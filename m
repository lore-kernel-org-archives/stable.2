Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC533B6ED
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010014; cv=fail; b=rHiI1BKhK6/LtxtOsD8/WSInzkQNRt0r84+ENwrgi5EzjTV/Tq3hUBmnW4Iv2gA4EbKY6jwgBbiKNib+qZadFTHWtnBe8AKJBr5lYAbHsaXe3vve2sq/6YSB0S48CDHiyZsDy/zDFAJ5EkY4vXKvAk56DGoTu1hjkYVjaqZr1HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010014; c=relaxed/simple;
	bh=cn79V9Pvi9dxTyedqfKs7Rjd45RkHHiOSw0Utehw5HI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cFV4yZANtVMRSW8V137N2/ul5GVHbEzsvqkuLqTGXQkhxcMn1AoIbV4GS6vHFlABHyGs9CGRBLa77aMYYTIs0YtVPl68JXPpeQc/tVDVdyfE8abrsrCDwPJsmReFYfYxNmL2958kjjyCGHtktZcge5bY/saSx0wNlox/A2plZ/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz3/AOo/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz3/AOo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784010012; x=1815546012;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cn79V9Pvi9dxTyedqfKs7Rjd45RkHHiOSw0Utehw5HI=;
  b=mz3/AOo/cIVdux4z9RZREUvYF0T0WDlNCxyKKWt4nkPWPmeIaUJvzVKJ
   9Zb1yShGEqWZXr3FCO/k3xShVarMv2xMVru5Ly4JU1XPrMRmFxdTYk1Dw
   qOcRg4AXQ3bbIDLRnBc90pTo8eGNFbvQVURlnR3Laam80LdOXArBlD8xq
   2gSKvpKLoI1UsxODGMwFWcrd7vLJszma4yso+F8l1dcqIwCV4AP3kThCv
   jqwrNtQriX04zFBsh7tYFhvmRyPbmnl/bcW5JOOJKFPrsFufwXupDOgwf
   Hakc/9vlE7Mf9ftCCsf1QFIQTlqlzqe5mM+TYfxkzCCRH4qZmfzODi29R
   g==;
X-CSE-ConnectionGUID: qSD2oKuATbGD+Hq6xt8J/w==
X-CSE-MsgGUID: 6M1uHVndSNW8xFYSOzKlxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="107417929"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="107417929"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:20:12 -0700
X-CSE-ConnectionGUID: nMsULieCQLuqjndSQEijcQ==
X-CSE-MsgGUID: R6qmYQeZTf6brHVCVuCzlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="293952551"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:20:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:20:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 23:20:11 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKpebKRNsewISQTDh/g2rJRLutIAVn6iNHrqBuyuKdC+afGcirpRZhwYblIL21yQMaMHVkq/kqRY8OsMPi79aQJ+lmhoSYqTvginqC5ay64RtqfqbRaUD2QGEvK+doUd9l2XiPPgjHw/Z4nY4xWtz00cxgTN2qohmn8A6eW5HZ8Imx9Ud8vXuoQJbDOXQTpcp5rbIH6Ey7bwCk57gJxFeOLrrUw3JSuC6Eyl3rc2fee+ttcgj1dVoZKFsIPIMmJkRVZ1vEE7DZZasD/vsZOQ9RAL2tHGO+AzxqgPY23Al3u7Oinr7ydBrwcCxjddOrzX4OgNUlzKUMEofCOfeeBUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMKxuJPIqioqid4hT9b23ZtO5XcRnWcdvOzU5397E5c=;
 b=HpRmF6U0z/32ZWd0ZIyl8jhWhcrSIiopcD0Cf+h4tM8OqVZM8Nm+GS0QWK8GS7AmlZ1qYPqzTZWgptCxW0z1WnLIN4s8J6olaBXrXGIkmuxP/Jj/QK+wowEpxCVsCWvP0BRKGuzZ9Be9XVWYyyLcIOFD7pu/vaRVc9uM6HidcL6BozRIKwmBS2SbJZysLcast8rwpkzsKsnGdFOTCTQDpb4V7CZAJnZTR9lLdiynmZYR0gd+jCev8jCegNHH7uSI9yjQPJSeOWCSSfwZU1k3evlQghd10bc16kjRbspA7OwfwYeOtyyt0fcU8aX+JJAQhvPBPKKHckARFcGTvLeBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:20:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 06:20:03 +0000
Date: Mon, 13 Jul 2026 23:20:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
CC: Shuicheng Lin <shuicheng.lin@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/vm: Reject invalid prefetch region for non-SVM VMA
Message-ID: <alXVEIHZLiopsPTt@gsse-cloud1.jf.intel.com>
References: <20260710021700.3611909-1-shuicheng.lin@intel.com>
 <alVSDlVhQBy59KlF@gsse-cloud1.jf.intel.com>
 <f6a7473e-66fa-4151-ba46-3e51d2009582@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6a7473e-66fa-4151-ba46-3e51d2009582@intel.com>
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 609988fb-b3cf-415d-2fb5-08dee16ff0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: x2aDEZjX2UXimrc9ws9MvQwze7On1iCvl+44xRr1RjnrZXntwyjFdv/ljrPVAbxt+wTebl6WhztQRw3aTVzNq9noQ9N2eK/ZELKI6wWMRZFmMS5fhxREAD1gULtIjqjvGO60r5pRzzp3NX9OrlIiUrnVQgPusUStQxGrffFIbGydUNZoSPXccSH/WybAzmqjXfcvxq3QBirFrMBmhaiiossuDpdOaRUroTIckTPCuQfR0O1YjqckiayzZ2H6xS2XvBF4o+Ux1kLocgKEeocRoaWsB5gLc4I5ODMxHRqYx4RUbFhElw+k2oabVBzCuDTtKPmQj+1u54y/jTbaMi0sdaocgdvu6CXCuoxLl7vaS/fLFZNhFXVtrpnWIKlqtR5b4DDID8uCnTl7P02g/1jMbz3oy8Esa55/pZs+eNzgBelYTo84vj5/+o+nrHFHzjV10zSG0Q3Bd3xxHKRUC0eVK9ij5fWNZu9K/U5QeawuciyWrfdw7f5A3wwvA8L1Xga8eEUiBDBF2eYBe5zKPJPLINyLkHb8vnvs00zYUveoJiXjkBVs/ePcpsexOZ2tpvXQVFTY6w1JgpFhZ9VXdrVvmh8tNn3b5mU+DYvUxzIRbPhO+Wqh0GlipF9q8DX84U3n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTBkZXdsUnFoOFNleHR4TWl0TFBoL2t5bEl3TmNmYjB0ZCtQdTNzcnFIYWxj?=
 =?utf-8?B?aHNZUkQ3TGhCYXZJUmIvdkJqSzdaN0tGK3V5NHdXNU9XemFiZitKMmpYeGxw?=
 =?utf-8?B?RHZDWFFRUGZISUpnQ2NMY1pnSmk2Sjl5T3llTGxRRWtqRXp6bi9qNnB1aDE2?=
 =?utf-8?B?eExXMG5mazFZSEN3UUV4b1VmT2dwOW83NzBNdnNDUkF5K0hWeFNoZkk2NERu?=
 =?utf-8?B?eGw0N29UYUNDcTBPZ0p6dzE2UnErODhaci80RExhYitPZTV1eGNUSmdxMlYw?=
 =?utf-8?B?amNhd0ZNK2NteWJINkRDeVdLL245cWE4SERpeFd2TDhvdlJEd1gvZ0pzNjJB?=
 =?utf-8?B?TURHMkhmTFNNOGo5aEZkdHAzTEsxZUE1dVcxSk9ZSEZIUDY3ZHF5bGRHbDZI?=
 =?utf-8?B?YU1aQmJOS0phdmJBQnZxK2JKSm4rblZaMVlhVkRQbFZLV3dOYjN3dnkzMEJZ?=
 =?utf-8?B?akcvQ2puWS94U1dJU2phSTl4dVZ3NzViQ2xrUDlWc2lvOUgyK0doZnRweW1E?=
 =?utf-8?B?T3NJb3M1NzhSRUNna0Y2T2xDT2VpUEpEUnlLWW0vWDd1ZzhYaUlUR3Q5UXEv?=
 =?utf-8?B?Y1piY1p0Szg4dysrTDQwT2VLM2kyK3JyMy9RQldyVjE1aXJuaHpCOUUzWFJv?=
 =?utf-8?B?SE1RQ2NpdzhBWTM1VnB0YVhRcDc5Q0h6UllERzQwbzZPMEF0Z3BtMC80YTBV?=
 =?utf-8?B?blBQeVhNY0Y3UlVIRHEvS1BaU0ZyMWw1azMvTUg4WGhuRTBRYWw5dDVqeG5r?=
 =?utf-8?B?ZlRrcDRqNURBQ1lhZEpBSkN2WFgvdUFZaEhLZHlSMmFXNFZtcVBFSVdYSnR0?=
 =?utf-8?B?bUpXa25wNmFUNUd5RGM3OWs0WHRrQ0ZOL2U4OGd1bmhsZmRaeU1wOHlJZXFX?=
 =?utf-8?B?U1dHRUtTdEI4K3RaVi91aGJPUVE0aFJDeXhuM1pGR0tRbVZjL2VBVW9jOUJi?=
 =?utf-8?B?dytwSmNNekVyUzhVb1dwc3paKzZoVFJjV21Ed3RpYnJWZ0ZqTTlDMjFaYjJt?=
 =?utf-8?B?b3ROSXVmSFdyMUpMVERwalhTMEcxbXBTcUkxYUZtNXJFY1lJeFp1bVVzVUhk?=
 =?utf-8?B?UTEva29BbHU4ZmN3MlV1cnJndnBhR1M5bEg1QWUrSFM2VUMxOWdaWEhaamNm?=
 =?utf-8?B?SWZtbEdraFlGLzd1QzVzbVY0TGorNi9UUGN2OU1DenVCVUdIZHB5QW1yeGFY?=
 =?utf-8?B?Uk9pbEJnbWsvbG5VRjd3bC9Fdm03cFhwZGNVZnM0QmV4SkRYWWtzTHZtTm5J?=
 =?utf-8?B?U0hlTStTOFRYeCs3VnB0S3ZPZmtwUWJQNHg5bEtnYnc5TkdIVmJRTFFsY3ls?=
 =?utf-8?B?aHpkRmlZRXJZbUVyRmpva0xnazE3R2lLNlJnWVJEUVdZY2kwTnZwcENOai9z?=
 =?utf-8?B?dFZLQmUyUDVjdzRZTHBibDFuK3BUTi8xUlZPSHhFNjdwaWFHSUNPSjJzRVY2?=
 =?utf-8?B?bnNUZENJSHlKRVJhNmJQTXRybVJSMnNwUnVFWm4yK3daL2dob25TazBvRlg0?=
 =?utf-8?B?YmtqbWtxVUFtaytKeStMT1BaWXF6clk4R1psUXBCbkhsc2w3Z0hGMVYxMndO?=
 =?utf-8?B?UnA1aExWTi82TS9WMnNqci9sYyt5NmxGQngyZ010b0EyOWRZZjVNUGdmSnJP?=
 =?utf-8?B?TWVXelV1NFNhQ3NIbDI0OWFtSkl4eFFFbVJWK1FTZ2hLYUh1Z2lYNjVpbjll?=
 =?utf-8?B?WW42b3laOWlIUURqRERBSm9wcWZmaWNMc2VHTUYwamdIMUVESWVzSEpDVkty?=
 =?utf-8?B?MWxHalJvRkk0bEJYNnBYY3dPMDZCbmE2SzYwL0sxbFJUdDlHZURZejMzRld0?=
 =?utf-8?B?NUhIdzRuaEdza3BqUzdkeG9nanhtcGVGUkZvTnJHYXZhZmliRG40eHkyRzF5?=
 =?utf-8?B?dG81NEsyQm16VUJrOUtUY3ZubWJMOGZoVjFpYjVjdUhpakFIV0xNdmpXRlV6?=
 =?utf-8?B?bm95NzVQb3AzK2NTbDdIUUs0d256VnVnWlFta21MUXZuUUNjNEJSSDllVGJ3?=
 =?utf-8?B?YlBidkl6YTJTOG85YUdaVDgzQndvcnZjUjUzOThEKzFEMjk4WWdiN01pckNV?=
 =?utf-8?B?UDhQRGx4TWxSVTlUQklENURudnBhNDhDUktPN3grRjFORkV1OEc5YS94eTFG?=
 =?utf-8?B?T1k1dnRpMHVYclZIMWlxb1NVRElFVFIxZGw2bVc0T21ENXJ4ems5bStGWmdQ?=
 =?utf-8?B?STAwMW9DTC9oWHNrSW9EbkZMdDJhK3BBU1hyMGF2ejRSN0xBL0ZLTVdrMW5x?=
 =?utf-8?B?dExDTjhNMzY0WTRJL1R0bVFaTkZEb0c0ajB3UVZwWi9BZCt4QlZNU2tEdTBo?=
 =?utf-8?B?RnUyZDNVbVRaT0swekQwT1hNaTFXRFdLSm1MQkg1T2I5TkRReVlsQ0dCODBU?=
 =?utf-8?Q?YEikdaUgz2WtrA54=3D?=
X-Exchange-RoutingPolicyChecked: FjqlLf6BovhUERGMB1d5BHyt2OFF0hPv7GlcVwj/vaTqev3Kx2QGjOcCcxI2BbzKqepyjcgnnxU3oAJY/VgPAoI0+nB5HcVE3M7RPUW96bWM1v+O1ULSh9VRnD7u4pIn6d4A9sThWrcs3AY0dGnYvWQ4MNX9+w6jmPNgZ11/Y8FV8loG2Ngouew9KLUOGKPsJGI9AeQ2Xbkejg3ScSSfcrrTn4dMRZ8WiJlI0Gdy1C+xtF4l83uL/cEoO4DRsyHUaLyQLBiNx34kEvjNHzKr2xYETZ8shD4EGBvT8X8H4+gklNgkD0tH5XpnsFkDCoITA133k/Lxc8RItCv+ntIMgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 609988fb-b3cf-415d-2fb5-08dee16ff0b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:20:03.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdTjZjhor0dLLirc2kUF5uOYsnZH20Bn3gpTUhDdCfLx/dKujzUc8g97DF8QIvhaCp+toqXWilA16WV/mCTOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com

On Tue, Jul 14, 2026 at 09:02:52AM +0530, Ghimiray, Himal Prasad wrote:
> 
> 
> On 14-07-2026 02:31, Matthew Brost wrote:
> > On Fri, Jul 10, 2026 at 02:17:00AM +0000, Shuicheng Lin wrote:
> > > DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC (-1) is only valid on a
> > > CPU-address-mirror (SVM) VMA. On a regular VMA the value is used as
> > > an index into region_to_mem_type[], causing an out-of-bounds access:
> > > 
> > >    UBSAN: array-index-out-of-bounds in drivers/gpu/drm/xe/xe_vm.c:3260:28
> > >    index 4294967295 is out of range for type 'u32 [3]'
> > >    Call Trace:
> > >     __ubsan_handle_out_of_bounds+0xa7/0xf0
> > >     vm_bind_ioctl_ops_execute+0x9b0/0x9d0 [xe]
> > >     xe_vm_bind_ioctl+0x19f1/0x1b10 [xe]
> > > 
> > > Three related changes:
> > > 
> > > - vm_bind_ioctl_ops_create(): For a non-CPU-address-mirror VMA, reject
> > >    both DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC and out-of-range prefetch
> > >    regions with -EINVAL. This is the primary fix for the OOB.
> > > 
> > > - op_lock_and_prep(): Tighten the xe_assert() to
> > >    'region < ARRAY_SIZE(region_to_mem_type)'. The
> > >    DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC exemption is no longer needed
> > >    since the value is rejected earlier, and '<=' was an off-by-one
> > >    bound (valid indices are 0..ARRAY_SIZE-1).
> > > 
> > > - xe_drm.h: Document the CPU-address-mirror constraint on the
> > >    DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC UAPI value.
> > > 
> > > Fixes: c1bb69a2e8e2 ("drm/xe/svm: Consult madvise preferred location in prefetch")
> > > Assisted-by: Claude:claude-opus-4.7
> > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > 
> > I think Himal at least fixed the memory safety problem later in the
> > pipeline here [1]. I'm unsure if he merged that one yet, but I'm
> > inclined to say this is a better solution.
> > 
> > What do you think Himal?
> 
> Hi Matt,
> 
> IMO -EINVAL isn't the right behaviour here. Rejecting fails the whole ioctl
> and prefetches nothing — including the SVM VMAs in the range that were
> always valid.
> 
> AFAIU prefetching a range that covers mixed VMAs is a perfectly valid use
> case. Today:
> 
> region 0 (system) works
> region 1 (devmem) works
> for -1 (CONSULT_MEM_ADVISE_PREF_LOC) we should prefetch each SVM VMA to its
> preferred location, and for a BO VMA try its preferred location (which is
> effectively always local devmem); if the BO has no VRAM placement, fall back
> to PL_TT — but no ioctl failure.
> 
> If we do decide -EINVAL is the right way, then we'd effectively be telling
> UMD that range-based prefetch only works with system/devmem, and that a
> CONSULT_MEM_ADVISE_PREF_LOC prefetch range must not contain any BO VMAs.
> That's a much more awkward contract to put on UMD, since a range can span
> both VMA types, so I'm not aligned with the EINVAL approach.
> 

Thanks for input here, I'm going to have to agree with Himal's line of
thinking here.

> Patch [1] is not merged yet, once you confirm will go ahead with it.
>

Go ahead merge.

Matt

> BR
> Himal
> 
> 
> > 
> > Matt
> > 
> > [1] https://patchwork.freedesktop.org/series/168913/
> > 
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_vm.c | 12 ++++++++++--
> > >   include/uapi/drm/xe_drm.h  |  4 +++-
> > >   2 files changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > index 080c2fff0e95..9430b2be18e4 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -2495,6 +2495,15 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
> > >   			u32 i;
> > >   			if (!xe_vma_is_cpu_addr_mirror(vma)) {
> > > +				if (XE_IOCTL_DBG(vm->xe,
> > > +						 prefetch_region ==
> > > +						 DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC) ||
> > > +				    XE_IOCTL_DBG(vm->xe,
> > > +						 prefetch_region >=
> > > +						 ARRAY_SIZE(region_to_mem_type))) {
> > > +					err = -EINVAL;
> > > +					goto unwind_prefetch_ops;
> > > +				}
> > >   				op->prefetch.region = prefetch_region;
> > >   				break;
> > >   			}
> > > @@ -3236,8 +3245,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
> > >   		if (!xe_vma_is_cpu_addr_mirror(vma)) {
> > >   			region = op->prefetch.region;
> > > -			xe_assert(vm->xe, region == DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC ||
> > > -				  region <= ARRAY_SIZE(region_to_mem_type));
> > > +			xe_assert(vm->xe, region < ARRAY_SIZE(region_to_mem_type));
> > >   		}
> > >   		/*
> > > diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> > > index 509202a7b13e..e159c44e380a 100644
> > > --- a/include/uapi/drm/xe_drm.h
> > > +++ b/include/uapi/drm/xe_drm.h
> > > @@ -1075,7 +1075,9 @@ struct drm_xe_vm_destroy {
> > >    *
> > >    * The @prefetch_mem_region_instance for %DRM_XE_VM_BIND_OP_PREFETCH can also be:
> > >    *  - %DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC, which ensures prefetching occurs in
> > > - *    the memory region advised by madvise.
> > > + *    the memory region advised by madvise. Only valid when the target VMA
> > > + *    was created with %DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR; rejected with
> > > + *    -EINVAL otherwise.
> > >    */
> > >   struct drm_xe_vm_bind_op {
> > >   	/** @extensions: Pointer to the first extension struct, if any */
> > > -- 
> > > 2.43.0
> > > 
> 
