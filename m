Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888C378D93;
	Thu,  3 Sep 2026 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469476; cv=fail; b=T17cyqG//r1VNUJQvna6cfqhwlnPoGXkdT/vTnxVpC7SL4OVda+RD8q45VXU/wyb5lsZRM5oeGbzpvDa3063DRJC9wwZXAmc4hErR1ZpXl9D3Mri40fI8CwEJZ3VnLSJi22qRJSK6NKbWqnc1YJf+pLnMGf0MCJs2VTZRFIrCw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469476; c=relaxed/simple;
	bh=2EELXHOi12sG8UfBM/fFxCr/rAU5Keg8EmpZ2/wl49g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LuF4HEeOMO+IpISwUB/isvYubljkel/7OMeeEEwNZGr5ELg6gC1AEztK8pb33AK05xSP4o04XSQ74MO8bDIAGqsxikRzmpQIGcBZREOBp/+HXyDlnAhA4/0ZUuQGPgKqRLMOjgMvCc6fZPDRYheXvpeE0vhKQ+1G5uJHEHWGelc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNScuQsM; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNScuQsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788469474; x=1820005474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2EELXHOi12sG8UfBM/fFxCr/rAU5Keg8EmpZ2/wl49g=;
  b=TNScuQsMpXsOB9pWULNxDLIivQVnTw+s+wo9JQQorZPDMEPyGaWoRA4J
   HyUyNDxMO95IM7B5BOCBVY6S+ZNiJDuGvxzGWIjV+H1BDQL/NzbqkZGz6
   uIEIPlso3w/iJmFoWDxEOMVFVgkIlfZH40t+4xRbbifjH7IiAE3IKHW3X
   eIcfrPQ1h6SszYtB5DyqUPnbLEdtqNsl1f0hJe9Kusber21CqetzIWetk
   f5/YSijC1YezIJqOe8M8A1bTPvccJn9v9h8ZdFL1eOpt8Oj9T5qL10OcG
   o8pO0JSkorTpOpTRT4NmydnoT9XQsM1acr7uCUulThWTyxS38+jpofVrs
   g==;
X-CSE-ConnectionGUID: fIoei6HDToq2Jugouxd1iw==
X-CSE-MsgGUID: ZzVIRMxvS3GRYEEGPGCIuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76520757"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="76520757"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:04:32 -0700
X-CSE-ConnectionGUID: eHurqparQwmk73CFBdc6Rg==
X-CSE-MsgGUID: jkItDA0ZQ7G+sLqzHBeNiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294707337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:04:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 14:04:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 14:04:31 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 14:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhGOdhvwK1whtxF+Rq1yC3sfC0XFA4nZIOzBXVrDCKH5XxrDOcbWXAALUvxBNlA+8tC1l0aH66iXBPuIuzCwdz2PKpYo0BE6TEpMtbTyb57aILxr0t8YH3+kfPmKXTUuDm+xQObIe2kvDpt+RLFZz1YsZaaWa/3FMC9ebaAztXsWBnuTonUNq6dTbZmcUG4XN32XrKsbpRO76L60/0sL7kGCVx2ju5Jfcq5SPD4qei8x/mU2tZun20fBODmZRjmMKJOp1H+9FKFrH0uGNKKhgipnrP7iM43B+fC6S1MBt4u74bQlZT5CPS7rC4CztKWga++35HNTEFb5yo8qi7tkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh4svpHZlb6ODgSBqtA1ng8YnJoR6nR3Zn7xHpa0Nuk=;
 b=pujVTWrDJnG5Eu9T0X4pZDLjHaMfbTT8xE3YnwWLHAlUWXRYPQyvNrfIOYYpl7iTon4O0aUgGAnXYKXcWx9Bw4+E02gcBiQsSn6njM5uhS7bcdpKVEezQfv6wzBhRBKnBSKIlPhP6I+zB1Lpqq6ZCEgwI8ZF+XPIRuoptt2Z74dNZcqey3NbfK5AToewCXZBpeQ6IyW6qsSP3Dtm2mp3tTaqyZXUK4HIltq4hd2txSka2a6hfSlxpHmz9o5pP6jPK2tOeOtJw9TdRuOt2jgu0BMDpX0iVbXUiM6KfqoKpBh/KW+GBkV4lkjeYTAOfYjBq4Urx92hm0ZvLlV0mGzG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DSWPR11MB9821.namprd11.prod.outlook.com (2603:10b6:8:4e1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 21:04:30 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:04:29 +0000
Message-ID: <96ca6bc4-a03a-4e4e-b82c-f5202cdf21ac@intel.com>
Date: Thu, 3 Sep 2026 14:04:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] x86/microcode/intel: Reject problematic loading on
 GNR systems
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<andrew.cooper3@citrix.com>, <arjan.van.de.ven@intel.com>,
	<stable@vger.kernel.org>
References: <20260901231634.714144-1-chang.seok.bae@intel.com>
 <20260901231634.714144-2-chang.seok.bae@intel.com>
 <20260903015154.GMapjSujbkKGzyihVB@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260903015154.GMapjSujbkKGzyihVB@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DSWPR11MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fe747c-54bb-4f3b-a591-08df09fef205
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MPoikdqfKe4SO4DypCiM6ik5OPahp0HfmXHg0rL+1GW8pKxDyJzMB+fYwqhv0KXlNIhK56rAZXDMIVXtK9QARkmmHfUwVuYSiW/z3HEUhV6h5SMTdkF2QVq6/WyCAbA6xi/utg4AARVJ76igflsh+qNpIW7n57ukwW5m2mUFA9sZuhp2D4hbYEEsiWSTYCMiKu7mkvm4IrzFfCV/yH+qSIf76RE1hhaBMbkqD4AkH7Q1wy4+Nkj58KAUhKcyVF2HR/dckkLXkVOe+3N97ueg42a7UZkI2N/Tgz+vs9jfg9tNngFhNutGzn+i8K92GRnz9dCOvYmcXQ8baLrhgf1Kd+FdiHflT4mVCtrD99rIJy4n3Bq5HA/rY240smmXn9u9QALJGYZcL2qoAAh2MJppHbxwtYo7CaqqnVgwfq0Omr2iBUAru7F4bMhxlnyGXevDhr1dGzNnyBP04kcR611GV1b6lXpKE0W8tAVEMueon5NbunypuB1pklSa1UwnuskT1UJKeeF9Ym6jMW/+NEf+cReqgO2/vZElSh+AeItPWbWucaKj9dluiAXTeCIpz0V32/WCPoemzHEcQmRRY3XXn5rlYICdCmKSH0isus3DmFmZwRvAYOmxOaVZo2FJy/9OTuz4SKLTjCofJlC+zHggrYIAYV7DBCJlaqTs4xtiu6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhQdHE1eHFnWEo4NFJUcEgxME5RendrVWwzVm1yVzdkZHlIejRGUkt2cy9o?=
 =?utf-8?B?NTczaWxjTlZtSWVQNHdsWml0YUhYSHdNUWRxM2VSRE8ydTBBaDlrWEhjc0ND?=
 =?utf-8?B?SWg1eVlwTC9JMTRGOG5LRnpqWVNua3ZqRUVIQTVwVEdsNVBSdWE1Snoxd1d3?=
 =?utf-8?B?RkJmS3duVFd2Qk1ObHpJeHVoZWFPdXBlbkdaQWlETmZ4d3BmTlFNc0k1bi9n?=
 =?utf-8?B?dW9CbXNkMyt3bkxmSHlXMmROZWRFWnNXcCtxdXRTU3hMNjByRkFzMnZmK1RT?=
 =?utf-8?B?RGZQOGhhUVFqR2lJV29FT3BYUW1Qd284VVkxVjhBeC9oeitqMDVnWHlaT0p6?=
 =?utf-8?B?dVVQUlYwd2ppVVV6ekhlbzVwbDdKUU5DZFdNbUZlOCtWWlNLcW1WaWJqVEdh?=
 =?utf-8?B?ZXFMWXl4a3ZQbzhqL2F3WHBkd0J3d1k5ZzF6TnRvSUhsdUVJR1d6RDJIeExm?=
 =?utf-8?B?OHZNdmtUN3N3RWFuNVNVQmUvZVhrNmNGVVZXaXZvcFdkMm1UY2c3VTRueW5n?=
 =?utf-8?B?ZzAvNzhqRnRtYWM4NWF4UGptWDJSSFNldTg2WjRBS3ZJVUQ0dFF2ejRNSTNR?=
 =?utf-8?B?QkRIcUtWaTJ4UGFrUnJYRHpqclhOalYwTmcveFVFQmkxY0wrOWFxak5DNzFl?=
 =?utf-8?B?T0NUUUNHVmxVZ2ZLVHFJcHFnTklCaFN1QzFKbFBXQWFxOGlaMkp5NThoWlFw?=
 =?utf-8?B?U0FmWEowZTVwSC90ZnAzSWFVMjBwZTA5a0VCaEJUQVBwZ0Zac1N4T3lsMnZO?=
 =?utf-8?B?WHV6YkNGZUVwMzFCYzJrQWxkVUlZbTNCYy84V3pPZHFUY25hb016clZOcGpj?=
 =?utf-8?B?d3V6aFRJaFZEdXVtTEx4NHkrQ0sxbVB6ZmQzYUd0eE9tcWdKa1JITTY0UWhY?=
 =?utf-8?B?NmI1cUVjdzRxK0pMeXZoa01tc1RwMTdibXhMaGRDbUNJQXBjSlBuOXZaNnMr?=
 =?utf-8?B?M0RpSXI5WE53SG13QkNYbjVSSVJ5UGgxaE5nbzZORUhmWmVNSUtHd1Y0RTlv?=
 =?utf-8?B?TVZTeXRRMlJwSmNwZkxRY3RhbVUwWHJkYUs5YWhFVVpZdXdjaFZ5NURHN09W?=
 =?utf-8?B?K255cExuMXdhcTdvVmhLemVqQmxwMnJNV2pzd2NWOTdvWGp1Sk5TSW1JN2Rz?=
 =?utf-8?B?RStQaGE2elZwaWVZaFFhQWh6dGd4ZmNvdDlvMTNiekJXaGVpOGNLU1RqWGdt?=
 =?utf-8?B?SFZBSWx1RUlVTkFxQkZqYWxaWUpBZ2pzamxmbEwrMGVFbGY5ZVJocGZhVHJM?=
 =?utf-8?B?WDIzL0g1cjZzM2orcDRQcUtPK2NXZ1loL0d3OGVjU3lIaUNRQzgyR2FMRTY4?=
 =?utf-8?B?S2pjOTVhNnlHZG0zZFdlTlBqVVlWV3lMYXRJODFaOUZ3aGxtRGRranhCZUFn?=
 =?utf-8?B?VEd4K0N5N2pDa1IrbS9rZ1lsdTl2R1krRGhsQXZYdGM4Nm9yK252N0FzN3pn?=
 =?utf-8?B?bmlZNEN5YUZxSmpEeldBdGszdlNMSjlUVVZqTDBCcEVBRHlkVUxCMG5kNU52?=
 =?utf-8?B?blMwWVE3bVZrYm9jRUlDWUlTT1hPUkZKcWI5Tzg0blo0T3NsaENNS3RTT3pU?=
 =?utf-8?B?QkJwck9NU1R0R2RCVVEwL3lFbjNKaHVrbjZhaDZLL2IxYkZIV1c3bjlTMWk1?=
 =?utf-8?B?S2xQZGQvbFlRTEtReEdLUFRTM0Fub2lhL01aOHBCTFZsQkhPUWUzOW1ieWo2?=
 =?utf-8?B?NHE3S1ByeE9ST1JPeVR6eVhxVWV6OTVzTGdtWE1PcDVHT2ZDVGhwN2cvc1dN?=
 =?utf-8?B?UmNkOGM2VjlTUkdNTE5jWEVRdUt4WGh2UTR5ZVhkY1dpNlFQWVFPTWVqZVFs?=
 =?utf-8?B?QUtVSmhXY0x6RFhmOUo2S0ZnSW5WbTR4WDh6L0hweC91QkF6bE53c1FqZm5r?=
 =?utf-8?B?SHVZWXhXNTVZVGFhYWhIdHcydytQUzRDSFVBZzJVbU8xbDRVczlObHdRci96?=
 =?utf-8?B?Ly81VHFXeVRzN1JTbHhVb2VBK05Xa3d4ZVh1QVQ5Z2JwWlJEblEreWZPVVZ4?=
 =?utf-8?B?eHlRWis4SXFyRk9CcXRPK0c2ZnppN2VWSVVOeGw1OFB0amFEbVBESFRtZWVx?=
 =?utf-8?B?YlVHSDFuU0dSOXJidXRha3p4OGY2Q2VOT1FOc1ltUDdHbDFnS2lMUDdKRXh0?=
 =?utf-8?B?TXFjckpMTmtPbGdhSWVveFRTeHI0ck5IRkt2ZjhZWTlmWHBKZlJRQVB5cTRW?=
 =?utf-8?B?cElEQ1RpREhWdlpudW9nbnN5eVdjZm12NHBiY21WWXRmWW5lYjczbDVrTngw?=
 =?utf-8?B?c3VxTE1WUDN5R3ZuY1FPb1J0WEJ5WHdseHVoSzBsL0JLZVQzaFNxdktQMUNo?=
 =?utf-8?B?dExDa0hJeHdiYVcwcnhaNUVjbXh1QXh2WGlVSHV1SzZGSXFtREpWZz09?=
X-Exchange-RoutingPolicyChecked: kG4CslXdASwioUuQ8+FPe1i2tyARQPT4BSYcHOKjGnUZqpKjTWh5K2cStL2lx8U9GeOhvWgcjPw8maXfFmEHMPxH4Jeo6zP5ziENS5JRT4dE5zSdlXnWDar3gpbD1DzxQx9igDBSLa26Ar+BFAy6YlpzQM6myME4bdvMG0bthRdO3QhWYocwoE80XDw9JW9Oi68byt7AXu7Ldk/2g73GD47PAx2I3E5onxJQhZXEuRUEpWvxpEiOTbIifBiRJ+qJk3YBWQQeF0mY4uliOd0CoeuX88Whkk2uEp/ELG2kuAJVh5c+rJb/ESYgZ9r+gBNunHmoYVUEAcwNmRZfezJohA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fe747c-54bb-4f3b-a591-08df09fef205
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:04:29.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: petdxpNdTVWSJXwT+SMaRMEHCAX8hb0d/L2TC6gYBmIxLmu0CE1Uirg2JzD6qvIaPeNATWQ/Zl9yh2SZgHnSvewxpOhouF7WyPi9tENcrkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9821
X-OriginatorOrg: intel.com

On 9/2/2026 6:51 PM, Borislav Petkov wrote:
> On Tue, Sep 01, 2026 at 11:16:26PM +0000, Chang S. Bae wrote:
>> +static bool is_loading_denied(struct cpu_signature *sig, u32 rev)
> 
> This naming is not better, sorry.
> 
> Is loading denied means the loading in general is denied because <raisin> or
> are you trying to check whether this particular revision should not be loaded?
> 
> I think it is latter.
> 
> So you wanna say
> 
> 	revision_blacklisted()
> 
> or so.

Maybe revision_banned()?

> 
>> +{
>> +	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
>> +
>> +	/*
>> +	 * Revision 0x1000405 contains prerequisite changes for subsequent
>> +	 * microcode updates on Granite Rapids systems. Updates directly from
>> +	 * an older revision to this or a newer one can result in #MC (GNR98).
>> +	 *
>> +	 * This dependency can be indicated from the minimum revision field.
>> +	 * However, revision 0x1000423 has an incorrect minimum revision in its
> 
> So you lost me here: 0x1000423 is not tested anywhere - just mentioned here.
> 
> So what I understand is: usually, dependencies like that can be expressed with
> minrev but *in addition* to the current issue, patch 0x1000423 has minrev
> wrong so that dependency cannot be upheld there either.
> 
> But then why even mention it if you're not going to test it?
> 
> Why do we care about GNR101 at all?
> 

My original intention was to explain why rejection is need for the late 
loading path. There is a minrev check, but broken with that case.

But to preserve the legacy behavior, the minrev check isn't enforced by 
default. So what's the point of mentioning? Yes, if we need to ban 
particular revisions, we need to do it everywhere.

So mentioning minrev is just distracting readers as long as rejection is 
based on revision number in the first place. Let me remove minrev 
wording from this patch.

>> +	 * header (GNR101).
>> +	 *
>> +	 * Prevent loading 0x1000405 or later unless the CPU has already been
>> +	 * updated to 0x1000405 or later.
>> +	 */
>> +	if (vfm == INTEL_GRANITERAPIDS_X &&
>> +	    x86_stepping(sig->sig) == 1 &&
>> +	    sig->pf & 0x95 &&
>> +	    sig->rev < 0x1000405 &&
>> +	    rev >= 0x1000405) {
> 
> You don't really need to test rev here - it is enough that sig->rev is
> < 0x1000405 - that already makes you susceptible and then you can check rev
> inside the { }.

Yeah, I'd like to simplify like that, though. Intel repository looks to 
have three published revisions before 0x1000405. So there can be a valid 
update between those revisions.

So still need to allow:
   old_rev < 0x1000405 -> new_rev < 0x1000405

while rejecting:
   old_rev < 0x1000405 -> new_rev >= 0x1000405

> 
>> +		if (rev == 0x1000405)
>> +			pr_err_once("Erratum GNR98: 0x1000405 is not loadable.\n");
>> +		else
>> +			pr_err_once("Erratum GNR98: 0x1000405 is required before 0x%x.\n", rev);
>> +		pr_err_once("Please update the system BIOS or firmware.\n");
> 
> This is useless most of the time because client won't usually get BIOS
> updates. You can tell people they should update their microcode packages
> instead. That's where we can really help.
> 

I see.

I think anyone seeing this message has probably already tried updating 
microcode. With `GNR98` in the message, they would still need to decode 
it by looking up the erratum and its workaround if want to follow up on it:

   Workaround: None identified. Software should avoid updating MCU
   versions earlier than 0x1000405 to 0x1000405 or later until the system
   is Firmware Interface Table (FIT) loaded with UEFI FW/BIOS to
   0x1000405 or later.

Then there isn't much point of the additional message, I suppose. I'll 
remove it.

>>   
>> -	if (is_blacklisted(cpu))
>> +	if (is_late_loading_denied(cpu))
> 
> Aaaah, you wanna be politically correct and can't use "blacklisted" anymore.
> 
> Well, you're not introducing new usage so you don't have to touch old usage.
> And "is denied" does not express the situation properly. Try a better one.
Okay. I'll leave the existing "is_blacklisted(cpu)" as it-is since it 
already exists and probably descriptive enough. Also assuming it will 
remain distinctive from the new one, e.g. revision_banned(...).

Thanks,
Chang
