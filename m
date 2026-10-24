Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854697;
	b=FwTArVKhPGvTnz+WpGxd1kl1fN+KG51MPuMQt/xb9Q85UbxqbYVuFNfJF/PUiIVWAfgK
	 QRLhTNlTACGgw5aYMGfTz0xLORm19n7mNnvdp2Yls66e3NyGV0b98A2j0DrN249PJ9CGm
	 Z3XA3IWM+wcJac9rV3XwTbrvlNg3J4JAaHPgVJull/unEUSuXBZTbUuteBeiX6HbpG+Lc
	 0u7r7BVjpKsfOSedL/Nz6iWKsGVFkZRZ1L1NO3jFMQ5S/FUYIfbGYdKAQMElxUT100IRH
	 Kcjd2oK5S2FKgUzs4zt3MUxbUrplRQXq7TYfxBWusC3H31YvFliAhM+1qICSX2IsjZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854697;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=r0+xqvEJHHv0xISiBuxAQ7qqtqJuG5B1JBhGzRsD4ns=;
	b=seT85OWjG6WWRXnb4sFFqe/cgNsO3XGz4vSewmGXy95Wd1HPM5AYLnhZGxQiJLr9LqS6
	 khSAcwBhOtqnWtFnKaR4NFpmPtL3BYR5YGXVdCLbwjjNCeDokDUzdDZVJZf2GIdLGfRG3
	 r1qJOFBL2EC1v3VjjWP5aqQ9QmxNgasPMRoirHOP9TsADm81GphHjoV6MopNGaR8/559t
	 8HWB3T46fXBGNvzllGJwLBC/mEiK2lFtZBSIjeTm+gX98DU4BUonEwmazbX6Y6lJjjWz6
	 jTqs1qlvVFgmiSk+3B9UKrGn0mzmp7iBSemj4D+B57ETL6wiVOQ7c4AbXAFZyDaGkcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VUjkZ83u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.44
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491E606A31A;
	Sat, 24 Oct 2026 15:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B491E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VUjkZ83u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3ROLbmeUh1tn80uZxgg+dxzC/eAQ4knmu3gMkQg5e2Lwxszzo+kvoyEbUYBe0hNmyvkMF8kaWEJmbxR3ep5568/QKu+KGaEW5q7p94u+GU97VWAqTcD90jOpD8PkI++a5zr7hAHJ6M82eT6tn1Gk7sAW/MnoDaIzOVwxDYtMivbCBGJfn5dUTKWya4XiXJWRGmTroeDOP37TtYij/4w2ZqDoGGPbuVyjYufoeBxB7h7qYo2l2IXGIxDKYb0LEKXMJyLC2eTxF5bFgEmvd17YqzDGX6ucQENlYjqf2rAxPYi/M50GR6hvsmQFxwbF94FD3jLWQiriD/6JtlQfyr5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0+xqvEJHHv0xISiBuxAQ7qqtqJuG5B1JBhGzRsD4ns=;
 b=g0IylL0DCCxTh9GyO7XDJy9fneqTiLPapuMnX4hT7JklDU99GwqJQ1/NOkEJx79sDaXPrCWosc+1WoSVb8ethQubiX3XJCwKMcMGxRruVy7RVKRwYCq+TUGafapWBWCzIro6F1FOOfB3u0IlhpR+Nq3jN5oXC1UjHa1/2QpkdUPUAMp73NxLJMR94JQJ+Tw+b13OEV7Z9H8BTTi82tNPNGogHYezy34cfzg5p99u70Zl6Kf/jrlAsBBQ4Sa2FZsHqWNHAkBaPQUMNyqBWQjbnOnnBL3lHTrHlzD6NSkWQ0TMfhlYQvQyowTAMaM0wQXuo+4lCUPUTwE7XxyzG2pqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0+xqvEJHHv0xISiBuxAQ7qqtqJuG5B1JBhGzRsD4ns=;
 b=VUjkZ83u/dWGXSEp0OLlU/kdRqYIixwpvLdbNXXp9zMlMf2uC4vYCZesQGQ+dr3rSWEw9t5TAf/WnCf/OuN86+r3qIoIMGMQYMks9ENl1l4qHiu/vmkr1znBnQTEikM8iAd/jQmDQOTHl03AaPuh3frB1IhsFcKC6u+tVd9Juyk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.16; Sat, 24 Oct 2026 15:09:33 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0546.019; Sat, 24 Oct 2026
 15:09:33 +0000
Date: Sat, 24 Oct 2026 11:09:24 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Weilin Tong <tongweilin@linux.alibaba.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: Re: [PATCH] EDAC/amd64: Fix double free of private data on
 registration failure
Message-ID: <20261024150924.GA1164@yaz-khff2.amd.com>
References: <20261021062925.1838750-1-tongweilin@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021062925.1838750-1-tongweilin@linux.alibaba.com>
X-ClientProxiedBy: BN9PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:408:f9::31) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: f307e674-4ff5-4e82-ef6d-08df31e0cf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	k5/zs7qaoJliVDEkZru8o8DDVjsga+0z9gaBQxQ337YVMrz1rb6RBeweKXDLD2IDcmu7BmSEGSxLjPiH4SbaISUaoMFhizpRj0LLUAY8CWTzhFe/y93mgGHaQAHYErfm9+e/MzEXT7xFDmYrP/42mNDnB0BIR0Se8ZgLVX3jhNpHD53KkqESet/fxcvNiTTB3QjkrmvjNkmRWukbMCk9PUJKNFkLh05cQnFcehel3T1LT5Inl114dlyLMYV+E9Zw1zUQEZUrtMngHJOXg/ve29IHiYVbesinjPWOpHsRWlsgOXHP07vlBXuaiOA+gaEqMoXO3r3eznbedRkI0UlzLOKKpFT3DmOVkjf1Y8a9UOIOcKAOV39r7j2BBATBybtDrIgr7+ANZufIKakMhgrOeWfLf+/RgR31iYVT/14m/bgvTl6DbApNH0g2V9gzKZs47eRq8rkhrUAQBcG+r2UV9l0jr5imGQtmsa9bzlGNqbnjoXOv9DTqquayyrnlBeSTf8+fiVWPuQwNTgoUiD3kKLMpwGZqaZebcKhMpcL9jrJxR3M0JA8IhIIdfoZlKJTecwS57Ab6MzVpQ28KKdYuN8RiHQSQrhBgXqU8qUsk6gC7W9XOcRvqVp8SIDqMBfqOEceaM5SSt2E3cKylJkl3Intg4HSsq158sch2eA8/bio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HwsHoD9aNAl3y35wSTv7M7yAyuvw2qZwPtvKFiBjqUtPOLzIxcZk6fgPkw+8?=
 =?us-ascii?Q?2oA4nbHK60o/X021V8328cg6JLC8KU8rMGHa+JfZCVxi0YX+wCB0OSzLI4hA?=
 =?us-ascii?Q?y7hTRYH12/dVAASgHB0xIxHFxJvlpZ4L8Ka0OPIpKDbDGdmY8ObXQUbTBWEl?=
 =?us-ascii?Q?Bmi7DHUBQ7GmBoA5yvgsKCeHjq+cViS8tbaJdpGl/JJ5cRlLuJnmBaxx4Wr6?=
 =?us-ascii?Q?VmLcXupWK0RRD7FI6OiqCs55qhoxIMiNrG0E9uddr3Thg8InU1pb5/9F3ytu?=
 =?us-ascii?Q?k8sx8CEoKlylgOma9ITaRMn5MXpUOJcDAcQDmMtcbE5divn5E8fSAeQvVLBZ?=
 =?us-ascii?Q?s78hPUOG9sOnMlzaWA3cOhtztVTMAKBsu7wTJD+quFRKU4G3bapWyrc1Wg0I?=
 =?us-ascii?Q?cwA0oDsmbtgwXXYXHJg0fEilsXGaaHQrd/5R3MwA9mcJ+gkrL2KIyGO1RMEM?=
 =?us-ascii?Q?FkOYtdfmrqjLfOzppgvydVYcPAU2BUb/KFQAJ8aEApun4Pe6Olxn1jGTal1z?=
 =?us-ascii?Q?hUjlLCQm8v+wIQXccvffNuHITn3C/HORHbURMT1aF9yjsLCV84tyL5tjKlkr?=
 =?us-ascii?Q?4RLQZKFzYVtsmzktNT3KNYtWgkHEPUhJLWEHiwMQCCRXadUqcy490kHbUDek?=
 =?us-ascii?Q?hRrxXiNie/9Vx0V5zY/oOmm3CmO2su6R8E3SVTOGlYezABwXIKLAtoEq89Cq?=
 =?us-ascii?Q?whzEjaCxSBPg1Db3JdsSSsA1adZHggA2MtnPB5exF1j/naZP2w0ITGsOxchf?=
 =?us-ascii?Q?oc/urEID/NllfZS5mFgb4qMCyxeNSgl6R0BPDeAYaIGZ4Pvw719SfqcndiiR?=
 =?us-ascii?Q?+YnDFlqtSq60BomNICCtl2GVS/Kf2sU3g1I/CxmT1Sp+Mny0bns2I5X7BOV0?=
 =?us-ascii?Q?hdoDkPcEcUp9IFyzScLhtxZpeiPeYcLNoGT8pr4OyIhhVA7rgY53L3vaqgqJ?=
 =?us-ascii?Q?KqrxP2E80pNWFZ5sU+5htzuWGqIoxr2fTUuK2rsnYD6RyxAQu0NhvhvMYdQk?=
 =?us-ascii?Q?vG1G9c6jSHzEHoK2zFAoxOuc7I6S/HG38UibwfX5JPDy1UiMQL/3lZLRowqz?=
 =?us-ascii?Q?LvNpzTWTY1yx88b9nqxPaVfhyVHND6YVA+WupMjlSg4u/umqmhwwB6tXjYIh?=
 =?us-ascii?Q?nj16jlbR7uL5hmtvFUkrxN/Z1jr5c8j+lYp9qe+BUuI3NaP7UvP0eo7hh9GM?=
 =?us-ascii?Q?KH61giy8ODytVgioNv0c9j0RMGLo86l+RH3NKmTFz2sevgQXd6yGomAHudO3?=
 =?us-ascii?Q?PiwJKqUI2AAamJu0fwk4dxhnNjGF/vHZmqUmLHCJxVt6brf2IXbF+P/zkBmg?=
 =?us-ascii?Q?TGZp0eY62l5lPVq3+/4EfmhYOF9fX6bHFMlbvImN+5T/PBzRXt9UKzBvhk6g?=
 =?us-ascii?Q?OZU9DbziOdJAY0Dg9DZ659HfTyJMh4Iz200CZkIp7/7VNmxfZDk8lZbzCHm6?=
 =?us-ascii?Q?f5NEiWbXZ/2GvuKqnCzzmQAdgv5gWb6KBti0L8jcw64XMfMK52y6LXFWxVVa?=
 =?us-ascii?Q?q1Z7V7N/sHZU0mfcR0uFWnqMAsJYInf7Kpck8aQr+lNz8fsYv0DjURaXemHn?=
 =?us-ascii?Q?sG9MGWWnFkaSPv4lZ+Bj8FvUmzMUZe+0KLnWhfaKIKOn3rR+QOULy0eOs/ZJ?=
 =?us-ascii?Q?8RbivwWFyPV5Z8xai6R+cVOH6LYB8Wby/1jgu6Oz0ATPkzLlZOQJJ701tMap?=
 =?us-ascii?Q?fD/5Q1R6RHcnwCVaI6QVndSCrttC2tplaxtfL+HR/Wdibktw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f307e674-4ff5-4e82-ef6d-08df31e0cf4f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 15:09:33.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UA8SHtvK88Wc5CmJRdrLMLZmqMXljl5FfvXFUh444ZEbKAM9zDzG8Cb4OISMapZar1dXf2hEqgguS8IcEgoJrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112

On Wed, Oct 21, 2026 at 02:29:20PM +0800, Weilin Tong wrote:
> If edac_mc_add_mc_with_groups() fails, init_one_instance() calls
> edac_mc_free(), which frees mci->pvt_info. probe_one_instance() then
> accesses and frees the same private data, causing a use-after-free
> and a double free.
> 
> Clear mci->pvt_info before calling edac_mc_free() to leave the cleanup
> to probe_one_instance(). The normal remove path already clears it.
> 
> Fixes: 0bbb265f7089 ("EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()")
> Cc: stable@vger.kernel.org
> Reported-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
> Signed-off-by: Weilin Tong <tongweilin@linux.alibaba.com>
> ---
>  drivers/edac/amd64_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 0c0d11c72925..edced7cbe83f 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3975,6 +3975,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	ret = -ENODEV;
>  	if (edac_mc_add_mc_with_groups(mci, amd64_edac_attr_groups)) {
>  		edac_dbg(1, "failed edac_mc_add_mc()\n");
> +		mci->pvt_info = NULL;
>  		edac_mc_free(mci);
>  		return ret;
>  	}
> 
> base-commit: 2c455ddca7827ad8fa3a64fdbf5a60efb928b46a
> -- 

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
