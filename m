Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89659145FE0;
	Tue,  2 Jun 2026 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430741; cv=fail; b=gvhbvP7hiA59nD2Blcc+gFvz6oeoq1hrARfED/vVVVAh+ZhAdAUHwZm6zCBx6FRwrmT5NoIKGd2F83OGd116+lMWutxs5RzPF9JqVtkijvt6itFgMDAXpmTeypBbG1mS+CG28D9F3kcfeLhY9AFpU4LpoZxib4stjw+HJKtiVW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430741; c=relaxed/simple;
	bh=BEJ4S27bUhzZjP8p3aNREtLu5A+uQHa6uwLOWVH74L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cahi+np42znMAotPX2XOa+mCvy717tri/OPZ/AcE6zQkBt1LuLHAXFT0z2cCSOeIpmzW98yuxWh3z+Lx+YbqRTGJQOehJbBJ94rAyvXTyQOu7rGfZwJyB6beS6D585e/BNs6HwgUA/aHK06VTTkRxCngxodxhN4pg26Q4k5/MBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XJwfDRjn; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJwfDRjn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnddcujFLOEcTaDf+4ZlNj/wzqGRPxSgilD5ojYBz11DGW15HnioDkyUNSxbQQI6p6POgTpeGjiCPeLhKc9X3SqTszxSkVmLUiGYi5PbqUwUkcrRyJeE3ATSJGVMax/2A4r3PICJrtttjLAbvcEsXmovJsLFXiWDUmlO0I7/i1d9hn4169fM4+pOm1kluAj1KmKuTuROkvzlHeR/wHmmKQOPt1GK0jQ7WGxgvhMIXDukFBshRFQeQWdlmp3Iauzjfhu/zd7hpWPzX/Y7W9RUvEeNHCHu3kzHYPWi7txEBGaHWZdgq27QlsxIToLtZtHYxvvm3e53xxpRwgaKcJpb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEHymzM8REI1mEb9RSsCo+Zr6kPnHI2DMMbYoGejKyk=;
 b=oLrAm6jJnFwcrCoGirpK2T3Cs2Q6Fy0dN/cwnWna3TdQcFhRAenGFdz8C+pPkxlidlXEFYU8oxf53r/63tyiBh4ThhVS6+yD1EF8VfepSLOJUQVRToxdUnZoy74tmaycEDhjw/Nd7KVfWf6lPcPuWi97L0Bk6XNkHr6OmG1A2wJ2/VTDJOXejlQT6VaYd11+lWOLZWvaQFIYYCQUY/yzASvhAwvNqjMAC0OdaJsrIweAWBgmuphN4kka92Vh7PjJl41gWdgFmcIi0cSoZvtX1IckpvF8DnlB5DWsCtgG0y51t/UrzZdTKcPMBIVV0OOFGAhsp1AWzYILn8kYAscAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEHymzM8REI1mEb9RSsCo+Zr6kPnHI2DMMbYoGejKyk=;
 b=XJwfDRjnWQIKfc1FHoGo9mzZH6EyJaFUefbmv0VhYwuNAIXbZ0HjH+XvPhwA7ki125vdWPeYl4OiXiWHW8I57z2VaiBc3tGNnwlHDPwSQ8qWsr6llrg75W7Hfxk3E2NVPwzQgL2i0+83e3wJigVd2mN4RFgSTpsxTdfjQVFbjQtP1c37FAikxmjCd1Y+Hs/b/dBvQnPheHvZFyilNndWhHiH5coQ4pzzzcmcu/68ORg5WYknpqGpkB4DkS4riOkHQ5l1VKbfB5puqu49yFf6VHAXYqRvpKDdXxbBF6hfT5qjo3SVjG48vROCS8Xy+k87bnRR0I9b+YxJCuxhPGc7Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 20:05:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 20:05:36 +0000
Date: Tue, 2 Jun 2026 16:05:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com, p.zabel@pengutronix.de,
	claudiu.beznea@tuxon.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/17] i3c: renesas: Reconfigure the DATBAS register
 on re-attach
Message-ID: <ah83iknpm9uhdi4S@lizhi-Precision-Tower-5810>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
 <20260602132824.3541151-5-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602132824.3541151-5-claudiu.beznea@kernel.org>
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: f47da884-efbb-4293-d88c-08dec0e24f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5eYcjCbsJVKDVL9FSf5iuZpSBKssrRMXvjBoxdgBnL1QPWwdHDBV51OGok8wjmHmCBqkG0bhUFU0PhixdgxhhsE4ibwq0k0FlfIB1tfCeuNNYWQ0A4HMdnm+zPhS7Vnuc4Tkwo/J2Can8RdgMIfUxMoUoE84RU5U5BtP0YlXmAFiMG7mx18yufeg7/ziYt/u0mUAJmnTAu7Bd6ybV7II9NIlgBeNPrtlkp578zWvqF25p18U0tAB82wcYV3b48nrE+TGbVrP5OXFSWyddqhY1mgkkwXxOWcc/SW9twTqRwjASJ/qPQ/dqfte0Sho+Bgu+odIBjQ6FcZOOpRS9pC+lMZ7GBn/lIp5/oQcviRJpTwPFhQBofeZ75mx1qItOLfnh6tILbmDxS8Qr7ShRaly0w/Sxv5eZu9Di1o7Z+ZR9rLNGUAZHqR8FCPXZjSTKTPGh/8pLCMYxXPIRDfvSUq6/wgeFmQ4UQRmEKKjD4vq3beTkkIsWuTrDpmmFfjDemVlELhahwRx+x11jGNOdYhzysVBfDBNx3tMb6yQYavXJq/cimgX/AY+oYZL3W7KvUacWG3atmXRHgh54lUAWPB20zswFJuDBWRt/2F1y4Fso+3nvvFNbda6KC3NhfioQvR6uOASf+i2OLEckOHBwwSnxIE9QKO1EjPTpqK4aGOI7qXdhHGhEFf0hOKABc5ubJuHXRixFRcyAHCjl3kpwuaC3XJrxt4oRllbbrFZZ9BJ3ItkVMiXljQapkvbQv5erLER
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tFpmegX0mNck3U7zpIcXOn3Xhw3GF/PIa7JGgfaEfAw4UrNRf5AUkQobrf3g?=
 =?us-ascii?Q?6oG3042jB03sjhNcUAM0jCuzstc3hI+KjZpF4x+srIxMH1rYqNwB1AXK0qgf?=
 =?us-ascii?Q?kmjrr5CPNgSQME6SR7jVSnxlocBQoRV2V5A51mlzgFzQZyaY9cCiJG1fkARU?=
 =?us-ascii?Q?D0B2dF+vh7s2lMGb6rtk+KYI29uE00pgxC+6rRdwMX6EKFY2P2XyvTK44riY?=
 =?us-ascii?Q?D898Pw257x1DvTCt09W2ThwKPON7ICzpbkfshmbi0KC1Nh00MxI9O1t/UXwN?=
 =?us-ascii?Q?OsQQV8pKAXaTL5/Vgwi8h32y64fGeGrMJPx7NiI5cNEovQVe4/y1zltGdM/G?=
 =?us-ascii?Q?4kYbGWr3pDbKuPKYZAH6pX5B3h2fQHS1OwwIWW9gbJnOQcpXYdkcgBdUDc5Q?=
 =?us-ascii?Q?kwq6szDiEuXCVAwEfyTgYWx4OECbIVgE/f7r+1Td2D/UJc27snrJaTZzaQZL?=
 =?us-ascii?Q?xckAMUwgASKnqyXF8AYWkAqa5LWUpX2Nvb9Qlwue13dXCzkzpvOLM4h0uHEI?=
 =?us-ascii?Q?vXeVl7yzp91XGxb5tMHy4961+EYOr6xod1PkfuBEut4pvkzTGRn97t2fnOUw?=
 =?us-ascii?Q?6P1q0vnR9DQYQ7uMsXXKyzhn+ilPNNu54M6ZR3Qzpz+N4FzQgNVYPhkmCuf+?=
 =?us-ascii?Q?kWJ2qv6neicNYdnBbEe6BbvxodXekpJ0qcluDRCQB9QnQedEF7enmThd21c6?=
 =?us-ascii?Q?0wpG8v2SuXGUFrQTyhVTa05tKyXML/y+XcTNPCkR4jpgGxq305QtqRZ1j9kY?=
 =?us-ascii?Q?EibH0bUT6cHnZPHhQbcfk87yg0ziGZjUoZ9egjfrrZV6ia7u4FNxGxIGjgr2?=
 =?us-ascii?Q?n8KZHrnc5o1c70HeoUP3VS58Tga2iYWKMASrnVKiX+g16Hx0ltYxZ75c5/Ga?=
 =?us-ascii?Q?OxxYzd+qTqoUuhxl4Qdu8+jTvXZspJfl01E4cBsMM1RhBdI56Cq3G4fzvfdE?=
 =?us-ascii?Q?0vLNIrn8Prptp2KF++ZSn/cFWTnvQjSov0NJz+RInN8z5+7kdUr6Yn2//W3B?=
 =?us-ascii?Q?eBVVIIOr2fhB+MA8fPosOcPC1A01EFL01Id5cu0DoL3kVGemt2MTciworCh9?=
 =?us-ascii?Q?7C/InvUk+BIgMK3pYiRQuM8NlQ3Xj+AQjgfrRwZVKvtaeaich41mpCdeYtbR?=
 =?us-ascii?Q?AyAFn4J/m2T+F9UzJYPdTGRVCDpILurRrueegPba6wH7zcD59uVWa9QS6V7p?=
 =?us-ascii?Q?CcydkoKEJo8TFm605YVgnOEJDh4DSjBP4lUZL7nVOB5qYcfmcIrmbbGM2DqA?=
 =?us-ascii?Q?5sHV/aEaA/hYscYWyAiertXYjSHrfhKU3hq9dWbPpom3t777M5Hl8X4EZhjU?=
 =?us-ascii?Q?rShhKzuLfOgSTP+TEUthGATtAHoyGo8Rw61/JRgdp9uYS51ByClTTKs2g0is?=
 =?us-ascii?Q?MPOoiNOO5oBG8cJv1DgHyQ0V3SgSyHuRMeiv3cpNXFQJZllhhA3Q8agEpqJg?=
 =?us-ascii?Q?FDDhthlfX/jWPutQUL+rBN3kp88D7GLAvEXvd/y1G9ec3Wp77YNdN+w2zV26?=
 =?us-ascii?Q?gkyhvQucFTObMwewW69kuYXGYKNYxGnnPch9euko2hIS/BXAd7tP76vjphJX?=
 =?us-ascii?Q?kgfA7RT0GzsaXPzrySL5rweTrMYcUhcDhV5TvAzUIRJvzN8BAgtCB9mIRYt/?=
 =?us-ascii?Q?cSZrI8fD7VLRVilSD+DZ8rBUWMjL6VM0ERN9Jb2T3EeIrro1FX1m6hMakkyp?=
 =?us-ascii?Q?UPXFpE0H/1iDfmEv38dV8jzTPLBNisDPEHAY2V8xyG6CPK8nHOoOk2ZGDtnV?=
 =?us-ascii?Q?4JxAu4tPzA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47da884-efbb-4293-d88c-08dec0e24f4b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:05:36.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bOcgKnx9M015Lq9/fdS3G7UvcKxu7DcsB3rnQF7seEeqNFOIzgNcxY5dRK7NVH75VUsaeftnBNg8th/Mj3Rqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572

On Tue, Jun 02, 2026 at 04:28:11PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> During re-attach, the device may change its position in the i3c->addrs[]
> array. As a result, it may use a different Device Address Table Basic
> Register (DATBAS), which needs to be reconfigured.
>
> Reconfigure the DATBAS register on re-attach. Along with it update
> software caches.
>
> Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Changes in v2:
> - dropped the "if (pos < 0)" check in renesas_i3c_reattach_i3c_dev() to allow
>   re-attaching in case of a full bus; along with it the condition to update
>   the DATBAS register and software caches was updated to
>   if (data->index != pos && pos >= 0)
> - adjusted the patch title
>
>  drivers/i3c/master/renesas-i3c.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
> index 4c86e7257804..76a4831098c9 100644
> --- a/drivers/i3c/master/renesas-i3c.c
> +++ b/drivers/i3c/master/renesas-i3c.c
> @@ -892,10 +892,26 @@ static int renesas_i3c_reattach_i3c_dev(struct i3c_dev_desc *dev,
>  	struct i3c_master_controller *m = i3c_dev_get_master(dev);
>  	struct renesas_i3c *i3c = to_renesas_i3c(m);
>  	struct renesas_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +	int pos;
> +
> +	pos = renesas_i3c_get_free_pos(i3c);
> +
> +	if (data->index != pos && pos >= 0) {
> +		renesas_writel(i3c->regs, DATBAS(data->index), 0);
> +		i3c->addrs[data->index] = 0;
> +		i3c->free_pos |= BIT(data->index);
> +
> +		data->index = pos;
> +		i3c->free_pos &= ~BIT(data->index);
> +	}
>
>  	i3c->addrs[data->index] = dev->info.dyn_addr ? dev->info.dyn_addr :
>  							dev->info.static_addr;
>
> +	renesas_writel(i3c->regs, DATBAS(data->index),
> +		       DATBAS_DVSTAD(dev->info.static_addr) |
> +		       datbas_dvdyad_with_parity(i3c->addrs[data->index]));
> +
>  	return 0;
>  }
>
> --
> 2.43.0
>
