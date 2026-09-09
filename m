Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011029.outbound.protection.outlook.com [52.103.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9143553A;
	Wed,  9 Sep 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949700; cv=fail; b=YkpYohRPNxUeaR7+z2X9MpDXCwAno+oINIQ1yjqHajTzZ4JY/ycXNAVbY2vj3AazVuEqfVka/QKx+oMaP9JkNNomYG+oXrdt5CTfgokzTopLePhAIdrB/TgIY276bpY7gc6vEEVg6NYs/OUu0yLZvXrsj8myiq5ob1Lrz2j9m6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949700; c=relaxed/simple;
	bh=vaU18lbKquo3rvmXjNCFIEqecs2MfDKi/De9PQD+ido=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RdjSC/1nuIGqGIETxckwIhsJfBURvzCB2HLcD4K39at9vPzRgZy7EIsOUTk2iurBiIYQ32pZKGiNvxVljnmCa8+xN7SxymwuSILWHf6gyEauj/zLc7ggmZtePaGxRb2k0aFKxlXWPTfWaszJ+nXCoot2YWxupX625Xg5g4rUDd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.jp; spf=pass smtp.mailfrom=outlook.jp; dkim=pass (2048-bit key) header.d=OUTLOOK.JP header.i=@OUTLOOK.JP header.b=dtyAb1bs; arc=fail smtp.client-ip=52.103.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.JP header.i=@OUTLOOK.JP header.b="dtyAb1bs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDGFJdWohYhot7zMOAQinYFEjjyhS/lE9F727UPNyS+isz8rC+oTHnZasGptimwWNNDGe5oJKiIpzwVMn/MEFGj6DfNMi61LD959M13r9iWkE+BKwcaKAbgWRZp5hPo+PXbm8pOWvdIGsN0UJp10eZkXNRnKY50WBbOh/OvS+eK9Xk8aPy+UCrV4c0qyG9ZhrKPY3FB69apYOdiyssuP3+FLUyNLIY1LH/E9/vvODDnasXhRV7gs4LNAMW8D1BiGC13dW0XMhu1IsnxVgqslnqtYJE6h81A8NffB8UxjBmT9bZwqXFJ4pCDwH8Ym0O6RswDtrXJhcJEwCmqmyKk26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5UFO5FY+WNqu/uDoUcUp6dWdGwHtXao42r//FHTOvI=;
 b=chgPZ13pwON3TdpWDuz0GE6eXImxhjNvwRN80D0+keqqiA07ZzjUEKsMxtrD/K8dtV1sWYbFLrmsFElcrU5SWE6kaPSSsxny6MZmVg0yjQb0/78rIMWQLTgU7e5Fd16TJ8qZj/1uFGlJtVERJki/QIFoX4s6u98NqqEpnnMFCsaLJxuvZH6p4fszYXwylDj+bcZwCaLUZ3N0irJ56xVU9Cxg/Y8tX/lzZSDzSwxeGTGTKC1uv+5o4tacuSaT/neCcvTdkrSdgPIftO6puln/YFHi7CkdTtTjcQ+xfwxosMOosK+UdpSYblcI4u1TYphdf0cynEtI1HDWVWAmM54Ihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5UFO5FY+WNqu/uDoUcUp6dWdGwHtXao42r//FHTOvI=;
 b=dtyAb1bsdXjLRR/1bUs8g2qQx1uPssh8MZreDq+S9oySAKVwJKpBpTdHg8xK7j0fNJLMV6YU6OTSVb7Sl5ElvRij5Nkc2EbCDl8ydt/hnFPeRWoE8I4Q8PHKBXlXDPpl12NovQbqdJakFV1S7hFY6DN/u9+NG2dW3ac8r2nwkFwQp8PhuagMEYp+07qD8jZ+xY/yrDox1ldZfl7eagAbHl61+45lF6d1aQnU4KnaZjJXcnnOQ8WNENox986meB+72o9QOfbHnTbau3pJ6juuY5mQNjKrbfdOvD4HPiMowQHtXEsqH5F8tcB3ULSAF2mKWTWtSvTBQ4mrfXKprVra4w==
Received: from OSZPR01MB9313.jpnprd01.prod.outlook.com (2603:1096:604:1d9::14)
 by OSZPR01MB8307.jpnprd01.prod.outlook.com (2603:1096:604:182::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:28:11 +0000
Received: from OSZPR01MB9313.jpnprd01.prod.outlook.com
 ([fe80::90bf:9b82:54c3:1542]) by OSZPR01MB9313.jpnprd01.prod.outlook.com
 ([fe80::90bf:9b82:54c3:1542%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:28:11 +0000
From: Keisuke Tsukuda <tkdkei@outlook.jp>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Wulff
	<crwulff@gmail.com>, Edward Adam Davis <eadavis@qq.com>, Michael Zimmermann
	<sigmaepsilon92@gmail.com>, Peter Korsgaard <peter@korsgaard.com>, Keisuke
 Tsukuda <tkdkei@outlook.jp>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH] usb: gadget: f_hid: keep GET_REPORT request across disable
Thread-Topic: [PATCH] usb: gadget: f_hid: keep GET_REPORT request across
 disable
Thread-Index: AQHdQEXpJ/QGxpTl6kG/BkKjPJx4Yw==
Date: Wed, 9 Sep 2026 10:28:11 +0000
Message-ID: <20260909102802.26181-1-tkdkei@outlook.jp>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB9313:EE_|OSZPR01MB8307:EE_
x-ms-office365-filtering-correlation-id: 18cf5e37-e0f4-40e5-fdcf-08df0e5d0c73
x-ms-exchange-slblob-mailprops:
 obhAqMD0nT+6TxoHw5fNkboUl/ASnSn2vw11fA6CHgZFwGtdxq09LGUVwhoHSYEXjFp/cPMmv5w5g77KWqX9MqOEVV0q801xCu4wBcaNfAUXSmdcFm5lJWjPS1E6VhZP2/O+vS/NNi6Yx0R/oXaHQwA0OWxhR00SHb3/TlQ6FEIIXlTH4eVhxyDdDQei+dnIJzdj5Pysq0MSpgsvCu62/wSHiPBe3Qz5bR2hug4szbnyhtNOdlbyJBKCeCxkK7/6/uoY+HpfznKBvmBAaHB/qFpDzUR7X+lS9MMUpkRADT1RIr5OeNuQNUoqhFIFJySs+hRhT4qVsSKNMZXEQljkexUmZIVOKSzSv+2BUHrKjHsYRxjjojqkbpc7R9F95kpBdL8PC57EwbSs+ViXPfdyZ996zc51UVMadmje2hvmAkY7YtCusCoCoCf9aLUnXuJoTyri2MsLXnEr6rpN+GDa50jYlMXAK7dFte9Nw6Bdrja5GMHSEltNNt+GeHcCQ0ZnqsLB9rDVnGcRI570vmWLwVBFxZb030JTlo1ASVpm+cOnuhBTkyL3vNx1d711zUvNJeyrDnP7qCORYQbmvNCeXA6sXjoQCYAGV6b1BWemjD5IFpfewtGpu9B5BMXAeU9n+6tab+1gZZJGQ9yQayBWGOOxbkp5QTP+C4nPrdjX8msXSq87fJxyclbcfz+3wmZruP9p59VftA2mCxSwEN4hVDZFLw0ddLsQXjyck86qpfEFe7KVNyK9msML8WcRhnUPB3TDaJjgS/qhW/N92UibFXz2fYpaREFuKgQ4ET1uahONhkebimSeA9FiiusL5Ug6
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|24021099003|8062599012|15080799012|41001999006|31061999003|38102599003|5062599005|25031999004|25010399006|4140399003|40105399003|53005399003|1602099012|12091999003|10035399007|2607281247196008|102099032|3412199025|4302099013|26104999009|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sD0ucoiG0fTGcnwYVnqpyGruTg40LWa5WawxLR9i2JCa6DH26lu8pB60G3?=
 =?iso-8859-1?Q?0blXZl7E/wtbfjCjT85crCnIlcjQfpvCIU2B9agpj/pQRdDn7lYYzCX1v7?=
 =?iso-8859-1?Q?lCiqaPMpwV0uPB++/c8uJsam05P+QTXmkJFzERsQU74RtH1SRrPM/9LKUU?=
 =?iso-8859-1?Q?I3rIdKFjgBvVPxKIsEEJ4vX4Ya6AuMYYIrMc/i9Q5zFVCdtCOF7eVjypD0?=
 =?iso-8859-1?Q?49ZOdp8FOfX/eDKDvbtO0qi43q4PLEoMVf9kigOWkHH0Gy1YR2BCTOue0P?=
 =?iso-8859-1?Q?aBjIAuttTktBOk4VoWwgTQGeh+1Z0WYk7KwPrJZoD0H2qW4cPCOJbO3cge?=
 =?iso-8859-1?Q?t9HMRxj773SIOeelAZffpwbl1SfZxIjCVHSgu+XyZJVkjdbtECFrr5Vyze?=
 =?iso-8859-1?Q?+p0JJfc9MD2zf6kIw1rLnF1nIZLcFuX04TBOCtYtbOxwNBmASDCTk3b6+B?=
 =?iso-8859-1?Q?qP/3n4EnhkO75fqjTlj5hxGLOxRcO9EfN3DSO/eVMesPdITdKaE4i0jegN?=
 =?iso-8859-1?Q?yZpkVjC6cxStHH4vrpkK0zRuzuHbzU1bAwHJWD/dIWHU8Q9LjffYkhw5ek?=
 =?iso-8859-1?Q?svNTa2F5Pl/Yixm3T+c13Yhi7loPDi2fqebobcujEN4ctjUR+VXmrK5TJY?=
 =?iso-8859-1?Q?ey/e0rtrvAxqDi2KDGUmIaRrFBfgyatlL2z4NgwXcoO4LMAmJ7Tj0J8uC0?=
 =?iso-8859-1?Q?2RZVQRbnEfrwigd1h1HTTsGUQQAH4O183VsHHqFOYnN7v6atoSM9g4em57?=
 =?iso-8859-1?Q?4qQ4YzoSc6HdNxn3jGOzN7JYjPhqOiR9AAlh7QJRPSh9nDnxPy/gyAcx07?=
 =?iso-8859-1?Q?wHga/2qSdgAt2wZHZsLbQwq2ooWbtuGgALCv+wd6E9rPJN8myeveXaUbS3?=
 =?iso-8859-1?Q?IJ/cfTNocYxGQvgnfP9DNQbqJHAuE8UVTtfr0WQWojD4ZAIiY4I6RYrtVU?=
 =?iso-8859-1?Q?tV5bsOGirdlkaik6nreg8Wjm1efYHEwZQA+bmSEbcAxPidtpwNqqP4wjZQ?=
 =?iso-8859-1?Q?8Osf5Xrou8p4Ww/JZ/XqRNjhmF/yrHYSB8m+96+lSgZZlWsSspah8jY7C9?=
 =?iso-8859-1?Q?q+kDPi61uj885GQdnjvQnKKrm9bgfW3pcBhRn0m0u54S4w5n6zazsJEOZX?=
 =?iso-8859-1?Q?p+KQOaK2EEOiUR3oNJ81MxQMB+Kzq5RsfjF/n/bs13MKJqwGXh0QjJB94u?=
 =?iso-8859-1?Q?zjQU08VCYzqHebHkyNOrUk+l4EDf6TK9zNQk3mSV1xV77XnH76RJy4onCp?=
 =?iso-8859-1?Q?YLHI8uE29y/zzZmis67Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Yp/+Eqq5/niHZ81Lj+Vag+tryDx/haHgwFrbYa8SxNYcp40VnA9hSbQgFX?=
 =?iso-8859-1?Q?Vqp2doXj+SBOClhVXp7UEYnw4ScjsUHvc6l93avbN3tdN5an81lcR0ln+7?=
 =?iso-8859-1?Q?gslcAvZPC7nJugmfAnnk9+j75Ionv8In479fm8VmlBJ+7eyqIVkPdK0PgJ?=
 =?iso-8859-1?Q?23zMEfGygHdcSNenIvD4ZjDs8OJ5cG/FI677RkmiG3npiE8iEFjjMw9Jqf?=
 =?iso-8859-1?Q?TjKYYmExWtQzwjYWpFMqyP2mrekzSaO9ywJKdPz8a/FZai1wP40QVG9lCK?=
 =?iso-8859-1?Q?6OBeMDdfwMaokM5Mox45ZV/17qfAfGE+Xg1kXYqdezgJoWskgGqX470Kvg?=
 =?iso-8859-1?Q?esz8/1kRhZAvtn8BC2KK398e8aTQA49Qnbnr0rClAaf2bONgb6lDf8bGM7?=
 =?iso-8859-1?Q?6HYcOtyCIt3PaxIGf7HFs/b0PzfzomK4kzCxrQONY+Ke6q4HcXl16moZ5V?=
 =?iso-8859-1?Q?13xCort695/27jrl/tXWaNiNL/28H1tCZliJR2WY6bb0ExhGex6rpdHeH9?=
 =?iso-8859-1?Q?gXiRwsBSk4b2uZ4UXTYBfSfSLgCIs7MTeBi3SX6mC7BUVO/Oj8aSpMWsHQ?=
 =?iso-8859-1?Q?MTBwnzEzRR/edufURoo043TJ1mKi2zink8sG84OxadbHSEfeqp85TnB7dA?=
 =?iso-8859-1?Q?9oKfJGffIOtvk7fFoE5vMmgR5RO++wopgcBy3p8uId7AhbHG/DSw2RnTPe?=
 =?iso-8859-1?Q?plpKquPrO+P6V1iiv5vVrSxB588eEoK98o0BhkIuY9dLF9smM8YV/holxo?=
 =?iso-8859-1?Q?c4CWRD8+jQNdrT7KgT5iRfM1zMyTysW7AliT0BzEHOG+/oNeH0zr/RSLAP?=
 =?iso-8859-1?Q?oepNn9K4Cn+JaSQcfkxNiCfz3IDmF6FhgmQSyCeBZo84InqsbLQzEtsfnb?=
 =?iso-8859-1?Q?amLILWolhI6uagsxL5aYqwTvfX4gwr4I8QuMExNQkNu7YQd9bd2sZm6g+m?=
 =?iso-8859-1?Q?ShomYthKJ9kxBJ/mndzJq08hOrzqeOjpUVe5UsK6ZQ7+Xr083xHYa5B9wx?=
 =?iso-8859-1?Q?sdh2uXzZddTy8a1KGczFY85uEmUKCVLPmMJR4QT9AkpdMSmf0Tg0HoURlV?=
 =?iso-8859-1?Q?qnjyo/YDsFJ8sbDlXF+WI9xUIHxD6KkpFKUNW7CFJIcfP9GhULpaCXCRkh?=
 =?iso-8859-1?Q?bbflg1hriEl0q91NfH06eseft91lhpGtSwOqmrwso/zFP7xf1X4Ko8TYuQ?=
 =?iso-8859-1?Q?RECU6bSuOw1s51LbpkUkklGR4josr6L+xiNeP5ZacwD3LmI2TW21jPJqAY?=
 =?iso-8859-1?Q?BvV4ZhMZClvw8efayq/oka6H1dx0Xj0SDAzo0hY/sp2HSE1brm0mxzverK?=
 =?iso-8859-1?Q?I5khR3KCQQrne0X87D3h2ct4QjqgiUAVoAkw1fv8oWkZ96cZ7cgcQZHevl?=
 =?iso-8859-1?Q?i1pjkdqoPgbAdzOOEOGNSn0lh0bJXFYvDNds7Ehi96XvymvWKJ9PY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB9313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cf5e37-e0f4-40e5-fdcf-08df0e5d0c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 10:28:11.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8307

hidg_disable() frees hidg->get_req when a GET_REPORT is waiting for=0A=
userspace. A USB reset disables and re-enables the existing function=0A=
without calling hidg_bind(), so the request remains NULL. Every later=0A=
GET_REPORT then times out until the gadget is unbound and bound again.=0A=
=0A=
Keep the request allocated for the lifetime of the bound function and=0A=
free it from hidg_unbind(). Cancel and wake a pending operation during=0A=
disable, and use a request generation counter to stop work from an old=0A=
configuration from replying to a newer control request.=0A=
=0A=
A pending get_req leak fix also adds cleanup at unbind, but it leaves the=
=0A=
early free in hidg_disable() and therefore does not address this reset=0A=
failure.=0A=
=0A=
The failure was reproduced on usb-testing with dummy_hcd: the interrupted=
=0A=
request failed with ESHUTDOWN and subsequent requests timed out. It was=0A=
also reproduced with a Linux xHCI host issuing a USB reset to a=0A=
Raspberry Pi 4 using DWC2. The change passed eight reset timings under=0A=
KASAN and the same physical Linux-host test.=0A=
=0A=
Fixes: a139c98f760e ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCT=
L")=0A=
Link: https://lore.kernel.org/all/tencent_F5AB9201DDA25D8E1925CF818D87258B8=
D07@qq.com/=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Keisuke Tsukuda <tkdkei@outlook.jp>=0A=
---=0A=
 drivers/usb/gadget/function/f_hid.c | 26 +++++++++++++++++++++-----=0A=
 1 file changed, 21 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/funct=
ion/f_hid.c=0A=
index 3c6b43d06a..99d9666172 100644=0A=
--- a/drivers/usb/gadget/function/f_hid.c=0A=
+++ b/drivers/usb/gadget/function/f_hid.c=0A=
@@ -96,6 +96,9 @@ struct f_hidg {=0A=
 	struct usb_request		*get_req;=0A=
 	struct usb_hidg_report		get_report;=0A=
 	bool				get_report_returned;=0A=
+	/* Cancel pending work and distinguish requests across reconfiguration. *=
/=0A=
+	bool				get_report_cancelled;=0A=
+	unsigned int			get_report_req_tag;=0A=
 	int				get_report_req_report_id;=0A=
 	int				get_report_req_report_length;=0A=
 	spinlock_t			get_report_spinlock;=0A=
@@ -562,10 +565,16 @@ static void get_report_workqueue_handler(struct work_=
struct *work)=0A=
 	struct usb_request		*req;=0A=
 	struct report_entry *ptr;=0A=
 	unsigned long	flags;=0A=
+	unsigned int	req_tag;=0A=
 =0A=
 	int status =3D 0;=0A=
 =0A=
 	spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+	if (hidg->get_report_cancelled) {=0A=
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+		return;=0A=
+	}=0A=
+	req_tag =3D hidg->get_report_req_tag;=0A=
 	req =3D hidg->get_req;=0A=
 	if (!req) {=0A=
 		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
@@ -598,6 +607,11 @@ static void get_report_workqueue_handler(struct work_s=
truct *work)=0A=
 		status =3D wait_event_interruptible_timeout(hidg->get_queue, !GET_REPORT=
_COND,=0A=
 					msecs_to_jiffies(GET_REPORT_TIMEOUT_MS));=0A=
 		spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+		if (hidg->get_report_cancelled ||=0A=
+		    req_tag !=3D hidg->get_report_req_tag) {=0A=
+			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+			return;=0A=
+		}=0A=
 		req =3D hidg->get_req;=0A=
 		if (!req) {=0A=
 			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
@@ -864,6 +878,8 @@ static int hidg_setup(struct usb_function *f,=0A=
 		 * GET_REPORT the request was actually for.=0A=
 		 */=0A=
 		spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+		hidg->get_report_cancelled =3D false;=0A=
+		hidg->get_report_req_tag++;=0A=
 		hidg->get_report_req_report_id =3D value & 0xff;=0A=
 		hidg->get_report_req_report_length =3D length;=0A=
 		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
@@ -997,12 +1013,11 @@ static void hidg_disable(struct usb_function *f)=0A=
 	}=0A=
 =0A=
 	spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
-	if (!hidg->get_report_returned) {=0A=
-		usb_ep_free_request(f->config->cdev->gadget->ep0, hidg->get_req);=0A=
-		hidg->get_req =3D NULL;=0A=
-		hidg->get_report_returned =3D true;=0A=
-	}=0A=
+	hidg->get_report_cancelled =3D true;=0A=
+	hidg->get_report_req_tag++;=0A=
+	hidg->get_report_returned =3D true;=0A=
 	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+	wake_up(&hidg->get_queue);=0A=
 =0A=
 	spin_lock_irqsave(&hidg->read_spinlock, flags);=0A=
 	hidg->disabled =3D true;=0A=
@@ -1588,6 +1603,7 @@ static void hidg_unbind(struct usb_configuration *c, =
struct usb_function *f)=0A=
 =0A=
 	cdev_device_del(hidg->cdev, &hidg->dev);=0A=
 	destroy_workqueue(hidg->workqueue);=0A=
+	usb_ep_free_request(c->cdev->gadget->ep0, hidg->get_req);=0A=
 	usb_free_all_descriptors(f);=0A=
 }=0A=
 =0A=
-- =0A=
2.50.1 (Apple Git-155)=0A=
=0A=
