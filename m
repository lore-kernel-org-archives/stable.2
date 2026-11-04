Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793816632;
	b=VS/1Fh8me5BEmvmfyMBdzmWXeTDhsWpKTDALu4o5ozpiGxHVIxpxR55oj2ItpxstCz66
	 j73ZYRMZBfwwuO+3pdGfAKK9JYRQIkghkwCE3NzP8/IhXQtaAnJXsI6ieJsMfOfL3PjiU
	 pOLshpwaXJJ6U5tZeLNkqeKpv6Y8f6clXV5PF5AZwGAaL16EXJNLnaQQ2cwYwmfPtBBuy
	 3r7GBxYOvIxNNbhIq9tAphXKR6E7p+gNTaGdrhHYgNhpi5nYTKQFay6wBYkoPXcjkjI0f
	 bwLAo+Sb0uznbiaide01um9IHy9X4SzfDhbVDC9eB01U2ydYtT75y5xW/o2t0PMCYlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816632;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
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
	bh=Bnuo1FXJk05i/zP9CjEx03llBpQJW/PMYCt1x6eUK8Y=;
	b=OUuZgeirMfyuesybsE+ivaHbfrV66de8RtEfytfdkhy85+TodONKhPBxaujydDJYmRru
	 ieh1/d8AQVImmg7l+jyfTTfis/xmsBNLEKTAi1LjI99oROsr8t42o0Ke3wuGUhmjqEBjl
	 9DsA1jdTg1rtvkDld2O4NDNf6dAZc4LWgO0jsNg+Uay0JSCyL7KxetEJrbXRl7fqESEwb
	 Ax17t8bo8gvtUc+xbG/bOO4Gyl5jjvihEPYzq41LJHgCECDcxEuW2gBFgqQGwm3T4NOE4
	 zhNaMfmmPuxGm4LgsiZV1PYAVDydIc/C80+SHKDL892wFu+2Nv2Vqg3izP7/trRwbtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NEO19Ubk;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE4606D806;
	Wed,  4 Nov 2026 18:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87AE4606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NEO19Ubk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793816631; x=1825352631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uPb6iCBmWz65ncxDFE+Yb9NitjwxIGLh/DNN/6s3c0U=;
  b=NEO19Ubk2FvTrg2iRwmLpsWFJSbdnqk5q5JyaFesJZGDO5tMSnFUpXZW
   pGK6hEPzHFBUjLqIfr2zL1hqX3Fh865Ju3YXoTARIp4ol7qJqhDI0tbgo
   ypyNqnxMl5WcPl7W0AXPAemsK3RWzV576HecljcvtsfTi/Zo6k53rdyXZ
   LOX8vG6QDHh1rwXK8AIFgD+H63carpkK2Pry+Q4dLADPdMo+BECXeMWvn
   QXphvvS6SEi+cC3bnYGhFOhioGzXsK+3JaqkjUvfW8th1aozwW74W776R
   BlQGcYNnBRejiySMtKTm1kV0WVDKnJ/kLZUfDUmXD7XEhLkdrUb5Lra9g
   Q==;
X-CSE-ConnectionGUID: y9E0bqswS+2Fl31T2BVIgg==
X-CSE-MsgGUID: 5DY0l3dmTjKTrBi2H6YEJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2459006"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2459006"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:23:51 -0800
X-CSE-ConnectionGUID: z+PWMh0jSpKl477YUn+BBA==
X-CSE-MsgGUID: 7fFrQZ4JRt2SK3XP+B7NqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6616241"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:23:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:23:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 10:23:50 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:23:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viQTecVB4fmPPSC2dXlsTc2AWihrqmXKaM4GCVvN4S2gOWRMXq3KbDTm6gOeIfmnpNB1UhQnxZOJ43D1WJytaDd5/WDn/HmFUriwIubHyvXn9ZP4gqcn0EoGI4O8RjsbKKhyd+8W46/ERlMSytpJmE2hwI0ReGm24nHdHNyizhx/wnIO+G3HRStJA9bn0JJq3WMPwoPXG69/yYpbQyahlPaVrYHf30qCUs5HZ6uK4YWgAEuewiUUm4ssMu4qfuOcGECeW5ZQ1MCL/lCMQOo4pU6rBHY/rGGzqU5ifpjuO/OzTQKnv6cn+EosscXQAxJABythxP4sZrpt7OnIl+YGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnuo1FXJk05i/zP9CjEx03llBpQJW/PMYCt1x6eUK8Y=;
 b=ct1Qu9JI1ge055VvbSfyKKpFhGEts4i0LltOgheTfDEESUV2ltlLBEjo1wNw2Chus2LMlA/gXvdM7I6irP6P+9Xs1GCiVeaTWBPSyl+aJD3tPBDhcImX6LLKO6di/tpkvjDWJ3+4RPNjSsXppZEim1x+JdrFj7r86CvcH6mTdcTK9weGpnpZ/VxPsoRoGwwXvN59dS36TNSfDB+lJUXKrHV6B+KM5IcYesb2RavTY3tCspGjfLFV/IYGYjb9Mzw2mW4YknW5PBdjwMEb74scXghPTOXZk0U9GZlkDZ7tl3exrY0n2xdgLbmAOaLEyoKeQ8JJdrpo3zqcE2TybEKAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:23:48 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 18:23:48 +0000
Message-ID: <316d51ce-9a41-4bf4-b701-1da0cbe92bb3@intel.com>
Date: Wed, 4 Nov 2026 20:23:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Unregister all clock providers
To: Wentao Liang <vulab@iscas.ac.cn>, Michal Simek <michal.simek@amd.com>,
	"Ulf Hansson" <ulfh@kernel.org>, <swati.agarwal@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261103100521.1309763-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261103100521.1309763-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c01e33-038e-49d8-7957-08df3aa0c47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|11063799006|56012099006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: dJ3frTnJ8jc4Pel5G7Cf5q3Ldbv18BkIeO99EUHrCb+vatBbwY7aKrXqRKlGA/QUcQIk+9gXgX0LGmYdFaQ+j/ZZEeAbCEAJ5u+CZjb9wwPL76sblAKTCBo+FnFLoz0Y1i3wjGCDf7iIGXqNL9JYiB0KyMis5bjTKv/D9iUSIhvKYh4LSHSBC+PAEsfbeACEARfrPOIKfwME/l1GuElPIFiXeorZKwioH2fbWLwumF5cZ0Vk5OW5lc8QCIU05R8lKypfB6cBZTyLvxdgFriGyGnlMjv9K/3xtZ9WA7akvdhkZfUdtEOeCCp0+9vG0HX93/dBSy1AZSTi8+ghC01PjNzbwjpuKcQ7vI/Zz6YaIYYxp7WLpkU1rKPqGcKv2N7nKioL8QewNsNYOmxxGX8MBCRM2teUx7IHF+mCtPJfXFRXtJ9swyiso1crZM/rszgcjH9xiZ8dIOOoyvoHaQ73zFV79LId3UIPXF/vIvt7BcGZX4SeRfW77XGMO/LdTIOvhMWrHHBs40plVQvYPInYbqKi/W9Ezs39ewk4bLpZp69CR4aq1gVwXUZtnhWFQ+fCozv3HsRD59s6CC1btEby/jc8YwcTFapw0syo1oPvcMP2H8ZLgXZyRdMgEx2VtDfPZum3iaY51DTmBtov6rq9b6Er2DX8PI67S48/lAUix3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpaWWJOa2NkNHRyYjdkcVJTRlFMZDQrRkVHRi82bG1aU0hYS2k2cHVoNGJV?=
 =?utf-8?B?cSs5alBBMmJ5b25sWHp6NWdnaXRVbHNKNFZkUS8zZ2RPQkFOZUUzQXMzbDZM?=
 =?utf-8?B?Z2M3b3lPZjNNZ2paSnVjRSs3V2FYMzJkWlJCR0RNMUVleGcyRlhhaE96SlhT?=
 =?utf-8?B?VStjNWwwSlE2V3hHWno3ZjJyNS9lQmROSFZwZkNacmN2S1Fpd0trUTdTaDZz?=
 =?utf-8?B?OUZvWnJ1RXE2a0JrRUREZTIzdC85SURpN1J3ZjVIQmxIOEJNZ0RoOEl6Mll6?=
 =?utf-8?B?dyt1bXUxM1R6eEFhcmZNNUN2MXEvYURjNTVVZENXd21XQytYdnpvR2ZJSUpJ?=
 =?utf-8?B?ellOdVNyVTdqT0JFTEhiZ2tpN0dVLzUwSnJRcTN5OStNVzlVa2hxTlFnQWQr?=
 =?utf-8?B?YS9KYmVJQXl1VE9OeVdZUWVxdnRFMHcvZUZVZzFNeStNU2RtdklGTUlYMUxF?=
 =?utf-8?B?eDRCNlY4d2ZyQmVHNHo4akV1djhoSmxNdlVBemVLa2tTUUVFYjQwamRnNUdn?=
 =?utf-8?B?WHlpdnFYV2dZK1FkcGVJU2hPT2Z6S1FQOVdCcDBabm9YM1cvZFlNL2JZMGtE?=
 =?utf-8?B?TUNZeEE1bHBEME5lVmFzVVdhVEdjUnNJZm9rMDluaXBvQ2VMZ0VxbDR6RVdZ?=
 =?utf-8?B?WWFoREt1SFYzUWJrRUxkV0pJZ1lkSFkwYVlqNGhuYklPM1hoa1FRbG9lR3Yv?=
 =?utf-8?B?cWZpaW5RKzdJM2FDRnpJYW40Qm9CSnMwNHVaTEVwbUJVQ2xQOGJJaFcxWUhQ?=
 =?utf-8?B?UFh2ZktneG14Y1QzQ3Bhc2k2N255VzFtYm0wWWVaZHg3UE40UlBJMHBoU1Zr?=
 =?utf-8?B?NXZGUW1CU01tdkxXQXRkaGFFN0RwdFF5NzF2QnFTZW1MSmNuL3VvWGN2Rmpi?=
 =?utf-8?B?dlRBdENTazFmVFNWdE5VeUp0VFBFb3F5UjNSaWtyMDkycDlENitlcENsWk9G?=
 =?utf-8?B?RHJJbjN1bEo4L0pIcU5zQmkrcTFIQUxiVXNheHg1dUs5S0hKdWRzTUhHTDJl?=
 =?utf-8?B?bXQvaVdTbk9hQngwbFdLL2lrcUNMQTJ2VSs1aEpVYnU4VURKcXEvc1JWL0F5?=
 =?utf-8?B?d1BBL2NvNW9qNG56eEdZdmtEREtFTkZKOVlnZ0d4TnB5N0xPZDFWd2NoU29y?=
 =?utf-8?B?YmdDZktLUms5clE4U2R3WllTVTZSeEtrWVRuUEpDY0NYeUh4V29pUnJrbEQv?=
 =?utf-8?B?TFk1VE1kRWVtb2Y3RmFmdTNCTkNScFI2c2U0VDZFNENKYStYQ251ZEFuQUlp?=
 =?utf-8?B?ZE9KbzdTZHBZMW5QWG5oU1E1SVdxQnIzL1NlaWtDbmhlUFlIV2lNR1dnb0Fn?=
 =?utf-8?B?Q1gyYkdhajFsS1gxOCtnaTNTSmpycHJqUG9PaUxvTEtPVWR1L1ZVdERpN2RG?=
 =?utf-8?B?cmVjTURmY0hReHdxUk5nS0VsSzRlbTNrRFVyaDBsaTd6UnhyTEd4YUU0c0Ux?=
 =?utf-8?B?SlFxU2dySGcxTndNZEJMa1QxSStaSHdKOStoSVQ4NTFWcXBUMzJ2anZZbWIr?=
 =?utf-8?B?MmdNb2NGQ1RqZHhhQitRUFN4K0ZZeFZic1pmRis2dzJ0dWFSQ2JjT21sNzBW?=
 =?utf-8?B?ZmROMkY3Mk0rRDJhbGZtMGtwVHpUb1ZodllYR2pnMWY1QlVuUHlCZk4rK1E3?=
 =?utf-8?B?WncyUFZRQnl0b1F0T0pMVzNMWXBpdkFWOExWVFRYbGtHWkZrSXBwQkpybVFi?=
 =?utf-8?B?NlplWGQ3bFdEcDQzK3dxcXI3NGpWNWM5cVE0cTFNRnBTaDJMakEyQStkSkUy?=
 =?utf-8?B?blQvZEVxaXVsWUlWNUlhcUt4T29IWkZraW5jWG55U1lJc0ZmS2hLcmRxL1Yr?=
 =?utf-8?B?M0VNcTRSbFAzd2NUVWozV3RPU3g1UFhYeUdTMkRObnBYR1I3NjVsZy8rd0xD?=
 =?utf-8?B?aDJ0TW40bndhNkd1TXpzei9zWFJmdUowdldXYjVHV2NtUnBuam53MlBPTUNr?=
 =?utf-8?B?VmtqMU96SDE4WEUxOEdENFpjcVUvNUJPOTN0WUZQeVJQMXJmKzhlUDF1NGxa?=
 =?utf-8?B?VE1vVXNBLzQwNVdGWm1vblg0YzlyeHc5V2Q4eHVMZFJmL1JueDZpSXlIMmg4?=
 =?utf-8?B?MWJnanR0YzE1YmJHVXYvNlFEVEtObTc5NG5Lek1lbmZWR1NzR0NmUDNmVStL?=
 =?utf-8?B?cm9rbUNNL2dxTkJlWE1JdzRoZDZ4Nk9NZTRPUWwrRFRSN1Y3VVBXeXB6bE1W?=
 =?utf-8?B?SmdFWnU4STlTeEYwQjd5RGFyeGk2THphaXloeXZLL1dGNVh2TExqejQvdWRW?=
 =?utf-8?B?U0lhcjN1ckY2eDZxR3c1bVR2ZmNCOHRpanJWU2ZkdFFBcUorZGI3Q1oyUzBj?=
 =?utf-8?B?QUlYUzNldkoybElqTERRb05obWI5Y29kVCtVaDhRRlJ1VWl3WUQrRTFiZ0gy?=
 =?utf-8?Q?Nvd9Rq5FpmagLkP0=3D?=
X-Exchange-RoutingPolicyChecked: TvQBQkCn+hGvxl2/0EtbqXzmBYezGVhLkf7u7fJco9cqH7BNokzvOwxT9ZWZJegvR9KzjGIXWMxZZymxBEVSD7BBlvFm1BuXllRxVvr6q6kJu8Y2OBCeKvKRGL0nbYCAb+PDyOYw1wOftBbHvOuTuWpFMNDHakIiLT70+ffrxe7GYKa6Wok1YC93MJnN/khpcJgvUNNCCAZ74azWJ6Hf7ZGE0RU+gSx26S7r5GkLpAUHoF7npZRZMBHHjjeWj5eTp0mcWuXOGnLiIj26UigEF0lZPjS4z2arc42EkgTG+DcGp7UuSXIK+4XPq/ldiHHkIhCczWDiZc+tN9Z74apFFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c01e33-038e-49d8-7957-08df3aa0c47d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:23:48.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdChE21U9mhzg3XqmAtbidXnToMAsfGc6tfxXjNsDJzcOW0rl03Yvt5YZXzfQkmubRHh2bWNMDPxALMxwybTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8393
X-OriginatorOrg: intel.com

On 03/11/2026 12:05, Wentao Liang wrote:
> When #clock-cells is non-zero, sdhci_arasan_register_sdclk() registers
> two clock providers for the same device node: one for the card clock and
> one for the sample clock.  of_clk_add_provider() takes a reference to
> the device node for each registration, but the unregister helper only
> calls of_clk_del_provider() once.  The second device node reference is
> therefore leaked and the sample clock provider remains registered after
> the driver has been unbound.
> 
> Drop one provider for every clock that was registered.
> 
> Fixes: 07a14d1df454 ("mmc: sdhci-of-arasan: Add sampling clock for a phy to use")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

"Assisted-by" tag is not used anymore

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Looks OK to me but maybe someone who uses this code could
review or test it, since Krzysztof has cast some doubt on the
contributor.

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 0ee22923ad56..dccd2980fdd6 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1648,11 +1648,20 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
>  static void sdhci_arasan_unregister_sdclk(struct device *dev)
>  {
>  	struct device_node *np = dev->of_node;
> +	u32 num_clks = 0;
>  
> -	if (!of_property_present(np, "#clock-cells"))
> +	if (of_property_read_u32(np, "#clock-cells", &num_clks) < 0)
>  		return;
>  
> -	of_clk_del_provider(dev->of_node);
> +	of_clk_del_provider(np);
> +
> +	/*
> +	 * sdhci_arasan_register_sdclk() registers a second provider for the
> +	 * sample clock when #clock-cells is non-zero, and each provider holds
> +	 * its own reference to the device node.
> +	 */
> +	if (num_clks)
> +		of_clk_del_provider(np);
>  }
>  
>  /**

