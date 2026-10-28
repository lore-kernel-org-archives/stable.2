Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793193624;
	b=AelCEQsZrN964m3sYBPIvMO2qoOOVJjgPbqpQuVRx5xd4v88i6PE4uZdHGoSosF/syRP
	 ZsIHYdPzTHg0FtX1YWyJJW4ZgIYcT/ujKeRLyp2PqdjvcZFxQDAMNjwagECY8iWh1DkGF
	 LY8Wq1K2AZV3mbUNnT5jRTDG50MnkMiBBmWsAF1ERnNZvThenWoIs1zMgchxhDXVr0GU2
	 mmDpnEv2wftWoG3um8giVE91R+7WM7goI6cBbaJEfXb50t4xb7NZiKtsPyQ9B1jnRVUOo
	 liZXAFHK75S+UEmcW/JSHqSCPiMS9nO78b+pUQpDUKkCjphfupjBw4kShnZ5nZ+mB1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193624;
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
	bh=qOnYlkmDZkc0J1Cbgd7wVp7D+hh+8/iTBexPARFA5Ts=;
	b=2VZzXQ0Pxe/47KXDUoRr49Fc5v5uggs6TXfgFvdD3ZWv6OupIR2uWXXtByo+czIThX4Z
	 k+GsKfNkdjT3MRjU/82sw3WVpg1ISsOZ8ahV9Z9sVxOTW1BquWAufwERt6NjYCPDs+MZs
	 qorROu4OkootBmPqO4+m1FFmNrQXoo/rqD6iWEreyDlg5UJg/H1sdsjAqFzTDx5VWN8l5
	 J3CjBCOCLDF3SMqtIsRBjjtyl0Hh4E45mgnnjGG+ztotrM2B+eKL0Mj4NemQiOo/1ozRo
	 j2y6EFKR/HXaxQlHXLqd17d0gQbsPY/sxoOtF4ZFLWvs+cIint4DXj7f2wiF0s9GDtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ToTAUdX9;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F488606A31A;
	Wed, 28 Oct 2026 13:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F488606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ToTAUdX9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793193625; x=1824729625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8QkH2zlPn9dXNbo1LUely6ovbVwZY8HRbMYZAo9fIKo=;
  b=ToTAUdX9tux3/YAc9du+Er2mtsEOwnbAMF2sNGpMkB3Yo9Iqy9iv5vyq
   BOHrGR2KZxZKpgiDx/GecMtZrGZK5Gvfa+wrtqSQx/HyhFyCnAwkGtlkp
   MEZ4uP2wO2dH310s5T/DMR1KC1GCY+NXiiiJuJawwk20eyEVaWQ8bwwbs
   HrGvIM8kulZRQWDQFymZeapNkc3QaVx+BeYrnfyKoP+A9a85YdEaRDrA9
   vWQQUcA6cpPa5v2dFlT7k4Jx+zwOxMPMo4VOYTAAxrlvP9/9ZnOd1XRrZ
   JYWnCYG+Mlio8HTUyk/PwDxAa2d+mEMZV9VSZ6GeHZHzaihJVT37yV02G
   g==;
X-CSE-ConnectionGUID: 1MVT7/81RCOmvYJBt62waQ==
X-CSE-MsgGUID: UzDQ8LdjRUO8TOtmHpPURA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="2019823"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="2019823"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:20:24 -0700
X-CSE-ConnectionGUID: HnIiMoIpQd+R6DhOnvTn3A==
X-CSE-MsgGUID: L8YmhLxMQhm9SV0M7/aU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4822963"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:20:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 06:20:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 06:20:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 06:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcaqhPrlO3rZJCNq9m5CtlBGMq/gf62yaAQta96BrLM1yysiyQNgtuwklG4mrbZyCeMDW8e47Hv7YjALVKOmNg3robgSk9hqKaCZmpMSEyc8W0fSWO6sP+6Mxsbkj7FnrlF5L+poVZoOYJUUKLQKZBZYJEJILv59fgcIMmZ7Npd+dZ/hRsveTB6jLf1KrEWDXiJcVAgZN909blKRpIAd9vi6V/gQmKaQgOMQRictR6CBEhrJcj2pzYtOPpoQviwUWFaXMupapKr0imxeJKhgnh47M5BcKHKdfBX+5iySF0AHyvXQdBuMM04aNuIqbaCCJcTWmvtdorymD9rDlxx/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOnYlkmDZkc0J1Cbgd7wVp7D+hh+8/iTBexPARFA5Ts=;
 b=CpHPe1CCgxj5RV1b9Uv95toP21j+0/lAjG1eDfCi7SZrVrSuaH+Fdjg60cBbfPcihFzH5qtTfhnjpsioEzTLK/9IkfRXonezyg3hTGo4O/dbqDHGE3vwCvsRJoCMbbnfFZfNcszYHm3zH2U5JNOrF9cYA33CnPvjedCtAuqxSCmFHEt04cPPUcAHv2CpNTvkXptPyPQ+2oaVEGLT2cZuxUubFjVNHNBoi6F4ELn3Sy4PGWGYtdaKfuBLOoH10zZDo4SQnVhyKqT8GJzsFM84rNjsvzgUacYcqBKtpkAMeoXvdgb4+5+96u+fligjVCy1L00n8a/oK8DjqbyyDUxkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by LVUPR11MB9857.namprd11.prod.outlook.com
 (2603:10b6:408:38b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 13:20:20 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 13:20:20 +0000
Date: Wed, 28 Oct 2026 14:20:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
CC: <netdev@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, <stable@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <auH2iJ9oXEQRVG26@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
 <20261028025026.11401-3-testwrzwrz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261028025026.11401-3-testwrzwrz@gmail.com>
X-ClientProxiedBy: DB8PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:10:110::15) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|LVUPR11MB9857:EE_
X-MS-Office365-Filtering-Correlation-Id: e303286c-ff3e-4631-aab2-08df34f63705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|261022075727099003|261022115727099003|261022113327099003|261026130827099003|261026135527099003|261021121427099003|261026121527099003|261026140227099003|261021135927099003|261021130227099003|261021133027099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 245Hn6BCV4vhTciLldoxrEMQj7z1bE8vzPrF+oJ3EzAJFF6zxVuuidG6tIkjLw3gSnwTHhXzDIT9yixtoHCn/YFwUokDkOyUbJraPItbvmjhYsqOHcEBU9nYLztzg9r3ETDGg6/OT/EFylWYOOpsmi/NfPR8sBz5absw4tliotXAm3ZafF5+uZTz0ybzBlXBO+2r1RqwNjnk64jeBQoV3fNGodZVzbSkCSciD9haUjg85E4VzrZwNhAYjJ0iM0snNmgv9fIf4cAj1YGuxjp+gzlm4lMF0xGd+b3T1hoLjx78tiiQHF3ZRAMep8Qv8hWy/JYxSjuWAhfOhEyKjKyfxEwqec5W8zhMS6p75HvMeezza/mCkqj4ffbsJqkSMZQHUtOoamdxCDs5z8UMdiNl/OfW54J5wrMwF9D/dyYNwuGDJFz/OjjbZ/PDH5AQUHEOFHAj4OCTdaxgkwT9fyrTRTcZdYvCnHl2+TPUPUSUBqQQt3A0TI98x8Sl/zN4x2SrvWdD450m7hJRSg3aOmz83590G5xY8TvWaU+HvjnRxCec/3ugODWmKUHvIUfkBex46yLWTfu5BE0qzE5nRGjUDdpDIr3VvYKwoqv7zy/HBKfFlStN3Ziwok+AKdCZeNqLVW3S1ofpYP2XYS46nVUb1VoiMeATDNYPYFHf1qoSXAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261022075727099003)(261022115727099003)(261022113327099003)(261026130827099003)(261026135527099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021135927099003)(261021130227099003)(261021133027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4dPfvxoP8If2yQe+Cekm7KB5KM8Nj+HbtHoIHd4y242bhkI2wffLyJCWySNs?=
 =?us-ascii?Q?M7lGi+yBZx8Tc2mWLw9fTVzHoeVFm+rxc+CSvFZp5JdbzMK2rBhEsQ1skord?=
 =?us-ascii?Q?1pUFFcs5wQkDQ6A4y325pSFTd0GI7SF8apxDaisB0RCv6SpWdRbctgmol8o3?=
 =?us-ascii?Q?Jhfg6eFKvl+9siYsDUjd8tGg9Qd1C6vch/aDO17mFiin3Uk7lD+F8mHvgCy3?=
 =?us-ascii?Q?xc5EFhoxK39xCQM9CeIq3pUUpGOqP8Njx+Xz8MulsNlsDsUTNsAE0S8rFBlf?=
 =?us-ascii?Q?YdzgZ6I7yxyNxLDHs1oi2f4sELN7JL3WTpc7QT+0U7RG9FwgKCtpeGZIAKwd?=
 =?us-ascii?Q?F3Gak/JEcX4HdvO7MLDeE8i+W3NGT8TZ6GGCtEE9DuCJSIJXleXCW4DluuNQ?=
 =?us-ascii?Q?FPgUn0mdV8oClXn//uEj+QKnb7arur+anqbN7bJgy4Du5QMsd95SrQTBiEAk?=
 =?us-ascii?Q?8j7HC7okYjIWhDBRE8Q/81oJEnp2wzaqR2G5eqc0Jyc9sGPVw9MPm1IFa62K?=
 =?us-ascii?Q?kos7f8nv5Aw2w4VuhzkCF7rTYVws5xNd1uQpK0HwIGa8vcJ8UfiUQz4IY/d6?=
 =?us-ascii?Q?+8qDY5qDb7CIoytnN3FEs5cY+7j9afp2v+HBt++lSS9rKwq3wQK1/BfDC5KZ?=
 =?us-ascii?Q?MgKil7Nc57HgcBZVeXXsXC/ZcqVU0Te7EhSKr5HJ1S4bUjJwjvIwSjyYd7/T?=
 =?us-ascii?Q?BeqafJj8/451XnMVG5cua4p6t2uvlBFF6V8TWZTXMb76BFjy86h16DcCS4iE?=
 =?us-ascii?Q?9tDM6mm+behbFxfLz5blOtt4rZdd29P8lyPIWIGc8Zv4XBWxPvK7for1/wPl?=
 =?us-ascii?Q?CPGYNzBzzS7yoTBgB7Bos71MqM429ao+312d5GBnt9zWcuHosoXIPvsudQWk?=
 =?us-ascii?Q?aJEV5jXaDqyE2SUOVxbh2aLZV0C+DjFOtpqbKIvzAu7kI3+V5S60c+00fVL7?=
 =?us-ascii?Q?C3EH2mJBL9yYEuSKkWHb7C8tl/MmQx6ZePEtA1nS2V5S/c0BNp/mpCMDH6QE?=
 =?us-ascii?Q?4WilIWd6eJCZVgkNACSAKCXRXY7YDK5AuZ/z0k2tQ7H8D/EEI86+RRxN3RCW?=
 =?us-ascii?Q?CkIhH0Vzqv26fhpN85WbtoQ2JkVQscHrRM2iPfDpklNn/v/a33sahdREzDVO?=
 =?us-ascii?Q?rEbSj/ijmLAMPcJ5VHfYXUz7qdG9uf308XkORETzgnClUZjDDSLMEdJPm4xo?=
 =?us-ascii?Q?IgXwD14o5sY6J+SyFFCaJA1mIsyCGfRFYHf4PNBvRGCl4bkgK80zXFculDiw?=
 =?us-ascii?Q?P7h0fbjQx/SAWCQY5e88tojel0BV+exBciBmOF31UdA9r3KPhWsFKUQGEMdT?=
 =?us-ascii?Q?4FS6osAGMIR8Sy0JVVSCmZ7XjhmO0E+y71XvywxR4092vV32WRnybIgXvB7A?=
 =?us-ascii?Q?Uq+2XpOi5xdjSX/68kQkWC+TpC+S3K8ui5h9bPKfSxVVes8OriF0VjE2ckZM?=
 =?us-ascii?Q?GNWPf5DXU7wi33NDhcftsVJk3sQ78Y7fyacVOcdWZXBrbAMG6ktgiNvn4hNZ?=
 =?us-ascii?Q?W+QHw0SPRDRvvtZr1Bl2+7ny+zQS0W2Ebu6RgfxxkBMhOmFLjH0+JiCcntbq?=
 =?us-ascii?Q?cOkU31HNyde6YxA89DYi+u1cH/BM+oQH1lksBTZtmH0HJ98n8gwdSl5YqTng?=
 =?us-ascii?Q?OOcueyvTg90cdKmy9oZwgL0LTTfMFKEbh+d53hMu37iUlHmLj5nUnhCQjbqP?=
 =?us-ascii?Q?6wUekxxcY7LgcTi9FFdIGwoz3NAyyAS8YPlE3j3bAdWPJIWDgtiRvgtRXg9q?=
 =?us-ascii?Q?enSTKh1JsFejLxZT3CDe6Njz5B6fmXA=3D?=
X-Exchange-RoutingPolicyChecked: cP8nfxQTNY08lvQYHRAQEXwdH5/jiu+iDeKSL4iQNqC0cOt4Q9eQF8zEczF/hO3p59Moo7RMS5YVMK/fgenUUfxFcVqEe+MDz/tm7aXH+I5/7FELPNh5jwU9q4dLZaaiZkmf13MYuBMpm9HQzHeR8roYJWDCZcs5PoWYK6/ZUk6/SUo1srtr27STEZNFxskSZ2JgzZQ1rrxB5s6rBDT6I/wctsHe9Vd2qJ2bspt/gH33PI35tUyPIiiG+TfUUh550XvpZyRH8NQ1yaKOHGmtqWNhefuyIX4t0WeBhcHlIDicv9CU6FrfupCcasaXyewskCXi+m8un+l1T+itxaeXeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e303286c-ff3e-4631-aab2-08df34f63705
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:20:20.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5p93xDS4DKbJZoMVEPotqXVsV5YCQNY9WyAkbUtVve+BthF0h+uwvT/spoM2t+h2vGoKP7oZetQxZFNfQb9FoPt99MgusG6VQPiLdgv7zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9857
X-OriginatorOrg: intel.com

On Wed, Oct 28, 2026 at 10:50:26AM +0800, Rongzheng Wang wrote:
> Extend test_xdp_metadata to send the same UDP packet both as one TX
> descriptor and as two descriptors, and to run the existing metadata and
> checksum verification for both cases.
> 
> Reuse the existing AF_XDP setup, packet generation, completion, and receive
> helpers in xdp_metadata.c instead of adding a separate test harness.
> 
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 122 ++++++++++++------
>  1 file changed, 84 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4..13de524c7fef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -19,6 +19,8 @@
>  #define RX_NAME "veRX"
>  
>  #define UDP_PAYLOAD_BYTES 4
> +#define UDP_SPLIT_BYTES (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
> +			   sizeof(struct udphdr))
>  
>  #define UDP_SOURCE_PORT 1234
>  #define AF_XDP_CONSUMER_PORT 8080
> @@ -56,13 +58,13 @@ struct xsk {
>  	struct xsk_socket *socket;
>  };
>  
> -static int open_xsk(int ifindex, struct xsk *xsk)
> +static int open_xsk(int ifindex, struct xsk *xsk, __u32 bind_flags)
>  {
>  	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
>  	const struct xsk_socket_config socket_config = {
>  		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
>  		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> -		.bind_flags = XDP_COPY,
> +		.bind_flags = bind_flags,
>  	};
>  	const struct xsk_umem_config umem_config = {
>  		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> @@ -133,31 +135,31 @@ static void close_xsk(struct xsk *xsk)
>  	munmap(xsk->umem_area, UMEM_SIZE);
>  }
>  
> -static int generate_packet(struct xsk *xsk, __u16 dst_port)
> +static int generate_packet(struct xsk *xsk, __u16 dst_port, u16 split_len)
>  {
>  	struct xsk_tx_metadata *meta;
>  	struct xdp_desc *tx_desc;
>  	struct udphdr *udph;
>  	struct ethhdr *eth;
>  	struct iphdr *iph;
> +	u16 pkt_len;
> +	u32 num, addr;
>  	void *data;
>  	__u32 idx;
> +	u8 pkt[256];

nit: breaking RCT - I know it's test but Stan payed attention to keeping
the order...

>  	int ret;
>  
> -	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> -	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
> +	pkt_len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
> +	if (!ASSERT_LT(split_len, pkt_len, "split_len"))
>  		return -1;
>  
> -	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
> -	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
> -	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
> -	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> -
> -	meta = data - sizeof(struct xsk_tx_metadata);
> -	memset(meta, 0, sizeof(*meta));
> -	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP;
> +	num = split_len ? 2 : 1;
> +	ret = xsk_ring_prod__reserve(&xsk->tx, num, &idx);
> +	if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
> +		return -1;
>  
> -	eth = data;
> +	memset(pkt, 0, sizeof(pkt));
> +	eth = (void *)pkt;
>  	iph = (void *)(eth + 1);
>  	udph = (void *)(iph + 1);
>  
> @@ -180,18 +182,38 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
>  	udph->source = htons(UDP_SOURCE_PORT);
>  	udph->dest = htons(dst_port);
>  	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
> +	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
>  	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
>  					 ntohs(udph->len), IPPROTO_UDP, 0);
>  
> -	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
> +	addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
> +	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
> +	tx_desc->addr = addr + sizeof(*meta);
> +	tx_desc->len = split_len ? split_len : pkt_len;
> +	tx_desc->options = XDP_TX_METADATA;
> +	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
> +	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> +	memcpy(data, pkt, tx_desc->len);
>  
> -	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
> +	meta = data - sizeof(*meta);
> +	memset(meta, 0, sizeof(*meta));
> +	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP | XDP_TXMD_FLAGS_CHECKSUM;
>  	meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
>  	meta->request.csum_offset = offsetof(struct udphdr, check);
>  
> -	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
> -	tx_desc->options |= XDP_TX_METADATA;
> -	xsk_ring_prod__submit(&xsk->tx, 1);
> +	if (split_len) {
> +		u32 addr2 = (idx + 1) % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
> +
> +		tx_desc->options |= XDP_PKT_CONTD;
> +		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + 1);
> +		tx_desc->addr = addr2 + sizeof(*meta);
> +		tx_desc->len = pkt_len - split_len;
> +		tx_desc->options = 0;
> +		data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> +		memcpy(data, pkt + split_len, tx_desc->len);

would it be worth exercising this up to MAX_SKB_FRAGS ?

then instead of having this flat layout you would loop over the desc
count.

> +	}
> +
> +	xsk_ring_prod__submit(&xsk->tx, num);
>  
>  	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
>  	if (!ASSERT_GE(ret, 0, "sendto"))
> @@ -224,24 +246,26 @@ static int generate_packet_inet(void)
>  	return err;
>  }
>  
> -static void complete_tx(struct xsk *xsk)
> +static void complete_tx(struct xsk *xsk, u32 num)
>  {
>  	struct xsk_tx_metadata *meta;
>  	__u64 addr;
>  	void *data;
> -	__u32 idx;
> -
> -	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
> -		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> -
> -		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> -
> -		data = xsk_umem__get_data(xsk->umem_area, addr);
> -		meta = data - sizeof(struct xsk_tx_metadata);
> -
> -		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
> -
> -		xsk_ring_cons__release(&xsk->comp, 1);
> +	__u32 idx, i;
> +
> +	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, num, &idx), num,
> +		      "xsk_ring_cons__peek")) {
> +		for (i = 0; i < num; i++) {
> +			addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx + i);
> +			printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx + i, addr);
> +
> +			if (i == 0) {
> +				data = xsk_umem__get_data(xsk->umem_area, addr);
> +				meta = data - sizeof(*meta);
> +				ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
> +			}
> +		}
> +		xsk_ring_cons__release(&xsk->comp, num);
>  	}
>  }
>  
> @@ -398,7 +422,7 @@ void test_xdp_metadata(void)
>  
>  	/* Setup separate AF_XDP for RX interface. */
>  
> -	ret = open_xsk(rx_ifindex, &rx_xsk);
> +	ret = open_xsk(rx_ifindex, &rx_xsk, XDP_COPY);
>  	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
>  		goto out;
>  
> @@ -462,11 +486,11 @@ void test_xdp_metadata(void)
>  
>  	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */
>  	tx_ifindex = if_nametoindex(TX_NAME);
> -	ret = open_xsk(tx_ifindex, &tx_xsk);
> +	ret = open_xsk(tx_ifindex, &tx_xsk, XDP_COPY | XDP_USE_SG);
>  	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
>  		goto out;
>  
> -	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> +	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 0), 0,
>  		       "generate AF_XDP_CONSUMER_PORT"))
>  		goto out;
>  
> @@ -482,7 +506,29 @@ void test_xdp_metadata(void)
>  	switch_ns_to_tx(&tok);
>  	if (!ASSERT_OK_PTR(tok, "setns tx"))
>  		goto out;
> -	complete_tx(&tx_xsk);
> +	complete_tx(&tx_xsk, 1);
> +
> +	/* Exercise software checksumming of a packet spread over multiple
> +	 * TX descriptors. The checksum is only computed once the skb is
> +	 * complete, so both fragments must be accounted for.
> +	 */
> +	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT,
> +				       UDP_SPLIT_BYTES), 0,
> +		       "generate multi-buffer AF_XDP packet"))
> +		goto out;
> +
> +	switch_ns_to_rx(&tok);
> +	if (!ASSERT_OK_PTR(tok, "setns rx"))
> +		goto out;
> +
> +	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
> +		       "verify multi-buffer xsk metadata"))
> +		goto out;
> +
> +	switch_ns_to_tx(&tok);
> +	if (!ASSERT_OK_PTR(tok, "setns tx"))
> +		goto out;
> +	complete_tx(&tx_xsk, 2);
>  
>  	/* Now check metadata of packet, generated with network stack */
>  	if (!ASSERT_GE(generate_packet_inet(), 0, "generate UDP packet"))
> @@ -518,7 +564,7 @@ void test_xdp_metadata(void)
>  		goto out;
>  
>  	/* Send packet to trigger . */
> -	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> +	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 0), 0,
>  		       "generate freplace packet"))
>  		goto out;
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
