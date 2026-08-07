Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115D361965;
	Fri,  7 Aug 2026 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084541; cv=fail; b=ZzmZZnzrujbGBns0AM0Kc6+UMZl8fVNLMQI5phlvSCJcoceVTCvfcn+80Al61Um7LiWLpUXU7E08b/W6lAnAvMJ0DHmNB1IdQkSnzQVrhF0uzTQKOCaXltlTjExWur3ffQeqxdbbk3m7Pgsd9qU+Z3avXCDhk7IzBLeid1uSN3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084541; c=relaxed/simple;
	bh=L8GpHu7ByGnG7P3ILdYUwb+8R60dZCyhOuzqMlhdVwc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UkfG2GeuRugSya5Cjqn83L8PbcUjbVy/pIqidg9sfuVOmaI1exib6iGnMzVOckJnecR60+SvVe7cHhWoeskSfrvn+qdThFwOhcX4EgddcFzqpktvGxxItQsSA/zGkTJOpAxKSf7uLDHH5DQvtqMtlEvu02CMwdE09nFvVkin3BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9inmq4E; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9inmq4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786084539; x=1817620539;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L8GpHu7ByGnG7P3ILdYUwb+8R60dZCyhOuzqMlhdVwc=;
  b=D9inmq4E4mo6oNVskXNDbGmMsCFWtT4scYMzsTo1IOwc8oX6qARABPVg
   IWBkerp/iVjGp6xT7xbVG9Sl4cClObsXMPBnEj2glx4xMbI4MXxpTplcs
   NaBbuE5/9pneNsCClQ8MmJL6GYsf5P+Hlt11CZMaHNEJpub89BCYovwKq
   +X4HN2uQxK4zOBIFbCEnRpgrl20jDwlxXQV8hS8Qo7rqzMe2WWpQ12pXP
   bxyoeDDvgGHzQomlVFhghh5vg6LiM9M22Go4EYJUzvx3nXBPiepTSX0Bo
   sH3zVM0AhEN/E0qf9T1u7C69zw2x66cEH872JJ4smMUjDhz5yBqEL4PPD
   g==;
X-CSE-ConnectionGUID: s7wKbPp4RaqHBdhu8JKDdw==
X-CSE-MsgGUID: +iAJVpzBQPu3mfOcJ0FmIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74229017"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="74229017"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 23:35:39 -0700
X-CSE-ConnectionGUID: W9Nspq/iSnm2C9QdYZQ02w==
X-CSE-MsgGUID: edvosnwkTvCcoiRZxu1i7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="262371433"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 23:35:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 23:35:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 23:35:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 23:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ews4ymo+CXkFiu8D6aSoRBmLrC/bmM4Z2EWIHeyNnP1ebWjOGhGWhUi1w2nySinuX+67z1x07jWBMwZcrttN9QLw4Vla4Zs7UKng6eW5DY9sI9j4Yjln2nzTMlSXv/5y9WtiHSlv5PxfwowHpCxKTo/9AeKM+5bEKLx6LwDmj8FdZ88TP+EufdoSvXD+2SaNRjHFrqP8xIiJY5wbbRGA1CTbRnERMIJvbXXjKMjgG9R3q+ejpOD4FrYTFKTXF1Qb5HcTc8VZZouhJNhgHH1Xan1OeHIqIdLBB9OXg08RbEhfpyDmtgmGoIkxN/MWVpV0PWQgx2a4v/4Pg6SGxEsniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BU+1LIbDvOGdvnjGZT6LOayDquAlEZrh9awcQUTfYc=;
 b=qjAFChtwC4XmY0QIsYgY92jFZoxVyVMIZaFowWyBK2uhLvJzbvbFVz5DQOIpGT0EvxCH3HGLLzz7UuMXf02w8cTYTjOO7WuEaehRtSbNhadLcJlbPN90jLQkxox1JZl91JzyWwasZAf7hjtE5fa3ThuccdErBOiGRsaDtVm+C1B0kW2mvUtwYHzxuLiGkkWDdkDtcxGcmCtchwg4jhyBlo/C+dXBTGYohQ6N1nrc9xzujxFM969X40oNKssp+7IbYHcawrccAZrdHyFl54K8xsdnwoCyl7yC9zWNNNLSJIGTs64mxxxezKeThsD3GEzFMtHjWaAPQDJqrbPPTVvvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by PH7PR11MB5794.namprd11.prod.outlook.com (2603:10b6:510:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 06:35:34 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 06:35:34 +0000
Message-ID: <fe3c58b1-5b34-444c-8149-e9a836f0a303@intel.com>
Date: Fri, 7 Aug 2026 09:35:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
To: "Mendez, Judith" <jm@ti.com>, Diogo Ivo <diogo.ivo@bootlin.com>, "Ulf
 Hansson" <ulfh@kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Pascal
 EBERHARD" <pascal.eberhard@se.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
	<stable@vger.kernel.org>
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
 <20260803-am654-sdhci-v2-4-a5ee5be86133@bootlin.com>
 <4721675e-e3ae-4e81-89db-eb0f7f419d1e@ti.com>
 <6fc6216a-5e57-4df5-9033-d3573409ed78@bootlin.com>
 <9cdf448b-436c-404f-bf72-b946204629a8@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <9cdf448b-436c-404f-bf72-b946204629a8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::34) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|PH7PR11MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d99ffed-73c5-474d-b815-08def44e154f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 32fyuz7kesySnxOoa7m8V7vxczu5sFhpisWIqbxSRjZkWViQSh3PYwjwgSU1oKYVuiTjzA14TKDHBlrrHiZsrg/XLd9K/rQcp+tup7UQ6et6UyBM3+wXuDEcmDNW8QpUtNldpKhygxFXiVFXhVQQSi49t2Xy64nQgAlbrYFe4O4gx7TgNPKd2S0yPmcrwI5y7fW/QLF/9lL9htThckOyhytoxnXVUjTxt7oNCT137KNWtYMUkXpYazT/xM3kVmgGS+Vvx0Nxh1T5Sk5yn/PCuVJflJdCAE6blak7A0ukvb7Wv9TVeYzSY/w/MilinCbCIE2CyNBmTyMOJ/YEZi2yRpWirUhW8CnF6PRQ5pY7VvgSQdLy5+MZEmc99bdVhgnpT8UxjFRiHN8s9Je3RvN8qZVSLkB33RZcXb/OPC9FgzC4wshIcoTdGZz98/cuLyn3qzDJXeurSaNszFTwOz8SCeh/bJmLp03UBhCBCbDGpxTdoLCvwNS3+1F1flrpQ/dY62HFduTnKNHh1KV1QO0o06sDOd4dLWL3hghkeLzCOU+Xa8rflaZYrJO95qptfzjecoB1OdouzT0ceCGcOPZn7W3dVeOKTfvxkn9s3GEDvCxdKETHgo39P3dCDzm/w/tT/ykVDIb3XjZxBw7YLoorZ6UZlZuLGV6DPDsbrfJj+mQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNTdEtYejdBS2NIVmV4NDNsY0NpMEJ4LzhEUjdCcVFsWWgwUGhZdmRnWkVn?=
 =?utf-8?B?Mmk5RE9iR0gwekZyNEQvVkFzc3A2MU5WcXFYVFd0OUlwZHJQVmVEVVNReDg1?=
 =?utf-8?B?TmcvclFycnFFQU9CQXk1eFRmaEJ3TjdGRWVXbk45RWZvZXB2OTlsdkFEL1gw?=
 =?utf-8?B?cXlHWDZ1bkZjazgwcmRUTVZTeU1vKzdCbUl6QU5CRW00WlpUYU1rQktkVWpE?=
 =?utf-8?B?MDVQaFZYWkN0bGtqaXhlajhSQUpoTHlrSEp0bTA1WUxIRWxQYkw3ekRhenY4?=
 =?utf-8?B?ZHhwWHZoOE40bXpZNXI4Q3hqSS9Ld0QxSWdTQUsrM2h5MzZIR0lBQk1hWnVu?=
 =?utf-8?B?SE0rV3lqSmxOK2g4Mmx6TXhzL3p3Z1pxdGtXMnJ6MWYvZFNjbSsrM1dMeVRi?=
 =?utf-8?B?a3RvUzZLbDZPang3MlJ3R3VlNGpWbzl5Syt0ZmlqS1N5VmU0UVcxZHFyREcr?=
 =?utf-8?B?SHBEWk4wb0tYNTh5dEtvNHJiV3N3SUs1aGhoU0xmUnN0ckxEMTRVR1J0WU55?=
 =?utf-8?B?VVhnTkUvUklYV29SNURDemVLSTRzLzJBMmFIWWk4ZW0zUStrcWV1ZDN1c3c3?=
 =?utf-8?B?S0l0VUljdzN6MEpjbUtmZUNjQUNud094WUhRVzJtdG1LTS82TWtJakpEZmI5?=
 =?utf-8?B?YXcvUDljR2pOR2JtcUM0TVJjaEZPekZtdEQ3aTUvVFJKR2d1ZmlZalpjU1hW?=
 =?utf-8?B?T0x6NkdScC9Ieml2dEZTSEJKa0MwL1BTV3RoeVVldStJaVpZZFNiMEFPL1hm?=
 =?utf-8?B?eU8xTmNtTVNKZUZJUWRPczhLeHZCd3VUZmZHR1crSU9VMW40TzduMHgzeEl4?=
 =?utf-8?B?MHAxWXVENmpiUVIzZFJlb1l4cGlzdkY1SHdYZnV0M1hISk1sZWpieWRFYW5x?=
 =?utf-8?B?T3JSUGJXOElpV05pbmgzUjJtbzNRUDdUWW1BYjdjMFBNTDh3SmtWUDZTSlJH?=
 =?utf-8?B?WXFQNnN4Q1h5SGFaMmtDeDJEbCtjR3RTQUdOUUp6bDhuWUtsUkE4bUhqSWo0?=
 =?utf-8?B?eVJna3NFUW1VY1Zxc216eGtpZEhtMjRxVDRWanpoajBtK1RZSURJTUJaWmV3?=
 =?utf-8?B?QlhEd241dDU1aVZDZ1k4MnpCU1Iya243QW5iNEd1MnVLM1hGV1FjNFVvWjFt?=
 =?utf-8?B?dHVmQWZxUHlOd1FoY3VVblNBQkM3ekJEbUUveElBY0UvQi95WjhIUkpTbml4?=
 =?utf-8?B?WjAyUDhUTWlrcUthRXZqOG1JOVpaNjR0b2piam9kc3Nvc2RGMm1WeXN4aCtR?=
 =?utf-8?B?NURzSnAwYW1NSGRLRklpWnFtTnl3Wm9lZ2NqUmpyN2llbXlVK0VTMFNoOWUx?=
 =?utf-8?B?QzFVRzZtQXJadnMzRWJWaEpmR3dnVUY3U0RFcnVuQ3B6NkJjeXZ3TzkwSm9k?=
 =?utf-8?B?WkZCVnlhaitaM2FEREFXTHNUNXFrNXFqS0hQSHVnbDRNRGRNampxaExwRlN5?=
 =?utf-8?B?Z0doNExkaFlzZklxd2NScjh6S0NyRURVRVJyRS8rSDc5VlBWWnRKQjlOdE05?=
 =?utf-8?B?QzcxVmE4YzQ0Z2liNWFHMmR3bGpWVkh6a1BsY1c4bERET29hME9EcERSakJR?=
 =?utf-8?B?M3FySHJjYjhURk5LZjU5VGg5eG9tbURBOTZ6RHlyci94SnBlMjVDMFB5U0Y4?=
 =?utf-8?B?dVl4QWdOTGQvTnlTRVZ2c1hYd0NBb3dNelovc3RUVmFNTzA4LzJXK3lDWmMx?=
 =?utf-8?B?WWdySUtFVFhrdC9kSlNXa2ZJSU1BVFlFYTQyWUx2by9JMFpnMHFlb1dNQ2Uy?=
 =?utf-8?B?T3FXT3g5Ulo4Z3Y1TFdjWXV0RU1Ed254bG9wWm9Jb0FtbWFiUjd3SGM5RE5M?=
 =?utf-8?B?T3FMbGtLbG9Oc2pMb3B6bHZKamE0cU9HSTcrUm91U0h3eVRNSkFjV1Q5c25r?=
 =?utf-8?B?VEdUYzNKQzRsYk9ZTkhiSkovcUVreGx0Q2VKVWhZRDE0SVRpZ2U5M0tSdDZB?=
 =?utf-8?B?TG94Q1hsY2FiUnN6WkRSb0ZMQ2FaZTlsUE52c0pqQ2ludGdqcmwwdWJWZllG?=
 =?utf-8?B?cnR2dm1xRHFMVkVIMHRKVVBpTEQ4UXpqQjgwM1BXVTZuVDRCVlNWK3plQXZa?=
 =?utf-8?B?d3YybTEwVlFGRFUwS1FSNHlmaUo3ZnU2cU9PUWZyZzJucERLZkZlcmtGL1Vn?=
 =?utf-8?B?aFRqcWlwRnNMMnlaQmZVWnJtNmlLMFl1QU9lZlhWSkZIKytIWEc0cHJRVC8z?=
 =?utf-8?B?NkNGdWxIVFlMUEhDekE1cjlGSEQwakp5b0doMjJ4TDJxNUg2d1ZJdVlUKzBw?=
 =?utf-8?B?T3NYZEEySUpJUUtvOGJyTUFJSjBjOUNaUitKODBMTGtmK3lQMUlwV3VtK1Fv?=
 =?utf-8?B?QXVadzRKR2l3Z3c2RWYvM213VWxveFR4Qk9KbGFOT1Q3NG9Hd2lnN25nRUlV?=
 =?utf-8?Q?rg9SaJbt9hurTaG0=3D?=
X-Exchange-RoutingPolicyChecked: JRBWs+7kxAWCUXDQmqLr3yuOPPpfZEsvDhPTNiGb+yOhgO4tK7KWUtQNy0nCf4L/aqlFSgnz8UyR9S728EQTKtMh1wY3H9zrEobMnKCJVZic3fEKbiYIayZTtBGJr/0qc+Rl145dVc8LGUfVwSHYFccenOeGhF+jMMwbDd4YAdjXvKdSxtWsJcMgObRUGEht1DUy3BwRGhmwj8MaGq6ZaMnzwUIlDM1Egu7w/0uKw1yRDTpRZfB7I5JSaM6Qt/FkDdoHAAA9mMkPdN3tk69NKDPJAsCNOVT8Fsh1pN7QIav+6s5DT0LidifqHFxXgJrkEA1q8Tgdg6W/4I4kC+sgrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d99ffed-73c5-474d-b815-08def44e154f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:35:34.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scH8TVkbBBhW7w/dyMKOOazIj2o07Dxz0H9BqKvM+gawtPFtVYFiLsR9RmhPtVbsqbYAu/PQs8SEr6nEv5f9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5794
X-OriginatorOrg: intel.com

On 06/08/2026 02:13, Mendez, Judith wrote:
> Hi Diogo,
> 
> On 8/4/2026 3:45 AM, Diogo Ivo wrote:
>> Hi Judith,
>>
>> Thanks for the review!
>>
>> On 8/3/26 9:59 PM, Mendez, Judith wrote:
>>> Hi Diogo,
>>>
>>> Thanks for your patch, couple of doubts below.
>>>
>>> On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
>>>> DDR50 mode is not required to support the tuning command CMD19, meaning
>>>> that calibration may fail on cards that do not implement it, in which
>>>> case a known-good itap delay value should be programmed into the host
>>>> controller.
>>>>
>>>> Do this by reading the (already defined) itap delay DT property for DDR50
>>>> and, if tuning fails for this mode, fall back to the DT-provided itap delay
>>>> value. If the DT does not provide a value for DDR50 fallback then this
>>>> simply disables using itapdly.
>>>>
>>>> Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
>>>
>>> Should this commit be the one to blame or should it be the commit that
>>> introduces DDR50 support?
>>
>> I'm not sure I follow you here, as I wasn't able to pinpoint a commit
>> that specifically introduced support for DDR50. Could you please clarify?
>>
>> Taking a look at the git log of the driver I see a0a62497f6aa, where
>> reading itapdly from DT was added but without reading the DDR50 value
>> and 13ebeae68ac9, the commit where tuning was originally added, but the
>> "responsibility" seems split between the two.
> 
> Yea I think because each of the three commits in question are adding
> support for something else. This bug fix that you are sending was never
> really discovered or debugged before. IMO (: Not sure if this requires
> a fixes tag then.
> 
> I will let Adrian or someone else decide what to do here. ^.^

The Fixes tag tells people whether they might need to backport the
patch.  It says "if you need Fixes commit then you need this commit too".

It should be the first commit where DDR50 could fail because of this issue.

> 
> ~ Judith
> 
>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
>>>> ---
>>>> Changes in v2:
>>>>   - As suggested by Sashiko save values read from DT for DDR50 in separate
>>>>     variables in order to keep them across multiple tuning cycles without
>>>>     overwriting them.
>>>> ---
>>>>   drivers/mmc/host/sdhci_am654.c | 25 ++++++++++++++++++++-----
>>>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/ sdhci_am654.c
>>>> index 8ce10422bba0..27ef79420eba 100644
>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>> @@ -126,7 +126,7 @@ static const struct timing_data td[] = {
>>>>                      NULL,
>>>>                      MMC_CAP_UHS_SDR104},
>>>>       [MMC_TIMING_UHS_DDR50]    = {"ti,otap-del-sel-ddr50",
>>>> -                   NULL,
>>>> +                   "ti,itap-del-sel-ddr50",
>>>>                      MMC_CAP_UHS_DDR50},
>>>>       [MMC_TIMING_MMC_DDR52]    = {"ti,otap-del-sel-ddr52",
>>>>                      "ti,itap-del-sel-ddr52",
>>>> @@ -144,6 +144,8 @@ struct sdhci_am654_data {
>>>>       u32 otap_del_sel[ARRAY_SIZE(td)];
>>>>       u32 itap_del_sel[ARRAY_SIZE(td)];
>>>>       u32 itap_del_ena[ARRAY_SIZE(td)];
>>>> +    u32 itap_del_sel_dt_ddr50;
>>>> +    u32 itap_del_ena_dt_ddr50;
>>>>       int clkbuf_sel;
>>>>       int trm_icp;
>>>>       int drv_strength;
>>>> @@ -579,10 +581,18 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>>>       } while (++tuning_loop < RETRY_TUNING_MAX);
>>>>       if (itapdly < 0) {
>>>> -        dev_err(dev, "Failed to find itapdly, fail tuning\n");
>>>> -        sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
>>>> -        sdhci_am654->itap_del_ena[timing] = 0;
>>>> -        sdhci_am654->itap_del_sel[timing] = 0;
>>>> +        if (timing == MMC_TIMING_UHS_DDR50) {
>>>
>>> Should dev_dbg be added here to let the user know that tuning failed but
>>> DT defaults were set?
>>
>> That sounds useful, I'll add a print here.
>>
>>> ~ Judith
>>>
>>
>> Best regards,
>> Diogo
> 

