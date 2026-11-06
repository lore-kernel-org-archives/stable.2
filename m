Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984158;
	b=5knB3Fscmy5s3+eIn7T/IqzGAQCSwcI17p3hqXJ11DzSuyxv+c4rGdEBMpuaXIhspcr5
	 4pp52evkVgla9eC5z9gww47MjQIztfiC47YZgcAdCWQci203ulA70KP7ozWUQ2bUPskf4
	 XQyqA41wu17deRwOCcAE9BPDLjIrCmR9dVT3NOl7N+nUnUDstOPsutZj26nYEEU80mMXN
	 gjprg2lC0yW348ixjGSvWBSybLu+WcH+y1jR2ml91ejAYV0kukpAXYqfGfiFXJvWYbT4v
	 btuAe+lYWu+nBg9xLkLTz1KrmB2leNYJGDvgQ8Y0+LKFS+X3s/mY7ZlKIGhljjcEQ7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984158;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions:X-ClientProxiedBy:
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
	bh=LzmbmloKDLdVR6B5ca4Kq1485dDpPN+FqZLjrLCFQgg=;
	b=5WG6RYhC1Ga2jeGnQq6w4Fixszaqy02gYP91LZOKiicoiZdg1gUEozrWbz9jNsDt6YsB
	 TZzznO4qKa85HYWhBTWPPeLerCB43Z1ktgVhMvyZ6IfS4JZZ25xHY/PuErW/RI1bqncjB
	 zXVRB7rAqW+ZBTUMpfYFRrX5cY0n6oW6aRKbScdLQC/7cecRKHSgBeVxW173hOleYAL3u
	 PuGg9qJfhj2cMTQ37dTbvWyF9AWaIFyE74yCc1sry5isC4oORehb7OuKi292bCO7j/1SM
	 E63a3e/8prBjlpl7BtXxojoJWxz38GmR9fHHlhJ47A+rBLYr6ni8p3EHvAGctY5wW4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E8V+djJz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.0
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC0606A326;
	Fri,  6 Nov 2026 16:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAC0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E8V+djJz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J13eRo30fExQnc4FN90rBdRFzS1rdtCcjyLjQuWm7BTbsl1qsEey4hgiwz513SrlNwsmGwQA77so1kW4O2gFz2stXk0dPG7fmA+sM5VqU1cuJxDYaZQQuRFojJlTrCnRxqPuTd3EWDsQ1Mbf6VpPEh544Vfd7S2AqB+vTnxMWpnhH3T6NheB/FXrS2IuN21401HaQKw0Ez70A/9WyS3xvXdabdpI+okrzUyn7iuoA6p8pofk3X3KaqsI0DdqDdbezv+U7VGvNlWvdAWpRb0/Jq7jQzXpM7Vx7LCGapISjspqc5PrRdpVLUFWG9O5qUcmVyPSvPJ+KmhUZod0iOtuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzmbmloKDLdVR6B5ca4Kq1485dDpPN+FqZLjrLCFQgg=;
 b=w++bVXWGw4+IymYVT2dMSholXj+wK4YOjehOpTWf949P67WKTmSsnZ7h2Su4L3LsFXQHgqufuFiPbRDus7JDsqEK0uF00MN/zfDXsmFaeV6xexIcEw8y9zjqbbd6Q+CH2HrZRUqW2UMNcL9ZlSVp4QQyiLYgV3ITka2X4EOhr7uxcLzBmsMimtLcHLtQJ0RgtSUshswGhGYITM5ndNgdNqYAHXFywgz36yZldpHOiBCbyVZRs1N8OtmrPhzmOmPITxHU8eWl/JN4OUa1Yt+wDehrTQ3wzz2pTzzI71wu+ziODWEu5HrmyhkG4R+/JGMshJ87vZVq6rnmTFXzlwUbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzmbmloKDLdVR6B5ca4Kq1485dDpPN+FqZLjrLCFQgg=;
 b=E8V+djJz1mUmNUjFPd9IUJirb/RCkf6k+ecRoF8EStoiVAtwbf427TL0CvShGDHHTi7igx5oikCcZVMc0JV3sLBLfbnk8/716gwPz7WvcjsJF8Fa+kI1C8ZD+LYwQYk85VthkuiNmAmu49/FaTNSqw5yFMQGFatEH+r/OYLbPdHT/IBmnQSn92blpH0Qa1qa7zD7lBnWx9qbo+y7Ra0p1NbAtsQLXamg/hE1F1jRRPHe3Cc7MH8wVDhZcIWpBcuwWyNxd4ssGvqrXpChrHupsTO5ueFGTZ77uOVegRRYq0OBRU7AVmEpctThqo1gpvyyReNTuhxcYZiB333c+FG+DQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 16:55:44 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 16:55:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Date: Fri, 06 Nov 2026 11:55:35 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <98E68B8C-49C5-4DBC-B687-38698F259C87@nvidia.com>
In-Reply-To: <au4A9Jx9_1PjpRCb@gremlin>
References:
 <20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com>
 <au4A9Jx9_1PjpRCb@gremlin>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:408:fe::27) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af5d556-31f2-4992-14c3-08df3c26c894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|260925022911599003|261026121527099003|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261022075727099003|261026140227099003|261028144727099003|4143699003|11063799006|10067099003|260925021911599003|22082099003|260925021311599003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	P0IMAgoz64RiQD/8TX3yYI8RfuZ1mhYw3MSh7IVNGUexZ/JigdlvrKWBiSdzNhYzIzvw/uBpEKbUmslgv3QcGMJrC9f3KtgvITSLX93DjHVOVspt4E1narY+mCg++TafEV+4lu4q/gHzJX8cvxwGNyG3Z5eNFSwtZ9fbbrs12Z1ToZLScndf92W+0TMFfUrN6Ovr6cx3TUvDlKpi9WzyZ9CfDAP2qWLLf5ze/bJn/CWNM2G3Y5hNhO/Y6bKsTWjC5Zub8G5jDFTsWu3SaV35IkIQFr+ikkpCTQwqHKntdWvHzj0KWDxlirfHvFuqpCb+U430NRUYBTXWJDnUgrdctCoaGlg9mQmrfqcePT8yaP8Io/yCCHcXKzmStgyn3fs6CVObweVg5RSP45gaVPvzm3npBCJosjD8syYkcrDXwCscrPVO9KuMUO9vfid11176sFfz7SBe/bSCcuJQYEIvpk3AVn9DqrBdDZzEoCry0bOypXOmu/9HLQggwaCbnr7BOhaoWPOe1hjJnPBRnf+tQMpJgR+McVCPmnzGx2crSmfgabyU0yZ1bdOM1GmWNDMKwrk6VjLmKgTIi61xbYaNmx8rL+5ilSuoDCW9oKLbe6Z0QyGySY2b2KV2pspyyWY+MsMQMOti9g54B7YYhVRsvKbgoQ47WwBFA6vB/+ickGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(260925022911599003)(261026121527099003)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261022075727099003)(261026140227099003)(261028144727099003)(4143699003)(11063799006)(10067099003)(260925021911599003)(22082099003)(260925021311599003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vDL3RCdja3M3kVgQC5kT7Vhh+8DCt8KkrdfkpBErUZkYhhn7QHqEvxoOBUxd?=
 =?us-ascii?Q?rwmCFTtppmGK+ZndO8CNqgjEOajABeH2HjKM8CRtw99jozYl4gDNFD5WrW44?=
 =?us-ascii?Q?kkU9d8Dc8x19gRvfOVVCsC4XutrF8No9AmnYhsVeojgr1JPRgoE4BUd0JRAx?=
 =?us-ascii?Q?Ekp3t21UMx2UBA9R2ht3LR62iQmgtl/mehnqXGS+tUcEtyoOUEgQcliN+N46?=
 =?us-ascii?Q?u/viqF3dY9qZZm8hm2JJyMVHWl+H1QsLnI6GUHW9xTcq6HHU0iIrKG8meGKl?=
 =?us-ascii?Q?ViCwUc9aRO3EbvdIv9xds0NWhLYCEHwKLoZOnOT65Uhzq7o01tu5d8/TespS?=
 =?us-ascii?Q?xOgqkuTxBeaogzfdSNW3k/ele23aKuGm7SFdsed+MU3CUKQOiL5RsmGQhZQg?=
 =?us-ascii?Q?xrcrTmvXsB8CTVN+vLoUdyz31jmhu0lE8qb3TdPadlTGZeqfFxTM9vrxRHAM?=
 =?us-ascii?Q?1Ur91uKqwqajZCG1wioQWM0GxUpmafqEaaPD+PHQz0hFW2VnfzS0DX6GIfts?=
 =?us-ascii?Q?0+za54ysFTjGGmTt5pxNcHPbaxt0DDlOqRD4ZIfH6Hihf/BqXKAyDSD5sF8X?=
 =?us-ascii?Q?FIZwCJLoiZbYEe73afysQ4U3h59d/52B3LIXFg6e7PrV5gSbN1UJoEAM75Uc?=
 =?us-ascii?Q?+m591CpENJpd2WaHtTELwJJ83IaukfmMs52ZQw1UFSk0aijbtpaSOwcP1n6x?=
 =?us-ascii?Q?aJmIaVRHJM/GIwxZlr/FTQhbzvETZ2IG6Z0x2RxHUclUdPuA6p0jyRF+j0BY?=
 =?us-ascii?Q?L5ofPQ4UueLi1d3oJcjIu/g2w/XE3siqGkhDaYa2qLSZ/YCmpBW0WPQecCf5?=
 =?us-ascii?Q?aXfBwXFMRwVTrGiP3x2ueqcpsT2/Ogmlm7PWndA4mbxs72BzI3m3Qg4kRyuc?=
 =?us-ascii?Q?Okv5JbA4m4s73ig6vMnPRSF4rpdbUrUeOSNht/wvimLNQpCMjQxpT3TCaNTa?=
 =?us-ascii?Q?uUmTlJzZtXW5rqKeNGVRmYdBAY5Fhy/1kTCSMfL2yA+Wl9hxZhY+H+BeDtLN?=
 =?us-ascii?Q?+sxgryHQcp62upDHOrd/21sQrWa8Z2fN2MS7MLGCMS1MDNJHmBnG/C9/CkhA?=
 =?us-ascii?Q?2XQ0uFyg7E3WIDtU4QiXlajQJsVpHeAqVEMfdjXhbm/Yi1tgyjJ2cyr0ettu?=
 =?us-ascii?Q?OcncxYCEnvcBE8LeIMDseziveqfrl6OHw+4bAprn2tHQZsQvXFrbfucl4VR5?=
 =?us-ascii?Q?sROKgBzAMRl8DorPvqOro4wXL7pWdKHVqKxB6JrhHg/atetalMEHuIoP2mhR?=
 =?us-ascii?Q?lQuDV88HFIYL3Wp2tu8eO4wxalIaLFyh2tmARiA3gsEDf1Hp6Uns5Fkqi4ew?=
 =?us-ascii?Q?J7L+kAtgJF/plnK80imR7CEeHmqSP8ykhJMrQYK7U6dURRTu+CRMqY4Nj/jR?=
 =?us-ascii?Q?rzSzt43J12Bz3QrnEZWF2uxeNRimHzF8iQTgxtCyhb/4THTvU/nKpH2mrXyg?=
 =?us-ascii?Q?0+xM/2ZajbYR/0h0ZgJcbR3vemOGYM9ttxLNnxOu7LHnd2tslUZ/u0CbL1vU?=
 =?us-ascii?Q?VoYZry33sr9v1ol9okX9YfYZ6Xrv+Y7H7hgP8wEuZW11lVtjQE6Pc8oJZlM8?=
 =?us-ascii?Q?x+ihBipsMsZhzmgXGyJqOe3DjL9v4ivwTenb1sSeN/mbIEMxw2GM3r67OvI/?=
 =?us-ascii?Q?lsBuexyygp2hdZrzlHM/JNEwMQurq6z59Gf6c9mqLUGDRH6Sk3AvKZBcp3HH?=
 =?us-ascii?Q?rfAdaszehcbKLWdPExQQuXW1ApYspru/eYfcVThUVkRO3RzW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af5d556-31f2-4992-14c3-08df3c26c894
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:55:38.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmXSbobZ8RSWw8Mj5Qau0377RBVV7/gENJwEAXVQk3O0icM7GvPmzdXfPD5YHR0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

On 6 Nov 2026, at 11:48, Lorenzo Stoakes (ARM) wrote:

> On Thu, Oct 29, 2026 at 10:08:44PM -0400, Zi Yan wrote:
>> __split_folio_to_order() calls prep_compound_page() on each new head p=
age
>> to create a compound page after clear_compound_head(). prep_compound_p=
age()
>> uses non atomic __SetPageHead(). It is mostly OK, since the folio is l=
ocked
>> and frozen and no one else is supposed to modify the folio's flags.
>>
>> However, code calling migration_entry_wait() can reach the folio by PF=
N,
>> then access its flags. It is because softleaf_entry_wait_on_locked() u=
sed
>
> Oh fun.
>
>> by migration_entry_wait() sets PG_waiters concurrently without taking =
a
>> reference and the frozen refcount during split cannot block it. Meanwh=
ile,
>> __SetPageHead() does a plain read and write, so PG_waiters atomically =
set
>> by softleaf_entry_wait_on_locked() will be lost if the set happens aft=
er
>> __SetPageHead()'s read and before its write.
>>
>> One example code interleaving:
>>
>> CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()
>>
>> 1. clear_compound_head(new_head)
>>    new_head->compound_info =3D 0
>>    (page_folio(new_head) =3D=3D new_head now)
>>
>>                                            2. migration_entry_wait()
>>                                              softleaf_to_folio(entry)
>>                                              page_folio() -> new_head
>>                                              (not the old head any mor=
e)
>>
>> 3. prep_compound_page(new_head, new_order)
>>      __SetPageHead(new_head)
>>        tmp =3D new_head->flags.f  <-- load; PG_waiters =3D=3D 0 in tmp=

>>
>>                                            4. folio_set_waiters(new_he=
ad)
>>                                              set_bit(PG_waiters, &flag=
s.f)
>>                                              enqueue on waitqueue, sle=
ep
>>
>> 5.     new_head->flags.f =3D tmp | (1UL << PG_head)
>>        <-- store; overwrites step 4, PG_waiters =3D=3D 0 again
>>
>> Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bi=
t(),
>> and CPU1 can remain blocked indefinitely.
>>
>> Fix it by adding the atomic version SetPageHead() and
>> prep_compound_page_atomic() using it. __split_folio_to_order() uses
>> prep_compound_page_atomic() to avoid the issue without adding an atomi=
c ops
>> to other prep_compound_page() users.
>>
>> Reported-by: David Hildenbrand <david@kernel.org>
>> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.=
com/
>> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pag=
es")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Nasty one. Some nits below but change looks sensible to me so:
>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> BTW AI flags an hw poison thing doing the same:
>
> memory_failure() does TestSetPageHWPoison(p) on an arbitrary subpage be=
fore
> taking a reference (mm/memory-failure.c:2458), which races the same way=
 with the
> plain flag clone and with folio_set_order()'s plain _flags_1 store.

These reference-less accessors are always making trouble. I will think
about how to deal with this one.

>
>> Cc: stable@vger.kernel.org
>> ---
>> The issue was raised by David when reviewing Ye Liu's "mm/huge_memory:=
 use
>> READ_ONCE() when cloning folio flags during split" [1].
>>
>> [1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e3=
31291c1@linux.dev/
>> ---
>>  include/linux/page-flags.h |  1 +
>>  mm/huge_memory.c           | 10 +++++++++-
>>  mm/internal.h              |  2 ++
>>  mm/page_alloc.c            | 20 ++++++++++++++++++--
>>  4 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index b0ddc652e76cc..08492ab3da895 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -854,6 +854,7 @@ static __always_inline int PageHead(const struct p=
age *page)
>>  	return test_bit(PG_head, &page->flags.f);
>>  }
>>
>> +SETPAGEFLAG(Head, head, PF_ANY)
>>  __SETPAGEFLAG(Head, head, PF_ANY)
>>  __CLEARPAGEFLAG(Head, head, PF_ANY)
>>  CLEARPAGEFLAG(Head, head, PF_ANY)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bd44d58e86845..319b038eba89d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3779,7 +3779,15 @@ static void __split_folio_to_order(struct folio=
 *folio, int old_order,
>>  		 */
>>  		clear_compound_head(new_head);
>>  		if (new_order) {
>> -			prep_compound_page(new_head, new_order);
>> +			/*
>> +			 * new_head is recognized as a folio after
>> +			 * clear_compound_head().
>> +			 * softleaf_entry_wait_on_locked() can set PG_waiters
>> +			 * on it without taking a reference, so its frozen state
>> +			 * cannot prevent it. Use the atomic version to avoid
>> +			 * losing a concurrently set PG_waiters.
>> +			 */
>> +			prep_compound_page_atomic(new_head, new_order);
>>  			folio_set_large_rmappable(new_folio);
>>  		}
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index aeebb3e49ed11..9b8864a8540aa 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page =
*tail,
>>  	VM_WARN_ON_ONCE(tail->private);
>>  }
>>
>> +void prep_compound_page_atomic(struct page *page, unsigned int order)=
;
>> +
>>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>>
>>  /*
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 143776e671abb..ace1359468046 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -682,18 +682,34 @@ static inline bool pcp_allowed_order(unsigned in=
t order)
>>   * This usage means that zero-order pages may not be compound.
>>   */
>>
>> -void prep_compound_page(struct page *page, unsigned int order)
>> +static void __prep_compound_head_and_tail(struct page *page, unsigned=
 int order)
>
> NIT: can this just be __prepare_compound_page()? I find the head + tail=
 bit
> quite confusing. The __ implies it's an internal function.

Will rename it.

>
>>  {
>>  	int i;
>>  	int nr_pages =3D 1 << order;
>>
>> -	__SetPageHead(page);
>>  	for (i =3D 1; i < nr_pages; i++)
>>  		prep_compound_tail(page + i, page, order);
>>
>>  	prep_compound_head(page, order);
>>  }
>>
>
> NIT: Maybe add a comment describing this like prep_compound_page_atomic=
()?

Sure.

Thanks for the review.

>
>> +void prep_compound_page(struct page *page, unsigned int order)
>> +{
>> +	__SetPageHead(page);
>> +	__prep_compound_head_and_tail(page, order);
>> +}
>> +
>> +/*
>> + * PG_head is set atomically whereas the other metadata is set with p=
lain stores.
>> + * It should be used when @page's flags can be modified concurrently,=

>> + * e.g., in __split_folio_to_order().
>> + */
>> +void prep_compound_page_atomic(struct page *page, unsigned int order)=

>> +{
>> +	SetPageHead(page);
>> +	__prep_compound_head_and_tail(page, order);
>> +}
>> +
>>  static inline void set_buddy_order(struct page *page, unsigned int or=
der)
>>  {
>>  	set_page_private(page, order);
>>
>> ---
>> base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
>> change-id: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c
>>
>> Best regards,
>> --
>> Yan, Zi
>>
>
> --
> Cheers, Lorenzo


Best Regards,
Yan, Zi
