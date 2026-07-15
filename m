Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886CB43F084;
	Wed, 15 Jul 2026 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141524; cv=fail; b=Fe01yPBdousI+ePAS0XKMcoLFNpSpHa/uRBODWUpLvsd7pIxM8xsepr3ntN9eKoeBICPNkd0/lPKTr0VdS458jikPOR0EO4OnRmsHDG/Q3MvuElOwsqHxe82F3KNbGoMYwF+NuRtN/mpH1olVk3sEWKiOm2vlXntQetU36RRbO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141524; c=relaxed/simple;
	bh=qb4TPoJc+s0eVn4JWYYJwrjh/fbkln7slunfTMzeE4Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cG5YeowlzXjwhCid8DDynB1YedVf42lLAOGlrRKyT0CXeodZ5Z1a3c5yOz3gcFEEC8JsGTc2RepaMzMjivaTvLPxlanQ9w74KgyIb1B105U206sT10kGEPxlahed6Y5k3sUqxLWrAQX4muev88x79I2BVdMHpDc7lG/o335ukBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIWoQJBU; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIWoQJBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784141520; x=1815677520;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qb4TPoJc+s0eVn4JWYYJwrjh/fbkln7slunfTMzeE4Y=;
  b=cIWoQJBUBNqVC4PYj90FFLz7+VDvFVWRImjHOxJKCwbvkgPjJkasbePJ
   7bIMpMd0Y8uXiC+OqqHJqq1ccGyVKh08HOwsvUGXUzYJd14EzeGNUBEIm
   pUcNVPwHAoJ7fkfmcL1uze1tJaF82031QsukRVIyKjNXrtTwI4QC8Qbjy
   GK4vyBuBmsy0J8PFC5ywfieuWEwDqpjg2RDv7p0iD/SnKSOCqwj4GYLEj
   Mj8Jy/I3SKynm/XH4wGOZZJ1ErUUciJLl7zcQFD4iZLOoFEY4tahCqsCk
   ADwEoBDXS6oOSfSb8Uire0TZ7pTmV5BLBvg68jVVpuKfqJd5Sp/R6JCKU
   g==;
X-CSE-ConnectionGUID: 2XG3nRl+TuqZCb62Br0CAA==
X-CSE-MsgGUID: 5n1w7v2JRQa8E+s91ODJVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88699136"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88699136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:51:58 -0700
X-CSE-ConnectionGUID: LJqk5UcsSeaLD5SZL8zUMQ==
X-CSE-MsgGUID: qVn21aybRF+JYEpFgoAH7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="253660591"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:51:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 11:51:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 11:51:57 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 11:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR5EhKnMV8JDa9KoJxbGXK+DP+exnVcTT0wxvxJEusnywyg/pNNEkzGnDHZnzGL8jFKRh7jJTeQPPQCAFZ4+LUcuHXcyZS8iDWX+u7OeBETsybkYox12GIycx4vOYw7JKNh+LaQu4TnWsGnc1Ya6Pqz0hWq04fhCecAj6wVaUk6oZFjFBG1CayJcE6swiPhZTKmKLcsmEVl9Fhr2nvZMjv3WOTe6oYao4tDuYbnwvfZMKpSPM3TOKzWTbaFFMTyUFd5g2cYi+AlJ0mSVRqcxAAi1YfGIU1VSnecOgps8fUxUYLHX97GtErqXJeT6HUx5lXnXPsP3UlQaFhlRvFIGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSeq+CNbQX0Wsbj14r81vjRR138NjGleeI0AJsT1wZw=;
 b=M7o7U95PH9gPqXc7t2/97uR9NwNJDlUrOo4lQpCuQLCZ9QNkBjg2Fc6+zflp4rzVBAwrLXHpdxZCKYoLxfy6IJBD3y2R/3GW6xG7Fr7/tO2ApcUhKoXJvSipqpPXGqbRVE6/iaaFOcOBflv9HIIvOcGAORcTudVCbO4+nhFIUiqwBq9pvhDyMmE+E6v+skzEAkztRSruZdVaN6ex5bHwmXMQqvMAcbY314fvNAEPsTLm+WewGl51PN2qPy5Nk5nfiV7RcD0Mt1W1VuL4fzdSUiz97L0QiKEFUZvWZXGfBgqc2xPwQn3s8oJRLCKz52cAz/Q/bXGtKGiH6cxgyw8pWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:51:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 18:51:50 +0000
Date: Wed, 15 Jul 2026 11:51:47 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v7] drm/ttm/pool: back up at native page order
Message-ID: <alfWw2PJVFHSOGqy@gsse-cloud1.jf.intel.com>
References: <20260715080058.3794385-1-matthew.brost@intel.com>
 <f58b1d99-6485-4ef7-8a5f-c63e6fad9ba8@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f58b1d99-6485-4ef7-8a5f-c63e6fad9ba8@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4516543d-91ee-4b35-b583-08dee2a22171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|10067099003|6133799003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +HRPDrhlEDW7EkG5KV/mbdkGiEpMNFieJy4ceI5AfGLoUdpE4GqyBUaxPB0W1lQfBa+Jwbi7HSryxqSxTT2fY49UxzCSXJODXihaxiChWHvpXvYWDIH34F1JD/vuOho+/4UapRv4Alq4noa+LQRZcQLSrhxQ0Amr6W+0S9ft7L3V0vC8xp+pEd66dRJslJ6eV9PZUNxNUFM88/o39X9f+YZv1qKDFjNOQMNXHu2CFhYZMMtlYGogaY6IrRAwdUtmMm9l4VjIW8DJ/Rhk6hodlUluB+cFgskTPMy0gtJ9sEeJPFqPRa1bB1a08ajbOy1rdVmqFG7LqD1I1SPOYIB4C84I96zcIujwDgXIwSTtzrdC+hR9E4uhAyL3S/DfkJlo/VX5virBjvaonVJHPHT6ypch8LP3B/7sNkYxymb0X0ycUa/gNl392nAeM+CHMAi8CFmmA7/fnhjNFTVNIcCjakVew72brs9WhEG2eXX1Eu8kYL77M99pfz1tP8e9SW6+9eo4QTZhiAYCxNU0HOFynOcBkPc+3/jHHDpfaCM6NDc/5HFWgZ1skvYbGrzmuJ7TD6Cawjn/ipiNZqCmORmlPYROIIbadVOk7alOXaHGNWv0N8IQGLZYJ/kdUhIKOiy5FZsnROtxvi2N3NpUrNuaIEwXtSBIc70vZNNbcRP597s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LM2+eNu+HL35SxbZXI0wGCUuFtR/fWrj+C5MYjEqSvTgJi+1awXG3o6DxI?=
 =?iso-8859-1?Q?n/uV/D506Loo9NV+ssNbgaK9KL3zvP87G2E+P/QnlXobTvnSN6q6RNMqrg?=
 =?iso-8859-1?Q?0l/OMw7O9atG2sI07XD94pq3cpHSPe9WnMHgO6m3ZmK99Ril5kimrjiLob?=
 =?iso-8859-1?Q?YK67PqTTlxvRnHp/Sv+G9RFopilUl12FTjZj/6J/L35t60lWm7hnG6QEjz?=
 =?iso-8859-1?Q?sg37ElaAHy/tUnS9t54wGCNyzOD2JxQQ9FXwCkOEYOext0dJTT7DvrZtbk?=
 =?iso-8859-1?Q?1kP8ghj08h9nhWvUmZyGk4enbygGsjlKHj67Nu1kFlOEAQ/dTskolnvnDx?=
 =?iso-8859-1?Q?vn6I/H1di8T8DFwCscdZ7DnzZ+ywMran7HAidX77aOSH6y6h934V+EGju9?=
 =?iso-8859-1?Q?3mp8eZz13I2eTGAKKnaKaC0DGoB6aiPa62AUnvIg6yGrz0Oqx3kABRNEKR?=
 =?iso-8859-1?Q?UfUsI1sJsb02u1X1BpjTc+S2zE58wPY9ZGJQx0r2pN8J349tGdQk0JNhUH?=
 =?iso-8859-1?Q?RfN+5y/IBjY+Ovp2sL7XnBjSIy5427hUkReexi8Bw7dHPhdyxE4XPZvzrC?=
 =?iso-8859-1?Q?jr8Gq/bqJ8KBZ6rl6Ym0SO2EzNFZLIy6dlhEOhCUgwdc1UgRDI7cUAHFoA?=
 =?iso-8859-1?Q?ExiKidRA4FqbEPYA9GG/5s6T7T9SDPU0xWNHMB/3kG72hNOEGRBZ6AavWn?=
 =?iso-8859-1?Q?xSDmBPMJUi81k/N4Lc4z+IxGs+KkSBcbEIgF+9IgIY7TLMoUMGDX6UukBG?=
 =?iso-8859-1?Q?KCMt6DU9ecLh/yROYrvlJhRV70TMTl9N+ISzeCb8REXkW2I0WfiIQg9Iw4?=
 =?iso-8859-1?Q?j1LZLgVeNBqxibqSpHFTQaOHjPRlF5lmbXrhH7yCkzCeF2bWnrme225M5b?=
 =?iso-8859-1?Q?Myaw2Gou1WGAuyNghYqL8CJj1FU9qTn+eZeXvaRLc4Ul9X69usqoYV/iFO?=
 =?iso-8859-1?Q?dbAnOC3IWgM78Ik6fW9kU2sXhbnVkO7sbPWRy5BdBpwS4IC7Y+DKD3cjIi?=
 =?iso-8859-1?Q?FRbZD4ReXKCpfPCsorkJakq+CzPoATtgWNegqHYAAU9LKYao7c5hAywZdy?=
 =?iso-8859-1?Q?qtHiqnLvw3GQmpyAKOjnC1vmP2bzM3JP/uVPbNqQKulp/l+T7aHcs7tsmX?=
 =?iso-8859-1?Q?2z8f81CRDT8ZUXn72L8lq7cjYXBSXAjL9AHfISBmiAySYKSa+aDZRJRqlU?=
 =?iso-8859-1?Q?PBapcBfukGFoSq8G2cG9n1vQNFVO9VkPLqED9HBCQu1+GEasgxa9Wx1p3c?=
 =?iso-8859-1?Q?42S70HLYBf3shXJBlU/ac+uPlmnmt8/cxHGYYXL6gRlHiAppJqmUQ3aqoJ?=
 =?iso-8859-1?Q?AOH4Ctgz1JmNznUCIeqwwB3KuTaTqApSMQ7UF1lqmDjQOvdfkD5xm34iJX?=
 =?iso-8859-1?Q?3X3ocqRDEo1BZUzBFqbMxb8UD1o5xr/TwKHo3fo07KiaptUM8XjzMgazC3?=
 =?iso-8859-1?Q?/DLfBioymlBRT1mu0aIWcGCdpzfKrSAdwGwQ95tn24usmCkiMI0WYjSkjs?=
 =?iso-8859-1?Q?gkNTN6IGk4iB8lfe/YTThRGJ8gVt1u90v0DqF3gRitl9rJWk19F7F9re/z?=
 =?iso-8859-1?Q?8JZsaKaFhddjWllGujqnq6Ja9rJtsGYh36b88x1ttdPl6k0b1vlN3JQ9p4?=
 =?iso-8859-1?Q?aV7D+IQv6E+D55w7tXsnxsW/Je065NlPLROlFfTcpJiCSCILFdeuuXexqF?=
 =?iso-8859-1?Q?xBD/WtFZf0Bq9GVXZPh8iFoTnFvY+0eGhpp2mgVF0ENvIPtSv6qXzaWICL?=
 =?iso-8859-1?Q?GZP1edkMMs9n73MVMd0QFqxn/sQrNbNcbkwh0a5KYRyWIjkSId9zlxu5fa?=
 =?iso-8859-1?Q?hk/dd3Xazw=3D=3D?=
X-Exchange-RoutingPolicyChecked: fEHa/yY2lp+7K+dXL/udsV4XGh2janMibZTjwnICIzGVDR6kSCOd64UeoElNPZgkQdSPc8IV9G2m03+z0o9fK9BF7a650FIIcUJix7xU5CRECICPQ5B1uZ/wkbOAJYlUjeDCo0irqAbmJuRPNmE9eSSO2EJDtmo0w7JDPxVGIK8vmNy02c7j1oKrgomCnaoPRk1W5HcO7JTg3Z3tSL7Vff0bsx9vsPaxGTIODTMYmBeuNw+kavcNSX5QHtwYXtGTgG4b/d87/sBD/oZ1/HCDGOD3IIsDeWgCUSDmLp1B2wBeoCgQjBUoSNwrcsOfUF82H85KqTtz3gUtNjV6ObjNPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4516543d-91ee-4b35-b583-08dee2a22171
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:51:50.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVh4cirMKDvWZiz013qOf2LpjqnQ/Y2LKxRCm1fR0j+pMv/tdLPtlQq3FlfWbWXIF/I4abbfAfKTlXr2PSL2Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com

On Wed, Jul 15, 2026 at 06:13:30PM +0200, Thomas Hellström wrote:
> 
> On 7/15/26 10:00, Matthew Brost wrote:
> > ttm_pool_split_for_swap() unconditionally splits high-order pool pages
> > into order-0 pages before backup, so every compound the shrinker
> > touches is shattered even when the rest of the system would prefer it
> > stay intact. Under sustained kswapd pressure this fragments memory
> > enough to drive other parts of MM into recovery loops.
> > 
> > Back up each compound at its native order instead. In
> > ttm_pool_backup(), hand the full compound to the new
> > ttm_backup_backup_folio(), which backs up subpages to a contiguous
> > range of shmem indices and returns the base handle plus the number of
> > subpages actually backed up (@nr_backed). On full success, free the
> > compound once at its native order -- no split_page(), no per-4K
> > refcount juggling.
> > 
> > A per-folio backup can't be made fully atomic under memory pressure:
> > ttm_backup_backup_folio() must allocate shmem folios before source
> > subpages can be released, so under true OOM any subpage may fail
> > while the rest of the compound is still live. Two mechanisms handle
> > this without regressing reclaim behaviour:
> > 
> >    - alloc_gfp gets __GFP_NOMEMALLOC whenever order > 0 (cleared again
> >      for order-0), so a high-order backup fails fast with -ENOMEM
> >      instead of draining kernel reserves, leaving them for other
> >      allocations under the same pressure.
> > 
> >    - If ttm_backup_backup_folio() still returns a short @nr_backed with
> >      a valid handle for the successfully-backed prefix, split the
> >      source compound with ttm_pool_split_for_swap(), free the prefix as
> >      order-0 pages (already safely in shmem), and retry the remaining
> >      subpages at order 0, where __GFP_NOMEMALLOC is cleared and
> >      reserves may be used as a last resort.
> > 
> > This preserves the original split-on-OOM fallback while keeping the
> > common case fragmentation-free, and preserves the "partial backup is
> > allowed" contract (shrunken is incremented per subpage backed up).
> > 
> > The restore-side leftover-page split in ttm_pool_restore_commit() is
> > left as-is: it's unreachable in practice and not worth complicating
> > the restore state machine to avoid.
> > 
> > Testing: the existing backup_fault_inject point only truncated
> > tt->num_pages, which never exercised the reactive split path above
> > since it never left a compound partially backed up. Wire fault
> > injection into ttm_backup_backup_folio() itself: past the first
> > subpage of a compound, synthesize a -ENOMEM in place of
> > shmem_read_folio_gfp() when should_fail() trips, producing the same
> > short @nr_pages_backed a real failure would and forcing
> > ttm_pool_backup() through the split-and-retry path. The fault_attr
> > stays private to ttm_pool.c; ttm_backup.c reaches it through
> > ttm_backup_fault_inject_folio(), declared in ttm_pool_internal.h.
> > 
> > While converting the writeback branch to operate on the whole folio,
> > the unlock condition after shmem_writeout() also changed from `if
> > (ret)` to `if (ret == AOP_WRITEPAGE_ACTIVATE)`, matching the actual
> > contract: shmem_writeout()/swap_writeout() only leave the folio locked
> > when returning AOP_WRITEPAGE_ACTIVATE; any other return (including a
> > hard error from arch_prepare_to_swap()) means the folio was already
> > unlocked internally. The old `if (ret)` check would have double-
> > unlocked in that hard-error case.
> > 
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
> > Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >   drivers/gpu/drm/ttm/ttm_backup.c        | 138 +++++++++++++++---------
> >   drivers/gpu/drm/ttm/ttm_pool.c          |  89 ++++++++++++---
> >   drivers/gpu/drm/ttm/ttm_pool_internal.h |   8 ++
> >   include/drm/ttm/ttm_backup.h            |  12 +--
> >   4 files changed, 178 insertions(+), 69 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
> > index 81df4cb5606b..a8f0b12c86d2 100644
> > --- a/drivers/gpu/drm/ttm/ttm_backup.c
> > +++ b/drivers/gpu/drm/ttm/ttm_backup.c
> > @@ -6,23 +6,25 @@
> >   #include <drm/ttm/ttm_backup.h>
> >   #include <linux/export.h>
> > -#include <linux/page-flags.h>
> >   #include <linux/swap.h>
> > +#include "ttm_pool_internal.h"
> > +
> >   /*
> >    * Need to map shmem indices to handle since a handle value
> >    * of 0 means error, following the swp_entry_t convention.
> >    */
> > -static unsigned long ttm_backup_shmem_idx_to_handle(pgoff_t idx)
> > -{
> > -	return (unsigned long)idx + 1;
> > -}
> >   static pgoff_t ttm_backup_handle_to_shmem_idx(pgoff_t handle)
> >   {
> >   	return handle - 1;
> >   }
> > +static unsigned long ttm_backup_shmem_idx_to_handle(pgoff_t idx)
> > +{
> > +	return (unsigned long)idx + 1;
> > +}
> > +
> 
> This seems like an unrelated change?
> 

Yes, let me drop this.

> 
> >   /**
> >    * ttm_backup_drop() - release memory associated with a handle
> >    * @backup: The struct backup pointer used to obtain the handle
> > @@ -68,17 +70,23 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
> >   }
> >   /**
> > - * ttm_backup_backup_page() - Backup a page
> > + * ttm_backup_backup_folio() - Backup a folio
> >    * @backup: The struct backup pointer to use.
> > - * @page: The page to back up.
> > - * @writeback: Whether to perform immediate writeback of the page.
> > + * @folio: The folio to back up.
> > + * @order: The allocation order of @folio.  Since TTM allocates higher-order
> > + *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
> > + *         return 1; the caller must pass the true order explicitly.
> > + * @writeback: Whether to perform immediate writeback of the folio's pages.
> >    * This may have performance implications.
> > - * @idx: A unique integer for each page and each struct backup.
> > + * @idx: A unique integer for the first page of the folio and each struct backup.
> >    * This allows the backup implementation to avoid managing
> >    * its address space separately.
> > - * @page_gfp: The gfp value used when the page was allocated.
> > - * This is used for accounting purposes.
> > + * @folio_gfp: The gfp value used when the folio was allocated.
> > + * Currently unused.
> >    * @alloc_gfp: The gfp to be used when allocating memory.
> > + * @nr_pages_backed: Output. On a successful return, set to the number of
> > + * pages actually backed up, which may be less than (1 << @order)
> > + * if an -ENOMEM was encountered mid-folio.
> >    *
> >    * Context: If called from reclaim context, the caller needs to
> >    * assert that the shrinker gfp has __GFP_FS set, to avoid
> > @@ -87,53 +95,87 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
> >    * that the shrinker gfp has __GFP_IO set, since without it,
> >    * we're not allowed to start backup IO.
> >    *
> > - * Return: A handle on success. Negative error code on failure.
> > - *
> > - * Note: This function could be extended to back up a folio and
> > - * implementations would then split the folio internally if needed.
> > - * Drawback is that the caller would then have to keep track of
> > - * the folio size- and usage.
> > + * Return: A handle for the first backed-up page on success (handles for
> > + * subsequent pages follow sequentially). -ENOMEM if no pages could be backed
> > + * up. Any other negative error code if a non-ENOMEM failure occurred; in that
> > + * case any pages backed up so far are truncated before returning.
> >    */
> >   s64
> > -ttm_backup_backup_page(struct file *backup, struct page *page,
> > -		       bool writeback, pgoff_t idx, gfp_t page_gfp,
> > -		       gfp_t alloc_gfp)
> > +ttm_backup_backup_folio(struct file *backup, struct folio *folio,
> > +			unsigned int order, bool writeback, pgoff_t idx,
> > +			gfp_t folio_gfp, gfp_t alloc_gfp,
> > +			pgoff_t *nr_pages_backed)
> >   {
> >   	struct address_space *mapping = backup->f_mapping;
> > -	unsigned long handle = 0;
> > +	int nr_pages = 1 << order;
> >   	struct folio *to_folio;
> > -	int ret;
> > -
> > -	to_folio = shmem_read_folio_gfp(mapping, idx, alloc_gfp);
> > -	if (IS_ERR(to_folio))
> > -		return PTR_ERR(to_folio);
> > -
> > -	folio_mark_accessed(to_folio);
> > -	folio_lock(to_folio);
> > -	folio_mark_dirty(to_folio);
> > -	copy_highpage(folio_file_page(to_folio, idx), page);
> > -	handle = ttm_backup_shmem_idx_to_handle(idx);
> > -
> > -	if (writeback && !folio_mapped(to_folio) &&
> > -	    folio_clear_dirty_for_io(to_folio)) {
> > -		folio_set_reclaim(to_folio);
> > -		ret = shmem_writeout(to_folio, NULL, NULL);
> > -		if (!folio_test_writeback(to_folio))
> > -			folio_clear_reclaim(to_folio);
> > +	int ret, i;
> > +
> > +	*nr_pages_backed = 0;
> > +
> > +	for (i = 0; i < nr_pages; ) {
> > +		int to_nr, j;
> > +
> >   		/*
> > -		 * If writeout succeeds, it unlocks the folio.	errors
> > -		 * are otherwise dropped, since writeout is only best
> > -		 * effort here.
> > +		 * Only inject past the first subpage so *nr_pages_backed is
> > +		 * always > 0 here, matching a genuine mid-compound -ENOMEM
> > +		 * and driving the caller's reactive split fallback instead
> > +		 * of an early, no-progress failure.
> >   		 */
> > -		if (ret)
> > +		if (IS_ENABLED(CONFIG_FAULT_INJECTION) && i &&
> > +		    ttm_backup_fault_inject_folio())
> > +			to_folio = ERR_PTR(-ENOMEM);
> > +		else
> > +			to_folio = shmem_read_folio_gfp(mapping, idx + i, alloc_gfp);
> > +		if (IS_ERR(to_folio)) {
> > +			int err = PTR_ERR(to_folio);
> > +
> > +			if (err == -ENOMEM && *nr_pages_backed)
> > +				return ttm_backup_shmem_idx_to_handle(idx);
> > +
> > +			if (*nr_pages_backed) {
> > +				shmem_truncate_range(file_inode(backup),
> > +						     (loff_t)idx << PAGE_SHIFT,
> > +						     ((loff_t)(idx + i) << PAGE_SHIFT) - 1);
> > +				/*
> > +				 * The pages just truncated are no longer
> > +				 * backed up; don't let the caller mistake
> > +				 * them for valid handles.
> > +				 */
> > +				*nr_pages_backed = 0;
> > +			}
> > +			return err;
> > +		}
> > +
> > +		to_nr = min_t(int, nr_pages - i,
> > +			      folio_next_index(to_folio) - (idx + i));
> > +
> > +		folio_mark_accessed(to_folio);
> > +		folio_lock(to_folio);
> > +		folio_mark_dirty(to_folio);
> > +
> > +		for (j = 0; j < to_nr; j++)
> > +			copy_highpage(folio_file_page(to_folio, idx + i + j),
> > +				      folio_page(folio, i + j));
> > +
> > +		if (writeback && !folio_mapped(to_folio) &&
> > +		    folio_clear_dirty_for_io(to_folio)) {
> > +			folio_set_reclaim(to_folio);
> > +			ret = shmem_writeout(to_folio, NULL, NULL);
> > +			if (!folio_test_writeback(to_folio))
> > +				folio_clear_reclaim(to_folio);
> > +			if (ret == AOP_WRITEPAGE_ACTIVATE)
> > +				folio_unlock(to_folio);
> Actually, it may be that the whole above block (setting reclaim etc) is

The check for AOP_WRITEPAGE_ACTIVATE was also missing from the old code.
This was flagged by a separate core MM patch that performed some
tree-wide cleanup around shmem_writeout(). Reading through the
shmem_writeout() implementation, the need for this check appears fairly
obvious.

> duplicating what shmem_writeout already does and that got missed in the
> conversion to shmem_writeout. In any case, that might belong in a separate

It is less obvious whether folio_set_reclaim() is called somewhere
along the shmem_writeout() path, and it is possible that we have this
part wrong. I think I agree that we should follow up on this and post a
separate patch if needed.

> patch. Note also that if shmem happened to allocate a 2M page, and we call
> shmem_writeout on it, it might be split on further copies to it, like if
> we're trying to back up a 4K-populated bo to a 2M shmem page. Also
> pre-existing.
> 

I don't think we pass in the original folio which what we trying to
avoid splitting in this patch, but I do see code around 'to_folio' being
split, so we may need a follow up here too?

Matt

> 
> > +		} else {
> >   			folio_unlock(to_folio);
> > -	} else {
> > -		folio_unlock(to_folio);
> > -	}
> > +		}
> > -	folio_put(to_folio);
> > +		folio_put(to_folio);
> > +		i += to_nr;
> > +		*nr_pages_backed = i;
> > +	}
> > -	return handle;
> > +	return ttm_backup_shmem_idx_to_handle(idx);
> >   }
> >   /**
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 80d0ad41456a..1bf37023fed6 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -53,8 +53,23 @@
> >   #ifdef CONFIG_FAULT_INJECTION
> >   #include <linux/fault-inject.h>
> >   static DECLARE_FAULT_ATTR(backup_fault_inject);
> > +
> > +/*
> > + * Exposed to ttm_backup.c so a mid-compound subpage can be made to fail
> > + * with -ENOMEM, exercising the reactive split-and-retry fallback in
> > + * ttm_pool_backup() for high-order backups.
> > + */
> > +bool ttm_backup_fault_inject_folio(void)
> > +{
> > +	return should_fail(&backup_fault_inject, 1);
> > +}
> >   #else
> >   #define should_fail(...) false
> > +
> > +bool ttm_backup_fault_inject_folio(void)
> > +{
> > +	return false;
> > +}
> >   #endif
> >   /**
> > @@ -492,7 +507,7 @@ static void ttm_pool_split_for_swap(struct ttm_pool *pool, struct page *p)
> >   /**
> >    * DOC: Partial backup and restoration of a struct ttm_tt.
> >    *
> > - * Swapout using ttm_backup_backup_page() and swapin using
> > + * Swapout using ttm_backup_backup_folio() and swapin using
> >    * ttm_backup_copy_page() may fail.
> >    * The former most likely due to lack of swap-space or memory, the latter due
> >    * to lack of memory or because of signal interruption during waits.
> > @@ -1050,12 +1065,12 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
> >   {
> >   	struct file *backup = tt->backup;
> >   	struct page *page;
> > -	unsigned long handle;
> >   	gfp_t alloc_gfp;
> >   	gfp_t gfp;
> >   	int ret = 0;
> >   	pgoff_t shrunken = 0;
> > -	pgoff_t i, num_pages;
> > +	pgoff_t i, j, num_pages, npages;
> > +	pgoff_t nr_backed;
> >   	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> >   		return -EINVAL;
> > @@ -1133,9 +1148,11 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
> >   	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && should_fail(&backup_fault_inject, 1))
> >   		num_pages = DIV_ROUND_UP(num_pages, 2);
> > -	for (i = 0; i < num_pages; ++i) {
> > -		s64 shandle;
> > +	for (i = 0; i < num_pages; i += npages) {
> > +		unsigned int order;
> > +		s64 handle;
> > +		npages = 1;
> >   		page = tt->pages[i];
> >   		if (unlikely(!page))
> >   			continue;
> > @@ -1144,19 +1161,61 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
> >   		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
> >   			continue;
> > -		ttm_pool_split_for_swap(pool, page);
> > +		order = ttm_pool_page_order(pool, page);
> > +		npages = 1UL << order;
> > +
> > +		/*
> > +		 * We don't allow dipping kernel reserves for high order backup
> > +		 */
> > +		if (order)
> > +			alloc_gfp |= __GFP_NOMEMALLOC;
> > +		else
> > +			alloc_gfp &= ~__GFP_NOMEMALLOC;
> > +
> > +		/*
> > +		 * Back up the compound atomically at its native order. If
> > +		 * fault injection truncated num_pages mid-compound, skip
> > +		 * the partial tail rather than splitting.
> > +		 */
> > +		if (unlikely(i + npages > num_pages))
> > +			break;
> > -		shandle = ttm_backup_backup_page(backup, page, flags->writeback, i,
> > -						 gfp, alloc_gfp);
> > -		if (shandle < 0) {
> > -			/* We allow partially shrunken tts */
> > -			ret = shandle;
> > +		handle = ttm_backup_backup_folio(backup, page_folio(page),
> > +						 order, flags->writeback, i,
> > +						 gfp, alloc_gfp,
> > +						 &nr_backed);
> > +		/*
> > +		 * Zero progress on this compound (whether order 0 or a
> > +		 * high-order compound that failed before backing up even
> > +		 * its first subpage) is unrecoverable: bail out rather than
> > +		 * looping forever with npages == nr_backed == 0 below.
> > +		 */
> > +		if (unlikely(handle < 0 && !nr_backed)) {
> > +			ret = handle;
> >   			break;
> >   		}
> > -		handle = shandle;
> > -		tt->pages[i] = ttm_backup_handle_to_page_ptr(handle);
> > -		__free_pages_gpu_account(page, 0, false);
> > -		shrunken++;
> > +
> > +		for (j = 0; j < nr_backed; j++)
> > +			tt->pages[i + j] = ttm_backup_handle_to_page_ptr(handle + j);
> > +
> > +		shrunken += nr_backed;
> > +
> > +		if (unlikely(nr_backed < npages)) {
> > +			/*
> > +			 * Partial OOM backup: split the compound and free the
> > +			 * subpages whose content is now in shmem. Continue the
> > +			 * loop from the first un-backed order-0 page.
> > +			 */
> > +			ttm_pool_split_for_swap(pool, page);
> > +			for (j = 0; j < nr_backed; j++)
> > +				__free_pages_gpu_account(page + j, 0, false);
> > +			npages = nr_backed;
> > +			continue;
> > +		}
> > +
> > +		/* Fully backed up: free at native order. */
> > +		page->private = 0;
> > +		__free_pages_gpu_account(page, order, false);
> >   	}
> >   	return shrunken ? shrunken : ret;
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h b/drivers/gpu/drm/ttm/ttm_pool_internal.h
> > index 24c179fd69d1..cbb17a2129fe 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
> > +++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
> > @@ -22,4 +22,12 @@ static inline unsigned int ttm_pool_beneficial_order(struct ttm_pool *pool)
> >   	return pool->alloc_flags & 0xff;
> >   }
> > +/*
> > + * Implemented in ttm_pool.c, used by ttm_backup.c. Returns true if a fault
> > + * should be injected mid-compound to test the reactive split-and-retry
> > + * fallback in ttm_pool_backup(). Always returns false when
> > + * CONFIG_FAULT_INJECTION is disabled.
> > + */
> > +bool ttm_backup_fault_inject_folio(void);
> > +
> >   #endif
> > diff --git a/include/drm/ttm/ttm_backup.h b/include/drm/ttm/ttm_backup.h
> > index 29b9c855af77..49efa713e87c 100644
> > --- a/include/drm/ttm/ttm_backup.h
> > +++ b/include/drm/ttm/ttm_backup.h
> > @@ -13,9 +13,8 @@
> >    * ttm_backup_handle_to_page_ptr() - Convert handle to struct page pointer
> >    * @handle: The handle to convert.
> >    *
> > - * Converts an opaque handle received from the
> > - * ttm_backup_backup_page() function to an (invalid)
> > - * struct page pointer suitable for a struct page array.
> > + * Converts an opaque handle received from a ttm_backup_backup_*()
> > + * function to an (invalid) struct page pointer suitable for a struct page array.
> >    *
> >    * Return: An (invalid) struct page pointer.
> >    */
> > @@ -59,9 +58,10 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
> >   			 pgoff_t handle, bool intr, gfp_t additional_gfp);
> >   s64
> > -ttm_backup_backup_page(struct file *backup, struct page *page,
> > -		       bool writeback, pgoff_t idx, gfp_t page_gfp,
> > -		       gfp_t alloc_gfp);
> > +ttm_backup_backup_folio(struct file *backup, struct folio *folio,
> > +			unsigned int order, bool writeback, pgoff_t idx,
> > +			gfp_t folio_gfp, gfp_t alloc_gfp,
> > +			pgoff_t *nr_pages_backed);
> >   void ttm_backup_fini(struct file *backup);
> Otherwise LGTM.
> 
> /Thomas
> 
> 
