Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030A416856;
	Thu,  1 Oct 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872525; cv=fail; b=HIrQMgkw8qwUfzk0PVwz8HPsPRob6VanuXvEE8Ls+jfNhtOozSwW47tTVO8nvni4Ra9GAUqSsSfq77xHoa0AMYkOnrpf/Laz6C3EwhWIEec1yal0O2bhIDNvAfwyA0bchkH8G862Lqem5MlSQlGv9iQWlCE/3UE4xKay8gTsMic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872525; c=relaxed/simple;
	bh=kP+t8o+SVnDxjYx5kDCCiI7HMDWgReZZi/P+quXPQTA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+guGA2HbxzNPPKHzraCju/v6IJ5bq7eSydYXNoVRRQYpl6p6rbs4opIPWBYEoyOvi26C17BBciIn9nofyakLwkIqdogxdq6wEtWZMxh5SUE2F3M4aXxu+mpJUdmnEkCIzMgNe/dvWm65EJO+GoEzKE1iAihYv3yUZD6o/7s4Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhrfV2ui; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhrfV2ui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790872524; x=1822408524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kP+t8o+SVnDxjYx5kDCCiI7HMDWgReZZi/P+quXPQTA=;
  b=nhrfV2uirT/33/1diw0p5Ktg/LsniUC+DF7qkftFtP4YhamPqzTwPKyM
   3aLftajUi7JB/Dj4W1lG9qBApCpo3nZfEHbclddl25H0+wezkbQvizsSb
   D7KsgMyv8EA4rqAa0C8IS96oQi6lAa+GnYUKuvvVB5TCfqzdUOeEqb2jp
   uH7FPcJW5HJth++Bod6kaBLA5v8Ymuk0oKM058MM3frUWiP19SL6ygsdb
   ynE5CfqtXI+/3Yy+Gy96exoRgdjkvQv5GV54zuHqddUoceTIr7qypsZGv
   wOL2wnNtBBFgkMfQo3ghtJIdhShrfr6iv2At86PJ82aSbskcL53j7V+j6
   w==;
X-CSE-ConnectionGUID: oKivcumGTVSgX94J5CQ9dA==
X-CSE-MsgGUID: +AMrhW06TpabLDMwaq0p9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="79195910"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="79195910"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 09:35:20 -0700
X-CSE-ConnectionGUID: Ki/dI40AS2GNds0xLutlRw==
X-CSE-MsgGUID: JuKMLy96QAiLy91kGPMe/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="275245659"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 09:35:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:35:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 09:35:14 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHi5S2a5y7x0ALFNwqjVXpNL55oHQmN5yJVSS0Z6MmVaxn2ysLijf70/eCmXfViw9tzpvN4+i6RfCJWGbWkRFmdaaE8Axqrhd+QumpGY/vqtlCzHdL7itPOl6BELh2xaFdBAlSKKkk0Fi2HZrxM05l8A2AIY1D++6epWYzBEpaKYEGEDz4rDyS6VYzl2cZxgtSSpdRwRTMT8UrpnVuKmaToC77j5KN2d6te0bzrNC9c1VzdahrGNLAO3PoBvFM2qWMRCGRrbLJH6QG+/XNRcoJuOvp40VrZkRLFj//05+uTcFqGMyWN3sumrZfmn5+z8HFtvf1JC/sfovFiBKGwm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv6XOOiV77yXu7xJXQHH8Qq0xB9nk/a3/WAla1WH74s=;
 b=sfsOowIHwGc470NDpKSvtkrpsyDnRmKdJhpn3wSaCQw6jRLj27NiGckEtGhoGyLffcTMUTD5O8usrR788ggSx8LeWPYHU+nkbRro6cSIM2jZynO3E+VtIf4tdu8NuqUZFVKTzDfuT0A9D6sF96HnqanJJaYHf7ymOfbYghRKq68kqYAcLMm8q979iwZvMAELhPcDsus2YZiVYGWJYziiPjH7bJL+opMb8/m22TGJXrnULafeS4e6mzJSGG/4DD267YztD3AOLt1tZN4pqd3F50Sc8oFzQ4TI//vS35V/ld/Xj4PTpRMWfT5rzG3Npjj0axLkkDFcBQ/0jYK3X4tmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by DS7PR11MB9497.namprd11.prod.outlook.com (2603:10b6:8:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 16:35:12 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 16:35:11 +0000
Message-ID: <c3d45d53-31b2-4977-9d35-f346e54e7935@intel.com>
Date: Thu, 1 Oct 2026 09:35:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ice: Restore Ordered MMIO Writes for Tx Doorbells
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<david.butler@appgate.com>, <emil.s.tantilov@intel.com>,
	<luoxuanqiang@kylinos.cn>, <bryan.fraschetti@canonical.com>,
	<tristan@talencesecurity.com>, <tomasz.lichwala@linux.intel.com>,
	<horms@kernel.org>, <aleksander.lobakin@intel.com>, <stable@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <aleksandr.loktionov@intel.com>
References: <20260928230429.495442-4-anthony.l.nguyen@intel.com>
 <179072991356.434549.1211761359531074249@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <179072991356.434549.1211761359531074249@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|DS7PR11MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: e7761bcb-72ed-4913-8373-08df1fd9f6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|11063799006|4143699003|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4984Ha5BtTUJVL2GmumLdvYFUUAYVIi4SreYzvY6wpUhOLAdkBeA4dqOmOMdo83ZUTVvPCx6Ek0eQ1YbJ1YuUwjy8gEIk95fBneqNJkTRgjdBWQLU7RQzsmAPXZ3Tv3M7KDHoGM6UCKjMhGkiEvyCXzItmhGoMFAqhTXipOBz5i4r2Slm+f1tlgioXp5EQT1ruEOI39Yr/jN05159XTrHJE9Ymq4QO61vgQRvbOF4DxvWyVeJaMmlwL3SzX7k58ZkRIa3KnAft0mP/1eKF/ZeqI8K2O5ZoQrI1/V1yD+J9Y4fyigWeScZHvzqpMfJYQGGlHeuOedyZNZQ9KX/lne7o4WX8CkBPXwNXqw5x/RgS30QPYAZjj+fIAZflvZFTu93DEaSyBVjt99vBVzjFSPcdiNIzEx2eyr0p10gL5i/HTBB9nR1LbCYVAKPuDxfNUlYPxSqItnuTYXdw3sm0NOZ2WWNf/d2CFygInsnp56osH2nG+pfaHgwvWkideXe6esAjEXArC8J0UdrefrVNLZL3K08lW4WrM3QZ8lyjMb0yPWSEF/sH1efoa519CCB/hfZ2dg20ovl3aPBgwNsbEPToDO/jNyx5fa2EUHa3F4keGMUKQDKbetiUKY+gJzBQSypsXQsfIzYLRbNi1rX3KVwJa9kgoz/2RvWX3hpwFk3EU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGM1Y3BTcFFyUjVFaW5tNUZNZFMwb2hEOFR1NlhSNUtMYWU0OFUrQitBMmN6?=
 =?utf-8?B?eTlId0huRHJFWFZqZkplUzdsYlZRUTY1V2VrUUxoa05nTXp1UEJvbUJnYnFJ?=
 =?utf-8?B?Q1djS0tGY09ZT3ZYT09NRTJFSFVGZ1k3dTZELzRjWFRRM3NVTUVrZHBEMVlU?=
 =?utf-8?B?QXZHOXMzelJWemdGRmlVRlBKZC9oaldtcUJxOHM4SUtjdkJMcWRybFcrOXMr?=
 =?utf-8?B?WVhrazdPK3hwTE9nbGhHRkdCcUV5RUZhOUM0cERlY2x5Q0dQN25MNmNJRVpt?=
 =?utf-8?B?Y1FYV1pMRFo2bmJjU0pGaG1iSVRPRDVNY3VtVllVeHpvSm5iYWRKdU9NYmEy?=
 =?utf-8?B?WHozcmI3RG4xWGFOdFZGWXVLOUVVLzhFQTVsYnh1R2VyT1c4akpmZG5NN04v?=
 =?utf-8?B?ZGllcGdlWWZWVVNFbktNbll5bGZOLzNXYTFiUlRRYXYxODdoOStqc1pvS09V?=
 =?utf-8?B?ZUVtWDdmQWNhSndKSWR5eFRSeUM4VjRMQW84YVg1bmNYdjgzQlZGeUZvMnRt?=
 =?utf-8?B?V2xTV3JpeHpXNDBsVHpvTFpWa0F5Tzl3Rmd0ZnBxaklkUk94cGRBN2hEQ2Zv?=
 =?utf-8?B?N3YydlkxV0kreEw2eG9wK0tiMThIRzBycUh3blZCWmpMTkI0S0k3QWdhL3Q5?=
 =?utf-8?B?eU44bXY0UEhtcDNOSFFlaDEvK1g4eXk3NUJhS01FU2xzb2dVQzJIeDhJbTZ2?=
 =?utf-8?B?YUFXai9PS0Y5NjBuK2FUVmxmUzlxVFBHSDQ4a2dySStxM0h0clRBK2owSWVI?=
 =?utf-8?B?NGRjalFRKzV6cStRWHNRbmZPNi9EL2szZVlrQ1dkUlFmNWw2ZnZRNHBuQnc3?=
 =?utf-8?B?R29oMWNCWTcwVVRwcExLTExUdjI4Wkwyd3RReUxPNElHdjZWcXIzZXE4TTEz?=
 =?utf-8?B?c3gvUGhVOXo5SG5jOCtzTWorbXhHTDNaUmtWd2tyZnZQblVkRkk0ZWlKeGgw?=
 =?utf-8?B?TnlpakJxSEZDSXZjdnB3RFJ1SFpMV0pjYlo0VHFSdDBEVWY2L1BJalBpL0hC?=
 =?utf-8?B?MjNwaUNTLzNDV2w1eDQ1RFNISnlScE5yWlJCL2NZTEZoR0dlQ2VTQjZKS0Vm?=
 =?utf-8?B?OXRzUHp4R2NOTUkrSnNjVzBWQis2WS9xRmZtejdjdWFkVWp3THBTYTlnSUFJ?=
 =?utf-8?B?VFJ3S21sb1ExQjZ3enlxUnVtUlV1VGVPOVBBYkJETXlqcVpFdEk2NVcwbGhj?=
 =?utf-8?B?aTE4cktkb1h1alhTWk54eWk4S2VvOG5xS3V0UjNTbFQyazNsSms0b3dPUFkr?=
 =?utf-8?B?b3RhS0cxNDVGekhuYWFnU0lhNk1SekZNZWJXZlBHd2cyOXYvTHd5RUJxR3RO?=
 =?utf-8?B?OHhKaEtFeHpndkhaUnBxaVMxZ2lqNzJ6bk93MmxsazRVRlRKcks2djJ3MEJu?=
 =?utf-8?B?RVV5OWhaYnBJanVBWnpKbC9hbFl6cjQvbFVlTWtDbTZQSHZmS2YvOGNZRFNT?=
 =?utf-8?B?UzY5cVYyMlpoSkJiZG1QNjg2aVBjSmRNUFV4WFVrb3ppaFU2N3RmU1Q0Ynh2?=
 =?utf-8?B?WHdRNTMwaVhRSDRFNnVYTmtLNmNGc0d6OXAvdlhENzViTEpSV2JBTGJqTjBp?=
 =?utf-8?B?UnRMTEFwNWc3dGtVKzc4YUJtNkdibEtSbXNxUGpHZmtBWmhEWTNkNHB3QU9o?=
 =?utf-8?B?Z1A1cXo2VDBkTU5qK2RSVUtXejRETFh0OGttTUpGaWNBV0c1bnZmdVJaSW41?=
 =?utf-8?B?Y1ovemtzRklzM0wzSS9INElwMCs5K1lWRGdGRStHK2tOaHFLZWdhMVc3QTRk?=
 =?utf-8?B?MEc1WTE5djdWOEJ4czZEeHBIeitxNzBHdE1xVHBHOW5md2ZKamc3Rk9nMDh5?=
 =?utf-8?B?UjNVT1dFZGdITHp4RU1kRFlrZDNqeDRZY3ZHUnRBYXNQQXh0cUJUMnJQV3Q3?=
 =?utf-8?B?NTNhSko3aFVrcVhvSHhpTmRlOXg0L1ZCMTlkSHoxRjBxK0FqRlBaOUhsajVY?=
 =?utf-8?B?NmtyekJYSGEvMEI0RllsNTQ2OXdOVzFpQnVpckp6ak5LSmZvbW50OGRNaGJh?=
 =?utf-8?B?VjZUaUtic1lRdVY2VnBmM0VXMXJjSFRIZTllemJscUdzeXNid0xDR2kvV1R2?=
 =?utf-8?B?MytYMklBcVFpMFZ1VjRsNjRpL214WFZuQi9taXQ5SE1tTHJMa05RZ0dMUEVs?=
 =?utf-8?B?Ky9NY2grSFZJUDBsUjZFVXN0RDgvclRTK1F2SWhRRVVLd1Nrc2dVRGdhaE1X?=
 =?utf-8?B?d1F2Yldoem4ybkZldEFJbDlSOHE0a3JBcDdBUzFmKzZydFRUL1NvbUEvVXQx?=
 =?utf-8?B?dmovWnpXT3d1SlJOc1BVaXFBbHFHdnA1RkhqemtSL1doL0dzRW0veVlLdVBW?=
 =?utf-8?B?Z1FQVVIwYk1LWHY5NCt5UU1OU1VuZmpuQXZXOFJDcUpVV2hPUlpyM3MwSVh6?=
 =?utf-8?Q?XBvSyspuZKuscdxc=3D?=
X-Exchange-RoutingPolicyChecked: JXDhnWsAoUc5eNLjp1Gy1LxYbo0uKb+JOwQ0u8CjQAp/qzLdp5wekm9Yw/mIUnzUkf/Ee9swuG7EqLfokKtZT6xi/Yh0h57UtBG/XUYfBhsX3r1tNyjIZr1exfeGqI9I006ZB+PT7HmbeEOt8PggmhKGsk2y5+pfzjUuzbjv4YSy9Jlyuff+xwzuNJzYq7V5tawgYiClegwY/57vgSO1a9++YmSohMrX3J9H/V/1Y1Bags+azJpKR9oQz7N+lYrV4UpU5Vgn6RN9r7VSrvb7Nozo4+R+C9ngyK/W1sXsFp6jL9dwwgtTy16UbNeWHT1cY01KtQh+kvZRjeSqAIy5Kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7761bcb-72ed-4913-8373-08df1fd9f6a5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:35:11.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEBGP3x4PQ0WYhgR7im4zwrTXSHi9A6twETOW4qQGSllQtUG0TGyU5CT+LwzxvOri3Ld/des8jgg/1yoc3yGcPJD5Ipk05Mqods4pnDNhww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9497
X-OriginatorOrg: intel.com



On 9/29/2026 5:58 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch fixes only the writer side of the ordering chain
>    behind the dql_completed() BUG_ON.
> 
> --
> 
> ice: Restore Ordered MMIO Writes for Tx Doorbells
> 
> This commit changes the Tx ring and tstamp ring tail doorbell writes in
> ice_tx_map() from writel_relaxed() back to writel(). The goal is to make
> the dql->num_queued update from __netdev_tx_sent_queue() visible before
> the NIC can start on the new descriptors. That avoids the BUG_ON in
> dql_completed() seen on arm64.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161572
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
>> index 31303ab5be175..a2c7c4962882d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
>> @@ -1561,10 +1561,10 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
>>   			}
>>   		}
>>   		tstamp_ring->next_to_use = j;
>> -		writel_relaxed(j, tstamp_ring->tail);
>> +		writel(j, tstamp_ring->tail);
>>   	} else {
>>   ring_kick:
>> -		writel_relaxed(i, tx_ring->tail);
>> +		writel(i, tx_ring->tail);
>>   	}
>>   	return;
> 
> [Severity: Medium]
> 
> This orders the xmit side. Is there a matching read barrier on the
> completion side?
> 
> ice_clean_tx_irq() reads the DONE bit that the device writes, and then
> completes the queue:
> 
> drivers/net/ethernet/intel/ice/ice_txrx.c:ice_clean_tx_irq() {
>      ...
> 		if (!(eop_desc->cmd_type_offset_bsz &
> 		      cpu_to_le64(ICE_TX_DESC_DTYPE_DESC_DONE)))
> 			break;
>      ...
> 	netdev_tx_completed_queue(txring_txq(tx_ring), total_pkts, total_bytes);
>      ...
> }
> 
> netdev_tx_completed_queue() then calls dql_completed(), which uses a
> relaxed load:
> 
> lib/dynamic_queue_limits.c:dql_completed() {
> 	num_queued = READ_ONCE(dql->num_queued);
>      ...
> 	BUG_ON(count > num_queued - dql->num_completed);
>      ...
> }
> 
> The smp_mb() in netdev_tx_completed_queue() runs after dql_completed(), so
> it does not order this load. On arm64, a control dependency on the DONE
> bit does not order a later load either.
> 
> The barriers that happen to sit on this path are not always there:
> 
> - The smp_rmb() at the top of the ice_clean_tx_irq() loop runs again only
>    when the next tx_buf has a non-NULL next_to_watch. It is skipped when
>    the loop stops on a NULL next_to_watch or when the budget runs out.
> 
> - skb_unref() issues smp_rmb() only when skb->users == 1 and
>    CONFIG_DEBUG_NET is off. With users > 1 (for example pktgen with burst,
>    which does refcount_add(burst, &skb->users)), napi_consume_skb() skips
>    the defer path. The failing refcount_dec_and_test() then gives only
>    release ordering.
> 
> - u64_stats_update_begin()/end() in ice_update_tx_ring_stats() are no-ops
>    on 64-bit. dma_unmap_single() does nothing for coherent dma-direct
>    without an IOMMU.
> 
> On that path, can the num_queued load complete before the DONE bit load?
> If so, it would return a value from before the xmit CPU's dql_queued()
> update and hit the same BUG_ON this commit is meant to fix.
> 
> The window is probably very small in practice. The num_queued store comes
> before the doorbell, the descriptor fetch, the transmit and the DONE
> write-back, and testing shows the observed crash is gone. This reader-side
> pattern is also older than both this patch and commit ccde82e90946.

Seems this is pre-existing as the review states this is older than the 
patch and cited Fixes commit. Sashiko points out that this "window is 
probably very small in practice." This patch is essentially reverting 
the change from writel_relaxed() to writel() that was done in the cited 
Fixes: commit and existed prior to it. Can we take this as-is as it's 
resolving a real issue and this situation seems unlikely as stated by AI 
and we have not had any reports of this.

Thanks,
Tony

> Would a dma_rmb() or smp_rmb() in ice_clean_tx_irq() help close this
> fully? It could go after the DONE check or before the
> netdev_tx_completed_queue() call.
> 

