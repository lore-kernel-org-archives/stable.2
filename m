Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023C2D9792
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 01:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101764; cv=fail; b=BLH4Dfft9QXIwj1ypOO6yoTOLRD1oTPuKSYGBYzJHP96b1kUA5rS2Ow+aZQzOBO2xKGPL7jfVWg78Ef2+Xmp2hgWHbP1pMIBmskfgKmvbQ9ev3U75BugzZbczabUxH7MMl7sxfLSj0/8W5zApKswukmRl6ot1PlmIGCr7DCWNfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101764; c=relaxed/simple;
	bh=2zS004W3OSeMztOMs6JZrJZhjUDO4quvLex3sSnWAz8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hfWIWVMTmeHTPSRCVuwFcj9AXYcewCOVRgOjgBt2fIDefGz7zBwsloit2Tc75h3e7wHjrjRrt9hpW2ULDLEsZ7VtBkLN+fC1HjMOGct7V1mcb4tfaAaQ3rCCx0MCX609S10FVDLKyiSRRMI0isdTUTgM8uSMuK3A+5TpNzTtSik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKHqpGNk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKHqpGNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787101763; x=1818637763;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2zS004W3OSeMztOMs6JZrJZhjUDO4quvLex3sSnWAz8=;
  b=ZKHqpGNkfg5wISnPSQmvortL02vCmYcG2E8Z99fPPQhMLITbzbpBGdqb
   Gpa2+8+8HOEIqIUZVHji3MD51jQhrp93DhWEW7S2aCbZa78ZyWLD+JaIg
   QkW7ooDJWvfXYgRq4CWRmth2JXuzWJJJXgo+JItVtS0VaqxSyEDrrQPt/
   pgRGOG617qLSjar3MwVQrsTBY8Psv3JcHE5bXWK7pPSA9L+57xzHV12YI
   MjBH17OtD/w493vgOJIw0PTbAnu5LD0tAjBI+SyFYV5EtV5HOYGqh8AaM
   l7xyzTZ+mLF3XQsI/0N0iBNGDzHA2olRgeV6T93C3Ej5EUJNLFif01Cbt
   w==;
X-CSE-ConnectionGUID: m6JSOuyuQ4eBwWJwZt8uRA==
X-CSE-MsgGUID: +NTqdyCoQQSKqgcsXif1+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91287564"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91287564"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 18:09:22 -0700
X-CSE-ConnectionGUID: RfLR2C/mSU6HfrtJBIUicQ==
X-CSE-MsgGUID: B8UCfzArThquNXRSWEks2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="269225956"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 18:09:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 18:09:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 18:09:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 18:09:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi01kACy/dUQeGy+NxkjI00e4tXDQB3X/m3NISKGCeRIlmfdtRWgBOBe87Lj2ptJ8HoNhc7ZL9U83T37cxYC5m9qeCfQGl79yPqrfmzOcb263Xx8UAI95bnVrPmt+fqTChlewZM/PNBgjgH1Kq9K3AT9pxqck2INs4uNlMkeSQyvXbrRloTm6VhhUDgbecmeIVyLb1dpAbFePYtU8YNU0TVE+8iSXFdlq+1B24GqQYsayC96sCWlXebLNpBn6UPDFE/4UnKJ9vh5wS11VBiRV9Ak6gcqbBhKkfI+DIUYxStjaJZcAo8fR3kzhXXJwhd0aIen2Pq3c/MSXwTPfVkGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URuDpGGtmluhdePrKaxprjUNqWH6l8LcxsHAO49DWhI=;
 b=UF6UAKtd7B850yiMreZgTEhSeBlNfpl54nXsaDfoSkvTvsjSv5w751jokmzhs8rFMHxrR24+raWwqAhS6/IKaU7YJ0/AmDGqwNInIVS4ra8N7dVh2DjduQKWY/J1PwcRDVRjEvfSnmHot4dXhm8n71MNQb6abmetm+SyG+GzNGve/3xV+3Pb9cdof0DOgGUxtigIeeR8Pg/7DbgHnSEMJE/9haGTqdKw2QCUfE98kWJkO8IwzzovT8vuX9oiCXzXehLYR/rfwn8xkw5zfHsddv60xWSOm/tgk/KK8XxqkrLUb9RMZmNLYpmtu5Mft6iiz+fsAnBKZPqn/hHJkLZOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB8685.namprd11.prod.outlook.com (2603:10b6:8:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 01:09:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 01:09:19 +0000
Date: Tue, 18 Aug 2026 18:09:17 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Varun Gupta <varun.gupta@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/guc: Skip CLEANUP message when GuC is stopped
Message-ID: <aoUCPYIDeBVhLg5l@gsse-cloud1.jf.intel.com>
References: <20260818040733.135964-1-varun.gupta@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260818040733.135964-1-varun.gupta@intel.com>
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: df4771f1-d392-4a45-2e0c-08defd8e7eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: mokiXmorLpspqzhmdR6m2YRdcwIujR6rK/oIodmVvmvMe3p6mOo5SzW1QC0HWnKaKD0vN1bjNaUmOj+HqLHrfx1tFZMpgauF0GfuzDmq5m8OTv3ExqPchQ3xOQ9VStE+ktDloFHWPPF733MgErhSfXQaUydFCpsWih0Pa/T3VfY78LvdFHm30Wvt5Mv2/xa3uNWzRPwYp3Y13WnVpUSev37bTq0UXbcF4YvdE2JqKBdv+NRf+Q3Ky+SKJnh9UihEwqKlM59pikeSnvLEtgae4FAOFxKlNhZuy/Wdh3XpP0K4hPsOqS7/dmAIQoSeDSi8r0w9K6QqXZskFB4UoXTgGFJnkrE5cQ1cl4RF03ImtQTDm8maCUmLuReayqyvHg8KJg8FNhjI8nXFcSun1ixLUbgW8a7sWGz4k82b0L9ltaijJRXM+M+3SJYcJlfBfwUZ2SBrfBu96SLvp16S7aCa/ao6NYhnMYoqzHSjLOS6v29tMUAmse8/8uhfNAbBScvlikEerVbigxzHaaxmZhVH5Mn/ARQ7AvKKEzBTr/Mfob38A7PPQTCaTs3AnflGLV4sV1tVIkPwy80zufB4YW0VUGljw7Sr2B8yoTtnHOzQYa5LoEqgjy3Q53HWuNQ76Vv1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JmXDOdqO01oCoh8AYyAYEpRBJ9V8H1TzIrK4Gjhpy/AG+VqApwYUZAD98vlR?=
 =?us-ascii?Q?bNjg19T9szKPhYLYVUM99jQOTGmfcHcjUeD/63IysHEfsWwgIwhVlvIejXcP?=
 =?us-ascii?Q?s8rV/gJBcAYaQeCDTAC7qT0iHM6F6QJIV6DkPDq/35ai2BKWXVnYvWsEOmuR?=
 =?us-ascii?Q?BK8dA8QrgmguLjX8tpbPkZcT+pROKWMfWDpa9oyrbHdNzFUspa8TudqOH83g?=
 =?us-ascii?Q?kAeZJzgefWCnoUrwoQMuXTa7hJRbifFGIlqKV0/RfsLk2HmsrV1KQ78EO8F7?=
 =?us-ascii?Q?kah3ZL0Y5LO1A2LKIxSd5l8CCFbzVrdl/pFerdpsC208GYh9kI6pqIvGnS1h?=
 =?us-ascii?Q?jueWO/IjPrV00z0c7m6q1VXQUvlucgwVmeCIYMPS8+2rQlbxgDI/r5g6d0LF?=
 =?us-ascii?Q?1zkvkw0xzoqCzzYsYstLanOWXIyeHdBWMjn/jViLSRyjrfV+AXLkyoWSZVJr?=
 =?us-ascii?Q?Yq0tMreHzyrseTcQ/JjQWVgBQVkp9MgVvTbi9SIBHqb/wU/27P7FrfixkTJ7?=
 =?us-ascii?Q?6PHYrHo4ePfrHZfrCE+r3KxD+EcJfD1i8IBS8pRDSU/zPY5o7vHtWM/jkHCo?=
 =?us-ascii?Q?nDs6q9ENej/mcSwk6RPrihG1uLk9/B4zJ9mRQqwtJcskDm1lv+IPIU8h5Mob?=
 =?us-ascii?Q?6d7dOVjQAq8hIlbtymR7VKe59mgtw/0Ntca5/DPZrYAALe+JcZwUKQ2JPGIP?=
 =?us-ascii?Q?koKyJLqWWQAUsFiifHEJkGQWpewbSVlw7jwtpp5RuH3YLrRyRGfLNnZXaFno?=
 =?us-ascii?Q?zcii7xOS2/Jjib92sq0+qFzrfo2bMnN9k7hv3ofe3GPdANMrJHLKMClNMQjw?=
 =?us-ascii?Q?pA13a3tOBfrRY0rJF26nb5zpQQYGRDSyb8Bisd4gbD/qEQusY0f7U7OEHuc9?=
 =?us-ascii?Q?KnzYLPafAB+kZ9x2eWIJucl9VsqZOervO3wEIcB2mEsEyCSSMpUbreyxayQV?=
 =?us-ascii?Q?Kf/wBjRUXza3Pwt1MQw++lPbOttuMNG0pZdlN6xUv0eD1LtDYTr9x8+wLdEm?=
 =?us-ascii?Q?uesNLH3X22ay64sMUn6OffQtg574XnAqOMZrY8nSVBoDXGfa7aHSVMHpPgKh?=
 =?us-ascii?Q?rxz35U6qdMJMQtSZ8CLxRGlGOPZqCupHvzpbhNy4Xkjz+i4fXGikzso+wboe?=
 =?us-ascii?Q?JIbRLFyUbQmB8+/SyMf43OWRKThKb/Oa0aYyiM5Mdd3r8JscgErLnPfw9rme?=
 =?us-ascii?Q?Mm06UIA4yKIneQRmjvz444oUgm9lYGX8HCq1Wd7kG149S6O+thTZ2QD0HlTC?=
 =?us-ascii?Q?huW5NfeBckuvqIoyvM557BySa9BLO+GhDYtGHw8Ll1U7g6dXB+gcrXWmeJRj?=
 =?us-ascii?Q?TW75Cwfmvdb66VnRISO80c3N7thq5QiZTxcAo0mbJ4bZO/shFfST48jAbU1R?=
 =?us-ascii?Q?+ECI0haqzAEwVJXmxD32S95XX50nUTBQk8xfMZAajvm3ohNwY8aBREJ9IY2v?=
 =?us-ascii?Q?w70NHgaBWL44DlLzNz9FOYlVw/o1Tottd+hCTMwiZPyNu5YT2BjWYmfJNtKi?=
 =?us-ascii?Q?rQG++rzdhvjQANFZMX4OL01JXh3A8m2/f3p2ja/kQILRsAbB3LZfKotbiOny?=
 =?us-ascii?Q?fVmb5kTjxP6/sM+91DfJkmoEJZ8QYPBTD7pdhGwXbJ3JJ+urFg1wZCceA4Kf?=
 =?us-ascii?Q?tnLheykZ9MQEYWSm/99Iw48Tzk0ejjAnIcaEQhv6dvuFZCXOF/3R+/YgdUns?=
 =?us-ascii?Q?/Mq3A6QJ6c/WAOtSeFLpBmU4bl2PBwFxcwqhV91OTsCYjfAd/v6PZIwDOoqc?=
 =?us-ascii?Q?Opns9CSREVmFsV0erCP2Ha1PPDdZI6s=3D?=
X-Exchange-RoutingPolicyChecked: R/MB/oZuF2kBNWUFjECrKjJkIaA4KCKOqQ0eDRPJz3w0KQ25AUFqA10HekFxC5a9oNGO/tXCp+JBj0DUU1K51Mfuboc+QkRX/jyD8jF4jLhEct3y9Xc7Y8wQhs0pdEaybzp4ifuYVNnW56fSutCkLT17chzy4P7kgPcleNQXcxkKd1lxrJ4m2NstCSfZRFMVuDXS2iX6jEfl+f57i8trs1KoT0htzeMjNN1T/zKZvWHmKU57uaLh7p3UmRp77FWjJBCUlB52Qz/K46IzdZ/jjLay5bhMti7w0Sh+xdRVLRI41aGNcxIkLHEinbmsvsXpVfVd9Yb5OjZQdtNmSr3GYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: df4771f1-d392-4a45-2e0c-08defd8e7eee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 01:09:19.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXYMwR38bu1fWt19BNYokFjxKEoQ7YXy1c1Q1Mk1XfCNF1vS9g0lerWRrD7gRLEEjXb/vt6Bl+ljtWDkUouwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8685
X-OriginatorOrg: intel.com

On Tue, Aug 18, 2026 at 09:37:33AM +0530, Varun Gupta wrote:
> Attempting to enqueue a CLEANUP message while the GuC is stopped

I think we going in the opposit direction - always send a cleanup
message:

https://patchwork.freedesktop.org/series/171989/

> (during a device reset or suspend) triggers a missing outer runtime
> PM protection warning in xe_pm_runtime_get_noresume().
> 

Hmm, do you have stack trace? You shouldn't be possible to get to
CLEANUP code without a PM reference.

Matt

> Since the GuC cannot service Command Transport (CT) requests while
> stopped, skip the message and route directly to local teardown.
> 
> Fixes: d930c19fdff3 ("drm/xe: Build PM into GuC CT layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 9036f89dff7d..24f35b0179e1 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -2180,12 +2180,14 @@ static bool guc_exec_queue_try_add_msg(struct xe_exec_queue *q,
>  #define STATIC_MSG_CGP_SYNC	3
>  static void guc_exec_queue_destroy(struct xe_exec_queue *q)
>  {
> +	struct xe_guc *guc = exec_queue_to_guc(q);
>  	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_CLEANUP;
>  
> -	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q))
> +	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q) &&
> +	    !xe_guc_read_stopped(guc))
>  		guc_exec_queue_add_msg(q, msg, CLEANUP);
>  	else
> -		__guc_exec_queue_destroy(exec_queue_to_guc(q), q);
> +		__guc_exec_queue_destroy(guc, q);
>  }
>  
>  static int guc_exec_queue_set_priority(struct xe_exec_queue *q,
> -- 
> 2.43.0
> 
