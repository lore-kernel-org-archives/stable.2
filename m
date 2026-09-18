Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA252D2DC
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768438; cv=fail; b=T88GGJI48kEzyur6CSwxOnPFvNl2rkxyC1UIjf6dq+LxFBAlHWciHQVAG1Jkab8TLOiJuJ0CzA4o0ZshKGVDPnWdKz+loyCWIt8hOm5yOTEO1ky/p1gYvvxOdMKRIAGiRu1C28Tap4ll5YAmJPtqfMZXl/nwiFH3NOon2z6D76Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768438; c=relaxed/simple;
	bh=U9C4XFFTg9RzeNaaBmXCkra9HzjHMUq71BkKSudzMqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LEiogFAYUA7C64NzShLa0f6VQa/jiomrrH1iVk5XyeMF5lkUkkBxyocfwQo795lWzgn5B44IJiDB+qS4cTkdVLfQeyGp+TA1+Q5gpnxSb5hnb5olN7pddhKIEWueP9gwctfB4LcoGA7l0sT+j40KCGy9T3kQPj1U5h1YAeaMspg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VU2ZKgJk; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VU2ZKgJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789768435; x=1821304435;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=U9C4XFFTg9RzeNaaBmXCkra9HzjHMUq71BkKSudzMqY=;
  b=VU2ZKgJk8OGr5cl/6L9tA04/ymVXTMfCm2Mg0/wY7XNWRs42LzbFBXRU
   z8jyz0If34+jWWycTg6J1kQCbjl52dWM/MmlpIPYThgr3CprpapovXDLg
   4ZQ9ir/njRIgJg2UmvlRi/7gVxwlCcPZJtNjvccAppKD5lvEOA416vTnV
   DRpY+dANSECVKKZZdpQ1JUGqlvsppLxNgSgcMGwNPOZjX9Ox4zwOqaGDQ
   xfxB3E59OX8S2/VZ2ZCwF+VoJTDmLrntPcoIoh/vbb/0TdSmAmJAaZtof
   t9Gsp9O38f4PECF2xWjnNh9WEor/bFLqoNimnNxaE+QLBGpIlLL1vwPcW
   g==;
X-CSE-ConnectionGUID: Y1Rok7UBTQGHw6PIYu8iLQ==
X-CSE-MsgGUID: eLXkLZqvQTWjGwPRailTiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="115835824"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115835824"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:53:55 -0700
X-CSE-ConnectionGUID: 7zFKjvGkSuaeIzfp8mvgyg==
X-CSE-MsgGUID: jn+4mXRJTa2Ka9yaRmyBCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="3065600"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:53:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 14:53:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 14:53:54 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.66)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 14:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxowU4bAP64flf+DjCPHeqcEe4l1H0XtE/PJH15VqKRRpBW9gm2MOb7y6nrXOXRg10F7D+et5Pzw/e+KbbHFHCm38HcU/abUjKU2rkKBzX2hWhDgeIdSGaTFL1pAzprHs4uES0qNqNqE3ZcN/MDUqNQCIX4Yre794u/zSyFX0qOqzmwD3VslA283KgGEOZXYk5Zd84qLPlr4uBL6NH6XcSd8X5tHl0pZ2tmNtFDHjwjUciAZ7FJcRmHGLcczvzUbeDpf1BPnwy4mA//ZHl4t7hpK0kTnQ/BE7KyCARBV9ux44L8wMXeb/LuIYTDWHtvJTDUNqVZ2ucN9X+FUit9PUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjxXYqOG0TA3A6WAEGUsEayuIAYbsAyshfkFHwVsAUo=;
 b=odEEATtBeDK+Fro3l6rcedoN4fNtNujAWIe+CA2CnIavs45L57rkxw4qE1pFdpGBmzZKWQXPB4Yz6KR3yAj/y/oUFCHis6pp8Uir82oSbkUWwQzvrAihQHJ+xQYkRpZtLtMGgQEw5SpobhZLTzfwENsYRgI/3tOxYCqT6EqlQVpjFeNxJ1y/wbkO+UV+gv5U4/zgYN/QlK55pB+9iI5odNPuERVkMSr+Z/fUORLlsnMGSM1FTG1NLwqxMiXQENHBAgDtwkriCIU6NDKPL0TNr38CixE0YWTC60CmIvnFU7vPW2hm12I10n0dIktak2OiDhIvxj+r/IoCG1dZZm73dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB8264.namprd11.prod.outlook.com (2603:10b6:806:26c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 21:53:50 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 21:53:50 +0000
Date: Fri, 18 Sep 2026 14:53:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/vm: nuke PTs only after unlinking contested VMAs
Message-ID: <aq2y7LEdPDqFWTql@gsse-cloud1.jf.intel.com>
References: <20260918131034.598078-2-matthew.auld@intel.com>
 <8c1744e4012ab5b30d1f26f8129d4944da1dcfa3.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c1744e4012ab5b30d1f26f8129d4944da1dcfa3.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ce6c69-34d8-432d-34e1-08df15cf52ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|22082099003|18002099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: usGBnN0pDFsfZRChLnUrquyQicUdWFaXiF16gjo51mIn14KrxYA00Q0UYKMbtTXm59K9RZnH1vQRhs7HVuk4RVICis+CAzc4hg5YJjvIRdGCJsq8EXlVMWIKp6CCzD2G5ae7Yf1WiHjTyZaOdAkr79+kQiAn3P8yEo7rWCi7XbJziXiiVAZLXpE6x801wKqRUdXTRtHnXFqLY7vjsX6WDsZz/+3ArdLSt2FS85KN6gP0l5J3CuvA75Wg7SzvFTulJJvIoPM3S8iDPWIqw/DLTECL9FkAbgid9DV1ZbCRHyCudmq01e62NazsxiIt2R6dI80sXT9RYmfqyAK5/dQ8NZiDI/+ciCuzXlqgl2ATZzOZeJ7Y+C2lMqwwxFRKWrPVA1wBfTnHTrGSTROR0olPVleFAl0z6vqDeTB/jSBZ06hl1uKRujNgWgcv14esDKF2xLOeldOPbZ/WJiDSHqm6WjYWFGc9wgdjIBjp6iWCmdnjuBwY+4LxMa13atHLdF+oNAixAOs8IM/7/Hr+Ey+6rarK5rEDTEP8IGw3uSHBTWoCY7WGkHneB/cxavrSBRxnoy9dKYEpUWSK/tYQJNKuA0VcMf3xZRVwQk+CPP/3TRuNJSrjJpIlMtseDj1iDUXZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XzNS45SGlT4cojIR3MBI8AMWvl4RnliLBD7Ktdf2D9ZOWIHuB+cS+3+5jX?=
 =?iso-8859-1?Q?DQJqUR/tpqLeArftCIKeViUQrNhNjiwge2xAUw95EiX9lLZxTfjBwgytCs?=
 =?iso-8859-1?Q?pMwkW8KhIpNM4aC1EcjWeYcoUF++HycsptkPItHlqhBsqlmZRvyfW/nzUI?=
 =?iso-8859-1?Q?j7gbI7va39c21H/fhYe7oWLIIWPO/a9MGOcnthXouIIQoR5L1awwNVmL7f?=
 =?iso-8859-1?Q?NUrn7+FvUkwBVuOfT+PxjmI/5kYIifT3+T98dk32F7pMw2Jp0zwTDqkaET?=
 =?iso-8859-1?Q?zFX1X3bDUzlr9o2bfvcKtKHSnZzoJqYP5slQTXK9HaEdT0TUYW3OWyQJkr?=
 =?iso-8859-1?Q?Efe+EEHM+WktBDAGKFAvTYkcTonEy7n3aXTOa8iddW5/FWqivHrXFjE5lb?=
 =?iso-8859-1?Q?RiKqITv/sgrEg1ldk1GRHkod38hAtA1SQvYVwIDXY21g4Lm3nlyoswtG4u?=
 =?iso-8859-1?Q?5kWckbOohHYmg2oDZXVRBXw+FDj+eNu1ChWMle8A33d24cEtsUQtbLfmjq?=
 =?iso-8859-1?Q?xeRVESsxAM3P8uxEA97pKlVPqQAHY/wWdtsHVZDZkxYgUwm8B0hA46bQ0U?=
 =?iso-8859-1?Q?SsGX5GaAWXECHMmJj+LNzvfaPV6dN7a67xY3I0fiv1pPhSMOOGdtXleoLp?=
 =?iso-8859-1?Q?iv5vkiRH6e5LQcnh6ra4okEYWZQdlG5+UflByM8QKBobST4gc8kyUYG6bT?=
 =?iso-8859-1?Q?c3yrqEWqGBQPijW15DBS/x3Q5OFvi3YLvJB6ZYx+d6Q0jaarN6eB0ghzYv?=
 =?iso-8859-1?Q?9fupdF4Vntjlx0u7lGkHzkmi59+hw25SoV4uxSOzksdMYVZb1urVdNQbwm?=
 =?iso-8859-1?Q?CxKFZlWSWegwQEchz1ZjnRUsN7Nkz5cTfentIEjg/9IXKHTZCiCXx8kiQN?=
 =?iso-8859-1?Q?hbI6j+qmZUsKpN/32NIxdHqvXlNelw6GTF/T/bNCNCmUGbjb/MvZ7C81Ip?=
 =?iso-8859-1?Q?sYyJtrm5z3ctFmg0c3ugOTO7ElDcEF8Jn5G/Vy08vjX9T9Fa6v5yGXkZ+g?=
 =?iso-8859-1?Q?5RY4Mhr23ghvyqEWFU7WVjbTcqNaNK6dY1n8CBOB4BmTo1wUVKXFJPpubU?=
 =?iso-8859-1?Q?SEaeiNIh9rZZRvf7bwwW+i71ZyJYZlglVR1nH6j/AgFbb5K5Bw2pwCH/1l?=
 =?iso-8859-1?Q?QysmeTWzBUF9Ozqcv8a+j73JVms89FxrQ4V+6oLAXaczaX3oGsnAXUpq3G?=
 =?iso-8859-1?Q?EivQyGrLMwcpZzHFjXSV4tI8lpmPabNuAvQL29vobXcgOCZitCBNG6Wg31?=
 =?iso-8859-1?Q?N6EpglyVBDSMb0wbJ2+OUfrCOfEfbiMTp44w6rI5B4U7Zv/xPJzywh8Qqe?=
 =?iso-8859-1?Q?hmvAhlGf5TclzYyFj/shFXKdOIlw6qNsTVNu+ntkpMT5gqIcunnteapVEX?=
 =?iso-8859-1?Q?dpxKHnxAb7ZmCKO5U0ZhOcpRTSJVQ7xHkrpwHAnAbHTtDHbI0cpgtSWTfr?=
 =?iso-8859-1?Q?g93LPbiGIH7PEAKAZ7vCAQimPcL3qcSGxD2WcOgF9f3Iz6Z8mAPms2vGmw?=
 =?iso-8859-1?Q?8wvGxTc4bByUtovD0AXAR37eUNkAx7H84GQvBVEDNJ7rl1McCGVE3zLD1K?=
 =?iso-8859-1?Q?Ol//KvQHLI+nCFg/cf/xXT8TAui8/eXhqEDbw9r5Wja0a/WTGsseGtHcUo?=
 =?iso-8859-1?Q?scGCiv/FjDAh5uR6X3CNmvPkJwBP5qSu1sCXQh5Dq7obiNOAntb3Ef9MvU?=
 =?iso-8859-1?Q?+qKASVlYNrdUs90rlrUAi2WziNFostwXNz6jvWIbqdk5ceqxOPfht4M6gq?=
 =?iso-8859-1?Q?wuBiFnxI28ID/07Z4fHfjzVWhWsP6uVlzCAXghkVRk0fsSC0O1ZU/a3j3c?=
 =?iso-8859-1?Q?SWSN32cxFw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ds/RtCORXeLpfFMYZK4kiuduVYGFLDzj8HRM/A8dAJpc1y30L6EsMTyo4ruHMFAnqCX1tcxNnsKZjgzsPykcUYdVZacBpkU8whBenT4esPSw0GENvDfWuvVPVhw4zFIAooM1g6owREjMZJoUC5pHhaML++B4wUOqxSvCqr33DrKTUANY76Ml7xhxtEHmHG/fp7RGFODbnMKklZ1PAboW7JlaPJ3ux/M7v+RnDkV2EZsQgxEFU3HFri8GzdH+VLoEuNO2krrspgXtoEAkqMCON0CE3GORgwTRNZj1pZdr93NZDAWK9sjY4bJaFSRO3qAVCXnp8G4q6tfspV2U2SXV4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ce6c69-34d8-432d-34e1-08df15cf52ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 21:53:50.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azLbZdYZkoEOTR4hB4/EPt2/gvelZNLFe9lT2OOuw8svyIuYxacFTTFZzYTK8j03E7VxumaGF2TQ3bffzyyHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8264
X-OriginatorOrg: intel.com

On Fri, Sep 18, 2026 at 04:35:43PM +0200, Thomas Hellström wrote:
> On Fri, 2026-09-18 at 14:10 +0100, Matthew Auld wrote:
> > In xe_vm_close_and_put(), external-BO VMAs are queued on the
> > contested
> > list for deferred destruction via xe_vma_destroy_unlocked(). However,
> > xe_vm_pt_destroy() was previously invoked before processing contested
> > VMAs, destroying vm->pt_root while those VMAs were still linked to
> > their
> > respective buffer objects (vm_bo->list.gpuva).
> > 
> > If a concurrent thread evicts one of those shared buffer objects,
> > xe_bo_trigger_rebind() holding only bo->resv walks the BO's VMAs and,
> > in
> > fault mode, calls xe_vm_invalidate_vma() -> xe_pt_zap_ptes(). Because
> > vm->pt_root[tile->id] is already NULL, dereferencing pt->level causes
> > a
> > NULL ptr deref.
> > 
> > Fix this by deferring xe_vm_free_scratch() and xe_vm_pt_destroy()
> > until
> > after all contested VMAs have been unlinked and destroyed.
> > 
> > User is reporting hitting a NULL ptr deref in xe_pt_zap_ptes(), which
> > could be explained by this race.
> > 
> > Assisted-by: LLM
> > Fixes: b06d47be7c83 ("drm/xe: Port Xe to GPUVA")
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9290
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.12+
> 
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 

I actually had a similar fix here [1] but I believe I missed the scratch
part.

Glad to see this fix getting in:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

[1] https://patchwork.freedesktop.org/patch/738642/?series=170045&rev=1

> 
> > ---
> >  drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index 17dc4debe7c1..390da884c727 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -1979,21 +1979,13 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> >  		vma->gpuva.flags |= XE_VMA_DESTROYED;
> >  	}
> >  
> > -	/*
> > -	 * All vm operations will add shared fences to resv.
> > -	 * The only exception is eviction for a shared object,
> > -	 * but even so, the unbind when evicted would still
> > -	 * install a fence to resv. Hence it's safe to
> > -	 * destroy the pagetables immediately.
> > -	 */
> > -	xe_vm_free_scratch(vm);
> > -	xe_vm_pt_destroy(vm);
> >  	xe_vm_unlock(vm);
> >  
> >  	/*
> > -	 * VM is now dead, cannot re-add nodes to vm->vmas if it's
> > NULL
> > -	 * Since we hold a refcount to the bo, we can remove and
> > free
> > -	 * the members safely without locking.
> > +	 * Unlink and destroy all contested external-BO VMAs before
> > destroying
> > +	 * the page tables. Otherwise, concurrent eviction holding
> > only bo->resv
> > +	 * can walk the BO's VMAs and attempt to invalidate/zap page
> > tables that
> > +	 * have already been freed.
> >  	 */
> >  	list_for_each_entry_safe(vma, next_vma, &contested,
> >  				 combined_links.destroy) {
> > @@ -2001,6 +1993,11 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> >  		xe_vma_destroy_unlocked(vma);
> >  	}
> >  
> > +	xe_vm_lock(vm, false);
> > +	xe_vm_free_scratch(vm);
> > +	xe_vm_pt_destroy(vm);
> > +	xe_vm_unlock(vm);
> > +
> >  	xe_svm_fini(vm);
> >  
> >  	up_write(&vm->lock);
