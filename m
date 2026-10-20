Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792527563;
	b=EDLLFX8Aqe4faqPZ/s9orJzG+XNTzWEpTerQn334weG865Si/rz89N81UvdveVHqHE+r
	 q2uRbCzGEbdnOvdRG1MmPjYU1vX3/0yG9UC8V/+60AYdzyw5Pppau6DxrWLTzwGqxwftA
	 f3IdatCposOGdfDjxhwv2g5xPAqo8d6aSBroDq6TeHskab5PzLa4kb5LWGfbN+FkCVbGC
	 RxtVn9+UBsLoaUPkOMCtf5jGa+xkJCbXq0P7n5l048EJT8dGYF3JtMHa0V+6sDqaaiZHw
	 mWWPJBKODfukYT/GGvfwn/SgEYn42UnLorDsXDXDKn2MtngWPJ5H6B57Vb8Z+Ia15KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527563;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=sNASX99OxrTjg14n03V9KJyhUmT/R3kV4Rnloox7nfY=;
	b=4K0nrMowspcHqAVJmWJLpgwsB0kdvUO4Cs0Y+1iIR2dgJ/lkOwDkWNPUXjtyVoGD/ly2
	 rlwZbkpOAr4ZnBy2qGgUlbwG22acPOV8jZfw+aXyXxl5Lm3tjRPao1AsBsOfMcBUDvQwg
	 xcPxx3Yhjdf/p8sdOeecm8eBhuEA6tBO6psRPl86rYmM1LmpKZWMSC73LL/M6eMaHY1yW
	 YRiQHm68jw/JQQGx6L+5zwBYVoejR9ZwSHYqlZxb4XC9/HHUtscTIkPlA+QI8MRhWM/e5
	 R0EaAOaMu5hIfxYNZzSZdXeRG8BTjboXQN5iQLRIcupweM1boh44EgB1K8LF6MLyaXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JQXd2cJr;
	arc=fail smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3723606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3723606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JQXd2cJr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792527561; x=1824063561;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GpBj19YqfISk/gZi8Wp0Df19YyYUgXKJJ+Bb7sX8Udg=;
  b=JQXd2cJrdaEUys7MZgicOmrLUNxsZyZNYnKISq6Y6D0gT1a+VxBi9ZK4
   ft7vNYOjF/lh8CGr1n/mnhSxH8XNKyiJ9GL9KbAx20FggupOw4G835HBo
   wjWZjTqNUEDGZXdOjgx8N1d0RDwthrjWuhA1owSzCNXDzuxhh1zMsEvmx
   W4F3h+VxWYLWzYEQGBW05OWge/jGo0iDjvIiDdzapq+g+IJSF03jrOI48
   ztH6XrteYKb2KBZl6hj+LUY4OilZOB+TOMumRuufUhXwhfFTYRB+D7Ysn
   kJ/pi4y1OCofHL48A53gXPQRZdtUw1/q5RmFaU8Bu+fI2dgwuha45VBLN
   w==;
X-CSE-ConnectionGUID: 6nERAm2+R52IuSZWP4QzCw==
X-CSE-MsgGUID: WjR73MVJSJOabSFqv+uAEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119712"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119712"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 13:19:20 -0700
X-CSE-ConnectionGUID: NW82TNYqTB669VlH2qVvig==
X-CSE-MsgGUID: Q93+BMmYT3CulNou8xmixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3234954"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 13:19:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 13:19:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 13:19:19 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 13:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0k7BBLp4E5rzMpK3sBFxHRMHNlNhcWZ6s+Ch5/Y7gOiQXtixmMHHle+zb9wRBNBq/1dr3/zjKFdTlwpi9FQ+geVuRyHyP3rseX8t3btvMU7UepP/rOqbZCezogyTt/YDfNbxz12TbgQiF2vr9VDUloiinlhhVZZOk36cX9f3Fa5U6DaInwasWK5Y3VoZ42w2xbl+TUa4Qh15+mtL0bPKZN+mYDSV5waZ7igIbBhJopvysLR1QvlY2j5sEXdrLvb8guDfxCehnVRWLMzR9GvCvBJOaDxUW6PIq8o19sVG0g6RHoh1r9ojIcT3TcZEOOuilpDmidvjv/QrtJ3i6jtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvUmOCvV3oQ29NYxHhaM9DFLCTYN/+8SXtBknYaflDY=;
 b=ro02hYS1FvLxIrMxE4A5rl5xE/MOgonZpMba2yjSnV5nSux9ElZPL9eI56yD0ysVGc6/m3rhIcHDOLH45489clOTwPKgROjLQ0ENaUIJiex9PZM2un5gM9suNctLjIrwB6LZHT77j3mJPGesTQ7I0mgzWxV/jSlKOTk3ldzxMgxxT7rcqWitDItFkFiv7BQZPQqWbROJXKvfsgFLsjmIAcynYwDF4R+U1AnJ21AWvFjOSVV3sIEu9nXQG44VcxI77znC6aN+xPqpRaCZcTsPoOomAMOYPEZZKef3BYbohKQ8otxSuhK/qY/2eirQlWX7rpgyYp+h+ugjGounCrwSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by SN7PR11MB7667.namprd11.prod.outlook.com (2603:10b6:806:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 20:19:16 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 20:19:16 +0000
Date: Tue, 20 Oct 2026 16:19:12 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Don't fail runtime suspend permanently on VRAM
 eviction -ENOMEM
Message-ID: <atfMwPZB4l01xna5@intel.com>
References: <20261020100545.46715-1-thomas.hellstrom@linux.intel.com>
 <atduGDrVk7kc-PPe@intel.com>
 <ateSC6dTa0M3Qc8n@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ateSC6dTa0M3Qc8n@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
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
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|SN7PR11MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c12d28d-197d-47da-279c-08df2ee769fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mYkHcKcMEMfhVcUBo4NvI41uCtMVDprihHnvCpps5q2IrvfGwVRaFrDVwrwFentxf3euKLm9teNLMgAwputcT2wbqADv//fE1T5tCnXXWy7gHi4MExTCB8t5AmGH2PJqgorjXpzUpM1rLZmR2YJHEEi1RzzKQfjJ5ehf+AlUcyTmSB9yfhHj3E/Dzx70Z5Lg4p/0exBZV/rmbJsLA21VNbZdtnhFGoaaCOGmQ8ibGYzhUmmLq9Kc8cFNszTTIlDUyeacWRHyXaWjcNfoiFJ8u0vqlNsi5fXQQee5QNig6l0NbrgI1stde+V0zD2+0EGkSYIHPVUxmpDPd38A2ne95P3NOS0f+zhJB09LQ/CkONZUQci+NqQ5qK7NJgw8FGQHN/qkFwwkzuxJoILRrHcyakX4TyhWFWObV+E04oST+FQXT4MKfELViACKKboJgsr8EHmZoX9PD2UCRJ2CsoOuz9p4xKz7wLsqXJo+LoZlQ5Jz0jvAZnSKAzifu5kcX3KNBfqNr3yPRLoJegTUmM4IBILzfYvHaNv5BcXNCtqaMXpyD2WrOefH+YnV/heBqwxqHhPCaDQ/U4l9Md3T6js4T12A5dhVAuzez2xdyzV3giVfKnVwCG9J7hrOmuDJsN9h7YYBT0jD45xfr4P5UnMsT1YW1cnK/NZS/u64dqMNiL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WEHYI/MDpj8IUZp/vlqEyTKS0/j18MLt1ASWGX1NNlzrp0Rt99eDUnpNUb?=
 =?iso-8859-1?Q?niLwcs9y2YRbiXCqQty7pF+yYV5IKJXDHgK78knO8/UxzMGxrmrNbbMLBf?=
 =?iso-8859-1?Q?DxtOIUjFCh8mk3Bgy5W6rXk8XttrII3DTWYLSDnnEE1Z6iYolPe4+NZImx?=
 =?iso-8859-1?Q?M21QRkzXYr1r9JqsoOtKQUBHYBIfLHRhFRPZ+JrpnJXTvAzuuE66+tH/gW?=
 =?iso-8859-1?Q?ihy3DLv0a0ETC345OsNpzTZMhVi9LJ/jyYho23S8v/tWj0to5h2W07YtlY?=
 =?iso-8859-1?Q?8wjS45yQkJV+OXADWZ9dVefKeKlYMReyIUylu9HuRSxUW2G0ZM0PxpqS1F?=
 =?iso-8859-1?Q?uJAHvmkV1p9pYtouDQa89mLvOD/iIugPK5vYo3PKyJv4rY5iqvI6OKbvun?=
 =?iso-8859-1?Q?X7ix1bZMBcCa+Cq4DgnBF1fOpx2QlDgF1C27krhGUZtpv5N1MT6RQupszS?=
 =?iso-8859-1?Q?3wu4l7qPQ+cZVTBr2Txhjw0fwm0chAOtk+BBIWlzYl2hhG615bvAGaXk64?=
 =?iso-8859-1?Q?jhPdeMX7cseOmFe2UZJ+UmX3SVk9/tulR+qcyHr0IpiL80kGc+LBu12Ys6?=
 =?iso-8859-1?Q?vxrtQq903Czc9rY5El6YDpSVL0pSdLeH0r7Z8Djft+i09BVmnF5Gt6pOe2?=
 =?iso-8859-1?Q?KH7jGJJCvb7inXPGaSdtrHZjctcxCXtWA0+xD482iN2mztBPzGUmT5Ow6n?=
 =?iso-8859-1?Q?IEJZoKNJGNpjBTqim4L/g98LuB0WYZcfCpQ4V0oXKvEAzlcsHISeQm5XkN?=
 =?iso-8859-1?Q?GGZT+sx8ZogGR2qIiHABZkmygfse5HgEuNcSIA2tRAw4arOuVtdUwQ3Jcq?=
 =?iso-8859-1?Q?v3uAAot7wadb3YuPpvtmA9VsYj05cdj4Z66Od1VlFSGZ8SjcCSjJwDWcHz?=
 =?iso-8859-1?Q?BbySdjsila3qIdKjBwIeOcyRXEGU5yvDOHeFO/3Ahlb5DY3MnC69iRFrPl?=
 =?iso-8859-1?Q?LkGr7PGjpEMGPn+TApVPfvrV2X33boF13LBgVf0aafeZp5dD8DRvTD1hlq?=
 =?iso-8859-1?Q?Hjg5qrU9uPKN3W46XIxzq/ubDx7gKWdVwMcZSL7RS63/8KRAa/Stef7o6g?=
 =?iso-8859-1?Q?WHlJ4VBsHnOu5wBPSZubG5vqyRMBcusK7f5LeeQCrMXrmP4pH0+TjQSsKx?=
 =?iso-8859-1?Q?Eu33MaDAM4EJq+mZJa7LrTIarHF+Fkk/Atrz+O2+1d619LGHQmgslLo6ct?=
 =?iso-8859-1?Q?z8BSCtwLDFucP8TO2XobRKORW2jyc5+uKEnYfDzOxxDxPYXTRMhFbkt+JK?=
 =?iso-8859-1?Q?VgGBXU4HSDrs2fchDwJtM0uV7bZwUCYQD9zE4fG2Hm1T/N1v3WLYSHWDis?=
 =?iso-8859-1?Q?CeGtkQfmzXSe+wR74UQ1/PoZGrG0JcPn5/LFLQ0xJImeoq1YjWc5OF+T3D?=
 =?iso-8859-1?Q?iJ+TWqhvXgohzvXrJt61nN5T30Np5gTJXaKc70tCuxpEvXKHK/4MYJaynS?=
 =?iso-8859-1?Q?C5B+RO7jPft8V4LgEOzIloBqBN80z5UM626+f3PzhCyY4WR24jDuG3HssG?=
 =?iso-8859-1?Q?ORVrs5PLK1Xlrgk+uYgneLs2zPUwChjHdJAo0FpiaNAjWqaCjl03YgtUHM?=
 =?iso-8859-1?Q?sF4DpV7UJTf5iLDEgxfPt0fVYE0PCO0fuuz7NU3mwKHpvENG5AbcJb9/Ac?=
 =?iso-8859-1?Q?6s+J6KpkaO86Bt8QPts708fVU1jlu7vDvTcEVW44jcgkU7omT9+gunr0Ym?=
 =?iso-8859-1?Q?EWaRy5WYMTF+UPyih3HO5u998Z9NGEjdhRY3WmPHJTFgH5QLqGjsJSo5TF?=
 =?iso-8859-1?Q?uYxlydUd0qN7n6jbjKj8u1KH1urtDSyhTrQoGJFwPNjzU9K9unI9D9JolB?=
 =?iso-8859-1?Q?9jKmPuEKjA=3D=3D?=
X-Exchange-RoutingPolicyChecked: joxI6yaXlQYIy15hf3ljccbvaz9BmxEMv7z0SS9SC0JcdlpwvXWJ+GxbpbvovJOGL/dD1Cs8yTnys4bBedq498RVYVwgV+ylD+1TLdEgH3FCPo+sZGuVxBjBNFpX7vNBkMpcAwZXYu/yhdglva/ki2iTm/Ggdok5y6vmJKn8xOYPlVJ4qqQ5h3dCEVRIL/dpmqyE2Ga2cFb/z5IoBnpeSLhPeUKV+nf0LClYF58R/6uiH5/w3iMO4ExMsp+YN6aUE3Mh6RMBJ1Mwzd1b+vFeZSUl4cxg1CqS9R6QUW0mULKfeOkxmYmfYAV0oIj5CRJWsiaBmMtDVppUIKEPFA1+rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c12d28d-197d-47da-279c-08df2ee769fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:19:16.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2S3Rar4bPrgK9y9zxSF1D7R85YgmuV0GTEOWypEwdheJk3OiZRBmiYM3I4ny27O3woad8UhCBxaUoT7464Xsww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7667
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 09:08:43AM -0700, Matthew Brost wrote:
> On Tue, Oct 20, 2026 at 09:35:20AM -0400, Rodrigo Vivi wrote:
> > On Tue, Oct 20, 2026 at 12:05:45PM +0200, Thomas Hellström wrote:
> > > If evicting VRAM to system memory fails with -ENOMEM during runtime
> > > suspend to D3cold, the error is returned to the runtime PM core.
> > > Runtime PM treats any error other than -EAGAIN or -EBUSY from the
> > > ->runtime_suspend() callback as fatal, records it in
> > > dev->power.runtime_error, and refuses further runtime PM operations
> > > on the device until the error is cleared.
> > 
> > oh!
> > 
> 
> I'm poked around core PM code but had a hard time verifying the above
> claim is correct.
> 
> Any code references to help me verify this is correct?

drivers/base/power/runtime.c
rpm_callback()

if (retval != -EAGAIN && retval != -EBUSY)
                 dev->power.runtime_error = retval;

that prevents new calls while this is not cleared.

> 
> Matt
> 
> > > 
> > > Memory shortage is a transient condition, and with eviction now using
> > > __GFP_RETRY_MAYFAIL it is also more likely to occur. Convert -ENOMEM
> > > from the eviction to -EAGAIN so that the device stays active and
> > > runtime suspend is retried at a later idle transition.
> > > 
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: intel-xe@lists.freedesktop.org
> > > Cc: <stable@vger.kernel.org> # v6.8+
> > > Assisted-by: LLM
> > > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_pm.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> > > index daa7ba2df317..9bf57ed1ea59 100644
> > > --- a/drivers/gpu/drm/xe/xe_pm.c
> > > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > > @@ -649,8 +649,16 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
> > >  
> > >  	if (xe->d3cold.allowed) {
> > >  		err = xe_bo_evict_all(xe);
> > > -		if (err)
> > > +		if (err) {
> > > +			/*
> > > +			 * Runtime PM treats errors other than -EAGAIN and
> > > +			 * -EBUSY as fatal, so report memory shortage as
> > > +			 * transient to allow a later retry.
> > > +			 */
> > > +			if (err == -ENOMEM)
> > > +				err = -EAGAIN;
> > 
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > 
> > >  			goto out_resume;
> > > +		}
> > >  	}
> > >  
> > >  	for_each_gt(gt, xe, id) {
> > > -- 
> > > 2.56.0
> > > 
