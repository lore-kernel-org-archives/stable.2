Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10003DB99C
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327653; cv=fail; b=FBoeR9kzioH4Ovt0yA/jKWDTgW8+hWgnbuPJhxqMe0Yj60GR3fOuMlCsRJIJQrUt9BAUBZAMOEOqJjWhrydVG5IM2CVc3XuQ3Jt8oAt7S1C+DAZoTjskLwguvboZvMFlI45xxtyBJrJlbBLeW0/Ny0D6A8EvxGMvMzkWFFjuVDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327653; c=relaxed/simple;
	bh=UAuUXVULGa+FbS8APgsf209cVzmAKwv4co0DO/7Jn7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JW+nEDsTDG0Isjt/iemLDA58B02IPBXXtKHxx/mkpBlk6QZkhbHGMbgkOsZDQmxPRCTC0/quymqGuEbZ9J9q8Focadti/Oev8Iyrl7RHh9L8DePw5ZFObxRrhosW3yLnCBWkh4/j7z5bICUpbhxFqBHm0z45QNBoMk31PoLoxH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRjIzxwT; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRjIzxwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780327644; x=1811863644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UAuUXVULGa+FbS8APgsf209cVzmAKwv4co0DO/7Jn7E=;
  b=dRjIzxwTYRoFnptg9aMCiXqEHqIkZa528x6CNQNsxFdfIYUtQvA+sRVm
   huyaVMPwEgrjS30n8uOdzhA3Uu6DiYyvRJZZjTC+4t1Dc8T71R5vMMUfu
   Tbqwf2X1oX9nJ2ck1AXj9nS/JyywkiZHlR84JqyxIaUuBsXSCRImCCAgP
   tGCeO5r/iWL0vM2hCS4L0P5ChDHO4W3BUdySXFpi+cVuhTM45Brvbqs4I
   XfFSuQFvaNL129HfZj0QJ/PWLXFHkB4qMensFCQ/726QMwSfqv8Ordu4R
   a3cvTCYzM7aT8PVUE+2Pbyf6BU4kfENETBIopadSiWmuMAPrArNfpIamL
   Q==;
X-CSE-ConnectionGUID: a5XHLMGIQ4OGBGYcoxXXYQ==
X-CSE-MsgGUID: BRI8vvWqS5qa7UOQqS1e4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="83665305"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="83665305"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:27:22 -0700
X-CSE-ConnectionGUID: jikjTgI4RAmx+gY7ronO2g==
X-CSE-MsgGUID: CJymJX9KRaG8e0RWvVyWOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239191829"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:27:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 08:27:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 08:27:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 08:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfLmX3/ygm2rUunlp2qW78OY06Rt+9m0+rXjKEiwSJh8BApKbGHjypBzZ2ODkwgyTJUdNxFkONGnkRpEs1I+AiBOH1kkBf6tP/Ik00Ulgw2T+nf5w3urK73mhzmhTYuyUvlkjetZR2hwKtk2Wdd1Ta60TBJRKycqE8AsjJZJx/p8oklYmzPavP+w5eVX3y5zn6q0FOVegHSGyEtLn3WwxJ+3NgH8wun/HPVHibR6zWXv0oivEaXCbYiI/Fk5OyPJR2ka1h7oFXMqx0l04QJPbi2kbg6s3HqT+LMcX4fHR8mfETGOC36eJpntdeJlopmH1e1+ku4zQQwQDDsXz/4O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAuUXVULGa+FbS8APgsf209cVzmAKwv4co0DO/7Jn7E=;
 b=AWM+gdqpiGWJr/F/31vpB2SjE8pVyVgUe3Wg+I+ZmdxZvRIMZcVCR6reLVXfBcDlqDpg3hQG5XJFm1wRA3DxdlH71G+54N0zNFIuUPLyNLrsp4Zb1cIfI+UNn0I7FGfJLeeVyB4w1Ie5GMBvsI9u8hNYUmtwpiwzU1jYKXxLexTBUPtF676fBTna4a0fhMAJ1tkhQ3A9AhiJ5tvseNyHBEwXyL03Z+HlhIeuzqauqCFp3U4eJpjXcrYgn+zoAIXo7n3kWd1ncMz+a53d8gaae91LM5eS1QRd/XV7JKXsX/6eTo1gY46H0v2YOizG2XWBsEnvddBTpb4t4NUrs0JgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 15:27:17 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 15:27:17 +0000
From: "Gote, Nitin R" <nitin.r.gote@intel.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Auld,
 Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<ckoenig.leichtzumerken@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Thomas Hellstrom
	<thomas.hellstrom@linux.intel.com>, "Brost, Matthew"
	<matthew.brost@intel.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
Thread-Topic: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
Thread-Index: AQHc8aq802CLhkFC/EqM+Lp7FGALlLYphJgAgAAOzQCAAAYZAIAABFoAgAAN3SA=
Date: Mon, 1 Jun 2026 15:27:17 +0000
Message-ID: <SA3PR11MB8118477615C02DD99CA966F7D0152@SA3PR11MB8118.namprd11.prod.outlook.com>
References: <20260601101536.1333480-2-nitin.r.gote@intel.com>
 <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
 <5e3854dd-d6ad-4110-966e-9029ef7c2374@amd.com>
 <b9b9e20f-703d-4e43-bd1a-17d8bbcead70@intel.com>
 <157c5cfc-b0a5-4ee9-b91a-909e87df3080@amd.com>
In-Reply-To: <157c5cfc-b0a5-4ee9-b91a-909e87df3080@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8118:EE_|SJ2PR11MB7456:EE_
x-ms-office365-filtering-correlation-id: 6aa81c55-16fe-46cd-dd80-08debff243d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 0GH6IX5YUMJX0pd57PnaMx6U4ZyVN/xKclYIZ3qmMwxugux9fY4uDdBjpd0GrmHJeerkqx9TdcVwhuxdN1hKuZ1Ve1AW7u+kARH1kopdzINhZF5bBhS/Ld59ZffknUexsLqX8/yNrgYIvnyEoSs1D402myDd2GdySJ5Sk62sRVdXRyIBUAZilwaor/66NpjAzzTQwHixc8dSLGjYTdiqbq9Bu2+yF0D9XaCZfptuQzmQaY/NomVccaA32PhY01mmrifc3+4ojysN6QkzmJKuXvKNHskHZ6jrfk3nyJD3YT7p83ZWrGM1+iKS5z+pI/ubp70VuTn+QrCfP2IWQRIP66XlMfp+sN0fZexadWY+Nb2mPijG6h9jh55iXxnwUd500w/ee7tDl5gK86ZOjRWQhrbh9NnDBt0YThVD1zQ0DuP+vB0w0HHEa7jXIhbe0wGKqBpU1tTYci4PPzmJMakh1kJahVpBJN0CbzjiCfLXDDa9oJqV5Ouepy2JC6OWNdOIGFe6R0O8xdU5URStx7ezS0zefT8pW79NMzm8UTLXluNSz62VVeSzsc9A6sGm3D37glQyzCKJ+wo5yMfQjwOsf+5sYomk+zQuLNbUwf72rULPVhlbgyT1+le/sd0XegNPi+GfGy7OjD7un89gVbLqvdLSP7KpdwanALPMLekhjiaoJAq4Mf1XRxtEdXqmOl9woJPpn+E+bhI+CoqHdruoxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjlZZnZ0RHFHSE5mRzg4NTd6NlFEa0ZtUGdLWlJtVk9HT3dwUFREdHRYSWd1?=
 =?utf-8?B?UEwvSjhYdFpWaE9MNW0vVHJCOXB5ZTFRZlp4eE5JK01EOEZhclBjakZPRHVI?=
 =?utf-8?B?ZVZXZStYQm40UFdLQjVnbG51NWRPT1FrU1pha1N5Wi82dkFsdytvejZBeG1W?=
 =?utf-8?B?QmNJazI2UUdWcnl3NWNJYzNDajE5K0hhZ0lrMFlabE53enhwb1RvMHZRa3U4?=
 =?utf-8?B?WExteWROL29DOGtZRkd3ZjNzbHVybldzZjdyOGlYRld4Nk9YS1hiSjJuWStr?=
 =?utf-8?B?bnRYSDZnNVd6MEozQ2RmWXpObTBhdk5ucHdtV3ZSTmdHSDdiaVg4ckpwaFF3?=
 =?utf-8?B?dld0M0x2QXoxWTRnNVhTWFpSZ1hIRFlzRDZHblhTWDI2VTFkN1VhVUJ5TEpX?=
 =?utf-8?B?MS9FQ2kzcUxlNy93bzh1Z0xhTENvempqVlU2R1h4TFlldkVsNmFJNkpheEhS?=
 =?utf-8?B?amVmcVlKdmx4anRuOXVoaWVGMWY4Q0JCQWl0cHRJWjF6b1RmbmZTaVpzMHUx?=
 =?utf-8?B?NzQrME5lditkeEV5c1ZzRkZJbW42Nll0WjNlSSsxVTJaOGxkS2RoYzJkSWVS?=
 =?utf-8?B?UngrNnFmQzVneUlTZ3hjODZXaEpFdFQ0NVJLVDlUMzdZWS9DcERqRG9xc081?=
 =?utf-8?B?NGNhdWRCMmp6NUQ0OXMyRjhlY3puSUxTMWVrUTJ5WkZ2RjZtMG8xNGgyL2J0?=
 =?utf-8?B?YmFRR2FXRUdWamg4ajF1OExBcTdZTnROYlBlUG9nN3gydkxXQUNxTlhIeXI2?=
 =?utf-8?B?YVpWeGFLY0t1RmZna3VWRW9kdWJDbkZOOFRZUDZQeVpMTXNwSC80MnVUSGxh?=
 =?utf-8?B?OUpRYWZvR0FsWkhwZ0I0eWo4K0MyRmNPZTdUY29OUDhVaVBLUEo0ZFJrdXBG?=
 =?utf-8?B?UFdrWE83NWp2Q3I3TE9TRnpqZXFMSC9pVzlSblpablB3TWI2VFBlUFl1YnBG?=
 =?utf-8?B?cjc5YWJORVhiMFIrNW9lR1IwekJEVUF5dFVFSytGcXFZMm4wYjl6akM5ZUFR?=
 =?utf-8?B?UE9scGl3cGdpVWVPVll5ZTVhVmo4RmVGd085S0xFZkkwVllJTldlcDVzc0dz?=
 =?utf-8?B?SG0xOXNaVXVkKzRMdnp6NDN4UEhpVXdxMUMwckREVC9zUy96TkRLZ1M5eDNi?=
 =?utf-8?B?YVc3bElNS3Eyckp6NlVTbHFvQVp5alQ1Z0ZOalZnQllCQ3diMXJ1eUJMQ1hV?=
 =?utf-8?B?RmRtU0YxNkIvZDEvSHJBKzk0RkRkdFBod0dXeDZnNUdDQjVHNmxaak5jc2JD?=
 =?utf-8?B?MjB6STZFanpNWUVTYnVNRzRSem9OQkpGVDN2UmtPL2tKaTd3NU03NHBZSzRD?=
 =?utf-8?B?ODQwSm93MXhJYVRTTStHVkVKMUR3M2dNVG4xSURiMWQyZ2Q5Z28wM1dGQlpY?=
 =?utf-8?B?R3pzT2ZCLzgybW5TSHBMME83akZYS2J6cWlUalFKa2ZvM0N6OHRjemtyUlg1?=
 =?utf-8?B?T2YwYUJpOGk2c3lIeUtaOG9GQmM4dXp5K1pOSyttcjdDNG5YVFdsSldrQmRM?=
 =?utf-8?B?Vkduek1rdHBwUlNtYkxaYU9VM1hWVElXUjJMTVpVZDUxTUswNVpGNjc4cEJq?=
 =?utf-8?B?dnNFQ0lrZEhIL251WFdwMHdpMjY4QkVsSG9BY0hFYXNweXVqT1Q0VVk5OWFP?=
 =?utf-8?B?RmRucDFvNUVQWnNWcXlaNjE5Zk9QQ1BnTlpBbmErT1o5ODZId251eUc4Yi9C?=
 =?utf-8?B?MkZHbHRiOEg5Q1RjWE9NTVlqcktIejdrUkh2S0N2SCtKQ2JYdlVQaCs0Nm1K?=
 =?utf-8?B?eGpBbjg2YVlpMExuZUtUWHRwaTExZU9JUUZJRXMzdytaNDNDazY3bmFIcW9j?=
 =?utf-8?B?b3JGOEhpakZIZiswK3hsd0QvdWV1Q3cyRUhsM0ZuS0E2UDk0OGZjRnJpSEdl?=
 =?utf-8?B?Q3NqaHE5YWpqNkVmeENsSDkxMXU3cStpS0RhNG5uQXlsQU1ySno5N0tsTytD?=
 =?utf-8?B?Y0dwQVgvV0ZVQnNBd2dEWkZlN2dDa1I0T1Fra0k1VWxUZ0YrazBnNUFCelJV?=
 =?utf-8?B?OHpZamQ5QmRrOGhVeksrTVhFRFFEVmZhY016a2lGYmttVVVMYjczUmNZM1h0?=
 =?utf-8?B?Y0QvblVIWEJ6SEJGakdSM2l3c01PZmY1VVhQVjloT24xVGpRV2RQOXllVEtI?=
 =?utf-8?B?eHd3dXZqdTNJbzhnUVQ1MCt2alFtWWE5emVMUHhIOTBvZXB3aElveDhnV2tu?=
 =?utf-8?B?Lzg3SG5SN0g3a2pvUDBLMlBTVC9NRVBLMmlxYUlUY2hBQnl6RUQrbzMzRHE1?=
 =?utf-8?B?SldUakVJaGhGblZ6ZmcvazN5bFdNVWF5b1RWM2RzSTcyb29XSW5ueTUrVGk2?=
 =?utf-8?B?bWhOaXlYaS8vUnM4NkQvWE8yVHhxZW5TUnpNUC9zdUovMTZ3MjdMZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L4ADqJMgTuOynN2ox/UL2Fzi6vJlG8MlcH21Neu7zN4UuYBNcIdr5jXmt6DPjkZG+C6aV1LiTBoelBL9QU9kMtMz1KSGPbJOMcXkuXtkjKRzkmRmbApJ9e3Iwef3nPbyzurE11PlJlHhSVl7/jhrH3vKUCDfkxmS08tZKXmoBLBpWumka2VgQrq9rUdXKcWi9O0QmL54m9Yductt61kvOL3Rg3/MrvaHoVQkoX8CIOK1Y2u70NecIWNKYl4kq6XbSnuZfAxziDobltPW2OjPgdjFfpb406Hjl5/wBwOPpnDUNDtksv7juqaccsqif09/yYjtu9LxH/bYcyd3nsinPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa81c55-16fe-46cd-dd80-08debff243d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 15:27:17.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9TwLso2JbFwcNPcSWbyCa1NS0q0PjWqt0dzHvBO+0rYHRe2yEsb0mATpk+Q3NW8g+L8R+w/SUEIeCcdjLY3wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
X-OriginatorOrg: intel.com

SGkgQ2hyaXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBKdW5lIDEsIDIwMjYgNTo0NyBQTQ0KPiBUbzogQXVsZCwgTWF0dGhldyA8bWF0dGhldy5hdWxk
QGludGVsLmNvbT47IEdvdGUsIE5pdGluIFINCj4gPG5pdGluLnIuZ290ZUBpbnRlbC5jb20+OyBp
bnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENocmlzdGlhbiBLw7ZuaWcNCj4gPGNrb2Vu
aWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZzsgVGhvbWFzIEhlbGxzdHJvbQ0KPiA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+
OyBCcm9zdCwgTWF0dGhldw0KPiA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+OyBQcm9zeWFrLCBW
aXRhbHkgPFZpdGFseS5Qcm9zeWFrQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS94ZTogRml4IFVBRiBpbiB4ZV9nZW1fcHJpbWVfaW1wb3J0KCkgb24gYXR0YWNoIGZhaWx1cmUN
Cj4gDQo+IE9uIDYvMS8yNiAxNDowMSwgTWF0dGhldyBBdWxkIHdyb3RlOg0KPiA+IE9uIDAxLzA2
LzIwMjYgMTI6MzksIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+IE9u
IDYvMS8yNiAxMjo0NiwgTWF0dGhldyBBdWxkIHdyb3RlOg0KPiA+Pj4gT24gMDEvMDYvMjAyNiAx
MToxNSwgTml0aW4gR290ZSB3cm90ZToNCj4gPj4+PiB4ZV9kbWFfYnVmX2NyZWF0ZV9vYmooKSBj
cmVhdGVzIHRoZSBpbXBvcnRlciBCTyB3aXRoIG9iai0+cmVzdg0KPiA+Pj4+IHBvaW50aW5nIGF0
IHRoZSBleHBvcnRlcidzIGRtYV9idWYtPnJlc3YuIFdoZW4NCj4gPj4+PiBkbWFfYnVmX2R5bmFt
aWNfYXR0YWNoKCkgZmFpbHMsIG5vIGRtYV9idWYgcmVmZXJlbmNlIGlzIGhlbGQgc28gdGhlDQo+
ID4+Pj4gZXhwb3J0ZXIgY2FuIGJlIGZyZWVkIGltbWVkaWF0ZWx5LiBTaW5jZSB0dG1fYm9fcmVs
ZWFzZSgpIG5vdw0KPiA+Pj4+IGFsd2F5cyBkZWZlcnMgY2xlYW51cCBmb3IgdHRtX2JvX3R5cGVf
c2cgQk9zIHRvIHRoZSBUVE0gd29ya3F1ZXVlLA0KPiA+Pj4+IHRoZSB3b3JrZXIgbGF0ZXIgY2Fs
bHMNCj4gPj4+PiBkbWFfcmVzdl9sb2NrKCkgb24gdGhlIGFscmVhZHktZnJlZWQgZXhwb3J0ZXIg
cmVzdiwgY2F1c2luZyBhIFVBRi4NCj4gPj4+Pg0KPiA+Pj4+IFJlc2V0IG9iai0+cmVzdiB0byB0
aGUgQk8ncyBwcml2YXRlIF9yZXN2IGJlZm9yZSBjYWxsaW5nDQo+ID4+Pj4geGVfYm9fcHV0KCkg
aW4gdGhlIGVycm9yIHBhdGguIFRoZSBCTyBpcyBub3QgeWV0IHB1Ymxpc2hlZCAoYXR0YWNoDQo+
ID4+Pj4gZmFpbGVkKSBhbmQgY2FycmllcyBubyBmZW5jZXMsIHNvIHRoZSBzd2l0Y2ggaXMgc2Fm
ZS4NCj4gPj4+Pg0KPiA+Pj4+IE9ic2VydmVkIHdpdGggaWd0QHhlX2xpdmVfa3Rlc3RAeGVfZG1h
X2J1Zl9rdW5pdCBvbiBCTUcgKFFFTVUpOg0KPiA+Pj4+DQo+ID4+Pj4gwqDCoMKgIE9vcHM6IGdl
bmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwNCj4gPj4+
PiBhZGRyZXNzIDB4NmI2YjZiNmI2YjZiNmI5Yw0KPiA+Pj4+IMKgwqDCoCBXb3JrcXVldWU6IHR0
bSB0dG1fYm9fZGVsYXllZF9kZWxldGUgW3R0bV0NCj4gPj4+PiDCoMKgwqAgUklQOiAwMDEwOm11
dGV4X2Nhbl9zcGluX29uX293bmVyKzB4M2YvMHhjMA0KPiA+Pj4+IMKgwqDCoCBDYWxsIFRyYWNl
Og0KPiA+Pj4+IMKgwqDCoMKgIDxUQVNLPg0KPiA+Pj4+IMKgwqDCoMKgID8gX193d19tdXRleF9s
b2NrLmNvbnN0cHJvcC4wKzB4MmRkLzB4MThlMA0KPiA+Pj4+IMKgwqDCoMKgID8gdHRtX2JvX2Rl
bGF5ZWRfZGVsZXRlKzB4NDEvMHhjMCBbdHRtXQ0KPiA+Pj4+IMKgwqDCoMKgIHd3X211dGV4X2xv
Y2srMHgzYy8weGIwDQo+ID4+Pj4gwqDCoMKgwqAgdHRtX2JvX2RlbGF5ZWRfZGVsZXRlKzB4NDEv
MHhjMCBbdHRtXQ0KPiA+Pj4+IMKgwqDCoMKgIHByb2Nlc3Nfb25lX3dvcmsrMHgyMzkvMHg3NDAN
Cj4gPj4+PiDCoMKgwqDCoCB3b3JrZXJfdGhyZWFkKzB4MjAwLzB4M2YwDQo+ID4+Pj4gwqDCoMKg
wqAga3RocmVhZCsweDEwZC8weDE1MA0KPiA+Pj4+IMKgwqDCoMKgIHJldF9mcm9tX2ZvcmsrMHgz
YmQvMHg0NzANCj4gPj4+PiDCoMKgwqDCoCByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4g
Pj4+PiDCoMKgwqDCoCA8L1RBU0s+DQo+ID4+Pj4NCj4gPj4+PiBDbG9zZXM6DQo+ID4+Pj4gaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS93b3JrX2l0ZW1zLzgw
MjMNCj4gPj4+PiBGaXhlczogZDk5ZmJkOWFhYjYyICgiZHJtL3R0bTogQWx3YXlzIHRha2UgdGhl
IGJvIGRlbGF5ZWQgY2xlYW51cA0KPiA+Pj4+IHBhdGggZm9yIGltcG9ydGVkIGJvcyIpDQo+ID4+
Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Ni44Kw0KPiA+Pj4+IENjOiBUaG9tYXMg
SGVsbHN0cm9tIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+PiBDYzog
TWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+DQo+ID4+Pj4gQ2M6IE1hdHRo
ZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBO
aXRpbiBHb3RlIDxuaXRpbi5yLmdvdGVAaW50ZWwuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+IMKg
wqAgZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RtYV9idWYuYyB8IDggKysrKysrKysNCj4gPj4+PiDC
oMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZG1hX2J1Zi5jDQo+ID4+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0veGUveGVfZG1hX2J1Zi5jIGluZGV4IDhhOTIwZTU4MjQ1Yy4uNmQ5NDRiZDQwNjVj
DQo+ID4+Pj4gMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RtYV9i
dWYuYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kbWFfYnVmLmMNCj4gPj4+
PiBAQCAtMzg0LDYgKzM4NCwxNCBAQCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QNCj4gPj4+PiAqeGVf
Z2VtX3ByaW1lX2ltcG9ydChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiA+Pj4+IMKgwqAgwqDC
oMKgwqDCoCBhdHRhY2ggPSBkbWFfYnVmX2R5bmFtaWNfYXR0YWNoKGRtYV9idWYsIGRldi0+ZGV2
LA0KPiA+Pj4+IGF0dGFjaF9vcHMsIG9iaik7DQo+ID4+Pj4gwqDCoMKgwqDCoMKgIGlmIChJU19F
UlIoYXR0YWNoKSkgew0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoCAvKg0KPiA+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgICogVGhlIEJPIHdhcyBjcmVhdGVkIHdpdGggcmVzdiA9IGRtYV9idWYtPnJlc3YN
Cj4gPj4+PiArKGV4cG9ydGVyJ3MNCj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHJlc3YpLiBT
aW5jZSBhdHRhY2ggZmFpbGVkLCBubyBkbWFfYnVmIHJlZmVyZW5jZSBpcw0KPiA+Pj4+ICtoZWxk
IGFuZA0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdGhlIGV4cG9ydGVyIG1heSBiZSBmcmVl
ZCBiZWZvcmUgVFRNJ3MgZGVsYXllZF9kZWxldGUNCj4gPj4+PiArd29ya2VyDQo+ID4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKiBydW5zLiBTd2l0Y2ggdG8gdGhlIEJPJ3Mgb3duIHJlc3YgdG8gcHJl
dmVudCBhIFVBRiB3aGVuDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB0dG1fYm9fZGVsYXll
ZF9kZWxldGUoKSB0cmllcyB0byBsb2NrIHRoZSBzdGFsZSBwb2ludGVyLg0KPiA+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgICovDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgIG9iai0+cmVzdiA9ICZvYmot
Pl9yZXN2Ow0KPiA+Pj4NCj4gPj4+ICtDaHJpc3RpYW4sIGRvZXMgYW1kZ3B1IG5vdCBoYXZlIHRo
ZSB0eXBlIG9mIHNhbWUgaXNzdWUgaGVyZT8gQWxzbyBhbnkNCj4gdGhvdWdodHMgaGVyZT8NCj4g
Pj4NCj4gPj4gT2gsIGdvb2QgY2F0Y2guIFllYWggSSB0aGluayB3ZSBoYXZlIHRoZSBzYW1lIHBy
b2JsZW0gb24gYW1kZ3B1IGFzIHdlbGwuDQo+ID4NCj4gPiBNYXliZSBkdW1iIHF1ZXN0aW9uLCBi
dXQgd2h5IGRvZXMgdGhlIHR0bV9ib19pbmRpdmlkdWFsaXplX3Jlc3YoKSBza2lwIHRoZQ0KPiBm
aW5hbCBzd2l0Y2ggb2YgdGhlIHJlc3YgZm9yIHR5cGVfc2c/DQo+IA0KPiBCZWNhdXNlIHdlIG5l
ZWQgdGhlIG9yaWdpbmFsIHJlc3Ygb2JqZWN0IGZvciBjbGVhbmluZyB1cCB0aGUgbWFwcGluZyBz
aG91bGQgdGhlDQo+IGluaXRpYWwgYXR0YWNoIGFuZCB0aGVuIG1hcCBoYXZlIHN1Y2NlZWQuDQo+
IA0KPiA+IEl0IGdvZXMgdGhyb3VnaCB0aGUgdHJvdWJsZSBvZiBjb3B5aW5nIHRoZSBmZW5jZXMg
YWNyb3NzPw0KPiANCj4gQmVjYXVzZSB3ZSBuZWVkIHRvIGtub3cgd2hlbiB0aGUgaW1wb3J0IGNh
biBiZSBjbGVhbmVkIHVwLg0KPiANCj4gSW4gb3RoZXIgd29yZHMgVFRNIHRha2VzIGEgY29weSBv
ZiB0aGUgY3VycmVudCBmZW5jZXMgYW5kIG9ubHkgdW5tYXAsIGRldGFjaA0KPiBhbmQgdGhlbiBk
byB0aGUgZmluYWwgY2xlYW51cCBhZnRlciB3ZSBhcmUgc3VyZSB0aGF0IHRoZSBzZXQgb2YgZmVu
Y2VzIHdoaWNoIHdhcw0KPiBhY3RpdmUgb24gZGVzdHJ1Y3Rpb24gaXMgbm93IHNpZ25hbGVkLg0K
PiANCj4gSWYgbmV3IGZlbmNlcyBhcmUgYWRkZWQgdG8gdGhlIHJlc3Ygb2JqZWN0IChtYXliZSBi
eSB0aGUgZXhwb3J0ZXIgaXRzZWxmIG9yIG90aGVyDQo+IGltcG9ydGVycykgYWZ0ZXIgb3VyIHJl
ZmVyZW5jZSBjb3VudCBnb3QgZG93biB0byB6ZXJvIHRoZW4gd2UgZG9uJ3QgY2FyZSBhYm91dA0K
PiB0aGF0Lg0KPiA+IElmIHdlIGRvIG5lZWQgdG8gaGFuZGxlIHRoaXMgaGVyZSwgZG8gd2UgYWxz
byBuZWVkIHRvIGdyYWIgdGhlIGxydSBsb2NrLCBsaWtlIHdlDQo+IGRvIGluIHR0bV9ib19pbmRp
dmlkdWFsaXplX3Jlc3YoKSB3aGVuIGRvaW5nIHRoZSBzd2FwPw0KPiANCj4gR29vZCBxdWVzdGlv
biwgb2YgaGFuZCBJIHdvdWxkIHNheSB5ZXMgYnV0IEkgY2xlYXJseSBuZWVkIHRvIGNoZWNrIHRo
ZSBzb3VyY2UNCj4gY29kZSBhcyB3ZWxsLg0KPiANCj4gTWlnaHQgYmUgYmV0dGVyIHRvIHN3aXRj
aCB0aGUgdHlwZSBvZiB0aGUgQk8gb24gZXJyb3Igc28gdGhhdCB0aGUgbm9ybWFsIGNsZWFudXAN
Cj4gd2lsbCBqdXN0IHN3aXRjaCBvdmVyIHRvIHRoZSBsb2NhbCBkbWFfcmVzdiBvYmplY3QuDQo+
IA0KDQotICAgICAgICAgICAgICAgb2JqLT5yZXN2ID0gJm9iai0+X3Jlc3Y7DQorICAgICAgICAg
ICAgICAgZ2VtX3RvX3hlX2JvKG9iaiktPnR0bS50eXBlID0gdHRtX2JvX3R5cGVfa2VybmVsOw0K
DQpTd2l0Y2hpbmcgdGhlIHR5cGUgdG8gdHRtX2JvX3R5cGVfa2VybmVsIGxldHMgdHRtX2JvX2lu
ZGl2aWR1YWxpemVfcmVzdigpIHN3YXAgcmVzdiB0byB0aGUgQk8ncyBwcml2YXRlIF9yZXN2IHVu
ZGVyIGxydV9sb2NrLCB3aGljaCBwcmV2ZW50cyBVQUYgd2l0aG91dCBuZWVkaW5nIGFueSBtYW51
YWwgbG9ja2luZy4NClRoaXMgc2VlbXMgYSBtb3JlIGNvcnJlY3QgYXBwcm9hY2guDQoNCj4gU2lu
Y2Ugd2UgZG9uJ3QgbmVlZCB0aGUgb3JpZ2luYWwgZG1hX3Jlc3YgZm9yIHRoZSBjbGVhbnVwIHRo
YXQgc2hvdWxkIHdvcmsgZmluZS4NCj4gDQo+ID4gSWRlYWxseSB4ZSBhbmQgYW1kZ3B1IGNhbiBq
dXN0IGhhdmUgaWRlbnRpY2FsIHNvbHV0aW9ucyBoZXJlLg0KPiANCj4gWWVhaCBjb21wbGV0ZWx5
IGFncmVlLg0KPiANCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPiANCj4gPg0KPiA+Pg0KPiA+
PiBIb3cgdGhlIGhlY2sgZGlkIHlvdSBmb3VuZCB0aGF0PyBEbyB3ZSBoYXZlIGEgZHVtbXkgZHJp
dmVyIChWR0VNPykgd2hpY2gNCj4gY291bGQgYmUgbWFkZSB0byBhbHdheXMgZmFpbCBhdHRhY2ht
ZW50IGZvciBhIHRlc3QgY2FzZT8NCg0KVGhlIGJ1ZyB3YXMgZm91bmQgdmlhIHRoZSBleGlzdGlu
ZyBLVW5pdCB0ZXN0ICh4ZV9kbWFfYnVmX2t1bml0KSwgd2hpY2ggd2FzIGZhaWxpbmcgb24gYSBC
TUcgVk0gZGV2aWNlLiBUaGUgdGVzdCBydW5zIDIwIHBhcmFtZXRlciBjb21iaW5hdGlvbnMuIA0K
dGhlIGZhaWxpbmcgb25lcyB1c2UgZm9yY2VfZGlmZmVyZW50X2RldmljZXM9dHJ1ZSArIG1lbV9t
YXNrPVhFX0JPX0ZMQUdfVlJBTTAgKyBub3AycF9hdHRhY2hfb3BzLCB3aGVyZSBkbWFfYnVmX2R5
bmFtaWNfYXR0YWNoKCkgcmV0dXJucyAtRU9QTk9UU1VQUCwgaGl0dGluZyB0aGUgZXJyb3IgcGF0
aC4NCg0KT24gYmFyZSBtZXRhbCBCTUcgdGhlIHJhY2Ugd2luZG93IGlzIHRvbyBuYXJyb3cgdG8g
aGl0IHRoZSBpc3N1ZS4gVG8gbWFrZSBpdCBtb3JlIGRldGVybWluaXN0aWMsIGFkZGVkIGEgc21h
bGwgbXNsZWVwKDEwMCkgaW4gdHRtX2JvX2RlbGF5ZWRfZGVsZXRlKCkganVzdCBiZWZvcmUgdGhl
IGRtYV9yZXN2X2xvY2soKSBjYWxsLCB3aGljaCB3aWRlbmVkIHRoZSByYWNlIHdpbmRvdy4NCldp
dGggS0FTQU4gZW5hYmxlZCwgdGhhdCBnYXZlIGEgY2xlYXIgc2xhYi11c2UtYWZ0ZXItZnJlZSBp
biBfX3d3X211dGV4X2xvY2sg4oCUIHRoZSAweDZiNmI2YjZiIFNMVUIgcG9pc29uIHBhdHRlcm4g
aW4gdGhlIGZhdWx0aW5nIGFkZHJlc3MgY29uZmlybWVkIHRoZSBVQUYuDQoNClRoYW5rcywNCk5p
dGluDQoNCj4gPj4NCj4gPj4gQFZpdGFseSBjYW4geW91IHRha2UgYSBsb29rIGFuZCB0cnkgdG8g
Y29tZSB1cCB3aXRoIGEgdGVzdCBjYXNlIGZvciB0aGF0Pw0KPiBUaGFua3MgaW4gYWR2YW5jZS4N
Cj4gPj4NCj4gPj4gVGhhbmtzIGZvciB0aGUgbm90aWNlLA0KPiA+PiBDaHJpc3RpYW4uDQo+ID4+
DQo+ID4+Pg0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhlX2JvX3B1dChnZW1fdG9feGVf
Ym8ob2JqKSk7DQo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEVSUl9DQVNUKGF0
dGFjaCk7DQo+ID4+Pj4gwqDCoMKgwqDCoMKgIH0NCj4gPj4+DQo+ID4+DQo+ID4NCg0K
