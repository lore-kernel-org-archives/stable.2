Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793361771;
	b=iKdY+FwZr/uflGY2ON763uscFKttEW6LSuHX43QAFZsT1KbOSjOGkLMhMHEpF00Mo4RB
	 8c56tAIus/2disGL7HiR4NWQ9rSOMfv/O4e1fYLPEgYTzU6UQix9OyLxpj2FA9iVBiG0Q
	 xx7DLeMFOY02mzz9ASf156tP9wYC354+aVULXjqaJQeL9ymubZYPqSzPU0qa5M+XwoU1K
	 RWNHa+ZoVbpo12AjLkpzHB3tmgasld6IZ+B06zzhHhXmb+o24Bnsz3FjhiGkUw+jS5XsQ
	 +5LOqEN9yAFDUTviZT54JNLIpj6i6EAsIUkO4RMNHX3vmydrN08XoVTu7wJmGFd1WVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361771;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=+6oJSOsTeTHjv/fO+copRg7hLizzhl6fr1surIhUdd0=;
	b=3JJu/g3jQ4iWhFRbcDD+XcVXeUbStDBGiT5MrGuNYUBcWJwtKr+iKLPjmTMZsrV5tlTv
	 UmbUuw3hYGGIcdO4BjR4ECpVi1nlVkFNkNNXR5g7yMlC7oQIUmweLWp+bXOyLxDwz5pzV
	 VBhzqL5LoW7ewh4MMezQG6DPkB/+ztvs7GQs6XzCDIAjX6wABD42Gb2a74rgD0xL1Viyb
	 6x6sTcbvKSQAa2gJj0t+8JGnHNADYrupICSZN99chRial07Ji/xrPSRcTCwoIQt2w1sTR
	 W+ZctLf6DG7aEe5ush4yKrNMOaHa6u60Zm/BK7LY1LD9wuPNs36ixiY6ARx7Owbu9Gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rn3GD9F5;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C0606A31A;
	Fri, 30 Oct 2026 12:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A7C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rn3GD9F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793361771; x=1824897771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qdRWf5jnL70MdXCK943IPnp+oONzoyzR5a9ldtXW2IA=;
  b=Rn3GD9F5UY2yocgikl5wDnAlfiZuE05rKJ6cGtFTQTFdyapNXpTjgYfJ
   ZXRn+QkoCWi+YBV3fZXUVI4/U9ERMlYAOrXRJsq9Aqtr8OdqHZ7PDZvS2
   NbIyVGM3HuMnNZlXbFMXXDQIMEBGHoM/CxQAUeF6bs2EhsiWu4uUvP8Ev
   HcdP91y0bCPLLMoZdemO7SDQwMuf810k+RI6Egf2jj7TU15rPAPGRvLNk
   ga3uHPwcyukfkZOGxsXSaq00LRGxR33Oowx0ac3JzZpuom0ypwoTPXz7P
   p9HgsBjxy6atG0o25wHi47NHoBNIAQ3iLN2uGr9ZDj/tNIqMHVzLUEPq8
   A==;
X-CSE-ConnectionGUID: 2imqacX1RQmiB3vvhANaEw==
X-CSE-MsgGUID: V60D2yU0TMi86R1L5DZI7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2006032"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2006032"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:02:41 -0700
X-CSE-ConnectionGUID: uIGsuzb1SlWbgWCOvdGi7Q==
X-CSE-MsgGUID: FwGxEYwLRQmw14sRO7WgEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5545774"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:02:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 05:02:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 05:02:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 05:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX518qv4LBC6F6n6GXGIzFr1PZB9B7XN6I8rbMvgaKssgcoC8STfp/VVzGJDFHtziVKK3POu3Oswu3Y0l/iS3akMMURCWZTxYFrTzM6rubPGqGSA2KjExCu66ApXoHb2+AKMNYAfNopoKhi5ThzmdPQhzEZE22yI05Wljf0ZSjP6ApAkxuInWvJ7icv/DwK9gOcmHfksvnj+ppQdJaa/MC6SXCWR3txsWJQb02b+g1G2PA0Ag0RbpGJOPd2rdX+gw5v5jpSfoxadHqCYP347UJHRRIdVWHX0iyrsEMxBzikblNAS9TbLSV61be0CGe/tpVgKCJtXfPsVpUmjN63kfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6oJSOsTeTHjv/fO+copRg7hLizzhl6fr1surIhUdd0=;
 b=RVYMgGEsiQvBNv4EvHVY3InebHXiunmcOZQLX7RNPju7DqoJr1OdzK7cjLf/wnMkfr35GP35vi9Pf1BWnZ08r+egA99CAgOJxsyTB6auL2pqLnHgP15kwRqRXm0kuCeuQJgFMFhka18+wzIyqTDfx9vi1YItqBAQlCUPV7CQHv77jrNfReJG4LXW42/t64U545GiUmbMYF9UpdMFvG/Iz0JbPydrXThOvigFdwjImcU1bg517gwDGC6JrspFB5Qa8jnECyb82rsT+ZZ+/yIohYG0WRseg1RZ88BrgmmrGPIRiNL1B+kue8/nniC87aBswMmO1V0FkFV1FoqGUlM0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by IA4PR11MB9418.namprd11.prod.outlook.com
 (2603:10b6:208:56f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 12:02:37 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 12:02:37 +0000
Date: Fri, 30 Oct 2026 13:02:32 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
CC: <netdev@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>, <stable@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <auSHWD91s8TQrvi1@boxer>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
 <20261030023248.78802-3-testwrzwrz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030023248.78802-3-testwrzwrz@gmail.com>
X-ClientProxiedBy: DB8PR04CA0024.eurprd04.prod.outlook.com
 (2603:10a6:10:110::34) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|IA4PR11MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: faefe128-b0be-40b8-cc70-08df367db0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|261009223027099003|261026140227099003|261026121527099003|261026135527099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|261028144727099003|261021133027099003|261021123027099003|261021135927099003|261021130227099003|261021121427099003|261026130827099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: erq67MPk4INYXwXEP61WI/ey6QG8eV45A0MJh5GhjP+NaFZGcPlqwZa4c7dvvKIOX3myKsK1xaWPrTs6JnZrvFV+axcSOUgmn3lF8NM4E8a3U9gnLsd6JeR92zKP25A3b4aZA3IfatFsa3FyDTzZymaEXtcZUQFrsyLjlLnfCUz5uN/wnNOrcA9hF6FdRE4fyv9/gdI5Xa4+oTupkGt72KSsOcmOW02PWqs+Xmm1tAFjFIwakA34YksK6alnYK+1nJGS5Iimaj7vDDrgOL0+wH1f4eQXdnMtc9BQGh9VFYCVrT6nmdFQTueUjNwBqcmXcU62kw5ZH5GnxhaHdTF3qjnsnU44Av0pIuNQOXqIMKYaHPAqNySHfQmWECjm2iChKiyvLwtj7AD4bw7/6Gdljo0qkvYrWaiHAjcnb8gOWv/1NbfcM7UEsmLS8wUZw6riH1doM0RHTEeXniN7Iy2QgCanoMgoKFJvXvG147kK/PpC3ARo8qcqh5A1L5NLqAijCBw8Fm0QgHsgvxuLRssxOS+58St3r+zPMGf5TPI9jAvHuAOJNsRl16CAlXl11oMI5dyrLu2fe4LXlSUZyrW94oCTl56qXfR6SuSrJnREKtI/WZ4Ix9H3oh+9YgwE//vfT22yG/2Srj/OW+g0TqJ8awuFmFX5MBpJfwLHY5829Ig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261026135527099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021133027099003)(261021123027099003)(261021135927099003)(261021130227099003)(261021121427099003)(261026130827099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewZ50XHin3cik9OG8UuSrH4u9R9s8qy7iA1rvCRFcukRZgtU7xWTAVdIQCBo?=
 =?us-ascii?Q?29scJmW8IXy9/jqVR/MbFDC5nBNdn2ymzL9ZP7YdicoUarS298pMaaohSosr?=
 =?us-ascii?Q?HaCQobi4lzE6CJfBikVHlbz+wNO5TaNAby3MYadCDL4CwAURxx27EzeGPOOO?=
 =?us-ascii?Q?6IHn4RgaYEjfvSIxXdA2v0JQktcOI7SJrU0VT3be+n9dZGr9fmMuYXgITNMV?=
 =?us-ascii?Q?I8UkmGPueP23jSJCsZCisxmhyYts0z/5099YvKOMQiV3r9FK83odPcVO4FBH?=
 =?us-ascii?Q?xA/qO0WxHcRLF4vIB1dkrFaaaWLpQYpy6g41ws+u+VIbk/NQIFW9YVdD/y2o?=
 =?us-ascii?Q?GbYDPpx1Rze+H3kEG5D7R9BZENMwybYKgicf4b+WxVHac/QFbRmLHaIdkS44?=
 =?us-ascii?Q?AGv1z2qNoEzJROMxm0lcPkMTtSmbjizTwkxnspJYfEwWYt0yfbKAdUOJeAal?=
 =?us-ascii?Q?jo+UYLtXeFMDkuaiHVB7CABgP4oK0Kpx90BGGhySvO3yXgCgAqyKPCVeopIv?=
 =?us-ascii?Q?l3HuGkn3M+rp6V9SgakCyiqaK30AABb+NW4E1vgsPJO2BdDhz1WFvRAgheRS?=
 =?us-ascii?Q?vGEjdh5h+M7x/OeM011Oh3Qa41mbKbY+6NDLeRIfZVg/75sHTJydTXA2aVQK?=
 =?us-ascii?Q?SRiLCTX1D1vYmlAgzlaKB5eJBAROYoCqp1BchFQB9lnb81T8CAv4wRddteoz?=
 =?us-ascii?Q?g/My5wmjGN3tNgN56Y1Bf9Cxx1lAZx8DtfTCSTIY/1vAsIQ8nu7rEik3EjQZ?=
 =?us-ascii?Q?CpSbzpwEzD0wC9oGgkH58Jfie/rnhiyY3kFnSTysJ+s1bRVniC/Dx2Cc9mKs?=
 =?us-ascii?Q?qyYwbRx4RbZoPc4nPDNIq+JqB0qqrS+wm51ouXjzac09Sakcxo1l86bJTyvH?=
 =?us-ascii?Q?f8akCOuS/pLTiHU9vFZfUdqGWzab+3hFcDOWmgEyMKRZpxXnbArgc0G0byCf?=
 =?us-ascii?Q?9xkKAJdHRMivQurKgFWey+g/Syra/j4QbmYzZn35d/FbXqPtTOR0XTw+h2H/?=
 =?us-ascii?Q?RQQyvdJL/fzjtZVZ1fyOEOaRsQTmxE4mi+76xtzL6P+j6BZlrjShgEfW8cdS?=
 =?us-ascii?Q?ub+Y8Ms8S4/F4A02CUNYzzz7NXApqwbjvbXM0jNAeDvoOxszVSwSM7XL91uY?=
 =?us-ascii?Q?RucrlKeKRVNyLM6Oa2POWiXsNRsC6ZV+IVUXGuUgaqCr5f2sqpQ6IgTU5aud?=
 =?us-ascii?Q?vGoEoebUtSVV3Qw3a2dDNsoWMKeHxpA0ZFLpEUBmchKsNx8FaRy9iRCqalB6?=
 =?us-ascii?Q?aa4xk1btn77SvSCIb/MXoonHgJ8sSEIu/t+TPz7US03y6vy411ZRFaxRaTwT?=
 =?us-ascii?Q?SoyxCn5BRuDEC8ej+WbGVeQ5sSAi8ooJmLIXk8GhnJNoLWQWM9/ZIES1vOCS?=
 =?us-ascii?Q?jtRhbriJmPpL3RfqGwiijEEd1HkwGTAFtcO+jzMnYlcmd1ri1LwCSSx2djlf?=
 =?us-ascii?Q?9WbFIWiBGv/LVpo1bdki1fm5D+L7RYo3J88+/9Dtkc8ywGLLllp11vAIwJvm?=
 =?us-ascii?Q?EaFxbEimcdw/g3G8udLx6FOjQnTHhx1iLbgS0qcvquvCe46Gz03KeuXYwUgp?=
 =?us-ascii?Q?ujvpN4g5zzWNQBJmDSuT+PnRW3WowHhyInNCd0CfwX9T0immrigg06oJJXF1?=
 =?us-ascii?Q?j09fKktQlCGpF7CpRFItVqtiy56uyMgd4fSWbAOo8q0YrQyvVAol1Q5FI2ZL?=
 =?us-ascii?Q?WS2yvTKcbO8swfUFRd2LDm4Sw4rfBlF4cUPEwf+v2RHSqZM58ncpW7xYhG18?=
 =?us-ascii?Q?bbrrR6/kvsJwGalYxo/5Ik2DLUHvrkw=3D?=
X-Exchange-RoutingPolicyChecked: cx9V5ssuys6+qq3ydNjo4/jXw881/QkiZ/e7gV6rgw1BPAkmmTkt9jrsMFZeydybacL7V02PZ2envFCpBgNOUdce8UIvK6DhKHOLSe1tcSuC7xfKl8tswVCTpuTZLWnEQ/1B2FgnLIcfGil0LSYjGKxSkhJ2nwcbLD2qvGFaPy70rD1NRsIkteFnH0hkaTsucHQymFVBxgTNAWJS402LZOVOGTv4OgDVrbKQmCayh084CIxlyh9RHdybAOkI31ZMUdgIP7tUNqvewcPc9Ujt08wdBoLaUGA9dqv0TN729AeQAvyGWbDbkO8dmbVpumw43zS0SuIyhvNY9WiYCC7FHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: faefe128-b0be-40b8-cc70-08df367db0e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:02:37.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEZBK/R/NwhOxH89M6MGpL8XM4gIbkanLiggLNYZf17RRuC90H6xXFjdNp9iBl5hYn8zNBrQzghCxNrXpbbnmqaXvXSG064h67xEUEyMibw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9418
X-OriginatorOrg: intel.com

On Fri, Oct 30, 2026 at 10:32:48AM +0800, Rongzheng Wang wrote:
> Extend test_xdp_metadata to send the same UDP packet using every descriptor
> count from 1 through MAX_TX_DESCS (MAX_SKB_FRAGS + 1), and to run the
> existing metadata and checksum verification for each case.
> 
> Build the packet once and write it into the TX descriptors in a loop
> instead of using a flat two-descriptor layout. Keep the first descriptor
> large enough to cover the checksum offset; the remaining payload is split
> across the continuation descriptors, with the last descriptor taking the
> remaining length.
> 
> Reuse the existing AF_XDP setup, packet generation, completion, and receive
> helpers in xdp_metadata.c instead of adding a separate test harness.
> 
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
>  1 file changed, 92 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4..17da0a145666 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -18,12 +18,15 @@
>  #define TX_NAME "veTX"
>  #define RX_NAME "veRX"
>  
> -#define UDP_PAYLOAD_BYTES 4
> +#define UDP_PAYLOAD_BYTES 32
> +
> +#define MAX_SKB_FRAGS 17 /* minimum CONFIG_MAX_SKB_FRAGS */
> +#define MAX_TX_DESCS (MAX_SKB_FRAGS + 1)
>  
>  #define UDP_SOURCE_PORT 1234
>  #define AF_XDP_CONSUMER_PORT 8080
>  
> -#define UMEM_NUM 16
> +#define UMEM_NUM 64
>  #define UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
>  #define UMEM_SIZE (UMEM_FRAME_SIZE * UMEM_NUM)
>  #define XDP_FLAGS XDP_FLAGS_DRV_MODE
> @@ -56,13 +59,13 @@ struct xsk {
>  	struct xsk_socket *socket;
>  };
>  
> -static int open_xsk(int ifindex, struct xsk *xsk)
> +static int open_xsk(int ifindex, struct xsk *xsk, __u32 bind_flags)
>  {
>  	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
>  	const struct xsk_socket_config socket_config = {
>  		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
>  		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> -		.bind_flags = XDP_COPY,
> +		.bind_flags = bind_flags,
>  	};
>  	const struct xsk_umem_config umem_config = {
>  		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> @@ -133,31 +136,35 @@ static void close_xsk(struct xsk *xsk)
>  	munmap(xsk->umem_area, UMEM_SIZE);
>  }
>  
> -static int generate_packet(struct xsk *xsk, __u16 dst_port)
> +static int generate_packet(struct xsk *xsk, __u16 dst_port, u32 num)
>  {
>  	struct xsk_tx_metadata *meta;
>  	struct xdp_desc *tx_desc;
>  	struct udphdr *udph;
>  	struct ethhdr *eth;
>  	struct iphdr *iph;
> +	u16 first_len;
> +	u16 pkt_len;
> +	u8 pkt[256];
> +	u32 offset;
>  	void *data;
>  	__u32 idx;
> +	u32 addr;
>  	int ret;
> +	u32 i;
>  
> -	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> -	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
> +	pkt_len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
> +	first_len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph);
> +	if (!num || num > MAX_TX_DESCS ||
> +	    (num > 1 && pkt_len - first_len < num - 1))
>  		return -1;
>  
> -	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
> -	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
> -	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
> -	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> -
> -	meta = data - sizeof(struct xsk_tx_metadata);
> -	memset(meta, 0, sizeof(*meta));
> -	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP;
> +	ret = xsk_ring_prod__reserve(&xsk->tx, num, &idx);
> +	if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
> +		return -1;
>  
> -	eth = data;
> +	memset(pkt, 0, sizeof(pkt));
> +	eth = (void *)pkt;
>  	iph = (void *)(eth + 1);
>  	udph = (void *)(iph + 1);
>  
> @@ -180,18 +187,43 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
>  	udph->source = htons(UDP_SOURCE_PORT);
>  	udph->dest = htons(dst_port);
>  	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
> +	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
>  	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
>  					 ntohs(udph->len), IPPROTO_UDP, 0);
>  
> -	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
> -
> -	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
> -	meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
> -	meta->request.csum_offset = offsetof(struct udphdr, check);
> +	for (i = 0, offset = 0; i < num; i++) {
> +		u32 len;
> +
> +		if (num == 1)
> +			len = pkt_len;
> +		else if (!i)
> +			len = first_len;
> +		else if (i == num - 1)
> +			len = pkt_len - offset;
> +		else
> +			len = (pkt_len - first_len) / (num - 1);
> +
> +		addr = (idx + i) % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
> +		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
> +		tx_desc->addr = addr + sizeof(*meta);
> +		tx_desc->len = len;
> +		tx_desc->options = i ? 0 : XDP_TX_METADATA;
> +		if (i + 1 < num)
> +			tx_desc->options |= XDP_PKT_CONTD;
> +		printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx + i, tx_desc->addr);
> +		data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> +		if (!i) {
> +			meta = data - sizeof(*meta);
> +			memset(meta, 0, sizeof(*meta));
> +			meta->flags = XDP_TXMD_FLAGS_TIMESTAMP | XDP_TXMD_FLAGS_CHECKSUM;
> +			meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
> +			meta->request.csum_offset = offsetof(struct udphdr, check);
> +		}
> +		memcpy(data, pkt + offset, len);
> +		offset += len;
> +	}
>  
> -	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
> -	tx_desc->options |= XDP_TX_METADATA;
> -	xsk_ring_prod__submit(&xsk->tx, 1);
> +	xsk_ring_prod__submit(&xsk->tx, num);
>  
>  	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
>  	if (!ASSERT_GE(ret, 0, "sendto"))
> @@ -224,24 +256,27 @@ static int generate_packet_inet(void)
>  	return err;
>  }
>  
> -static void complete_tx(struct xsk *xsk)
> +static void complete_tx(struct xsk *xsk, u32 num)
>  {
>  	struct xsk_tx_metadata *meta;
>  	__u64 addr;
>  	void *data;
>  	__u32 idx;
> -
> -	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
> -		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> -
> -		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> -
> -		data = xsk_umem__get_data(xsk->umem_area, addr);
> -		meta = data - sizeof(struct xsk_tx_metadata);
> -
> -		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
> -
> -		xsk_ring_cons__release(&xsk->comp, 1);
> +	__u32 i;
> +
> +	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, num, &idx), num,
> +		      "xsk_ring_cons__peek")) {
> +		for (i = 0; i < num; i++) {
> +			addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx + i);
> +			printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx + i, addr);
> +
> +			if (i == 0) {
> +				data = xsk_umem__get_data(xsk->umem_area, addr);
> +				meta = data - sizeof(*meta);
> +				ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
> +			}
> +		}
> +		xsk_ring_cons__release(&xsk->comp, num);
>  	}
>  }
>  
> @@ -325,7 +360,7 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
>  	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
>  
>  	/* checksum offload */
> -	ASSERT_EQ(udph->check, htons(0x721c), "csum");
> +	ASSERT_EQ(udph->check, htons(0x1c8f), "csum");
>  
>  done:
>  	xsk_ring_cons__release(&xsk->rx, 1);
> @@ -361,6 +396,7 @@ void test_xdp_metadata(void)
>  	int retries = 10;
>  	int rx_ifindex;
>  	int tx_ifindex;
> +	unsigned int i;
>  	int sock_fd;
>  	int ret;
>  
> @@ -398,7 +434,7 @@ void test_xdp_metadata(void)
>  
>  	/* Setup separate AF_XDP for RX interface. */
>  
> -	ret = open_xsk(rx_ifindex, &rx_xsk);
> +	ret = open_xsk(rx_ifindex, &rx_xsk, XDP_COPY);
>  	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
>  		goto out;
>  
> @@ -462,27 +498,28 @@ void test_xdp_metadata(void)
>  
>  	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */
>  	tx_ifindex = if_nametoindex(TX_NAME);
> -	ret = open_xsk(tx_ifindex, &tx_xsk);
> +	ret = open_xsk(tx_ifindex, &tx_xsk, XDP_COPY | XDP_USE_SG);
>  	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
>  		goto out;
>  
> -	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> -		       "generate AF_XDP_CONSUMER_PORT"))
> -		goto out;
> +	for (i = 1; i <= MAX_TX_DESCS; i++) {
> +		if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, i), 0,
> +			       "generate AF_XDP packet"))
> +			goto out;
>  
> -	switch_ns_to_rx(&tok);
> -	if (!ASSERT_OK_PTR(tok, "setns rx"))
> -		goto out;
> +		switch_ns_to_rx(&tok);
> +		if (!ASSERT_OK_PTR(tok, "setns rx"))
> +			goto out;
>  
> -	/* Verify packet sent from AF_XDP has proper metadata. */
> -	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
> -		       "verify_xsk_metadata"))
> -		goto out;
> +		if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
> +			       "verify xsk metadata"))
> +			goto out;
>  
> -	switch_ns_to_tx(&tok);
> -	if (!ASSERT_OK_PTR(tok, "setns tx"))
> -		goto out;
> -	complete_tx(&tx_xsk);
> +		switch_ns_to_tx(&tok);
> +		if (!ASSERT_OK_PTR(tok, "setns tx"))
> +			goto out;
> +		complete_tx(&tx_xsk, i);
> +	}
>  
>  	/* Now check metadata of packet, generated with network stack */
>  	if (!ASSERT_GE(generate_packet_inet(), 0, "generate UDP packet"))
> @@ -518,7 +555,7 @@ void test_xdp_metadata(void)
>  		goto out;
>  
>  	/* Send packet to trigger . */
> -	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> +	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 1), 0,
>  		       "generate freplace packet"))
>  		goto out;
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
