Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854203;
	b=5OyOfRwNyH9wM9++pgNWhWjJ4pCzlgmewmng4jYbKme91OE3XwjykFatOHrkJTACC7vW
	 4LKvVnluN3HV3LFMx/wTQOSoileqlYVLmIy1Um6h0+S+hcB3vz7ucSHGJNEQ8huuVIHKq
	 jkOYcVLHrV7g08HVRcmIX7LXZW1bEeP//WN3vAsEi0MIOReNjk3+e6BbByMatNxibiJri
	 TsccSf+qP3R6fmiJMhAcxOgDRQ9EwxPozTuEJce2bhdIoxy2HeoDNs+PdgWf8LUCJr5ul
	 tdldj7IMJLVq1XEfY5WP/kEk4ao49q5A1sR2rwKksaYhze0y0v1LTu3k2hYM0sqnPJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854203;
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
	bh=m5J4ymMSP7M+4hV/9Ynb/c48cHZC/MrLGO+q4uZwgXo=;
	b=OSXhKuAVUjMqhfmWbbiBrTJk55ByjNgVsgcQoIOpCPK3eCIBHpSHq7DBp5+wxuwzuvfs
	 Vsi8BQp4lAx6eUmkyTjpMl9AmaCX3U5kTouuw5jXl8adN+KFRUOR3+yRzzeCtjQnX1BP+
	 KAf00xvU6NOoqwrClQQXfem8q1CyaZMgWPDhBw/OFAlKFyRzS0vNBBLSh1WVHoY9Xgcml
	 TTRE6dU6f/RWp+0p1QkYiybZGkIVGcqn86BFVz04YPxZebmRJRVbtdKOQvCekOlNiD4yd
	 3XUYHK19F4HGbyYWXqpFvVBzWFuLZNMWFDocVhFyP12oznRj8qCz8lhfEkuVqIsaO9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=AqTk2Brf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.85
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020085.outbound.protection.outlook.com [52.101.191.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87256606A32F;
	Mon, 16 Nov 2026 18:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87256606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=AqTk2Brf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1fBHQy56pPCQhHKq+TAaPRIhqa1HufePoFNusACyFTnJm5ucRo8kGjlKkSozaojdbzuf2E7ivHPHXEoeH1Y1UurfxNVeWuOLtt/dCp93w1NJBkbTVbA7u7R99wyPSFVXGHqm2HsnUhH2xnZ8Pz1pf4oRJg8mxxlMDFQLIp3eWjxOcifPcvPQXehwPUoZPPD6KN2zVhq9RjbSfNOwT+6AIzuczW8Sr80PnmZJjjqVzfoPHvh/W870f1D0vjsxXicPr/27T/DbSql745wXfMiCl3V+L2NKtXe+MwnIc9JNi4w76+WCgLTfp5+NJayyeajXOwybM6fCr1rVL8mZib4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5J4ymMSP7M+4hV/9Ynb/c48cHZC/MrLGO+q4uZwgXo=;
 b=ulAC/5O7t19pA/+u1wzF0CJWBOUgGx7oPYHTtugbkDvBjId1x2KTpkUDFePA5v4SJ2iIkKIGT2gHl/Bid4OkGH0PnAOcawN+YsEc7n+NG2v6xB4i+NiVRn7b39rTSyvdvccUW8qTDZzJtzs4bhdRyl+opUR/bf+5HXDI2rr0TmiAFOe3UaM/KGzLr9u3OZX5rYx/k2U3FGuPOyNj/nsrZlFIWmq4Wq49jZv0VwmoYdO9bAvuedeDWfyW2VivxHlJeq33eUoz1fQU4bNbzDo+pRyXnDhMhHobQQpM8eHqKoF6Aq1d5OR9Q1GZo6U3ADk0UL56QoRueMLYOL8i5eJ5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5J4ymMSP7M+4hV/9Ynb/c48cHZC/MrLGO+q4uZwgXo=;
 b=AqTk2BrfKotKEGZbTHJoJrO5OV0B6VeFNhJ1EWEq3KgeTHTfylc8uV+VkHkpMOl5YTer9R6VFcpPtnRv1NDon5NxxzslKHTftTb/y20qxnSf32TmxRlWUw8b5hMyMc0igWZRdxM3KP2TczGjmlGmlUBCc5zNgU7mlfe+ZMEc9IHZQLdoUZSG5uIF1QhZe9NQ0rwEbpmnK0To1ZX3hX2lr2DuqlqLbXxRqv70Ms24ghCEbKHM2SpgQABsfgq1aavpDbN7kmvq9y8GDmWSd5k5oew0jzwGwnvoSakX6eV+dyfh6THhYaObYHUp+Tb6WAoow1wwChMWpPTtRUigFwRrgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YTZPR01MB11800.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:36:40 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 18:36:40 +0000
Message-ID: <83330898-b6de-469c-ac20-7367c1eb4f0e@efficios.com>
Date: Mon, 16 Nov 2026 13:36:39 -0500
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261116120626.JVHxeSTu@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YTZPR01MB11800:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa9da60-c70d-4f0c-8253-08df44108e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|261013131602099003|261009223027099003|4143699003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jlmBew9x0Qgyz+cUk6veUn1fuIiW2ROu3X4bEDr5XoAHZiJ/QbJ8H2Qz0JDa+KGM7dC5Sq1iGEojRBtjtFB1BMfyWlx7A2lgpP0Ie57wSCoH5SInvxuP+N/2P2DcArB9i6eEbyEwvrJ4G0ZAxVef8sHDkkZWyySnbDjjD87Vk0E4Fc9wZq1bEZJdap037L45LERKY5cLQDAYEySGrRC8RR3/y5ea2Vk7OYWoUSCastSMyS5iKWasaC2jwPv9VFKz1BUOx09FV+UjhwzcadiBUB6fylp9bRSV5e7VMgpHtBOMnoFN3P9wXex14+mlr1kPFyR3KZaFoazCtAklh4Bz1a57oH9JLQ7o/lrY8YcHqdPotw0qjbYCMKT1ELQxHYG0EqIbqEXWWFDeK1zZP1bpyVWLC5n9ZfTxRYLa+mTFhEb9aW6yHviQgP6hHPur3Uwhv0kNAgFqujb+7OKPqS5ocgSK45UN5jBEa12QyhlNFgwJZxEjXjtWat/yHXv2Og0tNqnMv+zeZFztFg2sq1DNd2D8tEYf1jyWtgRt3IjxF8eMHzCzsMyiVnYrLpGdWlrClg4CLnNghkmZxJ9Oe4t7MJUjPjjMDVA5mW45Tb5clP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(261013131602099003)(261009223027099003)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXpmQm9GekJ1ZGlyLzRURXFiWWVsK2dqKzZQM2xIS0FNY01HWDF5UDZuc0dk?=
 =?utf-8?B?dVFQVk8wTThpdXMvMzgyS2JHZlZiYllza2NKRmdUZlNwQ1VJTzhLNXRTODhi?=
 =?utf-8?B?YVhXVzhCYW1BcjhpV2tSU3YzWm01bXFxckVDVk5JMklJK3llQlNGSzkvbmF3?=
 =?utf-8?B?OWZlTUN0c28wZ1RoUG4yTWttUW5ySm1XM2FFTDdRbUxDRDJxSnNQR1crRXNU?=
 =?utf-8?B?ZlFRTGtKNXJmbnpvcWxmWjcxWHdGQW5sUDc0a3ZxNFM5RTBGSEphRXMxczB6?=
 =?utf-8?B?UG16b3hWR3ZZV2kyMmttNHVjck5nU1BKaEtGQnBvR01XTTlKZ2JETExrazB4?=
 =?utf-8?B?bVc4dDZPMkw3dmIxQTRSeUExNU1KYWpmeDcyUlZHQXV5cGZGNFI5VDVja2Zy?=
 =?utf-8?B?T2YwZXBsTFRDc2M5WWc1cEtQaDUzSWV5VTg2OWFCN09jeFlkblB3Zit2V2ph?=
 =?utf-8?B?NVZPb09VOTgybkJQRXhkOXNvdCszeU9XdTdEaDViQTRweE1ycTFtbDYrOWxB?=
 =?utf-8?B?bUxMeGJJR0w2cFlWUXhrc3ZHRzl6NDRZVFpMbUdVMmhzai8xVkRSMmZBZ3dJ?=
 =?utf-8?B?SS9xc1NSTVJFMkV0NDNmaWtIU09UZEZ0RTZuVC83bUtLTzBjNHFOZmYvbnUx?=
 =?utf-8?B?bm1TME5uSVU4M3RhY0g1b1NSb1dWblNqaEJPOENiTXJDeElHRDFCcmZ0ZG1S?=
 =?utf-8?B?Rmx0WTJwbk9YUXN2aDc0N3JMRDNVaHBqKyszcHRybE0yRVR3VTdaQXErcnJW?=
 =?utf-8?B?Y3RHUGwrS2hyclprZHV0ZlBjQlVVTFY5cUNJeGlHeGFabWdkQ0lHNzZhVmpK?=
 =?utf-8?B?N0l2bi9jYW8yYXBhK2VlbEdvbzR0L0FFMkEvRzA4UE9jM00vbGFxRDgvRktk?=
 =?utf-8?B?dEs3SlVVWmZzYzFYOTY0Zk9oalVTaE16bFZmenduQlhqSWtheDlFOVIyVjNs?=
 =?utf-8?B?ckJoaUIxTWlTMnhrNGgzRFRMTTJyYmlnRmk4ZjdRQy84dVZ4RHM3ZVVMRXBC?=
 =?utf-8?B?VmRRenNibDBHZVlIb3NIR0tQcGRrcWZib3N6Y0RjSlJoUjJ2dUpUUUFTMmx3?=
 =?utf-8?B?akNvMmhiaU11UW13UzdWQUFFVVJBMXd4L3hZRGZRVnl3OE94azZEaHNvY1ZZ?=
 =?utf-8?B?ZmRmZ1kwS0RKaVdUeDZqVWRENytzVGtIVkNnbSt4T0FCdmVIZ0FYVndFTlRI?=
 =?utf-8?B?aTdWZU5WN3M1YlZZb3dmQnpydWVEREdNWFA4T1BJTmdxcUFUSGpYM0VwaFNi?=
 =?utf-8?B?Y2Z0cTZxVHkxK0pSSVNFSUFGUno2OU5jb3hxMWsySURBSC9kQ3c1bmJMOEFG?=
 =?utf-8?B?aWFvWk9PY3IvUGtFTE42aFcvTzk4VU9FVU1FaFV3bEg5NGVxMEwzMU4wR0Ir?=
 =?utf-8?B?VjdweFJtdzlPOFdtT3FYNEY5a3RYNHhUQzg4VDQ1K1VJd3ZURkJUZW5vRy9s?=
 =?utf-8?B?MHhqSTJCWnBtWDB2R3BmZVczTUtUZHVJeTN5Q1IwU05oZklzWjhlaEFTVzdm?=
 =?utf-8?B?ZERnS25DNVZPSTFmeGdLb3hBMHp1N2VkWDMvOGpOVXd3Zk00Wk0rN0ZxRzBF?=
 =?utf-8?B?THphRUlpeWNZUnN5cFV6ZDhsYzVkSTc4STVGaDJYRXFSeXVhNWhkNFlDMExw?=
 =?utf-8?B?QzFoN1B4YmFqZEtKdUxueTNqU2FwZ0RveTlmUDNGbVpwRGtlMHpIejdqYmg0?=
 =?utf-8?B?NWtoRjVvOWdIUjNkcUYyK2o1azE0K2xtdUo1VjgrZURVRW9YZStDWDZjYXVj?=
 =?utf-8?B?elN6akVHeU1pKzdjeXNjQktab2wvNHFhMWlnaVFPcjlKODF0OFowZXhIUmVm?=
 =?utf-8?B?a0JnQjNoTllGQVVXSmJVR1d1dG95WXc5VGEvWGtuUGZQOFFDSzhpU0tKaVRI?=
 =?utf-8?B?UzBjVWRPYnVjYVZ2bjJsbE5PS291ZXphMXRjS3ZNbnBsS2V6UlJ2YmJ0Z2Nx?=
 =?utf-8?B?YmtBSDlzTUhXNVFUeTZnVEJzSnUrUi9GaXZmOEkxZktHMFg1Z09MNlVIZ3hE?=
 =?utf-8?B?SGxBcnlyNnFJb1ZxWFMxekorMktNUERaWlNlUGIxZmRYdVhLQVQyT095bGFX?=
 =?utf-8?B?NHh5U1hENmpRem5JOCt0Y1U1VnkwQnVScjVKbTI3djQxVXVKYlV6RkV6WFIw?=
 =?utf-8?B?UXlmMllibUMrdU9QK3NYYlA1a2paZWJpQzIxc240REo4T3VHTGVWcU12UWVK?=
 =?utf-8?B?K0NjVGtTL1dBemJKaG50TytNTzdNNTdXekVQUGQ4VWFnL3BxbFBuanVQRmlX?=
 =?utf-8?B?azZZRUh3eU9uQUhGaUlSNzNlWXFrcDU0aWxJOENtNVVLQ1A2S2I1OHJmSjBt?=
 =?utf-8?B?TzBMOU8yTWtVNHBMbHpxT1pwcFZQNS9kTTlLdmpHMjNPbHcreVZLRnRTR3do?=
 =?utf-8?Q?AV16dX/Xt2aJr5Zc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa9da60-c70d-4f0c-8253-08df44108e3a
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:36:40.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 216cO2PYIoXyTwSsr/VXm5mOFgrHdGuDUik0nF2XeiU+WqQomSDkGvOBJJBh1HYPFs+ssIRzhI99AYAjGPlyekEeCXJH4kOvbwfzDnP+nEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTZPR01MB11800

Hi Sebastian,

> Wouldn't it make sense to return true in this case so it can re-evaluate
> the situation for timeout/ signal rather than visit the scheduler for no
> reason?

Yes. With true, rt_mutex_slowlock_block() takes the wait lock again
and sets the sleep state. Then it tries the lock, and checks the
timeout, the signal and the ww_mutex wound. A wakeup that is none of
these cannot make it spin forever: the sleep state is set again before
the next spin.

> Also, wouldn't it make sense to restrict this to
> rt_mutex_slowlock_block() (and maybe there to the !TASK_UNINTERRUPTIBLE
> case but this might result in too much code) rather than have it also
> available rtlock_slowlock_locked() where it makes no difference?

Agreed for the rtlock side. An rtlock waiter is in TASK_RTLOCK_WAIT.
The lock handoff alone makes it running, and the handoff changes the
owner, which already ends the spin. Any other wakeup goes to
saved_state. I added a bool argument, as you suggest.

I kept the check for TASK_UNINTERRUPTIBLE on the rt_mutex side. A
ww_mutex wound also wakes an uninterruptible waiter, and the ABBA case
of patch 5 needs the spin to stop there.

With both changes, the futex and ww_mutex selftests pass, with and
without PREEMPT_RT. That includes the PI cases of patch 4.

Steven, the code changed after your Reviewed-by, so I dropped the tag
in the version below. Is it still fine with you?

The planned next version of the patch follows.

Thanks,

Mathieu

-- >8 --
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Fri, 6 Nov 2026 13:56:54 -0500
Subject: [PATCH] locking/rtmutex: Stop spinning on the owner when the waiter
  is woken

The top waiter of an rt_mutex sets its sleep state. Then it spins in
rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
the waiter back to TASK_RUNNING. The spin loop does not check for this.

The rtmutex_spin_on_owner() is just an optimization with the idea that
if the owner is still running on a CPU, it will likely release it soon.
If the owner gets preempted or schedules out on its own, the spinning
will stop and the waiter will sleep. This came from PREEMPT_RT adaptive
spinning for rt_spin_locks that allowed them to behave more like normal
spin locks and speed up PREEMPT_RT performance.

The problem is that when this was implemented for futex and normal
mutexes it did not account for timeouts or other mechanisms where
the owner releasing the lock wasn't the only way for the spinning
task to exit the mutex acquire. The spinning currently does not
account for anything else but the lock being released or the owner
sleeping.

The owner of a PI futex is a user task. It can run for a long time.
With an owner spinning in userspace, a 1ms pthread_mutex_timedlock()
returned up to 1.4s late in testing. The timeout signal or any signal
to the waiter will not stop it from spinning, and the signal will be
delayed until it exits the spin.

With PREEMPT_RT, two contexts that take two ww_mutexes in opposite
order spin on each other. The wound that resolves this wakes up the
younger one, but it keeps spinning. Only something else that needs one
of the two CPUs stops them. By default, the fair server does it after
950ms, to run SCHED_OTHER tasks.

Luckily, when the spinning task needs to exit the mutex lock code, its
state is set to TASK_RUNNING. By having the spin check the spinning
task's state to see if it switches to running, it can exit the spin
appropriately.

On a wakeup, the spin returns true. The caller then takes the wait lock
again and checks why it was woken, with no call to the scheduler. Only
rt_mutex_slowlock_block() asks for the check. An rtlock waiter is made
running by the lock handoff alone, and the handoff changes the owner,
which already ends the spin. Sebastian Andrzej Siewior suggested both.

Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
  kernel/locking/rtmutex.c | 22 ++++++++++++++++++----
  1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5a9534c715b8..93014df90eef 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1494,7 +1494,8 @@ static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
  #ifdef CONFIG_SMP
  static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
  				  struct rt_mutex_waiter *waiter,
-				  struct task_struct *owner)
+				  struct task_struct *owner,
+				  bool check_wakeup)
  {
  	bool res = true;
  
@@ -1510,6 +1511,13 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
  		 * the rcu_read_lock() ensures the memory stays valid.
  		 */
  		barrier();
+		/*
+		 * Stop spinning when current is woken, for example by a
+		 * timeout or a signal. Return true: the caller checks why,
+		 * with no call to the scheduler.
+		 */
+		if (check_wakeup && task_is_running(current))
+			break;
  		/*
  		 * Stop spinning when:
  		 *  - the lock owner has been scheduled out
@@ -1531,7 +1539,8 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
  #else
  static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
  				  struct rt_mutex_waiter *waiter,
-				  struct task_struct *owner)
+				  struct task_struct *owner,
+				  bool check_wakeup)
  {
  	return false;
  }
@@ -1665,7 +1674,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
  			owner = NULL;
  		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
  
-		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner)) {
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner, true)) {
  			lockevent_inc(rtmutex_slow_sleep);
  			rt_mutex_schedule();
  		}
@@ -1890,7 +1899,12 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
  			owner = NULL;
  		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
  
-		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner)) {
+		/*
+		 * Only the lock handoff makes an rtlock waiter running,
+		 * and it changes the owner. Any other wakeup goes to
+		 * saved_state. So the spin need not check for a wakeup.
+		 */
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner, false)) {
  			lockevent_inc(rtlock_slow_sleep);
  			schedule_rtlock();
  		}
-- 
2.47.3


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
