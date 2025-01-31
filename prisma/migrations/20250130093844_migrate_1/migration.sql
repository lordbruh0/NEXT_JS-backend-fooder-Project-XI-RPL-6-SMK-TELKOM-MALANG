/*
  Warnings:

  - The primary key for the `menu` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idMenu` on the `menu` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `menu` table. All the data in the column will be lost.
  - The primary key for the `order` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idOrder` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `idUser` on the `order` table. All the data in the column will be lost.
  - The primary key for the `orderlist` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idMenu` on the `orderlist` table. All the data in the column will be lost.
  - You are about to drop the column `idOrder` on the `orderlist` table. All the data in the column will be lost.
  - You are about to drop the column `idOrderList` on the `orderlist` table. All the data in the column will be lost.
  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idUser` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `profilePicture` on the `user` table. All the data in the column will be lost.
  - Added the required column `id` to the `Menu` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `OrderList` table without a default value. This is not possible if the table is not empty.
  - Made the column `note` on table `orderlist` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `id` to the `User` table without a default value. This is not possible if the table is not empty.
  - Made the column `name` on table `user` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `order` DROP FOREIGN KEY `order_idUser_fkey`;

-- DropForeignKey
ALTER TABLE `orderlist` DROP FOREIGN KEY `orderList_idMenu_fkey`;

-- DropForeignKey
ALTER TABLE `orderlist` DROP FOREIGN KEY `orderList_idOrder_fkey`;

-- DropIndex
DROP INDEX `order_idUser_fkey` ON `order`;

-- DropIndex
DROP INDEX `orderList_idMenu_fkey` ON `orderlist`;

-- DropIndex
DROP INDEX `orderList_idOrder_fkey` ON `orderlist`;

-- AlterTable
ALTER TABLE `menu` DROP PRIMARY KEY,
    DROP COLUMN `idMenu`,
    DROP COLUMN `image`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `picture` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `name` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `description` TEXT NULL,
    MODIFY `price` INTEGER NOT NULL DEFAULT 0,
    MODIFY `category` ENUM('FOOD', 'DRINK', 'SNACK') NOT NULL DEFAULT 'FOOD',
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `order` DROP PRIMARY KEY,
    DROP COLUMN `idOrder`,
    DROP COLUMN `idUser`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `userId` INTEGER NULL,
    MODIFY `customer` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `total_price` INTEGER NOT NULL DEFAULT 0,
    MODIFY `table_number` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `payment_method` ENUM('CASH', 'QRIS') NOT NULL DEFAULT 'CASH',
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `orderlist` DROP PRIMARY KEY,
    DROP COLUMN `idMenu`,
    DROP COLUMN `idOrder`,
    DROP COLUMN `idOrderList`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `menuId` INTEGER NULL,
    ADD COLUMN `orderId` INTEGER NULL,
    MODIFY `quantity` INTEGER NOT NULL DEFAULT 0,
    MODIFY `note` TEXT NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `idUser`,
    DROP COLUMN `profilePicture`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `profile_picture` VARCHAR(191) NULL,
    MODIFY `password` VARCHAR(191) NULL,
    MODIFY `name` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_menuId_fkey` FOREIGN KEY (`menuId`) REFERENCES `Menu`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `Order`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- RenameIndex
ALTER TABLE `menu` RENAME INDEX `menu_uuid_key` TO `Menu_uuid_key`;

-- RenameIndex
ALTER TABLE `order` RENAME INDEX `order_uuid_key` TO `Order_uuid_key`;

-- RenameIndex
ALTER TABLE `orderlist` RENAME INDEX `orderList_uuid_key` TO `OrderList_uuid_key`;

-- RenameIndex
ALTER TABLE `user` RENAME INDEX `user_email_key` TO `User_email_key`;

-- RenameIndex
ALTER TABLE `user` RENAME INDEX `user_uuid_key` TO `User_uuid_key`;
