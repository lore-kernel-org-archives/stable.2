Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D53FD969;
	Mon, 24 Aug 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565030; cv=fail; b=BMOTpkViopp7xHx1pCw9phJlifTz31/bPAYBarOJhhLOqLF0ddsqRCzqzVKKGG57N/FoD3OSsfFnNbZoPmuSJPHV4gaNa+GlwjH6jEhuC0wKqUJITRyGucg1UA8aglgTIUgsC7UyFBHco6SgjWC8J/QfH+y87//m9G7mEj2Vt9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565030; c=relaxed/simple;
	bh=KC9giAa8CS/kgz9OQ3mu0QKePTLWg/8NyuBXEmOspCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WuL/Vxq7dIO4XJdG5NAcbuCO9lfijYkOvJMansRDTITU+sitKSeGT2adi8Cjj0VJV6C5fcQ2oD4tlOvXGyVlCLf/DuXfrPDErsUxab5OxYdKuZP31buDnona6bff9Vffkrf+hGVsngGr+NYafI94i9N9TaD8dHhxaj0CstN1vHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjB65yVE; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjB65yVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787565027; x=1819101027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KC9giAa8CS/kgz9OQ3mu0QKePTLWg/8NyuBXEmOspCc=;
  b=XjB65yVEon/dpcQnLuL8U210cJxUeaUFYAAnmb2eJr5Bqf/QzxrMADPo
   3ajIKzBxMMfhWzKwI/hLeGzWQxiKi4rI9HtXXvZc31iGFHyjYhVzvWwKj
   z/wFEAG5UieeTtQhsmiG03HQv3L0UqN6s1l5E3y7SrQlS2X7xNIpF63eP
   IGXXwyG9JK2TGMhTp3mYurzNapbEMLCWUADkP8MJde3pFg6ORtWeIb/Lk
   xSDaDBEso6jXjXrRC9m4olVkT+4xds9rAyMdbBL1zLo95TASd+PL0IiNa
   U1ZrjylJsReLDZBV6lyzQZdc4pwEI9CHYVzN6TJLJs/mFgxTkEZSmbhLq
   g==;
X-CSE-ConnectionGUID: CBCjO4yeQiCQcBZiE0KIcQ==
X-CSE-MsgGUID: 1PO8+zm+Tly1AYmhYM8wug==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87882106"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87882106"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:50:25 -0700
X-CSE-ConnectionGUID: +ZS1HNKwRlWFmsyBv2EZkw==
X-CSE-MsgGUID: GxY7nNpnQ5iY/C7IW/g9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="267527132"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:50:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 02:50:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 02:50:24 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.39)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 02:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXmER5w+kFWLyUDTPByFjY7LZ3YcV64HGSizKczre/nKyvXUjXUBNeUBpM+uJKn+Vlv3n3djj0xaNf4wkVjoTa18KEtLfWIiE/qsgGrS84HMJEBtCxxlgKXwfa2LNeocw1qPFH5+73RA/prK2+ApIiixap9ufzQ95mnoBratFxoFSpvClXNUP5ifgaLoWZmoeoKJ6pGnkSahfbB26Sgl7wvHjkj0qA6oja/ci/L8otRhtBOsVvAJFFRXr0MJhAlOStmTSP6vsz4b28/SfTjMgGObn0Ey4t5VZWGpPHH62uiSyUo0k/hWKGkvQDnnnzZGTLcaWtKR+BBTfKg8+p1FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC9giAa8CS/kgz9OQ3mu0QKePTLWg/8NyuBXEmOspCc=;
 b=JHEqTvn9DOQdHExax8WDsvrjRvV5P3iSOG1bFeVFjyWKa5UBYokMJZUL4V92xR8EMcgr4WvSj59FaGegrBr2BDK8OSqp8HYekZocTmb5laz93RwXoMT0E+ckUJoRUtqsTLYZ1eb4cxyUT4ZfMAY+cl2mpckjfbMhIWz+GjKRL40gM1t8+acbWsiF/GfTLCGfvJR+5C+QRayLIjEc3G07zsSodq37XGd4KzmW7T6b1n+bcTggblFtGlS0VcGd3ccPl8eXSfIMM1tufBJ05zy/dJ863InaLLH6vJ7Nno0BuUyvIURiBkRWnjZ+qyghFwDjQNEVskOH58miN/CHA6LeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:50:20 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:50:20 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"nicoyip.dev@gmail.com" <nicoyip.dev@gmail.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
Thread-Topic: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
Thread-Index: AQHdMmjapMAXKduoRUK1jQB0aFBoqras9x2A
Date: Mon, 24 Aug 2026 09:50:20 +0000
Message-ID: <f4acaeca72ee48625798869d02b3edd2d189603a.camel@intel.com>
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|PH0PR11MB5016:EE_
x-ms-office365-filtering-correlation-id: 89416610-1c7e-4e0d-a7be-08df01c51c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|10067099003|6133799003|22082099003|11063799006|5023799004|18002099003|921020|38070700021;
x-microsoft-antispam-message-info: 8NCwz61VoCmSrLyuX2jSjmeVODHJKL27qgKdir8a5vaMjMK0j0M4pCOQo4My8AdcS1oZ+ovs+VsXM5ThvNnmBHJj3rLqp6x1Wm8dRADey/4RMnhb5lbwJ4cNYAiflqiY0hgsmZv5zrj+j29M9ACknE//D68uwzdkDZFnWNhM4PFl/9RbD6WcXcDAX4ma2WXrDKyPAWPQo4jXYpDxOjcPae84P4VMzeFKTRYF8sHBf4pOz4kGx5ugwkZUXU9spnopDtRJjyHCG99HJL2PmtOOL3GFRTCWOLJyAkqy63gMNCKtV+/cb8xAUX0YUD2rBUxX32XrLPYgvMRp5ef4dSLPmX69P8NPRaODg97sORCCNLCPhNtXs2brbOeRSTrYmECxAqghoZgsoOaCo3SZYw8ehulVK65NteSP7v5D8T5Pe3q0f/Rx0KudSwIOKn9KgTTECW8Y4ZCK4j4VJvUpuO9OZXqEpn173NOUnxXTz0ZzRTyqyDRJpgjFKmA9T9boAhWxcCCz1MDqNOBY/ab/tPgRC+7s8hixKKAwt73ZYx6HhDZP+aXRiQDD33ZDyefhkIjsfUBonPgkD8mC5TSn06mNxcSmTucniqNvN13bsCyEoXTk4TiVY8ocDg/ojhR4iPtovJuZ2nhBknA8VB74fTbWBqCRbtOnlP8QxAjafyFg5uxYHqFoGKIKv3bkBU1TH9M5f0jaUlvYsCkqIkw5/6W98AHqq/bVaqF/CMEB+Gf8AGyWU3DyvaUL6Nxd+IRHg+jz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(10067099003)(6133799003)(22082099003)(11063799006)(5023799004)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjFZemdaa2pPamwrbDVXWFRRRkNnSlpPdmJqT0JVam0yckMxSElYY2tjTWNU?=
 =?utf-8?B?SitFb3lCS3NadmhGQyt4cGtVOWorYm9Fc0xOWHkwcVQrNnMzYjZTVUN1MVZH?=
 =?utf-8?B?Y1hjNlhNYVlzUTlpZE1oSXBCRmd2VTNCSkxrM2k4OUpPUjY0Wk04MTdNcExX?=
 =?utf-8?B?K0N3UUhmUEs4YTdBdk8zWnFTQzhBbHZrdG5ZWmV0WlJrdmNhaUR6cldaRDhX?=
 =?utf-8?B?OXJZb2RmMDFaZFI2UUJwdzB6SGcvR0hhSTVzdUtlTHl1d1FITkFIMkNaM28y?=
 =?utf-8?B?Qzk5c0VZVCswOTVDVTlTY1dMWTNyM1ZUTHM4ZkZybzB2d3hGT1lTcU5FbzdL?=
 =?utf-8?B?YmlVWkJ2d0R2K1ZLcXF2UmFDYlE0TVA5T0JNdzdTSXUzZGttWFBWSUcrRjRR?=
 =?utf-8?B?bElpdmRWVndzYXNmdzBOTjZuRGJuN2k0TUpOL0RsQzRrU3JJb1U5QUxNRlNo?=
 =?utf-8?B?QW54TTNDZEgzRkdvVml3VHVyNVM5blk4VDRLeWpQdWVVdy9KdGFsNFdiMW9u?=
 =?utf-8?B?ZTBaeWkzRGZWK29JL08wVWJvbnA0WWZBU1hBTTN1N3RSQ0hvUk5jNUVURlNW?=
 =?utf-8?B?WHBZYXFnTElEY2pZV3FRaVdJTkFneTdjMkp2OEpaK05ncVlDb3JycTJ1VGxS?=
 =?utf-8?B?cC83aHhWVUJBeXVJaVFaelZDL1hNTGpMYW9NeTRLM2ZIZlg2eTRFZ3htd2xD?=
 =?utf-8?B?TVlnN2JTTGZQNytMS1BDaXF6WXd1cHJUU3llYXl3TVlUM1dqeElsYUxRa0Y0?=
 =?utf-8?B?bVUyZit2WUZZNFovWDZKZ2h6S1NhZXg2Q1Q4RzJiRVpJWkpRdzBvdldaZmJ1?=
 =?utf-8?B?NTFLSWhlam9NR1U1bU9uWnVTQWFIVUkwaU1WM2JLRmFIaHkvc2ZUVlBMT0tt?=
 =?utf-8?B?ekFqLys1eXZjQytLMjdTQ0tHR05TNFhKcXVmeWJhd2d1anVOYTNORkVxcmJN?=
 =?utf-8?B?T0IveUxHbVJxQldWSlJ5YnN3cjQrRkpiSjdmYXdNcUVBL3JubERkVnpwcndR?=
 =?utf-8?B?c1d5VUlMZ1dZbXhMd2hHUklLSTJWSHdHYkFsWjlvYWtEY1RvTzZtMkxXck9Y?=
 =?utf-8?B?TU8rNU04TlFGcWxYZlhCc2ZTN2UyMm9iVlQydG82dUhkVnl5eXNxTGNZMjJt?=
 =?utf-8?B?QmRIYVBJTCtkTzFYQS9MMXlkUVJrWlVIN2pvVE1tYTVGQ0Z2dHNxM0dqSmQy?=
 =?utf-8?B?aTFKRUw2UFB2NnBOTlJxQnVURHBrYldMbXRIQ1hBdkw2NmNUaUNmY2QvYVZi?=
 =?utf-8?B?Y09DdVNqNjRjSHlHZmtib0N5cURvRkhuOU42L1FvWjBsOSthTTRPUkxUN1c4?=
 =?utf-8?B?K05VUEhTNEJNT0Uzd0dtSjQycGdRZmM3NUdVRE5ha2s1azR0SFhtTGkxR1I5?=
 =?utf-8?B?d0x3eVlTQ1QyMHE5aGVpQ1FzNE5McDViYytlL0dsNXc2a2pnMyt6WXRWWVJF?=
 =?utf-8?B?dGpwWXE2NkwxOFN5ajZlOFBTNmd4TGx1a3JxSGlmRnJpbnJEREZHWGtiNVo0?=
 =?utf-8?B?QXpVYzZJMS9PbVhRSkNoRkRZWnZnek9uMlM4bjRJNjBteWR2M0FocE55S3dP?=
 =?utf-8?B?VVplMmFvYUpBaitXODBpNXBpbEllZTZ5YmQwbkYycDhuWVUyWFM4WDFRLzJD?=
 =?utf-8?B?V1h1V1kxYVp0SDFzZGlvNTYyeGVmVE0yZVNUWkoydkUzTTlNMnV2YmNpQjdM?=
 =?utf-8?B?VjNieVN2NkJvaTVmMDBkdVZKZGpBekkwWjE2VmJYeUYrR0xuUUowSDJld2NF?=
 =?utf-8?B?bWViWDZ1TGp0ZzRmanoxdlAzaVVkTjJNNWVjWVdXOUREdVpOTkR0dHVDdGU3?=
 =?utf-8?B?VlN1d084Z2xvUmlaQjVVOVN1aS9yamxvWDNSK09MOHJlUWpFeWUxMkpZOTMx?=
 =?utf-8?B?cWVPbVZ6eTc0MWNPd2ViOTVjZ0hSaFpLajlVM1ZqdTdTdGtBMEdXMjk1eFVw?=
 =?utf-8?B?SThxWU1GaFB4WDh6VkhOMG0rdHZDbXB3TnFnT25oVjZESGREMGRvTHY1NXVy?=
 =?utf-8?B?OUhBQ2JTNEdNbXFKeXp5VEFtUUF4T0lVMFkxLzUydE5jTTJJeGttUWkxTUpN?=
 =?utf-8?B?OGVsbTk2M3laS21WL041MmVkNnNocUM5bEF2YVN5a25BZWt6K3A5WloybHd4?=
 =?utf-8?B?UWkrNk10QTdxYnZrVEIvdk5hYisvdy96TU53WlBtQUppU3Q3L1VFNnYyckw5?=
 =?utf-8?B?Zm9wQWw4YjFwdjB6UGRIbDFOaUtJL1FmYTV0eHAwYkFUbitZVGVNMzJwRWdy?=
 =?utf-8?B?dXBSL1BGNm9UTEQwd05XaHIyUmZWZHV4MHdYV1lEMm1zcTZicFRGalRsMXZp?=
 =?utf-8?B?QzdRQlk1N0xscXQySjY2ZWNwcXI0QnJlb1N1K0tCT3REWmk5d0R3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE65439D1721444DB5B82767AF71BF67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BUVWBuslfh2PC0DiHXGSzFUzXf1lN3PUNwG04QD75/EjbMf3D7H7GYw179ZDLaloWif5uFnbBlqHfQjOEMVZ0sOJHmZ72cumTO9L7lqYxhb54GsBKZMeE6IaANk/nzmQVvCQVjYv2LCfWAAQKAzuajh2+/osIKSerjbBNzTUiGOme4nylUd/gEcvTxpgivQA8sKaKGYvziQaVxVNlY+Yw1aDYJ+BId7HtGbtT8rj9fBM3icsq/2erJYbruh9dgy9ywtBicYLiNp9B2huW6ax37VEXdRZQkVxChBs+5R0MBDuy4+6ZWaksvmj8dVfhyA9YrHLa0CRzUY4xd4FT6USvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89416610-1c7e-4e0d-a7be-08df01c51c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 09:50:20.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wku087CjuXdamtlRPo9Q+SWNABdtgfrHm1i1fPwhgGZlZdmYpjutr3PE8fsRaFUIIjgdvdJI4gfo/rka7Xs3XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTA4LTIzIGF0IDAzOjAyICswODAwLCBDaGVuZ2ZlbmcgWWUgd3JvdGU6DQo+
IFByb3RlY3QgdGhlIG5vbmNvaGVyZW50IERNQSB6YXAgd2l0aCBLVk0ncyBTUkNVIHNvIHRoYXQg
bWVtc2xvdHMgYW5kDQo+IHRoZWlyIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBtZXRhZGF0YSByZW1h
aW4gYWxpdmUgaWYgdGhlIHJtYXAgd2Fsaw0KPiBkcm9wcyBtbXVfbG9jayB0byByZXNjaGVkdWxl
Lg0KPiANCj4gVGhlIFZGSU8gbm9uY29oZXJlbnQtRE1BIHBhdGggaW52b2tlcw0KPiBrdm1fYXJj
aF9yZWdpc3Rlcl9ub25jb2hlcmVudF9kbWEoKSB3aXRob3V0IGhvbGRpbmcgc2xvdHNfbG9jayBv
ciBhbg0KPiBTUkNVIHJlYWQgbG9jay4ga3ZtX3phcF9nZm5fcmFuZ2UoKSBjYW4gdGhlbiBlbnRl
cg0KPiBfX3dhbGtfc2xvdF9ybWFwcygpLCB3aGljaCByZXRhaW5zIHBvaW50ZXJzIHRvIGEgbWVt
c2xvdCBhbmQgaXRzIHJtYXANCj4gd2hpbGUgY29uZF9yZXNjaGVkX3J3bG9ja193cml0ZSgpIHRl
bXBvcmFyaWx5IGRyb3BzIG1tdV9sb2NrLg0KDQprdm1femFwX2dmbl9yYW5nZSgpIGNhbiBpbnZv
a2UgDQoNCiAgIHNsb3RzID0gX19rdm1fbWVtc2xvdHMoa3ZtLCBpKTsNCg0KaW50ZXJuYWxseSAo
ZnJvbSBrdm1fcm1hcF96YXBfZ2ZuX3JhbmdlKCkpLiAgQUZBSUNUIHRoaXMgaXRzZWxmIGlzIGVu
b3VnaCB0aGF0DQp0aGUgY2FsbGVyIHNob3VsZCBlaXRoZXIgZ3JhYiByZWFkIGxvY2sgb2YgS1ZN
J3MgU1JDVSBvciBzbG90c19sb2NrLg0KDQpGb3IgaW5zdGFuY2UsIF9fa3ZtX3NldF9vcl9jbGVh
cl9hcGljdl9pbmhpYml0KCkgaXMgYWxyZWFkeSBob2xkaW5nIEtWTSdzIFNSQ1UNCnJlYWQgbG9j
ayB3aGVuIGNhbGxpbmcga3ZtX3phcF9nZm5fcmFuZ2UoKSB0byB6YXAgdGhlIEdGTiBvZiBndWVz
dCdzIEFQSUMgcGFnZQ0KKHdoaWNoIGlzIG9ubHkgMSBwYWdlIHRodXMgd29uJ3QgeWllbGQpLg0K
DQo+IA0KPiBUaGUgcmFjZSBsb29rcyBsaWtlIHRoaXM6DQo+IA0KPiAgIENQVSAwOiBWRklPIGNv
aGVyZW5jeSB1cGRhdGUgICAgICAgICAgQ1BVIDE6IG1lbXNsb3QgZGVsZXRlDQo+ICAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
ICBrdm1fdmZpb19zZXRfYXR0cigpDQo+ICAgICBrdm1fYXJjaF9yZWdpc3Rlcl9ub25jb2hlcmVu
dF9kbWEoKQ0KPiAgICAgICBrdm1femFwX2dmbl9yYW5nZSgpDQo+ICAgICAgICAgX193YWxrX3Ns
b3Rfcm1hcHMoKQ0KPiAgICAgICAgICAgaXRlcmF0b3Iucm1hcCA9IHNsb3QtPmFyY2gucm1hcA0K
PiAgICAgICAgICAgY29uZF9yZXNjaGVkX3J3bG9ja193cml0ZSgpDQo+ICAgICAgICAgICAgIGRy
b3AgbW11X2xvY2sNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBLVk1fU0VUX1VTRVJfTUVNT1JZX1JFR0lPTihERUxFVEUpDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGt2bV9hcmNoX2ZsdXNoX3NoYWRvd19tZW1zbG90KCkN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB6YXAgU1BURXMg
dW5kZXIgbW11X2xvY2sNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAga3ZtX3N3YXBfYWN0aXZlX21lbXNsb3RzKCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzeW5jaHJvbml6ZV9zcmN1X2V4cGVkaXRlZCgpDQoNCklzbid0
IGt2bV9zd2FwX2FjdGl2ZV9tZW1zbG90cygpIGNhbGxlZCBfYmVmb3JlXw0Ka3ZtX2FyY2hfZmx1
c2hfc2hhZG93X21lbXNsb3QoKT8NCg0KDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGt2bV9mcmVlX21lbXNsb3QoKQ0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZmcmVlKHNsb3QtPmFyY2gucm1hcFtpXSkNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShzbG90KQ0KPiANCj4g
ICAgICAgICAgIHJlYWNxdWlyZSBtbXVfbG9jaw0KPiAgICAgICAgICAgc2xvdF9ybWFwX3dhbGtf
bmV4dCgpDQo+ICAgICAgICAgICAgIHJlYWQgZnJlZWQgaXRlcmF0b3Iucm1hcA0KPiANCj4gVGhl
IGRlbGV0ZSBwYXRoIGlzIGFsbG93ZWQgdG8gZnJlZSB0aGUgb2xkIG1lbXNsb3QgYmVjYXVzZSB0
aGUgemFwIHBhdGgNCj4gaG9sZHMgbm8gU1JDVSByZWFkIGxvY2suIHN5bmNocm9uaXplX3NyY3Vf
ZXhwZWRpdGVkKCkgdGhlcmVmb3JlIGRvZXMgbm90DQo+IHdhaXQgZm9yIHRoZSBybWFwIHdhbGsg
YmVmb3JlIGt2bV9mcmVlX21lbXNsb3QoKSByZWxlYXNlcyB0aGUgb2xkIHNsb3QNCj4gYW5kIGl0
cyBybWFwIGFycmF5LiBXaGVuIHRoZSB6YXAgcmVzdW1lcywgc2xvdF9ybWFwX3dhbGtfbmV4dCgp
IHJlYWRzDQo+IGZyb20gZnJlZWQgbWVtb3J5Lg0KPiANCj4gS0FTQU4gcmVwb3J0ZWQ6DQo+IA0K
PiAgIEJVRzogS0FTQU46IHZtYWxsb2Mtb3V0LW9mLWJvdW5kcyBpbg0KPiAgIHNsb3Rfcm1hcF93
YWxrX25leHQrMHg4Mi8weDFjMA0KPiAgIFJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZmM5MDAw
MDVjMTAwOA0KPiANCj4gICBDYWxsIFRyYWNlOg0KPiAgICBzbG90X3JtYXBfd2Fsa19uZXh0KzB4
ODIvMHgxYzANCj4gICAgX19rdm1fcm1hcF96YXBfZ2ZuX3JhbmdlKzB4MTdhLzB4MjgwDQo+ICAg
IGt2bV96YXBfZ2ZuX3JhbmdlKzB4MmE2LzB4NmEwDQo+ICAgIGt2bV92ZmlvX3NldF9hdHRyKzB4
NTc2LzB4NzcwDQo+ICAgIGt2bV9kZXZpY2VfaW9jdGwrMHgxZmYvMHgzYjANCj4gICAgX194NjRf
c3lzX2lvY3RsKzB4MTM0LzB4MWMwDQo+IA0KPiBIb2xkIFNSQ1UgYWNyb3NzIHRoZSB6YXAgc28g
dGhhdCBtZW1zbG90IGRlbGV0aW9uIHdhaXRzIGZvciB0aGUgd2FsayB0bw0KPiBmaW5pc2ggYmVm
b3JlIGZyZWVpbmcgdGhlIG9sZCBzbG90LCB3aXRob3V0IGNoYW5naW5nIHphcCBiZWhhdmlvci4N
Cj4gDQo+IEZpeGVzOiAzNjJmZjZkY2E1NDEgKCJLVk06IHg4Ni9tbXU6IFphcCBLVk0gVERQIHdo
ZW4gbm9uY29oZXJlbnQgRE1BIGFzc2lnbm1lbnQgc3RhcnRzL3N0b3BzIikNCj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogQ2hlbmdmZW5nIFllIDxuaWNveWlw
LmRldkBnbWFpbC5jb20+DQoNCkNvZGUgY2hhbmdlIExHVE0sIGZlZWwgZnJlZSB0byBhZGQ6DQoN
ClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQoNCk5pdDogdGhl
IHNob3J0LWxvZyB1c2VzICJ4ODYvbW11IiBhcyB0b3BpYywgYnV0IG1heWJlICJ4ODYiIGlzIG1v
cmUgYXBwcm9wcmlhdGUNCnNpbmNlIHRoZSBjb2RlIGNoYW5nZSBpcyBtb3JlIGxpa2UgYXQgeDg2
IGxldmVsPw0KDQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL3g4Ni5jIHwgNiArKysrKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCj4gaW5kZXgg
Njk0NjliYmRjODRhLi4yMTE0NTUzZjMxNTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS94
ODYuYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCj4gQEAgLTE0MDkyLDggKzE0MDkyLDEy
IEBAIHN0YXRpYyB2b2lkIGt2bV9ub25jb2hlcmVudF9kbWFfYXNzaWdubWVudF9zdGFydF9vcl9z
dG9wKHN0cnVjdCBrdm0gKmt2bSkNCj4gIAkgKg0KPiAgCSAqIElmIEtWTSBhbHdheXMgaG9ub3Jz
IGd1ZXN0IFBBVCwgaG93ZXZlciwgdGhlcmUgaXMgbm90aGluZyB0byBkby4NCj4gIAkgKi8NCj4g
LQlpZiAoa3ZtX2NoZWNrX2hhc19xdWlyayhrdm0sIEtWTV9YODZfUVVJUktfSUdOT1JFX0dVRVNU
X1BBVCkpDQo+ICsJaWYgKGt2bV9jaGVja19oYXNfcXVpcmsoa3ZtLCBLVk1fWDg2X1FVSVJLX0lH
Tk9SRV9HVUVTVF9QQVQpKSB7DQo+ICsJCWludCBpZHggPSBzcmN1X3JlYWRfbG9jaygma3ZtLT5z
cmN1KTsNCj4gKw0KPiAgCQlrdm1femFwX2dmbl9yYW5nZShrdm0sIGdwYV90b19nZm4oMCksIGdw
YV90b19nZm4ofjBVTEwpKTsNCj4gKwkJc3JjdV9yZWFkX3VubG9jaygma3ZtLT5zcmN1LCBpZHgp
Ow0KPiArCX0NCj4gIH0NCg0K
