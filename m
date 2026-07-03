Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF53B47CD
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075847; cv=fail; b=B5WYx2wzk1hI8gOOohYdHWqMTaCXvdpZGqwYXO5skP+dYMBXnjmgeqvqPEgCIJjEoKHMAxAdGZJk1aG3sjCM41dLNwXOaSAVvtbdRwZy7IoZ1Co3L2BUkMa7CbxTT1KkqGT7hsYLQd9ODC6pYsYhDldGeBqLEbtuZ2bXLKKHuIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075847; c=relaxed/simple;
	bh=z97XUuUKg9hSX/fJ9TjZyDzB2j07A924ZUIRqVdLeBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTxUPrNC17DSjMbWx+r0I1zDXnYeDVAylIANiuogMOuDe0LxQcOsR06YhNuNXLTl+UsNNLdJv8P1Q8wzm1ynYiOnAgNqvXfJkJc3k0z1glUI/JA4DB4u7M1FzUPyb/Q49n8hRs1Ia4Vgnchj4xW0ajIC88Fel+uElTb4Vnc8amA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVuiaiSm; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVuiaiSm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783075845; x=1814611845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z97XUuUKg9hSX/fJ9TjZyDzB2j07A924ZUIRqVdLeBU=;
  b=GVuiaiSm+DkZ6b+sjZkwfRDfUW5Y7NXSFJMMGYzg9RADF9/ZyexJmxm+
   8RV+dmcVDjwaDi8TZm3GHzS2CD3wcD2G9iF71xAG6IPEGa4OauAZF4szu
   w36fSOQaUbH7nVA5PVJIo1QUURWioJaYLsewK2XGUnqmfis8xgB//Ci4s
   fLNZbCULpalBrscNzpcmjv8YNOD3jMk52nl+De7pPfDJdp0LKDtPPWgti
   EUrsj+SM3nsJf72on9ESUSsCCKUKB0O0apgCfHFDrehnbQPFkM6HUFiKV
   rIslF7bUbqJQNijlHy/DJS/lWlEoSl6uw/Cs/ide/8xON0UDCtxKkb3w9
   Q==;
X-CSE-ConnectionGUID: JAntB7f9S9uIUI2Mr/lmdQ==
X-CSE-MsgGUID: VJZz+ZFIRQWjS+fo53OmjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83921292"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83921292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 03:50:45 -0700
X-CSE-ConnectionGUID: iktIJz1iSmiIy8o9hW2Hag==
X-CSE-MsgGUID: 6Z9y/ZB5RzuxPbRnQASQ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="256977814"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 03:50:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 03:50:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 03:50:44 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 03:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEOjSwRPhY4Jets03DAtmmjnIHppo9VkAjO+XIjFxkA0NAKiuAgCyiIj70k0Ud1pwhLNCI7mGMubZEHlWlsrPs1p1buhqPfkixIfwZRg056+eL6VeVlTVdZGLyD/BE82j3XQUo3xAZJYObzMPutEXPRmL1FqgvU0YE0ZSETbOwrqQjTkvsSANKkBC5BKNUo78fdHrc3q7wWnAh6/k7Jpb210nnj6x4FYqT4C/nmFVT3s/C/yojz3h4Xsxc93+3ypNEAjv3vQEks/wScyIcBdG9KYsDl56KXTuc0ibCAsoVSl1MFZ/7XxslfvzTqGzfpLKLQ6Vi3Ctv9YhhqTa+zixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z97XUuUKg9hSX/fJ9TjZyDzB2j07A924ZUIRqVdLeBU=;
 b=yX8JQO1m4ewqh1mSRvgfye8T3+ZIKpUCn1v6b3Z3aUc2PUcaPqOJuejhbj6DNg/zEuIf5T4c5clLH4Uqo6muI/DEMNY1wAcl/EKVLyinmy5AB0/MrENP3CZFj4SZCraHxIkSpxmKxNL44F4dj9Uv7Wg4ubl247Kk3CgWHiznBywCGebcugit3/qQIiKlWYqRRfuTTm3Z13dqSwZEgtZ+Aevc33lE0nqgYmOkccs+Dz8zVgbvDBLLBpacoovRT/nCslgzz+PMQfWS8V0gUk/VHI7PCOaryJp8Vc8i0CAmbAtsJXH1nBhnJEdIjXL2RqM11XzrrLH0EikbozCNonfraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 10:50:41 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:50:41 +0000
From: "Gote, Nitin R" <nitin.r.gote@intel.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Auld, Matthew"
	<matthew.auld@intel.com>
Subject: RE: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
Thread-Topic: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
Thread-Index: AQHdCR1rykLZf8YnpEG+2EZUihr6+rZYoKYAgAAF+oCAACI3gIACZjsA
Date: Fri, 3 Jul 2026 10:50:40 +0000
Message-ID: <SA3PR11MB811856F0CAEE5983B1578C31D0F42@SA3PR11MB8118.namprd11.prod.outlook.com>
References: <20260701062559.3731993-2-nitin.r.gote@intel.com>
	 <dfed18b63a7b6cf164b3af7f65df8b4a1b9dbdf2.camel@linux.intel.com>
	 <b32a5081-545f-4703-ad88-ce54cc1efe09@amd.com>
 <fead429b4ee46bfb7cd1f1dee27912e155797fc6.camel@linux.intel.com>
In-Reply-To: <fead429b4ee46bfb7cd1f1dee27912e155797fc6.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8118:EE_|PH0PR11MB5879:EE_
x-ms-office365-filtering-correlation-id: 5cb88f43-9f4b-4880-25d4-08ded8f0ecc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: hvztfqG0KhfCbgtEG/ovQT3KXqearljs0BjnzWw9UAr0D4W5GK9Tvw7t+3i8wKal8njAhAClkJCGnqraULXoxkU3uMX21RnFQ8Qwc9FJiztP0vN8tlcjV9msvWaczgJESATzYGAUyNmUfI+3yQcZwJ30c1X6xfCsppyQ8qzOeVGbMMaIHeE8E7vjVkDriVJT9FsmB7dwLUuNGn2i44Ht3ISy9s7t9NTtpX/D09vG1ILNHJA6nGW48pjPOf8yAQ5DwC6l1ZCUVs0nBOqP7I+i3kgaeOqWU2C0mRPIoI29XfFQy2NohvhfMS+/Okw1Ea2AbreIEZoEefZQexRvwH1jFad2wEbSnMdHq2gHbyjnzpzEk1FZri5PX/eGKy7JXUd4aQnZWKY1iu8N39RN+0jQ90hmGjrKfUGJ8GRWRk/rPsekeA8/K890XAY9R4cyBL/mYui3rAw7voEoy3jAwQKdMhX9/n5GgeLKswA5BGsUbfN2PJ+C+PBsnVvSj56m8ISi6SifvL+Un0C7bKnfIGy04dpf3UtF3zeU7Gu5hwbiOMqprp9BDS0jDUDQNkXRC2l9yeCu2UT97CelOujBwgmJvrx1GdgordpOnVgzIXcdGjVMcM2Rc7eQ5/rHK+KDmldIwoWeLVf9Op9VIrby6dVvIYOn/4BgA0bruzj9l1hzKQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0V0WW80STFKODNOWXUxcHJYQy9QN1RtRzVSN2lIQUV5b0N0OHNhQ20xMWIx?=
 =?utf-8?B?dHlEbnptSG1FVlg3aVJGVlpxNmlNMzViWndvcm8rNm92T3owU2dzQ3gxa2pL?=
 =?utf-8?B?ZWl4STBLUG1CN0w3OHhXZUtDQUt5NmVLSVZoS0dHZE1peEZTdFJhRk1KdjFD?=
 =?utf-8?B?MGt5Vjl1TU1QWXoyRFVHVlZOR2ZhLzdWbkM1TldmeTZzZnZWVnh2ZER2dmkr?=
 =?utf-8?B?VVFKYTVGZDFJSGwxL092N2YwRE15RElPTDg0Nng3aTdTUlFLcWlpdmJYN3hY?=
 =?utf-8?B?NkFUZ1hWWVNvdjZLVnd1YkRwTXhIRFRSMjNJWG1XbHdDK0FvM25xc29DK0dP?=
 =?utf-8?B?TmdkMEhjUUZhcEZaUE1aRmpydjY2OG5qT2F5a25GUHF5aXNVaGlDU2hHeSt2?=
 =?utf-8?B?ZUl5a0V0L1RDK0p5UjZJL1crNXRnMFBjM0U2ZXZNSWk5YjkrOTZ6VWlabWJq?=
 =?utf-8?B?UnZKQ2tjSkRPdjF2MllzOWl3L0RScXMzRmErdnlMRWNHcEsrMjNBTmRwTHls?=
 =?utf-8?B?a3l0NCtyRUltT1J5b0hBQkFPNDJVejRvMXVya3JGSEpVampGT0JjOGZqVkpw?=
 =?utf-8?B?eHJzUnJ1U041YTByRXJVNUtCSTN0UFpuTDVHRWhoZ3hsNXl6TmttR0h5M2ht?=
 =?utf-8?B?VUg4bTJIbTZNWXNxaU1BUiswMFpOVHhndHZZMm5ZTGp5UXV6NmY0NXc3WCtj?=
 =?utf-8?B?ZVE3RTFHaEtvbkg5WU9nK0Z5QkVQV1pDVlFYaUtVTEtIMWNqNVRqckZyUDdz?=
 =?utf-8?B?RmhVeElVT0xsZW1zYVd2NloxZFBvelNUNnZKbG1WbW1KSGtqWmw5TmFSVHVk?=
 =?utf-8?B?RWtIWTJBaWE1Q0wzRjFLNWp3NStIeThQT1lMWURjN2FGMlc5ekhoWHo2MmFJ?=
 =?utf-8?B?c0pqMTVBdUpNajI0ZHh2aWpvS3FYZDJpcUZ0THRwTC9YRUNtVjVMT016N3NM?=
 =?utf-8?B?dUZkdTFQS2ZOY25MVDdLVG5wY0RUVTA5bUxIdXpaRUxHUDZqbEszelJyTTNX?=
 =?utf-8?B?ZzlnOHZjMUxMbTZnY1BvUktMMTVWbWp1Zm1ramVuaS9YUUNONnMrcVBQL0xy?=
 =?utf-8?B?MGF0NCt4cUd3eUs3Nk1QRXVhTjJndWpxakJsOE1CMERlSWZhNmI2VWo4bUtm?=
 =?utf-8?B?V1VOcFdZcmR5dldRVmt0ZXdxK0U1ZHgzRnhSS3JxQzBnUUZKWjU2N2VXdEZR?=
 =?utf-8?B?RjBTVlFSbDBPWW5rNlcycFFzcDJOcGxtV2U2eVpSY1FabkhPUUdtSll2VjN4?=
 =?utf-8?B?UXVhaWt6akw5cHVlMXVaVXhlRzBPRkpWOExlT1l5b2liWjR3d1B0cTU3a0Rn?=
 =?utf-8?B?VXdXZzBzQnMxOFAxbTgxK1UwRmtpVVEvWmJWY1JkaEpaWWVja0xLYkZlMEU4?=
 =?utf-8?B?UUlDK1dtVXdnejhFdnZTSy9ablJGT05vTWw0eG1Cais2elBYYk1oVGdBYUE3?=
 =?utf-8?B?ckZGWHVjVzhiRTZBNTdrakNVaTVHWjBTQkVRQ21CSXdPK3RpMWUvQ0lVVnpx?=
 =?utf-8?B?R0kxTmplQTVtY0E4aGVLOTBIU25xaFNqRXF0bWJtY2lGd1FvMjFPVHBFSmIx?=
 =?utf-8?B?Wm1GNmhScjQ3WTlaMFJMSzUxSERUOGlNNHJnclFQemxsVjJXU3QyUE5kSDRL?=
 =?utf-8?B?cUhlcUU5eURkNnFlK2p0RVNLcks0UnBQemp0dXVPMWVRcFJXYlE3WDlveUVt?=
 =?utf-8?B?YUhYOTZQN2hUNnhUVm12bms1dzY4VnJ6Z1pRN21hclVIODJJREtmQ21VaFFD?=
 =?utf-8?B?bHpSU01UUjRKb0RIejZUd2YzY0dDMVFmVlBDMVVzMHdESTI0ZWVON0VaMDVW?=
 =?utf-8?B?Uk9KQ1huMWp3N0k0Z08xSGtvK09nMDBnWkQ0Z3RLK2o0Z1BXMldUcDFwdnA5?=
 =?utf-8?B?T3AzK2V1ZjVJaVpKVHRERGFKdStOdFZmUFd3VEFQa1ZXQnpWYStzQndvK0xs?=
 =?utf-8?B?YnZJZzVOSTVtQWdQNGIwckh3ampYY3FrUjVFL2dLU1dYQlp6Zy9GajFYclcx?=
 =?utf-8?B?V3RONWxvRUMvamtyT3ZIVzhxdzJUM3pBTEcvTWt5SWM5VnBuQjFDWEkxbW9v?=
 =?utf-8?B?M2V1QzdDQklEcGZZTkhsVXhPMDMzbWRMWmFld25uUVZmUzlqUlo2bXJNRlRh?=
 =?utf-8?B?OGlmSEtZN3BuY3VQdmtmNnBDV3VkZzRIQjNBT2pYeDluSkNvaDdDZWRJVWxL?=
 =?utf-8?B?OWc0VjY4bWdLSTBrejJpYkdCMzBzcHN0Q1VaM0NQWlZvT1FVTkZSUS84UGZO?=
 =?utf-8?B?U3BOK3JyQUoyZEM4WU9jZ2RJQW5LWE1LdHpzM2c0OWdzNTNBNmJOYWJhbWJp?=
 =?utf-8?B?UDcwTXZmczhnVkVJc1F4L29maVpqOGRBdUtjbEhBZENUbTRoa250dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MRbA07cY+iYEQIMdVpBKs2Qt5MchTllBzmj7vqpkyl5RyIVquRuSSLqJTShsg+brk1vPNt9d46xVdCwKRfxvCc7TXy1cOOV/Wah1a+14xVveTe52TN3JS3TupYDOXSM7zhcDpmyYAK9/AatyEeduJ+WiM427vuwYYqpQa2yOi0s+4U5ksOxydzWo8lJNpaG5zIrtRQbCcEZz2ct2/yl5JVmngLFFCYeEMRl84F3oNZeqIElmpaVL+IJutA0aeJYHsOQ/NNv5Hl7cWcA8BhJwYMK9pwVa/TXJ/UOf+LbSO+LX2UPfkT3uIYS+pQ5DzD8YmUsgbuKZ/B4jFUngof0pKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb88f43-9f4b-4880-25d4-08ded8f0ecc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 10:50:40.8711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZXV1OttzgQ6/C+81E9c+SwtVlA+jbLV9I8v3skYoWA5aGfGVD3mGAixLnRpbIdmhLgQ1IQu9C6sZOZHqtyVTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgSGVsbHN0csO2bSA8
dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVs
eSAxLCAyMDI2IDg6NTMgUE0NCj4gVG86IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT47IEdvdGUsIE5pdGluIFINCj4gPG5pdGluLnIuZ290ZUBpbnRlbC5jb20+OyBp
bnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc7IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS90dG06IEZpeCBVQUYgb24gZG1hLWJ1ZiBhdHRhY2ggZmFpbHVyZSBmb3Ig
c2cgQk9zDQo+IA0KPiBPbiBXZWQsIDIwMjYtMDctMDEgYXQgMTU6MjAgKzAyMDAsIENocmlzdGlh
biBLw7ZuaWcgd3JvdGU6DQo+ID4gT24gNy8xLzI2IDE0OjU5LCBUaG9tYXMgSGVsbHN0csO2bSB3
cm90ZToNCj4gPiA+IEhpLCBOaXRpbg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMjAyNi0wNy0wMSBh
dCAxMTo1NiArMDUzMCwgTml0aW4gR290ZSB3cm90ZToNCj4gPiA+ID4gV2hlbiBhIGRtYS1idWYg
aW1wb3J0ZXIgY3JlYXRlcyBhIHR0bV9ib190eXBlX3NnIEJPIHdpdGggYm8tDQo+ID4gPiA+ID4g
YmFzZS5yZXN2DQo+ID4gPiA+IHBvaW50aW5nIGF0IHRoZSBleHBvcnRlcidzIGRtYV9idWYtPnJl
c3YgYW5kDQo+ID4gPiA+IGRtYV9idWZfZHluYW1pY19hdHRhY2goKQ0KPiA+ID4gPiBmYWlscywg
bm8gZG1hX2J1ZiByZWZlcmVuY2UgaXMgaGVsZC4gVGhlIGV4cG9ydGVyIGNhbiBiZSBmcmVlZA0K
PiA+ID4gPiBiZWZvcmUgdGhlIGRlbGF5ZWRfZGVsZXRlIHdvcmtlciBjYWxscw0KPiA+ID4gPiBk
bWFfcmVzdl9sb2NrKGJvLT5iYXNlLnJlc3YpLCBjYXVzaW5nIGENCj4gPiA+ID4gdXNlLWFmdGVy
LWZyZWU6DQo+ID4gPiA+DQo+ID4gPiA+IMKgIE9vcHM6IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVs
dCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwNCj4gPiA+ID4gYWRkcmVzcw0KPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoCAweDZiNmI2YjZiNmI2YjZiOWMNCj4gPiA+ID4gwqAgV29ya3F1ZXVlOiB0
dG0gdHRtX2JvX2RlbGF5ZWRfZGVsZXRlIFt0dG1dDQo+ID4gPiA+IMKgIFJJUDogMDAxMDptdXRl
eF9jYW5fc3Bpbl9vbl9vd25lcisweDNmLzB4YzANCj4gPiA+ID4NCj4gPiA+ID4gdHRtX2JvX2lu
ZGl2aWR1YWxpemVfcmVzdigpIHNraXBzIHRoZSByZXN2IHN3YXAgZm9yIGFsbCBzZyBCT3MgdG8N
Cj4gPiA+ID4ga2VlcCB0aGUgc2hhcmVkIHJlc3YgYXZhaWxhYmxlIGZvciBkZWxheWVkX2RlbGV0
ZSB0byByZWxlYXNlIHRoZQ0KPiA+ID4gPiBkbWEtIGJ1ZiBtYXBwaW5nLiBBIEJPIHdob3NlIGF0
dGFjaCBuZXZlciBzdWNjZWVkZWQgaGFzIG5vIG1hcHBpbmcNCj4gPiA+ID4gdG8gcmVsZWFzZSwg
eWV0IGl0IGtlZXBzIGJvLT5iYXNlLnJlc3YgcG9pbnRpbmcgYXQgdGhlIGV4cG9ydGVyDQo+ID4g
PiA+IHJlc3YgdGhhdCBkZWxheWVkX2RlbGV0ZSBsYXRlciBsb2NrcyBvbmNlIHRoZSBleHBvcnRl
ciBpcyBnb25lLg0KPiA+ID4gPg0KPiA+ID4gPiBGaXggdGhpcyBieSBjaGVja2luZyBiby0+YmFz
ZS5pbXBvcnRfYXR0YWNoLCB3aGljaCBpcyBzZXQgb25seQ0KPiA+ID4gPiBhZnRlciBhIHN1Y2Nl
c3NmdWwgYXR0YWNoLiBUaGUgY2hlY2sgaXMgcGxhY2VkIGFmdGVyDQo+ID4gPiA+IGRtYV9yZXN2
X2NvcHlfZmVuY2VzKCkNCj4gPiA+ID4gc28NCj4gPiA+ID4gc3VjY2Vzc2Z1bCBpbXBvcnRzIHN0
aWxsIGNvcHkgZmVuY2VzIHRvIF9yZXN2IGJlZm9yZSByZXR1cm5pbmcsDQo+ID4gPiA+IGtlZXBp
bmcgdGhlIHNoYXJlZCByZXN2IGZvciBkZWxheWVkX2RlbGV0ZS4gRmFpbGVkIGltcG9ydHMgZmFs
bA0KPiA+ID4gPiB0aHJvdWdoIHRvIHN3YXAgcmVzdiB0byBfcmVzdiwgc28gZGVsYXllZF9kZWxl
dGUgbmV2ZXIgbG9ja3MgdGhlDQo+ID4gPiA+IHN0YWxlIGV4cG9ydGVyIHJlc3YuDQo+ID4gPiA+
DQo+ID4gPiA+IENsb3NlczoNCj4gPiA+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3Jn
L2RybS94ZS9rZXJuZWwvLS93b3JrX2l0ZW1zLzgwMjMNCj4gPiA+ID4gRml4ZXM6IGQ5OWZiZDlh
YWI2MiAoImRybS90dG06IEFsd2F5cyB0YWtlIHRoZSBibyBkZWxheWVkIGNsZWFudXANCj4gPiA+
ID4gcGF0aCBmb3IgaW1wb3J0ZWQgYm9zIikNCj4gPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmfCoCMgdjYuOCsNCj4gPiA+ID4gQ2M6IFRob21hcyBIZWxsc3Ryb20gPHRob21hcy5oZWxs
c3Ryb21AbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogQ2hyaXN0aWFuIEtvbmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gPiA+IENjOiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcu
YXVsZEBpbnRlbC5jb20+DQo+ID4gPiA+IEFzc2lzdGVkLWJ5OiBHaXRIdWJfQ29waWxvdDpjbGF1
ZGUtc29ubmV0LTQuNg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaXRpbiBHb3RlIDxuaXRpbi5y
LmdvdGVAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gSGkgVGhvbWFzL0NocmlzdGlh
biwNCj4gPiA+ID4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiBBZGRyZXNzZWQgdGhlIHYzIHJl
dmlldyBjb21tZW50cyBpbiB0aGlzDQo+ID4gPiA+IHY0IHZlcnNpb24uDQo+ID4gPiA+DQo+ID4g
PiA+IHY0Og0KPiA+ID4gPiAtIE1vdmVkIGltcG9ydF9hdHRhY2ggY2hlY2sgdG8gYWZ0ZXIgZG1h
X3Jlc3ZfY29weV9mZW5jZXMoKSBzbw0KPiA+ID4gPiBmZW5jZXMNCj4gPiA+ID4gwqAgYXJlIGNv
cGllZCBiZWZvcmUgcmV0dXJuaW5nIGZvciBzdWNjZXNzZnVsIGltcG9ydHMgKFRob21hcykuDQo+
ID4gPiA+IC0gUmVtb3ZlZCBleHBvcnRlci1hbGl2ZSBjbGFpbSBmcm9tIGNvbW1pdCBtZXNzYWdl
IChUaG9tYXMpLg0KPiA+ID4NCj4gPiA+IFRoYXQncyBub3Qgc3VmZmljaWVudC4gV2hhdCBJIG1l
YW50IHdhcyB0aGF0IHRoaXMgaW52YWxpZGF0ZXMgdGhlDQo+ID4gPiBhcHByb2FjaCBpbiBpdHMg
Y3VycmVudCBmb3JtOg0KPiA+ID4NCj4gPiA+IEEJCQlCDQo+ID4gPiBwcmltZV9pbXBvcnQoKQ0K
PiA+ID4gZXhwb3J0ZWRfZ2V0KCk7DQo+ID4gPiBleHBvcnRlZF9sb2NrKCk7DQo+ID4gPiBib19j
cmVhdGUoKTsJCWxydV93YWxrKCk6DQo+ID4gPiBhdHRhY2hfZmFpbCgpOwkJYm9fZ2V0KCk7DQo+
ID4gPiBib19wdXQoKTsNCj4gPiA+IGV4cG9ydGVkX3VubG9jaygpOwlib19sb2NrKCkgLy8gZXhw
b3J0ZXJfbG9jaw0KPiA+ID4gZXhwb3J0ZXJfcHV0KCk7DQo+ID4gPiBleHBvcnRlcl9mcmVlKCk7
DQo+ID4gPiAJCQlib191bmxvY2soKTsgLy9VQUYNCj4gPiA+DQo+ID4gPiBUaGVyZSBpcyBubyBn
dWFyYW50ZWUgdGhhdCB0aGUgZXhwb3J0ZXIgc3RheXMgYWxpdmUgdW50aWwgcmVzdg0KPiA+ID4g
aW5kaXZpZHVhbGl6YXRpb24gaGFwcGVucy4NCj4gPg0KPiA+IElJUkMgYXQgbGVhc3QgZm9yIEFN
REdQVSB0aGF0IHNob3VsZG4ndCBiZSBwb3NzaWJsZS4NCj4gPg0KPiA+IFdlIGludGVudGlvbmFs
bHkgY3JlYXRlIHRoZSBpbXBvcnRlZCBCTyBhcyBlbXB0eSBzaGVsbCB3aXRob3V0DQo+ID4gdHRt
X3Jlc291cmNlIG9iamVjdCwgc28gaXQgaXMgbm90IG9uIGFueSBMUlUgbGlzdC4NCj4gPg0KPiA+
IEJ1dCB0byBiZSBob25lc3QgSSBoYXZlbid0IGxvb2tlZCBpbnRvIHRoYXQgaW4geWVhcnMsIHNv
IGl0IGlzDQo+ID4gcGVyZmVjdGx5IHBvc3NpYmxlIHRoYXQgdGhpcyBpcyBtZXNzZWQgdXAgYWdh
aW4uDQo+IA0KPiBZZWFoLCB0aGlzIHdhcyByZWNlbnRseSBjaGFuZ2VkIGluIHhlLCBidXQgSSdt
IG5vdCAxMDAlIHN1cmUgd2UgYWN0dWFsbHkgY3JlYXRlIGENCj4gYm8gcmVzb3VyY2UuDQo+IA0K
PiBJbiBhbnkgY2FzZSBpZiB3ZSBhZGQgYW4gYXNzZXJ0DQo+IA0KPiBXQVJOX09OX09OQ0UoYm8t
PnR5cGUgPT0gdHRtX2JvX3R5cGVfc2cgJiYgYm8tPnJlcyk7DQo+IA0KPiBqdXN0IGJlZm9yZSAv
IGFmdGVyDQo+IGJvLT5iYXNlLnJlc3YgPSAmYm8tPmJhc2UuX3Jlc3Y7DQo+IA0KPiBvciBzb21l
dGhpbmcgc2ltaWxhciwgd2Ugd291bGQgaGl0IHRoYXQgaWYgdGhlIGJvIGlzIHB1Ymxpc2hlZCBv
biB0aGUgTFJVIGFuZA0KPiB3b3VsZCBuZWVkIGFuIGFkZGl0aW9uYWwgZml4IGluIHRoZSBkcml2
ZXIuDQoNClRoYW5rIHlvdSBUaG9tYXMuIEkgY2hlY2tlZCB0aGUgeGUgZmxvdy4NCg0KeGVfZG1h
X2J1Zl9jcmVhdGVfb2JqKCkgY2FsbHMgeGVfYm9faW5pdF9sb2NrZWQoKSB3aXRoIHN5c3RlbSBw
bGFjZW1lbnQgZm9yIHNnIEJPcywgc28gdGhlIEJPIGdldHMgYSB0dG1fcmVzb3VyY2UgYW5kIGNh
biBiZSBwbGFjZWQgb24gdGhlIExSVSBiZWZvcmUgYXR0YWNoIGlzIGF0dGVtcHRlZC4NClNvIHRo
ZSByYWNlIHlvdSBwb2ludGVkIG91dCBsb29rcyByZWFsIGZvciB4ZS4NCg0KSSdsbCBhZGQgdGhl
IFdBUk5fT05fT05DRSgpIGFyb3VuZCB0aGUgcmVzdiBzd2FwIGFuZCByZS1ydW4gdGhlIHRlc3Qs
IHRoZW4gd29yayBvbiB0aGUgeGUtc2lkZSBmaXggYmFzZWQgb24gdGhlIHJlc3VsdC4NCg0KUmVn
YXJkcywNCk5pdGluDQoNCj4gDQo+IC9UaG9tYXMNCj4gDQo+IA0KPiA+DQo+ID4gUmVnYXJkcywN
Cj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPiA+DQo+ID4gPiAvVGhvbWFzDQo+ID4gPg0KPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4gdjM6DQo+ID4gPiA+IC0gRHJvcHBlZCB0aGUgeGUtc2lkZSByZW9y
ZGVyaW5nIGFwcHJvYWNoIHNpbmNlIGltcG9ydGVyX3ByaXYgbXVzdA0KPiA+ID4gPiBiZQ0KPiA+
ID4gPiDCoCB2YWxpZCB3aGVuIGRtYV9idWZfZHluYW1pY19hdHRhY2goKSBwdWJsaXNoZXMgdGhl
IGF0dGFjaG1lbnQuDQo+ID4gPiA+IC0gUGVyIENocmlzdGlhbidzIHN1Z2dlc3Rpb24gb24gdGhl
IHYxIHRocmVhZCwga2V5ZWQgdGhlIGNoZWNrIG9uDQo+ID4gPiA+IMKgIGltcG9ydF9hdHRhY2gg
cmF0aGVyIHRoYW4gcmVtb3ZpbmcgdGhlIHNnIGd1YXJkIGVudGlyZWx5Lg0KPiA+ID4gPiAtIEZp
eGVzIGJvdGggeGUgYW5kIGFtZGdwdSBpbiBhIHNpbmdsZSBUVE0gcGF0Y2guDQo+ID4gPiA+DQo+
ID4gPiA+IMKgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyB8IDI0ICsrKysrKysrKysrKysr
Ky0tLS0tLS0tLQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYw0KPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMg
aW5kZXggYmNkNzZmNmJiN2YwLi45YjYzNDFmNjk4MDUNCj4gPiA+ID4gMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiA+ID4gPiBAQCAtMjAzLDE1ICsyMDMsMjEgQEAgc3Rh
dGljIGludCB0dG1fYm9faW5kaXZpZHVhbGl6ZV9yZXN2KHN0cnVjdA0KPiA+ID4gPiB0dG1fYnVm
ZmVyX29iamVjdCAqYm8pDQo+ID4gPiA+IMKgCWlmIChyKQ0KPiA+ID4gPiDCoAkJcmV0dXJuIHI7
DQo+ID4gPiA+DQo+ID4gPiA+IC0JaWYgKGJvLT50eXBlICE9IHR0bV9ib190eXBlX3NnKSB7DQo+
ID4gPiA+IC0JCS8qIFRoaXMgd29ya3MgYmVjYXVzZSB0aGUgQk8gaXMgYWJvdXQgdG8gYmUNCj4g
PiA+ID4gZGVzdHJveWVkIGFuZCBub2JvZHkNCj4gPiA+ID4gLQkJICogcmVmZXJlbmNlIGl0IGFu
eSBtb3JlLiBUaGUgb25seSB0cmlja3kgY2FzZQ0KPiA+ID4gPiBpcw0KPiA+ID4gPiB0aGUgdHJ5
bG9jayBvbg0KPiA+ID4gPiAtCQkgKiB0aGUgcmVzdiBvYmplY3Qgd2hpbGUgaG9sZGluZyB0aGUg
bHJ1X2xvY2suDQo+ID4gPiA+IC0JCSAqLw0KPiA+ID4gPiAtCQlzcGluX2xvY2soJmJvLT5iZGV2
LT5scnVfbG9jayk7DQo+ID4gPiA+IC0JCWJvLT5iYXNlLnJlc3YgPSAmYm8tPmJhc2UuX3Jlc3Y7
DQo+ID4gPiA+IC0JCXNwaW5fdW5sb2NrKCZiby0+YmRldi0+bHJ1X2xvY2spOw0KPiA+ID4gPiAt
CX0NCj4gPiA+ID4gKwkvKg0KPiA+ID4gPiArCSAqIFN1Y2Nlc3NmdWxseSBpbXBvcnRlZCBzZyBC
T3MgbmVlZCB0aGUgc2hhcmVkIHJlc3YgZm9yDQo+ID4gPiA+IGRtYS1idWYNCj4gPiA+ID4gKwkg
KiBjbGVhbnVwLiBGYWlsZWQgaW1wb3J0cyBoYXZlIG5vIGF0dGFjaG1lbnQgb3IgbWFwcGluZw0K
PiA+ID4gPiBhbmQNCj4gPiA+ID4gY2FuDQo+ID4gPiA+ICsJICogdXNlIHRoZSBwcml2YXRlIF9y
ZXN2Lg0KPiA+ID4gPiArCSAqLw0KPiA+ID4gPiArCWlmIChiby0+dHlwZSA9PSB0dG1fYm9fdHlw
ZV9zZyAmJiBiby0NCj4gPiA+ID4gPmJhc2UuaW1wb3J0X2F0dGFjaCkNCj4gPiA+ID4gKwkJcmV0
dXJuIDA7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkvKiBUaGlzIHdvcmtzIGJlY2F1c2UgdGhlIEJP
IGlzIGFib3V0IHRvIGJlIGRlc3Ryb3llZA0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gbm9ib2R5DQo+
ID4gPiA+ICsJICogcmVmZXJlbmNlcyBpdCBhbnkgbW9yZS4gVGhlIG9ubHkgdHJpY2t5IGNhc2Ug
aXMgdGhlDQo+ID4gPiA+IHRyeWxvY2sgb24NCj4gPiA+ID4gKwkgKiB0aGUgcmVzdiBvYmplY3Qg
d2hpbGUgaG9sZGluZyB0aGUgbHJ1X2xvY2suDQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJc3Bp
bl9sb2NrKCZiby0+YmRldi0+bHJ1X2xvY2spOw0KPiA+ID4gPiArCWJvLT5iYXNlLnJlc3YgPSAm
Ym8tPmJhc2UuX3Jlc3Y7DQo+ID4gPiA+ICsJc3Bpbl91bmxvY2soJmJvLT5iZGV2LT5scnVfbG9j
ayk7DQo+ID4gPiA+DQo+ID4gPiA+IMKgCXJldHVybiByOw0KPiA+ID4gPiDCoH0NCg==
