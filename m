Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6C3D411D;
	Thu, 16 Jul 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190502; cv=fail; b=aZcCz8Iyvzyf9MFS1k0oiL/4Z+IXWZD0fa/nXfnpovIh3G52fQji1Ksjdizov4y1wb3aR7HLsB07fjkUa1yK5oNCJ2G27tykBF0gL+sp8DbleYYzpWPgQZgNnANdd8HI3yBC8UsOtot3psP72WGjgKVVF48+J/DvMXGH9j0KMS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190502; c=relaxed/simple;
	bh=XqRYocYrZmkgoTgMEymU2VE7TL8sTHyPaBI95/pFCe4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bacf4g2vUufCOCURN/95+8kYVCk+JSYgJNhifzNHjU+2gugWC5caWlPrVltl9w1Yl0X6yWsxd5Zg74blj4HlPzogQ54c6Dz3w2KlU7ElZJJ4wupLRzX959UZik6M128icZ51HkCE+k4wKGbIjWHv6hDrAmcbmZwipEKNZz6/4Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiqNidHd; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiqNidHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784190501; x=1815726501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XqRYocYrZmkgoTgMEymU2VE7TL8sTHyPaBI95/pFCe4=;
  b=aiqNidHdebPQV7yJ0p+pI8wv0xx0jmqiyhBS1GmfeQ9pMbL4FDVAEX+v
   08l0NqAxqUjRO3dzwqoc/ke6KqcelPPM3LQi7Mott0S3NyXDrN1Q4fklD
   kyXLw8FcwyciDWt3LxdTqPTla1Vw2CwBnCCkRfUOuQXlCYg/GcY+AGWkJ
   sSvuzSlvTJCrkolgHdj1TtGC/PmIQ5OOjn25qiK2PoyBL9f/srx1eMJgc
   LzuS00C956jrwnVzIc4OosfdXm6ZuPrhAdNBiWIyakXYs4kqd8/gRzkNN
   yWgYLeDogv2vmpV6uqvcmISKz9SJz/MPtETUUPtDOLWj/YvdSqDBc6ArS
   Q==;
X-CSE-ConnectionGUID: CtkjsP0VQm2jJUjLtrQgGw==
X-CSE-MsgGUID: m/2aCceFQJaRe3b9g1yfuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88667557"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="88667557"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:28:19 -0700
X-CSE-ConnectionGUID: xH2Lnij8SvquHC57gDGT6Q==
X-CSE-MsgGUID: WYqbUZuvS16MiWFlV+AneQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="253806482"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:28:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 01:28:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 01:28:18 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 01:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdQXDpuHZ+HVuEE7rOZ76ygtpHPVOWNt7yclLLw09ioAxibL+QLbN7ihu249++BrYZVX8MNbJO5fwkiMlW2PbkqYPLtCZXY4E7cENcudEpR0RGEHvwg3iLeTNr/8Vx8GPGLiwg7QJcrQTjMLd1WutqEtqa75By29gM2rM5+eeuWRrX8bO0ANyht03rSUBwXCW+S6bZx7KkS3nErPkUdQCCuUpzj21LOCQOvl1xPEx1KRVV00ge5ehpi5IcoJ+L6KqLnQCKZOt0EncIjexnYdl3yLGkWMVVkBwnIUW8FD/VUKHqtbcwQbO0i/PJ6UMneaeFkqFv4k9YbTTqbd46hOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmeWgPg64J5PwOzQPeTG8lqkG7tn81S2AhKI4YAHVkI=;
 b=uM2aF5X2iJHQJH28iGXNeMdP4g9pWbLHJxfBnu4+x41OTb38DVFjqgeJfWTCyL8D/f42XHnT3DJkYx1JDgR2jb+w5+cEOa5f9Obncql6PGmh5nY9UjWYaM+rncagEeUjJBL5USnog+DwoHvv3PdhG56EqRppcNn5qGC/HGgHO5p48cQCqdQpKTmD0WKSE1aYSOwyFjXVNAJwm/sN2Sqr4cUOtSL3AaITguceHsXiU5/ljOJdKnoHpGd88Yikcjn7cu+Qo6Xz5b4QkQAVN7ZBQXfdCaWkwDU+vVWaxz9hO+8rARJgcJo4tbhwnSW/24bG1LtRYsX86mhlmvjk3RXsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by SJ5PPF8622363CD.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Thu, 16 Jul
 2026 08:28:15 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 08:28:15 +0000
Message-ID: <22064276-6c56-411a-9f20-6917ceeb865f@intel.com>
Date: Thu, 16 Jul 2026 13:58:05 +0530
User-Agent: Mozilla Thunderbird
Subject: REGRESSION: [PATCH] usb: typec: ucsi: Fix race condition and ordering
 in port unregistration
To: Andrei Kuchynski <akuchynski@chromium.org>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Jameson Thies <jthies@google.com>, "Benson
 Leung" <bleung@chromium.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abhishek Pandit-Subedi
	<abhishekpandit@chromium.org>, Pooja Katiyar <pooja.katiyar@intel.com>,
	"Johan Hovold" <johan@kernel.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>,
	"Myrrh Periwinkle" <myrrhperiwinkle@qtmlabs.xyz>, Linyu Yuan
	<quic_linyyuan@quicinc.com>, Jack Pham <quic_jackp@quicinc.com>,
	<stable@vger.kernel.org>
References: <20260707141736.1635698-1-akuchynski@chromium.org>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260707141736.1635698-1-akuchynski@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::8) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|SJ5PPF8622363CD:EE_
X-MS-Office365-Filtering-Correlation-Id: d6108643-7fe3-4d6b-b355-08dee3142e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|12006099003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: I6/fClJGUBXwwpRXdnYYfmFhOH00uh1jX29FJt05OgU+qUV6EgHspJ6GqPwEA0xgyuxRdFmCN5TEO4dVkHHVUnSTpbhwFgjuiSgPXmmItORRHsCgyOiFzjXSTkCuK37YOZZ6S2Stn6aFRGfbRVRhRLPkr8FQqxExePyBSG4k9gAEuLprvK8YHGrhWpVkbFtxrZA3tZFiC95apgovfPC8d+bzdKr/TWOA1zYhavPCn8TRbcytBMRd1MQj0vt0YZdU6C3R1/u/xV33wxmEGji76khtqkj4EPd3dkUTZjbcZYRl6EBY+wScO6w39dUGyfyCvQ9eomiCngRBSZ4/KtYvuWIqt+POmUqCwPrJ5Uk5COrsoXsfPEFNKsIaVr4k0Guh89wTPAmTag1BvMM/kBitp8S9mQR+fJRgx5FGjMBVJ8H7Wl8uHo0buZvo9Yw1FsxIP5GSRoZBLsKuaQ2/sshEtoUsVtFvOPyrt9QO8Z4lW7Z39LCcBGUNtm5A1rhkWQj9mxN4VuAeUiMb2l4iK4RMGkERTy8QjCFcQeKbJD0gY6zuLLi+VKdV56K90ovkH3PRFmdK62/x5EyJH1zE9a9H1hbyhZtgH9DKeBaIFa8RP91Cy1bCyhsLoCSzx5NcxjOl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(12006099003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejZlcWpYOEE1a1ZZWjNTQ1FxemFrYVN4ZEp5bTh4WGlxS2h5ZEdTVGxwdjJY?=
 =?utf-8?B?QUhSQUY3R0RKY2cxeGdLMjJFNE9kdFI2UlRKNlFNODZRWkdjd3gzN2hFblpY?=
 =?utf-8?B?SUM1cEVWMXNyVjZUYkxhU1JFR1pLai9kNFd1UXNoNVhvZFJYdlBRMk90MFhM?=
 =?utf-8?B?NzFqOUZ3TkprcW91dE8xY2ZLcEd1bFUxRGpZR0NmTVhwU0JWMGFVbFBPckI4?=
 =?utf-8?B?dm9jM2Q3VVVRYm9qKzBWTUR5d09FZDF6ZmgrWi9tZ2xCWWZSTHZOQXJCblpL?=
 =?utf-8?B?eG5ZM2NmWURaOXU0S0h4aWFmWUw4dGhudUo3VmVhRDFZK2F3b21tcmpuVVhL?=
 =?utf-8?B?c0x1WENOVUxOL0JESXRuK1dncFRsRVRkTkdpWW05V2FiRTAwZVkwNVNrYVg0?=
 =?utf-8?B?RlJCbWtpOERDSkFxSjJLdG1HdGtnTzREWUlDaXBTNE4wTXlqK3VxeWorZlBU?=
 =?utf-8?B?TVRqUkwxTWpJWjBmMVJnREc0cFBMKytTenJRZDM3UklZOGZtOTFjVzJYckpZ?=
 =?utf-8?B?OFk0RVJFc0dBNkVoVldGT0hxd0NudkVtZXkrSDVoVUI2TFZ4SUJMUWtHWHMv?=
 =?utf-8?B?VDNKcnJuUTlRUi9OSmxtWnhUT1pOditSbzhTOW9jSjZ3QU0reDJ6NXpTNzR4?=
 =?utf-8?B?MmMyRG9pMndhZjloQk9yaTBjZ1diUFZzb2Z0RjVJOFowWjJDa2hBWTM5MHRk?=
 =?utf-8?B?cnVBT3h0SG1lMjZSdkNVOEtoeWdJL05tWG9VbnFWNE54NU5nKzVlUEZhREZT?=
 =?utf-8?B?N3hBV1ltT01YTUNGR1NpbkV4VDJuV0tVbHUxaWlMMmpXcWRuRitxcFVYUzB6?=
 =?utf-8?B?L2pDR1F3UEgwVUdsazNiM1U5Vy9rV2l2azJYTE9DMENVMXpjbExyZlVQdlE3?=
 =?utf-8?B?eVBPZ1ZGZ1VnV0Vqa1JrcmJINkZaS0w2TjBFYk1sVkI3UEVoUkkyc0lmY1B0?=
 =?utf-8?B?UHRxcjZjbjBqRWRJYXV3VmZjS0NIQzVmQW9selZwU3JwbjQ2aHVCZWQwVTh5?=
 =?utf-8?B?blpYUUFaWllMYXlQRFA2NkY1a3Jta2kvY1FGQWE0Tkw1OHZVZzRWQ2NOT0JX?=
 =?utf-8?B?dGZuNmFKMUxrNzJlNlArRlJCT3pJRVd6OVp1MjRXRmhOM3pWUXMyN2t0RENs?=
 =?utf-8?B?WkNRYVVWU1R6TExJbXFHU1VHZDczS2hQeXh1SmFoZ3crQkttUkVxRUd5ZDJn?=
 =?utf-8?B?dGlYVmRMWEZlT1hLbHVRQlFONVc1cngxeXZKSGxkelRxYTVpenFqQVg4TmdZ?=
 =?utf-8?B?NTJEV3k5VlJJNTcyZWdER3pLQnBIVXBWZEN6ZGpTYWRPeGtiOWhuOFlFTFVI?=
 =?utf-8?B?N2orNVBpNVpUVE1ESGZhVHRKY0xlT0l3TGZqbXFhYUpnU3ZlVkZRSVIzRG9j?=
 =?utf-8?B?SkNDK1Bxcm8vTEg4SktaWDcwcW5NSXRBaWZ2TGI0ZFpRa1JXU0twMTA4OFJ3?=
 =?utf-8?B?K0UrVmVJakxuVDNRekNDaUhGTWIxNXRSSnNKdWVEaGZoZ08xWDlJdmNVaDla?=
 =?utf-8?B?UW1aVW4yTmhoNGpER09XMHVPUFZpcHVoV2JPZW5aSG1kdmR3NWo3K1hhUVNM?=
 =?utf-8?B?NER3dEJsVGpBT2srRDV4ZW80SFF2SDk0OVpScTNZb2N1UjdsZlN3dlhyZ3hp?=
 =?utf-8?B?L0JrUU52d0hrUVY3M2JJQXpDZG5RV0hpTkd3cWZsU0Ryak5pVU04TW1JNkFr?=
 =?utf-8?B?TWlFQzQwSW1WcUJnSWkvTGRLUlVmL216ZVV3ekJ6K0lnSGRNRHpOTEZ4MkFJ?=
 =?utf-8?B?YVFXSXZwaDd0MFRUbDdoTGpzdFRkak1nd0VHcTNDSUZtcUt5cHFuUkkrTW5Z?=
 =?utf-8?B?V3MvSTEyQzc3dFRlOVExTXdKS3A2N3dPaHgxWWQzUlE3NEtOK3BjOFREd1ds?=
 =?utf-8?B?Y05CU0dqTkkrck83L2dwSkR1dzN5bGZSTFRXbmVEYzF0Ry9nZkRybXdISHhn?=
 =?utf-8?B?UnhqTlE5UE1FNkVPWSs2OU1zTG90V3VhSzIrcWVSNzZsODBLZkd3WXlrcE1u?=
 =?utf-8?B?STRWU2x4ajNmUitpWHdobVZ4NUxmb094Q002QU1lU3NyTEUrOXFWS2VoTHBn?=
 =?utf-8?B?eStJUE95OTVlNlowa2E1VlVNQ3hCN09UQVRRMElHODRsMG94eTBjL3NsdnFl?=
 =?utf-8?B?Vi9FOWlEYThuTGxJNktIcERUa2JoRHNwemRwaVVudENxb1BwbHhReU5QNVpR?=
 =?utf-8?B?VWlpTy9FT0JSclRucXlOWU1MaUtJK1NLUUZDYnlGTldtYm1wQzFKQ2hOT3d6?=
 =?utf-8?B?SFhBUTlmd2E3WmZsNW5xenZ0bERRbDVyZGdvTUhwSFprZlI5STE0WEZYbHBC?=
 =?utf-8?B?OUlaUEJwZUdwQXp4QzhWR0VSZ24zb1lYRlRUZ3hUSk9xS1hQVk1lVDJRdEts?=
 =?utf-8?Q?k1/DO2WixtIXFoNo=3D?=
X-Exchange-RoutingPolicyChecked: kwkGDhyWUX/5YghTw93sxxC9eBaothRRS4CJ2hfjyyhy8lJn+ja7MtqTVozghVWo34De6+1l00hiFXQIzSB4KoSrD9wY8lEqdmldRTjsqivJ9olOf6xEkt7LBzuDAmkThgZj2dLOdoKh3SPPa/groDxWVqASDWZqhdx5gqjxhJDQGpE6vSA5hZ1kbxRpDfLHYW1A4k9sJR/t5MD8RyIAnmsKABm5E2aiKGmrWngMWdAEXycJeCfs83BuWExXVYtdq3ZeGkaFzxw4jedNlE7UB6n5bKwmsT8ce2lx67GfiCqReuq9ZWfp2OTPo8jB1Sq+e8f/x8C3LzhMze7vkz+JHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6108643-7fe3-4d6b-b355-08dee3142e47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:28:15.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr6claqZTKO+2TqGRVZHELrHsjsbblbwrlTWaZKXNGJ/JS9k6Skw76xfcfMuqdh1PESimBKgCLwceWR0vQHjjzEkDwQB0XqYjMOcyo4otNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8622363CD
X-OriginatorOrg: intel.com

Hello Andrei,

On 7/7/2026 7:47 PM, Andrei Kuchynski wrote:
> A synchronization issue exists during port unregistration where pending
> partner work items can race against workqueue destruction, leading to
> use-after-free conditions:
> 
>    cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init failed
>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>    RIP: 0010:__queue_work+0x83/0x4a0
>    Call Trace:
>      <IRQ>
>      __cfi_delayed_work_timer_fn+0x10/0x10
>      run_timer_softirq+0x3b6/0xbd0
>      sched_clock_cpu+0xc/0x110
>      irq_exit_rcu+0x18d/0x330
>      fred_sysvec_apic_timer_interrupt+0x5e/0x80
> 
> Fix this by ensuring strict ordering and proper serialization during
> teardown:
> 
> 1. Move ucsi_unregister_partner() to the beginning of the teardown
> sequence and protect it under the connector mutex lock.
> 2. Ensure all pending partner tasks are explicitly flushed and finished
> before the workqueue is destroyed.
> 3. Switch from mod_delayed_work() to a cancel_delayed_work() and
> queue_delayed_work() sequence. This guarantees that items currently marked
> as pending won't be scheduled an additional time, preventing a double
> release of resources which leads to the following crash:
> 
>    Oops: general protection fault, probably for non-canonical address
>      0xdead000000000122: 0000 [#1] SMP NOPTI
>    Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
>    RIP: 0010:ucsi_poll_worker+0x65/0x1e0
>    Call Trace:
>    <TASK>
>      process_scheduled_works+0x218/0x6d0
>      worker_thread+0x188/0x3f0
>      __cfi_worker_thread+0x10/0x10
>      kthread+0x226/0x2a0
> 
> To ensure these rules are applied identically across both the normal
> teardown and the ucsi_init() error paths, consolidate the cleanup logic
> into a new helper, ucsi_unregister_port().


This seems to be causing regression in our linux-next CI. [1]

<6>[   18.008557] ------------[ cut here ]------------
<4>[   18.013166] DEBUG_LOCKS_WARN_ON(1)
<4>[   18.013167] WARNING: kernel/locking/lockdep.c:238 at 
__lock_acquire+0xa59/0x2750, CPU#1: kworker/u89:1/172
...
<4>[   18.159950] Hardware name: Intel Corporation Meteor Lake Client 
Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS 
MTLPFWI1.R00.3471.D89.2401091901 01/09/2024
<4>[   18.173125] Workqueue: events_dfl_long ucsi_init_work [typec_ucsi]
<4>[   18.179257] RIP: 0010:__lock_acquire+0xa60/0x2750
<4>[   18.183927] Code: 44 8b 5d a8 85 c0 0f 84 98 fd ff ff 44 8b 35 07 
0b 72 02 45 85 f6 0f 85 88 fd ff ff 48 8d 3d 27 25 73 02 48 c7 c6 1b 51 
27 83 <67> 48 0f b9 3a 31 c0 44 8b 5d a8 44 8b 4d b0 e9 c6 f7 ff ff 31 d2
...
<4>[   18.263886] PKRU: 55555554
<4>[   18.266583] Call Trace:
<4>[   18.269014]  <TASK>
<4>[   18.271110]  ? mark_held_locks+0x46/0x90
<4>[   18.275007]  lock_acquire+0xd9/0x2e0
<4>[   18.278562]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
<4>[   18.284096]  __mutex_lock+0xb2/0x1020
<4>[   18.287735]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
<4>[   18.293265]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
<4>[   18.298797]  ? synchronize_rcu_expedited+0x2b2/0x300
<4>[   18.303724]  ? __pfx_autoremove_wake_function+0x10/0x10
<4>[   18.308912]  mutex_lock_nested+0x1b/0x30
<4>[   18.312806]  ? mutex_lock_nested+0x1b/0x30
<4>[   18.316878]  ucsi_unregister_port+0x36/0x140 [typec_ucsi]
<4>[   18.322238]  ucsi_init_work+0x66d/0xc10 [typec_ucsi]
<4>[   18.327167]  process_one_work+0x2ad/0x8b0
<4>[   18.331158]  worker_thread+0x200/0x3f0
<4>[   18.334886]  ? __pfx_worker_thread+0x10/0x10
<4>[   18.339128]  kthread+0x10d/0x150
<4>[   18.342339]  ? __pfx_kthread+0x10/0x10
<4>[   18.346067]  ret_from_fork+0x3bd/0x470
<4>[   18.349795]  ? __pfx_kthread+0x10/0x10
<4>[   18.353522]  ret_from_fork_asm+0x1a/0x30
<4>[   18.357420]  </TASK>

Detailed log can be seen found in [2]

We confirmed that reverting the patch solves the issue.

Could you please check why the patch causes this regression and provide 
a fix if necessary?

Regards
Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] 
https://intel-gfx-ci.01.org/tree/linux-next/next-20260714/bat-mtlp-9/boot0.txt

-- Bisect Logs --

git bisect start
# status: waiting for both good and bad commits
# good: [5f1b513690edf51727e6928b97705b6437f9a98e] Merge remote-tracking 
branch 'spi/for-7.3' into spi-next
git bisect good 5f1b513690edf51727e6928b97705b6437f9a98e
# status: waiting for bad commit, 1 good commit known
# bad: [49362394dad7df66c274c867a271394c10ca2bb8] Add linux-next 
specific files for 20260713
git bisect bad 49362394dad7df66c274c867a271394c10ca2bb8
# bad: [dffddeb046466ed57038295bde28b42b7506a12b] Merge branch 
'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect bad dffddeb046466ed57038295bde28b42b7506a12b
# bad: [d154d0766bf3fe830e1bf98fb2d8648294a4a8da] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
git bisect bad d154d0766bf3fe830e1bf98fb2d8648294a4a8da
# bad: [671b0fd929bec9ebf863cb376baf9b9d1226a510] Merge branch 'master' 
of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
git bisect bad 671b0fd929bec9ebf863cb376baf9b9d1226a510
# good: [f4fb100039e96211609dfc44fb24b9e4a8a0f2f9] Merge tag 
's390-7.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect good f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
# good: [c296d513e034df93ddb230ad1c7a118d6b58750c] Merge branch 
'arm/fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect good c296d513e034df93ddb230ad1c7a118d6b58750c
# good: [de53c0a584f08f31eb957f8c849a59fb33b27fa8] Merge branch 'for-rc' 
of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect good de53c0a584f08f31eb957f8c849a59fb33b27fa8
# bad: [a6969de5a038bc08a948ada52bd7199a8dfa6cec] Merge branch 
'usb-linus' of 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect bad a6969de5a038bc08a948ada52bd7199a8dfa6cec
# good: [15eab2dd63a97587405ab6bfaad9728d5b35b5fe] Merge tag 
'asoc-fix-v7.2-rc2' of 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
git bisect good 15eab2dd63a97587405ab6bfaad9728d5b35b5fe
# bad: [c2e819be6a5c7f34344926b4bd7e3dfca58cf48a] usb: gadget: printer: 
fix infinite loop in printer_read()
git bisect bad c2e819be6a5c7f34344926b4bd7e3dfca58cf48a
# good: [29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b] USB: gadget: 
snps-udc: fix device name leak on probe failure
git bisect good 29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b
# good: [1febec7e47cdcd01f43fb0211094e3010474666e] usb: gadget: f_ncm: 
validate datagram bounds in ncm_unwrap_ntb()
git bisect good 1febec7e47cdcd01f43fb0211094e3010474666e
# bad: [0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb] usb: gadget: udc: bdc: 
free IRQ and drain func_wake_notify before teardown
git bisect bad 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb
# bad: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb: typec: ucsi: Fix 
race condition and ordering in port unregistration
git bisect bad 7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261
# first bad commit: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb: 
typec: ucsi: Fix race condition and ordering in port unregistration
> 
> Cc: stable@vger.kernel.org
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
> Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
> Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>   drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++------------------
>   1 file changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 92166a3725b16..d9668ed7c80ea 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>   	return ret;
>   }
>   
> +static void ucsi_unregister_port(struct ucsi_connector *con)
> +{
> +	struct ucsi_work *uwork;
> +
> +	if (con->wq) {
> +		mutex_lock(&con->lock);
> +		ucsi_unregister_partner(con);
> +		/*
> +		 * queue delayed items immediately so they can execute
> +		 * and free themselves before the wq is destroyed
> +		 */
> +		list_for_each_entry(uwork, &con->partner_tasks, node) {
> +			if (cancel_delayed_work(&uwork->work))
> +				queue_delayed_work(con->wq, &uwork->work, 0);
> +		}
> +		mutex_unlock(&con->lock);
> +
> +		destroy_workqueue(con->wq);
> +		con->wq = NULL;
> +	} else {
> +		ucsi_unregister_partner(con);
> +	}
> +
> +	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> +	ucsi_unregister_port_psy(con);
> +
> +	usb_power_delivery_unregister_capabilities(con->port_sink_caps);
> +	con->port_sink_caps = NULL;
> +	usb_power_delivery_unregister_capabilities(con->port_source_caps);
> +	con->port_source_caps = NULL;
> +	usb_power_delivery_unregister(con->pd);
> +	con->pd = NULL;
> +	typec_unregister_port(con->port);
> +	con->port = NULL;
> +}
> +
>   static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
>   {
>   	u16 features = ucsi->cap.features;
> @@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
>   	for (i = 0; i < ucsi->cap.num_connectors; i++)
>   		lockdep_unregister_key(&connector[i].lock_key);
>   
> -	for (con = connector; con->port; con++) {
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
> -		ucsi_unregister_partner(con);
> -		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(con);
> -
> -		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
> -		con->port_sink_caps = NULL;
> -		usb_power_delivery_unregister_capabilities(con->port_source_caps);
> -		con->port_source_caps = NULL;
> -		usb_power_delivery_unregister(con->pd);
> -		con->pd = NULL;
> -		typec_unregister_port(con->port);
> -		con->port = NULL;
> -	}
> +	for (con = connector; con->port; con++)
> +		ucsi_unregister_port(con);
>   	kfree(connector);
>   err_reset:
>   	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
> @@ -2194,33 +2216,7 @@ void ucsi_unregister(struct ucsi *ucsi)
>   
>   	for (i = 0; i < ucsi->cap.num_connectors; i++) {
>   		cancel_work_sync(&ucsi->connector[i].work);
> -
> -		if (ucsi->connector[i].wq) {
> -			struct ucsi_work *uwork;
> -
> -			mutex_lock(&ucsi->connector[i].lock);
> -			/*
> -			 * queue delayed items immediately so they can execute
> -			 * and free themselves before the wq is destroyed
> -			 */
> -			list_for_each_entry(uwork, &ucsi->connector[i].partner_tasks, node)
> -				mod_delayed_work(ucsi->connector[i].wq, &uwork->work, 0);
> -			mutex_unlock(&ucsi->connector[i].lock);
> -			destroy_workqueue(ucsi->connector[i].wq);
> -		}
> -
> -		ucsi_unregister_partner(&ucsi->connector[i]);
> -		ucsi_unregister_altmodes(&ucsi->connector[i],
> -					 UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(&ucsi->connector[i]);
> -
> -		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
> -		ucsi->connector[i].port_sink_caps = NULL;
> -		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
> -		ucsi->connector[i].port_source_caps = NULL;
> -		usb_power_delivery_unregister(ucsi->connector[i].pd);
> -		ucsi->connector[i].pd = NULL;
> -		typec_unregister_port(ucsi->connector[i].port);
> +		ucsi_unregister_port(&ucsi->connector[i]);
>   		lockdep_unregister_key(&ucsi->connector[i].lock_key);
>   	}
>   

