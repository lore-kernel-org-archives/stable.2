Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795417351;
	b=MqXaIrXpm3Vxycg23i8AVbpbTHJTNpjHnx2/EkVO6JRpxrN30R032lRZ7qZhPDP2kh/Z
	 YpVyxSln8Qy6/ONYIcnbHBNvYh4nO7Wo6/3PKDGLBWB2OJWJEjMnLsQZggpsQx7rp3YEk
	 48mExGRdXpY1hES8/5HcYZEERRMVRL08q9iRMN8+mGYCnnm1tVpb8MobRpi90UHYRzV2Q
	 233WYRmd3FJtpzC4WWSY/2mtreUPwZ80PEVZyBjlsMzR+AbR+hVMHcxOg4dlOS86ACtSz
	 nHaQ+4vz7Ri1Wi+OPFWoMQut88i37HyyvNokqWGkZ5O/24Cp4MVp6FuC1bxBD+ThfTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417351;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=u7A7uBVuIOCMZG7zE+E54d4xErth7u4DOcM7n08TxNc=;
	b=nMNe1bU5IpEOIlnjqEw3RCei4MQsVIIG2N9xfnT4gcMcIuXlp3rabRhkDLyKv/+31q/3
	 yW003uiCKzYR9jgMGdA4XFFXm2N3fQxmcb6JrnnpQcq7hPsXrqwupdAf9rRB7oMsrdfRM
	 fydW+qho6JTacKvaqZ/4AHsYTLR5lA8ftbuxyMzv/VET/Vh3sPWf3Pj5wNhGgjY4Bjn3x
	 MVQ7Zc6ScceMTUmd7i/GRn5HdmKwnAXvCtsEXXSN10p94MFG6uvxPjgF5EXap/m7RHlMr
	 G9ixl+Us3na8LJmtoJwaIO7OztyutVlawmocdBUtkCiuPVnQ5Tgpqume1l7c3ecKGVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BrdlFtHt;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DDmsZOkT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E8C606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08E8C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BrdlFtHt;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DDmsZOkT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795417351; x=1826953351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u7A7uBVuIOCMZG7zE+E54d4xErth7u4DOcM7n08TxNc=;
  b=BrdlFtHtWu3N6aarJiZok2ebWJvdUBvxbpG7ZTSCy8KqEKp+EU6R2A7b
   F31zi8FiqMZHLmlFQ3kAS/kLNTPESzDCw++RLt7uWJlVg5kgKfA+8bSgx
   SzGgAt1WKmqoiAHK0DLBAV6uMqJYvCfBtyY+/QenA9q0LE6N2y0coTLfZ
   a/aoPt8ouBUHew5SEbcwLrhvv2N7CgnyjusDPI4AA/SwZAlQl3/hQpYqU
   6165uP9hzNKqOHtTs/vcWKur8A7aNGLisJJZ5JeYO8ntMYRbS/6QEuT0C
   xWZLK6V29MG+V6Ag84HUiQa9pp9onFr4oAPUV+UdI+nWTPyXmNJWL/L6Z
   A==;
X-CSE-ConnectionGUID: g6jPmnY0SbeDqi20QyS8lw==
X-CSE-MsgGUID: E6McAFS6Tsi8BbHwRUMPbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4112768"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4112768"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:02:31 -0800
X-CSE-ConnectionGUID: gqdkIQHXR9GiX1I0/t411g==
X-CSE-MsgGUID: UVbV+CMBS9CHKDxXnGo/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="13203689"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:02:30 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:02:29 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:02:29 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:02:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs6UD9IagApiB20ZGDB/yEVSSy6CHTXc+LsHBOmdwaJi2W3zokNCdOMN7U4NcZJ4MXPrzA/be9XicU9QY+gEborVS1Cbf1qlMiycrHBi+bFVMQl0rnaJqWjGUBbaALOzv06IU+p0QBIAgXNoutYQJTgDGMUFDfeHSoK/KweBj3LPjyiOt5XZkchzBBznZ96ha/0/in9/cN3Hs4dbCEcy5Q4pubGrpNhFU+Kr0FxTsDcHPGI7Wzq08ryV7vBV59LhMQiIaGBPxvNbMV4ykNYwP/TgkBWXm2V5auOMPppI//ItxpZ0WMsxOpTrT3xelinrfe3MHvUY/qsa5ZvP5F1Y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7A7uBVuIOCMZG7zE+E54d4xErth7u4DOcM7n08TxNc=;
 b=eskUcix1rjReKn2fyOGUClwTndVXXvYwo6FBf0WrHjxKTz2DkNp9WmTLQbI7E22tCov19HQsR06Kc47pt07sRHZhtFeve2P5mzxMuOTyVUkS05j+cX+naD9JcSfUWas3F0PZn14i2Y8tlVcWk2vPVuCeNByL41uc31hKn1i0+fUVxsVCZ69gnZ9ceraYurZebl3vIbUs4KVODlltIZ59lt+ZxBJ6vCIeaE3SnQ9pBCGowma7xqgSmxKLUZGKQbVoyxO9yzWuVI2ccsXY5BtGC0YcN5V5sfhGM7ntDjBXxmkehw6t1EdK38GeG/YwOnkdv1VDr+RwsX6YMjzIe8619w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7A7uBVuIOCMZG7zE+E54d4xErth7u4DOcM7n08TxNc=;
 b=DDmsZOkTEDzadsnMczmmRTfFnvn3o/hwPXdMOP4M+mEWO96pAoCv/7DdS7NCXshSENeMVZ5Vu06oYcb1Tz2B0FI8aSeOMReaATuMkzLiK7Ailw+vJ25vL3GYQe5+Le7O/MBGictJ0X46ul2WSpDdZzgXVZwyiXJkSzWX+M5G0kU=
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CHAPR11MB9656.namprd11.prod.outlook.com (2603:10b6:610:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:02:27 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:02:27 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kahola, Mika" <mika.kahola@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
CC: "Nikula, Jani" <jani.nikula@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/psr: Adjust Xiaomi Book Pro 14 2026 psr2 disable
 quirk
Thread-Topic: [PATCH] drm/i915/psr: Adjust Xiaomi Book Pro 14 2026 psr2
 disable quirk
Thread-Index: AQHdd0xU73mI0auLZkqdnkLmlapEPbc2vMyAgASFzAA=
Date: Mon, 23 Nov 2026 07:02:27 +0000
Message-ID: <9d1634278a1497009f796eb401fa5c3ec29dd0ad.camel@intel.com>
References: <20261118110220.77370-1-jouni.hogander@intel.com>
	 <MW4PR11MB65701C4E512D24A5B51B9AC2EF782@MW4PR11MB6570.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB65701C4E512D24A5B51B9AC2EF782@MW4PR11MB6570.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CHAPR11MB9656:EE_
x-ms-office365-filtering-correlation-id: 72d54fd1-7f7f-461d-ada8-08df492fbc11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|4143699003|56012099006|10067099003|11063799006|261102123227099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: h3CCCXbmOTRffy58UZEKWmVOe4Gw9jW5o2jBGrUOgER9qMQNuL3rYSm7RD8fUEvwlZXqko4Nve+1vsY81Nmza3mDytjUVD/HatTfHGRHjtypBcKwkgWbkjAJIcDzyb6iaRjs4UCKAz8Vc+d4C0r0Aozmr67xhX+tTtBhGJXUCpbM5IGeB6Q8byM8IlZ8fMz9A11CeaU7XZEJ+nfYWbD3kTsR31ZBWazDHmcOgWCkFE7CF2rFzSgJBBCPt+l3VsTClql1A03E3NgLFdZVc5nb5SbAgE0X27lpYgqIg7HAVvCvTnObpIGL93tmxB/6UQn5Ud3wjemDx12toXT+HAgZx/Ht6TWQVAz6ZtnbPW1e6jicGA6sqfwK2OzVSOXd39cj4bmWkvSEJ0dnVfHG+serjqGRCysUIHgNoB2jM2F1rQ5XX/2yoXdPF7jfSkYpzzXz6HWg4SV4rjyuJt3CAuYgfl59lOfiUwwGivdSHonq7XAqZ9rc6Xg2NGhj3ETQruq40HqSmmq1aGfjfnF9MsvFxSBNWSdPAlqtNMzkfo1Zl015BdQQ0lxqtKPPcYPko3GOXQwmF1pgnz9HQ1wZdMy7cHG0N3fTV2rzbpjTccbng8Xv/n8rWP3Xs7NXH12BX0VXZBG/Ggl+l+aeI7LcSvy5fzjCMOGxYAz/hRRjTAwDRP8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(4143699003)(56012099006)(10067099003)(11063799006)(261102123227099003)(261021121427099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amRiU0ViS3VIbU5NdDROMU52cEtyOG45YnBzMEowSWNSL01GQ2ZQNklFeTdO?=
 =?utf-8?B?OU9TVFdQbnFsMFNMWlFWNWVJZmZsQUFGVEJzUEx5SEVpNzVzL1l0RXRKVWd0?=
 =?utf-8?B?R2txTVR2TU05aGN2cy9kTXY1ZjBycmFMOUhOejRVLzhzbkxxSkVxc2VaOVJm?=
 =?utf-8?B?VmRhZlRxMmNUT0NoS2dyRFQvdHo2SUlxOFJHWVM5c2g1Mnh1YlBZN1hkbC9Y?=
 =?utf-8?B?YjM0bTNvajlBeEdEMExXa2crZFZSVnR3K054RWYzUDVnakNOQ3kxT1JTM0Fr?=
 =?utf-8?B?b2tKOE5TQkRxcVdjVUVFLzUvbVZvMEJpZEhvdTQrYmUxcTF2ejZXSU5paEQx?=
 =?utf-8?B?YmNjeXUyZ3BYbXR0Z1RkeGdGY2pPMmZDak9IWnlsSStKZ0U1b0xvMWxIanBU?=
 =?utf-8?B?K0xjWkZxOXI0UjJ2aEp6R3BZa3Z3Y2kxRE1xajlXZWdWeUhZclIxKzVUdy9h?=
 =?utf-8?B?ditybWZXSXJONlB6eG9zR0l5RE1qNFFxSC9xaUJpTU9iWm16M3hnRVkwSFM3?=
 =?utf-8?B?d2R1amlKYWhuekJyRlh2azVpNVNLcFgxTW5LNGVEcTh4TVNTYkgxZG83WXpZ?=
 =?utf-8?B?UjNheTlJRVYyZ2lkaFFkVmlEcCtLUXNpMlV5S29ucEY4Y3dTeVhBNGJEWVZO?=
 =?utf-8?B?NWtYcTZYVDlmVlp5cjNuMHpIclhWcU9IWnpFRWU1dHhOWU1XaWU1WDNPTmRu?=
 =?utf-8?B?WWR4L1JJZnhaL3ZiL0FMVjRnTUpMNDY5aVY4NFdJSWxZY056TnNZR3FzZUhk?=
 =?utf-8?B?TDVOb3Z2YlBRb2JRMHZNMGxUS2daYTVwQUdLNkdVMlVOMHZ2QmZUOHlDNSti?=
 =?utf-8?B?TmNYVk5zZnIzeWRwM3pMdCt6MnVCQmc2cHdZNytKY21BNDhuemE4QmdkelBk?=
 =?utf-8?B?VVV5ZDlLU3B1Y3pOWlh1MUxjWlg1QzZvejZuZFNyZGZyY1V6Ry93eFlJNXFV?=
 =?utf-8?B?YkFlKzVFYTlDdmhmV1RxNTVnQ2dRcjJ2ZGFIYjNQVWlNd3Bza2o2K1RGU1Fz?=
 =?utf-8?B?aTAya2Q3R1VOZ1FLNHV4NElPTEpmb1ViRVZIOXdXKzBJeGJWaXM4dXgrMjJy?=
 =?utf-8?B?TGVVbFdUSjd3UW4yK2VsU2dORXpEOEhDdkdwQlYrQUJTVTBVMFhucmtPNlk0?=
 =?utf-8?B?VFJ2eUJ1aFpxWjNlbE9WaGk2cjNLQUVQZEkzZkRnZWRTYVRSRVhWbFowbHVv?=
 =?utf-8?B?dUNnM0RNdzk3WHV0bG03SndzWEVoZy84MlFVM2dIc3BGeHNvVHpqS1hxSG5y?=
 =?utf-8?B?eGJBV1N4V29JQnJFVDdEa2FBM0l2NnVjVjJvZ3NOYjlpTDJhRHY1dmlzU0M2?=
 =?utf-8?B?UUlVNlNNaXFZUzlUK3NHWlN2OWl4RTFJS2h4d1ZFQ055cTFoSFFKemVQQ1Ex?=
 =?utf-8?B?R1VlTllpdWFtSmVlZjNqUWl4VmYwZ1FyMmVJWGVTSXNIdXVqYnhIL1lMOTBF?=
 =?utf-8?B?Ny96S3I1TjFNMitLNFFoZ0lLb0QyemMrNmpHVEpUSEVoamJaZEZ0ZTZWZjVr?=
 =?utf-8?B?QnA0ODRQdDNhaFFNZDVja0g2QmJER0s5TWpRQ3JLWmxha2U2QmNoZjd3Z0VM?=
 =?utf-8?B?d0NaaWx4eDVHT3B2UDBGSHVPV0pEWXdwdzFXT1lCS3czbHBMNW1PSzZiQlFk?=
 =?utf-8?B?WCtqczZqd0JWRWp4Qk5sMGtPNk9DYzMxbm84UFNkY1g3OGJYVlBpRm5WWHIw?=
 =?utf-8?B?V1V6WjJNTGRYTDVQZmhWNTlRSUFudUNEdnY5RUMxajQrVThDelR0bjU2RjhH?=
 =?utf-8?B?SHg0YVQxRDlKVzJmZDcxMlFlZ3hpQVpCRjFaS0xkS3RhQXg3c3dkUDdRaTBn?=
 =?utf-8?B?elF0NzJyclZOZjFpd3VHbkRSK0k2Qk9EdEwwYXJIeisyZEtRTStBUThFczc2?=
 =?utf-8?B?Z1pvbksvdzNhMGJ5aGtjVzFNQXFsSVhJKzQ3dmtpalM4YUFjTkF1aTVPUUtW?=
 =?utf-8?B?ajJZU2Y4STNrR2pSemxJdmZsa3dvL3VCelJkU1pSQitUSHY0MVNCZG9obXR1?=
 =?utf-8?B?Rms0bHNQS3FZMlhubjd4UzcxMHlLcVM1NzgxMFMybmxwRVA2c2Rhd015dUk2?=
 =?utf-8?B?clNsaDcyTnFwaTdVRHp2OWFvMGJoNmZRN3J3aWgraTl6NWViWTg2cDJtNW5I?=
 =?utf-8?B?RklacEE4NDFsdEp3RktFSFhqRzZqZ3hSbjFnbG5ETVZvcUhzMnBPWnlPR0Zt?=
 =?utf-8?B?aHFjRHBmZU1Tbnh0NHU0Y3B4TDhXWkxjbmJuWEN6Q3NlM2FPTm9CVnBJdXVE?=
 =?utf-8?B?b1NLUGJ4U00zOWtMNVE0aGwrck5aZ2ZYd3ZHZW1jbDFCeU5EbEZiVnhNUmpM?=
 =?utf-8?B?WG9NV3hEck12V3ZKd0RVY3h2QmlQYUZ0dmxuOG1PdE15b2NSeDIyTDdsU1hQ?=
 =?utf-8?Q?DHYKzHUEsRWypVm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C495A25C2764E74D92ECACE33573889B@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: b2ao9fK9N1xQNc89eFlcCDlktzjKWQdHOdK4zsw3hYgUqXMQ+/tAfHg3zkKYBVv5ZMatqp1exEjRmXPEcj8n1DWK8LN+Xl53I+0Ptl5qpNPKEWQcYVqjKm57CaKihkuf4i0HwVMUt24SXLiBG8gTEfFbSfPgQWbjj/k7BCGjwsXRsu1pI3bBmYG7v65zd61OJm5ZkHSk38gyiBeKjGA2GACdfVz6vkVQ9kDof3IkII9Xo0LI6HQ4f8c9WWpM//Kq70mVdxgciEUD6cIR2uZeE2RALWw03DpSyVV0j/IiqdbyI/H/aOzAMy1MOHcfbH35lN5iN9GD4T76rg42MtDX8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d54fd1-7f7f-461d-ada8-08df492fbc11
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:02:27.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lxm230hSejas8dBdT8tFw8yj4xWSOCbzRw5l/7FGLNdlgPP79AKs5n+fRGdEr+Zni+f5J4RLkew+AKgNl6iYHXiuyWEJnz+p9yUTSi0riw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9656
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTExLTIwIGF0IDA5OjU4ICswMDAwLCBLYWhvbGEsIE1pa2Egd3JvdGU6DQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBIb2dhbmRlciwgSm91bmkg
PGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIDE4IE5vdmVt
YmVyIDIwMjYgMTMuMDINCj4gPiBUbzogaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
aW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gQ2M6IEhvZ2FuZGVyLCBKb3VuaSA8
am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPjsgTmlrdWxhLCBKYW5pDQo+ID4gPGphbmkubmlrdWxh
QGludGVsLmNvbT47IEthaG9sYSwgTWlrYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPjsNCj4gPiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogW1BBVENIXSBkcm0vaTkxNS9wc3I6
IEFkanVzdCBYaWFvbWkgQm9vayBQcm8gMTQgMjAyNiBwc3IyDQo+ID4gZGlzYWJsZSBxdWlyaw0K
PiA+IA0KPiA+IFdlIHdhbnQgdG8gYXBwbHkgcHNyMiBkaXNhYmxlIHF1aXJrIG9uwqAgWGlhb21p
IEJvb2sgUHJvIDE0IDIwMjYNCj4gPiB3aXRoDQo+ID4gZGlmZmVyaW5nIGRldmljZSBJRC4NCj4g
PiANCj4gPiBGaXhlczogNWU3OWFmNWRiMDBiICgiZHJtL2k5MTUvcHNyOiBEaXNhYmxlIFBTUjIg
b24gWGlhb21pIEJvb2sgUHJvDQo+ID4gMTQgMjAyNiBhcyBhIHF1aXJrIikNCj4gPiBDbG9zZXM6
DQo+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS93b3Jr
X2l0ZW1zLzk1NzUNCj4gPiBDYzogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGludGVsLmNvbT4N
Cj4gPiBDYzogTWlrYSBLYWhvbGEgPG1pa2Eua2Fob2xhQGludGVsLmNvbT4NCj4gPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjcuMisNCj4gDQo+IFJldmlld2VkLWJ5OiBNaWthIEth
aG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0KDQpUaGFuayB5b3UgTWlrYSBmb3IgdGhlIHJl
dmlldy4gVGhpcyBpcyBub3cgcHVzaGVkIHRvIGRybS1pbnRlbC1uZXh0Lg0KDQpCUiwNCkpvdW5p
IEjDtmdhbmRlcg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91
bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9xdWlya3MuYyB8IDEgKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfcXVpcmtzLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfcXVpcmtzLmMNCj4gPiBpbmRleCA5NmViOWE0MGRmOWI5Li5lMzMwM2Q1MTQ2ZTg5
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcXVp
cmtzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3F1aXJr
cy5jDQo+ID4gQEAgLTI3MCw2ICsyNzAsNyBAQCBzdGF0aWMgc3RydWN0IGludGVsX3F1aXJrIGlu
dGVsX3F1aXJrc1tdID0gew0KPiA+IA0KPiA+IMKgCS8qIFhpYW9taSBCb29rIFBybyAxNCAyMDI2
ICovDQo+ID4gwqAJeyAweGIwODEsIDB4MWQ3MiwgMHgyNDI0LCBxdWlya19kaXNhYmxlX3BzcjIg
fSwNCj4gPiArCXsgMHhiMDgwLCAweDFkNzIsIDB4MjQyNCwgcXVpcmtfZGlzYWJsZV9wc3IyIH0s
DQo+ID4gwqB9Ow0KPiA+IA0KPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBpbnRlbF9kcGNkX3F1
aXJrIGludGVsX2RwY2RfcXVpcmtzW10gPSB7DQo+ID4gLS0NCj4gPiAyLjUzLjANCg==
