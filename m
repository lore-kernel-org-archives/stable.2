Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759348F015;
	Mon, 21 Sep 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006679; cv=fail; b=A09Ohx8ALrHbkxYv3dsVi5gXldq2jVhDzTIfhYDpw8W6GQwc+dQz9IoIQCfvIj1qelXaA49NvaNg5/g1ud0pH++60RWxuQENZRjd8P1hle4CrzKWo3hOl1p+xY5LMwatg1LHLA7ybteAQNkgxBIJ95Nslyh26pb8eQrXFmX+TE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006679; c=relaxed/simple;
	bh=dV9BBXPx7gwNbhvGtrYI8PSDeYZNNFoVqYEjrckucE8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SNOme+2VXKteylvggrhN2EVK0gjIuoLrjBdzkaPTvB7zOhjoJ1usSvuyQkP1v2DpiyXs4UoXhO/BLgv1PIm8tDV3awWOSy2fcQYXEQZW5zWDoHBpJ65jUe0fXqGIPgabwmQ5P4qe0hU87H2hG12dUKVAO8ko1JrZ68uYTC/CG0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6z3nJrF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6z3nJrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790006677; x=1821542677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dV9BBXPx7gwNbhvGtrYI8PSDeYZNNFoVqYEjrckucE8=;
  b=i6z3nJrF5iDTLM2AzHoVn8aezHNIuqEMIEQK+Mi/3eSwxOuDxnKGW2HS
   Hp/+IMFaKNyAdmu6NaUUqmg975JHUt3Z50AF/2cf5xWdG/7T820dA6vTC
   b3GZm/xq7oBOVDqxmiV7bvFT/kB7DLo+getJJGRYVgwAFX6sLKnFjeqCZ
   D8y0C/PRQDGtdrjnusU/HVfKKQQlXcWzwZi09oF6hxlb6uMD5CYySuiyj
   IjFOvPPrluH2YXrg3uBq9g2xTziOGOAt/3CVfCm/P52AlL//ly94ABSIl
   S8dc53whS0mcAeSXotJXFEvfgk3bj8FFXGF89dBvE9/xZnC9Yy27RzLAi
   A==;
X-CSE-ConnectionGUID: qkynXr8fRnWASoYGHbV2xA==
X-CSE-MsgGUID: IpkeZu0KROmVWXHRVfwvVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90402500"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90402500"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:04:36 -0700
X-CSE-ConnectionGUID: LCg3XGJ0TQu+HbVGuMy2pQ==
X-CSE-MsgGUID: /PIuKjnPQzKZn/I4FZME/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="298947997"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:04:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 09:04:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 09:04:36 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 09:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWHDEjS53sd920+eSxzKvZ+rdcv2VFl40hRl2XMFX6j1dg78CWSHDXspHykYrUYmZuTHb1ubtwBrimIerzRxZTltJlhYM/ODuxHRxcWOj+zY78no3Gr9ewgnvsCZ6cr9HJivQF+HfCxohQzp6h1myDCX1TpX4bo05zBplDCXhiOSw6iJqnBqhKSSsMYz/ecmjhvSGfDUc/Kky61EdwJmP/7MbtKEbHAgMcHkIt2QHGUpT8UPX52jpHyaHaMI4ai6uxtuf3/Hk7z8V7XtBPczxhs31Msd6xvpJozH4DUyxJEJn5fs0ET/OQf+XWiabfHtfOnAM/OYcUrauB2MN2eeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peoEBrLgrn1Q8+58q3nfWMtLp4z0ek9uPoaFnGD7y1A=;
 b=HABCTVvXpBTAXVIWhgtcWz45OtKtBWZz4buDdqgFB3Pukl6H4bkEya39qBFtNnWE0sFw/P+mFwFMe8xJmadATmTegJjdOd6HgYZ6U4t3Enq+1+kxJ5CBkRymBjF0BeZxrUsKCHmKRwukyaqGrANDLyeTlw0bIzXjN53KUKpQpHv7NGoMnuLYzWbhhxnSnGrz5k10nOt3xWPyUCxvy2vWT8xghW0qT2ye/BtoHojJj3Em+KrxmvywK56zSCI99r6Vj1TPBTlfaOKCxOWvRq6WQjSuU7tHRnCbZ0XqYWJmr/6L3qJhEtt0aMTI3QWjKSXGBOdYxNXDm4Zu8CoXv7z/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:04:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:04:31 +0000
Date: Mon, 21 Sep 2026 09:04:30 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Wentao Liang <vulab@iscas.ac.cn>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiuxu.zhuo@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] EDAC/i10nm: Fix mdev reference leak in
 i10nm_get_ddr_munits()
Message-ID: <arFVjp8k-3kvSkhf@agluck-desk3>
References: <20260916091251.1997522-1-vulab@iscas.ac.cn>
 <aqx5UOLpXdDnDsi7@agluck-desk3>
 <20260919053437.GEaq4e7SFEZqRzsjim@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260919053437.GEaq4e7SFEZqRzsjim@fat_crate.local>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2d6f12-d6a3-427c-8f8d-08df17fa05b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JZegi0pyt8T0NgdSC1O9mUs/C6sk+puHhj/I707hMH9egXLb7GmIVL5JqWCZmUbFbV/YeULYp80yBKgnqIwRbbbhynI6AlxKBDSHBgX1aEbCPIBxJ5UOlCVsgzBKlDDfDwEglgXc+4cCn9GDui8h2bcApqWQhyq5Kx0qLSQT1F+oUZkr+1dClQai3p7iI1PLvoOuVl0/pzT7Yd8vMA1z1DYc4c6zFuqIxIll64pGsAxvpcJizh3NVfW+Fsqb4LuPQjyZ1vaCswPWjca6oohPXmVt0gzuYKgfhfjOJPWPfN7ZYoz056qwp1dNwXaB57KyPXaQF9Ak5aCjgCHJPw8SfsAgVXRp2EsJMPHp69RHqKbsW2BejHyPXfXWEKfOLChvIEG16C4oBafeuvEpE4cUtGlKsmnsFU8CWAIkZOSaU2e2t0dbKdp52WjLeYYwVHdypFXJ0OKItKpmC418BW7ewJ0dFGALQyd4FA/4H6NQKylizLjmDTEqz5i6sic9kfwqkL1QSYC65DlbVUYtuDBNfzPsHtDO8dU7C2d5xNt5CeTgGSUS7r4i+G2sTgTqKgy5M0P0ef+kiNzjsbiiJd3Pn/In2xYUNlcNu+d6XDbpt0hjovqsbJP0ipdnnKy8c8kilXesoHAPC9BaFlRkT+2IT+oXctTlKFQq+Xx3+/LLEIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zB8f8x3ubImdK4MMj0rvx5ojd1uM9QX380aDn4tEeXfhT6AFjljY+jBFzKR?=
 =?us-ascii?Q?jQQmQ26lxKvI5MzEzqFALrQxw4MN4op1zde3Ie7YEnKr5N+oD9Z5TeEsqM5c?=
 =?us-ascii?Q?/ZVqpFCet6TIY/LcfmaLqda6He7nZgk62go1eNXHRdiykbUqjIBLxwiCbvqU?=
 =?us-ascii?Q?ARcQSDqtEQ+VwKS/kNWhLJ4Q0yKb1cHcMxr33FKSCU7CvsUvUZJJSIgwCzSJ?=
 =?us-ascii?Q?Px3t7gJYkADveYj6p/gYESy1SDtBgLsIcYos5Naq6604TMN16sRa5C4p+XVP?=
 =?us-ascii?Q?J+1OK70xAK8lgKGovIQ6rUbkhPH7EwMTjaN57B9I/4tp7dycmmGIh/Tdisu+?=
 =?us-ascii?Q?NVugkgLRk0nUN9DrNE5yYRCcT7ALACwOI1sryCFc06K5mJ2fe4/So9Xo8DIu?=
 =?us-ascii?Q?wb5R+n8+zWIDkehRKQaVxEQ57yo5XI5yqYBEvHk6YhPsem3hlqeO0pvNVwJ4?=
 =?us-ascii?Q?EJrt9P83g2C+nFgcddLq4FDRgG5G/fUyFKhmXjkmp4N9KvzNToOaqeWOGDbJ?=
 =?us-ascii?Q?lKFiBrtulNTb3HVB45Qcus03MAJdtjnzJdobrXE/Rc4slPxtEJVFCihql3aF?=
 =?us-ascii?Q?JVVxwNBs8enB2TsC+G1ytzTUJxs8YABM9x8rMoGsNlxzaVsXIYT9kMp7Kkcv?=
 =?us-ascii?Q?RCxGDTzQB8066xYwy/MyXMCV50acq+KBUh9L/mRvuiaMcmCfOpD3NZXZtq+X?=
 =?us-ascii?Q?4IWaxamw7WXK6vjmAq7e7OmB5cX1FpypnOq19c4NzJ/Ra0uR1dKzyd9E51se?=
 =?us-ascii?Q?Fc1MlkK2CzHsyTJEONelvDiDjjqZkGD71k+aqCBejZYgQGJ6I0o5zMBrc+g7?=
 =?us-ascii?Q?t+JZCje+dJ5d+vK34pp496+piUuw0DojmnqJBtSEyU4VaPnc/pv9qhI/1SkD?=
 =?us-ascii?Q?VB1ym8LfniY4AXO/9WBtVmTEEmRXLNf0LywDGIlP1FidTseGQbvGdhqcNypk?=
 =?us-ascii?Q?/M/cLG/W85FwpjbLX1nHQCNjZO5In8vI5zecz4GraFGOW/7UCOT/X3gvaaJc?=
 =?us-ascii?Q?OFx9V8wpXRXqKzkTCTjZN8XtK/aewv378t3fXzUR/ESi3o9FLqzAaC0AjI2T?=
 =?us-ascii?Q?kvF3z36NJ7M+A2BENeJsrp0ZMquTt3wp+6TQRRGJO/Enea1d+LJnPa2/qMAu?=
 =?us-ascii?Q?bIeSJMniqgSX0OEuHHrs2HgAY3IBNsq/GaCHvMc5qEcr+UkgqqGjtw/I/hwc?=
 =?us-ascii?Q?Q3Bf68M1z1T5ZHeiQzHzN6QsSc3Oi1hObBDexyg+7LC7Tos0xxljoPIkocHf?=
 =?us-ascii?Q?obNmiTqxcNR6B68ToLb2Tn35UcKIeL2wW5PVqtvr5+mQ5NRo+NPsQF6nfjRM?=
 =?us-ascii?Q?XHnG8c5h0q4h12NRy5S5dweqh9MlrNtxPe+uYfyaqUmJ/IrdHomSNIdYWjOl?=
 =?us-ascii?Q?xen0Y5xcxi0M6n4FrLAXW4fbgKz69LxuB1g4TmfYYOTSaqzW9PXJiAsvdcfa?=
 =?us-ascii?Q?04lEgy0wTkT9X8B4Vy+R2qi99O6az3BOtMfJr/qvslOXe7foZoyti7kyW1aJ?=
 =?us-ascii?Q?AeMcrRDRs+5Y5jvp4Z+GfmtqMFKlNDbBlirz9spiXTLxTbk0wueu0F3c6zUK?=
 =?us-ascii?Q?47jV6z8NczHX3iC5yrOd1XUxnGa5gUCpVi9w6u7q0NfMhSx7ewQqvCpxWrCu?=
 =?us-ascii?Q?CShb4AKv3jYpm47qt4WPTIhO0GnPpzIszHKvJJTjuY21g+8vLcgBnervSgbd?=
 =?us-ascii?Q?LkPKyc/ZYxurvKIgV6FjeEMuaBD+h8D7lE+nDjankz5x9+Q3SyFuJT4ftPMM?=
 =?us-ascii?Q?qoqLQzmLoA=3D=3D?=
X-Exchange-RoutingPolicyChecked: WaFAUXkZbzjY5DJJAimIJ7seIM3SHep0XD/URJwHrIMyZlm7Q7i+8FuwbNnSlLKeoiFe1Yhch9x3NIjBgElD6pgX9GJuN8TjKz3FabqrFVXaguc6Y51VB+6RuwEsnmIqZsDFD+zKuTUgkQVMdLKImnjB/ytPloxhYJAjnrFCwOLShOXG45tKyGo/IeXGC6kJsJGyw/fC3eYnGaKN6Unm5F9Uw9Hhr9oPCUDoNA7OGDToJ/Ls7LECnzq/6uTGm4L+2PSLmvcuekfAsSEpL5xGu1KVIBPhGUHo5pO+Wh2JX8Gjw2JhT9qGyI38E0hFfCbsVqIjGNmsj6waWkoNb2UhTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2d6f12-d6a3-427c-8f8d-08df17fa05b5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:04:31.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6IGk1js5dI8d83WY/Y9axgeDmBK2KQxKxoOtgGZPJkZXpZ4xoDl+aGO2KLJYezujv+tWnCCNrHoPKe7oJgFGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com

On Fri, Sep 18, 2026 at 10:34:37PM -0700, Borislav Petkov wrote:
> Hi Tony,
> 
> On Thu, Sep 17, 2026 at 04:35:44PM -0700, Luck, Tony wrote:
> > On Wed, Sep 16, 2026 at 09:12:51AM +0000, Wentao Liang wrote:
> > > In i10nm_get_ddr_munits(), get_ddr_munit() returns a PCI device with
> > > its reference count incremented.  If ioremap() fails to map the MMIO
> > > space of the memory controller, the function returns -ENODEV without
> > > putting the reference held by mdev, leaking it.
> > > 
> > > Put the device reference before returning on the ioremap failure path.
> > 
> > Applied. Thanks.
> 
> this one has CC:stable. That means it needs to go to Linus now. If so, it
> needs to be into edac-urgent.

I though urgent was for:
1) Fixing something that broke in the current merge window
2) Fixing something that's really important (security, corruption)

This is just an old issue that's been around for ages.
> 
> Yes? No?

No.

-Tony
