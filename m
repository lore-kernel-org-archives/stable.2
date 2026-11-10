Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794328623;
	b=nZs76Nq53I9jdX6nxaLik4C7PBtBsZpmL4uEmwn0glqwOazUuCjjzdnv+clNJYlrwplx
	 JLJp6FzSVZ6QGHuESvt4bSKgNcAP+95795h0eZsiOxzxcC0rO72Tpj1bsS9tm/Z81cLx2
	 QIIqIJuVeWRfczpJuY/TpSuDFACwWj7KZaDefhyXpxCt8o2fxWl7v20ZGQwQnioZ/xsjf
	 ekcWBH/CGDhINlMZXI4fiEQcfXnDv0QcCxT0p9kJOQfiQmbu0PFkCeMotRZcHYFcd11Un
	 FqWp6vZeEXF9AEa5wDpzC1Y2QVFcxRYDfGt9LNkhVyi1VkwMmFdGYuzTKu5hpQ8U69g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328623;
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
	bh=BNj6o+e4HK9w4B8joJl2MWtu/scRno9HMR7zwxLXqoM=;
	b=HpUeW/mZnmQReRFOW2BKThgh9F8U3MOZrmhSW06Naq2t2ScRHajmLnH46nF6ak6MIO0B
	 VubCeY57ADsvLeBhwl2eEzPPFi7bnn+LykfCYn1MekV1+owEkj9i1GeIU7mctlz4l0oes
	 7KQwXHpPMzFh6Y/UjmfL8siHtcncCXpIsKFY4hhykeFZ8IYjIOV6FJDAojTQMO4yiRoXK
	 qE5MKOxfF6uQv3sEOIKVYT3hvh9U3U8cp1D+Su/dkXhPtaLVxhQNnClMXGJrUB9NmU+Ls
	 ifF54rYylDzUmyiVZD0qAQx8BkbiNcGqW3OoCAQhQ/lrMvfAS1A9k800APu3QLslhsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gJqTqczp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.2
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29627606A225;
	Tue, 10 Nov 2026 16:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29627606A225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gJqTqczp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFJIImkH7OW2np6T+UzG8xov2+CduFxPlywNTp2N0deUBIR8ekEa94+EiVI80TrvEEmV62ekkhnsi/orlgOylDQ+GLrOW1yqYyrp4Vz+KDOW1h/4ojhSuX7R1Dvv7Rpj9xE1AFSYcHVjMRodkFgLBfzZiu1WIS6TeGuLG43RH47uzOD2+5/XT4lZynvSn8JtwKqR1XOcRkqBe6cvrLtGu0PwSLShWvhVApgxA5WbjLbW9BVHJrQCcnkdLRr89vZ6cXHuG9h8pnYDzmm9YSqDCnqgxxxi1RZ7WUDj36sX8jgYVR43js/MEMnm8j7A+4+x5WAANF+SMJKNpJAIT3V1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNj6o+e4HK9w4B8joJl2MWtu/scRno9HMR7zwxLXqoM=;
 b=ixRo4ZPKr/Zhww9h+Ecj60XbdFFE9AG5AdnGV45nHD4RHJipM1PGYceZnMPTTkIyQMJPNDPVVJsFkiqtT7U+CsVzuumLi3441h14Z20sqxjmGJ9WwHmjhrZttkQ9m60Okp9XdRp0cXZTDmluz8mn+bqH3LhfN72ljdpTdTQvKhL7N8rl420bGnjLftRvehEbMuYeQKDTKYuxfxJdqEosnoIi3D81lzMQ9zPW20ZliSNiZnpCpB+8XO7rAnrEJKJw4BCW26UK74qCYWEnMZNgX1WwJapr98NXJ3+GCVioFOWdeT4kpQ2Dq2I56vd9pxA596jZn0NHciHoKgcYBEtJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNj6o+e4HK9w4B8joJl2MWtu/scRno9HMR7zwxLXqoM=;
 b=gJqTqczpMwF5rxde87np4I/ycQJTHGSG5LFwS58CaK8gAHnr5v6mcG3/WXoe79STOfk202go5N//vTn5gIiJAvQO9w4tyV+nToAPbZzCjylgsrQK+lmNmEHsrdIcV6uoJzMPHUOW9q3Mj1rEoygwkwWBN2zefIREJ1o95X9uDGQYWfeHPgcmTJflXoEiIprGfcsUgM1rYONauHpo4RvXB35V+01jDR3Bs+e6sD2JoTQFe+Z7EVAbzU6IJj64YGcUlPC7VcAwgi5gFp38k0Et6HZJsdtBeCtnWSMvNcBkLQh5bfVZmVJI4B7tLid0M2bnBqQOKcraJKDwoP2I2QqaYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS2PR12MB517653.namprd12.prod.outlook.com (2603:10b6:8:70a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 16:36:57 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 16:36:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kiryl Shutsemau <kas@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Date: Tue, 10 Nov 2026 11:36:53 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <117526B0-43C1-4F60-BA2A-3726AD1A9BDA@nvidia.com>
In-Reply-To: <avMaQIdAj5Zal3rd@thinkstation>
References:
 <20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com>
 <5a7bb477-5392-404c-a748-4748cec2c84f@kernel.org>
 <940CBBBB-D564-4D4F-9C8A-A9A272F08064@nvidia.com>
 <a3557629-d86d-42f6-b181-bf8540dc1982@kernel.org>
 <avMaQIdAj5Zal3rd@thinkstation>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: CH0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:610:cc::21) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS2PR12MB517653:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f9cdc0-f893-4f5e-512b-08df3f48d5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|5023799004|4143699003|11063799006|56012099006|261022105027099003|261021121427099003|261026121527099003|261028144727099003|261009223027099003|261102123227099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Iiv9D5BreY4uuU3GJkqvFfObi1/PtUEQyrIjV+z1h0DU6h8dzv/74NlFhH4c9Bl/O+WpiQc4TfiTuIZUZBfDobRKOHlgPW/7PEj95hlBn70J+rtvT98tBtzHuIM4bdPQQ0gGh94vd3wQaVC3oA0eputYXwz6RQ3kapNIVClQRTczbUMNp2obh+wN8Iq0P+ziqvQmu96ikdR0S1sVeDqPF6Y082+rR3GdaHwy8GaskPb4qY01wHzkQOx+2h5rYCF1/Hqvuz6icFD4NfkS4fjMXv16nzAcB2+A7JtCdqpj5JxE3gtBqAzu2hdwNYgpjYrJFYxcZd4O6lcXcVcWsCnV3RURQrFWhUMQK4Yfx25F9Kqb6DwaEo+2aSIoBDuCO5gvGRWyBPI9ts1dguzoZtXxLJbCBrcXy7nZX4kQAI7DiyORYuu18LKFSZW/CHw2o7eYYQ2jVZMHtdTbg3LBEAv9+owngwKqC2vaKnj0aD4qvMZYQRURUMkCxTqMK79chDP+l6ezsUrnJAXjlMpVJritL/sFFgwCQAWEbfY02/VqaN6QLHG7RIfKCZrjApLznEmoRreX0bawHN5fj6+yvPAN8SDWe1ZBAeZV8hXsWDMMGNND2++YTdyizf9L5sziXTIq60Y2NeWLlggbFV+4UBUOWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261009223027099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8mI99eDSZuu820ezVlKOqMajKsf4njVbWwCCjt5VFsYuOYh+j1ixbMIKIien?=
 =?us-ascii?Q?fAXyKkZK4L70SA6BjzC74m3OpgwY8Hquf7qAk4AH3WmPBX03rwoaVHZoBlru?=
 =?us-ascii?Q?+DIz4AZdQS72yoWgFWhgpCh4yCJ9gfYeQ6gs4U3wwwgFtBk+6sotw0hFlMb0?=
 =?us-ascii?Q?hgh6Xl8vSFw5IQb+gJSv4yeobFdHChFdbenxEVkWl+XuzKGe8MsnOl8/2tnb?=
 =?us-ascii?Q?KxVhNxhvdMecFCdIfWmvSPOgLpvTlrIVEnzBjhX/AAt5qy0Di/TRvvp4sCef?=
 =?us-ascii?Q?TSal1fzreRYvJaskHicCtHNPZIM+h9fEkTVYHPQKjds+pZfpBocxcGAGAbij?=
 =?us-ascii?Q?bcx6tVTot11l9U2cH1BXza78G3S0eTb9RRzd7goCQhbMqZ3QplpKV+rvjLfQ?=
 =?us-ascii?Q?W+IqtS5FKz1A+tq4/d4bbNaqEndyJAE+3Gz1ArJoFwvOwFbFyyWaG6rSOKGc?=
 =?us-ascii?Q?+Xmrgs/W91Q9nwfbqeiaMP5fjkgTb57nQ4Up8RXaV3b2OZB74CgzllOCVuuC?=
 =?us-ascii?Q?h/1NMpaCcGPn0XvaUjgYgT9BfD9zL+ZIrKtcEnn3hQjNltgSypWPM4OcmIec?=
 =?us-ascii?Q?IhwetXJgljqWCsk9PLgAvr9NLAmyNA9/ny7OsM/2Qhd7N9HB9wPHqjqxWYAR?=
 =?us-ascii?Q?im6MXzsyycqNZ3cu1Y7YnMNAxy+5OgCSFyUDwYbXWr0nIVFG2raJ+DMjdjH8?=
 =?us-ascii?Q?NOTLVzQlVGnPUlYAC7R46oi6IeGLhl9yQVCeRkC19W4/gYqR8dXry3kXFRAj?=
 =?us-ascii?Q?JPTtU+Kd9GbrMjJdVumArTlOFL3iI0xrCkIvehrxtvgLZjl9EREaXQPSHnbx?=
 =?us-ascii?Q?dRZ4lbd3VEJ9jXWmj0ww+GY8V/P4ftXPajCPu92cpCnprwxn458Ko7UsR4S6?=
 =?us-ascii?Q?kGKzBxkJdCtFuV/3ZGvM11VfuS5s0YXja6NPTyP0kAFTMBP+ElQvuRt3k2L1?=
 =?us-ascii?Q?BAeCUGK8m+kLa+FcpSBJvKC5qlR8AETD8d4faEqeU8AHllOy5b9s2h+3oudv?=
 =?us-ascii?Q?s12tQ2h9idBT7sdJyLIA4wCP/v/kCJNzHWZ9ELNswB8P2DyKSL4gavT4DERk?=
 =?us-ascii?Q?3slpP8i6WJFhAWipTBixWh1jE8+3eIA1IMSreaCxcXvNuEjpK7hCK2iKJ/Yp?=
 =?us-ascii?Q?vJfmup8QL2KKCrclDdtS1W/lYgOsRhcjgg2lFuA1KzXcEJIbJuoSzmTw3dx8?=
 =?us-ascii?Q?0yQ12tkcuOd1LxIXLz7A3W5XZntMwkbHZO6lB+0l0FfHaIxUiZnzwFE9s201?=
 =?us-ascii?Q?3wbeayLu5kQzDPMsgyPWMj4GSBnqifcaCgXNlM0ZMFi2RqETQPZhb2MYtj6z?=
 =?us-ascii?Q?79hCvJuIKF+J5jbIamr1eM5XCZQJF/sHfxk9S+2DYu46K2H6g4UBQIIUKoYX?=
 =?us-ascii?Q?HitCvoWQGo4nX0etfmmfvOfOoRU79IvdHchri/yBZwmU+qQT9w9Q9shR24Ti?=
 =?us-ascii?Q?M2oU1SMLSqzn6fsD6gCuAwS/4irRlj3YVebjjq8wOHjlo7fG3KdDJYG3Shc1?=
 =?us-ascii?Q?gGp2NfExEQDizuib6Kfo/kzlwDltprrcYJZIorHZwTUxAK6xs8SJ10Ipr3uC?=
 =?us-ascii?Q?hA9Rv/Xjp5ZsyBaWZlnBOZrrMU+dix9cwxBOMpzPWeGdPoW9ucORQh9Cq6wD?=
 =?us-ascii?Q?qVhp80lKoLucd6nJ8z1BAbwVnFIqsTkIbHt9WJp89MXuYaif1buy3uK1vTlR?=
 =?us-ascii?Q?HaWKgebf3YclYgU1Xx8nfj37nt3+WirZ9ZsT/yBN2T1s16R6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f9cdc0-f893-4f5e-512b-08df3f48d5df
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:36:56.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjOG49xjNk+TPEtin7co07rhjZUs6jhqWyoHbvDN1k4zFeusyR45ExBJ2tPwzK4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB517653

On 10 Nov 2026, at 8:48, Kiryl Shutsemau wrote:

> On Tue, Nov 10, 2026 at 12:31:21PM +0100, David Hildenbrand (Arm) wrote:
>>> This is V3 of the patch. Instead of using prep_compound_page_atomic(),
>>> PG_head is written before clear_compound_page(), after which new_head
>>> is visible to the reference-less writers.
>>
>> I'm confused, how is it then valid to have PG_waiters set concurrently while we
>> read new_folio->flags.f?
>
> It is not. The comment names the wrong word: PG_waiters can be set
> concurrently on the old head, not on new_folio.

Yes, thank you for the explanation. I confused myself when writing
the comment. At this code place, before clear_compound_head(),
reference-less accessors can only see the old folio.

>
> CPU1 and CPU2 below are two faults on a migration entry that points at
> new_head. Both take this path:
>
>   do_swap_page()
>     migration_entry_wait()
>       softleaf_entry_wait_on_locked()
>         softleaf_to_folio()
>           page_folio()           <-- old head or new_head?
>         folio_set_waiters()
>           set_bit(PG_waiters)    <-- on that folio's flags
>
> Which one page_folio() returns depends on clear_compound_head():
>
> CPU0: __split_folio_to_order()  CPU1: fault           CPU2: fault
>
>                                 1. page_folio()
>                                    -> old head
> 2. flags  = new_folio->flags.f
>    flags |= folio->flags.f
>                                 3. set_bit(PG_waiters)
>                                    -> folio->flags.f
> 4. new_folio->flags.f =
>            flags | PG_head
>    smp_wmb()
> 5. clear_compound_head()
>                                                       6. page_folio()
>                                                          -> new_head
>                                                       7. set_bit(PG_waiters)
>                                                          -> new_folio->flags.f
>
> 2 and 3 race on the old head's flags word.
>
> That is Ye Liu's KCSAN report, and it is benign: PG_waiters is not in
> the cloned mask. new_folio->flags.f gets PG_waiters only at 7, after
> CPU0's last plain write to it at 4.
>
> So only the folio->flags.f read needs data_race().
>
> The new_folio->flags.f read needs nothing; the READ_ONCE() I had there
> in my sketch was not needed.

Yes and I should have checked it more carefully, but my focus was mostly
on whether PG_head could be set before smp_wmb() and clear_compound_head().

I will clean this up and send v4. Sorry for the confusion.

Best Regards,
Yan, Zi
