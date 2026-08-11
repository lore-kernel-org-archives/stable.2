Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0D3803E9;
	Tue, 11 Aug 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476150; cv=fail; b=fEhkRFgaNxgDyYYqQQhftddR/ETekac0KhqstMm9aaM9YMKpvWkQ2QYvS9taxF6X3imrskDYIm+q1vmQUQGzxUMsz1F8lqiAHxqGy4N0NcqwsK9HpYSXV9E2malE4QEW9pRCqTEK3ZlDPoNY5lLEIKE8lyz+BPMSa1yCVHiz5YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476150; c=relaxed/simple;
	bh=4d8DguQxhGEJeTUrIYDuqeKYUHt5TEzYmyYsy4IKhQY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMlNr9ByTF0en4Oo1EvDaU5pBIwS8kf7TXsHGkAy6+PeJwkJiTB+Zsv4AKP7fYHXnx+p44o9/smDzz2jH62H6dNp7E0TC5QOGBqzNaYOU6jf/vHVlFqCA/zDX50GRsME7Psm/iis3TfH8FpIkPow9zcADidvK0NULbUy7/4PzZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+D/Oppr; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+D/Oppr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786476148; x=1818012148;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4d8DguQxhGEJeTUrIYDuqeKYUHt5TEzYmyYsy4IKhQY=;
  b=J+D/OpprTbApfa5wgaEjsBV8VwAYuOAFnj2E47DMO2KEY9MK15hfpEM9
   rCqr/AMMwBCthUwuLpxmTqBml0d7vZFsjZfWDQVC0lzutGc7N4SIgoOY7
   942hQP5LCWRsS3nDDjgHITGk/t75/cRAGY8KgswQUg1dn1jtVYyi+1Ide
   tHv7i8eW0P0oqhRNXqJUWWjfs+WbrNEp2TFCY2LRDMCXayHhbUq8AQfx6
   NAUi2kO61VRW5en/qNIX7BzsmsV1Vomg0g0EPBmnBa5ZJX942GNK6CGKN
   46ZwLNr4nMCp1tSbiaM02hhMgA6A4ZiYbsHR73YbrE0/3CILMOHt0GjhW
   A==;
X-CSE-ConnectionGUID: KJayJ+aHQjuo4L15P6L/CQ==
X-CSE-MsgGUID: FpGiy3hBTQuGLRyQ35ZRag==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97614243"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97614243"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 12:22:26 -0700
X-CSE-ConnectionGUID: vDcrvG3DTgeoi6f9OYAsbQ==
X-CSE-MsgGUID: zqcatcRaQ8+9ZG4AgUmurw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="257206348"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 12:22:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 12:22:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 12:22:25 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 12:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRRDtJSmowUPWCkmjkuJKz/fsgTxHQJcHPikrbIMci7D83dgHByzDFbe6DZOKt1NSyPojQgGlS13PxxWURIa12VzEaddqdoFy3qpI20G2OFrjMZbaqgy3TvSXe6uPMKy/jO5IHD0AMMywj1ZVqJ3Y+vQBPxqT0POqVG6s/MXjkSvGHl/iO0KPx2AaPfhbdBA1lzXWPL+Y+ww1I8BBr0OTz4PyQ/JTkJuU2vhpf24lH0feFhWvG7m9yGHmAtN6dNhkC7X6J1Lq3TJVYxcztmnuPGT854jAuijmEMuw+yoIMsi+gUgXSWK2zYABXreMPx1/XKk4ckyO/dn+SUID2uZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruxE1OAn/D7nRBHBjBdJvIwm0QUKqkpm85MmzIZltTw=;
 b=VNLC2Dkzhb1C9AwIF4YpzthEOACXn6lvF5TiVBnMKrJyzIWQBLIA7Rc/1I+HLjMRw/5q5SvcaOk7NiDR9a8bLMCQdOcxTB5OfUHVwKAfWUvgySpaXFIU6R5lmoIZOVYs2IQADSiFu+0ZMtXGLNaeY0G19AMULSQ9DsSdtfGqEN7o3/dgzCojXnhMrGTgkFzWRv5BJDm0gcuVHJBccmfhYzECLPj8FWSSYrTX2dQnnOgMyby73peMSAvMHGrgU5THhCThwrKg4bcThaefKwYi0AlDgF1hCGRlVhEu90L7L23O8ckk4Kf8xnTmqw5RCCgV+LuLKgTMustu/dnevR771g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4600.namprd11.prod.outlook.com (2603:10b6:208:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 19:22:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 19:22:22 +0000
Date: Tue, 11 Aug 2026 12:22:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <linux-cxl@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
Message-ID: <ant2Z1mzHCrzmzXn@aschofie-mobl2.lan>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:a03:338::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0738fd-74b7-4851-f92f-08def7ddde64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OaBDruzlGBGyDFRwmdbTpDHcYjLtIVWs4wZ9GvEtFdE9hJgr7m51oQA8KRCgWOoOsNNYNaUR4ZoqxoQZH1LvAajDRD9RyrM5LjhJb/Qzche9Q55Af81xT2g4VflBLtcPgXm3AkY8/BVRxDRq4F/GxBJSmxlXd55ZRSuCuI6qeIvsPnjPnB8aM9iB513Rh7LQDBJC2EtY+sHj4AxPVVvwkX9PqXkprWMY2fcEq8YTA1iUQfi0p47TNqywJ1W3CXeOMtLNmYST2QFE2Sp6f36nDxbH0jQGT0TNe95HR3cWZOGwE7MTFgF0cN1HYy6lCMwzqjUn0El/rwmgvyIVsvqkB7nxiIcZDuG1OhmTwNGKukQTwpvdpBzDvj/rUy5E4ohluhx3MmHW2BpCq7Ny/hT/+yMumdDb1ObgQfEqJwapEUCHb6c8kptcuKQcCxacKkSUSdmo6PTgdbhOc6uNn34RtDxCxiuyi+Ju6ff9FMhsz9aK8uqFoMyAajCKv5cVKqUx2wPe7Q1l2uAFF8l7+UDxejQAnoYPzwwfqvTx/55P2gQ35WNqNVotdb0Lvp5x8RhQWbIM/xdWInMPd8GRkybsnKm91b+OB6HpmYcyiHZLnuXICa9RMdROqxpjBW99VmeQoYOhg4sc+5QHZ0hwCBzUqg3jBPi9aVVBXeWFDQj9yTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7lIdhM2r1Ao7sZJc6BdUW3qNfQV5JD2Bp0rLUrpdidw39hMJi9QzJHpwRAB?=
 =?us-ascii?Q?EOSQe6p9W8qswbqQWFMPHBNntAfpOdj8TN5iC8pQISlkVGuBb1YjgEX+CXcD?=
 =?us-ascii?Q?UqKQ7EzACBFsT6RhNwrUQDI9Es174LtZ0TWXersWpVBd4iQdsuINR4FFUe3P?=
 =?us-ascii?Q?aLiL/dYwUCJ4xYsDSRlRU4Lqa1YyGNxyUgvvEsCm2QmwNYPE4bIrW6J+WH5I?=
 =?us-ascii?Q?QBUTcRijZBDcfIwoPUvjWn6sfs2D9GaE4nzIPzeIGlquwVsdNvP4EoxS/R9X?=
 =?us-ascii?Q?8NwPeV0TXtzWLhKLxUWp7NDz0ciTOedeuay1u/9aKfzTDu3BRoBWSb2SQu0R?=
 =?us-ascii?Q?ALQiLQmsBXM5ZJ5AdvAE4Ls0oC0XcqqxcVcOd2IWDTad7fI1v9PPBrPk341b?=
 =?us-ascii?Q?NGy0J4y87OufBCaJS4PpYX+pvPS5fp2JLRLsGBb0xPXs3XMq6ko3aZbKucO/?=
 =?us-ascii?Q?PKV2Xhf9vLPpidIe6p/8+WNO2DnMcOid8csqQMn0REImnLt39Z9yiR5SoRdZ?=
 =?us-ascii?Q?GbMwMyOXAVKC/lCEN3lsdQnSC4kaQcVOIvJY+LJc/QKd4f+MxGmfzDzOUzO8?=
 =?us-ascii?Q?SVvAaCcoW7wBulEZDp9XFa+1vE+vOE2J3qyCU+t/hhw9yFPRSTKku0S4CfQt?=
 =?us-ascii?Q?DCnAB2fFM/+RRZxoRwmHEdDUEDQNkxQ9vG8L4qZLr7XDjmgRq85wRquVHkte?=
 =?us-ascii?Q?DIqvNUW5/7UzvuZbFTZLqEvvWmD3XJhvZc7xMt/VeDYHebRWIX/a8rmOFYoc?=
 =?us-ascii?Q?I/YT17MsyjE6teVvzxo7JXQaz0pyGxSFVg0A5/zD6drU3FoFG1inpvZhGtIX?=
 =?us-ascii?Q?lum230h8YXDQOybeDdscQ9e7pyZuu1eAKzYE+vdPgf3mI5GrB7s5bHXrCMw/?=
 =?us-ascii?Q?Y4hG4y81WXmrhvg7EFy/ckybfryrtbfte76CPhC90d6TNhjjtmouZ9LUNNQW?=
 =?us-ascii?Q?BkgjVEbl4fB+NGqCG5kP3V9VRj2HoLqKd/9LxBlanGNvBewXD1CWuhSdxiPg?=
 =?us-ascii?Q?o3eDSjyk3Wd9BLyQcZC+s/3/VrT6aoyDDCvpvKLHMDRQFi8mbLJIrsmSYQ1P?=
 =?us-ascii?Q?H2/43pCuuBtRIElyoxUZyJ6b8+kVaNwPmpwvuLZmEf2vGCY+UzOHJN13vJZE?=
 =?us-ascii?Q?UdfVwM3IXzy+YtCPnkis7WawD3Y5H0wEOZOd6gEbkJ79RGb90vkDMj94csfx?=
 =?us-ascii?Q?ZHU0hZM7cG0ZVnVxjsdiik/je/O6CJGwFfr1PM7efn9OeKF2tmr63VI9LkSm?=
 =?us-ascii?Q?wFb446vzjJ9lk/mVWReof9GAUzOs4jE3rFejoq83dJ+b97W9AgDfGvO1RtIg?=
 =?us-ascii?Q?cUYzV8tKYB+1G9Srb42K5NfDExzWmgORKgPUr+AQindzSkKtQXUg140o7IBY?=
 =?us-ascii?Q?GKuNSUQ1MXO5/seyi+0PgHa3IHkFjw3Iz1KA7sBM1U+xSP4yWxrWaVZKiLdY?=
 =?us-ascii?Q?y+O5JizYqG5kRRKM4soXCv4YHoBWLQLf25kqpBm3PSmnCE9PHxKRMD7n0/41?=
 =?us-ascii?Q?a63RbLxhGS2ES7Z9YreJVpcz9haGaN26g7gkWds95LtWw4PO4MjwQbJ9tvzg?=
 =?us-ascii?Q?/ncg7S8F+rC9dcrdAsI5rExBQey03bA+Jl856hKmMuEdf3mUocLLxcXzrXvP?=
 =?us-ascii?Q?NfrXPXjPnhzYXri73juSXbuE5u7khSo0DRbwx3b8PQ7lXFBNi1NIWSQpwcix?=
 =?us-ascii?Q?tSldcd+qQ+nny4jEr213LB+A/UypH4GKyhr4OxI9O4UTQRbfk5esYxiStTRo?=
 =?us-ascii?Q?hTDs+GNiFsl1od4UQl9n+LpfX7iUJRo=3D?=
X-Exchange-RoutingPolicyChecked: VoLQxxV87r0UaDowyZvvOn4lBcM7vYo+FmvQAa6ycpzn+HOD0tQwJ6Sbt0zxpdDnuwCd29VeOlrl+b0uDtcMuZW5PDvqGp/vVGFeZd4EWIKVP2e/DChTwjoDm9b04u8HLK1nNIW42yltxJFyjFKAD1mJurGnoNfSY149PbyyLsDDsGkYuqMWShmzqi5zY47eG/z/7tsLgZshj5SCkLG00hszqpUhIRLFdKKz7HT4ZNuK+Bal4zKZ3OLZOWo322ikC0Sxuj5F+EOk1NfIGd6JgW/0KRgDADkPDwaEhWvLhVcCHW6GaQcq8NNxqnsFMGYvKSto58ol86Qwty/rYvl/Jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0738fd-74b7-4851-f92f-08def7ddde64
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:22:22.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jcfgf98TMIWV2Fu4IRR3HgnxODJrmTubx1jyFDcp9AU8gl6vm3ZIRpsMrbEJIAeH9XWA0dAbBcAu2pAN5uhryhi6UxgmTNZcmG28svYutDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4600
X-OriginatorOrg: intel.com

On Tue, Aug 11, 2026 at 12:00:13AM +0530, Shaikh Kamaluddin wrote:
> cxl_handle_mce() offlines the aliased page of an ELC region on any
> record with a usable address; it does not check MCI_STATUS_UC or
> filter non-memory errors. uc_decode_notifier(), the equivalent
> handler for plain memory on the same chain at the same priority,
> filters on mce->severity and leaves corrected errors untouched.
> cxl_handle_mce() has no such gate, so a corrected error - which
> the generic handler ignores - still causes the alias to be
> permanently retired via memory_failure().
> 
> Corrected errors do reach the chain: machine_check_poll() logs
> them via the same mce_gen_pool_process() path that feeds
> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> extends p->res to cover the DRAM half of the ELC pair, so a
> routine DRAM CE carries an address inside the region resource.
> 
> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> machine checks") established this filter for an equivalent handler
> on the same notifier chain; the consequence here is more severe, as
> the CXL handler calls memory_failure() rather than recording a bad
> block.
> 
> mce_is_correctable() is used instead of copying
> uc_decode_notifier()'s AO/DEFERRED test because the alias must
> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> the reported page but nothing owns the alias.
> 
> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> 

Thanks for the patch Shaikh,

The patch looks good to me, and the reproduction details show that this has
been thoroughly investigated.

The commit log is harder to follow than the code change itself. It seems
that too much of the investigation has leaked into the commit log which
makes it very dense and not very clarifying. For what is ultimately a
small and straightforward behavioral fix, the log spends a lot of time
narrating the code paths that establish the problem, while the important
impact, a reduction in usable memory, gets lost.

The commit log should introduce the code change and make it easier to
understand. I'd prefer the usual behavioral progression: describe what
happens today, why that is wrong and its impact, then state how the patch
fixes it. Also, please spell out Extended Linear Cache (ELC) on first use.

The subject can describe the behavior being fixed more directly as well.

For example: (if you use this example, you need to proofread it, to
be sure I actually captured this correctly ;))

cxl/mce: Avoid alias page retirement for corrected errors

cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
(ELC) region for any MCE with a usable address in the region. This
includes corrected errors and non-memory errors, needlessly reducing
usable memory.

Restrict ELC MCE handling to uncorrected memory errors. Use
mce_is_correctable() so that MCE_AR_SEVERITY errors continue to retire
the alias when the reported page is handled elsewhere.

Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")


more below...


> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---

The detailed investigation and reproduction below the scissors is useful and
should stay there.

snip

> 
> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index 65fed913b221..ee70c1c9f9b9 100644
> --- a/drivers/cxl/core/mce.c
> +++ b/drivers/cxl/core/mce.c
> @@ -18,7 +18,14 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
>  	u64 spa, spa_alias;
>  	unsigned long pfn;
>  
> -	if (!mce || !mce_usable_address(mce))
> +	if (!mce)
> +		return NOTIFY_DONE;
> +
> +	/* Only uncorrected memory errors warrant taking down the alias page */
> +	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
> +		return NOTIFY_DONE;
> +

The comment restates what the if condition says. I think the comment can
simply be dropped.



> +	if (!mce_usable_address(mce))
>  		return NOTIFY_DONE;
>  
>  	spa = mce->addr & MCI_ADDR_PHYSADDR;
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.0
> 
