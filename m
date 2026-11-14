Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794647479;
	b=ekwUF5/oGBIO3aPVnN0p+K6g7mGN9wd79KhZFyqCIfB6nTRaxy9nuMIlQtX8VSZjclW2
	 ots+kIayzNtDH+DMM3mkYR6Kl5AZfBC8gF/8Hc3ZJTQMc9k/SXWZ0gQwkBJAfCtKclzHx
	 83A36dAmPi2cIXOYZkHUSUlY4uYrL5VBzmqshx9zZPV0MngIgwa1ypirKwECLE0LF9UFk
	 2rJZrLzQaBKeq86q7IJqK8tdBAmmJW5gbvTQ3WnnNqYfpXD+zxIA4D9syvgIOFwRdU2jF
	 YwA2zOh1b2cMjYMvYEOERk2AhPq85c2ULDi9lLd5nttsWOEi9iUyUFRqf14xCrjcTIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794647479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=RVX9MRa9dV1R7ULlZD8/sNmRw4/XsN2yz2JOSVUwTg4=;
	b=oKHI1x/d1edySSDTZhxAJhC2x8/bMDkTn6FunXV1W7aLhtBP/Y++CoXSPhWfMaiUMo0Z
	 BkOyhaJxiDY2C6ngbKKQkztm39RV2+NjwtAQrlIypnred+3Du215+m5SBN90ax/rRlSCN
	 zDyXkeIDPK6w1u0Ough94mOnfW/5h/Kj0j0GtPtu+ZVVAva3chaYe9S6lPhTVR3xxtrZ8
	 ml/1qZmj6EanyJXe+lA9271yQsNZr7Fqf0ColEEzKCfMHvVxhsEaJkbqeB5QaNX6zWIOk
	 3pOXQNRDW2j3duKCAOjkj11aCcsk1V6dBNRZ4jH6NSH743jvMAt4IsIGtk3vHUL4zUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=adkHNykx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.23
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C59606A329;
	Sat, 14 Nov 2026 09:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C59606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=adkHNykx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EI0tqvG3qbyyAD65RIX6453GTXpl9GRAg7keVFZhqBysH47Ncyb8cng2mE8R4hf1I91Tf8SlMXXWmkqxpIRBzDRm6XPcMN0KYmD4G/10hMDYnxx/p79z0brEiHspw1g1zCP3/cTSuc+qcJASguRzP4migr6rTThHWALAPGiGsyPTgV089lbuQwhqlGThxxDzgBI7gs8fWJ6jd6cdF6grOwOXufAHdYJukOTkBL4pmodghzeDAFTWlIGDx5UU9WsUhEcPdiQH3HiPXDWtJ7yqKfvrnD5ttuFqWAgC9t8F/OPdoJZjEvcKzraCnGG/q196aNg6NpXAK5WJeL4tz6tH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVX9MRa9dV1R7ULlZD8/sNmRw4/XsN2yz2JOSVUwTg4=;
 b=B41NEBm+Hyw9SYAovAYjxMICMM8ZhC/luVLpNLlLZyswglYaPJqEeFsGfJMPW7YuKWc/+392DGKnUnMpdocMmvs9F5Wm2BoGH62oxVQ5DgM5OKnGKAdIiHOFzd0sUYs44GF0qZU0SMdSFXpy42Jgx2xlwCfzj2efdC6QGvRLqE09BMEZ4j3YopZ99IjOe2Ea8NpaaaqtDKiFlnguJmlEyfhC3Fm5X7rJW4iqUYBPpk6FJZ7cn/XuReQGDug15e5Bn0zZw5xw3wuV1ZNzidqnclZpELHpxWyEUEsBmJs731mBczRBO2DX4m/w75OKk0mgeEU/vuO+eD4zf9zZfUw66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVX9MRa9dV1R7ULlZD8/sNmRw4/XsN2yz2JOSVUwTg4=;
 b=adkHNykxSQdd9gs31MwLjCP3lhJvHbZ04zM44/At4mwnupKYvG1yhaRRgc6T6MTg1/TwBteNw+ot/Penef8sBOnUJn9pGAuuyJkcqO8dToPUrYvc9WWumt6TxgztPz4oGdbBH4BBS0TuDsJZBT1+E8KoQteJl9FIbHFQFuW1hs9+HqDHNmxUc4NlMdb37BHUpDcegyMWfzEgoTeNnn19Vgoittv4d9c8u+fzj0ss2h0GnC0s/qBKMCwCf1lUWOvexnaypg6nuilj51liEFqPRmbVzlAMPTTARIC+VsTUBGdHFKuCXhHKlZ4bXB183HRpwvbWV/Xq/bK/uVlvNbPG6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Sat, 14 Nov
 2026 09:11:13 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.008; Sat, 14 Nov 2026
 09:11:13 +0000
Date: Sat, 14 Nov 2026 10:11:03 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rik van Riel <riel@surriel.com>, Usama Arif <usama.arif@linux.dev>,
	peterz@infradead.org, mingo@redhat.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, samuelcrossley@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kas@kernel.org, Arnav Aghav <aghav@meta.com>
Subject: Re: [PATCH] Revert "sched/fair: Add SIS_UTIL support to
 select_idle_capacity()"
Message-ID: <avglp8nnc4u9OCb5@gpd4>
References: <20261113153157.2495664-1-usama.arif@linux.dev>
 <eba9d3df71f3f37bf7a318854a1ab6bf1cfb1981.camel@surriel.com>
 <CAKfTPtCJLci=Yzq6B0-hK5L0m5iQPw1Y0NDQhKEaV6reg-690g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCJLci=Yzq6B0-hK5L0m5iQPw1Y0NDQhKEaV6reg-690g@mail.gmail.com>
X-ClientProxiedBy: MI2PEPF00000B7A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40e) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe2c4ad-deb3-449b-2a5e-08df422f3b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|22082099003|10067099003|261028144727099003|4143699003|11063799006|261026121527099003|261022075727099003|56012099006|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	NVX9FmDfTG8m1fnCzWUinyU91wtWljdbTjArl6vYEF/n6KXAwhFG0u9B09LDKTqwUCCzfR2OOcLoRjh7hj8bCbSahzpjvMKCc48dz3NRJGjirtyI0PWAi4X0jyarzClJWUho23r1MkYNE7qgSPzhBHQvUDf5Z4szTpc+j176LHg7hg2VgOHFnPX5zdo4D9QAygg5IJpfM2B2uiSxfvMEs05lVyee3r96DIL5IeCeP/NaccKcP2kz75yBGWNLooVQPNLKBoWm3FRtgRH0KORDVruXYMrruQ5xh5purlwPUvzBztqbYrBoXHcpMnOxCHkA/TcFaLIUkN5CDvBScrbGVODvpmGtxhDz6hxbLGv1kIA39WPaJHk4C75KDbx1BrX8zerOE60+4lkh4egImF+Mzq7pUTPp9MX6eCvXpaV4TVobLBChyfu0+BdKkusHVg9Gju6dYcF7KP0mOX5ZhApkEkExOmsLQf3YmrjK8SKcv0NgF6QTXKSShI36WN9FK6RdXX+EOhaJKyIJDXkOfR+uAsKUHUSq/pefr0pkqxwZviYsmpXfNdZvC3+rIRQgLinYj9pmSNimJC1b0/x/lcxbPh/s2SlXGJOYBossk+uElHCqsXt/zHlUjMm2+Vh/eVcxpmhmTi2aBbgC53n8aVpZ7H7Gchy0q0BTFaEVINC4qb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(261028144727099003)(4143699003)(11063799006)(261026121527099003)(261022075727099003)(56012099006)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JJWOccdybl2EQMK37253pK8t9IDN3o7d/CHDi7ZWuJulJDII0Ts6a2HAOgfd?=
 =?us-ascii?Q?ogHwH7MPZ1kcDqJCN2eZ9QQPXo6RaMN8cgz9c/o4HbdDHFetIJo2KI8nckki?=
 =?us-ascii?Q?3v9C/l+BO19UHN7m+1VA1gZE4tAox3kDfjBOSJ3gAtuW2w1ZyETXzPzCzyS6?=
 =?us-ascii?Q?ijl7BzujPSFD/uUcJzlkVhz1+LkezrF9E12rUvnxLu4G8G5z4fZpsKHNL53w?=
 =?us-ascii?Q?E6Y0qjuiJEOeOWyqU1rsN6marAs0e0ccbyjZQUp5PWrgkvG1/LWFPVdIxu4Y?=
 =?us-ascii?Q?LXxThMA0qkdYbDicxJMdRoo5VU/iSTbPne9Bpwkh/vl9IEl7weJ5rx5FYJY7?=
 =?us-ascii?Q?/43RXVEgqXgp+3x+yPdv+tG8g2ptL5j7RGqBULhSgE/X4ybqHWIVgJ9KqE3L?=
 =?us-ascii?Q?WafjMWcGifQxbGYJlTmREzy1MsZ6yB6H7D6rIGa0T6+g679CAmcAShq4y3uF?=
 =?us-ascii?Q?d4TgttHMtaU6f1FlNdHUocMkH/mZMe+Shx72giqC02Qra2vzgjNeC/urYPMQ?=
 =?us-ascii?Q?LhxJ2r9QC16X+5+aWEwJSpACXHyFYz2iwqIdIlsJ9cBpEnGHqMYewee8oapQ?=
 =?us-ascii?Q?XEhy3C9hW/+2vfMrOVTrZFSyL58D+x805zGxPlexYTJErgQgh1q2t6kQIqlf?=
 =?us-ascii?Q?gELdCSXAGtrpNQuBallFPM9abxzWFyTD7+CHLJxJenaQ+RlhbrMvvyjkIFpd?=
 =?us-ascii?Q?vSYtLTg5cB9WlamdjHcloCUoNv4ThWXBr6LxeBtOifLr7/QZyBZaqW67jn3w?=
 =?us-ascii?Q?XD27JpSd4BAMJjElW3/heSheBYjywl6Dl+Yk22o7v6ZWe7B/Z4jOUbiQ8xtV?=
 =?us-ascii?Q?AkAOd1f5z0V2qX0yXAnTs3FBgh4ivBEC0UReEeSQ9R+Y/fMltpYGAYFK8sTV?=
 =?us-ascii?Q?qqOKmxT2nuUMgsR/FnxCX3HwzE9shPpEshRnJvUfoFVykYupwV5sX2ZGtF/a?=
 =?us-ascii?Q?/kLw5PcIdMzO6/vkusGu5mSqc0L3g7QR7hGtdWQIf92uF83UZ6Y9ky+8oRV9?=
 =?us-ascii?Q?WYi5NMtIYEs/TPGJGXJztTt1K3QloaBF5yZ6PkqK1aHhD4hwTf1/oFG9QTxn?=
 =?us-ascii?Q?ThiJhI8n3eGRxvG3+4+M4NfYbSsi6yYMSjRbSB8D8fTC2rpunv2OBF6uJDWN?=
 =?us-ascii?Q?F6NdUQ2uJn3dOVdkvcyNF6yhgc9FYH0HnIlc33fW5znuGRQSkUOK/BqUo22Z?=
 =?us-ascii?Q?ci1kk1gvk/wJ7KxU+odVqgtHmk4B8/ERTD+ijtGfK/OlOMJPcX4l2JVDyqUQ?=
 =?us-ascii?Q?AE81KqbsUbg1qtSKg6LjIzFTawhtCNzFh3NQfNRQrOvpjtOE/n/EBcxDiASG?=
 =?us-ascii?Q?eF2StidlR4UNhS/deQEYMqrIm5/pt5hZ4Uf0E8xB9u65PUiu5k7dNis57adL?=
 =?us-ascii?Q?Uq7m6MYAcI+rqzSE0qCoNQwOt0HHyXrK+RGjHwMzPO4FHp8PjRaJsNfXtYu7?=
 =?us-ascii?Q?JGT9nkDMBJjfIxpTUMLakcZy9pVyPeIEeAe7StcCPq9Kszg1yAg4xH6xAMOM?=
 =?us-ascii?Q?fFS65Ce5uPVKOpP2zPSrBQ/8AB+MKfT6gmQopF2xCc5dSk4ITRl3hQFAIgav?=
 =?us-ascii?Q?eALCDmiuBqEWcyCUgcJGnkTf69jK2BgI6fijaNyaShiUXlalcp3FwDvAyZKa?=
 =?us-ascii?Q?nN8qVf3Pi/bqFDQt3YqFe01DDy6jS28EkFkpHjcrM34rdqrfdKny71/rBOZK?=
 =?us-ascii?Q?6gFlqUvxSpnf28tIfnH2ffG83jr0MKCitFCWBSuC3hb8ruKkQRBd/oOEJm7v?=
 =?us-ascii?Q?Q8N8WRSqlQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe2c4ad-deb3-449b-2a5e-08df422f3b25
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 09:11:13.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rvA5fOoun/RdofZwYJikOns6JxXcH6AAyqLGL2F1R0qJBp1FrXlvIXpynRemjAdxzKmhZgM0qkX8Si1gcpQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

On Sat, Nov 14, 2026 at 09:18:30AM +0100, Vincent Guittot wrote:
> On Fri, 13 Nov 2026 at 20:32, Rik van Riel <riel@surriel.com> wrote:
> >
> > On Fri, 2026-11-13 at 07:31 -0800, Usama Arif wrote:
> > >
> > > On a 72-CPU NVIDIA grace arm64 server, small reported capacity
> > > differences
> > > (1013-1024) within the single LLC activate asymmetric selection. Both
> > > the reference and affected kernels were observed with a zero scan
> > > hint. The reference kernel ignored it and still searched the domain.
> > > A latency-sensitive, wakeup-heavy production workload saw its
> > > reported
> > > minute p50 latencies average 129 ms on the reference kernel and 223
> > > ms
> > > on the affected kernel.
> > >
> > > Disabling SIS_UTIL reduced the aggregate involuntary context switch
> > > rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
> > > raised the rate to 73.7k/s.
> >
> > Afaik, the asymmetrical selection is supposed
> > to solve a very specific problem: when a task
> > requires X amount of CPU capacity to run, we
> > try to avoid scheduling it on a CPU that has
> > only a fraction of X available.
> >
> > This creates the issue that a task that appears
> > to "need" exactly X, because it's been running
> > on a CPU with full available capacity, ends up
> > not being scheduled at all when the available
> > idle core has X-3% available capacity, because
> > that CPU happens to spend 3% of its time handling
> > interrupts, or running something else.
> 
> The task will be scheduled on this idle cpu/core of (X-3% capacity) if
> no other idle CPU with X capacity is available.
> The selection in select_idle_capacity is:
> - Idle core with enough capacity
> - Idle core with enough capacity but doesn't fullfill uclamp_min
> - Idle core that doesn't fit
> - Idle CPU with enough capacity
> - Idle CPU with enough capacity but doesn't fullfill uclamp_min
> - Idle CPU that doesn't fit

Right, and when the scan budget is exhausted select_idle_capacity()
returns the best idle candidate found so far, even if it doesn't fit.

However, in the zero-budget case, we return before examining any
candidates in the scan domain. Relaxing the capacity-fit rule inside
that scan wouldn't change the outcome, because we never reach that
check.

Maybe Rik's suggestion could instead help with the earlier checks in
select_idle_sibling()? Accepting an idle target, previous or recently
used CPU whose capacity is "close enough" could avoid reaching the
zero-budget bailout.

The tradeoff is that we'd accept a potentially weaker CPU immediately,
without searching for a better one.

Thanks,
-Andrea

> 
> >
> > In that situation, it will be better to run the
> > task on the CPU with 97% capacity right now,
> > than to not run the task until a CPU frees up
> > later.
> >
> > Things like SMT and power-driven hardware
> > scaling complicate the matter further, because
> > we simply cannot see the full amount of capacity
> > that is available on each CPU.
> >
> > That makes me wonder if we should simply accept
> > any CPU that's "close enough to X" when dealing
> > with asymmetrical placement.
> >
> > Say, anything that's above 3/4 of the capacity
> > of X would be considered good enough to run the task.
> >
> > That still prevents us from placing a CPU intensive
> > task on a little core in a big.LITTLE system, or
> > from placing a task on a CPU that spends 80% of its
> > time handling interrupts, but it will allow a task
> > to run right now, when the capacity imbalance is small.
> >
> > Does that make sense, or am I forgetting something
> > important?
> >
> > --
> > All Rights Reversed.
