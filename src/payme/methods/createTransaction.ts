import { CreateTransactionDto } from '../dto/create-transaction.dto';
import { PaymeError } from '../constants/payme-error';
import { TransactionState } from '../constants/transaction-state';
import { CancelingReasons } from '../payme.service';
import { CheckPerformTransactionDto } from '../dto/check-perform-transaction.dto';
import { TransactionMethods } from '../constants/transaction-methods';
import { ErrorStatusCodes } from '../constants/error-status-codes';
import { copyFileSync } from 'node:fs';
import { loadEnvFile } from 'node:process';
import * as console from "node:console";


export async function createTransaction(
  this: any,
  createTransactionDto: CreateTransactionDto,
) {
  const userId = Number(createTransactionDto.params?.account?.user_id);
  const amount = createTransactionDto.params.amount;
  if (!userId) {
    return {
      error: {
        code: ErrorStatusCodes.InvalidAuthorization,
        message: {
          uz: 'Noto‘g‘ri avtorizatsiya',
          en: 'Invalid authorization',
          ru: 'Неверная авторизация',
        },
      },
    };
  }

  const human = await this.prismaService.user.findUnique({
    where: { id: userId },
  });

  if(!human){
    return {
      error: {
        code: ErrorStatusCodes.TransactionNotAllowed,
        message: {
          uz: "Foydalanuvchi balansi yo'q",
          en: 'User balance does not exist',
          ru: 'Баланс пользователя не существует',
        },
      },
    };
  }

  const transId = await this.prismaService.pay_balance.findUnique({
    where: { transaction_id: createTransactionDto.params.id },
  });

  if (transId) {
    if (transId.status !== 'pending') {
      return {
        error: PaymeError.CantDoOperation,
        id: transId.transaction_id,
      };
    }
    return {
      result: {
        balance: transId.price,
        transaction: transId.transaction_id,
        state: TransactionState.Pending,
        create_time: new Date(transId.created_at).getTime(),
      },
    };
  }

  const checkTransaction: CheckPerformTransactionDto = {
    method: TransactionMethods.CheckPerformTransaction,
    params: {
      amount: amount,
      account: {
        user_id: userId.toString(),
      },
    },
  };

  const checkResult = await this.checkPerformTransaction(checkTransaction);

  if (checkResult.error) {
    return {
      error: checkResult.error,
      id: transId?.transaction_id
    };
  }

  const newTransaction = await this.prismaService.pay_balance.create({
    data: {
      user_id: userId,
      price: amount,
      transaction_id: createTransactionDto.params.id,
      state: 1,
      created_at: new Date(),
      updated_at: new Date(),
    },
  });

  return {
    result: {
      balance: newTransaction.price,
      transaction: newTransaction.transaction_id,
      state: TransactionState.Pending,
      create_time: new Date(newTransaction.created_at).getTime(),
    },
  };
}
