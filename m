Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717413ACA59;
	Thu, 17 Sep 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688159; cv=fail; b=IJzoh6YeHkrbZrUkwDXnABhn2QZvsS1xQ+aBjqbYsNwv3AlqgUQ3z9Jmopi/nu5MavnIPlDMTXSiwwLcHBW7wmU5jWDFGlQhvPyHhTJRcbR3qwnme7IDHBV6iLA8ERHM1VB4Kjn3VzN/q7swOTxBdg+ILcX9JlRmG1Noqxe4NXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688159; c=relaxed/simple;
	bh=LIE4SHxTN4qWm5Op/gN2f2wN/XLAfsfWcmQ/oYHFkR8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UELIJBghevoCpS+YO7rktlQmQRvXwHpuEPSEYLpYciFOqwLmeKTMunFK3h26tebSGY61c5NOFxXUmTIzvzJ15ncv0bn8lMHB/uCFp19/pugtSNoFXNE00T7Z9jOkSQklL9fzyPr6lYfpSYO6n0HT0lpx79olE4Iw5IwHw9LpH4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMz2Hf8m; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMz2Hf8m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789688157; x=1821224157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LIE4SHxTN4qWm5Op/gN2f2wN/XLAfsfWcmQ/oYHFkR8=;
  b=jMz2Hf8m6475asb+knuIYjmeEhXfsxJAkYqJL/lU2gAyBdKrrLEURuIg
   FCHWGg2FSK7wJhLgcI+9Xy5C1rhIqgc4rllAvmp7JOD5dgFUw44J1cz2q
   HLJR+nkVmDNByPWv2s+k+5zeaSjC6xBZm5rH1QeWBWEzUTIQRBDCbuzVx
   e/CITP/3K8E1KVwUEnA3/+ev3rrVes6lsuTap6oEn27C1ySIutVPGAdFb
   BdZHhPCIYuA7fXf9ZF6mVawUvpPAVucg/nRU1lq0c+EEBaDpyXooQHp0N
   qhqvkA9wd7Cz6hErvMfopr0pig0pBRhxrRVeyde2YvzXMOIIp/yyAqyn1
   g==;
X-CSE-ConnectionGUID: IpweQFAVT2uocj4tlO7SKA==
X-CSE-MsgGUID: Ghy0mB1oQ+esKUUV/FHzcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115696283"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115696283"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 16:35:56 -0700
X-CSE-ConnectionGUID: wuCAqaZLQSSQc/hnIPjhRA==
X-CSE-MsgGUID: fBhlosQCQj2KTh9zxFgVtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276052196"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 16:35:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 16:35:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 16:35:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 16:35:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDLCPH1eIlg/v6dCYECD2zP+haZYnbgu+w4IzkpL7wRi3r58u/xmAgtLaP5Rex0NrE4SECM3A1mbZ18uybrZZ5j0BZdxtxiK3v2rsYxALortBZ4rFkbVFn55r8I8HODgfz5cHCCJHRhtgy0kje3YlvbBRMyl4Et9B6naB8DsYbUFPqdEdAUREIjEowXWGWMu1KgrxescPj3eAHE/5s+tqrFgHi2V2a1GORYIRnYckC9f2bAUwkjF2l1AHc4bpIhF7meUVU16zZP311/bT4m3nuvbkeh+Laeew9R3MWnEEoYYucdzMqfHIUzAiJpRgkujxL6YSqq3l2+qyRN8jXiOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTFIMFVWM7ezrSk3iSTz3fPvEovLn7oo0R6sWAuCSd8=;
 b=fLG2n6G2wnDg/PP0Uv0lBS2WsM+vMat5jIgAEykcpcvsBxaiMdt9vXDY7Nh96YndEmGwCh0oJeVfEOz0qjtqYxAhokqsmOp2hqj8NAkL6Hv95RhmdoQSQMCfBRh0kNsiQwXbRocUdpwwnovQCAAfeOj3SXa+jw9VMtr5Tw56yUPGu/EuDLJ8uo72PDecQEF90hYV75zXHo7xdnUNa1fXy5DCQyw6nheqzr5jaeUWIHYm3ZhnMa7Ov0ymvP5Dkp2mqIVrur27Mix5DDPRYh9fn6hxMF3rRo8YaMHTU/xKiR0nAhvg046VEze+jllPZYmnZTMdaJU/Fhip5foho5gciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 23:35:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 23:35:45 +0000
Date: Thu, 17 Sep 2026 16:35:44 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <bp@alien8.de>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiuxu.zhuo@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] EDAC/i10nm: Fix mdev reference leak in
 i10nm_get_ddr_munits()
Message-ID: <aqx5UOLpXdDnDsi7@agluck-desk3>
References: <20260916091251.1997522-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916091251.1997522-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|DS7PR11MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e198e74-5330-4d32-b8c6-08df1514658d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wWVr4xhttGOgTF9nQ50U0o2nAikrA6ylPNnPkhuzvD0sl+SO5pN6qXm0ZLDjxMM9mrTiQAWYG0ITfn2VybFXWNzvFbcYyyj4JINgBFDaBsh4M2PNpyZcIpLIgpHXzErS5xTsrSisqoatoOj53+0CnOi0CeStW+tSOY+3RW+yFFhziv8eIJ41OyE+ydvBCF+Gm9X8x0aZZKg6ib3HnYFnoovmczmPHbG0uFKrFEB6JFus5hSrLcHaZ+Y/fBtbPDmp9mlFxHKexYjaS59ypLB8w4ZHD6tbSOJBLAAeXq5CBDju56bvO9xNwD4Mnxmb9f/8YMdLqA0iBdlD0KRGvCQnbP/iK102qcSy5Zs9DGk6+5VbhSa1LHbJ5aaetH6hMe8viyMqjmTs/3crJfQZx7S+3nr0bTnGqv/uY5G/MIqRFjYeJC7G719F44ZTsj3OKLJ5d1ocseh1TbEoOqrTOlZhg3vFA1CISEndkOBIK0Hxod9QvhtrUQaMEPyZx49I/34FgVGwvm4imfDlzqxN542IOsq9IjMXmQkhirR39di+4Q2QEHkM2IuDS4NML6yirNA9Jp0rbMpXAEAntZAnwT7k+HQUsjr+Rh0l7lp8Y/QrMFqU3dTXYux3udDW+P3P0CcPLHrzl4FRAAZvZ+BXAx6+xHGgbBm6nQbG/moY7rStfeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSg7kyr1t67AKm3UHNirt3alDJKv+fAGeoEaUtR5TSWTerUPFfgEs/D5k7aR?=
 =?us-ascii?Q?THMy+mkKmrOr8Io86dvFO4BRqPaSCPRQegMarWvVc0zlT8QBjSX4zu+dUipG?=
 =?us-ascii?Q?4KqVlKRfOn1MuTQM32F/NYuxdBiYX55uWY3pu2e6wL59Ca01C7zobDEjMr9p?=
 =?us-ascii?Q?P0pKlfCa1guV6XELdAAhytM85nEBMocqdRWncmJtb9cOS6Q+169CfHg35hba?=
 =?us-ascii?Q?rvVm+ePd19Fb3l1a0ujx6DtGG7jpE2aAOHfw0FQHsr+1hJl1Z2ZUCLTtMMSc?=
 =?us-ascii?Q?dlla4xPanPGTBUeJzqQl2md51s1htioZ/93m+lgJ2OvXYGm5m+zrrJlNwUy7?=
 =?us-ascii?Q?OBhkSAYm+9QsSYuDpwqjnx6zS5xUAFUfB9hZwvNnaq3mdH6iM1L8NjeRuf4E?=
 =?us-ascii?Q?7x5UHSEoGtcMz4glv8mE89c6aLPzx9ycIrAyEw7ue95Krv180yb3DBZca0Yi?=
 =?us-ascii?Q?QIrFO44iStMYPqzZ0HSDt5cj9Sv58Hqm+O1bshqVuNwc64RUDyUxIsCJK3Ru?=
 =?us-ascii?Q?3Ht/XYouLAJOKv1QydQdwIhwbnNnslIAdzHSUyju7q5vlLko0Zb8pKRnaejN?=
 =?us-ascii?Q?whvrU7nVCmjJMP6dFMy2PZMiUtxmtV8bTCEH48fUJ2a6zfvuFw31XOp2MdfZ?=
 =?us-ascii?Q?IZEMp4W+sC4H5vYCemXs1Kt+fAlcMYxn1N5pc+UaTQya24UWns890Pg93xdc?=
 =?us-ascii?Q?XTj1raii5GRB8kp0cfNn0L/c6gSdNriYA5fcx2Jpaec2BrLaUgdOtMqgJIJu?=
 =?us-ascii?Q?VN7G8gI5wMCMrZOvk1004ftFXRTYfM3JerOhlQve4vIVMxJOE5WVGjC1qxn+?=
 =?us-ascii?Q?hQX6Kwi6ELkJEO0rfBPlU6JQJVDhMaFLKMJP1Nxf4hxij1NefCyaw6fW5wgU?=
 =?us-ascii?Q?j0dmlKyKNUCnrZD5+AqjIhd8QmoHfvQ9ZVJVlWYr8r2YSlEZ7Wy1aQNyjR2h?=
 =?us-ascii?Q?pd4h2OVDYrS0W7i4bxoQqyIPPC07f2yoBNrPCzA6mrr2cXjR36nI/ahoeFkS?=
 =?us-ascii?Q?Bmt9uGHLzwq8gGmUc2dZSXrWg7CxJkgtPlof5p0kRAKSd54vV2B/3R2PXRlQ?=
 =?us-ascii?Q?bRaVX8CxZbDEmrszV/SW129WbjmsqMPR5sHRHPY2IIuHuTGhRLvRV3+GWCrR?=
 =?us-ascii?Q?Zemqs+0LRgk1+C/DCR0JE+SEg1srR00cFTlKmli37HXiJhF8lbWaPqg39hme?=
 =?us-ascii?Q?yhJcwsgpudlnswfgWeJATCBx32al8s72qEJ/2FwRxvdUIMNm9Jb5uXefbALs?=
 =?us-ascii?Q?nuhNUoIFvNIrXZuiI1XyHPrTruZjBJR5vjv4VtkhFMxvFAy5ORfmTd9spr9Q?=
 =?us-ascii?Q?TfamDF9mckGsL+7bAiNdHi2Pqt1K1T7QZ/AR+GDzPyQsDUeR8AWsmzZTLNq2?=
 =?us-ascii?Q?dM+YjulavD8PqwbNshNPJCyoSrgKTJJK8xSEKvkYQhnc621JBzgkYKyBt6qu?=
 =?us-ascii?Q?etmV7W+HXsu+8X7kqtxr7g5zpH4lTbG6RJj3hjkB6lpedZkYpCgNNGCDyUfi?=
 =?us-ascii?Q?vHsJWINwAIj1DeX2PnE0sm0zpmrPo7ZFAXo4MpoajA/QcS4jTqrAyrn7EaS2?=
 =?us-ascii?Q?ukuj2NCZ4DT0SgTq9+jWb4lE78A3JNp1YffWQSItFhRBZ7TY2tzLQLXk6yZR?=
 =?us-ascii?Q?8NTGtgvWzisBR0X2eduCL6ECC0nDgS0RRKWJMBc0tibkgPiQZISB5StkHxwH?=
 =?us-ascii?Q?80qBmlDytrwtOUOiZ9k+STt7b6VK/v9vt8t4EZLHy2ltvEnsj9ssmobHcUy0?=
 =?us-ascii?Q?btvkCnOQEQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: hWAlYavWDmiAh1FgyofExKcRiBJMHlGEwqoEK4br1qrIxnr+leXwDpH7X6N36nro1giyGfK0JiEve9nTMrvGRGXVTQDSsOPEgMrrAPyntW4R+YLtfhIeo7KmkcU0UYO5p2MtcSVR2P9sBCeephRHAEE7jLxRLYKVqxEAxNdDWSctTKHnsPIw4nDf5cKgAf+tQuauKumWw2ZaFNnQcWvhNMBrrxRbYQVsBexKWEgw+xj9cj1z7wOXTZIiJQbCujxM3osc6SezjfAu0suTrw3Jk3WW7/cf0sp7u4rN60rT3IwrEUb1RaRDV3ChdJEnfle5DqmV1NjiW1iBR13yJVKY4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e198e74-5330-4d32-b8c6-08df1514658d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 23:35:45.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZEFl2fumrEZduTASn9CEYtC0dBrOvVRX9QsodNbNr9TT3reodyoSnbIaTnkSCTmLY5FXHpg3qXWpdNfsFQJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6102
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 09:12:51AM +0000, Wentao Liang wrote:
> In i10nm_get_ddr_munits(), get_ddr_munit() returns a PCI device with
> its reference count incremented.  If ioremap() fails to map the MMIO
> space of the memory controller, the function returns -ENODEV without
> putting the reference held by mdev, leaking it.
> 
> Put the device reference before returning on the ioremap failure path.

Applied. Thanks.

-Tony
