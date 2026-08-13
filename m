Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D345388379;
	Thu, 13 Aug 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610002; cv=fail; b=Kd48E5wP+r0qVpJ7ipvZRlZhm6rz/23yYSsmq8FTlw6ri3V+GY7fGhGkIsxkSiqfBFo5L+rY3QUBaOE8eGZXgIfKxd2BCSrAfR8d2vzgsyqc0VuJBvZKXTIbz2XqK9SOPyNnxDTUR7DsOMCaf7ISBKW+7V8YUMckqXxglSdx4hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610002; c=relaxed/simple;
	bh=ShVFr8rYoagdF+L8ZZb1teI+Mvz/qgQOTNJhVQbx01g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ic2UlEmC0QYOfO7b1gXD1ZS+TufqqBONYh4W5xsZT+hZsr3qR/9RrsyriC13vwxKF9KHbpbH0y0a5JY4nNn0gdAF9vEuI0sEvfyaesxGTD2rhqB4/z/zl1NhVyyCKgEfzDrLO+eEPM6jO9k0J8td2kqsWGXEiGDHWV776r2lG0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JavlInGX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JavlInGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786610000; x=1818146000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ShVFr8rYoagdF+L8ZZb1teI+Mvz/qgQOTNJhVQbx01g=;
  b=JavlInGXXzySdn9Sx4UP4YSCn8n5MJx3ozndBg7m05+m2VT5UU4ZBdzp
   Gd3t1fnJ30uaQWI28Qduc2q/pJYarTBzoKtK25U8xXuVqOEd+UWDRJpE9
   A2Jp3BFX0Aijq7nkkhzzKk/Nmtv/71mrg9zvA9jgT83TvLOv+sqJrjGQy
   8fVc1IrLu915/yfYpEpced/ayFHUXTJzxppDSd8GWngKncsiZAbn7WlEI
   Pp0xFGUAImZo0QwNJtXEuGcufoLJ5kes2uY45159Vc9Z7HA3mikNBivnr
   OnQxG3WYCkugMJF7hk5+IU3RSJYNrr3+V8eatifNvvAt0oOZ7JHSPLEPN
   g==;
X-CSE-ConnectionGUID: u8t9+Mi1SeWI6XgqCgQfrQ==
X-CSE-MsgGUID: Hks8JIZSR1W77thmlKRo7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87303221"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87303221"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:33:14 -0700
X-CSE-ConnectionGUID: /febrRA9SEO0mhtP7XIdbA==
X-CSE-MsgGUID: NCWjoxqrQgGhkaTBk6PiiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="263419293"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:33:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 01:33:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 01:33:13 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 01:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6vWmPMJtAsfK3bAEn9BWOMHbZJ5Z0+U0VpW2AMf1S9OTfn14aviDVw6f70Quuet7WDDbPTdOAQo9NfUnc7C2SDKhtKSzbCT66BJJRThdmx91rK2CFCcPOnYFbScyjZM+vkzWcbwe64qVSB5U5BYT1udut/wYBNP5c/LJaOhfS0CEDz3JEDwIh6E+DMJgInN0fLIEsh4ySyfSfJmz6T/bQy1s+TvL6Xs//lIACxPz9UBE2Oq9ezSPVzkra/H9shk0d4eahGSDWiS9g/ssgc8qh8stLOEbvK4LY+XPwJiw/X6d1zsWxOqR+wuvnLM79u21IGFzunvleKK+zduXpCjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtuzL+LFAT9mJtcojhjOGVVHmx5CF25JLynUwYSf3t4=;
 b=b3PFxbWx3gvFHC0Z8pDRnCOL1k3EcJjMIjEAOSt/TJp7JKX9+w8YbLPZXdaFU0c1savOw9p1OFACHI+3mab0A6th3TdGpFYgzU6txNC9AlbhgeLP6pIAAPrpSodm6FEgoDLpyvjWsun0cZ1rpmehLYyu21Rxn1hObDLMbdjlp42qFdZsLKuIXZfdj+GeIJvCn3ALiWHmIoBCjBuWz3fDcQhN+vlXBhLr59NyVdjKjvD9rM2qSYSWU3Y6baX/z6uFpwjRpd9H/su/gwgODrPcmpxiRPttWBSMsBNSWT+d/1YZ61t8qvkZqcu7Y/yyarSyzgGHIGQUUzsPYv4UWs7/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 08:33:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 08:33:05 +0000
Date: Thu, 13 Aug 2026 01:33:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, "Dev
 Jain" <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
	<lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Alistair Popple
	<apopple@nvidia.com>, Balbir Singh <balbirs@nvidia.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Thomas Hellstrm
	<thomas.hellstrom@linux.intel.com>, Francois Dugast
	<francois.dugast@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] mm/migrate_device: Fix THP splitting of a CPU
 faulted device private folio
Message-ID: <an2BPN/1+C5zJnrm@gsse-cloud1.jf.intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
 <20260805231041.3791771-4-matthew.brost@intel.com>
 <87ik5in224.fsf@DESKTOP-5N7EMDA>
 <anopzF3Hk/RRh8kC@gsse-cloud1.jf.intel.com>
 <87cxvnn41l.fsf@DESKTOP-5N7EMDA>
 <an0CxFPPnvPWljyp@gsse-cloud1.jf.intel.com>
 <87bjb67pk0.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87bjb67pk0.fsf@DESKTOP-5N7EMDA>
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 869fac2c-8810-4a21-86c7-08def9157eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Jl4HkJ3TTBvwijyB+OADvjyddFtbJetjSumibKnFmwIM6b8ilih8w73EBWvubaNXlrzJC0nzOmRZjSzFAtE/gp4gsI5899AHPDbnVvnrX31muMmdHpBroFgWWsNyGI31pA0dAGoTh5DN3z0T1riZNqlrAj5MENgR/mxDUhAUABT893iBCkUl3qpKFEAUw/OtVVroM7Z5YBeRmLYH+GDraZz6PWpl/ReCxuW+qk0uqWznbnWpf2yWvPKyR+2o/7VLcfDR9kbmdUFIpMHUgakBtB1V9hxJ0qc6y3gjtnH6sFSbzkPwuYQGuGJG3u++0scFzpOMu3musNP4F3wvp74wOls0K+8URp63FgptneneQmd8RQUOM59NgbhYpab2Dz+mcKGquoGV+wIsfwvPqf9gnuCdujUGu7NgfZn/gtCD3T3mhvyDyCuXGLfFiL39g1u5WEjxjadFMrIPWUtSyWhg76YaJi0zMW+qkKQR7mxpOjPsz4uWQ+V7PM0spRmPD6WBXfXbDFjPJFENEs7mJ6X2w0sLOBjwEZ6ctwxXs2n+ox2zr727PMmRrTK5vpAGRbZ+6kQLlfAUkkczZnPn1XIc1kDSaJoKBt2SF/oQLOwlT5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJPh2yZgUi1edfkGS697NSHw+kjcA00NNYHRyA9ulkBgMrfjkLntrXLc7UZT?=
 =?us-ascii?Q?GUDZniyYe6dm9o8ixCD6AG3igYs4jUAw2iUgnwapYiS8WbOyd5srXG/Ce/43?=
 =?us-ascii?Q?XnmEvW0CVzy0ahMiucx1YaCLGWNGTBHZSQZ/jMWtCgHj0zXxbuId4gJYRfSe?=
 =?us-ascii?Q?oneWpaZbeQQxIx4zJvDlJfMUUwi0egcro1lS0Sf3A2MTO0ocn+WCbH1jBDrM?=
 =?us-ascii?Q?R0pTk07ID33A7IDP1QCeOU9H15b8VUNdHWfExcqSv7xvyY13byOhhFvHVkeQ?=
 =?us-ascii?Q?D4bB2MUvCpnGM11WnG7a8q6m5E728R5fpheS4eZgMbo0xyk3xdgKLXODkHJc?=
 =?us-ascii?Q?vX06bOmAmCO8O/VU8574gbFvA6fG6uKnCnqPRBxx5oohmtzT53jaGpyxaMUy?=
 =?us-ascii?Q?n+mc8Yv5aIvMCQ5IWjOTG17SJMjuE+1tbHzPCaQ2x1+GAo7s7W2iLN83Kl3U?=
 =?us-ascii?Q?oh9jlXTD0l613oqB69mIwDvzl0+YjHfg4J5SLXTQ1Lk4z8BOHr+pCqLq7gIC?=
 =?us-ascii?Q?U+u9mMSKeP6NLusNnYEzUyXdJj2KFyj4Lh/0Ok7j8jB7lnHGjw92re4H2qte?=
 =?us-ascii?Q?9CdUfBt3/Uf723lSqhCQ58SKXTArlcnjj2grGg4FThnW9TetCihtJMp3a0Oo?=
 =?us-ascii?Q?41T5Kos2AStfETS2k4hlF5x1EvwbIiHcaq1Lnki55iEyllGOZVSRwbh2X6qQ?=
 =?us-ascii?Q?8EdTL8e4u7BqO2IdlGYelsVOxuxuL3k47NwDp24ZNWDmt9OZ+GUvpX1LTyiR?=
 =?us-ascii?Q?pZHGdqzxfzNxjRBEZ+Rd5yUm/jiHvtZVwQ17AvYj9Y+PBOpavXzhbFTQVfOY?=
 =?us-ascii?Q?7zdRdcPOQ5xuOYQye0IeIWWdMOX4Zk5m6mBi5pB6oEaJg7tMJN/HXWrWyUMZ?=
 =?us-ascii?Q?JrVatEEHTgUbL2gVHL21vY1VMgLxH3H1rSlJ1616hIyyFi++ArHEXB7Z6wEm?=
 =?us-ascii?Q?TbT10JycawtCsv8rLunZvJpaHhbB/RJXzkBCoHfsFgnEwPSaFnYM/sJ46Xoj?=
 =?us-ascii?Q?cIlBM5p2dArlM10rq87sHUb+SpvBrj3+uPAe+1l0C0ej1hG4pB7ZdCGrATPd?=
 =?us-ascii?Q?kXLKSN9BcUnDIUmCGox5yzdY/mWp776jbywk9spD9XENbMXQisXy/qYnvfoY?=
 =?us-ascii?Q?aJJ4z/O0VG0UTlwrxwkzjlUTceqqHtBoXkGxJ8dNxW2ZmNUDzDmTae/Y1up8?=
 =?us-ascii?Q?dB2GofRN33gCzh+4u0qGFQesIvudIMcpBKo5swuDw+iLG7kb03tXOGAXL1eS?=
 =?us-ascii?Q?dUza7qX3tmDoqbcKdCdx6RqSg9XN8Wd8rgu4JihUrSq7Iqn3cNtmfR3lKAZC?=
 =?us-ascii?Q?IFSaM0gfxzn/DrsadzqA1jgVLFp+D835/OHE2LwM+hL3bkRmh2o3Vk3pI+Lt?=
 =?us-ascii?Q?krn4+KvX7e7ZG0At7iGurX6cwWtvMTnGy39gZvPnAScRe0LjLjV74f8faUEV?=
 =?us-ascii?Q?MHKhmS9Xp/jcXJoCYvCH8N7jOSuTHOaNOMYwBS9Ihol2AaLO8N2SnMwDnswH?=
 =?us-ascii?Q?rx3k1QcCZNtcrXYUNfDASg/1GwlTZOIh63ESXMdFnjXNBXzQLnUqHhwiTTFQ?=
 =?us-ascii?Q?aGR1QGqdRkq5AmnqSg+8utvaWNNCbkiFiC6MKSkcZ5ICAxmwPruL/fJYedfU?=
 =?us-ascii?Q?4O4gar7vtTqEkWSBgCIcxmYDU9+h5j30WDDaBuEycLWwhJcWfhI+FgXvv5nE?=
 =?us-ascii?Q?Nvwm9OPWt4aNaBVRSnO1xbSvGnlwRbhDneVKpSkbPlY5GPyfR8yByTKmAuuu?=
 =?us-ascii?Q?t9k0UilxxA+bFZ1J0r0nB1zlijP26ww=3D?=
X-Exchange-RoutingPolicyChecked: R41Jtpoi3ZCRiJo4ghGyLa/pD/G/bi07C856Jmy0N5XcEeVYeZVXy16qtnBoAcxWx5uVMObATit5uhvEeIrYjey5Qv/Lsytyg0adekTwe3VH4u6O3h43/Xri14PGleGTzknqew5SkqKzHbC4BGw01dsN8SR9owK55aZvPLegYVlTpBuV+rcIaY0A16KRVv6Hdas31XckCBmMkSFKNqQf5mFHI5BrC8JIe+ww6nNqfUYgeZryzNvKy/XmoTVjCYGUdMvnlgMBX89L0gSxUZaJCdQqP7uEbrTsvANJYixgOOFJuO1r5jeNrj0v/RnNIuMRFBVX4UaCB5CliF3uPuDiRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 869fac2c-8810-4a21-86c7-08def9157eaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:33:04.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbwN1hBDX/j3cpuvz4+BxdIqV48DaZ4fwesbHLjgzwUvDwsisZpUPLbxBg3swzITi1yCRfdceKi+ZGsbM9qUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com

On Thu, Aug 13, 2026 at 09:54:39AM +0800, Huang, Ying wrote:
> Matthew Brost <matthew.brost@intel.com> writes:
> 
> > On Wed, Aug 12, 2026 at 04:20:22PM +0800, Huang, Ying wrote:
> >> Matthew Brost <matthew.brost@intel.com> writes:
> >> 
> >> > On Mon, Aug 10, 2026 at 10:26:27AM +0800, Huang, Ying wrote:
> >> >> Hi, Matthew,
> >> >> 
> >> >> Matthew Brost <matthew.brost@intel.com> writes:
> >> >> 
> >> >> > When a CPU faults on a device private PMD and the device driver can only
> >> >> > allocate order-0 destination folios, __migrate_device_pages() has to
> >> >> > split the source THP via migrate_vma_split_unmapped_folio(). That path
> >> >> > is broken in two independent ways when the fault is what triggered the
> >> >> > migration.
> >> >> >
> >> >> > First, the split never succeeds. At the point folio_split_unmapped() is
> >> >> > called the folio carries two references beyond the ones it is
> >> >> > entitled to:
> >> >> >
> >> >> >   1 - taken by do_huge_pmd_device_private() for the duration of the
> >> >> >       ->migrate_to_ram() callback
> >> >> >   2 - taken by migrate_vma_collect_huge_pmd() when the folio was
> >> >> >       collected
> >> >> >
> >> >> > (the mapping reference having been dropped by set_pmd_migration_entry()).
> >> >> >
> >> >> > folio_split_unmapped() requires folio_expected_ref_count(folio) ==
> >> >> > folio_ref_count(folio) - 1, i.e. it tolerates exactly one caller
> >> >> > reference. With both of the above held the check sees 2 against an
> >> >> > expected 0 and returns -EAGAIN, so the migration is abandoned and the
> >> >> > CPU fault makes no progress.
> >> >> >
> >> >> > The PTE-based split path does not have this problem:
> >> >> > migrate_vma_split_folio() is called before any collect reference is
> >> >> > taken and explicitly skips folio_get() for the fault folio, so the fault
> >> >> > reference is the single caller reference the split expects.
> >> >> >
> >> >> > Fix it by dropping the fault reference across the split and re-taking it
> >> >> > afterwards. do_huge_pmd_device_private() derives the fault page from the
> >> >> > PMD entry, so it is always the head page of the folio and always ends up
> >> >> > in the head folio of an uniform split to order 0; re-taking the
> >> >> > reference on the folio therefore puts it back exactly where
> >> >> > do_huge_pmd_device_private() will release it. The folio cannot be freed
> >> >> > while the reference is dropped because the collect reference is still
> >> >> > held.
> >> >> >
> >> >> > Second, the folio is split globally but the page tables were demoted
> >> >> > only locally:
> >> >> >
> >> >> > 	split_huge_pmd_address(migrate->vma, addr, true);
> >> >> > 	ret = folio_split_unmapped(folio, 0);
> >> >> >
> >> >> > migrate_device_unmap() unmaps via try_to_migrate(folio, 0), deliberately
> >> >> > without TTU_SPLIT_HUGE_PMD, so every VMA that PMD maps the folio is left
> >> >> > holding a PMD sized migration entry. A folio that was PMD mapped in more
> >> >> > than one VMA -- after fork(), for example -- therefore keeps huge
> >> >> > migration entries in all the other VMAs while only migrate->vma is
> >> >> > demoted.
> >> >> >
> >> >> > folio_split_unmapped() does not notice: the folio is fully unmapped, so
> >> >> > it only looks at the refcount and happily splits to order 0. The other
> >> >> > VMAs are then left pointing a huge PMD at an order-0 folio, and
> >> >> > migrate_vma_finalize() -> remove_migration_ptes() walks into it:
> >> >> >
> >> >> >   page dumped because: VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
> >> >> >                                        !folio_test_pmd_mappable(folio))
> >> >> >   kernel BUG at mm/migrate.c:368!
> >> >> >   RIP: 0010:remove_migration_pte+0x56a/0x9b0
> >> >> >   Call Trace:
> >> >> >    rmap_walk_anon+0xfc/0x260
> >> >> >    remove_migration_ptes+0x79/0xb0
> >> >> >    __migrate_device_finalize+0x113/0x290
> >> >> >    __drm_pagemap_migrate_to_ram+0x278/0x360 [drm_gpusvm_helper]
> >> >> >    drm_pagemap_migrate_to_ram+0x5c/0x80 [drm_gpusvm_helper]
> >> >> >    do_huge_pmd_device_private+0x160/0x280
> >> >> 
> >> >> Which is the branch your patchset based on?  I found that
> >> >> drm_pagemap_migrate_populate_ram_pfn() in mm-everything-2026-08-08-07-08
> >> >> still don't support fallback to single pages if THP allocation fails as
> >> >> in the following comments,
> >> >> 
> >> >
> >> > This entire series, on drm-tip (i.e., the 6 patches posted here [1]).
> >> >
> >> > [1] https://patchwork.freedesktop.org/series/171651/
> >> 
> >> Thanks!
> >> 
> >> >> 	/* TODO: Support fallback to single pages if THP allocation fails */
> >> >> 
> >> >> 
> >> >> > Without CONFIG_DEBUG_VM the VM_BUG_ON_FOLIO() is compiled out and
> >> >> > remove_migration_pmd() installs a huge PMD pointing at an order-0 page
> >> >> > instead, along with add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR). The
> >> >> > victim mm then maps 2MB of address space onto a single 4K page, which
> >> >> > shows up later as bad rss-counter state, leaked page tables and page
> >> >> > allocator freelist corruption in unrelated processes.
> >> >> >
> >> >> > Note this second problem was latent before the refcount fix above: the
> >> >> > split always failed, and the failed attempt left migrate->vma demoted,
> >> >> > so the retried fault took the PTE path, where __folio_split() unmaps
> >> >> > with TTU_SPLIT_HUGE_PMD and demotes every VMA.
> >> >> >
> >> >> > Fix it by walking the rmap and demoting every PMD sized migration entry
> >> >> > mapping the folio before splitting it. Demote with freeze = false: entry
> >> >> > creation in __split_huge_pmd_locked() is dispatched on
> >> >> > pmd_is_migration_entry(), not on freeze, so a migration PMD becomes PTE
> >> >> > sized migration entries either way, and freeze only controls a trailing
> >> >> > put_page(). With freeze = false there is no refcount change at all,
> >> >> > which makes the demotion idempotent across N VMAs.
> >> >> >
> >> >> > rmap_walk_control.anon_lock is deliberately left unset:
> >> >> > folio_lock_anon_vma_read() depends on folio_mapped(), and the folio is
> >> >> > already fully unmapped here. This mirrors remove_migration_ptes().
> >> >> >
> >> >> > Finally, refuse the split for a folio that is not anonymous. The rmap
> >> >> > walk would otherwise reach a file backed VMA, where
> >> >> > split_huge_pmd_address() zaps the PMD instead of demoting it.
> >> >> >
> >> >> > Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
> >> >> > Cc: Andrew Morton <akpm@linux-foundation.org>
> >> >> > Cc: David Hildenbrand <david@kernel.org>
> >> >> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> >> >> > Cc: Zi Yan <ziy@nvidia.com>
> >> >> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> >> > Cc: Liam R. Howlett <liam@infradead.org>
> >> >> > Cc: Nico Pache <nico.pache@linux.dev>
> >> >> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> >> > Cc: Dev Jain <dev.jain@arm.com>
> >> >> > Cc: Barry Song <baohua@kernel.org>
> >> >> > Cc: Lance Yang <lance.yang@linux.dev>
> >> >> > Cc: Usama Arif <usama.arif@linux.dev>
> >> >> > Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> >> > Cc: Rakie Kim <rakie.kim@sk.com>
> >> >> > Cc: Byungchul Park <byungchul@sk.com>
> >> >> > Cc: Gregory Price <gourry@gourry.net>
> >> >> > Cc: Ying Huang <ying.huang@linux.alibaba.com>
> >> >> > Cc: Alistair Popple <apopple@nvidia.com>
> >> >> > Cc: Balbir Singh <balbirs@nvidia.com>
> >> >> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> >> > Cc: Maxime Ripard <mripard@kernel.org>
> >> >> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> >> > Cc: David Airlie <airlied@gmail.com>
> >> >> > Cc: Simona Vetter <simona@ffwll.ch>
> >> >> > Cc: Thomas Hellstrm <thomas.hellstrom@linux.intel.com>
> >> >> > Cc: Francois Dugast <francois.dugast@intel.com>
> >> >> > Cc: dri-devel@lists.freedesktop.org
> >> >> > Cc: linux-mm@kvack.org
> >> >> > Cc: linux-kernel@vger.kernel.org
> >> >> > Cc: stable@vger.kernel.org
> >> >> > Assisted-by: GitHub_Copilot:claude-opus-5
> >> >> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> >> >> > ---
> >> >> >  mm/migrate_device.c | 98 ++++++++++++++++++++++++++++++++++++++++-----
> >> >> >  1 file changed, 89 insertions(+), 9 deletions(-)
> >> >> >
> >> >> > diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> >> > index ae9027421b80..ae17bd516d24 100644
> >> >> > --- a/mm/migrate_device.c
> >> >> > +++ b/mm/migrate_device.c
> >> >> > @@ -899,22 +899,104 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> >> >> >  	return 0;
> >> >> >  }
> >> >> >  
> >> >> > +static bool migrate_vma_split_pmd_one(struct folio *folio,
> >> >> > +				      struct vm_area_struct *vma,
> >> >> > +				      unsigned long addr, void *arg)
> >> >> > +{
> >> >> > +	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
> >> >> > +
> >> >> > +	while (page_vma_mapped_walk(&pvmw)) {
> >> >> > +		if (pvmw.pte)
> >> >> > +			continue;
> >> >> > +
> >> >> > +		addr = pvmw.address;
> >> >> > +		page_vma_mapped_walk_done(&pvmw);
> >> >> > +
> >> >> > +		/*
> >> >> > +		 * Demote with freeze = false: the PMD already holds a
> >> >> > +		 * migration entry, so __split_huge_pmd_locked() creates PTE
> >> >> > +		 * sized migration entries from it and leaves the refcount
> >> >> > +		 * alone. There is at most one PMD mapping @folio per VMA, so
> >> >> > +		 * stop the walk here.
> >> >> > +		 */
> >> >> > +		split_huge_pmd_address(vma, addr, false);
> >> >> > +		break;
> >> >> > +	}
> >> >> > +
> >> >> > +	return true;
> >> >> > +}
> >> >> > +
> >> >> > +/*
> >> >> > + * Demote every PMD sized migration entry that maps @folio to PTE sized ones.
> >> >> > + *
> >> >> > + * migrate_device_unmap() unmaps with try_to_migrate(folio, 0), i.e. without
> >> >> > + * TTU_SPLIT_HUGE_PMD, so a folio that was PMD mapped in several VMAs -- after
> >> >> > + * fork(), for instance -- ends up with a PMD sized migration entry in every one
> >> >> > + * of them. folio_split_unmapped() below does not care, it only looks at the
> >> >> > + * refcount, so splitting the folio without demoting all of those first would
> >> >> > + * leave the other VMAs pointing a huge PMD at what is now an order-0 folio.
> >> >> > + * remove_migration_ptes() trips over that in migrate_vma_finalize().
> >> >> > + */
> >> >> > +static void migrate_vma_split_pmd_mappings(struct folio *folio)
> >> >> > +{
> >> >> > +	struct rmap_walk_control rwc = {
> >> >> > +		.rmap_one = migrate_vma_split_pmd_one,
> >> >> > +	};
> >> >> > +
> >> >> > +	/*
> >> >> > +	 * Do not pass .anon_lock: folio_lock_anon_vma_read() requires
> >> >> > +	 * folio_mapped(), and @folio is already fully unmapped here.
> >> >> > +	 */
> >> >> > +	rmap_walk(folio, &rwc);
> >> >> > +}
> >> >> > +
> >> >> >  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
> >> >> > -					    unsigned long idx, unsigned long addr,
> >> >> > +					    unsigned long idx,
> >> >> >  					    struct folio *folio)
> >> >> >  {
> >> >> >  	unsigned long i;
> >> >> >  	unsigned long pfn;
> >> >> >  	unsigned long flags;
> >> >> > +	bool fault_folio;
> >> >> >  	int ret = 0;
> >> >> >  
> >> >> >  	/*
> >> >> > -	 * take a reference, since split_huge_pmd_address() with freeze = true
> >> >> > -	 * drops a reference at the end.
> >> >> > +	 * migrate_vma_split_pmd_mappings() walks the rmap, and
> >> >> > +	 * split_huge_pmd_address() zaps rather than demotes a PMD in a VMA that
> >> >> > +	 * is not anonymous. migrate_vma_collect_huge_pmd() does not check the
> >> >> > +	 * VMA type, so a file THP can reach here; the rest of the migrate_vma()
> >> >> > +	 * machinery only supports anonymous memory anyway.
> >> >> >  	 */
> >> >> > -	folio_get(folio);
> >> >> > -	split_huge_pmd_address(migrate->vma, addr, true);
> >> >> > +	if (!folio_test_anon(folio))
> >> >> > +		return -EINVAL;
> >> >> > +
> >> >> > +	/*
> >> >> > +	 * A CPU fault on a device private PMD holds an extra reference on the
> >> >> > +	 * folio, taken by do_huge_pmd_device_private(). folio_split_unmapped()
> >> >> > +	 * only tolerates a single caller reference, so the split would always
> >> >> > +	 * fail with -EAGAIN while this fault reference is held.
> >> >> > +	 *
> >> >> > +	 * do_huge_pmd_device_private() derives the fault page from the PMD
> >> >> > +	 * entry, so it is always the head page of @folio, and therefore always
> >> >> > +	 * ends up in the head folio after an uniform split to order 0. Drop
> >> >> > +	 * the reference across the split and re-take it on the head folio
> >> >> > +	 * afterwards, leaving the reference exactly where it is expected to be
> >> >> > +	 * released.
> >> >> > +	 *
> >> >> > +	 * The folio cannot go away while the reference is dropped: the
> >> >> > +	 * reference taken by migrate_vma_collect_huge_pmd() is still held.
> >> >> > +	 */
> >> >> > +	fault_folio = migrate->fault_page &&
> >> >> > +		page_folio(migrate->fault_page) == folio;
> >> >> > +
> >> >> > +	migrate_vma_split_pmd_mappings(folio);
> >> >> > +
> >> >> > +	if (fault_folio)
> >> >> > +		folio_put(folio);
> >> >> >  	ret = folio_split_unmapped(folio, 0);
> >> >> > +	if (fault_folio)
> >> >> > +		folio_get(folio);
> >> >> > +
> >> >> 
> >> >> Is it better to pass "extra_cnt" to folio_split_unmapped()?  This
> >> >> follows the coding style of the other migrate functions better, like
> >> >> that in __migrate_device_pages().
> >> >> 
> >> >
> >> > That is an option. To be minimally invasive, I went this route. I also
> >> > didn't know offhand what would happen if our head page had an extra
> >> > reference and we then called folio_split_unmapped() with "extra_cnt", or
> >> > how that would affect the reference counts of the newly split pages
> >> > (i.e., whether we would need to adjust the reference counts of all split
> >> > pages after folio_split_unmapped() returns). However, I could quickly
> >> > reason that dropping the reference and then reacquiring it was
> >> > functionally correct and safe.
> >> 
> >> This makes sense for me.  Thanks!
> >> 
> >> I have another question.  If we have to split the large folio when
> >> migrating from device to ram, should we still migrate all pages of the
> >> original large folio, or should we migrate only the faulting
> >> normal-sized page of the original large folio instead?
> >> 
> >
> > This is a choice made by the upper layers that call the migrate_vma_*
> > functions and populate the migrate_vma arguments. In gpusvm/pagemap, we
> > still migrate the entire 2 MB region of memory as 512 4 KB pages upon
> > higher order failure, matching what we did prior to having 2 MB device
> > pages.
> > 
> > The reasoning is that migrations are expensive due to the CPU overhead of
> > migrate_vma_* and because GPU copies are issued, requiring larger transfer
> > sizes to achieve the full bandwidth of the bus. For example, a 4 KB copy
> > provides less than 1 GB/s of bandwidth regardless of PCIe speed, whereas
> > a 2 MB copy can nearly reach the theoretical maximum bandwidth of PCIe.
> > 
> > Early in the development of gpusvm/pagemap, I had a knob that forced only
> > single-page 4 KB faults and migrations, along with a test case that
> > measured the fault time in user space for a 2 MB buffer. If I recall
> > correctly, it was about 58 slower than batching 512 4 KB pages together
> > into a single fault and migration on a low-end BMG part.
> >
> > So on higher order page allocation failure, the preference is still do
> > the larger migration.
> 
> Got it!  Thanks for detailed explanation!
> 
> I think that another added complexity is that we need to split the 2MB
> page table of the GPU side.
> 

That part is somewhat of an independent issue. When memory is moved, we
receive an MMU notifier that invalidates the GPU pages. Whenever we
rebind, the GPU pages are recreated based on the new memory placement,
and GPU pages of the appropriate size are populated. This part is more
or less driver- and device-specific.

Matt

> ---
> Best Regards,
> Huang, Ying
> 
> > Matt
> >
> >> ---
> >> Best Regards,
> >> Huang, Ying
> >> 
> >> > Matt
> >> >
> >> >> >  	if (ret)
> >> >> >  		return ret;
> >> >> >  	migrate->src[idx] &= ~MIGRATE_PFN_COMPOUND;
> >> >> > @@ -935,7 +1017,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> >> >> >  }
> >> >> >  
> >> >> >  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
> >> >> > -					    unsigned long idx, unsigned long addr,
> >> >> > +					    unsigned long idx,
> >> >> >  					    struct folio *folio)
> >> >> >  {
> >> >> >  	return 0;
> >> >> > @@ -1103,7 +1185,6 @@ static void __migrate_device_pages(unsigned long *src_pfns,
> >> >> >  	struct mmu_notifier_range range;
> >> >> >  	unsigned long i, j;
> >> >> >  	bool notified = false;
> >> >> > -	unsigned long addr;
> >> >> >  
> >> >> >  	for (i = 0; i < npages; ) {
> >> >> >  		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
> >> >> > @@ -1177,8 +1258,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
> >> >> >  					goto next;
> >> >> >  				}
> >> >> >  				nr = 1 << folio_order(folio);
> >> >> > -				addr = migrate->start + i * PAGE_SIZE;
> >> >> > -				if (migrate_vma_split_unmapped_folio(migrate, i, addr, folio)) {
> >> >> > +				if (migrate_vma_split_unmapped_folio(migrate, i, folio)) {
> >> >> >  					src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
> >> >> >  							 MIGRATE_PFN_COMPOUND);
> >> >> >  					goto next;
> >> >> 
> >> >> ---
> >> >> Best Regards,
> >> >> Huang, Ying
