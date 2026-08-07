Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8E391832;
	Fri,  7 Aug 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090616; cv=fail; b=G+oHqpU089vOVuz9uv2uhhF1kTCpaOixFrgWh0rMdGXpnGgEMccZwL0tpltFPVvPl0JqlkneNFqpOJ3NK4ich/jGXFbvotA2Coopj54vNWlUQ6d7hcp297CXMcR7wTka0YD3pO4kbQMVOxcmUigyy201tIh856LakElUkVzTuaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090616; c=relaxed/simple;
	bh=4VUWwgJN5AXPj9h4JGyBmGniUghXvk1yLN4Vkj2DPOU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+AyhfhkR2eIzqfhA0C8V7lhT8I21i6WywHxBwI3MahKdhIs85Uzy49HGCyxgz4M0ZwwA/G1ks3sMMFt6a8k2Ldw2BPEa2m/FgaFZA6gF1bOBcGA2CaNat5Q4OwRBE1Ni+DNZ+sznU8TLgsauLuTSWc5ymfz7PWBAlGPra8dJWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEsBJmPC; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEsBJmPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786090614; x=1817626614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4VUWwgJN5AXPj9h4JGyBmGniUghXvk1yLN4Vkj2DPOU=;
  b=fEsBJmPC+03ECfwqmhYOpxX9wTxCgWa1JmDKwlB+b1pLuvyu5PmPET3R
   CFQk0737/Vuyutsp30EhW2Pe+lPwbXiylyZIKajClQNwDucEj2lV5edPx
   kSodaB/XMXABcDK+9WjBdE+c5Y3aJlCAjiqWMffl+C7dCebKnaGWbvan9
   +Nr5RdTBZe3tbfuRjaMVCpTaIaJznVDLZ3R4iM3cXwgTHQ2+A+u28pXZj
   eOUqghy41CCMpmAPyJI24SUbJmPp5sPtdiR6iFAv1elXrvS7neF3vUr2H
   8BfL4LPDHK/nQ4av+1BJ24PQphsWCnuaTd5itp7xKdZkOK1Wj2piqASHw
   Q==;
X-CSE-ConnectionGUID: JtVrveIJTeaxq0iJq+2QuQ==
X-CSE-MsgGUID: 3nmzOv+8QyiRwOWwttg75Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86635135"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86635135"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 01:16:54 -0700
X-CSE-ConnectionGUID: IUqlvnxAQdWXMgWEXRAzPA==
X-CSE-MsgGUID: LLlfNQVgTcmOSYop7F66eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="266573454"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 01:16:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 01:16:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 01:16:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 01:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDclZ8CUuhYQYyEnfyK2vC0DNNjZUdCQ1Mu+Lx7kccZBHav4JTsKavdKYOhnOiDYblPtC8+TWJNwIzR6q/dl0QNNjtMqS+OPa9ASW1x+xorI8+fcIgZD/15BJ/Dex6rdTEl4/Jrz+0p5npK3PdADrWh3WbGM4EAsN9ItL3wpOwnO8gpKBjHNeyvTJq2ZkFVH1eUeVP65TOdq2Cdt5oc66osAehIlvcPuSbdcYUiZVEN72TqgB2PGt0Dq69vuS7Y0i95v2Ns7/DecNVqh9b000CgE5vozf1a4VoTYzPU/LKfqoGxlOMKo1Mbsq8DVUHpoRi7yBrjGpDzu2Nkk0y6Qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCz9Z66FXfSiTr1uQC0ELIisT0jpZY6vHI3ktHYw3aQ=;
 b=uEaz2B2ZPdqGhoETaASWUM7jk5UCLi893HATTpAhVX53kh2eRIODwi4SrVppewfwFxOwwpbehTAIXAyE6g3AblN+hut2KK8RpQ95NZ1WkRQAozWW2VK+rb9+XO4tfrs3CxJwoVG7QqXtaf7xb7Akzf4HNmHKW9q77Lnec0lkjq0lBVbn2TakORWq/DmYxqxs9AbUCtVe5kq68C/p/+X0sGspFqYJblyVIcdovmG15heIVn5LI8fP1clJMdLHq5qY3WSpfhriPq94/0MfGwljtBvpgwmkFhOnWFQTQdARQAUegfowyR9ci1p7Gvz2Wi+m1zOWYJrEOCcI2x9Nyq2a4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 08:16:45 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 08:16:45 +0000
Message-ID: <c75cb7be-b3e1-4efb-a04d-6d705ffe7245@intel.com>
Date: Fri, 7 Aug 2026 11:16:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] mmc: sdhci_am654: Fix DDR50 mode for cards without
 tuning support
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, Ulf Hansson
	<ulfh@kernel.org>, Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Pascal
 EBERHARD" <pascal.eberhard@se.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
	<stable@vger.kernel.org>
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 280ab30d-23dc-4c5a-c6fd-08def45c37fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iTIwpMJlCfO/wG4Rxak2J9Q1eorzonbMqfb/qOJwKEzUZu0J/pEOqbyIHt3IWXVfMTBHxoFYYsjcGoIuJXf155tAMlOrsWv/zSOybCjVKdhauMJOJrFyPzC2ilTQ6QjWe8W1SnJ3GnImaQk2rUWwkDsBfISp1r3fadxVnIv5dzTwnGVb0riHS1uEFiNSxMoTDhv7O+bf6vtqApu6DlKkpyMLlgSKHW1VfS0lvyJ6F96khYnmPMTyfCtX5NU/vqX4jfkj0jUr/tlsKg+ossBheOd4uWGP7KaPAc9cKNdx7idyZRFEd11hrL7c/S/yxh0lQqPFXiTN2MEvQU5MpUHOgmTrF6mM32JJTdrEu4EsVsFw53g3tWwVNcIjdjRlBvICJT3NKOVPm0iX153ehCVX+Dra54/SYB9stkQ3U5Q/8zcVWfUqB74WFJeXZYeidu0LzPwTVsa0AFzFb7808ZxH7fDCAmcb/DJPEAqs/cpGW9225s1RbYaKXvHHUPdIezbbvF/W+9CFTPap94aFu4guXhYVpW7SQAXPkidsYGFSQoiRNpqEdeFVXLx+PkUWiM6zPrmAs/QRAZqh+5FgUt+zsmc0ZiTAHgUQElRQlufGSSSsonSpKI42E2SIhxu9UEUkF/ZR7YF/6rlcF3eWgMO5DTmwlAtO6EauakItVbrPOJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0YzUDQrRmloYkptTnJzZTdTSG5rdlF5VGdseEpDckgrNVV1TkdWUFQ4aUVs?=
 =?utf-8?B?VVVUeGNwdFVZdkZWbGJzS0ZBZ0laK0lyQ1o5ekdreC9jN1p0ajAwRVNiTWR0?=
 =?utf-8?B?L0dxcG84MVBHZnVRRlhsMzh5WDZ2MjZRQkRtVlpoNlJHZVVENjJGY1lWSSsz?=
 =?utf-8?B?L1dhQnNlL0JVa3ZOMkR3WVRVem92NURBR2lyTW5xdGdOcnJpMW0xZkJmalhv?=
 =?utf-8?B?RGxBZ2VEUzJiVmlXcHI5bHI0bHlIc296b0Y4ekpIYk5KRTBJVm1TOXlTdWRG?=
 =?utf-8?B?VlBFbExvdGl2UTc2V1NYWjA3RnBod1M0YkVLM3o1TGVvbWszRSsxODhHVkZ5?=
 =?utf-8?B?dG1SVHpFby82RVlHb2ZwbVBkTXU3Qmk3V3lsNG9maFBBQXJMaHJnMUZQTnJX?=
 =?utf-8?B?R2lLU1g4aDc4dmhuUjZUSVhZS0RNYTJxaXZQMk1UTW1FelBENzlRV0VRME9s?=
 =?utf-8?B?eTh6cWM3U2szUjNVSlpFdTBlV1c1blVINXQ5ZWxEUXNTelMrc1liL050YTF2?=
 =?utf-8?B?VStWV2xPSmhVRk5EaDNvbjVmaDAybE5DNkI5UitkOXE0N0syK2czb1Rza282?=
 =?utf-8?B?cnR0UUtCRUpHd041TmY1SjhMelpwcW5JenJ5SHZtSmtnSmRpTXdKYVhXdnEw?=
 =?utf-8?B?azZSeEpWTStYSHBEcW55WUJGNjJycTFkN2JqY2tVMGxIaUZSS2ZkemRqQkpM?=
 =?utf-8?B?eHNrTnVwY2E0NkZ0dXZzc0NUbkRKSFg5TkRqd1AvclZGVXRWQkR5YkRZclRk?=
 =?utf-8?B?TlIxQ2IzcTAvRkFwNXBhMG5lbHJxKzB4V2QyaFV0aVdhTlhnRWdmMFNadk1E?=
 =?utf-8?B?dEQvaHg4cDRuVzNGYkExNkVRZVpCNDhnZzFJS3RDMzk1dVZtVWJuL3Q0MUpY?=
 =?utf-8?B?eHEzYlhjQVJuNk5hRFVZcUE0T0xBNmtpSi9GSTR3dVlBYkp5YmJwSDlOM212?=
 =?utf-8?B?dVQ2VWtXREZlRjVwRXphOEpXQVpWdGVseUpEV3FVZjQvTllDcmJ6anN5OGdr?=
 =?utf-8?B?SEdhS001ZVlPd1hPK3lTcUdpQTF1THkvYkVXTFg1a25KbVBmaW95VGJnQ1pu?=
 =?utf-8?B?U1cwdmk0N2FjcTNTWWkvTjJCcUxDdEUyL0xRS2NOWnJjQ0ZtNVhYRmpmVStx?=
 =?utf-8?B?STV5UXl2Uk1kQkFkL3lTbmRwbEtoM1pCZlZ6akhGK3Y2QWp5Z0NPNWxBbjNs?=
 =?utf-8?B?V04ycVVhc2h2TVJmaEJtM0l5elRlRCtFQWxDT21pTTNTMlNQS1FVYkh2Q0U5?=
 =?utf-8?B?TS9GbEQ4enE5MnpDNUM5cEhCaDE1Q0RMN1htcmF1ZzNGeHVvVXJuOTh5UHBx?=
 =?utf-8?B?NlRubmNNUThhV04yd2NDZGlkcUNPQ3QvRDJROGdaYXJXQ2RoeGh5Q0I0Szl0?=
 =?utf-8?B?M1FKaEFTQnRBRnptay94VUs4SWZaSVR2SkJPcitaNHU1NDlIVUk3VGZqVGZJ?=
 =?utf-8?B?WXF4bG1OMExPaWR1MzF3RjhVOE9UdTFDejN2Q2ZtUnU1SksxYm15Wk9MZGdU?=
 =?utf-8?B?RXIrYW8vL2JFNm9CaFdEempGNlhnT01YSHR5RitMUHdZQXROMVBJWklFRjJx?=
 =?utf-8?B?OGxmeWxLZEJxclpDWjcrVlFrYlo2aG9CNXV3Uzhadms2TG5NTmsycENLbXVK?=
 =?utf-8?B?Yi9OQkFibDVlQWFVcTBxeVAwTFV2WlN6K0RqTXVGc1NiVWVnMlhYTkM4UDhy?=
 =?utf-8?B?OUFsTjUvenJPZjc3SU1hTXVyczhKWmM1YmFyMmo1VFNnSHNkZHlWcTVFZkps?=
 =?utf-8?B?ZVhRODVHS2gvcitaQUpwdUN2anc5K2ozd2N6YjA3UEdDOWNzNGV6RkVrYjhJ?=
 =?utf-8?B?TlRZejV5cDRXUXBINjdYRnl1Tm5HemZzSlJuSHI1a3lneTc2K0Q0UzJJN0FZ?=
 =?utf-8?B?Z0VJd3M3UWkwOU5qeTlNSDZQb0RuU2l4VW1yNHI1bDZWaTJwanhQWkxKam9T?=
 =?utf-8?B?N2Ivc2M1MUgwdzYwbFJwOUt2WGlnZWNtYyt1ZDlBUUNrMUhVUDhrQVh1Y2JW?=
 =?utf-8?B?QUZlOEpONXJyZm9FQmNIVTcvQXJjSW5PRGZTQ1BkTVBGU1RCNHYra2czVksz?=
 =?utf-8?B?YjgwNyt2Y3ZNaXRqZVFrL2lpQlJWZGlvUTNBMjlLcEVpNG0wdGJNeFZsN0pX?=
 =?utf-8?B?Q1Y0endCQWtMaDNicytRcTBBKzYvL2ExcEV2bmhRQWU1WEJuZHR1TmlhUW1x?=
 =?utf-8?B?NnFiTGZUWXFpTnRabWE3cjcvblc4VGROS2lQd3RjY3paamNyNmp5Q0Rqb3lu?=
 =?utf-8?B?d3FXWHFKUld0QTl6cjBDWUVVek1JZk11Z2FjcmZRWW1rNEgzdEJnRCtOdk5D?=
 =?utf-8?B?TFV6MHp1YUFEMmhFWFNKc0M1bGs2dloyNnZWZmhRRlQrc3hiV2pNbzRtV1g4?=
 =?utf-8?Q?iW8t2DHK0+/0SFPc=3D?=
X-Exchange-RoutingPolicyChecked: SAf2PptKzToYbRg7fzbJLxLlCjGM4Mibw5/R+tS+HNOvwhmIjTJTP+Pg6/qDcoAPCHLS+xOTVlbJsyuE3cllTETW7BGND8xS6hPAeexIHmJOf0T7Re0jVUuVl6gwmgowlJo18IcpWr9vtxfwL2lLzN9ccI46qTu5q3vI9HW7wykFCsS6cNP4c0vCbBPKtIStdDdj7Rxp6QXriZZa+5iTvdhxeyYbMLgvDiEAqQuT5RMVtfSH9ONDaTa/IpeYKMhHljEdagrqh5WQcANmUIYxcfFuLhVw7pmr66yHInOfKCQ7aXfUvFzuR8QNURo5jswZkBWMaLW6NS6vi7XvxApGig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 280ab30d-23dc-4c5a-c6fd-08def45c37fb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 08:16:44.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjHy2ySRws952erAt0frWKnQbivd1TMwy081bXaKIDGsGFCvbK1kAwUQxJQ0NH6cQLOWl9VC221cMF3d83ZxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

On 03/08/2026 16:47, Diogo Ivo (Schneider Electric) wrote:
> DDR50 mode is not required to support the tuning command CMD19 by the
> eMMC/SD specification, meaning that calibration may fail on cards that
> do not implement it. This series fixes four issues discovered when
> using such cards:
> 
>   - Patch 1 moves the tuning_loop counter from a persistent struct field
>     to a local variable, preventing failed tuning attempts from depleting
>     the retry budget across calls.
> 
>   - Patch 2 ensures the command/data line reset is always performed
>     after tuning, even on failure, preventing stale data in the
>     controller buffer.
> 
>   - Patch 3 clears the ITAPDLY enable and delay values on tuning
>     failure so that leftover calibration values do not interfere with
>     subsequent I/O.
> 
>   - Patch 4 falls back to the DT-provided itap delay value for DDR50
>     when tuning fails in this mode, making a best-effort attempt at a
>     known-good delay being programmed.
> 
> Together these changes make DDR50 functional on TI J721E SoCs with
> cards that lack CMD19 tuning support. This second version addresses
> all comments from Sashiko, which I found to be correct.
> 
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>

For all 4:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - Add new patch moving tuning_loop to a local variable (Patch 1)
> - Clear ITAPDLY array values alongside HW registers on tuning failure (Patch 3)
> - Save DT-provided itap delay values for DDR50 in dedicated variables
>   to preserve them across tuning cycles (Patch 4)
> - Link to v1: https://patch.msgid.link/20260729-am654-sdhci-v1-0-7568108e4b9a@bootlin.com
> 
> ---
> Diogo Ivo (Schneider Electric) (4):
>       mmc: sdhci_am654: Move tuning_loop to local variable
>       mmc: sdhci_am654: Reset command and data lines on failed tuning
>       mmc: sdhci_am654: Clear ITAPDLY on tuning failure
>       mmc: sdhci_am654: Fallback to DT-provided itap delay on DDR50 tuning failure
> 
>  drivers/mmc/host/sdhci_am654.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> ---
> base-commit: f932188d6b0b684ee8555c8ecf1cac3567c4b106
> change-id: 20260728-am654-sdhci-85094d458bae
> 
> Best regards,
> --  
> Diogo Ivo <diogo.ivo@bootlin.com>
> 

