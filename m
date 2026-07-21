Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A12E974D;
	Tue, 21 Jul 2026 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631562; cv=fail; b=XnW+f3lhq712FKWM+ZdcHMu+q7G+Aur0bHAFg/KNP61ll2KT7K1Xur7ZlNm1t27ykXd4+cma2hzKKssqEOhhZMxYsGC3sGtTZtXS6fAc0cnTV0l+mqaalwm2Z5UR1jD3TjOvMCLMSORmdFZ6wbapjIjGs4jgBtFUdB7TIbQRe/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631562; c=relaxed/simple;
	bh=dIUf9QX/30GIAHMYkeWE9p+Nne3Z57swYdaGrAFk9ms=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gToI/QQvoH7VHy03Jmi2iPGSVBSQQporVs+YFy1TYXNcfcKAZMf1MJOntwQriujbalFCAHzFjD5Wz99Q/1Wjh6Tpxm83hq5Yucs4jC8yekUv054JuPVYGXPrVFMEEcx4eHOt95vKl1pywAVMxg+YmFC8+jIsXv1j5+lOLOqLleE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7nYKF/X; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7nYKF/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784631561; x=1816167561;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dIUf9QX/30GIAHMYkeWE9p+Nne3Z57swYdaGrAFk9ms=;
  b=h7nYKF/XCV/gCgjpEQ7t1Ofzl+joz1If4zdhYaFg24pS0nf+k4XnWVan
   fsSPFdNs7wOsfZzwJcbABakm7XRgVYsmRHpaCAqsXLAR/8LFQP82gSa8m
   7RjYjIfUCbs8NtDMs6oCRz0QjfhYs7i8yWuADC4eY6u6Sir/OxwvJ5QMh
   l5YTHX3r8AUU8sG6ywndH229m5uqQX4lt7a9gYxsrecYhL4Rm+BzT72ml
   SZNE8QhMG76OlbeZ0PyhZNApVFEEOTDLHR1+6H1Q++ZipU1kP3J3AgbEF
   AygXpIfD3FCG1QVHbfVMRbVQ3a5pFb5IuAZsU+vlL7Vv9bGObIg7IsdMb
   A==;
X-CSE-ConnectionGUID: ahWXG70eQg6+JRysl+pBow==
X-CSE-MsgGUID: w4h4AodWThel9I+GLDpblA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87763962"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="87763962"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:59:20 -0700
X-CSE-ConnectionGUID: PQ11tPY/QwqMnHPG7sJBdg==
X-CSE-MsgGUID: tZaAaaJuTP6uxs/ieU5PrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="254329455"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:59:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 03:59:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 03:59:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 03:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMqHLqJBJrmdR9R+li7OZ3oinQ7nc4bYjw+PkgwL1oOMBMkdjQuMMg/hGKG43HYHsypgFdDtirt6CJXKqzzNIU0xIielRdighP5lX4w0Vvuhe9OVW0H0R8Ofx77cEX1wY5VArS7Vh8h0Ut/w0VlB5a8lQJQkY6rPju+DENURTmp2Fvb6yuBdIoTVVty18Xx83XviedAGgWITKhUeJKUobwU57sQ7NatvUkk1/gSOPh6p2u+6SdW72NuT4RAG+/t6Deh89EuvEZGhBPPV7IVX2tEvyQ8v2t6GIzqjJwx9ORX+lcwHcVwate1xhgzHQpoClp+YkuQf0InnUABTmcL0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3mK3bePM1IwepzfZpav+XrIM5TTi4uCs7mInwKF2PE=;
 b=VZpuqWmbCOqaEpSUWvqzHXi8rmr7vEegUCutoovcr1J/2eGwWsicNY7+AZN5OuKbIE8ukUwuOZNdVvmOSDBVQ3A+tLGMN8hbwL6GxVNeD8tzOY0QhozfyjXm7D+MN7c8ZTpERtrTI0MLoq4gNGbQiC1p8ReNRSVwv+Ixx86TbC3xoYEYQFpyDisha2MF1WBX3IGeU0iRXlUobFIHE+g+xXX+AOh3PHGBR1TVrQmJUPgduKFyFiROE3Bfo112ZCszvPrV0IAjVoiTZsb3dy/wHXduacznYIOKDcwslhLFD45dbhvJxmoP3vQluDghqnu72B5mbBBJi0RGVKg6Qy994Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA3PR11MB9255.namprd11.prod.outlook.com (2603:10b6:208:578::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:59:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 10:59:11 +0000
Date: Tue, 21 Jul 2026 12:58:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Matt Fleming <matt@readmodwrite.com>
CC: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, Lorenzo
 Bianconi <lorenzo@kernel.org>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<kernel-team@cloudflare.com>, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf] veth: convert frag_list skbs before running XDP
Message-ID: <al9Q8yPOfQIVxvp1@boxer>
References: <20260716100605.939654-1-matt@readmodwrite.com>
 <87jyquj5wm.fsf@toke.dk>
 <al3oXdjTYM_PziJp@matt-Precision-5490>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al3oXdjTYM_PziJp@matt-Precision-5490>
X-ClientProxiedBy: AM7PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::31) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA3PR11MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a85d454-3df7-4182-6dd8-08dee71718ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5CyjmsSAWUmUapoWQeUUARhH2QVrOSkDTOtqjTwsOS91xSZPs6yP/pVMXiM48zG7H6dhvi/UYMZDei7vcvIwPE2OQf73DqmBWC1xWKJ70xkUVH46/bR8VCyq4oIsfF+7PxEvJl1EykfG7f/6JA0Gjvhsh/3JuNSELJNigmYtE/zpuKsLob24O75LyAor/dKWN0NAmA9RwnqkuMiIbpaRxJ1T0roGYfAvVJNmEOv1s7fmN8WYhM2ooxZKGatRTa9Szu5ccSFOk+cMXYEXBGGkvtK9K96b2T5Xcwmwn2ttrrCv9je/A+K7sQ09ohbpGDG/yWMQyMYacgjzghV0f/Zb3mbJMyr2JyiP+24VAXnqcK50LjO23ytx45SOzETdJbGwmvlF+ongxsikyAqVWYu6IjMV3+QidQ+/MW1yD7kd4fvC9MPp7xN95qa3cG8Gu48+nVFM6pCQFSjuBzO/hhDYvbpt3/3amuXTcHInk0aK6HDDmx20ZzuyCag9mA8vymmkCcBdGxUC0JNBHmre9pFmaS/t1ElSdhTmV7V5oAqgIgjrrt8BzvZ7ERYhMzeZf1DQBX+MJvPLEOBvaQDtsDtERsoqWa15pkJDLGHAnmQ0IBOEsmtVIWBhOwAOTcVwKdVE5DSqX4fKAecw5COMLOtQEiKyxLLLznCY47+IWaDF/4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a/6UpQVVB/Clczp8KyJPerfq+fwu1mJV+p8CUSe729CCAy8bnOjetHzk/A?=
 =?iso-8859-1?Q?vBOUmpMroAvaaGnIGuYjnuDVFJxdIxabIFPJDyBqG5RAkOv6XFiCy7PuVk?=
 =?iso-8859-1?Q?nv1cKkxS8jcxcLyquiDRQzxmHQ2pL6xyKcN9EQ7NX8JDESJgTdXnvzZSti?=
 =?iso-8859-1?Q?v6DZJQEi1Zuym79PXY/IE++81WNhHBDs++KJ7QJvO8sIBrulDjtbGIM4JJ?=
 =?iso-8859-1?Q?zguVq2C0OW4DQqa0LCaxLh0UzfneMUT8CnqxgtMD0ylWuvXy7/CG/mq5nb?=
 =?iso-8859-1?Q?g1fleSxpnaZ4tjWRnKAtRzIFfGzZDJ1f9OS7MH3Mv0xO/un7tsPqhpOT2j?=
 =?iso-8859-1?Q?CLWde5DltSAZvbWMaa8XUzedQc2VkhoN+f7EV5G2Wxxzmhj0JE9zzcsE/t?=
 =?iso-8859-1?Q?r5xdooo+1qWo7Kn2AFWnBApthACF8Gahaf93yymScSegEBZBWKQMVWWye7?=
 =?iso-8859-1?Q?5lCdaVmqG9CeugjgS7eEpLl0/naTbbhKRuZflt3Rb4qE6wYk6U5YmnLgwh?=
 =?iso-8859-1?Q?PXP6wc2Zj8BA/EeuZDUwRD2//cWzm+wkJ7QZKVYctAvPYFozMN75I8lakK?=
 =?iso-8859-1?Q?1L9AAcKUpBlhJoepmv4Ti1MtWLLbVuV9S32ng4Uvkl9F7nmBOa3TDUt2lg?=
 =?iso-8859-1?Q?3VWJN+SPzkOdeZ2zB01lqtkQCBwVHeyTs07k99cW8LclZW2uAqscAialVd?=
 =?iso-8859-1?Q?4Z4Gu4sWTpsbsB9/Kw9077IdAOJZq+D1usy9xqZHUTG0nfl3d9q95qc7Ru?=
 =?iso-8859-1?Q?KT0oycUgEIWIU0G6ahdSs++2+mcBEZijW70fxCYL55gk+KFv9+N8GGWR5K?=
 =?iso-8859-1?Q?1VKJeaGoF06+Na3rNdW5X/a/AI0C+qgpV8y5tl4FPRXpHlhvd9YMhsIHfh?=
 =?iso-8859-1?Q?DA9D4lGthMR3qTDexXiYrDWoCtO+kMsAQy7gJSc4AbEU5NGDbymlV9pmia?=
 =?iso-8859-1?Q?MVmslK0cthiwDSOG/OyPEcBSkW095HVItlxTkH6fneUo8zczMsCYZ6gMYe?=
 =?iso-8859-1?Q?cjLT8vIbK7HWzxTqzWuqvfaffzjAhKoE07NykyP9Jj1z1i9GdFvgHuPnZY?=
 =?iso-8859-1?Q?aUzH48PXTF0sXboZCPO8uq55C2JF+ayskVFOGZx0Hfmbl/aCQf017qIesp?=
 =?iso-8859-1?Q?8ooyAT0QBudk+pOsRNvWAYRs4hsMxaX7xnO9ANOePyPOTbbhCrXsC4ISPe?=
 =?iso-8859-1?Q?lTVHyfig8608Sj7+At8x8k8CKMgm+N8TJPheRitsVGp366O+QBKzcfp2AU?=
 =?iso-8859-1?Q?SgHI+6gO5qs/6nLL3Zf4wLfZNPkTl1/5z9Rd4o5x84C1InWES9Bm8mOJnE?=
 =?iso-8859-1?Q?zEz1X7w2WSDQ25Pl6DmYpWFBtEdmg7b5XSEtVocYtfv0w06ZE4OKCP/+Du?=
 =?iso-8859-1?Q?lTmcrxdJDhm6NzQJYAMz9TQvWpvyIxtbb0GzwgqUC3zFLSbXfOZoL2HJs6?=
 =?iso-8859-1?Q?5vubwyMg39PlO/hvLL0mJjTukHDxj4J0Okk9NrF921xJt3QCO0WYhmpxaq?=
 =?iso-8859-1?Q?EmSwB1Q9rnodwUF5P6CTD6cesiS1ofTWUa6rHNRKn/aqoNMW7Y+15r1+aX?=
 =?iso-8859-1?Q?fLf2Ir3YsLAUHTV2MM1Wy46kp/VqQiYEzuRe+hZXCvvAhE9WbdiNSe+bCJ?=
 =?iso-8859-1?Q?+EvxMrXtqi35Lg25IZzKAogp6T2UQ74moigWw9mY0hhI+VbYp3zEA4Bjwq?=
 =?iso-8859-1?Q?wjly21UcGC1gEVs6VE0TmdTmFxJyhHsFp9Dwufo4SFUIpfM18m7qLOpnCT?=
 =?iso-8859-1?Q?9P8hDdwZDWPIdgs9+nCVuwpGMIifTn41sNfH5mLNam/c3zJS0TaArXn7to?=
 =?iso-8859-1?Q?GvbwWjAuAj3P7W8xO3tm9MkrkTyR54w=3D?=
X-Exchange-RoutingPolicyChecked: cLbKQEFo+xWlt0DujEa/bkR3WGzBdlAfifK149gnMLiFyf/P94NjzSzJslSsCthjVq3YANPs7+ydfV7BdCbKNqEewFt5usqj4wNRGe/gsqS7yJXvyoPGTg+i4T04bVpfR5e82pXDdBAoCWgbdZL6mQxZwkxgJyCA762YRJLxWSJK/52D99MGcCT6Jct4D5ILeDfubp4JYXMSkZ8A6qK1Y5A9WCdDEw7iWj/HT1Ar4vJ6Q2tyYuVsRJv+i7SpGdufcr/8PyYvYMVW1id75T8VsADycoVldBXnLTtSLzQ547YNtQs+beqmvlRXU+P9WyNMSai0mSd5wfz7kN5hYmS2RA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a85d454-3df7-4182-6dd8-08dee71718ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:59:11.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVMNsV9AyfuPgeDTxjbZnX1krZrIs9hFNycYSe/8ckdpdqxpDHTEDQvoiEV5VJoDP5k8vnoPhA/nm3t+EKQo1UXyP6d+yh35JuqS9ObPa1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9255
X-OriginatorOrg: intel.com

On Mon, Jul 20, 2026 at 11:24:47AM +0100, Matt Fleming wrote:
> On Fri, Jul 17, 2026 at 11:56:41AM +0200, Toke Høiland-Jørgensen wrote:
> > Matt Fleming <matt@readmodwrite.com> writes:
> > 
> > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > index 1c5142149175..efb24aae1f26 100644
> > > --- a/drivers/net/veth.c
> > > +++ b/drivers/net/veth.c
> > > @@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> > >  	u32 frame_sz;
> > >  
> > >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> > > -	    skb_shinfo(skb)->nr_frags ||
> > > +	    skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb) ||
> > 
> > Isn't 'skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb)' basically
> > the same as 'skb_is_nonlinear(skb)'? Which, incidentally, is what
> > generic XDP uses in the check that guards calling into the
> > skb_pp_cow_data() path.
>  
> Yeah, you're right. I tested that expression and it still fixes the
> bug. I'll update v2 to use skb_is_nonlinear().
> 
> > Looking at those two places, generic XDP checks for 'skb_cloned(skb)',
> > while veth checks 'skb_shared(skb) || skb_head_is_locked(skb)'. AFAICT,
> > the latter is stricter; should we update the generic XDP check?
>  
> Possibly, but the surrounding code isn't set up to deal with
> skb_shared() SKBs so that'd be a larger change. I can take a look at
> that too but I'm going to need more time to get my head around making
> that change correctly given that there's different fallback rules than
> veth.

Hi all,

I had an RFC that made veth to reuse generic XDP code path [0]. Jakub
commented we could have a common pp cow check on both sides. My plan is to
revive this work as this still causes page_pool issues when AF_XDP is used
on veth.

[0]: https://lore.kernel.org/bpf/20260509084858.773921-1-maciej.fijalkowski@intel.com/

Thanks,
Maciej

> 
> > >  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > >  		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
> > >  			goto drop;
> > > @@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> > >  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> > >  			 skb_headlen(skb), true);
> > >  
> > > -	if (skb_is_nonlinear(skb)) {
> > > +	if (skb_shinfo(skb)->nr_frags) {
> > >  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> > >  		xdp_buff_set_frags_flag(xdp);
> > >  	} else {
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 18dabb4e9cfa..1e837d01a908 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -936,12 +936,11 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
> > >  	int err, i, head_off;
> > >  	void *data;
> > >  
> > > -	/* XDP does not support fraglist so we need to linearize
> > > -	 * the skb.
> > > +	/*
> > > +	 * skb_copy_bits() handles both frags[] and frag_list input. If the
> > > +	 * copied skb remains non-linear, it uses frags[], which is the
> > > +	 * representation used by XDP multi-buffer.
> > >  	 */
> > 
> > This comment sorta reads like a function documentation comment, but it
> > ends up sitting weirdly in the middle of the function body. The comment
> > you're replacing was tied to the statement below, but this one isn't,
> > really. Should we turn it into an actual function doc comment instead?
> 
> Good point. I'll make this a function doc comment.
> 
> Thanks,
> Matt
> 
