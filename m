Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792579325;
	b=I8flZkylZdlCcWhVUWCNNW3QNtg4NgCw32K79yJyPqq0+PgOtNjXTEhEYnswdxkMU8ai
	 dgtZt3h6/611/92v5IsH0BkE6IbvJQKORC0Ur1r4qRt3SjapgVtKBOXstUkBmD383dLF0
	 1ThYrNCxMUUC4Tx+l3hNqU1nMTdJkJ0TNatjDBHlelfKO5gJTlOWqkN6kh2dkjSjDauXG
	 CTiRQ+U7xhoPIKgl7kezs8GWRGe92KlcZ8sIQi/bjRuZ7kBvVW9n8HXbXsbUqD/jvgGbr
	 6HzQJD+PFdRXNxrgcX4fIF1TrIOB7wT81H+fkHlnMakkl+8pPHiOeNkKGruGNxxf42g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579325;
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
	bh=BzX9QG8eUD/zvsmLv6C50R/sDPc5mOqFws3vtUtrweY=;
	b=X+aKaDNJXOjF8ETzbN4kKoUjA47Msuge8+hB8nbl8HYp+hx+ssG3mKGPzzGil+d1fZoV
	 g8IQZSlB3F5Wb6MJzeBx/F8Soa7NKGYlPHhF4stv7wCdf1OMiR4avYy/iRcVWc6qOZMPJ
	 bGQejORsFHOQmd0sx1Ue9kbeS6APzsCbBjvqRDK+7cbnTiF0gf7TVBtn9IsTzZeOM4qVx
	 3eL+sNOyKGhU93Gwd+XNgCENrecncO5x+uLHMLYL/bJrKP/VFBQ9WpN+ibXXL/Ugj/C7G
	 ah+S1YEx8Bm5AulStdN0mEEweJVyG0y+FX6r7zXpD36h8+tltn4jleoZFsTmSl8Bfjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EdypRVaf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5B606A319;
	Wed, 21 Oct 2026 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DB5B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EdypRVaf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792579324; x=1824115324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BzX9QG8eUD/zvsmLv6C50R/sDPc5mOqFws3vtUtrweY=;
  b=EdypRVafjHGpTXESikVLIDTllVOk9cdnyEGBh8carWwMazs/l8VJfHBP
   KaD5r84IN/DZ0/VpwmeIECiopPRVKiW9amCELbSnQUCVM7sSg3TMiEbYd
   w/JF8Hb9RGPRGEgsMbYPI3eYoSJkC19JaDieEnAAhmDqFeXJaZ2qYC0Gb
   0htmEuq/GONHyLHWTT9XTTqHdPq+FFv/CMIQ7R5DgA717Se9X/9u2o8iV
   iny9Y0s7yAb/anYfUxJAU2tidLKFbsHcNvWL+F4JY9t5apmzu3GPMd1uY
   DBgcDVR74MLDOh9itEOHdEkefURR5aoVk5Tjtcw1crlEoG3S5fb1Jvz5c
   w==;
X-CSE-ConnectionGUID: 47rnKJ4qREe6KzWV8V4zpQ==
X-CSE-MsgGUID: xSTFI8Q/SxqDCNUQa82Fog==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1201997"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1201997"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 03:41:59 -0700
X-CSE-ConnectionGUID: t+5wFpNMQLmVBAaq27I1BA==
X-CSE-MsgGUID: ilFp0jM+STWvW6RhR7MUiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="2947913"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 03:42:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:41:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:41:58 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:41:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5gxkXsdEJwnR4KWjHUChZTc6AJQrUFqNR3jcHsKkjDaA3IOLeJD3edc+Zou0N3n+zOLoOW/Du8mqeWM459pkTsm4/1KuSDEt3a0G/Z+ThsORpzHwXce4GsiJdPHv34FGBmkEL3PgL7grJOi5mPizrBnFA2zZfVtE2IYMwvbZvNnc2GfRn/Q74O/6i3XCBFAObz7+qa5uC7vJpOjuK1M87Hc81hnSV63SgFau2u5G8IHbPWdosPzZHqv87sjHh0S2mLGBO2u/6+d2iwZxtrb+SbYKxZ+lyedM6gXZHK6mBz/mkJaf9kMYFctw8ENotZpCU5GhJAPq28Aujg6r0vWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzX9QG8eUD/zvsmLv6C50R/sDPc5mOqFws3vtUtrweY=;
 b=AW71Yoms9NQ6yOFoSFLIjLXqDgEqM/Zs6fsMxFdo/LNlJbVyG6g8ZxfAxxqZc6iOUPfYeV0UBXi7GKPiT/FuRUA4J72ttwdAdQjRleQ78Y8fVA95d5/Ih+bWM5iGHPHkwtH6yqDdl0y7ZOgvOGR63YVvidRWGzlV4QbzU4xFxannEfi9AHOEihEEmLmupS8kS9NmdMewRkFr1XS8KZHbJT2r9pxPS+IND3uRSlg20PmxZ9Hzu0qyHL+91J/l4H4j8T4lA2tfMw1srBfGIgHS4DXx+XKeoppsSVlebWtZqgHtGRjQLnLY/SmI4+PVWnNRYLyUJcXXbPxhe/HD4Zzddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA0PR11MB4702.namprd11.prod.outlook.com
 (2603:10b6:806:92::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 10:41:56 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:41:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michael Grzeschik <mgr@kernel.org>, Jijie Shao
	<shaojijie@huawei.com>, Denis Benato <benato.denis96@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v3 2/3] net: fealnx: disable the PCI device on remove
 and probe failure
Thread-Topic: [PATCH net v3 2/3] net: fealnx: disable the PCI device on remove
 and probe failure
Thread-Index: AQHdX8+/WqB39ft660+Q6+ZkrMTf1rcH0eVw
Date: Wed, 21 Oct 2026 10:41:55 +0000
Message-ID: <CH3PR11MB566895C6DFA49A4B195B536E67E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
 <20261019134136.104932-3-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261019134136.104932-3-r.zhambakiev@prosoftsystems.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: ac29c03b-be40-4fdb-2e17-08df2f5fed53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|10067099003|22082099003|56012099006|4143699003|5023799004|261009223027099003|11063799006|38070700021;
x-microsoft-antispam-message-info: yu5K59DJpPorgbpVbVUwtLiFlE9+slLfesBWCwfoVnrc7UxH/YtgW+D/QJQ/uEEATRaKk1dIXmtveOGu2SNjKNiFHJKm+e/grgYw/1yxSgLfimSMfA+jxtk84yUAVmR6HGRN6HDBQwrPgCsJ9iBSK6ZRiDbPQ5qB2v5sGLdHhWcWwKASs2dZWdltExYdJ7sU59tm4g9alCOnLaMT5T68+hc8gp+5QB04rw3q+geqR4w5wo9uhU2xWQG7pSfu3hbzzag6Qp/uD8QFoa8CONooTBpSV43NXtu6SRuazyAqqsrFNjZPSNV52hQLChIg5wM7SupV0Cbw6wGdtgrIPyu37okbU1H8gWgnAdEXgB/fEvzBpCirm+0LgP6AsJhAhCsDzmLDxSeMPNOBRD/KTqqwC56bzqrJaYef4DoUjeMvyKotYxBxV5S+SZPEKmTR/f8MXFVF+HNZ3ehciwYVMc1m5VEItGH2KZAWqVmGt22AWKVOBZ0jqyyH78WO5FcfdSoArnnODjKaKVBOvEP6ot8aPcFVHeKdO0y5+SO01mdOPWK8pueR/SEYncBEHn2WdfMc14h8p49JwQIPBkTfpwvu39BtZQALditSyrFt25vMjT3PefZklTCZjZqAjMqFcmqna/WSIqigctKJLE18U2LkKtw0bJOs9/hYNsr5eF232dVRfc6IQJG7+4PPsDPyhZHNBaaPq+eamL4K2vMTbTYOCFyiblHlep+xZapMxDFd0hU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(10067099003)(22082099003)(56012099006)(4143699003)(5023799004)(261009223027099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVQ2blprRVBkbDFqS0M5bkVPbENiazQ5R2EvR3NkL2o4VzFkaXA4ejdPUEdE?=
 =?utf-8?B?YnA3cEw2Y2h2dFBiTytqWEVxTGs2QnpiamF4cDBWcmM2aUJEa3NudkRRWTZs?=
 =?utf-8?B?dWxKMHNRdUU1emRpaFduUEI5Y0RvOFU0VGc1eDNHYWZCRW53cFgvUFUzK3ov?=
 =?utf-8?B?WjZ2ZHdwVmxNU20xVEFIeHppdTJxUjEyMkwzSGErTTZtczB0NXVZYUo4Yzl5?=
 =?utf-8?B?S1hsVjJTVWZvaUhmc3JldUhLMnR5UFJ5dDN6YnNXR0twbzNRTW9BK2NhcXRu?=
 =?utf-8?B?bzU5VmFJZ2JFVGNITFFMV1RvNWpMVWRTTitBd1MwMU1rRjJ2M3NuWGFhYXln?=
 =?utf-8?B?cmJWVEZZcm5VeVFKbllMNEZuU0Fnd0l0VUZoeVdmLyt1QWJuOW4rR1NNR0xL?=
 =?utf-8?B?T01xeTNsai9yd1J5cDRzWUJUUXB4ZG56ZkUyYXFseGlvM0daTzVyRmpWekVC?=
 =?utf-8?B?ZVhsLzZHRlprM1BlZFEwUUVYNkNKTXBYSE5Yc25ScSszYWhKcWVDQ0cvNzlj?=
 =?utf-8?B?TEhuTTNGVnM4Mm9QaDBob254QmYvTGlIRHQzVWJqUmRVMlRaZUsvZmhIUml4?=
 =?utf-8?B?MjZ2MFNZNVhtaWM3MmFjODdGdEg2cCtCRVlJaDkyekdRZWlDWnhNQ0xscTZU?=
 =?utf-8?B?QytQbWJtNmJGbDNTN3hId3gzTElsSTlHMWpucGxtdDUvcW9ydjI1YnpXQjRJ?=
 =?utf-8?B?N2VxWkdxdEcwV3hUaHFpdGhSK2tEWjh1VHBnVlpSK1FjUUdQTjVDaHFWeGpq?=
 =?utf-8?B?UTIrdld6VURMZFpFT0RtRUttaUtqOEtVd0VNaXNNSVl6Z21TeHk4T0VGQ1Jo?=
 =?utf-8?B?M1B4ZHRjSTRPaExudFIyOVRCMjZMMXlCUk80NzZ3NWorNW9ydGY1OFZFOWxB?=
 =?utf-8?B?MTJRTEtzbUQ4K2ZMUHBWbVliRFZsQ25oSkpUNmxray94ZmFrOW53UWlPbnNK?=
 =?utf-8?B?bXE3M2o5ZUE3b01nd2FkWm9USjV1T3UxOXZieUliOExRUGdyZGpQRjNyaEEy?=
 =?utf-8?B?Tk0zU0U0Rnc2T1Foai9oejRNK0V4VXZRTE9xSWJndUhoQTZDY3RqYTNHSkdG?=
 =?utf-8?B?ckRvVEt0WThqSVRCZHp5T1Zka3RDZWZJbDFLU0p5OGdTcVNORjVNU1BJMWVk?=
 =?utf-8?B?ZnIwYXNjSDlDVkJETGxqTWdiS3h0RXVuZkNVNVBieVAyclhMWDg0blVuZDZl?=
 =?utf-8?B?RFlSMW9NYVFCUC9pN1NSS0VnMVlFM3FvWVhVTW5VK2hlUFkvajlMRVg3dkUr?=
 =?utf-8?B?bGVrcHFROXQvMW40bEhnbUZEeEFTV0ZSd25mcEFKR0lNa1NDZlBlZnFUdFh4?=
 =?utf-8?B?SnpxSllFYTVDVklkbVo4REVlUjdCckxqQ295TTAwUlhHWGd4Y1BpYWRoSk5G?=
 =?utf-8?B?RmxYeGlpc0NEOUkzeTdPUXB3d1F1bWZzaE01czVrczA4OUZMS0JOYXFFL3A0?=
 =?utf-8?B?Y3ZtTTJtZ1JJb0ZqNXh4Q3NoVGlMOEY5R3ZLRExlRnlmRjRKQ3d0TlpHNm0r?=
 =?utf-8?B?eUpWbDExVnVCd3NDWXVFNGRFYTQvUGhYZUFra3FUclp4UGdGM3FJd3FmVWJX?=
 =?utf-8?B?RzlNMDYvZHRqOXNxcDhka3VWWWtZMTFKVzRPU1FqSmxySWJVbFNocUYxT2lY?=
 =?utf-8?B?MjdFMGVsblAzcUZhcC8xeTd1OEl1MmJuRjRPT0g3aHNtUkhqSVBxVVF3RFlP?=
 =?utf-8?B?WDRBbm9DN3dsMk00UzRkZE9MdjBycXpLdnZDNWgwMjlpVW5OcS8yWTNnQlFJ?=
 =?utf-8?B?U00wMXVpUGtUK2paVTZ4V0tFcDZId2pWM3p3NFNRVnNCdDZkalFsaSs5QVND?=
 =?utf-8?B?a0hzV21yRnRyOEFNbml5cE1wTmlGOGhxeml2NTJPSkdSLzMvTThwdXF0cXZw?=
 =?utf-8?B?Wk5Gb0ROY2s3UHBDVnduOFpkUlI0dHlEZTIyVFd4WERWQis3enEyTmV0R3Vi?=
 =?utf-8?B?ZW45c2RLanBEeVhsK2dpdmJFeXlZMFZzTEptTGxYRnNmZGhqaUVxSy96YTcz?=
 =?utf-8?B?R1ZRNmtNNnllZFVMVlNzcnZqUXhLWElBMVVVeTZIakhRZ29XRmtpNVZQc3Ir?=
 =?utf-8?B?VklHaHZNRnBsZXhvQm5ieFRrRDNnaFFRaU5lZmU1SXR3ajlkUTBxaXVXeks4?=
 =?utf-8?B?RFh4SzBRSUg0Vi9QYU9iK1Z6TXpLVEZTalI1R2JBM2hHZUtHTkZSaWFyRVh5?=
 =?utf-8?B?dXQ2RUsxNDV0RnBtcS9TL0ZuTHBuSnZCd2gyQ0loWGxSQU5UVFMwSnB4OE5U?=
 =?utf-8?B?MkR3R1RUbVo2SkJPU3dIVnd1QitnVmNwR0NWdi9GSTVxNHZlZ2xKNFVPRkRB?=
 =?utf-8?B?Z2RiYmpsUDRzNmVTdFdDWGh5SnFQY3lrZFUrVU5hSTV2eEkrUkUyL1I0K3Zv?=
 =?utf-8?Q?yTyVRjFG3dvAi6Co=3D?=
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
X-Exchange-RoutingPolicyChecked: GOGGKWRq7LR3BzecCZutw1MdqqMf4+6gJd/ERu4mKQUF/FriTAXAAXF5+LmDMN90R6ez4cLz9uepH8zyV15nk/ckDzyxPZDqq9lkfMIrmE7msFE7lOyKDtaMdW+GK6AOs/RDfb59C78c8vewXQe2PNzhs6Aa7NerVlrAHTC6Pbe2XnxVt4tWGI67oDmsXEpZ4qKsgVj9C4H4etcBaK5kYXx0syIMTRQ81b/1bJCmfH/STEypq2t0tKjQDjkVKc5jVErDS6a1HybQCZs3XcbeQwc4dZAiCo5KvGdpPzt8jb4XBIfUomKY2vX+7PI5OVA2iMrNu2zr7RtpkarU3NU87w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac29c03b-be40-4fdb-2e17-08df2f5fed53
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:41:55.9715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0R2v4pp4NaIm/DAuiOzK9+W2v60bZnwlXNbbT5XTFD/yS+5ha8Nu3eASfpDd47Aq4Xi+C6jsDA7GxzAnPWViczvsrEuwoczvat/MX3vIeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog0JbQsNC80LHQsNC60LjQ
tdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00LjQvdC+0LLQuNGHIDxyLnpoYW1iYWtpZXZAcHJv
c29mdHN5c3RlbXMucnU+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxOSwgMjAyNiAzOjQzIFBN
DQo+IFRvOiBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPg0KPiBDYzog0JbQsNC8
0LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00LjQvdC+0LLQuNGHIDxyLnpoYW1i
YWtpZXZAcHJvc29mdHN5c3RlbXMucnU+OyBEYXZpZA0KPiBTLiBNaWxsZXIgPGRhdmVtQGRhdmVt
bG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0KPiBKYWt1YiBL
aWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29t
PjsNCj4gTWljaGFlbCBHcnplc2NoaWsgPG1nckBrZXJuZWwub3JnPjsgSmlqaWUgU2hhbyA8c2hh
b2ppamllQGh1YXdlaS5jb20+Ow0KPiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+OyBEZW5pcyBCZW5hdG8NCj4gPGJlbmF0by5kZW5pczk2QGdtYWls
LmNvbT47IFV3ZSBLbGVpbmUtS8O2bmlnIChUaGUgQ2FwYWJsZSBIdWIpDQo+IDx1LmtsZWluZS1r
b2VuaWdAYmF5bGlicmUuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGx2Yy1wcm9qZWN0QGxpbnV4dGVzdGluZy5vcmc7DQo+IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIG5ldCB2MyAyLzNdIG5ldDog
ZmVhbG54OiBkaXNhYmxlIHRoZSBQQ0kgZGV2aWNlIG9uDQo+IHJlbW92ZSBhbmQgcHJvYmUgZmFp
bHVyZQ0KPiANCj4gRnJvbTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRz
eXN0ZW1zLnJ1Pg0KPiANCj4gcGNpX2VuYWJsZV9kZXZpY2UoKSBpcyBjYWxsZWQgaW4gcHJvYmUs
IGJ1dCB0aGUgZGV2aWNlIGlzIG5ldmVyIGRpc2FibGVkDQo+IG9uIHByb2JlIGZhaWx1cmUgb3Ig
cmVtb3ZlLiBEZXZpY2UgcmVtYWlucyBlbmFibGVkIGFuZCBidXMgbWFzdGVyaW5nDQo+IHN0YXlz
IGFjdGl2ZS4NCj4gDQo+IEFkZCBwY2lfZGlzYWJsZV9kZXZpY2UoKSB0byB0aGUgcHJvYmUgZXJy
b3IgdW53aW5kIGFuZCB0bw0KPiBmZWFsbnhfcmVtb3ZlX29uZSgpLCBhZnRlciBhbGwgb3RoZXIg
cmVzb3VyY2VzIGhhdmUgYmVlbiByZWxlYXNlZC4NCj4gDQo+IEZvdW5kIGJ5IExpbnV4IFZlcmlm
aWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpDQo+IA0KPiBGaXhlczogMWRhMTc3ZTRj
M2Y0ICgiTGludXgtMi42LjEyLXJjMiIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFNpZ25lZC1vZmYtYnk6IFJhZGl5IFpoYW1iYWtpZXYgPHIuemhhbWJha2lldkBwcm9zb2Z0c3lz
dGVtcy5ydT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYyB8IDEyICsr
KysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0K
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jIGluZGV4IDY4MTk0YzllZjMzMi4uYjVl
OTZjNzAzN2YzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0K
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KPiBAQCAtNTAyLDEyICs1MDIs
MTMgQEAgc3RhdGljIGludCBmZWFsbnhfaW5pdF9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+
ICAJaWYgKGxlbiA8IE1JTl9SRUdJT05fU0laRSkgew0KPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYs
DQo+ICAJCQkgICAicmVnaW9uIHNpemUgJWxkIHRvbyBzbWFsbCwgYWJvcnRpbmdcbiIsIGxlbik7
DQo+IC0JCXJldHVybiAtRU5PREVWOw0KPiArCQllcnIgPSAtRU5PREVWOw0KPiArCQlnb3RvIGVy
cl9vdXRfZGlzYWJsZTsNCj4gIAl9DQo+IA0KPiAtCWkgPSBwY2lfcmVxdWVzdF9yZWdpb25zKHBk
ZXYsIGJvYXJkbmFtZSk7DQo+IC0JaWYgKGkpDQo+IC0JCXJldHVybiBpOw0KPiArCWVyciA9IHBj
aV9yZXF1ZXN0X3JlZ2lvbnMocGRldiwgYm9hcmRuYW1lKTsNCj4gKwlpZiAoZXJyKQ0KPiArCQln
b3RvIGVycl9vdXRfZGlzYWJsZTsNCj4gDQo+ICAJaXJxID0gcGRldi0+aXJxOw0KPiANCj4gQEAg
LTY3MSw2ICs2NzIsOCBAQCBzdGF0aWMgaW50IGZlYWxueF9pbml0X29uZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwNCj4gIAlwY2lfaW91bm1hcChwZGV2LCBpb2FkZHIpOw0KPiAgZXJyX291dF9yZXM6
DQo+ICAJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsNCj4gK2Vycl9vdXRfZGlzYWJsZToNCj4g
KwlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gDQo+
IEBAIC02OTAsNiArNjkzLDcgQEAgc3RhdGljIHZvaWQgZmVhbG54X3JlbW92ZV9vbmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYpDQo+ICAJCXBjaV9pb3VubWFwKHBkZXYsIG5wLT5tZW0pOw0KPiAgCQlm
cmVlX25ldGRldihkZXYpOw0KPiAgCQlwY2lfcmVsZWFzZV9yZWdpb25zKHBkZXYpOw0KPiArCQlw
Y2lfZGlzYWJsZV9kZXZpY2UocGRldik7DQo+ICAJfSBlbHNlDQo+ICAJCXByaW50ayhLRVJOX0VS
UiAiZmVhbG54OiByZW1vdmUgZm9yIHVua25vd24gZGV2aWNlXG4iKTsgIH0NCj4gLS0NCj4gMi41
My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT4NCg==
