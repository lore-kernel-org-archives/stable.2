Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3183AA9E8;
	Mon, 20 Jul 2026 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536651; cv=fail; b=WdpbkpJthw1V8ihTtuKoRO/Lvk092Hf8lIVoC5PuDq029AhabbwWlvm0MxN2x3296LnfBJJuXNO98dGMQzW5g/5n+vN8BRvnT+SgSkVGcpT6hS8ft++h8vaP7zSaS5jwSIu6V6oAwi+4wX2aA5CymyJtsiI7yUbZODa4uJUk+W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536651; c=relaxed/simple;
	bh=pDekd57vp+WplRzABRw1JSRmLWZJSmv8NnuIcwgy0Eg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5kWkD9pFfWNfIt+J6O14/ijNxoDDD3jZ98DJYfFDLcedn4dxbuCobMs09NdZEr9NbA5XvdWQk2lui+9TDk1j1o0yBNFjcyFqt8zvPXj0kyOzq22ADAKSTs6HyA6p9Edqpj5w05vfYtz0NPsikIahxW2kzsqHDa0eeqhtM1RZxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekEsSpII; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekEsSpII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784536649; x=1816072649;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pDekd57vp+WplRzABRw1JSRmLWZJSmv8NnuIcwgy0Eg=;
  b=ekEsSpIIg5/q/P3N4f+ImF1sKHl1Vi2skZRRrlwEKKaaFaxluRnJiNdQ
   v4MQ7kzCCOkRNKcTUCFTPXLqNDeXy4x88VVqgDn6w2bbEyGcmqc3F9dyC
   0LBFm6ecwZ9dqoeB+STF0g9mkyfLA4Vc6mfARYOzNztsvrFZNlIoulnnT
   MZEfXWucOthx0ypTi0H1He/VrlZVNdnSUbMAJtXEyfSQR4iDiD1PyYt29
   FlRrKEE2JkbPpaAGHk9xJq06fmSQAoU+CQD/ccWR6mxt6GJXoCK/qMi1J
   6nAeY0+mJ3oOyogl423pMHx2nFYBEXgOliJAHXFkuBikzozQqLafavjJe
   A==;
X-CSE-ConnectionGUID: nt008TFsSsmE8mTh8S+GIg==
X-CSE-MsgGUID: je/Hc+7CRd6nlwtzTGvA3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84989099"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84989099"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 01:37:28 -0700
X-CSE-ConnectionGUID: 7iqOj4GgSnifX6R8PFxwqA==
X-CSE-MsgGUID: elgtDaSQTwaKuHL8++DHSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="295602650"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 01:37:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:37:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 01:37:27 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuI3G5Z0rjizA6SL8CLuZPyVJo6vT/ar+UC2sF8SDgEDB3d1d4SKK9mU2IfY2EhQSA/xzk0V8nZpr3SsLo1PGvF5iaJQyjg4pv/8DfEUl+/zpdk6WpsjvaneVp4NMF28lao9D8GIXyZt07iSDbgPzR4HzCREF9C3xGEhkZeNC3vIwjZTAnXveg6S31bNtNblLfRTXjsD5gUdDoQG/DZMphRtlPN42daPg2bjyxSeAtb94XucvK4e3K7RvIkE6EPTWPbCI1bccuwpUWp8+btSlClwNUlaMAFoT9Arrb5Spf+aXwzYG+WCyGb5rSQf4hCjKBuYInfXCAvMAAe8YjWw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPcxGR9yjHULdrHaBMxugimJe+Gh7CuZBov4JFN/cDk=;
 b=v+DZBI5E3GbyGvuiiDmOXmwPs5gVCXA+zB810S993eOh3LnKVFmNYBEEWIJPMr0+EI/Vq7yknh/W3ee4FNaDGdLWPtf2lsdazkAAhOrJOgF1WgJgSz+EYrykv6z8vrkvogTDguxB99oEPn0bj8T6MBbbVXNjh7zP4a7WoSs0bjW/C2KTYM5Lqw5VWve3wXMVaZLFrl1FfNbBiLBOTKJnqXJNCQgZYUBxZaLTgUBDbCIAJ+jiAnXm702FsdcmBZJQ9FINBO+CHsyLt4sl7MoUMf2WPiuZiz/CXsMPQociEr21Ec0btfrhN6Lh9NBm8LSsw/7ebnfdXH9VJif3TZGuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by PH0PR11MB9704.namprd11.prod.outlook.com (2603:10b6:510:399::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:37:20 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 08:37:19 +0000
Date: Mon, 20 Jul 2026 16:37:08 +0800
From: Chao Gao <chao.gao@intel.com>
To: Venkatesh Srinivas <venkateshs@chromium.org>
CC: <kvm@vger.kernel.org>, <stable@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, Sean Christopherson <seanjc@google.com>, Jim Mattson
	<jmattson@google.com>, James Houghton <jthoughton@google.com>
Subject: Re: [PATCH] KVM: x86: Only reset TSC Deadline Timer in
 apic_timer_expired on KVM_RUN
Message-ID: <al3eNJFTJur4FI8T@intel.com>
References: <20260715234234.15382-2-venkateshs@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715234234.15382-2-venkateshs@chromium.org>
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|PH0PR11MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6491d9-8e46-4e68-feab-08dee63a1cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G+YzvA9RJggIIZLmhgDHOUhTTlkG/KVlc6IMecpTeIm+O/oEr/YB9vIhdeH2Je54VPWbIPtHt7ZnsuBRRHeJoHlxdBUjUAf1JkHa6p5y9hdEPcB8F1ICpcfpQivuFBzQZG9Rwg9AQb8zkAp70cLKLMPCjzBKd4XpBJK1Q7XK6kTO7WXiUWkm/8iddxTWWfN/DHHWxDdpMQ1DS0ZtsRAmkVTrfS7UrzTlH2X0UX8hDclNPOuqXqJLDSPoAeHWZPrDvjtoB7hqbtfkA5ujm39kEI/9EglAFcH+GmUZ6MzLR0TqzxKkG42AmXlDth06j5QvyzhX1goscB2yb1Hsl5x6NddDXkf/x5Ik3zATbJYugLCN/a4zt5QKQM/hhZ66s4Auti3+8frSPw4+hdPzfYPK7NzGE5aIk/NOwL3rksV3p6UGR931XKCTDKoPPBt/+CRVig7XFk3/8pLBbLXD3k1RmuEjKSZnIaw3fcQq6cDPqo4fnnyhLK0eNa60fEucHz0jkD7tMgf7c/SNjNYHMH1H/VaBbRqhpyqmZL541xX0I0y+ub8Z5aATVdm+aXhhEukZHiPujZ7Q3YNCch9kIw7gb22XvJ/xMlA1nKiEDXCAbMr5ORmUyA1WlOjEF7suDOUdSZu4vjQ7iYU6f2/Ep6uIbmJLKkD504On9HTgetzcEVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6q2oY9CmKW5RD83WUT95CFe4/aFSqEGzgfbnLWaT08WRegudENRzzvkMe/R?=
 =?us-ascii?Q?ku3dul0njIe4m8EVD7WXIxY7Cy8VfLiCdaWYgvfpzWVP8L9+PjgQQA0tfXx2?=
 =?us-ascii?Q?U2gRFRS4Py7I6vjKf5+wGe4oCQwjQ7gu+ZnBghRb39c6qaVlp3qsya/2CGBP?=
 =?us-ascii?Q?IB54vI4V2ZT02stwH1nHXt4n89zqDpGFaEcPVvTTlNfcDPrh3weW5aOmNTHV?=
 =?us-ascii?Q?8ycszliXWXvuEZ7+PrVmMnHm5iiucLx5GdEOrticIzyrIbUdSxTu45z8U0qU?=
 =?us-ascii?Q?fq6aPRtpNracqQ84t38raR91ZO9hSM/acOFW0t78DBWcn0VEZkLscJx9onBD?=
 =?us-ascii?Q?WSBbubEYh4XMAlRhtYmcHBiYhIQ4RXsZi216eabjb51Bh98f7h9U0eV3gL3l?=
 =?us-ascii?Q?zhusiH5QKp0N0+4hMM5y5DLG93Ihqblh/XlANnEtRHbGH0fD8oPf9jgx0t+/?=
 =?us-ascii?Q?y5i95WWZH878XnF2CvwfcAyngTYN1wWnklE7A6pzqOlLB60rdx5eGkSmz8md?=
 =?us-ascii?Q?YPQgEe/tTiI1uOlwNXBoQ/aut5c+96a9ImF7jvpIlZIsAoM2e0T3LKM75KJk?=
 =?us-ascii?Q?mGV4QBNf/J66yMUjwfuxrk5VN6lOWKzt6zlJGSYk7n2Q92z/2ox7I9rT67SO?=
 =?us-ascii?Q?72YpOoD9Dg/MexYdpRsIYwtcY3LhXKF5dd3j7ASt1cRCX1JyIZiTKqIvi/Pr?=
 =?us-ascii?Q?hVZ1phyPKgOA/RrxfF6pc0jYVSCb2AKugFShsNM/w6OGUrKKx1Y87iCzBUV4?=
 =?us-ascii?Q?jbQzel0pxQ1ITFnR3zV2v4sZ016F5AonT1Z/ZngxWcrqlS4v/biSwYsbHJ9P?=
 =?us-ascii?Q?f1+H78XwpdTq0O7w1v6lYK/xMkzyfaGgt1LYl2cD7YObklU/opIaQKsuYUTS?=
 =?us-ascii?Q?tWW1VbN8cM1k0BFAkCK8MmrZK4lYVcM9EC2gzXw2cmeBa4JOE0BziyeMbEUQ?=
 =?us-ascii?Q?FSIVpqhBdwIxi5eDB6iW+lXvIdqDNuksisk4H4gh2iq/wujc9CUhg80sx1hW?=
 =?us-ascii?Q?ExFr6b96AcS+T1j2vq9pKL06i09dmkJoktxDNwIn1DiTcSMkSD6EdAbRSh0k?=
 =?us-ascii?Q?V5EYD+ltaFlULuNZHvjXihGdxzYQphbJ2+vQPR49eCgar1cH7uTNNPwtJ65d?=
 =?us-ascii?Q?unme1Kg6tSbqnbcODC0qiGWXXY8VJJi9rLKpYWxqcO8OvTKyuyjXt4IDNI5G?=
 =?us-ascii?Q?OlQafk0jd2Z+EBldPvjn/+w7XJ0dJalyHEvLHZlRRpH7JHHQH41W+IPAYIub?=
 =?us-ascii?Q?Z6mGU8FE6cliXTVw0i2Pvq5lpiADBqnruTn+uNPFaO2aGrDAzV19OY/PGPyV?=
 =?us-ascii?Q?IXGhU03CWLZymDx4uI1TGtYF7g1H9cA7/A33uhv/bNeWuwvlPZOZJ9VqKkMq?=
 =?us-ascii?Q?UchZcX+0qBGXWjXKSIj9I89jeNOkAn1p5il0BbK+eBk6W1FSP/G03RHvXV6I?=
 =?us-ascii?Q?xNQEUbtwAKRmuOnex4pQkKvNnJt9FYxeDg5NkF0WpatTN+CjUG+eBEnbB5sn?=
 =?us-ascii?Q?DgSUxmxtBOZQ+bq6f3LFznE7CuZP/wgGl2eMuW/zqi8hMKVXpWn5SrdVOPZr?=
 =?us-ascii?Q?jFbzlhvS2O3Dc6etY0ZDsED1smAkggYSte1L5tzSTQKNyYFO3DcbEytYlQaN?=
 =?us-ascii?Q?5HYeaZejNZ/mIufw+H1BwanZAyAY+o/TgrWvp8mhdzvGvpjgj/EBAnksCy6d?=
 =?us-ascii?Q?9mZpAHEQI6fC90a6+0g39e7ORp26nLiZdGcU4IfLum+1UwQTzMAimpSuTdk+?=
 =?us-ascii?Q?MB6UfeN+pw=3D=3D?=
X-Exchange-RoutingPolicyChecked: BOEJXO2u1N8rvEIzwf6pIWuREm4E8eZxqBlRSwz+ASCGhVkOhlCQE4tr73hkMEkib+3xPmY1tb8ZQPFLv2jTXa9/nRHEJA2uImCyQkXDGd1ebAjb75+6peWCcpIMRWf0lzivPwm6O0zcraOFxzHsJJ4CIK2M6Lf9bthYwc5dcUDzMQ1XJCAMg266O+hUuEbTXB1guxspFMmS90KepQqkkTJ8YJ51mbg912g8+OFhmyAT8wEtooVXFe7qlWy1xjwuFYEv/DMOJWRYekxmjaLJ4HfptGSyyNV5hP8bCXSzxEha9z5hju8ulzvVVUgUfLtbgnOi4nAeEfTwqgLWJmYvaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6491d9-8e46-4e68-feab-08dee63a1cb0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:37:19.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16O1ZVae+4vjHZ/OjDAcCHd/IqDE5GgNY0N55+0qqRYvG0OMMcK99Y+odNflZ26nkOlYHk8xBuAdmsoNvmUAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9704
X-OriginatorOrg: intel.com

On Wed, Jul 15, 2026 at 11:42:35PM +0000, Venkatesh Srinivas wrote:
>Fixes a lost timer interrupt issue if:
>1) We are on an Intel platform w/ a VMX preemption timer && APICv
>2) A VMM calls KVM_GET_LAPIC before KVM_GET_MSRS to save vCPU state
>3) The thread executing the two calls migrates CPUs between the two calls
>
>After migration across CPUs, KVM_GET_MSRS calls vcpu_load, posting the
>interrupt and clearing the MSR:
>vcpu_load() ->
>  kvm_arch_vcpu_load() ->
>    kvm_lapic_restart_hv_timer() ->
>      start_hv_timer() ->
>        apic_timer_expired() ->
>          kvm_apic_inject_pending_timer_irqs()
>            . post interrupt into the LAPIC state
>            . clear IA32_TSCDEADLINE
>
>The saved LAPIC state will be missing the pending interrupt and the saved
>MSR will be zero. Oops.
>
>Fix by only posting an interrupt when we're attempting to enter the guest
>(vcpu->wants_to_run == true), not for vcpu_load from other paths.
>
>Assisted-by: gemini:gemini-3.1-pro-preview
>Debugged-by: David Matlack <dmatlack@google.com>
>Debugged-by: Sean Christopherson <seanjc@google.com>
>Debugged-by: Jim Mattson <jmattson@google.com>
>Debugged-by: James Houghton <jthoughton@google.com>
>Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>

Reviewed-by: Chao Gao <chao.gao@intel.com>
