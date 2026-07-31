Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628762D595B;
	Fri, 31 Jul 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532524; cv=fail; b=IqrX6WLmbzDX0Mp9vDlNfPkWb7eDP30CjH+J0Ca8yLSqUl8a9RXpSmSPqQDOp1GsWDaY3K5pqvAdZfs2oXzJ+oAAS3sgNFwAo4W7qiS+q72ILWe4CHTFtLKpc1+rG2/alawK+Exzl0GwZTw9RyUSLctUCiGtqg3fztrvRr9sJ0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532524; c=relaxed/simple;
	bh=Ir8j/6wpralKQzUB+0LogE+SWLV1BIrR4y7rHvmhup0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jMETTExFsWv3dVwnFLQcJYIS26GtO/Q1CEruLH58pSEWozjA8qyx3jpMvqQ/pf0ItJNJkz9jl3poW7a040PsOo1QMJcktMIhWOHPcWuKTP7bHsty8c/h71oyd5ASVl7DWQhFvmuLw1FePC/BwunmeUj9NKfhGRnBEvt5+L1xgoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1I5d78e; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1I5d78e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785532523; x=1817068523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ir8j/6wpralKQzUB+0LogE+SWLV1BIrR4y7rHvmhup0=;
  b=k1I5d78eWvdj6gk5L0QiExjmLc2MQMAd8HjX43erkSmzE6fbEQ9eqmwl
   ZpqL55XBOiO9K9qrslKIDseYjLBQZdy3+NwW5oqYxF18Zwkq7mOO5lxJS
   yVetajXWDThVsn9G8h9IOKVqzi0YXVwBI2t9y6RJmhrsGhV52UyIa40d8
   zDTYt9gT9tuEiOlKhHTQ6VN+shlvFt2PKDff6Mxq+/fZKg5XzOx9foA2B
   co5D6BhZWTL8Gr0ToW7y47UtEzO9w6PuNAI4ri/Zd/kk6tbvmE+nKw8OB
   JwUvfxee6cp/0QpkLxVIyqwWlD8a6Ast2IQqm6rIwKJnTVq/IMwqpnFcX
   A==;
X-CSE-ConnectionGUID: R/RXUmg7S/KQaEeL8OQE/w==
X-CSE-MsgGUID: wJEZIDslQN+WpnLdev7+sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="85929240"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="85929240"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 14:15:22 -0700
X-CSE-ConnectionGUID: oP2Mu/WmQzKDCaAa0ptVJg==
X-CSE-MsgGUID: xkRzLGEKS+OrZA0f1dSm/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="260724114"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 14:15:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 14:15:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 14:15:21 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 14:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtQP0RcI87f3wDyELR7a7WvpJWo1apWKh1B/S+Hz4l4F/gRINj0A026yc4gK1x80qK+mYmHHTdH/100zkLCog9Fx/LLQXycLfkgiqqK8EJdGtH8K5P3/h2xJdoj1VOGVb6FrggQiribTyDnDSN7lfSSRTZAaT3mU1CTx38fQdoPJZEzU55K8iPhOiYnjCru9aCYrBmAMYFztkYvLdUEDyw3HjoP8l8iWEOerEwAtO9E83j+oKwqUl4KPvrkWe8l7T5DKHEuok6NH4nDheEXQzw+37mmNYBkN8GlfH5bRl3hAgS0UZ3GoMsWXuP4iKpKFIHo+JE9ou/suXUS1v2TSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgAMiJOw8JgkvcI4HaKRUIuyYVv4pdsdwNaLu/ofWUw=;
 b=peajFL7/HKkNdofFVizKGE0noquxk7LWOyvJG5r+LcRcjPZfcA+jTipk8ds2i2WHTu4AoH/iHlEDNH5va98et0fgqK9XB1cjkGrKQYdmERIxzVrBl+zKlf4lsEwCqf1JGOgM5reUjxQ7ybupNDm6UdQG4KsKUaNkQ+9X1OkXOju3TNgucYfDPNapxbrefUQv8Qrz3KR9tw7W/ndkmKregIvAkrjpUR4Ip20sXuqDJaRntT0jc7+se/MwDaHBHfQAQKyanN5y/3aYoSJLxYq4Mb/iKSP429ctBGY+yonpyf33uA7Fd213cHWnBZJVV/dyzI29KYjaOgyuiUs+RFhkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:18 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 21:15:18 +0000
Message-ID: <67b265d0-49bf-4422-b0b1-e7273f09add0@intel.com>
Date: Fri, 31 Jul 2026 14:15:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX
 instructions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, Omar Avelar <omar.avelar@intel.com>,
	<stable@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?=
	<work@onurozkan.dev>, rust-for-linux <rust-for-linux@vger.kernel.org>
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
 <CANiq72=-HjYOoJPd=B+0OYrHuyCO+NpcjRvmmhT_ecVZj8q97Q@mail.gmail.com>
 <b705ef27-e87e-432a-ad1a-f425fe66887f@intel.com>
 <CANiq72kn8F-pnd-YxBiPN9nr02jagRk4NL-3vyX1tERCQjqNHA@mail.gmail.com>
 <fbbe2b57-19de-4480-b0c6-f44a6007a38f@intel.com>
 <CANiq72n0K3ULP=7iZhB1hnu6NHEHea66drAN3DKJEG-usTn6QA@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CANiq72n0K3ULP=7iZhB1hnu6NHEHea66drAN3DKJEG-usTn6QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a32ca3-315f-4ee1-3944-08deef48d2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: NgJE8aMGnjlMuOD7ognje0tZNdyqgNfvmtR8Mw6+nN07sJj6XPzpwKHiLCD/zTP22dLTKqPLpzovebFMy7b5RsXrzf84Md+I6+FyWSO8nmvYsSsDF7WkRqo169cIJaapJIHXKfngVXhzmbwnxaA3b9k6qHZpCvSTDxn1hIUOxOSeGzGwROGxVzdnmKFy0O7SEJDWL42kGn5cPyPZVolFNvXZso6LSS4NNFuyeUpI14WqNQ2dAjznj8UUlO7x9nMVirEWjXp0k6UbMvB6m6fKHUzOXSUYaeSevKdzrewtec5o26aYpdVUnNwvgw4GERlhb1Qn0wiGmDMJJiviclK1mpjRAjBrYBbIEBSM5Fs0Wkjp3dPWqjM97XtV7dMh8SBV1/Jpybe0n/IxMauhOjKSDmcsa0K8OBUqh7a4r1uSMVbQpuMZ+EYNRxq9RYbSg+jSJB0+Ey3o9sTnamGO4VVTtIIpMAWygShNAYM2FDSFFPEIKIDYvrChHCHFg10KIuCruvRTKGAmOZXEczZUfIBuAgSBeSqOPC8XWk46bk1Sk6hfZa8Cm4v3qXM0o6lQx3hG9rOnTOu5zYS9HYYN1HLBxFjauGHygSH1w0lNxkU9BQpWRJaAR16a23RiayYWHAjWKYmE8FnAFuKZZCHWij2JuWAuF789YtgcAjzy1guWsmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllTckd6dWZKaGdLTFRXUHhvQkpLeXRtRzBZaE44Wkd0akhReFIyRzlkVUdM?=
 =?utf-8?B?Y1FsNFVySk4xbm8xVytqRkcrMFdpTnozMkdUVTNXOXRWVE1iSjdCdVFBMFZW?=
 =?utf-8?B?TGdRdlE5QnpkZzlNb3AvTjdxVUx4bHBMSWxDRUkvSjFjTGFxcVdHcG5hWU1n?=
 =?utf-8?B?VkpxYitCRklFYStjVndxTlRqZm8rYVB5c3ZSN3gwVmVzNjBCWVVabnIzRDFl?=
 =?utf-8?B?Ui9IMGZQM2FDa3p4eWF5aDBhMFpRSHplbDlpYjErMy9JZzdVdHpxbmltOHBv?=
 =?utf-8?B?OVBnbFFJV282Tjk0SW1mT2VraXh1QnAyaWh0bFBzbkx5TG00bUpYNmdkYXJO?=
 =?utf-8?B?SDdseHEyRDhBZENiVHBXbmp6ZHFHT2VJTUVsSjVjWkFvNStTc0YxeWpxcnc3?=
 =?utf-8?B?ZklKTEYreThYMjhjRGlwdWkyZ3F3eTJUeElrV1pDZEJObkZnbytPN1Z3RjVO?=
 =?utf-8?B?ZDlSdUp3R1B4QWs0bFZ1bi8yZURRR3dhLzA0RHN5cDVwaWwxQVF5UkJQSWNv?=
 =?utf-8?B?SkFYWHNSWFAwR2d0dTZIclVCUlFMampLNnMvdlZVdi9Maml2dEkrNmlmZmJN?=
 =?utf-8?B?SUY1U1U0KzlkT1htc1BwZElqRk1IUEVuVlFBbU02cjNrMm5rc3dLdUNld2dQ?=
 =?utf-8?B?MTVJR2ZOMXlSNkRzWHVuMjdMcXAxV1VqamRSemVWSVNGY3JGY252dGsvZWRr?=
 =?utf-8?B?YmIrMThqNk9IbzhJQTJFMGJVSDRYOElkV254K3BUK1lVNDVVRzVNOWxvVzJo?=
 =?utf-8?B?US9EekVJeEIxZDNVaHFBZnV0Tm40VENUWXlFTGtPbG8rWGttcWhaNlBnYSt4?=
 =?utf-8?B?U0s4VUJjNjdhckFlMFp6bFJtSTZzRVJHYlRjWVYxS0VweHR2akI5dlJQNzl0?=
 =?utf-8?B?RzlzNlpKdktQYkNpY2pLNllDTHNLWk1tb0d0ei96VktiWjNTS0k5U1BOKzNN?=
 =?utf-8?B?dmVUQ0N5bmNUQ2d3TEp6QWY2aHZoTUNONFB6U2RublpkOTM3QmJLaCttOFNq?=
 =?utf-8?B?aElqRGtHalR2eEd6cUJWbGY1clRTbnNUVmxlYlBVU2lZNllGNFNlZVk0L1JN?=
 =?utf-8?B?NFN5SEgyeHZ2TWFLeCtKcTgvZWZ2b3AxdlpUY0k5eGVMNlFNeThpSzRFa2Q3?=
 =?utf-8?B?dEkwU3d0dTVXYzhVNDNIQUU0a1JSNzdFQ1hqdzBvU1JqZWwrTWUxeGVuK09o?=
 =?utf-8?B?UkJ4ejBMYURDbnRRQm5IL0llZWVSUk9Xengyelh6TTltdXd2ZE5KZUh3NDJ5?=
 =?utf-8?B?bFQ0YWpucjYxdG1vSHRVNGR4SGl6U3I2NXdYRTZSZ3oya2RlajNUOEdrc001?=
 =?utf-8?B?aG1HK2Q1LzE5SGdUbnVhNDl1QkZlR1pqTE8xQ1dEOGY3UDZkVE4vcE1xZDVx?=
 =?utf-8?B?TEhMemNBZW56MHlFVi9JamNPdktMYkRpNmg4dnllTytvTzduRk9BR25tdlpI?=
 =?utf-8?B?citUdG0rclc1VERKS1prc1MzYlZUbU9VM29lQ0JycXBuaDc3dTZvd3RYVVp1?=
 =?utf-8?B?dmtUM3FCV0ZUSkFGTEMycVlsLzRvTUxBZ1hNMnlQNTJvMEk2OGoxd3RIVG1I?=
 =?utf-8?B?R3lsYVNqZHg3Q3NuWjdNeEtockZSajRDOXIzZG5wcDcxZ01MOENPRGlGcnUy?=
 =?utf-8?B?c3NJYytQeGFxR3VDSEpaTHFMNWFLb09wUjN0T2lvZkJuaDZ3R0d6U25ZTStt?=
 =?utf-8?B?cDV4TG5ZRHVBQ0ZwR1JDSFVnVko5NElja1dPQmNOZkVySDR2bVAxZkZ4YkJV?=
 =?utf-8?B?d0oxRmhTMEJaTnNOSElXRGRzcmtNOU5zaVZXY0FkSDlXVTc3aHJQS3hOeXlm?=
 =?utf-8?B?amsvVFB0NGdOTEpYZ3ZoZmRzWit3cWJhMmhJaERZZ2pjR0JuOFNhczhCa3Fm?=
 =?utf-8?B?dGZFVWQzQkwwcWhJc0Q1eVZTamlvalJPbFlNRnZwSGg3WkVkNmxVQlFwMUkz?=
 =?utf-8?B?NkFnbEFUZTZyenJUYlRMNy9rZDh1bDJiMDlHUVZrYUgyTWtvSnNjaS9LcHVY?=
 =?utf-8?B?REtZQ0dDYWJJYWtSYVFQS1RGTzdadGNoR3BhYUtPdnJuYitNMWdiRUhPL1Mz?=
 =?utf-8?B?U2c1OGhxdUhXS3hMTHRZSGxzdmh1UW9RUDZaN0xLYXN2YUg5dzYwTEh5Y1h6?=
 =?utf-8?B?N1llOS8zVUtCWjNzb0puQ0xFMWlGbHlqcUZlcnZGK3prN1QwQUNmSEVOYVMy?=
 =?utf-8?B?dVZ4RWZOT1hvSE5ZUlhPNUFrWExWNkdJb0pueGdXdTdiWFluM3VVVHpxUGdo?=
 =?utf-8?B?bGZCVDdpbDRCS1hoQ3IzYkZ2S0lJR2l6ajh1ZmtYQWpTdVAvVGI2RmU2QytW?=
 =?utf-8?B?blU0MzFjYTdFQ0d0MVRNajRyYUo2THpSaVcrSXpZMVlraE1xS3YwUT09?=
X-Exchange-RoutingPolicyChecked: JcwgRXZEQ+kw94TXMBEVe0L5lQjPRnSAltdTFwKi3heNxIqj8tIwxHteYgiouUYDg2jVsvE8pfmhJmBlbZ/NxuntOEDx+Qd0ttztKExLIgHget/880kAOiOIjiccQDeoZ/gayCmg1Mk4rJ//VvbcVqO8whzdRpZgbBiicaiHw52BVT0WwhYv9hP67XZuPutiIlmaICgb0hUp/08XSueC34rGba/+o2OfxBCeAjvK+Q9bs6Anc0vAUg9J3wBFKLGtqRhPtkdPLpWePQlw9IigZG/EAN85XYkB357bOa7ihhvyt3/Yur9ztc91NZ7UEHPt9RBKyJhZLbyRM9YoCdoqhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a32ca3-315f-4ee1-3944-08deef48d2c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:18.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wu3owKuLCjFutYPBkJnsnvUP4/HlPa2EPt0u5tA2CfgvgDd0wWE5yXLQsttyTnfIRD4HlVWBJiGb87nZPT0OsoHq6rR2FKQArij9T0lAqh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com

On 7/31/2026 1:57 PM, Miguel Ojeda wrote:
> 
> Does it mean it could be the "OR" of those two?
> 
> i.e. it sounds like we could avoid having to pick one or the other.
Yes, you're right.

Thanks,
Chang
