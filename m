Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626943CEF4
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445464; cv=fail; b=h5WShGNpClSdqRpmKT0BZvbUdQ4V2byxzq2a/ues+pprMa/E1NUDasiV/PGwC7JObPnR5usrUeZmt0L3gFlmp/6Db4yuON+93c3bXpfz3UHE+NnZH4ZpgI0jD4c6LFVVTflMFxMu2p7rrPIE8TaJWOtgB43fnCysvQ96X8Zr7HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445464; c=relaxed/simple;
	bh=L/TIefERAHEyMNDT2tE3tw8Iu9wKKUYD8w/OKJ8SVgE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hphZjgdrJuhRTEoN1BfQubz5Q5WAWz9cUubqb/b0brRuJtpM5Q6KzoYh/41cg0AAfupXXTsEYYgprTsQxRGlvcgH5AnTi5nPhAiwdzg+3fwgtUlxDZCyxIM838L/a4yTnnNtDbRz2wKZEo2dGkjNAv7hSU51C/j3rKiWFRaTEC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRXGAXjm; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRXGAXjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786445460; x=1817981460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L/TIefERAHEyMNDT2tE3tw8Iu9wKKUYD8w/OKJ8SVgE=;
  b=mRXGAXjma7nV5KCwHwHHKheVnducANSyGwPBe4xLeN2Lrno1uw82jijw
   SL7GMZzu9/CpES9x9WehOunBWweJuBa/XestdqHJfolKLYOMxrAKWYbi0
   bdDtm5GltO8et5OoQcqirpYMhhe/WAU/c3ebDqtQjHNNQfY/rDQo2Q9gv
   0eMcEvEecRBhUYq1eSH/W/W7ZCDat3PYRSfwcwkJVFp2BGqVJAATLd/aa
   J3CaxS0sSfoVCDJKWmrc6cKoXah0ciJEnDXpGYt09z4Ptgndw50F+OtaI
   aN26cKCplQmWBYbBwKmucGQdTnEgigRVDDo5tAEUPYQrTAf1WfpX8PQlp
   A==;
X-CSE-ConnectionGUID: FwK/OoWdRLSQyIcfiG0inQ==
X-CSE-MsgGUID: I+xozeuwRP2OnD7eDKQKYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86094147"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86094147"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:50:55 -0700
X-CSE-ConnectionGUID: tyY7WCSaRj26fTuwf7q+yg==
X-CSE-MsgGUID: ScFHglSxTp64tNUGugYpDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="262800442"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:50:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 03:50:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 03:50:54 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 03:50:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSd486AoJ74o7nG+iu52S1G7l1L5LNmkZ8/mkA/vFBXxmcVF22IHKSq9CTuR8OLGBstPgmJepR4Ob2swgwDYk6+Cw9uDmGQRd+QNxwWpal0VSY2nkEpq/DuF49CeIoXe+uPWE4V+7Vrfe47KsxeX3R7L54i1tqZ+d2bTHeGWcsSkgtNG8QhUbU6BX0iauiuetj4sd0aGu8ths4oSgD07M34Rci+yjv3VJlAdFHpr2mtSDobMEu9lGb/u2/fGu0HQxVYzTpS4y75Lx42HEOKE9BL4zJonHdMKKtY4Xxz8IPTHVjREgxOxsjs5yRSF+qSbXJ5BVPdnzXZmY1HBo5Lytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGTNJuzIIMHchoBhg9LlSkn5mGlXowKw6+AKVGNUx0Y=;
 b=DDCWGTTsFqBvVN1YFV1BA9PgqvplGZfIVhkqnHKOZuTYT6g8RKOlI0wwTPzgI8EXQ6eUNAadA88fIoX5xaPAuGlJhStyHI2Q+4hJJJrdXfeEhq5a956MTgCIOuJSt2+HNHtJcn09KrfsuhtZPL1irb3HKNk6DNRj904q81n+EBtTBGPLL5ightnwdEvanB2zR020j+Mt23WrlZj7yb1jg168d0VDTIJndGBBYGV/4v9lQsf7VrWzgySyyPEZD2yUMtLRr+wiCDLTtIXf7f2cWBRuxWui5zjdTDeJwBssKcxNJgun7/ERKDs394L3nasXeJ3Pp7LuiEmpew3SIABz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DS0PR11MB7405.namprd11.prod.outlook.com (2603:10b6:8:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 10:50:51 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 10:50:51 +0000
Date: Tue, 11 Aug 2026 10:50:42 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
CC: <intel-gfx@lists.freedesktop.org>, <jani.nikula@linux.intel.com>,
	<joonas.lahtinen@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<tursulin@ursulin.net>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/gt: Fix request use-after-free in heartbeat()
Message-ID: <yzfnzbtsqjvk4y6vhn7uvdrzew5hqzfo4khdsx226ppqdjgm4q@xzysjj4fwcwz>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>
X-ClientProxiedBy: DUZPR01CA0185.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::11) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DS0PR11MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 4852671e-8a71-42ef-b5eb-08def79668f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1irMwhAk33xigaaWR1ExGTUOfXwMqnm6pkxsX1DqPT4z8zuRmOvxemZuYrTvninI81DOeQletjrI++/ozE6t78RGwN1QEwhLPchQVjbfWzSOCB4TiSPOHnGXwY5GF+nflYlPuQXWdj5RLFOAKx+rAXQRD0s1ybq7Xl2TOzgE61lw/KgS3hymFqvlXHKQVeTNQ2Zil3VGVu498OPC2vvkeHqsrIE2+tsiiFj+AUflPaEuZdQno2k3SlqlPPAqNHjCkSi2fUghC/pnzTQtbYYzGDrPf8a+Ej3nr76ROdWHnPK8Ndbnlll+KguUS1VyjaL4wj4DGFYCuBblq9CxdUpygZgBTmU1MJwBJMpdKhKguBH+B5i6W9yDUzdm2mvz7L/Hk6jpNZTDOwzxUfH+03kY+RSfHrMghmIvDn3mul5gmRV7YEsXYB5jTdLZLTND0gw5EB8OiH9xFIQ7yEQh02QfMrrkoqQz5ZZy9LW3BolDet13zbaowPump2YmXbNdlMCIf2Rmb85ezXMCKJXJgXBx3sAz2jaNuow7T+gdDjrOkPJh3MIIs5+z3uHlkza1cZg2RCHXYyTw+PRxQG4NtegTu4G5FiZ9aKPSVSx+7fHcNMrRksGX0RVj8fLykiZs1R6GgpsqFbVeyJjex1bCuHL63FWKIZx0RY7xuzB7q63XsG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZFSUFJRWdERkJIQzRxcWtQd1dRN3BXOCtiTlIydW1PdFVGWTZ2dVBvdzQv?=
 =?utf-8?B?ZUo2czVGWjlYcFZ3UWx2L0FwbjVoRGlvZTErRzFrNlREc0RXMXlwSE40bUdT?=
 =?utf-8?B?eEd6cDNrOFhXZXZpcE1iV20zWkFPTStrL2xLaVNkMjBVRGl2YWpGYnZYRmJX?=
 =?utf-8?B?cElaWCs2K3B1eThzbS9FWXN0SjlDTkVnKzZJRTM2ZU9MVTJsNmdBN3phdERB?=
 =?utf-8?B?VmV1NHZQRHIzWDN4dFVRKzNiekYwMUVSQWJ1WG9ibVRLWnhwbnRSMkMrTlEv?=
 =?utf-8?B?cHV6STNRYlg3bWdNYis4WFg1ZWdGb0hHK0ZkOGZGL1I0cmF6WmdVRjdQQXB2?=
 =?utf-8?B?TXdnWlJ1UVBWUnZDRFREc3dGSWRvWTJpcmRaQ3VuZ21NZWxtYUgwYXNwOXVo?=
 =?utf-8?B?c01SSEJoQ2krcWdHeWpZZXFJRXhtQXhhN3JUSzc3N094N2ZaS1RHOE8rTnBX?=
 =?utf-8?B?U1V4djhkTVJ1bm00VS9rbDZRdlhtL29TTUxIRGx5OTAzWXRmbVhjVzRUamdQ?=
 =?utf-8?B?aExscHBBRmxQaDdtdy9PeE5Kc0J1NTRuQmhKemgybFczYUZFVzBJMyt2UHdY?=
 =?utf-8?B?eUhRcG1CL1dNbWM4cjZLUXVEeHJZcVU0RlhXMndiT29xNzNiQTVjMDA4RG9r?=
 =?utf-8?B?SDNBeDJlc0F2RzFRdStaKzYxb08xWGNLQXZvWm9UWGorYzFuZ3ZTMkJzMjdJ?=
 =?utf-8?B?dVZOZ1I2dWJRV0ljaTk4R2xHQ0t2UjMvdDFtTno2NE5aSllTb0tZV2EyOGtE?=
 =?utf-8?B?eGpyN0MrWFhrZmRpeTV4Mi9Ma2JFclFDSmhEcFA4cnlWL1JDUlhxK0VEc3Rs?=
 =?utf-8?B?WkwwTGw0TTY2RW5ka0lDYzVRMURqMjYwa0FsOXBsUGpudEQ1aDVtRE4rY1R6?=
 =?utf-8?B?bDhqTXA4UStDQi82OEo1RjhNVWRFK3FVSEVGU1U3azZTd3pLUTVuN2FqSmVO?=
 =?utf-8?B?akE2dDY0ZEo4UmpxMDRBS3BkNm16R3huQjdiM2dmNVBtUUtURlBEcDJQTTBj?=
 =?utf-8?B?bUV2Sm1RRmdlQ3dwUDJLbS80bzJGM3NmZGlwQXprdU8xbWFncmRUN0hjbWc2?=
 =?utf-8?B?T3JSNEt2b3ovcnB0MnpqSllnTURXUUFyemVqVkJyUnhGZ2dycFE4SUdKUlNH?=
 =?utf-8?B?Y2xLalVySDRyTHlQRjBYWTZJQjE1MVZhVkx0N3FiWWdrQXdsbXFMUFBiency?=
 =?utf-8?B?eVpENk43bGtMbC8yR01IaUFHbGFIUERPVE5xTHRwNEEwRXNiUVF3cVIzdkFG?=
 =?utf-8?B?S2lyL1N2aHMzWFBTeWZNV2Z4enFQNzYxMHlRZTFWZEhwd2ZaNXV3dUpldkJk?=
 =?utf-8?B?UE42cDJsNC9ERzMwVU9qcWR3cEFUNHd1V0hTY2x0aTAzMDdMejdaUU16OVZ0?=
 =?utf-8?B?SkErUExWVlJqcUZWVGwyaW9ZZldOYWpRMnh0L0h1OXh6VXRDeDgxTG5GYjB3?=
 =?utf-8?B?bDZmUDNqTi8ySkVIbDBiTXlEaCtXdUpobGtUSmR0N242WDBlZjR5QmIrTUV6?=
 =?utf-8?B?UjNXbVowZEpYNFdrKzJ1WjdvWU1LcFE1RFZzWHBmbW0wSENwSllONWFmSXZz?=
 =?utf-8?B?TWZUTEhpZ1NOQW9xM3B2WS9GekRlejBCd3BuN3Q0c0JRMmlQbkQwWm9GV3B5?=
 =?utf-8?B?dEh4UHNrY1UvYWFBR2JmcG5Rc1JHK3ViVnZZVXUyNTJUbG5uR0NDekVGUDFF?=
 =?utf-8?B?a013UGx5cEhYWC9XQVJTeWtlSkZGSXBUbHpRZXVHaXdiaVcweHNHd0dIdDVj?=
 =?utf-8?B?eEEvNFhtNFQ2aEI2S3FtQnlWVzVtbXBDb1EyWmI4eG9yaUM0enBwdlpwVkFa?=
 =?utf-8?B?Q2k0NWt1Tit6S3VBcHE3OVN0KytDeWpUaCtiNFNZMC9aY2RSeUgxSlhxMFM2?=
 =?utf-8?B?dERITk0vc1BKcUhpY3J1Q3U5VWwzYmQ1aGhsY2dBaEovL21uRUN4NWFSZENU?=
 =?utf-8?B?RjdJUVVpWWJJVHNDNXJZWWlRUkpHQnJ2RGZrVEpKZ2RQQitlZzRtK2h4eUVW?=
 =?utf-8?B?d3RLZHY2ZHUydGFIZ0FaWXV4ZkJIdEdzZlUzRkZhb09LT0tkUVJOeUIxUVp6?=
 =?utf-8?B?SitlT3JMb2JUVEVDMVVDb00xWEJoRDNGQ0JxUCtjcGJVNDl5dzJYR2I1NzY5?=
 =?utf-8?B?SFlsbDBrc050bTk5dC9BU01CUkRQVC9ML21KSDdvZWFHbVBlTkFSQVdWS2Na?=
 =?utf-8?B?SnZZeDRsN2NXeHF0MUpRRmJxT241Vy90Syt6R2ZhaEZ3bk9yQUdhMHMvSGJN?=
 =?utf-8?B?SUFjY3o3NXQ4cjF1d1JHdWp1ZEhucTNJOStwRHpQQlFTNFk5azRaOUtvcDFl?=
 =?utf-8?B?dURQUElDc1FmWUhUeXY5K2VVcm05RTJ6aDRXdmlaTVNXbUxJZWVMUzBSY3JS?=
 =?utf-8?Q?svqHv4k3wj97+X2k=3D?=
X-Exchange-RoutingPolicyChecked: ia6hFQprt8L8QoeVa9QIEl9rCAjFzbTFpv+Xr98s89QOWfSuP2Adyj4iaem/+jMtJcJbQVxlCxRv+opHaUqkWw2o6y/2MM7PidP9B64Yd+55ii59D5g9+dW+EbodAgf2/W/m0k7VpZ9+m0cKbbfwy3D3xRSkkg+0XfmnFDbkJqJl+ybOQjp7qHBvW0qOvHSbxScF52hIy2T7U7oLoXWpwaSPxYyxehdQ7hquSTzMTzWCifH+87l7RqqE1AX7baTnsnv2DWIPzoVjy+oVeVHGMRBfelUd2d5m2tDgC1f5S4SDVM2sCd5rvpdRFsM//CC/sP3Vz7tSa86S3Fxd1bjnYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4852671e-8a71-42ef-b5eb-08def79668f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:50:51.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/xla3NjVDUlKqHB+xdfc5RjHMKEqd/BWBjwbskwJBSFoBfDphxdxxyhilQ6YpKLtNdqR2ssAYNKwVUNH8pXFzpiBWwWeSNUII8ZVanlYaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7405
X-OriginatorOrg: intel.com

Hi Shuangpeng,

On 2026-08-08 at 14:43:02 -0400, Shuangpeng Bai wrote:
> heartbeat() detaches engine->heartbeat.systole with xchg() before
> checking whether the request has completed. If the request is complete,
> dropping the detached systole reference may free it. Concurrently,
> idle_pulse() can observe the empty slot and publish a newer request.
> 
> The worker then sees a non-NULL engine->heartbeat.systole, but continues
> to dereference its stale local rq. The newer request can therefore make
> the shared-slot check succeed after the old request has been freed,
> causing use-after-free accesses to emitted_jiffies, submit, and sched.
> 
> If the detached request is incomplete, heartbeat() can also overwrite a
> newer request published by idle_pulse() when it unconditionally restores
> the old pointer.
> 
> Use cmpxchg() both when idle_pulse() publishes a request and when
> heartbeat() restores the detached request. Drop the detached reference
> when restoration loses the race, and reload rq from the shared slot
> before dereferencing it.
> 
> A KASAN-enabled i915 mock selftest reproduces the use-after-free before
> this change and completes without a report after the fix.
What is this mock selftest? Can I see it somewhere and confirm
if it works myself? A link to a public issue would be cool too,
something that gives more context as to how this was discovered.

> 
> Fixes: bf9bd6a5128a ("drm/i915/gt: Track the most recent pulse for the heartbeat")
> Cc: stable@vger.kernel.org # v5.11+
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>  .../gpu/drm/i915/gt/intel_engine_heartbeat.c  | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
> index 6424ecce8bcb..fc6c53c93cf5 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
> @@ -81,10 +81,18 @@ heartbeat_create(struct intel_context *ce, gfp_t gfp)
>  
>  static void idle_pulse(struct intel_engine_cs *engine, struct i915_request *rq)
>  {
> +	struct i915_request *systole;
> +
>  	engine->wakeref_serial = READ_ONCE(engine->serial) + 1;
>  	i915_request_add_active_barriers(rq);
> -	if (!engine->heartbeat.systole && intel_engine_has_heartbeat(engine))
> -		engine->heartbeat.systole = i915_request_get(rq);
> +	if (READ_ONCE(engine->heartbeat.systole) ||
> +	    !intel_engine_has_heartbeat(engine))
> +		return;
> +
> +	systole = i915_request_get(rq);
> +	/* The worker may have restored its detached systole in the meantime. */
> +	if (cmpxchg(&engine->heartbeat.systole, NULL, systole))
> +		i915_request_put(systole);
>  }
>  
>  static void heartbeat_commit(struct i915_request *rq,
> @@ -152,9 +160,11 @@ static void heartbeat(struct work_struct *wrk)
>  	if (rq) {
>  		if (i915_request_completed(rq))
>  			i915_request_put(rq);
> -		else
> -			engine->heartbeat.systole = rq;
> +		/* Keep a newer pulse that raced with the detached systole. */
> +		else if (cmpxchg(&engine->heartbeat.systole, NULL, rq))
> +			i915_request_put(rq);
>  	}
> +	rq = READ_ONCE(engine->heartbeat.systole);
>  
>  	if (!intel_engine_pm_get_if_awake(engine))
>  		return;
> @@ -163,11 +173,11 @@ static void heartbeat(struct work_struct *wrk)
>  		goto out;
>  
>  	if (i915_sched_engine_disabled(engine->sched_engine)) {
> -		reset_engine(engine, engine->heartbeat.systole);
> +		reset_engine(engine, rq);
>  		goto out;
>  	}
>  
> -	if (engine->heartbeat.systole) {
> +	if (rq) {
>  		long delay = READ_ONCE(engine->props.heartbeat_interval_ms);
>  
>  		/* Safeguard against too-fast worker invocations */
> 
> base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
> -- 
> 2.43.0
> 

The fix looks sane at first glance to me, but I'd like to see
how it was spotted before diving in further.

-- 
Best Regards,
Krzysztof
