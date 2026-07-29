Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCA3A875F;
	Wed, 29 Jul 2026 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362284; cv=fail; b=fM6FNWfED7ZPl1zCAT7ko96dPl0ICfyLegtqhhu7CMDye/wHGCriqHCYJVwA5rtldMVMgX2GDQgCPMugHiA8jYRB+halL7snuvD8KnSfjArYkoRFJ9A72YTOpfBIk+8WkFC0C152MamQ8iur+N3cj2KHBwPCH2n5KdHdSISESe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362284; c=relaxed/simple;
	bh=gKGIfgrVXMO80KrGQ9nPZ7suOicZC/eGvUO8oGCorqo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V7WdRJP4MSuqk38cWkHZXc84SDqdB+KEj+ubrjFthl1LShk7HELQ1YboQv8CwcaPj2ZYkHV6QFT4xfrD/IiGCGIxPmxNviPALajQ+JzndracSf0w6ZLipIi0RX4c3EtG18Ynv9ePxMC8VMKiJR/irOZSSGH1DbUe/DgIWlUPBKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUUhncUV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUUhncUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785362281; x=1816898281;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKGIfgrVXMO80KrGQ9nPZ7suOicZC/eGvUO8oGCorqo=;
  b=lUUhncUVrynfa4eMM6okc+lPDAa+Vp2JwmxLbvctY8ZEPyubeHnN6xze
   rBaoZStZe30PO0QgarotGLEN/Vc2SB7QB8+MYdL1DEuyY0c3avxNhjEdF
   uh4nUolSLDC1Vctj5Da7fX3LiB+VzqqwgAuNADoYKKzozXaP1DF5Lw56d
   EOtebP23ZK4O/yWkOFMshgiofmQ+8eE/KwVT9BUQFzetjH/rfNRSxeWkF
   /ZyZrUueToafaaXNRHB5zp9oUidVK8nTpaLpuwojKKgL4JkPvkTA/lZ5k
   ZQU+5EW8IiEynUZzwTNpmz7qJZ3W4pZi04wngraqKrK5H6CSdhD1b92Jk
   A==;
X-CSE-ConnectionGUID: bJKjAu8dTVe70R1CkkR1Jg==
X-CSE-MsgGUID: Oq2IEBZSRxqvlZZ7R7hLDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96642743"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="96642743"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 14:57:59 -0700
X-CSE-ConnectionGUID: oXRiup7QS+m8L1pPwPslrA==
X-CSE-MsgGUID: x+cZGi13TSCjYTXUCwLMYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="265170296"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 14:57:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 14:57:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 14:57:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 14:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfqa4V8HOr9H7ajVsGYGo7PFQKak3edXTJOWwgTgXUmu/TRbs1DwDqSpvtKc0KKw40Hg+nqEX0tJogGKUR3ScsYylTxZuKW7UV5FgVdVo03Q18Ox9r51daDycyMjVL9FgewweBKcrMDC7ofEgmITyFHis/GV2bBgty7M+sSDGZkpVzzM6e08PKeY+LM1gQUo0R5OKjP3rmKdVQV7Av3Ab/atOGY4o/fqdNI99n03d+neFsNS2FPtJqLH/USHDxAGVQeMMIYuc09lrEj7ddNlUc7lRiY9f/DqoYOiy4QE9mLaDf84mw/qVmHQ1q+vevpJQ+HiRBoL/hwtazqOqW5+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gZAxo5z0yF0wH/AkNu+jnSIP3+TU7F9e/i5OjkKE0c=;
 b=d1tduSiNlo/Gz7k8WGMbtLpFhbvpAPQuRADUhezfYMDbxi6LEgjsopjVVC277MBMGKSluyzWSpfRM2DHAgSBhs7iS987mRTVRk5S9L+wk6fgSenb7bb0iwRc28sn1hozgLst0d2+bhQDj9xxam3kebZx8Fa3c6BASGnz2+8fsWmEtMm+I0mfoA86Sadr3K5RMjH5s3it67UKiSgIDmG8dZ3Rn7Sop2eGiMOXfDkhOPO3Qi8TWtDTq0WrTInOVPKtYMWOlHSn3PbdGernz/ZMUF7aJzH+xOrAGNHeWsTye8Kv987nLAmGgZvFgt79iKpUGdzzRx6ye+A1CBvAToRbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 21:57:57 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 21:57:57 +0000
Message-ID: <40acfd87-23c5-40d2-8153-e94e1108c269@intel.com>
Date: Wed, 29 Jul 2026 14:57:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] qede: Fix NULL pointer dereference in TPA fragment
 processing
To: Vaibhav Nagare <nagarevaibhav@gmail.com>, <horms@kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: <andrew+netdev@lunn.ch>, <matvey.kovalev@ispras.ru>,
	<Pavel.Zhigulin@kaspersky.com>, <aelior@marvell.com>, <manishc@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Vaibhav Nagare <vnagare@redhat.com>
References: <20260727093322.1119035-1-vnagare@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260727093322.1119035-1-vnagare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA1PR11MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 35782f76-642d-4dda-45e9-08deedbc72c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HHpeMjWE6sTc8UGnawSrNuUnUbj4Y1/td5PML83NDCwiibZt4aararfiHXQHBJ0ichNtRezSeNvccCLIcgWjTijLxri9BS5DArQXp9MIUHtea+/Outtgj1HOaMSKzHuzJOeodqR+d+ixc/rxnedbX0K3HGjIrLCsedbhMJ2rwvZWTPpJ4pyctsiaJFP87eYyTmqj1J20kb32CiL7VxPdqiIt5Y50rPjFcL8IWz7hac8v1LamDj9wJoG13clDkZ96pIaCMvbcaJL6L/BLn3kVm16xHAUoesLW7dgcyEwPZGBL0E7udhqW6ms6QvSexzBNWlJgRxQm7VU/UqW6ay9Gku3RBypkJD1fBFPJN0CWWV8h1X7+VAMZNeAn5CCejzckuyTEOmrtGH1b6c7qTuo0D+jypd+wR/1cEafA9vRFYp47vjqrz/7rLO2Y2UY024dRHxa2ffZPJJKHk5OaO7Y0TS+bh3nswZ6WPILXJTFmnItqtyAHrxoMFJCfH5/nYe6juEIeBe9H0/vhcnehPuHTMXuvz6515yr0TdoBM3lKhgQtrC8b7iKGypWxREtJZnj88nfr7ZAy5WouEXw+xSm9iAFQRGjEVwGnqmPdxvMscYR8VYxyqBdiWyaf25w4wCn2hiKNTA5MRY5HjbleLpGpsJqFl5UrH/j0W4uKy6Q/DDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitjbFhlZnptbHd4VkNEN3RiZTFvZ080N3FwZGd0WEV1cndQakc5NytDeHQ5?=
 =?utf-8?B?ZnlZUDdTcGNoU2pEc2FhS1NsWXVmYUVXRDdUdUZiMGFEQy9yREZSVnBqNzBs?=
 =?utf-8?B?bEw1RjhzS1pOSXlGTTUxVnl5SjZlaVZ6cTRDZi9XOWVCM2Z3Q3lnVlF4eUJR?=
 =?utf-8?B?K2JLZTc4NWQ3ZnNYRHdGUk1Gb0RxekZ0MFVHMXI0OEJLTmRxMXdHczdKNk9F?=
 =?utf-8?B?ZUgxWlY1cEFsZFZrS3FUbUhzalVVUkJXc3ZiQzZrTm0xNVBSalY2MUh0R3VX?=
 =?utf-8?B?ZGo0emRlSnBUdTRlU3U5T1JiWUsrZkVtRk8raFpCK1dEcU1UMitnWlhYMHRs?=
 =?utf-8?B?M1dSa1Y4dTdhdzFPVy9PNnhnOXFGSmZINXg0RjF1ZmdUamFjMEpGTE41MlhR?=
 =?utf-8?B?V3poRzFiT1ZOazcrTFRteVdqc1c2dHNra2FpZ3BORjZMUCt2NW5TditaVG1W?=
 =?utf-8?B?UFM1VGFZaVYzc1BHZlBpWVJ6Y3dnRExYNmVtYVl4eHN0MWFITEtFaUVGMHNW?=
 =?utf-8?B?bzJRZ3NiY1V1SzNzem1iM1FJUUhkUDNNVmVObGRnME5ibnpSNTdKekhSeERp?=
 =?utf-8?B?a1lPbllFaUt5Z1RXSFFnUkY1WmpueUY5N0REN1AyS1FzWjdUUzcza2FMQURl?=
 =?utf-8?B?NC9ZNm95bE5lRzZUUDl2eElGSnMvVDEvRUJZbDNFUEtzTmFVdEI0WlE4aDJj?=
 =?utf-8?B?N0hlZVRMNFZ2V1REYTZXOGJ5VGV4WXJVMXVpOHFSNkZDQmp0c2ViV3FNcTJo?=
 =?utf-8?B?UmNoZlVIZzlyNkdJQk8rU3dES3FuNVRuMzFIRHJsT0wrZ1RYWk50Vnd0aE03?=
 =?utf-8?B?enRhaHIrM2F1NUR1dkdnYlhJeERERE5xSy9IRktLYlR4NlZuWmN4aHNwQUZu?=
 =?utf-8?B?S1NrQzMrdXM3Yk9GdWF6ZklTc3FsVE1hamUrb3djOVBRNzVnM2swRElGUGFV?=
 =?utf-8?B?eFgraDBDZXFBSjY2cWliVzJkZ0M3WGpycTVuMEZSYkcyVW1ZZ1lSbGxqMFBB?=
 =?utf-8?B?Sk9BUXQ3QkhqcTdDNVBRN1cwM2VqTlErK01mNUJuTkhtRWdhUVNUWG9UaGdr?=
 =?utf-8?B?ZVpRSG5lWmlyOGVWcE5tRjVLQWkzWkFtNDdhNm5hUWlyOUQrSDdCcEpKQU5v?=
 =?utf-8?B?TTVXbzRwYS92WjBQVk4zbmZBU3Z3YVg1ZC9RWWNmcUphUEFLbWl5dGw4U0sv?=
 =?utf-8?B?cmhoaUVKSnhuVFVPVFlCdHJFYnV2eUxZejJhVkxKL1BubXAxVDNodkZ1Ynlr?=
 =?utf-8?B?MmZrRVhVaFJqZS9TcmowODh2WUFYdlNaazBzZGZpdjJBYVFnZkNTWkdIWVQ0?=
 =?utf-8?B?dFdTSG92NElXRGN4RWtFaU9HMzRxOTdzUE14clpVVWpkNjA1YkdEV2JqWXVt?=
 =?utf-8?B?UGJyU08xMEQ0T2pmVlpuNUdLRDEyYjB1SGRBSkp3dzlvVEdhRC9kQzN2YVp0?=
 =?utf-8?B?NXNsWDlOQU9DVi9VVDJWelRWWGZEYkN5ZzJoZU1qNTlQOFhiL2Z4cVlhL2l5?=
 =?utf-8?B?blZLSHdQM2YwTHhRZXVFZXRJRUVPSkNCYm9NdTJya2tvanVhRi9acDBiQjdi?=
 =?utf-8?B?cGRPMmdGWnlpVUJjL3NGK2VaVi9vdFJESGFieDdyNnZWYVFPcWpXTkEwcXdj?=
 =?utf-8?B?am0xeURxRlEwR2JOTTRTWnZ2NTY4SUxSajI1V1lMUmszdm5HQ3VYY2wvLzZG?=
 =?utf-8?B?RVdTY05NcXpzUXNqeGpsaDlRWHhheUFKZ2VEclVWMDllSldhUHhKUlJreU1C?=
 =?utf-8?B?ZFBCTzZBNWpPcHA0THpDWmQ3cFV2OThBVlZqYTlHU2xYZmUrOHFrNzZwTDUy?=
 =?utf-8?B?ZUVxR1JMV3ROM25DWmllUVA0aHZTNzIzTXpndjhDVHZzYm14Tm1mWWUrdjE4?=
 =?utf-8?B?UEJuR1pScDhXcnhpUE1DTjYxdTVqcjU1Z01tZ2xzZlE2dDg4S3VsL1FBaS9P?=
 =?utf-8?B?V2lQZ2lYSXdqWjlxVm5tWjdwaG04K0czOXMvRksrY2hsTzVUNDZaR3VPRHBm?=
 =?utf-8?B?SS9JbEhoRERXejVWRitsRnVpelVON05iWVc3c3NuZmg3MWJhZGhHMlBlSEtO?=
 =?utf-8?B?ZlJ2cHp5cE9rcDRCdHpZZ0FzMnJvOS83TXMyNGdPMXRtRTRVZk1YRnBsSnVy?=
 =?utf-8?B?K3N1QlFqTFhLUjNRekxKcHc2alhJTFEwck1iNEZBaG9QNlVoSURnUXp0QlBP?=
 =?utf-8?B?QmRySW50WXN1N2VGdWxiaXRvV05EdmxKMXlOZlNVZnJFQi8rZVR1amVVaGM0?=
 =?utf-8?B?a1N3ejV0bWNYMkJESDlxTGoyQm03NG93Z0lsdmQ2VFJRQmh3WnpCcWNWRHF0?=
 =?utf-8?B?Z3VidmQ1dzJZT2RZa3FxNWcwRCsvajdMRHp6bjJtRHMwV1llRjVqRG1JUXhp?=
 =?utf-8?Q?4BS4jwnT0U7G7Fwk=3D?=
X-Exchange-RoutingPolicyChecked: Ubi5ybw2nM0UqmxDOyDST76tTo+JZUgPFxF0ZHIhu1iZSoj2LEw5u5EFXCoP3pJE80WGMLac6x+ZIsDVdBF699kHL9h8d/7XXy3jtMS6Eh0qcbEsDZZI1xz2kknyGin1QgLeYVWYzHw+1bDpOt27798dNGBJ+sdBjqZSZ6exOeiqTUSthAzphQkftTlStyNUyRIjF5SqBEYDHrHaU5g6xsNFhUaK8QIfFbRcfMEItOTbBHeFLZWsrmWWYAFNp1tSuT3lo+aYai1Rk0lWINVzmGw00K2QDaD2DoLZoOAcqQ0zqB15Nj+jDznRhPmR7rbHjFphqM5dH5fCkimwl95jZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35782f76-642d-4dda-45e9-08deedbc72c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 21:57:56.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtnX8QLMmFV+itpiDdsGyHV+w7ybMSyQY8vnyO1lYWOuaJc2BGs0bPguBTY+iyt/WJnTE7HrbuNGQAslhSNcctmi+496zsVMvCXKS4aDTqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com

On 7/27/2026 2:33 AM, Vaibhav Nagare wrote:
> Under memory pressure, the qede driver encounters NULL pointer
> dereferences when processing TPA continuation fragments because:
> 1. qede_fill_frag_skb() does not validate the page pointer before use
> 2. qede_tpa_end() checks error state AFTER calling qede_fill_frag_skb()
> 
> The crash occurs when:
> 1. System experiences memory pressure (GFP_ATOMIC allocations fail)
> 2. qede_alloc_rx_buffer() returns -ENOMEM, leaving sw_rx_data->data NULL
> 3. qede_tpa_start() sets QEDE_AGG_STATE_ERROR on SKB allocation failure
> 4. Hardware delivers TPA_CONT and TPA_END events for this aggregation
> 5. qede_tpa_end() calls qede_fill_frag_skb() before checking error state
> 6. qede_fill_frag_skb() accesses NULL pointer in skb_fill_page_desc()
> 7. Kernel panics with NULL pointer dereference
> 
> Example crash from production system:
>  BUG: unable to handle kernel NULL pointer dereference at 0x8
>  RIP: qede_fill_frag_skb+0x96/0x430 [qede]
>  Call Trace:
>    qede_rx_int+0xb06/0x1de0
>    qede_poll+0x2f4/0x6c0
>    __napi_poll+0x2d/0x130
> 
> Observed on HPE Synergy 480 Gen11 running RHEL 8.10
> (4.18.0-553.134.1.el8_10.x86_64), but the vulnerable code path
> exists in mainline.
> 
> Fix by:
> 1. Adding NULL page validation in qede_fill_frag_skb()
>    before dereferencing.
> 2. Checking error state EARLY in qede_tpa_end() and qede_tpa_cont() before
>    processing fragments.
> 3. Ensuring NULL buffer descriptors are consumed rather than recycled to
>    prevent NULL pointers from re-entering the active Rx ring.
> 4. Correcting buffer capacity tracking (rxq->filled_buffers) when dropping
>    empty descriptors to avoid Rx ring starvation.
> 5. Validating uninitialized buffers before reusing them in error paths to
>    prevent DMA and memory leaks.
> 
> Fixes: 55482edc25f0 ("qede: Add slowpath/fastpath support and enable hardware GRO")
> Cc: stable@vger.kernel.org
> 

v3 still has 2 comments from Sashiko, but I am not convinced they're
legitimate. I've outlined them below, but I believe the complaints are
not correct and fail to understand the flow, so:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
> ---
>  v3: Addressed AI review feedback:
>    - Fixed out-of-bounds array read by correcting logical AND condition 
>      order in qede_tpa_end() loop.
>    - Decremented rxq->filled_buffers when dropping NULL descriptors to 
>      prevent Rx ring starvation.
>    - Checked rx_bd->data validity before recycling BDs in TPA error loops 
>      to prevent re-injecting NULL pointers into the active ring.
>    - Fixed qede_tpa_end() error jump to prevent qede_reuse_page() from 
>      recycling uninitialized buffers and leaking DMA mappings.
>    - Moved version history below the '---' marker per subsystem guidelines.
> 
>  v2: Addressed AI review feedback from Simon Horman:
>    - Added net_ratelimit() to prevent printk storm in NAPI fast path
>    - Fixed NULL buffer recycling: check if page is valid before recycling,
>      otherwise just consume the BD to prevent NULL from re-entering the ring
>    - Added proper cleanup in qede_tpa_end() before early exit to prevent
>      memory leaks and ring desynchronization (DMA unmap + BD recycling)
> 
>  v1: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@redhat.com/
> 
>  drivers/net/ethernet/qlogic/qede/qede_fp.c | 59 ++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> index 33e18bb69774..dd6032200f52 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> @@ -670,13 +670,23 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
>  							 NUM_RX_BDS_MAX];
>  	struct qede_agg_info *tpa_info = &rxq->tpa_info[tpa_agg_index];
>  	struct sk_buff *skb = tpa_info->skb;
> +	struct page *page = current_bd->data;
>  
>  	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START))
>  		goto out;
>  
> +	/* Avoid NULL pointer dereference when under severe memory pressure */
> +	if (unlikely(!page)) {
> +		if (net_ratelimit())
> +			DP_NOTICE(edev,
> +				  "Failed to allocate RX buffer for TPA agg %u\n",
> +				  tpa_agg_index);
> +		goto out;
> +	}
> +
>  	/* Add one frag and update the appropriate fields in the skb */
>  	skb_fill_page_desc(skb, tpa_info->frag_id++,
> -			   current_bd->data,
> +			   page,
>  			   current_bd->page_offset + rxq->rx_headroom,
>  			   len_on_bd);
>  
> @@ -684,7 +694,7 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
>  		/* Incr page ref count to reuse on allocation failure
>  		 * so that it doesn't get freed while freeing SKB.
>  		 */
> -		page_ref_inc(current_bd->data);
> +		page_ref_inc(page);
>  		goto out;
>  	}
>  
> @@ -698,8 +708,12 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
>  
>  out:
>  	tpa_info->state = QEDE_AGG_STATE_ERROR;
> -	qede_recycle_rx_bd_ring(rxq, 1);
> -
> +	if (current_bd->data) {
> +		qede_recycle_rx_bd_ring(rxq, 1);
> +	} else {
> +		qede_rx_bd_ring_consume(rxq);
> +		rxq->filled_buffers--;
> +	}
>  	return -ENOMEM;
>  }
>  
> @@ -959,8 +973,24 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
>  				 struct qede_rx_queue *rxq,
>  				 struct eth_fast_path_rx_tpa_cont_cqe *cqe)
>  {
> +	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
>  	int i;
>  
> +	/* Don't process fragments if TPA start failed */
> +	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START)) {
> +		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
> +			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
> +								NUM_RX_BDS_MAX];
> +				if (likely(rx_bd->data)) {
> +					qede_recycle_rx_bd_ring(rxq, 1);
> +				} else {
> +					qede_rx_bd_ring_consume(rxq);
> +					rxq->filled_buffers--;
> +				}
> +		}
> +		return;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
>  		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
>  				   le16_to_cpu(cqe->len_list[i]));
> @@ -982,6 +1012,22 @@ static int qede_tpa_end(struct qede_dev *edev,
>  	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
>  	skb = tpa_info->skb;
>  
> +	/* Drop the packet if TPA start failed */
> +	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb)) {
> +		/* Recycle BDs from cqe->len_list to keep ring synchronized */
> +		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
> +			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
> +								NUM_RX_BDS_MAX];
> +			if (likely(rx_bd->data)) {
> +				qede_recycle_rx_bd_ring(rxq, 1);
> +			} else {
> +				qede_rx_bd_ring_consume(rxq);
> +				rxq->filled_buffers--;
> +			}
> +		}
> +		goto err;
> +	}
> +
>  	if (tpa_info->buffer.page_offset == PAGE_SIZE)
>  		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
>  			       PAGE_SIZE, rxq->data_direction);
> @@ -1023,8 +1069,11 @@ static int qede_tpa_end(struct qede_dev *edev,
>  err:
>  	tpa_info->state = QEDE_AGG_STATE_NONE;
>  
> -	if (tpa_info->tpa_start_fail) {
> +	if (likely(tpa_info->buffer.data)) {
>  		qede_reuse_page(rxq, &tpa_info->buffer);


Sashiko complains here with the following:
> Will this check always evaluate to false? Looking at qede_tpa_start(),
> it appears tpa_info->buffer.data is never assigned:
> qede_tpa_start() {
>     ...
>     tpa_info->buffer.page_offset = sw_rx_data_cons->page_offset;
>     tpa_info->buffer.mapping = sw_rx_data_cons->mapping;
>     /* buffer.data is not set here */
> }
> If buffer.data is never initialized, will this bypass the error recovery
> logic for TPA start failures? This could result in a permanent memory leak
> for the page and DMA mapping, and permanently exhaust the physical ring slots
> since rxq->filled_buffers is never decremented here to account for the lost
> slot. Could the original NULL pointer dereference be fixed by adding the
> missing assignment in qede_tpa_start() instead?


It doesn't seem to realize that buffer.data is assigned by
qede_realloc_rx_buffer or qede_alloc_rx_buffer, so I do not think this
is legitimate.

In particular, I think the AI fails to track that tpa_info->buffer
points to the same memory:

struct sw_rx_data *current_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
NUM_RX_BDS_MAX]

vs
struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];

As a result, it thinks the buffer.data is never initialized and relies
on this conclusion for both this and its next complaint.


> +	} else if (tpa_info->buffer.page_offset == PAGE_SIZE) {
> +		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
> +			       PAGE_SIZE, rxq->data_direction);
>  		tpa_info->tpa_start_fail = false;
>  	}
>  

Here, sashiko says this:

> Does this introduce a double DMA unmap on fragment failure?
> In qede_tpa_end(), if a TPA start was successful and exhausted the page,
> the mapping is unmapped unconditionally at the top of the function:
> qede_tpa_end() {
>     ...
>     if (tpa_info->buffer.page_offset == PAGE_SIZE)
>         dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
>                        PAGE_SIZE, rxq->data_direction);
>     ...
> }
> If a subsequent fragment allocation fails inside qede_fill_frag_skb(),
> execution jumps to the err block. Since tpa_info->buffer.data is always NULL
> (as noted above), and page_offset == PAGE_SIZE, execution would fall through
> to this else if block and unmap the exact same mapping a second time.
> Could this lead to IOMMU faults or memory corruption?

Same as above, this relies on buffer.data not being initialized.
