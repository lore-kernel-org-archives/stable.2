Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC446345CAB;
	Wed, 12 Aug 2026 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575828; cv=fail; b=nuuKTitwqm9+g4Im4HzHtAKmDcenfIfZtnLlmb+lDRSevtVsC79MAjk8ks3I5ySewOEYg+Z/EoJN3OSc+5dYaOmRhkZzfBlCUWFb9e3TmoO1oP/7uCaxJZRYFOT+9YhGUtIXXoyVziD9QTS5G/8sbd7ydRZQg/4ffNM8q0uNm6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575828; c=relaxed/simple;
	bh=vJHIPWclqvPdzBj7yFzscKDzRRl9TlC83GRgmMEBmcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/0XHuepZRUZaWOfi6PhSEDFJYVkkqAITUAsBQLzituEC8hodzUQ1UkETg5oHaBDwwoOYFZGROv80lo5JEsp2Kku8lGt9OAav4fYMJHmVFTIGn0w2U8+0TG4BWGKOzx2fOyGpIKyVOcRgJPGrTIxwfU5/5ARFHBw8n3MwmvfWjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZM2S9f2E; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZM2S9f2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786575826; x=1818111826;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vJHIPWclqvPdzBj7yFzscKDzRRl9TlC83GRgmMEBmcY=;
  b=ZM2S9f2EZXWP3RyHYsHWx7IKxjMO1/45z1csrzBeKXq82CXYfp+Npndv
   YmiMnKTnvXXu44hMRmDvntcnY0bDt2dYwTJYKHZghk91ssO3LV067ILkQ
   urYzbmgyPtDw/sNrVaJMNfj6dYKEFGnNrBc5fSq3cMmXthybH5tSkS+VZ
   JT7YcDKCMZcaVn3a016spt6PumoDTtPPIBjlbKnMXuAfrnQUI8DeBML59
   xm/lsR2DcKoCyaClxwe5Y6ng6AyGZJyF0Qcd4x+y2uV8/EoEQSNP0oaTa
   Vy/+5NyP+v0aaWsFxj3Ghw9pSmWt1M+v7euq1lPEAVNfGebwGM0KRpabs
   Q==;
X-CSE-ConnectionGUID: 6BViuWxQTZy4rPh+3N2BCg==
X-CSE-MsgGUID: dn+OhsucSP2jWltRrsndxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87361959"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87361959"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:03:45 -0700
X-CSE-ConnectionGUID: cha0kNkUT2OqQL65vspeSQ==
X-CSE-MsgGUID: rJgOuNBnTkKO8d3D/+B8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="261154168"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:02:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:02:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 16:02:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWZrYARHlRHP8i6Q78c/vnpc99XUiNmnySnnI8ocDvG5b9iQMxoF5co2iu9rv3fpZXoF3MT4VXuVzuIOaPkDfprLWVq4xkaVe5D1Ye4KGcUcAREASDeS8Z7+tr84c9JaYSNqGEV8+PeOQQimhqZ3hJP2aoZDNdFL42ZxhZLEJfxUkjeKSV8OHIws8vpMaumRl+k6YyBL4cEDSRSGiFGucebOE1mkI7Totski8cvnzEgCs080rpI8tbOWHbH6R++ttiVsuSVKx5r/h3/e4mYlrqsE9UpiZMk2c/pK3SSU8YIphodq1iR65DMZ6uZl4JcLJQ+ijRnvT08Y1S7y7H+qEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePaGp0lhEWQcMfsmlKMZoDQBO61sonJLiYCVPUK62qc=;
 b=oQz6AHg/qwD3ICyzYoGwVrgNLWGQ+4NS38HFl+VA5t5Nj5Qcpbqck7fw0YUXVqqF1BaTP4izbrxZ4rT2+U/kcz10pbK0RP5Q59AK94q1mMomqfCUKp9Z3oGK3tTHuSYOkdUSWAxmme6up3TxAnLlzV2wsN6av/vai7byXQmtl67e+DdJTK/h8Q0fkO9uLZgbJcD2/UCAOyIXwQRVV5XRU8gT5Bpw4onY3Q752WE1ehyrTI1q5JDi7X5MLh6Lhu4wurGfPiUUn7k4aFkepo4yIHfXqmeDS/MeY9oYTiZt4b+9GjQnqYw/PZ5MizC0jjNRYfYKVLZ/jfi88ab+1T0boA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6306.namprd11.prod.outlook.com (2603:10b6:930:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 23:02:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 23:02:41 +0000
Date: Wed, 12 Aug 2026 16:02:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <linux-cxl@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v2] cxl/mce: Avoid alias page retirement for corrected
 errors
Message-ID: <anz7iV2WrZfAnVib@aschofie-mobl2.lan>
References: <20260812151759.14390-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812151759.14390-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 32596333-a591-4696-da68-08def8c5cfd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: eYBvXX1hn8DAZwrpIq5vUuDucTiRhT+TOWaEAME94mUDGz3wtGy6i27zmL3uxq26Vvt99hBv3iyKCW9/iNWTShCOwZgLRPuxyJ5gIYmkKvyvNTUF6BzYlB4kjrFFFKJBXqWpBtFcUQxKhXQQv/yJScwyYVfMhAQIX5Rp/BZHX4ZRr6o7Txsg1XPNshYfUM+PNRUa3jop6xkdGZ7iT1Xh/uQtjs646SBLmKnZklXe2I2H9qaM+EWIIuz6IARuDuzYBCM0qKy5YpyK4fJ6KIax9GVX0EQYUIIPcq9zU5Or3UzC6u6GV25oQHlkBacrIf23n4R9LG+qkOuCibMpeTFCFdBNhavMW/BkCTPtg5Tvc2QKXj8bELuBVoCxWwC8pJG4gJaPuxTZr9LABc2UYJmpjRjjlgoGkf4B0nGWYD1DIk94dHb4AvdfAaW156pO2odv3tKMG0gKyoNInIlLzYruMY+5WafMtYRYMs2XKW2QhaAva+M14LQGfOXRMn8luiWULQ/2E93caxT3atxA2XXKzNfN6vMdibYCcgpH7z8tqxjwUZ38tdy3AupmQoOXV4uya36geSrpZcG/nkSsjzGYcuwl+LcD5wB8VDEOSH11uAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jM1Cs21NDK4KA43nsl3mwLQcr/Og3tTvCJZP2x9G8a9JGovTMh0B/FWo+xwU?=
 =?us-ascii?Q?D1jenl4qx47/X1yovnpko6+SrVB22LfgMYI2llbLIKwat1VQ9ubMzawBT3jh?=
 =?us-ascii?Q?RuPMHz2l5g63dXy964cLmNc3hBYI+Cse73A5xgrlaPjuFvUEHOq0kYJ3vCmK?=
 =?us-ascii?Q?6s6sN6FlCQX2Ba3K4M8WpzK/Rh68Whf7weiq2bPWhmDdJPw/HgaIKnAPvIGA?=
 =?us-ascii?Q?59dSI+kNPpw5X6dfkQ74WTjCycUnQdZtmpRBXvXYjVXPx/393zMSWb9rgulI?=
 =?us-ascii?Q?lJB446Ueod6bTtaO9otWU1JBDlMayzNhekI+6YEQPSuFCm2YB8emKONl6XIK?=
 =?us-ascii?Q?a+vId9noklT6r/lGYX013yacA56QYN+9xHayBRCRHRf4jSgKeFNaJzdiZt8B?=
 =?us-ascii?Q?FIuy3GhnHoXeUBn2zJB3db5m+YZsyoyrJGQUopdtTGSDkHE9Xp+Lr3t2K8U9?=
 =?us-ascii?Q?acwhZ40gw0J3eYZAdBVnmHxjuFBqTXxCUnAlwX8eXwAPAQYD34LaH9NOcu3P?=
 =?us-ascii?Q?DwQFDdZkjUIXlwPsFN4qwpKOV/V0ttzz0X2eAeYHGpPCLwaV8KizoSgXoXZg?=
 =?us-ascii?Q?LA9zR3VOBttSVASm0OdY8lTmBmTo5H2opJxSj3dHHldMTW7COvVqMT3lkddP?=
 =?us-ascii?Q?+PAE/KSQu6jf43rvGwBVbKKYu30dJDrc3WrnT1HW3C0i1AZ9hxQ4EfxGC+Nz?=
 =?us-ascii?Q?7AibSDQG2jSk/EuniUF9T3BPNO9G+krdrTeDnS9ENYOI/jUplzALkNBHf/rR?=
 =?us-ascii?Q?OcdXjDlhCxBTYVeS1ZY+jzhaKZd7IRHpeSqrl/ve+U65tWk8C3gJXY4KDo4x?=
 =?us-ascii?Q?4ZcUB6ZBP5km7vfx6rrGDQHWxm04w7vHflGy+HWuvYKzYTV1pEIEELqoJBHW?=
 =?us-ascii?Q?pT/4TtwAvGVeSnxdkc589dTb2RVEJ3dOjBeKHPDjK9/IozOYqBycu30aO/tp?=
 =?us-ascii?Q?aDyOLfvpAALs0zq+bBX0pHdujkkftGDPYRvSUCEjj7hMsyveA8MJfuPVVO/4?=
 =?us-ascii?Q?60v32JCr3uj43p7QBXWcqCjZxUqX23VsCdwQMTMtqzneys0EY/nFWMLdSHK/?=
 =?us-ascii?Q?sAB8NGDSmx045xYcli3f+WMQrIuO0a0zNRUAhD76OZSoWdMToaemBz4Is/MV?=
 =?us-ascii?Q?kGTe4KAiSVXGJfxrGQZM/sPWz6rlsjsdGfIc7li2HxxvE7o7z3kmwbLal4CU?=
 =?us-ascii?Q?I96OoevYdhJK8P9q1zBZvg5gqcVGGbDPapgEKzgPvZPLPRZ78U4TIVG9MSqG?=
 =?us-ascii?Q?zkOBZe8rTXSnIr0ls8os0T0mlFJFSU+c650QL4RYGJXsp9GZ1Maun8B4rPKq?=
 =?us-ascii?Q?9295SMw/OHgBr624jYN7QkXMwliIL9y0GPq345iRNwVpbbgBFdVaB8Y47H76?=
 =?us-ascii?Q?g6SULibcqQsyifZE8f+u2bubsU+H4KVzqooETahca7KPcEWQqcfkH3oWXvC4?=
 =?us-ascii?Q?/vprv4hHn4aUE8O4pHfaby504Bi2deA3m2iVQ0k20/BVc1lVeMMwbes76LSc?=
 =?us-ascii?Q?vkLFuNN76aX//dRGX1R8AsJh84IzZSMtseZLgW2n2rtLoD+G3E+hwETVa8Iq?=
 =?us-ascii?Q?3tH9DunETtpzqpWv/qvshcQNM7sptCWMzdPPYwHj/jzpIHeb3+188FB1LUiQ?=
 =?us-ascii?Q?pSxBmLep0wAiiaOYTW+JJTtyYIzCJ1oERGuzfEaUq6fHNCN3N65Kjnf0UcrM?=
 =?us-ascii?Q?mXECa2xEh84qpSim9H2cpF4xQa+UGwDGxcghz9HKsnF+9Dt8iEE4OpD8FII/?=
 =?us-ascii?Q?kkDHW4ORKicGeOklJDsUJHYSY24bm9g=3D?=
X-Exchange-RoutingPolicyChecked: aO4+N5GfSKbjTo0rH89+cEAZSPEyrYT8fwq/SAqdqvKHz9iqb6IWYX9Na7VpuB+QDj6nfo1A0jUpmUJXMQ9bfuL4z70PIKDPA1cu+71o4Ll+3EU1OadJfP//qasvEPKXktgBdMH60Y6m7pAZjgkZbibeesDYZN6tukrqxKYS6QIiaYrfh/KgYFA+Qa+iO27cBQffkA+2lc8iVMAUJbw3gYXTJgOa9gV/OqfCgT0f/GYRAtgYhDNXsBAzhgyDKibCvyeO+M8pjcwjgbgMGomuoUrz1TjYBg3CqZY84+BniQsGzY2phvP25J/y2rAkZeHqsAoFPRl3ane22i9ER+8m8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32596333-a591-4696-da68-08def8c5cfd8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 23:02:41.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpXAqbDyYeedFPcGmQ09RQnt22oybd2hRi3Pde8RM8VpuiD4LTNQLdKGwQcj7WryChetaSJiaCts5qvrsaikWr9GMbIOesX0i0uHC2YC55k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6306
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 08:47:59PM +0530, Shaikh Kamaluddin wrote:
> cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
> (ELC) region for any MCE with a usable address in the region. This
> includes corrected errors and non-memory errors, needlessly reducing
> usable memory.
> 
> Restrict ELC MCE handling to uncorrected memory errors. Use
> mce_is_correctable() so that MCE_AR_SEVERITY errors continue to retire
> the alias when the reported page is handled elsewhere.

Hi Shaikh,

Thanks for revising this.

Sashiko had a complaint that needs to be considered about the AMD
specific MCE classification and makes me wonder about using
mce_is_memory_error() in the test at all.

Could the fix simply reject mce_is_correctable() and retain
the existing mce_usable_address() behavior?  (And yeah, I'm thinking
I may have missed something in that complex description I asked
you to trim.)

Sashiko only replied to the linux-cxl mailing list so not all recipients
of your patch will see it:
https://sashiko.dev/#/patchset/20260812151759.14390-1-shaikhkamal2012%40gmail.com

BTW - it looks like Sashiko never looked at v1.

-- Alison


> 
> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
>   - Reworked commit message per review feedback
>   - Dropped redundant comment from the code
>  
> Reproduced under QEMU/vng. QEMU's cxl-type3 does not emulate the HMAT
> extended-linear address_mode bit, so ELC was forced locally for testing
> via a one-line debug hack in cxl_region_probe() (not part of this patch):
> 
> 	if (!p->cache_size && p->res)
> 		p->cache_size = resource_size(p->res) / 2;
> 
> Steps:
> 1. Boot with an Intel CPU model under TCG (KVM host-passthrough will
>     otherwise leak the host's real vendor ID, and AMD/SMCA takes a
>     different mce_usable_address() path than the one under test):
> vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> 
> 2. modprobe mce-inject
> $cxl list -M
> $cxl list -D
> $cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> $dmesg | grep "DEBUG: forced cache_size"
> $modprobe device_dax
> $modprobe kmem
> $ls /sys/bus/dax/devices/
> $daxctl reconfigure-device dax0.0 --mode=system-ram
> $lsmem
> it will show as below:
> dax0.0
> [   42.857642] Fallback order for Node 0: 0 
> [   42.857828] Built 1 zonelists, mobility grouping on.  Total pages: 1010805
> [   42.858446] Policy zone: Normal
> [
>   {
>     "chardev":"dax0.0",
>     "size":536870912,
>     "target_node":0,
>     "align":2097152,
>     "mode":"system-ram",
>     "online_memblocks":4,
>     "total_memblocks":4,
>     "movable":true
>   }
> ]
> reconfigured 1 device
> RANGE                                  SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> 
> Memory block size:       128M
> Total online memory:     4.5G
> Total offline memory:      0B
> 
> 3. Load the injector if not loaded earlier and derive the two MCi_STATUS values.
> 
>     modprobe mce-inject
> 
>     MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
>       bit 63  VAL     - record valid
>       bit 61  UC      - uncorrected (0 = corrected error under test)
>       bit 60  EN      - error reporting enabled
>       bit 59  MISCV   - MCi_MISC valid
>       bit 58  ADDRV   - MCi_ADDR valid
>       bits[15:0] MCACOD - bit 7 set = memory-error signature, per
>                           mce_is_memory_error()'s Intel branch
> 
>     python3 -c "
>     VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
>     MCACOD_MEM = 1<<7                      # memory error signature
>     ce = VAL | EN | MISCV | ADDRV | MCACOD_MEM
>     uc = ce | UC
>     print(f'CE status = {hex(ce)}')
>     print(f'UC status = {hex(uc)}')"
>     # CE status = 0x9c00000000000080
>     # UC status = 0xbc00000000000080
> 
>     MCi_MISC: address-mode field, bits[8:6], must be 2 (physical):
> 
>     python3 -c "print(hex(2 << 6))"
>     # misc = 0x80
> 
> 4.  $ cd /sys/kernel/debug/mce-inject
> $echo sw > flags
> $echo 0x9C00000000000080 > status
> $echo 0x80 > misc
> $echo 0x190010000 > addr
> $echo 9 > bank
> [  221.813395] mce: [Hardware Error]: Machine check events logged
> [  221.814716] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> [  221.816200] cxl_mce_debug: spa=0x190010000 contains=1
> [  221.817089] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> [  221.817655] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> [  221.821504] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> [  221.823903] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> [  221.824617] mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80 
> [  221.824997] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
> root@virtme-ng:/sys/kernel/debug/mce-inject# 
> root@virtme-ng:/sys/kernel/debug/mce-inject# grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> 
> CE without this patch:
>   cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>   Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>   HardwareCorrupted: 4 kB
> ------------------------------------- 
> CE with this patch:
>   (no "Offlining aliased SPA" message logged)
>   HardwareCorrupted: 0 kB
> 
> $cd /sys/kernel/debug/mce-inject
> $echo sw > flags
> $echo 0x9C00000000000080 > status
> $echo 0x80 > misc
> $echo 0x190010000 > addr
> $echo 9 > bank
> addr  bank  cpu  flags	ipid  misc  README  status  synd
> [   61.681659] mce: [Hardware Error]: Machine check events logged
> [   61.683442] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> [   61.684528] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> [   61.684974] mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80 
> [   61.688880] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
> [   86.504456] clocksource: Watchdog remote CPU 11 read timed out
> 
> $grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------
> For UC, same steps only status bit information will change :
> $cd /sys/kernel/debug/mce-inject
> $echo sw > flags
> $echo 0xbc00000000000080 > status
> $echo 0x80 > misc
> $echo 0x190010000 > addr
> $echo 9 > bank
> $dmesg | grep cxl_mce_debug
> $grep HardwareCorrupted /proc/meminfo
> [  313.398747] mce: [Hardware Error]: Machine check events logged
> [  313.400518] cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> [  313.401727] cxl_mce_debug: spa=0x190010000 contains=1
> [  313.402157] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> [  313.402663] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> [  313.405999] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> [  313.408375] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> [  313.408999] mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80 
> [  313.409367] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1
> 
> Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
>     cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>     Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>     HardwareCorrupted: 4 kB
> 
>  drivers/cxl/core/mce.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index 65fed913b221..e3c561489a00 100644
> --- a/drivers/cxl/core/mce.c
> +++ b/drivers/cxl/core/mce.c
> @@ -18,7 +18,13 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
>  	u64 spa, spa_alias;
>  	unsigned long pfn;
>  
> -	if (!mce || !mce_usable_address(mce))
> +	if (!mce)
> +		return NOTIFY_DONE;
> +
> +	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
> +		return NOTIFY_DONE;
> +
> +	if (!mce_usable_address(mce))
>  		return NOTIFY_DONE;
>  
>  	spa = mce->addr & MCI_ADDR_PHYSADDR;
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.0
> 
