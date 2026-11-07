Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794044754;
	b=Ij5RsooSwEIs5A1Gukq54AO9Kb1xVxEO8vVWPponI0IZQfWlaBbDhEz8yNF3eGTwzg/v
	 Ouy+gYeZTt25E8+jWxZ3psvvTevlfJ5Oxum21ksV9uEMklcofnr42YfaikJh8Am2jcQew
	 J0xvNYdLCN0WYDSCU54HfrDD6VcTuSJ/wkWDziHFnsfj9gQtT74JyOAKfmITL4Wc3Z2ax
	 ybXalcTQ9zb3POwdtq3Cwx4VV/BVlymYqibryDeZGkEwuSXd9TaMVOM9V8wHtVRra8bj7
	 6YwwkZ9UliiLXyEvHZYj1y/JetEGzKOt3NB+0c7ujOqmA8S/0xorSMLQ6sBVctcaM3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794044754;
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
	bh=DUrlmHNgqTLc1XqD9g8a3Qr0lSZz2Ig3GF17chSN/MM=;
	b=BDrUVe7LJOG0fFyYR8ig9pzrILaFh6x2DjW0qAtg4ZgGV3nfwsdUFMluKzVgt4vUNoBF
	 O7zlt06lnF8cwDr07vypnBeEKqTFH+m403xPN42PrxkEUgxQmkPegGDLJL5EzJx9ASoq0
	 uFAiKdLtl94RyI5KEXE5LO1IAdMU6lor6RY1xGJo/SS9YjtWxmkN2GRnLW3eFgDeuxMjN
	 5vopOjCFak7M8At6kwJHjAPXV90BD20jNog5BJmZR7iO85kxm8chij+emvjHVx8NluEps
	 1qR1umjB+YERIITSMMSojS5weHp/EmGFbH2TtPeF0Vw5IOoEmgyjQ4AbCDproNDyRdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sOKnL0X2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.41
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49785606A32C;
	Sat,  7 Nov 2026 09:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49785606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sOKnL0X2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAJ2qKdHzYYE0NlhhYu41LB2jnP2erBsRWtcTV0SsvRPHLFCT0fHECVozyE96mLSVz9vrll3DWrhuyGQXGPONuO77XbyC06XfIbrQIRxNaAqlURORtGMrXBXsCNJoNY+tbvjH/mZLrvj8ST2dbuj940I+qSc63EQixL+cR57hUilyKBM3cZTFS3UCWLyZrQVIaR6xSIjzBNavytwT1PZZitkJdYV2VddFMS/zVl4uVoh1NuF/6P8qiC9OfYRmDRiv4cqMJI0q1rEkDYT/SqKEnDX6sP2gaZA16iVG5ZDCCBD+CVF8MlesJ45nbzXKJCPen8oGogMiHVvZ7qMPftUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUrlmHNgqTLc1XqD9g8a3Qr0lSZz2Ig3GF17chSN/MM=;
 b=rOZQXUCi7q1/wGh+q1CsIIjTIXDAfZsdJZSNwNNV/M/7Ts0u1G6aqI+ri3xFnHVA2Grz/3WRBGBnsZe6/TcytmJYpaSdiBNOCK1Yxm21/cuaN996k160iNBVV7NJdS22xn1tgcuVlFEHmnW665rHcX8eb0fD88SWeXkdOs5/hWkTYckaKET3nlTrXeYwiJWCYxJZ5lzZlWrIg7xLYPs/xnMFv7Digcz+GR85CPOMV4zAvaaz5U1ApLuWQHE71sUNpojlGtmzfK5JdHhZGBoXvkaj1UmAaZrbv4+1JtgwWVmHbGZw+wmlXIloradOcPS63A5Nt5I+7lUfu84Ky5jLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUrlmHNgqTLc1XqD9g8a3Qr0lSZz2Ig3GF17chSN/MM=;
 b=sOKnL0X2QYMpsv8Ok16izC+Qg3mUClf6Q7Jczq1+fvGJ66/9MQumZwa1nEs/Oa/7njCyft9ZMzXR2hIkye/l0HfzAmSW2I5XEX67qShUJg+9pWJOxxflBUaj2nDo8UKkpCcyWopKyTf8iNcQUCZKm+LX7Uiaj1RMv+KKEdwFr08=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sat, 7 Nov
 2026 09:45:50 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0592.009; Sat, 7 Nov 2026
 09:45:50 +0000
Message-ID: <5e8f4a57-1b88-4e05-9081-6c47bd3183e3@amd.com>
Date: Sat, 7 Nov 2026 15:14:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] soundwire: amd: Disable interrupts if enabling
 manager fails
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>, "N, Poojitha"
 <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-22-lee@kernel.org>
 <48141b99-f1da-4582-b784-864148072d82@amd.com>
Content-Language: en-US
In-Reply-To: <48141b99-f1da-4582-b784-864148072d82@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::13) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e7bdb5-0ea9-488a-2c16-08df3cb3e7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|261102123227099003|261009223027099003|261022105027099003|261028144727099003|4143699003|56012099006|261026140227099003|11063799006|261021121427099003|261021123027099003|921020;
X-Microsoft-Antispam-Message-Info:
	VG9QipuduHXpqm6DKCjhHuVeRIwcENCd5NXsqTHEl9b5Cbh3S+rw/BITx/eJzysNWsj9NThbVbxIiWeDTOA7KHASgJO0y+h67l2hoJ+Vkpm9Io7oZrkAFedPemhxfxOs9LsQKvE3tew0f3832DRJmq4OTbtoJK1E2OBUYFnnbztUHtRJQY7q294S2Wc4dj0Tt3wZFnmFDebEad2pSjbZFqj/PVb7iujpTvtW59k3q4Wr1C5DIksRcIUfosKkKWMgkK1bfKcSuoFDK/QXLB01eNzOhPZRLxJe7jg+BsyQcelHrMEdVQsTLPJ0MG6+szZCENwaWuPou7QUI1Le+fHu+r7jBIOLjNvr3fu0sew6Lli80sQry7cC/j49VKoE8eGz8FklWjJKwNWodeVhgd6Z4pfVx6YL1gkasvq/JT98GhQE/N5E/849AJQNM2uwvY5FdsgLb4IQABiDeC31NWmz1SWwHSD5ny/KtB28nm6qCFBzMZZA1VIzhJCOtNPjH9C7My0CCdo+ktckKQsWqCbVcVo4BGggDJlwPxTsHDYygUBelaoboDFYnl2wD+mE6zQpf1hDYgNDm7Xm5x0qI6JxErv0ruw7EM3lvameRqwmjgyC5SsyK+LSZTvV5ke5q+VGQH1pQtklw1a8ns913NIslQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261009223027099003)(261022105027099003)(261028144727099003)(4143699003)(56012099006)(261026140227099003)(11063799006)(261021121427099003)(261021123027099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnkzeU9JNDFyZmNxQ2RVa0xHNFNvbXNDdGhWby9Bc09ZNVlPV21KbUxkeC9E?=
 =?utf-8?B?MHJPMVNzcitBbVpzRytsV3J1T09FZjZYY09hV1QwaHIvREhKLzBsUUc5RkNp?=
 =?utf-8?B?MFZIeXJFVE9qMTdHeWVSUDh0L25INXY4dDdPUTJFSC84L29saUxJRityZ1dS?=
 =?utf-8?B?cStjQ1R6ai9TUWNEZVV1L1RWNlduTU9CZEhEWWx1RWhlVldHMFhrc1lnY2dQ?=
 =?utf-8?B?Z2FDcGl4Yys2ZXZ4VlVRVW50VmZzUUhRL1dDWFg1b0dnWnljOGpBempFNjhy?=
 =?utf-8?B?YmkwOW5hd0Q3L3draGVYOUJ5NzdaZmxZLzJuc2pVQTNDRFcyN05VV0dBNFpM?=
 =?utf-8?B?YTUvaVA4bnpwVDNOVDhwWW9Sa3pORTVIUTRvVU95SnJNd2p5Qnh6djkwNzFz?=
 =?utf-8?B?UmpnTzV5ZUg5Z2JPUUxENFNPRDBSSXo3ZnhtN0Exb2YycFdCTnk4by8xSWE1?=
 =?utf-8?B?SjRwS2MxZUhFaDZUOHFkUlgzL0cyUVdPemhoc1FLekNCTnBBaHN1VmpBYnFK?=
 =?utf-8?B?MnNrV3loSGJacnRQQjl5eFg0YytjS1lPMlJDbWlrV01EaVh3SldOdG9pQkVR?=
 =?utf-8?B?M1E4UC9jRzJXWUFGbHZaZGxVaklBZTA0YlRHaFZlNG9yTWh2SFZaNHdsekRa?=
 =?utf-8?B?K0ZBWkxJQ2hialRaWERFSnVpdDdwSmkrTU4yVFgvSXM2T1ZIVHpPd0w1S0hs?=
 =?utf-8?B?bGdMYXdHY3ZDN1d2cUQ5WVdqbjdvOTR6UE8zSEU0eGV6aVVMS0gvK3lYZmZT?=
 =?utf-8?B?bC8wK1pRTDF5M1lnQ2tsSEV6WG01aE1CRHFrUjNOMHV1eFFvMkM1V3JLTEFr?=
 =?utf-8?B?ZmlFMHp5bS9VUks0d1lwUzZwbEpURnloekdKL2ZJM3BrRUc0V2djZ0xvQ3Rj?=
 =?utf-8?B?RUFudVZueDRvMlpGSnd2NkFaQ0JpUzNrOGFKaHY1cDhSajg2OFFzdHJsNG55?=
 =?utf-8?B?cDZ4cGF4ZTRGdGpHb21xTzBITThGU0VLbmUwR3RvcCtLY0huYUdnelZCQ3Ur?=
 =?utf-8?B?S3lxQ1hSNUp5ekdaeWRYZGJTNFJHK2Y3WW9iVmhZb0ZUTVd5ZWgzSmFheTJz?=
 =?utf-8?B?TmxKcjQ1aFFSdzdXWGdSKzdxVFI3Ym9rc2xMMzF0MzBycWlueHRnRzNGbE5B?=
 =?utf-8?B?ZnY5aVlsSWFKMlM0Y0l5WGVDUkVsV05XYkFKbk1GNStGWFJlMlNVZWI2Q0pN?=
 =?utf-8?B?Y3ptSENLNjk2VFZBOXNiWjVsRTRDSHZsVlJhMzlCNllTS0lsWHQ4NHJpTGpz?=
 =?utf-8?B?VUtIOExadGtZZ0F6ZklwK3pMOHhEc2pDVnNJK3FxUUtSbXZ1SW1DeG1zR0h1?=
 =?utf-8?B?M0M4UjRwVWgrTitPTXQ3NU9BUWh0MmNEZzIrSmE0U2JDQVZjMEo1Mll0REMw?=
 =?utf-8?B?WnFRL1FyQnkxc3l1Q3p5ck1BaXlyNUd4RWZycGlLMXlzWlVwT0ZFSTdLd3Qy?=
 =?utf-8?B?SUNZK1AyQ0dwSlNZYWRrVzNtNWdIYUJCZ3BVYTdIa1U0d3VrVnFkS2lNallU?=
 =?utf-8?B?aDJoaWU5T01WYmNlcVlmQ1RYVHZlUDA0bjE3MWVZd3BDd0t6dEpCRHNJZ2V6?=
 =?utf-8?B?L0orK2tKcUppdkY0b3FCNXdvU1VYQ0loaThoUnp3NjNocVpHclRsbXBYMDZS?=
 =?utf-8?B?aDdwcHltZ3NaejJIWlRiTjAxcm9oblplZkFLVm1RUGVPNXkxaHN6eWREWkt0?=
 =?utf-8?B?c0JyQnA0T0Rjby93MlEvaFNzQUpRS1BzMng3OVRPRzAvRWNuY1VQSDNJSnB6?=
 =?utf-8?B?NUNnRmxWcmlqMkQ2djF2c0xOZ0VVa2ZVWCsxMjBQV1FnSEl1eGxkM0VHM1g5?=
 =?utf-8?B?NEN1TlFMamFFVFRhWDBxVWNkK05xOE84anFEREtySGhYOFpoNkJ5M2txOXZB?=
 =?utf-8?B?aXQyaUFUcWtXUWNhUVBIc2dpWmV3ZzhEYzZYcXZ3eDRUVFR3bENVaTZXUWxs?=
 =?utf-8?B?am84b2J2UzJ3dmxDN29SVzJ4OUlyV04zeXVFOElVb2pmSHhWajFZQXlidm5M?=
 =?utf-8?B?T0R0K24rVkNKTmFmL2lXRXBVRTd0UUlJeEp2M2RCaW1qek14U1A0UklTb2dB?=
 =?utf-8?B?UjlWdlZqZ3hmaXhjY3JEcHF0TnFkY0h5MFJ1M3JwejdjdGVwUk42cnZJVEtZ?=
 =?utf-8?B?T0VLQUZGVGNCVS9iWkdEWEFzRW1LWnhGQUlHeWYvTTFDL1YxM2wxMit4UlQr?=
 =?utf-8?B?M2gySFNSVVI0aTYyR2pXemw5Um80eWJ5MG44Wkh5bDNuTWhJR08va0pzUzBO?=
 =?utf-8?B?LzRHT3VYcG51N1V0NjhmSDdiRHE2enBaUG1aajU3cjZldjd0c3dYc1Y5VCtm?=
 =?utf-8?B?Y2FHVXp2TC9zb21HUEQ4TXBoc2FiNnBrQ1FzNWVBaHQwU3Z6K21BUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e7bdb5-0ea9-488a-2c16-08df3cb3e7c6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 09:45:49.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tEt6+xzcy16wOt1w53G+zAzeVXmR//S3OQzyopBPoHUUZ4AY6ZKdPWnELP8zbSWdZKK8xdkmgXsPUtxhhB6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710



On 10/30/26 18:28, Mukunda,Vijendar wrote:
>
>
> On 10/30/26 16:17, Lee Jones wrote:
>> In amd_sdw_manager_start() and amd_resume_runtime(),
>> amd_enable_sdw_interrupts() is called before amd_enable_sdw_manager().
>> If amd_enable_sdw_manager() fails, both functions return immediately
>> with SoundWire interrupts left unmasked.  In addition,
>> amd_resume_runtime() ignores the return value of
>> amd_init_sdw_manager().
>>
>> Check the return value of amd_init_sdw_manager() in
>> amd_resume_runtime(), and disable interrupts if amd_enable_sdw_manager()
>> fails in amd_sdw_manager_start() and amd_resume_runtime().
> ++
> The unchecked return value of amd_init_sdw_manager() in
> amd_resume_runtime() is already addressed in our v3 patch series:
>
> https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m7741edcedb1264764edc7f8559e39af8b23433fb 
>
>
> The missing amd_disable_sdw_interrupts() on amd_enable_sdw_manager()
> failure is a valid observation and will be addressed in our upcoming
> v4 patch series. Please hold this patch until v4 is on-list to
> avoid conflicts.
Correction to the above. After a more detailed analysis of the ACP
hardware interrupt routing, the fix is not required. Please drop
this change and disregard our earlier statement.

The AMD ACP IP is the parent device that dispatches SoundWire
interrupts per manager instance. It only forwards an SDW interrupt
to the CPU when the corresponding SoundWire manager is active.
If acp_enable_sdw_manager() times out the ACP treats that manager
instance as inactive and will not assert any SDW interrupt on its
behalf, regardless of the mask register state.

Two independent hardware guarantees prevent any interrupt from
firing after a manager-enable failure:

1. The masks written by acp_enable_sdw_interrupts() cover
    packet-based SoundWire status events. These require the
    SoundWire clock to be running, which in turn requires the
    manager to be enabled. Without an active manager there is
    no clock, no SoundWire packet can be received, and no
    interrupt is generated.

2. Wake interrupt masks are only functional once the SoundWire
    manager is enabled in the D0 sequence. Additionally, wake
    is explicitly disabled at the very start of the POWER_OFF_MODE
    resume path, well before acp_enable_sdw_manager() is reached:

      writel(0x00, acp_mmio + ACP_SW_WAKE_EN(instance));
      amd_sdw_host_wake_enable_by_rev(amd_manager, false);
      ...
      acp_enable_sdw_interrupts(amd_manager);
      ret = acp_enable_sdw_manager(amd_manager);  /* may fail here */

v5 will not include a fix for this case.
>>
>> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD 
>> SoundWire manager driver")
>> Closes: 
>> https://sashiko.dev/#/bug/linux-309820e5-f754-4d3d-80aa-7f70d59f3e8e
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> ---
>>   drivers/soundwire/amd_manager.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soundwire/amd_manager.c 
>> b/drivers/soundwire/amd_manager.c
>> index faff3e9eefad..f64e8fea7e16 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -1109,8 +1109,10 @@ int amd_sdw_manager_start(struct 
>> amd_sdw_manager *amd_manager)
>>               return ret;
>>           amd_enable_sdw_interrupts(amd_manager);
>>           ret = amd_enable_sdw_manager(amd_manager);
>> -        if (ret)
>> +        if (ret) {
>> +            amd_disable_sdw_interrupts(amd_manager);
>>               return ret;
>> +        }
>>           amd_sdw_set_frameshape(amd_manager);
>>       }
>>       /* Enable runtime PM */
>> @@ -1503,11 +1505,15 @@ static int __maybe_unused 
>> amd_resume_runtime(struct device *dev)
>>           ret = amd_sdw_clk_init_ctrl(amd_manager);
>>           if (ret)
>>               return ret;
>> -        amd_init_sdw_manager(amd_manager);
>> +        ret = amd_init_sdw_manager(amd_manager);
>> +        if (ret)
>> +            return ret;
>>           amd_enable_sdw_interrupts(amd_manager);
>>           ret = amd_enable_sdw_manager(amd_manager);
>> -        if (ret)
>> +        if (ret) {
>> +            amd_disable_sdw_interrupts(amd_manager);
>>               return ret;
>> +        }
>>           amd_sdw_set_frameshape(amd_manager);
>>       }
>>       if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
>

