Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5340D583;
	Tue,  9 Jun 2026 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037237; cv=fail; b=B7Xx8Jkwgp8cyw26zEb64X0qOHMDwfCbln3sUf9/pHOj7ZYXgaBXByUNVdzNw+oyx7omvY/oss/qZM60mMNYovPr0CWD8PuCEAMSGtKtWI77RDc7iofsxBaKeYQbE86O10Qk954WuH2LKPv5erX1m/O2R1oZeEqywcn9Ync0i/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037237; c=relaxed/simple;
	bh=OsYVBdg6HN9hzxLl4RnUo5/PtuirVtQfkFhMEQR1wXk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrxPETrNzDIO/+zT6zCjdwHKW8Ofq3//h8KdtP2jtnFsmooNJXWx5y9Hz8O3hw5PDZJ8j+8oAGVOwcYUgi0Y2mHHp+eA549BjVByuxEa2ugcDtwASNYD6k77vS5dA2JKsc8yaZiz8DpFjLPXddiu2UEzsF67M2xAssvA2KGHmik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HB4V0duo; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HB4V0duo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781037236; x=1812573236;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OsYVBdg6HN9hzxLl4RnUo5/PtuirVtQfkFhMEQR1wXk=;
  b=HB4V0duojmhoCfwZo/HWqa627Q7PMczJZYw8b1zp1dYNrHydZxQCl9x0
   3hDb9O6kqi9+NTFQx6ggZjXPoAw5dTt1gXwCKvmd6ai/lVTVzFzUtmsk0
   5XVTyF4Sw839KprdGtLebakc3qp+FBHC6J1Q3nj31WQxBDWpMH5eEWa69
   X7O47ZwDlRbM3tkUZ5lagmgGE2GzzcGOZhMB1ae83FLQAXegQQgxJ/dp3
   hydbsm9b8bQuMiWYN44XS8TIJ4wHlNPJGrpoAjuyLKqJero3f50p0dSj/
   hXEkV2Z5zKxmjr3lIsvHy2x7PEt/41CP5+s2anZg6rxr66Z0ruy79SGFg
   Q==;
X-CSE-ConnectionGUID: 9OqdmDaMQJegbGqTQleWgA==
X-CSE-MsgGUID: O3jwTkWLTQ6AIHo4d/Uejg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81563054"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81563054"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 13:33:52 -0700
X-CSE-ConnectionGUID: JnvEWrflQJGjYqKor7u/DQ==
X-CSE-MsgGUID: +G2b/iI9Q1+39WC7h4lD/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245824732"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 13:33:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 13:33:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 13:33:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 13:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvhkSrzP7/UACLX+N97cyfCGzL3dtXd7jarDMotgFmwSvkfpLhsmkjJw9f24RCx18c6VbEhNp53kLiDH0r8HAI6jlhbVYYTBTMvZFzE9khSYZHPVRL1o4FKLP5c+bhjMtmiAE3zbKK9GwUpQxkKbooXz1LCzzYbcMzaKcAl/qLwnL7I7n03AYR13JN+Kdw/sq0UsVuX8fObsCuwRDDClDjcA5AlivuH5ODslEnpPnqjmmZ8RXN9cYdlnhgmLrO1Z1rjL25Mto1OwP32SeRq2S+uC1MdcoAMnonf/7TDokAyZslFIG9gEQ+DPGx6hT1UI5iwwFusS0nCIl1gEefxecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgzlqn6vfk3PD7OlulsyzF5F8WQ41pcyzfBgJgLg32k=;
 b=zFm9hXqYigVNNAKEQ/Fu1mi8dL2MGougO8nQqbNsglDLeJi4gOLmuLmkoN/ZSS9SiHZrqYyjSnRF22Lf5ja/76ShFEtuiZ+1ZLnhDaIqsYstOjhkkLu8sOyHeHriZp14+QjvXF4nPJlei1xjwT8rJ3xKoXzgPCAXdG1ps4/FmvgWJ6MdRmVjfi4BVCrpmsDUXPsW4QVCOIzCdugjBboAySsuGtjy87oUs54BFjVzcvwKakxTkjMsaobG7YBcXBGW32QkiR0h5TsNvrrvYlR5X2MCXpLG8WgGrLH6qzbhKVmVn9/p1NvBqaIIfyRuz5UVNAEvolXttH6EfbedNOQp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 20:33:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 20:33:44 +0000
Date: Tue, 9 Jun 2026 13:33:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<ming.li@zohomail.com>, <rrichter@amd.com>, <Benjamin.Cheatham@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <stable@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH] cxl/ras: Fix match_memdev_by_parent() pointer type
 mismatch
Message-ID: <aih4pG8wWVEdnXwH@aschofie-mobl2.lan>
References: <20260608224319.587614-1-terry.bowman@amd.com>
 <aihI9XAslh04a2T_@aschofie-mobl2.lan>
 <3cc3f8d9-a6bd-40d0-ad23-2a30112b2507@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cc3f8d9-a6bd-40d0-ad23-2a30112b2507@amd.com>
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CYYPR11MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec1506b-5503-4a0a-e477-08dec666667c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 3nMxG670lR5zl6D2RfMwzQt3jkj4eoEeJ3lefgJhR2OjkNtAJh1DFA0eNjudsWmKfoXp2Gohv3TLQNggSMsrgAtdJoj8lck029uB9xkmgaR5t4+e6T9G0afBSbwFeSdrhLuRGpP/MVjCRUTrzbpVb8Sq/xTczPtnOZOM2GjICcBHG9v/jHBScFUSPqGVRQOBgHUqeOxgYZkzShPpDX1oAMM2m+bB/lbVaGeMA9NQ59sCuiyzTNxucEZTNOoQHAyauiaLx9jcXZLWO0WKbcl3Xqt7CH+QK7qObmm9lFzyPKPFDYbtuHIStMaBo+NO3J6sgQg8psiKheTlyRW/CT1K0h4350sLuPkI4DagpVx/0H5YDJqdH2YtqDkA+MGudRKSH6E+wBdJsvwvfe37Zl6BJAmATP6R65wgEe+2DTgPQix3uVcIsYipSZ/okE/6JGKCcOeAwomOze8zIvCMWmP2okiCyQiLNrtWBYNqe6hb6pM6/BwCb6ABX1r8dYM1j3nmQYoW9azlNgHKGYjiXb4Qt7kFN9wMOCK8Ih37GXoGj58T0QPW3aQRmRlnHGbU8irsrNYqA4oUjLhRpryaLEeRPV7I+RTeB6MnAQxzfNSXztTg9KqH/iF4bXiVZgL6uH9CKP1VC5vzJYugtGm3702veaEuzRMOiI5XPw0sqY/VR9EcVL28b8QfRZZwLC/CPSOS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A+ZXAu66g6PHnSg5kkSQjoQumAzj972h7F+P1B0/KUQC5A9C548t1ld29ZAS?=
 =?us-ascii?Q?evi3tg7/ghUNVlTUop5nXPg2U4rmgwPudziUHcwm1Rn9/RkgDSUQ6OnkaG+Z?=
 =?us-ascii?Q?Zf2oWe6Ck2vAiGVwIK5LqcFdy03OfRzDhUzgVdQlxTZ+xGYP4z557YmcePpm?=
 =?us-ascii?Q?KGWShvQPRLSYyFCzZxmkUuetZIRi1dbV7+FjkGRSGfr8iKix8BHEh2+83V07?=
 =?us-ascii?Q?SlXxasBnIvZAhEZsAiQ9VHVEvHqud3z3VDj7Nhb2JruuifDtsnnNNkeT/x4H?=
 =?us-ascii?Q?03dalPUIjiLwGgaQWZEIkxNfJYCTEP+D7FaSGH3MVv4f1wrz6BGN/Fv0x5Xz?=
 =?us-ascii?Q?aT0CDkfnPOLUHmf4dzv3S4y66keWdu9AsY8j729nfs5pSw6fKtODYfg7EIoS?=
 =?us-ascii?Q?h1oDcS9hBdzb2B53T/9CGKXdCW1r8s9lbNhQAY0COK0X9FgMredjjf9oqrYR?=
 =?us-ascii?Q?b+fmbA0SvDzU6J4cRZPjWSHDOOwy9UDr9vkzDpDVj7KBHwDwC55jRog7SW3R?=
 =?us-ascii?Q?+cCBmWgiM11cI4XmCVOgDKzynRO2VqraEy7O0codARF1xxHpCA6Li4w7PCIR?=
 =?us-ascii?Q?qVk375TdrR4IK/ZIjXa2HeOPoj3nmzl6O3r8PkGvQ6JDhz9T+cjVxreRCr2/?=
 =?us-ascii?Q?vGBxI5DO54lY8POD1im4UD/Whxa/eCqQ1mgU4t/RiQfCEU2r7x+L47dKUuMe?=
 =?us-ascii?Q?otSgfZm/M47eugwQoCHDhXztwmuq46VCOyRI0f8HmF8w/ThHia9ulmr7gG9N?=
 =?us-ascii?Q?daHz/IFWj3Pz900dpKT33ElPjGibMOGjo6yyLCxXkSZObjYsbxqQZO7GZnI5?=
 =?us-ascii?Q?bstrIkgBtqXNlZe2d0B8NAaPlHp/ql84OIQocmesL7H93lXYiZZgDJHaIsiL?=
 =?us-ascii?Q?SJKVSTgGKwaf/j6n/d11RRlVpYyg/beKAuObLiqlg2P6iJGO2i5RxJtsbEIy?=
 =?us-ascii?Q?8pFktg6s26pFmfiySyE6z48PoAu81o1m2ls8QSFmJx8TKx79keJrsM9VnUlW?=
 =?us-ascii?Q?ZYP81dcGmNaEeNoxM45dcKFUgShSM8TeTmZuiQP0bpJBkskAmJBRet+Yn6/V?=
 =?us-ascii?Q?M9ebRw7OWxHJmc/wZmWmXcV7pMCv3Cq3jVNdCrdA6i2McvvAeQw1tZjPGap+?=
 =?us-ascii?Q?7Xr+j6QHZkuagjOqPLfWPDQU9z6mxqE7ef736/HTWleslnCM1JtbY7t1NlNH?=
 =?us-ascii?Q?aA7iaNQm0OVmcAEDP5qlFfhAppim/Fi85ls4Qp2SRvjVHJ6JIO6K6KBPIstO?=
 =?us-ascii?Q?UJrcRr3Rs0StdqOjnBvmEdIbj4Q63VrVi5szucvGbJLZGOC+1gE3MyME4RO+?=
 =?us-ascii?Q?XtN3LzFDGpXcOWBPlSD29z+k0gY94oBEqo5y+1Oyp9vqb6+TDLhhntl+i2A6?=
 =?us-ascii?Q?yQGM+g57Vhk653BkVEi41mdVMclvwJjIC+dEkP5KLxbr75Qs2SzKggh5ODNI?=
 =?us-ascii?Q?bb3W9dVJqvpzfHI7Y23mqZQBXhAsx7X8TrFZKpX/GflqS3wAQjnfuNDdtg7f?=
 =?us-ascii?Q?IBJU7JWjxmtlGnd3WAsGz+ZWSnOYAG6vU0kiBAq8TqQISvCTbD8Nc7/38qqx?=
 =?us-ascii?Q?oHptiEtH6zjUtloVbvo1u/B/jx4VR4DOPhi4530kusomePO5TaLyf1p01N/M?=
 =?us-ascii?Q?rjw6CvnGtFrqjwoAvhOV8KWwkz8AFPS7/PBkIDuGC9NWxfxFzPKJv8wQ+Z+S?=
 =?us-ascii?Q?3T3UHXrWPCgol6R/RyKCFESwHqeSyOAX+eo3tkNQQ6zbCKi1ovaHDWkjPHpv?=
 =?us-ascii?Q?l8BQ/6KFSW+nWd/KP3tokZaMtBN6Iuc=3D?=
X-Exchange-RoutingPolicyChecked: kidUSe7EoHNZM0yy6nKCdltgWPf28o3Nj9AT/qmkGyLvBSPoe/U8y3ddNDJL7hA0Em2yu8Ja8Co5a0OrmT2xe2PUiobM6AU8w8ExbyxT6wpcw97WVBdY67co1qiGJDOVrtoTigj9AsAEw+vjHSLf/pMREi1zWsW1cAwU+ROXqmUNkVcWVeFGcsbrr4XdCJonbGCELYgTwbUYUMQQ1ySR1qqSOEvRmOk+rpuLLZt9LFlMIbG9F01DMqSQcsWHVCblShRx6Ii8JXr56QTKjJ9l9bC3SoZ1l0BS9maykwgQXF98oQHJrMivCjJJqwTPwzXP6ab8vimyf2IVXeb0hYL2aA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec1506b-5503-4a0a-e477-08dec666667c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 20:33:44.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOf30G+9kS9MtmA1UztE7t/X7LMd7ykFIgF10BsHI80oeGAXfVYoDunWXbe2yPtP55e291Fn1s5GZcWiffgDO1JWk/eUyrwm/ewt00zQT9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
X-OriginatorOrg: intel.com

On Tue, Jun 09, 2026 at 01:17:32PM -0500, Bowman, Terry wrote:
> On 6/9/2026 12:10 PM, Alison Schofield wrote:
> > On Mon, Jun 08, 2026 at 05:43:19PM -0500, Terry Bowman wrote:
> >> bus_find_device() passes its data argument directly to the match
> >> function as a const void *. match_memdev_by_parent() compares
> >> dev->parent against this pointer:
> >>
> >>     dev->parent == uport
> >>
> >> cxlmd->dev.parent is set in cxl_memdev_alloc() as:
> >>
> >>     dev->parent = cxlds->dev;  /* cxlds->dev == &pdev->dev */
> >>
> >> So cxlmd->dev.parent holds a struct device * pointing to &pdev->dev.
> >> However, bus_find_device() is called with pdev (struct pci_dev *)
> >> rather than &pdev->dev (struct device *). Since struct pci_dev does
> >> not begin with struct device, the two pointer values differ, causing
> >> the comparison to always evaluate false.
> >>
> >> As a result, cxl_cper_handle_prot_err() silently drops every CPER
> >> error report for CXL endpoint devices -- bus_find_device() always
> >> returns NULL and the function returns early without emitting any
> >> kernel trace event.
> >>
> >> Fix by passing &pdev->dev instead of pdev.
> >>
> >> Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
> >> Reported-by: Sashiko <sashiko@linuxfoundation.org>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > 
> > Hi Terry,
> > 
> > The commit log is burying the lead- no endpoint errors reported.
> > 
> > There is no need for the full struct layout analysis in the
> > changelog. The important part in the functional regression
> > and the pointer mismatch as root cause.
> > 
> > Please reframe the commit message along the lines of background,
> > problem, cause, fix, and validation. Something like-
> > 
> >     CXL endpoint CPER protocol errors are processed by ...
> > 
> >     Following commit 3c70ec71abda, endpoint CPER protocol errors are
> >     silently dropped and no trace events are emitted. This happens
> >     because bus_find_device() is called with the wrong pointer type,
> >     so the memdev parent match never succeeds.
> > 
> >     Fix it by ...
> > 
> 
> Ok.
> 
> > 
> > How do we know it works now?
> > 
> > -- Alison
> > 
> > 
> 
> I have not tested this patch yet.

I am intentionally being a pest on the commit message, however I am 
not intentionally being a pest on the testing of this patch, because
it is obviously wrong code and obvious that the errors cannot be
reported unless this is fixed.

I was just after confirmation that we now see the errors once again,
and it's not something else that is broken. 

--Alison

> 
> - Terry
> 
> > 
> > 
> >> ---
> >>  drivers/cxl/core/ras.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> >> index 006c6ffc2f56..7ec2dab152a7 100644
> >> --- a/drivers/cxl/core/ras.c
> >> +++ b/drivers/cxl/core/ras.c
> >> @@ -94,8 +94,7 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> >>  	if (!pdev->dev.driver)
> >>  		return;
> >>  
> >> -	struct device *mem_dev __free(put_device) = bus_find_device(
> >> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> >> +	struct device *mem_dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
> >>  	if (!mem_dev)
> >>  		return;
> >>  
> >> -- 
> >> 2.34.1
> >>
> 
