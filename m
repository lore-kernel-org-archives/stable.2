Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794069496;
	b=kPj9T65XIHVPbw7g1lBBBLNDeiKG+i7X6zR85kU5hjcC+WCbiqsCr49awTBFiyHgvnOG
	 cq6e9Wax8ccgGnsK5fJZdInN8Rcyh+CdtAvichQ2lwhaQC8fi/9dXV92Di0CNe4mGg60R
	 8DYqv7Kcy5YB37ICVvDoXTxxmn2kv4zR/coU7fOUnHzrTmQjOjx9Mq4qPlgzAPQ+/B5rh
	 isSxSdBsXJLcXQXeebf8P2xUyRqxZrkb/2p9AJMDoBG6y283LbUAKzt5T7LUbVaLmbHOE
	 YqziYEA4Y0TyTOh1rrgt4yNgx7kqlj/tyD7DoYsjYCxsB6/UzCu/6XaDo3e0G1AxDzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069496;
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
	bh=rs21bQ8ex/2rPG0c+fRHtc0b7xzkYOE3iHllPbnC1HQ=;
	b=qo3kNRw7IXsJsQxi9tCv1jMwY5/a/iAN6S/4ZOg5CJdXDIUyC1tVuTRejVlpgvl6Yy+d
	 q8iiD2y1pQSRlNBQ2z/CpoRd/vd7OpOo/AxOW2n4a6IR01Lzo96Jh/OaVkZJ4PJVZwU5d
	 JATGzJIbjU1hxpdDqtRgEhpMfM/Mp8IDPQ7WmTxjwlbUwEPicCGjNpFt1yh80ZpR38SfF
	 m2m+/DbmFMdvLfnXApfpJJXifo5LJfJ8zK1IDLE0Sxgv+/CUPniSRHv9YeF0Aocjte74U
	 8zRF52Iu+BcY4zc5LipYi63Ze70Bc9IJ3junA1EwRze/MKn1c5qfKziEu+VWJ4f308w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IxjKX8b1;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E3606A326;
	Sat,  7 Nov 2026 16:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IxjKX8b1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794069494; x=1825605494;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XkOq7N01Rc3q9SDAT/OwuIN8n+FkWO9UPm8uaNO/XFE=;
  b=IxjKX8b1uDBi9oiIusi01472KnAc85Wdvt9BUM++qjvTJ3FSL5P5U1yp
   I9SECL/IaHqNK34pUWS2Xe9ZDsMBcYAnHubc0PHNHHu0CURg7keUpT1K/
   xSKWizpG9NiLJH+aCCDXw4QN3vgLQLTwfDsQ9oz/5EUM0QVEh6JwKBhy7
   SNxKCy173zK/4xbwimsd5i89d7iHGQAnvOF52ZzGV2MPHOMzaRAGrxlOq
   rbEj2FIzup5MDDL5u9apRvd0SrJgasCNHaMBJs6XZVnF+cPQM3yRziEQM
   o9syBBkSXCeKVISJ9Ps8b65+mqrc0kNnf2pobTLy729u5/QB1eDnIQ4CM
   Q==;
X-CSE-ConnectionGUID: GL/33KcMSqKhXbzdv7UsbQ==
X-CSE-MsgGUID: xx2ZSwUARCutuSbIg+w5Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2895630"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2895630"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 08:38:13 -0800
X-CSE-ConnectionGUID: Pgd9DfMgT2qB7VT+aHySRg==
X-CSE-MsgGUID: k1xGsMnGRbKoFX2J+ra6AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7407108"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 08:38:13 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 7 Nov 2026 08:38:12 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sat, 7 Nov 2026 08:38:12 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 7 Nov 2026 08:38:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX2GpKvh3cxqkQ7FCAAPbJiUlE1WCSJzaDOsmFkV4DoW2Q2Ix/RBV/3AEzgJ794gP63kBOxy+VzspNOss7vzt36SbqoHvxDVmKGCGRTUUJCyAldB25f2ZeeI3zKhcaLD6X+r8kAHuP36DvHWq7UnRKPFrprDwYxhYbaP3E8QD3Uj9hLJS49j1updGh8/ZMdIpvTtk3CGZ33UkjhParMijt1OxQvTeZtyd+1URY/5c0rEjWFI08nEPMAxTzOapc+OOQ7Kcq7poI4TImIJhV8q4uhcgvF4iXtz/df3t6mlnoQrLIXnjWsWW3aMnJ2guWWYMoWukWcxsMjS/VuEsrhq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs21bQ8ex/2rPG0c+fRHtc0b7xzkYOE3iHllPbnC1HQ=;
 b=nYpYDii6IZV78zCMi++N0fketLJyKZkL8MJVMN0lK0mabmdKWOcipgvfzRPo07quLfWbZ/LGR/wpoIQuyl9Zs+HzDhMtxHB6Uz8OfMoANYjPmOQ+6VHVyDxqwxLMqOpBc1eoZTOuBAoQckriyOAjwO87Noh9J2LVDMtHaPRIEcgf9pAfaLX9ker6wUwF9NrUdQxkyzfPzvM3djsEuiePTiH1jqUP3iIHZxno8Iq1T7ZsK/x8WZnA+weX73xvOPEk7DDC5z0AIMq4b6QN+IlwAEieXXGkK0l0k9FS5xRk/mfzIRKYzkHJmLAaJO3l737H0BGRjCRO9wpKy+1E23zKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by IA3PR11MB013943.namprd11.prod.outlook.com
 (2603:10b6:208:548::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 16:38:08 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 16:38:08 +0000
Date: Sat, 7 Nov 2026 17:37:53 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <tkusters@aweta.nl>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Sven
 Auhagen <sven.auhagen@voleatech.de>, Richard Cochran
	<richardcochran@gmail.com>, "Kurt Kanzenbach" <kurt@linutronix.de>, Sriram
 Yagnaraman <sriram.yagnaraman@ericsson.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Paul Moses
	<p@1g4.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Message-ID: <au9T4Y1rpxvuEuFv@boxer>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
 <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|IA3PR11MB013943:EE_
X-MS-Office365-Filtering-Correlation-Id: 023865bc-81b2-4ae3-96db-08df3ced8138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|5023799004|4143699003|11063799006|261028144727099003|56012099006|261102123227099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261009223027099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9f1ep4R/LeI5dVGrxzoeezJcaUenb5pY7mxRrzLl57zCeoS2XuMw/N1Qth2clKySQp2MmUxGA1+txzRXap3aDBK55cMmwdwsK8CX2OEf5OQ5dpYMnO+e5BymkUhMQemAgCSh3J0lMtSb13rZzuj2d0NSZ+oXrHEz662tDxSgb6uEtd64hh9e55hlqYvvDw6lulPbm8GNzIHTlS+VVg7pL1OroM/M5FVTdN9KKrpAoKQ5Xups4jhJmoDXKknTC7WgXTLJMI572bdN6AM9DtFOKRzc1LKAC2yKWkOy9t82MmwVd7QoXOUGA+mNFYkPT3znsNy68sW1wR7KmRKPtIbCOXURJWuUGoW4BwDhlJ7ZHBwP3GsQ0PKphr//oOC6WtmmmnOyaQVtzUe9863JaTxRwK9Qw1e2Cjy/NyCGbCc/04WJpV/4iIyyhVvFvrB5qJCfL0ouL1ePDySF5VFmwsJ1YpbLX87xe5WVVsY1HqgzPOqO+I7ODEJ1GawqYmF72ZFc9cx0lqt99CvjL3E2utvXfpSvC9yOssGyBL3o8F2C6t/BJnGUO6DlGwLJC+qLqXBLmPqUb9OkAdGwP5Xj42g3aYUEM/bYH10eRgC6XGhLJJ8MLSq0HPacDk47NccgFWNf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006)(261028144727099003)(56012099006)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W21Q1znbkTDSW35W+1kpYb93BE+B6Az0bsnnFa+V6GzRGPVE6L164WD3ND/T?=
 =?us-ascii?Q?pxIkvO/ebcwbdB17ZPNBUtpUIkw/iMCzBEBFJcXAuSvLBtMtggQV/9MotbNi?=
 =?us-ascii?Q?OIDz1gjJSHAHUCbfP0CI+5GFFVmXnVujHlC/SoY4/1eAMrD56bHBObM6tlho?=
 =?us-ascii?Q?syucSR+GeX5VXu6Scja1gGtOhwxq/ngUCSIqUfBhPmGgOZJFounbGqC36Z9W?=
 =?us-ascii?Q?Y/MhftcXFbqbCcsL5WsioKzlAvMu4Y7fSxB2PbyqAdndL9bwIiUvjhbTRmOd?=
 =?us-ascii?Q?Ty0ejA08Pi3aHu7uVgNvBlZUd9+hFMIgapDGE4wXrHw3JPC2TaADQob5XFZR?=
 =?us-ascii?Q?Op3z/toM6GEjwVgO1R+mVns2l91Myt1nP837uWjY1ELhKUajnbZkZTCphOta?=
 =?us-ascii?Q?li7/E1JHGT8cJGWu0xsems2BUMteuzRxBTyqN2xQByZZc7gN6Dg9f1fJIBbQ?=
 =?us-ascii?Q?LeU7fK9YJ0ctb+mRJZ3h4rfMQD7qy4OycO1b0JOOtwcGg4uhoisAbsKnpxAG?=
 =?us-ascii?Q?CJf1zfJSxBlDhBk9iC4hP6V412S4/I2SXxl/TeQ9+On98uDbieX6BKxmnTEq?=
 =?us-ascii?Q?ngVFG03mIxO9hAmhoZPtolCMe8hplJ9aIDIYZ28PlCQ2Sp3noYAUj0Jyn3kW?=
 =?us-ascii?Q?PsLB0EI0tnHniHTkYTZ0B1xbaPwA+Sk5z+MXua04bjHYrkhbxMXNO+3U3hmI?=
 =?us-ascii?Q?KzS6JydYIILVJZ4CrsuzeXKNXdyrHrQBtVwkMjkXgPFjkrayGwsy9XCm++FH?=
 =?us-ascii?Q?xlrd7XhE9emuMtapGPf4OA1BF+tLtICIqOVwzIwRJKOuAFpmvmNuKIWAm4gO?=
 =?us-ascii?Q?vQNErHI+LK/9zayS4kafvpIFz2pv55nMaTX5SOGgd30PXT/A/QaiyJ5Eanlq?=
 =?us-ascii?Q?3Yu/OmBcK6X1BateHzVP60ZR4MBCvVlVoPEt2kahr9UUI/my7f5T/t1DOr18?=
 =?us-ascii?Q?22LS2solKL6Ad+fhBCiq8y5XAy38WOqmD5hdeFQ1M0vRSYEl2A/z+zCDGfni?=
 =?us-ascii?Q?bnXhwCrSPJa+CAywJAfe2bna52W8C+6pb08H2YPX/+iPI1jpnkl6C1OJ/5Zw?=
 =?us-ascii?Q?SMmsprVGPb/LqyRPYNdbEFU4NHc4r43wsg0hTduvmf6bOgTV+zefyIO1Yinp?=
 =?us-ascii?Q?9ViPXeU0j0NLTfmGcyzmSy0rdGjED8LL6rmT+GgLk5JzVeypkIc+pWbrTT/Q?=
 =?us-ascii?Q?AKxvmdkeLP16A8YkiUhQQlqHbD1qY/OCeJ9UUojwlRkHS5YqLOvRxhwb2gBr?=
 =?us-ascii?Q?nat3jxcfwNMDzIUymPVf0t1Ky7Pr4KxnGvG3fzqSELy0pjE6rxDwl5AyS0De?=
 =?us-ascii?Q?KYNU1ckRcZuOeO9w94qiNXRuhwCw15uzLn4jlmu15K6Ehci42Qns9MEBnD85?=
 =?us-ascii?Q?jusLi/WzRtFi2QkD4NMn20dLakqVR1D2gwl273rWiypmkN7VnMUjOiiy54+J?=
 =?us-ascii?Q?svOoOMUalqaDODHajJS2WiGYNbO86CQBX+fGJeDSA8OTD9EFp5yLxTeSjF1/?=
 =?us-ascii?Q?xEABXOP+iPFFcXovPK5FHPnEsd1MAiJ8LYIt3ZIKttS0uS2GnjxeHy23zz5s?=
 =?us-ascii?Q?GtkLEAbqyIlBhQwayaw4D2a+yZuEiRlFn/QsFhM9W4a2LZn271v5U1upb+ID?=
 =?us-ascii?Q?t18UMGReoq+BEFPYFJEYIAzeujcTCs+MzUyjWfp/FCSOG5//SN8OZ4mrmFvp?=
 =?us-ascii?Q?eMMfzQiy7IpisfLq7s9c2vxNU5N8eWTmoJDc+iw9J1WOcaTcpI6CAL7dE9Hz?=
 =?us-ascii?Q?ZlgqRW6TEMLiaBKojIE/tjzS6YQFOqM=3D?=
X-Exchange-RoutingPolicyChecked: Q63dPaD5mTur1JB8xX59NQIJ2tsPDuYORHLbw8ttMFyijDCTFQqSBufZ0oh1zSuR2sBu/FzICEW1uvAEIr4jXZOrmETWvI85eQakEwBREHRKOUtkOsop974n9VR7SjRq7rfWbtH7rW5sg6oFy1FPXYkiuGEBjd39dSrUBTrWrMnuguioEZMrZl/kKwN3G80+G2Pgb2PGDuQVY9u78l+lVafGUvkXVPZZmPlIyasaXW3BbIAXY9DfkS0lote/8WhwLGiWIgWPuydZLzx5aOKGdioopP6CyTMEDRK7DV9i4pVT3y5DDC1SoueSaVtVvYtWHdF56abPgIoKThNqcslCQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 023865bc-81b2-4ae3-96db-08df3ced8138
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 16:38:08.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfWDumybyXqXJbG7zYLBx1T82x8DSDZK/h4oOEJWfgdjvefwAebKJAE+F3iA1omw0PBQUoBdo3/lmSVZHZqWQckA39S7KZKbFWWbRJWcEEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB013943
X-OriginatorOrg: intel.com

On Wed, Nov 04, 2026 at 07:40:04AM +0100, Tjerk Kusters via B4 Relay wrote:
> From: Tjerk Kusters <tkusters@aweta.nl>
> 
> SRRCTL.BSIZEPKT has a granularity of 1 KiB. For AF_XDP zero-copy rings,
> igb_setup_srrctl() programs xsk_pool_get_rx_frame_size(), which is
> rounded down. With 2 KiB UMEM chunks and the default headroom this is
> 1792 bytes, so the hardware buffer becomes 1 KiB and a full-size frame
> spans two Rx buffers. igb_clean_rx_irq_zc() handles every descriptor as
> a complete frame, so the AF_XDP socket gets such a frame as two
> packets, the second one without headers. With Rx timestamping enabled,
> the timestamp header is also stripped from the second buffer, and a
> short final buffer makes the size wrap.
> 
> Program the same buffer size as for the other rings, 2 KiB or 3 KiB.
> This depends on "igb: do not let XDP frames span more than one Rx
> buffer": the receive length limit set there while XDP is attached keeps
> the hardware from writing more than the frame plus the timestamp header
> into the larger buffer. Without it, the hardware can write past the XSK
> frame.
> 
> Refuse an XSK pool whose frame size cannot hold that, and an MTU change
> that would no longer fit a bound pool, also while no XDP program is
> attached. The current MTU is checked rather than the largest XDP MTU,
> as igb allows XDP up to MTU 3030 and that would rule out 2 KiB chunks.
> A pool that still does not fit when the ring is configured, for example
> because its queue was hidden by SR-IOV during an MTU change, is not used
> in zero-copy mode, see igb_xsk_pool(); its Tx then fails with EINVAL
> until the pool is bound again.

I would rather return -EBUSY when enabling VFs on queues with active
xsk_pool. Seems igb sort of steal queues from PF?

We do this in core when xsk_pool enabled queue would get wiped out via
ethtool -L shrinking the queue count.

> 
> This is the igb counterpart of the igc XSK buffer change.
> 
> Tested on an I350 with xdpsock from bpf-examples in rxdrop zero-copy
> mode on one queue, Rx timestamping on and 1514-byte frames from the
> peer. With 2 KiB chunks, the receive descriptors went from about two
> per frame to one per frame; 98-byte frames and 4 KiB chunks were one
> per frame with and without this patch. At MTU 3000, 4 KiB chunks
> receive 3014-byte frames in one buffer. A 2 KiB chunk pool at MTU 3000
> was refused by the new check on the 6.14.9 test kernel; current kernels
> already refuse it in xp_assign_dev(). There, with 2 KiB chunks and the
> default headroom, the new check refuses MTU 1751 to 1766, which the core
> accepts.
> 
> Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
> Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
> Cc: stable@vger.kernel.org
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  9 +++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c | 28 +++++++++++++++++++++++++---
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 19 ++++++++++++++++++-
>  3 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 0fff1df81b7b..0495c02544d6 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -856,6 +856,15 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
>  int igb_del_mac_steering_filter(struct igb_adapter *adapter,
>  				const u8 *addr, u8 queue, u8 flags);
>  
> +/* XDP does not support frames that span more than one Rx buffer, so a
> + * frame plus the inline Rx timestamp header must fit in one XSK buffer.
> + */
> +static inline bool igb_xsk_frame_fits(struct xsk_buff_pool *pool,
> +				      int max_frame)
> +{
> +	return max_frame + IGB_TS_HDR_LEN <= xsk_pool_get_rx_frame_size(pool);
> +}
> +
>  struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  				   struct igb_ring *ring);
>  int igb_xsk_pool_setup(struct igb_adapter *adapter,
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index cf9911137bd3..b286adedad5d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4833,9 +4833,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	u32 srrctl = 0;
>  	u32 buf_size;
>  
> -	if (ring->xsk_pool)
> -		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> -	else if (ring_uses_large_buffer(ring))
> +	/* SRRCTL.BSIZEPKT has a 1 KiB granularity, so programming the XSK
> +	 * frame size would round it down and split frames over several
> +	 * buffers. XSK rings use the same buffer size as the other rings.
> +	 * While XDP is attached, the receive length limit keeps frames
> +	 * within the XSK frame, see igb_xsk_frame_fits().
> +	 */
> +	if (ring_uses_large_buffer(ring))
>  		buf_size = IGB_RXBUFFER_3072;
>  	else
>  		buf_size = IGB_RXBUFFER_2048;
> @@ -6775,6 +6779,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
>  {
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
> +	int i;
>  
>  	if (igb_xdp_is_enabled(adapter) &&
>  	    !igb_xdp_frame_fits(adapter, max_frame)) {
> @@ -6788,6 +6793,23 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
>  	if (max_frame < (ETH_FRAME_LEN + ETH_FCS_LEN))
>  		max_frame = ETH_FRAME_LEN + ETH_FCS_LEN;
>  
> +	/* the frame must fit the buffers of a bound XSK pool, also while no
> +	 * XDP program is attached, as attaching one does not check it again
> +	 */
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		struct xsk_buff_pool *pool = xsk_get_pool_from_qid(netdev, i);
> +
> +		if (!pool || !pool->dev)
> +			continue;
> +
> +		if (!igb_xsk_frame_fits(pool, max_frame)) {
> +			netdev_warn(adapter->netdev,
> +				    "Requested MTU size is not supported with AF_XDP. Frame size is %d\n",
> +				    max_frame);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);
>  
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2..fb04df82272a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -91,7 +91,20 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  	if (!igb_xdp_is_enabled(adapter))
>  		return NULL;
>  
> -	return (pool && pool->dev) ? pool : NULL;
> +	if (!pool || !pool->dev)
> +		return NULL;
> +
> +	/* the MTU check in igb_change_mtu() does not see a pool on a queue
> +	 * that was hidden at the time, for example by SR-IOV
> +	 */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {
> +		netdev_warn_once(adapter->netdev,
> +				 "XSK frame size is too small for the MTU, queue %d is not used in zero-copy mode\n",
> +				 qid);
> +		return NULL;
> +	}
> +
> +	return pool;
>  }
>  
>  static int igb_xsk_pool_enable(struct igb_adapter *adapter,
> @@ -110,6 +123,10 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
>  	    qid >= netdev->real_num_tx_queues)
>  		return -EINVAL;
>  
> +	/* igb_change_mtu() keeps this true while the pool is bound */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size))
> +		return -EOPNOTSUPP;
> +
>  	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
>  	if (err)
>  		return err;
> 
> -- 
> 2.27.0
> 
> 
