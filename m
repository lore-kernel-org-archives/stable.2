Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603817;
	b=JwTVgLzNPPUh18Gjf2P5sxVmCswHpFDpEG/Y+3d/hqZ+IT8yf2Fn/idjK0RKwNa3EGhl
	 2YtvIjBhtDBRmW3Gnw1gZ5vpSYzegw+8F+U7WKzAUjgy+uuGvHt/ols0ZrQQkk+4XM+54
	 p03djozqFdBKhP7Ymy/i/ITKQsMmKx8NeYOjQKKNU1iQzTfzFrTDNZXpS4x4U8inLgcVx
	 3Of62G8lajYeUKCWvxxMhmAmAx3zQBY0YF9FQwiyfmSawQkieGC2vai0ek/MAggN8gW0d
	 7qLxRCqcFrK8QPhF9OUdba/DJgw74vhBZ6oul9RItE63DzmQ1d5Egqx99Msu7cEMoUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603817;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=L5ND1gKkQ2iqgI5hfsJbYsLZshs4fja5H3ptYfML2fc=;
	b=c1hoxtlk4pPxPnPAsOsZaLuakZGnt21lr/3yljmxKgNNjxDcqvWqnfq/8CPSHJvDYT+O
	 KsfEvn2dhD8WF0Ysa9cvbQwhEZFmkGwHc2KQDai5nSnZ7P8r0ABWxaCow+jYnZAZ20kYd
	 Zj4lrkoycQ+pJ3/BY+G/3d4LFeZFxINyceSBZwsP30gCq1AUrqse4vJEVP3H1P37wowIL
	 s45T9+Ux2o49QBNrq1N7/4gHDQ3Dv91vpDBwAcoiTteYCr9w2AfLY9HD55FMgMvf0lYXt
	 RotLmaSTjlLTkakxthdgQq6qUtjJ0Qr1ByeGlZ2dtfWxc1pIPBqKlc8PTF1OO8x23CQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r2QKWLDN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.29
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F0606A329;
	Mon,  2 Nov 2026 07:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A07F0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r2QKWLDN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APuIER0dCxNZMFSLaQVvkBWpsbk/9duKIlGj7bItcyQQ3ev7H9D8FeumlM/NM5b/yZFOwpTnWX+jG6BqakNsdhHnrMxRGgGlSbjs5eqEQ0rBS650dZgUdt8IESwL1gDdIvzDTYbSd4ziSdaUIU0uulT9nSQ7iXeYf3pbaXcI0w/oMyxOBIPsXDGcB1SDZ52PzWnXuquLI1nU5forWzIZK+zd/hGnkq8l5fLtvJq4/JpU72XJYNsM2+VwDUP5/TYPzzRJ4BJ+jZi6ZVkgjlArtKMQPX593BrCQ607a6Lgxe9uWIAb69hNWBpchsFEfbKG/hT5Ai5RN7OlrD90soCDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5ND1gKkQ2iqgI5hfsJbYsLZshs4fja5H3ptYfML2fc=;
 b=y91x5Ui8P4IkG1lUaN+8H2k1PBefVgwvNmGlKJ4B1SkjwBBtBghZIDyn1nP+PQPKsE7XLzB1CSzTo/B5AstTpJbLw7k4XI4rxLOrlu9HDc4vFdCcOnJm+uiRDnTYmYwaaFbHgXiKzs+sh5m4ZI8IuJsjzNWDWxsRGExXdd1tP180Y7eUfYEngbmERttIaBA7fs92eqnrvZhMjKmA7D437LXYxXQquLSsUx9y1lYfZAsih4axCbgtbKR/JxgBu3Z3DyCwfMMAiy1UokFs7kqKxuARx2uQ4mUIQgda2VTguMKs0tlW/NK1eLM+xnJusd8a4xBi0ic9N55qS3nvAZM3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5ND1gKkQ2iqgI5hfsJbYsLZshs4fja5H3ptYfML2fc=;
 b=r2QKWLDNRbfj6oanaEsvaAJ2zLrB26VsfIcyxdCCQ6UtcrYCgxm4qUPKyG7wUEqNwSMMirpyXXRyzR+WPD0LXQecm4KCikV9i/QJoNHjzZxcqR5e9QK0yNhQIdR6uSZ7nsvJhgPPmQe/TpaygmVwasOCmuf9ENhT3QTKIS7WRVY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV1PR12MB484207.namprd12.prod.outlook.com (2603:10b6:408:512::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:16:54 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:16:54 +0000
Message-ID: <b61a304e-8fc9-44c0-ae6d-2e60af7be1fe@amd.com>
Date: Mon, 2 Nov 2026 08:16:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: xiic: don't fail a read whose data is already in the
 RX FIFO
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, siddarth@nexthop.ai
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
 <CAKfKVtG4oCxJEvsQEDMxZSLbjSgzTxwMQ8Ky2Q9FtN3=6F+_rg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAKfKVtG4oCxJEvsQEDMxZSLbjSgzTxwMQ8Ky2Q9FtN3=6F+_rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIXP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV1PR12MB484207:EE_
X-MS-Office365-Filtering-Correlation-Id: 35813898-3404-40b1-e18b-08df38b145b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|261028144727099003|261021121427099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	u2RBI0Az7fkhMJRTy+XK0Gm1eW1mkNuUc0YHdvCCohh3t9y+2M4kBHo81vKai8+t1NYO4yqE+P/DPyd2EG7/aW9kuyXy8ZiZZ0Yw89ws1li6bQCQrZb3IZVm4cscQ4qm9XvmEkbqrSo8sbMNsqYbvcRXid0rZfnBgZC4pcEsyCDljZETwA8fb5ptfPmmfT33I7F2rJdTfNOODvWGEsbwZ0Th5K72nXPkt38Ww2wTAn1/Mfq/McgrgV5rae6AqO50afqsotYP5t3UnzhIedrJTQbT0xfuPyhR+ICJA1lpKnODiAvXsTym1gSxmYdz5qW06nzIWSeafKBztx+g3670PeggxI2e3fzFKIhmmzgpsipGNeZdA3rhNGDJFj0ZCJf8kdMCOlTp1ndIMHHb36oD48CsNc5TO4OVuHZiS1nol+3qCADI8zJzGFlnhWDG2V7giefbWRTZPTXbAuju8NpO0nsRX8eK0B2E5sf93jOExl5OPEfnEq4V9NLLYgh9+BZqUiIMkqk0YFpB9wIkx9zxHub+7mx5JLPIQE9LUwuHmDtWhaAwIi3HtqJuGUksNAjyKCPBbqbmsE6905z35KuIeMxRyPeeIHaO+lNnKXJLRIs3TkShaYSgUzZUz4+68Q9G3tae7x0yQOVXPAi6h+dvQjxdFByQNaF7Hrn2mirCjkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWxmTzB6UGNCS3E1RXp3RWdzalhYb1Z4bEdPa1ZXT0R4NFJLMnc5RklBL1NB?=
 =?utf-8?B?elVjMHJTeElVREtHRHRBY2cyMXNURTcyT1RXQ0lZSWdpakZzdWRnZ0NQZ1VW?=
 =?utf-8?B?RVpnUmJQb0NENFVxeUpKcWtrSlo1UGduVDVUcDlvSjhYeTBHMEtQOFQ4QzJn?=
 =?utf-8?B?WU5EaEoxQ3VCTHdLRlRndURzUllFQUFUbDZOMXRFWFlibHpUZWhwVStoQTRq?=
 =?utf-8?B?U2o1UHdOZUhrL1gyOUZjenVvTEFQR0I0QkxaMjJoa0ZNS3k1Z2RPdHlYZk1v?=
 =?utf-8?B?SjErSE0rV2JmVkRRNEJiNUxWTDZSeFRmTWhWOXVIa05CQTV2YmsyVjFoOFRP?=
 =?utf-8?B?NUlMR08zeGl4YWRTejFlTGhrNXc1azhINWowbmpibTJsTG5MQW1NNjJZTXVB?=
 =?utf-8?B?UGRhckU4V0dtc1lkUUdXR0lDbjBRL3JTckxBVytYUUp4RFJHYThIZEc5aFIv?=
 =?utf-8?B?c3lXSWtWcjhLdjlwdXRBdTBvUXB3SnBPRmp3NXo5QWN5R25pSFlkS1RGNnhi?=
 =?utf-8?B?bWwxUWVpK1k5dnk5MU9xOURydUwrMEJBVEQ2Umhld3ZaKzI2SCtlK1IrY3hR?=
 =?utf-8?B?SzVJSXRFRmNjcUlwelFkb0FXdFFyUmpCWDVZNVdWa3RxWGRyTks3NHBSMVR5?=
 =?utf-8?B?T2o4bC9pdng4RDNhcWszK1FRWVdpVEpTZGFqMU5TdS9oRklhcVFJNm9PdE0w?=
 =?utf-8?B?RXNWZmk2Mnl5SExzODAvWS9ubU5ONmE2ME54MFAwemkzN2VQRVM4T2VvclJM?=
 =?utf-8?B?WWVoK0daQVBaMlJ0UDZRWXZHdWlyMTJxMGhXbktHZ1FGZnlOUnF2YmpwU3kz?=
 =?utf-8?B?a0MwSm5aZklsZy9IYkJFdk5LY1pudHY1eERXVU80dXd6VGUxZnN1NUdCQmhZ?=
 =?utf-8?B?dHUwN293UVVWS2x0QkpwU2NidDhoSDkwRjBtSUlFTStxWVpkeXZmeUhUZ3Vh?=
 =?utf-8?B?KzFmbXV1aGdmMkJ5TE00eDBtd092aXVmbjRTdWpxVzI2aTNKaGRndHg1eXl5?=
 =?utf-8?B?TllwRTM2QW9ZOUhqV0hSa0FpVUlaTlNZNTBiN0dYQXkrb1RYU0x6V3IzUEhm?=
 =?utf-8?B?bmx5V0ppNGc3dnpHdXlpM25tQjMrTlhHRU4rZHZjNWt3SGdDckIxbmtMK0pO?=
 =?utf-8?B?dmdnejRWbHlXK1MrbUJYemlRT0QwbS9CZWZNRU8xbFpuT1kxVmtrTWY0QkRy?=
 =?utf-8?B?R01NNDlJS0hMMHlua1Y3WFRxajdpclhQS3loNTZLVm0zUUhtbTdFV1pSOGJM?=
 =?utf-8?B?ZFJSSVhWeHpNVjYwd1RzNGk1Vk9Lc2Y3SmZaNDQ1enFhNTlNNVFGMlJ6bzJy?=
 =?utf-8?B?eWtXSHhzajdVamNuOXhnYUY4bGo5K2daR05tMXZBRTB6NDdlYXpVckZQcVQ2?=
 =?utf-8?B?aGVMLzJaVlVkK3NxK0E4clNaSXhqR0ZXb1d2d0Vqd1dBNEJLbTk5VE40SEtr?=
 =?utf-8?B?cklSMnZGaWJ3czZCWXZjSGEvaDJhWWFKMmY5dG1XcHBoYSs3bzJ6SmxML211?=
 =?utf-8?B?NFRlVDNBZStVT0VBTzVUcXY1bFhmakcvcUg1MVZRTXBKSldadzlPRGFUZlgx?=
 =?utf-8?B?RXhDMnFrNGtCb1RBdDlsZk81MFpCazFrbEpCZXAwODVhbGprOTlzclFYdndS?=
 =?utf-8?B?VHhwYXdjdWpDenc5VW0yN0daQVZTNGZMMGFIcVM0S1RQSGJOanVjWnF4VXlw?=
 =?utf-8?B?TVpOSFA1YTVjQUd4WnBHUXlrdnhJQ1Q1b2dPamNiNlcwcS9mZ0RKdVhCcDZh?=
 =?utf-8?B?akZxM2RrNy9BdzVSam5KZnpVVjltTDV2VkpKdSt2YzFBcmlWVFJIM0Vsd0JR?=
 =?utf-8?B?OEd0eExKUXYxSUtveHl4VmpzS3lib0FRTGdEVlROaGczaUtnc2hVSVB6bHY3?=
 =?utf-8?B?aERGQ0FVOW80S1FkdTBvd1NBSk5aYnR0MDVjZ0R3SnVzZDFEMXZXeDFjVGtw?=
 =?utf-8?B?QTJGZG5qN3AxRGVjaVU5b0V1T2RybzNqSVhJaEMyN2swRmNLbHlzeFRMbjIv?=
 =?utf-8?B?a1cvSnpvR243SlVuV3Y5cjUyR0xGYW9la0lzSXpVZjExMzdZOUdlZk9OaUdT?=
 =?utf-8?B?TXlxSnNFRFpTblJJdFRhbmhaSEpvRXJkdDk4UHZJMzEzQTZKTHIyQlhuZmR4?=
 =?utf-8?B?Q1FvRm5YQmg1ZkIrdWg0NCtGVWlRSHhrdFZVU2xuZkpWNHUvb1lGTjFiVUhG?=
 =?utf-8?B?QkNTRDFvZ2xtOEZmWmVRUVdBcnJzSlN2aW5jR05GeUNOZW9qTVNraXd5bXQx?=
 =?utf-8?B?K2R5Z3BhS2I5RElNSkU3Qk1NbjF3NlRLUzJGY0NZZlRlKzNiSWZabjhEZk1L?=
 =?utf-8?Q?H52HF5PLMAAyKBxhOr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35813898-3404-40b1-e18b-08df38b145b3
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:16:54.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x0LtsJakbHzHnUGyqoTd9qowX3KLTjdNKEqs5sYAuUV3i9gA6OZAVbKgHavhyt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB484207



On 11/2/26 06:13, Shubhrajyoti Datta wrote:
> On Tue, Oct 6, 2026 at 12:21 AM Siddarth Chilukuri via B4 Relay
> <devnull+siddarth.nexthop.ai@kernel.org> wrote:
>>
>> From: Siddarth Chilukuri <siddarth@nexthop.ai>
>>
>> When the controller is the master receiver, TX_ERROR is set once the
>> core has NACKed the last byte ("transmit complete" in PG090). We have
>> seen xiic_process() run with TX_ERROR set but RX_FULL not yet set,
>> while the RX FIFO already holds all of the remaining bytes of the
>> message.
>>
>> xiic_process() treats TX_ERROR without RX_FULL as an error, so in this
>> case it reinitializes the core, the data in the FIFO is lost, and the
>> read returns -EIO even though it finished on the bus. The next read on
>> the same adapter can also return stale data without reporting an error.
>>
>> Fix this by checking the RX FIFO in the error path. If the message is
>> a read, there was no arbitration loss, and the FIFO has all of the
>> remaining bytes, handle it the same way as RX_FULL and complete the
>> message. Since IISR is toggle-on-write, only clear RX_FULL if it was
>> actually set.
>>
>> We found this on a system with several AXI IIC controllers in one PCIe
>> FPGA that share an interrupt. It only happens when at least two
>> controllers are busy at the same time. With 12 QSFP-DD modules being
>> read in parallel for 480 seconds, the failures went from 2083 -EIO and
>> 1158 reads with wrong data (out of 11.2M reads) to none.
>>
>> Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Siddarth Chilukuri <siddarth@nexthop.ai>
>> ---
> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
