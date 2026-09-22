Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8453A38B;
	Tue, 22 Sep 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075786; cv=fail; b=BSSVPydxvAwGPzYJyDNpRW49V9zbrhgjaTIP8VBDRuNh8d6g0GldfXWL32HHSp89lXWWbutxkbZJdVdVoP3syweXgENT/Ib5WQVI9JUFaoPdJOUX5QzEb8T6mMqpPlVKcsMm4qKp7DnIXd6CWAJpL3gDYH+Lvdpr+Gk8tN3Ltsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075786; c=relaxed/simple;
	bh=8AV4HoTERcsIZb+AyFe6FAuZh6h5Qbi9i4+t2aL22f4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AivfrNzoDhkAPTMm8Jqr3M8JPE+P5gha1nWZYv20ryeP5FoIS9JEgat2IFbVayhX465RIXN9296QcQC6eGXM5H4RgSf7IOkBYZszO4XQU+C1GVeOq9aNo3aWZJGNevpHntbAubahPKiEMBKBgzWQHOSs1RLsAvV1pWySkANYFaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RX/75VrC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RX/75VrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790075784; x=1821611784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8AV4HoTERcsIZb+AyFe6FAuZh6h5Qbi9i4+t2aL22f4=;
  b=RX/75VrC3WifphWZ59kuuVDeCrzgc5CBenOlumPXdaucCALHHVWcQnft
   VEuZ/bSEJ9sTTUU5BJGcCltvKkZ/xDr9Hegcw0JVgB1ewx+h9o18eFNml
   8xosK/hj4hZIVFZSu6HQFuK9ckLyDNZ1dv6WVxGWgCSNxgw9AMeKFrZUp
   ri/aoY9Ys2p2DG94GGDsabk9K9ayH5QSIBeUan9Sr65cNtooxR+rHbZE9
   wr2UTM6i1DwVZjAwPxVVsUG29TmytvMH9zfIe46O3GVNk9tV40yA0JCN3
   917UahkBdImQxY142lsh2L1tc62KSXgvf36kb27NhRcOwyq4lEFQaSiFO
   w==;
X-CSE-ConnectionGUID: wNoZBf0UTvKuHCyMzsSv6A==
X-CSE-MsgGUID: xfs9Cn6FQLKVnlGsmE5Zww==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90689750"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90689750"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:10:02 -0700
X-CSE-ConnectionGUID: x9hT0DWiSf63ryRwrbDT2w==
X-CSE-MsgGUID: IzB7OQRkTDCEufIRUrjM1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="301012513"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:10:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:10:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 04:10:01 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ui7eQIfweEFHVthAtzeYPBUGCC3FfDxAilrLau0wZlSQMzFnE0xV7y+qshz6hCqawU4wt6JMMSMI95OMxuzywivHOpFoetn5GgvtxaWAInSs/YgSCeuc0uY7eeSC/vRUIndfli0PiFt+QHePVbUFfOvIDqrKLY4OYShjO/GwzogQizIlL5lcvOyE5q5ZzDZM1Ulps0x4Mmwr3z2+R3Kv6+YCVFMHY1YICj9AkLHkf9LGmOYQnkCW8MTlcohfyVtJ2gey2DcXI1t0COGVuuYz5Vbvuv9uBaa8vVHh+T9f4MrBlkPNN+2ghlJyg+3WOIeCRBgSV9RcwoE3F+ipB4T2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fVWF+8QusEdCJMiZfiIKwFuXXxLbi3mHJlP+63kgRk=;
 b=hanKbhP7/i7jUPvnCfkI+XQgLntMmCO1C1g8du7zHtc89b5kPYY5FaDXtM/dBTCJY4Mx88tY9wRsNNLkrjb2uVJ7s0/loofET+B/YN9jt3BgFkEwAhAcsrinvEcKpgyt00wpLvOdGMS949ojiGw1ft8LfhZTqE3MNc6voHo79zvb86WS3aaBSE+mQDlnbZqNT73Mq2n/spYJ0RK6qgiClFbH2sbnpP5AvATpdhxAQd0UwKGQGOn/g68c1tVsZn/4l3vCto2aLGgubJWAvLWFaXzb5IS38SNNRVUQbq4W+0fXb7SJ0BIW60XoLdWzE9COrpdp6Ml0Z5xVp/LgG3LhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 11:09:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:09:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jiawenwu@trustnetic.com" <jiawenwu@trustnetic.com>,
	"mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leitao@debian.org" <leitao@debian.org>, "weirongguang@kylinos.cn"
	<weirongguang@kylinos.cn>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2 1/2] net: ngbe: propagate resume errors to the PM
 core
Thread-Topic: [PATCH net v2 1/2] net: ngbe: propagate resume errors to the PM
 core
Thread-Index: AQHdSnpmXGADfb7hNkqvpXsI1R5eF7bacL4w
Date: Tue, 22 Sep 2026 11:09:57 +0000
Message-ID: <IA3PR11MB898691A2B704A1EAA92A325AE5832@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260922100836.1147718-1-zhangyunfei1@kylinos.cn>
 <20260922100836.1147718-2-zhangyunfei1@kylinos.cn>
In-Reply-To: <20260922100836.1147718-2-zhangyunfei1@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7103:EE_
x-ms-office365-filtering-correlation-id: 38e08300-8db7-4e85-fdd2-08df189a0983
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9DMQ+tvnYZDD9Jz+HmqyiBmwtk7ZDgz7f5alzrZ4NE8qPclBKg+q4gK4mF4PsHkdVmLYEaRoUv2wALgly/TZ1ucvu3mhWswhK93FOFat39OihU9GLA9UrBJjjIrHCObZxRsP5nluab527223FW4junFz+LTr2VT2R49kmVghXJatEif1FvWOXR7CetQNoa9MYz7guCckHFHGaXAjmG2EMm6mgpEGjq6Vr17M4fq8/q2elX1Sp+S43KTuDyF/Kxf/Rop/BgY2IEbrfu+bLdUMauDxHN9vKEXDiAzK+iHfxE8KeOpsjBf9UUHi5gi3MRlVvQtjAhCrAPHZTrLQ4hXv9cgXscD5THLMySAjU8ooLc0NNlDG1L60viNYCeJNLEM/K8m6o8cagsTYni8KcDvD4OzcRsG7LbEhXzbgr6+mqvFbuhLMQCenwkhn9tvLgfxGqGJ7Wr5sbHMyTm8U40jBWaDru+SX00NBUwSOBA3ucSs19MCifvMI4Tz433DZqgECZ9g50ok74CMQem8ahUf5KaOGCAUtek/ok46VpqI0rEFvjiLhZg1LXlX4mTH/EaaKeZZbvCQuXjcChhfGAaV4ZVXbJoZ6oc5p79GOOILXVV14jMUyCWkKiR83YJur4Bo3cjQqNfUEwIYOcIlemxXc1hLKGCJCp4lkDakMm83EQPnuS94w88QjC1aXKbXF4ucl5+KE7FgJVOGqzcTK4KPInwXtRCk4kZn/H4eSJ503EP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WNU/wre+jHIk7KxH2Y/C2kvuecsp+loLNyCRqt3NotNpEgB3eb3KfA/BVAEn?=
 =?us-ascii?Q?XPAHH1bxdi0P0PftY9tt1tXMwkFyCcConhcF95Y6MozQYZjB/msEdWYnLD3+?=
 =?us-ascii?Q?RndhM9AfzSd1VW7RpgENe0DG+4EKAIpEBMMMk5pZTKTvAgL0CPyqT5dyUrzm?=
 =?us-ascii?Q?a7I1YBZMBMW7dnd3SIl6MsMnIEQ+rj6+TusxX1gyBY2nPut0+RXLypETaVGU?=
 =?us-ascii?Q?RbPuod3cho7dCYKhNY31JovXiaetTa5sNeumMf+Gc8eq4KpW2rUnRAzUA0Kc?=
 =?us-ascii?Q?CECTLQDGthxR+Xjnt9mHzFALMfpX6jwBXHJQuC2YEoyLIbVSimpMPo4wc2rW?=
 =?us-ascii?Q?GntsKPD5dHXejgKyheXatf2u5mgQIqPl24y4THSm3SQcKKALBzcVAa6BDIqq?=
 =?us-ascii?Q?Y02iWXfZl+lnucfKe10F080q2jJVQtjLcezOYW4Qu386USLd1QiYqN77c6fh?=
 =?us-ascii?Q?YzCutw558ao9+YtSYYj4MbHoI0DfchtHCJNhuW5aivS3+VePEMldPtRiHy1p?=
 =?us-ascii?Q?4bOA2NVOsDTUdvx8Sk5y43laCh7oO8JYjfRjcYNPMGQR+VaA+QHFwjAKweSc?=
 =?us-ascii?Q?V+XcGimnti9jb0OQsQbpIP2G9miKFmPcPPObxWMr2SwzPSoExbj+ygkKSXCt?=
 =?us-ascii?Q?jm1P4wCEo7Wn9EH6RB6+qbpZnoUslXB+DksBLt8c0mxmHfNn4vCAPuX71acv?=
 =?us-ascii?Q?KC547T5ocoUgmi3zQlnNFxPu+LxQ3tnvI/3fEMLSUGTb0AeWJrt5QftAkA2H?=
 =?us-ascii?Q?JzXfACQw0m3YbAxmdPrN4PbIn3ua4O6FktgKp2dMu9eEoRwxgkScylh8ZIov?=
 =?us-ascii?Q?XzNvaKFLrzuw1QXBG1AYGXCUIPXY3sekdLMJcc72tIO4IjaNLTw4f9TJaP/7?=
 =?us-ascii?Q?DXgvhGTit38nd6SCXrfWMk6HOhQyYqaRXI8BzKX407iTrU3PfmM4D31s6dHa?=
 =?us-ascii?Q?OCxgIZ/lazwTVDqajTcd+8/b/PZnL5VEamH47/BcJ+5HXxkn9qCnwVvtgZV3?=
 =?us-ascii?Q?R9w8VHiet8qDOvLtXHZIJUsFLfW1HCKtV2gqQNveGpnhhDUI5FRSHOVK/12a?=
 =?us-ascii?Q?5w7SJJ0230M0h3wICAq4sDHq+NcaDOy4Ah9VjNDOI59cozwyLv0Vxw54oxa+?=
 =?us-ascii?Q?aB3n801rhLIjp3B3sac3WMu/yIBtyAhl53sF04ekhtd7qRrEA/+qb+aZ2j59?=
 =?us-ascii?Q?1VdRDASS0woQRuIz6YK/00Zk5xZV5eyO4wA1tsx2xIeaY6wmh0UpFaXpNxHy?=
 =?us-ascii?Q?fmLXAiJZmV/WVd5N0lgpV3gbpPBxK4yw9nNHEOUk3MyrWBN+ppINrKkX6JiA?=
 =?us-ascii?Q?fZSDrdqdms/1+E8l8ZiDpFsqgp1du0lOcPks0whPLVC4Q8U9QpZZThdj3x0M?=
 =?us-ascii?Q?TYw+MqomreV2EwntQsAcDEs1lAsQVE01UxGZ9XpEbAO6B1q1Y249xXS+eWmv?=
 =?us-ascii?Q?bjT//mohcJwV/Va1s1ccdlk8y+IZF4JZpn3kznOKwAvWpMDZMLRJFrlgBPhN?=
 =?us-ascii?Q?gbN8ghstLnkh3vpx2ogO5UfZCoNt/sAPnFFR0JY4BP4MAWoRaaCmR32caQRJ?=
 =?us-ascii?Q?5kOCgNij40oXvPrjgE9YXvDupwy+JSj5J3IzLZ2jTOm7wj1ojYLnhuR15DY2?=
 =?us-ascii?Q?+mu8jF6msHPsRL2Z7Xti00d1S57ETAyfsqnltbM3HyxOuEVoKMUWi/mVoGIH?=
 =?us-ascii?Q?LMp3QkNvO/mwaaQakoekF19zLI1DL3FpGnl7Qj6+hts7Fb18Ns4IkjZxxPms?=
 =?us-ascii?Q?5SDT27QxhstKNdTV50G1j3gTZ29BppQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: x0p14T5WfCeoaiYXtuPz0YRn+lFLNMWLS3GO2RRPJSkad+u+PfIVytET85x55XgtXv7h1p2TPfc3z5ideXnHCCa1+usdpBDtUiQiex58j0um6rB3/ipQOMI5nwgV+c6+5eqP89g3OEduU4AfKL6d2qvfgqxXalCi2+RPqfavkO283FYaQc0Mj6WCA5+sImzT3eNfBRKQ/V8DPkyAYwegCZS4NWG1bXTpP4biFE4eKewZXnZcJDpSsLGmOJrO8QfrTnEjGpOxtHFflq1I5LC06EXeq9GNyfevSzqOCcWEQbMph5VlSBF0UT5ubOx1xWG2RYYfsGSVVJswegzT89xhlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e08300-8db7-4e85-fdd2-08df189a0983
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 11:09:57.3164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQFNL1AC/1qELRtyjUfOXPi0cp4MqdW+jSEcH2QIHwRXhTl+hJJpV5x/spuH7sBbDGr6O01RRufm+YgazsPIv7mRQ5mKHfwrZELxsvJXtRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> Sent: Tuesday, September 22, 2026 12:09 PM
> To: netdev@vger.kernel.org
> Cc: jiawenwu@trustnetic.com; mengyuanlou@net-swift.com;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; leitao@debian.org;
> weirongguang@kylinos.cn; u.kleine-koenig@baylibre.com; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [PATCH net v2 1/2] net: ngbe: propagate resume errors to the
> PM core
>=20
> ngbe_resume() declares err as u32 and unconditionally returns 0, so
> failures of wx_init_interrupt_scheme() or ngbe_open() are silently
> swallowed, and the return value of ngbe_reset_hw() is ignored
> entirely. The device stays in netif_device_detach() state with a
> broken interrupt scheme, the PM core is told the resume succeeded, and
> the netdev never appears in the networking stack again: the reset task
> also bails out early on the missing
> netif_device_present() check, so the device cannot self-heal.
>=20
> Fix the type to int and propagate the errors instead, making the whole
> tail of the resume path consistent with the
> pci_enable_device_mem() failure path at the top, which already
> propagates its error. If the hardware reset fails, the remaining
> resume steps cannot succeed, so return early instead of continuing
> with a broken device. A failed resume is then reported to the PM core,
> which records and logs the failure, instead of being silently
> swallowed.
>=20
> Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> ---
>=20
> Changes in v2:
> - also propagate the ngbe_reset_hw() failure, so the whole tail of
>   ngbe_resume() reports errors to the PM core;
> - drop the inaccurate "device can be re-probed" claim: the PM core
>   records and logs the failure, there is no re-probe.
>=20
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610..e8cabcc84a41 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -954,7 +954,7 @@ static int ngbe_resume(struct pci_dev *pdev)  {
>  	struct net_device *netdev;
>  	struct wx *wx;
> -	u32 err;
> +	int err;
>=20
>  	wx =3D pci_get_drvdata(pdev);
>  	netdev =3D wx->netdev;
> @@ -968,7 +968,9 @@ static int ngbe_resume(struct pci_dev *pdev)
>  	pci_set_master(pdev);
>  	device_wakeup_disable(&pdev->dev);
>=20
> -	ngbe_reset_hw(wx);
> +	err =3D ngbe_reset_hw(wx);
> +	if (err)
> +		return err;
>  	rtnl_lock();
>  	err =3D wx_init_interrupt_scheme(wx);
>  	if (!err && netif_running(netdev))
> @@ -977,7 +979,7 @@ static int ngbe_resume(struct pci_dev *pdev)
>  		netif_device_attach(netdev);
>  	rtnl_unlock();
>=20
> -	return 0;
> +	return err;
>  }
>=20
>  static struct pci_driver ngbe_driver =3D {
> --
> 2.25.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
