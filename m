Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795417448;
	b=0W6O+3QFlUl1XGlfotNTG711jeucqi8BNkgM1FlUNQ6HUOjWhap+QhU/mOZyHimIntyJ
	 rAfcQaCUfzK3Ai1EUqsS35ucERXMgMQIfA+W91nX4dHDrwy3v+qNum9p1lcl9pH+JiSYx
	 vRvFoDrUxywjphYPBWmW4txRaQFGTrT/b3PHxxu1QbdXwdz+2dSXigS22By+NMCkbvDUh
	 zYR7s3dXx9XPhpwcDJNNSLx0l6JMkqoH+Gypg42rYKWJxHtpiLAeuUrhIa0+WAXjHgurN
	 5KA4TZxWwcYWU4kgy/zsMRpeWexrpYkfW+Q/2NqMQHr41P4cOJXXzyOIorWDCVsIOuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417448;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
	b=PHQUj34MDICJs7BUPktGyttgOkL2IWKkgEG/RNreon8hOOGqBKjsFMDw/i2CUO1cMCtz
	 0TMhjfiyHcKvM8Mq9+K3FB1FE0PZ92uPSGcEjQERvSneRXs6TxdFsOk8Woo8dEO18jYaT
	 h8MNYbG3zphPKjRwsT4n7a97fRQ8Cj/8jZtcs+AxyOcnKRviurMBWoD9ZXm71++nexRih
	 3tnUyghxm7Jq9oxZ0oW4zp6TD5Kz6IL4pjmXvlT96SU3/QwfOyhFpCh+ZyMVfE/wJ3nUd
	 c9aZqLocfWS8BrbBiG5lhu8ll/XXgJ9X6EErmmA9yLlTPTMKBMqCJ7h8pLudFhTeroA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HzouGRZO;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="fIDWe/Mu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056E606A31A;
	Mon, 23 Nov 2026 07:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9056E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HzouGRZO;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fIDWe/Mu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795417447; x=1826953447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
  b=HzouGRZOLjI8JM0pbDd7iwG6zMk7PbQnS2UTrBMzEtLJjatvOkUbfGCC
   qYeUa9FN0CevTISSBB0hLw4dIECbHB1PvCNr/72+UGvgZziISz+EFFsd5
   4b1a7jiachSM7OZh3KHCgqTgViJuUL+YXMNaE4z0NcpT7MlWJJbXt1Dib
   ukBrqBfmcbE05iOsc0v2hR+bZ18ASIlY+VFJ5PFccs7QSx8/EIX9UYcaK
   VLZOsZ57piJowPz6Klq4e7IwMOwQsw2x0gePTKKgcdPoaW/opnl9VGrDm
   yraRVwkkRMHGR9PP6AgkadyJjeM8SzGoiysqTYQ+fG4rsObhGHq52LgoQ
   Q==;
X-CSE-ConnectionGUID: iTuRYsg6RaGNkCLgduvYCg==
X-CSE-MsgGUID: DS3f557BTw6T89sN56uD3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4319042"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4319042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:04:05 -0800
X-CSE-ConnectionGUID: Zx/mjT/MSBaB9hSbeV6zXg==
X-CSE-MsgGUID: IvD1jfF0Rce5p2m93SHQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11316160"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:04:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:04:04 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:04:04 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:04:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzxO/J2I+PruAuiCU0MLvLA+GU69hrBNc3nN/S/W6auaXaCmDHqCEFQCpC3H3n8g9b7L5wN/okJ/slTTyv64beac7jkqRY+0Lv6UAKYOI2Wz+d5+jW8QsdJtZj1rYh/3XKim5AJ4L9wHPsHFeqquyPtpoD/m3ZuHEQSUKZQZrrXfDeWggvapsS6AeqU7Pyj+a85mwq886CYD6Zdlw1SKkYvzE2GaP2xZotA4ZyQ4FIqqLOG6cIkgUoDZhgrEfYRXyRpTGl+f8FsIvWIjPZ8ZlX5K0YcjlEjs4ZLMowmhezTA8b4pHxzmS5IHhFo6N/V3+pSWoFSbo4i+R9mOFJgfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
 b=qg4W6PZFfoeC6XHcEu1i0thiO1oP4IpJe4zvBXsEL9m39+n7xUKHlqRMF8tI9+EdrnBOsSzEMDgQcHlQ9M9f6V2fOFEskRzey5BTGpWSZwGKfj1q+qDmnXy2zNpBsyj1Nv6VmSOJ7uCYAiRGQCfUHVce2+N3PfSUfMDJJPzL0yhb0wN2rhZPG4JQd2XDiaeqvdhcjPQQj5QHVhkAw20ko9T4jNxjDgkOh9HI+6Idw0vldeoVDL5PLfOsqy0V575Xdr8lZ1EMHcGfjxbMRMD4+RiQpX9TRhxO7oHgRJvz/JIOLwQ3bANOnLezVRzC6ZJSSMiYBklEwC3q0a2y1Iywqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYy3FRxMVtx+6Up+UIZJwFzCbifaeBYI3I78Q8jrunc=;
 b=fIDWe/Mu+ixlwoI7Yd/tKEi9UxcBMmPiwipDLs4iLlgQ/yfuEEfWuebcvVops2rkHKh8MMzMPkHqs37NjLK2GKIO15hJXUZrNJLW7ok/gNMSkQaE6bAl1/JF0FYwI9JS49T6EtFSQjT6UMVkuA8Q8rS530gNsHiG/Rg+6pMXM1c=
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 07:03:53 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:03:50 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "alessio.bogani@elettra.eu" <alessio.bogani@elettra.eu>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "horms@kernel.org"
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH net v2] igb: initialize PTP state before registering PHC
Thread-Topic: [PATCH net v2] igb: initialize PTP state before registering PHC
Thread-Index: AQHdRrX6CW79ZeY6PEa7Q54LUMhz7bc7pCXA
Date: Mon, 23 Nov 2026 07:03:49 +0000
Message-ID: <BY5PR11MB397674E55184C5C97C5EB9C7A5452@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
 <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|DS0PR11MB7213:EE_
x-ms-office365-filtering-correlation-id: a85fddf4-1477-4eb9-61fd-08df492fed23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|10067099003|11063799006|4143699003|56012099006|5023799004|261021123027099003|261009223027099003|261102123227099003|261021121427099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: r2QVV/En8Uc88kAudeFyqtjMpzl+4AA1Yq5v+Gfy5y+wDQsKWcTnU+EG3KZ0L7zUTazW9NqLYUGW26hWqOM+c0S3ESRpoc0wJpg1e5bwsFFqVsIzGaKg+e013PAfCotTkJ/hs2loNVLUhgyEbm4SY663juWZyE3qr015zZ+6GktmNRXtp8L2FITIHcUdiTpH28oB/acKkktJ2JF2rKR7xUUQsQ+kVlPzPaCPol0cH0hC+tPEDJctpWrQoQB9CA+sCGCi86zAD+cSdiII+GFAX5RglLCLTy0uBZBLhGPz+TKaHn+nAY+OU7h/KkHtNtWh4HZK8aR0zYL9ZykAmcyUQDIjcKB1HnWmC/1gtlsv18HTnMNTHkfcaB8fQNnLZco4NxNPUpl4S7YleAJD1jcQJheV9Stn5N3eZQHyjJPFMBxv8to/bmn2f7mCslpZKkVyu/cKEgCsFwK+f/hNqZHuqATRAS/87T1CCtc2vks75s5rShsz1+i468Op8vOHfk/3zSrE7+Doj2Uxws7pdqgUKjmvOBy/PZqVlTF0gTxhMjS8lkUtgrgdsj3TehjuGRRBV0XgrV8BqhuzcS/8pJWhE0XRxBoeu/9R4r2qCPMCrUGpybISAQKy/vl3UCooqAqkHAV6L8lA/lsYSHSSgNPMDxBepsyOgJUdXnA6GcQCsYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(5023799004)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rw2S14hXRsqml49cRPPN2JhS66bdAxAcUxZ4lCogzmZx5QAqWKXnIRm9x/Tq?=
 =?us-ascii?Q?q88+sja9dWgLw9rq6yQhTVpcHvePkymbUWBFePb8GdsR+hPHukaGkeUckPt8?=
 =?us-ascii?Q?0frTka8IO4uqrohJvu094YK8ok6ewv217ouqZcOBIt83gBXLNOd4VZd4TYWF?=
 =?us-ascii?Q?uHYJWOisrxncm4wT7n9gY+jG0RaCwDKaTIRlpbyQwqbAjmP62TRDcSrtbLl8?=
 =?us-ascii?Q?OfW/Uowrtw0LsVc/ybLxGk9C9Fh6bXtXqpAokUUMU1vKMQRyQR+fDJYT5UXd?=
 =?us-ascii?Q?23lGx9gaSBaAwvjHPGbdKFtbSyZ3RmPaXHIAFrB4KA0ZmbiGDDx+477V3WW+?=
 =?us-ascii?Q?5++4SZfTD9dEd+C5muPMkHVHsOXWtxOa+nI2kJC3nqrs6Mj7ZdxIDbBbJ62/?=
 =?us-ascii?Q?UMhQwvQx6xITiuEyMbZZ+tpGCysbNQWq65TOjH4OQVIVsQQ6wWksa0AxlfoT?=
 =?us-ascii?Q?khzYkFmv9JnVoypPybIWJhrB0GPPARFfccLCn3+QiGgi1Dcp3pA3iabNnwHf?=
 =?us-ascii?Q?k/kh6Y4IITskdTEwwT4/nu1MaSrs7arUR4pJxyqyANcsN//OV2+z1VswQ3rA?=
 =?us-ascii?Q?iCUAwpWIxxQQzJSN1Gg17abi6mVkcK48UlKcz0XzNnoQDDfKtoyxHBNJUE9T?=
 =?us-ascii?Q?Ra5+YNvzuY0Bb8FW95m6DBRW/4EuTSjCqcS6EDr0ukZ1o2pDCuH7qScYjJ0T?=
 =?us-ascii?Q?b/PCR3pTIegz6dEjUOrJzGPUYSVdMgX1dzvYY5olkNhlYtYX6wSSRV6WiyxV?=
 =?us-ascii?Q?B2gR2IlgdKinAqAftPDzTEw1g/nl1sUNsw/lgKxrr10Xy6JPV4/HgR/pQXDe?=
 =?us-ascii?Q?ElETB9Xus6X+5RdPS0i/+Y0WbZFe/RdhA2sSHcZhMZFSqIkklGG4Msw6jtpE?=
 =?us-ascii?Q?9kcxPKQ64gweL9UvZcolwt5cwHY81LE25sYe9VAs10vC2T3ZRLIbat5uAeNN?=
 =?us-ascii?Q?dzi6fSf6zel4Bkd+bweasomZUfWs+Y+W3LZQDL3igU4VNWjAMyLUPIcLAYLZ?=
 =?us-ascii?Q?wRlOAch76soVoK+4g9Gzn6RZwRuRndI8ids++niD2P+kJj3OpAQQmxuk8kTX?=
 =?us-ascii?Q?Z0VX/MOqN5gukphJIVT3+OS5CvQxZAZvYlMF3ytNHKPUNE6hJX0wMdx8FOOm?=
 =?us-ascii?Q?FTeEX1vWT2FOLDOMwUDf3/yB8Q8a2TnX3D32t3+oeQ/sLqoY2a/F2oHGx3tD?=
 =?us-ascii?Q?gL0Z4JWu2808s0yKLwQ1xftw/dAht6wsuyzrckTKcSYCAAjHvFtzWOYj0gbP?=
 =?us-ascii?Q?62NS1M6BaUXTYXIns5g+s6rCX7NYWitYeCF7eBsuPvUUvz7k5mscrSYRXTWj?=
 =?us-ascii?Q?ATx5U+pA2xCkFNsz8g9/bAyp4VGognfFNprpbEUb7SmASfHSBzfSYfHuvGlN?=
 =?us-ascii?Q?qiDAf13XlsTYtUZaCryTY3pn5XixKp15WXV6d/tO/UqBuohYngpmnB+EmPNV?=
 =?us-ascii?Q?avIvr0TTwnQy2XLeVdfH1sESgz4LhuGY8jKtx660j0WP4Xb66VLLODydf+C5?=
 =?us-ascii?Q?JmQtAijqZC04RrIpYgI5Fa5GMb0/JPDFxaFP97j88Di3CMu+dAQNmEg2gXMf?=
 =?us-ascii?Q?b1fSKkZGff3/FEKZ69K0WxjLAKO/FGs9aKbiHghK+Nfrfe6Z3r5e8CaGoYMK?=
 =?us-ascii?Q?445Sp4zx8rIsopUq3pKkHanFYn3tVUo33FmYNFbo1eXhIz90BQN3bSXlqajg?=
 =?us-ascii?Q?AHKIiMc1PDkxoqPrwHOeytEbM0cCxxrQurrPzZSsWHbC1V9l87EQ2Q8Ci9ex?=
 =?us-ascii?Q?jFOERB0nGw=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: GSw+qvbb1Dr9PLMOlKuBubxn7tM1KIsl38GEjXwPjPx2zPwrhWJhKjbwqcSuCspa63XfDNLXLCPfFo6JJejbF4ZOkO8vTfyybkx9VyT836FcHe2+9oP2Za6z9JTK8c1mC1tLBjrvrdmRhmAyhGXfkGi/MtV7i5LzYrDnULGY2W3TxXTrbKHb7OwOk2qynp15Vu3s0TOohcdLLz8wc3Bb4nokxUVEx2/9ko8sVBul73BE8DbYJfzTm+8O5qs/o2coyXvbGT9EaKBfd5CycV5veQXNHR0YVKUILFhxf1f9qpMi9tkkbvPUo9tqhfLP7pjy3VLJylMoB384Wt8nk1NJYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85fddf4-1477-4eb9-61fd-08df492fed23
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:03:50.0407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NHKEQgrWOs2k+yycMWIGuCuDCdpMjMaQyZeUnjZBQp2yFVWvG+pf4IHuFedfPNNoquvkYmA3Rp8W9GYsF/HQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Runyu Xiao <runyu.xiao@seu.edu.cn>=20
> Sent: 17 September 2026 20:33
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: alessio.bogani@elettra.eu; Kitszel, Przemyslaw <przemyslaw.kitszel@in=
tel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; =
kuba@kernel.org; pabeni@redhat.com; richardcochran@gmail.com; horms@kernel.=
org; intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel=
@vger.kernel.org; stable@vger.kernel.org; runyu.xiao@seu.edu.cn; jianhao.xu=
@seu.edu.cn
> Subject: [PATCH net v2] igb: initialize PTP state before registering PHC
>
> igb_ptp_init() currently initializes the PTP lock, work items, timestamp =
configuration, and timecounter after ptp_clock_register().
> The PHC is published by that call, so PTP callbacks and timestamp interru=
pts can run before those objects are ready.
>
> Initialize the complete PTP state before registering the PHC. Skip the se=
tup when CONFIG_PTP_1588_CLOCK is disabled, since the PTP registration help=
er is then a no-op. If PHC registration fails, cancel the work items queued=
 by igb_ptp_reset() or a timestamp interrupt before returning.
>
> Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20260830154912.2712900-1-runyu.xiao@=
seu.edu.cn/
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>
> ---
> v2:
> - Restore all PTP state initialization before PHC registration.
> - Skip PTP setup when CONFIG_PTP_1588_CLOCK is disabled.
> - Cancel both PTP work items when PHC registration fails.
> ---
> drivers/net/ethernet/intel/igb/igb_ptp.c | 31 +++++++++++++++---------
> 1 file changed, 19 insertions(+), 12 deletions(-)

Tested-by: Singh, Ayush1X < ayush1x.singh@intel.com > (A Contingent worker =
at Intel)
