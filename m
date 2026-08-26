Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC941862;
	Wed, 26 Aug 2026 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787703223; cv=fail; b=bw3NNoPEMtt3C+0VD2Pcb2/wGYgvnH+MJO8FJP/A6LiBiPUqr81iJoZAceky0d2GLCQDvtVDze7HO9itq9Rx91omWeljUE7xruZ3RtnCdE5mKJKpEGLD1MIwoth9JaxxEtPnmlJFQj0j0Yk6V4cuNzs78g3fr8enY1LgI/Asi8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787703223; c=relaxed/simple;
	bh=GHzU8c96a8g4/yULI/EjCcjt73QmXOsC54hi8nqpr6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAhStAQrQeipELII7YSztlOh8ztdP8cP26rC2ahxJLPFpW8yirqap7Cj15Btych4CQgbK9Z/UEnNeV8BgQjSoew/vgiejqPLxzG0N2CCWXmRYe9FOf5oeFn+rd8V9KyH/0zX0+JIK5OobkQsIgbGV5C/QV9Z1Vh1wCZz31sdeDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivC6Lyh6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivC6Lyh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787703222; x=1819239222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GHzU8c96a8g4/yULI/EjCcjt73QmXOsC54hi8nqpr6M=;
  b=ivC6Lyh6UcpGd4M4x5lZv4hIenbE03yjZWdjr8S/X4C6qwsYpXkx6vWc
   V+CQxT0P+OrtXHvcDt19zjOwV9ThQh7IbnGobjH7vUXF5oNC5R2S0DKM+
   /klBi9zZq6zbdzhgm5VS9yR0rhKQG6EeOiYmFgvOeLwrdObhItO+EFEqF
   0kQuXdqA+Z/tFZ2JnRcZ7R0wyRhPKX+hKi8oNhPFHfCrMtxEx9JsYDWFe
   NoihM6Tpw/BceHMeCJsv0KRxGI5/tQsTAgOprgk2AzxJj61k0H4e85W8Y
   aLaBE2dqTz3Ky5aO8MC1Phj9ys9TANHOXEZ5v1o9N3dRZvPDwInON7J5u
   w==;
X-CSE-ConnectionGUID: 6wN0d5iMRZyL/BM8KyWziw==
X-CSE-MsgGUID: cgGvrKfCSJKhQaeDohIp8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99337489"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99337489"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 17:13:41 -0700
X-CSE-ConnectionGUID: Sb5YGnqrTkui36dusFX6Hw==
X-CSE-MsgGUID: DyH7HqcBQzyd1qBEOuJguw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="270917594"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 17:13:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 17:13:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 17:13:41 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 17:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcj+YtTFB9rl8IQAqVusOnj7raaXUw41yASUImRo3LliX7FtAZDVa+UTB18fw1igkHslP9vypb4+AWhttlgjyb2YPab66cwuvxNGAnDXmfeeI6xjSgEbqXJWyCvfVyF+ArUUA66LCDzhSTxjvStsdfUidpYzxxPprseXdmTICwShJvht8ST/2g/HXv3+G620iyKzqP1Oy/4hTWcox4fuSzqDlCVdcc20BPbEyGR1fB58M+4d1ZsFG/Wbjoz5RPPy9ugMypzJpAwmwQYGgYmAtfrQOaUe6H+UFzJDjjFAgYQiDRp1l1eqgFppEwbMpmtqGV9Bg/Q3lv+7V1ZcHSXyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHzU8c96a8g4/yULI/EjCcjt73QmXOsC54hi8nqpr6M=;
 b=KZDqXTtpTSM/zqJ7nXFtkFgDRkf2vPEEzyrq73qLhqWnPSl0pgAZ9QMD5RvJGPE6aOZ6zZ93oh3h6TIvvsbpV5Jt/1a77blBTsf/Xy6OWuhTeQfjHAwtpBg5z+01IwL9rJ824izJP3ctMBkITb9fyTqmcZdsv+gudvermRy8o/oWFRHPe4WjADj2QZ3msbHChEskRsxaJqdtYkBRPVGkqP0WfMs4bhfA8UeVBITXUP048zh9yqlPLAQxbmGtYQtxBXL4sMtDp8t6gEL7K1VkiyDHEer4HA6GHE7AySjtxp+wVGoBXA47ISrRR2Xff66re7szc7lCW+rBkgpN8HcBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by SA3PR11MB7528.namprd11.prod.outlook.com (2603:10b6:806:317::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 00:13:38 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 00:13:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "nicoyip.dev@gmail.com"
	<nicoyip.dev@gmail.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: x86: Take SRCU in kvm_zap_gfn_range()
Thread-Topic: [PATCH v2] KVM: x86: Take SRCU in kvm_zap_gfn_range()
Thread-Index: AQHdNMEdZ/cHm5M28UKhmyBrSNNpwravdfQA
Date: Wed, 26 Aug 2026 00:13:37 +0000
Message-ID: <2c9959ff90c50de6f331dfbfbcdc1e99bcb122ba.camel@intel.com>
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
	 <20260825183924.237727-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260825183924.237727-1-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|SA3PR11MB7528:EE_
x-ms-office365-filtering-correlation-id: e5d8d243-bd49-4316-86e9-08df0306e06b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: TrzH4PXplBxY4SEJXdQzt2sCpSVBpM1wB5wPZDmYcz23STQfcBnP7bvFE0MW3xpS2rNpfDpCFKxf6QX+fqMLLv9eIyvffzLFuP4lkAEsRsFQXhakREXn8pQb/dgSqrg/RYDUeG+dYc3wAm16hGYZZttqAn2d2kB45ZaLvEOwl3x+00o3u1lEeOrwWu1WA4WuE4vziToEyAKGU91p6/0GyjvjCpa4i7+Chx4Fg0qoktcIQVLLuQbC6qXzM0mGGsZJ2819uv6KXecJhaJUKEnybILdSWRGR1qzcHhft5TDU91XxX0alVrGoywDzOa7O+tvg5MBsri6lwqB/R445TYrVY+R74OjWo13CNdbe7wg/+F73FxldEZ2eBpiR4+XWDBVdknDRBRmUjJ8/wMYvVRXssdbEsBJ1z6FqR5Xvd+WAzXQkun//iCLPY5C73nFjJ+pTs/GU0jHnuCTQEFe2hCo20vTnr1ncojUDQMmc0LIJr21X3i4hHPPzkKKwvmc1TYXdOje19kSMhs8upsAGmSRQ9OclDAmaIcmbnBe+X69LIsd0pXVeaIf5bbIOsZiDPht2tLOS6UZbSi82LJp48Oh3OddoMszdZAvJhQtUE4jXiLF3vSnyCzbRHcbF7M68OSdW9cQJ9SAie2k866sMXJQ1L3U2tQyk3MUzTGylz8wDPegvJwnNCJtsOiryUieoqTi1XMz1tgEXHKaL+dmF1sYGG52BOqbyqi3NVEzsMoTpwk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ektXVWVOVVM1ZjVDS0R2SjN4WU5NbWRyR0hrWWZFbm1VNngremJtUEYzdjFj?=
 =?utf-8?B?c0lNbVBaaFIyTUJrTzhNaUU3QnE0Y2lBdS9OcmxVTEtFeGdUaVA0V0pXd3Fx?=
 =?utf-8?B?TTlJRStjYWMrNTVwVEV5TXQzS0krQXRZcmNHMFFBNFFjc3VDMVpwM2tRdmNE?=
 =?utf-8?B?WVE2OThlSllPWWN2VndZclEyZzZVMGNkOEU4SEthbTZMQlJobjNHRDlzamI0?=
 =?utf-8?B?TGFDeHUxZHhmZGNaNVY5S3U0aE9Td0pRcEtxNUpKYUdpR1V6Z1loNTk3M2dj?=
 =?utf-8?B?MTRWNm5oSEFBRGJtQ3huUTBhVkxsdjdRMnppMG1YVUY1ZHJ6bCtpb2hmUVdl?=
 =?utf-8?B?Q3ByQVZMa3pPd1dNdFhKSWw5UHM2SFA2azZjOEszRVY5RWtjQ21uczhtWVBY?=
 =?utf-8?B?VFc0aWl6YUI1Znk5RjFvdnhveDZja2h2aE9pTVVXQSt4RXFRR0tWaS9JQkN2?=
 =?utf-8?B?OWgyODk5MWpkdG1pV2tieWRRc052UUsvZlV1QkZnSzcrakxCZyt3MU1XU21C?=
 =?utf-8?B?WkcyTUt6N2pBOHgrdStzT1NtV2FXSEZNYzYrbVNaTkZNTXc3V2ZvbVNQRzNz?=
 =?utf-8?B?L213MWtOMTVsUzV6NGlBbGZYcWRGMzNKRndrSmpoczlyNnhtQkdDTi9QNU55?=
 =?utf-8?B?YXhBVE96V0FJZmdpTlFiQUJzdm1Db3JvckJQRTFTY05vZURVVlZoNFd1UDc2?=
 =?utf-8?B?SVU5TGY3bFlNN09kaFM1YVlNRzJKNmppcnR5bXlsL3d3amJPbmRzc0FhZ0g2?=
 =?utf-8?B?L01MYU5xSGVlMi83anR0SG9HeFpiY2ZZRVBlMFlGSmU2cUs4WU03cW5RSnpK?=
 =?utf-8?B?OU1LNkY3UjBmVnZ0ZjVoOXVwdjBIT0JINitGYzZxQWRTWHUrWDJneXQyYmJ4?=
 =?utf-8?B?SjFyU0ZVanUwMnRjWllZeU0xRFRoRXk3RXEyenBYWm5FY3V2VEtPWWp3RnFE?=
 =?utf-8?B?ZTI3YlpRdWprNlAxc3NXek4vYUd1SWJabTk4bnNCNElFLy9sVEdreHAvaWFh?=
 =?utf-8?B?aGJlazB0WXhDaUY5NndDbExsOFdhZWg0eDVxS1cxMGN4eFR1MnhpaXVoTmxZ?=
 =?utf-8?B?L0FSeWJDbjdJMzdZelZqbjJyanRoeG90QXBKdlVXcEhmaWU4ZUp1a29rQzRL?=
 =?utf-8?B?MkdTREdnZ1k5SHBLUU9LV2FNUWVXRWZLS2o5RWo1YXpZZEw1Ujk3anZubUlZ?=
 =?utf-8?B?ZW51QnltL3VCWjJrZG1RN3c1M2dqV0xRUDg1ZkNWdXgyZUg1N1Z5SjZ5U0Vo?=
 =?utf-8?B?VVVOQURma29vdHdtVzFyMzk1LzMzUldXMi9ibkd0b296UDR3bExsUmtweDlD?=
 =?utf-8?B?YmRjYTFsdkVSS1hSQ3FkOG1xNG9EV1NFSnpOenUxaEovaCtiSy9oODVRRktZ?=
 =?utf-8?B?VkVuc296bHIzZEkvS2l0K0xMOGd3TGplb05yRHlCNkRoMTRWNmR2R3pZQmli?=
 =?utf-8?B?NldJb0JBZUozMFB6RkdtazdLWWxobHJ5QXZoL1doczA2WHR0aEVPWHNUcG01?=
 =?utf-8?B?SU0vdzQ1eXljNVpBc29za1BoL2hlWFFxS3gzeDVwMUh4MUNNNTBPOVBPQWVK?=
 =?utf-8?B?UHB6SGRQSklDZ0p0VUI0MzdBQzVhbkdyUk1wSUk3Y0Jtb0txeGNwakdnMERQ?=
 =?utf-8?B?bVVseUF6Z2FzRFJ1dVYxaXFlZmlORmpQNTFRckZDbmJWUUV6UHdOL1R2WUtS?=
 =?utf-8?B?T2F4VmYxR0hDWVdJRkdXT2VKaTliV2hJNHRITHYrUUlXdVo4TWt5K25uQ3p0?=
 =?utf-8?B?WU02QkROdkg5OGZrak1TWjZlQmlVSUJHV0RsbWlmSUkyb2g0bkdFUGtaeEhM?=
 =?utf-8?B?OVBvVklhRjNRZ0w0UVZIdWFqNm9vZ21YUTNTZjlXaHo2bHl5YytXQ3QzSVVo?=
 =?utf-8?B?NGhIc0w4bG5zSFRsdkEzZyt4QkZRa0ZVUGFlaXNtM0pWQk1OaUNtZFNUMkdv?=
 =?utf-8?B?MFEwV2FQTXRtcnE3SEZPcVJiMERCdFM5akhRbDJDdlBXQzMrWloxOVA1QUZZ?=
 =?utf-8?B?L21FeXlsTmozQlZDZ1FVam92c3NHQzI5MGNTem9RRGlpaDNlODdOejhxd3I0?=
 =?utf-8?B?bDQzamx4M2luZ1NybFplb0tOZjhWb2ROMmduME4rdXNUZW1CYnRnSjRvNGRz?=
 =?utf-8?B?eWZrWE14b3RXbEZsRXlJZ090Vjl1aGVBWWRBMGF4VW02SCtaSjIycDhiekFq?=
 =?utf-8?B?bHhFdGluanZsVnY3RUFjT0ZYSVF2UVlrWTk2ZXpIaFdteHU5Sk1aaGF6UUN3?=
 =?utf-8?B?d0I5SGRjcjhzS09UNmJHR256RmVBcUhUVy82VzZ4U0ZMaUZUU1BBd095cXB4?=
 =?utf-8?B?Y2FvNzFyUjA1TnRvUDdUcm95dzgxQjE4eWwwZFhKVGZsYWg0b2Ewdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94610542F9354649931CE8DE77C95462@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Foh63oI8DLevn9EOko3oU+IT+OXJBio/WxQEfPj4ayUy5oqSgkoM/RJdC8AxX7+i2qGrol5XP76wRwjYXNqNbL/GCl11lVe+zr5dGIepd1fEjeS/TGl5zlD5/j5f8depiyebULJ676D/JhN4J66VQSMF0i6+pmrCMkg+qt6pdvQx6pSQiuzXtkFnYhyxfZeGy2rjta4LPW0k2wOCwpy3z+tWRDhWdIlXF7EsYthnjsJbUtwt8oMRTQIEgFwunMXtQj4+F5AJteTwt+O38ATo6ILCgC9EKt/7Utw1XTi2lkOjsMWZg720MZnPTnVbzLmNGB6LHG9wgVTjblcG7qzPXA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d8d243-bd49-4316-86e9-08df0306e06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 00:13:37.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLmTvpdgQ8+brhp73Jq40S36L+2veXOdDBEg0lKZT/512dEo0feLXcK+3XRVFGkmkLPtKcZKczFN019BGH4v/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7528
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDAyOjM5ICswODAwLCBDaGVuZ2ZlbmcgWWUgd3JvdGU6DQo+
IGt2bV96YXBfZ2ZuX3JhbmdlKCkgd2Fsa3MgbWVtc2xvdHMgYW5kIHJtYXBzIGFuZCBtYXkgZHJv
cCBtbXVfbG9jayB0bw0KPiByZXNjaGVkdWxlLiBDYWxsZXJzIHRoYXQgZG8gbm90IGFscmVhZHkg
aG9sZCBrdm0tPnNyY3UgKG9yIHNsb3RzX2xvY2spDQo+IGNhbiByYWNlIHdpdGggbWVtc2xvdCBk
ZWxldGlvbjogc3luY2hyb25pemVfc3JjdV9leHBlZGl0ZWQoKSBkb2VzIG5vdA0KPiB3YWl0LCBr
dm1fZnJlZV9tZW1zbG90KCkgZnJlZXMgdGhlIG9sZCBzbG90IGFuZCBpdHMgcm1hcCwgYW5kIHRo
ZSB6YXANCj4gcmVzdW1lcyBvbiBmcmVlZCBtZW1vcnkuDQo+IA0KPiBUaGUgVkZJTyBub25jb2hl
cmVudC1ETUEgcGF0aCBoaXRzIHRoaXMgYnkgemFwcGluZyB0aGUgZW50aXJlIEdQQQ0KPiBzcGFj
ZSB3aXRob3V0IFNSQ1UuIEtBU0FOIHJlcG9ydGVkOg0KPiANCj4gICBCVUc6IEtBU0FOOiB2bWFs
bG9jLW91dC1vZi1ib3VuZHMgaW4gc2xvdF9ybWFwX3dhbGtfbmV4dCsweDgyLzB4MWMwDQo+ICAg
UmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZmYzkwMDAwNWMxMDA4DQo+ICAgQ2FsbCBUcmFjZToN
Cj4gICAgc2xvdF9ybWFwX3dhbGtfbmV4dCsweDgyLzB4MWMwDQo+ICAgIF9fa3ZtX3JtYXBfemFw
X2dmbl9yYW5nZSsweDE3YS8weDI4MA0KPiAgICBrdm1femFwX2dmbl9yYW5nZSsweDJhNi8weDZh
MA0KPiAgICBrdm1fdmZpb19zZXRfYXR0cisweDU3Ni8weDc3MA0KPiAgICBrdm1fZGV2aWNlX2lv
Y3RsKzB4MWZmLzB4M2IwDQo+IA0KPiBUYWtlIFNSQ1UgaW5zaWRlIGt2bV96YXBfZ2ZuX3Jhbmdl
KCkgc28gZXZlcnkgY2FsbGVyIGlzIGNvdmVyZWQuDQo+IE5lc3Rpbmcgd2l0aCBhbiBleGlzdGlu
ZyBrdm0tPnNyY3UgY3JpdGljYWwgc2VjdGlvbiBpcyBmaW5lOyB0aGUNCj4gaGVscGVyIHVzZXMg
YSBsb2NhbCBpbmRleC4gRHJvcCB0aGUgbm93LXJlZHVuZGFudCBTUkNVIHBhaXIgZnJvbQ0KPiBf
X2t2bV9zZXRfb3JfY2xlYXJfYXBpY3ZfaW5oaWJpdCgpLg0KPiANCj4gRml4ZXM6IDM2MmZmNmRj
YTU0MSAoIktWTTogeDg2L21tdTogWmFwIEtWTSBURFAgd2hlbiBub25jb2hlcmVudCBETUEgYXNz
aWdubWVudCBzdGFydHMvc3RvcHMiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBT
aWduZWQtb2ZmLWJ5OiBDaGVuZ2ZlbmcgWWUgPG5pY295aXAuZGV2QGdtYWlsLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KQnR3LCBJIGZvdW5k
IGt2bV9ub25jb2hlcmVudF9kbWFfYXNzaWdubWVudF9zdGFydF9vcl9zdG9wKCkgd2FzIGFkZGVk
IGF0DQpKdWx5LzIwMjMgYW5kIHRoZSBTUkNVIGxvY2sgdG8gX19rdm1fc2V0X29yX2NsZWFyX2Fw
aWN2X2luaGliaXQoKSB3YXMgYWRkZWQgYXQNCk5vdi8yMDIyLCBzbyBJIHRoaW5rIHRoaXMgcGF0
Y2ggc2hvdWxkIGJlIGFibGUgdG8gYmUgYXBwbGllZCB0byBzdGFibGUga2VybmVscw0KY2xlYW5s
eSAoaWYgbm8gb3RoZXIgY29uZmxpY3RzKS4NCg==
