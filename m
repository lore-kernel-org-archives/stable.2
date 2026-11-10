Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332332;
	b=tf9YnWq0Neg5Pufz9aVy8kvSbQ1iBVzYzp6kE8F286y3Uq2HBF4JiIaXTC+Vdk1/dY/k
	 ebqXGOYwIEAqKiG1jjzO4kS0QvCHtc9X0EjhxH6TAk+tFA0D5fdg9CarIKIgkUUqTIpJT
	 aM97hSy45vq5hVmfVoZMdfgtLs00+hIJ+Nyc3W3ZKw1roASPJgPoTBIMjNExvOVuOrefM
	 Ww/how5Q2i1/KjVjO6ZE4rVsAS98kvi13o6tC6TrRc8IF7ZiRuMHmufyQOU1MhHt9XMya
	 ETWwoHqiGeIQFMCZ9GeUmfyymLnI72W7dpU4W3ZtDwe8y8wOiN+UvvmEdxxAxQj+OPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332332;
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
	bh=YtxP/Fb9Ya4YhCUWombq8TWuqy7WdKLxksdu4dUBEjM=;
	b=cCSzq7YNlMaS02O2a/Y/wFKlT52Y+Iw0xNFWn7ptEwtVgr6Q+XkRF90hYxMAxzrAPs8K
	 pCP/ZN8Tu4QpPzoXkVSyairQf3JJBRGGMz6efeldyDByhtKNbGeZhnqpnF4W9pDkKKiSh
	 ykpPq/aHmdK2VyKzJxlIB23K+uLXHBicFO7j45QBjKAzWWOybMgJbsyq8lvcRKUpN3OU5
	 yKJpYOhtb+Y9YwQ5anNsc8B16+n7K+D9hD5Q1ft9LLubD2z8e+hrMfr/PrXNOpSWe1Fmc
	 3UqrQvUfhGoM3Ec4o9Qrg+GfXLk/W2B+UT6n048v+I1KmGOG40YY4tpnivn5TL+4N6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W3QXwh9n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C27606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C27606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W3QXwh9n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794332331; x=1825868331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YtxP/Fb9Ya4YhCUWombq8TWuqy7WdKLxksdu4dUBEjM=;
  b=W3QXwh9nc8+4BnbEfAIxz+GsBA56ZBZk94n0RjRPX2OTh60J3jCCSMuB
   DJuzzrGK+yNBFDmiGV5dUUTP9H5D1Pjfj0YhwJMHnaP9U3zmJ1Z20fW6z
   EOcDos/WtNII90VW5WzuFQPX2Oa9bX5wQ5KBAlctRUMC6o2+b5TFRPOh+
   83FkdtPfXkRM5CE7Lw0KB35Vd2qZM0XTjzIecbRsDPBJObkq8cN5BEwod
   MbSQEqUc57dEdjqXk0G2nXxT4WfZVRxD1YNgbZrZQyuLomONdIAw/QFIj
   fOmYttKKu4zNDsOlFfpmbGYb6W0VEXzXSkQViSzhhHAruEeNUvDtg2vBV
   w==;
X-CSE-ConnectionGUID: W7dKaUcTQL+N5rSHnIDe3g==
X-CSE-MsgGUID: XyJ6GoONQUWX9mT/kOTMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3172076"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3172076"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:38:51 -0800
X-CSE-ConnectionGUID: Gjt7VAbpR8u0Z51aP1mjTA==
X-CSE-MsgGUID: 1VWwQupwQluyMOZnuAmVKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8081255"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:38:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:38:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 09:38:50 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xu9yvpftG9WoaEpzbFCEpY9IUNue3yGA0zQpSWiwjfh64xnFj597CFnQzDT9wIiuaqCvtuvbfdL/5TQV+TPnXXi/vQL7FFfQh86pYAy3UDM99Twi/R5BRK4RwVl+Zwididra0pf280XPUrYkJ9X2acddhlm3du2lAEb6+UmaiA8JdPMu9vIUinzUq3xfMkXXWK39Q0aJnQk39SJJ93uY3QQ6wQjJwI4jHcwSrnCFI6CWstUfhjU/7FEeR7uDjhdmJxVGgCbKtZmueomKskjuWcHbFrfeb60CvjIpxRUlEj0YM4NB/tFruZ6hj+4y1+bJBnoByg922tV8emPMoP0ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtxP/Fb9Ya4YhCUWombq8TWuqy7WdKLxksdu4dUBEjM=;
 b=fKx9nNs8V3ZxOfcZ+BZwtKfRDUOzsc1MaCD2GKiqIqwkVgf7lbOWW7MS1Vj9d5QO2GgpX1f9S+PGOInuO/YU0goy+WC3/5WOx9nA9yPX3dOybHwmntvJYav+Ix4helICy4FKRSHQRN5BJBPx+A+6CQcC6kQ1FAKqjtMNqXu+LAfjLsmUy3zQ5jobrV5LhFhmoEBLktIthunvUoSUM3qsvdYBM0lDZBq+6RtjvtiyfwF/gE6TZS0gtVCIgO7NcCMEDXYi5APVKgnHKqicHw4UlbDDHq1kGZ3rm+UC1tISMii9CVneuyJykLNwjKSshKfLhfvpyrSGlFI/m8DyvAf8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB619106.namprd11.prod.outlook.com (2603:10b6:8:43e::11)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:38:47 +0000
Received: from DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee]) by DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee%7]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:38:47 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Sasha Levin <sashal@kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/guc_ads: allocate UM queues in VRAM
 on dGFX" failed to apply to 7.3-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/guc_ads: allocate UM queues in
 VRAM on dGFX" failed to apply to 7.3-stable tree
Thread-Index: AQHdbp8mEXB40akIzE2wBFzBBx4mmrcnlo0Q
Date: Tue, 10 Nov 2026 17:38:46 +0000
Message-ID: <DS3PR11MB619106EFD555BAB1CF9D669B85F4722@DS3PR11MB619106.namprd11.prod.outlook.com>
References: <20261107050240-failed-7.3-ace076ef0a85@kernel.org>
In-Reply-To: <20261107050240-failed-7.3-ace076ef0a85@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB619106:EE_|CY8PR11MB7136:EE_
x-ms-office365-filtering-correlation-id: 40267e4b-6f1d-4ac2-440a-08df3f517952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|42112799006|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: J0Qdgn0Zm8CPNwey9zkIhcX5tc/t1u/82LVOUhynAfZt5DNJtWhuhn7aNro25oWG1pi7yTMnDoSAWxhlTQutjOIqHcsD2m9deFnFEFKhWniuRbJWGAOUairp+w6nlQih07IWLaRS7vPhus+O9xZNew3/eS+cAD7874kxiGNAxC/H2BPdLNflKiIbXwAYlgXedMiJ2/LVCCUjtpdCeQxUDgr0EXIMq8HPPA+q+yUA2JLzOc5Kunkt7s/8rV990D9vq2T3hnWMxnAg+QjuvHzqndiJE+U+MNF9tTmzNIIji2PUvpbTe8dfy0ju7Fk/DszU24l5Bl4L3D+zdPYwslt9+DPDIpqHZZP/RygC/6gfbmb5VCNwBcCEeP9vrbfRXy65RyH0LRLjtp0yxqeqSCLrECSRXbgGbO4IXP25flQRYTz3JFgHKaHhKhYifyAzea22w17k3ilG91ffBvc9vpqRQO76+cin3jYcQKPqisurWeyRENPhpHROQaU+YNRc60mFpeYyj07t81bOc1Hg+5x7XEjc3m+AlpmJhGv7kTGaTU2REkkGzO8aexjdXRp642mndo/ckhPB6oMEnyvxPC9oR0cLceRz8jsOaChUsg+1/RGwpHFyeM3paibMfqlDA4HKQXbxQig3093UoX/wjCfLE058QQEzwr0qmgjp7FoSy4s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR11MB619106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(42112799006)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVhGRENUQkpBYXMrVU1CVy8xSUNIRjVPVlpIbEY2T0R1ZG9waFVOeU1RQUV0?=
 =?utf-8?B?eHBtWkhkQmdRazB4bWNleHBFZHV6bnJabTRRdklDYXhKUlBZYmpPWk9DQTJT?=
 =?utf-8?B?cE90TklHdm5TZi85Skp6KzlrZzhlaDU1dEx5K3BSbW54VENJM0ZudXhGNE1F?=
 =?utf-8?B?V3dzWXNQMFl0MzYvR0oyU1R6YjVSQ043QUhSWHFHSEdZbHdjc3UxVzI2ZU1V?=
 =?utf-8?B?eWY3QnUycFhBZWV5VEhtMzl0OEVkY1NoNm1wcHlYY1JUREpBaUhqMGlya0lj?=
 =?utf-8?B?K1dFeXhXZFFNd2Ztb1hEd0gxSUlySEJRV0syWWdSTVpzWFZ0dWRPNitVWlFC?=
 =?utf-8?B?am12eG52L2NlNDk0OEllQUtwZWJhR1IwaWh1UnlWTlExZXUrb2I2R1pPZXl6?=
 =?utf-8?B?LzYxanBtRTBuWXkvdEVlYkNKeFVxRTRPMGJDVjNKdVVlSWpDdEJmY0pyWWE0?=
 =?utf-8?B?aU9hSEFINFRhbksvam40Ry9zVHUyTUFiam1lMEx6T3hEVGRKbDA1djVIMW0x?=
 =?utf-8?B?TzhLZEl4bzZQNEFydUdWeDlla0R0MDZKSHlNZkxSdWF6bHNVYWJRZjJ2VGlT?=
 =?utf-8?B?YlZURks1MENQR2VhM3BQUTFqckdQZVJvRXYzYmp0VjMrYTJ1dVRNdzdTNHpk?=
 =?utf-8?B?N3pzK0VwYk43Z3dkNzZWS2VFYVRMSjJvbk1NT0tNQVN5dVdjYTF2ZUFSZVQ2?=
 =?utf-8?B?OFNrNXVuY0Q0a09wWC9TQjZwUm9iem5Zc2ZjTkxkS3dQTjhKSFJ1TDd3anBB?=
 =?utf-8?B?RGZ5TndZKzZhOHVyYmNaWjhheTRqSWFWNkZLQXJIcGpCMkZSRmZ3cFdhOGph?=
 =?utf-8?B?MThpa3hBSkM4dTJZMThhbjRwdHc1MFhPM2wydElldmZqMlBnaUhkcWxNUEhu?=
 =?utf-8?B?SlY4VmU5ODhyYnB5YU1qYURGYXBLQVE0bVZqUEhOU1FidGUwL0hJditTbnFp?=
 =?utf-8?B?Y2VURlBRdFpMN1I0VGxKT29sVFBMWVJ2dmJxNUNQdm1qalBTKzd6MVFyMTZK?=
 =?utf-8?B?bzBSWVFiMWtEekhkeUZ0RmtlN1ArbVlkT2RjNmFrTXVlVXlzMmc5V2ZTNW5x?=
 =?utf-8?B?K29yZlNnb2pqdmFNdGNkb3Vsb2ZqcXJnRUp4bGZYOXpFQzErTFcrbmFONnRp?=
 =?utf-8?B?OXByalhvam1MWFJUWXB1RjBXQlJCZ1N0Rk5tb0d0OWtnY1NTZ2JQSWlnSnRm?=
 =?utf-8?B?eHU0ZGN4T3ZUdUJzeHJVU1RMUjhmMjBxbHpIc0RqeUVPR0pwaTRqN0ZyeVN1?=
 =?utf-8?B?MWFMR2lWTHdmNHFJZUVnMDArSThXZHlzT2t5NS9FalBRdFhxNkhveTdVdWtX?=
 =?utf-8?B?Ris3RWZEL3dDMm83TWxibm8rbTIwbkZTYnYvbU91RWE4cTk3a0Z4eFJDS01H?=
 =?utf-8?B?V014MCs4SjQ5dDhlVDluVWdjRWpSZ28waDVnbmpvTG4vVmt2RWlhTlQ5OHBS?=
 =?utf-8?B?cncwZ2REcUs2b3FiZzVnWnZnWjMyRlpjeDRJT0RQWkZnd1hISmtlSnZDL290?=
 =?utf-8?B?UmoySkJUZmlLMXNnSFgxZHpXYlkwbEVFR2xsL0RyRVdrWjBDSFVuNGt2REV2?=
 =?utf-8?B?MlVISEkzalZpcmx4SjJqUjByREZjNVRGdDB3NlB5UlhXak1OU2JZVE5HRUVk?=
 =?utf-8?B?M1gxbXVGRThQU1ZYMTdwcjNCLythQjR1VlBCRWZwY3FBL2VzcitzZmwwRG4v?=
 =?utf-8?B?V2xpY0pNa3Q5RGJoL2xEWHAzeFBDdGkzVzF2NEM2OXpkVXU5ZDhaUUlzOCs0?=
 =?utf-8?B?WEdpbm9Ib05wUGw4QkRnQXgzbFUzTnl2bk5DZmpKNUJoOUVYelBvcjRQSU1B?=
 =?utf-8?B?VXJKVzFQSjV0TUJvdzBXTGpDTjRLTFh3cFIwR3I2UnlIREhuUzlTaXdqL0pi?=
 =?utf-8?B?YmJUdklXVWxjc0dNWVJraFo0M0VwRnNWaEhHVnY0ZTNMS2V1dVNDTXEyQ25z?=
 =?utf-8?B?cTlqbnVqek5nSEQyVWdNKzA5amFnRExOamZzNDRyODR3TkdKNStTd21HdzFS?=
 =?utf-8?B?anowYWFIOEdoNnZhTWFjMVB2ekE1dEM0T0RYY3ZnMUhqbzlxZElLNFVyL1B3?=
 =?utf-8?B?WlZMVHRlUy9yM1Y0UDdWeDF3czRyOGY4QzduTXNZNHQyQXhvUEhINnRYSXdC?=
 =?utf-8?B?RU45MExSTUZIa0pBMzQzOUNaRG04VENlYmlTdm9hM1ZxTEtuUnJ1ajR1TUlR?=
 =?utf-8?B?dWRSWk82MkhKMEZ6eGNvZGFiSGx3YlltM0NPRFdWUDkzVUVtQm9RaDBwa1N0?=
 =?utf-8?B?RHNEUUFvWmZJZGRVVjhYeXVBN0svREJYdWxZbmF4SUVmNmdiOVdnYW1mWUlo?=
 =?utf-8?Q?qVgd6i81F6ZZ7l6pdp?=
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
X-Exchange-RoutingPolicyChecked: Fzt7k88E/sVdl+gSO8QDBTTGEYfCYTcmQ5NQHXeyV4KAk9Sh5rsD3g/hGXHxfUigTcjrS4VYwyA5Z2tVhTr4kbaBbJrb9HdzK/xBPOO5DPGPjdACKcLDVYl10rI5xgbfrEJGqwJ7mKuL0waiDfLXxsTep10oEhsHzeQwecGLob7oqmqnEEGpcchFiFg26aY1yjhuvc6743WpKC30pztxUOELj2SqFcE2OH/oNQscuURjmv1DePVvZCLqUrV3DPHS2Kpn8tCdzHxO+E4ybp/OetOtNBMsW2SHqfBqA7wNZeC1BKD4zm+NIvUNM4mSHEfPbKr/Yqy6hDYngxHgOw03VA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB619106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40267e4b-6f1d-4ac2-440a-08df3f517952
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 17:38:46.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMFut6h/TjJk2RRBByMNLeSuwfZjcToHmueh5+NwGFq6AwTYmUE3VJX7TM6blb9b4S+Xv1FCsA0lySDgMHi8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com

SSBjaGVja2VkIGxpbnV4LTcuMy55LCBhbmQgdGhpcyBwYXRjaCBoYXMgYWxyZWFkeSBiZWVuIG1l
cmdlZCBpbnRvIGl0Lg0KDQpUaGFua3MsDQpKaWENCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1
cmRheSwgTm92ZW1iZXIgNywgMjAyNiAyOjAzIEFNDQo+IFRvOiBZYW8sIEppYSA8amlhLnlhb0Bp
bnRlbC5jb20+OyBNdW4sIEd3YW4tZ3llb25nIDxnd2FuLQ0KPiBneWVvbmcubXVuQGludGVsLmNv
bT47IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQo+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IEZBSUxFRDogcGF0Y2ggIltQQVRDSF0gZHJtL3hl
L2d1Y19hZHM6IGFsbG9jYXRlIFVNIHF1ZXVlcyBpbg0KPiBWUkFNIG9uIGRHRlgiIGZhaWxlZCB0
byBhcHBseSB0byA3LjMtc3RhYmxlIHRyZWUNCj4gDQo+IFRoZSBwYXRjaCBiZWxvdyBkb2VzIG5v
dCBhcHBseSB0byB0aGUgNy4zLXN0YWJsZSB0cmVlLg0KPiBJZiBzb21lb25lIHdhbnRzIGl0IGFw
cGxpZWQgdGhlcmUsIG9yIHRvIGFueSBvdGhlciBzdGFibGUgb3IgbG9uZ3Rlcm0gdHJlZSwNCj4g
dGhlbiBwbGVhc2UgZW1haWwgdGhlIGJhY2twb3J0LCBpbmNsdWRpbmcgdGhlIG9yaWdpbmFsIGdp
dCBjb21taXQgaWQgdG8NCj4gPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Lg0KPiANCj4gVG8gcmVw
cm9kdWNlIHRoZSBjb25mbGljdCBhbmQgcmVzdWJtaXQsIHlvdSBtYXkgdXNlIHRoZSBmb2xsb3dp
bmcgY29tbWFuZHM6DQo+IA0KPiBnaXQgZmV0Y2ggaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC8NCj4gbGludXgtNy4zLnkgZ2l0
IGNoZWNrb3V0IEZFVENIX0hFQUQgZ2l0IGNoZXJyeS1waWNrIC14DQo+IGFjZTA3NmVmMGE4NTRh
YjU5NDBiYWNjNTM5YmY2NmFmZDYxZDExOGMNCj4gIyA8cmVzb2x2ZSBjb25mbGljdHMsIGJ1aWxk
LCB0ZXN0LCBldGMuPiBnaXQgY29tbWl0IC1zIGdpdCBzZW5kLWVtYWlsIC0tdG8NCj4gJzxzdGFi
bGVAdmdlci5rZXJuZWwub3JnPicgLS1pbi1yZXBseS10byAnMjAyNjExMDcwNTAyNDAtZmFpbGVk
LTcuMy0NCj4gYWNlMDc2ZWYwYTg1QGtlcm5lbC5vcmcnIC0tc3ViamVjdC1wcmVmaXggJ1BBVENI
IDcuMy55JyAnSEVBRF4uLicNCj4gDQo+IFRoYW5rcywNCj4gU2FzaGENCj4gDQo+IC0tLS0tLS0t
LS0tLS0tLS0tLSBvcmlnaW5hbCBjb21taXQgaW4gTGludXMncyB0cmVlIC0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiANCj4gRnJvbSBhY2UwNzZlZjBhODU0YWI1OTQwYmFjYzUzOWJmNjZhZmQ2MWQxMThj
IE1vbiBTZXAgMTcgMDA6MDA6MDANCj4gMjAwMQ0KPiBGcm9tOiBKaWEgWWFvIDxqaWEueWFvQGlu
dGVsLmNvbT4NCj4gRGF0ZTogVHVlLCA0IEF1ZyAyMDI2IDE2OjUwOjU2ICswMDAwDQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL3hlL2d1Y19hZHM6IGFsbG9jYXRlIFVNIHF1ZXVlcyBpbiBWUkFNIG9u
IGRHRlgNCj4gDQo+IE9uIGlHUFUsIHRoZSBVTSBxdWV1ZSBCTyBpcyBhbGxvY2F0ZWQgaW4gc3lz
dGVtIG1lbW9yeS4gT24gZEdGWCwgdGhlIEJPDQo+IHdhcyBwcmV2aW91c2x5IGNyZWF0ZWQgaW4g
c3lzdGVtIG1lbW9yeSBhbmQgbGF0ZXIgcmVhbGxvY2F0ZWQgaW4NCj4geGVfZ3VjX3JlYWxsb2Nf
cG9zdF9od2NvbmZpZygpLiAgQWxsb2NhdGUgdGhlIFVNIHF1ZXVlIEJPIGRpcmVjdGx5IGluIFZS
QU0NCj4gb24gZEdGWCwgd2hlcmUgaXQgaXMgdWx0aW1hdGVseSByZXF1aXJlZC4NCj4gDQo+IEZp
eGVzOiA5YzU3YmMwODY1MmEgKCJkcm0veGUvbG5sOiBEcm9wIGZvcmNlX3Byb2JlIHJlcXVpcmVt
ZW50IikNCj4gQ2M6IEd3YW4tZ3llb25nIE11biA8Z3dhbi1neWVvbmcubXVuQGludGVsLmNvbT4N
Cj4gQ2M6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gQ2M6IDxzdGFi
bGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjEyKw0KPiBTaWduZWQtb2ZmLWJ5OiBKaWEgWWFvIDxq
aWEueWFvQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5h
dWxkQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1
bGRAaW50ZWwuY29tPg0KPiBMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA4MDQx
NjUwNTcuMTI5NTI5LTMtDQo+IGppYS55YW9AaW50ZWwuY29tDQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL3hlL3hlX2d1Yy5jICAgICB8IDYgLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUv
eGVfZ3VjX2Fkcy5jIHwgOCArKysrKy0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2d1Yy5jIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Yy5jIGluZGV4DQo+IDRmMTMy
YmY4NTM5ZGEuLjQyODZiZDA1YzY4NjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94
ZS94ZV9ndWMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjLmMNCj4gQEAgLTcz
MiwxMiArNzMyLDYgQEAgc3RhdGljIGludCB4ZV9ndWNfcmVhbGxvY19wb3N0X2h3Y29uZmlnKHN0
cnVjdA0KPiB4ZV9ndWMgKmd1YykNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAN
Cj4gLQlpZiAoZ3VjLT5hZHMudW1fcXVldWVfYm8pIHsNCj4gLQkJcmV0ID0geGVfbWFuYWdlZF9i
b19yZWluaXRfaW5fdnJhbSh4ZSwgdGlsZSwgJmd1Yy0NCj4gPmFkcy51bV9xdWV1ZV9ibyk7DQo+
IC0JCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiAtCX0NCj4gLQ0KPiAgCXJldHVybiAw
Ow0KPiAgfQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndWNfYWRz
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2Fkcy5jIGluZGV4IGY4YzY3OWNlZjAw
MzkuLjc3NDI5ZmY0ZDJhOWENCj4gMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94
ZV9ndWNfYWRzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Y19hZHMuYw0KPiBA
QCAtNDQ1LDE1ICs0NDUsMTcgQEAgaW50IHhlX2d1Y19hZHNfaW5pdChzdHJ1Y3QgeGVfZ3VjX2Fk
cyAqYWRzKQ0KPiAgCQkvKg0KPiAgCQkgKiBBbGxvY2F0ZSBhIHNlcGFyYXRlIEJPIGZvciB0aGUg
SFcgZmF1bHQgcmluZyAoVU0gcXVldWVzKS4NCj4gIAkJICoNCj4gLQkJICogUm91bmQgdGhlIHNp
emUgdXAgdG8gdGhlIG5leHQgcG93ZXIgb2YgdHdvIHNvIHRoYXQNCj4gKwkJICogUm91bmQgdGhl
IHNpemUgdXAgdG8gdGhlIG5leHQgcG93ZXIgb2YgdHdvIHNvIHRoYXQgb24gaUdQVQ0KPiAgCQkg
KiAoc3lzdGVtIG1lbW9yeSwgbm8gSU9NTVUpIHRoZSBUVE0gcG9vbCBpc3N1ZXMgYSBzaW5nbGUN
Cj4gIAkJICogYWxsb2NfcGFnZXMob3JkZXI9TikgY2FsbCwgbWF4aW1pc2luZyB0aGUgY2hhbmNl
IG9mIGdldHRpbmcNCj4gIAkJICogYSBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgYmxvY2suICBHdUMg
cmVxdWlyZXMgY29udGlndW91cw0KPiBEUEEuDQo+ICAJCSAqLw0KPiAtCQlzaXplX3QgdW1fc2l6
ZSA9DQo+IHJvdW5kdXBfcG93X29mX3R3byhHVUNfVU1fUVVFVUVfU0laRSAqDQo+ICsJCXNpemVf
dCB1bV9zaXplID0gSVNfREdGWCh4ZSkgPw0KPiArCQkJCSBHVUNfVU1fUVVFVUVfU0laRSAqDQo+
IEdVQ19VTV9IV19RVUVVRV9NQVggOg0KPiArDQo+IHJvdW5kdXBfcG93X29mX3R3byhHVUNfVU1f
UVVFVUVfU0laRSAqDQo+IA0KPiBHVUNfVU1fSFdfUVVFVUVfTUFYKTsNCj4gDQo+IC0JCXUzMiB1
bV9mbGFncyA9IFhFX0JPX0ZMQUdfU1lTVEVNIHwNCj4gKwkJdTMyIHVtX2ZsYWdzID0gWEVfQk9f
RkxBR19WUkFNX0lGX0RHRlgodGlsZSkgfA0KPiAgCQkJICAgICAgIFhFX0JPX0ZMQUdfR0dUVCB8
DQo+ICAJCQkgICAgICAgWEVfQk9fRkxBR19HR1RUX0lOVkFMSURBVEUgfA0KPiAgCQkJICAgICAg
IFhFX0JPX0ZMQUdfUElOTkVEX05PUkVTVE9SRTsNCj4gLS0NCj4gMi41My4wDQo+IA0KPiANCj4g
DQoNCg==
