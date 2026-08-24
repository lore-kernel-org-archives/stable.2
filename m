Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518436F434;
	Mon, 24 Aug 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599931; cv=fail; b=lNyfBpYJhBYj3vhVH/eAcN8jzpTUDVYxaAec1dT3EsAv38O+VlusxS2zCc1dQmAd78ysal15LqqXXP4xbMlVx8GYK1WsuQKVWvJFLw5EqgcY9URY3rada+PyOPo58HZNvrH6OFCJJBhxMehvbVnh55hn1U/roitJaOkSbVXHf7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599931; c=relaxed/simple;
	bh=93siKKbap4/ckt2DbRJtGXGejqjZgUW8akPhMkNr7wg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lC/yBr1Rg/1IbOyyS09LjVEBmd82G3pOZKVmSj9LqI4qRbmpiCAWYad1cj7BbNyWJgD9DImnQ7IVVIgk838i/8YfCMxEN7rc9vWRRTBZZkyA1pnXIYxBes/x7Q6R426M78QZNxrMroyf0PjIexVBXMJZEjFB+Gtr8JXBDNb7yZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSIkzIcE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSIkzIcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787599929; x=1819135929;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=93siKKbap4/ckt2DbRJtGXGejqjZgUW8akPhMkNr7wg=;
  b=nSIkzIcEw4ARaWPxyYg4Fd+w6QP4mG4ZWzPv9aM/yr+NdWdWRoj2B6Ym
   JewzvJIV0tsqb7IkW9K/kyRhmwQpr5WZhverun6QDdWZz5MmIDyAwv5xq
   /xUfzckYgQavrVUeYPMEgS7HWkvYEthWEDQ8X7paktyEmdOwCvoZ/QuQN
   23UT4NcaWTp9sFKAfsqzO9ZA6mDbWEC9o0mfb7t1XpVAiu4T+TXCG7f68
   wNviXdp+o+uteOjpCh7Xdg9lkYYn/4N8aJUnGBHL12M/L3dLQP1rVTu6x
   jk4NR6zRVeD+ITJkA1XqxQy+tiUx/2z+HK6pmuYUjjPo7j8G00Z99972Z
   Q==;
X-CSE-ConnectionGUID: AvRdSJEzRFu90PKmoQfK5g==
X-CSE-MsgGUID: hA7OFYWOTH2akTrajfHJWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88266002"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88266002"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:32:09 -0700
X-CSE-ConnectionGUID: yamfU24ATNecXYOl1MKzoQ==
X-CSE-MsgGUID: QlhiyZ7wQa21i4daY3uUvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="263805368"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:32:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:32:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 12:32:08 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiNsv4RdOvxRcDf/seOMvHw5n7hAvw7rZLrPXdlgats2xxRBtDD/ZXyNHFm+F2wOPqN1EFX9lbedOnLnvgIu7wJCCDV6sn+5Y/1t9VwnVW1OFwv6+PXfZWiEge33NEn7d0V//ESe8VGstqP039kSEUI6nSY1VqAZ8lGdE4nahBuVKSB15ojXUksC+wxKcPv8czMWI+RK0hYSZY029RBJGhDWy+kdZip0pTS2RmcawYPFxPQ/MHyv83jRNxqWdiUgBZ+fjMJtgx2LLi37+H17LKPjwxS3uPBf8pW6b2rz4s7SIL0Fac+AxA95BpHAnX2HfSysqx1fmD1autRZDt26sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4jkCVLipYpWniWDBZiJ+uQ9lJh4Kk9dHnPK8v3FC8k=;
 b=XtHW6RiamoVa/dQwH07WkRtkwCiumz7vWDn4zaeYoH9ALvVOrkwGsL6IF1tRVm8+DsEOm/Kr8mw9vLhzn1INCaGsW5UMuOQ0zXVmEWLVM1YNrhasI2XrogZHV9sLxoY79aNVGxIlskj3FaKbHr2wAX1elvLGitHRuWIgbZOefnAd0HyI+F2A5zfybsOu1t+ZRebP9FtXc10JUHOsvQN4SHukuKMDg5osgPXQnNilOLthHudToFYGsTRef2q/H+boGQet4c1iRih2M5sYx25zQKmP9+5fSW3+0yWGJjtvOWo02LZUQaFaNpW2oC4sEwA0TZnLdgR4O0KA6vtHT4DJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 19:32:03 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 19:32:03 +0000
Date: Mon, 24 Aug 2026 15:31:58 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Raag Jadav
	<raag.jadav@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Ramesh Babu B <ramesh.babu.b@intel.com>, "Michael J.
 Ruhl" <michael.j.ruhl@intel.com>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Message-ID: <aoycLvvrNPpZ0Ba4@intel.com>
References: <20260811121008.1493015-1-heikki.krogerus@linux.intel.com>
 <20260811121008.1493015-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260811121008.1493015-4-heikki.krogerus@linux.intel.com>
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|DS0PR11MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eee9f7d-d00f-4d33-55f3-08df02165fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eimh8glnvgd98JmVNZjQd6ZGCVDnUJK/9eQA77Nhfl3iTWI8Y9ptVQFtvXpogda29lURfAKit6SHXrfwFofScxn+nFHoByJFPdXd2hsKaIz21CzcvZdZ/yxop14rJuekYexVaL9pIinrQnRaxyz6yDTfGnqaBDFEehRBPdnLcLYjwj5rp/U+wgyNpT37z+2/PpOWE0ja/s/kgHIlrFA7gkC5S2jpM9EQ9nuA0SCQCZGSwtzt4qa4ZmNueX15XS4fZIH7AjPgPTtb/6rkydLYABRPlLersJGndC4U1x/MN+kg27ZUnBOV9CHVMDjDbvAKawAszZMQ5o/HgyA1GTGsWZ0hwvKOa7RY8aSbgUbQqelw9xAPEwijz1WoKo38hSmL9ZsnfAPXNfFteOGOIa52bDY2m5YHIxxHy4NCSw2G4pJiKrhfxW+v6RTEMfa83L12b30NBKJcFlMumC+t+VPV8M79ZIXBOIFXYoh1bjMmovr8X6zznCJQSyl3DAUARykBJ3TM23vr4AWyXwE0wR5oXEj1mjp8tezPRMNHLa41V+Z687yEUmlyKjHZ5t55MswoVpnigqZdI5WcvDIf0Xzx8IVInuEFICp60nGMxk+aoDnaMmy4/KX4Pnvy2T9dtMTRDKKDnvg4JQ2bFB6EFdlzKVnH5ip8DQXLjZnUXonJ4H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CjEqFHn/zD+k4NcL4wxL+Z5fNg5qKg5dVqbMZias2i6+VRZi+KGoQ8lbMPPg?=
 =?us-ascii?Q?Wf8uMzv99eofuUZHZZt5rlIduigO3EsYHoq+u4YSh878K7aWo6Mg/d+ANYN7?=
 =?us-ascii?Q?2gHG2DGydWzxHKaaFj0vun3vHTgLN/+TeAmq+Kwy7znwPcQFp+4n7kEPHKJs?=
 =?us-ascii?Q?UUZm08wCB3ZE2ecx55WN4DSZoMsj56DHU5ae478lvHNU+BLBEHb1wc5tiwvr?=
 =?us-ascii?Q?DwgFxoizvOpWNsGwdGEkAziJFujEIPToJXa7k/ZrWsblL7QO+adK5NB2s6jm?=
 =?us-ascii?Q?QeBoXVTq6tMeVpj9XW0l3KYN8afKNZlpMsa4mLgB+IuCGzfGcIvK/jfzv9tn?=
 =?us-ascii?Q?P0zq7uHKknc5KK6ETGMk535AlNnc6ilnup69RxuqiFZ/AE+ual3LhBCsghIo?=
 =?us-ascii?Q?ZPDqapCtzQpb+62p7f9ELGy6B+9Baw2yy5T18Q0lXLS++7bem2FSssCHEHLg?=
 =?us-ascii?Q?yHhYpMG3ArIwGM8qavcJT15GMVu97l+YKkNPQ5LcTr6R8B626M6uU4TESDZv?=
 =?us-ascii?Q?FRPQUD6k+ymR6j62gVjkVgDg+YT7QRw0vN7lIzZ1oI35QUggdh84llFIA/Uy?=
 =?us-ascii?Q?9n1oKdrdy00xexLPXxWogYnLXfn/U18q0O3jH1MUSWYa63K7xh1nPXkhq1Jk?=
 =?us-ascii?Q?5SECVCy1U/uVhwnrAcFcUTu+5HvisLpGSULmVzUhGnKSFCEQ1Qv6O8ZSMawF?=
 =?us-ascii?Q?WZRXjM35dUpdEvv27YlygGUT+8Maz+MU8QENYznZs7hIC6W7aK4bLYnzs5fe?=
 =?us-ascii?Q?ykgFupgJgeoot9T9WRccU64F4aSE8YVBuVCl8cPEwil9o7KEtX4AJqbMc9kg?=
 =?us-ascii?Q?bewYlppb6PKBvqGnR8vUj4o2sRd/g7WR3IWXh446WhYydBaHr27oMQH/T91f?=
 =?us-ascii?Q?q+g4g8LODOhpiNb+imyyReTrLuW5KDxRLHSUQ5GEbkavBirTjKz1SIQ/m/I6?=
 =?us-ascii?Q?6v/qdCWEKJM8vLva0pyOhchS+yQQfGyPA1pZLqGIi1/gmVaHPdD4+x9IhbSr?=
 =?us-ascii?Q?cA6F2+KrNa9LZev8jnVX31TubbBuM0vo3XYRoCR/s6sgfve1pVUaMBGaFob2?=
 =?us-ascii?Q?y3Oya75j49aQOWZtsxLJtLq/OxZSB1Cx50UYdlf7DxVZkvtoJRq4a8flL75n?=
 =?us-ascii?Q?tHWvGJZpn/qYwintOywWeAOgQxcFUvDfdKMLMin1eB3yq2wFYdmeganrSJS6?=
 =?us-ascii?Q?7VrAKvQq6SAKiy2BcNSpLlbQt+5/D+lxq2mWdhHO93Kw188cqE1g6+ROGc1Y?=
 =?us-ascii?Q?ncWaHBnrelef58mceZ+J3feIIzW8frMEF9OXFetLsDeV4FAsQF7yiqx22M0d?=
 =?us-ascii?Q?WbRkkcnKwyzm3YrgvRW70pCfJLW66TgIeioyxhVwiB8QjTXgSWIsT/1GklcD?=
 =?us-ascii?Q?Tdk0obkcF4rs6+iq0YQc5/4Y5U0ONTHyfkoRw5WoAbH76Oz6nUIvgQCEF81/?=
 =?us-ascii?Q?UFGFu6VY2ZNZ+Nc1qKlGGVWOMQiFLtsHZV1tNiHbidZV9TkvL0MUY0WpjGuG?=
 =?us-ascii?Q?2ka062xRh2RsSNaB9PpFhxgJyg62wpULDY/5xqfUDvLAum0IkSQWJg/hyVeq?=
 =?us-ascii?Q?JjLvL3nnPL5qrrWmkTTYhFuWcBW2gLAVELyyV0/8/KVU/B8CoLSlei9lz8ny?=
 =?us-ascii?Q?+wYcNeFPgozzYhJ7RWb4GKruxvYXbGC2WiIK9gyto2aTSAw5l6cexHQzWzKk?=
 =?us-ascii?Q?/nzcUHrXeeF+RWVuhyCdwU1XZkHIE8Sur4tBYfX6HJ8rn9ZiT5PyE1+96ihJ?=
 =?us-ascii?Q?q7lZ8328HQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: L5B0dZWYb7cVfqOOAcnlruubU0kQmrA6mrl8mIlTXetWILcYyOve1hymgtn/mjafXXOd9OxOwub1StR8QZXeU+RepsVFaDjdU8HosROO4+V/lWgFCKnIMEdUC4B1KI4VeiP8cDSRbo9E5U2e9+vJPTDeNkVpfdXmPMiOMkVbhK+r2rfavoWiOCly+30VC33ujJJrjpjbY6Bkct5g8xxfu8j7Ypb0hUgjkjTyZnffiPKY0mVFfodwpTvPCG/dx+Q1vV1/YSzz6np+4fwsEIrH7uvMRznaxDw9Vee1OT2l7nFt+h0rvdd5cwWJ+hOv9SFe0KA1RbpIwHAZR57CQ6aVaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eee9f7d-d00f-4d33-55f3-08df02165fe3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 19:32:03.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4m86rKxkadns1/4D+NojGYepvXr1/mvLVgnDPc9fLcIE6c2TO1hAhPRFE8xxOyZvScWFNq0hjXnHJV3mpuW8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
X-OriginatorOrg: intel.com

On Tue, Aug 11, 2026 at 02:10:08PM +0200, Heikki Krogerus wrote:
> Some platforms make an assumption that the i2c controller's
> enabled state indicates also the power state of the
> controller. This can create a problem when the controller is
> in disabled state, because the hardware may assume
> incorrectly that it is then also in low-power state.
> 
> To fix this, the controller is kept enabled by taking over
> the IC_ENABLE register. The controller has to be disabled
> when the configuration is updated and when the target
> address or the slave address are assigned, so disabling it
> when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> then re-enabling it again.
> 
> Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_i2c.c | 49 ++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_i2c.h |  1 +
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 32767570e43d4..d8fa68206f418 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -8,6 +8,7 @@
>  #include <drm/drm_print.h>
>  #include <linux/array_size.h>
>  #include <linux/container_of.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> @@ -215,11 +216,40 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
>  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
>  }
>  
> +/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
> +static void xe_i2c_disable(struct xe_i2c *i2c)
> +{
> +	int timeout = 100;
> +	u32 status;
> +
> +	xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), DW_IC_ENABLE_ENABLE, 0);
> +
> +	do {
> +		status = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_ENABLE_STATUS));
> +		if (!(status & DW_IC_ENABLE_ENABLE))
> +			return;
> +		/* Can't sleep here. */
> +		udelay(25);
> +	} while (timeout--);
> +
> +	dev_warn(i2c->drm_dev, "timeout in disabling i2c adapter\n");
> +}
> +
>  static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct xe_i2c *i2c = context;
>  
> -	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> +	*val = xe_mmio_read32(i2c->mmio, I2C_REG(reg));
> +
> +	switch (reg) {
> +	case DW_IC_ENABLE:
> +	case DW_IC_ENABLE_STATUS:
> +		FIELD_MODIFY(DW_IC_ENABLE_ENABLE, val,
> +			     i2c->ic_enable & DW_IC_ENABLE_ENABLE);
> +		break;
> +	default:
> +		break;
> +	}
>  
>  	return 0;
>  }
> @@ -229,6 +259,23 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
>  	struct xe_i2c *i2c = context;
>  
>  	switch (reg) {
> +	case DW_IC_CON:
> +	case DW_IC_TAR:
> +	case DW_IC_SAR:
> +		/* Disable the controller. */
> +		xe_i2c_disable(i2c);
> +
> +		/* Write the register. */
> +		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
> +
> +		/* Enable the controller. */
> +		xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 0, DW_IC_ENABLE_ENABLE);
> +		return 0;
> +	case DW_IC_ENABLE:
> +		i2c->ic_enable = val;
> +		/* Other fields can be updated except the enable bit. */
> +		val |= DW_IC_ENABLE_ENABLE;
> +		break;
>  	case DW_IC_SMBUS_INTR_MASK:
>  		/* Make sure the Alert is never masked. */
>  		val |= DW_IC_SMBUS_INTR_ALERT;
> diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
> index b200966b00484..d63adacfefe71 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.h
> +++ b/drivers/gpu/drm/xe/xe_i2c.h
> @@ -37,6 +37,7 @@ struct xe_i2c {
>  	struct platform_device *pdev;
>  	struct i2c_adapter *adapter;
>  	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
> +	unsigned int ic_enable;
>  
>  	struct notifier_block bus_notifier;
>  	struct work_struct work;
> -- 
> 2.50.1
> 
