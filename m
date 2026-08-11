Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B863403E1
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479331; cv=fail; b=N6oRrQC0K6ZbzOt9FYCj37W/W2DLKyuKrtN4iBXk7khgG6yheS61utF+LKljqe96xEB2eeufMloV/yFxZFHdZe/al0dEE7F1RvUiCk3+Mq/YcLMFcvrtGQzHE1dyJT3CZtZASdcrarvivjhqYoYT0IxQZ9gIVgsxyhsRK25C98w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479331; c=relaxed/simple;
	bh=hSL3EwReMdoCH/4X7x3sj3rGM1nTyle6Y4bPZ9xsVgM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jst0DijuI5Dg8qM6SKS06FrWQaWE6wZtHK+uJa4uHBjsTfx+mHhxdUqXhGdcPQLu5G959CSbuNxregym8pN+Mcen7mktBDgCH9BZ5IqjfjL5dBBtJLcuaJ8HsAqzS7EGYPZNwsVIMhv2pA9jFBXfrKg6ogiJDhuWuK9ovF0MtSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbNrXlgP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbNrXlgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786479330; x=1818015330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hSL3EwReMdoCH/4X7x3sj3rGM1nTyle6Y4bPZ9xsVgM=;
  b=mbNrXlgPIWmrJuLU/5XXNy3o03aWf9cCeGLIhJFVF27gQrteNyi7KiHH
   Up3yh5fjlL6QC8f/55OzkpIRdClMl2jnOipZ1a2Aa+XLFkt+f4joRBJGG
   L+Zq+3ZYRANy8/ga+drlci5sHSzIeYUpDt+1I5TEqZwKxCCRU8HwCpihS
   RSQD44h4V1XFnNWXF/WpRDcueWWmpBiZtW86TD9RfqYv37g3ywFyTqaI+
   HGQvdyAz3LvvVj0pgwqpWjp7cX1tzE7+KdVwy23LQz9ej1M2H97iykCd9
   J2ut7pv0WonhIsBgdDKgxKnXXo7RsSPcY+CA+dUTiVU9Z+3wPAJylu1Q2
   A==;
X-CSE-ConnectionGUID: Ovsx3PyhSKeKJ2AeTDGLqQ==
X-CSE-MsgGUID: kM21cymiRH6m3oVH3oiyBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86782170"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="86782170"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 13:15:29 -0700
X-CSE-ConnectionGUID: BvsW1/yfRaKmM1j6N/E+lQ==
X-CSE-MsgGUID: 2IHQjZRuSUu9QHWfb/RI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="267694245"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 13:15:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 13:15:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 13:15:28 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 13:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mam3OucLQ+tpcPrdHZCNz1j+zx6tfGMnyDEbmnpuyLOXGsSKRFm0qzwDSVQea8+Yy/bwws4H+vgXvj9ExLhVmT8nr2awrpP4QvArVTFkZvKgGgU5TCMVplffbmBqbKpqDexT8/ouzJsbVeLnLeXaI1auM2wiA2qPvL/B8FERVJ/UQfeMm2dASdelGzDQVqQiRl/zvkwVM/QoAz/yV8+vBW7x1fZt6YFeEQjKUQ4r88lax3xeUwj2qbRPSHP/v9nUCdTE5jNFMlmevgHkUHlcwMoTdPggmJkLZyfpGKw8GVsF00b1q+HZYbioGm4+d66zaEazYtHyQj2rVKrFQ6TGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC6Cq2hsy5z5dJDnQx3rpCs3w0S80LwukxiK0ieJQZA=;
 b=eBrANwoaOSmXeQdh/qDL5d87FZJ5F+QC3YhdHtl818ea3p865Rag7itO6PWgDLw9hvtcoylptr+0+12WNEYlPoDXEs0MYtCE449XAZcLV9ex4s8vHQe9RPt2bBxmg+u5DMw1Q+H23uFzNkhDi/LNrVdhAQdjB/SWixeDcsp1JB5iHQ3LBCpovgrJo3vG9cT7PRYiklg62jGRL6iOWBG+aK8Cd91I50axCljWk9B6uS7GVex7y8qb8bbMrPpDwRbNNTToyUtAYApV14qHIF9LM11GIIpNg7iGM2Fds4UiyzJOSX7GuH5P/jx9nVSWllZlh8EGucTd/1XYHSqrjc38ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 20:15:26 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 20:15:25 +0000
Date: Tue, 11 Aug 2026 16:15:21 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <matthew.brost@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v1] drm/xe: Fix xe_device_probe() failure
Message-ID: <anuC2fuCE4WvXy-8@intel.com>
References: <20260810123821.105605-1-raag.jadav@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810123821.105605-1-raag.jadav@intel.com>
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CY5PR11MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e19b70-234e-43f9-bd76-08def7e54767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: cMZG1RnmTCcWze2gbOlnCAtkFt3pTHmg1ZSv13Oq6WQiNx95ksqNTu0vahU0gJ+J3Eu/Q3WvfQricEAPblhD7ujx4sv7tGsbLOdcTQ+bQX6fOXaARgj1j1WBXXgEOpQvGVllttN4LcBQ+mA5IYMhOMPTOuJyir5oYpoLMmdqqz2YdW0CDWmndae4IdoxgsAh+l4gZUIEqMeIdk1sAfJlojuDp/oSXFXApmMcyJv3hgQdH9dO7xeD/xG90x2sg3eG3kzeB6BMD5wUD9UqkOV9KkNL3VW1FNzQNJRGJP6tgIPVvwbtuPyEOtSKTMQoQL/5v5ApYhykC0CLa69afGu8LmqKzI9QG8KxkhLAJwH3RD/WCZqsa7ytl41V4zJK6RYPheExSFmZOui+sLOgdH9sSBEKNYk/yO2S9sv+LFdDxmUXz8d2ANXCLcd57f76gYM4+gRJbpjWjdpfHp4zZAQmzRm53kqDixeAFiIEbvxi3hds9kvEtLbVTrfIqEY7BPrxu21MItvfFNQEBgTxlV5ijSuZo0D0klxaF4v8zsngStznXIipxzVrruUgoj8FRK1GKfhtECtmC5d9xB6VR2CenFWuSHTroekkRrWpTA9MFpjg1wH3qFJddUtwC5bwChWij7RqcJFmsufQC5ITqLQ6f96Yb5CTJoauBZvAULtUCaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWXBRXc5wyq3ncufpAAzXjDOsazZu0AfmkkUOMGiiB/4Zq94iIZbCEjZX3z1?=
 =?us-ascii?Q?LdkLL6ZZIgsxE20jPO+DxXjTzOYMuZfFwrUKc1Y7llMgyTOFcyvAzyYy0YXV?=
 =?us-ascii?Q?i8CZGFiQfUYO8FFpb1e+jcD+L9SmU5LRIxPO37jCMqhzEl+xGZjfBDiwOVMK?=
 =?us-ascii?Q?9mZDUetclQnKEDm2Uck35Ibtr0jnAK5g+wCZheHjfdbeQtH3MHJBY5qKSFlM?=
 =?us-ascii?Q?LvfQ+05h6RsXU4cehwgEZDKu+An1H8zIBE3kzwmVh4yG0+71YvD/3VG2ySuh?=
 =?us-ascii?Q?JTpb461p5kyjZ7Op5wqv+j1WUzNJHTDlM1WXfZyg9U1jLI8sTZiR3fXN8D4t?=
 =?us-ascii?Q?39x3KhSv61rtmmJRAIpjIc/JxwNF/W/6/uZoG2wwPG8QGxcgmmlgsuJ95aQU?=
 =?us-ascii?Q?yzC0fprzM/Gja/KMGNxbSY+07SeS8I/+aSYlqndM/KfbEn7xCtVkG+SkhZ7w?=
 =?us-ascii?Q?YQLyzbTlsQWUby6trdotKuJ9zvfRRZedCJH04/Nt/j/BrbsAig5ReIggS/fU?=
 =?us-ascii?Q?OutfmFDEhs5iriGmJRz/U6YoXrqJ9XtFm/u1sG6xq+opzi8wq/pizXlzV88l?=
 =?us-ascii?Q?nDNTPqBlOEg/WD/f5TUYKuRa1N2iZezHKyGLM4juRGgFz8d6xLsVx50Qg4FB?=
 =?us-ascii?Q?fY3kbd9nnMSfUAkkhUbSbg0DdnoeAeWEGG92mgmC0Ws5Uw5BKnfF4RvrQNni?=
 =?us-ascii?Q?vT1TzdNopPpKUkGPC9kK+y6XQh8w5o4Otdbk9asXC9pUDRVfY2HITZBmEZAk?=
 =?us-ascii?Q?tO2CwO8IFXHRrf9D+CgUChBD90EQu8xyZoFcDbvVJ8kOrRk8Qjqkxzi8w0Jo?=
 =?us-ascii?Q?CiNhDZPnTGuSdv/XoEdqfOl3n4JCC2zY+ai1QSRICeQljKr3ZVk9EKaB+P8p?=
 =?us-ascii?Q?5rcPR6P6gQU08o+B1hHi77u+I3gK1C9pMW27eZGwnlvZ5pgF/0cIqZpvYKhf?=
 =?us-ascii?Q?Eggx7GMddt9DobTLoUDIuu0KYdlNo+aJP7BlNDXTYxNDwO0HbzUDMfLweQ0d?=
 =?us-ascii?Q?uVb6hHf3aZicDU6I4llJuU3f29XUkX41kx/Gbqlh9B+xpJQkBPyI25d3Hxzh?=
 =?us-ascii?Q?JMBX34zXntOd1YzquIhjJxgDubheI8oznsBedg3N2WxZArelmx7p8qskE2lW?=
 =?us-ascii?Q?y8ftnVBRD/SuPBHxE73thVibSPoOxA7zMBly1MxrCHgvtvp9TuDmmShqs57i?=
 =?us-ascii?Q?jSo2O1BspGbh2XQuee30xDCbmllbBqiBDcXwS6a8fbPcBiYw5KAIkD5k/4aa?=
 =?us-ascii?Q?M97Nfj8GgwdpivGYpBPcLSuu2EnNZLURQZT3LM+bs5NXoT7GunTT2cdbmIDh?=
 =?us-ascii?Q?LEKEohmvakMpJX9UsOxsOp4N4S+jt+kDGBuwG/yAA/i17eGAmadSP5NmxhQR?=
 =?us-ascii?Q?wwp8wv6/8d+igQOHNHuC1ll8omkmKXZGs56kTEZVzLoVkM7quGg7MiSuwKtq?=
 =?us-ascii?Q?toBACjfTqPmn14dNGBYT6pa5X2mmidrL/vzrSsXtICZy/6+BdI3xqY4xzbd/?=
 =?us-ascii?Q?ckGUb0PimWW/+9UDabaPUHCwaJM0gNQMH86fBZedLOfgd73GZpZXKkYXgi6b?=
 =?us-ascii?Q?DATzPQSWpXJfRl1DGBARUKkyVrZ0m4sWn4J4SEj++4ldngbn068dlSsc6+Ky?=
 =?us-ascii?Q?hXuPRn1MzTXQ1yKdnXLef3IMTCwaSTzrDYkWmJawX3ks819inP9tc0OeNX6u?=
 =?us-ascii?Q?VKYbY9TSdekEzCAslaKvzZ8KPD2HNyKsKGoVku9ZWdZdMWx0IlqAKi1HmMxm?=
 =?us-ascii?Q?6OOp4J/H3w=3D=3D?=
X-Exchange-RoutingPolicyChecked: gibbD4QCYhoJ0VYui0GbefXsablj/wXCuk7fSk58LWYH8MrOCVnC6PWdWE85K1OJmoZvgmy8lYorcx7KQwpUKEo3DIIlLP9yvFueMLTJd0r/5qG9xFQDVos5y+Pbi7Pwa9oBwHkHJH/kMIT9nQWEFhNJVVzAdnGLRteC7G4XM2J56ZUAnFDINOxvaKHE606oecsz2A6jvbCIhM9gVOt+HuRsj/Q0QkCoph/4aLK7/FyqcKs2wX04ClTmNblH9kb/UmLssHBilt2/4+Ries7k6lYcRVi2KvUZMVbAA8vf1b8vGOvEMo2zfVjo11CxHOsRVjRrfyOc0bezWx3a2N8J/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e19b70-234e-43f9-bd76-08def7e54767
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 20:15:25.3819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LFkBg4hMbtTaMnlUPJUP58AlhOYPt18eD8WOuOZLrhsuZU6Xfwq0OZ01GGLV7XhFfW1kTTNw2WV+6ghz17P/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
X-OriginatorOrg: intel.com

On Mon, Aug 10, 2026 at 06:08:20PM +0530, Raag Jadav wrote:
> Currently, xe_device_probe() jumps to err_unregister_display label in case
> of failure except for its last call, which directly returns the error
> without required cleanup handling. This results in stale drm device that
> isn't cleaned up on unwind. Fix it.
> 
> [  810.194180] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:01.0/0000:03:00.0/drm/renderD128'
> [  810.194183] CPU: 9 UID: 0 PID: 5616 Comm: modprobe Kdump: loaded Tainted: G S   U      E       7.2.0-rc2-xe #382 PREEMPT(full)
> [  810.194185] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER, [E]=UNSIGNED_MODULE
> [  810.194186] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 1805 10/30/2024
> [  810.194186] Call Trace:
> [  810.194187]  <TASK>
> [  810.194188]  dump_stack_lvl+0xe0/0x100
> [  810.194195]  dump_stack+0x14/0x20
> [  810.194197]  sysfs_warn_dup+0x5f/0x80
> [  810.194204]  sysfs_create_dir_ns+0xbe/0xd0
> [  810.194210]  kobject_add_internal+0xbc/0x2b0
> [  810.194215]  kobject_add+0x7c/0xe0
> [  810.194220]  ? get_device_parent+0xcf/0x1e0
> [  810.194227]  device_add+0xe3/0x870
> [  810.194231]  ? __pfx_drm_gem_name_info+0x10/0x10 [drm]
> [  810.194280]  drm_minor_register+0x73/0x130 [drm]
> [  810.194322]  drm_dev_register+0x76/0x2a0 [drm]
> 
> Cc: stable@vger.kernel.org
> Fixes: da3799c97572 ("drm/xe: Use GuC to do GGTT invalidations for the GuC firmware")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index e327c7d35ca3..cad531009721 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -1165,7 +1165,12 @@ int xe_device_probe(struct xe_device *xe)
>  	 * xe_device_wedged_fini() is registered.
>  	 */
>  	xe_ras_process_errors(xe);
> -	return devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
> +
> +	err = devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
> +	if (err)
> +		goto err_unregister_display;
> +
> +	return 0;

I believe Sashiko might have a point on pre-existing issue.
But anyway, this patch is right and we need it

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  
>  err_unregister_display:
>  	xe_display_unregister(xe);
> -- 
> 2.43.0
> 
