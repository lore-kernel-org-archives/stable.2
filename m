Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793895052;
	b=GoS026/N36kgCngFCOpUKlHvpZVVFYlcGlavIQkzuwOfMaZKYhi2oOBJD0qe95ywLTrq
	 qXuazEpsNpETM9jGALKjKkp3Ox4GxMjd5Tc3Rt/Db1Ek0Q7zK3uFIqQD83vz35SlU6EVK
	 R3XB/yCNOAcyK/BHeTTbvvHoo3xpCVUTHKYaBtGgSM7jMC/6S9wnegVxZ9u47WohQPQw1
	 gPVz1PbblnyAjXo2ZL90FuN0Rvez6+ABTMtztonI9C7HO7oBYE5b27ORBs2d7X3CPRPP6
	 a3SdA3IHQ83hSFEPaqN0cyfYkYLqUAG+pEjouiQ5TpJeHwz8Lb8RPZKLQVWICis/Khg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895052;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=s9WCm9t0e/JQnnw8DKPRHqRxNcbpq5LB4Q7+plZFBEY=;
	b=FwinZMWtnOBkW7mBWhLz5sqJnxjf58OXvhbE+8yiN3l2/SGe68xWK1NQVehDgcD7MNok
	 tXztGC1n89DC3PYMeohBEmjxi1P/DAlzcMtfyQfC0HGl1WUzCZcawd0fVMz8oFhIx78Pk
	 ovMmqkgnEdJeRHTVqzRsk4Nd0tL2UaJRVwypjJGF1XtELsyz5uMe9hnzYFNfw4uVfeNhV
	 kVlHomC8LvckCDUjlMYAT1zkaGy2PCdg7X03OEVvO7Dfo5QGxYtzrir5xAeLW7S/iPV1o
	 VWvBNAm4qtUTPaYIqVjImNmWINCaVZc2fr/D3Rg/XlOeIUJMHGoSIKkr7nj7lrzNPZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mDKeqO69;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.67
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC546606A326;
	Thu,  5 Nov 2026 16:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC546606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mDKeqO69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKrLfYeOYWZ9fnAAxVn6fFXLMn7uMFxKPEJ9XSf1EaEGLNefmrhOFG0w76OfXWtgrBOF1ihHY71ursp5Wb5/Dk6XDB2VtaDeDBU0VhpE1rEPkdqU+Sb96gc6LKL4FUPphiO0ODgrKYXqhtnqesCRLQY4Vk/ZY6el7vZ2xyNX5MLkK0YmRTEL2iWPDamNpWElTaI/oNW1PY9X/Cwe8V3jXBj43Z5pjilrUba5eODGcHmxICKmdRs/AfytthmUljZ2zeZvK8MlUyVREQoz/ka5xzpo0+tTXgdRSHuP6iPTUW628zUVQT072EilqQicXo+d2zyy0YRfSasL6aW7XOFImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9WCm9t0e/JQnnw8DKPRHqRxNcbpq5LB4Q7+plZFBEY=;
 b=LfGB8Eneto9FRyKAqY2Gzp6exfX3tC7I0vwEqGKKErtPkQz2Pkd9RIv7unYu3RPXGt6XltR0ZESvDo02wmMuITB597WocnmiYmkCUmH8fmuEYnDpLK7KCq5Cr8Scr4mPGRTHaTbeeOsgHeYfQq5GCS7z7In2GnPU2YjvPXYSgX42FtoxPAkFgWUR5+DjyX9q85O4Qxe3CMZ3gVbOxD630EliF5xpjovseee7LUbX9u2rPT/kajOaALtIddmBRbvLB8AuEKZ5gOfqex1k7ktsFOFF54NssVXDts7Op/7kry0Ov7QVNMwdvxve6hJIZCO4Us3VGaYBE7JqUA6AJt2FxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9WCm9t0e/JQnnw8DKPRHqRxNcbpq5LB4Q7+plZFBEY=;
 b=mDKeqO693u3NCdGCfF1gclq5uGnTBB1VZ6flbgZLqR+eIYKAT6mHGtvMAv+tioqvuMEngayb51OgJ4vjmyBAR0K7QxxiGIuFUNWKEijCH3a1lQhV/Rt86eNCyTTp3D7IoQCZ3FjHA+BsVbHCFKORMsoZQYfL2V1GTtXwQfod+Es5hesBXCiclWU3TpQjA9KqftqROQIl/UHK1/COBGZuKkQpWWmAhrw1jiyty+vlOjZHZbD0rRqKeqcSuz0yMf47UQLHb4k+2pitcbpIeAr9ohlqS8BsG0oB2ScjZITZmgOA9/OOGY8vgqmz6EOkfyf+91xHVRlrGsTjEqlMQY6zlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:10:25 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 16:10:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, rientjes@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, muchun.song@linux.dev,
 osalvador@suse.de, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 Bessel.Wang@huawei.com, jiang.liu@huawei.com, mgorman@techsingularity.net,
 anshuman.khandual@arm.com, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 02/12] mm/page_alloc: keep the pagesets of an empty
 zone
Date: Thu, 05 Nov 2026 11:10:21 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <264A6055-CCB9-44CA-B638-D38A3993FF50@nvidia.com>
In-Reply-To: <6c5f3ef1-188f-4a5d-8775-578dc2c84c59@kernel.org>
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-3-gourry@gourry.net>
 <DMK59DO8M3AP.3OTG2YR62D9WO@nvidia.com>
 <489b668a-033c-4161-93e8-15d6b9b28b51@kernel.org>
 <DMLPC0D7EWRW.EVYWUONVO18A@nvidia.com>
 <6c5f3ef1-188f-4a5d-8775-578dc2c84c59@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: MN0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:208:530::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b69d8b0-5998-40ee-1369-08df3b574bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006|4143699003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261102123227099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	iSXN64PPiS+GJIdw7JS5nKfZIu/02WL9g+sZPH7SMqtZmnm/d4YgrlopJTg7LTC02diraEavGBDatGACuLM9SzBU8MQJBwIRSUW/AikPBprpZdbcMa/QP7vvQTEPgRB3dV6tt9DJHMcp4XiqRSN1UjM8PUiAiYJ4YUZeY9/TzgfaB1hoN1SU9JG2fV4Zb8pB4TJRV2XQjTBnf2IL2xmKs5gFslz+cntOK5fQgJcT1gFB+rc2U5HD5xOwRnSgZSTHCEusN0H/HFmz2+EoKH0E8r3AQqNz2EG2zNEUMPSlRjInRNaAteFmpGqYnPFlZAjCrydVLhAlkkN34aR5k3aChD5dPGvTspdSGgHbA4lz4wwJS3ftAFjCsesyUv3sHbVWDI12IQDypuKA3Heo6ngDJE+Dtqq44RUfbaUC+DKNqrUQ/4REXbcC6WjHvsjOML1d6pQ4zC3OenSGdv75CNducGvSLrYlvVX2bRqbmdW+I+uu2Onosz7w43dTrqIAvf5FWz0oR1B1yZUW+5tMhsrhsBfB8Xnxg628Ba3G8qEV+AEQzxgLGQ5D/xhS4W5vsrCcY0zzNwFcKvxatqAuO7cJULO02hc/ZMjMvJETFGILLq5fNZ0Lwk0ZBXwI0ewPu+CPEs7GVpzmylk7dQ01Zr32pGzN/Hx5Ye+7GdIyHQzy3EM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261102123227099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8myJywt+gKTaJjUrAI3l9fZFUZOAXataWFMGDjGzcbkXtU2XwnZRevTw1Ml?=
 =?us-ascii?Q?G17KKSHHW1bhPyDFKe9xb/7SyXgzVqlcaAn5BryDShDXgJLh5CG7XqLEmTMQ?=
 =?us-ascii?Q?rd+t8GOBbaknp3ejA6S67nur/YbBmBGuVY2fMbE7EUPmTpKnigS+CMJ/WiUB?=
 =?us-ascii?Q?2ilLyUcSNeox/+xbcYeh/4da7t6nnhQb/7dBpH3Aeq+AFmtf2PxI4J2EW4wM?=
 =?us-ascii?Q?W1XZQ5j/HYMHaqHl/XfdBvNPhcia4h+uRiIfthD1cU+IhC1HvSXC+AAFQk5h?=
 =?us-ascii?Q?KduEJjKOyzgZFocIS/TORN3rR8Id+xOXtnHy4ORGHuaSqp43xOloHkrdu76P?=
 =?us-ascii?Q?L2f7U6hlK7enxhMy/gVTPIZYnn3mWsQfqUoRKd6uHj0OPFaKfRiNri92iiKu?=
 =?us-ascii?Q?5pWWFBC2ZzcXhBrxxnQar6j88H65MgFgZSTCjn9epK6HcBvOz+6V7Fa32P0Q?=
 =?us-ascii?Q?mMEJWxaxiEddTUlCu7TQT+5nSHlBt7/+/gWM1pxtEJGumJM4+gAqBQGcgHJ+?=
 =?us-ascii?Q?kG5/iPAbkr3lVYbXTPdRnK00X91T1iDa9eJm0xszG4SZ6g0rzv93F4G/I+lf?=
 =?us-ascii?Q?tBldoCvuf+AADmQsFXc7GrWtm8D8ZWurN4+Lc66V1QNuZEtqZgB0pqINm/lu?=
 =?us-ascii?Q?DOqvbdJYHjeJ3Y/RrxE9CoqjSsgOGvjJEj+hsOS2LgjMIlIXM80aoeBHywYt?=
 =?us-ascii?Q?Kq/IbTGU42NEzolbxIz6BQe11LpNXPWqU0cEQR+/5wHVSppJbo2WI4c5irqg?=
 =?us-ascii?Q?qJ/UKuRwUF8LfPTaWQHe9Jet4ZJiOm4ioGhFlHj3tJkRYRGLYqwTYlxL0Fzu?=
 =?us-ascii?Q?Ngf6RY9/th0EaELwET3uEftiieeRsG3P2xuXGkfjdd1iEoEo6GdsWhFudHng?=
 =?us-ascii?Q?Eh4VZaS1/6K3QWiprvsllK6wWG1exQ3lh4+o1ii+amaR5txVkW0pCCkk1V1B?=
 =?us-ascii?Q?a+iE3qaESlqpw/RQC3xwRpw5Scd8LpsgoqMSQi97/9t7AzjrYSuT7aqQpWGM?=
 =?us-ascii?Q?eq/SnXtlQKgGagdll40Mya6Ks4v1dqJhod1PUqlptCfsDDQGcJHIUn5WMldz?=
 =?us-ascii?Q?VtPFNRQ2wt1a7X5BOTAqpb7e6Nd+H9ZVpEsm/XCr8LRfKQtqcIccQtAE6wUj?=
 =?us-ascii?Q?scflHIGPf+i/TV6Gyctqfp8jAZ0u59A96o/99q7HaOffeDqcw4GWxRSpt73B?=
 =?us-ascii?Q?/jHa+D57y2z35KxyS5NLg9658maVHXw7Nl4GRXxT5G4ovaYckrIJHn8yDBxR?=
 =?us-ascii?Q?Dvle8mmuy2zTBt/Yzu0eR+D5NnKlzlamdOzISP5/MEG2oWzMgU3FiFP/Suaa?=
 =?us-ascii?Q?gwrY67aCDWqiRjWxZunpjzaHwuGxohZR92Pw7UhWDWn8j8WDVtQ4hFKEDzv2?=
 =?us-ascii?Q?j65u+nT1Lb7xLKEvrtVu9jxSJa9AD6+nKaMjXyeKzOgjl4wm3fR0L0nGAC7v?=
 =?us-ascii?Q?CpgRxoo6OQk0BpGra0F50t4s4N9JFWvruLLDIgpuuw5J39bWpfIZhQR9ZmsM?=
 =?us-ascii?Q?zRbY0xEVV7vwFHtTG3pW55XrchtFfNJG+Iexw7K82kW/I7fEj7URcudXleQv?=
 =?us-ascii?Q?TdO8iBUSllWQHN8+FgEi+/DOUqPoPhA5Dr084mXqxfrSW5Ngg12pn+2Q78jL?=
 =?us-ascii?Q?FIqhSTEnfu3cxbfGlkyV+UpSOowcuHNTm16G0/x5KdAALv6K/MzHrQHtlGZa?=
 =?us-ascii?Q?NB0o+QnKUTiaTIe2p5MiUsLaxHzpdLVO7vXorAmxJZVfHNEX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b69d8b0-5998-40ee-1369-08df3b574bfd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:10:23.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv90dRN8qL/ZkeU2fkLU1Elq6QP1RVLvYfeQ7lkpICeJ1XKXPeMhk+GJpvo5/e0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

On 5 Nov 2026, at 4:58, Vlastimil Babka (SUSE) wrote:

> On 11/3/26 17:04, Zi Yan wrote:
>> On Tue Nov 3, 2026 at 9:57 AM EST, Vlastimil Babka (SUSE) wrote:
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index f1048168c90c..1850a41f24f7 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
>>>>>  {
>>>>>  	int cpu;
>>>>>
>>>>> +	/* The zone has been populated before, see zone_pcp_reset(). */
>>>>> +	if (zone->per_cpu_pageset != &boot_pageset)
>>>>> +		return;
>>>>> +
>>>>>  	/* Size may be 0 on !SMP && !NUMA */
>>>>>  	if (sizeof(struct per_cpu_zonestat) > 0)
>>>>>  		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
>>>>> @@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
>>>>>
>>>>>  __meminit void zone_pcp_init(struct zone *zone)
>>>>>  {
>>>>> +	/* A node which is added again, see zone_pcp_reset(). */
>>>>
>>>> it might be better to explain zone->per_cpu_pageset can only be NULL at
>>>> boot time and it needs an initialization.
>>>
>>> Hmm.
>>>
>>>>> +	if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
>>>>> +		return;
>>>
>>> Shouldn't then the check be just:
>>>
>>> if (zone->per_cpu_pageset)
>>> 	return;
>>>
>>> Because if it's == &boot_pageset, we are just setting the same values that
>>> area already there?
>>>
>>
>> Right. And zone_pcp_init(), called by zone_init_internals(), becomes a nop for
>> free_area_init_core_hotplug(). Then I wonder if zone_init_internals() is
>> needed for hotplug, but that belongs to a later cleanup.
>
> Yep, that's for later cleanup. Right now the minimum that's correct and not
> unnecessarily misleading is enough. So I've done this:
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1850a41f24f7..20bfd11c5851 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6404,8 +6404,8 @@ void __init setup_per_cpu_pageset(void)
>
>  __meminit void zone_pcp_init(struct zone *zone)
>  {
> -       /* A node which is added again, see zone_pcp_reset(). */
> -       if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
> +       /* This initialization only needs to be done once */
> +       if (zone->per_cpu_pageset)
>                 return;
>
>         /*
LGTM. Thanks.

Best Regards,
Yan, Zi
