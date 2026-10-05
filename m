Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A84BEE58;
	Mon,  5 Oct 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213762; cv=fail; b=jNgtAU0eMJeB/dlMfW/HlXdK8n24xK3cbZnnB70pVXwG7Zmv9qNLP+NyNZhFrw2GKFByc6TqwjnPYMLHJlXUkFjn3ApjGnB4349y7s2rlT1AS6b175rZNedTsCaC4quW/LPj/lRo9KwWroKO4TyVpK0xc/s9jXb504ULBnsF95k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213762; c=relaxed/simple;
	bh=LKO31lXYdfPbDxV1efG7Ao0Bl2Aj/c/SoSfBDZdkcOA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d7cBkq1Y4dKUNVklHBg3H6ZfeMGPhV3TYqPRLPJVeLYGpqpuDbNyMArcQnppE7RN7v0VIz1FKQA/SyFNbOSFuwSG+dW58bkMHtmvvKUuKoy3PZmtcIFua7yOoXBZ5zXAnQ6EUsI4nPBErvLnPL3/MJSSOogOHgKGrcwydgQqCRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=q+LxoyvS; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="q+LxoyvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghkVt2aCHIKPo8lKoxcyVO9XmY9VWn8fYLX9b4WrymT48iXzSe0Eb6V+4/pRrREM2IXQM7pNRbB+E8L68Qn91oXcgP8bzh5+IduC30itzemZplZUBnl/I1qpKYWlAoCLeN/i22rnW8qacsZRdid8exZZnevgP1y2Grb0vcJxNSslt+059B6IThR64LjfTwzeSxkIYXOjZTaCMRJ90Lb4xWqS6b1OIzSKRtk+1qdxvF00ofi+Ei/J+YhpUfoC17dUmIUwTS6KEHfx34diOVwhdkip6E/e1voFqSqannhie69Oot+zh9lSduPcztEruyXpK8wnzQvPp4eNyDc6otaJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKO31lXYdfPbDxV1efG7Ao0Bl2Aj/c/SoSfBDZdkcOA=;
 b=a6WzqeUdhnwB9gWFqo+FuHnGB08pmHq7EaNofbssU+ZgcfUDsVbFpP6Jt4V720eXo3jfah3tt8NS6PeJ7q0HumhTM0awODWjD+PNoK2g2JJFwUzOuAjiX65V3/SYRr83O0yenEXCJRd14s6AvpuX3nuJ8LkiftJJiietRTIXunBeTXrYdyVHceahFXjLVH+RN167ULaI2Hz04X+q0bDqvyyv19LCi9sz4eUvg/jtHgZOyQDL6RFvcMnv51nCHKPWVYAg2PT9xCZx+URjYE2LyNJaw13ynYoOlCC/sTrYRF+qCLeOM18hl7qVVH5JDTM1xKjU/poJ27snTVcxFWEZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKO31lXYdfPbDxV1efG7Ao0Bl2Aj/c/SoSfBDZdkcOA=;
 b=q+LxoyvS7Bwkh7VktXVGEI32CntZRt8lHUgqi2J8ePrdSki9axbdV/oQAQkrhXAF3qZ/v1SqKi7xh3dWHGf5mXzOFlw6jcJpUAqHALb9LvRRBHs3ISbWLEKWDZm28SJk0gWhEaPhDNGrkYa2OzzxYflUE5JRbSXHvrYtL96gyhY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SJ0PR03MB5773.namprd03.prod.outlook.com (2603:10b6:a03:2db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:22:37 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%7]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:22:37 +0000
Message-ID: <9459bab2-b373-4008-8f3d-f84b62db5b67@citrix.com>
Date: Mon, 5 Oct 2026 16:22:31 +0100
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
 <7ad90e94-d04d-453a-ba22-9640a5024d8c@citrix.com>
 <6801221a-6307-407a-85fc-46906f95d22e@linux.dev>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <6801221a-6307-407a-85fc-46906f95d22e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SJ0PR03MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 396d22c9-aac3-46eb-9ec3-08df22f47caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z43KP3XyrcywWiVBLZTXMtba7/wOX0PCHjoBfgYN4CqQo5ljuEdcYVUE8GHXvEKbIIsSGxTUDCP2gthWkhdxdXhXnf5eqNFBG2psu9Ikqdwsmg3maiil4o6Y6RMwZ86bsDpsTzXEKxqK3uiadwDwMB8gLEvAsMNoDJHJ4Tr7sIvS2/T/HlR4EfFGQfNbG972cDXtaNqmZVi49PSImY7uBPsPE9zvWP6r5RIYulmvAtpyB1TmCLU+BQgG1q7yLqhzhv4FNqk9vb5mg3abiAkX56whUBpe/sN0jizJ+JyCc1YBEu83Q23nCTQmFTG1ZWRf5j2iqX4fRHVYrQWY1yD/YH4/KVIk4qhcuOuK4cEUUNv9NeZ4e3BDGS05fmUQN+Ldge+/YNJhEyykAyCppHlWiy5uZ4pdl2hDYOFA4B8dlDZYQ++Hnx3QZNsb5a4swyn+j07uCcIYzZGTFTgxzxGLFR/tuIgDF70W5PkZ5cEk4qd1+hN1GfyFpJ61wQZkmvejg6OZlgSX3Fl0vmgJ5PJMFErPjYtxRGvhAW4G+DVfSST0TgR8NgUcBZc83wHRiFTkP+frjLDMY33Zd52QBJcBkrRH/Qrqzz2rdoBfcZBxsVsNRuX8sq4Ly4xGXlfG/R2K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay9jeUh6R2hvczNPTHMxUGVEdDR0OFhXQmRvMUlra1VlNXdVc1d4R2RYbDNS?=
 =?utf-8?B?YzBSOWNQamt3Z3l5eGgvU2l6aXdjNVVvZkJUMTQ2d3RpODdGT3ZzUGs1bjN1?=
 =?utf-8?B?amhTSkpQVEJYbnBYY3JnWWcrQmtMbTc2akpMQ1F2b0NQbUlrK3UvbEVKaDBm?=
 =?utf-8?B?b2lzVUl5QkNYbGZhUWFFeTBOeFk3WEhRYmZjMUxEL3kzcWd5OFpxNUVHWWlX?=
 =?utf-8?B?bEI5ZTNwalZ2VHVtNkRNQk9lK2VRZ0FVTnJxZ1ZoanU0WVNFU0JzS1IyS1Y5?=
 =?utf-8?B?bFNFczFpU2pTUG9tT0hsbXVTeVZZdUxEYWllNEdsU3gzMVJKVkFWQVM5TWJH?=
 =?utf-8?B?cDd0elJqR21iT3dIT0tWSUNOMlZtTDQ5TW10M0xvZFFsaHMwMXZjYXo0OFZW?=
 =?utf-8?B?d0pGYno4MnJXTkRQTGV6YmpMSDEyUCtMdFYrYmtwWHJQT0JMeXpsQUJ5NnFV?=
 =?utf-8?B?QU95Z3N3eXBhMENVcGM5YlV3eVVZZUhLendoMmJRWjJ0YWJOaGZHempPK3Fi?=
 =?utf-8?B?MHhCa2d2R2hMTzZyZ0JoQXpVbG50K29XSlQ0aTVURnRFS0RDSmhJTFZPTG11?=
 =?utf-8?B?TENhSU1udCtwMkpKYU90ZTJrcDZuZmpCQVZlN0xtZG44L1FCeW91RXI2dHVl?=
 =?utf-8?B?a3V6WnNuQVNnV0ptNXE5aktWcno5ZlJLeGF1UnN4eWduaXRhVkRJcDlDRFlE?=
 =?utf-8?B?dEVzRWtjOFJZeTkvbEhBdlZwMmQ5MnhtNzRDWjZRQmROTGt3OW1aSTNyaXhO?=
 =?utf-8?B?UDV4OXdjdCtxeWRoeHBia3J5OEp1dHVVZFFiS1F2NkNPV0RkUW16c2lxbVF3?=
 =?utf-8?B?SStZcDNPNjA2QzJzNWoyRFYycUw1YzRpUFJaTnVsekE0Tkk4dXRiN1UwdWpE?=
 =?utf-8?B?dVVqSE5DN0ZSeDRFeDl1dkpQYU9LVURwcnQ4QTlGVW5pSjdpbGdtVDNYM2Zv?=
 =?utf-8?B?akxock44a3pwZGQ3VHFDdFpSYXZnblZtZHNRRXlMYjM5VVp1bTQvUUI2U1BB?=
 =?utf-8?B?ZE5hdWszQnBLWkdsKzQ2NmRCUGQ4UXNhUkRCTU1nb0hpZ25KOW15UzRHQzRE?=
 =?utf-8?B?YlpiWHpjY2FGamE4elN0OEYvUkhwZTZFRzcxVWdxNExheXlSc2NBbStaU0FY?=
 =?utf-8?B?bCthdTlQUzkrYkVHeURXNE9GR29xNy95MzViYmRCNUJlNEFEbTZyQjMwVXNL?=
 =?utf-8?B?SnJTeHo1OWtHVTYrcE9BV25SMWY4ZGNYYUtMc2J5RWRQRm0wem1henlMZlBO?=
 =?utf-8?B?SjJzbkIrNGhyR1VrWlJjcit2U01YaDQydHRPTXdJU0JEWGZYUyszTEJxREVE?=
 =?utf-8?B?VHhYTXFybHhtWGQrd0tkQW0rZElQbG9qZUN5THlldE1xRGY5YldTYXFDdVlk?=
 =?utf-8?B?cW4ra0xBWFRabGN2WklVR3p5bDJwUktyOWpyaXpLalpCdFcvK3RwQlJBTEpx?=
 =?utf-8?B?Sm00Qlp2cHdsbU5SOUVyaSt0T2QzeG1peW9zSlBod2pxNzMvK1ppTENUdE9j?=
 =?utf-8?B?VWNmV3IwVDFWVnlZUE1VckhPWk50WUc0TG9nMEtITHZqaFcyZHhtYzlFMCtG?=
 =?utf-8?B?U045a3F6M1lsTEZicUxhWW92MUVjNXFDaVcrY0pkRmE2V2MwSmRYVXhUNVR5?=
 =?utf-8?B?ZzVjSEdRVm9aS1F2TGRoY3h5aUIyUzlib1NqZzI3dTZTb1Q4WjZXOWFEc2lE?=
 =?utf-8?B?ZThkZEZLRUdVTUFlNDFMNmRkUUhPMGEwNldweE5kTGtIOGFTNUQ1dDIveUpH?=
 =?utf-8?B?R2dUQVBlYi9iK2gvdUlYZDY0NitobUgxVGV2bkxQeXNIQ1dRaVhDWHcxUFFi?=
 =?utf-8?B?ZkJrdGkvT2ZGdG16d0JEQzc3TnI5OFcvTGc4eloxTk03L1BFcWlTcUY1bUxs?=
 =?utf-8?B?c0MyUURiZ1FHU0RMcFVUZXVyRVNxTXYvejRLS0JrVmRGN29aOEdWeXpmNXpD?=
 =?utf-8?B?WDRZM2xadEE3aElKQzFFUEtybnRnMjQzZUpIdVZJV2lvNXd6eFZZNGwvZEYr?=
 =?utf-8?B?blZjamVXY2g5ZndmM2RXLzdzMUF3Ui9GMGYxV2ZjY05mMm81bjlCR2NCeHhz?=
 =?utf-8?B?bkFmQmgzKzRuWlZIblQ5eGRxVG1tUDZON25FNktKMDJBcjM4cUljdzZJL0VX?=
 =?utf-8?B?ZGdMSmhFZFpHSGltRDQ2NkQvUE9Cc2cwTURjcHRwMkhXSmo3UUIyL1dDbXYr?=
 =?utf-8?B?Q0xyQ2Z0Nm9MdWt1dnllcDQ5SmNHVmoxTER4OXh4enphbEpSN2hDRG9YdktI?=
 =?utf-8?B?aVFsdmZycXFRSlNiSys0cmo5MmhFSC9YeUxhQ2RBbFIxNytoSytyWmFiN1hj?=
 =?utf-8?B?WTBoTXlwaVBubVdkWkFRWEVSL1ptcEFEZVdWSDlEcEFlS2swb2JpUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396d22c9-aac3-46eb-9ec3-08df22f47caf
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:22:37.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e4hFUZf4Ry4v+Bjd1taQkadMGcdlNzNG7pEjRRdFIHnAw3CgSYTBiDwf4yC7yhN2l3s70jJnpJIQQMgJqoqUHhjn5044XJqrbM17ieH/dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5773

On 05/10/2026 11:12 am, Lance Yang wrote:
> On 2026/10/5 17:57, Andrew Cooper wrote:
>> On 05/10/2026 9:32 am, Lance Yang wrote:
>>> On 2026/10/5 16:19, Andrew Cooper wrote:
>>>> On 05/10/2026 8:29 am, Lance Yang wrote:
>>>>>>
>>>>>> Did you repro any bug related to this? The functionality is perhaps
>>>>>> underspecified in the AMD manual.
>>>>>
>>>>> TBH, I don't have a reproducer yet. Just LLM stumbled upon this while
>>>>> I was investigating another memory corruption issue [1].
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/#t
>>>>>
>>>>
>>>> What hardware are you running on?
>>>>
>>>> That looks like the Zen5 issue, for which you want either the latest
>>>> microcode out of linux-firmware and/or
>>>> https://lore.kernel.org/r/20261002211617.1001617-1-bp@kernel.org
>>>>
>>>> TCE is a no-op in Zen1 and later, so unless you're on older
>>>> hardware, it
>>>> won't be that.
>>>
>>> Just to clarify ... these are two separate issues.
>>>
>>> I mentioned [1] only to explain how this came up while investigating
>>> something else. I'm not claiming that TCE caused the corruption
>>> reported
>>> there :)
>>
>> Please can you answer the question.  Which CPU are you seeing this on?
>>
>
> Which CPU? None so far. As I said, I don't have a reproducer. I'm trying
> to make sense of what the manual says and what the code does ...

I'm afraid that if you're trying to be helpful, you've had entirely the
opposite effect.

TLB handling is a complicated topic.  What you've done is present what
is effectively a query about the AMD manual as if it were a bugfix for
an critical-sounding issue.  You even sited a real bug-report for an
actually-critical issue, despite it turning out to have nothing to do
with your submission.

The patch is buggy.  For starters, you should be checking is whether TCE
is enabled, not whether it's available on the system.  This causes the
more expensive option to use used even when TCE is turned off.

But, AIUI INVLPG only flushes the whole structure cache because of a
windows bug which caused it to crash on a 486.  AMD deliberately
introduced TCE to remove this overhead for every OS which didn't want
lumbering with a workaround for buggy windows.

Linux currently believes that it's TLB invalidation algorithm is
compatible with TCE, so at a bare minimum, you need to have some kind of
discussion on why you believe this not to be true before claiming that
it "might be unsafe because the manual says so".


It's fine to ask a question, and even ask "so shouldn't the code look
like this?" but such a patch needs a very clear RFC or QUESTION tag.

~Andrew
