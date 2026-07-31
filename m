Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF71405C3F;
	Fri, 31 Jul 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511718; cv=fail; b=Kz2Crl44bz97X6hSG/vdoxIeIjf+XIMwdsZL69DGmrw9bHBl5PENIywCaiiDZ+yMZYUvI7hIpxw9HfvxEr53FuFSBo39oWHdBXpcrkaG8dV8F0ir7eymDrpbqhCRhHxSl4Zt9RxBCtV6MyFpi3T1bo9BAk6AzBZWB+oIS8Je8I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511718; c=relaxed/simple;
	bh=0fF1n9QCDPqhI5Lvj6xE+AJcoPUWz7nN4jU8NSb1IL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NOu2M75XrN9Nnqo12uIXsDi55t2YZK+8tVODNIumlQnC19RjULXONUYSxmIjHwdos1OhY7uAhUByg/XAq22DGKv+DL2XcUcLZ6oZE4UdmrmT2Gt4tleVD6aiQtP50/x4BhehZSByKwWciISHLvg7bqlhlRUQYZbkop8A1G3V8Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TU/ELSd4; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TU/ELSd4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyqUl6lNxRgxcpcWuEdNOVoW1xZNCi2VK4Zs9Gl2oTi5X9tegIkZHv42l/KWlZtom+FtKOfisbT5ctPvqhZH5ZLhCeSxv34fjHbTLQRkx5ia4HNT9wuvBK1r3ENsGrRrcmewfNQNRWtUFejLZ9cuUIRGjIdYJW/CYXx3xXA3crdpiVUwRo3N6ZyAYXpK4KK3N6dxoowbZr2H08BjTG7lyddnh3IUgzS3uLsYxKwUV9lJfMYpXRJ/+T58+C5KphR6mxLjIcFxioa6iZ8TCtPzunk6MLihj/KpdWQGQ2miqj68+rSR51xdG1pDtdt0SQ3/gsdfiV/BfT2w0uNPQU4C3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVQwd2qEgKjHAgU7Zi16NvRD9FWP06z/1zGikoEGa2k=;
 b=i2ufJncx3XQhgozJspXsCZGQPWBlFbUq/4BFaHCilcljmUeGa/ED4hwtspVgSBpUZh4GhjzAbcYs4uisrSpeqB5i5Gq3TrZzeYdSQBhE7Ss11erxLSwh+APLRhgXU9350LXo1FQRQWf9vw2kVbqe/eDRFnZH0oq+TKnmVXKB/ErHna0fTi5kXxek4wg+g58x0bzj+mHESNeYmGuqurZLncuI6+6pjVk+UOnkjfwWEJvM391f5Kets/p0uTvYNAVAq30lKz3db3NVrW1TqaURBKiPYIIeJIMSDhzC7jLIEU05a92fmPHBuDcIE8G7+h05YwHS5Ah+2DTf+NoIaDoQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVQwd2qEgKjHAgU7Zi16NvRD9FWP06z/1zGikoEGa2k=;
 b=TU/ELSd4CFZ1UnkDv2JwIXAQ8f3IgwfFcdgurVqqTrdnj8RFuCs8dseYuUXPr02SVAuojQnCrK4vIXGZpWNuj9H9bP+kHnmCfXNL8CGRcCdca4Xf2R4yKKYCZ6ID9e7qTkgxHexsbmT9Ngy2eLI/wPmIgmf5cmbxGLqKu2cW2ztIQDAo6Jpry1WdNtPo7vVbZzem/CAPQswKV28WJNLeZago7jiSo+J3Nn9dlBoH+FvwqH5kMzeFqVOYWdIi/4zfNyhoZTJ4K5VI9y7k6kPfdOBytGJps5VZ3prpB+SHGuPM9CmKeU+py15JBnfv17iLC9OpTIRrDXKlDDUtXihfog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10487.eurprd04.prod.outlook.com (2603:10a6:150:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 15:28:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:28:31 +0000
Date: Fri, 31 Jul 2026 10:28:21 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <amy_Fe7hYtidlua5@SMW015318>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-5-kmehltretter@gmail.com>
 <amufrR-1hop2pZOz@SMW015318>
 <amyxxce6haNJBJ3G@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amyxxce6haNJBJ3G@gmail.com>
X-ClientProxiedBy: PH2PEPF0000384B.namprd17.prod.outlook.com
 (2603:10b6:518:1::68) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10487:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c18ca36-0b77-4ad8-09ed-08deef186098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|7416014|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	geIP2OKogcNG7XaITlrnzDo3mHQPCpMv/35wKkwvK8n5yTK9HTe1ULj8qS6JJK4VMqout9j5igNwXJBhJPW8AWPNUwOUDjqBfA00HntNEkQPEXodB8Qz8A7Eozmb5pP8AaQN3nFnWHyR3brLcSEI10PuIpCD/r8YXa5UJulf9fMA/PdxfhJRYXRTXaUrn2y0lJN4VPDw3zyFCk8jkAoPz1VAhsH+cqnR2bNbm+zD6ep7P18/iITasYNLbw2LLyFNtJgQ+7oA7fzWwmj9skLUVThVwqZPwyYiT3BtXAmTJAGBOjPglBKEhf2PFGZQLpUh0rWe8cPjN5qJJ75on04U78GTZkAZCnWZdT2OcAxBpIYH8Hn3rGyZTzIxKSfuCsNzA/EW8c1+qtwomN83Q2EMBvXsrCpdRfPPOEsp6iM0t9ac5t/l7+hoY3XySfKY9PJj5CbI6IMoj8SRL1Wz0t6VVuOoGYHYbwaO4x+VgnjyJGhC4UjaEmU4wqMxr5iMIFO5jlnepdEAmjfbPodkaZYnMA61ajGCesuLudtz5qidb5ZtvKPFFRMmsPZlGNn1MKG3Fj1B1DZApkdfk8Rct8DY1oFNOCz1rmyTPo+5RwpZrk5nmFwEVUOI4oIs2N7lVcVCG9Yn4nbcZf+znnzPQRB5xuG3Cws6+rkJkXClRzdRWZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(7416014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6vitXt37InHseua3UgYlDYVbRuGr7xD+fWCUAqZc3Gg9uWKnJ93qjgz8Qibn?=
 =?us-ascii?Q?Qa/40ZoxoyV0c8ZSYBlEMkm+6h121O0bNHYl+1X/rOPRIGqDRltzOIXxBnQD?=
 =?us-ascii?Q?lMdVEO1C0HiCfP4gPsCQUvjLgBqf8FCcGdeo43VXzTQaoiqC+GpgSr+PTTjE?=
 =?us-ascii?Q?ErUIEv0KzOk2CVOgS10Ex+nMOhxSp+y4+UFVbnZM4VpRze40OczfpXLrIocd?=
 =?us-ascii?Q?BetgkYXe3qcP0O2lpxGUYXsHNHBLtefkXJjARQpl3MjTKXpYxLSuXvTNvOVk?=
 =?us-ascii?Q?iva/ymHQEpSGZbqzgRHXQpFfcdL0CTe1IAIiCt1894t+thaTPDhxnvfKTuyR?=
 =?us-ascii?Q?4AU0V55hI9JXe9rwnRQYZoTZ7ajQWCQ/P1aBH+2n3Evtf4rT9TWJtMFLfV6G?=
 =?us-ascii?Q?CGbKohOIwELxhyCSUP6mGwPrrB+WYPIiUlovQeuG8QIywXWnlN9AOVJgRkPS?=
 =?us-ascii?Q?HcAPUO3ZHsQiIO6QJ8AS5pee0+YoYAS08getlLKrdPtE8EQY1qqlxbnjAOk+?=
 =?us-ascii?Q?b5UzPU9A4fQUhnDWxTIirK1HSN5LqdNcHrOHosh0EKm6Z3mBon5H2DDDFiLE?=
 =?us-ascii?Q?RWPojwmbLzHI2Bhql0XTYHlTQIpTJJjoEACAfq6RC0Jd3IZzkiZIqwSSxNIE?=
 =?us-ascii?Q?veL2zjnGNR+NlqxTt6K5eMasXvAuZlHtwH2b3dSmS+/g0LRrBJ6LS6r9JgX3?=
 =?us-ascii?Q?XmsHv/blcJfpnQ/JD05VpXZAeqG80O3UBdB1zk6gdjdzfwagBOR8aS/84J5i?=
 =?us-ascii?Q?XOENQqNjTtIVU611lUnpdNvFFq+vHVC1HF/VSLms5J3r395y0kJbGg75aCT1?=
 =?us-ascii?Q?6MLsZmmHygVBvvt090BKDC2dtGsMljfQLRPxrpe4Hi+SWyrcQ3OtMLIhuYvV?=
 =?us-ascii?Q?57tB9jxonrZvf+tanzpGn899xNu5OsdhlmDhfVPsnZi3O7N7QYuR7PCftIY2?=
 =?us-ascii?Q?k5PD9+fev+dtnkEhDWbSjYODD/JbckgG4L9n8cHpNXhYbYv6wdA8NgriJtED?=
 =?us-ascii?Q?SP3QZAugfTanbcK38gPEHqBkor94fMDvVTzo5dNsxVFLSOJSJSdCx1xxQIxr?=
 =?us-ascii?Q?Xyy03GuwyWjPdeFHgK07aRyTtUDZb/n7WJCQqjR12CksAWol/Mw0RoDrDIyG?=
 =?us-ascii?Q?Wb67S/DZNoBunWeLFSzhQJQXFMJ9nNaKBM1cV3uo7Y5/PBf3B2yvq0lLmlCk?=
 =?us-ascii?Q?rc/ZzWqZMF5flI2feBTyQ+GWJR914B2PAgAn32+xxFGbHcx1t0pFGiftHuPj?=
 =?us-ascii?Q?ijIvq6+sMXyNIoW3vIncwEAMWwVDRe2ox07E5sbBEswEIUgJOc011oHBbTpn?=
 =?us-ascii?Q?yjORy8jDEaBw1OfV/ZGBz6hMVxvBhuhN1s44zKLjW5bOTpEZrfbRM49IhaF5?=
 =?us-ascii?Q?BM5May2KNjG2BVUqQ660ObanvumVfhaZv3BHBZaHPRAyNz5xHGd80SbJJc0G?=
 =?us-ascii?Q?oNyl3Bt7Hi02oZJCFO1ALxYk7i0h+/0+9T8yKq7Vf9er56wxShcTx0J736ht?=
 =?us-ascii?Q?Osnv+ccpPCPeLKddE4X/rEVw+8qOaoJQ/1oGCt/InkiV7/MWwPHVN2WGBSo3?=
 =?us-ascii?Q?Txa7IuF0x37o4y/SKBhmpphwPkUfe8M+hWh9rfddgPtiCUoKM9zYnSWHEBdu?=
 =?us-ascii?Q?MPBPnfQ5dsXl/IvuvGPjOlfC8FW4sCeVklA/bjgAXj7WTTe2BaKJVWXrns56?=
 =?us-ascii?Q?aiL6UtkXJztM8wb4Z1fRZFz2vjxAFR7GjNyQS8ZuptWWxJL1kBrpL5pgNah6?=
 =?us-ascii?Q?LW7CQ8iKuaHPemFUK5LE0wRgEg0CmCowd6Mi/0AB0wiFlZz+S/x4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18ca36-0b77-4ad8-09ed-08deef186098
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:28:31.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgM0UVfvE3HcdydOflJabLxqf4UJnNXkdI4n3V9TH+jwQEZoXUqJL4JT7lPjyvHEKaQaBy3onUD2wu7/akhiesnLeqBYnXAuK6zuu6wtL90GjmQdfKG7OBnv8jbI9Tuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10487

On Fri, Jul 31, 2026 at 04:40:21PM +0200, Karl Mehltretter wrote:
> On Thu, Jul 30, 2026 at 02:02:05PM +0100, Frank Li wrote:
> > imx_uart_remove()
> > {
> > 	imx_uart_ports[line] = NULL;
> > 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> > }
> >
> > Is above sequence to avoid use mutex?
> >
>
> I now tried this, but it doesn't work as-is:
>
> uart_add_one_port() may call imx_uart_console_setup(), so the entry
> must be present before the call.
>
> uart_remove_one_port() unregisters the console. Clearing the entry first
> causes its callbacks to dereference NULL.
>
> The mutex protects those sequences against sibling probes.

Okay

Frank
>
> Thanks,
> Karl
