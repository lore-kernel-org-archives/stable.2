Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76A3AE191
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803081; cv=fail; b=ffHs9jvZJwfGAAStfXPFOghGjvCVyM23OihlHLvE55T62DCdz+twfQkjYvdOjCY5dsBhZdMRXDbDWEeJAgNE6GlJW0SoYU+p22Ld4n3jBq7d5sKZmHGOuJPk2dtuRT5DiY9lf1O026fgz48CVejdwA79AdBfTJ6oti+3ekGL4+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803081; c=relaxed/simple;
	bh=I5rEZk5sPQxOEYKAg1GXV+al9jhYatoT6ryx5rbUPOs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dj6ZKq5rmydsv7sQxTm/hQhgwG4QMHtN5EwyNZ5R9up4XUibJF5+xWpSGVmV2GRUutEJulLv3S2YUvAD279YQBHSa6H3HyEGsffkrXn4ScIOsxn0Z6jcJd6CDrmcrUfRjcHfTkEW/STtbOi5Jlq0JubPJz9p6eLjXeD3ZqHu/CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+b3FWaK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+b3FWaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788803080; x=1820339080;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=I5rEZk5sPQxOEYKAg1GXV+al9jhYatoT6ryx5rbUPOs=;
  b=D+b3FWaKcfPkn3f+ZwcBoux6fQk7MaXQHKcA+kW2dFwQqvjhSilQ7AMQ
   Twuib9tvQSyvYjdSlnPzZ/2tpJXgelmkSbYgKuQvhSWrScJ05Bf5sKoFF
   1eMTdCFLPcwQIJl0P13xFZNigCDFZsDMumTiL30vGHMmyPffSG/qf0180
   PEIU05IrzQE8oT4tKWi/2UOdJM+l0cL2LCQ5WOwTWonqJkIrDPR44BF6B
   r+zmtmTnT7S1MewjQMQJ6yg9kTyJysmgOuT9DrBBSedOVkpMAZRVyGlqz
   Fu/huEqiKnYUfUBm+dqcucLdu5LMU7gjXkVDM6Qr0Km8bXpSk3umg/Ugf
   Q==;
X-CSE-ConnectionGUID: 4z+yIlJsT5eq3znQjxa0IA==
X-CSE-MsgGUID: WPDU4ZwwRsaLAxMS24UX4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93027270"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="93027270"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 10:44:39 -0700
X-CSE-ConnectionGUID: uYWTnz+7SoSFwjh7Yh1mTQ==
X-CSE-MsgGUID: nfX09rUXSCemxeRjDI6qYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="270253364"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 10:44:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 10:44:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 10:44:38 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 10:44:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcS/pLokgutQ66IX+TKMA85KmasLLVs6u4i71YzwZQOio4gsq4nqaCjrd7WHA4TkYSwSWpgs/6/IhD2N51qMV3D8DvzokptTmV6Apy594OR1eQmw3vJvKXHAS5vpGYkU5lZ2m7H0lQ16ohoFx1VOzTtOTyxHUZ9HNxDlRQPNYXmJLQ9kaVFwvMY0RM5EVfbh+X8B3HzSNtlIBThG8dzGXs+5QN1BB2Yo0FYNhA1Ev/r5ZajkP2CWYeZ3b89dqcIrFU5ZB5lvI3sELPbvDBQbt90Mrqx2RorfjiFp+cveCyqA0YTcZTumXuOXP4AgBcG7OXQfiShnF+sr30MzrPGXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VdbiVjq4fYFrarkmtC5b9szHlOsPqLI11yq0eaZff8=;
 b=hMUU2gTf45ma1r0BHO+o1WrG146AAyFaFxluudrOH0mnHxl52OMdhZLU7PgmLA3lA20NSSeWrIVb6ZQaglL7I73aSxvmKP9DKh6NIxZTT9sf9CZbhCwqXiM2v+tMv9kBXNecYdp0Yb9UFubMoXpyOWaCTgaH/VZNbPGKolauTdJQ2+xlrzbw87+Ovbkx8dwPzCN9j/yaEEEp/lsT87n63frUAjGl841Rl0cpF9CyVpkRjXnFeQnylX1IWamQVMXNpadmsSJxjo/IJG+qG08LyGth9z2s4ivbog0gvpTJhQWX4kL1L+vXZ5VaqKPuaa9H9CTym6BbYjofXEgjGBdfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3SPRMB0045.namprd11.prod.outlook.com (2603:10b6:208:57f::14)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 17:44:18 +0000
Received: from IA3SPRMB0045.namprd11.prod.outlook.com
 ([fe80::28ac:4593:a748:4b56]) by IA3SPRMB0045.namprd11.prod.outlook.com
 ([fe80::28ac:4593:a748:4b56%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 17:44:17 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 1/2] drm/i915/dp_mst: Fix configuring FEC for a disconnected stream
Date: Mon, 7 Sep 2026 20:44:12 +0300
Message-ID: <20260907174413.741851-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
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
X-MS-Office365-Filtering-Correlation-Id: d0c582ee-fb90-403c-8713-08df0d07a406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: NsMo4SXE9f2LZ8bIv8pwEie2skG6S95O22bpdBaN8oX/tZTNTbnZsVDPaGnh5UkcGfi8G/LkPt2sW+FedR8Pz3Lnt3iTD+EbTtAMBJhr1W8agGKRjchhPFpg9cmVD2cXpGEh7qGz8i0OCQoh/o6A94NmgMAnKYxC7NDwVJ+ru29Jm34BQVYxNg3L5OMVQeQscUNP2m+kKeeS/SvaXTAllFnGWlqMx/dRnmsnGpSFhvCgtJRwl9Q3pRyVBFf1eQ1tOytkPQgAr/6ZskeZfnnTJkd5oiXw/tDkcnV/RuL9Tmu4zSyDgGYkoRtf3rYJJLGrARKxe4r3WPk0fXTb1CZXqF9NoJuTzwV4RGnkFE+2W2NNSroRGCxmML9m/2Lw+YKH+90L4ZJ+TcT2RTOEYCTztmnKZ5Enhto6ZRQRQwO+mCxrYGWaOT0/8FsngH8JnZide+7FFQB1LJhR/irmDUcnytVE5WXPgEaJ+Y/nR5mchYUYiNQQLDNEP760phAzpYpFjIYO3vJ+nOav9mIoF+TFFN+JxRSDjDO9m1CxCusUu/rJh0Cf4qJ23UwbmDUxbZIsShKuf5/um83NxwCr2uGXwzFpuWEBeHCAkm8b11NicdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JIf0G2UM/kU4/K7fFdqOWP8Pp3yj6hw+FMeKTKlkR/6mmGk9jAiz5bFUEAHv?=
 =?us-ascii?Q?7yrD1LE/awO7sih/tKzjgLcdxUyi434iPacCmt0iX3VWpddAdmo/+KdcNtUF?=
 =?us-ascii?Q?Hf54X5W9zL+e1h5910jLxHym/FOLVepgEJYu30CFO0PdGymRCzhn3lIIj8G5?=
 =?us-ascii?Q?hrlvjFdMfsvOadizxzAYLeq+f2TFRZ+M6lNTel0o9tBhRvxO2C6K5r56MycT?=
 =?us-ascii?Q?IFxhfu5KKF0mU8p6xkrr5ISbaAw8n4DDKV6I28/gPQAuuXu1rHMtXt1E5DmX?=
 =?us-ascii?Q?XdNE8IhBVNNZD9dFI8g4keDdwvH4MMelFJftT4yR2OKhA6o3Ri4/guKaZZ++?=
 =?us-ascii?Q?Y1cfl6HxVvCbg97tv64PU/U7klNT7Ss5l/W+q/ZPqi35BSqKYxklCn1Ho+R0?=
 =?us-ascii?Q?zeKOQqqVG1zL3jgx4xGJKB8kRWZHMyOsSSnArddzES0OjngNstN99Fhi4+CO?=
 =?us-ascii?Q?MMFzhUSriY47atd39XR9DikEQiVXW55Fr7ekwbLIQ7Vj69+nhahSYTWzq50j?=
 =?us-ascii?Q?jSmHznaRdv2/1iEV/URShMzV7R7oq8uiXkuF6ONt52J9BmsCv6nMQIG3OC0v?=
 =?us-ascii?Q?mf7iCJiwuG2BOBS9X4P9bUOKaBWMbdXKIvDn+U3bpNZ+yEBubCdBNRbQq5df?=
 =?us-ascii?Q?r05OM97GJDNIyjhR3MUVBn4mFEXwAJ4ycxQ03nipjoyfoLoQ4INmRLgI/5H9?=
 =?us-ascii?Q?NHeXR/BDGo2HV7/vFKZPMK1iz2xpd6MmJRPAPZvP+3Q/TyXZSJvh5O/L8rS6?=
 =?us-ascii?Q?93kZoeapyE0G5dzW9nuMwgCBtjQOEP7NhGgdUal4rWtxL2POWN2kb2kHAY6B?=
 =?us-ascii?Q?K5T+205wBkJ9HMju9XQoNYexYXXkyA8oPA2atHj5g2LRCrG5qxOKJdX1f0Ho?=
 =?us-ascii?Q?wGLI5Yh0aJuYQXHmMq8J5os5zdxZbM3GP1Vtpz9si7i9D3oEsGE6dsxhId6X?=
 =?us-ascii?Q?csLnIO9Qqd2PMa2WgA5pWpo7yu9jcXeqRdQva74NRc3cuvlAoezbnAExVWDj?=
 =?us-ascii?Q?XZI4X2GjLfuYRSVD51JLei9aUEu7ks5Eom6DO1QjN69kH/vKC3PHNbkbdsur?=
 =?us-ascii?Q?1+TdU3xJ452pcs2Z85cQgd655qGeyBjmR2eLLx3zt/ip/sojW036HLTkk8ag?=
 =?us-ascii?Q?/sgRbG8bwZNJTiWUdeu1iMR95Uz3kaksY1N0gEaLIwOZyOfhaQ9aYst7QP8T?=
 =?us-ascii?Q?tVvI5ljzY3ktluofFGpvo5r9QtVdwUvBiRnoQbjRWT/lgx/JWB03tvUGF+AQ?=
 =?us-ascii?Q?tjbsexjvJqb8HqlYo/7EsaEwvfSF38C7+eoHEzmOijVFxdARNY4DJR70r+Vm?=
 =?us-ascii?Q?tVPjx6fSucE05q4OgEjRI75a1icYeioCP/d9Z1fnIr7JKwyjSM8MeyY/gpUp?=
 =?us-ascii?Q?VQhys0TQQ+me5iEyNd3hiwmKLedkD8JO9J6IB3v7cqmrdEPei8OiUXqQocp6?=
 =?us-ascii?Q?y7BUUKCluAFD3OU0nNAXsXhIxrDVNxbPw8YnTECOC82oAD0KVJ47n1naFmyu?=
 =?us-ascii?Q?lPCpzQM4Dm6N8MT5Vj5u6alE+3Sy8979BSo+N8ZiWw/Ej3dwmS5vQH3Qj57Y?=
 =?us-ascii?Q?R+EhlIb1dcCeiB+tB2OmQZuJuQxUXsbCoyQysscH+1bLJWGUWyKzuOnw3sqr?=
 =?us-ascii?Q?jE+tS0tF2NqVlrVhgT/6IW23jMuu+OyuEf7UCCWjMjF6k2L+UQSh5XqsVpLP?=
 =?us-ascii?Q?nbizLF9vGmUzNdN9sLoYBjgnZXHgu9warw9lBmMFH63ZbYz1Cc0B1ZVFjqTS?=
 =?us-ascii?Q?Gvv1c1i+HQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: KO/rOTwJ8RtaEBHr8xs11lqPfK3OvMMH/5/5lijlFX/8mDXpppLL3H4XUn0NcIG11zgtrCB8Y2Ojv17ncVBF/toFyje7m273/kNPK6W9opgzTSG/dpGP8Rdnq4oxS1cGLLu0ccSr/hHQUUMANdYKyybPOVdv09F4//oYarwogLYsrOVkQO97rhpQxijCKdPnsdN9C3XFhA5tZu/r76MkOSd/YUhLAYCF9QlJ/ZwTwkPNZcStcag115EOFqLZ63F9ezPutymfAJ2qwf5B/Isy3iY0Eql2U97DD9+5vnRuFA0qkoI1bTU/VAm2EmQ4EPqyTFgZwxUlqJF0raKka68h3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c582ee-fb90-403c-8713-08df0d07a406
X-MS-Exchange-CrossTenant-AuthSource: IA3SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 17:44:17.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z013ypv50zuK3TGCYMXRpzEoJ8ZfhGJ+Enmfg8gtMvVv4lBPSJ9YHd0NvMNxqV1NNUEI9PMq1kRvVd7ViqIrmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com

During an atomic commit after all the MST stream CRTC state is computed
the driver ensures that the FEC is configured the same way (enabled or
disabled) for all the streams on a given MST topology's link.
drm_dp_mst_port_downstream_of_parent() used to determine if a stream is
downstream of an MST port will return false if the whole topology is
disconnected, since in that case it can't verify that the port/
parent_port passed to it is in the given MST topology. This is a problem
during the above FEC configuration check, since
intel_dp_mst_check_dsc_change()->get_pipes_downstream_of_mst_ports()
will not return all the stream CRTCs/pipes for the topology as expected.
Since passing parent_port==NULL to get_pipes_downstream_of_mst_port()
is meant to return all the streams for the given topology (i.e. mst_mgr)
skip checking if an MST port is downstream of a parent port in this
case.

This fixes a problem where the FEC configuration check explained above
failed to ensure that all streams' FEC is configured the same way if the
topology was disconnected, leading to a FEC state mismatch error.

Cc: stable@vger.kernel.org # v6.10+
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 6a869d0f6ffc0..20766b6c0bcfa 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -856,7 +856,8 @@ static u8 get_pipes_downstream_of_mst_port(struct intel_atomic_state *state,
 		if (&connector->mst.dp->mst.mgr != mst_mgr)
 			continue;
 
-		if (connector->mst.port != parent_port &&
+		if (parent_port &&
+		    connector->mst.port != parent_port &&
 		    !drm_dp_mst_port_downstream_of_parent(mst_mgr,
 							  connector->mst.port,
 							  parent_port))
-- 
2.49.1

