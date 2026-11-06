Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793971404;
	b=fEmKmZiSbnxj+Y0MlJzwBu2qOdl+jPGnG1/OPJqK9Clp0FiaTGU2PStAGwoXyBMB4xQ1
	 O5f6EtzC+xrTRGa3bhbnxI37Jau0KXUASccUl5V3eAW8FJCLEQUms/SqZsMEqRhG9iVjM
	 5cDHx+VkBEfWYQGp6w41yOzy1kojQ7xsfEwwxn6MIScscEG66mtjTCfd1c/kqx3pyq2BO
	 7ItqdPh73xl+ieiIjvx/SXQFi+E9x8VHauA5mUjgU+GkLd8bXknV20LsbUVb0YidhRxs+
	 HJZ3JP/EVFADfMHORoEzKB6GRdvASiSoHRuhFNOV5ez25MS2+hn+26s3m116QtaRhQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971404;
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
	bh=vq0BoH9sc7XFDAR0R2+5AjwdFilHWXeE8pCwK76WrBY=;
	b=rhxSK2mVBvvy555Ldy6lyOEGhrZuXDJ2o8u17eGJafw6DtqHxN8j8Xv3y8PzNJzeSTlQ
	 uk83p4/bEXgLG/kcAYmm6gYZnEcOzO/RtGAtymdqW/QnTwaVlg5bEhJN4qEA82ucVns1Z
	 FvTSickb2+3raLk5PBOo8pxx+pU3nuQc2lEVz47dZIZxk1bRVCadRBRi+T9FPnzBH2I5c
	 B4cMushg7XtuxwQfC0Hqi8Pfdt4p+pA6CRxAkUM7WqzCuJJ7QYcUc19Inma8czmpcrmxb
	 c++KRzS1Bgy9lmeP+DOhMpXnX3t19WCFW+wV5m1qIRI3QizfSZszwKJgglMvroO0csA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=COg7BF2Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC4606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27DC4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=COg7BF2Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793971403; x=1825507403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vq0BoH9sc7XFDAR0R2+5AjwdFilHWXeE8pCwK76WrBY=;
  b=COg7BF2QMrUHfopVDCJDMNKmXRJ6fZSdAnTsZDqGvqg972eaC8UbkCKb
   NEpKGMrD4VPa96QEXL40O6vvbgpzT/U1gobMiQb3PNR/DHqFLIBg5JYjr
   VG45bZzkOkzgpBVSZscPMDdoGFe36u3ItcCoznfa2z2cVTeVjvaB4U0jt
   7xcfKpOyztHDbvwOK/kK5fDXz2+uW8Z4Nqm8l+1X5bs6XlrsA60HJaQHe
   HEFrUaEsy3vGJIgc3jlC+kcQ7kbFs6Nn0IGCFXwu5/8l4yKj0Wyu2EDds
   CVlcLqh6GC8r/Vbh/olIBKmrryq67mwy/pn33wpjjHuw3CsuDYmW1PkMa
   w==;
X-CSE-ConnectionGUID: m3XLxAI7TbaGglYIVMaANQ==
X-CSE-MsgGUID: ZTRomROESX25y+w4bDMCBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2668856"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2668856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:23:23 -0800
X-CSE-ConnectionGUID: Ji8CZ412QUqMQRMCp71Cgw==
X-CSE-MsgGUID: GH/Es4UER1+Wq1f3JUqjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7149451"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:23:23 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:23:21 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 05:23:21 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:23:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJx+UlLwBi2KmBa8B+9V1H6k5vOduR2iHfFKlrjb73abclTDoMNYrwdUnNXerlYWNcNeWRlj6d0vr7R8c4LTvhps2i4t3s7cpwHNioj01q9yxtUAuh6KfdQFy3PH6XgHPau+KeRjkdVho5TNPyJgZW028DF53YCP8FW94IYPPN5h8zeVEYt9hmdBmPSEs5SMqixbeo11/5FYPc+H2J/zDqHq+9ovsGrObgPRkDOcZ3OBf9v7UsVHs5fZ1CXb7SO9AFOFnc31Ddw95beNJh0fdGnl8iwS2uMdfXBp5jT0I1sPNx5Sqs1VsU96wFO0KNZ1O2me1QGUW4QZAu12gJocTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq0BoH9sc7XFDAR0R2+5AjwdFilHWXeE8pCwK76WrBY=;
 b=fAcx2wvKk/02/R7qqir/74L/zAuM+utQjjKbeyCoHUa7k5NlfUteV1u0y+6j0+gv64VNE12sCVzg6+xpOCBeqHATruA0Xf5kp9XRAS6spCdnmAyu+cvJfUHO9Ndc6BC2DR0TCMm3/h7l8WSm8GnLlcatEGpGTiRA6e/pHXfB4Ip4I+BAkepGZx4vrO208sm6KRetVinN0MxhwXIjlEx1nNTt0M2RQ1AcO1Z3FUFHN92KFM3BrAsynfHmiBlb1B2phPZktVLoID5lYsoUkzYfBq09uUksONiyXc03G59FsuEPAi6yAKIwA7CHKSf69qsZkw/DkiHYoShquEydo7dgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by MW4PR11MB6837.namprd11.prod.outlook.com
 (2603:10b6:303:221::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 13:23:14 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 13:23:13 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] drm/i915/display: Flush the fbdev frontbuffer
Thread-Topic: [PATCH v2 4/4] drm/i915/display: Flush the fbdev frontbuffer
Thread-Index: AQHdarKaVfdrwvTSkUGcc7iRp0jLfLchDnlg
Date: Fri, 6 Nov 2026 13:23:13 +0000
Message-ID: <DS4PPF69154114FBE160E451745B6B32EEEEF762@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261102100051.272137-1-jouni.hogander@intel.com>
 <20261102100051.272137-5-jouni.hogander@intel.com>
In-Reply-To: <20261102100051.272137-5-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|MW4PR11MB6837:EE_
x-ms-office365-filtering-correlation-id: fb3e5e58-e083-47fb-8be0-08df3c091c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|10070799003|1800799024|22082099003|18002099003|10067099003|38070700021|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|56012099006|261009223027099003;
x-microsoft-antispam-message-info: YFOEhJjCEnJ25J+hisRYfLZFxQ7uceNn3J2WUOPy81xAggPaZD852b/Y2C7aT3nVMsnIbsI6J05uYQUdpeuoond1phP0Rc6tgYWBxxjkOGAolUeTEIaxXytqCfmoHs9dEZ0yx1hAtt+cn1JaMZ4DGip9m7wXu67MGsulIWHASqk4KSE1fd0ily/yC1BvViWiOECRaqN3ZnLdeRuAxsr1wgn6s9e7Mh7u00yvMEPW5BNaqFHHGds59iSoIAxPonZ8UTxOr8Je5geOR8Llx5CpXSoa+wGWPYdvnTVnIyle0rOtd8OSeoPcZ9JJRNa/rfPVb97cqv/GNhawJRAvEIlnVuhL9i1KDuFhu5DRiz0tGAEG6Gz467L+Yf7LWxI03kF1B8pOpoxLr+EWGQ3wtD/1+Xt5P/JRB+yjLbgVjDtbO3yTz/E6TTy3kgiX3DVObcrnnSUsCF2La2mAj+5NTb+WVUIpGrDBF5TQpRVgLLc2iuuq7wBO9nLnLpCQl05N3Z1nbtto87rhJrsbLjJz/eLnxoRgWSv6pf/0Nn7fONKo1yMKIUZT8Kei/X89LtvhVls4t8LMWgy6uL8q/Ty5RMiIIwAOol8aOgWGIZGVNk0A0gOfcdDAKjBqzv3lqULeMoRFo7+hDDrsRjv3pipBEWa+EGTOcCPi3qPeNNUsN70RjPF+6LdL/2BAnG1i2GhIZqYLwbg8ovzTda8yMDpF65alKJTP0tNBHhqJaHxD7zS7mAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1h0dkcvNDNvOEszaW55azZucmw1eXA5Y1Q1YnBNcEVyUW1OckhqSzRTYUtu?=
 =?utf-8?B?WmtaOXVtMGtQeFg5TzMrdXJ3bkVzUFp2L1R3NXZENFZ6NWVXdkswbGFGWUdQ?=
 =?utf-8?B?ODhzNGZya2RvZEtMWnM4L1IyT3Y4ZHFBMnZ4M1gyczRwd0w5bHNDTVByR2F0?=
 =?utf-8?B?TkpMOTc2ZENhaFlZOWhkT1BUanBwQStnWVFiNFJLK0tvNnhxTWN6Mjl1SWxz?=
 =?utf-8?B?US9RSFJmWllmemNmV1Z4RjA2SENINDYzLzJaN253aHFUNFlnUG1UTFFMb0dT?=
 =?utf-8?B?QXJBZU45ZVR5R0g3blV5T29KcE5UcTlsVy9GZXJhbmwveXI3RTZIaUxpTDdJ?=
 =?utf-8?B?WHl0UXkzaTNVbTB5UHRGNE9oM2oxQm4vZmh3MUs5bk1wb0FQZm04K3MvNTdH?=
 =?utf-8?B?NUxzb0Vra2hjUXhndzBRaVJMWGVrQnFjR2JabERSZHhQOFQzU3FKdXgwL0xF?=
 =?utf-8?B?SmIxNkoxM1l6TjVWei8wTlNtSHQzRVFDblhvb2xMVVZBaUxwb3pTOCtZM3ky?=
 =?utf-8?B?WXZYekpTMXhuaWQvUjlJTFRLcXNDRHJuSllwYTNxK1U5YzJYTDFyVnNISFU0?=
 =?utf-8?B?TEpEREpHaXZKaGpuODhocEVNM1RQb0xhZjJvd2owcVo1dTBjOVQwbDNzZXBY?=
 =?utf-8?B?NjR6TktkS0t0aEgrWDdNSmJPUHJLN0prU1ExenpESlRlMm1OMU1ISjlQQkpU?=
 =?utf-8?B?aWFkTHp6UU9rOWhCdGZ5ZGwyYTN1Wm1kUFhqK3dBeTFLRDJLSEdZQWJhWHVY?=
 =?utf-8?B?cW5pa05ISWI2OTNLNExYS3cxdGVNR251V1B2SnBMbU5keEZFWnZTR2luc0ht?=
 =?utf-8?B?S0lvdXZwUERZem5OSmYwVWlxaFNTSjFYSXdtK3BMd2hab2hGOSt6SU4yb1VY?=
 =?utf-8?B?eFMzYkNCUVBBR2VmcXQ2ZmxHaGlrb2o2WGE2cHJ0aXFOLzRXSCtYQ1pzSjBE?=
 =?utf-8?B?U00zcEdHU3pMRDZCQURueHdLeGk2ZTN6YkM4UENqWFNySlgwY3pSS0hPSmto?=
 =?utf-8?B?MnZhd0ZZb3VCOUtoK3RpUmxqZkZaOTRtKzFLVGl2citNekhham5Zc0wycVZI?=
 =?utf-8?B?RnZBbWJrTVR0V2t0N3ZoZjBjR3ppNnVVSE5GV1YrVUdvdUhzSjJGZnRtbS9l?=
 =?utf-8?B?T3JJdGRLK2tpYVZUUFNTL0ZhQmpWbTlVYm80SUNlcnhRVyt6akVpcDIxV0Fw?=
 =?utf-8?B?blZlVEMyMGFBMXJZdWRNaEZ4WExXbDhvQUNRbTMxQlFCelYwV3ZCL3ZXUTU3?=
 =?utf-8?B?VC8vQ1J6WnljUXFqcWkvc2UyQml4MG51OWpJenU3RmZseDBqMW5JUmZmYisy?=
 =?utf-8?B?Z1hzekVXc09zWXR1SmJFNTJSQzlrZ01JREhPVDU0eVErOS9UbTBxL0J1QUlj?=
 =?utf-8?B?Rll1UnorYWgrTkNUM3Q3ejJSK3ByY3ZaOHJNVDFLK3V1YnYrUmRFMTRWV2lR?=
 =?utf-8?B?NGdkTGtTTUM4M2dvRElnK3lPUE9mOWpkQjJuZW5ETG81NGJjRE8veUpPUWMw?=
 =?utf-8?B?TlJIdkNYaXFaWk90dDZXZmRqa05rZHYzNjVWYkdSUXlGeW9pY24rVmlWS25S?=
 =?utf-8?B?bzk0aFNmNXh1WGdpRldHTjRRSGxuUDZRdzZDUExDMFR4Vzh2OENEMHZlQWc2?=
 =?utf-8?B?YTVmWjZhYVhuQjN0R3dKWS9Xc0hVWVA5YlhDOFBscnlwUEkwdGZQbWNON3lk?=
 =?utf-8?B?Rkp2Y3E2ZVI5bDhtaExmR2lHL1VmUzRITllSMXBMVUEzbHAwUFoyOHBZS2li?=
 =?utf-8?B?N0NweXdWdTVsMzBYeGtMUG1nSzJWYXVCZjN4cDd4TkxDWThEek1QTDBMZTZQ?=
 =?utf-8?B?eWN5RjE4YWZUbnBtWHE5V2lzeVk3YlgrOFRzaGx3eHZhU3NUbmNUcTg0YnFk?=
 =?utf-8?B?ZmF5WkVEZXkrR0x0SC9NUVdTSzd4N2paRXNiTE1Oays2N3dBbGl3TGZMVE5k?=
 =?utf-8?B?RVE0ZVVYdWZ5dmNNbTZMWlp3TFBRallTZWxkNER4b0lDUUtKNmdUaW1xZzM4?=
 =?utf-8?B?ZFlTMnBCUFIwanhjREhCZjVycnZZQ0RPMENiOTFWaTVHZGRjRkI3V0RhSkZy?=
 =?utf-8?B?dVYrVzdMZFFmM3JhQnBtWWpTNk41RlFVTWFTVUo0TEx1MTg1WmpXMEtQaUVF?=
 =?utf-8?B?SDhIdHRNenhFQUcyUDVsYTl5Q2p5Y2haNUJVSGNPcERvZFB2WFZsTzY1amFF?=
 =?utf-8?B?UU9ETmxoY296MlJZc3NGbkhSU3FWWWNwWllRUEU0NFBNVVNsTnpvanFZQU5k?=
 =?utf-8?B?UnYzd1h5OVRmSzhyS0I5bEMrNWtVVW4wdmE1L0xCZkg3UjFhdC8zRDkybmd3?=
 =?utf-8?B?aUlOQUhyQUlLdTk4c2pLbHhDQkFGZlZJZjJtUy8raDVVUVVjN0xuMkhCYUhj?=
 =?utf-8?Q?/KzeJCIuyXHiY1sOZXH9snA5aGe2XpDA4ppLm?=
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
X-Exchange-RoutingPolicyChecked: 1m42E4A7IqyqMTlJ5xIBcq+BtHrm1eNUn0mUOJDFxvH+89P0T+1fn1/RyXXiDBxo1h27ozSdwZTo/jj+Eg1bBCBT10rEOA8MsraauIzrWaBZr7XmPFojLZpTA44dfUKHLoOEleR95GCpmJHdKkLbYXogjbNCZmC8lwAy/qxfHxm8bmvt+0JRLBxYmBjXNWxwX4bFDNl722zXeVRfOHQy826qd+IdXXdNHQ2lu5+te4xKzoE8RVWbSXEPuXp3mCuRimHcX33TvuSXJRZSXyYZNTG03c+sPsw44uQ2sJsyMEeM7BT42KsWWt2Sy0n0m3zZ5RTMbhH31EvjwR7ylBF0cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3e5e58-e083-47fb-8be0-08df3c091c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 13:23:13.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egNMm7qxYrZn8Pft5ISlm9xXKgZNz+l0iC6JDF0k0VyoVHAqFiu3eyspzNsam8Sb623qo5xLxTC3Ilz4eQ/+Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC1nZnggPGludGVsLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEpvdW5pIEjDtmdh
bmRlcg0KPiBTZW50OiBNb25kYXksIDIgTm92ZW1iZXIgMjAyNiAxMi4wMQ0KPiBUbzogaW50ZWwt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBIb2dhbmRlciwgSm91bmkgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT47IE1hYXJ0
ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+OyBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiA0LzRdIGRybS9pOTE1L2Rpc3Bs
YXk6IEZsdXNoIHRoZSBmYmRldiBmcm9udGJ1ZmZlcg0KPiANCj4gZmJkZXYgaW52YWxpZGF0ZXMg
b24gc2V0X3BhciwgYmxhbmssIHBhbl9kaXNwbGF5IGFuZCByZXN0b3JlLCBidXQgbmV2ZXINCj4g
Zmx1c2hlcy4gT24gaTkxNSwgdW5yZWxhdGVkIHJlbmRlcmluZyBtYXkgY2xlYXIgdGhlIGJpdHM7
IFhlIGhhcyBubw0KPiBPUklHSU5fQ1MgaW52YWxpZGF0aW9uLCBzbyBQU1IgYW5kIEZCQyBjYW4g
cmVtYWluIGRpc2FibGVkIGluZGVmaW5pdGVseS4NCj4gDQo+IEZsdXNoIGFmdGVyIHRoZXNlIG9w
ZXJhdGlvbnM7IHRoZXkgYXJlIGFscmVhZHkgY29tcGxldGUuDQo+IA0KPiBGaXhlczogNDRlNjk0
OTU4Yjk1ICgiZHJtL3hlL2Rpc3BsYXk6IEltcGxlbWVudCBkaXNwbGF5IHN1cHBvcnQiKQ0KPiBD
YzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4N
Cj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjgrDQoNClJldmlld2VkLWJ5OiBN
aWthIEthaG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEpv
dW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZmJkZXYuYyB8IDEzICsrKysrKystLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9mYmRldi5j
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9mYmRldi5jDQo+IGluZGV4IDIx
OWVlMTdkZTNmNjguLmMwOTI0NmE5ODY1Y2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfZmJkZXYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX2ZiZGV2LmMNCj4gQEAgLTc1LDkgKzc1LDEwIEBAIHN0YXRpYyBzdHJ1
Y3QgaW50ZWxfZnJvbnRidWZmZXIgKnRvX2Zyb250YnVmZmVyKHN0cnVjdCBpbnRlbF9mYmRldiAq
aWZiZGV2KQ0KPiAgCXJldHVybiBpZmJkZXYtPmZiLT5mcm9udGJ1ZmZlcjsNCj4gIH0NCj4gDQo+
IC1zdGF0aWMgdm9pZCBpbnRlbF9mYmRldl9pbnZhbGlkYXRlKHN0cnVjdCBpbnRlbF9mYmRldiAq
aWZiZGV2KQ0KPiArLyogVGhlIGNvbnNvbGUgb3BlcmF0aW9uIGhhcyBhbHJlYWR5IGNvbXBsZXRl
ZCwgaGVuY2UgZmx1c2ggbm90IGludmFsaWRhdGUuICovDQo+ICtzdGF0aWMgdm9pZCBpbnRlbF9m
YmRldl9mbHVzaChzdHJ1Y3QgaW50ZWxfZmJkZXYgKmlmYmRldikNCj4gIHsNCj4gLQlpbnRlbF9m
cm9udGJ1ZmZlcl9pbnZhbGlkYXRlKHRvX2Zyb250YnVmZmVyKGlmYmRldiksIE9SSUdJTl9DUFUp
Ow0KPiArCWludGVsX2Zyb250YnVmZmVyX2ZsdXNoKHRvX2Zyb250YnVmZmVyKGlmYmRldiksIE9S
SUdJTl9DUFUpOw0KPiAgfQ0KPiANCj4gIEZCX0dFTl9ERUZBVUxUX0RFRkVSUkVEX0lPTUVNX09Q
UyhpbnRlbF9mYmRldiwNCj4gQEAgLTkxLDcgKzkyLDcgQEAgc3RhdGljIGludCBpbnRlbF9mYmRl
dl9zZXRfcGFyKHN0cnVjdCBmYl9pbmZvICppbmZvKQ0KPiANCj4gIAlyZXQgPSBkcm1fZmJfaGVs
cGVyX3NldF9wYXIoaW5mbyk7DQo+ICAJaWYgKHJldCA9PSAwKQ0KPiAtCQlpbnRlbF9mYmRldl9p
bnZhbGlkYXRlKGlmYmRldik7DQo+ICsJCWludGVsX2ZiZGV2X2ZsdXNoKGlmYmRldik7DQo+IA0K
PiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IEBAIC0xMDMsNyArMTA0LDcgQEAgc3RhdGljIGludCBp
bnRlbF9mYmRldl9ibGFuayhpbnQgYmxhbmssIHN0cnVjdCBmYl9pbmZvICppbmZvKQ0KPiANCj4g
IAlyZXQgPSBkcm1fZmJfaGVscGVyX2JsYW5rKGJsYW5rLCBpbmZvKTsNCj4gIAlpZiAocmV0ID09
IDApDQo+IC0JCWludGVsX2ZiZGV2X2ludmFsaWRhdGUoaWZiZGV2KTsNCj4gKwkJaW50ZWxfZmJk
ZXZfZmx1c2goaWZiZGV2KTsNCj4gDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gQEAgLTExNiw3
ICsxMTcsNyBAQCBzdGF0aWMgaW50IGludGVsX2ZiZGV2X3Bhbl9kaXNwbGF5KHN0cnVjdCBmYl92
YXJfc2NyZWVuaW5mbyAqdmFyLA0KPiANCj4gIAlyZXQgPSBkcm1fZmJfaGVscGVyX3Bhbl9kaXNw
bGF5KHZhciwgaW5mbyk7DQo+ICAJaWYgKHJldCA9PSAwKQ0KPiAtCQlpbnRlbF9mYmRldl9pbnZh
bGlkYXRlKGlmYmRldik7DQo+ICsJCWludGVsX2ZiZGV2X2ZsdXNoKGlmYmRldik7DQo+IA0KPiAg
CXJldHVybiByZXQ7DQo+ICB9DQo+IEBAIC0xODAsNyArMTgxLDcgQEAgc3RhdGljIHZvaWQgaW50
ZWxmYl9yZXN0b3JlKHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9oZWxwZXIpDQo+ICB7DQo+ICAJ
c3RydWN0IGludGVsX2ZiZGV2ICppZmJkZXYgPSB0b19pbnRlbF9mYmRldihmYl9oZWxwZXIpOw0K
PiANCj4gLQlpbnRlbF9mYmRldl9pbnZhbGlkYXRlKGlmYmRldik7DQo+ICsJaW50ZWxfZmJkZXZf
Zmx1c2goaWZiZGV2KTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBpbnRlbGZiX3NldF9zdXNw
ZW5kKHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9oZWxwZXIsIGJvb2wgc3VzcGVuZCkNCj4gLS0N
Cj4gMi41My4wDQoNCg==
