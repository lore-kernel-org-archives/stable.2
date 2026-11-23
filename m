Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795423317;
	b=JHMv1KqQuARYX9ub/1tfUcLvP+b0jqobazpGR3Q1cweMjg5+UlYtGkznwRvfEAno1N94
	 oN3JhmaGF/N99UBnuJy776YD2NuMKY6OMc+lq9sAUtNC7QxitHy8eu+sz1rphaeykUVp5
	 vfX5vZQeHFXtXuWf6JK47BiyxBo5VzYV4mwDs4Lz/CdHttlX7/zTUPoX3IPPsYKBniAz4
	 IfP7CmsmxeUEwr8jIzXcM2L0A5INu5mN8FgtG5QtGGC530N/4AHI/Rrq148uMNHU/js/A
	 ar1rxYTPB/buPOnGkSERoMlSycGf1/xaMdvxRODJWvnNKranfe35m4ZU+NL3SsrtGwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Y8enceVsOnDajIZWscYBG0YpzFHRo6EW0ie2BIzWVwA=;
	b=lN4oo95XgJxyyUC0gzKo56FGpvp0DkiLWx3s0+zAlvbaN3RKl8gQEfRsHq0GK0q1CL2j
	 jSEIkkR0BD5fglk0XHQY7geOtEOHP24Iihk11ciDJwFXy5sWTX5PBn0ncllbgg8gYzTBC
	 o02Jh4Cme28Itm6f1yxotxRwrJIwKwYN1SZBhZheADRgc5LFPY91BOaSQXqUV7BIMEuwl
	 I04mwyuvfnKxFtKwIg3lilcCVTmHHUK9qF3HcGzwboOooOtpDOT4Gr4FrxLFH8dts9LYa
	 hj8OXS47P88GyieJPTZX+THA1/xaOIVn1d7Q/XP7HXNtohBI8BAcMlz+Aj5i00rcJtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E7mkYxzt;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YF6ckzOo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D63606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D63606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E7mkYxzt;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YF6ckzOo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795423318; x=1826959318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1jDpGG4nPS5kttZiWHagKN9TMmUHv7PR7eGrIz/FXPo=;
  b=E7mkYxztIUlLRKc1ZBdmMKAiuefQKjKhuQTSPlPpJbh3vry9+NUsSJBq
   N7vHJNLE0Dxis2Ptesfl+hXvfzQ0dcRu9SFkNWGHmMjrgoHJ7fEAXhyJB
   Q2SpnbyoP9/hThoGZFjFURdHuFikPqQYoWu0qUGEdH9T0lBLAap4qgp1H
   Pp2TETHwZ4Gsaztrd3nhCppPm2QAsFRcKdJYnX6FJFHF3IzF4vKqbH7x1
   eJxE3Vsd3HBoPQM5gXrXxXUoZS1PNeS2M2AJj6qfEwNFtzh7AcKGIMgw4
   iePjgbiZr+37sq1pHBRGWxTC1rqEBkDkmO2gGVhO1KGRL3+YPX70AxFeb
   g==;
X-CSE-ConnectionGUID: 7vTn3+2wTEmeJzk+NPfH5w==
X-CSE-MsgGUID: mxvA8fH4S1eRdUhSw/miRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4238916"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4238916"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:41:57 -0800
X-CSE-ConnectionGUID: rZ9JWdYmRBqrvsb/Zc3D3Q==
X-CSE-MsgGUID: Bnnu+bJ0RJSQMi9YzH7qPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11658050"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:41:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 00:41:56 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 00:41:56 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 00:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI2zYvtlmeX1oDZeyfV2n8a6XPiFnd6y+YF5IoKuinNGJCbBfo4GDnoE5nfJ9s0bgKDsqRLSjJYgbbvgkprqJo4l3nDCPOTCNlI9OyIcYEF78HTy8fFKx55vHHHYR15AlYzVsB6LhqvbnOuSeeN+qxP+2uaTSEJUOLdriJYbntmf86I0sqZgDyBr1CB7Ib7tmsU17d2Ku9rVeSzZ4Y4rG3Y10oTyKXmKN2rHJQeY2UwLZ6aTa8h5jZbClZ99/8sEGOgS+pQkM2gFFNa0onMSQ2OzEnOaykqV7Fy3jdFij3FLqUnpSaexr4ciTU5IIjXHqNc7goiXaUjwyF8zXQ/XUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8enceVsOnDajIZWscYBG0YpzFHRo6EW0ie2BIzWVwA=;
 b=zCqp2QIBVAwlCwrdR4/AyJIjASW7zNdC7vZhD14MGlJDXZwtI/2U4Ga11IiOO3qGwb/s2xi57aA4DQqxa6Q4QqngOAFv17+fppipgt2qgBEGqt1+b1sDAzKAmwN9OQBLpIgPlWw95JOdN5vD2jiBmnTpx6ujkFbYkxCqdnDwPfcw57kMtA1ozTSKlZHrXzbtBMuWkU+61vVhhLosYUXe9wfl7xcru0mDY163JlAArccVe1z4bY+odgZUB+CCTu9rB8eJ8OXIhASt/WeDWbTJWKVO7BdcQ77F5kJVR2uD5gy1EDRVKKPfeEHRZ8nWvez0nf0yfNYCGvWXbPt7Ox8hmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8enceVsOnDajIZWscYBG0YpzFHRo6EW0ie2BIzWVwA=;
 b=YF6ckzOoiKfgBqEaFySpOGKsSwykKKTN/j1yf62GwzZVxbv99bf4rTG3K1mclywiWg1926qEFFhavE9IxM0s43o85Rrb9O+7wHIdHufYs3meF4CfZUOR7lfWh1VVKePIFYZgWDI06rChJiBbbvecKZhDL9ei66EXWC2JlG7WpdY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11) by PH8PR11MB9880.namprd11.prod.outlook.com
 (2603:10b6:510:3c5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:41:54 +0000
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c]) by LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:41:54 +0000
Message-ID: <1d902825-aa86-4438-8836-63a25deaf2cd@intel.com>
Date: Mon, 23 Nov 2026 14:11:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/i915/dip: Write the DIP header last
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
	<intel-xe@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Suraj Kandpal <suraj.kandpal@intel.com>, Xiao Lu
	<xiaolu.xie@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
	<ville.syrjala@linux.intel.com>
References: <20261113074849.30768-1-chaitanya.kumar.borah@intel.com>
 <55f8ef22-9581-416e-a446-59660390818e@intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <55f8ef22-9581-416e-a446-59660390818e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::18) To LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11)
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
X-MS-TrafficTypeDiagnostic: LY0PR11MB357627:EE_|PH8PR11MB9880:EE_
X-MS-Office365-Filtering-Correlation-Id: 5754cd6e-0372-4d2c-f266-08df493da03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261022115727099003|261028144727099003|261021123027099003|261021121427099003|11063799006|4143699003|56012099006|10067099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: zXysY3ZJ9VZQNKccpuTSYwubPeGUV/qyX/edzkYZssJwo7IDI+SIc5QVIQS8nE/Uzck23Wo5ayCmyPlbPQCkaFr/IRp4fU6I81DUyUxbDadU98Cgoi2yVirWaZMb00pTQqRlhBII6QrUV6DzlSifKjKMU/sfgIXRea/NpLGalHPaRLCCEc9qkCeAa5swGKfDyxouIblqZEcjO/qyKfq4uHGW4oZsweL1SD2r01TGnx/NMT3Tmb48FpePGrSUD40pM7DHG+Uy7m2IUr92ZOVjQNs2+4X5cyg451o3UyO8g0PHx6Z/B/T+IQu33Uw9KtTkins4Mmb9+GXKBcNmlbq+o6DQdi1l8nLP7yy0A3xPwZ4NbFQxFmEwIM1fGFDz7ZwM/zzL7q3rCROKmrVxwJ9Z3bQn8tWSXEmUPhsGuUs5YQG9GEzz7MnK2cnABi15YAvrnp5o0sCnI0WnKCFxyrKnaCaNT+excmcP8pd4Jk/DcRDiBE1uMAz+pqJA1KF8lB358gXxol3n7ykdkrFbW7E9KqhoGyhnodFuzDvXlaJWkvn0k5+XEvDFATonuZj8oRP3Gly3wLCMzZoaENepj4cVOXCTm2316/beDQJiNM0bhnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR11MB357627.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022115727099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNtQW5mT0t5L0kvcVFhMnNiNUpIeUFRR0ladlNJSmUwSzl5QksyTG5QeE9Q?=
 =?utf-8?B?QVAwVzNMRUVoOEh1K3d0Q0wrQjBPMG8wZjI2Wmp2VGZUZC8ySHFxWkkyU051?=
 =?utf-8?B?QWZpNlRydVR4bE45Ykx1dXIvS3hudDBvdHhnZE84UElBbmloM0VRaUtHc3c3?=
 =?utf-8?B?bHZ5OE04REVEKzRoVm54UVpJbXplbUdXLzdBbW5iSUxFbFF1aVUxWFVITzRj?=
 =?utf-8?B?aVpMWVJ2ZGJJTkJSbzhMWWZUWVNxSWNvMjk2R1VlNUpQRHoybWxSWHRDYTds?=
 =?utf-8?B?dFVlZVQrV2pjYVdjL0p6Q0ZrQWdPSXFscDAwVUc2QksrZVVieEtHeXYvN1NT?=
 =?utf-8?B?OFVzbVV2OXNJaFdBL04rRmJBSEdOYXhHdllrZkNEVHBDR3FRTnh0KzRpWjRS?=
 =?utf-8?B?Q2JNd3hreHdmeHA2SmpDZDU2eVJsdVBwcXg1MUQ1ckN4Q1N2OC9pTXRNNzRM?=
 =?utf-8?B?Skd6QXRwS2xvL2EyYytCdU10TjB2czkrMnRGeWxEbGd2WURIL0lIM29nQ0Y0?=
 =?utf-8?B?SGdLNUdWZWNoSjhyNXBCcUl6WmMreUNoZUFaTitSb0hjLytpaE9sMVBXQUpJ?=
 =?utf-8?B?UVlvQk5DNzVwRTZHMjQ4bGF4cFpJRDRWS0xkeEpwSC9ua2VMeVQvb1VDOTgz?=
 =?utf-8?B?aWszU0ZTNHVxbzIyeEVJOStEb2dic2lYVVZqTmhMUktVb09EalQxWGphdzZJ?=
 =?utf-8?B?WS9EMVRCM21UVXZkaFRZMGpSWXd3NkF5ejQ5bVFwQTRXK2svMzBNTm1WaFZs?=
 =?utf-8?B?bmJJYjM1ZDNQSFUwc0xnWlZPWVNkaDZnTXlXdnV1NU50ZW5TbW9QV1EwVzJN?=
 =?utf-8?B?Y3VyMWVOVU5EeGt5dFUyQjhTN294SXYyYVg2NHROQ0doUUUrQld2TUtKK1RY?=
 =?utf-8?B?RHVWOUVtaEkxelpRenlBZWo5NWlQaVhaVGJNYkNHdXo3OWdQYW5zbVdSVmRt?=
 =?utf-8?B?bm9qeDgyQkthZlBIb3VONVZwVkVNVEdyRXd2K0IvZ0ZHQzNJTzhIU3lVeHlu?=
 =?utf-8?B?aHhnLy9LMFNJYXVZMEtRMlRNZko5TFJzUGcwRjZ4NGw1RWJLMGh6b29PSHhW?=
 =?utf-8?B?TXRGNHdsWXdQd1FGWUNJSFhXODYyMWkxQkl6QWlpMkVTSXdpSldEWjl3TFN6?=
 =?utf-8?B?amg1cS9yNDdoSCt6b2xXcXFTSC9oMnVwLzZRVVpFY05lZmFFaVEvRUo3WGxE?=
 =?utf-8?B?aGhpRjlJUWtoSy9MaXJsdEtoSUF5Nkh3eVFQNVl1OFlFbUJGUlJPTzQ3YlJq?=
 =?utf-8?B?NDBGR3VYR20vUG5uNkwvR3dYbzFPMWswYW5hNnVLZG9uRTZMUzB2L1lPaXlq?=
 =?utf-8?B?bDNwY0NjaVNtNVZlYUY0WHhaenlPVVQyNTBKK0xmQ3U1aG9MTGVnSmJHK0ZF?=
 =?utf-8?B?OTIzVWVqemN1MFpiM2VCcmtwRHZ2YlgvTUcvaG9IbXgrdm5qSzdzdkJGdEtL?=
 =?utf-8?B?VGl0QVladFdFa3ZFK1lWMjNNYXBHM0lsY0Y3b0pMUkN6eXNlamc5QXNCMi8z?=
 =?utf-8?B?d2FYa05IWUI1TVI4MGFvWmhpdndpM2IxNi9PRmYzSmxXM2ltS1V5cEFMc0Fo?=
 =?utf-8?B?M085WVkyRmwvSURJSkNsK0R1c1M2U1FJN2NGT2RhUW1yVVZ1d2NpRmFudmVl?=
 =?utf-8?B?UnVWOTlqWmVub2o4UjU2b3I3cVhvVkpBQWJyQWt0N1dDbGhGdFBiWm55THZR?=
 =?utf-8?B?ZHovTDhteWJSUEIyNzZuZ2x2em0xamZXWUZxdDZUdm10ZVR6M0hVQTBOZDJl?=
 =?utf-8?B?RE9VMHFGb0hRWWRhL2V1eUF1NXJlN25ZbVZXMlRjZDFxYklaZ3hJaEJDNU1m?=
 =?utf-8?B?Q1RMK001MTFNSjJlWFRxdWhvNTBMNHpUL1IxNHdMSS94NWhiNzVGVG4yMUdx?=
 =?utf-8?B?cy9EY0k2VnpOTzJUZk4vNExvc09meGNyUGRFbWt5YnROZHJCOTZ6R0RHazZw?=
 =?utf-8?B?NDRZN09rM1FkNmtwb2IvWDBBU2FRMEVkVXk5bkM0M3R5M2Y2S0Z2MU1WVTNT?=
 =?utf-8?B?dXN6VXJqR2JXYWFEK1hEK21ENTErTngrbSt5ZU4rd29kcW42bUtRZldzSU5m?=
 =?utf-8?B?SHZ3VEUwVmZoU1lSNVZ6SUhVNWprNysvaStDMGk2UWdSYTNTRDhWaVFJTk1E?=
 =?utf-8?B?dmljTjZiN3ZSTFJKTTlCbEY5K2pPM2Y3RTZFNk1PTlVsZUwxNkJGaGg3Nkpw?=
 =?utf-8?B?bkdqTmlhWTJ4bWdXYVlzbUZ4MVZvYmdYSFVWclYzUG9LbG5yMHM1TEFQUURC?=
 =?utf-8?B?ZnAycXduQWFlem9yM1ZOZ2xCUVY4dWlPTmtLZWsybmJXK3FMWDBKMnA1QjJw?=
 =?utf-8?B?TjZhVUlhZ1lHYjJGZHNHajlDZXdxL044TWY3NHNyN2JZVG12VnU3UGhWQk5o?=
 =?utf-8?Q?Qb2cKpQS9JjaXLcg=3D?=
X-Exchange-RoutingPolicyChecked: f87ArTkfQ38IN91voFU9+Q9/M1chn8tjUqKLOeqHWcULsqdwxSsRG+xpE/KMClIA3kpCecipXu+Zplcm8BCutxDWjUNKXhB2E/o72iv2bhCNnbfbSVzD4zSn+0yqrwx2TXNs1cNXOWkK0W9DM1XJlgWaq87OnyXP/66b29p15I+rgrpwAcmQm8ooIcidKv9xKaAacgnWkWBKTOWFWA8+BpPMlYRmGi0+4nHBw6YEs80xsrdsAxzmziDUfS1J+qoYIFCxEvo21x0x1iTnRDsWiM5dK0IP385qYzK62Mx2QkemZVasuQ7ffii4jMnfpfNmS8et70okXyzX+3NouKfueA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5754cd6e-0372-4d2c-f266-08df493da03a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR11MB357627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:41:54.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HBfr/W+/ltmbvAZNTi7yGNVGeRJPtjognzV4tO/r8VXaB8dMUbCusYQyjF1vyrcWhT+fQxYt6Ds+1zqujC7v4d02MagNUpnymY9s7gacxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9880
X-OriginatorOrg: intel.com



On 11/18/2026 2:12 PM, Nautiyal, Ankit K wrote:
> 
> On 11/13/2026 1:18 PM, Chaitanya Kumar Borah wrote:
>> On platforms with SDP transmission line registers, the packets anchored
>> to them are double buffered in the transcoder (TC) clock domain. The 
>> packet
>> registers are in the core display (CD) clock domain and the whole 
>> packet is
>> clock crossed on the write of the header (dword 0), so Bspec requires the
>> data to be programmed first and the header last.
>>
>> hsw_write_infoframe() writes the header first, so the packet is crossed
>> before its payload is in place and the previous payload keeps being sent.
>> This hits the AS SDP, and the VSC SDP whenever an AS SDP is enabled, 
>> which
>> is whenever VRR is possible since commit 6a1712052859 ("drm/i915/dp: 
>> Enable
>> AS SDP whenever VRR is possible or PR !async"). With CMN_SDP_TL, 
>> enabled by
>> commit bfa597238073 ("drm/i915/dip: Enable Common SDP Transmission 
>> line"),
>> it also hits the GMP and VSC SDPs: on NVL, entering HDR on an eDP panel
>> leaves the image discoloured and scaled until the headers are rewritten.
>>
>> Write the payload, including the ECC zero fill, first and the header last
>> for all packets. Packets double buffered in the CD domain have no 
>> ordering
>> requirement and Bspec recommends using the same order for all packets, so
>> use it on all platforms.
>>
>> v2: Always write the header last, without the platform check. (Ville)
>>
>> Bspec: 75640, 71197, 74384
>> Fixes: e1123e617e51 ("drm/i915/vrr: Program EMP_AS_SDP_TL for DP AS SDP")
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17732
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9746
>> Cc: <stable@vger.kernel.org> # v6.17+
>> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
>> Cc: Xiao Lu <xiaolu.xie@intel.com>
>> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> 
> 
> LGTM.
> 
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

pushed to drm-intel-next. Thank you for the review.

> 
> Thanks Chaitanya and Xiao Lu for finding this out.
> 
> 
> As per the discussion in the V1 version (https:// 
> patchwork.freedesktop.org/patch/768289/) :
> 
> Xiao Lu, the VSC_SELECT clearing is a good catch on its own. It can go 
> as a separate patch on top of this one.
> 
> It may not be needed for the gitlab issue, but seems like a correct 
> cleanup to me.
> 
> Regards,
> 
> Ankit
> 
>> ---
>>
>> Notes:
>>      The same ordering change was posted earlier by Xiao Lu
>>      (https://patchwork.freedesktop.org/patch/763779/), for xe issue 
>> 9693[1].
>>      Fixes tag rationale
>>      The Fixes tag points at commit e1123e617e51 ("drm/i915/vrr: Program
>>      EMP_AS_SDP_TL for DP AS SDP"). The AS SDP has been written header 
>> first
>>      since it was added by commit 8845021b7331 ("drm/i915/display: 
>> Read/Write
>>      Adaptive Sync SDP"), but EMP_AS_SDP_TL, which holds the double 
>> buffer
>>      point and the transmission line of the AS SDP on BMG and LNL+, 
>> was only
>>      programmed from that commit on. From then on the driver relies on 
>> that
>>      register to anchor the AS SDP, and the VSC SDP whenever an AS SDP is
>>      enabled, and the programming note of the register asks for the 
>> packet
>>      data first and the header last. The two later commits cited in 
>> the commit
>>      message only widened the exposure: the first enabled the AS SDP 
>> whenever
>>      VRR is possible and the second added CMN_SDP_TL for the GMP and 
>> VSC SDPs.
>>      Alternatives considered:
>>       - 6a1712052859 (v7.2): AS SDP on whenever VRR is possible. A PTL 
>> report
>>         [2] is fixed by reverting it. Narrower than the spec argument, 
>> as it
>>         only covers v7.2 and later.
>>       - bfa597238073 (7.4): CMN_SDP_TL. The NVL regression, verified on
>>         hardware, but covered by the older tag as every kernel with it 
>> also
>>         has e1123e617e51.
>>       - 8845021b7331 (v6.10): first header first AS SDP write, but
>>         EMP_AS_SDP_TL was not programmed until e1123e617e51, so exposure
>>         before it could not be shown.
>>      Not verified:
>>       - The failure was observed locally on NVL with CMN_SDP_TL 
>> (rewriting the
>>         GMP and VSC headers makes the panel recover). The AS SDP and 
>> the VSC
>>         SDP with an AS SDP on BMG, LNL and PTL follow from the Bspec
>>         requirement and were not reproduced here.
>>       - No reproduction on kernels older than v7.2.
>>       - The HDR test on NVL was done with v1, which only differs by the
>>         platform check; NVL takes the same path in both versions.
>>      [1] https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9693
>>      [2] https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9746
>>
>>   drivers/gpu/drm/i915/display/intel_hdmi.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/ 
>> drm/i915/display/intel_hdmi.c
>> index 4ec0db8d93fb..66149aff7993 100644
>> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
>> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> @@ -535,18 +535,27 @@ void hsw_write_infoframe(struct intel_encoder 
>> *encoder,
>>       val &= ~hsw_infoframe_enable(type);
>>       intel_de_write(display, ctl_reg, val);
>> -    for (i = 0; i < len; i += 4) {
>> +    /* Program the payload first, the header (dword 0) is written 
>> last. */
>> +    for (i = 4; i < len; i += 4)
>>           intel_de_write(display,
>>                      hsw_dip_data_reg(display, cpu_transcoder, type, i 
>> >> 2),
>> -                   *data);
>> -        data++;
>> -    }
>> +                   data[i >> 2]);
>>       /* Write every possible data byte to force correct ECC 
>> calculation. */
>>       for (; i < data_size; i += 4)
>>           intel_de_write(display,
>>                      hsw_dip_data_reg(display, cpu_transcoder, type, i 
>> >> 2),
>>                      0);
>> +    /*
>> +     * Packets double buffered in the transcoder clock domain are clock
>> +     * crossed on the write of the header, so it has to come after the
>> +     * payload. Packets double buffered in the core display clock domain
>> +     * have no ordering requirement, so use the same order for all of 
>> them.
>> +     */
>> +    intel_de_write(display,
>> +               hsw_dip_data_reg(display, cpu_transcoder, type, 0),
>> +               data[0]);
>> +
>>       /* Wa_14013475917 */
>>       if (!(IS_DISPLAY_VER(display, 13, 14) && crtc_state->has_psr &&
>>             !crtc_state->has_panel_replay && type == DP_SDP_VSC))

