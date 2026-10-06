Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5A3B14B3;
	Tue,  6 Oct 2026 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274449; cv=fail; b=B9VQVn7Z8edf0BzdLtJDqLGQi1qC6/vJm7H2FfSEeWP+Bq7c4hflNJ1LTacYW21uZ9M9vWFrHwYxyQ6WNANWKdSR4WbPjjRVXT9IyPD98rnFy5W9j2L5Jm5s38VAVzGdLWTX6+YAmQ2DD8MpYJwtZfyv8Fxi1tHz1a7VlPJYnWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274449; c=relaxed/simple;
	bh=3RGOESPlkfnGxqRVow1/tA690jJ1IIcqqRTnYDdjQ1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FcTcdZTUiD847Ay+6ZDyxCGv5FpkAi9Ayoe/ZgSH0Q/SRRvQaIVsHBjNldvLwk36cb6lbJyHbCYMSCXeFO9yQ3ZMouiURHEamsewnbXCGFxdPvYM4IMJz3/XWy6SbDIidkbsomvwbbgvmpiY5nmqAzRHdpOOYUCWHVlQ0pWUxXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8AJIekj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8AJIekj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791274445; x=1822810445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3RGOESPlkfnGxqRVow1/tA690jJ1IIcqqRTnYDdjQ1k=;
  b=M8AJIekjxy7qe3xjzmE3lFoofNl0IjvGU13Beu+uVgWBbH8kEg6AIfWP
   MmtE4HZIyB32m5GL86as3VCHr9fFfy3Elv5XH/9cErZT2N/cgPXp+ocBO
   pwVa0SsiwjOrugU0E9WbVfNT1dL7UM9MKzVQZKwjKdJu4w3G1+x99k0SL
   RU3QWQBu2KhfXSQ+hpGgtLbP113dQtwM+2VcRM4c7q4/juNqj3V6BW8DK
   e3ulU+bffG7sjta6D1opMN5IJ191z285ZrFrtw7mUkFd+DhVWO3XWfqc2
   YlGBJ54jlsMBzMSj6ahadhZjZsbXFy6UnLN03lFusu+cHqVOkcLGbU24b
   w==;
X-CSE-ConnectionGUID: Ky0cLMPBScGaAEdKeIiaYA==
X-CSE-MsgGUID: LSAf1X+1Qou/s4CRxoPBvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="6973"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="6973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 01:12:44 -0700
X-CSE-ConnectionGUID: HBY/7SRoTvGJSukuo3ojUw==
X-CSE-MsgGUID: OEWMNXwkQECQvEa2nbmlQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="275738773"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 01:12:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:12:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 01:12:43 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:12:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpmocVwDue1s0TNt9sW9859x9swnQr8qej0nNkbtJYzR37U5C1BYzYl/f05t6JS9AApUpIv8abrsm7GDsGrbD3CM2Yn6CEeh04GmdhuD//OpcZs+TWqyOjISe6xadUQIsGvkvQJ3zD0e/voklhvIhzwNUwt8s6LseGpVuKqIhyr8jOV7F9SjdWP7RP4ow1QeJ0KR/EOWeqajSfkIP6dnh1HXShIOamQLEqcYEIFqps7DZFyK9b6VIsufUoyG32ZdZDV8CX0p1rKSdx8vrseoGjFqy8lCPa7cuUGLUTNBp6NE58sLLuQtcN2SM36tfaiye7pyicwz+4vtOv76w566Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RGOESPlkfnGxqRVow1/tA690jJ1IIcqqRTnYDdjQ1k=;
 b=zVjwb1Mht5K+n79YvXGCt5J+LWgzYDY8872Q4SC13S5kRS2ADWWpsIwRiWk14MlDxQKkfCWHsT61H/i4m1IOxEUYW204KlbZKNcir3FkA/9gY4dfjk9DMgqzKEFm74On4C1nrXyPiGR9WW1POGo0vW5ojoNfryfk9niRuNmC0Mnzri/3MlpkVE/G022AGgWMhNASOihq6TYEPMBiT6qACXuZl2EUuvL7paHHNVgtAGl0g/KMLEoJ58YNasp6Hykn/G0wMaKp2/7d/77tmlDOOnkRDafVccAsGWN0WTPfYmjPYe04G5D4L1UgOum3BL4x/QxMQ1/6sXyiaU+yYUtOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CY5PR11MB6212.namprd11.prod.outlook.com (2603:10b6:930:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 08:12:40 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:12:40 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>
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
Thread-Index: AQHdRpXAvvswkXsWq0yPUwugayVj17bY3IiAgBdrG9A=
Date: Tue, 6 Oct 2026 08:12:39 +0000
Message-ID: <IA3PR11MB8985AB2BA9112104BFE64CE88F952@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
 <20260921103459.GH13925@horms.kernel.org>
In-Reply-To: <20260921103459.GH13925@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CY5PR11MB6212:EE_
x-ms-office365-filtering-correlation-id: 20d2e814-2635-4500-c117-08df238196ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: N5+dqJwLou2nQ56UoqtEU/6TUN0AGUSWjNKMU3Qg/8/IB25aYTjHRwMmpMY/xxm8aYbx0brWG/Edb81UrwJxZkekLY6Wh4reqRPxxTzIZHCNPKdxykv9ICkhHwGn8+KezRKvSJdStySngYNhzqcwXzM22//xG0JXcf9iTJcqo+LGWLjViF0YzqShyxwQYtmUDw0AMVvwhvUIfy++ySeASQGdX1niMvlAXxhP4Vlez78WcP5qmaitAemWGixh1vFbT2GFRbGbmMVfuswP+eylVkapi7k8t5d6d8Elekj9Y+8GIMjL1dVY9p0QrM2jdN5SBvycqxlo3xgpgDj217djMO40lllIiMBvRHXk4z2yZl/epLqW9RoZHJEcClRPGnvHwFgyO0kanvTnzaNmIDuMPRl/987XV0GFUBpEJZ6RVpYk57xOvVFMvxJLKrygGZukEUu1WqS8y0UvyBauPNCiyGUThSompmsGQedZIoduUnafMruye/okFh+L3NHR8pSIgGzbHnz7j9xEOEmxcTNPl15Os6PUWYqNEXHNerKNgxF4a5q9fbsb+YRX4uzLv/XtQs0RyhMgmaL/XX448nhMoKs0Z24+AO1v/8ACXtU+zZiMZwHOBaPkiu53gm4ZgopBKYKnJ2z4e0dVi7Z0WwrvZvdpxURmqBuFnJ5zygsT+fe72MMQHboapSnqzdbMKCA1qcejYtwSOwMsuTVFOxo3Ek93NTTMboAeqVcnoL2/yEI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h3zTtXJ3ql6pRmpYOB1Yw5ERJ5vU16VAGCYWpfO5y0sx8Gi8vECO/jKYrTuC?=
 =?us-ascii?Q?bzY1YYBzuGIhS7Zmz7YkfKkjh/Aw2D9gIJx/yewcTzpbHlLd+DnVd/lVoNsU?=
 =?us-ascii?Q?bWuBSeoDPLYvTRK/fS8eUJwG/NXJ20Hvp5S9dYs0fFtVirJbkk5QrZdqhvsd?=
 =?us-ascii?Q?awwEaJu9YcC/5NyVK8kGqd/D4kLdm+gRWEfSf+PGwe/VjKbw9BMP1paj/qWF?=
 =?us-ascii?Q?qnNAPGNKfBMMBriiPTcWn9mdV76dhwODbqfOSFFjtcRKf0Z18wca9ucZAvwR?=
 =?us-ascii?Q?HUtNTabwzl5oAaTAstaNUrrDHhKZEeychPKal9Qabv0i26gPCYnj/xeoZJso?=
 =?us-ascii?Q?eOxcpUg/19vkIAjyJq2KYH/u6WLbHtMCen5IrKPtdd9vIcrMxDj6bXl9jZsF?=
 =?us-ascii?Q?KyNsoK1dcY4jCsZUUdQqxMoR8Jkk4DHV3a1Ri+P57l9PI3O6FNnSgOexvPbA?=
 =?us-ascii?Q?vF5koPGFalzvMq1H4TTYtMFi9nWtn7qptBvMwFClXXEk4kHtOKHYDiS1iY8W?=
 =?us-ascii?Q?j8q4UYqcQMzg/taNze6MINPCKBU/vi2Hs9PnreJtvIKaAmlUDeiS5x7/LmTu?=
 =?us-ascii?Q?a0QZRvIQBfZqBMil+YEvUne8N5Ss5FnAUc8U1ExabQQOxaGBEc+lsO9ZE66E?=
 =?us-ascii?Q?I5D6VRDIftFqJGy51whCxfBM7hUW4tGvOeW+Kx0exCofpi4BA1Fkl7++cv4D?=
 =?us-ascii?Q?9AvkdLRkmBjal7XQySBHLxiyJQJKcxJWTuPp7v6WAhlkO5mwTCK/ytOID1F1?=
 =?us-ascii?Q?AQmXL7NLg5UeEDSIIGEmj6rpQAGUAwxHu83LL0+wQIwr0/Cu83wBmWLJ3MZr?=
 =?us-ascii?Q?/YonQwEABISVbH7D8yqeQyJE+MFBxtGQ0n1SkANYG/A41Mu3RPFYd3ibxMpb?=
 =?us-ascii?Q?meSVB45yex3ZS5OE97PzhBeqe2rzaoo0G8F0zYzQQm6JvXnz9Zq2afasOOYX?=
 =?us-ascii?Q?au+ITMsZfUs0rbkqMdYaJl3xbc5rX9s08Vk136qSf2vtBotGR/YqX6O7v3cO?=
 =?us-ascii?Q?UKSGmSiMKn/Abgfsw2FqbvR+T2iOs+knUTYdHjWYiDSxYiGN0Uxu42sXhgq2?=
 =?us-ascii?Q?auKdhoz76vBnairlUXeiAk8gVfbaQoVWs6O0PAf4r8Tfmgi7u6ttkgfqWWRc?=
 =?us-ascii?Q?bVpTVgUmQ6UuXPT7BEnCpc1KemtJsVlB1LGoU2c/EEb1HeFTUuH9MgTrnDrF?=
 =?us-ascii?Q?h4tTjY6jstVDLpHtUan6PJ36AK7Q5yj6wo8DFGwbVM0dy7ImmfaSDk3YY631?=
 =?us-ascii?Q?LCW2iXwTPpC6N7KH6BF4VhIzcEjnDhea9AqvbmSCiZV7LdI+ce+NZfxYDHfT?=
 =?us-ascii?Q?xWdIOndi+a7R2W74Cvnhmoobtwa+Rs4MttxjXJ+eXuOPsW9RH/CO+3vV/Lpp?=
 =?us-ascii?Q?/Sx4LNh312nnQorV+FrOe5JAxXdYLeWTloEZEz5UqzoOazr6NBrxhBRVgaWu?=
 =?us-ascii?Q?62nOHcqV++LvUoOMkYuDBC5YC/6Y5WCpvY0jsEpxNoeNGscHMmnIoImmedFG?=
 =?us-ascii?Q?SfEAMmm0xDknTSbjt0JaCsrMiddbyIcP6jSvJd8i2aJtlOnevckEEWhLC1Df?=
 =?us-ascii?Q?fw+ddaJMbzbL4V4L3AVeRq9s98QPKf8WwEh3zZloFhzdOKQ2tlFz662W0/ax?=
 =?us-ascii?Q?ijVgc849AQES59biAycT1nZfos+w8reJlDwgc4dhYsuY/nwXj1WSbtua8PCR?=
 =?us-ascii?Q?BfryCF91YchNKLyboSLo6mu2EYVDKqWfgB+8AEiF1j65sjW+yRllVl4j+xhp?=
 =?us-ascii?Q?dSJmZs15uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gDc96z8ZsRYcljvP/83yhXpShZx57GST+p3kJPwiWysnnAMAyqXMLk8Df+51M1raHFCjLKsx46NnMYxxVfOHxcnXgIsz2DO8gFPWp0EoQY5xMy2Del2k3bTJHXVGK13CbUch0ncctR/PqykfVyrqSm7ZLpC1LYliClthwHIqxF129i28/xjcUFn/d63OFrQJuquOYVfuuSdZMDpUrJKSRRZc3pgDCFKBTDKruwO3wZdgYO+q++N7N9spEgNhaI2R/SwjYwDLx6748JBSry9z1bhd1K+SPy8lsOaSFybbvaIjF93JQoqXM9hP2l+vWBijeqZbbMxTYzueWgnR6aWavQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d2e814-2635-4500-c117-08df238196ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 08:12:39.9283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NObhJrObK/R4UBzyY5pniVseBk78Eb/AOO/S4YfHoR+P+A99cCurIgM7UcYt/ye6CfWJiIbN+DPOmzCbvquIYVlGJrjQ2c94MGsdIV+tags=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6212
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, September 21, 2026 12:35 PM
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
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

