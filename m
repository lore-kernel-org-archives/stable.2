Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=23.103.209.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409243;
	b=KVUdR3UljLBn9c7aQQXgrKNLXdFJrzQRbFx2No2VFC91yfexJ8gtovoPSG+GqhYL5uB6
	 nF71ruFTwJxccnU4QlLk1wvGED51hY7cBUxdgNcUQLm3bQ3WsTSVqF7CZl5tJMh0J6J+8
	 7WU5iGuNJ/jYLQZejFbFpc18CddCghJN1LT83efwtplIeXXmWf5lUgQ+dA3vFKiBaLw2c
	 Ppazbn9F9B2pYBZh8BccFllwA1sm2K/zF83rZ7Qh/qo2j80qvEBTGxcQFHfHjnjGn2PSi
	 RzO8tf56RjXll0sH9GZ9Bvw9jTMcSaSNEGCZwqbIyxOhpXrZ00YZ82oq5PEjH94wGZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409243;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LK/25wV4jL9GF3B3AyhxXmF8oR3gd0bC/RAaNyjHw4M=;
	b=mYfPJPx7Ve1ridAI/cyDei1VHfKfO3bB/hbd0zveNs1AJARlU5xQAkbfNbxx6gWX/RJo
	 33GN2/pGYRyIcxvVuWgOQK78WoNbzGWJfeiG8501PcX/aSV1AxxJ8q2rtYFkBJDyx5vnD
	 6PSCZC7PDT3faC4nAQw0Uc80fMLcVr7OzIWuloags6FGqslniuPSctBxrbqNY+VCBqX+t
	 D1DkyVezr5HqsyhVbKKKOznilAGr6pJfzP09fcwVAWORbpiOucwtO5Tg8L3HHgUvcHWms
	 tRSBQbwS/tdRJ0ZkZ7kMF1tArGzObsILZ0tRdXcNKuZ9AKlldoylxgTFtvY52HDvUnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gotenna.com;
	spf=pass smtp.mailfrom=gotenna.com;
	dkim=pass header.d=gotenna.com header.i=@gotenna.com header.a=rsa-sha256 header.s=selector1 header.b=PX+XG0ib;
	arc=pass header.oldest-pass=0 smtp.remote-ip=23.103.209.52
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0052.outbound.protection.office365.us [23.103.209.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C3606AD3D;
	Wed, 11 Nov 2026 15:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 963C3606AD3D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gotenna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotenna.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gotenna.com header.i=@gotenna.com header.a=rsa-sha256 header.s=selector1 header.b=PX+XG0ib
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=QMczFliKGjAwqEL08frDmABUvSSbyIeFKRc6Htjnt6KPC0Uj8AC6eCugSAf2ke+d+LPSzQtQ1JBW10IACkveg0aBGXKTspfFCpGNDM8VCLGgpPY3vAwUr6SfCyCrIJuE4rKkaGM2wNn878CZZYALp3B8+jhqoYue+tulpaoowYivTTd6kXTCicFLjE1cPNISHvPrq3x1/jCLK/hifu8OT6pI4J2/uOhMh5RbWgLe88pR8v0GGxZP1MpRHhtv+mwvSYOuWxJBG+Rpuztfs4kd+rNGe7C/qr8A+jMBbVIN0WCu+9tE6xSfN+bHPWN2lbfabIoO1V+QTSYwWoF6asqgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK/25wV4jL9GF3B3AyhxXmF8oR3gd0bC/RAaNyjHw4M=;
 b=F05f66gfGLDCr256VSo8c9oo2uHKjKDkv9uNiaaLXNdcQHDGd2/oc/gzVxZzZfLp2ULEsj8zS/lc5QRjuaBHkBeg/OkgbW/QYpm//bJz/t8RJRs7qHYSqhxkfpIA9huP9BTBGMdNCpgqVhVvjD5GPT9NpwXGUe1ehFQ5anqZquhFFZup2oq864y5Wmbk2QZv8gcMQQE8y1Rh1Cfy5v35gfzoC1Vatz8YGVY1VB+ZyT3WyhA7vFOO9+qeZTpk9YJhEt4xSiVvm4tCsl1waqqR/EguF4c5uaADsAELOwEyc34J/tqbvr+nUov2+eyAGtI3SM7YgKWlI78l8yoe5b7jBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gotenna.com; dmarc=pass action=none header.from=gotenna.com;
 dkim=pass header.d=gotenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK/25wV4jL9GF3B3AyhxXmF8oR3gd0bC/RAaNyjHw4M=;
 b=PX+XG0ibpWpg2TnqGIb35PNkaxY8QSW4/afyOw46JZaoV75SMRd//zg+Oav/OrWyx6pzzE4dHwu5TEReOT+LbdK4NThelEdYYx2I1zKGpFsz6ovxpLoj1MimyweSbfVtNiiFksnbRkFTBEzwY4k5PYz0Ow68OTi6w24SmoxSPMQ+oK5DhL777pKKaoV70xN3V3ZFncJfZRgwjsOTX3HdLlrwfs0vKyTT8mfwvRUQACQTBGapljFQZejbRxsWcKl0mh2JEg+jaag9e7q/sY4F8F51uCYtC4r0JlE1u8vUC6JBal6byO+E3pT9BHHW7n1C7tofkAaTxg6Y8EUq/oCL4Q==
Received: from SA1P110MB0976.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::10)
 by PH3P110MB3195.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:636::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.16; Wed, 11 Nov
 2026 15:00:32 +0000
Received: from SA1P110MB0976.NAMP110.PROD.OUTLOOK.COM
 ([fe80::4e82:7de2:f390:82d8]) by SA1P110MB0976.NAMP110.PROD.OUTLOOK.COM
 ([fe80::4e82:7de2:f390:82d8%5]) with mapi id 15.21.0569.015; Wed, 11 Nov 2026
 15:00:32 +0000
From: "Brian Ellis (US)" <brianellis@gotenna.com>
To: Ingo Rohloff <ingo.rohloff@lauterbach.com>, Brian Ellis via B4 Relay
	<devnull+brianellis.gotenna.com@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: apply XCVRDLY after PHY init
Thread-Topic: [PATCH] usb: dwc3: apply XCVRDLY after PHY init
Thread-Index: AQHdce1MGYOjXi3pCUqGOs3qwmfKdA==
Date: Wed, 11 Nov 2026 15:00:31 +0000
Message-ID:
 <SA1P110MB0976D23BC3177C60C5599941C471A@SA1P110MB0976.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gotenna.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB0976:EE_|PH3P110MB3195:EE_
x-ms-office365-filtering-correlation-id: 855183e0-a120-433b-0985-08df40048846
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|10070799003|41320700013|1800799024|55112099003|18002099003|13003099007|38070700021|56012099006|3023799007|261102123227099003|261026135527099003|261022113327099003|4133799003|261009223027099003|261021121427099003|261021130227099003|261021123027099003|261022115727099003|261022105027099003|261026121527099003|261021133027099003|261022075727099003|261026140227099003|261026130827099003|261028144727099003|261021135927099003|10067099003|6133799003;
x-microsoft-antispam-message-info:
 G+vJiqx1EWxKeNqdDXJ0C4HgitPKKkjmMsVmQ4kfWtNsYZUKw6fNy1eRK46Lr+U5DFpnETJS/9zx1l8ebqcI/w7hRAelDY4vt+Fp/w6ZdwB9Fkf/HhOuMXlh50GTgVIbl+vgTzEQ7B2WG0RtF318AmmcSk7ViASCrfoYwWIwt9gjg1tZKr8BS5D+vGUOqrDU/Zm1xdLCkZLtRv26eEIVgshWxFbLu7/bKY3ebyhNjao+5FlDpN4WWc8+XdcS8f3GxZ/yMMupmAwpdLREZjIraAIEtGfyTllcKmw7ApvXjpT+wXuX07QDY84Uj6gtBDTY50/YzyJDEf5l9rUcSTx3GsN0YFkk4GZNBAEepwYSjvmDA0qC1J3/csW2RlO4WhJV5DuiMUB77C3TwIJ4CalAmPmkqcwT4u/+Xa1uRK1g0uXrma9Ce4v2P0eMqp9DDKbRvKrlP/r2O+sOhtlT/vJLTccS1LGuUSj6HCdqgwpxcsTYvtk1LTc/Eb7Uvsn6mgMzVsJ5bMWhUGzEAP0P9XHDESsOj6aotcVEhQ2vi5swR1Jc04Tt6YVpkBvyWtXU009LA9XX3cbemLhAiqK+FqFUnogGHyc1paYsSF9C1oGXVTBH131sVjamHblad6gzl5u9ftvVoqj1ztPL7H9SJuPrgRV5BnqQFkFmsWvLHznZBKE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB0976.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(41320700013)(1800799024)(55112099003)(18002099003)(13003099007)(38070700021)(56012099006)(3023799007)(261102123227099003)(261026135527099003)(261022113327099003)(4133799003)(261009223027099003)(261021121427099003)(261021130227099003)(261021123027099003)(261022115727099003)(261022105027099003)(261026121527099003)(261021133027099003)(261022075727099003)(261026140227099003)(261026130827099003)(261028144727099003)(261021135927099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Yro1/eKA5MrLu9SFdLI5yTXex1hJdsIgzFfFCSdlP1RE0ujbKEnx2HGXtX?=
 =?iso-8859-1?Q?kZiE625aZhk+ioRFJzUPDuuiP1iUynhH1MZwFnNtw48ovkAKZdrftyi17R?=
 =?iso-8859-1?Q?btdpr8E4wsVjGH/x+SNVUqV1upH1Coh5UlaNbfk5sh+0HMphcX6FAYrcXN?=
 =?iso-8859-1?Q?sP8LKv78cY1Njmr1stcaRaeLKs6GuChc5IAxBkhkoAFZuvEmrOT7BPwayZ?=
 =?iso-8859-1?Q?XNZWmhE4WIke8M/bQ2ZJnmbcIn+y5ICLYp9sjMrdTcFULLXPIS3BZmS/Bg?=
 =?iso-8859-1?Q?QswzxOd+CcyRupqrtbZC7qcmw9vrfLu2Oec+jOmc/sehz4mwqDKHlsB2a6?=
 =?iso-8859-1?Q?t48t704MtFueZtvyGfJ6lwFQMggaZJk/njxr+GtoAe0u/m9GBqmgpZYi6y?=
 =?iso-8859-1?Q?HhgVZ9WXeMHlubylKvCwLPE65OSP+pFJ3no5DMjJ03uUkIU57UQqO4ZvHp?=
 =?iso-8859-1?Q?MLCIrgq1BPh0Ny4Tk+hQ4RK/ii6O/vsjpzgIhTn6iQ4bVxrNW/9dV9p13G?=
 =?iso-8859-1?Q?DppAoSrziTm61RdOKPyz3Xv5CKME0/PI8MkxRDU5oA0gfwcaK0Xgel3Pat?=
 =?iso-8859-1?Q?gLaPBTJ0cauLv1ec1IMsowu7418V88n7e+Od4Gov0Z5uX4ASn4lOIxd4tG?=
 =?iso-8859-1?Q?tbxyCo6DfN6u/AO7BBSgMaTB/qDsSoG3DQKExS1TQAlnpk6kzqjSPxW5Fo?=
 =?iso-8859-1?Q?iLY0tgWrrplZz3rOxF6/GP/ouC0IidHf2313/NS8OAPpSsh+XLraaxviFH?=
 =?iso-8859-1?Q?aY7mgYWJPXhOzEdq5ynsBHKu7ksOgY6q+xDGDZHuTwE74Mzk7tR7XnsVgH?=
 =?iso-8859-1?Q?Ba99GQmEn8ywfwhGpHkI/TsHsiPNNbBTBp2JCiQnpO5P84NTKTAq+SpN4+?=
 =?iso-8859-1?Q?RgH6dDsD0NXjTXbuTeJGUOVr0a4z4Nh+NjrPW+cNfZQvtpRyYOIPty7Z1M?=
 =?iso-8859-1?Q?w/S+49Ll+GhO73YdSnv4048sGd6sTpqh+Uuo+jwLd+fV5qQ3B8lHQxGmvt?=
 =?iso-8859-1?Q?JmvHATJtvKdjAelhdSsUUPyQcIi+5NXl9wcan9a2PkuPUX1rXxHrA7AY2R?=
 =?iso-8859-1?Q?8m2D79HxO9sVRj43TL1ljttajojUCQRyiZNH72TN2KyAje5DAxZqodI0eK?=
 =?iso-8859-1?Q?YOZwa7LRB1ruyv6OJLmsNCCm9YDtQMVJtnurRf/Tqnk55BsA+81i9sAChg?=
 =?iso-8859-1?Q?memDC4yBiWRzIzZt6TCXsh1XxQqeabyMO+bNFdFryHqB+fj408BG+KzU9m?=
 =?iso-8859-1?Q?fr+p3Z8mVlWvDD+D8a79uJzbWfTjtxJc36jN6ai4ujRDeR0olPFJ23AIhP?=
 =?iso-8859-1?Q?GF8EGFxjSUJYnaSs03UvC7xfw6D13kijXW0VBusL0DQr/KKwNWPXvb3Wx2?=
 =?iso-8859-1?Q?ydFUz+SxGx0R/HmphbzVrKGCiT9V60ovMue/V0S0tCwZ5Hv2uZayCOVZS/?=
 =?iso-8859-1?Q?uDrm41dih6vWehY0m8JSHQHevKcb76M48LG69VUQ+4QqBmxjjO2tcbrYQC?=
 =?iso-8859-1?Q?nKrAQKNSBHwyUm8OvnXEk5f/Ms+jBHUMty8+iMCFSZEbaK/yM8mYWULH3a?=
 =?iso-8859-1?Q?QClW6+es6zuqNFDSOM7fmyCItrQ8BgYVPdJao3QWnbQ/Pb/ieKrgY1bFMF?=
 =?iso-8859-1?Q?tSnsPvdHUlBR3r65pnyZc6zinndmFHu7RUqRBgFbxOMxtjjAG9DLCxCVLB?=
 =?iso-8859-1?Q?1SCg6MU3LRQO5QpduW2d6ETtcKLBnDGCio/C9Quk/LYQUchMyuCkCdX+d2?=
 =?iso-8859-1?Q?YsQBzmfy9ErKTEvLQ5o0gncjA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: gotenna.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB0976.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 855183e0-a120-433b-0985-08df40048846
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 15:00:31.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9997302-4e5a-473e-a9f5-f3ed9cd16249
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3P110MB3195

[ resending as plain text ]

Greg, please don't apply this patch; I withdraw it.

On Tue, 10 Nov 2026 14:28:06 +0100, Ingo Rohloff wrote:
I have a hypothesis what the problem is:
USB 2.0 LPM (Low Power Management).
Hello Ingo,

You were right, thank you. We tested XCVRDLY written early (where
a28de6335657 writes it) and late (this patch), with the host using
USB 2.0 LPM on the link or not. With LPM in use, the link died at
the first traffic every time, whichever way XCVRDLY was written. With
LPM off, it stayed up for the full 300 s every time, again either way.
We switched LPM off from the host side rather than running your
composite patch.

So it is LPM, and where XCVRDLY is written makes no difference.

Where did the 60 re-enumeration cycles came from?
If the link "stays up", then why do you get a re-enumeration?
They were deliberate: a soak that disconnected and reconnected the
gadget through soft_connect, to check enumeration itself. They were
not link losses. But that build already had LPM disabled in our
device tree, and the 1000 s run went through a hub, where the host
doesn't use LPM. That is why both looked like evidence for the
Reordering.

On the circuit: our board powers the USB3340's VBAT from the
connector's VBUS, so with no cable attached the PHY gives no ULPI
clock. That was a bad design choice, and the next board spin fixes
it. So the DT property I mentioned isn't needed upstream either.

An LLM assistant (Claude) helped run these tests and draft this reply.

Thanks,
Brian Ellis
Senior Firmware Engineer
goTenna
________________________________________
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Sent: Tuesday, November 10, 2026 6:32 AM
To: Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org>
Cc: Brian Ellis (US) <brianellis@gotenna.com>; Thinh Nguyen <Thinh.Nguyen@s=
ynopsys.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-usb@vg=
er.kernel.org <linux-usb@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org=
>
Subject: Re: [PATCH] usb: dwc3: apply XCVRDLY after PHY init

[You don't often get email from ingo.rohloff@lauterbach.com. Learn why this=
 is important at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


Hello Brian,

> This very likely depends on how exactly you use the USB344x.
> On my board I am using a USB3346 with the circuit described in
>
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDoc=
uments/DataSheets/00001880A.pdf
>
> Figure 8-1 USB333X DEVICE APPLICATION DIAGRAM
> (CONFIGURED FOR ULPI CLOCK OUTPUT MODE)
>
> What kind of circuit does your board use?

I am sorry that was the wrong PDF :-(

https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocum=
ents/DataSheets/USB334x-Data-Sheet-DS00002646A.pdf

FIGURE 8-1: USB3341, USB3346, AND USB3347 APPLICATION DIAGRAM
(DEVICE CONFIGURED FOR ULPI CLOCK OUTPUT MODE)

with best regards
  Ingo

On Tue, 10 Nov 2026 14:28:06 +0100
Ingo Rohloff <ingo.rohloff@lauterbach.com> wrote:

> Hello Brian,
>
> > Each link enumerates at 480 Mbps and passes traffic,
> > then drops 2.20-2.23 s after enumeration, and the host's
> > attempts to re-enumerate the device fail.
>
> I have a hypothesis what the problem is:
> USB 2.0 LPM (Low Power Management).
> Please try the attached patch.
> If this helps: That's the origin why you loose the link.
>
> It seems USB344x + DWC3 don't support USB 2.0 LPM in this combination.
>
> Note: This problem only appears when your HOST USB Controller also
> supports USB 2.0 LPM.
> Meaning: Depending on your exact Host PC you might not see this effect.
> Only recent PCs support USB 2.0 LPM; on my PC here only some specific
> USB ports support USB 2.0 LPM. So on my PC it depends to which USB port
> you connect the device to.
>
>
> > Ingo, if your USB3340 board is still to hand, it would help to know
> > whether its high-speed links stay up for more than a few seconds, with
> > and without this change.
>
> Yes this board is very much on hand ;-)
> The high-speed link there stays up indefinitely.
>
> > Not addressed here: on our board the ULPI ID read that a28de6335657 use=
s
> > to detect the USB3340 fails when no cable is attached at boot, because
> > this PHY only clocks ULPI with VBUS present, so the bit is never set an=
d
> > the port runs at full speed.
>
> At least for my board this is not the case.
>
> I get a completely stable 60Mhz ULPI clock regardless of if
> VBUS is present or not.
>
> Which of course in turn means the ULPI ID can be read out without
> any problems.
>
> This very likely depends on how exactly you use the USB344x.
> On my board I am using a USB3346 with the circuit described in
>
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDoc=
uments/DataSheets/00001880A.pdf
>
> Figure 8-1 USB333X DEVICE APPLICATION DIAGRAM
> (CONFIGURED FOR ULPI CLOCK OUTPUT MODE)
>
> What kind of circuit does your board use?
>
> > Fixing that needs a DT property and a binding update, so it is not part=
 of this fix.
>
> That was my original patch proposal: Use a DT property.
> I got push-back on that idea.
> The auto-detection via using the ULPI ID is a lot nicer.
> Of course this doesn't work if you don't have a stable ULPI CLK signal.
>
> > What matters is when the bit is written, not its value.  Written at the
> > end of dwc3_core_init() instead, GUSB2PHYCFG holds the same value
> > (0x00022710 on this board), and high-speed links on the same board stay
> > up: one ran continuously for over 1000 s with no receive errors, and 60
> > re-enumeration cycles completed without a failure.
>
> Where did the 60 re-enumeration cycles came from?
> If the link "stays up", then why do you get a re-enumeration?
>
> It might have something to do with what happens with the
> ULPI PHY when USB 2.0 LPM gets active.
> When the host looses the link (which should not happen in the first place=
)
> because of USB 2.0 LPM, then it re-enumerates.
> Depending on where you put the "dwc3_ulpi_setup(dwc);"
> this re-enumeration after link loss (because of USB 2.0 LPM)
> might then work.
>
> But again the link should not be lost in the first place.
>
> with best regards
>   Ingo
>
>
>
>
>
> On Mon, 09 Nov 2026 10:22:31 -0700
> Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org> wrot=
e:
>
> > From: Brian Ellis <brianellis@gotenna.com>
> >
> > Commit a28de6335657 ("usb: dwc3: Support USB3340x ULPI PHY high-speed
> > negotiation.") sets GUSB2PHYCFG.XCVRDLY in dwc3_ulpi_setup(), which
> > dwc3_core_init() calls straight after ULPI init.  That is before
> > dwc3_core_get_phy(), dwc3_phy_init(), dwc3_core_soft_reset() and
> > dwc3_phy_power_on(), so the bit is already asserted while the PHY is
> > brought up.
> >
> > On a ZynqMP board (DWC3 2.90a, peripheral mode) with a USB3340, that
> > ordering breaks high-speed links.  Each link enumerates at 480 Mbps and
> > passes traffic, then drops 2.20-2.23 s after enumeration, and the host'=
s
> > attempts to re-enumerate the device fail.  We measured 12 such links on
> > two host root ports; every one died in that window.
> >
> > What matters is when the bit is written, not its value.  Written at the
> > end of dwc3_core_init() instead, GUSB2PHYCFG holds the same value
> > (0x00022710 on this board), and high-speed links on the same board stay
> > up: one ran continuously for over 1000 s with no receive errors, and 60
> > re-enumeration cycles completed without a failure.
> >
> > Move the dwc3_ulpi_setup() call to the end of dwc3_core_init().  The bi=
t
> > is still set well before any high-speed chirp, which only happens when =
a
> > host enumerates the device.
> >
> > Fixes: a28de6335657 ("usb: dwc3: Support USB3340x ULPI PHY high-speed n=
egotiation.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Brian Ellis <brianellis@gotenna.com>
> > ---
> > How this was tested: not on mainline.  The failure and the fix were bot=
h
> > measured on our board running AMD's 6.6-based vendor kernel (through
> > ADI's tree), with a28de6335657 backported.  The backport calls
> > dwc3_ulpi_setup() from the same place and differs only in handling a
> > single USB2 port.  The 12 failing links were attached directly to two
> > host root ports.  The 1000 s run was through a hub, on a kernel carryin=
g
> > this change plus five other local dwc3, ULPI and extcon patches.  The 6=
0
> > re-enumeration cycles were direct to two root ports, on a later build
> > with more of our local USB fixes.  On mainline the change is
> > compile-tested only (x86_64 allmodconfig, W=3D1, no new warnings).
> >
> > Not established: why the ordering matters.  The outcome follows whether
> > XCVRDLY is asserted before dwc3_phy_init(), not the value written, but
> > we have not identified which step of PHY bring-up is sensitive to it.
> >
> > Ingo, if your USB3340 board is still to hand, it would help to know
> > whether its high-speed links stay up for more than a few seconds, with
> > and without this change.
> >
> > Not addressed here: on our board the ULPI ID read that a28de6335657 use=
s
> > to detect the USB3340 fails when no cable is attached at boot, because
> > this PHY only clocks ULPI with VBUS present, so the bit is never set an=
d
> > the port runs at full speed.  Fixing that needs a DT property and a
> > binding update, so it is not part of this fix.
> >
> > Tool use: an LLM coding assistant (Claude) helped run the investigation
> > and keep its record, wrote the code change, and drafted this changelog
> > and these notes from that record.  The measurements were taken on our
> > hardware.
> > ---
> >  drivers/usb/dwc3/core.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index fd5c2cd36c..9b37ceda9a 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1371,8 +1371,6 @@ int dwc3_core_init(struct dwc3 *dwc)
> >             dwc->ulpi_ready =3D true;
> >     }
> >
> > -   dwc3_ulpi_setup(dwc);
> > -
> >     if (!dwc->phys_ready) {
> >             ret =3D dwc3_core_get_phy(dwc);
> >             if (ret)
> > @@ -1534,6 +1532,9 @@ int dwc3_core_init(struct dwc3 *dwc)
> >             dwc3_writel(dwc, DWC3_GUCTL3, reg);
> >     }
> >
> > +   /* XCVRDLY must not be asserted across PHY init, so set it last. */
> > +   dwc3_ulpi_setup(dwc);
> > +
> >     return 0;
> >
> >  err_power_off_phy:
> >
> > ---
> > base-commit: 3149e8b3237f58d4dd440fc64c45c93404c4b064
> > change-id: 20261109-dwc3-xcvrdly-after-phy-init-509803f4b0c8
> >
> > Best regards,
>
>
>



--

-------------------------------------------------------------------------
Dipl.-Inform.
Ingo ROHLOFF
Senior Staff Engineer
phone +49 8102 9876-142 - ingo.rohloff@lauterbach.com

Lauterbach Engineering GmbH & Co. KG
Altlaufstrasse 40, 85635 Hoehenkirchen-Siegertsbrunn, GERMANY
http://www.lauterbach.com/

Registered Office: Hoehenkirchen-Siegertsbrunn, Germany,
Local Court: Munich, HRA 87406, VAT ID: DE246770537,
Managing Directors: Stephan Lauterbach, Dr. Thomas Ullmann

-------------------------------------------------------------------------
________________________________
The information contained in this e-mail and any attachments from Forterra =
may contain confidential and/or proprietary information, and is intended on=
ly for the named recipient to whom it was originally addressed. If you are =
not the intended recipient, any disclosure, distribution, or copying of thi=
s e-mail or its attachments is strictly prohibited. If you have received th=
is e-mail in error, please notify the sender immediately by return e-mail a=
nd permanently delete the e-mail and any attachments.
