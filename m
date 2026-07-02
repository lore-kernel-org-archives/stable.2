Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E60431E5B;
	Thu,  2 Jul 2026 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951989; cv=fail; b=SemZHbal9V75+MF4flfbmzFkdsNRzOkVznRA/OW8OzIruF137XvA6z9K9XKAicq1h9BMacFrS5sUheFmiko5+hGe6/NLo3+itjSRN7sUMC+1ZmUs8Ho0rBQzhmaHB0MoQz+K58AuxnioU2ocFomWkXxyhnCHtNirKBFC49lLyk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951989; c=relaxed/simple;
	bh=tsileeZclMe/vGScFcSOYNTXvsibXguQKBQLXyZY4js=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GiGWUFqySLvtoFwloJWi2NnBJnkqktFw89fRAk4WHY5sGgYhN6w7XsRAzJilNWKG9agx+v9OE9m+NlZJJafKElQPG/qUgWjYNFGjBge2Gpw788cZDQR80a93lY6hGjwpUQvt3ajup580HnRAkpGQaNA0UMR/fEYmiHgWHeXfzrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bY3Us0qW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bY3Us0qW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782951987; x=1814487987;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tsileeZclMe/vGScFcSOYNTXvsibXguQKBQLXyZY4js=;
  b=bY3Us0qWej/v0SMMRZQJted7E4sjgcYcY4U72htAw0P+Vq6h30wW1DhD
   p5QpGUIVn3Grjpyy/qXIvsETQgJ3HWOQN+RdZycaIsZlaFaJc0SLUQIUW
   jNtwIBxrC+iNPJWGAmJ9Hp1NqyteB2hxEI6SV4yfooa8ztut/9ZfVuqcL
   RFDX8hEZxD0cR/m1PQKRiiWHi44RD89XWIC7MGwHWxUvHl3gDzCWxVyg8
   BNGiSYPXrTjYfdBgxPFC5lcDZqN4cB1tb8Hs+lH3Xd1Nh4c0f8Ts0q9fr
   3ucJUgBsubg0wXZwvTtXq/v2tWGtWaqBJAO6BhZhmCoNWmaAwwcpWijIa
   Q==;
X-CSE-ConnectionGUID: xeP1xHAcQXKtMPNG74Un8Q==
X-CSE-MsgGUID: eHOZPv3TS/apPa0StiIq1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="109243602"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="109243602"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:26:27 -0700
X-CSE-ConnectionGUID: V7l84kNUQ9OjsJKDJblstw==
X-CSE-MsgGUID: 6wjGA16FRZyoaS21lEzLMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282777729"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:26:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 17:26:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 17:26:26 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 17:26:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhJDIf9YSM9ZYYtNZMu6vte3makZ8uZNgPsrby38QQYl/UQy4TbTeeAtpgGJREVzpw26uYhobX1bwIUNR8gJxo73Bs6jTSjUrLxqNblaKzNiHco+gbiKZAaH0AUKcGVUqFjMOZGfwc7m+XbPG3M+eruUY0xVhse6CzQ4I5cNPITmhILDW5LW+eXfGr4ov9Lm+wDeohhXERMVBNwmqDnI1lGYtvDV7rUKrl9CT7w1y3SeRAk6VyObt+DPaTyaPom+XZGo4CPnVm2em8AxvjAWXvswRuxniaI3V8+WCoe4T7KMksLVdxYc7EGWCCoaHcc0z8t1Z0r2z8eL9hp3oEnK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfgqt2Fws+TLnTzzxFoeZ+w0/HIYX5VKZ3GO056cQ+I=;
 b=rbYG7hPHdQIZ6vXV0RCBdbZGhwx2z2StED4Dw/MaVJhFkgWEVYhzksDWnVD+MZAw1MRTXBkG+mqI8OfWiduZMIGTfqvqFpNrwx92pbhHglrlJgQl9LNUqf3E2tjDZ7yqi+V+0Bn7yMcYjbLrkdZFo4Qpww93ayEx69ZFs7Zp5ZfuoKhO6RSWxPUg0NRr9mWkLRi2FuHGdgV9p8k4lpXZiR6B4ch/dmMz1f7y6HSW/svh6Lp0KGV1xVJSxi7muoDztfy/Vqx4YRa0TzJbuXm3BsRLphcRQPva2QHhBnxxXZ5heSw3uMP/py8rzNjv1KEBsWPW8A/xVLGnlEmAFRilGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 00:26:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 00:26:22 +0000
Date: Wed, 1 Jul 2026 17:26:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] cxl/pmem: Format nvdimm serial numbers as decimal
Message-ID: <akWwKt3AUER4CTho@aschofie-mobl2.lan>
References: <20260619055932.1354182-1-alison.schofield@intel.com>
 <6a3d83cf9ee43_164f9d10042@djbw-dev.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a3d83cf9ee43_164f9d10042@djbw-dev.notmuch>
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: ff266641-4c81-40fa-d47d-08ded7d08b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|5023799004|11063799006|4143699003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: OLInr8fzU45ArrSqoJbbevrwcJCPPyb9m8RuhWzZB8/B5whemaYgPx83XL6VGkdxx1MiDcifYgJCKXS+8dvJYpM1rQXMStt+eCcgYAw+kvikWXo8uXPLIpMLLJqDkjFQlQoIGbHh3+XWlSGbQqH1pick0bEXwB4eqPQyf0GpYxASREG+/Y61rYDJD3ZLgQj1EJT4LBJBVm3/HfICOzzag8ZUP2w1TSMUWLzexI2ewiZirFAqKi1WbtD+69bMynPrGZPSA/kEYfWJ0URTa9lTLX2Fh6hh8ytBoCeogv3ldmqEWh/Io0wu/AGODFrR7kjC9BoI+IAy+P2DeQvYGTe5wNvBYg53EN3Br4XTy3ExxfcyWhLmuE6ccWaJfpcPx1Nti5z7WoRnH0Ef2XRn6E1HSwwH5cc1Pc4sh7BXi7Zxh7zn5sXKx0hJEVASg5BCtsmJKcL6MMbXadrSHLoleroJjNJP1oQGUNvTUY4br6ppNWkcCSnuVzLAVhe1D+MTrYancRVwyrAquWpnynz8g6turjEcjan/9KDHI7MXfFFq2Y5sIXL2HE7AFufhQLCrubXEUzA4vwh+o1wMM23qytUrijjKlZLrYl2ms6yxruBTP7s45bUdqShSTun72+uxBD3kgfb49BcBLKV5A0t9QBxVj+tGKD/Kx8ca8E8cQgk5c0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vHMNx2Slaq8SRT7JRPm4Y/iroReygacR/r/migp6zShdPT+8247Bw1bXFSD?=
 =?us-ascii?Q?BWkHFdbVTU1rHzEtQbLvqKVSvKM2wxUBN4IcJvUoFrSSZwkKNv5+V0/k4hFP?=
 =?us-ascii?Q?0o4K6/BXbdXIq1lBZvFl2rs9VcoV6noEKYun+PSAbg3tujalAKZF1xKfHU8K?=
 =?us-ascii?Q?RkLWoaKZJIQci63nxLSdBRAAt/QHiho7E68FaAsj84vgojlTca7UCwYxGJnq?=
 =?us-ascii?Q?nDKUgDXVvJ+taFojdvPXkXKTF0hwU5TV+Tu+gv+vU+2iYuYf+g84BbCAZa+M?=
 =?us-ascii?Q?5NedJpqxvZ9hUgk/S/Z7dgoMsw2UOHsl8rkdWXRF4YZI/msi9tioLmkSHMDf?=
 =?us-ascii?Q?Ix/mE22akE2kEhz1qld9uCaYFiPY2broSAazdYcbtgZ2OYU3q4WhL1Xn/RDJ?=
 =?us-ascii?Q?xhWpkzQmDLb4wQmeIaGFS0FTL07kanOUTBkKoYumJjuoo/4ddHslhIDdOcSH?=
 =?us-ascii?Q?byklrq8BsylqgIURExigXDLG9/6oHBogp572dUrTaBIrl39BJ+2RXSMKIkh1?=
 =?us-ascii?Q?MtzxvCqsE+OcZaHMhk1Msw0iEhSuIGf27NLPjnbHqh7W+mFyQD8NafDzU2ZR?=
 =?us-ascii?Q?09nyr6F2q0Pl73ZSkh+RhizAY7lY+6+h0/ECOev2nX3KR7EVHgm7p31tZAzw?=
 =?us-ascii?Q?nuFCxyJK+7MXuCaJKqkAqLOJuM4vlrD/iadR+NAM1NZrmFr5qNXX46hiKdbk?=
 =?us-ascii?Q?5ecPxXkBr2i3o5I2sNYHx/I5uVdnwyfmjc9dYi8/2w6TipORnRMWhmy9hT9p?=
 =?us-ascii?Q?+GUIgJiRkoG6D4d1t1HgNfFMzZe+ubpPvyHntwInXs0wcL4vYJsC4/bYxhp5?=
 =?us-ascii?Q?vtf0x6woSvGqWCCdEiKHITB+r6W3K26OjrOhhc0oj8csm6zAq5LDeECivexL?=
 =?us-ascii?Q?YE826qIttoXwjzBZKTJLQJ2feuM20XFh5DPFVxKB/H26ugffz3nplZHoNSvk?=
 =?us-ascii?Q?IwkzqdBNCdXapn/ACmwrA0svrU7oTmSGK6XUnp18GctczhQFnO/uyFlH0I95?=
 =?us-ascii?Q?fn7Z5KIdEeKKSz5xKlb5MvpDJRuYfgDGMulbC212Ux9FsmKcZyBlzY+VdRyJ?=
 =?us-ascii?Q?wmv9dO+00pwi9X8/zlzsz+f0Sj7ZDO4wMpC/5JiuA1GHWTHBdpuoNguR09nX?=
 =?us-ascii?Q?TKW4cER0fSgixHIe0sXMVcg8Sdwy3+v1by45/5d1z78MzDauVJBhbE+GOMiR?=
 =?us-ascii?Q?ucsh3cOV/W5RJbAH/2YAH1XmH4rU6YZwtqM2Yq1thICnpn/+nT2ZWLypKeL7?=
 =?us-ascii?Q?HxeCBFM60FGDeyeKxrfS0pYzDdwigTbxY3vbvhlIM0ezfmlbF3aX0Cp2vkuc?=
 =?us-ascii?Q?LsCgQAEf/z+2xMDHAA7f/OmReEX/rfgyCLEqsXwI5ds0Ph7bYEDcRp1ZHZTj?=
 =?us-ascii?Q?FIARAVnD30NJnUcMXPFg/lNXZlxg/iAlovhwSA+XgHMip5JcvxroC4T10z7l?=
 =?us-ascii?Q?pYp6AZXgNoyM6/q1BcLFdjdutUdgWS/E5c9qOZ+fi8h/WvaAuu6qq7Abs1j8?=
 =?us-ascii?Q?4R3pO1QysrlfBFkzHSvsbHvRLRCWZvXinOJQUIrTmRrN/kchX5QtFqmpJlay?=
 =?us-ascii?Q?vOxsAVu7+0Z6EzhikKbyX2FX2RfDE/wKCASgHJibZihL+1SptvIfl92rLBp2?=
 =?us-ascii?Q?8JO0+TB2ahurHHpMkswxhSObu+2rwVBQ+C7j5RFlZmvF+MKqHKLhtVlz+Tsm?=
 =?us-ascii?Q?DPd3bhvFAlBGING5LugL62sq21Zb+GEsiqGAM7voKVqqJMNP/kMin9hUcELP?=
 =?us-ascii?Q?SG0SAN7mR+45xpwJyDOCpp3aCwDLJKc=3D?=
X-Exchange-RoutingPolicyChecked: a3jXdk2aZO3qcX+3Am/o8ZeYZvd6Z7729VTCgbfNpBEVekOFEMQgtYdq4KkpYh/dPhRahmwWiUyD32BOkM0XxBmYHUxxyiOHn8LrQXVrV6tVJgGs6EGxk/4s/hxourc48DzLghSuv7HNhOBmLv0W+SGm7uiE0B+frsjb96wJAJ4AVxegX0IhBF7T4gU2vpG6el3G2vdUJOwMU/df9C7b9vdC1R4ienKUTk5HVLdUcmy/hpQKPTZJ3CQQEKhif1Q7hiex0+Reigh9jU6qbjkBb+QbHNDo61Pg1tZYpNrL6Fyr2MGI/AL4nZmnI6PTWK59zRrylovOWs6+9AVCRZ69PQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff266641-4c81-40fa-d47d-08ded7d08b04
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 00:26:22.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rftGTPQ7X+a5OD0BedjGzEo97PregBOncrv3p+/4Pnz7shCTa+VHraYGx+lT81lJ8/6dwUTD1XrwCVspv1ptCOKJKtwhLtPWUPciLTJAUK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

On Thu, Jun 25, 2026 at 12:38:55PM -0700, Dan Williams (nvidia) wrote:
> Alison Schofield wrote:
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
> 
> Good find!
> 
> This is a good fix for folks with new kernels and old tooling, but
> leaves folks with old kernels in the lurch.
> 
> Not sure of the priority of doing this additional work given it is not
> clear the CXL PMEM devices with security commands ever shipped, but
> userspace tooling can workaround this problem by always injecting both
> an nvdimm:%llx and nvdimm:%lld formatted key descriptor.

Hi Dan,

I tried this out, having load-keys install the same blob under both
dec and hex key descriptions. It can work, but a couple of potential
issues stopped me from moving ahead w it -

Shared keyring: these keys live on the per-uid user keyring (@u), not a
private ndctl keyring. Duplicating every key by default consumes space
in a shared system resource for what should only be a transitional
compatibility workaround. In practice the 1 MB quota is rarely a problem
because load-keys runs as root, but it is still unnecessary growth of a
shared keyring.

Clutter: an administrator running 'keyctl show' would see an extra
nvdimm:<hex> key that appears to belong to another dimm, and the key
description cannot be annotated because it must exactly match what the
kernel looks up.

I also considered an opt-in flag, like "ndctl load-keys --hex-compat".
But that mainly benefits users running old kernels with newer ndctl.
The primary audience, users staying on older kernels, seem unlikely to
update their ndctl tooling.

That left me back at a fix for stable PLUS a documented manual recovery
process. Appended below but not yet published.

And one more thing...while trying out all that I found a signedness issue
w the serial number representation. So I'm posting a new little series that
address that too and obsoletes this patch.

-- Alison


Manual recovery (for the documentation)
---------------------------------------

If a passphrase-protected CXL nvdimm does not auto-unlock after a reboot
-- it stays "locked" and the pmem namespaces it backs do not come up --
use the following to recover on a kernel that lacks the serial fix.

1. Confirm the device is actually locked, and that auto-unlock is what
   failed (not, say, a missing key blob or a hardware/security state
   issue):

     ndctl list -i -d nmemX | jq -r '.[].dimms[0].security'

   This should report "locked". If it reports "disabled" the device has
   no passphrase enrolled and this is a different problem; if it reports
   "unlocked" there is nothing to recover.

2. Confirm the failure is the serial-number format mismatch. The kernel
   looks the key up by a hex-formatted serial, while ndctl saved and
   named it by the decimal serial. They differ for any serial of 10 or
   greater. Compare the two spellings of this device's serial:

     # decimal serial, as ndctl named the key:
     cat /sys/bus/nd/devices/nmemX/cxl/id

     # hex serial, as the kernel looks it up:
     cat /sys/bus/cxl/devices/memY/serial

   If the decimal 'id' is 10 or greater (the hex and decimal forms are
   not the same string), you are hitting this issue. Confirm the key
   blob ndctl saved exists, named by the decimal serial:

     id=$(cat /sys/bus/nd/devices/nmemX/cxl/id)
     ls /etc/ndctl/keys/nvdimm_${id}_$(hostname).blob

   If that blob is missing, the key was never saved and this recovery
   does not apply -- re-enroll the passphrase instead.

3. Stage the same key blob under the hex-formatted serial so that
   load-keys also installs the key the kernel asks for:

     id=$(cat /sys/bus/nd/devices/nmemX/cxl/id)
     hexid=$(printf '%x' "$id")
     host=$(hostname)
     cp /etc/ndctl/keys/nvdimm_${id}_${host}.blob \
        /etc/ndctl/keys/nvdimm_${hexid}_${host}.blob

4. Reload the keys and bring the device up. load-keys derives the key
   description from the blob file name, so the copy is installed as the
   nvdimm:<hex> key the kernel requests:

     ndctl load-keys
     ndctl enable-dimm nmemX

   The device should now report "unlocked":

     ndctl list -i -d nmemX | jq -r '.[].dimms[0].security'

END manual recovery steps



> 
> For the kernel change:
> 
> Acked-by: Dan Williams <djbw@kernel.org>
