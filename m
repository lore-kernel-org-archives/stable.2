Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BB420E71
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833705; cv=fail; b=RnCyiY7s4iscu1gJ/XqPmVz+SG1vux2f5HIpvIBGMmCpUVV6BbEwSeE25oyfExp14PT/KjMYFpwoXNvLhGmvqjdAebkUANVOW5pm2p6Idm3768p1hZZth0UmujqpmKt2Xz22Kj0TFBYILaellB7t05S4I9frUOAgjFxysjw7ktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833705; c=relaxed/simple;
	bh=ztJENs3FEW8LCiQUQT1xFxu5mfg51ku04Y4jQurI5Ng=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cyC9U1u/vfswXo6pX9dyQu1zkuINSua9pxu87MbA8B0IeyimnKe2bh9Ubcb1B3OJe0OtdqYZKv3+KPOOYPel2MnHZ9Vk0tX6UBqmaNUQ1msk1/2T1+qyYBZrlFm/kZQkFS7QLSFblM0tzbkO0Qzul+In39cYxtuq6t27KDNj0nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evbgHBGU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evbgHBGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785833703; x=1817369703;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ztJENs3FEW8LCiQUQT1xFxu5mfg51ku04Y4jQurI5Ng=;
  b=evbgHBGUvR4OqBTduu3ryLRBxjuVLxRjRDz+/E1XuLK0AtUcYn2TQlJz
   SidtVyAmzA/iyKexwLYKBAHXAtwLZfUXuCpF3jyXSfqllCAxJVXyBpPSf
   gdKiDu1i1UqKSzt9wGbRrNLmUasZ/fsSVChPaP1ZtphwmoH6nbQTJCNbe
   M8p9pvT1IyYXVrqgO0XZFknm2OcNH/KW9AZfCSrav72meTjvl4F9nAPIv
   gwrS/p9bSAhSuyHOoU5vwMxXO2qAL5TJJY8fMOWFXC8zJeBZ1yq3TKpZP
   LXRzS25Slr7biieJFUiuamz9WuBcoe3uilZxzY9wSncv9/4sJ0GT6hYAN
   A==;
X-CSE-ConnectionGUID: 3uZdugLTT9q1uBCl7vwMQw==
X-CSE-MsgGUID: dxS7n4HPT3WnOi8hCQftwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86499073"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86499073"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:55:02 -0700
X-CSE-ConnectionGUID: vkUO1BJHRdWCBuhHkP7UUw==
X-CSE-MsgGUID: RsJViU4bSpeOXeeijZYpOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="258778712"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:55:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:55:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 01:55:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:55:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tmk1ZUqtkogt5zVNfWk80QUvJMXaWgU568FKBVH77QkuJ1daocRM2v+818z9ZHxZGgqyb0wWwXw1x82OS8zT7tu1V/7Od3j5i+TY0msdewXeNZzthe8UznN15QTKqCQiV7qOn8uy+h8PETQFevGge7/B/9tcgSRFPVJT3ngFItkLCF4gd13j9pvfHMDeFchoXPUpL0ZZWJclsjSnXLx3JUWAQazB0Xck7AVPxnrpa7WpXd/x6BXuS4lWCQFOtJaKiN636BnxtAT/zx5MAsj1md7y7po9QbqXxqwANQkagdUX9zOwF3cEJTETdwFS7E/OjPJYT6bnFnn3Kows5JqdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4mHNQiDDUbOglWksTVC6NdP0VM4enKBsF2pmCjne8w=;
 b=ED7eDjgFlZxiVC6ipymDvTg7ZyfkhZNeyQi/imkcBVSG6FwytSJ5aNg6opD2nhLUPkG6Timl8B6BO8VbbhNC1rJRaMyAtxu0ekoAFiZjJQKOa1z0/wsHsrSDjFSleuVlgpI9+YAwpzftUjAN1tiXUi3JRGFzjBkaicBJUeX4sgrn8gAQ1ChlHCkLZZgVm+OJzwJQ8scyG3IGHAuJxRnstdLu+uOnrH0TPsmQiiadsltBgceFpg2KTqXrxfnvR7Ovid3UbzgACu9ehqrnXmv6NvDGfdwP09rh80gb5fUAb1IYu3IfijXqT6x2u/skGNCAZ5tNIkK2XnbuUWn7LFi2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:54:53 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 08:54:53 +0000
Date: Tue, 4 Aug 2026 01:54:50 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: Jia Yao <jia.yao@intel.com>, <intel-xe@lists.freedesktop.org>,
	"Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] drm/xe/guc_ads: allocate UM queues in a separate
 BO
Message-ID: <anGo2nE/j1QUKE0J@gsse-cloud1.jf.intel.com>
References: <20260803200838.98826-1-jia.yao@intel.com>
 <20260803200838.98826-2-jia.yao@intel.com>
 <fff60c87-460c-4713-a65a-e9c3841bbf2b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fff60c87-460c-4713-a65a-e9c3841bbf2b@intel.com>
X-ClientProxiedBy: MW4PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:303:16d::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SN7PR11MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 206a486e-cf2f-4545-5823-08def2060cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|5023799004|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KFBNWmh2ZUm7uMbuWuRLnJiBdEfLqSVKsEM/c3Q10ve7vNaUAUbNZU8MwgRrhVzOhMjeMJ46EvIrgFVZEfNp6T7VJJ763rLSf988m3mZrFehexAukI5m8dg77XnLXz4uI8HBtlOILRsMoI89CeHQ+CRX1j94dXX6ybZYuKypHI8FLbwxNbqTlfT9zZzt5p1EaJwbk1l2yUVuVA2qAAbiDziuVjjI/qqmVvGvoyRJS+Hb/zIs9d6imPKmeqVslu1s7OEC36PO+TjtrKouygKvIVmJ0Lml4qNN7J+jhZUz0R9OhflX9gC98q084Npa6VWrQaRjJhMIdU5G2M9kaI6lNL74A0lvp63GvK1XblaZR7Qdl0Xe4u48mZDzEg4Lp8iReSAO9Mq8OD48CibZShfOY0b39R7ffIMPw/nGUfKWY/LgBvnsUWVFgfucOtLhlrGg2gga7jtCRzyilF2IqTsK0l2B0iUPR4SQ+tRRXLdzBo2PlLVB2ZS96H5TwIkpglcOJDJpjSHxey4oSRftx/cJI+OKnndnRcix0CVk+BaPnD2DKgBDkHZ85ZUMpNUl6ys+Gq41atYT5VLfNWgX6QhlbvpkjET6Nia+XarF4/LkYkOc6Acql01lHDfHUkaeJoAPcGk8kQAuev1plmb8byOJq3b7XiCPCvwg5YbBxXjE9r8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4bIsD5cdxbH3jgVzU6b5VSU9Pye8QumFNQb/bjlawyL8I2B/BWCwiKnidWrY?=
 =?us-ascii?Q?YAwHzbENKOltNhGuJ12Oo5NPBeoH4X/sEIxf3bkk1PCodHcuZcvhMWu8c8se?=
 =?us-ascii?Q?9fnkn6PUP8emYCoQLB4bwAtglXb5jBw8EywpjzS5/c7Xk7Eu+tGtOQmEE2CA?=
 =?us-ascii?Q?ZdFFtmxWOWHvq1OujpYdrs5IWD+com78p/VcH0wVSpzl6orjUaXnK0Gf73GT?=
 =?us-ascii?Q?la0Q7xaoNgcUvPrcrS5jPhHJqVfJIrl2/Vz4MqvRKK26H7Pn1xKBtLiGALuW?=
 =?us-ascii?Q?+AV1FmpKOidKEp7UcyNelzsQYqtw7Yn5t90N1oHCmbjswZfaiNLuk7JDNbw1?=
 =?us-ascii?Q?wscuk464VMjv6pN3kE1Z1Ntg5lpdEyVG74v5tbWeZ6DfqyZ1igigApb7gv/G?=
 =?us-ascii?Q?BzvsPz2j7Lf0M4iXNZ0zjeXV3my+rI3Q3IciPRXtLkHFvPsPRqhy3/BJgwPa?=
 =?us-ascii?Q?9oZPYlBw/obNV00NU7aouMLVA0LI/bJf9uWRkHN2Mtm3uM3krh4+6ZR/5yvJ?=
 =?us-ascii?Q?toeAV0idjdb48C3kDltMWeE6R8Hf3OQv1OJpTIM8uJaFuUwRj4ZxKldxRByY?=
 =?us-ascii?Q?nRvaieCsHKBh/6b4k1fHJasYwjrlzybBQ73nFHnDFfGcK2g+CsWVBTJ+yzxb?=
 =?us-ascii?Q?qfkYg8g9Sa5J6hLh4auIfSFKeNhnjakeydvGTCPnQdtRDASmee8BweK17Q2m?=
 =?us-ascii?Q?ohiVSOUKs4YPt9rCtps9kpTImxN+ReL+il2Se0nLntAi0SOmBYH5e8NlGYL6?=
 =?us-ascii?Q?etFJbSeQEjB9vYr+b+klwIw3jwclHfaJUtj4tUZMRI+c7ohrJEmMB+/Q4yXu?=
 =?us-ascii?Q?JzHw6F8nY6r0qwurcZWs/Y613C6l5vlYqy3QRoaUy7a3nLGEmYjMWSJq41FY?=
 =?us-ascii?Q?U8Kc/wdub4A390POIq/Ie+TUNlr9Sk+NbRqzCvDmjQCOuPaAReSjPDixSuhj?=
 =?us-ascii?Q?flhHwiltnDuGrsMQiY3GNYcQrpO2CW6UgnOlCOWj0B8imoq5QMbCTj6eCW8z?=
 =?us-ascii?Q?svGM2r/B5q7Q1EF6nXJipE5OSC5C3Bz6gv/Sz60uFukGCPVEkxjR4/LYRGFa?=
 =?us-ascii?Q?xt3ZQQJUp3srqeWUHTS/02aoe8pCPniGpdCeHctO/4S7kU2e6rNJzzvKhPtP?=
 =?us-ascii?Q?oqH9tj/WqO64lrQiGR8ay+0QbhsbKD6ZHcbT9zDA86zWkMM5lClI/UDZ4+fD?=
 =?us-ascii?Q?lH+LHQBGhfftm7rM4fsMswcpqPa4BSf0gbfDBT51ZrVW6pRgcoWaat/ncnci?=
 =?us-ascii?Q?Kumaz398rhTCm5taJFx4Uq5CHXdXt1DrG6IhBUpaS8IcauMF4PeORJ5xVqF9?=
 =?us-ascii?Q?+oqqpfA93ZYjm9rQ3iJFnzi7ieyt8BtrjkImi8P1qUHp60byo2vbpDmyfV4c?=
 =?us-ascii?Q?KFGV3zQTJawV+fAnV/m1JOXaXHVCxEE2FEe8FM3BPizHk+1DkZusEW1lO6nL?=
 =?us-ascii?Q?7yGBpDA8ieIhHl3ngUfJR4mZmKSzJ51QGdW3ud/DXsbHHGn+fIget3nA0ncj?=
 =?us-ascii?Q?5QEFI0iwHJOhRzuIXrHX0kmEDEB8pTnV6UDD+b9eFO/4LO9t0N4e0C5Uq9a0?=
 =?us-ascii?Q?CP1lqJlGA99otDD8lcPPR8yxPRo6s0H2uQIVzrzz7aFInKi0KDnriWWQCj1W?=
 =?us-ascii?Q?MfxwBcnkO8u+TqWCSgCCCHaJeq1jNq5DcqvRHVeFRl3/q0pb7Td0jdzlVy91?=
 =?us-ascii?Q?Yn1AiM4PbYh4AQrNpTIsNf2L5Zstu9oXJvxTEqkA7oXm/BD31zI7gX/Zh4OG?=
 =?us-ascii?Q?JpSCmv4Rngw7Sp4quXnNnnXl+j688DY=3D?=
X-Exchange-RoutingPolicyChecked: TP/CtLqjT84jZGpZCb/DrueFvpIq9HPF3RkLrocSCwWbR4peFY7+7aVVHnr2x/WwBgjWKHpZZ1ytmONs7Rm3FR1MVTBDGwc5ZBHrZ+/aHXj4yxVO5mIetGEl4iminyKdNP2gn4SGsvtzF1S+Bnp2SvH4MzM9APT3stleMfqiv4qHO1WBmegs40v8t8Hg0dnbqy5CEFWZoZbFsKGwEmYQ3lOP4UL/qrx+F9rUPHHsv4IhVxetTX0HYR27OuW1gcnKFk1NQZys25qpT1AhwvAL3yrvC9PxfNk7tG3j9HP6wigrTUrFWHycrxEQxydsr3epyNIDGKynTujr3bC/Lpy9cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 206a486e-cf2f-4545-5823-08def2060cc9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:54:53.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50fQ1kr6psknQccaAOnjnAHyjsSMOzKiEoMUdztzhReS3I0GhHqtBF2bw5ERPKQrDhYWVYLwzfHfZrQC4KMu2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

On Tue, Aug 04, 2026 at 09:00:19AM +0100, Matthew Auld wrote:
> On 03/08/2026 21:08, Jia Yao wrote:
> > Move the UM queues into a dedicated UC BO (ads->um_queue_bo) and avoid
> > CPU memset operations on it, which eliminates the CPU as a potential
> > cacheline-polluting agent and helps maintain consistency between GAM
> > writes and GuC reads.
> > 
> > Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.12+
> > Signed-off-by: Jia Yao <jia.yao@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_guc.c           |  6 ++
> >   drivers/gpu/drm/xe/xe_guc_ads.c       | 89 +++++++++++++++++----------
> >   drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
> >   3 files changed, 68 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> > index 4286bd05c686..4f132bf8539d 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.c
> > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > @@ -732,6 +732,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
> >   	if (ret)
> >   		return ret;

Add a newline here.

> > +	if (guc->ads.um_queue_bo) {
> > +		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >   	return 0;
> >   }
> > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> > index f0ac00586d3a..ef8e9cc35c8c 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/fault-inject.h>
> >   #include <drm/drm_managed.h>
> > +#include <drm/drm_prime.h>
> >   #include <generated/xe_wa_oob.h>
> > @@ -64,10 +65,14 @@ ads_to_map(struct xe_guc_ads *ads)
> >   /*
> >    * The Additional Data Struct (ADS) has pointers for different buffers used by
> > - * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
> > - * all the extra buffers indirectly linked via the ADS struct's entries.
> > + * the GuC. One gem object (ads->bo) contains the ADS struct itself (guc_ads)
> > + * and most of the extra buffers linked via the ADS struct's entries.  The UM
> > + * fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE, ACCESS_COUNTER rings) are
> > + * kept in a separate BO (ads->um_queue_bo) so that the full memset of ads->bo
> > + * performed on every GT reset does not discard fault descriptors already
> > + * written into the rings by the GPU.
> >    *
> > - * Layout of the ADS blob allocated for the GuC:
> > + * Layout of the ADS blob (ads->bo):
> >    *
> >    *      +---------------------------------------+ <== base
> >    *      | guc_ads                               |
> > @@ -99,10 +104,6 @@ ads_to_map(struct xe_guc_ads *ads)
> >    *      +---------------------------------------+
> >    *      | padding                               |
> >    *      +---------------------------------------+ <== 4K aligned
> > - *      | UM queues                             |
> > - *      +---------------------------------------+
> > - *      | padding                               |
> > - *      +---------------------------------------+ <== 4K aligned
> >    *      | private data                          |
> >    *      +---------------------------------------+
> >    *      | padding                               |
> > @@ -156,16 +157,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
> >   	return PAGE_ALIGN(ads->capture_size);
> >   }
> > -static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
> > -{
> > -	struct xe_device *xe = ads_to_xe(ads);
> > -
> > -	if (!xe->info.has_usm)
> > -		return 0;
> > -
> > -	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
> > -}
> > -
> >   static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
> >   {
> >   	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
> > @@ -206,22 +197,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
> >   	return PAGE_ALIGN(offset);
> >   }
> > -static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
> > -{
> > -	u32 offset;
> > -
> > -	offset = guc_ads_capture_offset(ads) +
> > -		 guc_ads_capture_size(ads);
> > -
> > -	return PAGE_ALIGN(offset);
> > -}
> > -
> >   static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
> >   {
> >   	size_t offset;
> > -	offset = guc_ads_um_queues_offset(ads) +
> > -		guc_ads_um_queues_size(ads);
> > +	offset = guc_ads_capture_offset(ads) +
> > +		guc_ads_capture_size(ads);
> >   	return PAGE_ALIGN(offset);
> >   }
> > @@ -461,6 +442,44 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
> >   	ads->bo = bo;
> > +	if (xe->info.has_usm) {
> > +		/*
> > +		 * Allocate a separate BO for the HW fault ring (UM queues).
> > +		 *
> > +		 * Round the size up to the next power of two so that
> > +		 * (system memory, no IOMMU) the TTM pool issues a single
> > +		 * alloc_pages(order=N) call, maximising the chance of getting
> > +		 * a physically contiguous block.  GuC requires contiguous DPA.
> > +		 */
> > +		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
> > +						    GUC_UM_HW_QUEUE_MAX);
> > +
> > +		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
> > +						  XE_BO_FLAG_SYSTEM |
> > +						  XE_BO_FLAG_GGTT |
> > +						  XE_BO_FLAG_GGTT_INVALIDATE |
> > +						  XE_BO_FLAG_PINNED_NORESTORE);
> > +		if (IS_ERR(bo))
> > +			return PTR_ERR(bo);
> > +
> > +		/*
> > +		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
> > +		 * ring via base_dpa, which must be a contiguous DMA address
> > +		 * range.  Verify that the allocated pages are contiguous in
> > +		 * DMA address space.
> > +		 */
> > +		if (xe_bo_sg(bo) &&
> 
> 
> There is a comment from Sashiko that there might not be a valid tt for vram
> buffers, so perhaps just make this check !xe_bo_is_vram() instead?
> 
> > +		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads)) &&
> > +		    unlikely(drm_prime_get_contiguous_size(xe_bo_sg(bo)) <

Using drm_prime_* really is the wrong layering. Either this helper
should be some drm or sg generic or IMO we implement this helper
ourselves until we have a proper one in drm or sg generic.

e.g., for SG specific BOs, something like this should work.

xe_bo_sg_is_contigous(struct xe_bo *bo)
{
	struct xe_res_cursor cur;

	xe_assert(xe_bo_device(bo), xe_bo_sg(bo));
	xe_res_first_sg(xe_bo_sg(bo), 0, xe_bo_size(bo), &cur);

	return cur.size == xe_bo_size(bo);
}

Matt

> > +			     GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX)) {
> > +			drm_err(&xe->drm,
> > +				"UM fault queue memory is not contiguous in DMA address space; GAM requires contiguous DPA\n");
> > +			return -ENOMEM;
> > +		}
> > +
> > +		ads->um_queue_bo = bo;
> > +	}
> > +
> >   	return 0;
> >   }
> >   ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
> > @@ -893,7 +912,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
> >   static void guc_um_init_params(struct xe_guc_ads *ads)
> >   {
> > -	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
> > +	struct xe_bo *um_bo = ads->um_queue_bo;
> >   	struct xe_guc *guc = ads_to_guc(ads);
> >   	struct xe_device *xe = ads_to_xe(ads);
> >   	u64 base_dpa;
> > @@ -903,8 +922,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
> >   	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
> > -	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
> > -	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
> > +	if (um_bo) {
> > +		/* All USM platforms: UM queues in dedicated um_queue_bo */
> > +		base_ggtt = xe_bo_ggtt_addr(um_bo);
> > +		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
> > +	} else {
> > +		/* Platform does not support USM: no UM queues, nothing to do */
> > +		return;
> > +	}
> >   	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
> >   		/*
> > diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> > index 48a8e092023f..845c1fbd93a4 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
> > +++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> > @@ -16,6 +16,11 @@ struct xe_bo;
> >   struct xe_guc_ads {
> >   	/** @bo: Xe BO for GuC ads blob */
> >   	struct xe_bo *bo;
> > +	/**
> > +	 * @um_queue_bo: Dedicated BO for the HW fault ring (UM queues).
> > +	 * NULL if the platform does not support USM.
> > +	 */
> > +	struct xe_bo *um_queue_bo;
> >   	/** @golden_lrc_size: golden LRC size */
> >   	size_t golden_lrc_size;
> >   	/** @regset_size: size of register set passed to GuC for save/restore */
> 
