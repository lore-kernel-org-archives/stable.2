Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF83890E4;
	Fri, 17 Jul 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289442; cv=fail; b=Zth82g920VxQS7F8lZCRv4mqNi4nYUBf3T4r0dnObcKL/UH+Rj/F1XzO4EyvZSjhnlGux3Zv24YNgocHDiH+OaMPRDP5bHjReGEHk46UmFYpjzve9fUbsEPxD6c4dubxurLaCJvvSqDsQBtvFTOGijMwqnktXwwcEcAA7nn+UOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289442; c=relaxed/simple;
	bh=nbzzV/j9+aLhccIBDI0k+4YWOk7rxL9DHKdHwsejjWc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/2RXKnccJAnse1LNL+XGPJA0tYZcr5VtEG63A/7QXhoM/LZG1oWYIr/ml8+wNNaypyCHo6CG1ABDVByEVG2WkpKDaAO3lziWCWRKqNJ9UZDIIT4Rx+QjCaEgHQapxxao8Y2hl9AeodnJHyLXyi4du0YULVMSy0qckWik7frQQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ds8v8AFZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ds8v8AFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784289439; x=1815825439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nbzzV/j9+aLhccIBDI0k+4YWOk7rxL9DHKdHwsejjWc=;
  b=ds8v8AFZsFZehx+m8sPBpajgIfObGkCKULaaBD8xFfjxWCnqoPKuHPL+
   NF2K6ZaIrI+0mfiXciyu26qLYH0i1nt643YlU1SJsRN78ddnwlVDu7Emg
   KYBLabt9oJ+b5Y8tpFc/DtTm6xMOV/9hNxsfSa+UYAFE3OpRgGgu6ZNMh
   CfMVLF64n4qL8KuD4BOxsRdtZMJzcOkljI9bqNtO72Fkhr+AFCug7uwYN
   cgXPSoE1uigwXKju/AIJk/LiZxOoaUOOxu8Tj0pvvjcBXdZzRZ+4vAuec
   AiB1ayjfZJVmatPM/lYXpVnH7besqZ8yU5JYMv8cJTZs/09sBaYGEL8Kp
   g==;
X-CSE-ConnectionGUID: 30ohqwbHQhCH7BGMCvkK9A==
X-CSE-MsgGUID: QOPvc075SPS/5X45g4UXhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107753148"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="107753148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 04:57:18 -0700
X-CSE-ConnectionGUID: v+2I/0E+Tv6UWWQLL+sCkg==
X-CSE-MsgGUID: AKuqrbBqTNq3C9k71kXt1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="256851365"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 04:57:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 04:57:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 04:57:17 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 04:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSrwhNl6WB5z+/RV7JkOOhckehwPLsEcIS5nqwn3mDErJdcZf5hVrV/8DAmap9UrYWe2D3bTdyz+bIiuq899xksfgA9hNrnqErJujrTrI4USywLdOwEFdQcOLapVFEn4yrrv5r6qGYTm2j2MIKoST5xzAKi7RezqKlJ35Kuo1PBVTV2Fw8HJIUgCkSReLalNR7K07xsYwzrsM6o829d7VcHQHa7nK4o46PjA9Nh3qhNWWuBMRZ36ijD8j509igN9a9ws6G8mKZaK+4JdqprqsTwKLOnAYUfQZAP1a1VDBBnvu9rh5yzTDiIH8eFWsKv0/l/coEW3GgLzNxLDdHvv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PlQUktfMIYgw5VbPGBSUkfhV4nx9a8kpMHalXxpC9s=;
 b=oCHdnK7O/N/4zrdkAo1y2iI6O/LPhX0p5V3fE4BCRn/HEbROEhlS0uey8vAuJNWooD+6DKQBDWNwg9JbhV64ar7Jtib1ps56BWOr1V/hWNEzG9XGcQxNu+pytfqTsK5CfZpnBPtzKablBha7zBs6rItnAly3K7L185kJW9WLzPZ2a0a2EWXklsbmXn3Iylrtl89SyecpFVREqhTjYshx88Cy3Fw3fLnIWc5NPxv8E3Mu0rL4YQHAAqwe/sFmqyMFMB3GUw34BxN6jbkXQe/lwE4ZeGCJMUvTReGH5JqoAicBh/OuE4euYWyra94Cv7P8epNe2+oa2y/Ik5s3Tkb0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:57:13 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:57:13 +0000
Message-ID: <2efef615-83ff-4172-a680-e02e999bfa8b@intel.com>
Date: Fri, 17 Jul 2026 17:27:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: ucsi: Correct teardown ordering in
 ucsi_init() error path
To: Andrei Kuchynski <akuchynski@chromium.org>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Jameson Thies <jthies@google.com>, "Benson
 Leung" <bleung@chromium.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pooja Katiyar
	<pooja.katiyar@intel.com>, Abhishek Pandit-Subedi
	<abhishekpandit@chromium.org>, Johan Hovold <johan@kernel.org>, Hsin-Te Yuan
	<yuanhsinte@chromium.org>, Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Jack Pham <quic_jackp@quicinc.com>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, <stable@vger.kernel.org>
References: <20260717104614.325250-1-akuchynski@chromium.org>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260717104614.325250-1-akuchynski@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cecb794-6106-489a-8b56-08dee3fa8a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: zUk9hbnEgezSc1iz49/71F1OCQHYMu48c+udViwUXKP6WZP47/7Bz4RmJH4px7PqUlpMqfHbmFi25/ie+UFRMDrgpHqLA/Ps0RDcntorbelYVKDI3iU+er7dcdhw+Yh4gtwYyR7SIFmWhaclBBQYfry8bhM5XWnB8Tmu4YPNkIPwXWB8psmXqy1bqXzx3dUHFu+2c7b3XYbD3+xmF2OT5yyHkiZfW7Px/4kPIr7+egP0Ap58LrL/b2ZatxctSsYfi+tzVpTuMps2A0PSD55IlYdj175jAx+rpvVWtj2y9VHPuxiVNZgYrt7gCVqeCgPXqeLMGXb1FOQQOkyIBpM86dspbHJx0kiWkF5lQJHs72Gd9JOXJ1hJeH48vcSEA4amS3PfGlvSkafbD8/KV9MMe5vI6Hu6FzQlgqBshcJ+JFvgPm/dASKz9XoY5o071r3TnMv9ViJTrTPP6dvjZugcabMyPRgcq2lzidrdvamhFGt1+tEpdWyfayKtzQ0OmgxWTC5fJZiQqiC4kpFlrVJChF1Pi7RmI20Bg1Oq1YgUj3w2wE49GqHSr8po9rnXs3h1k5JcRzA++wIGw6gZFheI1rOZ5RbuwIs5Wvv8lLMETMuWml/L5y9sNBRFqJ6N65TU3YKPSATqrWPfJNyNtSbbf7jXDkz7qMG4kA6UrA2oG6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlTaUMrZFJtL2h0eFNkRHpHbGkvYUtxZDlCeEdNTGhtT05CcDIvc05kWDZx?=
 =?utf-8?B?WUVQaUhzV2llZzVmWjFXZFVSbUhFNE14TWtLN0dSNnBsQlZkRWNlT0xpbXFa?=
 =?utf-8?B?SnFtTThrRitWd29idzdqMjdUZlFlTkdJVUl0Nm8zNVBKdkVwLythVlZvODBm?=
 =?utf-8?B?SE9JeEM3OGhQV2dnejBRcnljNFFncmtUVU1pZ05PS1dYSE5XWWtVQmpkTERY?=
 =?utf-8?B?NWZ3TEZMT05SN1lmMjkvNElPZkozN2IzYjhrMnZlaGVZZ1BEQXhRNWx1NHdU?=
 =?utf-8?B?SlEyUlRXVnFIMXQ2UnROQ0lhWkQxcDZXR0F1Tm83bTBDa251SkN5OFE5YVdJ?=
 =?utf-8?B?TjhGZS9VNGFOVTNIdjRyVE1Fd1lIS2Q4NzBNL1ZPeUQxQlovbEdpVHVMWVM5?=
 =?utf-8?B?MjF3U0xkWkZwQVBkdTI2a0tLVjZ4WTZJNWhVNHFYNGthMENCeXMvam9OMGpj?=
 =?utf-8?B?b0Q0QisydzlNeXB4TUFnMi9OcExpc1NiWm42VEtibktkMzdjeXk1M01UU0ti?=
 =?utf-8?B?K0wzUzg3SDhrK2FwZlVmQWc2V3Btdnp6cTA2UURRWkw3clAvT04zVmV3QWRC?=
 =?utf-8?B?R25uOGp6SXlhNE9LUENVVGREeS9tcHNtdWplUENWVGxBaGFTZGVYcm1DNFBm?=
 =?utf-8?B?NzI5NHhHTm9ieWVybHkzSDdJN2g0RS9NTUNCY3J0V1JBaFhHbFRNMkZjamhk?=
 =?utf-8?B?Z0VINm1DZVVkK256WHlUMkpMUDZrcDdSMyt5Lzl4azVLdVVWUkZoSGc0WW5w?=
 =?utf-8?B?Tzh0N2lmUHJqZm5rZTRpWnVWMFdpWHo5eGc4blNBM2FPQ2k3ZVk5U3ZiTGMz?=
 =?utf-8?B?NXpKK3p0S0phRzFlZ3oyY01Ya0tUTFhUSS9VK1k1RzhsazBCWlJMQ1pXQ0k0?=
 =?utf-8?B?dS8rdm1MTk96MTg3a1JTZzJ3L3V4YnJwdmJRblFmME1lVHQ2RytUWUFEQldB?=
 =?utf-8?B?K3ZYVGhVUitVZGdhMmRSK0o3Ty9Pam9Qbk9wbm5zMmN0VzV2MUdjV25jaExU?=
 =?utf-8?B?TDQ2cWxnTFlCSUMyc043OUdtWlczdmZhQXh1dlF0OTVuY0E3c0c3cy9DZXVz?=
 =?utf-8?B?NDVGZ244cXczdWlMQXlmRUJUWHNudkJDb3ZkR2xCNEpKclE5TjRibVJpYlhr?=
 =?utf-8?B?cDJmM2pSVlY2OG9WaTdkY0Ird1pCK2U4Q0dSTlUvUk42RTNzT2ppNUZ5LzBy?=
 =?utf-8?B?UkVHM0hLMGNiKzZMWEx0aEJRZ3h1ZzBBekk3Q0JqRldvdWcwN2NhNGx0ODYw?=
 =?utf-8?B?d3hCSUJiQUlNdnNlTXpUbUE2c0ZDc0FvL2dCQm1Sa3dtMEtjbmNkWEMyWVpi?=
 =?utf-8?B?MU9PTVNTQWlpdGZMT01DeUxEazAxRmp6dEJXY2xkR0pWaVNqNWNubjZmTWpl?=
 =?utf-8?B?QUc2MjFUZXZ4RzVDTFk1VDJleStVZEVNc2d5K2V4MjV0M2R3QUM3YVNmdkh3?=
 =?utf-8?B?c1dRU3orMnRRdDlESUVEa2IwcTN3em5xaU9QR1FZRlRmK2QxZXFmYUduc0tp?=
 =?utf-8?B?THhZeERTLy9kWUwrakdBL3BZYkJXS0tHdUFvam9aeURmeGw0ZHFROGdCZERH?=
 =?utf-8?B?cFJBeExLNEQvTzZYTkwzUGUvSWpxRlRpdXpIcHpnMEtZQnd0VzFDb281NktT?=
 =?utf-8?B?RUxTSFUxUzV5UjZIZk1CVmxrcENpK1BwU1NTWDZRMmRQOGlzcGNPTTRteTdt?=
 =?utf-8?B?cGY0ZStaenZtTXFOVE5yUkdEc2ZHaUNhWEl5c3RtQzloenA3L0ZnNTJpOHpL?=
 =?utf-8?B?Sk1QWFJsbVdyaXhtdFZ5NVErVksxU1RRSEJLY2cvb2ZFZ1EzTHlPUFgrcEhR?=
 =?utf-8?B?RzdmQTFRbDBodXVhNVN1WUhRSU14SWpvOFhoRC9BRisrVGorMHh3UFRLbDJl?=
 =?utf-8?B?K2RwQUR1YjM5YTdIbDJTZE5rSkhxWmt0dFJZajQ1TEQwRzlIZnFJY2JabERB?=
 =?utf-8?B?Qm9GS1ArWkFKc2NhN3RiUkp2a1k0bGt1WURUL2tBR2p6aW5PZTVLYmplYTBF?=
 =?utf-8?B?QWdCMUNmWDFUeHFxYmwxcDRaZEtYM2hLbEpvTTlWQVFJTnJDalo3MzhIU1JM?=
 =?utf-8?B?NnkwUTBUUG8waWNTaUN5RFh2YlhUR3VxbGhnQ3BId1ZyTUxoS1FONDdkbXd0?=
 =?utf-8?B?dFBndzlIV0hhMzUxWlc3cjFlUld5S3NkcVBOTEFicFlIeUpwK0VFa01Za3dN?=
 =?utf-8?B?dWxIK0RpMDZaNnNvSFRadUFQcVNCZlFEMzM4dTJ4ay83eW8wenMzR3VuTXpM?=
 =?utf-8?B?QnVISWhjRzJaQUJhSU1aVXJ6T2I1bWFLNGhKSklKZCtRb3NWVVhKYmJad05J?=
 =?utf-8?B?bDBRMk1HV2oyWnBheUFWa1oxL2NnVXBML29nZWZsTVJMd3IxS0pWSVZvRnZ3?=
 =?utf-8?Q?g5JQWlPlR1c3aFgM=3D?=
X-Exchange-RoutingPolicyChecked: SVGSMM2YmfqAlnjRK8LT7aSvLN4OHvLW5N4Ksy75HqdJrNWl/e4P1i22VSHBAbkoE9h69JLeZ8k9dBDi0NDklHcEBbsgDLYwHuz1L7Skzbtk9qzdV2dcjz6Qo48N+gANrJJBa7qpVhr9lfS2dzMH1t4XJIcQaoG7nJVeXVDv2tQQG8/Kn9dYLMzAGNoEDashEAF257WFQBfATI7leSk8rUZcTo5Mn/58ZtABcyiU1v3NNl4UeQ6S+xAV9VV2ZNMNQI1KaUMRXlKJ+12rIFRbFtEbTraPtguyjZs+lL1Y7FSIOCx+/zD9kt0wOu/efzp9YGd1Zqz5KZGrZtNyq5kXAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cecb794-6106-489a-8b56-08dee3fa8a27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:57:13.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwKTrVNk0Ri7AK6cXJrhZTZt7VO5XDT5euANKqbElohFv7AQOl5Gn1Jb4cLQBvxei27NSMTaE8zA8EBPuYxeXWo3iSa4iH+F05IFo4tuWic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com



On 7/17/2026 4:16 PM, Andrei Kuchynski wrote:
> The commit 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and
> ordering in port unregistration") consolidated port teardown into the
> ucsi_unregister_port() helper. However, it introduced an ordering problem
> in the ucsi_init() error path.
> 
> Fix this by ensuring ucsi_unregister_port() is called before we unregister
> their corresponding lockdep keys.
> 

Feel free to use.

Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>


> Cc: stable@vger.kernel.org
> Fixes: 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and ordering in port unregistration")
> Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/all/22064276-6c56-411a-9f20-6917ceeb865f@intel.com/
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
> Changes in v2:
> - Added Reported-by tag.
> 
>   drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 1ae4224d2dfc3..49f1c53721bbd 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -2142,11 +2142,11 @@ static int ucsi_init(struct ucsi *ucsi)
>   	return 0;
>   
>   err_unregister:
> +	for (con = connector; con->port; con++)
> +		ucsi_unregister_port(con);
>   	for (i = 0; i < ucsi->cap.num_connectors; i++)
>   		lockdep_unregister_key(&connector[i].lock_key);
>   
> -	for (con = connector; con->port; con++)
> -		ucsi_unregister_port(con);
>   	kfree(connector);
>   err_reset:
>   	memset(&ucsi->cap, 0, sizeof(ucsi->cap));

