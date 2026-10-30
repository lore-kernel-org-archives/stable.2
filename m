Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793363388;
	b=IJ2x3plA29lWUKVy1B2szHwg/cHLqGNEcWHJ2NZWi+8amsBcSUSljyg5m/aBtmLdjLiK
	 vhc5PfRfgTPDeUrPKVBlPEnUWGt8GWaa64zPp6cfng8Ngrt152FFh3pSBIyDzYO48zC1i
	 2l58GIBCbDW1vGgJh4wYOVNd12c0o1y79aXqT5Vc2f+R1CtC0t5ANsLA+EdY95ujwHtKQ
	 p2ErjDQV3zq7XBTqtrEwYICnv2+SlzNLYd+7pE8pwowDKdzd3FUtk1gCX1FH49TbsKqA9
	 f7JnkMakt82i0x6eE4c/dLmSkBaPLZba1fuFeZKk/zfMNtyl1sukSw64ftRrP6R9K2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363388;
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
	bh=KqDv9O/lym0AuZqP3MEoO12afg11wChGVOVXXOgkbdk=;
	b=bsN/2L4sN60r2TGciCqfBogViozwxONiV2ySJbCIDzfuRgFGDdoFwhqQkkKl8v4qsGU5
	 96/LFPDC8AMu/0HzGvB5ClCtd2bXuM1lQNI/EMNGTn2d2uH62f8nqFkj3hiy3skI7dIUj
	 CX80siJ2e84E/s9DkX2p09dgWwNTr0kVoHfFuS1dL6b8U4J6lDRv+PqDSmnhD/lIzGgmY
	 xYt2ufxhuq11aeAZqBaXLPKqwr+fC1x8ai5UMOarkNYh2FTPkIJzHfRO+Ar+1o+dMCaw6
	 czetfAi6AkBfAdKSS53vxwEFtcx36fLU3UW1FZLAgx7pmKBDaqjH1+a8EUlWKDjhI6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pwHnRDoH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.48
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D256606A31C;
	Fri, 30 Oct 2026 12:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D256606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pwHnRDoH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIaWvnYt6QZrgHmKSs6t4Gma5ZxhRYAJdY/APibhKROve4zpdQR/jUDB5pwhVnsykFyb5ZeFPMtAKtsi4DUHXLC1/XNWIKBuwEZcZz8pgCcME9qQ5PKu7jb3dq/zZSp68iUw4IluLvOzgBomj3ZDLdKRJTyLISllbwAzaN9VFbREX/PY0VkpV5l9+Ypxdyy24lvBdCYVIY0VIydXrGiPq4EMRZo6s5fN6PzJAcZDSlqokv+rOvfMtMwt9K3MpcXNzKiGW8Lz6NeuFQuPr9NQ7T1ojJQTNNB6fi2eoq7cU+rbric2E8O8XMA8JTSJECEYHDIb7z7UYcdYTzI6KfF3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqDv9O/lym0AuZqP3MEoO12afg11wChGVOVXXOgkbdk=;
 b=fcIzyi+D6smrbRj0ZGyx8lNdbHUN5qnfQG7HsN5Du512Z6QRGbIBTPkPvMR8+DFuL6UxDAKNRio0VCOu70klhar0d9+ylzCPRTRa6cdelDOZLguv0Xp4yAtjWNG8UKbtpNv7Or0XImYGohJhb6WzF9K2XQ0mrGgsnYH2Hh2q4oMsMNsbEEOpilUr/lmkaZVaCQFTtLwHFdfj5G9uR7MnooqYgQoCP0WbB6EthPwhfAW/M50I4UCoRg+OOJ9NSg1S39mSjGhuEpUey5ZtBur5D9uTYOkc833N6eHnqD4GttzwiWv+gGATbFPR3K5i4JJgUv9z6sA57uy/U3JOTWXReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqDv9O/lym0AuZqP3MEoO12afg11wChGVOVXXOgkbdk=;
 b=pwHnRDoHmoYTUq53t/nt8aYn1L5cT1B8Vgmi5v7FjThdfshEiRYnHLBK6lKbYAXkxChsCvch2gIdLHGih5SkD1fLtZC4NkdcT+n5d0EhaDdadXFkqzh0x070IzRClpoFc7p7tLFr45/0fbRk9ryVb+Un+kad529yk+zsMn4fSm0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 12:29:44 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:29:44 +0000
Message-ID: <2d7dcffa-687c-46b2-b449-5818cc4ca56d@amd.com>
Date: Fri, 30 Oct 2026 17:58:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] soundwire: amd: Synchronise parent IRQ and disable
 work on manager removal
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-19-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-19-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::9) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: e605a490-2b12-4d9b-30f1-08df36817a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|921020|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	UuccgnfkPMRmjiloJtrreDXPFSW8Z1ipxCdkVEngF6a8gkGIqs9VJ8k+44uOTticVD+nW5FtPQkIxkAORsFB2GFFrveydkidAKqFQ5ixrxMo/QRLDQrua7F3AokljAq7PzmesWolQGGvyEElJHc6aavKRISXAXxLxqOJ0iZ8DtUZdyQruS23p3ITQMJyg4zYT/sQVDeOwFgwbVOK3gMfi1g7C55hZXtHy+KsWi3pMdS2vlK4EKVwDafDsiAs4YN8x+6KxNTZD7E0El+BexXzOoDxMU3Un13fpw6M7NoK7eLKMl3MwrOcvd2FatzXKBOUAUjVWdZoUMFyGBbFQ+SHlGajhzTRdHfLeUWxZvQwUhDUGnSesC4O3shwwNSzLjs7UmApvSkg5cijWNEGz1usKXCilPEaoBYPduZKBgJ50PTMgw8xYFAdM7o7nbzl3lwOsaWM3ke9HPaPvDZi6U2j5Fj7XtdjSIjhCYQS8bvsKcFliwozxCwCb3qJNqZO9xzPzeH3trIAe+mE9CHNgbT+5CJqe3FiTQs3QLDqLHfRreIxzBEfjWtuTq8reKHMSV3yEhQMvj1lBSYhY3iH+ULSK+qb6BMAXoqh9IXOfRKnPr6cTawvmU9lwLmT2tA48Y/lU4GME7OBRv5ZgbUmXkZDlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NmYnVDRElieXEyeDVGallNSFhhVG9GdC9TRU9NdVhRckJUZ0pxMGo1azlo?=
 =?utf-8?B?d3FPRlY0bTVnaFhPSFlYa1BSLzZhNWlLcW9SRmxxRW1CMDRiSDlRUmtBVDhm?=
 =?utf-8?B?TUNicnYxL3NmU0tJTWNvdEZhK0QwR0ZGdlEwUzVPZkdRQXFPUnhjbzNBWXl3?=
 =?utf-8?B?aHJLRzJCUVZKb3F6azloVm9hREt3VyttdE5TRE9qZjdWRWFUazNqTnNuQits?=
 =?utf-8?B?OWtHOGc5SjZzajVSVVRXQ1hxNVhmL2p1NFNISVowZDR0LzRJaVRjc2Nta0ta?=
 =?utf-8?B?UlEycWptSEhOS2MxZzhCM3AwczAzcHYrMzloU0VaRGtmaCtGOTZObzA4SHZw?=
 =?utf-8?B?QlpaK25iS3lZcWM5NkMrU1NpSkxLczg2dEllMXNoR0JPS2p0K0JlNE1pdXdD?=
 =?utf-8?B?a0VNaCsyRnA2Tm5PaVMzSitBOWJqOU0rMXIxTFYvdUZOUkVyOCtIMU1XY3lF?=
 =?utf-8?B?U1drK1o3WGp3ZGxhR3d0d1R3RXN5U1BiVmpUeTBVeWRkQ3Z6NXRzSG5lWlBJ?=
 =?utf-8?B?SW81UXpEQncxQldnMDgyY3RRQlZMeENDeXFkaGUvOVNpc3NEYnpPNy9GL1Y1?=
 =?utf-8?B?MFZ6dGVCWnI5RUdiMTBHNmNsRlg0QmpML0hocXZVcWlPdEFxZ2IzbWZtalYx?=
 =?utf-8?B?Y3NMU2wrU0NwdUt3TzRndUhqNlJrdXNDMDJRQ0NjMFhPazNCbk9RaVM4d2Ry?=
 =?utf-8?B?WjB6NGpkaGMvYzBnVFpQaVFBMUx6RUN6SE1mMkZwNXdEMEU1NFFWR3JSOEh1?=
 =?utf-8?B?d3QycEFIVUhJeDlScGhzWUpHMHNjMUdQK0lDTEd5MkhMK0FOcDRENlIzdXNT?=
 =?utf-8?B?bjZPejY2dXRoZ2pVS2xGMW04MWo2VW9rc1drRXJwaGVRM0JCOWYzdXMzblAz?=
 =?utf-8?B?dmJSZDQrVU5TMDFtZyt2bGszR1ZGS01IQ2UxSXpSN0lydXl5TGlyMVZLM1lr?=
 =?utf-8?B?L2dodWdjN2h2U0oxRUVWc0tQdkhCVGF3WFBmeXpObXo5MUMzMGprRTRkbmRK?=
 =?utf-8?B?a1VnbENtRmc1ZlVndDNHeU82SDE0UEdBNVFUQjFEbkkwUjZsWlZ0a21IY1ZE?=
 =?utf-8?B?enU3Sy85dTJOZGdtbzFJMDVXRUpUWmE0TkpONGR6a2F1V1FxaDluOStFRWxQ?=
 =?utf-8?B?YW85RTRHRHg2SHJwZytZU0N3S2lidThCblFpVlVYN1lKWHpnSURRMTZpQnJ4?=
 =?utf-8?B?dTAwcjVKZ0VzOFlJKzNrNmVEZlBHamhWdU1BallRMFVwak9TU0J4TG0rd0xX?=
 =?utf-8?B?eW5lSTJUL28wb1k3N2FhcjF6RHZ3L2R0elpBSzdUeVR2eUwxRFVOcEVzc2x0?=
 =?utf-8?B?dEJSLzRTWmxad3l1TUdCQThNbGV5eDJ0T0NQS1EzTGtXOU5UYTRuaU5ycU96?=
 =?utf-8?B?M3M3MGd4UnR5SUwvMDdCeU0zQldYS3dOU3VYVk5DTGpQN2p3ME5Fb0todjJz?=
 =?utf-8?B?THRNWCtudkNxVU1obzB6dTRtVVpYSDZwQmVNR2loWllBWTc0ZlNTNGdhSzBt?=
 =?utf-8?B?b1hpcTRVcFVQcUhMaHBtdzZIc0pCTm9iRVpJVTluZmRxQ1lYU0NLYjBncDNw?=
 =?utf-8?B?S1VyTzJCdGJvME5iRWprMXVFOTJGOCtvMGZGb3ZnZ1diV25HR0ZPd3J0VkFu?=
 =?utf-8?B?SVRrajBLWnNpbDJ3WFJHMWhXQ0tLWTdZVjIwM3ZOblN6R05pNUJBcGV3TExj?=
 =?utf-8?B?U3FXSFJBK1RJajl4Y3VDT0pXNllsTk5iRWlCcGxNTjU0UERIeUk2S25oNldt?=
 =?utf-8?B?dVNMRS91TWRCSGdnQXJHdVpEMG1nUkNlL3c2NmQwV0k2Q1pHMThSRmdZcmRy?=
 =?utf-8?B?RHV0OWcvRHNNVGlYM1dlR0kxdlNkOHR0Nk1MMlNQT1pkcXRSeVQ5VTVKTVF6?=
 =?utf-8?B?WnIzQVBNTklRYU5iY2RRY2pwYys3dERkS1NOMUhhbUd3SGl4cXd1RlJFWXA2?=
 =?utf-8?B?ckJDcUxxRUZacVFQMXU4czM5WmRXNG1Ma1JlRUozM3hkYXM1b0FTemZJWGgx?=
 =?utf-8?B?c01rZ2hyd2lJckpsN2ZYdSswNllrY205YlZSMjJaR21jZlBsdWVMQit5MExh?=
 =?utf-8?B?VVh5cS9BVzc5NkZuYUJSMkxCMW5HWURUWlhQWC94RXpyN2tvWGZqS2x1TDIy?=
 =?utf-8?B?eFFPYll3dnQ1SjBUczRJaWQ4NzVKQ2gwUmlzUjAzQ0MvNkxseTdvNXZ2SGJo?=
 =?utf-8?B?MlFEMG1LWHh1blF2QlZkSk0yVFNLcytzU0hCbVRxRERUZE9LWmhuNEJOaVRE?=
 =?utf-8?B?QmtyZS9xZjJoU0Z5Tm04UHUwYXA4Z3UxVzhKVzJUUExCRWthQTViSTFLRzIw?=
 =?utf-8?B?dDkzSng0V0hjcGdOa2NKdy83M3V4Ulc5MVdDdGVPMnFZanN1ZllDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e605a490-2b12-4d9b-30f1-08df36817a22
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:29:44.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URW1hj3q1wkAXnXg6BOJhHqROYF/oT3v9OLkC461FGqhwnvQHfpujtwqwFPLIg8DmlczNT2gbhqmOniLH2EHkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> In the ACP top-half interrupt handlers, amd_manager is retrieved via
> dev_get_drvdata() and used to schedule amd_sdw_irq_thread when
> non-NULL.  If an interrupt is already in flight on another CPU when
> amd_sdw_manager_remove() runs, the handler can call
> schedule_work(&amd_manager->amd_sdw_irq_thread) after cancel_work_sync()
> returns and after devm frees amd_manager.
>
> Disable SoundWire interrupts, synchronise with the parent PCI device
> IRQ, disable both manager work items with disable_work_sync(), and mask
> interrupts again in case amd_sdw_update_slave_status_work() was running.
>
> Fixes: f93b697ed98e ("soundwire: amd: cancel pending slave status handling workqueue during remove sequence")
> Closes: https://sashiko.dev/#/bug/linux-ab458b2e-f505-4a41-8238-a93ceb5d9c77
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 1d8a08bda261..f39f4f04db7e 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -8,10 +8,12 @@
>   #include <linux/completion.h>
>   #include <linux/cleanup.h>
>   #include <linux/device.h>
> +#include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/jiffies.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/soundwire/sdw.h>
>   #include <linux/soundwire/sdw_registers.h>
> @@ -1199,8 +1201,11 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
>          pm_runtime_get_sync(&pdev->dev);
>          pm_runtime_disable(&pdev->dev);
>          pm_runtime_put_noidle(&pdev->dev);
> -       cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
> -       cancel_work_sync(&amd_manager->amd_sdw_work);
> +       amd_disable_sdw_interrupts(amd_manager);
> +       if (pdev->dev.parent && dev_is_pci(pdev->dev.parent))
> +               synchronize_irq(to_pci_dev(pdev->dev.parent)->irq);
> +       disable_work_sync(&amd_manager->amd_sdw_irq_thread);
> +       disable_work_sync(&amd_manager->amd_sdw_work);
++

The synchronize_irq() approach is incorrect for this hardware. The
ACP IP uses a dedicated line-based interrupt. Using
to_pci_dev(pdev->dev.parent)->irq gives the parent PCI device's
primary IRQ, which is not the SoundWire interrupt line. Synchronizing
the wrong IRQ does not ensure the ACP SoundWire top-half handler has
completed on another CPU.

Additionally, disable_work_sync() is not available in older stable
kernels, making the Cc: stable tag unworkable without further
backport effort.

The double call to amd_disable_sdw_interrupts() is also unjustified —
the work handler does not re-enable interrupts.

We have addressed this race in our upcoming v4 patch series using an
interrupt_enabled flag checked in the top-half before scheduling
work. This is the standard pattern for this type of race and has been
validated on the hardware. Please drop this patch.
>          amd_disable_sdw_interrupts(amd_manager);
>          sdw_bus_master_delete(&amd_manager->bus);
>          ret = amd_disable_sdw_manager(amd_manager);
> --
> 2.56.0.317.g454f8302e1-goog

