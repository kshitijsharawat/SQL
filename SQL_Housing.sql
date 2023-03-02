/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [PortfolioProject].[dbo].[NashvilleHousing]



  Select *
  From PortfolioProject.dbo.NashvilleHousing                    

 Select SaleDate
  From PortfolioProject.dbo.NashvilleHousing

  Update NashvilleHousing
  SET SaleDate=CONVERT(Date,SaleDate)

  ALTER TABLE NashvilleHousing
  ADD SaleDateConverted Date;

  Update NashvilleHousing
  SET SaleDateConverted=CONVERT(Date,SaleDate)




  
  Select *
  From PortfolioProject.dbo.NashvilleHousing
  --Where PropertyAddress is null
order by ParcelID



Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
  From PortfolioProject.dbo.NashvilleHousing a
Join PortfolioProject.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null



update a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
 From PortfolioProject.dbo.NashvilleHousing a
Join PortfolioProject.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null







  Select PropertyAddress
  From PortfolioProject.dbo.NashvilleHousing
  --Where PropertyAddress is null
--order by ParcelID


SELECT
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address
From PortfolioProject.dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
  ADD PropertySplitAddress nvarchar(255);

  Update NashvilleHousing
  SET PropertySplitAddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)


ALTER TABLE NashvilleHousing
  ADD PropertySplitCity nvarchar(255);

  Update NashvilleHousing
  SET PropertySplitCity=SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))


  Select *
  From PortfolioProject.dbo.NashvilleHousing




Select OwnerAddress
From PortfolioProject.dbo.NashvilleHousing


Select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From PortfolioProject.dbo.NashvilleHousing


 ALTER TABLE NashvilleHousing
  ADD OwnerSplitAddress nvarchar(255);

  Update NashvilleHousing
  SET OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3)



 ALTER TABLE NashvilleHousing
  ADD OwnerSplitCity nvarchar(255);

  Update NashvilleHousing
  SET OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress,',','.'),2)


   ALTER TABLE NashvilleHousing
  ADD OwnerSplitState nvarchar(255);

  Update NashvilleHousing
  SET OwnerSplitState=PARSENAME(REPLACE(OwnerAddress,',','.'),1)



Select *
From PortfolioProject.dbo.NashvilleHousing





Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2



Select SoldAsVacant ,
CASE When SoldAsVacant='Y' Then 'Yes'
	 When SoldAsVacant='N' Then 'No'
	 ELSE SoldAsVacant
	 END
From PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant='Y' Then 'Yes'
	 When SoldAsVacant='N' Then 'No'
	 ELSE SoldAsVacant
	 END




WITH RowNumCTE AS(
Select *,
ROW_NUMBER() OVER (Partition by ParcelID, PropertyAddress, 
SalePrice, SaleDate, LegalReference
ORDER BY UniqueID) row_num

from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
Delete 
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress






Select *
From PortfolioProject.dbo.NashvilleHousing

Alter Table PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


Alter Table PortfolioProject.dbo.NashvilleHousing
DROP COLUMN SaleDate