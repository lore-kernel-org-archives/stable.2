Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3A49CF3F;
	Wed,  2 Sep 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355318; cv=fail; b=IOB95SS0/SFFpzRcnX0WUTvVRFY2Y5wQ9GSQxQxE0vwPWpVopzr8GxQu66J4pQVUPfVvMrrRFPFHdxIgOdLvKjSKqDF9aiAlaf92pAP9nlgHgyEmZN3fVYnkKRvwE1JS8Bs50ImJGZAnkM6dkONOmSZCFq+dokY6gvgkJDmAwmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355318; c=relaxed/simple;
	bh=hOFnDE7w1+JoIOT5F9QGZ+FVJHqSLb3xBfThFomEuJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=StzvJHJxAGKXXllT8T2tTAIvwDNLchv8VDz0eVUe1OuLGbA1VGJAH4RoDwOk907aBwWt96PC7UNK3ptP0PDh2DI0i38mBQ843zc/CRzvmk4WMPiY0CuGLqVgNm7Eg3iMkD+Csm5ghgY+UK0YJ68i1SyzLNApZRG4GNK14t77HsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=danurHx3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="danurHx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788355316; x=1819891316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hOFnDE7w1+JoIOT5F9QGZ+FVJHqSLb3xBfThFomEuJI=;
  b=danurHx311b+zLxGbdT21MDLCfgTOVPvepjh8tBTalcFS4+syVgU0hSD
   ysJaCmfWvVXXRUaWYrw0MfOvfjmhwSoCWx+bREg+wjt/ozOlRprl72l9l
   3upBMeo3DVC1LGpl+wh0Um4z6ul18ho3HOQI8UuLpKOakJ2KLJARku+Ml
   5G4+GKmMl6oPAVwXw1hkA2dEcslhOhsOtPlryzD/v4pQwRgrpSxrW5agj
   jcmcW6GPJST4k7bTPUzR2xPNMl7q/kI+tg3T615kRDbkmDL+Nopuacg2e
   ywN9hefe/4oODE+MM/ySEdh6ebXPOd7V9RAXDUozh2HNOQialBp+nMoAR
   A==;
X-CSE-ConnectionGUID: WzdWv/fUTAaKsGCITK1ZMw==
X-CSE-MsgGUID: 48G2bZk7RkuD8qRnO/pnmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88860387"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88860387"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:21:55 -0700
X-CSE-ConnectionGUID: 7RqOtmblRnuL6/61h1yIGQ==
X-CSE-MsgGUID: cWML4olxS4as1kF2kwSBnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307620231"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:21:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:21:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 06:21:54 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glEUva5vIZLKQZZdjgJYwuRlGwFD3qQ+xDmLGl/QNIKPGMlpKZHH2U+orddsuwERqiVRdi7Jy+bs1VEqag+ZGr9Y+PLXWLGRfQCG7j6+HVty2DDCpFQq6iZjd0vaSiEFFugQxyF4cvzOmF/qjlH68OeH/fKKzBJ3FAbBo/dYLbyogkH0aIsUzCqsNDKjBE4kuFmXQJsgz7lZcmmuC2xqArbQYXZDnRkQbzB5ZPPRLXjxMUoJvgVz5gC2LC15hDULzWIyEMBGNr5j5OWTja6V3b9sN59MQmL+PNH1djyDRlu/eeFS2Cmyrvo/tF8yx9C5wKXA9YjgLf/W385GFIS8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOFnDE7w1+JoIOT5F9QGZ+FVJHqSLb3xBfThFomEuJI=;
 b=qaRPp39+gUSqIJrjNOfTq0qaMRZblFp8/MRVZ9fAF75ZsT3wAxaiSe+E1gEZdd7UuWVierwr2DgTelVrPIhHV4sQPqLwPhi+2lPCvU0TorXz0lOhpL8gQEuqD045tDzIfCN36iJSoWi4Mt5ZIq6IBvvRQFoePYPZHbTaLOvH+nc1/xRpiaf47S96/TH9ZrO1wvQWOMP0pPksR67f1p+K9mhn1xV6owAZrefKfLzV5Z1PX0zn3NYukSp1p2dTrolBKTosnyJRc7QcWouL8QjyJAXeyyB8LoTWchVjTAdUqWKEDwfsI/diBl9Dj1OMtu1TcS4d1LMzjAIfERuvenKx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8857.namprd11.prod.outlook.com (2603:10b6:806:46b::10)
 by CYXPR11MB8754.namprd11.prod.outlook.com (2603:10b6:930:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:21:51 +0000
Received: from SA1PR11MB8857.namprd11.prod.outlook.com
 ([fe80::e847:8fea:6b23:944b]) by SA1PR11MB8857.namprd11.prod.outlook.com
 ([fe80::e847:8fea:6b23:944b%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:21:47 +0000
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Bae, Chang Seok"
	<chang.seok.bae@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/8] x86/microcode/intel: Reject problematic loading on
 GNR systems
Thread-Topic: [PATCH 1/8] x86/microcode/intel: Reject problematic loading on
 GNR systems
Thread-Index: AQHdOmuvjwfCw8/NWkO2J7+MD4eUmLa7RF2AgAAAjqA=
Date: Wed, 2 Sep 2026 13:21:40 +0000
Deferred-Delivery: Wed, 2 Sep 2026 13:21:17 +0000
Message-ID: <SA1PR11MB8857ACC16B56D3138355506392B72@SA1PR11MB8857.namprd11.prod.outlook.com>
References: <20260901231634.714144-1-chang.seok.bae@intel.com>
 <20260901231634.714144-2-chang.seok.bae@intel.com>
 <d035139c-6b37-46f3-baff-a27d0f1a082e@intel.com>
In-Reply-To: <d035139c-6b37-46f3-baff-a27d0f1a082e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8857:EE_|CYXPR11MB8754:EE_
x-ms-office365-filtering-correlation-id: 94255f24-fe1b-44f4-23d9-08df08f523f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|38070700021|10067099003|11063799006|4143699003;
x-microsoft-antispam-message-info: tiCxnAboUfaxe0xo8/mJZPbxIxCUhnxkKv3mvBQO8EiaLkg8Vkds6OErWGahJGUELjRaXsVpdZQgWk9NhWc400hsUXImECi9S+E3MhGSdAZJqkGIjb/202OpgbZoy4hzP2srJvoHU+CuhfSzSFs7w6mLr4MCqoAt85cTYXmN8B/bWHueLyJDxE5OK8KHSbNuOf8bnqPx8y3BAt47zFwY2fkQB9nfzhi8U8+40Lknyn++nW9m+aE/DBu0aVE5wKoEF9j/gOI5LfuAcb1IV53B2RO3Q3/9ZfFHEYDGJ/FTzFTLM/RnKE0sqn1zYTeSg8GloOzGFZFzXW8UqDUTSxvSMwWS2ABgCbP/KlMFe95DQVCLC9OryvWMvf9iZVCr33NJ32+fJAM8zj+MjNC+ayyxhXuV0AJzILE/fmR1xFDyntapGhIW6TcGi5IerFm1TMymYNvLT8PTziy7gj7Zo5t90UuegeuTKOQnSSn1a6MHfbN9TzcRkeRuQXGdLDF96xWx4tw5Tus0hrh+C7em1PxXq/8uybC0gA+gjDCqGum4zH/zLRi8XrPZG91HrbLOuoN0TrvlAFBtrcWNTuD+joCo5Tx9OYGipzp5M2Y0OwOy/s1iJfoN0RQ5RCK+yWIUJQ6UnLjLECbYt8+K6SnsCAk/juty+9vViXYjSZwd3kRRfQfI97d2T3TxdtcprodIOaNDo4X/Sev4l+5qsjK6uH0i7EfJh3W7MQAxJ/S8e6k7vXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Snh6WlVVM2VPVWZ3SDV4MVpUTndnUW5pTlgvOTdIZGk2RGRKbEhad2pXZ1JY?=
 =?utf-8?B?NWx4V3c1LzU4STZHOFdIbnI0WmlHbERYdHI4ZTdhSUtxaVN5VnozVVRKdUZv?=
 =?utf-8?B?Q0hMdXQ1eEFRQ1laWE11SC9weUVnVEJJL1JxNlNuTnlaQmFLdnpkeEx3anA0?=
 =?utf-8?B?eHFqNDFpd2J3RHU3YzdsSkVDQklmcVVOc25YdENLbWpXMVdPb2RwTERMQ0ds?=
 =?utf-8?B?cnBVb1VxenpXR2U5MjFFTHovdnUwSldjL3dXM3dkTlBOdThUMWI3ZW1TTitL?=
 =?utf-8?B?S3I1TjZ4UVpqR0o5K0FteUVjV0tMV21HUnZIR2tLMDBpZE42dUNEYkUxZ1NP?=
 =?utf-8?B?RDZXNUZXN0t6YUhUZnBHM2pLOXV3MGV6blBwZUxqRFpkNWgvNjF1YWZUalRO?=
 =?utf-8?B?T2RNaGVpZmRZTzdkVVIrSzhXV3NzUDBpNlk0Y0FsZSsvMHNPSnNiZEl4Q3p0?=
 =?utf-8?B?aHlPUmhIbkgybmtlbEcydkd4cGJxOVR6Y24vckRsQ1o4TWpCRzFPZ1FJYyt0?=
 =?utf-8?B?M1BxSGU2RjFEbnRLNTJEWHk3Z3krRnkxK2UzYlJhbWZmai9IOHRXbFlSSFRO?=
 =?utf-8?B?SEh4clZpZFVTQ0h6Y2JQYTVVT2htd3FjYmlUTnZ2NU9GcmZ5YTV2cUxDYUdL?=
 =?utf-8?B?ZHEwcUp1UHR4bnZBOEdwSElpdFpVN05ldUJsRnpDaUxaV3ZjTHZtVlBKOHpW?=
 =?utf-8?B?aHQ3MStkWEk4RkNDRDcrOENEbWhlTngycGJFVWtGcWd6aVVLSExqN0lOTnkx?=
 =?utf-8?B?aVFHT1B0Q3Bhd0FsM3Vyb08yMTVZZWxSenZTTnhXMWZlekVxeVMvbXBFZG9H?=
 =?utf-8?B?VThFK3FYenVEQU51ZUYxY2ducnZvdGlhc00rbU8yMHFJcmtKZ2VoSmVtVlJX?=
 =?utf-8?B?TWI3L0FNem8xTjZ3NmNYNDhqZ2V6R2tYcXJMd3p2VkMvdUpqeGhOTVJSNzEz?=
 =?utf-8?B?elBrTkFSNUpnUUx3YUZsRlRZNEdTRFVOV3R5eEx5bUVlbDFWTklNdGIwUCtv?=
 =?utf-8?B?NlNMZ084UGNkaDk2N1JhVE9XWFhCb0pHYTlCWXBTWUc1OXVYSGVHaHY5QnlV?=
 =?utf-8?B?NVdkZmFqbUN5NDNnV1hxNm1Yemh3TTkrRXYzYVkwbzY5M0V1UnlxOVRPb3ow?=
 =?utf-8?B?UzZMT0dCeHNNZFlBRVRISnlvMjF0RisrT2RqR25wVEUxMTFNQ2FEY1BOelFN?=
 =?utf-8?B?UFg1WkJwTUZhQy95R3pNTGVjNmloQllHa2dQRXVsWFpQazRJNmRvQURaU1RB?=
 =?utf-8?B?R0dsc2lmVHRNWWhZTCtyZ215Q0pLeUYvSVl4QTk4OUhlMWFvUGMrSjlhOTZI?=
 =?utf-8?B?cU9KMmwyUzZqdW1rbXNXYTB2c0tYaSt1TUc0Z2lkOUVhMDNrUStGaDNBbEx6?=
 =?utf-8?B?ZW1yRFA3cmplTWc4dXBmZ2N3SUtHVUdYclYvNENrSnJKcWZSdm15SnVPZTc3?=
 =?utf-8?B?QlFqMjlXVmRvVXpsY21QMFBvdUlLeG1jbXpaVi84TkdlNHIwTVhKRWdkTllS?=
 =?utf-8?B?bEQxdFJxU0tCNFVKZGMrR294dUFrM2tmclNTK1I2UGNJQVZLMVBzaHZZbkJI?=
 =?utf-8?B?aHMvMDY1YWNpT0tPR3FpRlJlYWRoeUgrVklOTkV5b09QeWtEWnR5ZFAxM1BP?=
 =?utf-8?B?eGhzOW83VFJLc0k0TGZyZW9UNE5OVkxzakxhd2FTYkx4dDZKS3B5OWFrOVdE?=
 =?utf-8?B?ZkJ4RWtMZ3F3SXE4THdHMFowclpjN0tPUThLVjY5dDFjUmJ2MnNnclEydWtU?=
 =?utf-8?B?TE50MGVDd2VWNXA5bllBSjhwK0ZoMmNOUy9zazVlV0VjK2FHZVdVNEhiZllV?=
 =?utf-8?B?RkVSKzljN2VuQWNyTkRTM0Z3R3RsMnQ1NWp5YTlhL1VNd2N5MzR5Z2RyQ2tH?=
 =?utf-8?B?bDZackZkSGNySXBHbG9PeGhOc2hLcjQ0cFRORW4rUXZHa3ljcys2SEZ6c2Fz?=
 =?utf-8?B?ZE9ISWhRNXpEZHlvUjBZUDZFMFZQUEdkRUdUL2hPYzZJMFd1V1hWZEZPMG1X?=
 =?utf-8?B?THA4QWFmTnM1UGwxMlRxMlFHZk1XeG1DeFFIL3Bad2Q2M2dld2hFUkFTVWFz?=
 =?utf-8?B?R055czc0RlA3a0t5QVBLSlM3bXlwMWtqSHFseWd6N0I4bjhnMG8xaXFyV3Rk?=
 =?utf-8?B?UEN4MU1qeTdUZmRIa2JiczNLRVhSeFpZd1NRb1JLcGd5cUdqdGpRWVp1VEht?=
 =?utf-8?B?c1lYS0J6ejhxUnNyVjROd29YcER6RVZMQ3MzTHlkOXAzYnhLdmlzelZXQWZ0?=
 =?utf-8?B?cHZzek9IcUhyZVhmaExCYU9jVDFqZTB3THJWbVlDSC9UdnNEOFlESUU3OTNz?=
 =?utf-8?B?c3UxemRXQzJzOTdOQktGbGIvYmpKaG9hR0tzdXZDa1Y2ZUNQaXJEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LIfvfW6gqcLidEWkyoOavur7spJKqHXBB8RPsmw53kE65cdnbacLWM6nOjaO7q88jaBodzWIBKJ7t6WMK7Ii+0cvU3VtNuu/BkY7YAT3gTJY98qt2WKAGJOsSaim3WJV8C/dcCIITmSvm09Ze6XheJFsPqXoWVwFQ5OfLvCW+vGuysq+QuKRqnXWBojL1Mt36A2oal57fbt9arEhVvhZCpBstGNISR4O/KOAc+pONkUG2mSorTN0DByKr9NI+xv7i8onhtfKGLJoLO06ZWwMRgDuvekiguzSsdrOYSJuhUgdHbVJ1s/6U9T5Ozpefuzgcp0LxbSB/UAPbhWjTNiEwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8857.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94255f24-fe1b-44f4-23d9-08df08f523f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 13:21:47.1762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1ePHP1vy1tZzUYceNQAGhl667ShlHojqUc7LaoV/4waj2yOZlqiOrGdJPlip10Fho1ZassUrddBAbB9rNO1geE4JwKAbYyz88pMh6vwyjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8754
X-OriginatorOrg: intel.com

PiBPbiA5LzEvMjAyNiA0OjE2IFBNLCBDaGFuZyBTLiBCYWUgd3JvdGU6DQo+ID4gUmV2aXNpb24g
MHgxMDAwNDA1IGNvbnRhaW5zIGludGVybmFsIG1pY3JvY29kZSBjaGFuZ2VzIHRoYXQgYXJlIHJl
cXVpcmVkDQo+ID4gYnkgc3Vic2VxdWVudCByZXZpc2lvbnMgdG8gYXZvaWQgI01DIGR1cmluZyBs
b2FkaW5nLg0KPiANCj4gQmVmb3JlIGdvaW5nIHRvIHRoZSBzb2x1dGlvbiBzcGFjZSwgY2FuIHdl
IGFkZCBzb21lIG1vcmUNCj4gY29udGV4dC9iYWNrZ3JvdW5kIGhlcmU/DQoNCkkgdGhpbmssIHRh
a2luZyBhcyBzdGVwIGJhY2ssIHRoZSB3b3JsZCBpcyBzb3J0IG9mIHNpbXBsZSBhbmQgbW9yZSBl
eGFtcGxlcyBtYXliZSBoZWxwaW5nIG9yIG1heWJlIG5vdC4NCg0KQXQgdGhlIHJlcXVlc3Qgb2Yg
ImxpbnV4IGZvbGtzIiAobWFueSBvbiB0aGUgQ0MpLCBJbnRlbCBhZGRlZCBhICJtaW5yZXYiIGZp
ZWxkIGZvciB0aGUgbWljcm9jb2RlIGZpbGVzLCB0byBleHByZXNzIGEgImRvbid0IGxvYWQgdGhp
cyB1bmxlc3MgeW91IGFyZSBhdCBsZWFzdCBhdCB2ZXJzaW9uIFhZWiIsIGZvciB2YXJpb3VzIGNv
bXBhdGliaWxpdHkgcmVhc29ucy4NCg0KQXQgdGhlIHRpbWUsIHdlIGFkZGVkIHRoaXMgYXMgYSBj
aGVjayB0byAicnVudGltZSIgbG9hZGluZywgYnV0IG5vdCBkdXJpbmcgZWFybHkgbG9hZGluZy4g
SW4gaGluZHNpZ2h0IHRoaXMgd2FzIGEgbWlzdGFrZSwgY29tcGF0aWJpbGl0eSBpc3N1ZXMgYXJl
IG5vdCBsaW1pdGVkIHRvIGxhdGUgcnVudGltZSBsb2FkaW5nLCBidXQgY2FuIGFsc28gaGFwcGVu
IGR1cmluZyBlYXJsaWVyLWluLXRoZS1PUyBsb2FkaW5nLg0KDQpUaGUgZXhhbXBsZSBtZW50aW9u
ZWQgaXMgYSBjYXNlIHdoZXJlIHRoaXMgYmVjYW1lIG5vIGxvbmdlciB0aGVvcmV0aWNhbC4uLi4g
DQoNCk5vdywgdGhlc2Uga2luZCBvZiBjb21wYXQgYnJlYWtzIGFyZSBzb21ld2hhdCByYXJlICh3
ZSBjYW4gZGViYXRlIHdoYXQgcmFyZSBtZWFucyBJIHN1cHBvc2UpLCBidXQgY2xlYXJseSB0aGV5
IGhhcHBlbiAodGhlIGJ1ZyBtZW50aW9uZWQgaXMgY2xlYXIgZXhpc3RlbmNlIHByb29mKS4NCg0K
VGhlIG1vcmUgZGV0YWlsZWQgbmljZXIgc29sdXRpb24gaXMgaW4gbGF0ZXIgcGF0Y2hlcyAtLSB0
aGlzIHBhdGNoIGp1c3QgbWFrZXMgdGhlIGtlcm5lbCBob25vciB0aGUgbWlucmV2IGZpZWxkIG1v
cmUgY29uc2lzdGVudGx5LCB3aGljaCBnZXRzIHRoZSBrZXJuZWwgaW50byBhICJzYWZlIiBzcGFj
ZSBhZ2Fpbi4gVGhlIHJlYXNvbiB0aGlzIHBhdGNoIGlzIGZpcnN0IGlzIG9uZSBvZiAtc3RhYmxl
IGJhY2twb3J0cy4gT25lIGNhbiBpbWFnaW5lIHRoYXQgLXN0YWJsZSBmb2xrcyBsaWtlIHRvIHRh
a2UgdGhlIG1vc3Qgc2ltcGxlIHNvbHV0aW9uIGJhY2sgZmlyc3QgYmVmb3JlIGV2ZW4gY29uc2lk
ZXJpbmcgYSBtb3JlIGNvbXBsZXggc29sdXRpb24uLi4uIA0K
