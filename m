Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B7440A21;
	Mon, 10 Aug 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391992; cv=fail; b=b0MNw9jnU4B9J/gJ1iUtXMyj3EGRcw5YDLiWHGJTCm+x/0KSM0XfEpm+daTt6i1PC/bmTo5sqEdniM/uATPmLZ/vKZuZMgZXr3FHS6RB2VMo+hyx6ISV64a3jbxTSsxB35GqzMr8eJjZcUqGDz1efRx5TUmHl9p7zCwAesL6xmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391992; c=relaxed/simple;
	bh=wMK9UggJD66Qj/RCg2YnIDFdZZA8DL4gzS7MN86iUNo=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=mOOzkCxa+4NLsOg7Gh4HehVtXXFQU/yDowBICqY/2tIfgXNk25F5L6YPw0aLoXWfVOIbVTc38Fzj+rSGjDII8Je/+EPo3B16x4NQ+2tGeXaeSAxQyMMcvCJ6Cps1/BRSXndf5Fc1ap+K0EffeRFK0PjXdjJ+PZI3/9niZXHZvhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X7vagReK; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7vagReK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAxzECmrbl5a0IKVhoTbsb9SBKCMHqjOBcA5wjpsGDcfqQCmBWoViuSsmRD2g8dgQpk9gFmVhFV8BxCPUS1kJMXAInefU0rMFZG39IVuqt1hmjPtEFo/m/Yoo43ovJKAEDqGj/mx9v75bRTIO1Eg8VDElGmORqKGe0V5fkKDuEmLlI5vi5wD9aVz6wh54PPa7xXho8jwjaI2r38NQwhuDcNoeeCEdKAemw7zfN9AC3+FJvS4i7dpZHg04/r4yOME9s2f5Pu0i3jPSvpTjtbHatbAnorBvza1odM98ywkne8n780W32QY38CrAadVcE1BZhqCYHxznWGLVPjD3YXjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAPobipaIEaVSBw6TVdzGGzKEEB28oKPw52hBnUmrI4=;
 b=TqjyfSa90ziXpkVvysauTXJJBnHwnxdSFaLCHiq+OVu/ZWPPO58uB6uranAVIdqVeAdj7hIo4aOhikey2Zr/T94jQDj3IunsXH8T0uxDJPPyuBps8Dv9jpfksBW21Hx6iPatBcxyCurYaxPhuP8Pe2oHDhcMPZ/13YbKpVAl19IW/Gfz5Rc6YsANmIXOnN9TIJbCQFKYVWnS1jaVXax/kBs1RJmkgetTvsDAeJx9R/soE64E0fpK1XY3OLEI1pgO/h/0sw5C2b4Qoz08pYQ00qxNG/JgabOwjMtb0FP6C0QUPGFLUMe6mQFQSlNHR8wHHwWWZuNb9OhlE9g1j/ZQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAPobipaIEaVSBw6TVdzGGzKEEB28oKPw52hBnUmrI4=;
 b=X7vagReK+YmeuVVHwyEAR6HX5HhdefJJyitQyeKWUTJCChHcxaXhn0vmeimSrqdfEox3VWbvafg1l3xDBVT2weErPzpDjGy2ovS1G4/Lg48P4C+bEuTtT7FpgymWyvR4jIIrKl7yTKAPDMC8theUT2P3J+IBwqji8rzK+AJTd3djXXZIV0jnwjQEJfSLb5V7dzYAakHQAqsbACnBUMdZpTry870yC/geLMI/u32THaJqeBQNnK4ympMU7e/iSZlFJ7C/pP8gzaUK8woLwjIUTvJslJL+oO4AH1E9BwO6VocLTRXW/8eAD7fWrdOxiaV6N95vSiIqDN6aifv2louJyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:59:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:59:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iommu/iommufd: Fix NULL pointer deref in
 iommufd_ioas_change_process when racing with iopt_map_file_pages
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, jgg@ziepe.ca, joro@8bytes.org, will@kernel.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
 steven.sistare@oracle.com, stable@vger.kernel.org
In-Reply-To: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
References: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
Date: Mon, 10 Aug 2026 16:59:43 -0300
Message-Id: <178639198310.282103.12552740515074532170.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c5eac1-e2d8-4439-d9d8-08def719edc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AU2jD+yZ0JTXjyNm9wd2sGAgqTGPjYfi8sBzqUJhWkTiIzU+YWaUylSYsTODGiyY3DOjC2RSbxk60Y/CjWnC4WujjJW+zY6Mn8kA8a2h5E2B8L1Hs2QM9SRGu2zX1C41DHB8eh7KBOozhGsJwplAQVF2FYQ/3B1K9xkNFmT1m+3rHZa1o458xkHUr5myRXvqA2gCWJ7nAs4cJXe/PgnvRk6k+LR8eIb5ByWWYGf1PqXkMv5u1I34XRFZ6QgcxWfU8S4dSaB3pOgb06xadNuPIKuT/d1LJh9wPQBwlxz0v4Ph8VX1G1w7GHZ+L/wIX2x9ACqQgG780x8gq8KICNLmXkUtWD0l23/Fdqq5e+ID5r5WDA/GXNpwg+GeElsEJ6NkB/8IyRxC0e+t1lRpJ83EKOn3eX8T/jDiHzzPlbVsqG1PWhrY+i6gw27cVe6r5WdfUyvNpbcI0OvTwGBbpvwHI3Y9Z5Ke9IAN5lZDw0UklP9XvKpjs+9VJ8RWCmlLD90rSoti6q1uaKgv0AZoxX08Dq2wHsaajMz0FeoXMQKaLMzxi9J6F76g9WbEaMkBN74SxlsWj7hxqzuRo48A0WuA0k/Q5A4H7jfeITOKQiVkvnJKKpPanrKfyslr7TAA32m9nKEuaGNfouxU6HSb/92k0es1GciTonsnCG1AfR4oLcA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2FDdWRSRzdrZGlaM0xKYXR3UWV4ZzhxMzNQdFRQRXZxRjZ5azFTZGtJUVVL?=
 =?utf-8?B?WnRiOGdiWENyalVOYkZUc1dQMEJKbk90cDk1Qi9IQWRwTXFrRmJkTXAvRTNI?=
 =?utf-8?B?SmZmZHluR1hiL01tcktEMzhlNnY1Q25md0lTeXFVUDBFY1c5WVN2SFNKZ2Nx?=
 =?utf-8?B?RFlyckRGYTRoay9jVUxsV0x6dDNJWHFLZFUzWEhKUXB2c0NsSzI2M1pHZjhr?=
 =?utf-8?B?TXRoemVuZVQ2KzBmNlVWZEgrWjRxWThuUHV0SjRSRnRzeUtYTDYvaHd2MjJB?=
 =?utf-8?B?NGh0SGxTQ0hrajlWNFd5QWZveCtLTWU4WUhtSXEzVVF4UVdQaHgxTDllWWY5?=
 =?utf-8?B?RU1MVjU5aXNIMzh0SlFBekc4c0gwR0JSUmFIZHBNM3BMMnc0V3NOY0thSWln?=
 =?utf-8?B?aVlPdFlZN285K1JUSyt2ckRCSHlYV2tpN3ZlUlh4WnpPdzZQa0tLYjhZWGxt?=
 =?utf-8?B?VTBXQUpDczRoT2ZvVEVzU3lIWU9kK3BwdjY2cHYzbmwrTFhJZjY1N1V6c0to?=
 =?utf-8?B?bnN2cWFDREV5bG80UnZMbEFWM1UvTlNaNGpaekhIeXkyTE5NYnc3OHRYcHJG?=
 =?utf-8?B?NStpOVNGRVZwRmdHcU5ONjZrSHNqai9INUFJWFUyVUg2Q1BHQktZWWRqZ3JF?=
 =?utf-8?B?bEpLaXBlYSsyWmJuMjNvZ3JqdkJleHQxOXFWTmp0QnR6eTF2SEVyRkt0dW9w?=
 =?utf-8?B?SUxNS3NXdWc4NHlRZ2dyNjRycHhWbHVMSkRFeUQxRVNrbStTQWVWU1IxcmND?=
 =?utf-8?B?L1k3UlIvOUo5QXYrMXpoYXQ2OVV6alhXbHppYUVHUjdzN0U4RVkvT2M4b3hW?=
 =?utf-8?B?ZE5LekNJMDk0eTd3bFBUd2Zkc043eDhBVWEzdXpKTzFVVnBzeDh1L2hTVldz?=
 =?utf-8?B?RSt4NDNJWFQySWJhRWNRR3lKSVpoQVdLdnBUMEVvQ2M5MCtEMTN0OG1xMEln?=
 =?utf-8?B?cFZWa2VRYnI1ck1Ic1hDY1dNZ3Uyc2ZUMFIrUTRGUEdNRk1ZODh3NTB4eEFX?=
 =?utf-8?B?ODhaK0ZUNW5XaFR1bkNiN3RMa0VmUm1WRExnZERlZ3BFRWhlU1RpaS9oUGtU?=
 =?utf-8?B?L3RrNnhoUlNoOStjYk9kcEx6Ty80VkxOTHB4c1RkR2kxNHZYY2NBd20wTkdx?=
 =?utf-8?B?Y01WZDRDc0drcEtvNDVhNkFFU20yNGxlcTNWZ0hNVWJRWHk0cGlIbjVnZ1Va?=
 =?utf-8?B?MzRobitnMFVmbUpVOWFyYXlsa1ZuYVVjQXI5VmcvSkJKSklHWUdKd0V6c04v?=
 =?utf-8?B?YndmNjVqbzBDbEx2RGVGNlZlYVR5eEJwaUxUL3pFc2tWbE9XaGkzVnVpRUpX?=
 =?utf-8?B?YVZhVm1aa1dpTmRtcnphUmpCR2ZIUlZaVkpSTjJtRnRvU3hrdjJEbSt4MFVx?=
 =?utf-8?B?TzFlMlBua3d0d0gwYjZ4ZmFLbFROZVdEODkya2pLdmhpck40Ukl2cUY5OTht?=
 =?utf-8?B?K2ljeFNlWklSWEowRkxrOFlkZmU4cm1QbS9NU1JmcHNDTUM3QVI5ZDY4bU8y?=
 =?utf-8?B?Qkd4cW1DYXYyOWoxaVNmcFc5SkdtU25IekF5cndyYUppNExNQlFIblNHMGRx?=
 =?utf-8?B?cEhYeVRxRld3ZWNna0pFd0w5dWZnaXJwbzhoNUdvVzhEL1BuYzljcWRsSnI0?=
 =?utf-8?B?TGU4QjFrQXBwVHVReVBySmtHTFV2VEl0YWs5dEJsUFRBd1E3NDZpUjRWbG5h?=
 =?utf-8?B?SjVKRzVZUDJ5Rk9BbFR2bUhYZzhjQUxwUncwMU9ITnM1TUNyOTNZSjVFajlH?=
 =?utf-8?B?QlhPM3QxQXlKOTRsMDllMVlCWStmdFcram12ZXFTZWp0dVFtODBaMU0yWXlk?=
 =?utf-8?B?ZFVTWWdXZnVvVStXS1U0WjhXeTdlMVI0VkRaSUM2RHdyTlIySDZoY3R4WTJ4?=
 =?utf-8?B?aDhiZTUyRzRaS3VPTUs2MjYwbTVZREJ3U0JldHlERm9ETjZGSTFmZEgybDI0?=
 =?utf-8?B?OHdWVlVOYmw1K3BKKytRbWNQdGtWZGhhYk1IRjNPZHI4aHlmQkJCWUhzOEV6?=
 =?utf-8?B?eExBSW5sRENhQ2pFeWU3Z2Y1azh5OHZqenJyNnFjaFZ5V2tRb0hJTDFBRFdN?=
 =?utf-8?B?aWhGTDhXd0VUSHp3bVFTOUFvcDh1UnNncHdkQW9KK0xNTUpuSVRuY1R2VlN0?=
 =?utf-8?B?OE03RklYZ1dNb2JKUkd1NzNuLzNpRlY0cUdRMmNLVjZDWFlaZ010Z2ZQUStM?=
 =?utf-8?B?b0MwTGdUWEExbjJkdmJhU0psbncvaFppT0JtVkgwSG9Bb2FiOGRSaUxPYUNm?=
 =?utf-8?B?M3F6c0tsOHIvZndhb0xoLzZGRW1KQnV5L2VrblQ5QXBWNFNxT1VOTzFvWks2?=
 =?utf-8?B?V3VXUUM4VVJlRXc3bHJkNWI5ZXZ4a2diUFRPMkU3bG1rSWhBdjB1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5eac1-e2d8-4439-d9d8-08def719edc3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:59:47.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHIkZnum1SxbJTScb+51N7buqFRGsTMjH/TRN2/7ilQkagrDMjE/jfkhttsOUqm0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

> @@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
>  		return rc;
>  
>  	for_each_ioas_area(&ioas_list, index, ioas, area)  {
> +		if (!area->pages) {
> +			rc = -EBUSY;
> +			goto out;
> +		}
>  		if (area->pages->type != IOPT_ADDRESS_FILE) {
>  			rc = -EINVAL;
>  			goto out;

If we do this then a concurrent map will get corrupted accounting. I think we
have to prevent map from progressing too. I belive the issue is we don't take
enough locks.

Does this fix it?

--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -383,6 +383,7 @@ static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
 
        xa_for_each(ioas_list, index, ioas) {
                up_write(&ioas->iopt.iova_rwsem);
+               up_write(&ioas->iopt.devices);
                refcount_dec(&ioas->obj.users);
        }
        up_write(&ictx->ioas_creation_lock);
@@ -422,6 +423,8 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
                xa_unlock(&ictx->objects);
 
                ioas = container_of(obj, struct iommufd_ioas, obj);
+               down_write_nest_lock(&ioas->iopt.devices_rwsem,
+                                    &ictx->ioas_creation_lock);
                down_write_nest_lock(&ioas->iopt.iova_rwsem,
                                     &ictx->ioas_creation_lock);

-- 
Jason
