Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E4346A0B
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102280; cv=fail; b=XJuouOO5Ccg2xpI4jvVLWnsg7skmap725/8I5mcum//sl5vFc34BZRgKNAWneVo6UL6oUw7phZQC/hQ+j+NWoppUaye05jOr9qGRsHD49DC77m626bCFBC6kEHEBGNOidUAdfzazn/wS3F0LjqXWBa5HvALecE7YDmB21NPgYco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102280; c=relaxed/simple;
	bh=sTgQw1NtyanKH2JMjxpRpD+TBDbXi3tPiszANHhHT/g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dNi1tEUTuLuqFLSvv16KI93gWflye7iZXwkcCmG7Ut3QZTh/4JiDkB3Y3EY+7MsnL8lMoE2Z0dYfTKgzBx7N7q4/hOL0lzkG+7MCLhld/uZYs8hXv6LNybWTzKIV/F0fRx7e7bjvClr4SZTQKqq46rAfM9zBCW4Pds6auZ4aHks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgLqTK7D; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgLqTK7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787102279; x=1818638279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sTgQw1NtyanKH2JMjxpRpD+TBDbXi3tPiszANHhHT/g=;
  b=cgLqTK7DEqRwU2V5ej3t7ePime8qnV+BbX/dTb+4R1PBu8INXFttouvM
   QPhgnUt8M8WNuDHlWlOqN/1bL4BlPhkWdsLvTVFLOHPFg9DC2ZQqCy6Gy
   UE0G5tq5X83UjqAzdJgcXfrfL62ACieH6XunctJoAfiPC5V+RiCKxiIFx
   xsn5GJ+Yki5FiMJKxQF+iQCAwlUzuCdJM5X02NoMf39gadMcb9hW7baMS
   tcjtef1aZ7deA//4piBy+4UM7kDR1jB78lUY8KPe/qkyKbpf1ZqK2Dv45
   Q6LpLZJ6Hf+JGo2tSKt/ywsS6gy1DYRh2HNMUZgH4CkkEIbDAqjnRi7t+
   Q==;
X-CSE-ConnectionGUID: wltr6M4qQ52IUpIkSD0YxQ==
X-CSE-MsgGUID: fIKM3FS5TsaZfA/t30hQTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98967867"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98967867"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 18:17:58 -0700
X-CSE-ConnectionGUID: OSUp6eT8RxCgPse3HZ7WDw==
X-CSE-MsgGUID: SaOVaDJdS6GK4AredRONIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261178673"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 18:17:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 18:17:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 18:17:56 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 18:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzLtaDXg0INux1VG14l8HQZnStGs9cH5ZnnwwfpDGy+F6W3xfzKoARVMPij0hYtlsBuB2MtYYrZf5TGW8umY1nfVAOtBittBRkaeAMhQ6ZwAHIz32Eg1haoU+H89V8OIcndgt6kCeJ+chceSmxt9zsqmpt+3Sqn0fsHOxEweKQsJmr7XnBAUUaqetxN4XvU/vC8V1wAVPIN1cSmwtO8Ny3+MAQPtez9EezCc5xXbNluQ2ynQcGxpyR3BsN9LwFdbkQeF4jogaec13JYlYzUWEhtOhJP7LPd5s2g9ZQp2p7ZXyhvs9AbPMeREakEQbCMnuME/wQ1awyHzlD6b4QxzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1YDcGCCuYGErzf0+ubQfdsxuEOavCppZ5x0FkimelU=;
 b=BB7J3fg6PXINRZByAVFiTszWFHa615RhrGo3qr7+Ijp5ghPMhNFxQD6mxiWAoL+t0dq2254uthYTQ1wLBLj3q4NfNQTZibgPqBlWVB08WiKG8Omf3VcPDaj5nmsDBR3rqtl5heHNkJWcd1i7vT2MUH0ThYtfIZj18DTZvinNdv9lUDCscEGPJgR5aXky+5Pq8l8QJXWwbcWlmqM8gvv2QjEwQgix9ZsF6lCYDskKP7rHY2iojkfcfo2ft5pvX5xAx8TuunNq3UurNHSG7Mw25Bd+sOteYWsOFif+HJWQY1Z6CvKvLHR/CXRO/tTdXrorAjckDIFUtAOV5B+brAe6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB8685.namprd11.prod.outlook.com (2603:10b6:8:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 01:17:53 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 01:17:53 +0000
Date: Tue, 18 Aug 2026 18:17:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Varun Gupta <varun.gupta@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/guc: Skip CLEANUP message when GuC is stopped
Message-ID: <aoUEP2RP/4kLySh+@gsse-cloud1.jf.intel.com>
References: <20260818040733.135964-1-varun.gupta@intel.com>
 <aoUCPYIDeBVhLg5l@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoUCPYIDeBVhLg5l@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: c21d8532-6839-4e38-660d-08defd8fb171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: PmBEt+92ArvTVxo0o4cqyrYgcWIuWDtzQUdemk0WgSC70pLPySS3GvznLawY4udZnDQNCJk0KGJcUDOwMRbRWCWqHKvRJW4zQySgd6hTIdhjaTbRqhNc/W2l5UtZc2PLJRFHUiNWX/5pwIfZ8aHgUDG+O781tsmryn61rNOmCStIAIGT83+3u1xMp5At1+fl64AMoPheNRAQ64ffwjexclFmCqnJraukt+8N1fOuoLSt1lajD6biNQaSp+YiAbv8jBnXhid/rYTZJCoOpFX/ZPKfhHGsAf/JnSN27Lt+geh3gFQ+0FXXurMbu2jUaIUM+QsY0Udu5Ro93ecYCtbyYEEzkMcPlm6+gtPYRukS6IsebzzUKk/kx1dxGPZtis9ZjwugVY1QBmbdZLcR5GMHOazPRfoxtt5p46zwDYj1bAbU7IfmOOXOfMLeViHm2XfxHa0PtHkcgxIWndKUtPP4xQRJAtKYgy8WWPC2ahrogeSLGSf1qzNivq+ceObzdTVRzabCR/G3qSvqWom5kPsWusijSM86EPO6Y+2214hyVwFWw+QukUrGb3al+VHtAD06ysOr7G6B2J4nuxMGwvg55D+QJeKwv+sjywZ+LcxqrpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lIEL351huU97YztYQLPX82026968W+6QOfSPCVgd04DqPqAxQCterJ21qxWh?=
 =?us-ascii?Q?VsCdgn21YRfhFX4gwQO/6HJNBi9lZogsIa9GRAg5fDstcL5SSgUAuE/KUeQW?=
 =?us-ascii?Q?xLrdZxsFJEvxa0dOMlZfN8Fg0jNMT/hV8wLF197SWdC/0q4/SaKKGuCgUXf1?=
 =?us-ascii?Q?EqzviODcQD6FzDfMrW5LAgUsGI4PRYedQrWOT+d19+lcCnkVMgGtfwwmV2N7?=
 =?us-ascii?Q?PNbV4edL0ppFFISi1sxZKg6PfdQg8QS7QEEiMowfQAN1nLoCBMT5e37jJZS+?=
 =?us-ascii?Q?U1FlaZmVULGBd8zQs8+7fi0FsxkAHcuHAi3myAskqX/e8KnnKWKawGgLXGEW?=
 =?us-ascii?Q?7copmBdEGTJ5HdKVYuUPEWqMWAAcm+DpqXD1bbVsfVR4p/28+k7sKUYHx9fX?=
 =?us-ascii?Q?Yl6TnNbpP0uSzPK7nKt44QmHoDT7mBIMvTG51o7Rqu/I4+5bRw7NN8KvH1Pv?=
 =?us-ascii?Q?ENjZCTo/lyOYE3iBwHLdFZ0d8qNUVJp1sOyHE4RNb7/pT6nSqegh0nRgSuc6?=
 =?us-ascii?Q?powHi+n0V+Ht14PXXncJYt2oJF6lOrZ2xlzb4Af1dlNKmOHR+ixYzriRXzn2?=
 =?us-ascii?Q?WttAOdsDTBRszySwf8pBcjYQgA0uMEIMLN77jmT2jkcNoBzGAeKRmPkdfu6T?=
 =?us-ascii?Q?ZMzhYc6736yl3U/NN1SF7pzxk2BT+VkTTgw8e+ZHsKK738FW2AGAlzwRWF4X?=
 =?us-ascii?Q?hedipvr+WXPTNFPVq5Z0ux6e98JqNvdqlDVOY8x3lHY/EcEblzuxazd/RLKS?=
 =?us-ascii?Q?hKbPRuYAYsgjoSZWvTDQJUGOjQ8zDcnOrNiEUu/mC+NeUWSAvD/ZadOqkD0N?=
 =?us-ascii?Q?0A6svgIUREm4QPKQ6y/BMxQMes5Uk4YdGEDCz3+OpztRD0eh9yT77NuKEKC8?=
 =?us-ascii?Q?9mw8Nrr711xHtv4Sptg/7lcxE/iVQ02HghUarDAoLhMgICs8F9DxdjihF+N9?=
 =?us-ascii?Q?UpnxZaOJFkkvTgayeAN7oCrKBKVG5LD+p/PRl/t+PJIjtj0eiG/xPYirvLni?=
 =?us-ascii?Q?HH4wPfAS8fuAbQ2B+C7ok11h7z/Prp1ONEP1+xS9BXVVqaQ0c4K8KpOxTMTK?=
 =?us-ascii?Q?icB1FdxAXK4+mAOsI7ph1jSEJ3EeAh/lCXoNtk4ZM2KPG/SfbX5nBSG4hH1z?=
 =?us-ascii?Q?sXvkiffSolCmOaKmE9s+MWzrY28RnS68l1KsE0wavdhqRdGTbvvslddKLcQE?=
 =?us-ascii?Q?rEzCbwO1XClQlFtAfJB6VQjz5WHynHZvYcSK7e/2n0c1I4AEO2oGarCwpgOH?=
 =?us-ascii?Q?UGZCtiaIablsqzDR5s/JUkxedHkqNpHTNuQxXTGoM8DAghMEyTt+0YJED26u?=
 =?us-ascii?Q?Cx6Q3SEjAyHSBk/mjBBS+BmrFqTQj6hKEGPBpCtFboPyykH/Jwv1SoP6PCv1?=
 =?us-ascii?Q?IAFBDO7HpwHNnahnvs6tUuOw1EhJ4uJ73zHCzvtSSIOEqXGfuCMjItMAu212?=
 =?us-ascii?Q?wFeC8raXzWgk3rnXxjNOs47qNp8svCHfISi157aJsWiAjKF1ISJ9UNLrFNAJ?=
 =?us-ascii?Q?1FAE47LuREHwSXvpGuAtiSNEuJN2dDBk84/aOF2WNQazBcdFVzT+z/28Sw2D?=
 =?us-ascii?Q?tQ6zge/BGc3ZQ+x8MoLEkVgloBiQ90MotzhVDVMouFENDXHPZpfWZ/l4mRj2?=
 =?us-ascii?Q?eK4GpS8FkbVBwtjFUvsJaRY8XIcHe4MKyz+CrTTk2HP/H8N7nKfFr8+/92ki?=
 =?us-ascii?Q?/rq87jpAjn2COGXY8fUz52vhlNV1IiQraLh2y+TwrEDtuF7+V2vehNGXlj2a?=
 =?us-ascii?Q?KQSXb5JZAD1fa5c6UR0Z3q/Oti9ti4I=3D?=
X-Exchange-RoutingPolicyChecked: pH1IHYKfq20KZiaefJ7kkg8QXOF3V+FcQcDm37M7ggamHD7PjzBuxhz1WRkmRtrtCjtTPNmnILOyDgRxuLmkYLsoBznMtkaFOdsY2GhO3bRV10Try4MiaOUWkNTAzm1iEBKwEBxeqxpaHCGFilLJyKWr+wfiPnYTTLq8jBDH3sXbZQID+HfQI0m8EN0Cu+LEjYK7cwNvNbEgbRZLLNXPCdYo5OcZb1QZ7tRSKh5uLVqk1P0zhu/McqUO0eIIRyg1fQjZNVbU66sW6v0TGWoeMmnlM6EdvSDWYxo4jVV83AYYqempzlVQfTdMI06vNGMvwnUobzbgYSmbZfvHRKJJWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c21d8532-6839-4e38-660d-08defd8fb171
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 01:17:53.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPHZayLGN2RE5lQWMo89lBqr7RL1H94TuWxo879VT7lTyj58oRJrDmr6xj7eFCYXkYKxseUedfeb+E4Ej0QUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8685
X-OriginatorOrg: intel.com

On Tue, Aug 18, 2026 at 06:09:17PM -0700, Matthew Brost wrote:
> On Tue, Aug 18, 2026 at 09:37:33AM +0530, Varun Gupta wrote:
> > Attempting to enqueue a CLEANUP message while the GuC is stopped
> 
> I think we going in the opposit direction - always send a cleanup
> message:
> 
> https://patchwork.freedesktop.org/series/171989/
> 
> > (during a device reset or suspend) triggers a missing outer runtime
> > PM protection warning in xe_pm_runtime_get_noresume().
> > 
> 
> Hmm, do you have stack trace? You shouldn't be possible to get to
> CLEANUP code without a PM reference.
> 
> Matt
> 
> > Since the GuC cannot service Command Transport (CT) requests while
> > stopped, skip the message and route directly to local teardown.
> > 
> > Fixes: d930c19fdff3 ("drm/xe: Build PM into GuC CT layer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_guc_submit.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index 9036f89dff7d..24f35b0179e1 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -2180,12 +2180,14 @@ static bool guc_exec_queue_try_add_msg(struct xe_exec_queue *q,
> >  #define STATIC_MSG_CGP_SYNC	3
> >  static void guc_exec_queue_destroy(struct xe_exec_queue *q)
> >  {
> > +	struct xe_guc *guc = exec_queue_to_guc(q);
> >  	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_CLEANUP;
> >  
> > -	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q))
> > +	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q) &&
> > +	    !xe_guc_read_stopped(guc))

This would break VF migration too as we do global stop / starts while
the GuC is still holding a ref to the exec queue and do not both away
the GuC state.

Matt

> >  		guc_exec_queue_add_msg(q, msg, CLEANUP);
> >  	else
> > -		__guc_exec_queue_destroy(exec_queue_to_guc(q), q);
> > +		__guc_exec_queue_destroy(guc, q);
> >  }
> >  
> >  static int guc_exec_queue_set_priority(struct xe_exec_queue *q,
> > -- 
> > 2.43.0
> > 
