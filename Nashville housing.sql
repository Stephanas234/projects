
--SELECT  *
-- FROM [master].[dbo].[NashvilleHousing]

  --SELECT saledateconverted
  --FROM ..NashvilleHousing

  --UPDATE ..NashvilleHousing
  --SET SaleDate = CONVERT(date, SaleDate)

  --ALTER TABLE NashvilleHousing
  --ADD saledateconverted date;

  --UPDATE ..NashvilleHousing
  --SET saledateconverted = CONVERT(date, SaleDate)

  --POPULATE PROPERTY ADDRESS DATA
 
 SELECT *
  FROM ..NashvilleHousing
  --WHERE PropertyAddress is null
  ORDER BY ParcelID

  SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyaddress, b.PropertyAddress)
  FROM NashvilleHOUSING a
  JOIN ..NashvilleHousing b
  on a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
  WHERE a.PropertyAddress is null

  UPDATE a
  SET propertyaddress = ISNULL(a.propertyaddress, b.PropertyAddress) 
  FROM NashvilleHOUSING a
  JOIN ..NashvilleHousing b
  on a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
  WHERE a.PropertyAddress is null

  --BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (address, city, state)

SELECT propertyaddress
FROM ..NashvilleHousing

SELECT propertyaddress, SUBSTRING(propertyaddress,1,charindex(',',propertyaddress) -1) as address, SUBSTRING(propertyaddress,charindex(',',propertyaddress) +1, LEN(propertyaddress)) as CITY
FROM ..NashvilleHousing


 ALTER TABLE NashvilleHousing
  ADD property_address nvarchar(255);

 UPDATE ..NashvilleHousing
 SET property_address = SUBSTRING(propertyaddress,1,charindex(',',propertyaddress) -1)

 
  ALTER TABLE NashvilleHousing
  ADD Property_city nvarchar(255);

  UPDATE ..NashvilleHousing
  SET property_city = SUBSTRING(propertyaddress,charindex(',',propertyaddress) +1, LEN(propertyaddress))

  --USING PARSENAME

  SELECT OwnerAddress
  FROM ..NashvilleHousing

  SELECT PARSENAME(REPLACE(OWNERADDRESS,',','.'),3),PARSENAME(REPLACE(OWNERADDRESS,',','.'),2), PARSENAME(REPLACE(OWNERADDRESS,',','.'),1)
  FROM ..NashvilleHousing

  ALTER TABLE NashvilleHousing
  ADD Owner_address nvarchar(255);

 UPDATE ..NashvilleHousing
 SET Owner_address = PARSENAME(REPLACE(OWNERADDRESS,',','.'),3)

 
  ALTER TABLE NashvilleHousing
  ADD Owner_city nvarchar(255);

  UPDATE ..NashvilleHousing
  SET Owner_city = PARSENAME(REPLACE(OWNERADDRESS,',','.'),2)

  ALTER TABLE NashvilleHousing
  ADD Owner_state nvarchar(255);

 UPDATE ..NashvilleHousing
 SET owner_state = PARSENAME(REPLACE(OWNERADDRESS,',','.'),1)

 SELECT *
 FROM ..NashvilleHousing

 --CHANGING Y and N to Yes and No in "sold as Vacant"

 SELECT DISTINCT(soldasvacant), COUNT(SOLDASVACANT)
 FROM ..NashvilleHousing
 GROUP BY SoldAsVacant
 ORDER BY 2

SELECT soldasvacant,
CASE WHEN soldasvacant = 'y' then 'yes'
when soldasvacant = 'n' then 'no'
else SoldAsVacant end
from ..nashvillehousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN soldasvacant = 'y' then 'yes'
when soldasvacant = 'n' then 'no'
else SoldAsVacant end

--Removing Duplicates

   
DELETE SUB
FROM 
(SELECT *, ROW_NUMBER() OVER (PARTITION BY parcelID, saleprice, legalreference order by uniqueid) row_num
FROM ..NashvilleHousing) SUB	
WHERE row_num > 1




--delete unused columns

SELECT *
FROM ..NashvilleHousing

ALTER TABLE Nashvillehousing
drop column owneraddress, taxdistrict, propertyaddress

ALTER TABLE NASHVILLEHOUSING
DROP COLUMN SALEDATE


