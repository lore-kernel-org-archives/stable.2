Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273449;
	b=aJjlW32qP4DRJFT8rQ7IzScl5XIEU2EKduwMoHHGCYmKokdFZgyV3nlhe0Na+I9INfM8
	 diSbqhjmRmAXcWjFNc/+QH8RxWjgje4S2nVcJpx2I4Tz6x6gWEtxz5wrgr1J0PrQ8ukfI
	 1HduQ0+rVYvAeRDX0cFpf9RoKzJXQCoMmZ+eIo6d+kiKQUwFJPQrbS26QNjNqqvgrrIM4
	 HD7pUd90sTBDPBWk28fIYGImGiPVUtM4mYQPf06SvHdPC0jo48hXjTOZOrrXlCsHeGDEN
	 eDsMdE7jBzEruGCGClZd//wmBWnvjmj0I1++c0TLFZl/8QaHnLDBRnq50dneZT9U62w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273449;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Organization:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=guIqd9G5Y+N2zLlcXHVZoLvBf8v/FzgGzij5POha8xw=;
	b=s+oF+U7uF69ZotN2rFAVX7ZP23f1S6v8NSp3OPJs8lSZZkdOUOFHxdvzvdWdx8sn1od4
	 k/ntOJniRbSXTetODdQ+zUqjsBbwsuaEqDRbtPwiJS7mhcIN9GnVBDkReWhm4v9qyojkX
	 RGRN16ERNDFY1QjAV/PolMHdow3c3qlIkC47mRNIOtKZ5+D/w5BpnHdVLKAi2uoaiXrF7
	 kLhdSr1OUvy4qVGNe8OIxDsTUueGZQBZvNto9a/cRcBWYY8Mm72iZcPhtFP7ILz23OW4J
	 pCDUDPdSbe+qI4XSLTKpAhhSUJk5lJNsblLNGMrn7Q4FKu3CgMlgFdSJbBeL9zODeKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jxOi4Wyp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB0606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEBB0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jxOi4Wyp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793273448; x=1824809448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=N1D95aU9dGA4eWgsRp0A3ncKTjiAYbTSBAHyYMznx8o=;
  b=jxOi4WypIMplDpuj4MkU8cQnpQOn7weCDhPq8+l7jagfeBn1X9iRVx/g
   3Ho5gyGidP+l27kDj9L/HzUVHPfEXVsy3i/PPwCYqM0z+TKZcLhLkMk8e
   jkJwlNH5yLamyfFDufuWEvUapgoepMLJLS3qaAyjuE3wb/73qDCt8QRgr
   hBwb62/kNxFOnz79axiqe36UJGBgJc0Frzs9QoxiUfQ53U41ZDV6mAl0y
   8tlRTz+trZCiMsFoJy+SCfNX32vLpl+nAY1TfuXEFi3pX0mrvXlOnXp3d
   7sKev8G716GH9r5BAFsqzIJW8vx2ZrW0eu11kLUN/UnDFFfhkUS8dKZqG
   Q==;
X-CSE-ConnectionGUID: j3Nm+qv9TJmZCBZqY8yP/A==
X-CSE-MsgGUID: nJW+yqQUROeMJnNk3osXmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2018067"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2018067"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:48 -0700
X-CSE-ConnectionGUID: OUCU+r6HRr2hOnsznhAWgA==
X-CSE-MsgGUID: A3XTsHCCQ6SFbIMC9/HSdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5130216"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:30:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3ZZjHWPRUpAWpj9tQVf+32UFC9NYIlxkhenvr26kAPFu5a2JPskgsHIhjxxcMxErKPEOZyEBVEu3GJOi7RtiC6OcepNWHzs1f9AeBkcNwnH17YrMCQJH6AD4FDVaAG8PQwtKS4MEjwx8BrgA8kWwjJEKY0d3zsPUHn+UdUPW9qR4toea/22u+EQqkgjsPc81WLPPZCC8ioA33OsfqHQQgx3lDetZEVogFMBzJKb05DeHG25bmYqz3jLr/VGUJ7wMWTHtet2YolEAY4n7zOqNBXvz4vwbyK5VHJTsVweknuV85n9Z18dx2TuyifIVE+TUdBV+z0oPmxIZhSbE+sA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guIqd9G5Y+N2zLlcXHVZoLvBf8v/FzgGzij5POha8xw=;
 b=rYuuB/Iw+k+3u5IWe016oL/pyKaSE5mp8ZgsX9A5KdSRn7FYOJTGo2uY26ytJVkktM0L47FW/Rq2QkkGudQrWCM+5AaQsYulYsLzuf1oslE0FfgtINvL4NVwsJB9k8D/1IKQDbufbirryi4grDjwZ9n+dU5AfCj9dVxhjfC5V03WfBFMUUVIvimQ272VlJe41H8krvh0KF9tG3hr90grDUBaeh2Ux5ZhtnKvjZOtsTqLKmwrqWMouPonJ0r5fKMlr/Ez9Nu5fkh8JilBaAKPnsH1JxGNsSRnib+pDvCaHdxD6FTMZzNsVXDO8R1ANwGvRjB0qAgzD27+zTPK0ZWyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DSWPR11MB9823.namprd11.prod.outlook.com (2603:10b6:8:4e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:30:32 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:30:32 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 5/6] drm/i915/mtl+: Use PHY type to identify TypeC ports in PLL ID lookup
Date: Thu, 29 Oct 2026 13:30:16 +0200
Message-ID: <20261029113017.618286-6-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20261029113017.618286-1-imre.deak@intel.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC22.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::119) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DSWPR11MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 301c65ab-eb84-4a72-4329-08df35b00a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: i7LDaK3Gx7s8sKuQT3+p1bA7wgnJsiDNhwlg2L2xpVMRTJKcNPmNUi7KQGQzmktLdJVMSQCLHupVC5dFKHpV5dvXyoSjUJ/Blyi+XKcFptL6rOTn9AXanCP75KkBOhGS594faym1u0lNJkEO0/gG7sIzbRfB94S0n1AGUx8fcGc1wEGULO3/NyZ3qDL8pgMUIhxwQT6pjQuEuRB85b0+2y1tvlK502kVkQskrEUjRx4CdL9vyXwlKZp/tHR0atcbjJwn3BPW+aH35qql2D31LkgcqNhduD0q58gjE1Q8C9O55QbwSa8aSgeetM9BKePTI/jALw+VCHpQrsty/B7kDPBtr+vRC4J6DW5BZ/kBD4kp/qQM7jLQuc4sMedrsUvO4bwZsM9UhoBVbeAHoazyJe2/VqlLmlOeBR/GF7/CZCnapj6y9GaybA6Rksb55xB0AK2DDa0Nh+y89fBNP8/lK2hYL2eZg6VSIncSq1M7F9/29dQjzgfEaVgT3ozH+WWWeH2FaiyMVS+YXTGn0tceIa1gWOQDiakkoejdocewXE/IpzTTHY/7xWZr+zE12f+lX7UG2J14fSkb5LKf0sYsJ4bCpkew4D+Ycs6QasLZkzb94I2LG9ap4nKYYCt9YGlW+CbMK2pWtfYeDTkUd8azoagINj70QnzB2F38IF57iG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MnYKP4T6ByznX+pzk3p5KnDb1X6cRTcfHDg/1vLVR99gJXaruLjuf4QK/I8p?=
 =?us-ascii?Q?MaEVlWV4ChZPydwiZ83zk74+C8TLyDbMAfvTJpL97c/V3+44S3ANXXXPUX2n?=
 =?us-ascii?Q?PkAXAyAutKN8Bn41SA76VGlAXJv8K2gOuKhcOyV9hLMYc/eWXsKfwOG6z4KE?=
 =?us-ascii?Q?Gg6sBJ1sXbwZBIJ2GldgYRgBGmE+vN5B1uo+1yRkATLAr0J2v4B7njs4MLDA?=
 =?us-ascii?Q?UR93/KOPEVyO8JgxYVZf9RsvEyXBhWwqcb3mLcljQ25douc2SjbaWijOxH3K?=
 =?us-ascii?Q?qmTqqpbIa2zEvxzIMv30s5e7Tpa7AMdMmuIPd0S2q/sCleJYjFyFWAO7iXNg?=
 =?us-ascii?Q?7nuQ5PEk2Q3pg+P1D55GJXYfCUqfAnQeaCylp40DAfKH6jkxgMGaU2Qm/lUY?=
 =?us-ascii?Q?GKDzj/U0w9Ab4D8UCXFA3li2TgGCTMOh+xBVlBbRG1ioEqhUj2FxMqNv0tyb?=
 =?us-ascii?Q?2mWfAPaBz6LT7HeUx3nad6AYAEM+/OL8O2zFjV9HQ5VYrxVFJm3bukpCEmJ0?=
 =?us-ascii?Q?HW35iARnYjlYxigiEMhxoOAbZ4AsnhKGEZ3kBkF4miNAH91z240LO8cnV4P/?=
 =?us-ascii?Q?5SzUl0NUPLaW4IWzr4cnqn981+DGwRj3ve/TmIhn8797hNk9jFCXXvbxdN+p?=
 =?us-ascii?Q?KesQv6DDPpWq1LIAyZp//nXJ3V7x3Fzfneg2eahlEJso2dC7FqM+q+17Yl4K?=
 =?us-ascii?Q?SUaw78F8xT3NcPlmOyigy5OU7Tahbmg+LBH5bJyBBCksOB8G/JcurAKXR20v?=
 =?us-ascii?Q?uBeFDl/zh/jzbDG/Gi+NJviNOV3Ks4GVJc6xc0nlPHxaTgixJDr9LViQmdE+?=
 =?us-ascii?Q?7b6mUfUc2kZlY6vnqu9t1vuju3wA8W8/Th9J0FqsuG+5Szzj4z18A+9AfWcX?=
 =?us-ascii?Q?wB7/04r/Bhz0Cb5j9qTe5rGTCHVFRyhKRdi8BJdyZgJmEm24jD65CAQnyDhk?=
 =?us-ascii?Q?x1CL3A5H72bAIjK8jyLVznPfIs4b1qHLxFayif/HGf8xtaZSufYNTbPcOplF?=
 =?us-ascii?Q?xJnUWliR3PYxme/lSjf5ZW124V+7ONqmfOs2FmJMv+9PMjBtnSn6yhOQ/uuc?=
 =?us-ascii?Q?bTHSRdZrIROfjNZvCirtmZdSmfYYChbqDVKVuneOJfWcJ3+qVVUeZRy317DB?=
 =?us-ascii?Q?FaIaSzEbGO5APnnrcsi3fXRtEMdLyaJdQc1q53ViSqnKmbv4shEWDrAJtFp/?=
 =?us-ascii?Q?cbmCsiEkxJ5gAg0Dv3vsY4P/DHMx1ArPAuVS0iuvk0i+BvlWxekd/UFU+RYb?=
 =?us-ascii?Q?cIbKsRBe/q1XXhxvIivglwxPHAbPVfW2D/Yaa8d0h9u2jovOuHdphAHDk8p6?=
 =?us-ascii?Q?wBBDmempzGpRvD/W/tinUrU5HJd20ZqpMPbqzD+j3jHAl2PiTO+bd//tX6gk?=
 =?us-ascii?Q?ABJ5nRBDRcvXZFUhktCNYU2bwQs4SsyOespqCje7WcHNoB7GDBQsXGyNxx0y?=
 =?us-ascii?Q?twIZfcQrDGiP2geoHaqePGegP2fonT3Epd+52HRLI0an5KMg97zgq3crwoAQ?=
 =?us-ascii?Q?o6iclDZZnlbePbkGINs9iCPsXidYuMpXyqFQDEjvlBhipNUIfAjzK4M1CO2C?=
 =?us-ascii?Q?H5FQDic9k1Bt9SDAQGuvNlLboO2A+Rv2R2p2sHOz8LFzeXxOP0ltcwi6B0jx?=
 =?us-ascii?Q?RlNAHkmQILxwQfUjDGYxV947rb9L1TGuTNqcBnOwPwq6i+JZsJHOkWlV4QQB?=
 =?us-ascii?Q?mRwf9ybIfVkhs+j8Tf1JRwO196IXK1r19YoWP8X0yfVVQxmMhLz3r/xZYtg4?=
 =?us-ascii?Q?ernJK6qWeg=3D=3D?=
X-Exchange-RoutingPolicyChecked: MRZKd9mYf5tMZKphJELvIbwAG+kjpw5orO1GpeJTql+2YpsDRQ/WPG0LTJxm/BfRbiNEPt4DPJnIZi7Xr9nelobjvNyHNdbaE3LZHl7mzCCnI0UXmYI5zmlMXPZUQH3etzu8gAMjhcbPMW4jM6luap7dY9U/e4hy554/NvHLHTz6y5ZTudUl0fS4Bhk+Kngf7e8nbi0F3rmVpGKs7wSlEA2J+fCLjJLGBJFwxci5e+4upnj9G9ub86+noD16wg/g+CxkE0875Ar2DXSV/QMvcxSqcHMi0LGrmoyY+me+EJ3Gq3zTBjjcSUQ4T2XC610zFw5vgBk00hb4xRJEgP1psQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 301c65ab-eb84-4a72-4329-08df35b00a7c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:30:31.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URem+hi1YuA7OkaoTZlLUAMNLR5nm7doA+qRuFhzjNRo6R0agl+m20jHFcH+cXQHrZeHELF7BTWEkWTRxYd55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9823
X-OriginatorOrg: intel.com

Use the PHY type to identify TypeC ports in the PLL ID lookup function.
This ensures that port B takes the TypeC path when an upcoming change
sets its PHY type to TypeC on PTL+ platforms with an eDP panel connected
to a TypeC PHY.

CC: stable@vger.kernel.org # 6.14+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index bfd6f0a197253..563db12cf2ef3 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -207,7 +207,7 @@ enum intel_dpll_id icl_tc_port_to_pll_id(enum tc_port tc_port)
 
 enum intel_dpll_id mtl_port_to_pll_id(struct intel_display *display, enum port port)
 {
-	if (port >= PORT_TC1)
+	if (intel_phy_is_tc(display, intel_port_to_phy(display, port)))
 		return icl_tc_port_to_pll_id(intel_port_to_tc(display, port));
 
 	switch (port) {
-- 
2.49.1

