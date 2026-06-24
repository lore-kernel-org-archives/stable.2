Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D13815CB
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281303; cv=fail; b=uI0VW95Lep6sgmbXQUhzNbrXsCmE9+dyQefU4I6VGRFk+QuMugJ235S01DvkaTzI/82HategqBeItunZzNNb+4O3iAlZ3BDx548aGIrVcpikvDMSazi0chlMd8u0SzhDiyrzP8/X1TSFTXRXc0rcR0fY1TaYOVwBSFX5tEYxRHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281303; c=relaxed/simple;
	bh=LoROcJJHECYhHexo5zb9IoUKjcB/JAdNp8YyNefJYxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxBiNf86Hr6rBn8SZjv2RYA2+CqJjzjjV3+NfZcfHoQVW65UoRGXLzZ6FM6FQ5XC3xGBK+tyTZocfuDqtHzvXEUvhHouEGctiQ92K6ZOsWyDKZeI80OU+s/lfICqtnXeGjGsYQ2mSM22jOg0yLC9qAmg3CnvWW80pcuQUNJ+MnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jk8kmJO3; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jk8kmJO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782281301; x=1813817301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LoROcJJHECYhHexo5zb9IoUKjcB/JAdNp8YyNefJYxM=;
  b=Jk8kmJO3/qI33hHAG1vOoOpUcsI5cfQg6KmlYsJrZnZ0AqF8y3RMMZ3C
   lYMyL9N13wCTLqUaDAZ3fswTh+rRdt9WTMoNfR+00/tDI5ZcYljI58wQ9
   eheYAhcLxJ1Ou+lfDuArFg9LU4REgL9OAF0D7j8Y4rbxWMAFVlCWZlYEw
   pmpz+kn7t3L0WLIc4P154NyvKzLMVOKYT5MmuY/HmOrKPk2MF4ZApmBbW
   UXkf/LvqkV0pQX4O8za1WYh6qa0Ce/AEvCRArgnXbSwMmB1XQChLQ5anV
   eDpVC2axvlyortSK/e5vPBZB9gkVwl55oLEDUSMWR1nQvh7qqnAJ495v1
   Q==;
X-CSE-ConnectionGUID: vpF83ocgSzyUiWy/rKRAZA==
X-CSE-MsgGUID: 11kEZUS7QPO9UydppcinjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82149329"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82149329"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 23:08:20 -0700
X-CSE-ConnectionGUID: IM7WQXc3Qba0s1v+RFThPw==
X-CSE-MsgGUID: hNeFlfvlQ/aBmYqac6M3yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249840928"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 23:08:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 23:08:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 23:08:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 23:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+Ne7Vy0m9z9inVXAdeS4Tz1viJ+g75eZ7XRQuyaLoU1dVLt0gjw9whErcdqLwa5iWfHi/mLnzPcoIuIzoeHSucCOpLXvQYAHmFhwrtRx4grCd7zEMXhwRfS7EXuDp0ZU2UhbUPn3PGGdYSu/0eG7T6O0bj0ZZBqqk+QT83QGCftsjzBZx3xNmi/C8NwwEsJJTJ9cNRv/4z5PUr9ZXjAXXkI155bPZ0A6EiQ1NZjvgd5UGntysEkTumNIj4sDRyRgWckxFyMJimy70Epd5B97oN6Y7fP5OXvEqZfZzGKV1OZ6W0jsiOzZ24Ym+z+ppXqtntHHpkxf7Xygi4A4JF90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoROcJJHECYhHexo5zb9IoUKjcB/JAdNp8YyNefJYxM=;
 b=TXRKhTQbPoiTeFbG5Com4vk4YehyQSxd3ADyfNkIettx3x2d2lpER0I6pLgo5aft4oBeg8Apk42jYZeAjL6K6BQCkvkXnXNlM+kHdKHQqTYjQ4lmY2iLC52LGK3HPCw1o7AA62cjnyXhACdFA2W56Rn3MrPpmgBJETJARMHtW3+o0pkbsr7VsCBfrUSN+qK8e1HrDGM6Ft0qvsXt9bGgge2FF64WVoqpfFSKhGz3aW9kW9geEnY2CVoGEIINHX3lN2XZQX4gFEWXiWZjyxKQNzySCnxGADvhOqvymRVQjno3Lc2v0yjbRO3YonaToFr8DCJiL1vN7IVFDjW8XjoXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 06:08:15 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 06:08:15 +0000
From: "Gote, Nitin R" <nitin.r.gote@intel.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Thomas Hellstrom
	<thomas.hellstrom@linux.intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH] drm/xe: Create imported sg BO only after dma-buf attach
Thread-Topic: [PATCH] drm/xe: Create imported sg BO only after dma-buf attach
Thread-Index: AQHc/j1mtnz0pGZJdESjfBaaz/+9/7ZCgvcAgAqyyQA=
Date: Wed, 24 Jun 2026 06:08:15 +0000
Message-ID: <SA3PR11MB811895D76A9BED7E81C76B45D0ED2@SA3PR11MB8118.namprd11.prod.outlook.com>
References: <20260617101654.1989199-2-nitin.r.gote@intel.com>
 <6c5c3c43-7f42-41c9-9d59-7109b68831c7@amd.com>
In-Reply-To: <6c5c3c43-7f42-41c9-9d59-7109b68831c7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8118:EE_|SJ1PR11MB6252:EE_
x-ms-office365-filtering-correlation-id: b07cfb9d-74ce-4303-e6a4-08ded1b6faa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|38070700021|4143699003|56012099006|22082099003|5023799004|11063799006;
x-microsoft-antispam-message-info: xaorWZsMjH8yy5cs7/Vim41JK+Jwnt419xDQ5kcnqUArq3PEcrG8jKhvIe9nyxEvRMIuLZj3i1TE/8iG2oxyIgVQSEyEm1UIxFbFdNR1VI5XJ5y7TXmZx6PwmX5aVn9ldNaveutT1INLbtqGPeYp6D6RifRkQjuBBHNmRXnYbALT5AmBO/ClTvghpaHFAdVWCj4Msiw/BYk5tcF20ReNrAJQ9S4EyUv9GLl7S2Xqw/wFf+3EuYX8EysT0vdKaqiMBZaM7KZDCmJah3upQKNwH7KdB9A4qEx/aDOa1exw79UUB38J8YFxaYw9xFUYqmyQzz5l0yXxFKsDfo7LbHJKOOljFLRfqLmgB8eib0F7EtNwjSk/USQwba5zwQWfa0naq5BD/O9sa9T2XqJ0zgPLVEjT+ja7S3El1kpBX/g0dJ8Khrq6rUIyBVeuF2FK0nISGH2tO6oyGcimfadWvD42wGZmk0GMVUTY/XKAjEPbbegBGeJcAT1Ho3/Bi5N9tlLSLt6VKPQ7BjpRusCXsPvZ7UX5taAQKMdwF6L7VZeOW+9E6gaB+5CWmGC/R/Bh9a7NqWI0pfpszBQFwhZn5TDBXNr+hqmT4o0RtZ+yxTxTjsQ1UP/k1qUPZDj5B7a7GiASGNQtW8lWrPC5u/NNAIP7e/lX5/Dgm5GpJUBnzvVih9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(38070700021)(4143699003)(56012099006)(22082099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjlFMGZKb0VXdlFoclBXbWtNUWV0TExKWHdFbXUxSDhxbUVCYXU1RWZDQXpr?=
 =?utf-8?B?ZWRMTHczL3JMUWs5QjQ3cHNrencwVnpuazBtUS9TWDNzakZobHE3VFpnVjY4?=
 =?utf-8?B?S3FncXhhc3pzbG9sMHg4aEs2aXJVUUtraVdNRGxlRCtQSEE0NkV1VVRncVJu?=
 =?utf-8?B?QXl3MzhlS1NOb0EwR3kzazBkU05EbzJSRjJzS2dDSVN2cmxDbmZLVWcybFpq?=
 =?utf-8?B?ODJGRHVyVk5tSkJxaXJWSlV4YUI4SU10SktOMlF2VUVKczllVllGRmxmS05t?=
 =?utf-8?B?MUVQQmo3YytQTnBlb1FmamVxQjlCZ0VIOFpmZ28yUzJqVE1pUlBrejFnN0FG?=
 =?utf-8?B?SDNmdzBsWWRpMTZmdUZHZkYzaVZHRTR0Y3pWMlErV1ZWbzJKN3pqcXd6OUdZ?=
 =?utf-8?B?Q3d5OGdyWjhkZWVYMnU0LzNuZFo5bTAyVzBLNzFmdWxtWlVIYWlLY1JoTnpJ?=
 =?utf-8?B?OGlBZFZsbGRZVG1qekw2THAwUi9FWU1Kc2l2MW5zZ1g3UTNPQy9nS04yM3BB?=
 =?utf-8?B?TnVXVzVOS3VSSkR2cFdVWjBXQWg3aE00Qm55ODgxMWV3Rm9LNEliTGRJSGJm?=
 =?utf-8?B?NlR3bU9KOWJQZWM4R1QybnFHc1BGb3hIVHljNlk2Y28vVnd4d0xzaVZ1bFc2?=
 =?utf-8?B?a0JtNkhCbWNvWWJkMDZKd2VGSEZ1MTFENElycmhRNGhCM3NUaVozZnFSaTkv?=
 =?utf-8?B?YkJ2eHBBd1BtM1VYcnVkVHQ5VTFqS2c2NEp3dmxMcldNWC9qRkc1aE5TaWtl?=
 =?utf-8?B?Y0hWUmZZVlY5eWppZmhCdE41VzhzNEJuellkS3JkYjY2VmtTelg1eVRkOHNH?=
 =?utf-8?B?dmNLREYwdnNuWWwzNk43Z0FqNko2K2pwRC9UL0Z1MmgzRnFpYzVOdWo3NUFt?=
 =?utf-8?B?d2RoM05JM1U5a3F1SUV3OURiZm82K2t5aHAvc1krWVFRZTFrN2hMOHJLeG0x?=
 =?utf-8?B?a1JMMytxajJlSEh3YjZqR2E5aWJrVG1jVEFoNVZzRmllUlR0SGUxOGQ2VXAy?=
 =?utf-8?B?MFlHaS9GTVplM1dUZThzTVhBQXBRUkFPQXVHNWJnQnZDMFhzMWVTVVZqT3By?=
 =?utf-8?B?TmZLZ3BqNUlwRmZGMGNwa2FyOHBJZXF6ejY2K251SHBBaDZhdlozTHROS0h5?=
 =?utf-8?B?UWp3eHpmTjkrK2gwbWRsaThqTGRhYzd2bjN5eUxLK2NPVEEzeG4wVVdCVGFJ?=
 =?utf-8?B?YnFKd1dJR3JEeENiRk1sK28zNDE2NDNOanhnTW5yeEJoUTZzYWdwZVFLRDht?=
 =?utf-8?B?UHllMGxFWGpQcEFWeXpndXA3Z0grVzd6UE82Ui9XUk5oN1FJd2c1S1NqNXls?=
 =?utf-8?B?RkZJamhkQm1hZmkycTIzYkFvVWZMdFIzT0QrdnEwelhrcVZCSzA3OTJLMFZE?=
 =?utf-8?B?ZUZkSWpEQkl4aUxwTWJaREZHS1FocDlQVVcrQURzV0Jzb2I5VEkrVGlYblN1?=
 =?utf-8?B?bmpOc0hxWVkrUU9jNnFZZ1AwdlZPaFRpMmUyc0hzYlI0RHFCRXV6TTlaVUdS?=
 =?utf-8?B?RlZESS9Rdjhkc0ZtMzNKVkVBQStDYlZwT1o3bTJmMDF5a3ZWWWdjOGxONXN6?=
 =?utf-8?B?Y0IvUGNvSXB6akZRc1pwbTZjYjZEWVJUWHF0WFE2RDNya1ZYYUN0UkhXaVRo?=
 =?utf-8?B?UXNuSTBKWUlzZVhvaDIweWNFR056UHlvQll1dVRHMFBNZmRHNmRyZUtISG1K?=
 =?utf-8?B?ODZERFI1ZDFGR2ZjZ1ZSZDkwek51ZGJDS2ZOcVN3NEtVZlVsWlBMbkQrV1Z3?=
 =?utf-8?B?T2xWM3NSeStMVjU4N3VyMVM4bHJndWpZSkJHZWhGMndJblBFWnVibnhtTkVU?=
 =?utf-8?B?aUdFcW5RdlhmckJpcjFCUW85SlZaL0YvM21tRXRtZnYvR1pubWZzZ2FhV0lk?=
 =?utf-8?B?YjRFT0JHd3RhSWVJYnFlVVgwL3ljNjBBMlV3SUFsUWdPZ0cvTTBXS0dKd3ZY?=
 =?utf-8?B?Qzc5V2NnVDFtMWQxNmxpM09SNU9FRGxndTdCL1pTWlU1YnhpRHhEMEF5Tk91?=
 =?utf-8?B?VjR3N294bDBZTzF3UEQ4Zkg3ZzdvMkRKU1B3R1VXK09VbDJ4VjdyQUQweUk0?=
 =?utf-8?B?ZWtpR1ZYQVRicUJHS1VwdlpsQ0FheWQreENMYlJuSjllTVFwMS9OZGZPYlEr?=
 =?utf-8?B?LzZPUlQyNDhCQnFWdGRST1FZZHRwenR6K0hkVVdSTTYxdDluaFRsakhDYzFp?=
 =?utf-8?B?UU1NamVRcmF1YVRQbG8va0NlWVVSaGxFMnVSd2NaZEFXUW41dXBNQjhMZ3pR?=
 =?utf-8?B?aHVzazVnVFU1ZUNMRERsaktZSUhia0R2dGhqZkVOUjZXMlFWV3Q0UHFFUXhF?=
 =?utf-8?B?NzN4ZVcxbGpZT0s1anpERWdmWmZaQ0pVT05WOFNuNTRsclpyODgrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: boKfwbHk6JDR1x5GZszHVshvQPkfzON6oP+BxmvuM8kazWB199HMzgcoFMSo2CJcBowA/DHf41oURC2amHnOQ1AvdiAmqkp5sj+M2yvQbBza4GTGpKSo9La2w2ISzQYWkOoBOWtd/ZFhd2E7NEvlPtfU7OY7MpgQmOvPLudLlo4eh2hYhrcI+0Zzb08bauquBQctzcs5hJ31/aeXhQpZFk852NbSl2hz5sOxdVZzTh6+LabTRfCjskjw89vm22rPWv1WuYsMD76Z4+T77NfEu1PQ9QIE/AoaYl7CMSDbZ0edHJGfQqg3Low1rWhocdS6ZiGQCSjl274ytvaH2QKN9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07cfb9d-74ce-4303-e6a4-08ded1b6faa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 06:08:15.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nt91UgsbsdrlRd2iwv9TL5TM1m1uocNJxuuYKOoQoLGWhYDNOzkrCMC/zwNt3ivo7GEGFMlXDhVYVCll2MG3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6252
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxNywgMjAy
NiAzOjI4IFBNDQo+IFRvOiBHb3RlLCBOaXRpbiBSIDxuaXRpbi5yLmdvdGVAaW50ZWwuY29tPjsg
aW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnOyBUaG9tYXMgSGVsbHN0cm9tDQo+IDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNv
bT47IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS94ZTogQ3JlYXRlIGltcG9ydGVkIHNnIEJPIG9ubHkgYWZ0ZXIgZG1hLWJ1
ZiBhdHRhY2gNCj4gDQo+IE9uIDYvMTcvMjYgMTI6MTYsIE5pdGluIEdvdGUgd3JvdGU6DQo+ID4g
eGVfZG1hX2J1Zl9jcmVhdGVfb2JqKCkgY3JlYXRlcyBhIHR0bV9ib190eXBlX3NnIEJPIHdob3Nl
IHJlc3YgcG9pbnRzDQo+ID4gYXQgdGhlIGV4cG9ydGVyJ3MgZG1hX2J1Zi0+cmVzdiwgdGhlbiBk
bWFfYnVmX2R5bmFtaWNfYXR0YWNoKCkgaXMNCj4gPiBjYWxsZWQuIElmIHRoZSBhdHRhY2ggZmFp
bHMsIG5vIGltcG9ydGVyIGF0dGFjaG1lbnQgZXhpc3RzIGFuZCB4ZSBkb2VzDQo+ID4gbm90IHJl
dGFpbiBhIGRtYS1idWYgcmVmZXJlbmNlLCB5ZXQgdGhlIEJPJ3MgcmVzdiBzdGlsbCBwb2ludHMg
YXQgdGhlDQo+ID4gZXhwb3J0ZXIncyBkbWFfcmVzdi4gU2luY2Ugc2cgQk8gY2xlYW51cCBpcyBk
ZWZlcnJlZCwNCj4gPiB0dG1fYm9fZGVsYXllZF9kZWxldGUoKSBtYXkgbGF0ZXIgbG9jayB0aGF0
IHN0YWxlIHJlc3YgYW5kIGhpdCBhDQo+ID4gdXNlLWFmdGVyLWZyZWUuDQo+ID4NCj4gPiBGaXgg
dGhpcyBieSByZXZlcnNpbmcgdGhlIG9yZGVyOiBhdHRhY2ggZmlyc3Qgd2l0aCBhIE5VTEwNCj4g
PiBpbXBvcnRlcl9wcml2LCB0aGVuIGNyZWF0ZSB0aGUgQk8gb25seSBhZnRlciB0aGUgYXR0YWNo
IHN1Y2NlZWRzLiBUaGUNCj4gPiBpbnZhbGlkYXRlX21hcHBpbmdzIGNhbGxiYWNrIHRyZWF0cyBO
VUxMIGltcG9ydGVyX3ByaXYgYXMgYW4NCj4gPiBpbmNvbXBsZXRlIGltcG9ydCBhbmQgcmV0dXJu
cyBlYXJseTsgYXQgdGhhdCBwb2ludCBubyBpbXBvcnRlciBCTyBoYXMNCj4gPiBiZWVuIGNyZWF0
ZWQsIHNvIHRoZXJlIGlzIG5vdGhpbmcgdG8gaW52YWxpZGF0ZS4NCj4gPg0KPiA+IElmIEJPIGNy
ZWF0aW9uIGZhaWxzIGFmdGVyIGF0dGFjaCBzdWNjZWVkcywgZGV0YWNoIGFuZCByZXR1cm4gdGhl
IGVycm9yLg0KPiA+IFNpbmNlIGdldF9kbWFfYnVmKCkgaXMgb25seSBjYWxsZWQgYWZ0ZXIgQk8g
Y3JlYXRpb24gc3VjY2VlZHMsIHRoZQ0KPiA+IGVycm9yIHBhdGhzIGxlYXZlIG5vIGV4dHJhIGRt
YS1idWYgcmVmZXJlbmNlIGJlaGluZC4NCj4gPg0KPiA+IFRlc3RlZCB3aXRoIGlndEB4ZV9saXZl
X2t0ZXN0QHhlX2RtYV9idWZfa3VuaXQgb24gQk1HDQo+ID4NCj4gPiB2MjogKFRob21hcykNCj4g
PiAgIC0gUmV3b3JrZWQgdGhlIGZpeCB0byBhdm9pZCBjcmVhdGluZyB0aGUgaW1wb3J0ZWQgc2cg
Qk8gYmVmb3JlDQo+ID4gICAgIGRtYV9idWZfZHluYW1pY19hdHRhY2goKSBzdWNjZWVkcy4NCj4g
PiAgIC0gQXR0YWNoIHdpdGggaW1wb3J0ZXJfcHJpdiA9PSBOVUxMIGFuZCBtYWtlIGludmFsaWRh
dGVfbWFwcGluZ3MgaWdub3JlDQo+ID4gICAgIGluY29tcGxldGUgaW1wb3J0cy4NCj4gPiAgIC0g
S2VlcCBnZXRfZG1hX2J1ZigpIGFmdGVyIHN1Y2Nlc3NmdWwgQk8gY3JlYXRpb24gc28gZXJyb3Ig
cGF0aHMgbGVhdmUgbm8NCj4gPiAgICAgZXh0cmEgZG1hLWJ1ZiByZWZlcmVuY2UgYmVoaW5kLg0K
PiA+DQo+ID4gRml4ZXM6IGQ5OWZiZDlhYWI2MiAoImRybS90dG06IEFsd2F5cyB0YWtlIHRoZSBi
byBkZWxheWVkIGNsZWFudXAgcGF0aA0KPiA+IGZvciBpbXBvcnRlZCBib3MiKQ0KPiA+IENsb3Nl
czogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS93b3JrX2l0
ZW1zLzgwMjMNCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjgrDQo+ID4gQ2M6
IFRob21hcyBIZWxsc3Ryb20gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPg0KPiA+
IENjOiBDaHJpc3RpYW4gS29uaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gPiBDYzog
TWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiA+IEFzc2lzdGVkLWJ5OiBH
aXRIdWJfQ29waWxvdDpjbGF1ZGUtc29ubmV0LTQuNg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pdGlu
IEdvdGUgPG5pdGluLnIuZ290ZUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS94ZS94ZV9kbWFfYnVmLmMgfCA0Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RtYV9i
dWYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RtYV9idWYuYyBpbmRleCA4YTkyMGU1
ODI0NWMuLjlmYzRjNTQ4NDUxOQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS94ZS94ZV9kbWFfYnVmLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZG1hX2J1
Zi5jDQo+ID4gQEAgLTMxNywxMCArMzE3LDE5IEBAIHhlX2RtYV9idWZfY3JlYXRlX29iaihzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LA0KPiA+IHN0cnVjdCBkbWFfYnVmICpkbWFfYnVmKQ0KPiA+DQo+
ID4gIHN0YXRpYyB2b2lkIHhlX2RtYV9idWZfbW92ZV9ub3RpZnkoc3RydWN0IGRtYV9idWZfYXR0
YWNobWVudCAqYXR0YWNoKQ0KPiA+IHsNCj4gPiAtCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2Jq
ID0gYXR0YWNoLT5pbXBvcnRlcl9wcml2Ow0KPiA+IC0Jc3RydWN0IHhlX2JvICpibyA9IGdlbV90
b194ZV9ibyhvYmopOw0KPiA+ICsJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSBSRUFEX09O
Q0UoYXR0YWNoLT5pbXBvcnRlcl9wcml2KTsNCj4gPiArCXN0cnVjdCB4ZV9ibyAqYm87DQo+ID4g
IAlzdHJ1Y3QgZHJtX2V4ZWMgKmV4ZWMgPSBYRV9WQUxJREFUSU9OX1VOU1VQUE9SVEVEOw0KPiA+
DQo+ID4gKwkvKg0KPiA+ICsJICogVGhlIGF0dGFjaG1lbnQgaXMgdmlzaWJsZSBiZWZvcmUgdGhl
IGltcG9ydGVkIEJPIGlzIGNyZWF0ZWQuDQo+ID4gKwkgKiBVbnRpbCBpbXBvcnRlcl9wcml2IGlz
IHNldCwgdGhlcmUgaXMgbm8gaW1wb3J0ZXIgb2JqZWN0IHRvDQo+ID4gKwkgKiBpbnZhbGlkYXRl
Lg0KPiA+ICsJICovDQo+ID4gKwlpZiAoIW9iaikNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+
ICsJYm8gPSBnZW1fdG9feGVfYm8ob2JqKTsNCj4gPiAgCVhFX1dBUk5fT04oeGVfYm9fZXZpY3Qo
Ym8sIGV4ZWMpKTsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTM2NSwzMSArMzc0LDM0IEBAIHN0cnVj
dCBkcm1fZ2VtX29iamVjdA0KPiAqeGVfZ2VtX3ByaW1lX2ltcG9ydChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LA0KPiA+ICAJCX0NCj4gPiAgCX0NCj4gPg0KPiA+IC0JLyoNCj4gPiAtCSAqIFRoaXMg
bmVlZHMgdG8gaGFwcGVuIGJlZm9yZSB0aGUgYXR0YWNoLCBzaW5jZSBpdCB3aWxsIGNyZWF0ZSBh
IG5ldw0KPiA+IC0JICogYXR0YWNobWVudCBmb3IgdGhpcywgYW5kIGFkZCBpdCB0byB0aGUgbGlz
dCBvZiBhdHRhY2htZW50cywgYXQgd2hpY2gNCj4gPiAtCSAqIHBvaW50IGl0IGlzIGdsb2JhbGx5
IHZpc2libGUsIGFuZCBhdCBhbnkgcG9pbnQgdGhlIGV4cG9ydCBzaWRlIGNhbg0KPiA+IC0JICog
Y2FsbCBpbnRvIG9uIGludmFsaWRhdGVfbWFwcGluZ3MgY2FsbGJhY2ssIHdoaWNoIHJlcXVpcmUg
YSB3b3JraW5nDQo+ID4gLQkgKiBvYmplY3QuDQo+ID4gLQkgKi8NCj4gPiAtCW9iaiA9IHhlX2Rt
YV9idWZfY3JlYXRlX29iaihkZXYsIGRtYV9idWYpOw0KPiA+IC0JaWYgKElTX0VSUihvYmopKQ0K
PiA+IC0JCXJldHVybiBvYmo7DQo+ID4gLQ0KPiA+ICAJYXR0YWNoX29wcyA9ICZ4ZV9kbWFfYnVm
X2F0dGFjaF9vcHM7ICAjaWYNCj4gPiBJU19FTkFCTEVEKENPTkZJR19EUk1fWEVfS1VOSVRfVEVT
VCkNCj4gPiAgCWlmICh0ZXN0KQ0KPiA+ICAJCWF0dGFjaF9vcHMgPSB0ZXN0LT5hdHRhY2hfb3Bz
Ow0KPiA+ICAjZW5kaWYNCj4gPg0KPiA+IC0JYXR0YWNoID0gZG1hX2J1Zl9keW5hbWljX2F0dGFj
aChkbWFfYnVmLCBkZXYtPmRldiwgYXR0YWNoX29wcywgb2JqKTsNCj4gPiArCS8qDQo+ID4gKwkg
KiB4ZV9kbWFfYnVmX2NyZWF0ZV9vYmooKSBjcmVhdGVzIGEgdHRtX2JvX3R5cGVfc2cgQk8gd2hv
c2UgcmVzdg0KPiBwb2ludHMNCj4gPiArCSAqIGF0IGRtYV9idWYtPnJlc3YuIERvIG5vdCBjcmVh
dGUgdGhhdCBCTyB1bnRpbCBhdHRhY2ggc3VjY2VlZHM7DQo+ID4gKwkgKiBvdGhlcndpc2UgYW4g
YXR0YWNoIGZhaWx1cmUgY2FuIGxlYXZlIGRlbGF5ZWRfZGVsZXRlIHdpdGggYSBzdGFsZQ0KPiA+
ICsJICogZXhwb3J0ZXIgcmVzdi4gQXR0YWNoIHdpdGggTlVMTCBpbXBvcnRlcl9wcml2IGZpcnN0
OyBtb3ZlX25vdGlmeQ0KPiA+ICsJICogc2tpcHMgaW5jb21wbGV0ZSBhdHRhY2htZW50cy4NCj4g
PiArCSAqLw0KPiA+ICsJYXR0YWNoID0gZG1hX2J1Zl9keW5hbWljX2F0dGFjaChkbWFfYnVmLCBk
ZXYtPmRldiwgYXR0YWNoX29wcywNCj4gPiArTlVMTCk7DQo+ID4gIAlpZiAoSVNfRVJSKGF0dGFj
aCkpIHsNCj4gPiAtCQl4ZV9ib19wdXQoZ2VtX3RvX3hlX2JvKG9iaikpOw0KPiA+ICAJCXJldHVy
biBFUlJfQ0FTVChhdHRhY2gpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gKwlvYmogPSB4ZV9kbWFfYnVm
X2NyZWF0ZV9vYmooZGV2LCBkbWFfYnVmKTsNCj4gPiArCWlmIChJU19FUlIob2JqKSkgew0KPiA+
ICsJCWRtYV9idWZfZGV0YWNoKGRtYV9idWYsIGF0dGFjaCk7DQo+ID4gKwkJcmV0dXJuIG9iajsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gIAlnZXRfZG1hX2J1ZihkbWFfYnVmKTsNCj4gPiAgCW9iai0+
aW1wb3J0X2F0dGFjaCA9IGF0dGFjaDsNCj4gPiArCVdSSVRFX09OQ0UoYXR0YWNoLT5pbXBvcnRl
cl9wcml2LCBvYmopOw0KPiANCj4gVGhlIGF0dGFjaG1lbnQgKm11c3QqIGJlIGZ1bGx5IGluaXRp
YWxpemVkIGJ5IGRtYV9idWZfZHluYW1pY19hdHRhY2goKSBiZWZvcmUNCj4gaXQgYmVjb21lcyB2
aXNpYmxlIGluIHRoZSBhdHRhY2htZW50IGxpc3QgYW5kIHRoZSBXUklURV9PTkNFKCkgaGVyZSBp
cyBub3QgZXZlbg0KPiByZW1vdGVseSB0aGUgY29ycmVjdCBtZW1vcnkgYmFycmllciB0byBkbyB0
aGlzLg0KPiANCj4gVGhpcyBpcyBqdXN0IGFza2luZyBmb3IgYSByYWNlIGNvbmRpdGlvbiB3aGlj
aCBnaXZpbmcgdGhlIHByaXZhdGUgZGF0YSBhcyBwYXJhbWV0ZXINCj4gaXMgaW50ZW5kZWQgdG8g
cHJldmVudC4NCj4gDQo+IFNvIGFzIERNQS1idWYgbWFpbnRhaW5lciBJIGhhdmUgdG8gcmVqZWN0
IHRoYXQgYXMgaW5jb3JyZWN0IHVzZSBvZiB0aGUgQVBJLg0KPiANCj4gUmVnYXJkcywNCj4gQ2hy
aXN0aWFuLg0KPiANCg0KVGhhbmsgeW91LCBDaHJpc3RpYW4uIEkgc2VlIHRoZSBpc3N1ZSBub3cu
DQoNCllvdSdyZSByaWdodCwgaW1wb3J0ZXJfcHJpdiBtdXN0IGJlIHZhbGlkIHdoZW4gZG1hX2J1
Zl9keW5hbWljX2F0dGFjaCgpDQpwdWJsaXNoZXMgdGhlIGF0dGFjaG1lbnQsIHNvIEknbGwgZHJv
cCB0aGlzIHhlLXNpZGUgcmUtb3JkZXJpbmcgYXBwcm9hY2guDQoNCkknbGwgcmV2aXNpdCB0aGUg
VFRNLXNpZGUgYXBwcm9hY2ggZm9yIGZhaWxlZCBzZyBpbXBvcnRzIChpbXBvcnRfYXR0YWNoID09
IE5VTEwpLCB3aGlsZSBrZWVwaW5nIHN1Y2Nlc3NmdWwgaW1wb3J0cyB1bmNoYW5nZWQsIGFuZA0K
bWFrZSBzdXJlIHRoZSBleHBvcnRlci9yZXN2IGxpZmV0aW1lIGR1cmluZyBpbmRpdmlkdWFsaXph
dGlvbiBpcyBjb3ZlcmVkLg0KDQpSZWdhcmRzLA0KTml0aW4NCg0KPiA+ICsNCj4gPiAgCXJldHVy
biBvYmo7DQo+ID4gIH0NCj4gPg0KDQo=
