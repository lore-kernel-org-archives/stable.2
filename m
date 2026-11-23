Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795435830;
	b=uBWINZq6VviEaRM2GoNGCdtc2wn7ipHftM370HJEnIynZVkrbJsgCrkmNRXzZxIAj8cW
	 SmKjOtQ4eIwsevM0PqDy2DJau/Zbie74wGOf/ZcUVOZ2+5QER6jzmJrvubtNwYy0EKTky
	 p5+IJv0ExkXUYT2pQBFXlkVJoYC8rSyJQOOwRpzvlRkhSDkbQW5mKLyvPH/a7vk1cWFoI
	 +0xw7yVUdZhYt53BcQqktQmqhAZspPTYyasgRiv3qhFggZEtzey7C3+lkr8TbZJTJSFFw
	 y8efIP1ONw/EDbSvoSRhHX3Zqv+9nhUN1w7uBZCJG8v7HiESWNwyojdEFDbnwGwJTiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435830;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Organization:
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
	bh=uIL45Pz6uJF4541+Imw4UChdcO4Jq0bDqejEwNteMnQ=;
	b=36jA2SzmF8LSb0fmRmGgvBDWIn9lsGTg4A1xqFU+cMbV/YMNfTCJ2tpZuecNB5jsiJVN
	 F13wwKkWph+G+AqNDeZfMvbUjeF7ysPzlQU5vkw5gXs8wcopqVovyoucRTub0EguxlA6a
	 KIJgfuyxLClPbExaLx4eXTda2T4t9PmfaZGIrTFUxylqKMDs8MWofG2+tzD87MgpH0qWG
	 kZt0RJbYrmFvt3B8tFkaOEqsC7BSLLKlWoNTAWB7DchRgKnd/yyy+Jxi+a3+mGDvR8kbM
	 hDjnAGhSfWHP+AtGO13WtVcBY+LVQgZdgeXCzhenBn1UoxjoeqE4WIw8eMnvLutS9yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BC6lQqzi;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FTXQaEV1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB2606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEAB2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BC6lQqzi;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FTXQaEV1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795435830; x=1826971830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=A7vtFR7b8Q4eF9REc4I6Rn2m2OzniT8WtvEE2ZEOUyw=;
  b=BC6lQqzih8dSBVG90ZO1JiPzHhS4+VeXtDUtRblN9Ph443/uRJbErulf
   c4nUHDXZqbg5PwSfD0IpoWNN7N4UhgVZ8YNOcCRfZVQ5irpdSgGzQYtJi
   8yORzHRVuKOivlFDti0bnF7aqpu5BythuAQ75eJh9lhCKkeybdIsYW0Kn
   5YTCWO3tSCH7BsaukmQ6tXzp6+j+OXfy3tWWpFG5NU9tFChZPj6Yp29t3
   wt7QqJ3Pjw6UrHQswtIGZd2rnlqsLkUFrhovgI+dnskn73b+8aiRTjZ1f
   rtJu2R0ZfCGPWgHR7+5L3I745YKbhQA158mFmQwRUoegEmgx5/YVSLqHg
   Q==;
X-CSE-ConnectionGUID: GKq6U+eDQ6e4DPsH64p/3w==
X-CSE-MsgGUID: C/fw9YOBTUuVs1WD8tZmQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4077471"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4077471"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:10:29 -0800
X-CSE-ConnectionGUID: WHcjs1BQQQqpjyNs1cyVTQ==
X-CSE-MsgGUID: Xmkg6DJzR/WABApMoJXXzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11166538"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:10:29 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 04:10:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 04:10:28 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 04:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbLiyfe8os0XmIg4XH3HcdgPKVkgLbKwbpqjycPpnrph6VhAgebA8++9yS06L38VifZQsgwWS4kqGUf5d54J4PQxI2oQqDvsN5/bgugIBuyedBDkw6c24vAJqucZxNzNBfDEwwzPXJaTobZ2oART+FqCqkV+M5BcNQ9rZFnPq+efsLTHm16uBtZqCyh7XzN2dNh4b24Vi8wbWaF8NNsIFmdfvE5fydmsdOSVD9mTb3C8Yat/Sp2M2ZOmzJG0MVdYD4eKBG9Lr6/PxhZ7B/uskn2JVaF26I+lILpgFyZz2SpfIcwNjpwPhUffXVPRwN3OOrtMO3QHqrBAxKFgYjEAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIL45Pz6uJF4541+Imw4UChdcO4Jq0bDqejEwNteMnQ=;
 b=eRcmGqQm+DdV+n5RBMZ+/8fa7EyFN88egqZZusT6eNpImNklY/HVZAisKsyxUBLWuRvzowc1f+8iOnRfJUT/fTfAgd36Umx4hOvPeeVRVmasAyEIEhH34xLWBZdzC7nPK8q6XdiC4/eRTBsAmurUvd7Qg3U5bDLcfOkm+tHmCoZsssnFYEKSoKjs4//AF6Qdaz62xRmvm82ylWBGa+8/uaTYoT1kuhfSoM/VprN5zwXFfZ8EMXrPnTnKPRWaqlr1uZ87sWdWEzwcKMSxcTTz76l6f8nAm+zauERn9iy4JqsMk2g+SlPlbs0fPkL5C9POuHRh+7GerT2XQUvgTrEzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIL45Pz6uJF4541+Imw4UChdcO4Jq0bDqejEwNteMnQ=;
 b=FTXQaEV1e4uZXfGVS1ZhL/F2WM3WOqzzW1yhTaiIh6qqHfRauRWBK24fI4q4fq9a66YHuCVOL7lnoQYErpxf+fDIskVy1KhN9OXgkkSym09eCAaxB9T3VkEok5vJkla/1I19J+JlDhscqClCGKl6KDl7a7bMUZFi7/d9Y5o9R/c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DS4PR11MB9602.namprd11.prod.outlook.com (2603:10b6:8:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 12:10:26 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 12:10:25 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: Jani Nikula <jani.nikula@intel.com>, <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@redhat.com>, Frederik Schwan <freswa@archlinux.org>,
	<stable@vger.kernel.org>
Subject: [CI] drm/i915/dp: Fix source PHY updates for UHBR links with LTTPRs
Date: Mon, 23 Nov 2026 14:09:54 +0200
Message-ID: <20261123120954.1115838-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <avtDzWO1sOXYvxZ2@mail.tty42.de>
References: <avtDzWO1sOXYvxZ2@mail.tty42.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC05.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::267) To IA3PR11MB9273.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DS4PR11MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: c173c023-de8b-4c10-44f6-08df495ac1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|11063799006|261021123027099003|56012099006|10067099003|18002099003|22082099003|261009223027099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: qtYjqFI3JvBKg601dk1qt0a6iK8bHj5/w7upBdz1+sCCQZMTfJExSiW9Jd/W4QjT5++lPD2IxwjTtPEGf87JX3lUz8LNRhiF5Oy+Dsl7PmCMB4RXK48WC5EXh9dqEuqrVgJ/LLaBcct0kwuXI3UjRR7XUglyxUMuj+MuyWQmN0zgWRDq4wzyj9VP4XsnEb6vfMeWOZUu1ZhMjOl3JIomwC+3KYnB+hR03p7QyBP7dP1Zbu0P5r74kM9DjXwwzhRhNDteDakuzQKvnQBkjg5bDWYMGbN676Nt8w6aYXGMbS3ias8LXds2RHoYLp9RfU/uUkvMunytCMyRDgjKiZfpOFFUdgoBqQxraGgwFy10P7fOMBjuwCGPTBI1BztetTHxuR+YTcqq4OofxVIqEmXow1O6YsmIpeUQ+9ZJdpIvs5lzVJ/V4HYH4P6lkmlNwb6Z1kOEdakjX1PMNwq9Mi4nqN+nmoPReoX81AwcCMr69D2f/PjtHbWSbnjskfoRuUTSmW0BHQh5lbodTCQyaFPkLvxvC6bcpCQPfvGc6H7Mzz9yy0Cu1QqlfSlUs/qV3xxkPeHwWgupiPnAQn/515uyIQmAR+LBP7DlQuDB5kLZHM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(11063799006)(261021123027099003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jbUE1Bct1KyRvlnBJGGPjB+VeITx6om64FJyGjpSJbKFO2gjSQJC6YRhnbfM?=
 =?us-ascii?Q?BxbTbUBGz/3yL1nUj/0WlmfY0N2LGmDRd8/5m++XLl2swicgWmOjDtjaRFu/?=
 =?us-ascii?Q?9Y609eX20i8PcqqYe/xFKKyi3xJtKB4g12YZJ0QDQyTB3H+b6FtfMxTsDOFr?=
 =?us-ascii?Q?ntMx9RaD/gqD0GEqK6wjuYd/FiLMcL9qVVkI+WadEtuquXshqumKLFd/Dmao?=
 =?us-ascii?Q?Yd8vSUd90W7vQ1nl7Rm+NgGtqTbwu/Sr6aLJwYxoFSr2EFFPGlNqsIwApEDS?=
 =?us-ascii?Q?pusTudkUfRFArnBKF6ubHmuu8lEIltIAcOsU+IvN+jHoWz9fjpn61mi9UDYQ?=
 =?us-ascii?Q?bIKkGMJq8I+MHQqAwOfadIagXOV3EbiOVzfp6ICMzDMiA50TgA/USeB594QK?=
 =?us-ascii?Q?zsu36xjrleo3PvKhvOTH0pyTIGCinFP3ZZLAwcfCUpHWJVWhTlLYY2knXRQy?=
 =?us-ascii?Q?t5gAwLs5ZEiZmRiTA708ZSbrma+4zX3QclXeIibeEAfu6mbPttBST0PAohM4?=
 =?us-ascii?Q?EJ7fuFL14KHbLIIhw/3oBRJyo8Uk5KLciTIhf7V7ZKHm8wgTa73+xiAxK3hQ?=
 =?us-ascii?Q?XsdotGWmXYJhRcC+NnZybg67B0MsBBsLWWLsxH974vQweczilsytfoQ825Vu?=
 =?us-ascii?Q?5yOewSvrSJyYrxIFo2FTaeGIdOSsUuu8ul5OrfDkIaleEUZJ06FthlAmRLKF?=
 =?us-ascii?Q?CVUEXd6biNiqkPkGiNqNiuKqBEQ5bnvLpPhaPa0R9rOjQvOS4iJUcwwWl30L?=
 =?us-ascii?Q?XKfVbgl981Iz20pYDtbGEq9yasCKfdDtD3Xmaq7pZrX6ezl03Vw68zkG/Kly?=
 =?us-ascii?Q?97zMdRXG3+o8up2aSvX80z9C58dBtzDSdMAdk0VPflbOgTgRwWMufmNrnzDF?=
 =?us-ascii?Q?GX7rYqP1cgOxeG6lRsIFo2jzg8deZjtoGNHQObTTiBcAUQmCmlfU4uWzAbzz?=
 =?us-ascii?Q?k6DQk/z+HrBkoKZrQpA9hlYWuKcbCsWddiNYeYOPeognXXGU+8tLpReIn1XE?=
 =?us-ascii?Q?RwmB8mHui0mJwsKXaeHhAL6CsMIQGiRucNaq2KpnoKUxULOmY39QoS2u/uXg?=
 =?us-ascii?Q?5DJTZNCACibERo5OKvjxjzKSZANEAjEXD+XOV8Db9xG+f/QKkbYoKlnOKsJ9?=
 =?us-ascii?Q?iCwd1YsC4pPlOLL3XAh3LnvEsVurxHxDhIBc76pqgivAZg5au79/3S4T1Zhq?=
 =?us-ascii?Q?gKwBm/lgtY/QmdulZGZntCiVH4I3ifZ4kVbtR7WonTty589yYfv71DgJXKKS?=
 =?us-ascii?Q?2KNDXw6YzeqqkcmoX33gjM04Rh2yDvaTeFpVe4wSeLikYvCj2mRt7CroyAxY?=
 =?us-ascii?Q?kXPmh8EZ9xRszYksbUo9pAqHcHZ9PhWdpAHihrKGZ8bIXVEwXj8FyNfBglVu?=
 =?us-ascii?Q?Ys8DOBVShfu1zlTOy0aoIhm2nzcwsgSBAO1MMDSWTnmu1qW25bev2szZauli?=
 =?us-ascii?Q?ku+7Myw9F7kWjMnIIzihFg8/sMk/Ml+zQsYBU406gYXnrTSghnYJNtwifPVC?=
 =?us-ascii?Q?N3WFygdhNacbuaBAyz9+WDPM+1UYrq1t91MZxi4iSM9uORwzqNwdBfnQF3Qx?=
 =?us-ascii?Q?yqazpTIi5PLXYVNCrKPIMxq9mEzMsxQ9qSv0G77rkAHOdj2c7p91wqQ7VUkI?=
 =?us-ascii?Q?rXAwdAqPmxMx8r8Ug4WlZxlpJ0lBpb3sgm2pezuLxV0Jk+zIKl83YZFHmveJ?=
 =?us-ascii?Q?oarmOGpeQMNc8A6Ex1qJg2PeeGxwoepsFqDLmXApyralsGCRLEteROOmcAAF?=
 =?us-ascii?Q?2J6pS23V+Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: UyqGD53CIN6vei9pR7z1QWFNBgQBp6GPtbDaF8b89/aAgI7MsRCAlTL6iub2yUYB1NXWRFhRZGwQzWiDeRKhNGLjZbroYZWphJxTzv8niS9zmBR1Dz23wFN0IwyXd/gWNp0blF52kMYxYNpliVrwZ65fA6ONMNV4MLzgbyHE48uQKG/jWktixaAxkpMkWt00FPmVNJ/fHPOUuBV5b5If21pnkFv42c2lGIobeAxoDmL4EbpfJ91bMVArf4THF2O7VWaAyQgb91GCf17t0XjdkBhTOt8SkArPtaN7BaVBUnQZ4SrZz7pF8kqldMg33Jo19DqvgnbvgYHTHDkwAcmOOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c173c023-de8b-4c10-44f6-08df495ac1b2
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:10:25.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdS313vICVcDbepjxZ0aiTwjalKNdi5Suy77WHGCRISBvy8TC5k2crUMe2Fh52KTDXGzTUFrHf29YszdHO9TMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9602
X-OriginatorOrg: intel.com

From: Frederik Schwan <freswa@archlinux.org>

128b/132b links use LTTPR-transparent training even when LTTPRs are
present. The DPRX is trained directly in a single phase, without first
training each LTTPR PHY separately. The source must therefore program
its FFE parameters during this DPRX training phase.

The source signal-level update is currently guarded by
intel_dp_phy_is_downstream_of_source(). With LTTPRs present, this only
accepts the source-adjacent LTTPR PHY and rejects DP_PHY_DPRX. That is
appropriate for non-transparent 8b/10b training, but skips the source
FFE update during 128b/132b training. This affects legacy and DP-alt
port modes; in TBT-alt mode the Thunderbolt subsystem owns and programs
the source PHY.

Program the source signal levels for UHBR regardless of the detected
LTTPRs. Also make the per-lane capability check used by
intel_dp_get_lane_adjust_tx_ffe_preset() use the source PHY's capability
for UHBR, rather than treating the DPRX as a separately trained
receiver behind an LTTPR. Preserve the existing 8b/10b behavior.

Enabling UHBR tunneling exposed this older bug on a ThinkPad P1 Gen 8
with a ThinkPad Thunderbolt 5 Smart Dock 7500. Updating the source FFE
presets restores four-lane UHBR20 training and both DP displays.

Fixes: a421d8a99216 ("drm/i915/dp: rewrite DP 2.0 128b/132b link training based on errata")
Cc: stable@vger.kernel.org # v5.18+
Link: https://lore.kernel.org/regressions/40e2af4139b94eaeecd41fcdccb4ec1ef3dc098a@intel.com/
Assisted-by: Codex:gpt-6
Signed-off-by: Frederik Schwan <freswa@archlinux.org>
Acked-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 .../drm/i915/display/intel_dp_link_training.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index ac1aff6edf052..1efc78b329a69 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -773,11 +773,14 @@ static u8 intel_dp_phy_preemph_max(struct intel_dp *intel_dp,
 }
 
 static bool has_per_lane_signal_levels(struct intel_dp *intel_dp,
+				       const struct intel_crtc_state *crtc_state,
 				       enum drm_dp_phy dp_phy)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 
-	return !intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) ||
+	/* UHBR training always adjusts the source PHY, even with LTTPRs. */
+	return (!intel_dp_is_uhbr(crtc_state) &&
+		!intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy)) ||
 		DISPLAY_VER(display) >= 10 || display->platform.broxton;
 }
 
@@ -790,7 +793,7 @@ static u8 intel_dp_get_lane_adjust_tx_ffe_preset(struct intel_dp *intel_dp,
 {
 	u8 tx_ffe = 0;
 
-	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
+	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
 		lane = min(lane, crtc_state->lane_count - 1);
 		tx_ffe = drm_dp_get_adjust_tx_ffe_preset(link_status, lane);
 	} else {
@@ -813,7 +816,7 @@ static u8 intel_dp_get_lane_adjust_vswing_preemph(struct intel_dp *intel_dp,
 	u8 voltage_max;
 	u8 preemph_max;
 
-	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
+	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
 		lane = min(lane, crtc_state->lane_count - 1);
 
 		v = drm_dp_get_adjust_request_voltage(link_status, lane);
@@ -1021,7 +1024,12 @@ void intel_dp_set_signal_levels(struct intel_dp *intel_dp,
 		       TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
 	}
 
-	if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
+	/*
+	 * UHBR links use transparent training, so the source PHY must be
+	 * programmed during the DPRX training phase even with LTTPRs present.
+	 */
+	if (intel_dp_is_uhbr(crtc_state) ||
+	    intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
 		encoder->set_signal_levels(encoder, crtc_state);
 }
 
-- 
2.49.1

