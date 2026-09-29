Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57381322B9F;
	Tue, 29 Sep 2026 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705469; cv=fail; b=bVCdTyEFNXexz5cXf35Ndh5JkqSTFhQzc7GO761u4rsL4uVIHgFcKAB87r5a8QrmItQqWhKYDxkHz5IsEjMVfl7M5YaAm7sJan7TctdtYaXC04HzziSRlprWUQVWdgJZz46p3m9bMciZ65H5RyyJGVPYzF9zZ4fZJfoBE0RKB5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705469; c=relaxed/simple;
	bh=tL0c7GPTj7dBl7wwbYlRD0Jsn1jnHM2ARr1vlZGeNdQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBICa/qrjJzJer1Wu1ej2vYwddPCdiByddEcrWvjhyVG0vglFaY/Nb4CPbMd/EJ2K8XndsgD35um4wYx0yyFw3aBNH3IK1W76/l52j/63N/HiFl36+Iv/KUjKMjR8uJPsxPKraiVfYUkvAwvqIa4ouZIONlKxrjI8bKcNq0n6gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9HyCT+g; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9HyCT+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790705467; x=1822241467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tL0c7GPTj7dBl7wwbYlRD0Jsn1jnHM2ARr1vlZGeNdQ=;
  b=n9HyCT+g/N5AIvrMlrBXjJr/Vvfm6QMESN4uDwpbvkoFAYzCE+kwF10r
   t2QJVpTZtSsCXX37EofZ2EXA8y5AbwiRbcspty6+DPr/J5u+TH2DXiQTZ
   MEdTd7nfQnI4ze2VgLPz4xeu0c4m7bsCLeqnsX905puor+3pXxdNI2NJp
   +mX6NkgEzwGDN/kfcsLVY1iwK6qgB3SnJzCvc3NygHPwUSipEQa3IWYr3
   fHNxgG2P7rDLClIsGqwe+x9pJdj++r8WB42NteYXb9xaXimXdFoe70G0x
   K1VvcLohi8l/lqeBJz+durK5SXepJ3PU7oYyQfRlv8GzO+ZqWPSBCKrhn
   Q==;
X-CSE-ConnectionGUID: C/HZAgjSTd22fyPS8bTH2w==
X-CSE-MsgGUID: RcY7MKhsS/27WZnjPk6iAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90331430"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90331430"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:11:06 -0700
X-CSE-ConnectionGUID: 7zqWG0laRwOsB+VFjD5rgQ==
X-CSE-MsgGUID: jLKAs1YIQ0+i/2v0UODwhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280200294"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:11:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 11:11:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 11:11:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 11:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHH1T7q5jWkPvrBVnZNgc0TlgGNd+y5giTswLlFC9XAkjcPsIM+libpWOjbKxMz8UAZuVqV8iyJ0cHSyxcLBNvaZ4tHon6o42Od0zezMedjRI/80D0M8izyFA58PRQxkzf0s4Z1nuiUsGY9pbQF3/Qo41g0Zcpnp7NnjRiVUD2POU3C68zfslDO9r7CVSD3J2n9YY5D8z0kE1wAuE1Hngal0x0J6/q/tbvjiHxFf0ejbNxft9bPFea71x91UXhkd6vMRai2ywDFZ9nPsDLycuHDDYucV90yxw30FCNIEiM1/nMrHeJ4md5AculMOuDfocehPVNb6PIQzAYLw47BbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRt2rzThKfNjz3h3AQbcxaaAAgYMLamJGnIlhto2xMc=;
 b=wcx6X42Hv1KQDl+X/GAIXvlPcB6bsdiiNX8GPEm/Bv+BN/hz1MUwQMJczIwqjQZXbAjklM2UnnBQsz9FChzqJvcsVdkkR6DtQ5Zd7eiOtd6wC/tMD+dhP2+3NguLDEbHPQCLBb2SbV6URpku8RioK5HjU8N75ju7xFQdssawitNd1B/ZJCBBFCzxHHLXibHaUO7cKVr2kwDiXrkqVKQvqBOsnWzWOMsCTlmpyx5jQ/0awz/5f62N+Tlqi/umIMbU4SyRBkccHqNDDvUEaCsL+vLb0Oz0F2f6XMprEsStcS3ktEkzU/+wIgndu81bKzQ5ielT372EjOhRIe0ciT2Fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 18:11:03 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:11:02 +0000
Message-ID: <547ed917-77fc-4670-974c-4d4fd6fbf3e7@intel.com>
Date: Tue, 29 Sep 2026 11:11:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: Linkui Xiao <xiaolinkui@126.com>, <netdev-bot+sinfo@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>, <stable@vger.kernel.org>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <179057875290.31693.7249107578001642813@kernel.org>
 <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 6827bf87-f913-41d5-d8db-08df1e5505c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|6133799003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: rm2STdpYaGNK/LvyuDz0hyoVJomKKq5J5Odet7KLoNglYXB8NH8yGHCCMCh1hOFjDfuKPDQo7Q6Ck5CLQ/ZFx62i0Tbdgv47GUjnPuPTW4wxj5wzWvhUFb4ijg3ZZySwTEtiUtbrH9cCpqCmtT9iHtRrLy+CsW1Rhs0RG8nHSshV4/UTIKrl0foMrlQ72KR/GYE3pooW0PrBL2vvxgPjRVpk+jf43H8KEO6p7NZeSBbY35zN9EBjEzR7gyKXkQ+PLBXFe5JVKa1vU+pz20KFAodQkQhi84s1ZEoNKrB63nXBg2AiZ3t0fGUkt5MboUXgegodFyt10nQ00ujlxOB7BLFChHgRV2SElQgUmyb2a8nVEsNYRRLrEEZYGv2hqqWBAhFnooeVmhEvL0RzkfTuXJVxk19EfTPYBhhsTOBK5uMybAPSvNma2Lp8jFG3tq6vKOi7IJALnbc9Z9erN4x0nKY4RZjaIvPcHwolhhOvSFXX7KlryajxFoFyO35U3THa6aMan3bp3r/0ao4/qvPJyhXoqALKOJ0AYIH47pF4FoXkZA83hCWA/0nJlUklesqRlZ8mpl62QrUhZg548oZGWUyocWhwmQydQtnyoNa7vc73Y+q2hQuQ81VLvlb2IK3dehvg37N80A2pNaSungHwcRA4+PcmadwzO1z27LpDpVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBUc2FVSmE1Uk9xc2NDRjFnMndQQktKM1Vpb0d3b04vbTVrM2lJS0d6QjNi?=
 =?utf-8?B?NzNRb0VseVVBQXJQMUVCMFVDZndlVzlCNlAzYVhDS1NuWVhSTk9RZFlOVVNm?=
 =?utf-8?B?aDBMd1RJV3g5NkRadVozdXFweWhvMEFYTlBlNWQ5dENBbHBmUEhRYlFpSjc3?=
 =?utf-8?B?UDhwVHQxZEhYcEkycWU5dmxpN0I0dVFlSS92WDVPdkUyTEZGWk5seWx5Q1ps?=
 =?utf-8?B?Mlptdm9HTkR5cG8rTVVJN2tJcGg5TzNIMG0xL3l1YTZRVkpBOXc2MGZWWTlG?=
 =?utf-8?B?bXR4TDZzbUl4eFdTOEZ1SGt3R0FrOE5OcnljVVMzaW9LZ0NINTFzajRBMUR5?=
 =?utf-8?B?NFBtd3o5YWlkRHNQTjBRTHVjdlhVNkRoWDVMbVdnUWlpNHV2azlqQjI5amlY?=
 =?utf-8?B?ekxQZmQ3OWtMbmxzbk5Ba1RLL01KbExCUU1KendQdlNGRHArUXdNaHowWWhq?=
 =?utf-8?B?cDJXSk10Vm1IbzRPY2V3QzBUUGtncHBtWDluMUZvOHVrNEd1RVQ3bC9NVkVQ?=
 =?utf-8?B?SDVMQ05iR3ZYbzhQdjNyazJGQzRpOHlaai9QY0YwTSsra3ByRXRkVjl1bnhi?=
 =?utf-8?B?Umd1US9rc3lWcEdzYWRNTEc1OUlEdXpSZDcvZkIxSTZndHFuOXlXS21jMXdt?=
 =?utf-8?B?TE9ZV21VbERaTEVMZnVzQW5kZDNnM1diRi9OTDdDZDBhSk9MYmx6aUhsN2xD?=
 =?utf-8?B?Q2RlM2tiMTJqTWxuTWJSQTQvMWtwdDd2YnI2aENJcjV6UTkzdThmMC9pZ3By?=
 =?utf-8?B?b00zS2FjVDFNQnlIVGJ0Kzhac3lHcnMyTHJjbDBVbmJWRjVnUzFveFFBb09W?=
 =?utf-8?B?WmxWN2ZtOHlUaHNxcHA0ZElxVmN1NzYwTTI2UzAzWERhdlZxZFJiNTNvRDhu?=
 =?utf-8?B?cisvWmIzU1ZOUzk2Y2szR1lJS3lPeDhoR3c2M2dJQzd1dm1mSEtzNW1GK0dC?=
 =?utf-8?B?aHdMOHpJalRyWUdqQ3VqRU1jTDN5VE01UE82QVVyM3dBOHVKZlo3KzdpRnBB?=
 =?utf-8?B?YVN2WWZUa0k2U3M5ZmZURVB4bkVQenNiSTUzNzlMTHUyazdTT2U2TzRGcW5Z?=
 =?utf-8?B?NGFUK2pmR3dwRFdrcHE0eW94Y2l2WXJSY2VVVUtPbGRObWhZZE1RcTJMNGFy?=
 =?utf-8?B?OUQ1U080UjRiLzgwTUx0L0FkOWxzeDBvbkcxVERUbzhGOWk2blRVcnIrSDRz?=
 =?utf-8?B?ZGpZbmRUWEIyekI5dnlxMXNQVU9HOXBMazd4clBScFhTQ0lQbHoydVArQ1ZL?=
 =?utf-8?B?anRibzFla0xacDEvemk4NWljbVhIRGZPMCtZM05KSGorZHQxZTFJYjlLcGlW?=
 =?utf-8?B?dXpHQUJpclFJbHFtb0JOWmFmL2F2RTkrNElJRDRjbnZDaGpyTU0wUzJPdDBy?=
 =?utf-8?B?ZU04NEd0MFM4bngzWGpVelNnVTJvOER5ZDVKQkhLNzNsL2RwYzY5SFpibUhZ?=
 =?utf-8?B?dWZxaWdMNHoyYVgybGVoRjVBT0xybjZkZTgvZ3hwVStzanRvZys0Z0Zoa1Vr?=
 =?utf-8?B?Q1FnaHBqdmIyMWRWdC9RVmhFT1J4MzBoVmtGcklNclRaVXlndXp0ZHNLdWFQ?=
 =?utf-8?B?VDVDZEROMmdOK2tWYjZnZDJNbGtuRVBPaTdRdDVuRkl4OWM0Vm1jNVQ0YVd0?=
 =?utf-8?B?eVdCRGFMNm0wT0xOWnhuTndyKzlYNmNnN2xhd1kzdXZNYlVpbG5mSlN5UVhW?=
 =?utf-8?B?bmxKeW15K1o0MkdSWVRMTkpaRWMyNVg1TVlQZktlS1gyaDdDMWM5em5FUWY4?=
 =?utf-8?B?VHQ0THg4d05COFBuUUFtTVVqVmJkM3pZYzJLWFlIR252TEQxdWtuQjVkZitj?=
 =?utf-8?B?eVhSdmRwWS8xeXdxeVEzcTU4eG9aV2JXQkdoRm9pTzAxZUhjNE9XNC9Jc3Fa?=
 =?utf-8?B?dTlvZzRDR0NCMTVZTXZ3dkdFWWFQQ0N6blExS1NWU3BWNkdYcHRWNi9wTDdu?=
 =?utf-8?B?YUVMSnlLOFUrMjZVNHFoT3RCbklmaFZwaWVvaXBFM1hONUdwYzl3d3Z5dENE?=
 =?utf-8?B?SnkybWRLRE0zZkNkQnl6RDFkK0duSVF2UVpyNFZYK2hBSjZQK3Jaa1I0c0VX?=
 =?utf-8?B?M0psQjBBMHFXcTVRL1RLUGZjZlJmbEhybHhiRVE5aGNPOGthS1d3OUhZc1p4?=
 =?utf-8?B?aUNKd242TGdrY2RpKzgxK1VIY05qWnpZRnZIcjdScHdwWVpWSEpDM05PcFIv?=
 =?utf-8?B?SVJZdFdxTlI5Unp1U2NJUEY1MXBsa3Jwc3ZEWDVobXdiU2tPWHBRNVM0bXB6?=
 =?utf-8?B?ZWhNTy9CeWlRM1FnRjFFOTJSc2p6R1ZwMk1IMTFOMldJZVpSYjJhRFlQYlBt?=
 =?utf-8?B?MHg0bnhKYkRVZjBhZnVjTG9SV001R05pY1RwM00xZlVlNk5icWN0eVRWVE1O?=
 =?utf-8?Q?6UV//OiNBuENoB+8=3D?=
X-Exchange-RoutingPolicyChecked: e0sWxhBZO4VwCPOx6qbIYeIq6EPC6smlym9xawNTIXx/FXwsWX6FXtgbPwhzp1MWmxMtWOErsmnVCPuEghd/JpUsSIHIV7/9ChrnjSU5VVwZ+3jTGsEoV4qgPijLvKo5UegJlqw3rLhnLr1cl4Ye5NEbA9MSSIG8V3gnK60PB7ahSktxjE9IgwJczhfkvbLwUu34eI0ScTDWYIVnCaEc5Puq75RqXO3MecBWx8f3MVVfA61S1CLwifHUKMIHXG+tnZSDKdqhVH8qfG6gOT2gIPQCfNgnIU5B+4y22ok1UndKjvGLEZPPoMq6odkGb7b+7+ZWR3YRlbyaP6lsudSv7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6827bf87-f913-41d5-d8db-08df1e5505c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:11:02.8999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHE+1RYJId+wfibI1rRMlbvfOsME94zQ+S6Dya/PVhaKgTOYZ9N/qtW7bOWPGVF+a1d9rF4apTV00oK/5Y6dFNnSdzFbDLl8hj2o8tAQuKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com



On 9/28/2026 12:14 AM, Linkui Xiao wrote:
> Hi,
> 
> Thanks for the review. Please find the missing information below.
> 
> - How the issue was discovered:
>    Found during manual code inspection of the ice VF setup/teardown 
> error paths. It was not reported by syzbot, a static analysis tool, or 
> an LLM scan, and was not hit in production.
> 
> - Whether the issue was actually triggered:
>    Not actually triggered. It is a theoretical error-path cleanup issue 
> found by inspection; no stack trace or error message was observed.
> 
> - Hardware tested:
>    Not tested on real hardware. The change was only compile-tested; no 
> affected Intel NIC/firmware test was performed.
> 
> The same applies to patch 2/2: it was also found by the same manual code 
> inspection, was not triggered at runtime, and was only compile-tested, 
> not tested on real hardware.
> 
> If a v3 is needed for other review reasons, I will include this 
> information in the commit messages.
> 
> Thanks,
> Linkui Xiao
> 
> On 2026/9/28 14:59, netdev-bot+sinfo@kernel.org wrote:
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>   - How the issue was discovered, e.g. hit in production, hit during
>>     development, syzbot report, manual code inspection, LLM or static
>>     analysis tool scan.
>>
>>   - Whether the issue was actually triggered, or is only theoretical
>>     (e.g. found by code inspection). If it was triggered please include
>>     the symptoms, like the stack trace or error messages.
>>
>>   - What hardware the change was tested on. For driver fixes please
>>     mention the device (and if relevant firmware version) used for
>>     testing, or say that the change was not tested on real hardware.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.

Hi Jakub,

For patches that go through iwl-net, how did you want this handled? It 
says to not repost just to address the above, but since this will get 
submitted later, did you want the commit updated to make the latter 
check happy, did you want me to copy/paste the response to the commit, 
or something else?

Thanks,
Tony

>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
> 

