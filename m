Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038663DD520;
	Mon, 27 Jul 2026 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192951; cv=fail; b=FgVCS6D2X6U6+d9/gWr50EnGCFWBqe/zhtFWp67+yizst7iEROiv+YXvJW9lY1sbMpFT+DEcKoCZByOik0F8Zq+zkJcui9QR0yzcT+frLK81ZZ5gqGbfPhN3+BzEJco5YRB0PlMnFz/MDZcPGgR9P77veL4x89aWxwylfACLqws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192951; c=relaxed/simple;
	bh=y3SxVW5ymrqGvng16KFocMOc71dWRc1wdcwCDTIacto=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tGrYDgHZZIY73ljbP+Q8JzIaVSZ3ZzeIdkSVWgNndLU3L1TbL2JU+UgJbZ0GnEG01BiMuI1oSsFW+6vtr02sXHS+V0xSolxiCx6RtX8T0UeGgnl2nytYvhJcEQUrC5Bo24762bM2VdYKpAn3VWqsvHkb+ZSk+YxhL/XEZjuiT8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkQlHsrx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkQlHsrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192949; x=1816728949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y3SxVW5ymrqGvng16KFocMOc71dWRc1wdcwCDTIacto=;
  b=WkQlHsrxwSzptQ2euSAoUegltVmWW1RzCoc7b9B3qz62Bf8OwRq87951
   3hanoai+V0vDX/2kWEJQa41glkQ3MJYHuBWJE1lyAQZbXvKjDpe2AnSBD
   BGO2zQJ7e8nrDTwR4wx+bC5AglJaqCxGzwqAyesj0gEBOmoW/3L4tjdf9
   QqVyMb31jHrbZgUIA8fQJZq8ZHNUUpti3YiIuI0WE4Yv0XMhUbzzLx191
   T2uCeoecWAXVnzJe6TdsSI3PNZIsRb5tcq4kWrTP/KRte3NXCU98AaLn9
   eaWSKPdwpdC0+NkfNISakc3L/mv5c3AIG7iC1Vm0t+WXftVpMRRfJcEAH
   g==;
X-CSE-ConnectionGUID: jyQFOOdGS4qa/VN3y6/Rsg==
X-CSE-MsgGUID: 8/x/QYL/R6ub1/shZwq2Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89591068"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="89591068"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:34 -0700
X-CSE-ConnectionGUID: MVwU3kkfSpCPW8EOra+b5A==
X-CSE-MsgGUID: qo8zlTWFStCGdrcdlKow9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="253204072"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:55:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 15:55:33 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjAbWF9ET/jM5jkfz6t8kNsvewHcHALDQ7Wck5ttJcrip9fKSqv8LkJF/7CZ4HooD2fXJKFfW4MLx7SJZ4CZ+Q+xqXFSxU98rreh22kQIcl/5517VaCLl00hKs6vWD0o9ICapEJT778Ai4BJV/6HCOIXKqkyuYib7hnfvoWJw3QV2A/IGYzSnbftcjFlj9uBkzYYyUEIcTJxtl6pDnyLNKdLnnFjsd4BJzaz/gwhh45jnzA/95tTpgaVDH8d48nfOyFekVir3ny33USm6EoSJbF/QNsjLfm/v+N5XlF/xjRb/75JLQEyFTjRP/aDyRNnCyBvPanFFxXdLOD4nsVO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2zHktDMEFMU4bs2q2pkCV1Vxd1HTOy3GXVD1v319y4=;
 b=HlPPZM/pm5+0Z5ap2zMb5ySUMmB3s7W8VzQwa97PwzW9NWs28duYeVo1rpc8R44rrjno6B/O3SRrx5clGn/k1AwJgtN55VndtRRQdZk9v+PU9nBxdCoHLwEdlCXpiDOP9pnHSsL7a/8JpUoUJ+KcXaSQv0J0g5aAEcMEfFP/f6lclsvYJLdRGTcEOVnXjYZD5HLdHES9IuCrwSUY/K2R3UrL3vykcBkpb7hdI8KrVMCWN891x1rGVMsH/N2Abc9rWRIMEgaMnrO6uVXET96fqMLymi6ulBdeR7YqBX7wQO+j+swpfMhLw08W92D4McU1PBafpMfpZEZxfVb2l2rszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA3PR11MB8918.namprd11.prod.outlook.com (2603:10b6:208:57c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 22:55:31 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 22:55:31 +0000
Message-ID: <54804d01-9254-4482-a0be-c38c3c6177b8@intel.com>
Date: Mon, 27 Jul 2026 15:55:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] liquidio: Fix possible memory leak in
 lio_reset_queues()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, <andrew+netdev@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260727080258.86279-1-nihaal@cse.iitm.ac.in>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260727080258.86279-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA3PR11MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8e42f6-0cf7-412c-3224-08deec32291b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: E388yu3WD6omICm7ef+aSKUu+AG5Xli5+FgmkDT03mvnoyZjgRj9ysbOUMnv3UrZ8EWXowQ1wyCSldJOTARecnCWIQsOiRElHH/i7SFsjDaaYgzQ4E1x0je+LVifg3xi9EV9PjQw/46NNLgZGHxH5E4pM3Q9bCjAHXLysOyMQji4sdBgCJ285YDDplJqJeD7TMehbxiB5WTuZ1zgeDRyNEP+RJPuvSk+1impEtwx/sDgeZ5sP5gJVRJ3+2fSvnx9GLNZO83o8cByi2sgQIZreHgKMXQ84+xhSjJXCzu+xZEZZqwvpOVcIz0qUstYogcawsxzILpRN5necOoO86rh8PWYxvpIWdjJpL39NE8RwDRHnM0qEdBcN6g+BOA+XyU//I5va/jb8B8QbWPVCx4lNJwYUq6cIEZqRBKIpUnwBStddHFCSR4OS3cVR89yF+S2cJTgT/sQP4msB3V8DdwPzFtRns9+4/JQpMIJkBx4ojh6OxH8XRiG34qa21f77qofyr6UWNo3TFwqYvQLCQdbZKi0Q9UwCZkf4AFARvNmcFdoV0lLEdual11wb9m0efIYUjSkXfcVqX1v5tqjkWH6kIIHD38U1YgAYTZH0ZpaMEqlQ/ck0rPhW0Ok0y51fIdBiQWkLzi5N5JNfdN9ffdjfKkNQntJUWbKu15FEMwR9fQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtRNjlNSXhJYnUwWDkraStnczlqVG83T2VHN1VUNGx2ZGJvZmFQWm5zVHVm?=
 =?utf-8?B?M04vOWkzY2Z2TFFNTnMwNWlMU0QxV1l2N2d5SFcvU094MzM5UFI1a3MyRWFW?=
 =?utf-8?B?NUgxZEpRMC9OY2RoZU03aXNpcVlDaExGelBVOC8vNDdoR2s2R2ozbTlJQzQx?=
 =?utf-8?B?MFRxVmdPWGVZRzgxd2NSaTQzOUtvTVQzWWlyaTE4YkZxOTNxUUZKWlNzN255?=
 =?utf-8?B?VnExVURVQytIS1ZuSGU2L2g4YW54SUJEQXpnUmh0d3VlQjJVbnNaQ05QNUYy?=
 =?utf-8?B?VmJQbHAvcWtnZnJCNFZSU0VPRmxxMHZxWFhQOW4yV1BUVkE0elYvZGExTGdJ?=
 =?utf-8?B?ZHpqNHFmRURlc1I4RGsrUDZPVDdNS0hsZmphYy9rSUlCYlp4Nk0xSGJPZUtC?=
 =?utf-8?B?ZTVjWmU3blZBU094dUU5SHlSTklsZDM2bUpuVVNndlA4akZKTWx6UWZxcWkw?=
 =?utf-8?B?Wk5mOXVac0NKVkVWQ2x3YldIUlAyYWd0WWZhbXFVQmVDdGdsbWZ1MmF0Ymk1?=
 =?utf-8?B?OGZSY1J4UjhnSXgwMm1YdFFIc2wyZVpHWDRZK01Ea3BiQUFVdU80eTlDQ05V?=
 =?utf-8?B?VTJSdE94c05OM3pLWVBYWFR2T0FBZGl6d3FPOXRRMDFPVDRWd2dYVkh6cHZT?=
 =?utf-8?B?WVBzb3p1VW5OR00xUUp5NGYreWNJK0dWTlJJS3FkOHMwNnR5SFIrUjZSTTl5?=
 =?utf-8?B?SWUyK1NFZ1gra0IvQkw0c0hKaE9FMkZjRTJlOXQva1hkV0RwSGNuelF3dWhK?=
 =?utf-8?B?Nmg2S1R2Y25xdVRMVFBCZCttdS9aYnl3NXpIUUladURQclhKNHJKTkY2OG5i?=
 =?utf-8?B?L04vMUJPTzRucURncXVxVk0xREMzMTlVOVBxeE9oM2Z5UE1kZTlESTFWS3NH?=
 =?utf-8?B?b0Q2c1NQVzJLN0RRNkdwZ0RzZlRsd255aXJSaWZjS2xrVW5hY0dkbjhicmJn?=
 =?utf-8?B?L01wMHVQbkhPMU5NY3NmckhOS2tuZVMxWndoWkdTQ3BIQW4yRDVac01TWXhL?=
 =?utf-8?B?RjIwZm9wUm9kS1FGeFcremd4dS9BNUpNS1hIVUlQcGRtMmh4emRidXZKRVZH?=
 =?utf-8?B?UHlCZ2p6bzI1NVFraWpBWDdQa3ZKbzVaVktSamNEcGxZOXJhbTZIOURvL0Fj?=
 =?utf-8?B?U3AwTVVicnE4VHFEQTM0U3ppRDFQbDBSSldHWU83NlV1U3ZHMFFTVGc4U2tq?=
 =?utf-8?B?M0M1RUg0WkZRMXpmYWIyS0FEc3dCZU9hU002ajNVYU1wNnY2Yk8rRmRiUDAz?=
 =?utf-8?B?dVQ4LzZlOGRsajVoT1dsejJVcTFyQUF3d2tBMW9NenlhS21PZXJSQ1BDdEF1?=
 =?utf-8?B?YURQbTYvaE0zeXBUT0Myb1RlYmtFTDg4MlEvMW8wc2RHY1N4UzBhTGdtTUtl?=
 =?utf-8?B?Q2pJRHI1RnQ3YmlkQnVpbDNYV2Z5YzBwUTUzdUhoSHZkNnlCb0VZc1hQUW1C?=
 =?utf-8?B?UkJ1R3dZeVhFdzhmcmhjVjdENllLMEJpaGtQRTNlMmdRczhLb0R6VlRpVG4x?=
 =?utf-8?B?TFFvOTRGYnZaSnRaeW05YVlKQnRHb2lXK3ZTZVJtTkFZTlBSN0c5RVhjL0Fh?=
 =?utf-8?B?RmFpdlpDTlFjSUpXcGE2NkpUd0RzMTFnVktyZDRDOVc4OEt6K2NKcEY0cm1j?=
 =?utf-8?B?NitDRUE4eDF3aUJMUmVkeVRzQkVRV3V0OTN3YlhEa2Q2ZG9pdTRYS3V2U0o2?=
 =?utf-8?B?MzFjMlU0OTlEL2VSdWhMRHFqeDY4TEJRalBLYmlscmQxSzc4MU1HVlNmQkxB?=
 =?utf-8?B?WG83bUNJTjJmNEl1QVMzSjZqWXg2cHI1NlM1VjlYR0hXdXBrM0ZqaXd1dUpU?=
 =?utf-8?B?aVY4L0pFYWpkOHg2L1BMYW03Yk5kSlp2WnovbmlCMmU1bldhWUxCSVFwZVUy?=
 =?utf-8?B?b2phWXduNVl2aUpySzB2aWJYSmlIckthdUNRNE5oYlZvanR2SmRKSXhRY0Zu?=
 =?utf-8?B?d1VTUU5leDAyVTVEZG5SUTNwS0JrSWJOa2p3eGc2b2JSTjUxSm80cWVCMEVz?=
 =?utf-8?B?Yjh4L0V4SmVZRFdIcDBuRGVTVGR1LzBNbENFSVFQUXk3NEE4Zitqd0UwZFFp?=
 =?utf-8?B?RWxOcGM0R1lVdTlmYmJYdU9SOW9WVS9VaGcvWmJ3OENUM3haL0M2RG1WVVVy?=
 =?utf-8?B?OEhyV0lDdy9mSzhxUWxFOGlUZ1pOMXZaN1pybHF6b2pwaWp1N290OW1MbUVa?=
 =?utf-8?B?OG5PWG8zNDlScit3K2VyRjZNUTRpUXkyWHJEV1BtTHdYbGQwaXFFRVpvd1F6?=
 =?utf-8?B?a3dmRWsvZm1yalhYTlNmR1dJSFN0U0NKMmJML3VtbUgxbkVyT3ZoVVU1VGxx?=
 =?utf-8?B?N0dGQlRvaHUrRjBobkdzOHRkSnFmOHpwNXpwMC92WXJsNkN0N0U3Zz09?=
X-Exchange-RoutingPolicyChecked: aaTgluIobuWJXqsvgr4iouZ9YOSxBdkTDAlBmpszllzRV4c1hTJf9dLTQ3lfWt+3T3JJqiai7a550/5AIeiYd102eOSiMddo/p+vL5QqVi3Eu73AbAXMf/+RCqPuAasVfa2C1+/IJPO/5f3NwYITZJbn2Yul0YCjTLSXWk3r+iFjGmZYeMyww/+bn4AoeLbB7lu6VelNNXX2FlwQKBR/Yuwru3mOghWlTRcuBHiL1636yYyYc5n+TIutS+ydFbrEkeyqfXIxECaOCv0bgH3y61dKO4Pl4gz1hS3OvX3c5eiAANCTEOuNb/r7qu2RuFfseY+Vyx2sdNmI2NI/S3URxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8e42f6-0cf7-412c-3224-08deec32291b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 22:55:31.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTBB5QOyLaxLUL4UQ3I7LdzVQkHjZjzmZa9XSOJbOu48xI/yjMqEG5UaicZ+/YKx+W6fCdGPm32WWd0GIBkm8wJdBFQlqd8z0B534U3Poig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8918
X-OriginatorOrg: intel.com

On 7/27/2026 1:02 AM, Abdun Nihaal wrote:
> The memory allocated in lio_setup_glists() and setup_rx_oom_poll_fn() is
> not freed in some of the error paths in lio_reset_queues().
> Fix that by adding the corresponding free functions to the error paths.
> 
> Fixes: 4b6e326b2d34 ("liquidio: Per queue oom work queue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 

Would be nice if we had a reproduction but I suspect this is tricky to
do without some kind of fault injection.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> index c849e2c871a9..222ef0b661da 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> @@ -1242,15 +1242,20 @@ static int lio_reset_queues(struct net_device *netdev, uint32_t num_qs)
>  
>  		if (setup_rx_oom_poll_fn(netdev)) {
>  			dev_err(&oct->pci_dev->dev, "lio_setup_rx_oom_poll_fn failed\n");
> +			lio_delete_glists(lio);
>  			return 1;
>  		}
>  
>  		/* Send firmware the information about new number of queues
>  		 * if the interface is a VF or a PF that is SRIOV enabled.
>  		 */
> -		if (oct->sriov_info.sriov_enabled || OCTEON_CN23XX_VF(oct))
> -			if (lio_send_queue_count_update(netdev, num_qs))
> +		if (oct->sriov_info.sriov_enabled || OCTEON_CN23XX_VF(oct)) {
> +			if (lio_send_queue_count_update(netdev, num_qs)) {
> +				cleanup_rx_oom_poll_fn(netdev);
> +				lio_delete_glists(lio);
>  				return -1;
> +			}
> +		}
>  	}
>  
>  	return 0;

