Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9ED4A1E0D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142036; cv=fail; b=YIQMNhvzhaaUGrGx4L0A6/HrL5oC02nl1xEtg0YSULcfxyaeU4QAqRdntv0PYTecRHdB2gIQUnIp0hhZiSkNzcYAscICyN/4CD/OWt+W1ZeWAGyWaiExWlz9TsAG/WTv5QGKvF7PmxsuEj8ObFPCb8H3LLNsuwU9ZjLe1ySSy3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142036; c=relaxed/simple;
	bh=PM1qTmZYPWApiDJDGyCAGX07hhZK8atqRj4llZVY7Iw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SvgzMD8Sg7OhwwPRxQHx+vGSMfpbx53WuGXsMNRU5CwC8eLOQL5K0sBCS+RP4GIgy4Q5FQbx6IkByC+raY0mthEvzoyQm2BUAhctZZVBPJ/GtrB7H7uyjmAhGVF0sPt3Gp3f1PEcInAj8+ITfQrFC6F1GdOF6ZWzm93r34MOmxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZr7wwse; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZr7wwse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789142033; x=1820678033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PM1qTmZYPWApiDJDGyCAGX07hhZK8atqRj4llZVY7Iw=;
  b=cZr7wwse62S9auMAfCKqJjzn3WKnoM/bYTXPl7aJ6/TJIgexyBjtbsar
   TMXiTgtHYwJW2aorFnAjCnBJZDvEi/CKNOGGG2PW3VdhjN7sTqP59NIqV
   OG2CUS55i0dAdOxsPxQFLVXXF5qsfEkD5EnBF1mnSWpX43EC6s+pG2O/T
   sdGD6+1/VAuq0q/762ew7vYsKCEZuJlubjYFqKQflkyKzzaIzX802DTgz
   HXe2Y+ujmRJnq9Aui5Y8BSL9732TDwhNxUY9U/oJg4ClW7w05U7rBYBFn
   dKe5CHYwn1vZ2bxhSX1RNkB/H1ISF7BTTXzJyWU9k8kb7jy57NJDteYab
   Q==;
X-CSE-ConnectionGUID: aSxVZdp9S0azuVMsLH7pLQ==
X-CSE-MsgGUID: xdxUZkdiRfWMy7SbwKwkGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100271190"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="100271190"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:53:51 -0700
X-CSE-ConnectionGUID: DbaZ0BvMQyifLvs5kue9PA==
X-CSE-MsgGUID: hRcP0S2gT1SW4nndbzGIBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="272461223"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:53:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:53:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:53:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XttgngmTz9bTeoleX8ETYzs1lsL/VEe+8rJQCQxpQbLRy3tygBt+Wbio7cic8e2axlJUh1/hyQMJI01JUUKYpM18/hYbOMfZL9CKbSKwAM7udNAwk7MLT0Z6ki4al6Qnq/SegHQkal8X5yMWpPokUQB/jpXkSmmPicanYY3gOkOZpB1UuuSNXZpyfo1PFvE/lh6YrJVWLq97Spkc1qlKfkZfOdcMmHFVAfR9Z2x2XzKBYXAPbeZtIVahoFToP6IMlOZUv+jOxB5pUTz31ZSa9VBGJa9+0mif6QS2q+Z9LIDkqJ//E5Y5+U8YiRhvYPMEqnU/SKMo6DIO/zFkuGQvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4RO0euAq89W9vkC9dpmjm7ct1ShY0tMV/RykYzhWuM=;
 b=p8dm0y2OnsCUX94SmwiKdaNPrmnaobRPKRzMuit2kbOjwesYgoZELm1x7vOgkjpCNLo9YWCQoRlEvoFZlJODUUCAX1N40Q0xbELv2mFsGlhq5VPsvvGytPPbo14of7wk6STjYkqfwKgsq4h++yPdIQM6nYgOtxj1D70xTpMfyK7nBkA7dqwyDxrsE1ByZWAt20ilpwUvzTX/4uoAuxw7R9nEkzYZgCsO/zo5PBVwO/PXwqGTEWSifZm44cl7DjfUDczUk7HCUQ/v05Uce13QoMEmdyvOUKBXFPtHX3HAjLfp3CnOUQWwr1z9hJNUiQ6IFMBjQDao7tuGNGGzDvNsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:53:28 +0000
Received: from CY8PR11MB7010.namprd11.prod.outlook.com
 ([fe80::e26:c52f:6245:a646]) by CY8PR11MB7010.namprd11.prod.outlook.com
 ([fe80::e26:c52f:6245:a646%6]) with mapi id 15.21.0382.012; Fri, 11 Sep 2026
 15:53:28 +0000
Message-ID: <7e0a5a55-e44d-4af2-ab17-4c1292cceb73@intel.com>
Date: Fri, 11 Sep 2026 08:53:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/i915/gsc: Validate the CPD entry offset before
 manifest read
To: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	<intel-gfx@lists.freedesktop.org>
CC: Martin Hodo <martin.hodo@intel.com>, Alan Previn
	<alan.previn.teres.alexis@intel.com>, <stable@vger.kernel.org>
References: <20260807192301.3009387-3-jesus.narvaez@intel.com>
 <20260807192301.3009387-4-jesus.narvaez@intel.com>
 <2b53deee-6c11-4375-9650-4482854412f9@intel.com>
Content-Language: en-US
From: "Narvaez, Jesus" <jesus.narvaez@intel.com>
Organization: Intel
In-Reply-To: <2b53deee-6c11-4375-9650-4482854412f9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To CY8PR11MB7010.namprd11.prod.outlook.com
 (2603:10b6:930:56::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7010:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: d4dff492-097f-47c3-b48a-08df101cd259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LJddk0R+ZZTUPfWbmzKYh+1HBv6akg5nRyyoy8OzE5/0nTb+rC9cI8vrMOhVz2Z+yVTIC/BoywO2y8yT5yJg52fWF/OELpbxgjqZBd+6FGeUj20nZUcyrmWiQNGSTMu+PwlqkjZJlXld4AU9qtNOnJgOdL8GrrYBOqasjZa8TcaRVlAnCZqaTsffgVCgOO3qdxU3sqbbDQO3ipI8J4/TFQL6h/O9QKvm85Zl2Y970lODK/bskmg2Ql5Hb/1v+fBDFIjKxtp8dcCo9eenlP5ARH+S+Nn6na9ORVFRrAOjNlePtgkQgSTmKjvMYfBBN+N4/tDfLNOwtmfGUBqJZjow8dEye91raP7+v1ucYToH3HTK1GVUHfuOtY5sjUmQlgJv+Smz1qP/FEg5haUkyy92k4lk4mZd0Tc0XSbg9t+GaqQg+8bDCy9lYXVN5wd0/YNS96t7E4uxWvZxiffqFkOo2/iAB5jVfE26CzzOIh3cJwPlaS7g5QKx0IpbRyDGAHl4tEWUaW0YuaopNMVd1MviG/eH9Di9eZZGW8ORL/emsFCxEcQU+5SW9yQhD2BGBpau1Ean7bYFO+7QuS374GhQpBJsu/Y7q5QYlXlIj7lWn0zVaUEi3UNIPl2W8b3hPDiiH9ar+jOhR/dCzE/ExTFS9J9Go3JPeLYqc28LhxyFepE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDFkTUoybFNzODJCWWdvakRXWE0wRXJXc0dQSDB2VUpOTWI3dzFpWnFKeW9v?=
 =?utf-8?B?K3IrdVBnVWRNbFJSYzJkMTB3bTkrbitTRTVleW5Ia25IRXVoRXhBQWU3S3N6?=
 =?utf-8?B?QUdqY2puOVhUQzFvSEJsRFBiOEVlSEVSS1Rza3J1VGU3allZdVE2RzJtUk5X?=
 =?utf-8?B?WXAyWlVCdis2NWVkTVhQZUYrSXFIbjJ3eFRsZWJOV2ZTMURtRHFJMVZnbUlU?=
 =?utf-8?B?QXdwdnl1NVJYbVc3MEE0dTdxQW9mVkdBWWxBOTdYLzlKRWxRdXpqYjg4dzRy?=
 =?utf-8?B?S1M4d0JtV3Qrci9BU0ppVjVqNE9lOVZTckNpMkVJRElGYzd4MTMwR3RGZzZo?=
 =?utf-8?B?ZFRXbGJvNzhJRnZURkFXZUVuL1J3L1d5ZlNYd1ZtdVFkZTdTMlZ0SkkvSS92?=
 =?utf-8?B?djdPdXVzQ1kvNExPeU1kTGJKQzJXVUxzVGZBTWRvRFBxWHEyS3U3bDdpNEhE?=
 =?utf-8?B?eEM0bTZWRHo5Rmo5RjgrQnZmRWppUnhaV3pPRldsaW12SzVDdmE5REd2V1di?=
 =?utf-8?B?Z2pBcnJkRUhUZmVBSXVoWnNBTDhWbWdrWHViZkE1Z2NCcm5KU08ySGZZdERo?=
 =?utf-8?B?MEZ5ZG15Q1hxVTVrK1ZvWlQ2dnQwcGwvM3J1Y3JtZ0NWSUlOcVlybHFGN3FQ?=
 =?utf-8?B?NVdHUTh1OXFGaVRrTmJzaUZrTXRjOWd5M2E2b2lPb0NGdkY4MUc1dnBHL1hr?=
 =?utf-8?B?K1NDb3pFWlJ3bktBUkpObG1tTDFFZnRpc1FEcEdnODhUbXFrVUJzYXpaVGNz?=
 =?utf-8?B?TmlIYlkvc0FpNDdsTlBvWlBqMmN5allNWTg3TjdCeUwxWmN5a3BsQlhzQmtS?=
 =?utf-8?B?SWFFS1ZodStPN1YxVTQwUU45bHpwL3VaZkFhblhheGJKTXBsazA4MzdHb0hz?=
 =?utf-8?B?R2NkSzlHRlFLTU5GNDJacnVCOGFMUGUwOGowTWF1NGdaRlZjb2Y4UmZIa0Zx?=
 =?utf-8?B?WkRlSDd0dk9YYzJvZjBQeTh4eFVlcC94TEE4STRyZHJKdmFwTUpwZ2JPK1o4?=
 =?utf-8?B?RkhyWkpxalZWYm1HS1lzK3dpQkROQjB6NlhJRXMzNExRZ2ZBOWlnS0IxM0Vz?=
 =?utf-8?B?blZHQnBSZFRPNWo2eC9tUEJkMW1CRWUvOW9xenpsTi96cWlPQkRwVURQL1Bn?=
 =?utf-8?B?UVhvYlRSdnBPSEo3RjgzVGIvSEs1RFFoTWtDelBXMFZmZlI5Y3FKOFB5cnV1?=
 =?utf-8?B?blRnaTVhZUVYWWRXOThpM0ZRbHY0OXBRcllqZmlkY3lzVklva01MaXNDNmpB?=
 =?utf-8?B?K25PVTZCVXZpOS9zQ0dRRmcxV3Z0R2hpSUJiTmNST09PeU5jYjE3QnI5MmxK?=
 =?utf-8?B?Q3p2cDBnU0FPc3d4VDZ0ZUhCb1BVWjdGOVRnVDZmQXY3SjV3NzAvL1NnaFFH?=
 =?utf-8?B?dTlSSlJSdGorUW1QVUpuTDlJS2ZEamhzaG56a3cyTE9SazNWSFF4STZPMWtC?=
 =?utf-8?B?V2hXVTJ2aEhTTVZVSk96N2hDVXhtdURVcWF6Y0toSGtjWUxLS1Jma1NEVzJh?=
 =?utf-8?B?dzFqZUVxZWxMNThHYXhtTXZ3SVRzd0lzNnBBaDQ1YWt0MVdqQWNnZ29HVzZU?=
 =?utf-8?B?UUpUOHMvS1dNblFZd3hMS2hVUmJ5SkdtWGROaWRKeHMxT2RBK2dtM1hxWWJt?=
 =?utf-8?B?dm9zYnBvdG54djFzNFB6Y2NwS3IyL1ZiNWFEY05sVEtad2VEMlprMVZvZUlG?=
 =?utf-8?B?cG16WTVHcXdPN3g5NmJPdkltSTQyUzkrT2poSHlJWnQ4ZlZyZFZkYk9UZW5J?=
 =?utf-8?B?YW1EWVdVQjc1bm1IcGRFK29haHZyVTR2ckFHZ3VjMW1wWmhwRWlVdjFvRFZP?=
 =?utf-8?B?NEJNNXJwUXljb2FIaEJKU3hnVG1SNCtoeUthby9Jd2c3WkJXQys0ZG9wMkYz?=
 =?utf-8?B?Ri9MQ2k2ZkJYYk16UHNVRDUyWEM1SlJaZ0luMkxBay9Cc1E4TWczMWJYbDBh?=
 =?utf-8?B?TU5pV0RQekVVRDI0NzRPeEVSd0lVOEFtMElPeHdvZWpCUTZQbkNiaUFYRGI3?=
 =?utf-8?B?Njl1cUc2bnd6WVZwUU9GUUtKd0ROL056ekV1TE5KaEx0Tlc4UnJnV1ZRVlRr?=
 =?utf-8?B?TWIydWVibzBoWnlaLzZ2MkJmOVMvcTF4WUpMckV0Uko2eW05d0tsRHdrUWFw?=
 =?utf-8?B?OStlV1hZdVhIWlYxSm91ditHSG1kdCtGd2R4Y28xWlNFSVloUnk0TlozVXU5?=
 =?utf-8?B?My9iQXpEZXNBRmJ0c2xHTEpTdHFUWllHRE1KSnpkN0VQbmtDQWQvNld1TXla?=
 =?utf-8?B?MThDWVZaOFpIeEdIczlLY2NtZFpNMTY1MWNsUzlmb1JPdmt1eFpWQjlWUmda?=
 =?utf-8?B?bnJRSytySjdMQmxtUHl6N2t1UjJBWTRQc1hJRmdFdEU4dWRPQ3JpUT09?=
X-Exchange-RoutingPolicyChecked: Inrp0KX0smsaNR+SiAAK8Uk4Vu6O+lr22Mb6ZBW6m8Tck76CHt+D1d2cfKZjJyFSlwSSIiND9B72EjHsbMR167eOT571rxmFp1Lpnvg5L825GH9IxP+X69yZcimea9Um9PnMv+lguYJnXHu7SfY2DoCuX4SvXhEg3YAdwK7bduwfhEAb5eXkv4+f7g9unND72VmKOY+j1/OdC6uw+6QsGVPDBJF7/qDSKCewtE8Cg0WET5nYj8e58FJLv2MyQNgNA/OAu/LQ/F8xJYxmBWyAC49xuc9TceF6aQpj5T8jpN9vjz4wwMsglKti8uDzAm2VZdsnGlJ4hqsebZEIECSwcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4dff492-097f-47c3-b48a-08df101cd259
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:53:28.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4NzxdbMQAbwyQ1QXMPkPn3I7ttyEmb9loiMX3aXNVU13GPmkux6zCwF8mLsAvjzMYAhMsJnI6GfmcjPSntS6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com


On 8/24/2026 7:28 PM, Daniele Ceraolo Spurio wrote:
>
>
> On 8/7/2026 12:23 PM, Jesus Narvaez wrote:
>> The CPD manifest offset was dereferenced without checking the bounds
>> first. Therefore, ensure the offset doesn't point into the CPD header
>> or past the bounds of the FW blob before reading the GSC manifest.
>>
>> Also, validate CPD header length before using it to size the CPD
>> entry table, and cast the boot1 partition's offset and size to size_t
>> to avoid an integer overflow.
>>
>> Discovered using AI-assisted static analysis confirmed by Intel Product
>> Security.
>>
>> Reported-by: Martin Hodo <martin.hodo@intel.com>
>> Fixes: 56fafa569764 ("drm/i915/mtl/gsc: extract release and security 
>> versions from the gsc binary")
>> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
>> Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.6+
>> Signed-off-by: Jesus Narvaez <jesus.narvaez@intel.com>
>> ---
>>   drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c | 27 ++++++++++++++++++++---
>>   1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c 
>> b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
>> index d550eb6edfb8..1b9976869c46 100644
>> --- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
>> @@ -139,7 +139,7 @@ int intel_gsc_fw_get_binary_info(struct 
>> intel_uc_fw *gsc_fw, const void *data, s
>>        * --------------------------------------------------
>>        */
>>   -    min_size = layout->boot1.offset + layout->boot1.size;
>> +    min_size = (size_t)layout->boot1.offset + layout->boot1.size;
>>       if (size < min_size) {
>>           gt_err(gt, "GSC FW too small for boot section! %zu < %zu\n",
>>                  size, min_size);
>> @@ -195,7 +195,14 @@ int intel_gsc_fw_get_binary_info(struct 
>> intel_uc_fw *gsc_fw, const void *data, s
>>           return -EINVAL;
>>       }
>>   -    min_size += sizeof(*cpd_entry) * cpd_header->num_of_entries;
>> +    if (cpd_header->header_length < sizeof(struct 
>> intel_gsc_cpd_header_v2)) {
>> +        gt_err(gt, "invalid CPD header length in GSC bin: %u < %zu!\n",
>> +               cpd_header->header_length, sizeof(*cpd_header));
>> +        return -EINVAL;
>> +    }
>
> I think this check should be a few lines higher, where we assign the 
> cpd_header pointer. That way you can also switch the min_size 
> assignment there to use cpd_header->header_length and leave the one 
> here untouched.
I'm not sure I fully understand what you're saying here. Are you saying 
to move this cpd_header->header_length check to right after the 
cpd_header pointer is assigned, and then update min_size after that to 
also use cpd_header->header_length instead of sizeof(*cpd_header)? If 
so, my understanding is that we haven't validated cpd_header at that 
point, and we'd be reading cpd_header->header_length as part of the 
check before we know it's safe, so I think it would be best to leave it 
where it is.
>
>> +
>> +    min_size = bpdt_entry->sub_partition_offset + 
>> cpd_header->header_length +
>> +           sizeof(*cpd_entry) * cpd_header->num_of_entries;
>>       if (layout->boot1.size < min_size) {
>>           gt_err(gt, "GSC FW boot section too small for CPD entries: 
>> %u < %zu\n",
>>                  layout->boot1.size, min_size);
>> @@ -205,7 +212,21 @@ int intel_gsc_fw_get_binary_info(struct 
>> intel_uc_fw *gsc_fw, const void *data, s
>>       cpd_entry = (void *)cpd_header + cpd_header->header_length;
>>       for (i = 0; i < cpd_header->num_of_entries; i++, cpd_entry++) {
>>           if (strcmp(cpd_entry->name, "RBEP.man") == 0) {
>> -            manifest = (void *)cpd_header + 
>> cpd_entry_offset(cpd_entry);
>> +            u32 man_off = cpd_entry_offset(cpd_entry);
>> +
>> +            if (man_off < cpd_header->header_length) {
>> +                gt_err(gt, "GSC FW manifest offset points into CPD 
>> header: %u < %u\n",
>> +                       man_off, cpd_header->header_length);
>> +                return -EINVAL;
>> +            }
>
> I don't think this check is valuable. The offset could point to a lot 
> of different invalid places and we can't check them all, we just need 
> to make sure it points inside the binary. If the binary is malformed 
> it will fail to load so we'll catch the error then.
Makes sense, will remove.
>
>> +
>> +            if (man_off + sizeof(struct intel_gsc_manifest_header) >
>> +                layout->boot1.size - 
>> bpdt_entry->sub_partition_offset) {
>
> using bpdt_entry->sub_partition_offset is kind of dodgy here because 
> we're outside the loop where we go through all entries. If we ever 
> need to look for a second entry then bpdt_entry might no longer point 
> to the CDP at this point. IMO better to save it to a variable.
> Also IMO some parenthesis would make things cleaner here.
>
> Daniele

OK understood, I can add those changes.

Jesus Narvaez

>
>> +                gt_err(gt, "GSC FW boot section too small for 
>> manifest: %u < %zu\n",
>> +                       layout->boot1.size, man_off + 
>> sizeof(*manifest));
>> +                return -ENODATA;
>> +            }
>> +            manifest = (void *)cpd_header + man_off;
>> intel_uc_fw_version_from_gsc_manifest(&gsc->release,
>>                                     manifest);
>>               gsc->security_version = manifest->security_version;
>
