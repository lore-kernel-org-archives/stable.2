Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D949E14F;
	Thu, 10 Sep 2026 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079044; cv=fail; b=tXwfCqCN4pQiiatmwHnP1TdMdtsmN1cBrNz9u1jhXMpDsl6bsWctpVHE2zPx+AVGZmXw2/eNYSpAFDaaOMU4XK2JiiDS7uMm5B/SpEaI7V3zimK2lUSligzzlKfos4expmM1TyvdQBBlBwJOQ7Jy+absPGvLyUNVAoC/a/O4cuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079044; c=relaxed/simple;
	bh=cYlZouHxDxIOWB/3/jrdRLxKMV3DVw16cnHSLBWh0Lg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FdDw2ggpQModX6HH5QDALT4zuFc3WK2W4ZZEDvp/pELajp5wsRPd8bSYn/vcPhotNFkx5JF0LRSAPHhAyOW3pQE/ezw+dzovQuNIhH4HabGGEJTtOBoUZ+f/xgyofd/32RpkyYtoq7rMf2GpXxxURrSpQmCLm+y2lB+mrK/nM4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCBhCLno; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCBhCLno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789079042; x=1820615042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cYlZouHxDxIOWB/3/jrdRLxKMV3DVw16cnHSLBWh0Lg=;
  b=lCBhCLnoSIHrvj3izNOsXI56TWtV0jnR1iMYgs312wpVBk/rM9nuDILn
   d6hds7ka7P2y+cXm+WbBIM8fhvgF2J8/Xbhxj3Zu1SCiGPXNsZnxn4J3z
   2hDXCPt2YVdRKOR3D/IYYv+r4ct12SXgAmMIwNxjfIvI6kaCN5C7Sv6oq
   Gr9z9p8ttepO93JKdDJDANmaoPBuTmOqiHqYkpvR7+3H7J62KFT7Vn93m
   qNtVMbcfwheKgQCyMohBStkShQUHJEJmJvwodrwVwPhpu8Er0KRP5/tJc
   Qr/QxLngdeftLPQvdo6cHZQIjoOj/QQt18mGpuEv2iUiDRGt4SNjZqO/D
   Q==;
X-CSE-ConnectionGUID: 767+0HB8Tb+JCSaKLZIZYg==
X-CSE-MsgGUID: KT+M58RCQ0W0RVzElD04LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89753744"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89753744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:24:01 -0700
X-CSE-ConnectionGUID: c9u23OOATzKl/9w69+jtww==
X-CSE-MsgGUID: meQSqSsMQJOIPaAvToKxGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="275281046"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:24:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 15:24:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 15:24:00 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 15:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD6t1vZkV6e2AgREAtdcCnCcmPfzr3GOIRV5HsNQyZ4DnWhZaE+ql5jDtTMNuUGMeaTlAyAcdOjwEhLEgzDzaqvktP5XtoEHPYdMECEDdilIW8TFY5cm4C8a1hwrG9YalX8YAH2mxjCK2vLx/YSvE7BszTI9B8IgLm3VzXajjd9slQJLSsT/TQkVW+Vr0OyjgTNEvzq6UfA4/WwlmxTNerMsTQ0sc2mG2P9hrbJ3wUpkSCNIUc9cDqMMUo53y8rV/amDSQQ7NCGDMApoX9sQvNqkht61ZTXozG2cezTI81KemvKWBKUd1OmaqXLQypdtB8/sKFO+ImH/U/iOOyctxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2z6zS9b5OnTQ/ZY5JRZGwR/fImJwTC/2jAg1q/PDfc=;
 b=bJmfHdfHNv1R44nxsJ3M1W1ImHpCcx7ZJ3xeohS0A3tk+qCz3PF6O3fvdEWxHg3Q6I2hAhTkjugp5Ts1Aemh0ehXpIj7fDVy4iqmJEEfiiCLKjSSQyhWqFpYj5TEuFtC0oYoDaB0fQRlBtT0evhcyGdF7JG2nVDrZ/F/JoEZ23zz2bAhRsMvNX5LowBAj9nVlifqaVOnFQHnq14kVpXO/K+tc1S5lcUAdaaRmq0j3m94Sfcm6k7PzrDum4BP9prHzfesgKSKXaMrRuxMVzuBEVP9+SQw1xS5LSKzQcrZR1jk0w6SzXJ05Fa4JPRvIjA4sCgiIsP/wLFnEtOmVyw7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 22:23:54 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 22:23:54 +0000
Date: Thu, 10 Sep 2026 18:23:50 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
CC: <lucas.demarchi@intel.com>, <thomas.hellstrom@linux.intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/i2c: cancel the client work on remove
Message-ID: <aqMt9p4QAaHUt1ov@intel.com>
References: <20260909052328.654682-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260909052328.654682-1-fanwu01@zju.edu.cn>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d638c4-8733-47f2-32ec-08df0f8a32cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g4Jx3AOpaUL+KMrz5pTIUXsm9VjQADhnOcNON1auTSj4wqYz3GzaN3KnuP+cLUU9hlm/pQ38dvjhH1ctMARiBJiDUuX8FSSEUgJVRK/67zN5GJcj4+2qkuRRj7tZXA3IoQfswqP7Illm0Iqs8BM0ZdYCFuYItaWXVTt48lwCyn9aiMdpK3mmWJ/hu+1R5aSz5efJKhF5QWmJL6DNCBcFkifP9YQTX9T+XPi8vcnWXJHwpUIzxuAVbOe8mxz72e6NdUxLXYc/ptJZieJ2Kntk1moXYepyijDCSj+vgulStfhhHXNWoGGbwNZM4MNP3vtIVuUvypFyCnbFisOgncElyMY4vsfcufg5JQQIZbG5TJEg7ZzTz5x/sqPIyuHYCnSmdDGkjUwf3rHzebdm+gLjJzdUtiZucahgL2PzO/MFo0xwDOAhTmkHOV2qURyDmo1/623Wln9cmmEm0CtM55/s4r8vj9IAMjqzyBFL8dLWsYW4KT27RfLMqXI1skHJ93rr8Uvh42TQhRmuGztVDDLeQfcuUQ8z/BS9GHaTwDstUwbhfXPj93YauzRoDTIYeRvSvs+Qbm/v56DFUrJMnasolVK/KQEiZCBWBOxalUpvXOIiB5WmlyhHaS8Scuy4nYTLbOzI7VIOr8FTBmPhZLSKNgGY9+RMdywiga74o8wPVj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYBgxNIe074qPMKGmSVbiZD1+nQPxcOdx/zgYsPfAxve4xsT1NTMrU0VOz/a?=
 =?us-ascii?Q?1kfMezFfxlDooikY377gVXHDj76Y22LKVhQjL7I4pzkxPHylziWN9MZ/d/eC?=
 =?us-ascii?Q?aPngyh7gHJUQM8l47ren31lhloDA2DjiOyjkCatn1HTV9B9O8A+ETjI70FFM?=
 =?us-ascii?Q?kc+1cNKHYRBCtOH2EgbmbVdGUlN25krxS5OLb+istUJM9gZstSNyXLj3y0RE?=
 =?us-ascii?Q?yowgE3GNovBzN+dkwJVRUBBw4e8Lw6bN0DJDnxANRQrgGkzEgkdSDucUags9?=
 =?us-ascii?Q?/EygozsXtRuRQgt0WldVSecXBls2ZwzWtUIwP2NutwOSfIS9K5/yejIHR9kN?=
 =?us-ascii?Q?gV4aZJlcO+xjIBVo24IlNbYWRkogvdsgnJ6QB9rsU9zkb1FIcne5YlAWBddq?=
 =?us-ascii?Q?IWwLTKJwTB8pa3ieHPkAVg7bRaHGMBSIFe6G2vu9xgceIqggBbS/ERbqzRfo?=
 =?us-ascii?Q?W3pqRCI2smvIC6mN5gnoHeHaDOlwvclOprVxmS6NIa0VzGXFXVSQNeTLPlDm?=
 =?us-ascii?Q?S6siJ6IYO/ZRwRnvHStZJ+xChRTDNAELbwb03znVTGbe8Qyat6ytzqkiooi2?=
 =?us-ascii?Q?RHfpMUzg0y+YsLfHr8VCp64YnUcSy16Ekpbr6waivpBI2cQOh0kn7qYL4ZQ9?=
 =?us-ascii?Q?YfkKCKtUwigzALBIEnHJjP+rwPPBMypUIwByDesv63vgHP4bIxBsqTh2f06B?=
 =?us-ascii?Q?NJxmijVPe+l0dECsO4iefWm5O/jyOi+JLLxUwcxTPSxcbVidtD8KTouMooqJ?=
 =?us-ascii?Q?MkkD2RNzQry5N7SSdnznTHIB5vD+whkWDrPvbAJXZBGJDO7+wy8UfTTJPE+/?=
 =?us-ascii?Q?biDSF2I+4UPelwQpeZkdrTqc2qmZOvXPO0VMlMtD0ixg0igQqdzQum1RAx3w?=
 =?us-ascii?Q?bW7hwE8zDHzXn9y6D7UCRlV3vdJZRFZyh0ixeIK2HmpKPC/DWd7C1ddagRMZ?=
 =?us-ascii?Q?sZLFntck0eSiZ0DEDH9AfSdOdafxYH/RtklxQ/BWtmlLp0vb74+q3xtaoQH6?=
 =?us-ascii?Q?jz4TahwYwOq56w85oEsnV0k42Jy1j3mTclm30286GxfKgb2XwqVtk5h/+Z/r?=
 =?us-ascii?Q?weQ/umEGXcebZAiZzbQViAIsgnkZd8DFKE770M5hTjwCCJWYCpld0aDl0ElB?=
 =?us-ascii?Q?0tjZMaFY+Qqo5ep8vg/Fa4VVr/mUTBvW6dWthCcUSSK1QvVuymMHhSnHPwK8?=
 =?us-ascii?Q?9CytcAipoWL7sWnSK5ZZjQUG6byah8X94x4AD7xvbnGlg/gZaurwSnu7xrhD?=
 =?us-ascii?Q?kchRHHTHp4/k0PyP+vraaEjaWMPc6GorNAyv05qf7OMOi+9T8ZGBht9hDwsT?=
 =?us-ascii?Q?EvtZWMvFgJbfCkM+//gOBiuWAgOoYLV3acKlUd4+dtgrjBa5zG/SCU+j9wSX?=
 =?us-ascii?Q?9l6CoFw9rIwFeagaXinmCyKUOZizss+SJIQDuWygvrIabsZ9EL+nu+ukmdGh?=
 =?us-ascii?Q?WJMnpe8NZ1AbT49D0kta4rWxGK3VO3omIHsQBqPbp6uhMhsHNfpI90uIhS3p?=
 =?us-ascii?Q?I5vleVwVmlAR/5925w4XOdHyCdQ8e3ZG6IpEH073yK3IQOeeeiYyAGj6jO4J?=
 =?us-ascii?Q?m/PGbZX8ImWNxpdME6E7IE/RNpJ3USwVy2GEVleUAD5YcGQDlami7AIzjkUn?=
 =?us-ascii?Q?lONztbsUBNgkllI8KHpxoO4d/mCRuU7ZOiS5kfEMCNzTv2dVjGCk4pmltuhv?=
 =?us-ascii?Q?aW+QN6T8f7Hmlqj9y7TZ09oGzPzRFDX3aMXuMuRF+G9/5/BATVORQ397x7gf?=
 =?us-ascii?Q?1PxcIKtooQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: b4Nxhp9Uem5ryaDop1HH8ndhdSQ3qoL0yqQ2DrPTyyfRQB+Sq1SgfE0thQ5F7XKgQUWuxtIV5dfk2UKc4dZGeHg9nzAiHL/y7iZvaiXcTMcX8weTXSVaoSsoHb6dbMBb7vpt8eoLGOlTaAk8Mcxgo6k/LAUhnqIy0j+0L3vPKEi3Geo0Y8gE2/lz6mv23/Br8FwxlqCTBNwsDD7ZA2RX56zRvkb+uWs9s1Is6LY3Ah/I1IIwGcD+14dia7ZrWULA3qs+E0l8sR4B7jE5uHAgK8y7xP3AJ+AtqXr0gIeJiHPrZKzJGoglJBKopmjUP/EPGd4x9+T06c7ZZVBpaITN6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d638c4-8733-47f2-32ec-08df0f8a32cb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 22:23:54.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DVbrCtkxR6aKMfRKm41i8vXEFjdyxmqfq7rlNhc7hdRnNgePizf4Fu0FkEuHUpAo1srSfBEvux/mse4lHiaqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
X-OriginatorOrg: intel.com

On Wed, Sep 09, 2026 at 05:23:28AM +0000, Fan Wu wrote:
> xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
> schedules i2c->work when the adapter is registered under the xe I2C
> platform device, and xe_i2c_client_work() then instantiates the AMC
> client device on that adapter.
> 
> xe_i2c_remove() unregisters the client devices, the bus notifier and
> the adapter platform device, but it never drains i2c->work. A work
> item that is still queued or running when the adapter is unregistered
> dereferences i2c->adapter in i2c_new_client_device() after
> platform_device_unregister() has released the adapter. The work item
> is also embedded in the devm-allocated struct xe_i2c, so a work item
> still queued after the drm device devm unwind frees that allocation
> runs its callback on freed memory.
> 
> Cancel the work in xe_i2c_remove(), after bus_unregister_notifier()
> so that no new instance can be scheduled, and before the adapter is
> unregistered so that a running instance still finds a live adapter.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/gpu/drm/xe/xe_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 706783863d07..5a176d78193b 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -311,6 +311,7 @@ static void xe_i2c_remove(void *data)
>  		i2c_unregister_device(i2c->client[i]);
>  
>  	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
> +	cancel_work_sync(&i2c->work);
>  	xe_i2c_unregister_adapter(i2c);
>  	xe_i2c_remove_irq(i2c);

This code has changed. Could you please rebase on top of drm-tip?

Then recheck your solution. You might need something different...

>  }
> 
