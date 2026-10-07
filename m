Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDE3BB9FE;
	Wed,  7 Oct 2026 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371236; cv=fail; b=IowywbGDh2aYckhnl6JO2EkOq1YZmW2IX0TdGQ9wCrLSKPf1om624CuYvhQNcv2P1kwrY7v+TqPKmWL+7ZSFo/llhoThyqTzKXn9aIGsAfLMTPE+prHO9ic6DWo2fhZd40jrDlYYRH4x/YZTdLX7hj3DmcmRs78LfqJK/YvYo10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371236; c=relaxed/simple;
	bh=AiRYSUOHYDbUr/oMFbyXXP+XPNYsGlltZlZ7Tw6B9uc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QThUMYnM0hrQz3X773bx+Oz1RJfRNY709kmft/+Cqo5MCJQ59oSDeZCcsPBa0tcFpfvHp3YggdJ05F/c5wY8smj476ZNNvEpQsF/h3mrBzJy7WMMBeocbJjBl6Ad1dB4OITbGcyMUipl5/9C4MDIZGoAp8mKP+5jBou2D4KnO94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nP8V8bbU; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nP8V8bbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791371217; x=1822907217;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AiRYSUOHYDbUr/oMFbyXXP+XPNYsGlltZlZ7Tw6B9uc=;
  b=nP8V8bbUXDAbLbj0/XLheTj83QX9HlL0cqwg8V76ZteZDZkWNTHpmWC1
   3AWavqM3EyiJL4w354bo4Ca44HLr36+GbtGgAS932LAFVvAEdXTwpWCG6
   SwoAr4X+yMFfv1djOukqYhMyGlV5pnBKnDA+P5QeWGE0Cz6esg+31iC9V
   CQxT5v3oq1vEczk49KEEjjHKARkrBqTx8f58FphAUJR+8vWQmrXPvfMM5
   82ThIYdjQ7EkMfVVzD7IpOxCLWhZKRSXEk2DOb2yoqp/7PvM67trXZFPa
   ceU5ilOWMDmaLuEHIK8rl/9470zJRqd4ESA5lLT1Fe7wlROpeTavv7IdX
   w==;
X-CSE-ConnectionGUID: dm2TGVqpQ2mV0JYi7iZDmA==
X-CSE-MsgGUID: H+UY/smHToOAabLprKn8Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="24833"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="24833"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 04:06:07 -0700
X-CSE-ConnectionGUID: OSjfRO22RpWN+zOqns+QNQ==
X-CSE-MsgGUID: +4rU5fCyRUKO3rbcim/Atg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="303712643"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 04:06:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 04:06:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 04:06:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 04:06:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeImxB0WTmo5+XcsgBx9vnkoaQX0adnnYktZ0mIYLa11XfzR5azJJzcoBQPdOnVyOVel6kYNVcXEwnuFn5k3o70utcvgUPP0aMTDZ/lT43m0ue86D/hk+a/s3isobECTR9mxw40pnft/jnQZkysf+HuR3WkX++c+SZQsR5194ixe+NauoX58wFq22IlPfjRMo2OGR6uPukPsWycflpDpJLOENw32WLLujXCys2t86ypyPYnIyGRYLXTNM4lUbQZG+xgJxQdiDkJTta+lyfxByvk+Th9yWeLZxqehCUe79/+GXTLxlKAaGN+jWfz7aXPcMdJtNNs1BnI2YxNRtqQW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04lYrbxYVCPnINgdpIPRgpR6bkuqWMHLZlgiDnvUTPU=;
 b=UoorI+XSj2m5+kBl52tHlZwEec57p32LbMBDK1Ur88A6CGg9UCB3wYhhgaPmpBNWEnRr+8mslskQaxA8H0ovo+C7HyT3JoXO8fUyMVRLkopyu20Ai1ZnQdu03ll51tritqZNLzy9WfEIUSgcnEahmD2LeGRMa/7vGECb8GXpcTfKTDAGchsAhxLrstbHAEiwk83PYxGvM6hORpCN8n6/9iS6iUCMk4ChbWz/HixtHjeSznuIhloBp6DlOGFNJgVvLD4i3geujCIHH6ZkJa3h5dJ8Kr4bmRhRWT2m3/azoMZA42uPSFHVoyzE+udltmKmS5kzIzcyx16BRKV8rOrrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH8PR11MB9805.namprd11.prod.outlook.com (2603:10b6:510:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:06:03 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 11:06:02 +0000
Message-ID: <0c464819-16ee-4bae-b15c-3337516ef3c9@intel.com>
Date: Wed, 7 Oct 2026 13:11:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Linkui Xiao <xiaolinkui@126.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev-bot+sinfo@kernel.org>, <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linkui Xiao <xiaolinkui@kylinos.cn>,
	<stable@vger.kernel.org>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <179057875290.31693.7249107578001642813@kernel.org>
 <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
 <547ed917-77fc-4670-974c-4d4fd6fbf3e7@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <547ed917-77fc-4670-974c-4d4fd6fbf3e7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA3PEPF0000051B.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::676) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH8PR11MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: be52b88b-17cd-43d3-e381-08df2462f9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: pefRdTY89FxSV/OO8QX20/n3hNBPFEevLySt/WemR3iUNAMjFlPPgaPFoqgMx1fk/a9tuIFyZGWKhWbox1U9mvpsz+yFUjWv98rJTJofhSTWsJSK/2WXmvzgdu6iFF6yqY2YFTTUp22NIjlECvjey5BeWfQbXGIw1Em9VP4OuIve36IrjKhWc8TwGAJZ/dx9F5HfVHFc2M1xBdurRuxl4mlD/Rv/q/oIUTWbVRLqlZoB7LDe31X3aPQZbCJ3r6GSIh7nmkVQevvktxVfVQGcXByjczTtKk/PSYwWmIms0BrL8fuu4uoAEOnVYRKi/RnC1TsANcpLdii4VEUyAkL1EahOhn0g/9pxPAx3Bg07+JUZ3DEihOd4EofK9o8h0FFyi2XhVJPByBesxRK9i9k3p/ektQ0WALjsVSqh+mPlMu87Jf4+n3hOE1VUQUG6ipovDH78Uh586Wim2eyBPKWKFdtk87CXHwz99mtD9jMSDpdVdI53L+9rkq5g5YhzCs1gK3uBCCe39kJoWo/KYtP5qr2zfm6j9MNMVqQUqrwLzCEwCKfB7Xu8cxdAKvzO2xIEu6kzdSXxIaxZMxFpIgdcBFqZ9qXqmnLSDiuJIRS2MUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJteW5wTk1RanpoSkVZZkk3MEN4YnJ5U1cyVkdRdUZiUU9qbHJoOFFXeFlv?=
 =?utf-8?B?dENtdWNPam5DVEwyRWZTbzlpR2ZMTTM5ODRsS1JVY3lkMGhiVW55Sjd5cEs2?=
 =?utf-8?B?ZFpWS3M1TGMxbjNGTnJMekgyTW1UcUNTZzREOHJyTkFFNWlGYVkweFV0bElF?=
 =?utf-8?B?TUR1VDQ5YkJCQ21Ca0R1MG1jTVlYRS9iZmZBNStOV0QrSnlTMjZMN1lOcEgy?=
 =?utf-8?B?cnloSnJzQUM3WHFKT2ZvZGlTRm5tem9ZemNFUnpzbllsc0t4ZEYrNFpUbmMy?=
 =?utf-8?B?a2VQZUtLazUxWjRJd0ZEN01XRVRvREZpVVp1b2dEcVRxbFY1OGRSa0xkYUY2?=
 =?utf-8?B?Q2J5TGJFSzBYQkJyR081SkZaUmIyajhmdkZJMVQ2SFE1Z3ZzMnNHcVppa2xJ?=
 =?utf-8?B?SktrRUxIVHBQaTRtdDQ1dEpQcjBJL3N2OUNhWmxFOXhrbTVsNThoYnBsaW5R?=
 =?utf-8?B?YlgwNkJlY1l4N0VNNlNjR2JtMmZFRkwvMXRrS045NVZ2RGdkRng0aFlTYnFx?=
 =?utf-8?B?Vk5RY3p4bHBrL3hBdXkzL20vZ2xoTEt2SlcrSmxGRVJsbFJRdXljU0p5VVlR?=
 =?utf-8?B?YXdGMFk0UEwwcnVkMHFZUm5rY2l2UGpYeGRiOEFWZlkyNHBKd1R4VThyNEJk?=
 =?utf-8?B?TkZDbER0MnAvRVlkdmpwcmJSV1JQY1RvaDM1V0ZUVmpsRCtoVHRMMDMwcmFh?=
 =?utf-8?B?bTk1bVBQN21TaVhQQmdrdlVVRHpRQnpMbjNmamZSUHRpV2g5SUdWM00vMkJm?=
 =?utf-8?B?M3loZkpUYzMxa2txVFNVYkhuT2dzQTZSY0NmTUx3eFVPUCsvdHMrNGVvV2lI?=
 =?utf-8?B?WnhqYmRiM2F0NHVEZXkxcG9WWEtMcVI0RzhyeWdJUnVmT0ljUk9YRVBaT2hU?=
 =?utf-8?B?eEU5SU9Fc3NFeW5Ca2UrOThrK1VLNDJUaEtKNkxjTzVwbDQxOVhUUGpJK0FH?=
 =?utf-8?B?d242cVpCSzZsVXNRaDYvYXgzaHJ4M3hielp0ajlDSkZQMEdFQUJYSUkrbG0z?=
 =?utf-8?B?OWVXbFMvVWlVM2xFT0ZGNWJzWlZ4Mnp2a2JrQlBMSVFQZTJ0c1dORm5tL0VI?=
 =?utf-8?B?cnkxWnpXNUsvMHZYSndVNnh1akRTSGJaK2tKbTlhVGx6QVF6eEpjd091ZHZY?=
 =?utf-8?B?WUk1eURnZjU3SzhYNVB4d0k4MGpaZGJDdWJHNDlQSDFFNXNpdWFPOVFCQ2VM?=
 =?utf-8?B?SmJHTUhyVmdjc3FJRzg4R3QwcnArelg3eStUNlpJVXpoMFpXMnQ2cEJHRG4v?=
 =?utf-8?B?eFROQ1MrY2g3TjU2QTUvMWVDM0xkcTdybCtkRnZvTUowaEpqdUo0MVBsRHg1?=
 =?utf-8?B?SlhqL3M3c0xKdmo0aCs3a1VLZFBKQnpEWHRLWlMxOTlTcGE3cFF2Ujc0dVpZ?=
 =?utf-8?B?QjBuYzY1RjlVelpYdVhNU3dVVmE5azRkMUJHNENlSnFPYVBWQkJiMWRtdzN0?=
 =?utf-8?B?eG0vcUR2VEp3aE1vaTBQTCtnaGtUTHNVQThvaExrU2o5UWEyTjVSUkNUT0Rp?=
 =?utf-8?B?N2V3b1pFOEppNE1adEZueGhwS2xPUVNPT2xnTkZ5SDJNZVh1QThZUW5aOTNy?=
 =?utf-8?B?Q3dacEhpUk1WZ1lrTnFyNmFHSm5CM1hoS3VxUitsYzZMQWl2dlMzR2lzYXNR?=
 =?utf-8?B?S2I2dmM3NzB5ZUxhVDkvejdNcHFuVkw0N2p2bkxVajB0RVVvOGlLclQzK1p5?=
 =?utf-8?B?RDNmOTcvL0ZRdEwra3hCQzFkemdNU0toc3poQVUrYUtuaWVBaHM3TVM0QlMw?=
 =?utf-8?B?NmtxN3lKdnNMMnlRZSs5RHFOVjI4VGE4YzBRSzQ1dVdDYVJremYrcUQ5azky?=
 =?utf-8?B?TE9lL21icEo4YVlmcDlTRG5haHpaTG11QWFyNUZ5K2VmU1Q5Y1ZCMEYxYXpw?=
 =?utf-8?B?MC9jNEFqbmJCdi9TeWs3RkZ2dVlmMUNlZk1jck05bFB6N2xobjlqeHJGTE45?=
 =?utf-8?B?N3dEU2xSSVJLeTU5bG5sdGh4QVN1eEdjdmd5cVBVMEpIQ1hQYlZRbkVTNDFP?=
 =?utf-8?B?Y2wzSzMrRnFzRTEyd2dHLzZPOHpxcm13dUpvazVFTnZLZnkrRGtkS3JnOHZD?=
 =?utf-8?B?R2lKK3cxQVJXY1FFNFBCeDF6dTIrc0xlOG8ya2RBaytjNkltcFAya0k4bGpH?=
 =?utf-8?B?V0UrL1diWEd3L0YyYzNMcmdPek9wMnR3MjVrYmQ1RTBBdFhlS1lyQWFwWEhI?=
 =?utf-8?B?WGpCZXZZN1drcURzc1o2aGdNZGFCRi9kQW1Tc0Rad0tOdHVCZ2dXVnZUUmdJ?=
 =?utf-8?B?QmlTV0Y2anF5TEJpZWFpdDlPSUV2clRxWXRJVXBPbkFDREZuczZ0S05BWFh1?=
 =?utf-8?B?ZEJvNGNXcEp3endVRXdQY0s1aHFXei9ESlJZVjFFem5mbWlGK1BYaW5hdzJB?=
 =?utf-8?Q?jGLj+V96jm9VwJp8=3D?=
X-Exchange-RoutingPolicyChecked: HTWPKAgkn2CU2x4zVH6Y0sohXRiOjW6yxm11zRxtvZJet4r9mPpxlow+4oKb0htHmZxoDYHEjSxMU8ngNSpz1m7Ha4ogicqOXpwGIcpVd443Tf10MGHXssxG/3ce86pi0sbP1S1sLqYXu4lBfz3MgRH4vipnEsTFrkDzZlnW9DyByQlJlceTsPwZkgDWJdiKpfZcMVEWlu4gZ73c5cdhlHBctgqOLGUcyyUA8s8IyyDJa4kRdubMpNQtQ2JJYwq8nuthm5KCQ19uIUkYqbqKCaTtAgsXc9/aSq4kH4QDKKsfmPn4ChS6ROCtSSeODXvrGoNOMLNZVGW34qkgFLnuuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: be52b88b-17cd-43d3-e381-08df2462f9bf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:06:02.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW8jY3cO27XEVG6eLqgeNvu59PO2LzCbK/zhKw+O0knA6XnP/PvoQQ2HyM3k6Gbo2VcIRBzC8Kuuapgbnegus3X/0Ly2fOMuVxiDDySzbRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9805
X-OriginatorOrg: intel.com

On 9/29/26 8:11 PM, Tony Nguyen wrote:
> 
> 
> On 9/28/2026 12:14 AM, Linkui Xiao wrote:
>> Hi,
>>
>> Thanks for the review. Please find the missing information below.
>>
>> - How the issue was discovered:
>>    Found during manual code inspection of the ice VF setup/teardown 
>> error paths. It was not reported by syzbot, a static analysis tool, or 
>> an LLM scan, and was not hit in production.
>>
>> - Whether the issue was actually triggered:
>>    Not actually triggered. It is a theoretical error-path cleanup 
>> issue found by inspection; no stack trace or error message was observed.
>>
>> - Hardware tested:
>>    Not tested on real hardware. The change was only compile-tested; no 
>> affected Intel NIC/firmware test was performed.
>>
>> The same applies to patch 2/2: it was also found by the same manual 
>> code inspection, was not triggered at runtime, and was only compile- 
>> tested, not tested on real hardware.
>>
>> If a v3 is needed for other review reasons, I will include this 
>> information in the commit messages.
>>
>> Thanks,
>> Linkui Xiao
>>
>> On 2026/9/28 14:59, netdev-bot+sinfo@kernel.org wrote:
>>> Hi!
>>>
>>> This is an automated message. This series looks like a fix, but its
>>> commit messages seem to be missing some information:
>>>
>>>   - How the issue was discovered, e.g. hit in production, hit during
>>>     development, syzbot report, manual code inspection, LLM or static
>>>     analysis tool scan.
>>>
>>>   - Whether the issue was actually triggered, or is only theoretical
>>>     (e.g. found by code inspection). If it was triggered please include
>>>     the symptoms, like the stack trace or error messages.
>>>
>>>   - What hardware the change was tested on. For driver fixes please
>>>     mention the device (and if relevant firmware version) used for
>>>     testing, or say that the change was not tested on real hardware.
>>>
>>> Please do not repost the series just to address the above. Instead,
>>> reply to this email with the missing information, so that reviewers
>>> can take it into account. If the series needs another revision for
>>> other reasons, please include the information in the commit messages
>>> then.
> 
> Hi Jakub,
> 
> For patches that go through iwl-net, how did you want this handled? It 
> says to not repost just to address the above, but since this will get 
> submitted later, did you want the commit updated to make the latter 
> check happy, did you want me to copy/paste the response to the commit, 
> or something else?

In general, I would say it's up to you Tony.
Perhaps we could decide based on the amount of additional changes.

For this particular patch sashiko already posted complains:
https://sashiko.dev/#/patchset/20260928065306.1514795-1-xiaolinkui%40126.com?part=1

I've encountered the same problem (although during my OOT encounters),
and the solution is to detach/attach VF representors outside of
vf->cfg_lock. More rationale by AI follows:

ice_reset_all_vfs() and ice_free_vfs() call ice_eswitch_detach() and
ice_eswitch_attach() with vf->cfg_lock held. Both take the devlink
instance lock and then register or unregister the representor netdev,
which takes RTNL. ndo_set_vf_mac(), ndo_set_vf_vlan() and the
representor's ethtool reset take vf->cfg_lock under RTNL, so the order
is inverted. The ice_check_vf_ready_for_cfg() check in those callers
runs before vf->cfg_lock is taken, so it doesn't keep them away from a
reset that is already in progress.

Detach before taking vf->cfg_lock and attach after releasing it.
Representors are added and removed only under pf->vfs.table_lock, and
ice_start_vfs() already attaches without vf->cfg_lock. Both functions
set ICE_VF_DIS first, so a concurrent ice_reset_vf() bails out before it
reaches ice_eswitch_update_repr().
