Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F041685C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739786; cv=fail; b=md0gevmwl+ji//qnknC6SJZ32ZrGuy2u2p8kMSX8HkWP8Xhodz4dHPirtfggNS7WEX/amoPMsHRwGS8FXJV6+tnuhbIDE/4rh28/SEwcupmIpB8PvLs8TyfESzjJtTIO1MqPiwBdhUvnZk3NcCYFjbS+TzK0M6j6xI3r4yiqyk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739786; c=relaxed/simple;
	bh=s16eRcY+FGnwrwad/+daoJgsMnLZCc4b/67j8G6xNT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+EJtdMZIzl+oj6rOvQjY6MBu5NZUskPKa2NuBu3Hpbuy2c6euaN9Li1suB64DcEI51LYjOl4Ej782pUnJeDAGPVUqWYFAHtnDVwqekVvXTtnAwJdJE6LY3w+AksGjnEB45OCYsElOCdLV9pZQlAo0Q2pwGXCsnsZO5aRWo6e28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFofcIKQ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFofcIKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784739782; x=1816275782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s16eRcY+FGnwrwad/+daoJgsMnLZCc4b/67j8G6xNT8=;
  b=HFofcIKQhkYEraHncHD4RTfE8WoxIha4zQumSXZB32MPa884Ekdr6Vol
   5mMGN2aUjzWC0VG+W3YtVJSM7MKBz/j9OOWnVPFoYyAeajrJzKoob9H4b
   /aNaEBGgWgBq4uk+8Yh43o7RUTym/J0k1XLULdbq8En+PscgWOD6Vebjl
   0SZ5EQzO/eqwOOcHN22wdafgHYAoYbiag5SxII2XGZQIpZJA1sF00zIEC
   VvpxUoh5EX/tMwyXzHzCRktDAv6vuR6rUyBTsJQkD320UuWLfzG18WduL
   s4WoX6FzeLIFRj5onN0JOPzl9jcluD2fXXXtX0t3Zt9DmMzIzEpeIsKS/
   A==;
X-CSE-ConnectionGUID: s8sotFSwRGm1grZRVL8GhA==
X-CSE-MsgGUID: Czc6En6IRTGjMoaZW8YBmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84508131"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="84508131"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 10:03:01 -0700
X-CSE-ConnectionGUID: ts/EmFdMTUqUILDyhkOzyQ==
X-CSE-MsgGUID: 2zt170uKTVGa/1smx7pF4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="254756546"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 10:02:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:02:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 10:02:56 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUYIB/Op1GE7afzH42WJH3CpLMZWfyCJ5KWsvjuFRPKc+JtH28g20QFh+gwYzvsM+wjJZXr63juHbgqMVk3LoyL2AZ9jDnoaJ3AYFDYgGYwf8/2JimEAEonGKpTovfVsJ++1I6N4Np0xJljWuSTJiDmHbQvqYFqpc56MgfHdNWCRdsMLyCJ6st3XJlu3PsUdsyx7QiKKAlplC3xTSEcKCH9Z+HNkoXamlBD17f4uaeHm7qpzkaON7WUDmssAFZRLjNZTd03Fe0KzeZw0HDsS8/b+DthpyhtjO+ImSZpMylRO072pbXjBp/X8p9Zx4VJbD55qez5pueYOxbS8RDkfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s16eRcY+FGnwrwad/+daoJgsMnLZCc4b/67j8G6xNT8=;
 b=mTkmIhcTG1ig7gAWFN/EOkj4PKMadISomys1AC06IHSW7qy9R0oFkhlsskvlCmwzOCqhLeoZvhOy1/Vai/oxT/e3LxwcuquXtM0ck3hIIcn/tmXPV68/NBg4W7WwxRmruX92O+2jROLJ3ZERnUTN7u9UN7iw53yDphe+O6kMNHAQE6/ymPmKhfUU66omSHGHP60ZczoyeVr4GamtftLlrmdt/TfRYclTzE2q9jOhQzGn/VuDAyeXlT+5Ea8b7J/teGe2C4SwQqDrsy6fInjmft0lif9HCSJB8v/h5SHcSL7DYRM1E42qO37xRgOuJHj1wiypIJbw09uoBoyPBW/xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by SA7PR11MB9595.namprd11.prod.outlook.com
 (2603:10b6:806:4d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:02:53 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:02:53 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: John Foushee <johnfoushee@gmail.com>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX
 brightness panels
Thread-Topic: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX
 brightness panels
Thread-Index: AQHdGfGE/GbQvAcko0WXMVfVY37/6bZ5uEaAgAAGgQCAAAQc8A==
Date: Wed, 22 Jul 2026 17:02:52 +0000
Message-ID: <DS4PPFE901A304FEDE2765BE65449319629E3C12@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260722154802.3760046-1-johnfoushee@gmail.com>
 <DS4PPFE901A304F30C76A6DDF48BDAAE920E3C12@DS4PPFE901A304F.namprd11.prod.outlook.com>
 <CAGsDCxQ30bUzMbzSigA-o55zX=vzyeP91g38ZDvzJftppp17uA@mail.gmail.com>
In-Reply-To: <CAGsDCxQ30bUzMbzSigA-o55zX=vzyeP91g38ZDvzJftppp17uA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|SA7PR11MB9595:EE_
x-ms-office365-filtering-correlation-id: b536dad6-706c-430c-b31f-08dee8131199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|13003099007|38070700021|22082099003|18002099003|6133799003|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: ELHRelnHBRFGsw3rTSrwFEuJh6W1NhsvYMPlR8qM0XNz0fQXMx9+5clfUtT65oB4rYazBAMpJgZyfH9niQvAqDfdtmRbmzQ+eGr7HaE/XywLy+tXHTvME8+CcNqXTVnSCJIAntfNX6cO3ndlvmbgl3VsSbeq8vQt4OuN/+k/BJtvuyjj/z5KbB3lgg2Ly4h7m6V3DHT83i47oujfQg/m3IONNaEl3nQzK0Splldzt3CpmLuLrSavj/fRrKOjM7XPe1jTREXzTOHqxPmuHq0wTlTJcBGi7SzRJnuP61uowjihdPG82h173T2OQWLPNMkSCDlkE7OmlvVC5cN+QPB45s64muZVWRyLgosFoCPa2HT3bBnlYYKQHHrQvt/y1UtiHPjfQ9W8c3M6fnyJnoDKzBuPZaR658wYlp0o6O5Ecq7g5rryESB52QYSImvUxU+Dn4zogwwB1ykK7nel5aAH5ooY+dd/+WyEZ8IxH9EKAZlgwsNkYbG5uIiM4VNKo+zs9YQc6/vNnGcl4qS5V5ISF7aECIfcgAZnBj3aggFM9M0f+wMz9LCriuKN0ggExrG+IKu3VRmX0cWmsBCUWwUDL6BFo9TgUyRa+judSLihfMqgfJtrNG13m1/bRXPHec1UzTMhSPKMBKk/AR/PyaKbG8fpqpu7BLqhGak5aE1avuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(13003099007)(38070700021)(22082099003)(18002099003)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEY1TkVvVU5PdDNsejVoSUlRalZyY0hPTHZuemx2V24yRUpZdVNGeWpaMFpa?=
 =?utf-8?B?VjF6TEo4dkN2dlVReHhQd25sTURpVFA1VHdYWmw5dkN0S1lRaG10eGYySmFu?=
 =?utf-8?B?a3pSUUFTSExzckMzZStwdTBmTEkxMEJlTXBVTlNqWndvM1cycE53ZHlNeGUv?=
 =?utf-8?B?cmpPZ2NtY1RQRW16NzM2RnFscTZuMmU4UndnWUkwMnc3M3k4L0F5ZG5HRjNw?=
 =?utf-8?B?L1Bma2hXNkdZcUxYZXl6c2E5d0YyNGF3alVIREN2UTdoM21DMk1WeG9lcXpv?=
 =?utf-8?B?K3ZEcEtPV1dld2RuMEVRdFV6RDBYdSsvMzNIYTAzYUI0N1pDclVJMWp3b0kz?=
 =?utf-8?B?RTNBYTR2dGpWZi9XT1dJU1BTSEljS0xSbFhuTXBjaFZrL1lXVlRyY2p6QnJs?=
 =?utf-8?B?eUp4V01pREVtVGs5QkFqOUpZQzdXUWY1NXVNczN3KzNSNTVUZGVlRXdVMGxv?=
 =?utf-8?B?Z2JGNE1iY0lUNXRrNzhQOGxueVBHblRpZ21BQmh1YkNhWDYwRktEZkNlTFZn?=
 =?utf-8?B?b1M3eVB3K1NTaHVSYUV4cHJ4akNIekU4NWlnc1lsRW1xQ1RNeEg1dTIrSytJ?=
 =?utf-8?B?WHBsMnVnaWQ4dnkvYjlKWDQ5VWVBUXVXVGJWWGM3cGEwSWhFYXp0eEVIWkl1?=
 =?utf-8?B?QXJ0NjB0VmlDUVo0WWtuemtQaUtibTVueVBzY3UvSkxkaDRFQ3UvRWplRTB6?=
 =?utf-8?B?dXZPY0JxR0xFZHYwK0Y0TWpXTkI5UWxsWExycklPTis1YVViaW5XVE1HZGND?=
 =?utf-8?B?YVJEWk12VVV4TGF4VzRRbkRNVmdXUDIwRVVxeCtIb0IzbzhPV2JycE1xU0ZF?=
 =?utf-8?B?UWgwVC9QSm5iZ2RBaDEvd2lKUnhsc0dGZVVYbDlmN2xSZy95NGh1eGR6QmhS?=
 =?utf-8?B?RE1Tc0xMVkhKNFBHVklraGRhYVZnK2tCTWtuSnZnOWpIdHBINXpCVHZiaHZ4?=
 =?utf-8?B?NmhGL05UcTZtWGxpWlVxSmxZYlVYcjArRzFZU242RkFibWIvVnN2K0VYMVVk?=
 =?utf-8?B?YWRPZFBpMGlKbUNnOVlIUTZOT29NaEdTYnZPQzVrVE1rdm1YcmlLelZmeWVX?=
 =?utf-8?B?SERMdXNuNFQ2TmYvT0I2WndncVU1cnZZeUNEcUFaRUltT0J5TEFkTDI5L3dw?=
 =?utf-8?B?QlVQN3NnWUp1d2xQdWgveG5mV2ZVeFltZTZnUmhoMDNIeXNOZmZBeCsveG40?=
 =?utf-8?B?Y2ZvNDRIVXhTbVpYK3dkZGZPVjRWMEZQZ0hwNmtXayt0Mjd6bnV1V1pPZWI2?=
 =?utf-8?B?dHBsZXduTmVSeXdvNzQ4cWh0NlUybm4yVmNsR2lUVkV1a2ptajJ2RWRTUVU5?=
 =?utf-8?B?RGZiTWNPRGFCU3NYMjgyWloxdHZHeHg2SktQQzRLNjJ1NHlFRm8xTENDTDUv?=
 =?utf-8?B?NUJiUFJ5bUlLSzcvTXJUeXN4MFA4UkZLQzFVSEdxNFloMXozendURFVFL0Jh?=
 =?utf-8?B?VTdndlB4ZFRoQ1ZPTThiaDVCQTViUnFuU2Y0aDNQY0NBUG1VQStTdHdYR2I3?=
 =?utf-8?B?NlQ3QVN2M1NJbFlUcGxRNHVUVU1GNGtVRExSbUNqRUhDd3AxbHVBMWxVOWxo?=
 =?utf-8?B?SnU3VlBJcFRwU0hyT2VFVEpHL2U5ODZRSVJQYWd6YW9xWXM0ek84NGltTjk0?=
 =?utf-8?B?dGZkTCtnQ2ZrVzY5SWNkTWVwUmtTVVFCZ2pycGdiZi9rYXVNYWtoOWJPV0VC?=
 =?utf-8?B?QlhEalFrU2w5ejhjL0d2T0k0U0RJMzlWVndOVzVBQlNERG5HcEFjVTRBbHZ3?=
 =?utf-8?B?b0FKaTJUYTVhWURxVWlZa2FYWFJYNndGMGY0SlNua2tIWERJRUdFVGZFWjNX?=
 =?utf-8?B?dUs3NnBRWUZLaUtINDE4aFRCSjZHMng1QjZ4U1IxSGpQdDJjSnVVVHpIMEhK?=
 =?utf-8?B?MTFTdjI3M0g0b0FJcHBDQXFyRThBaXNlazRFQjNZd01IdTlpZDY4ZTZoVXN6?=
 =?utf-8?B?cXBDVHpqaEZIT2JRbzlSSlVIbEhYNFpFWnR1UXR1ZnpmNDcvakd6aGRlbUI4?=
 =?utf-8?B?N3dPWnFMRUFHUlNSS2RDNEZ3ZFlMam9WUXRQajZUa29ZcEM2SThXbXhuZUdk?=
 =?utf-8?B?UDBMemJZSkwxdkZCK2kwaGhodHJreFA3cEFvWU8zMkwwN1FpRkk1VTdhSnpK?=
 =?utf-8?B?Y0lYVUJPTVluNE5JSkJ5VVRiblNZVXFYanlJQ3p5OFdHQUMrOTRxU1BxSTZJ?=
 =?utf-8?B?eFEzSG9pNDU1VlUvN1Vtc2FuM2tZeXJZRVJlYUpvbjdQWFVvaUU5dUZCLzhj?=
 =?utf-8?B?NVA4OXNhSGo3dkdnR3c4dExrZDU1VHJGTFJ0Q204RlVZVmprWE9YNlA1SkRJ?=
 =?utf-8?B?aE5zTHRzS2lkWFZjLzZBNkZKZTdYanNTUU1BWE5PMURrZHc3OEhNQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HSKu1kS/uOXe9Ky6vw8parct0e7sbNnwz03Wf5oGQfHBWd/Hsx6wZwNzH157y54oNfgge1D9DEacrnoVOGrCqpY0KEouzMxYyoDKRwLy+HLw4zleKBTTJfsvyJaWj/uz8BkimJJUtM5/4I8a22YHivHVvXkZvxYDBaR2q4SKlAaxovallUZIMfC0zIpwgX3d8PISCz8iEK4IyrwTix708kTrizONFN0LZwtqHGTUGflyTcmDEwops94brytHedvaotP/OBCvOTzjni3f3HOUtGklWefy0qMwByZSfYSavIGwghVfiItWzg0tEM+mTDAWCacSlEJNmlkpeoXqnOlG9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b536dad6-706c-430c-b31f-08dee8131199
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:02:53.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bw3S3Qf5TQ0Tb2NUEjV0/Zh/R4MKiNOjLCRAwwK1a2j9b8eaSb+kvv3DkOzxx5bHY3i0uQ0ko8PbXiEM6NIf6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9595
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vaTkxNS9iYWNrbGlnaHQ6IGFsbG93IGh5YnJpZCBw
aW4tZW5hYmxlICsgQVVYDQo+IGJyaWdodG5lc3MgcGFuZWxzDQo+IA0KPiA+IEhpIEpvaG4gdGhp
cyBmaXggaGFzIGJlZW4gYWxyZWFkeSBmbG9hdGVkLCByZXZpZXdlZCBhbmQgbWVyZ2VkIHNvbWUN
Cj4gPiBkYXlzIGFnbyB0byBkcm0taW50ZWwtbmV4dC4NCj4gPg0KPiA+IGh0dHBzOi8vcGF0Y2h3
b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMTcwNTIyLw0KPiANCj4gVGhhbmtzLCBnbGFkIGl0
J3MgZml4ZWQsIGFuZCBoYXBweSB0byBzZWUgdGhlIHNhbWUgY29uY2x1c2lvbjsgcGxlYXNlIGRp
c3JlZ2FyZA0KPiBteSBwYXRjaC4NCj4gDQo+IEZvciB0aGUgcmVjb3JkOiBpbmRlcGVuZGVudGx5
IHJvb3QtY2F1c2VkIGFuZCB0ZXN0ZWQgdGhlIHNhbWUgY2hhbmdlIG9uIGENCj4gR29vZ2xlIFBp
eGVsIFNsYXRlIChub2N0dXJuZSwgVGlhbm1hIFkxNTZaQU4wMi4wOiBhZHZlcnRpc2VzDQo+IEJS
SUdIVE5FU1NfQVVYX1NFVF9DQVAgd2l0aG91dCBBVVhfRU5BQkxFX0NBUCwgaWdub3JlcyBQV00g
Zm9yDQo+IGJyaWdodG5lc3MsIGFuZCByZXNldHMgdGhlIEFVWCBicmlnaHRuZXNzIHJlZ2lzdGVy
IG9uIGV2ZXJ5IHBhbmVsIHBvd2VyIGN5Y2xlLA0KPiBzbyBpdCByZXN1bWVzIGZyb20gc3VzcGVu
ZCB0byBhIHBlcm1hbmVudGx5IGJsYWNrIHNjcmVlbiB3aXRob3V0IHRoaXMgZml4KS4NCj4gV2l0
aCB0aGUgZXF1aXZhbGVudCBjaGFuZ2Ugb24gNy4xLjQgdGhlIHBhbmVsJ3MgQVVYIGJyaWdodG5l
c3MgcmVnaXN0ZXIgaXMNCj4gcmVzdG9yZWQgYWNyb3NzIHN1c3BlbmQvcmVzdW1lIGFuZCBmdWxs
LXJhbmdlIGJyaWdodG5lc3MgY29udHJvbCB3b3Jrcywgc28NCj4gZmVlbCBmcmVlIHRvIGNvdW50
IHRoYXQgYXMgYQ0KPiANCg0KSGkgVGhhbmtzIGZvciB0aGUgcGF0Y2gsIHllcyBJIGhhZCBhIGxv
dCBvZiBnaXRsYWIgZnJvbSBwYW5lbHMgdGhhdCBkb27igJl0IGhhdmUgYSBQV00gZmFsbGJhY2sg
d2hpY2ggbGVkIHRvIHRoaXMgc2FtZSBmaXguDQoNCj4gVGVzdGVkLWJ5OiBKb2huIEZvdXNoZWUg
PGpvaG5mb3VzaGVlQGdtYWlsLmNvbT4NCj4gDQo+IGZvciBjb21taXQgN2Q1OTRiMjQgb24gcmVh
bCBhZmZlY3RlZCBoYXJkd2FyZS4NCj4gDQo+IE9uZSBxdWVzdGlvbjogdGhlIHJlZ3Jlc3Npb24g
KGVkOGJlNzgwYmRiYyB1cHN0cmVhbSAvIDEwMmQ0NGIzYThmYSBpbg0KPiBtYWlubGluZSkgaXMg
cHJlc2VudCBpbiB0aGUgc2hpcHBpbmcgNy4xLnggc3RhYmxlIHNlcmllcywgYnV0IDdkNTk0YjI0
IGRvZXNuJ3QNCj4gY2FycnkgQ2M6IHN0YWJsZS4gV2lsbCB0aGUgRml4ZXM6IHRhZyBiZSBlbm91
Z2ggZm9yIGl0IHRvIGJlIHBpY2tlZCB1cCBmb3INCj4gNy4xLngvNy4yLngsIG9yIHNob3VsZCBp
dCBiZSBub21pbmF0ZWQgdG8gc3RhYmxlIGV4cGxpY2l0bHk/DQo+IEFmZmVjdGVkIGRldmljZXMg
YXJlIHVudXNhYmxlIGFmdGVyIGFueSBzdXNwZW5kIHdpdGhvdXQgaXQsIHNvIGEgYmFja3BvcnQN
Cj4gd291bGQgbWF0dGVyIHRvIHVzZXJzIG9uIGN1cnJlbnQgc3RhYmxlIGtlcm5lbHMuDQoNClll
cyBJIGp1c3QgQ2MnZWQgdGhlbSBzbyB0aGF0IGl0IGdldHMgcGlja2VkIHVwLiBBZGRlZCB5b3Ug
aW4gaXQgdG9vLg0KDQpSZWdhcmRzLA0KU3VyYWogS2FuZHBhbA0KDQo+IA0KPiBEaWFnbm9zaXMg
ZGV0YWlscywgRFBDRCBkdW1wcyBhbmQgRURJRCwgaWYgdXNlZnVsOg0KPiBodHRwczovL2dpdGxh
Yi5mcmVlZGVza3RvcC5vcmcvZHJtL2k5MTUva2VybmVsLy0vaXNzdWVzLzE2Njc5DQo+IA0KPiBU
aGFua3MsDQo+IEpvaG4NCj4gDQo+IA0KPiBPbiBXZWQsIEp1bCAyMiwgMjAyNiBhdCA5OjIy4oCv
QU0gS2FuZHBhbCwgU3VyYWogPHN1cmFqLmthbmRwYWxAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9pOTE1L2JhY2tsaWdodDogYWxsb3cg
aHlicmlkIHBpbi1lbmFibGUgKyBBVVgNCj4gPiA+IGJyaWdodG5lc3MgcGFuZWxzDQo+ID4gPg0K
PiA+ID4gQ29tbWl0IDEwMmQ0NGIzYThmYSAoImRybS9pOTE1L2JhY2tsaWdodDogRml4IFZFU0Eg
YmFja2xpZ2h0DQo+ID4gPiBwb3NzaWJsZSBjaGVjaw0KPiA+ID4gY29uZGl0aW9uIikgcmVzdHJp
Y3RlZCB0aGUgVkVTQSBiYWNrbGlnaHQgcGF0aCB0byBmdWxseSBBVVgtYmFzZWQNCj4gPiA+IHBh
bmVscyAoZW5hYmxlIGFuZCBhZGp1c3RtZW50IGJvdGggdmlhIEFVWCksIG9uIHRoZSBncm91bmRz
IHRoYXQgdGhlDQo+ID4gPiBoeWJyaWQgY29uZmlndXJhdGlvbnMgYXJlIG5vdCBjdXJyZW50bHkg
c3VwcG9ydGVkLg0KPiA+ID4NCj4gPiA+IFRoZSBoeWJyaWQgcGluLWVuYWJsZSArIEFVWC1hZGp1
c3RtZW50IGNvbmZpZ3VyYXRpb24gaXMgaG93ZXZlcg0KPiA+ID4gYWxyZWFkeQ0KPiA+ID4gaGFu
ZGxlZDogaW50ZWxfZHBfYXV4X3Zlc2FfZW5hYmxlX2JhY2tsaWdodCgpIGZhbGxzIGJhY2sgdG8g
dGhlIFBXTQ0KPiA+ID4gZnVuY3MgZm9yIGVuYWJsZSB3aGVuIGluZm8uYXV4X2VuYWJsZSBpcyB1
bnNldCwgYW5kDQo+ID4gPiBkcm1fZWRwX2JhY2tsaWdodF9pbml0KCkgc3VwcG9ydHMgYXV4X3Nl
dCB3aXRob3V0IGF1eF9lbmFibGUuDQo+ID4gPg0KPiA+ID4gQXQgbGVhc3Qgb25lIHBhbmVsIHJl
cXVpcmVzIHRoaXMgY29uZmlndXJhdGlvbiB0byB3b3JrIGF0IGFsbDogdGhlDQo+ID4gPiBUaWFu
bWENCj4gPiA+IFkxNTZaQU4wMi4wIGluIHRoZSBHb29nbGUgUGl4ZWwgU2xhdGUgKG5vY3R1cm5l
KSBhZHZlcnRpc2VzDQo+ID4gPiBEUF9FRFBfQkFDS0xJR0hUX0JSSUdIVE5FU1NfQVVYX1NFVF9D
QVAgYnV0IG5vdA0KPiA+ID4gRFBfRURQX0JBQ0tMSUdIVF9BVVhfRU5BQkxFX0NBUCAoRFBfRURQ
X0dFTkVSQUxfQ0FQXzEgPSAweGZiLA0KPiA+ID4gRFBfRURQX0JBQ0tMSUdIVF9BREpVU1RNRU5U
X0NBUCA9IDB4ZmYpLiBUaGUgcGFuZWwgaWdub3JlcyB0aGUNCj4gUFdNDQo+ID4gPiBwaW4gZm9y
IGJyaWdodG5lc3MgYWRqdXN0bWVudCwgYW5kIHJlc2V0cyBpdHMgQVVYIGJyaWdodG5lc3MNCj4g
PiA+IHJlZ2lzdGVyDQo+ID4gPiAoRFBfRURQX0JBQ0tMSUdIVF9CUklHSFRORVNTX01TQi9MU0Ip
IHRvIDAgd2hlbmV2ZXIgcGFuZWwgcG93ZXINCj4gaXMNCj4gPiA+IGN5Y2xlZC4gV2l0aCB0aGUg
UFdNIGJhY2tsaWdodCBmdW5jcyBzZWxlY3RlZCwgdGhlIHBhbmVsIGNvbWVzIGJhY2sNCj4gPiA+
IGJsYWNrIGFmdGVyIGV2ZXJ5IHN1c3BlbmQvcmVzdW1lIG9yIERQTVMgb2ZmL29uIGN5Y2xlIHdo
aWxlIGFsbA0KPiA+ID4gZHJpdmVyLXZpc2libGUgc3RhdGUgKGxpbmsgdHJhaW5pbmcsIFBQUywg
UFdNIGR1dHkpIGxvb2tzIGhlYWx0aHkuDQo+ID4gPiBGaXJtd2FyZSByZXdyaXRlcyB0aGUgcmVn
aXN0ZXIgYXQgYm9vdCwgd2hpY2ggbWFza3MgdGhlIHByb2JsZW0NCj4gPiA+IHVudGlsIHRoZSBm
aXJzdCBydW50aW1lIHBhbmVsIHBvd2VyIGN5Y2xlLg0KPiA+ID4NCj4gPiA+IEFsbG93IHRoZSBo
eWJyaWQgY29uZmlndXJhdGlvbiBieSByZXF1aXJpbmcgb25seSBBVVggYnJpZ2h0bmVzcw0KPiA+
ID4gYWRqdXN0bWVudCBjYXBhYmlsaXR5OyBiYWNrbGlnaHQgZW5hYmxlIGtlZXBzIHVzaW5nIHRo
ZSBwaW4vUFdNIHBhdGgNCj4gPiA+IHZpYSB0aGUgZXhpc3RpbmcgZmFsbGJhY2suDQo+ID4gPg0K
PiA+ID4gVGVzdGVkIG9uIHRoZSBHb29nbGUgUGl4ZWwgU2xhdGUgKEtCTC1ZKSBvbiA3LjEuNDog
aTkxNSBub3cgc2VsZWN0cw0KPiA+ID4gdGhlIFZFU0EgQVVYIGJhY2tsaWdodCBpbnRlcmZhY2Us
IHRoZSBwYW5lbCdzIEFVWCBicmlnaHRuZXNzDQo+ID4gPiByZWdpc3RlciBpcyByZXN0b3JlZCBh
Y3Jvc3Mgc3VzcGVuZC9yZXN1bWUsIGFuZCBicmlnaHRuZXNzIGNvbnRyb2wNCj4gPiA+IHdvcmtz
IG92ZXIgdGhlIGZ1bGwgcmFuZ2Ugd2hlcmUgaXQgcHJldmlvdXNseSBoYWQgbm8gZWZmZWN0Lg0K
PiA+ID4NCj4gPiA+IEZpeGVzOiAxMDJkNDRiM2E4ZmEgKCJkcm0vaTkxNS9iYWNrbGlnaHQ6IEZp
eCBWRVNBIGJhY2tsaWdodA0KPiA+ID4gcG9zc2libGUgY2hlY2sNCj4gPiA+IGNvbmRpdGlvbiIp
DQo+ID4gPiBDbG9zZXM6DQo+ID4gPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJt
L2k5MTUva2VybmVsLy0vaXNzdWVzLzE2Njc5DQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiA+ID4gQ2M6IFN1cmFqIEthbmRwYWwgPHN1cmFqLmthbmRwYWxAaW50ZWwuY29tPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogSm9obiBGb3VzaGVlIDxqb2huZm91c2hlZUBnbWFpbC5jb20+
DQo+ID4NCj4gPiBIaSBKb2huIHRoaXMgZml4IGhhcyBiZWVuIGFscmVhZHkgZmxvYXRlZCwgcmV2
aWV3ZWQgYW5kIG1lcmdlZCBzb21lIGRheXMNCj4gYWdvIHRvIGRybS1pbnRlbC1uZXh0Lg0KPiA+
DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Nlcmllcy8xNzA1MjIvDQo+
ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFN1cmFqIEthbmRwYWwNCj4gPg0KPiA+ID4gLS0tDQo+ID4g
PiAgLi4uL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwX2F1eF9iYWNrbGlnaHQuYyAgICB8
IDEyICsrKysrKysrLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBfYXV4X2JhY2tsaWdodC5jDQo+ID4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBfYXV4X2JhY2tsaWdodC5jDQo+ID4gPiBpbmRl
eCA3YTZjMDdmLi5hNWMwM2MzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9kcF9hdXhfYmFja2xpZ2h0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBfYXV4X2JhY2tsaWdodC5jDQo+ID4gPiBAQCAt
NjE2LDExICs2MTYsMTUgQEAgY2hlY2tfaWZfdmVzYV9iYWNrbGlnaHRfcG9zc2libGUoc3RydWN0
DQo+ID4gPiBpbnRlbF9kcA0KPiA+ID4gKmludGVsX2RwKQ0KPiA+ID4gICAgICAgdTggYml0X21p
biwgYml0X21heDsNCj4gPiA+DQo+ID4gPiAgICAgICAvKg0KPiA+ID4gLSAgICAgICogU2luY2Ug
d2Ugb25seSBzdXBwb3J0IEZ1bGx5IEFVWCBCYXNlZCBWRVNBIEJhY2tsaWdodCBpbnRlcmZhY2Ug
bWFrZQ0KPiA+ID4gc3VyZQ0KPiA+ID4gLSAgICAgICogYmFja2xpZ2h0IGVuYWJsZSBpcyBwb3Nz
aWJsZSB2aWEgQVVYIGFsb25nIHdpdGggYmFja2xpZ2h0IGFkanVzdG1lbnQNCj4gPiA+ICsgICAg
ICAqIEJyaWdodG5lc3MgYWRqdXN0bWVudCBtdXN0IGJlIHBvc3NpYmxlIHZpYSBBVVguIEJhY2ts
aWdodCAqZW5hYmxlKg0KPiA+ID4gKyAgICAgICogbWF5IGNvbWUgZWl0aGVyIHZpYSBBVVggKERQ
X0VEUF9CQUNLTElHSFRfQVVYX0VOQUJMRV9DQVApDQo+ID4gPiBvciB2aWEgdGhlDQo+ID4gPiAr
ICAgICAgKiBCTF9FTkFCTEUgcGluLCB3aGljaCB0aGUgVkVTQSBiYWNrbGlnaHQgY29kZSBhbHJl
YWR5IHN1cHBvcnRzIGJ5DQo+ID4gPiArICAgICAgKiBmYWxsaW5nIGJhY2sgdG8gdGhlIFBXTSBm
dW5jcyBmb3IgZW5hYmxlIHdoZW4gYXV4X2VuYWJsZSBpcyBub3Qgc2V0Lg0KPiA+ID4gKyAgICAg
ICogU29tZSBwYW5lbHMgKGUuZy4gVGlhbm1hIFkxNTZaQU4wMi4wIGluIHRoZSBHb29nbGUgUGl4
ZWwgU2xhdGUpDQo+ID4gPiArICAgICAgKiBzdXBwb3J0IG9ubHkgdGhhdCBoeWJyaWQgY29uZmln
dXJhdGlvbiBhbmQgaWdub3JlIHRoZSBQV00gcGluIGZvcg0KPiA+ID4gKyAgICAgICogYnJpZ2h0
bmVzcyBhZGp1c3RtZW50Lg0KPiA+ID4gICAgICAgICovDQo+ID4gPiAtICAgICBpZiAoIShpbnRl
bF9kcC0+ZWRwX2RwY2RbMV0gJiBEUF9FRFBfQkFDS0xJR0hUX0FVWF9FTkFCTEVfQ0FQDQo+ID4g
PiAmJg0KPiA+ID4gLSAgICAgICAgICAgaW50ZWxfZHAtPmVkcF9kcGNkWzJdICYNCj4gPiA+IERQ
X0VEUF9CQUNLTElHSFRfQlJJR0hUTkVTU19BVVhfU0VUX0NBUCkpDQo+ID4gPiArICAgICBpZiAo
IShpbnRlbF9kcC0+ZWRwX2RwY2RbMl0gJg0KPiA+ID4gK0RQX0VEUF9CQUNLTElHSFRfQlJJR0hU
TkVTU19BVVhfU0VUX0NBUCkpDQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4g
PiA+DQo+ID4gPiAgICAgICByZXQgPSBkcm1fZHBfZHBjZF9yZWFkX2J5dGUoJmludGVsX2RwLT5h
dXgsDQo+ID4gPiBEUF9FRFBfUFdNR0VOX0JJVF9DT1VOVF9DQVBfTUlOLCAmYml0X21pbik7DQo+
ID4gPiAtLQ0KPiA+ID4gMi40Ny4zDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiANCj4gQGZvdXNoDQo=
