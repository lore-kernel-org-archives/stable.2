Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E163E00B3;
	Mon, 17 Aug 2026 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967053; cv=fail; b=G4zBuKYZ3wCDKfXDNyZNJsEgiAHjwaEqin/wStR7/dbkd+rQVd7yGaFI+T347TGETDN7pzf/Pq4VIdzODB7Umsbn0tRH4bg7abOfUJvrfLNfcTWK7o6f3h/YEyURwh+meN4gZl/wLfOjaauy6Huny1+dE2tj/8ZGbKMJ6Eb9wXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967053; c=relaxed/simple;
	bh=NBXD6Gjd2fokjJNAmdRLy9ZNRCiAG72OeBppNSqqr/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ee6XnapYRHqTJwAgzkMJZ8O8dQBd+uk+eqkU7w0xIGSsIx07QGGGDm6sDd6HBN+aKc7NKmC+5VkSE4nqbkdlZPHxgn1EfU2ibnP8wAm/RuflKHgTLiEnt1LaHytz/hUme1mrV4jp0fr3hNlXOtRZ8WtoQcEBtmQemJncx/BwM/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n8dYvTve; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n8dYvTve"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQtBMyz15w8pXqF0r6h7VncjOvLfx2G7VTpMfPRWFUdXJnG+aowHJ7CA2CjypL2Qa07HB+xkYJcbxQKVdGzt3i0rimaJSXnYWGLAaqiTqIICcyRc8Owx5GWZjnfuJX3Fq0Q2qHRuGIz78P6UP/uzr8Nb8tzjmvSGjIlWtTz/SOm/l4xTJgZQlL+wEYWKtE2OSlC2d3nUsB32qWX2/VYCVxpO9alGs7Ka4v33Tba6S35XgDq7m1Bc1Z+W74klYmLY4ZHmwDYzYlL1QzmYY674dr3lyBtSU5VtCg8UocRAXv8pRa+WElfMVAytqMqxTkcTj1ff+O9a3pNzQomO7pIrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H54x8JIP3hJF7G0n8H7p4zrfvN86oXF67Rx685T5+6A=;
 b=dbAlFvtIFtu9bBripU1lrFQrzDjgB7UcfqQMyemX5pah9LarwSJg6oLMz+Ja+f24fXYvkKCsOscB7fYU8eq8T344om6Ol5mk6lzLg2LWihawg1g7PAXVJb78YPm5bpYZtWrWCjKSNNp+1uakr+swl2kcejvcIQ9G/R9acZIoLfMXFkKTm5jka9tNJ7LUMZdgsLOCL5twtxES5gwPYS0gkchwG33KdEKHuI8YwnzVML1/5in8JU3+G8yeVw6jkSA9xTYC3MMh1RH56frWbVWvf/9vQosphSJFfrtGR+fOq7fLKe+WEXn+/9ZEFcDtBoMykmGtx4r4jN3rtYKKzKCo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H54x8JIP3hJF7G0n8H7p4zrfvN86oXF67Rx685T5+6A=;
 b=n8dYvTveKCJulD/tccaleRILl7fksAEYHtA+iVl1ueAidWXZyxYPLDg570c824cgncJKxxC4aEbDjbB1s8VZLD+ukoU01Vs4/O+t951VR0lBCd9VwxErQpZBUAG7DnhtCk2SaALVXz+E2avlQ00IoIZ1zZ+Q/8Ygz6PWnoujMtBZEbGGfN+Kvmh44WaFvPtnqRRsWtC3NJp8sAT4fOIUSmDE9vPE1eVSXaXDFmQKeVGgKQ172g2Q6hlKXEDNyGDgiP2rwD57Z1bxFiGDCuIIrSbx7guGxC/vuSWvwQ6tK8mS/eXVYYNeoobM0jHqJlRBDq819t3pFJXdJKFBV7bGSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 11:44:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 11:44:09 +0000
Date: Mon, 17 Aug 2026 08:44:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Dmitry Malkin <dma@nebius.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <20260817114407.GB1175472@nvidia.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814221103.GE510472@nvidia.com>
 <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <aoLtgeYLpYobpyKN@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoLtgeYLpYobpyKN@google.com>
X-ClientProxiedBy: YT4PR01CA0429.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: cac42666-0a01-4211-f642-08defc54d96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u5bwq2HTDdRP2RznwNUbMKV9ZPytXyrxPn3hzB5x9kPBv6SJOGoIPEHEaQ88FLvekknqW3voMh2hKdtFF0e1vN38dRyffyW4c0yfgcbNDR/1qR7lMzsdcI1YafBtsc4aWyfgibvCY5ZcnOaPdVUImbm2Qv3lcZGMM74kVGBG4Bvbk+TRJYD1yfEsm/3U6oRy88oJ2plmSg/j3cUu8m6VqX6etAsFERdjVc4PXWK9QJBacYTY5cQ3uhzApdE1Oq3hDj3J65UXScjgMeTnBz/wG961mwx7cuaRogDybWVIl43JaH+batwwI49EPey+LFlDXW4KTC5Y+gRn2KxFI/Sfrr8GCjWTkanl3Px+wumUK/0Lfbsum+CjMQF95lnJn3iuM6DLK9t3c51jKXB4ZmvbTaUWqFdRBMdjerpON5TJ/T8Ej9W4zhQ/vGP2/XT9OMRkKvEBq4Q+C65n7EmARyraYphCpMMzHKzf7IxhYheA6gw8b8PUoZtLu0rCfbcSImIMuVPCrsgBC4X0hVXxnpXQlu7ObHv6vJuW5Lo73MrGTh2qFhRPtK3zcTxFonLhqlEvJidtpW1xRms8kTKy87Wzr8wG2Q03c6ENrk0NzLy+3qesf76kZOTBvp+GUZPpu4ubuCd5UqJN1vMzQ+jDsPXGuzVAZVkyy5hha2NF3c9U06o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M13sESqc3XfIgScs+d/S32WNumNL3IOJC7Ubcer6jLcb/hCx2/QmLA8Y2e+U?=
 =?us-ascii?Q?PaW5Yb5LPPd6tKEvHUs0Db/K5Rn1/vL95olyh0PiAXEjcY8CJg2NDHn/GgCt?=
 =?us-ascii?Q?JCwYnc/8wmPl6VXK6O7RV+nJhN6pOv6iqIGhvhaGSG8J2uXKAW57BN47T0Or?=
 =?us-ascii?Q?RW7k4ogL6/4ujFjc4yY7od6SqJKXpAqARW+2oP76GSPinItTgJNcnpJ6Vvgp?=
 =?us-ascii?Q?r+Bht8oJ/+acvDOuszQdxns9eGULNXfDOjaS6G6j+yBIj96/7Ow/XnmxQ+Jf?=
 =?us-ascii?Q?Ej+OIY6dBg6Sm2uN8IL8qQVkwnfn5R2GHuEd1tBSA9XSBy0GgtwdnP0OA3+O?=
 =?us-ascii?Q?NOQzdzewfv9vvtCOSF5yJHnYFYArTHjJPLtxMkpUJaX+PbL5j09yRDX9IhwZ?=
 =?us-ascii?Q?L7IdJrhLBPL9syhdtY4DVozNtKuA0rkWMpxEdYQ1PkmirosFbO4YD6186Bdk?=
 =?us-ascii?Q?kXsqiKzy8rGgyePL7dvvo1bacCCVucZ6PbD+GxMa5+4NtOjAhN75Punyi4tv?=
 =?us-ascii?Q?TiZAxKobonIqtbkHX+blg0fP7zh3Qu0cG5sjqDhIV8LWjhsNcSHR/GNGqyUB?=
 =?us-ascii?Q?tEKLBZ2VNaCkp0/YF9thVs5sUMxRTonF1CY84CNukT8cyD6XOTkB9GF2hcQl?=
 =?us-ascii?Q?kDeLzGVHCUXyXi7ZxtxxwTkOhX3mHWBI26YwRcepyjbvo/Ve7qHAdAXVR0cZ?=
 =?us-ascii?Q?VQulBy/nhEODW5t4d8RKSYL2dQhvGPFQX99TOf6JrITLeuZYfQzSDUGeI8F9?=
 =?us-ascii?Q?r7sb39XaKHWPB4cWADM96VFa0BjENGmJWpCxgiNLDrBGmzZJcGzW2Fvvel59?=
 =?us-ascii?Q?EsMbDkBmt3pdiyrEuG0K5C1b4hayu017ozFIJ8KgLX7AqPRp8ToIi1j0DQzT?=
 =?us-ascii?Q?6QGyJ6Vv5PE2ScNx4g5XlU1ZIPmHZ6D8s55ekCKohlo1r6Ctnm7p33iyLtiI?=
 =?us-ascii?Q?rExu8rZDDix+0HfHeP+ZlMVB6Uw/O2kar46BFnQRUFsr0mH9fgLNJj0+gE0E?=
 =?us-ascii?Q?+bsqug7Tj7w4s9N8xEN6X7f42NmQlXn8fL4Zc6fdqDaJb2A8V4LcLKNR5iRb?=
 =?us-ascii?Q?GZhtvhnN2GTdpE5ljxRtTx98mF6TaI0H7pnOAwNvCwah9x4NhwzUvcPZR2ZJ?=
 =?us-ascii?Q?SXbpHE5lPlA1QaPn0e97Xa3OCUOsQXJ07Yx06U6UtNnk5ecvIlhTKgQ4nA45?=
 =?us-ascii?Q?fCLPsVN8Skx9hfwXe3rC1xg+vFoQ7qlJozn9u2/nucLHk/uPmzibGiTrj+UJ?=
 =?us-ascii?Q?Ts8mhgkOFL15s7WRYkrlhECwDtXm9WSUAIRs61DAgCvWOleu4ljuzIWWGQdR?=
 =?us-ascii?Q?Jlq4fqyowzasIgJ/Sq2EFXXUUQ1VQTitHGCCqS2IurqA2cM/xWLuyo0Jk/GU?=
 =?us-ascii?Q?7+9iYQ7vZTur8E4aIRnjNP1mykQ2WQAVQFwmQ7XsDDPDxLLR4ZG4nt4g/gg6?=
 =?us-ascii?Q?2Sl6S+61tF1mFQnRU5BZyUPFiI4WV7abDy0wRC0jCN/kXFzI3zXQACZ/fKED?=
 =?us-ascii?Q?As8FJwOzVygoAE9O2P75iFJ4dNkhvVKtz74CPUBGGlj+ofgag7PonGz0Uhl6?=
 =?us-ascii?Q?14ZDcJtgA4jwrvKeuWkd3B2ZZpPwCyy9+0q7ZXIbLdmAjDoy5l/jQpVPGbsQ?=
 =?us-ascii?Q?t0yX2jhNgLXfi6RBU9tl7RjYVFFyDmMRdxbHo2MLocTa2s4BMY7P0rTh/+9a?=
 =?us-ascii?Q?MLYUDW0Kt8lJz4jv/6i2aPLblfofE8SsFRcDACd7pWE0daOM8Vihggp+OY2i?=
 =?us-ascii?Q?+9IhiYhuFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac42666-0a01-4211-f642-08defc54d96f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 11:44:08.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QGIMO8WuAHBXowJFRsx3vrGZFfR2uZLC7mmAYMt40uENLDjpnRzSu8wx+xUdZkC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

On Mon, Aug 17, 2026 at 11:16:17AM +0000, Pranjal Shrivastava wrote:
> But, regarding PCI P2PDMA, you can still enable it with ACS enabled in
> the upstream kernel *IF* your hardware supports TLP forwarding between
> root ports.
> 
> When ACS is enabled, all TLPs get forwarded to the host's Root Ports
> instead of getting routed directly through the switch.

Generally nobody wants to run like that, the performance is
terrible. The reason these systems have a PCI switch is because of
performance of the P2P path.

Jason
