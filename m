Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38983806DB;
	Wed,  3 Jun 2026 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487952; cv=fail; b=YeXub+MXRxUKCCbMGIK2oo0TPaA4oX5zLlVOQ7VgWaOMe+09excsyWI9/ZjmwnCSpYVYf2FPJRhaEXZeKUwPGRQkEXC5Xbn16kMbckcQy0C0SxA9Enufm+B2FNY8gSIDp3HZJfgFNh2fNlA5S5jyx8tcPeLqq1qqlB1LaTgcDCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487952; c=relaxed/simple;
	bh=y6FsdAfYoenDJW7iyjIYTaByn0WSyqiZw7kYIh43Jg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fu3qdJ2dmr3Bw/2HASyuRyD0EfXZBiT1xtRkOi0oL4AFP0tleXrBTqKprkNagNNA7/KI/TjdVJ22cOIIvJiYX9hs0SGS5Obc4ycELJFvdfb4ZKLHwYvaGnqp3qXHQ+db2nnJlBQN5iLQi1AJXakBbbR5s60Y6v1vo9aYZHMuDsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRxvfbKp; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRxvfbKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487951; x=1812023951;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=y6FsdAfYoenDJW7iyjIYTaByn0WSyqiZw7kYIh43Jg4=;
  b=hRxvfbKpx3+tXYW/SXHipWSb7B3z9WF8lldoW9XIfjQmHAS4bMkII0uU
   vY3qK4Qq+7zvExyJ6Kv9ZTi5nI4MkO4OMTonkQAwgwTxR8lCSc2JGxGEf
   Y+tHw16QlrDEssjlb5xS2BSCGd1+m2whMYMmMsfO+00mIzuiaERgGAuI/
   Mis93sxNgGUIlHxEMF9i0sn/SVMEXQt4TNIc4WrFi0hMWwwoyyUi+g5/r
   KsF2mDspdvwYEfaKDwv8twprRHN24XXI2HTE5vxP3xvfU5VwyKl18cOkW
   bJ+DhJ6C6BgEBljttMWkm2mP4KDgM8w+1YQPCmpLwtR6mcf1ZuFvN2Ubx
   g==;
X-CSE-ConnectionGUID: hJMYOiGERt6ThMPTAOyx2g==
X-CSE-MsgGUID: RUX5fDoLTSafAF912H3x6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92776581"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="92776581"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:59:10 -0700
X-CSE-ConnectionGUID: LyaP0kiFSluTJmNmX44uaQ==
X-CSE-MsgGUID: t8fW20IeTw+6Hj3bSLAFSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="248520675"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:59:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:59:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:59:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:59:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWuVHGJRSE2jjPRrgegNBL0yVpWoQGtaZ6V49326wEmcT5xhiG5CWoEzz1G82P8E/snJpwmsE9iGYdu3c3540mpU96dR4VPQVrZTHKM88jDBDcmZeCvs7sKb2LocnmGuJuaW36vLCxmzTdmYuRWRx3KJZAaR1v5qiKrQagqLUX8co90nF5kMRlniuh4umBzUx/wTlNyUHm1O/vsCsgK1GrS2eF85Cu0B/4G1pdptpCIS8xuLC1MSRsBWo3YmBeTkudRRl3ZZ0QygqI+SWoueRSuxmNK7EekKk5+UYBl2Yrd//nhlWLrtwb751PWA7EJgwVYpvX7S/CkjYJ7rioHL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGWhB0a5klVt+xSyUlft7tnugV3PLZFNTWB017LXKzg=;
 b=PXrvwIaLAb3AhqjkzO2gPy0ceTiPha6C2LBNBTTZlRZfahhLr8/DHSWXnou1NTvAe72arRVnddWM3ueI2Ecdvl5QNNGAj/LARAfr+0ycyoUfb9BAYztnIgDWkWj7gsI58IYle6XNLvqCrgZRcbo90MnR4SjBsCuXHvRrBvWqBJjUnyQJFeMmYKeCOT8yqSPU5RdMflanX/wdrL7qrQy2DOnUkAw6Z4odi10Q5tiMCxUmc3ZIg+gDaw6J5pFLT0RkKSWaLltVRb8PGRur8rVcrDlvFLzYda+8DprJFQKempeU/N12wVtRS5rJqg6fwaHDQchj0jAHGr2ja1ShqSJxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 3 Jun 2026
 11:59:00 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 11:58:59 +0000
Date: Wed, 3 Jun 2026 14:58:51 +0300
From: Imre Deak <imre.deak@intel.com>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
	Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>, Jesse Barnes
	<jbarnes@virtuousgeek.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>, Mark Yacoub
	<markyacoub@google.com>, Sean Paul <seanpaul@google.com>,
	<intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Simona
 Vetter" <simona.vetter@ffwll.ch>, <stable@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm/i915/display/intel_dp: Drop redundant
 intel_dp_aux_fini() on init failure
Message-ID: <aiAW-48pIjBR2PKR@ideak-desk.lan>
Reply-To: <imre.deak@intel.com>
References: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
 <20260603-fix_i915-v1-3-7479ff64e705@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603-fix_i915-v1-3-7479ff64e705@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GVZP280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::11) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DS0PR11MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 77580b39-6178-4413-6c9c-08dec1677f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|11063799006|5023799004|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: chHt6N89ViH5A3EU4U6HTP8t48gwxsoiOFic3fitrhQ4odP3/dqJxjf5ZpzEimxuLKXKTU3GHx3bBt4mUf0J5eLjLiGSdqkhqEZSrWs8LOqLpYm3v4pWz4cZaGZ/DIGiMKpAubDxX8not6wXWKj3ogvxbyyZIjMspRKw/M6tBcLvFbz9PobvgLgO+/k9VdqxkyN8frvTSjneWhESnm9Tf65fWY/tkgDqqvtUi9Va84txHqVNm7hP5L9u3JtU908JYjcowjT4rLwu0pKhI00nipINzolfI4LvAi+i+b0Anh5P0s59DeHMxk6VNbnJ2bRh1bCiKYWby01HaXYGijolXvt7L46jwtvQUicaQOtlPwyEPwBdAn8+LIBtoAn8RDhe5MUh1ZDXJw7j2TkgGfLcgl5cHdCopCjF/7vv871GXXjU4PbczxC2Xv/b/mlsSKIF6fRG05HeAOMmxRyRYSfWku3O11I645+UUj53NJ1IAS7TTXsrutwOSqCny4ANujQeuzLKdjMd0RfSc6JvdD3fZOMk28tvnuJq6cWnEYg879Zb4bgQ66DRpWK1jd91uBvB2wrbkdmANaslUgsHhA4284nLYaEhwI0eYd8FA6C9whMw0FZoK8wqHuR+kIMvYm0PnZDyqmgEv3eSGiXeWSefyPZJKhJqvoill6He2TowPB25O1lgWuMYpU0SorAskyfn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEiPlDyxUHbwNGmGDnm+LLnQXC+aYovWhfGhUeCJc8Ma+WQZW/B93/CaL9M4?=
 =?us-ascii?Q?e2bOEk92m9/PmBHjfbcA9uYGkMTk6YvjnDw67HxQMVFszIJAcg8qUYhOlxBo?=
 =?us-ascii?Q?OyPov9XCRh0cwmeYouYOnnZNmpEs4hK3UVKklsZ4KbBiyKrGTvIUX02n/7Ro?=
 =?us-ascii?Q?7uHU2TrIpYU4Q5z1XxjZ4TGwSIAbbVZvG6QGcnDG9U1LvbH1r9hooAVEa2lC?=
 =?us-ascii?Q?jgnEx3KcllG62ZswBJ1Em3IQSkJpJqX0A9nK9sVaJB9cICxQ7ThUoFMO49RS?=
 =?us-ascii?Q?vjvC9KC7VVZQ7Ai5f+7xjUTDgwq5YRgVAklTyiopa7f8Kifq1/euOVLMjTa3?=
 =?us-ascii?Q?EeWQ3csAKP0I/mdueY5ne83N0XcROA4K9zqzTXACGBoPP1ybHm8qHOY7OIub?=
 =?us-ascii?Q?9Rz2vVKi3ZBbMIZUZwZqhzBN9aI6NQyYrL7RfPpWKrGzo9jtuyMclcgdVEb4?=
 =?us-ascii?Q?SHMCQbRhYHA7Yxkw2c9wng9NGC0hWSt+6NnE+1JAN0w1pqZiTPCZmT4ZMTP4?=
 =?us-ascii?Q?MrCb9c2uq+qIF4aWcuEQwYYpzy3ifAzmQybzfvhJSolGl35YCK1HxObOkuw1?=
 =?us-ascii?Q?lfG1zuPhx4zObdl+ifonwkBIFECKBCfMYeCkaJHGcpGVCxPS2lKUkPIgRxoW?=
 =?us-ascii?Q?VGA+1jtucT3rb47hGogMDtKpBpB1lpQtmKdlOmogfT5CMFrzl6g6kvQU08Qt?=
 =?us-ascii?Q?6sNwcwdtxXY5dAuqo5qNmC1mERJn3AkK+Utr5EBijPHgTpXKJ02NKBSC4SAZ?=
 =?us-ascii?Q?3lVmlGMz0Xgz4bKCW9NLlSrQZ6+QJBO2cogQ+bk98HvTHDBDMLh6Lh82zkDe?=
 =?us-ascii?Q?OsXVFUnqXgup8MFfEtd/ER/NYPY776rgsTxchkyWCoEiqJn+89ib8+iAI6W+?=
 =?us-ascii?Q?3XcXGkrJCkX9b51OoPdx6sNdMdHgOxbDZN0Rjo9liN6wilJZXsFLrAXVS8zA?=
 =?us-ascii?Q?ViuUtnascIsljTr1wFVpkuO3QbmUv+OKNh7rCee97pwN2ONCDZM6691nqJMo?=
 =?us-ascii?Q?YL8Yy26X45vZuqwIpC1is747VNMuIUhgbMJs9ipu6wBwTUlEcYpClVgWE9Kw?=
 =?us-ascii?Q?zeAHUov3j3+uxYY3Ek69hvaQYeRbLbH6i+KMCEajvM7sCYtAL6AHjhtKu0zm?=
 =?us-ascii?Q?UuB8F1h5JEsRp/u6vwP9f8GgWb9khGJrgnlRa8poi3p7sv9gUPzc8/pURf21?=
 =?us-ascii?Q?+mNJSmdaahjPVcV1hrHCdnRgqUJXm7f3W2CnNr1Pmgp8fZjw/nhKvylgxQ+X?=
 =?us-ascii?Q?XhD0PHBAaZxgI9DhcSBNDpY1kSMF2uhtr/uTJrYhrJzIRfcK5EzHHqrxRbUz?=
 =?us-ascii?Q?lm1bTuGYCnu3MrNjd0pepZPmPGxbBzE/kfIKLbI+sEBaF7+JHexLx2JsHHf+?=
 =?us-ascii?Q?aqZQ4NsFQ+uW4VwoNVlDF5bAtQKVLspcKY5o1nFj+9Zs+vmnp241eXU8PcEc?=
 =?us-ascii?Q?4chUK4P3Y5GPL5MK8c2mgoji3vYn24kPN8EyFCIJj6MrLgvnAGezmvK+wTQ0?=
 =?us-ascii?Q?DkSR+QoUj+OppG69OjoWA9VdpXBWuTPCRZxG/2DpU3IF7wtttjChcL8IVbvC?=
 =?us-ascii?Q?0dSmB/vUiwcrqB4Czy6aPqS6XW9oHkN0H8nDHRn+c3RnuXyWzFawBgjA5noo?=
 =?us-ascii?Q?dtHQ7wy4G9KjIa/0wyxPUlOVaH/spVpimd8xgdq79GKLBEwB6rTdjQSYYx0Q?=
 =?us-ascii?Q?1seymnIAlRjUw8YdINwR/+OHpkpCabOp89H7amaM2/nchJ5U4lU+Sspd5Ll+?=
 =?us-ascii?Q?r8boNthWVw=3D=3D?=
X-Exchange-RoutingPolicyChecked: rn29jdM/sDT6KvEA8zq1bp+4tnWgfowOVLpuAHuGrfGhuxsWrY/bBfGrh01ZuzPBDU9QDlZ/R/znmTcSe10IjoeYv8dM4fT3BWusCElsI6lGbuvXwX4rDqrZBu8ktojiOEAzzCXBLhWGS/MnmbihrqxDBHKCXv9mInYEPlK0Sdth76a4kz4Xibc/aeA61zXl0S1Rn+mY07+mlwRu/cbvO2kvxSdGSSI6rqocRPUApJ23Az+3Z6k4qfube2m7Ahcr6mwg27mEyY2vQwTeAxHt8idivLOR4a3zXN3na0jyLwnR1eKfJ061O1Tnw16AwEdxYDTbzeY6QcTxXq1pEBNqHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77580b39-6178-4413-6c9c-08dec1677f72
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:58:59.9053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCtw2jt/TY+GDIL4EaIFgkNZUqDZ0UFfiwPCnpk0Orjp2/NjmIt2t2NUD1klQns0fApHHZLTpiAT6JvpNnxY3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 10:59:54AM +0200, Kory Maincent wrote:
> intel_dp_aux_fini() is already invoked via intel_dp_encoder_flush_work()
> in the encoder destroy path (intel_dp_encoder_destroy() and
> intel_ddi_encoder_destroy()). Calling it explicitly when
> intel_edp_init_connector() fails before jumping to the fail label
> therefore results in a double invocation. Drop the redundant call.

Could you please describe the exact call chain leading to
intel_dp_encoder_flush_work() if intel_dp_init_connector() fails?

> Cc: stable@vger.kernel.org
> Fixes: c191eca110a37 ("drm/i915: Move intel_connector->unregister to connector->early_unregister")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index f01a6eed38395..f4fab568172f4 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -7310,10 +7310,8 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
>  		connector->get_hw_state = intel_connector_get_hw_state;
>  	connector->sync_state = intel_dp_connector_sync_state;
>  
> -	if (!intel_edp_init_connector(intel_dp, connector)) {
> -		intel_dp_aux_fini(intel_dp);
> +	if (!intel_edp_init_connector(intel_dp, connector))
>  		goto fail;
> -	}
>  
>  	intel_dp_set_source_rates(intel_dp);
>  	intel_dp_set_common_rates(intel_dp);
> 
> -- 
> 2.43.0
> 
