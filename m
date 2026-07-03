Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0282DEA95;
	Fri,  3 Jul 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094775; cv=fail; b=q5Bb8HrQu0+CrylNvdVigYmG5GvwCIj1SAcI1/dmCSkJR2cs8+3swzGY6xRO9w602IUqlWy4aCj7UmmZhIcSmwi4/oXlIpNedToNxXR89ov88DRyE6eT6KIbMkxsII2Y6XKpe0GMtiiCaEosvtdAQayeAlSX/dTtd6FelusKzu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094775; c=relaxed/simple;
	bh=fGTUATdzMi8jRqHoPTgUgDTGgJ16xhjC1kU0nAdI+Zg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QkLm21r94p5sjWiz14XSL8Q0tLyVsUr6XRonFASiJJnxJNGoEuciuqSfiGyuOgWTMV7nFowo5gjpTSJf36Lobrcp9pQLldWP7wqXSzW2LdERganmVGEo3JYCs2LyfLWidofLSKKWda1Ca5amZPOp5Li/I0eOVKQvo6qGtM8HkbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKac/loF; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKac/loF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783094772; x=1814630772;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fGTUATdzMi8jRqHoPTgUgDTGgJ16xhjC1kU0nAdI+Zg=;
  b=DKac/loFWR4R5C3qDcvodn1CHgqRdua1hovnK8lJtKra2tWoJlEItQyI
   ghkXUMJh3TIwR/IVe0G+eVNz84swlA/nbM5PeHBi537ZpS2vtVQPMNLWc
   wjL+Q/Zvc1pnViGgwvDsYECSwqEBJYxWN8tjbXZ46ZSUUnlpHWKZo9H3d
   iB0+OoSzu2D8yFM1BSxFhRkz0Lnce5Y911/JzbyeCKb20hNfZzGC7Uj4+
   9bzKM39gYzle1NM2+f0oDKxweBT59iYPqkDV3CSUw8UstkMzEiGHznjEx
   I4r+IEFk8ZKaj1YyFG7tiSWmuLqAdKLkSyY86lPD+G7Dkw7WR96Zx/l9d
   Q==;
X-CSE-ConnectionGUID: W1NKDzodRsKP3TzWvIqIqw==
X-CSE-MsgGUID: H1nsNyIrSbGsDd+uynhaiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="83883464"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83883464"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:06:10 -0700
X-CSE-ConnectionGUID: NHLYMM5uSWGgjH7s5JAiNw==
X-CSE-MsgGUID: ldlPjRk3RrSZZYuDO2n9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252081899"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:06:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 09:06:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 09:06:08 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 09:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc2mnBFA12b8qErLYXXOdLbhqmmXZtbefjjF0eaDqo1nulPm/M/O2IEJ4K2a7cCVyZUJJKY0rP8bcua3ahFznflXyw9NEixEfDc97r5D4dr4+Kg/Xqh3BDjIep2zCoqAaAbgkUuvP+X+c5s3j0T8ZfNFfNiwgsA9NeqCs2VfLSlVA+f7S+e9UdXOxsly7vp84m4X+V5S51ipgjDgw8XvzQ6ohptiUJ7j7wEntMgapNtz4OFE3ywZUl3NXplOg60jSzK583LC8X1WSeMRAFCU7YfMT7tdtnEl5TILdPaLWhTNFW+PDCZzImlVlApSbhiXbvfWC1d+tPA79Qjwzx00KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gje+kMswaFKxHYJoVjLkWfg2eWYd21HlBRPYS9eC5qo=;
 b=SWOb3L1Dyvh2JwR+54FdDgANUOQqflERq2r/VjLc9ctFN17LkBic4Kyi3MKC/HFAnnOi0R2RWeB4FddZx9j88bmMFx9cftJcDR5MNWY/ZRwGAszf61bxFTR5feyT82uEDk/f2AFJT2PFf/l6z34xDSvjnZyJfUqDfJ3xY/Y2tpF1gpJWek/dda4cp8+36pg5RjF2iSKMpFP5/cbvjqPEthyB+LIPKUAzld+wV8EcvhUD/rA3Ure4rN4sdxIvgbP/FpjL5yv0wWErDNJNfjBT/ywHKmy6DS8sSdVEdN+TEYTlrbWZnL5l0lwjv/lKX/0bKtY3HEo7+URvvg/t9V+sHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 PH3PPF0515C3CD3.namprd11.prod.outlook.com (2603:10b6:518:1::d05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 16:06:04 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 16:06:04 +0000
Date: Fri, 3 Jul 2026 18:05:57 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Eddie Phillips <eddiephillips@google.com>
CC: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>,
	<joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, <sdf@fomichev.me>,
	<willemb@google.com>, <jordanrhee@google.com>, <nktgrg@google.com>,
	<maolson@google.com>, <jacob.e.keller@intel.com>, <thostet@google.com>,
	<csully@google.com>, <bcf@google.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] gve: fix Rx queue stall on alloc failure
Message-ID: <akfd5abdGbxFl5o9@boxer>
References: <20260701005341.3699161-1-hramamurthy@google.com>
 <akUUXT6UwTTD2yOs@boxer>
 <CAPBb8HmE6q0VPa5PooFP3VFF27GU3B4622Xww6MHRT-9i4zTxA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPBb8HmE6q0VPa5PooFP3VFF27GU3B4622Xww6MHRT-9i4zTxA@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::28) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|PH3PPF0515C3CD3:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee0a7a5-20b9-40b4-96ca-08ded91cfc1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: vOUwzDodPTC+Bzg3Hhhc9CJ7WG/WkCBnPpTEAhSK9dhluQgajFK7xh3yNiePkbSoOvtHgtPfHs56t5ez6o4wk2/SdLB3kt77yC9LvLqpZemE32XrLyaEiV2tS1y8o/bKCVNTj48DpwwaWn5YG+EDVw9eChRqhSs00tRhgJOf14H8cLpeAcz2OxmvtwbBDZy3Jn+mkgpujqvafVLOypSghULudwxxnssYC2X3tDaYbLXLj29G7HsvTxSaYDCrHMDHDwfkr65okBj1v0zVZC9EyaczCLrz0LUWtI2gJjiy4OTW3E/Pwwbi8SAA70zVmcug447OxHzHC4xk6HJcguWnf6uE5YuuSZSuu4eXWSyIulX9LysdnfBC7wRIfNIatLAVfaokFT1Q1NulT4j/oLPQAl5jcBDie8KaVzCmRWZD59O5cCk5zgpTQBwB6/sTlZwdArb/TgpRuGwm8+z/2hdl2c7H6qzolr5LuIPSSdi0PitLfzHJ8cCWRae4RXcoOXCc3dxljyxxWCnhjDG4N9UsJxeX/dYTxvd+wTkTXhf3rfHzBeLvEfGXUec1w2BfMeldU/TIs/I0gc/SJUJvrXozFN0lkuO2pkNJ4h2PX4Gm62ynN4Q9K37OGvb5mIxBtOzjTx++x+7/EIOEs8CvscLaaCXL7/zBnVSvEu7M0EGDBJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlVIV05Lb2lSa0lFTTJGbFZ3cUs2bS9oOWJTSGloVkpPcUljb0o4OWJHVlBz?=
 =?utf-8?B?SXFkZjVXd3Bhd095bWRxZlpxU3A0Mk0wUUMwdjE4cDlBSmxrOGRkcjJoT0NO?=
 =?utf-8?B?R0QwaFo1Zm5uN0pGVHQxdXZEQk52anduMlFDeU5HODVrTHJEc1dJb3Qvd2VP?=
 =?utf-8?B?RXJFUnM4UkhKclEwUWU4OERTOVpVUG54aXVVa1dmQXZXUUhzN2VWd2pjdTg2?=
 =?utf-8?B?MHhLczJiTE84MjZiZjJPRnp4endrMUFWTk5jMHVKU2tmVnRNdDBKZ25JbldD?=
 =?utf-8?B?ejdFRzByUldwaS83VHU1VGJNSkJPY0pPZTdpbjM0MTBORjdJejdHdzVkN3dC?=
 =?utf-8?B?clZQblpMZUVKMUdDTHVaUFBoVTh0ZjhwN2lGc1dONjl6UjB5V0FCbktSVExY?=
 =?utf-8?B?c0Q5YmlDVWc0MzJIN2M3U3JkK0wzVDM4eUsxM2c3aXdwZ0R1TkMyNTgwQVpW?=
 =?utf-8?B?NjVaWXFHQnYrSmFZaHFhZGJaOGxxSUNvRHh3R21wYUlPcktnL0hZa3RYelVy?=
 =?utf-8?B?Y2NGUUdtY1poTkpzekVaRmVLTlhFRmE4bWNZaXIvYjlhcndmTHdRN1VFVTVG?=
 =?utf-8?B?czk3Q25YTWFyeTlnVjRqazlrRTFKVlJQVXJKSXZUeUNSVnY1MFl4UHpwZytZ?=
 =?utf-8?B?MTZpbG1jOUE5VVlxTERSSlZzcUdXN2k1UGpOb016QW44K1FoYjJkWGR4dVpu?=
 =?utf-8?B?dzk5MUMzcmFiaDFtRXdRMWgvOE1RTWovSEJ2eFVkN2tlVGRPT2RtSHRsdmxl?=
 =?utf-8?B?aHFrVEFIbnJZc0ZsYXJKMHVCclFqU09tWEVRNDJyeGpnYk43cHFCWk9IdllI?=
 =?utf-8?B?SUxIWEYrSHNBVklvRG11SDlpeEd1TU9MSWNxWFFyMDF3NkNnanlxZ0pXNWlu?=
 =?utf-8?B?cHlYYmdiU1NHRS9VYi9aK280V0czS1FramJ1WjZpeVBodlQ5NzNkUDFFTWl2?=
 =?utf-8?B?RS9lTUpxTFYwMUFRZU1NOVFVNzhGdCs2SkpwMmZNRTdrOUpuVlpFNzQvWFVm?=
 =?utf-8?B?Z3Ztc1dsSXNYTVdhTWptTXN5NGp3WEVvbWNORUZmblJsaWo2K3NOS0FnMGMx?=
 =?utf-8?B?WCt0UTdlM1h1eGRVN1htbTU0aU5aOS9OR2s2Y0RjRTVsWmVEeUpLekszSFFY?=
 =?utf-8?B?S3YxNmZJK3dHejRFdE95TTlwd0N2MUdpWm40Y0Y1eDU3QmtKRVVDOWdZK0tN?=
 =?utf-8?B?dGUrSW5hRzB6bjJXQVhEd1hDaXV2RlFPSE9EZnZOWUtDZlg3UVdFWXZPN1Mr?=
 =?utf-8?B?K3RrS2x6QzRxZEJSWkdHYVdvR3VuVXkrZ0hUaG5hWDhCUGxxcUlFbVFTSnJI?=
 =?utf-8?B?ZmRKQ2tBMzJDWHNvYUlhWGcxTEpYRU1QUnJ5RUhZc1AvTnVBNm94bGZOQXN1?=
 =?utf-8?B?Z0NIVHZmWEJsb1VuQ1JTYWFybWQ3dTJzM1VpaDM1R0lCMjlnampERmN5VGx6?=
 =?utf-8?B?TTVEVXNzd2VDckNuRlR0cnpOWlc3bWczWDIrZGZuRGdUOHRzR1VSVUpYK3Fk?=
 =?utf-8?B?aWRwRGhENkM0eDR3ZUJiZDZEa0hVampRakl1YkZXWWFMaG1DNTJ0RnQxclpr?=
 =?utf-8?B?ZGF2SWJXc0hzamhQN0VWK3ZEcXR2eXdnYVJzVU9UUnNJcXdWVmN6QzVJdCtQ?=
 =?utf-8?B?elBwSGZHYVArcVFWUXM2Z0FwMCtLdVowTE9naXhYNVZMQWV0NkpiVHhWQ2lu?=
 =?utf-8?B?Q283K3pleGMzb1JtdHljd3l2QW8wbXFWMVp6cDM5d1puTDdMdjVKKzZZQ3lJ?=
 =?utf-8?B?MkxpTmhRd2drcVZNSkdhWXlUdjZZREJJZklEMGdheHhnMFdZdmI0K1FMRFFX?=
 =?utf-8?B?amdMd0piT3IvUmNOUTZsb3VURmxFcXdXQUoxMGwzMHZKeE14SUt5UnJWNWhs?=
 =?utf-8?B?VERSTmd3aUxnOHZPZXRLcGpWcHJDNmluaHA5YXI1MjVNUG9qa1luTkRaTjVx?=
 =?utf-8?B?bXQ5UThoSnp0cit2dTZkN2tuQ1VLZmZ4OHBqRk90SWZZeENMUDFyWUFlbWdv?=
 =?utf-8?B?MlBJNFUrWUZ6WFNoM1prUEMrMElUbXBTNkxnU3V2OG03NVYxb0NLeWtUOW9z?=
 =?utf-8?B?NzVvYi8vTDh2YzhUODcwNkRwd1ZWY0VWNitpcThaejdVZGdxMnRoV1hyUm5X?=
 =?utf-8?B?MjJFRkpNLzNzeE5DR3lPSXhqc25pdE5lYmhYZGcvM20xclBtZjNmaTRuV2dm?=
 =?utf-8?B?NE9vd2FVV2JRM0tHYWZFclUwYzhnSHpPWHptVC9jOUt0TUJnZWIxU0VBSmFW?=
 =?utf-8?B?UnlxcTgweDNRclluSDcxSXVHWWFEQmEzMWJsRmhOeTV3RkpiL1BsZ2s3U08w?=
 =?utf-8?B?Y0MrdnpQMEFLRXhtaFBhTnZXQ0pEYUQ1eDU4ZFlxZFhkWGo3L3dkOGRIL1VY?=
 =?utf-8?Q?mN+C9lwidLRXjYu0=3D?=
X-Exchange-RoutingPolicyChecked: tKf90PZTCTaMkZfh7wsl1Xv/A9ksEnDd+o5VeGUcTEQ1OpQEwnmlAGX77xFIJtYsq3TISI+92yY8pqHUjXum+iu0C5KHKZOfWq4sVX9bslF/vCrNg3wDgisQHW7MvBNUJt4aAHhwKQHninN3oXS5VQCc/gbSUEWNDeRwMJZOvnQBea+rFJ9cboSS5a9qkEJWIFEDMV5czfHAZh8UFsNQ24Y1iaabeNjaDcPqNWTCIk3G5cBnJvJBTgur5jONPNJDx/QGi5vknzeSQuSzlIcmp5CYvX1Sp0o+1XqXGvUniUox3mMvik3SbznEsDhEDEV4h4hIsgGo5z23SbgMIEUs6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee0a7a5-20b9-40b4-96ca-08ded91cfc1d
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:06:04.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khzNZpy2vXWA+jyx/qrfhCjHTO3brd7oAzd4EiH+XB/uui4LAcIYrtvdgFvxXS4sG03Dnw2gU2ILLH/TeL0Qm3cliYdXNxmKks7QGUisqEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0515C3CD3
X-OriginatorOrg: intel.com

On Fri, Jul 03, 2026 at 01:03:20AM -0700, Eddie Phillips wrote:
> > I think this deserves to be pulled out of the timer logic?
> 
> If by this you mean pull the stats into a separate patch, I agree.

Hi Eddie,

instead of forming a response at the top of the mail, please have your
answers inlined; it is preferred way of communication on mailing lists.

> 
> > - couldn't you detect this case within napi poll loop?
> 
> It can only be detected after attempting to refill the queue and finding
> that we are still below the critical threshold.
> 
> > - if not, does it have to be per-q timer? wouldn't one global per pf timer
> >   satisfy your needs?
> 
> There are a few ways a global timer could be implemented,
>  - The global timer could queue napi for *all* queues, which would
> result in a lot of unnecessary work.
>  - The global timer could iterate over each queue and try to detect
> the critical low buffer condition, however this would require
> introducing synchronization between the timer and the napis, which
> would introduce expensive locking into the hot path.
>  - The global timer could be paired with a bitmap that stores which
> queues need to be serviced.

bitmap would probably do the job but i won't insist here tho.

One more question/idea:
Before arming the starvation timer, could we first try to make a smaller batch
of already-posted buffers visible to HW?

It seems the HW can accept RX buffer tail doorbell updates at a granularity
lower than the normal `GVE_RX_BUF_THRESH_DQO` batching threshold, apparently as
low as 8 descriptors. If that is the case, could we first use this as an
emergency low-watermark path: when refill posts at least 8 descriptors but does
not reach the normal 32-descriptor threshold, ring the doorbell immediately and
only arm the starvation timer if even that lower threshold cannot be reached?

> 
> A `struct timer_list` is only 40 bytes, so the current implemention is
> not expensive. Though a global timer is valid, it's not strictly better.
> 
> That said, I agree that we can clean up the structure—I will move the
> timer state from the individual RX rings to the `gve_priv` structure.
> 
> On Wed, Jul 1, 2026 at 6:22 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Jul 01, 2026 at 12:53:41AM +0000, Harshitha Ramamurthy wrote:
> > > From: Eddie Phillips <eddiephillips@google.com>
> > >
> > > When the system is under extreme memory pressure, page allocations can
> > > fail during the Rx buffer refill loop. If the number of buffers posted
> > > to hardware falls below a critical low threshold and the refill loop
> > > exits due to allocation failures, the queue can stall:
> > >
> > > 1. The device drops incoming packets because there are no descriptors.
> > > 2. Since no packets are processed, no Rx completions are generated.
> > > 3. Because no completions occur, NAPI is never scheduled, preventing
> > >    the refill loop from running again even after memory is freed.
> > >
> > > This results in a permanent queue stall.
> > >
> > > Resolve this by introducing a starvation recovery timer for each Rx queue.
> > > If the number of buffers posted to hardware falls below a critical low
> > > threshold, start a timer to periodically reschedule NAPI. Once NAPI runs
> > > and successfully refills the queue above the threshold, the timer is
> > > not rescheduled.
> > >
> > > Also add a new ethtool statistic "rx_critical_low_bufs" to track the
> > > number of times the starvation recovery timer is triggered.
> >
> > I think this deserves to be pulled out of the timer logic?
> >
> > Two questions tho:
> > - couldn't you detect this case within napi poll loop?
> > - if not, does it have to be per-q timer? wouldn't one global per pf timer
> >   satisfy your needs?
> >
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> > > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > > Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > ---
> > >  drivers/net/ethernet/google/gve/gve.h         |  4 ++++
> > >  drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
> > >  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 32 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 49 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> > > index 2f7bd330..8378bef2 100644
> > > --- a/drivers/net/ethernet/google/gve/gve.h
> > > +++ b/drivers/net/ethernet/google/gve/gve.h
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/netdevice.h>
> > >  #include <linux/net_tstamp.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/timer.h>
> > >  #include <linux/ptp_clock_kernel.h>
> > >  #include <linux/u64_stats_sync.h>
> > >  #include <net/page_pool/helpers.h>
> > > @@ -41,6 +42,7 @@
> > >
> > >  /* Interval to schedule a stats report update, 20000ms. */
> > >  #define GVE_STATS_REPORT_TIMER_PERIOD        20000
> > > +#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
> > >
> > >  /* Numbers of NIC tx/rx stats in stats report. */
> > >  #define NIC_TX_STATS_REPORT_NUM      0
> > > @@ -318,6 +320,7 @@ struct gve_rx_ring {
> > >       u64 rx_copied_pkt; /* free-running total number of copied packets */
> > >       u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails */
> > >       u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fails */
> > > +     u64 rx_critical_low_bufs; /* count of critical low buffer events */
> > >       u64 rx_desc_err_dropped_pkt; /* free-running count of packets dropped by descriptor error */
> > >       /* free-running count of unsplit packets due to header buffer overflow or hdr_len is 0 */
> > >       u64 rx_hsplit_unsplit_pkt;
> > > @@ -334,6 +337,7 @@ struct gve_rx_ring {
> > >       struct gve_queue_resources *q_resources; /* head and tail pointer idx */
> > >       dma_addr_t q_resources_bus; /* dma address for the queue resources */
> > >       struct u64_stats_sync statss; /* sync stats for 32bit archs */
> > > +     struct timer_list starvation_timer; /* for queue starvation recovery */
> > >
> > >       struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > index a0e0472b..71b6efbf 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > @@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
> > >       "rx_hsplit_unsplit_pkt",
> > >       "interface_up_cnt", "interface_down_cnt", "reset_cnt",
> > >       "page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
> > > +     "rx_critical_low_bufs",
> > >  };
> > >
> > >  static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
> > > @@ -58,6 +59,7 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
> > >       "rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
> > >       "rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
> > >       "rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp_alloc_fails[%u]",
> > > +     "rx_critical_low_bufs[%u]",
> > >  };
> > >
> > >  static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] = {
> > > @@ -151,12 +153,14 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > >  {
> > >       u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
> > >               tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
> > > +             tmp_rx_critical_low_bufs,
> > >               tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
> > >               tmp_tx_pkts, tmp_tx_bytes,
> > >               tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
> > >       u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
> > >               rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
> > > -             tx_dropped, xdp_tx_errors, xdp_redirect_errors;
> > > +             rx_critical_low_bufs, tx_dropped, xdp_tx_errors,
> > > +             xdp_redirect_errors;
> > >       int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
> > >       int stats_idx, stats_region_len, nic_stats_len;
> > >       struct stats *report_stats;
> > > @@ -197,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > >
> > >       for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
> > >            rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
> > > +          rx_critical_low_bufs = 0,
> > >            rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
> > >            xdp_tx_errors = 0, xdp_redirect_errors = 0,
> > >            ring = 0;
> > > @@ -212,6 +217,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > >                               tmp_rx_bytes = rx->rbytes;
> > >                               tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
> > >                               tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
> > > +                             tmp_rx_critical_low_bufs =
> > > +                                     rx->rx_critical_low_bufs;
> > >                               tmp_rx_desc_err_dropped_pkt =
> > >                                       rx->rx_desc_err_dropped_pkt;
> > >                               tmp_rx_hsplit_unsplit_pkt =
> > > @@ -226,6 +233,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > >                       rx_bytes += tmp_rx_bytes;
> > >                       rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
> > >                       rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
> > > +                     rx_critical_low_bufs += tmp_rx_critical_low_bufs;
> > >                       rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
> > >                       rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
> > >                       xdp_tx_errors += tmp_xdp_tx_errors;
> > > @@ -269,6 +277,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > >       data[i++] = priv->page_alloc_fail;
> > >       data[i++] = priv->dma_mapping_error;
> > >       data[i++] = priv->stats_report_trigger_cnt;
> > > +     data[i++] = rx_critical_low_bufs;
> > >       i = GVE_MAIN_STATS_LEN;
> > >
> > >       rx_base_stats_idx = 0;
> > > @@ -337,6 +346,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > >                               tmp_rx_hsplit_bytes = rx->rx_hsplit_bytes;
> > >                               tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
> > >                               tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
> > > +                             tmp_rx_critical_low_bufs =
> > > +                                     rx->rx_critical_low_bufs;
> > >                               tmp_rx_desc_err_dropped_pkt =
> > >                                       rx->rx_desc_err_dropped_pkt;
> > >                               tmp_xdp_tx_errors = rx->xdp_tx_errors;
> > > @@ -381,6 +392,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > >                       } while (u64_stats_fetch_retry(&priv->rx[ring].statss,
> > >                                                      start));
> > >                       i += GVE_XDP_ACTIONS + 3; /* XDP rx counters */
> > > +                     data[i++] = tmp_rx_critical_low_bufs;
> > >               }
> > >       } else {
> > >               i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
> > > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > index 02cba280..303db4fa 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > @@ -18,6 +18,16 @@
> > >  #include <net/tcp.h>
> > >  #include <net/xdp_sock_drv.h>
> > >
> > > +static void gve_rx_starvation_timer(struct timer_list *t)
> > > +{
> > > +     struct gve_rx_ring *rx = timer_container_of(rx, t, starvation_timer);
> > > +     struct gve_priv *priv = rx->gve;
> > > +     struct gve_notify_block *block;
> > > +
> > > +     block = &priv->ntfy_blocks[rx->ntfy_id];
> > > +     napi_schedule(&block->napi);
> > > +}
> > > +
> > >  static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
> > >  {
> > >       struct device *hdev = &priv->pdev->dev;
> > > @@ -120,6 +130,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
> > >
> > >       if (rx->dqo.page_pool)
> > >               page_pool_disable_direct_recycling(rx->dqo.page_pool);
> > > +     timer_delete_sync(&rx->starvation_timer);
> > >       gve_remove_napi(priv, ntfy_idx);
> > >       gve_rx_remove_from_block(priv, idx);
> > >       gve_rx_reset_ring_dqo(priv, idx);
> > > @@ -136,6 +147,8 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> > >       u32 qpl_id;
> > >       int i;
> > >
> > > +     timer_shutdown_sync(&rx->starvation_timer);
> > > +
> > >       completion_queue_slots = rx->dqo.complq.mask + 1;
> > >       buffer_queue_slots = rx->dqo.bufq.mask + 1;
> > >
> > > @@ -232,6 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> > >       rx->gve = priv;
> > >       rx->q_num = idx;
> > >       rx->packet_buffer_size = cfg->packet_buffer_size;
> > > +     timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
> > >
> > >       if (cfg->xdp) {
> > >               rx->packet_buffer_truesize = GVE_XDP_RX_BUFFER_SIZE_DQO;
> > > @@ -365,6 +379,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
> > >       struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
> > >       struct gve_rx_buf_queue_dqo *bufq = &rx->dqo.bufq;
> > >       struct gve_priv *priv = rx->gve;
> > > +     u32 num_bufs_avail_to_hw;
> > >       u32 num_avail_slots;
> > >       u32 num_full_slots;
> > >       u32 num_posted = 0;
> > > @@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
> > >       }
> > >
> > >       rx->fill_cnt += num_posted;
> > > +
> > > +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> > > +      * visible to the hardware, and no doorbell was written, the hardware
> > > +      * is in danger of starving and cannot trigger interrupts. Start the
> > > +      * timer to periodically reschedule NAPI and recover from starvation.
> > > +      */
> > > +     num_bufs_avail_to_hw =
> > > +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> > > +              bufq->head) & bufq->mask;
> > > +
> > > +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> > > +             u64_stats_update_begin(&rx->statss);
> > > +             rx->rx_critical_low_bufs++;
> > > +             u64_stats_update_end(&rx->statss);
> > > +             mod_timer(&rx->starvation_timer,
> > > +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
> > > +     }
> > >  }
> > >
> > >  static void gve_rx_skb_csum(struct sk_buff *skb,
> > > --
> > > 2.55.0.rc2.803.g1fd1e6609c-goog
> > >
> > >
