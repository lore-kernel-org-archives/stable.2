Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569837C927;
	Wed, 19 Aug 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148173; cv=fail; b=bt9WvU+shzzi/Qj82Dsv/2ECrErqrhez2/wHBRcJZnVKbDVdtVXAVsN2SGA0xdf2fsrjI2Ii6IbktHZzT7kvxjY9nxdc71YhMrE1PiUC9CbiB0M00fFJilzeqXZ90EzTX2aaebUv2ICKJNSctInnQljnF4+9I2dcGD4YL6ESwSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148173; c=relaxed/simple;
	bh=kU+E3XKf/uI6XF247VqOKiXesjdyA/Ueo7pI9TMJBdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cg/9BdcGc1rCyrndwchuZA7vfB4fv8Q9NoEqoHjyYSVaaDSCXCr8SqTgyjcGbOsV0wrFuUjnZk04XQY87k8+KclnHKesBQQ6WLeK9/JWpRoqpQsUjz3npPt7Hx2lBTtupmwJARtkJ3K/KonFXpA808v+IpnwGsZjdhM57Dn4tno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rpasp36s; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rpasp36s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787148171; x=1818684171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kU+E3XKf/uI6XF247VqOKiXesjdyA/Ueo7pI9TMJBdc=;
  b=Rpasp36sRDRrQPM4nAXmSngjw2WH6Zuz/T7HscXwE7CdrAgnsXnwAhqa
   bm8vac9xnLD3S55kdHurwVAThvC1xWd9qeDIRLvAzxEy6UfVmDnwJmHGK
   fkDsujTv0BVpuiU6giRZTQVKFrOZMWS6aij4iLx9Cb8KgetRJ2wLP7Uoj
   9k99clvS4Yk2C4bIbssDi2dKN7tjN6JexiWbn1Jd+Uq/u7Mre+gzw4JtW
   Uj7LpnMHrsAEZB57B+QqhUIkrSe5o67T0q7YgxYnHrDbhf/YYAbVb1aq8
   j8Zzt04unohnBaOMsGP/Qhk1mD6hm07WOD6/k20LAd/Z8rfJTUiaoB+Vy
   A==;
X-CSE-ConnectionGUID: GGZ13j07Qve6b5zc4bu4Ww==
X-CSE-MsgGUID: iOY4HE1tQB6+vKkEXAkeAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="110449265"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="110449265"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:02:51 -0700
X-CSE-ConnectionGUID: aHZ4mVxyQfivcKfH4pvhQA==
X-CSE-MsgGUID: msfirdmeTUC2sIfA1zJGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264238785"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:02:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:02:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 07:02:49 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/CZ2l+zOc1vt7mVEG8kbzI2fEHmzzyak2w3zBWnAKor6iBIJ3ZWLqjwbV2SjEsifOx3QkAmfzmZwRFtMIJC2qQJf5lkxq25yjcgttG/+aad8Rwz5ybGaKnyyklrN6Du/XEsjZ8211k9UJtAQFLw/uiq7YMx0SDJAVChxn9mZTYM+3z76l1j9ESbtfz0VMOTRWCjJND3s2n4ZydGtYfp55e+EbWoUhRlQf/ZFyoNFt3lnEpeUVWPyYFZSDgjzeZ4x5OxbzBf1CONBjXu4mPpMVlHIOC9fIXJlBjEPo770t5upblc6bxnDj6fYZuy8o5doypQGmgyXYptSTY+L9KbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/JVc3cLiujoP6JZE3DnALR6Q3cJl+L+LgydhcEmJio=;
 b=czairPpmv8aTRiuO8NNbZ1meTt07T0NfCdXhO8dPIGS2l7ATI7gOr+1ZXe3mVA36DT83ZcAqGoiy8F3qRoVry18uYRygln+feU+EnNJOa6v5pVksBjj/3fKn9kVKTJx9xtk3AcB1IU28ZbD3xOEsMMjFA+nZQY1ONivJhPGJW+ofGZ49s75sY7hxEoOXvZ5C3PJbsQqdQwYEC9cPHBRwrtxlgugLwwfZXhpZw7CxUG0lL30SRGiV0GMQoA7oDcj7Sc5HqKiz+3LbhwqWggIsn5q9eal3Wxya8z8Y+xvYv2ewuSyR23LHzlw51xJ2sCqj0EH+SxZAa8Zl4KRPZl2MJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:02:45 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 14:02:44 +0000
Date: Wed, 19 Aug 2026 22:02:36 +0800
From: Chao Gao <chao.gao@intel.com>
To: Keqiang Duan <duankeqiangcym@gmail.com>
CC: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] KVM: VMX: Clear GUEST_ACTIVITY_STATE when userspace
 makes a vCPU RUNNABLE
Message-ID: <aoW3fOhPuFY7Whia@intel.com>
References: <20260819034652.98938-1-duankeqiangcym@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260819034652.98938-1-duankeqiangcym@gmail.com>
X-ClientProxiedBy: TY6P301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::10) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|IA0PR11MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: d40c2662-68ae-4450-82b7-08defdfa8ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|3023799007|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VLg4QUJOybCJ+avk2xfHmLsPwZ2vgrd+Y3TY0Q2e6/mHKhKE4RfkjWQBbAAMtFe9IeRUATiGjN4ATSW3sUxoV19L7lLjLy9RiG3QIeUP1dE6aDdf0zyRl4TwoZ5MQAL4YgmKJysRsfptE6Py24AdrVLjx6HGDzKf/I0nKwgli31WGHgSTQYoQDUmfGKKCfQTMX4lwzNoWd6ODPrjZFEOTjITR3efX2nu7M2E09bMS3hZWlPEVtToe08GbqWF5ew/IuwoOi/d58M0R/YRskf23A8iyjc7T5oZ9ZkKE5DnRwjbkinbvCW4yFfBRzkB3iTm5P9I62agkuGttyUOpoCsrVv1oSf696Yqoun3EsMPMCQbjegAP0+s1gD62CUrLo6T2W6a2fhRGTTDuL6jgKDKNr9TbaO3I4PScNaamdKf5Xl1xYvTz9Xe5pPiHR1d4WGJpVU5Rz8GkpMPDcxY41Uy+w9faOR+345p0k+RudcYPyaAzLB93NyhyzcZMUzC0klGLzXFntdt0cQY0Ub56pz6BvIsLE7o3ofZaRW6NDcDLYK8QZeFtaPU1ysDlLvZOCenSQu6enGhAj+FowV8ukzdOC8nqGmBnQkvGoAVre3r8z7a9LC2zJzauu/yB5JULJca86M+KMRZANadQ3XgwPESGRRzWPwg1S7ON32R7nBs2qI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Y/msJqXGpkIAr0DwbfZjG6VH9X4kuyeblwnEOUgUINle8VFJ8GFqFj9o2Ta?=
 =?us-ascii?Q?stTWqdpWCq61POShEc9rG/fPQhb0MWRFRn3h52pof5EGiQTOUEQsQ2+mKL2j?=
 =?us-ascii?Q?mLHYypOtQ/qnzWPtj9bMLShs+xTptAGSykzmNKnVEOm6c7wAWGFThi2qv6sY?=
 =?us-ascii?Q?bf/nRaTRckIHnUkFe7+Q6QaaN7+FAlSbvKMhYkwOC2AhkSemOQ8gFKaNFpq4?=
 =?us-ascii?Q?MdG4t6rmtHdn7QLzfHr5eE6JR1QKzIlsaPRdlzBAacjB+HRW/tHeEYOhXeua?=
 =?us-ascii?Q?Yt8X2matyYo6NsUPzqtlzVfx5KKHcrdH6tqJtnOESy0IVT4zQ27TtE3FTnIC?=
 =?us-ascii?Q?oPggZxmERirxpqW4dUKsx0/0MyRK1Ol/19E8aUbQKn8LvASlxWiHxa19oAWJ?=
 =?us-ascii?Q?nimG6pMAQVY6Z3Y0OD+7XDymCuTKPH82EJP19qd/cYgOrT5hmRZ5YnMhJNJQ?=
 =?us-ascii?Q?Q+xum/lQ4Oj+FahM+VMrKJmrVnnFGcYlBI/NgTpN0tIXs5H/+jzg8gKrTgk4?=
 =?us-ascii?Q?zw1GKp1nGhV6R1OO8SL14Rx9uEPkRXGPnT2KoYm6qy3tJgUbBk4ybKecgdVQ?=
 =?us-ascii?Q?IDBSF/Kkz8/qRVVvaZe6DZFvWpoNB+fojWMHAfNlZIELWr5VK5k4o7xCpe/v?=
 =?us-ascii?Q?gKmNgBSFvyQBx8hJGHtqExHA0vuazxhrOWw2UVqfe6XpghEl1tl6OyPOgRsI?=
 =?us-ascii?Q?qzMKVC47Dn4vihuZrGoHU+q71JTyR3Ud+mfCNIfYjw9biJCqqKTN7mUy57rq?=
 =?us-ascii?Q?hjNGYXpb0p8d2LmOnvXQJb+v6X83VIA8RW0+Cc0g9hhiWT2yR3z/DPe1Jcaz?=
 =?us-ascii?Q?5eGP0vgLf08cEPC5ZH8Xs7/Lb0QdSTbarfdoBE8/OaaY+utuPgUyca3BsYeT?=
 =?us-ascii?Q?ypE66+g3tO5dA1VZLixawcwoueGOzGv3dbwKiqKUGfTip1wqA4YJn5dxH9Lq?=
 =?us-ascii?Q?PADGo1HqzM/rSjjtAiZoCBXq4+OrHyAqQfr5U/sjataQ5Xi7neKT+x4Pqd9y?=
 =?us-ascii?Q?YiCzp9Fg3X/DIBpnYQF9JEhr5MaNqV4ddeaAXXxToYClgm6niNJG663bRrkH?=
 =?us-ascii?Q?C6Wq1YOHgDlukCSBiaWVuFmLVauicymWZqlV76iCvTTRJVcwbsCeABLWcJaV?=
 =?us-ascii?Q?Y5q3xaf85NtdMbeANJKEWHOrk0QW1l4SkoyZa8UF9lzg/wd4sXZLHC2L4x4n?=
 =?us-ascii?Q?MWiC47ennzu35rX3GT75c69oEPR6/mEQ8Pz0zrlAgDzJq72gAd3NurHnJpGo?=
 =?us-ascii?Q?ZxLvsMaoT1eJxDmYvnPp+AALTE6+YBRQhnmc30M96kn6jVqE8OCL4dDSEe/D?=
 =?us-ascii?Q?TyDlfUr2WZHNppUJLi0AIwxZqHEZk2st4cjOYOEUR8Oqmt6JPpfWj3aASOXO?=
 =?us-ascii?Q?+yMC00Yu3jU6wrerrVWUlGjZlkiZZY84gnc3Kn8TDK0z+06NdYwenXE4qhjZ?=
 =?us-ascii?Q?L93L6fhB38DH6+R/98rfXKAz5M30Mt+wmKFJV8kaXWPdGpC+pNJC/My9mKKy?=
 =?us-ascii?Q?She+x0CdFc1ErI/4WVcxhYBBeHCBmrkU8XJMcwQB0W1vEUhOB3egGUQU4AnK?=
 =?us-ascii?Q?rL06jkYw2930aL/XzJQQd1iyk2vfQoJfdhhmTLul1MHq0KMxeFjc+WiCvw4e?=
 =?us-ascii?Q?v3YN2BuPALglX6MO/hXqVZoKdJj+Y54uNd3r1OZeLiIjKIJeqNM2zvrd8Bf4?=
 =?us-ascii?Q?J2bQdcMoZ28Ntvu5GVpLgiMb46qPmRD7zhhIWmCz3lXGUj/RBaj02MWMmjIg?=
 =?us-ascii?Q?gEX/bLV+jQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: WqLMywG1R4T38TTVaUMzQiHAhZ6+/qS1MTUIMG5nI1rzkf9+YaT+e0PZNXzQ0apObVr/dmhIWjN9wMCRWJmMXjf5RSBn5H3CrPTgDHkhHdu2HInUY59aNrXZVzzk9cYGVi+FG0NbyUxVZfFV2eHSgQtjattFrlck1U+BQ3fRhNzdQp7Ktv9IvPf5qlBXPNsZLyjDAMISQboDg2MOsRmoYQ6j8LdVqArkJyvgP1JezXyYT3W6IKh4Dh7A17TAd+/BxWSfdPiWNq8zfjuIfd2+kGeDzVjK79PQinLNmTsG1ekA8fSJsiesPRUB3pyL77uiAhsK8hYj20LxRMvHrxTS8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d40c2662-68ae-4450-82b7-08defdfa8ab8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:02:44.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPGKDPfyOPNzdghHf2c1fmMJ4opAM9u0QxSDcidPfDDhI+jhua2DLpMsfm/xOZKkLaxhvt8PeMvsGaNIQ8J/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
X-OriginatorOrg: intel.com

On Wed, Aug 19, 2026 at 11:46:52AM +0800, Keqiang Duan wrote:
>Force a vCPU out of its hardware-tracked halted state when userspace
>explicitly declares the vCPU RUNNABLE via KVM_SET_MP_STATE, i.e. clear
>VMCS.GUEST_ACTIVITY_STATE if it says the vCPU is halted.  Add an optional
>kvm_x86_ops hook to do the clearing, as SVM has no equivalent VMCB field.
>
>When HLT-exiting is disabled for a VM (KVM_CAP_X86_DISABLE_EXITS with
>KVM_X86_DISABLE_EXITS_HLT, e.g. QEMU's "-overcommit cpu-pm=on"), a guest
>HLT halts the physical CPU instead of exiting to KVM, and hardware saves
>GUEST_ACTIVITY_STATE=HLT into the VMCS on the next VM-Exit.  That field is
>sticky: it survives VM-Exit/VM-Enter and is only cleared by vmx_clear_hlt()
>on event injection, or by vmx_vcpu_reset() on INIT / vCPU creation.
>
>Nothing clears it on a userspace-driven state change.  KVM_SET_REGS only
>writes the software register cache and KVM_SET_MP_STATE only writes
>vcpu->arch.mp_state; kvm_vcpu_running() likewise consults software state
>only.  A VMM that emulates a machine reset therefore ends up with a vCPU
>that KVM happily VM-Enters while hardware refuses to fetch instructions.
>
>Reproduce with a Linux guest by triggering a panic/kdump on a non-boot
>vCPU: nmi_shootdown_cpus() parks the other vCPUs -- including vCPU0 -- in
>crash_nmi_callback(), which does local_irq_disable() followed by a bare
>HLT.  The capture kernel then resets the machine via port 0xCF9.  QEMU
>rewrites RIP to 0xfff0 and sets mp_state to RUNNABLE, but vCPU0's
>GUEST_ACTIVITY_STATE is still HLT, so the BSP never executes the reset
>vector, never sends SIPIs, and the entire VM hangs at "reboot: machine
>restart" forever.  Only destroying and recreating the VM recovers it.
>
>Clearing the state is always safe: waking from HLT is architecturally
>permitted to be spurious, and every HLT in the kernel is inside a loop.
>Hook KVM_SET_MP_STATE rather than the VM-Enter path so that the clearing
>is driven by an explicit userspace declaration, and so that no work is
>added to vmx_vcpu_run().
>
>Note, vmx_clear_hlt() loses its "static" qualifier as the kvm_x86_ops table
>now lives in vmx/main.c.  TDX cannot disable HLT-exiting and KVM cannot
>access a TD's VMCS, so vt_clear_hlt() short-circuits for TD vCPUs,
>following the existing vt_*() wrapper pattern.
>
>Fixes: caa057a2cad6 ("KVM: X86: Provide a capability to disable HLT intercepts")
>Cc: stable@vger.kernel.org
>Signed-off-by: Keqiang Duan <duankeqiangcym@gmail.com>

There was an earlier attempt to fix this issue:

https://lore.kernel.org/kvm/20230630072612.1106705-1-aiqi.i7@bytedance.com

Sean suggested doing exactly this there, i.e. clearing the activity state in
kvm_arch_vcpu_ioctl_set_mpstate() via a new kvm_x86_ops hook:

https://lore.kernel.org/kvm/ZMgIQ5m1jMSAogT4@google.com/
