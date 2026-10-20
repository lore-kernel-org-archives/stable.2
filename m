Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792497649;
	b=aAKmJisWhmjh78j/v4uKMN8K/n9Uq455X6Nsfe626dzYAQgGXVeYHb4hljugrDAwSL7g
	 HBzK04bs3cvTmX7DHHeg2Oh5PVDln5nRYPJPZtDZVsFYwuNzQ1rRB/RFH9PYcfht3J1sg
	 OBfmcacW3q8xYvi9bh6MAuk319FdGdLROR7bmJYOYVrbyq+WKqbiUA1QDUptFBobmS1hM
	 NQKHXYTSNBdr4Xilcb2TMqW0eVCCPLg10DqCFxVI7jmXrpEizlM8rUhiZj6kl5tEoTqnd
	 jNqluorcxG0veZDKEjCU0rf3PAuagnFHNGdeN/kQl5aQpWi5X9sr7G/hIaYbQ0lDpww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497649;
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
	bh=FBoqE2iIjVXl6zKqkMl6unVARQv4xv7dwY9RTqbg+Bw=;
	b=GgXvM90P5/jdpc9ObReGeSrWABW4scyU5LDeh1XrpvdY6fnTSV36y+r80Rca1AkHGX4i
	 KwhXvIJwmn3JnxvlLyOrZ1YRugrCTiRi+U/uCum4QaNNY6zOrCOibPCNJf6CC0RIOTiaU
	 lLc5q9aLfEqF/OjlPA7lxbcoRNwzSNbVe/3+GZAhBtv9S5yia3AHQB7Sglb+YXeSrYS+t
	 uzQvYzRgMnaqCDO5LDPNN2TvaXM+TMPDpI5Qpq2Zn+OOUdRSVQ5sibZRe26pU9Ip+JzOC
	 6NuVmOBC8WOhyHN19BBi50RphFSkDuvOQ+gHXAIq00MOfgEsKEp36+3A7ajFJMOaqBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E8EiNcSV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE5606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ECE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E8EiNcSV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792497648; x=1824033648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FBoqE2iIjVXl6zKqkMl6unVARQv4xv7dwY9RTqbg+Bw=;
  b=E8EiNcSVh00Vt8AwwhIeXlmT23g2+qnNdsDE9JdabiArZmSqcfgJk2iL
   90FZDZY+7OBpUyfhA4nWbalNSXnK/c8wf3JpKNPWG8gKRzSvV4tXZia5f
   Yhc/NU2I93AQklqnle7x6sU5M+p7/t/2RXfJYsDuvcemXt9UfzCgRKvwU
   +XkwnFcH+LWkwEeToxBdnL/SZsz7Kvq2loO59LiERmufPrcMAxBI2J1oY
   nLEFMfa3Nw6HfTlt803zPF+DlDb/Nlo290t5r79kkRVBv1C1S7KU3eehz
   Glu6f4nybi9mbWdxoFAZGZ5JZ2reOknSuqTHPDwVXfcSY4swONH30vM0m
   A==;
X-CSE-ConnectionGUID: JXw/eLlgTjaMNrRdeshDnA==
X-CSE-MsgGUID: FUgUfjO7QemeK2s6Aass+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1232132"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1232132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 05:00:48 -0700
X-CSE-ConnectionGUID: gH7GxUTWSaWx1rJI51CtMQ==
X-CSE-MsgGUID: 5JqaSy6ESMCufmxY3X3T0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3126038"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 05:00:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 05:00:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 05:00:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 05:00:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxVkuLVDhp31QXPaeoIV2nTq9ytSQp6ovcA7srzGF7pAzsPW34iyVAsr6NKZ1sb+Nbb+yF0oTNSU3kLPkyHstryPfLuTP6qYcsnGuDDIe6QeLOXDnz9+2LTQluSzqR04Xq0qZULs5KqdwIaNY3I86kYlAg8gNKIvWt7RrnQTR78Kv20ZQ9Y5c4AnU/rqQHAgUQOTxsRWe/bhwzT0Jr+tywgQPxlyEASdeK4F8qYu1On8q4cckEARAuJV98wFbqL5fHUPB7pVvz2VEsRpc5uSXnzAvMV+n0SZ8UyiEK61N1Xs1J3DpC9hK9wm0Sf1Jj5HE3DuclJi4ooeMKRwxFH2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBoqE2iIjVXl6zKqkMl6unVARQv4xv7dwY9RTqbg+Bw=;
 b=L8u1vYP53c4csd8ZiXh4kzK3LxIrRMCjd92dKLMTaJchvtpOQo9EDIV4+09rRwnSo20r9Oqym9xqBujH3ezNZssFy35pDGi2MZ0BtAT0Y8kkSf0AhQv47LzXSfSwfrhGpdstlQe2iPwQV7yH3rFN7deBFG068Bv09lq8uFx2Pavu7c1HOdrdJbXEkL8+fTzIv1cG1S2A/OBNv0AmiZwsDhlSD/RYPrGx1peXNC2erB85FKx217c2SO2qLTv9NH+mFAjlkcj+Hc2Kk9Bxuv+u4/ZJHLdCW4OEAg3n/aiL5/QT+lsp76SWopAlCJm6/019z2pmPlWUy+Wl7srYW85y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by PH7PR11MB5766.namprd11.prod.outlook.com
 (2603:10b6:510:130::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 12:00:41 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 12:00:41 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 3/8] drm/i915/psr: Disable linked plane sel fetch as well
Thread-Topic: [PATCH 3/8] drm/i915/psr: Disable linked plane sel fetch as well
Thread-Index: AQHdT/dF1SMUDkd83k2kdjMV/PWm0rcGdTmw
Date: Tue, 20 Oct 2026 12:00:41 +0000
Message-ID: <DS4PPF69154114F2B86A04538696692F02DEF672@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20260929094434.77129-1-jouni.hogander@intel.com>
 <20260929094434.77129-4-jouni.hogander@intel.com>
In-Reply-To: <20260929094434.77129-4-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|PH7PR11MB5766:EE_
x-ms-office365-filtering-correlation-id: 5277f604-7abf-4300-a538-08df2ea1c35f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|260925022911599003|56012099006|38070700021|4143699003|11063799006|261009223027099003|260925021311599003|18002099003|10067099003|22082099003|260925021911599003;
x-microsoft-antispam-message-info: hApTIqBjHDro3VLltH/EGDW+9HOaNqK5VtzaynCNOK6o/J6bdwB3MBMFDZqKoFgnSGeKkOTiS8sZhbKjkOTAxNe5P7OJ97WbhTGN1hXCS44AFI37FuhWZN66lQrOBFTvIq/um9wTbf7xb/DoIIdwAkhHPDEUHSEiYa3OkkNLhErmPT2ZEZ/2To0BRZgwbITz1DPopiVUwBnu3FhvHMx1bwMCdPi3Q0fqhvO8uncWta+l/tvEMlUyD8PzVM/1egXIesRI9lpZKOjBBe3PmBo2UQ5OHrL6TjOUoq83EUR/GUW0xDJXbFKva1mvZZXBHnnhM1GwaEZuB7+W1d6YUylVPfWMM9mxK3TlZ++q/356v2xewS2+c58gNZEA2gmRw5pftDuUBy0ane5hpKUz19TJg7+FrRQYbNTUIGncj7BFqgkCrngpQYygo/h4vEMAMXBHS0neGEExRH1edczrTJY9vv8BEGIirnq3epnuK2SMLSeQduqQiFbvT2eEcA8k3U9EkUX/LJUE8VWtlbKNBvlrst2IHwK6kCCX/k3AuOFV4WTbuNh5vS3jXU2tc/t8XKcNUvoLyVpU3Vse9cfl6Y+II/W7XRja1EVYcjoEeQkAf6gvwxqZ4nXRdyyeYdRLpi5ig/fvSYoPuBEwQ0X7CczueK5N4d4cyX/5Mwi+ifKp0M3+JTEFYyNUZjAgbxC0SkN8/kPWZHS+xVvYg8LFmKpNbndcO5l+iaPC+NXBamtbVVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(260925022911599003)(56012099006)(38070700021)(4143699003)(11063799006)(261009223027099003)(260925021311599003)(18002099003)(10067099003)(22082099003)(260925021911599003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHlvZTNWZk94amloRWRzdGhmMVRXdFlZVUZxSTJqTHV1SkFMRWFmdWFta0hY?=
 =?utf-8?B?cDdMWkpKaXJhRi9kY3JLZEc0OVlHUUVqcU53azB6Ym5UaVFOejlEem1UeFUr?=
 =?utf-8?B?WU0ydmlLYktmVGJlZnMzTXpZbUYzdDcyNXVWN0w2Y0svczNMVi84RXhzWHpp?=
 =?utf-8?B?MXlWTXRLTVZuRk52UzFHcngrR2ZlTjBHNzJuSEFnNzF2dWxsamx3bSs1c0xr?=
 =?utf-8?B?dkpZN1NPd0ovc1RQS2FtS2UxK1JydTc5ZVZmekw5R3pkVTROOWhBQlpQbWoz?=
 =?utf-8?B?Q3YxOGMwS2YrbmFUeXVuZ1dPQmV1dVdIVXhaZjEvSHU1aHI4TXZzcEdQRG1l?=
 =?utf-8?B?dHhuTS8vc1BVYnhXREthVHlLWGNQbEhTWVY2dTNuMnFDeXg3bU1ab3dsMjUx?=
 =?utf-8?B?TzRKemp2RVdZcHd5N3VsRGlzNlFXdFdBbGJMSndubkQxaTNZUzRLc3RxY1Q5?=
 =?utf-8?B?TVRMSmx1VFhkYlU4UnBlUUlSajl2bFQvOXNuK0ZmVzVMYXVMcVZrOFpoZEhB?=
 =?utf-8?B?N21uL05nTkwza01yTXhveVF6NzZLcWcwczFKYzUyZW4rNHMyZE1SU2NQSHZt?=
 =?utf-8?B?RTVseTJGOWg2ZTRDcjB1R3dFK2FDZkVOb1kyclFmUUtLR0ZqWThDaWRuY1BD?=
 =?utf-8?B?dTFJeEd2bzZua3hIMnY3SnFjL2NUeDhqRXgvU1ptb0tCMGpXYW9uem5DalND?=
 =?utf-8?B?WktVRWNkVXBqK3VmZ29YcW5Vcm93UDRRODRxSS96cXZFSE1PMEtKbEcwU3JX?=
 =?utf-8?B?RkVNbEZ6VWJwUXVKRVluWjF3MC9VYXRCWkRGRUdGSm5LU2xtemlBYVRNQjh1?=
 =?utf-8?B?VFZod0ppb1JVNHBLWTlpckJpZGU4WjdmVzBBN09pZVpSR2cwK2V5ZUhvOW9o?=
 =?utf-8?B?RWR4SmNIMnpnbWlhNm4wREM0S04wQk12cWVYMFkyV0VMZnNldE1MbHZlR3lL?=
 =?utf-8?B?QXhLNjhLQ21QcmZBQXhrenZsR0NYVWt0UHNGdjA1bHBwSzdVM0E1c2xhdG9B?=
 =?utf-8?B?UG05SUVvU1ZBcS9sbStBZ253OXI4enl4Ylp4UzhhcEx6cVVuOXMyMDVER3FI?=
 =?utf-8?B?VThob2pwbGplMDRZR3RJS1NRdWpoYmE0dDdWVTV2RXB3TnR1cithRHpscG9o?=
 =?utf-8?B?cjNNMTVBckJGQXZZbk1veGdnK0JmTTlrOGNQc05xUEw3b1FUeExsZGpkNDcx?=
 =?utf-8?B?T2U1ekIycm9VQlpMb0hSZ3FGU1A4aFBUYis3WXcrQkk0bXB3NTFZY1AzSjUz?=
 =?utf-8?B?OVhXdm9iL1UyNkoyczhSYUR2a3ErTllsamRVdDJ6WUwvdVBXc2laZktvcitr?=
 =?utf-8?B?aDEzc1ErdnByQ0dZZXNpa1dZQWFncS9BMEhMdmZRSXpOM3Viai80cTZNMVIv?=
 =?utf-8?B?SmRiY3pqRTBKRDFNbDNkNVhrYmRwbWs5VkZNWWFRc1dkNEY3dkYvb003SWtS?=
 =?utf-8?B?bXNOZWxNUUtEWW8vc1oyR1pxVVdkbHBrejFsZzg5dWVld2NyZzd6WmRRN2FN?=
 =?utf-8?B?ZUFMUjdrUzUzTDNFSjA2OTRIdVRKUEFOY0RROFJhZ3ZkcU1jTUpYVTZtL3RT?=
 =?utf-8?B?ZXpQMVRCQjVWclQwdWMrSXFsQVJka1RmMktVVkhYTzlWMkRreWdkeDRsMEQw?=
 =?utf-8?B?WTNiaExCN3lIRFd1MDRia0J5WldyYytERnVCOWNKdjRhVVg1ZjdJcG1qWnE5?=
 =?utf-8?B?a3RFeWRCMFRneWZ5R3lCSk9Mdm9XQ1pmZHRMSEs1eHRiUUZocHJrM1ErY3or?=
 =?utf-8?B?NTZpdFlmSmZHb2FqdWVRNHlLZ2tkZUlDK2hyZEdWbFQ1QTZtdkZHeWFWb2ZN?=
 =?utf-8?B?ZzBWbDRqU3J1WmRkOHY3TWZsYXZBWkhhekZhYjF3enZjVkhpTGtFK0JZaEhv?=
 =?utf-8?B?Z0luUytzM1cydDJYZ0l5dWdaaGlDcnYydUF2M21qeEcxNEIwUmt0OFppMXNr?=
 =?utf-8?B?d2VwZHFMR0x1b3hTemlQeW1zRzZ1R292cVBhV1plUGR5ZTFuYW5kRzhjVjI2?=
 =?utf-8?B?NlJRUXdIS2toVHFIelVyQXJUT2ZIODJaWVZ5VDI4TlNvVU5LU3J2WmRldWp5?=
 =?utf-8?B?Q2l0OEJOYmd0MU5kMGRhbTJQQWtZME5wVy9pbU84WGtyNWNPcklqRVlYZk5h?=
 =?utf-8?B?a2MzMHoxNTVoV2Y0M0NDeXhrQkdiei9yVnFOZ3o4QlpCOFBlRklXMVJSanlz?=
 =?utf-8?B?UGlCanR3Qm5rNHFyaE5XeWlzSmRBaklmT1JkZWJaYXlsaVE2ditFcXlUZy9j?=
 =?utf-8?B?aUpYenlONVZlZDFXejRpa2pEVDBzQUsyQ2tjald4NDVob0k3ZlNiQ0hNYmU4?=
 =?utf-8?B?dW12WEZiWEgvSlM5ZlpPalZ0T25hZmk0bGR5VzVhWlRlenJpYzh4UT09?=
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
X-Exchange-RoutingPolicyChecked: QfFDRRZoKt+6yLhi7zs3CY5o5qomFZfFVmh7flwrKkxctP78DjvSjFFUbfFS6O0w41NdSWxgyVw4sPqyMXXESVZ8egggwt8rcj2xmV2nezBHmQCkK/vWTsSbTyV+Rnzh13Z4ncb8VJFqzPZjy9A5QTFxkSca2NUjtCJIJZ1wpAGRnrsNQkb5p5w1fQPLjOw3PM1UcKrBzu4v9wXAWcQlts9D0+45oNSR/6CYkmfEDzBTUYlZ+YkAzYco0U1wQf+tuvdlmm5fa0df97CfXBNOaGCYIDQVoRVxGuzI1wWMzwX/Natg8pYEcA3oyLnVfwtPGrVeHaOrHFtbtq+nZE4PvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5277f604-7abf-4300-a538-08df2ea1c35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 12:00:41.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiLYnXGZJUyGhAbxVMQXkKHziXTj342q0Zrpdi2D+lfYelXfeuwCxU/JYMI/zoXGLFc+9ljyH7M+8XxsEtawBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBKb3VuaSBIw7ZnYW5k
ZXINCj4gU2VudDogVHVlc2RheSwgMjkgU2VwdGVtYmVyIDIwMjYgMTIuNDQNCj4gVG86IGludGVs
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBDYzogSG9nYW5kZXIsIEpvdW5pIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+OyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCAzLzhdIGRybS9pOTE1L3Bzcjog
RGlzYWJsZSBsaW5rZWQgcGxhbmUgc2VsIGZldGNoIGFzIHdlbGwNCj4gDQo+IEN1cnJlbnRseSB3
ZSBhcmUgbm90IHNldHRpbmcgbGlua2VkIHBsYW5lIHNlbGVjdGl2ZSBhcmVhIHdoZW4gc2VsZWN0
aXZlDQo+IGZldGNoIGlzIGFib3V0IHRvIGJlIGRpc2FibGVkIGZvciB0aGUgVVYgcGxhbmUuIEZp
eCB0aGlzIGJ5IHNpbXBsaWZ5aW5nIHRoZQ0KPiBsb29wIGJ5IGp1c3QgaGFuZGxpbmcgcGxhbmUg
c2VsZWN0aXZlIGZldGNoIGRpc2FibGUgYW5kIGFyZWEgc2V0dGluZyBzYW1lDQo+IHdheS4NCj4g
DQo+IEFsc28gc2V0IHRoZSB1cGRhdGVfcGxhbmVzIGJpdCBiYXNlZCBvbiBjb21wYXJpbmcgb2xk
IGFuZCBuZXcgcGxhbmUNCj4gc2VsZWN0aXZlIGZldGNoIGFyZWEuIFRoaXMgd2F5IGJvdGggdGhl
IHBsYW5lIGFuZCBpdHMgbGlua2VkIFkgcGxhbmUgYXJlDQo+IHVwZGF0ZWQgb25seSB3aGVuIHRo
ZWlyIHNlbGVjdGl2ZSBmZXRjaCBhcmVhIGNoYW5nZWQuDQo+IA0KPiBGaXhlczogYTRmNDc3ZTZh
YzE3ICgiZHJtL2k5MTUvcHNyOiBBZGQgcHJvcGVyIGhhbmRsaW5nIGZvciBkaXNhYmxpbmcgc2Vs
IGZldGNoIGZvciBwbGFuZXMiKQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYu
OCsNCj4gQXNzaXN0ZWQtYnk6IEdpdEh1Yi1Db3BpbG90OmNsYXVkZS1vcHVzLTUNCj4gU2lnbmVk
LW9mZi1ieTogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQoNClJl
dmlld2VkLWJ5OiBNaWthIEthaG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0KDQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYyB8IDI3ICsrKysrKysr
KysrKy0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfcHNyLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bz
ci5jDQo+IGluZGV4IGE5ZTkyMTUyMDAwMTUuLmYyZWM3YjBlMDY2OGMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiBAQCAtMzA2NSwyMSArMzA2NSwx
NCBAQCBpbnQgaW50ZWxfcHNyMl9zZWxfZmV0Y2hfdXBkYXRlKHN0cnVjdCBpbnRlbF9hdG9taWNf
c3RhdGUgKnN0YXRlLA0KPiANCj4gIAkJaW50ZXIgPSBjcnRjX3N0YXRlLT5wc3IyX3N1X2FyZWE7
DQo+ICAJCXNlbF9mZXRjaF9hcmVhID0gJm5ld19wbGFuZV9zdGF0ZS0+cHNyMl9zZWxfZmV0Y2hf
YXJlYTsNCj4gLQkJaWYgKCFkcm1fcmVjdF9pbnRlcnNlY3QoJmludGVyLCAmbmV3X3BsYW5lX3N0
YXRlLT51YXBpLmRzdCkpIHsNCj4gLQkJCS8qDQo+IC0JCQkgKiBpZiBwbGFuZSBzZWwgZmV0Y2gg
d2FzIHByZXZpb3VzbHkgZW5hYmxlZCAtPg0KPiAtCQkJICogZGlzYWJsZSBpdA0KPiAtCQkJICov
DQo+IC0JCQlpZiAoZHJtX3JlY3RfaGVpZ2h0KCZvbGRfcGxhbmVfc3RhdGUtPnBzcjJfc2VsX2Zl
dGNoX2FyZWEpID4gMCkNCj4gLQkJCQljcnRjX3N0YXRlLT51cGRhdGVfcGxhbmVzIHw9IEJJVChw
bGFuZS0+aWQpOw0KPiAtDQo+IC0JCQljb250aW51ZTsNCj4gKwkJaWYgKGRybV9yZWN0X2ludGVy
c2VjdCgmaW50ZXIsICZuZXdfcGxhbmVfc3RhdGUtPnVhcGkuZHN0KSkgew0KPiArCQkJc2VsX2Zl
dGNoX2FyZWEtPnkxID0gaW50ZXIueTEgLSBuZXdfcGxhbmVfc3RhdGUtPnVhcGkuZHN0LnkxOw0K
PiArCQkJc2VsX2ZldGNoX2FyZWEtPnkyID0gaW50ZXIueTIgLSBuZXdfcGxhbmVfc3RhdGUtPnVh
cGkuZHN0LnkxOw0KPiAgCQl9DQo+IA0KPiAtCQlzZWxfZmV0Y2hfYXJlYSA9ICZuZXdfcGxhbmVf
c3RhdGUtPnBzcjJfc2VsX2ZldGNoX2FyZWE7DQo+IC0JCXNlbF9mZXRjaF9hcmVhLT55MSA9IGlu
dGVyLnkxIC0gbmV3X3BsYW5lX3N0YXRlLT51YXBpLmRzdC55MTsNCj4gLQkJc2VsX2ZldGNoX2Fy
ZWEtPnkyID0gaW50ZXIueTIgLSBuZXdfcGxhbmVfc3RhdGUtPnVhcGkuZHN0LnkxOw0KPiAtCQlj
cnRjX3N0YXRlLT51cGRhdGVfcGxhbmVzIHw9IEJJVChwbGFuZS0+aWQpOw0KPiArCQlpZiAoIWRy
bV9yZWN0X2VxdWFscygmb2xkX3BsYW5lX3N0YXRlLT5wc3IyX3NlbF9mZXRjaF9hcmVhLA0KPiAr
CQkJCSAgICAgc2VsX2ZldGNoX2FyZWEpKQ0KPiArCQkJY3J0Y19zdGF0ZS0+dXBkYXRlX3BsYW5l
cyB8PSBCSVQocGxhbmUtPmlkKTsNCj4gDQo+ICAJCS8qDQo+ICAJCSAqIFNlbF9mZXRjaF9hcmVh
IGlzIGNhbGN1bGF0ZWQgZm9yIFVWIHBsYW5lLiBVc2UNCj4gQEAgLTMwODcsMTYgKzMwODAsMjIg
QEAgaW50IGludGVsX3BzcjJfc2VsX2ZldGNoX3VwZGF0ZShzdHJ1Y3QgaW50ZWxfYXRvbWljX3N0
YXRlICpzdGF0ZSwNCj4gIAkJICovDQo+ICAJCWlmIChsaW5rZWQpIHsNCj4gIAkJCXN0cnVjdCBp
bnRlbF9wbGFuZV9zdGF0ZSAqbGlua2VkX25ld19wbGFuZV9zdGF0ZTsNCj4gKwkJCXN0cnVjdCBp
bnRlbF9wbGFuZV9zdGF0ZSAqbGlua2VkX29sZF9wbGFuZV9zdGF0ZTsNCj4gIAkJCXN0cnVjdCBk
cm1fcmVjdCAqbGlua2VkX3NlbF9mZXRjaF9hcmVhOw0KPiANCj4gIAkJCWxpbmtlZF9uZXdfcGxh
bmVfc3RhdGUgPSBpbnRlbF9hdG9taWNfZ2V0X25ld19wbGFuZV9zdGF0ZShzdGF0ZSwgbGlua2Vk
KTsNCj4gIAkJCWlmICghbGlua2VkX25ld19wbGFuZV9zdGF0ZSkNCj4gIAkJCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gDQo+ICsJCQlsaW5rZWRfb2xkX3BsYW5lX3N0YXRlID0gaW50ZWxfYXRvbWljX2dl
dF9vbGRfcGxhbmVfc3RhdGUoc3RhdGUsIGxpbmtlZCk7DQo+ICsNCj4gIAkJCWxpbmtlZF9zZWxf
ZmV0Y2hfYXJlYSA9ICZsaW5rZWRfbmV3X3BsYW5lX3N0YXRlLT5wc3IyX3NlbF9mZXRjaF9hcmVh
Ow0KPiAgCQkJbGlua2VkX3NlbF9mZXRjaF9hcmVhLT55MSA9IHNlbF9mZXRjaF9hcmVhLT55MTsN
Cj4gIAkJCWxpbmtlZF9zZWxfZmV0Y2hfYXJlYS0+eTIgPSBzZWxfZmV0Y2hfYXJlYS0+eTI7DQo+
IC0JCQljcnRjX3N0YXRlLT51cGRhdGVfcGxhbmVzIHw9IEJJVChsaW5rZWQtPmlkKTsNCj4gKw0K
PiArCQkJaWYgKCFkcm1fcmVjdF9lcXVhbHMoJmxpbmtlZF9vbGRfcGxhbmVfc3RhdGUtPnBzcjJf
c2VsX2ZldGNoX2FyZWEsDQo+ICsJCQkJCSAgICAgbGlua2VkX3NlbF9mZXRjaF9hcmVhKSkNCj4g
KwkJCQljcnRjX3N0YXRlLT51cGRhdGVfcGxhbmVzIHw9IEJJVChsaW5rZWQtPmlkKTsNCj4gIAkJ
fQ0KPiAgCX0NCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQo=
