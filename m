Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E56A489894
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729873; cv=fail; b=nHzwQDEDNIT6O0KN8Y8dOOal5riVz8Nc4Lt6cspRaQXTiQDPU9WtgpBlS3SnzyY6Xq1NXGuwTonK03rUZM0K7UDUG2XzeKfqevyZFL0SxwVYFz1zi7vLN8BJx9Ynf3J2a/RGbZQD9daO0wqB4GL4fPFxRXFY8+FUCOsg+AaXPTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729873; c=relaxed/simple;
	bh=pgmKEPnEdbzxO2tHIf/VY9RV2a3xa4ZNG30ID63WLes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T3A6eFPw8WcP+kfoG5kv/B+4nUQ7P29nropQYJj+DNASrNDDfO/KHqogaupKr2BNWbtlFk5OWf5WK0bRgcoWSvHHYVKQMJjTw6LED0+ZS1jHKMjYaggTNY61jtfC6KuqUv/aSpIx3riS1XKhvoc5rBhEtU4/gV1w2GJJX+uvycU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAd3nZ6A; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAd3nZ6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786729872; x=1818265872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pgmKEPnEdbzxO2tHIf/VY9RV2a3xa4ZNG30ID63WLes=;
  b=MAd3nZ6Are9fxq8BEqvl/l01kDbA4dVSmdVLO1pge24ou7bpH8NVF2zw
   i+p5sn8VvksxbEMpv4fAJ1mKOA6Ph7GWbGeIpghCF6aXlvsRy007FF/At
   QogzPrBASZaz3fFJHDXXoN5UaDX4xG0AhGUFnC8FkLaSOqZwuGcxnEGe8
   37P1pZgIfU7MpVhBDMnAAKHmH70LT7WWJy4Q5j0BOmE4NLMO4iww5WuUf
   Q12BQNP3sdbxP8WAccygUD9rzXf0FFZ4OuhwymL5ytVssmSGbBnRv8mRq
   DhFLA6AbKXuDsfBpG+lO4Sf9az+/uAg91Oeu1TwOE4TZxmFm81Cf09ZB6
   A==;
X-CSE-ConnectionGUID: 42UfNAfDT7SKQI9kpdqldA==
X-CSE-MsgGUID: 3HOB+gJXRn+jhCMi0giOWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="91185484"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="91185484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 10:51:11 -0700
X-CSE-ConnectionGUID: MEVtiWHyTr2ngAqiHd4mLw==
X-CSE-MsgGUID: 3LyLvkF9QZuqzeBcbYOFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260052894"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 10:51:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 10:51:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 10:51:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 10:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXH7InzAE94CaAcGcrh2Sd3p2phPwh/7dumn97drM8cKhwGQ37YOcxEtHoSDs/cALXr/TiVAqBDWem5C69d3do8c36/HmP4d+W+uJSZX94naAdEdz+46Hr6q0hYQckvIvsxDMQmD8wh4Yw9S6dLwkIJe4dMfaRR2gxqs+XoyHn0z8Bu/a3rpA2V5JdknT6kKQhl1qO0IBOR0ICIrDgRyEX7LL8ZSPJ4HVuuM09soi0R+1jI6pKSs5kmzNxb2TbQ/j8kRzptid7N1JX7/mbI4ve75pQkX/8Kmcr5zPQxp9+Jr7T+YVjSo/a2al9mjUsbVKWTm4oCPypCLL6EhCx0OeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgmKEPnEdbzxO2tHIf/VY9RV2a3xa4ZNG30ID63WLes=;
 b=yaDJuoQF5yAN73Twb4BhhFraBbx1Z9mgD5sNiEni0tgrXFszPs2zDabwzAxjZ//QThIdwFOyvZV/JxaP8S+A0qLzOkJnrQiFfYmByxeKw5+wV8AtVhVtOTV2kbgObLupuc5XY7PdMuXGK3Q8wB2Vr75G8dpEKj16lB+o+smwAvqLBR2sF1oiN6ICBHm1uAqBQS3PXmtcSVFt7dWUox4lipExTw8c8gmNXpB4PMOb3kLF/nY2T7nnpvXJnI+CVT7QocxyPHigkP0HGxKdsPzI6QrJ/CdqA0Xd/Oi+MaYW5MwoWdZVQnix29QnnatDhRFLbdBwJ5lxN1OcGbGrjVvZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by DS4PPFA92F35354.namprd11.prod.outlook.com (2603:10b6:f:fc02::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 17:51:04 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 17:51:04 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Landwerlin, Lionel G"
	<lionel.g.landwerlin@intel.com>
Subject: Re: [PATCH] drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs
 batches
Thread-Topic: [PATCH] drm/xe: Flush LSC untyped L1 dataport cache after
 rcs/ccs batches
Thread-Index: AQHdK9Yv9XUdMUHAhUGyZRu8cD8oTLad0veA
Date: Fri, 14 Aug 2026 17:51:04 +0000
Message-ID: <f30acebfd8b4b85f3f41f9c6149e2f849b133263.camel@intel.com>
References: <20260814101725.5505-1-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20260814101725.5505-1-thomas.hellstrom@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|DS4PPFA92F35354:EE_
x-ms-office365-filtering-correlation-id: e1fd05e5-9642-47b1-a8c5-08defa2c9c98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|18092099006|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|11063799006;
x-microsoft-antispam-message-info: 8AnY36xsGxTz0qJFy8Ftsg+4ZpYAXoA7CHLj27ra6MlL96VoUqHNCl4QrH9Nza3pOVFkPziD10mVDZjZV2cSR59ArPBrxHJBS16V2Q2cYXS1pZTmMiwt/N9bqN5BHbKr3JWA3/cC1BbEuJRQhXryDcpWD+GfIaawMLlRFrzf4O6sGDOHayCRwoHfUUh2eI8X1Ld9PZoEQgyN/z13C/n552OWv9T4WzrHU0rzwOpX2o3naYMBY08mBJjenrt3NMO8elqFEJNfKpmOXssJn0Jzbgz1mLG9PSB7Ppk94naqQUQq8USlqrYzrvSjJ7F9HhVjdy7meSWjc7RudgoktUZjChi6Ztz5mdPIqcNLuF+TL1bHq2yO6H0skF/oURt3vjY22IEGqrWZwK+3Dr2JZKghkkM2PYTpMZlSew4A6A3CrmT/SgJaLEdj8WQiNDNBa/z84qVb9ThcBCASODn/6PzjVsiK2cxdyX5/sOtpBvBQehzUWWsfgcvPJm91JM4n44Fgu+/0V+TP0GhkOXmU+w9kp8b8wnR4tMHo5x43xTBZfUJhavC0Y/tYRHuw8M8D2q5D3EbifJIctEkgeke7bJX/h+8MFX9fKbeYpbrylR5uv5dsfUGmg+tGJNczniRHeAwjtFImQvUWhuYQfDPhaOB8sOhfWnqonA3LMZJUnEX286M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(18092099006)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekQvNURzeGpiN2NQWWdFaUd5bHBsNytFMVZnbDhmZGRMQzd5OU5mRUFPMWpm?=
 =?utf-8?B?a1BUTXhmVWtlOFRyMU9lbDVSZk8xcWhHdU03ZXlscXFVbGEvcGhMdjZQMlVr?=
 =?utf-8?B?YUs2WjdxanNPckV0MXBlaTJzZExPQ1Erci9FM25qVWpDK3kyRlNDcmNlem5L?=
 =?utf-8?B?VFFNalB5dG9Bdzh0ME4vNitFYkRSWTYrblhnYU80WXdwSVJuMFVNRkppelpy?=
 =?utf-8?B?ekdJeFFEMmNscDkrNmpPanNLbCtiZVRLZnJKcEpmZVB1MlRZYytvdXVpVzAx?=
 =?utf-8?B?Wkxwdzl4cTdMdHl5bGdsR043ZHlIT2ZrTzJ0UFlZYzdVNDAyajB2RGRPR2R4?=
 =?utf-8?B?dVNNT2ZROEs5REdyUlYxVHpSeDZhS0xoR3JBV0hiZENOZElhaUJyUE43YmQ3?=
 =?utf-8?B?a2FXY3dtaU93RmRyUVBVYWJWNEVsa0JTZU9hNHdURU5ZeEN4MFhtbHh2YWNv?=
 =?utf-8?B?T3orWDNSMm1DRnJoK2RCVTU3YVZNcHZZc2U4Ulc4NVR3WWNhNGczVTQ5OGw1?=
 =?utf-8?B?bzFXdW1MbXFiL25aQnlCT0lJQmZRTElJb0hIb3dPUERzMEJXakswWk1BZ0xv?=
 =?utf-8?B?dW5jb3pBNE9mSFc3c3NKdDBreDdJbGdZeC9ESTB2eXNSNW1wcXEvYXIweXpY?=
 =?utf-8?B?WVlqMXY3S0FNUDZLWjFMblUyOVBXS3BPNGN6UW5lNFVDL1VtNnRObHkwblVG?=
 =?utf-8?B?VWIwaGNqZjExWWtEa0lPbGlRcTd5MjdVd2xrVi81ajdQOW9NUHhkRGJjekg4?=
 =?utf-8?B?cUliSDdpS2dyQVd6Q0diT1BJTW16OW8zV0QxbnJXd2xSeFAyb0ZCcURTUzNO?=
 =?utf-8?B?cVZnL2hoN3NSSnVPVWIzdzVUbGF6K3FZbGVSQVlLdlI0RXQwZTRvWEVYSmhk?=
 =?utf-8?B?L3BYUkxUWnQ4WEh0eVFrY3lzeEJ6M25WYzNYVlI5VzVURzNRSk5oeWtQbzR1?=
 =?utf-8?B?R1U5RFFNTlkyazltL3FmU0g1cUhBWk53dkdOelQ4NmVQeHBoblA5RmJlaWdT?=
 =?utf-8?B?UjAyaS9Vb1pveDBoMkxFVzdiTWh0WWxYbkxzUitHRVhMUnlHWUVpVTA4RlEr?=
 =?utf-8?B?cG13dHNmVTVlWHhTWDVQMTVlRmV3Z2g3dGtxRXYwTXpsVGZLTkJvK3VjdVZq?=
 =?utf-8?B?amZmaWVEOEhzVnh6UHZaZ3dwVUsyb2hrNU5xbHJQSnJwRmFsUEFpeU9UWlBF?=
 =?utf-8?B?RUxCR1pzUzdIL3F1U2ludHZqejRUdEg5emUzWDllaEdhM1piM1JTTTNEZlA5?=
 =?utf-8?B?dzBGUmNidTIvS2NqcFgxWG5hTWJ1MmphVUFUNEVuSUNUdmdBK0VsYWZqeVBP?=
 =?utf-8?B?WmNlUGIwaTgxL2txRnRyYUwzanoxU0JwRHhEMThxR1pVc0FXVmJuTU9WNVpG?=
 =?utf-8?B?K0tESXdaYUtQWHdMY2ZTVmNUNFBON1RCQ21IMmlQclZRdXZ2M2krT0xtbC92?=
 =?utf-8?B?R01oenFwNmFYZTBBMk81QmUrekZaWmtYVXcvZEFuWGNzcXpuR0t4c2IrQ3BK?=
 =?utf-8?B?a1dpV2VSVTRQclZodkIxN3pFVkY0MHNKM3JQcUlLbkJ0Q2Yvd1Zyb2RjVlNq?=
 =?utf-8?B?VXZZcXdvVG0zcmpIWXN2TXFIVDNhakxiMnBiYmtRMHVMcDR4d3hNZ05PUHN3?=
 =?utf-8?B?RVl1Siswc1JNTEpqbDFFM0diY0pPYjJiMWZaR2ZJU1VOWmd6b0U3ZjZWeU9C?=
 =?utf-8?B?Vkp4OCtmMzdKUWpsd3pBQ1VCK0N1WVArYkFzczRTeS84b25BbFRxYnM2NnZD?=
 =?utf-8?B?aHluRFVCS0ZUNGllSWduTHhxblJBc0lhWmVaM3ZJK3dyYWl1MWNuTmFSYjRO?=
 =?utf-8?B?Zm1xOFBBM01qZnRvb1VBQjNBSlVwaEtVSHBXWUUrNmZUY0VwK3Zzc0NaQkh1?=
 =?utf-8?B?QzhtcGFTdWRLY1FXdUJrVFg2WFlpVTczck5tNk5rbk00RWc1RVdDeXJVYWV2?=
 =?utf-8?B?RDZpMzZXcE9kVVhlaFZwcjltMzVjZ2lnVU5DUnJPeGF4UTVJeHRNMVFaN2pY?=
 =?utf-8?B?ZzBjV0x3Tm9LREE4U3FwekdYVUc4cEhRVmxkOFdNaWZ6OElEN2I4VTU2TWE5?=
 =?utf-8?B?YTBQN2tNUWtyWERkd0hjdnc1R2FHUm9NSjkvVU5sNHphMC9sWE81enR3WEpt?=
 =?utf-8?B?Nk5QTkpxaDlPelJYKyttNzZwWEc5NEV3OHNpNytRRG5QUDQzZXEzdG0xTS9R?=
 =?utf-8?B?aEozS3dJcWxDM3QwQldUc2huS2dtcDNJVkdFTFVVbkdvY3NscWNZWUhTd2d6?=
 =?utf-8?B?VHhwL0JVRHZtQTdyYVoxbWlCSzVhcHdUQi8rc0lTdFdjRGRuZkRQRHRMMSs3?=
 =?utf-8?B?eENWWEduNWo2OTZxZTI5L1JtbmgyN1R3QjNuU3JhQ3VaaFJyTEIwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F913B8B29F54548ACEACA00B729F15E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kNOnuaXLNv5l7wJT28sqKnnrAv8spNLMLePAPl/iz8jqPDV8briVrgDjv5hlTMcX/OOgOo13Bdm/A+foNfGBm+yT2H1iU1SDtn2HEejKxEK23RJc31+oNY8IfrbYWGuCDr6iacA9EnoF4cE7mK7t+t1YBf4LQo4AF3CIKsg2qcdHhZBtQjziWmLhb0N/gJ6cbGLrFfm3NP0SM7VAjIpY+59oap9d4hQR3+Mr0gG90yqLvarEVKSEdit+KTDoWTslq/fvE1rwrAvvY4IaK/KKAq+4lZmRhaTHXNcDfNvyO05h6AcT6IToniAFKzVuiXS5QaEhKiMiZ37QrNDG+G0wog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fd05e5-9642-47b1-a8c5-08defa2c9c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 17:51:04.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHy8WSIs0vU/xsW15w1RVy9maOhhpXr22suvmvrFsfZrQmD4f/3B4+/mzLxc+OHMG/UvGRKnuAJf2iUkQPEUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA92F35354
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTE0IGF0IDEyOjE3ICswMjAwLCBUaG9tYXMgSGVsbHN0csO2bSB3cm90
ZToNCj4gZW1pdF9yZW5kZXJfY2FjaGVfZmx1c2goKSBzZXRzIFBJUEVfQ09OVFJPTDBfSERDX1BJ
UEVMSU5FX0ZMVVNIIHRvDQo+IGZsdXNoIHRoZSBMMi9IREMgZGF0YSBjYWNoZSBiZWZvcmUgZmVu
Y2Ugc2lnbmFsbGluZywgYnV0IGl0IG5ldmVyDQo+IHJlcXVlc3RzIGEgZmx1c2ggb2YgdGhlIExT
QyB1bnR5cGVkIEwxIGRhdGEgY2FjaGUgdmlhIHRoZSAnVW50eXBlZA0KPiBEYXRhLVBvcnQgQ2Fj
aGUgRmx1c2ggRW5hYmxlJyBiaXQgaW4gUElQRV9DT05UUk9MIERXb3JkMFsxMV0uDQo+IA0KPiBQ
ZXIgdGhlIEJzcGVjLCBpbiAzRCBwaXBlbGluZSBtb2RlIEhEQyBQaXBlbGluZSBGbHVzaCBpcyBk
b2N1bWVudGVkDQo+IHRvDQo+IGFsc28gZmx1c2gvaW52YWxpZGF0ZSB0aGUgdW50eXBlZCBMMSBj
YWNoZSwgYnV0IG9ubHkgZGVwZW5kaW5nIG9uIGhvdw0KPiBIRENfQ0hJQ0tFTjBbMTM6MTFdIGlz
IHByb2dyYW1tZWQuIFN0YXJ0aW5nIHdpdGggTVRMLCB0aGlzIGNvdXBsaW5nDQo+IGJldHdlZW4g
SERDIFBpcGVsaW5lIEZsdXNoIGFuZCB0aGUgdW50eXBlZCBMMSBjYWNoZSBmbHVzaCBubyBsb25n
ZXINCj4gaG9sZHMgaW4gcHJhY3RpY2UsIHJlZ2FyZGxlc3Mgb2YgaG93IEhEQ19DSElDS0VOMCBp
cyBwcm9ncmFtbWVkLCBzbw0KPiByZWx5aW5nIG9uIGl0IGlzIG5vdCBzYWZlIG9uIG5ld2VyIHBs
YXRmb3JtcyBzdWNoIGFzIEJNRy4gTWVzYSdzDQo+IFZ1bGthbg0KPiBkcml2ZXIgKGFudikgaGFz
IGJlZW4gYXNzdW1pbmcgdGhlIGtlcm5lbCBmbHVzaGVzIGJvdGggY2FjaGVzIGJldHdlZW4NCj4g
c3VibWlzc2lvbnMsIGFuZCBoaXQgdXNlci12aXNpYmxlIGNvcnJ1cHRpb24gaW4gYXBwcyBzdWNo
IGFzDQo+IExsYW1hLmNwcA0KPiBiZWNhdXNlIG9mIHRoaXMgZ2FwOyBpdCBub3cgd29ya3MgYXJv
dW5kIGl0IGJ5IGZsdXNoaW5nIGJvdGggY2FjaGVzDQo+IGFnYWluIGZyb20gdXNlcnNwYWNlIGF0
IHRoZSBlbmQgb2YgZXZlcnkgY29tbWFuZCBidWZmZXIuDQo+IA0KPiBGaXggaXQgaW4gdGhlIGtl
cm5lbCBpbnN0ZWFkOiBleHBsaWNpdGx5IHNldA0KPiBQSVBFX0NPTlRST0wwX1VOVFlQRURfREFU
QVBPUlRfQ0FDSEVfRkxVU0ggdG9nZXRoZXIgd2l0aA0KPiBQSVBFX0NPTlRST0wwX0hEQ19QSVBF
TElORV9GTFVTSCBpbiBlbWl0X3JlbmRlcl9jYWNoZV9mbHVzaCgpLCBzbw0KPiBjYWxsZXJzIHdh
aXRpbmcgb24gdGhpcyBmbHVzaCAoZS5nLiBlbmQgb2YgYmF0Y2gsIGJlZm9yZSByZWxlYXNpbmcN
Cj4gbWVtb3J5IGZvciByZXVzZSkgY2FuIHJlbHkgb24gYm90aCB0aGUgTDIgYW5kIEwxIGRhdGEg
Y2FjaGVzIGJlaW5nDQo+IGNsZWFuLCB3aXRob3V0IGRlcGVuZGluZyBvbiB1bmRvY3VtZW50ZWQg
cGxhdGZvcm0tc3BlY2lmaWMNCj4gSERDX0NISUNLRU4wIGJlaGF2aW9yIG9yIHJlcXVpcmluZyBh
IHVzZXJzcGFjZSB3b3JrYXJvdW5kLg0KPiANCj4gRml4ZXM6IDlmOGY5M2JlZTNlZiAoImRybS94
ZTogRW1pdCBhIHJlbmRlciBjYWNoZSBmbHVzaCBhZnRlciBlYWNoDQo+IHJjcy9jY3MgYmF0Y2gi
KQ0KPiBSZXBvcnRlZC1ieTogTGlvbmVsIExhbmR3ZXJsaW4gPGxpb25lbC5nLmxhbmR3ZXJsaW5A
aW50ZWwuY29tPg0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0v
eGUva2VybmVsLy0vaXNzdWVzLzg5MDkNCj4gQ2M6IEpvc8OpIFJvYmVydG8gZGUgU291emEgPGpv
c2Uuc291emFAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni44Kw0KPiBBc3Npc3RlZC1ieTog
R2l0SHViX0NvcGlsb3Q6Y2xhdWRlLXNvbm5ldC01DQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBI
ZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+IMKg
ZHJpdmVycy9ncHUvZHJtL3hlL2luc3RydWN0aW9ucy94ZV9ncHVfY29tbWFuZHMuaCB8IDEgKw0K
PiDCoGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9yaW5nX29wcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDMgKystDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUv
aW5zdHJ1Y3Rpb25zL3hlX2dwdV9jb21tYW5kcy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL3hlL2lu
c3RydWN0aW9ucy94ZV9ncHVfY29tbWFuZHMuaA0KPiBpbmRleCAxOGQwZmRlOGM5OGYuLmZhZjhk
N2UyYzVjMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL2luc3RydWN0aW9ucy94
ZV9ncHVfY29tbWFuZHMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUvaW5zdHJ1Y3Rpb25z
L3hlX2dwdV9jb21tYW5kcy5oDQo+IEBAIC00Niw2ICs0Niw3IEBADQo+IMKgI2RlZmluZQ0KPiBH
RlhfT1BfUElQRV9DT05UUk9MKGxlbikJKCgweDM8PDI5KXwoMHgzPDwyNyl8KDB4Mjw8MjQpfCgo
bGVuKS0yKSkNCj4gwqANCj4gwqAjZGVmaW5lwqDCoCBQSVBFX0NPTlRST0wwX1FVRVVFX0RSQUlO
X01PREUJCUJJVCgxMikNCj4gKyNkZWZpbmUJwqANCj4gUElQRV9DT05UUk9MMF9VTlRZUEVEX0RB
VEFQT1JUX0NBQ0hFX0ZMVVNICUJJVCgxMSkJLyogZ2VuMTIgKi8NCj4gwqAjZGVmaW5lCcKgDQo+
IFBJUEVfQ09OVFJPTDBfTDNfUkVBRF9PTkxZX0NBQ0hFX0lOVkFMSURBVEUJQklUKDEwKQkvKiBn
ZW4xMiAqLw0KPiDCoCNkZWZpbmUJwqANCj4gUElQRV9DT05UUk9MMF9IRENfUElQRUxJTkVfRkxV
U0gJCUJJVCg5KQkvKiBnZW4xMiAqLw0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3hlL3hlX3Jpbmdfb3BzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfcmluZ19vcHMu
Yw0KPiBpbmRleCAzOWE2NzBlOTFiYTcuLjc5NTExZGU1NThkOSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3hlL3hlX3Jpbmdfb3BzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hl
L3hlX3Jpbmdfb3BzLmMNCj4gQEAgLTIxOSw3ICsyMTksOCBAQCBzdGF0aWMgaW50IGVtaXRfcmVu
ZGVyX2NhY2hlX2ZsdXNoKHN0cnVjdA0KPiB4ZV9zY2hlZF9qb2IgKmpvYiwgdTMyICpkdywgaW50
IGkpDQo+IMKgCQlpID0gZW1pdF9waXBlX2NvbnRyb2woZHcsIGksIDAsDQo+IFBJUEVfQ09OVFJP
TF9ERVBUSF9DQUNIRV9GTFVTSCwNCj4gwqAJCQkJwqDCoMKgwqDCoA0KPiBMUkNfUFBIV1NQX0ZM
VVNIX0lOVkFMX1NDUkFUQ0hfQUREUiwgMCk7DQo+IMKgDQo+IC0JZmxhZ3MwID0gUElQRV9DT05U
Uk9MMF9IRENfUElQRUxJTkVfRkxVU0g7DQo+ICsJZmxhZ3MwID0gUElQRV9DT05UUk9MMF9IRENf
UElQRUxJTkVfRkxVU0ggfA0KPiArCQlQSVBFX0NPTlRST0wwX1VOVFlQRURfREFUQVBPUlRfQ0FD
SEVfRkxVU0g7DQoNCk15IG9ubHkgY29uY2VybiBpcyB0aGlzIHByb2dyYW1taW5nIG5vdGU6DQoN
ClRoaXMgYml0IGlzIGZ1bmN0aW9uYWwgYW5kIG11c3QgYmUgb25seSBzZXQgZm9yIEdQR1BVIHdv
cmtsb2FkcywgaS5lDQp3aGVuIFBJUEVMSU5FX1NFTEVDVCBjb21tYW5kIGhhcyBzZXQgUGlwZWxp
bmUgU2VsZWN0IG1vZGUgc2V0IHRvIEdQR1BVLg0KDQpTcGVjIGlzIG5vdCAxMDAlIGNsZWFyIGJ1
dCBsb29rcyBsaWtlIHNldHRpbmcgaXQgaW4gM0QgbW9kZSB3b3VsZCBiZQ0Kbm9wLg0KDQpTbyBp
ZiB0aGlzIGRvbid0IGNhdXNlIGFueSByZWdyZXNzaW9uIHRoaXMgaXM6DQoNCg0KUmV2aWV3ZWQt
Ynk6IEpvc8OpIFJvYmVydG8gZGUgU291emEgPGpvc2Uuc291emFAaW50ZWwuY29tPg0KDQo+IMKg
CWZsYWdzMSA9IChQSVBFX0NPTlRST0xfVElMRV9DQUNIRV9GTFVTSCB8DQo+IMKgCQkgUElQRV9D
T05UUk9MX1JFTkRFUl9UQVJHRVRfQ0FDSEVfRkxVU0ggfA0KPiDCoAkJIFBJUEVfQ09OVFJPTF9E
RVBUSF9DQUNIRV9GTFVTSCB8DQo=
