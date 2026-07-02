Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B8317173;
	Thu,  2 Jul 2026 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030920; cv=fail; b=cYcgN6lqYfwtP4vTZ5mYTW4f5+K0TEYlYdDq4BtSYTcoii8DJ83RHWsd/c161AZ6mgM09CcA08f4dKhIET33emZX81tOejqKxLbo3W25FxevlG7xuo67hX6JwkR7xtttORO8Rl1qI5TAOW8wWbEAd1GOFl4S08T1NwMV621bO/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030920; c=relaxed/simple;
	bh=qakWhJh0yITDW0PU3tZdddOeAmOY1eKvH/8O1EI+2Qg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gxy4+HVppVfTFR0WBPdeGlzGClaCFSn7LIAr6pivWkw+is9B9n88VbBGKSllLqJ2FnzHQoP0GO3kCRe32pawgmwHe1kX1v8xzDEOo0c+Dx6XDktQJRG82cy16cR58ToI2iZagivQae+7BNJNJkMfNJaxZZJFKoWNX/0rpxGQN2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kicC8qly; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kicC8qly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783030918; x=1814566918;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qakWhJh0yITDW0PU3tZdddOeAmOY1eKvH/8O1EI+2Qg=;
  b=kicC8qly6+Il4BTmOSD8qgonPPj3BHF/05NUC5El2eUY5AEQtKn50yJZ
   j5BG2BjqbQ3KhJQs1e4e9Q9uW9yJcYaoz/v0PuODX7er4rIDBR4D89bzc
   AxKV9IYVT236vQMH+VSU16keZ87iDj2HvHK0lQsuoGfd7Aa3oFMtNiivo
   Qj+RSZEPbn64I8mPjiMTdyt/vgTMxmvqiVq1SGvE6skHWOER+YC5K5w52
   4K4E1/aEhyOPDEiHcjaBzopJ/kChwVFizKfGeIl6SKSiJi94cvXcZ18pT
   T3HLt7h1WaCO0FWONKHbCSNi889AdI7PqDUQTW5A3UmE1o18jGnE4Yxpv
   A==;
X-CSE-ConnectionGUID: aDPzTnlQRKuB2/h3tnHHGw==
X-CSE-MsgGUID: lnbMnt1cRQGPrOpel1hoxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95292876"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="95292876"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 15:21:57 -0700
X-CSE-ConnectionGUID: mVtya0qtTfyJhTcf55gvEA==
X-CSE-MsgGUID: u6uoPWa9TeqQsIo7XjVc+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="277287028"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 15:21:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 15:21:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 15:21:57 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 15:21:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsogkA+fkPOEkRaWFly9ouOkvdgfu8lDU/apZawf0pwhG8iUDEUtTMRUAwNlHbo90H4zucBfHZVCfgFC7N4c+ANdMNRthm94YVreBJPxBNW1ZnKuXjOzkxA0SOCTLFeQ2+soau1d03O8ZkICZNE3ayUBnrl7ODeGVG0ohYIYpjtnYtG7pFCeZix1UmfsjtJ1G3gSOmYtToO7B5AQiZcqtjzjJQ2POdlOvu50SuRfxARW2UUL5GdkmT5/GQ88vM0adO14xT3xZjTHm+uuUVzM30fIVQYbFmYUomr9t8EJBJNOhs9AOz/3WJiMirLPvJ+YfJQ8mMTCYKoD2JGHyZ2E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wovZ0mZuR/97jAFpqad52QzFJq9SFyl18+zeFJ+8G5s=;
 b=FGszewrdHApYqetV13q66JVzg8UjgPRR3772Q3xSzQcV+35lu3cjcBkSy4wcXDGZwJCTgk/L48jmfdyWe6ePK7YHcAUG3iQEwvMnDwPFpdqkN9pZGE7X/DbCuUacyT8CYkhMcs0OXI6t3oLFfA6G+5n1vfTXSZG+kL4Rqofe9qu1uAZl485SP81mmjChBjqwbANO2bnKGnaZjRoJoHEXfkzrYHlFQBGtxd7Gk3d5rAWztIks+QSDWY8j8DR9APi0sqNLAijn/HhVcwFw7KPFYuJgUBezCg4Tv9CfmAwISX61OnagngqwEqHj6Cvz/llAJ+4PfYpixiZiWMEhtTckaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 22:21:47 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 22:21:47 +0000
Date: Thu, 2 Jul 2026 15:21:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm: Account for NULL pages in ttm_pool_backup
Message-ID: <akbkdxHY19rP8A1B@gsse-cloud1.jf.intel.com>
References: <20260626074653.1326683-1-matthew.brost@intel.com>
 <d2558fc5240d47d08d6b7d35fdeeb50f9b78a292.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2558fc5240d47d08d6b7d35fdeeb50f9b78a292.camel@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 288c02f8-ef18-4472-926a-08ded8884dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|20046099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qk443UY+9VW5/IKoIidtwTZGC4J47Gq5wEXPQh1y2cFKT1m0ol879x30gHcLkTSo4hJhzwb7f9GtIGupjbHBapUuTTm11Xlyb1dkmWGW3J7WD+Glh14FGVDQIyIGNrTURrxWe16AIJUe9b3qtiiGf7wk5S42DCFGbdLJOnvVcCrRoYvr/HkCQh8Z7VU/6XUV+dEmMX2Kvrp/emFHOWxZkZWuRn51GuDXyWBFdFKK5HuC76Y1N8noEVklNb7OW/uyIKCe2F2xHGbu/UCZ3D3VsJhmcvep310vAs+Nk1+1xuYp2dkHN3TO6PU2U+gn4/5akgm1KTD/2UPn2U6b18xc4fPzwe0RIeW41TGH7u2uv/fFjjwt/g/q1/i7jg3NdmWdKeGKvZ7d8cNpH56koIZOtfDEWKjn+r4exqb7GKye2Pk6ecpSFo18domlmfuZvG0UMAfAfL89+dQ0+NL+5bHJ+/kGwC3+trZvAnYD0bi/I6FekIwBWSYE49k6xivqGXRV0b2vn+RhgpyHUu9fH9uLnhHA4PLWVmNeoqqzWV1xz51v4SWaBNuYiRQPX+KRs2I5395bGWAsjLgEp3BcA9V3yML+1xwVl40CCqvngbql+moS9Ly/o92Ed3VAylCdhz6Dky9NtVjopAC6dr/xcXoR85HnBI1J/7FGyDM2U/2BszE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(20046099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vo8f2i5a0XNIhPxiNb6lvBJiXJPf6zFVs8CYA+WVXmtuLoeBdo9pSGu0lt?=
 =?iso-8859-1?Q?/33wrhDXy0ECGntXavwtzw64lIa4z8PpXov3kepHFFe3GWURVu/wvQyhvA?=
 =?iso-8859-1?Q?ELLKVDjg/nzbmBuS/jJNT8Bnl6iXTu0XlKy0uZ4f4zZwAB1j22J3n9s3n5?=
 =?iso-8859-1?Q?M6Ac2NbX7hdKqjGcDc+i07ClRpY/eEA7mdP6KU9YAmBrVn0kG1wcamPuvt?=
 =?iso-8859-1?Q?WiykCTCqct/lGjcW54dsw0vLRRlBZfQGWBT14chkM2P+meEoIBKMcfooQL?=
 =?iso-8859-1?Q?YCEecCjeZdgSrKbqYmU4ULcG2wcB9vt47ypfSCOXdR/JKge5iBZRi/TcVU?=
 =?iso-8859-1?Q?Sqx+qVqDOnk3aTXaXZbbS23ETXYIRvemBWMuJXKwu5OMlVCP9Fa9RsiZVB?=
 =?iso-8859-1?Q?3ldB1hJy3DWRo1YKRoycGCnrgYb4w3u1qonWn3mLaEJJn2UFAY5anlTlEQ?=
 =?iso-8859-1?Q?valFOAOGW9gy2aoZZeQuZ2/hlcpi2mvMQ9nZFeZ2yiftU2Lw9ywURmpxov?=
 =?iso-8859-1?Q?RQrPKcHd3R487sUOJUV5JLz+PuLWb9Oh3e1FIfCINZAf9xu9XM3WXK8vrF?=
 =?iso-8859-1?Q?9dFULNFnP2KNW7VDPwEgDuKk6EKpurdATyM7wfWg/FucGp/yPbQR47XNDL?=
 =?iso-8859-1?Q?ZCgjxs6p/6E8qKyAKhMZJijt+ms4zpEHhi0g8FHpbpGXOSUS0cp71Fz3lv?=
 =?iso-8859-1?Q?m4Xi6w3KKxLUbpi67dxbngvlPm6uySyD5JADHQfR5dbDj6ymSw9AJAqPQX?=
 =?iso-8859-1?Q?djrW7Lkk+v2jGwv9LvT8zpXKcPmFVxHHaUa27/3RAwO2zmsCD4xLUsbQkp?=
 =?iso-8859-1?Q?L0Ssu51MerL2RmNaYzhoeCtDM+AvBeR132VL8iON4FyXLMYJQxBIgmUqRW?=
 =?iso-8859-1?Q?+1OZzwVx2rTN+yehH0Z7+KAprFiBQUgl3/7qyGl85fO+bFqTIbYaLfvYMZ?=
 =?iso-8859-1?Q?QOxbeDXgZnPh8l6WCtYGYlpte7a6rzaRLtV+JsPdh18E6lU8n97zeJ/gpY?=
 =?iso-8859-1?Q?VKMgNdnoP5j6cNrc83xoAvgHUhu+RrbdVkSKfc+mcy55mCrszUCCRbXxSg?=
 =?iso-8859-1?Q?A5nQEZy59l25QZZ/HTWdY7+/vPawhWtH/v6vPDxCpM7NDbqI2ABh51KNcX?=
 =?iso-8859-1?Q?QwRw01yVYNyD30CQACW7ixe3XMFkNdzHI9h7PYr9eKpanUdDPY1WcaGeNn?=
 =?iso-8859-1?Q?YuaaQNidciw2YVZAH+0/uTVpyBXzgeYQCU5rYGHTrt1WpaMVZGFfIIMAnA?=
 =?iso-8859-1?Q?EDWO8EYmwSMMHUE79q1yoyq8ZQqCwHi6Kkm3qMmjPiREy9JgO4PkaetnHj?=
 =?iso-8859-1?Q?f6jKbirC+qxuR9WmWjpXrZYMLr9Dk5Q/Xj4VNvLr1T6R1OuEPX98KX7vNe?=
 =?iso-8859-1?Q?Wtbo2UXAsA1Gf1DyHY/Gq5aETHsO+hJDyqSxe87ty7+BRmIUm4dHMT5nww?=
 =?iso-8859-1?Q?Jlcx7IdDfdHINSdM6HRCTDpLrlGbpslblprjAwkKjpTJKXXkRhnbDaRLHi?=
 =?iso-8859-1?Q?DAeRNlniknDXsCcy+GdYWDf920N5fzHAhga4XEwXynIZNlnHwAavhLTZxm?=
 =?iso-8859-1?Q?IyRdgZf4ZNZIRHQf8g7wlOzLi0eW0bUf3iQ9AgCtgndzSuTV/NyrjdStBA?=
 =?iso-8859-1?Q?hkhXOcrXXISud5KhQNDDUjnXRbnOpEwnSFb73a/erI4qwymcXGsNbJmcid?=
 =?iso-8859-1?Q?llkKihNxZUa9h/N97e++24HQprSPCbdhvgUFabjIUtEWS60h37LRNHqmG1?=
 =?iso-8859-1?Q?P6einHG1cDH+gbPyfwwr3HcV0CthxcwkCbPJ0/qHiyccRTHThUifNUendj?=
 =?iso-8859-1?Q?1D+8IsKoIQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: H4CD2KTXAowMB/HQJoe+kFT+g77U2wbyNEtGDzYNZ7f+AOPMOQROoyfoFnkPJWJwZ8C/dUiOXhdTy8vw/usdqecAA8UUUDv3oLea2cuEqZI7qho4dXSv9Zu351bo+LOn5My61w5ewsKdrczRLJ2nriNdFMMLPDpPqnPoPQV1B+E7FUg3XDZqVZtF9qd5DTjRnUBdVSltwePdlTf9RBmodcSExbyywsHcNvhFxXZWiTxhBCxf0QNfIxUd4kaqlFCQKpbuOu5Ug8dDedT8Qf9VaKosBOt1OuHzoS+JCO0Mszy1NhoppXXiG8kJPc6gwpoqKf94XhOUpmPH0zLX83XyDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 288c02f8-ef18-4472-926a-08ded8884dd7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 22:21:47.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frvoj6Nb9XTxFiRlRpeP3E9HBKBpwXOBi3LnCIcL/MxBweOOzVJ0p2MNDYM9myNZJ+DCa01pidmksvswj3xgSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 01:57:28PM +0200, Thomas Hellström wrote:
> Hi, Matt
> 
> On Fri, 2026-06-26 at 00:46 -0700, Matthew Brost wrote:
> > Pages in ttm_pool_backup can be NULL, and set_pages_array_wb() cannot
> > handle NULL entries. Switch to set_pages_wb() after checking for NULL
> > pages.
> > 
> > Fixes the following oops:
> > 
> > Oops: general protection fault, kernel NULL pointer dereference 0x0:
> > 0000 [#1] SMP NOPTI
> > RIP: 0010:__cpa_process_fault+0xf8/0x770
> > RSP: 0018:ffffc90000a87718 EFLAGS: 00010287
> > RAX: 0000000000000000 RBX: ffffc90000a87868 RCX: 0000000000000000
> > RDX: 0000000000001000 RSI: 0005088000000000 RDI: ffffffff827c5f34
> > RBP: 0005088000000000 R08: ffffc90000a877cb R09: ffffc90000a877d0
> > R10: 0000000000000000 R11: 000000000000001b R12: 000ffffffffff000
> > R13: ffffc90000a87868 R14: ffffc90000a87868 R15: ffff88815b882ae0
> > FS:  0000000000000000(0000) GS:ffff8884ec840000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f930b844000 CR3: 000000000262e003 CR4: 0000000008f70ef0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  __change_page_attr_set_clr+0x989/0xe90
> >  ? __purge_vmap_area_lazy+0x6c/0x3a0
> >  ? _vm_unmap_aliases+0x250/0x2a0
> >  set_pages_array_wb+0x7f/0x120
> >  ttm_pool_backup+0x4c9/0x5b0 [ttm]
> >  ? dma_resv_wait_timeout+0x3b/0xf0
> >  ttm_tt_backup+0x32/0x60 [ttm]
> >  ttm_bo_shrink+0x66/0x110 [ttm]
> >  xe_bo_shrink_purge+0x12b/0x1b0 [xe]
> >  xe_bo_shrink+0xbb/0x270 [xe]
> >  __xe_shrinker_walk+0xf7/0x160 [xe]
> >  xe_shrinker_walk+0x9d/0xc0 [xe]
> >  xe_shrinker_scan+0x11f/0x210 [xe]
> >  do_shrink_slab+0x13b/0x270
> >  shrink_slab+0xf1/0x400
> >  shrink_node+0x352/0x8a0
> >  balance_pgdat+0x32c/0x700
> >  kswapd+0x205/0x2f0
> >  ? __pfx_autoremove_wake_function+0x10/0x10
> >  ? __pfx_kswapd+0x10/0x10
> >  kthread+0xd1/0x110
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork+0x1b1/0x200
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > 
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> > shrink pages")
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 49 +++++++++++++++++---------------
> > --
> >  1 file changed, 24 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 682ae4f40424..ea14447411a6 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -1064,34 +1064,33 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  	    ttm_pool_uses_dma_alloc(pool) ||
> > ttm_tt_is_backed_up(tt))
> >  		return -EBUSY;
> >  
> > -#ifdef CONFIG_X86
> > -	/* Anything returned to the system needs to be cached. */
> > -	if (tt->caching != ttm_cached)
> > -		set_pages_array_wb(tt->pages, tt->num_pages);
> > -#endif
> > +	for (i = 0; i < tt->num_pages; i += num_pages) {
> > +		unsigned int order;
> >  
> > -	if (tt->dma_address || flags->purge) {
> > -		for (i = 0; i < tt->num_pages; i += num_pages) {
> > -			unsigned int order;
> > +		page = tt->pages[i];
> > +		if (unlikely(!page)) {
> > +			num_pages = 1;
> > +			continue;
> > +		}
> >  
> > -			page = tt->pages[i];
> > -			if (unlikely(!page)) {
> > -				num_pages = 1;
> > -				continue;
> > -			}
> > +		order = ttm_pool_page_order(pool, page);
> > +		num_pages = 1UL << order;
> >  
> > -			order = ttm_pool_page_order(pool, page);
> > -			num_pages = 1UL << order;
> > -			if (tt->dma_address)
> > -				ttm_pool_unmap(pool, tt-
> > >dma_address[i],
> > -					       num_pages);
> > -			if (flags->purge) {
> > -				shrunken += num_pages;
> > -				page->private = 0;
> > -				__free_pages_gpu_account(page,
> > order, false);
> > -				memset(tt->pages + i, 0,
> > -				       num_pages * sizeof(*tt-
> > >pages));
> > -			}
> > +#ifdef CONFIG_X86
> > +		/* Anything returned to the system needs to be
> > cached. */
> > +		if (tt->caching != ttm_cached)
> > +			set_pages_wb(page, 1 << order);
> > +#endif
> 
> As discussed otherwise, this causes one IPI per page when TLB flushing,
> whereas set_pages_array_wb() causes one per array. IPIs are quite
> costly, and
> set_pages_array_wb() has been tailor-made to only issue one per array,
> so we would want to call it on subarrays in case there are NULL
> pointers and always call it in case there are no NULL pointers.
> 

Thanks, fixing this another rev. Also is possible for a page to be a
backup ptr, so folding that fix as well into the following revs.

Matt

> /Thomas
> 
> 
> > +
> > +		if (tt->dma_address)
> > +			ttm_pool_unmap(pool, tt->dma_address[i],
> > +				       num_pages);
> > +		if (flags->purge) {
> > +			shrunken += num_pages;
> > +			page->private = 0;
> > +			__free_pages_gpu_account(page, order,
> > false);
> > +			memset(tt->pages + i, 0,
> > +			       num_pages * sizeof(*tt->pages));
> >  		}
> >  	}
> >  
