Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183139281B;
	Sat,  8 Aug 2026 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786159294; cv=fail; b=mO5AcXrKYKK/BpvpqS4VVbPh3/YHtasFUrAT0bYdpQ/WdjrUwGchcu4IieHmsIelil4MIyFxHmkN868oVni+qsdM4Mpxd9/UWUmzBOEw9YUKq/CSntgtgpa5NH8o0KdU3t+JVsvIYxoufusbFhNl7wdO8MdTWHKw/XDl2IuT9eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786159294; c=relaxed/simple;
	bh=+z54wCsnKpbohYWBSpvIEUPvr4Mrx+Z+28KlDN3z9mw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ov07c3CV2hhU4fc0WVbFy79OOj0lzxIVZIOPYWqFA2RkaYGDB4L8asoI40sXKn3hS8VCCwMpg0HG4NtYyJgSk2QeSmknEZE/pmXHv5w41DaKS3xYIVfrS44jrPkPEhmrjdYCpY4Vnt4DvVlmLIA10uk/MQWhtKZbhAQTDnlUMG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmhsW+Iv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmhsW+Iv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786159290; x=1817695290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+z54wCsnKpbohYWBSpvIEUPvr4Mrx+Z+28KlDN3z9mw=;
  b=PmhsW+IvNrBckb1KG+RJy0Rdxkm2LbbCJjpwnrB3+B5IvbHfNVXTQiUR
   QuuN9RgCn9PASQEUqqwZynqBYC2rI5/HgElcxzR9T2WJj+lYYDUolu63K
   b14F+N68d6wiHT9HGcI23zf0behxIHjBXwTEUGF56sdtc60JZOcCkW5UA
   0681OTwiOXVUeZ0pof6Zy9+dmhsCGMMLunZV76ou7RyTWUWS7eMAPmfb5
   WJJAoFWoabD8Z4mucZq9btaQ2tquJvBnNHXx+F+vDCk4cZrHu2p6b1Foy
   deFDcG6yg3oeiMDCwpbvCBNKPQ31WtpbBGY3b331C2TJa9qR/bu9NKYMv
   A==;
X-CSE-ConnectionGUID: mM6bcwCMTH2Caa1nwDeXrg==
X-CSE-MsgGUID: 57Lrp5gPRXGtjQKfQGIvCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86795934"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="86795934"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 20:21:27 -0700
X-CSE-ConnectionGUID: AmItD3IkTQu1ndF2RvOA5g==
X-CSE-MsgGUID: yuKv4JoyR/WVgy9WTLr6fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="292458900"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 20:21:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 20:21:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 20:21:27 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 20:21:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLlv0bdJrpTdz66UFhoFNN6GmklgHEtH2d6qT2wu18Biv/tBhK3eUnFjR3b/HZ6Ef06Eib4RREICWjI50ODR3JTn6n+AxYPFYMwkuAvmHOYoeXZdHFBarHOY+Uq/EvykUX2suNjcf51KH7ywoEKsmzJJLt/PbGjlU4i2gcPYpyC4bTy5F8tALS8ff/63zdQvzAZylPs6iPqdDpl933WL+vpYht1SUhKzPDXgiwVHwq1I5e1FTSQjIYhu7Y5oT9v3HZ8JuhvkA6jjCVvEHGjXjDatS8U3WoCTTYPMTEZlAuFqBGYG0i1OHvJGdNY9hNqTgcXB2bbeuhgQ2kG05XLaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ETw4TY8Nws4CkYcWsiW53WWq1/gLKAbyV2VECW1GcY=;
 b=ggNrxhT4h3c6TzvLEeAm63qeTmyQi6JwcvNbzhVTlsBshSx6YGP6lKXSxX2GTawpLjHPR64Y4nc5YE+jkDGx/fobpr9hJqKM6yTgDzwUgG1ye2faxW+ScfksDrjrSsq3FJI4Dk3ZO5HKOer+eBnKC0Rd9W9Gw29N5LZvbIYWwPTEAtGFZTksr5cmI1+efwtSf7FZi/XkfvCG0NuX8tP63ZFaReWy/UNYnKTrMGC/B2AmXOQ/OqHp3goCVX3D/w/Tt1HybzgkpSxkfPDGErhnDZ+oBh7YsfaPl4BFkMpTh877TlebfxmWJ1PHG69ohWDZfrmZ2Sdc4cvOlJgV0gS9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Sat, 8 Aug
 2026 03:21:21 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:21:21 +0000
Message-ID: <b00de567-f828-4ad8-a6ab-6ab1c47de68e@intel.com>
Date: Fri, 7 Aug 2026 20:21:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/build/64: Prevent native builds from generating
 APX instructions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<ojeda@kernel.org>, <nathan@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<dakr@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<acourbot@nvidia.com>, <work@onurozkan.dev>, Omar Avelar
	<omar.avelar@intel.com>, <stable@vger.kernel.org>
References: <20260807151715.7247-1-chang.seok.bae@intel.com>
 <CANiq72=bEB5-GvvroXigiCVtHjGtkhs1ARkk+mDbvjNAR4XKVQ@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CANiq72=bEB5-GvvroXigiCVtHjGtkhs1ARkk+mDbvjNAR4XKVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW6PR11MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: e28e8854-8647-4772-43bf-08def4fc1e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: +OPACHFwDV78ibiv9ef3savk1rU3ezwML95iqcjB9k5tm7EExGIZJYvt82lai+xq/s07Ohb5eLPbn3ejh3rJFHpI96GVoR6QUrGSWl47K2F2LDIqlaFXfUGpBJDJ9qc4lHDfuZI2LqYLVdZb+ggdGEo/sWCHkpSrjyp8HWraeOR9Ltk3cqv1KdzHT3AOTgKdWmjIRWKz1jS9OwGBA4MWs8qBoekhkdklyf7ZpIUAoiQLgc6izrEJxrW/1RgxUMCC/mGS9eM1E5WGU4TfOFFgDHowMBTD4pq3vZZoLcjGDLudazP013GqfCrSDe/1JPlK5o5gGrjMvF96qOJOCKKbEQQTGXvwitg+QdYsxqM7vPULbpO2blCYYUvyBmlAzFNtTTXwFfILHKbMixPvksGP8840Ut7V5AAuqueOrzWEWCCQha9w1lg6UVlWXHsZl5q05iN7mgUkrBXqeRVWouMT51NaIwiBSeiMPqr6MDN77e42ublVkxpQ8PHu7Dfk5th0z/f6AvElaBfJ6PtkcJB+UJQx8v91+KEmbnXhhz1oxW6R0nGS9c5sFLUIKygkJqyC87NbKQHDK+YMbvvApx3iQy1WR3f/vcbBmeakLxA2sH+koA6pwUYLrW8ebUxEvBWhzyUCAUXoz5PV0cT+sDU0wOn+bei5j/WmBH4KQ45fpWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHU5YXQ2K1VMa04zNnJRejVMUmYrZkc4SlRUOFBMcEsvMFlPd0ZQRVFKOVFP?=
 =?utf-8?B?ZEFKRGExUXlyQ2lVNDB2eFU2a3FxMk9panlEbERpWkpNNnpKeEJwbkRPQUFq?=
 =?utf-8?B?SHgxQmx4VjB4QkdrelhiUXF6Q0xCM0VPYms2VlJOWUF2UjBBbW5ZdlUybTUz?=
 =?utf-8?B?eldSek94TWc1eWl1TjFTbUxIK0tVNStHTGVNNUQvVmNmOE5KRkpKNTVHNjRU?=
 =?utf-8?B?aEtkZzdKTjBZMzdRalB0Z1VWd2JBN3hQNVlFRVJnbWpsU2NteUFhenJXZWxm?=
 =?utf-8?B?Wk5SN2M2aGtQOWxMYjNLUEZ3WGYrNXhPZGJHV29sZTFZRmYvMzZIS3VMTVlC?=
 =?utf-8?B?c0FtSWZybVBNelFyQ1RST3dLblBVazNkM3U1MlBGNFhTNS95M0pmQzV1aVNr?=
 =?utf-8?B?M2hsSG9VN2pEenc3UnY2UEI3RG5YU3phMDNteDNpK3hmeEhFZXZ2YkdHaTlt?=
 =?utf-8?B?ZkIzOXFqbVBNZHI0S3FnT2FNdVdkclhheHpHWUdtOHFCdnYvR09yWGRiaHVl?=
 =?utf-8?B?ZHhtVTI4dE5ZTHJiOXYvRHk0ZlNqRzBjVlZWalhaZ3BrcW1BY3IyV3h6WUlY?=
 =?utf-8?B?Z0IrNTlqMGJLand6QmxieHRQVXZuZmJHNjZ3cjRXQm4wUDJVNzJPay9SZHVt?=
 =?utf-8?B?WTZOWlh6NmVmWUorV3ZxdHp1WkUxUHlaNTZIdTJjcklibTNxWjhYazQ0MHU1?=
 =?utf-8?B?K2J6RmRaNXJzSXZlRHBzS0tKQWJoaE9oc3ZmRVpxZTk5Y1EwNVRWWDdQKzdD?=
 =?utf-8?B?K2o2dDJqVXhKRjZSejFEODVSc3d2K3M3cCt1T3BlNVQ2YVZNdGxGL2FzMytq?=
 =?utf-8?B?elRxR0dlZzBicTA2c3RGM1JGTzRjaG1XaUF4SUJ4VDk4dll5WlBzN1l2ZWhU?=
 =?utf-8?B?YS9QU1BTTW91OHFUYmlOZWpJR2dmR1dYWjByOU93S0JLckluNmUzZUJDajVx?=
 =?utf-8?B?dDcrM25MUkRIaFp3Tm5vK2hydDg3SFRwWDdXMUFHOHJQODcrRVV3RnAzM01O?=
 =?utf-8?B?cWxZU0J0eU81QitJY1RrNzR6UjBIT3ozWWd0WTZkb3FNMDh6emw2Q0xmNFRh?=
 =?utf-8?B?cWxYdVJpYmFIc1ljQTN1emx2dlBsa3U1RW1XM1AxNGUzT0RpNkV3TndtT1ds?=
 =?utf-8?B?WnhYekx1aXNQL2l2YTVVWnNmM2Y0eVJPL0VwbGNseThqL0E2NEI1a2RBSEMr?=
 =?utf-8?B?bEpFNm1sQ0NHdU5aU1FObENZcEUyZ2J1RUZ1WS9aSXkwSlozVytMbFEzWGly?=
 =?utf-8?B?dmJUOXc4QlV4QUJ1VWMra1U0am5oSm9waU0ybDR5a2x5TGJVTmNQbmo4Sms3?=
 =?utf-8?B?RXBlVzBoMUdxbmIxZFhrbnBNZ0xYc3ZSMFUvV05LUjFzbFlXaFk2ZnpDQ29i?=
 =?utf-8?B?a3hIeloyUXRkbVl0N1RXU09hVHJDS2hWL1pLU3crWnRLKzNwbUduWHVjUDc0?=
 =?utf-8?B?NlpHR0s4c3ZSZUY0K0xGWmg4YWpjQ2JLaEgzaGpCb3ZacVFJR01xNHU5dHRu?=
 =?utf-8?B?ZzZmOGRXS05zZTZJRkJrYmQvdm0yRjkvbzRZbU1iU3lSUHcwQ1VaU3lscFBM?=
 =?utf-8?B?WThBVCthNXZyb3QrMUkwTVZXb3AxKzRld3huRDg0RTlBTlkvVGRldEFZZDhq?=
 =?utf-8?B?RmxSRTBiZmU4Y1FpR25zbTNHVmxjL0ZreldmR21TdnNMenFZRzlqOXJCUUZB?=
 =?utf-8?B?RlViU0JhL05YRzBDNm5kT25IOWZCaklLYkF2NlA3S0lxVXhFMmxSVmViU05L?=
 =?utf-8?B?WFdyVmk5eTdOQWZJU1RjQ3ZNUUhNYWZIaERaRFFCU2pJODZoMW5udG5tT1g3?=
 =?utf-8?B?aUt4emdIVjZ1UWUyWXg1RlpWV1hyK204Tk1hUkp1YnRPeFh3UXZidTZ0K1Na?=
 =?utf-8?B?MW81RThsY0lXSTJiYkpVbVFZTWZrUkxCYzBGQUo2QWFTQXVpcXlyVGNaK2ZZ?=
 =?utf-8?B?MC9MTmRERkU3Z3ZsRnA2UFpqalFzQnk5U3ZkcjhDVnR0S0xBTE44eWs1N0FZ?=
 =?utf-8?B?SFl5RWlObWFQWmZpUDZXYWpHTGJyRHpJZmNneVd2VzJTSXh0NjZaSWthaExC?=
 =?utf-8?B?R2I2ME0vNkdZczBZd0FyV1RLQUc3UFo5NHkxOHQxdjMyU29vVk1Wekc5aVpk?=
 =?utf-8?B?RHRPelJJa3V0U1JlaitXV2w4RlVhNmh5bG9lMmRIY2NhWEFCSkhYMjV2cDl2?=
 =?utf-8?B?TWlXbDNzMTZlN3VLQjFMdmh1MG4yQ25JTUljeUt2T3pmSXpyQXJBbUxzTmFa?=
 =?utf-8?B?V3ZaSDkzOUpJWENOZnpsQmgrK29XMFBJY3MwWlNheUtyZ0VHTFdiM2UxeUZD?=
 =?utf-8?B?WHV0RHlLcVhTNHRJeUdydEhmN1NtUjROelpuTjRGdjNLaGJwZXBOQT09?=
X-Exchange-RoutingPolicyChecked: E7zoVDyQk+3eWwPbkdjAv3p/ySAojjf0Y/nrGlcVLaDtgkBDFb1JANq2ydZ/FUTkZK7JF7EHmfpcYIaUAvo7D/u23O1HTMitBMJMgY0mJnFOusoBmpeu8FhkqAXFrKvrONmeTllOkjJg93hQOXxtuEbPJpcAuT9QnockYa5zOUH1O4aF4VKzUOcANcZX9kqc9Y8qez7HcqQtm6Ix0a6oYN+54DZH61aPXnEYPN7IhVS/ffgG3qW9HqQud6zNvohAhbaYY78+VoCQFMaJe2QpYQCf95ZWcG6DRWdzaXLWwNa/qfg9QAc8QbD5CocHGR1TsVuaqGxgZ+2i632cA6yFhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e28e8854-8647-4772-43bf-08def4fc1e44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:21:21.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KktCrdqugrqExuWmBfGEWt+gr8lNEmD4f4bTUg90430Nxcxgx9Vn/pGBI1PRdSS641kzJl+eMECiAhlI5DsYw+OYG/KF0AyvuYHghCeCXfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8309
X-OriginatorOrg: intel.com

On 8/7/2026 9:58 AM, Miguel Ojeda wrote:
> On Fri, Aug 7, 2026 at 5:43 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
>> Omar reported this broad concern to me, when resolving a separate issue
>> with his custom module. CONFIG_X86_NATIVE_CPU=y allows builds to
>> opportunistically emit APX instructions when the build host supports APX
>> since the commit.
> 
> I think this sentence may be cut? I guess this refers to the commit in
> the Fixes tag.


Yes, I intended “the commit” to refer to the one in the Fixes: tag. To 
make it explicit, I can add the commit back here:

   ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU ...")


>> For Rust, APX must be explicitly disabled because any backend supporting
>> APX may otherwise emit APX instructions with target-cpu=native. Pass
>> features=-apxf through the generated JSON to avoid unstable-feature
>> warnings.
> 
> So, just to confirm: is Rust 1.88 (with a new enough LLVM) enough to
> avoid the warnings? Maybe a link to the tracking issue would be nice:
> 
>    https://github.com/rust-lang/rust/issues/139284


Passing `-apxf` through the generated target JSON avoids this warning:

warning: unstable feature specified for `-Ctarget-feature`: `apxf`
   |
   = note: this feature is not stably supported; its behavior can change 
in the future

I’ll add the link to reference the status of the Rust support. Thanks.

>> Support for this gating also depends on the Rust/LLVM combination. Rust
>> 1.88 introduced the `apxf` feature option, but versions prior to 1.93 may
>> emit an `apxf` attribute which LLVM 23 or later can interpret. Restrict
>> native Rust builds accordingly.
>>
>> Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
> 
> This looks like it exists in 6.18.y+, so I assume this should have:
> 
> Cc: stable@vger.kernel.org

Yes, I have included it.

Thanks,
Chang
