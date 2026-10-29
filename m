Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273450;
	b=WnEWQNiBHe+ooGJGe1CZqoINkiPatktB/8u4oFM8Ko4k67OJ6+AMRH0NKciY5CCKdB/M
	 rz/h87oyKF2g79JPXcE4qohazbk1iVyg+QUVTivNjryzcflcPYG0OS4arZDywBs6o/6jB
	 wD7xpM03t4ytp12HfDpuoAs+SezIL6LwN2vFsy2ZA6LcW7ftCpvvPuSS7SVm6YXz8nKq5
	 2mQ20IZRUbT+Ni53BIMvjO/vXBpgUXAuqUesryS88CpH/9MMXyT62Fj8Oudqwuspq+BiZ
	 s6rJ9MFK4bV8nhoeThdF8C1f+NAfFfv3XA/StgLA+A9sSbjsyoTflv3r/ES1ji7En2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273450;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:Organization:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=TmRnE+EPUOPwJwycXVQS8V0lYIwModAvtLlOxM7eWsA=;
	b=OZ4Xec8DpB6DTrhrcOXh+nVtJpTTSyBhsqCgL+ioOK80VqWsJub+Pnco1WuBcNLp9y+e
	 8BnqkX7M/s7xLmxJCnzSuJXRG87PrbbV+16GEYADzn/SCkc/myAx988s4DFTLFMKmgPuf
	 htLIhGKrZGuiqUR9t5D77T5l9suStvCTY4blGehq3Uz3YbjVfmHi0JVaGoH9p82UpSEup
	 Ls0dQtwXfO/z7FaXjGh/1s1vAxy+eHgsMns73Uk0FUTxxZCrqU1AGcPFRdNr0cgyWqmMX
	 0mR76FLlS2FtwW6TitqcA49X5Wc1ew3WW4urKhaJ7pBqpur0gWpfhuef1kaCvwVDKlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m6y50z9P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9689606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9689606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m6y50z9P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793273449; x=1824809449;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vdC4RHMFX4QyLITIIgaAdWRuj6wTGgHl0EVAKQOXznk=;
  b=m6y50z9PtBfYGKFm4qh8jZkcG0erEQLATqaL5us39G7gHx64VDlZ+7Hp
   xCOvlddUSns7LaYpt3Bnk3WEgSnHE78JANy92nSS9dx2L3eCxfcTziihO
   XzzsrRYs4mKDGT5y7MZJ/PuV/3+TGWfj5D8nRPQnEfOVmvoygehjgvQBo
   0P4SFGhsfK24qw93jla+lJJIk4XoVkD1TJBhj4S75wqkz/jlPvySv2BYZ
   na6k5sYW6ENIQ4dCYRESkMVcK5DIHxun7/YNGgV0VzHZ6ICMJ3rDaJpff
   8gde71M7z6NteTTcZYaKSvwOJ8T4LrNeilPeMRstSmOZdqlS7Wl1BZP6k
   Q==;
X-CSE-ConnectionGUID: zbxtV/rDQYO9ab2PlTwOqA==
X-CSE-MsgGUID: 2zccJ21cTsSBylQG4UeGCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2011763"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2011763"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:49 -0700
X-CSE-ConnectionGUID: d4WVlEjWT4OY8+Uqa53unw==
X-CSE-MsgGUID: 36T2TT7wSiqvvhI6YIrTBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5456773"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:30:47 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfZYWPgbQbSGjSXeC9B5pGz6zPz+Namc2+7zxciNb3T3U7MW7peILn+bW/8Wgx0B5l8vMGVN8ybHvPCoouwVaxC+ptaNXb+vzubt8nBIAJKgO2mH3W+O/tS+kBqFBjVpmPuG7+UIblsKr5Fgt4X/Wv1AaNhjuuu+BQFy2NYZIgARRmUvMv6OMPRLVySDGyZtWhKEpKXmYPZqo0m+lEab//27PcpfWaeaoWMvMCpwSTZRomnZ/Grt8kGLxkh13k0qJTHE0lL767j/xgSKvGHaCOcnU3oXCE33Q+555+OA1B4RuRzyehTnoUlqStgQEDRE6i9rSOB+2y+vP5laUgdG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmRnE+EPUOPwJwycXVQS8V0lYIwModAvtLlOxM7eWsA=;
 b=wGNZno1VtWL2LIW6SDf/h2u5kYc2G2Uk5f3ExhCHb7ML8eOrHaRfCnrDkRK3lpIdA/4lgteXjGNmKeImK9c3ksNBLvh8IgtMxA4z4jBMT6p6ggaoMrJNjXxL5Rt3Wj19C6ED43qWWbZbLIMeJ6gN8U4Wp0Rb9f962EyPuyO2kS0QyYdU+jX4BUZz9ARZ9D4UdNnp6+sqnB2nMrnV4++BftnwbdCHy7hxyGICnc3nJrY1+WYwzPWvW6TaNSl3GfLlkPZg/agWdgNLFUZRVwNbvgHCT8jrj3oT1WKrmciP80zElnh64uYNv9I5xnU0/Owlh2qNld7GzJb8Jzv5DJcecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DSWPR11MB9823.namprd11.prod.outlook.com (2603:10b6:8:4e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:30:23 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:30:23 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 0/6] drm/i915/ptl+: Fix eDP support on TypeC PHYs
Date: Thu, 29 Oct 2026 13:30:11 +0200
Message-ID: <20261029113017.618286-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
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
X-MS-Office365-Filtering-Correlation-Id: 76d369b2-d896-4469-83c7-08df35b00523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: o03sChXxpEv+32unzMV2ju4ba5QLEP0ubpqwZ/r3cuqWctKXLJA2D8CIBz9ofhdmhjltBa+dulxZZB0T+ppLKfdco2ma0jKC4IHic1evv11ueDRVHLKtJNZXnhYNxo/oPgkQ7eDnrM8JimSmE/ci2gCV0CJx8qzG4j4IzrnkIGXtwqEqaa+4lEshpI0GETMpjI4X1ZC4PfnnekJOVC0r5WIK7+kn50HGqhLYtLx5ea6yW9qz8OjMnHIeZRMn+ELafn+UEgnrSE9QKRR3GnQjW3PBnopFqK5iA4qT7DiXUz6C1PJRTb+03Pul71yVfZPJI4vMlwKhOWcpPXWFpCMnueZ33ZvL8LpCXO5jyJqL3PZTgJum5BtvRsYhaBoK8+7+hKpR9D8kPD48PPhzyKdruzIqg0DwGmXEALRuVDV2paU+xHKF3eD12qnZ4/lew7DuUFnIsg6orJ2H/5Zfl2ROq6MK0E2hr5RcPOQId0Lj9RedS8/5NMhfnX0DS3woHjxLJ6TwbHWKPqs1PMM/fh319l5dPHh59/twqSV5LdYcDpg7bsFRWCrFeaihyecCAfBSKCA1trF+ah+Ng+AzLLDmYj5fv7NBbq+tPuYQ6mansWwADnxKjdQTFTNZJCA7qNHQpeIbpLBzaf1IajX8TojQcLOCOg8xOfz0D/PsjcYH/F0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6k5MHGXTnUAlXBp+KmCICRpjbg81BMaOkYMT0cvcQtAaZRP+XY5NZzDzGSP/?=
 =?us-ascii?Q?lY/Ewh4v5dkRIdxdoA7EKH3cCBloWyJ91Sx7H2LfSqmCjA4/ifZjPGm4e+hU?=
 =?us-ascii?Q?3iAGSwzIA6gI7LKsjfFue1okCA3UqyWHPPPlAgO81ME/e2ODh/KVCvxecDz/?=
 =?us-ascii?Q?WqrIViFyn3zp+NA8d6s0L/sgYfNy/N/AHPpxMlhePEF2EGGXrwkDfvoIftRG?=
 =?us-ascii?Q?b3gp8ZyoRi4PgDJbRgo6nbx501+Ipua6zEE4Iyl8Dyn/mbooh67fvE+VVwqA?=
 =?us-ascii?Q?yrDhVeSkcTR2c1kZbJuSS4MN54HISsjhc3eCJ3kmxp6cUWLl2UwW6QvgZ/pI?=
 =?us-ascii?Q?Ucy9SahyYmcwl61WcynH3G0fBXXCnAglL7+14Ui5rq7aMtq5g/m5AedL7gK+?=
 =?us-ascii?Q?9k4dxh5mYBiSktUtwkF3NECkYwj7/4wHKIG6fnD7m2sm1sSC+RD99e01hmhn?=
 =?us-ascii?Q?vJ1RELoP6m9WuaL/F5/JTS1/p7N9Zhe5QJkLC9pt8IueWLKR3djmECyFhotv?=
 =?us-ascii?Q?fQpBCFAjAPntOhINrXtyip7y0MjTRM+kMQnxDizNYSGyq7e1oZJCbudJVrv6?=
 =?us-ascii?Q?PQrPeb5oaASob1+LftkmKXF9KzmIEFRkxMweIdiEMBWcBpYwJ2tVirQmXWhO?=
 =?us-ascii?Q?SMPHAYfzh8IXsX5VIL9SaQG7zNwA1enpz+sTUpZnPN0BLuP0M5JNHQ7zkzhF?=
 =?us-ascii?Q?c/rA8GE0v0/D4lxLQwYc94oPRAktS9twETYN+M3Ujt2yiQcnPcoXCYNNgBMj?=
 =?us-ascii?Q?I0XGZFdw1LNiZ6fUQzU/htaQOJd8YTENtukj6LSdryC8RdUElgWFZ4HB2O4M?=
 =?us-ascii?Q?HGBqvPRu+2G7Z8eJrwLgf/GroStajENN0MiL7beltpO1BETHHzHuEXwUofy2?=
 =?us-ascii?Q?UI/81fNLEgq6iGhSTYGnZPR6IILKWqP6r4lplGOpQ9Uq3HTUPhl+nzUq7oQb?=
 =?us-ascii?Q?hh01mFhAZzIyiwBXhsh4CCt9ob8/8x9PucRhRdOkKPXV5+duyKXr/aGAnxTV?=
 =?us-ascii?Q?1+u7z0D1FMoyY68T8u6TlkjwSVqWUdixIBWhoSwtIWB2Fd/ytBBywPryZW7L?=
 =?us-ascii?Q?gA8hAlyGV5XP9UcTKyU2gUFWV629vC3kC9uGyh400ux/Hr3pVp2FLbRrt9ck?=
 =?us-ascii?Q?J3IHp233/tn7+Y72ElVSImIVFAaDvbLfpLPsfBBBjvTtmB1ifUAqb7DClUAq?=
 =?us-ascii?Q?18OtivdBxkiF01zKKNSkmuLIz/TFqEYonywKvL4Mb8f3HJJ/esx0wIkkicys?=
 =?us-ascii?Q?NdU9tnR9BnBHvWQE0xr3q0Dv2jq7xyjA5qK62LUHLPE1dYPQk/cfZgjTS0zm?=
 =?us-ascii?Q?7O82kiLs8Ayqn+re2VHAW4UwpG4KMng74Dk0/HTPaKWFl2et0b9PQCGVdnO0?=
 =?us-ascii?Q?LmUa9NhRkd4U7Y7RQBmS9iuSIkdy1sbF7z/CBidcHVLiiqsLNZdo2/dzHu/R?=
 =?us-ascii?Q?6LNeXL1an4xhOjX/ip0XAH8Fytl64fFUGaqk8AAYWFVP1WuoU6F61nibbUcy?=
 =?us-ascii?Q?2LBxDtRY/LekxCoLVZklkPHuRe55WZLBXBDatRIxu3WyonBs8uYjVFFyXHvW?=
 =?us-ascii?Q?pyTkZdfjrLui5JUPmzaSPxJWdcmxf9aEzV7x3LomCralVtfT4kYBFBfaH/i2?=
 =?us-ascii?Q?M10g2uYyiZbuKxZ6Vcc/iks0CP+D8RsSza6GQEAic898U1hCpPyWWkHr9Mx3?=
 =?us-ascii?Q?yi5FJSQdYWUAk2p8EKD7TZO9i9mKQb2shPdGf/f6spiHa7y7OYJo3VhsBEcc?=
 =?us-ascii?Q?1VJ353bV7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: dMt2svbGCR6zEh30119914tY1KmDtP8y3+bBZBUn1uZmzH7Ak4h+tx8ED3Znav6C6dPriXC9FIlyh6g03skE0SafenHJ5K8qes9BRvPYYS6FW/h6PjSdy3N3SzB3igpqtBPcqL4Y2U+kEBE5DYweI6n9uApuI739IdlZbiOQTd2uOIfifk/AczL8RnUb6mlGoMISQfVLzvA3ht73cdOLaU5ieTDEjel91vBjwzoqAhEF5FHWkgmfJ7SeiwfWJRIpnwnqVTrwJhtFEjGrQHciuJVnG3jLwmldYydbr/ahaIzKr8tJ8uUKp5eirhJ5vOa6xe1Xb4f6V3J7cbEiZjLKsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d369b2-d896-4469-83c7-08df35b00523
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:30:23.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjo35A5G+Qqx+Bs7C6EsH6wE60bPk7NQrTUNea81RZic3mHHPIE044QRnVfZPLd9PRvinG1LkZYr2ZrJvYBjRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9823
X-OriginatorOrg: intel.com

This patchset fixes the PHY type and TypeC port mapping for eDP on PTL+
platforms where port B's DDI is connected to a C20 TypeC PHY.

Cc: stable@vger.kernel.org # 6.14+

Imre Deak (6):
  drm/i915/dp_aux: Take the TypeC port lock after the PPS lock
  drm/i915/pps: Hold a TypeC link reference for PPS VDD
  drm/i915/pps: Reset PPS state after TypeC port init on resume
  drm/i915/ptl+: Add TypeC HPD pin selection for port B
  drm/i915/mtl+: Use PHY type to identify TypeC ports in PLL ID lookup
  drm/i915/ptl+: Fix TypeC detection for eDP on port B

 drivers/gpu/drm/i915/display/intel_ddi.c      |  6 ++-
 drivers/gpu/drm/i915/display/intel_display.c  | 11 ++++++
 drivers/gpu/drm/i915/display/intel_dp_aux.c   | 39 +++++++++----------
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c |  2 +-
 drivers/gpu/drm/i915/display/intel_pps.c      | 14 +++++++
 drivers/gpu/drm/i915/display/intel_tc.c       |  9 ++++-
 6 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.49.1

