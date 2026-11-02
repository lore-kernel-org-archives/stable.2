Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616689;
	b=LxIae+a/VN0j4mUvBpuxup5kKBW2PAFnx5TvnNAhbpa/SLiDp3KB6LE2PvXHEt1s8dtD
	 DFNVBR89s945Q82NF5G3pgSkZ/fadMv3+O8DhA72VQ2yR39iJunm2ZPPD3JE0qMWoVu43
	 Y0CCGPJJET/h+TaGITkdNiYYJMp2/CNPhlQi1LlPDoaj0oKeKySgG46Ft0cdrYacjPd+Z
	 OrTT1Pvb+3S4BRAHHZC0k5sUXoP26Vx6RvaIJPLfYQjlENOpWOjnKtKmA/Ci0BqrOWqFH
	 HWDf1KAJwdkGNWyzblw3z/6vk0MEpSX/EBI+AguBOqjuoFYe4T9p1qkouS+14Dipyaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616689;
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
	bh=saGM8VXaNGQOFlA8ntrLIYkSV8ZkbRLtN7MAMJ+3s3w=;
	b=tblvswQD5opcveBeSLWoSHMjQK9yGOc6oLwg8gfI8Ftcd/kLoK+GkCiY2ihuBzm8JTO4
	 sMzsQN6O6Hx2toQ7JnJB9wf4yCqio2JP85qwEX+sOMFUCuOtdeEPis9e+72u6eryBLUFv
	 8sZMmfvWrfHMRYWOMDY6HGwr1b+nOfqq8jMlj+VUXSmOCGjEIZRi6qrsKTlCnRxQuNVmr
	 3VsiBo1oCa7habInhHbQF73HKJtz7QXJaQNcjn9BpxG+7RABZ8sKYZAw7RqPmYwl3mBIf
	 wWowpB92d9x5amoig0c+kQUs+otgYVVDCZERDH3yu9Xu7fKC3PHv50ZL5hp2kdsfH3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jz0tt5up;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B6606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3B6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jz0tt5up
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616688; x=1825152688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=saGM8VXaNGQOFlA8ntrLIYkSV8ZkbRLtN7MAMJ+3s3w=;
  b=Jz0tt5upW1s6JlKE0Zq/A33r0vPEIn1kpsWFov5a5CCEkTfkRqu9zw5j
   ZvSMyAPG0RWPDp+Cy/co0E29LRStrY/gvvQTLbrlvKjtrn/Iip3ec7GM9
   xZz2zMZUMDoZtKLoeNdZl7jpe+VLs6L7RUMxGKoUtqoY+vwHUaG+1KiV0
   qxkUzJlxSDrQCatbN0iky+5q/BIPz0Em7xWIitDdDDYz+eJ18Fnhoymup
   UcZA0dfMraAZ9l+2GBzMfIGc076HCyl/vLSmjciDzfObEzefnhWx9FOTs
   xAMNAcYllWyJcgli/I0lFNBPb5fSqzFhF180AkV3YGv7mEWLQzWgz2qKj
   Q==;
X-CSE-ConnectionGUID: zbAX6BsSTRmqhYQw1JMtgw==
X-CSE-MsgGUID: X+lyZkzPSJC5XbqX9nW+Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2313356"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2313356"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:51:28 -0800
X-CSE-ConnectionGUID: 7C1H2CM5TzCaAlf61YeuWg==
X-CSE-MsgGUID: hUtbmtpjSIKboAbUBOl3/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6439185"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:51:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:51:27 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:51:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:51:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUjpQiBFU3zSVKaWm/JckIBDZlFe7DlFY9DC/ojXSzgK+KrqJ5XY6HyjcvoWc3SSWEkhf8i91sZHrNxsZJEh2HvNJax4xMNIh39HlkElwByRh9WjBvveWZUgPXa6JikCNg6FKIZdkOBwPG0CjUi45d6R723MBsgMrItGDXAR+GQvH46415QaCFYU87h23AddeuoJ6x4BS6RqTY7PDXqsuikMWb+PpOytRosXCaxmH6zbyJcMyFWiD0Z1PhedbNjLlGf0t3bqumwnO/wQvtAVOzaC9scM3VzkfKDY+SkqNf0QFUqEG2rcOpfDAkViA1SIZBdhHgWtjDDTc1lYYnOfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saGM8VXaNGQOFlA8ntrLIYkSV8ZkbRLtN7MAMJ+3s3w=;
 b=qmPqZxgRz6prWAvOupZeV5aGz2Q5R1vKuWDybzx7hIfIRVGNN91NVyoQS+WWdeIsriXKm57IBcVzVQI8sOJLqZ5CpR45+h29V3x4Dmp83/aIoQavmab5XgHGpX+CZOjK48CMrV74fXAx1+1w6XeJ02/C03+wpBfs5l7i239GahrSubRDs5sZtNOEsGQXMA1s6+AuWBex/izvCwtac44wi8aJojtSWbFaeHlR4bBHOvnnaFrCbE9gS34EnmzlnhpCbqvahXQzNwAiU8S0EAUAQfkYIcFGx5D3MxXSTxpRI6as9NIrclxGLbdJhGJQLrwx9xo63x0xUxfDNc5kOzHV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by CO1PR11MB5106.namprd11.prod.outlook.com
 (2603:10b6:303:93::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:51:25 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:51:25 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 4/6] drm/i915/ptl+: Add TypeC HPD pin selection for port B
Thread-Topic: [PATCH 4/6] drm/i915/ptl+: Add TypeC HPD pin selection for port
 B
Thread-Index: AQHdZ5nVMMP7RJzsW0Kbs9UphN6eU7caoO4g
Date: Mon, 2 Nov 2026 10:51:25 +0000
Message-ID: <DS4PPF69154114F35B5B2B302C7CE20B9EBEF6A2@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
 <20261029113017.618286-5-imre.deak@intel.com>
In-Reply-To: <20261029113017.618286-5-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|CO1PR11MB5106:EE_
x-ms-office365-filtering-correlation-id: 08b661c6-1cec-4573-d93b-08df38cf3d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|4143699003|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: nJ/9ga62EO2eR2xysNNHfQv7fAIJF+BCRA59n10b/6qeGcBr6AhQgP7kOaCe8blbqBG7DvnH1QalD1RovCmH6LpFDcAr/JHwIUT84V6syNX+DL57wzjkxC9tkKfl6YYoaVzV3Fq1f5F+5m7Wy+n35JCOzBOLdVl5zn7DGD+3X1cxSb/5ZEKHdGL7Kx7Ep/jkwTz6ENpQjPHq0mvOJP6K3vBnGG0GeKynCSIxunRTozk5VtK4zRV3l+MfozMlt+z5bLP0yVHmBSLSf79TBQalbQNnXXjvYeqHoKpz8Zm88Plf1y8YEgQkWn90UHa2ilRd3lmPcbl9xINpBWOUfVF41DFdiWB7tJcFh4IpDSc/mpQuf3pgYYl5uvyz0bbdnKJKQuZpXRs7zG2iFpyE5qyvOzz5h7yLTs10ZYRHqz1DrALV2VR5lS58T/iH5pkawq3yinzCe85V//aLZ0ONJDORaZccdminAKsL4K61mS3E7oKDv4ZmmY/oYiGMv3n77j5MahnO2rLtSxB2TJwVXxCPvQU9C3xLPgTzub6ST981MwQfN6DSHr8qN0cMr70HnLBG8cmMzNgSmbOvji0xmRICjG/9lL+ac0re1ZCiFGPlKCbyzMEKDzznvkFD/1EWgEkxb4wCbvEvMuHaqFtRtvCI94iaxYzYDw4BW2wRjy+IyGJz7ak+335fOExoBLChHSSt1aVZpZHbE3Bdth1kXeyd0FJefWIZYaknZ0YDTFa0KyA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzF1U3gyT2l2UFZNR2N0WVZTbDZrTHBnWHlMaDltaXEzbFdSUTRud0c3WlVW?=
 =?utf-8?B?QjFpbENjOExvV3lRRjV2OTBad05od2JGTThjZFdRRkd4TG1XSEU4UitjNFFD?=
 =?utf-8?B?U2g0YklGTzVVWEZ5azJpYTR0VG5jS1QxS2hVTHc0VmVsYitybTdqM0E4YVR2?=
 =?utf-8?B?ZW14RW81L0w4a25QY2pVaXhEeWZiT20vUFVsTFZoSHpXcEEzVEV5eDVLS2hJ?=
 =?utf-8?B?VjNQZmZkeGlKMTB3Y0JBQTJvVzliT1V4MzkrVFQwVnd3anhjMFR5N1FNL3Z4?=
 =?utf-8?B?ZWhQOEM3TVFXeVRkZnEveE01RGZEckZZNG5odU9xbkdFMXl0bE0xMW9VUU9Y?=
 =?utf-8?B?KzdkYjJ3OG02bUdrcUp2bVlmRkY3bVRlVmRqRHd0Zkp3eGVxNWJjMUlYQm1t?=
 =?utf-8?B?YUpMaDN6c2ZqT2VXSlhmNDFhMGhpVCt0c05NMVN5SnRGc3oxcEh0T0NEcHBC?=
 =?utf-8?B?N2JPUlk2UDlhaFl2dEhtMFNvNVp3THkydXlncmg5c3pmWERoUmJCNFdaTG9t?=
 =?utf-8?B?Y3VhVzF2d0dMNjVLQmtydjM5SThOemNFNFZha3Jld2VUUlJiSzQwbnB1KzFH?=
 =?utf-8?B?S09mSjdKSk1KK2dUM3htczhyb0xsL3RMM3BCN0xZZWhvay9hYWtSTWREd2FK?=
 =?utf-8?B?dXlKV25rQzB3REVqa1lBUUVMYkZQODhpbzFzd2poelh2NytJamVEVThoN205?=
 =?utf-8?B?YnZ5U3FLeHNORUJEU3I1bEVDTkZYTEM4OVQ4NW1MTktrMGsxcFhXZ3hneGZp?=
 =?utf-8?B?aHlzSVdxT3VDQTBIeFJMZW9mUXVidXlRZDJNRm9xYTVoNEcvMElmUWllMmVJ?=
 =?utf-8?B?REd6V3JtTXdid0VDRnVpZGRTYld1eTd3NUdpcGZCcmFwSlpQWXNOdFh5RmtQ?=
 =?utf-8?B?MjY0cXNHc1QwYkNkV0lURVU2c2s4ck0vNFNUVVJqWjBBM0NNZEVhNEFQdnB0?=
 =?utf-8?B?b2o1MkFsTmNxMjRUcGFzRkQ5NUJXbENkTlUvcmVlOXFuSkc2ME1yakEzOUw3?=
 =?utf-8?B?Z2pFSit2LzNvWHNpOUt3N01jYjdRQkdYU1NlOW9uZU9NbFZLV3Vpdy9Ec2gz?=
 =?utf-8?B?S0hmdzQ1K0dWaTlSWFFRYW9kclp0bHNmR0dpSHNOT2JoeGwyWUpsNi9CZGtV?=
 =?utf-8?B?SW5nU2Fod2F1TVpmWTJod2FwZUVLUzRJY0xjUk4yMWcwYk9mYk9Fakc5RHRC?=
 =?utf-8?B?QzVReUs0UXh4Q243aG1tdVhiWUdQalBkU3NIakh4N0JnU3VTMUYyNTFBNGZF?=
 =?utf-8?B?cm1FM2QrWG96ME5tSisvMkxKbTBNaUVjM1pXeE5laFc2bitjNFcrU2NKTEtZ?=
 =?utf-8?B?eTFZeStrZkpzWCtIRlJ1RktoZWRicGNaZllHTU1YRHlUNDJoUXFabkpKbCtQ?=
 =?utf-8?B?MitPSzBPVk1IL2VraDdMNTdqRXdUY1gyMkU2Yzd1TENqMVc2TGxkZHlnTFNS?=
 =?utf-8?B?N2U1SUV0b05YQzRyWGxaNFJ6aXdNRE1xcGdXZVFqSmU3cUZwTHZnbWdHQzdz?=
 =?utf-8?B?eHdZZERpVXlHZHMwaUFzZzNIMWJTbUdobmdJWXdXSVVpNzZFcFJCNVFLOUxJ?=
 =?utf-8?B?c2VtRUNWbzdPMlVMd0p0THp0NE1QUlFuUzNoME41eVlNaUppQUVZUldhWjBV?=
 =?utf-8?B?MDJiVU12WUF0WEJ1ejZ0ZXJJRzJCcGJLUVZ6V0xGWDZGWWFMcGVJSHFTTG9W?=
 =?utf-8?B?TWJTRHF3c3I2UHRhUDA3eUozclY5RG1UT01UQlh6aFhQbUZIbUNxbkZOcmZL?=
 =?utf-8?B?WlVDcVBFWVhxaWZodUpVZG1NSnZrQWVWNmFEb0FqQlJOWVcvVzRZTzdDb1JO?=
 =?utf-8?B?QTVDbGRuZ29MR2x0R1d5M3k2dHJ3M0I1MnB6eUNVUHo0aEZFY2dsVWJnL0JZ?=
 =?utf-8?B?Y2RTVkM1WEtNR3JJMGVFYzJ2RzB1RTI5SDFodmMvandITmpWcE1NeDdHT1hO?=
 =?utf-8?B?dmdKbDZJclpXK01ENkhmcW9DcmRsdzlhWVVwclExQmZlUncvVG1HTFpzcUFU?=
 =?utf-8?B?em5wc2x3c0taNWd2WktQSisxZ2lqWGpINjEvTjFHV1JXa0ZySU8vYjltSkNL?=
 =?utf-8?B?L1pzYmpCeGxTOXJ6Y04yQWhNZUNzNDlpVnYrYmhrRk1BbVUrQWdkVDQyWUJ0?=
 =?utf-8?B?K2Q4VnlhNU01OGE2ZklkZWRFQkRWcVMrWUZVYzZvT01BTDM4QURFVWV4Unpt?=
 =?utf-8?B?TVdxUkZ2SEVpRzhnaWJmN1NUb1k3ZVZ6bzR5RVpJQ052RUZBL01jWXhoVDds?=
 =?utf-8?B?Mk5wcVBZOXM3VURRNTE3K2IxUUZVTDk4bTRxZ2hEQ08relBoMVRzbFdIbjFY?=
 =?utf-8?B?cmJkRHgxcmRIejMzakc4WmVSZDFmRFVCdVJwaVZ4ZzBUNW9sRVpQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: azHO9HS5682OowmACWkMdwlMAKX3R2OBIsD/5KRAe474vZOc/ePPODb6iLYPRV53ROmlmwx/CSBnjgorNiNEaQDpCTkfYcv/pFp0qZpGa1//o5OtQ9j4qprlg99LtP7LMnC2bxuT0kyrPkonzSlgmy2+EnpMW9z3h95O6GfMLd8rmVMmmzIKpT23y7/iFaUjsLE2z/6Hr9uagl925YzyJKDXrJl7riATJAt1B2yqmiSeWI4HIL+YkQ0wHYKTSrB0Qfg2H5qHAI0yk7jBc6WHhd82t11Zhtq0l+UAOg1KlHIo8atLD+yMUxa9CxGJ+Qi1cK1CI7Djgs5hpqEWomqWvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b661c6-1cec-4573-d93b-08df38cf3d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:51:25.0989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCxfIBKLxbwyV594hOp0GKVPALUMYr/P0b/QZ6jaBP1kMxqvY5URF84KITyY5ySuGedQUzKAcIU8Trc1Fk7wdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBJbXJlIERlYWsNCj4g
U2VudDogVGh1cnNkYXksIDI5IE9jdG9iZXIgMjAyNiAxMy4zMA0KPiBUbzogaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCA0LzZdIGRybS9pOTE1
L3B0bCs6IEFkZCBUeXBlQyBIUEQgcGluIHNlbGVjdGlvbiBmb3IgcG9ydCBCDQo+IA0KPiBIYW5k
bGUgdGhlIFR5cGVDIFBIWSBvbiBwb3J0IEIgY2FzZSB3aGlsZSBtYXBwaW5nIHRoZSBwb3J0IHRv
IGFuIEhQRA0KPiBwaW4uIFRoaXMgcHJlcGFyZXMgZm9yIGFuIHVwY29taW5nIGNoYW5nZSB0aGF0
IHdpbGwgc2V0IHBvcnQgQidzIFBIWQ0KPiB0eXBlIHRvIFR5cGVDIG9uIFBUTCsgcGxhdGZvcm1z
IHdpdGggYW4gZURQIHBhbmVsIGNvbm5lY3RlZCB0byBhIFR5cGVDDQo+IFBIWS4NCj4gDQo+IEtl
ZXAgdGhlIGV4aXN0aW5nIHBvcnQgPj0gUE9SVF9UQzEgY2FzZSBhbmQgaXRzIEhQRCBwaW4gbWFw
cGluZyBmb3INCj4gREcyLCB3aGVyZSBQT1JUX1RDMSBoYXMgYSBub24tVHlwZUMgUEhZLg0KPiAN
Cj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjE0Kw0KPiBTaWduZWQtb2ZmLWJ5OiBJ
bXJlIERlYWsgPGltcmUuZGVha0BpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBNaWthIEthaG9s
YSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9kZGkuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2RkaS5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kZGkuYw0K
PiBpbmRleCBkZGE5NTcwOWM3YzczLi41OTUwMjQ2ZTQ1YTA2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RkaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGRpLmMNCj4gQEAgLTUwNTMsNiArNTA1Myw4IEBAIHN0
YXRpYyBlbnVtIGhwZF9waW4geGVscGRfaHBkX3BpbihzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlz
cGxheSwgZW51bSBwb3J0IHBvcnQpDQo+ICAJCXJldHVybiBIUERfUE9SVF9EICsgcG9ydCAtIFBP
UlRfRF9YRUxQRDsNCj4gIAllbHNlIGlmIChwb3J0ID49IFBPUlRfVEMxKQ0KPiAgCQlyZXR1cm4g
SFBEX1BPUlRfVEMxICsgcG9ydCAtIFBPUlRfVEMxOw0KPiArCWVsc2UgaWYgKGludGVsX3BoeV9p
c190YyhkaXNwbGF5LCBpbnRlbF9wb3J0X3RvX3BoeShkaXNwbGF5LCBwb3J0KSkpDQo+ICsJCXJl
dHVybiBIUERfUE9SVF9UQzEgKyBpbnRlbF9wb3J0X3RvX3RjKGRpc3BsYXksIHBvcnQpIC0gVENf
UE9SVF8xOw0KPiAgCWVsc2UNCj4gIAkJcmV0dXJuIEhQRF9QT1JUX0EgKyBwb3J0IC0gUE9SVF9B
Ow0KPiAgfQ0KPiAtLQ0KPiAyLjQ5LjENCg0K
