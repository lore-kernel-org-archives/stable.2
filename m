Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793272996;
	b=p34qRQhJm4I54GKLuH/07DMuYxzhqhVPK8Kqkfyemvvh3OQNXjyW1zjUJY9Ep6lKVeh0
	 89dWVD+DQ869X8jr6GuEslnSkirZfqTtPVFB70lDaS8hvjGB6Jb5srnV40wBAa8XWee/m
	 Le/qF2dIy1sS4gLcqvPTIwdeCEgPNJitBykQ0ZGiMXUpORAW8Xfwl0PU6Mf+BAVtpCMYU
	 SsC1piTJfAW+lWKBfKEJWnNVs4HFVpBIwyyybFKTJsn4hVRBLJ56GTQgqY+84EayP9SS5
	 hlx8b6PKTodJdcjJHZovVLgyBSrStWl3OocEn5llSGogT3bNQqQRVgQNeimbNTepx6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272996;
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
	bh=HdkVOEEou1eL2CE1Ec0gMSmyFECXLIDid31sr2Ahi1A=;
	b=0nvfRaxeSEqk09NOjoZA1n3DT0MmiDCSHXigYMUy34BvaUS/6318L3AG8TvQdx7s0GSW
	 4CUb8he8T5sZkCY/8bdkpJOpYpGwDW6OHEVK0n2jxlVppG2HWm8CHv1Kg+xEuFeb02DPy
	 bURbmxKZ9zAsHujzdr+u7cjDiSuvBANcPAF9asxrOBHRxWgL4GIlGq+pJ4rafFc/0/RKu
	 cJcXVPeGNrkYkHZNVRTXVFGZkgNqWLTw7o8BwXm88182QE6wHFDIbgYonXvvcSbW7SJ+U
	 2lNCARhKj+JLQVGqPFaeeEPHMbIVJigYLgjWiD7PnFL4n8N6jj+TvepBrovP5vPsy9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nin054pm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E4606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nin054pm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793272994; x=1824808994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OZCP4glXe1Y9ZFVb1H9DQel4e68SaGslytDRttoynbA=;
  b=nin054pmzQw0V1bEH2onU1J8xWTpdMh9za6GZaeFybFL6wjIpFwbLhV4
   uL2GD1Zv3TeKoIEag7lFiMU72YnyeDVlwTQwwgfXc5u+Ybk5oxfNFYNH6
   SivSY3yRczzvg7YPgD9jWCKuVL2lz0EEafIov95o++4lF7o32gunb0Myj
   l1314XZMnHY9gPBsee4qHNV1EQObaSDaE2EkN9tdxLK0R7D3/53AIKYGW
   65P+A0q+Dv4VuPjdSear6opCSvXYioxZZoorqDIHCJZuIAmZocSvcWLb6
   nRKOP5bz3x4bK8fcPOPybK/TESNXKUjCon0DLQZlxzFmZhlEJevhfP9cW
   A==;
X-CSE-ConnectionGUID: sbw02YSsSEOJxS4T8T0dVg==
X-CSE-MsgGUID: YwMXk2F4QsijcVdZtMoe8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2017280"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2017280"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:23:13 -0700
X-CSE-ConnectionGUID: upMMPT0HRC2wb8gK56Ueag==
X-CSE-MsgGUID: j2wD/iMCQZq6Zol7JhN5Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5128376"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:23:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:23:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:23:13 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UclUEhmJtgAUqKh50y38nD1Bn5u4zz4VBB6i/9gQSH1yhPCRmGZ9MipbDNMZrr7EKrqUk+eqYL6EQzGmUO9jCAozTV0hWPwVALTXENA77gUowK6pSmoM6ya4F+0xS4a2Scl0BAy9UEuo0+TmpVVmfUD2qrtwk87y/tOHlPZF0ltNb/+nRm47VDjAL7v+YDV7heY88VTEC+IS3HamwECtqwff1HAVeRYYIO4ZDK2v8XiLljWSyqReV0wBB3D32F/xW9PJO0rh5VbCNeQBUmHkO90j5CU+DWuh5gzp5tRzzMJ9KcDhsdafPDIitIlLFpf5jHDo/wcmHypmofW4foNswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdkVOEEou1eL2CE1Ec0gMSmyFECXLIDid31sr2Ahi1A=;
 b=lA/ZxtGVAwSG5No14dXBH+bTK7b/lTmEM87N4tiJiXwKDITqMumQXGR7zC3DWGXJcgEITMGnA3c+D6o6Fc4qwlEtIjEgXM19YlGTWT1JnnYTAhsncLSZXGSwZQQ5xMm/jGzK9/z/sADtkp2Ws/O83jo5f0JTaL3BN08Rs9jQOBZstQ+Qs1E7exi0l9uKDYZ5ulJ+SUF6f6zZTT+rkfVASR8EDU9cB2o7DiD5yMa822ts/y81TD3aElarfMJE4tI5nM72lN9k5TzxkoYrepK8pnZXoQrlpWsmh0f6QQVJwDbcCPiPof4KANYtWwQP16DqGmDtbZTsS8fbNn+wc6zw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13)
 by LV4PPFDC496280F.namprd11.prod.outlook.com (2603:10b6:40f:fc02::22e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Thu, 29 Oct
 2026 11:23:10 +0000
Received: from SJ2PR11MB8346.namprd11.prod.outlook.com
 ([fe80::6f5:b048:e73d:d6bc]) by SJ2PR11MB8346.namprd11.prod.outlook.com
 ([fe80::6f5:b048:e73d:d6bc%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:23:10 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Srinivas, Vidya" <vidya.srinivas@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
Subject: RE: [PATCH v4 0/2] drm/i915/display: Limit scaler count and disable
 pipe joiner on WCL
Thread-Topic: [PATCH v4 0/2] drm/i915/display: Limit scaler count and disable
 pipe joiner on WCL
Thread-Index: AQHdZqvxDYiaqLLKeUWDcmAHWSEtuLcUYfUg
Date: Thu, 29 Oct 2026 11:23:10 +0000
Message-ID: <SJ2PR11MB8346E58752F73C9F86DE6576F46E2@SJ2PR11MB8346.namprd11.prod.outlook.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
In-Reply-To: <20261028070404.1913843-1-vidya.srinivas@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8346:EE_|LV4PPFDC496280F:EE_
x-ms-office365-filtering-correlation-id: c60fdc64-41ff-425b-75a6-08df35af035a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|4143699003|11063799006|56012099006|261009223027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: h2nsvWkBPp50b5JbBOXkav/dvbWRDjKdyE8uI06gcAe70kgR03Ow3acSLWh/H/P6DAfDqcLnqjPyR5/ukGFUcgLUpivkbxt8oM3ixlMJ7f5QKygKgekR6QMfdLxF2gqrepS1/LLDlVfpcUG39ouaTBWuHQy6ZKJ/NLZywPPJ1kV8kEpFTarNl0N5X5Lxa5NwHbOflA7ZrEdwvaaHySklqMKk8X2Dij0EtHz7V5V/aqSjUS72p9ZKHOFFD8YxKgPOFtKlZZWPFADx77cxkXNAzCOoq3/9U5kI62JaEGEnifbZlKiTFvabPPx2gzJ5Pqj6dnvvpoLQ8VQwQmgjp0jQhnbC+5fhtGoERgeKJ/FzOzrkg5seEgNzAdNjgfJKNQCWqyYDBUsNyoeeyqB23C2O4ZXBddaU1iBI68PdR653LbBNLOcdtVJLe9ZD3SzpnCEmqxTaB6ckDA+yGDj2QTnbdIrhgHCkqrJXiHfTLgKsBRzfhXVHkiop8UFTa8lP+Dy0q3+TCB6rd3AmuXnVOk7jIB/xOHZphVdvNp8WDZlNJ+0+HE8K8FbkkPfLMYxFg4NKs+DgMqbbocpTsd+MNzT9fDa9KHCWHMU+ZQL72KcGhl9v0r7/hNtgFayV0nos+7ncsE4/ijqj67GpGlroyFfDsKINgcctB+My53ZENGUY+Zez8kUEXpWkWiV+CFds3BAjP2Exas+nF+7EEl+p/tl2OMtKlsbDIl/BcjmR0KwGCBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8346.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R8/6aXq+qoOS8HTrOfaysMGKFH497Hl3qSOIN8bx6ogtQeFtYYQSUYFhCBEx?=
 =?us-ascii?Q?UZOVTS9zXLa4cPiZn1E0c3Y2qnRGRtQ41g05sZaLj5jeXxwfMA/P8Wa3F2Uv?=
 =?us-ascii?Q?iK9D3wPoprDFAgsB/t32SAhYiFwwdQdRdBNuppRRJXzo6ZYevHmd9LUj5DL8?=
 =?us-ascii?Q?vUe2aT0g4PcRJJy2GkXLUcEfLBtUukzrC8N8J3PA+TScADuyKCZOn2TJVm5t?=
 =?us-ascii?Q?N4v3AOP4oSKulo2SWSGSCqwsKPlcLlBXXWWdF6mDp1OCLetHthZ6eWnEaMHP?=
 =?us-ascii?Q?hYU9vh8e26D00PIZYowO12jmvFSO4Nj0MC8Py/B6Z3uxNPMt0OVqmiSpGZUI?=
 =?us-ascii?Q?lEwcCjM/zqi8HtINtKijtOt31RRRCTQ5LMNzF2MaIaV4qmEg1GDgl3ySthW8?=
 =?us-ascii?Q?WPHpnAxPqvoQHO+l8VsLGUPjPEKxeslJu5RlgeGMxu+o7qDBAReCOya1RbXi?=
 =?us-ascii?Q?Nu/v/38xy+UO33qmWWqWlwELpLvJx02pDOmViSD3H35qm9EH+yiMYA9Wcn9N?=
 =?us-ascii?Q?CsC08P2gpCVGKJpJtGNyTboe/q36OLP0XDYYOEDnZ+PQmTm0jkT8LKW6HqKN?=
 =?us-ascii?Q?5WYWs1Aw5wyAwg2PIClJA5huO2OaeGR5DUDelWRC7f/pUAVY5shkg6hiy/xd?=
 =?us-ascii?Q?ibpUho6mIFMmz90BQTrM7s1ijdS44DSgA1Z85RJLOTkXc+wZIzCV4haDmdn2?=
 =?us-ascii?Q?0NXg9LPOZtN15Y/YGwmklNpUorujtQ0BK0o9bAxuAxzTlYZyNRlf5W+WdrUB?=
 =?us-ascii?Q?WAwyfQcAuVESOg3vYXmRDlnEHdebrSlyodKPppvui4Z4eFCu544zbDGTfVe3?=
 =?us-ascii?Q?adjZXGn4vNnVl8TRmKM1UhoOJ4HKLznO5OtVJgVBUzuy5bn2cpYVvuUjL0VN?=
 =?us-ascii?Q?Uh54nshhCvg/tWJa9ETUBqmd0fIPKeLdJMonwl1owjvkHHS4UI6VW2EC0DI/?=
 =?us-ascii?Q?IC6kWo2+uNCkAFAn8f1FaELmnI3C4eqYbeyEN6ZqDtLWpSGhid9TPnqNrdCz?=
 =?us-ascii?Q?JqMXoWFhOu/nueb0CdN9H+GEKdI88QCDEsT4BsJf2QDPmOv1IGIPHiGrf03h?=
 =?us-ascii?Q?021d4/Q+xJKE3l+noIvXLxQjUjtgQbUnKJPRTwpEKAaPWp67KkgSpMG9ppr0?=
 =?us-ascii?Q?lFj2Gg1VLEfOxCazxl3RuRmnaWw/MH7Z66SUKGd5HU0EKTSeK1W1pz9Gqzdy?=
 =?us-ascii?Q?Ke0m089SMW/zN3CvcuUD7F5YAuWdUudT1OqVOa364sIL5nd8ZfwUykfcFH7x?=
 =?us-ascii?Q?NKGGRacKrZ0k0cZ7cvS7OlCYGc5MsrYnH5W6B8PFIxHXjXFH+Eo4eiJcH0/l?=
 =?us-ascii?Q?sRWB3iD5wYOVqnuaiQPKfyFUSvyttUU0o64AW4cg3dTo7Qho24vdylc/9uxs?=
 =?us-ascii?Q?Ff0MsQWpl8Ouhy43KKqSM99uOpHSOvbru3Ye8C1mrIoO8j6Hd1vHt1z13W7F?=
 =?us-ascii?Q?V7/mrNzsdEsyzN0ssHgULAT5gnobsyeCjN+Dyx3o4EHFtzEbQyWsn2rCFBve?=
 =?us-ascii?Q?FubtWA4iWyIWEW/J2R2/m+7dLm1YLUowgeF+y40XJh/xQUrUBFqcWcvAjgAu?=
 =?us-ascii?Q?TfZRdif+67iwNRWQ9wA3zbdeeLP4+zx3oB9X3KJ8X2bYXVUxn+aEqPQBLCRt?=
 =?us-ascii?Q?5ud7lNjwkZZ/VAxUPFm6buHHJm+RWXvILRbN5cY3w94Hfip4ZcP68CAhurKC?=
 =?us-ascii?Q?gweo4+78N/d8fcErA7GFAOTFIwwzxiGGv0/mbMWbuv08vC2w?=
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
X-Exchange-RoutingPolicyChecked: 0MISauB2xDg4n60on/ByVp+hi4JsZExi4+KXYAWsKaEuWENQG08FJexQZSREqajB0CigPHBbSkLBO+wBbD2VBwaWnVtK1RUCVvWWHBTByiU3pOiwDhVvcXForE+Li1U52Ec/julmiZ2UtYFFKV38Nw2KtMTCvJpD2sFkaFb6BuhrFRYReLp4nhdj4M1oRA8nedk1aNKV8Lr3Go5MEhwF/ouLisWZszZkRxCPn5mGQ+fHfvxaSJEo0cz8PxOPPUl64ah7m9JbMuGSQWT4QBn0Iiu7CEIJeY7YN7cVm+cigMcRls7Dy31W3sdG43JOJqIy6c/PlKOAqPda5TfU+oJTjw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8346.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60fdc64-41ff-425b-75a6-08df35af035a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 11:23:10.0535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKnIycgyfzCCfFXwPepbQ1EAQTrKcc0GlfXZb6ZpJv6IOy2YcBcW7J7WklM5AeNtQBOLiTYBV96sMaPuBosd2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPFDC496280F
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Srinivas, Vidya <vidya.srinivas@intel.com>
> Sent: Wednesday, October 28, 2026 12:34 PM
> To: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Srinivas, Vidya
> <vidya.srinivas@intel.com>
> Subject: [PATCH v4 0/2] drm/i915/display: Limit scaler count and disable =
pipe
> joiner on WCL
>=20
> Pipe joining is not supported in the WCL display configuration.
> Modes that would require joining are rejected, matching the 4k 60Hz maxim=
um
> resolution documented for the platform.
>=20
> Also, WCL supports a single pipe scaler instead of two.

Pushed the changes to drm-intel-next. Thanks for the patches and reviews.
Have taken the correct Fixes: tag while merging, dropped others.

Regards,
Uma Shankar

> Vidya Srinivas (2):
>   drm/i915/display: Single scaler per pipe on WCL
>   drm/i915/display: Disable pipe joiner on WCL
>=20
>  drivers/gpu/drm/i915/display/intel_display_device.c | 5 ++++-
>  drivers/gpu/drm/i915/display/intel_dp.c             | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> --
> 2.45.2

