Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793092165;
	b=ZWoC2KmYuSF+jkE5Kz5Qcd3o7EpyML8DlyMc2XoTrRKWXG+N1nIVGQ8gxyyIx9J0GkDb
	 sf1+VHHNErXjmgJeMiTYmfA9mbNRg/KCi3HokrSLBYj8eckfNnI/6JwdZMVdmmjl6F6v1
	 cQQ3wM5fZxDD8Ubaeqk6qmi7ZI/1WwtUhAm/B/qb2a+3X1OTh3hvCSDOaY2qL7YSJBcsE
	 bLinoGQV8ikLx7JGwbXX1KR3Vz+WzJx+Emo1X08AeeQoekeYzW+NT+c4WnOaZS6FCnBL9
	 9uV3mY6bMoA3JGQ5w3lVXHuLddZ45uuFsxcJ+0X5o3Zzo9NCRVLpdZofbuz+zM4gVDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=E29fL+G5Q66sWKzCrIz5QbuktkmdjvwrjUDSDYXabXQ=;
	b=b15ffH8n6Wdt7i04jTgkJ8I+CfYC7qgfZsI3qjrOxD3IOfiDuofjAYmkS0ACGrx8NOh9
	 W0kYOIgHbHmzH7geRC8CA+RNtcNnclrQp8idqM52PY5+JEouxety3X2/N4P5BPQRzoblh
	 wRUQd8LKYmKZsqtM1Gk59GvZngGYyqzkvw1ONdY5kDn/FFPfCJHBaXQRagX20FYfdwLox
	 Qv7DjNRXY9aQtmdtitRJLggbJWDsBRLhJ885v+fcAUNNRq1IK/vC//0FY8p31RSppwiVI
	 8ZDwsKiOCIBn2ntpO/GW530pxcC2aEcdhrOgUeImMTuCySmr70a9LdiZ9ptmgE3iMug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FmlAkLQz;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0174606A31B;
	Tue, 27 Oct 2026 09:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0174606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FmlAkLQz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793092164; x=1824628164;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tdq/jB3bKiNqrpHLKtLGz5YQVJ1wTpQsaCEl2ezPqVU=;
  b=FmlAkLQz1PiltdLZSHrQ+/A2C+CAEghlbnFEd6a4RKpUdqCtlXMKGxl5
   Vfi1tnk1kyTzZ9PnmgTGo6ezuTlilU6zvKPF0Z6wRIeMd6oaTbvGIQa1n
   BsO3NuoVSRzHy3Baoi7Ya1RwOr/H8sAukupvA+ZxmOIEDklBMuVGxWH01
   30dFBaQ5W43W2ejN2voZXFEErnd9uInDb01sYKoPNH/Gg3eWitBLXya/Z
   S+pI3lUO0AWuMjbFB7CdWCv8TC6HrV3bmLc5TP+aN8Wv4a/LGXPuA5zDr
   nDAPyvDR54Z/lZ5WejAMkzioeTIuSq5P68lzzc8CQv49tD2uZPgjN/gAi
   w==;
X-CSE-ConnectionGUID: lTC30IDsSYOB0ut7ZhOl6A==
X-CSE-MsgGUID: ZZPHqOWKQW6824SFIj2lRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1876898"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1876898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 02:09:22 -0700
X-CSE-ConnectionGUID: TWFRFJVxT7K9ypF0OiPk9Q==
X-CSE-MsgGUID: uhK5yXsiTI2NFnBHkoFrwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4594753"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 02:09:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 02:09:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 02:09:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 02:09:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTKOPj0AJjN75DulwkmHGYVCNY92RkaBvxbj6NI8qxugg8uDw/DGjiqZ+CL+59IPEgfyJ6bNBR96lZ1GIdt0xpWmPhF/WxjIvrZaZcymEmLrf0yeUlTLybGmE4dsrG8RII5yXhbhbw4JI53pGBXOU05rjARJk/2Hqd7wxfZ1bJL8u8kOksVRrHLS9wWalgH6BE8r62OohZ1ig4HBJ0kKxWfe+MNtPEs9u/NFJLXNOqsb1UeL+nk8dhRqnB0QqyYO4LUdLp8hA11LdNQb2/H/gGC8JweMGyFLAvLJoJFADiktxZ7weYVniAezFawDRIUp1Jmjze32C4shMPK00dVCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E29fL+G5Q66sWKzCrIz5QbuktkmdjvwrjUDSDYXabXQ=;
 b=RAF29frhSNaQ8GTPnZDWvQtySzHW4g+cglUhKlPqYwjNLCGI0wsj335A2NeP6tWjwEfhjEGUbNxy0WU/1WgZS0IydKaKIKTg9HREWIhCSp4YOHjx0wtl8reDka8HrtQtdzKAhpTL/EStfnlGQTGCEr9VBtc0PKmfk2tAMFb64ucNrGI+fsvoXfgK4eyjGc5Vrz0CVVXvWe6GJkKgm5mqW3doMiDfGyDPbX4kuB2Js6vLmnO+WtsFVqZScqhiCq0gTgQ5LvYLOuDDNE5P6ws/H684ICBCcrjyvCUAxeuYW284nsdRVP97ZRe0qMt5SgVtDuAJ6P2cK9rjkSSpgbLqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by DS7PR11MB6224.namprd11.prod.outlook.com (2603:10b6:8:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 09:09:12 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:09:06 +0000
Message-ID: <9ef99f9d-475d-43bd-af77-f3c0b650d056@intel.com>
Date: Tue, 27 Oct 2026 10:09:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, <perex@perex.cz>,
	<tiwai@suse.com>
CC: <pierre-louis.bossart@linux.dev>, <linux-sound@vger.kernel.org>,
	<stable@vger.kernel.org>, <kai.vehmanen@linux.intel.com>
References: <20261027072835.4796-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20261027072835.4796-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008A4.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::655) To PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15)
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
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_|DS7PR11MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e486393-3ebd-4e13-b03d-08df3409f42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|261026121527099003|56012099006|11063799006|10067099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 88MW+mDCAsHhvlwFw9oMCwu+TRlIdu4E2JOZg5p28uY1rHUte4RsbzmAnIX9T6lkifNW2Jnx8E+Dw58K223ClZdzQhJvj/gtbyHX9IrnMKcp18K8VMFooKA2xngiLU87V+q68f2/FEJvKP7Ek15BPtuEXwEJAXwPKwa7zjjyhH2/NagYnohZyh7TYIGcUvX8bhs6xn80Fhgi6Yqy1PvZYRWlAYLmYxc9zT8Km2+D2FB3gd8n92MDSvfpD2ZNfGxI+7Q1NyGqWw4sVMZLOgxdBro8sIq5n4Krv8QQRxM2wHeN509Qv96aAXkTOhbpWJQr+s2AbMu/6q9ULLu7fBE96Y1CgFYmsaxC4+lVIbbzR7MBX6mRwt5skaQXMGJtE2iw11nLDsgZmWMPgsIkqhLgIg7SbDYoJd0n/EWf3ZdVT8K1iBOD4crA3AWA8XFGpTiB//5QrBlTzvO2tIr89nwdkCN/f8nUm0kYAopRhLpee7fVYGESom9DQdVmbYczB+jRHsi4zO+hUMZEhtMkQRFUN1NOCGy4jIb8O3aKHQvzwBGGsxyzW21pAipv9gtPeV5bUOrKCmR5K3clnjr7RAouxgBy3vx2RYZbMXcoCEMcRPRVhtoCFx5v/2hJopU6I6Zn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzFPU1FZcjlNYytIQWczZDVFNmlVRmJuaS9rQUROdVAwM0krbXJCM1V1VW52?=
 =?utf-8?B?a2UzZ3dLQzMrdHhoSEhWSmxIeXNQOVdGNTM1SVFGblZVRVRESjR6am01dEov?=
 =?utf-8?B?RnBTeFExaTE2cHJHeU92eDFJZWFwamozZkNxT0dtajZlRGdoeFlhMUV2RVpR?=
 =?utf-8?B?c2tNS0g5YW1JWGpuRW5raEVJYTdSUFFvZ05iVnB4bmN2MGNDSkdiMnJXZ0NN?=
 =?utf-8?B?c0hpeGhLT3B2QnZySkJ6UzJnVVBENk1jcVZYdlNoZ0NYM09ZOGlKL24vUUdU?=
 =?utf-8?B?bVNqNytEaXVqWmRCNWtacVYwQ1VRTmtaNnQ1NjA2NnZjQVNXcFJxU0JRanB0?=
 =?utf-8?B?S2tUbmhSVkt0My9NSkxkdGdHUjBUZnQ3Q0NFRHg4SWd6UkFBbCtLMUIvN1Yy?=
 =?utf-8?B?MkZZZ3A0VGtvNWRpS2wyZVpKbHFuQkUyWDJtQXk1S3p6emhXb21EbXM3cFpO?=
 =?utf-8?B?SEQzMmJMUzk0eXFHemFkL2lnMW5GV3BWaDdDTnI1VlB2ckw4OXo4aUs5dW1v?=
 =?utf-8?B?NlNCd25RT0ZCL1ZuWGJ0MEFUMnhUa0Q0cXRPQnhnMjkvb3YyNFV1d0ZzVExG?=
 =?utf-8?B?Tlp2VFd1S3FjdmJpbDE3RkVLQmFUUCtBMlZmV3hiamxsUmRLSkVjL2RyTjVn?=
 =?utf-8?B?Q0g4cnVYN2pxcHZEZm5sanMxbHlZSVM0WlZiejhwclRyUGZOdVNWVmJVR0Va?=
 =?utf-8?B?MGRXNTJyN1Y5cjZmcjJ4RUhhckRkbndzRlgxV3RUK25WRGorekZ4emM5Z0l2?=
 =?utf-8?B?a041L3BOOFhRSVpDOXBkTld2WlVzbGl3ak91bFVpYjA0aHRNRzdudGRvNWZm?=
 =?utf-8?B?OXdLRlBxOWx4cTc0em16VnVQYXFrbEJIcVZ1K0FYSitSSkVQMGJ2Nktacmgr?=
 =?utf-8?B?bHcycmdIMzk1aWRvM1dGcnpiaVFHQnFhREZrK0dPbDBTbVZBZ2kxNnUxaVpQ?=
 =?utf-8?B?S1ZnZkV2WHVVVitMbVdDbEU0TmtSN21UcG9TTFQwa2x0bGx1bU1JR1Jod0lq?=
 =?utf-8?B?RTFUeVZlTzlJaWcvenVUVFYxeXlpckRJVUhKZkd4THFjeTV4K0RjT00zZDRm?=
 =?utf-8?B?d2MwQUtvN1Z0VEtMWjBNZ2tSSnVFeG8vZTlKNW1XcXZqbk51U1NmcDRqOGJo?=
 =?utf-8?B?VDZlZmlUVWtUV296ZDBlbHlTbkpsSWhtV1FUZnhjVGxZaWR3aUdycDBIbnpM?=
 =?utf-8?B?UHZrcTJEbTBBdnhWOTliWlAyRXE0RHZjWlo5U0tuS2xrR1dzQVl1R2hDK2Rm?=
 =?utf-8?B?ZWtnWEs4TFBreTljbkVHRUxUWSt1SDdCdjJkUW0renNmYjdpNjNxQno4VDdl?=
 =?utf-8?B?Q25qNmxQQjBBNFFhT3ZMWUxnb016V2Jhdy9UMFJOVnlSanNqNkhWN3ZsVFBY?=
 =?utf-8?B?TEtIQmRkQmR1OFFhWkhwL1I3aFZEK0xpd29nOGlESVV2VmEyem9BNzhmUUVh?=
 =?utf-8?B?RTVaVG40K0EzQ3RjYjVNaHlVdFdxRzdybmJWTDlsL1ZES0pXOVhHT2hmNHBq?=
 =?utf-8?B?dVUwQ0wrd2xYUi80WTcyVkIxNXJUNXNHNVMwZ0xhWE5RRmxGb2ZndlpYdHhy?=
 =?utf-8?B?Zm1ZejRlYVp5SlRaa0F5SzBsdUlQRENQZWZIbWhjcnVSeWpZaVhUQXYzZDFT?=
 =?utf-8?B?SnhUOTRlN0d1L0k2MlBzeGdCaGx0T1pDRk5VNVZNVVJlM21rZnJaengrOU5H?=
 =?utf-8?B?bURpSGZ0Z0I0bUNKYy9qdGFXNVE3L0JGZ0FhTXpUOHNyRXdQaHh2ckhNTTl0?=
 =?utf-8?B?aFIrdVFydDYzYVpRUTRCZ0N1TkUzcjBoc0FUTmxoN0VuTGZQYitPRlJYb0sr?=
 =?utf-8?B?OGZOVUFUenZWdmd4TVhwZFhBeDdMbFBvYVdDMDVYeC9JSUR2aHZaRDAxYWhN?=
 =?utf-8?B?bFF4eURyUFJQOTdJZ2dMQXZUQkt6Z1JKSm9WZDk5TGF1T1QxUk91V014eVZo?=
 =?utf-8?B?TGhHU2dzZEsxaXQ3T0VZcVcrYXQwL0NRRWVVUk40MWVhOXVuRnkvOHVwWHBa?=
 =?utf-8?B?LzJwQXpuOFNlM1o0c1lIWXlSUUJsNXB5ZHNNLzIvVE1nbEVBV0NBMUZNODlv?=
 =?utf-8?B?Z3p2WTJyNnBxSG45R1FHQUVLTWRlMGZuZ0YyK2lQRXhGTkhGTWFBUzdkenZi?=
 =?utf-8?B?Y2FsQ0VHS3o0T0hVT1U5ZUNRSGFST0g5cEd1MnNOMUxlYXhVb3hFYU1NcjNW?=
 =?utf-8?B?NzdrbDRkdDg4Q1lqUnpyYi9XTmRjZENaZEJvZmZiSEo4WW5WSHY1WTBVVlR5?=
 =?utf-8?B?ODE0NFhNOVFERk5JN1pFMWFUS2pUYXVPbmNiZ0NVQ2NhUUczUlNDSnVmcG9X?=
 =?utf-8?B?Y1hBSWg0RFZzOHlId2JNNkNteitSWnJrUEhFSHUrN0RBRnd2OFFURm11b2Vk?=
 =?utf-8?Q?WTk75B8XWSSadYwc=3D?=
X-Exchange-RoutingPolicyChecked: av5NakfdMSjJGWWFG+tD55zOkUjHdqpSNt16e+L7J8UWjfufzYTtaJwQ2xWkFLbSgh5W7GCmVk9g7q4PyLKcvUQoEjd7E9XuUqOsTlAyLLRW7lcWeRmu0nba8Ew7/CpLuuOCaGbPxrSlGsx9JaHvlwNkKESje56UMknpFTLRDftLbQaytYNGJJRNwYsS80YuZZeLXP/DMSTAeXKzi8YN5lzG9MOsYHAFuiC4RJbhy3uN2Z7T2hOqxAWKIqElZW/PESrb7pB8+EMJv8Q5C7hT6YrWZF1RLhiC9k2fQxS+wzMaLo09IsLbiUPbM9IFWtlphZc7+GGeAKMDVrUmOYAIRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e486393-3ebd-4e13-b03d-08df3409f42e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:09:06.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnaQ3Lec8g0aboisS3vMarSKYpQJ+2eDogs4Ge5M9VcCX0UNAz7rpBdWE2KRBmx7wU40fSL9bj+osHaAMcJL8RjQxusJCmZFhSKFIIZsj3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6224
X-OriginatorOrg: intel.com

On 10/27/2026 8:28 AM, Peter Ujfalusi wrote:
> Writing to the reconfig or clear sysfs nodes of a codec handled by ASoC
> (SOF via hdac_hda, AVS via codecs/hda) hangs the writer.
> 
> snd_hda_codec_reset() sets card->shutdown and calls
> device_release_driver(). With ext_ops the driver unbind unregisters the
> ASoC component, which unbinds and frees the whole ASoC card:
> - snd_card_disconnect() returns early as card->shutdown is already set,
>   so the card's child devices are not removed and snd_card_free() waits
>   for the card release forever.
> - Even without that, freeing the card removes the codec's hwdep device,
>   which owns the sysfs node the reset was issued from, deadlocking in
>   kernfs while waiting for the active write to finish.
> 
> The legacy HDA driver keeps the card across a driver rebind, ASoC does
> not, so the reset cannot be supported there. Return -EOPNOTSUPP and skip
> the misleading "codec is being used" messages in the callers.
> 
> Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222182
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

We've had a short chat about this case and I'm grateful for the quick
resolution. Thanks you Peter!

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
