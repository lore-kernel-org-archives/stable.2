Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00A356771
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737455; cv=fail; b=F5sH3xPfiTLi4Oe+70xghUFUFzjFjo82OZMgJmgBY0sEfmbvl5GXye/CPfMF2/SDkFcW0HmSi9WHjQvVRuYIJmN2HqFEVTrPp6UPVwosNUN6RhJlTfGwuK6gPNwrIXZkLMt4ut08WXDrmom9SIyQotKIb8ofDVVYuR6SRp97Z5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737455; c=relaxed/simple;
	bh=0XDM4pVWlN93BwkZyuHXsF5erDv29hwBmvMmTegD8iE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixzBXqYrGiISYuwA65Hwj2S5oywfww3ZKuzaoqel9LQUkuZsdRFvHhjgLBVX72QVv++RzK4qXHaXVRa4McvtymQd78zu4Dt2faC17jKJetxGNXnNmnHO17HOGVvg3EICI6LydPZxVrVzlcQ7j27udWLvViu7epxvTNC1mxdW7Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoW/R6xw; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoW/R6xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784737453; x=1816273453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0XDM4pVWlN93BwkZyuHXsF5erDv29hwBmvMmTegD8iE=;
  b=eoW/R6xwuf0TXfGNDIYZHfzdhA/H0GWVjtaKCwXHkQao99WNPkGurTGx
   y16U80UhuSaXXlCOcB8fa2v13FtSKAf1K3AsgaFLnw08jQZ5cXGdWH/8v
   A7wseZXv4zO7aaUYzrKr1gqK8ShejW0qEwiQllxHpOx9CjHD5tq0xENwv
   xALPLyfGrzFV0rGNUfoZu5MtZzcml9ob4tRVwUDZkv/tXIHnxnwBQtjAu
   p3XLZY/A0a9uchx83iBKwIVfYx7yyVZUfhiQ0DJ6CFLHSZfbr67Py5qN1
   df1hmTib3eNQOZguRvP07mNoIgoWozn4KnMsFi45SVjFkg4/FStAmznL9
   g==;
X-CSE-ConnectionGUID: 6vMmLPzWRICFBGZB/SeXDQ==
X-CSE-MsgGUID: DDoR+sutTqK7cugnqWyj2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96517252"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="96517252"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:24:12 -0700
X-CSE-ConnectionGUID: Uy+SbiynQ5iFOtjjClErPA==
X-CSE-MsgGUID: TjgSP31+R9Kc4p8jYEpqxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="288133207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:24:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:24:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 09:24:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIRM691DgX+Sg9kTr3Ui7tJ5RZDp+RghrhXGOF0bBe/Bw/CBctPxUVA10gqp8due0Tpp6HQNgu5JyJTcnPn4QbdBOYRuzHamZgfOflZoCLUo2N+QoyN3owbSiJkznb2bw1ly9csUq2jEGpRiPWf13ThyVhnSP6SQ4xIV9B0PFOkZAFoHCNvstRv4WXpzZv/9SXHdu68/b1kgukNdyLIwep8eZa5Mp6yi/LJzsFhIi5eYgKnlKnOHKa6kd5vvjx1PsIBaXW23gWjYadAmjSrYDa/00eOm0GniCF4mXdiLfx7EfOPSuW4O6OOvQCCw5+uj4frvsHButgtU6jWabUmaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XDM4pVWlN93BwkZyuHXsF5erDv29hwBmvMmTegD8iE=;
 b=S2rr5pXtgeDhNXkmqyzxz2aD355OnTZgBMAmqXXNfpnyuXVp9knnRZWZN3wJW/pSgjGPZD8tWoVL3ASDhhplDkjVICTsgqf8qpjNaKeYvJVHG/4XsoRDgDpko1uzHw75kofYev3VVR/Q7e0kUjEQjldyVBFWGSxr4W4iQgYPM6jyi+wqNt2erqmBQNPBB9Zhp3X1cUB/sA8707XTsaGuJddcfhLh9rqAO0teBmIX6Quy9nxBUnN/vnwpQIvZDkFvztVeDy6j9Ef1vq7ENCVXLBzdvPgGFL4hy8Gouh+BOZL54hY/R1qRMaGJw9YrY8eBB7ZWwcQ5TgMH+wL25UOP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by LVUPR11MB9591.namprd11.prod.outlook.com
 (2603:10b6:408:3a2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 16:24:07 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:24:07 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Grzelak, Michal" <michal.grzelak@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "johnfoushee@gmail.com" <johnfoushee@gmail.com>
Subject: RE: drm/i915/backlight: Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check
 for DPCD backlight
Thread-Topic: drm/i915/backlight: Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check
 for DPCD backlight
Thread-Index: AQHdFe4WZ3DJcK5RmkCOjDaHP5BC5LZ12wCwgAPl4VA=
Date: Wed, 22 Jul 2026 16:24:07 +0000
Message-ID: <DS4PPFE901A304F4502AA28ACBD80EA0199E3C12@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260716030959.436430-1-suraj.kandpal@intel.com>
 <837ba34a-35ee-57b9-02fb-880b35c1c692@intel.com>
 <DS4PPFE901A304FADD15BAEBC6B192C846EE3C32@DS4PPFE901A304F.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPFE901A304FADD15BAEBC6B192C846EE3C32@DS4PPFE901A304F.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|LVUPR11MB9591:EE_
x-ms-office365-filtering-correlation-id: c9bc8dd2-1477-4ecf-b42f-08dee80da77f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: yW6hSdn8osMwZ90PzWrRVSiaNLh76Xije2JwcwGlSbRm2qw2qC7qSUDOK6K3VOGPqqL+YF0sTvt76Rz4zcLHHsJlkKZK9p/F/q19rsFFCnLd+U+QssYTxJelYY9WtOyKhckMyEtu6Tw8kX9lq0XXMtF8/7mSeVmj8jyTN+DmoG+iXsPYmXmGU7j2MVQsazzsiWyIwKHrBvMxYs3hkdTb+JydPC2AFsz/cIegB65R9qDPogYxnQUr0IQHKCimXQ5X10Akk/94B+IIDeGUMqVoAyH8kJIAgc86pfrn0GuYMgjwUkLjyKdt3Qd3mQyJj00al4rCKdWpwm1LLsu9WR30qxRTIJBbMBJKLj6JW0suov/DZfooBm1XRxMpvBu6wcQUkT2GzPqHBXM51nGTte7Puhi3Tv3+srUsW/ZZca27KktMzKR3Ala+IOhMveNNZg2ByE/8Ch2fJdCbfZWr2ye0Om7OUsvqn8igpxI5YxbbWY35WbXKbZmvbIfbJa4OsKTuuvbJFrPlVm9YOO6pfb7R2C/z2k2Ny5de5I7LaRDrCmCsQSEMQVr89wwBKKVfsohqCPvi0AdRCg6vcMw9zpSJdb89/+AL4alHam5i/seWGElHtDCP44eOWpSgDSg9HIMdg2YhDRAr9sq7FS9661eJRpFP4orMuBTY9rRC6/lgeQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWk5Z29LenpDczlIVUFLR3ZKVlYyenJSc3ltZHpMRGxsSVVUWWtkUkNEYnFO?=
 =?utf-8?B?c3lnWWRpOHZIenNKdncvTk9hMDZuYjFleTlNRG1waGkrWmdIK0ZBNGoxMm91?=
 =?utf-8?B?RDVDM1dFZnluRit2TGxSWUJaaEZjTHhpNGFzSnlSTEZwQk05cTJpQUM5WFdi?=
 =?utf-8?B?THFYcTcwNGNwWWI3RjVEVGZ5QnZaNk5ncm4veWpWQUZrSU1HSnlVV2M0TzIy?=
 =?utf-8?B?Z3Yvb2JJVEtrUFljeWR6c09OcnRDNVlIT2QwTjdrYlJSWWdZTktNTEJuTGhx?=
 =?utf-8?B?U3JuTG10VzljV2svS0VxbkttZm16UnNhSW5BU3VWOWFpN1gwenZXeDZPOWFl?=
 =?utf-8?B?YUorRUlXWndrb0JsanNIMXRlZFNkY2tlWkJRam42L0x3cFNHcEhPbGFxQ1ls?=
 =?utf-8?B?NVlYSjdwUm5pc3VSSmVJcTVENENQQXNlcDJBUVhyVmp6NVFNV1lZQTV3Rk9G?=
 =?utf-8?B?TFZqYkdkVkIzQ2JOR2ZnaHZaNEhVbURjREhhVmduY01tbk9YZkdTWHphN0ha?=
 =?utf-8?B?RDQxZ21jc1cya2tpcDVxeW5FNHNVVEpPbFFaK015ZE8zdTk4NnZRclRvSkFw?=
 =?utf-8?B?M1ZrdXVoc2tIbnVoUEFVaGdpK0dRRU1WZWU0dm14VWZQVGdGMkwra3Z1Z05K?=
 =?utf-8?B?bGpidHFEN0RaYjlUbE1GZWgvMUlEN282dHNBZTFRWFJLU04vdmdXbnR4cGZD?=
 =?utf-8?B?WXE5a25kcVRWcHNnODBDYXhQQU85eWpzNzlaTnZ3UEZobkl0TklMOE9QQUc5?=
 =?utf-8?B?aHI4TDlVUU9RTWoxWWZ6ZEZtaHpRMkgrVzlSdXY5S2RXT3NmSGx0M2VJZVBn?=
 =?utf-8?B?dkVrQnJaWHRDcjFQNlBRcVBpWlNxVi9zVXJ4QzVBanJWMHdDb0txS2NMdlA2?=
 =?utf-8?B?TXJMWS9rSko1dFZBOW1CZUMwTUlnRUIrUThMY3pkWk4zZmcxcXpmbERGaHF2?=
 =?utf-8?B?NFE4d0RHMmpxdGVJNEJmVVpYSTBYdnpXOFA2c21IOXhCNjRSajNRMHEyMW1z?=
 =?utf-8?B?UDREVk1LcUlFNGZpa1RGT09BaG9YeDc5MVNjK00rU20yc2x2VXBmV3B5VkpN?=
 =?utf-8?B?WERBU25SUC9RZjMxMEUwQTVOYlRBcklJcDYzZ0lGSjZVZ1ozblQwNXE4MmVB?=
 =?utf-8?B?R1VLa3lKVnE2b0p3cXhUOHlmSDJhdEdGaGcrVWJlb2FLb2RVa0RHb0w5N3lV?=
 =?utf-8?B?TU9ONHM5MGYydTJva2Y5b3hWTlJhYnh5dng0clZLYm5TYUlVSWwyN3FTaTkx?=
 =?utf-8?B?QTNucFZQL3BEQTdDUFVqa2d1MGIxNFhzUGlXczl0TmpPaTVkYjkxTzRnYStN?=
 =?utf-8?B?YXRBNnh6cGpRc1ovbFhQMW5QMkI1VTNnbUdlaktqWjU5TVVUTmdRU1dXbkZ4?=
 =?utf-8?B?dzk4NDl5WXUwajByODMya3ZVRm1ReS90cndic212dlNWaEpLc1Q4Z3BMMUtD?=
 =?utf-8?B?WVNiUFZUWFdRUXc3V1A0R29KY3lsbGlRdy9OU3lrNmVaYlE1bDliU1hidDl3?=
 =?utf-8?B?bHRwS1ZYVzV6V1hGK20rTlpDSWZ6NXB3ZUpSSjVCREg1WFczK2Z2bkoxOHYv?=
 =?utf-8?B?c3V3M1hKVENiaGh0WUduN3Y3MU41WXB0TzAvNVQ1T2lYYUxrY0krUmU5Tmtv?=
 =?utf-8?B?T1AzMTRtYlRJZjNDN1lKbXhVK3ljR2Z6T0pZMnBNekc0cHh0YnQ1aE9CVW1r?=
 =?utf-8?B?SGpCQVY4R3VXblJXRzZrTUtBeENtZmh4UzUreityY0Y0WVRTNzRXWThQeE0r?=
 =?utf-8?B?OTRDNDVpMGZxWHVobFlUQmVUdUt0WkpzQlE2Q283SGR5RTNsQTBDZzhYVEtY?=
 =?utf-8?B?ZEQ5K2w5RjFFZ0tVaVdnNklwZnVNeG9paFpBakpCdjZQbnEzdlNhUnFYbExN?=
 =?utf-8?B?QWJJcFBoT1FxTXMyVkc5NE9hREpuT0hyWGhZTjMrNFc4Rm8reSs5MHJZUERK?=
 =?utf-8?B?ZW1INzB1Uk83M2RuTldHbXNxazJMcjVmL2pWUmsvK1FxNmhGczBiWVhUR1k0?=
 =?utf-8?B?VmIrN0ZtQUVGM1RodmtKeHJKNjh2N21GYnRPY1lJZWlNYitXYnh4R2s4YTFa?=
 =?utf-8?B?QXo4L2tyOEU1NU5pKzl1ZnN5cngwZVl6VUlUK0Q5MGN0a0RQWlpxVWdnMk1x?=
 =?utf-8?B?OENEd3dNMXR5d25LZmozdzZCRG12VTZTUUEvUE1MWndocmV2bmE3Y3lCVEJo?=
 =?utf-8?B?YlhtSS9GSVdEV01IalFuVmphVWQyeW9ydkRJRGVtMEowZUJFY09FSWRZT0pI?=
 =?utf-8?B?ZDErOUZISTJwUVVMWVhrbnd2RGp1WXlwVi95TjBnc3BDZzFjQUVjUWkzZVh3?=
 =?utf-8?B?N2ZCd2k4M0s2Sy9SakRaSmtlMlB0QVh4NDBwbll0Q1ZhUFpBTmptdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ANcL6/x/rrdHMn4bZ4puJVXniPPCpcfaL3CwXZlhH4DuUw0Mo41ycnk9vl+3gWRCJbCYOXBKFKraWAtnLe3JV9lcfS0iJz+gOt2rUMq0GRk3LFRt+HO6Bn6BUvOTeHHzbfG0TNIRZRmoATorAb92JZRFZGXor1pm0NP//7Xex6UawbkvV0etkR+ZCrtFFtoF0n4LTuwmGeXfbGczJQWVu1KjHGaf0Oao+FOn+xvJa0FuhX9GsvcWXN4R2IarE0AYn12QOxr8XwYUcgyxHB7FrNu0VQWhHKHF7nTgtW44K7YGJBD80B5Q/AHoijqHnPxKJi33NMt0lu94QbQtse9Vsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bc8dd2-1477-4ecf-b42f-08dee80da77f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 16:24:07.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJf2+XcenMDb3WOboPTiOd7L7y5L/TCRrxs/5g5170w5fq82UUHyqhCQT7HhbR2d6GZuU6e11Mcb/s6nK8kmDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9591
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSRTogZHJtL2k5MTUvYmFja2xpZ2h0OiBSZW1vdmUNCj4gRFBfRURQX0JBQ0tM
SUdIVF9BVVhfRU5BQkxFX0NBUCBjaGVjayBmb3IgRFBDRCBiYWNrbGlnaHQNCj4gDQo+ID4gU3Vi
amVjdDogUmU6IGRybS9pOTE1L2JhY2tsaWdodDogUmVtb3ZlDQo+ID4gRFBfRURQX0JBQ0tMSUdI
VF9BVVhfRU5BQkxFX0NBUCBjaGVjayBmb3IgRFBDRCBiYWNrbGlnaHQNCj4gPg0KPiA+IE9uIFRo
dSwgMTYgSnVsIDIwMjYsIFN1cmFqIEthbmRwYWwgd3JvdGU6DQo+ID4gPiBUdXJucyBvdXQgU29t
ZSBwYW5lbHMgYWxsb3cgb25seSBiYWNrbGlnaHQgQVVYIGJhc2VkIGJhY2tsaWdodA0KPiA+DQo+
ID4gbml0czoNCj4gPiBzL1NvbWUvc29tZS8NCj4gPiBzL2JhY2tsaWdodCBBVVgvQVVYLw0KPiA+
DQo+ID4gPiBieSBqdXN0IHNldHRpbmcgdGhlIERQX0VEUF9CQUNLTElHSFRfQlJJR0hUTkVTU19B
VVhfU0VUX0NBUCBhbmQNCj4gbm90DQo+ID4gPiBzZXR0aW5nIHRoZSBEUF9FRFBfQkFDS0xJR0hU
X0FVWF9FTkFCTEVfQ0FQLg0KPiA+ID4gSWYgd2UgbWFrZSBEUF9FRFBfQkFDS0xJR0hUX0FVWF9F
TkFCTEVfQ0FQIGEgbmVjZXNzaXR5IGZvciBBVVgNCj4gYmFzZWQNCj4gPiA+IERQQ0QgYmFja2xp
Z2h0IHRoZXNlIHBhbmVscyBsb29zZSB0aGUgYWJpbGl0eSB0byBtYW5pcHVsYXRlDQo+ID4gPiBi
YWNrbGlnaHQgdmlhIEFVWCwgc3BlY2lhbGx5IG9uZXMgd2l0aCBubyBQV00gY29udHJvbGxlci4N
Cj4gPg0KPiA+IG1heWJlOiBzL3NwZWNpYWxseS9lc3BlY2lhbGx5Lw0KPiA+DQo+ID4gPiBSZW1v
dmUgdGhpcyBjaGVjayBmcm9tIGZ1bmN0aW9uIHNvIHRoYXQgcGFuZWxzIHdobyBkbyBub3QgYWR2
ZXJ0aXNlDQo+ID4gPiBEUF9FRFBfQkFDS0xJR0hUX0FVWF9FTkFCTEVfQ0FQIGJ1dCBhZHZlcnRp
c2UNCj4gPiA+IERQX0VEUF9CQUNLTElHSFRfQlJJR0hUTkVTU19BVVhfU0VUX0NBUCBhcmUgYWJs
ZSB0byBtYW5pcHVsYXRlDQo+ID4gPiBiYWNrbGlnaHQgYWdhaW4uDQo+ID4gPg0KPiA+ID4gRml4
ZXM6IGVkOGJlNzgwYmRiYyAoImRybS9pOTE1L2JhY2tsaWdodDogRml4IFZFU0EgYmFja2xpZ2h0
DQo+ID4gPiBwb3NzaWJsZSBjaGVjayBjb25kaXRpb24iKQ0KPiA+ID4gQ2xvc2VzOg0KPiA+ID4g
aHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pOTE1L2tlcm5lbC8tL3dvcmtfaXRl
bXMvMTY1MDcNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1cmFqIEthbmRwYWwgPHN1cmFqLmthbmRw
YWxAaW50ZWwuY29tPg0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+IGRyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfZHBfYXV4X2JhY2tsaWdodC5jIHwgMyArLS0NCj4gPiA+IDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9hdXhfYmFja2xp
Z2h0LmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9hdXhf
YmFja2xpZ2h0LmMNCj4gPiA+IGluZGV4IDdhNmMwN2Y2YWFlYi4uODMyNDVjYjczOGU1IDEwMDY0
NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9hdXhf
YmFja2xpZ2h0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfZHBfYXV4X2JhY2tsaWdodC5jDQo+ID4gPiBAQCAtNjE5LDggKzYxOSw3IEBAIGNoZWNrX2lm
X3Zlc2FfYmFja2xpZ2h0X3Bvc3NpYmxlKHN0cnVjdCBpbnRlbF9kcA0KPiA+ICppbnRlbF9kcCkN
Cj4gPiA+IAkgKiBTaW5jZSB3ZSBvbmx5IHN1cHBvcnQgRnVsbHkgQVVYIEJhc2VkIFZFU0EgQmFj
a2xpZ2h0IGludGVyZmFjZQ0KPiA+ID4gbWFrZQ0KPiA+IHN1cmUNCj4gPiA+IAkgKiBiYWNrbGln
aHQgZW5hYmxlIGlzIHBvc3NpYmxlIHZpYSBBVVggYWxvbmcgd2l0aCBiYWNrbGlnaHQgYWRqdXN0
bWVudA0KPiA+ID4gCSAqLw0KPiA+DQo+ID4gV29uZGVyaW5nIGlmIHRoZSBjb21tZW50IGFib3Zl
IG5lZWRzIGFueSBhZGp1c3RtZW50Pw0KPiANCj4gWW91IGFyZSByaWdodCB0aGlzIGNvbW1lbnQg
d2lsbCBuZWVkIHRvIGJlIHJlbW92ZWQgIG5vdw0KPiANCj4gPg0KPiA+IEVpdGhlciB3YXk6DQo+
ID4gUmV2aWV3ZWQtYnk6IE1pY2hhxYIgR3J6ZWxhayA8bWljaGFsLmdyemVsYWtAaW50ZWwuY29t
Pg0KPiA+DQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXdzLA0KPiBQdXNoZWQgdG8gZGluIHdp
dGggYWJvdmUgbWVudGlvbmVkIGNoYW5nZXMNCj4gDQo+IFJlZ2FyZHMsDQo+IFN1cmFqIEthbmRw
YWwNCj4gDQoNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gQlIsDQo+ID4gTWljaGHF
gg0KPiA+DQo+ID4gPiAtCWlmICghKGludGVsX2RwLT5lZHBfZHBjZFsxXSAmIERQX0VEUF9CQUNL
TElHSFRfQVVYX0VOQUJMRV9DQVANCj4gPiAmJg0KPiA+ID4gLQkgICAgICBpbnRlbF9kcC0+ZWRw
X2RwY2RbMl0gJg0KPiA+IERQX0VEUF9CQUNLTElHSFRfQlJJR0hUTkVTU19BVVhfU0VUX0NBUCkp
DQo+ID4gPiArCWlmICghKGludGVsX2RwLT5lZHBfZHBjZFsyXSAmDQo+ID4gPiArRFBfRURQX0JB
Q0tMSUdIVF9CUklHSFRORVNTX0FVWF9TRVRfQ0FQKSkNCj4gPiA+IAkJcmV0dXJuIGZhbHNlOw0K
PiA+ID4NCj4gPiA+IAlyZXQgPSBkcm1fZHBfZHBjZF9yZWFkX2J5dGUoJmludGVsX2RwLT5hdXgs
DQo+ID4gPiBEUF9FRFBfUFdNR0VOX0JJVF9DT1VOVF9DQVBfTUlOLCAmYml0X21pbik7DQo+ID4g
Pg0K
