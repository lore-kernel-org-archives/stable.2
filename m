Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DD3B2FCD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280749; cv=fail; b=lYDVknZSMEn2CjtgljYtMj+J3nNacLyIAMJDcb/C9ccQjx3gcrr118wSNhf2BduQHu2ajtinLvTPd0F1+8d2R8al/ZjZ83QqrPPh/RE7Bv2qPtXxwCd3f6ml6gW+adG90omR7XmWsrjHSkJD0nNXfM51QHBLfChtUvjLXKsfOV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280749; c=relaxed/simple;
	bh=yPobatKZfcEul/FLZ3X8OlLEcLCU6zfmKTt5VYpQYEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZAFTTpxbbWVjcdLzUVVC8u6+DBXKrGyAXB8cS7sMjS6fJhJQiN0+hHO9qsZ/+L9FwyPa4NxSJLa782b88lejqTDpwrPTEyjfrJP1NpN6jZAZoJZxq1IaxB3lL9mNKB+6F4noz4siAsmkHFqGw0tqxloN71xDOvodWyEr1cpTWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOUW3IEO; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOUW3IEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791280748; x=1822816748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yPobatKZfcEul/FLZ3X8OlLEcLCU6zfmKTt5VYpQYEA=;
  b=lOUW3IEOY3DCY0K4EEzANqMDKVib+t/GyzsAe1qeEyOjozxG9OFfA8d3
   KKw0hUA5mVOB7GTDWqj6xOW+YYBYhaKfiNEc0mCCxdvftLj1zwTIAMT5B
   /hhBa3wK2SWHIxaTKdMGp65Ixh40dJnuMU08iQKRstwdAXlDSuqAFgrXh
   ANIYl+DihOArK1V7mhkzqhFUsHwcGbbz4+I4cDCzHcj4KNpOrWNEGfF3x
   Z6ZJJlReO+gAXKiHTZeLJ73ZaIK3GLnkMDL9JKbvaWL4ID1ONNiR4Y5Nt
   6hNTZWxlxVd+M1lza0Ij2NcfblFTKkejCDBa98JgMw2y+i3aVt78kS/qx
   A==;
X-CSE-ConnectionGUID: TmBA1RkHSl6TGfjcU6MKww==
X-CSE-MsgGUID: PVU+NjYlSS+Cp32gRLf0nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="16112"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="16112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 02:59:07 -0700
X-CSE-ConnectionGUID: t6mKirgYQDeTlCVz/8zsfA==
X-CSE-MsgGUID: 8YX9nuNSRUm0q42v3V2vKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="306590849"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 02:59:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:59:06 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHRmicT0cJdJZCZzUc/V58nJgLPLkBMRAuTfAnBGgUtUV6F7bIsuCnM53BLE6u+Vp8uJJVo9+DSkTc5QUY2pzatZ0IM1PuoorgOLQMDdnLGJl0/7KB2qjo/qf+wJg6e2lSM6CuUUtGDw3w3Uz2Cf2+eZ1sPnHKjVpDEo6eTCSGqDreycGNgGqF5BefB77fFN0rgMBMM5PnBRMzXZHHvYjpFSZGMggw0vQQd4/AyXguC7w5uOyfZ/Ze8BFEB/Uv5AjzOuS4NDKV5NDQXPRcNfj73kJ8MKnHuGKegSaK15fj8v7Og5slswS2MPMCGtvGjjG9eVgSO4aywdAl84qePMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lu0qyfHQmNDJ9VziDEzRJ2X+z5Tl0DGESJOhQu9sUE=;
 b=S03zcLxsVpc498BR0aJL69f/IQlrQOVW5GGmWL+s7uubkuywij00r91ZlNMZ6VplK9uGeRTxrSqnNIUQP/umdGoOTeAQA64zeFLQ795sd9LBnj/IJ2va8movM6G8c+ADngXpK+W+C27vsO2ejfj/Z6wlpfCOb2NM56dnKha6dmPz9B6YTZDCeZWpoQumfzY/Y1bgloI/C7/xlsJQSoXtOkhVqjhsPKAW7q9RgFNWcJpCIF9Bb5UBfFx3DZAVqeOFfXezDW8FqDJWJTc3iDQLTrYNKXkXFLLtouPI3VGD2tLPBkKe3/CUzJFi0GOqQ3ukKeerlUGcILbyteROw2GDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 09:59:02 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 09:59:02 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
	<michal.grzelak@intel.com>, Janusz Krzysztofik
	<janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v7 2/6] drm/i915/gem: Count mapped pages in a folio
Date: Tue, 6 Oct 2026 09:58:41 +0000
Message-ID: <20261006095845.451212-3-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05321ad0-eb6a-419f-e5a0-08df23907339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1C+UkA5n8ee4ehmv90qQafhx1mKWyMuaFgevQ+yW1JtAOPW586Gs0iEdUHUO6l8eCx3jJ5mcedQumV0es5K9ElHUy633It3/0GhPb1X8D1cyCNLju2B90bhN9iZZe9f8iMWX1dUoH/wNUbc2gEuhvithlKBDA5IGsoIxVTcUifgMcdiXW5JYCqTGK0OhkmtCMhTokK38WVA3u4yLN89i7TSq0wEOOp1Bcqu7cDWeHI1Vn34t/Q53DrNizH3w6tlEd2LXb8/pqbYvtBdPbHmxhJB/c82M56NO59TrL8kALeZ/NzK5fgYNCklAN5gUBPYlVIho9+oYnW4X23k+CV2fqarxXBEUWSJanDOAjd5/Ls0KIg7/7Qv7ajZL51yGygZDOTrh/fAtra4VaQ4hsro3v/9FzXcvMWECvBsJvoaKFVsp4LjyYXFHXnSmR3FnZMJBsKSZY3wrbB9i0uH+pmAqehF2kWBQ9fWKUqhy79Dwa2OiN1yw7Ql2g+5jR31wN3VH4OTZKRIAQa35p9Cf40E0QjFoIde7GkCS22wri8/ot/1iDBxFEeYUx7v6ydwq1whslKmq6bWxY0PSz0ohY6Q1f9/jptmu8az8sOAe+qY+DtxJZKWS2InxbDie44MDoM29
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0CqT0UJQwISGl6jwi/zJOG7RRRfjYbOnLRJhz46wWsLlztzkhUkv2yzgsqH?=
 =?us-ascii?Q?S0+TAwgzWeg8PcbcqvDWB9Oj3Z/Z9bc/1iTGM+jmb4DVQ2n0+9+YY5X+suXb?=
 =?us-ascii?Q?G4PSdG86FP0/jlJG3EvTxGCxaGS31V8/N7f5Z/mBSjJnkpcXgJsyKfV62fBM?=
 =?us-ascii?Q?siMCi+Jpf7YEkw8O7KhzvO4Q8UNh+CVn/eaMc/mjL61EIdiDoOW8Dqre3+Ow?=
 =?us-ascii?Q?5kcLd8hh6HI/xLTZ68kWh7hacMRDrjZTXyM0SN36wL5QaJH6wFmbk3yFDUJX?=
 =?us-ascii?Q?kceGC5ovJTB3WGvd7AprogF0vqJK+gNzP4CpmFefTPj4BwllBue/djBVokXs?=
 =?us-ascii?Q?TFSGg5iIBFU6Mh2nu7Zspksh5T1eqZITMInGhjJwebbTFyN4ezKjv+yFtvYV?=
 =?us-ascii?Q?sm2PMg5zpRack6hpjT1BAW3R5PG9hEbcF7bgW3foTxeBEpPTONFHS19McCKq?=
 =?us-ascii?Q?g2QiSTkj2rfQR7QzKsrH5uyR7NVhbao5MHNvcR4k/5eh2sjM+qh2tbUvG3cz?=
 =?us-ascii?Q?83YEKFoWUb6JxhsspyMHb2c/EjtivfrXmHd83X6QYWoXEy/XbhOItloZkim0?=
 =?us-ascii?Q?MyEJTNHvjyAlpUx+NECgGG/KCQ4sCERx1nRMYDq+aMZu2Rb1kGZbduTva6IN?=
 =?us-ascii?Q?yLP0novVoDu73GMysDTRmMp9al969jIVJLHzMwZ4IKHU948lxdB4iRwCVezd?=
 =?us-ascii?Q?KYaImnc2TW7uFuf/8qu3kM6tZ72Yqn14gLugrgrLVx4CxmVg4G9FHjH2K2Yi?=
 =?us-ascii?Q?4rgyBj7Qvp4RNk37detP4YTWzNL8l6OJg0HXr9DnnyfN1lbaqJZfveaGSraU?=
 =?us-ascii?Q?NmeYYqXt7VF36aKsTORkmBZlTD5JjFh8gJ70yeLuKn6dg1wvxHdk01k3AI9M?=
 =?us-ascii?Q?/7+wnb3/m5+tWyK5o82TjqMFqz6c+CI+uL1GDG5Z9/K+QjlxaeTR1Ooc/+Vu?=
 =?us-ascii?Q?3LK6hDL4vRldC9sPB0PGrWwQiC324ni9ecCJCx63FiqoW78LsxW2003iCWPq?=
 =?us-ascii?Q?/qI6A/k29I9Xv5/lj3mw8vWnRxVsxBfCXvXFD5msZthheLV5Kek+GzLxo0Tz?=
 =?us-ascii?Q?zJOZxkY98UOVeumlRReqcWi1hlwnml9zcq9oXIUMdloPgWjH44ypJ4dL/I1q?=
 =?us-ascii?Q?b/en2nr5eN6UhuY6qwovFkhtuLx/n9BlnOBb7XwAVoqqPeoLvbSWQeWiB4m/?=
 =?us-ascii?Q?K/TMCFtVKW3/ZKlJwSzlX4C0OJc1XzdYD0eMMUV55ncRT+Exz0GIj/RTdQlm?=
 =?us-ascii?Q?GHEIUs2ur+jwQZggAcFz/8WgKwjq0oSFNBsafxFjd+jMO61KpZU4qUb/eWnV?=
 =?us-ascii?Q?s2yCmYqx1btzGdMiTAxEmSDxRAhr6LoJ5BB0ZJYgkyW/rFz2NJuKGHcWr+n9?=
 =?us-ascii?Q?knGGJ58zyrieA8EhARs+n0WT99EeOc8WKdMvzzmgwOZzj2Ij8DBGYG03om+Z?=
 =?us-ascii?Q?rLKfkfbdLwXIIwAQLA3cToTLhvBqR6AJ8kc5JiQoK5PH9SmPkNnQHVoyxkkV?=
 =?us-ascii?Q?B8mkur9+RVD4q75XqScKyKxCeZ6dhT/USGud9qLtwdMqCU0DJeD0XOE2s8to?=
 =?us-ascii?Q?k00KbwLY/T4RqOq9qI6M4bcEXVXH8cKecVqodBkmZJxC/hfPB7o9msFHc74+?=
 =?us-ascii?Q?aEP0zeDVVD3zwlQdsj0QTM6fytazpe/6H8jzoOPl8HftZ7Z3X0oewbsrDq+J?=
 =?us-ascii?Q?uXSbNTtTs0PpjF7nJpZSEvveELAMTMOkg2DBpi8G8NxFd8pxVP+UkIX7BX5/?=
 =?us-ascii?Q?wP32CiNiuAwQoTNtd4cgjpYNKFrj97c=3D?=
X-Exchange-RoutingPolicyChecked: 4tDFyMaz1hzZdw06/P9KquYsK4jRKZ0SjjE1R3pEj4O4a2mzOlfC+Zhato2iGjtzMPzgOeczcdHfZJdyCVVI9rL+Laxv+qPMFQMRHx25kWEE2iC6a43sC1UE9NouUeFBPcLPjz3BPFLmb0BP8/0482Xh60Z2GKk/HEe3fQuFLDynvdhaV56qaV/DP4pG3STyVROTn1bJPF1AEQFAeFEtDu1/m4RwbravuNWau4iXIEWBUbHl62o3f4pQuD09qXqmGsEXo0/cKfv0miI9INMzSewuidpoXf8nglssPgkg1RwgrfNhUdxr/ASYePqHLOXY5gTCoahDikV388WYH1JQuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05321ad0-eb6a-419f-e5a0-08df23907339
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:59:02.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aamei8CxoItqV76SeAuqb2DO8YewTCGGrl7GylWKlheWZPIa0weF7XatQ7phbOvZxoioga4niweHFqYEtsaJsJoOk+qhrFO2LHktp5u0Vao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com

Before addition of commit 029ae067431a
("drm/i915: Fix potential overflow of shmem scatterlist length")
and after folios were introduced complete folios were always
allocated, possibly overloading the scatterlist capacity which
was never truly limited to PAGE_SIZE when requested via
max_segment. The above commit addressed scatterlist overloading,
but unintentionally disabled PAGE_SIZE as a valid max_segment
value and failed to take care of remaining pages from folios
above max_segment boundary.
This created a state, where multitude of scatterlists were used
for the same folio, but never counting enough of its pages to
jump to the next folio.

Furthermore, current do-while loop goes over the same folio
multiple times, increasing the refcount each time, and breaks
get/put symmetry: many shmem_read_folio_gfp() gets and only one
put in i915_gem_object_put_pages_shmem() per folio.

Track how many pages have already been counted in a folio and
use that number as an offset on consecutive allocations from the
same folio to ensure it is fully covered before reading next
folio.

Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterlist length")
Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v7:
 * Derive the page offset within the current folio from
   next_pfn. (Janusz)
 * Update next_pfn using that offset and clarify its role in
   merging contiguous physical pages. (Andi)

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 108 +++++++++++++---------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index e35ee4bd456f..645da248e25d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -70,7 +70,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	unsigned int page_count; /* restricted by sg_alloc_table */
 	unsigned long i;
 	struct scatterlist *sg;
-	unsigned long next_pfn = 0;	/* suppress gcc warning */
+	/* suppress gcc warnings */
+	unsigned long next_pfn = 0;
+	struct folio *folio;
 	gfp_t noreclaim;
 	int ret;
 
@@ -104,7 +106,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	sg = st->sgl;
 	st->nents = 0;
 	for (i = 0; i < page_count; i++) {
-		struct folio *folio;
+		unsigned long folio_page_index;
 		unsigned long nr_pages;
 		const unsigned int shrink[] = {
 			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
@@ -112,51 +114,61 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
-		do {
-			cond_resched();
-			folio = shmem_read_folio_gfp(mapping, i, gfp);
-			if (!IS_ERR(folio))
-				break;
-
-			if (!*s) {
-				ret = PTR_ERR(folio);
-				goto err_sg;
-			}
-
-			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
-
-			/*
-			 * We've tried hard to allocate the memory by reaping
-			 * our own buffer, now let the real VM do its job and
-			 * go down in flames if truly OOM.
-			 *
-			 * However, since graphics tend to be disposable,
-			 * defer the oom here by reporting the ENOMEM back
-			 * to userspace.
-			 */
-			if (!*s) {
-				/* reclaim and warn, but no oom */
-				gfp = mapping_gfp_mask(mapping);
+		if (!i || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
+			/* Grab the next folio if we exhausted the current one. */
+			do {
+				cond_resched();
+				folio = shmem_read_folio_gfp(mapping, i, gfp);
+				folio_page_index = 0;
+				if (!IS_ERR(folio))
+					break;
+
+				if (!*s) {
+					ret = PTR_ERR(folio);
+					goto err_sg;
+				}
+
+				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
 
 				/*
-				 * Our bo are always dirty and so we require
-				 * kswapd to reclaim our pages (direct reclaim
-				 * does not effectively begin pageout of our
-				 * buffers on its own). However, direct reclaim
-				 * only waits for kswapd when under allocation
-				 * congestion. So as a result __GFP_RECLAIM is
-				 * unreliable and fails to actually reclaim our
-				 * dirty pages -- unless you try over and over
-				 * again with !__GFP_NORETRY. However, we still
-				 * want to fail this allocation rather than
-				 * trigger the out-of-memory killer and for
-				 * this we want __GFP_RETRY_MAYFAIL.
+				 * We've tried hard to allocate the memory by reaping
+				 * our own buffer, now let the real VM do its job and
+				 * go down in flames if truly OOM.
+				 *
+				 * However, since graphics tend to be disposable,
+				 * defer the oom here by reporting the ENOMEM back
+				 * to userspace.
 				 */
-				gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-			}
-		} while (1);
+				if (!*s) {
+					/* reclaim and warn, but no oom */
+					gfp = mapping_gfp_mask(mapping);
+
+					/*
+					 * Our bo are always dirty and so we require
+					 * kswapd to reclaim our pages (direct reclaim
+					 * does not effectively begin pageout of our
+					 * buffers on its own). However, direct reclaim
+					 * only waits for kswapd when under allocation
+					 * congestion. So as a result __GFP_RECLAIM is
+					 * unreliable and fails to actually reclaim our
+					 * dirty pages -- unless you try over and over
+					 * again with !__GFP_NORETRY. However, we still
+					 * want to fail this allocation rather than
+					 * trigger the out-of-memory killer and for
+					 * this we want __GFP_RETRY_MAYFAIL.
+					 */
+					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+				}
+			} while (1);
+		} else {
+			/*
+			 * Otherwise, we are still inside the same folio,
+			 * so just update its page index.
+			 */
+			folio_page_index = next_pfn - folio_pfn(folio);
+		}
 
-		nr_pages = min3(folio_nr_pages(folio),
+		nr_pages = min3(folio_nr_pages(folio) - folio_page_index,
 				page_count - i, max_segment / PAGE_SIZE);
 
 		if (!i ||
@@ -166,13 +178,19 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 				sg = sg_next(sg);
 
 			st->nents++;
-			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
+			sg_set_page(sg, folio_page(folio, folio_page_index),
+				    nr_pages * PAGE_SIZE, 0);
 		} else {
 			nr_pages = min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
 
 			sg->length += nr_pages * PAGE_SIZE;
 		}
-		next_pfn = folio_pfn(folio) + nr_pages;
+
+		/*
+		 * Store the next PFN, so contiguous physical pages
+		 * can be merged into the same SG entry.
+		 */
+		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
 		i += nr_pages - 1;
 
 		/* Check that the i965g/gm workaround works. */
-- 
2.34.1

