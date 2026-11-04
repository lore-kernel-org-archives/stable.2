Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816851;
	b=R/pRB1o23aaFqgH4Hwwznj7ib8lxgEpcNFgkTBKxnv2muBh06MCYDBZi+wfhbJvFBzaL
	 rog6h8+w+4xplRLJJe7glp08A3RZDy4nKON91HAKjPAwG4vay4jxh94niwhevbthA5lGX
	 UIe6wLWKDDyE4UzZsUUE06KE8Qk4DE5nMG4tV7RhlQc6UPb+upykVJoMSn4Rr8V8Rx+ef
	 lmJJ6aM0eA2bxHc7xB0Zp+immvDhFx5umaQD6hvYXhLs2HUU+9kiXxxq2rQ9E/MhD9qUB
	 lZBIsYf9dsPC968mKEQ0Z6yh3K2snf8T2lJMFx4/tiGkGMYCFy1JcaelRDlW9gianWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816851;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zb899icSw2jcraenfSf5c13LOWuS0QUsXFh671wWn9s=;
	b=jovZFPivz/IkU6RN8h0r/Qe41ZzMwwDqePOJNT/pDtmSJyQwO/BW/4Kzz1R5qzpjlgOS
	 4j5Q6e17O+/tX7qfriBFckxR7SmmMATZpiOclocgqIFlCkB4Go0Q1U8+IVvnATFo3GI1W
	 i7H2v1bnHFufkBKObK55QLkMyl2pPgA2pIchDDsb6rfyHw5018X3z17mEQ01X2g0z2UH5
	 DhYnsoU8x7gJkue1ohBTeC0cjo4BnI0My/jx1NNLlfNsG63bCTq1iPUSxti8vP9dCjfXf
	 6WYngaxnpZO8l5kLUzER2y6xa1r0hcKss3khH9EC4vIkpn3iETJAOtq8cV+rRV/1qEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qvgj0GfF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.61
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E0606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823E0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qvgj0GfF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d863S3M/NKGYtqxHe4EZhkCOyMpLmqJRc/EfhPzfRoUU9jR5sDBLGGVVDFY2tTSDhlU1U09eMV56gngMr+rOk+KSBTd8AXGwW3LJjU102At0OWkP1wLMr0+G4bwDSjUADlYdkoLVjY6zi1YZ2BzaDLYqewcgQqDG0UbCT7zXOzoae8dK4J21UgL6zqJAwnfpgbFoCUvGFbu9vf5eVxkscsBK/g6nosC1+AzCJHkTojFPkXC8+F+j4R7vvHhVRwUgx4ZsqMjkBvcp+6EytzK8JovwIZMovZl+Q61Jpwz3Md2393gTzsOjXpe7M95QVmpZXkBp6DDNuiC5T/Ik1ywE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb899icSw2jcraenfSf5c13LOWuS0QUsXFh671wWn9s=;
 b=YfiZ33zR0i5ssYLkB51hRrWh3MVFLWR8CsiqBvdmtFb1/O4AV5LK+tzQbkLjGw/xcVSYBbtiF4+zIFWfTQNff5NG+nXgAMC4RFi/E57AlHlf7cL1zhhnLu7PO7yq4LYA1sbxoggMN09+w29ldKJkf4v3VfGJGaAWNH2q8LJcyZeuCK0q5+Z5JbdM4cZUOaHvCUZaPjx8vUp0WESTrWyDqXsUGt8GL+dl19wa62zT/NNYLwxBHkm0S8+bBNW/+1zt4Pe8VPNg7OwR8nfc6Td0mkw3seR47vYWqA9KdVPqhf17yLnmCMWBWjuovCNxUJOn+YJwBBI5/HWmfAv3ZSudjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb899icSw2jcraenfSf5c13LOWuS0QUsXFh671wWn9s=;
 b=Qvgj0GfFKBcHicGRjCDRyGNJkOPNSjWfxra24XyqHNvb11FIsIyWTvC3wlE/Eimz4JnBsCNyDCE1bft5SSEvcaEVo3rL6t8N2MQf88s5Q8/3bQKbbLWTvKNGBBYiEL6V/DXfzzB3DxKYHiF74hdq1AnciAaj9YkfNftYmi3oWzU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9)
 by CH4PR12MB590718.namprd12.prod.outlook.com (2603:10b6:610:50f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:27:26 +0000
Received: from IA1PR12MB6234.namprd12.prod.outlook.com
 ([fe80::6cf6:114a:ea31:153b]) by IA1PR12MB6234.namprd12.prod.outlook.com
 ([fe80::6cf6:114a:ea31:153b%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 18:27:26 +0000
Message-ID: <a5659c47-3967-4a78-b0b8-2e31f188f773@amd.com>
Date: Wed, 4 Nov 2026 12:27:24 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: "Gong, Richard" <richard.gong@amd.com>
Subject: Add commit "63e91c199789 accel/amdxdna: Add support for AIE2 revision
 9" to kernel 7.3.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:806:a7::14) To IA1PR12MB6234.namprd12.prod.outlook.com
 (2603:10b6:208:3e6::9)
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB6234:EE_|CH4PR12MB590718:EE_
X-MS-Office365-Filtering-Correlation-Id: ef718019-a22c-4f3b-92bf-08df3aa146a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|11063799006|56012099006|261022105027099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	t/Jak7uGIf5uRr82Gdj/GQov4t05Vrq01vADhSqTz4g0IseNgXAhIpmvKqFFONPxlF/nd83e8ntoArSOgxU85gadPpDZyUYZ+/2jsrjGPaJ38NAZAIXLxhKesRFCjHZLXXEhfxK37jw1cTIyEzM3zhQ0FB6lmr65ixB4q6dG/VcDQrTRkStyOpa5gySyp4hCXYyQb4HXswfwzTkOXoDAnbMdcbkJqm4DU12dTHWjq/kxsr7VFOrKdUzaeZX3u8DsrJa+UhV5LbgnvNuHhFLpEgpXCbLSYuYvUyepwhAIrQ+AjkNi58SnDI9VaKo7oevIYef1ZxkIF9EQKCiumtMOpsvLwxvgpwG5+WlvQw8kiyYu3cEP3/ylvDWOxP1q2TxxQmLdEtyao40GgzGVtuX4TiYjF5Q/fYj9eRYLX1ezXXe+IQ7PP5w+phjqLZaAhsBTmhfH/XZm1Cms7pbohIsR5oUB81bLhh0BdA+tyMXSBMCnJ6dL7d0ZJROBk0Bs9fY7VAL97p31LkBhZM3aQPFNvFFM6Ds76wTfjyGxVg2vdYv4ZqeZC1blspaZNN5bqcXM0Sj648KlBcahQpiXgAyqjmxhqscvxz86+8Jj6rqZX5rhkfxVg09fAkkIEk5/3V7EcbMg1lOsyIirjOM8sHM9t/Biq+7s0v9wvA2Gh0eOLBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6234.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzlPVU9CdCtkQnZ1QlBSbzFCdTZyRkwzZmhYRHR4TitJN3BnMGxjMFByczg4?=
 =?utf-8?B?YjVhaEtkWDBkTjJGL1VuZmxqWmZGSWNaaEtxQkF0dmJTTVpGb3ZyOVJ5NHI1?=
 =?utf-8?B?Nk16ajVveWpDWTFJV1FBM3ZDUlB6U3RQTjNqeFM2aUp4MnVMV0dhRnhrQmNB?=
 =?utf-8?B?ZnFUMW5wa1Z2TXZSa1lXdXJNOGFSUTVqUTArZU8yZGIvWDJCUmpZQ1E2eGYr?=
 =?utf-8?B?YktwSWZISTNTRnVpaVVPbVRPUHF5UERrZDVCY3ZPZWVaN1BBNVNNUlVLVmFF?=
 =?utf-8?B?SHJxcC8xNnluMzdtVThFczBDa0xLR2pKc3RLYkN3dTdsOVV6YjBtWHFKSy9L?=
 =?utf-8?B?T2c4RlJxZktpc0xuMkFLb1ZPM3hSZ2tFeTNCTm9TQnBBTHpxdHJraW84cDVk?=
 =?utf-8?B?cWh5MksxWlJWRTV3ZnY3dURZODY2d1MrRGxTSjlZelNVTFBBWFk5VCsyOW5P?=
 =?utf-8?B?MzZ3eGpIYVNkeXhZYnowcTlHNTZTY0hHL3Bsc25HTHJUeFlqZlNzR0JkRGZR?=
 =?utf-8?B?WFNRNEtGNC9HQUlLa2xzazlKaDJhc2lyUzFkaVpGTEg4Z0hMQnJpMU1KVUJS?=
 =?utf-8?B?ZFEzYUNDb1FvL0dKbDFjV0hnQXZhd1dPQ2QzWHR4L2lXNkM4N241RkUwa1JT?=
 =?utf-8?B?Q3BoazZzSFZ0TXltcDQ2THpvSlg3ZTI0WW9ndlF4RENEQVdaRnZIRWRua2Z2?=
 =?utf-8?B?L0RjUFlCa21zU2poQjVxNVF3aXc1OGk0THZvVG9jTWpmZExHNHJNaCtyLy9H?=
 =?utf-8?B?dDNLWCttSVpyUk03bDBNQXZtNGJFaEZ3dHA4TitNSUF0ZnhLMlJZcVRNNmJ1?=
 =?utf-8?B?V29JeUs1bFZKWkxkTXMxVkhGU3MxZWJYNWh0T2JKZVZ5cnNheVcvL0daeWN3?=
 =?utf-8?B?dTNxeWd2UHhjaW5PdFZYanRnbkQrU0tManhPOFFCOFdLRHh4ZVdFSEhsUGVv?=
 =?utf-8?B?VVpWZ2ZRdXc4QmorWFFndTRmQU9KR1E0VEE2K24zeG5rWDgzalRmLzhWdUVi?=
 =?utf-8?B?Wm5iVFpiMll6YXFRKzN1dmZMNmJDMTF3OUk4ZStTUzR2YTZpUVRYTzhYSW5B?=
 =?utf-8?B?c1J1eW5SVmswQll2NVBGcWRzMTZOSmNYMlFKOXBmbnFzSmJMZTlVMW5kSklH?=
 =?utf-8?B?T2d1S0hjcjJDS1ZYOFRDaDZXdS9BS0l1elA3bUxXQUZpU1VFRU5iVmcwZERF?=
 =?utf-8?B?LzA1N0FNM1NlMFg5dk1INXh1VjVpamQvVzdiazFZNnRyU3ZqemtuUVFFRk1P?=
 =?utf-8?B?eHNRYmYvR3BpdVBPeEhGTUxhemhldXl6SktoS2VoZlJpRks2RURQeHJLaHVw?=
 =?utf-8?B?NWJCaWlycmJvdkwrZWV6SjRVWG5LcmRUcUpQSTBIdlA1SDA0c2ZzSFo2bG5a?=
 =?utf-8?B?MFgzVm1UV29oVUltamN6YjRYNlMvYkczcTd0UHhaeXZWcnE0RGhOZVE2MnBM?=
 =?utf-8?B?SkdnMm9lcGZzT0J0YUIyV1kwMUV0L2prZGVQc05VSlJPOU9nTVZOTjNTZXV3?=
 =?utf-8?B?eDFHWDFjUTB4WTVlcm5BM0pNQkpGR2dyS3NYZ0tGTkxTak81anMyYnRrZkZl?=
 =?utf-8?B?a3VneThJQlU2eWs2Y0V6Ui9XY0czNEpwS2VnTUZBOU81YzBCelZjU2xPdVRW?=
 =?utf-8?B?MkRSaDlxUVJjeXN2Q015M0xPUlJNclRjUnBYVFJkRVBsaTVxZlhZc2RuQjc3?=
 =?utf-8?B?bzl0NUhFNkovdVZWTFdBbEZtZTIwc1NTWjh3ZHhjZHNnNko5K2ZNTC9NUmRj?=
 =?utf-8?B?WkdLanRTdGtmc2RwRnBmQ08zMmhmbGRYYnZyclBKVERNQWkzSDJneXVNK1Na?=
 =?utf-8?B?YWkvMjA5VHpsMXM1OUZmWkpwSXBFYmUrZ2pZNGxUZHMvYWl1dU9TZU9HRGtG?=
 =?utf-8?B?b1hSYjJUcEhRcnJnQlp3d29GS1R5SnVaelJibmRWR0NnSzJYRWRqcXc4UDJh?=
 =?utf-8?B?c1IzdTdlcUhVclJYdGxoMVkxUDF6TkpVYzJoL1lRNENWSHZaWlk0Si9SQnJV?=
 =?utf-8?B?UWxibXUwbWFIZ2hvQm9xTnYrTUJLWVI0cWM1aEFMQ2UrZ1gzblpRT2k4dGFY?=
 =?utf-8?B?S0d2SERtYlpzR3F6TVkwZS84WXl4cHVRWjZDL0t5eVVic1l3cFQzZlgxNmM2?=
 =?utf-8?B?a3UrMm8zK3o0akhYTnh5YzhUYWh3dE5ZTjFlandjQkI3N0M0cGl3L0dUNVk1?=
 =?utf-8?B?U21BdEJGMDNmcFJpWG1ZUTBJSXhnQzFXK24vMnhjOFR0dmVjS0tTc3gyN041?=
 =?utf-8?B?NFNKVzZyRlVTUnNRdUlLZ3NpOEZQWkkzOWtSQkVaTGtHY3BrVzRKSjZmSEh5?=
 =?utf-8?Q?6eJwVwGPdclSAWp8lw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef718019-a22c-4f3b-92bf-08df3aa146a5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:27:26.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxOpMbv4UYgTz2uEgbxKZ1bKXUZvyJXhVME35bjvhLlnSG3SSAMSFBW+6Q7LGeUHXlfi4wLPDqX6gY7XYa65TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB590718

Hi,

The following commit addresses an issue where the amdxdna driver fails 
to recognize AIE2 revision 9 hardware on AMD processor from family 1Ah 
Models 70h.

     63e91c199789 accel/amdxdna: Add support for AIE2 revision 9

Please add this commit to stable kernel 7.3.y. Thanks!

Regards,

Richard

