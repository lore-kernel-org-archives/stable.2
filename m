Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46D351C1C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118632; cv=fail; b=L2yiE7izVoZWs1OqxRs7F5CFfkDh7RT0kRg92expp94SgQ1wcgyxi9u0qO+FPCE0JY/W9xwht123sHecYkPjXaQX50zvPzBTno7UOsFy87X+pd+glLBE+zLhfsDS9kbs7AVdkEt0wzEOMdCmV8A7X8Gk8vdQNh23D/dVVvmz1wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118632; c=relaxed/simple;
	bh=DWE0TVsrrZQQy9sIrVKBpfkg4iOi1d8z0s7OLkBl1Yo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FuMpcu0tXYDO1myKPwVAT+r7Ks8iPY0mvIvBGd5Yn6L2473hkzLiVQS9zDdepSf0z7WrWhL4nXPvxOnHr2bTBvhcW7QTsuQzArQemJejafVmyCJYySQsNxin1nJyDY4AAvTJr06+K5jzbUdf1CFZyZA1d7+h8lfgSKt44GbJYmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0sSs7LG; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0sSs7LG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789118630; x=1820654630;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DWE0TVsrrZQQy9sIrVKBpfkg4iOi1d8z0s7OLkBl1Yo=;
  b=h0sSs7LGnX5jejtVjv44nKbW+dhedyOsy0lGcO3HlLZm9iOuGVERd0BC
   OxXQpat0VpzCWE663OJHB6GBN8BODQowfKJN++2V1XGZNN3O91WF4R7Cr
   5RUPoVDHHLI3I8QbvFk8ErlwIUnUoz4IkKHNg0pdRxU0nS6K/2YPGv5Bj
   CpLnQ94eD3dL2HJUQRs/3wmj96MyK8lEv0kquFlTI4sUbCCv0QOJ9Zf3u
   t81miqwzqlHnmbCEVhbIsblhKwAbUUf21QshVe9s5weHECwqG2mnhvANk
   RM7KCSb176se2q5vF7aUEIzIpixqMqRIYVpVoETIKkgxlbgV56cBsORgj
   g==;
X-CSE-ConnectionGUID: ePeWrM9tQo6mqI2vRxd03A==
X-CSE-MsgGUID: VvC8PPt0S9aCsacy7/rwjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88722588"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="88722588"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:23:49 -0700
X-CSE-ConnectionGUID: QvkDeAuJQfqFxDGzpYC/DQ==
X-CSE-MsgGUID: O3b8lHEgRe2dV62hEVJ7rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="268187840"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:23:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:23:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:23:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3FZ6nFeNPTzifgKzeN4lsPvdc00tAoyG4TtyStS/N0i8229vfM+D5FCfPmYaNkvqYaGMHN2+b3GT+wU6VWDuqpTRS2LH52LpX4ltywdTDycq2wsrId02N7v93b1SUnm/f3RaCVpZw/TnGHctkwKORq4wiRSruouYdEjvg4qdLdsEG7ToPbL08Bnv5zABlzwrI8S6RJ3nX43GA8zXUV9aX3XSVW5dRsjukmPfXUy7eVq1ic5Fe5yp2PBGVfFq8qU+An+XhI0NzajweDm7YmEpV8gnu2IdJ7sbQdF4/lWx+/gH7q2gfb75U+2WIfduu87rnRdrCXHIwkopMsNT+aH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPw0CcIE5OyM6HMBjSjDs9nfO6Zvy9k4qypUwCQFcPw=;
 b=BnqhtLNq9M7oaxr0I0cguzUIjhpSSyfv4Rw7GXFCriN8hdeViq20Mjf82QPLj9kwpqci9x9QN27WAk2YhVxprsppcRbTKOh8gDORctcbCBLWxaN3EQsWAHVcPtvGHfoi3viGUfGkSue2PeW5SqgnFKy65TScqsfUEh5X/TneBr6M9zpat/Y1kHJFFPqWZ/jtE7p2RXbwzIKPV0lFYkO6u/Xnrsej+SK4emAmTssruw49PbDGKXENY0+3Z+rIjbskKlQhxXVi41OC4UKNvtL3upWDCVTyC9uh0Tb53KsE0I0shfGXmnfH9TDkpXZw8bD8UAoRiPq+FidiFN5y7IjS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:23:45 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:23:45 +0000
Date: Fri, 11 Sep 2026 02:23:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <phasta@kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <kernel-dev@igalia.com>,
	<Luke.Wildhardt@proton.me>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>, Vitaly Prosyak
	<vitaly.prosyak@amd.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/sched: Do not restore unsaved virtual runtime
Message-ID: <aqPIngEx8w1VgoAA@gsse-cloud1.jf.intel.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
 <35456574-5fc6-4270-85f9-940201998116@igalia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35456574-5fc6-4270-85f9-940201998116@igalia.com>
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH0PR11MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df8d971-36a7-42f6-23c4-08df0fe660b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X3pYNDHR85a+fdwYZvHZnkRePAgrea7yaxeesBzrrqb9Urulz3vG4f8EevZuinBcL9WJca6x+ntHsXaeqcjBDxjn4nMAp7pngbdejV2AmMfsONmaWK0Zk9ceOkJ2YrqyOzOYppy2aoe+/mlCj2p008J5kHjU4ueBGN6nAqQED2ygjTVUa2nV7sSpMW6DPmt0964+Z+CyGVPMo0W7gnCJ+3H4hpUM2qA8CIVj0Qw2SQMR8EkLn+LS4aVlb+m1CcIAvlzKiZDl21MyqNVUX32M8ZsvyLqiJUz35OS2k0lWmcIZtIjXuTBS42dlaStia8jBenSR4ERvqDi8D4BkhFWzo2lQ+W0XVXbGRGlKUo5Duw2oh94nOoQJyPhG5HkPIzIY/rWsy0UKY56itqJIwL/YGXlH5iDJbiiTqoJG9jOPKWKvzkkOlwMBOfcsEixnL2qJ916XuCKIFJ7uqWLOtEojEemsEfuWDPEmonmrDnVMrGLkRMM24hhxHwtFkqwn0Tq11snp+hDZRO4SqP4P2vEK3DJVuG9syUWjzo8FrEDlHYvbccAWKUAZKVMDnd06AP6giVY9u5swkzC8/Qf9NE5Xkurq5frImYpi6tzky2xxvoQdi9lRoFpQmn8fAtc3a2PV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW90R25lVW9vSWdIaUpkOHo2WFBRRTlHSHIzWEJzMFlpd0oydUpDbCsyaFoz?=
 =?utf-8?B?czNoalZZdUFiS3EwMC9FRndING14QkNZaWZYTytad0k5Sis3MXZZU0Uva2F3?=
 =?utf-8?B?YzJLTlR4ek5TOGlzVmNnVW41bDRuZzBaQXZESElpYkVDSUZ6OEUwR1NxbGRL?=
 =?utf-8?B?K01QMWZQcFBiUE9Od1F0UC9aUEYxZCtjQ09lWTVTdlJuQ2U2UlprM1E2SUtu?=
 =?utf-8?B?cXd4V25NT1QwZ3dHWWExNEZWaGFwcnJzWDhiV2V3OElKTlIxVWplT2t4L0Ny?=
 =?utf-8?B?M1AyQktqcFF5OS8yNWp2aDkyV240SkFKY0FnTjdOYmNFRWszWG5Pc3ZTVG1a?=
 =?utf-8?B?RVNlcXVVaG52YThTTEdHN1JlWWlmS2MvY1I4MmFLempYRENjallRUUZVMUtR?=
 =?utf-8?B?MkZsU0RrRVUySXYwSkhibFBpU0tjVmdtMU9tdlgvVzVWT0poa2s2Q0YzakJL?=
 =?utf-8?B?VEJ2L3lvbVpMc2VOaXJqUXhZazhpakpEblhJYU5ENEFKK1J4Skh6Rk9nU1pU?=
 =?utf-8?B?UnY4T1pRMUxra0xiekRFYWYvc1Z4Z3pUSGZibGhsZHFTVU1ZUmxBNHVpaVVk?=
 =?utf-8?B?dDAwb3ltblBhNzU3Ykk5UlJTTVVtdkNXbm9FTDR2aWd0OCs0dlF0T1A1VGJa?=
 =?utf-8?B?R2NNck03RE1zWkYwUUpsT1BsVHY0NU05b2VWckpleFY1TEpGOE5CV1R5MXAv?=
 =?utf-8?B?RW1RcEtONGZaM2toTlBvdk93TG5XN2FIVTNwa0JhQ0p2NjV5VnNuTmdNbXBW?=
 =?utf-8?B?VzdJSjgrejNiemEzKytFK3VKUFFrUXFvdUdINUtMYVhBWTQ3WDNZeVZaQU1p?=
 =?utf-8?B?WmczSlhrVHl3b0xMY1Iyb2ZIV1J3c25ZTDBaelIyUUNDc1ZCNkFNTlZxT1Rs?=
 =?utf-8?B?c01XbDJ3Z0VLTVdZOTFjTlcxVTA3VFNsMWR0d01NNHVJMkRXVnB2YTlhaFQ2?=
 =?utf-8?B?d09nc0RWS1ozZGdDbmZ0ZEsyL09SMzlMeW50MEZmNjAzQnhqL2RmMi8yMnZv?=
 =?utf-8?B?dmpaV2MxZDY1WVRGS3FDbVVhR25qMkJCUGpocnVKUWpUVGhQUDlzSUxmUCt5?=
 =?utf-8?B?d0FGYUEwdWd5YXRBY3RTc3dNdGtwd1VSMlE4azlVYnFsVk85LzNwSkxvTU1a?=
 =?utf-8?B?eE5rUkdISVFXRUZSL1NaSjNrbTRGNVM5TnJVY0RDT2hqalBrSnNEclRBdTBZ?=
 =?utf-8?B?cVNmL3R3MW9jL0hRdU5yUngrRGF4UnNMZ3A4SW5FQWRmMGtCNDVjaEM0RUZx?=
 =?utf-8?B?dU5tTTFwc3RML2h0S080NTFRcjFHYjdzd0tYVlpHYmNRTXpCUDVRNlcrVUJN?=
 =?utf-8?B?MFhYb3Q3T213TmNaWmJ2ZXp2azRkSE9TQ25OTEdBRGdGbnFJMDRtZ3pQV3dL?=
 =?utf-8?B?aVE3YTZhQkpwMzZGeUh5dS9ZV1V1UTFmTThRR3IrYy9PWXhzY3pvTWRXZDNi?=
 =?utf-8?B?czNxS2IxVzhYeDBzdFQwRFhiSEFORjdZODZ5SmhBSGh4MXVEQ0lBVnN6VFZN?=
 =?utf-8?B?dVJGNnVwQSsxWUc0N1lRVWszcHRwWlZ3RTlpOUZzM0tVTkJ2VkJsNHk5ZTFw?=
 =?utf-8?B?NFJtaTBSS0NpYWZLK2NpRDRzR3ZhUm5kdzRERUswZHNjZTZCK3ZZMzdmTWtH?=
 =?utf-8?B?bE8xcW5yWFdxREhPZU1KeW1OYlhqdEZhUmYvaWFVa2cyclMwdVc1Szg3Nzcr?=
 =?utf-8?B?Yi9zeUhUeDRyaUdCcTg0b0l1VU13TlMxQnZLeEsxeDFmYyt3b1d3cVpNVlFX?=
 =?utf-8?B?NzdjbEFnYXJ4UlpvK3JMWkEwQkIvRHFaaStYZlF1VmZuSzVaNytIdm52TGxB?=
 =?utf-8?B?SXdDMUVYUWRDcDhMNFZZay8wQUU3VVp6Tk0renZTMDNrUFQ0d3RyRk5BdjNa?=
 =?utf-8?B?S1RML3MvVnkyYlFveStSTGpydjJEeTZneWp1WHpTYmEvcVd2TjM5S0tYcmZ4?=
 =?utf-8?B?NHlCcjFMb3hPUVowVkovTUJpeGdWb1VJUi8yaW1mUGZoZUE1elpSYzNwN3FT?=
 =?utf-8?B?b093RWF0STJ1S2kwS2F2SlljQkhtUVdweVd3MXNQN1QvRXhKNlVWUi9uOXho?=
 =?utf-8?B?akJSbjZVUG85cllpY05QU2kvTHZNdGJjLzFUOUphUUg5aFd2MHlWTW8yRjRN?=
 =?utf-8?B?T0lRaXJ3aXFwVnZKRkZJT0JQbWR4SC83NlBiRHlvNVltWjhrSUlobzExSW53?=
 =?utf-8?B?VWtLVDMyN3cwS1J0cTVSaDNMQXhyc2NKbnA3U0FlcUZNREY0NER3b2ExM0pt?=
 =?utf-8?B?RGlNTlplbktkNGlXYnNYVEJxZzFVMnI4ckQ2SUM4NHluVndRMFR6a254b2lo?=
 =?utf-8?B?Y1pHcEVPQlFsT01PYmRXYjFFb1pVTWNhNWMybkZ5bXd4UVllZVhqUT09?=
X-Exchange-RoutingPolicyChecked: XVxoHyuZAjWprWOaZQs7EUmRpVb3NMa9P6XrBDgM9HkcmLF0VDyRTNDj/k0Uh9lvcBNcRETOLj1wOd04YI58G9VRRCkH/kpTb8V4WzNrKO5iAMKAsltjWK0YnrBfFb5fysdvfrogutjr6yYnbJMhQCu1eYAwo8uCWSqvjJxzoO4/yp7jdsuE9kvxsb7EQyM0RneWXgcLrd6H43KB/MMVzlBgdTyf4bNwDxZUpa4fC2mvc40dZUfZAfr/GtKRNcy38mKqRg7lsrq+S1vIfKarqcP3BqcxyIh1P72CrpqdeArmsN5aWYH1GeVuLb5+D9IK7DOgmN4EWojgmP2wOiypnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df8d971-36a7-42f6-23c4-08df0fe660b9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:23:45.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chtcxAHpb79mq7u041zB9rFFFrjDiw+p1gwvx7SUjFYc9s+MzWpqhgRaIOUTrR9UK/958mFPa7/So1etIuRInA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952
X-OriginatorOrg: intel.com

On Fri, Sep 11, 2026 at 10:18:29AM +0100, Tvrtko Ursulin wrote:
> 
> On 11/09/2026 09:56, Philipp Stanner wrote:
> > On Mon, 2026-09-07 at 14:05 +0100, Tvrtko Ursulin wrote:
> > > Prevent pushing a new job to an entity seeing it being the first in the
> > > queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
> > > side in drm_sched_entity_pop_job() has de-queued the job but not yet
> > > updated the saved virtual time.
> > 
> > I think I don't fully get the bug from that message. The bug (is it
> > even one?) you address is the performance bottleneck for CFS under high
> > load, right?
> 
> Not high load but a race condition between the save and restore of virtual
> time when entities enter/leave a run queue.
> 
> > Anyways, I think I got a better idea:
> > 
> > > 
> > > We do this by pulling the locked sections out to encompass both the queue
> > > push/pop and corresponding rbtree management.
> > 
> > So basically you move for locking the spsc-queue, the lockless queue
> > which is usually used with the locks next to it anyways. That's cool
> > stuff. I've suggested this for a while already
> > 
> > https://docs.kernel.org/gpu/todo.html#replace-the-lockless-queue-with-a-locked-list
> > 
> > So from a maintainability perspective, it would be far cooler if you go
> > down this road one step further and kill the spsc_queue for good,
> > replacing it with a fully locked list. AFAIR Christian and Danilo also
> > have agreed to this.
> 
> I am happy to work on that just that a) I thought some time back you said
> someone from RedHat will tackle it, and b) lets please not gate this bugfix
> on that.
> > 
> > […]
> > 
> > > @@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
> > >    */
> > >   void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
> > >   {
> > > +	struct drm_sched_rq *rq = entity->rq;
> > >   	struct drm_sched_job *next_job;
> > > -	struct drm_sched_rq *rq;
> > > +
> > > +	lockdep_assert_held(&entity->lock);
> > 
> > btw. I think it *reads* a bit safer if the rq initalization happens
> > below the lockdep assertion. Also might make the diff nicer.

No. This style is used throughout the kernel. Your suggestion makes the
code harder to read, and it scales poorly as the number of stack
variables increases.

> 
> It makes not practical difference but sure, I agree it reads better so I can
> respin once you clarify if you are blocking the bugfix until the spsc
> removal or what.

Yes. The lockdep invarient holds regardless.

Matt

> 
> Regards,
> 
> Tvrtko
