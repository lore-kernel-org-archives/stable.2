Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794411862;
	b=WVk40IouYm6ZCR5PA1lrGZ0iQX5vDFb1x5mXLkh58vJkJoXW6Ee4f/xoui4/w3gb/ZTt
	 LUTgPQ1CR9/le45vroJm3wXrKlnc/v0y8gVxLXTC2/frFzL6BkwhrA0GHMEC7q66wtcNZ
	 GaSPJqH89gGsUubFl+nFLIuR6FTahc6SVz+mdQxXI+4k479HVwKc6MVNkcW5edOWc0CxH
	 XdGZZbJh08gufclb8WYvtOWTsZ9uemsM8reNxCrTFa+njNKm5clIF73vfQa666C6qmIPT
	 PZmmNN9jtHD0zNJ8hVE49Y1rEoLKSE6i23hriFSeKTT88Cn2lA85gONdbEJqHhDS8Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411862;
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
	bh=TEdNsCq/f/rLe4tazrT4IB8EEhkzWxgpFESIKEFNN8g=;
	b=Ogvt7T1wDhZ/DxPqSegK6lTRXReO/NgaIELCPCH+PO1gFDcV8HgquCjV1evqgNRR8Hck
	 WTBxd4ifu1nvX4m7otx+pKG9o2/QLWXE3Vi/xUNEoYwCc5LBM2aibs5fQvqu9cQOs5hRE
	 U6maNdBd+Rc+vJ8NSNhuEurbhg8t9ku+AGHBV2ZnvcOKA5/ANUmLbrL/ZFFAFc2KDdkWa
	 8QP1CQO94itVWuwvF2xDQpC1MyuiI5g1sm6K8o9BkBvaCeFSjnQTglY95NQ/qNMSevOPI
	 OTcLMYffkr9WcPKjZdBSHGazJ2ho/m8nhkVrS7Ikg5IVvXrwuooesVz4PJt5vhCDITg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BB6XJoX/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FC606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 718FC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BB6XJoX/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794411862; x=1825947862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TEdNsCq/f/rLe4tazrT4IB8EEhkzWxgpFESIKEFNN8g=;
  b=BB6XJoX/B76phyAIwOhPneZW4nb/Vmx4kFS2SJnfhqMRFFeRZhyON7VT
   ZGKFNCDAatn27sICziyMHa3sa8s0HnVXOmf5g0xRrBlZabB5TjF9EK6LO
   oxhaXR4uP82beYCLV+vCbVBN149TwRoe9xvhOseMEvUVojZJ887OWb7+W
   cynMrv2vjEwqp4/yF5NLZ9CRW/ZKfx9kdT8elg5VYrN+S08BkzVWFwc17
   Rm0LciFX8kmZz6MS+PkQyYdpQzoYodBqihKb3rhF4jhldG77Ji/wyEFWv
   oVR87+IRNSVq3irRvyRPy3yRQG9QqZdhBoqmMABZPP4jg2XqOry338Vpc
   Q==;
X-CSE-ConnectionGUID: IfBNNG0TT3+kx9m8tGSrsw==
X-CSE-MsgGUID: UXdKnaGXTWeWKqmGRem5pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3066758"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3066758"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 07:44:21 -0800
X-CSE-ConnectionGUID: cS6pyU8sQCazsWh4BBaKaw==
X-CSE-MsgGUID: xVbebBz7RCCC2rLkaJ0aCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8617118"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 07:44:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 07:44:20 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 07:44:20 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 07:44:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkWIo0L4uQ7dLgIaRo8LtYj5kkFk/RNYZLkp479BRBg/xfn/4T8Ailx3A5aUnoMsWyrOGwFgCzJx/TlcjADr3SV35v017g3HV/YeYfVKsvIRCNcvN01M3Ngty3RzFs2cet6Cjp3087pdLtipeJAA2t+/dW+RajWERzDHkAoiwLnFx9IM1TeqgaUnEE2rPQfgwmcoKx3EMHhfIYJGyG6/6CPEmj8qiIxwZdWnjQ5FcoBi9rgyRF2YmSuCmLTvRdYSasKEka4dWzbeneCkFfyKcAVc6oiZta0xaoa2caV5VnogeuAj6nZJ3K4VIOwlUxYDResVpwAEE1dsrZp5ejfceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEdNsCq/f/rLe4tazrT4IB8EEhkzWxgpFESIKEFNN8g=;
 b=td7lm18om1CZCgbNg4T8kGP3qbHxKAQjYWTPCKV9vJ+3gIhOhDHZG8lTSnX7clT95o1YrOkVm7mV89qh1fF7bDLh1B6q8YY2IrfB9UEFacGrJOQ7UII2VKNnvkocTPCP12Z7PjwIBtox4AdXNv8wtTKJ09YhjKUdEphpbYlJJ6t+1V6Qt7fOI9VUFzmN2sAMTu4E+B9KR1EYQPCpgF3QIX2RXRHFZbfa6sUzEBvGiz4o9m59l/O1779eCpOZD410hcl5gdUTnY+aq4N7wpp5CHQ5K7E2DLIAVEqlSYgJofc1HpnFEI5PEc9yhD9YSkMFpJMMAZLK7Rakv5aSp1jU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6570.namprd11.prod.outlook.com (2603:10b6:303:1e3::6)
 by CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:44:14 +0000
Received: from MW4PR11MB6570.namprd11.prod.outlook.com
 ([fe80::63e8:6dc8:402b:36d1]) by MW4PR11MB6570.namprd11.prod.outlook.com
 ([fe80::63e8:6dc8:402b:36d1%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 15:44:13 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/cdclk: Ignore SWF18 in SKL CDCLK sanitization
Thread-Topic: [PATCH] drm/i915/cdclk: Ignore SWF18 in SKL CDCLK sanitization
Thread-Index: AQHdbSPskngIbpaGZ0aTeQTuf6mQ/rcfzU8AgAk7U6A=
Date: Wed, 11 Nov 2026 15:44:13 +0000
Message-ID: <MW4PR11MB6570922D801B6765441C4FA5EF712@MW4PR11MB6570.namprd11.prod.outlook.com>
References: <20261105124737.24456-1-ville.syrjala@linux.intel.com>
 <auzLYHTMuLVVktJv@intel.com>
In-Reply-To: <auzLYHTMuLVVktJv@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6570:EE_|CY8PR11MB6937:EE_
x-ms-office365-filtering-correlation-id: 9402d8dd-e18d-47d7-9399-08df400aa2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|261009223027099003|10067099003|3023799007|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|5023799004|56012099006|38070700021|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: d2R9UJG+60PGwTDq1PeMo6yJiJeuu2cG3yeYXk9KucrCbXXc74Z9InU6sGSvhsLOYzytcRc+xf62PR/rvM8GdaSamaz0j5hnAhEFpxcqrH0xD0e/jNBpNYlMc7z4mpVocnWsYDn/dKLBrhaVR5gKIuGZxcSfSIEoaoayT+ioeK+1b4oG00nw+dnLPpt6VYq04CotVv1+tPzF//8gW0QrlWJLevkSQZ+XI1nftQosWdbycDBDmbrTNhIijBD+HHtW4J/BQO/4nKcltP4x28TjedwybwUq0vbfY+k6jfRHcPU3Brw/PDzEbnI11M8ZCpWQ8gGPZGYIuWSoIM64tJNZt7iZ6j+vlml384HzadXc7xzGNL0yGlB6gAex7KH5ncOGKbLHo1c5c4QTakQ/EHbjLCs/TifHf5U5v+khucC2My7fF8jrDMzyT9iBDi4l1w4pewlxUaUB6Dy53tCrCiSVsy/Or1b+f9puOEZt2iCDpnmksPtHHDziwt3x3g59fYDtcNcoldxcibQomtdpamFeEoOnlcYWoJL7OV4IydeZcFk0HemJETb/y4s/qeiuG80rcJzpJhyXNCABPefQtRt8/gLtqN5na6TGIZOIuYUKfZ5sVVA7n/5sEiXItSdz2VVTM0lICOgjIDmxMt5lgK9rkr6mgt/trIas4t2hSOW21ws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6570.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(5023799004)(56012099006)(38070700021)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUU5Wk1OV2hMWFl3THZtT1d5WjU0QXltaWswZUl2SEF3R3JOYksvU2p0UFN1?=
 =?utf-8?B?L2tjRFFldXYyVUtrR09NV29QZW5nM3NyYTEwaWY5bmlMNHI2WnNRb3hlLzEy?=
 =?utf-8?B?NXNReGxhMWZiWm9GZWhwellvMk80eXBGcnUybHplTm5ZTUF3bjVBdk8zTVBF?=
 =?utf-8?B?MEZ0N2lGSmltVVp3ajBSSTVmTkVKbDZuQkdXZHd6NWozTUlKSFVNbUxNTUtr?=
 =?utf-8?B?TkJ4NjFadTc2cjBERys0N3pWZ0t2NDBIeGpiODN6UkVzTG82K0NlREdwUk4w?=
 =?utf-8?B?dmc5N3M2WGRoK1M0T2VtNStUY1ZEOFZ2OC9oNnJ2QWNSNFJ3NTlJSzVNc2hi?=
 =?utf-8?B?cjYxWFA2RjRYT1prNnppMXpQd3FTT2pHS1BCNkY4ZlhDNk5uSlNQWlU3TkdJ?=
 =?utf-8?B?SFhoZmtaTUkva2Jvd3FlOEFydXRNLzRndnNIemhkaSsrMnA1bzV0dTZWNjJs?=
 =?utf-8?B?RzFVbWN5dUw5SUlvQ3craytSSXVNVzFrczA5U3BYRkp5TVRYMHY1SE9TMTdj?=
 =?utf-8?B?eHFUaEFLZ3VtUTc2a0NWckdUM2JCWnFmQnpLYVlDdVdsRERKMzNXdnRmZWp2?=
 =?utf-8?B?WkZGeDZmR1VpUmNXRlREWGhuTHFpemp5RldiakJ5RmpqdjVObEhuWTJyRzA0?=
 =?utf-8?B?VWdPbzVoZkRpM01uaGUyK1F4WGgraXRTWVdTVVp2Y2x6V05mU3Zmak5RVEoz?=
 =?utf-8?B?TTV3czZRKzlqK2dTS3VneCs4cVpqR0dFU3pOQ1NkSWtTenVrZk1sNmRDUENW?=
 =?utf-8?B?VnR6Wmx5RDJ2QUl5Y0hpam10bFh5ZnlTZWVyZ2ZBRk1tSWVOV09INm4zeFlm?=
 =?utf-8?B?NjRxcDViUWJQdTVhcGpPemdIZUk2OXZYakF0QlZqUDBTOWJHUXB6TkdUTDFV?=
 =?utf-8?B?VVpDL3dsV2ZkdXg5QTk3WHN3TEtzTjR0NVRqYjhKeGtqRWdlV3IwMnBMTEtG?=
 =?utf-8?B?aFBMZUVDU0FxWEJxQ3I5L3RzYTlDL0pWWENtNXJwTWNPMnlJbWwvMmtMRXZY?=
 =?utf-8?B?aENnRW1DOGVMQjk2YlRteUNQcTJZc1J4amZWSWRWZ2dWdHBWTWc0TndMZ3JY?=
 =?utf-8?B?M0N2QjMrNjRKWnM2STNBUHkrMW9xV1VBZzcxWDhVV0FicEJtOFFqZzZWQVFH?=
 =?utf-8?B?Q2MyaTltUkVxa0tjSDhUcUk2MDY4cDgzLy8xUFV0MHBGM2pxK2ZweU0yZDZs?=
 =?utf-8?B?SnRtRW5taEtPZW1kRFdFL0x5ZnVaQ0ZqQ1NzWFFXK1kwZkUzTGQ3eWN6b0dk?=
 =?utf-8?B?a1RwTHJaNXZDNWMyZG94WEExdzZiT2tJQiswZHlrWkg0MmovaGl2VGRoaVVF?=
 =?utf-8?B?UVVabmN6OE5URnNIUlN2RTlWTG1PV2N2bWhmeXR1UjIyb2RucGw5N2lPa04r?=
 =?utf-8?B?TGpEaU5CbzJTQkJvdDN1VFQyaURVajhuT0w5K0RYT0ErYW5LeEpsN1JKeWh5?=
 =?utf-8?B?djdHbWZqRVB4Zy9lWjl3ODNxS0gzSkl6UUw1QUtDaS9WQkhyOE1pbEdWRzZD?=
 =?utf-8?B?dDE0MkozUjlpcDFBNGtPUkwxbVovV2t5WG5zTUl6UDJGdGRJSW93WTY5R1ZJ?=
 =?utf-8?B?ZEhKMFlBOUIyU1FQdXB6MzNPZDdVZGVLdEhSZklVSHdBSkRHUFNpWmdiTklh?=
 =?utf-8?B?dDdYV1RtV3Y4SXlPMWJrYTIyR3M1b1pZOWRlQjZtZi9XWVFaamV5ZUlQOFBv?=
 =?utf-8?B?SG5BN3AxWHE5UVlQOElxcXhpUElrbDcxSDU2MjZDSUIyQmZyR3prSzlCcGpJ?=
 =?utf-8?B?NFN4UzR2R3k0NHBlM3VhZjF4bXBWdEtUUUNLVEVCQWUrTmR5a2dZSVk3ckQz?=
 =?utf-8?B?Um5WUXYxRnRENndJaU5zMTRaZUdEc0FvUGkzSThacldkay8zTFRCRXVPcW1p?=
 =?utf-8?B?UXRvTDFubC9USTRPbyt4bDFmOW12bkp3OVdEUUd6eFFCdEwvYmZNQ2Fjdmhq?=
 =?utf-8?B?QS8zTncvZytNYjJkMHYvUFJpaW55N0xkNW1XNkNVdmVEc0hkd0lsOUJRYzNv?=
 =?utf-8?B?SlErVXBsbTdaMTF3TVRKWUx3d291NVlxbWdCKzVEaGo3UXo5Z1o0bTMxTHFs?=
 =?utf-8?B?WmZaV21aTzdESGdLanhqUkxjMWYvT3Rmdm9CMUN2dkNaQUNHaHpueHBDODlP?=
 =?utf-8?B?TWYzMm5LbUVvV0JUOTY4TlZkYzh2VmdERmFpWDhPdEd2QUhwVmp2bjZJcGkz?=
 =?utf-8?B?elVhTnN5Qkp5dHBtcTZhL091dVp5Ykd2VzBsTDdPeVVTeWNiY2pueUY1eisw?=
 =?utf-8?B?Mkk2NVUvVmFFeFhKQVNPZldST3BrdkwwNSt4bnlwVDdJV1VjS3pqdU02ZXd0?=
 =?utf-8?B?WEtVRWlMRjllaHRaN1VSVU5EaTMvQ2dZVHRnZ2hwYWd1UERLVEFNUT09?=
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
X-Exchange-RoutingPolicyChecked: xz7O5aIPTsIBpM6gNNSb0hkg4heIEER03oATxFEsmOrQcFAkHvhTfUpguuhpP+3ffeeVJbqCnp+ZgK742kRYhmtEpG7TEcfGm0j2ywNplYS9EY0b6jwqy+piSQgtK3pq4DnvX8uxePFPWSJAcO1oMl3PX/4wxR193l9WnHzIX5DfM4jwLXDC8yAL7PjrseHtP+yUnvWY71dMZa3VNmeCZhxbV1BhfYqRoKYTSDfFE07ViFGYKE+44VLL6b4jXqGlPGUrfW428Y/0ZnsU4nz8F/efXk6NdRf0kRk6+hiu6AXm1sVErOa17qLli/fTpaHBUFfsNego5ljr6G4RgdpVQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6570.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9402d8dd-e18d-47d7-9399-08df400aa2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 15:44:13.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: podMl9LIEydotayk/gZt9045Aci8jubE6/5FYlheha9oqbaKuSsvq9N6wMi23NQaUKu2QuFdipMKq+9PHqDE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC1nZnggPGludGVsLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIFZpbGxlIFN5cmrD
pGzDpA0KPiBTZW50OiBUaHVyc2RheSwgNSBOb3ZlbWJlciAyMDI2IDIwLjMxDQo+IFRvOiBpbnRl
bC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBpbnRlbC14ZUBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2k5MTUvY2RjbGs6IElnbm9yZSBTV0YxOCBpbiBTS0wgQ0RDTEsgc2FuaXRpemF0aW9uDQo+
IA0KPiBPbiBUaHUsIE5vdiAwNSwgMjAyNiBhdCAwMjo0NzozN1BNICswMjAwLCBWaWxsZSBTeXJq
YWxhIHdyb3RlOg0KPiA+IEZyb206IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51
eC5pbnRlbC5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHkgb24gU0tML2Rlcml2YXRpdmVzIHdlIGFy
ZSBjaGVja2luZyB3aGV0aGVyDQo+ID4gdGhlIFZCSU9TL0dPUCBwcm9ncmFtbWVkIHRoZSBTV0Yx
OCBzY3JhdGNoIHJlZ2lzdGVyDQo+ID4gYXBwcm9wcmlhdGVseS4gQmFzZWQgb24gdGhlIG9yaWdp
bmFsIGNvbW1pdCwgYW5kIHRoZQ0KPiA+IHNldCBvZiBiaXRzIGNoZWNrZWQsIHRoZSBjb2RlIGFj
dHVhbGx5IHdhbnRlZCB0byBjaGVjaw0KPiA+IFNXRjA2IGluc3RlYWQuIExvb2tzIGxpa2UgaXQn
cyBqdXN0IGNvbXBsZXRlbHkgY29uZnVzZWQNCj4gPiB3aGV0aGVyIHRoZSByZWdpc3RlciBvZmZz
ZXQgc2hvdWxkIGJlIDB4Nio0IHZzLiAweDE4IHZzLg0KPiA+IDB4MTgqNC4gU1dGMDYgaXMgd2hl
cmUgdGhlIFZCSU9TL0dPUCBzaG91bGQgc3R1ZmYgc29tZQ0KPiA+IGluZm9ybWF0aW9uIGFib3V0
IHdoYXQgb3V0cHV0cyBpdCBlbmFibGVkLiBTV0YxOCBpcw0KPiA+IHdoZXJlIHRoZSBWQklPUy9H
T1AgaXMgc3VwcG9zZWQgdG8gc3R1ZmYgdGhlIG1heGltdW0NCj4gPiBDRENMSyBmcmVxdWVuY3ku
DQo+IA0KPiBBY3R1YWxseSBpdCdzIG1lIHdobyBpcyBjb25mdXNlZC4gU1dGMDYgaXMgdGhlIENE
Q0xLIHRoaW5nDQo+IGFuZCBTV0YxOCBpcyB0aGUgcGlwZS9vdXRwdXQgdGhpbmcuIFNvIEkgZ3Vl
c3MgaXQgd2FzIGNoZWNraW5nDQo+IHRoZSByaWdodCByZWdpc3RlciBhZnRlciBhbGwuIE9oIHdl
bGwsIHRoYXQgZG9lc24ndCBjaGFuZ2UgdGhlDQo+IGZhY3QgdGhhdCBpdCBkb2Vzbid0IHdvcmsg
b24gY2hyb21lYm9va3MuDQo+IA0KPiA+DQo+ID4gSSBzdXBwb3NlIGVpdGhlciBvZiB0aGVzZSBz
Y3JhdGNoIHJlZ2lzdGVycyBhcmUgcGFydA0KPiA+IG9mIHRoZSBleHBlY3RlZCBwcm90b2NvbCBi
ZXR3ZWVuIHRoZSBWQklPUy9HT1AgYW5kDQo+ID4gZHJpdmVyLCBidXQgaXQgbG9va3MgbGlrZSBh
dCBsZWFzdCBzb21lIGNvcmVib290DQo+ID4gYmFzZWQgc3lzdGVtcyBkb24ndCBzZXQgdGhlbSB1
cC4NCj4gPg0KPiA+IFNXRjE4IG5vdCBiZWluZyBwb3B1bGF0ZWQgbGVhZHMgdXMgdG8gcmVwcm9n
cmFtIHRoZQ0KPiA+IENEQ0xLIFBMTCBkdXJpbmcgZHJpdmVyIGluaXRpYWxpemF0aW9uLCB3aGls
ZSB0aGUNCj4gPiBkaXNwbGF5IHBpcGVzIGFyZSBzdGlsbCBwb3RlbnRpYWxseSBhY3RpdmUuIFdl
IGFsc28NCj4gPiBzZXQgQ0RDTEsgdG8gaXRzIG1pbmltdW0gZnJlcXVlbmN5LCB1bmRlciB0aGUN
Cj4gPiBhc3N1bXB0aW9uIHRoYXQgbm90aGluZyBhY3R1YWxseSBuZWVkcyBhIGhpZ2hlcg0KPiA+
IENEQ0xLIGZyZXF1ZW5jeSB3aGVuIGl0IGhhc24ndCBldmVuIGJlZW4gY29ycmVjdGx5DQo+ID4g
aW5pdGlhbGl6ZWQuDQo+ID4NCj4gPiBEdWUgdG8gc29tZSBvdGhlciBjaGFuZ2VzIGluIHRoZSBj
b2RlIHdlIG1heSBubyBsb25nZXINCj4gPiBmb3JjZSBhIGZ1bGwgQ0RDTEsgcmVjYWxjdWxhdGlv
biBhbmQgcmVwcm9ncmFtbWluZyB1cG9uDQo+ID4gdGhlIGZpcnN0IGF0b21pYyBjb21taXQsIHNv
IENEQ0xLIGNhbiByZW1haW4gYXQgYQ0KPiA+IHBvdGVudGlhbGx5IHRvbyBsb3cgYSBmcmVxdWVu
Y3kgaW5kZWZpbml0ZWx5Lg0KPiA+DQo+ID4gVG8gZml4IHRoaXMgbGV0J3MganVzdCBzdG9wIGxv
b2tpbmcgYXQgU1dGMTggY29tcGxldGVseS4NCj4gPiBUaGUgY29kZSBpcyBhbnl3YXkgY29uZnVz
ZWQgYWJvdXQgd2hpY2ggcmVnaXN0ZXINCj4gPiBpdCdzIGFjdHVhbGx5IGxvb2tpbmcgYXQsIGFu
ZCB3ZSBkb24ndCBsb29rIGF0IHRoYXQNCj4gPiByZWdpc3RlciBvbiBhbnkgb3RoZXIgcGxhdGZv
cm0gZWl0aGVyLiBXZSBhbHNvIGRvIGFuDQo+ID4gYWN0dWFsIHJlYWRvdXQgb2YgdGhlIENEQ0xL
IHN0YXRlIGZyb20gdGhlIGhhcmR3YXJlDQo+ID4gc28gd2Ugc2hvdWxkIGJlIGFibGUgdG8gc3Bv
dCBpZiBhbnl0aGluZyBpcyB3cm9uZw0KPiA+IGVub3VnaCB0byBuZWVkIHJlcHJvZ3JhbW1pbmcu
DQo+ID4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiBiYTkxYjll
ZWNiNDcgKCJkcm0vaTkxNS9jZGNsazogRGVjb3VwbGUgY2RjbGsgZnJvbSBzdGF0ZS0+bW9kZXNl
dCIpDQo+ID4gQ2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2k5MTUv
a2VybmVsLy0vd29ya19pdGVtcy8xNjU5NQ0KPiA+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJl
ZWRlc2t0b3Aub3JnL2RybS9pOTE1L2tlcm5lbC8tL3dvcmtfaXRlbXMvMTc0MjMNCg0KRHJvcHBp
bmcgdGhlIFNXRjE4IGNoZWNrIGZpeGVzIHRoZSBpc3N1ZSBzbywNCg0KUmV2aWV3ZWQtYnk6IE1p
a2EgS2Fob2xhIDxtaWthLmthaG9sYUBpbnRlbC5jb20+DQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBW
aWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2NkY2xrLmMgfCAxMyArLS0t
LS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTIgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9jZGNsay5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jZGNs
ay5jDQo+ID4gaW5kZXggOTJlNmZjYTg2MWY2Li4wZjJmNjkzYzc4ZDQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jZGNsay5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jZGNsay5jDQo+ID4gQEAgLTEyNjks
MTggKzEyNjksNyBAQCBzdGF0aWMgdm9pZCBza2xfc2V0X2NkY2xrKHN0cnVjdCBpbnRlbF9kaXNw
bGF5ICpkaXNwbGF5LA0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIHNrbF9zYW5pdGl6ZV9jZGNsayhz
dHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSkNCj4gPiAgew0KPiA+IC0JdTMyIGNkY3RsLCBl
eHBlY3RlZCwgc3dmMTg7DQo+ID4gLQ0KPiA+IC0JLyoNCj4gPiAtCSAqIGNoZWNrIGlmIHRoZSBw
cmUtb3MgaW5pdGlhbGl6ZWQgdGhlIGRpc3BsYXkNCj4gPiAtCSAqIFRoZXJlIGlzIFNXRjE4IHNj
cmF0Y2hwYWQgcmVnaXN0ZXIgZGVmaW5lZCB3aGljaCBpcyBzZXQgYnkgdGhlDQo+ID4gLQkgKiBw
cmUtb3Mgd2hpY2ggY2FuIGJlIHVzZWQgYnkgdGhlIE9TIGRyaXZlcnMgdG8gY2hlY2sgdGhlIHN0
YXR1cw0KPiA+IC0JICovDQo+ID4gLQlzd2YxOCA9IGludGVsX2RlX3JlYWQoZGlzcGxheSwgU1dG
X0lMSygweDE4KSk7DQo+ID4gLQlpZiAoKHN3ZjE4ICYgMHgwMEZGRkZGRikgPT0gMCkgew0KPiA+
IC0JCWRybV9kYmdfa21zKGRpc3BsYXktPmRybSwgIlNhbml0aXppbmcgQ0RDTEsgZHVlIHRvIFNX
RjE4IDB4JXhcbiIsIHN3ZjE4KTsNCj4gPiAtCQlnb3RvIHNhbml0aXplOw0KPiA+IC0JfQ0KPiA+
ICsJdTMyIGNkY3RsLCBleHBlY3RlZDsNCj4gPg0KPiA+ICAJaW50ZWxfdXBkYXRlX2NkY2xrKGRp
c3BsYXkpOw0KPiA+ICAJaW50ZWxfY2RjbGtfZHVtcF9jb25maWcoZGlzcGxheSwgJmRpc3BsYXkt
PmNkY2xrLmh3LCAiQ3VycmVudCBDRENMSyIpOw0KPiA+IC0tDQo+ID4gMi41Ni4wDQo+IA0KPiAt
LQ0KPiBWaWxsZSBTeXJqw6Rsw6QNCj4gSW50ZWwNCg==
