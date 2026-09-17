Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021086.outbound.protection.outlook.com [40.107.167.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB93AC0ED;
	Thu, 17 Sep 2026 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633600; cv=fail; b=lcrbq/xc2Rb3ZMMO/g2yFUroTPJkNGXCPySh+RwGVEYc/rJFPywvSV90QHoklu45bdX6eWORxt5S+0JHOGGH3gvZPvkCJpqULewORQAgCJbSeJGt2DpB4ULTsUPSvBdWMkl3WT1uTyTBLWilqnbeDOOohjuWsKo4EHRpu6yWMHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633600; c=relaxed/simple;
	bh=zjchQJ6tdJ+YCV4otKJLzVDoFUw46j6p4T7UMA9GWbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=fR2kSTILl8sd3NmyU9Wua1HIoA5LGDpdiIxlgGkh44RxDJMhVndi7879QUf1b0XO9xxBraAr1klQJD0APrKyjmVdkYTNRWz2sZ3EuQWoCixFoJXpsX/2IiX6FYLL4K5IkpKNB/j0iSOIm/BXNZwJl9DBWI8Rk8FHd03GgUXscS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=rgKJhl1B; arc=fail smtp.client-ip=40.107.167.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="rgKJhl1B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REpWRK+CNK3Cg5gfT3RYlg+DlVmy0fgKc/NSPprypkGDcigguhBftx1MHyMhPL0Ox62LZWOc5lechvAonhBP2yfeNHTKudwib5z2C9grS0707qKILrjHTqxLxofBkZrJ6Mm0P37McaCYrJjhJ8+sFtNZDh4pU4C1coRZBJJZFH4AU9EhpZjAH5mAbI/V5tKldPAXLNIeXD8DlJPvSQxtAlOKA0jegxEY94aTOckUNE6Pbl3jxkXwCC0V1LPkj6iqsbJTFDVTwElUoeWPg40hqResyL7RKfn7htm3EpX4oo9Ugxn6ExBrkPR1zuNll0XFsafqX37+yMkOkn/WOwUb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJq8fZp1wI3N5vSrYBBh5i6BbPInHIwlK+rz4ydmPg0=;
 b=FEIPjBsm5XsGMqC8IWCg92iuVdhXtZSBC/3JBh7g/kaFc2SqY6TGHtmBsglWrgOMIlSb6sM+nJiUDlENuWDR4/m1Yo24luYWtnAIs5SMPG9yWNB5EBsmQHemhQRP0xWwaDILLrtg8NexNMc3JT0QsnX3132e/M3Uxq9dhNouj0EkqAPMpZKm9y6FP0jJEuRHPb2BWMdjcZS4BMsC22vTuZop6aPSLwyOTPS8GpN7rnrY8XwQnHg0iuSiZbtdTVAjvXB3I8sAm9DOueiTlBz/ZDHKf4kdVHmQh/ShooxvECSjt3c9B+tRgIibcLa97/wactOflYSrkj3GcbbMjdcVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJq8fZp1wI3N5vSrYBBh5i6BbPInHIwlK+rz4ydmPg0=;
 b=rgKJhl1B7472G/CfxWrQ3An0YZax5PgqA+VqG3b6tHOmFauhFE7Dh8WUZeWtTj1I2X74KBx51vw3Y2IA4OJzvCd1m3DJITLlDVi0lnLk7NqpcYn+gaVDrLxAGa8apljycd1ye+rIlWR1Nsp21MnKgAbWvQwY79kBE3T7UdRTNfW36orDcTPnevXSYwnjU/vd3ch8qJnn1nVq0Ig5ABD+MAGvH6VkBpZfAgzsT5lLDCvcEGtjfKg37N42+QHdp4jog9RlM8xFJSAZHtzfdZIdGANNZPuJO1WW1Ywoc5VlLACbaEMP5CMmsOPPPhitXYkw0hwFRRmfT2UlLivgBglS9g==
Received: from ZR4P278MB2224.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:c2::20)
 by GV0P278MB1538.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:64::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 08:26:11 +0000
Received: from ZR4P278MB2224.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ec1c:ca10:29c5:5482]) by ZR4P278MB2224.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ec1c:ca10:29c5:5482%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:26:11 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: "rafael@kernel.org" <rafael@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>, "nathan@kernel.org" <nathan@kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] rtc: cmos: Use platform_get_irq_optional() in
 cmos_platform_probe()
Thread-Topic: [PATCH v2] rtc: cmos: Use platform_get_irq_optional() in
 cmos_platform_probe()
Thread-Index: AQHdRn4x8oId/mrkxU6j7O0fPC1gMA==
Date: Thu, 17 Sep 2026 08:26:10 +0000
Message-ID: <d35e7730006ac5a2ccaa08092201994afea668cb.camel@impulsing.ch>
In-Reply-To: <12857714.O9o76ZdvQC@rafael.j.wysocki>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR4P278MB2224:EE_|GV0P278MB1538:EE_
x-ms-office365-filtering-correlation-id: dc717c7a-de38-4c65-9518-08df1495547c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|6049299003|7416014|376014|4053099003|22082099003|18002099003|38070700021|56012099006|6133799003|10067099003;
x-microsoft-antispam-message-info:
 KfMtGf9TewELDpZq75y0RO6ZCUoQqTAqn6ESrna2SSlVY1zROpvd01nzsWNLxjyJ5scom4LD1SlLqIOxAQtI7HcQgRgSFixp2B52Ko8j7ARWueCYa+iwhIX04c4JMVp173R5T1trETxDnj/l9fWw9mziqohDasr2YHJ2zWuHLcychfAlhMJdd2leHEgr1HG0Sx5nCB+H4KO1vj+v/AD2zAfTcL2EZNumv18Rq88jv6DZUUXPE4CuCeDiYj6qKXEOs+DJIumtDvti+5a475Aj0Yy2rJ53/ljssogP88EzlpcWd7Oo/AOCOslyZe4kQiagPF30XrHKyUQMEtZZ8+XeIrGH5wl3MmRibDyDSvn/NFeP3viK0drzbCkliTxQZU2jHLyRxyQ5Xfh9UnH7B0NOpXewisWQeeSImfwe7iiSqwOqSyArclkNcNZKvKtrH3VysPCkB2dy+pz46LLTBa/sRRfuM2Udlg4naJzgCbXlPfa7ZMpYFM65XMOcztMej0sJ9H6oDumGsbcQVYxcj5YgTrseKpJxdYOr1ogNWkkngNQ5jjRXTqd/Sgo78ceHfazbAaXW3r1nC8pO7y4bK3J0+PL/wprupxECvEYr1mVxh5jSMZ8mXsw77xJfXiIHhkMVmBvNRC6mx8O27JMdbhmIfvfSnjUWZmOtpCyKqoUZfiLIfOueKg80D6EYLKekEmhBuD2ocKODeBpUUbmgXmGlBw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR4P278MB2224.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(6049299003)(7416014)(376014)(4053099003)(22082099003)(18002099003)(38070700021)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmRuUXR5K0k4ZEQxMFlKQzZIakEvMnR3WGU2b2VOWHQ4a1FESFNTRGE1ejhF?=
 =?utf-8?B?UVZLZkhjYU9NZFdOSW1IbzEzRTRMVFJ4UFRRK0RIcDFuVjdoVHRIcWVid1B5?=
 =?utf-8?B?R2JIZ3BuQ3p6Uis4WTY3Tnc2L2d1QU0rbHFoVmhGTXh5UUpuMVJ5aDh4QlFY?=
 =?utf-8?B?U0c2K3F6b00zUzFOWmdneW1JY0pvUC9DZU16RGdPRzFQOFVmS0s1aFhwemI0?=
 =?utf-8?B?VXF1KzdJQWdaaFkyMTFSWE5wOUh5MCtLNEtDVTVkei9Tb0N0aHM1WE9vd1Fp?=
 =?utf-8?B?NFl1cE9KL1B6a3BOaFpFS0tJLzkrYmlYS2FjbFVEa1JFc2tZQ2pTaUJNazlE?=
 =?utf-8?B?L0FadUpVQ3IxK2FIODFKbmtIV3p0dmpLQ3hLSzl1U1NiZEp5USs1Z1R4cjJ3?=
 =?utf-8?B?cXF1dUFvYW1EdlA1ZXpEN0VOZURXUHN0bW41WU5meXBQOGtGVUpUeS9IMFFG?=
 =?utf-8?B?VXlvMWVjSi9kYjZodUlCbGFDZ3o1TlVsR2k5NW5ycFRqWGUyeVdMbnpIdFl3?=
 =?utf-8?B?NmtZcDM3M0luTUZMdUYzaHRxWS9KRFJpWmduN2dpblZxakFVTWMzeE0wSmY0?=
 =?utf-8?B?dEk5WFhwSUtrSEZpWWN6UVdvSXJmZzdxT0EybXhWZlE5aE1ML045WVdFMlZj?=
 =?utf-8?B?Ni9LT0E0WUxOUWxKOXNCN0pUTXB3QlV0TmxxUThFVG5XOWNDRDhneGhhSUlB?=
 =?utf-8?B?bnY2ek9mVEF0U25uTGhHcmd0TUZJcHJhL05oSFM1Ykd1Mm5ja0NRSWFsMlZJ?=
 =?utf-8?B?aVhxRTI1V1NpQ280TTdhTHBlL0hPcmxITVAvU2dXbk5LU3NHcWtwVk14WnA5?=
 =?utf-8?B?NGJ4STByWXQzS0QydmZXZmNiS2phUmc1Y2gwcGdIQm5sc1FMRDhxMnhYOSsx?=
 =?utf-8?B?c1puNEJnNHp4T1g4WnluMFB5Um9DVGpxZVU1dmxFd0FxWTBhT3dNTGxkRDlX?=
 =?utf-8?B?VUZaVzFSMVFyNDJYdUx6S0pmeVJqbm9sTFZEWWkwQ1hCNVNIYXNkYks2TFRO?=
 =?utf-8?B?Y0ozU0podlpvci9HdnZHckFsTDRBL1phaTlIeGl3MjgrajRlRVhaeEVEa0NM?=
 =?utf-8?B?NFkvNXYxY0FOUFRxYTk2WWpzdUVzMXErUGwydHdOclZSR0VvQkJYUkc5d3o2?=
 =?utf-8?B?aG1xeC9UUmdTcExuZlBISGdwSnBqYnMxZHN4ZlNNL2hQWGoxYUxxVnB5cFlZ?=
 =?utf-8?B?OVdOOUt6ekl6ZzR1Y3dMWEtJKzJOS1F3NXE3TWpUZk5yMXphcHdkcjBUYzVG?=
 =?utf-8?B?enpQZWxWTHVqTnBDd3drd2p6dTl0MmVhSC9QVWM2dStTbGFQcHJDVWlVUkZR?=
 =?utf-8?B?ZEJSSS95dEh5ZHIvWEJENGxRbkNWZytCbE1BTTlETnBEdExWS3dENC9IWWdO?=
 =?utf-8?B?anltYlZFWFNiZ3M3cFhDNncvM2k0dFJPWXpDOGlodFYrMGwrRkI0Rm0wRlRx?=
 =?utf-8?B?VFY0WjQ5WGNFY2N0TlZlRXBsMjVHaHNLa2V2SWk2cEVrMmkxU3d1K0xWSzBy?=
 =?utf-8?B?RFduSWIzc05LeUhnWG9FOUp3UXUrTTVMUTZYSVlxQjN3RitaRnVKL0lSSEcx?=
 =?utf-8?B?aitBQ0lsOFRSc1ltK2dBK0c4blMranpSZ3RUd3l0Sm5pcHg2eWpEamxRN2Jp?=
 =?utf-8?B?M2JxRXJBSDg2U2VWK25aTW5KeU5CMHFKYlNPbGZBMENyWnU3YVdTb3NvOFRH?=
 =?utf-8?B?UjN5VzR2bWZtQzdCRjFya0dUcDZzN2VtTENIV3h6WXhoZTZ0YVlZeUhIS0RC?=
 =?utf-8?B?ZlBEWUNMWGpYQm16aHJhaHdoZVhtTWVNV05MMGYxTzRLVzF4L201U3hJdmVL?=
 =?utf-8?B?NWdIS2paVFZwUk1WZGlxQVJyWUJva21QTlluUmhqa1pZeVdyRGtFbUY3RWw1?=
 =?utf-8?B?emhPQk1NUTBGeklDeXJpUmNJTGhXMm83eXQ5OThXUFRkQzg0VG9oSGhIY2Yx?=
 =?utf-8?B?N2VrUWpzdlpLcEFNME9ReVpjbDVuNWMwZzB0V3hPa1ZuYkNmcDZsNjZvemNM?=
 =?utf-8?B?UXl6cWhjdlVuRElZd1dOaHRUSWVkQ2hmVk01VDE1VlU5aUkrMjkvaG1qWGNa?=
 =?utf-8?B?dkptNkVZdE1XeU02YUxzQ0I2UTdQK1pSZjQ1ZkVsdFJJenJCaGlsc0hQWVNW?=
 =?utf-8?B?dzVSOS8zaWpEUXU0N1RKWmRzNjIzVmh2RTM2QTVERnF3NEozbnc5dERTL3ZB?=
 =?utf-8?B?YnN4YkhwRFpGNEdJb3lGOXJobDdRODYxaTdBTU9CbU45NkEyeUgxWVRWbE94?=
 =?utf-8?B?bWhrQjNOTTdmRU0xUklhNFN2clVPekdTSEF4MDlEYWxoc2JkY2FVakNra1F0?=
 =?utf-8?B?d29nWUJsRzQ0ay9oRjBJTmtIeVRmMFBWTGpFaXlEZHB3UzNUZVV6dXd3YUI2?=
 =?utf-8?Q?C6HEqMJWzEoV1k2A=3D?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-6rJxH4ASE09NOf8LQUEV"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR4P278MB2224.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc717c7a-de38-4c65-9518-08df1495547c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 08:26:10.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KXc0leL8ueVOtB5C+Tdg2dsJ3RLdLZSLV68QnXuPJoUY6xxy6AYljujoxJzuApToCYfSSIfylHg/EBI49DYd6pt0zylqhP5cCVIOl0rdC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1538

--=-6rJxH4ASE09NOf8LQUEV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

this patch did not carry a Cc: stable tag, but the platform device
binding changes it fixes have meanwhile been backported to 6.18.y
(6.18.51), including:

  ACPI: x86/rtc-cmos: Use platform device for driver binding

This fix was not backported with it, so 6.18.51 is now affected by
exactly the problem Nathan reported in

https://lore.kernel.org/linux-acpi/20260303060752.GA2749263@ax162/

On my HP ProBook 445 G8 (AMD) the boot log changed as follows:

6.18.49 (good):
  rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram

6.18.51 (bad):
  rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
  rtc_cmos PNP0B00:00: no alarms, y3k, 114 bytes nvram

On stable this is more than a confusing message. Without an IRQ the
RTC has no alarm support, so CLOCK_BOOTTIME_ALARM is not available
and systemd (261) refuses suspend-then-hibernate:

  systemd-logind: CLOCK_BOOTTIME_ALARM is not supported, can't
  perform suspend-then-hibernate.
  Call to SuspendThenHibernate failed: Sleep verb
  'suspend-then-hibernate' is not configured or configuration is
  not supported by kernel

Plain suspend and hibernate still work. RTC wake alarms are also
broken:

  # rtcwake -m no -s 120
  rtcwake: set rtc wake alarm failed: Invalid argument

The fix is in mainline since v7.0 as:

  e9f850ba66cd ("rtc: cmos: Use platform_get_irq_optional() in cmos_platfor=
m_probe()")

Stable team, could you please queue it for 6.18.y? Any other stable
series that received the rtc-cmos platform device binding backport
would need it as well.

#regzbot introduced: v6.18.49..v6.18.51
#regzbot title: rtc-cmos: no RTC alarms on x86 in 6.18.y after platform dev=
ice binding backport
#regzbot fix: rtc: cmos: Use platform_get_irq_optional() in cmos_platform_p=
robe()

Thanks,
Philippe

--=-6rJxH4ASE09NOf8LQUEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----=0A=
=0A=
iQHTBAABCgA9FiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmqrpCEfHHBoaWxpcHBl=0A=
LnNjaGVua2VyQGltcHVsc2luZy5jaAAKCRCNEONHaGhfGolzDADjqUcYkE88tkCN=0A=
ZF2+VuUlI7UVh3dXDw03fSnn2Q31XWyzMs/hC16ENhkRke9tthvy1uWYIeSAURr8=0A=
8VAaYIW8OkK+sWxHEk10rrw1qmxlBgEOfWILIFjlLsnrFobYfuG8FqjQdX+2lNsW=0A=
JaLvQDadMdCde1K0Y4QT3Plcj6Kgf0kQiEE32PWSY7lcHl2hFM14t1Z7VH1wxnuY=0A=
1YZExIqaV6P5ZCcgrA4yDWQUdn8ANc2L+1Rqop86FC7mbwqralvXSSDODkM43/6+=0A=
eH1So1qrUC9eRdXdzlMXNQ3pNPHvBVtz03obVuzLXpxqb1uwrBNxo0+FRhVcGmMA=0A=
h+GXOt+o3szdXb3KmH/sZxezrSMnmcokDNGQYMZazkvbRJ0IyxBL/Zt+bzOEz7Hg=0A=
1g2WWxHQr9bz8J0qnjEyvNsMxmQIEdjG3bDLr2zLH5EdG3/zVDn0++yswi1gb1FE=0A=
sTu97Jinxa+RgKoyzUtk+EW1iPJt24UZ2BsokjjoNoOaW5076eY=3D=0A=
=3DGEuN=0A=
-----END PGP SIGNATURE-----=0A=

--=-6rJxH4ASE09NOf8LQUEV--
