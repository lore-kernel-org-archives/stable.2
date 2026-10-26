Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792980141;
	b=KUNSMsg1oL2L8GWjKo4395UecYpxFjW1Yhz6Hs+1kwVZOAzmHBACvUeWBZqnE70rgP6o
	 +UtpGNO4gVvqYuN7OHkNrEik0fVTl9FFm/MaRVKA7UQStPBgM4DGzTn8yzvgpxHuneHXw
	 jRGlyoPHbDqXACig4uCn9/V1ChiiHEnL9IiynKE0B+eq/EJ1/8/o+esJQ1fK6s17UkO6l
	 N9fXn52d6GDzuW/c5DcnDI/8y9+1OYuAr4K05Cxfe84mb0aIzR/3iEnvQpo0oKtvhVhOs
	 6UokTUxIjx+CckgWS40c9zfmN/m0BirqhmV4ifHO0bwRRFJ/uzM1lSpEPuwOSKwKrdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980141;
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
	bh=oLHR48GYNhLWdREA8MRQ+oR0tecssRHY9M9ShvcKpMM=;
	b=oocintHVJvXsw+spbKlSVjNdjpaOaFHETjoGdnU+AOQtGPIS9P0YnBfCLr7ypcybAIzc
	 ggihLZ2RGyQyfGOE0S40zQpq1Baks5I7hX/XLzi10Zlcq4xGIKoGaVZLNhsa+jEN0N9Tv
	 Sb9Fxy1L4a3i79MZILC6cWyca+ftXNnv4F8yV6zq1cjmXr9AmPWj9WQTE8AmIfQV2HLVP
	 omzS6nNxe23ZlYq/iLKE3zea3E6qO9ZCqN28zeJsexDkMBp3gBv975ixDkGgVikjkb34+
	 1WvKXpwmkGxoEJfOYXM8MKIpk93qIZF+o+PcZSylinYJzB/GGMMGyvMCW50bvw7wFvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h3enCglO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948E606A31B;
	Mon, 26 Oct 2026 02:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3948E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h3enCglO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792980139; x=1824516139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kV5bT7CHrPfov1OmyUP23uPog/C7pvhpmwAPw6bi54U=;
  b=h3enCglORBbl8gjRVFvCJgPB+JWvZlh1KeFrSA5cTaYhoMCRlGCAo683
   pBUdF6ahbu+CG6FaqFyBC7KCGc6ewSpGo1kOXt3cINcV09gqSH+eE0xIl
   Dkwm8vwCtpBs63/6XRZ98A93tulnKI152RIOMA+gd11JAnZZPCpukmPQM
   AY1B9ZkRouTaWb9gppbUTnhGEiFH1mnNAG1dqVR9ysnIj3c8WTmR24k2M
   j4PHjqkoa0aIf5FqkC6+n2gcv+iAYL7+udFKzlgbQexUIb3P07R7JjyZH
   21j3pR3hE2VjJsCJAQDPYNW+pkMld110cO77fH0R0ESfTse5+xtNqOxCW
   Q==;
X-CSE-ConnectionGUID: mR/vhzjAQIm8yD7J773pbQ==
X-CSE-MsgGUID: 6QQrQj+tTous99uEt5UA9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1643202"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1643202"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:02:19 -0700
X-CSE-ConnectionGUID: 2vI1DO/yT5GF0/FwR9y1VQ==
X-CSE-MsgGUID: 5H6ClLmBRH+ebWBlIYRDzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4518647"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:02:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 19:02:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 25 Oct 2026 19:02:18 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 19:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG++XKjPnodRSfw9GyGgKheOh3dKPrtR7Ix2Y1kssPT1XVlQS+2albgyq5pKRrpulnRUlJA37rPVVoCYts5djk/4pjlUido/wzNDVgXb9uGMcuz6UERB4YC2sMHUxgk6zi8KdrUUa5MK6YCpxjI8qArH9wRRxT6YLF0sMSKBuI7mqfYjeAl4x1zlNv/mf3l0LnJovyA5GAtaugwtUq4PxER9CGfsIrLoKG0C4zHs42shHJKkvy0syd8/4Rg254XDgUTWEU1dbIJ/OaPoiOKt0AaOFnhGN8601+Yh6gXQNas7Dv7iydnPmptD75y5cfsdBKICMJPWS7DICllMXp+Xcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLHR48GYNhLWdREA8MRQ+oR0tecssRHY9M9ShvcKpMM=;
 b=a2G2Yk//cpYrwgbJMMfoXkqisQxrL9+A/kVpHVMrfFm5yG1EFPexMnh9xf/Du5t/LcudEnij5lSQNfrUPE/PB4E3iCOfg9qJRyzlYWx0FmZ1mpjpZ9+DfNtls9mDbVdJqI1jSPd43nGIu+XEwQlrt9L+HBFfbg6AtxySiwZw3d3s0Xfsd4o/b0FrKQ++/BYy8fk2HdSSpL+vHHlEUWUoBPiGxkHuPtgiIGPOHWHSEBFTG/utGFDgCYWVy3lyEvFvR+0pxKkIwf8PiZaLgLeCrZkzj0iG1v2HUhief1Uma/uMwoEprA+JOVmj8fdEzkk56BCYJoJcjExZ+EfMHi272w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:02:10 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:02:09 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Tristan Madani <tristmd@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tristan Madani <tristan@talencesecurity.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] HID: intel-thc-hid: validate ACPI buffer length before
 memcpy
Thread-Topic: [PATCH v2] HID: intel-thc-hid: validate ACPI buffer length
 before memcpy
Thread-Index: AQHdZJg53RfiTa2JCE6wg9/EWrLQgbcPEhgA
Date: Mon, 26 Oct 2026 02:02:09 +0000
Message-ID: <SJ0PR11MB7704B237F555C35A667F485CF4612@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261024205850.4051206-1-tristmd@gmail.com>
 <20261025154745.2734805-1-tristmd@gmail.com>
In-Reply-To: <20261025154745.2734805-1-tristmd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|SJ0PR11MB7153:EE_
x-ms-office365-filtering-correlation-id: 679e4562-0169-482b-06b8-08df330524f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261022115727099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021130227099003|261022113327099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: f8CJFB+EvGICdMhlr8Op2b81CR34K3auLhlyJk/baGJTyedKvbfKxt8I7FllxPAEtLiLFtUDpx3NM+1IIhFwVKjiwAkE1MfGExYamKkv/4xloWmxCtXzU1P6nLsCyhrKTzmr3TQEqUejcqixJ8IMj0PzGRD5c+Cdils5ZnW0KfLd0rURjtcTnIgrcvtqDj9Qj1gMYA5qoQhsAVlRo68qUFu560QzeGCJR3Lz3BsJ8K1YgFtRVnDU3wU690GsKAv3U7qwNwgvIZ85f3F4XeTaU4PwaI0NtKd9LKYisBla0agen+3s5Ldq98XVUxoSllW7lH26PcOKDXg1HelGdZOlLiuSSdVt+lmm78k+BB37b/XfOvF9JO/677LghOjsSFQNmKiCIfZxqGunBbt/iEWkX0REXlGje6NjMzNzlcaJv650SSPEfADdR57SgfF6bGHhFvw4ICJUvH0U44AdcY+gbZQht8Lms+zgI9vOyCaXtIGymlHxHWVb1Eo81IiGQBIejV8Spm/DstU+HeCyC7NA55a2QYtcNevKNjmVQeLLP192sve4WSCjZOgA4rh2OMtxBXrfHKNEsWOrOjSUQpo9eMefGErSKJvWzwvHfsY09O2RaHUOcpYvT4/ZNwRFtZDJwM6Mz8T4jrpaNe9C21ATdYhwilJf6tNoXmS5y/TJZbVUBnplAvFxjoX/b9IDw9OxbMdOoAZpXh11VIRcucQ5kSH4WNNp0WvA5dARGn3Py4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261022113327099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DlD4k6UUMhgEnW0K3kYl0OPMqErabB6q/0zuYIY4PWmfBVKVbvusEt/kWvYa?=
 =?us-ascii?Q?rNYXJ/XTaXz5W/4xQlqJYpBU7V2jU04S4xKBk8P+RNNUoGPVx/4WANzx5IAq?=
 =?us-ascii?Q?liTPYnk6D7Qsb292PU/alYcC+S56WI+S6/1+BJIalKEWFurd6oXH/vRBdPUc?=
 =?us-ascii?Q?0umrtPytqu7UvKuAc+5oX/eUcbuFpfeq9S5ggGQVRiugCMwtj4eIERnh1BVq?=
 =?us-ascii?Q?MCWSC8QwdMemARUmPyofCVrpTPmtHs/R0PVtmAVPGwcIWXlbAdrZTPXNwruZ?=
 =?us-ascii?Q?RfwegdHKl3whZRAHV1AZDcRCyJIc5DDWKHh3pkM+l1y8LtcmqHaYO5z9VmWu?=
 =?us-ascii?Q?mOikbmCDlxRQCcVkEUU7cqLkfs+/VDs3OdmXGvwZ8EmMpH3We8fNdg01iOBZ?=
 =?us-ascii?Q?uobmuATB30qRYdma4RR28aZb3ia6+UoR7UpO+B+BDoCK45IO05oOf0i+5bXb?=
 =?us-ascii?Q?xug3TaLTGeZO/rKXWhmylQPi7HCejMuD9mIhcRlYyB3J9SOo0YfOGBRCV53o?=
 =?us-ascii?Q?nLYAaqT+PaxDO2j3CZZZDLF3iBuPSYu45Sx+iwwsfMJ96ShxaEvfflZi3oLy?=
 =?us-ascii?Q?7FhbQqcJBLxMisli4UFE+1EjH02uMLnlSwXvhF4NtZFeRaIXZe35GKdcCKR3?=
 =?us-ascii?Q?Wd1yuxC/nbjh5eT9JXVq/I37E+/KGs2UTFYDNObrbxAStsHNqignR/36ihpP?=
 =?us-ascii?Q?bTu8QxoePvforAlnEIrJXKLV+qGR1c9larNkGPggI+X5DRr7/O5cc1tbY0n6?=
 =?us-ascii?Q?J1YFH5SKCJzZfUWq5TspubDHQgf+JDPGkYDsjQr8BAK4xMpQlNQLKq8Ch+7D?=
 =?us-ascii?Q?BvyhkXpVC7AylsKw4WHXxOkEg+4ufJVaA6ypv+34ygW2ppnKUolnzIes+1so?=
 =?us-ascii?Q?9aRuzP96FXqYcGrfc2+k46DdtGK/wA5MD+R1afEdw1q/jITCue7hla345fUg?=
 =?us-ascii?Q?1QsVBf6/VhI3gzL8UF8rkSsPKcsOBLhhluaqs78EvVr6bEfVlR0o2gy0sK5h?=
 =?us-ascii?Q?NfJf1RkjGC4WtJCPqszdVGmaDa7glw2e5oyzCCGdwvnZ/qh+nXjEOgTyRn/3?=
 =?us-ascii?Q?H3JsJ2Y4YKTHxgh9lRKqNEivwK3ibCkoQJPVzAwGbDphN9PvXXs426FOmFOF?=
 =?us-ascii?Q?PsVRj4xZ/1DfJxjjhw7s9JEju1JFA7wkzkgmWEK18T1sCdMLRN/4o6lEDgeR?=
 =?us-ascii?Q?0PZs3C3vnwaDwrCkdKEMWrhsV6v1C0jaF3cXIVbyeCxMqCNdoBgKoYb7h3dp?=
 =?us-ascii?Q?RBBO5byDmvctFjcuhYRL4aqL4LbDcspLlVGvBVQwdvNYJpNiuhKy2GlJxAo5?=
 =?us-ascii?Q?UgiFU0N+I3rUafIeDannxc+kQ9Ug3LwA/afDfZoSaNQDo9j4ePbwJEWro+D9?=
 =?us-ascii?Q?h8H5jTSbsARpCjDpFh3Iw1c2/XfpAPTdAXbGBHWj4sx+VbOPkM/l35cEwdcU?=
 =?us-ascii?Q?i1jJZ7lewWBl3TZkIws8A+OZbITpiaq09MPMaOO1/puJDKa26gXNs4rPDY3m?=
 =?us-ascii?Q?/cAOzRvPBePqMpmjPccekuVYAA2enmcSQ0iTyH8OjQzvLCTGIlgrz7QGpYMj?=
 =?us-ascii?Q?KNJmMqH8sF5Xr4EwwO9L5x80yUMOMxulQDqCMj0hMb+Vjh0el06tyuLHm4nT?=
 =?us-ascii?Q?2/UGlmwu/FXjL9a3z19UUghVI3b+VvpPVazef/3WdbTxaVedLBN3cWNJGbsm?=
 =?us-ascii?Q?m8BhIqdA+x/xGdqcO9/JkImW6kH9NXKdEy17ewOgPGYH0paz?=
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
X-Exchange-RoutingPolicyChecked: o/CXDBrohasWZRqImzErrrarxCnMd31R4r/h5a6ADNkGn5Vu+x5tT1Mis8jaBMZ8FvoTH3Qdeg/1aZbe6Lc8V422UqndtvQtgD4V8tX0MO45e3S1GTftuNPZGjcIM8hjuWA/MvCX3YJRRMUeL/OKr/Cuk1qA2XWUPmjJtlAsqkoZVinkw7+rIU64ccm2Ihni4r89zLn2rQ/aKsVOqaeUVKFdew2Wgqw/RbMjjOVA7UeZiMISPZit3c2VHCbN/Ccp6pngN9WeblhGQoPAjLtfXR18/L3gTSfjGBeW6yx1JH7D2y6yLslLCJkHKkdnEchUomK8PmVhOyoP5zGWhz/zqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679e4562-0169-482b-06b8-08df330524f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 02:02:09.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaEO0OwDajou/1Yaue0tayjADHl+jqPrsOw5iVXLLvxC4UPOUgHQZ31g28yFpaIlwZ1i/qvAq8LtNfoW6jsUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Tristan Madani <tristmd@gmail.com>
> Sent: Sunday, October 25, 2026 11:48 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;
> jikos@kernel.org; bentiss@kernel.org
> Cc: srinivas.pandruvada@linux.intel.com; mpearson-lenovo@squebb.ca; linux=
-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; Tristan Madani
> <tristan@talencesecurity.com>; stable@vger.kernel.org
> Subject: [PATCH v2] HID: intel-thc-hid: validate ACPI buffer length befor=
e memcpy
>=20
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> The QuickI2C and QuickSPI ACPI helper functions copy firmware-returned bu=
ffers
> into caller-provided structures without verifying the buffer length. Malf=
ormed or
> short ACPI tables could cause an out-of-bounds read from the firmware buf=
fer,
> and oversized responses could overflow the destination struct.
>=20
> Additionally, quicki2c_acpi_get_dsd_property() does not validate the retu=
rned
> ACPI object type before accessing buffer fields, and does not free the al=
located
> ACPI buffer on the success path, leaking memory on every call.
>=20
> Add a buf_size parameter to the ACPI helper functions and reject response=
s
> larger than the destination buffer. Accept shorter responses to handle fi=
rmware
> that returns buffers without struct tail padding (e.g. ISUB tables return=
ing 177 or
> 145 bytes for a 184-byte struct).
> Zero-initialize caller stack structures so fields beyond the firmware res=
ponse
> length are deterministic. Add the missing type check and kfree to the DSD=
 helper.
>=20
> Fixes: 5282e45ccbfa ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2=
C ACPI
> interfaces")
> Fixes: 7cb06f08ef13 ("HID: intel-thc-hid: intel-quickspi: Add THC QuickSP=
I ACPI
> interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2:
> - Use overflow-only check (>) instead of exact-match (!=3D) so firmware
>   returning shorter buffers (e.g. 177 or 145 bytes for 184-byte ISUB
>   struct, or 1 byte for 4-byte SPI opcode) is accepted
> - Zero-initialize caller stack structures for deterministic behavior
>   with short firmware responses
> - Add missing type validation and kfree in DSD helper
> - Add braces per coding style
>=20
>  .../intel-quicki2c/pci-quicki2c.c             | 40 ++++++++++++++-----
>  .../intel-quickspi/pci-quickspi.c             | 36 ++++++++++-------
>  2 files changed, 51 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 7a913f717efaad..dd21864d16b05b 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -62,7 +62,8 @@ static const struct acpi_gpio_mapping quicki2c_gpios[] =
=3D {
>   * Return: 0 if success or ENODEV on failure.
>   */
>  static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, cons=
t
> guid_t *guid,
> -					  u64 rev, u64 func, acpi_object_type
> type, void *prop_buf)
> +					  u64 rev, u64 func, acpi_object_type
> type,
> +					  void *prop_buf, size_t buf_size)
>  {
>  	acpi_handle handle =3D acpi_device_handle(adev);
>  	union acpi_object *obj;
> @@ -75,10 +76,15 @@ static int quicki2c_acpi_get_dsm_property(struct
> acpi_device *adev, const guid_t
>  		return -ENODEV;
>  	}
>=20
> -	if (type =3D=3D ACPI_TYPE_INTEGER)
> +	if (type =3D=3D ACPI_TYPE_INTEGER) {
>  		*(u32 *)prop_buf =3D (u32)obj->integer.value;
> -	else if (type =3D=3D ACPI_TYPE_BUFFER)
> +	} else if (type =3D=3D ACPI_TYPE_BUFFER) {
> +		if (buf_size > 0 && obj->buffer.length > buf_size) {
> +			ACPI_FREE(obj);
> +			return -ENOSPC;
> +		}
>  		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
> +	}
>=20
>  	ACPI_FREE(obj);
>=20
> @@ -97,7 +103,8 @@ static int quicki2c_acpi_get_dsm_property(struct
> acpi_device *adev, const guid_t
>   * Return: 0 if success or ENODEV on failed.
>   */
>  static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi=
_string
> dsd_method_name,
> -					  acpi_object_type type, void
> *prop_buf)
> +					  acpi_object_type type, void *prop_buf,
> +					  size_t buf_size)
>  {
>  	acpi_handle handle =3D acpi_device_handle(adev);
>  	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL }; @@ -
> 113,7 +120,16 @@ static int quicki2c_acpi_get_dsd_property(struct acpi_de=
vice
> *adev, acpi_string
>=20
>  	ret_obj =3D buffer.pointer;
>=20
> +	if (ret_obj->type !=3D type) {
> +		kfree(buffer.pointer);
> +		return -EINVAL;
> +	}
> +	if (buf_size > 0 && ret_obj->buffer.length > buf_size) {
> +		kfree(buffer.pointer);
> +		return -ENOSPC;
> +	}
>  	memcpy(prop_buf, ret_obj->buffer.pointer, ret_obj->buffer.length);
> +	kfree(buffer.pointer);
>=20
>  	return 0;
>  }
> @@ -129,8 +145,8 @@ static int quicki2c_acpi_get_dsd_property(struct
> acpi_device *adev, acpi_string  static int quicki2c_get_acpi_resources(st=
ruct
> quicki2c_device *qcdev)  {
>  	struct acpi_device *adev =3D ACPI_COMPANION(qcdev->dev);
> -	struct quicki2c_subip_acpi_parameter i2c_param;
> -	struct quicki2c_subip_acpi_config i2c_config;
> +	struct quicki2c_subip_acpi_parameter i2c_param =3D {};
> +	struct quicki2c_subip_acpi_config i2c_config =3D {};
>  	u32 hid_desc_addr;
>  	int ret =3D -EINVAL;
>=20
> @@ -145,7 +161,7 @@ static int quicki2c_get_acpi_resources(struct
> quicki2c_device *qcdev)
>  					     QUICKI2C_ACPI_REVISION_NUM,
>=20
> QUICKI2C_ACPI_FUNC_NUM_HID_DESC_ADDR,
>  					     ACPI_TYPE_INTEGER,
> -					     &hid_desc_addr);
> +					     &hid_desc_addr, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -155,7 +171,7 @@ static int quicki2c_get_acpi_resources(struct
> quicki2c_device *qcdev)
>  					     QUICKI2C_ACPI_REVISION_NUM,
>=20
> QUICKI2C_ACPI_FUNC_NUM_ACTIVE_LTR_VAL,
>  					     ACPI_TYPE_INTEGER,
> -					     &qcdev->active_ltr_val);
> +					     &qcdev->active_ltr_val, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -163,12 +179,13 @@ static int quicki2c_get_acpi_resources(struct
> quicki2c_device *qcdev)
>  					     QUICKI2C_ACPI_REVISION_NUM,
>=20
> QUICKI2C_ACPI_FUNC_NUM_LP_LTR_VAL,
>  					     ACPI_TYPE_INTEGER,
> -					     &qcdev->low_power_ltr_val);
> +					     &qcdev->low_power_ltr_val, 0);
>  	if (ret)
>  		return ret;
>=20
>  	ret =3D quicki2c_acpi_get_dsd_property(adev,
> QUICKI2C_ACPI_METHOD_NAME_ICRS,
> -					     ACPI_TYPE_BUFFER, &i2c_param);
> +					     ACPI_TYPE_BUFFER, &i2c_param,
> +					     sizeof(i2c_param));
>  	if (ret)
>  		return ret;
>=20
> @@ -180,7 +197,8 @@ static int quicki2c_get_acpi_resources(struct
> quicki2c_device *qcdev)
>  	qcdev->i2c_config.target_addr =3D i2c_param.device_address;
>=20
>  	ret =3D quicki2c_acpi_get_dsd_property(adev,
> QUICKI2C_ACPI_METHOD_NAME_ISUB,
> -					     ACPI_TYPE_BUFFER, &i2c_config);
> +					     ACPI_TYPE_BUFFER, &i2c_config,
> +					     sizeof(i2c_config));
>  	if (ret)
>  		return ret;
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 53023e30cf8d47..e4331ba4e503d9 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -81,7 +81,8 @@ static const struct acpi_gpio_mapping quickspi_gpios[] =
=3D {
>   * Return: 0 if successful or ENODEV on failed.
>   */
>  static int thc_acpi_get_property(struct acpi_device *adev, const guid_t =
*guid,
> -				 u64 rev, u64 func, acpi_object_type type, void
> *prop_buf)
> +				 u64 rev, u64 func, acpi_object_type type,
> +				 void *prop_buf, size_t buf_size)
>  {
>  	acpi_handle handle =3D acpi_device_handle(adev);
>  	union acpi_object *obj;
> @@ -94,10 +95,15 @@ static int thc_acpi_get_property(struct acpi_device
> *adev, const guid_t *guid,
>  		return -ENODEV;
>  	}
>=20
> -	if (type =3D=3D ACPI_TYPE_INTEGER)
> +	if (type =3D=3D ACPI_TYPE_INTEGER) {
>  		*(u32 *)prop_buf =3D (u32)obj->integer.value;
> -	else if (type =3D=3D ACPI_TYPE_BUFFER)
> +	} else if (type =3D=3D ACPI_TYPE_BUFFER) {
> +		if (buf_size > 0 && obj->buffer.length > buf_size) {
> +			ACPI_FREE(obj);
> +			return -ENOSPC;
> +		}
>  		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
> +	}
>=20
>  	ACPI_FREE(obj);
>=20
> @@ -129,7 +135,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_HDR_ADDR,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->input_report_hdr_addr);
> +				    &qsdev->input_report_hdr_addr, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -137,7 +143,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_BDY_ADDR,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->input_report_bdy_addr);
> +				    &qsdev->input_report_bdy_addr, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -145,7 +151,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_OUTPUT_REP_ADDR,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->output_report_addr);
> +				    &qsdev->output_report_addr, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -153,7 +159,8 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_READ_OPCODE,
>  				    ACPI_TYPE_BUFFER,
> -				    &qsdev->spi_read_opcode);
> +				    &qsdev->spi_read_opcode,
> +				    sizeof(qsdev->spi_read_opcode));
>  	if (ret)
>  		return ret;
>=20
> @@ -161,7 +168,8 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_WRITE_OPCODE,
>  				    ACPI_TYPE_BUFFER,
> -				    &qsdev->spi_write_opcode);
> +				    &qsdev->spi_write_opcode,
> +				    sizeof(qsdev->spi_write_opcode));
>  	if (ret)
>  		return ret;
>=20
> @@ -169,7 +177,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>  				    ACPI_QUICKSPI_FUNC_NUM_IO_MODE,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->spi_read_io_mode);
> +				    &qsdev->spi_read_io_mode, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -184,7 +192,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_CONNECTION_SPEED,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->spi_freq_val);
> +				    &qsdev->spi_freq_val, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -192,7 +200,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_LIMIT_PACKET_SIZE,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->limit_packet_size);
> +				    &qsdev->limit_packet_size, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -205,7 +213,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>=20
> ACPI_QUICKSPI_FUNC_NUM_PERFORMANCE_LIMIT,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->performance_limit);
> +				    &qsdev->performance_limit, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -215,7 +223,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>  				    ACPI_QUICKSPI_FUNC_NUM_ACTIVE_LTR,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->active_ltr_val);
> +				    &qsdev->active_ltr_val, 0);
>  	if (ret)
>  		return ret;
>=20
> @@ -223,7 +231,7 @@ static int quickspi_get_acpi_resources(struct
> quickspi_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>  				    ACPI_QUICKSPI_FUNC_NUM_LP_LTR,
>  				    ACPI_TYPE_INTEGER,
> -				    &qsdev->low_power_ltr_val);
> +				    &qsdev->low_power_ltr_val, 0);
>  	if (ret)
>  		return ret;
>=20

Thanks for your patch!
It will be better if you can split it into two separate patches (One for Qu=
ickSPI, one for QuickI2C).

Reviewed-by: Even Xu <even.xu@intel.com>

> --
> 2.47.3

