Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6325F984
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079986; cv=fail; b=qT76ecznfts+vIYOuAG5kGN/Tmq2s02Y0x53YeyhT4hTaEobnNXQvJ2Ey382xMAApoUKnPsV+fMXW64PUfdBuGtKuMYykqsn09IwL6BKyyOyQIzWu2DFIyf9i4hOD/e6UHXGvKbTbCHuiCWUQu6BeC+tXloQGSwILfyBwqeZkT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079986; c=relaxed/simple;
	bh=hRDkpaz08VGRfQQSFTFcaveFtlqR2oKrI4Fl3U2DGLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hyqysOkEKBd1E5NNamBTaOO957RnP45Jn8Z0//BeYLHBROqXyFZCJN6yVgUePO+FSGNTPfiRVNRvrC/WB22cAJGTHjNehUZJapUrkd3JKEH7994K1/MqMBy1S43D/k6xrpnNqS4DCS6KLMqGlJviAy7cWHGk+RGgs6Rmtf6bWtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPG9eIW8; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPG9eIW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784079985; x=1815615985;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hRDkpaz08VGRfQQSFTFcaveFtlqR2oKrI4Fl3U2DGLY=;
  b=FPG9eIW8ywhpWmY8LGlOuOZrYrmj++LAZmcD9ancMA07OGqyjo6uiNUm
   285pCmZNi9VbXP5Ie2FeKEVYeCXNDMdyQu6VVQBLbdNmrbCxvOJfldjL7
   ZfAHvIIy2Dj6VylisLRsjFD5m1rDqyY2Nx7SOI/FQhOpCwn/X8SC6wxBh
   Ihe35c2ECKLC1jm2h5lMCTzUPKiTcC0N7XZOkibkIjIbjNAHm+a3i//h9
   MJyMgpM7P/8gN/5z6q5j/+jskFdj2GxmiY9cZm8CIOUxquzYANKCnYP1y
   z7Scyw93yD4uw6hQBumpZS9wGOpe/P1HCvP7laVSkIvUcRFyGNSDVt18S
   Q==;
X-CSE-ConnectionGUID: bj7t35iiQKiMz9Il69ivlw==
X-CSE-MsgGUID: OAwxVdxtS7Gl40br/kccWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84733545"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84733545"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 18:46:23 -0700
X-CSE-ConnectionGUID: zEWQY9q2TaiN/2iT+ZvWIA==
X-CSE-MsgGUID: ujzBFUyJS7WHW3qkI083Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="256663933"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 18:46:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 18:46:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 18:46:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 18:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8ST6W3Ov4EfVFfDvT7QEM/4zXUVu4Z9uy+tSd83FTrhQgZHecYFmNV+pkTWR0zrR9bLtIpjKjLUCHbCe380DIGqtoky0Og3y8wJ11T+YfhhReYpSPRYLVYsMXqsYepQR0p+LCcxnJwDALCaG/ius7yggvtA4kjMh6dB8rxi9/75SMLMqQU2iBURByXPelloUJBpPJeVpjLdh31bOZkqLJ0FOUUYJCGSpm9TOhvlkg4wfgXoGwY7727g1czeWSl+KkAeXpWG09MZZewrL8UKDsP+nW4fnZJ1kZVYAbMYFNjbNuXTzF9xm9YY708CQ/2hkJjRZIQafJqgrvDN+sP7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGT/PZXqIrHZE7habtzIvp3wAGwBa6R8P8p6PPUS0KI=;
 b=KNKeMYuFoetzVhhmgwQM9aikAQvoye7d/9Ie/eyatTGIjEssrqHWxkldiacyT+Lbd6cJK9ew5ITsuRnULZAuJ3/fcZQIukrAARBoLDdY0n0lFsBEohnaJLeb8uIDYpL6omIrGmQp2aBexI5hrck9Cwi/NT3tPcY3ERtXto1TXLLrMkauLat9CfdSILUD+18S5ClnQGW+gV81jiCMpPcRyKXj5ZgYQr8HCmfiuqmulUbiuezIP18//BqmqBIHATq1IQ3NMOQVMdsYxISd9hACJJIUuDh+RWvNzIbkNPmADUZix/Vznb+OHkY/F6lJvcTyWuYOKhbMhHrdAd81S8VB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 01:46:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:46:19 +0000
Date: Tue, 14 Jul 2026 18:46:16 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Zongyao Bai <zongyao.bai@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/pt: Reset current_op in xe_pt_update_ops_init()
Message-ID: <albmaGCoA32iIsvt@gsse-cloud1.jf.intel.com>
References: <20260713230830.2662760-1-zongyao.bai@intel.com>
 <20260714232433.2737533-1-zongyao.bai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714232433.2737533-1-zongyao.bai@intel.com>
X-ClientProxiedBy: MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f553597-f5e3-4181-cd6e-08dee212dddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|6133799003|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: w6qLC/Dl2eHbV/y71VsCiO7cRN40BLFERMCD3uIdetZINb92Gfu72i1Bbyko/dyV9FsD7SS4pHCTGcEns0btfFYowHtaydDYesN7RPRHQ0c9ojE4CrK1QqsEX2WlYfeCp+df2vzKJ/X2w3FznI0hX7sc9TEt43jKLGFsfHMutpSVhc7e5Iv7TR1AYWtkA/kjLyqXuCQ5zvnsa9Te4PqrbXSE/mejS3Ct9SGgRM7h8FgRKTXj6OHKznzC3esfKKuaiqlFK4ORIjQbOE92vW3yD8EnPkheScIxX2ud39SZiDJGLTJcVrCZK1s6Xj7+ynRSzb8zE9gU44MCHAVHpbgW1ptI6qFer97mi85grKZManTumGAJycqTORC7AaLmcI8gz39tWqNQx/oRi+1s/oDc7dvQ9FIujslGWAIK3EthrQO2ee7pT5RK+yv3s7IgTA2QcNI+wiRpPJjooRwVKyIdaeCHTqX9t8NRdjNTacI+KmnOrPBGiuW1dKrVYBvBEVkIyOP/FtfrGVFHzgsD3aJNSY7fXHBpXG8r9L9qzt9HWRUfwu7Mp/TioNajx7EOlRGMJud55KG8FMTU5Lxm3QUDBY/wrGLoAOqDJARHk4501oK+55xiOYxj1Rd9q9tCzXS+Z+dHriJGFmJLskMivOCOglShUiyEeUQ+9P88V31kUig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vhTllJNQPqFMSc/Ef/W6h05mK7gD7tHLTCF6b43lncWcH1QW6mTWC57cPEkD?=
 =?us-ascii?Q?oDf35lmjgDSnkufTsA5+Rq6Bi5RK1LJvjHOZyZyBDGNQ/EMciWUDrTG7MVxV?=
 =?us-ascii?Q?hgaojhS6fGHvPFHFnh1r7zJI3xoflF66XM6TiS2Rwr4TyDWT4e2FP3+ExG40?=
 =?us-ascii?Q?jFnH8b3cRyj73cTpdERhM4WaczTuuz0V6qef88Uz+N9j6wXDPLFER7AAYQcb?=
 =?us-ascii?Q?IvaIFSfaeovCqeUpyMKUxRPACYJLQNyjTSd1YSTqKL/tUbHRkrW7h9Cd24Gt?=
 =?us-ascii?Q?eJhc7JcdLCdZXgveauWMb4q6nXho25WHKq54Ah2hb4nTxTD3w9EtgJ8SsU/z?=
 =?us-ascii?Q?+TLuE1uN7T4SG7aV0H5xiDUuxLS+9wXVYoeHAj18Y6HyPPb2h/Tkp9XJ7eX1?=
 =?us-ascii?Q?LsXw2RspHUXY7MoFCegmQxlvAlLp2vv1kWtykJAREXIeqERxS+cg3pb2ZGzT?=
 =?us-ascii?Q?D215ggxuMpXo/jhKni/rZjwDnBFyPaUZTGk7lD5Ug8JMwza2ufJdWu4I/pUS?=
 =?us-ascii?Q?r6K6bIZAWXGKUgelgPsfi5dT/zO46l4c2cX8BPqamxLB6q/Ci8V5a1zV7T6A?=
 =?us-ascii?Q?xpa74V/VoDjynofBzosTqLC3YcDG3xS7PsrEd0elz/J/Le6bxeIzoALjbKuv?=
 =?us-ascii?Q?TfsnvEAnVBv1Et2h17K98H/PGM4hF2lz36gK5ez9o9zEY0M8Wj0l1d4D36V+?=
 =?us-ascii?Q?Jl53cXVE7/o5VrqN6ckC9pFEUJ16gjsrVywWNWd8rXAaa8aNvg4FXp0vRr08?=
 =?us-ascii?Q?xgk+fAqR0POO5KybDzdsAsh32MuExqBhERqAzdMjAmX2jnqA6yYC0R953Gcp?=
 =?us-ascii?Q?vd26VDxLnxICOXLvOZEKn65qTlPtnIQcxt34oD2VkEdnLtwPkwJj5wNcTRIA?=
 =?us-ascii?Q?JjYDW7WCEir5jyGvUXhu90XhDItYJrdqs0KBshIxihBXQ9bKNAmlmqiQ4tM1?=
 =?us-ascii?Q?fRYTbrUSQG+3vzhDzwqDPnTwFOcEgu4ue8PByY5UNmmVTLmSOir3ODAhmOTP?=
 =?us-ascii?Q?6+0SLbZmmcRCC9p9o/k36FqwpFjQCNJnJMoNPaGDa5vhjs1LjAcGNtXDN/ar?=
 =?us-ascii?Q?Ok2jVHUmVaS+5eIT117WudzgMdkUqgc4xZ2PM8W136TXcYX0X3zrkXipw7EH?=
 =?us-ascii?Q?PoEpsRRGXSemOthMca9k/0vwTI1kizJgQVyRorcLZy791cpQ9I4YB/Q73B4y?=
 =?us-ascii?Q?SOnY69lpi4+LqXpxDoBR7RQPt4uCzfOQa8UEbbcvamU0dd6qaLHaOACjasL/?=
 =?us-ascii?Q?FyO5gFe/epJ+/wf/PJ0AJ9S0QDCWz/7Vxzf6qoDs2Lbpqnc8QLdnR/Q4h8v/?=
 =?us-ascii?Q?XVyDs4k8TxSTM+bkY3rerYvO0+X8Rt6sYsAZVt3eqXD7B57UvP/jOtGPUWIA?=
 =?us-ascii?Q?GySxTE3sMPpGRSyRhhwpKQqjAPxDh1QTW5VQIpUrcHeTQpOKBPg7UaXySKv3?=
 =?us-ascii?Q?m92aaHopl5trgmGabmykTx8+ycdU5k4pncX4laWlsgaMgjnX8pzSqwhwHOE6?=
 =?us-ascii?Q?CS4CP8AS5IB8amO4Ijeew2j5SQH+PK7sW1rK9Fce5hfxcjBjudPN24+nFQ3M?=
 =?us-ascii?Q?vrb+qq/IG2FEDeNg9HJRC2zb0SyVAEh5briqt3K7EVLwWLfp390BxiKaoHNV?=
 =?us-ascii?Q?E0piIAnWPe+IwAk+aPQzEEIQxnPoyYhdz36MJ2R2/QIEA7a1NL3ky+ux1cdP?=
 =?us-ascii?Q?eSQSScHz15AN9glfE80TMaLm1LYQnth7QjiTeaZ5lKpIfxltmanI63TfDjx3?=
 =?us-ascii?Q?9CcghUdh7w=3D=3D?=
X-Exchange-RoutingPolicyChecked: UNxOCC6AX0KRR9/hWSmdP7g4mN8fUo3vgySBsRA86DLQLV4xToru9JvaSjkDevuaRlxSDKptrJYj00prK1sRFNmNkC3eJnz6glnVyUvdotqp0umzieLGckva62G6RImtt+b15TpcCPoSlZ1EKu8Pvubg0NnBp+86TxpuaB52/HgkzVY3OKf478fonerzeTN+35rA83Cwl9uXsVKUT73lxqxc+pzFyjQIZR73F64zDXf3MlmbUeD4LHE6MbeIikPxOVOE+C+U5nxguu7U3d6KTudXUGtMU9p1e7WGgPw+Zm7BgAaWMflEHpTcx7RbaTZAQQ1UeH3KpgGRsxO/pNayww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f553597-f5e3-4181-cd6e-08dee212dddb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:46:19.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y71/b7VH/cesG1ncvrTyEq+OcD2NjaPdJLDVRiUdqe4N9Hy8SG2/VcBvCF31ZEojxn45iKslTb+g+sGrQBuv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-OriginatorOrg: intel.com

On Tue, Jul 14, 2026 at 11:24:32PM +0000, Zongyao Bai wrote:
> xe_pt_update_ops_init() fails to reset current_op to 0. On the
> vm_bind path, ops_execute() calls xe_pt_update_ops_prepare() inside
> the xe_validation_guard() / drm_exec_until_all_locked() loop. When
> that loop retries due to lock contention or OOM eviction
> (drm_exec_retry_on_contention() / xe_validation_retry_on_oom()),
> xe_pt_update_ops_prepare() runs again on the same vops, and each
> call to bind_op_prepare() increments current_op without resetting it.
> 
> After N retries current_op exceeds the array size allocated by
> xe_vma_ops_alloc(), causing an out-of-bounds write into
> SLUB-poisoned memory and a subsequent UAF crash in
> xe_migrate_update_pgtables_cpu() when reading the corrupted pt_op->bind.
> 
> Also reset needs_svm_lock and needs_invalidation which are derived in
> the same prepare pass and would otherwise cause wrong migrate ops
> selection and redundant TLB invalidation on retry.
> 
> Fix this by resetting current_op, needs_svm_lock and needs_invalidation
> in xe_pt_update_ops_init().
> 
> v2 (Matt):
>    - Add details in commit message.
>    - Add Fixes tag and Cc to stable@vger.kernel.org
> 
> Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
> Suggested-by: Matthew Auld <matthew.auld@intel.com>
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-sonnet-4.6
> Signed-off-by: Zongyao Bai <zongyao.bai@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_pt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index e466f714bf86..598c6b2571e7 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -2371,8 +2371,11 @@ static void
>  xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
>  {
>  	init_llist_head(&pt_update_ops->deferred);
> +	pt_update_ops->current_op = 0;
>  	pt_update_ops->start = ~0x0ull;
>  	pt_update_ops->last = 0x0ull;
> +	pt_update_ops->needs_svm_lock = false;
> +	pt_update_ops->needs_invalidation = false;
>  	xe_page_reclaim_list_init(&pt_update_ops->prl);
>  }
>  
> -- 
> 2.43.0
> 
