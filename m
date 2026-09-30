Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C647F2CE;
	Wed, 30 Sep 2026 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809023; cv=fail; b=ZFsgmhZWSC6GLStG/1plis0s7qv+4WSZA1epxdmkq5dZKiyqMcypcjvOsleUkuE3JyXI3XxomR+Cbq5xsZlEN0VC6QZCwxaA7VN82bCwZuQBokcsLPIewczsvWW1YUPR3/aGHz3hHL/JJ2C9Ckq3fHh/erMn2bUFrt1zGfuc++M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809023; c=relaxed/simple;
	bh=TchL4T6bq5nZq2XTkyB9lqJkfk71YFF8fCkrWpfHReg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CJUbRk1PEJURhplHnKmL+xRTb7ONiYcesYT+Ey5bwVwtckzuGHCe1UT0h8OqegIr0oxdxtG4tQZHteKrFpW7dvJg+urv7ksO+jzB6ZwOxJYDHK6aIImown9i718n7nRJbhwzYiL6brQF2Qngiklu3Ae6GrV2bvgu3hkZNZ9MXqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsip/q7j; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsip/q7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809019; x=1822345019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TchL4T6bq5nZq2XTkyB9lqJkfk71YFF8fCkrWpfHReg=;
  b=lsip/q7jaTjK0ut9GkYaQX70AdXRjNre6+j5QPTRMKHOUZPUD5PnzIoP
   HA4qvcZqLz2PHsPkVB4tpKCtJVrcGBRC66oeDQR0NxtT0rDfJkyU8ps8h
   1l4McyVs3Uy1/z3bDvkvO2Xjz/CUCjFda7NLbodGslxjRMX0iKLqQgA+F
   n7TDS2ELGu+CRt+8Tq150q0DPkv5dIJhCggejStJySWvNhiTkmubSxz5d
   sZGO/5lnvTbCKhOyKX4p4qtot9it9xSfBgAiegz4mrc9X/6YJ8MfT6mU+
   aSE8eiOuCYbnIqkHyXfuSbvIEHuTbLuRr6qCJ9hlPMe61xGx3K1XUwZzy
   g==;
X-CSE-ConnectionGUID: kkCLkH/GSTyTMbpwQAKYqA==
X-CSE-MsgGUID: vXZzCbsmQm6ekCUoUiSVbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="117086700"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="117086700"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:56:56 -0700
X-CSE-ConnectionGUID: m+LwT1yXQO+N3k+Ziezocg==
X-CSE-MsgGUID: dQomvRG9QPq10d/CEYTwgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275354646"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:56:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 15:56:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 15:56:55 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 15:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/OEj2Z5OSFPfGyqyuqN3/D51K/cEldUFrbWFMi4TJMkU8HIUH53wL19p3NZP7rgAu40+0Tk0y5pmFJCHc4whWD80gfDg68YMFpRj2Lf36WTYTeJ39D33tMZqE3OMVFvm0MR74GQCkD8jTNp1mrp0joDGj6oueqRdfelLa99s4PXO3lO8aB/hw9IODBMYXyRenD5oN2yQ3CW6UPe2CI5PfdwImLNiq4Y8UhGD9HixoWG8ukyHMrQoABOPXC4+bQThGTOEkO3Tvf2qjhfOVyUbhDhYfrZ5gBSGhJKX2wZ8t5OJts1uceWdSR7Zj2CDEpwV3FeryAk2hlndnZSoqBxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cOXFyh8o7VgEyulpkYXqNcbc0Od/8xTKhbUCkYGX+Y=;
 b=FFEuQAoWdyJOdyIxri6loGwNiRJf20YUkDCkAzKtNpYLxkIBPxsyTeS39te2WVf8KTJrZ2k8P7Dm9HKjxP/rehx+EUxZCiun4CS70JuElChAIs7Yuua5SbHE7YfoqZLFNU1lG/2lxs/61fgwp1lI6ixRovtpKgrVx2xIPl1BhqQyEBp0OGTd2/c1biMYORX9N5RCHOEp1aSllmDk3YkLtLAohNocRBS0ZKIEW/mOYu0ba4Es8RJU3YW68dzsExLLpDQPsOBfIpde9tFcLm9mmdluNxP46IFCTL7swvyXkDiYQTTqoSwJWCqJ84feqGI5j514eQJUhIA01wGDFuu72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 22:56:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 22:56:44 +0000
Date: Wed, 30 Sep 2026 15:56:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<ming.li@zohomail.com>, <icheng@nvidia.com>, <stable@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, "Gregory Price (Meta)"
	<gourry@gourry.net>
Subject: Re: [PATCH v3 1/3] cxl/port: Clear cached dport pointers when a
 dport is removed
Message-ID: <ar2TqGKJUZaIfICe@aschofie-mobl2.lan>
References: <20260930152311.4164036-1-dave.jiang@intel.com>
 <20260930152311.4164036-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930152311.4164036-2-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV8PR11MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f97bb0-4525-4a04-2e30-08df1f461947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|5023799004|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: TsAigpbf9e8RwA3CbIsJiIXfWZZ/VB9oo9lb5hp8ClkurT7D4qmycgk3UufftKAB7DTgKqX+gvJ2HpOksVvn6yqG6H9RuS1bPo+bUmArzQ9odZ3Hto7YFi8NiIYZHvaRyktHN40RNmVi+VBv5deZDot5HRRSb+UaMPIZ4OZX8JtAjis4EfnUCAYPgjgDh0/SWTUm4qlp0S6R+kWjXcPvtQK1u9zOcPx1vcqsK/uJ7JHSlpjpn63Hc54E2DEUPmR7UR1K0ez+cik2CcN0VPXssNPbOmdrDHH/q7aEVoUQPUIaFZ/Tvazeauw+QFEKMsKqns61BoCrUgWOhysxgj42A0w9T7lBLuoFy6Q3f5hb//vt1Y5kLQKWF/ZOGDNj9d7bcgcrq3jxgFBWgaMhP50AnO+BVueAmSPaiwbYo0ZwFNW3i23n9GoeAjMogbSx7J+ocfMQTU9iGvFw1oD10JBXQg29Rd6tSibfvOsiYy4YKP0lfqY9c0oskxMxiy6mOqYFhEo+fS0A/MGyvt7qyIlaOKmpeFOgwEXZT/2d4o4RXDAXZmU7E7KZunJCtG7JeOuo/at9wjgx5P7A1T3dgfpj8SgErQ1B11Zf2UXISoKpBDAZhYLUI8e/1UnEXoOeGp5l9XNYMtoBMpXeIB3M65Da7fm1WgYm8htvcSw1PoG8gB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(5023799004)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R07+VO7WSSoq9cVk8E28T7bXsXy9fAof/3tW0iKeoMzRwi8m+bwaMglAhP+9?=
 =?us-ascii?Q?M2b2HfusLEZSmU2a6h0GAB19Z020idzF1z9I+ZYFtdqT+5XirUqFe72Owj8+?=
 =?us-ascii?Q?C+Ix8T+77sNr80uKEw2rbv012I/aNNJeJPCqk6hfVubKGmJK+RPnrU1jAdP8?=
 =?us-ascii?Q?PV5Kcd2VFbg3/7UtcUWreDHWLQ/ccbReW3Brl7YrxlRGWNH6psIddckCEiy9?=
 =?us-ascii?Q?4pf1i2QD/2n4Glw5jP+tSYcDl0bjQoBaPaOy3gDM3bS1rEy45cxsrDhkRwT7?=
 =?us-ascii?Q?FjVRa4AVJ0zJyVTVNa1UQituLZq22Cz8uQD3cuOc/bdaRRhrPy9tLlOG7eXy?=
 =?us-ascii?Q?pGtNNcH3eJ5GujEt6OlxQp8bnVdoaxcE6MDcgdWewTJShpwDB3p+iSHsXPVW?=
 =?us-ascii?Q?x5Yo1ZV22CeKn0VR1RMF29SKtmpET5tw98xPA60waTz4BeEaJ0GXKYVFJxhc?=
 =?us-ascii?Q?kV+jqxnHwDea8hJTinsG7RnAROXi1M5DpWT8As39JG7hBDQ9ZRcvWafCRDdE?=
 =?us-ascii?Q?3la7/lpvveG4lUVfDqcKtOuyafymIf34uBsk93jTJsjkTiYGQKO5lLNVuc2l?=
 =?us-ascii?Q?EZsHErQ7jjum/nE/ZpwvYko4HlPsx1Rc3WA/b2MJhG65Q4At5zLxwGVtCGcJ?=
 =?us-ascii?Q?iBgsHqk/VctIQ32YYGKxlNQOKw0cZ6gw9j0oACg/7B98tm5izruc62mCpSRc?=
 =?us-ascii?Q?dlBxARR2U/b1q3zhPDkC0JFRRKdHQjDFuXjyoApsMMZj/uK2B/mzDPpr1xvK?=
 =?us-ascii?Q?C80cG0tM276bKFed6UEPJA1+xLBXIeaS6UCEOH7zAsqi9kTuw7zNJGPgqxfs?=
 =?us-ascii?Q?lfwAb9aBJ++oznYXvFTn65k3S8Ya+sOZybZ4hZzpozXe6Yf+wLg73H+6uFOs?=
 =?us-ascii?Q?uPfTuEIFlHTNuNF/Mb3+E2+JNp0VFiA6aPsNNQlDWtJ8Gw6H3+CgDtAnDIhT?=
 =?us-ascii?Q?yqyM5kTzbNJG3Mkp3Vle8d8R2hLr3XelFrURRUM5obKnixcH+jEy/G0ESDfi?=
 =?us-ascii?Q?mMHRvGlaN3u6S56fdGPocBT0+RvEUrsMqceO1Nnsn1vH7H5Two2S/quF1c1x?=
 =?us-ascii?Q?BiNTaLEMZgnie/Axqc/i/cARSUBM6zAcyySgRvfHKj+aodakzw8X5L95g2JH?=
 =?us-ascii?Q?yWRZhEjrKs9ACi6Eh0/5yP5P3g7xfVU7bs3XTKdGu+GXPhHTKLjnEeyhDj6W?=
 =?us-ascii?Q?b4+eZ2//j3RpaPR10NlYvCJR9GjWJTK02dEREKgzky6MzvmaS+TOsKi9FuQ/?=
 =?us-ascii?Q?WPTvY+hxaxZMWRipsQ1/iNkvfaD3gVSeWYCOnxcZcxQ1psvmzx8e13x+18vq?=
 =?us-ascii?Q?xAT6Of97Lc22TljKlPG2M7hcX1qP1fr0iwcOzrR9sUv3CxW4l7S/ZGUdfhgH?=
 =?us-ascii?Q?oA9DIpDjOgAuw7eMmWy49G2OlyQ3LPtFp9+TZVh5p6kzJTlhsnJU1AS+TQ2n?=
 =?us-ascii?Q?MGI4WQij30pr3XOeuH6XOmQ+HP9eIYvMsigd5WbVWRx92n2zVzuiwHJsx53M?=
 =?us-ascii?Q?Ls652FDDyUIaD8xKrf1bKWpR0yqbWWaFlxtfx1Y6scGuWsB0oNaQ4Myky9tz?=
 =?us-ascii?Q?w8oqkF1jXKbmnxBtf3R30CtxBwHFxv3bxUhbvyLMq/vJ9yZ52AYxPgWpD9I0?=
 =?us-ascii?Q?6Vt7vdZ2wrdKQttQoVaO01lhephOQTY+sXKGY/uI0zqEeaxjsX3RwUUInAmb?=
 =?us-ascii?Q?VNkdSK2JilFHPAnwmr6AobZMa7k6IPb1ndTgPz5Ht5ZhID9knroP0klAu6hZ?=
 =?us-ascii?Q?hSsI4gtlkB+Rt+MhZbb/c2avaTpRIr0=3D?=
X-Exchange-RoutingPolicyChecked: A3+KYe/I2jdTmuqsdKol+pn9YHFqFcS1yQF8wWJHc1Nm/GQwsSDC/8r3ejSq/W9Yj3cKYzfF6GODJS1VqQl523TgdilxNK7wY9wPpYx3qes+2TafdkfYYv/YuWyq8pIPe+Fni/JPz3lAD5G46danRNtUx0nJYFMdxTGLjXEfNlaS765cYHR9PEApWYmxbstvOckgwV3fS4kYJZ2kUXWsU/dZN0rfVn9vJV1wJkIiObdUOs0HSOgl2etbqBJJAR14jmKBe8OnQKaOtQ7tx/VgJNO8mU38Xpfxxwzq3xV2SuPYpIz5ohbIiKl5u1886QQtaEKZ/Cfh2hONH5QES2vqrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f97bb0-4525-4a04-2e30-08df1f461947
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:56:44.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ7pgkyrNkHf8MTRpFB/j7D4Uk9iu03CKkMheqof+EIeQzLJdlMC03h9C/KYyfZi65iZDEF9siGp2aG0cHdqMAdF6YUEXmQcixkPozBFxqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 08:23:09AM -0700, Dave Jiang wrote:
> Switch decoders cache dport pointers in cxlsd->target[], and nothing
> clears them when a dport is freed. Readers then dereference freed memory.
> 
> KASAN caught it under a cxl_test load/unload loop with concurrent sysfs
> reads (abbreviated).
> 
> Clear the matching slots from cxl_dport_remove(), walking the port's
> decoders the way cxl_port_update_decoder_targets() does on the add side.
> Scan all nr_targets slots, the target[] allocation size, and clear every
> hit.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

