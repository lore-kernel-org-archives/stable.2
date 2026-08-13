Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD554756CA
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627168; cv=fail; b=qKzt5NOOS2sFtJ8U/Gsd0lqVsh2ugfZz2wn8LJdKB3JiZXOCp662kUFFeNFslkhrp+M70d2+z4x+/zdMn6poB6KGpEEVDt+AYEMTK1t7Y1t6+MLkai0JKbydxf/x76Y34AjUz1pNTuoX21rXLRefWHY9AXLRkwxOrkz71EydF80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627168; c=relaxed/simple;
	bh=yiEr542YqCRg21gPcS1cxUuKyty0pBVtdCwjY3LbdQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfzBuxO2ceoWdUyP8yu2ANlyzIUvpOYWqwoTDy2R2tHIK0tdM9c68Sklu/d3lOxLtcrZrgJeD53XwdNhfTDx3mFR91ZwYJjL2YDYilQ8pGSuzrmoBoAYgHUFxdt6xryTGAH1DIEl9iwOqb2XK2reZsXawWqxvPBVPwShrb4CaMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BdGm+bgj; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BdGm+bgj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9Fq+MsFpTuNXPJtBdIcLMRaLXmOkBGmx7zbukgIpjJElrxLMXvHpUtYhwgYgHwv1uOt9sq4qngU7WF/G3H5fUgFVMy/lqfSAyAW2pRLRCr59T476tyY8h+Hx0/L7DeNPiO67jr5cQzM7KDvYarb3ZeFSScTF08t8Zy1ZICG0fVNnjC74EHTUf7aOovdB+eV2Kd8mkPgMYuR6sjKMPQhqS8+Avaql5B3vxpc0rG7lhkJHnnNEbOs8fsnTlS3exK85r7/L0yMCU5jdBlPDxDMpR4gb8yvbPzNl7asVJ4bBHyIQeDU3C6Q8Y5GDOKXtzDb1dE+uxzHYuJ1tDprPGRYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wfMnn1kCrC42RylUEz3ioHMWMHJgAxDTaYAbsrXqRg=;
 b=Cr6Kup2nXVSefIbn7DCVYdHLhPxmoGlzsoVnL4lz/0JQWChf72e7P8cVvVbYOncqfQCJbQ8mcRUGA6RELwjIHfbcoCXa1yAwIWHpXqkzv7coPIKNI6veBqh2LOWdmaB2uh6++Zh9B28eyGC9eayL8HsHLNaE2IXTxIdYfvKBySIHm8FDVaOfUgviU9aSC9Lmxm76775nT6alQ4gh6sbkcolw3KVzPWSfpTzg8oq2l9ZPrGr6ntgR7DvBU4uPI4ZEm1NcK9rIrosEEpTkj3U/t7mJjATi/I7FG3fZ18ponuAeW0u9W8ESLHgGhQWwbrT+uTk7WPVrwdV1KvuUkN39gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wfMnn1kCrC42RylUEz3ioHMWMHJgAxDTaYAbsrXqRg=;
 b=BdGm+bgjdalHDlU/LKzFvOSYFvErBUhW8WmjiE1PuCJopBQtdkHaW07PxHlmuD4VDUd5dZrFHLM8j7wQQJ34jAdMqoOOfSH02lyARxZHIJcg7501rpwdN+0mMmD6EUpgBaPJ9DsxqS073BUTKsyuRdtnbgb9OuWB6Ljzmy9CYpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 13:19:17 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:19:17 +0000
Message-ID: <d5ad8146-dec8-465b-ab37-a7bb52542682@amd.com>
Date: Thu, 13 Aug 2026 15:19:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/15] iio: adc: xilinx-xadc: Correct Write edge in CFG
To: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>, git@amd.com
Cc: srinivas.goud@amd.com, sai.krishna.potthuri@amd.com,
 stable@vger.kernel.org, Conall O'Griofa <conall.ogriofa@amd.com>
References: <20260812173918.1156342-1-DileepKumar.Nagavarapu@amd.com>
 <20260812173918.1156342-2-DileepKumar.Nagavarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260812173918.1156342-2-DileepKumar.Nagavarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247a81a-f197-43b7-eb54-08def93d7a0d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7cBYsFX1WFvLwsR7jUqBAw/zrs7Cv4oRa7jAqIgy3L2Y8OYqQtYRnfruPR1ov0TLQt1EL7mnErQT4IWvtOpXRDhmL1vdhOCwyJfUg/TnzFVBnnrBrvvJVjzUcR6DnIGBkauB6RBV1MbBQKBRnJJlrlOipJQFUCbAMvTg/1RJAAknlcQl0LR7akFXdGiyUwjGGCm9VRkY4cUa2FRgvopl6rm0nZ44J5USLTPpdMvfawdTHMRCzH3j8761qiI5T/g4xy2CpDZORFmvp/yArAkytLX0TiLfyD5fp4i6JSUMipVr60X59UTzBz6Vec39ARFVpucCUIXA1V60pKD7IJ2owik/gPHqITi1AAMEieLB++M20vbivZ7z74quME3FzK1PbiaiACuUBkXGGZ6AAgAEudma9jfjP9fYsv+iwfaI9TGGLN4OpdTqi2SXbqxiI5saXSieFi9tYhRMo1Asqjd8c3VS83JZwZUBvga/GrS2OpXpYw/SstnMen3l2u6YwL9qH6zcFVBYkrF+d9lN7X7vAIrvdwS4FMzeu9S1ZGQkh4jFTx1lV1jRJ/0GCSBt5yGR61aqpRU8YceWii4D3j1Ev6f2Z3JnXMxbuZQTF+dsJY0zSHTN40LdNt4X/DBGsmI+fnPWbTwI/C4RAUrcSowq0LdZ9FNlKq6vgKzjBtQsvjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGF1VmNOZWxNUytWMEtWRVNHZGhMcXgwRVc1OVpseHhxMEJkazk0NU9zNHZt?=
 =?utf-8?B?bElUMDY1c29LS0VPdjB3YytvQlU4ajZxUFdmNi9peDdUa0tSeHNCNHJWZUpY?=
 =?utf-8?B?UGNzMWpUVTZEYStOUitwdHNrbFVMbHE4Y2k2cVNENEExdkxtMUNsSEd4bUx5?=
 =?utf-8?B?bjdyVzhsRG00VE1lR0NLbE5yN3FnU3JMTjVYcnNJSXRGaTNmM2tXbUttUkNn?=
 =?utf-8?B?TWwwQlJQb0ZOTWtnNHFYREQzSHluS1BuNnFWOFBjSEoxaUVhOGdDblNyOHRS?=
 =?utf-8?B?M3phbG5hcHpzdWtUcS81ODRyaERzblR6U1dZeXdYZzRQY3pkbDVGaDk3ME8x?=
 =?utf-8?B?MTlPOXlQV3pzbnR5OUdLakNpSmhuaHZpeE5mdmZiQ2Mzdm5KdFV5SjNGeUdq?=
 =?utf-8?B?ME9QSmZucENzZ1Jyb3Z0TWxCZFRibUZTVWh5ZVRNMlRTVlppZkx6UXNyRHNN?=
 =?utf-8?B?dkdZUVJ5aUlUaC92VTJmU2wxalB2WHZaV05jNnRjVm9kcnpha3VhNHMyTXZr?=
 =?utf-8?B?eHJyTGo3R1BBS0JYVEN1Vjg2NTRnR1I2SGpZYmF3UlVVMWpCZkJFYXBpZTdM?=
 =?utf-8?B?SDhMMlA0ckRNRnhPZzRSVVdlTGxGeUFLNmRvWWg2SUNmTXVFcjJmS2hxZHY4?=
 =?utf-8?B?Q1BTa3UvUHp2cU1TUFFFWVgvZFU4ZmVxTkJ1bHlSVjl1SHRCOEdsdDhETHdC?=
 =?utf-8?B?bDV5clowSXhEbDRsTjZ1bEFiMnR0Q1VXd3R2bk9sR2RycnpKeWdPejdaOWZ3?=
 =?utf-8?B?eC8weGpPZHVjd1VLbDVHUyt1RVg4ejFQQm10VGk3SXhndjE1THhjenRySWdm?=
 =?utf-8?B?WUJlT2JDaG5CU2M0MnEzdXhCVFZWUGlZaHhWTmdhakZnb1d2dVp0LzdEQjc3?=
 =?utf-8?B?KytnMTBrKytiQmFlckF6UUNuNkxoNE5scEhjaWpYQTJ1RHRCRDZvRHk2QkFn?=
 =?utf-8?B?TVZLYWFtL0xHUHkySGsvK3BTSWo1K2laVG5ZdWNHUXZqQk1QT0dMYVRSOS8y?=
 =?utf-8?B?WDViTnN3UTVXb1lrQkhUSk1UY3Npb3RpWVI2RHpNR0krRktneDViZTRnbXc1?=
 =?utf-8?B?RHZiZTJvTEtKVFlzNEkvbW1TV2FRRDhuUGZpZ3hFbi9ZN2JqMkVOdEpnOUxs?=
 =?utf-8?B?QXpSKy9xQ0MxOGN1bGsxYmxwWS9oalFsWUJFSm1NK1FKbzFWVHBLWVZzWkdP?=
 =?utf-8?B?VEVsMVhTR2c4ZEwyZTgrNDRwaDRQaGxkZG5ZY09hQytTWU8wWXBHYUtVTmJ2?=
 =?utf-8?B?N0pSRkgwVUNjY05RRkxWdm5aczJPTXd3NjBZbWxUZm1JR3ZuVlpzU0hZaDBZ?=
 =?utf-8?B?S3NQYktmS3ZWWFZFczljZzltazkvdjNmL0w4VC90QkxJUm9qcTlobkc1MzRV?=
 =?utf-8?B?bjhvNHAvbXRJR1RpVzdES0RZb29xQ0h5WHh5WXhtRVZhbzdyakU1RmIxRzBi?=
 =?utf-8?B?a1QzVzJ4WEZ0ci81Z2QxMFlaU1BBS21XYklwQ3VRNWNuN3N0enNuSEI5Nys3?=
 =?utf-8?B?bnM4VFUwem5zWmxPMXl5eEljZnQyVlJxYzVZS29pN0pVWlRUQWNzV0x2SUhw?=
 =?utf-8?B?bExJTFhxVUVVK3BYazY5WjZsbGVLakt2N3FNc1JjNkF4ckE2UnYva01vbXJq?=
 =?utf-8?B?SFRrNDJwK0RDYVMvU2F0d2x3eUVhUXRxVGNxRzlEL1VSZ2JFN3IrMnVBMVAw?=
 =?utf-8?B?eEtPWkZFdlVBSVVDS3lWMUJueDNFem5OaExxUkVXZjJkSkxxK0M4eWtEK2NG?=
 =?utf-8?B?S2paV0ZCZWttUGMwMlJ3Ly9Ddi81OTNwajZma2NKZkVaYVE0NXUydkZHQ2tH?=
 =?utf-8?B?UEloaUhyNFNWSXhUOEo1M0RramxVUDQreXQxRU9tck1iZmNhNGx5R2c5U1NP?=
 =?utf-8?B?YlNhcG1jdVJqTU0vMUpIblpweHpON1pOTVdBOUdhN05paDZPZGZLYWZGQm5L?=
 =?utf-8?B?QmN2OVRMLzArTHdsdU5PSFRXNkNlVEhTNkNLRUdmWXpqcDQvc08xcHlTdEVa?=
 =?utf-8?B?anMwVVo5dnArYkorcnZaa3N4SGJpTTByQkFBUDZGb25PKy9yTWlxelE5NkJz?=
 =?utf-8?B?REwwZjB3eWRpK3dhN0puY25JMEdHYVZGenlYSzEvQkRiSUFydW1qMGplMFdM?=
 =?utf-8?B?eEhBZkluclE5YlFCeTFJU2VjQ1RiV0hwVmhNcFQ2cmxHK3FuYzhjRXcrQzM2?=
 =?utf-8?B?QS9SblU2NlgxelAvdkhZVmlJUm54aXhzT3RNTmg4dXBFL01QQWQ1UTgrRGxj?=
 =?utf-8?B?eHZyaE5TMUYzN2ZuV0h4Q1UxVWFDUHdJVGhKZE0rSEtDWWdXeTVIOFFBZkJm?=
 =?utf-8?B?aEp2YThUZkVjdU5ONFpQZCtKRzE1cDB2UDZ4eGhLZlhJMS9MRm5JQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247a81a-f197-43b7-eb54-08def93d7a0d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:19:17.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRnpHL6h2xmnSdPg2/LNr3SfjN45Z0KVAE43lFdkQ23jQqmCIxVFyr/tZjnt2GbJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331



On 8/12/26 19:39, Dileep Kumar Nagavarapu wrote:
> UG585 states about the PS-XADC interface configuration steps,
> REDGE is 1 and WEDGE is 0, this is consistent with the XADCIF_CFG
> register default value.
> 
> Configure WEDGE to 0 as specified by the TRM.Abnormal
> XADC temperature readings observed on Zynq-7000 are no
> longer reproducible with the documented setting applied.
> 
> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>

emails are lowercase

M

