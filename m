Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204244;
	b=Dlq+M0m9T2Qh2Rq03vqqSF/eYjPGWRn55n8EiWI7TdtDvE3S8BKIVt5QQ+uuoOYrFG6Z
	 kUmxKUVTNnTw21ADs1gZr2iVDcUkuajXCuDcIxtQzDxzI1Hp1l2D+9in5R3K7JyhPCICW
	 6lzXW16fG8GbqHe1zFjNe4LcBoVeioD6lilNB6EwuWTJO1FfT2hbl8RvAsBO8qSjzVdLS
	 MvXbWmly6DAWidKqmLOA/rAijRCe5laJKSdzsXtRTD0qerbcdmHQZcWHsG2/XnX8dtelx
	 FEhiyISKaR2TbV+aH+aHxiO5Ta2pjieMsxpcts9cVp0owUd5svh3bKHRwKe6zxgxQ/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AlIg+kAiB08Dl1qg5i3P0kJ+PmJNs61K6y8+fHcujg0=;
	b=AZwPIm4Atw1WqZIYIBXLrz9lbJAwgISdS/Dn2991kOnZmW4yKMsRNAdcjsSEwzP1pI/Y
	 R5FKz5lol3kdjBagjPEgk90oeSXSTSM4SVcIu93PxroiKSt7EN/SX/qEWKkKYC05U/SRy
	 OW4DJ5eHZIql3dcY73hW3SdSm26/5xPiGv5DOB3oipnIU8UrRUW74yKKideW+k+VXNii/
	 LJktN/e146z013GnM9f4X8mdNgyI0yK6m8lPemNPNfC4jdpWqavNMaaiKRSQ68RAgG/Hx
	 1XNxmxclsgIEMHMnivfzVohc7AnJ7ylUspGI8RmaxZHT/aKtpFfOLKDAEfhtRwW2p4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="AURQ/z3E";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.19
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95439606A31A;
	Wed, 28 Oct 2026 16:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95439606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AURQ/z3E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFCIPijhYR69EMWZobZYeCDJF3TTIHnIohPQkSyQfwTFzT6blk5+2xTAq3nM1HLFafpJp0d+F2fWRBHIYOyHfwn1uIq+LYdOd/JoeCeqEMLmDX2wVwmSHzPfex2IUifItAA1N4KBlBp9GTrhVE0L9U8bxx5I3NDoAnILCqSp1Yv54gGjayQ3A2LHcZWn4AFzkJYr/YLDi44G7xbvRZWnfYWdOiWT7FeWKKw7ZpI6yqGaq8SDT0cKFvNSq+pRjOJA/Pe/RYI7kPYNRimXTeo9+/W3giJ5TqUWZi/jrv+vlfhf0NI0lj/4QpnbuTA9rZnzvxb3hAgEF2MDrtoc1WldcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlIg+kAiB08Dl1qg5i3P0kJ+PmJNs61K6y8+fHcujg0=;
 b=PNVHRHIITIPMCmXlyUt7hqLkJNAY9C3saokW2hUbge8SPu54B+fAeBQWkHeBlRO19wve6IVALHfxOdh4bos+MekisOGVkFaydjqBF3gRZ1Xtj7M2PWupLnwC4mmEGVbfw9onXY0yLzX33A+YBgy4pLSd+vn4UHxzIIvJ5XiCF5qhnaL2VFLtLkHQ7JkIesuZcMHX/6ILheZAVCv8k2S85io7+1efXN7b6KuVuZZ3jhNhiPNmZhX1ufLPJhBqC1oHqLJKNoAS+9zROwlg+WcArWtVUSVmvxSNHHsNIsgAwMN6g/hDMCjN9knKLQrNS9I0f9fkzAw0mo7iUAUYWozvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlIg+kAiB08Dl1qg5i3P0kJ+PmJNs61K6y8+fHcujg0=;
 b=AURQ/z3EvXupAFcXHutgXglBtaDAjYJcQm/6blUluZxNtFXefVW1fxuy59hea08X9dqeqYaRR79AhhFNK1TZJeNPYiDh3jp/SKOFM7kiIMm8vDlFmo38agFWbwqDy/lCVCWX549PY48g5Djic9udgq/X3kXVGVb01c8NGqkTjZznPPFIvoT5jleMDbcAagaD4UiIgkYDTKkvV4TI+UYXyHrosDCSj6w0guopXThNHiDc1VBUigjiohilFqltvIfk9SUWflclLK19yE2L6lKRvjtnu2ht87hV6h+umPAmtTVEh3Wy2OBgLXbviTTEoi10FdE4oSdH4Id/cBDByl0DeQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA1PR04MB10985.eurprd04.prod.outlook.com (2603:10a6:102:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:17:20 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:17:20 +0000
Date: Wed, 28 Oct 2026 12:17:11 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Message-ID: <auIgByiiQNwtr1WK@lizhi-Precision-Tower-5810>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com>
X-ClientProxiedBy: PH7P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA1PR04MB10985:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b061b37-0659-4005-de50-08df350ef16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|23010399003|7416014|261028144727099003|261026140227099003|11063799006|5023799004|4143699003|56012099006|261021123027099003|261026121527099003|261009223027099003|261022075727099003|261021121427099003|10067099003|261022105027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0MJDLyX95JNV/vhZ08t0lQpMzw0Csrb9NcS/wcHMPtuS1/mjJ2ni2qh0JI4HMx77ePsJ6/FHJSSGs08IBCTXWLbOYBMlQXG20yfkJYFH5NqveMDT9USUloTTmhL8k1CgjI/AZTABKsAzCvM6bno8++EhsLZa4Su77SW2I6/20OOOWFarSfpSw3RvWoCrAK6Vmky3HMSu+WQ1JgOxZpMxHEcl3J8EIbFQjVht1ygnSQiXfSN0A0ZrDml4YmqDLZP8WzN8+yYGMQsUw9UJAt11n9VnsrLxsVpA/CqvvLFysaqFTvrgnOl9cwBY9jU9dg/j7OPmyO/CIgB7qR2MvuD+owsh3JhY9HQcgfuNijGqaPLjb9T2K9Dben4tz8Cgpj5ZLJI+atz0yHahlZzNoQyYvs92Dumzk1fAotuScYIrJyHx/is8RmVKKtjc8finErTeTozFSi6szDzK0EMZn7u0yHHc/8jEiz9fgB+HzTdXxZXhm1AhbOtaynuZ08dkYindxzolCi8q7Lx2KLYN6QOLZj+lTssQf7psu4lmT78SdfNp2FSdao4EOqwVp7ZfsKmUMt/MwYzMmIPVPZ+K+uMsp8gSn0jgUze0QGVM7KnbTKYpjhwBe2015TwC3JukF2KR1C8cOO2g3Tg4RETfrsIzt64cu/N8YUGm1sip5j0KlQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(23010399003)(7416014)(261028144727099003)(261026140227099003)(11063799006)(5023799004)(4143699003)(56012099006)(261021123027099003)(261026121527099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHY6pv0lRGJw8pmTIHs/0VVOLVfN80LEfJUCd6lSDm2F1Ovf28DdArWF78Cj?=
 =?us-ascii?Q?J8377RttRnOVxkWKWkR5s0w66np603N+jDRSLTOlhWGg24aI+4t31tw7XsCq?=
 =?us-ascii?Q?vxVv/Dpy9LJFkGrK+dpBfZCjth+Zc58rqjURrRHhBj0fTUJUe24CKd9oUfPX?=
 =?us-ascii?Q?/kmUJILHpu3JyAfb5PKBF2eeMIbYotxNQr17ND/IKDp5s4RFLFSjxe0ym4r1?=
 =?us-ascii?Q?XGlhxjLdKYxwh6Yj2CSFPGX/FQQDzqh+QTC4T1FUpzNrV+JFERgzD01+gAaB?=
 =?us-ascii?Q?s8ZrrmiKGc7zs87ceawTrBKI+n7ASH8WCVkTWej6KYxR+1HP2oaQjEAW6bU3?=
 =?us-ascii?Q?tHT4CGGdb0rGcDYavmhU6sJYyohf2z7+Mh847ufXktmo4ND4qNH8puNPbbeg?=
 =?us-ascii?Q?3WiVZDLvXtUnwhqYBaX0/4m8rQEMi5Zu9OLKJIALfoF4RP7TO6J27DjmUXr6?=
 =?us-ascii?Q?ND6z/0baiMm3GNuKOqIVTBllOE7YoZzJ42Tda+9eBf4g3nMnbOqpRlq4YZFN?=
 =?us-ascii?Q?DdnuxBcz6lDIOH69OkI74W/N1lV/NjeKQ1bIUwD5m3jrGTKJGcHJ4FtcGd6Q?=
 =?us-ascii?Q?3XzFnLruau5m01r5DHKiZFsy3vwtY4gCSXENW2bMSMDvKUS1fvhx2xuu2ci1?=
 =?us-ascii?Q?l2K8GnVlKpmdWfzuJh0LsldFHcZggjRD4GLrj2xrvCtTUkdwWbdFzxqfmjrB?=
 =?us-ascii?Q?VUMaJznjfkKxoYAHRjQOF1e2HaZ0xUv8dnILED5zOS2iJN8oOvf2IGQB4rix?=
 =?us-ascii?Q?TwIfUifqU6GWJ9318xcqWSquSpA8oVAXhnKb8SFEpBJBjNT74oM07MtdJUSe?=
 =?us-ascii?Q?XtMa25sFYtz3iiEUjFYDHaOEwOgcGU7AGOc8Ym+XDdE1sfBKEWSh4nGETbLj?=
 =?us-ascii?Q?wqt4gSGpLHF5dZ8MOIZqmslk3wUbj6/jzVcK4r8ALUV8VP/nkvGkVGcucf28?=
 =?us-ascii?Q?L1NlD/fE+DOdLjZi8YLE8qDqW2T9Thv4g3DJ10K2qDQI39FriuV615fZXN4M?=
 =?us-ascii?Q?K6210K3540hnhD1hu3Z6jAnrYbfVYsYAZpxtcXbP6yNy+mu/gcngEQXYqBtS?=
 =?us-ascii?Q?qOWfHyFDItvklKMVMBgn135/buR12SIS8zQJCVh33i03LhsASdoCIkO0EPYd?=
 =?us-ascii?Q?uleWeEqvNSf0rrNtdj2E8zdFHnGjSNuXJON+J2dNDvUMmxfxiwveXuNf17ad?=
 =?us-ascii?Q?dH+Zkh+a239Ql9udPOI/NoffHWbDEHrrbX3MlUDn2u34ZM59EjkfU7RDu9To?=
 =?us-ascii?Q?YdojZm/7J9fti62FT4uOH+mjm0nWkiTZQF31mB+P1CY/5hSPcfd62WtC6486?=
 =?us-ascii?Q?CpQTRMiIvsAhEWLl5VjvMbvOwzouRxQfezVOyMS3TW5hSa/RZCn7tjgbKnxg?=
 =?us-ascii?Q?b0AkC0MdC5oqr0Lw+sIo9HoUunLGk7jPOS5TzWk4bIHsZ7or6I7wTzRNT1FL?=
 =?us-ascii?Q?71R+qgE5cjoVXRR5Z9NtOLz8znMc12HxgnSFVUjE75i5lCwuL6MjjxcX+K8Q?=
 =?us-ascii?Q?0GvsNuiLFc4Znl1fSrO35XsgsQ2N3mGU9b7scfEy9go2VYGZXycUTfWgLRPQ?=
 =?us-ascii?Q?QsiR7XGo4QljU55EZn/RPRxCgNIYSi3XsUelFWy1U3Q6jbI8MTfp760RE6h3?=
 =?us-ascii?Q?ZDnx8GBG8fLM5U46l36PH/vf7AQqeVFu/R5bb5QE+aUaCXEo7a02TippElaP?=
 =?us-ascii?Q?hd7XwtERAzQ2MPvWSoJlAKlKyR7prGbX74v28/wjOIF72LnRjiW9OCmm/cso?=
 =?us-ascii?Q?nT0nuO2ppMxN5/Z2i5qdEPhfRPxTUDqMN+wNC4OEqK5ctE1+RXtN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b061b37-0659-4005-de50-08df350ef16f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:17:20.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNyJRBLdP5N+L1ujKWi0AJYX8+tQ2cRlUwHTteMPsSZTRhrugpXeYlrC/3CRp6U5J8TlPrO+qFoILPnKVglru2Wz+lwvnIW3GSUzRvWqFVAm34590+Fg5bKlw5WRmaOK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10985

On Fri, Oct 23, 2026 at 10:27:22AM -0600, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
>
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
>
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
>
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> 1. after the IRQ-handler submitted the tasklet but before the tasklet
>    started handling the DMA-descriptors in dwc_scan_descriptors();
> 2. after the XFER completion flag was detected in the
>    dwc_scan_descriptors() method, but before the dwc_complete_all() method
>    is called
> the error denoted above is printed due to the overlap of the last transfer
> completion and the new transfer execution stages.
>
> Clear the channel interrupt status when stopping it, and keep the XFER
> check, descriptor detachment and queued-transfer restart in one locked
> section. An empty active list needs no completion processing.
>
> When the locked XFER recheck finds no event, only update residue. A stale
> tasklet snapshot may belong to a terminated transfer, and a zero residue
> only means the source has been read, not that destination writes have
> finished. Requiring RAW.XFER also prevents the fallback scan from freeing
> a descriptor still linked on active_list.
>
> Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 70 ++++++++++++++++++++-------------------------------
>  1 file changed, 27 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index dd75f97a33b3..07a5f5105787 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -141,6 +141,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	channel_clear_bit(dw, CH_EN, dwc->mask);
>  	while (dma_readl(dw, CH_EN) & dwc->mask)
>  		cpu_relax();
> +
> +	dma_writel(dw, CLEAR.XFER, dwc->mask);
> +	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
> +	dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.ERROR, dwc->mask);
>  }
>
>  /*----------------------------------------------------------------------*/
> @@ -257,34 +263,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
>  	dmaengine_desc_callback_invoke(&cb, NULL);
>  }
>
> -static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
> -{
> -	struct dw_desc *desc, *_desc;
> -	LIST_HEAD(list);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&dwc->lock, flags);
> -	if (dma_readl(dw, CH_EN) & dwc->mask) {
> -		dev_err(chan2dev(&dwc->chan),
> -			"BUG: XFER bit set, but channel not idle!\n");
> -
> -		/* Try to continue after resetting the channel... */
> -		dwc_chan_disable(dw, dwc);
> -	}
> -
> -	/*
> -	 * Submit queued descriptors ASAP, i.e. before we go through
> -	 * the completed ones.
> -	 */
> -	list_splice_init(&dwc->active_list, &list);
> -	dwc_dostart_first_queued(dwc);
> -
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> -
> -	list_for_each_entry_safe(desc, _desc, &list, desc_node)
> -		dwc_descriptor_complete(dwc, desc, true);
> -}
> -
>  /* Returns how many bytes were already received from source */
>  static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  {
> @@ -302,6 +280,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	struct dw_desc *child;
>  	u32 status_xfer;
>  	unsigned long flags;
> +	LIST_HEAD(list);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
>  	llp = channel_readl(dwc, LLP);
> @@ -310,6 +289,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	if (status_xfer & dwc->mask) {
>  		/* Everything we've submitted is done */
>  		dma_writel(dw, CLEAR.XFER, dwc->mask);
> +		if (list_empty(&dwc->active_list)) {
> +			spin_unlock_irqrestore(&dwc->lock, flags);
> +			return;
> +		}
>
>  		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
>  			struct list_head *head, *active = dwc->tx_node_active;
> @@ -341,9 +324,23 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
>  		}
>
> +		if (dma_readl(dw, CH_EN) & dwc->mask) {
> +			dev_err(chan2dev(&dwc->chan),
> +				"BUG: XFER bit set, but channel not idle!\n");
> +
> +			/* Try to continue after resetting the channel... */
> +			dwc_chan_disable(dw, dwc);
> +		}
> +
> +		/* Detach the completed transfer before starting queued work. */
> +		list_splice_init(&dwc->active_list, &list);
> +		dwc_dostart_first_queued(dwc);
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>
> -		dwc_complete_all(dw, dwc);
> +		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> +			list_del_init(&desc->desc_node);
> +			dwc_descriptor_complete(dwc, desc, true);
> +		}
>  		return;
>  	}
>
> @@ -389,22 +386,9 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  			desc->residue -= child->len;
>  		}
>
> -		/*
> -		 * No descriptors so far seem to be in progress, i.e.
> -		 * this one must be done.
> -		 */
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		dwc_descriptor_complete(dwc, desc, true);
> -		spin_lock_irqsave(&dwc->lock, flags);
>  	}
>
> -	dev_err(chan2dev(&dwc->chan),
> -		"BUG: All descriptors done, but channel not idle!\n");
> -
> -	/* Try to continue after resetting the channel... */
> -	dwc_chan_disable(dw, dwc);
> -
> -	dwc_dostart_first_queued(dwc);
> +	/* Residue describes source reads; only RAW.XFER completes a transfer. */
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  }
>
>
> --
> 2.53.0
>
