Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE142C51D;
	Wed, 12 Aug 2026 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577619; cv=fail; b=n1+7u8VqCLSvj5jBpP9ewa7LD1UkS6dA+a0o8+B0RsNafGMv4V9WyU2IEsiNCHwQb2rflF7arR1Db3T8GNikoAv8zSVDnrvlVWM/DQTpjBLjjiWfDFHu+9utH1P0kPN48wDAiwB78R9dM6kKsOw0pZk/Lk715+s16LQxD5dMC+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577619; c=relaxed/simple;
	bh=xGn0BlALxifTIiMRRO49J8CzA+QxR9A2088o/RqJlfk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N6sxH1IasFozQiLzFSX/GD4RtgMGALZkAb2yRKGA6eh0Nu7bFGh/jN0/x1nWBoEWNhdfKHqdt3kZvnI3ZI3SjhICiVweuOC7hjaW2AsLG6jH+wAsczvlYFyYni1jAVLyuYYyG/QS5+2bU7ngdRqo87IM2R4m1ldr1/9mwak7UcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE2230Q1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE2230Q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786577617; x=1818113617;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xGn0BlALxifTIiMRRO49J8CzA+QxR9A2088o/RqJlfk=;
  b=bE2230Q1r0VtA4zmrPf+ak4z6iH3TMMLGwMa/fDx/ydbTnOtn54SgyLS
   SKfXz9aRQ4NAURpuuy0fFl4lMZvP+fVRNpp5bk23QS7wsdY7DeEr3x9P2
   +6BLoLFCR2sXHhJqRmKR4QJUst4ULIRSSJz0kUlrY7z/9GKogO39TXAZb
   yIcnQ6kDLaabqMMSLLj1tZGCknZJssUPsq3cndpJ9IJEji8EGCra2B8An
   YorUgGoyvbMkY1x/vw/LEo/GuBJ0YioqSf2qdyijEcip0bkwZ1Y4UcEUF
   YM+lzeONcyatI2psmhxpiLAEjMFx4VrlRDGtfHQLqYDsCudCB6d0MLVDm
   w==;
X-CSE-ConnectionGUID: EMKnqyegRuqzWPKhN9fM2Q==
X-CSE-MsgGUID: ZhqYrViBTCynUD7zdkQ+9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87026575"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87026575"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:33:35 -0700
X-CSE-ConnectionGUID: y/nwQdxfTbi47aI5N9oukw==
X-CSE-MsgGUID: VQ9+tAxsTp6E6Pp8hUmE2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268956318"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:33:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:33:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 16:33:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1r13i2hHcRdL0EHtoD2tbh+lFw3Tb8H4iYWXiV323MCuryAf72AOZEGU2Cpl+24vSHGgqhRtUsbzH09gRWxR0jdJMU0c3e1Cwl6fVQjLA17nvVW75+WJfmxQjztJgvAD8Y3nAjVX8MO0LjhPW/NSLThWfSS+ZypvOGhdrsXD2NK0IQkMt6ZcM6H7RyA7B3g3K6iAYLhaj4YV50w62+6fJTr68+59s+XfhsUz7z4PwGVjKN26kG8lvV+gxFwWMh6rDFn9VRW8dx5IOQQaquwYACKicOCstEAp5L0c4wGi75VHFoMF2BGgFqEE0TmSHis/Jlm8RCsCMKH9r0zRDkKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axf4jE2KIk6fTsMZSlaS3wrrsuiDw3+FEHvqzX6xtxs=;
 b=Fywv6wVbffJRXDSblawTNahMSRf0rv5diDlPKIeb1JKnEtFANGn4AAlgYAlLtdbcOK+gAtztzxxnmgyAmjHO2Y4N61vqVDRMia8BAjRI//dQmv7JTeSxE3WoU/G6DrvRfFB2Ej/2/1ZIeNe7975xc5eGb4I+JmiSb4YTVWFQCSZSoLUXrod/5A520PFgBQ2EgEibYXhigaV1wRDunYbJ8JkjewgCvPYfZtb5l9OxkUXU3/pns6yruqcKpQnVXBlgeuot6IrSHAnNRQ88FLvjrAKm9F8t//ihPjRRdvTYSCXOV8fbwpRfFtsWjS6iHQ8CtW1ym42lvD2hIo9yJP+oIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4654.namprd11.prod.outlook.com (2603:10b6:806:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 23:33:28 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 23:33:28 +0000
Date: Wed, 12 Aug 2026 16:33:24 -0700
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
Message-ID: <an0CxFPPnvPWljyp@gsse-cloud1.jf.intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
 <20260805231041.3791771-4-matthew.brost@intel.com>
 <87ik5in224.fsf@DESKTOP-5N7EMDA>
 <anopzF3Hk/RRh8kC@gsse-cloud1.jf.intel.com>
 <87cxvnn41l.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxvnn41l.fsf@DESKTOP-5N7EMDA>
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1a750c-6a1d-4f13-d493-08def8ca1c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|56012099006|10067099003|11063799006|4143699003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: Ts643CH8rZ8zQsRQozl2IX3ztY0dafOH0/dInI/yzS8h1RF6LS9+ZuEGlU/Pfr0XpVaGsYV4b5I54XQi28L4JuzHl2e47v8wgfSrNNuxHcgDXGPwKGdg2NrpL9mtE5wdQZepIwVrGA/bwhau8u/rJcnvyuiwUEa7t5H42h8CtL4ZZN/340+FGKGIMdl04r4Fupro9vN2q7T/P8yR3FVmKtocsbZY4NIIbtAgK9wovC5O3wcpCSIrGKmpxHXCkXutpb4+pIp6SjaQ2zvF/DJfLEezNNqtjXhjvRJPb0E0L8wpmmlkWsd9XdR2dLsNPP8LaC1ooyaDLKqmn9+jbQIzS+4nb9Eit5v+BCuH0w85OiDepiuW3CFMu9vTWX9oZsmYnwKG4iu8y5dzs0owmz6sMFcjw8QwgCR8lfOxtx4zTcT2BR7odI6UA55jmxElQDbV/G3c2CzVO8ZcIHjnfF8ZZagzrmCU+WFvwYyUwM3kWfemfPtL/XybuzJp9aP5RNzh3TBP859grZR3YdbDfhyg+Rx1AqSJV4Dr/YLjMEfx8Kvm7pCgdH5pmZR+cnNPa+kR40fdWOok18VXuFlQ60A3DfuoWzFlYlQo1jjDs9/BIJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HBbLeSEUQBKT/E07dwQieTm+8CGxvGjhXzkuFcC7h3dISYYxPoqy6f3W+6?=
 =?iso-8859-1?Q?hrFUFJsU/e9Y956eP3Xgok0oHdV5P5hRVz6Eqw2hTI3AyeL0/rsmEyVVQ8?=
 =?iso-8859-1?Q?KXiQs/lb1f3b/EdnzFp6qs3TpgpY4NIHpOQUN00wgOkCluVshNEyQWgFgX?=
 =?iso-8859-1?Q?cx60QySvv8C0YBvfgSZZmpf94QuavF6w/mChVIuYL2QTXPRUywl7UWdmyM?=
 =?iso-8859-1?Q?+iNmzQtwLIpAgGqk4MtJJsFR6e/Ay4tz8BP1NjhbajBGRaswOuZmq1YzQG?=
 =?iso-8859-1?Q?2lPDlboAnsCD7jsXgp2ncDsrPIoIQLgSBe4V2UhIVWN+9evm7a45tQalRN?=
 =?iso-8859-1?Q?eiSt9u7v7snOQwKSSGgAGsIWp5KSQDT2yhe8rf9n/49Y364ijie4WMjZpu?=
 =?iso-8859-1?Q?sjjQi9JB5FdUaOvssMloh5l+CMvSeZiB1xzks7JJy+g3cPLD/+muehIRxR?=
 =?iso-8859-1?Q?acUF0fudNdie3Vxjn3PTjzU/DQ0RIcMPx1HkS1e9KXuvOSB6zi03Gelkbx?=
 =?iso-8859-1?Q?OeY/zmgaP9U+VTkIQihXSV2HgXXVNGsbuLc8tmfi6dGR4COahqTzNiBbe6?=
 =?iso-8859-1?Q?3uX4fbn4IvbFa20SwzPzafTb30TupLKjiJSC7gbkkCo2EuymP5podeJNul?=
 =?iso-8859-1?Q?2P/S7n82TqRIM+zdof1WQfQpTiOqusCHkvNwY+QhZ7An8hfqxKEgPAk9BV?=
 =?iso-8859-1?Q?LSdHnSp5cWuYDxOBpwRTlnrlcoSXniyRIpMvAwA04FRwawd3/ZIpE++Cju?=
 =?iso-8859-1?Q?zCN3K2CJg0kfVC2cW91JAqQmicK5o/HIYDkHbKaQh51nBPovbyI5F5xPqT?=
 =?iso-8859-1?Q?FA+zbEdkZdAw6pNNjJCJ9ENBxSbYgqdO+EtFkU8Q4JNnEkZq12v/ASI0nd?=
 =?iso-8859-1?Q?15uqqGfOn38pbfex3UVE5woA1RqAOI3OXlxrPEwnpuGgtZ5b3fFk3M6/qK?=
 =?iso-8859-1?Q?Ye74rwyAQVbrIYM25mxorllWwRhykbHyQhhF5GdzipEdhpLd/U8Zqtt0iK?=
 =?iso-8859-1?Q?HuWVLIsRsAUejxluk9p1SxdjdHvV0S7YCJfU4duNadqwgT866DSr35pcwt?=
 =?iso-8859-1?Q?nPZ39IBD9U3zBsj1QXPgTQ6DXS576KkyH/tjkZVxEauc9VVb56SNJfMJkX?=
 =?iso-8859-1?Q?v9+3VHvD5TelWIIShBvE86kd7m3FYeFUlGA046IbBSobJUD8ESJ1gONjyZ?=
 =?iso-8859-1?Q?6UtmCw9TrZSQ8LnyEmUSyQExqzb9rLVrO80nA2u0x8jnSrBvhWpCSzwtfH?=
 =?iso-8859-1?Q?tAmDqngL3qv0//Wd1NXXyqFEK16yG9I0wBJ/Il2+x5VWJ2eI3Dkn71CoMz?=
 =?iso-8859-1?Q?sBxIA2RNwI9qdbKWW8nDFl5T83Nloy4uJIHhAsA2MdzT0Qpcd1eoCkxKFa?=
 =?iso-8859-1?Q?+tthofRfr0iTM5YreF24NIKZIAaOylfqhwG+jLucs1+LZBf9DYBmrO1NIB?=
 =?iso-8859-1?Q?ThWknZ2MjVl3BbnSDFeSNMQaRSsf3X8TOR10T4ZEY362NhZa6zhsjnfLnn?=
 =?iso-8859-1?Q?JXcjMRVZG3/Pu7bthxmh/1yl475s940tGKv87wQkvr5++Pa7OGCp1ZiLQO?=
 =?iso-8859-1?Q?NnLCOzzMk1ZUXZBErfwuOj0I8J4c8Fn9cO7/okx4BK/YL0iAfp64vQPa3T?=
 =?iso-8859-1?Q?qkOCwDlZ0mq4Kz2oG+gjiw8FP4WbiBvHCMRXsjg8agVB9npnO/AafM0T6y?=
 =?iso-8859-1?Q?Anv6Cclvn6tCDpvrUlotsKUDNVCtcKM6t8Ug6D/bt7kaq5OfZQPcc1ttIc?=
 =?iso-8859-1?Q?+L6JMvYUaZ8nysIwhsDTmOXBe0TVIRiZ3YWdq64vnxQBZTaXPZSFprhPp3?=
 =?iso-8859-1?Q?vzJhY/SDg08nYmDTWVgRbb5ZreWw86E=3D?=
X-Exchange-RoutingPolicyChecked: ZTBHpzFc75+WNc7T0ZddPpuX5R2sgipZtno8Mvya0onbXM0LirxONsl6rrKDDgV1jVffDeVy1V+Kp2erX/ZFy+U7NJShKS0mudT9aN+V7iwQ4kv7cWVFjhv5OsBcj3keBqJYoVkCN29Smui8xn1PCHd0Ng2nVd9AVYZM1gQk4Q559th8IkNPYv31xvJ1OEtjOumss2kv7ZdGKcCIdeaVQn5UcuEBSQVl8piVRSg6HrGiR0cIC9EMSwN9F8+A+tlyMOCI0SrTxbpZpdHv2hpwmsKrxdJAK4ZvQhWnBW1FcPjfga49rq+4wsPoEaw9ORnRMnA/9c7HH5WlZ63hQxdZdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1a750c-6a1d-4f13-d493-08def8ca1c7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 23:33:28.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzcnvj7uqbAEaxX97kW5aOpx7HFXajv9sHYRKZrlGl23MkHlCgd8+SuMoz4mUVr6x7tJyatMXg+YbPb7uYABBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4654
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 04:20:22PM +0800, Huang, Ying wrote:
> Matthew Brost <matthew.brost@intel.com> writes:
> 
> > On Mon, Aug 10, 2026 at 10:26:27AM +0800, Huang, Ying wrote:
> >> Hi, Matthew,
> >> 
> >> Matthew Brost <matthew.brost@intel.com> writes:
> >> 
> >> > When a CPU faults on a device private PMD and the device driver can only
> >> > allocate order-0 destination folios, __migrate_device_pages() has to
> >> > split the source THP via migrate_vma_split_unmapped_folio(). That path
> >> > is broken in two independent ways when the fault is what triggered the
> >> > migration.
> >> >
> >> > First, the split never succeeds. At the point folio_split_unmapped() is
> >> > called the folio carries two references beyond the ones it is
> >> > entitled to:
> >> >
> >> >   1 - taken by do_huge_pmd_device_private() for the duration of the
> >> >       ->migrate_to_ram() callback
> >> >   2 - taken by migrate_vma_collect_huge_pmd() when the folio was
> >> >       collected
> >> >
> >> > (the mapping reference having been dropped by set_pmd_migration_entry()).
> >> >
> >> > folio_split_unmapped() requires folio_expected_ref_count(folio) ==
> >> > folio_ref_count(folio) - 1, i.e. it tolerates exactly one caller
> >> > reference. With both of the above held the check sees 2 against an
> >> > expected 0 and returns -EAGAIN, so the migration is abandoned and the
> >> > CPU fault makes no progress.
> >> >
> >> > The PTE-based split path does not have this problem:
> >> > migrate_vma_split_folio() is called before any collect reference is
> >> > taken and explicitly skips folio_get() for the fault folio, so the fault
> >> > reference is the single caller reference the split expects.
> >> >
> >> > Fix it by dropping the fault reference across the split and re-taking it
> >> > afterwards. do_huge_pmd_device_private() derives the fault page from the
> >> > PMD entry, so it is always the head page of the folio and always ends up
> >> > in the head folio of an uniform split to order 0; re-taking the
> >> > reference on the folio therefore puts it back exactly where
> >> > do_huge_pmd_device_private() will release it. The folio cannot be freed
> >> > while the reference is dropped because the collect reference is still
> >> > held.
> >> >
> >> > Second, the folio is split globally but the page tables were demoted
> >> > only locally:
> >> >
> >> > 	split_huge_pmd_address(migrate->vma, addr, true);
> >> > 	ret = folio_split_unmapped(folio, 0);
> >> >
> >> > migrate_device_unmap() unmaps via try_to_migrate(folio, 0), deliberately
> >> > without TTU_SPLIT_HUGE_PMD, so every VMA that PMD maps the folio is left
> >> > holding a PMD sized migration entry. A folio that was PMD mapped in more
> >> > than one VMA -- after fork(), for example -- therefore keeps huge
> >> > migration entries in all the other VMAs while only migrate->vma is
> >> > demoted.
> >> >
> >> > folio_split_unmapped() does not notice: the folio is fully unmapped, so
> >> > it only looks at the refcount and happily splits to order 0. The other
> >> > VMAs are then left pointing a huge PMD at an order-0 folio, and
> >> > migrate_vma_finalize() -> remove_migration_ptes() walks into it:
> >> >
> >> >   page dumped because: VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
> >> >                                        !folio_test_pmd_mappable(folio))
> >> >   kernel BUG at mm/migrate.c:368!
> >> >   RIP: 0010:remove_migration_pte+0x56a/0x9b0
> >> >   Call Trace:
> >> >    rmap_walk_anon+0xfc/0x260
> >> >    remove_migration_ptes+0x79/0xb0
> >> >    __migrate_device_finalize+0x113/0x290
> >> >    __drm_pagemap_migrate_to_ram+0x278/0x360 [drm_gpusvm_helper]
> >> >    drm_pagemap_migrate_to_ram+0x5c/0x80 [drm_gpusvm_helper]
> >> >    do_huge_pmd_device_private+0x160/0x280
> >> 
> >> Which is the branch your patchset based on?  I found that
> >> drm_pagemap_migrate_populate_ram_pfn() in mm-everything-2026-08-08-07-08
> >> still don't support fallback to single pages if THP allocation fails as
> >> in the following comments,
> >> 
> >
> > This entire series, on drm-tip (i.e., the 6 patches posted here [1]).
> >
> > [1] https://patchwork.freedesktop.org/series/171651/
> 
> Thanks!
> 
> >> 	/* TODO: Support fallback to single pages if THP allocation fails */
> >> 
> >> 
> >> > Without CONFIG_DEBUG_VM the VM_BUG_ON_FOLIO() is compiled out and
> >> > remove_migration_pmd() installs a huge PMD pointing at an order-0 page
> >> > instead, along with add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR). The
> >> > victim mm then maps 2MB of address space onto a single 4K page, which
> >> > shows up later as bad rss-counter state, leaked page tables and page
> >> > allocator freelist corruption in unrelated processes.
> >> >
> >> > Note this second problem was latent before the refcount fix above: the
> >> > split always failed, and the failed attempt left migrate->vma demoted,
> >> > so the retried fault took the PTE path, where __folio_split() unmaps
> >> > with TTU_SPLIT_HUGE_PMD and demotes every VMA.
> >> >
> >> > Fix it by walking the rmap and demoting every PMD sized migration entry
> >> > mapping the folio before splitting it. Demote with freeze = false: entry
> >> > creation in __split_huge_pmd_locked() is dispatched on
> >> > pmd_is_migration_entry(), not on freeze, so a migration PMD becomes PTE
> >> > sized migration entries either way, and freeze only controls a trailing
> >> > put_page(). With freeze = false there is no refcount change at all,
> >> > which makes the demotion idempotent across N VMAs.
> >> >
> >> > rmap_walk_control.anon_lock is deliberately left unset:
> >> > folio_lock_anon_vma_read() depends on folio_mapped(), and the folio is
> >> > already fully unmapped here. This mirrors remove_migration_ptes().
> >> >
> >> > Finally, refuse the split for a folio that is not anonymous. The rmap
> >> > walk would otherwise reach a file backed VMA, where
> >> > split_huge_pmd_address() zaps the PMD instead of demoting it.
> >> >
> >> > Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
> >> > Cc: Andrew Morton <akpm@linux-foundation.org>
> >> > Cc: David Hildenbrand <david@kernel.org>
> >> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> >> > Cc: Zi Yan <ziy@nvidia.com>
> >> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> > Cc: Liam R. Howlett <liam@infradead.org>
> >> > Cc: Nico Pache <nico.pache@linux.dev>
> >> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> > Cc: Dev Jain <dev.jain@arm.com>
> >> > Cc: Barry Song <baohua@kernel.org>
> >> > Cc: Lance Yang <lance.yang@linux.dev>
> >> > Cc: Usama Arif <usama.arif@linux.dev>
> >> > Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> > Cc: Rakie Kim <rakie.kim@sk.com>
> >> > Cc: Byungchul Park <byungchul@sk.com>
> >> > Cc: Gregory Price <gourry@gourry.net>
> >> > Cc: Ying Huang <ying.huang@linux.alibaba.com>
> >> > Cc: Alistair Popple <apopple@nvidia.com>
> >> > Cc: Balbir Singh <balbirs@nvidia.com>
> >> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> > Cc: Maxime Ripard <mripard@kernel.org>
> >> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> > Cc: David Airlie <airlied@gmail.com>
> >> > Cc: Simona Vetter <simona@ffwll.ch>
> >> > Cc: Thomas Hellstrm <thomas.hellstrom@linux.intel.com>
> >> > Cc: Francois Dugast <francois.dugast@intel.com>
> >> > Cc: dri-devel@lists.freedesktop.org
> >> > Cc: linux-mm@kvack.org
> >> > Cc: linux-kernel@vger.kernel.org
> >> > Cc: stable@vger.kernel.org
> >> > Assisted-by: GitHub_Copilot:claude-opus-5
> >> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> >> > ---
> >> >  mm/migrate_device.c | 98 ++++++++++++++++++++++++++++++++++++++++-----
> >> >  1 file changed, 89 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> > index ae9027421b80..ae17bd516d24 100644
> >> > --- a/mm/migrate_device.c
> >> > +++ b/mm/migrate_device.c
> >> > @@ -899,22 +899,104 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> >> >  	return 0;
> >> >  }
> >> >  
> >> > +static bool migrate_vma_split_pmd_one(struct folio *folio,
> >> > +				      struct vm_area_struct *vma,
> >> > +				      unsigned long addr, void *arg)
> >> > +{
> >> > +	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
> >> > +
> >> > +	while (page_vma_mapped_walk(&pvmw)) {
> >> > +		if (pvmw.pte)
> >> > +			continue;
> >> > +
> >> > +		addr = pvmw.address;
> >> > +		page_vma_mapped_walk_done(&pvmw);
> >> > +
> >> > +		/*
> >> > +		 * Demote with freeze = false: the PMD already holds a
> >> > +		 * migration entry, so __split_huge_pmd_locked() creates PTE
> >> > +		 * sized migration entries from it and leaves the refcount
> >> > +		 * alone. There is at most one PMD mapping @folio per VMA, so
> >> > +		 * stop the walk here.
> >> > +		 */
> >> > +		split_huge_pmd_address(vma, addr, false);
> >> > +		break;
> >> > +	}
> >> > +
> >> > +	return true;
> >> > +}
> >> > +
> >> > +/*
> >> > + * Demote every PMD sized migration entry that maps @folio to PTE sized ones.
> >> > + *
> >> > + * migrate_device_unmap() unmaps with try_to_migrate(folio, 0), i.e. without
> >> > + * TTU_SPLIT_HUGE_PMD, so a folio that was PMD mapped in several VMAs -- after
> >> > + * fork(), for instance -- ends up with a PMD sized migration entry in every one
> >> > + * of them. folio_split_unmapped() below does not care, it only looks at the
> >> > + * refcount, so splitting the folio without demoting all of those first would
> >> > + * leave the other VMAs pointing a huge PMD at what is now an order-0 folio.
> >> > + * remove_migration_ptes() trips over that in migrate_vma_finalize().
> >> > + */
> >> > +static void migrate_vma_split_pmd_mappings(struct folio *folio)
> >> > +{
> >> > +	struct rmap_walk_control rwc = {
> >> > +		.rmap_one = migrate_vma_split_pmd_one,
> >> > +	};
> >> > +
> >> > +	/*
> >> > +	 * Do not pass .anon_lock: folio_lock_anon_vma_read() requires
> >> > +	 * folio_mapped(), and @folio is already fully unmapped here.
> >> > +	 */
> >> > +	rmap_walk(folio, &rwc);
> >> > +}
> >> > +
> >> >  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
> >> > -					    unsigned long idx, unsigned long addr,
> >> > +					    unsigned long idx,
> >> >  					    struct folio *folio)
> >> >  {
> >> >  	unsigned long i;
> >> >  	unsigned long pfn;
> >> >  	unsigned long flags;
> >> > +	bool fault_folio;
> >> >  	int ret = 0;
> >> >  
> >> >  	/*
> >> > -	 * take a reference, since split_huge_pmd_address() with freeze = true
> >> > -	 * drops a reference at the end.
> >> > +	 * migrate_vma_split_pmd_mappings() walks the rmap, and
> >> > +	 * split_huge_pmd_address() zaps rather than demotes a PMD in a VMA that
> >> > +	 * is not anonymous. migrate_vma_collect_huge_pmd() does not check the
> >> > +	 * VMA type, so a file THP can reach here; the rest of the migrate_vma()
> >> > +	 * machinery only supports anonymous memory anyway.
> >> >  	 */
> >> > -	folio_get(folio);
> >> > -	split_huge_pmd_address(migrate->vma, addr, true);
> >> > +	if (!folio_test_anon(folio))
> >> > +		return -EINVAL;
> >> > +
> >> > +	/*
> >> > +	 * A CPU fault on a device private PMD holds an extra reference on the
> >> > +	 * folio, taken by do_huge_pmd_device_private(). folio_split_unmapped()
> >> > +	 * only tolerates a single caller reference, so the split would always
> >> > +	 * fail with -EAGAIN while this fault reference is held.
> >> > +	 *
> >> > +	 * do_huge_pmd_device_private() derives the fault page from the PMD
> >> > +	 * entry, so it is always the head page of @folio, and therefore always
> >> > +	 * ends up in the head folio after an uniform split to order 0. Drop
> >> > +	 * the reference across the split and re-take it on the head folio
> >> > +	 * afterwards, leaving the reference exactly where it is expected to be
> >> > +	 * released.
> >> > +	 *
> >> > +	 * The folio cannot go away while the reference is dropped: the
> >> > +	 * reference taken by migrate_vma_collect_huge_pmd() is still held.
> >> > +	 */
> >> > +	fault_folio = migrate->fault_page &&
> >> > +		page_folio(migrate->fault_page) == folio;
> >> > +
> >> > +	migrate_vma_split_pmd_mappings(folio);
> >> > +
> >> > +	if (fault_folio)
> >> > +		folio_put(folio);
> >> >  	ret = folio_split_unmapped(folio, 0);
> >> > +	if (fault_folio)
> >> > +		folio_get(folio);
> >> > +
> >> 
> >> Is it better to pass "extra_cnt" to folio_split_unmapped()?  This
> >> follows the coding style of the other migrate functions better, like
> >> that in __migrate_device_pages().
> >> 
> >
> > That is an option. To be minimally invasive, I went this route. I also
> > didn't know offhand what would happen if our head page had an extra
> > reference and we then called folio_split_unmapped() with "extra_cnt", or
> > how that would affect the reference counts of the newly split pages
> > (i.e., whether we would need to adjust the reference counts of all split
> > pages after folio_split_unmapped() returns). However, I could quickly
> > reason that dropping the reference and then reacquiring it was
> > functionally correct and safe.
> 
> This makes sense for me.  Thanks!
> 
> I have another question.  If we have to split the large folio when
> migrating from device to ram, should we still migrate all pages of the
> original large folio, or should we migrate only the faulting
> normal-sized page of the original large folio instead?
> 

This is a choice made by the upper layers that call the migrate_vma_*
functions and populate the migrate_vma arguments. In gpusvm/pagemap, we
still migrate the entire 2 MB region of memory as 512 4 KB pages upon
higher order failure, matching what we did prior to having 2 MB device
pages.
 
The reasoning is that migrations are expensive due to the CPU overhead of
migrate_vma_* and because GPU copies are issued, requiring larger transfer
sizes to achieve the full bandwidth of the bus. For example, a 4 KB copy
provides less than 1 GB/s of bandwidth regardless of PCIe speed, whereas
a 2 MB copy can nearly reach the theoretical maximum bandwidth of PCIe.
 
Early in the development of gpusvm/pagemap, I had a knob that forced only
single-page 4 KB faults and migrations, along with a test case that
measured the fault time in user space for a 2 MB buffer. If I recall
correctly, it was about 58× slower than batching 512 4 KB pages together
into a single fault and migration on a low-end BMG part.

So on higher order page allocation failure, the preference is still do
the larger migration.

Matt

> ---
> Best Regards,
> Huang, Ying
> 
> > Matt
> >
> >> >  	if (ret)
> >> >  		return ret;
> >> >  	migrate->src[idx] &= ~MIGRATE_PFN_COMPOUND;
> >> > @@ -935,7 +1017,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> >> >  }
> >> >  
> >> >  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
> >> > -					    unsigned long idx, unsigned long addr,
> >> > +					    unsigned long idx,
> >> >  					    struct folio *folio)
> >> >  {
> >> >  	return 0;
> >> > @@ -1103,7 +1185,6 @@ static void __migrate_device_pages(unsigned long *src_pfns,
> >> >  	struct mmu_notifier_range range;
> >> >  	unsigned long i, j;
> >> >  	bool notified = false;
> >> > -	unsigned long addr;
> >> >  
> >> >  	for (i = 0; i < npages; ) {
> >> >  		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
> >> > @@ -1177,8 +1258,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
> >> >  					goto next;
> >> >  				}
> >> >  				nr = 1 << folio_order(folio);
> >> > -				addr = migrate->start + i * PAGE_SIZE;
> >> > -				if (migrate_vma_split_unmapped_folio(migrate, i, addr, folio)) {
> >> > +				if (migrate_vma_split_unmapped_folio(migrate, i, folio)) {
> >> >  					src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
> >> >  							 MIGRATE_PFN_COMPOUND);
> >> >  					goto next;
> >> 
> >> ---
> >> Best Regards,
> >> Huang, Ying
