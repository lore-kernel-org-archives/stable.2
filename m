Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4E39021F;
	Wed,  3 Jun 2026 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469126; cv=fail; b=EoAOnSripE/4FFiCNln1fD7PQi5vmlST8zdiQO+mgti0rAjx8o5w+hBTliHxqC02DvdnRLagHzsMv4CR2jNlXCz5kwM/OkZwPZjO3TZD8sfKFXqs5ZvDzuDzyqNElH6VfDNexDe7BLrsdP5HT7s3KVl3KW4FKmhdmOOd4XNxJ+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469126; c=relaxed/simple;
	bh=LhFzzamU73JS9uzqSmIEyCqyJPkJI7kgAxZFgFuEUhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fsp3Xq4wp0tn9VU9dIxiQrh3bg+f+p/c3JTyabiKKtUKs+qCzzFnt1npzbK5yQx1yfaGJe0d5zdET1zi30S5thDYZp2NmSBxMCwaqUNbE/vE52jrti6LLHXc1GYB6l8J9TeSQoDGjl3T9AqW+qQIo07laNp2tez1S4OqkpAsIfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVzDBqQj; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVzDBqQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780469124; x=1812005124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LhFzzamU73JS9uzqSmIEyCqyJPkJI7kgAxZFgFuEUhg=;
  b=HVzDBqQjofJTPHBN3fshAKAmEyNHWv5p+O0RSOo9TJcSvh1Qmmq5MqRZ
   CaQ2BetfY5LZ0gVShIf6Ja7A5geOEHRZ4AmWk+2qD4QjtHKDR3s7+Hc44
   Xp/sEZsJ4JS8Eq2ugHKB0ZWhMq275ktI2GFL/OKxCpXzCZBOxVOkrI1Fj
   JOOg8onimpHB4HIGk2gmeo8TippjUYho00+jq/ZQ9teZ7MBY4NzWWdYT2
   yRf2xGpxiS4DRX0nJOUF7Hjr73XaSZPM8xKJGi/moPO6KMUx1AjJJHPI+
   xTierbO9jjwui39SJOE617nGb6PUzYG8ZNdJZ7WwPDOlrPDIzL/xpFKtW
   A==;
X-CSE-ConnectionGUID: Fno5vGsDSWamc8Y/SF62yw==
X-CSE-MsgGUID: FQiD0ODxRAanqlZLxNRdCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81243182"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81243182"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:45:23 -0700
X-CSE-ConnectionGUID: NocuhFIuTK6hEU2trUbHvg==
X-CSE-MsgGUID: xy0rbyfqS6ygfx3ZcYgqbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241141820"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:45:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:45:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:45:22 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn6ArLXAXrWQaNh698uzvB64lfGnx35bO6BT2aoGG7QxnnpSf3y0QE/E6dA5UUwXEA8MnCKXifl0lcLOWM30GRcZrCLDg8fOgJFZbVmoRGJ77yo06gyh/rYkcyGbEEiDPY2eeyEaseD6A4B04IjutgJ0xocd9RKhzkUEIvA+Ux+qlZN8DXSHlNpx36XLSzIP9oJfzjFslUAURbY1hpjkU1eelqrMza5sbEFlxCSSSsWK6zKgjfmsY6hkuqfMp/1Md1KgPCcBPSzwLs8KIODbC1QPQeU2SP3Gxr7Xb+86xNPVz9dNezs0KII0hHqRy0pHx8X0kbkrSc5Wk1i9j1UKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhFzzamU73JS9uzqSmIEyCqyJPkJI7kgAxZFgFuEUhg=;
 b=HM15q4TIUNGSHPn2nR7WzO1ROJHR9zBh5WPAQXiqWZRFHTFFHI3OLTuRhcRA0zSOmkp3ugaAmKj9yuhvRHRp3h3SQrxvynEB0c/eZ2rcSicgfJcQiU7EIvv711oqajTdyoVKbhgHpXkYj6IGJ8oo46Ct3BwLXeakwS632YW2eECgfmjjg1rNQPIa+mGISsLV+F3FryfsskaF/d+Ox04jAJkt428u+Vg7jHHeMK0nW4ixHFXbxzPqio+o9j6/1dRaRpHv3D078yH1HlmPWpKLdedlcZkSgBPlTerqVPKzzQvN6fjEDysHwoWEOXZoXrTlqod/UBGnbkzuC4ON0C4Zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:45:10 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:45:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Junrui Luo <moonafterrain@outlook.com>, Alex Williamson
	<alex@shazbot.org>, Shameer Kolothum <skolothumtho@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Shay Drory
	<shayd@nvidia.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] vfio: prevent infinite loop in vfio_mig_get_next_state()
 on blocked arc
Thread-Topic: [PATCH] vfio: prevent infinite loop in vfio_mig_get_next_state()
 on blocked arc
Thread-Index: AQHc8m6FU+KCtXyQbkO+q8tBYXjL4rYsY/RA
Date: Wed, 3 Jun 2026 06:45:10 +0000
Message-ID: <DM6PR11MB3690BB88FF8276D28F9D9C938C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: 5c291190-bae0-46a3-a48e-08dec13ba883
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|3023799007|11063799006|5023799004|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: SRvjvIzW5x5h0xbeO0/QzHnE1JP1FZGNJt8YcsYwNoJHHQjmGNy+8N5tWWQhKEUjzAToh6VTBYxM6/BjqSc8afdDscWcHNqMAgAEO5tMONKb5kc6w7b3Wgs+yoDhUMmI1HfJqyFKN0FNGPlEJxpoytsOibGXHNr4E/z3NxhBP2wCF36N7iZXU3injO2Zq5QtuH17eUbd9BwEFRf2FOhQvPKTwxtuQ2Dt9Gdo+iL0cF7c4dEtWnogM/5iKQqb+66dgmQWEZM5FJbY+VHe5Cvhu5x/j2q1Wwn4DFLM8k+Gmk0Fah6L85ctiM19TMmlu+VCbmtGn4YhLpHtD9z/iS8OHEt/74hTrkFMpdCH29AbZefB2DHjFk40a0twNtSUJlN7KPIERJkiM1wDLrmawr02nVs2WaBFWAyNDaylKDQGyC/YjuWzPff4CH1Y3aZ8uMtdMz5meyH1T7GbRW/7J1fK+QM7D0yajuKzw3bkVLxsrLKFbbZ0HtrJvdrgpeW2kAzhAhOLU9LlLzAl9DViqCo95NZvHfTVURQnVVdJCyHjii7DEsfd0uSDRioyGeawZkZ4dAA+WI8XklOd96N4F1VHH9tHmlIaqHs1M/uZBwo4e2MC3B8PPlyijs+aybwVjEwfMRs/uondngYIopmZFQopQKB6WbIw0fwEXiZcmko4JZTcqUOInl+CvhBvbgHIpA4zUtnh4UJw1MjFpTLVcjWu+zJ3N26VAcZIqMpXYA+awxeNrGkuMR1/1r53pp9rNtXh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(3023799007)(11063799006)(5023799004)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEt1MnhEaUNIbWNBdHJJTHlSblJTVFVESmhXVXYreXhmRkR3bXZnVXA5M094?=
 =?utf-8?B?MTlPbUV6N2tOS2U3SGp3VDg4bWNRK0NBWGZMQ1RQSi96YWRYTG5BcnBMb0VD?=
 =?utf-8?B?cEdVeGpDc2JvRmRzQm8wZ3owQVJ5Mi9vU3l2QVZQbUtmekZ1YSt1WlVpU2cw?=
 =?utf-8?B?cVpFUCtXc0lqR3FOR21ZYk5wNnpXL3huaCtUODNhaUs2UFhDZXJWTmtyY0wx?=
 =?utf-8?B?aDRaZ0xCWEk1aENsclBOdXJWUUtHc1V2aUExYkoyNmlJSm5CTFVTYUdUMXNC?=
 =?utf-8?B?N01reG5nT2FpZGRvalA3ZHVtNFVTM25LWlpER3owRkxzYy9iSG5JSGt1aG5D?=
 =?utf-8?B?TWNrK2F1WldRNkZUVFQxcVFleG9rVlNmZHhTOW5CRVhXczlOT1FuRndITmQx?=
 =?utf-8?B?VE85d1hoRDhFUDVJeFZ5b3B6cmJpamhwZHM3em5VSXpzQ0ZiSU5QSFJlZzBq?=
 =?utf-8?B?TmZJb1UyK1ZobDB2UThyc01TR01qLzNSL3orQitabGZNTjkvZjdCSGJETlRQ?=
 =?utf-8?B?OUZYNHFzVm9sQzdLbVYreUsvWmxqc1lrOUx3ejhuYmZ6RURZNG96WU9sM2Zm?=
 =?utf-8?B?UnRhTGRoVXNBdEFTeDJ5enkwZTVpOWVxNnZWakZXMkNFL1lPeVQ5SEMyeUN1?=
 =?utf-8?B?ZnJGTzRYK29sSlUrS0N6dlVSdE5EeVZ3L3pFM2RFV1pjbjh5UkhkcVpkUXAr?=
 =?utf-8?B?ZW1tRUNCdEkxZm91WnBmV0dlQUZYZ3pySGZobUVMV3BHVTdkZ05QT2hKSHRR?=
 =?utf-8?B?NlE4NVRnV1lDSlVydFJpeXJKaDIwWmw4T3lBTGZQVVBoTzNjQ2M3OWRoZk5s?=
 =?utf-8?B?UzVHZzhZdWc3NUY1cnpuczFYT0FQVHlzbm5oVmppK2F6WFpwbEVTTC83ZjQ4?=
 =?utf-8?B?T09saHRDaHhTUHZZdW9pYUt3eERWa3lMa1NCMFBzZGhHS2F1blZsYUllWGNo?=
 =?utf-8?B?YVlLTmNCL0ZzanN5TGorR0VibDlXWDNmQnR3THptYnpRTldCVFJxSXV3WEp1?=
 =?utf-8?B?dEJpaWdkQ1JVWExQQ3dNMDVKa0lGRitmOHBZUDhYSXZWY0pVV2ZVOU9DSTJs?=
 =?utf-8?B?RW13dnNZaGtsSTh6TTdIQ2FHM2sxbHkxdWNIZWtKcGs1TEFSSXlyaUlBQmRk?=
 =?utf-8?B?anJOOXo3ck5OeDRFWUpVMjVYbTc4c3ZTeTVKYWZWNDcveGVHNmR6RHlWSXg4?=
 =?utf-8?B?QWxVRktXQmVaL281ejRKUG02bjA2ekZ6S3dPenVGeEJnckszcW9LaVZiMlFt?=
 =?utf-8?B?VGdCSmpVazBmNXQxemhWc0NHWW9VVDQ1akxtdFdEUUVCTlJ3Y3JGTktjZlhJ?=
 =?utf-8?B?cWg1ZjhvR0JJWUR0dlJZeHJ6TFVSWmxCTFRWVHBnc0JjdzYzUU5aK2Z6ZXZ0?=
 =?utf-8?B?RUVNSXJzUWxIRkpQZjY1WWp4VW5RaXRtaDl5QktSY2hpMzI5Z0J2YytqWjFu?=
 =?utf-8?B?VnhHWklER3lzYkRtU2Rmc09YbWVmOGdFdGNrRzZxZitpd25BR3kwejlXNkt5?=
 =?utf-8?B?aWdIMllRVjZwaW9LYzBUYTQ0KzlKV0dtVFlRbmZxWVovRDZhbDV0WUthempT?=
 =?utf-8?B?ME1RQU1FdURGM3lscERGMTlMK2pQNUtCVWRRU0VWZElFN3BZQUU4N1JWWlZh?=
 =?utf-8?B?dmpFbEpYekZBeEZIZGRWS0RpMTd2Q0R1MDA0TXNrRXhsL1F5QjRvQ2M1YXZO?=
 =?utf-8?B?dm1uZ2QzY0JYU1dGdm0wdHUzVityY2p0MVlEbzJiNnFPTXlDV25takJBYk5Q?=
 =?utf-8?B?VmlTZmFaYVU5NS8xRFVFNko1U3JQRDFoOWNRUFJYS3lGbVFWVThTMjNFcnZP?=
 =?utf-8?B?bkpaNlZvcXdkK3NvZC85aERJU0xCamNaR3EvQm1tQmN3M0R3ekJkT1VIdy8x?=
 =?utf-8?B?RG9jb3I1TkdVQWRSOFIvak84Qjh3NG1KdDJPSXcrWVNIWHRiaWdXK20xMnZn?=
 =?utf-8?B?ZnNhOEgxRUMydEFldDhkL1p4OC9KV3I4WUxaVEQ0WWcvbFVRWENrc0JiZnhD?=
 =?utf-8?B?OXYwOW5CUVRzbUhzK09NRjZBbk44Yno3aTVNTlJ5K3M1ZHFaVVkxdEdUWWdH?=
 =?utf-8?B?cGcrTGE4VFNSZmtsTjdxVlhXT0ZSOVkvTW54UE90R0ZQdFVSNE13M3pwVEdo?=
 =?utf-8?B?RXZ1LzNYcDhvRkRtWXFWZUdzSzhPNTVTV0ZTTEVrcG45NmJ4NUdidFhCTmhk?=
 =?utf-8?B?SXRrWHJ3Z2l0ajZDbkt3VVExZ1NKM0o1cnJxSDZ0cUI4eG1mZXRWOFNnTndX?=
 =?utf-8?B?aW1PVXlMRFN1RkxHTUJTc3hlMzdlVXNSNWsrRm5mOWliVEY3eDFOMUhlNEZk?=
 =?utf-8?B?Q2ZVbkJOdUYzWTVQYzBiZGtBM2Y2b2dyNlkzNVdUUldvd1ZsbVNodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lpk+L9U+C41zKVSIJ1byUBlTVe+dupbr2D/hkRonj9DfZEjsrsHDWxHSUBoanvYpAP5pnq3BHkzIDK5tfnFzHyZnbLdeE3ORENBvdXVCMKPtAR3Zeb+9Br9405aGQtQ92Aiz2j1x9Z3PHJEO+iqGlzwvfmu3dM8rPUxVz8CK752Xk8AHyRdrSVb7EDNEEOSunq3CNhMDizEl8VbUnvrwtzZOoRH6P4YGZRgfDfYn9LNxGBpkQHASyL1svmpg5sAuefhYgvT9Ai3yiovFnsZUZ6p0O60ixK7MBTDeTMnYUpDa1nOdX6TqaDM9WdSvKdPvFQVNfddt4lVGM9RJ3WLvmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c291190-bae0-46a3-a48e-08dec13ba883
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:45:10.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hfYTemg+rSRLUEM7UwUvdkRbQzWyCueWGKFfagxCj1dU8QF23L6nKuj5SH0pKSu3a+yBYyTAqKyi/KG6tACdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-OriginatorOrg: intel.com

PiBGcm9tOiBKdW5ydWkgTHVvIDxtb29uYWZ0ZXJyYWluQG91dGxvb2suY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBKdW5lIDIsIDIwMjYgNDo1OSBQTQ0KPiANCj4gdmZpb19taWdfZ2V0X25leHRfc3Rh
dGUoKSB3YWxrcyB2ZmlvX2Zyb21fZnNtX3RhYmxlW10gb25lIHN0ZXAgYXQgYSB0aW1lLA0KPiBs
b29waW5nIHRvIHNraXAgb3B0aW9uYWwgc3RhdGVzIHRoZSBkZXZpY2UgZG9lcyBub3Qgc3VwcG9y
dCB1bnRpbA0KPiAqbmV4dF9mc20gaXMgc3VwcG9ydGVkLiBBIGJsb2NrZWQgdHJhbnNpdGlvbiBp
cyBlbmNvZGVkIGFzDQo+IFZGSU9fREVWSUNFX1NUQVRFX0VSUk9SLCB3aGljaCB0aGUgdHJhaWxp
bmcgcmV0dXJuIHJlcG9ydHMgYXMgLUVJTlZBTC4NCj4gDQo+IFRoZSBza2lwIGxvb3AgZG9lcyBu
b3QgYWNjb3VudCBmb3IgdGhlIEVSUk9SIHNlbnRpbmVsLg0KPiBzdGF0ZV9mbGFnc190YWJsZVtF
UlJPUl0gaXMgfjBVIGFuZCB2ZmlvX2Zyb21fZnNtX3RhYmxlW0VSUk9SXVsqXSBpcw0KPiBFUlJP
Uiwgc28gb25jZSAqbmV4dF9mc20gYmVjb21lcyBFUlJPUiB0aGUgbG9vcCBjb25kaXRpb24gc3Rh
eXMgdHJ1ZSBhbmQNCj4gKm5leHRfZnNtIG5ldmVyIGNoYW5nZXMuIFRoZSBibG9ja2VkIGFyY3Mg
U1RPUF9DT1BZIC0+IFBSRV9DT1BZIGFuZA0KPiBTVE9QX0NPUFkgLT4gUFJFX0NPUFlfUDJQIG1h
cCB0byBFUlJPUiB5ZXQgcGFzcyB0aGUgc3VwcG9ydCBjaGVjayBvbiBhDQo+IHByZWNvcHktY2Fw
YWJsZSBkZXZpY2UsIGNhdXNpbmcgdGhlIGxvb3AgdG8gc3BpbiBmb3JldmVyIHdoaWxlIGhvbGRp
bmcNCj4gdGhlIGRyaXZlciBzdGF0ZSBtdXRleC4gVGhpcyBjYW4gcmVzdWx0IGluIGEgc29mdCBs
b2NrdXAsIGFuZCBhIHBhbmljDQo+IHdpdGggc29mdGxvY2t1cF9wYW5pYyBzZXQuDQo+IA0KPiBU
ZXJtaW5hdGUgdGhlIHNraXAgbG9vcCBvbiB0aGUgRVJST1Igc2VudGluZWwgc28gYSBibG9ja2Vk
IHRyYW5zaXRpb24NCj4gZmFsbHMgdGhyb3VnaCB0byB0aGUgZXhpc3RpbmcgcmV0dXJuIGFuZCBy
ZXBvcnRzIC1FSU5WQUwuDQo+IA0KPiBGaXhlczogNGRiNTI2MDJhNjA3ICgidmZpbzogRXh0ZW5k
IHRoZSBkZXZpY2UgbWlncmF0aW9uIHByb3RvY29sIHdpdGgNCj4gUFJFX0NPUFkiKQ0KPiBSZXBv
cnRlZC1ieTogWXVoYW8gSmlhbmcgPGRhbmlzamlhbmdAZ21haWwuY29tPg0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBKdW5ydWkgTHVvIDxtb29uYWZ0ZXJy
YWluQG91dGxvb2suY29tPg0KDQpSZXZpZXdlZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBp
bnRlbC5jb20+DQo=
