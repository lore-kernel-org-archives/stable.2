Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE843672BA;
	Fri, 10 Jul 2026 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657226; cv=fail; b=AbM+/4ul/X6fUZSt0MIW2enoFhOq561oQPGu0ud/O/JYPN8lkSEs3ItVbKjhGf7DqE+Pfz8AlHsXSNBw9xb02i1ynRGg7UGde0qJA5ZcO6kdZtRJSilZrLEDzNnQujFTsoFEPJUiYdxWzld1LjdkD2aAaFd26JRWipywnwCd1T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657226; c=relaxed/simple;
	bh=hgxw2pnQ7w0B8SSE08ECepdtZ5Ah9UXtpi4iBqcpF/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=suhJaP28OJsqKuHscS7M400NWt45C1trFVOFCdbTjMwqVeTK8+ZDeP+xo+gF4JdW2DB0nyWVYS9r3GdLGKG5Xd6YICdX0YqSP8VR0P0Tvy+cQl+eP9f4u2KUm11lpDmooqLvRxKt7UDndRsSlOsxEURty4mThdYiArU8ip9ecuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VEIgw4+6; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VEIgw4+6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF9EZYriIF87UP8zSE56FmaXoTvy9c7Xxvgj5Lf49FOrnIqM/mLF2v2pFAvtCac3fKQ78dJIlqmxDCEVlZ2HObPynClmu7zuNaUnygC6GaJEuMyv49SWSSN8h57xKBu7XayS6OeIw6w0GDxwbsQ8X+fVCixKF+kTm2twozFOVGCJwOSWaNYpKPQPqIiy8v4oTIl4LBzsTV6YfGqE0MTe/LOiaEImHlt2O0RX3TI7Nlw309fVLgdqsU4r2oInqSAirFx7eHu9US75DWKZKzJL23LW0/63+/2TbMtt1Zsc1uFQNIWuWAafMWDxJ67vPGpaqf1kxnt2w1ohuRG3EIV0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR3OT6OnBfvOUBltu5FJVTz5pSvJf0bQ0yxBpAd9WNg=;
 b=wClNvmpwXs7H0DqEh2MG+uXua4Ymgll4T0HMbHxAvdoV0SWYF0DZbZCl9UT1p56He0hknr1h6Bj9Sl+2ErSYFQn9O17Jay2ehzyLElO+U3/cfJg6S2fv747/haM5vFbAApFpiY2zYvExsNSYoxBIuVnZLlLezbCuAu6ITs7ryLBTfY2huXzjbb4FB5yoAQmaW5W+5vkctAvg/r6cvCmhi7iZgiFxutoSSkOyxHPLt495NIRe0Bhsq6laJ3Qs/FRLo4N29khizn7gZ4KiS2afloURPXqgxnu4JWr9qlsVI55PtjpN/LjCGnUkp6xriQzx49o7zIDGgFBYWQeh4Judnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR3OT6OnBfvOUBltu5FJVTz5pSvJf0bQ0yxBpAd9WNg=;
 b=VEIgw4+67WMqH3+iFW9UHPWM6lkyfG8A7m3pP2wkrdLOlUdwhBC78LPJ46vTNK8+sKxiW5QGHjkUjV2GajMRBfCiZ1kNGLU4wgHFQ+Z87KSPp3hri5QypGXm1zKzdVUz7YxxRbnyKFkVzlIzphitlJTcHJ7YF73Ttc/JiSckGMbh96rbbAE28uubBPsKEiR9Wnv6GUgKAm9kAOoSsz2P8nmGNRBDihO1kK3RLcN5hBI3xak+o50CkTVw7rK5kIW/+zhhjNZXjjBiPBkg0F6CVPBLSurnRT4gocsx6cYrV+YKgy5VM+WdsKiRNIjE/oxUBeQ4cmObo66R0dULZ2Kx3w==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DBBPR04MB7548.eurprd04.prod.outlook.com (2603:10a6:10:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 04:20:21 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 04:20:21 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: "Doruk (0sec)" <doruk@0sec.ai>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v1()
Thread-Topic: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v1()
Thread-Index: AQHdECNrPs5DuQvaME6B0NAtKHvnrg==
Date: Fri, 10 Jul 2026 04:20:21 +0000
Message-ID:
 <AS4PR04MB9692BB0B2C3008F45818659FE7FD2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260705115650.81724-1-doruk@0sec.ai>
 <f28eea1f-80da-4def-b11f-33a531a1b595@molgen.mpg.de>
 <AS4PR04MB9692E00192B16910C3F3C011E7F12@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <CAPdMp1pcsmnnH9vXKfhxSo5q0Dr+TiLL+0ZrN=Pz-eZtWQjutg@mail.gmail.com>
In-Reply-To:
 <CAPdMp1pcsmnnH9vXKfhxSo5q0Dr+TiLL+0ZrN=Pz-eZtWQjutg@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|DBBPR04MB7548:EE_
x-ms-office365-filtering-correlation-id: 3df879c9-bb07-4e26-c6d2-08dede3a8e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|56012099006|4133799003|11063799006|4143699003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Il87GUAFaReBdCG0Ov+cwlT+XHdlBVHKVmSX3evT1gjHOXTwKsxElyr8P+MaTkuKHlStC71Ui6843Vpr2sBGDqhLG/86fWQK3TDvp8OspA14Qc4AFjPZob29Hn7HQZjv65yj4/Domus4hTx/2FJ5C+IYAnRa2lA/IOM0fHdoYN5ZPVynqZ1kdFBpDdlAizlQ1NryzZE/72RGZpSMbkqpsM2PxcYJXxeoZZP7GxEpOHdL+hZ4UtQZbiri7cz7wWg/lkoal76DHclyN18JPE4tm69tZeUC/LuhhwNfKe6u11/9li04GwCcSnIQ9k8eCbAz1lrG6ioW5qUTfxVSZR5+2nBxDdL3gNpjx6p2DZpMHRS7yECSvoqkMVmO8zQBJ6MpobDZhys+APSnEXrRXyQRVn1KJEXE1+tqYdhLhaOr63tUMIQE/5JfBF1Hlphi+BgBtTc/qeMwWgEWxkzO6APIRZOIA3KTNpTLfpQ57XdMkfg4WyAJv9qIt56b2Jo/tOfIqMQzycPtFP+HbsL0fJ5kL5PddxkcTedrohGe0HnW0QfhJxuvYGJFlTj53pWPEjY+NRdZmSOG0Zit6NbiL7Bm1AYzrNmn50FAceE85kJSjHB63SPOF1QCF4BhbpPYRU0REaTjAi2kWsjT1vvNpHklBmUD/iyEyEJ6zgGNbHzHDlQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(56012099006)(4133799003)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oi4hsZ9e7nAA6rVVfvGwrfDapcEPgIxc/3lax+c9uMePFrTQhbTYkLrDCtPS?=
 =?us-ascii?Q?Tp904nODQ9irVApTecNPJAqFwBgQnjC9M6WqBNz61h3Lee7T+u2DRkQ+W3ly?=
 =?us-ascii?Q?MN7kF8Jig7L9P26t95SoEoFdmAG4TV/chGaQBPZj2kgQCf3gceAgR2Kyu4Ty?=
 =?us-ascii?Q?cdmCo4m16quYDcg+OV6GUodi1WQZRa7ChAGIH1wrSwcZWFkf+mkwQaW+Hezz?=
 =?us-ascii?Q?Z5zFMUmRwZiofk7YJ/UNIWD0v0fnc4VEwNwLLqN9z8zHqYVQpGZYYZyDxX6j?=
 =?us-ascii?Q?9lEdTmrKWQktkB0fCAe0nN5oew7tAY9GjMcipIDLgDNTPm1TzqYJFOG7emB8?=
 =?us-ascii?Q?l0MbVQcl/kBX0BSiPj/eg7isajr3S066Sl+xAtEpQL3uaBu/KJw3eYzvO1RF?=
 =?us-ascii?Q?wbGz95Y3a8LXWd/icMh9G2nnBwUBNSFcEPBAes7VJD06QLWkMCK/5vYtg/f2?=
 =?us-ascii?Q?IjpLVoO8weeOdaFiWcn/+pTd88+T4dcLHtnNooFvBsJVInjl2lf+pLXY/mTm?=
 =?us-ascii?Q?Z+U9L5OBGEqOuU7pkorRgdrqFlem04RLee4TfGagYuAw+R1j3NQA1NjnOs78?=
 =?us-ascii?Q?sY7CesTVLvaRl/u0dqb4ICpodGQVnrjM4pG3Y+vtk+S+v8V2RNGpHseEzCWy?=
 =?us-ascii?Q?1zzYvJnuW8AUp6cjp9FsTKYH8bflDe/HL478ocQUscPQEh/rt0D/WL9KT5Ex?=
 =?us-ascii?Q?h5jD5eQZCUb1QyzIXJmTK5LeXr/EuZONn5ukLHbizqNRwA+2lx0W0Pt98Hpn?=
 =?us-ascii?Q?/SY7DwMPeiUm441GBBdUtb4hDoqnL9uAre9k6L6BYhWIN9NT36yZLkrHm4/1?=
 =?us-ascii?Q?hvmbt3UMp8rIctvT3uAia+5m6oig5DGC6TgOEaouvO5GsecPxvCn5GBdKHXa?=
 =?us-ascii?Q?a+Wduw0GTLENSRvZur9f0CJxsshxnaJs33BaMO56ZtNmy10bYc2Py+R/L0Yf?=
 =?us-ascii?Q?QiMQPB7zNpiHSz4tPcqqPB53FxhtWMp2Q9wW2XQOg+PdwsPalbf4r12OTYNM?=
 =?us-ascii?Q?ylSxq+SJ6VnQh07e359pleM9pjd+8+ZA4Pyn0bHZOTdnOqLhrZ5yp7cZU7cG?=
 =?us-ascii?Q?qqZy7j7JLvNRVpWN8kgIVd6fO33Zlu5fVO1EUkoiiZRMvT4jl/VBCmBiHV3x?=
 =?us-ascii?Q?yDL3TRNrYwtxP/YwwdudaLZkgGwRGCPDqaelXUaelF8hRTkNooU6vrNcLUaG?=
 =?us-ascii?Q?z1svamyTKA+amKGgNgms7WvKjqAegAW1cX7932yDpCXyX8AwJcJDShl35eXR?=
 =?us-ascii?Q?8Kn9XIgKK1KtJeTleY3DPeiVUTGLD1TDXVwXjfAi3No8dUh9sRDubx5yVTEF?=
 =?us-ascii?Q?3ip8PpOd9MlPFL44AgyLZiC6HF1r4NqBMkvGW8XGeyt5MsyJcRvvEG2ON8i7?=
 =?us-ascii?Q?Osr4H+B+PTVP25zRSct3RcehRHL1TClk95o6zn3wcn1z37/lBspsqJQtHJY4?=
 =?us-ascii?Q?r3YZHLSagB2yNfdGcItNUbz6IWrCrfR/aGgK9CNqSLGUJpbYubxJs0BWnBv0?=
 =?us-ascii?Q?kT/rBA0sX7iTKaefhoNES7xg5wAcYSfg0JPtew1LvWHd3SoFRT3o16yyEpID?=
 =?us-ascii?Q?HMpZ7yrcKOLK4itUJDD0kBbBEG7HSTo9+5/P6IdPouP8kM+/ZmXMFAXAyqaC?=
 =?us-ascii?Q?wGs91TNeYTz9XZLWLU7jAnws2CI9XAl51GiRUArnSySqi58+yI62P672MvlF?=
 =?us-ascii?Q?3zDKBAuLuGB5LF+n1WhP0/s/+RZpt5kljc35M2vfuf1CohNjiw2gp13EaLWH?=
 =?us-ascii?Q?TR9WzSKBpg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df879c9-bb07-4e26-c6d2-08dede3a8e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 04:20:21.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFebayCM1IhLuZXGNEYCKS9p1IQRUi2b2ljgF/aPfzow1UBM6DUNe3KgXPy8EivZd4sIDczBTcTx6R2Kb3M5XN8yslkCDw+F4WzUvevgKoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7548

Hi Doruk,

Apologies for the confusion. I was referring to a different patch but looki=
ng more closely I realised both are different.

Apologies again.

Your patch tries to prevent an unbounded access in nxp_get_data_len() which=
 seems genuine in a corrupt FW file or malicious controller.

Please do send a V2 patch as Paul requested with all offset, expected_len a=
nd size values logged, along with the reviewed-by tag.

Thanks,
Neeraj Kale

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>



> Hi Neeraj,
>
> Thank you, and sorry if I'm missing sth!
>
> That patchwork link points to Zhao
> Dongdong's "Fix use-after-free in probe error path" patch, which addresse=
s
> the probe-path use-after-free rather than the firmware-download read.
>
> On the firmware-read side: commit 25c286d75821 ("Bluetooth: btnxpuart: Fi=
x
> out-of-bounds firmware read in nxp_recv_fw_req_v3()") bounded the v3
> handler.
> My patch targets the v1 handler, nxp_recv_fw_req_v1(), where (at least in
> today's bluetooth-next) the header length is still read at
> nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
>
> with no bound on fw_dnld_v1_offset, and the payload write still uses the
> non-overflow-safe "fw_dnld_v1_offset + len <=3D fw->size" form
> (fw_dnld_v1_offset is u32, so the sum can wrap).
>
> If it's still open, I'm happy to send a v2 that also logs the offset/size=
 values, as
> Paul suggested. Either way, thanks very much for taking the time, and I'm
> happy to defer to whatever you have queued.
>
> Best,
> Doruk
>
>
>
> On Mon, 6 Jul 2026 at 06:20, Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com> wrote:
> >
> > Hi Doruk,
> >
> > Thank you for submitting this patch.
> >
> > However, a similar patch is already in review and approved by me:
> > https://patc/
> >
> hwork.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2Ftencent_F2E2AF1B6F5
> 10
> >
> 577B10C6897ED768BBBAF07%40qq.com%2F&data=3D05%7C02%7Cneeraj.sanja
> ykale%4
> >
> 0nxp.com%7C667652efd25047817cd808deddfddf56%7C686ea1d3bc2b4c6fa9
> 2cd99c
> >
> 5c301635%7C0%7C0%7C639192279635192171%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0
> >
> eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpb
> CIsIl
> >
> dUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DQYHW%2B%2BB2KeS1FlSJb36v4
> NHS1%2BLa8W
> > q0oQscOroZra0%3D&reserved=3D0 It's awaiting Luiz's review and/or merge.
> >
> >
> > Hi Luiz,
> >
> > Can you please review the patch mentioned in the URL above, from Zhao
> Dongdong? I have answered your review comment.
> > Thank you for your time and review.
> >
> > Thanks,
> > Neeraj
> >
> >
> > > Dear Doruk,
> > >
> > >
> > > Thank you for the patch.
> > >
> > > Am 05.07.26 um 13:56 schrieb Doruk Tan Ozturk:
> > > > Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds
> > > > firmware read in nxp_recv_fw_req_v3()") bounded the v3 firmware
> > > > download offset but left an unbounded read in the v1 handler.
> > > >
> > > > nxp_recv_fw_req_v1() advances a device-driven download offset
> > > > (fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
> > > > bookkeeping runs even when the payload write is skipped, so the
> > > > offset can walk past nxpdev->fw->size. When the controller then
> > > > requests a header (len =3D=3D HDR_LEN), the driver reads the 16-byt=
e
> > > > bootloader header at
> > > >
> > > >    nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
> > > >
> > > > with no bound on the offset, reading past the end of the firmware
> image.
> > > > A malicious or malfunctioning NXP UART controller can drive this
> > > > to read out-of-bounds kernel memory during firmware download.
> > > >
> > > > Bound the offset before the header read, and convert the payload
> > > > write guard to the overflow-safe form used by the v3 path
> > > > (fw_dnld_v1_offset is u32, so fw_dnld_v1_offset + len can wrap).
> > > >
> > > > This was found by 0sec automated security-research tooling
> > > >
> > > (https://0.0.0.0/
> > >
> sec.a%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C667652efd25
> 047
> > >
> 817cd808deddfddf56%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C6391
> > >
> 92279635231913%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRyd
> WUsIlYiO
> > >
> iIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> 0%
> > >
> 7C%7C%7C&sdata=3DnLlRKyBusMXrHIK5NjCqZS7C0T6FTLfszBmagPI%2BDqQ%3
> D&rese
> > > rved=3D0
> > >
> i%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7Cc82fdb86e33f476
> > >
> 570ed08dedad83110%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > >
> C639188819230990815%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiO
> > >
> nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyf
> > >
> Q%3D%3D%7C0%7C%7C%7C&sdata=3Dz6YC4OGfeSW45U2PbFFlFz13DG3%2FSr
> > > qYeFKMSNTiMBI%3D&reserved=3D0).
> > > >
> > > > Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> > > > Bluetooth chipsets")
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: 0sec:claude-opus-4-8
> > > > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > > > ---
> > > >   drivers/bluetooth/btnxpuart.c | 13 ++++++++++---
> > > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/bluetooth/btnxpuart.c
> > > > b/drivers/bluetooth/btnxpuart.c index 6a1cffe08d5f..88d9ebf25a8f
> > > > 100644
> > > > --- a/drivers/bluetooth/btnxpuart.c
> > > > +++ b/drivers/bluetooth/btnxpuart.c
> > > > @@ -1041,11 +1041,17 @@ static int nxp_recv_fw_req_v1(struct
> > > > hci_dev
> > > *hdev, struct sk_buff *skb)
> > > >                * and we need to re-send the previous header again.
> > > >                */
> > > >               if (len =3D=3D nxpdev->fw_v1_expected_len) {
> > > > -                     if (len =3D=3D HDR_LEN)
> > > > +                     if (len =3D=3D HDR_LEN) {
> > > > +                             if (nxpdev->fw_dnld_v1_offset >=3D nx=
pdev->fw->size ||
> > > > +                                 nxpdev->fw->size -
> > > > + nxpdev->fw_dnld_v1_offset <
> > > HDR_LEN) {
> > > > +                                     bt_dev_err(hdev, "FW request
> > > > + offset out of bounds");
> > >
> > > Would it make sense to log all the values, as I'd think, such an
> > > issue might be hard to reproduce and gathering the values miht be
> difficult?
> > >
> > > > +                                     goto free_skb;
> > > > +                             }
> > > >                               nxpdev->fw_v1_expected_len =3D
> > > > nxp_get_data_len(nxpdev-
> > > >fw->data +
> > > >                                                                    =
   nxpdev->fw_dnld_v1_offset);
> > > > -                     else
> > > > +                     } else {
> > > >                               nxpdev->fw_v1_expected_len =3D
> > > > HDR_LEN;
> > > > +                     }
> > > >               } else if (len =3D=3D HDR_LEN) {
> > > >                       /* FW download out of sync. Send previous chu=
nk again */
> > > >                       nxpdev->fw_dnld_v1_offset -=3D
> > > > nxpdev->fw_v1_sent_bytes; @@ -1053,7 +1059,8 @@ static int
> > > nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
> > > >               }
> > > >       }
> > > >
> > > > -     if (nxpdev->fw_dnld_v1_offset + len <=3D nxpdev->fw->size)
> > > > +     if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
> > > > +         len <=3D nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
> > > >               serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->d=
ata +
> > > >                                       nxpdev->fw_dnld_v1_offset, le=
n);
> > > >       nxpdev->fw_v1_sent_bytes =3D len;
> > >
> > >
> > > Kind regards,
> > >
> > > Paul
