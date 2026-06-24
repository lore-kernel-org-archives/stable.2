Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8928852E;
	Wed, 24 Jun 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292933; cv=fail; b=MBg/gF+/flLgXwQkDjhez7Yn21R/XDPobOf1a+fx37AgI3GjnbCjZ7iqyyjmyv7r1xbSrPSg9SxOMn0nKB1P5s8X+LySH9a9oXA7KTj+mPvTjboZK+BEfMKqfSobQQTEyoohdGQpKfYBlpfFx85MFOYdOzmK8nRQ0AQ0SRweEkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292933; c=relaxed/simple;
	bh=HkziqEex4uNQFJkvUEqTMlsPOy+fOSMa4p04W9pyd1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rPwjQhEiw4CG/snxDQwGHpV290b9M7vH4MtWHNGSMcs/6AXmSYSxxMwyvRE29JMVzyuMMfLjArJsX/zkYeReLvjQsCHt7eb/yqAs58/qLZhp9VRdsfDTZ3q6q3xIsOmgNfqcPggUZwOY/GT34NYrrq6ncQKQ6XNZCoFV9SBeH/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mR0RQRlJ; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mR0RQRlJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mba+pLufRWUNt2UtAuPYzeZx/06bR6dMRb01T0jMXjR3weIAiltcCPO6TuCFr0ir42ygk2UkKRdbpXocusLT+IKEvZULYuet1DWAEDd9A6bbIR7tv5qkEqNWrDMMYVdilyJ9VG3+iMwQk4mhqgqh8uVXQihhBF78JrGhvMIKlpOQ+WCLxO+JAN3LsvsK7vbRLJMHX5GHt57xhGdXJgu75ZpxBjdSByIv40U21fbEzOU4k/Vw6HX32cqCPWPMQttbsaLO3dkij5LQerWvqpQ/RtfA8kbke1jwFqzs08mRruMmW+YtTO8DtkFkLPazZc1Ze9iq7ps/rfmy5vRK4xwhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wFQr2M5ecn5ZbUQHVJcRgYV+L6KMM6v5QxukK0Lcx8=;
 b=xRodFj00ErVSeWK6btXoHPrdU590ieo9S8kYHFjjztwym11Sxu5W/y6d0E21pjifmuLTdpWllvtcjWMHpncREAt5g6pDuwUG6oJ5cA8NeN/w9vOui6aWYiIqItI1w5zJASrZLauQ1mrNAqNHaF+V4kaBY9fACCXtkNm7jFjm4YRmyYof2AppeSFYO+f/MkWIfsiiC6DDFUd3rK2uZLDcDo3qRsbtUPOR7Eiz8XAqAuOz8ayY6h5WfJGyxD/nkWQN/aoAx/rBrXi16x6zsgqNYxsCdwS8UZ2SGUVvONteG53sPDz9Xj7lmrXVVEJ5rIQk8nOZeUxkFwvoGiP0nYcqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wFQr2M5ecn5ZbUQHVJcRgYV+L6KMM6v5QxukK0Lcx8=;
 b=mR0RQRlJ/1qgtW5DPOl8IUuJX2GiH9J30tvA6xUUbNCLPev41oT8cwZpxIzwqQ+tCYBtIggbPpzpRPjnG4HYyZj88QzkuFbd7ILWuAsY2ongf+30DmDOg22hK7vewM8EcYp3SzRqm3p06lr2AcbLoY25xRDzAFsFmzQqU4JFYiGHiSpqpp1Nb7ZJ07XZ+TiMZzsQ2K/r4g/3SalyVXuEBiSWEpvMV+fQQsK+LV9aqn70D6xJh/WYwPSK4TUrpPKVyVK51ScY5SyGwTvKzub/NAozyqEycWZS/WWklOduHtHU8LK72Jdc4EbvmI2FcaecySnOOmZG2Iwd2AmW33HqHg==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by VI0PR04MB10758.eurprd04.prod.outlook.com (2603:10a6:800:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 09:22:02 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 09:22:02 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>, Mark Brown
	<broonie@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Carlos Song <carlos.song@nxp.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] spi: imx: reconfigure for PIO when DMA cannot be started
Thread-Topic: [PATCH] spi: imx: reconfigure for PIO when DMA cannot be started
Thread-Index: AQHdA7rqB7BoGa3VZEKWBDkA1aUE6w==
Date: Wed, 24 Jun 2026 09:22:02 +0000
Message-ID:
 <AM0PR04MB68027B9C426D7CD42E256B92E8ED2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260623153240.57185-1-javier.pastrana@linutronix.de>
In-Reply-To: <20260623153240.57185-1-javier.pastrana@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|VI0PR04MB10758:EE_
x-ms-office365-filtering-correlation-id: 41dc2de0-2d47-4ba1-b091-08ded1d20cc9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|19092799006|921020|6133799003|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 fxXUuLPnTAHKLc7Y/0APr+Jd7IBxD/FKS3j1YcMys8o2xzamRhGfPva3R/E1WtoKg/mWHd9ygZkaSzoWkfyaW/7KB8BczbgHkrojh31HGGvgubUB9PlCW2HA/DlnLHEd6KKZpcVO5kvtmVmmy0tWYS9eDQ5mlnUoJnO6d7izwQAoJzCPJpXEz4sODmd+76d0UUY/e28n9zNfj3e40faSXJ5nZ39PEKQ7+ulth8/qd+LOsfkaM3/VVIpXreLcamukrsxf/3ocFp6xVrMPsbg6UUm7pHmyj7u9jKDRtXE6i1MyZHrzsdaQkmPNuWdlpT78I0JJDg91JA64LkyASlA1sGo2S8ZlU0FNV5/oNJPSO/gBJxXPq562ZvOCuYuxbE7kzoXNUt6ChlGBkDt/5bR1mTgRK+U9g/Xpo1W6XVBEzTfHD8lWAAVTni29kDi9RH9/94lfp2GfgpFbAczpUo0r5COz6ALI4RHQHWiNJdFx5JYB0Y5l+K8QkraHyazZsw2u6R110Qmv6j7NRikHaYVOlDihMCY1MNWO/rSMDqItm5hNu9ji9X9Rizhiy23i1qFDI8S31y9qukvidOK+AhoUJuawSvU9iwoGP8TsOciZ4fenvwLwy+0KQQfsK+3eeYpRXBEnCb3xlqDmxaKoObjk9NIPeGeFgRo3WpGZG04fpZdPdfINoJ5l4cOn3cPge7EhGqh5RoJ1to/p7fw1BspUcK/lxT+MmkeEboXOHSIpAn+vcw1a9ShKXRmhVOVrxDPH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(19092799006)(921020)(6133799003)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d0K3GzBpewQYVvQVCEdUqYnryAXmQVCXd8JkescX8jQVfzPlx5pXPxWL2F00?=
 =?us-ascii?Q?VG7oqBCcTtK7hdIV9yCE+jygPmBGZzzaFPpsT/gfUu1fWKRYou4Z3dJBm9nS?=
 =?us-ascii?Q?cINXcbjHzRAqF0ePpf/tcxzxwgaUZUGDXti/q2g5L5mWnmd9rGRLZJ3cS+iu?=
 =?us-ascii?Q?Jnr+vSG2gRfRSiJB8SiHeR2lRkPVY5R/eiQIgM8jVlQrtOOUScsHDG9G135J?=
 =?us-ascii?Q?QNgLvpsmWLYB26yjUhbHji8uf/zVSlSgbCCkZeHFvfKTQ/coFUE+6Bn9jqhi?=
 =?us-ascii?Q?RHJUT1Kj56tzm9wbBGneZRexma0fwFj21ypuySFrTWOnIVL2hn0ws4cNsSNO?=
 =?us-ascii?Q?tvZy11T49r/CnTciPoPWetifjCGeutzAQUgw7a/Vo8SUJ5V3tu/tWq2x0WGR?=
 =?us-ascii?Q?a+ejJCEnaP2gAyXiso8O7WXPLV2JznDqDzI2hEoYQfE5Hm5MUZlEU+nsHc7G?=
 =?us-ascii?Q?yQZ3laUetuJ109ygaz8nhZ6KktW5k155ssw0HXxzAFC8rlo6H9qnv5D2h3wr?=
 =?us-ascii?Q?NnSA/FXr71q2Nsz7USTuHY/AKhtG7sP8wz227ixQj1GbZZ6g7gV7RujnoiYY?=
 =?us-ascii?Q?LH8XkXgtrAE2rxUeU9TCyPiObh6apC7YsIAoxKgtp1ntuizmBPkzyJU43h9F?=
 =?us-ascii?Q?ONiI7bWa0dSd4Wiv9w5o/fW7N44g8j+XXygXAq7+S83lMFZnqFDAa+3iLKg0?=
 =?us-ascii?Q?9vJq1tjbBUIbmyM5h7rKJEsuemJaZ+5wUxC0xo46jvJe7IfuIIa28/rYO8Gr?=
 =?us-ascii?Q?S3Dlaco8V+zHXz6H6GCJXUL4WDleoY3DzuWLFHd90Z3aewbveU8EifAP0dWg?=
 =?us-ascii?Q?H5+oKf7fO5xC2IChTERE6ImV0cujbEonV3nd1A9UezWeCiNBg4DsA5w3syk2?=
 =?us-ascii?Q?mJwBz8cbfL1KXpCB/3xvqOwJtn3eR3Ansza85gsL0sM+MynixuBybg1GcJbA?=
 =?us-ascii?Q?S7WJGNk6D4RXlm+SctkX4ZDZmlGyJqrY+YnoXttlDmMw7e9X4MT/hnNKHxFp?=
 =?us-ascii?Q?HYkT6GcgstDVlovuTBUVOJHrMCfX1ZSz9BHSXeekz7zpyXvA+0rqYQGW9Z7Q?=
 =?us-ascii?Q?H/kWhFWUF1qsEmNhQC/9Yqh7ta+kvpDuuAcxfJQPWY0jZsw+6JdrmyZW6KWK?=
 =?us-ascii?Q?N8PLq5aGDbWHkZWOvdfmO2XyVUR+KeRyp4ixEfFr8Che1vo/g1zyHiq7yMzU?=
 =?us-ascii?Q?BV1vo0+lM/Z90WW0txK87b9SqSTUzKJW6FcaHFDCJVNkuuUm0NhzLEq8eUMD?=
 =?us-ascii?Q?bE+ttQuj/OambTkPoeW4tMR3uodRX1zbLGvUeKMoJTyNbRW5FOFeU3/9xclX?=
 =?us-ascii?Q?M2Tnm/CLixg/hvUGGPJCt9bl4dCsLLM2WCN6hIZ/tbvqv3J52Q+pjofB9KEo?=
 =?us-ascii?Q?GJQe+ko1kwY2NvqscPGd6rpWmqVNHXIvNju6y9eHTSVXv2Cx5Li5ocW1YtZW?=
 =?us-ascii?Q?N/JDxFnoZ3wE/vNSd9A8w1AlUnH3Jtfsnap++umKr5h8PwaRMNgOgkwLvrgS?=
 =?us-ascii?Q?YIoQV7OdKeT3p8pViT5k4nq3c7Ee4HO73XoGRtIotAOCqZQNFluwhF615q4c?=
 =?us-ascii?Q?x7EQYF9V6I7kiPE+TEU0fS/p2F7opG+thrp46chNin2lrszzqkmzUX1wNxCK?=
 =?us-ascii?Q?ilcozs66WEItxNszIZ2olPDfkRSk5sqDUBhfM5aAEwzTGRMyoFFhFySyTmU/?=
 =?us-ascii?Q?0jWt0YdL/OYAd72bsB2V4Uz7XbHZlXrOc/JIQtxMHejDNi/LHSmS/e5kI0ga?=
 =?us-ascii?Q?bARJNrE8Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dc2de0-2d47-4ba1-b091-08ded1d20cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 09:22:02.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hst9Kf83yqMXT+sCS0+z6hWQDDUoCT8/UEt3CNE/zqpVxMz0luTU2mPM/U2pojtbK99KvnZMVlx907g+Cyw7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10758



> -----Original Message-----
> From: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> Sent: Tuesday, June 23, 2026 11:33 PM
> To: Mark Brown <broonie@kernel.org>; Frank Li <frank.li@nxp.com>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Carlos Song
> <carlos.song@nxp.com>; linux-spi@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: javier.pastrana@linutronix.de; stable@vger.kernel.org
> Subject: [PATCH] spi: imx: reconfigure for PIO when DMA cannot be started
>=20
> [You don't often get email from javier.pastrana@linutronix.de. Learn why =
this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> When spi_imx_can_dma() selects DMA, the ECSPI is configured for DMA:
> spi_imx_setupxfer() sets CTRL.SMC and clears dynamic_burst, and
> spi_imx_dma_transfer() programs the dynamic-burst BURST_LENGTH and the
> SDMA watermarks.
>=20
> If the DMA descriptor cannot be prepared (dmaengine_prep_slave_single()
> returns NULL), the transfer is failed with SPI_TRANS_FAIL_NO_START and fa=
lls
> back to PIO. The dynamic-burst DMA path uses its own bounce buffers inste=
ad of
> the SPI core's mapping, so xfer->{tx,rx}_sg_mapped are not set and the co=
re's
> DMA->PIO retry is skipped; the driver falls back to PIO internally. But n=
one of the
> DMA-mode configuration is undone, so the PIO transfer runs with CTRL.SMC =
set,
> the wrong burst length and dynamic_burst cleared, and the transferred dat=
a is
> corrupted.
>=20
> This is easily hit on i.MX8MP boards that describe ECSPI DMA in the devic=
e tree
> but run SDMA on ROM firmware (no external sdma-imx7d.bin):
> every ECSPI DMA prepare fails. An Infineon SLB9670 TPM on ECSPI1 then ret=
urns
> shifted TPM2_GetCapability data, is flagged "field failure mode", /dev/tp=
mrm0 is
> never created.
>=20
> Mark the controller PIO-only (controller->fallback) and re-run
> spi_imx_setupxfer() before falling back, so the ECSPI is reconfigured exa=
ctly like a
> normal PIO transfer.
>=20
> Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DM=
A
> mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> ---
>  drivers/spi/spi-imx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> 480d1e8b281f..64c78bd79d7d 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -2153,6 +2153,8 @@ static int spi_imx_transfer_one(struct spi_controll=
er
> *controller,
>                 ret =3D spi_imx_dma_transfer(spi_imx, transfer);
>                 if (transfer->error & SPI_TRANS_FAIL_NO_START) {
>                         spi_imx->usedma =3D false;
> +                       controller->fallback =3D true;
> +                       spi_imx_setupxfer(spi, transfer);

Hi, Javier

Thank you very much for fixing this issue!

You can remove this line also: spi_imx->usedma =3D false;
Because spi_imx_setupxfer() will recheck spi_imx_can_dma() and return false=
 because controller->fallback =3D true;

How do you think about it?

Carlos Song

>                         if (spi_imx->target_mode)
>                                 return spi_imx_pio_transfer_target(spi,
> transfer);
>                         else
> --
> 2.47.3
>=20

