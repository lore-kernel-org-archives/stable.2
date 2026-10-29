Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273449;
	b=ianNADD8z7TIfoDY1Qd3CaeTyVbjb4F6DeV8Y1lCqE1M92erQlFIjhvx6qrhCDcFZvC0
	 03izqCnwoGt6edd9KmuqraLqO1Jkx/8a42N4TVUFvRQF/6UfSZWer+QKF5f2ngPjQibdN
	 xaZay2ZcrIMGXvG9rbMfSEnY+N1jU4EVrsUp0Lpncu0vssNxwo/nWyrWZmvqiqlrV3vNr
	 kJ7sceO3aIFslJGMV/WepaNurlKYT2ITSdu+vPlD66RH95BeIEk0WMYuilu3DgEs6voW9
	 f3nTdfVBUFhG85gHyC9cDNBGp/hsY0oEZaZekOUGk5xQ3lIDAxROfTML+u+91eE5yeA==
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
	bh=Fo8/48KFAJyBDXn69Dz4TV5in41me6G4MQwT2bx9qTU=;
	b=AAZzvRlLy1EVevFhZVnNTLesy8jgs/xVBm14/Hz1UFHvMRWqBkr7lH9vVjCMwCjH7X6s
	 oSQa7jjHO0jrOfj4hcJ39ijmr4qZ+fbIT/clBbI+4Eok0kIqNBcZbsq4qTOgOGmE0nMNh
	 bIwqsaeJB6DDQATwS15pfnBSkj0yqNAjLneGUTHezCY+a23FhoEa8u/tS8bLe66uNVUVk
	 MJXR36OkApTQ7Zb+1A5BremlGJK+4foodPqDlDjRL2eYy1Qz4HV1ooQMghfpQWCqIzzRH
	 Us6He0siPgjTNBLl+q7ujyp6SZ2w2YO5JMoilRxat1UhgjV056gb7YIX9meqLbThFCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YNIafYtG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D5606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YNIafYtG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793273448; x=1824809448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PvBwu7cj0mWsXiKBoLaJ2Vkrbi4v+GUsfed2Kj6JUmY=;
  b=YNIafYtG1m6kr0nVcWBW2W/Suc/0Gx9kX5FIUtEbK7LFn/ia4o0l5F0K
   PMJcFMkgOvkQTTb7+kCsS1jSCcVqJuM1Ljp5UnYOxl5eSjZpUX+EBaMrY
   KS4HDHbppQjxat3uW1hR/dAtgMV+SYTTm+faGQmKwTLYE6ESqHnxSFZ8U
   wh9sBbtJRcLTeMYIPTgGTeU/gdgw4YAsN+eCnG6t+X6RwbLO+b9kmntxG
   yHAvKJhVp4YrKmR6kXpV9lKpfvNZOBY9523z47O17X0Ti303YfxrnJ54t
   rJC3E4Yh3FgkIVT/E3MTL4w7TFlYUsj7haFuMo4QFURGknPNJDEH6DBki
   Q==;
X-CSE-ConnectionGUID: oBHtuXObRYy4FHTJEZNiAw==
X-CSE-MsgGUID: 5ocQ15KIQiuunasr5wlNPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2018069"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2018069"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:48 -0700
X-CSE-ConnectionGUID: QIZyXw6yRY+q5mPQrJby/A==
X-CSE-MsgGUID: +d7PMbylRiyxxruh0RSv6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5130215"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:30:45 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1XI4V9VIYPR2quJ89kteE9HTJ4p/bul5iNXC8RtwUoZDv4DRvnuFOfQaHfAup/ogssR8/kFSAsIxTtB/JuMw+qTg1IM4Hi1b6crykcpHvO5hW3+VMQnOrSzdJhOgwIvc7P8yU8zfDFv9j0P8KWeQpY9EyW8uD9Gdg3NPVuOximXf2Z5fmpfH/gH23uJXHSl2NV6Wm5jXoLKHKVhnxx45vwzso0tDH73alO7Y5s8S0wzMnD8GnXPRtwdJDfpAe+cI3m5Yd3MSw8zK2Rmkoee+E/cVwIb/3qOMtAxjsTpkdXCtZWK6mdUCdgtxhLUXnQWlwRztM283yE67caFFu/WUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo8/48KFAJyBDXn69Dz4TV5in41me6G4MQwT2bx9qTU=;
 b=siKnLb9wpNH3drn/SqewUKHwuMoU7gphiocPD98P3mc0WbIP6YotIGjsJZciC1IPIjAj+sIV4pdxOAd+oO26zH6BtbAqOF5FdglevfzXJnM59EZjFyeGhhKn/Ur9Vn24k6j5lz1mREBGPAWcoTvlThhrqkcuLcfspAeX9zVgX0oDKXbxccN7J+JInsGHcwwmgvQvHDf8DFE9dFYgcMKNJR+XXY5SP+iYrUMaP0t4xGYKytXseYxPHLkvvUIpI0qfOwt+N1/KQpReAaEttJMpFuwmtObAch70wqrBZgpTTvtXlGh0FWSF3Nn+OpsozaebbUZH+4NmmIsKcTiuDk04Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DSWPR11MB9823.namprd11.prod.outlook.com (2603:10b6:8:4e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:30:30 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:30:30 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 4/6] drm/i915/ptl+: Add TypeC HPD pin selection for port B
Date: Thu, 29 Oct 2026 13:30:15 +0200
Message-ID: <20261029113017.618286-5-imre.deak@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 91c9d213-8633-4ea0-cb0f-08df35b00949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ed+eslSKsiDXtvoox4SCWJ14M9IPpC7JWTtivkh9g8KSG3jfiZB4sbkNBysnqmKXbk25sXAG23/peZlU6T4hAWjIpwT9vW+uUHrQaWaKijguRgkAlwDyI+16/KZ9opRFfYYB30wOYQ4z2rJp+18IBI6c3OOUZ99fwOlL192D23USxZm7YrSSREwE1A+Jz2Zz9/mvWjY0vj958/6sPRCUnkq14J0RqE9hrOIML38PDqw2RuQBCxenBwwHemAXlgZBPkuo9z6jLZvIiY8HeZNQLWvY4qrm99NfpdfwPfbl1R3v3wiq1Ejd+gnrXzBMdbg9XfxO/b30Ztbrli9M8Se7sruHGc/8JuWlrK+9cs7huFTtdSXc8rkUElBEKWpVyi2bYZ57B/rQce2iM90qpwGRi1f4S1xEF4grH3zFsxWPWrBXEinLZbX/ZHW1+CL+sgVjWk0NgpgNLILsN4hpwQ0BNUvLh9KFS+QZ1k22pITahjQ+zO7kemU1ZAXIZtPl756ZqdYOGJfPPy6lR7z5aAX61SH+fcQCyGP1N0FdFYFv0YyLMEddaY8UAKKwsxxIzuUgMRdk1sKgqeEmxaPjtMYjb5FIST2EVGZbzOEYx5KFmm88SVR013aFJPauQ3p4/f2j+BS5EI4YLGAotKZ9REeZ1OCYCaeM+m30Ytd3i1OHVTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eNO6Wej6G+r2cMDmUH441dwnSXgU7+LQAY16R0C/2sWqOEKcW/7Mj+K6CLKA?=
 =?us-ascii?Q?k1kYvk4W+1X9I7kYVX+8jloQnKJVKxI7T1Ori6lxHu0qyrWrdYanxdEL801M?=
 =?us-ascii?Q?RDIkT4VI06LK57aQWiS38l1W+7tFk94nbEYRcWer/qAkkASzCfJklrL99xhy?=
 =?us-ascii?Q?chfdJFvkbKF+e5ye5yvKpNlhNksqhRNTlHneNxPgrusjALZy0hz+rcdYQDn7?=
 =?us-ascii?Q?ITV+Vi2If2cblJzGr8PojhIgb69JRBJ85Z3IeXyYuQ9sUyzpN8E/e+qC28KQ?=
 =?us-ascii?Q?awuFSDm54gBEX/enEZWK5JyyffTtNstNmo1s0bjvPYo6xyVF6mmvThbeYH8x?=
 =?us-ascii?Q?lucee/SlY35GWQdHsRiR5+iW5zDA9FPtDaNMSvRlq/B2oJi+bujHzBtQQqFG?=
 =?us-ascii?Q?knTWEH9a/2ObC9HCiz+V4HGdGpA0jSZ+xA1WkhMXQE9soWDpvjkt71zcY0CU?=
 =?us-ascii?Q?iaVZ2u4k4M7ezPoaisCKGezpGxDQlA3NS35hAQSrzhHqsjx2cZAlfZVpduRN?=
 =?us-ascii?Q?Fhb61SRrt2HSIbb52iOSIkp/5FwW+gsUPEmMFWAVaEhtd/jjMYR/hG50hCN5?=
 =?us-ascii?Q?SgSybKllewg2UYZ77lGvBhGBhFAnrQ/CdCbfgY0DwC58nwdYt100xS+6fKXR?=
 =?us-ascii?Q?E9RgPdSu0SWx9AqfupiwiF9KAidasBDmhPn08oeRqQ01M7RMudOdoPcqdEyv?=
 =?us-ascii?Q?R17Iya15lm+1Qrip/h7xwYSuxWwGd0MPyEV3kVh6U3EP1n7ZSDEDyPS/aWWC?=
 =?us-ascii?Q?ThTHXYT1ZeqdY2WykYiLZ/5MDtkDLoUmWj1Gnu0vWUwuEMyi8OQSKXnQCEmS?=
 =?us-ascii?Q?u+vb7F08FnhXfOJ1kHiYptss8ItgCDQJLkJYnCvmsTKlLnIgVWyIcMhy68wR?=
 =?us-ascii?Q?sbNtvWDSzZIeGwrweXFuoNAAbyxj5Yk9tfdYN8MPjE3ay7wSwmvwJOyfCG1Z?=
 =?us-ascii?Q?3YGHKnv3vgLFxffQ7FjDGArde9Ax7CwrjE8BNDNd3FNsGbc0YSwyGpcMhikp?=
 =?us-ascii?Q?EBUxYMid3b27EUViDQ/PvDzzo0t5RlGhGKYBccqJjSh9LFj8a60oSRvhf1Sh?=
 =?us-ascii?Q?UhKZxDewH+dVY8tnL5O2bulAyz/+4IqbEPz7nrtS5snA4TijetihhXn0T6G1?=
 =?us-ascii?Q?QXJoAv8HUuWckuSYdPmQJojM/nfHwC2HVNg03fNZgUy8672c9ONEU37MNXGu?=
 =?us-ascii?Q?hPGzY04kJLwG16qNelCZhCiHDl/j1r9jIDjuxClq/mOiHFClfvrP9WSF+2Ap?=
 =?us-ascii?Q?tdKnoj5QjqeaI7eEE0HXxWhMIvgNV1ASlC09A/9Jd8xTGSSl4GM7dJWvbOZA?=
 =?us-ascii?Q?X85epdLzhLm+FfTU56bUAJNS9JamI49NJ+dwourDqgm8dw0S5m8emkXemvrM?=
 =?us-ascii?Q?fSXgSO0iCL6MmBq6IzZigZXqhcNNMlbTtcYRFtpPW8hr/FR1oHo6VJpR2Fzc?=
 =?us-ascii?Q?RrBlOJl2DCIrPKmf04/sLDD8HeIFVAMlT1BPA9pU0ZHzxjJEupcDPI71IiZN?=
 =?us-ascii?Q?NZU7mndoeCeOKvakE/ffIKts+1DjV5nrglLfWNCIPa3vhvtG3BFuhttWFP3u?=
 =?us-ascii?Q?Q+afoR7vIBSjbvlgG80mOFjzWZ0GFRKa0Qe5OvfttRxOWgG45T8upFHui61x?=
 =?us-ascii?Q?8M/ylwwCvYxm4qooASY++sezgMKvdE54st/eLD0DWtbnF/cleklIQvf8skhf?=
 =?us-ascii?Q?sfi6BKbJEH5ch8ADMzT/6nz2G0FDLUfpgVtS3q7AfHOjCiQKStm+n1EbM87b?=
 =?us-ascii?Q?aClIuJ1prQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: jl/l6/kdFtJP/ewqV7YjpTVa/ksGE9pUijCQOKrhCgKW6hM5FUllL/I1O7QiP8JBg9XxIqTZoU5zBDxV77QvlgUdSc+niYDAUJT6msvTprIcl+y3P6PBRl7DP9+cJ5P8urgBE0Eba42FjpAyMmaO9IgQSU8mJL1MfDzrXVwED4T9Pl6vk9vuK0y8toOiJWRwh9GzGKnNpARoggYxZltNdRB7cSfYtpPxrdRrtzOKlEPhCqoPgn6ED6bXcfvaSLkgIt3AHiAV9JWb0aPK12w2U/Q2EEdoz1PZBQyFszdVseZpUMVgTo14y59Ok/IgNC7nhsdhknoTNZb6Z9D2L+gbpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c9d213-8633-4ea0-cb0f-08df35b00949
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:30:29.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WF/+jrWc9TShwIr2PrG4LTR7mcy74AA1gMQaTOnqBL5HpRK3s2El9jmHA3/sQRzYZ7ns3kRdhdMAyk4rVDmxTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9823
X-OriginatorOrg: intel.com

Handle the TypeC PHY on port B case while mapping the port to an HPD
pin. This prepares for an upcoming change that will set port B's PHY
type to TypeC on PTL+ platforms with an eDP panel connected to a TypeC
PHY.

Keep the existing port >= PORT_TC1 case and its HPD pin mapping for
DG2, where PORT_TC1 has a non-TypeC PHY.

CC: stable@vger.kernel.org # 6.14+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index dda95709c7c73..5950246e45a06 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -5053,6 +5053,8 @@ static enum hpd_pin xelpd_hpd_pin(struct intel_display *display, enum port port)
 		return HPD_PORT_D + port - PORT_D_XELPD;
 	else if (port >= PORT_TC1)
 		return HPD_PORT_TC1 + port - PORT_TC1;
+	else if (intel_phy_is_tc(display, intel_port_to_phy(display, port)))
+		return HPD_PORT_TC1 + intel_port_to_tc(display, port) - TC_PORT_1;
 	else
 		return HPD_PORT_A + port - PORT_A;
 }
-- 
2.49.1

