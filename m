Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0439E6FC;
	Wed, 12 Aug 2026 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574549; cv=fail; b=jmkT5hDracnDoLMD37m5+tgGh7XN5MucwCksl2ISQd3LFwHnE2RG0tN57NyqblzTo11MmMsgb7InfRWDRdbz1u4WieK+l9CSn3Xi24gl9aoxFZQ4uirMeQsDqsc/XrEe/qGmsIEYEssjxUqim2XDcvldPdE3OfkNTsavioZEhd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574549; c=relaxed/simple;
	bh=9bz+oFwEk8pOsavtHMKPZytcN1ZN2HLo95ZItHWB5rg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PefkxChaWh+7efBLu8IQKiaGA/nwNbM3FtBarkROlycQcnrPSR7evN5RBaxDkdVbnNzRS9pefRLmZhM5VujeOHRiN4kz12TD5xGZ1X6hX9c7RKJQ36CP+n/myT5Eq4pXkFPFJRkB373hj88rWSgcBV3tUGZVoR964/szccmDUGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbZkoo0t; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbZkoo0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786574548; x=1818110548;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9bz+oFwEk8pOsavtHMKPZytcN1ZN2HLo95ZItHWB5rg=;
  b=lbZkoo0tiOQ4NcnQwmB0SOIksH/qxgOJMJnlVzXjpTH4uUWFkeMgM6Eb
   33r5xBJwMG9jv8q1L9wOPR77j7MSGKPeWXU2lUX7OupwHXwVuG2OTqt6P
   h2tgrITEeFkcau3dlsBzMmhq1zcvPzqIOOrNPbfGkeaqgWk6kL0otLm/f
   3kVgSxiJVO5hXUXOdnX5IJi/7J0BL0aVWLsAV9gRjQh6WYNYR88SU1b/O
   /yMcrJUInRm6VrOSxX2JJ+vsoOojlpVOuxZfSEwxfDyyTPz7uASkbqSAb
   UUCPfVgeCxLnz2qGoUlBWjZtyfapUNgP7zqmRRfuwWMiuLwDcj0K4S71P
   w==;
X-CSE-ConnectionGUID: OuhIV6zDQJ6fimWN4EegZQ==
X-CSE-MsgGUID: JjHW0hJVTwi7jQlAbqIEZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87023417"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87023417"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:42:27 -0700
X-CSE-ConnectionGUID: irdvybw5RDyslEMBiU2w1A==
X-CSE-MsgGUID: u5YXTmtHSe6F17l9Ihe10w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="259938509"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:42:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:42:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 15:42:25 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:42:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuXSoqx+YL2ycGTVfOBw5CtEFBP5cV+iY5nnmrfbBIcUhOepoV/xRobsgdzg8Kp/pz21mizVAN5rtkZ4rG5MRgftAYVFGPlkFJa/CFRR9lL8h2CUqseA5ZrTDjT9iYSQ9JRAmCyMuTwSDG3EZeHI3G4/cia8gxz/TiisPOyCQordBm3GpOTbMmoi4D1M/VZNZdqk8fw7UCxaaqo/SoNmLgPqrcIyLjvinAjvG+oYFUW1mm22nhtT025iYv5eSIW4z3taF/AxtBK0I8VU3QcLludqyxxgOSiTxluUCxMh/T7LpSfYW8BkzYzL7Q8F1OBGzyphYiee+vX/doHwghr6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pod27bcNEXmOKZ7aB40h0r5q8WmeXwkI2OgoCyPjutQ=;
 b=UrXHh4iye1aGWeMj64hlFrMuQOS3m62JIKtT0r+2lBFaApVOSsAeH8wOlLZgZSoJGN032cRSuQILLgY7+Kip8H1IXkTPJ6idGVtqSShkywLvAQ9g3OzEAq9Q0y6BU4PRyYdZsxYJOZueBPFKAEFwvL9DWi2t00ZAjzq6BlRuWDUwi80lXtzbjbBQQP/QCugDfvOjw9bbCNMvkwkuWpODwySDob3G6+fJKlepmDD8kx4USfBk+9bgQ1nOMUu07W/2x7GxP0sKH+R2fSj1wtKnoplG9Q2bLVqPLE9x+2w9Pc7AN6yr8fFDYI537YjvpNvmuuaGf1nMPvTYJCOhmKzi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 22:42:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 22:42:22 +0000
Date: Wed, 12 Aug 2026 15:42:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, shaikh kamaluddin
	<shaikhkamal2012@gmail.com>
CC: shaikh kamaluddin <shaikhkamal2012@gmail.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-cxl@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
Message-ID: <anz2yiHLrDFhkxuv@aschofie-mobl2.lan>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
 <anyYev89TB1jHAXe@acer-nitro-anv15-41>
 <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f8c0b4-a97a-4db2-ea93-08def8c2f914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|11063799006|10067099003|56012099006|4143699003|5023799004|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: T0AU14ECAQcwlCEOlkshXeJ7EcNGUlABBgEdbDLbmP/0CFCJFKFZx29UF7ef66dXtedMEzGo7flJAPM1nwbuk9fmqDXJYn8Sn5WjncjMUtZq/luLigCnlXxUNeLQvh6Fbnog+6mmQRuBoOXTV8ZtmW10S+RnduynrgCcpa9Z4H2EiRbHrukGFJqJ110D8pM/joNC8l6BuV6+NoYo+GY/QgtKAECpcfUztaIBzyPGr6DzWFKPDk3NorO7+9Z2yMY/3BgiheC1x6jCguBPQQGC6+2ohq407KK15FMWIAPA6XU/QN58H2ZRz7mo8Q5qonwPjspn51nAtEsIfc2FsRpF6T/XzTj8uwGDr8FUVELkNoVHzh7xN0ZOG8vJOJy9sz3sXZjwkkpqwUxf7D/j27qiCHcH0CRLK88pCsASlwF+rsMAOOTnCBAzqFG5F4jYOluojlYwubErZCt597JshdA+8D2vxaTOwg41F9Xz8ycys4bxg8G92rjYy4U9FGSsOPZKbg2uiGQmgR4qCXcaExcL/mtWP0HWsi34l5iBWqfxozKoV4Kw6r0ghVpcc5NvIEN81waFmpjD2oVN5E/lbqIB60U/n4dL6J2Cxb8S8IHgXGbNw9x6zfMCC29+sDFLljc4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(4143699003)(5023799004)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRpjWgy/uB0ACt/a8AFkpsKNDTUSHlgEwlZJb7+1RqVaUnmugSqXGIt9Oese?=
 =?us-ascii?Q?hO0q1tTYV2p85DB5cqaP5PNqFEeAfyuYLrpjUSql6CwsYJYy1pnDICtgMJQY?=
 =?us-ascii?Q?EoieBEEptb6t3I8wq7clYlAimbMs1eeBJZaK1U+g6TWmGp2LdqMgV5EMWCbJ?=
 =?us-ascii?Q?1Sz8Aq91C/dFMz0h2jRzgt+Yy0Ec27DVLksltd+xB5YyGbHmSMWyVMwq0yAD?=
 =?us-ascii?Q?Q/myTQU9FZZyGCmSHSejtCvsguRFgRBICDYVFzz0ofAoIEb8EX2X+n2VQ+p5?=
 =?us-ascii?Q?qkzOAY+VhUKbgqzYAojTD30NAvpFN1m7TmjxGG4FA5ycOVvklE5B5ZhZVKb2?=
 =?us-ascii?Q?tzmAs/SjxT2MKYVLSMIpFnbTXF8Y2vIBa31PnKtjNMFIWSYoraMwnOaF16AS?=
 =?us-ascii?Q?VqrrAGgn+cq+W9OMi4Z38hjxZyzsFSyntXKgJHm/7gh38hsTLEHS6BjpGwuq?=
 =?us-ascii?Q?MYFDBSRD7gCLnLQlFmHmHqTGuZLX2Iue2jlE8dPaXkxwk5fyTmie0PulmZfk?=
 =?us-ascii?Q?MFW8BL7iNjKuUye2IPii3wsvrWrkmfn45uFdnFQw2W6pYxvOJrQ/qha7AP9w?=
 =?us-ascii?Q?JG7zNMyaGAQmsnWviQMjfUvhnakDvjvvT3jALA/t5u3ps3cZFNUJEcFga4K0?=
 =?us-ascii?Q?4cvjXUbqLZ4/oayxcdDUy9U5to66iGkHjwODrGhO2I3APAZ1D0Bw66EP9Av2?=
 =?us-ascii?Q?l3lNJIOp7Ey18ErETyZSWdvjQ1oCxpSUWWsX7gSVOLeUYFXTzPFc45gg6lhw?=
 =?us-ascii?Q?zhX8bCTlFFKzfveMrPI4G5qQUtg7FL9kEaHlW1QfYvGJsNIeXouZ9PzqYO/V?=
 =?us-ascii?Q?NS6HM2suqVXP1ZpSlWhJ4dXJSla/GFfVJlxiFIZnVh0gFEXoPt6pw5n6IwN8?=
 =?us-ascii?Q?bw+4Eng8w4+AtD/1zVdoK209r5NDumZ6v0PmejofSRtduQA2bwreVpUhb+zo?=
 =?us-ascii?Q?PeL+9vXQHh58AZov3/v37WfhTnp3pjIHx3eHtWiQbkzkGhMqKLba8uOQbDxD?=
 =?us-ascii?Q?SobEfSfbzRstG2wrYHtKe49uW/Hgb4W0uyGgYWzQZ5z6Uq40RFgobJWHTX78?=
 =?us-ascii?Q?EMWL32lb06N6AgJRS8rGFfR/CuRfD6MjhsI8HwCydDLiVXc9O0FLFO2uHifL?=
 =?us-ascii?Q?ZnnzAp0YdXXoYPYqUks2SdGJz+0d9vIpPNmwsZP+1kcWzzSOf1cM24tuliKv?=
 =?us-ascii?Q?8nPUVprDLaQF8YhoA0tVv4ABmmW51i3a3jDnW4NJbZWytHZTtYgcrZnENu0y?=
 =?us-ascii?Q?eOthtgnp4XTPOh74+uf1+zkWQil916xd+TcHRyKQ5q1Fl9JSP+sf5LglYvX8?=
 =?us-ascii?Q?1YRRTI3kEXrv/aQmpzXwsCMwQS9dr6xJR34D/bq+UAF3DhuXx81p+X4coXhL?=
 =?us-ascii?Q?+Q9Oe+ryZlzWKPGS9pSG3FTgYc/a5bM4dqq4aIHTON+l2xYbINu6ceguiKXq?=
 =?us-ascii?Q?sRCYc9j8sYinfsaMjU8eMxeuBcLE7KWijRdJ69mFi7Xrwp7/k/C02Tcyphfk?=
 =?us-ascii?Q?feutQpuBm/JjeT8yc0pD7fXbMP4U8hMwuXsjb/X2crWFwcBxs+h3Ie3NWlns?=
 =?us-ascii?Q?xwI6ySbFubPMOcXsh2zYXUi5SpIS/wKl3kG/VA1oTAwwFNiGyF9zJIpDrcUb?=
 =?us-ascii?Q?PIexh6MixOILsOUNwwlv5rKyk6Yi0YQgbP5M3Gv/Vmwa1EIbCIgylPEbfSdF?=
 =?us-ascii?Q?ZyVzB29Qf+9WwGwxe7j616jkgvGBJ4qftx2irESVV2kDmPoFBWSkjXVzmSkR?=
 =?us-ascii?Q?h9ehcLN4K36pq0j+Zf15n37Bq64PsTE=3D?=
X-Exchange-RoutingPolicyChecked: NtWpum1mIJNDNw9jtxDH5J1kEeRM67/unYYkJqvvQKmR2aTNlS4PPGBPiyj/dYG7E525vaqmSzu8bud5gQbtUkBgxGZZQ2Ay/W1QjpKTL5DM2YFCH7FxvL7/U3dJMTmSgn4IptMYuJI4PPM+5Et/aoqm9kQ/JNme0RoODGjgudAk1ZQXThNd3iTx8OIF0IqRzTDd9QdE32L72jDpwN69F0r/AYfO9EBTA8Wc13905Rzea4BmxCUwmkrCuV94rNe5ETkfeWhepSqrcodFmb9EMajlX2K5aGXthccW2i4EYZcTShZDdP8Vx1mw839i9bvDv1U41HE/aZI5xpgDURQgUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f8c0b4-a97a-4db2-ea93-08def8c2f914
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:42:22.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYE+tET0Ic5N52Pyks2YOb6u0+IMS+29arbP2+ZkN7HnpvZRnRmzhfv2du0pOvZLAQv3LDHfnvTEp2HkAUQ6JLsTLdyNOQb7tqDACr/iq3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 11:19:40AM -0500, Cheatham, Benjamin wrote:
> On 8/12/2026 10:59 AM, shaikh kamaluddin wrote:
> > [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Mon, Aug 10, 2026 at 02:00:18PM -0500, Cheatham, Benjamin wrote:
> >> On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
> >>> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> cxl_handle_mce() offlines the aliased page of an ELC region on any
> >>> record with a usable address; it does not check MCI_STATUS_UC or
> >>> filter non-memory errors. uc_decode_notifier(), the equivalent
> >>> handler for plain memory on the same chain at the same priority,
> >>> filters on mce->severity and leaves corrected errors untouched.
> >>> cxl_handle_mce() has no such gate, so a corrected error - which
> >>> the generic handler ignores - still causes the alias to be
> >>> permanently retired via memory_failure().
> >>>
> >>> Corrected errors do reach the chain: machine_check_poll() logs
> >>> them via the same mce_gen_pool_process() path that feeds
> >>> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> >>> extends p->res to cover the DRAM half of the ELC pair, so a
> >>> routine DRAM CE carries an address inside the region resource.
> >>>
> >>> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> >>> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> >>> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> >>> machine checks") established this filter for an equivalent handler
> >>> on the same notifier chain; the consequence here is more severe, as
> >>> the CXL handler calls memory_failure() rather than recording a bad
> >>> block.
> >>>
> >>> mce_is_correctable() is used instead of copying
> >>> uc_decode_notifier()'s AO/DEFERRED test because the alias must
> >>> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> >>> the reported page but nothing owns the alias.
> >>>
> >>> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> >>>
> >>> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> >>> ---
> >>
> >> This looks good to me, so:
> >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> >>
> > Thanks for review!
> >> If you have the time, could you also share a script that does the below testing on the list? It may
> >> be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
> >> the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
> >> for people to run would help with any future breakage.
> > Happy to share it. One question on where it'd fit best: ndctl
> > (github.com/pmem/ndctl.git) as you mentioned, or drivers/cxl's own
> > tools/testing/cxl/ in-tree? I'm open to either, or proposing it in
> > both if that's useful - happy to follow your lead on which is the
> > better home for it.
> > 
> 
> If looks like there's already some mock functions for extended linear cache in tools/testing/cxl, so
> I'd recommending trying to put it there to begin with. It may require updates to ndctl after the fact
> to run the test(s) as well. If that looks too involved then sending the script out to the list standalone
> should be fine. I don't know if anyone will pick it up, but it'll be searchable on lore if anyone wants
> to test this.


This sounded interesting! I gave it a try with cxl_test and mce-inject,
and it looks like this can be tested without the QEMU CXL topology or the
forced cache_size hack.

I built with CONFIG_X86_MCE_INJECT=m and loaded cxl_test with its
existing ELC support:

# modprobe cxl_test extended_linear_cache=1
# cxl list -R
[
  {
    "region":"region0",
    "resource":70300293136384,
    "size":1073741824,
    "extended_linear_cache_size":536870912,
    "type":"ram",
    "interleave_ways":2,
    "interleave_granularity":4096,
    "decode_state":"commit",
    "locked":false
  }
]

Using 0x3ff010010000 as the injected SPA, I first injected the
corrected error from your example. On the patched kernel there was no
CXL offlining message, as expected.

I then changed only the status to the uncorrectable case:

# cd /sys/kernel/debug/mce-inject
# echo sw > flags
# echo 0xbc00000000000080 > status
# echo 0x80 > misc
# echo 0x3ff010010000 > addr
# echo 9 > bank

and got:

cxl_region region0: Offlining aliased SPA address0: 0x3ff030010000
Memory failure: 0x3ff030010: memory outside kernel control
mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
mce: [Hardware Error]: TSC 23c5a5a9188 ADDR 3ff010010000 MISC 80
mce: [Hardware Error]: PROCESSOR 0:50657 TIME 1786573477 SOCKET 0 APIC 0 microcode 5003302

So the cxl_test ELC plus mce-inject looks sufficient to exercise the
path: the CE is ignored with the patch, while the UC reaches the alias
offlining path and computes the expected alias.

The "memory outside kernel control" is because I did not put the
aliased memory into system RAM for this quick test.

This would be a test case addition for the the cxl-elc.sh unit test.
It seems like a tiny, close-the-barn-door-after-the-horse-got-out,
kind of test case, but maybe not?  Maybe it opens the door to more
things can do we mce-inject elsewhere?

I'll leave that to Shaikh if they want to add the new test case.

-- Alison


> 
> Thanks,
> Ben
