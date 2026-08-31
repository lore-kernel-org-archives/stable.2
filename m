Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABE37D12F;
	Mon, 31 Aug 2026 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213490; cv=fail; b=uNLmKe7Xny2hqjFmiyr3O+4R99I6rWCD6HWZsGsylJT+vnXQxzHaLDlD2ol7vT8y+wZKYoF0j4MFFZ5s4KurJYlE3W2I/GbV6/zlR94MqtKg2GLhzX+F+Fft3MKa26ub6QZTCG3LaBaJIg/U8UlzakYYtgHcoCXZDLSHk5/Idrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213490; c=relaxed/simple;
	bh=2E22gummJcppUtsypUzp7HL09SwKGtEUqH6GNpy/YsY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PbVC0EYVO+lpCzuwU6VWSdEb/HhAfWUJrglaInpG7j7lUUvfa8WPt0QdUJFzC0zuevnZJo51SHpL2sdAjSctpQwsKS/2Bo6XKo2Enif+4kH2xWne6rE/swDV2l7z1SzVz/9hBa7vWF8yBqucUd2ikW1DwLkF3zmv5gqWyusjZyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d++eSCI0; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d++eSCI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788213488; x=1819749488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2E22gummJcppUtsypUzp7HL09SwKGtEUqH6GNpy/YsY=;
  b=d++eSCI01Bk9ZCsVv8rlB48KvYABG5KEyUqHTW6PLsluqtPtrG+lgpt7
   5imuKQ2KOQTKaqjAPislpV7pDjUyMjMAEnKMK7qN6H+KEjg3s1nat3VDo
   F9NG6oeDtWaczPOZQvQ3w2slZsDTMYEku53fwQU8s6SrrV4IZI2ZoY4+3
   GBi959yitp4XfZq+YVJ67ar4tcTu/i4MxnNPeTAj9/R1c+hvJJfOwZga5
   aZWBkHaK0xCxxO5VIDuxYOHeiFABNVEd6yelGKldZo3P8fNzb9Dj8Rp4x
   aSBvcfBUBu9u9XlYYb4K1rn7ajZt0bva6gOlWWkzSnxOWvBg+0qpyEsYk
   A==;
X-CSE-ConnectionGUID: ZjPLLjvIQ/qEu2SPEzPefg==
X-CSE-MsgGUID: la5psdofSx23AP2vQBphgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92497682"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="92497682"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 14:58:08 -0700
X-CSE-ConnectionGUID: 1HBiqKBXS3CV0u0wy+UJwQ==
X-CSE-MsgGUID: q6IlF3vEQvedvOpjJXw8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="262773019"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 14:58:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:58:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 14:58:06 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXFjoaQmu1o5mTAf53a8gxTMXfXUgIPu9bO9bdwEAhKsKW5hhlrOh+eMP30Ok/+yKgY213XEq6N5UHPYnSot2YulmK0QzSlNB4LKMlnW3wnHlqT4eIfQMP5lVUCzXSZYGGoOn/XqtvLkCM9W3L3JzYrHZzNBTvXx8snkxRyi8F8e8vdhpG9kMXe5/KO4/EN4WGLVMpcCefsPmGZ6E4Upt+OsfPy2n4wzvDz3qMBUjNGUgMruteMAZgCD3Rq5CKDzR+KWfrHDZq8MgutZDa/pY+mM1gzmt+gTVy5deuhxgeFU2/5/sIIetyt8JsMxzsSJ8k8/FOeIpmW9jc/pi2Lo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzXlvMJodwDE/y8rjXcQ2+VzKwf4gA3OLf0evAqkxiM=;
 b=EI0WaVFRBJmUYn76bZ/DznLOtQRHOm4KXYYpViKcRzn15eM6Q9Gfec5rlBF+XvOWlhYvZty2nOs8YIDiu+CqGxYOrDiMTTsu/KPPl3Z5ODBzUpJElPRi0KgEFL1e1XJDmFFavluLYDAIZ02lCw2ZH2DMMUGeBHyYBv1Giz3jxpbp6TOV3axSl0yjvlRCf5ZDNbq+tCDx/WQDX6jDmMM8quroZNMAl4lZSHtoZu9SxWP8cpsJoLIyNYLFBw0o70eTxcrwiEOiuQ8nXlSbnkPKArvSlJkDKwdSWc0y7RmZVsdEGXprs3qkVWxn3/jscdjl25bioXB/2uAiuzisRMXxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:58:04 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:58:03 +0000
Message-ID: <8ab343e6-1bb3-4213-9fad-fab43bf40362@intel.com>
Date: Mon, 31 Aug 2026 14:58:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] iavf: add missing PTP adjustment callbacks
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Xuanqiang Luo
	<xuanqiang.luo@linux.dev>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <richardcochran@gmail.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<ahmed.zaki@intel.com>, <mateusz.polchlopek@intel.com>,
	<saikrishnag@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, Xuanqiang Luo
	<luoxuanqiang@kylinos.cn>, <stable@vger.kernel.org>
References: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
 <ddc21a8e-b2dc-41a7-8390-5642664f08ea@linux.dev>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <ddc21a8e-b2dc-41a7-8390-5642664f08ea@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV8PR11MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: d26fa58c-defc-4ce7-373b-08df07aaee60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: MVTOZOH7YGCxo92r/OHaHOt+Xy+DFuWzmL624GNbBHLOX5yYcTlS3O2T5sh65OyY6sZIY0t0z/FgfUIjHjoyC1VkqfCD7wl1kxSCVXUvt720UvV5Git2eLK0aDTB2TBftdO5Z339O5d+tbQ94nLHaLrxj4fp80nysXyEswsNC50YOGAm4PNLTLkWWEMvF3//3NLqCry3V44rKurKqPBkdxrP27uzGqmRyBArH9bSmJVtp7Xsyr6q7Y7iP2b3wXR+26Ea4Mqek6V7x4u19nl6yrYU51vKU9KkrkWzCnF9R2VOVU4mSuwsepk5OKw9q8OXy5IfTQNpmlkWICeyxsABIcu8YkgxsFM/HwICMWfpHJUh7rzRmduWxbFzNXmHqcwL2Up5ntyeFM9tFiG4iAkT33lev4bIjFhrNHWp0R61ZgXbl2iyeaARxeZ7pPHcBHnOZE2c9CQUA0mIdH6UwMJU+CmyFh2pXpUTjgHUxHPe/FJFAAMIoX/plODNtGVClOCTb/txLhdckLsZ56HD5qGkD1+qBBO/ram3yNHouegrtmYkbUuiG8DDSF1lKAaOr+XmW3VNzNYArnvSpJgXOdoBBYqUOB8R6x1ymu3esSd38IFVYkNtJMnIvWFcgjZJ2UNmfA08meWO3aJrcWCAO+fGQQkTgpmzQfcaMw34pjdFoD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5JcWoxbzNNdGNuYVRxQ0F0SEpSNzhUY21SM0psZEo2d0JyY2ltdXZHdkl4?=
 =?utf-8?B?Vk93Q004cE1VSFFLSVlQR2FERlF6TExRTm9SemlXeHhFWVpoMy9xSWZiMUtv?=
 =?utf-8?B?Q0dwTEtJTERIdDMrZUZWeG9mdkxHa3dpWnpmV1ZRb0Q4bUh3Y0xoV2RGSlQx?=
 =?utf-8?B?MzFMWW9vamhoQmFpOVBlc0dEZS9YRW1UYzVUSlhsVUkrbzlMSlpEbzNpY0lP?=
 =?utf-8?B?WFplczZoQXVZVXpZeDZQYm40SmRqUGRINmJ5V0Z1Q2lvUklacHpyVEdXN3lu?=
 =?utf-8?B?cXNXVFZtRzdDTm5MVVQ3TzdyRXhhR3FNaU5wZmhkNFdWM0h0SjMyek1iUnBT?=
 =?utf-8?B?ZFEzc1o4R0NSbGlmaktsMkJZS2NZWE9QR1lBaW1QTjl5WWNrWVhiUHZuYlBV?=
 =?utf-8?B?MFRJNGFTWnIrTXJzM0MyRTZkdFZKTmozUkJFUkM1a1pzMzJaSXY3V0dhc0Js?=
 =?utf-8?B?ZDRJZmllenF5bStOZ2xvSUsrbU1semZveFQvakpSS3JPUVIzbVhPREYwd09T?=
 =?utf-8?B?eStQZS80RVVhMlB6VlVrNzZGZFhvckNPaUJrbk4ranpYY2dUVkI1Nk5MU3hB?=
 =?utf-8?B?N1RGSVBoVk9LTUtEUXBaeXkzaldRMUhCSGxhNzJoV2pudkF1QUErWDc2a0d3?=
 =?utf-8?B?TkxOdDBkSi92S1dKZTlOai8ycnd0RlRCVlBpckpVZlRXY0dEaU11OVB0bzQ1?=
 =?utf-8?B?eFVUQXo5OFBTV0NXOXN3VlNCUHBUTkxFYm1oK1FLalhIYTgyZ2lGVG02YjJy?=
 =?utf-8?B?RHdTQ3hoQy9pUEdmWitGKytHNzNhTGdxSmFEWlpnZkFVTUU2Q1VTMUttMTZy?=
 =?utf-8?B?bjY3Zi9MQ2xJdWh4a2lFVnlDWm1tcS9TblFvR3cyeFBncTBSWnBPK0pGUUdD?=
 =?utf-8?B?SDZ0bzZKSGRWQk5SUGhJdkNLb0tjYXJTTTlSYjgwdEorc1djK1EvWmU5Ymg4?=
 =?utf-8?B?ZzlhR01HRFdsTVZQUGl1S0dMd1VrNDBKTFJ6WE9aV2hyQnZiN2RDRDZJTmhm?=
 =?utf-8?B?K3hzdHlvSDROMUpQTUF5V3dlZXhlOHptelBFRHRzbkdwdUVSYXdRalA5eWR0?=
 =?utf-8?B?U2hPZHZmTW1EM01mc0ZhaEI3Qy8xbjVKVGhIT3BPU3BJSUs1MnVrekFSYktz?=
 =?utf-8?B?NzcrYXQ4K2g3bmZHR0ZJa2YxYnlmZWFCQnR2ejRPN1NyODVsaVNXTkNteENo?=
 =?utf-8?B?SnRyd2U2SUhkazNIQ2R2TUk5akpybjY3TzBOd200a3RJL2t5YytkQWR6VmZz?=
 =?utf-8?B?citvUUh6bUdkOERRdW82M0hhYy9pUEFoMFp0RzVnWnZ6cE53RlVwWkpNUHkx?=
 =?utf-8?B?R0NWVXZLeWpUcG5mQmt5VThtQ1BxRXlUcjN3RzFpQkx4OWJOUTdZSjkzc3NK?=
 =?utf-8?B?V0srUVMwY1ZrZ0JKeU9zQ3YzL0dwT1lKMDYzKzFxWjBRZkpoaXVtcWhRUGUx?=
 =?utf-8?B?VUlQTk14MVI0a254bjNFUU1zVXhCUDloemRzZkRBYmZyQk5XOE9waEEwcktw?=
 =?utf-8?B?VVAxR0YyeHc4VVlzVnRsWG5tK1hSOFJoZm5RRGJDL0EvUHVWL2xrR1JJNmRt?=
 =?utf-8?B?NFh2SWhoRHdIZ2hTUHpxOXJJWDYwQVhXZ1FNSk5Yd0x3aTBhNU5tbHZjMDA1?=
 =?utf-8?B?b2JSNDY4emNucTRZWlNueDcwNXBoNVBZakQ4Nlo2alhXQ0VDVXVRdTRoSmVH?=
 =?utf-8?B?S0FrWHMzSjhrRTBsdlNJVkt1SFFFNUZvT2FCZFc1cS9FMEI4Q2U1cUp6NnFS?=
 =?utf-8?B?VlpkaXN5Vk5hQU1NelZrQ3JlNnJWZnlCZlI4UDZ2Mi9pSnEwNHVoc3hhN00v?=
 =?utf-8?B?bjE4L09qUjVOUWxTZWhpdWRQTEQrNUpzL2pLN041TzA5VnlTSHRINVZzWE5v?=
 =?utf-8?B?bnpCejlkcFVYOTV4VFRPVVpLUVlOK3VSUmQ2MnBDVUZHdzNjanZsczdWLzY2?=
 =?utf-8?B?WXF2RWE2ZXpjeE1kdVlpQ1RRQmhLYXJ2dHdUay9lWXBlTkttWXp1OURlU2tE?=
 =?utf-8?B?NGs0cXlMbWE2NzNMcmVJOTRVdXRZcktUZU1jN1dTRnJLdW10YnBaLzJCYTQv?=
 =?utf-8?B?OURSYlNzVmV4RGhqK0RKYWJ2VEhDaDhZMEV2eUxVM0pmRVptM09TNm9BeU1t?=
 =?utf-8?B?TzZBSFFWQUlTaVA2cVNtMndBMWt4Q2NRZDdjZjcxcDRJK1EzcC9lNjdtTWhO?=
 =?utf-8?B?WldjeGFoY0VvT2cvQjNlRkg1aDZ3NDhrd2s4dTFaU01MU2I0WXYxc3ZtTVFM?=
 =?utf-8?B?SS9mbEJLbGZzOU56eHZ5eVhoN0VXNkZHMTJmRmViT1R0UHl4STdySlVIMERl?=
 =?utf-8?B?M1QzdVFlSWdzN2dWWlZXR29XM04zM0F3RnhBSXNlaDVwY1dZczZ4QT09?=
X-Exchange-RoutingPolicyChecked: jiVQgPtUEQ4yBs+XDuonW1Dhaj6ACVel5pRFHaUoPqfndK9wBcavKYrTMICHdODCQqLaW9TeLdQhk7G8xkJ9nlBTPp0UEry85VcvLIsq1TrTL/qg0yB1vgEWYdV6ICW8LU3sZ6N2IJVWcqga/aRg5r23QMLw7pZMv0I8guagJqU30Kv+a3gNv2zkDRoGmvI/BkiJ5WPTxNRuMFgMV2IBHrYKM89uhG1foKTIKx2KX/RvgFS6v0RWvDOPj7IBGoPl6L/lc1MO6f9Y2sFIRwQQQYElFcl6GK1HAXmxHB5LDhgqjdKu2g4q8d46I95ulKO8ZgP2E30W8vwhWV0O5phf8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d26fa58c-defc-4ce7-373b-08df07aaee60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:58:03.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03+X7roaTpC38kR1iJqiqKSU6UbMi+73LwtfdwVj90CmmOqTG1E6QDN0Zf4gN2UyHb3Cy6FeQpBo8CqEKZSjN5T1nqzB9jpSSVCuRHtORHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

On 8/28/2026 2:10 AM, Vadim Fedorenko wrote:
> On 28/08/2026 02:58, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> The PTP hardware clock documentation requires drivers to implement all
>> callbacks and return -EOPNOTSUPP for unsupported features.
>>
>> The iavf driver registers a PHC without adjtime or adjfine callbacks.
>> A userspace clock_adjtime(2) request reaches ptp_clock_adjtime(), where
>> ADJ_SETOFFSET calls adjtime and ADJ_FREQUENCY calls adjfine. The missing
>> callbacks can therefore cause a NULL dereference.
>>
>> Provide both callbacks and return -EOPNOTSUPP for the unsupported
>> operations.
>>
>> Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP
>> clock")
>> Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
>> Link: https://lore.kernel.org/all/20260826101004.100979-1-
>> xuanqiang.luo@linux.dev/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_ptp.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/
>> ethernet/intel/iavf/iavf_ptp.c
>> index 87b97e09df14a..fcb273828bc1b 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
>> @@ -252,6 +252,16 @@ static int iavf_ptp_gettimex64(struct
>> ptp_clock_info *info,
>>       return iavf_read_phc_indirect(adapter, ts, sts);
>>   }
>>   +static int iavf_ptp_adjfine(struct ptp_clock_info *info, long
>> scaled_ppm)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int iavf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   static int iavf_ptp_settime64(struct ptp_clock_info *info,
>>                     const struct timespec64 *ts)
>>   {
>> @@ -326,6 +336,8 @@ static int iavf_ptp_register_clock(struct
>> iavf_adapter *adapter)
>>            KBUILD_MODNAME, dev_name(dev));
>>       ptp_info->owner = THIS_MODULE;
>>       ptp_info->gettimex64 = iavf_ptp_gettimex64;
>> +    ptp_info->adjfine = iavf_ptp_adjfine;
>> +    ptp_info->adjtime = iavf_ptp_adjtime;
>>       ptp_info->settime64 = iavf_ptp_settime64;
>>       ptp_info->do_aux_work = iavf_ptp_do_aux_work;
>>   
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

