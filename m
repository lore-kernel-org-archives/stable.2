Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF643CD8BF;
	Thu, 17 Sep 2026 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678482; cv=fail; b=JkJget2jACNPLjj0fEfIO2WTaGE2hrB0yXF3Wv9oMLRDQnyvzKNWgCGqNZl8lcOkoRgTJR0r0257RwtKFZiPR5/1kWn9noZZii51fpVXKmmGsAHNoH2tvBTyKQeYg1t+qK7LgSJ4mhAsAjGXEHP8W1BGTr0kYhE7rBFQtf8jhhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678482; c=relaxed/simple;
	bh=hpL2uMI+KQ9/xdgVrhVvNpPpRpDVJd4hGKssGHmc03A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vif7LvSCZODGmasnzL8QWxIMA0Bgk48sekoW/HFIca2mdYm1lLeu4Ze9JPX6lsLYIdPmp0oDHse9EUr6QGvod3b7dy8s8hr6Xwbu+VA151vbhVgy/l8XAY8FsLlh0PDlY8536IPd4AS0jWNXmsCFDkC+iweA0UgetDdDds2pF1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHXpZ/Js; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHXpZ/Js"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789678482; x=1821214482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hpL2uMI+KQ9/xdgVrhVvNpPpRpDVJd4hGKssGHmc03A=;
  b=dHXpZ/JsHSHQPwyN4leXV+++D7PsEvDm5vU76Cg1ShliQy86eIiCFA3E
   eBUqKm6AKOIfv44caWH88eDSKJ88psK3ZHWYsj1dxB1BZIpq1JovdRQUd
   5gMiEjkK0BW5TieuNx3ZR8w3xNdwRrmfY4byzS8Awg6JJUbpfa4jWl/x8
   d9m2aR8GRsCzDMKk7kRTuDQGnLiHlYa5va2gLmbKzNlGXFe2jt2fSFR9L
   4bEXQ1JfokOejj6+PB+gP6Cv9W6LCmIEv1CVPPDcEtBxPFvqEFFqyVspG
   sEXHLx69IZOalHh4pR2b1wkF3hWNQWOLbPIZkAhLghZJ1u+CralEZ9amr
   A==;
X-CSE-ConnectionGUID: bEgVo8gOQROHBiAFbapSMQ==
X-CSE-MsgGUID: LEQuRia/SEqNV+ijC18FMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="657434"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="657434"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:54:41 -0700
X-CSE-ConnectionGUID: fIseNDXTTFyp6QZwY6dNyg==
X-CSE-MsgGUID: dzau87qvSZGmPf9wSULBuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270716761"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:54:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 13:54:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 13:54:40 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 13:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzJVDYmrbh+VlAEMzWDkGOGtx8Pt/AnQWem6/4/JVh7ggJTxjcbx1oPzAMN9C1yvLefw+JVO2dZyKCui+J24p2ArU8EpmmcUYxpLOV0mkivNpYJOt8/moMfAcQLo0Y4oVzSjCw6frWhl1gIfyi6FRpAdo8MS1+gHKK77jZImIxm2LZb9GUpM8bluTArkZlC617jd0qk3gDEhq7ulm9HIWwZmv9FAHNsDUsFy4QfN/viKl6DCmT5nXOVKx9oD8bVOR7BhiVYgR3GACLBuyVnJPgn2LMvxZLWByXdsT7KEF/B1O5f9exxB/L1N1B3zysgn3z5kX+aJ+4xrJeyPS08rDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpL2uMI+KQ9/xdgVrhVvNpPpRpDVJd4hGKssGHmc03A=;
 b=GHQzjPnjh6spNqrRaOX8v5/rfQT+VSdKN4V7VJwdbN0+qoePiIOcT/UvSfUfFAybmhM64vv11ISZBk40U2cWHbWwqbu1zpJNyZVa8Iu/mip7oNVY3YQ1XkCFGrY12cshBO3KuKLPIUAOMYKesUoX/pHVIQtnq5T6q9p5y4DWqiyLOGNS9LGjw3XZ4CV6CblDuBkejn3ns/XFqIultpxrrsgEY+G6Z1HfSHlTXrsP5l7etyBeYk+445DDapCH1jk+Uz5McQ1nVmY1Nkma7Tc+BINRpksdm7GWUyh2phu/5tous4Qr/AYDgWXPHpWX/V63LFBysA7Rte28c/b0ZAhyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 20:54:26 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 20:54:26 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "runyu.xiao@seu.edu.cn" <runyu.xiao@seu.edu.cn>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>
CC: "avifishman70@gmail.com" <avifishman70@gmail.com>, "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>, "benjaminfair@google.com" <benjaminfair@google.com>,
	"tmaimon77@gmail.com" <tmaimon77@gmail.com>, "yuenn@google.com"
	<yuenn@google.com>, "venture@google.com" <venture@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tali.perry1@gmail.com" <tali.perry1@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] peci: npcm: Initialize state before requesting IRQ
Thread-Topic: [PATCH] peci: npcm: Initialize state before requesting IRQ
Thread-Index: AQHdOu7/ZhF35egQq0mPgT25ZjXuEbbTV5GA
Date: Thu, 17 Sep 2026 20:54:26 +0000
Message-ID: <58aebcfcaba4c18bdfb34d47e3cd11d7250a7436.camel@intel.com>
References: <20260902152256.3591658-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260902152256.3591658-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: 1b2a2861-0441-4aa2-fea7-08df14fddc0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 2DpNDYY8EEmezB4Ip7Trt1+uj+Y5oqJv8DBNmBeWnwk9phpAQ/vmfWYbNS3hmFgvBVhoesAQmwXYBgrNghPfd8fDGOil5GmFQeFn7u/ZuQCwNpAwM8jSbg6ffVQHuVcccMkonH0d4SGBIicOH5Dp3meffdDBYfpMApJDuzCMdJfvBZoABsoEI2GtkUVdjSrdWk5bozaSbSEgMxnvf8hC7mvnHxnKRqe0YD9ylgodaTFAQrGD6x1rkfvOOhWYmndN9WSm6iKwH6SN49fy2GuMGNuMk64csl84ZIFGWAcm8VzlNDxNH81QAfJA7IDumashDZtWlt/4fBtRC+JpsqR2pkQmYwy1yJRDxmsKYwNN9ulFBV07ShD7ouv4nmF2VnGWcGkQWzkesg57tsWx7doyvk2xws54ZEP/GviTfnK556bRa9A8NFLhVVA34TMGxC3NVaQH8TF28i1bUFH2J70qjVsfCfZlzM20+Dx3h91UsKHtQIGBeI2FcZXpn4VjBvftRpYsDQvaV1j806IS2RITbdAtTurBuPdpVz7pKvYHY/AvR6Lc7LeOezSUh3ABgUayZauTPqhiU+A6mCLwhC/f+QxQqUXAHYWl/lVIelBxQOthdLUTAUcoAGOhXXBDiBzyd3WUTzYN6xprWOnAN3uEKPkqaHu/Q/dRmiCZSmzXdrxLQkDfMNWg8t99o1+ZsAGMxyLq666tayktcaWNWZSUhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JobVZLeW1iUTY3YU5QUW0raWVZeTNkYk5KSUcyM1NoaXp6L25ZeDc4bE1E?=
 =?utf-8?B?QjJ0TndHNU9ULzZWRHVSeEFabTZZbDZ4NEgyNjVWTnJ0ODNSTDM3VlM0Ymhn?=
 =?utf-8?B?TW1RNVZHUW1QQXpDZFo0R2Z2ZGRNTnlJNFFTZjdBNm5KMmVjUVM2emowd1VK?=
 =?utf-8?B?RWJ1akxUcHVpTDRqcDN2Y2N5aDFkUEo0NE9WVFVxTitsb2FEa3dMSjBXTGFp?=
 =?utf-8?B?UXpycWg1UTdwUE55eTg0dEUraVR0TTJtaFZieFl5UkFXYnJtRHU4cWdIK0d3?=
 =?utf-8?B?Y0s5dHVINU44RjhvaCsxOUZnWHlVOWJlL2Jzb1FKUDBkRWJiZDZkZEJzZ2Vq?=
 =?utf-8?B?Z2JIQ3dhdGFqRk5EU1RGWWpYanVHcGNDYTMxdjFWSG83eVlsZXdDdVY4VTFC?=
 =?utf-8?B?a2dxS2NXQndhMjZIdm5qQU5UVWZtZFphcHRsMUQwbXRMTXROTjJwcjlXUXZj?=
 =?utf-8?B?T3ZUcHNmaHpuUXViRXdnRmxFSEVVZFFaaWovRGxMT2hpTHhBVlk4czFZVFdS?=
 =?utf-8?B?VU1ONHBGREJPV2dXV3Rld3ZpM1p5M3ZGa0dKVGc3WkhWY25pc05hQ2tEeDJF?=
 =?utf-8?B?YVRHZWowN3BZc3ZGbG5LWmtSZU1DVmtRcFZyM29ucHdtdE55UG9wenIydjhz?=
 =?utf-8?B?TUNvUnN5U3ZQZnZxMHNJYUcyWDVycjBJVGRoOVpuZkdxVG5qdmd5S0tTeTFN?=
 =?utf-8?B?QzBIVUZaYTR6U25kcVB1QWtBV01xa0dNdjJtYjFuaUZTMGVtVCtWRE1RZWl6?=
 =?utf-8?B?YzZMYldPUHJldmFQbHc0em9RRUd1dS9DMmcxNFRrVys5RGl3YzJoNlhVamFm?=
 =?utf-8?B?TElTQmkzRThBV0UwNlpwWVVBVFZQSWQ5K0dwUHlrWFZCTDRqbUNCYWdHODJx?=
 =?utf-8?B?TEF2RDZCcTJ5U0U2eUh4ZmsvZzlYeGdLcFZBT3BmWlhIeEhWQkpvTFN4c3lM?=
 =?utf-8?B?d01QUFF0NW45QVNKK0VYWVROYTlxU3VQdE02T3BUSEVGZStRaFpKdDU2SWtO?=
 =?utf-8?B?cTcxdXdRRjNvRmZkRlhMS0l6bmxCSVNRQVJCS3ZVeU1IMGVmbE81ZTh5aTV3?=
 =?utf-8?B?eVB1ejl3MS9rbFNmVGxGU29CbjhhTUVWOWRvTmEwQTNKRDJyaGtPUWxJUGpp?=
 =?utf-8?B?bnhxZzVpbkNmRGkyNTA2UlhHaTFveWplanVLMitvSERDR0cxc2NDWWxhNzJ6?=
 =?utf-8?B?dzJGbWJKd1hobmlZdllPeitaQzJtcHE1N3lVeGVROVJpS3ZXMVMwUHFaSUsx?=
 =?utf-8?B?MkZvaHZkUHEzM3RoM2xOU0dQM1plcXlIMlVGS2llL0djZEZtOWprVkorU25Q?=
 =?utf-8?B?bnpWb3lEdkswSTNRdUNxNHZKOC9FQWRkQ3VNWGhUUDhSY2dFUXVpN3J0NXlz?=
 =?utf-8?B?RGpiS292TkJ6YWdXdHZQK1htSGpmUTAxcURWcUhVZ2pDRU45amlNMUpBVHZn?=
 =?utf-8?B?OHVXSFUvc0RlbHh3MVlhZlhsRFJHdVNsS0VMSDlXNXhZaDhjaUxqRytFblNr?=
 =?utf-8?B?d1FpMkRIdGxNNEhDQUo0TDM5aHhFNXRVVXlMNzJkMCtydUFXcXMyZVRDNWZG?=
 =?utf-8?B?L3FjRlpjYkxEc1dHRjVFUy9GeWswcENrNHkxdXVhc3FDcDV1NmNWNVc3SG5s?=
 =?utf-8?B?R0E2ckVpY2wrcjVWcmxDOEdBSzNzS0RZL0xVR3I1M0hyT1ZnV1hmUjZiOXJH?=
 =?utf-8?B?bmlCc2FmSGJwR0Nod3FpcDBqWmEwWmJ0dytIQTNJeTlzdG1vTHUvNEx3UVhk?=
 =?utf-8?B?Uk9Ha1hUY3VkMkZYQXM4enE1VE56eEJHQTVENWE2aTFBbmdoeGY1YVdqSUp2?=
 =?utf-8?B?RzhBekNLZi9ML0YyQlNhV0FybmJvS0pqc1oyTG94cjY0a1BpQXBUZ0NGQjlI?=
 =?utf-8?B?UUVmT05xWDRpUHIrYVJaVzJzQWxmODlhL2lXdTJXM0pIdzRrUUV1eExRYks1?=
 =?utf-8?B?aklMNlhDdWNESjMyVk1Ma1NjQWxtVVc3ZzVLN0ZOV2IraWFmdHF0M3J2Tmtn?=
 =?utf-8?B?SEdUSGR2MFdjMldZRitIeWJHSS9SbnFBV25OU2Uxekh3akhhQjVocnVtTTAw?=
 =?utf-8?B?Z3FWQU1mTDJDZGZCN0hyenI2Mnd1WUNGUGJVNDRVbEh5OTAyd0JwQnpiTVRq?=
 =?utf-8?B?U0xZMlFXL3FCNXZPZzdxeUZjNlMzSk4rTlVkUnRlV2pwZElVWG5Kc2tYRXNJ?=
 =?utf-8?B?aHVwRktNeHRQUmdZeFRDTk1TdEFlb3lKWkFDUzFuN2ZIeUlOeEVYbEg2c0Fz?=
 =?utf-8?B?YjQxSTJhUC9QY0tzL1NIMUhSZmg1elRkVWhCNjdyZllmR2Y0U1g5UHhjVmhm?=
 =?utf-8?B?bjkrazZobTRjMDEyNTRocVlQUHdTSHRCN014NTlUQlhmSGRiKyttRDFFWlN3?=
 =?utf-8?Q?kE1rdPn/1ClwR2Mw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E459C34D3A444A41B4C0A1D13FA79395@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lLOxHn5pKQKzyzOy+1gTmpSdMUPq9TuKBxFhLpEeM5slBly6V+Bhwctg31D0d4LTm96x/qSOseCsxkKkeBfU2EJ56OAZAyrpvnF787Uyk9+LqVY5mx19hvLqtE2BA2UqjTsI5rauXf25C+mWWdPrbJ3MRQcGF+nxBOBP/2iXVkNHA71zOGdgdptSgfnLEVMZHDISa4aVvoANcppymWa/acs/kA6M4HDtd/DXfdmHDWwDAwhMEbwP0YwmYd9CgwCuCuc9NlJl0HwHYk/uRRNqK5boC2I2FBUk8Y7zbr30ncAZyrmIXz1G/6QaN0/gnSRaTgb29RqBi9HNgH3Uc+ku+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2a2861-0441-4aa2-fea7-08df14fddc0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 20:54:26.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMNoc2U4OHXRZeVHK3j403nvvKRdrSvIOZz0rSJK2PCxNy7JSJV3IPToSe/jEhVqUVVulo09XaW5KbJWqHJvBffkntK29cnFGcLe4+nlDFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDIzOjIyICswODAwLCBSdW55dSBYaWFvIHdyb3RlOg0KPiBU
aGUgUEVDSSBpbnRlcnJ1cHQgaGFuZGxlciB1c2VzIHRoZSBsb2NrIGFuZCBjb21wbGV0aW9uIG9i
amVjdCBhcyBzb29uIGFzDQo+IHRoZSBpbnRlcnJ1cHQgaXMgZGVsaXZlcmVkLiBJbml0aWFsaXpl
IGJvdGggYmVmb3JlIHJlZ2lzdGVyaW5nIHRoZQ0KPiBoYW5kbGVyIHNvIGFuIGVhcmx5IGludGVy
cnVwdCBjYW5ub3QgYWNjZXNzIHVuaW5pdGlhbGl6ZWQgc3RhdGUuDQo+IA0KPiBGaXhlczogM2Ux
NjE4NGExYmQ4ICgicGVjaTogQWRkIHBlY2ktbnBjbSBjb250cm9sbGVyIGRyaXZlciIpDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEFzc2lzdGVkLWJ5OiBDb2RleDpHUFQtNQ0KPiBT
aWduZWQtb2ZmLWJ5OiBSdW55dSBYaWFvIDxydW55dS54aWFvQHNldS5lZHUuY24+DQoNClJldmll
d2VkLWJ5OiBJd29uYSBXaW5pYXJza2EgPGl3b25hLndpbmlhcnNrYUBpbnRlbC5jb20+DQoNClRo
YW5rcw0KLUl3b25hDQoNCj4gLS0tDQo+IMKgZHJpdmVycy9wZWNpL2NvbnRyb2xsZXIvcGVjaS1u
cGNtLmMgfCA2ICsrKy0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZWNpL2NvbnRyb2xsZXIv
cGVjaS1ucGNtLmMNCj4gYi9kcml2ZXJzL3BlY2kvY29udHJvbGxlci9wZWNpLW5wY20uYw0KPiBp
bmRleCA5MzE4Njg5OTEuLjNjYzRlOTU5YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wZWNpL2Nv
bnRyb2xsZXIvcGVjaS1ucGNtLmMNCj4gKysrIGIvZHJpdmVycy9wZWNpL2NvbnRyb2xsZXIvcGVj
aS1ucGNtLmMNCj4gQEAgLTI1MywxNCArMjUzLDE0IEBAIHN0YXRpYyBpbnQgbnBjbV9wZWNpX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IMKgCWlmIChwcml2LT5pcnEgPCAw
KQ0KPiDCoAkJcmV0dXJuIHByaXYtPmlycTsNCj4gwqANCj4gKwlpbml0X2NvbXBsZXRpb24oJnBy
aXYtPnhmZXJfY29tcGxldGUpOw0KPiArCXNwaW5fbG9ja19pbml0KCZwcml2LT5sb2NrKTsNCj4g
Kw0KPiDCoAlyZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHByaXYtPmlycSwgbnBj
bV9wZWNpX2lycV9oYW5kbGVyLA0KPiDCoAkJCcKgwqDCoMKgwqDCoCAwLCAicGVjaS1ucGNtLWly
cSIsIHByaXYpOw0KPiDCoAlpZiAocmV0KQ0KPiDCoAkJcmV0dXJuIHJldDsNCj4gwqANCj4gLQlp
bml0X2NvbXBsZXRpb24oJnByaXYtPnhmZXJfY29tcGxldGUpOw0KPiAtCXNwaW5fbG9ja19pbml0
KCZwcml2LT5sb2NrKTsNCj4gLQ0KPiDCoAlyZXQgPSBucGNtX3BlY2lfaW5pdF9jdHJsKHByaXYp
Ow0KPiDCoAlpZiAocmV0KQ0KPiDCoAkJcmV0dXJuIHJldDsNCg==
