Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15646EF94
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038676; cv=fail; b=D5GUsnAjk4kr2ajQ+e7WMfZ4+wmgP4NGjx/zhhAfvpx7ZmNc/Ztw+hXXeTp9Ay55IgkeBl7mFlQpjuMCDRbsY0IEQSpfRFj7c0Y3fcuMHxiN26PbvYTL74WbcS8WGynCzkzuMAqKSBDF2q/K1C/ED7YoiziMhWS6Etg9MksnEjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038676; c=relaxed/simple;
	bh=Nkn3j/hb/DE7+E3NaeDzEuJGsgAV7LYi4vglH2K88vU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rqt3mkqDNEVMcn+Ib25+QWbcgq8eLOtcLEVKmpgCGUaTZTvFvctGCWrryeqn1OIgaZfOKQm/M8ZTLbjf0KM5b80IVxPlEq41s2Qkl/hLP1nzuZkwFLLSlMjNKLsCL6Q8YUbG0z2BqZ/dh9F9cvsPeQ1OoNZ0nK9+qQLShjxWkiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayUr516i; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayUr516i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789038675; x=1820574675;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Nkn3j/hb/DE7+E3NaeDzEuJGsgAV7LYi4vglH2K88vU=;
  b=ayUr516i/tsFFaiCS91Q2K8ly2xp/WuPA+/iQF4KTHoC7N90S044PHu6
   KDL7VaW1CzOX+MFz83xm2ZnB6oaG++phBwzRW4CtRMvYuDIT6jCmwEZjG
   Ah9Etb25akEUPoSs4kJlBYdg6y7mSjdg90foz7ftQGZQ3Fs0L58j59290
   3MdK56cTDEDlGDmc0qbuFnWI1NY0nLA0hBK4V9T1mIR8uknOATdpOyqH9
   R3+zb9zbrkglAmLfj+ygPsiBxe1U7BPecjDfsJKEfHNwzACAQ0n1Jees8
   QRcoYYN/omS7c88UGhP/Kni6Cz73aGkilY4F3ArZ3mq4wcZ3XfuU4e0Tt
   w==;
X-CSE-ConnectionGUID: zYT86lxGTwiq6GRWwqfQeA==
X-CSE-MsgGUID: NzDwTzFKTHCSwQ6kxb/Svg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112257585"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="112257585"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 04:11:14 -0700
X-CSE-ConnectionGUID: yivW486YQLy3V2HinK8mCg==
X-CSE-MsgGUID: b/ajcXBrTyqWjmydy0amJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="272106508"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 04:11:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 04:11:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 04:11:13 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 04:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg2yxZAj65fnWBuKaTlhjebj3t+lwtbMQyV1GwBm7zwxFD3kp3ksXUTcAiTH8hAbusSfK798it3Ou/BtsgeRQ6a1X1kHfxw2ermA59DQ9XblvspA0q0XR8dhr9Y+mcgNHz/HJUBhkIE1+bc/I27ptvXd+jm7LJgZOD18iWVqvmD4U5rA39n2aWoFG4e63n1arlXgBnmDMxOAAhRn0IL6oDgJas/IQgEdNE10K7pcgVp1rFZU5u+WreqRcyowX5BoJ00P0DFgf6I5hB8ACnnbAxn9NRiBwOjxtA8Z9UuP0Bu+Mm+E6HnbF/ZWcTBjf03gnP35G5wxWJ5PeK3R8iIpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7BYGtIRQpkGR+0x4g/v3TGT+5ZTuyqBfdyD/fp6s/0=;
 b=ftl5vx0KhBqeNMpkQqLT5EmKZu3qTmS6SjZlXjbmafyLc0EXDb4PSF2tIWb/93xc87wvZLpjbfRkeB9Y9umNei3FzuFeNwJoJ6BHGcSxlPEBnzTRE4nIzk1SMjBktmSMgliJa4P8s8RMBM+wv4UjJel5xcO5hrgMTvlkiHubHx2Ou7cYcC3pvAr+WdF7jyFipTwDcN6Wzbdy/cCNI8E/IZHRgAJ2ZyBAlaS+981/Td8Dmg2UbAzs5KjlSs1Mzo5ndXr6CvjD7No3ktR6zkyM3jecEc3FRDBKc7G+LYmtD0EvKwPPEBEzPauKHhkMat2WMFU3eps58arOp3eXd9NVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 11:11:11 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 11:11:11 +0000
Date: Thu, 10 Sep 2026 14:11:05 +0300
From: Imre Deak <imre.deak@intel.com>
To: Luca Coelho <luca@coelho.fi>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/i915/dp_mst: Fix configuring TUs for a
 disconnected stream
Message-ID: <aqKQSYPEonBCauQc@ideak-desk.lan>
Reply-To: <imre.deak@intel.com>
References: <20260907174413.741851-1-imre.deak@intel.com>
 <20260907174413.741851-2-imre.deak@intel.com>
 <676822730026eb7eed7513dbc8f1461f24c6a1a7.camel@coelho.fi>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <676822730026eb7eed7513dbc8f1461f24c6a1a7.camel@coelho.fi>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GV3PEPF0001DC13.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::27a) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|PH0PR11MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3140cfce-cd34-42d7-0e09-08df0f2c38ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /5gY4MpiBhuSBhvb6Bz/MvCAvZgD2NlX4tFvWr6NUlLy1N+cwpcSZf9oLpzwBST2DSzlAV2BgjlYGhxW4mVjMStUVGCI458gNn3wjQFiGGFnxmPKyZbk6I0DPdQxhwlnKW2ltdF+J5KscZgD0ytJ929pbf+PT2Idg+x4d7W6y1K45F4d6C7NkWUR1F8L85RWs99cbBr11pzf1sY0yjV+Rxk9WQRL6+zYkeVpwzhgPHWp1Feubf3ti8BnhlZRnaURU8+ZVzrw7+JPWmCU0tHOkDjHsEQ9PcTLZF7EBRrGRN2w8HTthF9kjs5We83LuPcFhEM7DVD6sXBv851QQjkslOd9CxF3GiQG77+flO6noo3xgNIPoiahgmpysERah29Ou3JocOdPiv24kQlL0IeytTUaXHoHWZtKckEyRhqVPw9Ay4g1hn3ZLtr+nAmcJruOYqiuBsqCUN/ookjxyU4X0iIQoN+yspSQXN6RiXFxxLyA6p5MgdZv4Mp9CTPQ0GNRPba3pZCoWjHRri3417U14bYQi6T0kKTupV/3xadFAyFR4Pwq23BVD0h5iD4eIFDmpwB0ylKvW173cfCsFRDvf+UzoovsUByaTlyLoZK2d0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AX92Ggr0wA1DtVvR3+FTZkNRNfByuQ/7MVoaRY74YMqdREtB8kfIoEA7eW0w?=
 =?us-ascii?Q?SwXieTms9vgkb78fMlugNcOJ9KFFsSa3P7cSWtDdu7AOgYqFbIAmNiQjuQ04?=
 =?us-ascii?Q?ECBxiMUf+HAzBNtAqBF8ru2wr98nxUF8BX7dLdbQBIyhXMLqXA27kOJPoRdk?=
 =?us-ascii?Q?KEZjGNyvH1TsPsb1/DLqdswvcm2vo4XYM7oNTwyH343J4Brq48zoySCDdWIz?=
 =?us-ascii?Q?Ko348RzH8dMD+pxX+kLJPv1atOVhwGxFWgs6R49u123U/RQP3GhCo8GM2wZy?=
 =?us-ascii?Q?jq2N3YsgBeVnM9kzIQvIKUOa6R4HjMnkrwJ9c7b55fR6RjEO6Je+src7yvBR?=
 =?us-ascii?Q?hwBsQK+iOlHwBynbYDsGkwS2W721x8VfZZ9eigmmoa4z9KZKAjKqOpkg/3kZ?=
 =?us-ascii?Q?YbB9Jg+aLXz0eoQUKgI5hJSDQJeheG+YzjpXP7/+QFpCgCcVgDId5DepB77q?=
 =?us-ascii?Q?c8XEZVn+5YBOHwq/KOA5joy4tgQwr9mpiabfRCErDY25PCWAV+I9tkpFHfGL?=
 =?us-ascii?Q?QqMWqEakH67Dj4uTtQYew+1QdOuiZCU8vvmcuWt9NESXWDv3NqFfA44U5Iw1?=
 =?us-ascii?Q?KJ2qBBYRHwDdmrl2aCL/ohITqZYPnY2hj8J1S/eFyB/O4+NRBynknThNLD+L?=
 =?us-ascii?Q?iHS0ABmu4WGK/JOVrr1cOy0ZIr1EidJeJnK4KNlUhLRbhkpgnhuS3B/+mZsC?=
 =?us-ascii?Q?8dWcnBGNeVjfYDHNHwyx5Sjj9yrxoMcIbk50InGusZxyQMmKLN0+q4oRcDds?=
 =?us-ascii?Q?CdCkaSaq/a86ZLKSaDlAUE9/1xqyDmgfyILAGr1MeloqH/KaQSaU1PglQqUQ?=
 =?us-ascii?Q?duSGwrZelXHf/YkReSJXbK9EeoBCcxUoFi3LuJ0P2DPfYzQRTq/zFMBldRwD?=
 =?us-ascii?Q?ccMatrrUcIr2shfw0Dx875Xxgm06Idk+W/VbC+2zYceTz04qIsuPC9ezTtwk?=
 =?us-ascii?Q?fnzPf6SQA8Y9+TxBAivzZqLBBAI07fx38ekXtvQbB7j2H81uFCBWylcKwy0z?=
 =?us-ascii?Q?QDHVOfPLYf+LpTlx+8lZvVq5Tpe1jsGpnlL2BGzhKMCrkBphR1Vjt50995pT?=
 =?us-ascii?Q?8SnWbukfnKmjppLrQD2kayQqAVaeHA1jdjN2BR+JIeas6zMm9x/bkK6M1/FM?=
 =?us-ascii?Q?bDTXsP6mham4pkA/xkCapZuXkcDjDg+gf1hGiwqy9/tG0Sd+vk8PrwzhBI5+?=
 =?us-ascii?Q?26QOothzDlKQ5CRp+RzUNV6Tf5OC6Fx0bXBRCZ8NsrfHAiq3HdKJny6VdEle?=
 =?us-ascii?Q?PkGvuALW3iIkKuZ+hCPjWwP9YUy2WVPxH5KnYb0JgieUmFn9h6pRzjCCyYgR?=
 =?us-ascii?Q?be48TuA6E4anxJL5jJb8dvQ9bkBEe1k5s2aDundLLKbNpvApvHRi7eqU2/q+?=
 =?us-ascii?Q?dKOxH2FcWIRpZzOqBhnh2HwM7ItFp2da7NVm1n2Bc7EmKSCfXenrhi3QkcJK?=
 =?us-ascii?Q?sa21srf3r49QkJ2j7Zji/t+zqKLA2docQTyQ4B93xOwyh4nY0WoxciZghDSk?=
 =?us-ascii?Q?9YtFWtds7mTeShGyVNphgjtxQfH8+WlMWKWy7oRiyuJFD98xk0pwQHTV8rG1?=
 =?us-ascii?Q?ZcUTbli7vu/afH6XrX3V7Y8z4WtGJF9KtlKiApm1fOo4YMg3HcKFoUH5+2mH?=
 =?us-ascii?Q?AyTcezwGFzc6i/3BvkW3lI9oEOInU6FaulvrzS5j0F+vTWaE9M9LO4A8Efco?=
 =?us-ascii?Q?3X4M/ZzhQ4l5rjfxral7bAy7q7DLzS1sPci2CsSdt6HRV1d4B83heVsCIT2o?=
 =?us-ascii?Q?DBYGpcyRhg=3D=3D?=
X-Exchange-RoutingPolicyChecked: b7R/b9qFKpxbMPHhXpYttbPUsBr4WvxCktGfz4ryqaO31lI0QD5uwQqXOjqbkZWlpS/r17vRkBFhEGqEpQNd1UkBBvHJB98FUTGTgaF0BD8BudmXNz91Qzb01EvV+QHSfiD9B2axn25O6XzGCa0wgIlzmFQehkeM55kKN0FFKCd4cieFE18HV76sWkc6UyJntH95FjMR5tgPFu0xTA5PirtIzdHIeyI38VlDc/gL7Fw56p41tXqvp16AhJvr6suqNFLdntrFSw9cSZoldUhJZKicREGNYJHSdLn1MjvQTqVzlVJmaOcjTjmd4UQeXJpdNQUqUNNsqu0r+DPVLEntBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3140cfce-cd34-42d7-0e09-08df0f2c38ac
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 11:11:11.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QfWhokrjzAVyFydMNCxXDwX5MMEv4xCB4+NDpz9HEo8BTzaP3Usv4B0qj5Bl12K9r8BU70+IJ4Ja5bQYhRcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
X-OriginatorOrg: intel.com

On Thu, Sep 10, 2026 at 12:50:16PM +0300, Luca Coelho wrote:
> On Mon, 2026-09-07 at 20:44 +0300, Imre Deak wrote:
> > During an atomic commit after all the MST stream CRTC state is computed
> > the driver ensures that the sum of TUs of all the streams on a given MST
> > topology link is within limits (63 for 8b10 and 64 for 128b132b). For a
> > disconnected stream the DRM MST core's BW verification doesn't ensure
> > this, because the topology state it uses for this is destroyed as soon
> > as the stream (i.e. MST connector/port) is disconnected. The driver
> > should keep the link state valid even for such disconnected streams, as
> > userspace may disable them one-by-one only in a deferred way. Ensure the
> > link's sum of TUs stays within limits in this case by simply reusing the
> > maximum link BPP limit from the stream's (i.e. CRTC's) old state.
> > 
> > The disconnection can happen either via the whole topology getting
> > disconnected or via only the given stream's port getting disconnected.
> > Check for both of these conditions separately, as a connector gets
> > unregistered after a link disconnect event only in a deferred way.
> > 
> > Cc: stable@vger.kernel.org # v6.10+
> > Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
> > Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
> > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp_mst.c  | 21 ++++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_dp_mst.h  |  2 ++
> >  drivers/gpu/drm/i915/display/intel_link_bw.c |  3 ++-
> >  3 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > index 20766b6c0bcfa..0c362784afe4a 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > @@ -2172,6 +2172,27 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
> >  	return false;
> >  }
> >  
> > +bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
> > +				      const struct intel_crtc *crtc)
> > +{
> > +	struct intel_connector *connector;
> > +
> > +	connector = get_connector_in_state_for_crtc(state, crtc);
> > +	if (!connector)
> > +		return false;
> > +
> > +	if (!connector->mst.dp)
> > +		return false;
> > +
> > +	if (!connector->mst.dp->mst.mgr.mst_state)
> > +		return true;
> > +
> > +	if (drm_connector_is_unregistered(&connector->base))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  /**
> >   * intel_dp_mst_prepare_probe - Prepare an MST link for topology probing
> >   * @intel_dp: DP port object
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/drm/i915/display/intel_dp_mst.h
> > index ab09b487c6bb5..8ce89242c05c9 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
> > @@ -28,6 +28,8 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
> >  				   struct intel_link_bw_limits *limits);
> >  bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
> >  				     struct intel_crtc *crtc);
> > +bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
> > +				      const struct intel_crtc *crtc);
> >  void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
> >  bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
> >  
> > diff --git a/drivers/gpu/drm/i915/display/intel_link_bw.c b/drivers/gpu/drm/i915/display/intel_link_bw.c
> > index b47474a3e9fec..e71e76d6fd3e0 100644
> > --- a/drivers/gpu/drm/i915/display/intel_link_bw.c
> > +++ b/drivers/gpu/drm/i915/display/intel_link_bw.c
> > @@ -64,7 +64,8 @@ void intel_link_bw_init_limits(struct intel_atomic_state *state,
> >  			intel_atomic_get_new_crtc_state(state, crtc);
> >  		int forced_bpp_x16 = get_forced_link_bpp_x16(state, crtc);
> >  
> > -		if (state->base.duplicated && crtc_state) {
> > +		if ((state->base.duplicated && crtc_state) ||
> > +		    intel_dp_mst_stream_disconnected(state, crtc)) {
> >  			limits->max_bpp_x16[pipe] = crtc_state->max_link_bpp_x16;
> >  			if (intel_dsc_enabled_on_link(crtc_state))
> >  				limits->link_dsc_pipes |= BIT(pipe);
> 
> I think Sashiko's NULL-dereference commment is valid.  Can you check
> it?

At least I can't see how a connector can get into the atomic state
without the crtc state for the CRTC associated with the connector.
Sashiko didn't provide the exact scenario it had in mind.

> 
> --
> Cheers,
> Luca.
