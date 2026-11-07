Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794080058;
	b=Bh2+3X3o/5pVBK45pbVcEaVtwhQOTYqerHQuIM0+OYsL6VqMFJp3JyRZDyitdcc+Ygou
	 uHvBBZbXNfOZIuwH6kGvB259cy0OM8X2AVI5jpCoDEbKdySkI1c+Cbf20j0UQAEKXf969
	 fUFOz2BQf5MFCyO9o1VAJmxGf22OHVOsHKthPj5Uh2LS73q/8Re0hPna4JdQMcXbnIGYd
	 igB8sgTTOT75aKHnmTj8ccIxCXteHuKNtgrttziw3S/K4k1O6/Cbm4CnMVcTIliWCu3fv
	 d3KCoBaLxyIohKDcYgJNTB4XgALOqYnLwZ9cqp285b2v9Q84aBB7eM+iOIN63BT/Upg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080058;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=C2mc20T7WfwNWDWve4U8qj0WFgpO5sQP4D0U6/23ozU=;
	b=MermuvuSN+KJPDbTqL265SyRgmfqeDMcmDbFx52JpfNNp4KwrAsTXC8A1nAy/oG3VuUD
	 p40/op/5BxmRrVZsHdf8oGWMVneChISvFKd24884KlY+ktw8/KsdTcE7KDYQ1pAAYdKZz
	 yMjRc2rSMp1sOkKLcCFz48C1afyonRea3MRMx7ut5k+aW28IDkYr+5M9lOsQsouIC3J8b
	 y1tdGipw1Zp1qS7fwgxq+pXcMgiKDMNN9cdpaJaefGkebvve71ulWWSVOxPsRDzoTYEWz
	 E1+TzsrGw38iXWiG3xOnFZyES5zCMbhea5r7ut+wWf3DNlrDN0tH/02RcXPFK56JZ5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dVCzEI05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.82
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020082.outbound.protection.outlook.com [52.101.189.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636C606A32F;
	Sat,  7 Nov 2026 19:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9636C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dVCzEI05
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtEG5bs2VtUQKREWHFXiWH8fYd1VibwyzNtvzLAekxf6YHsyeZR5PerRDDFEif6GVZ7pbjVJmyJRXuXdCFxeD2OrfSiceDnZdp4L4eRODzAfrL6sYMo9NFa+K4VLU90PZyiS4csCkmLuuqWBA+IDDElcBMcbwZWWYitIruWe+evXLk/XhU1vjqmrBxrrFUNH3oUSvcx/JrfKdMf9TvTkjLPmvBccHjCdwXWzBFb7c2lz8FBy27tmrBEyMiz69bz41dqmZ8gFIaqVUARI5v9VyEtYXl5tJyBUAMLf6cY/2dcinxKz2uhv69yU/fr0srjXh7cepvJhnrid1QC7JD7wfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2mc20T7WfwNWDWve4U8qj0WFgpO5sQP4D0U6/23ozU=;
 b=rbWfvkB1G7SFmBajjh2zWIyG3Z81yypQbyWazGcf4EQITu6KI3t44ZG2zIsc6IyxfZo24E797bKc2P/fAKg+FfOIMu8KSefspc+GL5UYuwI+uZsTZTXItXvYKnb2sXooVqju/hSP1HH1OZyLKQhaHfhBDXuXE3yTEKpX74TlQsZlFpewMTXRnqhF4oYVSMSFcQ6md9/v0Ydk9tzCBhwRsOihLc2MVx8CMQYe7oGGsj9RIMuyjiIHdResSxEQi4h91q1GJ0D0i7xPGfChfGzhsG8Mxrg36IUFIGDsLaHCeudGVGjMLlpralNuV4NagPAH7R7mBpwWrNAnb9ocsc7gMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2mc20T7WfwNWDWve4U8qj0WFgpO5sQP4D0U6/23ozU=;
 b=dVCzEI05fbDsUKrz30m6CqzTCbEHdbQJpUXlTZzOSWn7LPfTa9601oCQRoBX9FHEStYLZD/Fcy8JwhUiGgOS4u65UCL8Vbmay7gYLjwzp+NRrb+z43CZJIkzE1i2AMkODAK+s8+FE3yeSijD+foScFqZ/bYVDQpX2h18P5ortJgGuZBpogmWB2U9N36zMXQoZHXMtVnqgRIaSIbcC8lv/4BtFE7KHOQZckz+r9wzq6tLPTrla0YY0DJcl8pPIVG0YkHbe2KNXtJwokKCQzMjQGY337FuoD0QadjWMPqaWnjmpyJ+PfqOHlj+AB+WFCf/0X7IQoGNo8mlomTZRZm+rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB842448.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 19:34:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 19:34:14 +0000
Message-ID: <2a786b46-e935-4269-9bdc-edac43521a80@efficios.com>
Date: Sat, 7 Nov 2026 14:34:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when the
 waiter is woken
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
 <20261107002927.3cbad7ff@fedora>
 <20261107104329.GA2668564@noisy.programming.kicks-ass.net>
 <c77635b1-9c24-459a-b75c-82cbfb67185f@efficios.com>
 <20261107123642.149677cf@fedora>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261107123642.149677cf@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::28) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB842448:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f76e0c-22a3-4c53-6dbc-08df3d061acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|261026140227099003|4143699003|261022075727099003|56012099006|261022105027099003|261021121427099003|261013131602099003|261021123027099003|261102123227099003|261026121527099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dERBWBNA3TeJ4PA8tr2h9Ich35US2TmeTk6e/K7RfoN5R78FnzoHua/H6lGidtlt7yMkWi82/uTrFIdl4BCMQqP6p/jjTph27FVCqCOSHPtoWQHvSEXrmsSNn+jGRrQlIoHhwqKbul5nN8Q1fAKbLzrzDURaEDMcCav1CQ8Nij3+7hUHn702i/Ps51GXL61rGx3RulxneAYKijWFN7tKalnHd+SECWDp1zkkdeg4Nv6Tcg5633l8O8sFxMtJNb81tJS7CQic+Uyu5VZqpexlk4IesYd+KM/DaH32JElpnKZkx2uA6QnXSVJdJJn+7pvFIRnxHwXjR3JTZqzb7mlGmjZ1VsTlHSy7/QAyiBO6SvmJhK5iKgL64Alk5r/9zyr6royWrBOhyWuIeyE6luxBaZtouSmNSD0yq1Yz018N/r7WTfMLnOfl3y4YODPZK4WkFmNEAVYU3K/hTBQ5Nd4HIikBDoPQ3rhOfoc1/bdXQ428Be7ycAZXQTILb+3dc2gsdR32lG2vV8fRAwWS7fM+loEEqnKkgZANwCD+7F/e6PjBFpBln84p+251MlAt/J2FsZB45/RNpw6udFqUFAtkNL1epDA7nIGdx2ZMMTKawyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261026140227099003)(4143699003)(261022075727099003)(56012099006)(261022105027099003)(261021121427099003)(261013131602099003)(261021123027099003)(261102123227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0JjOTd0YnpvY2VtOTJhc3EvcXZINVd2M1RMelJYejRza0ZUWWJXVTB5THc2?=
 =?utf-8?B?WVdRVHVWMDJackZLdlluaW5ucFUyc1c0d1FmdjlUa3lCQ1NFaGpnVHNyQndK?=
 =?utf-8?B?d0pXNk54REtnbDFYRWltUkJHTHd2UU5YN1BTNHAzb1ZKVG1ZbTIzSFJSN1lY?=
 =?utf-8?B?NGJtQ0g0S1hWQWZVRG8zUEdLNjc0WVNvZjNQWVRkRS9FUjF3aW0yREYvcGRl?=
 =?utf-8?B?UWw3YWg3eWcvWG1GZzIzTU5PeHB6aTFYWlRNZ1h1WXFvUjNZMVZHajZvVUEy?=
 =?utf-8?B?UjgrdExFY2h4SS95bWFZU2RWVFdwRmU3RVFqcHhMTWZtNDNVNDZDczhoSHMr?=
 =?utf-8?B?MWNVcWVhTExVYVZlYjJuaVdzaXpydXZFOW1QY1l6QnJ1cXc1cTRnOU9nYjhK?=
 =?utf-8?B?d1p2UDdkWGsrb3Y3dnQ4NGgyaHdGcHg0SlowaWJsTXpvOG9mbmdTTXFxb0Ji?=
 =?utf-8?B?emJ0TG5BU2xpckZ4TzloZFFQZTV1RUx1M1RMbUl3YS9aeVlLaE9ZUlRyMzM0?=
 =?utf-8?B?QnBaVTNVQ3ArMmo1a0oyeUJrMmlHZldTb1BQRVNOZFNva1VKSEdXdVVaUjJn?=
 =?utf-8?B?V01xRTFJZ2MreWdodEs3aS9HdGZoRnNRS2Q0Yk9IUW1OR0Z5akQ3ZVRYRVFs?=
 =?utf-8?B?eWJsWjQ4Sm5HKytyM1ljMElCYkJzaXVmcHVDenVLVlY5QlluWUIwdWQ4TVZC?=
 =?utf-8?B?STEvRWJQcG80bHJ3V1dvUGVLQ0MwdEFFMllRZWZOSGNRMHVrclhiZERIaUJ0?=
 =?utf-8?B?NnNYQ2FSRTZVU0c0T3Nhc0FzcS93d2xWblRlY0V4d25mK0p5MmtLWUN0Qkcr?=
 =?utf-8?B?Y1RWeUtnNHE1bUo2MUlIRlkrdEc1QlhmTTVVTGJ0WGFvRFoyd1BCeXVLNjVl?=
 =?utf-8?B?TzUzdkZzdHh6d0k4WHRLdmhwZGZtb2c4c2taYnl1bE54d2ZqWlF1TVRBU1Qw?=
 =?utf-8?B?WEJVV1NzaFhMdzZRK1pKYzlOOTJOd2dLUFBFcTZvQ2FMZllHYjFaYVdlY0o1?=
 =?utf-8?B?MlEvRWpGZmxFRW9makMyOHVOTSs2K2p0S25iMG90NEJSaDEzdU9yeUQxRGhD?=
 =?utf-8?B?ZXhMZmxGcEJtd0NNR21DS1RaNlNHVEFHc0VZWEFaejhPUTdjQURBTXcxb2dG?=
 =?utf-8?B?TmhsZDVKQU55WlliZnVEUUxkSDNsNzVhY2kxVytFbVBzT2pkejJHR3YyYzdB?=
 =?utf-8?B?WlBFL2xQWVBpZUt1R01MdnRIR05WdzBwNHh3bXlheGlJYVREL3lRM25pcUox?=
 =?utf-8?B?cjJEWlpWRE9wcDFYZ083djN1TmV6aHBTd0JsRnltdEwzK1dLWUFvSC81WFVR?=
 =?utf-8?B?bWthRkxJL2RmVldjNHF1bmRLU3pXQjhnaWVRalVhbi8yKzJrSUtFVWlrbFlr?=
 =?utf-8?B?MHp5VzZqclFMbUNqZUlra1JtdG4wdndYWlJ0T0NjTDBNS053L1ZQR1NycGo4?=
 =?utf-8?B?eHAwTkpCUWc1aW83UlFoZkVjdmhuWG5Bb3Z6S092ZzZUNXdVR3JvcHYxTjlJ?=
 =?utf-8?B?ZjR6SjVHRUVBTVdxMmJGWmhtS1VtZitqU00vdkpaNUhKbU1WbVIrYUxvZ3gw?=
 =?utf-8?B?TlNFZnNwQnVsTzNYYkU4bFB6VGVHNElXa2E2U1hDM2gzZUFNWVZkc1hSckVD?=
 =?utf-8?B?N0NaNDhjSFRnSzJOSEhVSk90NWNkQXFHbGdIRnR1MEkwZ1BqeHRsa1NlOXI2?=
 =?utf-8?B?SVJ3Vy90UkVySzV4WDRvbkl6Y0lOTTYyVE5aOHVtTU54emRDdTZhRXVZOG1Q?=
 =?utf-8?B?VGtnVWJ2ckg5eGZqQUZVWXdzZXdyK1Yxd1NIK1BpbmFKL0h2WFZyaVkxNkR5?=
 =?utf-8?B?amdndnBNVkxpekxDQ3NEdUsraG9VaVFMVE9Ud3Zoc21lczFhL0p2eitTR1M2?=
 =?utf-8?B?SzZVeFJNRGJpYTZud0JtR0xYY2d1azNjVXI3eE5KakViZ1VhL1ppaitRVHBp?=
 =?utf-8?B?NzJnTFV2aTRqM3VzOTNRbHBsaU9kbEFLSGE2dTZiTlhPejBpaDdpMzl2NGRy?=
 =?utf-8?B?Mit3bXVEdWpwTDJGL2NqOXQxcUVZVlo1M2MwZWxHWURiOEtmY2s1OFRwUlBz?=
 =?utf-8?B?dzAzbHg4UUZHTWpoaDRBcnJTVUc1ODJrQkl3UXJNd0VySnBCMGEyaXNUTzlk?=
 =?utf-8?B?aktNRzNqMGt0VFg5VWkwS3FvYUlraVVHeWtGVGhUU3JIZVRaUUlQNkNkMTQv?=
 =?utf-8?B?dUZJTXZ1eXJjdzJkaGZ6dFMzQ2Y3WWJ3T1JZSEV0bndJNlFRZjRqVXFueXA1?=
 =?utf-8?B?Z3VrbFRrU01mS2FOMkN1R3IvVVQ1MlBwRGRodzJBdUxCWTljUmJXQVY2VHp3?=
 =?utf-8?B?L09Nbk11NEsxSjR2QzNUV0lqYnlodzUxbk1XVFlKUUlYSGdiYUxNUHVVdndE?=
 =?utf-8?Q?k/t4KUZn7rvtM2LU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f76e0c-22a3-4c53-6dbc-08df3d061acd
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 19:34:14.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aejBqTmOV7M6geACYGPw+sIsRhAF0MCbGy4BrgQ3SLzuuBEwjRA+CSUMKYlEcuaY7ElkimFeR30wZi6U/GlEeo9aGaQJ6wMx6lXwQFNVwCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB842448

On 2026-11-07 12:36, Steven Rostedt wrote:
[...]
> Still way too verbose for the fix. It makes it sound more complicated
> than it is.
> 
>    locking/rtmutex: Stop spinning on the owner when the waiter is woken
> 
>    The top waiter of an rt_mutex sets its sleep state. Then it spins in
>    rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
>    the waiter back to TASK_RUNNING. The spin loop does not check for this.
>    So a timeout or a signal is only handled when the owner blocks, or when
>    the waiter has to reschedule.
> 
>    The rtmutex_spin_on_owner() is just an optimization with the idea that
>    if the owner is still running on a CPU, it will likely release it soon.
>    If the owner gets preempted or schedules out on its own, the spinning
>    will stop and the waiter will sleep. This came from PREEMPT_RT adaptive
>    spinning for rt_spin_locks that allowed them to behave more like normal
>    spin locks and speed up PREEMPT_RT performance.
> 
>    The problem is that when this was implemented for futex and normal
>    mutexes it did not account for timeouts or other mechanisms where
>    the owner releasing the lock wasn't the only way for the spinning
>    task to exit the mutex acquire. The spinning currently does not
>    account for anything else but the lock being released or the owner
>    sleeping.
> 
>    Luckily, when the spinning task needs to exit the mutex lock code, it's
>    state is set to TASK_RUNNING. By having the spin check the spinning
>    task's state to see if it switches to running, it can exit the spin
>    appropriately.
> 
> How about something like the above?
It drops important information, such as the user visible impact of the
issue. How about this remix ?

locking/rtmutex: Stop spinning on the owner when the waiter is woken

The top waiter of an rt_mutex sets its sleep state. Then it spins in
rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
the waiter back to TASK_RUNNING. The spin loop does not check for this.
So a timeout or a signal is only handled when the owner blocks, or when
the waiter has to reschedule.

The spin is an optimization. A running owner will likely release the
lock soon, so the waiter spins instead of going to sleep. It comes
from the PREEMPT_RT adaptive spinning for rt_spin_locks. Only the
lock handoff wakes an rt_spin_lock waiter, so the spin did not need to
check for other wakeups there. The spin was then extended to all
rtmutex based locks. Their waiters can also be woken by a timeout, a
signal or a ww_mutex wound.

The owner of a PI futex is a user task. It can run for a long time.
With an owner spinning in userspace, a 1ms pthread_mutex_timedlock()
returned up to 1.4s late in testing. A signal to the waiter is delayed
too.

With PREEMPT_RT, two contexts that take two ww_mutexes in opposite
order spin on each other. Only something else that needs one of the two
CPUs stops them. By default, the fair server does it after 950ms, to
run SCHED_OTHER tasks.

Fix this by also stopping the spin when the waiter is TASK_RUNNING. The
slowpath then handles the wakeup, as it does after schedule().

PI mutex throughput is unchanged. The futex and ww_mutex selftests added
later in this series test both cases.

Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
