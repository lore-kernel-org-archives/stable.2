Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793991934;
	b=IPs0ZilobvLK8VveV/E7HwhLJn4RZNpdllznz9TbBZBlJnV69ZP4hu2vzcGftqXJ57Q2
	 VNO5Ekx3ds7rzyobapjXz0BqFBUUDEtFL7Jc/sBVwi2Kql4p0kP+xcE58/GhM476tIW7z
	 xM/j6KeopkRJa8N6q4oFjI2VhXiIcmKoWXdMEOXAKMQEFOAU13gCpV5RXraUSIY7G25wL
	 0M/RDQyTyF6RBlWQfNB5QvFKTTU0HcGLq0Ukz6NWGayUwDPNEG6h1oieFxeEJrBJvTYBz
	 FXrjnukr6xp/hB7jlw5vChfmHY8/OZ/4RDZH3EbOb0dWO5bD5Xww9oqomYQKXDJZkFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991934;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=2QPk5DyIsW6Z85k0wbXv8MzwSbmYWo+uKV3cilc+uME=;
	b=g4iXsNw60npwOqLupm1WtVFVSusrrwVeW1qhBwxbYAO57CJscFay8AHszHYc9CJtIemJ
	 KPgtirHtBpeEPZzHoB19PBRzrn2YJQZaPeHIg1NOIrR4B9SXcvVHQJ78rXzv4ICmjcP/v
	 HpoJI9qPP6lkn3mv0d65z0pauer7kfvZIuCgz7Jy8O4lBKLByeSY6RhDVMHewW4FtkVTK
	 bOzpqQr+N+8aw7lhi3L4QjKz3PW8sNWXayJga4SldKZmwtZcKc6dErb/timaE9BzUMKKw
	 Wa1YFXIDCBV3VNp32WREY3EOdOoIAMGoiwWOa7ZX+mdX4G02CIgF+2mvcu0mAd2oVeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QpuWHlRp;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF52606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DF52606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QpuWHlRp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793991932; x=1825527932;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8uGR83QgBUb/8qw3isVQ0VMBm2dDzFIblxlYX1KcghA=;
  b=QpuWHlRpIQy1S4taIDnTIWgxmzaw/2q59EOGQWXac6LEw0AFHHtdmGz8
   +CBk5GpPwzGio2vagHf5p8fJWwtUAgSVb32zb8CbXJPv1Wyflvw+jG4QE
   xOWtNsLRhztsbdc2as/dUxM2uxBdKb5aZBh47eCDhWz/LhvgmNIT630Rc
   j5Ns/CZSk0wD6BtsF2VLX/3Q/p417sww2L/2NqT1bI2TKm6zOkZ4jALDf
   rAA8SFibfpij/Xoh9q82y4M240+8lTyno9ZjLkbC92rXrCsrnmRFrm8J4
   3MJbVSQXlmwn8QbWW2Q5DsL2VFaP8zOipj4/dKPNT8rEsnb7pfmrB0Okw
   A==;
X-CSE-ConnectionGUID: 6eBgQnM8RHGyctXWyyyZzQ==
X-CSE-MsgGUID: atPQENpjQ72/oQuP3ajs3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2697048"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2697048"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 11:05:32 -0800
X-CSE-ConnectionGUID: pG2zCzHASDmSqezEzs1iqg==
X-CSE-MsgGUID: Bw4vSelsRd2Y417VX3eCsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9121293"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 11:05:32 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:05:31 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 11:05:31 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:05:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlQ73qAF9rtajXKZmh/Z56xtfVzqiBWa8Uoi0pIxxrA8bgsOAYBB6EwBkBOoxXYf+D/Qz5xmCK4L1sxIsb+z+DKCEIBhiNXcXy1CcfLgPd6/MFleZbUhStqZ1erVcfXlHIcg/wahYL4/h64+nTwtCGHSzT1wLp9d/0gpbuHGKd29rp8c0/OwXodtvlOJSpkt8pIgyD585F+xZP6sgRGB/elQd0fq/360nT8XQYHqOl+kLQ5Sp2tLiB0mVaXxKd/Cha1+gpsXpcXupwsqW+QOE+cTCbN+qtT+JI73dQ9sTgIzHHyqEVmOtmbfrwn+46iz6OsLALwSlCo1JborQjRNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QPk5DyIsW6Z85k0wbXv8MzwSbmYWo+uKV3cilc+uME=;
 b=njRq/FEEz8Ahxi7r1+k62exL/0jEQVq2lb/resRzN/XX2lor9iME4LokUFFGogNk12VB+7Bo+lbR+ZxRYV30wvw7e8IoeBmbtHUr1AjpEq4iRnv3biFPbdK5I0XPuXhH8ye15ZEhOi+kmSyVDQTlDNIve8WVideSkinXyXC0lvfdCGKCeKWvXUhVz53nzKToKX+Zq9wJ2LheC7Uo5qEjMWZ+kgmPRVaHVlS3FQkgdNIvll9pqhqff3yEVKxxF86+rJNkW0JA+5/7wcWQ7OBLKtIsXiEKZJ6oDWa44tCtngjq4uBu4vRtRYKFhdSXBGD+VVDMUFEDnUjXzBPTOoZAow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 19:03:58 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::53aa:3f7a:59cd:e057]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::53aa:3f7a:59cd:e057%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 19:03:57 +0000
Date: Fri, 6 Nov 2026 11:03:55 -0800
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
	<lionel.g.landwerlin@intel.com>, <jose.souza@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "Aleksander
 Czerwionka" <aleksander.czerwionka@intel.com>
Subject: Re: [PATCH] drm/xe/query: Use ordered clock reads for engine cycles
 cpu_delta
Message-ID: <au4km9yC97ZDtdST@soc-5CG1426VCC.clients.intel.com>
References: <20261102094557.2321150-2-sanjay.kumar.yadav@intel.com>
 <aut6ItIACilWOGMi@soc-5CG1426VCC.clients.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <aut6ItIACilWOGMi@soc-5CG1426VCC.clients.intel.com>
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|DM6PR11MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: fab81204-7ea2-41dc-459f-08df3c38b5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|10067099003|261022075727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|4143699003|56012099006|261021123027099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 8Ufj+7K/DLFdObwgGs9My/RTsSCc+EAaLanrSyjWuCMOvD67Wra3RoMJ59IwqypMOg0p+KEZz/D0Fxl1B2EXsMqBepxv/BQ8/PpxCA5eg/qsNQeQZ67SMCvynwwK1NFsxXtZnC3eG863Cb6MrFTVWgexD/Ps3vj72B0UHViq6hpN/HrnHow9nJ6P3GnYjckUvyvTbLrNIYOO+nn64QM2ouWwtZqCN/MJSjxFLMsfw3wH43tLBJ0ZrwuiXhpblHbmY57xXpiAjEwarai7aisuBqgYV0gKGC3HFmFLY74Da/yzqYoPq4+vkYebd+gipdC9oNgm4yanvk8ImtBd9KtXLKv8Hi9LRS11vSHrSulFbKJv29kUxvw+F5bJG9xdleZwi38dGDtofS3tGz8lrL4flbbzrxVXImd7W0gPc1nKXwFphpUcIo7R2UEglohcWnyvwndLLWsKDzRdxVh9EJSBk0kwHUmNIJmv2XGvosL1aDO1SRByGEuPIVMYsPQG2XE16ACXHW5mWIKNzG2tZJVY5FAOUPcwDDtXXf6kHyc7z7/weqH7rA3Ru4Gh7MkNP1bvv4/aDbXLvYcwxqIpsu2O+j4RVD1gHn9l9T7HmlEUWes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(10067099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(4143699003)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRUR3JqajQ3U1BXUEkrSExvMWJ5c3ZsN1gyZkxvcHJQTm9VZEU0bm9BaUha?=
 =?utf-8?B?VmtJZVl5YVFFeFVsdXdlWTRYcWttK3lvYnFvRElkdzhpT2NqQ0I2M3FudGZ3?=
 =?utf-8?B?UTZZMWJGRmhtTkFpVGxkcG92NG5qR0x5ZFhObGE3T3BzY2FPSDFTWmREQmRv?=
 =?utf-8?B?U1RnUWkvN3BpdzZMaUxRdlJ6bzNWbkx5OXpkTlg3ZlJNNXIySHc1SktiTFBm?=
 =?utf-8?B?Z0RlRXRkbHhJeTc5azE1eEI5MDlTWVFZelU1Y0RBTjJrbkd5NE53U2NWWTls?=
 =?utf-8?B?SHBZV2ZCNkVJdk85TzRvMjU3UDd4dnNpMnZJWml4bjlOaHhnTW5IM0xGMVdr?=
 =?utf-8?B?Ky9vL1IwbjBVYTM1TWxlUERrNXVVMmRUMGgyMkp6RzJDRVFGNVl5ZDN5UjVs?=
 =?utf-8?B?bGRUZ2g3L1Y3S2NNeTltRGJMcVNFenpMS091Z0M1MUZrM1o4TVlSV0hkVTBF?=
 =?utf-8?B?MWd5ZEx4bkFCS0hMZ0M1MkVLUHZQc09IS3NaV1d5N2NucXdHdWQxcXY5amx5?=
 =?utf-8?B?R2RmZmVDV3J6akROTUVXNVZBVU1pdXpxV1N5QVlFM3VTMEo4TDdWNFBvYUo2?=
 =?utf-8?B?Wk4yNzA0bEt0YkR2b2pKSDF6cHQ3aWU1d3FmTHFKdERXTXhRZnBzOWQ4V0t3?=
 =?utf-8?B?Q0lvQTl3cnh1ODIzeCtDY3ZrZFVKTkJxU1JyTmNUU1FLZHdVc0ZTYWMvMi9n?=
 =?utf-8?B?ck1TeGllRXFsVTFCc0QwMEFaZ0hRcDZIamhYbUVIRmxZZFEwVk5TU1F3dlIz?=
 =?utf-8?B?YTdvU3lxRkJYT3VqRTgzSFJMUGhjSDJ6YS9VakZIR3ZsQnNXditpd04rNTdy?=
 =?utf-8?B?T0F3U1hqTXdPajVzWTJIOTBObFBiNVhyelgrTi9lSmxSbzRoaVB3bm05YjZE?=
 =?utf-8?B?Ykh3YS9kamNIRlR0YW1wRFRKM1V6dGVLejVaa2pCck05Nzczbzh5QXkwNU4x?=
 =?utf-8?B?VS9tRzFnd2NvVXlCa3h6M09KNERYR3dzMWphQnRET2JwNnFrRGh1eE01YjA5?=
 =?utf-8?B?bWRjWmVrdnY3Mk9CV1pkNlJDaFloTEJOZWZDUWxKTzcrMUc0R0p3ZVJ1L1hH?=
 =?utf-8?B?ZGxBM2NBVXI2Y0FlTWt5bnVjSU05TmNLR2RzYjdIaDlQWlN5ZTNyaWREbWty?=
 =?utf-8?B?Mk9ybFZoa2xkL3JOZ1Q5SHRldURVLy9lakswM1h6UmNsWGFDOUw4TjRDZElk?=
 =?utf-8?B?U2JvMGJPZzFPS1daQXJBdFZiYnFtN09PTlRHNTRaRDVEblVPQ1Q4K1BPM0dl?=
 =?utf-8?B?VmZXVkZUZHhsTnhsSTZLT2luSFVEcUMvVXJaNlhSQTdmeDlpamdMOWZxVDBz?=
 =?utf-8?B?OFZHd3ZwTVJLekRHWk1yTDRWWEt4cFhxNjcza0MvdWhtbVp2eXl4MjJGU2Qr?=
 =?utf-8?B?eWtGT1ExQlVzNUhPeVl4RVgyWkRSaVFNN25Ed0lPdWxNK21UQXJaNWtRTnV4?=
 =?utf-8?B?T0M1YkZBUGVGTXQrcWZLOTNWUTRiODlNclNVL2ZTZ0UrYlA3Z243QTQ4eTZW?=
 =?utf-8?B?NE5pczhFYkF5aDYzTGs5V21rRDVHRTNSKyszcDZ5ZnNucC95K09HTEMwT1VU?=
 =?utf-8?B?dGFFQXEvbzJYQ2EwOTRIM291ckJnUWROM2duWXc3VGw4R0pscWQ2dElwOWNy?=
 =?utf-8?B?WkZNOEtDUk4zSUk4dGhkYW0wYS9iU0RUWjhVOXl3bUVhNFhPMGZKaXY4TTRN?=
 =?utf-8?B?RGlvbmVpVU00SUFVNDNvMk1WTjR4K1pCS2NmSG1NcENkcXFJQmZZU1Fidk04?=
 =?utf-8?B?cElXdHRxcW5tb0dpMFFoMTU4TVBBWm9oTWlhcHA3QnlCc0EzTURWQzI0UGdY?=
 =?utf-8?B?WWI3SFB0R1JMNkl4Y01zUVVyVnlpOTBWT0NkVkRGT1QwUVpoQW5HUVR6S3M4?=
 =?utf-8?B?ZzBsNzVhUzhzeUNKcGJja2orU0RJUTFBMHJMRDNWRWdxdXRGZ2hwSEpKdnp1?=
 =?utf-8?B?NXZ0a2UxMzdHMlFFK1BJTk5nV3g4MG9oR2ZZc2grTVdwL2RtdjY2SVNLaTVa?=
 =?utf-8?B?ekR6TjBIdFJQRDE2eEZIQlpYdEh0VTFPWEJVVnlDU0s5djVTZWZPckFPUTc4?=
 =?utf-8?B?UW1RaU12aURzMmNwWkZkOUI5MUp3ZWpLeG8vQVNCdk5ibnRMRkdSUVV4K2Rp?=
 =?utf-8?B?ZEZ2c3o2L2Q0MGc0d2dYVjRlczZ6UzViZzBvTkdxTktqMDVVR1YxcGFJMDhF?=
 =?utf-8?B?TW90VTNObEZlWnpVNmlZUVZGczAwYU5FR2xvUEdWTFh4UW5XWVRJeU1HTU1Q?=
 =?utf-8?B?dDZhRi80K0pYamIyUmxDZWp2STdhTW5IZjZubFR0M0tNM0lKVE5sR05xUGRJ?=
 =?utf-8?B?YmMwNDdmY1AxL29oTG5lZVZUWlE1YjlYZG5RcFNiMS9yYkdBSHdjczdzNVhO?=
 =?utf-8?Q?8HxEH1OHQxab7qh0=3D?=
X-Exchange-RoutingPolicyChecked: rsvL7RMaLqgv+gIWhTSuHXfmLbDXodYwLoWtE2D73hFfXUFqOUCKEAEaFG8HdVXY+w+kIZV4+84DOtZwDq7KWY3ID93kaIkyzE7j6hC8OPVranZArwqbmqcGZdiWUAxN2CwHLJ64eM29l1Uxj6d565rpBKoP8Oze7gqyU0n20VbREwZiMMkAHvQEG2VwKKMezmgTtIgs4w/zn076cq9Bz/jK/J8t7Hr/IaEe4Lu/Z63MYiwMNMJ0U26WgPp/qyf/Zb0zaVqqkOZRqCBggEXCpoFrTpWuSsBkQPvIiIjuYtCYXL2S6PdD95e8Y8Lo8urq5SlPdntI/AJuit9WF4RIzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fab81204-7ea2-41dc-459f-08df3c38b5be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:03:57.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjP2W9SZz9Ehrg8Ao9HUcgbai7zXswzccyKxCdsBD6NHVlFISa71+9il+2F2Qi/NGhVfzIY+O+U3Mu2UQLq7retAx2TvGcJYxmauVokUe24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com

On Wed, Nov 04, 2026 at 10:32:02AM -0800, Umesh Nerlige Ramappa wrote:
>On Mon, Nov 02, 2026 at 03:15:58PM +0530, Sanjay Yadav wrote:
>>cpu_delta is meant to bound the time taken to read the engine timestamp
>>register, but it is measured with local_clock(), which on x86 is a plain
>>RDTSC that is not ordered against loads. Either end of the window can
>>thus be sampled while an earlier MMIO read is still in flight.
>>
>>A reproducer looping on DRM_XE_DEVICE_QUERY_ENGINE_CYCLES on BMG reports
>>cpu_delta as low as 18 ns, while the MMIO read alone takes > 1.5 us.
>>
>>Use ktime_get_raw_ns() at both ends instead. Its clocksource read is
>>ordered (rdtsc_ordered() on x86).
>>With this, the reproducer reports min/median cpu_delta of 1567/1745 ns
>>and no short values.
>>
>>Fixes: 7793d00d1bf5 ("drm/xe: Correlate engine and cpu timestamps with better accuracy")
>>Cc: <stable@vger.kernel.org> # v6.8+
>>Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>>Cc: Matthew Brost <matthew.brost@intel.com>
>>Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>Suggested-by: Aleksander Czerwionka <aleksander.czerwionka@intel.com>
>>Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>>---
>>drivers/gpu/drm/xe/xe_query.c | 6 +++---
>>1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
>>index dc975f595368..9cc35fc83954 100644
>>--- a/drivers/gpu/drm/xe/xe_query.c
>>+++ b/drivers/gpu/drm/xe/xe_query.c
>>@@ -6,7 +6,6 @@
>>#include "xe_query.h"
>>
>>#include <linux/nospec.h>
>>-#include <linux/sched/clock.h>
>>
>>#include <drm/ttm/ttm_placement.h>
>>#include <generated/xe_wa_oob.h>
>>@@ -97,13 +96,14 @@ hwe_read_timestamp(struct xe_hw_engine *hwe, u64 *engine_ts, u64 *cpu_ts,
>>	u32 upper, lower, old_upper, loop = 0;
>>	struct xe_reg upper_reg = RING_TIMESTAMP_UDW(hwe->mmio_base),
>>		      lower_reg = RING_TIMESTAMP(hwe->mmio_base);
>>+	u64 delta_start;
>>
>>	upper = xe_mmio_read32(mmio, upper_reg);
>>	do {
>>-		*cpu_delta = local_clock();
>>+		delta_start = ktime_get_raw_ns();
>
>Using local_clock was intentional at the point this logic was 
>introduced in [1]. Adding Lionel and Jose for inputs here.

This issue seems to be breaking profiling, so we need to merge this 
asap. If we hear other concerns later, we fix it later.

Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>

Thanks,
Umesh

>
>Regards,
>Umesh
>
>[1] https://patchwork.freedesktop.org/patch/422843/?series=87552&rev=2
>>		*cpu_ts = cpu_clock();
>>		lower = xe_mmio_read32(mmio, lower_reg);
>>-		*cpu_delta = local_clock() - *cpu_delta;
>>+		*cpu_delta = ktime_get_raw_ns() - delta_start;
>>		old_upper = upper;
>>		upper = xe_mmio_read32(mmio, upper_reg);
>>	} while (upper != old_upper && loop++ < 2);
>>-- 
>>2.52.0
>>
