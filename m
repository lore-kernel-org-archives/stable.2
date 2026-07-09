Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43A3ABD8E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623764; cv=fail; b=ZPfmDHfZJgLBpzDV34jwO78kyrzg/VAzE93Wa2X3zvw4cWHd3cAu/1ZGVIhv7mOq2mSwwEdwFe/8GtJuWAyJAkze5GDXBEiZYVx6OlycaK3SYKMbnFAJaq40FjZePQ01JyMJS01/Z1kHDBH4HUyYKOXA5tRAOZszT/6Cb+ZDO0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623764; c=relaxed/simple;
	bh=W5R9ZugX/295FekUBI5WAuUxvpqMEX0Me5Q5p6cIeQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdnKUf7i4FluOx5vrnaElm8ZDzL2ggF5SEnM8v6iXbGDQO2+iTYRyquoJJKiw3tMKMrQmBqH54N1w6HrqZt0OLFpV5EUF6Vao7FEkac7/mc8/AAJjdaxtPbiqewEQU50lHn6fWTQBWiee1fxdrL9qocoiEoWKWDn0jLHHtvu9U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAFrWerv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAFrWerv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783623760; x=1815159760;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=W5R9ZugX/295FekUBI5WAuUxvpqMEX0Me5Q5p6cIeQQ=;
  b=RAFrWerv1hAamECtiRRzcvzGyuRAyhiiiwt1VbVPZN2RJPXqANFOpnDy
   AO0sGtXbaFNLELYcpTUtES53M9G7y+Tbc0Syr5+kWgvtL/gwZ2Ghy7mSG
   EXCw97s/0KfE+mh7wBzrK666DpZf80y9YXACYB8Eod99fELFK5YcWKiPH
   la2f0Hk3VI5geObMh9Nl/3CFqbuAxp4rAOaEMqpRW1D78N4yXxfiGeFM4
   g7e4i7NNxpEAK/bizG/bJE6ttSg31L6lXS9aBDM8Pz7HgC3nxuWAAmG7F
   1fnuwodK9HsvCWOYaZ7J6Jpis1c8oIvHsLzENb7nM5teR6B+6TyuZeYQn
   w==;
X-CSE-ConnectionGUID: K+ZY/RBpRh6Ctt7C3Jw7MA==
X-CSE-MsgGUID: OKwN88sORIeKODCj3ikQnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84420413"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84420413"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 12:02:39 -0700
X-CSE-ConnectionGUID: VWcrewAiQIKppF84BDHoPw==
X-CSE-MsgGUID: TyxQmWbVTkSIOjewSVyyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258540107"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 12:02:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 12:02:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 12:02:38 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 12:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbFPJIame5jjV8PvxxmnfqWjLhI2sM3RZF5IJmZiJ+E3gRwy2DShLcu0ZJWfzrTbKFxae+nmYhoVR5r2o2iiTM5oBP6nQ0ysUIgHOt73naVvkgODFUJdPfPmvolnJ6E3oKEsUr+sc0C2oKnXLs+hZ25LU5UaWVrVDF2tj9RpYPeaFoY1/nsqa7whw+5S+pcHDsMxo7tKZAy/xYDcOOeHgZJEqYyj4uG3OXU3o/ciPvDcm8w7wjfpTqEOgyCOZi/lhohyrqyeUSzu4cIU8KkDxcqt4lkOFSECMhqi3b+zNNh2SSfs2/VgqOwcQAd36FsFvMRX3QZ9C9TcregziKX1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEpIyM09Chq4Wt9JnXA8/hyq3F4Ak+8cljUnGVJ5CVc=;
 b=eQ2PbcH/LteXjtpZBYysGLoDS6ARoxFoBVWU1d8TmZtUEoOSvl7R4sgJwYVO+9xf8NF2K8cDaE1mUE3q6b9DGhtJBSI3J91QrrPN8uydrmtbxurqSnmJgQOF2V+WVeiMBkh98oQvIfmhUTw6Q+IZ416m5bNJsHB/41TEALykgw4Ft50zbftZwLfqr2okuS1kXwLNXJyf/9SDOb8QjLPqsEhsREqVEohhrAqmkiFuiXPXadtoEy/rtPMpUS7g1aYZ+m+S1Z6jD4LW8xzQppk72O/wnfCtBcrk0vaqe5eDkza2/8SQtzUgwCT3QEs2ml4cYjN0jaVXDezdyajGdbpl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 19:02:34 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 19:02:34 +0000
Date: Thu, 9 Jul 2026 12:02:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Wait on external BO kernel fences in exec IOCTL
Message-ID: <ak/wRrF9DWBdykiP@gsse-cloud1.jf.intel.com>
References: <20260702215805.4011228-1-matthew.brost@intel.com>
 <d5c3258a-04d1-42d6-9d74-cdd9a1172d97@intel.com>
 <42f4a99a3b572f7141ff1a2d7db2854d457300c4.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42f4a99a3b572f7141ff1a2d7db2854d457300c4.camel@linux.intel.com>
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2717cb-8a01-4252-9995-08deddeca230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|6133799003|22082099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: tFRPgajXIBS8FVz5qt0AYvDlEyQMh7n4MzkVt94M2KvIIEQs3iqNIXCrnXmz2KdZCMlRzcOA947E4fZPQDCaO3ksLxw3mOoLGtVkvCOhBt7FvaV7o2Hx2UtlAFKmAgkE8JIigQfULn+X7usyaXbfGu+G6GdIvsK0LhY1yxsatf+cvn97JFZQlfd9GSa1v3OfjzKYCXKgIZIj8pFLYehOTHjQ3pXpc748FeJ6FQMQY4AOuUF6mS01Ft4VMavDBMg75ZSfPDwvedGiJUjHzc+uH+JbrekyisyaMnTJ+a7ex1ynWdgiTRfSFBDoqPXJuMk2N27FSKN1lUBM+tdt2Cvf6J+l0PMWeMOTmnKCMmiiIdltODav7lMO/JmNzRcNAFYKkQLoEQIWpcFI4SOhxA2UeA63mHZhywiIxVyZ31AJUBuIweocGRLGY7Ut2wQRE45ULOcmKKN8lNymcn7naf5Dhfu9Mu0okXUu3BqODi35aFvbdRAZKwWbttOsjeqrJZlFfPOh0kwkgqrnAQCjLxIixQX2AjhKhPVo7vwCqUowRNn8IZaBPflL7dQzMxqkR6kbxL3tqGvTnc7FwdqjOAIBq7OsnrGMbOv8GfXSAw5z1CHDIvbTknjN6RJ8NMkhdrAXs/8t3+phtsd8toKFVBtx6BXoiOZJoonXoVvY17HOt+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JdJrCOISsammcEZ9cytO7HmFX77Y6VvrZJWdL6Ho83EoXIREZ+S0bizrXR?=
 =?iso-8859-1?Q?lyF1K3NAjH4kAQQCjtfsny+vW4HpBcghmz348Y3DuztPTEDdWr36VpEpvS?=
 =?iso-8859-1?Q?MW3/jTTKwZBjI0z/8UA+CehQiPFj/kufai4/olIxe3dr23xgnnN71ue0LA?=
 =?iso-8859-1?Q?bRdKg9iF3eJuw2nOzeyEiHshW7vFKH4CMC3grTcJZ9vLJeEbUCnf5oo5Xs?=
 =?iso-8859-1?Q?gsfawffQ4zh5KiwZKw036Rl/UDz5fWGFJUVUeUclivEM1RKlofyggYxxnZ?=
 =?iso-8859-1?Q?3WTbEDrRJfgviAA2mcl4vhLrppaOrqRBsD0Fd1HgMK6/EuvVj9Aq2VA6Wa?=
 =?iso-8859-1?Q?L9Uga2lrIxwoKakudS1Q/eX4isGlvsYg4Mrx7Y1iz2dtF3BStGnhVUVZF+?=
 =?iso-8859-1?Q?XivBnBftfVCunjBvoZcNtf1Xz4kQlgyL75lnzRSsEuO0TXctVyYZHOvDsx?=
 =?iso-8859-1?Q?s0FrPJnBPCPQMOEA3b+wuFd7dbCjIRPxZxQ8wECipx/IFdTAs1k+k1p+Uk?=
 =?iso-8859-1?Q?QF5gcreOKDz1nmoAPI51W0Q0zzIx6PD746iQORaqq2wivhcLKu5cEb/99L?=
 =?iso-8859-1?Q?fos97YZt9KZV08PGwh8ohz2j/lLgVYUL2wDb7zATzdu3G8hOKg5Sgueb6n?=
 =?iso-8859-1?Q?c+MPTj2M2CXs4zeiOKvZBVbHB4u58lNzJ2fTiN+7K9VFPO9TMvrPxUqarW?=
 =?iso-8859-1?Q?ObWM8qn3O85SfZK9+/6JsrXqnmo78ESY7kgDwpDIB4vAItTQdvigxRM5qZ?=
 =?iso-8859-1?Q?VWlHdi95/lHAW06CeJSTw6EJtnkjbV7kBPXAcVxstoWyXdyWQ3r2jXacBm?=
 =?iso-8859-1?Q?kTTyI6CA42wDOcO+iCxMiv8NrSUrD2NiR2CGNPjbR1eAdqboM8kihIfgG1?=
 =?iso-8859-1?Q?GNG3Y+z4vm2hReFgVgOxMLjmg7DQN3LkQSRJSEH1FrmqOFCuJVnyLzeLBY?=
 =?iso-8859-1?Q?TOJ61AibZ8QMSvzfxhetKJ8bQsjPYjfXXHQvBYNiYUvV3yqomZNuBmi0RH?=
 =?iso-8859-1?Q?tC9OC2lLaR/mdkIiYzId4N742PtL0mXSUKSzTgVM1xMi59MmqHgmdmyC6N?=
 =?iso-8859-1?Q?2HoTDJ7MiIn6EqJB9vLLAxIPlqYV4ywCqJ6A9x9T5rlHhS0p0MZbGQyyZR?=
 =?iso-8859-1?Q?pvFu6Y/KVAhPlyMxHmR/OCkxEd50ccwC2MIrccVGmAMOszxusMqz+cJ/tm?=
 =?iso-8859-1?Q?ZE+9L6Nk8Mr9VAQHGvegAYQ+PsWY4elZmAR8/DlughyY9vPpxpWC84/nKf?=
 =?iso-8859-1?Q?y/a1x3JSLXUIeiAFNVUegiDfrktf7GijmzlBvpMYkT5t6xJpt1lDVBz1xK?=
 =?iso-8859-1?Q?6cVe47/yFHaWBPVLJwdjpq1RBV6sJ9wuUkMy++JhDAKGVBq3FDWHRBKdT1?=
 =?iso-8859-1?Q?H+qP1QtnINUPfuRaxAKIFJ+dUHSOVAanJW492WppH8XRgMcTWvdEWVFue1?=
 =?iso-8859-1?Q?avJj2wnhY7JuPOSih4GWqF9uHsJOFRXSU91nqeAWTIdbKnkzhbtNzMuMvP?=
 =?iso-8859-1?Q?jDI8wDCBSgv3+3JB0pluby8LLAIZ6v4lQq5LNXtQMyJPsewkWFTmKUtsGa?=
 =?iso-8859-1?Q?zds4Irok6niyUa6faFBAis72x3nlz7cjqyZ7IXMUGlw2/63GHnIdViucOY?=
 =?iso-8859-1?Q?hn5dPjZC9ZG6tCZ9/QxbLdMAwb8ZPDbGm5N3iPxDwVJzV76Wou16EYNC17?=
 =?iso-8859-1?Q?IrTkuhE5DXJ79Lx9fVsRHizg/bh9riA39n5pbeh4ivcNAzfherfse1GTWB?=
 =?iso-8859-1?Q?s8WAdGOZCSZ/ovVddGvnP75t8BFZQlLHe0+VNCkWfJb9joyaCIDIurmwaA?=
 =?iso-8859-1?Q?FuCei87+/8fbd5dbDCtDi0rIkPNFNXs=3D?=
X-Exchange-RoutingPolicyChecked: ZGXF9o3ezoX9aeiYSA7rGhIY1qC+bIaEZbKLsenLgU7RM55f5gLv4zpB63wzLSWbLeBcvtXtwEWLDwvq02M07KY2zraSytl1x1Iy63bi4Id0bmB5AUEfdjH5Yt4vfk3wADPnXJBKtSzB7x6vn/AEY3Na7eWHlaaoEK/o41Cu4BNYSyHOTSN3fKEeWvNs940auE3kVqAR/i5XeqF9nRWc5jJ4WG1nQUFeCZADfk6FJtQvnd5f3Gc/OrZCMqEBp+IvyGAhrCHfLkVdAhg2B1ygyGyWC+YbQ/Zv6weQbCKNj8gkkLUiQjMvO81hrxDDwJBUYlN7cDJvO7LRvAs6g4tKzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2717cb-8a01-4252-9995-08deddeca230
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 19:02:34.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/R8BDxLUR/nGYASv40Xhpqxz6479LyoIEe/PKRBeUhrQ0Xkib43A/53I3Xfkci9GU6Sk8q2EuUhFxtpMy326A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com

On Thu, Jul 09, 2026 at 01:01:07PM +0200, Thomas Hellström wrote:
> On Fri, 2026-07-03 at 09:45 +0100, Matthew Auld wrote:
> > On 02/07/2026 22:58, Matthew Brost wrote:
> > > Before arming a user job, xe_exec_ioctl() only added the VM's
> > > dma-resv KERNEL slot as a dependency. That slot covers rebinds and
> > > the kernel operations of the VM's private BOs, but not external BOs
> > > (bo->vm == NULL), which carry their kernel operations (evictions,
> > > moves, ...) in their own dma-resv KERNEL slot.
> > > 
> > > The DMA_RESV_USAGE_KERNEL slot is the cross-driver contract for
> > > memory management operations that must complete before the BO or
> > > its
> > > backing store may be used: any accessor is required to wait on the
> > > KERNEL fences before touching the resv. By skipping the external
> > > BOs'
> > > KERNEL slots, the exec path violated that contract and could
> > > schedule
> > > a user job while a kernel operation on an external BO mapped by the
> > > VM
> > > was still in flight, racing against it and potentially reading or
> > > writing memory that was being moved.
> > > 
> > > Replace the VM-only dependency with an iteration over every object
> > > locked by the exec, adding each object's KERNEL slot as a job
> > > dependency. This covers the VM resv (rebinds and private BOs) as
> > > well
> > > as every external BO, mirroring the drm_gpuvm_resv_add_fence() call
> > > that later publishes the job fence to the same set of objects.
> > > Long-running mode continues to skip this, as before.
> > > 
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > > GPUs")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > Wow, kind of surprised we missed this.
> 
> Hm. Does this actually add any additional kernel fences to the exec
> dep?
> 
> Isn't the safety mechanism we have that no valid GPU PTEs are allowed
> to be set up with active kernel fences, and in the cases (rebinds,
> munmap split) we generate a VM kernel fence. 

I think that is an arbitrary Xe-enforced rule that just happens to be
true today. A different driver could install a KERNEL fence on a shared
BO that effectively says, "don't touch this until I'm done," without
triggering any rebind flows, and we'd break.

What actually exposed this issue is some local WIP where I use the
`dma_iova_*` functions to manage TT mappings. In that model, when memory
moves, a rebind does not need to be triggered because the IOVA remains
the same. What does change is the IOVA linkage, which is protected by a
KERNEL fence. The exec IOCTL did not detect that fence and subsequently
hit a CAT[33] error.

So, in my opinion, this is fixing a clear violation of the semantics of
a KERNEL fence.

Per the doc:

 79          * Drivers *always* must wait for those fences before accessing the
 80          * resource protected by the dma_resv object. The only exception for
 81          * that is when the resource is known to be locked down in place by
 82          * pinning it previously.

Matt

> 
> So if an exec runs trying to access such a bo with an active clear, for
> example, it would typically generate a pagefault?
> 
> Thomas
> 
> 
> 
> 
> 
> > 
> > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > 
> > > ---
> > >   drivers/gpu/drm/xe/xe_exec.c | 22 ++++++++++++++++------
> > >   1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_exec.c
> > > b/drivers/gpu/drm/xe/xe_exec.c
> > > index e05dabfcd43c..d5293bc33a67 100644
> > > --- a/drivers/gpu/drm/xe/xe_exec.c
> > > +++ b/drivers/gpu/drm/xe/xe_exec.c
> > > @@ -292,13 +292,23 @@ int xe_exec_ioctl(struct drm_device *dev,
> > > void *data, struct drm_file *file)
> > >   		goto err_exec;
> > >   	}
> > >   
> > > -	/* Wait behind rebinds */
> > > +	/*
> > > +	 * Wait behind rebinds and any kernel operations
> > > (evictions, defrag
> > > +	 * moves, ...) on the VM and all external BOs. The VM's
> > > private BOs
> > > +	 * carry their kernel ops in the VM dma-resv KERNEL slot,
> > > while each
> > > +	 * external BO carries them in its own dma-resv KERNEL
> > > slot; both are
> > > +	 * covered by iterating every object locked by the exec,
> > > mirroring the
> > > +	 * drm_gpuvm_resv_add_fence() below.
> > > +	 */
> > >   	if (!xe_vm_in_lr_mode(vm)) {
> > > -		err = xe_sched_job_add_deps(job,
> > > -					    xe_vm_resv(vm),
> > > -					   
> > > DMA_RESV_USAGE_KERNEL);
> > > -		if (err)
> > > -			goto err_put_job;
> > > +		struct drm_gem_object *obj;
> > > +
> > > +		drm_exec_for_each_locked_object(exec, obj) {
> > > +			err = xe_sched_job_add_deps(job, obj-
> > > >resv,
> > > +						   
> > > DMA_RESV_USAGE_KERNEL);
> > > +			if (err)
> > > +				goto err_put_job;
> > > +		}
> > >   	}
> > >   
> > >   	for (i = 0; i < num_syncs && !err; i++)
