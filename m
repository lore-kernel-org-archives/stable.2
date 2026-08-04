Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCBC455188
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854417; cv=fail; b=NcuKRSDlHiP9Vu84wsjJTPAMa1QlCDDVyBjtwT0hcj8hPTczEuSKRUiKwmKUdvWuCOnu7L75FP+mOPkQfEwIUW3Un7YSYH8EDuYjZDU9PCvFEP3CuwNwTX4fhrDDDG/uAoeYdu+SfPFwFymRZYnThZOeA89gFCLybPR1wuYG0Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854417; c=relaxed/simple;
	bh=qqpnzjiR47oyfND0PKcn9PjQ57wtpyS7Um9uEJN6Qho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PBq/ymEhWbaC6S4LUiT+TNbIrHhhzwb+KvwGAPYfyXQ4ONUC02bpSki7nfZVkihEM4C05WypmyZdM3WMdkWz4FuQWEsCN3mcJwO1OtzI5Oa9y78QcRReqz18g1viNLcn5bt615iOBuorSn0XlDTpAjUDBGczz6lIY3TINU9hJvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtkmmV+4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtkmmV+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785854415; x=1817390415;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qqpnzjiR47oyfND0PKcn9PjQ57wtpyS7Um9uEJN6Qho=;
  b=gtkmmV+47XWCovzxkTOJgootDmxTzE8BBJDB88lgORN7JRXdU9rnQjht
   5zP5DB9xwYo77UJPP4o1CmXOLGV7F5IknsgQ29zUseXD3qao1I/zEY3EM
   iZB9WEHDq/HdrjVBRhST7hK40hx1ZVuA3FAovotCAP2zp8e9ae0F5Iqal
   50XDUgb3Cp2Glfr97m5rLXnPD4LpxiJn5jPVesKgjrIhNB4kMPiTn2OKT
   YIGkXiTinyfFNHIGLWwfPL+7Du3XjnD+vkkXwyhFhOjOOj4XcbCWQ5pTg
   fxpmp9xx7oQeQ4haQewIhwit4S/V7DGhAY3Y199nP1/J39dVpsL+2WebA
   w==;
X-CSE-ConnectionGUID: OiTBu11kQPaKQJOk1T+pWw==
X-CSE-MsgGUID: yCbLID9xR6WlFeOqzRc37Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88933720"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="88933720"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 07:40:14 -0700
X-CSE-ConnectionGUID: d4ESGOAoRT+u3gz80ufjoA==
X-CSE-MsgGUID: xe0TcAKqR6WldnheFT1r6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="258858514"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 07:39:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 07:39:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 07:39:20 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.59)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 07:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yn9FYO9Magcwo99mtZJARyHVG3jF+7tLtk9Tuy5JZvw0+gdveTIzJVeIDwYnvUb+23iLDcINSdzQzRoFVyEtEn0fTi+UdEZP/bIJdBisri7V3c79VbUkdZ78pzAIdi2a362RvHq+AS0O5L0fJ9ZUIJJUZEet42E3D7jwYo+e6hXLW12ucBzcFCXVOL/oDXmjSSO081YV7iDGfYDAX+d8DAb86OP2SJp/LI5ZH2QApKLusLF0hjwdcoHNWveiekp1Onsj9AgKvBEEa16YQl9LuyAqjLELNf23kNBq62qJ+M+oV5y9x5b/FmYkCzCOBpXINHlHnhbYGcmN6C9BPYhAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxBCDxBqJZM5ymMbwcRMHsK20LG6XXOQLtuwz8TelJk=;
 b=mJ8SuZXSlcP/OOi+YBmUqT8feTOrZBk8HtYjq0D/hmHesg0btHPHmqJZhmuhOl/lwPGd6jyYmi6/ckrAIfzutR+CfgPfb9FWSTJbXh/sIN0aIPdPSj23MGX4uJ2jchlfWZ3+zDtDaUf5Tfgflm6S0+/I4nUzmwQZnPUgw/xktWnyeMf7jBYucm29Uj1/l5B52SAeZ2mSHBYHVWQRzAuBo9zNjSC/nE3HWRYPkgHTU59qaaUZyA0SYyPrMaNghRd9lQ9x0SUke6iU2dHlM8fiwrpRMG55/1sS/Kg2zjYmNKid1L/tcDQnKqWj1OVPUsiCVLrSkiB7PiI+BO3bjGDLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by PH3PPF25FF87461.namprd11.prod.outlook.com (2603:10b6:518:1::d10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:39:12 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 14:39:12 +0000
Message-ID: <e4364662-18f8-48eb-9224-d73d64ebe6df@intel.com>
Date: Tue, 4 Aug 2026 20:09:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/i915/3dlut: disable 3D LUT for pre-GLK
To: =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: Jani Nikula <jani.nikula@intel.com>, <stable@vger.kernel.org>
References: <20260803214909.3076716-1-michal.grzelak@intel.com>
 <20260803214909.3076716-3-michal.grzelak@intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260803214909.3076716-3-michal.grzelak@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0139.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::9) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|PH3PPF25FF87461:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d6fda4-ee2c-4164-80f2-08def2362649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ID6EsA1ELdFSYCKQaxn77hr7+MStTEKDz7eDAvKTSw/di9yUCY2dwqCuJ4dk2YG/2kvsAdiY+3FubviFWiEf6DDTY5yvIZ7RlvVt6JYr5JAUlfokrcOrgJPKShsYY45jobsZ+Mch9VbSor61TsaBIu3DBMDiDR4kKM8/qvSEyljCwRYi7JxG9w9IwElSepic6pLgg90kTCG6panRIuftRd3+bj6hvtnUKTMqs0GsF8ev6CDVVXOix3h3jXZ1YjhVBFz+VGRG+j9u3hXI1B9xw7IGxdNuaL1v1aeRzYhEGYWtcO5qYa3y6OsjYy2CyKKm2xC01lH/V/OhGH4Ja/EmzrRXS5xQIZ3u1EB4JfVD3MwZD+3xb2Rvrd7M2aRBwAEoR7NMewc6DX4U/aLaBdPZyASyXDGvCDjjbS6U3+9CMkUEo7WFcxH8cwFftWPr+3jcr4u0U4OaUvIoONHtCenIj2zmPZV4PfkA9Pglp6NaFO6Jb1xCxhtCXXli/S+KBst1rggQZBlXcOjI5PJQCZmjpW5qoKACBSUYCWEJsnsWx1Y60pMWW9rnyIedgfveiE4ATr5f7gsp8sBBJtZaqaWAPuIblUvubt3gZX708oJTMcMcpImX9WJcB4e09/T+1HWuw+sumVVznFJhIySEmjcn/TI6Svaqg1gj/JJLyjGc2DA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em9UaVRMeXp3L2tNL2FSbHg0ZGFhUGxLQ1czb21WVStRbGxhbkhCTWV5cTl2?=
 =?utf-8?B?d3lJZkRPckhpT3B5dnFtZUZMQ3hkdjNkckRXYmZSYlNLRFZTVXNnK1lMZUhK?=
 =?utf-8?B?ZkxoalZ6ejFtUEV1U2ZLOTR3UlR0ZHNENlRlYmY2T25HamZkZU9ZUXZrby94?=
 =?utf-8?B?SlFwZFBjRytKanFncWNibUhsV0MzdFRxb1JDVCtwVTJ5bXAxVUl6L2hsc3g0?=
 =?utf-8?B?Q0JvTWdUY1JzSWlrZnowUUNuRGZ4Um01VTFpelN1dk1zT010RHdBSHgzbWhi?=
 =?utf-8?B?eCs2WjdOVk1JYVpVdGtSVERLQThWem5oblZwKzhrTUhXcFZBSEFqeDdaNm9k?=
 =?utf-8?B?YjI3Y1Z6NkxYNitSQkN0cjFSWDJQTHVFUUM0c2laYURpVUVWR0tUaTllL2pX?=
 =?utf-8?B?Rlh1Q2NONmRtTFR0OTRqN29ISms4cVJ2WmZjd21yaHJSOVRGdGI5ZTZZb0dh?=
 =?utf-8?B?VEJCeFphdTgvYXZjTnVIK0tnbTNZaXlrS2hhZlpBd1VhNVIrSFN0ZWYrdTM0?=
 =?utf-8?B?UkJGMndVbnI2VG4rZ3JHaGhrSXkyQUxLdDNydzUzWmJwcm55NXE5bEtpWUZ4?=
 =?utf-8?B?ZzhLcDUzaVF0anpsV0ZxNmJXUFR1aEc5ZFVhRkVRdmI5RW1Ob3JZRjd1RExU?=
 =?utf-8?B?Qnl3YTlQeGpSTzc1WXFId1MzbnhGZjdTQWRFeVFpbTNwWE56emY5SkRWRzZJ?=
 =?utf-8?B?VFJMUGtyN0NNUXhpTkhoejFYTktQMi9UOHBaeTcvbW4vZWNuelhNcHdhcDV6?=
 =?utf-8?B?T1NaZE8zdnp0L1ZjS2Y1bmJ6dXJidnliUlJHS2pDYlBpT0NMbms4L05UOWJn?=
 =?utf-8?B?Z3dNeUcvN1FmZVNwN0RHRUN0enZ4U1pBUVlSaHRxZXFnOFNrY2NRakljS2dX?=
 =?utf-8?B?QklEcmVON0g5b0w3Si9LTUpEbjhpeDU2Q2FMRGpRQmJGSlpzNWU4blQ5Z3NJ?=
 =?utf-8?B?MEtPK093NnZLWWF3cmFPcTcwNklZUFFtNmtKdzhzajMwQzBlSFQyY0FwQnRl?=
 =?utf-8?B?bXhPVFgrRENadnhMaFQycHh2RnZiYXRRRjdzbGZtOTc4Q0hPcHpsR3dBa1B6?=
 =?utf-8?B?RVJRM3U5RlZFbHVLYUdRUmdTNklHSHI1c0haSUhtSDBlYUVLVjNpTnRoK3Qx?=
 =?utf-8?B?VHl5U1lXQWpWT281Ym5VeGNJVXFqZWNIakZrUjh3a2xEVHFaT3Z4RU9VTk1J?=
 =?utf-8?B?MnBOTmd6eGRVZlR5cy96Z0tNVEZCNkJwMCtJd3FJcTNZZmhGM05rWjkyL2lB?=
 =?utf-8?B?dEMxYjJGSThOOUk4Nlp2cE5pdmxQTndKVEMxeTVGMmhlZGlZWUd5dmNIREpl?=
 =?utf-8?B?SGtPU0gxNWlkSStXOWZUM0pmY3Z4N21lWW5YcVQzaHJZaVlKbmptZ1FWczdP?=
 =?utf-8?B?eEoybUxTeGhmS0VjNitsSnAxb0RPV0hKd2d4SUg0U2VXS0M1MmVMSnIxTUpk?=
 =?utf-8?B?VU1CT3RBL1N3RmRJTGZ4NU1mN0JwVWp0MFlKbnFaNXpaQ09lQisrUVdEdExK?=
 =?utf-8?B?bEpPUWlZQ1pONEdJVGdyOEZpV3RxSTc1OTNYT3ZzZnZNQ1VQVlpIdVZqV1Zl?=
 =?utf-8?B?LzBUVkw5bkszZlBEQ25JZkk1cWVrejRjN0hpYnJxb1FSWkFiazdNTXU1OHZh?=
 =?utf-8?B?MEJwOEhYZ2UrYkVHU1RNc0ZlOFlPNG5YbmtMM2NQZXJOb0UwcW1HaDd6SWFt?=
 =?utf-8?B?QVQ3Wk91dVhjRVRjUjRGSm1wM2JyQmNWTGJTbjZiM0haVnpGa2x6a3Y0Y3o1?=
 =?utf-8?B?L0JMUmg3QktvTEt4d1hXMjJLR2t6ZnBsWEE0RUZIcGZkRTVNSjZ0SVplZ2Y3?=
 =?utf-8?B?WUZIWSsvTHp3MjNBY2NMeDlGTDh1RW03dThNWnA2ZnRua2ViN0ZTZm1WdUxW?=
 =?utf-8?B?SlMvbnZkQjgyajBNQ2NJRy9SVkdUeXhOV1RRN2w4VVpmNTYydGxaRDdmMjFO?=
 =?utf-8?B?alNlVlRSTjBnbGNjZEFDT05mMGJJVnAxSlByb25GMnR6UjN0Wm4zL0o0bW94?=
 =?utf-8?B?REEzWkhFWGF2clMzbU0xdjRrYjdpQktnZUhHcFErWk5vTmU0V013THUxSkUv?=
 =?utf-8?B?c09zVllDTmI1cjM1aDdUUFl3UktyRmhaY2oxQzBFaWxncWFKVWVld2ZzUG96?=
 =?utf-8?B?ZlliSjIvZnVJUEZ5K0dLUEkrRE05R0M5OTgzZHFWVjl6bEEvcUY4TWtpbnVi?=
 =?utf-8?B?RnJNWStRRkJNU3NkN3pObDlhUEhOUVZ5SEM4SmRhWjBLNU10TTZzeENidmVr?=
 =?utf-8?B?ZzVRUEx2QTY2VGpkZzlSNXNKRGl5bFFiR3lpNlBIZ2h5NjdFTWxtYWJ2VHFV?=
 =?utf-8?B?TXUvdDNadFV6V2daZDg3Zk0xS2tGblRCSE5OL1p3RVpBNTFMSVY3OXZZcWRn?=
 =?utf-8?Q?PuS4PXJ4qSZTBvK8=3D?=
X-Exchange-RoutingPolicyChecked: NVuqsklF7uKrO+wPYYeCD6tdSAU+Amoo25qQBRMc00tmOiKH+TfDrch5+CPXUmdUdvt7+JKnlDsr1bR4pqE6H3XB+2R4C+29NbQHzBSalM1xsaDryQuu0wWjew90TaE6RK9Eil2FgrnYtCuzZF29fAkRq+modW2J/RtojFYKqSlwvzLzrtQWRJxfsE8qaDtwX9Oe7po76UGiSdzoo97KJ+vbzXGOF9ljCx4GEjIrXQ+ioUBvsTQPhzitEpP2E1mu2SfO1BIa1HMA2FQhpPLA/jAtWwGsuUOGgIP6/bW5PihyqAcPLZlnkw13LDYF3tghtMbffyBASxyU5+6B6tP1tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d6fda4-ee2c-4164-80f2-08def2362649
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:39:12.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHkw+Agxt9nP7N+hf9qKmsM5vVe7GCCBhT6Qpgdxzxx8M0us4Xyz6MEhoYyJVGwfcN4AqeajjdBpSudUWaZJ6s1XeNRRFRO9mBlx2uNVjNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF25FF87461
X-OriginatorOrg: intel.com



On 8/4/2026 3:19 AM, Michał Grzelak wrote:
> GLK+ hardware supports 3D LUT. Disable the feature for pre-GLK
> platforms.
> 
> Add .has_3dlut field into struct intel_display_runtime_info. Use the
> field to store whether 3D LUT is enabled. Initialize the field to 1 on
> GLK+.
> 
> Add macro for checking 3D LUT's support. Use it while checking whether
> CRTC has 3D LUT enabled.
> 
> v1->v2
> - use either runtime info flag or display version check (Jani)
> - don't initialize runtime info flag to 0 (Jani)
> 
> Bspec: 15585
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 65db7a1f9cf7 ("drm/i915/color: Add 3D LUT to color pipeline")

I am not sure if you need the fixes tag for this patch because 3D LUT is 
already gated on DISPLAY_VER(display) >= 12. More on it on Patch 3.

> Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_color.c          | 3 +++
>   drivers/gpu/drm/i915/display/intel_display_device.c | 5 +++++
>   drivers/gpu/drm/i915/display/intel_display_device.h | 2 ++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
> index 87ced9f6ff40..ffdefb51a264 100644
> --- a/drivers/gpu/drm/i915/display/intel_color.c
> +++ b/drivers/gpu/drm/i915/display/intel_color.c
> @@ -4258,6 +4258,9 @@ intel_color_load_plane_luts(struct intel_dsb *dsb,
>   bool
>   intel_color_crtc_has_3dlut(struct intel_display *display, enum pipe pipe)
>   {
> +	if (!HAS_3DLUT(display))
> +		return false;
> +
>   	if (DISPLAY_VER(display) >= 12)
>   		return pipe == PIPE_A || pipe == PIPE_B;
>   	else
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index f17fc2c68472..4c09f35644ba 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -864,6 +864,7 @@ static const struct platform_desc glk_desc = {
>   		GLK_COLORS,
>   
>   		.__runtime_defaults.ip.ver = 10,
> +		.__runtime_defaults.has_3dlut = 1,
>   	},
>   	STEP_INFO(glk_steppings),
>   };
> @@ -899,6 +900,7 @@ static const struct platform_desc glk_desc = {
>   	ICL_COLORS, \
>   	\
>   	.__runtime_defaults.ip.ver = 11, \
> +	.__runtime_defaults.has_3dlut = 1, \
>   	.__runtime_defaults.has_dmc = 1, \
>   	.__runtime_defaults.has_dsc = 1, \
>   	.__runtime_defaults.has_hdcp = 1, \
> @@ -990,6 +992,7 @@ static const struct platform_desc ehl_desc = {
>   	ICL_COLORS, \
>   	\
>   	.__runtime_defaults.ip.ver = 12, \
> +	.__runtime_defaults.has_3dlut = 1, \
>   	.__runtime_defaults.has_dmc = 1, \
>   	.__runtime_defaults.has_dsc = 1, \
>   	.__runtime_defaults.has_hdcp = 1, \
> @@ -1156,6 +1159,7 @@ static const struct platform_desc adl_s_desc = {
>   	TGL_CURSOR_OFFSETS,							\
>   										\
>   	.__runtime_defaults.ip.ver = 13,					\
> +	.__runtime_defaults.has_3dlut = 1,					\
>   	.__runtime_defaults.has_dmc = 1,					\
>   	.__runtime_defaults.has_dsc = 1,					\
>   	.__runtime_defaults.fbc_mask = BIT(INTEL_FBC_A),			\
> @@ -1335,6 +1339,7 @@ static const struct platform_desc dg2_desc = {
>   		BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |				\
>   		BIT(TRANSCODER_C) | BIT(TRANSCODER_D),				\
>   	.__runtime_defaults.fbc_mask = BIT(INTEL_FBC_A) | BIT(INTEL_FBC_B),	\
> +	.__runtime_defaults.has_3dlut = 1,					\
>   	.__runtime_defaults.has_dmc = 1,					\
>   	.__runtime_defaults.has_dsc = 1,					\
>   	.__runtime_defaults.has_hdcp = 1,					\
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
> index 7121e7cd9512..5300c6ab99e7 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.h
> @@ -147,6 +147,7 @@ struct intel_display_platforms {
>   
>   #define HAS_128B_Y_TILING(__display)	(!(__display)->platform.i915g && !(__display)->platform.i915gm)
>   #define HAS_2PPC(__display)		(DISPLAY_VER(__display) >= 10)
> +#define HAS_3DLUT(__display)		(DISPLAY_RUNTIME_INFO(__display)->has_3dlut)
>   #define HAS_4TILE(__display)		((__display)->platform.dg2 || DISPLAY_VER(__display) >= 14)
>   #define HAS_ASYNC_FLIPS(__display)	(DISPLAY_VER(__display) >= 5)
>   #define HAS_AS_SDP(__display)		(DISPLAY_VER(__display) >= 13)
> @@ -304,6 +305,7 @@ struct intel_display_runtime_info {
>   
>   	u8 fbc_mask;
>   
> +	bool has_3dlut;
>   	bool has_hdcp;
>   	bool has_dmc;
>   	bool has_dsc;

