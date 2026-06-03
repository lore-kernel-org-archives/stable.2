Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF03328FA
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494469; cv=fail; b=i614E30QNL//ZbWaMv1uy8Y9iv7mHmWOvYwdYX710n9vK9LTbIMiBB22qneN3NvTDJPTxi8FhVieSzPTAkbs6RCTiZM6ChtVa0OUO0ANvdTWnixRH87CF5DKVfo3PBRGwaMVFHwnJevFWPG36FOMztVxemh8s6pT1awD14N1/y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494469; c=relaxed/simple;
	bh=wJLxj+t3vPUrWwGiF3M/tgt4pphxhaOGoxlazz4gkhw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wc4tX9udMy5XA1W7XFJBF2qb3KkjnzzTFuaFDdIaGITNrJ5+vMMjY0+yF8Gk78SCMnJc1DZx2UptahRRAYLIMfox6bquDqEtcASOesDA8N+lSgaf/HUAevugwrKxdJZ7febgzcbfvz0jJ1T8VZifs42WbNRckT4lRUkmrAi0YAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLOPc2Ux; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLOPc2Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780494467; x=1812030467;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wJLxj+t3vPUrWwGiF3M/tgt4pphxhaOGoxlazz4gkhw=;
  b=FLOPc2UxA77K1L/Y0yNxxaGyJA0XjGBYIJpsHwnkS9GCrpSwhXj8DJIL
   8zhUbWGfYMPO2zzh9J+k6oVzewJ7phvhvUreH1uklNYupN8gVjRTkf8QL
   ztDKbyl6jOgUq273qcXU0bv0OIFcPpqUnzKvTCVX32El5mx/DGF61QpM1
   J2M/k2ts62ZXn17TXPE0VT63Rhpht/FPY63BOxKvqqw3lEK9LTwAVx3f+
   QK6sjS0LG0qL7l5p1b595zVZsX0HS5G26CGPEOs/jQ7R41OTxBFcoGb70
   NQlOvyxDfbxfuB/JYT6oWpbwKlKABbvDmPUhiR+R4qNaE/2w4Dw9qs6kb
   A==;
X-CSE-ConnectionGUID: 9wIrleDZTge2JNGqW8CRYw==
X-CSE-MsgGUID: gRblQeL/Sum1WuFO3UlRlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81364747"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81364747"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:47:46 -0700
X-CSE-ConnectionGUID: jF0dyWvuRpCUbKQpS+QjcQ==
X-CSE-MsgGUID: vCksp7kcTyOK5zIwIFJzJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="248553315"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:47:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:47:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 06:47:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRzFJL9EN4JOThL4/LSpwd4i23IY+hA7bn6m8a3HwX+DhSKUiWgQV5rr8GcFUOFy31AkFOZiIMlK7FsmkQKKZVHeghgl1TsgHtjORvs+SKc+z1rS1OGT/8m2HucSJCmKriFMe2qMMpeYb5QjvC3dkHwf8mEi2Uv+Vc013II93QAEXU3N3Le1kTwgDF42FmVbpZYQ6PslUXqmH0D0PxXgAMv6bQlihTcp+djrAaccmugxiq3jlwZaPRueE5vrYuibMBRsWBVTiz6Y8D/2CWKsmDzea9mi+0oMVi7bQJDEu0NXmwzgedOKdnuFgNkY4Dwuk6IF3P4mExOkLUcKiEle4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4JQPl8YLmRUbkYrY15T0zWk/2lt8puP5BzgKiUDX9Y=;
 b=qNKRMn+5R8IXfDA+8x+vyQyGQOpddGpH/dLiN7R3QXyd/71/YDDLqOIm+dNxBLwls8O0y7jBPMseL35NN1Fjjpa4fbVlg2TD4rDAIUk6I3o1I8AvgV2YnXG+Nf73LWiJqSCX1rnE4fCkFKPgiUldshAl4aCbXmnqL9z7ypnmGrw5/Mxx7w+8tgYWiwvqURrH/BbSjpWEp1gX8/AMEPXRB6vvRZKkL4gGVq8s86L6oT0BaFeoOJTi+mI1yIWdBUu9LtyHDTWMeg31nQYuvHVSefP/OQNAY3yH+18aNguyNNxQIRid9g43uIfsAJRugeza7iz5+sLEeC8VGhAxcYGMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by DM4PR11MB7208.namprd11.prod.outlook.com (2603:10b6:8:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:47:36 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:47:36 +0000
Date: Wed, 3 Jun 2026 09:47:30 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<nirmoy.das@intel.com>, <umesh.nerlige.ramappa@intel.com>,
	<thomas.hellstrom@linux.intel.com>, <matthew.brost@intel.com>,
	<niranjana.vishwanathapura@intel.com>, <thomas.hellstrom@intel.com>,
	<fei.yang@intel.com>, <himal.prasad.ghimiray@intel.com>,
	<matthew.d.roper@intel.com>, <maarten.lankhorst@intel.com>,
	<joonas.lahtinen@intel.com>, <matthew.auld@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] drm/sched: fix drm_sched_tdr_queue_imm to not
 corrupt timeout value
Message-ID: <aiAwcnWbsxUIMKbI@intel.com>
References: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
 <20260603120641.473434-5-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603120641.473434-5-sanjay.kumar.yadav@intel.com>
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|DM4PR11MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4887ce9e-0f03-4e7f-2645-08dec176ab5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LjYqECUaUBacxs89Qo7kocX0JvSxrEnkdcHoahBtTLcHdynv2gRYMt0IMcmheC/hjHkLJ2I33oe+no+P4kN7Shayovh7OmPdTCFNf3AMpPiNrhX27CVee7CVQlfLyuua4+5r42RwyObcz7l5x5DzSB7Wqcia/EczTnL4l5NSmQqwaSjTdGuLemtQ8/y9YPMLJPqDqmIO6e6idAMkIMs20zGUj2hlK5ruwrxWsxuj2tzFHOlPPU8Kyq6sHTFWLBeRb3MdeHGIzcnOBTqM/UTgcOMhxkfVAimCgwgRajKz76LuhWurUa/VklszADw/YFxVIpq7SZT07ycd8nuRjkyLED+Z0+KXxmhQxhDv8u0wYQpqR6RuITotCBlzBqghefqCLg9I/2YY0v4tJ9cdKk/bORF7NzU/4GpYDOuKd/I/Gx+BenkV3ArnFbO6L6/YdPclyxGZj1GwmgrrPL45FZdGpu9iTy4CDAczQLHYh2+3G5y3OhYEm6ajMxp+zgl7yxzKoAZzp1obIN4FC5LEk4pHxD1WCu7nYbTLBayK280Y8HatUdLdJJ7eONJ9dUatlLUCfirwMKpM4SsCCOihlMDuDf1zhgrl89F5DulHWlVnA6KMaeT4LVdH40COueID0MJCgzR5Iz6eb2KtacypgwUn0esLu1l2DFyxteePxVFftkoq+B628uHncX2pEhN1z6jN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZPMWs5Sk1yMmxRMXZXNzlKdExFd2JQM2NyV2hoSUZkb2Q0Y09RblRIRnk5?=
 =?utf-8?B?c3pVdCtsemp6S2tPS2tQc3BwTnpjOUJzYU5xSlh3QXlWOGRERURNZUFGc1JW?=
 =?utf-8?B?aldBaTMxUndlSWlvT2U0SEZJc0lFZ25mTzZCN1dxVnExZFR1RHFnTk9oYitF?=
 =?utf-8?B?MkRERW9Dck5mQ0lhSVFaYVFwRCtaTDNGYmRoa0dmUWgxeTA2WjNSZkF1dFBx?=
 =?utf-8?B?OWtIOVBxVW1hY0ZMWWpQUVpyK1YxV1BmV3RkazNPMnpiUlFDUG1OUFRGT2ZH?=
 =?utf-8?B?bFM1T0FBRlM5WG1TN25rSXRaeEpxSGpsbFBYTEFkaERtVHNIRWcwZWZwd3pn?=
 =?utf-8?B?Y0RsZXNUeFkxSVBnMk9QclFCM1NJekZ2UjNaVzYrUTBLSytLeFRsVmNYcXN2?=
 =?utf-8?B?Mk5OcHN1N2d3TlVIK28vcStxNUtVTHZxdVU0d0diSWdaWDNlaGRJaEZmS2Nw?=
 =?utf-8?B?TVlhV1QrZ3VHaHJKRmFzLzFocmRENjQ3YWRPNzFleHRNUUNlcUMrSmRHaWU3?=
 =?utf-8?B?dHVDRnF1RU5MTEp6V2lWZlZJQUNYeUJocm54eTBLaUlyUHA2T0VmcFQzTW5P?=
 =?utf-8?B?SnFtY1V5NHZQNzJGeGVja3NiNkkvd3RIa0xhRitET1JMaWZBYUlNWi9COWhV?=
 =?utf-8?B?OVd4Nys5TmF3U0o0cUlBRGI1b3dkR0hlZjh4ZlV3MWpYVThEbnYxWTFTK094?=
 =?utf-8?B?dmNyZnpHKzdYTys2bVR5ckJkY2pJUUg4cTFGSGxScGhaeWI0aGVnOFFvc2My?=
 =?utf-8?B?YXN5Wi93Y3p2R0xPbUtBcFY5TzZxZVJIeG02WnFsVjJ3VGZyOWEwenh5ZFBx?=
 =?utf-8?B?eXpxdW5uS2prKzNwdE1iS1c4TkhwdkEycG4wemowUCtsU1lCNGxBa3hXVU94?=
 =?utf-8?B?Z3hjbUJSa2Z3QncxVGdrc3E2ck5DMG5uWERkZ2l5ODR1c0U0OHR6LzJLdUhI?=
 =?utf-8?B?bjVLR1JkVkk1Y2Vzc1A0SFpJWEtWOEJCQUJtd1cxRTBLODhGeVF2VGZKRWxO?=
 =?utf-8?B?UmdTV3k3QWRsMjd3eFdOYjRvLzlnNXZiQ1BUd1ZlVHJEZ1dXbFVjSnFvZlpK?=
 =?utf-8?B?cXBGR2F5Tm15bEkzb01DVzVtdXpWSjZmVGNUVjFKU2J0UjlDSDgzRnVTdFVJ?=
 =?utf-8?B?eHZ1NDJTQU1qbnQ5SWl4TktpOHhpTVN3MjVHTjN1NkNuN3FCbFNCUS91ajNE?=
 =?utf-8?B?RzBmb0c4dTZhdmhoNEZJdFlvTGZ2VGZlcW0vdXlpNUdxQStRN3g1WWwyMzFT?=
 =?utf-8?B?eGhiRzNqWW5PNmFwV3pMMm1PV0pid2NwN2hxUmFOclppQTRBdHpTdHZpamQy?=
 =?utf-8?B?ZWFZZTdxZjRGSUQ2V3BmeGVORzBUcGcyS3ZBYzBrWENiQXRWbTJKZE5vTTNj?=
 =?utf-8?B?d0dTcFF6RVlIQVRMMGhacGJXU2tKeXUwUlBMQTgrWVhlbnQ5RWdEQmRyeDV0?=
 =?utf-8?B?b0xFRjJuazVzbmRRKy9ZNnpGa0lKdTRxODd3NGxMSmJTWW1FYTVCbk5pKzJk?=
 =?utf-8?B?TzZFWXYwaTNmQlQ5WTR1RXlDeDBTMG0vUnprZVhueW5Gb2FmUHdvTmIrUEQ5?=
 =?utf-8?B?WjNlblJkcG9QSWVBaHZ4eGRBVFlIcmJ6aTl2MXZGaFJHU1g4RFhUK3dyTmhQ?=
 =?utf-8?B?RHBpVTNjZCs1eFdlcnZvS1NJNmN5TnZ1YjBtTm8zaHUyeXc4eWx3Yzl6WllN?=
 =?utf-8?B?TmsxZjF1ckgzK2oybEhYWFg2L0FuenNnUkZkNVBVZVc2SU9SNWtTY2U3dDQx?=
 =?utf-8?B?MktCT2RGalduVjgvck1QMnkrUkh6M1VwVS9ER3BHN1N5Uk42UytlV2FwY3E3?=
 =?utf-8?B?Z2VCT1dxWng3RFM0clNxRzZ4UVJBaFNKa2ZXSnlJd1VWcnFOZ2ptVXg4bFYx?=
 =?utf-8?B?M0VnZmtWVEVWYWFDL2NTRUdkaGIrV1B2bFkyT3Mxb0JhWUozL1dQRjg4anBL?=
 =?utf-8?B?NHJTenJNN3FDb3FSamlKbXU2TjFHUDA0QkRaUTdDcTBhWU4zc2g4SVcvc3N6?=
 =?utf-8?B?QVdoN0o0Q0p2a0ZRMVNxYTF2ZlpnRHRHSm9sZG10T3cwbmFTeWhkbGlUNHBp?=
 =?utf-8?B?WGppNzk0UWtjWUt2eTRoWW5rZjgxRVd2dkhvVWI5WVkxMjhTeHAzMzN2TkpQ?=
 =?utf-8?B?b0I3b1lQbERGMkU5YTFPa0dPMGxjbVB6Mm41YXhvMGF1N3d6YkZyS3Q5bk5F?=
 =?utf-8?B?SlpTMEU0Zy9iWTJVdnlycnlCeFF3QnM4d1BMeVU0a0h4MFd4UzkyZDV4SHJo?=
 =?utf-8?B?TWhOZlhhYy83aFAzcEZQdXZvVVI1YXhKMy9CaEtxRWdCcEhqbElkRVVpMURH?=
 =?utf-8?B?b01Ed01weXdONmk1SkNBUTIxYzc0b0JzeFFPQTdoVzVGdEdFaHdVZz09?=
X-Exchange-RoutingPolicyChecked: Ur10joVxROw0Sh9yW/F7YbSY1gBKqrN5xJHApUgi41AZxHD/uaxehy2oN67/9scsMT1hYyIZtx7qzfr018j3sdVaD/XCRSzAGW8MRrkFrxVTKQNRtOfDW/lhT5SHEr951xBXEk7x6y3zeyyQpzFP2UMFvzbxcGrm7Or7Qu5wk0DjY8OglttzDU2p0kLYBup+Xjw69AH3MrEwkEDiW5Wev3mnAKtXtG1WRdrUwLZEvXL82J8J2aNH+lWRQfDef1fUjcbF4fbpKOMOEd9NjwHdaM+b9l2tGMGhCAXO/QkhzxyhvzWnehR6b+uItALIvepL3WTLfwRXQ4cT9qFBA1flUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4887ce9e-0f03-4e7f-2645-08dec176ab5a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:47:36.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7RBzhoDKaK3/rth2Qv11tSQOsGrWBgkfI2xPBV6z2RAZ16nbAfGC1b5dTcjIO/+b10WwtvByt91CHxP/4fD+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7208
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 05:36:41PM +0530, Sanjay Yadav wrote:
> drm_sched_tdr_queue_imm() sets sched->timeout to 0 and never restores
> it. This breaks all future TDR timers — jobs get timed out instantly
> before they even start running on hardware.
> 
> Use mod_delayed_work() directly to fire the TDR worker immediately
> without modifying the timeout field. This preserves the original
> timeout value for subsequent job submissions.
> 
> Fixes: 8ec5a4e5ce97 ("drm/xe: Resume TDR after GT reset")
> Cc: <stable@vger.kernel.org> # v6.13+
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4.6
> Suggested-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 818d3d4434b5..be144e244745 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -212,8 +212,8 @@ static void drm_sched_start_timeout_unlocked(struct drm_gpu_scheduler *sched)
>  void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched)
>  {
>  	spin_lock(&sched->job_list_lock);
> -	sched->timeout = 0;
> -	drm_sched_start_timeout(sched);
> +	if (!list_empty(&sched->pending_list))
> +		mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);

No, please. If there's something wrong with the timeout clear we need
to get that fixed at the drm layer instead of doing our own.

>  	spin_unlock(&sched->job_list_lock);
>  }
>  EXPORT_SYMBOL(drm_sched_tdr_queue_imm);
> -- 
> 2.52.0
> 
