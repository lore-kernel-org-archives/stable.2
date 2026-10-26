Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792980373;
	b=yqvM9ZZy4XNZuFHGth9bRgCIL40vYg7ifvC5HUaAVNPRoO7qK7Kzq9ueqliLmVwVJ9he
	 xJCtMxzsm78Wj+RYXkgLSkxAsm/KM1UxsWCoyNSR1G6HHyEl0uTqf3pspzxqaD/iCNmbe
	 srnS6PrJ2+8wV6DP1g+dJufHoI0Gbsw8+BiPeHcDZnxgdyfAucyP+PYjbY1csZIaNgSBa
	 hlGxQWpVE29lD+H6YoNK75yRPaJPQFDfqT/tT/6Q03WeAF+QQ9EKkz/lCsrmRh7mGkGR4
	 6Uk/h3GCFpojXn0m2mL1mYSudRLsFh+0u5gAktpOB4jmZFcj1paeyNn/NA8YoVq+GBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980373;
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
	bh=2UsODfpjOv4eaQq3M8Rq59ucmgp+OcF8hPn+1GuoOsw=;
	b=aS4qXa5L8ZYX8YwNkIZdHSJInFuHnMZQXJj5Ac9yMZAf9HTNjW8iFKCe8lYi31HMNeJQ
	 wRIJprzQV5MSTz8rxlpR7dYmmgwWWB9ZUe9/0g7MGb5vGEDGwQGH1H/CVzWE81xd0t9Tt
	 T1U3Hkan8NXTi6fRC2kbJtHF/XTSbU/ZSStQIjUJZcX/yNDgY4f8e+ClwyGkqjxZ3hwO5
	 icqR4KV03niBaIcfstt9ksLRhtozuM7kfkfUzPnp5qh0KXJkIhIeR7CAh11wBJCfF75Lb
	 dRjdOuN+80CWucaYW24PMg07TOcuAOZkoQAgHGjOJ0kypBhfUX87sp3paeVPBhebxNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gEOF42ki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F740606A32A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F740606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gEOF42ki
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792980371; x=1824516371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qHeBEUaMYWGMXQylbb7J4zAUNPpUoANL53XgdgO0Slo=;
  b=gEOF42ki+dKbJzpRArGEU/7AFTH1g474bruIEjCAhoq64HU7SEttP4Yi
   FmyNH7sWCLISY2B5cGqQgTif87VQwTweJ1X0dBnUT+VjUVOxUNgwWw7sj
   lQTQuQCbPJj3M1IXq3pa+nXuXdZ2mJbfKwE9dfSfy+N+qHJa7daT2KVNt
   qzybIfauRuOAf/2pum5MRehxSPWa4/ZEicV+PkTrzRrqdd4rt7SJ+wv0K
   2HTYsQtOoM98p08pdQLhnvAMpsnAK0fOqKYmgmagH1ad2ktcg6gnKTjr5
   xvpRrsAUFBGFQOdlyY5z6lOze67oOBvYfttvvnu54kqwPZXYTF5TLKbdy
   g==;
X-CSE-ConnectionGUID: NCo7tntGT5KYUajvIIe/uQ==
X-CSE-MsgGUID: 5YK6EvZOToWLMM9M4IpjvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1512168"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1512168"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:06:11 -0700
X-CSE-ConnectionGUID: oePcJs8BT+OWAkxoQv68Cw==
X-CSE-MsgGUID: qXVvqsh3QWmfVcAr23Rg/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4171347"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:06:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 19:06:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 25 Oct 2026 19:06:09 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 19:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N71ipR1PckeOrpcNmxaaa3yWLmGsi5ZZZ0kgvVYctzIWBKVelAAiT/L1pCKQfeQEESIpgQiVaJb2ljs62y8V01CWKaFsJOFhuKPHBfutmXDSj6+wDyzdnWwb1IrA6aArxZMK5CgBXHmkylrWkoh+Mu/siVFup6jRIHYQYTpCngVSDZ4bzld3PCXAcXdKDAOSivS0D1rTqnUVrVQfzooshdmJKdSKelG4WscJ70y/5k5+jtug7J3KGFgt/GGt4Gm9A2ORBV/OgpbAxM0kL+HAOy3nJJ3CXAoiPQUh4x1YR8sA4okW5qlSvSmBFx8Is8UMuAcMsSX/+JWU7L+bblJ5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UsODfpjOv4eaQq3M8Rq59ucmgp+OcF8hPn+1GuoOsw=;
 b=ppV6W1xOyd5WaleRTT7/ZSzMoSp8+7NqLRge3KG5X03VG5e+0zmyYx7bg2H22d8etmZ53S4H7ZL1s3A6UC5BhS6IUC8TFM6wjGTv3U4UMWExz20OzDj1KQys+JTV3eu6L7Ev9innL/lB3iyqX1huncRu3RiUxEmUxuapzVkTQJY4AuDTbcge95LtVKRNSxgFBZBrONAwqJiFmlU6Vifl02pB/uD2OC8jo6XyPUggAlvC7HfniH3AVnQ7g1i7X7MNkjqNhtvb4GSpxTjFgEEWFXMNR/kjQzcNrJMdvMxaqPNhkmCQwsL8AWEsfBM5sn/Uzp+2i9l0dUWSczLAv8JQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by SN7PR11MB6972.namprd11.prod.outlook.com
 (2603:10b6:806:2ac::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:06:07 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:06:07 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: Sui Jingfeng <suijingfeng@loongson.cn>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] drm/i915/dsc: Fix QP table index calculation for
 bpp selection
Thread-Topic: [PATCH v2 1/2] drm/i915/dsc: Fix QP table index calculation for
 bpp selection
Thread-Index: AQHdZIE64NljReaIcEuXRkJ6/o8xIrcPE/Yw
Date: Mon, 26 Oct 2026 02:06:06 +0000
Message-ID: <DS4PPFE901A304F1ED66B31B87C61281D17E3612@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261016101713.230013-2-ankit.k.nautiyal@intel.com>
 <20261025124720.953439-1-ankit.k.nautiyal@intel.com>
In-Reply-To: <20261025124720.953439-1-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|SN7PR11MB6972:EE_
x-ms-office365-filtering-correlation-id: 18e1b443-5a4b-4fd6-2618-08df3305b261
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|261021121427099003|10067099003|261009223027099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: U0XJIgnjn/tYm5XtMSyw1vAxcXDRk2MOfZTf7DeSisdunkq200nrHXSO2lH/Tr942T1YogPdQe2KMj8ZRUaCqddY6H8wCGBCvNd2WXMR1Kf0f4Q59lI2ytI/6nFvxsNOAf7OiYHCb1gzwwlPrdSvnO06x8EdVNpIcjd2mVAWNKRoqAZhEVIf7GjT4U99SWh3ojt7R/Lha5Q+1wUglrRgMbpDNthFRtwdO38v2U1VeDoeo5K/1t/vJw3BwSmFdVW/7w9uX+XBEuOzNNTuxD/HE991WnOHG+cEdlToUYAFSHTLmJnFPMiV/GQ2G64TrYJjiZq37PNRp5/sQvrbegsxBtVpkUJ027Z2k0xIotNTAscQR1g88RK9tpjeSMBlv3eE0VQQQo5vJ0QZ/o5mPrhKf3H203vLL45ECIMTIETlTdhHubBcucr4WdJ80Iynm8B9DT9fO4pRbpRUBTtVVcTVzDJF0X9KeavXChAdLblbqI8ALuI5G3yssbgDrrQh+KVlLRIRaTQY35I4jhufjutSIKrEZjQ8MpJK+XOvCf5nKlIeSTXMKPw6YNmgaZFEqSXucsSkCkxzXX7qmR4j0HL4NmH9JKj2Uz5YXrHozHUUxCMJyzziXqPS3IKHPksxENoEIHZIf3/iUoKKTWy8fmWoM9ec3SuTpIW8Jy4D0xNebxGHn/2K0bvpsV7cH7okBYrPXVxqeZIKODoqCZUmfFYu9YFO/lBOHJpRN7/IMNWl+g0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dUabuss8u24P5zk5AmH/LeqN/xaYNopyFIyD7Yn+gtov7Cc6RVQmaHq8YIOy?=
 =?us-ascii?Q?WVblAfKMgEh41qkS8kA+RBz8y/HnGY9D5Y7RBDTqXW3MLLUQDybt7PuoN4Lf?=
 =?us-ascii?Q?KUiABEQzfjzDErxJ00DLCs7/KIfdQlD78Zz9IIBHZh83ocHRgh9//Y2sGx4r?=
 =?us-ascii?Q?FhQ8apY9MipmvERZAXXk2kZqn5GR/q3CdI4YgC9K5N3VGspk1rV+z/37apwf?=
 =?us-ascii?Q?RvrHf1H9BfmdYBaR2cqqUUJyHzO94kSU5hRZ8/AuYsJfr7TACD30rnaSHvDO?=
 =?us-ascii?Q?csUmrbaRyLdUy4RRq/bOZsTPMONvCfPzjUlFaORn69HB7XFPGqa3No8Ik2G0?=
 =?us-ascii?Q?kCd8rhRFYQYCQCdI/vao45I8wbcJjvo2WmrlLP6sbHiqWttChwRdhNLcahhY?=
 =?us-ascii?Q?dwldj3ZqI9KPUZhKmIYep6eirAFy57CZYxrmO+sDG5AnDXawR2FZ8tSTHh6J?=
 =?us-ascii?Q?GUy7jckcyUx+cA7xwb8ZxAhUtQgnqbKJ5cFpY4XDEld4kBuJba9mSJ510gpt?=
 =?us-ascii?Q?HRKIz1eufbsTiyukjnJRwSUTq3sPvAMZqESoV1lo0A0vdp6qhNwp7V1LxZRf?=
 =?us-ascii?Q?eJ5nF1IFNH0uenGlRmROBZRGsLucI+n3Yb80A09IGn+hjl+WpRrqIW5WX2B2?=
 =?us-ascii?Q?WS8bLBVabwI4AIO66DoftSDhQkMihJpmFUcoFqMI+7ll7XmxDxdQ37dBYIMM?=
 =?us-ascii?Q?/pV4j9kxdB1m53k6zOSBjtfMX3xaoynrgM5wgcsryp90pi47eIqXBfOFvvuE?=
 =?us-ascii?Q?cwBbcCRUkUBgJ5WMf3ixn6qeW8Zdr4ehkGw/gQQMGisfhrZy6QrJH9q3lOg6?=
 =?us-ascii?Q?g0LdwwU8jVw5wFpWHaKnPrS+C9r4xTgZK+sxfG9T35N2FEWJyv6nMv0G6kmi?=
 =?us-ascii?Q?gClX+nVpTrCIXY4kwYVws4b5g5FkgdLUKDkzXVn7S9fhVPNo6+liYWOaLPPs?=
 =?us-ascii?Q?wzCcPc7pReVORJcEl9TrA+YmBsTkjqKUIk6esVyXzyvVmYtVKVF/4VfNyr40?=
 =?us-ascii?Q?e3y2WT8rZRQnKFuItTwWT1BEUW5BZ6Gbl4JfdEy2WwRBqN7rnemx/epjTBPc?=
 =?us-ascii?Q?cum1hLi5xKkoYvomAeaFM3PfsbCzuUStrXwmexMf7t9sL6jFSPRKqMj90DA7?=
 =?us-ascii?Q?5eJlq75fSJiAVFXB/M0wkNNVhmMPy1bOyWoUuU2i68GB9TlOReBbPpKipOHJ?=
 =?us-ascii?Q?fEb52hdrCWQWrwiGWWEuUcvGCJfHzzXPUAlgiB/H6VRp50ZvwXFI2fvWIOnM?=
 =?us-ascii?Q?j4S1JM0zfJbvpcuUE6K0GKzBHwbi1DQIxaUhtiyfkifmKR8WUt64ikzh5hoW?=
 =?us-ascii?Q?qpa8i4nLCG6ZEURI4k/x2v9+7GO0OL7Dl+3/JlljrqI1sMfHNtK5jfVMsOyx?=
 =?us-ascii?Q?RhQbfiKCw9Zc6kjlCpcwCNNxuzu8b2J8oG7DgvXCVLvIolgY5ItaA/xoGT/v?=
 =?us-ascii?Q?3tbLe1XLulETpdS0nePwXmV63tCY3fa34IT5ye+9el53eTOMKw5rr59Lt1D3?=
 =?us-ascii?Q?IQpzYgD09YP+AEDko6ba3TUPSw7pMmqkoZWV186MKw9leBNsXTSbP1lwFibQ?=
 =?us-ascii?Q?yWwkGTonbTGG9JQvfFCJuqCbW2604oeBi3iZ0dBQSEm7jRd1IEKmLvFR/leE?=
 =?us-ascii?Q?42Q0gpO/IhaiuX/YMEuPIUwWuffbnXfNinJlXgmW5eIUsu9WorzTDfMnT0Zx?=
 =?us-ascii?Q?NvHqT36H5egS3gPBMeu2e+m6Rsz7vKmMYcuoUeEMBjNXkLDLXoWSI85PHSwL?=
 =?us-ascii?Q?OMQaf3/ZoA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: AR8rTPYyUtbA3uvD8vlLNi8iHt3peoNbPWyI1hJckU6i+lLovkuFhIr0qAXqLuNqNIOrojW1y6zvrBqXmKIBwEpFX1XW/9AhbRAmsqqVqMJRKfFDCxv+y7eDFJDCF8bNKfEb43YBBArAqCG2QKzjAwvZG7eA5ailPqKWdc0pFMXjA8rYgrKLv5N5UpWufgcYGG4p9DQDXZLY8akR33sxKi83y4XIndwLPA/5x1iXgi0d24Pi4e9SY5WCiu2M1piGfvkKQ+O/d/lGTpRoADkDppBufA/EJqOESQHNIVWk74wt0bqGJIxMPp77CV/DPCw0gs8t38ly/X+FxDuOFdrp0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e1b443-5a4b-4fd6-2618-08df3305b261
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 02:06:06.9267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aeCamFEHvCJ2xdjvXPRxL6MBoOEMN6m+ofVtESSuJJhVUP11zfq3FqjMXzuD9FZnr6juMAsPljkoxym4I51kUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com

> Subject: [PATCH v2 1/2] drm/i915/dsc: Fix QP table index calculation for =
bpp
> selection
>=20
> The QP table rows increment in steps of 0.5 bpp, meaning each integer bpp
> step corresponds to 2 rows in the table. While refactoring the index
> calculation to support fractional bpp, the multiplier of 2 was dropped fo=
r the
> integer bpp portion.
>=20
> Also, the check for a fractional bpp of 0.5 or more compared fractional_b=
its
> against 5000 which was a leftover threshold from an earlier decimal-scale=
d
> (*10000) version of the change.
>=20
> Restore the missing factor of 2 in the integer part of the bpp calculatio=
n, and
> compare fractional_bits against 8 (0.5 in Q4 format, i.e. 8/16) instead o=
f 5000,
> to correctly align the QP selection with the table layout.
>=20
> Also fix a typo in the native_420 comment: the second bpp sub-range was
> written as 4.5 to 4.8375 instead of 4.5 to 4.9375, inconsistent with the
> 9.875 value it maps to.
>=20
> v2:
>  - Fix fractional_bits threshold. (Sashiko)
>  - Fix typo in native_420 comment (4.8375 -> 4.9375).
>=20
> Fixes: 2df50cb46a4c ("drm/i915/dsc/mtl: Add support for fractional bpp")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Sui Jingfeng <suijingfeng@loongson.cn>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_vdsc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c
> b/drivers/gpu/drm/i915/display/intel_vdsc.c
> index 8f06c3a4d56d..a6556a6e45b7 100644
> --- a/drivers/gpu/drm/i915/display/intel_vdsc.c
> +++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
> @@ -211,7 +211,7 @@ calculate_rc_params(struct drm_dsc_config *vdsc_cfg)
>  		 * For 420 format since bits_per_pixel (bpp) is set to target
> bpp * 2,
>  		 * QP table values for target bpp 4.0 to 4.4375 (rounded to 4.0)
> are
>  		 * actually for bpp 8 to 8.875 (rounded to 4.0 * 2 i.e 8).
> -		 * Similarly values for target bpp 4.5 to 4.8375 (rounded to
> 4.5)
> +		 * Similarly values for target bpp 4.5 to 4.9375 (rounded to
> 4.5)
>  		 * are for bpp 9 to 9.875 (rounded to 4.5 * 2 i.e 9), and so on.
>  		 */
>  		bpp_i  =3D bpp - 8;
> @@ -239,7 +239,7 @@ calculate_rc_params(struct drm_dsc_config *vdsc_cfg)
>  				range_bpg_offset &
> DSC_RANGE_BPG_OFFSET_MASK;
>  		}
>  	} else {
> -		/* fractional bpp part * 10000 (for precision up to 4 decimal
> places) */
> +		/* fractional bpp part, in Q4 format */
>  		int fractional_bits =3D fxp_q4_to_frac(vdsc_cfg->bits_per_pixel);
>=20
>  		static const s8 ofs_und6[] =3D {
> @@ -259,9 +259,9 @@ calculate_rc_params(struct drm_dsc_config *vdsc_cfg)
>  		 * QP table rows have values in increment of 0.5.
>  		 * So 6.0 bpp to 6.4375 will have index 0, 6.5 to 6.9375 will
> have index 1,
>  		 * and so on.
> -		 * 0.5 fractional part with 4 decimal precision becomes 5000
> +		 * 0.5 in Q4 fractional format is 8 (i.e. 8/16)
>  		 */
> -		bpp_i  =3D ((bpp - 6) + (fractional_bits < 5000 ? 0 : 1));
> +		bpp_i  =3D (2 * (bpp - 6) + (fractional_bits < 8 ? 0 : 1));
>=20
>  		for (buf_i =3D 0; buf_i < DSC_NUM_BUF_RANGES; buf_i++) {
>  			u8 range_bpg_offset;
> --
> 2.50.1

