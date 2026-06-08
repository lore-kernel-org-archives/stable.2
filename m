Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23A2D5922;
	Mon,  8 Jun 2026 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886575; cv=fail; b=rTA8KwuiTomXHxJyYnyEZeMGcsN5whbgb3utprKCq6c2xE1GnPjS00dPvgxFncOQpbbgVUPGNDjOcSce7Nov4a2+/uE8OOxzW5vefm0N6I89OQ5QL7MshFU7p8C1iIxlAHDdVkeQfj3C0C2UxcBdBc9r8eimQZEBMywV0UyOKd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886575; c=relaxed/simple;
	bh=j0pLwEkx2mFMjN5WYU3p3PqKita7wJ15M1zrvVPNJB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=McX1jdlTMGIJYwDyJClM/nEbR7pL2GHIPlds2+WuIagCfjketZtJGHVWIwVTdOYClO3qpdOGJXtirdZYZ4ds+Cj38bnLHrQtWxVdipLHPbRHJe9uWcMxbpvC1bN/MxhLG/mURCmMfKPzVHcjBCLjKC9dAhMiCz4YdUh3snDUbKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d1gMBb8X; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d1gMBb8X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoebShPJ+GGTlFdxCOMIip/neX5a/HQtz37zJZfkNvbYSxMZzzReVYnn0ROy3HsYvpTRNHedImYC2f5HTK5Z5yjQ0bcyQ8CpI1l/s4afAuF1DLKp9z1sPyKJfXjCxV702I6MHrRMiEf8ENNmNJN46Jw5oewcAmUGfx1Sh7TLEVefJ6IDk8hae8Aj/XYyipWK0fbrIhBoKyNahYjtfLFI9r/mwNnvDcKeU/rjmuvbTK3JoECcPRMe9IeWniHBcImZXKLUJm5A7090ZIf+zdZ4mQ7/m3kHzM6tPVGJPKSGe1NkEsu7erTamDohlyd5vwgCM4HBlAV7MCKm3Qr21oo7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9sWY2hU3G6X3dJD3QTSn20uOs9mpAXGZqLHnPdpPgA=;
 b=zSaOS5p4JFYQJO+vNL8J9jFZ4cOItOKgetPFVxHcW40vSKWf+ao4vaFCOGIjaiXF7jGL4zHwE3edJuqwEfuAtHtb6zSsrPBtc49hvYZztzaanlTaT9VK2/zTRmc21SfcbFz02VZ0py3orNeG946ldRcAeipd1NmlyNV2VQ72tbjz0m58ScApFWZmFjdHDnuOAXBNEnDSMvdwxjnk+l1hDiKHif4S0eFZ7OhOT64kKpRnF4tkGETinmXwqo2DmcMEMLaBq8gKntdVzp9+NEIfhPPTBHP+djwAIhBaHk+nUG+ALk1Lslb3UT4tATBOmLkSLfjUxwJ1Cer4/ZlMmq/XRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9sWY2hU3G6X3dJD3QTSn20uOs9mpAXGZqLHnPdpPgA=;
 b=d1gMBb8Xs6zLNGR8sZ5ifZuLFtr7ayLINOz7gwvShf11AE7135U11GOv9tgJZC5C8patqaXfpqhEeraEOZLlNS8wqJ5EeYVAGT/L6PaPU2rqs3l1yIdEQYqMy6bcRkU0tGsgDHmxOKz7Ruvig0dkf9qcfhtJbVIaas4c3N6AfbTWTMgWQn6xF1by1aJx1fHaS7qFiAEaaO2GTavVn063H0Zelhj2rpv49FriqpPixSW2CfM6PtVIoQkhmTEtuTE8RaIGJ+vpBQ7VnQ+8pEm5d2iwrrLnlriX9+KmTxUaxRKBNdFP57MHxvaHkHldUel+9RoqW1PZKzS/NvK2i8LbMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB10656.eurprd04.prod.outlook.com (2603:10a6:150:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 02:42:50 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 02:42:50 +0000
Date: Mon, 8 Jun 2026 10:41:45 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <i7jdx4j4kd6dcntitqrcz74d47wfqv5iwc3zdlwx7rs7xoykql@ivj6mxr2zyva>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
 <aiLmN2yUsqLadbSo@ashevche-desk.local>
 <aiLw0bLKiipMCZC5@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLw0bLKiipMCZC5@ashevche-desk.local>
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB10656:EE_
X-MS-Office365-Filtering-Correlation-Id: e47fc61c-8256-4635-60a0-08dec507a185
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|22082099003|18002099003|6133799003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
 pd85/FTVCiKf/qCOGOUsygAKeZG2gky5+rUWS+sfAtzv0tIV0zNnfDHjZtK38JH6+t/oUzbYmEu/DisGzy4J7LVBD4V+Kyo6etrfEpeLZ3AVo0j5vOO9w7QxklTYMJqDFsurllGdUhsS3pGjUzaXMAXkiAnoQIPbhCUc5Voe3reI1YHYGPrGdkTS+erqgl+OqFksFT/96dMWxCeC3fgg4maoDABIXh3iy3e/OCls0v6mB6sQ5yUkrrUlx2exRAjD6rhUdf1RNkaewg/HU+pbwSg67gJJfHXHKEk1EantfH08hUNtk1fCKWj+W6NXwkDz/jynqln0MyUOmlDfWICWXfcD7zSAmQ8VnX7mqk44o8g4ErDSYqW1ayCmlL2PuoI60H2Nqj2w0l+USUYTtlnql0DUkJN5M+F6VEWwCf1t13QxplVh/ng9uCsNf+voUwEUap3eBR51OmCY43ZBlApz+wU5nriBU/883wf7osluY/Zdnd6GMbbBvokAS0zpdr8PgH0rTpGrY8neqEjfoLPuS/mvHbQ+ucdBF3i1AHNIYIL2U/PcIQ9t4TUFFDWwrJndwV6lmj+szyCu/A7VeWHarkjUYIR+Jwbz3iYD6DFNa45wt8LPULh0fKYI5gTQ/Mj7HiXJODNBgE3PABm39wYIh9rVJ1/XCkLWLQOw6mbzvm9JqftX7rhtORNZuOgvPMUj
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?aozDJL8q62J98vytu5LgjfZIyUR7T48r/lwxwmB4pDkpHhYngmFdx27gUKQ4?=
 =?us-ascii?Q?Fsr+Q4z7yB0B8c2pcPZRW+S9bSFAxK0orB92MndSoBtnwLq1v1ePEqa0P+f7?=
 =?us-ascii?Q?o4PBvgafIUsfhpqFhkngftSZPBIjNIS2nYIVxvxFKWJ64Y1yUP/WrCpzz4As?=
 =?us-ascii?Q?vxFVEekSVZLi7Q1ps59h97/J98PdcVK+LyARrEvjC+7JB1vq01ISDWzzj7Qj?=
 =?us-ascii?Q?rkAWPXlyxF799FJt6UdD70QPgNo4skbXTbhIWwSUY9oaeABCNBd/hrc6IyKR?=
 =?us-ascii?Q?hEVG0UEkH7CpbBIq70ljKtV2gQz4d0fTMIgEvJiY/yOe1ztF7ltOQ/nrPes0?=
 =?us-ascii?Q?yrwHZ3w8y+ZpgLIk5qU6bBCVB+R6we+f6j2+wbO1yGBQSYoHYRwQr0Xd6FCT?=
 =?us-ascii?Q?zDlo6a3CyxDRQDRrMMZlScJfOhwYzWLyF29JeylUPaO7hfxnVtkRbvkbQDgV?=
 =?us-ascii?Q?BZOIxcPEcq6XhdSac+kPyBhFA1A5Z1R5j/EDOuYAhq7SExLpyoDXufyjal5M?=
 =?us-ascii?Q?jItCwFYxzo+4+AZ4tWcBPPQGb9MTBtlN5WibYMCYB3Xf5hq+PaZ+DLENyaJs?=
 =?us-ascii?Q?2YPIUY9K+fQWKi62nPaIK2OSgY+jHBmMLF7Nd5k/1tjPj72BBvsNzJXFrbRZ?=
 =?us-ascii?Q?ZUwTut+c0soalb3rlqdAh9KX5DuqIyJNYAFaC9EpqhoXtX+MK7XL7I2v1bQG?=
 =?us-ascii?Q?vh+W82/I+kicfug8qMc9715hwVRwmkKZeLCQDVzkLWsfTZgO/8sW52rf/wNy?=
 =?us-ascii?Q?dT30HcFOGTxFKXj7dOEhNjVnCHugaTnrDHL0hBeVAyYUwup1lXeI63FBiJiZ?=
 =?us-ascii?Q?ATfUUviCWqGrQhuuAx3zADzSZDTIp4BCRQK4tiOh+uXzalcLZZH7GF/ig2gj?=
 =?us-ascii?Q?c7UxCk/QOqrpNrS3AKQA5LPpsJMXQwlOyjeGONIs1ReHpkh7AJ1TEcyery8R?=
 =?us-ascii?Q?rKfAIBjokw6d87b8a2TOS+bHLfBmOURb84jgu4vv301dKldg0UW728EvxZlL?=
 =?us-ascii?Q?AEIaIanTkNF9C9Cbn7pF2pCiHqboqYRSrb78sBbhRM9fDym5qoF/4NKvALje?=
 =?us-ascii?Q?64foOQiQ8QIofx1DD3N9/ttSFjD6MLZE2+mGjusO62oz9TR6GHwqiOiksib3?=
 =?us-ascii?Q?UBvbBdnGCI6tChafM/i++QnmCd5MwGJ863P8cwWI9ThIJazoMAAltSdUvklt?=
 =?us-ascii?Q?IfRe0w+4ZrWpBVr0O3mainowYNjCNiGLdmF4oB+hq+iJ3lrF1bxTHKhqn8Xn?=
 =?us-ascii?Q?fY+HKyhd3Z4A9gVpOuRZ/FV32yZK/9+5bGOX2wMR6PcvQAcKTFC2vrGAoAx7?=
 =?us-ascii?Q?eAgjYCih1xTHc5kyFLtrQtgDde7MXQA9CVR49pjXQ85JAiFRAGIsV4tPWaK3?=
 =?us-ascii?Q?OjOJkTwUFlXywljKyeoNAAtwfV/xcA5mJ/H4SjLKLHU1rnwXxKiaT4ZletS5?=
 =?us-ascii?Q?fbqD6U+ojWRpfYdv2Hx0hUu9OAHJMbI0AsKUqr/rnGgwMPTKHZl/8+SOSylM?=
 =?us-ascii?Q?t5zk/9hzbgrhK06jvIbeEVKZucpqJYOz5ua1i6eDa01Z7Lb1og12Nggr4VGG?=
 =?us-ascii?Q?uKrTMOTlVHrzUZybkpoQrHz8dNmtAF2QjeBY64OJs4wUMUG8sHE0TN+TGTlW?=
 =?us-ascii?Q?42VpJNG4SrE2d04PB+YuCCVmhjsv4YDRD0m4uKd4ZoJbjJKEO2tEpi1oA04Y?=
 =?us-ascii?Q?3P2dboio8K6KhbFdhb7ccvR94UmhqaHkMSjctefCeE3yWgRPiNo6LicCIX+h?=
 =?us-ascii?Q?hvNhDA9j1xVfu11rHklnqYXpAjEMSAmZU8G9RyNecwAMJN/ocncL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47fc61c-8256-4635-60a0-08dec507a185
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 02:42:49.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqPbZ1pwPVfF4SrMBe9wif3dE8+x7NEXS8koJB3oEKbSuwnmYsPVggsOuZ9g1zfN54VvfCY1JMDbcG32STlNeQ+AUJCnkl2b/SiM7A0Hv402vlze+6PgsVTYJ1GUKnUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10656

On Fri, Jun 05, 2026 at 06:52:49PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 06:07:41PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2026 at 06:31:16PM +0800, Xu Yang wrote:
> > > This series fixes two issues in the fwnode child iteration logic when
> > > a secondary fwnode is present.
> > > 
> > > The first issue is  a refcount imbalance in software_node_get_next_child().
> > > When a software node is used as a secondary fwnode, the iteration code may
> > > incorrectly decrement the refcount of child nodes that do not belong to the
> > > software node hierarchy. This results in refcount underflow and possible
> > > use-after-free.
> > > 
> > > The second issue is an infinite loop in fwnode_for_each_child_node(), caused
> > > by improper handling of iteration state across primary and secondary fwnodes.
> > > When iterating over children from both primary and secondary fwnodes, the code
> > > may incorrectly resume iteration from the primary fwnode even when the current
> > > child belongs to the secondary, leading to repeated traversal and a loop.
> > > 
> > > Both issues are triggered when mixing different fwnode types through the
> > > secondary mechanism, and stem from incorrect assumptions about ownership
> > > and traversal context of child nodes.
> > 
> > > ---
> > > Changes in v3:
> > > - remove software node patch 
> > 
> > Hmm... Maybe I was unclear. My question was to investigate the way to actually
> > move software node to use the swnode APIs (and not fwnode ones) and be on par
> > with what OF code does. This series does the opposite and adds a hack to the
> > next_child implementation.
> > 
> > > - add a kunit test case suggested by Andy Shevchenko
> > 
> > But thanks for the test case!
> 
> I'm preparing another patch (just a clean up) and I see that your test cases
> indeed fail without any other patch being applied. Also noticed that the test
> cases are not fully compliant with the requirement of the "primary"/"secondary"
> fwnode flavours. But this doesn't affect the execution.
> 
> I will play more with this to understand the problem better.

OK. Suggestions on the fwnode flavours would be appreciated :)

Thanks,
Xu Yang
