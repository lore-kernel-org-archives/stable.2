Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78781DF748
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698387; cv=fail; b=X7Wj+lFqW3AK4QK8fQbjGjo0zbpSm0c38btB0zV6pv5UMPLaMZcPCJW0ScuiPBxIyO4kPMNRnru43zO1vyh5QPZpniNtmaFatGXj+l6/vVuXkXtkaWt0u6tPcHVaH1UqQXU4+c+AqN2YbIWom4IOVWj6Zq5gXBAeB1a01240kHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698387; c=relaxed/simple;
	bh=tXtALZIasFEbRggx3HtFaRYgHIjQM9JZErtRW0nOBKs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RblVG6Xi1Q4JANLhsoBn6wZT0TtUO4JoEXzNWmPqbpKckoOe215ItX5now/Z7b8xbK0zWU6ys4eMl7ofij7uVQ5bqw2KKZNeXizsKWTCT4FEk1Fl5o92jIPcs6shWrBkyx3AmbZNPnRBiMc2Gc/5I8j/rC6p56YnftddjdTRR9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7Qae5n/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7Qae5n/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784698385; x=1816234385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tXtALZIasFEbRggx3HtFaRYgHIjQM9JZErtRW0nOBKs=;
  b=g7Qae5n/IQh/p2EC9X6FzxJ0Wp4CfmLgzTBvDbX0HmbfkAMeEngm8/qD
   9b19XnRojIt9H+vtnnpd2cOzP8jvCe8w39x2lUi78auns0jqKR7/o5Y1P
   dGoBTxrf9xT98MkXjGZi/wEswg8pkYHE4ouwlbvNx0383jAVuzBs7tL6y
   jZ2MnneHC3RcXUn9Q7OeOiBjF1gZrtgnnfxt4+VL/OazLT1guKW/mawZD
   ZLFNrQPlo45+eKYzxhkZsNaEgwx29C+4yxGCJeyNLYEROHPXudI5yJyXr
   KD8KF3Mafp+Ngx5XzOLz8hZMFeCLa3noghcRbR2wtT8rMcvdy/QawpDlW
   w==;
X-CSE-ConnectionGUID: HuIEGj7xRqKPJCHeJDQ90A==
X-CSE-MsgGUID: q6zqxJdgR1mjbgto+wZeZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85440379"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85440379"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 22:33:04 -0700
X-CSE-ConnectionGUID: HwsKFPqARZSz2LP/czJ5UQ==
X-CSE-MsgGUID: agSYxFVoTDeKU1nrDpIeoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="288000198"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 22:33:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 22:33:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 22:33:03 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 22:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6Jr3q2I/OtzuTsaAyIMdJjS9RS752AkoV+0VSiwloVQQfyKCcbLID3gLG7lZDUQ7GEW45GnK2UU6mZ7IQyrtWjQBqgtRRjn6TlL1Eivq1+AacKpBLSmna2mZ055sVzw27gcY5szpC/T9TrNP3FsKYgWnUSIOCsGGHz5B2gFCGxbFR9WQbMYi083pp3bC57OZQqTmnttvWriJvrDu8kqJJ+pDS+YVeh8tEdgW46cAoBC8zMW0T2lNQi2HlrPdYs39IKZkbs06amouHeoE1tQaJgMo5dI8S3SczxZIcG4BdJaihXNK7JzjW7GghDuRE1N/FCOM2GTJO7JheG9NqkwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbpVOgc4uNcGpzYpufNRBi64StkvdMzsC518mqjQ7FM=;
 b=R63oC7PYUTliysKH6F4wTpPCxecX2MzzpNOTX8ybkqj6Mi/mmIhBM5rzeOmaSZKYYRD0bwl+PmmuHPJDnuKUm//84u4uIdfKjxFJUqLJd4StNxYzY3WypmqDkiSWCJyWzCQ0kJvY5EJWs+LJwNXN20fam7d07eygc/lsG2S+DyCIjQpE6Ze4e1DWxHEizj961QifdxuLEvZUotw71nux5XAsNAdP+dcTzPT9jBjOl+ijtHrEM0qnoSV1icPCBASDBiYks+62LF0PVIoSu+h2yRMkYjGC4DEh/ZSKOFsZqhpEiNeqFAhkrFrQ7t9HCB4M7PoQ5RDKZNO/9RMfEhFDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by IA1PR11MB7173.namprd11.prod.outlook.com
 (2603:10b6:208:41b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 05:32:59 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983%8]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 05:32:59 +0000
Message-ID: <0098bedf-a884-48ec-a8fa-0b484b05b4b8@intel.com>
Date: Wed, 22 Jul 2026 11:02:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/pagemap: Clear driver-provided PFNs from migration
 PFN array
To: Matthew Brost <matthew.brost@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>
CC: Sashiko <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
References: <20260721204353.1082632-1-matthew.brost@intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20260721204353.1082632-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::15) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: ea87baab-23ad-4374-2555-08dee7b2b0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +Ppn7IBXoFekCh6OckQjHgelNR0TpGqqEa2QQI49fRIHyl8xKz+e3teRgpHwPJAQ0DAyqP6ibfjeQy0/bS5S95NA3vPDd1NMhnp5nsZdyDCUgWvXGqWF9rNhV+zMsG/WDeUh8Ou1UxUDNnsOES3aWFozH9WB8Pkg5NwGcIXTNYUWLO0X7uKFcx3YmC9MY/2cmNHat+2ZqA+2ggSP/tjkHdW+aAdOOK6no/0cKFHgNy2JhjiTWEk6QflfSc0Hqnp0gBuYa0qpAYw2bDecIAKjHh8/WTy2HF99rg3qlrZJTeQsDflKR4ATXU1GbTcTe6iXy5ha3ZMl579yiXlrsuHTB+5aEm9KxxldpOYEl77gLTEGVzm5dmCiBmj8ovmwXpT1dohLVQVDPtl3rj2++ri8huX2To3/X3V+s6JN1pa+sP17LPDtnPRVRPv78+I9fawtq6IN6W1MIq+WkZIaDAdjl2oFEo8/5jMWcxzj+XQXZej3fUn3DrAFZauqrchisvHwa+tej9QnsuwUHB3GN5W41RbJcl2VnDgJrorsldNfKw9dHDnIxF8rBZusXi5vdlLK+6NaJC1beepIbbjZIbj5ECLBu3J+XGvUd34eh3g0zY4Fi9hwpN/buK5rCLD74XUEFySgfofa7y1QXBKnC++izB8hVUUVKPWveiiP1SzaUkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF691668CDD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTdsS1NLd3hNRWVCL0h1cGtUaXZYM3d4NkhHNk1UWGdxNjFhZVdSTWZENWF0?=
 =?utf-8?B?dktXQ3o4b1FDaHZHbnBpQy9NaWVidzJqWWM5ZWFEdURWTkFkUFNzdnZrNWE0?=
 =?utf-8?B?VGM1L1BFNjZLNmtqT0thRk42Q1ljQkdvQWVmdmdGYitZNzNrdlpjYmNPYnI2?=
 =?utf-8?B?M21IdVZFdGhOaDNEcnBWaWZiRjZwdjh5REZKMVpvaFMycWNncGxMZ1VyTDQw?=
 =?utf-8?B?Q1VkQTI3KzYrbEgrL0h3NmsyYmJoNVQ2YStmMTJNVy9BUnZwQXduTERMcDMx?=
 =?utf-8?B?S21yYVV1cG9FNVpwUmc4ZWZmVi95Y1FjcUVmcjJnNWFid1NZblErZHRMRFZS?=
 =?utf-8?B?YmszSTR5ZEYvRVExS1Vhd0s5dHI2V2NNOVFqVmc3K00yMzRPUHlqU2x2UXBs?=
 =?utf-8?B?YmROa1grQWVWMWM5MEliMjJjMjV1NXR6SVZYOUQ3Y3JOWFp0SlpwTHBnZWZu?=
 =?utf-8?B?NjJucEJrSnBIR01FZHZ4RnFyY2tUc1p4V1Jrbys2NXp1TnZLRU5scXl6d0la?=
 =?utf-8?B?eUQ4WFducGUzVGQ3UG1RQU53U1N5K0Z6dVY0MWgzYkV0VTIyZFR5R1pBdzF3?=
 =?utf-8?B?QmgzcDBWd2daMEVVM05CaGVzRk5RakJ4bVdIeHhVMElpREVGam5NS0luNGxi?=
 =?utf-8?B?RHNPekJSNjg1ZlFMb0hNN3lOZmQ2Ym9ybUI4UTkwSHE5Q215Sk03ZmdKWTY4?=
 =?utf-8?B?ZFNGMUtzRFh4bnVrTVlmcHM1bCs4VytvZmVJN0UyNVBZR3J4MjhETkNqL3ds?=
 =?utf-8?B?eWMySVl6b3hwY1BjbkgxQldQcjVicHpEaU1CTG1BaXdyekFKM2Y0N2NYNEFT?=
 =?utf-8?B?V2gyZjg2c2dEdWVlZVd2MXdRQngwQlhrdTh1czhLQTMySGd5Z01xVEd4dmdP?=
 =?utf-8?B?WXdlVldRYVhjNUlzd09uek9xSlNTUVBEVGJUK1ZjN0VGQUVqR1RZaE02Wmpt?=
 =?utf-8?B?Tk1kSnpZTXdrR0ZaT1BIU3BGYVRmNjJWcnhhNWRxOEFlWmpSalVVTFQ3dXVS?=
 =?utf-8?B?M3FwU3ZKM1lBZDRTZE1uRU82Q0g4V3c4R25VcjMzLzBIc0FGejhPMzB2UCs0?=
 =?utf-8?B?Y1k0UkxhRlhSQjRXTWZhU0hkdElyQmoyOCtES0orYmxTVGpXZ1Q4d1dnSEp3?=
 =?utf-8?B?SVVFMjRwelBkeXlEajk1ZGpMR1JVWkIvelJrY3lkZXRuNjFVZnUwZm52bnRt?=
 =?utf-8?B?ZGNRQnBHZy9SM05OYjcxTDJCNU9qUXA1LytCYk5JUm8zOUhKdU5HUUJHcURl?=
 =?utf-8?B?L1lzelJjYUx3NnYzN0R6WDJwa1hsTHptanQxbXgvb2xubVN6N0NwUENGZzZU?=
 =?utf-8?B?Ykk5MkFoc1JRN3E0L3Q1cTZtY0VuTjJvN3VUcldvTjVaN3YwcUxUUG5uM1lY?=
 =?utf-8?B?K00rU25sMzlVSFhPdHB1WngwMGY4ekVEVXc2WDlpUTFiZGxvZVZwSDdGcXl3?=
 =?utf-8?B?Sys1UElsdVlpM2tWdkRSSWNqbnVRQW9Jei9lZFNwR1d0QTVYcHRTTGtWcmFY?=
 =?utf-8?B?ejNVa2lBdGVTZFpFMFQyZCtPWDc5N0E0SURJNUxOT3A1Q0dQZU9uaUpoejY5?=
 =?utf-8?B?c0EvRXdJVThWcnIyVzF6THpTSGgwaHlJN1gySkZnRkJ5Y0s0V0JjMi94VUw4?=
 =?utf-8?B?SXpEY2xUNjJabDl0TnRCUENZalhQWnJ3LzF5YS8rNDQ3aWRjTjhQSnNOQi9j?=
 =?utf-8?B?dWk3a2NnSEo1T0hydVFmV2lJWS9iek5iaFlndHpFb04xWTE2eE55S3Q0eEIw?=
 =?utf-8?B?WnBXWGNIdW9rbHBuRnRKd3F5WHM2T2ZOTlZHYlduNGhWN0R6ZXNNWElNSnJa?=
 =?utf-8?B?SERVOFJ0a29mY3BKNTA1TGxKdDlnVVBYWFZOK04zQ1VrQ3gwb0xYYzNjZmcx?=
 =?utf-8?B?KzFnQS9KdVpKRWhJdDdSTzVnazF1eDhuK2toTFMyMXFGSlJXbzFiajUrZmNC?=
 =?utf-8?B?VGd6WHVnYUFYbGduOHExQ3Roa2xodTVaZ0ZqSitsQ1FyOEo3SVdqd1BBZkVI?=
 =?utf-8?B?UFNqNTBIQXFKYXFER1ZNZzBPS202N1hTVm9vYk1kWitoVnFTdEJMUjAxekhP?=
 =?utf-8?B?dmtLMXduaWJVZkdGRzZzeDRVbWExdzNKUG1RSUZmVjNBWFVDWXIvOFNLS29L?=
 =?utf-8?B?bzhBNEx5R2ptTE9sYlhoQi83OS9hbzExUnFsRzNzYUo0YWpLbW9qblY4cjVH?=
 =?utf-8?B?eVI1Z1RqWitSL1cwMXVzcTJKUkNJVFpiN3JLeFZIR1JVWW9KK1VuT3VVcmYz?=
 =?utf-8?B?bEIzTzRZVGhIa1hvMXZxVjkrK2RYT3VETjBSeitIV3NVcE9uZ2ZtSU8xaVU5?=
 =?utf-8?B?ejc0eGVPMzlSOXYzMWVrZjhVMTh4WGM0Q2N1M0NhdE5WNlUvbFBVZzJpdS92?=
 =?utf-8?Q?5JK27NcfSo06wdw8=3D?=
X-Exchange-RoutingPolicyChecked: V+GCn/zcG3pRUTbzKyqslTwbdSzJQHcAToE+UL0OOfh+tGJJ50pt9z4r+AosbLaZEIgg8wh7L2oZGjrfAiaP/N0gF6lk3kuPkx0akvvBNzcanAg1OdpZ/TR+esCBtYeBHWSoJqDlNjRNvJATa5YJozK1v7e0djPPBwO2qwIMzqnjsA8rNKbIUR48hh9a6PKf5+Lva21/vkARMNojSDXnPnPAfZsLukPRE7fxgOYqG5Hb6zsQ0Qo8FJ1qxQ9iT2XXFTTfGsxmfdkPqdYDeiKCtZc9Mr0x37WCzXtHXDILkcjvS73mmC41skjhD6ya9OVmsZI+ZDP24inYZFNe8rw0UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea87baab-23ad-4374-2555-08dee7b2b0f9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 05:32:59.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtVihz0xitnD1yuJLYfdu2kDV8SqbC7zlx9eXmdpqYSr3SX80MqBwQSH1QWPfPUNH4LYJYavYHK78QoDP1ZsmStuGZX16MOjFkcoc1PCfrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com



On 22-07-2026 02:13, Matthew Brost wrote:
> DRM pagemap overloads the migration PFN array to store driver-provided
> PFNs before calling migrate_vma_*() to finalize the migration. If an
> error occurs during the incremental copy phase, the migration PFN
> entries are reverted to their original state. After reverting the
> device-folio mutations, clear any remaining driver-provided PFNs to
> avoid confusing the migrate_vma_*() helpers.
> 
> Also clear any driver-provided PFNs if populate_devmem_pfn() fails, as
> a precaution against stale entries being interpreted as migration PFNs.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 3902846af36b ("drm/pagemap Fix error paths in drm_pagemap_migrate_to_devmem")
> Fixes: ec265e1f1cfc ("drm/pagemap: Support source migration over interconnect")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

> 
> ---
> v2:
>   - Be paranoid and also clear driver-provided on populate_devmem_pfn()
>     failure (Sashiko)
> ---
>   drivers/gpu/drm/drm_pagemap.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b..892b325fa99b 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -727,8 +727,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>   	}
>   
>   	err = ops->populate_devmem_pfn(devmem_allocation, npages, migrate.dst);
> -	if (err)
> -		goto err_aborted_migration;
> +	if (err) {
> +		npages = 0;
> +		goto err_finalize;
> +	}
>   
>   	own_pages = 0;
>   
> @@ -807,8 +809,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>   		msecs_to_jiffies(mdetails->timeslice_ms);
>   
>   err_finalize:
> -	if (err)
> +	if (err) {
>   		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
> +		for (i = npages; i < npages_in_range(start, end); ++i)
> +			migrate.dst[i] = 0;
> +	}
>   err_aborted_migration:
>   	migrate_vma_pages(&migrate);
>   

