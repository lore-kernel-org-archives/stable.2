Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793326200;
	b=xiRZLh6w1qVe2LIFVFkYkBympDT6Q5TXay4IpvP/b96ORZiwqd/s+kVOfvhcjnN3NKG3
	 WETEtltRRs+J90bUowAgQ/A0p2oEZ52fo9vBfKZfFkoY9DgFMYVuflESh5H2iJN6gNQaB
	 N2KF0b6wQ7GD+AkP2FQUooReDr/m1ylZYS4RSr1I2n+iexQAoaJGRVHzzsuem1ySmydwk
	 pVK9YajxiPW09EPu03FO4jY5qkUrno2dEuzJ7Lx9g36G4KtVXcFBYQdHPhZMP0MZpJe+q
	 FU4St4FXgxcDxN1M+MtxMVWua/7QFy5wpH7ogtqvmtlX4Jhr7anF0PPtzUb+1zwk6+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326200;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=gfanOOaozXx+NMgSq0Z71/Ofp9shW0FRiDHYkg0Mg0c=;
	b=RTASJXoZyusZWGJ3Bkzznc+lCrFldvoYOIK5WLeXGl3TkyjLfvqguP/WqDdQOX7nzqwH
	 7H9qgAhID7CCHavH4KVLh0q7q93SJ0Pu199ynGGzuPcnOPyiodCwDt1jqpEQhcYkSUcIG
	 Iwnza6Pg8sowlgCF6TXHOlvXNKSytFM19W5wu5Um8QAKtSV1Y2QQkr7/rzM16itproIT5
	 V0JS9AEXWXsq55ISIk+ZWxm80/7/Sv30pNd0+YYSAvte0LMVLOQ7MoQEe5L00cZ6XsKcY
	 D6b6qk2FojobUrH5ryZECkWfZ9gcnwKkGGOPh21lYvPaYToIzzE/rpl6vvKibXhNTJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DTAiLZtO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.22
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98220606A31A;
	Fri, 30 Oct 2026 02:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98220606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DTAiLZtO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8oddOVqopzjSVrxVFuDXgV9vK9eEgemIuQNM24mw9vLWKPfhKn5dFgmr2bHM83bXIy9XnRuPUAkfD4pyIIBNDlIQ32SwzZwZiUhPu00KvJ5Z+s8JeKPUQjJ6Kwqgfwl2EnpMrVW8iWpan5FX/K9DB61fGNfC5quN0byLcMGnhp65jV0cAglg4B4NOPGaN3V2iGP0d137a3w0bh15obvHvZzWGhixzV/ZE7BvU3QoOAlHPobGlTesheek6M0BGOvOFNSW3HAExa2RwhT5NKZZS1rNqIREUdfj81Y41bMD7Bb+QHr8MEJpUOq8KalK8PY3UaX8wmVADLA0Fao5NG8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfanOOaozXx+NMgSq0Z71/Ofp9shW0FRiDHYkg0Mg0c=;
 b=m+XSe/PoRknPj2OJ73Q/nzOtEVefDWXAyQIKcUAoRu7CCrZQLLM1VJpKFsxMu98PFYFaPqnpawgOELBYNSVPxZUwDMGN/HjBP89MrpaPjIGgvl5D7NEwYhNN9XzSEW1OovWFj1vZLvALjGn2I6ETwH39ac5jWjCz9EE4z1FG3YUgONL4+M9y8bkjcONgVfwzJ/vjga70c3hE3P8QNh30EGO0rY0Jt71b4uvpbHU1hLsJGqcdvP6q76qoT01sJhCmmSAhAMbTqlxAZ43dvvdnODCUjjpoibMs1auOeovjrd50H19w0iGVuEd9yQaISsgwsDqLNyvuZfpKuqTMndQnkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfanOOaozXx+NMgSq0Z71/Ofp9shW0FRiDHYkg0Mg0c=;
 b=DTAiLZtOb5ccTKQBW3lNzLjssqetBAyMuwJ1Pk4MITaim1iYUxWVCjEWn/5JshkJNptB1TWWjwgjlG0BiANQMFnZZPH5rVpahzLkBtOdhvkDXbdbEbhYRqmDpDU/GsR1+4h4i61ffTcrYsdFAaI6BN+cXdCTrDBC5D03K9v6Am8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 02:09:55 +0000
Received: from DS0PR12MB7747.namprd12.prod.outlook.com
 ([fe80::2ef2:e88:4708:b589]) by DS0PR12MB7747.namprd12.prod.outlook.com
 ([fe80::2ef2:e88:4708:b589%5]) with mapi id 15.21.0569.007; Fri, 30 Oct 2026
 02:09:55 +0000
Message-ID: <4fd44cc2-ce8b-4919-bfcf-586ba0c20469@amd.com>
Date: Fri, 30 Oct 2026 10:09:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: amd: isp4: fix self-deadlock in
 isp4sd_start_stream() error path
To: caspar.adriani@proton.me, Nirujogi Pratap <pratap.nirujogi@amd.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Benjamin Chan <Benjamin.Chan@amd.com>, King Li <King.Li@amd.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>,
 Yifei Gao <gyf161023@gmail.com>,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
Content-Language: en-US
From: Bin Du <Bin.Du@amd.com>
In-Reply-To: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To DS0PR12MB7747.namprd12.prod.outlook.com
 (2603:10b6:8:138::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB7747:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7c6455-6560-4821-fd65-08df362ae3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	4jx22mmPl8k7iNLK2cMAJqVhzc01Kp75nKm4wSkfHIVryQIWoZvObu+GWXgBth4amhc0t7HYaDL2dNFdaCii5SUTcny3L8zMishOuFB+d8Wm081QI7sbAoeHfX2+ssUSNNSyWhUlWfL6Py6XJc41OY2E7TSG+fPMi7ii3pHMGGxLHDuO03f5vDTUoUXwyKQRleJGclO/HAMCtj/uQr30UmoH7F33wnsnBu1ki7e4DEYFk0+uvetP1lci7sULjtJXtEOtfto8PVTrc1WLFrNjuiPiw2zVqemkuvZ9+wfq61weZBkqmRko2kWX1vAa+PFNq5vYoUzbgqGn8PdZMSohu+Tgm8dvbYQ+f+3uKmMXEYJr8bOX24s7hnHZlwfwkYAZxVFVATpD6H13fGSgbwP6LzEctYoxIPLj6jApew7jQSTywjO+4ws7tsTdz5iJo/5bQqHW+eBZobwnwD+90nW+iehgWqj1aHxEW5YVt5oPNVb22CQVmZ6KAxrEJef1wbByitgdo8JB78UDnqMBS8CYdRunbFd8PtQ/p1jJ052LhiuskApUsl41aPpeGKg2aKavnQ47j4oJwu1kjYopNEbqwFZQPAkYps3hLyCdgh2AzsdYAUFZn43ioYLLr008rlFBX8XFaQv0CpKCyKLOr7zoKHUit2gfu++t2J5HDu3L3dQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7747.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FDM2ZJL3FqMm1zblBmVXV6TWV4c1JKQmN0VnpPVXZPQU16TSs2OHhYNlI0?=
 =?utf-8?B?bFZlY0FBaldVKzB5UURia0lab1BHd1RVbzNpVW5Ldm1YM25qYW1pQzZ1SXlQ?=
 =?utf-8?B?MmEvdXpvYnZXSGFPUThsMnRVQlR6WWhEYjFRUWFxc2JhSmhERDl3dHFWQVox?=
 =?utf-8?B?bzI0SEFQeUlxdjhJbzkrK3ZuNWdVcDU4eFJmUUMybDVCY2JDZTF3SHdweU1V?=
 =?utf-8?B?MGM4cFc0TVpTR0F4SWxiZFliQTJQcWdSQktiZUl2VGNyamFDREV5N1lwUjlk?=
 =?utf-8?B?WmRndElQN3FybXlSWnI2a2lMcFlraUVhUTJ5Wko4Y0VFWGpDN2FmRkhRQlpw?=
 =?utf-8?B?UzJtUTB5S2xyckEzcmpaU2xWbktiZ2wrVjVidTF2UllsVWRHZWFNRUp1T2lV?=
 =?utf-8?B?ZkdSVlg5b0t5dnFlVVIyM0taQk1weWthNGd5WkZUS0R5S0JINkNFVm9BRU9L?=
 =?utf-8?B?QlVIcXFlWERRZDlaQTJpNGE2SFQ2cG1wRzc1VmhhSmplWGlQREtDZHluSGE2?=
 =?utf-8?B?Y25SRFdLMGovd0hYQUw3WWgrdU5SSzZkaDhERjlzc2N4Mkx5NGkxKzVTWmhK?=
 =?utf-8?B?MEhvVEFCYmVER0dYZzFWSEkxWXJHTDExcWtVZ2p3ZjdHRnArc3BCbDI0VUZa?=
 =?utf-8?B?THJiWnB3eVVUL083TVFCMCt2MGRlY2I2d2ozWVZ5NWJ5bFhCZ0MwN2IwUkhC?=
 =?utf-8?B?WVBrRGJxa1dRalAwck9Db2FGUXlHSHlyRTZkak4zYTN0cldHYTZGejhkUUx3?=
 =?utf-8?B?aHBlUVdudVhsNG9kbjVUZFdSc3JqcFU2cWluZmtoakcya3g1OTUyU0hDQ0Nu?=
 =?utf-8?B?NGgwS3V6cW0yRlB5N2Zva1ZVdHJmLzkyOW5QWWZHTjY2OWFxemU5MUdSVzFS?=
 =?utf-8?B?ZFdnRXRKMkM1aG5Pamd0ai9OejdBbnlyRkZxUzlkNjMxSE9MUFFFamdldXVN?=
 =?utf-8?B?Ri8xSlN0SUYvZUk2dXFpNFdmUEEwYVI4aXFkNzJSUkhnQXpYTzJYejFBanlz?=
 =?utf-8?B?QlJFdXVNeGdZaHJ4SUg0QU1NRGRpcHl5cnpyNUN5N29rMjZGZEJkZ1dZQ0Rp?=
 =?utf-8?B?Znd0NTBxeTBldXRSSWQ3ZHZmWGZZbkZia3FxeEVBdXl0ZGhhNDZZc0dUV1BL?=
 =?utf-8?B?MDdLQ2haNmZ3Z1FpZ0hUanRReE5VeEZRQVR4cUtKWjE5OUhiYmRJN2dpakhn?=
 =?utf-8?B?d3d6b3k3WlZWRXV4STJYUG9uL1JzWEJHa1NlWE5wdG45RW9adDZnczdKdjEz?=
 =?utf-8?B?OHBUdkN0b0I3WVdYSEJzZTJaNVZNbjBIVUZSZThsTGtRbW9KWlNadUVMNVJ2?=
 =?utf-8?B?UkRJdU0xbnBuSHdiVWVpcklEK2IrTmNmeEFoNDhJSXUydDdXaHc0Wm5ZUEky?=
 =?utf-8?B?VWhsbEhXRDFweXhYL1pPSWd3NHF0aDI3U1JQaU9TK1ZpOHFCMGJQRzI5Vkt3?=
 =?utf-8?B?T1ltRVRDSDJCTHpsakwwWUpjd2xYZnY5SUdDaWxJc3YxZU5UOEs5dDgxL1ZH?=
 =?utf-8?B?L1A0R2pIY3FkQUFnK0ZoUFV5UzhVNmVTQjhkdlFtRU0yZFNFVWtWYUdDRVRi?=
 =?utf-8?B?ODR3T2JSRlNMMytuUXE0LzZmUnRidTBVTzFxOXdJMlpxL09TeVNqMExpNUE2?=
 =?utf-8?B?ZHBndmxXM2p5Rld6b3lXVXJlcldGZVdlNi9aRVVTa21LbjBvNFQ4SVhIV2J2?=
 =?utf-8?B?U3dMakRkVEpPallkekhNM1JpODRFdXR3QlhFVTNkbXQrakJGbk5KLyt5eW1n?=
 =?utf-8?B?N01kRWhGR0VDRGUwamRNdjRUUHBsekNuamI1OUsrWmJYUVQwbnNqSVVPN3Zr?=
 =?utf-8?B?MlMybDhIemVHMTY2Z0tnWTdQMmgrcjAvamM5ektib25hb2o2ZDUxaHZPWDNh?=
 =?utf-8?B?Y2kyd2pJSXNZMnhxUVhXa01oYUJWeDQ5OG5ld2V1V1F0ZnBQaHJpRFgya1Bh?=
 =?utf-8?B?ZXZzNzdTUzkyR0lFd29qK3JndzR4TG51VjJFZURjWXJDR1k4TnZMeGxlcXhR?=
 =?utf-8?B?aUpUUm5DYisyRzRCRkluYmt0aytTaWVIYUtLMEhCaUI2SFVtZ2cxOGJNZmp1?=
 =?utf-8?B?dUl2aEpMYk1RL0U0VTJGb0EzMUxvc3IyUzZxaUdsNkVxMVpTOFF0bU1oVVdo?=
 =?utf-8?B?ZGN4c3RDeHoxWHdFZnVMVXErZXB0RGxIZUFjeTBlMXNGRmYxb2I5VEx1RHNW?=
 =?utf-8?B?c29ZakxzaU1QaXlEMU82dnBaVHhaNHVoRzYxcUJQYjg5TENYZFE5VDNXc0ZC?=
 =?utf-8?B?L3o2QTgyMUtxVWlpQW5NVkRQcHc3VUlTeHBia0VWOTExMnZtWG5mRGRxQXZB?=
 =?utf-8?Q?pSqj86IZOnGwqIkMCQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7c6455-6560-4821-fd65-08df362ae3bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:09:54.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzqLvpgSj9yOtGfPHLvLuwaPCQLbVdZ6gkFzn5eJ/pCd5oC97I7+ooCYUyLi9icC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA

Reviewed-by: Bin Du <bin.du@amd.com>

On 10/28/2026 10:05 PM, Caspar Adriani via B4 Relay wrote:
> 
> From: Caspar Adriani <caspar.adriani@proton.me>
> 
> isp4sd_start_stream() takes ops_mutex with guard() and, when
> isp4sd_init_stream() or isp4sd_setup_output() fails, jumps to
> err_stop_stream and calls isp4sd_stop_stream(). That function takes
> ops_mutex again, so the task blocks on a mutex it already holds. Every
> later open, close or ioctl on the device then blocks behind it, and
> only a reboot recovers:
> 
>   INFO: task .v4l2-ctl-wrapp:38440 blocked for more than 122 seconds.
>    isp4sd_stop_stream.isra.0+0x43/0x1d0 [amd_isp4_capture]
>    isp4sd_enable_streams.cold+0x8b/0x26c [amd_isp4_capture]
>    v4l2_subdev_enable_streams+0x1ff/0x360 [videodev]
>    isp4vid_qops_start_streaming+0xf2/0x160 [amd_isp4_capture]
>   INFO: task .v4l2-ctl-wrapp:38440 is blocked on a mutex likely owned
>   by task .v4l2-ctl-wrapp:38440.
> 
> One way to reach the error path: start and stop a stream, then start
> it again without setting the format. isp4sd_uninit_stream() clears the
> subdev pad format on stop, so isp4sd_get_str_out_prop() fails on the
> second start with "fail to get out prop" and "fail to setup output".
> 
> Move the body of isp4sd_stop_stream() into __isp4sd_stop_stream(),
> which expects ops_mutex to be held, and call it from the error path.
> 
> Fixes: 4e5e7a7ddb4a ("media: platform: amd: isp4 subdev and firmware loading handling added")
> Cc: stable@vger.kernel.org
> Signed-off-by: Caspar Adriani <caspar.adriani@proton.me>
> ---
> Tested on an ASUS ROG Flow Z13 (GZ302EA) on v7.3, with a local,
> not-for-upstream change that adds its OMNI13B1 sensor to the ISP4 ACPI
> tables so the capture device is created. The stock firmware does not
> support that sensor, so no frames arrive, but the start and stop paths
> run. Sequence: v4l2-ctl --set-fmt-video=1920x1080 NV12 --stream-mmap,
> stopped after 10 s; the same without --set-fmt-video; then the first
> command again.
> 
> Without this patch (v7.2.8, same setup) this failure hung the task as
> shown above. With it, VIDIOC_STREAMON returns -EINVAL after "fail to
> get out prop" / "fail to setup output", v4l2-ctl exits, no task is left
> blocked, and the third run starts and stops the stream normally.
> Not run: lockdep (CONFIG_PROVE_LOCKING is off in this kernel).
> ---
>  drivers/media/platform/amd/isp4/isp4_subdev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
> index a108d90ace..08512f060a 100644
> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> @@ -745,15 +745,15 @@ int isp4sd_pwron_and_init(struct v4l2_subdev *sd)
>         return -EINVAL;
>  }
> 
> -static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> -                             struct v4l2_subdev_state *state, u32 pad)
> +static void __isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +                                struct v4l2_subdev_state *state, u32 pad)
>  {
>         struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>         struct isp4sd_output_info *output_info = &sensor_info->output_info;
>         struct isp4_interface *ispif = &isp_subdev->ispif;
>         struct device *dev = isp_subdev->dev;
> 
> -       guard(mutex)(&isp_subdev->ops_mutex);
> +       lockdep_assert_held(&isp_subdev->ops_mutex);
>         dev_dbg(dev, "status %i\n", output_info->start_status);
> 
>         if (output_info->start_status == ISP4SD_START_STATUS_STARTED) {
> @@ -786,6 +786,13 @@ static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
>         }
> 
>         isp4sd_uninit_stream(isp_subdev, state, pad);
> +}
> +
> +static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +                             struct v4l2_subdev_state *state, u32 pad)
> +{
> +       guard(mutex)(&isp_subdev->ops_mutex);
> +       __isp4sd_stop_stream(isp_subdev, state, pad);
> 
>         /*
>          * Return success to ensure the stop process proceeds,
> @@ -836,7 +843,7 @@ static int isp4sd_start_stream(struct isp4_subdev *isp_subdev,
>         return 0;
> 
>  err_stop_stream:
> -       isp4sd_stop_stream(isp_subdev, state, pad);
> +       __isp4sd_stop_stream(isp_subdev, state, pad);
>         return ret;
>  }
> 
> 
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261028-isp4-start-stream-deadlock-6c33a97d3297
> 
> Best regards,
> --
> Caspar Adriani <caspar.adriani@proton.me>

