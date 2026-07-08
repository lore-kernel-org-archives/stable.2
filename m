Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91752853E9;
	Wed,  8 Jul 2026 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540399; cv=fail; b=OpIOFvP8wXxqa/kiqi4q2Gu6PopKXX6iiyTxAD6TIyXaRaechkgn3mYBnCEPCbk3Wxv8beuFoz0ZGDSkVTs4/h+h9Z3TtYrE/mUs1kQI/aBVGGGzq/S/04AOAC0KEOmH9TIZSFIbM8gHvAVKHlo3YMXA/w/lEXptXzPOWpt2jco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540399; c=relaxed/simple;
	bh=z5yppuynIGwHpa2ZIayyafl8bIWues+2zBrkEuxZYUs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lycicr8eAqMHQV8vXXbcOo9EhJwP6Lto8y6E0qZrKQtw/sPPvlzsD37vnedWd02BKT56ljioPdGkxWVLQJpD/HlZvY6MPhf4oesO29/VRk/dRB5iNH/98kXxXUBU2m2v+R+4As/ISTgb7uTCNrPu5b1KX74I1+noH8/nnE7LLLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtQSMFWg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtQSMFWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783540397; x=1815076397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z5yppuynIGwHpa2ZIayyafl8bIWues+2zBrkEuxZYUs=;
  b=dtQSMFWgQeXPdLnfb0EM1JOeJDJ468KN7tZk+W5shmgz3uhon3tFia9z
   PuZLuTqFKveFZDI4/NXcrmqVWI8pOXn+18AhsYMWFcrXBs6S6TcM+cX6U
   FS10htPf5rOTRCZIU86KM/w4BZHnaUgySiJjLCzO1VR1+wRGcbXQqD54P
   284n34oiJX0SpajpIpqr2vTVIoYmtNpeRQQp7K3IBz6fFYDO2X6QypRNZ
   Dt0W0g4SdOJRmgryF68aO1kUeF2zbeXbYzgBqELE46pewEYpb+XEBmf17
   iYSwltLmfC3jCqlnHkSTznjg6feQlGUYmE38HE0urx0Lxxpdoy6yLbO7X
   g==;
X-CSE-ConnectionGUID: I6NAxH0bQG+cfQ+XwbJ/uQ==
X-CSE-MsgGUID: bGygaRpMTaKafiR3vpX4dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84236191"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84236191"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:53:17 -0700
X-CSE-ConnectionGUID: a2lTeD6vTMijeglv/rIYGg==
X-CSE-MsgGUID: jaPshmFMTWWbezPadb88nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="255030124"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:53:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 12:53:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 12:53:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 12:53:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/lQnHU0X1lxE3swBgyC3gYmBaaDNlLYb6+F5akiZz4/ABS6GJz4Aeo1tLImD+APvbHq/GAdJTM0zsrhBVp9WzIT4JBXzOSBq9oAelT+ITzA5HElIvsMWesncvMu1VhCAO143XeVIKF5pBYUNFR3hZ2A0KhMQ9QFQugYARO+VLQFT3+JiPd8RgTmlOMdKTxuP8sDSxnhVLgoahDt62ry0UExzzNk61MunR1OhrssxOhLEnyJb//BaoduVcMfsdCjVKGM0qwc9uYIlNm383az6OeB5v5i84uodsrPaJtF/LC2zwfcxzpKifJqn5cfP7vcq3JFQ3DPs04ktayKoCrWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyDbr5I47pp4Y2qVW8isviXCXFq7GdTOMIwxXBnP44s=;
 b=rZSuKmJXdLoEHkBwINAzqnN+o1ucfzP+jacC12y76aLIcSsrJX2IUEhCzQb5bPMCYZxxSsr+x5koRexBii7xP8ni8LGHwjP8Sz/oPK/uSCoMUmKhsIm9Y2YuB6Zr4fjcb4g8nlu7IkL27CCmF+kORITz5wB6RwH+SEwMJWlcOWv45EpWXn6joYxqvO9SqcATVzddXKkZ610b2w+tsusuLpnhcsAtwwkx+2ZwgJtvyg95++xbcKKqb8JA0LC2vv7lXEyeJ5Od+OfcYf2Ll5IYiZU/A2DxNMFnFAHLQk0j+vQqQApLUqlqLm5fck645CbzHX3fVeEyW/nlwsyPIc7++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 19:53:12 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 19:53:12 +0000
Date: Wed, 8 Jul 2026 15:53:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/nvm: fix writable override for CRI
Message-ID: <ak6qpHnzj7I9fLiz@intel.com>
References: <20260708-cri_nvm_fdo_flip-v1-1-792373667334@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708-cri_nvm_fdo_flip-v1-1-792373667334@intel.com>
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH0PR11MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: b3255962-c6e3-41c4-e406-08dedd2a8b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: DqyFdoOeXSr8dZPtGgcXMjwbb74bT7cz3ytGEtaRFksTjiV2aua/sqQ0xd9XN9YzqWcKeFo6pwZEMKIW7obo5V0IIkIcDyX9lIR1YbBuKQVDfaySqlToouT+YvSGxuHtJeyak8uRPiz+mXIvb7o5CCzeS0B8KnEjyelSN8ftaPxpawOFlEE175HVOX9SP0BTyjhQVywbpM3n/4UBaedLqz9AHkBYyF0oCWDmbz9bJyFDhrC3SDgtB+rYFVxvgJglBXq42u+vmfKMYc+chrma32IhjdUhnbLAm3tIVvYmjIVVui+7cFZQiq9dzXnOay227igx5MqrnvcCeSlW1+lpnwoBrVnhHHFKSEEwXX4i/dIPM5AkE7n1raxzw4UinsuUuuZjPE1azpTNKqzm9h22NXkibHa/rk3Y2KPxVLhiAAskPxrObg+2nexaNifjKu0qMACoj74MIuGaR1iWCELaacjUU8UPsdWB6HfPyK/7DTPPOpHSrAigB14wxpeJqZbJIHtJMdNG3O/mw1t2H+p754D+GsfFmpcWbTIWC8Nk0XsqFY/jeuwCu2ySl42C3y2Vw1Z5vE2Q2Md6F6tmsd+OZix4tc+pMRI5fPuqvcU6/qaXmTKuaW0VPKfqf+jEAjo0T1gN8K4QqJVP5VkYQlZBMioWA23ZTLcqq+50ZrEzFpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3c2TOvQsOLk6xxGfhT2gVXsjqwEe6XxWt26x6chrB9zIKk3HXBuzjnxJXbb?=
 =?us-ascii?Q?0IPq9592I65yJLmgTp4uzABzob1K/cbNXoaai4gXOb/57XMNEMqGLGNCqLuR?=
 =?us-ascii?Q?xMQv9DdVF42av2vipz4bRzDf2OJlVU3P9embeG5tCn+5ipkXMOm27uAzVWPp?=
 =?us-ascii?Q?hxwmDk4wGvN2yi11O4eEF94xBx255uxM+yVy4IAZmNiWjjKfLpC5eAAlvgHg?=
 =?us-ascii?Q?kpLJwi4ujPubrRyS6dE+evoNIfeZbs1CRCWvPdKlol0bqya647k3N7d1pEsE?=
 =?us-ascii?Q?KQz+ITpc/so8OXB5vAehQ9o6SsJkbILSqKOZ/EVGeRJ2fMDO+/2gjCNViZqj?=
 =?us-ascii?Q?tO7LwbT5S3K1BY90z7J74gpLXXWmE9MNOl5RLI2EX5H3M3Ke+l05cx5u9WXk?=
 =?us-ascii?Q?1U78MCJNvKVHJlfR4lxvEhBjljV55fTw1/zwrQYnUTZAV7gd8jtf3/C50mR+?=
 =?us-ascii?Q?fcxPSyww0xURBH+UxHUkYGspSznBxUQsB2/O+0YMFskn6Ht2fMLxTFJC10Co?=
 =?us-ascii?Q?uT4rBbwsrdb5e/Ab+qi0hnH9MJUtXiFTlnpayE4VTczlnstr2PGqDdncWj7y?=
 =?us-ascii?Q?Y/J7MF/DVXAj8b0ZcTNjMiXncwnUTZ6TcUgfbJxyqXzp+srA34j/IVXXlGrm?=
 =?us-ascii?Q?BNFHzFO9SFs07qfF2Ro2tOUdtthH7XZJmaIw4KvYcHUXiQM48Qu7+zpLeziZ?=
 =?us-ascii?Q?zhrNaPByOiJPF4MmATdxUNob93wbnfUrBW+X9yWUaFi/vasyQrLImLTx/MFv?=
 =?us-ascii?Q?OQB9Sa5xm3vlGX9gPdbvR8/SeyPYp6cpvZrxcrPuW5mkf6BX9c0nuRikTDwk?=
 =?us-ascii?Q?wcglRBXtYh5yXmpu6DdElSKgA/IWyN2BWVxNbm5MEBqRa9dCEu1Tjy0HxYuF?=
 =?us-ascii?Q?NoqZBE8o15RWoqgl3707Bs+pV4/NO6muybdPhK+Q4cidy7U9ZfUF8TNUTcQA?=
 =?us-ascii?Q?eaR79VvElPG43Ionr+ye3Xz+snUsvIiGqI++ZgRil33WsEz6stOtd9wvhiSe?=
 =?us-ascii?Q?agZgfYIXGg/2JytT/BFz17csQXc9XBCDJmY3nZkbuDfd8KDIoMrZuNhbxrUm?=
 =?us-ascii?Q?qaddysaXyEECnKcV2cCCFNk+6D6ychYa6Vyhi9yZd/ojRrFVi3RRO1Mpk3Vi?=
 =?us-ascii?Q?dPNu2sRbov2q5eV0BTttmfQc5h0grmHJ9sY0si21DO/SGAq/Zq+nZh6sbBZB?=
 =?us-ascii?Q?2BB0yYeDYv4nHGt5Y7G6VrJUxoWgwb5I2GEkB+eBM2abbn15J/rjAiBYIiVq?=
 =?us-ascii?Q?DrZaHahaHVywxgAoQ4xRS2x9/CXaWCwRsr1/cGJZkHUG/SZ0kSjHpYl3CwFv?=
 =?us-ascii?Q?z3MWnmrBRQhJ6ccRWdJXqnJSbaoRUei/al0Zqy0jtkTZKpc5x1UADzgxm4ZC?=
 =?us-ascii?Q?C9vHfeWbwQQ1M4S+8tvFMzTH7v/y8uf2m9Rma4d2AtFrTUuhmnDaTbku9QSI?=
 =?us-ascii?Q?kiXASjsR2H4szfZa/fYU/MYJMX33IdYjJYAk/PqLmgOndC9dKcLoZkmP9Hy4?=
 =?us-ascii?Q?qwHephBza47PCZQ+yQtTmJlpRztVpBTzwMP431Hb70hEmVvtXow/5UFi3F5V?=
 =?us-ascii?Q?OZflS7YS/cisIEG/QMQ+OeODGgTW1p1tHfpDWSh6lLBnKnFaabfQwNjGahBg?=
 =?us-ascii?Q?3wRD9H2rYWW/4amMj4nN/LzFqn+JqzX/eAENtUyo8Fw4ozQJUHSBIEPsWTpQ?=
 =?us-ascii?Q?dAKVlXOImQXlTThawaL7wkMRF0tY2KuSvLnI6k/eIyqIOox66VXHsONJQ0GO?=
 =?us-ascii?Q?WZl3fHwHSg=3D=3D?=
X-Exchange-RoutingPolicyChecked: BLZdf8ZTLIsaAII5lLyFEbSXYoywPBIOAAQ/wQEQlyCcu4yRTBwyGSX1B3K9JRIbRwyvseMBTgpKzZLcTuVgQh1ANuWF7a5Lvvk99ljS/fEWhsnPtsQjMw1K2CFeHeFgTjNiAuV0XGKA5Tn1o3td7Wx2b7y9qC0q1bchP/4ZislYC5qW/DWaV4NtFKC2qWfm4kqf3RJs/SUhkrsUXwzUcgq+WFG+iz0bLhl52qAXhpvPFRx+NR6FSE11Bt9mj0cFsFuadb6LrozLXMPKjdk+0pKAJ90o/KZZYGuM5cBQ1pOeR2vqBnYpnkWVRZ1/a27Z2LcCdBvnxlPU40qS12M4Ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3255962-c6e3-41c4-e406-08dedd2a8b2c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:53:12.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZfMohVoltuPeMhZIGjK4LEKAsDlKHKrFmAWLPsVH45zPqnlFwYl3HXhAI1dT2lU8PJwgEEY0raeQWOAC0T/Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4887
X-OriginatorOrg: intel.com

On Wed, Jul 08, 2026 at 06:00:17PM +0300, Alexander Usyskin wrote:
> The witable override should be set when FDO_MODE bit is enabled.
> Fix the comparison to distingush this case from legacy systems
> where bit should be disabled to have override.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9dde74fd9e65 ("drm/xe/nvm: enable cri platform")
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_nvm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
> index 33487e91f366..d50ee414e83e 100644
> --- a/drivers/gpu/drm/xe/xe_nvm.c
> +++ b/drivers/gpu/drm/xe/xe_nvm.c
> @@ -60,35 +60,39 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
>  	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
>  	bool writable_override;
>  	struct xe_reg reg;
> -	u32 test_bit;
> +	u32 test_bit, test_val;
>  
>  	switch (xe->info.platform) {
>  	case XE_CRESCENTISLAND:
>  		reg = PCODE_SCRATCH(0);
> -		test_bit = FDO_MODE;
> +		test_val = test_bit = FDO_MODE;

-:31: CHECK:MULTIPLE_ASSIGNMENTS: multiple assignments should be avoided
#31: FILE: drivers/gpu/drm/xe/xe_nvm.c:68:
+		test_val = test_bit = FDO_MODE;

total: 0 errors, 0 warnings, 1 checks, 42 lines checked

>  		break;
>  	case XE_BATTLEMAGE:
>  		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	case XE_PVC:
>  		reg = HECI_FWSTS2(PVC_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	case XE_DG2:
>  		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	case XE_DG1:
>  		reg = HECI_FWSTS2(DG1_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	default:
>  		drm_err(&xe->drm, "Unknown platform\n");
>  		return true;
>  	}
>  
> -	writable_override = !(xe_mmio_read32(mmio, reg) & test_bit);
> +	writable_override = (xe_mmio_read32(mmio, reg) & test_bit) == test_val;
>  	if (writable_override)
>  		drm_info(&xe->drm, "NVM access overridden by jumper\n");
>  	return writable_override;
> 
> ---
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> change-id: 20260708-cri_nvm_fdo_flip-333b545e1dd8
> 
> Best regards,
> -- 
> Alexander Usyskin <alexander.usyskin@intel.com>
> 
