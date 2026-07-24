Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022142.outbound.protection.outlook.com [52.101.126.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095492BB13
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857607; cv=fail; b=Hl+O9imVGqHVZ8b6mdBxOML6p0OKSofukzlEyZv3+ThwiMKAjMOBND1RgM3vxWfGCCqkCEZk4oSMpO3uBv7V0+ENnI5Jxk+M5vXByNQwf/dp8GOGZmul/ety+oPuUwT18CIclVwHvilTIqSvFI+WFypQ8k3b1WRUeg6BOTShNoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857607; c=relaxed/simple;
	bh=R777v149e5zH1YY08FjtwDBL/A0q1KbYt6lLp5T9R9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2UZmNt3n2I/yIKWCvm61pw0uv04FB2FpoPs1kbG+G/3yh4AuicXA5K4gJ9Dats0+yM5irk72C1PfpT+dAyKC3/FjJ8kEiggG0nGHRXivrsauoWPBLQH1LZLo/HqQLcwPdivxDOBrBID3cRBh3klb53RPsHX92HQydAyItPOOwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ma+0h3xj; arc=fail smtp.client-ip=52.101.126.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ma+0h3xj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTgzli+X/x8vq8uMQ1RE+2BOvGTvT2hX+rJEUDoPoYO6y1/wRkMgS6rqGavuBq5foppM18g/GwB9DSMMkm1vtshTIZsfIkt52dY7FTOx5ymuAsE/4J+okBGYzfy81mj2Bv3jCWRRroLkhbbTIaK+wiMFUwkRVwRpOlkhd7anvoE7eSSohxOE6xuR4Qf3UsXvSkGqwxICq84ENHl/j4krGfg9sG9ojJ54yLVOJqjiniy0MVMtQOMEgDyS66pSb+6B1IDIp1JHppKbEGPPb8ZQXUqBOKfa6C2pPcAc6ILFqm66diIzyXd3LvrjMehbiKC2110a6xE5tF+DVTG0hvy/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPG5yyza7HNRpyShHoCgD/I3GGtpC6uNlZLu2pymNFE=;
 b=uq5l/SbdnEhjUuuHwNuxdF1icNLGJ/2Mg8vj1k1TdSND8/k4mUlKYSs4/MsXAWAv+Xbu5jkmADpyzpLryf9kzGhTVUfLnfMMPWHFiJ/5y2R90KyvKJ0DV2nS2p3iO9fugpoGQ7SF+qA0c6n3qV77eybGs37jW0XoIwzETUaclgahGPISAM3wXIj2Yh0JfRH3iyPvKpPMJgAiMMPK25yoV/eDBsbP9F89JUKHeFTch9/Ph66eFODNrCx1urFoDXHHtQXmz0rFg6rOoAy0jfKJuSVuRtQGYt6lgxWwv1YIhFflrgMYUYerEJWyEC09dRf/KrOAxQSntkretIxTxtrV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPG5yyza7HNRpyShHoCgD/I3GGtpC6uNlZLu2pymNFE=;
 b=ma+0h3xjVURlB7zjz79m4Gggnrx/pYiYfpr90XF2sWsm1LSLmH4z42gf2emMhJFbM1YyReQm85JjMYqyl/UiFVEkxNZ12Ix/mFrLH993s2pyoCAl49Ty7wsDARWCroohy/cuEQustl9be43Qudep6WIHRzJ9sjk0faTbyIyJK+hiHWaRAuC6KlphMpV2KhpmvK4w+DkSxMCFJi17vdi6IRztDFrsjmCbqCvaz8v+J3444cTmNWHr99j2BaC/hJ7xNPISmEAlJyxiPwDXAAgpA7/uHonSUrt1r0KCgefCvkyBzBqxtIp1Y3Ri2mvvr7BtxE1EEsgSd4e8s8+yNI3pJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by SEZPR03MB7629.apcprd03.prod.outlook.com (2603:1096:101:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 01:46:42 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 01:46:42 +0000
Message-ID: <aff1295a-6de5-4276-826b-f447a44cad0a@amlogic.com>
Date: Fri, 24 Jul 2026 09:46:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com,
 JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>
 <2026070937-unveiling-atlantic-b798@gregkh>
 <21c69c82-f947-49b6-a046-cd0cd3037dce@amlogic.com>
 <2026072110-tweet-comment-9180@gregkh>
Content-Language: en-US
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <2026072110-tweet-comment-9180@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0093.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::14) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|SEZPR03MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a3dc5f-055e-4d59-a074-08dee9256948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YGOuwyNk0LbQG1gGKwZW5sp3EGyHepCr3x34k9T5zMY0309IgEyaS6gdSxYqK4bTjxxdrCh17fFfCM+1suCalgMdHwT8vR/w7L4ZZZi9GayfGJwOY5ItXYLvPqkmH4ohTuM5vx6Dhcv2EGDqLuuRIblKAyFxqaKrYzOw1PE5UDdsqeYIiTuwnxxcOvNUaZwUsJTiNck5tcTPUj/EuCFYJQkwg7t/gAPuDESZlEKqh9u9l8y8M0KW9IVaNUrRNi5B9p/HBQoap34E/3kLvYCU8L1fPzJjplYTrn5T2mezsBLDHxd6Jw2Qe9fpBetl04vjAH1OtuwCzZqNo2nHW7FVswaQfGvA2OXiMqvXLo9oIsQOV/y0qFjSqHXfU9oTrqrEkktVQPiM+5O1phjw6QyNWrKIK7s17iEj7nhYMc787UxhD9LtHT5f2JZUm5pCvKwFfJ3RY6zCetc81S7lHnlTX2Uh1joLZCGqTUX/1NaWTLKJKqXMMt14WRy9AqUHQyQ45DZS1eQlnrThc7uYWJafcBsCpkGzceF8c2L+Isuwm5kb0haeFx1m/lWoXudRQJtexo9y9uko/qBDMf9BYxMy1mCtdb+A7iXuRBMJOc+VuAvIH5XiJJFG44c5ebonuYNSLQ6mLRsk3s0kn80XvBtjxpE9jGh+OokiVSj0FVmx9CY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alRzQzNsR0UydHhrK2RuRW9BNFVCQmI0b2VNUnlYQ1hNcmxBWFptQ0dIbGRn?=
 =?utf-8?B?V0tkdUJZb1ZQV2pXRHovYVJXZjNJUlQxRDY1d2NEUWNiWTU4dWdaQnVXQk91?=
 =?utf-8?B?NmtDUHRUaE93R0tQS1RtTG05YnJTWGpaK1JmUkZ2RktIVWRCdlRtcjFtNlVH?=
 =?utf-8?B?cFV6K1puRkMrbUtMRjM2TEZEMFVTSCtSWFgwbDNKenhZYlhVMmczaStlbVFo?=
 =?utf-8?B?MGJBWVloUTV6U2d6TTJTRmRYbCszU0tyUE4zZTZ0Q3R3OHFpN3ZLUHYxY0Uv?=
 =?utf-8?B?SXI1TlpKcVlUamtVbXhxb1UrcW5NbzNoeEVkeVdhRm5pRSsraTVhWkdLV0Fq?=
 =?utf-8?B?SlpsVjFWNWFGMXdzZkxGWlVUSG9QZHhFUnpHbnhENHl3TjRtam5NMzJ2cXls?=
 =?utf-8?B?amhnY1NpankvTVpmWnA2cjVocTBGRVpDZGZlQUtBNG96NlF5VVQxdk1VNTlM?=
 =?utf-8?B?QUNUV09tRnpud2ZKKzBJWGNxeU15R3BsVnN1dlRLTmQ2N2p5VmtIM0xKdVFH?=
 =?utf-8?B?MlRlKzVTN3BoNmxqTWR1RWF0Z2pJRkEyVmxiSWZmVmY4dE5QY0NpYjI3OCtW?=
 =?utf-8?B?czZkSGo1bnhSODF1Q1hNQ04ydEhZWWZKV2l1SWtSRXAzQzJaRC9WV2NQS2Fn?=
 =?utf-8?B?QWRjWC9PNWx4bytrQVN1dy9tR3E2TWYvQXNPeUFxWVBRNEtheDVNUXQzWWhs?=
 =?utf-8?B?OXZ6STVWWi9QQ0JTZlhpVzkvaGFEVGZ5WDBXdjJoZURVNHNmNjFLK1ZoZjJx?=
 =?utf-8?B?Z25IckxMV3E3TGJNYkJuazdSVUtFSnpGZjU0aUJkd05XVEFaVVd0SmhxZEF2?=
 =?utf-8?B?ZnM1YVl0WFg1U3h2N3EvRi85QVBjV1BWZFR5TjdDc2dDb0lWaHNkTy9xd3Bt?=
 =?utf-8?B?b2Y1R0cvNEJZV0hERHYySjRialVoZS9teDloNXpRQVNuYnRFRnczOStlenJk?=
 =?utf-8?B?Skw4YXd6V2QvNW0rNkwrRmFIaXpBeFNDUWVDbzRBK3lxa0t4aS9tcTV6bFVo?=
 =?utf-8?B?OEdmYXl0bVpyMDhOMVBhRWhXSk1zb0ZCVGhUc2RTeGVqNWZYNTU4bFR2djZW?=
 =?utf-8?B?VUZuVFk0c0lZbk1JdHVxbHVRS2V6QW9nc2NEUUF1Tm9kK1dZcld6S1JnaUYv?=
 =?utf-8?B?Nk5FRnNqN2FpREF1anpwT29rUTBURE5ER3drNkluSjJ3TE9xeTA1aE9MZkxZ?=
 =?utf-8?B?b05KWXpOV09KRUNmNFF2UU1TSGdKdlJ1UExLOERJQlFhOWd2c0pjLzJYY28r?=
 =?utf-8?B?R29rMWNCZDIxRk1QY1ZMaWRkTE0xSkNyMWJneTJkcDZETVhEazRybWZQS3Aw?=
 =?utf-8?B?OVdCbDJQWG5JZHlEUDdzQjBibEdqbmRIMktUMFBObDl2RjlvSExGRXhDeGc3?=
 =?utf-8?B?Z2JuOFNsQWxWRjIxWk5qd1FYOWJueTI5eUU0Ni9NRjVnS29kQWlUcndZMzFW?=
 =?utf-8?B?RzVVZ3Y1NjgxSGl5bUNrb0V3OTdwV21hMU9Ud1hGK1pBVlBXY0VxTTNNSGU5?=
 =?utf-8?B?OU9NRG45Ti9IU00rRU12ZllDNHBCV2tWVVBTVzh4eEluVUE0bFRGcXhqTTY0?=
 =?utf-8?B?ODYzS210QnFBVzI1M2d1clNvSzZETU52b0JLM3A2d0dPSFdaVVVueVYvUTlB?=
 =?utf-8?B?azYzaStmNTRnNFh0YWNsYnErdmNIMlIrbzdXL01ZQ2dBRTk4bU04Sm93cEUx?=
 =?utf-8?B?VFRjbGFHSXBsRHZtR0RlQ0hxazNFaTdlaHNVYTRieXFtbmk3a3dPTGlhTUJo?=
 =?utf-8?B?K0dPc2J0d1FYNENkYjE3a1oxZ0FlU2w0OXlTQ2JyM2VoRWptcGJRRk41M3lo?=
 =?utf-8?B?QXQwY1d0c0NaK3NGaXRpckNISXhTQ2JCWmhNMzE0REJPRE1qS3hXbzdsZVpy?=
 =?utf-8?B?L2IrOHlXb0NiNkRWVlR5NVhRWDdGRVdBZk9ObzMvRjlzeXFWa3hyRnpqSHB0?=
 =?utf-8?B?WFU3Z1ltR3dIZW5UVTFrb2J2UG5ueG9JRjUraFRWRlNqUlkzbDJBaGgyM1A4?=
 =?utf-8?B?dldxbkRTUDdBLzhKb1p4MzVGMEpvQTM1RjJoTjBwSno4dTQ3M21qYmt2dGRk?=
 =?utf-8?B?VjN5MDg1SmlxVk1KdEZWdU5Id0pIOXpCeVRtME15b1EwN0x5TjIyY2lYU3J5?=
 =?utf-8?B?MnU1eVFST1NOaGxoNG9FeE5vWUJEOEJIZHArSGZlVGgva2dtRFU3K2xSOENO?=
 =?utf-8?B?aVFHWnVGZGJnNlFQKzBKdVl4OWgzbWo4VU5aZXRlZ0JINHRTZ2ZPNlpmeGFV?=
 =?utf-8?B?cUVZUjhPeU5KZUcrcHVNaDc3Q1lwZFJsV1FoWDlaTFAxbVJhN0h3TEV4aCtD?=
 =?utf-8?B?c1JHbFd6YUU4eUFEaGNRbTJ2c3NBQjRNbTYzOGdSWHJ3Z1lrM2t0QT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a3dc5f-055e-4d59-a074-08dee9256948
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 01:46:42.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HK81rlWqP8x0SQcb5BmlxDAt/Zs+rc1eKHqzlxuLFjErxT+aXHrLSnu/1BlNmH6VjMfceRRn+WJNCf8SYSusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7629



On 7/21/2026 9:04 PM, Greg KH wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Jul 10, 2026 at 11:17:19AM +0800, Jiucheng Xu wrote:
>>
>> On 7/9/2026 7:04 PM, Greg KH wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Thu, Jul 09, 2026 at 05:35:40PM +0800, Jiucheng Xu via B4 Relay wrote:
>>>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>>>
>>>> commit edf7e9040fc52c922db947f9c6c36f07377c52ea upstream.
>>>>
>>>> As JY reported in bugzilla [1],
>>>
>>> What kernel(s) is this for?
>>
>> I'm really sorry, Greg.
>>
>> This is my first time submitting code to the stable git tree, and I'm not
>> quite familiar with the process and rules yet. Please forgive me.
>>
>> I hope this patch can be applied to the v5.15.y branch. I referred to other
>> patches and added a "[Mark: backport to v5.15.y]" in the commit message. I'm
>> not sure if this is correct.
> 
> It needs to go to the newer kernels first, so that you do not have a
> regression when moving to a newer release.  So can you submit backports
> for all of the relevant stable kernel trees, including 5.15.y, and we
> will be glad to queue them all up then.
> Hi Greg,

Could I ask for your advice? When submitting patches to different 
branches, how do I mark each commit to specify the target branch it 
applies to?

Thanks,
Jiucheng
