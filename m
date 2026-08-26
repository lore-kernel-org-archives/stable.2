Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70A15E8B;
	Wed, 26 Aug 2026 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787706608; cv=fail; b=jGAnVr1cQOGSDHUY3RdAf1MvY/OI4IZdBBqG1bJdfJ3Wo0rAAoJ/R7VS5J6mned4ufYuvG8631NCTr92JlcBz6LV+9ZvjHqkBI07tEb9UhUWJAChx4Xwwtgg/xCBKe7iyLbbxVVzfAsiYOXihQX37IQNAVSjITbLOcRkLgpsbBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787706608; c=relaxed/simple;
	bh=vjNxmLJV2LQgW0434cHJKg24BUrZSeQ4B4HC+3wX/Mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZQJZxsD3+X3FyKy2xdlDGx1e304JA0WWYINcrqgpnhEThZafkyjVHH6L+0IsRPta4ZgFYjLQe+tVYs7347ato+s/GOEkInppVnbhAZLlghVEfCNxUPEMW/tQlNAb5qfxIAkYZmLpQHrWD5ElxtcQchNScDdnC+ZhGDM8BjdVn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQVZmzFX; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQVZmzFX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787706606; x=1819242606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vjNxmLJV2LQgW0434cHJKg24BUrZSeQ4B4HC+3wX/Mw=;
  b=VQVZmzFXufLaHQ1uSmv3jBuHPRgtyhW1aYRtaX4OW2wvcyMHYKelU0Ka
   H/prpMRh6/AJVCHqJlcrPzsHcfElZvICX8abuBk4s8CDkZ0u1Up9Hdcy2
   JmcuG4p3EPtdnRV6ogUdQRXNwgsCGu75kgiqgAlVUV5KSF1EspeR4GwQS
   2OkKdCi6P2gR+/WEvzocu7t6mv/bR+3wtvdTPdUPX+MIC0zTblhVXq/7j
   /HtLdJeK9unQ6sxFuXa8uK9qIAvf+Am2s6rmwSFeKreXl3SLi+oDvbj8d
   LZfFilldQtepRuEF8IpIpR2cTEwYq/NzXUn4ycZdQOg1yvKdeWPTvlgfx
   A==;
X-CSE-ConnectionGUID: rhEabr/QSMeN0OWhke0qBA==
X-CSE-MsgGUID: x6sWul3xQuisATftz0Dniw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88041622"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88041622"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 18:10:06 -0700
X-CSE-ConnectionGUID: 2QG9lN4uTJ6ujvcUHsTsYQ==
X-CSE-MsgGUID: +xHrEHCcTpCl9ziFSzV/mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="266132110"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 18:10:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 18:10:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 18:10:04 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 18:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2BZipw/jDnM+x1kkdkkYHXD3Z7GLiGWDLaJDsEl+f03D279rbt/Gl94t9LUB6qvwruVZG0KxvZwslGutMiH5iF9xchvd94SlSX/U7BE93IXnNcWPsi+3pAwLW7J88VCBWuY4+5MuE+JbZojIXhwFCJjysolglxgO04lsn0nXOGRYyOqV8t3uYtfWaUk9VlHjjE7Shje5goJLkUSx1X6btWjFcFh7VpRlS4ukuFS7BZ2Lsg1lZJsGx0E15T4vpkyPAKpzOMW0eNfH2OeqDaXi1+DMDx3jJHTSaEiFh0V/SJjoCIO67G8VpNSa65sk3+v+D/1+OkZbloarzBMQ/OYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8eM2NIIEpErq5df6F4B1NmR281y7AboHo4StEBql6g=;
 b=m1Un4Vq1E5OU7nhxAhlY1rYudw+z9m6Etxb5Vfku9QR0QHwhMAfA11yJmqO2p0w0exIam5ahi87H6EL+04oMLR0nl+ZDYAq00DfqF8WvpJ3nw9tKmo9RSAfq+6mVmK30/wGo4gS+1pip1piNCNqaJtptBrY8xjImq/kGJBPHyzyLGUaX/zGDekSO6jJoA9Sg/YKQw3etei2N/gNacedAH87FVVIDSd5JStoAcpaBMhHMs9Qmzss0XWJHe3EvjWG2WgK5MCWvNO0ZgkIHx77H337vvBP+hjkI6JVhRq5R5jHiHCiOw3tLBPG4jb7inGmTLafR6QZzIbxDeBs5ijzaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 01:10:02 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:10:01 +0000
From: "Xu, Even" <even.xu@intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input buffer
 for the DMA
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input
 buffer for the DMA
Thread-Index: AQHdMjQpjOXT9LnzF0uw7scCh+5XYbavhq2Q
Date: Wed, 26 Aug 2026 01:10:01 +0000
Message-ID: <IA1PR11MB6098D3A31961238BCC060D83F4AE2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260822124531.644834-1-sammiee5311@gmail.com>
In-Reply-To: <20260822124531.644834-1-sammiee5311@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: 8d17e093-f0aa-435f-a39a-08df030ec142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|5023799004|56012099006|38070700021;
x-microsoft-antispam-message-info: PRGDDjltsWdRn9Yu5V8bFaXS6AclMToUuvpqUfjIwwtiGGLC0Q9kuPMLwfVODeczCA3O0YgsB9w62PhLbFD2oQXbUZ+0sgGO4BhPprAkkrku1HQb/NqkRWIMcCZurV2iPlG1FPWebNv/rs75rHW9oxRiVMltnyvPvaCVTSoxauunvkHIxvnscRp9UzIYctuBFARJLoYxiCJ6f1fQG2psYkK3djVSGPQb4Y02+xpfm8lJjUH1YntTbiCyzlVw5BOf4Azf7uL1hV48n1TJVwdKN/sA14xkAbvmgHt6JALLCEYKqnFV+E/Hsj+upOeHS9NBlK8PByJNaocMpR+Cqo/KcdzvAMGmpMMrSgNIJGso/wixfqi+puKhjkhwy8NLMQL9N/HOlIAs/bd3rU/2GyXf0NQdmliZR0ky/4bHESjFDN8F+S08FxayUtX0FjO6wv9xzELKnRVDkA7p5xo7xZRFLIlOFL7CSxLAd93E/64SgBFfVZN8GMTqJkRBiUa5UUu1GuSVf+d3+Rhv4GwN7rnyyHe5wmjqiq4z+UavfXnK/8N3dQxmvTQfP7BNMU8Tr3DSuVvh4aeILJlZy7TdTaDbU4FBB06LpFvi7lfVdnMrCYOyS2XVsJMnrRaY5Amc7shdyMpvzOcZJ9w8vNVVfzItN+OkfqqHPS6jnKFPq7a4jucU/OeYRAxhyiMTsnHGAmo8ngXNe8h4VW5ZRMoHyeKqKBKUgAgGQbibyuG4QYN6QUw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l1Cn2A4M92pNGUHJFL+FImPQ1Xwd4KBSkcT4UG+jR3zWEFUQUBgLCp8PgFnn?=
 =?us-ascii?Q?+fknZpkgiR+GbL2ZWQh68T19FvzfS85kN4+eddwNXRVIXOXI1vYs2SIcVX8C?=
 =?us-ascii?Q?cx3ED7sl/vNAs034NPt6R7dfK6TCrRAitNK+6qCdCFYnkWBkmUJCLQ5scB+t?=
 =?us-ascii?Q?oo3v2GLt/ZLR/kQ4+HnGSyh3dJbwSmcD/AJAF329qKLh0LJYCTw0grLcb/PB?=
 =?us-ascii?Q?zycelBvcQQv/OWoWcn6UQ8QP+FjkDG2ltrMfgVXl86EoJv0Kp3gA8lvxJjw8?=
 =?us-ascii?Q?VhFMiZGNPqBQbqU5U7jTVvkVTRjmxJcPk7NauUSpUFmnn5/5n8B6sywPrsGY?=
 =?us-ascii?Q?ScGuIcyyFKSjWv4VteJyOmj747C0EgFU5xFasboAKmDkY34Tw1G2xqjmEQJ2?=
 =?us-ascii?Q?t4iAgH5X8VZTuCMk/UEY0gctRwjlrT/aWBby2Sclsfqx6O4bTCrr1pb1x46X?=
 =?us-ascii?Q?3/13z0G7EkAl44KduAz6wPmLos68ViLwKAbFRz6t3m06y5YkSODYGqbdzn8T?=
 =?us-ascii?Q?Q4p5jjI3NpzB4HeL4npPU6XbbzSvC2AyA9BKem/mqCK7Aj+FB8ahIn33Gmyk?=
 =?us-ascii?Q?O3GjkluTTkSuobbT2QrqpPS94NA925eT7OVt4zaOJhv55am/Z1MWpaN4BAeZ?=
 =?us-ascii?Q?xk6+gaJUb3A23nUY/3ndcMqA+HTludxkRurLeU7xonWILs/jeYIppw2UljS+?=
 =?us-ascii?Q?v3WVUjIB5V3ICCNmjH+FeWMwblVJE9iBV1zp/npOaqYsPMj0Vo9oDtKVtxde?=
 =?us-ascii?Q?R0M+M6XJpOaoOmymubnxuwCeTfmbSw4AojibRp2UaLlC7sRaVzf7TV9SvqKO?=
 =?us-ascii?Q?LJFyqTRMOzwqwTnEOgrkhM+TBX2Yq12lq5By9KNwPgCwGxagd1bIXathzFUo?=
 =?us-ascii?Q?h3wtGP76I8VVofZ0TmEx3H4yK72GhHDiC1BmVkt0oOODgUNBgtWje45pYMGD?=
 =?us-ascii?Q?jqkkQNMj8Y2nxgfvlQMeZunFpJcWS5cAcvKFEA0QETIM7iH5g3l+O+huBM5c?=
 =?us-ascii?Q?Tnv3QVaXtg96smu2imRTiD2BraFh46KCa+fepbBRN9PM4hXfjW3KneAOWrt5?=
 =?us-ascii?Q?4MzGImsPWceIxipwdQLgz7kaScNY5ig3kdlTuesGNnWN4PXP+mhwaO56B4b2?=
 =?us-ascii?Q?Mr81n8aOedKj83kqLeLXn04qVIEFgImCQlMKO57lnk+MrdKquvOkXxBrG9+i?=
 =?us-ascii?Q?SNwOF/Q1jOPPXo5kxJf/mfesyofxiO4DTrbTpeazwkvu82IkUnq8DUqNWI2R?=
 =?us-ascii?Q?CDndsqOD56JezYqQfqN45JXDJ8h8zeM8sl8NknU0+jhPQpiKbfWjuXYpt9cm?=
 =?us-ascii?Q?7bXLSns/+caGk6x2zOIphzzenGalI2BM9oNnEfuXE6zPb79RN1D0j9kx7ifC?=
 =?us-ascii?Q?f6gNC0IMeiuLhkoXcNM3DQwniHpXJUTyL6/mOuy4HRic7XsblDWnEm/tuDl3?=
 =?us-ascii?Q?4+0K+WH2fPkr1Hpq6844U7o0jXqaJmwtFpbRYsqTydjjc/EKUxxEKdBy5nrO?=
 =?us-ascii?Q?Gamm4L0qickwXDy/okbqmoHbQQ3svCUxkayOh5pMeyP5GPwk+0AHkezigdSb?=
 =?us-ascii?Q?22u1WWWKJp2XwM2Ael9uKnrSl6Q9bQHLwgBGeI2LM+xkk9StHD87q5dDOCsc?=
 =?us-ascii?Q?pmXmf2NnUhRABHeK4kOguDIrMe28xfL37SSuRvvg5Idq+AKkHJYqY1ddV1XC?=
 =?us-ascii?Q?HixPOfDyyJj4wGobOwc/DnObHFChwY8dQRpuOKieoJzgqL2H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T4IAnSUvoxbrl9INy61dzT3AgGQPw5mzv2kR7AEjKecw8Ix1RO6xb7iVp+owK5wZjDd7Vaa/mEYW4zG1UGxN7j5hNjSut1elFdXCriAaIj3T89Qfu6xEHrw3qcUwI+bxS/KI7IWQsIG1xfKFuahUHARK62Sv5nPNhpkB+oqiYAqM32LjzrdEaZ8AzI2qxlJnG5H+dGuBMFJt6iZhmwE4KvDvcGFZB2SJUvBG+nqmODlVsFAIy1trSgOvYUeDpEEoA2JOL+UXchLxymsyzhIZCJB9WgxcQUmeQM7gEEdljvZ0CwFfWURS9JkeJ+3pFL2PCK60ECWFG1/L3+d/cYgWPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d17e093-f0aa-435f-a39a-08df030ec142
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 01:10:01.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkS84YJKS711RADBzBrxQrxPeXiIlDQ77E9QNPEM5SOE0ZgyTFpPL48yJWDtjDQGbx2IiosaEfFslx/Sy1RxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: HyeongJun An <sammiee5311@gmail.com>
> Sent: Saturday, August 22, 2026 8:46 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; HyeongJun An <sammiee5311@gmail.com>
> Subject: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input buffe=
r for the
> DMA
>=20
> quicki2c_alloc_report_buf() sizes input_buf as max(max_input_len, SZ_4K),=
 but
> two channels deliver into it and dma_set_max_packet_size() rounds both
> up: RxDMA2 to ALIGN(max_input_len, SZ_4K) and SWDMA to
> ALIGN(max(max_input_len, report_desc_len), SZ_4K).  read_dma_buffer() bou=
nds
> the copy against those, not against the allocation.

Hi,  HyeongJun,

It's not a problem.
There are two layers buffer in THC driver:
one is in thc-hw driver for HW DMA, which initialized in quicki2c_dma_init(=
) by thc_dma_set_max_packet_sizes();
one is in quicki2c driver for HID, which allocated in quicki2c_alloc_report=
_buf().

SWDMA will use the buffer and size initialized by thc_dma_set_max_packet_si=
zes(), it's already the max one, so don't worry.

>=20
> quicki2c_get_report() reads into input_buf with prd_tbl_len NULL, so noth=
ing
> programs a length, and a device declaring report_desc_len 5000 with
> max_input_len 64 overruns the 4K buffer by 4096 bytes.  The RxDMA2 leg
> additionally needs the I2C max input size clamp to be off.

Quicki2c driver has different buffers for different hid report separately, =
so input report and report descriptor have different buffer with different =
size.

>=20
> Size input_buf from the SWDMA packet size and keep the 4K floor.
>=20
> Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC Qu=
ickI2C
> driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
> Not reproduced on hardware.  Triggering it needs a controller that sends =
more
> than the lengths it declared, which is the case the existing comment was =
already
> written for.
>=20
> max_report_len is reused for the report_buf allocation below, so that buf=
fer and
> qcdev->report_len grow with input_buf whenever the SWDMA ceiling is the
> larger term.  Both stay bounded by that ceiling.

SWDMA can be used for report descriptor retrieve and manual input report re=
ad,
quicki2c driver already set SWDMA buffer to max(le16_to_cpu(qcdev->dev_desc=
.max_input_len),  le16_to_cpu(qcdev->dev_desc.report_desc_len));
so it's not a problem, that's why you never reproduce the issue.

>=20
>  drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 0d2ad7bc3648..f6f9f95296d3 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -602,9 +602,12 @@ static int quicki2c_alloc_report_buf(struct
> quicki2c_device *qcdev)
>=20
>  	/*
>  	 * Some HIDI2C devices don't declare input/output max length correctly,
> -	 * give default 4K buffer to avoid DMA buffer overrun.
> +	 * give default 4K buffer to avoid DMA buffer overrun.  Both RxDMA2 and
> +	 * SWDMA land here, so cover the larger SWDMA packet size.
>  	 */
> -	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len),
> SZ_4K);
> +	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len),
> +			     le16_to_cpu(qcdev->dev_desc.report_desc_len));
> +	max_report_len =3D max_t(size_t, ALIGN(max_report_len, SZ_4K), SZ_4K);
>=20
>  	qcdev->input_buf =3D devm_kzalloc(qcdev->dev, max_report_len,
> GFP_KERNEL);
>  	if (!qcdev->input_buf)
> --
> 2.43.0

