Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793013311;
	b=iUGyB8JnH675i3BAFQ/LqBT+eWRGlLb2WVzy2P/v1wAcNY7y/nV5OM6KebWHZt4Gufbs
	 aofMGYE7DwQp7EFWXHPCQ2E1jGbAirioLtCBSDZ4febcqe8vn9AYrpZMKnX1NkWaBGJ/w
	 L//aZI4vVIExOS7b9MWfJJH1BDrg8WZpSCa1cs4m/y2cQBj+BZTW8AjvMaLu2btvnbamz
	 RW+rjB9HENptgpYQYaEiEBKYqqmeyH46nR3d7HnftHxB3lWO6tm5sisu4t/NYM13CWqT9
	 GGOcyILRg946ZQmw5f9sClbXTl+XFj5EJqwMZBauz6sIJi3GVnkwcSMfq7mfRLuqQNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013311;
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
	bh=yAAef/wag064Dtu98AmYHsgQ6P/Uzr3fA21gpb3turI=;
	b=ehH/leJ/MX10+3pg4y26S+CJ6SO+hg5FOW5YfPAfhYTmMNiCycIBcruktGi+GWKVgWqH
	 S7PW/JshutTesk6XKmHpJyB60GEDUbKt6P68cp2ClryxBr2uAYr8udTSgrS+SVse796nL
	 VlSxEagaHCT3Ge7DybTxVKaTz6LRxtUcvulM90vjTPIFSfjpH+Xq5fDA4jlnvzlceyw+k
	 HybhU5oVDmecUkGGwqR/0T+p4c4B4xTCqjzJfsQATpyQeZmVt4FYh1EeJLj0mx5R+mT8D
	 w1Y6NHsH1Z568Hdqo493vXXF5oTF6k6uOFwC1aKucwzmK0rU26Zbhk2wmlTQ+gskHmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0GwVGzW;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1A606A90C;
	Mon, 26 Oct 2026 11:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE1A606A90C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0GwVGzW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793013310; x=1824549310;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ar5PHXV2ACS/Ig0A1UhXuXk4u0/wS/sbmqHnEcBlzpc=;
  b=i0GwVGzWeRlA4brkUmfws+obOIXWZmATPX1CxumoyLDUVY7ZBqh2+5dW
   UBOjNMHO6mws9Cx+GOK6IPmUirwW923hEyoAPTMCTtRNGRRwVyT0GIHES
   8BZMonM0CMN2hy+slGYSGUMth6t73FUwPlaCxlV+LUiGyqdYqowyT5l+1
   uIWSL86vez9m8UvrtBunYmu2eJqbfTUuzdlXiDkzzKmQJTvuYtkL1CoYf
   SYoNuhpgxZjBGDWQEmQNoIuIRWo+ssT0poXQhI1fVJ70UaGje1CvkTz92
   b6zjj28HoxFoMdzuUJbx6uRDY/aRKZ4lW0hmTINF2rceXFTr8xOIaEo5I
   Q==;
X-CSE-ConnectionGUID: afL7WNOFR9OkVbB8iUNSYg==
X-CSE-MsgGUID: Kat91mD5SiO+LkpLc7SCBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1567611"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1567611"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:15:09 -0700
X-CSE-ConnectionGUID: mcLWa9yWTUa3NmlaibQMGQ==
X-CSE-MsgGUID: aztrheFyTw61uSGGFnbn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4188447"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:15:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 04:15:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 04:15:08 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 04:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+wpAzpqwRv0Vu4CnALMwgnPZD7ZajjM6JJ25dsQXtVr6M21OfYXJhbQxCsUrfs1juEgOhIXUpDJKsO9QxUnTBHbMabYWDaXJveIdR3Dq3/yF8W1/pYY1fJNUIDW8sREzhp/4/FBfXI/HXAi3YCV6szt4s4KZi2hurzPeMXSq8QBDArSjFKJW0CpWglccugh7XISROSP3Ty6QBymGaWQksRsEPHlIZ+E/1odwTYhK1LPf+ErSSryq2Om2S2vj5y/jbQgy3wWgDX3ekL8tANdODod6glm7zVtA4+vt7ULHtN3h/ZdOR1e/ynrH7v4gx4Js4OZOU0DYfVRvWUlVqz0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAAef/wag064Dtu98AmYHsgQ6P/Uzr3fA21gpb3turI=;
 b=ES8b6FvLTyShw+5+rNTO4su8y/0KfeZUWOtjADdebXvy6BZBUP3NRs4RRVUQq5wzxu90RxQE6R4csgd78SDUiN85bsnDWOUMCw//GVP8oLTNwg0KkQ5ZvrLFuMC8Rvql/rvODwnCK0Ij9blgPczJfWRKVlOXRwbcqB+ybHOqCMmHpOPXure06NQA49UxgyMXQdb7YiG22GOZwGOInke2kMZnyXhM7rShBUxbG5LP4RoV0qGzXSUw+4ZgXuBgWvhM5zqjuEC0esdK8Qyen0qckh8vXmAdXRa6ldZaGPtRPgjpf2sSvcThVRhCBpKZ3w0c43niki5NBnr9HY2h5NkLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DS6PR11MB458838.namprd11.prod.outlook.com
 (2603:10b6:8:52a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:15:05 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 11:15:05 +0000
Date: Mon, 26 Oct 2026 12:15:00 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Jason Xing
	<kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, <stable@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is
 complete
Message-ID: <at82NLzM7g8HGgum@boxer>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
 <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261024141157.59301-2-testwrzwrz@gmail.com>
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DS6PR11MB458838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2e2a07-717a-4544-57e5-08df3352634d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261009223027099003|261021135927099003|261021121427099003|261021123027099003|261022105027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Fh8aSUkozke5nGv8Eb1kfIinF1TMbridZvxrq+jtWzOnQid37nhxbXv3POHhHqqTqVD7xpaJ/pV0TK3BF/BYEgsdknbm7nE6IBn3rEYQAoo6ax3VLNxRqHUuUoaEG/rLLxx6fiU5vfZNwgM4R9LyLlk3WdHmNw/cdGukTFyyzIaHlToe8kqwB/xA2UuZpSSmFGhnRWu4MzYYdhO/b8h0r/Att9qh737PJ/IG3QahNTeCcyCw8094DuKtKZ+ixbFksGxNmPcQtXQp6eVjTgYMODHcPem4xjX4kFZmLgPhFDwOHACvTak/lhi/yiUt1KH+niPGH/XusiJNV45PhdT9UZ3oWHZsERnMJ0/u4AhHpmyTWC0sYWDC8BzsbJNcAW4crvu6hZmGnwXnSv7hA4o4uWRk8FNAPy2/+TNKlpcimmI0sctOy8mtVdexGgUk+NSyraTJQhJz9KW/lLPPUYu+vnOJJO863A5iQ7AlrAZ/t0BrdAfFvu+zk5/GyfxW5jZljI942tx2GGVbDD+ks6TNkgLQyJ42jHT0lE4H/wOps1WOBkhbXoexh1tUva2nTnLii3HxOvNXlMp3Qlq5L70uKDBr3I3DJV3wXr1ASbCxHLGHXFqQyABSMCX6eTdu0+PLnHXsd6auaEbwUynQrv50nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009223027099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYaydlSs68OVVejD5i3iH4B9p73KY2ch1aq1829X00/Bv5obVIN04MIv+HWf?=
 =?us-ascii?Q?VuQ4B4Fp91EFIxUN1U6mQzsE19Ln4okShnZNmWYmMPAcAEF8moa9Gz6XMvrV?=
 =?us-ascii?Q?s3ZxzWpUsRaVgsk0q2hAmWFgLvkEjBPvevduTYL6NhNg+mNavhaWHmQs5Qnb?=
 =?us-ascii?Q?kMJLif3PMxiUxGI6J/1EyZczk3KhLQKw8R15MA0KXEjz9Hkp5qQfRApPAB74?=
 =?us-ascii?Q?FQmM+FOT/ILVSDV2UpBP6o+1pisdGoXyXIKROZgiDNCOR17lILIM00S1DF7+?=
 =?us-ascii?Q?ulUTbybUoDAKP/r6J5BJakUgkJKDXNbzu5MqvTcYvgdRU7LlHulDDRoxmPAY?=
 =?us-ascii?Q?yslgCxBdRJKxDsXE8ptBiKoocJ+/63X4qCjUvsLeoGauChDtZqXhob6CU4FD?=
 =?us-ascii?Q?tTB4u51Zkj+1yz/lxTUMyu68ABr9l6OxyX4KYRrLOizPE9ob04ITAAROo7lb?=
 =?us-ascii?Q?LwNK+Kp+N+p8dZkxpiHo9rb8kTR1szXxGpU+TVyXUDCLlAkyjh7cgZbVKXTp?=
 =?us-ascii?Q?VXbDUJeXSpo7qUXyMvrRYvHO45N6p64/NoBHGU6Ys2WreRi8SRBsTNchAkAs?=
 =?us-ascii?Q?xrlqtZ8ImUfZUlGdOTvJSZ85dEAXazdKFzSv4lbMT8D+zALixyJhCw3HrVzL?=
 =?us-ascii?Q?U8riDAFG5vFg5ZeaztldXoD6/EZDtn8scjcwL3urRcr3DgELFJ8jdGgF1kUz?=
 =?us-ascii?Q?DEmj4payoyJXEEOMW5FIRyyCxTsHp9sQcS3t4+sJH+5PbFo9itJhvTPzTzm/?=
 =?us-ascii?Q?C3iA3UEZIvpY5+xpVmocwwqB9MT8mmMNZvT/9IbWgIGwt20WYpq5jr+Rveoz?=
 =?us-ascii?Q?ahIjFmrwRTQpcT7mZ8nmURyeYDjkyOZbtMcvoPCbtOy98Go2wm414lToCFuo?=
 =?us-ascii?Q?kTI+4cNJVR3dlj4ve9wpuyPVr+sn3kc3O9ay+cJWjjSKGR2sDnc1Iz93m3VM?=
 =?us-ascii?Q?X8MhENHNIWYWZB99fkP6JddCL09lS6KATe0vXVgnGwG56IirnnO03P7pnhv+?=
 =?us-ascii?Q?Wvkb0eV9A28jZw9N9u8vjDliNuYOWQjtqb083L+34y5vhmBR3P3sbTB2bY+J?=
 =?us-ascii?Q?Q8cusjdxgke9VTSXENyzpxQeMaUxnPxrNA/yEAK7Lhh8Kl20llQSSGjmdLnC?=
 =?us-ascii?Q?CPGyNLIu2I8qxO3fWINVq3vDEcOfY8C5fLAteuGkSD2jMzrJCpnHHuQY/VB3?=
 =?us-ascii?Q?QLwyEX2TG4tnELrCvCUT0xNeHxkJCvHtj+dE2/yP5hj7pHBJZIgrMxT9C4iT?=
 =?us-ascii?Q?29Z3gkuPW0hZ7AxdTzS0ed0I5wUjdokl8Sa+kFBJnQ7sq0bQn+yocodpPDOW?=
 =?us-ascii?Q?xjmoaIhpi5L7MN/ozgbmvQIIu+rb5LJTP697WvE5aVXaZPTfxBHMAIwfpDfM?=
 =?us-ascii?Q?jWYGLKzAZy13v8yXSl6jq2CwHUOzTFO6+3+ooIvmEsocRDBx+eMVlii7BEtd?=
 =?us-ascii?Q?cyepJTKNS72Xha6Lxu3C8BD20mEI9tQ584a74lM2a2I0oxELm7d5rPCliI8S?=
 =?us-ascii?Q?py1kf+XWJnsJc6SLdPK8bopAcFhelc4gIQf/dS3CKDAByzX91ytmcaW2zDJU?=
 =?us-ascii?Q?y9ASq8IAZW2cBwinUyDk+qAQ7m9uznV/NR9p4IJvif9ffFMEE0lcRKI6uZEM?=
 =?us-ascii?Q?1NS2AmQFGHo8ul5wI+xMDAn/y9KMGQLFHCAoZoSkyH9EGLG8YQJe2Vov0A7k?=
 =?us-ascii?Q?K5VBrdn8I790GCAcJzP5SQmIopkR/PLg4sd8SJlhRYKu1K0tIIvNKgT+/KBu?=
 =?us-ascii?Q?VXOpG+jnM3HZXy3X7+pL2QLHVY122Ds=3D?=
X-Exchange-RoutingPolicyChecked: KOTYBCsiebID9sd2Vx7m+Ep/m+jtFweCrLb8voYqrs0/3aqAGO3a7SDxc8mzb30hupSVOAA8BW4LZdssP4XDBncwbK2JetQsCBKxKEs52d5bwExKM+51nfDxT59kA4gaLL6Ac5P27RSiJYCJcbG7xjS/0S6/o8kEwQog+0B8NACeokIwiu/LsiSP6PMkou9dl1NnlB1iGdUv1pbuafUuu0eA02GHMcsUNwMT8w1HmFgSpEaFaF8yLFZJCxukptvfBdlf0UyKvxEjWkuMESOr1hqk5uRNSN3Jobl09DyhtIZGaXhvpUy64GrezLq1+mryLjLb+h4efgd//7JBeZwd6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2e2a07-717a-4544-57e5-08df3352634d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:15:05.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8xjpMH1pGxQTanGNPpL4sA0ao+zTYwo3ANKUThIMkAPqzumbAYFfx7gajbz8Z7OJ1E22p3Wq2q+zrPoqkJCY/zKfDSE5uXIWqIXMghYmU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB458838
X-OriginatorOrg: intel.com

On Sat, Oct 24, 2026 at 10:11:56PM +0800, Rongzheng Wang wrote:
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
> ---
>  net/xdp/xsk.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..65be2a368325 100644
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
> @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  	return 0;
>  }
>  
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
> +{
> +	if (!pool->tx_sw_csum || skb->ip_summed != CHECKSUM_PARTIAL)

If i am reading this right check against ip_summed is a way to tell that
first frag had XDP_TXMD_FLAGS_CHECKSUM flag set.

Agreed with Jason to preserve unlikely() when checking pool->tx_sw_csum.

Regarding skb drop, I am leaning towards this, I don't see much sense in
retry when packet is malformed? Not sure how this could be communicated up
to user space.

> +		return 0;
> +
> +	return skb_checksum_help(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  					      struct xdp_desc *desc)
>  {
> @@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
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
