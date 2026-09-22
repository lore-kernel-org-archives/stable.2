Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86E51FCB8;
	Tue, 22 Sep 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112986; cv=fail; b=L8DstczjVOyhnoszMqitoG9TWYvTDwlFkVAxzYwRYvaB427bajVF6JfZyjdvMM6zgiBxGvKhdFGMwYUHTW+JjJ+LDuH3f0QyjIZ1R1GvhQ/jXTJ73d84uoc1ibXOyno219s5K8WxjxcOED9beCTli8cAMHMoxol7iA3z/D8u8Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112986; c=relaxed/simple;
	bh=BBpdiUFrDks8n+y/wd3yvYyjDUjHN7s+2hY2ErKEzDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HhmW8/fSy/rb66rpn74wc0yaw4iHKHmS6es+sg4PDsZ5tITigLrWgkefJ7+rXMPtr2WrLox4pGZyip9JJXJvIsym9RT1R2RrEjVzdKTVqXsoaLowiLr3a66eKSaYNFuf+DcLFjcCFCsKVQ0h7htM5pWw7Mc6ARfuW5CWdSn/oUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkjF/fAE; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkjF/fAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790112968; x=1821648968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BBpdiUFrDks8n+y/wd3yvYyjDUjHN7s+2hY2ErKEzDY=;
  b=jkjF/fAEkfg8G8MCv2Zm3w1GW9e1+xlaa9uMUMSrsfXW5woYxXEuIQRT
   /8QhxApw1JLOqmcVVlB/fNnVQkM7v/Wv2lpMsGqpbN5wPpZdk1fhbBDAA
   9J/8iYimM/ok+7rU+okWlYDs/vSCvNo3Sg+TJXWwclwVeFt22AeWOZIYI
   LoxQCJ9XWckFlWE0aAe7/KURwskRoVcvCyrVyLxiSvMYTjIeoetPr2Ase
   TIZ8nesuxz3o4v1lXZSdeCNOZQ51kqtdJwdfQWtz9ubRpfhfVrR1G0J7c
   STV12pMOceCj7XG+PioihIqpcl7XOO8mvytBOSRF6GXjzfXbXCirbmqcS
   A==;
X-CSE-ConnectionGUID: uMlHi5H7TTC0DP8sGo3f0g==
X-CSE-MsgGUID: i+lXKsppSCij94mipx8aEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90626866"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90626866"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:35:59 -0700
X-CSE-ConnectionGUID: pbBRHpyJR9GNjFpR7LGdlg==
X-CSE-MsgGUID: SUxCWgIdRki2Q6S3Rrs0yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="278070148"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:35:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:35:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 14:35:58 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:35:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxVvaIAGg4MQ9A4qoZBGjhpFrEk2TkyaF6R00z7H0AdSmD7k4yUcI0yxe/922ttI4HHV/ZFbTz116F8pfkdW9YlmyjdjNLCIH4ZGYJFTW36qkjlW9Nd7MIQ2SY56Y4UacozfLXlJwiFXzmBOyTFX2WI/qiE3epo/C8uox1hQbD3MHUH5SpgIh9nN38sNEQ/aucLhAPpvCEiMvmcAQFY9ltw1GAfVDvPDv9Kn7WkulNQwAbN60PcMyOj2ORWQKwCDOzMoOdwRINi+C0sk4NHrLozJHG1BWHrw/1qvkOCu04z2Kpl4FsAxBxhcPxhZdD+2wLtZhRMCC1rp+H8g/M9V2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jhJlXyDAUnCj+UMTYRA9zDa82x3+cJOgQrBPHK00Zo=;
 b=W5B6jugk9yluqHhHre6HA2YVq9AQXIVKS+6xdHx99edvEIT5Jjl9OIIBmV4DGCDbwVaX96aDgeqNURL6pytRu9tATV5D7GQr1k4ewJ5dYSwkG9HX6Mfp7+qmKnLXKKVAVUwrLFRq9r4yTWbjfNySIuYRFU48EIBDCQFyXeEEFQCMha8slMlhlCcOuTVNATUmp3WBvn4xcufQ0nIrLY0ScF9Xx1HIpRy33NN2y4aCuqdfv4mqbPID4PZ/QmqTdiUGlhGLoR665fe458ftjnkOb1mgmBL1tS139cW1ReUmOGc5IST0hydjYjC1UBVO7i7pxrcUIK4VcIUJCGtU3ob7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 21:35:33 +0000
Received: from MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2]) by MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:35:33 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net 1/2] ice: fix DPLL registration on boards without
 the SMA clock mux
Thread-Topic: [PATCH iwl-net 1/2] ice: fix DPLL registration on boards without
 the SMA clock mux
Thread-Index: AQHdRtdCIHE0O/HUNUCUWiFPhXw2s7bbJs9A
Date: Tue, 22 Sep 2026 21:35:33 +0000
Message-ID: <MW4PR11MB6984A32D6EB75197B6DBFE749B832@MW4PR11MB6984.namprd11.prod.outlook.com>
References: <20260917190258.3239282-1-poros@redhat.com>
 <20260917190258.3239282-2-poros@redhat.com>
In-Reply-To: <20260917190258.3239282-2-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6984:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: 86a75df8-6997-42ef-12c4-08df18f16ecb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|38070700021|6133799003|10067099003|5023799004|11063799006|4143699003|3023799007|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: +EOuM9TbbdlZPs5cx+RwOmeQ1ZIVtj7nfsbnLubNlrlsjY8gOtdZpzVy6FYgxW6b1YycaRM9ywFffovpUmS3HNcyru0FwfpltvmX8aFfYxS0/wrNfnOa7Bw72ByA5rEUl53ftwjb94XpxBLDOLdg9Z1I7U90Jj+FmemeO6jbkiJ5GxCktC7hawGc0YVSiNzOOPVMRF3YMUVYmB8FeT7EUbaxIPQYhOIRBABjj470TS5YP6OheDCAwgxi1PTUlRvklxHb6jQVtzG/tbAhvBBV8AptXfWl6454DOtM7rd5PlgA71bTuzLLmChbtZNbpI237mudAjzAqxAi3TTf2TxWp1yl6s3PF38SIzjpFN/mCARVFPi507E7TTbb+b0IN0cllpNhw4BXMo6hGMAtLMTzh24/nPrz+LzlZIXkkuILhIHG19lzGpHoIrLD39U0VQZdXLzj/i7a46YuvWw0LBGKxgPGhZsagYD5V3gQ2rtDHUiAbJ8TaroGn5aBnajsXot0SzKDsuLUUgDVgS6kKGVCD21NKEYOVqiamrD4Y8T60ixJazyfAlK2tpae/DCAWbOgFPDGtDjyQF3+DOUYgJNW7qWMVwNpljEfuJIzQwThuEwCFOv82BoEgmG7AsAgNnnqlhtoOyD2CsfI9geFyXVmtoEBl0G10Wwv0yAOFUOIo20AJhEhOke/5cB1XBicsrmZxSNFbhs/Gqj00XyJqGij7D9hD/tnAKrkhQIgUgmFSJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fg+HH1j6aiSe13sYE687a8VewdquD7gQtpYoz2gUiSNAG8fCNfZ6B4cpNxSg?=
 =?us-ascii?Q?maxESXgjidDCjILyUhPJ0KjZkTBfBDfKP7QX69lIOVkqywLeQaX9NUonFeJq?=
 =?us-ascii?Q?hWQXnxEyLBFeOQE9W1v58uDlMt/jDI6FCMD7IwCTOF6c6NSSnb69QmBU8i9s?=
 =?us-ascii?Q?zKX3oBZKHSyoMbP70z8f5Iazh1TpX8xcbDCvPsHlkVgCFPBeDaL12XxTzljy?=
 =?us-ascii?Q?FipmFWJHLbQS7RNFAu1p4lBv0rmjks/vSXzTYLXCfGqs7MhbGjMFIYc8ALIT?=
 =?us-ascii?Q?658y5s/1FfEp1FbrVlJjOqkgJV0b0AIsmeXqxxJKEKKQLCh2+VehiSC058mv?=
 =?us-ascii?Q?DdvVchVelAoVqddwEc5n1kC1puv0dd1cYSn7t+zpRwLVoBV/OXNEFkXZ/SW/?=
 =?us-ascii?Q?sZOcOdBUR1Z81+FXrBvUYPaPXzCGJfGKDzy+D2EVF0i5ru8PgHxIgGHSabQR?=
 =?us-ascii?Q?DoxVjIvukaFfQnjZF1mQUV69rsy6n2tnahCwDHm+DDA8zNCSrX8bfydKfTZM?=
 =?us-ascii?Q?lIlYxV9NK7gWsAbj2yedZUjRCrmZYNL1WubO1b3T3sOtMLjkk0whQ79cYiyy?=
 =?us-ascii?Q?yIR/qEnTh0Kx6qDKkSAlObz6zPj9twLLa2fV1/AalShY8xXW+CqC68guAWGp?=
 =?us-ascii?Q?mnO/8KjonqC3VKnkwk76yG26njDTEsJdb98EaYPRuzHeemHOTU/9cJWwTthO?=
 =?us-ascii?Q?Bki0gkta0O7pIuZHWKEuhDt8W642YGddJ+A1Utf9sYzsgCxnbHxKctWBUP+1?=
 =?us-ascii?Q?l/Y2lN9o8B1kbhwUUlU1hVZ58wz2UnNF9+eEvJEbMrO2OCWWrCC6UBcGCTRq?=
 =?us-ascii?Q?sre2E1UI/tF5R5QzKZ3KqL5Q7ZVm3z4AK9uBCeMOOyb8eIVHUFSiHZYYmsS+?=
 =?us-ascii?Q?i6BfTaE2SB+MsWiBqiOCJ9E2dgR9DiKFb4DXMdlkMxZxmu08RxC4ULVjVOM5?=
 =?us-ascii?Q?BZOsAuNf8Nj1rvOSOiUF9ZjK7hEngI8meKjbFI5IoCjeoCyBmumKqsWAQJDO?=
 =?us-ascii?Q?XgtAxzrZX1rbS2Gq/pxCySrcUSbSKG0NDyDX6sfYfo0xAXV6wqQ91QNMe4EW?=
 =?us-ascii?Q?ySKAWlAgNFf/f4ymTQsN4WDUMAu4GZzP5aRxWc/IiBspAq/M5ALh4uv+mmiy?=
 =?us-ascii?Q?CLaDG73hhfWEBWl0GtOAczqNh9nC+zUUSGvah61F3ptmr3dzjpz6IEwPZ6yq?=
 =?us-ascii?Q?BVaG+Y/ww69R5O41tkXwZ9nqLF8T76RuhgpUfSlGi+j5oHJDFS088RqM/mbK?=
 =?us-ascii?Q?cXDhUs4vpMf+KjI+yTXHviUZBIANpxA6GfeYyUCAWdHO810NQsrzTJDfky6a?=
 =?us-ascii?Q?//5icnCJsR6XdSF1ET5+Bl2AgbYBNKZgT7mm4zro3AHH5hev0Z+UMyOlANu/?=
 =?us-ascii?Q?hPpznbiKyVL171Vgnb7VgsF0fHdTBzTDKOiNyUgxusXT7Z9mbIb7kXfF0iDr?=
 =?us-ascii?Q?Hrf4a33yq8duoIAXufb68jjiywomlU5UBA/h1r66qXGgHBYOScpLCJY8DUQC?=
 =?us-ascii?Q?esLjGwlFxI4tBnKMw67sVA1pUFDdc0Ja5ryU+7S7U138rqPH8usXDGrMGchJ?=
 =?us-ascii?Q?fIffeiL9sgCCcHfFuedZ0jSOh60rCKX8qAvJTAbIRzbj6kNf1ybfHUT12qvH?=
 =?us-ascii?Q?S58S/p0HPdOfI5lu9mZqHJ84iX2+2u8EeQSXZjMw6DgqC0UXOgq/BeJbltuC?=
 =?us-ascii?Q?/jW5bCoxXwSzhYQz40qTy67JqvL2k87K0hBWTVJAJ2O33egjcTWX5PpMZd5C?=
 =?us-ascii?Q?optuplcWBr4Odrfd2sNEGCJ1PUvougE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uRMfKYD9S/lnBqBg+Oq1RU530PwLIinVMR/xKRMjp2G7ciSZYGpuFG7hoe0k+6z14D25XX9cWmIiiTXFcem/gj5hzYsfEUVvwamXk+mY1WlaCOuPl3lwEta7ajJHugP+kzy1dIzlThlxR/+X98Y/4w/ZWqyaxvX7oohzTXLgVqsJbymmEkkf0yKruH8laajVCHdYBbmoBLTh34Y7OOw2F435jpMzpfFv0TnthNOE4kDYlrZ0WpjOZ5r7Zj47+jX9ttCXvrxWCyj3S8ZB/ccR/z5OgW7ZEV4Ld2Kf0yCle2vO52DsjTmOaQHGODGUq2hflQS9XLwZpnFzhFeHSwgfXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a75df8-6997-42ef-12c4-08df18f16ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 21:35:33.4369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rLZ0JvQSmg0v0bn1pjo/fo0xnaZg1xMpPy/X3STSxGI0kEzphYY/rB2I0AQmf+VfwBM4Iv8TAF8I/9Rja1u6Es19eB+3cl4Dj9n4C+xT98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

>From: Petr Oros <poros@redhat.com>
>Sent: Thursday, September 17, 2026 9:03 PM
>
>The SMA and U.FL connectors of an E810-C timing board are routed by a
>PCA9575 GPIO expander, and ice_dpll_init_info_sw_pins() reaches it
>through ice_read_sma_ctrl(). On a board that carries a CGU but no such
>expander the netlist lookup fails with -ENXIO, which aborts
>ice_dpll_init_info() and with it the whole DPLL registration:
>
>  ice 0000:cc:00.0: ice_dpll_init_info - fail: d->inputs:...
>  ice 0000:cc:00.0: DPLLs init failure err:-6
>
>Userspace loses the EEC and PPS devices, every CGU pin and the recovered
>clock pin.
>
>The netlist describes the mux with a clock mux node, which
>ice_init_feature_support() already turns into ICE_F_SMA_CTRL. Key the
>software controlled pins on that flag. Without the mux the SMA wrappers
>stay inputs, the state the mux path programs at init anyway, and do not
>advertise DIRECTION_CAN_CHANGE. The U.FL pins are the other leg of the
>mux, so they are hidden, and the outgoing CGU pins stay visible as
>REF-SMA1 and REF-SMA2/U.FL2.
>
>The layout is not exotic, the E810_C827_SyncE_SFP_SEC configuration in
>Intel's 4.80 NVM package has no clock mux node either. Such boards
>worked until the SMA and U.FL redesign moved the expander access into
>the DPLL init path.
>
>Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
>Cc: stable@vger.kernel.org
>Signed-off-by: Petr Oros <poros@redhat.com>


Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index 85a74cd6ea1f3e..e0362b6bf332e5 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -107,6 +107,9 @@ static const struct dpll_pin_frequency
>ice_esync_range[] =3D {
>  */
> static bool ice_dpll_is_sw_pin(struct ice_pf *pf, u8 index, bool input)
> {
>+	if (!input && !ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
>+		return false;
>+
> 	if (input && pf->hw.device_id =3D=3D ICE_DEV_ID_E810C_QSFP)
> 		index -=3D ICE_DPLL_SW_PIN_INPUT_BASE_QSFP -
> 			 ICE_DPLL_SW_PIN_INPUT_BASE_SFP;
>@@ -1213,6 +1216,8 @@ static int ice_dpll_sma_direction_set(struct
>ice_dpll_pin *p,
>
> 	if (p->direction =3D=3D direction && p->active)
> 		return 0;
>+	if (!ice_is_feature_supported(p->pf, ICE_F_SMA_CTRL))
>+		return -EOPNOTSUPP;
> 	ret =3D ice_read_sma_ctrl(&p->pf->hw, &data);
> 	if (ret)
> 		return ret;
>@@ -4510,9 +4515,14 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf
>*pf)
> 						  true, &freq_supp_num);
> 		pin->prop.freq_supported_num =3D freq_supp_num;
> 		pin->prop.capabilities =3D
>-			(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE |
>-			 DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
>-			 caps);
>+			(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE | caps);
>+		if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
>+			pin->prop.capabilities |=3D
>+				DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
>+		} else {
>+			pin->active =3D true;
>+			pin->direction =3D DPLL_PIN_DIRECTION_INPUT;
>+		}
> 		pin->pf =3D pf;
> 		pin->prop.board_label =3D ice_dpll_sw_pin_sma[i];
> 		pin->input =3D &d->inputs[pin_abs_idx];
>@@ -4526,6 +4536,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf
>*pf)
> 		pin->idx =3D i;
> 		pin->prop.type =3D DPLL_PIN_TYPE_EXT;
> 		pin->prop.capabilities =3D caps;
>+		pin->hidden =3D !ice_is_feature_supported(pf, ICE_F_SMA_CTRL);
> 		pin->pf =3D pf;
> 		pin->prop.board_label =3D ice_dpll_sw_pin_ufl[i];
> 		if (i =3D=3D ICE_DPLL_PIN_SW_1_IDX) {
>@@ -4555,6 +4566,9 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf
>*pf)
> 		ice_dpll_phase_range_set(&pin->prop.phase_range,
>phase_adj_max);
> 	}
>
>+	if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
>+		return 0;
>+
> 	/* Initialize the SMA control register to a known-good default
>state.
> 	 * Without this write the PCA9575 GPIO expander retains its power-on
> 	 * default (all outputs high) which makes all SW pins appear
>inactive.
>--
>2.55.0

