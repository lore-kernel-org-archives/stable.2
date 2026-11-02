Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793647725;
	b=ItByTkZJLeYC2VuC3FgCoIbYFKOtc6UPxRDsLRuHB32sNp/b8XK6sSpQQkY4411VDnJG
	 qQ9ClCBIDP1+EG4H0tP+3eGpqlPUkS+4nBcS9AEJhotuup8A0oVglbkR7xKF39m5gFciu
	 trQfzl0wm1E0pjqmlxRzx5QGRLHDxseaLRLqjnIbCUw7Whd1igcMlVAQYdk/Qj13DiS3X
	 h55ts895/k0u58QzsYq4zPGHYtfFSOwnoC72bl1YITif3mQjjOPZFN5miFPtszgKhfKuV
	 o6NQLh5oXiMZ+ndFcQ4bQpGzPZ39llFREC4ZjfOXO7PDVyYkT+eubx7LoNoMFlTBzuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647725;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=cyFANMWvnnUngKpYt59F1neud3hA13a0RiPOixLHw2w=;
	b=h8Eecyx0zTbL8g7q2Zj8ODpKrhOpRv+lozNoNpajGlJMJwTClybNow+extcUVQ1wpCke
	 Us3uEbjvvM9nHicjZTBZL7JiM70DpB0h6/QewTf96uYHpkIi/fnU1sUwlGVhuXjtD4dNC
	 Cn+pPdnvZr2Kv7zEQV3sP0b/vYnJ+FJ0TiaDFw8C/ljBOyRRCvXKbZ8se92t/KD6ht+iS
	 DFjitxd4zK3pFPyZ+E9hSQPxWPTVy3qCTjygfy8XA28H1ktthVRcKX4iGcHByF46/BxW3
	 OipxHWiUZJacLQy/SpjscGsOvTz6O1Ut5J0ppVrA9rxnMIT0+0nezmBWzQSadnpCzpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EueKEJd1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F6606A324;
	Mon,  2 Nov 2026 19:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295F6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EueKEJd1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793647725; x=1825183725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cyFANMWvnnUngKpYt59F1neud3hA13a0RiPOixLHw2w=;
  b=EueKEJd1+divww2DBq+AwLUWRZf2qYSzdqsiXzjnBzUx7Rp1Hz3l+ZTJ
   HiiFkztn3t1G5Bo6NPsGHyNH7++IK3jxsoCIRxryPih3CD2V5AZ2G6Yp0
   kN6o1gWefMwBpu+ddWhio2rs+Zl6eWfbdnX/nBANsI4YwlZFNiI0pMAOE
   rtwFle5kHRachZDWJsD8d+YBBOAinuL8Raqj2oyjdJmEDSQr3yp11GjIP
   bceHT2+D/o9yUhRit6y7tDCJGPdvz/kH88KjKxAaQCv56XZdolftSVXxX
   U1nTOF3A7pNSsoqG1NnGVTGu+8ATK+8EyHXqnYiVcIjQ5bQnZM8NZdZFL
   A==;
X-CSE-ConnectionGUID: r3sy917qSMSU7qFR2kCl6g==
X-CSE-MsgGUID: AuDWq+wXTGyhfhIVuU66VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2372123"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2372123"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:28:42 -0800
X-CSE-ConnectionGUID: aFYnEtH/S8e36XpD7lS3Dg==
X-CSE-MsgGUID: 7akggvwMRV+hXLFJCr1Beg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6044176"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:28:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:28:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 11:28:36 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:28:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFwWH/ipVqCCMB2TRnHOs2T1gMyRrnk8x3mM7qANVjjG+9fZqxsz/shzbpQf4YuO+qdbHcYiQm/I5I1oEY9TCFpBNRwrAjm2/HP9c9XvJW54QRHdvCwGhWLo+fxSgB/y7Zk0GSbYUN71YH3qB+LBlp7yuZ4S7d47gMsVXBvPqJ9/ToFKDwxcesdKlkGPfVuwDKrEfTs/8G55jCZv7ZCMk14c/9rH/mJPZknp+0a0Dgs/pgJ14N6MlS8K/7isT3iLscUy50crHIVtbJZ2poqS1g/ZD1NTWSJ/xD1pUUrmeHQnyWnFuvo2Kd3zQsYIqSstFH9n4w0GlHJou+9V53z0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyFANMWvnnUngKpYt59F1neud3hA13a0RiPOixLHw2w=;
 b=vWUqxZfYAlHRAjf/T9x+w20HICkcfKvLZHjWd3OxteOsUt1qUldx10c73TLj3MaU9p/sJXxaA/hE9i2iYmHDv5M4H9ZolpwiZVRvpTSoHqCcibz4sqPb+mtwLYoLHlv5f5N66dosPCAHgv0N+kXGZWbhSyOJsIIHuPkFkJaq6NA69v+djK2c5Q75XhIvEt5syMIqJjVnAMbamQjCMmij9nTQU+RAvrrtG2yJyUlLgwNli+AHlVsZSRhb1NDyRQ1UjY9cp5duEKfeqG9ClnjTbxzLP2gMMxAuJ4P5HGuf9Lf0LgWDE/1iY2IouimFomqBX5M+fd1xSunhwP8vH1vPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by MW5PR11MB5929.namprd11.prod.outlook.com
 (2603:10b6:303:194::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:28:32 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:28:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"challvy.tee@gmail.com" <challvy.tee@gmail.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "seanjc@google.com" <seanjc@google.com>, "kai.huang@intel.com"
	<kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH v4] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module
 is not initialized
Thread-Topic: [PATCH v4] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module
 is not initialized
Thread-Index: AQHdapxwH1SzV9F37ESZK5jT7jZqXbcbK3aA
Date: Mon, 2 Nov 2026 19:28:32 +0000
Message-ID: <223dd15d2740bf6d2010e3b4a295b22c559dfdad.camel@intel.com>
References: <07cfa95a-e766-411b-8765-33352a04c0be@intel.com>
	 <20261102073244.919864-1-challvy.tee@gmail.com>
In-Reply-To: <20261102073244.919864-1-challvy.tee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|MW5PR11MB5929:EE_
x-ms-office365-filtering-correlation-id: 94a2a82d-0e72-4f32-8d72-08df39177b3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|38070700021|261021121427099003|4143699003|5023799004|261009223027099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|11063799006|10067099003|18002099003|22082099003|261102123227099003|6133799003;
x-microsoft-antispam-message-info: wck/YyWoxPSlSpesPq3B656169CMaIzxRkb4Fem2hIhQ59LAyKKr+cWkZXw1MYqUjismsnTFNRm+Xj/FWAP2A4QurfxpBYlAjGjW6kTvzBob80HxdkT3V95Jw3TT7KZkD2p5/mFk9tmdGq/xeIs9c84GWIqbdPN/nCF94ZemWCIGvsXdr5nl3I91BrgHtYGqmMpcJ/CLIkUXP4s6NtPqSpowznt/kFHJxwSYTNT04CRlSy1FS3TE9N27ETj6AvN3Qoi5IglButU4M3Agps/1f3ljePq+kwV4jKP4CrHjZ9A1Hgf3bdn//DYXjwqwSU2n1LP77s2H5JK1+xJROheZxAi2tG+IsCN3j55c4ga9nTkcrgGmNLtDa16yt70IQxtzreH43l91cT9SFHCHyfW11nFgSlcrVtl9KdmH9lR3tz+0m365lnv8809QAl4nfqaczUb7CN5GqbncMDUFF+kbocRgvH0kJCCdU5+YjHlkTkcE1XzU0I8WuRG1cImS7U8H98lKAW+jQQLalAgrhHWukzSGND5HplTeziqMCbx/QHP8nv4eB2y69Oi/W7sL/Zb5uepZh5u9f2v5gObSZM1oz6pMKOIx/oucyOCDHJ4qBjcYgg8EXjTE2rngaXvLC9yFPI+C0NDZCnR/dO7t01RK72nQvofOHzHC3iOORiz9HlWoFhCJfy50O6AK625xiz6KAGRi43iYKooSupn78R0WSI2QuXJZ9jJBoYK3035Otek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(38070700021)(261021121427099003)(4143699003)(5023799004)(261009223027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(11063799006)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUhvKy9lZDdWd3RkZ05zSE4vRk1wYlJuZnVFdUM1NXRiT3RGa3lIak02RUFq?=
 =?utf-8?B?dUlxNUVUbmlzdnZXSUcrbnFOb015S3hoSzYwMWJyK3VBZm9WZXhYeUpHRG9C?=
 =?utf-8?B?WXNSc3hYRXNJMzJyekpkcytFSDZ6dzZldWJsTEpEOTlGRThZa2ZIRW9KVXpZ?=
 =?utf-8?B?ZnV3MjVWOU9Pa0tTYm80YXZ1dFNyTDJOU0JOYVoxM2J6VXIrRUw2dC9Tb0kx?=
 =?utf-8?B?UHFRYXFRNmg0NExnV0VnY1NWMTcrRnJXL2czMm1ydUxHWmlsMzdIQTV6NHpF?=
 =?utf-8?B?ZEt2SDdPamJtbm5YOGZIY2llNUExUExUTFFHa1BHMm02ZjhDZk8zb09rWkVU?=
 =?utf-8?B?WWw3MzFiRTlEbitoMFBJU091ZmJjYytDanh2QmRTUWtKWDJsOWVxVjQvOVc4?=
 =?utf-8?B?bHZ2MWNTT0JFaXU0c0dZNFZ6Y1ZPZ1Q3MTJQc3RxdGJnTVA5NExISUdBVFRH?=
 =?utf-8?B?b3BQZ3J6YVNGVTJrc0M0ajkyR2FVMlpzSmRZSWhJZnovVTMwejdIdE01ZTFw?=
 =?utf-8?B?Um9tbExkNW5OVS81ZGR2RlVVeU9BZWdTRzZFU0IrZzhkQjZFSXVrWFZUSFVI?=
 =?utf-8?B?bXlZYTAvY0I4OGVXTFhwckc4ZzhkUjFnM2ZJTUlSVmtHbytWZGJ2VURUTGJw?=
 =?utf-8?B?ZTd1dTBTbkRna3VHU25YZjVWeVVEOXRkTEEzc0VtbGd0Y2tvT25HWHBEemVX?=
 =?utf-8?B?RDE4bk9za29IZUFSa2dReTVsSUp1Mk9xaTVsUzZiT1UzQnBDV2djYWtpREtv?=
 =?utf-8?B?THZCK1NtVVhkNXh0R2JqR3JjVFM2Sit4TmtQUldhZzJLbUhjZ0JORFY0QXlD?=
 =?utf-8?B?VlB3dGRzdlJiMG5pYnlWWnlIQzV2dU51OHFiczRBV3J3RXlCL21EWFpMdGZ3?=
 =?utf-8?B?MzBtbE1lalBtVHlXaHdpWWtxczd0ZGE5cDJRaUMzZE1HV0RVVWxvWlNyU3Jq?=
 =?utf-8?B?NnlLVjFPY25QRW1UK1E1Z1hCS0VWY1Fnc1lvRG0vSVZVcDdidUVmenlycG96?=
 =?utf-8?B?eVVicHFtYUhGTGcrcmxDcWlEZk5ZYzlpRDBZQW1xaVQybHF1ak9BY2lkZ09N?=
 =?utf-8?B?U21BRFNVNFBFNDBaMWpJS29GOER1QWNVTzNZYXZqTkpnTjJXU0p0S3hDNzBv?=
 =?utf-8?B?RlpDK21zOVZkempPVDJjMWVNTllWdFZ0aXR5SUpxQ3FTTTM4NEs1WnlweGcr?=
 =?utf-8?B?bGYrb2N2WlIyc1VsUWovZ2M2Ykg0L2JITExMLzVjbnVHUk5PL29VZW1Hd1ht?=
 =?utf-8?B?RFFlMW1FTlRMRFo4ZjdVcXZhNXZBSnpoRzFYYVdyOFZwK1lPanp5T0h1L3l5?=
 =?utf-8?B?VHd3TEwwQW1TZ1JKdXBkaWpNdmlBR2ZhbEVIeEs1emEyRU50dU1tbW9HSVVT?=
 =?utf-8?B?dnJtU2dPNXRMemJzejg3VkVNWC9BTGtNVFVFU0hvMk8yWEx3QzFqaW9PYTVa?=
 =?utf-8?B?SEdqR0FPbWFQWTVTS1VXN29CeHhwSXNVMGN2QlpQUTB6Y1JYdVFtRXZxRDg5?=
 =?utf-8?B?Z3hUYU8wWTVYUEpwMng0cTlySUFjU3FNWGRnNDJvQU0zZjJlb3FXbnBXTkFQ?=
 =?utf-8?B?WldOU3BDZVAxSkN3a3l1UncwMHhzTEJXd2JVZHRSY0FxY0h5Y2gxUFIxQ1dI?=
 =?utf-8?B?WnJ4YTFFVkYydGoyS1hkemRteTJURDRvem1MSDF4eENENExGSG8rbTJaZ1hx?=
 =?utf-8?B?VjVFUWVxeW82ZlNnTlZLQ3lIWndPNjVtaFkxMjN4UVRzeWxpRktsM0h4VWwr?=
 =?utf-8?B?bEJMU0J4ajM3b0JXSlNwdlQyT3JJdGx3bmx1bktQMGV6VzVHS0R0Yzg4QUc3?=
 =?utf-8?B?YUZTQTJxckppT3B5SWRySGV2eFVXaVdBODdvcmE3UzUzaUV1L095RzBGdVhj?=
 =?utf-8?B?dmtTcTdvWjltTU1kQm1VOEVZRC9wUHJFR21teHBFTUt6cVRWOHU1RVA1Zllp?=
 =?utf-8?B?TTc5MnFsVFd1Mi8wazRHWHRteUMyTW9RazU1L1YwdzJka0hkVnI0ZzVQVFY3?=
 =?utf-8?B?NllxOHA4M3VZaThsM1Z3K2VraUpBdUROL1ZycU1HZ1Zna1oyUm5aK2x2dVBx?=
 =?utf-8?B?TDYwY1VMbHdLb2ZqeEZJR3ZxNG9kSWdOZFpVbklLWmdEV2VrUWRCNjl5TjV6?=
 =?utf-8?B?Ty9IUVNvWmU3bXhEQVV5SmRnZHpXeXo1TFZsUTlzT2xMR3ZSTXB5YzhrUVdu?=
 =?utf-8?B?WlhuR3VnN3pUd2Yzb2w4T25YYTg5S1BPZ29jQVpNYXo5M2pSTTBmMXErTkdz?=
 =?utf-8?B?QmczaG5XdGFLVXRtZ3JlMFdGSWlGb0F4QWZNbnZ4a2JKOTJoUTFPT0xwblVk?=
 =?utf-8?B?amo3dFNRMmR3Q0dTWHdEMkU2SSs3VXprSGFocXNxVE9qTWNTY21pbStoejhU?=
 =?utf-8?Q?DSXzTH5GHsA3WtrU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE53224581F15C4282EAB63AF0EB3435@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: Pchr5Wb3/r6XRa8I2QlaIGCjm3+FedvbVJULRA9+4mqd7Wny404MUAX0bgMhgOmNdcyuofv2bWbEIZnZ2yXqz8Z4bA+iNAxXeo0c+1qkZONI8ieRbBhbPYdJ7+9hSDSkesOpkiTr1nV1Hxm3uecJmH0Ql6JOVVHZumM/QhObm6MjJX3LJCf+A8yry+l+gDPoGuN8CejyR1NsG73O+JV+Pff4+lWP2BQ0XpCYwGhea2sxfmQw8hlnKApzkuqFvawiyhhL38sAZwSsR1ar1UN3EiZWWcmKwzXFXpRounMqSRROzqaGdm2p0E813JYQf+z6MKfTvvchcmNHmciW6prZIw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a2a82d-0e72-4f32-8d72-08df39177b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 19:28:32.4510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ya5rQzsBQgJ5yUpOiZMIGzZ8qtZUJPjhECSUv0DmdBurpXi3ftV6sZ9TM8dN3/J/JSxvZH6UeDdpJiBQS1D87i+z+N1xjt0AsF9yEGus3T4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTAyIGF0IDE1OjMyICswODAwLCBDaGFsbHZ5IFRlZSB3cm90ZToNCj4g
Q29tbWl0IDViMjVmMjQ5YmUzMiAoIng4Ni90ZHg6IERpc2FibGUgdGhlIFREWCBtb2R1bGUgZHVy
aW5nIGtleGVjIGFuZA0KPiBrZHVtcCIpIG1hZGUgbmF0aXZlX21hY2hpbmVfY3Jhc2hfc2h1dGRv
d24oKSBjYWxsIHRkeF9zeXNfZGlzYWJsZSgpLA0KPiB3aG9zZSBvbmx5IGdhdGUgaXMgY29tcGls
ZSB0aW1lIChDT05GSUdfSU5URUxfVERYX0hPU1QpLsKgIEEga2VybmVsIHRoYXQNCj4gbmV2ZXIg
aW5pdGlhbGl6ZWQgdGhlIFREWCBtb2R1bGUgdGhlcmVmb3JlIHN0aWxsIGlzc3Vlcw0KPiBUREgu
U1lTLkRJU0FCTEUuDQo+IA0KPiBJbiBWTVggbm9uLXJvb3Qgb3BlcmF0aW9uIG9uIGEgU0VBTS1j
YXBhYmxlIGhvc3QsIFNFQU1DQUxMIGNhdXNlcyBhIFZNDQo+IGV4aXQgaW5zdGVhZCBvZiBhIG5h
dGl2ZSAjVUQuwqAgS1ZNIGluamVjdHMgI1VEIG9ubHkgc2luY2UNCj4gY29tbWl0IDlkN2RmYjk1
ZGEyYyAoIktWTTogVk1YOiBJbmplY3QgI1VEIGlmIGd1ZXN0IHRyaWVzIHRvIGV4ZWN1dGUNCj4g
U0VBTUNBTEwgb3IgVERDQUxMIiksIGZpcnN0IHJlbGVhc2VkIGluIHY2LjE4LsKgIE9uIGFuIG9s
ZGVyIGhvc3QgdGhlDQo+IFZNTSBnZXRzIEtWTV9FWElUX0lOVEVSTkFMX0VSUk9SIGFuZCB0aGUg
dkNQVSBuZXZlciByZXN1bWVzLCBzbw0KPiBtYWNoaW5lX2tleGVjKCkgaXMgbmV2ZXIgcmVhY2hl
ZCBhbmQgbm8gdm1jb3JlIGlzIHdyaXR0ZW4uwqAgS2R1bXAgaXMNCj4gdGh1cyBicm9rZW4gb25s
eSBpbiBndWVzdHMgb24gU0VBTS1jYXBhYmxlIGhvc3RzIHdob3NlIGh5cGVydmlzb3IgZG9lcw0K
PiBub3QgaGFuZGxlIHRoZSBleGl0OyBwbGFpbiBrZXhlYyBpcyB1bmFmZmVjdGVkIGJlY2F1c2Ug
dGR4X3NodXRkb3duKCkNCj4gb25seSBydW5zIGFzIGEgc3lzY29yZSBvcCwgcmVnaXN0ZXJlZCBh
ZnRlciBpbml0X3RkeF9tb2R1bGUoKSBzdWNjZWVkcy4NCj4gDQo+IEdhdGUgdGhlIFNFQU1DQUxM
IG9uIFg4Nl9GRUFUVVJFX1REWF9IT1NUX1BMQVRGT1JNIGJlZm9yZSBpc3N1aW5nIGl0LA0KPiB0
aGUgd2F5IHBhZGRyX2lzX3RkeF9wcml2YXRlKCkgYWxyZWFkeSBndWFyZHMgaXRzIG93biBTRUFN
Q0FMTCBpbiB0aGlzDQo+IGZpbGUuwqAgV2l0aG91dCB0aGF0IGZlYXR1cmUgdGhlIG1vZHVsZSBp
cyBuZXZlciBpbml0aWFsaXplZCwgc28gdGhlcmUNCj4gaXMgbm90aGluZyB0byBkaXNhYmxlOyBv
biBhIFREWCBob3N0IHRoZSBnYXRlIGlzIGEgbm8tb3AuDQo+IA0KPiBJdCBhbHNvIGRlY291cGxl
cyBrZHVtcCBmcm9tIHRoZSBob3N0IEtWTSB2ZXJzaW9uIC0tIGEgZ3Vlc3QgY2Fubm90DQo+IHJl
cXVpcmUgaXRzIGhvc3QgdG8gaW5qZWN0IHRoZSAjVUQuDQo+IA0KPiBGaXhlczogNWIyNWYyNDli
ZTMyICgieDg2L3RkeDogRGlzYWJsZSB0aGUgVERYIG1vZHVsZSBkdXJpbmcga2V4ZWMgYW5kIGtk
dW1wIikNCj4gU3VnZ2VzdGVkLWJ5OiBLaXJ5bCBTaHV0c2VtYXUgPGthc0BrZXJuZWwub3JnPg0K
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFsbHZ5IFRl
ZSA8Y2hhbGx2eS50ZWVAZ21haWwuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRn
ZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
