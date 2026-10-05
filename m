Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880A35DA78;
	Mon,  5 Oct 2026 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194257; cv=fail; b=Th4jJi5JpTfPerpj5ub8w1td7GL4eCG3McM2qs0kHInzqAhMGfjGRp9xt5OHuK+XZvkzoxdxMbLBNXrhpB0ImM1X/8wO2mKXNLx/S4128+2pM+YFPdf5/Ru5uDnKQj++bNaJ9ROiHh9R6p43WHMcpXvp/nKfu+3/aQ7LfjaQ3io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194257; c=relaxed/simple;
	bh=Us2A+MW98rFgAhR8FGraxoOStjA4mdzAvtB8OLypS14=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mmJxJHhag9Qq99tNCcnXjYs6Voim32caEM3rW9jVmkIOnmNBVL/1eGuO/dOO1idoTCkOjjH7xeLzWL5evJHkTOXUHLFTtCnEMnoBo7v3R3qm2+nwcuh5TT2cn/vKMOE1O60dkTD6i32THWu5GCrKj3zR7zXucnduRcULHJKuu+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=fojMa/qz; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fojMa/qz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecrh5LUO2YIjWU4QE3qkiYCUEsK/fLF5E/+1MReKmcMrl5kpWSGecdu4Y+PzrpGrWgjhUm2VRA/hbRsectD8sGs2n4Rt/VVz9cPaWqQhSAE1AGbIthKX62BClvt5VIMTEGwaoKiscOTHG8PctEVgNXF0BXTQK6eWtQEBvVjCfdaiCmjHb/AEEYhKMHZS0hw612HdbaOgzwSVQ1EJ3upiivWO06gCyjRU4kh9N+OeI/N4VNwAT3axZufmXQ7djqLOHn0FrOqAdlsde54qhDN8rG+XGRQ6pstCpyJb3CkMoFceO0C1D64snmqsKj5k5LgxMAxDEl9uABrlGp8BL4AvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us2A+MW98rFgAhR8FGraxoOStjA4mdzAvtB8OLypS14=;
 b=VfCqnXI16d6tJl/M2w9xs+oLmDiwfy4owIhiWF9pfD4me6B/ZaMbfTqxNsJixx/yIa0uclSDRCfYHOdgqSjNBjtU4bW2NoNhjeVIlY9YXgqau4xsM2YSdcoGKPtWZIprQis6wYtx9UcAgRZH7qHU/5uMFcdbXUXqpqNWsxauni5OrVRRe8a/2lDbIELOHnVNRWt/0ydYWPijPeFemjrUkRFFYU2dJ3f+nIy/pw2qFAKEWJsp7pfyNjjOMYlb7HXJtl8lSv7EeCk9fBBI0raHq5yR9khELb7OWI+Yvr19gZQHeb8nzgi8iGrCXfKEMD8u0EcxwotiPFnlf6mZdonbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us2A+MW98rFgAhR8FGraxoOStjA4mdzAvtB8OLypS14=;
 b=fojMa/qzXATDWBGosELam4qWFC0BSdec5vyfQ/cQ0UaOhht4ooKyUlgozFLMiS1AyM+RtSuQGXe70K9resq4aGV6C8huBDtlFySRqsXbxo8bUM0XJ2BXhDyp2x6hjhW6psR2J9hv0Ck+ImrE9kp7p6U74idVkqhTZti4fbnqruQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by PH0PR03MB6448.namprd03.prod.outlook.com (2603:10b6:510:b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 09:57:28 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%7]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 09:57:28 +0000
Message-ID: <7ad90e94-d04d-453a-ba22-9640a5024d8c@citrix.com>
Date: Mon, 5 Oct 2026 10:57:23 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, riel@surriel.com,
 linux-kernel@vger.kernel.org, qi.zheng@linux.dev, nadav.amit@gmail.com,
 thomas.lendacky@amd.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, brendan.jackman@linux.dev, jannh@google.com,
 mhklinux@outlook.com, Manali.Shukla@amd.com, mingo@kernel.org,
 stable@vger.kernel.org, toshi.kani@hpe.com, david@kernel.org,
 mikhail.v.gavrilov@gmail.com
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
To: Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
 <ab077b6a-160f-41a2-a167-813f0560e30d@citrix.com>
 <38541ec6-d796-4f35-a700-75ab097b6df5@linux.dev>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <38541ec6-d796-4f35-a700-75ab097b6df5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|PH0PR03MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8e4785-de4b-4c3b-51db-08df22c710bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|22082099003|18002099003|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ditrg2QXSRvQ2LyqQqhLlpX4NZxfTZ4fPRqAS4zfQaiC6z8fgy0Ro/0N7yd05de5bq/5c82faYxpeAFqj1TbAvhNFb94zjvPdgAeSTIcRZ4GEJv27K7eePjVXaEvUbAXEmHWlUSE7NWA/WSHMolGdNJLJoCfoOQMiQhcOKK0DI+mD3WK0ctn+ZxctJ3ckHxtYPnAWv81ACFmul2NceFRCL57u2xztjo6Jy4wZMsIQP6XzuN+7hV++r31J9oJ5MDNQIgBHUIaYV0fgcSvpAg5WgeweTIijMqf5rj21XFgZzodTfwpPr8LM7Dn8X/GAVxdzRuSJFUpLLqGsJqzTb3Jemlw9sN+YDupyxT0bTqN9di9cnZR25MySl1aYq7g816/ZGOYBvnszcePig/dQw3Bzyw3CCwQYtbl6nLiPgCw2xxqM0MQaX9w5hGm444NPRt9b28MAJgpmoRfuFxS5T6uz1nTLWNKVfeg2OKW//eIJP3Ly80IBPYzzTLN7fbNVdUMtoUNWiRyRMNMwhlQuCKGwywUhhc+l04CEP19f16xpC342Z3xrwURPTgquGx2srIrDP7H5GetSssRok8BM9565VtseKApqqfb/bx13MIFeun5kz6uudKTmeWdPD0V2B7s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTVGaXdxb1l3WS95eG96dEthRDAzbmt2VjFWNXd1UkdJQWpMWEZXYmFoUXRy?=
 =?utf-8?B?dGdLR3pnWkVMWVhleTVHbmw1R0JQaWdsM0JFdjUwSWk1UkdGUE9ITHFYUzRm?=
 =?utf-8?B?VlRSanJxZVNWSkcvMFBndnlBV3FyZEU5ZnhnQVJwNmE1eW1QRExTbEdnajdK?=
 =?utf-8?B?T2UwVWp0RmRsbHp2R3V2Z0Y5MmRqYkNxVG5yVHRrU2F6NlpOUk5XTkk0T0ZW?=
 =?utf-8?B?a2g3RGsrMDUxY2FzdlQ4NEp3UStHZ2Naa2FPUUQydFNJSWd2WmNmUFBpd01B?=
 =?utf-8?B?eEJpcitzSllvUER0M1BvNFFMeEo2WkVmbE8weDN0N3NFUUhYdmFMK0lLckRk?=
 =?utf-8?B?QmZ1T1pXbXVjRWg1VmpqYW5WNVM0bktpM0V4SmExTEcrMjhha2pEcDl6L1hx?=
 =?utf-8?B?eW51U3UvOGo5cE1PRGUzd0pRVHZsRVFzWU1XMEs0a3VMUDlaTkU4TTI1eVVN?=
 =?utf-8?B?VmtLUnA3K2NGK3FtMU9HeXp4OWI2Zk8zV2VJaG9yeWVnOFBicXhvVlRvZGFi?=
 =?utf-8?B?Q3FWcEpPMjk5U1FXTlQ2SnV2ME52amFEeittVDZ0anUvK0dxZ1dJeGJ2T3FL?=
 =?utf-8?B?M0ovVzdGSVhUU082NnM5ZTdwbUk0UUZvZ091bHI5U1prd21EcUZPc1VRNHRj?=
 =?utf-8?B?VHFxaVk1QjJQT09VQXY0Y2tDR3MxWXNFYXBpT1B3dmc4MjdTWEpaeE03d3hY?=
 =?utf-8?B?SkVlempDWkpMc0poQlBGV2VPUGUxdWVZNEpqNll1N3NnL0t1bWlIVzZsWGs1?=
 =?utf-8?B?TlgxZlo5RVEzUXhMTlRxOXprMnpnTy9VSTdmS1RUbjlrbGIrRnZ5V0VRaUNL?=
 =?utf-8?B?K2hIYUF4djVKajd1SlkrTUJuVjBMUU5sbUowYmE2ZTNRdmh4VzQ2dGFuMm9E?=
 =?utf-8?B?WlV1Y2gxSkU1RXF6K2drYkpKWnlXMVJLVFFWRnRlcW5rVlVob21tKzQvYnk0?=
 =?utf-8?B?bnIwYll6a01sOTc2S3VCUkwzVldjKzFSZCtZMTlWd0pNTUVxZTNVNmhEZHVO?=
 =?utf-8?B?MkZOalNGNDVjTzlZUHcxTGRYNUlLQmt0Q3ZLV0NCWDN5aC9OWkpTMmFkcmUw?=
 =?utf-8?B?N0dNeXdUQWkrUGFUN1lvYW1ubzkzbG0yUVVVeVU1R0FqUGpjVUJ2TjJBTnRs?=
 =?utf-8?B?Qk9jUnBkWGpBa0VBQlpQd0NweFhTZFNYMVVLYkJTUGlwbG0ydDNuamxmVnFx?=
 =?utf-8?B?VVVxRzRtS0ZLUmpwTk1jalEzUitkak4rTzluZlNUQmM2UWVvR1YyS3BGNjRY?=
 =?utf-8?B?V0ZuaXdjVS9Vakd4OGNZUkNSTmQrR0xnQmVpWVdsLzRPMmFEcnZ4VWx6SzMx?=
 =?utf-8?B?MnRlbmxVTkJCYktOaGs2bTE5eFNLdkV0S2lwaGdNcU1aYlNiM0F1QWI4aURa?=
 =?utf-8?B?WjViWHcxSjdvM3JPL2J4N2ZZUHJmbU8zdmYwZ0hpdFZwTm1jWHJOYlRLZnJ2?=
 =?utf-8?B?RWxpL2dwVHhlY0I3a09wNldqSCtvWnBIQ3dwRXI4V2w2ZzExdGF6TGJ2a256?=
 =?utf-8?B?Q0VRbUNJTDgrV0RvRERXQTB4aTBGUkZEYzdFNnArVWFtUFVzcGdKc3J5Mk00?=
 =?utf-8?B?UTVVVFIrRkRJSCtuVTlIU0V5ZkZqaHR0WTlmWDdGbDJLWHUyQzBKN3AybFBI?=
 =?utf-8?B?bnJ6QmtDMFRzNWdWbFFLd0V4T1BiUVJtT3NsWW1hTHNvdzZESk1FU2hCbHJI?=
 =?utf-8?B?bDFjREVIYktLdGMrRW91SmVHVVA3U2tNUTdLY0EralIwa1RpWkNHak02NFlX?=
 =?utf-8?B?Zm0zVFpUVzc3UkJsQXF5T3ZEK3owRWdDNlRXaGk0SnEvUkx3Z1phQytsQzZY?=
 =?utf-8?B?K2FOR0h0bGpKVnRDNjZDSnZ5YUhBZ3dUK2pYMUlqM0FNcjd3ZlhuOWZKV3pB?=
 =?utf-8?B?R1JKcnZTdWI1amRBYkx1TFBFQlQ2OHFtUVJYbEFNNWR0V21xSjJvdjRUSXQ2?=
 =?utf-8?B?YnNISlFDKytTcHdBSnYvSW0yWUlyVEtldkEyRjBHYWNOZHRnK0hEUk1TMHJZ?=
 =?utf-8?B?YjdSb0w2U1piYjJralJ6NisxTkdsZ0NndjBSUVMzeVRnV0lqa1B6RTlVOEJh?=
 =?utf-8?B?REQwWCtjYUVvRHNaTDlmUWtjUTlBNjBreEt1UlhFUkJkQU9HTUxGd1FzWGZn?=
 =?utf-8?B?VnFmVDZLbW9jUXlMNWVSdjVBSE5qRjEra3ZibG1meEtuZndFR08rS2g0YXZl?=
 =?utf-8?B?cWtZNTBoUXBLdVdldkxxdVJsQitvbTZJd1hBNklQeWRFN2ptdXdSbVk3QXZX?=
 =?utf-8?B?WjE1VmNhQmwyM3YwQTcyN212M3B6VXVVVG05NnVjWllTT1Q2c3lmQTFmSDlC?=
 =?utf-8?B?cmhqYU1RWTFOYjZ6TnlZVkRzV3F3eW5wL0puZzhJLzZDVVUxREEzdz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8e4785-de4b-4c3b-51db-08df22c710bb
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:57:28.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsmiJUsS5m/ATwGm+pTnhXwIlonyXAr7YJdC43s7C3cI+JtZqhQmeXrft0MJcps6BUSbmh4ecjUiLgsaTLtWWhAVjvdLwEY5pTyWc2H5gIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6448

On 05/10/2026 9:32 am, Lance Yang wrote:
>
>
> On 2026/10/5 16:19, Andrew Cooper wrote:
>> On 05/10/2026 8:29 am, Lance Yang wrote:
>>>>
>>>> Did you repro any bug related to this? The functionality is perhaps
>>>> underspecified in the AMD manual.
>>>
>>> TBH, I don't have a reproducer yet. Just LLM stumbled upon this while
>>> I was investigating another memory corruption issue [1].
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/#t
>>
>> What hardware are you running on?
>>
>> That looks like the Zen5 issue, for which you want either the latest
>> microcode out of linux-firmware and/or
>> https://lore.kernel.org/r/20261002211617.1001617-1-bp@kernel.org
>>
>> TCE is a no-op in Zen1 and later, so unless you're on older hardware, it
>> won't be that.
>
> Just to clarify ... these are two separate issues.
>
> I mentioned [1] only to explain how this came up while investigating
> something else. I'm not claiming that TCE caused the corruption reported
> there :) 

Please can you answer the question.  Which CPU are you seeing this on?

~Andrew
