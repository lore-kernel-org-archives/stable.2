Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA445221F39;
	Thu,  2 Jul 2026 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951888; cv=fail; b=VWJkrz1zc7fjexFt5gpL6wLfe2x2EJkC4N5W9F2zCUflZb66K+4etJ0F71QzZ0g3fpozpfyxE67N2pVPRpiZiydPjLnaOzRc/tzYqqyCanEF7IjqZxIgb9jAoPPPJBlclvbd+YWZY6FB10U0W1/z0ZgtCyqHpGOSLDXWZjtzqKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951888; c=relaxed/simple;
	bh=jpswpoI0GOMxq9rE59wbbaBXBLxBDW0ckIxCQzBQKSQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phmVmhPQJzEKsxCwSn53MIxz5kk1zqlxCF7UzM/OwAxncVD5fepaCVyY5O5m6NUeUwpX25M2IvGiuNTjHoytb07XaM4BklGRcFna+IHhwYz7AeUjKvq3wYEFqKv9xzx/akT1KnInfziXl3zXPiXkvLz5eU7BaWnxZXJALLKySPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkLcuV7b; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkLcuV7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782951887; x=1814487887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jpswpoI0GOMxq9rE59wbbaBXBLxBDW0ckIxCQzBQKSQ=;
  b=jkLcuV7bHyILcH+wKbv8+d50/xk3snHGeiMHas5ww3LEjLSLo7IahkJW
   EiB5nFyKTZ7FujbjUmMeYfVBl8oDtSucYx9m1TIN/+EFkTQt3cQe2Tiv2
   URa/2o/JsdSYmJNRqsh5B+Y3Fqy14iUM6sO0iouhJHwY3i4DKiMbZg3E2
   eeO134+C25K320RfPHpGWBuXPLe8ot3GT49GMKOx5jCj2E8kemOrnL6JD
   Hyqzqx2MOnCRBZCr7nxUqP7WkqW0SBVQdeMCAf2P7R+zP6XtMiJOyD3hc
   yBzG4cuV3HoGP0trDoWcGxvxTdmKELfr3OStjI7jQVDEgm4KZGpm/0CXT
   w==;
X-CSE-ConnectionGUID: YexQrgOmTyWU+IAllZza+A==
X-CSE-MsgGUID: VguBcV4BQ16Sd8lEYghTbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95198850"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95198850"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:24:46 -0700
X-CSE-ConnectionGUID: Bn8rlex+Sd6h8KHHHzXU1g==
X-CSE-MsgGUID: wJwHHU9bSvCNbcz8kRcCRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="250061506"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:24:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 17:24:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 17:24:45 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 17:24:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7mOpx6JqbKUI/JrX6nLWe7hW1aYilGjn4rSsAL3GtwhLE3qnL97XFkUYIHAQGU2XnO5Vk/Xi6bJD0yuuC0RoE05gh/bME7Bfdkoqmrxhu9c8rCw7gHunDrrVcvMgsHOjtvAkE5oCgvGGFNEMA/tdiYptnWRaDFDY9QaxX1J/Ya0rYH62Q5pJFSEWhBzr6zY50KjM3rmKVDesVjEtujjG/cqesngJFLIKnAKCilq7wYM5IKgI6JWQT99BhzFZaHz6U2cZasY20SJf1srjUAGiy+dvjbCwTcWoOq/t65cbCMHIokxM9+IGVNbh+tmu+MwDB7SADOuATm00LKJgSmyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+TRGiiE1EV8ZxeMiRLs+patQR7n4KxKMHTSc+MGJYQ=;
 b=GUHxtfFp1YH7CK08MItsV7gPMD3Frxz34gHshzMqgQOo6cAYKfcDxgjAqSqFOLnUDGzoTZLkRya2WFBgp7sr0YQ+KdDjNvBWLBr/aJ7Kvf3UJr7ISGZvkPLdlZ5ehow+I3QSseanTtrBIGeDJDUTkSRw85FcN0G2J9jqGQ/R5LT1QEdkRVUYy02hEEjNpqQfYRnUcwfhzLxSr3Oh4EE5VMfE+fwEvMVjRy9u29iPAG//cogGpP7sau0ej77wOLZPNIhsDNz20zwcAgdgeAQwf3hdbUkHRB3o+sV5NewcwgB04KiN3A44Y8vQ1H12VMyltGcAA6QKFgQJnxHoD8MgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 00:24:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 00:24:37 +0000
Date: Wed, 1 Jul 2026 17:24:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] cxl/pmem: Format nvdimm serial numbers as decimal
Message-ID: <akWvwcXywvPPTHhI@aschofie-mobl2.lan>
References: <20260619055932.1354182-1-alison.schofield@intel.com>
 <ddc1d44c-37ef-473e-9f87-efe207d8bcbf@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ddc1d44c-37ef-473e-9f87-efe207d8bcbf@intel.com>
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: cc64ab66-81b9-4c52-0872-08ded7d04cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 82g/mgR7T/eDEFGTP0JIIV9zJleHSGJYdiXVReBS7XC0qDHPdu8fdvGJCIeoSz4gmEjz438M6sr686BgP7Yocen9iKUYXO1tgTBLTIpPPO/+Gzwd/8LEyTGBVrS1cmqV3Xwe0fym35iLSF/vtiITwi5vf0Ab3SDdt/q69PH1fplJVFrZVzjIajbQeUft7UKQ4g7QuJvxRMXr5rrFCTRBTzYBdsUliKvz505Gl9VhKMclDW/RMAgkY+UzA5YM6cnHzj6T+oz2lazOSO7Mnsvb+H6aoMrOyOj+uiGnETsIR14p0JDlqqSqitLe6hieoI5Tu7MgYkFKXJkn12H+pPnUBGGPk2md0lt9yiTrwlDipGxl/EdWkUmy8X5AEO8Gve3oFT5fqYv0mXqTOix72UD6se3Tz4QRXm6wNuG/5zIc8AlyYniV/2174MDzWOzyvrk9wgQWRUO6DzcubcI9MuBCBgi9zPbu89/CV6BqcjvKKRcWGqCaGkthn8vNj6+019EI6qM+tSilx7anlXJpL1ep/SbwCCR+WzuugXGBlwSdYrSa16j9dBMSxuY3LMl8b2CKTmGqiRNvGOjhDFLaTahiZhiRPTxoG4ZkHGZ5GacvEbn6emeF6V88fJ9veIA3dxrZo5csrnT4kH79Ib0+iVyIQrydOzD/rHfg50fBYyMLkYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JtdRQXuXN04ROvnHBAe7cBDFi/XKvDg3I9xsXdOJVS74kEsuU2Xsh4uqu7cr?=
 =?us-ascii?Q?apjgByq272DWHHZqM9omU8z1N9B0esp7s4bxvGaY6occVAm6dMw7QLJqHCix?=
 =?us-ascii?Q?zpTyP4tMrkg6CJDLx0j51+SjRPhZE6r2MT1hFdkiGUmPRk0IIDrDFoWDKwyY?=
 =?us-ascii?Q?n6m+bwvXeGdWEhQOXokTs+Aw0eI03cuELaTJaQsiaPdWfB4valLO/zd6FmWF?=
 =?us-ascii?Q?49OLT8Cl7QjBjf+yyjgY0Lo5TAzq1CHEiebhI2mzTJN7kJqkGnU7KD7XKFyX?=
 =?us-ascii?Q?d5CezyJrWV1pIQsWLw1YaYX9Ou9aBzh15xbTYhBjdcEWJGmP0BQvFgEmu9Gi?=
 =?us-ascii?Q?n+eoUnbAk2SnrQU2FiSA2R1ZqoPOFb54U1DEFoTnThyoJWHZ9pSy7B9jLw8X?=
 =?us-ascii?Q?YDDlLQKvzscCQHE8JW5E1ArVa/snmye29cnzAIF3vCrT1mrNSwDwqgdY33Rq?=
 =?us-ascii?Q?KnbeJxHIs3pFFWQHiLqsjwu9dTDTphOZOhpH7hRLUS3NpjQWIjiicQ2G3q5J?=
 =?us-ascii?Q?O68qnOZYPfE0Cn3u/Iep4GTBmsVzprTx+YV/m6EjQd7hEJkMDh1a4TC4y97m?=
 =?us-ascii?Q?sfpXRQijz6sx3DiCyZ+5aRHuSbGiXQ+9cGQvwcz8lpqCDGSAo+w2bMbVplgT?=
 =?us-ascii?Q?jxjtzbWbQLZYgMVgw20pp+3skfUa/TdbUa1dPymra4ba9DH5K5NyC5emp7d1?=
 =?us-ascii?Q?WJG2xFvp2Q9EWWA51H48JPzoVY+RsqqDnn82+VqNc55A24B6OUFzqd7S4EBx?=
 =?us-ascii?Q?saREjkrnDGxxgCUvo2vxBvKY3IXzPi7xJwFzqLpbCMxeCv73uinsdqX7TGy2?=
 =?us-ascii?Q?oLZrZH+F0QfxYmdgJHpcmyWOvR0KAz0vGq6IpOZf9nQNxS9sqIdsFN/8Dblj?=
 =?us-ascii?Q?1MWl6xl2jymqcShKIMc4NqTLs/OaTdyzrxSt3k2jNt49HS8HIKFs5pD5IOig?=
 =?us-ascii?Q?dvI91y4+RzSi7kZFNCom/ZQQ/nmFWLMfA7HFd1Ngrr+jOvxUMV/v3Vs12AUA?=
 =?us-ascii?Q?uettu8HQdJ+qP2rMt5TAEX3gHyvpUhWFuksEkmXGcvCPGsxvy0FJ564GvkJU?=
 =?us-ascii?Q?EXIEEcWFC5/J9haUbX+7XerHcy6daLwJkifNDFnFTex8VqfJMbheRY0hSjcK?=
 =?us-ascii?Q?ce5ziu8a04nSW9bghCOOxqAd7k8nj6BXxxxuU/uBGYkNsaaqsWyDZxn8o3oq?=
 =?us-ascii?Q?AAaaddQVJR2BpOhNB/963HsZfKpk6rzSWZEN4s3qPCJltAZ2JEKJY+AD5xPQ?=
 =?us-ascii?Q?oZF+bVzSFeW3iWdZCOGqFOrSAExRRHHiL199l4E5hBJ5Bb3tJUQVlsHjx3hI?=
 =?us-ascii?Q?JJl3n7SdbV769tFipN4YTo01XeUoeuRLOsbk6jwEHIaHixJCbj5ihDxK63Rw?=
 =?us-ascii?Q?HZ3Vs9Lo3G305MzkMRxtf/t2B/ebrujG8ftDtsZMNfPS2M5GY4r7Do1O0AbV?=
 =?us-ascii?Q?wHwa36vbcKhXy1VAoy8l5SL16KyjqhmrH4GeZqAkS4WBOBP6RQBWCU2+2eAu?=
 =?us-ascii?Q?239FssaUwmle4Lr+Zz1DTw9Dvy5OmgkZvgtybVS7UKlzKxmYt+Jlv0slZxgD?=
 =?us-ascii?Q?MRGO7yr8qlie94aN7DvpceuW3OiVivyzh4KiB3u18IEC3XDUyEKV2ciodUYu?=
 =?us-ascii?Q?2Cq4UQBAccTerPJKlKsryLhJOv2dQvo6ita6TNVZNRpnirs1pdaI2RYsJJgK?=
 =?us-ascii?Q?rrPBOq+RM2lK7BSDHb0pUWBXa8viM7ZgKv0Wv2OopMOgT879ruY3nWWqz/Jk?=
 =?us-ascii?Q?H13W2pD0ysjrzHa6W+Q1/g0jFrzfO44=3D?=
X-Exchange-RoutingPolicyChecked: Fyfmxsvk7Evwu283OJxZWAt5LfChm6IjoKbihjatP5yQ1fIXif4b41pPRXE7QOo2Tc4o259utt5jVa/4OL+BIC/12w+kmXgat+hWErRqQgWeI3aSsVqoM1FKgwIEMcwWgmK2SJyPrXnV7jUgWuNYKUbp8iJkpb5/H8mLp0tG9Iq689CYpMvy3ew0jXH0UitrgooMxygtPrM9Oab48rjVLsa4JzNw6VO74i0eqF7yuVnaVjk7qgO5vo21gzQhUUsOP7F/go93gtSUvvOwh5UzHMCnQdwKM2XDdzSfuo2qEde9OCoWXFYyv9KjnCLpyVUclrDXCm0fa15g5lHuFREEkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc64ab66-81b9-4c52-0872-08ded7d04cab
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 00:24:37.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eInX8N88T+zGgcw5k2AjQ4iU+XnmU9XXISlWXwguUj04BK50nmWIaC3iI7ha3bo4+jb5YuDHCJSXURfzethO+lTHAwuH2dBCgjbnpOyOw4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

On Mon, Jun 22, 2026 at 09:19:11AM -0700, Dave Jiang wrote:
> 
> 
> On 6/18/26 10:59 PM, Alison Schofield wrote:
> > The CXL NVDIMM security passphrase key is looked up by the description
> > "nvdimm:" followed by the device serial string. For serial numbers of
> > 10 and above, the kernel auto-unlock path fails to find the key
> > because ndctl names it with a decimal serial and the kernel uses hex.
> > 
> > That means a passphrase-protected device cannot be unlocked after a
> > reboot, and the pmem namespaces it backs do not come up. Devices
> > without an enrolled passphrase are unaffected.
> > 
> > The mismatch occurs for any serial number of 10 and above. Since CXL
> > device serial numbers are vendor-assigned 64-bit values, that covers
> > essentially all real hardware once security is enabled.
> > 
> > The 'id' sysfs attribute is established ABI that ndctl consumes as
> > decimal, so format the kernel's serial string the same way. A u64
> > decimal string requires up to 20 digits plus a NUL byte, so grow
> > CXL_DEV_ID_LEN to fit it.
> > 
> > The issue was exposed by CXL unit test cxl-security.sh when cxl_test
> > mock serial numbers were recently extended to 10 and above.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/pmem.c | 10 ++++++----
> >  drivers/cxl/cxl.h       |  3 ++-
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> > index 68462e38a977..2ccdf04c1f43 100644
> > --- a/drivers/cxl/core/pmem.c
> > +++ b/drivers/cxl/core/pmem.c
> > @@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
> >  	dev->bus = &cxl_bus_type;
> >  	dev->type = &cxl_nvdimm_type;
> >  	/*
> > -	 * A "%llx" string is 17-bytes vs dimm_id that is max
> > -	 * NVDIMM_KEY_DESC_LEN
> > +	 * dev_id becomes the nvdimm dimm_id used for security key
> > +	 * lookups. Match the decimal serial emitted by the CXL 'id'
> > +	 * sysfs attribute. A u64 decimal string requires 20 digits
> > +	 * plus a NUL byte and must still fit in NVDIMM_KEY_DESC_LEN.
> >  	 */
> > -	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
> > +	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
> 
> Can CXL_DEV_ID_LEN be used here?
> 

No. dev_id is defined as u8[CXL_DEV_ID_LEN], so sizeof(cxl_nvd->dev_id)
is already CXL_DEV_ID_LEN so that would make the check
CXL_DEV_ID_LEN < CXL_DEV_ID_LEN, and that is always false, never fires.

The 21 is the requirement (20 digits + NUL); sizeof() is what the buffer
provides. The check has to stay independent of the macro to have meaning.


> >  		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
> > -	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
> > +	sprintf(cxl_nvd->dev_id, "%lld", cxlmd->cxlds->serial);
> >  
> >  	return cxl_nvd;
> >  }

