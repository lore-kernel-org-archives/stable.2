Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793304972;
	b=Xx3vkaxRPnZdkXppcEapPV9jrhi4UN0RZfwf2R3eKvD6exQdSs2eqc/ar8uthTscTFCv
	 EuDUmN4cEZ3XF8KqfQ89V57QtRt2jLk8O8MtzFP0tG2wikpj2q51Mp9FitZasDOeVFbMF
	 HBHjDn6smJnEHZ7Wp2gx9JqawweSM7zurxHPdqltE2VU6Xrle7L0b2uzjcZGPkDWlEozX
	 tdmZV/QNqeL4aajmwgP+p0uc1vTsG3PnM5zBtFsIK84W/LRES9rG5FcP6KLP+Ml5Sb4QL
	 ApxOEPZmu7QRS/t0syowfJQZCeBheDrZpXkjVl2xX1VLwdJMEtapI6EdUsDexA2G2wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304972;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=zr2+JkfkLTjoHK85g/mOf5A87vK1NjtjdDy7fzU1Lac=;
	b=agPgzQ9RnkqX9Qpdzf4aYHf4+zKra+DGIPjHGb6ibIv7fbZ1VlBXb4uQ+OQOuDqfosjM
	 ZxTEIacRZntdGT0Eady9zub0r15cz7DE0MT98HRcENJU7qEX+b214TSw+SJ4r3loF/+uq
	 /liaATSOb13T8Dx/HdXet4hEMtAdj2d0Z+dbn/45CBjCReYNCKtAjL4i7Mebqr734Cwvx
	 satMIJb4Km9+D/T/e4HvMqQyb87/bu0XqCWF98RO0GA/U8bdw2V64K2ZFTHVEbIwYlKN5
	 nSEW3uTKE/gPXvO5tTIWy0hDjgeUNGaGbpyseAFWeCpiiWukI0GMgVpY3hfHYD/vMKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bB86CQJj;
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139A606A31F;
	Thu, 29 Oct 2026 20:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C139A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bB86CQJj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793304971; x=1824840971;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YNlDw4JUdoWYJn7jf89+nkzm2C7umP2w7QoHKUt2yDM=;
  b=bB86CQJjq7b+oAQrlzHGjOYcSzzBHI1C7VDN7CKwlpA9qGt2Cm3YLXtX
   4vB8jnN5yPrvTLPJ0el0puprRh0Atms+nMFe9R2V4wI55hYF6SHPaNzbo
   idCR1OYhcrhLqRkzzUS+Qhro/r0OVvJYz/T9TpeVu779E5e/mjWIbhF33
   Wc+1gt7Fe2QKcWMZtgkD9Vb2S9fFMMiKbrtQSdGmiqphEBcYhZ5MAR9nM
   Kc1WCCQp2qkRn3vhM2XkhVh7JhXawh/WYoPM2EyIOtf1cBubwiBoRMIhi
   USD/nRUcKeUT+VFBdc1mJPCqlJNcocfIff9xCLaOsyd3R8F9GucwAohoD
   w==;
X-CSE-ConnectionGUID: 9WCVPQuaRw+SIQjmRIgG6g==
X-CSE-MsgGUID: lPBfyejlTNCZdT58D4R9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2077316"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2077316"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 13:16:11 -0700
X-CSE-ConnectionGUID: gkSfTD06RE+JWB8lzNqEtQ==
X-CSE-MsgGUID: tUZd3Vc4SQGfaT1xuSVVVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5268549"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 13:16:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 13:16:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 13:16:09 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 13:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE6qGhqsPQ6IEOdYCeZPS5yPD8MyuOYIfJMQxu3qvApC8Aikm8Z3WGf+rWcwK7cYGJ2aBchHEPefF8bL5aKqejPUGLrN1sAJWwf6EIgo52PlbA/5AyVexV3Kebjb+LweqoPXmQ7c7lzinkO0WLZZFhykNTwN7WJq1qC4oIwlF6/49Td+GDCvsXNsRx5QEQOQnah8z0K+65SZEF9PpaV77kMzHpdE1Bah0kf7AIfZ4x4bBWU6N2HKR0M0Z8KJJKz2gxuLciB8Po7hc3jafZhFzBxP2PV/Bo9rCWntNgUP4aOqQOTUEPaVj4Zeh8mwMtCiOV4CFEuDRSbUsgtn6ecR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr2+JkfkLTjoHK85g/mOf5A87vK1NjtjdDy7fzU1Lac=;
 b=rZ95zInrDjqSrXVviyqwhh6TPW1DPY9sLoPz6gx+YeyY79f8VUnR1u8wv6SvPF0ico9fPCpea+HZTnHvjgZ8Q86kTCafiWp984OPH/J7TmkEXOM1gzqGVD6420J/rNb70Ia5EcInuIJuiLw7B9H1J04Hjok7eR1vW8cJoR5rwPcLEYWr9J7rwPCdxnXgpnYSb1K1Xke9d3QBsl6Ygy7tQA7iIb4jEHQeAaohk+q2AsZvfoTS9BzhmUnTBtGLh+VvnmTJpBsC7u7/dL843Rv0Bt72ax4mv69eeiQZPW9jZm4G4hQf6t9g0960QKMgjrmFEhU5rCQ/zBjBIJ7a4Iz1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 20:16:07 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 20:16:07 +0000
Message-ID: <eac354da-21f1-4663-84b0-74dab1459fa9@intel.com>
Date: Thu, 29 Oct 2026 13:16:04 -0700
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v3 1/2] x86/fpu: Fix memory leak with dynamic fpstate and
 exec()
To: Guixiong Wei <weiguixiong@bytedance.com>, <x86@kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <cover.1793072271.git.weiguixiong@bytedance.com>
 <f6c7690f8288ad9e95996e0cb37fc4c385df9ee1.1793072271.git.weiguixiong@bytedance.com>
Content-Language: en-US
In-Reply-To: <f6c7690f8288ad9e95996e0cb37fc4c385df9ee1.1793072271.git.weiguixiong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::24) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: a467133b-7d9c-43bf-5f8d-08df35f97715
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: RZHD7LJ6njWilVIpYp2qB6S8qfo4rg0Cs1pjvP2JRraW6tlJsOVGD7qC6RxsMqwZiJj2TBNYOkZ6ya0OAFbxIRfxwjPeKGQwtzsTBjHw9G9ANqPquG+oIvTPeqzpn1E01gtZ1MwRgoRZq681QzPZUK9ILp3Opr3pdpsmrLbprKYqPpZKLW7+RRknswBOhL3j//LKH4i4NCBDlJEnu+WP2BJ0xWkSXzmgcDRHJifL+8Iee0+3IYk+3Mqxu1jGxffgpXt+0z+Q+rvTTv74OIilEMv4DXQLnDrHTKtQ84dRI6bSBnQdHJmB2LThbfHBAyPqQEqhAbr3THAozo1cZkzTthlzACn3nQHTIDzdW9eMBb77xK9DjcGGgIL0b/5z0aEiV5OixU95MjFgCqTC6FdZVRjfwjXPEapBgVW1ZlBdb/wEvDrdF0QJJdAF4z2aPWESQYraCG96A9TTDVDkHZ7Nm20H8USvVK9KLDK5jgK4q244tY9GBcnV8AYQmK+v8/nq2Pt0ql3AVNTAhWy3b14MigW7Qx9l2VVtqdD60ICRKO+BT7ZRo17e0QFzudb2BZyjy6hE1SR0myNQSw6HZA2kIswur945ctOlNe7AR8d5T+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZTUEhxa3BiQUgrM3diOHdDM3Zkajh3ZWI2NHdpdG10VExTM0JPZVNmeU5Y?=
 =?utf-8?B?b0paWFhZZENYc3VPWjBJRzBwUkZxZmxjd1owazhOZHZoaEFNYW5KYlRldzBl?=
 =?utf-8?B?QzZ4U3BDNHRBMWZrWVhPTmlqdHV6U2U5ZC9XZHBUZE9jQiszbWJkdGNremM1?=
 =?utf-8?B?N3BUaUpSakNycTAvN2JJVHdRK3p3UDJxSTNTMGZxN1ZsUWlTTU55cmUvMFEx?=
 =?utf-8?B?NFA3NXE3YXZnWkNEZDZEdzd0a3d2dUs0ekhxRU5uZkswaEUzMDVBR2xzM0lk?=
 =?utf-8?B?akFkNGdLd2JxT083TG56QU1GaEtZMDZnandlZzJ0QzQ5TDN6N3R1WnBGQU1y?=
 =?utf-8?B?SXpyUURBS3dqNUdNeTlEdm1IZmFZZFVSOExNY0RCQmdwa0g3cEx3SWFVVEc5?=
 =?utf-8?B?OWs1YUM5QUE4czJLZFRTa2wxTnRmaSsxQjlxbC9lbFZhTWw3blB6MkVHZHRa?=
 =?utf-8?B?R3dCa1JIR0NLa0hTdE5FN1hMV3pCdU1EbVB6RTZ5UjlaOHJhZU5aekF1Nm9z?=
 =?utf-8?B?Ly9ZYjV4T2pVQmlIbmtIMnJwc3U1Mk4yQ0U0eE9Pd0k5UDhKV1FOTHNZRW45?=
 =?utf-8?B?aDFPLzgyTWM2S2x3cUdFY2pVVWxmRzN0a0F0VGtFdFFVVDN6TFV4ckN6UXV2?=
 =?utf-8?B?TGVSR0pGc2tOTE5yczFINE1raUh4VHpVOTh3VXBDLzBhSFJ6WnUwZVRLUGkv?=
 =?utf-8?B?MmU5Uktwa0xOOU11WDM5SGI1RzZ4bHMrbWpLVnFFNDVzMWtlNjBxakdKemkx?=
 =?utf-8?B?NnJYU0pPYmJMZGVNbVJ2bmxVL2ZhdUphVWZGSno4czlITS9VUzlhVnZpc0pN?=
 =?utf-8?B?d0N4aklmcFRJamxwUVFiNFBQcTNZWkcrbWF0bGV0ekh4WFRMdWxJbGJlUHFM?=
 =?utf-8?B?emxYcFd5M2tUWUNxYUZRVExsTXVyODdZMTduQStRRDJQbUlhUWo0dmp6VXIz?=
 =?utf-8?B?blRMOWczTGIvd3lmQmhRSndCVFBBOHdNMlV0c0w3c0JtSWo0QWZsdlJubnBx?=
 =?utf-8?B?b3lRaFkyK2pRbVY0UzErZGplU1hrU09CakdvalRpYktNcnkrZ2pDdlg0RFhJ?=
 =?utf-8?B?QmlQUTc1Um11TkFxZXovK0JLK0RzSFNXcVpjSldmalF6YUZGdlF6NWRvWGVi?=
 =?utf-8?B?VlFmbUZxM0JDeGlWQ0NDdEJ5ay9LYVV3b2M4ZnVpRHpNR3dzT3h0eDdwckJE?=
 =?utf-8?B?NVp3ODhtZ1F1NFpsZmRXbzBIODdFUkJmdFU3NXZocXkwN1UyYkdTekt2VGFW?=
 =?utf-8?B?ancrODJsd0ZtRDNnaXZxcXRTNU9CZ3BPc3VaTDU4S1Q5MEkwR1J3R081Ti9I?=
 =?utf-8?B?bUtlM0ZxV3QzN3F3NGdYMXhXUEp5ZkUySjNsVTFUMDRwcVlFbXBvcFNhNkxw?=
 =?utf-8?B?K1NqYnAxcGpMRlpZUzg1Ykw5b052SHFBbUU0NWJTN2J4aWlsRVNGbjFnSU51?=
 =?utf-8?B?UzRGWGhJWVV6dkRrTGN0VzJtbXZxNWFvTWRyMGUrMmtvN1l1bEJWeUdzSWMr?=
 =?utf-8?B?MExvSW5BdS9oR2VtblJkbnY4UWRmeFFudVpHanFuYW1DY2dpZlZ4dUtsbERt?=
 =?utf-8?B?ZnFuSHY3WVVYaVM4aTlrMnkzTlBGOFFDbXFNSFJYeURUR0cwMWtOckJwTk1t?=
 =?utf-8?B?V1I3THI1Y21oWUJycXYvT0gySkt5L3BMZWNRTmY1cEp3bXZkWVZwM0FHUkl2?=
 =?utf-8?B?Kys3MDI5dHdvejlFTkpaYlp4WkdHakJqNjE0dE9uc0xxN1h3WTEwUlRVWWdj?=
 =?utf-8?B?b3FBS1YreEJxMEpoQWNRRHR1dlVCQkk3L08yYkU0L2plTUhGVDVSQTlQTXFp?=
 =?utf-8?B?YlBYTnZYUVNUTElha0JkbFhXeHBJdGlhUkJ6L3htV2dsOEF5YUZ6bHFRVW5F?=
 =?utf-8?B?d3I0RWx1YkcxR2dWUFFKbFRPelR0MXM1U0dhbnJjbldsTGtrMEVqaUhkWkhZ?=
 =?utf-8?B?WmxtUDk1R004ZjM0YVF0eXhINkRScWlSTkRoZUl0Si9qOXJJMTVudFZhTG5t?=
 =?utf-8?B?dklIcVhCcGtBZTU2QS9VZGorcm5LdEU1NlBGb1ZaK0szdEY3V2ZIOUI3c3pT?=
 =?utf-8?B?TzdZZEFWdXlpWEUrZmtZTTBGREtrQ1dROWowampaendsTVE2QVBxOEc3RGlI?=
 =?utf-8?B?UE5wY3J5SHpOUDdOZUp1WFpRU3dXVVZGVG1ZQURVN0VFcDFNbDlNOGVPQSsw?=
 =?utf-8?B?OWpwVjdmaU9tNzZudWx5MXhEL0U3T0NUL2ViU0l0eWMvOUFXY0lZa01ISFVo?=
 =?utf-8?B?cUxlZW9mNFE2dFpVN2pGZnpXUGVtV3ZITVV0aUlmdVJyTW1HbUdySm5xakM0?=
 =?utf-8?B?dkpBZlRXU1VlMDY0QTBtODlrejE5a2pDUElpN1FuWlBHWE1yUzlCZz09?=
X-Exchange-RoutingPolicyChecked: ML7Mze8RNn7qfXfbrxzdzpHf9TZobPIpfv6e7hmHo8LXoUGC1a6oOPJEY1R1Bq218g3lTLvm9hti6Axc0AKC1BaeOYrIvkWCVT3M4BRfAI9DdstGvSPNUopCHfxUoK4vGJZgq7DYD8P2x/uKPibSkwBUXWlSCSVajKfxlWUSNVjzY2h4rtTDeu5R7EtJtbFjYzFI54gnq36L50O2GDfuJIanh/ASMzxuTqgbMk91nVNDSgC6QHcBlC4cs/GwDnWWN+pd8qDRiRQDD/pPdaEUYJa8RNUzOdJvO0IGvln3IWWzOGyof8uThJT1GBGJl4T3bP/d6wcRye8Zth6aaPyaLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a467133b-7d9c-43bf-5f8d-08df35f97715
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 20:16:07.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE7v4XlHAaZQ7olWi4d1zVoGkorsDtxQPZ8rKLMqGwn4evNjNOouPZrKsxeT6R+ST/MYcSRDHAVymCBTLz2iX6USaaKY3m4VtgBR4DeB+vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

On 10/26/2026 8:44 PM, Guixiong Wei wrote:
>   
>   void fpstate_reset(struct fpu *fpu)
>   {
> +	/* Free dynamic fpstate (if any) before resetting pointer: */
> +	fpstate_free(fpu);
> +

Did you check Sashiko review there?
https://sashiko.dev/#/patchset/cover.1793072271.git.weiguixiong%40bytedance.com

The point looks valid to me.

I think one way to fix it is to set TIF_NEED_FPU_LOAD in
fpu_flush_thread() before the reset. Maybe something like:

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d1aeecd57f5e..f474fc357281 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -592,8 +592,15 @@ static void __fpstate_reset(struct fpstate *fpstate)
         fpstate->user_xfeatures = fpu_user_cfg.default_features;
  }

+/*
+ * Callers resetting the current task must ensure that its FPU register 
state
+ * isn't saved on context switch as the buffer may be freed here.
+ */
  void fpstate_reset(struct fpu *fpu)
  {
+       /* Free dynamic fpstate (if any) before resetting pointer: */
+       fpstate_free(fpu);
+
         /* Set the fpstate pointer to the default fpstate */
         fpu->fpstate = &fpu->__fpstate;
         __fpstate_reset(fpu->fpstate);
@@ -670,6 +677,8 @@ int fpu_clone(struct task_struct *dst, u64 
clone_flags, bool minimal,
         /* The new task's FPU state cannot be valid in the hardware. */
         dst_fpu->last_cpu = -1;

+       /* Break the link to the other FPU's fpstate: */
+       dst_fpu->fpstate = NULL;
         fpstate_reset(dst_fpu);

         if (!cpu_feature_enabled(X86_FEATURE_FPU))
@@ -866,6 +875,9 @@ void fpu__clear_user_states(struct fpu *fpu)

  void fpu_flush_thread(void)
  {
+       /* Prevent the hardware state from being saved on context switch */
+       set_thread_flag(TIF_NEED_FPU_LOAD);
+
         fpstate_reset(x86_task_fpu(current));
         fpu_reset_fpstate_regs();

Thanks,
Chang
