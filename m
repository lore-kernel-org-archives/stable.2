Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794965304;
	b=cCZ0l5k9bjE1GRDmKFdOcJtej2l9+d1qrNOpm6CD0+nRlVJt3cqxQ9O0TrLgrrCDWKkr
	 Sf2GL8TwCjnm5WkwbCe5asbndYhYLeHGRN50NKHxDExpjJZ5abVKlEO8BaYAXwoDnZv60
	 JFqupyOASNyOz9YwZ0t0EcoyePjfJ+p1KH8DxTbaMsvH1/U0UBF6Hszl5AHkAkgVbw7GI
	 fgx32R/S18Ok2TZDez5KtznbSL9KAQNhnp6E3V48wTDpiN8IcEMDtL/nOxlG3qFO95yCw
	 aj2DRGwcMUxfj7zxOny8ru2bKBFvGE7PkuRv4fx9UhfNl+CWe2U07uDXcKMrinrkuEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965304;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=mQyhXDJkhzCgRd25O/AAksJjZ8HnuZTAS336cltTuyM=;
	b=tvoHCnDzOnUAnKDrk4CnYM0sbICNCjQh4zeJDrgT1McWvPL2P0KGk1FnQH6Vc/SPvUcj
	 uI/qiDrZFCYT86gwOTGhkD6Pm+cbhPj2fFWaALcxwDIz/XWeoexgkvwsiNB7CaShEwX6n
	 g2wJMcy9HWAoIV8cHtLlxs6IYF9O+2WSOhy6m31qiOZ1YUGqVEigHde4nfHoZlR/JqoIe
	 7Zqlqf+P9fqTFv3qiPsYnyi1CZ1WS9E6W3uWiWIjz90q5uAhLYqSFcPdQxiRKf+rKlYaX
	 EM9RjTpTB0F46300B9t30z8uP4l8lBawzMWai6uVuhg3jvymqtu5QdFqylIY3ajtsoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cpwMs6gZ;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="DIsCtv/t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F301606A31C;
	Wed, 18 Nov 2026 01:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F301606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cpwMs6gZ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DIsCtv/t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794965304; x=1826501304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mQyhXDJkhzCgRd25O/AAksJjZ8HnuZTAS336cltTuyM=;
  b=cpwMs6gZek+BZFyA6r7t/RA3+qTbmN0PCnmzkPXHNFMpg5S/sV/zoYHe
   YxYxnmdbawnxEJ5UhTI6FaUmbSNHuHuAka3QoyLaKOhMTgT6zwTf2+fgC
   TME49x31vLe+qMR2E6XuiU0m5tKMP9UCa8qa1ij82AjGbYGFwLkYoGSwZ
   kFbP8E/HvpPnjJKgGXaXmzkHOMSpd4vRAGhljXgRA8jJgOj2xekyxVyou
   HXPsM4G/WEwkVitzSkV7eRXhdr5Wwp/Jz94t2Zrv828gdaKf6wstV8fRg
   4/E3XjFLdjawrT7b5dTP5CtnJA9SLhnx76c7gKMs0poVeZ06Bt+0VZybZ
   A==;
X-CSE-ConnectionGUID: 5rcrUA3WT3SDOoYrGgbc2w==
X-CSE-MsgGUID: f2S4cQ8yS9KURTBGhnzaoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3643330"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3643330"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:28:24 -0800
X-CSE-ConnectionGUID: 2IxNh861QZKDm5ktTNv1dQ==
X-CSE-MsgGUID: F/YH+lAgRx+nrFm500HV7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10049599"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:28:23 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:28:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 17:28:22 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:28:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZN3Y2SDmTjpOjxXqrWUA98ApHUoajr6avE2bs/CDlsTHFr5rIzck7XBQWkxPUgt0dKiQJzsWV9N3n+yXkQbBJfxF14Zvru40xBK4UY6vCs7gbMaG0exuqu6Jyj83ovPFXVHPrauGSdAkCJEu85FeLyj0kxNR8QGYd4xckHTDNB2QnbTS4rvoCtnbbEfWVZRGJS4Va4I66xF5leahZSdp1Ny3M2NIqxQrW4Q9r9+Rb4zJlrzTtLWXyBVsjOd8v4PMuCzsRXdBx2Jq0mC3jc0Vutvu2jeslyhK3vhN5TG+0EPZA2N7o4whXyBcYxCxMLPx7cFohee12hWTvJeoeNeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQyhXDJkhzCgRd25O/AAksJjZ8HnuZTAS336cltTuyM=;
 b=EmdQYCzQWuHNw4+c7SCHjt5WX7kgLLbniEn1jz0V5ozWtU5lKICKUvLnq9lUfa6Axn7ckAUKevFQ+cGgqr1owSWMz3WcktuX5QvaVQFUWP+6hj837AftVqhk8secP+eB4gAqe/5nbatBDMUb4l8uOzgpbBoNfAcU0NnFSV2uQ1V7m+s9YWzWf3xwiPs9W3YXdsEbJwDFt9xa3HFNHE+mK9ixvZOE6+ro+ynIkwBSYwxE/lltMhGcBlcgTngnzBh26R8Fvg/o/I/GqgEHXne6eaYllT292klw9DOQUdiexPD5LgtzhOSDiijn/9Wj1BSRkYsPjIVdHEZnMrNbzVkmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQyhXDJkhzCgRd25O/AAksJjZ8HnuZTAS336cltTuyM=;
 b=DIsCtv/tcx5rg7Wmbm4UUXRMVMz8HWDH9unNaeisdQkTk/36nf38t4HHgKEXrGtJFfSklkQQHGFAA5psp8oB08wbp6ecNBQ9AjspgXYNQ4cLP6kcMF/UQm3vS8lL8iOQPip9afsyXfnAT1jNoseBdOwVt+zvVG+4xp4s81ffsPI=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DM4PR11MB7328.namprd11.prod.outlook.com
 (2603:10b6:8:104::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 01:28:20 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 01:28:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "moe@flashbots.net" <moe@flashbots.net>
CC: "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"Miao, Jun" <jun.miao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "djbw@kernel.org" <djbw@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFvwn5qoZXh0XSBSZTogW1BBVENIIHYzIDAvMl0gdmlydDogdGR4LWd1?=
 =?utf-8?Q?est:_Fix_and_speed_up_the_wait_for_a_Quote?=
Thread-Topic: =?utf-8?B?W/CfmqhleHRdIFJlOiBbUEFUQ0ggdjMgMC8yXSB2aXJ0OiB0ZHgtZ3Vlc3Q6?=
 =?utf-8?Q?_Fix_and_speed_up_the_wait_for_a_Quote?=
Thread-Index: AQHdY+xbWjjgSCvIwUKkNDKjcu8hYLcbQGeAgADq+YCAEDbyAIABL/4AgAWeBoA=
Date: Wed, 18 Nov 2026 01:28:20 +0000
Message-ID: <86f99f3010775eeff6269fd9bb8f4edac10a7d85.camel@intel.com>
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
	 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
	 <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
	 <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
	 <CAKV3HMMfx4APmardWdtL8yhirXMuuBQMZ8xrtowHNRnTKXNRiw@mail.gmail.com>
In-Reply-To: <CAKV3HMMfx4APmardWdtL8yhirXMuuBQMZ8xrtowHNRnTKXNRiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: b9304ee5-e655-4bdc-f919-08df45133ab5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261022105027099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: dxZ00qMRXnK+ju+gtlatizxvcnj0l5pVeNOLqrJA1NddCRi4W9Wjd2+xfUpyptlPxRbYt8iWHYmSFtGgj+YL5Bbimyp/i/Hegs0v5B9vmknCYJlrsBFT346IEn84g4q1wmPibmoXtuUz+3C6Vkis/WdGYeXbQqHIBmvjVgFjExATBIxKMrpunS2JNVGS7KeWMUscSqg50uqy0kgcqrgbAcFolm36ENOcQiCUDwkxHdi0+n+edkP/swu/iOjX9t2UYuUDbxgE16aHiJxOB+Dn5ngMvQTk3kLV+3u14GxzbSoRXEAZAyww4XInt6aeR5woDOkW5yPSG0G91d4fxmwummLxWmWuqVa0mO9fPtz+lENzxZ4fxLZET8kVMYu0VpyGtMtnMuDJpKrea93U7CZuno2TdlVlU8eGNot5HDsT/3R7NwR3VfvxRDa2LC9/YihbdJdRFHiFSVUktxltaTevR6oKmfCWRtNtsQKdUpWCmZLiy3if2P7xfyBBHYLdwPbnDRBGvP9KWJAFen4VzCInDXrMMVy3hrVa10A0D4Kiv2BcY+A0PB2IYbrUGB+vT9GQThWX2XNGo84dhswvNW3bsNMgnFXSVwdCmdHqMUgR6jZqKQoLhioPylVRp2trwk/dL+gjAetxeL/yH4JP8ndyU0bWZB58Xd0TtFQNSzT58DUhJ0GSxrdlBysPKTuj2cJlPzJ86wCfL83DoKYdyCb4/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRCS0RZWGk2NEx0a3Y4ZCtjTThvaGoyQTc1eTRFMU12SVJKK1VGMFBwLzIr?=
 =?utf-8?B?Qld6cHVnRkRkN1NPQmVrTEs0ajdBOU8vOEFxdUJwNW1qVnp1enZTc2xjdUZw?=
 =?utf-8?B?V090Vy9ZWWtRWmdTZnc1Y2IyNDFnY3F0ajltOEtYeFd6djF2NUY5RitqTXBh?=
 =?utf-8?B?aCtKaldWaEtnMXFFbHNuWFkyM2c1T0Y4cUxwY2hPcHAyRVFYViszdEdPU2ZS?=
 =?utf-8?B?NmlYTHBvOXIwaXVpQU16eGd2SnBlWnJzakJEMWFzc2QxY3pZdGRZR1Mybkxv?=
 =?utf-8?B?djFrTlFaRVdKT0RHS04vTW5lcWNCYnBuTmFHQXB6L1YxOUU3K0NlQWQvVFRV?=
 =?utf-8?B?S1JERnovOGtYK3JDZVNkaGVwSEJLblZXdkgrR29lVDJpQTR1eGQ1RkN4Ni8y?=
 =?utf-8?B?QXd6NjhiYUo5cHBhRkpqdittSGdxNHY5OHltNlhIVmR3WWxHZDM1QWVDYWp2?=
 =?utf-8?B?ZVZHUTFXTnVTYk1mb0x0RGtEQ1JWRDhjVVE0TU13eWhXZ1VBK2phRkgyc1VY?=
 =?utf-8?B?MERJb1lLRkVTRW5QNHZZMDNiRVlCOHFON1hERGgydWMvYUlPR0k5dmIybnE5?=
 =?utf-8?B?NHhwWTZOV1JOOWRxenErZEV0UlpiRlZhbmNiWjZRbFE0ZFlUcFdjWmZSNFpj?=
 =?utf-8?B?K29GczJhWFpQSGswbHQzSGl1S09oTlFBenluRi92YTFNT2liTmduM0VGWGgz?=
 =?utf-8?B?Y0hvN1FzNEdYWklTblAvNmtHUENOVEhtOTB0SHRERTFHeWZPdU56YzdjcXh6?=
 =?utf-8?B?ZlE2czhYbjVQdEU3VDUyRFRrZGhaTGgrL2ZnQjVDa3dLSVVLQXJ1bit6QVhz?=
 =?utf-8?B?ZmJaeEM3QlpGcmJYbHlFdVVQZ1BNZzNYTTZrV1ozRXZaNUJhNk1OSEE2eDI2?=
 =?utf-8?B?YURobmtEUU5ybGxEeGxTT1NEMG9nMVRZaFd5cXlzQlI2a1FjVm8wWUNlN1U5?=
 =?utf-8?B?R1hoZ0Y5OERJZ2F0a1lKV0hzSVdNajdXZzhmdTMwbTBKeSt1ZzlhSzc2ZGlI?=
 =?utf-8?B?OUxHZ1UxSzRxOHR2ajAvTys5WkNCNVlna3pXdWs1ZkhWdlpNNkVNNVpFTXZO?=
 =?utf-8?B?MktQT2VuTThIRGxTd0kvYWJ5UStxWXVFZTRWK3hyZlNSN2h0cVArdVphTE1H?=
 =?utf-8?B?OHZHd2dPRXVJK1J3My9meDl6ZVRXazQrRE1Na0lkdDIrZjFjMExqYWxmQ2p5?=
 =?utf-8?B?RzRuSFJoazRCNU1nWU1OZUV4T2h0NHFKMTJSUkp2Q1BmSnJpMmM4T3NSRTd3?=
 =?utf-8?B?ek12Z01yaS9IQjRUWmxISStzck1uUGcrK3lTQmhsWmhMb1FDSlFJMFpRQ2dQ?=
 =?utf-8?B?YXdFZm9rV04wcTVxa1ZTL01HdUR1NVVIMmhwTXhQODdMSUlURFdEcnZjRnp3?=
 =?utf-8?B?Z1RvalJHak8yd1ZTd2JVQitoYkpFZ3B6dnZqdjVLQWdVSW5CTWlIVFFGc3hR?=
 =?utf-8?B?c05VUXQvZjlWLzdta1hPNHNJZ2pEZHRnQ05mQnpTemE0Q3hGS2c4U3pTem5R?=
 =?utf-8?B?Q25hUyt5REp2NTBFVW85SSswZDVjVDBnOGpyTUtZNFBpc1FGNGZKa1RjWlBQ?=
 =?utf-8?B?ZlpTU2ltOEdSTXJpVWJLY2tiMXlxVVhYTDVDZkRUMzZOUTFPTmsxZXpqTmhZ?=
 =?utf-8?B?YnJNUTJYY04zQlh3ZEtia3QrUTczM1NqWE0yaTlhb3hOMk1wMWtvOXhTZG1j?=
 =?utf-8?B?bGFXRGwyRTZEM29FZEI2c0ZvaHZ1R24ya2t4eE0rZGJZM2hUWkUrT3NQR3Vz?=
 =?utf-8?B?eC90cHVQYzVVMUU2YlRNQXdGMW80YkI3OVpGdjBTNXlCM0cwenBRUFZkVEJQ?=
 =?utf-8?B?clI1YkFwM1RRd2lEK1RvMWdWOEs5N0hBWkRkMTdEY2x2NTVDQ3ZYRUpvT3Mz?=
 =?utf-8?B?SFNGa3ZlVTRNbnNLYVgwWWJOR1NVUHlmOHdIbmNjUFFCTzRsUGttcG9JSDN2?=
 =?utf-8?B?N0xUKy93aGVYaHh4MCsyczdPVzlFQVB1WWZZTDdNMnJHL240RStiNjI1UU9I?=
 =?utf-8?B?Um1xS2g4UEREWnRrcDZVWHRkTEZhYm44dG1PaFh4em9PM3JjRHgvQlN4Ujhm?=
 =?utf-8?B?REY5N1VVSVZUd2pWMFBJUU9iNVVOL2c3ak10OGI0ZjNrZThmOGFZQnA1OS9W?=
 =?utf-8?B?TWlXS1R0dkdLY2M2NUo4cCsweGNWY2V5NHFmbU8zT25sWFd0OEJLTldmUDJh?=
 =?utf-8?B?V0NwalJpWFMzZnJnSlFxVVlvUVh5NEhaQnpQZ0NQeldLUDRZMUxSR0ZUUmdD?=
 =?utf-8?B?b2xyN2ZYS1ZYRE50V0N0cUlPTjI2N3JzRDhzcVdiOVAvd1ZWaS9sMTNvM1F3?=
 =?utf-8?B?UGhaV1ViODgzdWZXSGdNTmMxY1lCNjlhMFFZM21lUDhLYnMrb21MbzArRXhK?=
 =?utf-8?Q?BCo4Qre1+b0u1y1s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11A90F912791104A85DD1BFF9EBDB9DE@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: uNGuibFSktg008mNAsgaswIN0rGmYWZ6M+5G+Ia2Tn2RJIjzWJg0QcGD0EVcrlZ6+wCCobQReJjLzoNZes0AE1VbgCii7r21ey1Pb3bzG6cIHUWhoeZbNuQe6cq39GfkILy0rmmUJ78IUK1g+Fsk3g2ILedawgtwih8NjDbDy2EONrSU29A0A0/Zu3nEMmBBenh3ZFjneeVJUuMl/CroItvmDoCmFPAafsOj3U+TcOhFr0m+nVDs+HxjTMFmy48+lxGmO4CbYNyBXvgG+V0m3b7Gb8tWiyQVHuEyHc/h3gzEfWjJwOuAiaOUcvTnKHSSJslcvEswaRjea03ZXg3nmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9304ee5-e655-4bdc-f919-08df45133ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 01:28:20.1345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zmy5zqo2CC/Az+5MOe8yO9mzK3JjP4QJU12VFfaAPbKaegj40Qd7zlwYuYPsWLUSDrogMHS8OgtD9gYDbyqz/LO/zdiwNhpB6HG0vsMRN4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTExLTE0IGF0IDExOjQxICswMDAwLCBNb2UgTWFoaG91ayB3cm90ZToNCj4g
T24gRnJpLCAyMDI2LTExLTEzIGF0IDE3OjMzICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gPiBXZSBkbyBleHBlY3QgcXVvdGUgZXhlY3V0aW9uIHRpbWUgdG8gY2hhbmdlLCBzbyB0
aGlzIG1heSBub3QgYmUgb3B0aW1hbCBsb25nDQo+ID4gdGVybS4gVGhlIGV4cG9uZW50aWFsIGJh
Y2tvZmYgY291bGQgbGltaXQgaXQgdG8gMnggdGhlIHJlYWwgcXVvdGUgdGltZS4gRm9yIGENCj4g
PiBsb25nIHF1b3RlIHRoaXMgY291bGQgYmUgcHJldHR5IGxvbmcuDQo+IA0KPiBUaGUgYmFja29m
ZiBpcyBjYXBwZWQgYXQgMTAwIG1zLiBUaGUgMnggYm91bmQgb25seSBhcHBsaWVzIHdoaWxlIHRo
ZQ0KPiBzbGVlcCBpcyBzdGlsbCBkb3VibGluZywgd2hpY2ggaXMgcm91Z2hseSB0aGUgZmlyc3Qg
MTMwIG1zLiBBbnkgUXVvdGUNCj4gdGhhdCB0YWtlcyBsb25nZXIgaXMgc2VlbiBhdCBtb3N0IDEw
MCBtcyBhZnRlciBpdCBjb21wbGV0ZXMsIHdoYXRldmVyDQo+IGl0cyBkdXJhdGlvbi4gQSAxMCBz
IFF1b3RlIHJldHVybnMgYnkgMTAuMSBzLiBUaGUgY3VycmVudCBjb2RlIGFkZHMgdXANCj4gdG8g
MSBzLg0KPiANCj4gPiBJJ2QgYWxtb3N0IHdvbmRlciBpZiB0aGUgZ3Vlc3Qgd291bGQgbm9ybWFs
bHkgYmUgaGFwcHkgdG8gc3BlbmQgbW9yZSBjeWNsZXMgb24NCj4gPiBnZXR0aW5nIGEgZmFzdGVy
IHF1b3RlLg0KPiANCj4gSSB0aGluayBzbyB0b28uIFRoZSBjYXAgaXMgYSBzaW5nbGUgY29uc3Rh
bnQuIEkgY2FuIGxvd2VyIGl0ICgxMCBtcw0KPiB3b3VsZCBtZWFuIDEwMCB3YWtldXBzIHBlciBz
ZWNvbmQsIGFuZCBvbmx5IHdoaWxlIGEgUXVvdGUgaXMgaW4gZmxpZ2h0KQ0KPiBvciByZXBsYWNl
IHRoZSBiYWNrb2ZmIHdpdGggYSBzaG9ydCBmaXhlZCBpbnRlcnZhbC4gVGVsbCBtZSB3aGljaCB5
b3UNCj4gcHJlZmVyIGFuZCBJIHdpbGwgZG8gdGhhdCBpbiB2NC4NCg0KSSdkIHRoaW5rIGEgc2lt
cGxlciBzaG9ydGVuaW5nIG9mIHRoZSB0aW1lIHdvdWxkIGJlIGJldHRlciB0aGFuIHNvbWV0aGlu
ZyBtb3JlDQphZHZhbmNlZC4gQnV0Li4uDQoNCj4gDQo+ID4gQ2FuIHlvdSBleHBsYWluIG1vcmUg
YWJvdXQgdGhlIHF1b3RlIHVzZSBjYXNlIHlvdSBhcmUgdGFyZ2V0aW5nPw0KPiANCj4gQXR0ZXN0
ZWQgVExTLiBSaWdodCBhZnRlciBlYWNoIFRMUyBoYW5kc2hha2UgdGhlIHNlcnZlciBpbiB0aGUg
VEQgc2VuZHMNCj4gYSBmcmVzaCBRdW90ZS4gSXRzIFJFUE9SVERBVEEgaXMgdGhlIGhhc2ggb2Yg
dGhlIFRMUyBwdWJsaWMga2V5IHBsdXMNCj4ga2V5aW5nIG1hdGVyaWFsIGV4cG9ydGVkIGZyb20g
dGhhdCBzZXNzaW9uIChSRkMgNTcwNSkuIFRoYXQgYmluZHMgdGhlDQo+IFF1b3RlIHRvIHRoZSBz
ZXNzaW9uLCBzbyBpdCBjYW5ub3QgYmUgY2FjaGVkIG9yIHJldXNlZCwgYW5kIGV2ZXJ5IG5ldw0K
PiBjb25uZWN0aW9uIGNvc3RzIG9uZSBHZXRRdW90ZS4gUmVxdWVzdHMgYXJlIHNlcmlhbGl6ZWQg
YnkgcXVvdGVfbG9jaywgc28NCj4gdG9kYXkgYSBURCBhY2NlcHRzIGFib3V0IG9uZSBjb25uZWN0
aW9uIHBlciBzZWNvbmQsIGFuZCB0ZW4gY2xpZW50cw0KPiBjb25uZWN0aW5nIGF0IG9uY2Ugd2Fp
dCB1cCB0byB0ZW4gc2Vjb25kcy4gV2l0aCBhIGxvY2FsIFFHUyB0aGUgUXVvdGUNCj4gaXRzZWxm
IHRha2VzIGEgZmV3IG1pbGxpc2Vjb25kcy4gV2l0aCBwYXRjaCAyIHRoZSBzYW1lIHRlbiBjb25u
ZWN0aW9ucw0KPiB0YWtlIGFib3V0IDAuMSBzLg0KPiANCj4gU2Vzc2lvbiBiaW5kaW5nIGlzIGFs
c28gdGhlIGZpeCBmb3IgdGhlIHJlY2VudCByZWxheSBhdHRhY2tzIG9uIGF0dGVzdGVkDQo+IFRM
Uywgc28gb25lIFF1b3RlIHBlciBjb25uZWN0aW9uIGlzIGJlY29taW5nIHRoZSBub3JtLg0KPiAN
Cj4gRm9yIHRoZSBsb25nIHRlcm0gSSBoYXZlIGV2ZW50IG5vdGlmeSB3b3JraW5nIG9uIHRvcCBv
ZiB0aGlzIHNlcmllcy4gVGhlDQo+IGRyaXZlciB1c2VzIHRoZSBpbnRlcnJ1cHQgd2hlbiBHZXRU
ZFZtQ2FsbEluZm8gcmVwb3J0cyBpdCBhbmQga2VlcHMgdGhlDQo+IHBvbGxpbmcgYXMgdGhlIGZh
bGxiYWNrLiBPdmVyIDEyMCBiYWNrLXRvLWJhY2sgUXVvdGVzIGF0IEhaPTI1MCBpdCBnaXZlcw0K
PiAyIG1zIG1lZGlhbiwgYWdhaW5zdCA4IG1zIHdpdGggcG9sbGluZyBhbG9uZS4gSSBjYW4gcG9z
dCBpdCBhcyBhDQo+IGZvbGxvdy11cCBvbmNlIHdlIGFncmVlIG9uIHRoZSBwb2xsaW5nIHNpZGUu
DQoNClNob3VsZG4ndCBhdHRlc3RlZCBUTFMganVzdCBiZSB1c2VkIHRvIHNldCB1cCBzb21lIG90
aGVyIGtleSBzdWNoIHRoYXQNCnN1YnNlcXVlbnQgY29ubmVjdGlvbnMgY2FuIGJlIGFzIGZhc3Qg
YXMgbm9ybWFsIFRMUz8gMC4xcyBpcyBzdGlsbCBraW5kIG9mIHNsb3cuDQpJbiB0aGUgZW5kIEkg
dGhpbmsgcXVvdGUgYmFzZWQgYXR0ZXN0ZWQgVExTIGlzIG5vdCBub3JtYWxseSBleHBlY3RlZCB0
byBiZSBmYXN0Lg0KU28gaXMgdGhpcyB0cnlpbmcgdG8gb3B0aW1pemUgdGhlIHdyb25nIHRoaW5n
Pw0K
