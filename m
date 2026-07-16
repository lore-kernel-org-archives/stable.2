Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCE30C366;
	Thu, 16 Jul 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784242165; cv=fail; b=fg1dxi6wWDijGImBcEEOUOQa7ltLUeOIBAfm9FYrQKIz9GoYq6S7PMr1MZxofKCE540/4Wz76hXd/PvI8+kDgwz8s4U2HAkSo7GZ/5kIKRd8Zke8OvFqyb6Ma5JC7uiLJ0NZortl5qgOsar8RNcFsT8mXP4vlrJqr0eZGLQcpIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784242165; c=relaxed/simple;
	bh=HVpf7INGilvA7obYcQZGfqcnCutm4QM4mXX0YtX0HBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DeQqbaXlz0X48tFDmwN7mcmmU354bccIC0k1rryoryeyGGY4fKZhuYRyx5/NfZVD24/IwBwt+/7lOgAfUxIjQKrsrYyUkIODbUbjhLHvEtXcbntZGup1tLtP6UtAsz/0JCPnokpeMXi8gEUWURyW09YctGeAiCsixkYwDtUlLig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnQ2iUwR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnQ2iUwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784242162; x=1815778162;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HVpf7INGilvA7obYcQZGfqcnCutm4QM4mXX0YtX0HBg=;
  b=fnQ2iUwRLBnlLm6nszsSBll5PjygDd3RzjujNvHQIHSF3ExKjdiGWATx
   04nNQIU/Lg//xefPPeW/1LOju9KRK+lIAazSvHRGQETvGTnf2cwgQO3zB
   Tl50xDHiaOHE+jIvMVJszPmeegpZ90IpU10q5lg+t+2vxog9NZ+byozP6
   FFminPGPzRDFr3UDRyWS+GE8modtK+RdxX3cFCq+7y1TCz7IacxcaIuYw
   7lbnBtWMc1fATeVb7VYkcnTBQ02FgKMPyrg/0biiJ9AGvuXzhJqhr6h2D
   jnQvDNZq3jgMXk3JWTFs2gXQuT4I3F/RMOWjsu3Voyzzaxc/dRI2pWv2t
   g==;
X-CSE-ConnectionGUID: ptyQTEncSAWJc+MTNJr8eA==
X-CSE-MsgGUID: JV2/+v+xRJq6Kc2nutrG5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="110464811"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="110464811"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 15:49:21 -0700
X-CSE-ConnectionGUID: nBVfiZPPSaq4piuHS52QVQ==
X-CSE-MsgGUID: UI62xNszQ06i+4/P+wnP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="254850934"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 15:49:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 15:49:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 15:49:20 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 15:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqfrJFEHLy4mz+lnQlXjEKr20TKBaQ1kxmk/l8LCYDmnt1mCl9muDF1Gb7rRCTP+oRUfAEcFOLVZhF2s2AA3VFlcZcrVjebyaoynCZkl/DY6XuCUzGANel77U5AUqNifGwkPz1t7S4PyGJSkEikzHZVkkv948OlTaUMGUAa5hEnekF5IWH/H5cfCAp3AVO3f8VfVtEN7rjKkqaieBuXPEbnBARNp9qePJrRiNqrBq8xt4nlQAjlg31LkipqCDSu8H6BcKBLWxYsfdGnL79JpLpn4Zd2zr7eEn6Y77YAockWmhyQjVQVtD8cGPBkdkbS80dzb47M5aCYyKL9AOJIgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Sh7bMQf3K78XUuTxSe8LOw44MqdlVQe2nDvpgLLKfU=;
 b=UWrTu53LG48iGiJKr+can+gXf/lXTYTXX8QLPrSHxJkUaCDA5WF8WRQNJvDimGU55/QYvt3oP9e73aHPomShZh2eLoDRVGfvAv1tA7sJoNO4zWtlRxwyMvA8i7czTXjaVDlm76sCrqgOeSihJlyX62cylxgWAEK6iGIz0U4wCZmNha2SlgrO0DlA8x2iAKRowbSO9t+WFK6Mz3E7Zukl3lT8JIj++hakkGEjVxJL30DweerLF4HxhAAQicxEqcylqRJ/s1eduV6DGtOE1xRUIWmqgxEfeu9F3CmMjWdW3VCSGwuf4bTdbHcJTRESQ54NsWw3WPh9A2+bgN9KPvZ4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by LV3PR11MB8725.namprd11.prod.outlook.com (2603:10b6:408:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 22:49:11 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 22:49:11 +0000
Date: Thu, 16 Jul 2026 15:49:06 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Huang Rui
	<ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH] drm/ttm/pool: back up at native page order
Message-ID: <allf4vE96KAowd8E@gsse-cloud1.jf.intel.com>
References: <20260716201358.4086085-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716201358.4086085-1-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|LV3PR11MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7bc97a-f7c7-4871-d826-08dee38c738c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|11063799006|10067099003|6133799003|56012099006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: MrG5WEtiHMaf48PXXLCwKGzv+T7+EEtyWJIoMZqp7nid5C/uGzfzIYomhyU7gjKfXhFHgQmcVwd8qBwFPrdhADi7nYJW83bTIN010BuAt/7rQtNlgVh/RmEtjglvDYjvb/501SpSK4lCsgyRyOJO2iGLnYUTmN1Yq9Pt2XYRPJn5b0sB4n7X9LH2FC5Tj5ZcYrql/Nz8W4O/SFDd2LhhL+EGctLXajgbGn+qzCesBMDOg3eZ/Ack4BUMDdQ+uxxqGd14W3obx6X48yHelJr8sWTnKkmZ0ws4/vnQ0TjltfwC2YQjBQ6vu4y7Hb4Mnx4CJ33nn+4xR8wfKQropKovRHUFf9rT+OzrX87gA1360bjBZPI8sEuajFspWH2ZaQOvDsWAsJJ+PW8IQB4++xC5FalZ10nSqDJGyu49d3uDLEtHmce5ZD3WCYr26zsq8AciypVxBemWwBgRHpq0dgjmiiyhEGGxhVM/qi/mkebHF0C0sfgVgmGsv6F93UWJVnGnMxV/5HiAPYUaJSbe3TK9VqQ7pnzuWQQ315zgb4b3Aqkr2aubGY4ESjpA32QsICx1sWq5k9e3ixLorm6adq405r8CRvYO5swhF37mAusVHF6LWsZbszHJvLzozPLBflvKHVtZSsQkE3U2udrN9U7fUUEYDFyCoOuZXC8gVnTtisQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(11063799006)(10067099003)(6133799003)(56012099006)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AC0MgcTJJLVgJ9c0OMDQWqQ48IJWIrCutLAG9OdcnLd8DOUA2rCMPKZGb6?=
 =?iso-8859-1?Q?msToo9mN2QIbzC9h65VJdWK4inNCfy3A1stPE4BDJ05uVG0cfBiDIFofqw?=
 =?iso-8859-1?Q?LXwNCcVlZQ+d8J43MbFaJm6He4t44RAkyc3/YWPdgjkLYSsbBqQegk7lK0?=
 =?iso-8859-1?Q?iu87+wSHpN1tdAqZq79h1b8aMGlW2l3tIl/yP4TIVDxdtLWvv3zsIkqPIe?=
 =?iso-8859-1?Q?4kxYpvrnSzS+rH0HM4YBqrT73BXEs5+2BhrTiC/3JQt5EKq1lCDgzcWJXn?=
 =?iso-8859-1?Q?CvQuWLHTYibiPyMGB816rOw/f5E8iUxkF5TloENIx/cRVATL1SYlU5oH2+?=
 =?iso-8859-1?Q?ouj+IDkza6HveiNY0ZkSXL2FreAe3w5ej59N308XEeQux1fWArecjQguG3?=
 =?iso-8859-1?Q?5hbfOW1+Eeay05sw681p09uZ4kyUckhlrRKoLsIxEfXJpq8NofPS+jH3kI?=
 =?iso-8859-1?Q?vsRQ2KN7GFmq5EY/6d/lnMf1Q5kMXOlzOgYxebjlIPzrSWP3hucbbfiG9I?=
 =?iso-8859-1?Q?TY7ReOY7fcqACUzHILzispNMD1Ev7oOzs1GmfYcEyqhO/0iQ5O/S3k7UL4?=
 =?iso-8859-1?Q?7aQQojz6BHv4/EgPwNHAI6Nip+rOM2GUvYbQVHZfaPHt7lacsZOITxyokC?=
 =?iso-8859-1?Q?VhAevAsl07XAFVaSuyWNvsCqhoR4b0/LUEFz6LtqSJXwEeqNOQaR8oQoHd?=
 =?iso-8859-1?Q?rpMgeki6EzB5WVYmqweFJJsm+w1FICf9TuxMnWU9hty7b/rtS2H6pc4c4x?=
 =?iso-8859-1?Q?pMLQVgEYgL0GNMYI8+gnUyoMQrd/SDLQDJf2Wm/o7D0v055Pdmsip+rwUe?=
 =?iso-8859-1?Q?Ox6+B40/G74b7Mqt7M5a7MBV1PIxIjt6QCp6b4RWiYWLMceivLJN/FjcGV?=
 =?iso-8859-1?Q?i6MsiW1F1P8Vqb+DIQvA27piCNMg5Sv4iL5fD0A/Bj2BAXDR/jedqTY/SJ?=
 =?iso-8859-1?Q?ItG6DB/X1Oy0Xh8nnFYlA90+BP7ekUkuJxEaPPnP1MQWtdG9j9A3RGHUvy?=
 =?iso-8859-1?Q?JmVT25Adeu/G4WEtOPhXl/Nz5hUMfpPnVq5qrNUhwU3oRfMMwGrI6SH30+?=
 =?iso-8859-1?Q?JkGdf1qhovP7wJX11LsN3oeHGpleDHYEIaC+kW43iZWdife4uNacByExGT?=
 =?iso-8859-1?Q?y4BW0Ih5NzpjOWT4xfSn2t8cp00+4Baw70B1/ljxmEiFP19uQdOEoCXEJG?=
 =?iso-8859-1?Q?hIrfKuI7tzzxtPcOUOruhp8BfXQPtKekMXU8t6vBE0bl/aFXE6ZfyYTssX?=
 =?iso-8859-1?Q?q5U69Rusz2QF3IAXjZH9yfLKDjkgqFF/CQeQnpEeF75+xpYCG7dBblKg1W?=
 =?iso-8859-1?Q?SjbXVC+M+SS+THe8fKiEGtBny7pAipmOn6EvO0ngp2zw3OH4TcH0+elnCW?=
 =?iso-8859-1?Q?k8ca4/8oTpPaJOGLR56E6glQ/17l9OVLzlgw/xm77QMLh3NOjs3x6bUkQ/?=
 =?iso-8859-1?Q?gfmOnkKUQaPsIFHbxhsvLu1MlCGTYibgcCQRp83ij9RhtKuHY+8gyKZ7ac?=
 =?iso-8859-1?Q?OZD4/0YQ2RqxVfeY7ofcW3vMleClcvFaiOyhzSdhN4Yj0iIo8MBmCyU2B+?=
 =?iso-8859-1?Q?xpDTRhJ1ntfEB3kWmLFk0QMVIVLD9gVgD+bKWaDx+cLUoxRnvmwlA39spc?=
 =?iso-8859-1?Q?JcOtzwrC/ZwW456h2bGPwDN59Ga500qFc6A4hf5X2Q92u1F+By/cPKhLsa?=
 =?iso-8859-1?Q?VI1aCYmfjT9h3GcWAAWmuPXwjQV7ldpJ3mKPnXIaxlWh3+ppDSD4VA0Xiu?=
 =?iso-8859-1?Q?ByL3iIKTZlIN45KsnFty9R/haakgAmtRyq3alRCMSPb2bYgMX631FlEUAe?=
 =?iso-8859-1?Q?z3Xe2nCQhw=3D=3D?=
X-Exchange-RoutingPolicyChecked: qUWooVhGnRNZFY2ft0+b2leabzo8Ojw57McYX1IGqPyvsc2q5tBfGBT6sWDc+hVt0/Z4ctDBWO/Ds3maQFEraB1obXEZ7oJRH2BBtpdR0GuoQUG6OkhPuNktuICDmfGRda5bMxwfs4/grjMnGtZzW6LDeO5NFEtZynJg31d1aQsQRCI4xSz1noWljoRKDtOfOj0tA1T2V4z5HuNKsOf5t2Pw9XcXjlRM0PEZh7mS2cv8inzok6icPAX71rCp0IaW5uN1w0MeMgnuuESGHosBZxZMfIpKFuJRRGZO1wohNLSQ1gyE4/WuBsuyEVD/5lerGi4cHIhgv93VuszvQZ9ogA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7bc97a-f7c7-4871-d826-08dee38c738c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:49:11.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH8XfVyqHeBE9UE2Zi0QBSMLhOhM4mbwqn6HRgPrgpthS2y3v0xE60O2yyYfxNWia3F4yW60qBJMpg0ozzP89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8725
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 01:13:58PM -0700, Matthew Brost wrote:
> ttm_pool_split_for_swap() unconditionally splits high-order pool pages
> into order-0 pages before backup, so every compound the shrinker
> touches is shattered even when the rest of the system would prefer it
> stay intact. Under sustained kswapd pressure this fragments memory
> enough to drive other parts of MM into recovery loops.
> 
> Back up each compound at its native order instead. In
> ttm_pool_backup(), hand the full compound to the new
> ttm_backup_backup_folio(), which backs up subpages to a contiguous
> range of shmem indices and returns the base handle plus the number of
> subpages actually backed up (@nr_backed). On full success, free the
> compound once at its native order -- no split_page(), no per-4K
> refcount juggling.
> 
> A per-folio backup can't be made fully atomic under memory pressure:
> ttm_backup_backup_folio() must allocate shmem folios before source
> subpages can be released, so under true OOM any subpage may fail
> while the rest of the compound is still live. Two mechanisms handle
> this without regressing reclaim behaviour:
> 
>   - alloc_gfp gets __GFP_NOMEMALLOC whenever order > 0 (cleared again
>     for order-0), so a high-order backup fails fast with -ENOMEM
>     instead of draining kernel reserves, leaving them for other
>     allocations under the same pressure.
> 
>   - If ttm_backup_backup_folio() still returns a short @nr_backed with
>     a valid handle for the successfully-backed prefix, split the
>     source compound with ttm_pool_split_for_swap(), free the prefix as
>     order-0 pages (already safely in shmem), and retry the remaining
>     subpages at order 0, where __GFP_NOMEMALLOC is cleared and
>     reserves may be used as a last resort.
> 
> This preserves the original split-on-OOM fallback while keeping the
> common case fragmentation-free, and preserves the "partial backup is
> allowed" contract (shrunken is incremented per subpage backed up).
> 
> The restore-side leftover-page split in ttm_pool_restore_commit() is
> left as-is: it's unreachable in practice and not worth complicating
> the restore state machine to avoid.
> 
> Testing: the existing backup_fault_inject point only truncated
> tt->num_pages, which never exercised the reactive split path above
> since it never left a compound partially backed up. Wire fault
> injection into ttm_backup_backup_folio() itself: past the first
> subpage of a compound, synthesize a -ENOMEM in place of
> shmem_read_folio_gfp() when should_fail() trips, producing the same
> short @nr_pages_backed a real failure would and forcing
> ttm_pool_backup() through the split-and-retry path. The fault_attr
> stays private to ttm_pool.c; ttm_backup.c reaches it through
> ttm_backup_fault_inject_folio(), declared in ttm_pool_internal.h.
> 
> While converting the writeback branch to operate on the whole folio,
> the unlock condition after shmem_writeout() also changed from `if
> (ret)` to `if (ret == AOP_WRITEPAGE_ACTIVATE)`, matching the actual
> contract: shmem_writeout()/swap_writeout() only leave the folio locked
> when returning AOP_WRITEPAGE_ACTIVATE; any other return (including a
> hard error from arch_prepare_to_swap()) means the folio was already
> unlocked internally. The old `if (ret)` check would have double-
> unlocked in that hard-error case.
> 
> Cc: Christian Koenig <christian.koenig@amd.com>

@Christian - we plan on merging this unless you have any objections.

This code path is only exercised by Xe moment if that is unclear.

Matt

> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
> Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_backup.c        | 129 ++++++++++++++++--------
>  drivers/gpu/drm/ttm/ttm_pool.c          |  89 +++++++++++++---
>  drivers/gpu/drm/ttm/ttm_pool_internal.h |   8 ++
>  include/drm/ttm/ttm_backup.h            |  12 +--
>  4 files changed, 173 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
> index 81df4cb5606b..3c067aadc52d 100644
> --- a/drivers/gpu/drm/ttm/ttm_backup.c
> +++ b/drivers/gpu/drm/ttm/ttm_backup.c
> @@ -6,9 +6,10 @@
>  #include <drm/ttm/ttm_backup.h>
>  
>  #include <linux/export.h>
> -#include <linux/page-flags.h>
>  #include <linux/swap.h>
>  
> +#include "ttm_pool_internal.h"
> +
>  /*
>   * Need to map shmem indices to handle since a handle value
>   * of 0 means error, following the swp_entry_t convention.
> @@ -68,17 +69,23 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
>  }
>  
>  /**
> - * ttm_backup_backup_page() - Backup a page
> + * ttm_backup_backup_folio() - Backup a folio
>   * @backup: The struct backup pointer to use.
> - * @page: The page to back up.
> - * @writeback: Whether to perform immediate writeback of the page.
> + * @folio: The folio to back up.
> + * @order: The allocation order of @folio.  Since TTM allocates higher-order
> + *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
> + *         return 1; the caller must pass the true order explicitly.
> + * @writeback: Whether to perform immediate writeback of the folio's pages.
>   * This may have performance implications.
> - * @idx: A unique integer for each page and each struct backup.
> + * @idx: A unique integer for the first page of the folio and each struct backup.
>   * This allows the backup implementation to avoid managing
>   * its address space separately.
> - * @page_gfp: The gfp value used when the page was allocated.
> - * This is used for accounting purposes.
> + * @folio_gfp: The gfp value used when the folio was allocated.
> + * Currently unused.
>   * @alloc_gfp: The gfp to be used when allocating memory.
> + * @nr_pages_backed: Output. On a successful return, set to the number of
> + * pages actually backed up, which may be less than (1 << @order)
> + * if an -ENOMEM was encountered mid-folio.
>   *
>   * Context: If called from reclaim context, the caller needs to
>   * assert that the shrinker gfp has __GFP_FS set, to avoid
> @@ -87,53 +94,87 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
>   * that the shrinker gfp has __GFP_IO set, since without it,
>   * we're not allowed to start backup IO.
>   *
> - * Return: A handle on success. Negative error code on failure.
> - *
> - * Note: This function could be extended to back up a folio and
> - * implementations would then split the folio internally if needed.
> - * Drawback is that the caller would then have to keep track of
> - * the folio size- and usage.
> + * Return: A handle for the first backed-up page on success (handles for
> + * subsequent pages follow sequentially). -ENOMEM if no pages could be backed
> + * up. Any other negative error code if a non-ENOMEM failure occurred; in that
> + * case any pages backed up so far are truncated before returning.
>   */
>  s64
> -ttm_backup_backup_page(struct file *backup, struct page *page,
> -		       bool writeback, pgoff_t idx, gfp_t page_gfp,
> -		       gfp_t alloc_gfp)
> +ttm_backup_backup_folio(struct file *backup, struct folio *folio,
> +			unsigned int order, bool writeback, pgoff_t idx,
> +			gfp_t folio_gfp, gfp_t alloc_gfp,
> +			pgoff_t *nr_pages_backed)
>  {
>  	struct address_space *mapping = backup->f_mapping;
> -	unsigned long handle = 0;
> +	int nr_pages = 1 << order;
>  	struct folio *to_folio;
> -	int ret;
> -
> -	to_folio = shmem_read_folio_gfp(mapping, idx, alloc_gfp);
> -	if (IS_ERR(to_folio))
> -		return PTR_ERR(to_folio);
> -
> -	folio_mark_accessed(to_folio);
> -	folio_lock(to_folio);
> -	folio_mark_dirty(to_folio);
> -	copy_highpage(folio_file_page(to_folio, idx), page);
> -	handle = ttm_backup_shmem_idx_to_handle(idx);
> -
> -	if (writeback && !folio_mapped(to_folio) &&
> -	    folio_clear_dirty_for_io(to_folio)) {
> -		folio_set_reclaim(to_folio);
> -		ret = shmem_writeout(to_folio, NULL, NULL);
> -		if (!folio_test_writeback(to_folio))
> -			folio_clear_reclaim(to_folio);
> +	int ret, i;
> +
> +	*nr_pages_backed = 0;
> +
> +	for (i = 0; i < nr_pages; ) {
> +		int to_nr, j;
> +
>  		/*
> -		 * If writeout succeeds, it unlocks the folio.	errors
> -		 * are otherwise dropped, since writeout is only best
> -		 * effort here.
> +		 * Only inject past the first subpage so *nr_pages_backed is
> +		 * always > 0 here, matching a genuine mid-compound -ENOMEM
> +		 * and driving the caller's reactive split fallback instead
> +		 * of an early, no-progress failure.
>  		 */
> -		if (ret)
> +		if (IS_ENABLED(CONFIG_FAULT_INJECTION) && i &&
> +		    ttm_backup_fault_inject_folio())
> +			to_folio = ERR_PTR(-ENOMEM);
> +		else
> +			to_folio = shmem_read_folio_gfp(mapping, idx + i, alloc_gfp);
> +		if (IS_ERR(to_folio)) {
> +			int err = PTR_ERR(to_folio);
> +
> +			if (err == -ENOMEM && *nr_pages_backed)
> +				return ttm_backup_shmem_idx_to_handle(idx);
> +
> +			if (*nr_pages_backed) {
> +				shmem_truncate_range(file_inode(backup),
> +						     (loff_t)idx << PAGE_SHIFT,
> +						     ((loff_t)(idx + i) << PAGE_SHIFT) - 1);
> +				/*
> +				 * The pages just truncated are no longer
> +				 * backed up; don't let the caller mistake
> +				 * them for valid handles.
> +				 */
> +				*nr_pages_backed = 0;
> +			}
> +			return err;
> +		}
> +
> +		to_nr = min_t(int, nr_pages - i,
> +			      folio_next_index(to_folio) - (idx + i));
> +
> +		folio_mark_accessed(to_folio);
> +		folio_lock(to_folio);
> +		folio_mark_dirty(to_folio);
> +
> +		for (j = 0; j < to_nr; j++)
> +			copy_highpage(folio_file_page(to_folio, idx + i + j),
> +				      folio_page(folio, i + j));
> +
> +		if (writeback && !folio_mapped(to_folio) &&
> +		    folio_clear_dirty_for_io(to_folio)) {
> +			folio_set_reclaim(to_folio);
> +			ret = shmem_writeout(to_folio, NULL, NULL);
> +			if (!folio_test_writeback(to_folio))
> +				folio_clear_reclaim(to_folio);
> +			if (ret == AOP_WRITEPAGE_ACTIVATE)
> +				folio_unlock(to_folio);
> +		} else {
>  			folio_unlock(to_folio);
> -	} else {
> -		folio_unlock(to_folio);
> -	}
> +		}
>  
> -	folio_put(to_folio);
> +		folio_put(to_folio);
> +		i += to_nr;
> +		*nr_pages_backed = i;
> +	}
>  
> -	return handle;
> +	return ttm_backup_shmem_idx_to_handle(idx);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 80d0ad41456a..1bf37023fed6 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -53,8 +53,23 @@
>  #ifdef CONFIG_FAULT_INJECTION
>  #include <linux/fault-inject.h>
>  static DECLARE_FAULT_ATTR(backup_fault_inject);
> +
> +/*
> + * Exposed to ttm_backup.c so a mid-compound subpage can be made to fail
> + * with -ENOMEM, exercising the reactive split-and-retry fallback in
> + * ttm_pool_backup() for high-order backups.
> + */
> +bool ttm_backup_fault_inject_folio(void)
> +{
> +	return should_fail(&backup_fault_inject, 1);
> +}
>  #else
>  #define should_fail(...) false
> +
> +bool ttm_backup_fault_inject_folio(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  /**
> @@ -492,7 +507,7 @@ static void ttm_pool_split_for_swap(struct ttm_pool *pool, struct page *p)
>  /**
>   * DOC: Partial backup and restoration of a struct ttm_tt.
>   *
> - * Swapout using ttm_backup_backup_page() and swapin using
> + * Swapout using ttm_backup_backup_folio() and swapin using
>   * ttm_backup_copy_page() may fail.
>   * The former most likely due to lack of swap-space or memory, the latter due
>   * to lack of memory or because of signal interruption during waits.
> @@ -1050,12 +1065,12 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
>  {
>  	struct file *backup = tt->backup;
>  	struct page *page;
> -	unsigned long handle;
>  	gfp_t alloc_gfp;
>  	gfp_t gfp;
>  	int ret = 0;
>  	pgoff_t shrunken = 0;
> -	pgoff_t i, num_pages;
> +	pgoff_t i, j, num_pages, npages;
> +	pgoff_t nr_backed;
>  
>  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
>  		return -EINVAL;
> @@ -1133,9 +1148,11 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
>  	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && should_fail(&backup_fault_inject, 1))
>  		num_pages = DIV_ROUND_UP(num_pages, 2);
>  
> -	for (i = 0; i < num_pages; ++i) {
> -		s64 shandle;
> +	for (i = 0; i < num_pages; i += npages) {
> +		unsigned int order;
> +		s64 handle;
>  
> +		npages = 1;
>  		page = tt->pages[i];
>  		if (unlikely(!page))
>  			continue;
> @@ -1144,19 +1161,61 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
>  		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
>  			continue;
>  
> -		ttm_pool_split_for_swap(pool, page);
> +		order = ttm_pool_page_order(pool, page);
> +		npages = 1UL << order;
> +
> +		/*
> +		 * We don't allow dipping kernel reserves for high order backup
> +		 */
> +		if (order)
> +			alloc_gfp |= __GFP_NOMEMALLOC;
> +		else
> +			alloc_gfp &= ~__GFP_NOMEMALLOC;
> +
> +		/*
> +		 * Back up the compound atomically at its native order. If
> +		 * fault injection truncated num_pages mid-compound, skip
> +		 * the partial tail rather than splitting.
> +		 */
> +		if (unlikely(i + npages > num_pages))
> +			break;
>  
> -		shandle = ttm_backup_backup_page(backup, page, flags->writeback, i,
> -						 gfp, alloc_gfp);
> -		if (shandle < 0) {
> -			/* We allow partially shrunken tts */
> -			ret = shandle;
> +		handle = ttm_backup_backup_folio(backup, page_folio(page),
> +						 order, flags->writeback, i,
> +						 gfp, alloc_gfp,
> +						 &nr_backed);
> +		/*
> +		 * Zero progress on this compound (whether order 0 or a
> +		 * high-order compound that failed before backing up even
> +		 * its first subpage) is unrecoverable: bail out rather than
> +		 * looping forever with npages == nr_backed == 0 below.
> +		 */
> +		if (unlikely(handle < 0 && !nr_backed)) {
> +			ret = handle;
>  			break;
>  		}
> -		handle = shandle;
> -		tt->pages[i] = ttm_backup_handle_to_page_ptr(handle);
> -		__free_pages_gpu_account(page, 0, false);
> -		shrunken++;
> +
> +		for (j = 0; j < nr_backed; j++)
> +			tt->pages[i + j] = ttm_backup_handle_to_page_ptr(handle + j);
> +
> +		shrunken += nr_backed;
> +
> +		if (unlikely(nr_backed < npages)) {
> +			/*
> +			 * Partial OOM backup: split the compound and free the
> +			 * subpages whose content is now in shmem. Continue the
> +			 * loop from the first un-backed order-0 page.
> +			 */
> +			ttm_pool_split_for_swap(pool, page);
> +			for (j = 0; j < nr_backed; j++)
> +				__free_pages_gpu_account(page + j, 0, false);
> +			npages = nr_backed;
> +			continue;
> +		}
> +
> +		/* Fully backed up: free at native order. */
> +		page->private = 0;
> +		__free_pages_gpu_account(page, order, false);
>  	}
>  
>  	return shrunken ? shrunken : ret;
> diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h b/drivers/gpu/drm/ttm/ttm_pool_internal.h
> index 24c179fd69d1..cbb17a2129fe 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
> +++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
> @@ -22,4 +22,12 @@ static inline unsigned int ttm_pool_beneficial_order(struct ttm_pool *pool)
>  	return pool->alloc_flags & 0xff;
>  }
>  
> +/*
> + * Implemented in ttm_pool.c, used by ttm_backup.c. Returns true if a fault
> + * should be injected mid-compound to test the reactive split-and-retry
> + * fallback in ttm_pool_backup(). Always returns false when
> + * CONFIG_FAULT_INJECTION is disabled.
> + */
> +bool ttm_backup_fault_inject_folio(void);
> +
>  #endif
> diff --git a/include/drm/ttm/ttm_backup.h b/include/drm/ttm/ttm_backup.h
> index 29b9c855af77..49efa713e87c 100644
> --- a/include/drm/ttm/ttm_backup.h
> +++ b/include/drm/ttm/ttm_backup.h
> @@ -13,9 +13,8 @@
>   * ttm_backup_handle_to_page_ptr() - Convert handle to struct page pointer
>   * @handle: The handle to convert.
>   *
> - * Converts an opaque handle received from the
> - * ttm_backup_backup_page() function to an (invalid)
> - * struct page pointer suitable for a struct page array.
> + * Converts an opaque handle received from a ttm_backup_backup_*()
> + * function to an (invalid) struct page pointer suitable for a struct page array.
>   *
>   * Return: An (invalid) struct page pointer.
>   */
> @@ -59,9 +58,10 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
>  			 pgoff_t handle, bool intr, gfp_t additional_gfp);
>  
>  s64
> -ttm_backup_backup_page(struct file *backup, struct page *page,
> -		       bool writeback, pgoff_t idx, gfp_t page_gfp,
> -		       gfp_t alloc_gfp);
> +ttm_backup_backup_folio(struct file *backup, struct folio *folio,
> +			unsigned int order, bool writeback, pgoff_t idx,
> +			gfp_t folio_gfp, gfp_t alloc_gfp,
> +			pgoff_t *nr_pages_backed);
>  
>  void ttm_backup_fini(struct file *backup);
>  
> -- 
> 2.34.1
> 
