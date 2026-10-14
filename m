Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C927E07E;
	Wed, 14 Oct 2026 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973198; cv=fail; b=ru+eRucbyVEpjP/NQN52wS5IpxcYOgEDxyt+GXfSjFDbdPERDTemIV8f5MUgnQEWex6QgkzmwlwxXclFFFSiVyodO1SOyf628FsZu61CNX5vIs6qGtNznBSt5hS6K50ABjehbgEOZNb7AOYg2Hp2j2WDI09rfuv+z0ft0OdOPHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973198; c=relaxed/simple;
	bh=QzJ3QDVsdmMcYzKefmRmCZtuSXsAENGI/jH2oISJHy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QFBv4Mq1osfqCEjEP6fMpYzc5Q2RsJsjDtswucxYnRozWz1mSqIGWcVixAR32zBGUqtgcKvygoMSoq/1Qyv87Bcc9SIpbbOp+79UPwzR9cHPKvl8GGTrQXTqYe4DbdRDEsaOw8N/C9aOav6koR9dnfSM3Ia6WCDUd7ezm/6qOts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DItyBBlQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DItyBBlQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791973189; x=1823509189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QzJ3QDVsdmMcYzKefmRmCZtuSXsAENGI/jH2oISJHy8=;
  b=DItyBBlQR0mM5CJlIPutX1NsO80C1DWqG/x9Zcx0TnauYZoLOSbVNk4d
   ONC9yNeVKSzvyL3PsYVemrleFZnoEyMZZ+oXGMjoeJx5qM6a5PYcadnsR
   miJsMpz0yxVjpy+lIxkgRWWvW9M+rICqCK2kAJJzLRzEA/MvhJkBAFfHv
   9I3NtOWLskPS5D0mUXRQIO36hO9sbd41FEj2Kkk9w35KRnoTX63yXyyZP
   S7M27dUNKXJj5h3YPHnyhfgMmEq59MAjZRc9T4ZBbXdRBpuIr65kxhF0N
   3/kpmewvG46Mv7G4ypb/zqdcqciSYa8DunYZnCJWIBPwJQPzcwj2+Adsp
   g==;
X-CSE-ConnectionGUID: j7tYH63sTCGS6oxYq9sm4w==
X-CSE-MsgGUID: nUU+3lU8SeG8BYKEheKxGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="617111"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="617111"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:19:48 -0700
X-CSE-ConnectionGUID: YtKNrTglT4m1L6LB4GlUUw==
X-CSE-MsgGUID: MkZPF2bWQ06dPi+DbfufTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="3154739"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:19:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:19:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:19:33 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7181H73uMmhhz1CYQUytzaJ3Zzbj42A0oKbAI32T2amtI1vA5gM7illcWmF0ay6RauKbG/x1Mxzh4ZOuddIyUBWDYxFyP+FM8SAJBY3LadmESaSxUMhlJYdLPQnbWib9q30/cWXPaut9c9CXxoYMwO2Q+0AMaDC1gdX7vIRvvBs3KaLqNCF3rPKbR/vmXojLlTNvDb9FUW/DXODgXKk5iPacZ/JjSbeNpyCNw12JWLkmNUbeYnzdiSGzQdg1LiHTLkbG09xQAbAL+f2CFr4l7rMaQkFTsAK5FKCBJARQoU29wajdzwGtc2q9jmNEXsejgrTYc4JD5dRwODNvZZm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzJ3QDVsdmMcYzKefmRmCZtuSXsAENGI/jH2oISJHy8=;
 b=II6mPPQdf+zjNgVxOr+nLdBbxDX8abAKt2JTYsa7CWHfp+sxx/u9upjTvChWmn01vLPHW71CWgRT7ags3mfREBFymNBNXEjjQ9D01+zxrByXQwvaSo4K+qjC6cjLVP8WsvpCzAiktvIbgKN0RqTQocK3a27QczljzEncMxAzewQVBhIMgILKoZh6X8Qt4vMX2v9S2UNJSGwaPJl0cHOK2cPP++0cltcZB9/k91FE6KESdtorzdz8fSWi+c1W/E3GsO0Pti4ufZgz+rAUL2kjEaI9x3WsstlfXEs7v0xC0pT9daG9Z6PkOhm63h/IvUt/QBAMeSYsu+tXM0qSqKRjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:19:30 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 10:19:29 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "hex@aleph0.ai"
	<hex@aleph0.ai>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/psr: Send a frame change notification for async
 flips
Thread-Topic: [PATCH] drm/i915/psr: Send a frame change notification for async
 flips
Thread-Index: AQHdWyXXPMjim1SDbkWjqRe5jYPFIrb81LEA
Date: Wed, 14 Oct 2026 10:19:29 +0000
Message-ID: <023984fe3325b7976897cfdb06061c379b6206f0.camel@intel.com>
References: <20261013-fix-psr-async-trans-push-v1-1-ee79bf31b66f@aleph0.ai>
In-Reply-To: <20261013-fix-psr-async-trans-push-v1-1-ee79bf31b66f@aleph0.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: 99e44bc7-cf5a-4050-5ef6-08df29dca20f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|38070700021|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: qUqbj5DaUgugQar6x60u2mMmPEvPklXIoSTbJ7H5R5z3u64sIbGym8ulXshjauQARGpDmNRWI5YZPS30ym/8ydnYa4wQmEIdbcSFQgzqxfdcbFs/7qPQmIeevfn6HqQL3J/YJrUA0622jZdGHT5RgT27jWNGAZ4fUHoRN+bbIrQTZ6bZm1UJl6PhMCkN6nhO7Z3YWc7WO2g2haO/w5XrctJKJdN0LB178KPzCLJQse68w0Vw5nAJRDIpyeRBXSTKusZ7EDYVP8dZXDUPfDwBdQ0wbGapM/swKgEduptKB7txAScPBRQwxP6jJYx7QvbCN4kJ2bJBfmkA9R8wzNygLQJjfkA5gcETm2FE8KjV/YjVMcpe5AmAUlLGHkMUPWvFBJlVwhHUE0wOTDQgFkXVWvKBCGPFaDKBEFpi5/9qmkdZNJFDMCOqqrDaWZC3RPdoiuNrjCczS60IgACCCwJIzuCnVvtndxr9jB121AqZxqzzoJYFJIVwfl03mTpDl52jQne27G89RwbjqYjUOc67UK5b6wx6MNu8/irHyrBdGap5E28DguiwQnvGLfAVpkAuRWLmbmQuKbKPQh9QsOoMZr0ZicHoq4IONGyeO+n3evrHU4VTBhdeZzwcK4GA9ZdxtRo6GPA2qSY9InZ+IwnXC4sxmkEZywIt6SqRKqsYAw0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjlnQjVwajc1UGxGaWF6THRRUXVCZVJES3BxcThFdEpOa0VjamdEYk5GbEdx?=
 =?utf-8?B?cjJxZk9SaGtHTHMya05MeTNSWTJuYlhxMERpQWpNZGRzSlhFZW9YaWdsYm13?=
 =?utf-8?B?YkhoUUdBM1B5NG5pUlFiQmZ0T3UxN1V4NUh0Y2llalg4RzhqUzB5emtXbzc2?=
 =?utf-8?B?WDZSMkV5cnZJdVZ0bTJicG5vZWhjeGtRQUdJcFIrOU8wVWFqeHRMUndpekR0?=
 =?utf-8?B?MnIxS2JteVkrUkVVUWRGMEVLSW04MkwwNG5qNW1hMkNyOFlld3EyY0I4dlNB?=
 =?utf-8?B?a3Q4T003MXpkMDl3dDdCRFdNdzFSbUNGVlFpTkZhVjYrejJuemlmTlp4d3Rk?=
 =?utf-8?B?b1AwcTlHZEdOcVI3Z3hIS2hEellxYXlGOHVjNmhzZ3VuQUpqOFdPMVZnN0xF?=
 =?utf-8?B?cUoxSGw1cWVidVlRQjFvZ1RHN29GbE5FSGI3dEZXbXZnSnJBbUovZDhOZXox?=
 =?utf-8?B?eFZIaXFNaXJpMzhQZjFQQ0pKbCtISFBnS2tCQzFmVDNHVHg4Z2g3Y2VXUmdi?=
 =?utf-8?B?R0Y0U2hVeGdPVTRIZTZHOUVoZ01TVVoweU92MytoVFF4UEpDL05Ga0RQbDFx?=
 =?utf-8?B?WnMwWTB0QWdja2M1K0dQbUVRZWxHamVUc1FNQUoxeUxaaGI3WTQxcm9KTXFh?=
 =?utf-8?B?b3AxYzFEZmp2UmF6UEhOYlJ3cm9yQWw4MjlJQjJSTnZaZU9ORWZTWWc4YUZW?=
 =?utf-8?B?bm14OTZJU1VRRUVHN2dIbjZzQ1VIdVMxUGJaanA0ZnFBWTV6amJSaWYvaERY?=
 =?utf-8?B?K3g2RDBNQmM5WjFJMlZDT2hiQUVWR3VRbWNIR3B5UHNkc3JueWlhK0c3R1dL?=
 =?utf-8?B?b1BSZWtCVVBUc3pIYkQyUzdCTmMwQWlIa0dQQWpPMnhZR2tEemlMRThhUkxk?=
 =?utf-8?B?RXNiMUxZd1Ezb2tjTEk1Qk80UFpKY21MVVRidmF0RTVRdEF2d2RZSHRIYU9O?=
 =?utf-8?B?RU5oTHlieUlqREZWZXo0SmE5Z1ZhRmhQeElsbkplSXdHQlZ6ekhiM0hTUW5K?=
 =?utf-8?B?UmUzTE5nQVFiblFnSDZGV00rZkQ3eUdLRXJjMGE3NVIwYWk2U0lHWHlTdElk?=
 =?utf-8?B?LzhOd1lMYU5UREdqZENRNlorR0Z0WEFOSGFESmtKSGJoYWhia1dQNVdYWm44?=
 =?utf-8?B?MGtONjlrcTZJYWQzeEpMM0NEdHV2Uk1iamFnREFiWVBlWlUxRUVTWUh2SG52?=
 =?utf-8?B?MmpwN3ZDbnZHekdKYXF6R0F5OWcvUFM4b2drelVMYjluRjY3cWlEWFRJV253?=
 =?utf-8?B?T2xUVWVIVGF3c1FKZmZYVFBNUkk4VWlNbGdLb0k5K01rT2szN1NQMHc1SUVS?=
 =?utf-8?B?U3ZkSkJlYlBFY0VkYTBrbTlsdWNhUUJsZkd2L2R1bTdzZ3hhZ3lycUJpbmVK?=
 =?utf-8?B?Vy9jOGN3VVpIcmlERlJmR3FzNjRJVkI4RklvNzRQQTh3R0dmWDAxdm12RHZV?=
 =?utf-8?B?RmhrVnJzcjE1NmNYTUdjRmxtQSt5V1R2R0RkdzlCVFQ4MXFTK2QwSG50aGFu?=
 =?utf-8?B?TEhGeENnRFFva3U4RzA2aXg0UGowOGZYNWpZU0Y1UHZKYkpiNVFhZ3JsNW9w?=
 =?utf-8?B?QVVzNloxZlJtTXVZV3pvYXJ1UlhtaHVrYlBiZ2JVV2E0MjQzdUlMMHluR0ls?=
 =?utf-8?B?dlVSR2w3UUhiYkJNRThmQ3NYckd5OWlTendTTWxnaE12enBsZ2ltdXdXV1oz?=
 =?utf-8?B?NVRwZzZWcEJlR1BuRm0xdTJ2RmY2VVYxQmpYSHpyYVJvWHg1czhzcE8zakQw?=
 =?utf-8?B?aGMvbHhoa2Jxd1YxYWtCMGtDQm5VeXR5TnEyZDVoclZiUndKTGZoL2YzMGJr?=
 =?utf-8?B?K1NCazJaWDlKMGUrZHUyc0FCdkRtSkZsdm5IL1ROd2xLRlFSS0dLRSt6bkpy?=
 =?utf-8?B?aHh3RE0vNFBoRFN6T0ZTV01JNkE5b3J4NXpkSFZrdGhoTk5tcHcxVTQ4ZEVU?=
 =?utf-8?B?MDFFMkF0YmhXVERwK1JlaXJscks0d0lqdStraVNPWWJjK1VvUG5PSFFoSnFM?=
 =?utf-8?B?c0tXU3YxVUhORXJhc2dXb0xvNW9ZMWhkNXJITkJaajJDQm5nVDlOWHNyTG9B?=
 =?utf-8?B?Q2ZkT1FqNUhPcUU3SmRvWTZuSXR0YWRMMTBVT25ReTBJVHRFYjh4ZThJZzla?=
 =?utf-8?B?Zm1WMmdKb016TEg2NjZlaHQ0RzVHUVRhNjF4UFU3LzRBMGR4NkVBYkxRQ0tV?=
 =?utf-8?B?bmdyTm1zMm45MUJVdWwzeStta1VmNmVPMFoySFNNcG5wUm1ITDFWM000YVdK?=
 =?utf-8?B?RDZpNUQwSS9INlNEblFKSU50RFNTM016Z0hxOUh1R2RFTmVrRkVIdldqSG9n?=
 =?utf-8?B?bFVEZGczZGtnUm5JdkJuRmRlRGJmVWVuWTNsbFRRMzJJK0tONm9EM2x2cnRl?=
 =?utf-8?Q?fbTCxpx42pPA0lRc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35675E432E003446A1F20D368DFC0AE0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nYTWuGHGNV+Prfx1MssGuSx5HLY+hNwtSwtNiw7YiaGERHiNcQ2E2pAvb2bvAdGboSp+VuS3R3meo0fbCpheqT+BkIDN062AlZENxkWoU8Woe5Ci2H+fHZcWcR7sa0l8sGNMZ6KfSbpHFtnQKAyFMU8qiFGSE+A3Ksji5HI58ua98bnWfgJlfKfRzIW/4VqWN/iZmNqUYuNW0YjfoF1EnoPMwpgaAyj0yLmNV3oVuR3lCZVL/YH87+c0d9cVIv6dacdnhtfe309fEQoE8R6noS4cIOApf7xPxnbyZwJqoMX2yToZcnHbY8SqKZwIPTSRG6ArasiOBrJt+nBg1MAhfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e44bc7-cf5a-4050-5ef6-08df29dca20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:19:29.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbTCpD+S0YsU/GVNFgg/iOd9KxyKarP9BbjdvkwMe3oUc2w39GpEhNlTrmbujIzsOgVlyMbZdt3PltiIEdYbLscRhq68SZBULMw1DMzZo4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTEzIGF0IDE3OjE2ICswMjAwLCBWbGFkeXNsYXYgWWFta292eWkgdmlh
IEI0IFJlbGF5DQp3cm90ZToNCj4gRnJvbTogVmxhZHlzbGF2IFlhbWtvdnlpIDxoZXhAYWxlcGgw
LmFpPg0KPiANCj4gT24gcGxhdGZvcm1zIHVzaW5nIFRSQU5TX1BVU0ggZm9yIFBTUiBmcmFtZS1j
aGFuZ2Ugbm90aWZpY2F0aW9ucywNCj4gaW50ZWxfcGlwZV91cGRhdGVfZW5kKCkgZXhpdHMgZWFy
bHkgZm9yIGFzeW5jaHJvbm91cyBmbGlwcywgYmVmb3JlDQo+IHNlbmRpbmcNCj4gdGhlIHB1c2gu
IFRoZSByZWdpc3Rlci1iYXNlZCBub3RpZmljYXRpb24gaXMgZGlzYWJsZWQgb24gdGhlc2UNCj4g
cGxhdGZvcm1zLA0KPiBhbmQgYW4gT1JJR0lOX0ZMSVAgZnJvbnRidWZmZXIgZmx1c2ggZG9lcyBu
b3QgZm9yY2UgUFNSIHRvIGV4aXQuDQo+IA0KPiBUaGlzIGNhbiBsZWF2ZSBhbiBhY2NlcHRlZCBh
c3luYyBmbGlwIHdpdGhvdXQgYSBjb21wbGV0aW9uIGV2ZW50DQo+IGFmdGVyDQo+IFBTUjIgZW50
ZXJzIERFRVBfU0xFRVAuIE9uIFBhbnRoZXIgTGFrZSwgc2Nhbm91dCBmcmVlemVzIGFuZCB0aGUN
Cj4ga2VybmVsDQo+IHJlcG9ydHMgIltDUlRDOjE1MjpwaXBlIEFdIGZsaXBfZG9uZSB0aW1lZCBv
dXQiLiBJbnRlbCBJR1QNCj4ga21zX2FzeW5jX2ZsaXBzDQo+IHJlcHJvZHVjZXMgdGhlIGZhaWx1
cmUgd2l0aCB0aGUgY29tcG9zaXRvciBpbmFjdGl2ZSB3aGVuIGEgMjAwIG1zDQo+IGlkbGUNCj4g
aW50ZXJ2YWwgaXMgaW5zZXJ0ZWQgYmVmb3JlIGFuIGFzeW5jaHJvbm91cyBhdG9taWMgZmxpcC4N
Cj4gDQo+IFNlbmQgdGhlIFBTUiBmcmFtZS1jaGFuZ2Ugbm90aWZpY2F0aW9uIGFmdGVyIHBsYW5l
IHByb2dyYW1taW5nIGFuZA0KPiBiZWZvcmUNCj4gcmVsZWFzaW5nIHRoZSBleGlzdGluZyBQU1Ig
bG9jay4gUmVzdHJpY3QgdGhlIHB1c2ggdG8gQ1JUQyBzdGF0ZXMNCj4gdGhhdCB1c2UNCj4gVFJB
TlNfUFVTSCBmb3IgUFNSLCBsZWF2aW5nIG90aGVyIGFzeW5jIGZsaXBzIGFuZCB0aGUgc3luY2hy
b25vdXMgYW5kDQo+IERTQg0KPiBwYXRocyB1bmNoYW5nZWQuDQoNCllvdSB3ZXJlbid0IHNlZWlu
ZyAiVlJSIHB1c2ggc2VuZCBzdGlsbCBwZW5kaW5nIiBlcnJvciBtZXNzYWdlcyBhZnRlcg0KeW91
ciBjaGFuZ2U/DQoNCkFueXdheXMgSSB0aGluayB5b3Ugc2hvdWxkIGRpc2FibGUgdGhhdCBjaGVj
ayBmb3IgYXN5bmMgZmxpcCBjYXNlIGluDQp5b3VyIHBhdGNoLiBTZWUgaW50ZWxfdnJyX2NoZWNr
X3B1c2hfc2VudCBpbg0KaW50ZWxfZGlzcGxheS5jOmludGVsX2F0b21pY19jb21taXRfdGFpbC4N
Cg0KQlIsDQpKb3VuaSBIw7ZnYW5kZXINCj4gDQo+IENsb3NlczoNCj4gaHR0cHM6Ly9naXRsYWIu
ZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS93b3JrX2l0ZW1zLzk1ODINCj4gRml4ZXM6
IDEyOWE0ZGExMTcwNyAoImRybS9pOTE1L3BzcjogVXNlIFRSQU5TX1BVU0ggdG8gdHJpZ2dlciBm
cmFtZQ0KPiBjaGFuZ2UgZXZlbnQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBB
c3Npc3RlZC1ieTogTExNIHNwYXJzZSBzbWF0Y2gNCj4gU2lnbmVkLW9mZi1ieTogVmxhZHlzbGF2
IFlhbWtvdnlpIDxoZXhAYWxlcGgwLmFpPg0KPiAtLS0NCj4gQmFzZWQgb24gZHJtLXRpcCAoMjAy
Ni0xMC0xMyk7IGFsc28gYXBwbGllcyB0byB2Ny4zLXJjNy4NCj4gDQo+IFJ1bnRpbWUtdGVzdGVk
IG9uIFBhbnRoZXIgTGFrZSAoeGUsIGVEUC0xLCAyODgweDE4MDApIHdpdGggVWJ1bnR1LQ0KPiBi
YXNlZA0KPiA3LjMuMC1yYzYga2VybmVscywgYmVmb3JlIGFuZCBhZnRlciB0aGlzIGZpeC4gSUdU
IGttc19hc3luY19mbGlwcywNCj4gYXN5bmMtZmxpcC13aXRoLXBhZ2UtZmxpcC1ldmVudHMtdGls
ZWQtYXRvbWljLCBkeW5hbWljIHN1YnRlc3QNCj4gcGlwZS1BLWVEUC0xLTQtcmMtY2NzLCBmYWls
cyB3aXRoIEZsaXAgVGltZW91dCBiZWZvcmUgdGhlIGZpeCBhbmQNCj4gcGFzc2VzDQo+IGFmdGVy
d2FyZHMuIEFuIExEX1BSRUxPQUQgaW50ZXJwb3NlciBpbnNlcnRzIG9uZSAyMDAgbXMgaWRsZSBp
bnRlcnZhbA0KPiBiZWZvcmUgdGhlIGVpZ2h0aCBhc3luYyBhdG9taWMgY29tbWl0IHdpdGhvdXQg
Y2hhbmdpbmcgaXRzIHJlcXVlc3Qgb3INCj4gZmxhZ3MuIEJvdGggcnVucyBlbnRlciBQU1IyIEVh
cmx5IFRyYW5zcG9ydCBERUVQX1NMRUVQIHdpdGggc2VsZWN0aXZlDQo+IGZldGNoIGVuYWJsZWQg
YmVmb3JlIHRoYXQgY29tbWl0Lg0KPiANCj4gQ2xhbmcgMjMuMS4yLCBXPTEgYnVpbGRzIGFuZCBT
cGFyc2UvU21hdGNoIGNoZWNrcyBvZiB0aGUgQ1JUQywgUFNSDQo+IGFuZCBWUlINCj4gdHJhbnNs
YXRpb24gdW5pdHMgZm9yIGk5MTUgYW5kIFhlIHByb2R1Y2VkIG5vIG5ldyBkaWFnbm9zdGljcy4N
Cj4gDQo+IE9wZW5BSSBDb2RleCAoR1BULTYtQXN0cmEpIGFzc2lzdGVkIGRpYWdub3NpcywgcmVw
cm9kdWNlciBhbmQgZml4DQo+IGRldmVsb3BtZW50LCB2YWxpZGF0aW9uIGFuZCBwYXRjaCBwcmVw
YXJhdGlvbiwgZm9sbG93aW5nIHJlcXVlc3RzIHRvDQo+IHJlcHJvZHVjZSB0aGUgZnJlZXplIGlu
ZGVwZW5kZW50bHksIHRyYWNlIGl0cyBkcml2ZXIgY2F1c2UgYW5kDQo+IHByZXBhcmUgYQ0KPiB0
ZXN0ZWQgdXBzdHJlYW0gZml4LiBJIHRha2UgZGlyZWN0IHJlc3BvbnNpYmlsaXR5IGZvciB0aGlz
DQo+IGNvbnRyaWJ1dGlvbiwNCj4gaGF2ZSBjYXJlZnVsbHkgcmV2aWV3ZWQgdGhlIGNoYW5nZSBh
bmQgZW5zdXJlZCByaWdvcm91cyBsb2NhbA0KPiB0ZXN0aW5nLg0KPiAtLS0NCj4gwqBkcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2NydGMuYyB8IDEwICsrKysrKysrKy0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jcnRjLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2NydGMuYw0KPiBpbmRleCAxMGVkOWJk
ZmVlNzYuLjhlZjI0Y2RkYmFhNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9jcnRjLmMNCj4gQEAgLTczNiw4ICs3MzYsMTYgQEAgdm9pZCBpbnRlbF9waXBlX3Vw
ZGF0ZV9lbmQoc3RydWN0DQo+IGludGVsX2F0b21pY19zdGF0ZSAqc3RhdGUsDQo+IMKgDQo+IMKg
CWRybV9XQVJOX09OKGRpc3BsYXktPmRybSwgbmV3X2NydGNfc3RhdGUtPnVzZV9kc2IpOw0KPiDC
oA0KPiAtCWlmIChuZXdfY3J0Y19zdGF0ZS0+ZG9fYXN5bmNfZmxpcCkNCj4gKwlpZiAobmV3X2Ny
dGNfc3RhdGUtPmRvX2FzeW5jX2ZsaXApIHsNCj4gKwkJLyoNCj4gKwkJICogTE5MKyB1c2VzIFRS
QU5TX1BVU0ggZm9yIFBTUiBmcmFtZS1jaGFuZ2UNCj4gbm90aWZpY2F0aW9ucy4NCj4gKwkJICog
QXN5bmMgZmxpcHMgc2tpcCB0aGUgdmJsYW5rIHBhdGggYmVsb3csIGJ1dCBzdGlsbA0KPiBuZWVk
IHRvDQo+ICsJCSAqIG5vdGlmeSBQU1IgYWZ0ZXIgcHJvZ3JhbW1pbmcgdGhlIG5ldyBzdXJmYWNl
DQo+IGFkZHJlc3MuDQo+ICsJCSAqLw0KPiArCQlpZiAoaW50ZWxfcHNyX3VzZV90cmFuc19wdXNo
KG5ld19jcnRjX3N0YXRlKSkNCj4gKwkJCWludGVsX3Zycl9zZW5kX3B1c2goTlVMTCwgbmV3X2Ny
dGNfc3RhdGUpOw0KPiDCoAkJZ290byBvdXQ7DQo+ICsJfQ0KPiDCoA0KPiDCoAl0cmFjZV9pbnRl
bF9waXBlX3VwZGF0ZV9lbmQoY3J0YywgZW5kX3ZibF9jb3VudCwNCj4gc2NhbmxpbmVfZW5kKTsN
Cj4gwqANCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZWIxYmY0NzAwZDNiMjVhMWExZTY3MGVm
MzFjYzA2OTY5ZmEwODAxOQ0KPiBjaGFuZ2UtaWQ6IDIwMjYxMDEzLWZpeC1wc3ItYXN5bmMtdHJh
bnMtcHVzaC1iZmE2NTUwMjcwYzcNCj4gDQo+IA0KDQo=
