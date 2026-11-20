Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.162
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160964;
	b=lrPqHQcq4iospGf3JH1vE51wUmaM1kgdGG7qPpNLRksyUZeFJRNP5/wVQSxjwWwgCgrG
	 8vX4kSi7/ysG+iZpHviXF+BacX13sOWhk3AEh4X95XEyhVAF/bm2YbCdLgfheB6R468np
	 TXjcRzjZ4NJwSdGFlmr2I5YI6K0W6MhRH2bZgA3g5rL4iFopzh2mqKy8RJ8uEiA6WIZuF
	 +IlzU2h5dNz+ehhiwx3eTCdMfoKzeucgaDw8jz92BmQoyRF+aF5n0ReK/5lNLqdyBGBhq
	 sSC/91vqEuCBK4q3cxn/LagNqFGvNq2+bf3xzAx5vn+hulm77nMl3ADagTFTtyY4NYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160964;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-TM-AS-ERS:
	 X-TMASE-Version:X-TMASE-Result:X-TMASE-MatchedRID:X-TMASE-XGENCLOUD:
	 X-TM-Addin-Auth:X-TM-Addin-ProductCode:X-TM-Deliver-Signature;
	bh=5NX58GU8U/8qBOdcYqojXMo+/2rUCkX4cq+WViRbA80=;
	b=pZWPGhPLXfyul9HCK6uefC0Sn253eaNLDnEP3csDgDbWF79MwRvFJgTynQ6dhXcHlbmR
	 d6P1v/QcKMXIM4Tqpa2nizlkl++3Liox5Am7QtJi2rThMPl3SqiiIiwSh/+JxNvwayOGs
	 QUary/JvhLc5TSZCZStdHH+H/LEAcjEEC58KMc25vS6kRzstqfEoDysgu3VS0UvShtnQn
	 scRqe5fOUP0fWNCw7m2PCE7oHR2ykT1DAcwP5VYoIj8uRGq0TBvBS2JhTIidpi+w1p6V3
	 AN9QS32haoiFWbsfXFmT3K9TxHNMj7RsLxmrLjbcHAoHZRr7IEtNt/FqDgD9inghXZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=electrifex.com;
	spf=pass smtp.mailfrom=electrifex.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.162
Received: from repost.tmes-in.trendmicro.com (repost.tmes-in.trendmicro.com [3.110.59.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B8606A320;
	Fri, 20 Nov 2026 07:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electrifex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrifex.com
Received: from 52.101.225.81_.trendmicro.com (unknown [172.26.46.176])
	by repost.tmes-in.trendmicro.com (Postfix) with SMTP id B69FBC00090C;
	Fri, 20 Nov 2026 07:49:14 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1795160947.481000
X-TM-MAIL-UUID: 11250f29-ad4a-4d96-8338-a155359403dd
Received: from PNYPR01CU001.outbound.protection.outlook.com (unknown [52.101.225.81])
	by repre.tmes-in.trendmicro.com (Trend Micro Email Security) with ESMTPS id 759EEC00042A;
	Fri, 20 Nov 2026 07:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBZoGSVdEZ1W47T8kGoC/5Wj9Ew95ySfRHA/lMxRcmCHMlBenzgrTBJZo9/1Uq1kR58mzjt+y7va0pve/ou6RPiaPDGCLdPOErCBNTSjHjJAXqaHIJ6Em/1Ab4Sdz1hnvoM4NnP9JyJ5F8lwzT3puqTxgSepZlx7I7+Lct/CePpO+wOiRxix8BbD4zZrcGKASodmQqggRulsbO7VUG5JHyxfhn4JFQg0FrsSACAc8apJ9yRQrdUHCGqBMQnhBgfaxxazSohEIe7UjEIZ9qCf02iRJYvda57JJinRGwq3Z74v6tHb0Ga4VAVZpUewtgsY2H7uDtxOuLLI1neH73Sv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NX58GU8U/8qBOdcYqojXMo+/2rUCkX4cq+WViRbA80=;
 b=rXRQPUaReUbt2w5qtcW/Uma+jOXZrjx5n6sc3PYbTmEA9mo5sB8zEkm2kjD91nrG9Uf0xhv8lteuqwJKL/QYYUzqhFHjEg8ZGTHqlzVQSn/AEYc67DVvQeRO2BtvzlPG6iaY9mwZqXFblUVYjdxgO71sGT1mPQJE170xDcOGmSDtm7DDVVY2zuFy5svMhHYEJSOadOX3ZKA7E5QuT0QHNQ7iBPL7OmpksvzgN1SSvgWjYqjL8r5OVuwWOIri6EiayZoKGUcctgdjV9TkaGO3amEHuc8ff+xsokAR18y4CMr8DtuNGZXfMGbOCD/m7fbImWrdItSd62CbHdbFbbLSxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=electrifex.com; dmarc=pass action=none
 header.from=electrifex.com; dkim=pass header.d=electrifex.com; arc=none
Received: from MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:cc::6)
 by MA0PR01MB8884.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:49:05 +0000
Received: from MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c284:c893:95b6:d2a3]) by MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c284:c893:95b6:d2a3%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:49:05 +0000
From: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
To: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Sam Edwards <cfsworks@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, David Wu
	<david.wu@rock-chips.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: [PATCH net] net: stmmac: retry a failed RX refill from a timer
Thread-Topic: [PATCH net] net: stmmac: retry a failed RX refill from a timer
Thread-Index: AQHdeMHkOZtbzcYqfk6xISx5T/okIA==
Date: Fri, 20 Nov 2026 07:49:05 +0000
Message-ID:
 <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=electrifex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB9217:EE_|MA0PR01MB8884:EE_
x-ms-office365-filtering-correlation-id: eae309ca-680f-4100-b5eb-08df46dac044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021135927099003|261021123027099003|261021121427099003|261102123227099003|38070700021|5023799004|56012099006|10067099003|18002099003|261009223027099003|6133799003;
x-microsoft-antispam-message-info:
 wjBBjnYlfLM/fQGWZhl/C1o+F7XIipZswOv5l9O2VimAlMfrG9zJ8Wix/znvlfpKaK9NKc3n6X516ziuflRG3Ptq9vDx/sxfgDWo+ByQtlEQLfPServdeWCMqXyl0h6eZ8IH/JKT+MJ66jzzk92uqQjgeFKPKQQaq2h6L6BsKU8oHsKsPYsxvbalHKBkKwNu3YW4aX9zWAU+ttZdKHnEtwZKHDMStCAxPSHQ2a07rteBpHqfGgz5UEl+jBcQ5LIlLc90JJ/1fkfdcYqRjuwtOg/YXrMS9NvDexiPfkMsTFgLdOuUmQiqXwg5csPHqCBjsJuzhiWZs1ln2+UzETxCIPV6d4G3gOVyaRsqQjC3M8xnVHUbufmKYSj4Ob9CTxC7oKfsRfo2XRAJQsodxzlEAKSEsPEjhm4wyQTIKXrl3BTwxlx2mtgOMPiCyz5t7QV3vtyUqy2PBW5UMMaYpNMkeNzX2RY0y3hTd0kQ0SJ4Cexod6rWXLZvOqTuOSSq2JLPqKf9+bfAPNdPaeqbi/3SypTBlgjp2wrGIMG0/V3jX3DREJoQRtJBPnUo1N+c3aFUiRhvHUSXxF+wQI4PpYiao58iJxYOMDVBXccGTbomoVTkbDAE9jnC/62V5W5idvb3sT4TNoAWM8QDdsx94UM5v6WF7msOHLwRgJU7bqsTbKY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261102123227099003)(38070700021)(5023799004)(56012099006)(10067099003)(18002099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mCO6hWKGcf/t0gtfg7nmKjHvNZTLUlxfxxIw8ZBXykhkGOhID8uhCMd8zX?=
 =?iso-8859-1?Q?GaxYo3/Pwo4zifiwhu0Uz8Pm2jI9JMg6e3si1hvulDeRMr4+E6ralJoMJX?=
 =?iso-8859-1?Q?c/YyTzrwEwJYB6705JOAqUT/CPlkKpjRo+lyE2E3PVVxJQmbaDAbK7ar+v?=
 =?iso-8859-1?Q?uvRYH3asyJ3moSGl79eBwHyI0CQPDc2PIzYMO188/PiGSjFmY6hfvtiGMj?=
 =?iso-8859-1?Q?s7N6IkNRuNgYInyZNdKf+nbATl9+XYdA/FX9mvscEIBPrM57SxY6uABFzQ?=
 =?iso-8859-1?Q?4ke5HxTXvOZKTSQPCDJYTJKHdLncffyuuHNlgELEz3Rij7edb1enwoklzM?=
 =?iso-8859-1?Q?y/rgx9Q+jAOjRMuCWppcXLTTreeSUl+b++pPZ2wcc68Xjr7ARZ3deEEr2d?=
 =?iso-8859-1?Q?m/0iozv+36fEAgHtt3nxTHMonGIRPez40FKiKJY4BDhaWO40zNqlZrQI/k?=
 =?iso-8859-1?Q?bMFIyo4haBZU262FXhVLr0P7iEjacVhGI/VgAwen8iIS2pS0ZoSMX9MNT9?=
 =?iso-8859-1?Q?8KAAOBOm41e2OBPRAixwvkdye8K/A0WNzpfzd+BZxt/uAlGzQRm/9r6dRl?=
 =?iso-8859-1?Q?qTwNaR45I5r1BQaRRb2cwfdAVfCory5CwCaAzdmkFLslHC3LXRD/eLxaD+?=
 =?iso-8859-1?Q?98Zj3gQsWMxjubb6uaWdOih9L1Sgiqri+H9amzRPMb1NDX0GD+Ap+eibV1?=
 =?iso-8859-1?Q?bYBWKNpk48X+D2oCph084TCP+54rWnjp0Ef3SY4I5kY3L1KkO5tJde9Ke3?=
 =?iso-8859-1?Q?s1fx3pQX8jHwk4DUgPZkxY0h4Vnx91e67fbVVIEKtTzHf2FYsP5xEVYgpL?=
 =?iso-8859-1?Q?7K0CWOIFQHxSyHf/KzjVACurCvLBDU/q3GKvHzUfxWniY5XfMI9yaEKon5?=
 =?iso-8859-1?Q?T4l+EDphPVDmUP5PnO0gB+pg1lO+mfrkyy6RnuPmpu8p3YM+24f9nd3qMN?=
 =?iso-8859-1?Q?tB9LcA43Mt1IeYXUet9NMTMMaO+8P32kQzFXNQrbgN1HhH7h5J/HlcApjm?=
 =?iso-8859-1?Q?GgXE621lYnngNXxuJLKQ7lVnC3y29Lg18SMoGBEnEnJ95BzFfVxejPaf9B?=
 =?iso-8859-1?Q?a6kXxBrQyw7uf8BMS7bFLBnSeqVF3SJi4eIDgJk4rkKD4VNc435ihVULfE?=
 =?iso-8859-1?Q?uyATCazAd+mN2gu0diVD/po9Jcgdp14/aDFW4sAeO+VhC7oCvMTblBIqt8?=
 =?iso-8859-1?Q?zF+diCD9+Sz3aJsJXXgq6zjba8uiK7vswUYvtkJr4sRgV/4W/RArdugeNX?=
 =?iso-8859-1?Q?oHeyCLDbydYCDno3up0kDjYwtx+QVzV68JJVH7pL68VV1ka44BTXGJNuOe?=
 =?iso-8859-1?Q?6E7CJbEabmbB2xntMIfWmRGtrsPuKH1uzueYf2Gtpco3sY9qiVqVo3gGLG?=
 =?iso-8859-1?Q?lZNikXcKENLUvC4g3qGekWqyVw83tdstTF/f8gOawFRVD0AbAd49Do/nJX?=
 =?iso-8859-1?Q?yd2zFmQwqb5/QyAamF9sBxTqaRwt7QOCPk4/hZgL9kVLXcf/OdFurXzD5M?=
 =?iso-8859-1?Q?4+Kd0XW6/z4+E3f0mGMfxAipvXyRhcjXQesFZLpVjg2Ur2a4OFyZeTnPva?=
 =?iso-8859-1?Q?YEQ3u4G2oucOeFyIyCwsXqatFdUOg3g+4lmiJYdurDUA06/wTnI23LHslO?=
 =?iso-8859-1?Q?uPXy6WAujJ0BLjgA2b4JUVy7DjDq2g7mX/0PSrtPiqo/1yRnFysziqy6KV?=
 =?iso-8859-1?Q?cuCvlUnCdEO/JpXjW0NTPf6f1/e/fD6PftOc8NPrnK4GJPV2K+FSeczgSU?=
 =?iso-8859-1?Q?FUQL4vy7Ye6RiCaR91DjqABlc+i+4cIfm38aCoNZTGCWJE1DBoNY2ZTQd4?=
 =?iso-8859-1?Q?NJg8z6xtar5YXekz4rr4JJ5C813UorA=3D?=
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
X-Exchange-RoutingPolicyChecked:
	o8UbUcfVab5p69Hguv3p9OfqEbVp0yqLpZHUqMkEMS2HB+DgOrhI/a7g4XpgakQeasHVSRKNFfRDEFc8L9IUHf9nRcVTCmKdgaOuYTWdpYacYaEFm7tzPitQo2BZGFLiy36+6A2aSCHEt72EfxYdfCyvYcqXd0EVk6/TGCNhro5JxV2Q/GMk5R6xZNE+pjIuriRBaS+OX9P7r9bNjzX1/ofNUDX6nFlT/r57BO07YT/D7ZYAEPc4ryHObtYtSnZlJE3UmettdPZhI67XHpmV89iJCQB9/Of/0hXXcHePPZ34rw8pkz4LX260AHjV1P/Iz/7zZzEfOih9dLmeYJeCUg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ISg3vuwdKZN+S4/djHETktUVW4Xyzd2m85K8jlvK0qYA8Msa+u6IyDAqLsmwyb9/mX5KHvH2KUTjZasf8VEbrPYvo32UJdD2PWjeE/BB5AKQUpcZIZ1byDLPTuK/ClEYn2b4sxQT2MPvRjW4awDXZMSmVU5U6d8wUIdhKeaiYIQ3koBKBjf2+xfv+AC9kf1NuMYrKSky86cASAqQOoutjVYfGKSBJTGn0aNlTB3sGHawAsZ/T8rrYrkKw9rQldsMurfA+UyOT6lyeNkBnnb0NEG62g51UCX9t1drAUt6igQ9GL9UOOK3W7HZFIbxp0poGbX/ZuFfQJ2FeawuUBiBldyvuOEDo3Yk6lAUVO+crvnGBDaAprG4GmwPGS1RXUvqDoTtBsNu1X9U90UkDhn/dVriSNnzEwqhx04OfCWf/2TCzZs1DNvNLbrrlLYHHPcUqfxGbExUhUlNJAS0NC+fMtv4h41IHjbaShon962EXiH2n0WmuTVLnUw/OPD3VL8+STE6tJIT/RlT+mOXV/RvTp8FP+35vu2v3Ffd3sFkR6nQiTyiMt+He4KTZBgOiEWyL2Z5tsoS76rf9B922iaqrQCrBsQy0R8lROxsmBWRXzE=
X-OriginatorOrg: electrifex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eae309ca-680f-4100-b5eb-08df46dac044
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 07:49:05.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f2626450-e675-4872-bae6-db17376f7643
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHdub65C0IiQJIkPTdvN42TgHm4rXMEX3salv7Xa27jWqveAzdNM4HK8AAcJj8sIqyHs16z6FdCYdlfQN3NkJBBoAtKJUAbybm96U8NthpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8884
X-TM-AS-ERS: 52.101.225.81-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30330.005
X-TMASE-Result: 10--10.253100-7.000000
X-TMASE-MatchedRID: CkleXbrz2X+cSGy4JgO+Ta39Nxr6In/3OteHVGUMZ+CAPedCSeScsjas
	lHciyNgLP+a17NVAlr/hlAobdbKjfSQQMtD1IXx1O3Y9BE9+f5Fi/Vat3E2go1SAWjKAu3w74Dg
	iKWJARSSFuFRWapqaEtyvdUTaWVvuEWPbvrK/8x30k0bHb1p9aJWWzHC8Hr3VSIJ+KGcvdiEtqc
	fpF+q8J4SLNcKFd2mM4JDrAVfOvSFlSs4tb2YgDaa5LaHlPm0+zSk7os0c3Z5JS2w6PnRBWp6Qo
	0q91sC6aEzKgkX63fcPDGaazJL7k27H03xIBmfcHE2izCIy+zsgXWpfO4k/zjt1GYMJSu9OvEhC
	KXi+kJxCk/r+8E64k9pBtr9Rh55gx5inPPrI0FRSU7TOghylTufShpTpYz775aLISmJsQyX1+rq
	IB6mePP8jFz3Ul72cTNXKUxA5jnW+YFGd6yxpC7mRMjwGlGpy1kSOvrGs/+FnwBMQsDuB3uPziW
	Dkjn4BpkLUBRn+nRgrkP/j6Rff66FxGsBorjeoybaMhlRNDfBSM6qNRfMkEmJZehP8D8gvNlHNC
	jMfVpEmJWy0rPISDV5R/zx7rNpg6LWWRS861V9rAlSpuYY8Hdo+48giqZwnEgg3cwDHl/2bQrEU
	PLWlDmdtARg0IcL9v9rSd36EgULA931+mNd9sJs7gkGWoKY3IeFljx6TxcrEpnvAn+akwgAHbVh
	aKznjpLJ0O5VvQS0BYKHjFLnj7H7cGd19dSFd
X-TMASE-XGENCLOUD: f7121554-5fe1-4a5c-ba30-d42b9d917baf-0-0-200-0
X-TM-Addin-Auth: yJbV+S3QWRYQv1FBF35io9IpC/4Ifjd1m1W5d7EuEvKhEnH9sMvbHm2NUOy
	nDfFbvUBlkG2tfn+HI8KtLErE7S57QlsviC/kOYHWPqeuZXtnmIgTnhkEJ3ucZRoomHZBowwH7q
	DiFFBTtd+tDnHEQQYs7xP41hfBlD9vZ/04S/CIEgkMjXP/DkP4qHbpJaZz1Xyul06tALNo8uSa5
	rM/HE2WigGmhYZXDa0z1HeQxJyrG32TbnBXz5LeAzPL64XYGMVNduxWZCgQjrJPJjmxDmll5GcO
	kkSGeWUCI2D/9bS7SBtjSTIBP9TEIzq8NM8+anUCLFNch5NdrxwU+HCLAw==.J64WBspllfTnf7
	H1joZlGxa03rGPMOzIMirdgKdSTBKSkyvGyzHw5mTZNZDXnZcMaphd8iQsRMu34KaoxJ/LC6tpp
	pZ8mqzhIRcokv98eaxmiCLhCZ94gRv7viMt5oVUZc4HbOdf3Ijpztrq3Zp+xOcVDWr9OE5JisBp
	aClz2W1HUc76oBKAIi1ArvXMHPuc9bIMrPj5i2+NtgM75vj2zt2T11cOBj49F0uuJYRMzdq8WaF
	nhV5gXLkBfa55ZYRWC4oglKs+Pd7aKux6yLZVa8u7+uGCbghrO94AorlhFNjOhxTP9DgTO9DpH4
	/y6G3LbemLKOt2tX/ODKpj5X+NZQ==
X-TM-Addin-ProductCode: EMS
X-TM-Deliver-Signature: 639E89041D909FFFFEF32264727C9A65

stmmac_rx_refill() stops at the first page_pool allocation failure. The=0A=
refill is retried only from the next RX NAPI poll, and only an RX=0A=
interrupt schedules that poll. Once the DMA has used the buffers it=0A=
still had, it suspends, no RX interrupt comes, and receive can stay dead=0A=
even after memory is available again, until the interface is reopened.=0A=
Commit 0bb05e6adfa9 ("net: stmmac: Prevent NULL deref when RX memory=0A=
exhausted") describes this stall and leaves it for a later change.=0A=
=0A=
When at most STMMAC_RX_REFILL_THRESH (16) slots are left with the DMA=0A=
after a poll, arm a per-channel timer that schedules the RX NAPI 10 ms=0A=
later. The poll retries the refill and re-arms the timer while=0A=
allocations keep failing, so NAPI does not keep polling while memory is=0A=
short. This follows the review of an earlier attempt (see Links). The=0A=
retry does not rely on the Receive Buffer Unavailable (RBU) interrupt,=0A=
which is not enabled on every core and kernel version.=0A=
=0A=
The timer lives in struct stmmac_channel, because __stmmac_open()=0A=
replaces priv->dma_conf. It is cancelled after rx_napi is disabled, and=0A=
stmmac_enable_all_queues() re-arms it, because=0A=
stmmac_setup_tc_block_cb() disables and re-enables the queues without=0A=
re-initialising the rings.=0A=
=0A=
Found while debugging a separate AF_XDP zero-copy RX stall, with the=0A=
help of an AI code review agent. Reproduced on an ADI ADSP-SC598=0A=
(dwmac 5.20) with a kernel based on ADI's 6.18.31, using error=0A=
injection: page_pool_alloc_netmems() was made to return NULL on every=0A=
call through fail_function (retval 0, probability 100, times -1) for 3 s=0A=
while receiving about 4000 frames/s. With the RBU interrupt disabled=0A=
(the dwmac4 default in 6.18), receive stayed dead in 6 of 6 runs until=0A=
ethtool -G.=0A=
=0A=
Tested on the same board with the fix backported: receive came back by=0A=
itself in every run of the reproducer, with the RBU interrupt off and=0A=
on. Only build-tested on mainline. Other DMA cores were not tested.=0A=
Kernel selftests were not run.=0A=
=0A=
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet cont=
rollers.")=0A=
Cc: stable@vger.kernel.org=0A=
Link: https://lore.kernel.org/netdev/20260331195927.3353cc6d@kernel.org/=0A=
Link: https://lore.kernel.org/netdev/20260402174049.0ac088cc@kernel.org/=0A=
Signed-off-by: Anandu Padinhare <Anandu.Padinhare@electrifex.com>=0A=
---=0A=
More testing on the board, with KASAN, lockdep and DEBUG_OBJECTS_TIMERS=0A=
and the RBU interrupt off and on: failure rates from 1 % to 99 %, up to=0A=
60 s of failures, RX rings of 64 to 1024 entries, and down/up, ethtool=0A=
-G/-L, MTU, tc flower, XDP and AF_XDP zero-copy changes while the ring=0A=
was empty. A driver unbind with a retry pending was also tested (RBU=0A=
interrupt off). Traced with ftrace, frames arrived again 31-37 ms after=0A=
the failures stopped. With 50 % to 100 % of the allocations failing and=0A=
the RBU interrupt off, the retry timer fired 52-61 times per second and=0A=
the CPU stayed 86-96 % idle.=0A=
=0A=
With the RBU interrupt enabled (dwmac4 since v7.1), an RBU interrupt=0A=
storm follows on the test board when every allocation fails, with and=0A=
without this patch. Without this patch, receive came back through that=0A=
storm in 4 of 5 runs and stayed dead in one.=0A=
=0A=
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +=0A=
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 47 ++++++++++++++++++-=0A=
 .../net/ethernet/stmicro/stmmac/stmmac_xdp.c  |  1 +=0A=
 3 files changed, 48 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/eth=
ernet/stmicro/stmmac/stmmac.h=0A=
index b76acfe0d958..88b83dc3cf0f 100644=0A=
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h=0A=
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h=0A=
@@ -142,6 +142,7 @@ struct stmmac_channel {=0A=
 	struct napi_struct rx_napi ____cacheline_aligned_in_smp;=0A=
 	struct napi_struct tx_napi ____cacheline_aligned_in_smp;=0A=
 	struct napi_struct rxtx_napi ____cacheline_aligned_in_smp;=0A=
+	struct timer_list rx_refill_timer;=0A=
 	struct stmmac_priv *priv_data;=0A=
 	spinlock_t lock;=0A=
 	u32 index;=0A=
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c=0A=
index a685ce4638f6..ad9873aaf2db 100644=0A=
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c=0A=
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c=0A=
@@ -86,6 +86,8 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");=0A=
 #define STMMAC_XSK_TX_BUDGET_MAX	256=0A=
 #define STMMAC_TX_XSK_AVAIL		16=0A=
 #define STMMAC_RX_FILL_BATCH		16=0A=
+#define STMMAC_RX_REFILL_THRESH		16=0A=
+#define STMMAC_RX_REFILL_RETRY_MS	10=0A=
 =0A=
 #define STMMAC_XDP_PASS		0=0A=
 #define STMMAC_XDP_CONSUMED	BIT(0)=0A=
@@ -263,6 +265,32 @@ static void stmmac_verify_args(void)=0A=
 		pr_warn("stmmac: module parameter 'flow_ctrl' is obsolete - please remov=
e from your module configuration\n");=0A=
 }=0A=
 =0A=
+/* The RX DMA suspends without an interrupt once it has used all its buffe=
rs,=0A=
+ * so a refill that failed for lack of memory would never be retried. Retr=
y it=0A=
+ * from a timer when few slots are left with the DMA.=0A=
+ */=0A=
+static bool stmmac_rx_refill_needed(struct stmmac_priv *priv, u32 queue)=
=0A=
+{=0A=
+	struct stmmac_rx_queue *rx_q =3D &priv->dma_conf.rx_queue[queue];=0A=
+=0A=
+	return CIRC_SPACE(rx_q->cur_rx, rx_q->dirty_rx,=0A=
+			  priv->dma_conf.dma_rx_size) < STMMAC_RX_REFILL_THRESH;=0A=
+}=0A=
+=0A=
+static void stmmac_rx_refill_timer_arm(struct stmmac_channel *ch)=0A=
+{=0A=
+	if (!timer_pending(&ch->rx_refill_timer))=0A=
+		mod_timer(&ch->rx_refill_timer,=0A=
+			  jiffies + msecs_to_jiffies(STMMAC_RX_REFILL_RETRY_MS));=0A=
+}=0A=
+=0A=
+static void stmmac_rx_refill_timer(struct timer_list *t)=0A=
+{=0A=
+	struct stmmac_channel *ch =3D timer_container_of(ch, t, rx_refill_timer);=
=0A=
+=0A=
+	napi_schedule(&ch->rx_napi);=0A=
+}=0A=
+=0A=
 static void __stmmac_disable_all_queues(struct stmmac_priv *priv)=0A=
 {=0A=
 	u8 rx_queues_cnt =3D priv->plat->rx_queues_to_use;=0A=
@@ -284,6 +312,10 @@ static void __stmmac_disable_all_queues(struct stmmac_=
priv *priv)=0A=
 		if (queue < tx_queues_cnt)=0A=
 			napi_disable(&ch->tx_napi);=0A=
 	}=0A=
+=0A=
+	/* With NAPI disabled no poll can re-arm the refill timers */=0A=
+	for (queue =3D 0; queue < rx_queues_cnt; queue++)=0A=
+		timer_delete_sync(&priv->channel[queue].rx_refill_timer);=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -328,8 +360,17 @@ static void stmmac_enable_all_queues(struct stmmac_pri=
v *priv)=0A=
 			continue;=0A=
 		}=0A=
 =0A=
-		if (queue < rx_queues_cnt)=0A=
+		if (queue < rx_queues_cnt) {=0A=
+			/* Disabling the queues cancelled any pending refill=0A=
+			 * retry, but the ring may have been kept as it was.=0A=
+			 * Check it while no poll can run.=0A=
+			 */=0A=
+			bool refill =3D stmmac_rx_refill_needed(priv, queue);=0A=
+=0A=
 			napi_enable(&ch->rx_napi);=0A=
+			if (refill)=0A=
+				stmmac_rx_refill_timer_arm(ch);=0A=
+		}=0A=
 		if (queue < tx_queues_cnt)=0A=
 			napi_enable(&ch->tx_napi);=0A=
 	}=0A=
@@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_struct *na=
pi, int budget)=0A=
 	u64_stats_update_end(&rxq_stats->napi_syncp);=0A=
 =0A=
 	work_done =3D stmmac_rx(priv, budget, chan);=0A=
+	if (unlikely(stmmac_rx_refill_needed(priv, chan)))=0A=
+		stmmac_rx_refill_timer_arm(ch);=0A=
 	if (work_done < budget && napi_complete_done(napi, work_done)) {=0A=
 		unsigned long flags;=0A=
 =0A=
@@ -7779,6 +7822,8 @@ static void stmmac_napi_add(struct net_device *dev)=
=0A=
 =0A=
 		if (queue < priv->plat->rx_queues_to_use) {=0A=
 			netif_napi_add(dev, &ch->rx_napi, stmmac_napi_poll_rx);=0A=
+			timer_setup(&ch->rx_refill_timer,=0A=
+				    stmmac_rx_refill_timer, 0);=0A=
 		}=0A=
 		if (queue < priv->plat->tx_queues_to_use) {=0A=
 			netif_napi_add_tx(dev, &ch->tx_napi,=0A=
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net=
/ethernet/stmicro/stmmac/stmmac_xdp.c=0A=
index 9af9e0cb366c..c3e85ee1067c 100644=0A=
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c=0A=
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c=0A=
@@ -35,6 +35,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *pri=
v,=0A=
 =0A=
 	if (need_update) {=0A=
 		napi_disable(&ch->rx_napi);=0A=
+		timer_delete_sync(&ch->rx_refill_timer);=0A=
 		napi_disable(&ch->tx_napi);=0A=
 		stmmac_disable_rx_queue(priv, queue);=0A=
 		stmmac_disable_tx_queue(priv, queue);=0A=
=0A=
base-commit: 325e921a7aa170181e1cce235d9c652cb0ad3a5b=
