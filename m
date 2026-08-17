Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3183BFE2B;
	Mon, 17 Aug 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008383; cv=fail; b=SYBsNGPuESNq8zFLWq8g1iAH4hbE5kVxrd6108N2uK/EwKZUWFjB9q9CzOJyml0/8rYWD8QTp/Dy5zFdNi93cqlGgX1WTtNbc5fv9mvNEhpIfIfyH80U+6WFZHzddPzHnI1/0WKsewwqSsSoFv/dYovTxIetPpc6rdojcYSGj+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008383; c=relaxed/simple;
	bh=MfE4hSs2LNqfvsnRbFZbKd0iyObnaH9+A9d4f1BcwdQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HINaC04zhxPb0FEJgnhY2+rIQhk2HSXu8aO7aymZbecRQSDH7fW2eIqt7IsBOITG75Rq3d246eLRHyhLYs+CJrDDO0DPXyoxp5FTRvxND38W0IMYlZeF7LoZ086NtvOYvXVbrLEwaLh3I0cD0IcHmvdrcnwaoMICwpV85+WzMuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ryf2iUvg; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ryf2iUvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787008380; x=1818544380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MfE4hSs2LNqfvsnRbFZbKd0iyObnaH9+A9d4f1BcwdQ=;
  b=Ryf2iUvg9fYDUNPVV7JI4jrUExIanzBlzyLwu/BCKsIuNnVb9p72c4WY
   bCxXkG8duXKvf3GpGRfnW18vRDoU6jtKKYJdi6AVhsx2RnTyfwbfmYA00
   mPUQ3KFZ+ZtUv3Tmnw6YAEtfm+q8kNL4hjj7LARyrlfLCKjDJ0cUqYQrd
   EwsOq6aXdYbhDtClUblVD4o6QyWk9GwKVg+oRb7aPK80g5Kd4+sJ/4pz+
   rl8KS5pvUdyRpkpRbAI8UTinriFrfXhghji6nWG0aWkVRfn08QV/rQm6b
   NomY2HYXa3lvVlg1fPYdIZVUFaTSrNZamy4omweERUbz+G2qSfH9dSCsR
   A==;
X-CSE-ConnectionGUID: 3QHc/NtzQBWgSurxLpGoPQ==
X-CSE-MsgGUID: JDo3rsTNSIemwEFuaS0uoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91173144"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="91173144"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 16:12:59 -0700
X-CSE-ConnectionGUID: jdTgSlj4RZaV4ixzryUTAQ==
X-CSE-MsgGUID: qIw0BaBPRvm8fcaBL+fAfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="260829963"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 16:12:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 16:12:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 16:12:58 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 16:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9XFk/BYiflmGOFeI2b6OYAqW+M3DxCJcOJG4RrJFCEV0fhllPMtgjw4HOG16xdKiaHrD7+CPuKLYDC44evX81sgPD720yrh4OfUGfaumJ9nHZw6mVZYIilvloYFUhMQCqh4T2DuakjSb/msGHbm2IBEJjgGBnmfJWFW4KZPxuAtjZJK+FHtkQGohSCf/C7Agm3mM3Mso1zzEh8GdFcNGqLUkPxihweBpT5Ns43uSw6tmIHAVtKmfQtqRcbzeOzABopdeJghok3RsZrN+LTdSq6Csuen5CjJe6w0tohC+cd0kNpOSr3aDw9g7ljQgkERapRrv3OhTKjCscdo6da65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dQJCteomMlT+vu9elM0LhPcCmogvIpWDaXwaFv2D+o=;
 b=f1SVfEdz2Lo8vnuVER4w5IbG8bGfcFW4wpz5FS3bjEvDGd8uE0GhbLmqpPf9h0h+HeMAmAM35ZIPVsXp3MXZTlLyd8FpwfDl38eHfDgv3/4rihuR831/c7s3B5R/j3oVeYeb0SzA2QMv3xzezAzG3LOl9YTGIwXXIP8unOdTmqvqkPNXnxypZPgZYbMixEP2PmVcGHsg8WJ8qFaGBOLG3I0DnS/eDUbWLd4nJp3/VbpsZTUSq+RrAD78eVEOSRwqo3dOV0/zt4PGCu4mzmEI4KJIVmQtXq2vzEOri0Gc84WmBKL6g/XQowqwIwHTLWtz9PyWT78m3VWqY+Srh0elmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 23:12:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 23:12:54 +0000
Date: Mon, 17 Aug 2026 16:12:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
CC: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-cxl@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
Message-ID: <aoOVcQHklDi2_lhL@aschofie-mobl2.lan>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
 <anyYev89TB1jHAXe@acer-nitro-anv15-41>
 <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>
 <anz2yiHLrDFhkxuv@aschofie-mobl2.lan>
 <aoL2QSTlDoAQhWhv@acer-nitro-anv15-41>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoL2QSTlDoAQhWhv@acer-nitro-anv15-41>
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ee6d24-c031-4c64-5936-08defcb51107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|56012099006|13003099007|6133799003|11063799006|10067099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: H7/wnh8DwslSXytZAqAC0rypdvNddbUnwcjTf/FGOXfmjfotNOOC35j1UpPdCfrtuAXDTHfJYnSRX/yY6Mv8oGopktjJHe2qnz/fG1FVCGLXkAfukZAhc3Fpvd29Gt/PyC/J/7fsGw66TzqVR5wNFNha3K7gB1i8+gmQhXnqXoNMv7Fk14w0Cd44uj3exWhaFpampbKRfYF1mLPd5aGUHgT0pN5Z9oLpySV7cPi5jIlRvt6dx4Aq3S8fHWeXpq8EZAglaquzoThnL2jokgo9g7q3H2fXXlPNe26g6y6cb3n/wp5mnI4y/juKNd3PzHKkddnxyZWykT84sO0H+7lTTYGf/aAiIlNW9Xyn7zVHnKc42C/UKg5zzmB9Gced9x4oAP3fPblm6TrIWB3f2dkKstjBMOQggjxUvpXpoWVyuVl+IsxKZWbvTZVRVI1Z6zaSQ616qyTR/YREASN8gKu5QioqhXp3BW26m8CqB5BEVwU6kvDj9dRTEdFV9rQn3oBem7l2sEUMM3ZfczTYzgreOAr89e/uKIsGPRJioH0okNbSXn9osVBo+6kiuy+9lwVVzHUasYcMK+wv7GrkV0lv398HfOUWe2EuWmBUzUCGtrmdLpyn3LytQ0qeOgptpveL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(13003099007)(6133799003)(11063799006)(10067099003)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oVqcpAIsAPPa1ZNAxkkTxqEbX2Q5ZzIw1MsSJzjbMUKTxiPA7ymjn70GYVmu?=
 =?us-ascii?Q?rsOzl4xgZyaKXcQGvXMy/bfmFMP83bcWDka/0nNRAcDoWWVhiFVghP8Gjncs?=
 =?us-ascii?Q?eyOZWLu5Frdzyl/9Kv8zVnYAj8XRGfNTjEkTINSouB5BOvWwxXa5PG4WwFiw?=
 =?us-ascii?Q?Bm5CQJ18ZyaSz/4AdTJ3EbpqfDKLuXPxXVM8zLEtUBqIcf6gTuB8i/dv+noj?=
 =?us-ascii?Q?zoz/SR7ZsbPi+tlSff9h0Jqj7LpJcC7UpP4o2nwOhG3azlkZBFxKthppe3zm?=
 =?us-ascii?Q?cbps2HcYHXwVETHbm/Ns4s9cl7RCVPAJpTSOIP4M2enCR4eZ48lAUYdu08vF?=
 =?us-ascii?Q?r/Oarc5JVdSUPS0nNG0xGsCn+oGrS0Tm16i83YhMTDvf2XpSh7DMo0ihY+0s?=
 =?us-ascii?Q?5keeKFbs7GQ4D9FHY9Lg4NjuaNcneBMTGfBUvpy+6niJcyGruG8ZV9YGnxpZ?=
 =?us-ascii?Q?wz+wGgeyKwHxHw16+a24wV7gPyttnJWV4P1NzPi0EeJ7OIeyaqRbMYb2Ho7n?=
 =?us-ascii?Q?vOk0aMOmgg8f/ouYsj1P+1NjoKpyt6FstYWENQ0DbfdkDjk9k/VnIXI82d4G?=
 =?us-ascii?Q?TaB3KKAeHVEncx4MTAAwEyUgXM9P+czSLgLL7/TeVnWET3v0D0LuostMOn4O?=
 =?us-ascii?Q?99ij7WYoYk0vX+xYlgL1EayV+eJGlsR/vlDylXIE8xVgT935pWju+R6LUC7U?=
 =?us-ascii?Q?nQWDTnVUsFox4PzJrE1VdhCRskqTeMMuvLv/nKWQh6vbKkSwBx4TqhryUdZG?=
 =?us-ascii?Q?+Ttj+bTutrqheHUMJZUQ77YlzXpPk36s8krgv1Xh+9jOHLmjehixVXjPswqh?=
 =?us-ascii?Q?Wtrn1B5PU9osZeKusZuL5gAcXT8xRVIJq4+QG3DQj2/Frzt8LoeDcfJkSz4r?=
 =?us-ascii?Q?JMaZsNv3+31UhYw6MkojvcvGxKgF3gmq3BG7zzUQ/AnOsDH10w5LtdT3gKqe?=
 =?us-ascii?Q?wqJWGD6eiKYVcClkjDno8rYeoDMTWkkn4f+krpA0kCaUQ6n2hKqFfxt9LL5A?=
 =?us-ascii?Q?TNMy6MiSrsMqTGeW1fWaB8iH/jkQUG5iUpUuBAFyr0v47tzJk6P6rhwQexb8?=
 =?us-ascii?Q?C2C0qVBPaurNk1zvGwfqKxMpMz9J2B0S1ZWxtszp/eyC+CC7nAJNuXFp1WNf?=
 =?us-ascii?Q?rOuTfejIC03qRAeorsGTdDC4qnuQLf273omk8+GCj4EPUQJ0zdB+5GXQQ/KC?=
 =?us-ascii?Q?LhFyvGkeWYLZa/SPRRydBp1X1rfaaqVKZX7ueguKawnKaEKj6BvUu17UvN2N?=
 =?us-ascii?Q?r6a3tc8dMTxSo5HLGKBn+p5EF6uodLsxDvIlwyyGq7COwRe0zU9UXQcJV1jX?=
 =?us-ascii?Q?IUret5RVWM83tLvX1CuO+Ymhyd/hvKL3tRnZtPYAgwJ2Y8zK45vI53UMZTmr?=
 =?us-ascii?Q?PHxRFn/gI99pDVndYu80GsmQA1yukO6T2ap8jW8d/nex7JWaO1nCX2Ob/aWn?=
 =?us-ascii?Q?PM1BGu0aRNetg7PSbzmdUgGhc3iWxWCjfuALyLQsfjpPYrq/pJw7hgvRYbXh?=
 =?us-ascii?Q?2ImtQyGCVt/5k7b8o+uW172BveWHdX6yzEt4+fF5NjCOo42oqkqf8yIKucEC?=
 =?us-ascii?Q?UEiOe2SuOImi3CH+agMsvCU5/UAnkDMYQ3XIFJTCWTjoOocashUXj3flaN/i?=
 =?us-ascii?Q?Q0tlrI/SpDwCc4UeUdh8BhEvCnuJaMwTpO4yLvHdUPpzjgFlN0s75CZ6GZ1l?=
 =?us-ascii?Q?9AW1CatH9ILwiurJY27AWVJ/XFJjmp2uwezj2pQ6VXvwkmSnd/OSRNCPwvxo?=
 =?us-ascii?Q?+PNvoAnVGJRLKUc1eClivvV0GcONosg=3D?=
X-Exchange-RoutingPolicyChecked: Q59Dg4xZqkKyIDlo0MDFJcbV0/EVwvfJORT4dhrTZ3L5U6Q5NwP+HyqliV0f7fucsn9/soW+q9L2HVVDnFPPTQ5SqcuUDYn9APOjhScK24OSzAm+M9tZq5pGsBj46/1UehVQPXf5ugrfcdZY1A0qmWrpIDP99wMmc9p2Eu4EuVOxgKziuDkgdGBG3xwpGL07HPas5/KXfsQbRJxEzOuG0xZfo6X0PeM+U/Vin8lkYP8NYxZZO07Sg3blB7qS3o/9hzcTk1REMIqIZXXA4pQQXjunbYhEFq2uh1NC9dTChud59UlL4MdQ4NmHfDen73iQmXZ22QSA+iB3zc3nySs7CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ee6d24-c031-4c64-5936-08defcb51107
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 23:12:54.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvyshkLwAEqbNBf1k+bfODJTm/TfogwLdtiDfDm6oWL1P+DtNPBdBDoQC17jvVyFbuBtF5m8+nvdvBmuI+Oa4FtEBJzMBA4lUl4ZbZpOlCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6311
X-OriginatorOrg: intel.com

On Mon, Aug 17, 2026 at 05:23:37PM +0530, shaikh kamaluddin wrote:
> On Wed, Aug 12, 2026 at 03:42:18PM -0700, Alison Schofield wrote:
> > On Wed, Aug 12, 2026 at 11:19:40AM -0500, Cheatham, Benjamin wrote:
> > > On 8/12/2026 10:59 AM, shaikh kamaluddin wrote:
> > > > [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > 
> > > > On Mon, Aug 10, 2026 at 02:00:18PM -0500, Cheatham, Benjamin wrote:
> > > >> On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
> > > >>> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >>>
> > > >>> cxl_handle_mce() offlines the aliased page of an ELC region on any
> > > >>> record with a usable address; it does not check MCI_STATUS_UC or
> > > >>> filter non-memory errors. uc_decode_notifier(), the equivalent
> > > >>> handler for plain memory on the same chain at the same priority,
> > > >>> filters on mce->severity and leaves corrected errors untouched.
> > > >>> cxl_handle_mce() has no such gate, so a corrected error - which
> > > >>> the generic handler ignores - still causes the alias to be
> > > >>> permanently retired via memory_failure().
> > > >>>
> > > >>> Corrected errors do reach the chain: machine_check_poll() logs
> > > >>> them via the same mce_gen_pool_process() path that feeds
> > > >>> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> > > >>> extends p->res to cover the DRAM half of the ELC pair, so a
> > > >>> routine DRAM CE carries an address inside the region resource.
> > > >>>
> > > >>> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> > > >>> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> > > >>> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> > > >>> machine checks") established this filter for an equivalent handler
> > > >>> on the same notifier chain; the consequence here is more severe, as
> > > >>> the CXL handler calls memory_failure() rather than recording a bad
> > > >>> block.
> > > >>>
> > > >>> mce_is_correctable() is used instead of copying
> > > >>> uc_decode_notifier()'s AO/DEFERRED test because the alias must
> > > >>> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> > > >>> the reported page but nothing owns the alias.
> > > >>>
> > > >>> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > > >>>
> > > >>> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > > >>> ---
> > > >>
> > > >> This looks good to me, so:
> > > >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > > >>
> > > > Thanks for review!
> > > >> If you have the time, could you also share a script that does the below testing on the list? It may
> > > >> be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
> > > >> the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
> > > >> for people to run would help with any future breakage.
> > > > Happy to share it. One question on where it'd fit best: ndctl
> > > > (github.com/pmem/ndctl.git) as you mentioned, or drivers/cxl's own
> > > > tools/testing/cxl/ in-tree? I'm open to either, or proposing it in
> > > > both if that's useful - happy to follow your lead on which is the
> > > > better home for it.
> > > > 
> > > 
> > > If looks like there's already some mock functions for extended linear cache in tools/testing/cxl, so
> > > I'd recommending trying to put it there to begin with. It may require updates to ndctl after the fact
> > > to run the test(s) as well. If that looks too involved then sending the script out to the list standalone
> > > should be fine. I don't know if anyone will pick it up, but it'll be searchable on lore if anyone wants
> > > to test this.
> > 
> > 
> > This sounded interesting! I gave it a try with cxl_test and mce-inject,
> > and it looks like this can be tested without the QEMU CXL topology or the
> > forced cache_size hack.
> > 
> > I built with CONFIG_X86_MCE_INJECT=m and loaded cxl_test with its
> > existing ELC support:
> > 
> > # modprobe cxl_test extended_linear_cache=1
> > # cxl list -R
> > [
> >   {
> >     "region":"region0",
> >     "resource":70300293136384,
> >     "size":1073741824,
> >     "extended_linear_cache_size":536870912,
> >     "type":"ram",
> >     "interleave_ways":2,
> >     "interleave_granularity":4096,
> >     "decode_state":"commit",
> >     "locked":false
> >   }
> > ]
> > 
> > Using 0x3ff010010000 as the injected SPA, I first injected the
> > corrected error from your example. On the patched kernel there was no
> > CXL offlining message, as expected.
> > 
> > I then changed only the status to the uncorrectable case:
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0xbc00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x3ff010010000 > addr
> > # echo 9 > bank
> > 
> > and got:
> > 
> > cxl_region region0: Offlining aliased SPA address0: 0x3ff030010000
> > Memory failure: 0x3ff030010: memory outside kernel control
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> > mce: [Hardware Error]: TSC 23c5a5a9188 ADDR 3ff010010000 MISC 80
> > mce: [Hardware Error]: PROCESSOR 0:50657 TIME 1786573477 SOCKET 0 APIC 0 microcode 5003302
> > 
> > So the cxl_test ELC plus mce-inject looks sufficient to exercise the
> > path: the CE is ignored with the patch, while the UC reaches the alias
> > offlining path and computes the expected alias.
> > 
> > The "memory outside kernel control" is because I did not put the
> > aliased memory into system RAM for this quick test.
> > 
> > This would be a test case addition for the the cxl-elc.sh unit test.
> > It seems like a tiny, close-the-barn-door-after-the-horse-got-out,
> > kind of test case, but maybe not?  Maybe it opens the door to more
> > things can do we mce-inject elsewhere?
> > 
> > I'll leave that to Shaikh if they want to add the new test case.
> > 
> > -- Alison
> 
> 
> Hi Alison,
> 
> Thanks for trying this. This is very helpful.
> 
> I had initially started with the same cxl_test + mce-inject approach before moving to the vng/QEMU CXL Type-3 setup.
> 
> On the current cxl/next tree, I was first blocked while building tools/testing/cxl with LLVM/ld.lld. modpost was failing on wrapped CXL symbols, for example:
> 
> .export_symbol section references '__wrap_devm_cxl_add_rch_dport',
> but it does not seem to be an export symbol
> 
> .export_symbol section references '__wrap_devm_cxl_add_dport_by_dev',
> but it does not seem to be an export symbol
> 
> .export_symbol section references '__wrap_cxl_await_media_ready',
> but it does not seem to be an export symbol
> 
> There were similar failures for some of the decoder/CDAT wrappers.
> 
> This appears to be the same issue addressed by the patch currently under review:
> 
> [PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported symbols
> 
> https://lore.kernel.org/linux-cxl/20260721084009.38100-1-icheng@nvidia.com/
> 
> The patch avoids globally wrapping the CXL core symbols that are also defined/exported by cxl_core, and instead applies those wrappers only to the modules that need them.

Hi Shaikh,

I applied the patch to the base commit included in the patch:
>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

I don't use LLVM toolchain, but I do see Richards patch you refer to.
We'll need to get that queued for 7.4.

> 
> With that patch applied, tools/testing/cxl builds successfully for me. However, I still hit a runtime crash when loading the ELC setup:
> 
> # modprobe cxl_test extended_linear_cache=1
> 
> BUG: unable to handle page fault for address: 0000000000003358
> #PF: supervisor read access in kernel mode
> RIP: __alloc_frozen_pages_noprof+0x12e/0x320
> CR2: 0000000000003358
> Workqueue: async async_run_entry_fn


So there must be something different about your cxl-test address 
space. I have 
region resource: 0x3ff010000000
region size:     0x40000000
ELC size:        0x20000000

You cannot even load w elc = 1 !

Does "modprobe cxl_test" work for you?
If yes, how far can you get? Does cxl-topology.sh work for you?
I wouldn't have you try the whole suite since you are telling me
cxl-elc.sh  already fails.

Maybe we need to look at where cxl test is loaded for you and why
the ELC address shennanigans fail in your environment.

Let me know what you see. 

Thanks,
Alison



> 
> So the build issue and this runtime crash appear to be separate problems. The runtime failure is what led me to use the vng/QEMU CXL Type-3 setup for validating the MCE change, where I was able to exercise both the CE and UC cases.
> 
> Since you were able to run:
> 
> modprobe cxl_test extended_linear_cache=1
>         +
> mce-inject
> 
> successfully, could you please share the kernel configuration and any patches you have on top of cxl/next? That would help me compare the working setup with mine and identify what I am still missing on the cxl_test side.
> 
> Your result also confirms that, once I get this setup stable, extending the existing cxl-elc.sh test looks like the right direction for regression coverage. My plan would be to derive the SPA and expected alias dynamically from the ELC region, inject a CE and verify that the alias-offlining path is not reached, then inject a UC and verify that the expected aliased SPA is still offlined.
> 
> This is a small regression test for the current issue, but exercising mce-inject through the CXL test infrastructure may also provide useful coverage for other CXL RAS/MCE paths in the future.
> 
> For the current patch validation, I still think the vng/QEMU Type-3 setup is useful as an end-to-end test since it can exercise the actual CXL region and system-RAM memory_failure() path, while cxl_test + mce-inject looks better suited for the lightweight automated regression test.
> 
> Thanks,
> Shaikh
> 
> 
> > 
> > > 
> > > Thanks,
> > > Ben
