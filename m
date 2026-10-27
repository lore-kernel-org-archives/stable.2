Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793122488;
	b=lyMMAVoLj3j8LFfBscghfmA97FRyWECV5qk1bgqYOMYfNHRpBwDfCRp0DVYghH0NyEfF
	 AAxOq/5jeYAmIFa9E5CcV0Du4Xg7rsr+ETEIz5FirhgLct6Hpf0/jLpZS118WPwMZTxBx
	 JiiiZDEMZNlfX4tPuXo80L7ACZYsxqaNgyZo6KJWt4AbilSCBZOLGMVqqPpE/va9g3g6L
	 td4e7jZnB1hyu/uTRfo2hjqEJufqQuLhjJsKG6kGdrzHFkZ56sFsA0NxuXMIi7zBdEz8u
	 8Lrnd3rPmjW6qRQAEMfIDtVtspyTYGCT4lTNxJ5ZzZqov1raSYLrO63FTx9DvYXKEYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122488;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=GZ71TJ3d6xVuPPz27MwDP1bcGGs2L7qn/BpAPJ8epwk=;
	b=LtQB58TnA/1dZ1awlQ3mObiytvnfDSfxKCfi/R2PaakJxIyra8oW+XI5FZgW9hRw9gNX
	 DrVfSCQzf5wRCRI8Sg+7+fmTlxdEM+KbPaMtQAK5+iN2a9GNUgR0+Rm1X4PokVjdC0RKw
	 5/8WZUr27QQfFlb4IczsF2WgRUpcBMmN2bZK22p+tvgjIORMmZLb2L3zwCqqoT/RgsXBj
	 vLY5ZGHD6SkbO9oZPNqY6OqHNlWpJd+tlgvIDtxwQCzDxZIgFwAfQARiiLCuHSMQ3x9HG
	 vBl97z7eE+CwudlAZX5t7OCcJ2z72/y8olh+myISk/cociwTx2nYMEV/7kwtgJI+btA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmjNNwvs;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEB606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DECEB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmjNNwvs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793122487; x=1824658487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FBtHAlB2iBYVHvZK2bQ3tkqg4NNENwJ0/VE8GwXkdVY=;
  b=bmjNNwvsmDm+k/FiPUIt/+6hlD/1IUiNcuJnnhBN6uaVTdMHfnsk97uV
   LnZ4xcRhbNO5hHTBxn3frSZOdYizn+Moxrgena+shVHzdlZNQ3cQSaBQd
   DMvshOPsGP2I71dSJ3B/u1fw9d6Y60XAMSTjYpP3ntkXhqpixznlR1lXW
   XYTOHpGSIXZj730wy8mZVUPkPkuFBwrI1L03/SEs9brvmK0jiC5GyrCNn
   xK9joN36O5YMtuktOsuzRLoBfCjKRB611OYc9jJfVNU+6VoIi5KTXwSKT
   z0EdbwPMDTWOreq2EGYhsYW5dsuUscE2tK4E9LkZtbsnCi3MEMBT/swc/
   A==;
X-CSE-ConnectionGUID: eX3DWCOxTEmgoYenCIJNWw==
X-CSE-MsgGUID: DGobDNN4Rjia825xfbIgFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1824435"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1824435"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:33:55 -0700
X-CSE-ConnectionGUID: oyce1y6ARuSgAlbVCeHJ0A==
X-CSE-MsgGUID: gfBzWmPlQkGAaBKnDfTNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4605827"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:33:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:33:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 10:33:53 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bro2TSLrxYRruZPn6rIgI9YZ2Nj8oIimI6wxuVKtVfrpTBSJe6Zy3GXiG4EP0N2k6x3Y+5phKDr3JLvkDekecwqhhui6qSJIVOcOZQdFR8jHhVgl7FdpP0Xj977B7LgiTFEEzvQMnqOm2BYahO/qOG7pmgd7JD/UxIFkJB+jQ7MwsCcsYVHdKsF78JKrDenU+jYR3QgCf0+tKvdv1S+rhxYTr5Ss1VyIRbJmx4r0Z8B2zM45YIS48Vyl9CEy5j5ah92ACNc79b0/yL4ZtKxDs9VzJzoMagX0B1BdxwA+GoiEl0vpDcweG/DgFp1dLQuw9FXSVyw1h8omvLHzKSOj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ71TJ3d6xVuPPz27MwDP1bcGGs2L7qn/BpAPJ8epwk=;
 b=svFEzPlaXEGqZIl+/zDBT8T5tn8x6k0PFDe8Qa+CeE22ndSBnJLDZhHafrViThYA2ViEFE6uPtKaFZvbRLUZOLUqOeTYidsociELUu7/vwKqfv+xPU4MWc3PLV1CsDjOL6m9yXeN8urZNMnHsGxx7JJX7qdUs9ekb6WQMsoUZBjwlhVt0RUhnBckU1kcRDmmqRE1tzydkjGDtqYEOpwDSOPer3wV2cPvaI0z4Ut3IMwqvn8s8xLEQfAx/7OdgZk6YcGC3mPNLABo9k/y0CvckQlfSL4uZf2nQdp6tX4ec5/6s6TnFB/3sKuSKXKptwq9hX5uFeZrsrsX5j6j108Kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21) by PH7PR11MB6724.namprd11.prod.outlook.com
 (2603:10b6:510:1b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:33:50 +0000
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460]) by LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 17:33:49 +0000
Message-ID: <0bf8a97d-cab8-4f9b-89d4-dad687bd411b@intel.com>
Date: Tue, 27 Oct 2026 23:03:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/dp: Add quirk to allow eDP joiner on ASUS ROG
 Strix SCAR 18
To: Jani Nikula <jani.nikula@linux.intel.com>,
	<intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <suraj.kandpal@intel.com>, <stable@vger.kernel.org>
References: <20261027024334.1140596-1-ankit.k.nautiyal@intel.com>
 <fc612de514d2382b5c783854aeb98963d0bc0fb9@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <fc612de514d2382b5c783854aeb98963d0bc0fb9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB148960:EE_|PH7PR11MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 23eef054-5373-4c87-28cb-08df34507638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|261026121527099003|4143699003|56012099006|261022075727099003|261022105027099003|10067099003|5023799004|11063799006|261021123027099003|261009223027099003|261021121427099003|261022113327099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: ahTXpewt9JT8URDPsTAe4CcDi4lZI3Ujb2e4NbsupkTFu+FO16Igfomoz4itM68GCcpRohmDwX/QObxqFjzJNxLq+d5rlkj/JG67zLdRjM6hiuiw4+sLdicIIOf/UxWoLb6ffemQkvvK6WZoQqWcvdBd6UKU+1Jux6dXoBRgm0B3LoEoColoHwyMdgoE+6n1YxZW85HWbouYAYq8ieWU9yA7t84Tj+fM3Uf5lO+EzmdbE25RdYngrpdhk8Bkt/55FtYXrxjz3hAe7PIgZG87sn+XdTQKnV/z6UpMfbUyLKdbSjOMySe2tTfKSPbsS1XoDbZlJiwuldOMkOqwk+DKpk5hpjePBzTrkg0V3hpBwPw+6jmtNvtffA/x8fzGpPoaexg187fAci9PQWamMtPnjmUg/XFSoxXitYWVLIu+jejj1fzmJoKFXOpZpDiSxLzSMO3CC494OpONdSVJP2TdYrbYaMT9lFqT5X8coeF3tj0Cmo8+M2w+4FRN6LhvksMvSWJQV5Ud6vrGvF2jmsEIwoXaQxLfOav6GwBCdTRsPLfmQeoufjr67TSlQuM84C/ZHC0ik01agFdbigGdxUirV7E23xm45jqmrQMyiCg/4zFJnaGpyjdjb6hDt1nId5lH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB148960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(261026121527099003)(4143699003)(56012099006)(261022075727099003)(261022105027099003)(10067099003)(5023799004)(11063799006)(261021123027099003)(261009223027099003)(261021121427099003)(261022113327099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDhSOWk3Yy9FUHBSUkRhWmZGSis5Qk15ZFd3OFFWd1FWTVpQc2JCcHRoR2RE?=
 =?utf-8?B?QlgveDJrL0xYUHl4MFo2TDhUTm04SXJpZ1lLS1Y4N3YvUWZBYUk3Q0FmOG05?=
 =?utf-8?B?a21GdXpVanZRcEpobENQWUpWOUpCRCtPRFdEWWpmSTZBYktmSndJVkY2czNL?=
 =?utf-8?B?eFQ2ZGNNZWZkNUd5cjdUTGExL3J3TFhKOVNwKy9SdjdDVFNoRUZZTWYzWVlz?=
 =?utf-8?B?em9CbmlDWThWVkFwZUl6S0xReTVvUnh0MmpUbE40VUdOOTNvUXh6bnRtTmw5?=
 =?utf-8?B?NDVHSGxZekw4cUVpbE8vTHdrTE1PMVcvbnN0bW9qa2RnRGxUT3VEZG1kVzFW?=
 =?utf-8?B?eEV3bFdIMDZ1NUZpSGJKSm50VFI1a3NMRkEvVjBxWmVxbmNJVHJucndoWnA5?=
 =?utf-8?B?YVdnZDVXN2Zoc05EczNSOWhmZU0zbHZhT1I5ODVuSExNRUJHUFdCTXlZZTRM?=
 =?utf-8?B?K2VxRGdBaDZmRkgwK2JYT21ibDdMcTdPYUhDdE1MVm5UY1I0RFZwcUc0czF0?=
 =?utf-8?B?ZmRpMGVQVnVaSU5oZFdjVjh5NXJZYm5lbUtzRW41WFhsdDZNRW0xdHozaUtQ?=
 =?utf-8?B?VG4vSTcyU0xKV2NoeXlHVHJ2dzZxd1lwdHZDenM1aWRCcXF0Z2dIbENjUmFS?=
 =?utf-8?B?Qng0SjRQN2FzQUdqbkdMRzk1TURNYVBzaEx0bkl6cStrTXJQTS85UFIwNm9w?=
 =?utf-8?B?K01mZ04zMTdPbGR3QWs1amlaU29XYkxCck9CZ1N1SXpST0JyM09JZDAydFgx?=
 =?utf-8?B?YzR4U3piR2ExV1Y5Ny9HczBCRlR6WmlLc0F3VGYyZnlNR1gvWTd3SVZkNWxI?=
 =?utf-8?B?bmFDMVdrM2ZNa1pNMkhxdk43MzUwV2RLY1hjSW9Xa2E2WWNRdG40NEJrL0Ns?=
 =?utf-8?B?c0hpdlRRb2htaFZkb3phQ0h0SzlVU3VCMFBhZS9IMTlUaUFRMWRDZVMwQ0dn?=
 =?utf-8?B?czZEb0dLdzFFYXBkMklSYXJ4am44QkhPZjJlbWpJeGhGaEpWb05lRzloN0Y0?=
 =?utf-8?B?a0FURkc5eCtTU1BwWDlpc1hZdmhqOHk0cHpNdy9XOStzczh6Y2gvbG9NVmhu?=
 =?utf-8?B?dURWZFFrTlJXaTNwYnp4dmdrRE1jaEZBTUY0Q1luMHV2cUFSR2FWS2RGZFo4?=
 =?utf-8?B?Um53bG9xUEtnMEJTSWlKbU0wWkQ0a2hHUVBsQU12MG1PYjF5T0hTdk5ZMk83?=
 =?utf-8?B?bzBHK1U4UVNsSkVDNUQ4ZnZiQ2N2WWJSaTBLM1FDK1hodE9kYWFXWTlnSE1w?=
 =?utf-8?B?UWRGK0VNYUdIS0N0aVlvODJqU1Q4ODRMb2dRbE1lMHFxa2xua0k2bC9Ca3Nl?=
 =?utf-8?B?aUpYWGhXZWVTVXhCWEdZRlV4VHVvTjhJN3diZWtya0Q1REJrcXppbmFQMEZX?=
 =?utf-8?B?Mk9YRmc0K2NKelpVMVIyRHRIL2p3M2dPbDRkaXJBVGYzL3FRTVN3VzRyUWJx?=
 =?utf-8?B?UCtITEZtWGJWN3Q3SkN4bTJRMmx2dHhURUppS25tUEJtdTcrVUxJa2I5emNG?=
 =?utf-8?B?aHBtcEpWeEtRakZ2b2Rka2hUL0laOE1mZGF1TWRmU2tBTWdsQWlyVFpxQkxz?=
 =?utf-8?B?dFMyZElrU1JkVEx3ekZXZlhxOWFTSjNwZmR4LzRMSTRmU3NsemtyODdrTUx5?=
 =?utf-8?B?WHYyRHZLZDdXWFZ0L0J1TDU5TUprb3lzZ0MzSVdwL292bWoxbXNWMlh6M01l?=
 =?utf-8?B?OEpPM0tpVVBNQUZZd21HRzNQdEVxYVl1RWJLLy8xQUxTSWc3SWlnczVaZUF4?=
 =?utf-8?B?MHBQTERubGFRdmREakY2bGVxYUsyM3ZPOFRmUGMwbitscDB1Qzk0eHFML2ZU?=
 =?utf-8?B?YlRnQU42N05GTnJYRFNrdTdhMVdqRlRBckdSZDVydWNkZEFDWG1udjhGb0dM?=
 =?utf-8?B?ekRKLzd6MThwV2tBeWp6dDdJQkIwZkIvM1VVbVRyUjJDV1ZsZlRPenIyS2lz?=
 =?utf-8?B?VEVVaWwxUjBKakRJQ0cxTUpYd2FFQ0dEbHdRMWIxQ2JlMER6bXJDbFVvUTFk?=
 =?utf-8?B?cG9oM0RieGVtSGQ5L0w1K0tRZlpjcnM2RkFkOFhQaWlaQ21sWktaQ0VNckZK?=
 =?utf-8?B?VU1sQS9jbUk0dGx4OFJ3VGpsMVhteHJhRzdqWFlvWWNjbDRmUGM1cmtPOUxl?=
 =?utf-8?B?WkN4ZXNuY3M5NTBKa0dFbnlTZHd6bHFyRGVibGZndTM5SktNVkNEMGxuNktQ?=
 =?utf-8?B?a0hFSjBhWi81UmlwRnNOUDZWTS83Mi80MVpmVEIxSVZGZUVhM0lWYUtHcFR4?=
 =?utf-8?B?U2VnZkpxZ1VKWkVUT1podUV3MFRYdmNPelAyTWp6Y24xODZ3dXBLQ29FOHI2?=
 =?utf-8?B?VkZORDFYWXQxLzRnMGR6WmJMVXEwVWFQaGVBOXlHcFV0Y1Z3Q0Z4SW10cVRS?=
 =?utf-8?Q?u0i7d5tLxeAMOQyU=3D?=
X-Exchange-RoutingPolicyChecked: og3U+mTtcVcsp17SZZJnMlEwiTX3tZZdQ1ZT2zy9LdFUovFTdRRg8pyDUET40N67KEB77qCmd3Gi5niDXlrE50TQiHw66YFpyiyGqxjIWMvJMKwTybtv95CglVVTSaWS+RQM53zWcNZb+LXZ2j7bJbh3e3wToPbv5QpiUdesfSmFhy3JiNqZdKMD4EE7pkpHWL4GlTpKvit7hCn+UwTqxFN053p0/boQzlTzpMnQBKULdgUGwjdzUN533VM6nMsv7yTxzLtOEtxPdWV5w/WN4WmGETHaPauSQNVUa0OMYbPcHWQ+A7laO295Dw8kU9t9TXZ+lHtKbf0ubd0sLPWGPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23eef054-5373-4c87-28cb-08df34507638
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB148960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:33:49.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHobQcIdot36b4/ZI0ocC8mOlf2lCZhFhCl+EhG07gSFA5RQEthRGCeKNTjx0OUxYNW0UpDta95CCVtonmcBhGPYYhINyF+g4dNdFC1Ql+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6724
X-OriginatorOrg: intel.com


On 10/27/2026 4:46 PM, Jani Nikula wrote:
> On Tue, 27 Oct 2026, Ankit Nautiyal <ankit.k.nautiyal@intel.com> wrote:
>> On Arrow Lake, VBT defaults the eDP pipe joiner enable bit to
>> disabled, and commit 650471948e49 ("drm/i915/dp: Avoid joiner for
>> eDP if not enabled in VBT") made the driver honor that default.
>>
>> On the ASUS ROG Strix SCAR 18 (G835LXG), the bit in VBT is left to
>> the platform default instead of enabling it, even though the
>> 3840x2400@240Hz panel requires the joiner to reach its native
>> mode. As a result the mode is pruned and the panel is limited to
>> 120Hz.
>>
>> Since the VBT bit cannot be relied upon globally for ARL (it is
>> needed to block the joiner on at least one other machine), add a
>> machine-specific quirk, to bypass the VBT restriction and allow the
>> joiner on this machine.
>>
>> Fixes: 650471948e49 ("drm/i915/dp: Avoid joiner for eDP if not enabled in VBT")
>> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v7.1+
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16854
>> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> ---
>>   drivers/gpu/drm/i915/display/intel_dp.c     |  3 ++-
>>   drivers/gpu/drm/i915/display/intel_quirks.c | 13 +++++++++++++
>>   drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
>> index 00e02e019d25..7b83cc83eede 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -476,7 +476,8 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>>   		return false;
>>   
>>   	if (intel_dp_is_edp(intel_dp)) {
>> -		bool pipe_joiner_enable = connector->panel.vbt.edp.pipe_joiner_enable;
>> +		bool pipe_joiner_enable = connector->panel.vbt.edp.pipe_joiner_enable ||
>> +					  intel_has_quirk(display, QUIRK_ALLOW_EDP_JOINER);
> Could we hide the quirk in intel_bios.c to set
> connector->panel.vbt.edp.pipe_joiner_enable?

Yes that should be possible, as I understand the intel_init_quirks 
already sets all quirks before we reach this point.

So we can set panel->vbt.edp.pipe_joiner_enable directly in intel_bios.c 
if the quirk is present.

I will make this change and send the new revision.

Thanks for the suggestion.


Regards,

Ankit


>
> BR,
> Jani.
>
>>   
>>   		if (connector->force_joined_pipes > 1)
>>   			pipe_joiner_enable = true;
>> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
>> index 7d7db774d8c7..ba7bce7f2827 100644
>> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
>> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
>> @@ -100,6 +100,16 @@ static void quirk_disable_psr2(struct intel_display *display)
>>   	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
>>   }
>>   
>> +/*
>> + * VBT on some machines defaults the eDP pipe joiner to disabled even though
>> + * the panel requires it to achieve its native mode, so allow it regardless.
>> + */
>> +static void quirk_allow_edp_joiner(struct intel_display *display)
>> +{
>> +	intel_set_quirk(display, QUIRK_ALLOW_EDP_JOINER);
>> +	drm_info(display->drm, "Applying allow eDP joiner quirk\n");
>> +}
>> +
>>   struct intel_quirk {
>>   	int device;
>>   	int subsystem_vendor;
>> @@ -262,6 +272,9 @@ static struct intel_quirk intel_quirks[] = {
>>   
>>   	/* Xiaomi Book Pro 14 2026 */
>>   	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
>> +
>> +	/* ASUS ROG Strix SCAR 18 G835LXG */
>> +	{ 0x7d67, 0x1043, 0x3b29, quirk_allow_edp_joiner },
>>   };
>>   
>>   static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
>> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
>> index 970a4fe52faf..84f31809011c 100644
>> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
>> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
>> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>>   	QUIRK_EDP_LIMIT_RATE_HBR2,
>>   	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>>   	QUIRK_DISABLE_PSR2,
>> +	QUIRK_ALLOW_EDP_JOINER,
>>   };
>>   
>>   void intel_init_quirks(struct intel_display *display);
