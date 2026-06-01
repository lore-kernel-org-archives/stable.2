Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2B38AC75;
	Mon,  1 Jun 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302526; cv=fail; b=p7QsOLh9AeMC2YOygLyjfA0kykOvEKAu001HO4F0tmAVnS0Hmn2Cvzwo9YFEMxMFZ1gJblm+MuA51yxm5Jd5R2ZeF5mrQ/HsvzRUBNdDkjRsrtVGiTaY/JtJoPJiyhqGnE4CoozgLGVAKQiKNeCeP0bo79T5xOKsRFwqMIF6KK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302526; c=relaxed/simple;
	bh=QD/oFosc6vgb5xaTAu5qy/bjhefikFKaTSTexuGWB2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ctDILV8l5zyd4IavzRbCLFgWvwW8qwyrN+tLN1SUElHGEPEdP0G6oF1hNPqJZS9aVz6kO0CvnkL9jALjY6I/Auk7kg2DGOvuGNNuBgXpKZ0/v7LAr2mneuY5jZOXWeEwAGF9mivPobFz3/g9gburAYFTUUD9OEcOLetNkvdcakw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JIEBiX+o; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JIEBiX+o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pauXDMe4URCG6C0H+fIAp9ZGNDEDmsm7l03LgFeYShAbJj3wr78JXUWBjptptQQrdR3ZmrmCKewo69GwO+Ora2kOEoTf5asfICNEVjakg4JMBxktaDclcoR/uPBUBDSBBbESjuOZxsQ61eLW3XCYTTLuSvc0qCc5ZM09eforaU3BXAQXSCnL/ykfXM1BgF4DPDVF1ISIvtBx6YLjbQ7ArrQftiZzDInHhQt1/2eEIEuf5d2PrDXCf19P1oZr2i4zlDjoPxR0s2BSZ8vsbeLlxRkBAEUM74srEq8FmC8tSPlatU/KDQr63bHJycldimA/NGTSTkmQIvwlsLat/xQwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXqbzSZpemiuhqL6/wxd5MeintVoUZJlXCW+PDtPmaw=;
 b=BeWIIbwIfM4qLQTJ2N2MXMNG7P2U5wRbHJAcAX1VVPLH5CFFRbyDIjufLP/lk+hkgNaznfELxlLYWy6hev61O5yMb9eszP7Y0UO61cpGzBiJRebgh4EZnlhg7ZIxaHhTtjt1RBcll62fe5UwLdj/qpBXDEhAcCUC+SHd9Z/4kZVSQ/RN4xcausV4p0Wz8ZR60pDlAMLdV0wRjEXgsRt5GTFzcwJg7OsIn5p9WQf78RXA139oHyrOD2aDoBljUkRE4Z7TIxtjG4D5t+dkTYQfsMK1iKun5DcW4GpvGc6v9NhMfIqt1CmN3Xdg2+PXhGzJI/A7frQJdnErz8m3Jbpf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXqbzSZpemiuhqL6/wxd5MeintVoUZJlXCW+PDtPmaw=;
 b=JIEBiX+oXEFVC4bui8qCz5M0AbVBfjN3KVkn55P3wmR5urx5qIUZCoCAX4XO3qGPcyG3bpfD44A4WwrMEMzTlIS40LFanFPQv3RQbfwEFD9tPRWogv0SyxYw7in9Mv2xqmQ9a2D5u9W4RIvy27pXRGoOx1XCz4nHMHdomqOsVY7mmorbKyJ7aahWEP3/dnXHMhw/sU6X2Gc6rkdh7f4n6dC8m92XuuWpgu/2yTyXPRtOOdYPvg3BVmPKSWWHvpgmHoeMDQ/8K9z4pfyY5kkLSEt1XCN6bE6X/33IfPy7fjW8TfDNOd3C8nlgpt2hesRag5jRby0cft9uXkUNAr+Brg==
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 08:28:41 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Mon, 1 Jun 2026
 08:28:39 +0000
From: "Chancel Liu (OSS)" <chancel.liu@oss.nxp.com>
To: "Chancel Liu (OSS)" <chancel.liu@oss.nxp.com>, "shengjiu.wang@gmail.com"
	<shengjiu.wang@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
	"festevam@gmail.com" <festevam@gmail.com>, "nicoleotsuka@gmail.com"
	<nicoleotsuka@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Thread-Topic: [PATCH v2] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Thread-Index: AQHc8aClUGW5ocMFhUu35IXe69YnlQ==
Date: Mon, 1 Jun 2026 08:28:38 +0000
Message-ID:
 <AM9PR04MB83538A743077201BDF9CA1A7E3152@AM9PR04MB8353.eurprd04.prod.outlook.com>
References: <20260529085020.3727790-1-chancel.liu@nxp.com>
 <20260601070543.1351629-1-chancel.liu@oss.nxp.com>
In-Reply-To: <20260601070543.1351629-1-chancel.liu@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8353:EE_|DB8PR04MB6858:EE_
x-ms-office365-filtering-correlation-id: e9835867-a099-4b06-992f-08debfb7c825
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 n5OPt+2AY8iP8B414mCwkhvCmy+qJD+DGTB7NYkblLS28CT7YFXi8kP13ovKBVf6+sSV1aMT41kZlqSIozKmX/AXeg5Mfw5cClJpJbflLEcMAcXwkU0H36LK6K9jZxeHrGC6Z0C9WOhdGuIhduwaprBgn8ox57iXZCisuq5oZUS3PRUgGpxPhNIc84rsi+qBCUduPzJMvepwuYa3Q0p6TUg86cGLy2M9+8lqF4q550Ra3vIFOfbWy7stwy36xsUfr57Uo+TKHCXKe3gFMemWGb0BPLz/2pPyf0PLJzz7x3D+y0wwP/VQk7ch++2D7zvc3I8ypbwK4HdhbMgbqT+UfbjCaOVr7WeEz0mwIdcxaButFwpzhCp5N640Cfq10zQfJAfNq9vcP2Tv0bC6Hgzv5fEcrZfWsCwfpdkN7x58/rDwHSQCd8eEgnL0IQjZ6a80YtmsiRyLHNrl3ruWalfWXn7a0cL3iv0mA25GApYaLLpN93uXn4Gk4iPe+byyi03qnqFqKglTY6lNd1+JnrhZXjCkj2cw3H1v0wpx847HqaTvckSIIxNxwYKnLuu58a84ns/UPnDnCYwkP9NrWpZ7/VC8ihmTeCFz38WJN8ZAhVPvM4R+YwOBJobGnzNSlQAjKlacWj8S2V7zMumVg5cDEBv968fZJhN+hLUvnPTZgAP2vOndhRUjyWQ7sb34PGrmREXCQ8u7NonWKe8UAV5tKHuUgMbplVLh1EWEvfdSkBOp9qJApPJxPcvyKAQZFzou
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tkRcj89AuAxYsH1eZv+eUmHW2mOnyNQZ/Nry7J1S4T6aI7HC6GNBeGmrDB?=
 =?iso-8859-1?Q?ANevpQU6wntTfUfYK8dN8mJZZabv6tiudiZsBUCt9rzHq3Ps5WD5fvPN7r?=
 =?iso-8859-1?Q?NrBFQ5WZW1mZ8wLaKUhpRscb+7zjAgvQ/QuGRUVVIA3N0JHqPzpFCSFeBx?=
 =?iso-8859-1?Q?qyeQ/jirk3FQy75mN8Xup1K0ZicQdXm13XHwdXnBNBdpM0RrCGsw8/q2PG?=
 =?iso-8859-1?Q?QjaMDvl1ZylimwRCmCXJ+0DlwBHsP6bt1NkyJmiEHrGfUb81+SoqyExfZ6?=
 =?iso-8859-1?Q?lvawR0r/TzOJ50kUirCqkz/hGkcKmpf+vnXF1mVwvFDqSbC3parmQPzzJ/?=
 =?iso-8859-1?Q?Qiu0QY0Wy/oCCHLAwBueuM9hVhWfrVZ/1z759GEAOK9wiH6RSGkIXf+jHS?=
 =?iso-8859-1?Q?JF50aqxAzzSGw1aCvvfmaYNRkvo015iSU+PKesdsxAJVG/hBXX8DWaxnB/?=
 =?iso-8859-1?Q?kKHVRze/wEgAumuVeSl/2v+ohnu5fEUMn5+wpXxYjE0mGqy6UmM6c7XOVu?=
 =?iso-8859-1?Q?3isTmTniX7E7mo390G/SJlYXEiAE848e3I8dcutu/ajZMQH3CkfhoEItKo?=
 =?iso-8859-1?Q?AR3ZTH44s+EB8m8vWIe+I9pgtHy6EfwB1b6T0DRULPiNfwyB/Ipp4C3UGn?=
 =?iso-8859-1?Q?ZfMk59lWMl6kDbbYJ+kf439f116IW8QfXJVAB3/IxOdC6QVKvanl/XlQ0E?=
 =?iso-8859-1?Q?zNukk2utgwZEW/PwWyjnmArSky04o4Uo/culyHs7nQpvSADtNdy+bs6fTg?=
 =?iso-8859-1?Q?yrzjrtAgmGi0bYnJEpcnHxT65ko4C0zalE5e9Vcv6iXIBA5spxV16S/on6?=
 =?iso-8859-1?Q?fY3Yxd5y0Mxl2kkcRHCKuC+k9EnF/NckjL6PaRsxjRnghfOBRlm4sVrpQt?=
 =?iso-8859-1?Q?+8Ybt4wV3NyvYT/6GQ1TZ44StFUX3uQ9aoNwf27KB1NQC2MWqBQRW52i9I?=
 =?iso-8859-1?Q?5+ZGMC2MUaoSSC1CPR/Z9N3ZXmeZTUNdRXbtqOXSNJSqNhU1OM3ecDuAWi?=
 =?iso-8859-1?Q?BhcIwKSZJwKv9OIhwGMzKvtCv99m8MQXw2/6bkVkmtHi/DQB/N2Zjr77rr?=
 =?iso-8859-1?Q?M3sHHAT5OV6avSCN8UWhYP7X9kzKkqI6ZFD2zqUI+2IoxhAa7bsltDqwnS?=
 =?iso-8859-1?Q?aNoroSgfQG3lCSdpoGLLTKOy7b7vD3klpqcmXOXtB2XHBTDMf27NogttW2?=
 =?iso-8859-1?Q?xRXHOAfDu6UjCxv5Tx66cqaLWRpL8kkyO6tr05B7Z0paf1JydBbyvFNtCj?=
 =?iso-8859-1?Q?u7K5GcDi2hmSTtsLOr2ZIg+55/oZ0p5xtSCNk3Jp2ZRM7wRlmHyRqlVxcy?=
 =?iso-8859-1?Q?ToCvyI725u5VSarTR/tI7yOmopkvGRSxBzbpKpgrTjoI4zugvOdIRX33zV?=
 =?iso-8859-1?Q?aE05buyKqJbVHTXeB8Ynnz7bfLC2S5vW+oOwlpwL6TtuYXA7QehUunM33Q?=
 =?iso-8859-1?Q?zPsbViWNI6mv+X8dErHHVc5Gc3/nml00elNgeWcYwWTb+klFbBVcZZ0Z9P?=
 =?iso-8859-1?Q?G6XGqSThDuD1oc2YOgWrRGKxiEbY70N9pAkLMDQt09ZDuz4/ftth2dMAap?=
 =?iso-8859-1?Q?JorRA5YBA3CQSnXoHyKdv+OY45crFP5Wf4TseS3jlTHmtP1MKwu55e+ZCS?=
 =?iso-8859-1?Q?uhMbpPCi79BpDxlwSP5xt/t1SeKB4c9PPt9rlq1jvKVlXtA0I9yDL3/fBE?=
 =?iso-8859-1?Q?17ephsFLlDMqIuR3OUBG5Znq++YzXORLB2ppzhR3mzsdjrMDxLAEC89ncl?=
 =?iso-8859-1?Q?N/HxBzDTkic5Yc25Jv3YVGjKqJAYMGs92cmj2rpQQZA6lijTNDPAnJxZye?=
 =?iso-8859-1?Q?hJq4yxVqcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9835867-a099-4b06-992f-08debfb7c825
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 08:28:39.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/dTKkENqdkhAXtWuWypEWHJp+TmK7ukW0651sxEyAJQsoR/vt03nUb7IIxScusnJZtMEZBbESkV5StSZNrfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

Sorry, please ignore v2, it can't be applied successfully.
Will send v3 shortly.

Regards,=A0
Chancel Liu

> When configuring 32 slots TDM (channels =3D=3D slots =3D=3D 32), the xMR =
(Mask
> Register) write used:
> ~0UL - ((1 << min(channels, slots)) - 1)
>=20
> The literal "1" is a signed 32-bit int. Shifting it by 32 positions is
> undefined behaviour which may set this register to 0xFFFFFFFF, masking al=
l
> 32 slots.
>=20
> Use GENMASK_U32() macro instead. For 32 slots this produces a zero mask:
> ~GENMASK_U32(31, 0) =3D ~0xFFFFFFFF =3D 0x00000000 Behaviour for fewer th=
an 32
> slots is unchanged.
>=20
> Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel enable
> bits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
> Changes in v2
> - Use GENMASK_U32() macro instead to make it clearer and safer
>=20
>  sound/soc/fsl/fsl_sai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c index
> 821e3bd51b6e..9661602b53c5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream
> *substream,
>  				   FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_MSTR);
>=20
>  	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
> -		     ~0ULL - ((1ULL << min(channels, slots)) - 1));
> +		     ~GENMASK_U32(min(channels, slots) - 1, 0));
>=20
>  	return 0;
>  }
> --
> 2.50.1

