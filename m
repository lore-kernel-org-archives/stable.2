Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793726426;
	b=IyLpQU4iBcNmXJenHMkaapg7BN8KzIPbsaJ5oJOllhv43voTZpnHlBCiQAmJjtKyHIwK
	 AV+bpVdDCV2lL5yrrjEDfwPmQvhIuLQnBGaTK1UPXyAxfMdgIfRiQii8dbZP5JqTh//qc
	 vO769f8+XeTRmHgezL8XF3bDvvjT43esEJ7+aL7ofluVg/YugjA+KMn/69ROc9Fm/+tZ7
	 JASgF/8SSZbon7W63/NKNfeFjBeCwAzOQkOhFSjZuLUoSnhpD9jr7JDXed0fIBVLg3Qpg
	 R9+qekf++f9+oeOi7x2n93h5KKI7buPHyCvvS2Ynx3SodfSiGYf8gzdpcA1WeWFuGsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726426;
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
	bh=b8b2HrFzfwRz3iO1O/6TeP9psjG5ZordsHXuusgZ3fA=;
	b=GMsxnEEjdzU5Mes9zPGtitUQ+Pf9mytY+r19F4EqYUfI74cLdV/GAa/hUs7rfqB34i7O
	 nmBdEY+augR2VkrjGUUj5mBwiU80ECuedHa2rHOFMYPQX6waoyX7D9DjM5NwGLiBcdF2W
	 S7oq7C2Rk11uCFcPpYyxvRq14EIe1a1OBePBAej3LM9tZ5anaMdPwgzJm/VtV7VCc2itw
	 x91umRNLLvqzvOeIZnhRL0tkCnY8F8sbPrpnVwaGNhSqXWn+wr9EKqiW7lUjXQG2o8HHU
	 FcqzVzGOTUg4RoJKbFB9Qmydy6bQ3g93IG7x/ptGYZ+WNCf7lJIiiPVTyy27OFs2Q9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gP0outDl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74629606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74629606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gP0outDl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793726425; x=1825262425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b8b2HrFzfwRz3iO1O/6TeP9psjG5ZordsHXuusgZ3fA=;
  b=gP0outDl7twBjOOinbCEyxKiQ6USmmH8w7dcE5Tfzg20Yj6M8M9KCQSY
   7mtTwKWbEEfJP1qccHVIj8ua4bAWkC+FRcGQ6yET4VREAEmuB/MWnlgVm
   zUT5SuFWwo8mvOOc84Qprc3d3qglu11OC2I9Nsl5thh41gzCSDP00vYVG
   TxqhEDixdR7L0ar03oEd8RIoy+W1dL6qH/zpWMvc79j37Vk1kAwILYFUU
   dIizIY7mU7wtVv9DmPFnw72CmKKFHBtwJSUoZdIIYixWjYS/PO2Pj9UfA
   woU5V3njomyzU+FvQ1ch0GC5eNxjCJ/H0/SmMVdZceXGrZc9aYCrWLNfp
   Q==;
X-CSE-ConnectionGUID: jJF/gkhGTsm/m8v1Rx+PzA==
X-CSE-MsgGUID: yp1J8n7jRQWUYPizXEkZmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2490091"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2490091"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:20:24 -0800
X-CSE-ConnectionGUID: UEhxkNsBS5SMLY1LmhsLug==
X-CSE-MsgGUID: zMa1ytCfRlmsht2tt3d0ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6844379"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:20:23 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:20:23 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 09:20:23 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:20:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4GXtYfkd0ea5A2PUmdPCOFEf3Rtmlh49a3/DRWfr+L1hn8L9ec6gtcXMdOvOERlM7QlQjlDJr4FPWYp0fOchWv9pKnezopI4/He+JR+0DtpbGwCJ8uPivkeIQo7xHtgJnYJQtm5pHdJx5YGdtUWvhNZ4GJkoj894HzfHC2Gyl0+eLKpzie4LP7myDvji5MlOucJ0kgBw6bTjqOF19nCOdfh1kMIH0HSs73MLD21Wx1FjgpfDkQiUpHHzEAcldrgurJHTuJ4s4qlcb189QvV01/ofNcPGpr9IoOGZiI1MN7LMh05jtcuq5IJvBMZVwdbOSr74ugW4b1aurH0kuBhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8b2HrFzfwRz3iO1O/6TeP9psjG5ZordsHXuusgZ3fA=;
 b=AF5KX3eqdSS7mRCywli5CAtYWuyjI4C/Tsi36IClHbzcnnFCkj387XLm6UaFJNNPqqqwkaDZwQ+9W8IdzfFrroCfCGvv9tgk8dyFm07zA4SEambFhSnRIvEQgFvnkj2mKnCxZVdLl3/K/6kR7zpgRtb64n9K9CIDiar++bOS9lVu92dAy7MYWzpAcNrn51O/wSqF8qSDAq3YEqDzlgvMkNAtUMhVOs01isRmlrilY+A6CQVEWMYIOnrEazXGFC7iYOtPBMGnybhdoammimbTb6Vj/vY47CuCbmZVbRUAiCSCpNIWH1MazqpSbKDu13N1CwRkDZaCNyx0eXtqTOBHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH9PR11MB9904.namprd11.prod.outlook.com (2603:10b6:610:343::13)
 by SACPR11MB967231.namprd11.prod.outlook.com (2603:10b6:806:548::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 17:20:20 +0000
Received: from CH9PR11MB9904.namprd11.prod.outlook.com
 ([fe80::44cb:c9de:97ec:baec]) by CH9PR11MB9904.namprd11.prod.outlook.com
 ([fe80::44cb:c9de:97ec:baec%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 17:20:19 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] drm/i915: Fix OOB access of reset_engine_count for
 compute class
Thread-Topic: [PATCH 1/1] drm/i915: Fix OOB access of reset_engine_count for
 compute class
Thread-Index: AQHdZyCCqLR3j+/uLkK2slo4kNhMi7cTiKQAgAkYTAA=
Date: Tue, 3 Nov 2026 17:20:19 +0000
Message-ID: <3c6666dfae434a70ef05a6b83a6a59e668622b91.camel@intel.com>
References: <20261028210828.433225-2-alan.previn.teres.alexis@intel.com>
	 <9ac015b1-703c-4e35-9520-82a81d02f433@intel.com>
In-Reply-To: <9ac015b1-703c-4e35-9520-82a81d02f433@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH9PR11MB9904:EE_|SACPR11MB967231:EE_
x-ms-office365-filtering-correlation-id: aad99ad3-4d39-4600-213b-08df39cebc90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: bgls2bqH3IbJi/DW/EHDNMvinB8F+xkH/SGZ5VOrYUGXrPtFRRzaDpzOd6xGwvJNRWDubGls/66W7Br+bBb9u+616WPL4+tSeg45hITc5eCCg76LJsRzbX57C7xCFNcI3QG4rCJDjAywOOdPDSN3RFgJfs3etggIQ4JLNrVbr3juMLkxpsos6ReO6LAcZJNTKU8BwnLYutE3LESb6/Gze4ZGoJXm/M6z6S2y+ig784vM68DmO784VdH8yRWufEhzEcNPC4QAjx2KraXomT3RonMTT78+sC+VE2E3SX4VANRov9Y8GFYwFzAH13JwnJucI229acO0zDOjE/RwqyFf2ExP0aghTN6AI5JdyB/0fv3IMPxafr+Ihy98tGxnq9Ha5gpKXaaHAzrqdYicd7x/ATfpHKFJI7KYF4cMKzyvkv6xK6CAQQi6//347RvZGJto8+df4A5V65SpUIBMUB1kD+jqJdGV0n04b8ff5FJyZBl4VGtx81rmz5AnPjw9Ud3itg3cDHzQL9cJZ619KBGgwLMJRjiw6eCUW9N7MiddUN1+kJFxMdf0x+6eRxoZDFEFg/6EblkjNlI+aMBsZNJLLv97nkhpIFCPPYVVU29j+xfiatIJh2FoD6NuswME66i5qFdI678BhpMewpI4rcoG9btyDEX+0l2bjc0qfE5FtSyXKM9VM5g5ji81/WM7J2pRZloNxbHzXBwsqN4De/+v/dTfopP67FwnpGn6wnpGef4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH9PR11MB9904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTVUa2RRM3lTRDE4aUxPbllTUlM4L2hIVEJjSHpFUGtrK2JWaldUbW1uUmFa?=
 =?utf-8?B?cTgvaUJpTXdOU1dZZXBWTlk1dWpRdC9tNyswekU0UWU3UnlmQmsxWkFIWm5k?=
 =?utf-8?B?RGwzcTFpQXhzbDg2eHN5emR5Mk9MemoxdUV0ZUlSMm5PamYyTHV0bmlpcXUw?=
 =?utf-8?B?Vm5GNk1nS0lOTTBJTUcyTk1QeW1PK0h0SGpoSHRNWEtYb1V5dld4OUZTUy9z?=
 =?utf-8?B?aGtOWEt2WWZUY3djWGFsRFM5QkVDUVo0dHhISForTEV5Vk15eThuZy9YZEdx?=
 =?utf-8?B?OUJEeWd0TjNWM3dtTDJBVFdBQ2M2RmxPOW1GQzZML2pYZmJJc29GTzBOTm91?=
 =?utf-8?B?MWZsSjJIYUNiNWFWRTdlU1QyWUFxY1hEZytVOWFEb3Y3RnRYM2VjdFY3MzJI?=
 =?utf-8?B?ekFPVy83elJuYzlZcGt4bG1pLzBwN0NzQnlDYUpNclR3ZHI1eHVNQVpmaEE2?=
 =?utf-8?B?eGIzK0t6UU5Qa2RuTmZsWm1vZERSSWU1UXJKTUxRWGk5WXMvQ2RPTGxYKysz?=
 =?utf-8?B?RnJic0QzeXY4WWUvOWt0VVlHK3BsVXlpVVl4a2l3OWU5dW9yTUxFaU1qWDBE?=
 =?utf-8?B?Z055RGFSdFRtcGZ2UXZqUFVMOTdtMzlLUUN3d056SDlhODAzc3ZIVmhJd1o2?=
 =?utf-8?B?MnAxQmJUWmRNNkk4NDJaZEVhV1YrOVlUaE9QZmVkTzhyYnMwc21qZHJYQmV4?=
 =?utf-8?B?bmVkSE1SV0cvWmoxVDFnODhHL0dUeS9Ed2JuWC9UTVE5NWFQdnZPd0NTaTEy?=
 =?utf-8?B?SWx2RHdiczd4UDhIU1RMa01IK2N5N0FDekFvVkZpTWVkdys3YW1VZkRlY3pv?=
 =?utf-8?B?YWJocVZGWlU1OUpDcFdoUGp3OFdaWUg2aU5ERWNqTFkvRGVmSWg0cmtGU3Ax?=
 =?utf-8?B?NXNYOHVDUUcwNUJUckU1VXpPaVl4elhTajBrZVpSTWNyRDE4Q3ArTjVoTmZT?=
 =?utf-8?B?VzVxMXMzd1pPdUVXRVNwYS9CMVNXSzNjVm5GTitsVmxwMm1PbjFPNlRRaURx?=
 =?utf-8?B?eTI2NHRyTi9xV0FobDJUcnpENzFEdlFIcEwrcUVDOGJsY2NrekNmSjk5MnN4?=
 =?utf-8?B?Y24wQ0RQSXZvVjh2Mng5c1VGc1FqUXR6dnFqMVV3WGkvTWxpNnRvQ0ZnU0k1?=
 =?utf-8?B?S2VUV3JZRXRQMVZvQ0FNSnk1Y0JRWGFNaElqMGtxRGZwOFB3V3ZpKzJzdVFq?=
 =?utf-8?B?b3dKRzR2c2FHSTlQYXJhNi9MYWlVc3Q1OEZKVGxzcStQdlV2bGd2NGR1d3l0?=
 =?utf-8?B?Q2wzeWZDbHhBb3dWYkw0d2F2aktKZzV5TE91QUtHeGZjc2RPbUl4NGlDTXdD?=
 =?utf-8?B?ZlFzQmlDbGM5MUZoaFN6NkdubVJ5dTVhMFZvaVRUMzdid0pLditZVWxSMW16?=
 =?utf-8?B?Um9VMUluUE9Vb3Vzemc1NDNNUUlYK05lWkgxZEc3eTRUR2N2Vm1UUldPVGk0?=
 =?utf-8?B?Mzd1ajlSaTNpNjE0bURSZW5WeWhjMHRCWlFuNjJFb2MxZHN4TnA0WFNXTFJW?=
 =?utf-8?B?blAycVBxaDJZeWYwQmhnWUxCeTJleUh3OVoxMlFxUFY3QXMyaUwyc3oxZnBm?=
 =?utf-8?B?SmxBOVlxYktPMXRGbTAvS3l5NTk0SCsybitDSFNDNlB5eUcwNE5ZUndpWWlP?=
 =?utf-8?B?ZnVGVUFqL29JbFU1MHplVU1kaVhzdUl4OTJMNW51eitNV3A1bmZlYnRjdzFo?=
 =?utf-8?B?SUxCSWtwMUNHSXZJbnloZThHaVJ0U3ZpdkJsNHorRVppOHJtU1F4ckkyQk5v?=
 =?utf-8?B?eWR1OHBlZFVTL0VyUzhFK3lrdGhEeTNsSlZGbFd2OXR4dU1WQVV5b2lGSEJF?=
 =?utf-8?B?SzY5dzNtV253TTEzMEVDV3VzZzd1WGpZejByMktXclNmSkFVNTFvZ294R1M5?=
 =?utf-8?B?R01YWjA2SktXMmFMKzNrUEhHZFk4MWhyb2JQbmlsZnJGSlFINU16TWQvNEkz?=
 =?utf-8?B?QUprVVNRUWQ1ZDZKcUdCdjdWd3pWTndkNklOM21jem1Ld2RFZjd5eEN0VEJE?=
 =?utf-8?B?a29HelduTVI5Uy84aFpvUERmT04vVkU5czdORnFPNXltMXdCUmRsOEZSNTgx?=
 =?utf-8?B?dFNVUGpiSEQ5bjhPWGFRMTJOQXpWNTVGZnZHc1ZwVDlEem5SYmJxRkFOZHBx?=
 =?utf-8?B?RFppaVFLY0E4Q0NIM0pBNHJlZUpBRkl2M3lHMFRnZVk5c1JsMVlGZSs3N2U3?=
 =?utf-8?B?K2NnL1JYS2paZTg3Yy9oT1BhQlRPNGJYVVZYSTMreTVDSzhicWZJNHJ6SldH?=
 =?utf-8?B?VjdmcmJyM1J3UldIZGJFYzhnK05DM2kvVkJBZ3YvOFFHaTg2aGM3Vkx2S05M?=
 =?utf-8?B?SDBSR3czOFZwK3d2Q2lrR1AxR2ZyYWdJZVZ4ZjZlUU1HekJwRDV2eDMwN1lk?=
 =?utf-8?Q?897yDFAS59J6+VGn5orMNLUckTumFV9o/snKs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8E90AB44B7015429F9CD0293531F987@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: v+2MqJKMLcsnuJgS+Acg3YM/e3twmoFEW3XhnQ8VUKIPA9sd4bFMHQPK+WJeFNwQrGSN3Ol1NJ75FGn1uVU7pj07VAschS7mXZeVRsn9YBF2FKP6ufoMUP805TZ3c2YFj0KhfGGHrAZuwKVoEfui6Q1YQ0PVf/jgtObzPjwjSDERabmjvhsDb6Ob0tme1hSUdQyj2Amo5Yh709kH3Xt1AhxvfHH69770e5NM8qhQGte7IqaIFvq4lRi1Ut4zbPbYux5HGZuUGFY6VwJdUd+Pd2jdpvysLjBifAQAO3G0SGmhe4LUXvZkzQ9jUPDGJ2/VCbpwKCZH8eId1ZQ+uTrB6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH9PR11MB9904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad99ad3-4d39-4600-213b-08df39cebc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 17:20:19.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gG0VFJaGZKtgDB4wLmsEf9ko0J/RXydrz7iYHL2cxborHxMKSVdcaxaE9a6GZcSLNcHmhAweaMrGjKNmaaOjzaCg9eO7yHEX7o4vSJaxTeTQZnEzUZhqag+G/yDR3KE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR11MB967231
X-OriginatorOrg: intel.com

VGhhbmtzIERhbmllbGUuDQpVbmZvcnRudWF0ZWx5IHdlIGNhbid0IG1lcmdlIHRoaXMgb25lIGp1
c3QgeWV0IC0gaGFkIHRvIHJlcnVuIENJIGFmdGVyIHJlYWxpemluZw0KdGhlIGZpcnN0IHJ1biB3
YXMgYWxsIHBhc3NpbmcgYnV0IGluIGFjdHVhbCBmYWN0IHdhcyBhbGwgc2tpcHBpbmcgYnV0IGxh
YmVsbGVkIGFzDQprbm93bi1pc3N1ZXMuDQoNCi4uLmFsYW4NCg==
