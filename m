Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793362944;
	b=4QBRXdF62Xh6ZCM3DurQ/Zn13w0k01E3H0Zp5IN1z/Jb1CfTscncZPwhy/QUeeli8fGt
	 osJZluZfx9Zs3Qr2tyTZg5qtgXrqjn/LY4nxsKIt6lqchyyHQ2JQqSHDcPCeyhnCGI7pF
	 HaD/pdYoIpev4eN2CZOo202ivz6BEs60KGG2rKok1sbGpqs5rsVAYCyaClWvCqmeygXvu
	 edK3R5vfZP1DvY4pdteCt2tRtSNUCQ4XCE0RKoxQN+CjiMRBhHn49v6IXDUzkbwjCTEzk
	 0DpWURAOb5C+DDkZ5TrMYHBudpDBUeq3X8pl7CDKHhTUX4m2zOAJ+eH6x+Nqi+0U8lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362944;
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
	bh=pDcnT4djSt9pCqT6ZxvVUgmjfPqDa4igSgdjZ3ZiFkM=;
	b=1YTL9pm/BbcEzLaHWEnqRrIS3I9itk1qFBn58mIp2KTPcQSmpCFWDVr55YtOFFIyLjJT
	 GyAhMWu/A/pCcTYGlFCPKkiHRby5mcnvCcxfoqIikzLLFifle0PpM+pfIBZNgZaAnQgu/
	 5XLdzjKf1XE/6k2xq9mTWluZYWkXj5k98LvoodcRck+Em96q1rMBU6/c9ur6uB/WRiFwH
	 Wia8yHsDPYTq+Dklj9jmJuWa3DmXn4m8lCt5NzXoyfLuZ5w4o8TcMe//alBG0pQQhjLh5
	 w2mJ/rJD96A69jvsOxpZ/DLuCYcrmAwbb8kfTvD+wtPqbotQHfS0cG4CCLTQZ1srYyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s9VcBvWG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.35
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C9606A31A;
	Fri, 30 Oct 2026 12:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3C9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s9VcBvWG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfjSQvqptzyWY4UlijidcAMaRp8cNjxAmKH4STG9gCOqx5h2kD7zbgd0YXM+InazFqD2eCE0hIGUT3GJQSEUuarteee2D7L8eWNLF+Kl4arvytX5pX6e4ApXx06SQe7fgkzMwNjeZn0iiCmcvNn52F6d2hAvs5GUsbOSrZ2la5m17k7Xee0mv8/2SoKlbwBLBGRKniNXjecSENaGAYFUC2kKJxiBjAUZ6BVCXOzps/6CjxLyTK3KE1wwoVkUfddS5QF2aVurLff7V7wRqXlZqFCkp8CfMTSNZO3cW7WIkYYG6Gvg0PCD9+RKTFuJv9Glp0XdbM1kpGwt4lhNTpHHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDcnT4djSt9pCqT6ZxvVUgmjfPqDa4igSgdjZ3ZiFkM=;
 b=sIvlzHcsWxvTE9rT8ogHWG5nXrYfaxyezTBSeW7WLAkSm+3DIg0YbvMD1W4E66m2gqGak0MqxqbL011Gcj7/CIrjkGtn11suUpZ5i27O/foj9i5tJrGw9ShLg0F4h3R0SzXK49kCd/o8wYAjl7v5CK2Y4eQtSLEpHO5l0iKwF7UCTmdX5DqXVzNdbum4AJ8WPKHbDf0ljUPlk8c91kWZMQcuENpwk/4KNwBp2vJ5Xso3JpdPJkVrT4V9Zv8HZDrx463zcF9USDPZeIkbEh57LpMUjYUpz8czSMClQMvzI9Re9/F2UKmWdlycZlgqYSanDY/gsMxk/mVrX0+nMnq7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDcnT4djSt9pCqT6ZxvVUgmjfPqDa4igSgdjZ3ZiFkM=;
 b=s9VcBvWGvsc08bK/KAwwlvfUmjq0ph0dZyvmtmmKMvBaP1q5DDv6yIrm5vu7qtde9pwjha03H9CpeYoXbjboHmkGBCfyrHSAjuvug/7RGQSgQLgx6l3eoCiEnOIaoxWyRZ14FBXpa0k7Nl1s5m2GZ3Y6d0U/Lo+UzrsZGbW5F6o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:22:20 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:22:20 +0000
Message-ID: <4e034603-ab79-4939-8313-7744120dab19@amd.com>
Date: Fri, 30 Oct 2026 17:51:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] soundwire: amd: Resume manager before hardware
 teardown in amd_sdw_manager_remove()
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Prasad, Prasad"
 <venkataprasad.potturu@amd.com>, Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-18-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-18-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::19) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e03bb31-c8ce-475a-3251-08df3680715a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|921020|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	+EKeICWD80CinLJ66eBQF+f81mpyEG9YSweE6dJAqmtfJY2TVJV8In+YCsoz+IlA1lvVnWtZl4Y54oDItdhfxoXNlXS7nslDmmn67Ihs+ws6vFybQn1F5VHr7PclC+36v2rxR6XqQ9ld2UEeME/gNz3lzuIfYYa3oN+MibsogMyLS2hvVTLvGUODsnOCdIz6kUPg4KeCsEk4OXkzmonKjRv0/ZB66g1P6MkZBwfMU6/KdqzfgAje5Qj7TuMkF6XxA0LJicuHJuH9vOMsQqJkKYgBAO5WWwdF5ARF/mmTHXXeCvXx1bMv67ESqlVEV9qX30CQKohdXIV515JlezNbG2lFO95NW3ZHgIZba3iSXMXz16rrV8TLu9ERvyRb+3P5h/yDSlr71OruSm+CuJADZf0dPGXsPKwQhiycwsDlltF9/ifAywmVi7KAgz7HaJHG1XjZDkus7CCv0OkuuZ7+v5dAyi92tfCGtDjWgsojAsB30OMH1xkdICMwxNBzgGpwh0UsKsUOuy55djHf/HQ//buclvauivsM4vJTxaePop87B3rZK4IgR0UupudwSnco0PUy08o3K4CrGRz6XNGSlB11qhX28TLTx54Cwyyyu3DPINR3b4MW9N9x8o3+8PlaEv1KBAwUyDn2qK+58wpa3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5SNkZneEUwMldsUjdwczYxbjNZdkZqY3pjT2gwTFFoYm5CaTRYS2JWVERy?=
 =?utf-8?B?NlUrb3hhSGxpVUt4ZHUwbXRWVXk5K1p4RVBpY0VmaUdvQkVxb0JyOVVqTCtB?=
 =?utf-8?B?NnQxWURQN0dMbkJZS1A0RGhZU3FScGIvQ2htNmhlY1Aza3JUNDJqeDROTURh?=
 =?utf-8?B?VnoxMEc0T0M1aGF1d1FYVm5nQjBxeUFBcWRLVzZCV3NPaWRlaTExRENlVzU2?=
 =?utf-8?B?SUh5V255Nkhad1IyTzBvbHhWTjdFakxZdEVKV0NiZEhWckR6cXJIeXlCN2tB?=
 =?utf-8?B?WGwveEoxTSt2clhrMmNDRWtUZGNBQTF3cEFmRkg4Rm9PTHg4S3pFbCt0T3Nn?=
 =?utf-8?B?R05icjN4aUI1T1NoQVREc1dZVnd4RDRmZFdIQmZNV0RGVE52WmVOWHkxTW8x?=
 =?utf-8?B?VmIxRjY1TkZEQm81YjRoUUtQdW5DUWM5ZWdXaE9ZS1pqWG9jYWNkZ0oyNE1B?=
 =?utf-8?B?R0U2Vlcrd1M2bEEvWHJBc3U1anFDaEhXMVNUVit5L0ZWRnNXN2JaTW9NQWtw?=
 =?utf-8?B?L3dtWFJCVlhPK3gzU0tTMVhDSTVuSWlDVzJHa1NlcWViYXgyZnBnQUhSZ1pG?=
 =?utf-8?B?Q2tUaWkzMWhRNE5NYjV4RjdLaWJiNVczS0ZxTENlUjlVSC9RWlZwWUhrcnky?=
 =?utf-8?B?TW03dXZtMnpKZHBJcS91aG9lMWc0d0Z0aGZqRC95NjdyY0YxWGlCNGt5QVJy?=
 =?utf-8?B?R0JOQTRLcjBTQ1hSMnpFc1dTRkExVWwxb0hNUlFoNCs2Rm5ZVm1Ham5sTXBM?=
 =?utf-8?B?aVB6VnhHQ1FKVGo1a2ttY3ZVdFlBR1lCTTJPcTROWGQ0UVRvb3NJQTB5T3p4?=
 =?utf-8?B?TG9XdUdBclhrSU9VZ2gwa1FjYWo3dEJLa3FmUFdDamhJSk82T08ySnltc0RV?=
 =?utf-8?B?ZHRsandzZ1lqQnA2aE1ZM3NnVVMwSFdLNzFKT2dtQndYQXRsNW0xMFcvSW00?=
 =?utf-8?B?NFo5Vm84ZlRRQ2RRTHZQVkZxakNkVzYyY1ZPN25YU3pWMHB0dTZ0YnBER2ZW?=
 =?utf-8?B?bUw0NnprRGdYU0tqQkJObTFLTGJxcVJjb2NUbzZBVW5nSC94SnR2dmxmcFBk?=
 =?utf-8?B?d05WTXk5NDQ1UXNhWE5IRzN4UUtaL3dXby9WbkJJeWdPbDBiY2FkTWNWUTVp?=
 =?utf-8?B?c3NWRmVzUlJ1QlE2Z3lOWG8vR1R3QkNjbFNlY3paTHBtQUJsVmZwUmxkb0cx?=
 =?utf-8?B?UTZ6blNHNTNJOUl4WDNHUWNGc0Y0a1o5c0ZjcTNMOVo2Rmg2U21pWVJGY2hU?=
 =?utf-8?B?YVpzdnNmR0VKUHVLdjRtc3lBQm83YUpkcGxMSFg4MGEzNkRqeUhEZjFWNzJT?=
 =?utf-8?B?TVV1bXNYTUg1RkYydGs1cEF5N3l2N2ljTW5pK2lJa1V5QWtlNjY0QnFZaUpL?=
 =?utf-8?B?QTdPbGhxVjRFZUd5a3dXdUdSenFuN1RiK0dwYS9pdkZiOUpCeE9FSkNrc0hh?=
 =?utf-8?B?bHA2M0ZEc2hKRmV6ZXhPWm5GOWtxMUdZdUtaNG5nVjN4ZWFZZzVGekZ4d3Vu?=
 =?utf-8?B?Z1JPTlhhTUNyeXpaekdOK3ZkOHg0bDBaTjFQZVdhcnJqRTdMT0tMWXhHZWNB?=
 =?utf-8?B?Y3l4bS9Ud1BrSDVjSXJRTUhqVVcyT29SVTZNV2VzanptRUJrdFQrTDNCWGRX?=
 =?utf-8?B?RUY3aGRaNVZDYjdxcUtVbUNvZ1dhRklxS09ERmxqRU4yQmRYcWFJczVRMmxL?=
 =?utf-8?B?VW1yQ3Z0Mlg1aTRoWXlPVFVPYUhXVmNBSlg2OWZvQmJEeDlCeGtTUVFnWFIz?=
 =?utf-8?B?YU5vMFBOR2hTTnBhYTM1Zlg5ckNvVkxHSFZUcEFiR2hlZEZNZHpIc0tKT0xj?=
 =?utf-8?B?KzZwcjZSZzc1eEgvdHl5eGdlWlBuT0RwTjBJR3FSeWlzT1JCOG9qcVR2U2xC?=
 =?utf-8?B?ZE9TMExsa2prZUtTU0puZFM0ODdSc3RkYWM5NXVIeTg0V3FMV0xhMTE1MVcz?=
 =?utf-8?B?aW1nQStCWHFWdGNTeUV2ek8yaDEzQ3JaSjQwYkw1d3JmTjdlcVY5cXlMeURG?=
 =?utf-8?B?dnZ5UVZldVFXUXptb2FScUQxNU1laGc1K1RqcGdoSE51TDlwTXpMeUxBOGgv?=
 =?utf-8?B?V1g1OHBGRHdZSGhZalJrSyt5MXZpd0Y2R0h0TEZ3dHN6UExlaHpobVMzTGJj?=
 =?utf-8?B?QUJjWlVwMUs5VERJWFlEZjl0L2tteHR2WmJIOWlOR1dKVmVyRGw3NGN5RmxV?=
 =?utf-8?B?ajJBRzdGNnF0Z053eG5ZcUJpUnk1QzJNSVYrVnR2V0wzeU1XOXZXR2RqOWsy?=
 =?utf-8?B?SEN0aldnbVdibTNGWDF1WUt5SkwreENtSDdZUXV3SXRldmFjbmpWNFpBSlYv?=
 =?utf-8?B?djR4c3d6bGZZYURjZVVWUHNyUG8zS3FEK1ZwN0I5aVU0a2JzQUtmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e03bb31-c8ce-475a-3251-08df3680715a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:22:19.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMxNH22J1RLNWN3UvAeUTAS52uIn2BmYTRQuaAEHx62kvxAoXAP81bNp+XxVRF/Cw6cmvXzl8Vl0+SCG9LlE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> amd_sdw_manager_remove() calls pm_runtime_disable() and immediately
> accesses MMIO registers in amd_disable_sdw_interrupts() and
> amd_disable_sdw_manager() without waking the device if it is
> runtime-suspended.
>
> Call pm_runtime_get_sync() before disabling runtime PM and balance the
> usage count with pm_runtime_put_noidle() so the controller is awake
> during teardown.
>
> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
> Closes: https://sashiko.dev/#/bug/linux-dad4d803-06a7-473d-829d-66860776f4d6
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 2e1038ea0f36..1d8a08bda261 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -1196,7 +1196,9 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
>          struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
>          int ret;
>
> +       pm_runtime_get_sync(&pdev->dev);
>          pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
The SoundWire manager is a child platform device of the ACP PCI
device and does not have a dedicated BAR. Its MMIO is mapped through
the parent ACP PCI device's address space, which remains valid and
accessible for the lifetime of the parent device.

Runtime-suspending the SoundWire manager child device does not unmap
or gate that MMIO region. As long as the parent ACP PCI device is
alive — which it is during child device teardown — MMIO access is
always safe, regardless of the child's runtime PM state.

The described scenario cannot occur on this hardware. Please drop
this patch.
>          cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
>          cancel_work_sync(&amd_manager->amd_sdw_work);
>          amd_disable_sdw_interrupts(amd_manager);
> --
> 2.56.0.317.g454f8302e1-goog

