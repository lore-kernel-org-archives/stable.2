Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0D426D0B;
	Tue, 11 Aug 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441046; cv=fail; b=t40Mn4nwYCPfhkrTY96Fjf9C7wb5FtegGt9oOZTa5bAXGdDaIu3vstH8lXYhxzcX4hJEkW4At7KGOf4hc0qUgmK5+8T+qRc06me+JXJXq3vESmCdIt0wz6M63NNVaB9HFE8w3AX8dhXDvZPSkjMQ3BJVEJePfZFiyn2Yrj7wE5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441046; c=relaxed/simple;
	bh=/JHob7mTj8P5AQEEsyhZqmnaLO0ZkgO1Aezl7IMujrU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sclSBU1LhU8xMnBqeXmKebIf1Xb+zGdcGdUUC//P1vbLWwMHxvqDaqbNOlqrZ5QBcdOLzpYfGeN3VJe66zGkeEXf4Ra1j+2EVwk/r/Gu0OR5dJRsiSiiOcI9hvaYdgyRw1uAuJTAy9BmLnr1AmD6tOtkFCVv2oYGSWjC7wKeNmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb0T4gOk; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb0T4gOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786441045; x=1817977045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/JHob7mTj8P5AQEEsyhZqmnaLO0ZkgO1Aezl7IMujrU=;
  b=Lb0T4gOka+OKJcLmdDxykyToo2BlbjZH2BdDpOqPPvD+fCyAoPYCAAx1
   XVSDRlf0q9Ufc5uu9USvbOuuO70L79JEOAVJq5cIchK4fK9uQ5gUUXDw5
   1iZXGJ4+BP166RveAvar2CewsroGv5hs7ZqWudS2I3ptCZRwnG6x+1HJJ
   52GW7TuwftrwNkEL1u95F2m6kjX+mbLAzIVid/BKo3ge4uHxr8oHhvzmj
   pIteStTvGL9cYbEr1d8aboEElzO+14eIZyIIPNEkFXx9U2P0Dw1qMK6X3
   5EjBfCBdqencj+tbOlvxMWNU3+xD6F0FLH+y8weNXTt3Y2IcMA0VMEgs0
   A==;
X-CSE-ConnectionGUID: RU6V5EnRT0iF0PRRUZkDIg==
X-CSE-MsgGUID: awzKyXSRStOOJXbmmddZzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86993075"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86993075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:37:24 -0700
X-CSE-ConnectionGUID: Q4buEpHrRBaq4oN1eHITew==
X-CSE-MsgGUID: X/CtitlRT2K05ysxcUJoWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="263338973"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:37:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:37:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 02:37:23 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTqWTU3JPqKUACjU4ku6/OTosgWOwmn18nTTR0zUSXCQ7G4SSLuRXCeJ3afkchiNWgZ322Jfktiu+I6odSyPFVdnNOW6eTjO8muLbcsx9tGOaunqycM+kmQHlNAfqcN2r26vyoOhITEitpTRY53ja45/0wlnov4oz5Nqw7/lUOMUNfp8M020VMv5SAk8/JzneHL6jmLglFFAzvN8ZbMQeD/iL5Qv7pVviS2+zoAfjtIXkbbI5fEPdX713vCMxVpOrL4o3LxIApYwPAcd0lLb1H1JgW6ied50BGlyZoGX0BNpaxdpI8AQqm3CPh5YH1vZxAhqTNH5tJhW8p9xAw//+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK4FT2Th+zQ7RmK4WKk2wQl1eggXehClzx4S1hfCOqI=;
 b=vQJUa9AhxQtBMR/4fvE3dDrZ+mhdqTwofRzYNH8fIPoQGEwoKf9HAKbAFc0QIpoFBZaENTRO32qR6TGJretrcCDDKIPIFNVajXxbfiS3xmC/Es8adPCFH08ZPJitaAcBGmX1+rAGFkj64sBtOhiHLEIBz1uBBXNozo6zKyynzEGSCAMGd6x/+ZjHhaJK4w202x4Qb2X5hoBqVkdnay4+BlBVEMBgfoqPcV6/RsDavQwbafmiBfeENNMed+akpKinhyJ2/MLgLnJ0x+99S6yRqqqsNK/C8Z+qC+Tf7LtMlpZobt69Jo/n3vmyDZiSIsES4a/5rBGEY00DVDvCck4Qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by IA3PR11MB155912.namprd11.prod.outlook.com (2603:10b6:208:549::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 09:37:17 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 09:37:17 +0000
Date: Tue, 11 Aug 2026 09:37:06 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <jani.nikula@linux.intel.com>,
	<joonas.lahtinen@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<tursulin@ursulin.net>, <chris@chris-wilson.co.uk>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/gem: Fix request use-after-free in
 active_engine()
Message-ID: <zmincd7ubpkwasily6fegvx7mz6zkdw5oglbj3ynpgqovpkszh@un7lyxy6dgly>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260809173646.3292361-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260809173646.3292361-1-shuangpeng.kernel@gmail.com>
X-ClientProxiedBy: DUZPR01CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::16) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|IA3PR11MB155912:EE_
X-MS-Office365-Filtering-Correlation-Id: f877f1e6-2f4c-44d8-63c0-08def78c21d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: Sud7CNOM+Z2Cxs677dc1GvizBVhc2C4GMJ33Pw3jQeI+kYwBpXWg7YmelrFbDs9x1If6OSugqyXdtG6ukwaUqDg+s8jwNuzsY7N6wixaJDQGEXgU3GOTKzNCo+n7fomnhDatc+DJY24VvPOHjB6NDqqe5wZOhmz+iQP06VKv13mGFXWA738J/CHJ/hcLMpvlVbYjQ0/NFrB2dhOimcuslaTR6td3Iz7l+W+9IX+akRqpydYOdUBV1Ra6wD3R/BcOtWwQyW86xfPwNtPLGfx/rsNRkiJki95RsjDH659dYDy4re639e0aWay4SqmQDkoQRPbDY5tttX0atgYQ5+WJaHDMCevJGvwMcgLN+x48U4x1+9fAl2Z8f+wV2F191pK3jBy4d/72TmYdmqMlvIM9P83NJZJTsvckvVvU706OJmPvT+YCbyIM/2QT5GZ04CHAXPqqT78tnli0S4hV7ieteOXMvBD2El5Kd/j+uSHF2m5Pcsa8NYrVzDHI02FTfJM6SpBnxnzc8GGr+EJOXVsC6kmKsswSf6Z44UdLZUYWqU4g0uGDoPqjt1j70GPaZB2ooTqpXmCqrs5n955ghjEMAUtCckymPDTQD7Ndv+UOKBycJQ3Vys9Bv+0XkskPUnwHnm7aQoTu78zRuuvtmh9MKbbrxlQ0Z1c1bDrZwX/Ssq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERZZGxmYkphaFVzaTdVL29ocXZaMVJCRjB4enlLSWkwN25wTjhpM0J1NVBU?=
 =?utf-8?B?L2dKWkJvNzh4MTBxRmVXbkZJQzlIRmNmUW5yLzQrdFJFSnZXUGF6VEQxblNJ?=
 =?utf-8?B?VmpSVE5BUmpnNmloR21kV1hTWVdlaVMxeHN0Y1hBWVVldkx5R2V0TFlkZXh2?=
 =?utf-8?B?T0dtYmFiL0lWeEpuTUpnUUQ5RmsvelZkNlllVjlIbEQwd2thd1VxcWUwT05s?=
 =?utf-8?B?YTBvS3h4dVU5S3d0WEhHK1R1eU1HM1FQdHcrZHNXYkIxVHY1SkR1L21nTytO?=
 =?utf-8?B?WnZ3TzRFeHBhaUFnWFNic09CSFloK2FuZGpKaDZyb3V4a0Jjc3QxNkI0RXpZ?=
 =?utf-8?B?OVpiOCtpSXA0SjNzaG1MaEpBQ3N3WTJMSVd0SW13NXBrVEhLdWE2dCt3cHRP?=
 =?utf-8?B?am1HdTMvUkc0U2lBVlQvS0xHZyt5dURjNnE2eVAxZnFWRHlXb2REVnFlOWRG?=
 =?utf-8?B?SmQ1K3dyWkRzMCtRdjFSUjVxZ21aeDYwZk9MaUpRRTJ6M1E4UWRmQzNlQ1g4?=
 =?utf-8?B?OVFiRTNtK2syNzR5aWt1eDVVZ2NTRzk5OFVxRkxLNExpU1IxZzdsY3BVRHRh?=
 =?utf-8?B?SnYvTnF4Q2FsQnBHelYrckhrT1EzQzRHOCt3cmkyT3htV3p4VjYyTzRsZTF5?=
 =?utf-8?B?OWhNMzZQaEhKd1FxdkljU2xibThQdzlqMXlBZURLQVU0NExqZ0Y1M08wcXJL?=
 =?utf-8?B?L3dRRkY1Uzd2SkJzemYvTzFPNTd3eFNlMHd6TnhKS291b2lBRVNJMlF2cEk0?=
 =?utf-8?B?TUR4UjlLSFJPQUNUS3NoQ1FPNkJPbUhRaURPR1I4VytiSVJyK0NGSzN3Smkx?=
 =?utf-8?B?NXlvWFZHWm56a0o0OG85Mms4cDFmMURWcFdCcFNJYW1mdWNBdE5rWFVuSTJR?=
 =?utf-8?B?RlNQekhFSHoreUw5YU42N1MxbVNqWGxrNmtCNUZtUVVQekJiZlJhYzdEMjIv?=
 =?utf-8?B?aG1BeFFIczVZVU16eHBEeDl6SUd3eEd6MDZlVjNBbXd4b0FPN2dFMHBzOUk0?=
 =?utf-8?B?MEtsL2F4cjEyZDVwMXNsMWlaL3RCb05oRGxLa0ZyYW5oa1NlcHNnZEIybURj?=
 =?utf-8?B?ZEU1c0NEaVl0c1piSVZXM2VxWlp0N1I2MGhraGJ0eDFua1lwenN3SFJ5VHBC?=
 =?utf-8?B?NFluZysveEx4dzhRQzA3SHk1NlpMSVZMWGsySFhCYUtZajdYSTh3QnBKeXRI?=
 =?utf-8?B?VXlHTXZIU0VBRTExaUhidnhJS1kzRjBKTi9zei9QOHBNQk5qK1BEQTdBUWsx?=
 =?utf-8?B?bmwxWnJKZDZheUFwZEc0Y3pOczl1US96c0JKSjc1QTRHSG95dEFudGVTT2xx?=
 =?utf-8?B?dGNwOUtHdzNFVzNDTjdxalhBRGJxaHk3ZDBDS3NwNGtKbzJvTStoTXM4Nk1q?=
 =?utf-8?B?V0xyYmZiVExYcG9uNXNrMXZrUlNBMVJhREVHRnQvT2gyOVc4eEJvd2NPRjJp?=
 =?utf-8?B?WExmbXdxclpybmhsWnFSZ1RiRkZnOHVmKzAyMCtteDRhWHlwakdyV1BiMmV1?=
 =?utf-8?B?bWtFNm1lV0VhRzlMTmVQdG9EVU9RMkxQZkVrN1pROXRsVlNqOS9PanZzeWx4?=
 =?utf-8?B?NEVpZk9SRk9MVWpSMnZVYm9sb2NxUm9jeExuVjVyazNxRGRSME91MUFIQ3Na?=
 =?utf-8?B?bWsrQWJpY04wNjF4cXhpVnJEWjk0RUZQSE10SVZGTHBvdWpOR0dqM0J5cFRH?=
 =?utf-8?B?Q1hHZ3BTc2ZqVnQ2L3lBcUFPSWdEWkt2SU1LT1h5VS8yYXpLVFZRSTBsVWxJ?=
 =?utf-8?B?eGVwWmhxVXFXOE8vKzJwdHNIVGFjK0YrWmpLbTJTdHNQUVVnQ0tBOHRuUDZV?=
 =?utf-8?B?b1huVnRXTkt5MHFBS3U2WlNZWExkVlFOYjBjcjEyblIxNkY2U284YnAraWNq?=
 =?utf-8?B?WjkwWGt5cjBwZU9YQ2t4TVc4eVYxRzN2VGMvMnkzZG5ZNmFXUjNhcXd6d0JW?=
 =?utf-8?B?N1JJUkVnM2hVZWE5RlcxNHk5NUlhZ3ZCMjdMWDFDeTJkdFBxVmg4NGgvZXdy?=
 =?utf-8?B?THd5OS9PNDYvR0dpU3JzRWhySjAyZmMvcjA4T2JyVEU1dzRlSDBVVlJhU01z?=
 =?utf-8?B?OFZoTnpLWDhpS0RjRFZqN2NUWlZqWmMwVjUzc082TVlRcG9Qb0pFVGhiaWhj?=
 =?utf-8?B?Vko1elYyZzN2UVRuS1pYQkxHcnBpOVpOZExqTmI5ejlJYjRpZ09Vb0gwbE9n?=
 =?utf-8?B?TUtETGw3cDlIcnkrdEUxRC9yYmJpRjZQTFpCcWUwaEsvS2J5RTRuM1F3Y0ho?=
 =?utf-8?B?NFRrSW5jcFFtQWpkQ2I3T1QrTG5nRlpDNjMyZUhHQ1dpOEJoQ29Bek93V0li?=
 =?utf-8?B?ME1NRUw5aUZ4TGptUzlycUR1Y1lPR0F3Nk0zdDRBM2JOcndncDc4TEtaL2I4?=
 =?utf-8?Q?BKcGWsEotXEAzbp0=3D?=
X-Exchange-RoutingPolicyChecked: lkUTtKO8W3lnvtFCKqNiajJoXvnONXeoziRrG4slrMxuHcPJhTG72AzhI/vF/b1XALK8dkC8TQzy7HQO4aro0LMCZrUdCWeyAlJfklL9jDmfCxS8ITjzIHR3KAXfcvScH36ap1c49nF8+ETm44V6Sww9OLt7M01FoyCmI5HiM4hKdlFIG9Et4Vumdh2xtaknpWYVUDdjUpywcdi5mNy/avaY1TqFHcnVg/tVJExgmZRlBH8XcWV7F7EJPrxdm/YotugJd2emy18cegwKINdpUkyYPMubvRKByvzoPUPJVRoj/DQHz9t0pINjU2jyZKjMB6u5jVpPczmiSu2WhrPtXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f877f1e6-2f4c-44d8-63c0-08def78c21d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 09:37:16.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxaWBLnFdzDWgYl9dYx/U2R9ekBNDQ6izmsF4JCQhGPsmzMyP4YJWheAET8UZR/QsQZufJQidN5nuxiWs7ldCHDghG3rdGPzmXiXUHnXGxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB155912
X-OriginatorOrg: intel.com

Hi Shuangpeng,

On 2026-08-09 at 13:36:46 -0400, Shuangpeng Bai wrote:
> active_engine() walks timeline->requests in reverse under RCU and takes a
> temporary reference before inspecting each request. However, it drops that
> reference in the loop body before list_for_each_entry_reverse() advances
> the cursor.
> 
> Concurrent retirement can unlink the same request and drop its base
> reference while active_engine() holds the temporary reference. The put in
> active_engine() may then be final, freeing or recycling the request before
> the loop step reads rq->link.prev. SLAB_TYPESAFE_BY_RCU does not defer that
> reuse.
> 
> Open-code the reverse walk and cache the previous request while the current
> request is still referenced. The next request remains protected by
> i915_request_get_rcu() and validated against the timeline before use.
> 
> An i915 mock selftest forced retirement between the active check and cursor
> advance. The vulnerable tree reached the final request release and
> kmem_cache_free(), while the fixed tree completed the same ordering without
> accessing rq after the put.
What mock selftest are you referring to?

> 
> Fixes: 3cfea8c97c93 ("drm/i915/gem: Hold request reference for canceling an active context")
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index c58ffa5a8fa6..ff5c892a0176 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -1361,7 +1361,7 @@ static bool __cancel_engine(struct intel_engine_cs *engine)
>  static struct intel_engine_cs *active_engine(struct intel_context *ce)
>  {
>  	struct intel_engine_cs *engine = NULL;
> -	struct i915_request *rq;
> +	struct i915_request *rq, *prev;
>  
>  	if (intel_context_has_inflight(ce))
>  		return intel_context_inflight(ce);
> @@ -1375,7 +1375,8 @@ static struct intel_engine_cs *active_engine(struct intel_context *ce)
>  	 * (and onto a new timeline->requests list).
>  	 */
>  	rcu_read_lock();
> -	list_for_each_entry_reverse(rq, &ce->timeline->requests, link) {
> +	rq = list_last_entry(&ce->timeline->requests, typeof(*rq), link);
> +	while (!list_entry_is_head(rq, &ce->timeline->requests, link)) {
>  		bool found;
>  
>  		/* timeline is already completed upto this point? */
> @@ -1387,9 +1388,14 @@ static struct intel_engine_cs *active_engine(struct intel_context *ce)
>  		if (likely(rcu_access_pointer(rq->timeline) == ce->timeline))
>  			found = i915_request_active_engine(rq, &engine);
>  
> +		/* Cache the cursor before the put, which may release rq. */
> +		if (!found)
You could skip this check here and unconditionally set "prev".
Its value is going to be used only once if found == false anyway.

> +			prev = list_prev_entry(rq, link);
>  		i915_request_put(rq);
>  		if (found)
>  			break;
> +
> +		rq = prev;
>  	}
>  	rcu_read_unlock();
>  
> 
> base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
> -- 
> 2.43.0
> 

-- 
Best Regards,
Krzysztof
