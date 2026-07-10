Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6853AC0C7;
	Fri, 10 Jul 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680235; cv=fail; b=nCvAUSvJZbqIQSntT4LvWfVJpMQDFpKK7nxcGWA2f9m+bbkjOvc8lHyWVFTPU3MUYFjmqnyQg5CV0C8TyxPf3U3NcZkyvLc5Nn7KozgG+tocUAL0VeLtSDjPKsiDooI8zo+5BguK+Gt+Z2qYOpCgMJAY1qdRhUOChNYywHgBQdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680235; c=relaxed/simple;
	bh=1Khur5cyABa1MboBAIBmI+SsTgHyHYtqd7Y2slC/0W4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N19vZifrAd/xxYKcRrngwLh2SQX3C5Aw5EpCWrYwiBxEKFB9VUvun+alQ48xM95uG6MjneF6plFahmF/S0SpKPfvMK0QQkoPgti97uGAHS+gxfUe/2I/ybY9ltSIazfUCUPcRs8ihuR2yNCpHsyRotgSnvEu1XPPzrVZEJfGI74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ew54Xhx5; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ew54Xhx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783680232; x=1815216232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Khur5cyABa1MboBAIBmI+SsTgHyHYtqd7Y2slC/0W4=;
  b=Ew54Xhx5Ps1+rkFNPQKZAuDt/2ol3D687Ef+ovLL9PYjjsCzIdX9EACJ
   tV853U7+PMOPDs87F4JDShLoGN/WHegSIMv5Zh48QDQKzUvDK5xdsWM5g
   NLfUb5aOOb4iOdtAezpQHHLhL+mjM6/AmxWUcxD/eNEJsMcY+nzX61Ic2
   w9ho7/X6uZ3+GS0pSRKAXVkx6bf8ZpjM5Dll3DFbdwlvHxMwEkF86k+K/
   gM+u1zshWakFaCrlympO2G1uESHOQnwolZraITTsewk829ANTO7XYDYkO
   qBkepp1LYjfMaf+BxcYk4JcsxjkgKhRV/MJKA6OtpyqI81TBkF8SGu5KM
   Q==;
X-CSE-ConnectionGUID: ID9k9omwSMS9RZrHe9dwoQ==
X-CSE-MsgGUID: TAUIrtI8RsSD6iRai5PI9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71901560"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71901560"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:43:51 -0700
X-CSE-ConnectionGUID: lk9NWlvMTNKdjeJaK9QIew==
X-CSE-MsgGUID: 1y2Z5fduRcCjbyLPl7rPVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254352716"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:43:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:43:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:43:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRyCVZPQ81Y2KltOO5+t4F12Vour/feCTNPdA1mqWp5lWWicB3I35PZMg5Spnb+x3Tvse8a2Gd7AMaqHfM5c/MEuZFRAs7SJmXWzpCElwE/0mzRHsabZpcEJsosyGFV/4JCN+urIXNFhmOUBhy8DDZ6oP3vAqVBqFYTSpSiOALJli/1g+UOTmO683HERiEUdTeza8iOsj0usw/kvL/EiNYMhaHBHBj3j4fXQHCg/cHW2RFRGkOrAYGuql4ap6k6qfh1za+3NtvsNs9ysMIiRW2eWBajTW0OPkc1ipR4474s24mEjfy73gYY+leKTQjKwCG0wGbuTVEGc/Q/l30q0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrlF0Vp4VW+ZP93e/xFRe0EFmZ5vnW04XkVjQPGHd1o=;
 b=bm3OCZJRYuH0ngsKHnlgxE+mZkP+zGXd/tLFYV+KcuPwouv7LQQ/Ovqor5/6sgsWSnDgky2f+rrFd5AFGP1rzIjn+3VXQZF8XoMnfbHQVh4YYd/0aR7q9VWMFlWckqdihUHan9ON0Mlkh0By8tjLMnSMLIs4/oGEVyrtbw0mBuM8IxSSwcwZy9ukNVdGROIdRil5vVpOmTp4KkOg60F9feUHnzLEedLokjjZVJaeaADTEye7tgP0PXeQ0RUksKtMtVeH9id+JHxg2FzB2GrvJ6DD9A3A8xe6aRJEq3N05bbBKp5h+eUtdnB1S6LVFmj1AjQA5TolI+3as518kyGePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by LV4PR11MB9466.namprd11.prod.outlook.com (2603:10b6:408:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 10:43:47 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 10:43:47 +0000
Message-ID: <320f773e-60fe-48a1-a86c-dfa1591756bb@intel.com>
Date: Fri, 10 Jul 2026 12:43:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: hip04: fix tx coalesce timer and IRQ teardown
 races
To: Fan Wu <fanwu01@zju.edu.cn>
CC: <shenjian15@huawei.com>, <netdev@vger.kernel.org>,
	<salil.mehta@huawei.com>, <dingtianhong@huawei.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260710015730.630775-1-fanwu01@zju.edu.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260710015730.630775-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:10:232::23) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|LV4PR11MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa80f2a-fc68-4492-8cdc-08dede701f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VgT+b6Ht4+MIOE+cSv4FiGbe3nXCWBE6dPJxOlGoR4JVHmDg7VTFg5G4NzjkauAuMtVPJAxNCm2tWrg8Kltaq2Svg0SE/GgsZ9ewJ3nVg9t8etPHI6YGK/vnrLTZXe0YbpspaDvUqfE1Vmfs44kGmCYsXq9U4oiWoeeVWN2Czor6JfdqZm08HP02qdm/CjPJgZAS+SZs0FO1c5zzMDGjQZnpvqoi+vBVBbX5+KsVOmZNumuFChnD/EaaSsYNOvS0rGPvyhuvuMuajDY9MWJ1vgRDKqA6aoFD/3QxOzzk+3qPNk8ITy/zBHFDdjRJIN2RhmpyVjzw8sF86vtigzNT2pM7R6/WAHIGNMHbrObgsn4fqgtTsGb4+7n5oaczfwB7ouMZtkwdzMPRfFtWSDvX+dFzE9dY5R/yD5W4kRkL78B+5MXX22r4P8xlmbu30AZ87006mx8cgpo0PeHL3SJZb57mCO0fm6sD+gnQLCjeEthKShsb+b9X4oYPXtFsLi7yUOLbZIyhxQIKaNVH21RLXtWeNlNNM1pjvL6JvOzLAetVTjj/ivzy7ZZQcaQHDzvWXqTFGlbIauXV1Buwp5TWLU+bolCGhNLI4yz+TrslB/9UDrRC9gVGedKV+ufQVskHDV3aLjG1STGcY6g1RVs+0mG5WxnwhAvdHA2dH/jUCcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllENFZ4T2FLbURMenk5OG52dGNjNSt0YUZLOW1QanBzQ2czdXdxYmFuQ3g4?=
 =?utf-8?B?dVlZRVBJY1NsQzZZWnRtRllzNzNtQUJscWE1RHZPbTZ6ZVZaNkNJVUttaDhX?=
 =?utf-8?B?ZDgrT21xV05pM1VVVjNSb01qMUZxMC93cW5hK044aWhnN2FkNytZWkdZTGFE?=
 =?utf-8?B?anhWTXBia0ZlVVJ4TUpQYmRwY3JqNDVTeUFXNTRtLzI0RE1iSzdremlJdWFa?=
 =?utf-8?B?RFN0d2g2QW1ZV2R1Ui9qdjZHNG02TjhYWGJTaU5lbkppRENUVERkeXNSRjJr?=
 =?utf-8?B?OFR4ZFNWWVYwUzluTXVCd0srYzF3aTBwZ3V3MStJdmQ3YnJUeWc1QnJWelhY?=
 =?utf-8?B?dzd1ZnljZytJa2lmVUZSZHJWMVhrVXZFWmtKNFFVcXlBeis2UWtmWjJnSk41?=
 =?utf-8?B?WXBkZjhUOEdBM0tDT2wveWUyT25MQU41QVNqYitLelpDdXFGQUZIeUpVUHkz?=
 =?utf-8?B?TWVLQUVHY1RLZkhINU95b3BtR0FSNmptLzRyVDBFcS8zOThmTVd2MVJkWDZB?=
 =?utf-8?B?M2xLR2dkTGk4VXRDUm1Ra3lQOURaOU5xK0crWGFVREJ1MmxGR3pjREV4aS9q?=
 =?utf-8?B?WEc2eXdXTnVkT0ZyWjlGM3hmc09Ya0ZJK083T3ZHMjRyaDJKTWFCS2l3UmJk?=
 =?utf-8?B?YTRLQlpLaTlsaVhPTVF2djVJM3BaWHcrK1d3WWF4dlZIbWhQcVg4b0Fxdnl6?=
 =?utf-8?B?aHVtMTgvekV4ZmpOM1ViUkNCWkROTkI5OTRmby9MZ2lEbVZxR3JrVy9oMk5i?=
 =?utf-8?B?VWVqNE05MXg3b2FrOVgyQ1hDZFNrZlJ1ZUVWL3dQWCs2OEJySlYrM2dwNDE0?=
 =?utf-8?B?UFFlNkVBamhPYmJJTHJONXVuVGhHVzJidC9ZMXZuYUhiSjhSMjlyMExseEg4?=
 =?utf-8?B?SFhZNGw5ME9nRXRESDluY2MxQ3RnZ09sWlZRVFRHUk96K2hULyswbEhzdjJU?=
 =?utf-8?B?TTNHandJS0pIdXFDYXlVQmQ0NWY1cVVuOUdzeWxzSHRJNUxxN24veEdjczNy?=
 =?utf-8?B?dUhXNUx5cjNadmNYMVlIclVCVjdQRGZ3SUFIQVhNa2pzVGt1bmUyaVpNakZY?=
 =?utf-8?B?eVJrdWV2WkJJWDFjZDgvZkdCWXpXSTZtOGNvajdzcXl5ZHJHcUlhMk1SQWF5?=
 =?utf-8?B?Ri81aGUwc1h5TE12Ni9sZk5vMGtnb1p6L0ovRGJNL0wrY1NNNHU2M0xJVzlq?=
 =?utf-8?B?dU1pck5va1hEVFJGeHFvQkljRHpsWFJkZC81ZkdzTzZNemszUG4wVDFPT2pj?=
 =?utf-8?B?azNRcUZReERQeWRBbTJ5WHMyTFdEWTF0SEgxUlkrOXorSVA1YVdwYitTU0F3?=
 =?utf-8?B?OGhDTmpkcTJvODVmTWVqeEdDbHA5bWI0M3htdS9rcmgxOHZCQ1htcmxBYkVx?=
 =?utf-8?B?NkpCUDIzR21rbGxuZG9oY2wrb2FUTTRENVpoWGJQTTZlQnAwWW14dWxXUTU0?=
 =?utf-8?B?cW5nYXo4TDNhTmZqb3dkdGdOMHVobnB5TFgrd3JRNlJCeE5uTGtmVXlmU0Fx?=
 =?utf-8?B?T3dETXZNODlBZWdmOUlNQUVwVUNaNzhpaWFaNE9LQmtqaHRHcHJNOWl6Sytq?=
 =?utf-8?B?SzN6UEZBRDFxM3dCZ2RqaGdra2kzaTdsdTQxTTIrRm55bXQ3OVZkaW1JY1Zq?=
 =?utf-8?B?V3FvOEZ6TWgvemZTZDhSNEFsSklDcVFBUmxlOCtiak5SRXVPeWFiZ1FSS1Fz?=
 =?utf-8?B?dkwvWGpqQVBvOUVVbDFyelE0eXlXY3dVaUVTVktOZHNNcXVQbzlOVU1MWkNl?=
 =?utf-8?B?MUxhTUFsd2loZXhXcC92QzNQYi9ha2ZZc1h0Q2VsT1ZyekJsVEpiUG1vMlQw?=
 =?utf-8?B?OHlIZ0VmcVdtRlhqckhpbmtoL0ZBeW5XU2s2RnlMSjZZOWg2NER6NU9IZXFL?=
 =?utf-8?B?Qnh5UFQ5amxCUUJzWVRMMUNFMnlWQ2RUWHRWTzVTWERWRS9IZ0tMTEdpMXZ0?=
 =?utf-8?B?dWNlVldlbVNNNEM5NWs4VDRWcHhQYjZ6ejdJcUhRY01lZFI0dkJrc281MkZi?=
 =?utf-8?B?UndWemt5NzhSVzNndXVhZU1WWWdCaVBkR05WVmdtbmVkTWVrbnYxSXAvVUI3?=
 =?utf-8?B?Vk9zbXpzd2lsZEVoUHdtbk9vd0xWMjBkU0ptMGlHMUlKR3RKL1I3eEVvREEy?=
 =?utf-8?B?ay9lOUQzcFdXbHhBOFI3OTNnRm5FUmhUVjdkcU1xY0VyRTYyZFhFZnlKeHNV?=
 =?utf-8?B?VGU3dXRhS3VSSW9ydHROdnN2YUdGbmRXWHhEWjNTZHhzZlVoYTdmUVIzdVFU?=
 =?utf-8?B?UGxsZFlxQUN5dWxhcUZGb3JyM2VRdHVxM3d6cGt2cGhzOGFkR0R5SzFZZnNS?=
 =?utf-8?B?NVBZeXh1Vld2NXdrUFAzUWIzdWlCeHhUUkJPcnhiOUZ2d3VRakUwMGV2NEEv?=
 =?utf-8?Q?HopUAmMl9mXcSjhU=3D?=
X-Exchange-RoutingPolicyChecked: c4jPYDl4NebiYnSoigFPZ32HQcI13gQKi9iUHfJ8zDbKNvN63NVipcQmcczrwKA+DDjwlymD6Noq1QxWCAeghMvyyppSing+xK+2ZL7h7PQmoXLBOxxzGzLrVxw3PSIconpl/OyFn+ol2xmtAphe9oawNvXo576AfMUMO7IUWhnj5setnxBROpjurqMNIpSXTCYYNdoaw4Jnsc3Lso2JujhxqCuLJUWs7sd3aFy6bjq4QyziCf/1wwXSIjaz7sXcq1XR7lzImMcksQJDkMKzH625PpoUjhpBW9WgvaLO62apgETTJfeKYUJShdLBwco8O/1t2nBGhzCHqtR7Ypr/MQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa80f2a-fc68-4492-8cdc-08dede701f2a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:43:47.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaUInKY6qkUtPVnf8BSPPXSen3zeuTWTI9hSdcEEySn09k6Oa2BOf68aJeUvmrXWv+SIzb0xxvRmPFIVyVqH5sPpetQlvIcu7/CVCQnXrrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9466
X-OriginatorOrg: intel.com

On 7/10/26 03:57, Fan Wu wrote:
> The hip04 remove path frees the TX/RX rings before unregistering the
> netdev. If the interface is still up, unregister_netdev() then runs
> .ndo_stop, whose TX reclaim and NAPI poll touch the already-freed DMA
> ring memory. The TX coalesce timer and the platform IRQ also outlive
> the netdev private data they dereference.
> 
> Reorder hip04_remove() so the netdev is unregistered (which runs .ndo_stop
> synchronously, stopping NAPI and the TX queue) before the rings are freed.
> Free the devm-managed IRQ explicitly before free_netdev(), so
> hip04_mac_interrupt() (whose dev_id is the netdev) cannot fire against
> freed memory: devm would otherwise release it only after .remove returns.
> 
> hip04_mac_stop() must quiesce both arming sites of the coalesce timer.
> The NAPI poll arms it, and napi_disable() returns once the poll calls
> napi_complete_done(), not when the poll function returns, so move that
> arm before napi_complete_done(). 

> The existing early exits that jump to
> done do not call napi_complete_done(), so they remain outside the
> completion-after-arm window this change closes. 

this particular sentence is hard to read, as you use AI, would be good
to rephrase

> The TX xmit path also

s/Tx xmit/Tx/

> arms it, and mac_stop() is reached directly from hip04_tx_timeout_task()
> as well as via .ndo_stop, so use netif_tx_disable() rather than
> netif_stop_queue() to wait for an in-flight hip04_mac_start_xmit() to
> finish.  The timer is then drained with hrtimer_cancel().  A "closing"
> flag, checked at the single arming site, guards against a later arm.
> 
> hip04_tx_timeout_task() restarts the device with mac_stop() + mac_open();
> serialize that restart against .ndo_stop with rtnl_lock(), matching the

given the direction to reduce RTNL usage I see no point adding more
usage in the driver
perhaps netdev_lock() will be sufficient?

> netdev core's locking, skip it if the device is no longer running, and
> emit an error if the restart fails instead of silently leaving it down.
> 
> This issue was found by an in-house static analysis tool.

Thank you for detailed description, I get from that what the bug is,
what is the fix, and agree in principle with all of that.

> 
> Fixes: a41ea46a9a12 ("net: hisilicon: new hip04 ethernet driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

