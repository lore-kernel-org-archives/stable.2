Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793180251;
	b=BtnPwtTEDfhDbD2LZ3L42r9D5PWbFyINv70+QX1kWtg5kW6anh133av226wx5DlSB04i
	 CegoSb9kFp1TnQT8cNbQJ5IRIMVJOaSRmAvFww1QXn+iAqPZJwJT1vIBMXh8wG+Abc6p5
	 SFOV8ecvDj4epFhCrE/7P8EAnlZZYSJOdgWm13dAKYWH+aXUB8sE80LtCEKWTAsRGbY/D
	 KnNDU/mkXseNTJrgBhpnPAmo5oi9w6iS/VPbl/lf8y3Nck1MfDBjpAgB7AkucxipO5YuR
	 uxjujmgrBBggGEeo5h+gTfxjYG1aBqjAPQ5dXgdpPtKzM3Zn9M3V4Y9KYL9G+6j/h9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:From:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=ZZipZpPa7Dd7HDumHs6s3ND7a3XJ6FkSG/bXGbTHfQ4=;
	b=cWd9jsqfPksBVAJoCimJfJN8H1qUF/pza+NOHxTloWMe8LIgj0D9+OhrNMNIHVE13nwD
	 iNliT90qawEQgTmYgmT5uHF67+o2cS+EnU4tx7fDVtTDW3rwcEJ8AT0UI010vcCRF7uQr
	 P0aT/2Znsu7ENxwJWwqUbpIT38FVPQ7oKiM0aBidFdRRBZ7iI0jzKu1kRJcRkXUruTD8v
	 hQoc+L6eB9Qlj+LilBqX5jWaG/1iVwQf6ATU5SvsE+lIngN6BWCuVMiElZNtloPqEOfkY
	 qhqLiudodjHRkfzd/GP7qYz4opDSV4pD9DB1giKHBvGnMAxw/t14yi8BB8U91q3MCkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a2aF3k7s;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4C606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56A4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a2aF3k7s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793180249; x=1824716249;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJPXLThIEqwpPc2PpB3rzuT8KYFe8isJ+h2yNQvbcEk=;
  b=a2aF3k7slbUVOmdlv9FXRQf5qW1D5zeAiP0mpSclWEMqosI7R2qfEWJE
   e96UMdCELdewAOM81H/0azCk+8CfQju7IPumbxZUjOd8l2MZs/TgQebkb
   0C5cu2ve/y6uO25KITNlcRt0FLjmwOsWWFuyEvimFP7MN+XayVq8u6GZ7
   5vyFia1H5CuJCRKbvPcjQs7mObHZ2cDhQtnSln0LKVlyZbM0gQ++D/6KA
   MsinneVyLoKcfsNdzTHfPqNbEuxKsCRjcWs0FNOEX7Tkrh43vpAP1UdE6
   R4u96MVOqTdoXpyw0EbRXhP4ZoZJUWhomRjijKOn4y2ZsUwRFsx/jofPV
   A==;
X-CSE-ConnectionGUID: EMD/+AunT0WXp8Egp1lymQ==
X-CSE-MsgGUID: fqq+VrgqQ+GlEx1Vmge2lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1895550"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1895550"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:37:28 -0700
X-CSE-ConnectionGUID: pUaRoCTgToGyFo6vktTS7A==
X-CSE-MsgGUID: PBlYX2snQF2M0JaU2Wgz4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6633559"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:37:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 02:37:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 02:37:28 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 02:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7KTFBzjMpFCtqE1e+t9w04Ge3TFgsGXwMc67loY53UOWKxNb/YhRPTYn2zFkLXqY1Gvrc7GMgq3Yb3SGPQkqzDrJwq0TEG/Lj++fKDO/6ZOf3poKsIHUQ8rH7DxixwiJZvUh62ob98iBKZJUH3iqwxuHNeWljpnsKFWaTvaR/IlA3xnKSnKDKhXT51vfHRhXTSORCKUZDIgIIsWmBqW0ckX0ZH4pl06myzvwXJqFgCmGEHh8L7iV32wZY6LQvI+I3NGox5q/JH/nvu3tHNW5q3eFZLzfzLygaDiXVJGcB4nGfYLgTFJoU53BWK82xPdHJHY/P/yap9owiVSpCg7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZipZpPa7Dd7HDumHs6s3ND7a3XJ6FkSG/bXGbTHfQ4=;
 b=DdqsrFDHjZeubL7xtMKdwHVsASLmTNNNP+icFAUBYD2mSfYPJakNfkb+IEj/GmrJfUzatyxjm+ve2us8x7GHMnu0+qaPW++FHtOpV4K3/tJFD57Byb1u1KTmRe/4ajri5Xv6SRlOCmTQ5IvtazVpMj0OEINkWMGP75C+pkylj3zZL+JNAcBrxJMSXMJrBBO6j4wvONbLhCXvwVOea2IqqC5tAAjceiHpYVO+agX6Lw/YXMblmxL+is9hjdgtzyxUof5ltLhEofPqppBt6pLWECsmsbUNW2UIsKCpSDJ47R26E/dKt1646FsWSqJhB5ZjTQkFFWU0cResdsdLpAvggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21)
 by LVWPR11MB9881.namprd11.prod.outlook.com (2603:10b6:408:3be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:37:20 +0000
Received: from SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3]) by SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:37:20 +0000
Message-ID: <fe7b9725-be64-4a34-a8b1-b2551fb0ae91@intel.com>
Date: Wed, 28 Oct 2026 15:07:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "Srinivas, Vidya" <vidya.srinivas@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
 <94c3c16c-50ce-444c-985f-0fc0fb009242@intel.com>
 <PH7PR11MB82526C4A1D72F22D44331A7B896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
 <48da0157-6fb3-4e93-a43c-0443c5bcbbb2@intel.com>
Content-Language: en-GB
In-Reply-To: <48da0157-6fb3-4e93-a43c-0443c5bcbbb2@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::10) To SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21)
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
X-MS-TrafficTypeDiagnostic: SA2PR11MB5035:EE_|LVWPR11MB9881:EE_
X-MS-Office365-Filtering-Correlation-Id: 100eea31-1b53-4363-900e-08df34d71026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261026121527099003|11063799006|261021123027099003|56012099006|4143699003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: dOTMD7tBZ2r9d0mVu7padRWQqFhOVahgiPRRmfSkrSl2E9lUIDY9fkBXK6xyCXqPY2EZHbGDc39vcWnwBWHdiLGA1w7Xd+JfKriWkT7z/nAqBitk8/eJd13z6WcmzW1jBRZZPkTPyQjKaiHnooBdg4QnYkVaV1LSCHN+9F78GjL08fdMpMRDrX3n6p3jbUYs+8K8gtElcLxRugfgHovqd0bZiqW1u16TV22sBo57IUM4DpJZqUnJRAhKPlFHA8FGYVX1Q3AgcbSnDzVJZzrxAHdM35KAcErzrP3G4spAfWAF2X9Y782TDwhWY0Wau77psO6PHroXL/nDk0fpMZIAZNSFMdOiER9L3OmvnRg16pmuUZ3EbdM1Vnq2ani2J/eIN+LDONLj84Nsnf/DldLmLEloc6f+C1IJhKTqhKbkGTGeO7+qn3RAy4efD2dB8xvIQSAkBFwacM9o0HYuodLmU3fvE5Ri+03/eLg2ww8fNebB/uXnh+PHt6Bi0AvICgiwym7xqZoBjSiOadz2Vpt3DmqfxvqT7yUOfdpXsttZIAjPWH5P5x7w9t5JyBGuY7Af5Eh+uNTNLyzYCULtofViwQL9bLeHD6V8t3hZYTzit+V6+buFUsk0vLE7wHRIiJh4aSECDIGPgJn+uB6RgKLEwpYR+Q/nQiNm5ketMPpoPTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5035.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261026121527099003)(11063799006)(261021123027099003)(56012099006)(4143699003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N05FRXh2QVY0anZ0VXMxdktyeFcvWG93YUtndmdTbXpqL3pMdXlSZTlwUW10?=
 =?utf-8?B?dzVkcmo0NE9PR0lNLy9lV3QzUU1NUmdxaGgvSjBHeUdXOERhQnplV2RnZEs3?=
 =?utf-8?B?ZEdwcXBuNWxzSHNCMjNtOW1HVXFhUFlUeC9aMGNyMDExdlBEVkY5eDcxSGpW?=
 =?utf-8?B?R1JCdExhRVVUT3VRanFlblB6bFNZVVRNNWhKYVNMUzRkczY5Qlh3L2I2b29y?=
 =?utf-8?B?cFNqS3lVSm9BdkZ2ODRsNWpVcGgvc3dhUlVoUlF4U1hFL1EwVVkzVXB5eGEy?=
 =?utf-8?B?YXBhWFVaTGJnd0NoUmpyZ1pMU0luMlNpSUIzOFZudGIwbm9ZVG13bkxMRWgr?=
 =?utf-8?B?OVI2U0RlWFN3Nk5mOWxJeVptK0ZReTdaOWZBUTRBaWsyZkZrMGE5Y005a2Va?=
 =?utf-8?B?d3o5V2ZrejRYRUxWajFXWU5WNmdDb25aNFZ3NTlNNXVtVUgrVE1DMS9seEZp?=
 =?utf-8?B?cCtOS2pGeU9xOTRDUURDRERWM3RxbjNHQXJtSXFkOGJ5U043Y3FqUDRkK0dX?=
 =?utf-8?B?MFVJS2E4UHRnOVUwU3dKSEFoTnExN29ZSytoZnNkYkFiaTNGMUloR25IMU5Q?=
 =?utf-8?B?d2xaS0c2dnRPL3lDenV2U216c3BTWlgyaGhzcHNwZVhMTGZXNmh4cGVaLzM3?=
 =?utf-8?B?aU5td3VGNVIybnd1MHM2U1R2UE43ZFBmNGwrSGxHZHpDNkx3S2pCTzJlWkV3?=
 =?utf-8?B?TVNpa1REUVFOM241OW1FVzZneDc5eWRRVjlSSXJoVmJIdm1vZnFXQis2NVZs?=
 =?utf-8?B?bDFhZzZvR1J4eFlsMjNPc3p3amNVempJa3FVdG1mVDlreHpTZUljUXZjY254?=
 =?utf-8?B?MEVNWnVSYnlGY2FOUW15VTErMTltK2xyTURVT3JxbXFWUURxdjlsL0g2Z3c2?=
 =?utf-8?B?MTR2ZVhuWWNBc2ZlMVJuTjZYUmMyZFp1NjVVeEp5U0M1SGxHdGlnTHExNlZO?=
 =?utf-8?B?c1BMcUxneXZoQnhUTXRYelRYcEsyOE0vYlkweDlsbnFYOHdRQ1JtNkR4YlFw?=
 =?utf-8?B?UnJTQ3lWa29BT0xJdXFpaXNnL2JNNUswUjQyVXRhNEF3V0FTRGsvMVpUTyto?=
 =?utf-8?B?ZmtNZDY5QnZwLzYrZWRkYnI0aWluZHpEQU8yLzMraVBtRlJSY2lVMk5NcUNR?=
 =?utf-8?B?dVhPN0FFaUF1Ris1M1h4dnJNSkpiWXdUL2dyaUJYOVpxL0Y4SFMvQnFDWGcz?=
 =?utf-8?B?YTl3OFpYb0h0QjFYMTFtTU5RNngyU1luUmo0WUx4WEJqbGYxZjcxb3RFMWJM?=
 =?utf-8?B?OFhSR3cyNXkxazd4cXhXNDg4SEJOSThoSnB6eXFac0hDR0JjZzFQZGw1QnQ0?=
 =?utf-8?B?bmUyL1pvRDlTbUpaaWtiU0Z1UkRpR1dCRWp5V3p0YkxQSzhkcDg3R01sY2Ur?=
 =?utf-8?B?N25obVpTZEVxNGZKRUVoblM0a3dsUzc4SjYvdEl3SkdOV2dXSWVCQ1E1T3Yw?=
 =?utf-8?B?SnBMdVRVZStRNURpdVZmRlo5bHI3dC91VzgzQ01HelVmME1sd0kyak04U1RG?=
 =?utf-8?B?OVoveUM0SzNReHdhUzNUQ3lWbGVsV3EzSU5OL29lL0dOM0wwM3RUVXE4Q0JJ?=
 =?utf-8?B?M244YXdIWWw5by9sK1dVQWM0ekFvc2xiUHZyaSt0SFV4SXpybjBWRlZGTG9r?=
 =?utf-8?B?cUtLMHFMc0xZOW9vRkI5anJKbjdFSGgyVW40SmNuWmIzcTNWL0ljcFo1NHI5?=
 =?utf-8?B?REx4N2lBVUFxS3E5YWM2UE5LamJsYUgzYmV6UHdZeFNDVnNvY0JiN3l2QVJq?=
 =?utf-8?B?VWk3UHVXVDM4L0preDg5WlBJMTdHSHBOcUR2Rlk0SlhKclVORkV3QVlGOTg4?=
 =?utf-8?B?d0NYMW1INnVPR1pWNk44UEpUakxIa212UHQvdERyOWRSNDJKaXgrZjdtYW0w?=
 =?utf-8?B?MHdJTUZXUitlWXFDaWpvWjMxSE5icVd1SXozYThSVlBkbjJNOW40bGk5b0FU?=
 =?utf-8?B?dEF1UEluTGMzTGpRb080WFBka0FoRmVRS21QYmxwRWRMbUZPZkd5ckFaZE1i?=
 =?utf-8?B?OTBmVjdMM3RsVS9qSzlMaDBHSkFydDdtRzNZcXZ3YjF1WE0vMVc3emtYN2I3?=
 =?utf-8?B?N1R1V3d6U2RQazhVREhtdEVIOVBIVUFaYys1TE42UURHd1VSYkNhNVUyMDli?=
 =?utf-8?B?RXZSYTFwVVd1ZDhCcDBuS29vVXltNndTSys4TUVFVklTdzZmZ052QXorcFNM?=
 =?utf-8?B?ZlBFenRVbGNGRUYyV2JKUW9aTThZeW02cEc2V25xT0VrQmRSS1cxMDQwNm9W?=
 =?utf-8?B?TXI1eUhBS0loa1VhZG1FYmxzL3hRTDJGaHFsQnB6MmFmbEYrT2I2MEFFTUpz?=
 =?utf-8?B?TWNUOVl4R0tUaHhaRlM4M3hVYUNzU0Q3aVhneTFqVlJlcU43Y083Q1EyN3pK?=
 =?utf-8?Q?duEdxLYaF7tBgsL0=3D?=
X-Exchange-RoutingPolicyChecked: NQT9wa70kOwL/D+PNPCtxdNif1SzQuufX2eRfHbYB39t9dz1cVBNp+0D05MAPgjzJAm3XwqYJnKrr/CIhj1jfOFH4eYhCSBw8Tg5wHQ8S4iPjmlU3hhgvVuqWB/Hm8Rf5sugJHXGW4FEXeqn+LCOdESBQFG7/6Z9AW/FcHONCnPkF2D93KaY0UzcdoDML8zzi4gDtP7VdMZWAYZSj3YpJjodI31zQ6ab8RcK/ukv+Dap2B2R+FG+2GpsQDU98rwUcuhYMayWp/YO5DakMsBkDS9GggpvwG4LZvmWmF453Sxkji1qmpq9/0mHfzTb1+OfGyeZOwVRNhZeJQXpzBHEJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 100eea31-1b53-4363-900e-08df34d71026
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5035.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:37:20.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F67U+mo/rVVFIcPiw/RfjNgdw9+kBVW7EBnA/mnIXy0m9TBUJYjJzutSt5myQMKms1+S4TWa0CApQ2DCwHVLa2FO8BCCxiV1UXj4K/ynIZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR11MB9881
X-OriginatorOrg: intel.com



On 10/28/2026 2:58 PM, Borah, Chaitanya Kumar wrote:
> 
> 
> On 10/28/2026 2:27 PM, Srinivas, Vidya wrote:
>>
>>
>>> -----Original Message-----
>>> From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>>> Sent: 28 October 2026 14:08
>>> To: Srinivas, Vidya <vidya.srinivas@intel.com>; intel- 
>>> gfx@lists.freedesktop.org
>>> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
>>> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Lin, Charlton
>>> <charlton.lin@intel.com>
>>> Subject: Re: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
>>>
>>>
>>>
>>> On 10/28/2026 12:34 PM, Vidya Srinivas wrote:
>>>> Pipe joining is not supported in the WCL display configuration.
>>>> Report no joiner support on WCL so that modes which would require
>>>> joining are rejected, matching the 4k 60Hz maximum resolution
>>>> documented for the platform.
>>>>
>>>> v2: Rebase onto latest upstream
>>>> v3: Fix up the commit message
>>>> v4: Split the scaler and joiner changes into separate patches (Jani)
>>>>
>>>> Bspec: 74286
>>>> Cc: stable@vger.kernel.org
>>>
>>> Won't we need a Fixes tag to tell where this change need to go to?
>>
>> Hello Chaitanya,
>>
>> Thank you. Yes, I did check checkpatch gave the same warning but I 
>> couldn’t find the exact patch to call out the fixes
>> There are patches like Extend the max dotclock limit to WCL, Restrict 
>> max source rate for WCL to HBR3,
>> drm/i915/wcl: Add display device info, Add power well mapping for WCL 
>> etc.
>> git log shows under merge tag the "Add support for Wildcat Lake (WCL) 
>> display, version 30.02"
>> So, could not find the patch for which I could mention fixes.
> 
> Fixes: 632633d095b6 ("drm/i915/wcl: Add display device info")
> 
> Should be sufficient.
> 

Sorry, support for the device id was added even before that.

Better fit.

Fixes: f8e1c3e07db1 ("drm/i915/xe3lpd: Add support for display version 
30.02")

It would be worth checking though if these patches applies as is or 
might need some rebase.

==
Chaitanya

>>
>> Regards
>> Vidya
>>
>>>
>>>> Suggested-by: Charlton Lin <charlton.lin@intel.com>
>>>> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
>>>> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
>>>> ---
>>>>    drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
>>>> b/drivers/gpu/drm/i915/display/intel_dp.c
>>>> index 00e02e019d25..ef164a797618 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>>>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>>>> @@ -485,9 +485,9 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>>>>                return false;
>>>>        }
>>>>
>>>> -    return DISPLAY_VER(display) >= 12 ||
>>>> +    return ((DISPLAY_VER(display) >= 12 && DISPLAY_VERx100(display) !=
>>>> +3002) ||
>>>>            (DISPLAY_VER(display) == 11 &&
>>>> -         encoder->port != PORT_A);
>>>> +         encoder->port != PORT_A));
>>>>    }
>>>>
>>>>    static int dg2_max_source_rate(struct intel_dp *intel_dp)
>>
> 

