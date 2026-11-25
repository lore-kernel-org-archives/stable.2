Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795575771;
	b=DEfXIasHMeCSMPWgwgLSmiP59qxWZLxl2r6FHfrTNPzs5OYQ+Ey98azvf92yHpZV2Xik
	 H4WK5pP3c81jK8raCRhS/YMQWRXay6Q5pcnuVwMhJw7uQRhOJKfP/aaIUIEZlprCgirbP
	 2k/sJ5tyVqW6CJc+lz9SQ07bs/GUYsefMSftRDVCINBLFm/sH+h05K4nnhnvoLAS9tEjE
	 W79x8zcj4BA/Y3U590SjbY1o+39dpr5W1nSTet0vttDrPELYdOCeEMAyECv8wcOt5PiHV
	 AjPEzNhWsk5Tl1JExO76yqEHm/Zx4eyLFSLTPEr++miOY3imyB/eQj04Cm4RICxFTVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575771;
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
	bh=EP3g4jm3QKYjhlYq8KoO85mFTafhLdsoA0wVJ3AvJAo=;
	b=G7WrKJZzidZgl+A8i8vJfGKloVA6kmpB/dy7qlWnnWmVrcFqOTRY7J2x6EbwIZ/qtcIj
	 7utkJHBMTtgVuU0guzJf7z7JRuEYqhxemiPcv9F7ZUCURdDtauFBcAS/1vmqaJgfgU8fb
	 xyP2VSAJU11aqOVRidcrqmLgi+cQPfjdPvsTg8JbLMLRu2fpQZULdLd9baHWdxXbpDiaC
	 AJ4atw8sN3YPG7qjdYd2uy3sMCoUA36gaaY8Rbix897XJK65yoWtuce0LJedeFnENa2xL
	 /odU3bYPh1tS8mPWrzJxnfI1L5RTXWYalcn5f9vZZ/S9OQV6gT7vsMLxWOJsgT6kc5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MwTak+l8;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m3+hwZSL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E1606A334;
	Wed, 25 Nov 2026 03:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A67E1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MwTak+l8;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m3+hwZSL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795575771; x=1827111771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zsJvYz93kLjb6SFP5mf5t7uAcX4VWVAYn9kCDFjpaoA=;
  b=MwTak+l8xUOfjau3dM5bpQjQAQiNiKrW+DmJmA9p5K5SzY5keRAdRVuN
   L79M3AbtMtr5TtELkOSo48sbBQEtvJx/ZSna++lU6xJ/fI9VQq5YzTYNg
   jsnCTYV0ir+GQFo7AUv6Yat9XHo4EqaqqzfVMp81Ef6ConUn6uPVKdM4b
   cDN4tY4jMXjV/KtByZbhYvn+Kj1UpklUfpnPB2xHOQVXIi89tIXzwNjho
   nrsxkagiAzN5qCk1TxFK7IWZWW5X9ki7ratnYT1jZZtqblDjv0c6dpfvU
   w2awoLDdEGmclS4Gh8HKamwAUXTDZ6jTGYWaq9B/9/CKlwC0CsSVd3WMP
   g==;
X-CSE-ConnectionGUID: duzF2SGCQzSAoZp39WVtfA==
X-CSE-MsgGUID: wnz5OYwHQMyKFhXJYF/d9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4454904"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4454904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:02:50 -0800
X-CSE-ConnectionGUID: gVAfJHQ6T7ed95NuYbCW5w==
X-CSE-MsgGUID: hfT5MgaUR5CNV8rg6YkNtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12072588"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:02:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:02:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 19:02:49 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:02:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCIh7KPD/usnqHGGwGgzZ92YdCi4p6ruR+Dspcs+wu8P5XatQy5L5VREP4q/B8c6JoDbW/lRGZyxVgfUA8hrz6prePIkfNDNByCUAWXc3BNFD+QJiiDLKbXEhS0N8SPuj7iqbNMSuJDyz1Al4s6mJqnYgdy9PnqudCim99lObPTzBzfDwVXmZoCFkbqHGlnCbeuP6qHNiPt9jUTwiM6kAHYqjJp4yXoBwH3AUQLEnf39gpt153L0P/bBuUcMtdTvoVG4QIp1HXU3S68jTELMQl5rdv6OcmP4fbhhwl3FHZJRO5q31SczZCzSECwhNtzrZJMZS6o4OXyTtD299x9umA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP3g4jm3QKYjhlYq8KoO85mFTafhLdsoA0wVJ3AvJAo=;
 b=WdLVQpMGFOAmFC/QL4772rfhLv2JGKCJHQFHTcaXO17dh+126TTJ4oHm5+eSuCHss31m9aXVLqwm6bpBSX8U5FWZ1KchjSYrraogpGOnHc+TUxknwvlP+A4WbohyaCMCLj8uI44HIvQ4jgKKE23dpYuWQz4KRC835InPe9uBJv96rwiQ5XeV1gvmnba6UibPmxoHtvzU6B000SFy982YQJ79XJ10NDNG13xjpvt3gMuAGgtgp9J2D6MWzfKC1T37iWa8LkXitPRQ+tfVKYAM3jSJ7wNz9IuUszJ5qUAU0WNh1BUTJkOfzWjQmM1H1mJunUFL0wP9mbTNjH1uTxyAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP3g4jm3QKYjhlYq8KoO85mFTafhLdsoA0wVJ3AvJAo=;
 b=m3+hwZSLpTv5qfOrZOln0YWOgAKdFrY6evYL8U0oVLsR5O/Hgkec8WyhCkZ2Psk8utMT+f1MWZpAH6FjJ6w1evUqg+7QymJw/5vvjLIOLfQHlLCLR1SGCW8uCuvPCRsUl5owOt2nVarWm8kxGuZ9KUVCdoakCrb5h6Xohoh5nKI=
Received: from MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 03:02:46 +0000
Received: from MW4PR11MB6982.namprd11.prod.outlook.com
 ([fe80::b676:829:5412:4afd]) by MW4PR11MB6982.namprd11.prod.outlook.com
 ([fe80::b676:829:5412:4afd%3]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 03:02:46 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Vishal Badole <Vishal.Badole@amd.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Liang, Dan"
	<dan.liang@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v8] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Topic: [PATCH v8] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Index: AQHddEsnSK8n6Ao4dUis02zw07nLi7c+EYug
Date: Wed, 25 Nov 2026 03:02:46 +0000
Message-ID: <MW4PR11MB69827D44533F71B62DC3995F92432@MW4PR11MB6982.namprd11.prod.outlook.com>
References: <20261114151403.1379591-1-Vishal.Badole@amd.com>
In-Reply-To: <20261114151403.1379591-1-Vishal.Badole@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6982:EE_|LV8PR11MB8461:EE_
x-ms-office365-filtering-correlation-id: 9e35fca1-eea1-4abb-cd01-08df4aa094e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|3023799007|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261102123227099003|261022075727099003|261026121527099003|261028144727099003|56012099006|10067099003|38070700021|11063799006|5023799004;
x-microsoft-antispam-message-info: 3QhxlBKQ1NpNJAii3okO84fwW3QTap07sXFyvjeCbWG9u8vXlJKLIQhGE5MEXBOPp+VMERe+pFQMgdx5MyyMyun4dkGL/BxkhF+cPjgszC6/Yv3WtJTFufaEBtAF2HzoLq8NeCixm7ipaGYOo5pF9QFuyhvXJyj81U4KEttC6yeD3WuiaG/6yxzSurGuNo5TYS//ouYLZA3J7kLP7i5oxIzkqLG58+Q2LsUb15Bd2gFQtYDXs1wly/Z0KqMcIUGLFyeapnp6e4s3zbBAbK8q4VACEtS3iMwHbG7dPuYvayF5e6hIaDaMdTgnhLWNspS1cccp8zf41pdT7jo9zR4HY1PKia58L0oQQmBnbG7wdpnmgvD9yFU5rxQifLals71Ab/zKhuueju+wIWEavXkciojTha3FxwboJIplH8vNO3nn+k1NZoaI69uMEfy2TdDeYTcNr4Tj0P+bJoDINjNkeN90uXag9KQ7w1em8KcwZEed0b8p+dowxstfuRLUyV1vljjLfGThB8PXW24forMMsNoevuo0WA6A6rvFV1WZSVQ/4ebvx9QprVY9hupaXYmGjA87z5oL27UU4ft57c4zSFtr7gk1hQpBNuJ3fdCL+6p/vMAvOtkvryHADhLjIkOyT/6ly2I6AP9ZtfavyP1OhJTjGnJLUFEbWCiqMRnWgyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6982.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261102123227099003)(261022075727099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(38070700021)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FxHswUujfQgeTqrBckzQuy7OdazsFs1/m14FCXJTg+KAMBikwp6+QGfDCQWN?=
 =?us-ascii?Q?D3iyD8QtQKDpyt2kGX2TmOuKzwGcnM/hHaVEjCCZclKyWNfRpsypXLI0D93u?=
 =?us-ascii?Q?rBrIZyQXnIDCf9kxgdDs78vCkJOuzA2PJ7dO2cb7EY2TLSN45t/XPRu6ZVbq?=
 =?us-ascii?Q?E/sOjCWY8eBpPdlUaQRODeZ2OH3+zKEAXaqn+e9IqxvTIqo6neelY1Uc4mEc?=
 =?us-ascii?Q?iL325jxfSdy27DtBUespK8vf5aiJZ+/AgzB5xmIRAX2q6IQbnjyBLo7eTDaE?=
 =?us-ascii?Q?E3SN8Vp7LwfIJIlkN/lFAHm4JAqkKBOa5B5jUDTAnk194oEA9GrUYmhxYjfQ?=
 =?us-ascii?Q?KzYG/UQ4JBNDRz+eOXPQCTmfDimNaaaL+6dqQ7SeqXER3mLZepQZPiTT8eIk?=
 =?us-ascii?Q?m9S6X7z9KV0ugNMdf7Mkcyrwyy85CKui4I0+kdkDdK+74CzIJfMKs9EGTPdi?=
 =?us-ascii?Q?frKgkxgqwx+U/j/2VMEsciegPi30Vui7yVEtwt5y//L2a+iyF/SK5D1VnG7J?=
 =?us-ascii?Q?/cKoL1bZf66H/SilxB5e+OglF3xu3DXW+HmY18sKL00zJ+EJ4/pZ0PGR3Gcn?=
 =?us-ascii?Q?LFY/OB0atOqf83f3uWgGUkZ1BGiVLiwANcVjGnGpARzJauoGtdFWnxjBBua9?=
 =?us-ascii?Q?2o0bUd2ECwTr1cnPIVJ6eBLGtwyPHV2tEfAxXBtnPYYLhCUHaHTpKumLAaZd?=
 =?us-ascii?Q?ngs3a7ZKBTXiw6Kp3Tr/SiWBDBf6hoVti/rs3xsZ6ikC4fN57pNX/bqd6mqK?=
 =?us-ascii?Q?ZK1LGi5Pa8nK7praN+oNZtvHLJuHn7luQk9bf+g2ZdjANxe4MZi7mSLTE9rz?=
 =?us-ascii?Q?WDClhgnORiS1ZUQR9Tqmw0El+d3Qz8CrUm/7J4ftnOEABuiUKsMehjArdLum?=
 =?us-ascii?Q?EiMx1VvbbPu+p9239OyGGFgXYGHDnsSBupdCmgnVg5ouS12xWGQUwacNPqSa?=
 =?us-ascii?Q?T8EDMV3nFdH6I6FUCZnDwJ+IZ+42kE6ZckmM6erjCerBPZS502iQli5kVPvN?=
 =?us-ascii?Q?v3A8u+D6gNV4OW57Uzqk659ti/FywJY7VdT9FkcvNn9RXUlXfYmTi9gHz8Si?=
 =?us-ascii?Q?OLbOABxVz0f8OjbH6uihRc88C1wLkp90jE8TWsC7zyAVSZCOPPlNmHBl5951?=
 =?us-ascii?Q?X5aKt7/4PmiKG9fzcLjW01J86sIhTlg15jo+Ys0W1ffo1KpNTZBhAlOEGQa8?=
 =?us-ascii?Q?LUOqF0ScgzUj/BKZkNtZa5V9aLCaKe6qY0tfqrKVX/D0yCa1nKbtst5bTKML?=
 =?us-ascii?Q?m8BRTpoV7bXV9g3jDMAp6Q2PMuwfugKP3laWzmOkuoJtznv91ORA9ddqqqMt?=
 =?us-ascii?Q?QdlZJIThrdHE0K0bIxRnR7L5CWThuymvZy6kUPMz+DU6mcMJrCuhWEe8Vjno?=
 =?us-ascii?Q?r3+HpsFjrNUm3LqEKw7rX6qj8N5V4jbQOHvRBRSnKJT36cFI2Z2R7ILPOsZG?=
 =?us-ascii?Q?wm1cwMwj/tAyBGBIKKxMm0PFJt0tPhR3Q37gvaeAi3iluw+HU/1L6wbnvHGR?=
 =?us-ascii?Q?Fd9bPbgutKB2aT99j0seXHHMmWM8RwF9EvrNujwoeyZXPSSp5vYwNdW1n6QP?=
 =?us-ascii?Q?B1+wDmJ7KYYiZYI1275INjIOE0ZIXnUGzx0bMU4kawr45iC6gq+ALPo+hOQ6?=
 =?us-ascii?Q?9jvSmuEV6kkezST5i+0Pk781DdW/N5dC3kdqrfpf9zPnQbVPaHqR0y4MJ1Vr?=
 =?us-ascii?Q?9zTFPcr7QHg8Y/DNOlnKxZi7gGGoMP9KIp3/MffWBPVepR2CnDrw0xdqGlSF?=
 =?us-ascii?Q?jGxT40V8kw=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: dV7tjd7CxUH1y1xAVDBcYefuUvB5HMs1GWKgGFJ/MEPnT19xKGnJlWjSH0rfTcFF7Q9Qsl7ZoGFcioOXIHJwHkSEs9PNYGASLZdqDh/PTUfWXikhN0lIMUGZvCVrv6LD5l9zxrSsYatNG7YZ41bdwv3Z+DUJp74awxDy9JlKUF7dC19hklCbHhz/VTEGPe2bVtBykEx5+OfD3tDgs4j5yMu3DUuLkDIgUJuitbwEgCBKQREAZk/xDc1m9vtD2olF2l5h2ceipLGoSpmYwHtr/Dv9MK/wwO6BZ70mrNXe9TpU2VkJ/AqDk6OUfacVlZXEca4Up1oZYxMuXEl4EAXS9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6982.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35fca1-eea1-4abb-cd01-08df4aa094e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:02:46.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFMw0vraJuFf0RAViBnUSS+vsvur4S0J+Sz/zA0rRJkWHX6b3jSyCSTtwpp9cqJm1T3yhYj2GDCFUxOrtr5lHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com

Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>

On Sat, 14 Nov 2026 23:16:43, Vishal Badole <Vishal.Badole@amd.com> wrote:
> group_cpus_evenly() builds the managed-IRQ affinity spread used by
> multi-queue devices such as NVMe. That spread is meant to be a property
> of the static CPU topology: it walks cpu_present_mask and then
> cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
> including CPUs that are offline at the time. A driver depends on that
> partition staying stable across re-computation - the CPUs a queue is
> given at probe must still describe the same queue after the device is
> later reset and its affinity recomputed.
>
> On an AMD system that stability breaks across an s2idle cycle. CPUs 3-11
> are offlined before suspend, leaving only CPUs 0-2 online. s2idle itself
> does not offline secondary CPUs. The NVMe controller uses the
> simple-suspend quirk, so resume fully re-initialises it and recomputes th=
e
> affinity spread while CPUs 3-11 remain offline. The system then hangs for
> roughly two minutes and stays sluggish afterwards, the controller only
> making progress through its command-timeout poll:
>
>   nvme nvme0: I/O tag 898 (3382) QID 9 timeout, completion polled
>   nvme nvme0: I/O tag 398 (618e) QID 11 timeout, completion polled
>
> QID 9 and QID 11 are the queues whose CPUs were offline when the spread
> was recomputed. "completion polled" means the commands did finish in
> hardware, but their interrupts were never delivered to a CPU that was
> watching the queue, so nothing reaped them until the timeout fired.
>
> It happens because commit 89802ca36c96 ("lib/group_cpus: make group CPU
> cluster aware") derives the cluster groups from topology_cluster_cpumask(=
),
> which lists only the cluster siblings that are online when it is called.
> The resulting partition therefore depends on the transient online mask
> rather than on the topology alone. Recomputed on resume while CPUs 3-11
> remain offline, it no longer matches the boot-time partition, and a
> queue is left with an affinity that does not cover the CPU it is meant to
> serve once that CPU comes back online. The dependence is on the online
> mask, not on any AMD-specific behaviour, so the same stall is reproducibl=
e
> on Intel platforms as well.
>
> Fix this by snapshotting cluster and SMT masks together under
> cpus_read_trylock() when all present CPUs are online. Latch the first
> capture attempt, permanently using CPU-order grouping if it fails, and
> propagate later allocation errors instead of switching algorithms. This
> keeps successful spreads stable across CPU offline/online cycles for an
> unchanged group count, present/possible CPU sets and NUMA topology.
>
> Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> ---
> Changes in v8:
> - Check for a snapshot before allocating the temporary cluster mask.
> - Link to v7:https://lore.kernel.org/all/20261110174513.461743-1-Vishal.B=
adole@amd.com/
>
> Changes in v7:
> - Return ncluster directly from __try_group_cluster_cpus().
> - Remove the duplicate done update in __group_cpus_evenly().
> - Link to v6: https://lore.kernel.org/all/20261102070930.1803698-1-Vishal=
.Badole@amd.com/
>
> Changes in v6:
> - Clarify CPUs 3-11 stay offline from before suspend through IRQ remappin=
g.
> - Describe the lock as excluding CPU hotplug, not pinning topology masks.
> - Link to v5: https://lore.kernel.org/all/20261027073627.2589115-1-Vishal=
.Badole@amd.com/
>
> Changes in v5:
> - Snapshot SMT masks alongside cluster masks using the existing cleanup.
> - Latch capture at entry; use CPU order without live masks on failure.
> - Propagate cluster allocation errors instead of changing the spread.
> - Link to v4: https://lore.kernel.org/all/20260826171537.4167367-1-Vishal=
.Badole@amd.com/
>
> Changes in v4:
> - Drop the index-based unwind; reuse the mask-based cleanup path.
> - Link to v3: https://lore.kernel.org/all/20260821184923.2462575-1-Vishal=
.Badole@amd.com/
>
> Changes in v3:
> - Take the snapshot under cpus_read_trylock() to avoid a torn view.
> - Link to v2: https://lore.kernel.org/all/20260814123402.3170161-1-Vishal=
.Badole@amd.com/
>
> Changes in v2:
> - Gate the snapshot on cpu_present_mask instead of cpu_possible_mask.
> - Reword the changelog and the code comments. No other change.
> - Link to v1: https://lore.kernel.org/all/20260807073612.3711269-1-Vishal=
.Badole@amd.com/
>
>  lib/group_cpus.c | 125 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 106 insertions(+), 19 deletions(-)
>
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index e6e18d7a49bba..79aa911b05ba9 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -6,11 +6,14 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
> +#include <linux/mutex.h>
>  #include <linux/sort.h>
>  #include <linux/group_cpus.h>
>
>  #ifdef CONFIG_SMP
>
> +static cpumask_var_t *sibling_snapshot;
> +
>  static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *=
nmsk,
>  				unsigned int cpus_per_grp)
>  {
> @@ -29,7 +32,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk,=
 struct cpumask *nmsk,
>  		cpus_per_grp--;
>
>  		/* If the cpu has siblings, use them first */
> -		siblmsk =3D topology_sibling_cpumask(cpu);
> +		siblmsk =3D sibling_snapshot ? sibling_snapshot[cpu] : cpumask_of(cpu)=
;
>  		for (sibl =3D -1; cpus_per_grp > 0; ) {
>  			sibl =3D cpumask_next(sibl, siblmsk);
>  			if (sibl >=3D nr_cpu_ids)
> @@ -286,6 +289,84 @@ static void assign_cpus_to_groups(unsigned int ncpus=
,
>  	}
>  }
>
> +/*
> + * Cluster and SMT sibling masks change when CPUs go offline. Snapshot b=
oth
> + * on the first spread if every present CPU is online. Latch the attempt=
 even
> + * on failure, so later spreads cannot enable a different grouping algor=
ithm.
> + *
> + * Without a snapshot, use CPU order without cluster or SMT preference.
> + * Successful spreads remain stable for the same group count, present/po=
ssible
> + * CPU sets and NUMA topology. The snapshot is not refreshed for CPU hot=
-add.
> + */
> +static cpumask_var_t *cluster_snapshot;
> +static bool cluster_snapshot_initialized;
> +static DEFINE_MUTEX(cluster_snapshot_lock);
> +
> +static void capture_cluster_snapshot(void)
> +{
> +	cpumask_var_t *snapshot, *siblings;
> +	unsigned int cpu;
> +
> +	/* Pairs with the smp_store_release() below. */
> +	if (smp_load_acquire(&cluster_snapshot_initialized))
> +		return;
> +
> +	mutex_lock(&cluster_snapshot_lock);
> +	if (cluster_snapshot_initialized)
> +		goto out;
> +
> +	/* Only capture when all present CPUs are online. */
> +	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask)))
> +		goto done;
> +
> +	snapshot =3D kcalloc(nr_cpu_ids, sizeof(*snapshot), GFP_KERNEL);
> +	if (!snapshot)
> +		goto done;
> +	siblings =3D kcalloc(nr_cpu_ids, sizeof(*siblings), GFP_KERNEL);
> +	if (!siblings)
> +		goto free_snapshot;
> +
> +	for_each_possible_cpu(cpu)
> +		if (!zalloc_cpumask_var(&snapshot[cpu], GFP_KERNEL) ||
> +		    !zalloc_cpumask_var(&siblings[cpu], GFP_KERNEL))
> +			goto free_snapshot;
> +
> +	/* Trylock: a caller may hold a lock the hotplug writer needs. */
> +	if (!cpus_read_trylock())
> +		goto free_snapshot;
> +
> +	/* Recheck with CPU hotplug excluded before copying the masks. */
> +	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask))) {
> +		cpus_read_unlock();
> +		goto free_snapshot;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		cpumask_copy(snapshot[cpu], topology_cluster_cpumask(cpu));
> +		cpumask_copy(siblings[cpu], topology_sibling_cpumask(cpu));
> +	}
> +	cpus_read_unlock();
> +
> +	cluster_snapshot =3D snapshot;
> +	sibling_snapshot =3D siblings;
> +	goto done;
> +
> +free_snapshot:
> +	/* Unallocated entries are NULL, which free_cpumask_var() ignores. */
> +	for_each_possible_cpu(cpu) {
> +		free_cpumask_var(snapshot[cpu]);
> +		if (siblings)
> +			free_cpumask_var(siblings[cpu]);
> +	}
> +	kfree(snapshot);
> +	kfree(siblings);
> +done:
> +	/* Publish the capture outcome, including failure, before grouping. */
> +	smp_store_release(&cluster_snapshot_initialized, true);
> +out:
> +	mutex_unlock(&cluster_snapshot_lock);
> +}
> +
>  static int alloc_cluster_groups(unsigned int ncpus,
>  				unsigned int ngroups,
>  				struct cpumask *node_cpumask,
> @@ -307,7 +388,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  		if (cpu >=3D nr_cpu_ids)
>  			break;
>
> -		cluster_mask =3D topology_cluster_cpumask(cpu);
> +		cluster_mask =3D cluster_snapshot[cpu];
>  		if (!cpumask_weight(cluster_mask))
>  			goto no_cluster;
>  		/* Clean out CPUs on the same cluster. */
> @@ -322,7 +403,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  	/* Allocate memory based on cluster number. */
>  	clusters =3D kzalloc_objs(*clusters, ncluster);
>  	if (!clusters)
> -		goto no_cluster;
> +		return -ENOMEM;
>  	cluster_groups =3D kzalloc_objs(struct node_groups, ncluster);
>  	if (!cluster_groups)
>  		goto fail_cluster_groups;
> @@ -331,7 +412,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  	cpumask_copy(msk, node_cpumask);
>  	for (n =3D 0; n < ncluster; n++) {
>  		cpu =3D cpumask_first(msk);
> -		cluster_mask =3D topology_cluster_cpumask(cpu);
> +		cluster_mask =3D cluster_snapshot[cpu];
>  		nc =3D cpumask_weight_and(cluster_mask, node_cpumask);
>  		clusters[n] =3D cluster_mask;
>  		cluster_groups[n].id =3D n;
> @@ -347,6 +428,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>
>   fail_cluster_groups:
>  	kfree(clusters);
> +	return -ENOMEM;
>   no_cluster:
>  	return 0;
>  }
> @@ -354,9 +436,9 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  /*
>   * Try group CPUs evenly for cluster locality within a NUMA node.
>   *
> - * Return: true if success, false otherwise.
> + * Return: cluster count on success, 0 if inapplicable, or -ENOMEM on fa=
ilure.
>   */
> -static bool __try_group_cluster_cpus(unsigned int ncpus,
> +static int __try_group_cluster_cpus(unsigned int ncpus,
>  				     unsigned int ngroups,
>  				     struct cpumask *node_cpumask,
>  				     struct cpumask *masks,
> @@ -365,18 +447,20 @@ static bool __try_group_cluster_cpus(unsigned int n=
cpus,
>  {
>  	struct node_groups *cluster_groups;
>  	const struct cpumask **clusters;
> -	unsigned int ncluster;
> -	bool ret =3D false;
> +	int ncluster;
>  	cpumask_var_t nmsk;
>  	unsigned int i, nc;
>
> +	if (!cluster_snapshot)
> +		return 0;
> +
>  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> -		goto fail_nmsk_alloc;
> +		return -ENOMEM;
>
>  	ncluster =3D alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
>  					&clusters, &cluster_groups);
>
> -	if (ncluster =3D=3D 0)
> +	if (ncluster <=3D 0)
>  		goto fail_no_clusters;
>
>  	for (i =3D 0; i < ncluster; i++) {
> @@ -392,13 +476,11 @@ static bool __try_group_cluster_cpus(unsigned int n=
cpus,
>  		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
>  	}
>
> -	ret =3D true;
>  	kfree(cluster_groups);
>  	kfree(clusters);
>   fail_no_clusters:
>  	free_cpumask_var(nmsk);
> - fail_nmsk_alloc:
> -	return ret;
> +	return ncluster;
>  }
>
>  static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgr=
ps,
> @@ -442,6 +524,7 @@ static int __group_cpus_evenly(unsigned int startgrp,=
 unsigned int numgrps,
>  	for (i =3D 0; i < nr_node_ids; i++) {
>  		unsigned int ncpus;
>  		struct node_groups *nv =3D &node_groups[i];
> +		int ret;
>
>  		if (nv->ngroups =3D=3D UINT_MAX)
>  			continue;
> @@ -454,14 +537,16 @@ static int __group_cpus_evenly(unsigned int startgr=
p, unsigned int numgrps,
>
>  		WARN_ON_ONCE(nv->ngroups > ncpus);
>
> -		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
> -					     masks, &curgrp, last_grp)) {
> -			done +=3D nv->ngroups;
> -			continue;
> +		ret =3D __try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
> +					       masks, &curgrp, last_grp);
> +		if (ret < 0) {
> +			kfree(node_groups);
> +			return ret;
>  		}
>
> -		assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
> -				      last_grp);
> +		if (!ret)
> +			assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
> +					      last_grp);
>  		done +=3D nv->ngroups;
>  	}
>  	kfree(node_groups);
> @@ -496,6 +581,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s, unsigned int *nummasks)
>  	if (numgrps =3D=3D 0)
>  		return NULL;
>
> +	capture_cluster_snapshot();
> +
>  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>  		return NULL;
