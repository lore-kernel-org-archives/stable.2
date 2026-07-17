Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6C19E992;
	Fri, 17 Jul 2026 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256499; cv=fail; b=WTPagbrLhPbcA90Tv9EYgPPQ7+l7HQzTtqyk++Ti4zVAGYTaKHVnQGSOg/dG7EwXAUQQVIi2GB822tNFOFA9Y3RY6DsNyRgbdlfd5rBjmSnsx3/Ma6GlRlo7dzRq665NncNrE3dG0Xy1OLEJnoIDb77RSC5D1nT8MJCycVVyKZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256499; c=relaxed/simple;
	bh=lO4LeWUQ6mQRXShmR9eyIYr3aIqawHQm5br+e486QXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HRpMjB/Nko+MIqVXJcqMTfi1zD0FOay3OF1MxsJ7PSX4eGZxSjFYyA81NZb59SISlC6RbXXAB7Iy0b/XaPwdBCfFR7xIg6HmsHD16Og2n8+Jr9K9YfBcguzxDSNO+Nf3htmoyUk898J81mCPsMHmHnzHxU4vMwRXLL7YsQpQCTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lB/5ahZy; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lB/5ahZy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxdiNZ9ycGdRpFlLd+6LP2bpTXH8tZ1wO60O8t1n39xzPfhJJJZtjLpA93ZITmdO2piL44TYNascsZTOV2XcB7Vn8lVfvyI6pY1mmisXfNuk3XZ14uskFvDQ2Hj4nXH4C8rAjtFVv6i1lklnm58znFZy4mUS7ne7wWj9xn3EJfmmc8wUnFS0gQnTKMv30DgXXKWnW9z8xvcENn2cAuPbxCTmhG63w2XxmQl89ph/4hQVcYQ5Oa2eHibCwixkWx6Mnuo5FDJ6upBIJocn+fY9PNRlL618N2duCoM4mT6v/GSyXZoJFlN0s452MdJL2nyLLyzeEKiEE8XsbyKrQ5BNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2gfCWW5qfZtR/nYiDlU+erzcumWxlvlm5ekaNVG1cM=;
 b=C4SqucikR5+GPoej/IjMxucjPlEBTleDRZvEaCUKc0mGyvXOIyP0hDonDAxbOvXK1wFUp1b5PtFjV3PqGnnWgq3XJ9dfZl13WpxX9bEOsM6peKupWiqZT/jpH3+6eLs2S20SSmybe37Rfcy38iet4beKIH9GFEI6Ep0/NJYJBke+2yjy61yItdJWqjKoHhEwUeRvawFW1aMrmM9GbN7p24/IUY6tUrnB5ZpVzVC+WZK4AW8EDyjia5ND6eSnDzRH6iFuQgjro8fTQrTrgzKrpE/kj5TNlZQ7w2Z3pkzIPVaEpsLYBogrHk6qnLV8QmC6lYUEn1i5X323+e4exxmUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2gfCWW5qfZtR/nYiDlU+erzcumWxlvlm5ekaNVG1cM=;
 b=lB/5ahZyoO10B0BK4HTR4UnxqmVxY5B+hQ5Q0gddFWyfS/xj5iHSAB/PIUUvZDJPQi61fieJDRJnogk64EIRQDeNXt8MOgFdJCc/d/U13fTF0YVTjr5ZvNtp0roCu99At27/9d45qu3cQurqZ5/NrAEfkvvLuzy2evpXrjWxET6MT1EirE+1Byl9CJc883aktchOMu//w3PdFntB8uZRe/NF2HuDGbRfCukTn8U+Y/OxmWaCpWkgnffKXK9IXu7N1obiDrrpUneI6Frg7fOhgKonkC0mGJPKXRGgSf2elhLZCTBRQrLqU0ZGWHp3abjp1L4L/AXpMoOOCLZfjkAs4g==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VE1PR04MB7422.eurprd04.prod.outlook.com
 (2603:10a6:800:1af::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 02:48:13 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 02:48:13 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Soeren Moch <smoch@web.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for
 i.MX6Q
Thread-Topic: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for
 i.MX6Q
Thread-Index: AQHdFWva3lzIBAkdE0+7w16ylxS4DLZwuZwAgABFuWA=
Date: Fri, 17 Jul 2026 02:48:13 +0000
Message-ID:
 <GV2PR04MB1201921DB5CD30DBD9353CD0C8CC62@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260716214054.47372-1-smoch@web.de>
 <20260716222704.GA240248@bhelgaas>
In-Reply-To: <20260716222704.GA240248@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VE1PR04MB7422:EE_
x-ms-office365-filtering-correlation-id: 8d21b9d7-d1c3-4f48-a29e-08dee3add891
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|6133799003|56012099006|22082099003|18002099003|4143699003|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info:
 54+Wy1EzEsmiTSQKyaBkd8vMR+uCKsTAV+0z81yf84ugadZSoQWwZSDJWkJSYWO0wf4sDdgNz4xkkC6z3WKT5LZIWwhXR4zHJsdeqYduSLehFHa0VGpx9RWGdBvaO90ACnS+zPkQqQyUnflX8Nl+LtEUqu+7V/nBN4ECPkYRyRNt8e/2ARs9CARdpOj2Poehmb0EMO0JIRIyqds17N/kQdhYu86dg1+XXaXmik1N5dStezHbT1V2lXR8MhwMAXURAeBSyQG8JFDbxNnK1AnU1o5qkuZBGXV5BwTVo/ZLg1oNLMIyqri7q5t5uqHQPB7FV534m6uxP2TgXtypECMPFzKD8tQof4juJPAk58L20at6izZ3k4QHk7LpLgoMOMoNBaF5snWXi0ejaLavlz4MIBJp+Py2ya6XQ8AmP7qI0TnGdtBe4ggR3hkZAO6l1KFF5H48jOtvT/d+3G6z4w+OqL7gpeZfODoAVrBnXUyVyqHvo0tn4hSWhaUFGqjyare7qK0j9Sh4wcSnjLNEO3LZfgyu9vqRqJe48UUpL7Tzz+FBcXRXLvmjN2+Tbhiwu8ncrgv6+U+nzG0ev+MW+sW6pZmaGGS+rfFOnxGV/m/HfpftslLPv/22/ICRDCgxd9+HGekmugrQ5A2ODHoS2ednOBgeMFHW4t4dad6tSJoUfO4PkzwZYJzRkPi1L7OFhQPXVhJYokXHFPlMhLWNan8al/qDOv38ZezpRUmAq/splTI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DNLYWI3vqKaz2mPT3xYFvFa2Y5nVmfUbTk00nGM4REBzBlQIx1Ac5r7F8Y4z?=
 =?us-ascii?Q?jFjrGZ/hoUt1JD3CqI5dtogGb/MRfPdIvyikrO1LecT4QofTrHmUyxFOsmTy?=
 =?us-ascii?Q?u+XYZdQcBkCbKiIWwtPo8ZJXKv0S/f3ABViv5cuia5TrPlxYbGQR/oMwCCcm?=
 =?us-ascii?Q?qFbzq+kplQzXs3uZROmMsOYBQw9qJII/S68SA2JhptFPcqpi0zBTMFTeP7F+?=
 =?us-ascii?Q?TwlwvSuNuEgCQ3wv+wEL/Q0/yeAquCLmc7CzAPCOhgfMBEy0WhH0ouWDpFry?=
 =?us-ascii?Q?ielPfzFl9J9B9qXcD7xA+9j72TiTbK7m7v+f9NsWb9fYVuwCTsDZ3cB4aNU2?=
 =?us-ascii?Q?JOY4NHI9q99TTnDl8GKPct5uMBU7dfMkEtyDIoMhdSb25KG79b4NZeWg0XiT?=
 =?us-ascii?Q?mCRzIC0IoGV55mZjeyu3ZNy+DlxllCrNYVufIKBpsx3KjlrYHqc6QFNoMKQu?=
 =?us-ascii?Q?F3CoVQNnIFOU3FnOQloQ/CZUk707zH+Q75MkfUXa1U7sh3WmxjjsvQDekxNQ?=
 =?us-ascii?Q?KC5ihi2BmssYHR/ELt8wWvFK7m1YFE8jnMhZVK1Q7rrENkCFfosShPgAECW6?=
 =?us-ascii?Q?AWTjZB2zzDHubqeLqHZJGh2MUI4uzEksSxDuq/f44oCWjCnYAjsrZGjE8kzs?=
 =?us-ascii?Q?jkezRkJGxRWdtT8yhtiqc1X3M56Hj+uavCDJW4VzE/St37PvxtDxDxKhXB52?=
 =?us-ascii?Q?F1G6K7Ynr3/mFg90IOPWtqoQ/94LnZ0U8C3n18c7HrhaFnKhmWCSWoDeOjib?=
 =?us-ascii?Q?abkP2xFXVmBB+vkOBV19VH04x8XlH7IfESlQMZUFesyNJkGwSNQtBQba7p7C?=
 =?us-ascii?Q?k5VTmRcmkNTUNeDOi4J3yIju8+zR3VYBwzu9v6Dy+958SZ65z3qUqSk2omT3?=
 =?us-ascii?Q?HB3/H1JxJ5DFXGBC3dn1fcmctivPTLt+8lzZ47dAccINjBX9HLh2iX/oAAxu?=
 =?us-ascii?Q?ogs3o2FcHkQRDhdxKofWuH9OV3KUdehYdXxmvjLcAyDT8tusjJrCVTC4ISsv?=
 =?us-ascii?Q?11xWyUGB3QOu6RGrleZmqaWzYnRN1atNvsCtba5Y7aA/N/OK2MHqQZ78rDRR?=
 =?us-ascii?Q?e/MexDLWgRjTAgyz9/2ih87o/QCaXz1UIHJYb7wJnMP+U41c3SI8H9EABKKk?=
 =?us-ascii?Q?ZGUkE6XEgf2ppbC5Lpap3dzF/nAgmz4ny66iwdw1CNzbSc3jcGR3xxE6F30a?=
 =?us-ascii?Q?bZsosYHD+HCeYrRau541rAUxXunQ3WKCXB42Q8c7/LEbmJxTeUQnY3eq4Lf9?=
 =?us-ascii?Q?k74Vnp3h1KWQ7LAwPoR6Imkg614NNEswjF8B7+XluH1G9wtj3dUr3RjElPhd?=
 =?us-ascii?Q?sGeSqpnbUuB2ZP3cnUGHH7aFJ3nCpp4vQTIiIbjc6GH+u1+EbZj2wfwDAQey?=
 =?us-ascii?Q?s4RgZj1T2kXYitjyRb/Zhsfhn8RUvmmg+f8jpAdLOBxa6tJN8ab/CjDuhqSK?=
 =?us-ascii?Q?Yf6VVsmOXbpalGq2WWDbwZYKYj9NtEpWrKdg2DZ2xddZC5mQeinwqDNixC5F?=
 =?us-ascii?Q?7BGgPN/I/I8aGKgnEwHqyEQK1SPi/cSFNFMOKSoqlCKw1WBl8J05FXyoLmNb?=
 =?us-ascii?Q?h3ze+Zct2GjOt9bWPGXGa44fjNAl9mwQMAR3wsmbbiTaQfckfv4TD7Xv0roW?=
 =?us-ascii?Q?atAXbWaMeGiO81egwwGgTgO3z67Ocfv95LGwPyqXbIKy98PyqggXhsgvqLdh?=
 =?us-ascii?Q?jPv3pPk+ETKzc0+ZGAU8xgniFqF1ABwPDb9CMmfC5opZOXt/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d21b9d7-d1c3-4f48-a29e-08dee3add891
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 02:48:13.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04k2LmHd+dv+6NGqPMTVtAgVKPrvWA10NYXog1SQ/YwUWPQXLHRSnpTZqtDhtLSgLnJn7xi9wpq9Kq69gHt7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7422

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, July 17, 2026 6:27 AM
> To: Soeren Moch <smoch@web.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; stable@vger.kernel.org; Hongxing
> Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>; Manivannan
> Sadhasivam <mani@kernel.org>; Lucas Stach <l.stach@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for=
 i.MX6Q
>=20
> On Thu, Jul 16, 2026 at 11:40:54PM +0200, Soeren Moch wrote:
> > On the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
> > the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
> >
> > Even though the Root Port MSIs won't be received by the iMSI-RX
> > controller due to design, this chipset has some weird hardware bug
> > that prevents the endpoint MSIs from reaching when the Root Port MSI
> > capability is disabled.
> >
> > Hence, always keep the Root Port MSI capability for this chipset.
> >
> > Note that by keeping Root Port MSI capability, Root Port MSIs such as
> > AER, PME and others won't be received by default. So users need to use
> > workarounds such as passing 'pcie_pme=3Dnomsi' cmdline param.
>=20
> I'd like to align the subject a little more with 3a4e8302e72f and avoid r=
epeating
> the ".. from reaching when the Root Port MSI ..." part of the commit log,=
 which
> seems to be missing a word.  So I propose the following (if you think it'=
s accurate):
>=20
>   PCI: imx6: Keep i.MX6Q Root Port MSI capability with iMSI-RX to work ar=
ound
> hardware bug
>=20
>   On some NXP chipsets, disabling Root Port MSI/MSI-X Capabilities blocks
>   MSIs originating from Endpoints from reaching the iMSI-RX controller.
>=20
>   To address this hardware bug, 3a4e8302e72f ("PCI: imx6: Keep Root Port =
MSI
>   capability with iMSI-RX to work around hardware bug") preserves Root Po=
rt
>   MSI and MSI-X Capabilities on i.MX7D, i.MX8MM, and i.MX8MQ when iMSI-RX
> is
>   in use.
>=20
>   The same applies to i.MX6Q, so preserve Root Port MSI/MSI-X Capabilitie=
s
>   there as well.
>=20
>   Note that preserving these Capabilities means Root Port-originated MSIs
>   such as AER and PME won't be received due to separate hardware limitati=
ons.
>   Users may need to use workarounds such as passing the 'pcie_pme=3Dnomsi=
'
>   command-line parameter.
>=20
> Also, we need to resolve the Sashiko question about whether IMX6QP and
> IMX6SX also need this.  NXP folks, can you verify?
Hi Bjorn:
Thank you for the reminder.

You are correct. I apologize for not covering these legacy platforms
initially. I have now verified that i.MX6QP and i.MX6SX PCIe controllers ha=
ve
the same issue, so the fix should be applied to these platforms as well.

Should I send a separate patch for i.MX6QP and i.MX6SX, or would you prefer
that I extend this commit to cover all three variants in v3?

Best Regards
Richard Zhu
>=20
> > Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root
> > Port if iMSI-RX is used as MSI controller")
> > Cc: <stable@vger.kernel.org> # 7.0+
> > Signed-off-by: Soeren Moch <smoch@web.de>
> > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> > Cc: Manivannan Sadhasivam <mani@kernel.org>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: imx@lists.linux.dev
> > Cc: linux-kernel@vger.kernel.org
> >
> > This patch is similar to
> > 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX
> > to work around hardware bug")
> >
> > Tested on a tbs2910 board [1]
> > [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> >
> > changes in v2:
> > - collect a-b and r-b tags
> > - use correct fixes tag (Manivannan)
> >   (reference commit that introduced the bug, not the incomplete fix)
> >
> > Since this is a fix for a regression in linux-7.0+, can this still be m=
erged for 7.2-
> rcS ?
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 98e1db751132..8130cf93c2bb 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] =
=3D {
> >  		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
> >  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
> >  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> > -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
> >  		.dbi_length =3D 0x200,
> >  		.gpr =3D "fsl,imx6q-iomuxc-gpr",
> >  		.ltssm_off =3D IOMUXC_GPR12,
> > --
> > 2.43.0
> >
