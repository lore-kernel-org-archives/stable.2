Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27A3CA4A3
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280624; cv=fail; b=n0fIwq9lzcLO/Qpfk3PR/BBxtzcsWcnVXY8t4uoj/v8R5AiV/3x3miAJu5kQsaERC/725uu23Nloj1jLNygJevRcZGbr9735EMaurlqQmqnTmPMDNXCLjFZA1azQtFe2HwfV6ccxFA48HU8APq0BKlBktJ8k7CqdZNPuymuY8g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280624; c=relaxed/simple;
	bh=DKkE48z01q7Piyi05adOOGw8nILokgJIGWnQ+WJLi/c=;
	h=Content-Type:Date:Message-ID:Subject:From:To:CC:References:
	 In-Reply-To:MIME-Version; b=sXm23z9lWRwuFspK/NUCdjcoGR3dnJxzsl33ACb+UPGOko+ANRM+WEBs+G9SeF1Fge5jKP5n2Wnnq45HTQb5dLwpkl6J/XdD6CZjDyIL9Tj2ziFENV0TRkYsT/ML2eh5N67OlXq0Sc8sC10SuzSV4MBicwXKeKa6jvoERHT9TiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRQdi/uf; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRQdi/uf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791280624; x=1822816624;
  h=content-transfer-encoding:date:message-id:subject:from:
   to:cc:references:in-reply-to:mime-version;
  bh=DKkE48z01q7Piyi05adOOGw8nILokgJIGWnQ+WJLi/c=;
  b=VRQdi/ufYMo3rPRQnUC4GM9PvUM5PjdueTyE6Rbps7Lmx7VC6Zwb4sLs
   mcGcmnk8Hm1o9EPLZDeeL/tKYlI0wXxyYY+P9MHvsrZMgCzs5NX0bNhM1
   vsUjh2Jl8UWR/RiN787jZd3eHNO3eVOn8yQYSvL/axwX7KuZ2DZs0rsuR
   Fe2h+uuLYDJ0w250s9AUpNDcq1Cl/1j4QPNS0BcK2xONrpm1xV8D8Xi3i
   aqeGIaVRe0y5RHQJhoqntA28HmQipUT6kc6fOG0FGZaMKQtDJUV4zmV7J
   fpnRXaeJaNK/8jcBEumPxa38fP45xgomLgfo438NiC/9gRL9iTPVw4vKX
   Q==;
X-CSE-ConnectionGUID: XuOI3bZqS86i1gYd7Axr1Q==
X-CSE-MsgGUID: jW8hCY+aSFa3YwVsG+srFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="17839"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="17839"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 02:57:03 -0700
X-CSE-ConnectionGUID: VV6EXaTxRtC49oR4lgaTzw==
X-CSE-MsgGUID: s9fAZGxMRJ2CmEwEbRhQIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1201165"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 02:57:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:57:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:57:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaqqO78HrXPYEGquP2Ox4fDAHRXAgfjrIpSG05IWcsjTJImD+hop2iTSK4J/QSkeM8b+J6+KigCe3lA/cr6SBf5dvj8RZDe+pltYsVQG4qR1kLJUhYV0TVseBkDRKeexgXhXsl2PIZhw5Hlt4+PzS/8236vmjmnTJAgas/kJiTtLyZfU7EZJJzSe/UnskTvzLWMRKPSOV3Y5S+3c9PZBsQXMtXjevL4t/Psyt+IF0id6N/xmHgG8JcztbYN/3+GI5KhxEvBTcsrfnI2uRvdHRQ3IDHYxol+iiW9sSdoM1hfXaxNSTdCQ42XnXI8JPtyr2Q0xqu5vwdssLq/P9idhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv1w4lQDpkGiJ6z60GXMm6BGxwqi6OvkaPDnLeIuGTE=;
 b=kI3BdQJ1SSKUYSVe3lOCz4BgaS6V1XhjByYaB4nrnhB/x2p5//miLPG20I9tup4mlSo83lZnNVqVwWB+Xf7Jw72tyitLx3VwJaKppHSFAlWQgezpE3hVCP+klcwXyPMdEtVmgjWS4DDYea6YusW+eVeR6EbIthadLIwRH+Zftl7mUmwK2xmER4xsOa/implOKYaYICi4DO5BsegjXsQlWbd/reOXOjutthUmlPzGlFZ9oCtZE9Xnq/1W+uscGOwLi+RA934JK0zMjc6UcGgxznFIG7eXl4ZwxsF/V169mBG13vACFUHkOvIjwv/Aiy7RZXZok6v/CSsnxFrSuE3NTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by SA3PR11MB168349.namprd11.prod.outlook.com (2603:10b6:806:530::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:56:59 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:56:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 6 Oct 2026 11:56:52 +0200
Message-ID: <DLXNZCV3F1J3.1K297GN97SJN4@intel.com>
Subject: Re: [PATCH] iommu/dma: Catch scatterlist length overflows
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <iommu@lists.linux.dev>,
	<dri-devel@lists.freedesktop.org>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>,
	=?utf-8?q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261002053320.3145901-1-krzysztof.karas@intel.com>
In-Reply-To: <20261002053320.3145901-1-krzysztof.karas@intel.com>
X-ClientProxiedBy: VI1PR08CA0272.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::45) To MW4PR11MB6909.namprd11.prod.outlook.com
 (2603:10b6:303:224::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6909:EE_|SA3PR11MB168349:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ee3575-114d-4b74-ada2-08df23902a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VPfDMZEPss3QTF9ZfVGoyC2sKPWoby2pPOd/AQSBId4LiziUZTJTViikmRLG5Hc4IkwvEcSqi2/naYgf7FOc+yhf0+h4J8ZeXXvw8KNM1e/MagX+AVwl4mHjkyEZjwranDGhXDqZ8AbH7q2EqfmRwjSDy/r2ope3QY0z0FZqy6V12wIqjKaTqwiDRzpvPxa+cN7B5JI4uVrfYOk3b3+wr8L//5SqvGni2BaC7DF+Wh/ZWFX/eF9UZeQSNCv3m+TrqOGHiIv7Muw19haG9cxGBfuPO0s2MqjRencJ9fuhmtWOgDeXzxV7WO50A18m62W6RzK+ynJzqrKZl74UU+C/QtDN45S+r8kpeaqM1upjI0ERiGezNxVFzKs+wHbMa2VNHMHmnR/FRlXOntL1idjoo/2NgxITLjp9VTxPld5EkhuyGkjWILMHirj6TgUKtvG45dCRDOK8Gw44Z25KlClRCtDm+tyX1eWfJzTuTHVwwNcdib13+oqCAwpmyI1kqA2tyU4rj1vwM9j3R1Gd4PKBN/OjGMLUGY8clGlX0rOKMLOj8KZ3xYW/rVwSF6vObJHZ70ZUVQG3wynYebIKb7N+DNdi0t6AZGKPQTbD3fcXt5ZncbAW+UFkc2USDcBKrYmksKIEuvFbqXEvfDMFdNPxL6+e31bg2Xf2tk+fclxC2tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6909.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZxRGJzTlZvc3Y2eHpBODNNdVYybTBsL3BTMExYRjBBdVNLZHNSdGgxazhL?=
 =?utf-8?B?ME9pSVpTbjBiek5TWXQxQVRXNzZ6cVRtR0tPb1Fjb1dWYlJVaWdwSW52YVNN?=
 =?utf-8?B?eHo5MUVLcWFKdU5QSCswejZsd2tVN2NJZmYxY3NKWHRJT2h1bW1jZDBxbGxZ?=
 =?utf-8?B?a3BJR01MNFNxWUxTOTdONWtyQk1tVW92bDJGZnNDc1NmM2dQZEhrWTAwK1Zx?=
 =?utf-8?B?a292VDV3eXBUeFNWcjVlTjljM0hUdng0ZkltL1RrUFh0MEg2OFlTcGJGbmlJ?=
 =?utf-8?B?MC9KR2lqYXNzMjdHYmtQSy8vMHVpYnpSanI3T3dqU1gwSzlqS2ExWVFCYTZl?=
 =?utf-8?B?WDBpRkJ5MXNKMURRbTkzUGN1RytrNjdaOHhaOE40YkNmVWd1czF1SmV6TTBJ?=
 =?utf-8?B?UEJzVGwvNDh6dHhWTk5FRzZ2OW1QY0RCVVBvTTJSMXhtUWdJSmYyWStEOU0y?=
 =?utf-8?B?blJMMndjMllrVTdqWFRWMUx0ekhkcTV2QlhNZ2ZHNU1MOWFVYkhrODFxQ2Q4?=
 =?utf-8?B?c000VFNNMkJRTWdSOHV5QXFXNUVHZFZCdW1ORkRBRjQzNGdWa0pyaDlibjNy?=
 =?utf-8?B?V1lyOElPNXZ0ZlhLZHhhcXBKRTZLT3Q2NEI0ZXlIZmhPRDRDa1VtMUZqcVZR?=
 =?utf-8?B?YjZFTHNQZitadHBUN21WY1A0c3lTcFlDWEJoOXdBUktoRGVKakJ4ZWx1Zy83?=
 =?utf-8?B?aDcwbmRrWSs5OWdUS3A0bkdZbVcrMDUxWjdkbzJWOG5xQlVtZ3RSbXYwcmhn?=
 =?utf-8?B?eVBldkl5eTV0TmNLQkhOUEFQWmpsWnpJalk2ZG11d0hsZTZOajQ2RkJTcElQ?=
 =?utf-8?B?V2wwMUpSTlNuSXpXdlBLOENhNWE4WXFwT3NZNys3MEZJNGtCeFpDY0U3T1ps?=
 =?utf-8?B?c2RFWFBSSUZpTHRRTHY0c0tlQkVUN1ZOVHduOVc5dmlCRDVUTFBZTVJSUDdU?=
 =?utf-8?B?b0U5VDBwV0hNZWR1VWRqZXQ0cVBpK1B2dUNUVUR2d0p1V2tWUldkODhzbUVQ?=
 =?utf-8?B?bnFHNmlLZ3ZNNXFyZExYOWNwVkdCdTRJaFNjZUxMNXNmbXdSSkxNbTdVM01T?=
 =?utf-8?B?NFhPR3MzaHRXRWsrelBZQkY5UXBTUk80RjV1RGl1TTZWS3lxbU1aOWtHK2NE?=
 =?utf-8?B?TEZYdURHU0E1ZjVQWDltSjNnNEdqNTJ3YWh1b2dkWlZrbERUbXpwYUc3aXVO?=
 =?utf-8?B?QzFUTEh2TC9PelRSaEVuaEtUWHlXNXB2ZGZFSEFlVTltZU1KcTFyc1laN25y?=
 =?utf-8?B?WklCUGROYUJZZHlRdXZFTU55MTNWSjk5TnJyZ0JIc0psZGVqbmIzZ28rejNp?=
 =?utf-8?B?MkZOU2MxeHNZc0p5N1lnZ0RXSnkrb05EVkNFSVBXbGdhdGVZQUw4UWh6bFhz?=
 =?utf-8?B?cFBTUk00eXVpVmE3amZhLzVlMzBWQlk4YTZaTzc4OWZ3ZHJ0RThEOFd0VlVr?=
 =?utf-8?B?ZWdQY3ZNYWw5OGpnM1dMY1NYeWY1cWRndUtLTjYrSlpYRnpDUmVuNi80MXhR?=
 =?utf-8?B?L1FHb3hiS0RuMndMakQrT2IvTUlRR0hSSUZnZHQzK0xzMlZwcERTWnhlaFJm?=
 =?utf-8?B?eW83Q0QyK2tGWHg5OTZKVVg4R2tTZXhQYzZxdFhUZzRaMWhabDR4d2VDQ0py?=
 =?utf-8?B?M3liRlg5a053bGhTVE1mMlV1U0k3WW9qWlZBYzVQNTd1dmZNMVFLWC9zTFFW?=
 =?utf-8?B?QkxOM0NjYk1CQTFLQlN2a21nM3ZJS0pUdWM1ZEhVK2JGWXZvRmhHZXM0QXlt?=
 =?utf-8?B?SDNIU1hGUVB1Mm1JNC9MNjVMTytrZjJPdUJ4c0dnVS9obEtzeE1XSVZLdTR1?=
 =?utf-8?B?bTJCUm5xaW9nWWYxZlFrSEFDbmlhelhETStKdWdmYldNNkpVeVBSbFRIcGhK?=
 =?utf-8?B?UFZma3FGalUyeUw4SW9oSTVQY29jUUhlbTRjSlpkSDB5bUtyTmNSdlRDWWRH?=
 =?utf-8?B?SUhvMjVqVW1kNUpSMW52cUNmL3lDMUlYSjRWMDQ0TUQ2ZVpNUUJOODNZM3Q0?=
 =?utf-8?B?WE8vQlBiWEJ5UHJqdjdxQVllaXpCM1NndktGaFI4ZnBYV2pIQWY0WWRXMmRi?=
 =?utf-8?B?YzJTK2hnakZWR252bXlTVVBFV3plYy9jeEVVNXBuTEluc3c3RmlOczJUSmtQ?=
 =?utf-8?B?a2dYMDhFdUxmRTk4SXB5RHJMeUl3NHA3akJNb0Z6eXhoZnBka2FabFdwQ2Y4?=
 =?utf-8?B?eWZRRkp1amYrb3dKbTdwQjAzc0lJVURrSDJ6d1JWMzd5Y3dhTERJb0FvQkJW?=
 =?utf-8?B?Q2dFOVhIRVlEb3dQYWZWajJLTktXSGJXTTFGcGhFaHlPNi8zMTA2R1lWOXFL?=
 =?utf-8?B?akx0dEdTSStHYzZyRlNiUVlKb0l1eXVsMWs3TE9lMUdJWTgva25KNzcvQndm?=
 =?utf-8?Q?otaizbUyL3JfWZAA=3D?=
X-Exchange-RoutingPolicyChecked: upE6OiEWxFRKzO4WlEu3F/yyobOeoT+Q+l6DwJ2IZJ6B0Ebi+6TFdGaOsjlvICBTldvMdutzxBJQH5ncurpE/zbmLVOYih6N1c+LZpKWk3htWNpW5pK+SiVv2u3lN9Qh3gmEHN69qTpXXs8SJOtKWvGp/L3caxYEEBZQjwN6vYz51qxJc7lViWo1tEXqyjDonDA0h31XQzLKqSYfZehk3tL/0/0kaObAA38A1iOV0neiDdPUdX2/phBQ9CurzAqTCHaWExqll7xKA0x9ZnFLsaIabRqLZnQpPtCBLmdvCipy+R+P8rVEDcIuEGuHwcF+B63ih9R0H2g8ppl4vga/mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ee3575-114d-4b74-ada2-08df23902a04
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:56:59.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk7gCL5yl5Y4epVGAaih1FnJkLX9UKNxaL0ve9dYWTh7VSCwObBSf9OFPBmxUUTMwsCUMIPdTzJ/qzrMQafqpk7tcWCgQBdPIBt7V9ydy0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB168349
X-OriginatorOrg: intel.com

Hi Krzysztof,

On Fri Oct 2, 2026 at 7:33 AM CEST, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses only one
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>  1) silently wrapping the value
>  2) smaller than desired mappings produced by iommu_map_sg
>  3) leaving mapped bytes in memory (no iommu_unmap)
>
> Address this issue by adding overflow detection for scatterlist
> length field.
>
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

--=20
Best regards,
Sebastian

