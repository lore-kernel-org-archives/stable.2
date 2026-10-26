Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793027860;
	b=On+FAUJVIKUXMK6DDRIUiXvZsCq51aUqN0dkgL9NUQ7d4Trd2z0saDL3VKfVUXy9DoF+
	 Pyyl5adu3OmJ2GlECrdcSwKoQHumSaRFEx9kzeN/N3NKNntX6fIdUt6C+Ax9ScVXA6NyF
	 rpRjIxr2m83A+6selmRxbgibQrd7Z9W8vAtbqWqaeeTKfnNZyGdFSVHHwtBFGzbd1lDgL
	 QpA5eQATenEK9k+lSIQ8wTOl+qs9F0ZIW2PNigoAcP7E4n3a67BcMj7ecUDEDavhk57GC
	 kVEWyJ+NDw9lV0yz3T1+97Nxx5WDO9OJ+ujuKrYChe8PTE7iJR1Bi3bXAG5QiBp3abg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027860;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
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
	bh=iveSz/pxfigEGN74P93mIDsBYkKZvAhdIm8Y4Wy0AUc=;
	b=JSCrWHAkAWRYgPfpF3syVvql7N8Lyj31T0XqcFmD8k4nmADL40ruV1QbkeRz19lXeRzI
	 ExFUiPjAoEDOEqXag5Pf47Tc6X4gtuP+hVj6UsKFTFU/kJNhjcImfl+UNePbm0zmafoFh
	 wEW1ftkogaxnSTfJfwALc9eBASkvGuaxjeCiKUOb1n/PlQKM7ZLbwVnPQrc1MGfHuOrMy
	 57LPKdy+ed2MXaRlr9G6UtmMkrkQkn8eMax8NbwBDmDAw/tgsrqWqUVT1kWl5OIEi/++b
	 YHTE5w4AIzA3E3fWZAdc4Ed0W0f5gvXPHSKOFnPjLyySuBvwHST1SzVvH4AVo/SHWgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HelpQhv5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CB606A31A;
	Mon, 26 Oct 2026 15:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 654CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HelpQhv5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793027858; x=1824563858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iveSz/pxfigEGN74P93mIDsBYkKZvAhdIm8Y4Wy0AUc=;
  b=HelpQhv50gySSv1TUkrgcdSIDQH3/HL1QCBAmk3UBWZvRt2uOoSwh/o2
   I6EDFeWx8kW12Tu90lSYECMwRRPvhMiSlETDDrpbppE1twG++bVvapnSw
   MW8LuNA79ORfeJibZ5cm2bdvtdC8EnlzocKem0Fst+Bam1XHm0aYxh6GX
   +RMlX2zhDO5plE/r526ParFABAYqvvvvO+pyb41iNpJrJJcUljW7of7ip
   pc83joe5Nb/4oO18pRaQiSfYY8BhnNQLzkj6TSUfjEds9FqJWh73TCURj
   fhZvf7krxKc/vWEZuXWMPQT4hit49vN6k29lH+Xp12rzy7Cgc0+hNKIab
   A==;
X-CSE-ConnectionGUID: GLaC/svTQkSwUQrrxKd4Cg==
X-CSE-MsgGUID: bNQWx74jTIyivWGspGVklQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1693093"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1693093"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 08:17:37 -0700
X-CSE-ConnectionGUID: IUlt18OpTdCZqN9o5Lt/jw==
X-CSE-MsgGUID: UIQDuXENSxOIvzdYGKMgrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4239313"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 08:17:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 08:17:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 08:17:36 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 08:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr00vG9fQMAlY2QXj/AfZSKpyiXdtWZ6vgEirTzUZAWVBlh05RXXLbrJ01iLEzoyRvmsmHECKcczA6nwHmH86uyOBhrrSNXT1t4R2CQQjUiSh41Fbz1IZHsymqsfZaUCAvNYgZI9cjNH40n6pQvgsLdTABgnyfys6JWU2gM4y1G9iegGVpIqLuqoJDGGUR1wQFfEUMujZhqcCoNw90V5JE/gpxuexN7xUx4hH7Uuyj14V/pcWTGcyq3ejLTVS5tnb7HvHmTFJZ8Bb3ymvamXPmgBu5lSHK6aY6LIqKPIrPXUY0JEZ5ZfqsgKsxUJltV02F/I8qyhttitwYZC4e5mpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iveSz/pxfigEGN74P93mIDsBYkKZvAhdIm8Y4Wy0AUc=;
 b=AZUh3F5vIY+aA/Sn2RdH/so4va2XQ6jqlppg8WJB+cf4nBBoBVjPURqVGt7D5c6roIPymRC6iOu4tzQtDuP8rMJQ/xRqMpNkLDLwNGKhmAcMC6gM8UTPyd9dEmS2vqI2EgB0yJfXJIrQdSVpNw2czqhEBcGECVJmrtjgV7HCimGPlP4aPBhqPYSh/ZPArIG04Lh3k8iFc2ak4iP13KeEKb4a1vatnkeGOwI1DYPDlekzByS3e4FGgnRXNRjzMQkbNnci8TGKLi6VjCMOH8lEV+zUHfmS4FIr8aHoryyoHfWw1B+jRFPy99ixvoU9W1cWhMLVjJRdujOIb3PTRjRiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:17:33 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9%5]) with mapi id 15.21.0546.017; Mon, 26 Oct 2026
 15:17:31 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "ch@murgatroid.com" <ch@murgatroid.com>
CC: "joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"jikos@kernel.org" <jikos@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Zhang, Lixu" <lixu.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback removal
 with raw events
Thread-Topic: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback removal
 with raw events
Thread-Index: AQHdZV0e8mR7gmBdW0qNGzKc9dFdlQ==
Date: Mon, 26 Oct 2026 15:17:31 +0000
Message-ID: <76a9ab9657249508821a0f023f56f1d1b2da61ac.camel@intel.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
	 <20261019023420.83976-2-ch@murgatroid.com>
	 <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
	 <CACw0PsaJr6E0Y3AXoGKDUiKp4vsaA+GEJjPqEhYuSoKqDp1jUA@mail.gmail.com>
In-Reply-To: <CACw0PsaJr6E0Y3AXoGKDUiKp4vsaA+GEJjPqEhYuSoKqDp1jUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA2PR11MB5098:EE_
x-ms-office365-filtering-correlation-id: f6ea3779-322f-44fe-20d9-08df33744122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|261026135527099003|261026140227099003|261026130827099003|38070700021|4143699003|11063799006|56012099006|261021135927099003|261022113327099003|261022075727099003|261009223027099003|261021130227099003|261022105027099003|261022115727099003|261021133027099003|261021123027099003|261021121427099003|10067099003|261026121527099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: ZNpQ6dE6P8WA9m91HsaQH8Ox/Ikn74l3nmbnXFOlcHS5UilMuYMPjYWfFzNypy2EfxFcnl1Hs69zPd0wPDEwhpRMkqoE/g/PtJWBgD9Drjaa/vEGdKqxPcWP9L2nC65wnlAhHYPyP6Ikxhy1BMinz5XdlmcvY7DqwmJ1O065hsZZvKUFu3snVk4jaM4FNRzDUBQxn4HGyHaVArm7vILEcYSoZf2UNdt4I3enwkNcQ0XzuyEdld5KbnXWxPpWDqgYUiDfW/yst0yOnMLgP1hFipw4WECQ0kgcuwh5G0s1gC9oa0pV/ivuLl77HTVqKNzjh9bvmzrCmIT+2IXQh8fLrOnbQvBBmwrzD219SgmdQ+M3HamKbb8oaYgT3ZXgZDZE5vl3ADd0Y9qAWL5Zqv/mZ5a+9mZyU8VF5U+j9xY0EbO5fiTlxFjmlxQqvythuYRQ8HgMRTib7OvsDZ3ythStaEvwXCE6+jjm/UpZemrd59c8HGAQvEHe3xgXZuI90VLoCvlObWZzYQxWNUuJrkhTfVQ8ieKwXPR6y8NZ/XoxjuKpyxkbWJ71vy1AqjFwPklJbe8xG1FabjFlOgSu5QreKslqPY8RqGIH/mFXi414iU3dkEt6tGiNaSVU4XtKn3FaijnBRuM5uMRr0eEz9/b4kXGfUYSp5Gzftnr1csP3ffZNzZZUHsIj0lKy3MA6s7vRt0NEI7yoL/oB8EPxIzkbFuJjb7jlAplTe6v5RysF8Ww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(261026135527099003)(261026140227099003)(261026130827099003)(38070700021)(4143699003)(11063799006)(56012099006)(261021135927099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021130227099003)(261022105027099003)(261022115727099003)(261021133027099003)(261021123027099003)(261021121427099003)(10067099003)(261026121527099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmJHc0ZrOTFDUWtwN21VcURkMi9kb3cxYllBZ1dSMmlVVkJaQy80Y2FtWUkx?=
 =?utf-8?B?TkVrcnBkYnR1QzIycm9jMGxXb1dtV3FjR0ZjUmx3amtzKzFSNG4rVGNGeHll?=
 =?utf-8?B?MFBHOVphNXB4L3l2NTBjVWI3ZGo2RXY2bUtmb25kV1pVZE5tWGZkNDVPTXh2?=
 =?utf-8?B?anArdEVwcHVtSFdrUDNrK2NiVElmN1QvL2t6bWdGbHVFTmJES1ErTGRUNXdw?=
 =?utf-8?B?M0dqZkdobmkrOTR6empaMFNlcW9oZ3ZZS2s4MmVmQlkxWXhLa3JCR0F2akVE?=
 =?utf-8?B?NEd3N2NCZ3lZK2N2MHgyWkFibnJYSzhLSU4ycHRzdS9lMEUzblN3UTY1Q01p?=
 =?utf-8?B?SFlOSUFjczBlTENNN1ArTjhJOHB5b1BWOGxYSms4YjdpMmk0OERVNlZTdllG?=
 =?utf-8?B?QTdwc2RwZkFGYjNzYUtnWW0xUk5IWndHRWF5UmhVbkoxd1U2eVdVVkFKNHE1?=
 =?utf-8?B?NCtFb1NZa0N6N09DMDYyVi9qbmRWRUc2aUJBSHpNVlZ5N004VEY2OFpFYlN1?=
 =?utf-8?B?SVBWeGNqelF1ZCthM21zZmlWSDZJTWNTZUE5cjRobVEybkZFSkgvWGdkZjNk?=
 =?utf-8?B?S1N4VU1BRytHb2xsN0Joc2dicWpOV096emJyV0k5QVljT3pOZ2Q3ZlhBWmYr?=
 =?utf-8?B?d2hSVVp3MnRoa0VpLzNDR2E0NFdYTExsNFJoZUNWOXVmdFR1Vy9VdjdTRzlG?=
 =?utf-8?B?bE85U2VRU1g2aW5Kbm9uVDMwbjk5UnpLcW9MbFU3NTczUzJVS05SOTZFUEZn?=
 =?utf-8?B?Y0kzbTY1WkV0eHJPSkhrc1crTkxnbjlMS29ZT3RSQTVIOVZlTVdoQ3EyaUR1?=
 =?utf-8?B?SkZCcDZBeUlYUERqUlltVmdwaU5PNWMwYlhvWWNJRzMxZWY0YUlIZHhwL3FD?=
 =?utf-8?B?QmNSNWtkWmtLOE15ajRLdS9LNkxxbzVjcXRNdFhUOHFZcWRhdzE1SmNtMzRz?=
 =?utf-8?B?QUZTZmVzdE5IbVhtVk1CTmRYenF5bUlJVzA3R2J5clFYanFrYlRsbVhiaG1Y?=
 =?utf-8?B?b1hUeTRaSmtwQ2dEdFVFYnlVRXdYOGpNN1pVeXZheUhEVGxQS2hWU2NHQTJ5?=
 =?utf-8?B?aWRqTVpZN1hoUTZpd29RWFVScy9YdWFnZmNUTzBmV0VDaFBiZVFpSTMzQ3ZS?=
 =?utf-8?B?eCtQUkRTeFRYOGpuWmxCeWg5RkUvMlFYTG05YmFKbHZ2Ty9LTkQ5ckEwSm84?=
 =?utf-8?B?dU9weUtkdlF3eWoxRE05VFlZYzE0WG84bXFDdEthTFZlRTVIUGk0cE9WN1Mw?=
 =?utf-8?B?VVhRNms0QVF3bitnYWVXNmwvNkUzSTNPOGo1aE0yMHRIS2RUL2tUWjJDK3NL?=
 =?utf-8?B?dXdWYXdEekpmWmVqVm1XeUxLU043N3N1SUtWWTIvenBzdzNxVTg4c3hlL2Z5?=
 =?utf-8?B?amxSdFp4d0lNWVVTZ3UrWnZQcDRFWVBlZDJRNkZ2aUpqaDJkbmYyUnpSZW1q?=
 =?utf-8?B?NEdpaDJjRzQ1QmlpMU9Lb0RrSmx2emVmaEl0VUt0MWp5SFhUVXQ5L3pTQUEz?=
 =?utf-8?B?bGZOWDBSQnlIUUxIcUlEcVBiRS9vbFNzVkJ0ZmpnZmpOQkY4ZU9uMloyWUlx?=
 =?utf-8?B?aDYzbm91Q0UyWXlJUEZYTEoySndMajVFaFB5dUdIL0g0Sy9KQWs3elkwdlE3?=
 =?utf-8?B?TGxKZDZrbWMzMHpWVnVxdUJ4bENPdXlEU0pkL2pJYjk5NThTYzJkb3V2QnE0?=
 =?utf-8?B?ZVlscjBwUWtGbWdJSGUrNjY2dGc0WW5vY3F2Z01Ed1ZTY254WSt6Y3h3Y01K?=
 =?utf-8?B?QVhhRkxOcVZFRGNjY3JHQkw0STExN01WbDJxeEJ2aWwzSWV1OUYxMzVGc3Fo?=
 =?utf-8?B?dVYrekk2R2pmNEJXV0ZqVjNDYTZhRnFaQjFXMHhPdjVSWS9ILzd4SzVzUTJS?=
 =?utf-8?B?bUlMWUUrNE1QWkQ5M1plV2Y0eVZLRkJoM2xJdG9aa0t2bHVTUlkxcGovcHJV?=
 =?utf-8?B?SjdaQVNzOGNCN3h4cEhmc2RZN1hSWjlMZURIUlJCYUVvcVhDakN2TWVBaGxL?=
 =?utf-8?B?Rko1b0JDcldkTTF3aUcwQXN6WGlFTnZ0VWE5d0pSNE5nZENIc3VpY0MxZGg0?=
 =?utf-8?B?aFR3QStkN1c5WkpmVFk2K055RFd6UHcrdzNBajV5V0xxSzcyR2JUOC9OWGov?=
 =?utf-8?B?czI5M0tlbG5PMUJ6d3hseUQzcWZiUjIyd0ZXc09qdldnS1duUFQxNDBNMjZJ?=
 =?utf-8?B?Zkh5bnJFczYvSktMNnFaYm15dXdCeCtMdldYT2crTk54MTBCcjhBS1Nibndu?=
 =?utf-8?B?SC9qVTFEdFViK21nRkI3YmFjSGNMMzlyakl1Z3Z5OXZ6QUhWTEszWk5PcHdw?=
 =?utf-8?B?aXl1RW5obHBKL2JUeHBmMHNUbSsydFJ0d3N0UStQVmptNmh6bEwvMXlJKy9N?=
 =?utf-8?Q?Swyyi0JNR/0mU74U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54780CDB3B5CC14197719B17F65645AE@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: DFawkIzRLXfWCSS09Z0kj8OjJn85YsFliJpEoK6WIcC9mmtRofUNLywGaNjys7+uyDkLJUls3s+d0A9d8R9RVuA94mDlHzOgq/Ak4+Ro6byW8rpQeWrO56QZHMSJpcWEe5P/nsPDc5p+WZzQH0N4h4uqIGk7BKRcQqOuzl4WVqIZ3Tihhi2+r5gfJZacfGqEgx+HLMNYAyG4vhy0qrLsETVSTPwebqaqwHsWCg17R8H5TI9R9PhvfBPuRisr1fFg/hzvyDu7rH7d7Mrs2rq7vDG4ID3mnsToL+5LDqIHU5j7wJjtJ51o4ZPc+D/0/96LyLA2r2bDSkNvF8xtDcaHIA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ea3779-322f-44fe-20d9-08df33744122
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 15:17:31.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YQLH+90wwxrExQ1uUN5Pzk0+mBC9KKe1op6rSorqBDoDGJBrPPz/HeiSkziubbi7COa+A280MpibEK2Kr88c7RC0MA6qXi8b1fk4y3gr+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDE4OjU4IC0wNzAwLCBDaHJpc3RvcGhlciBIb292ZXIgd3Jv
dGU6DQo+ID4gwqBJcyB0aGlzIGlzc3VlIGFjdHVhbGx5IHJlcHJvZHVjZWQgb3IgaXQgd2FzIGZv
dW5kIGJ5IHNvbWUgQUkNCj4gPiB0b29scz8NCj4gDQo+IFJlYWwgbGlmZS7CoMKgIEkgd2VkZ2Vk
IG15IGtlcm5lbCBzZXZlcmFsIHRpbWVzIHdpdGggYW4gTUNQMjIyMUEgdXNiDQo+IGkyYyBicmlk
Z2UuDQo+IA0KPiANCg0KQWNrZWQtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBh
bmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KDQoNCj4gT24gV2VkLCBPY3QgMjEsIDIwMjYgYXQg
NjoyMuKAr1BNIFNyaW5pdmFzIFBhbmRydXZhZGENCj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAbGlu
dXguaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTdW4sIDIwMjYtMTAtMTggYXQgMTk6
MzQgLTA3MDAsIENocmlzdG9waGVyIEhvb3ZlciB3cm90ZToNCj4gPiA+IHNlbnNvcl9odWJfcmF3
X2V2ZW50KCkgaG9sZHMgcGRhdGEtPmxvY2sgd2hpbGUgaXQgbG9va3MgYQ0KPiA+ID4gY2FsbGJh
Y2sgdXANCj4gPiA+IGluIGR5bl9jYWxsYmFja19saXN0IGFuZCBjYWxscyBpdHMgY2FwdHVyZV9z
YW1wbGUoKSBhbmQNCj4gPiA+IHNlbmRfZXZlbnQoKS4NCj4gPiA+IHNlbnNvcl9odWJfcmVtb3Zl
X2NhbGxiYWNrKCkgdGFrZXMgb25seSBkeW5fY2FsbGJhY2tfbG9jaywgc28gaXQNCj4gPiA+IGNh
bg0KPiA+ID4gdW5saW5rIGEgY2FsbGJhY2sgYW5kIHJldHVybiB3aGlsZSBhbm90aGVyIENQVSBp
cyBiZXR3ZWVuIHRoZQ0KPiA+ID4gbG9va3VwDQo+ID4gPiBhbmQgdGhlIGNhbGwuwqAgVGhlIHNl
bnNvciBkcml2ZXJzIHJlbW92ZSB0aGVpciBjYWxsYmFjayBpbg0KPiA+ID4gLnJlbW92ZSgpDQo+
ID4gDQo+ID4gVHdvIHNwYWNlcyBiZWZvcmUgIlRoZSIuDQo+ID4gDQo+ID4gPiBhbmQga2VlcCB0
aGUgc3RydWN0IGhpZF9zZW5zb3JfaHViX2NhbGxiYWNrcyBpbiBtZW1vcnkgdGhhdA0KPiA+ID4g
ZGV2cmVzDQo+ID4gPiBmcmVlcyByaWdodCBhZnRlciwgc28gYSByZXBvcnQgcmFjaW5nIGFuIHVu
YmluZCBjYW4gY2FsbCB0aHJvdWdoDQo+ID4gPiBmcmVlZCBmdW5jdGlvbiBwb2ludGVycy4NCj4g
PiA+IA0KPiA+ID4gVGFrZSBwZGF0YS0+bG9jayBpbiBzZW5zb3JfaHViX3JlbW92ZV9jYWxsYmFj
aygpIHRvbywgb3V0c2lkZQ0KPiA+ID4gZHluX2NhbGxiYWNrX2xvY2sgYXMgaW4gc2Vuc29yX2h1
Yl9yYXdfZXZlbnQoKSwgc28gdGhlIHJlbW92YWwNCj4gPiA+IHdhaXRzDQo+ID4gPiBmb3IgYSBy
ZXBvcnQgaW4gZmxpZ2h0LsKgIHBkYXRhLT5sb2NrIGlzIG90aGVyd2lzZSBvbmx5IHRha2VuIGlu
DQo+ID4gPiBzZW5zb3JfaHViX3Jhd19ldmVudCgpLCBhbmQgY2FsbGJhY2tzIGFyZSByZW1vdmVk
IGZyb20gcHJvY2Vzcw0KPiA+ID4gY29udGV4dC4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDQwMWNh
MjRmYjM0YSAoIkhJRDogc2Vuc29yczogaW50cm9kdWNlIHNlbnNvciBmcmFtZXdvcmsiKQ0KPiA+
ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waGVyIEhvb3ZlciA8Y2hAbXVyZ2F0cm9pZC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogSm9z
aHVhIENyb2Z0cyA8am9zaHVhLmNyb2Z0czFAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDC
oGRyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMgfCAxMiArKysrKysrKysrLS0NCj4gPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiAN
Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jIGIvZHJpdmVy
cy9oaWQvaGlkLQ0KPiA+ID4gc2Vuc29yLQ0KPiA+ID4gaHViLmMNCj4gPiA+IGluZGV4IDY0NzBh
MjkwZWJmYy4uN2NmOWYzOTg1OTJlIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9oaWQvaGlk
LXNlbnNvci1odWIuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1odWIuYw0K
PiA+ID4gQEAgLTE3Myw3ICsxNzMsMTQgQEAgaW50IHNlbnNvcl9odWJfcmVtb3ZlX2NhbGxiYWNr
KHN0cnVjdA0KPiA+ID4gaGlkX3NlbnNvcl9odWJfZGV2aWNlICpoc2RldiwNCj4gPiA+IMKgwqDC
oMKgwqAgc3RydWN0IHNlbnNvcl9odWJfZGF0YSAqcGRhdGEgPSBoaWRfZ2V0X2RydmRhdGEoaHNk
ZXYtDQo+ID4gPiA+IGhkZXYpOw0KPiA+ID4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiA+ID4gDQo+ID4gPiAtwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJnBkYXRhLT5keW5f
Y2FsbGJhY2tfbG9jaywgZmxhZ3MpOw0KPiA+ID4gK8KgwqDCoMKgIC8qDQo+ID4gPiArwqDCoMKg
wqDCoCAqIHNlbnNvcl9odWJfcmF3X2V2ZW50KCkgaG9sZHMgcGRhdGEtPmxvY2sgd2hpbGUgaXQg
bG9va3MNCj4gPiA+IHVwIGENCj4gPiA+ICvCoMKgwqDCoMKgICogY2FsbGJhY2sgYW5kIGNhbGxz
IGl0LsKgIFRha2luZyBpdCBoZXJlIHRvbyBtZWFucyBubw0KPiA+ID4gcmVwb3J0IGlzDQo+ID4g
PiArwqDCoMKgwqDCoCAqIHN0aWxsIHVzaW5nIHRoZSBjYWxsYmFjayBvbmNlIGl0IGlzIHVubGlu
a2VkLCBzbyBpdHMNCj4gPiA+IG93bmVyIG1heQ0KPiA+ID4gK8KgwqDCoMKgwqAgKiBmcmVlIGl0
IGFzIHNvb24gYXMgdGhpcyByZXR1cm5zLg0KPiA+ID4gK8KgwqDCoMKgwqAgKi8NCj4gPiA+ICvC
oMKgwqDCoCBzcGluX2xvY2tfaXJxc2F2ZSgmcGRhdGEtPmxvY2ssIGZsYWdzKTsNCj4gPiA+ICvC
oMKgwqDCoCBzcGluX2xvY2soJnBkYXRhLT5keW5fY2FsbGJhY2tfbG9jayk7DQo+ID4gPiDCoMKg
wqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkoY2FsbGJhY2ssICZwZGF0YS0+ZHluX2NhbGxiYWNr
X2xpc3QsDQo+ID4gPiBsaXN0KQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGNhbGxiYWNrLT51c2FnZV9pZCA9PSB1c2FnZV9pZCAmJg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNhbGxiYWNrLT5oc2RldiA9PQ0KPiA+ID4gaHNkZXYpIHsNCj4g
PiA+IEBAIC0xODEsNyArMTg4LDggQEAgaW50IHNlbnNvcl9odWJfcmVtb3ZlX2NhbGxiYWNrKHN0
cnVjdA0KPiA+ID4gaGlkX3NlbnNvcl9odWJfZGV2aWNlICpoc2RldiwNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZnJlZShjYWxsYmFjayk7DQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gPiAtwqDCoMKgwqAgc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmcGRhdGEtPmR5bl9jYWxsYmFja19sb2NrLCBmbGFncyk7DQo+ID4gPiAr
wqDCoMKgwqAgc3Bpbl91bmxvY2soJnBkYXRhLT5keW5fY2FsbGJhY2tfbG9jayk7DQo+ID4gPiAr
wqDCoMKgwqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcGRhdGEtPmxvY2ssIGZsYWdzKTsNCj4g
PiA+IA0KPiA+IA0KPiA+IFRoZSBwYXRjaCBsb29rcyBmaW5lLiBJcyB0aGlzIGlzc3VlIGFjdHVh
bGx5IHJlcHJvZHVjZWQgb3IgaXQgd2FzDQo+ID4gZm91bmQNCj4gPiBieSBzb21lIEFJIHRvb2xz
Pw0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBTcmluaXZhcw0KPiA+IA0KPiA+ID4gwqDCoMKgwqDC
oCByZXR1cm4gMDsNCj4gPiA+IMKgfQ0K
