Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793080206;
	b=emiOImiuRv5jG1tDTHk5xKyZvzhOs7PQhLZbx2I4plV2h8mqxXOSnJpK9dgoOAYPPczd
	 bb6pytBJ0nkM1JcLT8Twxp+Dp0T6/gxII8bVALaUTyoValf9RW2BBtQrAuPi3wRoMl/AZ
	 v9OTXWLLIBnfLn947/ydDM4e+czeYNppVvSklS5j0GsjLwVkV8HfqE9h0yI8aTEN6taZR
	 lgKhfaSrlKHsfzm+S1vSKuW3/BUZkD1bX6XD9icqghaqPCTo81iJUBJlP4co5/W67VaBc
	 /R/5lsFlRkkVgWqAYMD1+jMEu5hTXT/nm3H2F2WHLjTFUsakcGl6eR4AzrAsUBbsBSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080206;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=qV1tbNl6Es/ZCo6+i7DkBWEjJimyJvjxssHZj7+Nxyo=;
	b=e/ES+7Ok9XR1UJMmqM67BlVQHDn6GwlJkj4MhfK3M4xLKamA+4c96Pu3ha4JQgA73xZI
	 WeBeBiFxj+hcF+fQpT3x6JImFEnAJI6HauEbfJExiYnbSiGzgG4YDjQ4DO/IYLgtFX/ij
	 vM+bEpCZLA5y1IVE7OHQy+psheKn5eFqvQOw1Np6bEcm86b9B4ng0bwJTdP8JI1sQ8WFS
	 R4yAF6qw5IjEv9/HKRTw5/ydaYqLm9/xXJnHmvEWMTZFNuFgKaVsr2QGA8O9Bu+i4RQ6w
	 UDGVhjLV2cS7fvq9g+GfPxxRGVdX1GHV0UDKFad0G/Hlh7G8rLw9NDrNQUyPVx2NP7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aocxmy2A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5CA606A31A;
	Tue, 27 Oct 2026 05:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aocxmy2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793080206; x=1824616206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qV1tbNl6Es/ZCo6+i7DkBWEjJimyJvjxssHZj7+Nxyo=;
  b=aocxmy2A5y6TPr2tLJxJqbKheIJPZ58JDgzoVY+gn3ENPsLq2hFR+Bn3
   bjtTnHP2SHe+muj1RqTSay8NhHS6TdAn9nYU6ZGRM7PKZfs6Crx9gh6GG
   q68kwt7PPVvEAEE0UVDHWGMNul304Ft0hy/STCnp0NWx4MwLmfx02+Oob
   2cq22a2Xm/4nW+eRyuwRSvw4NZmq6V1ijA6R0Ngbq93/4JiWNia0qab+H
   M53cP2DGvhdcZ7xAivqeD5WAVB6APnmYEJWzB13xFFZXzz+Tv8EpC8QzH
   1ncITmZqS0LahmLQySreNUsGs5FccbMZr0Ig7EHicx/UzdMT+VXT58YXI
   w==;
X-CSE-ConnectionGUID: d9lXTx8VS8axILkgeyPADA==
X-CSE-MsgGUID: RDPwmQWMQRyTMdRPjUMUoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1765187"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1765187"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 22:50:05 -0700
X-CSE-ConnectionGUID: 6qzrNknSTPaTqfWPLss6ow==
X-CSE-MsgGUID: /uwUsybKSli8AZHv9mF71w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4856572"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 22:50:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 22:50:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 22:50:04 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 22:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfWaA0mURc2JlEHrgCIoLe192Y+YYHluu3IaA76QktC8UNKk1f3SaCtckJDZYtB5fIK18lCNMSZkOc2Uq43hSxM9eSF0l6xdeWzdfUIQRah+36Y91cYYS/WL4nlFmgjSY/n/tTU5pD78n/Bu59MpWC16bItWQSkH1cvpfIW7uw+ZE5jdd//fIbJ5htycbbu6df5w9pl/PqRq43GReLmUIBHrk0QP+nXm07WL7hBSt6Yq+nJd+RoUt7Fa411Kw2xznMIQ2ixLzF1j+PjMJ46Xcmqn25pb9/U5VCsR5+NvHE7O+umlqA4KbHXcRfZxxODhZcaAC+slhv30FRRZRpszyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV1tbNl6Es/ZCo6+i7DkBWEjJimyJvjxssHZj7+Nxyo=;
 b=xIAp9w5g92SE6gERnwQCo8syNA2qqwE5dsa+0pLcVLBbmCFCn0EI3oowO0GUglhgdhCxJVK+OtOhc3tq3DayTDErjoGYDJBNLWSKEsytDznUWIyUcKC1bPOlp1tp8IksLtNnSROV2ki8ZMo5aeq/9X047HNqDJrbFlo5ed11V6FnzRdT99TvG75q2ottErVlFdT2K9zjO9zOWmHlhC0knAe1Lrq2FDEFxptGnUff86+phkAMlGzcRsInMI+bu2EDkKFLvpbBqpR/ATL3VJXhzrVX3mlbrFW3gkKBI9gGEnNNl8CVlRm+/JPwICqHXTJDC+dt/fGDf0uFNmxyQma8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by PH8PR11MB9974.namprd11.prod.outlook.com (2603:10b6:510:3cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:49:57 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 05:49:56 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter
 when register_netdev() fails
Thread-Topic: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter
 when register_netdev() fails
Thread-Index: AQHdRd9QtyE+6Avr30K2fVvRJNxTbrcRIjqw
Date: Tue, 27 Oct 2026 05:49:56 +0000
Message-ID: <BY5PR11MB397697AC12B3A50F88D34832A5602@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <20260916132740.1001797-1-xiaolinkui@126.com>
In-Reply-To: <20260916132740.1001797-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|PH8PR11MB9974:EE_
x-ms-office365-filtering-correlation-id: 6da0cff5-de1a-4a3e-b5b8-08df33ee216a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|921020|261026121527099003|38070700021|11063799006|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|22082099003|18002099003|261026140227099003;
x-microsoft-antispam-message-info: nowTbW5DFBfXHi0W1TiJzZc0RLNRcS1gq2Fv9wW9lnoqgJZPKFc1cwkSYGU4uQLQSWV0A63God+Yb9pHrooe6WebSJz883h4L/Id3vokCVTLut511dPw4qi4BsMo3/BPNrd4H80oTspm+qwsBgKhb4dihZkfuJBKt8aP1PH1qOXA4o5aPzauwpgPJ9GY00hkxCeoedZNuWl4rMin6FCrXsK1o+7Nbft9nOnIeQ2G4GbbDYg9ALUtICi93uSRpIhGaANcCSFEQ4Bu02KjsVUqdVHMQBXgWLsNxQ16B+IY2de8WqlTYSsti0NBWwyWHUrd8HFkEvkIp+A2JoRx8mIG6UFEehjJklymCZ2EVsSYkLje6P+tS95xi1gUdllhKihFCTEecb7S8YIVKekRzkyrlJ28sUmuWK/f6xWtpYtE2ZvuuJ4LaBkfXqC9zIVGvLE3o1dtK2ZDsV8kBywW3bU2SK+xq9dEGrpOJeVe3kcm7A1VmJFUTrOkY2JSVqmZJxpx/MpcSjdyWNp07MwEBKhABKOhyKHVBQ2KjHaDiPuBWQWYToKzC6HU3D1PBjSlXyk5dGiWl4yya3gZXMabJOdxyYWsNm3KXRSs5jT7fw/T2HAOAcU6hqjCa3IzF/cC6w9ymA58yu3YXDg0zO32Ts7148piF569HkhnM07AQVASJ96QuWw2SAH4DFlfkLcF+rGR/TT25Am0RTZo8qIjta9NotPKx4sgr0wnzEZdWGFPR08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(921020)(261026121527099003)(38070700021)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d1CedJwluI6ttq0yQ+r7nbOjc4jY/TZVzsAtXMMpBC6KS3ohcrUvJX1P1pIe?=
 =?us-ascii?Q?LEWTt8jgiBb/09WmH8EQC0K92VrkKobFcesKrIc8wFP0P6ur9BmtyqYvaOQr?=
 =?us-ascii?Q?nGroZAqM4om+HUc4PZSDuc0s4r2IFI02u9iqWVte39HFha6GYSuCcMz3ZTHv?=
 =?us-ascii?Q?L8PjjsZCl/hFfyFBKzDfYmqtg6zTvkSPf/JUShaKDNSh+BhXDmI+/QWz/ibJ?=
 =?us-ascii?Q?wh8aENqPiRuQScBynCptYHIyQZ3ukkT+UHxTvn+Yw6nrGLi0oOLk9pslAO39?=
 =?us-ascii?Q?bRzmHTt6KLXQPP+kyREWzEeUBqCRJyseOfOnFa/mMS0pbe/ymQXVf6fkk/1Q?=
 =?us-ascii?Q?0kynuWFG3U6LxZTMfjmbbJCR5OgQOfIMrXaePUNweAoDJURzTpOfcfiJXqVF?=
 =?us-ascii?Q?Qo1z7ojY7To7H8m0f79/NdoVIGxnc9wvNAVsl61g0n9apUO3w0P7Lax9+lgB?=
 =?us-ascii?Q?7K0/bYVYvX+mNuNpoA7s1tzXjqt3m6qo2xLA6N9tZMV58Zf4wTFwcy568wcc?=
 =?us-ascii?Q?b1bIqOyYKOq6fcrNkF2fCKvDdA+VN6KaZ+Er4JkvMq3c1bn4NjfQ1mij9ROe?=
 =?us-ascii?Q?W2ckP65TM4TCKwukWHUYMj0m0NY7PVSoPhL/qmGRDYnfTTwNb9gDWioAuhzX?=
 =?us-ascii?Q?bYxQX+5HvGlOHwtylCj6+25uMEe0Wi3lVQJZq/W82Mey9MQELouLx4HXR10w?=
 =?us-ascii?Q?JW6ybrrSv+SQHbTyl8SBRrI1mSm4EzX3DaWLwbKjs/2yjx46N0SBpeR37I22?=
 =?us-ascii?Q?Dw+3VBC6w9E+2zN6XOLhF+tVJnGLv4JoyoVEtHKjrIR8pHoqhrXrTItnrED7?=
 =?us-ascii?Q?42zwkgYgLbYjhlDrZbJuYkkAafsDoYt2xnAI7LWN0bsoOx4qNDTi7IndVovc?=
 =?us-ascii?Q?CdsbOtoaDUszPruL2krt+XmxnrKxWJxiFWaCwv/2ygcnrG/oGqhIL+hHWgFy?=
 =?us-ascii?Q?d5FT1cLPGMpb3YHy6yJCxtqubGLZUSQbEew2AtWe4C+nZFS/Cq5j9HcYZdRH?=
 =?us-ascii?Q?TweLNoqsFbLStlfy5uDbF0oEI7ExmdnYeQZH6lu3twwjHKyJdqhfeNpDXXwl?=
 =?us-ascii?Q?oSZqbj6CKaFgIidLTiDkupWiS9C+BHxXU3WRGthSWYSuIu5Mq4CL+WE577+L?=
 =?us-ascii?Q?KK80682PrzxCdVXpWpjCBEB0+yUcEidJnYn4J/fbUMieqMS3AQ/dVGyBGhqI?=
 =?us-ascii?Q?JDMQhgbqQx2Zo6RGrDQEc553Ew9HsIrTPfOpBaFaZzQ1/NfZ44MDt5ZhHA0h?=
 =?us-ascii?Q?8GSVEwsBJNdNVyANdGs8hgOFTg+0r8vx0BpXgGAHBecSbgdBwlo/6vuScc2i?=
 =?us-ascii?Q?EJol14h2MvyHUlJsH3ZcRWbiTySV8jRolcchUQ5+49lXBbMRUnK3NHCVVpYQ?=
 =?us-ascii?Q?CbIkaKeUyZQs07KzfDShh4a4dFMxclIFFXMci2hfMLa1EpqYcBGcXDNS11BB?=
 =?us-ascii?Q?60TBKCRwR0yKHpjc+vdniNy1UFIq2lfP3SuTF2OFoZbPqDA2QAzboE5EJJaM?=
 =?us-ascii?Q?39/H5Hznmfpg+mDuc/hp/vI7Px6cesyUkuen0KqA122c0Np6skDL/2VGVLZN?=
 =?us-ascii?Q?+gXJK3GofraT/dSnyyQx28y7Q9U0mL1H5WJmdMhxUHT30a+igpjT7mrSvDn3?=
 =?us-ascii?Q?iuy9x+b+TUpoAeJCjip1lBtIGqhmhfw039w8skMUptEjCZCI49vLa3PtOfSm?=
 =?us-ascii?Q?G7GMD11uF/B9l7InfzfNt2Nosam1B1pvR8DElbHJTpQnuD8RxftsNjOr//Ev?=
 =?us-ascii?Q?/kYH9XNUv+0FahhOtPh8scWzpLWDpDvDTkBjIe9GGgDKg7zxiSlawRkQDt+b?=
x-ms-exchange-antispam-messagedata-1: k+lZLgLCHobn+A==
Content-Type: text/plain; charset="us-ascii"
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
X-Exchange-RoutingPolicyChecked: aVsqp07GeuNZ+NKWP6w22K9GMSiXVLMX4trDln1YORpBHmRaz11eCIrubsCyLehaxX5InRI0zjFuVCGGuPaTwtW1KieyB+G8kY3jqezIB25N3Lcg6G2Tyu4efeNm4zEZHfRIA7DE9GuPXmAFsIQzOYvLhgqy+qF59UKRIR/nG4sLAn6fLDllWwPh6N0wLT8u1RJBKsFOCi8OzgwVTx9LieCbxKSLkbgjSVhLiUVJOV6CYzFmKnzHUdAhFmlTBqmJHkhxEUv9gFHXrGSzostZzfly66SszQvuR4jp9NICet8AIoUXJ7EK1CmEwoI+AdjNoPFK6HqU2HkbNqztY8QBTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da0cff5-de1a-4a3e-b5b8-08df33ee216a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 05:49:56.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCfosDBzpA9vnXMs8vT9syFO0RU6y8s2AR9ZnePBueVUqu9QJcBRVoLceOQ1BgFDK/HItPiALThJVYYSdzT/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9974
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>=20
> Sent: 16 September 2026 18:58
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>; stable@vger.kernel.=
org
> Subject: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter wh=
en register_netdev() fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> igb_probe() sets up the bit-banging i2c adapter with igb_init_i2c() befor=
e it registers the netdev, but the err_register path only zeroes
adapter->i2c_adap instead of unregistering the adapter. On i350 parts,
where igb_init_i2c() really registers the bus, the adapter is therefore sti=
ll registered when free_netdev() releases the memory that embeds it.
The i2c core keeps pointing at the freed adapter, so any later access to th=
at bus dereferences freed memory, and the adapter number is leaked.
>
> Call igb_remove_i2c() instead, the same way igb_remove() tears the bus do=
wn. Move the helper next to igb_init_i2c() so that it is in scope for igb_p=
robe(). i2c_del_adapter() returns early for an adapter that was never regis=
tered, so the parts without i2c support are unaffected.
>
> Fixes: 441fc6fdb47a ("igb: Add i2c interface to igb.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>

Tested-by: Singh, Ayush1X < ayush1x.singh@intel.com > (A Contingent worker =
at Intel)
