Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793261397;
	b=MD1Ayotf1FVfk32DLrpRw3iKEczdp1ygbVs5ceg+LkzooD8l7WyufG5BShvmKv80+uSS
	 YyfO2YsT6v+6nmeulwFGhlQtGS4owH71gznPbM6RCjXQe84Ut2RsSUhNQLzjTlYH3Pmtm
	 PlK0gDCEPUX2v2z6rc9cRTXD7Wig+zXECalNvepf6LIOyBwujCa6xgLmsYSBAHGvkbVA0
	 97A+ZOzKNnnJ8XtB8hiQemtGZLmtsG8ajd+a+ljC0AFC0D0ZmmVP6sPhrMQtIb0boa+/F
	 GC6eJ5r/0HfRpBtvO6FxYoXS+FxwbA77ooE5Hn2MC3PAPto8PiscE0Bz2eEQiMXYnbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261397;
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
	bh=adkbwkZy4HMlHTRYepgztUmTaknLMcn146rUVZrZY4c=;
	b=nP8fAW9CVZdN+ZG+jUrONujYfNQVzh3jreQAWTVcrU21VT2KGcUDPWr0O9NFjOmxKHdb
	 nRRWN1/V1w9hZq3T3qMTel+SHlC2hCG89ceE8l6ZGX2XcdUl97Ty72wFzYKaR0QXm/X1F
	 vKpzAkCxTRLOGj94SLHwF7kXCGHfD3FJkdtDKyTmollHsaim9ISRczPt47uQvWSEbkKkM
	 GOZyEr2dkXN7d3yVEoAEplTo80R5C7khS/J2RHiJ+Y8Il0Qokw9Fnq/3ZTa1MiXWzyz13
	 vuxa9G9CB4bPQrBxb2dR3lEVFq319ZSFG/wNdRUETuevNTnDV+rTpTnFpcF3I6Y6GxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="R/I5ZBM9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2D606A31A;
	Thu, 29 Oct 2026 08:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R/I5ZBM9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793261397; x=1824797397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=adkbwkZy4HMlHTRYepgztUmTaknLMcn146rUVZrZY4c=;
  b=R/I5ZBM9AZU5m56fu7Y0uSA1ZfgYHsptianazDAFz3qyeneDDFYl8eMu
   ceFML0WtJrNWbHgLK8GocU6dGMeHgAi+jXR7YYvzzuPTV1PUZ/D2/qRin
   Awe/SPusJ51iPad314xakG5eJLUxl23v3Zkm5XTNrgASJt1KzfW0ZYpon
   IZ5gqfOp3zJB19oys9w5GTJp7HHXwN5rOLl+3DnLPXGZWY3rTQgC6Sx+g
   wT2aS+KQKjPxyXSmx+NvsmfyttajIbFmnXRPr4B5E51rMrPJHARXVS6Ua
   L1c88c/jFFo0uslJ1DXURyM4/4rKP18I591gSOdaCpv9c3xsnbAxv4W6j
   A==;
X-CSE-ConnectionGUID: PGxP1kl/Rs6/SOF1J8hm+g==
X-CSE-MsgGUID: Jan91YhuSwetNck/5vPcTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2012653"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2012653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:09:56 -0700
X-CSE-ConnectionGUID: 732dlg22Q6Omka/OG7F1nQ==
X-CSE-MsgGUID: s9O6hQrwTvWnYf9TbXFBlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5410252"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:09:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 01:09:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 01:09:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 01:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pb5T7hacgi9F5aPeJMvPM3BtcwUlyFdIl/EcuqxJ2OtREPXxDqOptKPP5mV/Tj1zo3NCB5l/5eGTB2xXkjI7DGcUOHLw4SfTOLjhG0QaYb18YvKzV+bmLYDzLzKlv48nA4636MXIqXi4iy4dG4Sn2WrovJVCyQcbqmTe0fu7ts7hwAIhVDuBo1IGjpcgQvOi0giN0X6eKDdJXMiVC5nhqpzha6R783wSBLHXJ04r3ifoRL16LuwJW/A6VFtE58I70b/fNGsL/z8FwM+rdROksTIpYAEGjmczttCVLcEDKz+jLKh/xmsVmrtHCf8iVk7uw1Luk6PB57R3AsQzZ85ygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adkbwkZy4HMlHTRYepgztUmTaknLMcn146rUVZrZY4c=;
 b=meVLT75u+yL+CnrvHcjQI218hUctskoilkqUWF2UdcO6PtQnXcea7uZJWDDME8pWXXZNFXLUNtjGxefoWaprOt3LtmIkF6tbw4VHpSIJpzxXdLVxun7tw674X4aqOl8ImbW62n7wfs6FbF+cp+FHV1V7ZCaprxrLFrHFi5AMmgLutKgqwMbYTzVGUPSApL/UoY9h+YGqLM9fO58Q5uOTimeR05KaTMjzYmpJRxB1/PMmr4nXt0qKN/RY4Vv189qNXwe3G+z6wkymspIsy+LjnPfJKBmODL41qED7JLwv4Ht1tKoyj8rWXNnvlv52m/zzW8pwan3ksGyp1TcUQ77viQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SN7PR11MB7092.namprd11.prod.outlook.com
 (2603:10b6:806:29b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 08:09:46 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 08:09:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Paul Moses <p@1g4.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"vedang.patel@intel.com" <vedang.patel@intel.com>, "jithu.joseph@intel.com"
	<jithu.joseph@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "andre.guedes@intel.com"
	<andre.guedes@intel.com>, "Dahan, AvigailX" <avigailx.dahan@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v3 2/2] igc: fix AF_XDP receive buffer size for 2K
 UMEM chunks
Thread-Topic: [PATCH net v3 2/2] igc: fix AF_XDP receive buffer size for 2K
 UMEM chunks
Thread-Index: AQHdZrdPGMywUJIelEeTcjn4CrIrQLcUKm0g
Date: Thu, 29 Oct 2026 08:09:45 +0000
Message-ID: <CH3PR11MB566895FDA70020EC1BC59BD531E56E2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261028083344.3047350-1-p@1g4.org>
 <20261028083344.3047350-3-p@1g4.org>
In-Reply-To: <20261028083344.3047350-3-p@1g4.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: f1a261a4-3945-47d4-9220-08df3593fe6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|38070700021|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: FoCVXt1RyO3APAeGzmk1fnZzClJkdXmSvYAx/1Ruhn9y8EH3DiUX5gqAWl/blrKC7XmAUSSkeeQvCtAZKoNWMWJaIQFyFqiPLokuQAH24wHNFab8O1sXcVDRR+nBloID3BvkmYbPElEJGoLdQy3y1NmGMjRPSKZlBj+FKEy4ZYMx6CoI7omkmOVzeS9Ov4Zb4BHJFLDFJKyeafNfJFsW5SGd5rAIRWExNrH8NWlT97GkO4fpe/jzxf9T3IHOsNsKowWB3sucFGMvRzJASyLZNh5C6SKj73bqtnnCY63JIrqeF6doodMc4qDpmsL4ATM7Sr2/YOU9ehmsmsIVqwqDPI39PSd/kW3dDwjrU401YO3UYKzvP6P2EYoRMAb51mFQBVr4kmlOMu5mKrMXMHNJSpstAi96UPtS5eylFsS40fvhkjoCZT1SnVrrmHdmHbH0Cai98pz8U5PuOVugWeotnFwrS35lmTprTTgKbKnj7eSCkksNKOcQeK3v7/CpQ45P6Bwaf+1PFD1MRqn2Iz2Xy8HujrQ8Y8hUFjUWJVuwhW8XYA/N3jDUx1PJ2nZcw5/LApqNEkKCOrBObRatHYH98Kmd9vdBVbML9+5SWxEf+gPvDnXIwGnApFg48ONaPbvvWqRUASCYqyOWfeh0o6/FUqiYTFtR0LmStR6lCcddC5EXBE32aLesDxScmLIJ+ZwEVrPQ/r4wtr/yzpmVdXkaHb2g2K6b0yPf36orNADZmI4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjV2cUhRdjZoL0tENmZUYWFPRUdvTEVISWxtM2QzazAzR3p0VWhZZ21mTXFt?=
 =?utf-8?B?aWRIUkRLTGdVd3dEajBiMEd3MUZVQWFIN1gwRVNpRFd3bEVieVNuT1lyaWdU?=
 =?utf-8?B?a01kazJkOUU0emMvWi9raWRWNTRaT3hPQkxXam1DcllJSU9FOXErSXpJRllh?=
 =?utf-8?B?OEVza1hkVGJTT0tMMTNLL1lxSEJPT1NoVjdzVENoKzZ1OUg4RlZUSGxEd2xa?=
 =?utf-8?B?VzluZGY5dFd6dytYZTJwY3UwOFM2LzRuSENxSDZWOHBWb0JvM2NvOTZCaXo1?=
 =?utf-8?B?V0pTNk9FSkRRSGlBZUZRVjlxYjkyZDdkVnNUOGNqYlpSbm0wNEdaT2IwZjRl?=
 =?utf-8?B?SkdrOEJvaVB5Vm5VSWpweEFsaUhNaEIwV1BHUnZFVXRrUzhVeElBRUUvMisv?=
 =?utf-8?B?ZDBwUklHbWZZU05HNyszL3JXcitkNzJRZzhOVGVIbnZGbk5ZdTQzem1EbGR4?=
 =?utf-8?B?dDVUekR6d2oza1M4WnNFNm5LZ3g0MEMwZXVrMEVXK3hBTjZEM25yWFE3R001?=
 =?utf-8?B?eEpveHQ3YXpwT1BKd1c4dXE5WllDUzdxbkU5QkVHU1NGYlhKckRxOWpQVkZj?=
 =?utf-8?B?cEhRalhoS0JRUm15cFQwaVFna3V0M1grSnE5UXhrQ0tBNHBoZEdUbjhUbkMz?=
 =?utf-8?B?QjZYU1hkdFVyam1HbmJMV0x4d2dLL3ZXbFNYK3hPKzR0YWJYK2Z5U2Y4aUlx?=
 =?utf-8?B?UzZIdE4xWDVZWWYxWEVZeWlwMU1wVEtHZDZOOWRYWGMzTTdpYTE2NDRRNVJK?=
 =?utf-8?B?NGVOSWNDblEyLy9uQzZaTlhCVGRvQ0c1MGFGQXVnSFBRZEtSR1dRMERjU0NJ?=
 =?utf-8?B?ZjNpSjhlRnBTM0lIZVBqRTVwUTlwSzZJeWJ1RWVVUUtHdlB1bmZOTHBjOWR5?=
 =?utf-8?B?QVErMThNbjJ2SEZiMEZIVm5EeHhxQUQ1QTVCL3FvaVBPRyt2U2w4U1dnZXNz?=
 =?utf-8?B?azdhaDZ0Zk9mREMwUWV2d3FoUDFlUFlrS2g2M1RkVHd0TStacXluNjBac1Bs?=
 =?utf-8?B?ZXZ2Z3h6b1hTRnJCQjV3R2dWZTNwNkcxZndsMEtzQ29raTlpQmIwSlFSWUtZ?=
 =?utf-8?B?WEQ0Q1dVbzJrQUprZFNyT290d2pJWHBkOENYdmtIWmlpNVV2NHJrN21EZWhp?=
 =?utf-8?B?enZBdGkvcUlkdkRYWkk4eXhsemNsdVJnNmIyeTNKVzJWUTA0U3E5VkhZNnU5?=
 =?utf-8?B?ME1MczZBaGR3eTh4OWJ1V3JuODI1ekxidlUxeW9jcWlHT0tWTzBncEtEc01T?=
 =?utf-8?B?NUFZMFRpeTVTeFArMGc3aVphS21uNHMzM01PUW5CazBNSlJ2Nmk4VnNBTi9Z?=
 =?utf-8?B?bUpUQ0dBWEE1VUFtU244RU5RM3hZTW1CcGhla3BIVWtOWkd6eW9KSFRUSFZG?=
 =?utf-8?B?NDlkeUNjRmgvUU5YQW9FSUVLV2REcDVtY2RoYTZjdFpwcXcrUHY1RzlpWUl4?=
 =?utf-8?B?czhTbmZqRXduUWplczdib0VhTDFjVHd3SU9VZ0w1eVd6K2t0QzNheExHTnFW?=
 =?utf-8?B?UDNBOEltT25MTkJETGZEVmc5M2lJLzNRQ1RwMlhsM2pQNm1zbUdycDFhcWlX?=
 =?utf-8?B?ajhjTndxUmRzcVpPYVdlb2cvK3Q3NzduUGp2TWg5bWZucDA4REY2Vjl4Y01a?=
 =?utf-8?B?YmdBZlp3YTh3ZDAwTGx2dDlMbS9MaTVpL3ova1hhdjU0bWdobExtM0o0UFJv?=
 =?utf-8?B?RytqZzFFVzJXWTZVK1dZWkw2SEZ4blVxYWpaY0t2YlBxYVlaYjFvT3BjOEll?=
 =?utf-8?B?V2doam5oQW51dE1EemIrMndwZTRIdGQxd2oydnZIVWkxRkl2VGlrZ2E3cGNC?=
 =?utf-8?B?Slh5WjZodUxBSTZMSmNpemkvdFFjZkJoNXc1TmFCc24vZVJkN3VOZEJrSWc1?=
 =?utf-8?B?dTJ0VkNFcUorcE1ZTkF5TTBpN0hxa0NkM1VLVndlSlM1RkdlNVR4TGlhb0Za?=
 =?utf-8?B?OWlkSjRZQU0wUm41MmJQQy9lc0FEMkJrZE0rYmN6VXpPUjBGbC8yazRRN3Na?=
 =?utf-8?B?ZzRKODc0Vmg0a29CRWVtNGlJVm0vdUo0ZUJpYnlwLy9xVzI2Vk4yWDZtblc2?=
 =?utf-8?B?MTI5VHFtUGg1ci9NOC9ZemFybDFKVmk0bndNcEhTNER5aDRPTGRBVHpYMkpu?=
 =?utf-8?B?dXQzOWVWbklrUFh3MFI4aWMzbnVZTFlJeW9oVUs1OFg5ZnN1RzF6OXB5Z1dE?=
 =?utf-8?B?eUpPVUZsdjJteUFzQm1VeWVkTEtXM3NZQkxrVlZPblRudjIxRHVTM1RHdDFE?=
 =?utf-8?B?ajh5dUVHMWRSR0xyZG00WURRZGE3MzNtVlZpeFU0ejdocWNWUURCeCtkSDA0?=
 =?utf-8?B?TlRZTUxGODcrL0IwT1h3aDdXUWR3TlVEZzNYMHRCV1o1ZkhnMzlIb252Zjl0?=
 =?utf-8?Q?KM94h8w5i96wK9ac=3D?=
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
X-Exchange-RoutingPolicyChecked: K+gyy8ac4cxR8U305dxPe/eTNrbQE+SfXEsh1VMxAGG3PhneoWNKGO7KaQh2JB/k/PBJd1rbWHfXOM/zen7ZcAwAOX2XV5gCIDlPEi6AsZDBSHja9+84ie96gjCpVcA0MF3/5MMQWxXYOiKhikrcZwVXVQATOjU8cI3TEnviLPCDPqWyAcGXwDlMlTPNrj8Vj1n/fb+hsAItjZFhXSHOJD5RzVPh1B6obtUtMvaP9tyNXuz+C4pl5E0/YpkqkzywAQgEtkgmnc7KsXGjIyRYuX1I91ijF2gMn7BkYVYyDRkFR1lHttQQlg199ZiUnFzN+/0bFefyELbpxdOzJODyMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a261a4-3945-47d4-9220-08df3593fe6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 08:09:45.4130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEKXFlq3fCA2Tg7T4aYhpqraOgp1zkdfF0RjHbsODGzIIAmvCq6SUsr0wMwE2UtxbaIJie8vkPtYssdtkrT1Ksz8AMGNixafM6+miq/rmWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNb3NlcyA8cEAx
ZzQub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjgsIDIwMjYgOTozNSBBTQ0KPiBU
bzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNv
bT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGFzdEBr
ZXJuZWwub3JnOyBkYW5pZWxAaW9nZWFyYm94Lm5ldDsNCj4gaGF3a0BrZXJuZWwub3JnOyBqb2hu
LmZhc3RhYmVuZEBnbWFpbC5jb207IHNkZkBmb21pY2hldi5tZTsNCj4gdmVkYW5nLnBhdGVsQGlu
dGVsLmNvbTsgaml0aHUuam9zZXBoQGludGVsLmNvbTsgRmlqYWxrb3dza2ksIE1hY2llag0KPiA8
bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT47IGFuZHJlLmd1ZWRlc0BpbnRlbC5jb207IExv
a3Rpb25vdiwNCj4gQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IERh
aGFuLCBBdmlnYWlsWA0KPiA8YXZpZ2FpbHguZGFoYW5AaW50ZWwuY29tPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IHYzIDIvMl0gaWdjOiBmaXggQUZfWERQIHJl
Y2VpdmUgYnVmZmVyIHNpemUgZm9yIDJLDQo+IFVNRU0gY2h1bmtzDQo+IA0Kbml0OiBQZXJoYXBz
IHVzZSAiMiBLaUIiIGluc3RlYWQgb2YgIjJLIiBoZXJlLCBhcyB0aGUgbGF0dGVyIGRvZXMgbm90
DQpzcGVjaWZ5IHRoZSB1bml0Lg0KDQo+IEZyb206IE1hY2llaiBGaWphbGtvd3NraSA8bWFjaWVq
LmZpamFsa293c2tpQGludGVsLmNvbT4NCj4gDQo+IFNSUkNUTC5CU0laRVBLVCBoYXMgYSBncmFu
dWxhcml0eSBvZiAxIEtpQi4gV2l0aCBhIDIgS2lCIFVNRU0gY2h1bmsgYW5kDQo+IHRoZSBkZWZh
dWx0IFhEUCBoZWFkcm9vbSwgeHNrX3Bvb2xfZ2V0X3J4X2ZyYW1lX3NpemUoKSByZXR1cm5zIDE3
OTIuDQo+IFByb2dyYW1taW5nIHRoaXMgdmFsdWUgdHJ1bmNhdGVzIHRoZSBoYXJkd2FyZSByZWNl
aXZlIGJ1ZmZlciBzaXplIHRvIDENCj4gS2lCLCBldmVuIHRob3VnaCBhbiBNVFUtc2l6ZWQgZnJh
bWUgZml0cyBpbiB0aGUgdXNhYmxlIFVNRU0gYXJlYS4NCj4gDQo+IFhEUCBvbiBpZ2MgaXMgbGlt
aXRlZCB0byBNVFUgMTUwMCwgc28gY29uZmlndXJlIGEgMiBLaUIgcmVjZWl2ZSBidWZmZXINCj4g
Zm9yIFhTSyByaW5ncy4gTGltaXQgUkxQTUwgdG8gdGhlIG1heGltdW0gc3VwcG9ydGVkIEV0aGVy
bmV0IGZyYW1lIHNpemUNCj4gd2hpbGUgWERQIGlzIGF0dGFjaGVkLCByZWdhcmRsZXNzIG9mIFBB
R0VfU0laRSwgdG8gYXZvaWQgb3ZlcnNpemVkDQo+IGZyYW1lcyBzcGFubmluZyBkZXNjcmlwdG9y
cyBvciBleGNlZWRpbmcgdGhlIHVzYWJsZSBVTUVNIHNwYWNlLg0KPiANCj4gUkxQTUwgaXMgY3Vy
cmVudGx5IHByb2dyYW1tZWQgZnJvbSBpZ2Nfc2V0X3J4X21vZGUoKSwgd2hpY2ggY2FuIHJ1bg0K
PiB3aXRob3V0IFJUTkwsIGZvciBleGFtcGxlIG9uIGFuIElQdjYgbXVsdGljYXN0IGpvaW4sIGFu
ZCBjb3VsZCB0aGVuIHVzZQ0KPiBhIHN0YWxlIFhEUCBzdGF0ZS4gUkxQTUwgZG9lcyBub3QgZGVw
ZW5kIG9uIHRoZSBhZGRyZXNzIGxpc3RzLg0KPiBQcm9ncmFtIGl0IGZyb20gaWdjX3NldHVwX3Jj
dGwoKSBpbnN0ZWFkLCBuZXh0IHRvIFJDVEwuTFBFLCBhbmQgZnJvbQ0KPiBpZ2NfeGRwX3NldF9w
cm9nKCkgd2hpbGUgdGhlIHJpbmdzIGFyZSBkaXNhYmxlZC4gVGhpcyBhdm9pZHMNCj4gbmV0aWZf
YWRkcl9sb2NrX2JoKCkgdXNhZ2UuDQo+IA0KPiBWYWxpZGF0ZSB0aGF0IHRoZSBYU0sgZnJhbWUg
c2l6ZSBhY2NvbW1vZGF0ZXMgYSBtYXhpbXVtLXNpemUgZnJhbWUgd2l0aA0KPiB0d28gVkxBTiB0
YWdzLCBGQ1MgYW5kIHRoZSBvcHRpb25hbCBpbmxpbmUgUlggdGltZXN0YW1wLiBDaGVjayBhZ2Fp
bnN0DQo+IHRoZSBtYXhpbXVtIHN1cHBvcnRlZCBYRFAgTVRVLCByYXRoZXIgdGhhbiB0aGUgY3Vy
cmVudCBNVFUsIHdoaWNoIGNhbg0KPiBjaGFuZ2UgYWZ0ZXIgdGhlIHNvY2tldCBpcyBib3VuZC4N
Cj4gDQo+IEZpeGVzOiBmYzlkZjJhMGI1MjAgKCJpZ2M6IEVuYWJsZSBSWCB2aWEgQUZfWERQIHpl
cm8tY29weSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hY2llaiBGaWphbGtvd3NraSA8bWFjaWVqLmZp
amFsa293c2tpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGF1bCBNb3NlcyA8cEAxZzQu
b3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaCAgICAg
IHwgIDEgKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMgfCAz
MyArKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Z2MvaWdjX3hkcC5jICB8IDExICsrKysrLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMzIGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lnYy9pZ2MuaA0KPiBpbmRleCAxN2YyMTNjYzkuLmFkMTA2MmY4NSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaA0KPiBAQCAtNzY1LDYgKzc2NSw3IEBAIHN0YXRpYyBp
bmxpbmUgczMyIGlnY19yZWFkX3BoeV9yZWcoc3RydWN0IGlnY19odw0KPiAqaHcsIHUzMiBvZmZz
ZXQsIHUxNiAqZGF0YSkNCj4gIAlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICB9DQo+IA0KPiArdm9p
ZCBpZ2Nfc2V0X3JscG1sKHN0cnVjdCBpZ2NfYWRhcHRlciAqYWRhcHRlcik7DQo+ICB2b2lkIGln
Y19yZWluaXRfbG9ja2VkKHN0cnVjdCBpZ2NfYWRhcHRlciAqKTsgIHN0cnVjdCBpZ2NfbmZjX3J1
bGUNCj4gKmlnY19nZXRfbmZjX3J1bGUoc3RydWN0IGlnY19hZGFwdGVyICphZGFwdGVyLA0KPiAg
CQkJCSAgICAgIHUzMiBsb2NhdGlvbik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lnYy9pZ2NfbWFpbi5jDQo+IGluZGV4IDQxYjI5M2RjMS4uNmI0MThkYzcxIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPiBAQCAtNjc0LDggKzY3
NCwxMSBAQCBzdGF0aWMgdm9pZCBpZ2NfY29uZmlndXJlX3J4X3Jpbmcoc3RydWN0DQo+IGlnY19h
ZGFwdGVyICphZGFwdGVyLA0KPiAgCXJpbmctPm5leHRfdG9fY2xlYW4gPSAwOw0KPiAgCXJpbmct
Pm5leHRfdG9fdXNlID0gMDsNCj4gDQoNCkFsc28sIGJlbG93Og0KDQo+ICsJLyogaWdjJ3MgWERQ
IGxpbWl0cyBNVFUgdG8gMTUwMDsgYWxsIFhTSyBSWCBidWZmZXJzIGNhbiB1c2UgMmtiOw0KPiAr
CSAqIFJMUE1MIGxpbWl0cyB0aGUgcmVjZWl2ZSBsZW5ndGggdG8gZml0IGFmdGVyIFVNRU0gaGVh
ZHJvb20uDQo+ICsJICovDQoNCiIya2IiIG5vcm1hbGx5IG1lYW5zIDIga2lsb2JpdHMsIHdoZXJl
YXMgdGhlIGJ1ZmZlciBzaXplIGhlcmUgaXMNCjIwNDggYnl0ZXMuIEkgc3VnZ2VzdCB1c2luZyAi
MiBLaUIiIGNvbnNpc3RlbnRseSBpbiB0aGUgc3ViamVjdCwNCmNvbW1pdCBtZXNzYWdlLCBhbmQg
Y29tbWVudHMuDQoNCi4uLg0KDQpBbHNvLCBiZWxvdzoNCg0KPiArCS8qIGlnYydzIFhEUCBjdXJy
ZW50bHkgZG9lcyBub3Qgc3VwcG9ydCBqdW1ibyBmcmFtZXMuIExpbWl0IHRoZQ0KPiArCSAqIGFj
Y2VwdGVkIHBhY2tldCBzaXplIHJlZ2FyZGxlc3Mgb2YgUEFHRV9TSVpFIHNvIGl0IGZpdHMgaW4g
YQ0KPiAya2INCj4gKwkgKiBYU0sgY2h1bmsuDQo+ICsJICovDQo+ICsJaWYgKGlnY194ZHBfaXNf
ZW5hYmxlZChhZGFwdGVyKSkNCj4gKwkJcmxwbWwgPSBFVEhfRlJBTUVfTEVOICsgVkxBTl9ITEVO
ICogMiArIEVUSF9GQ1NfTEVOOw0KPiArDQo+ICsJd3IzMihJR0NfUkxQTUwsIHJscG1sKTsNCj4g
K30NCj4gKw0KDQoNCk90aGVyd2lzZSwgbG9va3MgZmluZSBmb3IgbWUNClJldmlld2VkLWJ5OiBB
bGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
