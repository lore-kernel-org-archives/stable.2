Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792636566;
	b=3JIv6NCZETWmkbx4jcGir9aYmRGBuc3suvim4riXU+LPsTg7DZP6xTIxUIU7cePpcG0p
	 X4XLDZc9pJ6Yen7SINnC58hwusOYamB/CJFPfrhqa9JYcrctQXFB1D44raqBBb3aNsyQS
	 kzYEDsoQHYQdaDF0QkAQhQjASM3/yfPw46oQ6fJzYSGlz3f6NgWUJMKc8Um4JTmh5pXWG
	 GFidmA6F17wExBcusaEPgij+DaKf2SpdC/aZ+ftDN68pVtrfn4V5ZGiSZ+3ZKPzNs7dSn
	 OFVC69VQjWKTeZfUcQrPZ8csDNVKFGnpSKSbXzoRJ9QEYDYi2hjzgTs45Is7JiAM+1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636566;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=nkc1d6gVtsY2d3OArXERpe48/W3VGbD8/xT3IIhHhPY=;
	b=Lwtn2v3tIowujjvcSk8TylxXiVP9Grud4EeEY6UVZCtcJRA+xQ9BZjbL/gS17LyoJ7ty
	 gb15aAb9RI4jUwcJ+Up8i6QPd9q/fi+sJ8izWR8oGNnkjqLda0tnmiTCNqI805QaOCxbR
	 VdbiTMr2ZTB798zaSNk2OBt228D2g1RWiYydlH3Is+IGPW53mpZ8KRS4mQqtCDMpQk0NU
	 +HKH/gHgDgjXddXbPY4pb7h1+fW4eqMUOxGQlCT1yX4HnEKsD6NBV3bKzWjCw08hcKC01
	 icryzCAlaPIaAC+c5UJ3k5nftgpxKKk5lk6Enw4YfNxtPY3/BDJQqZy6CTBFZTKCb1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WMeMRbO1;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144A606A319;
	Thu, 22 Oct 2026 02:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7144A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WMeMRbO1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792636566; x=1824172566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b4wkM8VetkPjPxLpdEFyxTszk3mU6ikiFOUret7BjJk=;
  b=WMeMRbO15jGAdGVhyzyXcj0fFQXqcH7Vvf6lZz5EjzS04+XkPWgYs9B1
   DUA/srjLYdTY+5RjS8LAtB6S/MzHOMUPKUcnempZWo3dYKUTWZVdRI8Me
   0oCAS8YGVh8jNWuS/Q+bawl6InCuGEJ16dTydbjyoYPqANqCES5VvJI6C
   yIHoXoS76eAmeWcKy8oRi+fIjDtAAoilHYINcV9lYo8kbNhZfYkhyaWrE
   JwtUa2Wmq7UXMgBKfI0oReLYQjLBxf1Z6qPFR+8oWJLm0AL0rVNctgSob
   kEyPz7Bc2/0p0C4xjqXpX+QjW7ibjyfTPMCfUvd4PUvlrvKUl8QPcHX9w
   Q==;
X-CSE-ConnectionGUID: unA0bWEFRAqIBjDJr+k6Pw==
X-CSE-MsgGUID: PhOLWsHXS3CNtlaM7AtKWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1386470"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1386470"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 19:36:06 -0700
X-CSE-ConnectionGUID: h8V/FhS4Rx+Bw8km+tee1A==
X-CSE-MsgGUID: IAY5sgbMTe+kK5iwke75+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3309115"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 19:36:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 19:36:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 19:36:04 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 19:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvdbi/ny+SO82f8WXfpahREPZ7MFO2N8e0H6KDBpB9AF00mVLgxRO05Sa1A4lNjQ9NJVuKR1w14TYEr5705lVweWAkZJHkbTOu4RTcFd5KvUWyVDcFpU5AUq6BPm1jtAvomdq4fHU/624k0FjEd1jJl/W9SAadAweX27QhdmDFPQQCvOCDuLBwA0IG9S/6UmFUUrvR8ODbbs0TCnPy4z1/aUXFluqZ6/41TRxLboX4HQ/T8D/z0cw82njv1vX8X+dSuOVUGhiogO4AmpVy5p4yUU+JZBlnhDasFB3B6As3ZNtkUOuc/RetKUbpaGo2nPEIkmjtjq+mG44oLGPL0iTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkc1d6gVtsY2d3OArXERpe48/W3VGbD8/xT3IIhHhPY=;
 b=phlGPPmMOGtjdBSZ7xMYorTN5Ux1RFKpg2lzT87xYpfK1atSMKov84prPlHwvEGPBAXaCVQkpkt4D1+lnDQ56KeAxU4RKHIJB0fciABEvX5kIedIiKLdHYGs1PVclzgHlU4sJ+pVWfPIRvr/Z4YZ7uML7aMAtqNAAvY0w7cdRvoHnvmgKLng8RRhi/k4uq+8U0elk4wRp+ZdDcAG5TMSk7usORLvSIYohzpMFNJHNirls6NGCkGnME7bX4hEl/Yeu6gWG7X9Ohc7+5M5GZ/LmbgPhhJ97RlBUY5dHmV78jg1AMD0xWoKcwMPRCEayAZeq282L87zAu4CdEy3UHx3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:35:57 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 02:35:57 +0000
Date: Wed, 21 Oct 2026 19:35:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <karim.sabar@utexas.edu>
CC: <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Use kvmalloc for the VMA ops page-table update
 array
Message-ID: <atl2i1vJoU2QwCbG@gsse-cloud1.jf.intel.com>
References: <atkLLH47Zd6vMX3B@gsse-cloud1.jf.intel.com>
 <6ad974ba.a8122b97.39a7e6.f867@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ad974ba.a8122b97.39a7e6.f867@mx.google.com>
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: d139dce1-838d-420b-bb41-08df2fe53383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|10067099003|22082099003|261021123027099003|4143699003|261009223027099003|5023799004|11063799006|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: gsaQBfxm4K0hAmneO+33OD5z3jMFD0ouwOieHhjJ/zdj+T0D3/rYxRBYKjmDcz2U1BSGsXanoR51z7ofm1rBwFwyeu0TcSM1qiAAPWkh9wy1TdztsCdbzCGZHV/cC+tbt2PPWc5XywooHd141hxoWN8lJIfbSRxKmLMx7vye2X3pwBAUftcNpacuiFQ9fX7dM4x/xBP3D2iW1yGkCBMYol0OAua3EZijOOVQzeQitrQBkoWTe7TNSwW4liAFcIuCSKhRYpD46iYTCmTRSJQiPkYwf/cOZCsTgM8LDtuTdH6ZKJDDIoGOke4s4D7gVQUWhp0tAa05wkW6vOZkpNujvnogAMygp8lEgnAij8+ecqX9pxLrw31bYYlxMbWpnwpWt2J220GF6j2ex4gf3JLS+YwFOVRxltsVLysAg35yYGsCu2qAzO0j+ovlEEywjSnZm+GInMmYPfaFrMX5lh2yhHzJCelP2woT/iwufHGRSpH2v7r1maqN/6n1gavjD2fOR4SaAUwVX8LLisHkBEPdyJcO2lgEU8/03ra416fK+gDFB+Q/bsOz2h0hcKqiaCPSe6Z9NsbiMqiM4oqVTBKCkx01H2edlqhFOHcqQgt2UTiBHQTS3YIrSsHxx8a+TUV7UG5XBbVQixNSKvu380IP6N8EJjuuST+T5u3GEbPhXXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(22082099003)(261021123027099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zLNG0gI1XTmVC/4Won2ook9YLZRPTXVq6jrWVJOaMoicIWGvfgMNOML8uY+e?=
 =?us-ascii?Q?ufXSVk9xHqV+SGnIt4A/9Po1aFu8vs8iuTxCI+bhvE+aDaLx12hZZjsvPaSL?=
 =?us-ascii?Q?WyQi6pfJLGtl3sG4qVbledT9wTM7hD0OvX6ttI3Cin2CfPFisWnHpTxRWv+p?=
 =?us-ascii?Q?5cpJxRkUXGgvfT6Ao4XkpFaMZ3E4Vo6qaNCK3HMjx4WbOEjreIPmpDZa05WH?=
 =?us-ascii?Q?a+XFI8nxAnUrtXzFF8ScHuweBQ1afS75e2axrEwuNdaRMbTOfH1Il1216ZDy?=
 =?us-ascii?Q?fM7pradrSzjFhbyJZvfwcrtlse8m1b0+bOsbPfaOPqYxUwwU1ilNh11ATCvD?=
 =?us-ascii?Q?GZV3+Dp6hdOCTEsxyNOs4m6WcyyFPZ1w8UdN+W9AykaQsy5g7+ae5zBaQHqF?=
 =?us-ascii?Q?7T+13VNkeIAhygZGBzHqLLwWYuBK5xvGjmzHFi1WCvq9An8puJESFN4ZPlHP?=
 =?us-ascii?Q?EhazXlfayjw99/r6OoUnI6Fk3lW3IwQosWpTv3aiwQlfi82xMmeWWqmi+Gug?=
 =?us-ascii?Q?O8cSYlRS1edzh6cLJPJF+Yei1IU/smTZSB0pqjFJqoPmbcLfE/h1bk50X8Be?=
 =?us-ascii?Q?AP2h8OP9U6pGv5As7LXb9dPYZmcdDWyE0uGrc6YD6qnKxVKZMGBDxVp8XC3h?=
 =?us-ascii?Q?BhmrRX3NQkTiLljlpzcJ2W73pTiw0TCo5f8bYaz5/cB5VVAFuNUIPlB0hSQQ?=
 =?us-ascii?Q?aN2dFtC3loIngtGj1bOWt8rdKLiqNKolcrfs4yA0STJJRIxLN4YQo2bZ4vAx?=
 =?us-ascii?Q?d2NqA/Zx33Vl1rYNMTp1zl1NzFDExfc+AmSByKBjBeqg5lgrAdE93Xmo7yer?=
 =?us-ascii?Q?/HIMxO0Z6YsFw7FVFubXPskPwrKFCbIlLfoa+oVI3TB5vPC4l/7Pc2xzjIoo?=
 =?us-ascii?Q?EQW1u8u5yNzGYkAl1JxsMrkhjIdbQzmF1NIsi9jQE97wN3hrI/BEnYF8CN9g?=
 =?us-ascii?Q?XBq6eikJKCkMD0k5D8bBUcYxtW8cchgLX26aB1I4CsE1IXIwaBtC/gjAopma?=
 =?us-ascii?Q?7MySpnZFf7hMdBzn+kV+jc3cFNVAmm9RyT7jf5u0IHcyGzLU9nC4jHkaTshk?=
 =?us-ascii?Q?hFnoFADEC/SfO67wnToPlCt3qEfzRwYG4Srv3c1ktdqDIcqID4ww/HOwcSky?=
 =?us-ascii?Q?sqJkSK4z4/Y2THizLHfnZtRcj8TOglzszzLNsPBCVqOu0VP9Ur397Z6WaklH?=
 =?us-ascii?Q?nyWur6uTOk1IFl7IZyuIdwxFOkNJwW6Azl14Uip+DYsFWhw16izkdCLQRBrl?=
 =?us-ascii?Q?zIeDjC4ogjgDsWOevGzIxq20eGVrMiBKoTJfsJBav9sPM7plR3p1KUNQBCi5?=
 =?us-ascii?Q?u+pAl7tnmRQC2w3prXdl3peYxldnW0gva/KVIKEchAlVgkzy0wPSqlO9Xhsm?=
 =?us-ascii?Q?3f1WvQxvs+Wpxm/91AXvP0ITxYvoiNdnlWalX9Qz/Ig0o27Uf1BEatcGgjKt?=
 =?us-ascii?Q?dO16uQQ+AqtXWqvDP91HjybE5ciMszwmjwz2m8XViSwU0Wm2nbHBHzI1i3E0?=
 =?us-ascii?Q?akknG5yBwH2nRt9l/JES5iHH3RFrxjELEcNs5TIsuACa6ThLkJP9zA1fSVVx?=
 =?us-ascii?Q?HIjU5ZX6EBtAXaIaYhtoZRRYX4zCbJf7z0qSFmvVBpOAO1SjJX92vQqu8YxG?=
 =?us-ascii?Q?9tzlyRvz3C/ZZnZjkse+BUDyaJ04dttB2kkHZzCSrptcHuPKAC4gi54z9f79?=
 =?us-ascii?Q?4rxTgRqeZEwOpVAzPPbhuyfCU1lFlbP+AAqoE65UrhMBVtwTzcuiATLprUMH?=
 =?us-ascii?Q?QvjbBEcHrg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1O4KGKPKhDV6ntCJfH+e5pU39oV05tM9mWpjNqxKPeEPlOYicjcM9vFvPPzH8DrptUo4twGdkFE8Bn60dSwZqm7oqlcNp5fiww/yz8iReK9XpROINDnaiheZVYCWAlVbjnMXIQNpt9UavRJhU+PGs5o7kaWYW2nOQNm5tEeKCOAkB5hKFxU8PhT0Fci+f8XbgvwcBLoorwhsPQlKmb1DG2phQNwOXqR802Apa+uX0AJBZKJ2bGUcdCo5n9RsPItI9jxqOJpOVN2nDNhTMLug0+ejGUvJmcQniHQYw3h5G40kVJ38IXZJbbS0RezzlH7C5+tcnYhLq6wqopGqQ2yIhw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d139dce1-838d-420b-bb41-08df2fe53383
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 02:35:56.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjltaoxJzL05ytuRSgUtXTJL7QxKZw65gSfPLTVUqUc2gzZJeMxW64KFL1gnLxNl2vSFSuIjsxfZnOrdawolGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-OriginatorOrg: intel.com

On Wed, Oct 21, 2026 at 09:28:08PM -0500, karim.sabar@utexas.edu wrote:
> Hey Matthew!
> 
> Sounds good to me, the fallback of trying to bind the vma one at a time sounds good to me. And it is actually a bit broader than my patch since it covers the -ENOBUFS case as well. It should also be easy to get through drm-xe-fixes and then backported the normal way.
> 
> I can write it as a v2 & test it on my Panther Lake device, I have a small repro that does about 20,000 mappings and fails after suspend (every time without the fix). If you'd prefer to write it, I can test your patch as well.
> 

Since you have a repro, I'd say go ahead and code it up. This is on my
radar, so I can review and pull it quickly. It should be a relatively
simple function, and something like Claude can help you code it with a
concise query if needed.

One follow-up we'd probably want to add is error injection and an IGT
test to ensure long-term functionality, but we (Intel) can take care of
that part as an AR.

Matt 

> Thanks,
> Karim
> 
> On Wed, 21 Oct 2026 11:57:48 -0700, Matthew Brost wrote:
> > On Tue, Oct 20, 2026 at 07:08:27PM -0500, karim.sabar@utexas.edu wrote:
> >> From: Karim Sabar <karim.sabar@utexas.edu>
> >> 
> >
> > Thanks for the patch. I do see the problem in the old code.
> > Unfortunately, we will not be able to pull this into drm-xe-next or
> > drm-xe-fixes, as 7.3 is already out and 0e33330f1238 is included in our
> > 7.4 PR. As a result, this would need to go directly to stable.
> >
> > There is also a risk that predates the series containing 0e33330f1238.
> > If the bind has to run on the GPU, you can still get -ENOBUFS later in
> > the bind pipeline if the bind is too large to fit into the
> > migration-layer BB. If that occurs, the proper fix may actually be in
> > xe_vm_validate_rebind(). If xe_vm_rebind() fails with -ENOBUFS or
> > -ENOMEM, we could call a new function, such as xe_vm_rebind_iterative(),
> > which would run each VMA requiring a rebind in its own job. This is
> > effectively what Mesa does in userspace when a bind operation returns
> > -ENOBUFS.
> >
> > We could probably still pull that approach into drm-xe-fixes + have
> > naturally backport to stable, and it may ultimately be the better
> > solution.
> >
> > Let me know what you think. I can give this an RB, but I'd like to hold
> > off until we've settled on the solution we want to pursue here.
> >
> > Matt
> >
> >> Big games die after every s2idle resume on flat-CCS iGPUs. The exec
> >> ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.
> >> 
> >> On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
> >> these parts. On resume the first exec rebinds every VMA in one go and
> >> xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
> >> Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
> >> array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed.
> >> __GFP_NOWARN keeps it out of dmesg.
> >> 
> >> Data from a Panther Lake handheld (SteamOS kernel 7.2.7), kretprobes
> >> after resume:
> >>   xe_vma_ops_alloc  -ENOMEM on 63 of 63 attempts
> >>   xe_vm_rebind      -ENOMEM on 63 of 63 attempts
> >>   BO validate, TTM populate, PT prepare  never failed
> >> 
> >> The array is only used by the CPU and doesn't need to be contiguous.
> >> This switches it to kvmalloc and kvfree.
> >> 
> >> With the same change applied as a module on that kernel, the game
> >> survives every sleep I tried with zero ENOMEM. The biggest array was
> >> 30,753 ops (11.8 MB).
> >> 
> >> drm-xe-next already does this through commit 0e33330f1238 ("drm/xe: Add
> >> struct xe_pt_job_ops"), but that's part of a big series that won't go
> >> to stable.
> >> 
> >> I tracked this down and tested it on my own device. I used an AI
> >> assistant to help with the debugging, i.e the kprobe tracing and
> >> reading through the xe code. I ran every test, picked the fix and
> >> reviewed the change myself.
> >> 
> >> What I couldn't do: this is build-tested on drm-xe-fixes but only
> >> run-tested on the SteamOS 7.2.7 kernel through an equivalent module,
> >> not on a mainline kernel.
> >> 
> >> Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
> >> Cc: stable@vger.kernel.org # v6.11+
> >> Assisted-by: Claude:claude-opus-5-5
> >> Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
> >> ---
> >> Downstream SteamOS report with the same data: https://github.com/ValveSoftware/SteamOS/issues/2962
> >> ---
> >>  drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> >> index 99e42bd29..5caef443b 100644
> >> --- a/drivers/gpu/drm/xe/xe_vm.c
> >> +++ b/drivers/gpu/drm/xe/xe_vm.c
> >> @@ -703,9 +703,9 @@ static int xe_vma_ops_alloc(struct xe_vma_ops *vops, bool array_of_binds)
> >>  			continue;
> >>  
> >>  		vops->pt_update_ops[i].ops =
> >> -			kmalloc_objs(*vops->pt_update_ops[i].ops,
> >> -				     vops->pt_update_ops[i].num_ops,
> >> -				     GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> >> +			kvmalloc_objs(*vops->pt_update_ops[i].ops,
> >> +				      vops->pt_update_ops[i].num_ops,
> >> +				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> >>  		if (!vops->pt_update_ops[i].ops)
> >>  			return array_of_binds ? -ENOBUFS : -ENOMEM;
> >>  	}
> >> @@ -742,7 +742,7 @@ static void xe_vma_ops_fini(struct xe_vma_ops *vops)
> >>  	xe_vma_svm_prefetch_ops_fini(vops);
> >>  
> >>  	for (i = 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
> >> -		kfree(vops->pt_update_ops[i].ops);
> >> +		kvfree(vops->pt_update_ops[i].ops);
> >>  }
> >>  
> >>  static void xe_vma_ops_incr_pt_update_ops(struct xe_vma_ops *vops, u8 tile_mask, int inc_val)
> >> 
> >> ---
> >> base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
> >> change-id: 20261020-xe-kvmalloc-vma-ops-2637ebf81cfd
> >> 
> >> Best regards,
> >> --  
> >> Karim Sabar <karim.sabar@utexas.edu>
> >>
