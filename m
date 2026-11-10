Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794324886;
	b=4fHeLjqi2sYmMpEUevIu4F7SieD13yOePuMjFBGdhGUfAtT+EUHuDD5fxK8nb+ki7kDS
	 Gzs45xK7NRTdqT7NIUcWlxnRrQYij0TFboisNtQ5iOoYY9IbGcvNHcnlw8erVe11pkzrL
	 CkKPlqA0csmwyaADvxyf9b/aZR6QIncNKmNhgmKGLfOjHxskMr4judIBy4o4gV4hOSyjD
	 CRW7Ig3skNEXdewpmCOShWtHULadVQfmEkPgbJ7DxcyTsghgYO6gGOxDuJu9UDlYcwRQp
	 bbtddBJHEso7cIImaFYf6ulBdBHgjO3Mt86EzMWslmHcRppBGhKmfJTWunHhO6kl7xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324886;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=P1nQLMthzVpeBQjmmOl47vr4/H8MHbpo3fWlv9TrWy0=;
	b=5H0PtO+QYShko9+ftapBhh4tOTtPOYZVG4dfLUnCqN9RG9+cOL7jidFEdSlaQaU6jMwg
	 AqHTPeRsaNkBDVVASrP/ARGMvGzH8O6UOTlQSb/CS9gB1XHsA40PXEYBPImFcD9XX5fiW
	 KmxEBGO2ZiYCL52ERc5WiKuot28Jbx9xyE9dA14nsJ4Q+O+4MLMJNqnxPVbh9zEVxVEED
	 tfPUxeSOWgG73M/jvzpnbgcNkR1tmaSTEAl0lVmzCkFdkELUQEl3Bx+17LPos3YW775Lf
	 wCySS3RydL1ozJZnoCysbzB9R9b/s3oIC7ucT5swMc73vMXUsV5XDgxBLY/oexwgRnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kIO2VYQU;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E436606A321;
	Tue, 10 Nov 2026 15:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E436606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kIO2VYQU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794324887; x=1825860887;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6HZNrucCY46zTu9mWZQ5sUUhwPDXm3vVtQJ7RWJpVKA=;
  b=kIO2VYQUV96C65lav0GuW8IIGYLiAH47jEE3kfh4IwBhSon/3J6t+JHy
   sB2rlxCrQCVfLV6i803Sl4ZZCB5Z8S/N7CR7OfPFbdHuNmMiP+7S3fXI+
   XPkXklk27fekrKnQpfVAYaj/RGQnnZ7koUJoQT7csOZhQQU96pu2uos02
   MHrXGVmwN8Z4f3+kObkzSP68/SFwo4rkRYgQkvJf9iJ+68PNDDSQEZ6hm
   kRAZ4uWkPWDlRJAxX2eIWkI0OZqJ7J2oXDR847r7YzUV20Eu8RUyazJ4Y
   sFxqIbMlXRBZvrpGRp2YjCr7eHLYDsFCGfUhJ0Rq5irRufRBXu0Cs4qhm
   Q==;
X-CSE-ConnectionGUID: mOQK0rwDSO6rMDk3iJnW2A==
X-CSE-MsgGUID: aXMARX2zSPyZtpvsTLmo/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3105357"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3105357"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 07:34:46 -0800
X-CSE-ConnectionGUID: iCtbAX+GQNaMptqsNrbkxA==
X-CSE-MsgGUID: jjlzzT5CRU+WKiMsMG9Pxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8505514"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 07:34:46 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:34:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 07:34:45 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:34:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcjhQILCllI2kHaF3VdxVuAg1CqxGQtf+266yUcwCwBV6VErpo6FRVVhDrEgtW8nu6ZYJJi9p1TSnHrgmk6Dcyyuw3vP8B+voEAD96uPjMZw+sFif3vbK9J4lrwkrzN7P4PS1cbYrLQCV5srW86iqJrqQUNRHk02dvlx2HJn6WuNtFdcZllL9rOOWfpppirsIGwK4eH7+wx1rDsBUkNJHN0e3trGmIJDTqJiFjGDH9nfi7fUOgaJuPq7SyQ3Qbp26f2FCXZiNqIw+AeMDh1dndZF3dbQHpNzMxfqELTax7hCsjNTSD3M6EydQdPeZR5N1QA5ohw1pQLIYps3wnRrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1nQLMthzVpeBQjmmOl47vr4/H8MHbpo3fWlv9TrWy0=;
 b=LohhoO0WAmt6kPeX1z/7Rb7DkKY1HhhZbKtiThRuC8FyO+1y3O93gYymNG7S/qDHFpP+qhwCEh8yD2XN5IM7HdVX/NOW6OsbDoj3njSYMnUx9prBLXRndHZL6oXwtyqS01FA7QzP0UQmMf08TZF0sbl7AqZO+0/xBIeIsJjiR3+E37k+XBKXCCNrf/tNOMgSIxVpDDlvBe2trGPs51WuaEUaJsQCbGxkjIHat7kbYNAJoB5jdF8kTq2lZpMJIbdQZXgoTQA+zEsNNbHI3wnZoo3rKUCJScAbqeRndVRDJTFPS+7zFQLxMBpv8THJtO7deUveLdUAqNmMFRp0623UEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:34:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0592.009; Tue, 10 Nov 2026
 15:34:34 +0000
Message-ID: <d4808e61-6836-4a44-a102-c488bee49762@intel.com>
Date: Tue, 10 Nov 2026 16:34:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: fix Rx byte accounting for dropped XDP
 frames
To: <Dominik.Dvorak@econ.muni.cz>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>, <stable@vger.kernel.org>
References: <20261109-ice-xdp-rx-bytes-v2-1-7d6035e687e2@econ.muni.cz>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261109-ice-xdp-rx-bytes-v2-1-7d6035e687e2@econ.muni.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 2576c2a9-4687-40b5-4046-08df3f401ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261021121427099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: AC+E9u8Mjmkfd2sPqGhJ8l8zqYHEixDMR0S9+6F5YjC6CS+8nLuXG3BFybdRSuyayRZXbctNmdhQfFQYYHtSJKmsmSoDSvl5Qh6mSPtgQ5oKWsb/g3EO5N3cmzBDlhaNZ4CxXOUPP/EfTaosO6bggZm6Tlz2+CXhA+tnt48Ryo0WPvTfg8timvSFiL7XCMd9TMAr5ax6SkRxcS+nXhXiB9GZEXB2MkdMzB7W01Zb9hbKgdSICurJNwaZYPkxlJzm4tKUGzLZzsDnj9p7n3acFQplsoUsAmCxLSLkMiQcSibnykKuUEhmKtoGY9IcFYfOtEPeb7ClX/pE+08YVvD1dzUq+cvr6uRELuUA+RFLsdXq/RSTKpgD9uLr7ibR3fhPd0nJluTZCrrcixwgE9JHMx0l9JXgD+duYjFUiwe3rbXcBmu/hSsf9hvrpTX5apeE3Ab7WWoM2kBVHCx2up2bEUGPZ49nDMsjA3zGc/L7QQvrlgJbNN3F556veicpPwrxB2LN+ZGBkabmeRYfuJ9S6gciC5UyRBgVoYGRS2B/AKb+4+zCqa2fS/Yf1IV09+2UIOmUSdMHKq1NCF7889oXgp/9DK8vcKhoK3OmY2C7o9bvLoVpHsuQ8YjHynK/QVEc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBoQzRPODNDYXlpS24yK0gxMS9wRnJKd3lITXFMbFBia3MrYklmVXdVNnhw?=
 =?utf-8?B?aGk3MG5YLzJwb0l1Q3lZUVcvQUdDKzVxckdBZWpxTzEwTXgrMitGU3BzQmNT?=
 =?utf-8?B?VnFuaTlVdkZiRHZzeFo0d0dOSE1hd0p4NmtIcEFTN21BWjMwM2p6UEtGWVlW?=
 =?utf-8?B?WEpXV0xVZVkvMTJNWTd0UkIvYWdnUUxsY0dQUmQ5bUZBRER0cEdWd1pXTGdM?=
 =?utf-8?B?V1N6anZLQjhJNllEbmNUSEgxSy9UdHhOYTRrU2tQb0x3VE4zR3F3N3JBaWZM?=
 =?utf-8?B?eFFpeTVYL0tnWmhDWVJ4cVFpeTZJcEZoYmk2eWZtN0pFYXRXelJ4SlNtMUQy?=
 =?utf-8?B?eDlPU2FLNFl6WUhPMFdPamNPR1JPamwxeDFxQ2loZzFKR3JCdG5SWDZpWWNZ?=
 =?utf-8?B?bVhsT2o3ZG00dmxkSXpIRE80WmwvYnYySExwNlN5WDNiRkhrbHlDVWhlWEpw?=
 =?utf-8?B?bFRXYkFLYkJUZGJ4dTg0ZzM3L0hOZVludHhWcnZLQm5PdVdpN0pzT09OR0o3?=
 =?utf-8?B?RTlkOFp4Y04yS3BMUEdEMlYyclRzUWZQd2VZU0dxRHdoMSsydkJ2czdtQjMw?=
 =?utf-8?B?cTRFOFFJNHhDZHJrK1FWZGJxYk50RXhidEEwMlNzNitydzhEUDdFUkdBNVdV?=
 =?utf-8?B?ODJuRzIycjBoNzR1VEV4T1luWmF1bDRkQ2pydHdsMjFwV0N2TkFiaGtiME0w?=
 =?utf-8?B?ejVtN1JBY0hYVWdVaXZuZ2ora3o5MmxCVmxEZTdaWkEza1l1RnY0cEtiWUhT?=
 =?utf-8?B?UkhGZXRqTXgxbU93eEdnQlFUbkU0dU9UbmV3ZjcrTFFpTlNwbWljUkxBdWVM?=
 =?utf-8?B?a3lxaENSMUcyRDkvLzRHL2M2Y2JZNWFqUHhCMStrNERFQURXMWdtNDVtSGhr?=
 =?utf-8?B?QXRQbzRmZXpTNWFqVnBpd1BqeXBMMVFSbHU1c1AyWSsrK3ljLzJLM1RTeDgx?=
 =?utf-8?B?bFp1QUl1dE83ODgzRm1RVkNBdlZvVjJ6QVNldkRxVU82RDV6L3dNUmdvYkdv?=
 =?utf-8?B?VlcxR0FWU0tyR1RQSmdSUisyd3NVd2dSQnBGVFhIMllaWG1xZVhtbWhsM2JQ?=
 =?utf-8?B?NXFCQktibFRIVWVVTGV1V1pUSElYVFh3U1haN3p4b3BGZWFHUkxBMkIxWXVQ?=
 =?utf-8?B?V3c1TE84ZnhLWHNiSFZTdGhMcWYvWkQwaDFXdWtCVTFobElXT3orbUJJWnZy?=
 =?utf-8?B?alIyeUJLbitYRGJVS0JOVmRtR20waUNUaU5GWlVob21PdldNVFlDZ2pxVTJP?=
 =?utf-8?B?V0JiRTBUcG0xNzlEWGlsUGZLWUVIWXAxVENEVXVTSkoyK1pmTGtaWnhKdDJw?=
 =?utf-8?B?cVJYVVB3bTE0anY1ckRrcm1HVnliZ3hGV3o2VnpRVW5MQ0VVSkNuNmU1VUFM?=
 =?utf-8?B?NHRjSGF4ZnVjc2FBZHB6ZFdQNFJOWjBmV3Z0WVBEcS9Td29YM3J4SGVkUGJR?=
 =?utf-8?B?K3Q1TXA3ZTZ0d3Rzc1FIMHQ2SE9VL3ZCc1VYREs3WXowMXQwb1FacnRVcGI2?=
 =?utf-8?B?b3BKS1pRUmlkbEhaN09VM0JOUGQvcm9HcHV0Y2swZURRNTI0Z245eDZXMUpk?=
 =?utf-8?B?VGxuQnJ0enNqTGJzOG5lakMwb2U0R2prQmhrV0w0M2U1cVM1ck90c2dZOHhv?=
 =?utf-8?B?QzBnaHJmRDRZWCtlSFh5OU5zYmpzeGxoMGR0ZDUwZUdZRkNSV3ppSWpOR3N5?=
 =?utf-8?B?WmpNWGtZYkxuczlzOXk0MWk5M0tNSmQyTmhMYnRZZCtqb2psc1dzZXNzNERU?=
 =?utf-8?B?dWJiMUIzTWJHbE9uUGEzT3E0WnlMZEtGbEd1RDZKdkJuVTU1QXRUQURRVW00?=
 =?utf-8?B?dmxDd1FTR1cxQlFydGcxSzNaL2RPN3hBR0Y4eFVMZUs1WW1Dd05kYlJENXU4?=
 =?utf-8?B?Y0lDYmpIRUx1cjN0ZTJTTWhwVFlPeEdQTS9vd3ZOYVF3Z3RLV2U3S1ZXZlNw?=
 =?utf-8?B?SXNQVk9GWHd2dzIyMEVNOGZOWmNMaFZBbklva3BXVHBwOWhJOXc1aVBudHdz?=
 =?utf-8?B?c0pEM1FqV3ZMenAxbmNwU1Bhbi9pc2NqOWZ3N1ZOWEtkMkNNU3VqSU9iZkox?=
 =?utf-8?B?SWtGeEMxT3Y1dDBTaW5tRnJuQ1R0dGVNeEVrTldmTzMwNkJRSG12U3hqWXFs?=
 =?utf-8?B?MGc5bi9aYWdWOFByZlBkVmRaUlp0a0dwZUdKWDF3WGpjcXhoamxZV3FhWW84?=
 =?utf-8?B?OEhQZUFNaEpZL2dncGlEZnJDK2ZRVmJJcUVUQS9MUjFkcDl6cnJCdi9SaGI2?=
 =?utf-8?B?YStnT211SUg4UWh1NjBQckhpZ1lidks5c2VsU0k2VzJUaWlZYlpxQStKeDUv?=
 =?utf-8?B?QlVNRVdGV1Z5MHh2MjFyUDlrNnN2MVZwMVA4M01DVm9WTVJNWm5OZHYyMnRp?=
 =?utf-8?Q?60mIyX/N2BT3NwZI=3D?=
X-Exchange-RoutingPolicyChecked: iYqurYXf9G0aqTHUKGij/4QcqBHSLvKBBlj5xdAzXKfcp/o5YDv7MVoEoOtQPYFrQ5krpM3uicppSPfk/HpCqil386Dgu946OlTdv2MCUGOcHw4jekO193/UInQzgIvXqGoTx0o9L+e2zIFsVXnpNTQdZKf9DxvKh/P+JLuXDP52FzhJ2KAMkAFyFW/ejMG1kITstGh/BKYRl8Jh8zP9E+1hx9afKJvkKr2v5wEKx/qjf7dZOi4EdkUtJc/pTjeOWHXU+5lvN1F+Rz5oCzcJl+IzNzOJ3GzyOyUBY5UoxyWnplDCyMhp5m+NdT5WlF/t9GETdZ6AfZf4AiKVKmutOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2576c2a9-4687-40b5-4046-08df3f401ed1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:34:34.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sfk27hrvMJHs+NE7tsVFpJs4AoODcNyIA8xOK/46kYZz7UHeMKs9/58tLFt8YaUQpCoeUppy2TOnS/14LLvFRwVvecfIwxV/JEM33iSKVjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

From: Dominik Dvořák Via B4 Relay
<devnull+Dominik.Dvorak.econ.muni.cz@kernel.org>
Date: Mon, 09 Nov 2026 09:24:10 +0100

> From: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>
> 
> Since the Rx path was converted to page pool and libeth, ice_run_xdp()
> returns the buffer itself via libeth_xdp_return_buff() on XDP_DROP,
> XDP_ABORTED and on a failed XDP_TX or XDP_REDIRECT. That helper also
> sets xdp->data to NULL. ice_clean_rx_irq() then calls xdp_get_buff_len()
> on the same buffer to update the Rx byte counter, which evaluates
> xdp->data_end - NULL and adds the low 32 bits of a kernel address to
> the ring's byte counter for every such frame. For multi-buffer frames
> it would also read skb_shared_info from a page that has already been
> returned to the page pool.
> 
> On an E810 with an XDP blocklist attached to an 802.3ad bond, this shows
> up as jumps of up to 4 GiB in the per-queue and netdev rx_bytes counters,
> one per dropped packet, while the packet counters and the hardware byte
> counter (rx_bytes.nic) stay correct. The bogus values are also exposed
> to unprivileged users through the netdev statistics.
> 
> Count the frame length once, before running the XDP program, and use it
> for the byte counter on every path; this also drops the duplicate
> skb->len accounting that the XDP_PASS path did afterwards. The frame
> length as received is counted, rather than the length after a possible
> bpf_xdp_adjust_head()/bpf_xdp_adjust_tail().
> 
> The problem was tracked down and this fix written with the help of
> Claude Opus 5.5 (Anthropic), working from netdev and ethtool counters
> collected on the affected system and from the driver source.
> 
> Tested on an E810-XXV (7.0.14 kernel, same code as current master) with
> an XDP blocklist attached to an 802.3ad bond: without the fix, each
> dropped packet added about 2.5 GB to rx_queue_N_bytes; with the fix, 40
> dropped packets produced no such jumps.
> 
> Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
> Cc: stable@vger.kernel.org # 6.18.x
> Link: https://lore.kernel.org/netdev/DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com/
> Signed-off-by: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

This looks elegant and even simplifies hotpath a bit. I don't think we
need to try counting post-XDP bytes as if the XDP program added some
bytes using grow tail, those weren't received by wire either way.

> ---
> Based on the stable v7.0.14 tree, which is what the affected box runs;
> the changed code is identical in current master. Tested on that box
> with the fixed module built against the 7.0.14-26-pve headers.
> ---
> Changes in v2:
> - Account for Rx bytes and packets once, before ice_run_xdp(), and drop
>   the separate skb->len accounting on the XDP_PASS path (Olek).
> - Add Cc: stable with the minimum affected version (Olek).
Thanks,
Olek
