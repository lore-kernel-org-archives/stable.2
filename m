Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267B280331
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280756; cv=fail; b=SYStMihFkanS9n5vGuY1bQoSBxF0+2zOGcfVsz4Uv/nUiq9iTk137Nn2iwlaDviFjhRVWxPJ2/pGFU7p7BlmE9r9O+Dl3UnuJE/zCq3Mj7hhhD+xLroyjRdWvZtol4UoXP4/9Nhi3v1fhPguDHHBL2J9+h0iYFHsNK4G5NE4NVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280756; c=relaxed/simple;
	bh=OWTfRxgPcYP2vclnh7MtAYdhVT7P817jhfi5CDtHXy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kzJ5N9nrrDLxJTXCe2MVFv46/kCB6eYyySrHGWYjEqWLlYEIqfcVUid4FDt3Mnd4UjTnjs8t+H6qA9ptp2EB0HyXQsK3JzOce+fyk6Bxga7Obf63W0BKxkMHu2SWncqfhHLo+JU1Pq23cZwLsYa74jHq7lEbnkj4g8a0mbgG61s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBNE7R1c; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBNE7R1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791280755; x=1822816755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OWTfRxgPcYP2vclnh7MtAYdhVT7P817jhfi5CDtHXy0=;
  b=HBNE7R1cttZoC+mQjCV7IuZJfiX6+S/nZuBsGQAdPUx5LHb7S+eHFBgx
   xYT6FX6zhENmuu6MdjEVjV3PUOvf+77sriheYystxPTVswW1Ivxt/Acgn
   SZCm6c95mFG5Na4WMFEfTxL7keQzxAWKPRMOjEtQS7tRLZFzCF3Tppi1L
   9entrvT6Y9JMYzZC7bMLJldBB37qYh6QKjkKmg4fZg8fjN/lA7+QoHgm8
   Zoecr5OTUEYDaOAIdXiGAM3eGWpsUvENjoVEaZgkrXEpTsKv4mJq1Shkp
   YNnP3khsImHQusYd5qC28O303dAK+CfQq6GQ7EUSMK4Vg0urxv8qOmmwq
   g==;
X-CSE-ConnectionGUID: kYlKbLnyTBK+D8uVdnRyHA==
X-CSE-MsgGUID: QKP3XNQNRWqKyvSbq2frJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="95783118"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="95783118"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 02:59:14 -0700
X-CSE-ConnectionGUID: f+5VZFFTQpqUTrb+LeFN6g==
X-CSE-MsgGUID: QMByZSD8REyLzLbYFig30g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="305039037"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 02:59:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:59:13 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCRSg4NWGTD+05/YTqUPd2RJdx79B4vp9ekmvMTKLfZu4w9AJ0Tba7EPWy5U0VBFiCocP+dMCGDnAfx0Si40zQWkIm9vkc73JAue5rfknOreqlehi/nZEsGfoQ2LRdlgFqTzpBdQUQjMc2nNorEIy0t+WF1GL96onjYWAUAldy3GEcitTkpvaeC9pZwZr4mMwndIob/Hg0mCCLPyFwI4ecT6jAXW9C5b2HIyf3o83wOe4c+em75d7okzRTe/et/I2XjeseXfpaIkcU5CXiHhml50rwQ3yvR4UR49t4FVAnydHkvzlHOpUdl0FtFOYvHrMHEFv5RTzyrMsGvCj8GRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq4J4narIjFZe3u2s/wUX5E4C+IRgRAXMYOeILP8x9g=;
 b=EOmbCeOcqhS1x+9d7XRuLLXbE22cB4RtS7dCLeWT/wLNo0Yiq2yTfyXVEAYANK/NUPTlW+bKTv8sWfJ+dQDZ0iGNUpAPDKTB0StFOWoeD6l9R4q+aieKOw3aAZidkLgisokpqW0YiAZ7olErGrpCRlwg9Xt2xMgpifdUAr+7EMTJ/P2YZiD6mnFGuJ+iq9NRGTNqYBw1gnkEMB2LPNbd9/RMNxuX10zc5B+bxajWdTkwReriJku4kyf0ob3qNIOU1s6FmhhKQroMzXkyKrQu62IwzZkiqnD/6ROWGaCK2dTVXiaONLCBcVS6xuzbTR3KnBZEEQhzqVmN0pRStAgsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 09:59:05 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 09:59:04 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
	<michal.grzelak@intel.com>, Janusz Krzysztofik
	<janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v7 3/6] drm/i915/gem: Free sg table on failure to acquire second folio
Date: Tue, 6 Oct 2026 09:58:42 +0000
Message-ID: <20261006095845.451212-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006095845.451212-1-krzysztof.karas@intel.com>
References: <20261006095845.451212-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::30) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8ced0d-0465-44bc-f654-08df23907482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yflH4gTW5QSbYi8BCA+l+ly3SCiwH6XMJAEbfSji8HWQj9Spfhsp2RCxl4SBSEXQGxJZ6vl2SME8k1UGerJn1RlV9zoL4i9+30WgNGnBt8FsmnNHrRhhRqSa15Fi44VgjyTxDNkdjjayhNzo3eNKo0b9nb/GkHxpxxDrI848rpuGpYQgyk/45HKyOoSSGV6klkSU0/8xcWGpEZbKgUF8lk1tO8ydRqwGt0mrBrsUpLA1SoEwWBmRo3GUoaTVipIxhuH1rkO8VFBQdoY7xKi/UvIFUD/XHvheTwSsdmF8xmLdvwXdO3uuwRAToe3t3Nree+BPa/1Tf2h8NVUEmuo5sZrO6CLoRlJsQwGiX76qm15Fyh1hlAzG+7C1f6MpF6vR3zBt4bI2yBUkVoPMjITgzBsuFYLGhYeDAusbxusa+RU0dRnHIVILjTEcR24THIFbuyHMA6Ze77pVtDG0cQOoKewz7ZxldDEJ+OHwAfsmWSB+KLVOiFO+Z8UcEgPPIacMeycDVVmdINneeMmVy5Ko6IHRVevASPw7HNoyICbpmexW2twTdVCYcQdp3HB/HGKN1apOYyGy7RLsnTfa1zRg+GvDf0UZjj7gvEUnUYrArKfeOpSIJSZwGM49OLl8ZMx7oLP+lkbp3qazrsp3Imbp6wQlB86l1KW5UNvQa662q9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qgm2MskjtqFXrQQO0wRZYSBZ1RgPzc7JJDzDIFCZIVE2A4S412eccglWR+BR?=
 =?us-ascii?Q?coaf6X53oMGSTqBo7HnBFCciTQA14w8wk3ZjqT0uacgDPpVrLErm8Lb/gWd3?=
 =?us-ascii?Q?nFUKFp1pmwxHXoTBpkMtcjCj9WhjKKePql5bfmtRPWhlGSsLqCyq2dzYwhR1?=
 =?us-ascii?Q?iW5++V8KC+pt/MSbebiA5FLQ4+T1vRPTx4ZiZq7iUQcfflE24v66/VspMKDb?=
 =?us-ascii?Q?hOL7FI3nLOZHNULGLAccqWegRmvoVsV5WZcmpHe0hgqdBGY+4+wBDn4dVL+T?=
 =?us-ascii?Q?uEmcuoTIorX63qfGBF0lL6MNCbqUDb488bxRNY5PVe+pBTbD3CS/VbsVZVhE?=
 =?us-ascii?Q?97/dAri4s8n3NJEdOk7QJeOOv8c8184ppfD5fGatbx6ihhGFPbw/BvBFasDE?=
 =?us-ascii?Q?lkRBtwpc2rRwRYvvjU7rWBDMRZj5cIqrqLssonj4WTSH49r37utZczoMy9i1?=
 =?us-ascii?Q?40TISXXe8Boq1yjx3vxyanIRCMIUOKoTIYr+LnorBvnlGTPxuhKNxPuBw7yg?=
 =?us-ascii?Q?2QTntDrbvCWWBmOmhuLl9SBm8yv1O08XP4Fd1I0W9q2gJNzd9teQiAWlHlRR?=
 =?us-ascii?Q?icXqKjYx6Z5NEWZiAfLf+DwtF+25VYd2Dk+MCYHqXgFg3oYzCIsbvya9Qloc?=
 =?us-ascii?Q?Gw5eM/MH0MstPgrk4HUSGVR1yxaPpFuEfo3/Tzj/ylhI9lZ3FJf7BdzIdfkG?=
 =?us-ascii?Q?8Y0anZgorKwNvAZlCsnJCxjTM81EY/HPFfsrY3B3XPvrt2JX7fs6HllZbYLM?=
 =?us-ascii?Q?dRTV0ZhNVnmPPd6rYaI6/ZywSGXXPmFy4IAaNRJKF0T0KUqxS8IjDAPPmYAO?=
 =?us-ascii?Q?5h4gfmeZ6qHh2Qz7KhR6wLoEBOBHzPCr0hZAebxBFO3Rk235m3B7bgtvXVXw?=
 =?us-ascii?Q?a01xcw1fhkQuPf0SF2n3botQA9xAlaeE5+KdhFrGHOgk6jNGf/ljgGiJzQxF?=
 =?us-ascii?Q?EUORoxti4d+YtmABxUAGfhkrVtedDUOlg827Ex7Bxh1EDt0cLYpWCDRgmRHf?=
 =?us-ascii?Q?1vzWuqya8Xk54FNobH7RZ/1MovXBhCnssNMbBHqX5BsgocxIXRKvOj0qSgIo?=
 =?us-ascii?Q?kbib4XDVw4jxN4qG0mlYOcgIddTqcw9zLBhLQSzP18LjVZ2CdrhbzzhDtLJ5?=
 =?us-ascii?Q?p9F+wW5QZAF2OE+YW6wOznvwvzlj7ShizPNUjSzOURZ6Et+BwJH0BPdQxkLJ?=
 =?us-ascii?Q?16+khC/x/cZIwTSy+vB1St9/Yp9ofSOvLWj1coXtq7G6cG0i0VyqEfnMniey?=
 =?us-ascii?Q?Y+OjTx8yRL16dNy5RaYRVpmwbVH2cEOBMLaBpVSNiAmk4iZPQPG6VCMHDo4u?=
 =?us-ascii?Q?KbVnXwvy4ID/eOarwBMdhaY3In7XVzXDKmebkwIRIKnAvH+OLleXfnx5YgfB?=
 =?us-ascii?Q?AB4Kd3RKSS30DVXJ3Isi30k3QXRBTKSrj0a0XHJmlZk/aoA9r0InRvbAqfMy?=
 =?us-ascii?Q?ubHJBT5Rn7Gt6a60DK1a0B53JxHzXJuFHaY3GRpJeaUtb3MliGRidmIPawnJ?=
 =?us-ascii?Q?1/Tygdp/yg7R62n2wheeE6sSIePZWh9K2T+Brf/FlA2274SuU8YIgpCZ7Ro2?=
 =?us-ascii?Q?Le8Dk8COD3iu9cvDpy7tb4ORixPzcHtI184qzQlwxRHJATJxPZ7CMlOnLarO?=
 =?us-ascii?Q?2DcooDi9L+qikCmSCRs/oKqPbIZ9HQP69mtFK5HHC8VSTJOQ+SHXTeWwwe0B?=
 =?us-ascii?Q?EoxcdsxFYsGK29jC+MQSs5mxBoRKUHCBp6VFeK4aS1gEqZARA587y7bcjdU0?=
 =?us-ascii?Q?6VPuFxp9fbb6hEMiw7ht+XkeTn5bWEQ=3D?=
X-Exchange-RoutingPolicyChecked: 1AMgQSD5WdXwK21ANRADC5IFTaDRutsjp/0rXvibQhFiscVH2sVclVF+M4tPi7O8sV9eViXepp8Kuh0USI9rQO6HSGfXr5uOHL+gj1bflVIAY+cQLOaB5+o+zJIk3di6F1xrS9AiUCEy6D8HlhRh08o2SX2dLXgn5A/LsLL4zZzzdWoRKGloM8wRX31f3ERhjG+OMvx8rrzimEoayUPfvxaWRRZaSYT3l0OUeZrYq4U+yoZ4dMwStx1RA40H5+KQ5rmkPIBZjJ7+4+sDuoR0qgIPrjsyCKtx8YFJFBl5HPitp59hAEcVzjOYG1NJenjadosA8mf9xaAxLiUgMXw9KQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8ced0d-0465-44bc-f654-08df23907482
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:59:04.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeZHJUaymvF1clSolbB6FPb2imDYLudEh59zRLnPF11fDj3uEQsmrQFPWJX29/4t2IVQR9866uBpe8cE1FunJBl8QmOGOF83bUYFiiztzUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com

We should release folios if the first entry was populated, but
loop failed before sg advanced (st->nents == 1 && sg == st->sgl).

Fixes: 957ad9a02be6 ("drm/i915/gem: Avoid iterating an empty list")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
v7:
 * No functional changes.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 645da248e25d..76836f4882d3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -205,7 +205,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	return 0;
 err_sg:
 	sg_mark_end(sg);
-	if (sg != st->sgl) {
+	if (st->nents) {
 		shmem_sg_free_table(st, mapping, false, false);
 	} else {
 		mapping_clear_unevictable(mapping);
-- 
2.34.1

