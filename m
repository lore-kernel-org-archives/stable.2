Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1D2FFF8D;
	Mon, 24 Aug 2026 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607649; cv=fail; b=CeJAPfw4/nUtX5uvpDMvEd/gHvDFZ8hccCnIiPbwTX6yfjSg0INLwg6bPlRrSgot5sChd4GMS4v2gcj+sBkmsSIHBexZ/p6uDl9Vl+4srTTJLubIKmsgYKZk+re2y9g19TnkNuDoFjcy1khC0eP5XCM7zsVkBTQkK7+R9Gmi+8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607649; c=relaxed/simple;
	bh=7REVRVJUPFEC7XJHx2S2yHEFKiZfldjQsEgR3Qp1Mfs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ayKj8LSyIQdQblP1ZD9c8Hisrv1WaOG2J5Mv7yn4cR2iZQ+XealHj67iXoytSo2EmU8ZwB4aRHFTghYrclhxWiVmiHFPGHaCRSJmEKxwqeabJzokwy1T0JXAgfQG7jf1q635Ic14bEYLbntUW4GLlp34XlOw57K508AeTvQPwNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJx5Ytvv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJx5Ytvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787607647; x=1819143647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7REVRVJUPFEC7XJHx2S2yHEFKiZfldjQsEgR3Qp1Mfs=;
  b=WJx5Ytvv3dUgzG2xg+UOVoXWDTNgei6UwJkYt/AZLGB9y1OX7Qj6r3Eb
   DfnpGNhqB3bJLRPSOU+UFQuCVXOIHFizDGUxD8M+Y97abZKvkbdUHVaPS
   0L5wUo4V6bNrT9363wOMSQ3dRqmkSuZnGQzIewt5/Whjn8JXqAh2I9yW+
   BElL7wM/r2dqsFCGYjrSZIescfYmVD9Vzasksxs/56mKZlYw4Ldeh65IU
   UoffCVBykTfCaps22cQOxCaccjd48K0gwDPNXkGWsDQe0PStadGeupyG6
   DVdkXbp5ZZ2mqu64kL7lRfxv2VEJyKaj1fH6vwVBLWbA1+7HEe1wqvZPq
   Q==;
X-CSE-ConnectionGUID: ZOvLpxIZRQ6Nggp7zy46kg==
X-CSE-MsgGUID: S+yHwkJ1SFyvwB8aj98O0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87944104"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87944104"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:40:46 -0700
X-CSE-ConnectionGUID: L6kUtwYeRfW02fPSGkHx3A==
X-CSE-MsgGUID: SBWLIUYPQo+mm8VFkG/Mtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="272324606"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:40:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:40:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 14:40:45 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKQwRWGRRYUak6EWpLud20e8JmSLZMG4S2QpOngKEKUs2KBdZS9z4M/wtVGJ/bZYq+RDaN0aCqCQk6iHZGyfz6Xx7sSLcgm4gddmSCKrwLflS3RuHNSYTnjoWrEXueLVdQ2IDR0XNU6xODrhDI2uxb3vyA8ixUYexbdKMhN50ct4GVotNB8VvYtiAxaYk1J/Foy++T2tHxmoqZmHjF3aQIxomrn47fp7l+MgRdKu+Tq342NAy/6xzo0XAZuRbw/6qceNBKvkxeoFqcbfqxgiA6MLyMYb1F9GYKJZJKPLfH/AXk2VAvECkBZzxdQkz9z+8PtpZr/+ZLyMw6i7eaBaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkq3ZkfMihJH2DRViQhu1FxHx9ZSI9ytmNi4O2ontmU=;
 b=n2p380TaCwhY7EiAbjFRgEI9mBLwJj7VXMALiZK6NWROuADJi6DM1k06tZY1s5V8kDiENVQvKyOOo6Qx1uTb8xiH/s7uney3McV9TIO+LWZYe7B3h2FGWMMg5gmgbHKWsQ1t48FNHWyHwt5A5kkoTjPBlHHFZp+nwkPqMQZvJt8VycbmmwiSPOrVHwPHwVLyKxqYHI6u4gWHgGnyEingU9YI68MHnLmX0PsHYAd0OND5KtdNA2fnI36AqT8+uHzspeUXbWuAiraN6bxp3CIz0DO8+y3T+xGydD+IR/MhtvCb4/Rr1xoKZR7yLkXkPjLi8yXkFiwtw6DdJdKP9crxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6035.namprd11.prod.outlook.com (2603:10b6:208:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 21:40:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 21:40:42 +0000
Date: Mon, 24 Aug 2026 14:40:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <linux-cxl@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v3] cxl/mce: Avoid alias page retirement for corrected
 errors
Message-ID: <aoy6VWVLWcaqHiWQ@aschofie-mobl2.lan>
References: <20260824134957.11085-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260824134957.11085-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: babd5b6a-45db-42ce-0204-08df0228589b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|56012099006|3023799007|5023799004|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3vjUsjK3466awS4e/UtWd+84g2X2mpu1HzD4cznGILuciYJCuPg4MBwT/cQvEINPqXdXF+SuNI9tlBmpulWU6Kl/D9jc7p8YhbwAT50dXpOwV7CPXXIsk6Z894oEXuWLLEtdRGNDgr9sXw9MU35kX+zz6sV9ONbQVlu5XlSZG3AJjclUKqLdBMgUFTsdt31TUyF0FSMqyS33xdTqEfEOeSJaKBNgVaTWRmEc9y2aSoFhsPNZiwdtkIqvynZJoPCFBvNZdjzEnQVouaZr2hQs4Rr++tUlIcRArofdzXOxlmk5s/wP9+u99b/JqWeFjAyGIWjMdW1NTFnonXSEcrY30jinwZUI/21qiMCJJ0Yl2QfwI9gU8HneCRhvxPR0A/e4zQDmmJIijl9Zcpqlzrj8uoNimG+nFuau9CdsduU0PyUBKwhajRHGbRpxHYW/fX4B7SfUjvfZ30zoJl44lsZ1To8wQHn+Z4osVzeenpa3AUsmwBz/13Fz1GP7SF57aZjNY2/5m6MpX91RtTEJwRRRezk/QWmi1EA0j4XqhMNTZzj1/zpIT5GlOufUdpHi8x4kBS+rcUSCkjCyw0V+43mWy3qZrAHccdrVOA+8pAB1Ofoi5mV2y3NxDjF3MFpUqa2QJDDsCWO7abq1IUqLewBOJlF/FFQv/Sxdkl98YQYzgkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(56012099006)(3023799007)(5023799004)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TaAvy+CULFjy9LI2ps6M1A4S5IPpvLFTr5R9QtQN0frSkhZGaO8nE3XX2XpU?=
 =?us-ascii?Q?476C7f3akumXef0T9Slj66NPJgQ+GPqUjd5j9cfl/ZWR9+XzQqFknzOgr0RX?=
 =?us-ascii?Q?X1PdAjPngmFGWdhpvqe8wVlwEZZ5lb6n+ghe9KX9ILE3pwNu2MEVG1qrV6Ue?=
 =?us-ascii?Q?K2X7WdejAsxt4IcoA/vb1FeEx0WtRlsmGL7I0QyX2WDtwlMooB1mrdf7v9yf?=
 =?us-ascii?Q?rHD9/U/Ao6WvnOE2f6Eh82kmUj0YKSo01/lJfE/1GWpWbcm/Bb+/Roagn3C9?=
 =?us-ascii?Q?z8o8nq5ZUzzV/i1YJi8IuCKJ7a2eIZ7H1wdOk5ssU+RfsFdz8R0N/C1J9HQp?=
 =?us-ascii?Q?6pBY0I4fpyDmCKKPntbx66lOwfmFjeyPPJ58aq8xy9FnyOFZXAprn5TYYPaL?=
 =?us-ascii?Q?5hXUUL4v//JIk8x2H3G2JcoWbrxCGaBMw/z+S4pp7+IWXde4FTP9VJvG12f3?=
 =?us-ascii?Q?pxYlxbLVkfUYXLMmirRbtQd0GfoIuZx0t3BV9X/fSdWl8fTzN8Rn7McvFbBl?=
 =?us-ascii?Q?75902CQe/RC+WloA0wvwpwh7jKzjOk2rIvbEhpD8cZUDDaG3jcct/5r7IQ4P?=
 =?us-ascii?Q?2SkVdNeNtWFqGe5jjpKhrwj8gztTa0keTr8r7+KpjOJqXJGP8NavVoBH3II2?=
 =?us-ascii?Q?YuAL0U/uzrv13UC1pzmGLf3RBVC4Zc7HpWVzySTPVfnHH2pO7lUUXyl6WdRB?=
 =?us-ascii?Q?HVFjaD785oBA8XSNRicdfOScu1Nf807dVW5Ei8b9ip8rtnmEAUchcRYaQtfL?=
 =?us-ascii?Q?5lPTlMLYcYVmR//hMYjQo0tN4VRDjlewhXRy8uc3+tJj0A0iaw+3w6E3jq7F?=
 =?us-ascii?Q?+hxhjyC1/sWwZrYMdUa37utqmkFrWOXlZfEa79Py4AeEeknkn/2YJo24XXzG?=
 =?us-ascii?Q?C/zR9jjGBlq1cwOFJuZ98RFKrVjz1xcQ3bpt+0U7UecCpYwh5Y94iCrFMrG/?=
 =?us-ascii?Q?DWvLX34uMn4OUjJeclbRsLNr5qIL43k20rO5trz5cqLmSl9m71exSmE+1EHJ?=
 =?us-ascii?Q?nzZQPPAxwZmz8caD1BKQIqDMSumbodMpwjZ2GQym2iY1pYThIqoODQVV7reV?=
 =?us-ascii?Q?OmjeXu8LUpIbqBCXKAvbsZzoLmx0NS60btjbhMhG7DdV6lf09EpiSHefk7s2?=
 =?us-ascii?Q?17Em2JnaLpmzy4YUNPeWIdSVp2rk/AZunZpa1ngyZNFARGXAGJiX6AADQBeR?=
 =?us-ascii?Q?+Ezb+VMqaAYzRBGcJ/AgNQ81YCUzq/Fr2wk/06lAzTlFOjWUtYQHGtPxKrxW?=
 =?us-ascii?Q?R8Wj3nu2H42kla+X3j5yGIIkOnSOXdt7P06xsWIUze22vV9YPJ5GecP/Jdgy?=
 =?us-ascii?Q?7dbJ70ZghzUevzfifDWE6Vw8mvd/zsxy6c/3K7NjRU8FYzzKLZGBwcMeUsYz?=
 =?us-ascii?Q?y3Em7q/6LWB/dDoo0yevONGnZz5taprtcX2pfSh+MC2II/k1fMdpfKklANpO?=
 =?us-ascii?Q?lDFwLWyskEJVxpsbshoO3Nf2WLtPXvRboucB9AjKfB4PY5NIkULOxzCJlPbF?=
 =?us-ascii?Q?o9X5DcycdBV6xvel5Ug6wvfjBqpJA8Dp46u7nvV/biKwoosMeRvzguTFvqxW?=
 =?us-ascii?Q?GbiDGGcQ/oBLY0rzPBlAST6kj/swaraWmB7ct9l5vqDY9UGlrUG1Fqju+UCW?=
 =?us-ascii?Q?HvpjufOgl+ga1jZZwE9A/RriwLubVd2udsmaTgP4Q4lGx1IruwQCAe7ZGcuM?=
 =?us-ascii?Q?Y5ZIaB1d07W0O2abDqHOgQeBI12dgkkqAyDogv1gOnW5MUpcD4hvq9TJxw/+?=
 =?us-ascii?Q?1qaRXGAiUVEySYXNw01vWjzbsHOB9LA=3D?=
X-Exchange-RoutingPolicyChecked: koBguiF2UG/D3FPJcwYpR8V3tjHcemwhxsyk5x+GNh8lbCJEoBQDleLcO+nN3xXZg/4bBrSCO/F/NhSc+4MNaqZwSQuGTBF4iBs45ay3B86CNGb3VH04xZ6bwlG/VAjAtASiDd7iB8y/zmq3ZAwg8HaSUDCyZ+vLn6U5JtX7IHdhlOVOkmPuhXizurJRuY/2mXJ1yaBR63CUQKLLFcAZJAeC75V5W4LCe9rVRh4AxNt7JF1XJxUCUaMhUAoNlGnLpWCO+JGSJM0B60cyYUWDAUArTGjiE9ZM2go0enhAZCerYw7mDsT23w10W8vVdIhm/UKLGp+SNlHztj+zuypbyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: babd5b6a-45db-42ce-0204-08df0228589b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 21:40:42.1252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1lseLzsGpSu8tf5VbGyeHnvHz18yZFGCsCc+S2taXBDravhzh9mW1tTuqvUJbXh8bZTyV1iOIfS+QlHjXypC+NqavAuI38QT9/1Lv699fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6035
X-OriginatorOrg: intel.com

On Mon, Aug 24, 2026 at 07:19:57PM +0530, Shaikh Kamaluddin wrote:
> cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
> (ELC) region for any MCE with a usable address in the region. This
> includes corrected errors, needlessly reducing usable memory.
> 
> Skip ELC alias retirement when mce_is_correctable() identifies the
> reported error as corrected. Uncorrected errors with a usable address
> in the ELC region continue to retire the aliased page as before.
> 
> mce_usable_address() already implements the per-vendor checks that
> determine whether the reported address is usable, so no separate
> memory-error classification is needed.
> 
> On AMD, a corrected legacy bank 4 DRAM ECC error (XEC 8) reports a
> usable address and retired the aliased page before this change.
> Tested under QEMU with Intel Skylake-Server and AMD EPYC-Milan models.
> 
> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

To be complete, I'm not retesting since v2, so not offering my
testing tag here. I have confidence in your thorough testing!

-- Alison



> ---
> Changelog:
> 
> v2 -> v3:
>  - Drop the mce_is_memory_error() gate added in v2. On AMD it rejects
>    every non-UMC bank type, so poison-consumption records reported from
>    Load/Store or Data Fabric banks never reached mce_usable_address(),
>    which would have accepted them via MCA_STATUS[Poison]. (Sashiko)
>  - mce_usable_address() already implements the complete per-vendor
>    address-usability logic, so no separate memory-error classification
>    is needed.
>  - Add AMD test coverage (QEMU/TCG, EPYC-Milan) alongside the existing
>    Intel results.
> 
> Link to v2: https://lore.kernel.org/linux-cxl/20260812151759.14390-1-shaikhkamal2012@gmail.com/
> 
> v1 -> v2:
>   - Reworked commit message per review feedback
>   - Dropped redundant comment from the code
> 
> Link to v1: https://lore.kernel.org/linux-cxl/20260810183013.47085-1-shaikhkamal2012@gmail.com/ 
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
>     different mce_usable_address() path, covered in the section below):
> 
> vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> 
> 2. modprobe mce-inject
> $ cxl list -M
> $ cxl list -D
> $ cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> $ dmesg | grep "DEBUG: forced cache_size"
> $ modprobe device_dax
> $ modprobe kmem
> $ ls /sys/bus/dax/devices/
> $ daxctl reconfigure-device dax0.0 --mode=system-ram
> $ lsmem
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
>    # modprobe mce-inject
> 
>     MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
>       bit 63  VAL     - record valid
>       bit 61  UC      - uncorrected (0 = corrected error under test)
>       bit 60  EN      - error reporting enabled
>       bit 59  MISCV   - MCi_MISC valid
>       bit 58  ADDRV   - MCi_ADDR valid
>       bits[15:0] MCACOD - retained from the v2 test setup so the Intel
>                           and AMD runs differ only in CPU model; not
>                           consulted by this path.
> 
>     python3 -c "
>     VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
>     MCACOD_MEM = 1<<7                
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
> 4.  # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9C00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190010000 contains=1
> cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> ---------------------------------------
> 
> CE without this patch:
>   cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>   Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>   HardwareCorrupted: 4 kB
> ------------------------------------- 
> 
> CE with this patch:
>   (no "Offlining aliased SPA" message logged)
>   HardwareCorrupted: 0 kB
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9C00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
> clocksource: Watchdog remote CPU 11 read timed out
> 
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> --------------------------------------
> 
> For UC, same steps only status bit information will change :
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0xbc00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> # dmesg | grep cxl_mce_debug
> #  grep HardwareCorrupted /proc/meminfo
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190010000 contains=1
> cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1
> 
> Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
>     cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>     Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>     HardwareCorrupted: 4 kB
> -----------------------------------------------------------------------
> 
> AMD Platform Testing:
> ---------------------
> 
> Note the vendor difference: on Intel, MISCV with MCi_MISC[8:6]=2 makes
> any ADDRV record usable, so a plain CE is address-usable. On AMD an
> address is usable only via poison, legacy bank-4 DRAM ECC, or PADDRV --
> hence the differing usable= values for the same status word below.
> 
> 
> vendor_id	: AuthenticAMD
> model name	: AMD EPYC-Milan Processor
> 
> -------------------------------------
> Mainline Kernel Without this patch:
> -------------------------------------
> 
> vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu EPYC-Milan -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> 
> # cxl list -M
> # cxl list -D
> # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> # dmesg | grep "DEBUG: forced cache_size"
> # modprobe device_dax
> # modprobe kmem
> # daxctl reconfigure-device dax0.0 --mode=system-ram
> 
> # lsmem
> RANGE                                  SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> 
> Memory block size:       128M
> Total online memory:     4.5G
> Total offline memory:      0B
> Load Injector
> # modprobe mce-inject
> --------------------------------------------------------------------------------
> 
> case1:
> 
> label              status           addr         bank   note
> 
> [LEGACY_B4_CE]  0x9c00000000080000  0x190070000   4     "case 3: bank4 XEC8 corrected+usable "[Before Patch]
> ---------------------------------------------------------------------------------------------------------------------
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9c00000000080000 > status
> # echo 0x80 > misc
> # echo 0x190070000 > addr
> # echo 4 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190070000 contains=1
> cxl_mce_debug: spa_alias=0x1a0070000 pfn=0x1a0070 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0070000
> Memory failure: 0x1a0070: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> mce: [Hardware Error]: TSC cbdf882d20 ADDR 190070000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479138 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> --------------------------------------------------------------------------------------------
> 
> case2:
> label        status              addr         bank   note
> 
> [POISON]  0x9c00080000000080    0x190040000    9     "case 2: poison only (UC=0) - divergence to note"[Before Patch]
> -----------------------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00080000000080 > status
> # echo 0x80 > misc
> # echo 0x190040000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190040000 contains=1
> cxl_mce_debug: spa_alias=0x1a0040000 pfn=0x1a0040 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0040000
> Memory failure: 0x1a0040: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> mce: [Hardware Error]: TSC 17153949200 ADDR 190040000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479277 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     8 kB (cumulative added previous 4kb + 4kb this test)
> -----------------------------------------------
> 
> AMD Platform Testing with applied patch:
> ------------------------------------------
> 
> # cxl list -D
> # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> # dmesg | grep "DEBUG: forced cache_size"
> # modprobe device_dax
> # modprobe kmem
> # daxctl reconfigure-device dax0.0 --mode=system-ram
> # lsmem
> # modprobe mce-inject
> ----------------------------------------------------
> 
> case1:
> label              status           addr         bank   note
> 
> [ CE]          0x9c00000000000080    0x190010000   9     "case 1: corrected, no usable addr"
> ----------------------------------------------------------------------------------------
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9c00000000000080 > status
> # echo 0x80 > misc
> # echo 0x190010000 > addr
> # echo 9 > bank
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> mce: [Hardware Error]: TSC 8e59f2f3bc0 ADDR 190010000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454918 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------------------------------------------------------
> 
> case2:
> label              status           addr         bank   note
> [ UC ]        0xbc00000000000080    0x190020000   9      "case 1: uncorrected, no poison -> unusable"
> -------------------------------------------------------------------------------------------------
> 
> cd /sys/kernel/debug/mce-inject
> echo sw > flags
> echo 0xbc00000000000080 > status
> echo 0x80 > misc
> echo 0x190020000 > addr
> echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> mce: [Hardware Error]: TSC 134d6de13240 ADDR 190020000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787460569 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------------------------------------------------
> 
> case3:
> label              status           addr         bank   note
> 
> [ POISON ]   0x9c00080000000080    0x190040000   9      "case 2: poison only (UC=0) - divergence to note"
> ------------------------------------------------------------------------------------------------------------
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0x9c00080000000080 > status
> # echo 0x80 > misc
> # echo 0x190040000 > addr
> # echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> mce: [Hardware Error]: TSC 14e29da617c0 ADDR 190040000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787463321 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> ------------------------------------------
> 
> case4:
> label              status           addr         bank   note
> 
> [ DEFERRED ]  0x9c00100000000080    0x190020000   9     "case 1: deferred, no poison -> unusable"
> ------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00100000000080 > status
> # echo 0x80 > misc
> #echo 0x190020000 > addr
> #echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00100000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00100000000080
> mce: [Hardware Error]: TSC 9a2d801ff40 ADDR 190020000 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787456818 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -----------------------------------------------
> 
> case5:
> label              status            addr         bank    note
> 
> [ DEF_POISON ]  0x9c00180000000080    0x190060000   9      "case 2: deferred+poison - MUST be handled"
> --------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00180000000080 > status
> # echo 0x80 > misc
> # echo 0x190060000 > addr
> # echo 9 > bank
> Result:
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00180000000080 addr=0x190060000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190060000 contains=1
> cxl_mce_debug: spa_alias=0x1a0060000 pfn=0x1a0060 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0060000
> Memory failure: 0x1a0060: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00180000000080
> mce: [Hardware Error]: TSC a60fd45ae60 ADDR 190060000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457072 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> -----------------------------------
> 
> case6:
> label              status           addr         bank   note
> 
> [UC_POISON]  0xbc00080000000080    0x190050000   9       "case 2: poison consumption - MUST be handled"
> --------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0xbc00080000000080 > status
> # echo 0x80 > misc
> # echo 0x190050000 > addr
> # echo 9 > bank
> 
> Resul:
> 
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0xbc00080000000080 addr=0x190050000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> cxl_mce_debug: spa=0x190050000 contains=1
> cxl_mce_debug: spa_alias=0x1a0050000 pfn=0x1a0050 pfn_valid=1
> cxl_region region0: Offlining aliased SPA address0: 0x1a0050000
> Memory failure: 0x1a0050: recovery action for free buddy page: Recovered
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00080000000080
> mce: [Hardware Error]: TSC f03abeed540 ADDR 190050000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457328 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> -------------------------------------------------------------------------------------
> 
> case7:
> label              status                   addr         bank    note
> 
> [B4_NONMEM_POISON]   0x9c00080000000080    0x190080000   4       "case 3 override: bank4 non-mem, poison ignored"
> -------------------------------------------------------------------------------------------------------------------
> 
> # echo sw > flags
> # echo 0x9c00080000000080  > status
> # echo 0x80 > misc
> # echo 0x190080000 > addr
> # echo 4 > bank
> 
> Result:
> 
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190080000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00080000000080
> mce: [Hardware Error]: TSC 21c66cecf80 ADDR 190080000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454082 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> --------------------------------------------------------------------------------------------
> 
> case8:
> label              status               addr         bank     note
> 
> [LEGACY_B4_CE]   0x9c00000000080000    0x190070000   4        "case 3: bank4 XEC8 corrected+usable - THE FIX"
> -------------------------------------------------------------------------------------------------------------------
> 
> echo sw > flags
> echo 0x9c00000000080000 > status
> echo 0x80 > misc
> echo 0x190070000 > addr
> echo 4 > bank
> 
> result:
> -------
> 
> mce: [Hardware Error]: Machine check events logged
> cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> mce: [Hardware Error]: TSC 3610305ed80 ADDR 190070000 MISC 80 
> mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454482 SOCKET 0 APIC 0 microcode 1000065
> # grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------------------------
> 
> Note: an AMD record with MCI_STATUS_POISON set but UC and Deferred
> clear is filtered by this patch where it previously was not. Per AMD64
> APM 24593 Rev 3.45, when UC is clear the error class is determined
> solely by the Deferred bit, and Poison qualifies an uncorrected error
> rather than establishing one. Real poison is therefore always reported
> with Deferred set (not yet consumed) or UC set (consumed via #MC), and
> both of those cases still retire the alias. Poison with UC and Deferred
> both clear is not a valid encoding and appears only under software
> injection.
> 
>  drivers/cxl/core/mce.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index 65fed913b221..3ac6802e750d 100644
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
> +	if (mce_is_correctable(mce))
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
