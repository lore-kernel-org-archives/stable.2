Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359437F309;
	Wed, 23 Sep 2026 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151302; cv=fail; b=btSLWTIoIYfY4jecELRApIWOYV05ljS9G+R3u6Sh+N2o7/TnIJyjVhsTbuEUS9Sx7fnWdT9ef7/ypOcW7krV2PnXJturMIuGxsMZnrnOmocimcuAcLwfaUSa/tUR8WwxlKrOn3sAWHq3D9hUKed/spElZMe1prRK/I+pjT6xSMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151302; c=relaxed/simple;
	bh=Z8NU1EZI5RGHIglJ/VWlI4EUfQgYM8p9z/3jbyRgPsY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JaLqXU8vBEQvEwv3/ojr/Cey0Vmtfr1eaRV+0IkTMFEmIlmeMskFM/5Kq6KkqI2hNMOjpOdDknlKJ55SbmTs6Q6zLpx70W/Ls6gUP4X9h3ooSwbX//6q7DU6zoXAmU8dspRiFe5ftZInFQUi6B0ANxnjUZxTQtJnT+3kyu1WG7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8F5nryu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8F5nryu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790151300; x=1821687300;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z8NU1EZI5RGHIglJ/VWlI4EUfQgYM8p9z/3jbyRgPsY=;
  b=i8F5nryuM9MYGKCZIhI/53JhUnT6+6gVUFpJjDw/qwU+CdIQVXJTaMRW
   KR2AqJb8bFF6yK1ZZVCdWoA1BbU9vXlgzboXy725qKWONUCfDEe+D52/s
   u3LQ3yLry3WKTdMPgf/0EkGctyQNZLOKT11AZJo2laJbLnuA1G2v6vErQ
   PklNyrXiavphWU5o3QFLkuNAMVeRsRungf/4RbEOoOeTpcYB2Ex+xzL2O
   J4XgsB88sbNCtMGdDInciLlnTJS7iocPwSNpt2rE1KMNIlTpfrtb134Te
   BrWryJnLezb3n7sKTQHBYFBVbVL6esgermh7PKYj8NkIoPUmRU7EhMMjs
   Q==;
X-CSE-ConnectionGUID: 7VBrFnWTRRyWKQd85h00hw==
X-CSE-MsgGUID: Qs25iNzDS4SX8UIkQD0D6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="93322435"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="93322435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:15:00 -0700
X-CSE-ConnectionGUID: cCxhshyMSVOYaf92yeG8Sg==
X-CSE-MsgGUID: dL4l/7W9RX2GkcJmfIms4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="278249418"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:15:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:14:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 01:14:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfxsK1Uycu2toXliW1MhvUb2WTVHbiEVk6FsZyNx+3v2CVJGDfWgraZcxr2bC6fleOO7P60ouQoxjZDoY9SZuHqE4vZ7Vt7ZZorSRV8+udjAkSduZsjHNoOzjRJBHy/Kv4x+ugVALfLcPKjA3OrB3ewG1zUZlq14sR6Ih+k+T70mQYuulXciveN7BQBnEmGIp3FKki+ucanF+E+g0IVuUlgJRzMniEocqPwlrMb6hDkduUScGd/9ROd7bAxunXvKkdPt7Ng3I0oE2naKjE77WLHbR4WKyqvdP3RFAUWWUGJ0LkXm4HDjfZP+D9dYb8MQmlFWALJxbjzrUtgS9inZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWorVDMTpZTXMfzWXrnQVMswep26u9l/Mxr0AG+CAUI=;
 b=xFFr+atYjCTYkQyrgn1SustBHblHI83lmtS4lhqt9GVuXZ7P6uhGheS6GC+z+ZTNrC1dPx57NCgpjFk5GGunHHDg7IpVTVNEgD98pwGngyI2245MJr6be4glslFleINQqiImYPr/IC1TKo3cecMk5Tqfw+mYziQz2y/ru9Hs0SwDgMZTWDf9ejzcWIKHoo8aUslIY/JudMv41R+PVkqmQEaYt/8ftR5O2Bf3qhuaTF6RZKylgzeYeSxMELOv8wdqyvftsyBC8fjf3N0Di6KCYg/yunZY/fZvGCc1QSn14cifxbPpN0CFmT5dHYvWzI5qymGxpg8s2aloBIOOBJYwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:14:54 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 08:14:54 +0000
Message-ID: <af20eb97-2fca-4ab9-9759-90b210b34802@intel.com>
Date: Wed, 23 Sep 2026 10:14:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: SST: fix platform device leak on probe
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: <stable@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thorsten Blum
	<thorsten.blum@linux.dev>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260921073847.63505-1-lgs201920130244@gmail.com>
 <dd60ce64-4af1-479e-99d3-1787a06da882@intel.com>
 <CANUHTR9F+D1C49MLiiy5z1snyKtbBtdU1cnuhsgr0cysp+yOcQ@mail.gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CANUHTR9F+D1C49MLiiy5z1snyKtbBtdU1cnuhsgr0cysp+yOcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA3PEPF00000521.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::66b) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|PH8PR11MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: d4989c58-b745-442f-9540-08df194abf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BWEpmKE0SXJ+j0uJoKJ60k5s8EU8w93bLDISd+8Sq4pl+QCA+KyEUAmrsNP2wg8SeGeplIMUc1/HBvX0I9a4IOBG4MkdVMRYHEFtz4/K1IUqGv9aMs4isDl8LfpkRsMUUViXc7OJRa9496vMUboUZ69bwuDY2glOm1RPO0QZzdzOE/0nNj7eq4NGpijI4X6Fnqba9Vqw3vPQjFsU5vJek25txWJvR+7wXOMm8/3fnSmzUpFJu6cTkRQKU3y7YV8isEJ6EyH7N3/qq7vCNLZmaEIHGJS+yK5vuLKTxyJxYooNcQrIwSiogQM37rvrHnVywZ+R8M1laT3pf3KipgR+XfVYfhEVQq10Hj5Z8mmMmMQ/mTHi9neFVugb503Bhbf5S33+rYRYP8+Ykg6M3/q2G1N7IJdZkbJb7ikUNYGzURHjYhPWbccZhKdAJKRD+G+numWVYMdqJ5jGGmWmAVRQOSZsPmYiFa7e6dFk6RJP5xE8zCUW5RgwSxGvhEci/mEoze5JsaC/6exVHUDpJripenAoLNe3KGvUumFlYmUU7NH32fxwvYBap2TGWzQPjLdfF53Qs1qpjyiwy8fI/c5JgSJPR5sYOaHrMBIpmiwAVUuRMlT54jWAhkW0oDQDqL6MCakYjXywWV0M8a6VOUiVcJTk6tUrTjJ534aDuWnejAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFocCswMFRBZzNyRFdBejVlanNzVDdPWm1WSGk5NHVsTU14VjNDSVJjZHc5?=
 =?utf-8?B?dlNpekVlaWYzblVVQTVkSXVCTHlKYnVXdFkxSS9LcURnaE5STjFLaTY1WVhT?=
 =?utf-8?B?a3U1SStXYk5tY21vcFhVZG9SQklVM2ZCSHpSMFZjc1FoWEJwMFZxaTQrS1NN?=
 =?utf-8?B?akFjYzcxTEtOS3lqVlNRWFNaVUFJQlQ4ZUZGUnBCRDV6ekd4TXpPZjkvUVlI?=
 =?utf-8?B?R1VEb3BzTURmR3RuQ29IKy9WZmNFOFFsb041NWpvWnB3K2JoYlVZYmhOMUFO?=
 =?utf-8?B?bVI3NlUreXg0ZEdkcy9JYWMrUVBOaWdVbGp2dEg2djlpMm4rMzdzd2M2L3RB?=
 =?utf-8?B?dVRKU3UyaU5MbGEySDRlTFU4RXBYNng2cCtrRU9QRE16NUUvUGpvdjlHWlpj?=
 =?utf-8?B?em5rZVlJR3BXZERRMFZLRDBiZEF0djBJSDRrbHJ2Z0E4c0pyY0JDeGRzSUdo?=
 =?utf-8?B?S2o0KzlhSDBPamtLdXFZRWNmNUdwQVlHemtObjJnWXBrd2xZU1gydzJ1MzVv?=
 =?utf-8?B?cXVWZ3B4b2VRL0FrWFA3Vkd0amF2d1VHNzIxdlZYZVJYUU9LK01pejZuaXBJ?=
 =?utf-8?B?MFhCWTFZbVBkQ0xOS2gzYW05ZTFwdHZsNUtYNDhJL240QStmMyswMXUxZ0Fs?=
 =?utf-8?B?MFlrMG9DY0JTSE1TTmplOFFSSk9mVG1SUVA0bG1DSkltMnRrK0l0aU5RZDFE?=
 =?utf-8?B?blVCU1k2UGRKTUdOUlpJQzM4V096dDZ0MjVvKy83dUt3clU5R2RmdXpGY05H?=
 =?utf-8?B?YUh4QUVBVnBWcUlpZWFlTVlJUmhuam9YTkJVdFNLRFVhdVJ4VGlpenExVnhx?=
 =?utf-8?B?eWlBWTE0SXo1dHNXcktYcWthNVZtSG9RWnNOb2dwYmdqem91MUFLc2RpblNG?=
 =?utf-8?B?OS9TL09JNTlkOHBXTG5yWm0rVEI2T1RSWHZRenBCbWU4Rm5ISjdXSWxTTFg0?=
 =?utf-8?B?R2pjOUdaQk83V2pmYjN4aXJnQnN5Yk96cjFUVzZCVXM3d3c2RzhoRTNxd0Qy?=
 =?utf-8?B?dXV2R1p2MWh1Q1J2OVp0b3p2Yy9oMXZMNFQ0OXNsUzZqajJ4MEgzNVcvN211?=
 =?utf-8?B?MHFvRmZlU0VXTXBvdGMvcnNUVVNiWW5GYk9MejU4dzl5OWV5eEk4NmR6cDNX?=
 =?utf-8?B?YzRDZVBnaHM1Y3JFOTRxTlhsOWZBR2ZHa1F1dlFKVk9Banc3WnlMWHpyT1pP?=
 =?utf-8?B?bDcyRUlqN3dmZVJPZWxFODQxaW5XdVdoblp5YkFqQVRISWk1ajQybGdJOGRa?=
 =?utf-8?B?U1BuQUo2RExzMEFwZCtnZzVkUFJwK3RNR0liemF0WGd3ZlR4MHpQcU5Qa1Jo?=
 =?utf-8?B?bURFN2FqeGpBdnpuaWU5WDFnemJTWUVKZnlUSGJTbEI5UjZpWGIrMnBZM0wv?=
 =?utf-8?B?NHRJak0wRVV6c3piYkdLSWNoc1pkdTd1ZndBb2NqM1hNSjdpa0Nzd0xYRnVB?=
 =?utf-8?B?M1FQbWhCZGJ4aG9aL0tYMTJLNi91VEdSR1pvNUNmeUh6bkZWTS96Yk5YeXhq?=
 =?utf-8?B?UzBDMUlkZVlXMUtCWUdRN3NNVTRRdW9TcGpYRnpnMDN3ZU8waXdELzVyelNF?=
 =?utf-8?B?Zjk0b1pyWCtLM2dVMEZNSjU2Lzd3SWpvbUtwWkZMalZleW9teDNGN1pmOVdm?=
 =?utf-8?B?T2FHUW5ybmxJbXJ6Qy95NHB3RkYxSjVHckZHZW5ncFhWa1JYNnVBT2huM1h6?=
 =?utf-8?B?dHBTdG1oQWVxdWJlZTBVa2M2Qmk0V25VdmVSbTcvWmxQaU8wdVVmYjc3NkJV?=
 =?utf-8?B?TWhIcFFEY2c4bkY4SEcxTkVva1RlY0lmWkQvUDlrbE5LQXFzV25uSmU4VnA3?=
 =?utf-8?B?R2x3dWd5TW5qSkZDQ0x6U0JCRnlxS2ZuMmhKc2plbzFaM3pqNUVNVmk2UU81?=
 =?utf-8?B?VFVha2F3WXJSZmJxeHRBZExFUHRhdHFLSlhmdlR3T20xZGRJanZDT1VYUWh3?=
 =?utf-8?B?NXRTNVJaZzczeEpSWjZQTEI5aDhNTWJsaDJiSkJ4MEZJMHJ5Umw2eDFZVDdL?=
 =?utf-8?B?cnlTWmJmYi85TDhEa0gwNDRUS1BOdzJReHV6NGYzTzZUTkN5SkZ1TmVhekpz?=
 =?utf-8?B?cFVSenZrQVZqS3FteGYzUjBMZEZQS2t3dEkvT3BHMHhzamVKUUh1NmUvUSs0?=
 =?utf-8?B?TmhCaGpvbWNIOGlxaDFidEVCZkcvLzZlUnBxZ0lYWG5PS3ZqNnErS2RMOTFP?=
 =?utf-8?B?ampVN1YxQ3diNU4wdUxEWmxpUWNWbWNJV1lTSEFzenliZWhucmdCTnN2VnZr?=
 =?utf-8?B?azlKbVllakNEa3hoZ3ptRFViTXZMUDIyeU8wS3FycXBzL3pObjJBZkNEUUlj?=
 =?utf-8?B?SWF2R2lKMzNLc3JTQWRMVFIxdFRCSlZzZk1CN0xPdnhKY01BdVNzTDB2ZUo5?=
 =?utf-8?Q?C/axygACT+GQHVio=3D?=
X-Exchange-RoutingPolicyChecked: ybPEpnr6mZUhJbVAX1c6G1HsFUmXPoIDoteq0OwfRWhrsse3+fSgOnF8QclZcE30A3o2vuiCRZeSCatlFOkuzE5ij/Tqufa+qRzgvsf1Y5hYKzqkGARhOv1XjN1sAUmF1zknWxdcmqNgipUHL3bmV8N5AJtcEJtJwemPPz1SVvMhZeS7dnbzbWwrysNdEGuHKd+Hs0AYkLbgDnO1MvWhJeBEbltbfbb0IysjCbO2xS3wxK/cIwPY0PhXw5TsbD9rXm7P1aEez9PhGHwLSBk5Pt+Iz+q4WNeSZD9d78eitsM4ZeVeO1PDNm+qnMWuhBdUld822fUDMkFOYVWOcFMTpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4989c58-b745-442f-9540-08df194abf19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:14:53.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJP4EkgminRFagllISRUB2xbIS8n58djMgZLrWaHwHeKO3qeXpwyFymrPpkOemaGlWDYTEvRQjE8Q67bRETQQY3/bN+QSQvNxVRbVcpuPf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
X-OriginatorOrg: intel.com

On 9/22/2026 10:17 AM, Guangshuo Li wrote:
> Hi Czarek,
> 
> Thanks for the review.

>>> @@ -361,15 +362,21 @@ static int sst_acpi_probe(struct platform_device *pdev)
>>>
>>>       ret = sst_platform_get_resources(ctx);
>>>       if (ret)
>>> -             return ret;
>>> +             goto err_unregister_mdev;
>>>
>>>       ret = sst_context_init(ctx);
>>>       if (ret < 0)
>>> -             return ret;
>>> +             goto err_unregister_mdev;
>>>
>>>       sst_configure_runtime_pm(ctx);
>>>       platform_set_drvdata(pdev, ctx);
>>>       return ret;
>>> +
>>> +err_unregister_mdev:
>>> +     platform_device_unregister(mdev);
>>> +err_unregister_plat_dev:
>>> +     platform_device_unregister(plat_dev);
>>> +     return ret;
>>>  }
>>
>> Looks like sst_acpi_remove() does not unregister the devices either.
>> That could be fixed by enlisting devm_add_action_or_reset() in
>> sst_acpi_probe() without altering sst_acpi_remove() at all.
>>
>> Would you mind sending a separate patch updating the function so both
>> the error path and the driver-unload clean up the device objects?
>>
>>
>> Kind regards,
>> Czarek
> 
> I'll update the title to:
> 
> ASoC: Intel: atom: Fix platform device leak on probe failure
> 
> and trim the commit message as suggested, including the
> s/machine drivers/machine board/ change. I'll also add your Reviewed-by.
> 
> For the separate cleanup patch, do you mean something like this?
> 
> +static void sst_unregister_platform_device(void *data)
> +{
> +        platform_device_unregister(data);
> +}
> +
>         plat_dev = platform_device_register_data(...);
>         if (IS_ERR(plat_dev))
>                 return PTR_ERR(plat_dev);
> +
> +       ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
> +                                      plat_dev);
> +       if (ret)
> +               return ret;
> 
>         ...
> 
>         mdev = platform_device_register_data(...);
>         if (IS_ERR(mdev))
>                 return PTR_ERR(mdev);
> +
> +       ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
> +                                      mdev);
> +       if (ret)
> +               return ret;
> 
> This would let devres clean up both devices on later probe failure and on
> driver unload, so the explicit unregister error paths from the first patch
> would no longer be needed after this patch.
> 
> Would this be what you had in mind? If so, I'll follow Krzysztof's
> suggestion, organize the related changes into a proper patch series,
> and send a two-patch v2.

I do not mind either approach. There are two problems here:
	1) leak on probe() failure
	2) leak on driver remove()

So, two patches-approach IMHO is perfectly fine. And yes, enlisting
devm_add_action_or_reset() closes both 1) and 2) in one go.

Kind regards,
Czarek
