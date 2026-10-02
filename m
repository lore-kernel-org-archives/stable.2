Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E4380FFD
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 05:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919223; cv=fail; b=I9KjofuwxttU1/6IXJBtJdgZpg/AmflL1RAucjf77n5CvQBrVHBgPtZtI1fBQNich3RgeSjhtW05za1Kor5ui0NE+krhjawv8YeCZittBkZcbsBF1myP7JG25kcOY149LiwBIRzOoviK+iXh+SpAn6G7jmbX/is/W/OS6jQPKvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919223; c=relaxed/simple;
	bh=JDbSo6jQM7jOB4H3aO7jKmtb3cQDFRnwUtZ/3hwK+io=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rUAkFEiRXkIlW3Ff77/eVBHMQsHidZqG1elklL4P6QvJxbNxq6ECaeDKZoutWgBsMM3tYJE+CFyQfhcwKVYf2GLN4n1cuxzhes3YON0hrzi07FcuGCkXDSdQx09vToSX75YcxTiJnE05drSRkDWqIHBMBpNs4TnqOcOc/aKand8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zb12rzMU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zb12rzMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790919219; x=1822455219;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JDbSo6jQM7jOB4H3aO7jKmtb3cQDFRnwUtZ/3hwK+io=;
  b=Zb12rzMUy7EjI07xEVOMAgPjFiDyHaSQyUCKu03nL3BuhxXkuZ1Py7SC
   Tc8UiW8lMnPRqOz6lP9PrBhgEap3N4BMA2m7YuFjOZIyw+DpQMxCVUEJn
   oC3uWJIinRvVi2oW3fVxx3omI185QEbgtbcN0YVmC+dPyMOkIhQgH9o0F
   CGzSO0KokhxJsrgDQQak+bgs/VvZB7BRpHWluETiOC8/heSL2wGkoqphm
   dgEe5gHk1xHqvwx4wZXacjuQybRSFzD9fZoggYq0I8QQ53if6bWKqyb1Z
   KAOWOcuy+pwIaR+kD2ngfQxZcKEHrXDEo/Vtlu3OhIuXMq/U/joMrGiMs
   g==;
X-CSE-ConnectionGUID: azdRNSpSQ+SQmtmSRxjspw==
X-CSE-MsgGUID: r7OB5t+6Q/6saBmoYrOUDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90639306"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90639306"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:33:38 -0700
X-CSE-ConnectionGUID: JOPF+o1AQWe26o6GGVGS8w==
X-CSE-MsgGUID: Ik/5NK9FQbuLZGODUKx5sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="305675405"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:33:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 22:33:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 22:33:37 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 22:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LovMcdikip6QlRrEGWk7y4hKK5uWtHtySJUrZ2AWlA6Rjv09Ne0GJNSobCaylf2ZTDBkk0HEPJdM6UAL8Ach84YBdKz7AQXpiVg6h0kCXipaMtDnm74wDNV9WHMg7WbJ0JRXKSh/c36zc+pBjOnJNgPxjOa81E//EtqzzJyccN1CKgLhg93PZSSxCXkbL9UdHygTpz4pbjdbxytYaRiGQGYFlRZt6xds4M4+xniDJlR7oDdbIG2JxaAgnS6oj5ScWpyVEpG/MrV4x6e8DwZz0IsvaRaq6MUKKqw556yFarR+215KAwMgKmYNZRtQN39pN+nlgUbT84TOtYN7YbrCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub5Ho8XgCYfQ5j0k6VaCLQnCicxp2BP/SjfSOvu1h94=;
 b=XuYh+Yro4Ik4sLQH2FETchWlNS0HfDIrT5fG5Z21h4b4F2/U4bgKgmgjyu5k4REPRKGKhmRZy1piNEHItps2IUI6OHc0iK/5tAGDzJsrmg7VvMkJl3novw01+uuPTWFl9Ap6DSffiC9ABw52tZEpPbuibcc7GciD9exzPNix2BqKPDHcPkGyUHYTqw6sYZHEA9R8CysMjHOEolGWosYqm11XNMTStRk4le7dwUjLXw7cF1On25YYMGP48HVrhpOAqASBGl/foOru1TR0B2Dg4U2Ys9KlxSn8PGj0LC+x8+uBsdysKBK5IWHt3X6NgLg+OvRs8oHqA1DN30oY3HpX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 05:33:35 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 05:33:34 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <iommu@lists.linux.dev>,
	<dri-devel@lists.freedesktop.org>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] iommu/dma: Catch scatterlist length overflows
Date: Fri, 2 Oct 2026 05:33:20 +0000
Message-ID: <20261002053320.3145901-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM4PR11MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 405b074e-4a86-4e01-90a0-08df2046b3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: pNwXgeAdlEDtUpytcwLNfvBR8crB+sbj5F6up7nbLxse9QkGTz+lgF82sjohnvbJFGjn1aRGp+iHOMtHpDutChv9zgtSOPmcOxX+0waTf1uf2qQLIBEHnyJ9Jj8KvuT/FgfOknHQ2Q367vwO6etu9uWcgaYcMg0Nc0l+36zSiBTfArIgQrJc8Qo+pc3Pu1hvrovX+Ey5r0hIUW7abBpa/KNDiC2jGdXz8J5R9lWDhmQZZZmQ8ZqBrhi5k0oni1yVISjoKAh78XaYGuCtoFzbZecqrveh4hx7nfNEAKBtLYjXpUbZoQVneBW+a2TWHDzYxctIFbQOBHs1aiVJvTHJU6/eiQDdlf4U8IxeX7Ataz4dSMW4MQNpz4FFeWOH9juBnH0fXJnfGhlJ7XctHAZC3U0EZ/ZGZCXuzQS2FPaxN5OnldjSKazAMOItiIZ227jlFawZpkXRU7NfNiacs+zxkgUDX8Lu6lm0rX1nif8XRc5VNpAz5BxMcuv7kHn3Pg9DjfsF8vTE1Uj0a9MZM8gTijj0063y/dgMJHaxar0IVm7A5f0JeGv30dG5O0PKhxd8jm4MwkvnWo9J95a/NiOTRzkRVPT1Tu6nlvYW2HERr+x7jHxP50ksPL9fze7ZJRThA581jSdOAQJXvsbjJPVMdkqDPOlm4optlzaKg0/YtoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQn0uh1yuyr4Vwhm0lZnDR0VI5wHtvis6ATjsyZns5miCixKxBfk+IjM6l4t?=
 =?us-ascii?Q?rnPHGPoIkAY90YAz7dD1F4GT8cGUTBxJ21w9jbW0SZKN1oKPnrNdN1Lj9niw?=
 =?us-ascii?Q?6ZA15WDkkGMNV0PjaRfSb36r+aqkaL4Is/AXXAo1ENW6PaGCpV5qeEekjvRk?=
 =?us-ascii?Q?l/2ExRmlg2H/QXwMLeiZzrQbrOo6jtblgF29+it53ci0oyF8u1VTEOX0AJNV?=
 =?us-ascii?Q?Z4I9M8aj4UycbrQ/nmT3JT6QgkkpWulnMppI1C3y1CCMVGdnAzYyg6txqs2j?=
 =?us-ascii?Q?jLLamH/vpn2zTekV2pNbsXeJERPm3MpbKE9pszKDofkbspTTK8FrZM4WQuf3?=
 =?us-ascii?Q?6psw1dAyIHFMuRMbOLwO2PwKrHGnuAYo9kMq47fnVu7q9f+QpY44mAA1koQa?=
 =?us-ascii?Q?aZJGff0rhc6bEw7c86/MXVkezPRDclwcUkGEJTBTOvUbtXoB3/kQ2Ebcqx8p?=
 =?us-ascii?Q?itLGBlF9vXqWZjbPA2jk2HlU+9NhMn1yoEvbXc/IZDWzQbV3sXuQsYtH5WQR?=
 =?us-ascii?Q?V6B2b+NUKUiMN1u5g3wCzESHqWd2bU2uNLgOdPNU0EzMS0BlzrZi0w3iBxzS?=
 =?us-ascii?Q?JO0m62/tejFufOrWKePmm1i7zou4DA+MPUaKmoPjjTNFvk29QrHsXdtbYic2?=
 =?us-ascii?Q?jFMBrlBbJqundfb8juP0tqwIY2Fo22eD+JkT/gWeKEWyH0Z/nHpuxE+YSYiM?=
 =?us-ascii?Q?md3X+MvzrgV8xtx1Jf25dNTFoQKFVOdNggnjW4x2vY0whzl5jlm/LD0NJO4d?=
 =?us-ascii?Q?Hj0+5GPy0PCTYUWloJfMHz2txsxDe24pb9a2L5YkA8f7JKUGVPve3e9PjuOW?=
 =?us-ascii?Q?DoxzE93YKG4OuIkM9Xs79D3YoUHUPP0qAXipPwAfYetTYisUKAX5BCzHJ4qQ?=
 =?us-ascii?Q?78e+TO3KdNLUvznVqw+3bc6OIzfr9XLiMEgygpVUlXHfcC8cPMVWne1Lk12L?=
 =?us-ascii?Q?rFKhNfU87z88JgMocKiruoO31U5F1mifXfstwsB2UOVF7arLwFRTeZQU+pTl?=
 =?us-ascii?Q?UdKeyCTgH/WHzYvql9xbtesf3IlQw1CAugkRgm5VTAQoUDxUOPmqFQAW/Oc5?=
 =?us-ascii?Q?hPMHsiqaUVTOlcCdOG+qChGSm0vL6qPCrFP4182Wcb+IpwdjyaXvkTHC+Vir?=
 =?us-ascii?Q?71P3WzQtbYlDBt7BDZUYj+QTR9ujEOjqMNroCfM7CQGuwobytCItsWQgvd5W?=
 =?us-ascii?Q?MaDaCGajh5J9bL1uW5lh3fe+yug2hTL6PyBkcZ8HnbvDwLoiLrY0YAPPwFZQ?=
 =?us-ascii?Q?xVip3CBieRcznOX3rQa8mtksItbtczmTArQN1KYs9AFTkf1voas72C507UuH?=
 =?us-ascii?Q?Z211ZoShPmHmOQaKZwx3F3sM8lK0tduHvxhfa43amiw3qxgTKFkmC0Yo5Y7G?=
 =?us-ascii?Q?oDKA2OvobQlbDQt/yBHCeKne0NgyAg8D3SpUgJRiTNzZJAp0nQUurbUeUFSx?=
 =?us-ascii?Q?zO5KLmgj9s0N1856xzXz6hmaSQAxzTMC/VYZsViLPCYtpVpK+MGHheDpHB3B?=
 =?us-ascii?Q?JzFV8mILV6QTslW7a42dqwBEJXhMIxRVRpM0rTWf5ZdHJRD64wy2JJG5+oF2?=
 =?us-ascii?Q?dK9E2p7s3xcXl1utLkR61pFQCAXC7MqR5QN0qHKMowIL5gGBjkxuOtM9O2sB?=
 =?us-ascii?Q?LEqdLcetAwFCsBU99Q1MF548eXVz/9RKUwnHTWzQCLpjgatgfA8WCKQX5DhN?=
 =?us-ascii?Q?+Bwc/KQaklz6otvLddVyoAKZQ+OwLE89JK4w0vU7LBsgtLJH7fvuixF2ObYH?=
 =?us-ascii?Q?OY29HUHYy+zo/O7+Ym2Kk3GnFxx+XCA=3D?=
X-Exchange-RoutingPolicyChecked: ez4KCc8J7lettFUdTf86lM1YSLrVFIlHaSIC55+UYyxTcNBpAet+9SWOsI/NMZV3HdP+rcwoDOjXheiZXRmcHRGVtRse4VhnlmpvjHuRdgMX40XaMiTuSnzug84wVEdTmXzsxeFCs4ubI0zRk+MJSDo7Fzv+xGVM/F/G8aXCfMUMkF2K9drSdG7IYJG52XVF7D7WZ28sVRUE6b9did9whd0DOR1OtFBHY0aCjGZ1oyQ5VVZ/Ia4YZgt0rQEPA6VotrJM4bIaCsUjxuCmXibwwRykQJzQNZlMhff6kLuPDFxsAG6V/+5c6RVVCYtM/3kiEaf0bLOUGxnBayB6FsJlmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b074e-4a86-4e01-90a0-08df2046b3d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 05:33:34.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MjqhDRCVMzcAnYWonaBYYMpGgQCy0/1SPlFeO+JLVLpOz96+08BJGEWwr9BlNyYj1gSz3P1+iQdrWPwj7JhVoSFhRPzdoSq+kntKsVX+do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com

It is possible, when a very large mapping uses only one
scatterlist, that padding overflows scatterlist's length field.
This results in:
 1) silently wrapping the value
 2) smaller than desired mappings produced by iommu_map_sg
 3) leaving mapped bytes in memory (no iommu_unmap)

Address this issue by adding overflow detection for scatterlist
length field.

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
This patch was previously part of "drivers: Improve memory
management for large object allocations when i915/shmem is used
with iommu" series, but was extracted and posted separately on
request of one of the reviewers (Andi Shyti). There have been no
functional changes since last version.

this version:
 * Added separating blank lines (Andi);
 * Added IOMMU maintainers suggested by get_maintainer.pl
   script to CC (Andi);

 drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd43..06edb4056dc1b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1477,6 +1477,11 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
+		if (overflows_type(s_length, s->length)) {
+			ret = -EOVERFLOW;
+
+			goto out_restore_sg;
+		}
 		s->length = s_length;
 
 		/*
@@ -1493,7 +1498,20 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 *   time through here (i.e. before it has a meaningful value).
 		 */
 		if (pad_len && pad_len < s_length - 1) {
-			prev->length += pad_len;
+			unsigned int new_prev_len;
+
+			/*
+			 * For large mappings spanning multiple GBs we
+			 * may not be able to fit all needed padding into
+			 * sg->length.
+			 */
+			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
+				ret = -EOVERFLOW;
+
+				goto out_restore_sg;
+			}
+
+			prev->length = new_prev_len;
 			iova_len += pad_len;
 		}
 
-- 
2.34.1

