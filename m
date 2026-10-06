Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D5372B41;
	Tue,  6 Oct 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273751; cv=fail; b=en9s1CZND5i0tSOjQFPm0MYlBYNJa3JGcmBpN80B2yfHs8OHcZEWcPSh99P2/q2dkLROtzN9LaOZ3ArPzn6F1GrCLk9RTZKTuFOoYy3wBnRjQqdhtgLsUeN6huaGRJe1wyPbEpwcwE6YHjPL+6MbF71Kn/4pOOm/bDF0F4sadHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273751; c=relaxed/simple;
	bh=iShV5OAPd/i0VfDDAQvb9G2T8SUe8z6gr0LCbO59iF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ton7ixa2+tVrlLypUnkOsWiv1QC6uGEyftNRKXZovMS0ILbXv4Wl7/IMRdxze6yuQGUiGxxRB2P/EXAt6f85PO+IwU5uu9lbUYpwc7vJH+SjZO5sjGFm3kPcltqDVZgwHQalJnocONSaO/MFgRo+H1ucube5rpatO3nZ0IywWKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXe0gnAP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXe0gnAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791273749; x=1822809749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iShV5OAPd/i0VfDDAQvb9G2T8SUe8z6gr0LCbO59iF0=;
  b=UXe0gnAPKm8Kz2PZpjkQNV/fYRzgp/6LIkEXxA2gk4lHmnbjyeP9imqJ
   Vn8iF6+3klinPsfkplVnXNyOB2FXHDcjRHgiO1yw4VrNERiq/pvq86izu
   gu8ik1181RfXe8XweWw9yXVXspc4XAIIn/r8iKUq6FmLrWQVrJO7tFhz1
   IB86uH8CRRd5xnvp/dm9OfE0f+y6yAuGsswl1+37+V+5UEsD4RmT6zGW9
   MwXpcIQezr6gtrFkq1Sf/dmi2sM6CdCqnhJcmE7AgeeFroMXpprYjqubO
   W1Lq21HriqvwXidGcE5I/AQGxVJvfjnnb28sVtPgEid00HMfT9CA3GYgt
   A==;
X-CSE-ConnectionGUID: s6W+QWAjSj+qsfA2vircdg==
X-CSE-MsgGUID: kHMnUOA+Qg2sCN66jAMamQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="9772"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="9772"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 01:02:28 -0700
X-CSE-ConnectionGUID: GV/bJ036Q1+d753hPT46Eg==
X-CSE-MsgGUID: 6am69iYST8eWxC/xNj+aZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="281863313"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 01:02:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:02:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 01:02:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXVdppuL4h8Bu8xlM9DeLUyV9D4mYwDpSyGXZiMNoBJ1nbpz5c6qjMwKow54fY4AiLRcjD4PWLxZkp6v6/7Vdna+r4/As0FTUp0seEZR91bjrwwL4Ntlwjj6tXJvNsq9AiheFeRPNGjwGIoKAbBjfPxbNm7mO89CTE5URBiKkvkr2jmRtPA9LlRfKkdEfezM4ZsOKWVR0AgZSa2lPNV9aWlBN1P4Ra2uQgzDtGYkG8hKPYifnrqdIFAPVlfyaPk4qJ8j/wmlACwAZTVWJqiapqV3YwRf/llSscgt9upxv5bk47UAy1mI6gnj9O3RKsncT1k+WDmkWOCnj/Xh8rWzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgZveKb6fwUUzGFWM/+uIt+7QVq1cgxZhRUWX/1+Q6E=;
 b=C1sVTX2kMzHF/xHqOUit8COJ7dk7f0fNhuLxHU/r9nDnGXDJKP5iZkEcp7Rl8NVrypVeTvi5OMHQSp+q8LPcIr9FFoBxxLEL19i1PS6vD6vURJ8KALcTQlb2GEDZVHiP5N3UHUOmg3fV3Z3/MB8VgVJWWY4QKxd8lSEZdpzlFfCYQgo5/DFgOQaQWXPg+JkSdE4x9XICqm+OSQMDPiiohpPF2mv4ikLb+A3tCMKTpICHkvn/ou61rueIo6Sj7J5Rhwq7ZG/Omc2uM8eYST5jwh+hhraPYKtERLmtbK6jIGmBU0RaXdwYTqT0csQHZcvTgg4ZrCci3gFMHzcLXhCzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DSM1PF8C3EF9610.namprd11.prod.outlook.com (2603:10b6:f:fc02::149) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:02:25 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:02:25 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Joe Damato <joe@dama.to>, Wentao Liang <vulab@iscas.ac.cn>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "sln@onemain.com"
	<sln@onemain.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Topic: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Index: AQHdRpXAvvswkXsWq0yPUwugayVj17bmXXwAgAnnV8A=
Date: Tue, 6 Oct 2026 08:02:25 +0000
Message-ID: <IA3PR11MB89855391A93351D625E893378F952@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
 <arxcOtu89COHAncp@devvm20253.cco0.facebook.com>
In-Reply-To: <arxcOtu89COHAncp@devvm20253.cco0.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DSM1PF8C3EF9610:EE_
x-ms-office365-filtering-correlation-id: 7268d8ec-cbd3-42ab-b248-08df23802871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: t0QlzkeuUYU39KU0SlpXsrQNJAXykYo/XucEv/H9oU0UpLTY82xfIB1gsbjOYZd8UoFaR+VUBwXEvkVlM9cHwP5KDXwFsjA+QX7lJcYpru9JufYS+5lW1W6Wu5BVBfk8sYl5cKZ9ELrNNFd1Q0Frtoapwm0nK5XyebTCdDrFpN/6Tkm0y/hUbQn8OrDORcPAg0gE+9/6LQQXm60XUs6NkAS7MXtWu9dEetmAWDUza4LAHu6NNhxt1NCYvO+VdK3hlg9jEHUSBO/CCt4CM+XQpzxq0juVoDj9ytcy+idVID7AxGuGwCHA+5Mjs5NQ8g8K0a+W1VzQhNhHbgXr0ccBGpTWtXQi70W6MQaPbNIX4xA3q6ogaSaEVipyUCbOPghOTIL8mJX4f1Ta0v0+LrsZpIAdjyNKrqS7BGpVlRYC5GLAaz/00Xj8QKekUDtPhJuhe4ugu7hJ8oziHL1VIHLdHK5lqaL+4DtqhLxScq0RNORDXSjrMUIz+9erT769ciSlrWcbOYtRSGbF3hwxSO79enjkcJywgL5MwTMGzB1JNb38wxmd7pS2wCJiNdWln5CQHdzQgYsS4A/IrmOZLLSQqHJtCwHXfGj3Boe170l89awq2ZFGVucJ4TUFCVlUXYqyIPaAoe1+sOoxRMGew96+UWclXaFrAPft+xfdoGmjiP2SNSD6gUBgsOw5RqEqXE5xNmAUqSpNAa+2ibqoP3rzt85LXJK8+hYfxOp1q/wnnLw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0HzzxcEwykBFcnsiG3i1ODZVzXNzCHMBR9b4wgaPFoeZ9yugb9rbyan41WTt?=
 =?us-ascii?Q?/gKEN8/xa8uXzNTIOiCD4uQx7iEKsKwHgZFOWFzlGi0GJxsl90jChaii+aoh?=
 =?us-ascii?Q?vhPos90sweUWrGmc7YKH21HJMp/58hWiK0ryTUuNqrX8A4Pu1lI2XOR7EbW7?=
 =?us-ascii?Q?T07+5WmRN+2DVrttghsWW7QBul8bkTve3FKqydUPWbcIr7S0JI3MPpg+5Rkz?=
 =?us-ascii?Q?92Qu9oDlc7/mmR7viwA6S1QdRIsA1pdi1T1lr54SPXPoqAx4nyzlzRGNofrP?=
 =?us-ascii?Q?KBboJX9AepoanB60Cbe1UTKdsB+wxA40+82xUk8idJjbfiUIfLDvcc32Eirf?=
 =?us-ascii?Q?5rMCLMIUrGIO+K5f0M2rwkFrvUSZvK8MZRW3/Wr4MH67U39lGKqYR+3Yl8O8?=
 =?us-ascii?Q?tTWJ2F1OR6wwBm6PMwc12uYsKMBFQ7dnDIpF82MROP80T73lL+MfZW2w+3vD?=
 =?us-ascii?Q?M6SW4lemmY/9Lz1NPk/RyDs7NCAB9Pl+HNf5KhSfn5ltpF7TLV3vPKilx4rM?=
 =?us-ascii?Q?g41yDmnuVcMX4Sedz+JZ8wag8hH97+AGhQvTeMhR6rkmUZIPSWVLM+Sq/Zwg?=
 =?us-ascii?Q?lcxckXKuvwmm+3w+F0nEbtosKN1h0HmjhcK+kInows0dgCicVaWmIaKDYLyK?=
 =?us-ascii?Q?ZcpqeYER0qc3LCB49RwdTJtGoPkaY8zMLRgP9tJA/e9TwQnkgZ0Y25gytI6n?=
 =?us-ascii?Q?Uph4DNyXX7A0hukTq8+tOqKzJ7XBTEZTnBvP2xKTX4kt/qTZCBNQ9Uc570j8?=
 =?us-ascii?Q?MKCIOCv9/B2nTpmDJSLJ0ikrsfa7oJAQImuo/zrkVerLQQCOxNyZr/JxYac+?=
 =?us-ascii?Q?OfZF9Niqj82opkawHtwveon/hDtbTxS4rgYXSmRtpzgXOwC13xYZLViGycS1?=
 =?us-ascii?Q?Qo3FrVQj7b9PN+Ho2anHmZZ8d1cVHQCHPtC3R+bTAUmm6Zi12jL7KV+noUwz?=
 =?us-ascii?Q?XGEFwf5UucG+fgC3yS7zF6uaruo9NRZIZ6AnRQLcU/0bxOnVCvkykLawZy1H?=
 =?us-ascii?Q?jFXn5e2EDIGcstFFC3x0Mip0JSMyhqdh6N/e0YXQdDjtkyyP4lrZutYGJb96?=
 =?us-ascii?Q?iefHsyAogHI65P43OHvjwowPOtlQl6a2degutb6by95FNyWfD+h1vcyILRDS?=
 =?us-ascii?Q?lEHj7oAUDt923krtwztjpnnrKHBDgEJhyWFnZSMJrXIygZCmOEtP+Zat3nV0?=
 =?us-ascii?Q?jR2rk8u4EiXDAMZHo4wKqBdHoydXH+8l8NNYAp6ZWGW6g7PILM6A86XAK0O3?=
 =?us-ascii?Q?ki6l6+gzu9mvA9uiNbWCeyz2BusSD/tYB5iGIYDeL+AgHFKV5cmfLV7c9xz5?=
 =?us-ascii?Q?bdWneetYURaRwRX1AqyS9lw8QgK3PXLpXZO5q0zj3TKon76jqrPE1BPIhjEj?=
 =?us-ascii?Q?KVwThV5opj4RtiBZahOP85GMMsfF691ilNa2xXAsxYf0Sr1bjYBZEQSiy1xR?=
 =?us-ascii?Q?0XdJlhwtwNYciTas+5kI6ob1l5UgP+PvMIp/7LlSE0cwQilsVTbXt8cqwY4/?=
 =?us-ascii?Q?MERLnKBw6bk1pXalLFb8tkA7BRirVq1BzeY7xcr3Xql6N0WgzgbXBXAKZf3q?=
 =?us-ascii?Q?e6ehpFvukZTpMLFGDz8rDAolkibJqVa4Nn4ISKewntQODfCGu8qZZ1Pg7q7c?=
 =?us-ascii?Q?cUg/MQio9eFcogVXwi0wK9fimMa6nMfuhkui+mJ02a+6VjH8mtDjxfvvYOHv?=
 =?us-ascii?Q?L/q9lQofbKEkq6YsLQHQcn7F3Rspn4i0HDX5vRXsE9fnt4KhMT5EUp2Xkeyi?=
 =?us-ascii?Q?cXAv0Yg3vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pkDXXOOMpXQxiiRcGeIMCoB96OIFQmjvNU6OuRib48BQgfA9ug0ptUacSUack/Oj711B56C3UnNXgCrurKTez4v/J/ezWGTMAOnaDNv026r8wKcIh3BP0z55v8mS2KanY28n0DAvi3HxBf8JzBElmD99+Z8mpePODC9XTp1ocPAWmhaQqQjVaPpOXwUwApZlorfSam32GUVMWdX2ctzmxnJraO2U0Tcqu7uRF/CtGuHhucokvSq5itYsidV7lXZf3h35g/zO2d5DC9Wz9M/jj9y6rb3vtKTGcWLYy51cM505axe7DIgdGeQuaztxpxeClaAcaMLERZLdMiYjbmmVZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268d8ec-cbd3-42ab-b248-08df23802871
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 08:02:25.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J8RuYhu4HJP7xOPCOS+r/MLnA8V6K53at20Y3ZAog80X3qZvvsGLy0YfS6wHob19SNS1/3Q2YeiBzbCvJchiTW5CMlp5LtKjwEYGthZ/VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF8C3EF9610
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Joe Damato <joe@dama.to>
> Sent: Wednesday, September 30, 2026 2:48 AM
> To: Wentao Liang <vulab@iscas.ac.cn>
> Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L <anthony.l.nguyen@intel.com>=
;
> davem@davemloft.net; edumazet@google.com; intel-wired-lan@lists.osuosl.or=
g;
> kuba@kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> sln@onemain.com; stable@vger.kernel.org
> Subject: Re: [PATCH] ixgbevf: fix xfrm_state reference leak in ixgbevf_ip=
sec_rx()
>=20
> On Thu, Sep 17, 2026 at 11:14:18AM +0000, Wentao Liang wrote:
> > ixgbevf_ipsec_find_rx_state() returns the state with an extra
> > reference, which is handed over to the secpath on the success path.
> > When
> > secpath_set() fails, the state has not been stored anywhere yet and
> > the reference is dropped on the floor.
> >
> > Release it before returning.
> >
> > Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
>=20
> Reviewed-by: Joe Damato <joe@dama.to>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

