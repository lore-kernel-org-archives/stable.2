Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB7364EA6
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803082; cv=fail; b=GxsMfSC+JbJw4cDvGQPTKMlSjVMRr+FZ81TxX1L2QVmzbRvjtoDD7ZT/pHEWFrBW2lV2AbONLhQJnqujf6CffYG4jytyi3ar0qGORJpvMYEYnrXfBzTzZnxoVE2CzWEHIdt6FsTb4xAJLl1ZA287U1FuT2rWSqhIOWRK7aW8rVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803082; c=relaxed/simple;
	bh=aYI1XDFRdQux4jmqF6Ufz+aaqp2ocY13AUS1B7XVWoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTvXdpfTaOwZoW0meHmwfdqQD0hGhk6D6RknbTc+1Q8bfCtE0g3Mc9mzcxFkd+dWAKldlGfz1jSsKPycyQ6T1A1SLOE8GimrelIyG8HZqMtuW26cLeIoXdcN4/cTaBZ8yANfjUikARCEi+f/z7uEfeyOw2+2owvlZ38aruqZzT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hU/kfBgH; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hU/kfBgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788803080; x=1820339080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aYI1XDFRdQux4jmqF6Ufz+aaqp2ocY13AUS1B7XVWoo=;
  b=hU/kfBgHTXluFcwjW6Zxdvj0y60LTgxZtJAuiF+34u+sqKpZsXXcUcrJ
   445PfmD2Iwk1oFdXGg6jsseuii35+BvOAjN3NNMCR1wxPUprcUy+e8DJ9
   DtHD+8nwzyUGlBVFJJ7GPbAWy8GRygBAzKVvySZ7+mKBtOeOBHeqkBW7/
   bVlJE6m1usQHd74JO+p9oFY4LcmbzTXOp/vK8l40HuZZgO/6zDohL4O9q
   JZANQZ58o8YHBVnYzVfx1vopJeHHnDrdRbBH/EBF94Dk9rIVUOjefnvHA
   6Kg8RW7oyC7mfg8aFQsTDkQX3FSqqs3ycZfjYWVzAiMtsPlJXkzTEBA8f
   g==;
X-CSE-ConnectionGUID: XQui9UpsTZuWaei/biJ1mQ==
X-CSE-MsgGUID: m0OmhqMOTSqnrYFHVS+wrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="106724238"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="106724238"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 10:44:39 -0700
X-CSE-ConnectionGUID: UH4bHUwWTTWiuQFi1uSS2w==
X-CSE-MsgGUID: OqGF0CJfRTesIj3V9ZPtuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="272706485"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 10:44:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 10:44:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 10:44:39 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 10:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KU9qJxMVDn3aToDRrTpF7t2GY0XkTi4Ysiq/BXoabktPv7eP+XG/ehhJnxEuceHvvUSSUOEsszxoCKyI84OLCrg/IQnyx14fJWXEC6hJ8GiqDMpOatmUEi/mJ/XdUNdM8C9bzY8S0j8wLcfAFmupgxYWU1ZQ2Pg6JCHEMVzLfhPynfND9WRPTo3ofR/pxKOyRWuTFdssoQZRCJD/x/WvQIMVr/SFwdSBBJAuPSjNV4r4yYtj0yQNZtnhrzO/RqZtZfZk/n+1kteAmEHtBj/GlhklycPQZtyogYwQQtM2WfMzZnufOyj58M/iDRvD/CoiwNuzQY7INdR1aUTlw+SnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRCszxWfTwz9mKyVSOzegDlBRzKRyzzH56IiMn0bTr0=;
 b=rnT9SRPkcpMpNEft3NPI5kUCllhmqPxQI87uiwlu9U1xx0c4/XotVK8JLtbb1Lqaj0ninrIIMF8JdxaeQ5LcA+zA0ACph9vEkgW7XVkdIK9AyCLOzTm39Bjco7AhseDMvWn8v31RITFAslsvddn6XMVgv0dWPVpa1ale03C3BqbkeEE/qFpTT6BOcYKW2B9wbeC8XaBvQ0Z94f9DXMN+ZPBrSWmiIoKtjvYlbuX3MD9P8nc2kQfGGhcHDrchWOHabpB+UsUxUSQVJdaZt83kzcenxH1wHPDD3ATQjybe31DtfuQRWVKjIda7BsAqYFx16bhT6wWzknb3QdyFr/0s2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3SPRMB0045.namprd11.prod.outlook.com (2603:10b6:208:57f::14)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 17:44:19 +0000
Received: from IA3SPRMB0045.namprd11.prod.outlook.com
 ([fe80::28ac:4593:a748:4b56]) by IA3SPRMB0045.namprd11.prod.outlook.com
 ([fe80::28ac:4593:a748:4b56%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 17:44:19 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 2/2] drm/i915/dp_mst: Fix configuring TUs for a disconnected stream
Date: Mon, 7 Sep 2026 20:44:13 +0300
Message-ID: <20260907174413.741851-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260907174413.741851-1-imre.deak@intel.com>
References: <20260907174413.741851-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::23) To IA3SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:208:57f::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3SPRMB0045:EE_|DM6PR11MB4612:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a16fc6-de2b-4279-ab4f-08df0d07a4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gkXbeW5H6lLEfl57z4XZCoo1+oXM9ksN8wMk8kYKzTVMMuvapcUZSHFMhf/3qXNBR9nsx8cplii4jT6ObOWjUicHrqfZRZ5xq7tm4PA5n4MYb3bdJo6nFwOBkJ6qL1fii8s3q54mmypvonnR0IhBDpQM/PJV5fYT1QQkhSvpalXdVSIB6PJQO+TZl84agGcHWAp8qAnXb6+uyu+/GdMtj/mbTQO2E9FTxoQdfN9FKZy9/Gyp7xrO8thXggG0lSOR/KwV3iQSPRBbDWYm5ot0FN8YT7m0GvFuRoeXkV0vQXADKbTmxhrYrC6HbafCynX4sq6hVIC3psBAyhtqeJxL8eagX48dguC5NsuKZgvyDnkn3TCxyo4mjNo5TggA46ymQVwJqwAG74MWyQbmKQ9sGCACOZbn8aQas03WKTTT5YP8BgRMctxsOv9Z92dyM3fuSTXoqvlKqk3FxykOee4nHVFwPlrck9kBJfl4B9hK7CjNOU2c1G586DQBLH1xHTykWq6Z9gTmeADP4kcxxDHyibYmov+advwbgwLSGKoHd2iD/pD1aUVzNpjHKe3tyqjpx02SdBAf++/bE5+8Wo1TYglo6DTuNcUbfmEJpc6slss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dISs9SSWLqPB3gJnpYYbFmi0u9Pwq768uSMbbRzpP9pIRpUEORpq51/FywDt?=
 =?us-ascii?Q?FB6590YIGKi3ENwjc/4mGtzVQyeTTjXfrBiHBBEe5jVPdGnl6pWsdj5Hwjl5?=
 =?us-ascii?Q?OOBB8iRHviMAXFzWqMYeyeK6Do6/eLkPWt4DnjjuTL4H9q9c8RDe0s9qOvtU?=
 =?us-ascii?Q?Upm+RKbnavounyi+ACLtAJw4cf5zIFABx9fLLRHKaCXFTdQyWBskdVqPV6L8?=
 =?us-ascii?Q?Z13XigGLy4fu4Sh0HDr1zLknwPcd5XJJnDC1x/n6rdey1fEwTjkhdhnP6OuE?=
 =?us-ascii?Q?aJIQmcG3SOBmA2y9mW8U7aPepkyVoZROsTkTN4ANpwSO2btR3NthA6H1uK8p?=
 =?us-ascii?Q?pjtZqVI3ojBB9Ad6iKG72+uqJFs5U3257J2oKAim6wgzVGaKw0at5h3YRpeX?=
 =?us-ascii?Q?v0kGHdUdiEn0BSyxQKVJwPQi1HLDGeZw9DrSNvjczmjFkq6E34A5Wi0GfNp0?=
 =?us-ascii?Q?NzqgjrohxC3gwJ50hoGV+PqKsBy8nPA/6slFd8wKcQbIsiGU7B80golPNhDm?=
 =?us-ascii?Q?t5Mglp9c1rDcE/Fk9BJMFBOnYdws9pCgHydU6Gp8BbavH7uVLuwS9HDJNyWt?=
 =?us-ascii?Q?J61Qp7hcMg7ro1JOpbov4Hrm3Ve2S27Ivgc7Ee9Cl1ChXlDkYtJsXMF79pOG?=
 =?us-ascii?Q?V8BpBN568/hVs04pz+UTJF81r0PS1ug5Nznyk38/0gIgAoJp6dEbgfvPxPue?=
 =?us-ascii?Q?9Tnf20+n91HyP5secGl9wdSrEq8kCVqSd+rPgHTcHqktdrdMhUzhPCXsiiaV?=
 =?us-ascii?Q?XZoOxYGsR9MgLs/+HdlNuc1fS3UXnriBO5XvvKR1TBNzMRpCH86nPDDJme68?=
 =?us-ascii?Q?4xaML3Hf1QGytxVrIpUFTtvFW7hD4y0p+Qqn/xg9Y5jMGYE5eyd4yAYftBCJ?=
 =?us-ascii?Q?l8Tl84e85WCuCNN+uJ43/0Q8hlHxGQ4rTf+Ql5SpGrAVJi4JXjXG3zlw6XAL?=
 =?us-ascii?Q?/V/4DS+WtgX2fxAd6OmwN9Z3XdghBgKDggN5S5BsOWKFgjefUjK+vIuhGBxd?=
 =?us-ascii?Q?iPIQmbk6YbjhkXt2H3xnjZCbu9hi5w/LwprwduKPvRs8j9Pq+GptHa7fliLG?=
 =?us-ascii?Q?rlAZ5lw/IkcwhK0B9ZDzpPPquHf6k2juXliNQTPPCyue0k7A8DHa5u0OJCWZ?=
 =?us-ascii?Q?+DIr3orl+0bB3t1QC4suUcQLo1Tkne8PXO+scTaSxCg8Kn5xdLhG85X2ULAO?=
 =?us-ascii?Q?sz7WxlgWH/hsZqff/kViwo/umz+H+uTZUZJIMqwnFDW3ZHCONHPCukdb7NNm?=
 =?us-ascii?Q?5/hnHqLTAq9IZttOFcABlrHQvh+ggU20IutNHn4Yyyrvgv9JYrFbg+LTy0Dq?=
 =?us-ascii?Q?18mIavZMDOfP+1T895H9nBFw2HwQAZ+OIdBdK4zqC1spPBP8+hvyMIsnVE6g?=
 =?us-ascii?Q?WFIk+iPMlf6xyNvSvDjP1TZl6xAEF3GEYtD7GmWA47mDaFh9zSi0Qz2KGEx3?=
 =?us-ascii?Q?OFzeGEPMZjgF8v/78620KCO8IumGRd9ZvVcBMud5FEMKp0vpi4n8CP1xzk1X?=
 =?us-ascii?Q?YIvsWuByWZS2wloaQ/AvuIUiPVuoaEBeop3hFHMlpHfEMl+//aMTd58M2u7W?=
 =?us-ascii?Q?+8sLA28Oi9qk/z2/CeQVQsDYK0AQfunrCX5dcFmfhfKdsMR2DD6u1iilszrS?=
 =?us-ascii?Q?XC7aP4cCOm8grBB1phuG7WIY79AJxWIIA3j9M+a2ysuvvXxAEJlz25L7knmh?=
 =?us-ascii?Q?MODf9AfkTxhDKIIfRO3khh/ayZPEiH73hfAKGZndt2FpqnSnG8R1/K/+8xQI?=
 =?us-ascii?Q?vjNWTd7QmQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: cTiWoVdXzodXFdwh2VDImDPfki8g4xHtWSHC20N1Dj6IFXUCgW9z9t65MPH5RPXxl/L4c93fzLXoyZeWst0M7mbhf8CiAVVHRUlLO7HA/ayA6uBZeJqYLghlV1je1MWI31Ei0NbYrJKPxJELRSOE96cOPL+CW9FSigoRMYIeivTm4tfDPYjnrlVM727ogG3KIqvsvlLw2zXTEIM1dclPNYoXlNlWV0Cp2PoHO6Ia42MrQxu3+37lgBB1abaBMMAtXEYVjLffxZkM7MoZ07u0/NVEGNanTnnJffCLt0cV3KmOgz/0Om6IpySeTcdFSIhUelTWqi0jdYHwfPaJfktiJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a16fc6-de2b-4279-ab4f-08df0d07a4db
X-MS-Exchange-CrossTenant-AuthSource: IA3SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 17:44:19.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Gn/quoRhibx/2EkncMqFkHNZ6JOzCX7kbnysL+JlMTjz2gbUYwKXhGTznKjexlB/hwc19hHoPW/o01eHpeR6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com

During an atomic commit after all the MST stream CRTC state is computed
the driver ensures that the sum of TUs of all the streams on a given MST
topology link is within limits (63 for 8b10 and 64 for 128b132b). For a
disconnected stream the DRM MST core's BW verification doesn't ensure
this, because the topology state it uses for this is destroyed as soon
as the stream (i.e. MST connector/port) is disconnected. The driver
should keep the link state valid even for such disconnected streams, as
userspace may disable them one-by-one only in a deferred way. Ensure the
link's sum of TUs stays within limits in this case by simply reusing the
maximum link BPP limit from the stream's (i.e. CRTC's) old state.

The disconnection can happen either via the whole topology getting
disconnected or via only the given stream's port getting disconnected.
Check for both of these conditions separately, as a connector gets
unregistered after a link disconnect event only in a deferred way.

Cc: stable@vger.kernel.org # v6.10+
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c  | 21 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.h  |  2 ++
 drivers/gpu/drm/i915/display/intel_link_bw.c |  3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 20766b6c0bcfa..0c362784afe4a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -2172,6 +2172,27 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 	return false;
 }
 
+bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
+				      const struct intel_crtc *crtc)
+{
+	struct intel_connector *connector;
+
+	connector = get_connector_in_state_for_crtc(state, crtc);
+	if (!connector)
+		return false;
+
+	if (!connector->mst.dp)
+		return false;
+
+	if (!connector->mst.dp->mst.mgr.mst_state)
+		return true;
+
+	if (drm_connector_is_unregistered(&connector->base))
+		return true;
+
+	return false;
+}
+
 /**
  * intel_dp_mst_prepare_probe - Prepare an MST link for topology probing
  * @intel_dp: DP port object
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/drm/i915/display/intel_dp_mst.h
index ab09b487c6bb5..8ce89242c05c9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
@@ -28,6 +28,8 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
 				   struct intel_link_bw_limits *limits);
 bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 				     struct intel_crtc *crtc);
+bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
+				      const struct intel_crtc *crtc);
 void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
 bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
 
diff --git a/drivers/gpu/drm/i915/display/intel_link_bw.c b/drivers/gpu/drm/i915/display/intel_link_bw.c
index b47474a3e9fec..e71e76d6fd3e0 100644
--- a/drivers/gpu/drm/i915/display/intel_link_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_link_bw.c
@@ -64,7 +64,8 @@ void intel_link_bw_init_limits(struct intel_atomic_state *state,
 			intel_atomic_get_new_crtc_state(state, crtc);
 		int forced_bpp_x16 = get_forced_link_bpp_x16(state, crtc);
 
-		if (state->base.duplicated && crtc_state) {
+		if ((state->base.duplicated && crtc_state) ||
+		    intel_dp_mst_stream_disconnected(state, crtc)) {
 			limits->max_bpp_x16[pipe] = crtc_state->max_link_bpp_x16;
 			if (intel_dsc_enabled_on_link(crtc_state))
 				limits->link_dsc_pipes |= BIT(pipe);
-- 
2.49.1

