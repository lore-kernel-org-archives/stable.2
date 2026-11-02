Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793620856;
	b=Kw2JKFUQrZDgKjrmwR/jb5TqrdNgOKrVdX41jFneB6IIcEm7/puzs/Py2PnRXbxt3sVH
	 TgSwZtXx1lOA7wvayvGvITWN+0flcBLHe67t4nXsPUOKsgYTMWslXg5BTRVSnDoE86nKZ
	 ITzT1uBlawhw0OXfIdMXWlW8UK3ozXqjiYyb2gKEOIMjCrUOwmHpFlI76GLwXqM7zs4RJ
	 wr6Uq04TcQsooVROPRkguPIWB0LtJgHFQ5Vb1xRD2wCpIMUcxoV1vIPrCNXOWvLH6/qhj
	 Fp1BpTOXbFoBa4pjx1LbSxw6yPSSQRVQLtwdmk4qKNiICcMpz9PxwEhEzOsFIpf5bNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620856;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Tuo/EcTDAS4YCTZgtXLJ0XDbI72sm7DaOg6aTwddUTo=;
	b=DvqH5fDGcZgWTH/hYihhx/PoEpazuJgmRb5jn6WW5GDXwcBYzXzyY4Pup2hNwKkqf6e4
	 TbidoldtssHAuqikjeKPta2K/KiegZhx+CtYPvXOG2PXYGAZWB4U5FFaSMdQHzOYVsOUn
	 RS5Gt3thEAdivAtC0255ExABEnKuwEJ5MvGP3Nzm6T5Idzpxo15glQv+xzxhv2ySEgcwt
	 5Rzh6g1J+KXhvx+7I7PzMVVP1ksB+5VmGQTk8oINWMf8wUWIDtVooilqs3tDHXrqO3vZd
	 TagFhuLGqvqEtvqq/UOgrO8t8yhxjTJPYCg2GNNpeGSkeSxyBFIzQA35QHfv/QuQtmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=iMxZ2xE+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92557606A975;
	Mon,  2 Nov 2026 12:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92557606A975
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=iMxZ2xE+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq3hzZ1Q+jv5T3Fe5cwJ8mk+x1zcFFPBFjAxypcCMY2d95jO0kHeWirfAI72s2f7KGmdLO+4kBZffaBDw3tJCLzRTrly/P9Ln0sUsld7YgzuH5394oZ6COxLYLRVpf0vLuesecxKIiMbo82XbBknpCykw3DuuMiapBxU49nYPxm2yjQWDXdnysjbxeLxzF3i+tt1MjfuyF5AgiptAyDX4rSUfNwEmgZPBEn/STZVP20FejvRurux+UxANgj76rvhFGj/gzHVOWLcckqfsvTNW/1MVZNYckrzs5mD459rqHszTm+gdCsrps7i4YvmlBP9pRMQniAZb2zczmGiyfSjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tuo/EcTDAS4YCTZgtXLJ0XDbI72sm7DaOg6aTwddUTo=;
 b=BqAvwjwljEh0i9gxgV9kOgWhbYryj82G8+A3l0qL4RmjwMYkyuLNToIfLznO2bPJo+KP3WNi8+PiE1HGFWyHAbcSikkCmgrgIkT06PXlkGOALrLweb4QwFtgTEuJoBKH/z87DEUqBuUrtpK1aK2l1/+J7pyyYbvqptCpMovjcnmPYV383d3mriIsr9bv8b/yKoJpc+nFB4uzYOrgjFzzunbvNyrYaVUeNoit4cVIXDERHE2rBT1+kiCB4WPYZiUlBSlZt+H93Miz5hRVXcYDw06i46recPMHOp7U1888jNUaXc7jhCycsUFinQV4mf31uZnaBetGEOx3d+AXZfwHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tuo/EcTDAS4YCTZgtXLJ0XDbI72sm7DaOg6aTwddUTo=;
 b=iMxZ2xE+4VIZ+MC2bFYfGqXJa/+fRC5+B+vLN8icRbVzbxkqjNxGBIwgC9J+jtNszgfr07Ungb2o0nveHicnXJuyLJompJHYIww3qzdpcHP/J7B9PaYWEPRdnSJkkhqb6VoahL1oUKimHfl3DhQfGRA3BNEGHP3uVvDMjgyiZwBozZ9UMgNsQT96KX71HxFdSL/0HaOqSFNvYi58sEuvh5OM0rDJJfv8Y8+ybR8dy2/x9ByeNhtOYUpoJyhX54ordkT9FcLjOURMhmcaB+lm94qwadqcqxMGEXwwppLUq7APr+zicmuK7SEM+AnrwTRXUft2Y/bXuffW/mL0hyq51g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM (2603:10a6:d10:1a3::22)
 by DU4P189MB3469.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:00:48 +0000
Received: from FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a]) by FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 ([fe80::4658:dbd6:d572:896a%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:00:47 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
Date: Mon, 02 Nov 2026 12:59:53 +0100
Subject: [PATCH 3/3] wifi: ath11k: add KUnit tests for crash recovery and
 TX status allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ath11k-oom-v1-3-f3c391bd63f3@est.tech>
References: <20261102-ath11k-oom-v1-0-f3c391bd63f3@est.tech>
In-Reply-To: <20261102-ath11k-oom-v1-0-f3c391bd63f3@est.tech>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, 
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, 
 Shashidhar Lakkavalli <slakkavalli@datto.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Jeroen Trappers <jeroen.trappers@gmail.com>, 
 mike Seo <mikeseohyungjin@gmail.com>, 1152007@bugs.debian.org, 
 stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Sathishkumar Muruganandam <quic_murugana@quicinc.com>, 
 John Crispin <john@phrozen.org>, 
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>, 
 Sriram R <sriram.ramachandran@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Yunseong Kim <yunseong.kim@est.tech>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793620836; l=18305;
 i=yunseong.kim@est.tech; s=20260824; h=from:subject:message-id;
 bh=tAokhiXonPE2e1/r9bXbqYkR/ZQ88n1f5oyiG6EA7jQ=;
 b=VP2Y6/soRsW/wExY2KsDTXIwLwWGU+o5kfRf8xiy0pDepmJx1AUbMOAtrtdy1c8SWchlJ7wUP
 gXcdFgKm2dpALqeXyPJ9Jj4LghdAaj6AQp6Icne7IzjUNvYU4fwunq3
X-Developer-Key: i=yunseong.kim@est.tech; a=ed25519;
 pk=nfdmjNawkxBHo9UNdzLNBEht8sYmXp0MYUsa/hwC7vw=
X-ClientProxiedBy: DU7PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::7) To FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:d10:1a3::22)
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
X-MS-TrafficTypeDiagnostic: FRWP189MB3398:EE_|DU4P189MB3469:EE_
X-MS-Office365-Filtering-Correlation-Id: afb82d73-5a2b-48b6-762a-08df38d8ee5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261021123027099003|11063799006|5023799004|56012099006|261009223327099003|261009223027099003|261009221727099003|261009220027099003|261009221227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SpYXkRgFv614C657BVwfd7oKcbzp2iVT3jt0om9VIQiKcK8vLOGtV2sZxQryoDGFS8i+ROxNMMTqy2uotm+AQrOphFhPIPMDz25EYnrGO52eLg4m5FtjFQmdBx63U0lZnhq54mYVsQEmbSw0Zj9MGIHq5FxOtYvcRqLUk7MFBW/msnRE4bWmnjOu7GDwe+KtMMdgNLw7XX0cnXayGJA71xRpF+3mcphg2sfUxhM82VhN9D6EU9SxpQRJcpLjcCzBfKxhVJltdUUtvy3RFLxnwN49e2vtEnZYghWwZHFvW3hr9vQjvrck8n/lxMvcJ4XWf36sgZEr8OYKhhP6fHOvLBILx4MdzFgud4IXjbKkLKRVCmhbEDM2eWtHj74ECzkFC6DNerATPwy4480Grjcl2ws2C6DGf6BoYwtIGXRuZKKkK0tU4HbJ6ee2mOqFgZRnXfRy0Z1hDA8GC0BFJEbSbXg1/PG+Iy/EI+IXyoWT1Hz1OwsRf2LZeoVg6zDei4KvFYWKjvXvVQVLsXeSXl0Y3quPw6Pq5hK/JVNoXSMdGuAQ3c7We4E389vk0amWsPu1at++wJOH3bCHZm9YbsbdG6qWa5Aeo8Ph2hLYcIfBnfr0mzkOXciZrNmOfJX5lsD+ue8fYGjKzEedNTO8g91VMf8n+kvjc9azaQZyofq2srE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP189MB3398.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261021123027099003)(11063799006)(5023799004)(56012099006)(261009223327099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXNlY1hQRXI5em5GVkdVS21Zd2xlY2p5OVdUcm9Qbm10bHBnYmhsM1pZNkJM?=
 =?utf-8?B?eFpiLzZwV25jQ2tTdUUxa2YvWmRuYnZ3eGVqaU8rSENzL2NubEhtVGNIREZP?=
 =?utf-8?B?TzFTdStsWDJGR1FSb1BRZWJwWktPMTY4UGVRWlFuN1NVSWhaY3pZMFlDMVVD?=
 =?utf-8?B?eDAvQkkyWnpPYzd3ZkxOZThsWmMvRVllb0w4RXMxbFVRdlN6KzhCWGNtdXhh?=
 =?utf-8?B?MHdDSlYyY3lTaUJzUytNVVA2MFhTaWlFTENYQk9hYjZhYzNxNlhrVDJTd043?=
 =?utf-8?B?YTBIVGh0M0JDVzhrREIvRWVyQ1M3cFlpQUJ6NkVYemdvMVVic1RDWEdwWWR3?=
 =?utf-8?B?bGhoVlFTay91a2c3NEdSNUVyUE1mTnZqaytWcE1wc0QzbTZIQTFKRFQ5R1cw?=
 =?utf-8?B?U1hmNk9lcmY0bHFNYWU5WWJTQWp5L01ub3VhNVZ1NkxzUVFEdEtmRTVYOGRk?=
 =?utf-8?B?Z25zR0dEdGRSWmx2ZGhpVHVwc1JvcGc2aU43d0V1QkNrRTRFNTUranFLQXJr?=
 =?utf-8?B?cHpabzFibHdEbkNyYW5PckdhN3J3M0xpbHlFaVV3RFFxaFI1UUloUmNLSlhP?=
 =?utf-8?B?OHFKaVdyVWpmQ0pQYWNxaE1tQXJOaDBqWE9CZ3drMFRsWi9nNGtWMjgwc1o1?=
 =?utf-8?B?UkhCQXFNK3BHWnp1R2lnRXFoR1cwZG1mVDZhaEJ3TDVvNTNxWW9HRTRBYlAz?=
 =?utf-8?B?THE3Qm9pa0lkN0dtM3NkVUZRVk5BbU9PcC9NemNSRWFFOFp3RnYvM1NnZlk0?=
 =?utf-8?B?UXdWTTNKM1RHM1F5WTJXUUhCNUtnQXVNbURHSG1mTmVPb2RKcjMwWmFDejFC?=
 =?utf-8?B?NXpjeFR5Q29vZWNBMk9CSHpsanhndEI3Zmp2dWtlMndIRkhRb3QrR01xMVJy?=
 =?utf-8?B?Wml0RWxNRGdiS3FlcmdBcUdxY2gvNXRyUkN5YUV4a1BCVFlublN1ZGl4Y2hE?=
 =?utf-8?B?V0RuMDlaTDVhUHdsaTZZY3JHY1o5K01LT1hUOHMxQWZDSUtkT1M5ZzVYck5Q?=
 =?utf-8?B?TjdTTTA5TWtlS3g4UFMrNDQ4YnRGa1pIRlNOYis4RENHSVNDTmhqMUk4bGxH?=
 =?utf-8?B?NDkrS1UxSDZ2cUI4S3A2eEV6VlFxMmFJd3FHY211aHdHOU1icElJaVNBR2NC?=
 =?utf-8?B?b09DejhxY1NwTFgwSU5tZmdtSzR4K3RMTG0rWDlGWVNDY3NTSnBuOE16aTB1?=
 =?utf-8?B?ZmlyeXhDRUtyenRYejdJbTh2T2JWSGNxN2xoYnBBeFlwTW9PbWZTdlAvVlo0?=
 =?utf-8?B?VDcvbVdiU0NLZkEzMUQ0aVJQZDBhOUFSdlcwaXpWUktyY29xSVVycTMrT3Mv?=
 =?utf-8?B?R0hxSHh5elVyem41dkEwbjhzcklxTjRDZGFCbUR3S0tBUnZmNkhQc2czMTJ6?=
 =?utf-8?B?SGJQZmNyTDh2VC9sWXpOc3lwcFg2VUZRQmF3YVNYYkZtOFZ5aGV2S3ptaG5s?=
 =?utf-8?B?UVR3QndUTFJnc2d0VVF2VzZ1dFRmd0s2RGN0MVRPc3VHRVh4VHNXY0JRMkt1?=
 =?utf-8?B?Z0hTV2FUYUlIRllHamt4RFJRREFKR3JzRThFSGg4dE5UUThaaUMwc0NTVlFk?=
 =?utf-8?B?TitoOHIzRGVtWXp5ZnRmTVkzSzdNUlVOUkpFZnhqMGxjSExhc0pEU1VHZ0pm?=
 =?utf-8?B?QlA2ck1qdWFvOFNzdFdEWlp5VUxZRkEweXAxZnhuZmhJRVlob3BOS2tyQlYw?=
 =?utf-8?B?ejhsUFFNbCtkTktPZWZycjhIaHRyN3pjM3BJaG0zRnRvV0xaWjVRd2FPaTZI?=
 =?utf-8?B?MFUxK0txV1hBVWZpRXdqRTV6ZGtybzR6WnQ3VmhkWGovc0t4R2R0UzJJaUtj?=
 =?utf-8?B?anN1M3BXcUtWZ3I5MGNpNVFyRmMrbU5YQXNVeDM3ZFBpL1c2SU9iRktYM2JC?=
 =?utf-8?B?dDltN0tvQ25MdG9Kb1F6K3gzeHZZK0JSK3lHV0FndVZtTEtGRjN4bFJhWWNK?=
 =?utf-8?B?V2hod05VbERvZEhURWVnNkJnWnhTOU9CWTZCK3Y5MkVWM1B4dlllenJ1bm9Y?=
 =?utf-8?B?NXZIRkNMZ1dQNngrRmhhL1pZK0FZcEFNK3RnMlFZNWZkb0xPdnpOd3pYU0pH?=
 =?utf-8?B?cUNvbllUTGYrMXFEYXk0V2puNzZyZm1senNOK0hvZGp5disrOTh2ejVNVjJH?=
 =?utf-8?B?R2trV0UrdlRCRHh5T1FueDFwTXJ3WUY2Y2pMK0pMSHBjR2NrcHVOTzcyelBR?=
 =?utf-8?B?VytmeVlGR09oTS82dmloMXVqWEFIUWZIL0FreVY4RDZVSGRrcHppdDRkd0hI?=
 =?utf-8?B?cjkzcmZsN01Pa3poaFJKUHlnOW45am1MbGxuSGdUaHNQYVU4M29rZEN6dmJ4?=
 =?utf-8?B?SXlKcWpqOUFLSHhUNmg0YlhiRHBOWjZpN2t2R0ViRml0cFJTNkNKdz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: afb82d73-5a2b-48b6-762a-08df38d8ee5e
X-MS-Exchange-CrossTenant-AuthSource: FRWP189MB3398.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:00:47.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAJzJlDk4zMh7dR9tssAJWwb+MVywNkAS/epVSGKkslzNmVzxuvus4maiCCwr8GIPFA802LVpSzAtlviBhOnmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB3469

Add hardware-independent KUnit tests covering the ath11k recovery flow,
TX status buffer allocation, error handling, and subsequent traffic
rejection.

The test suite exercises production driver code without hardware emulation
by stubbing firmware exchange and injecting deterministic allocation
failures. It verifies:
- ath11k_test_recovery_success: normal recovery flow through
  ath11k_core_reconfigure_on_crash().
- ath11k_test_recovery_tx_status_alloc_fail: deterministic failure
  injection in ath11k_dp_alloc(), verifying that recovery returns -ENOMEM,
  sets ATH11K_FLAG_CRASH_FLUSH, and leaves HAL SRNG memory allocated.
- ath11k_test_recovery_subsequent_send_prevented: verifies that after a
  recovery failure, subsequent attempts to transmit via ath11k_ce_send()
  are rejected with -ESHUTDOWN without accessing hardware rings.
- ath11k_test_recovery_resource_cleanup_and_teardown: verifies that
  resources (IDR, tx_status) are cleanly unwound and full driver teardown
  succeeds without double-free.
- ath11k_test_dp_tx_status_kvmalloc: validates kvmalloc allocation and
  kvfree teardown lifecycle.

Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 drivers/net/wireless/ath/ath11k/.kunitconfig |  14 ++
 drivers/net/wireless/ath/ath11k/Kconfig      |  11 +
 drivers/net/wireless/ath/ath11k/Makefile     |   1 +
 drivers/net/wireless/ath/ath11k/core.c       |  30 ++-
 drivers/net/wireless/ath/ath11k/core.h       |  17 ++
 drivers/net/wireless/ath/ath11k/dp.c         |   7 +
 drivers/net/wireless/ath/ath11k/test.c       | 330 +++++++++++++++++++++++++++
 7 files changed, 409 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/.kunitconfig b/drivers/net/wireless/ath/ath11k/.kunitconfig
new file mode 100644
index 0000000000000..b13aaaecf04a4
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/.kunitconfig
@@ -0,0 +1,14 @@
+CONFIG_KUNIT=y
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_WIRELESS=y
+CONFIG_CFG80211=y
+CONFIG_MAC80211=y
+CONFIG_CRYPTO=y
+CONFIG_ATH_COMMON=y
+CONFIG_QCOM_QMI_HELPERS=y
+CONFIG_QRTR=y
+CONFIG_ATH11K=y
+CONFIG_ATH11K_KUNIT_TEST=y
diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 44b520d2e66ee..2b688f1093457 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -71,3 +71,14 @@ config ATH11K_CFR
 	  to enable, disable, and dump data.
 
 	  Say Y to enable CFR data dump collection via debugfs.
+
+config ATH11K_KUNIT_TEST
+	bool "KUnit tests for ath11k" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && ATH11K=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for ath11k recovery and resource management.
+	  It tests crash recovery flow, dynamic allocation failure handling,
+	  resource cleanup ordering, and subsequent send protection.
+
+	  If unsure, say N.
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index b1435fcf3e1bf..e42a38a2d0269 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -29,6 +29,7 @@ ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 ath11k-$(CONFIG_PM) += wow.o
 ath11k-$(CONFIG_DEV_COREDUMP) += coredump.o
 ath11k-$(CONFIG_ATH11K_CFR) += cfr.o
+ath11k-$(CONFIG_ATH11K_KUNIT_TEST) += test.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b859b26f31114..27c08721c6a72 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2245,6 +2245,11 @@ static int ath11k_core_start_firmware(struct ath11k_base *ab,
 {
 	int ret;
 
+#if IS_ENABLED(CONFIG_ATH11K_KUNIT_TEST)
+	if (ab->test_ops.start_firmware)
+		return ab->test_ops.start_firmware(ab, mode);
+#endif
+
 	ath11k_ce_get_shadow_config(ab, &ab->qmi.ce_cfg.shadow_reg_v2,
 				    &ab->qmi.ce_cfg.shadow_reg_v2_len);
 
@@ -2297,13 +2302,27 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
 
 	mutex_lock(&ab->core_lock);
+#if IS_ENABLED(CONFIG_ATH11K_KUNIT_TEST)
+	if (ab->test_ops.core_start)
+		ret = ab->test_ops.core_start(ab);
+	else
+		ret = ath11k_core_start(ab);
+#else
 	ret = ath11k_core_start(ab);
+#endif
 	if (ret) {
 		ath11k_err(ab, "failed to start core: %d\n", ret);
 		goto err_dp_free;
 	}
 
+#if IS_ENABLED(CONFIG_ATH11K_KUNIT_TEST)
+	if (ab->test_ops.pdev_create)
+		ret = ab->test_ops.pdev_create(ab);
+	else
+		ret = ath11k_core_pdev_create(ab);
+#else
 	ret = ath11k_core_pdev_create(ab);
+#endif
 	if (ret) {
 		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
 		goto err_core_stop;
@@ -2320,12 +2339,21 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 	ath11k_dp_free(ab);
 	mutex_unlock(&ab->core_lock);
 err_firmware_stop:
+#if IS_ENABLED(CONFIG_ATH11K_KUNIT_TEST)
+	if (ab->test_ops.stop_firmware) {
+		ab->test_ops.stop_firmware_called++;
+		ab->test_ops.stop_firmware(ab);
+	} else {
+		ath11k_qmi_firmware_stop(ab);
+	}
+#else
 	ath11k_qmi_firmware_stop(ab);
+#endif
 
 	return ret;
 }
 
-static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
+VISIBLE_IF_KUNIT int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 {
 	int ret;
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a0d725923ef24..57895e4bafffe 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -18,6 +18,7 @@
 #include <linux/firmware.h>
 #include <linux/suspend.h>
 #include <linux/of.h>
+#include <kunit/visibility.h>
 
 #include "qmi.h"
 #include "htc.h"
@@ -1092,6 +1093,18 @@ struct ath11k_base {
 	enum ath11k_pm_policy actual_pm_policy;
 	struct notifier_block pm_nb;
 
+#if IS_ENABLED(CONFIG_ATH11K_KUNIT_TEST)
+	struct {
+		int (*start_firmware)(struct ath11k_base *ab,
+				      enum ath11k_firmware_mode mode);
+		void (*stop_firmware)(struct ath11k_base *ab);
+		int (*core_start)(struct ath11k_base *ab);
+		int (*pdev_create)(struct ath11k_base *ab);
+		bool fail_tx_status_alloc;
+		int stop_firmware_called;
+	} test_ops;
+#endif
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -1372,4 +1385,8 @@ static inline const char *ath11k_bus_str(enum ath11k_bus bus)
 
 void ath11k_core_pm_notifier_unregister(struct ath11k_base *ab);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab);
+#endif
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 45602ec2dce63..d1918f5d5e1a6 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1093,7 +1093,14 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 		dp->tx_ring[i].tx_status_head = 0;
 		dp->tx_ring[i].tx_status_tail = DP_TX_COMP_RING_SIZE - 1;
+#if IS_ENABLED(CONFIG_ATH11K_KUNIT_TEST)
+		if (ab->test_ops.fail_tx_status_alloc)
+			dp->tx_ring[i].tx_status = NULL;
+		else
+			dp->tx_ring[i].tx_status = kvmalloc(size, GFP_KERNEL);
+#else
 		dp->tx_ring[i].tx_status = kvmalloc(size, GFP_KERNEL);
+#endif
 		if (!dp->tx_ring[i].tx_status) {
 			ret = -ENOMEM;
 			goto fail_tx_status;
diff --git a/drivers/net/wireless/ath/ath11k/test.c b/drivers/net/wireless/ath/ath11k/test.c
new file mode 100644
index 0000000000000..cdf7bd4289946
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/test.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * KUnit regression tests for ath11k crash recovery and resource ownership
+ *
+ * Exercises ath11k production crash recovery flow (ath11k_core_reconfigure_on_crash),
+ * verifying error recovery paths, deterministic TX status allocation failure,
+ * preservation of HAL SRNG lifecycle, and enforcement of -ESHUTDOWN on subsequent sends.
+ */
+
+#include <kunit/test.h>
+#include <kunit/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/skbuff.h>
+#include <linux/vmalloc.h>
+
+#include "core.h"
+#include "hal.h"
+#include "hal_desc.h"
+#include "ce.h"
+#include "dp.h"
+#include "dp_tx.h"
+#include "hif.h"
+
+struct ath11k_test_fixture {
+	struct device *dev;
+	struct ath11k_base *ab;
+};
+
+static void ath11k_test_dummy_timer(struct timer_list *t)
+{
+}
+
+static u32 ath11k_test_read32(struct ath11k_base *ab, u32 address)
+{
+	return 0;
+}
+
+static void ath11k_test_write32(struct ath11k_base *ab, u32 address, u32 data)
+{
+}
+
+static void ath11k_test_irq_enable(struct ath11k_base *ab)
+{
+}
+
+static void ath11k_test_irq_disable(struct ath11k_base *ab)
+{
+}
+
+static int ath11k_test_hif_start(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static void ath11k_test_hif_stop(struct ath11k_base *ab)
+{
+}
+
+static int ath11k_test_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+					   u8 *ul_pipe, u8 *dl_pipe)
+{
+	return 0;
+}
+
+static const struct ath11k_hif_ops ath11k_test_hif_ops = {
+	.read32 = ath11k_test_read32,
+	.write32 = ath11k_test_write32,
+	.irq_enable = ath11k_test_irq_enable,
+	.irq_disable = ath11k_test_irq_disable,
+	.start = ath11k_test_hif_start,
+	.stop = ath11k_test_hif_stop,
+	.map_service_to_pipe = ath11k_test_map_service_to_pipe,
+};
+
+static int ath11k_test_start_firmware(struct ath11k_base *ab,
+				      enum ath11k_firmware_mode mode)
+{
+	return 0;
+}
+
+static void ath11k_test_stop_firmware(struct ath11k_base *ab)
+{
+}
+
+static int ath11k_test_core_start(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static int ath11k_test_pdev_create(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static int ath11k_test_init(struct kunit *test)
+{
+	struct ath11k_test_fixture *fx;
+	struct ath11k_base *ab;
+	struct device *dev;
+	int ret;
+
+	fx = kunit_kzalloc(test, sizeof(*fx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+
+	dev = kunit_device_register(test, "ath11k_kunit_dev");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	fx->dev = dev;
+
+	ab = ath11k_core_alloc(dev, 0, ATH11K_BUS_PCI);
+	KUNIT_ASSERT_NOT_NULL(test, ab);
+	fx->ab = ab;
+	test->priv = fx;
+
+	ab->hif.ops = &ath11k_test_hif_ops;
+
+	timer_setup(&ab->mon_reap_timer, ath11k_test_dummy_timer, 0);
+
+	ab->hw_rev = ATH11K_HW_WCN6855_HW21;
+	ret = ath11k_core_pre_init(ab);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = ath11k_hal_srng_init(ab);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = ath11k_ce_alloc_pipes(ab);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = ath11k_ce_init_pipes(ab);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = ath11k_dp_alloc(ab);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ab->test_ops.start_firmware = ath11k_test_start_firmware;
+	ab->test_ops.stop_firmware = ath11k_test_stop_firmware;
+	ab->test_ops.core_start = ath11k_test_core_start;
+	ab->test_ops.pdev_create = ath11k_test_pdev_create;
+	ab->test_ops.fail_tx_status_alloc = false;
+	ab->test_ops.stop_firmware_called = 0;
+
+	return 0;
+}
+
+static void ath11k_test_exit(struct kunit *test)
+{
+	struct ath11k_test_fixture *fx = test->priv;
+	struct ath11k_base *ab;
+
+	if (!fx || !fx->ab)
+		return;
+
+	ab = fx->ab;
+	ath11k_dp_free(ab);
+	ath11k_ce_free_pipes(ab);
+	ath11k_hal_srng_deinit(ab);
+	ath11k_fw_destroy(ab);
+	ath11k_core_free(ab);
+}
+
+/*
+ * Test 1: Successful recovery.
+ * Verifies that standard crash reconfiguration succeeds, clears recovery and
+ * crash-flush flags, allocates DP resources, and keeps HAL SRNG intact.
+ */
+static void ath11k_test_recovery_success(struct kunit *test)
+{
+	struct ath11k_test_fixture *fx = test->priv;
+	struct ath11k_base *ab = fx->ab;
+	int ret;
+
+	set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+
+	ret = ath11k_core_reconfigure_on_crash(ab);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags));
+	KUNIT_EXPECT_FALSE(test, test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags));
+	KUNIT_EXPECT_NOT_NULL(test, ab->dp.tx_ring[0].tx_status);
+	KUNIT_EXPECT_NOT_NULL(test, ab->hal.rdp.vaddr);
+	KUNIT_EXPECT_NOT_NULL(test, ab->hal.srng_config);
+}
+
+/*
+ * Test 2: Failure at TX status allocation during recovery.
+ * Verifies that when TX status allocation fails during crash recovery:
+ * 1. Recovery returns -ENOMEM.
+ * 2. ATH11K_FLAG_CRASH_FLUSH is set to protect against subsequent traffic.
+ * 3. Firmware stop is invoked.
+ * 4. DP tx_status is NULL.
+ * 5. HAL SRNG memory and config are preserved (not freed prematurely).
+ */
+static void ath11k_test_recovery_tx_status_alloc_fail(struct kunit *test)
+{
+	struct ath11k_test_fixture *fx = test->priv;
+	struct ath11k_base *ab = fx->ab;
+	int ret;
+
+	/* Run initial successful recovery to establish initialized state */
+	set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+	ret = ath11k_core_reconfigure_on_crash(ab);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, ab->dp.tx_ring[0].tx_status);
+
+	/* Trigger recovery with injected TX status allocation failure */
+	set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+	ab->test_ops.fail_tx_status_alloc = true;
+	ab->test_ops.stop_firmware_called = 0;
+
+	ret = ath11k_core_reconfigure_on_crash(ab);
+	KUNIT_EXPECT_EQ(test, ret, -ENOMEM);
+
+	/* CRASH_FLUSH must be set to protect the driver against entry calls */
+	KUNIT_EXPECT_TRUE(test, test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags));
+	KUNIT_EXPECT_GT(test, ab->test_ops.stop_firmware_called, 0);
+	KUNIT_EXPECT_NULL(test, ab->dp.tx_ring[0].tx_status);
+
+	/* HAL SRNG memory must NOT be deinited on recovery failure */
+	KUNIT_EXPECT_NOT_NULL(test, ab->hal.rdp.vaddr);
+	KUNIT_EXPECT_NOT_NULL(test, ab->hal.srng_config);
+}
+
+/*
+ * Test 3: Prevention of subsequent unsafe operations after recovery failure.
+ * Verifies that after TX status allocation fails during recovery, subsequent
+ * CE and DP send operations return -ESHUTDOWN rather than touching hardware
+ * or dereferencing freed/uninitialized memory.
+ */
+static void ath11k_test_recovery_subsequent_send_prevented(struct kunit *test)
+{
+	struct ath11k_test_fixture *fx = test->priv;
+	struct ath11k_base *ab = fx->ab;
+	struct sk_buff *skb;
+	int ret;
+
+	/* Run recovery with allocation failure */
+	set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+	ab->test_ops.fail_tx_status_alloc = true;
+	ret = ath11k_core_reconfigure_on_crash(ab);
+	KUNIT_ASSERT_EQ(test, ret, -ENOMEM);
+	KUNIT_ASSERT_TRUE(test, test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags));
+
+	/* CE send on CE 3 (WMI control pipe) must be blocked with -ESHUTDOWN */
+	skb = dev_alloc_skb(64);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	ret = ath11k_ce_send(ab, skb, 3, 0);
+	KUNIT_EXPECT_EQ(test, ret, -ESHUTDOWN);
+	dev_kfree_skb(skb);
+
+	/* DP TX REO command must also be blocked with -ESHUTDOWN */
+	ret = ath11k_dp_tx_send_reo_cmd(ab, NULL, 0, NULL, NULL);
+	KUNIT_EXPECT_EQ(test, ret, -ESHUTDOWN);
+}
+
+/*
+ * Test 4: Resource ownership and cleanup after recovery failure.
+ * Verifies that after recovery failure, a subsequent recovery attempt
+ * when memory is available succeeds, clears CRASH_FLUSH, and tears down
+ * cleanly without double-free or corruption.
+ */
+static void ath11k_test_recovery_resource_cleanup_and_teardown(struct kunit *test)
+{
+	struct ath11k_test_fixture *fx = test->priv;
+	struct ath11k_base *ab = fx->ab;
+	int ret;
+
+	/* Step 1: Initial failure */
+	set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+	ab->test_ops.fail_tx_status_alloc = true;
+	ret = ath11k_core_reconfigure_on_crash(ab);
+	KUNIT_ASSERT_EQ(test, ret, -ENOMEM);
+	KUNIT_ASSERT_TRUE(test, test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags));
+
+	/* Step 2: Memory becomes available, retry recovery */
+	ab->test_ops.fail_tx_status_alloc = false;
+	set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+	ret = ath11k_core_reconfigure_on_crash(ab);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags));
+	KUNIT_EXPECT_FALSE(test, test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags));
+	KUNIT_EXPECT_NOT_NULL(test, ab->dp.tx_ring[0].tx_status);
+	KUNIT_EXPECT_NOT_NULL(test, ab->hal.rdp.vaddr);
+	KUNIT_EXPECT_NOT_NULL(test, ab->hal.srng_config);
+}
+
+/*
+ * Test 5: DP TX status allocation sizing and kvmalloc lifecycle.
+ * Verifies that TX status ring size is 1 MiB (order-8 contiguous allocation),
+ * that ath11k_dp_alloc allocates it, and ath11k_dp_free frees and NULLs it.
+ */
+static void ath11k_test_dp_tx_status_kvmalloc(struct kunit *test)
+{
+	struct ath11k_test_fixture *fx = test->priv;
+	struct ath11k_base *ab = fx->ab;
+	size_t size;
+	int ret;
+
+	size = DP_TX_COMP_RING_SIZE * sizeof(struct hal_wbm_release_ring);
+	KUNIT_EXPECT_EQ(test, size, (size_t)1048576);
+
+	/* DP was allocated in fixture init, verify tx_status is present */
+	KUNIT_EXPECT_NOT_NULL(test, ab->dp.tx_ring[0].tx_status);
+
+	/* Free and verify tx_status is NULLed */
+	ath11k_dp_free(ab);
+	KUNIT_EXPECT_NULL(test, ab->dp.tx_ring[0].tx_status);
+
+	/* Reallocate and verify kvmalloc successfully allocates it again */
+	ret = ath11k_dp_alloc(ab);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NOT_NULL(test, ab->dp.tx_ring[0].tx_status);
+}
+
+static struct kunit_case ath11k_recovery_test_cases[] = {
+	KUNIT_CASE(ath11k_test_recovery_success),
+	KUNIT_CASE(ath11k_test_recovery_tx_status_alloc_fail),
+	KUNIT_CASE(ath11k_test_recovery_subsequent_send_prevented),
+	KUNIT_CASE(ath11k_test_recovery_resource_cleanup_and_teardown),
+	KUNIT_CASE(ath11k_test_dp_tx_status_kvmalloc),
+	{}
+};
+
+static struct kunit_suite ath11k_recovery_test_suite = {
+	.name = "ath11k-recovery",
+	.init = ath11k_test_init,
+	.exit = ath11k_test_exit,
+	.test_cases = ath11k_recovery_test_cases,
+};
+
+kunit_test_suite(ath11k_recovery_test_suite);

-- 
2.47.3

