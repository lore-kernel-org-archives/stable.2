Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102548;
	b=KIltDVanx8tE34kuwOTx2YyH4HGG7Di46Stj5DFJNBuHuPQXk2twnbbyaEwNu4Xz6OnO
	 Vh13GhsoEHi4IrSZzluVTuwfjXI0QhqR18RogW5araKN/0wySxOdAq04HToyRNNTBDBVx
	 +rECKT1xnGIv5VdcokcNrdl7etLVGeCqHjGXisPem+wHmDYZ89fqS/oElDG3ktV9qN4Em
	 JD2cBDE5EWw8BiQYhkEIJS3UgWSAJOG8O5TTcyuVD1BoZXV8SDShayJ+jINk+z1sz6M91
	 fuSjF36RQZmwAYGVwxOj1Lu3cPLhUgx8pXBT4YeH1N+qNryOaYiLyZxhfxSsG7En66g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102548;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
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
	bh=GdnELN3IONQfxHzKfFFKbVozGIUxDCOrqOJCBiA1WlQ=;
	b=v9TAt9+wFb0X7PrFRx04PrFWwEWyoXOSrjwquDRx9sbYr+6KQD497lYPA42ggT1I+PSF
	 bactGEDDiBBRrkA8q8Hx6blJFNROcd1Wg1qhsOXjlhpQ36drIPIDbfg67GifPXciaQ9H2
	 A3Wn03rU3mCgZFJKC31kv+cjxK3+kqcBXzQRUuiVucJBAhqQYmjkcRNr75555vobs4KSP
	 /onRAIK+C/nyXXFZAIToUzv6/kr1Dec33y/aTs7kf4w89FmkYz649ZgKLfJLF2XiGMeDX
	 +K0Y5UmKg0WD1IwexJRDr4FikNVwWcN2Qt9kAP8xyWShgwxZCamVhBclDmQNepCGYUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OolGNOpP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.6
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7534606A33E
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7534606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OolGNOpP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY6s5iUsFRxhX92mBOGo4ZKlZXQuDPD6SbEyhTa8WjPKKJK1Sws7s0wf+hOJ4KwxxyetFPPlOggXon1/qmZ+QKwQKTfgi1zRq07cyw4YKRCsvTFu6V9OwfpmyQS9tDbloXiwOAcdFbJPeKlTKP6PanMORt8C9KL+cL/NUQHsf9Jb60BK6rTDBzkrIn+tqpipHcUGu8pbX7fFYwL4c4aVHpLMjZ7zvlxG0UVTDezcKjXnRRmrLNb3KKFsqjuAi81Wkb7vmCvhuyJeG98GIcdL2hvXb18EDIlE5xdjqN/+cFNvnv/1T+OB3xzonFwgHM36eN0WPoFvTCmQHSkrmJHrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdnELN3IONQfxHzKfFFKbVozGIUxDCOrqOJCBiA1WlQ=;
 b=feNLaa+A/RC+YnwejGKFqKo2I4x7XRctpjEOXcQJqRnEAtsXqJyjsCha0G/eP9kOJhgVu1Ba+xS0LqiPZKeuRMANZ9f5F5dgdax8pxR4UdMWvVGirktPtWju+J4MF89pd4B/9JekNW+AEpCKKC8By+SxsCmRqOlo9HnczY7pUw41opoxEQU3IsVvuZwkIsAfnzXmm/aYBn1bLguBMSDEk5y6iRbQAr6I55wrusX4wfc00jByXZMtdz6jw3Pu1SiIcdq6R0OkmoDuDOLueACkECp3it2ySacajqhndgb9DJMs7Q7Ak1Hk1zaWhoYKMw961EHuZBkfm32ijoUgMRKtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdnELN3IONQfxHzKfFFKbVozGIUxDCOrqOJCBiA1WlQ=;
 b=OolGNOpPwS4j0n0RYq8WzYO3wcfNk/dSMYWGpCxVuD7ax10+P/CxXCT3BzERHJE42nnPOFSjNByHHGWMuyqs5qQKg0Tt9ANeMDGr3GF24Dz9llE8Ck/oSd4/+Dye/1KqTpLW/SvOU9xJP/K5eyQcng24G3bFDdQa41bDj7fK37k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:35:42 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 15:35:42 +0000
Message-ID: <bcbf45b3-6921-4031-83a1-0d2591db50db@amd.com>
Date: Thu, 19 Nov 2026 09:35:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: track BACO state in the SMU v11 ArmD3
 sequence
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
 Nathan Blomquist <nblomquist@gmail.com>
References: <20261119141944.2994497-1-alexander.deucher@amd.com>
 <2026111904-gloating-share-b28e@gregkh>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026111904-gloating-share-b28e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:f2::22) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 857f05c4-20cd-486c-f761-08df4652c4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003|261028144727099003|261009223027099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	UjsbQlLqRZLBj8xHGosKslAmWCNj7dOu8BdkmML4kBC8c4QAgZSDijkQoTstOxBw6U4oALxFN/Trq4NBFXD6wFdmcFQSZSc6NFe+8MWoMv0tD2utdPMWGwsS0WCghfFJd5hrMw/zD9X/obX/85/C1/73licI2nMS83oW1q3Qb5DF10enMa2wAd00A0RUT6Z7arId20l14Jzkd702Yl1A6QXo2kESLgOK9zPtubQ6WDKrnvsuyE/YHVfSr/TFIundzln5ircl6DqXi6VvcHdsnpUBmnn0THgqkuCSqX8/JYJwEkSFMMMdERF9Avi7Fu9pnU4/eiER2XS1c/oGYaS2I9SXl7J+Rv9IxSPtL7zl0xNCknmuxmkbol1sRkZgThRQuOIzffOjZXxhb8yhNH1hme/7rywS6zPCLZjz4KwcKiJtmy7A5/eIZHFTEopL4z757mKMXtz76UCX9gSoIoJiDSeVjD7ZFKrzfFYL0A56FvhQzNRuG/xVkmTOQuNUB5Alkljw5JEQhnx/3767Vhr9NXKKK318oArJhqbAo+8/d/crlZm+t5q9hwjXTKit6FK4l+i+0ar8Dqwu7Ejqn7l0iAjzTSWn5GQMV92CnU1feIzf+J+KEIMqINea0mr0Bcz4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUVkNGhwOWJKMGR4MnZFRld0TTcvczVaUnorSDZyd29XYkREaCs2eE1yZWdR?=
 =?utf-8?B?U3JYV0wwMXNsblUrN0FDRXdnamJUN3Jmb2UrbDZ2MkxRY2h6UG9Hc3liYUJr?=
 =?utf-8?B?ZTBrSEhZYVpTODFWbTNvdDNHQjlyaWFmb0ExeFIzeHMrdFVQUkZ1eEhWajR4?=
 =?utf-8?B?Zm5VQTdpLzN5b3hyNTU5UVNvQUpTWHdWOGpUWGRaVEQ4Z096ekNnSWwvUWMv?=
 =?utf-8?B?dDhBUnJUSVZRS1JkS014TVpKK0hjV0JvQS9NMDBVTGhyd21rQkpQaE5JdFBu?=
 =?utf-8?B?T0o2N0ovenYvdWdjaEdkYnUvWUYvd2NsZFh1WDZ1aVh0ZlM1WmlZUm9FZGIv?=
 =?utf-8?B?RktjR1g1U3pHK0FEMXlTclIwdnhFODFrK3pEdExOTjg4aC9qNCsrWndhRGJj?=
 =?utf-8?B?Q3FIVy9RZkw1V0hRelBKWDZoaEhncUg3UXJxYzczNUllcUVWNzVaVTk4UXhI?=
 =?utf-8?B?aVh6TzBjOHArN0NoMFZrdW9OWlYrSHRpUkF0UGxVVURNYUs2TDRBRHdoNzdQ?=
 =?utf-8?B?V3IrTjg2WkQydndHN3dvd2pkSVpjeDYrNFhZQTJSalhOWHZBZy9lN3ZBVm9I?=
 =?utf-8?B?THFGa2x0dFVZVDNTY2I0d3BIN0t1bmgxNGxIbTFuVnA1ZGZ0eFYyUXg4YkFK?=
 =?utf-8?B?NzFlUHVpUzV2WGZZb1VpSmt5VDB2c0xRczE0VTZRdXhJbEVxZkE4MytHSmc5?=
 =?utf-8?B?ZEE1K1Q1QjF5TzQ1MnFsTllrWEJvWlNrTzM0SjVqUFRRYnVuWXFGM0NTZTVh?=
 =?utf-8?B?a1Y3TENSVXdsdHBlVU5jUXcxWmlpN0JWNDRUclBBMzF2N1pOT1ZjMzhPaGY0?=
 =?utf-8?B?dm0vSGgxbERNWHM3V3duS0JSdjkzd092c29FZ1VPUktvR28xL1B3enlhMnNH?=
 =?utf-8?B?MzE3eE82ODlWdHh3YXJWVU1MalJGem9rb0pwd3BoYVQ4RlM0ZGx2RFE2Z05w?=
 =?utf-8?B?a2NtTEJNTWlvU1RKRHJnTlRtTlZ3UGlwaG0rVE00NUhFaUpoUW1QZHhyYUcr?=
 =?utf-8?B?T2VyMmRDZ25yZGRoZFI5OUtwMUM1VEpuWG94UDlwMUJDL3QrTko0M1poTFUx?=
 =?utf-8?B?ckt2NmdCQWNCKzZOS0g0UFB2a2MyL05NeUZHKzZyVlpZdExWUmVEVXovQ080?=
 =?utf-8?B?cFlQemZMY2k3dUtpWW1DMWFXb1c0K2FXK1c0YklkQk1BR3FTYks3MUEzR3p0?=
 =?utf-8?B?eDk3WHNhdXlNM3J3UVloMnQzTVhMMk5qcC9Hby9oMXI1WmpHVTBvdDIrUFVi?=
 =?utf-8?B?RmowMFRJSSt3U09lSUlVZFhZR21MNG1JZlh2di8vUnRYNktNWXc5Q0wza1Zj?=
 =?utf-8?B?U2VSVDh4bE1CRHR0WGFidEFoVWhCcTJwem03TDd4VTFDclVKaVVrbDlKaXhV?=
 =?utf-8?B?RDB0MmhUeDZvSFBMdlJnUTJTWFdoblI3TFZ4QVJaRFd2WHJZcHdjYmMzM0Rl?=
 =?utf-8?B?N0p3Ymk5R3lQb1ZUYm9EV0trbElkQWM1aXJpRXdhRm1nNkIxWkNyTm8vMU5F?=
 =?utf-8?B?UWowRDVjN1pRZGFJT3pScFdNMUtEb05nMHIvb2dWTHRMRW14MGxGOHUzckVu?=
 =?utf-8?B?MGYzWUNFbHJ0RE83M2dSaEZXbzZHaDVJYlhNdWhuOEVGbGF5akcraEtDdVhm?=
 =?utf-8?B?aHc4SVBOdEE2cS9LWnAzNWt1ckdqMWFjYkdRSVFUdGtMbW9KMkx0N0VzWkNh?=
 =?utf-8?B?SitZYmhFY0xyMjFvdSt1MlpNd0wvbThxajZhMUxIMUFHQkE3RGlJRjFKNDRL?=
 =?utf-8?B?NS91SUNyMVNma0lrRFEzMGZzZ3B0dzFJcDAzSFlQbUpESFZHVGNtNkVBZnQ2?=
 =?utf-8?B?UXAzTGUwUzYwaVpaczhDN0l6T0xvRjRCT01Rb2J5RUtMblQ5cU5Id29NMnU1?=
 =?utf-8?B?WFgva2RtUEUrZTByZHllR3VZN3A1UTkyNUtpa0ZpZXc3ckdtbXh6V1VxR0Vs?=
 =?utf-8?B?OVNMSUIyNVE5WWNQUHl2d25OWC9LWXNQVUNPRWRjZHlxeWk2TC8wUFZISmla?=
 =?utf-8?B?S0F6aGVCdlFRZFJNLzNKSm5SUGlvN01wZHhCUDVWc1RWbk9ESGhnWmMwYTYx?=
 =?utf-8?B?ZUNQcVNRV29RR2hLM3dpcUl3NDV0T0JvVU96eVdEaFZrZFhjWng0V1F0VVZB?=
 =?utf-8?B?UzREVS9CWU5GSm9UYnN2REtNV0ZqRjhIRThJcGxGVG1FeGNMaFVkeWZHZWhJ?=
 =?utf-8?B?OE14SnJZZENTUk5yUGNrMHFHVVlwMUgxdlZhL3h1dXRjcTFRbmpoM0pBUk9U?=
 =?utf-8?B?SlczcFJ1ZDJlNE5oVjZPeE1pNFo4R3doaGVmWkxodlVkVUkrKzZmb2N0bUJt?=
 =?utf-8?Q?aDqHCijzpY9oqPw+EW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857f05c4-20cd-486c-f761-08df4652c4e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:35:42.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdcI4xEQradNIyFXmabYf7VEVKV19JQcl30vzNw9GkfO68ZGg8zyQfqB3KqPz9wO7J2IhzjPx4pIKx+ZUoGzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766



On 11/19/26 08:22, Greg KH wrote:
> On Thu, Nov 19, 2026 at 09:19:44AM -0500, Alex Deucher wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> On Navi1x/Sienna Cichlid with runtime PM, when the audio function is
>> enabled, BACO entry and exit are delegated to PMFW by sending
>> SMU_MSG_ArmD3 instead of going through smu_v11_0_baco_set_state().
>> Unlike the v13/v14/v15 helpers, smu_v11_0_baco_set_armd3_sequence()
>> does not update smu_baco->state, so the driver keeps reporting
>> SMU_BACO_STATE_EXIT while the ASIC is armed for / sitting in BACO.
>>
>> At runtime resume amdgpu_device_baco_exit() checks
>> amdgpu_device_supports_baco(), which ends up in
>> smu_v11_0_get_bamaco_support().  Since the state never reads ENTER, the
>> "already in BACO" shortcut is skipped and the live BACO feature bit is
>> consulted instead.  PMFW clears that bit once ArmD3(BACO) is armed, so
>> the check reports "supported but not enabled", the exit fails with
>> -ENOTSUPP and the ULPS ArmD3 message is never sent.  The runtime resume
>> caller ignores the error, and a later secondary bus reset leaves the
>> device unreachable.  This shows up on a Navi 23 being handed from amdgpu
>> to vfio-pci:
>>
>>    baco_enter: in_runpm=1 audio_enabled=1 armd3=1 baco_state=1 ret=0
>>    bamaco: state=1 ... feat supported=1 enabled=0 in_runpm=1
>>    baco_exit: supports=0 ...
>>    runtime resume: baco_exit ret=-524
>>
>> Update smu_baco->state in the helper, mirroring the v13 implementation,
>> so the capability check short-circuits while in BACO.
>>
>> Reported-by: Nathan Blomquist <nblomquist@gmail.com>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
>> Tested-by: Nathan Blomquist <nblomquist@gmail.com>
>> Fixes: 13d75eadfa1a ("drm/amd/pm: correct the runpm handling for BACO supported ASIC")
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> Link: https://patch.msgid.link/20261103141457.2558235-1-mario.limonciello@amd.com
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry picked from commit d515b2694eab5b35533c7fb7af5bddff53ff60d3)
>> (cherry picked from commit a26ec190925733dd205507493e936e59dbcd2b19)
> 
> Really?
> 
> :)
> 
> What stable tree(s) is this for?
> 
Original commit it fixes is 5.14, so I did a backport and test build on 
all the remaining stable trees and they all worked.

┌────────┬──────────┬───────────────────────┬─────────────┬─────────────┐
│  Tree  │   Base   │        Branch         │ Cherry-pick │ Module build
├────────┼──────────┼───────────────────────┼─────────────┼─────────────┤
│ 7.3.y  │ 7.3.5    │ superm1/stable-7.3.y  │ clean       │ OK
├────────┼──────────┼───────────────────────┼─────────────┼─────────────┤
│ 6.18.y │ 6.18.64  │ superm1/stable-6.18.y │ clean       │ OK
├────────┼──────────┼───────────────────────┼─────────────┼─────────────┤
│ 6.12.y │ 6.12.118 │ superm1/stable-6.12.y │ clean       │ OK
├────────┼──────────┼───────────────────────┼─────────────┼─────────────┤
│ 6.6.y  │ 6.6.162  │ superm1/stable-6.6.y  │ clean       │ OK
├────────┼──────────┼───────────────────────┼─────────────┼─────────────┤
│ 6.1.y  │ 6.1.192  │ superm1/stable-6.1.y  │ clean       │ OK
├────────┼──────────┼───────────────────────┼─────────────┼─────────────┤
│ 5.15.y │ 5.15.225 │ superm1/stable-5.15.y │ clean       │ OK
└────────┴──────────┴───────────────────────┴─────────────┴─────────────┘

