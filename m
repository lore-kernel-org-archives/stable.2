Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793364976;
	b=2nyt/dlP7id9UiZ1XyDg1JMqPyxX9LaugcIAJhbRHG97xF/39ekjqRaysQbVQ3bwuxFS
	 +ksfMGWb7ivXx/NjA8FXjABT/JbDkl4gQ17/Or0uoYh3AJM083KBTuzRAX85UcGTVvUAE
	 jRxSZZuLptUCrfQekjFLQ4wuyGYiZMhM8HO6o5Oo+wPkC0SUTXneXmfpImAM5z9+n+fAM
	 LlEzyEnBepQu0FJS+69jUk1Kxa66oZ2dAhQ9dQ5b/c7IA+BhNxrpoGSwuFtrcS5hCjixh
	 WoBlBVrRwnfLc3rniOLSmMO+V1bn1OC5ZaqCOV8XsFEyXA/R0g06fGPRwbYBEXy3iIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364976;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=8NWp340E2ieZb6QzmBX/dRB4W192AcOmDj/AcOt++uM=;
	b=Do4bfMe8QH7SumuN8n9go891IeTWtttl1nlCPiOI7RRY5Fpm8uUN0vYmMUK9syMFed+b
	 fxOwQKo5OvedjLWtgO/IQkuOBJ8L7kYRIQzNDR4Nx33otxtOpmHQ73JGAW+Iq//o8e8+x
	 KtwWRCOSA4sun8J+rM2Uki4ededY0Bl8b7KBa8m5YQP7pVbbke/ZEaPCG1QGdDQg8yjBt
	 C1BM8j7++LH7Zg1GYM/9UuCPn9D8mx8fLQk1W2n3TNsXXouKlfXfXnKoNMPz1lj0BVpc3
	 JDUMHyeQAWEksaYgNb9A8Jv1Gbl9RPB9dg7DO0oIUZ3QCegpC8HpOAeJJfmRlKFFpHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UbGCm0eU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.11
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC712606A31E;
	Fri, 30 Oct 2026 12:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC712606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UbGCm0eU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evvsyQVY8IbUJ/yDE1RByeh4zIl2a4O/+0DU8qgpE+gigp/vho7+HPQbnecwV2bTmGBurzhBcHvhuB4CDYqyGm4bcrTNP6yflaS4j54tn6G3z3luiueg9P4qLdlGssQObiFLJ1KB3zzNB7ns4o7uQ6xbBmqKC67g2Z9GS+HoG3019yTQB5ky7Y2ntU5As9aZu56pCuIA5in9uxq3cb+CS8CKtdjeG/qpUsMKF7Hy/J4lHew4cPaTyfL2fANqQSzJOeY7cjku65hcARlgS7FcDnMIS0Gkho6mzxue7lBq223RsQaS0liTTMarkaRj5q3ePqi0lv6COMZrVzeiRodDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NWp340E2ieZb6QzmBX/dRB4W192AcOmDj/AcOt++uM=;
 b=MlqAZ6jFfVDscro3slNCKNJxIsf0NrLNVp9Yd2SS4Fe6UoA+EpnP2Dmf8HJka0ZI2lb5TW25kanI6WnAVcWFcgcl8dZ3JETGWm02pb1wSFUPaCknxTQIP9pcBMQx/O8b53ujSWvtEvQEhbpUHiORYzUcOZMgLJCtbx7/HVIc5YNZptStljiAcXct7o85hXNHuwyhaN0gsktqBfECIxHWnJWNycKGh4CFMpJTNSgMNQ8RYlBABR3zx2+XFWWGDakMJvG5HhlskVjCkMgBvegx+q4fbUnWLRsISV4vXe2aaFLGLBZ0eVCafcWZY6tT+p6n+2G/fYqi+V9U3WwFn4u3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NWp340E2ieZb6QzmBX/dRB4W192AcOmDj/AcOt++uM=;
 b=UbGCm0eUILVCXpX7ApkD9qfVcj9m6oCzIijdMqOzlaOSZaxSy2S2PTN18x8imGyEaaspdwx1NGL4mhtYgSBt0f2r+g1L+SDKh7cq8qD5BDB4XhUEUwQt3SI/kfqxBQfJH44IFF8nBTuYDtIkRPrQrCpf3ruAEmt5YAqu6i3tUFg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:56:13 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:56:13 +0000
Message-ID: <fa7230de-7c4f-4c27-93e5-d4145f10dc53@amd.com>
Date: Fri, 30 Oct 2026 18:25:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] soundwire: amd: Check clock resume timeout in
 amd_resume_runtime()
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-21-lee@kernel.org>
 <55ccb8c9-9d11-4c22-b17d-a31746ea4031@amd.com>
Content-Language: en-US
In-Reply-To: <55ccb8c9-9d11-4c22-b17d-a31746ea4031@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0063.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::12) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 800bb541-bb37-4906-c624-08df36852ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|921020|56012099006|4143699003|11063799006|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wbNuC565UeJOEKxFeRkbC/tBOIwZupt2jSbwNn5gyduZi+HLpZUC2lYf4x3kAaLVcpyQcWDfiYi52nVEVnV8A/qqM4Z3EyyZO1fmTM4pCBbl8S/mN62abmTzly5JuuAZpQuaAuX3K/PJX0pijElECRhLEjWK84vKfPUA7A2QrLZD6ToDWtkCGCzyWHfSdmzQKT8BWkJKoNDJLJQWoJcT84cbL22sQ84iMqmuUFEmZBzHkb2wNFxHsPjOqL0oxJ2Ki4Ojrpogx/rvC0KQH+7lZ3cwha/vnNvaBYAYXFgHPs6pz1BgKjIGR0ncXs0uj6g2y1Ayki2VBoarHlxmq+BRJVHySWwoA9kjf/PuxPfpP9Vs+mdVOy1e0FmHmiXfi7EkwEBudMPFHpDFQ3JVOV+8c26xHpzvU+bK2XXd+PfenUGm/kq9aD6s4J5gbXbZGE3n3xOoHMdB4xbt2zu7U9IGQ5TNdJzC1krygqxzEnDx69Xjk4aDVu5UMR5TRDevMLvbRlDvi40fo6ZzE08Qr26aUPHN+0KQvYMxdhjDx4IPaLVOS9aig9pfC3nN69gEyjxeJlM6XYV9KXGmAA6i626i95ipftPSrbMl2iYbSO8GWf+o3eU2B3LL+Vx9Tn9D5lgqgY0hslTiocRKkye7XAhpZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(4143699003)(11063799006)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWlHRldlRjY3b0Rka3N1RU9hMEVGN1NiS2xMYUFRMDBNS0ZIOXA5bzFJRWNM?=
 =?utf-8?B?bExnb0kvY3ZVS2QxTEk2V0wra1ZLbFArQndleVdFL0x4MitUQ0dPZ2JOUGo2?=
 =?utf-8?B?Yyt2SCtoTnFIaXdGR3pIcUhRTmZ0anZHYkxUMVhkb3JSdHkwWVpWZEdSUmta?=
 =?utf-8?B?QXJLRzRqT2F6R0g2cVNmRXNMZVFCT3c4Y3pFdUViL2ZNRnhpZks3c1FOb3c4?=
 =?utf-8?B?OUlDUnlwcStXb2ZWc2RUZmhQNEZ0UCtsd0w1WUU2aHRFYWNvNzVob0d1Q2JT?=
 =?utf-8?B?a1E1bzRQcG5aSElKS0xzKzF1TURhbUxkaUU2TEV0K0ZjR2tVNkhJaWcvRlAw?=
 =?utf-8?B?WktRd0xHN2o3MTRCNHk0Z1p2Q3BabER1am5zWDJYTDJ6RG9adTBCVTB0dFB1?=
 =?utf-8?B?VG8vWlZjVk5JODNSU2dsSmhONjU5d1RVcmkvbjJtM2MrL2FqKzR6RUZQU1lp?=
 =?utf-8?B?aHl4TUg4RUs1aDNTQ2xqOXFkbW1lSWtsRlRrcVp4dDA1VG95UUcwV2RRWHBu?=
 =?utf-8?B?WEQxYVp2T2lEY3BTeElxRjlPcHo4YTd3U3hNTUh2MnRkWTdkTWZTYVJHVHpu?=
 =?utf-8?B?dTZ3UkxwKzYwR0R0dWgwRy85N2ZrS3RIR01XdUQ4OU4veWZhbXhxUVFtbkZ1?=
 =?utf-8?B?MzIybVpaRUN5NzE4NnN1TUxjZkxKRnF1bHNrNTFiamozb29senRsQ3d6OFJX?=
 =?utf-8?B?S0M1TnFCYnpncDBCZUJSWjB6UXd6M3doWjYyek96RnRjK0N1YmJreVVyd2NL?=
 =?utf-8?B?d3h0T0xMRnV2UjZwY2dzS05nNXQ2TVBlbEt3N3NieFUvU3JOejZMV2IxOU56?=
 =?utf-8?B?ZWxSakYzZWVrY242STFrSFpuczkyS2J0NVFxU0RRRWJYMlQ5YXg2MlFpUy9D?=
 =?utf-8?B?b3ZsVzBIMERMZFcxTDJFNEREa0g4MUhTeWt1Y1BjWU95cnVHYjNkeTJZa2tn?=
 =?utf-8?B?NnkzREFhVHlzSGFESlBCTUpwQ1I3RXBxRTlGcU9SQngwVkNDbDIxeUdVMzI2?=
 =?utf-8?B?ZEJHdXpBYVdCQjFsb09UKzk1c3RMcjNXYTdEWDV0b2tCb2w4NjJremNvRlZL?=
 =?utf-8?B?VHJhSzFZTXB2SXpBUmpoRXBUVzNhR0JiK0QxS0lZY2F5NXBCcDVDVnIyTjZ6?=
 =?utf-8?B?TTI1UEpucjlLNDQreU5ZWjhxb1N5UlJRVFhRYjdrQXhFd0hhSXY5Z3dBS3Zk?=
 =?utf-8?B?dVNrZmw0b0VIanZ4UU9XL3g1MUxZZTFZVk9BMHRUcVUzWGJTcVNkc1lmUlA2?=
 =?utf-8?B?WVhuOHAzTE1WRXFQS1htV3JUbzVxa01aOS83NmplSStqTzZ0eTN4SCtiMjRl?=
 =?utf-8?B?aFluU0htSTc4ZnZPbXF6b2xzbGtzK29kTmY3bEIxdzZjenB1enpwbnN1UzRG?=
 =?utf-8?B?SWkxUCttMUtkVHRLY3RRUk92WlFDL2NqL2tIT2ZPN1JjRTcwWjluYm1WaWhV?=
 =?utf-8?B?anhrWEFIanVvN3NTNVFRTkZYR0phc29lam9HVVU2V2dpVkJMb0J2SlhhUUlZ?=
 =?utf-8?B?SSt1bTNvVWlHNUFIaHdWUnN1a2YvNkZlcmNyclN5RXNIbzhSL204akQvVEdL?=
 =?utf-8?B?Mnh5L0I3dnMxelc1UGV2TXlVcE4zbE1sOTVJVUtvV2t6ZjMra0ZCcU5WUGZm?=
 =?utf-8?B?UzYxZUZMZTdmeWZoOWlNNGgyRjRoc0hYYy9Xa1RYRyt3bzRkanNtRWVNNzk4?=
 =?utf-8?B?THRQaTdGQU1Yb09hcFRWVlBoMkRZWmx1VnNIa2ZaMXI5M2dzQm12Ulp3M0JU?=
 =?utf-8?B?VWI0a3JXekRTQzh1RnFiZEFBbUQyVE9CQkxtRktLSkZVRG5vYVFPVTZwcUlt?=
 =?utf-8?B?VldPdFZ5eXd1TGNFWUMrRmtXNnV3QStDZC9jOC9MdVBTYWZ1NnhSdzVoR1hX?=
 =?utf-8?B?a2pRU2YwMzhPa0VXbjUwY0VGdGx1VnhmeTFWTUdNL2wwV2xkSlUvK25QUUdu?=
 =?utf-8?B?eUMvaG94amMxdkJEbHlxWGFqdmxkWU52RUtNRDlpZ1VtcUFDNHE0ayszNjJ3?=
 =?utf-8?B?NXBQS1BMU083OWw5U2pOYVVXZ0lESmxYMFlyMHRPeCtLeHJzczhBbG9RSGZ6?=
 =?utf-8?B?UzNZa3lRclJsU1AxYmpFWG5KdWFpSUpCV1UyQWdTMUlqYVdnTjdGT2p2WGs3?=
 =?utf-8?B?TVJPSDBkRXBNb3VhRkRrcG40aWdFYWxGdENwcDVkejd5MjF5bVhTd012ZUFI?=
 =?utf-8?B?bUE3ejlJSzN1YkFrSXhaa0Nrb25ucDhHQ2lXQ3AvRElWUmtrSG1KeDJrbHVp?=
 =?utf-8?B?eHp1eWNHOUFNSnR5bFlOQzgwazVFckVhSmNQUjlPTS9DTG0vSzBYcnFDU0tL?=
 =?utf-8?B?WU12YWo1N3ArZFZmRTRnTW9pZXVObUpWdTZ5eHdYVXFaVktHbEZMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800bb541-bb37-4906-c624-08df36852ce5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:56:12.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGDrlN8A7vAW8WFwJlcPCv5oXuPwZOhwM1vL8otZR8N0MsJdPGq6uGfB2CS9bw1S3vEZOIJZ/8NJ9mqECLJgLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744



On 10/30/26 18:21, Mukunda,Vijendar wrote:
>
>
> On 10/30/26 16:16, Lee Jones wrote:
>> When resuming from AMD_SDW_POWER_OFF_MODE in amd_resume_runtime(), the
>> return value of readl_poll_timeout() when polling for
>> AMD_SDW_CLK_RESUME_DONE is stored in ret but never checked, allowing
>> resume to proceed even when clock resume times out.
>>
>> Return ret if polling for AMD_SDW_CLK_RESUME_DONE fails.
>>
>> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD 
>> SoundWire manager driver")
>> Closes: 
>> https://sashiko.dev/#/bug/linux-c6360b30-11b9-40a1-ab04-528462af313c
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> ---
>>   drivers/soundwire/amd_manager.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/amd_manager.c 
>> b/drivers/soundwire/amd_manager.c
>> index ba8e6d42c467..faff3e9eefad 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -1494,10 +1494,10 @@ static int __maybe_unused 
>> amd_resume_runtime(struct device *dev)
>>               ret = readl_poll_timeout(amd_manager->mmio + 
>> ACP_SW_CLK_RESUME_CTRL, val,
>>                            (val & AMD_SDW_CLK_RESUME_DONE), 
>> ACP_DELAY_US,
>>                            AMD_SDW_TIMEOUT);
>> -            if (val & AMD_SDW_CLK_RESUME_DONE) {
>> -                writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> -                amd_manager->clk_stopped = false;
>> -            }
>> +            if (ret)
>> +                return ret;
>> +            writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> +            amd_manager->clk_stopped = false;
> ++
>
> The bug is valid. On clock resume timeout the code falls through to
> sdw_clear_slave_status() and full bus re-init without the clock
> being active, which is incorrect.
>
> However, we have identified additional issues in this code path that
> need to be addressed together:
>
> 1. writel(0, ACP_SW_CLK_RESUME_CTRL) is incorrect — this register
>    is not a plain zero-clear register. Only the Clk_Resume_Req bit
>    should be cleared using a read-modify-write on the success path.
Slight correction.  Ignore comment 1.

>
> 2. The same unchecked ret pattern exists in
>    amd_acp63_sdw_clock_stop_exit() and needs to be fixed together.
>
> We are planning to address all of these as part of our upcoming v4
> patch series which will be posted shortly. Could you please hold
> this patch until v4 is on-list to avoid conflicts?
>>           }
>>           sdw_clear_slave_status(bus, 
>> SDW_UNATTACH_REQUEST_MASTER_RESET);
>>           ret = amd_sdw_clk_init_ctrl(amd_manager);
>

