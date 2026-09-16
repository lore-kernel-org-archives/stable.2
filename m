Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527094E4314;
	Wed, 16 Sep 2026 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592834; cv=fail; b=SpWEiVpZiVs93RlP8KF468m5YUZySAHf7ZxuSWSxvUM36u/2GkJeo6iU7UAKXtCWxoynaybRXirszpXv5y4DUe8XGS/OP54m65OngXUGLOneY/MNZK5eYyTKAgvGjiRkoz3xUQssp0677qmgnQSW/C16G2s3ZWwss2USY6TtsI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592834; c=relaxed/simple;
	bh=pxVqG3VzYPIzQ1o/XYEqY+Hga2+7HgDDWuZUWyrLtRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3JgCszc0PPOPiyctHB1n79DyWIy6Xb+Pebfgdw+jb99/W7+AqkW1zMw2F45zhLWCQdSPD9Ozdu2OIz/bi/mcsOVRWmjL3nBs/zdUBFUDn57ZqP4djQ7gW5NhgB3DcAM6y1GoL9r+FjKJI770G4KkRM3Tns85v67sjYd/p+m7Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jQpE1Fl8; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jQpE1Fl8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu9+3ss97FT0qHYzyweD9Ox6LmVpoDdUm6DtUwUXSyUiKN+5RINuCuBg17TWH9AO2fQyOC/e3IUB+FudmMY47PT/klV4NgPtkjctdeVThkdoZP+SsNO6yS+XYJFceKNLzBh6wRSP/qLkKNwOgFAgCUHlyuL9puxPMCBxdt41qQWiYysLpvLdD9Z4E2wcJFB0LfYXizGlQh+mOy24zhfcNqx1gHW9V3N+ptNR0ZJw5Y9cnqIhhAhGhi4jSecoNPvuM+vSndyS6NY6Ib7VrbMS7NJ+7xHT+3rbVWHqtVP2P8FDaPTk3L9i5foEb5pegeTYMnKoRE0cUqXPQ6Wkg/RzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vsYhAau1sdJODOWBLT1OFowzkqXHmfOufk5m68stIs=;
 b=v3Qzpqv2FsqIoIdJB/4Bg+uvOM2aY4kUpDy/YiJGBAE/H5H476OVA+vQrpwXI50w26GO6SEmDMTAnt5alzNee0mSd2QGkiahKDtXd3bbe2hsMLNb2qJuHMf7COmB95WPAY/0lPaPzecjlD+u/BoYw4Q1lVOfzeuNQZX5XKCkoQIKjHSBvIeC2a36engMbNjT4lHmuzcmD1XHk7zJERr7pqtTZA+nqBtbOz/esRJ6htd/AW7Qn5YLwfwpyc67xDG9rYh5s99IqdBhoBBZljrij92Dsj7dj6BbQ6519YPqsnSIS31Ng0NCndfmokB4X+XasmeBsV2HUsjahbQR0bxauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vsYhAau1sdJODOWBLT1OFowzkqXHmfOufk5m68stIs=;
 b=jQpE1Fl8tNf3tuSM+J0r+eSW3WhRjRPmrgnrrFDaSc9QqLtTe1gzKF0+qWDIcEVcEwWeRdz5t5MDiuRnOaHOeGV9+WtYYJwnO9VXfY8iGz0g5otPTdj9PwskhC8e3sue/7a75+uHeX1l5hpeEG8Um3E+hShOJA1jdcXMJBvxFR4=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 21:06:43 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 21:06:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"javierm@redhat.com" <javierm@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()
Thread-Topic: [PATCH] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()
Thread-Index: AQHdRa5sZ+/6Msn6PEaex6Kl+iyJjrbRr/Lg
Date: Wed, 16 Sep 2026 21:06:43 +0000
Message-ID:
 <BN9PR12MB5146B7A8975825C3623CFF97F7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916073815.1972045-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916073815.1972045-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-16T20:55:13.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SN7PR12MB6816:EE_
x-ms-office365-filtering-correlation-id: c935ee11-5e7b-47a5-1294-08df14366910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|10067099003|11063799006|56012099006|22082099003;
x-microsoft-antispam-message-info:
 deBMQNQnMXVrLEk+oRVpDDEPjEgppthQ1CrkL0fgr1AFNSZ7QrwGcMC21yimjJ34ouJwlQr46a4w81bmJC68mAHQEUCbyr/AmO0dap/SZCbc+ZxNwTAQmz4Rkv0tfpLkZ/X5/FP5EVWh7EtfuXXKHLOq/jjheGFp3Im+9Mvj85EZpX8CMVw8U2G54fjDFPFjF6LCQbGUA90dqtx0aHXTGiZUIzcz4dpuN00v3yyOxX6k/4yesOEbFd1ZXS7ATtFwJpeJAvKrn/lZMBBXHzqZ1M5aQI7/lD9L1hCC9r2lBe+2BY5pvtBZGZsrP8V+05z19smF+gpy1RgduhF8PvWSpwKtMShZYJbpOkwQYo+3yUOn3ymbqlIpuYrdi815CiSYQweZbWyjY4uW2kxa3s5ePXn30kslei6QgJfcK3zoEIR8AtgTpDM/NGfW4nRR2AAH4FJvqzZUGNnXGTDyd93Ul6s014PPOo/04sBrbWwx4LgZzEBIl5NFgbTr7HiNGYwb1j05vM3QvRX74WQRDvOPLc0GnTpEjdiu9SdiXhr3tMP1+JTYD+BYPB56O9ch3/pfkGOsgxuDD5kY/476rsE8B95NoM/0pfXVtuOh3AfhbFjHTZImScHq9wNA0YDw66p68ePFzOPqW/Krt79xpr0jvUPpRufPxj/4URgTkENg/sFsDx0g7DD2S8J78cs1o4COjnvpzn3SWtdbwLIi0qZGiQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rB+ZHF0521ZnmavREHYizxPaqbVMnBfGZzoPBu3Ki8HSOrmthkboj+2dCVJ3?=
 =?us-ascii?Q?LqP2oY0AVxTrR7NAgejHGHWSUHfGMZFMZbB9RaMXkk97QxBWyj2cSNchHRhm?=
 =?us-ascii?Q?dxHzWRXSLsMjUQxMHHVI3a4OXDJpxeIvtqMuSsxX6TLopL4Ra0jBD84n2vKT?=
 =?us-ascii?Q?HJnN7oUMYsgwoRJCkiDGd3m9gdlEM9zln/rD1K5Uj4Yzn4VgAcdbRdtU4KKf?=
 =?us-ascii?Q?5KCSBGLFuAdoOvK5FtDCCJyteMPDxrY2xDxMp4RYpvXCHpaU9ug1aTM9mFJc?=
 =?us-ascii?Q?ny2W9AW8vWuvZ2bvceCm0U5M90rpUDR9rY5N31S7dpmggsCMB3GreSbykkc6?=
 =?us-ascii?Q?2sMiTJ3PZCEMAcBVBsL7RsLkeRXmOK3FDsK/JfEKfwrJAt35W4ROQtl0rC+5?=
 =?us-ascii?Q?j+tgfEEL/bEUKOiTMTfHLvS0rny1aUrItexRg4r5IcO/tyYOVWH/BWUU9YPn?=
 =?us-ascii?Q?Uilq968VTEsShMxhYAkk8cbpLiti4jcSCCoMGelv34bJ6dxY43rIY/CIgzrq?=
 =?us-ascii?Q?4v1z28WMi5KKxQBSG1zjWprMEkWF7lf7gPcOnDITAu6MlozhSQGuGONIrzy6?=
 =?us-ascii?Q?+uRFZHdX2IOYdO/SNhpPowwbm+GH394RAhRbUokRKp/sqWQ+1InRAFxiQczw?=
 =?us-ascii?Q?aor7pSLtSADQGd3tHVRuCyOWG6rzSdilph7FkhtZWqrWPsuIOTrpkAgt1p9x?=
 =?us-ascii?Q?MPkNBB9euN8HjQwvoGiOPhtc4rrOsNm43782UHO9qf3TkTO0rn8ESUc8czz5?=
 =?us-ascii?Q?2G9W2zHmXynEHIzqmm0QLyq9Q84L+tpwO9gK5kcFX0+v0DTVjUu6dHqNJK9U?=
 =?us-ascii?Q?j0GVJs3HRXXr0zYlZiAlAcWjycJ1I7uoh7ufCVK3WwqWD5d9QOQ8FmB/uAzM?=
 =?us-ascii?Q?LerRMaeKHuoRb85urHg6QvJYLAS5BRpB2bH64VUStS6lmwbvE+EQuT6vY8cX?=
 =?us-ascii?Q?Ua8cX8O2zNg5R3oL+yB7TiugBA0iZV5li2s9RWRnWYJVRzJld5gxZXovf49R?=
 =?us-ascii?Q?dXtTLlGjgTHBdpJaI09TlMV4kQt68wpWx684ZkiWqIw4eJvSz/Iv9mVm6JhQ?=
 =?us-ascii?Q?Ke/1Kn0PiJKLeV6HJ5PTuMScscNN5lM77KaMX6WLXUdPHUD1k3RAwhna/wLj?=
 =?us-ascii?Q?gzWLbY0JB6dzeMxNPvlxcsYJf6tqY+nxrkzwTSNBK7oKtqcpzDOmYNR3WXBu?=
 =?us-ascii?Q?TeIR02TfVA1JMuPavUTzQ+8AIfVMyJV11dD9uuYiuNxFKmGuMNsPu3+QMBYJ?=
 =?us-ascii?Q?UWlIS07Mra1D7oeNytrqv8P3VqxXDHqPSYCP3d+x4NZ4FX6vno2fVBmvfNAX?=
 =?us-ascii?Q?rgKmWyFX9FRV2thgy4foJ5dg6MV+53BSDhwTrLtnVwJpEdc4KcxbcYNmCBDq?=
 =?us-ascii?Q?U7sg5/fZz1qRAB6vB7lp4PUJLu5JwTwOWVC1dTFpb2cAuLPSBDHoRChOweSz?=
 =?us-ascii?Q?bfxL+0dEs5lui/Ah5oKBLv0AbRFj59PESmK2a8HKVX51yqLS1Sxs1BfnYCv0?=
 =?us-ascii?Q?m7OaUnmj2dKWnPa64Mt5oqF2ZhDl7IaiQuOWN7ksfS7QQX9du/Xc0hcP0GJo?=
 =?us-ascii?Q?6ZcBirxlAcvL7RaTYI/Kbl2opG7JdfNMsydJNuYp9aM+i6iAmkVBNrfH6xDF?=
 =?us-ascii?Q?uQv5wACPZ43A/qY0jbo18RBDIUrG0iVIhQqILzVUFfrI+9UgS5RCIK1YFkLu?=
 =?us-ascii?Q?qu8lcMRkcwZQuwOYXPu7vBwvEJkjlN5pHDsx9ZYavwYoXvs1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c935ee11-5e7b-47a5-1294-08df14366910
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 21:06:43.2931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PPLOJjAofNEC9ywQNB4OfGiWqqpdOB5FcOiyGzwYqv4qiqVf5iBxb7p4O/RkaS8xAoohHSRT6w0TfORJJHNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816

Public

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 3:38 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: dri-devel@lists.freedesktop.org; javierm@redhat.com; linux-
> kernel@vger.kernel.org; tzimmermann@suse.de; Wentao Liang
> <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] firmware/sysfb: Fix device reference count leak in
> sysfb_disable()
>
> In sysfb_disable(), parent is obtained via sysfb_parent_dev(si), which ca=
lls
> screen_info_pci_dev(si) and returns a pointer to &pdev->dev with an acqui=
red
> reference count. However, sysfb_disable() does not release this reference
> before returning, leading to a device reference leak.
>
> Fix this by checking if parent is not an ERR_PTR and calling
> put_device(parent) before releasing the mutex.
>
> Fixes: b49420d6a1ae ("video/aperture: optionally match the device in
> sysfb_disable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/firmware/sysfb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c index
> 8833582c1883..11c5ce128a6c 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -71,9 +71,12 @@ void sysfb_disable(struct device *dev)
>
>       mutex_lock(&disable_lock);
>       parent =3D sysfb_parent_dev(si);
> -     if (!dev || !parent || dev =3D=3D parent) {
> -             sysfb_unregister();
> -             disabled =3D true;
> +     if (!IS_ERR(parent)) {

Are there cases where sysfb_unregister() would need to be called even if pa=
rent returns an error?

Alex

> +             if (!dev || !parent || dev =3D=3D parent) {
> +                     sysfb_unregister();
> +                     disabled =3D true;
> +             }
> +             put_device(parent);
>       }
>       mutex_unlock(&disable_lock);
>  }
> --
> 2.34.1

