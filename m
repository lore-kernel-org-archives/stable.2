Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2A237707;
	Tue, 15 Sep 2026 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439092; cv=fail; b=WMA3jfBpsN5NZCrm7kiyb/1f8UWtD+wF6yeXDavzWGWt8U4puc5yds9/j8lUGFFjsXCY9alySWkYT25IHBvAGvbf+fwLX/TDINtDUkJpXObksUtRyf5laMTxDQ7txS3o4PUKCYO8mo7P2vhiWtWSh8YkddE+AA5/tXsvrokt4/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439092; c=relaxed/simple;
	bh=3qwqlkiH4yfre4OgGb3a98n3fjUd3po5xH7X8+HpafE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dM7ZVggVOvLedxtoTsHPMuxI8fkYyuUgxHp6k5nEV7Qft6gsCNkjdtXwLnLl6b9QwFFJKeuBko5GNr+qxCPABAW3zip+WCt/IQ+HE6BEU0aYVKwowpReese1wX8WccHx2pL5nHAs+KpMew1nfkpaK8HjDj47Onwk/4Sk2qEtUqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHB4ibgY; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHB4ibgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789439091; x=1820975091;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3qwqlkiH4yfre4OgGb3a98n3fjUd3po5xH7X8+HpafE=;
  b=mHB4ibgYq/IZvxijEhLB6kIzIIfPFpL8LkZjrgIHRS3B5Ed2YZGfaDsu
   ilTgS9tqJu+Aqd9vpVkAhxcglw5JegqVS6JwZlk3oJTRzx22xBRdNW4GA
   qUTVJLBKdkGxDcBI8rXxt43JwNNLPCRsQ4GoK7Jy+UIdJqce1VVBkGPyQ
   bTku6kr5o2ANqVoXrti0i1+shAdLWCck5n6HD7h4UssK29R5EcP27TZDq
   CRidav9OsomNCLjG9YLIbHRCoMUPBSlopu6dDzywVvLPlGViM6Tkr+4MQ
   wOTKb6Rm2/d02q2sgt17IW2fYPmc38KHj6wkf/r8OFDVHpfT/9nsD9OE+
   w==;
X-CSE-ConnectionGUID: OhvEHVu/SCG0JcHAItfG1A==
X-CSE-MsgGUID: 5NwzBb0kTZCd5hZc5O5FRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89807360"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89807360"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 19:24:50 -0700
X-CSE-ConnectionGUID: Qei35pywQT2Otk8qSBBK+w==
X-CSE-MsgGUID: suc2PQknTx2c1fD3Sn7RtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297832741"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 19:24:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 19:24:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 19:24:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 19:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsnAp0O1GwFYvQsTN5s/oqlYpjjvhfLwe9tGvEc6KDmWZATNHmMFlxKnnBd1NsKy0V5+xZbPSum3vM161iZzwI8QFMj3Jw8bA+ilrZn8tN7gb5G305jDEjjveDHXZfiND8skLg62lxFMyaTQnlpABF1eFJn3CRf+JGveEViWhPs6SFDBZkWsqZoFfBy1t3oYx0a/iyce2tFfi0O8s1OVa3/TCwTX4oPwgQZfLUx9iLy2ZVeRhkBYa85pSFPNSxA8sC4vGnLUnxVSy51BVHSn19m8fnoeAXcVIPtFdX32tW3HVf9/At8SJma+rwuFY6FytMwRsycbkUo8Is1VoZ3b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtRUxZVxUv+IOSzdjZKJppj+E3sGs061lbQrhsCcLhk=;
 b=ELCYOMYbtBKVR303aKUrQOjjqw7tkPCBSFkMbCb+69Y0UZjGXfyqXNANoPWsAioEsTMIEfZIXn2iHo62789sE7LvFAak0Kh3yZnmp67hRtA1Gs5M3edIZCXhyzpOArvxpODVuFiE2R8u4axRrwKV7OdqAWr5Q1kqYym1tYAEYW0pSvBr4DB5qg+2bDVr/PoXYz7MjthKcJLS0c942Mvgul9QaXLxZsuki/ZcxeHJpaBK3UR9HHO3KrTCqjb6jXhjHjxPqJv1CGVwysU/F/dbeJbwQYH8/c9/2B2y5sKa1SfChY2hCbJrq+e5cRRf3QjPWS0GXCceI8+rtfdCAeEOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8375.namprd11.prod.outlook.com (2603:10b6:806:38b::22)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:24:44 +0000
Received: from SA1PR11MB8375.namprd11.prod.outlook.com
 ([fe80::540d:f5b9:7f09:6ae5]) by SA1PR11MB8375.namprd11.prod.outlook.com
 ([fe80::540d:f5b9:7f09:6ae5%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:24:44 +0000
Date: Tue, 15 Sep 2026 10:24:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: Keqiang Duan <duankeqiangcym@gmail.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Qinguang Chen
	<chenqinguang@kuaishou.com>, Zhiping Du <duzhiping@kuaishou.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
Message-ID: <aqisYqQwC3k6trXb@intel.com>
References: <20260820123512.87236-1-duankeqiangcym@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820123512.87236-1-duankeqiangcym@gmail.com>
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To SA1PR11MB8375.namprd11.prod.outlook.com (2603:10b6:806:38b::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8375:EE_|PH0PR11MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 68421a87-838b-46db-bcdd-08df12d08121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZyZ1uJTZYlHTawUqOEWN/Y2IJaHkNpihImX60u2PviU+cM4sBfoBFQaGXHVLTKpfcfvgxAmIt0m2n7ld7NyPnxazQ9E/p0T9h4zExLq3wIR7Q6+G8bx206Pob2qYx4D7Z+XFlWP75mlxtNoPYxnnuZkJsoLFGI/mlwh2NbkG3kkX7JL/5554PyZwLnBDKGt+7oiA0eWa/yxYlEmxpIC0PqTSPro1vTKwV+oi+6z/ixnwnssoQgogcuLEH3Ku41mTfXOj0VPpMGLH3KWQU1sMFbsZYn7E5g7PLrMhw4XkGWOXgsM1clpoVHPonvihaG0iOi+XpjnWOqS8xVtaP2YOuy3DMWg55aaoujPHkgcFaFm1JTNwTONmPbGSW7BMYpJZMYk1epwTSJda7wsf5sUhgrXWGnR1DEmVarc/tbf9KZzRWnlRQrjF7W2fvubnP1lorHlWaLBLIzZ+lakTUahbvE2DjTPotaUbW1FzvrIgrmmk2BkfCYkBisuVUiEzRrZILrvVAUDtELyRnq05xO1JkNciywl2NZmQnG1oB+oWGZF2l+dcjzp4d4+rj6YY1b+NGPesr0da3ah6Z0rP7VzX8RG1BL2yURIdrLbqYPS2RU3gSxMfxDnBbn7eexm9XQkl3A7ypUHrEL+QvTPt03dw+JQWw5lk1dlQkALa7/Y8oyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OG5nR+/THnSZymdMqL8pPU8CdFt6L9LmScOz4KOy6a3ZK5gbWFAoCe2ZmmIN?=
 =?us-ascii?Q?zjMQup/b0MJP4q2yNPsyNrH5szIErWMY+VGbEdYn+Cw/PDCmX9+ZL7Ou4dbC?=
 =?us-ascii?Q?mmx3/eTr7mpwiX3IiiMsTdCCgx+MH4pBnHXDafY8y9u8wMhY3u7DXz7dMfmy?=
 =?us-ascii?Q?ZjMhBCaLl3it12szsoiiG8/0Fq3nK/62HJsG9FOQjqcu8h2w7FN6u0DGhVtp?=
 =?us-ascii?Q?kffbAGz3yKmD90R46jg5oELcwLR9Z87TDbxBYoPKdQhVCKYY/5/IMAmylkjn?=
 =?us-ascii?Q?N0LfWPFM804NbmWtXAUom3y47yIsDSHRbpP8E+VxGM4LsLBhXI4vTjkFW7dp?=
 =?us-ascii?Q?mlwzmJdh+eGpdGMzQoOFelxfvMMY0MwAxECsH5VYhWa5ib8JBT6aQbLGKFhe?=
 =?us-ascii?Q?nl5XxLIDXKQjy4iFgyFl2O97HSqK9DpM+7Cs3Llxb2CschExA1pJtAVTTsvE?=
 =?us-ascii?Q?Xf8hl4k5YHrxJi/eLR6UI0niEQfGHkk++tqXAXxhkFYX6xaw7N0ocFmwUDFn?=
 =?us-ascii?Q?+pkJ2lBpRlcYb9tNAZBjbisbyawhBIW1NqlIbjAPh+5Yv1cdVunr8UOanM+x?=
 =?us-ascii?Q?0sFXebuF8tdK8cOTmw4Gpfn0004ip9UQi46o+SaJnuyDHZ8SsYWQuOfsH0DE?=
 =?us-ascii?Q?ltZxyHypDzgbub0q92mgo1BR28POe0KwXBj8cM7YwY8W6XpeCCRkCeF2lkzv?=
 =?us-ascii?Q?RulmqzGqp4aWyh1W8LaOLp0bOYHdzT/i5SPtGSjkeRbbLlCSR5t2k4Wvbtv3?=
 =?us-ascii?Q?A0UOLmydeuAOV7SO33hQlFM5SGBjXZ+mrwCY8X+BLKo/gr1Wf40U4udEvdCV?=
 =?us-ascii?Q?dKaWAtVlhRF8iRKt2UtkPfXVy1hwFAzIpoh39HUB0/gwFmJsLjPDKYqNPpuy?=
 =?us-ascii?Q?aQX70tX+l6PE64ocQZO4ZnjOl0yM0bF8LxATm6zRSEYfosrM51UGPR1ahbao?=
 =?us-ascii?Q?VqdKrMBnu8XUOLdqjLc2lDvL8x25mIFD5qo7ViVs0Mu3OZDFBrYNOYHKPRqv?=
 =?us-ascii?Q?iW+8LMBOypVkdzgsqhiXjhtAwbPF9kXcskadSt9Nu1hYYVQYGft+VMb085E6?=
 =?us-ascii?Q?np1yRnxkPHun+ygPb5kuIxO6SWAEWwn2Csa6pMZtaulH/5SE2EUmW96I05U9?=
 =?us-ascii?Q?XeM+CD+ghAQ5xna3muvJmeQFwtex8uZ3xPtCE5mTYYsRNtYRpLwG3s/pdY3W?=
 =?us-ascii?Q?kPjEIZtZgGVBptm12/EcZX3l20spbIz+5RUZH/pKP04zg98kdikuNdmkBGZz?=
 =?us-ascii?Q?41tIL+qQb8BlO1XCJC/1ArgcuGTSJX2GoOVYSuc+mFg6P3drF2BdWfdbqaSr?=
 =?us-ascii?Q?gdWNZHXKeZjtEdsZmj+mFEFxFUc59sRc/EhIM/+dCcGBvZKRZ+6fwXqqNfPm?=
 =?us-ascii?Q?+K0mIQNId3U2upvF8cKHQy+h/CtgOFMuwh68THaKNvTkIClweyHAnzzUL6nh?=
 =?us-ascii?Q?J4Faug73HuLGMAzH5OiEqAZejy/0YGcHkvco6SGQtzbAt6oM/BSauSC1/gah?=
 =?us-ascii?Q?MjduKgTZx58UHhFmUuFQyS9TnG9AZnfZGAuu+scLb+bznrMpiJPg27+0sY/u?=
 =?us-ascii?Q?FBjuCSu0rLrDj5WZOvb3jBz+CuS9geVOcnqsToYxs3bEp9uTV/1Wg+VQeSiE?=
 =?us-ascii?Q?W2T2SQEP9A1Dmg4IYYKv5u0/KlrAPqMWyRULkiZojBEryKFsrld0IV8sQKpq?=
 =?us-ascii?Q?SIWGW8us0C2hqP7nz+SH4bNizEQ/8e0vspyagoqeNx7Rvi1xcPi3l5jml/kr?=
 =?us-ascii?Q?3xeRrUZxSw=3D=3D?=
X-Exchange-RoutingPolicyChecked: xnjzoEWYfPt254+Kmlx38RvVWkT73UeUbYlpTs0/dH9kwcHyp9oA/FQ7PNz9bzr7Xy1cM43qKMKq2jeqo87zaiVSk6uiEb1YgI3xSISBDJqVUC3raMEJsYn0FivYCaA9/ZvmNzc3Nju+j6SAIKEv0SyTAyd6UMYgRc/WbUb0oEsHLVAweC4ZEGBtTK+2GE0HYn6VpVXMFdsdDeV1KWRyefhfEzVhviqr2VxNGCVWVHpbivFmqyT/ikzrZTMz63HSnbjymKD6TUMHyE5lKzwaOYEBaQF4x41pkE2EHWxAoA3WQVhUVZ9I9raT4UfViQkgSnO6aAC2qexZtHGBj5IMAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 68421a87-838b-46db-bcdd-08df12d08121
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:24:44.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce72StbG5v4b9vJtPZkMutCVcqls+D7o8f4bKDKY5Q9E4cSatYxOlOY4amxjdRJSs+GfOK0Y7wQiV8W1m0nbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com

On Thu, Aug 20, 2026 at 08:35:12PM +0800, Keqiang Duan wrote:
>Force a vCPU out of its hardware-tracked halted state when userspace puts
>the vCPU into any state other than HALTED via KVM_SET_MP_STATE, i.e. clear
>VMCS.GUEST_ACTIVITY_STATE if it says the vCPU is halted.  Add an optional
>kvm_x86_ops hook to do the clearing, as SVM has no equivalent VMCB field.

[snip]

>
>Fixes: caa057a2cad6 ("KVM: X86: Provide a capability to disable HLT intercepts")
>Cc: stable@vger.kernel.org
>Tested-by: Qinguang Chen <chenqinguang@kuaishou.com>
>Signed-off-by: Zhiping Du <duzhiping@kuaishou.com>
>Signed-off-by: Keqiang Duan <duankeqiangcym@gmail.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
