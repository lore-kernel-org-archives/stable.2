Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792512989;
	b=dAs5fVQbtWp89T+5F2xxsIPxd20SbCEwNVSNSODi4d4rMM9b2yHJmNzoPVumY8u8WAcg
	 lYO7WzzGM9drElduhdGxRKY01xhzWkU2b9vKnh4Mwe73gyKO5QQaFC9RJRa9zFLNY6QXu
	 7TUrs2CclFLjhwkK+0qLL06/Y8Ma0fZRLeW92T4g4kiNRqKqk7OCJjbxTjea/PL6w38hx
	 QOME/DQSbXLatXS1S/r0sJycyIrB0Qct21wMS3/yCziHq6lCCojff/XVktvfC2RMyAlfu
	 vc3ESja9aulu/M6cGtWihEpuJR8vGDjuWUYDWX0DKLBYfzn4uRkEnm3xYGrIqOfELGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512989;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=Hn7GdNy8+aLcKVP5ToZsjbtgipOCUF3/96DeldfHrOU=;
	b=GDweGdMoGg60lcx5rfKw4VBjYzHYTlgqs4xuyz6Z9/F3t6vv4oh33v4Qez17QGdi6gQf
	 PT/a9bEgY6BkkHPw+ixrfse9/B1L0mKYw8EPtT/0hWj+M2iuhKgw84VneCM/hN67Qr4OC
	 GMjQStB9dAGQkr1/XSRijg30P1vJPxJ0X+AflXIcafx1JOi2s593eUIKUpCmGqG4W69QK
	 gRc9EboXyZPzjaBIk+oQh8jZUnfihAoCKBqgcxrtsJuEYkLAU/SILd/vH7no5yiQTA2lN
	 d0h76ObyX26620UiY4/qwxejGyGsllrhmGIp6uZkou6MjGujvZNJuvpVNJnPgZZADaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zh3xuLy8;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B2606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zh3xuLy8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792512988; x=1824048988;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=akTQdsSJuj+7E3eycT1h3ljK4ElMktlz6W3iM7+iODo=;
  b=Zh3xuLy8IfqUBCfARmBhmsGe28o1CisE4tHgmctIALkyOQWO7i+0jk81
   Mlc2llsp5xzF9Q8wneUflXGl6JykgLcZ2FIQ1h0ncgf+1PPjn16Wu4u/w
   2KQ+qz7UuYhj7bxn79IhqcZyDWMcVglsNc6aeQfUeu1ss5DwqHP8wjZDh
   DsvAn4gZ2UzXeG6PQXQMpKT+AqpJVr41iaJpo0WMJPy2CPEprIPjhRDbh
   iqkv4LucL57gxz7/Gq5XCnYQmhEpLUINBjPb3L9zW8cHyQmQDyn2h2A4F
   +JBn29mnA20OLNBvoINSOFdeTfr6UktKWDswLQ8HKQxJqLKR8W1cOcsBM
   g==;
X-CSE-ConnectionGUID: uAah7ypLRRa5KPJWm0Nrxg==
X-CSE-MsgGUID: Ifn3HfaYTqiuAblOx6HvFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1325267"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1325267"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 09:16:27 -0700
X-CSE-ConnectionGUID: ps2awJPsQO6xE8leCCEANQ==
X-CSE-MsgGUID: 7jFRVjyMTVOCRFMz9x5tIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3265625"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 09:16:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:16:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 09:16:26 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJkI2+pvnG7WvdN/vrntbCohzLZMtdRv+JVMc3x9ve+EELdF0bApkrlYz9Leq306BTijZw2sRR3rN44+zeoJUdjDd6r92eVIGII0crAZ6ovFMAZMTc+nPT33HgWryryCXxNnWr1Ka4XWK9yc9dm643aOGriz23cGuxz4GOtnum4fQsBp0b7MNMy544XD0Dj/Iv2IYi4i46mcsi/uGLLZOUr6FR1tL52120EvkHKn2W0GzO1hv5zYkODc7zClPfM6YL0nhOcJfRRO/8Ct+moriB06e4DLYAJQ26fN38im639t2xbKoS5/L8KHPpy+beypfT4ozhwGpoCLGOxPLLUtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E857dvdDT6Xszu7IqeJ7gQr7jmfjo+ctXxqsJtdp/qU=;
 b=QTmmTMLIkk2Iu7D8wOkziwzldMXvddLZsU6bWlEF0GBRnKl7mIQGVwCVe41pL1v35550IuH1oLtjoVECf++g1Yxa0pvBBJtylnnmcFtKtqTr48QoMkYIzYSiCunQFy3HkEXrCz/Sp7VCx4pZWDuIPh6hwULSyjMe1HKoGxo8YrNG+4vsw8kclMmWMMSPmRPztKD4z+CDBk2wZu0wWpJ3IZumRnQJetmk1F/uGu4YVVFir6MyhZepvj0d+RlQIxN25na6v8Bae3eloSRAtaae6xOjqQYx8wJofcmJCqzchl4ml1VrYZP4jw0SjLoiLV486/j52N99LKe8NhiRVeWNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH8PR11MB9829.namprd11.prod.outlook.com (2603:10b6:510:3c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 16:16:24 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:16:24 +0000
Date: Tue, 20 Oct 2026 09:16:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Natalie Vock <nat@pixelcluster.dev>,
	Arun Pravin <arunpravin.paneerselvam@amd.com>,
	<dri-devel@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm, drm/xe: Don't invoke the OOM killer when
 evicting VRAM at suspend
Message-ID: <ateT1i6Pwa4h0pVN@gsse-cloud1.jf.intel.com>
References: <20261020100504.46684-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261020100504.46684-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
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
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH8PR11MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b98c7b-d489-4094-b2cd-08df2ec57c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|5023799004|261009223027099003|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: vKCe5JIHf+kUb0giKtZH/CPCTolUIyTm01a04VH3gcBI82E7uMBpxglNBMlMZOJ0nlGDRrwKR2zennsxAKKEwolNB1bg6w9Hg2R6HAHIjQayF0wZkUPAmcjzeSHIfQ69eXRMZnWRSG6144lWaytXXMg6VJQcD7qTKbq/EagxXCi6s1Z9okBby6KyhHxle+zebYuBg2fC3psaHzfnQaYKDn62EDWgZ8M7moPLjhLF/azdFcRwPjf1PnOATbRCspqTOITozvXPWvLSYh7IcmLmIw4NHwWTltl23UwJ4Y1NZbnUEWA84nEQSGrqZQbkmXOg9rCOzQYIuTwO+DeTccWbarnnEb57/DenuNCMY/PZ3IaADgA3NcyNt5I6+w0mhTA0DU6uoT2U3lZ6PlpzNk/9rZ84/WN4tx/ANWLH0U/7pNwr7A5UHQsYB2EyHV9VwxSRzcbGWzJ7/xTIUBJCljG/WuzDR0YgPo59sbMGsE60e9D/3ZC7+drhPx1oDHiWpweWCQIzn/Uzy2JP+WbZuB7l1Y/s15jA5QxB/2YDb/kk0tfZQ/XL5g35qfwrmyujdtQ5ki2xdLynVnQTMZk9sIOxSNdSha5ADKMzQAkeFR8ivuv2dgZtzrQDbWlmlOTCj08a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(5023799004)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GIN6/jdLzXTbxERleMEYi4tWvzEJvlzjuFkRNeKFkf8bSTjy8zSxA2hfRW?=
 =?iso-8859-1?Q?j64rNrwaKHB9sop0OkFHspFpwksr6wKxSLE0zL9PekUy2q7m8SUkw0+mQF?=
 =?iso-8859-1?Q?mIiulQ+g/9fsBtSuLUtqTvycO3Pen3JbLFtThS8B6n+Y7l4MCej62iS7k4?=
 =?iso-8859-1?Q?3VzPSINtWx9eUkacWPUBOvJCVBZNUXWRaWsbtoUOchPrT/+so28PK+sE/w?=
 =?iso-8859-1?Q?tfmCYDfIQ6176lzYBAa11r2DXn+b85P7ddzfTpnLkiUNptS9XOmA8wSpYW?=
 =?iso-8859-1?Q?xWfqr7YGq+z3ZkfU7hi9xLFUjew2tGzQRbk1cGGBcrx8YuzY49nudNngJN?=
 =?iso-8859-1?Q?/5pO8XWhz6I8LjbN92MGtEZjZHG7gEhPmLr8mYzDCzYUhIvnq0t8euWiw1?=
 =?iso-8859-1?Q?eS9xQ2UTj6B0E8rmG5JARDHsAWWnErEeCvpn+fOAIvAn/xRqWoySmjJVMG?=
 =?iso-8859-1?Q?YpGmkj9kjkvdf4FOg9NvCOGIwkc2X9V2CwlFanjIn6Qh6CgnpYef3+QZnA?=
 =?iso-8859-1?Q?fEsvYJUjqOcFGksabrtiEM9B/bnl6MYiNHM8sW2oZ7BO9vBYQ0otXINt9x?=
 =?iso-8859-1?Q?7RJu4Mo9l/IUbwGFmqFa8ta9+NnBhWu07B//XfpqUu8QJgK4UzQ+CVDgwO?=
 =?iso-8859-1?Q?c62o7Q7WpqWYqGfO4s6x8QtO9JyNQIjdwuXS+ANfw4u81u/vFrPcFsWx5Y?=
 =?iso-8859-1?Q?ztoPjinxph8t0cWSosTRRfC4S1cBWerZChCVDx3tMaGc/uHEtOJ3fj8gfu?=
 =?iso-8859-1?Q?i8zp7CmNApdZOF7OWM6iZRnUGvzvSnz2Saqw3A6KUbbe9ex7gYWwecBLPp?=
 =?iso-8859-1?Q?LlEcK8f/6md4aGHXsc1r8zgdbqgANoJWBGbsOrvFW8paL9AZ2aXQ2efcIy?=
 =?iso-8859-1?Q?vd1pBIjfUDvocMNRJ/erdsCqpSMWEpCzwZA4/i7YprRv6qSIzzf4JYxEuP?=
 =?iso-8859-1?Q?WVUoHo2uUSpLQS60TiPqgSNyKEbuDIrYxQkgqsHBw5zr0trWNUfNveFimN?=
 =?iso-8859-1?Q?j5h0QHVJa87xR2dOYGtlKTq8F6BC987PjQeBIo4P3WMwl9bYM0hLgtFwOS?=
 =?iso-8859-1?Q?9zwiZjn5MpLPYpOz6i5XWMOOqCWTpFMcVGBFHFM+Hz26bBARhqtZf3oOYS?=
 =?iso-8859-1?Q?I7XxEeVPAVXpO5Wk07nyv+s2y9FImaQOk0uVyXjaMw7kh+xajzViuYMIso?=
 =?iso-8859-1?Q?wumcbMYbB4WM7RJMypOXJUoKjvJes71f84xhjGa0eo+3pwHNty4Jk6f8Ly?=
 =?iso-8859-1?Q?vz5EpDXahZTj6K5emrKj7jZz5h6lM8ILEcfHcBAdqCfVN5MgABNGmVthqG?=
 =?iso-8859-1?Q?cfbvH9jIipCvrJfW3CgazvhLqVDseAF/mxOJCUbT27LEsgt0enpDP3O/kJ?=
 =?iso-8859-1?Q?YDqvk3KcA6ZtBi9wPwql9th/s0c7Mnf7CKf0WLgw3ojS8fAudLi4d3Hsep?=
 =?iso-8859-1?Q?E32MkmQfI33JwGnslZ55IiHoXFRxnKTJR+3rky9RNc8gCBK4G4zN6wGDxB?=
 =?iso-8859-1?Q?SsTfrdY7Vpi5T6gKCtsHJd4/on1v1ZW/rKWR/h9/V5z88YuRnKb8uUrBpf?=
 =?iso-8859-1?Q?xkMp+zPJTh4RiYNJ3JiTOSHp/Q8KcIgpNlXTPkdY+dQslTrh5M8rWBk3Fq?=
 =?iso-8859-1?Q?jyRilgYbd6wlSIvE3BW9bVKUdXZVWhp70B+yn0E2U6TavE1FK9hUkrmn/I?=
 =?iso-8859-1?Q?RbZZ7uLOk3HR5Xjm002Vtr3lgXDYlWcSyc0LZn3JL73tXcoBDnzKKFhGfa?=
 =?iso-8859-1?Q?AcXOk4q1spw67stXzPQa/IHuAYjfu4HqS/d+ZDi7Mpa8l9d2/d9bv1DZvJ?=
 =?iso-8859-1?Q?MirDdPBHnQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: L9hfCMotaUaMaDG0CRVIkWcmw/dEa/6eA6a0MxMfsTyb1ma8YD2TvJCDDHqer0qkLYRAaDejV+rsPWtJShAfL8mx8smrnuKPJI9t0M3j8kdhpaaNx2hJseOWdSbF4XJj9ZOw5q4Wd7Kpy52ltHB4H2xPg36qorm3s4c8oGT8xsVlbdPgE0gO5qy9NNA9t9DLKRe1fv2mqpYylT4xxQn/pNvotpIH6+suu6OM5elo1SyJ5gdbCCupC9/dI0fmUFmb4wsbPv5C+sDgX4Xx7dOEvDMQUSpW5PjBpExfUEuEECvBjQvWxZSHE9FhbbH4EHdAkWNLaiZBznj9ZyZtKJpSbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b98c7b-d489-4094-b2cd-08df2ec57c40
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:16:23.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG8AQKgJCtXOw6XpOez5nn/vlZkksJJCEVw9WBRkYQ5tMm85IVV7V7rMRUIdzx/1Jo+/Ff2guquAXGa5cL/bzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9829
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 12:05:04PM +0200, Thomas Hellström wrote:
> When evicting user BOs from VRAM at suspend time, allocating system
> memory for the eviction may currently invoke the OOM killer. Under
> memory pressure it is preferable to abort the suspend and return
> -ENOMEM rather than killing processes.
> 
> TTM's ttm_resource_manager_evict_all() uses a default operation
> context, which doesn't allow the caller to request
> __GFP_RETRY_MAYFAIL allocations. Introduce
> ttm_resource_manager_evict_all_ctx() taking a caller-supplied
> struct ttm_operation_ctx, keeping ttm_resource_manager_evict_all()
> as an exported wrapper using a default context so that existing
> users are unaffected. Also honor the ctx interruptible setting when
> waiting for the eviction fences.
> 
> Use the new function from xe_bo_evict_all_user() with
> gfp_retry_mayfail set.
> 
> Note that the PM notifier eviction is best-effort and ignores errors.
> Any remaining BOs are evicted again from the .suspend() callback,
> where an -ENOMEM might then cause the suspend to be aborted.
> 
> Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Natalie Vock <nat@pixelcluster.dev>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9615
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 37 +++++++++++++++++++++++-------
>  drivers/gpu/drm/xe/xe_bo_evict.c   |  5 +++-
>  include/drm/ttm/ttm_resource.h     |  5 ++++
>  3 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 4e6d3d658d85..5296b32a2e92 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -568,24 +568,26 @@ void ttm_resource_manager_init(struct ttm_resource_manager *man,
>  }
>  EXPORT_SYMBOL(ttm_resource_manager_init);
>  
> -/*
> - * ttm_resource_manager_evict_all
> - *
> +/**
> + * ttm_resource_manager_evict_all_ctx() - Evict all objects from a manager
>   * @bdev: device to use
>   * @man: manager to use
> + * @ctx: operation context for the eviction
>   *
>   * Evict all the objects out of a memory manager until it is empty.
>   * Part of memory manager cleanup sequence.
> + *
> + * Return: 0 on success, negative error code on failure.
>   */
> -int ttm_resource_manager_evict_all(struct ttm_device *bdev,
> -				   struct ttm_resource_manager *man)
> +int ttm_resource_manager_evict_all_ctx(struct ttm_device *bdev,
> +				       struct ttm_resource_manager *man,
> +				       struct ttm_operation_ctx *ctx)
>  {
> -	struct ttm_operation_ctx ctx = { };
>  	struct dma_fence *fence;
>  	int ret, i;
>  
>  	do {
> -		ret = ttm_bo_evict_first(bdev, man, &ctx);
> +		ret = ttm_bo_evict_first(bdev, man, ctx);
>  		cond_resched();
>  	} while (!ret);
>  
> @@ -600,7 +602,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>  		if (fence && !dma_fence_is_signaled(fence)) {
>  			dma_fence_get(fence);
>  			spin_unlock(&man->eviction_lock);
> -			ret = dma_fence_wait(fence, false);
> +			ret = dma_fence_wait(fence, ctx->interruptible);
>  			dma_fence_put(fence);
>  			if (ret)
>  				return ret;
> @@ -611,6 +613,25 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(ttm_resource_manager_evict_all_ctx);
> +
> +/**
> + * ttm_resource_manager_evict_all() - Evict all objects from a manager
> + * @bdev: device to use
> + * @man: manager to use
> + *
> + * Same as ttm_resource_manager_evict_all_ctx() using a default,
> + * non-interruptible operation context.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int ttm_resource_manager_evict_all(struct ttm_device *bdev,
> +				   struct ttm_resource_manager *man)
> +{
> +	struct ttm_operation_ctx ctx = { };
> +
> +	return ttm_resource_manager_evict_all_ctx(bdev, man, &ctx);
> +}
>  EXPORT_SYMBOL(ttm_resource_manager_evict_all);
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> index 7661fca7f278..a37316a27573 100644
> --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> @@ -114,6 +114,9 @@ void xe_bo_notifier_unprepare_all_pinned(struct xe_device *xe)
>   */
>  int xe_bo_evict_all_user(struct xe_device *xe)
>  {
> +	struct ttm_operation_ctx ctx = {
> +		.gfp_retry_mayfail = true,
> +	};
>  	struct ttm_device *bdev = &xe->ttm;
>  	u32 mem_type;
>  	int ret;
> @@ -135,7 +138,7 @@ int xe_bo_evict_all_user(struct xe_device *xe)
>  			continue;
>  
>  		if (man) {
> -			ret = ttm_resource_manager_evict_all(bdev, man);
> +			ret = ttm_resource_manager_evict_all_ctx(bdev, man, &ctx);
>  			if (ret)
>  				return ret;
>  		}
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 714c533622c2..6cf9187a12eb 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -42,6 +42,7 @@ struct dmem_cgroup_device;
>  struct dmem_cgroup_region;
>  struct drm_printer;
>  struct ttm_device;
> +struct ttm_operation_ctx;
>  struct ttm_resource_manager;
>  struct ttm_resource;
>  struct ttm_place;
> @@ -488,6 +489,10 @@ void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *man,
>  int ttm_resource_manager_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
>  				      u64 target_bytes, void *priv);
>  
> +int ttm_resource_manager_evict_all_ctx(struct ttm_device *bdev,
> +				       struct ttm_resource_manager *man,
> +				       struct ttm_operation_ctx *ctx);
> +
>  int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>  				   struct ttm_resource_manager *man);
>  
> -- 
> 2.56.0
> 
