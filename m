Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7D1D5CFE;
	Thu, 30 Jul 2026 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450970; cv=fail; b=hp7dwo094OQFeXwtKyo8EA+Wkqq+0rKx8nHJ502PokyAM1ToNPLmV1gA6TeqL5x/VQ3cgKblxOuQ4yzfu8n3IiLq/wKjONI/G1bw1vMOVPDak5G82d1MXrRrEu6okHnQV4fa3QtD2G3bMM4oohhXJo2fAN4KBuHKQKxiz0T+6bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450970; c=relaxed/simple;
	bh=L9TpPf+LvSxG6uncpH/dASQkZrA/zBFMBQBaY5bLKf4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LbSLf0iwdtPuEg4b0vRoN/weAExe3PbIpBdfejFZTeBNwductCryTUzyrzKUsPuQS+PlfMc+3ZHxzkhtaqxEu8vLw4pyWUwboj0inFMmzxQnuaGy0rgPqeRk3vVp0mIzfCY9V3oGlabbdNAsGP0FIyJBHWNHtGuT2qsLngGM3NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+t7j4cK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+t7j4cK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450968; x=1816986968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L9TpPf+LvSxG6uncpH/dASQkZrA/zBFMBQBaY5bLKf4=;
  b=D+t7j4cKumbc8RIObqfW3XK0p9suLnjr9CWC37WKC0ryG6iQMbjvjvkj
   PICvb5WaXen8heIaUWH5OIzGxqqoAPRJyn27jd4+YVhzF8d8lQ2KHAyUy
   SAsvYpn2ChzfVVnLTgZMR37uu4VIkaG31xarOmiC/KMQkccR7L8Y+/Piz
   KnU3WqQJPp4wzPLEZVHz3NIAbrUyMdn3miDkGRXbz3sWmyHtwDLbrt357
   Xwt7cLRPMleZPxf9Ed81geXhM1HfYTObwPxdaaBFOXjcbz9Kh9CMZZBXw
   e+YEnlffAJeHv+IGyEgrjpseOXivArgB5iUc1HHQXzjni0ctQR3lNUDFy
   A==;
X-CSE-ConnectionGUID: YGa1RFcNRF2tg3yMFJ75xQ==
X-CSE-MsgGUID: 5zQn6KBxSLKRR3CE+kflrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86196678"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="86196678"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:36:07 -0700
X-CSE-ConnectionGUID: eFFxAcKtSyCXwEcwjq556Q==
X-CSE-MsgGUID: j14wOYTcTSKOUzCTOuZbrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="257747493"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:36:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 15:36:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 15:36:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 15:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkxraIvVAoKdxYBLdwIv9QZ4JAB6za7FYe9DCNm16AF6T5to91mauh8LgJ7QFvrbsAhudWICwxrLXXRLRMos4jLjtHQY+3nhoj8Ibp2d5D7NExazvyIPFFnsv42UAjeXWrv7JSTXdbFB1x4a5FqYPbtF2aXDxtCllr3i+HVb1aYhZEMBLsjLbDBXzHGqO1facvBSfofEtIpfbF5OmDyDpCoAAj8RkQG/0iod6Ow56ZNA6MxncF/mjAOGkMYQlCN7UNxYxleTj/xOGUEnLlgY+fZgf+NNNK3rN0+80QtqFGqzZ2HVkVLCEslSo7RXSwtre8az1UCLSdpVgKNknrJjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DGqS7G1LxNf9W6uHMNoh3ZvDzlI4VQ0qVZevfqD79s=;
 b=t1g3KAG2OXRPJmyIqp2dwwhYCOLX5FTDaGhEEI1sDvD1d0GOXK19AMRXdbbozHcswX1mxsVP5vbHB1uZ4WAp5T6tiZ1ZHT8UcMF1ss4NKp6Xddttlwlne+8u1twh2XaFm/aN3U359f5Ui4XJ0JUNbKioH6/uRotQIB3dH1Jsb3agWSFqKxheZ6mMK4HpRTh871ZZ0HHgA4RAX9s3y8NWvSLC6sgqHUAUUWuZ0mBS3IanzH/sf83NoxmPuFPMHGCFKBGUyVXAstJ0n4iTmpoAgr2rvwra4ZerAuq8aMVJOZ4X+SrCfxzWqTncmRTR/SPM+FRn+iosUJ8mE7MbHahOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by MN2PR11MB4614.namprd11.prod.outlook.com (2603:10b6:208:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 22:36:03 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 22:36:03 +0000
Message-ID: <02f446c3-9d50-439a-bcb5-d3838e793fb1@intel.com>
Date: Thu, 30 Jul 2026 15:35:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igbvf: fix DMA mapping leak
 on Tx error
To: <xuanqiang.luo@linux.dev>, <intel-wired-lan@lists.osuosl.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <roel.kluin@gmail.com>, <tactii@gmail.com>,
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	<stable@vger.kernel.org>
References: <20260721092323.39372-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260721092323.39372-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:303:2b::25) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|MN2PR11MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a139e8-e563-44b9-1b1d-08deee8aefba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AkheUKKYQ6ozZQRvQqE8wDunBLCrOt2HHwIG3skS5KYdS7q3C7jYW30Ufhv/1Kh991ls8TuMuXCiuJyq3NClek9nUUo0jS+wtpzqJ5N6uP9fcA4kMLPTBw5A84TaO4YBuPx6C21T+M1xlbZrF3yCDpeDMGpy8i91l7CR2TzaQVNRE7cmf6nG4+q84u+WMGIUU99lmsvdbxFJZA0XgA6RJeAmOCOuuZ8b6LlOpa/5qA3nSahaqomh6bjYzmPyt9YDre8DDMeoMhdpswfQGH/FrQMJyJIO5WVAOih/v/qs1yBYt65d7BckG9aKgsNnGfvPFoxhbUy9zi/CYDptsn1qa6Df7V/lOSTmLj3ffi+XLyk9f7SowCOeGpVdBeUlluaKzVRG8Hs5p71IXOchXPMyDEs7ri07qu7yuo6M0DdJouznP/SNrmLxMANPrZp7ugFwV9W0CWsJkHJMN35pvyAAcjTzM8iE4EXjosKRnLE99XZnwYFNdNuT9oXOzVex1muA1VBbMRIxXUvBiTK14bwu7U2IeQ5Dh6ykjEgWbKHRmwXfvAX4/DxxBDqc0MWlywZD7msTbP/kDXFLQiaLiuHh0l1SfvP1TigvjQmRo3+ggWvb1j/b8p2awLmV+JvvvGxjXjXK5SdUZuCDEJcI8yulqNEp/cpvYcuNySImjX0mivU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHh2aDkrbzd3VHYvMHVHM1h3WTIrYWdPZXJOazFYaTgwWTEwWCtzeHV4SHo4?=
 =?utf-8?B?ekcxU3NuMlVWT1BwdEdreUFZMUV4azZyMzFkemVDT2NFUW04a2QxOHBmWjQx?=
 =?utf-8?B?QmJTZ1ZOV3lqMWNFMU5PZ2VEeldReElob1J3cVdSMkJCSWRYcFZWT20vZjJP?=
 =?utf-8?B?cmVlWitDUkJ5NTZtVWhiMjgwSkdyWm1OTU15Zjg3VEcvdXVxcFZ4SzJ3SUhK?=
 =?utf-8?B?V08yS3ZqSVVIOG96UWJjWUV6OWpTMWhKRFRQQjV2TTBhNElPSVZkRnJ1WUdL?=
 =?utf-8?B?T0VkY1dIR1llZ09CNEN0K0tzWXplOFFLS0NTMHI0cUNxU3BnVFkybWhzY3o5?=
 =?utf-8?B?OE1IOStJQTluMHhKdWhHZE4zcVlCQ0NIU2l5MzBXMGo1UGxJV1BXc0NCeWEx?=
 =?utf-8?B?Qng2TCtGMlZZdXlRNUxic1NZVFN4RXMrKzRJYTA3dGV2dHJBWkg0Qm5xUXBv?=
 =?utf-8?B?WXVzaXpJOGpWckdLMVpkWFJGVDhtdUk4Mjg0UlpxWTVreXYzUkcvMjdMYUtP?=
 =?utf-8?B?L3N5cXgveXlQQkZ6V0VQK0E3eTNaeTJncFFmSzk2S1pvTXJDYVQxSnlFSWl3?=
 =?utf-8?B?cjJrTEtWMmEzZDlIYUhGc2hwTDFzN0NiMGdXM0pYSlhWcURZY1hETjA1cDFZ?=
 =?utf-8?B?cmV2SExZNlJQdDhpbFdHSCthTHdYVzFxTG5GUVd4bVJWOVJLSmlRTmpkUWwy?=
 =?utf-8?B?SnVRNDBvME9aMHJOT2xTTmFFTmhGQkd5bWR6Q2krODFYa0RjZ3BzNHR4TEpi?=
 =?utf-8?B?SENIVy81djBLRnpWNUZtMTkzaTlZN1RFQ2Vrd0h1blZhN0VnUHg4RVBkem1R?=
 =?utf-8?B?TVR3UDBUQXRZVUhMVmlUTTV6STQ1MTB1MUwvZnJYck9WNFZHSnk0Z0s0SzYw?=
 =?utf-8?B?WTduTHpuSS83TFI5R1o0UnJsTW1lYk45V0Q0SDFGdFVHK0RaZFlrNDBpSWx4?=
 =?utf-8?B?RHNSdVBJbFZvSmxINkRFK2x0a21MNGNzdDNmdk1QUkdQNEpZdlRDSDJ4QkVl?=
 =?utf-8?B?VEtWSTlQcXZnMWJ5R3h1WDdDcFAxVk1ZSnN2ekpzMXZjejlQL081QW44Qlo0?=
 =?utf-8?B?dDB0ODRVWWZwR0NteENSSWtIRG1JWCtNSjVIV2dFUTZHOEJDMEdCQklkZTNS?=
 =?utf-8?B?Tnk2VTVvUlN1VGZOek1iVXB3MUV2Y1hONmN6SURiTUFob2JpZGp1V1pueEkz?=
 =?utf-8?B?cjN6akxXQWlyK1czL0YybmhVbE9CdmVSZytERmltanc0dGtiMG15d2hSYWpw?=
 =?utf-8?B?TDhsd2lTaWl3bXVoSU9MY1VlekNsMy9TUlJub0VPKzFLRXF1U0lTKzRvem9m?=
 =?utf-8?B?dU1INjlidVZhcU9DckhyTWZzUkpBYVVuQXZ5OXNpVEk4ZGlrMWZjOUgzTlEv?=
 =?utf-8?B?bGNhWUtHM3RRNU40UTcrbEQySTJWZi81WFF0cmxITUs4SnNHdThFeHU1WTBu?=
 =?utf-8?B?M3NmN1RwbHpXcHlkSU1QT1YwS3g5akFuN2hrV1JScWVMWUtvVnBXc3hLUE1s?=
 =?utf-8?B?Wmh3MUVXeGxsR1VpNXpOSTljaG1kdFBMaHZ2MG9xMVpHNG9RQldHWUpkTlla?=
 =?utf-8?B?NnE3dGdPL3ZYT2hIdEp5WHJBVElFQnovNXJ3bmtvWEF3UXBmSStWUTVFK1Fi?=
 =?utf-8?B?MVAvRHVMN0txOElCaEp1bXdvTHRmTjJoK1Y0NU13ZmU0RVI1YUR0L0o4dy96?=
 =?utf-8?B?OVBLMSswbGU3WmlzNGdmNTd1M2dSU0tmbitxNXNwSnM1VVd0OW5Ea3NuODJX?=
 =?utf-8?B?RkIyNlBTNzYxYVY3Y3dpN0MwSDhnb3ByZzJHRXVTL0ZaYUZqeE8zVDhuOHc4?=
 =?utf-8?B?ZTN2NUd5MENEMHNwa2UzOWdLMXh5WGZKazlTc3RVQVlxLzFZTnBQRUhpdTY4?=
 =?utf-8?B?aXE4SU5nRkVXOHdBMzNrWmpHcXoyaTNRNEgyaEJUOElOdytva0RFSzRaWXRR?=
 =?utf-8?B?dFpya2JOTkZEbDlGQzk3R0lxZFRaMkFZcmIvbjNlQnFpaXFnNktiUDFpdWxC?=
 =?utf-8?B?d0swVDAwVUlrbXdPUDMrNWFCdGhDaVRZZGVBSTQxKysxZU5LSy9mY3p1cFpQ?=
 =?utf-8?B?cUpWZWlsMGNZNHlNL0xCY2ovU1gxZVVlNkpoUlNWaWFUcnlwREwrNmdaWisx?=
 =?utf-8?B?OG9va3BPc3FCUVVwWThJaGxyejg3R24yWlNrdFExZ0JTSHUyWFI3MlhXTnRG?=
 =?utf-8?B?MnVITTJaYVowaWhZY3pYdzJoN1ZRVG94aE9LRGVqK3ZtanF3RzBrQVVhTFZT?=
 =?utf-8?B?ZU9YTXlwYWgrYzJaZVZZdHUwWVVVVWRRMTlUR2JQNUlQV3U1ZEQ5cUFURi9j?=
 =?utf-8?B?WEw4WVlGbVNsUDArRDQrRGt5TzdDK1VPZ2VGQzEvcUMrdGdnQlhoeThDNThi?=
 =?utf-8?Q?/0ZS8CCvlJzPQVsk=3D?=
X-Exchange-RoutingPolicyChecked: rD/IdE6DcVpnythKBFh4oBxGCyz7AlOXmCchzgQ9W9IAJtLgj1Wv/Al+CYfxI1ktV9psX5hrEMmdXi8P1WsvhRKlfOX3oLIpEkvohSZUIJb3CaOksCpBB6QX+dyHwRl3mRQhFhrtp6C9qsyM0mC0ZlHVRgXEx4lOp3Evyj+1b4Bze1U4jRzm9446T9wrJQxYEffHsO0zmoHvJXu73njmrVhBuqboqXgR3e4x61HZptP0gggEHcBoNCIt2WdGshnmbNsPfnw8wLHIjvJSeRJCVjHIEXvGlabE7HW9IxAVM2SBBAinbgec7MYHzot+J2siIAhkYOx1mBtOzV4L1VGnsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a139e8-e563-44b9-1b1d-08deee8aefba
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 22:36:03.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCEOObFGB0PSSJ1aqRgT8vRCszuZULcaycNy10UKZrs7X5gfv0mcpLkoym/X55y2GNfB/+9vonxUSDonKgnH0lFwzjBysVtfObvu/fCEDdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4614
X-OriginatorOrg: intel.com



On 7/21/2026 2:23 AM, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> When mapping a fragmented skb fails, count already matches the number of
> successful mappings that must be undone. Decrementing it before the cleanup
> loop leaves one mapping active. Reusing the descriptor then overwrites its
> DMA address and loses the mapping.
> 
> Remove the extra decrement so the error path unmaps every successful
> mapping.

Thanks for the patch Xuanqiang, but we had one submitted for this already.

https://lore.kernel.org/intel-wired-lan/20260417033452.640551-1-tactii@gmail.com/

Thanks,
Tony

> Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
> index c5ae15fcdca75..3d2aba5c3f126 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
>   	buffer_info->time_stamp = 0;
>   	buffer_info->length = 0;
>   	buffer_info->mapped_as_page = false;
> -	if (count)
> -		count--;
>   
>   	/* clear timestamp and dma mappings for remaining portion of packet */
>   	while (count--) {

