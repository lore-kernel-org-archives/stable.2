Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C834477E58;
	Tue, 14 Jul 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044473; cv=fail; b=ABsAOg05d309+H5PUky0OuuP+HazhGjNees/m02aKeQPpeWE8+nwLL366qweaExxsiZSBPMtvLtqdLCBTsMc3Y3VVIivPhtf9UVCnchGQSiK/UhEKPDa2fpqWgI0BEnHlAI/TuVfIPhYASw6cZy6QAjtEO6YRgTr4vnGHGbXsgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044473; c=relaxed/simple;
	bh=As5jI9ByobXnbhcV3vdMYQ+ucFHHZhSzyZ06qCezIuc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nHqn1TATjo9AaNf6E0o97mE5Qa5F360AIHYyKPsegF+v6Pcujxkys4mcZ6x+CyHMu/3B2+/h1aGdwSMtYJCEl5rXWB5c737ls7KCLiwXa8xykDmDbyflfgHbInoT1tuRybsMvKcFcAtKI1hP69M+b/DSpjKyO66Lmyo+Ycq5x/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXEKYfVt; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXEKYfVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784044472; x=1815580472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=As5jI9ByobXnbhcV3vdMYQ+ucFHHZhSzyZ06qCezIuc=;
  b=PXEKYfVtf2SJJCz94YE7mhpBzrpzpJiVZocTB1uZ+IbpA/qQRAycOug3
   DsQqsSSfvjHWvFJfSzxT4bDVtHGwvrbZwJrQVuW30PFkJdn5Hu+rO4lYy
   x7ZAZd906MpmdmalblzKvLFrmastTRayvG0ZaxOq+lNhBEHcEgtImgf9v
   +PRoONNiTGjyyoy/ABYDHBYq3XdzXGGLbYE7Tz+nZTOpg7HZB37+Ft6MD
   m+QBYjv0L1ZTR00+5En0wfJV5LcBi/Pup/cmcN/i6SuSZGZa1OAzKRi3q
   wXsi1Tyu1bYwT0U6Qc3Lyu+ySefFjSyNCdEmvq177FOtCYo6o74Y3P/gG
   Q==;
X-CSE-ConnectionGUID: D/F38XjnSEi8UqkG/grgSQ==
X-CSE-MsgGUID: MDEIzfiaSnuyY6txqkTZMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102093855"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102093855"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:54:31 -0700
X-CSE-ConnectionGUID: WgbEjWMbSaGri5CM2QY00Q==
X-CSE-MsgGUID: j8WYPl34QhCnihIYb//RFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="256551409"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:54:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:54:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 08:54:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf1a+eoWTsOi1oKK96eJtvrRP+nLgPjZZdQ9zCUuEH4V4pVfejOIhagtydHGJT+ckvjH1dv94Sc5OcoOL2udd5582t62nn5smODJA8/cX8/WNu0Xf0xD0FWdGOYf2+w8GeY3NfUABfPS0YOCpQMKoP38JikgfyA/hpxaqxJ7Tpam0XYZDNC5LbNPq597tsvOnoP/JoPDWEkgBVOT1dZf8T4yE6hXnDYXOZpO1AG/kXE06AblofiGyx/Z9fQX0mpEv5QHYUm8PafFJBcBrLBEemQe1UqSlMgR2W5IB3n+CpzC75Hv5bj7k1VZszvaL/8C0dmysU2aZxZa/lesgW+hTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upbt/IpZYN00bNnopCcvhheJ/tXxOqxy1G6BFBJxJds=;
 b=hqju+H0CSDs44+wcXDi1H+UZ327dH5yEqmtpgI4RWFS/qG+c5J7oftLexcdRyMdS+VrylIa6usjyVLP9MDc/cGEomGLxxS0FCijtowByXFpaZTU6WTFHQz0nBIvmwULcjURHgINZCo0QinEQM3Ou2kRATMG317bas3d7os6vUebRcE+C2asBeXwdtBsVBVLZ3WlkAU10UsSYcrCyXzkuAg4Huoxs850PpF28MH8xBTL7r/ODt7f/dQ1HSRR3Ynu12zynIN5b/MiLE6TznGV67bOdp6PMgHq27zdV1MRvs40TgkoSVrwyXTAsQlBP4v149YKPJxrWJS6W8kZ8MmUP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SJ5PPF2F2B659FE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:54:21 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:54:21 +0000
Date: Tue, 14 Jul 2026 11:54:16 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Raag Jadav
	<raag.jadav@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Ramesh Babu B <ramesh.babu.b@intel.com>, "Michael J.
 Ruhl" <michael.j.ruhl@intel.com>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] drm/xe/i2c: alerts and controller enabling
 modifications
Message-ID: <alZbqH51wJjm_CVC@intel.com>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SJ5PPF2F2B659FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ea53bd-2912-443c-f2cf-08dee1c02b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9wxz2Slo6KwwR06T5FJYRHqURzykAvUCWsUDYefnzOf761jcmtoVn+SzUIZXqE341JekztJwPRNOEFWZguACGIBJoBrtTx5BtJYQ5PhJHOKY6BH3ADfD/SZ75H6F1/YUfqAiK6Ss8KouPF7D4RXHx1YQ2eWBSilI/4mguDzvJLIevI3149EyksjkMq9rR3fF09JNpTaDj6hXRlq0XBMLWg0FAbrHk/9htKIa1wAOy+yy07HAmHElw2SC4E/4HGkmf8oUlcwH61bAJV1eXgaD4r3ZsBd1lnqUfGW0vtsXNaAMRkqbvjhGObMz+JJjKqwT8PR5osz9mAB6EKnnZSwDOFeTDznxpoWr44ohMYIm6Sg1mUXOoQNzfl5n4N8s7Z5yK8iAy3in68rJWhoo3QIZ7XG8ZJZlPaipOAhZ1KYHD42SWvFHeSsLsgC1h+5mwVR7VH+jEEonXv9218XKY3xmBj7eUcPYKYUDzzEEV+j78ZOUYrxbZ578o0qrHv8PIRRR5/BONzjCkPbvmYnmsrKejz+kHpd8Eq/ZnKOxZ62zGVgpLws0LhP09HgBYOZjeQV536Ufl0JE5e88HaVHzizgF2LGKE2coPQxX3XkJ7FivpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BtlyUBYfOFauomfKpTSMrtShDIUoR1Jli1WCxdhE7xNTtz36u72tEB3RQ+8G?=
 =?us-ascii?Q?C2QwPVBQaA84Z6H4iyp19B8IqKzoiJdXE+DZqktW6lmez2dt11lV8Hdlvkkv?=
 =?us-ascii?Q?q8tQnVaWdZVHhXlYOPxA1rnL+WVKyuWOh9oO94KB++1iByx6ddzTlFCKxs/W?=
 =?us-ascii?Q?urBmc1nlyB7gZ8dvc7qom4pWYXAUgCDz6LjidCyb4iFobM0Rd258+NDzd9Ui?=
 =?us-ascii?Q?dup6ZKpblzbOeLbzU3AsbpRjWCzH8GLvtF+qkl0zvJwV9Nav3Uwb7v9ICgVv?=
 =?us-ascii?Q?WuTya0zzVTw2XFhVH8OGfDHy/anJCdW9WYXFMb4BlNxUT5JTUmrD5WVwrTZ+?=
 =?us-ascii?Q?oUX3Rd15pxYi2fhUYI3BTeBImnrgQZ5Ckip4m8fbPU2qCXroUsQEVZYzhYwB?=
 =?us-ascii?Q?8RUWUEMveGmQfsnsQ8YrfNWOgLRzESXhIi3xBusVy5ZrhCXB4SPAyS6u/Ykm?=
 =?us-ascii?Q?dobQublp+z1dfw6uFhRmN3SMmVjllVDoAIZ3bY9AU2Z94ea6YZKkkfpjgby3?=
 =?us-ascii?Q?xG7RByjFu/ZVmmoWzHm2PXS4mRueLeVVxPbTPviTomMg2+UTsz4gcNzoNba7?=
 =?us-ascii?Q?8X4CbQ/v25BK9a4B+plC5Qa2EmRBGs5vJl158i8cuWVq2z0sDpBZ562RpsYE?=
 =?us-ascii?Q?PHU6c1hIKq1Ya6fET5Wz7crNmHGJNS/+s7bf9TNMyMAwoep2KJwJU/Jg0f58?=
 =?us-ascii?Q?nKMC1CC3Eq31/Rx+bIgTzusHXWF6zSMqT4/okyQ2dHbyQ1rrxzWqrhTXGJOh?=
 =?us-ascii?Q?y7Bj23RlGrf6YZIFIVQe91/l8JbYN85is6tFF4yrAThpKmKn4RUJajH6uDHZ?=
 =?us-ascii?Q?LOZBGK1dPkQuSytR2yHl6wwlXHmgMjQfn9PPfe65tNHzk/0Lnpx30B58OmAR?=
 =?us-ascii?Q?dGDaASplpRtgqM1OsHzMjTZpAjGa+yedcJhgbC2QqboQKkDlEHD0o0DYbWfR?=
 =?us-ascii?Q?EttysMwVZHSBU0Zq4IR0HSLO+go+kpbgdQYyc8e3l4QEhtGVHkTqq9BXZODZ?=
 =?us-ascii?Q?adUsl7OmnTaJlCg34S9ZXHE8niFnmFtyoBkCMx465pxLTlYWN/FkBmh891sT?=
 =?us-ascii?Q?lE9SOsuSKLFAy/ym9Szyi/j7YGR07NWw2OE+5sodhgT8TlFItgkoIBgTQOzM?=
 =?us-ascii?Q?a1+r1+TZTX+AB16nbZW9A/JGTmRzAK2pgJfoeHVxrbATM+Mv4LJmu1gTJjKt?=
 =?us-ascii?Q?BuW1YmW+Lkhz6B+oKXshcZxP47xtvY9ceY3doHzU9BKM/5NveQ1pNs3p9Fl4?=
 =?us-ascii?Q?HyR7gfAPP/EaMYLhoRoACTnRxtICyHLoibU7F0tTU0Te04O1Frdi1AFGLWA9?=
 =?us-ascii?Q?XXMyPBL/P7ZQdP3QR+bulrCgQNHbY0sAy4+7YfuM+2SIR08DqxmFHceSovgT?=
 =?us-ascii?Q?rxe9V4uFXvvUkCUZJ7jX6QWWLSvLUWn1XVh3+mmTxnmD0fddnL1O6n9Oshfc?=
 =?us-ascii?Q?mZhPQgK+l0E8mePt4LHDvxRL6XsAKoKDNH+C5t9vhW8rVgHOTTKU/wKhDiKH?=
 =?us-ascii?Q?bMSZXRDkZkYCZuSg3M1W/FGP4NObfLNbDryNwnleLOTa4lsRJN1eQaIytuC4?=
 =?us-ascii?Q?D+ZFi7q8LiR+z29HHPQhNHIaZVk9kHlUW9IfGsIzcxaJsXp4U8nOUYBE3EdS?=
 =?us-ascii?Q?syCRLjpjlM0H87bHcuFBTg4FejGbX3VhO88pa/ArSuTH8lIHuaHRZk0i/frU?=
 =?us-ascii?Q?jQAslp5BA3AaSbYi45YJuufy7Q9RN+UQAW6kAXdttiHWOyju/AgUKg9goHKQ?=
 =?us-ascii?Q?2ceuL0Vg1w=3D=3D?=
X-Exchange-RoutingPolicyChecked: hoW6mOacHzEz78S38qMadAHIf3S1E97YXfp99HtUbgBiEEWIjqajcI66MADfgJ5P8px6pnNePgk7xuFBOudUbo2vh/wTZUo143r1AhaaRc17XgK2lt5z9TcbpbiYoVgSPsqjj1S3lK7aUBClPy7GUhHj8aPf2dqM3z9XVUGzjMF95mHrB0p21ZuEIngUDz+ljxUTO2yGThEofOIAqLEWIa0buyh693CrCRGOjrz6YY6A6FNxOV0ZvZhUS1pWZMxzQkZTItBCmSBz6lLrOsKyx+GlSJMoL0O0x/BBkH8mzSUs5vbOOUDp9z56AQ+26Egu+PuB1Q7KtPYQIrCevkLg9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ea53bd-2912-443c-f2cf-08dee1c02b5f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:54:21.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M158hw+1d32PrctrVKy/5kRjVO/Yw5AKl3QX7jHOaMQfVoJ7d+8/vr35ozv45W06JKtlwsF9Y/L4R/YNmFLSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F2B659FE
X-OriginatorOrg: intel.com

On Mon, Jul 13, 2026 at 05:55:58PM +0200, Heikki Krogerus wrote:
> Hi,
> 
> The hardware challenges that these patches address are so severe that I'm
> marking both of them as fixes. In both cases the GPU may silently end up in
> unresponsive state (or worse). The second patch has been refactored so that it
> includes the direct AMC alert handling in Xe instead of the normal alert handler
> registration. The subject lines were also changed to highlight the fact that
> these are fixes. Ramesh helped me with the testing and with the implementation
> for the AMC alert handling.
> 
> Changed since v2:
> - Added Fixes tag to both patches.
> - i2c-designware is no longer supplied with an interrupt so it will be in
>   polling mode (ACCESS_POLLING will be enabled). The IRQ path in hardware can't
>   handle the amount of interrupts the i2c controller generates. Only the
>   interrupts from the SMBus Alert line are left enabled.
> - The registration of the default smbus alert handler is dropped.
> - The AMC alerts are handled directly in Xe. All the alerts will cause the
>   device to be declared as wedged at least for now.
> - Cleanups proposed by Raag.
> 
> v2: https://lore.kernel.org/lkml/20260625125939.429078-1-heikki.krogerus@linux.intel.com/
> 
> Changed since v1:
> - Global header for the DesignWare I2C registers which meant a bit of
>   patch refactoring.
> - Selecting CONFIG_SMBUS in CONFIG_XE and handling smbus in xe_i2c.c instead of
>   separate file.
> - Storing the alert device to the client array and providing enum for the
>   clients.
> - Allowing other fields in the IC_ENABLE register to be updated except the
>   Enable bit.
> - Can't sleep in xe_i2c_disable() so using udelay().
> 
> v1: https://lore.kernel.org/lkml/20260622114759.3464047-1-heikki.krogerus@linux.intel.com/
> 
> This includes support for the SMBus alerts, and special handling for the
> IC_ENABLE register.
> 
> Thanks,


Please take a look to Shashiko review and let us know in case of false positives:
https://sashiko.dev/#/patchset/20260713155601.711389-1-heikki.krogerus%40linux.intel.com

> 
> Heikki Krogerus (3):
>   i2c: designware: Global register definitions
>   drm/xe/i2c: Fix the interrupt handling
>   drm/xe/i2c: Keep the i2c controller always enabled
> 
>  MAINTAINERS                                |   1 +
>  drivers/gpu/drm/xe/Makefile                |   4 +-
>  drivers/gpu/drm/xe/regs/xe_i2c_regs.h      |   2 +
>  drivers/gpu/drm/xe/xe_amc.c                | 173 +++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_amc.h                |  25 +++
>  drivers/gpu/drm/xe/xe_i2c.c                | 136 +++++++++-------
>  drivers/gpu/drm/xe/xe_i2c.h                |  14 +-
>  drivers/i2c/busses/i2c-designware-common.c |   2 +
>  drivers/i2c/busses/i2c-designware-core.h   |  85 +---------
>  drivers/i2c/busses/i2c-designware-master.c |   2 +
>  drivers/i2c/busses/i2c-designware-slave.c  |   2 +
>  include/linux/designware_i2c.h             | 107 +++++++++++++
>  12 files changed, 405 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/gpu/drm/xe/xe_amc.c
>  create mode 100644 drivers/gpu/drm/xe/xe_amc.h
>  create mode 100644 include/linux/designware_i2c.h
> 
> -- 
> 2.50.1
> 
