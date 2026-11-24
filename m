Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795543982;
	b=L/Canm+NCk1vU/9/wRb+NBL0x2Er4YaNiX39W8QN4KQLL2X/hHMu7egzk08AzxP8Vgor
	 ZDZkwHV8SxniYShChQgGlt06veHkFeCnbYo9CzRSaIflmp/YaXMC5t6A0/wdCLoORSYIr
	 JaXo/1q7Mo1FxsgD0VExHicsTxkTQk+FC/aUrMaFNvBGXhHDsndCimZthZJSE7PMciS1b
	 hhP41SJusHtHkqOLuJGLYJVIF0G2DXqGc1bhbldxeU76Dt3cNjfxvveybadWXMu3T6kJk
	 a2TsN3BB1Oq/YqWtxYdmlZJdH1eqOCRBpwpmvG7WmYaTEotclt51kdEiitunZFEHFEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543982;
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
	bh=vROy7RB1KCwKXxjWgByp2MfERi4F2ivR3Pwu86FJEro=;
	b=2vGm5EwNyBWLxvpM+Y8hEMayewkBolWkOthfMN0LKqKy8iaALdF5/Uz9g/EO97QHkyL7
	 k+iPVtv+JElf0c37UJJ+voAamQJH2WU+E4Z19dA0m8abfb6Fl7Imd8LZIvWsrpAKpHQzd
	 EgDzLZDWk+S26cijugTTW+u+D6suAZ9sxCDWOnix0cN295kCbJGZQfi33kIRW/Fp1z6yP
	 z50qIcgHQSwFVHr9PXEDSTifP7/AqX9fsqH3z+FPLRT+b3OyN/BtV1+T7G+RZA8EyE4Jn
	 3xECwqlMbPAE+gzBn3ujSCsQVoRAR71RXPUyU5yXcLUPw/jGFl1YmgloN3i683EfFuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSPTC+ec;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=i7lP3u6k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1381606A321;
	Tue, 24 Nov 2026 18:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1381606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSPTC+ec;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=i7lP3u6k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795543982; x=1827079982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vROy7RB1KCwKXxjWgByp2MfERi4F2ivR3Pwu86FJEro=;
  b=eSPTC+ecn5nNhDh2heGClaEthznw6hS5B7Uk4GFJWrPBrEOnMSWAN552
   gl2h8EH1ndUtuTz2nerQNLE2WeMijHw/huw5tdBCB92f/XFvdLh1bev0q
   c/di8UH8NGR1gd6Hc/ODm4IDSROWjT8Wf+8B2uWNucTnzW244iNBc2K1a
   k6R8PKos0MsDVVrRdywcYONrawIewTCSkwydTiqFqpH1zhUwHEUhhAp9n
   lwQU+XcDwrr4VTMkHOGdQ9D/U1/XERsBVEjYGgL9xm/HrjQN/8CykjiO6
   hGVXGUNGsNccTcchPs4T2kM4mDRyhlvVNErMNp4ZNWyh7BZ7B0kcLBSwx
   w==;
X-CSE-ConnectionGUID: NVhw8l+wRa65h2HVYosTBg==
X-CSE-MsgGUID: sIW2i26YQZ+r/mk8mSL9aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4315764"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4315764"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 10:11:43 -0800
X-CSE-ConnectionGUID: jSzaHRMaS9Shh+N5lR6TgQ==
X-CSE-MsgGUID: Un4H2061QWGFK+MDLEfAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11422997"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 10:11:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 10:11:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 10:11:41 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 10:11:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiwpbP5LaNseYvnWBPLfWHu+TlBTDDNlKfuWJ7dxLBn3kTpx7/PsiYZySmySRPi8X4O55avDjsE1LAIAtZSFuFhk44Fa5cffFA6K9viYCYR2JipEHENmkT2WUQUXgKPny1R2CarZ9otwHsb0xRltWPt7rK0fxpbBzjrkjVDb6nb6K/O39jtP5juVQQ8ita4f9cd4ojs0oSMl/jl5I5rmL/oLaJB6quW2Wq6XBUI46sEh4SsFB1nHjJb91RMlyCa0WkYJ48834TOhbhCR37QtbuqYWhN+5WxmvQqDqWPAoay8CLfohGFggqixCmZbSiXDhUr3ND0G5lve1/2s9bNqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vROy7RB1KCwKXxjWgByp2MfERi4F2ivR3Pwu86FJEro=;
 b=n/ZEIpbslHKrrJx7mC8Lfj8m2bDHaRuh+67uTHlM/d6EE+YFmx1vYnaKhUKAp8KtGVg9TErmP5KbjsOinYFu9IAxI07nIuy9ZhuVjDqXsIjjpDCDxCIX8T8WPDfzCv8FVk6CxpAZHSA0UWymlZblOGNvqaI55UiXsGjW1CJ4DZql1egCHo/s/ST9QoemQK02covg0jA8Gzi9cNqkMV0P8TKJ83YU/pc00BbAmzhxAFDUSJgKM7QCMpQ2cZ+VS2WT5uWrvLzVe9mziN+tFVtLNRj2tkFP6daH9ILSoF8FIwq7PqYldzoxQDjR1nSE6wVtoBdqc0dLeVH1ufDDwPQLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vROy7RB1KCwKXxjWgByp2MfERi4F2ivR3Pwu86FJEro=;
 b=i7lP3u6k9BBzyeSdBAEEgiHyQZscWgGlwgU7Rjkt/XSj68rfTE6n0fj6FgFmOXSh97jn9oMsO/dCJyOBaCC1vyGyW3NgmI475FBJO5dkl/S4bIg//KweW0ZF1v/XHzjH2UXlMskZz7VI0BixYbxxdqjB02PZqOuSeDWZXJTUGcQ=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by PH7PR11MB6771.namprd11.prod.outlook.com
 (2603:10b6:510:1b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 18:11:29 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 18:11:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "moe@flashbots.net" <moe@flashbots.net>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Miao, Jun" <jun.miao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
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
Thread-Index: AQHdY+xbWjjgSCvIwUKkNDKjcu8hYLcbQGeAgADq+YCAEDbyAIABL/4AgAWeBoCAAOGEAIAJpMAA
Date: Tue, 24 Nov 2026 18:11:29 +0000
Message-ID: <b9a69a9ca8665f7edc1e80b2516423154248d1c5.camel@intel.com>
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
	 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
	 <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
	 <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
	 <CAKV3HMMfx4APmardWdtL8yhirXMuuBQMZ8xrtowHNRnTKXNRiw@mail.gmail.com>
	 <86f99f3010775eeff6269fd9bb8f4edac10a7d85.camel@intel.com>
	 <CAKV3HMMjyHig6LTiCsXKLvgvsW+0GVitCc0ziBD9RNxH2TAuvA@mail.gmail.com>
In-Reply-To: <CAKV3HMMjyHig6LTiCsXKLvgvsW+0GVitCc0ziBD9RNxH2TAuvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|PH7PR11MB6771:EE_
x-ms-office365-filtering-correlation-id: c1d20755-5a4e-465b-2866-08df4a565cd3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006|261026140227099003|4143699003|261026121527099003|261102130727099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: Xrq+UsVL4g0f7IyfcvRTqXwSTwMI0zBB+dIONQit7V2v1kRdD3+J/oKVx6IK6nHd0gWMwUJ8aX2tSIxhWD+hVgTBh6BovaX+NxGdZqa2honyX60pu8w1330woCel/Hh+lyN1sqkQuvRwbXQhzxxK58y8mUh5r7u79aBaBgWZdP3x8Y5QR61WmGUaupAIEBRqQ17U4+1NG3CWLz7HazSOCzERIH4LNv++mCoJ0eMAxHlzMs2+VIEwJx/PMiBZDyDOmb7OoLt4s3WrP/VCVlznh3TDhZBpRvwHs1m0ksJkLKmOfqQtx/ItKXyfT5GUb1PSIZSaCEC6TNbw6OFlNI/LEOMfduTc1Qt+p4ZwgNE6BYLLrqvIt3imPcE6ViT45SI/d+LBRew6dJwqs/s008JsogZ0wDLIQZsUe7U99Qx7A4nOwlXzMI01AQ9YhMZeHEwKP+7DLfK9ykmxKudAic4i9I87KB84KxpKWmOXGu38UmPR3I6Zjouh9N844igoo2l34vZzVzlSusHghGbtzVRb7LAdLDkIs3tqa07lgo641UlaJgZkwtcs2hZa2pC19G/iJEkvqkMT4ZfrLI5L3qKvwlfPAbTySudj/DnZltfDLXVHBgOeJ2AajWHd1PrmR1WJsLVHIf8Upx+V0Z4mSv7QfkB8YZUnGKyP9VNTp+zOAavlydZv2oDo9RCz6aMrWyQVnYVLlyDDhGR7kBSjFG3a2jzZSQUMkuwzgafGI34BSQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(261026140227099003)(4143699003)(261026121527099003)(261102130727099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGN1M1dmYzdWN0dvRlpmVmpOUnZYWUNXNmo1RURqTmRaVGxOUERFSGR2Zjhj?=
 =?utf-8?B?SmtWYmZDRGlmOFF6bUJCK0g4aC9talFkM2FEeEdTZ2lPem5TaS9DMHRBODQw?=
 =?utf-8?B?c1NhN3dBaHk0bEdCOG1YVWl3S1RGMmYwNGZSNzJBMlNEcnlFZWhFeCs4aE5F?=
 =?utf-8?B?Wlg0bkhaLzhodmhwdjBKNGhpaUl0dXFFVURTVnBhdEdWUlNGNGhNOXR4YTlF?=
 =?utf-8?B?NFlnc0hXdmdHME5Bak02dXA0LzBkMmFwMDBWL1AxMk1QV0RGdW5iUDM3UGlj?=
 =?utf-8?B?d0lzQmRYdWdMNzF3ZHZNaVJLSjR3dXVWYTlDR3JDcFo0bnVsMmtpcDE3c3d4?=
 =?utf-8?B?aUhjdXlJcitjK01SQ0VQclNGSzJFdUlKaDFMV0FTYm8wYmtuT0V4ZGNnMmdX?=
 =?utf-8?B?UkZxaWtoSmFQWDFYbXRzQ0FxOXJNSGF5bFRXSndVNk5QTE5RUHUxaW82VnFO?=
 =?utf-8?B?SlRGZk5meElzNGVWenRFaFVQbkRLd3YvbUFqbW00bzNjYmZOM2J3NENGODU5?=
 =?utf-8?B?c1FwVkZwWjNpRG1xMC9KUTFqS3RHMWpjREV4dmRBc3lkZXhQYWQ5bTF1Tnhj?=
 =?utf-8?B?QWd4SEh2MEphb3ZkRXg2cW1udDl3MG1jZnJBQVNuOEJ1Um5sa2I4aUdBQytu?=
 =?utf-8?B?Y3FxWjduMWpFZkhCWHhoRnhVQTZ5Nk5sa1FIT05ZeU5sN0hvQ1pObmpGU2xX?=
 =?utf-8?B?STl6aDk5WnYybjZuSHk0ZGNNR1B0MVFnSk4rT2ZpM0c0QWxsWW5zYVA4bnhV?=
 =?utf-8?B?c0tLWTVqbW9QTm9aS09FS25PSGVFWWdTZHNVd1V1bVRlOEVvdEFPTmgzSnN0?=
 =?utf-8?B?cTh4QzMvKzM3MkV2SzMrQnB2ZllLc1JzTnA5UExLcy8yRWxyemhmOGk4UWZp?=
 =?utf-8?B?MkJPQ1dIREVYWjAzQ0tTVnZqNXhMUm5rOEpaUzBRNVV3d09WTSsyOUpqOUE1?=
 =?utf-8?B?dHpRVDN4Sm45WmtmaEJkMXRQRnV6KytYUWVlS2xZNjR6MFFyb0FhbUlxSHJ0?=
 =?utf-8?B?Q3lBMnBqVnRKRXFjTjR0WDNsZEhqOXlyNU5EMDRweVcxVlNNYzdFYUloRUgw?=
 =?utf-8?B?UEcrRGtkTXZaODlENGxZei9vUWpnb3QwME5KN21EUGlZaEh0QlJWK1NvZlV5?=
 =?utf-8?B?OS9EejdzM2JRMlJtK2RFZXBDcTBpK0xwQmxWME5aaUtNN2dKRVdLNkZxYjhJ?=
 =?utf-8?B?TWJ4RVN4d1lWRCtmcGhQU3JSSTZmZTM3azVEOFJKc0JPZ0ZZVmpuNEpWcnpq?=
 =?utf-8?B?amp4amR1UHNsVFc2c3JYNGpxZGRFYk8vTEpPOGIzWEQ1dFJpZXlMaDlCeWZF?=
 =?utf-8?B?TTZ2UlVaU0JCdTdNb2l6V2hhSWlNL09INCtIdmZmc3IrNmpHT0ZWNk5qbmNu?=
 =?utf-8?B?R3JtK3dZUXlPdzZtNG1jdVdyVXVtWFhwZ0pUYVNhQ0lJRFJtNkZIcHBCWkhM?=
 =?utf-8?B?WDFEWVRSclBpNVR0dGZ4aHBxbzkvTzk1RTk0RVZWRmFRKzdYckhXZVdsQkI5?=
 =?utf-8?B?QkFJZ1BPSzdZRzN1SWlBOUl5WGhkZGtXc2U4RUljb1VYTzNMU3lISTMwcFNy?=
 =?utf-8?B?R3huQTVyY2FkVWNJV1BtdkVUeWRVWDR4eDJGcVdVYk1keVY0Ly9CbTFtazc3?=
 =?utf-8?B?amhlUXJxbFRlV0xCUzI0OGVBRStWU2UyVnBpTGhlL0hmNkkvenlFcUNSUExX?=
 =?utf-8?B?QktyNTJEVHZTZUdJeWNyd0lYcU1PMzNYQUFzUFFuaW11MEJuOUdMVlF5WjFR?=
 =?utf-8?B?am9sZG9uak9jZ0VaeEhxUWZuTUhRcGJaR2VzSXhtU3ZlMFJkQjFSUUVZTjlG?=
 =?utf-8?B?dElrYmwzVks2cE1WVzNZZkZQZUdnSVoyQlhqYzlTQlJQNkw5MmgwTkZnUW05?=
 =?utf-8?B?eTNlRER5blFMVVZ5L05DdFVHT05OOSs4SEpJMTBXRWpiT3NmTTlkNXZsa2tR?=
 =?utf-8?B?VW1RWW1HQ29TdVZrZkJXaGZWcVl0dHYzN05OTjZ4RU5jNUlzZnhDc25WOS9K?=
 =?utf-8?B?LzJ6c2tHVnppVjltb3pHYm9MelJUNzVzdmdZS3M1WEdXcCtsNDhoamQvZ21u?=
 =?utf-8?B?aWF4dDhlMHJWNmtmaTAwRVg3WFdRS1pXRVlzK3lBSXVTdnU4YmRQTWJTak5F?=
 =?utf-8?B?QThiYjk4Tm5ZWnUwRGJKbVQ5dXFQYzBvSXRCMm95TGR2SUJhbnhQRFJxWTFm?=
 =?utf-8?B?eHJJbTFnZjRyelhHQ3M2MlRVRU1xZStmNkFlTDZ1Z2FwUzdGbnpqdmN6NkxZ?=
 =?utf-8?B?MForak8yRjY0b1BCS1FCMk5ORlUzZ01JbHRMUXRmWkgrQTl2NGF4c1ZHak5n?=
 =?utf-8?B?am4rNW5RNzZ2WlBzUmhQdlR1WStsbUdkOVZ3WCs1TDVxOWpyeDR0TENFbDEw?=
 =?utf-8?Q?Bznr5rgyXOz4kFXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D48676AF0081647A16C3183CCB693C6@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: MFf8aqk4qpRwyqX31M4WL2I0Op/ozS4TRxsRWaupI12iooIzWu3mHt7T0f+bC37BcEgk/ShfMb2yvqZU9E1Ka4BrSdyeDK1IpZS95C2eU88u8LhWnupEL05warEq1V1Ksi4W+zlSGAM7Emxi7vNwi5MU17bJPWMPtzgI/eSdCOncBocq4YfFxvIvt2mY/hx9ou147u0FpChABZiokmjSPAu/dYJ+gqCBFhmp/8TwpmcYvcvUE9rla8fHidt4jNylgEWvVePyOlHhPRoJoeKOzkSNC4ZgXA9fEn2KdPb0PLzKvy8w+ebfiIgPiu2zqFxXZ81mYiUvwyAN5ZgcoA5Drw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d20755-5a4e-465b-2866-08df4a565cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 18:11:29.3952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLiZNpOm+wi/2XrkXUL2yJp1UzIEbMJj1Phc/YFCJi0IM7OcAOrGYM1y8zKPrXqPiwq++MWzS876VPZL3Z1FReGFi2Wk5gmb20Jvyz+93QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTExLTE4IGF0IDE0OjU1ICswMDAwLCBNb2UgTWFoaG91ayB3cm90ZToNCj4g
T24gV2VkLCAyMDI2LTExLTE4IGF0IDAxOjI4ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gPiBJJ2QgdGhpbmsgYSBzaW1wbGVyIHNob3J0ZW5pbmcgb2YgdGhlIHRpbWUgd291bGQg
YmUgYmV0dGVyIHRoYW4gc29tZXRoaW5nIG1vcmUNCj4gPiBhZHZhbmNlZC4gQnV0Li4uDQo+IA0K
PiBPSy4gSW4gdjQsIHBhdGNoIDIgd2lsbCByZXBsYWNlIHRoZSBiYWNrb2ZmIHdpdGggYSBmaXhl
ZCAxMCBtcyBzbGVlcC4NCj4gUGF0Y2ggMSBzdGF5cyBhcyBpdCBpcy4gSXQgZml4ZXMgdGhlIHRp
bWVvdXQgY2hlY2sgYW5kIGlzIG1hcmtlZCBmb3INCj4gc3RhYmxlLCBzbyBpdCBjb3VsZCBhbHNv
IGdvIGluIG9uIGl0cyBvd24uDQoNCk9rLg0KDQo+IA0KPiA+IFNob3VsZG4ndCBhdHRlc3RlZCBU
TFMganVzdCBiZSB1c2VkIHRvIHNldCB1cCBzb21lIG90aGVyIGtleSBzdWNoIHRoYXQNCj4gPiBz
dWJzZXF1ZW50IGNvbm5lY3Rpb25zIGNhbiBiZSBhcyBmYXN0IGFzIG5vcm1hbCBUTFM/IDAuMXMg
aXMgc3RpbGwga2luZCBvZiBzbG93Lg0KPiANCj4gVGhlIDAuMSBzIHdhcyB0aGUgdG90YWwgZm9y
IHRlbiBjbGllbnRzIGNvbm5lY3RpbmcgYXQgb25jZS4gRWFjaCBRdW90ZQ0KPiB0b29rIGFib3V0
IDggbXMgd2l0aCB2MyBvZiBwYXRjaCAyIChtZWRpYW4gb2YgMTIwIGJhY2stdG8tYmFjayBRdW90
ZXMgYXQNCj4gSFo9MjUwKSwgYW5kIHF1b3RlX2xvY2sgcnVucyB0aGVtIG9uZSBhZnRlciB0aGUg
b3RoZXIuDQo+IA0KPiBPdXIgSFRUUCBwcm94eSBhbHJlYWR5IGRvZXMgcGFydCBvZiB0aGlzLiBB
IGNsaWVudCBrZWVwcyBpdHMgYXR0ZXN0ZWQNCj4gY29ubmVjdGlvbiBvcGVuIGFuZCBzZW5kcyBh
bGwgaXRzIHJlcXVlc3RzIG92ZXIgaXQsIHNvIGl0IG5lZWRzIG9uZQ0KPiBRdW90ZSBwZXIgY29u
bmVjdGlvbiwgbm90IHBlciByZXF1ZXN0LiBXaGF0IGlzIGxlZnQgaXMgdGhlIGZpcnN0DQo+IGNv
bm5lY3Rpb24gb2YgZWFjaCBjbGllbnQuIE1hbnkgY2xpZW50cyBjYW4gYXJyaXZlIGF0IG9uY2Us
IGZvciBleGFtcGxlDQo+IGFmdGVyIHRoZSBURCByZXN0YXJ0cy4gVG9kYXkgdGhlIGxhc3Qgb2Yg
TiBjbGllbnRzIHdhaXRzIGFib3V0IE4NCj4gc2Vjb25kcy4NCj4gDQo+IFdlIGRvbid0IHRydXN0
IGEga2V5IGZyb20gYW4gZWFybGllciBhdHRlc3RhdGlvbiBmb3IgbmV3IGNvbm5lY3Rpb25zLg0K
PiBJZiBhIGxhdGVyIGNvbm5lY3Rpb24gcmVsaWVkIG9ubHkgb24gc3VjaCBhIGtleSwgYSBsZWFr
ZWQga2V5IHdvdWxkIGJlDQo+IGVub3VnaCB0byBwYXNzIGFzIHRoZSBURCB3aXRob3V0IGFueSBR
dW90ZS4gVGhlIHJlY2VudCByZWxheSBhdHRhY2tzIG9uDQo+IGF0dGVzdGVkIFRMUyB1c2VkIHRo
aXMga2luZCBvZiBnYXAuIEluIENWRS0yMDI2LTEwODI2OSAoQ1ZTUyA5LjEpIHRoZQ0KPiBRdW90
ZSB3YXMgYm91bmQgdG8gdGhlIFRMUyBrZXkgYW5kIGEgY2xpZW50IG5vbmNlIGJ1dCBub3QgdG8g
dGhlDQo+IHNlc3Npb24sIHNvIGFuIGF0dGFja2VyIHdpdGggdGhlIFRMUyBwcml2YXRlIGtleSBj
b3VsZCByZWxheSBhIGdlbnVpbmUNCj4gUXVvdGUgb250byBpdHMgb3duIGNvbm5lY3Rpb24uIEJp
bmRpbmcgZWFjaCBRdW90ZSB0byBrZXlpbmcgbWF0ZXJpYWwNCj4gZXhwb3J0ZWQgZnJvbSB0aGF0
IHNlc3Npb24gY2xvc2VzIHRoaXMuIFRoZSBleHBvcnRlZCB2YWx1ZSBpcyB1bmlxdWUgdG8NCj4g
ZWFjaCBoYW5kc2hha2UsIHNvIGl0IGFsc28gc2VydmVzIGFzIHRoZSBub25jZS4NCg0KVGhhbmtz
IGZvciBzaGFyaW5nLiBUaGUgY2FzZSBpcyAiYW4gYXR0YWNrZXIgd2l0aCB0aGUgVExTIHByaXZh
dGUga2V5IiBhbmQgYSBidWcNCmluIGEgY2xpZW50IGxpYnJhcnk/IEl0IHNvdW5kcyBsaWtlIGEg
cHJldHR5IGFnZ3Jlc3NpdmUgdGhyZWF0IG1vZGVsLiBJJ20gc3RpbGwNCm5vdCBzdXJlIHF1b3Rp
bmcgaXMgc2V0dXAgZm9yIHRoaXMga2luZCBvZiB0aGluZyBmcm9tIGEgcGVyZm9ybWFuY2UgcGVy
c3BlY3RpdmUuDQpCdXQgdmVyeSBpbnRlcmVzdGluZyB0byBoZWFyIGFib3V0IHRoZSB1c2UgY2Fz
ZS4NCg0KPiANCj4gPiBJbiB0aGUgZW5kIEkgdGhpbmsgcXVvdGUgYmFzZWQgYXR0ZXN0ZWQgVExT
IGlzIG5vdCBub3JtYWxseSBleHBlY3RlZCB0byBiZSBmYXN0Lg0KPiA+IFNvIGlzIHRoaXMgdHJ5
aW5nIHRvIG9wdGltaXplIHRoZSB3cm9uZyB0aGluZz8NCj4gDQo+IEl0IGRvZXMgbm90IG5lZWQg
dG8gYmUgYXMgZmFzdCBhcyBwbGFpbiBUTFMuIEJ1dCB0aGUgc2Vjb25kIGlzIG5vdCB0aGUNCj4g
Y29zdCBvZiBhdHRlc3RhdGlvbi4gV2l0aCBhIGxvY2FsIFFHUyB0aGUgUXVvdGUgaXMgcmVhZHkg
YSBmZXcNCj4gbWlsbGlzZWNvbmRzIGFmdGVyIHRoZSByZXF1ZXN0LCBidXQgdGhlIGRyaXZlciBk
b2VzIG5vdCBjaGVjayBhZ2FpbiBmb3INCj4gYSBmdWxsIHNlY29uZC4gQW55IHVzZXIgb2YgY29u
ZmlnZnMtdHNtIG9uIFREWCBwYXlzIHRoYXQsIHdoYXRldmVyIHJ1bnMNCj4gb24gdG9wLiBUaGUg
cGF0Y2ggc2hvcnRlbnMgdGhhdCB3YWl0LiBJdCBkb2VzIG5vdCB0cnkgdG8gbWFrZSB0aGUgUXVv
dGUNCj4gaXRzZWxmIGZhc3Rlci4NCj4gDQo+IElmIHRoYXQgd29ya3MgZm9yIHlvdSwgSSB3aWxs
IHNlbmQgdjQgd2l0aCB0aGUgZml4ZWQgaW50ZXJ2YWwuDQoNClllYSwgbGV0J3MganVzdCBnbyB3
aXRoIHRoZSBwb2xsaW5nIGZpeCBhbmQgdGhlIGZhc3RlciByYXRlLiBJdCBzZWVtcyB0aGUNCmRl
ZmF1bHQgaXMgdG9vIGhpZ2ggYmFzZWQgb24gdGhlIGFzc3VtcHRpb24gdGhhdCB1c2VycyB3b3Vs
ZCByYXRoZXIgc3BlbmQgQ1BVDQpjeWNsZXMgdGhlbiB3YWl0IHdoZW4gZ2V0dGluZyBhIHF1b3Rl
Lg0KDQpBbmQgc29ycnkgZm9yIHRoZSBzbG93IHJlc3BvbnNlcy4gSSB3YXMgd2FpdGluZyBmb3Ig
c29tZW9uZSBlbHNlIHRvIGNoaW1lIGluIGJ1dA0KaXQgc2VlbXMgdGhleSB3aWxsIG5vdCBiZSBh
YmxlIHRvLg0KDQo=
