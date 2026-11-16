Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854147;
	b=UGxExN6pZN2gP0gYvjUIgKefopC8J2JtvPwsnUOFVcEU32dda7h7WlRiHLTAjcKPq3NH
	 UkqUjXOrMKBHyb3KH9PsCXvtphRdgiIN7voPMNAYr624t3DFkhv8N/CwP837xAItpcYdR
	 EDXCD9rMHOTs6qPI/IcIOEknpUeoOR6P1wjbo3yw3w+d0xkdLDgdkrPb/ief47Hcnm2+A
	 wwLAyFtApDCGuVeKVOaqzQRRScqEpF/K6EC+Rhw3eyWzNXHWPq5+HdYLqULX+DcCplWmW
	 9zaXbyXmKcwOAdnpH8gT/04+zlLa91BCcSeqdXwp1UgDfwqruqfuYiJNy3rygAO0VPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854147;
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
	bh=SIdNXmQkahDS46TmcuBLLkqDDnzAzEKHSDDfsFnpSRU=;
	b=vEwY79AjjObtaV6HbmiEzOvzQyZv3W+0G7BfkEgPqeQZQjsg5xk3mkJfXH8ZsCG/cqCx
	 S1Dug6tK/IXP7TiArwOGFvRCWFM3UwMeoM8ySL4JQH5vo62WvTLlNLtj/uiHKfg+Opkm2
	 sH4F+zNlTVBfqll1uVf9p8cmYDRp2xS/9RvJNeidReEHn/W6PjgPqSpCJy6nnnwdwGu4k
	 fkTbtie1bWDSsughWZdN1zWj0uprTBxkbKwE/Mb/5OC8fg0oIEslYXVs96DfDBoOrA0f6
	 zrDiJExfmxc2enAybVxHRx1VM8iPX1R37JrQiQwkk1DtXjq57xfnbjyCG97gf8WdvsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=HiNgSvhC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.116
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020116.outbound.protection.outlook.com [52.101.189.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708EB606A323;
	Mon, 16 Nov 2026 18:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708EB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=HiNgSvhC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWBcrhhWPqDRtnnAhZR4S6oBGEIVljV/PMtHiJdNr+PrLzAKOn/VWAyeDQTKAfnj5kXYIeOVZB25AuF2pvjNx4KXs3iByhe8VjGthbt1fMeSNshyyvl1MeJpMP7EQJMFqR3wSIIHEH6+5vCmZ+D8KkZuxlbKUBWlQrkN+cXjn6iG2uftpEbHOVZwBV/+Wh2TaLKnbKJVladAmnX0Jri6BcetveGd0xqxHY0F8W1+NN/zJTRLr4wEvajRfmsHyULgk+P7DXmd4OnT5kPxoYIhJerT6dBLQ5obaMKYRpCqfzipLLBRqgV4h3gSRLpb8bufZ6Er5GuiF+D7zINsPbsPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIdNXmQkahDS46TmcuBLLkqDDnzAzEKHSDDfsFnpSRU=;
 b=wG/V7knmjGCerxJ1f474yz+/BHC32WGMZdy+oJLSZKk6q/it7yCDzbNBEfBDFTpEDAFzDfj3Z9+g17DdeNHQeyLpiS2p3G1sWVw+036A9DrxHPVYoU4ruM3SPqbJV2iMGeKh70Xe6Q69e6K6yDiy5g04h6Dmr+npI9WqZCpje+BweCjCML3+pSBHXE7HaP3MvBHinlkuPwRl3r1mG/Ei/VmiyQRywXPSE7T/EXZATHnsoQHc2hUsZGHvN5DmRTXZZ9Qmq2RAXdRBx64fVReS3qi4QwQCpdjq4d9WTvNa13W9mAc9ryaVqydl/smaX/dYgqyU9o/UCLRU4VNMGQUEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIdNXmQkahDS46TmcuBLLkqDDnzAzEKHSDDfsFnpSRU=;
 b=HiNgSvhCnlzAdpUGObEDsmOlnDmDUENMFXlJ/7gKa8A5gAfo/qhlfom/6krEZ6NTxWlY4ayr9XCg8AFq1E7gmfLeSxU1Cj34GP/OWu8eC2/pYKoQPhRFwL7rHI65rpGMUqPR7K3+PXYENCnOtN1u1iMhp2XDkX+2LXjbcOm0KcBWmU+kGQFfsqdUEgM2Ite8e2AC0uA1yi7EDUU7D+SgKqKY1jphZHGhWpIHMnC2ShFazPnYssVMZH9w+MIQgDxzDctFGry1VB7kaPL6RQqthHgM73ksa+oL8uwYBo4Qukf7id2spfEtPGR13tOLuFIsa1Z/+iV2IfMVTh8sSnaDnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YTZPR01MB11800.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:35:43 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 18:35:43 +0000
Message-ID: <b7a29cec-9a66-4a50-b740-943d88c49b63@efficios.com>
Date: Mon, 16 Nov 2026 13:35:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] locking/rtmutex: Clone the sort keys in
 rt_mutex_enqueue_pi()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-4-mathieu.desnoyers@efficios.com>
 <20261116151152.vDbnofKe@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261116151152.vDbnofKe@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: b257434b-e85b-46be-7394-08df44106bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	IuKycmrRtu4CWu/sV2SpdX860U23fhbAuj5K7e1ynYk2Sf9De6cWkkLFLaIWKa/Utc2UEfhuuYI8pZx7Rn2CzAerBal1ZidjZd9oXfuUpuMq5JmmIp2xsjMvHkgI07X0Id5tG6VTI+B+Hj1GE9m6E5m/+3yB7ZqQlI+pR/3tya4etphA+6pqYtG03iBJuGkR5aGbKFlnjKNxEWxKc4l7s/6WgxqN17WkwWiu80+OvcybzPFdvaCX4uV5H1s4aILPuHrt/SKsAMf8DN2drWvganmuqY6Niw8tystm4iOmaqB0FuhZuv4xckqCqoBsqwwSKr/7L5eg+kgbulHL+tmvlcSPADKJyzzWwnaUS6EYmO4Hjvte2hvrWYFHSKqAGnWM5U/BYo14Z0eYJkNL1R0OpZFvTqeyi/sno9eOiJS9hh/tvt/lmlbkBM+gE1jopaByfm9PabFGfWPxMWZObFHoN8ZKQussVOnmIZ2216zhvo745wLBHN6zTpE81U9OL+uk/nk5OGfXKH0jpNZbbjUIVyEwVmTW4borVjSCbhbUXW9VK+TYwfM0s85ZpfUZ93L3PGetCxXQ9pR+JyMFrEtMyNmTOD0rJ1QfXK0i/vZ5sTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFhEYVI4VWZRVUJyaWg0WE9zWUZhSDIrUGZERTFSa3doeGI0cE9uY1hGTmg4?=
 =?utf-8?B?Tzh3ZkpBWTJmRkxTM0tKalY1RUUrMWJIRUNNWDRZZEhtZU5xaiszMlNleEVu?=
 =?utf-8?B?cWRlUEFycmoybS91U2lxYW1EMGxjcGQ3OGZuZjJ6QUs4Q1hBb0FuQUFVN3B3?=
 =?utf-8?B?NFFsRjJMZE5VbzZQbWNGRVpPUE5kWmE1V3B3MnkxOVZaRHp2c0JMaUM1VmJs?=
 =?utf-8?B?WklGLzNoZkZrTW01dXFMbUt4UTIzaW1wK2hHTXdzWW1GdjFmOHMyNXhQRXh3?=
 =?utf-8?B?MllCZ2tmNEZpanczbFZMUnNYVTJEcENXdkNKTnc3Um5IZkVXSGR5L2lEbXZx?=
 =?utf-8?B?dmxMS3Z6bDVjVnQ2bTdKcWtwbUdTd28wTVZYaEpnSVpjaFBSck8vY0tBQjZQ?=
 =?utf-8?B?dGZzOUQ0WkgzUlJNZk9IM1NJa2RJYU9hQ0ZrRk1aTEdUUWpiSnlqempBeG9l?=
 =?utf-8?B?LzZlNmFudzB6WUtDUUF6R1YzeXAwbm5TbXNpSFh6VVNJMkExRWgvYkZEMmRP?=
 =?utf-8?B?MEpRNzlCL2w4d3pmb0ZORTNSVXcybDhyODdreVdKdERyR1F4V3NzRUpPSWZn?=
 =?utf-8?B?TmZTVUsyeHFtZm9HZkpYeTNEcHcrOVAwU2xrY2crbnB5eXJ1QWZiaHVXR3RV?=
 =?utf-8?B?Mm9jcll6VGltcjlDeExuS0gvbEpjWkROV0swU2lHanhLUDJxUHNCdHgvVHgy?=
 =?utf-8?B?eUJRZjEyUVR2ZXUvUGwzd0kxV213MWZLa2FvK1k4MXZjQlpwaE9SSWF2eExG?=
 =?utf-8?B?Z0p5ZERQUnBJNVZLTHJrVHp4VUsrZzJhc3RxWkpKS080WXhBOXJwbjdBWXRB?=
 =?utf-8?B?SnNUbVVMNXhVUmxBcTBPR0ljd04wdjRuNzA5YzhPdXhGZVI4VTd1enhCcnYr?=
 =?utf-8?B?TVp3ZGk5VlVLUE9oSTNaS0VKR0wyWFVEK3Naei8rZ2hhSzMvNlJJRUVpSmlj?=
 =?utf-8?B?elVJUU9nekNwMVVINVlVaU1FajNINS9DVHVQc3hXN1hUTmJ0ZGY0SjRIZFkw?=
 =?utf-8?B?Ujc0OWRDV3EyTnFpZFVLbEpDZGhGNUJwTElXRG1kVU9IMGtKLzh3cCtQT2Ru?=
 =?utf-8?B?M0d3SFUxbHB2UW1LNGtqczgvcU8vNFh0Z3F2dUx2d0pnZWYwZHhJWTVDZXBl?=
 =?utf-8?B?bkJScGVvdzFBekQ1MG9oZitlQk05T0EzditxeWpDYmY0b0JDcEFBUDRtaVJo?=
 =?utf-8?B?ZWR1NjlvR3ZNRHo4NGxOcmsvRTFEODFSNW5IeDdJUVpXWWlIUk9HOFUybzY4?=
 =?utf-8?B?YmY1aGhBRWtQV2JyYVFtSkZFUDJ6a2lSRnNzcEZoWjJZdFNCck4xODk3SXE4?=
 =?utf-8?B?RXY5MFRwa0ZwWit3emRaaVUwblBaK1pUSVd5SHUyWTJaSUpWY2x1N05QOFho?=
 =?utf-8?B?TFBvcDA0c2l4cnYxSkcxcmJGeFp1Q0tPeWZCWC84Ukx5VklLSkZpVjFMc1pQ?=
 =?utf-8?B?NE5IU2xpdVVmWHYrbkRrM0FJWjh2bUNEa0hRK0dpZ09OM3ljLzQ1Rklrdm9D?=
 =?utf-8?B?ajVRQ2o4K0hySmZnMEFpc2Vva2VHMG9Nc3dwVVRvVFdFd3ZIT2JBTzBmamRS?=
 =?utf-8?B?Z3JoVm9tNjhPY01XRTZxcUswUUlzbytpVUl0ZVZVTEtUMjhjbmI5ZDVpODF4?=
 =?utf-8?B?a3JZQ3hJbUVFbkQwS1RXYVdUWG10TWkwN1NVSmpBTytCYVFnbklRYnJrL2ls?=
 =?utf-8?B?VzJsU01wRTFOVElDbjV6K3pHWTdwVE1lalNZak5nd200T09nUFdoVCtQWVNo?=
 =?utf-8?B?R2g2SlFTTFkxU0lPaFFhRlkzZ0p5OHJYclZEUG5FOEJLaWFJMnRuaXQyNHJF?=
 =?utf-8?B?eGNsVHFGS1Rzb1QyQnVPZk5nZitjOFpIZXlOd0xFWjVaT3hxNVovZk53Rjdp?=
 =?utf-8?B?WlV0Rlo3K0ZzWnVOVHpMdzZ3YUZPTGtlY21pSjdHd1Zyd2dtRlhDdGJkbWdM?=
 =?utf-8?B?MG0xV2tYQW1ES0hpcG5RRnU1cit0NVpYbGJmQkJsVFQ1c2x6UllGYUVqM1c5?=
 =?utf-8?B?REZyY2hCWjJWd281a3FxUjlZSTlZZ2ZqTkpzSDhkUkRmRmEyTHViYm1LS1k3?=
 =?utf-8?B?V3FVU3dhcUVFTnc4ZGxvRHVzZHVWb2NCaUNuUDU0MXcyTFFmdU12SXIrRmdz?=
 =?utf-8?B?ZzBTeUtPMVRJK0hUS0VwUFF3V3hYbEhLTERBU0gzWmdVVUJOYmVFeGRzUlBh?=
 =?utf-8?B?U3U0MG0wNlpNa3dKNkh4bjdBWHB3L3BLWS8wTUVqYnd5TkZ2bE9wMU96cnp2?=
 =?utf-8?B?KzZMcmt4eFlkSUxGYXF6RFFFVUJDTnRMeUZmSzdrNDFhZXd2bzBwZTIyWjFG?=
 =?utf-8?B?VU9JY3VqRzBMdXpJL3pSaVRISmpmMVJEckxIOGhuZDNSRlBUdzIrK3phYis3?=
 =?utf-8?Q?4dALvYr4/1mpM+v8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b257434b-e85b-46be-7394-08df44106bca
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:35:42.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEdVOnvKhQH+9BRxC93RPrLQoiEIqTIv4N/WyYVcYscY48fKZDjGjuYvahkU0RfD0Wj5k1u9bwUc3gFW81efno+ahSrgjq+367aac+MwDsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTZPR01MB11800

Hi Sebastian,

 > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks. I will add your tag in the next version.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
