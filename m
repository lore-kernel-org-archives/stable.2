Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022872;
	b=G9aOurrIA0qch/O9yeQ5ZJpWvrqUgzhziQA/AXwBUqZU5xVK5MvyoSLh009VHsF4BHpF
	 EDILhpgZ0PxGwLJ7oZ1MdUDUnNwQMi7fVJAFixqlR1YRt8TDnsW3QJjrczc4Tn1CWxDrn
	 kYOUxDMCqiakt6jGvy+O8N6hNRdm11NaejjScZS6dvL21KfgzW00Gj3o5BVtrua1N9cBf
	 s8LldmDrUc1pu0g+iMpVuset6l+Q7lc8p2Hlup38y6RpYgoeQNdAm0CruXAQ2VarJmN36
	 W2NDuWitz2J4UuZWC5Xn0AaqdkRhiwZbeYVZqQJqNKp8vO05CHrePvqXIOEwfsovDqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022872;
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
	bh=lpv8PvguJfE4iW1m8aoEdB6tdwfBLwr+8CJ8tZ8cdx4=;
	b=H+xhiu2wZO6y1eodwgC6lGiUlwxA4/UilL+OxfO2UTapTwgsvnkuy/z8t9Y+nOsgb89i
	 PfNaYahycqt/dGZRUZoY5QjgruJuOABi3o/tT4ZvQG1lFyJPw7lKlmH1W0oFrdTJMJD5E
	 uXzLQgfVKRFraV4KXvukeDLynpyQw5NOBWAMHt6kDz5uuaqA8Y3F1r+1xdTFHoUa44+yl
	 ImwjSJ0a6nWCvSpeeDLwxa/XiR//xYId7z04QxNN+wB24w/b9GsayMYvlTQFwDudWhUnb
	 Fi6Elm0tyhVCSms59jc4Fs0aMlByYVfJjzCGs4KxkV5Ijc4XATSa8MX4oi2Bi1RDKxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=VRMGWKp4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.129
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020129.outbound.protection.outlook.com [52.101.189.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A18606B5E9;
	Wed, 18 Nov 2026 17:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A18606B5E9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=VRMGWKp4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNqb65gwDd5Auzq1dGg5gfshxwz9L8CbPyPl9AAEYYrq7UYm4A4V90ybl1Jl2qNZL1tJPfd0eTIi3RVKKyK0utOGLBUS1w74qvPomf9+lnVAZHhecOvpKSunYRO5b3TrqV6WWlrkK7fs+RmILCEYktlclAOuRouppeXZyCLmcCEeRN7ppP9rPOMrMSYvxhU9HyzydEe9TqZfW87KuVLWd77yMjPjipvJaQIzRiU4V8Ka3i03Ym30Bj3owXqYTFkBrbDNRfjA3/6uLmxUoBAbQewp+LZvSJ1JTkLQnnT7RyFO9rc1T9AzsJ7+8V0SYU+xEt8thkbZchpHUG4yhJAv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpv8PvguJfE4iW1m8aoEdB6tdwfBLwr+8CJ8tZ8cdx4=;
 b=DN9e7xAjPWioNU1MWGox3qpW5RZcsKA9PScwmhEJRnqyd2tOGYILaCvGEMzRgcF00ICWXjB90dfsWyLBh7qg6apPU0ZXVJjKJ1ZtgutJM2cl7wP612zmf3dtmrf1Q9P9KO6ofIBC8595ht3dmyhPaNL/nqGIycT4qTXeGj3/oLPuo6aoy5MbvTwsmyAHiMbxbWFJ3UO/nuhQkWXbKGEFHXCQsd5LFlG3gIPMDRBZl3aQdA9S7zTRudzBjaf3FX6WERaahDdyopa1uaG5mATaqj5eC/0OMtX2c+LYF8LTz4xlkwTtPwS2Wq1vhnC7FGioCt4oVUrAV8w0cCQsYDNb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpv8PvguJfE4iW1m8aoEdB6tdwfBLwr+8CJ8tZ8cdx4=;
 b=VRMGWKp4uhTBRKivegmHqtA+LapMixvl8Xx/HwkEH+gobRJELR08VcP6RepO10remt5miBSK2V+tCIEQqJWQgAoTeHT8ka67mmNlvv73gdZYKpwEgwupb/wTpxOP8vRPLyCV0kWkLvRhCrtoyyHhHLHldFvMD9I7YIIx0QqNKc6an9/pwtRu6dFh+XPs3fJXy8QxebllsevcKnr6TEXmpFaKC77JwCofiXh4sPWSqnhPA5IhaAyUCql3e0IZup/kIBFipC/2h+blEEHRtRyLXwXMi5Z5tU8w6ZQppkk/dO5kOT2CfeFQ5bAO3yYiRuS6autM6+h2B19ha9La9Tpgfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB6345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:27:47 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:27:47 +0000
Message-ID: <8ba74adb-b8c4-4109-b20c-7094012d4853@efficios.com>
Date: Wed, 18 Nov 2026 12:27:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] locking/rtmutex: Stop spinning on the owner when
 the waiter is woken
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-2-mathieu.desnoyers@efficios.com>
 <20261116120626.JVHxeSTu@linutronix.de>
 <83330898-b6de-469c-ac20-7367c1eb4f0e@efficios.com>
 <20261118141912.GnOg6YYM@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261118141912.GnOg6YYM@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::10) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fd609e-6ae1-49ff-25fa-08df4599434b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|56012099006|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	Ln7XNprr7baW+szHap9QzXJdrcmZ1Q+lS2LAXumrmhuoQXbsQeNK0jOjSQEEj5g2okjZYJkxiS2GYe79CKsTtCFt27XjX7xtmyYFICud2kOysFEAFkEIeJq2U4XhJWQNxvdzDAaQwEcRjWkn/L9ySC5uh6nRfw6RAYaRwt0yH/PAG1+JciOOjUWcW5r6drl0Y5gQm8meSUSEqACXnlEHoElymvpwhSxmmismE59aUSpmTGCxHytJ/07UphqQ6zMoXgvT6etCH0rVfoMtzhrVVDsrc5IZ5Ans/bwsd/dZcL3eGJqBG2jHJOtOWt/FudR6m4xJ1ZQPXD7Ff/cctiZ9KgpYohWIQJaPGKXtHZ4T2/KlO1l6sGTXlhITy602HubxLYaWlWPvjwPuSGUzl9UXOeOCIrj0CsGFzJbZj+vDAR/gJmDlrJXHFgCot3IRzGvoBdQ8nQWMAyy4/oCQLnPJKFh2XxfS2yKMFZx6nHreC1EXyIlvYtlOU2baZk+YcAEORSKq3f8A3wN+udQY/wDLq7exQ5obtAGquBodU0ai4ZTIF5M5/M3dVeG7C7UWfh/ah74SSVMNV60QtloyblkqvMpPpY1cn8v3ThhwNMVLyRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0RubXQ4U2x5ZjNlN3lsVlpUdEZ6ODhta253bDJGT1FPdU1ENUVYdEZIb0lZ?=
 =?utf-8?B?WjkyclkrRjJRcmNRUDMrLzdBMUVQTUt5a0ZrdTVOeHFsUTl3Q0poQkk3K1dI?=
 =?utf-8?B?cTBidXFzaEp0ZXR5MXFYTytUeDViaWNGRW0vTHl2blFnZXdWZ2I0SVRlNi9F?=
 =?utf-8?B?K2RiQkQ1MXFrZmZCTVptQm5kUzZWY3h3UU5BbW5tZjE3TFRNRXJkSUtqMklz?=
 =?utf-8?B?YVdpMzBBY2lBY2lxRHFBSDZ1OW82Si82Rk4zbWs0cjVLQkVZczFldlJkclkv?=
 =?utf-8?B?ekpDOS9kWlpIVlYzdlJHbUFJOUVhUFRiZmc0VU5KUlFXVEF2WmJLVDdpelVG?=
 =?utf-8?B?R3BCc2tHYmZEa29aTllCVTA3VmVJZEZSSThlK2NONXhhb0ZtcXFNZ2RZRURv?=
 =?utf-8?B?VTU5bUdoeXIxN0xYZytJeExnbjZFem02VlRiRjBRb0l4aXVIQnNWUWs5eVpp?=
 =?utf-8?B?V0gvelVGWlJRSGdWMDFjSzM5L0JzSkEzSnlEK2VqNDd4N0E5VlI0di9aVDNx?=
 =?utf-8?B?RFhLRVY3MW9GNFAyUGN0MWN4UGZWeEt2RStpWnBpWGJpdmJBbDRSM0hrVkVm?=
 =?utf-8?B?NXdIRkxXazh1Z1VBbkFvZXYyTGd6UnZWdndUY012dnlpVW1CM2NPV2piN0xT?=
 =?utf-8?B?dTRYRXNxOXVYcDRBUjJSbXZNUnRhekxnck1neEJnWXFjZE85bUVGMC85VmNI?=
 =?utf-8?B?TjF5d2JMZHA1UVdZVENySnhPbjFBZkVaUmJydVJINVFwbkJ0K3dSK2lCMkVk?=
 =?utf-8?B?RjBFYUJoRklRckl0UVFyNndlNkhGNFFNMmJsTkxpSytwZElMenJDTnlFa1lS?=
 =?utf-8?B?Q2JqY1oyY1JOU0xqR0tjeE1DYy9wdWdyckl2UFZiYUhSSGpIZFE5WFRFb2RY?=
 =?utf-8?B?Q1NGZ1dhRWVROVg1K3dPdXQyelpxZ2RvcHd2Q3daSXAxc3NlSi8ycmZaN0VG?=
 =?utf-8?B?aFJTL1Q1SksrNTZFR0tCK2liNXR4bm90dERFKzR5dmZNNkgrZTZJeDQ5Vlpz?=
 =?utf-8?B?WmRJYWhFTFQ2T3NZajdJbkZCYnNEdGVQK1NmbWFMM1NRekNETkNLTWUwTGRU?=
 =?utf-8?B?VU5pN3FJK2gyN0JSSFdkdzFUWVNxejd3d2l0K0p1dWtXZzNUUHMrd2FBRnlH?=
 =?utf-8?B?L005ak5yRllFeUxybUFScmgrVjBLT20vYkhYdWFmaFdxaVRYT1pURXkySTlS?=
 =?utf-8?B?ejJRNHNmSFk4OUtDSmVGM2NMaDdGbnpsRGhFRUdGVXFMSW4remFOZHp2Nzdj?=
 =?utf-8?B?OG82TVArNFd2dHdqTW5pS0xieE1OcnBlaWNGd0ViRmV4djNsNzVBUlEvek1t?=
 =?utf-8?B?Nytsdkw0Z3lURWRpNElFWWxtY1VDc21GUW8vblIzYXJTUnU1UlBTQXZobGV1?=
 =?utf-8?B?eVdGMGNlRkN3V1ZtVGg5WGVxbjVGeDVPaGU1Z2JiTURLU2VNckJ5dDRpTUJ1?=
 =?utf-8?B?WTBNUk1qa1BwU3ZzNG50bnIxNWE0anJLV0gvanRxUkFaNGdyRTdWcDk1blhG?=
 =?utf-8?B?Y3BnVjhTMXBsU09VaTIzcytETnRORGxIZEk0T0Zwc3NQbGxEWWRzVUpEb1k4?=
 =?utf-8?B?YW5tYlhwaVZ5UDMvUGE1YlVYQ3hKN0VBZkFkVnBQMklIdTFOdllRbWlNdVRM?=
 =?utf-8?B?VEljMFRiWEJPVm50Z2VuU2hGdUJBblYrS2dkanFKZm9jZW9qWFRoZGVnaysv?=
 =?utf-8?B?Tk9IUkhOMnRWODFQaEhuT1hqenZoODBocTlqQzlySHkvR1ZZY2xoc24rdFh6?=
 =?utf-8?B?Q3lObVBYS1dPTVBHM2poekZzdjNya2FUNzQwY1NtdUlEdmkxZmhaSzFrMFJq?=
 =?utf-8?B?Y1hObmNQYWw4M1pBZWo5ZlpPMnMwZzE0dXNiTDVMT0FTdWdSYW5IY0RjSUxC?=
 =?utf-8?B?QUdqd0RWZUUrdFF2WFhYSjByakJiNW5iMDBLSjNGVHVScXVjVzhDalltb0tO?=
 =?utf-8?B?Wk1QVzhKL2R3QUU3bVFtbFJ1V1VpL1ZzMUFCdkhDaEpoUGpDaUE1QUY3elUx?=
 =?utf-8?B?Skt1Rm1IM0xsaTExSDR2WHplcmt1STdmaCtWbjgzOHdPTG1wcHh5elM0WWVx?=
 =?utf-8?B?K0R1VXpETTU2NmpuaW8vZGl1K2xtV0ZXV0ZpOTMwMll4NFhWT2RWVG5wTkxo?=
 =?utf-8?B?Qk8vRHhBMDZNd2tobmhRYmgybkVTNEJmaTF5ajE4Z3NDaVllcW5JN0dBS2dp?=
 =?utf-8?B?a1R3c1FqNk5Ieng2YXZQSFUydnVvSW9LVkRxZ2Nna0tFWnlvRzZEYTY5SmRa?=
 =?utf-8?B?MlMzcjdvVDZ0S2NGU2s0ZDZCS1NtRW5iUDFaYzZXS2ZmNy94bkJDZHI1K2lJ?=
 =?utf-8?B?OHFveDNQcDRaalpRUlA4ZXljaUNZMm1LR2U3WHd0V3RKTG40bEY1S1hWVzFj?=
 =?utf-8?Q?nL6pWyOuE5UohSiMGsBTs9jCTmQ27+j8Dy6AP?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fd609e-6ae1-49ff-25fa-08df4599434b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:27:47.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7DFhnaEcYBhu1+tKhuvIHDvPO3HhqFhho5EQsAHKX9CNALRB7oHIeVt9df5LPPERB6PsYFZPsECQ+MdabqIal9t7rbxhbplQy1Vsu3TQm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6345

Hi Sebastian,

> > I kept the check for TASK_UNINTERRUPTIBLE on the rt_mutex side. A
> > ww_mutex wound also wakes an uninterruptible waiter, and the ABBA case
> > of patch 5 needs the spin to stop there.
>
> Not sure what is related to. I don't see this in this patch.
> TASK_UNINTERRUPTIBLE vs TASK_INTERRUPTIBLE would make a difference for
> signals here.

Sorry, that was unclear. The patch tests no state. You had suggested
to limit the check to !TASK_UNINTERRUPTIBLE. I did not do that. A
ww_mutex waiter sleeps in TASK_UNINTERRUPTIBLE, and the wound wakes it.
That is the ABBA case of patch 5. So the spin must stop for an
uninterruptible waiter too.

> For my taste this is overly verbose. In the spirit of "ain't nobody got
> time for that" what about
[...]

I will take your text in the next version.

> I agree with the change as-is so
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!

>               /* If became running, trylock again or abort (signal/
>                * timeout)
>                */

I will take this comment.

> I would drop this entirely. It says below that the check is for signal/
> timeout which is something we don't have here. So I don't think this is
> required.

I will drop it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
