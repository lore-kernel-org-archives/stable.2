Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2B48164E;
	Fri,  2 Oct 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950744; cv=fail; b=mKVRE3DMj3SwXayNEUtn4f+9czvYewigCUkXgvUs5HDoXWwsWzu7nPfBKTP3xpuqmPSwNyzr5TXnw4wzYMSCRIBZKUKAOOI4+0Kv14lEhcEvK3imZfsWCtlzjDsdCyKki/7aYTS6Cl8b039Sb2WdgaU2wB9oulZ0s0KOdSaKDU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950744; c=relaxed/simple;
	bh=QDJ+SYpzjhErBEx/S0xtUURJ0yTkfaMnOb+LWfjy1CQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ii1OUuRptlnp88Lm3orurTkX5z/yZjSdey1ULjeGIgijPkCItVZo/ebrWx7gk/4WspO2Na3046NlNbxWz0zLcU/3bDQpCWlosmEdaKsgXfRj2m0oMzFjpIms0PK4QENuEyeRvk4HF6ifUhINN9ZBPxQp4RlwAAq7MYC6a1Va04g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5DfP4Jr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5DfP4Jr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790950743; x=1822486743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QDJ+SYpzjhErBEx/S0xtUURJ0yTkfaMnOb+LWfjy1CQ=;
  b=a5DfP4JrRV4HM5pWRpn1396NQFkDqYpsKOzBkVYDjC2aVJTvprEznyu6
   PfYRF46KQdY0+TwI7b2UC4i28gL+FlljNI9PTFhBY/JnFVukW+3CHlde7
   NjNBow+g3WX3p4VEvDuqlyoXtTuwwhm06xEYVqAhp+rzgYTVy35yU/qk9
   IO8WlzfoY+70Cr9cyT3h5NeWHhtDiG+qBIQ2equoXWCl5kTbJC7kBQpi0
   6QOt072dipM3oI6aSWGBNgigJAeURn7qalVARhh0Wyj+I/mZFnzJigJxI
   DH/e0MnpJJ382I4oWdWoSEIemyUKM+RoVYMDzOiZgts2m07e+PImcs/RM
   A==;
X-CSE-ConnectionGUID: kHGYjhiFTDGYtwPKTnOTYA==
X-CSE-MsgGUID: +Y1wUdHYTFGC0+HDNemOKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90575723"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90575723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:19:02 -0700
X-CSE-ConnectionGUID: P07cf5kUQ+i9/b5tNueyyQ==
X-CSE-MsgGUID: YMfJdLW/Qfyy4QnhJjQchg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279506997"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:19:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:19:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 07:19:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y87rOS0/p7C6yHnsg+lE8S+KUDi18abmrMqmjidkV4E1cXhtAWSRcwv2ZLilEYSqqd2xknx44bUD3j9XeU2/sTpu7MtX7m6vr+T5DvTUk7estG+RIkBU0ks5/D/hJS7dYbaHpNVpBiM1/DmM05MwYH64XCQVlG2MikFaZZSL1c74CgUt7U0lXl5oeI3JqP1bDLb4zxVxzKLtdHiUu7GeYeX22bxqYU9ydBWYQVpahaz2PWwmlXyrMRNxzPTz+3FrvvDyldVvOCKl5csoNnTyuFFw+NoV0SDi1z4euPSxVLcXza5vUlST3I+Wkr/rAZ24i8Ic+DeQL7rBuNjk6N5trw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDJ+SYpzjhErBEx/S0xtUURJ0yTkfaMnOb+LWfjy1CQ=;
 b=ZipKIVDOIzDIFY0SQUTcrLUN5yXy7ghUAcakjZeyVu+yHRizx5yNGkPTCKrN2D//nWTtaRPRPp4PgIAbrqs8im42Hkshd7xwP5NoqF5mIs9e9OM3Hoxr6Bq8KN1g/sMH7AtTbVfnW9r4+CPjp8Z42yFXRVW3T9tUfDzaC0P4I4JDfdy1uiUCLMJldBtXKKnJFUddx7K4+V9v7EssKwr0FScYsFfN7u6PardkyeTeCAe6UkhM0s7J9OWt45mODXn2Yu+3H9FEXCmENZy1jiGEHPPpEtr2vATDIViFkfdLftPhNvEVZkZkCSS9uq/LXJZdKGLjfSReXuaScsE8iX2weQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB5946.namprd11.prod.outlook.com (2603:10b6:806:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 14:18:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:18:56 +0000
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
Subject: RE: [PATCH net v2 1/3] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net v2 1/3] net: fealnx: fix teardown order in remove
Thread-Index: AQHdUnfRvKa0pR6FzEGasc/BsufUObbqTOUQ
Date: Fri, 2 Oct 2026 14:18:55 +0000
Message-ID: <IA3PR11MB8986BF6858E33846C0AEE3C6E5892@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
 <20261002140954.261779-2-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261002140954.261779-2-r.zhambakiev@prosoftsystems.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB5946:EE_
x-ms-office365-filtering-correlation-id: 2831c389-3828-4e3b-cafd-08df209017fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|38070700021|56012099006|10067099003|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: 7TlaHJjT74jPhrKBD3oYfzn+sYsOQyit210xd0fsro2Glodc9pQwdrBHGiQsXfMLICUQGxSvP1GQt3cJ9kIFvYMJ1S08Mdwzkki37WOsm5GJ6Zytf8nNzNXwYg1WX5yEYKuSz23xVROtlxhPfO+gR53Dxzf2y9YyOMb1Jgs+IiDJuL832XplV+s5Edo/2jGIGYguSQ2YJvCKeCpqnMceAcHMRHnLNUZm+KG8jRq6QD9oisYXlylxmDBBCWvf+SNOFenFQHd1P1dYl6zlEn776v1dC+/xVX0tOHp+yzumaHiizrpGKDYGkzT3uVhb3ro1RTDdSDXV//vQisoowzO8n4NksoyqNR0W4RemYKTzwFpQMN1KYRVkSkDXkrjNJ/sNznnD4459IqiwWOUA1TaGR9eEOYp4OB7zvn2QqxrilxgB/WsJm5PA1aZ8mIgiWNox4aP+PmkRQLVDDYJAEeERvlQodEMoeWOWDqCA9Ev206wfgeGKz0IE9hK1f4itkGwCz632OnJjeZ7IzM5+b/kNZhS32zSvC0ruTdj5TF6HZR7d8hntWkm+N7vgo+6TgQOrDFrlZMhFkCVvkSbB15RQD3kVf1M2H8iiAIut7UzjrASr1BipNBVJpocAyRwv6dPJ2tOB515CJ1MoYM2wGEfLxHFZbjGjNCnRu0qsVl75YvFYcWCRyz0TxtjBZDQekc0Vj5T0HCjqaqTvQ/UQDKlxMC/Z95cXwBxgsiiIA4nKScM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0RZM0VZWUpBeVBKUmppNVZYTHMzbmxUc3NEWDVTVDFYY3IzZEZLZTBsSFhv?=
 =?utf-8?B?Njd2WTE0TWphdkpPLzczWlFCclFyeGRnNG5SNERvTklIWEgxZGdBMmRSbnR2?=
 =?utf-8?B?MEl0SnQvQkIrQzY4ODVzbkJUaDA2YWtSeUZMVEcwRy9oYnMrMDBIVW5ERDhC?=
 =?utf-8?B?dDdyRGdSK0FHeW40dndheTBOZTVUdm9tWHd1YTcxTGFqdkZRTGZNYVdwekFN?=
 =?utf-8?B?c2VaNG56OFhzSGJQSkl3SndadGpGTjF1VzJWcTdXN1VoSHd0eEdFdVpkUm1n?=
 =?utf-8?B?S2xSTzRKWkVjaXNjc3RtU1NWRVlacnFlUCtudjJXTnF2eDJzeWNSVWxSUWJn?=
 =?utf-8?B?T3BkMTNXTm5CSmNJZ1RWdnNlUHJsOFQxSUxWRm5MZGp0eGJ1Q0xiL0M2M0Jr?=
 =?utf-8?B?am1RRkxUWDVyTnZESG5qakp1N2ZUUlRJMTQ5RXVrLzZFY1BzcnhLK09LWjNV?=
 =?utf-8?B?eTNTb2JudjAwaTNOR201SjFxTEhsNFUxakpVWm9Rb1VlbXlxSmRvT25jUG9j?=
 =?utf-8?B?ZnFFUnNMMldERzU1NzNiZzhzbk54dkRiV0xRcG1YS1hUSHBCeGE3Wlp2eGUx?=
 =?utf-8?B?cWZ2V3hqdTd5QUFMUzRNK1JNWlo1ZGZ4VU1xZE56ei9jUnNna2E1emR3NTNS?=
 =?utf-8?B?OHhLSXJ0MkdwVHAxcXN6YXcvVUcwbFlWNGJXQm1ZYUNWcVZrUEJVdmlRa0Vj?=
 =?utf-8?B?RXpuUndKRWE2cm5FUG1NWmNBNUtpM3AzL1Zvb0hhRUo3SDhkZkR5YUQyeWpZ?=
 =?utf-8?B?ZVN1MkJqNkh3NFE5Y1d1RmRtVTVHMUZkd0FnNG9rZ0hJdDkvWTEyK1g2N2d1?=
 =?utf-8?B?NThaeW5wNXJTVzZpNUxuNU90TlNyV2liL2pVSUZYQ0svZkhaaG9JV3hvcitv?=
 =?utf-8?B?WWVIc1VPbGdmaGNWYm9TczNkZjBMQnY3MmhOWi9sTjRUa2FLWFJsc3F6c0lj?=
 =?utf-8?B?S01aL1g3L0xKc3ZhcEp3RVpzNFdqVGx1TUkwOGhUSkFpKzliU2dhRUhRaldW?=
 =?utf-8?B?Sjh0V0QyTC8xakgyNXJQd3RkY3BPVzF1c3dSS2c3U0NlRXZTOCsvWXEyajFm?=
 =?utf-8?B?SUN6VkJsa0drcFNlekg5OEFvb1NUdkExMlVFS3NVaGUzc2E5OFhPM3p3SWwx?=
 =?utf-8?B?b1BxbG1NR3dXMHpsNVRqWTFlbDlIUXE3d294SXdWaVg1eWQ5QnNCOWh6WWFI?=
 =?utf-8?B?SWRXR29tbXhwWWFGRE5QYVh0M0JLU2pWNnRKU2lJc2hUTEUzUEFyZUwrRi9G?=
 =?utf-8?B?WW5MVHcxVTd1SWUveFdiUnBpblE3UzlwR093V29tdWVibmIxUmV3SmR6bGM0?=
 =?utf-8?B?aUNweDNlQms3Z3JKWkNaZjVmUm4vR2duOUgzL0pBaDUvdFd4MkJHa3NFbEtn?=
 =?utf-8?B?OEFScGJpNFBVanpPYkZkYmQyaDVnTzZVaHhDQURWK2FFQkRpOWlkT3Yrc2tC?=
 =?utf-8?B?TnplQjUyQ1k1WnhHaFNYWGQvUERKODloYnFqRkluTVpyVDFLOTIwSmR4dG9i?=
 =?utf-8?B?MmQyWTQrMFVmcWhNeHhiVEhlTkE3QmxTK3VNZFB1NUJuQmc2MUdvMTlVaGFD?=
 =?utf-8?B?TG0wM2tUM1JVMEFiNUN6bFl5aWV3ZWlOVVlRTFpUNG4vSy85cmRGN3hod1dW?=
 =?utf-8?B?bjRydk56c2YvUHRUT1VYNHRxdWwxRmZNd2VjQlVMbmk4cEZ4b05SN1RMOUFq?=
 =?utf-8?B?dG8xeS93NUhVU2xscEMybWIwdmdKQTRxMW95OXhucDB2RkVEL0hYWFJGUjlx?=
 =?utf-8?B?UG5wNktGU0tLTHp6WE9CTzhhbWxEZ3ZDbzNFelV6NVdZRmd2YUk0V0RGTHlB?=
 =?utf-8?B?bEZtS1NOQXVlUVpmYzJ3Mmt5cUZiaVBxZlZJN3VNT0V6Wmt0Uy9pd2xka3Zv?=
 =?utf-8?B?WG9lNUZGMzM0Y3h0WEZtU21UWmhVU2hlZndUdjNvMDNZWHplVHBHcW9raXcw?=
 =?utf-8?B?NG9rdDk5YWdCRTZia2FmbU16amRkUHFGeWhoZkZyK3FiUHNmalE3SFR3c1Rh?=
 =?utf-8?B?Y0JRcmdoRzBaN1ExWHZzalZsOExlSXJ3QjdCSXVwRWErYWlkdVJ5MG83eGxC?=
 =?utf-8?B?YmFvenBVSlFtSXdKejlTc1JldHJJUHJ0TTVZU2JsalZYYnZpaklWVzVyL0Za?=
 =?utf-8?B?c1dKdXNsY29oZmE1V0dZSVdOdFhZWXZjUElIdHNDcXMvdXNwZnlEMHl3dTcw?=
 =?utf-8?B?VWJHWnptYXd1OXpCY09odVNiTzA3RkNTMDhBNFFJVmMrUkZWU21MY1NNNGxa?=
 =?utf-8?B?VEJsUlVvMkhRRmhXd1hiTUJ5bHhxOFQ3aFFnK2Foek9WNW5rQVA2eUJwVVMw?=
 =?utf-8?B?UlZIZVZTU3NZOUx5Z1lJUnozbEVNTmpXZU5sNkxpOHhXNWIxQW1lQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kSNgEdKU2USE+LQAyBHM3hGb02C4HiK/jotYb5oz5FRr9ZgApym5gaMlnAPPASQU+4MzgM8OFaTNbYhsdeOQVy3YYNsCwx4Y42zc3fULici+GGcT6CYdA3+x8DFEuYyFjXH5tjqQlCQeDcZrndm+CRCUG7Dn86fRdhGB4cLwSKu7ajY7CINk9Mq8qVwnJILAnPbWA3NUMilN/BJUX042H6RGUn7gWvgFiRuUmXhy7WthM963SPaCt5kfw/4MgaVWF1mA7DCFUR2d3JO3E+nd+tKf44dvmz2eT76l0/7pxlRoXQpQ82R2DlH0sj6aCECumdsYuNxoOGa/rbIfuwIqUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2831c389-3828-4e3b-cafd-08df209017fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 14:18:55.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQyfY8omI5j9wsq2kLW7ep5vrwmF7wtbYY1MJ7nJ5Yqw7ssNxMvJyJ6o1THcmCu+RCMd1TpVAml4b2l/ZjHQpH8fXo5Mcx+VxJJzPzbAKxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5946
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog0JbQsNC80LHQsNC60LjQ
tdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00LjQvdC+0LLQuNGHIDxyLnpoYW1iYWtpZXZAcHJv
c29mdHN5c3RlbXMucnU+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyLCAyMDI2IDQ6MTAgUE0N
Cj4gVG86IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+DQo+IENjOiDQltCw0LzQ
sdCw0LrQuNC10LIg0KDQsNC00LjQuSDQoNC40LrQsNGA0LTQuNC90L7QstC40YcgPHIuemhhbWJh
a2lldkBwcm9zb2Z0c3lzdGVtcy5ydT47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5j
b20+OyBNaWNoYWVsIEdyemVzY2hpayA8bWdyQGtlcm5lbC5vcmc+OyBKaWppZSBTaGFvDQo+IDxz
aGFvamlqaWVAaHVhd2VpLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIu
bG9rdGlvbm92QGludGVsLmNvbT47IERlbmlzIEJlbmF0bw0KPiA8YmVuYXRvLmRlbmlzOTZAZ21h
aWwuY29tPjsgVXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1YikNCj4gPHUua2xlaW5l
LWtvZW5pZ0BiYXlsaWJyZS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbHZjLXByb2plY3RAbGludXh0ZXN0aW5nLm9yZzsNCj4g
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IHYyIDEvM10gbmV0
OiBmZWFsbng6IGZpeCB0ZWFyZG93biBvcmRlciBpbiByZW1vdmUNCj4gDQo+IEZyb206IFJhZGl5
IFpoYW1iYWtpZXYgPHIuemhhbWJha2lldkBwcm9zb2Z0c3lzdGVtcy5ydT4NCj4gDQo+IGZlYWxu
eF9yZW1vdmVfb25lKCkgZnJlZXMgdGhlIERNQSByaW5ncyBiZWZvcmUgdW5yZWdpc3RlcmluZyB0
aGUNCj4gbmV0ZGV2LCB3aGlsZSB0aGUgaW50ZXJmYWNlIG1heSBzdGlsbCBiZSB1cCwgd2hpY2gg
bGVhdmVzIGEgd2luZG93DQo+IHdoZXJlIGZyZWVkIG1lbW9yeSBjYW4gYmUgYWNjZXNzZWQuDQo+
IA0KPiBDYWxsIHVucmVnaXN0ZXJfbmV0ZGV2KCkgZmlyc3Qgc28gZGV2X2Nsb3NlKCkgc3RvcHMg
dGhlIFR4L1J4IGVuZ2luZXMsDQo+IGRlbGV0ZXMgdGhlIHRpbWVycywgYW5kIGZyZWVzIHRoZSBJ
UlEgYmVmb3JlIHRoZSByaW5ncyBhcmUgZnJlZWQuDQo+IA0KPiBGb3VuZCBieSBMaW51eCBWZXJp
ZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKQ0KPiANCj4gRml4ZXM6IDFkYTE3N2U0
YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiBTaWduZWQtb2ZmLWJ5OiBSYWRpeSBaaGFtYmFraWV2IDxyLnpoYW1iYWtpZXZAcHJvc29mdHN5
c3RlbXMucnU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZlYWxueC5jIGluZGV4IGJkYzM4YWFjNTg1MC4uNjgxOTRjOWVmMzMyDQo+
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KPiBAQCAtNjgyLDExICs2ODIsMTEgQEAgc3Rh
dGljIHZvaWQgZmVhbG54X3JlbW92ZV9vbmUoc3RydWN0IHBjaV9kZXYNCj4gKnBkZXYpDQo+ICAJ
aWYgKGRldikgew0KPiAgCQlzdHJ1Y3QgbmV0ZGV2X3ByaXZhdGUgKm5wID0gbmV0ZGV2X3ByaXYo
ZGV2KTsNCj4gDQo+ICsJCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQo+ICAJCWRtYV9mcmVlX2Nv
aGVyZW50KCZwZGV2LT5kZXYsIFRYX1RPVEFMX1NJWkUsIG5wLQ0KPiA+dHhfcmluZywNCj4gIAkJ
CQkgIG5wLT50eF9yaW5nX2RtYSk7DQo+ICAJCWRtYV9mcmVlX2NvaGVyZW50KCZwZGV2LT5kZXYs
IFJYX1RPVEFMX1NJWkUsIG5wLQ0KPiA+cnhfcmluZywNCj4gIAkJCQkgIG5wLT5yeF9yaW5nX2Rt
YSk7DQo+IC0JCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQo+ICAJCXBjaV9pb3VubWFwKHBkZXYs
IG5wLT5tZW0pOw0KPiAgCQlmcmVlX25ldGRldihkZXYpOw0KPiAgCQlwY2lfcmVsZWFzZV9yZWdp
b25zKHBkZXYpOw0KPiAtLQ0KPiAyLjUzLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0
aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQo=
