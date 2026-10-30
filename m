Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360708;
	b=R2csUWsP7LLP5/iJzrwMxOmQP1ewYTCL6Vo27PKu1zB3JEGf/gia+UO6tlvYlAr2npwS
	 7SyVf9DTVHjXk0pqbOVtwCIO6bpGmCe5vlBXk1jO5Ecwge3XJAZQWIAtxNWEufJF0+qb9
	 ZYgbMqiPkz6A8AD8C8Qxg1l6hhDNvS+0V7EK7O6X2DKC8h54h3B8k+LCFEi+OZActEowz
	 4+eRvxO4q1hkywyKucHIZOLaK1chbZuhBzGsF/mxJDvZMBtcAets3INnl6sWL76rflm+y
	 SqxsU0Xz+R3aJoKI7SvbQJDg7kCpK9iNGR0altvUwb29QYc1mnjurvOD+LBnh5sUyrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360708;
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
	bh=XU7tyOd1a5V6d0VPnKgkSKl66qhteQPJUyRt1ZWcfMY=;
	b=H2mbXs4sdNsE0GSAX++axMqa8jrlFrc+NwJwAgHp2O1lbfSoNk14txRcple212AvRdcH
	 t1SMhDdmc+fYw0p8uY0p7syrVn39ZIe2xRIF6QSzuE6SQK83bXsTTlBfq2lgGyd4oq6he
	 kyo3mMSRB6SFDVOQbPPe2NrrUcjPa+K+4tWgknkOwmuy5N0R3P0bfkbyyLHtSRJh7/sRl
	 3KPpWuABjuF7wvQDYQXdW/ryuMqjoDZDsYUj/Fw8A+ThB3DgFwZ2/If3eQTwOOhEqMaGZ
	 WlSBepHR8CMXmzSF4KY3A8zFxyflPWyiXg/ud/WI2pEaFh0TL/3MdNTr350Vc0gtcOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Li/6lTPa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27376606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27376606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Li/6lTPa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793360707; x=1824896707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5z3b3t6psIwpyiHstHJ0tQ58HVCsB7rNWaQN2jedEKk=;
  b=Li/6lTPaR3kCj+p8LCkh7Rw5Rhxd4/fDPR3WdlHZS0UuAMRpAESvybmo
   WmAIvEhhdopvSCkHVFNQMjAtXTAqeJi6P9GtwQ3yTPnqSdJrH1tPm8rNW
   A8pVA14C23UfglBm/EpgMJzSCMaOhoSqhy0kS334hGlN5GN5vn7jrVu6X
   klLRERw/3f4oX4aYhhhkeOdWggFpwmYy4bBXYVAiO3t3g3lErQdq32eBd
   GrdoDZ8T+wv1s3RTneU7gFKp17MXucZGdLFnFRmHUwgtNIW1/eFJFDozZ
   WoL0bC+rDPuAz8wN1O1Ec8j/6lEvXNAJadTPVl/+Td9LZmWagYJeqq244
   w==;
X-CSE-ConnectionGUID: zKC/vqAKRUeiIDVDOzIiKA==
X-CSE-MsgGUID: zgZE90F9QL6KwOiDlSbxlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2113584"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2113584"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 04:45:06 -0700
X-CSE-ConnectionGUID: VgmiO/1mSTmmlu61MPBfGw==
X-CSE-MsgGUID: bdR1UP/vSsSwj+UhKSiFWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5501960"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 04:45:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 04:45:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 04:45:06 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 04:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiMMynMsNwshFmKt++avaU6MiU4OwTTpIrXJzCEhgyH2ght3FT6RC8Ll5pspCkxzKLcDIQhj47Tpu2YaYy0s0lEYhcMKdn3+KjA1Z5nrHqALvMjt9qEABtMeZORQROWxRgWaFeQxV66QQJZ3umoJptMysGm30i5ZVcr8JS+D+v6fYKZq4hz9LB499UaknMk7ih/XZvBdxTEtcmBsYaUuhY4kHDS9IuTBjJq+96g9oS14Gb/zsVqkJxW++n98pOnjyhyl1iPt3BUdGR6KfYBwDkMqmT3jYQxJP9+ly0Hpy3vHtEkMm1hvCSEwccW0Yfn4TH7aGQyWsgiYSr6jLVXkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU7tyOd1a5V6d0VPnKgkSKl66qhteQPJUyRt1ZWcfMY=;
 b=SjBPlGw+q51ljQLuSGc9qxcL0k3niADzLkb3IpT1R4usOpaDMhQEnYYblzxU9bAcfIrAibnt+ji2YMNznNCCLnkghIAQ+6rcPZpUs+j8mGSLWCCpMTv7gByDWyzaO/f38y8OYL+0ombeKt05u2k4aoPH3gomxFk8B22cKgRUE32EifhB3zrR24qN4L9tkn9NEpKu08h9TPC4qIu4QgIUcDW5QmlthYwIi5SFhFeC5muMAa3pqT/jMSPqfuFVrGSWIN0KCdpcAe5qSSilMt6nOS5zB91zMMCFUlFqrNzeBUUjLQoWjcsl5LeA3llRY0vsVdkmuZB1H5gTGMD6MpMtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by CH3PR11MB7203.namprd11.prod.outlook.com (2603:10b6:610:148::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:45:03 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:45:02 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH v2 5/6] drm/i915/mtl+: Use PHY type to identify TypeC ports in PLL ID lookup
Date: Fri, 30 Oct 2026 13:44:56 +0200
Message-ID: <20261030114456.651066-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20261029113017.618286-6-imre.deak@intel.com>
References: <20261029113017.618286-6-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0002394C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::34c) To IA3PR11MB9273.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|CH3PR11MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a89e87-2587-47d0-c3d3-08df367b3c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|261021121427099003|261021123027099003|261009223027099003|261026121527099003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: IniUcvAa+sTOrN10TxGaFAFGPS8RPfCvyikpEohRd/yj8qCa6/bHX/gIH0BY+p/fSFrhOjZ4pDAkueeTZNTAOLdvZqzTTMfuTcNAjmKLmt0TdlEVftUTMzsrm53TPnVE2xtc/FbFeR/fiGt4oBmLRCwU7yirChfFLVmIkaWiJ8OkGgc59211FMKfjr/ITRXBN6ZH2gW/ESxNklbS4vg8FZuzJIBYECzjViIOLCo/0ktDKg8faZFct5wpToaOEwRCOmFe/QOsDWeZiUco+sI91kG+nk0E0HsXOaCOWc6RtorctQJ4RxbsQlTf+kKrn2zajZvLizYYlW6b/assGkP1M/XZscjLyYcDBq6GpM+IKNfaRLeQ0eUE794gekn2Voy2k25MSMVbB0H09ZUtSsJz90JvtAP2fdOaH6asiHBwR0QcPQI8fmf1xPD4iIJUKuiCdejQW9palx8vEIvIh8g4SPCoKmAQElOONYHbZg53VytlYpEfnh3sK9XfwDNgLYwh3NpCHRhFfdkZSXEnEqnaEw39eZCJTfFtjsu4R19NIgv7BaZe7E8pMnmisfZ3s+ED+WODEcI9Iw/jXU9GQXQX97DT3jaymM4XJLFhsTVt8kIt0nlj+iggfoxplaUEI9l+Al059SO7jhLc9VFFxcjgjzWGrR4oBTI/0OHcwEuX4iE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m7GooIwXE59ljOdVMzCZjTq8AaX7+Abojw9pb7W4gog8bn0FqI/DxQ4p09v4?=
 =?us-ascii?Q?NrkTvIhKMCvcLWT0dbpoS67YgVkaryg0t4diE9jedC24zycz40jYU/qDfShG?=
 =?us-ascii?Q?caIQxzaltUp/IxjRuCL/6hdCO3taFcz8rab/6OO9/TWtt7PciAqKxlmbaXX4?=
 =?us-ascii?Q?4JudAk+SUckI8gSoTe2zXocRXgLjKvnwt+BYqZSd4gGm1SPrLpWAUVgvNcD8?=
 =?us-ascii?Q?KySvlUJi9q5UoSuOb7T+oVCLkvyIdt9SLr8sRW51BGWPN7fX3ocdhOEuq8LT?=
 =?us-ascii?Q?0PqMWokN9dqW3RHuxYXroQLi0T5F3HHb81yEshbF2tAhrvqh1WSTfvaXHMis?=
 =?us-ascii?Q?CNgqPz0N50QcYynO1WmQLMy1yV6i3ogXvrsQ7n28pfAegT6cCN8d9QWjVoot?=
 =?us-ascii?Q?ZNdW9JlY1xfHqp58RzXz0G0I6u6K+6dePqRMu1hloE2f/HzC2yILW55OqvfE?=
 =?us-ascii?Q?o0OnsF9wYtLXnpmcekMnkxYoqNZQU15ob7kjb6/mr+HL8Tc4SaFzmoyh8Bz2?=
 =?us-ascii?Q?3Rt9BCoyowDk9mg42PXQQfB6PfWx/ovjdtnqR5W14X8rEdkD4TMLw0rhWYRj?=
 =?us-ascii?Q?mYaWewXqCxMMUbQoY77aXqw+K+3b9HC5WB8OIu+oF84Ck6SS3X53+5zO/+5C?=
 =?us-ascii?Q?DprRpbWBAM63YRiN/24ALkjGMRi9bVvfy6K7mnCofh6B1eO99C4pElj/3oFX?=
 =?us-ascii?Q?4ZEloVuGZixSIj3BE1WzXxdAYAGcArvMkQIMKD3xTPZQfsQR90kBlMqqVf7T?=
 =?us-ascii?Q?Tae1mrb8uCQO5TJpTayHL9xGi+CTfwnbU4fqGD+BAYQFpsWIZ9CtQ5csdQJC?=
 =?us-ascii?Q?HWJvGnqaYbk+pu7h29YKqcoBS0VfmCjGNrvkDAPttc+7t7GHSJMooCItBtoJ?=
 =?us-ascii?Q?j2z74kfzp8gnrGe5KwYBDwuP7jLtrHWJVLzeBf1Q0IfjvfYZfB9Oa2uHIA21?=
 =?us-ascii?Q?ncn+1XbLqPEWZFjSo6fdtRGP0AxtMkO+zBXVym+bQCwy4U/My4RYuFma2o0M?=
 =?us-ascii?Q?Pfqw1239A+GK3hqJCz8frqmXI+SpxUFYHAm12Vi1jCCwgrhjdWiRkZ6Osn0Z?=
 =?us-ascii?Q?j6V3091GpV1cRvKgsV/G7yoyaLadiwIa/6wfdXif6z6mhP5D9Wmf1K1+w6xL?=
 =?us-ascii?Q?T+dxvbovCPSACXkQhFPj3xzjw4SKVa04ZqSSatayOCB0vWuCYcrqqIzqEfht?=
 =?us-ascii?Q?x0wPnDjphMjl1mEyM4greN5+I6RAL5hnxG2IJjrCiG7v+sDt42UuOMEGZEx1?=
 =?us-ascii?Q?5a45mp7QWrotVkxBhjEAOkQqgPsG5imaSRaGEi6PFTmsvrcC0pMp+uAPODFL?=
 =?us-ascii?Q?20FyYEf1Vxt+W/t077KzLx7v7IWyotFB8T7WwDmr9jv3FVGzXqbQZXxGBQkO?=
 =?us-ascii?Q?A5zU/6Xcd8P5envFkLKy+f9u13xrfsme3QhD6SIudmr/uSn8ppN7g304r3Ib?=
 =?us-ascii?Q?xuhvi8WdBRrSgC+xz+J0xNGQVMqG7dDbyL62UowoztwiqWrPRDqTZOWdhN+x?=
 =?us-ascii?Q?go8d4Gb3l78pZCUe5AGlOHz3sX2VaXd1Zc6hV1m5uD9sAKjgPGlPmEYycazv?=
 =?us-ascii?Q?R2H7n+PyRs/SSy6Qms3KxfA+tOAFzzACxTdB3iKbcoJ49Jqo00/JPlrUnLg3?=
 =?us-ascii?Q?IBWkA7uWf19fdlEJMdKiuSs0pjvCzDghcTXO/iADYA60dGtDbIugCjPfCB7K?=
 =?us-ascii?Q?zrnxJDBob1bDVbd0RkiV2u6JufZg+48pVJAktRRjkNOiC4CdJR+gcGFrc3dC?=
 =?us-ascii?Q?LSJ5PsAQpQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: TMGbRgPfRuwXURSoZkJR9IiYdzudlXmW7fRQmU/zyISyc31NU11+2qz9OlQdMGGlidP2rXQQH61sYph+mndTXyKQI4g7gKM/ZjotHf52Aovei32nO1zxqfrO5sNyLmocPGs9kQafac52ai/sj94AqkPNMBCY8HAcQyT3SH4aN6leo+mOyrt6GepOY/8Ke8je+wLLtsuUhiTy15Ewf7jF/6pQA0CqQ9LC/oh76BdSrRZjvqnlxmKEMHFm+XzAd+8kzri6fiytXG8wRgZ5PMACjk7KH7lqbqZaejCiL4fqXHVbLCO43fwcH7CAJSY8jPWIgjPdsJDmai5yPapv3egBMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a89e87-2587-47d0-c3d3-08df367b3c0d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:45:02.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: camSjrmHruFIdGIirMJ6nmyzS/ayO73A76ZhfnL2ReKWzmouH1pvX6KEwzwY7bdDc7nJZo4KCFuN4GFSBfvwOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7203
X-OriginatorOrg: intel.com

Use the PHY type to identify TypeC ports in the PLL ID lookup function.
This ensures that port B takes the TypeC path when an upcoming change
sets its PHY type to TypeC on PTL+ platforms with an eDP panel connected
to a TypeC PHY.

Keep the existing port >= PORT_TC1 case for BMG, where PORT_TC1 has a
a TypeC DDI (and so uses the TypeC DDI register addresses, has a C20 PHY
and the corresponding TC port -> PLL ID mapping), but this C20 PHY is
not a TypeC PHY (i.e. it's not controlled by the TypeC Subsystem and so
the driver doesn't need to run the TypeC PHY connect/disconnect,
power-on/power-off sequences for the PHY).

v2: Keep handling the BMG TypeC DDI but non-TypeC PHY cases. (Sashiko)

CC: stable@vger.kernel.org # 6.14+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index bfd6f0a197253..ac9d3f1102747 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -207,7 +207,8 @@ enum intel_dpll_id icl_tc_port_to_pll_id(enum tc_port tc_port)
 
 enum intel_dpll_id mtl_port_to_pll_id(struct intel_display *display, enum port port)
 {
-	if (port >= PORT_TC1)
+	if (port >= PORT_TC1 ||
+	    intel_phy_is_tc(display, intel_port_to_phy(display, port)))
 		return icl_tc_port_to_pll_id(intel_port_to_tc(display, port));
 
 	switch (port) {
-- 
2.49.1

