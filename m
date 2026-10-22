Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679925;
	b=PJEiez4pNPMqznGKMEHO43TI8eU0FOH97k6tvXlGSEDHX+UVynGPxGZmQxFk5t+Zt6nm
	 OcdtCqgXiS8NSI9/zd8/KqHjXsxEuasuOmpQGtbxPFhsM1PJ6w/gtiJl+48h2Hu9NXXNI
	 8abFr903ltIhfV10sR8dNhkxYbQPUqKhBMpZsRnwpK5mB3hBVitG8JuKOmv5b1EMKcImh
	 SkTirBsnmTFJNna6rEuGhgj/IP/pCykR2BiGMjQQxhQ7lbPszq9uf8rdahnAT+3PSPEXs
	 m6Vja5xHp4QiR92bfTuNuISXDLepv3E04we0FE/3/YD5kYU4ea29GikMiO5lI0TgvSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679925;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
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
	bh=H9ac9YOK3Nf/2ey/1YsEIvR78ChJrwY/m/v2CwaY2JQ=;
	b=5DuFrLnebDW5myQpjHEzaNOwI+wh0hQaLgFc5UtGjE91Gj/4FalrmK2mCfmAANNYyJOP
	 71JyAt6wLImVQnGqZ72+vNceO2PpIM8q6DDscELctVb04rzpRcIb5f4iCIk8KGrfda6/A
	 8balR8AE5/DzoC2qd+aKtTMZ8lJUxrQRGDwuGo8EHkb6fiTw0E90prvWal0+dniDnA9Qf
	 kw1JkBrxMQwvH5T9YtefVT1v3VBGCe0e9hmjvBb3WLQuJb4sT+/CIafhVNMtnA3nrt6Mp
	 4lK2Lj3wYV662MCPM5aYuZ63nByRcsDOkJX55joWvcL5sbGmL3V/5+Ct7dhGxn7jJ2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s74Qjcai;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.6
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9861606A31A;
	Thu, 22 Oct 2026 14:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9861606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s74Qjcai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0obRlgH13nqJ2igxh+y6nzDgvgbCxWMCujHj9mTlGzIvB+WWiCqKIqvFaLuQK6uyscEuioi1MQyp3UwFp1oGak29M+bwzW5PuWVoufZHnwCCiaYMlhaTiIYhiOx7Pj/UWghRC6Jrab4P3lnNlpalqKJfoTS2BDHsSZJQALLIWowQCpJX9HpoRlfJJNUTEP8e4O7Y6XfkSR42l2ocf0f27iMg53BkZ5RfxWYAM4zGle9uwPM5FrGZGj1tX8UEDv3R7+Cnv6Ybvidv8R2dwXiEQeDBvHa8FrlpNNVym0vOWu2VIAEzKVpV9SNwziOZgwDP17oDhc2QjkGN0FK5CLLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9ac9YOK3Nf/2ey/1YsEIvR78ChJrwY/m/v2CwaY2JQ=;
 b=kd1knM/BZl6PbNZDN1QPWDrxxOaFUvZzvFxNsMMsQSQUyCbx5lw0mWGIqR8xiDo1ukn3LUGkHPAZgvLbGcxEcTg60Mzbyn86T6llMpRSxUIEDkJZDUQXkcPHyTYrv2mXwRYBbK0ekFdK4eVzyV8ATz5cFIjtrZkYovqIIf/B1Aw2IrwyYgqreeC5DI7i1ug5ewVXLj0exJ/vVxwTsq+bpKsEhBf4KURtBhEt1GbK0mwfPsJ1VpNWcYgcOlMQ+kkQ8S/iDB4JQb9/N14VSx+zlYD7KuYpoqEfKvJrWKlFUs9y5OF3GWz759gerMVX6QZ3noTA7i4q/j9eYGdJ/4slYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9ac9YOK3Nf/2ey/1YsEIvR78ChJrwY/m/v2CwaY2JQ=;
 b=s74QjcainPGJzQRqaw3o1xfP32ilid48MEEnf+B/NWsVdqmGKtUodgPWpxpzWxpeZwMwt6hy0bwWU4NOo1+HX9jkXtMhUkRmoa0rYSgPG61C4H7Oivip/K7CGSYoT1/BUoVJudLVhTVajDoIFlihvuFGx1drenxtvZvGfSZf+JQxvvp8XsHYtW1qVJPostHnJxwIs2Kl7hHZehcN2qW2KuSIbPxUVFBBHwN5spAqNaiyQPdIuCXonAKImvg/9bVM+fXBYTi63OjOzo78y29QTx1OXbMYAypv6jm1gYVXN3Jez1VKzn6mOYqYs2Va0uBxKF7xLoiW38SrsSEe50+QvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:36:32 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 14:36:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 10:36:22 -0400
Message-Id: <DMBFY2ZGL367.LVBHVXCR4GPO@nvidia.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2] mm/page_alloc: fix shuffling and reporting for
 no-lock frees
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Alexander Duyck"
 <alexanderduyck@fb.com>, "David Hildenbrand" <david@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, <linux-mm@kvack.org>,
 <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261022062523.97082-1-kmehltretter@gmail.com>
In-Reply-To: <20261022062523.97082-1-kmehltretter@gmail.com>
X-ClientProxiedBy: SN7PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:806:f2::23) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ebc57c-c642-4561-9443-08df3049d9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|11063799006|261021135927099003|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hrWVW3tjuuJZFyze6uJlZS0VXB5+OPJH5wttvPQGAkKwXENxSBa8ysfjSyc98PO7mVlPzifLuRze07GRQ1Oe/pb6dOFSBQjZL5pGgZvyECcq4pKWezYViN2p+Tz6eaVVfej/32pjuXbRReH0k08LmBUsUuOAMPX/5xVzN73CahyiArDzc+1Q2yN2wsfkEjv4EUrv/8DeR/rb/4c4OlrGbmo68Piq09lG2goXB3FpoScfEniNOKjuMv0feYId6Zefo/MFlennTp3mUqGL7YZDoZ7X+hklDxYZTrkYVL07vRmExNaxvEq4v8q5P+VkUn1xBAX+cHemBm1uQIGgkvlXLrGxfuvEEJiwlwEFctqXVKadZJNLw92kInv8QTZjADT4J7HvxMGoVQOamMfjZPM1jOoglBZqBnUszSiSYjEySu5XBpsbLVjvvb4hmgbDB2I7G26a/tcQpMdzbQDsZVieLlBi+RuuL4vrndlDw8nlz5JQbXT57ow2L3C23R0+jNS5zqU82X68p6AugNMdFOQfkYNOwq1Bkn2J7vMcTvRhRpOhwYT0DFeo2BfwQmemPJ5tHx43ddk14i4yU3UVTlHHB8wUxIScjNgfWa2sBG6WRPd4ncBkcN1Ty1P6HA1/EMTuzcYqIcAMynMq5j0Fd9oBcrJ0UvePsW1MTS60kfqYfVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(261021135927099003)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z21hUGZlNFI1cTBhaTg0SVFnN2pETU5ndUNrWk05SXhtVWNCL3VBQkczS1Fj?=
 =?utf-8?B?dWFOOXpNcG8zWkNmWGxKdExoeWRIenRPalVZMGdDOWFkb0NBd2NjVkttdytN?=
 =?utf-8?B?Z2E0L2IrdXJnTmlqNFZ5Q2lVb0RSTFdxWHhBQmRuMmpKNG9GdlpuQmVyclg0?=
 =?utf-8?B?dzRIaUpqMUdWd1Vxbkg0SkdpK0ttZkQzby96VDBKK2d3MlpHQnBhVEdxblBP?=
 =?utf-8?B?bU5qN0pQeWVlM1dKbDVxWXpQQWRuN3Y5ZzVzN1hYVklXajBjZWVQbUF2aVZS?=
 =?utf-8?B?QjJoN0tLeCtpL0ZCbFZYNjhYaFdhbStKTVNwT0c0UUpjb3NMUWRQc1RYLzlr?=
 =?utf-8?B?VUV2MHdPaEwwK0F3VXV4UDVQL09ackQvaUgrK09KWmptcmYzTHJxMTlldk9V?=
 =?utf-8?B?TkhrcFk2b0lvbXlpVlphNjlDZG9qRS8rZFNUczJBV3pDb1J2ZlRzZjhXL09h?=
 =?utf-8?B?Syt0M25rR1dOeVlZMWJIbkRqSXhxMHhocm5JQmtabFlRVmJzd3VLbkt5WElL?=
 =?utf-8?B?MjhVYTU1QTJMb0dUTjNMYm5DVDloVFpKZ1o0ejZ2N3NFN0NERWhSTTN0Qk1V?=
 =?utf-8?B?em4vZGttNlZ5R0hIQ0I0aWZKNUllUDNmdWNsU25ycXNxRHBENmp5Q0RzTkVv?=
 =?utf-8?B?WEJYaFh5a2h5WEVnam5KVlZTN1JUb3BuSjEySURIYU4xaE9HdXR4QXNOemtm?=
 =?utf-8?B?L2MybUFSRU1URjhpeEFFSlhJbGIvdERvMHM4OGxhQ1ZZZjFpa1ZBblpOaC9T?=
 =?utf-8?B?L21GMFFVQVVZa1NUOTZ6RU5RN0toZVBPWGptY2lxTDhhSVZxdlpIYW9mREYw?=
 =?utf-8?B?Umd0NVA0a3ZuaHltdFhvT0VpNWJ0MkdhNWRuYmVpamk2NjRDaUoyU1NiQ2ph?=
 =?utf-8?B?em9FczB3RUFwaFlheGJqOEhrR0t4SnhzdnBzMVpLQlprcnoyUEFPMDl4QW5k?=
 =?utf-8?B?NG5XSDFNL0dBVEpvdm1DK3o0ejBZL2ZiSitjZ3Y2VCtjb2dRRjFseHNzV1da?=
 =?utf-8?B?akdyanFUT0RXVnljVFo2ZlMxZDRDTkRkREdUYmRZcmQrYkZjMTZpb2lZRTVW?=
 =?utf-8?B?T0JMYUEyOFM4QWRkNFVCdVBGNTJObEo5cEt5Z2FUd1dzb2UxcVhGb1I3K1Er?=
 =?utf-8?B?cTUwWWt1NStQV3JhTmhmbHFBR1d0TkVxTmxjWkl3WGU1TUEvZXl3MmNjRlNw?=
 =?utf-8?B?NTgzeE5UZkREZlkzSC9NTXBsR1RIeUthNkJIS1dJL0R3L01jNjhsUlZKcWRF?=
 =?utf-8?B?djBpUEVYOWN4ZHJTUEdZMnBhZmErWGxKa1R6WXZpbERBSEJsc05EQjNZOHlh?=
 =?utf-8?B?N2dpK09FZDI0YVhJd1pTRHNwT3VIN0ozbm03b0I4TXNaNzFWNVRiRWVxWCt1?=
 =?utf-8?B?S0E2MHdCUlZSY21aQ0lkdG5Gb2hlNGlIRldTTkFrY3dQd3lrM2svWTFOdVI5?=
 =?utf-8?B?cW9ocWMyOE9ldEJJaS8zVkJCYUJ5TlR5NVZaT0IySnprSG0xdFk2cEVJZWVL?=
 =?utf-8?B?ZmphWWIxWFJCb25Eelc2OS9Md0ZRQ3Vqb09LVkkzQ2hMdUhBK1pvQ2JncHlk?=
 =?utf-8?B?UUVaWDZhVGViUlFDNE5nV2pyMXRmWVVSMEZEMFJmaGxPWThSSGFUUndrcnpX?=
 =?utf-8?B?amRldmhQeVlSM2tZcmpZRW5GV2JxWjcxNThsRVhIVjRHWWtUQlBiR2NUOEFG?=
 =?utf-8?B?bm5maFFOcFNpSDdQbFV6ZGRQZXRNN3E2b1hTT3YyR0dsUElSV0dOaEFvc3Vz?=
 =?utf-8?B?ZEVHYVh5VTNqV2VFc2xleURGOWZ0LzlEUkUyNzVyditzTnZMK3V0U1h5Ky9T?=
 =?utf-8?B?bUEvdDJVRmRuNE9oc1N3cE5BcFlZOWtuNFJaOWoxK3YvdFFuUnJQS0swMktu?=
 =?utf-8?B?VkM4dnRFUWdEU085NFAwaXBUUXdjUTlXbGJoblYyMGNGVUlaM2NTRC8rMTFR?=
 =?utf-8?B?S1hKa3lOclNwMlZhcms5M0MxbGhCamJ3ZUhDcDVqN2VGVlVSYzA2dUZTaTk1?=
 =?utf-8?B?RnprKzNTeVpPYTA2THRJbmJPTUx6UU1lNGlkby96dDdJNi9BUmlSNWdBcHdF?=
 =?utf-8?B?MVExRFd4NlFBaE1BNUlmWlg3Q05rZHFmOW9IS3R0ellnUk44QmNtMlN5UHJJ?=
 =?utf-8?B?WFlYajhzZDlZQ0pCMjkrcHJJVnc4NU5FUnlnczIvNzNUVDI5TmlkUFBUOUd5?=
 =?utf-8?B?S2xiWjRNRVd4WWtnZ1pnTU9vRVJTR1kxelV3b01vVlNTTHZDck1WZkcrZTI1?=
 =?utf-8?B?T2xrZEhLNGJlL1dXRmNORWxsc3R2WU0xbXRRL0dCV3o3UkpmcTFwUVZmVU1B?=
 =?utf-8?Q?5OKgpXrteV+F/RNUzZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ebc57c-c642-4561-9443-08df3049d9d3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:36:25.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs8WoNs5oOdPd6KNFKK2ItIz3Y9D3r0LDWtkPEWAtUJ0uNp9s4AiZ/xmo78Vyo+k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

On Thu Oct 22, 2026 at 2:25 AM EDT, Karl Mehltretter wrote:
> free_pages_nolock() may run from NMI context. The BPF arena also calls
> it while holding arena->spinlock through raw_res_spin_lock_irqsave().
> When the zone trylock succeeds, __free_one_page() still reaches page
> shuffling and page reporting.
>
> When shuffle_pick_tail() exhausts its random-bit cache, it calls
> get_random_u64(). Once the CRNG is ready, this takes an rtmutex-backed
> local lock on PREEMPT_RT, which cannot be acquired while a raw spinlock
> is held. A test-only forced refill under a raw spinlock reported an
> invalid wait context at batched_entropy_u64.lock.
>
> page_reporting_notify_free() may call queue_delayed_work(), which is not
> NMI-safe.
>
> Pass the no-lock constraint to shuffle_pick_tail(). For no-lock frees,
> use a pre-seeded per-CPU prandom state, following the slab allocator.
> Keep the cached get_random_u64() path for ordinary frees. Seed all
> possible CPUs before memblock memory is released to the buddy allocator.
>
> Skip page reporting for no-lock frees. The page remains on the buddy
> list for a later reporting pass.
>
> For stable backports, FPI_NOLOCK was named FPI_TRYLOCK through v7.2.
>
> Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> Cc: stable@vger.kernel.org # needs FPI_TRYLOCK through v7.2
> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Changes in v2:
> - Preserve shuffling for no-lock frees with a pre-seeded per-CPU prandom
>   state, following the slab allocator.
> - Keep the cached get_random_u64() path for ordinary frees.
> - Keep the page-reporting guard and explain its NMI constraint.
> - Check is_shuffle_order() before the no-lock flag.
>
> v1: https://lore.kernel.org/r/20261005063515.6312-1-kmehltretter@gmail.co=
m/
>
> Testing:
>
> A temporary caller freed 65 maximum-order pages under a raw spinlock,
> then repeated the workload through __free_pages(). SMP=3D1 and SMP=3D4 QE=
MU
> TCG guests produced the same path counts:
>
>                                   no-lock  ordinary
>   shuffle decisions                    65        65
>   prandom_u32_state() decisions        65         0
>   cached random-bit decisions           0        65
>   get_random_u64() calls                0         2
>   reporting notifications               0        65
>
> Both guests ran PREEMPT_RT with lockdep, raw-lock nesting checks, page
> reporting, and page shuffling enabled. Both lanes selected the list head
> and tail. Neither guest reported an invalid wait context, lockdep splat,
> atomic-sleep warning, BUG, oops, or panic.
>
> The test does not inject an NMI. The in-tree BPF arena caller establishes
> the raw-lock path, while the forced refill checks the previously failing
> transition.
>
>
>  mm/mm_init.c    |  1 +
>  mm/page_alloc.c |  6 +++---
>  mm/shuffle.c    | 24 +++++++++++++++++++++++-
>  mm/shuffle.h    |  9 +++++++--
>  4 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 1533aebafb688..01bccb23a89c2 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2643,6 +2643,7 @@ void __init mm_core_init_early(void)
>  void __init mm_core_init(void)
>  {
>  	arch_mm_preinit();
> +	shuffle_init();
>  	init_zero_page_pfn();
> =20
>  	/* Initializations relying on SMP setup */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c483..f13993bda67e1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1014,14 +1014,14 @@ static inline void __free_one_page(struct page *p=
age,
>  	if (fpi_flags & FPI_TO_TAIL)
>  		to_tail =3D true;
>  	else if (is_shuffle_order(order))
> -		to_tail =3D shuffle_pick_tail();
> +		to_tail =3D shuffle_pick_tail(!(fpi_flags & FPI_NOLOCK));
>  	else
>  		to_tail =3D buddy_merge_likely(pfn, buddy_pfn, page, order);
> =20
>  	__add_to_free_list(page, zone, order, migratetype, to_tail);
> =20
> -	/* Notify page reporting subsystem of freed page */
> -	if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
> +	/* No-lock frees may run from NMI, where delayed work cannot be queued.=
 */
> +	if (!(fpi_flags & (FPI_SKIP_REPORT_NOTIFY | FPI_NOLOCK)))
>  		page_reporting_notify_free(order);
>  }
> =20
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index 82a2c7725a08a..2e1f76d6bf92b 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -5,6 +5,7 @@
>  #include <linux/init.h>
>  #include <linux/mmzone.h>
>  #include <linux/random.h>
> +#include <linux/prandom.h>
>  #include <linux/moduleparam.h>
>  #include "internal.h"
>  #include "page_alloc.h"
> @@ -13,6 +14,7 @@
>  DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
> =20
>  static bool shuffle_param;
> +static DEFINE_PER_CPU(struct rnd_state, shuffle_rnd_state);
> =20
>  static __meminit int shuffle_param_set(const char *val,
>  		const struct kernel_param *kp)
> @@ -30,6 +32,12 @@ static const struct kernel_param_ops shuffle_param_ops=
 =3D {
>  };
>  module_param_cb(shuffle, &shuffle_param_ops, &shuffle_param, 0400);
> =20
> +void __init shuffle_init(void)
> +{
> +	if (static_branch_unlikely(&page_alloc_shuffle_key))
> +		prandom_seed_full_state(&shuffle_rnd_state);
> +}
> +
>  /*
>   * For two pages to be swapped in the shuffle, they must be free (on a
>   * 'free_area' lru), have the same order, and have the same migratetype.
> @@ -159,12 +167,26 @@ void __meminit __shuffle_free_memory(pg_data_t *pgd=
at)
>  		shuffle_zone(z);
>  }
> =20
> -bool shuffle_pick_tail(void)
> +bool shuffle_pick_tail(bool allow_spin)
>  {
>  	static u64 rand;
>  	static u8 rand_bits;
>  	bool ret;
> =20
> +	if (!allow_spin) {
> +		struct rnd_state *state;
> +
> +		/*
> +		 * An interrupt or NMI handler might interrupt and change
> +		 * the state in the middle, but that's safe.
> +		 */
> +		state =3D &get_cpu_var(shuffle_rnd_state);
> +		ret =3D prandom_u32_state(state) & 1;
> +		put_cpu_var(shuffle_rnd_state);
> +
> +		return ret;
> +	}
> +

I see init_slab_obj_iter() has the same pattern as here (like you said
in the commit message). I wonder if we can have a helper function for
them to avoid the repetition.

Otherwise, LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

