Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794591613;
	b=lxfvO7kz3qDqvGIgB4QoAfOInmxkvV8mwE782WdC013Se6Q9AcieNyqIQAUEVJoQeakl
	 OZYOen6G2DPtZIkJr1j11t7D0bqjv8f6xxJt07CDQpi0XV5ZYeXlpnwrEcw1WcNQDy4+K
	 Bl4NzAElTQdOQR6Gr2/4CYm3CiLygZlfmup+ThvQbUXnj8zQa1GIJ8dFt6Vux9xgxbQ9E
	 LtjUOlbDfWGNRUQsduxAtwiCfJqMAKPW1g3BPEDeYzs7bpd4s9G8A3Dl8pELW95dqC1xe
	 62gg4spk1F7yNLhFqHmH9ylGagY++jdv/aqOYUBoQcwMBP5Z6FGj/PmSrHtbyWQfOnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591613;
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
	bh=AoQbaRNJ8qov7a+sYaPCaqPIENLObcRsphUHNO6vnVM=;
	b=knA5FbiMqkAjgq18vONe2FjtMQnpMTQ/M7NpwGCpUIfRc0nXbGurkIjS1OJIxmKZmwwg
	 9ge8cKstdSZsLnl8VKSlI51Wy02Wa5Xv4g6vsMOixteW/XcNdXMJLA1ye7mBc1TIS3trI
	 onWFzHudBE10hnu7Ov0E4p2kJWutPRCDN+h1bWwdpkpCoi7z0gtaD7NbUyPlLacFCeA/S
	 6JM7xi+xqJaZy7qFMSqRKew0f8a6pfA1SCZWN2aMcg1qpnQLBlN4P/Lmexk8zfr2vegfG
	 NEVmPubh116QyVvDRZxETw2llGoZ5UzyReR8zvJsIC2rQ+yTNFayQkezEe8vGPUNoyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QnxVDcon;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YfxIoJst;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C56606B460;
	Fri, 13 Nov 2026 17:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C56606B460
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QnxVDcon;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YfxIoJst
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794591607; x=1826127607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AoQbaRNJ8qov7a+sYaPCaqPIENLObcRsphUHNO6vnVM=;
  b=QnxVDconO5hLk++HC8LT94lZFThGxNAMXgeXEbnlfQRx96aiCdJd4R+g
   iQ8Q9LITmMIHLk+iHkDAENl0Hq7ekTbMFwpJWsY7lECtf5PyYAaYz/4LS
   bh5heXvJ4AH72ZLOA34x7A90wDE2wpuo2yuoYIA92aKNMHEkgqboLRwyB
   ejpPDiD3yfT4HmE3KSTGFpzJtWJM/Dsb1nLfFOA4yhXJ3XYsZDdwXudpb
   IcEHl0c8fkwFIz+rZuaKkHqYFNjrIvcvignkyVs9SOcJGa7pWrc4qMkAQ
   lUpu9B1BNdq6hfLptKByD6E1rdwuU0EiGBebaQzqCdQMU+vzoIBjfxJLN
   g==;
X-CSE-ConnectionGUID: CxiK6l3xRCWwLpb1IOFR2A==
X-CSE-MsgGUID: Dt+sGgTqRzSEWO6w17mHSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3398024"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3398024"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 09:39:58 -0800
X-CSE-ConnectionGUID: wBFrGWsPQ12qgn4bVFfqxA==
X-CSE-MsgGUID: KZqjIceCQl6Zb4tB6mzH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9071994"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 09:39:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 09:39:57 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 09:39:57 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 09:39:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RknkbNzOq2WFmyF1F8fi13UOkcoAeWdkbFKJbTaHqby4FMePdWxEFK+El7lTxtH7HxH9nofEssebfM2fpDu6TOvIPpNaY5YkQzF8sJ+5cWnnattoiDjpEs/b9chYgJgTOoS2ok0EYQm4p3JoJmgsnmeTguSEsVd8l9IuMHGhFzFtNiMqYAUJ3jhfmHhPtr+Pppv7rhqFDJVpFJTSVH2a3Wj37FEN61kWIbP8gDYRfr+pxbqBJI4rYxi5/x8He1qYokE8NlTZYcJrB6elE8aYjKxraflqoOT8IrP0hYB+76k1hEwUDYRg5zquhJVcAzE29hHjNLgdBLCdzZ44t8t9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoQbaRNJ8qov7a+sYaPCaqPIENLObcRsphUHNO6vnVM=;
 b=vqpKu1gvRSJhsjCc+NgVfINwx7HOWgYV88VHYBJqiAGW5mOtLw9rjjke/IzASfGjk9v52vYw87C0lmV1Ox7pUUvgPUTNVzEugZBtrYLXNDBunoO8Fkiivi6nwESeJqw9gnpPgFDhPmkEO+jUhrgT1FQUBcqWUFaIDspevDZyIR0OTJ8QOsMBX74IBDuUYKpxoWTvEMzw96ziYhzopN2/gR9pqYrSZv3sroyfz0TX+uNYiESShsj87G645YT/zGzmxD5VW9AxRtclmZ1EY2iGXQe79qYTYfTqtbMQcgrm8q2AjrQCFzKiPkVQTGpvStmAVtU7y5QSxRGqEqk/7Q+QRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoQbaRNJ8qov7a+sYaPCaqPIENLObcRsphUHNO6vnVM=;
 b=YfxIoJstDwdWSImEaZA1leVpvnWiLyuBvQUn2lOz/0FUvXh8pdrFaEG7NOxegGomeITFXSyLDlRfgb/4AQ8DVVPiP0zkZ28vuHwnYl17YAB1dKhm5fubZS+iVRvnyH/gS5/1mgck3Afham794w2feCvPwGyKYM/e5iW5ILfQuTU=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by PH3PPF46CD353BF.namprd11.prod.outlook.com
 (2603:10b6:518:1::d1b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:33:26 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 17:33:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "moe@flashbots.net" <moe@flashbots.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Miao, Jun" <jun.miao@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "djbw@kernel.org" <djbw@kernel.org>
Subject: =?utf-8?B?UmU6IFvwn5qoZXh0XSBSZTogW1BBVENIIHYzIDAvMl0gdmlydDogdGR4LWd1?=
 =?utf-8?Q?est:_Fix_and_speed_up_the_wait_for_a_Quote?=
Thread-Topic: =?utf-8?B?W/CfmqhleHRdIFJlOiBbUEFUQ0ggdjMgMC8yXSB2aXJ0OiB0ZHgtZ3Vlc3Q6?=
 =?utf-8?Q?_Fix_and_speed_up_the_wait_for_a_Quote?=
Thread-Index: AQHdY+xbWjjgSCvIwUKkNDKjcu8hYLcbQGeAgADq+YCAEDbyAA==
Date: Fri, 13 Nov 2026 17:33:25 +0000
Message-ID: <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
	 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
	 <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
In-Reply-To: <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|PH3PPF46CD353BF:EE_
x-ms-office365-filtering-correlation-id: edd1adea-8194-44a5-6726-08df41ac3930
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|261009223027099003|10067099003|261026140227099003|11063799006|4143699003|56012099006|261009221227099003|261022105027099003|261028144727099003|261026121527099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: RG5Vx3IKhPpM8Pw7T5qJrOZAWrdssGylljA7isWkFZJP5et9mWBh+9EgRa8AENDmx0LVz514IJKXcXmRNjLx1LfWiyN9jPj7TUIYftLr3+L25/6+gwO5L015+Y18s6KozEPvmis+EF4BcxP9BEbF0rstMVYlxFHueRe4kaioby3gp14170KnRC58OLqW9/0SwjfNbZzxKidnEr3Cfq3pqV0vh8HKQcmAedmx5DsKpUGkB+9c5RUG8FgXt264IpPPHWQWjxtEgbibpbJi6cgK5i5uAHbv/BLEKEjfm7elyRprgtIBDUEckhLXAn+sEIrbmy49uigA6ZuBFnroq3EuJ444h+N6m4CNtMqVAQ9npmU8paSKVI5wBqkPZQgIt4q0B9PcE1YVWR2+fKLh5xL0HKfgQ+1QgzFjviboKvNwNGJzTpbUdcMhNZ39/fD+IcZxNZPXE/iELRpyTwutKSnEM6hXrBb0b6NvJTiySfCr0tTHQGf9S7CJHOU7RqXKxMwWlMyvhMhC/fZ1AMX+J3gwwv12wqkldfRBNc525LjLxBRVqWsztIopM5JDWncR1qTmtfYM7oq0rI+weFXcekFyv0iqmJsjq8v/NZN5Y76pBdqcTkVTfS918SEKIWDkms2nOaJk4peGYQoHLYjvESf8smPFaq2z0SxahHb0Vu9vCtL0TaQlb7x8aVqRNKj1a7tEdgV7uS3/HDn64adbzijdfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(261009223027099003)(10067099003)(261026140227099003)(11063799006)(4143699003)(56012099006)(261009221227099003)(261022105027099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXNwMEJZbm1lREY3TXAwTXhJN0xWZW8wYUpNQmtqZXVCeDVlZG9uK0RGY0JG?=
 =?utf-8?B?dlJXb1VMVGlPdU9WTHp3UURPRlgwV3Ntc3N0NFpXK3hXa1NDQjN0MGpTZ3ZQ?=
 =?utf-8?B?VmdTNDBGSGNJdkNBdDFicXl1TVhyODhJWXpZc1VWRzh3NlpXVjB3blNaTEJN?=
 =?utf-8?B?Z0dPSzdwckxLVFFoV3plRG5JdWpVTFBHeVh4RUNVbjZ1d3dMRlF4TzF3VDBU?=
 =?utf-8?B?ckdoQWI3dmZrMGJTTlFEWGljbk9MTjBDb25xVEJVajlYK01OdDlkamRuazNh?=
 =?utf-8?B?aFkwV2lLZ1VNMjRwalVUL1ZkK1pUeHp4WndPNG1makY1L2daY1JSUG0rOG50?=
 =?utf-8?B?dWJOOE9ITzRJb002NnBiZUJWc1Rtbkp1aUlmODh2ZnZZdmpvNkNGM2Y4cXhl?=
 =?utf-8?B?SThaT3ZWRjhGSzlqMFk0TE1vcjNXNjdyaERQc1FWei93aU9RVE1nN05pQ3Q1?=
 =?utf-8?B?MHhPditkQzhVRktPWGw1M1IvYVhoUGJ5L2ttVXJHMXVDL3VSZlFJd1FJSG1m?=
 =?utf-8?B?ajdVN1YxTG84eWJ4b2Y5Qkl1R3pSSkdTQjJYQUZVR2FzbmZKNFNZSlI2Wk1m?=
 =?utf-8?B?UFFWcmVxV0xaRTFkWDNJM05yTEZsVXB6cVZZT3ZGZWtUOGFxQlcrR0Fka0dR?=
 =?utf-8?B?ZEJyN0VBM0lNSUQrR1dkQlc4dWlZMksrMnoxanQ0aERPR3FjWHErWDlUV2Jh?=
 =?utf-8?B?TE92WnBMS2ZseHVMY3RTakpGMnh0azZwZGYwaklFZFlyVUpZbzBpQnNsVGVM?=
 =?utf-8?B?bEhDc1RENG1jMnA4b3A4YmdDcEZ0VHZaNnFJRjh5UWYzS2J1TDZMYnplVzUw?=
 =?utf-8?B?U1JIWEx0SkYrTTZxNndDQ2RwZFBtd2ZodzRxOTZWUU9CN2hrTzhBbUZ3dEt4?=
 =?utf-8?B?VU90aVZHOGg4MmluTjA5Z0ZlOTRQcWZLN01oQzFrczltY01OZ3Q1YnFXbFJa?=
 =?utf-8?B?SG0xZDJ1MXY0ckU4U3c5dit1TTNrWGtWVUJSaDdDdHAzaElNaEpDUDdCRlNz?=
 =?utf-8?B?Um5xRTZTWVQ5dEtVQnBSR3kzMFBpWFVqUVJFbStiQXY5UFRmcVpBUHlmSHZF?=
 =?utf-8?B?L0E5bUlMcmVtYW9ZNFFRMmlQRzRvKzQ4M3ZDVytteWRzSGVBc2pZM1JIeUgv?=
 =?utf-8?B?R3JFaUFqUGpKV3JjM3UrODRmWjBnSUorSlB0dENkc3FsZ0dRY0txazJ0bkNv?=
 =?utf-8?B?Ukt4SHA0VUxNMFhPKzV4NkdVaHFGVnlpekZuSUh3Q0o2bjV5MU5wMnp0N0Nk?=
 =?utf-8?B?NGZaVStBU3ppTTRaVExXWUNKZFlXaDJPalBHR0V1ZXJ1OWNOcWw2Ykl6ajB3?=
 =?utf-8?B?eitENmI0bG1VQjlnS3E3eEoxenN4YkhiaUVBUXhyakRBK0IrMTRxUGRKMUc0?=
 =?utf-8?B?ak1uYUlJazJPeHJDdGVWUjRwYVptM1l2Tkp1N1JIK3VaTW1wVmlRSjlrVm15?=
 =?utf-8?B?dUJzQkFuZU5jc1dSUEhQL2tBOWRTYXpreFRoaG9SalM2MWNaYUlITFBqNnZa?=
 =?utf-8?B?d0pKdlQyajh3Q0hYRklxUEMzK3c4N2xCdE82SUkxNzVweC8zK2UydlZzL1hF?=
 =?utf-8?B?elZlcjdVS1NYOS9oMy84TGJhTFMrR2ZqQ0JFd2VWSDZtZzVYTnU2RmtrN3U5?=
 =?utf-8?B?OWx4ODBOZkpCaFFxNGxBb0hINThpM0tMa09mbWZjbFEyTm40RFdGZjgxV1A1?=
 =?utf-8?B?OWdXL1E4TXQyR0pGUFV1UFd0M3gyTzZpbTBoOTFKbS9Xbll1MUFkSklMRjFl?=
 =?utf-8?B?S0FneDNyTGNCeS9wOUZOSGwwVm1qVUJyUTFXakF0SW8ra2ZpZGU3MkdkTUZC?=
 =?utf-8?B?UzBibWVwZGdSMWlVZ0lsLzVIQURPUTV5TWZneG5BZnBaNW8rK0ZYZzNyd0x5?=
 =?utf-8?B?TVpXRlppcWtiMGVpdEZIWFVtS2pSUlZnc3hjaTNuVjVDak5qWjZpandBSlRt?=
 =?utf-8?B?V3VqSU5sWGxzVFRoaUcxVWhFOWNCY2NSMmN1RkR1MWwzOCtmQStubWVyMk5G?=
 =?utf-8?B?Y2hNZDlSY2VudVB2bE03NklJNHRpSE9EWVgrd3JFR3Zub0VqaUw0NWIvOGU4?=
 =?utf-8?B?SDkwSndkMkVWMnhWcXc5R0JxQm1zcHgrNmMrbjF4bFpxajhJbklCNndkZ3h4?=
 =?utf-8?B?RUVTZkQ1OEFpY0U4aDIvdVhmWmczcnlYdUdobk9SSmNCNncyWnllN0pmNVVC?=
 =?utf-8?B?YTdId3FES1EzMHNQUVM3NDFOQXJwN3huYmw2T3BDZ0R2UllIMTBuTUVzSnZZ?=
 =?utf-8?B?S2ZKeGtsUEtuMjJVTktSaFovTnFqblVYaHdENEVsaHhHZnVYWmJNbWU4bkhm?=
 =?utf-8?B?Qmlyem4xd1o1UVlLN3dPeDhhdTBoNkRWVERKVUk2d0tZR2tvajlzLy9oK3Jq?=
 =?utf-8?Q?q5ZF7/W0dFlAgGWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AACFD8D76DD10E49A64BC1A667ECAD14@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: dqkGeFOGmsu/R/xDkHol/J6w20Jbrryu1faXUPPC8VjgnbfTJe9orlqp7Q5Ur4QGpajrcmZdaXBJm7rV1ImkM1GbUVkP3VasXgS8QmSmkQYJX5GJfwyLY47OkPC5BVKYU8itJRWS0JkDyCOBKmwwfWaRqV5es22ND2BUKmveVCNMhWIyN4je7nC5Neh1EZVtUxxms0HFADs2KL1ElRY6AeRrW+grHIjKtruR46ou9EZAZtNGdNhHhWAPXRVrgyMAbr+cyxkTXjg+hKpq6+mFkjeN5QJ6XGNIAG7965Q4Zc+6wDEKlZKmV83lnt7U5gsbl7s+3Yir4a+HBdvSi3VRkw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd1adea-8194-44a5-6726-08df41ac3930
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 17:33:25.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qf472N+p4LkGIUs2emiNnQ6spMDS/f7biTCK38UY5p+TpaTl7b3pWKLpaMF4tNqVO0bApM3xMRwCbrjhDffEEX1GDYw5Hg9riZ7Fz2uuPP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF46CD353BF
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTExLTAzIGF0IDA5OjU2ICswMDAwLCBNb2UgTWFoaG91ayB3cm90ZToNCj4g
T24gTW9uLCAyMDI2LTExLTAyIGF0IDE5OjU1ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gPiBMb25nIHRlcm0gdGhvdWdoLCBpc24ndCB0aGlzIGEgYmV0dGVyIG9wdGlvbj8gVGhp
cyBwYXRjaCBpcw0KPiA+IGVzc2VudGlhbGx5IGEgcGVyZm9ybWFuY2Ugb3B0aW1pemF0aW9uLg0K
PiANCj4gQWdyZWVkIHRoYXQgaW50ZXJydXB0LWRyaXZlbiBjb21wbGV0aW9uIGlzIHRoZSBiZXR0
ZXIgZW5kIHN0YXRlIHdoZXJlIHRoZQ0KPiBWTU0gc3VwcG9ydHMgaXQuIEJ1dCBJIGRvbid0IHRo
aW5rIGl0IGNhbiByZXBsYWNlIHBvbGxpbmcuDQo+IFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQg
aXMgb3B0aW9uYWwgaW4gdGhlIEdIQ0kgYW5kIGVudW1lcmF0ZWQgdGhyb3VnaA0KPiBHZXRUZFZt
Q2FsbEluZm8uIEtWTSBvbmx5IGZvcndhcmRzIGl0IHRvIHVzZXJzcGFjZSAoc2luY2UgdjYuMTYp
LCBhbmQgYQ0KPiBWTU0gdGhhdCBkb2Vzbid0IGltcGxlbWVudCBpdCByZXR1cm5zIFNVQkZVTkNf
VU5TVVBQT1JURUQuIFNvIHRoZSBndWVzdA0KPiBzdGlsbCBuZWVkcyBhIHBvbGxpbmcgZmFsbGJh
Y2sgZm9yIG9sZGVyIEtWTS9RRU1VIGFuZCBmb3Igb3RoZXIgVk1Ncy4NCj4gUGF0Y2ggMiBpcyBh
Ym91dCB0aGF0IGZhbGxiYWNrLg0KDQpXZSBkbyBleHBlY3QgcXVvdGUgZXhlY3V0aW9uIHRpbWUg
dG8gY2hhbmdlLCBzbyB0aGlzIG1heSBub3QgYmUgb3B0aW1hbCBsb25nDQp0ZXJtLiBUaGUgZXhw
b25lbnRpYWwgYmFja29mZiBjb3VsZCBsaW1pdCBpdCB0byAyeCB0aGUgcmVhbCBxdW90ZSB0aW1l
LiBGb3IgYQ0KbG9uZyBxdW90ZSB0aGlzIGNvdWxkIGJlIHByZXR0eSBsb25nLiBJJ2QgYWxtb3N0
IHdvbmRlciBpZiB0aGUgZ3Vlc3Qgd291bGQNCm5vcm1hbGx5IGJlIGhhcHB5IHRvIHNwZW5kIG1v
cmUgY3ljbGVzIG9uIGdldHRpbmcgYSBmYXN0ZXIgcXVvdGUuIENhbiB5b3UNCmV4cGxhaW4gbW9y
ZSBhYm91dCB0aGUgcXVvdGUgdXNlIGNhc2UgeW91IGFyZSB0YXJnZXRpbmc/DQo=
