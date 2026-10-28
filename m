Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793193686;
	b=2ruRv/TnQ0JmlCkLm7bmdwO0artvXIupYuRv1LV34hBvWfWM+dGEJXSaSysK0gzvw9qm
	 1WpStxBcg5oy/rKF5Gfm60RbZDkiF/3BjUiQxcC1uFz6fwbvO5Tc5b/DiqL/PqzMKt6+d
	 WHP9yQYV01/6AxnYWzYYUBVr9JtPbhxQpPKyuTwz4A04fjPrSvw13J06s/Rt+3+2kh0Ei
	 gNAMRrI7/bo8wkiXIOnWmThjFdJdnLfNRXwAvhakPwIBvDTv2+CgnE4pccKBZm4mx4ooj
	 8XyWtPI/fGyJXWprXRpfiwK2FhjVTSkFlS/rvxxFlvwWQiU+tPF1VS8ULeg8tfgrnsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193686;
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
	bh=xETPizG1IqkMOHMHc0SCK0mwOjgVKG9gLOGQ0Io03m4=;
	b=Jmxgmhbm/jx4jvaGyKQCPJJK2d+f/+ia61oE1NfAYSlHk0UFJpKfEikoAcqqx/xiwGcD
	 1mjdGN05G1D5C8ZYPy2q3Kn4I2VWxBdRqU6tagkrAhWW9yS1LUaTVadO6AoPUIcLF29UT
	 nMIeyG4t46uwa6raFxQ8XNJGJjAepQGP/gh8c4jYoJuxR30tDfHhFgS9zIyIVEYapocvV
	 h5NGL20pEfnCqkKKrwd/T4morKZNNqoSa1QW+i9wgPzrCWW58Ej9pAkqElP9/MoM4MWZl
	 1NIAEQ/4AFuzfFO4whq5dat0YY44MoU2NDq1OurOk3iSEtqcTLux9z0acGYShk+udBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mGdVAtKB;
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEE606A31C;
	Wed, 28 Oct 2026 13:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mGdVAtKB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793193685; x=1824729685;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5a3zVFIf/CMoucicdfkGBsVUG8pja930ovlWyMVPr98=;
  b=mGdVAtKBxrTKa+1pcI+DfIwMs3vzmNb8hqFB5uGvppiqOlRkiLpYl1L7
   RyqfnTU0wpZCE9hapBOrPGDPSRyx6CMBDrKxDh6EqSR9bRlJER8FnngOp
   gdw3+aYvqIvHq68BDmFo92QqmoR5a9i+hO68NQnKoHbgfwxE6hbNZ4N/3
   M5gROt44wMFIQ8FTvXxJkjhoJ8/U0s07Iej1p4nWSi7Ma7jL10yKNoMT/
   wrQf+oP0fU1x+0MlGYQIc6pQPGEFFWqk00OJ0182sj84t/T/rsacSkI3W
   5alcYzX6lNAKqZegimullQz6uH44TLDav/sC3vGgJD94VZWoCqtFQj+DI
   g==;
X-CSE-ConnectionGUID: bxSCSvYtRWKsJYes1Gg+gQ==
X-CSE-MsgGUID: 9SuUIJVJT/aR/ypXeuWmsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1794273"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1794273"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:21:24 -0700
X-CSE-ConnectionGUID: fkh4Nr7rRLGrjr25s13yZQ==
X-CSE-MsgGUID: YRGbsAseQ1iLDJQpW+04xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4798175"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:21:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 06:21:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 06:21:23 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 06:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMOPcxAD3yVrRDvCvwXpTUYySBpDobIZbIRx3kqRr1skNeQCr7+pScjK5rAFrIZicL0v9uSMw5/A7VT7ywpfEnudY6XcuCI4vf/PNcmRaAQpltIaRpjWvXe0O7Y8WhDLmPwp85GzqHsFqui3JpA+hjDie2HVzQAx+Qv4JQ1jRfwjuFj1rEQvxASCvOoFqbyhjaGsSz/F7eQOwefQ847c7WgDKZ1dz3Fd8f9TSdC3yHtCeUJYZeW/2YC4iEQspuB0hmckB8I8uR4CIBhceO/dyfrN/LnWywXRpScB1YFxSBwhN8agP8lh7kdijLI8hNhV1k7Kl9Cxu+xyUL8k2NqtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xETPizG1IqkMOHMHc0SCK0mwOjgVKG9gLOGQ0Io03m4=;
 b=nEqU2mxwW133CWwes2MtJybF35eTBUpo4L4Q5HcUga8hTtjZWe5yeCbrUGAk5tcKNYFKRub/fiKRVz0F4ocVr5qDEUbJ5LSi70Uq0dDOpXgzBBqIEgwpiN12TrSN7woIEuPfk//voDqsd/vYYZW8SHlHvTYlUAu4h+0TcECI+xB2HxORnm9P2yQSj+owI2S4gZvB/yHDhLCW4kkRXUS71uB9zL+7L0PYMJNCQWWyAlkw28qQDkHgZ7og9HOFo9KxyeKySjFef2V4jMsY6EZXTB0/jTV2+9Sd7KSl53W33Vl261dYJyUOFJLd/yKuD1sZ88aJXZ/+fDgGtfeUhVBCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by IA1PR11MB6395.namprd11.prod.outlook.com
 (2603:10b6:208:3ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 13:21:18 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 13:21:18 +0000
Date: Wed, 28 Oct 2026 14:21:12 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
CC: <netdev@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, <stable@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/2] xsk: defer software checksum until the skb is
 complete
Message-ID: <auH2yISa8xouAx/3@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
 <20261028025026.11401-2-testwrzwrz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261028025026.11401-2-testwrzwrz@gmail.com>
X-ClientProxiedBy: DU7PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::13) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaf1e5b-ab0f-4843-2b80-08df34f65989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VZcmwZIle+KkPO7r2hflPv10sOQc7Ztm+gpQBtkPNLkq9NGJYMKo5BZywM67j6G6CTG27i/VQDeepWu6k8A5xLHOwLN1J7VaO7g2CX/G8Isz85lq8phWEMP9k5jkaa0b47n6lxDN8nerdDkXT/KnwIrssKBr2HCAn/FpywpEpanZ0xj/DLJJ05ozPd6FFWtBxZuQB4CkFOKCiJmJhjqI/JMX2oEmVLghR/bjAvFOHzmNAtEYCDCKTEGZals5DZLqq69AXBX/0bSX8jG6XR8ctbpUPO4oWV5p7xg2byPGwi9rMNIunFuKCfJfwqsR5UdJIRwYRFYYy3ILEb34EapayUfH8oJMLPirdxo/ACy7rh8/m73E0DIQq7nyGc1ckyiRKgvsTXjQYz9KwuKtsTDv+TyaxvHhlFTdmR7q+/4vdrsGoNbdCTmqWI68sUi+fuWn4rn0yBGAbmNOLTrMALZFR2RzoLxeiXz8QkiHS0kvVJA2LTVx/mQFiHQ/Pgnyd5xvIsg191wWhc1pAG/4zyYz6Z1Fmp/dBejdks4wDzJYCajq8jVrR3pH4hIxZ9sxWowvYgbdIE0XbgL6LXEQeZK8mMWAxtgaFX/x8iphViEVx5jLQpJj74Qrcb1ufi65p7PPbr1D89VU+S0W33jCFhO+Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltRKjTKC3AqllrQsN9aDUwwF5X2yDFxXTtr7yoGMbJLFHqx1+DK66CV2/5Gp?=
 =?us-ascii?Q?KLSiK0+Wlj+piN4v2APvgZKBTvWMImdgbEXQQE49JW/pmAQIdHdjns3cvp2u?=
 =?us-ascii?Q?Qrxuc7r5jeSs+vUP0PP3Bmdmd+r4INn0A/xggzSdZHfoor5wxbFU8cJv7eI4?=
 =?us-ascii?Q?uwH0/ZsSat4pu3OCTa5zOf85vfjey6YavazXLFM7HnpT0mVLCqvh5q4AlAqG?=
 =?us-ascii?Q?uglz1OzpyOn9WQQNP/4hnS3LQUsO50+bhRKw01qvZm6+QilNQDlrsOBsRaDZ?=
 =?us-ascii?Q?jt5fU9JyCXrBXBNWppcvelEQqAZmvZcztRA2ANFOEodjktunxciWrZ0Nb+l3?=
 =?us-ascii?Q?p6vZFQSFZ95pAJMgy7VNvjJL9lydMtKkTMLfWuf+BvnR2KzMERtd1zIO/T7z?=
 =?us-ascii?Q?A8NmseeqvJnRB0mop/4yFXWFMuSQc6/o+leyaYtWzTlJMjYy9jMOTG79QG1J?=
 =?us-ascii?Q?a/QbVB8ksJD3TJeKrXuPr2lUt1bM9uSHld7XAQZ7Z7QyZF2kqQXiZr5wqgUA?=
 =?us-ascii?Q?srtIflZnbqFV3pTf1wSN+juvzBy59SiVk+pcq/n5aiEpBkneb7/Qh8v1c8Ey?=
 =?us-ascii?Q?eI3I6z0h3ozOn/V2j2ElgQwe/oUFXtOfsnmt56nS1YMhhKkHeQd0b28AXfGz?=
 =?us-ascii?Q?QM/71IsABSxkK5K42nXO4IlJEabzGEZkFhwIfPy5ZQIK//A/JfqU99LasQsG?=
 =?us-ascii?Q?CjFRfPTp5N7vocCX3DXLIj9km7L/qDVwE/4bGuULjrS6wWjg1PxuXXEPhcNb?=
 =?us-ascii?Q?YkY35qpV7aFliF+GOpd7jsgfz7apWU7YUYlUCEb+Z6GQ5y7R6xZGJPP2Oz3j?=
 =?us-ascii?Q?4aybVSruPz9453A+88TU+zsc7BPMfqQ0o0C2D0e8EDu5pBhg5syasuXuNDiJ?=
 =?us-ascii?Q?YME2VCuV999SYf9TLKV+5UcHfV/zbvL3KRPVyeSV/sT/InL4f3SJe6/tW5I4?=
 =?us-ascii?Q?N5UxiL1VWTIZnmsRqgC7jbFhLMs13BsHoQ9s0jpqzv7tX3gPq9DK6f1N/kua?=
 =?us-ascii?Q?sFSENemraTRcSkU3yHxPYqZCq4o4RgUXk/vuLF6aYb8fbfOz986EuLW9nlyN?=
 =?us-ascii?Q?jV3uBrue2Se9JB4NtUX8NEPa7LFsXoo/uVikj9wPDpQkfOyeOVclA1im7b9v?=
 =?us-ascii?Q?0FXJkzUjaEe495b22L4SaOWe0iQqqv4K8mJCX/aAoBCwJxHbc9zbskAc2D02?=
 =?us-ascii?Q?Bb03jLP3ExC80PiBlaITVKGaqqdq1+lIGT/aB9AI8T2TeEIle7YjlKXw6tlk?=
 =?us-ascii?Q?/Xw4SzMNa+gWbtEWniAI11h9L5kSkZmPbyyRqrVXQS9jBJ6wHqAMA7FFAH8g?=
 =?us-ascii?Q?idSiQ6DPSwS5iHKYsTu/ycEBU0AZgS0KbdgVzZLkuVGLrLsqADSDqB9f2Doh?=
 =?us-ascii?Q?X5srZ274hTVzsM8rrtMzkRNWGAZml+b0ILLMO/nEzifALricY/COxCH6g+6J?=
 =?us-ascii?Q?q5wlPzdyRdt2EoACmqBbByo2nFWDpMebdpj79ZxYfvHx173fd4ZFuXP0ug3h?=
 =?us-ascii?Q?a1jmD1pSywdwmP8RMCBybbxz4S5SCeo5kqhg+9wYLPKzUyubaVt+hwn/tz89?=
 =?us-ascii?Q?4yEs32x/HLC/IR9Mz48ZLIQpez1q1qhf0K7EyGA8fOduGkowG0TCJ0xMBkOV?=
 =?us-ascii?Q?kHNMZxut7UAhtLnWgkSK6RWLqGekjn/QVtZxNFGRVcfD+PujbICl/70j6h2Y?=
 =?us-ascii?Q?dKkWunQtdhbazhbU1XjxHTrBM1A5Jb83Ou4BeSqTE+B0rFmZYDRH3VCliVS3?=
 =?us-ascii?Q?OWEc4HGGytOJLa1Ubmpa0w3CVYkFtYA=3D?=
X-Exchange-RoutingPolicyChecked: zbTm+FkTQs17HycNDNRlxnHVwGQV5XCWkKGXnLGhz/+IVxO7QF3fm2hJnTpRfS71a5QvcjKwunmxva5PYboQTqKDwu5Vz0wDTQUzaG5o+T0nP/J4N2LLU78shnkYDa8hzx9U1KNzJByibTwwCs64+brFoP8ejM+OlXAx5PvXgzpGjhrXeVP50fb+ufQgpfJV3AkTnzDUOEBQ3cvOtMutaSUccUkW8YHkPa9Pn5u8jk1f+mzQWWFh4qL2gop391xr7bmpu4ghh/TVsjqPEtRVlMVe6Zt2vd9YQp47GV2TOaWRqokRQYR3pIRfKQrhJ69OMw+lyZoIeNnjrxKapKUzZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaf1e5b-ab0f-4843-2b80-08df34f65989
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:21:18.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4PnScG3d6O/dmcfNIGNavlisbXrSY6C/9yqBRl97vN8vVZT2aWXfvk4HKO+2LrCmc2VbCwdHCqD3k3oxBbIZEhJWoPV2k7KLyw/jmlgBlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com

On Wed, Oct 28, 2026 at 10:50:25AM +0800, Rongzheng Wang wrote:
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
> 
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
> 
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
> 
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  net/xdp/xsk.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..aa6b010192ad 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  		skb->csum_start = hr + csum_start;
>  		skb->csum_offset = csum_offset;
>  		skb->ip_summed = CHECKSUM_PARTIAL;
> -
> -		if (unlikely(pool->tx_sw_csum)) {
> -			int err;
> -
> -			err = skb_checksum_help(skb);
> -			if (err)
> -				return err;
> -		}
>  	}
>  
>  	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> @@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  	return 0;
>  }
>  
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
> +{
> +	if (unlikely(pool->tx_sw_csum &&
> +		     skb->ip_summed == CHECKSUM_PARTIAL))
> +		return skb_checksum_help(skb);
> +
> +	return 0;
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  					      struct xdp_desc *desc)
>  {
> @@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		if (xp_mb_desc(&desc)) {
>  			xs->skb = skb;
>  			continue;
> +		} else {
> +			err = xsk_skb_sw_csum(skb, xs->pool);
> +			if (unlikely(err)) {
> +				xsk_drop_skb(skb);
> +				goto out;
> +			}
>  		}
>  
>  		err = __dev_direct_xmit(skb, xs->queue_id);
> -- 
> 2.39.5 (Apple Git-154)
> 
