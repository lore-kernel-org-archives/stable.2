Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9D381AEC;
	Fri,  5 Jun 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684111; cv=fail; b=K+oWnExJKnToOIFgUJnQc/2Vc5vf5TSDxiXgN7VVg5+jcIPGw0dKlp20+UeeGKmdCyiLLrXrxVuQKcOmVY4D/dbyh5Fl5q5R86/9CnhncZCicSQ5H8UpecWK5EEwy32ZK2K+jfrG/b+Se9Po02zMGLzoSwwlql8fUr83myIY10U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684111; c=relaxed/simple;
	bh=sLXs+XlyAXtfZz5nVwcDTI7iLlFcyHCz7PfSMRtP3AY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XAqb8yxivbhotIGJ2YdVvdTkgo4V6GWE1+dgTRddJV6DPElv21nOae4rU85j0fzGcFVcInZSIzJPnRT3b30Wspva7zX7jammTztYeaLFMh/xELGjetjIK/iiuDNWo7HNNVCZ6XpD+QocMpcH3rQ+zCYPnuuSQaY1VBiMdxKeFC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGPriVIl; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGPriVIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780684110; x=1812220110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sLXs+XlyAXtfZz5nVwcDTI7iLlFcyHCz7PfSMRtP3AY=;
  b=aGPriVIl3fe/2IWsqssVe6CpjFu24ZElXccVWzgmcEKeCXWE59xeH6Ob
   Badcg1Opm9PrJLfB5tXl5AzxHU7DyH87UPTeDiG0BdpFHsfbrBXv0IaW5
   ZvRr1vX98CPPugRn2yx0xs6tahliWEk4AKjW9pmrytM8CpYCMUqtS2/fC
   376+Y1RoRH3DHPR28DbuyvUjMEm2VrJemJRxZqUTcBbsWE2lmxoYtGFDr
   U7L2jZuaN7o6axJH6I/GnRsjlGgQ5fXSurVuIm/rpxNjKaQD/GGGBadAC
   hF4UpNQCMH+0CLeo/oYv5SFCc21nb3xxNQYptmGPImSBTQNn/gzjK3oPJ
   A==;
X-CSE-ConnectionGUID: aUYNQMlVQAKY/JZYwyhTaA==
X-CSE-MsgGUID: fm4Se28zTd+joqWv6vXXTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81431869"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81431869"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:28:30 -0700
X-CSE-ConnectionGUID: pkGT9xFATm2TZwRZQ0CBpA==
X-CSE-MsgGUID: SqCVYdwaRUOiL3HqZB1OQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="246746651"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:28:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:28:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 11:28:28 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGexX9VoqDxXViPwqiSFE2Bc4s2WJxdzt6ZSGTOB46crB8Ve4dHdOIS318LDWehfLaKAFMZpbQiTIYnPeah1S9Cd3/bqFEhPApbR2oC4ssStMwyVV/QVHGK/vHextfKeTdpG7w3FgZ6Rp4o6Se5alOpZFrkKkTljpu7hQkjP8Ylfr2U4OLxKAPimHkcBxoQMvf1uZckKu3Gl0sl7b45ES0UFrRr0ZS0hOvRC+t4N22uDgh+wcWczI6sEkjH+Yvsnd6e27bZfrrBa83IRDx6uT9HyMbO1Fm8rrXpCFBPpzdhvGmMzZb/Ce1LrXCGz6tRAp6Sxsobo/SrQI3p0+/azfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLXs+XlyAXtfZz5nVwcDTI7iLlFcyHCz7PfSMRtP3AY=;
 b=xDJoRW0DHR61nCqcwF6K4KTIX9gv1UcWJQMqHmQumkGnd2YROxMOd5qvia+2EY8YAUimb6gUgCdb7zMBxgdX3pI6dYn5CRNQLPYnYfUTFW1j7OGmrbbH0hq9xDlgXUeIy0fET/AubKhjvs8IjAEjEyrBjDEXXy3F+PMmNFLf86VQT4kC3v+3vosvtC6Ss/fCCXrp+cHi+11pvoQvl28GGnwVtWICakD25YGp7SrAMXXfhdyDkPkJ0Kug+IAKHoi31X2fSIAF+3kjkMpY1gG6KUBEjXyscfe9GowipF7nljlw4U1mRPTiHDdQXyn7MxaGMvE0aTqLu3RbLziu/LHjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:28:23 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 18:28:23 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
	<irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Chen, Zide"
	<zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH 4/8] perf/x86/intel: Fix redundant branch type check in
 intel_pmu_lbr_filter()
Thread-Topic: [PATCH 4/8] perf/x86/intel: Fix redundant branch type check in
 intel_pmu_lbr_filter()
Thread-Index: AQHc9IkNbZoUDKhlgkSlAjqEWia8kbYwSRqA
Date: Fri, 5 Jun 2026 18:28:22 +0000
Message-ID: <5f1cedec93b2ea87cb89f259b0eaeddba69093bf.camel@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
	 <20260605011136.2043393-5-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605011136.2043393-5-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA1PR11MB8428:EE_
x-ms-office365-filtering-correlation-id: c5d1941e-5de7-4702-a78f-08dec33039db
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: b+L+ONCcTq9oAwkOxJ6FG/eWU311y+JqVajq1lQ0A8QOE9oYom2s5tyfwq91zca+m7W3XhfwmuXVKF1k89Q3WSVQwXmo4bx3ZhrhxSHu+REQU6jhXKpWdV2AwOw52k3xQxc9jC/K5eZoA3EK/nO16gZLu+bhL7jj1hyWDtaD1eLLCi7teQ8tGFs/MXe5bojXuULsgWbn+0bt9zUbahVfujIhooDWEFrStInjIo4YlfhfCPt4+SZM8Ho47rWsb7wev0MnMW8FgyuvNIOS6O+JZ6C6HUeAosTzO2nZlz4uEPLLgHOaiFV4M9mK/oOhEO9/EENY+6BfvVHQeHkeWKCHPD0TfRrC/gZvytL7GpTbklC+9cE/XC281c83pFVXuIsq9xSpsyLBx4MHeepq7o5Br9AVuULzk2YJJC0PGkHkx1aaEoLzDhA4F7V/ZreytOv0p85HvVXNYG6CWcdZQceGGqAx3iNyqgtgtlPpBgUfEbtXGF/Ov8RIch112YQZ88LaG2+sv9kwN9rb3yaDQdD43HQqPzZNcCF/vC8cROBg5k5VewLG2oOO3uMG08Am5077yZxidgmZGxuujVvJ0NfnCVyWBBT8V9GiutjAA7HzKpODEwL96ViJhWXgLjrelL0p4WXgwn4wrG2kWkSyH+yNpd19J1hDpe9hT6oY45c3fCDs+d2T2NmQdt0eJeidZn0TFSsdjtPVXyDpk4GoIu4ooS69a2PyE7Qg4LisUDDtZ2VX8/Be3QKza1EEAKmwS9CRm4F24LhgGOZlCj31mL82bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUpXMUtvS3pUZUVHZi9tTUt5dGx6citFTXJpR3V4dmU1UFNyZWhJWkhHZHFW?=
 =?utf-8?B?aU41WEhyMzJYeXNsTk1jYWJSOFRUenpUcDFwSnhIQmExcmh4Z28rTWlhREFk?=
 =?utf-8?B?cmtXZjVPZ1p4OTFJeFZKVU1xaVFSc0FJSTVKYjREN2kxaVZCT3hjWnRLVzF6?=
 =?utf-8?B?dGhWYTFmVVUvNGVXaG5VSEVLUmhZSGxvZXY0OEg3a3VOMjVlWE9MbGNxMHdZ?=
 =?utf-8?B?UjVRVzR0WFhBcEc2V016UHg3dDJGZlIwbWRhTFd0MHNuU0pJV0puSkNudFlC?=
 =?utf-8?B?NFZXZ3NRMW9GWWtwemR5b29sVVZ0NUttRGU1TldoQWM4NkZMQyt1Q21oNDZR?=
 =?utf-8?B?d3lPb2tWUWJDZ2c0bkwvSkJTVmZLbUFIYTkxTFlCZE5ZZTZkODh1THBZU1ZX?=
 =?utf-8?B?WUVkMS9xYVNTWC80aFhIb1F2MlAvY1FzUmFsL0dLWG5UZGFjNkk4aG1pZURl?=
 =?utf-8?B?cDNTMmdicTJYaWV4SnJPYXVjZWxLQVA4SFg4aDBKVzFLRjhKT3pMc3BvVDc3?=
 =?utf-8?B?amswMUx2UW5ITG90Tkd4bzdmNzdUdWFic2xhZDJrVWllNHNON1FFSU5vcGw0?=
 =?utf-8?B?S1VzdFlLaEFNZXlwZEYyVVB3TWtDVWgrSUtVVm8xeHZEQTl4YkxIQ282UDNI?=
 =?utf-8?B?OGhMcDJPRHZoRkN5NWlBakFtNTNvTTcrM2JLZjYyR3hlbmk1ZmM2MzZRK09n?=
 =?utf-8?B?dU5Uc0J6L0ZIMU1IczdEUkVVTzRsOEd5TmM3amsvTnpkdnBhQXVMd3NnMnFm?=
 =?utf-8?B?Q2J3c0R2YjhyL2poa29VbzIxaWFhNnZQVU52dGg4cmR1QklrZXVxNkhsd1Ni?=
 =?utf-8?B?R0ZLRVVqNlI1citOWmlISnk3RjdBZ016RGtSSTV4M1k0NE5Mb0dJQmF4c1Zm?=
 =?utf-8?B?ZzhsQmZYeUVpblJvcVpEUFFxMytuazhwb3JKQlRtZFg3dTREZWdaRVBTMkxh?=
 =?utf-8?B?Nkl2ckxzRWdVMUZ4NTJXYmpsUWhJdmh4djg0Njdqa01mUTg4YXhnTlF0MFF3?=
 =?utf-8?B?N2wvMktkM2Fwd0VaaWZPYnRuWWtVdnhUenBHZHJrTEpKSFI4MnJuVHlzZ05L?=
 =?utf-8?B?Q1JYY2I2YjlsMGEwb1NtSUo2S1BiN2VOdkwxSE9KWENXTTRIV1FYdThEQjJN?=
 =?utf-8?B?NDYvcW9wbHV2d0VmbkkwcHRJWU93SFJpd2tPbzFzejllY1B5cW5sSExxSEFS?=
 =?utf-8?B?RVh5VTJXUDd1ZUJpaXEwVEhXNSs3dXhSV2ZIQTBiQnRJVVR3THhQZ3NsTWRS?=
 =?utf-8?B?UFJ4Q0xueVRxZGg4dUtVenVsbzJRblhUaVFRR2M2OHlGT0R6UDJXOWxveWVo?=
 =?utf-8?B?ZCtzREdLQVlTc0g0N3pJYU14T2RSUUNJWVpnVUcwU1RxbWJmSGVyaXNnOUcy?=
 =?utf-8?B?QmRrZVVrQWFFNnc2SmFwNFhzUlY4bmN3WTFwb0ZCdVVWRjVvalYrbll3UXUr?=
 =?utf-8?B?bk4rQ0dSNFBZUmdWLzlrK1Y0WU9lVmhkQnhBcUZVREdrUWtza0YvdHZMcW5L?=
 =?utf-8?B?MmxsVENVTytjako4Nm1LcndpWGxwV0tlaTdJS1VTY1p6ak9wakVld0lvcWp5?=
 =?utf-8?B?RXRKTFZGYWpxS0NkcDVaeHRHak5NTGc4SDNpREdpNjJWcnAwaUx2ck5xWXVz?=
 =?utf-8?B?VjB2dlVEdm12Z0RvbzJranJ6WlFHRlMxdkQ2SlZYUDhnSmF1eTQ0bzFWNGdx?=
 =?utf-8?B?SHpDZWxCbkFJR2JSN204UmdMbXRGTlczanZPUEVUNk80aFR4MFBKSDJoZUds?=
 =?utf-8?B?UWhWcktVUzdQTnJqM0ZLVHJDV0g0eEw0OURuVVhTYTRQMU5jcU9TZWRSTUxv?=
 =?utf-8?B?QzlFM3JxaTlpN21yQW5QczdqdnRhdEVpbjhUcldVQjFVbzRTcjk0ZzJSaHJQ?=
 =?utf-8?B?UnpaRERjUEp0M3J0d0d5RGhRZlFGR1QwR2VuK3I1RkdCZ1NONGtZL2VGS3R4?=
 =?utf-8?B?NDduWHYvZGlIV1JvdCtZZEpYeHR4QS93QlFVYlgvWElqYm1VbEFUYUU2aDZ6?=
 =?utf-8?B?N3k3QUpBcmtQVThWb3NUTzAwVWFnWS9FTUlrNVdQS1RBOXVrZG45RzVxNkJ1?=
 =?utf-8?B?VHF1WEVrV1lKSzRHTTBEbzVMS3hHZlNiT1BUT2dyTVlwZnpBczh3S0laMlk0?=
 =?utf-8?B?YnFBd1NRMlJNQWNBdUQzTVRBR3NWUXpLYVVqSVJ3T0hkMmoxZjhYUThYVDFi?=
 =?utf-8?B?SytoVitoVi8wK1VyQkVDcDF5bHZuL1VnejlPd29jbWN0Smt2YjVHQ3c3VlNp?=
 =?utf-8?B?YkNhaVdVejllZzdjOXJSWWtJMzgzMUpXbTc4bDlzZVpMbnFrOXA2d3UxV2Q1?=
 =?utf-8?B?VWxWVmNKd1hEN2Z0OGFlcFRqRDdIRVZ0TDFMV1gyaHo0M2xvb3U2TGN3Wk1i?=
 =?utf-8?Q?cyqV8hxuS5LSM/uIEMxEwVashkulaVwh9Itw7MO7LLiYK?=
x-ms-exchange-antispam-messagedata-1: v258YR2k8fS8ijvOtryp4m4hoMlf+ghSg1o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DB134A2E6E1E44B82A4103728FD5922@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dZe1uRId3+uOdj10VYM6r2LhCd/Buu4Q4sVxnd/SFJ+eg6/wydKT/qHtQmnWeVwBWsh+iFSTWiZw2RB23xYBQCLItHUtODRX1vIgmIDtAARul7ga6crxxDcKPvSLsx/5lMn+ov343DnzGGpqoMpKltScpmeOp4MINOnVEYoUOfeYcbjd9ALq02CPIWMPQjutJ84pq2ApWGLOdI0z3e+UAMHB3Y6RocB6I1C31CNesqr7ltDBB7dgRzt7okNgT2Bqy/Kk4/kjmrVJmaPAFiU5XicBZ5iAMecJNiCB0OfU0Ujfva1/lGOt7hHQ5M0UL5WmGcTezs3p7LVlpuUlMhFbpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d1941e-5de7-4702-a78f-08dec33039db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:28:22.9487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNvMBKZZL+h2P6Nw+Oq79bmqbdfOTRzhjzXjQPWVD8Z1f1xIWCJKfMIUJnJgYbi1y6S1eZBZZGb3EBI+Eea/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDA5OjExICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IElu
IGludGVsX3BtdV9sYnJfZmlsdGVyKCksIHRoZSAndHlwZScgdmFyaWFibGUgaXMgYml0d2lzZSBP
UmVkIHdpdGgNCj4gJ3RvX3BsbScgKHdoaWNoIGNvbnRhaW5zIFg4Nl9CUl9VU0VSIGFuZC9vciBY
ODZfQlJfS0VSTkVMIGJpdHMpLiBCZWNhdXNlDQo+IG9mIHRoaXMsICd0eXBlJyBjYW4gbmV2ZXIg
ZXF1YWwgWDg2X0JSX05PTkUgKDApIGFmdGVyIHRoZSBhc3NpZ25tZW50Lg0KPiANCj4gQXMgYSBy
ZXN1bHQsIHRoZSBzdWJzZXF1ZW50IGNoZWNrICdpZiAodHlwZSA9PSBYODZfQlJfTk9ORSknIGlz
IGRlYWQgY29kZQ0KPiBhbmQgdGhlIGVudHJpZXMgd2l0aCBYODZfQlJfTk9ORSB0eXBlIHdvdWxk
IG5vdCBiZSBza2lwcGVkIGV2ZW50dWFsbHkuDQo+IA0KPiBDb3JyZWN0IHRoaXMgYnkgbWFza2lu
ZyBvdXQgdGhlIFg4Nl9CUl9LRVJORUwgYW5kIFg4Nl9CUl9VU0VSIGJpdHMNCj4gYmVmb3JlIHBl
cmZvcm1pbmcgdGhlIFg4Nl9CUl9OT05FIGNvbXBhcmlzb24uDQo+IA0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBGaXhlczogNDcxMjVkYjI3ZTQ3ICgicGVyZi94ODYvaW50ZWwvbGJy
OiBTdXBwb3J0IEFyY2hpdGVjdHVyYWwgTEJSIikNCj4gU2lnbmVkLW9mZi1ieTogRGFwZW5nIE1p
IDxkYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+IA0KPiBPcmlnaW5hbCBwYXRj
aCBsaW5rOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MTQwMjE0NDAuOTI4
MDY4LTEtZGFwZW5nMS5taUBsaW51eC5pbnRlbC5jb20vDQo+IA0KPiDCoGFyY2gveDg2L2V2ZW50
cy9pbnRlbC9sYnIuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwv
bGJyLmMgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvbGJyLmMNCj4gaW5kZXggNzJmMmFkY2RhN2M2
Li4xNjk3N2U0YzZmOGEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9sYnIu
Yw0KPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvbGJyLmMNCj4gQEAgLTEyNDUsNyArMTI0
NSw3IEBAIGludGVsX3BtdV9sYnJfZmlsdGVyKHN0cnVjdCBjcHVfaHdfZXZlbnRzICpjcHVjKQ0K
PiDCoAkJfQ0KPiDCoA0KPiDCoAkJLyogaWYgdHlwZSBkb2VzIG5vdCBjb3JyZXNwb25kLCB0aGVu
IGRpc2NhcmQgKi8NCj4gLQkJaWYgKHR5cGUgPT0gWDg2X0JSX05PTkUgfHwgKGJyX3NlbCAmIHR5
cGUpICE9IHR5cGUpIHsNCj4gKwkJaWYgKCh0eXBlICYgflg4Nl9CUl9QTE0pID09IFg4Nl9CUl9O
T05FIHx8IChicl9zZWwgJiB0eXBlKSAhPSB0eXBlKSB7DQoNCkxvb2tpbmcgYXQgaW50ZWxfcG11
X2xicl9maWx0ZXIuLi4NCg0KCWlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9BUkNIX0xC
UikgJiYNCgkgICAgdHlwZSA8PSBBUkNIX0xCUl9CUl9UWVBFX0tOT1dOX01BWCkgew0KCQl0b19w
bG0gPSBrZXJuZWxfaXAodG8pID8gWDg2X0JSX0tFUk5FTCA6IFg4Nl9CUl9VU0VSOw0KCQl0eXBl
ID0gYXJjaF9sYnJfYnJfdHlwZV9tYXBbdHlwZV0gfCB0b19wbG07DQoJfSBlbHNlDQoJCXR5cGUg
PSBicmFuY2hfdHlwZShmcm9tLCB0bywgY3B1Yy0+bGJyX2VudHJpZXNbaV0uYWJvcnQpOw0KDQpJ
biB0aGUgZWxzZSBjYXNlLCBpdCBkb2VzIGxvb2sgKGJyYW5jaF90eXBlIC0+IGdldF9icmFuY2hf
dHlwZSkgY2FuIHJldHVybiBYODZfQlJfTk9ORSB3aXRob3V0IE9SJ2luZyBpdCB3aXRoIFg4Nl9C
Ul9LRVJORUwgb3IgWDg2X0JSX1VTRVIsIHNvIHRoZSBjb25kaXRpb24gY2hlY2tpbmcgdGhlIHR5
cGUgZm9yIFg4Nl9CUl9OT05FIGlzIG5vdCBleGFjdGx5ICJkZWFkIGNvZGUuIg0KDQpPbmUgZXhh
bXBsZToNCg0Kc3RhdGljIGludCBnZXRfYnJhbmNoX3R5cGUodW5zaWduZWQgbG9uZyBmcm9tLCB1
bnNpZ25lZCBsb25nIHRvLCBpbnQgYWJvcnQsDQoJCQkgICBib29sIGZ1c2VkLCBpbnQgKm9mZnNl
dCkNCnsNCi4uLg0KCSAqIG1heWJlIHplcm8gaWYgbGJyIGRpZCBub3QgZmlsbCB1cCBhZnRlciBh
IHJlc2V0IGJ5IHRoZSB0aW1lDQoJICogd2UgZ2V0IGEgUE1VIGludGVycnVwdA0KCSAqLw0KCWlm
IChmcm9tID09IDAgfHwgdG8gPT0gMCkNCgkJcmV0dXJuIFg4Nl9CUl9OT05FOw0KLi4uDQoNClRo
b3VnaCBpbiB0aG9zZSBjYXNlcywgaXQgZG9lc24ndCBzZWVtIGxpa2UgdGhpcyBjaGFuZ2Ugd291
bGQgbWFrZSBhIGRpZmZlcmVuY2UuIEkgZ3Vlc3MgaXQgaXNuJ3QgY2xlYXIgdG8gbWUgd2hhdCBp
c3N1ZSB0aGlzIGNoYW5nZSBpcyBmaXhpbmcuDQoNClRoYW5rcywNClRvbQ0KDQo+IMKgCQkJY3B1
Yy0+bGJyX2VudHJpZXNbaV0uZnJvbSA9IDA7DQo+IMKgCQkJY29tcHJlc3MgPSB0cnVlOw0KPiDC
oAkJfQ0KDQo=
