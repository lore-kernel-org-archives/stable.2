Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403ED381AF1;
	Mon, 24 Aug 2026 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600223; cv=fail; b=DpDE++ol7Z7RQV0tFFhwVzstml3beiTLQMi9fP8CtZPQ9G6Zr3svqGckF/EA7F/DlnlwpO0pUvXeDRyvAC0Hpm1TqgZXYOJqQIuzHPImsT5GzOotU+Fgs7B9eTip8s+EWFP5Ix6ooV2lfxybOjPxyy9s6//141Z2NLvOK2DNOJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600223; c=relaxed/simple;
	bh=C5nQegtRy/aimLCyaNQ/RSgx6Hp9KuLmVY85LCPbvOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dGPCHALPYjXcAlvfCMYHnuq2a4RdIgturcbig2f6OLXdELWlwPZfVdTZJgZBfnR+Xoz6Zl60Gt0Xwc2BbQQpVh/IiG+A6e0KIbRGxU6PhpOVIT7SpSlODd9hNfmbiQ/BHeEpb//7H4YWY6smJoBnhStm7NVlprEpe/G0jloJNRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZHGBSAM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZHGBSAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787600221; x=1819136221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C5nQegtRy/aimLCyaNQ/RSgx6Hp9KuLmVY85LCPbvOk=;
  b=PZHGBSAMJ8/+pLSv6takoiGwmUobdpuG5zEL4RpT9nOQaXM3YNh+Fhwl
   +SHe5AUEjSINPoU1yoI3IUDAPFpmCfFALqiXQIIK5oXr50Rrn1RVQHVd1
   9UJwFWSxcjjZjk+RMyeBXXhBLYnP43y4Njdqb5qg/lFhVMT7/VUCaddcT
   W74hR+OFCbvAhm3VTLAFGzsmYHnCYL7Wp753c+kEehdY5aGT7F+z2vX3Q
   KXq4FtgkIm5s9I7fu4RyoDWogTjMhUcdFOTVIAewadavUwwKZNJEXIWTL
   Vds/fSjfUT2G5qPxe5iHFtvBjdJ3Bh/4AszhjKUM5/n3GiLcnDJWcJgjg
   w==;
X-CSE-ConnectionGUID: gyZAlFAARGC+nEbdZwoPSw==
X-CSE-MsgGUID: wwStYF0zT4OpMrOdf7aPnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="113599235"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="113599235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:37:00 -0700
X-CSE-ConnectionGUID: l40gCZpuQu62LhXCzEWogw==
X-CSE-MsgGUID: XFEmgFy/RQOvl7sQIGNfnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290615359"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:37:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:37:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 12:37:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:36:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJHtqrWQbOqTaHdSWdihteqBiCfhsKMQuDsyEAvFVILfbS5vZxo/+xQjS5dHvL14zvbHR9WWB71UjB6Q7Cur/cpDp/dY7GdlAG4wSW8m9bmEVoPJmmBz+r7gZs9jiC99Wc1X+Ua4btgmgfpmRMK/We6VWB848Y+O9dVhTEFX4PObYhE5EDRsjuepiEAhGDRXtyOcXE8oaK4GR4u8ZeyGnXbLq2hwOk3b9o8s1OLXjyzf1BK1B4TMdwV0QJM1Y/J4nHy7SzcNwMU1PO2oYQEFZ4wpDHdPHSRw8gTmrEJSQJmAAmeAOOI+5FTM7qvALOF7DZynjKJcXHn+UWB5CM2rCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A48QAaEqhPMn1GJ3bA6gOZIq0uAK6K7qAyCpUIuaiE=;
 b=lk4nN1qMFpJPo7vGTyl/RHF0KpuV09edqKT/fhmbi4XFp4D4Gh5k+TlxTkOmeL6qwzG/JPYMED9Zj3I0bHIRIOiY4Z1hb+8tWFdR4To72x5S0tsPu73DYGLQILcHp4iNZRmOFsedK9gBmgX+dJb5Hg1LUqm63rdsu8ZRGmcdfx+1oHbGLXEJhLv2ABQazm5Um5mLZH/jU+LQvLeVu82Wh9x2bYbqIpyr7a4mDRrz4T62j6o3UMH7gj4MmkS7KIsn/DwdUTQoOpha7gXL99Rlww/IOnk6q49Og77qG9KUjqdyDCW627Fo4sHLBSxLefEYN7omsK0J6t9Z3LCxQuZgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 19:36:51 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 19:36:51 +0000
Date: Mon, 24 Aug 2026 15:36:46 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: fix autosuspend cleanup during teardown
Message-ID: <aoydTpq-TKqASiD6@intel.com>
References: <20260808144907.2918746-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260808144907.2918746-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|DS0PR11MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b07c6a8-1b7e-4db8-faed-08df02170b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rIacGPBD6PQyKqzi2uU7YWfR93ov4S+PkrV/V5WupsxmlDvKEenbSIPr7B+PU1WXLT4BlkK7ZwExMf60nG5402IKeu/N52ezBB1h2TzjXVYNW7Ql+1cnvYxuz1zvLlz0wiRwmcvVyzZ4gU+wKP2djYUWr1DhgE77CbnCQif98LmRYlqOdisFjmONHo4Rg7DHokzKaVgfrrChCwHM9aElEX8HCx9qVT5eh102ObriIRWVlT+rmpFX3EITzvC88uzZvGyVDaU/26E7CZcRzznNH1lDalhifVP5l2ONY1S3aW1s/JKPaWhogQ1At9iQOPMNz5BAh7eNd4sWO8mExBume2q71OyWrNIU3EOs0Mst0MjdHYMCeBao8hoCNLI/j1nyIW2o6LUIolZStU5063xGvOGOk9Hp8b0hTcc58sKKS58UnsVbUumMT/hXHkQSXuxphiO3YkPvx5j7nl30LNmhOWujJI6/0HJK9Ue4icxYgVX0dxTkFkKSmLKBHv+PJUbLCmHRSXj17JSYAmeStVJ5OFdl1Yb82icV9iJybjLNNbyjx5ffwYTMQP5rEVumWOHlUfnY7cLwDBy0OTCaH5qRXXVYrujzUNkCXNEF6eMk1AI0tBAc9KwN0a/66XF/fP0MlWsFMHbBU3DsrxXlgGjTe8O1g+pD8yMb3bucaEy/1Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ESFSNC4B6lP6ICw8QC6LgfC85nMwPlYm3LfRBB1Hxqk9euPtr0Uq6v5K6Xfo?=
 =?us-ascii?Q?GWoG/l1Y68EID5dDSSx3V24gvQNXXHgNICDkqGXKlP0CX639Hd5UA3qJCZIg?=
 =?us-ascii?Q?211fIMSGSUvK4Fq3upZaHmdr1dD4VIwY5eTivSX6uuNmp40ZFA2TSJgPFsqX?=
 =?us-ascii?Q?NLt2UobZFiirKLF5LaffprGG70AvEWA1ptIiNCn2z5m2ctlVHojwX90GZhqa?=
 =?us-ascii?Q?AvESDpXzMXWHfgpfdQWgFDqCoA8tM+piTW90gbaKlsY+UAO48rug+EbTPQw9?=
 =?us-ascii?Q?5nNknh3SY5FBCYuNfyyerOY+Hfei1WYqE7IM/GrZ/iAwz91jpRj7fX7XlTy5?=
 =?us-ascii?Q?0spTEwR8VsVcvJyIEMcU32ABXfH9oCBU7HuMZtNSVuEg+4ZFFVyIUTltbAyX?=
 =?us-ascii?Q?GujSFd+9V77beXmqNZqkJVmgzyu0UknJ8R4QWCGpHeDbpctWEiY8ChKg52gH?=
 =?us-ascii?Q?E2pqunbNQ+eT40A8+qp1dZ1qWtPklZs2S6JJyH0V+r4/OrpTkZ5LuuAVFHU1?=
 =?us-ascii?Q?elA4WshFXwBfNYwIZAdZS+JJXWquOLYQjej+W9bv8GNw3Ke6sHspzFRfMi5F?=
 =?us-ascii?Q?y4gfHELV2AINZYsNM+Zb/1MifbMVHFZNJmW6b5zCwm7+mcp7ZmDn3E3dh13M?=
 =?us-ascii?Q?XUCpcWmKJvAe7rjF74AuQ3bo4k25J8YACZzj1g4WqZgx0z0rxO9RFz5EcUlI?=
 =?us-ascii?Q?6sa3pq3SanCWb0EOF4YAgJhmz/yTxMzHyMbF6IXpmhX6Dn9HJku6TW2FOELL?=
 =?us-ascii?Q?3DlyHD2P+B3j1X0sx0DYcrbkzVk2yutEKaQ3TszDW+3699IkGVsnaBBDB2cc?=
 =?us-ascii?Q?GbYruCp40y6ng9542lB4sf/yHpuwTZ/Ss58xMmDbJ93jyT5lDkIkhNBwM6U8?=
 =?us-ascii?Q?L35nYzlbI2tnTFk6yDUrq+gCXJtR0mxc2npbQcA3r9ppvLxgNkK0UR+ZMEVW?=
 =?us-ascii?Q?mvUtH3Mow4Rru+X41HVZDPNwb8DR91gq+X0kVa+1Ehu/gcDhgXJFqozvceHG?=
 =?us-ascii?Q?2lguSq0NiCAcoET01fJxxMJhlpQCetSLN7Brv/LggIITzn1ULT5Rx26WRcwK?=
 =?us-ascii?Q?0NgdiCMjk0YOTrTZ8Up9oiIjZzP1/Aiwwzmdb7cVwdkgM8kxFWaFkFrhQnjV?=
 =?us-ascii?Q?xTT9LupgZlIPqNZxPTtQ+cz0P7XvMqSUrZEV3FEZBR5dMZen70iTR1OrbNEH?=
 =?us-ascii?Q?qu9dAbkC26eEZulfwd492OavPR2nhVPontTSALD2LMtvNkRNWzTvzYPoTlYW?=
 =?us-ascii?Q?erWbk9jp5bsIQJ+ORpUeZ6bDCMJv87+uXzszcVwplYSB+7vsVZFJrUznk+KC?=
 =?us-ascii?Q?2spzHM9KTS0Hsm+kNxaifaFG4whsb8vUclx5VrEI3ym2VAgDdIY+7YRSRNwN?=
 =?us-ascii?Q?R/KfM1Jg060qHliAiLGrY09FaRpvfCSZx6n/ksU4R1UU5Tt0u0CdWSEWi9cj?=
 =?us-ascii?Q?ocA4S0JxU3v82PtK0Ugr6e2vG2m5Z1Xk1e/Y5GJPFbgflt6Ju+L6pki3ymZk?=
 =?us-ascii?Q?3O9xRM72KOSk26d41D6h0Gn9FoE0/43wawFIVpwf21YZ4OiN68HqNhyK3Y3R?=
 =?us-ascii?Q?u3GUjZzeLPyVtqbhHfKTvmGBdEmZdiJjfokchfW6gJXWhdEjooSC6URd7BMo?=
 =?us-ascii?Q?k3u5p/ZVgMcvbdQJZFeHm2OoXA5ZTWVWqgBbvuzcIBfIvfZznAPQ6Xb7POpZ?=
 =?us-ascii?Q?2M49k00jeNrcLBDGedKgRJxKPcqQn7nXmZ5vsewJThFCti3MN4a+jElx3nm3?=
 =?us-ascii?Q?Bpp/U3y25Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: PjwE526eKYJc3UpFdjr3CJI8HxxTmRnzgekc1krHcr+X1VpPSRLNgshNjrgtGLLs2VxV38weMqnWSX03d/7R3SDX/bn8/E4kScstSvsEz7TM5h6rZ0hXXjf5LoW4wjGsL6Cz4JsGMtnISyLM+T5LENhTKHwe/iDHINhX9xBtwS+2XRzbYExB4FWCeEST8zne0cjsRitvsb90dsP8zGzNABmQmXbaq3h2hiiQL1zNK3MHBMSilIQQSNYoHllfWrIDPOuSSjPyZUjkft9zlCUUExF8CqPF3t/nzg5Rx0WN2Pmlfcoe9cQkmARltDiIbeqlfBQkSe3w8iJQqQXyVq9mDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b07c6a8-1b7e-4db8-faed-08df02170b57
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 19:36:51.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnzVxGTsLVQ9kbeMVfVw7jkSL4K1UmjD4X2eO64zzrYuL1D9W6OO6Lpm4bFlH7XS3Wmt+dqQY3OU6gcyg/l8Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
X-OriginatorOrg: intel.com

On Sat, Aug 08, 2026 at 10:49:07PM +0800, Guangshuo Li wrote:
> xe_pm_runtime_init() calls pm_runtime_use_autosuspend(), but
> xe_pm_runtime_fini() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the runtime
> PM teardown path.
> 
> This issue was found by manual code inspection.

Thanks for your contribution, but I believe this needs further explanation.
I only see this function getting used in pair with the _enable and _disable
never paierd with _allowed _forbid pair... Why in this case we would need
this?

> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 99562f691080..301789adaa21 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -518,6 +518,7 @@ static void xe_pm_runtime_fini(struct xe_device *xe)
>  	if (IS_SRIOV_VF(xe))
>  		return;
>  
> +	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_forbid(dev);
>  }
> -- 
> 2.43.0
> 
