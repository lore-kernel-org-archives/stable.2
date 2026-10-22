Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792689018;
	b=nbdbrouwqup1iwm8DgQpYUO85CGXkPvwTMNfHJf1cH6tffvzaHEimsTZvtm9JOEG4WK1
	 /tFR2+Wp2bJpfkEDnAVyQqbgGFgOJx/jSWYkUv40x6vXg1SZ1qTqSU2R8uOlzsa/RO+3E
	 6utS0WsJfJYrwRX8K2qvM/ONQlVN3k0ljnzRJN1e75GgeBMekY7QJ66+bba3QOIz54U2/
	 i/i/z68Rd5SudMlxXOWNQhFXNZqlCLPHmEenCh5IS5/6jYpj5u5XjAcq7nWa4vcY/LDYB
	 xCAZdpblFycxn0QNnaQQ55wWKphRdsvDajgWI2F6B/nAWHgqWtR7CMWTvCGfHKZFGnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689018;
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
	bh=szRl2wYjpBQlnh+vOb9NLRFWNgXcdBKmnGcIvjD1E2I=;
	b=WAev9cLMWDg+KeiNhMC4nTZRuVqa7z/7+iSR3OA2Qd2F4RuWofJfSUWG09z1Gl2oVGFR
	 8Pc5wxixwG4WKTDF43F+SbiwFQrMd1aInQjgTlgu1D3JAqweK/5BsmFoiX+GXwNhaMgcx
	 2ABpN7qXch/JhKQarAxfLSX32qEgNjEvCPsGGyHImEQQhcmg6Ghct2DvgUDiqw4CAV8sz
	 gkq9IVpyHUwhr84Npt7wFzS4H7Gyq+adfklZhf6qTxn9/7J4P3RKZE+RImEseFHVjQOeF
	 Ehdj4/6F/4L7QqTYWBMIRxMaHsuqt1btTFi+pOb0vkeg0BQk5pIMIsicRqoT5r2Fn2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eVFi5bAg;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B027606A31F;
	Thu, 22 Oct 2026 17:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B027606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eVFi5bAg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792689019; x=1824225019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xkH/BRlpQKywpup9RmazyCw4mpeQgkFgnKl+OcUe3+M=;
  b=eVFi5bAg76EyWgVaVQRVGT0PGlDdrlf3AeHdVurBM/dOAUkg2RP1DFsx
   UiyJKMMClMGYCR2TumcU/5SBZfuEDh/y95MwImcrFNm2M2+BHmg+BgMxz
   6CfmBCtCfkEjsvD3nZDSJ8d5mYxcZs72RqYiR5nWwXvR8BYJuWFn+xFc/
   g4tP+8QAnHGMTiL1DCDkuH7FgupeTWT30hx/0Xcj895u4s0T87es7Uakk
   JnQYO213R+MxGDbni+b3DPrVKxJ8T/vGqcOy2MVx9Wcpq8jo+8WPCX3Ot
   l5G4sYpzHP5MfhmBOq2Jw/uYORurJAqORsnPEgQiG+E7rs8ypcDBMmuE2
   g==;
X-CSE-ConnectionGUID: XDs8aL9nRhqo8bNWIhat8Q==
X-CSE-MsgGUID: 8Ko8+MWWQj2Ewl/lMtt0/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1460192"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1460192"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:10:18 -0700
X-CSE-ConnectionGUID: dkvkhDD8Q5qHZ3YiSLIYtQ==
X-CSE-MsgGUID: mGpCXpwxQ4eCQMAG3SCiKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3286905"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:10:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 10:10:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 10:10:16 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 10:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5oXphzKLT56hC4kBVE8OnDW32VfZB2JtWKc4M3CjUTUgVx0GGm718RZosbaRQ1QO0HcETnfodJPL2Fiop+/FQh2ckIdpxhCEAXr0zesOFFr04Xla3IB3jmkGVztoo34FmCc8XhvzfWlb8/k92xNMjNWFS45AiqPFSDIZneZ5yfMmAv7wIP9WoOvFVzZnLaIph6bxp3b65Q/ThfL3yPi/9kzbIINOPSOVpMMYENuNXTUsG400dU+KkCv1Ejy+D+M20IohXJ5R8wqylAq3rMU7hnXYrOGl6komrYtjuELKXZ3/MNQDQZ1M6Yh89QfwsClTqzf4Vm3POj3ZUhF4wPrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szRl2wYjpBQlnh+vOb9NLRFWNgXcdBKmnGcIvjD1E2I=;
 b=Gh7N80zFurSm1/60KKYJ0hVfEWgdcBqgYtipN2GTYhvGhTMU/weoOLwK7F87oOB1/gaEJiexb7zVFCwq/28UiqdqtBP9YqzrAyaJrrFQ5WN91iCF7I4BUYwMbU5eswJ+BVU2HZlUo9PVdtyNZ3SHXvLR/CuDLdP8RW/AvyRDKaStCCv93BIOSJqSJ4erEH6v54GY9kVFkkAt6bq429ZRCBYTNAMP7XnZJuwAFFZbk++LDML9A/fBf4VBy95TSWWWZ2MNizxe3C6G8PzwdBnIHkCrNHP29MxmwrrghpY+wmey+KCrA+h7i6F6yuGB2SDhzgXsex3+mBt0PhR8fGGtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SAWPR11MB9709.namprd11.prod.outlook.com (2603:10b6:806:4ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 17:10:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 17:10:14 +0000
Date: Thu, 22 Oct 2026 19:10:08 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <sdf@fomichev.me>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] xsk: restore UMEM flags after failed pool assignment
Message-ID: <atpDcGN3zWhixRj1@boxer>
References: <20261021224705.2078753-1-p@1g4.org>
 <atnKf5dNv0Vk1sCo@boxer>
 <xFs3DcEr8aRQdjIeuzTZ4fmeQ3Ay8_x_94KB387XkLZDamj_rLyn4IGiFdZMi0u69fpiYrPQq9P6o1j_xixC1WbF-tl3JxDLmcMZZkPk70k=@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xFs3DcEr8aRQdjIeuzTZ4fmeQ3Ay8_x_94KB387XkLZDamj_rLyn4IGiFdZMi0u69fpiYrPQq9P6o1j_xixC1WbF-tl3JxDLmcMZZkPk70k=@1g4.org>
X-ClientProxiedBy: WA2PEPF0000089A.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::651) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SAWPR11MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d3afc8-d146-4c74-1406-08df305f56ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|11063799006|4143699003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X7en2sWJ5npDLbfPhoDoO8hfU4/JKclkZBGTUb1AXsu+tpaUsnqZNr5l9MSk1QBxlopHYil0I6omzPXNgzBkYdMkvv0L/9XjijWT84JJYNCnSBTIY8ATWSUdlrRxjmi/m8HiV2sAU2br02Q1sHr/d8l6jlu9ibJNZI9sRC8loPx9UiMvVNap7JX2xJ0mUyrrZlTMzTNw852yeM2zIMy90kgoo6vaxOfcfnlTnzN0wr3GGhl5r5fxzl1QqC5ALG+dR3PM36u1Ljlx0vORS+OaFA7awUTdDCSUQC+EaNV4uTdpuBKGwtRcny4M101s5wB8rLGgyjgSNI00YIbvLAu84BKA+BKPrw5aS/oT2Vyc5xEVddXj2J6jYa3haT4tERn3AUbkhF73X+5my821QEHONyFYNNJZevHTD/hde8iCrsBFa7SYZ8NgQP6DheYrqGXV4E+n9dLVk6pa8UmDytTLLBtKgEc6Z+1ZQIimO1+Tvo4AA+tHP63W1/qLqZ9rJRtYj4DC09yZuvAW/9PanB/ypQJaYXtWhEsMPwZRj5lwVS3s19m76ROYazhLi03gFUzJBFRXO7oL6PRRQMm/PLg+9b6gQZuBYWi7aqAJek4Z6WeMjbV6H+J3eNImcIw6Ycv8BeK1jQyaD4qAkdo0nwNYPmUvxjR3Zs6ErZFiSF7YZ2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUCuOGVhNEUKn0Zx/iIqLjr44RvaHSn/lN2zrfHJNHR+SVIrHVs0nruY/S01?=
 =?us-ascii?Q?n0Sp4UnxHVGvAwiOATdKQeSp2cBY8sleq30XibCj11ssLPL/sE481frXqlvM?=
 =?us-ascii?Q?aA+LvNEarvvb2XIplmK/f2PYPwaC2tUPGtfYYyktwJmxo1/S1aVGfT5QJ2F/?=
 =?us-ascii?Q?MMwjXbzyzfKsxcshDBRU88w/IvfRuxzT7xszcYGq9apm3SRbMcve7Sb3xjOx?=
 =?us-ascii?Q?Opdxz7k9a5id1rgyyylTjhpegwZEKCq1XAZmJFJNQyPIF4FAstwlr5kzwmhw?=
 =?us-ascii?Q?AWcwaeD8fUXOzNnbkDQIbALL3qhNcqKVA7qqZ/8X/KeHcoebZNqKCyDiQPDz?=
 =?us-ascii?Q?GA/TaCGi/FmON6V57qg43jgw6M1xl9G3r+5njVNMbfo8GDGv3mQ+Vjnh/ciN?=
 =?us-ascii?Q?QgfAG8FnMBeb/bQe1z3dF7u/gI4scHn9TtRKfarH3sAG6aAtEBPRwvai1erS?=
 =?us-ascii?Q?1nZ4xQR8F5G/iF+8VfKt0v5NJ1Iv6eHZaWZw7rLdw839b1AbEsz5lrqYN4Zl?=
 =?us-ascii?Q?MnjibUJ1R7HG6mgPHmwIW7pkueTBo+ISmtDILYXB8JhJG6oIZW2AeV6spaX6?=
 =?us-ascii?Q?XJgD2+s44r6/Bjy8L4bfyp5lAHq5lZFSurkJMX0BjG0J21Aiv03IEIkL6igh?=
 =?us-ascii?Q?GTs0ME8CB0k67ftwQH61NfEFcXgfrhtHAf5CZmx6prSpuDHyH91phH2AkJi3?=
 =?us-ascii?Q?uB1dE73O3LTGgLWv2oYMMiT0JH9h60XYtODgTFs4wkOgpy1lstAqqhmRT2A8?=
 =?us-ascii?Q?Ys4/XZgQidmN7tvupWLNT5cjJn9MnLnd/PgJy306epAqBYPQjohuNvGLNstN?=
 =?us-ascii?Q?MZw3iLnuLfZNdNwyiNp0US/OEwW6Wxnp+J3l6FVYgOmOn7+WIvtucHqF3Tdu?=
 =?us-ascii?Q?x9VkTDr6pKw1UTEEtu2mjp1RbzU4zP6X183INcHTGuLxKFtWwCTslbfzzNP5?=
 =?us-ascii?Q?34NPZ7d/l1QKyS1zpPtEvqpnO6NIbQK+Y6A5+YdwQ6wctVKaxVDt51JW+Bps?=
 =?us-ascii?Q?EbXQdwcYS1FzMs/dYZyRolBCoFAL1mNLGAMibXTU5N6dBUwPZ17og2aX/Va7?=
 =?us-ascii?Q?J5HEeJnFc4M09vyRhqFRUd3J4stb0Qzv5RNLRyVDRmbg1P7jrtWfZPWtAGmZ?=
 =?us-ascii?Q?FjXBcle915c44HBnATFaGnpo2IU6mvtrSE3MbheFrQXmfEPJUR398Hq69+NR?=
 =?us-ascii?Q?8FjGv1xPCd1PXanqDJY0mRRG4el7vBE7quwfr6aXf6/AJkkofEXqMrZR3c8o?=
 =?us-ascii?Q?u5DmJ4AtQU5s0rfHY4lb76bmPu7G3W4UIUcv+LTQAz4MpAOoT87ySHu5TqFi?=
 =?us-ascii?Q?qWE/mvST1cnE9xdNM8WGHd8pfCDzK/4Dmw5UeU8iKssZm+4ParYoP/RuKteq?=
 =?us-ascii?Q?PHN5CNykG4E4AkDwn8rD1wuR6lAhEaI+wasjh59vXVp67PYmnTWf9S3W4ahQ?=
 =?us-ascii?Q?dCFdBBFJfD5PIY1B6QK3hS3irIwp+39Vg54qRbnfaUbtswc/oDaYQmTKglIT?=
 =?us-ascii?Q?gCLXG100eICejE7jjn5/r0GWnnm62okfraC8ZUqUK5KjBAjBazL5HkW6rNq0?=
 =?us-ascii?Q?4a1f16GhGCdQh+oqmE/kZwQNTnByoL2Ukn2OF/EhIKM5JevregnEAn2BNY55?=
 =?us-ascii?Q?EylbL1ogA3c6uBAmBhfEt8yiKluILwuD1ONtl5ozhix55MQ7ZuWZQerrvX4B?=
 =?us-ascii?Q?4iCfZIMNZfWV0oVQwSRsflGqYoOMxe5Z9czenKOmao817nAxRYqy4LuoAbcP?=
 =?us-ascii?Q?/hO5e/zrL0B+SlS4wig76RjrJYcy6PM=3D?=
X-Exchange-RoutingPolicyChecked: CRb98PhaiBN4+hKWsbI7rUauLTxbdTVUUvC6CGnCL7Z+BzrNA9DmoNrvpSaQ6mj/BXEzLsLFI3M4nlwADLBqYaaIQnfV/071clbBMJLBD9hZIuxTkrCXCDy1e279RGUNXPtWgV6/sEduMGCSNW+m2uav1OpveT3MNUOvKwa7tpECAZ+wdDACxNHE1QTeyfkgNalOsiu0IUCgh+gUbwm8ip65/LSQwZTX4pIyeJ/X76zoLDEB0dSU+PImzg6uI2csGws7YOK5WnIGTVVImubhIeTMf4pWh6Qe2QYepspKKRwO1QDiLi+uIXx0koCApofoGo+6v8hXsFcV1fIBKV8VYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d3afc8-d146-4c74-1406-08df305f56ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 17:10:14.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmsvbc+tBuOCJKlhyvcIZE2gnSdONVdsPZXDczCAQXG+B/tfz8GM1gz5hz+LRJ4YdqWZYMxMUkJVqsBQgRPC1y4tD3LlIOjzOi3JtyUoJCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9709
X-OriginatorOrg: intel.com

On Thu, Oct 22, 2026 at 04:55:59PM +0000, Paul Moses wrote:
> On Thursday, October 22nd, 2026 at 3:34 AM, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > On Wed, Oct 21, 2026 at 10:47:33PM +0000, Paul Moses wrote:
> > > xp_assign_dev() sets XDP_UMEM_SG_FLAG before checking whether the
> > > device supports multibuffer zero-copy. If assignment fails, xsk_bind()
> > > destroys the pool but retains the registered UMEM. A subsequent bind
> > > without XDP_USE_SG inherits the stale flag.
> >
> > so you opened a socket, tried binding with XDP_USE_SG, failed then retried
> > without the flag and you noticed unexpected rx frame size due to kept
> > XDP_UMEM_SG_FLAG - do i get this right?
> >
> > socket not being closed kept the umem alive...
> >
> > >
> > > The flag also changes RX buffer sizing after DMA mapping. On igc, a
> > > failed SG bind followed by a non-SG retry with 4096-byte chunks and
> > > 1792 bytes of headroom passes admission with 2048 bytes, but programs
> > > a 1024-byte RX buffer. On I225-V hardware, an ordinary 1514-byte frame
> > > is truncated to 1024 bytes or 1008 with RX timestamps enabled.
> > > Restoring the original flags eliminates the truncation in both cases.
> >
> > It should be enough to state that sg flag presence takes into account
> > tailroom size and therefore has influence on final rx frame size provided
> > to driver.
> >
> > >
> > > Save the UMEM flags before assignment and restore them on failure.
> >
> > Regarding the patch content:
> > Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >
> > >
> > > Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing umem")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moses <p@1g4.org>
> > > ---
> > >  net/xdp/xsk_buff_pool.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 0ebd4d46f7ab..7750d2ec4ee2 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -166,6 +166,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >  {
> > >  	u32 needed = netdev->mtu + ETH_PAD_LEN;
> > >  	u32 segs = netdev->xdp_zc_max_segs;
> > > +	u8 umem_flags = pool->umem->flags;
> > >  	bool mbuf = flags & XDP_USE_SG;
> > >  	bool force_zc, force_copy;
> > >  	struct netdev_bpf bpf;
> > > @@ -268,6 +269,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >  	if (!force_zc)
> > >  		err = 0; /* fallback to copy mode */
> > >  	if (err) {
> > > +		pool->umem->flags = umem_flags;
> > >  		xsk_clear_pool_at_qid(netdev, queue_id);
> > >  		hlist_del(&pool->dev_node);
> > >  		pool->netdev = NULL;
> > >
> > > --
> > > 2.56.GIT
> > >
> > >
> >
> 
> Right, evidence suggests igc handles it gracefully, I had attempted 
> to provide multiple examples of real world impact to satiate Sashiko,
> but only igc survived final edit. It needs to be open for the failed 
> bind and successful retry, it can be closed after and bad state 
> remains. If you're looking for greater impact, look at stmmac. I'll
> send out a v2 without naming drivers specifically soon.

Not really needed to go with v2 with reworded message. Let us wait for
bot reports first.

