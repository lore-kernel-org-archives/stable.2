Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7648989C;
	Fri, 31 Jul 2026 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530821; cv=fail; b=TQBvQHgufj5CJ7BUGv2RoV96igLEfMktNgZc3huOpyTPYDgwadAKcZGTwlSqZ/RHLIlZYZ1fEn8Fe7TTkgwuI/KRM++TDVT6DP2jdIlhBqD+/BEMFxhJ0lXEl2ishhomP0MxpJW/jVfjdM6g1mr36vku1Kx1o7IafdEdwx6sZHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530821; c=relaxed/simple;
	bh=xuOS7mLVKaUlTX9VBDkUZyJ0jgWF38j+DJ9xwvPR2zI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hqn2jYtZUsDnx3ljrHvF84ChQb3ECa9AU+G1NXY73ftxEHcKrh7ngZl8ZtHmGN/B5GZT5FvsuuU7ATMLSxuftnxMBVj1e31nUow+BsTJ9QrOeyhRdIggIi3dVpDcRN5lVl6r11gHIVp7sp5+rck7X40FvdjLMA57B3y8IHA1E68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5zeIpqS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5zeIpqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785530820; x=1817066820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xuOS7mLVKaUlTX9VBDkUZyJ0jgWF38j+DJ9xwvPR2zI=;
  b=B5zeIpqSK+dZcTijXOALMT5Lp7nu6luaS1bwAnFZzGasoc54fTHBodSb
   +OPA0iazB8Fe0zXCw+1MueYhHuwD9ns3NtEYycBOpo+UVs7rVEPa9NFPA
   KHadItL8kz4XrCfJxmmWrCp2GIRVuFumhb3/kD52qDO1VM9VuXZ9aAfgX
   C4E3Nkq8YLR2+zyxnoPq1u7GD/tMqhr9JeUE1iScMJJjiohEDu9DLJdFr
   lOwwAFT++CmoBkI3dWYCHnaN5H0T2htcphs1dZXFWMdTy+f6pn5e2XQEX
   ODt4MqYSPCUvyUnN46LASD24LJIhk97VhV/Sh0wzrrrkQkrCTUVaCw6lP
   g==;
X-CSE-ConnectionGUID: 9InCsGecQUKYh0CVjQ6GiQ==
X-CSE-MsgGUID: squmTjOFS5+8W7qrEh3VJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="97675310"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="97675310"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 13:46:59 -0700
X-CSE-ConnectionGUID: EOW+XgHXRwGq2OidHmsUMQ==
X-CSE-MsgGUID: XYmxnZrIR6aR6HkvfDrhog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="256759234"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 13:46:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 13:46:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 13:46:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 13:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTaV3nhCMJ4XdMT1C05P16IB1GUqBJGyONyi+CYjIXsim7QUIqd5i+Gdv+2egBqGcxvxfTXibYCwKNGS7vbYZ2bInOKcGKlGhWEpXrFckS8ZrctHF6Zfd/vzI6aW/DSherRfL/Ah987HXuyOxo8sr5xEAbk0BludS7p4+V8+0ohZJFLqIZoTAGIiRjLsDxEM9EW2Ap7LFu4Z8GnAUY/HPcR3GvzqVDE5XUwJx2uWUKtqlc3GZE3p8OK4vSJ05vxoF8oY0q6OgBJpSgNjgepZRh26+eD+bFQxSS37eeMOPH4NtXVfTbckW3VswcJK7SxfhdsVLRkBbx98q8TgRB30iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYvzITmp6AY3+9Y8Pno1UfZhnP2oJWUuYSIQt0nLnGI=;
 b=yhj4htY99oGMmvyQ9UkdR7h0BbTubeFC5mwGtbjt3a6J9cdwFUXy/KOc5SfCewiwrGuMyOSU3gHFZLW3G5qBR0rJ2UXwmsxqmPqUCABm1XVeFzkYgcLcKvAJKj2DdjncgEVf3dPuJXUUb7nhhzpUJmOE5SwuhFqM9M9TUtAEd+1A2gofDZ+NzDzkcOYlzyNh5ymgxzciFhvCIdM0GCq8YQ+sAxcAUv+0seNMMrv8YeUBXHFgdA+s3xoEan+5PjMA+aTKLDoTqgG63Rz8oh+RXRv4hwKgypDd+JA+qeYT00BMhuM8Cx1SC+D6qsOgkkdWwykMcAJxR26e6qjrb+lmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH8PR11MB6997.namprd11.prod.outlook.com (2603:10b6:510:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 20:46:08 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 20:46:08 +0000
Message-ID: <fbbe2b57-19de-4480-b0c6-f44a6007a38f@intel.com>
Date: Fri, 31 Jul 2026 13:46:03 -0700
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
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CANiq72kn8F-pnd-YxBiPN9nr02jagRk4NL-3vyX1tERCQjqNHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH8PR11MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c1435a-837d-44d5-5ed9-08deef44bf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6A/R6hfveaLRtwU+ryZb9U73FzgAHoOgLYhKRHRGEeLxz593TmImJWx3vSD4X0JS3p4cO8fROhx8elmXhj2EW/AuB56EUJiTJCpf9hecCPAZHFzQUDXF8ZfwrImuAkYYalyJCK9pz8dwDmuzm9Azr+fzvSCIBRo2ZNdU0tO6GWuOtqEyBI15vXzvQUQbp+8eiTC8G12Rlrml8LW3xVZjxILPaL7PY/T9YqSIDNC8Y3ww7VeR9P//2yCqf/iOSCayKjjWbYgVSXoDM12ZWQqj8FTE806qoPGRHe6N/lfFEm7Px4ao4L2zs66fEeJ8GqLTN6Ko5WLsZe4zbUL7YRz9b1LKV7TXJWc0j0bk6brFm9dQAGVuJhVRFzo+1vqE9MRlB+l25An9PzMzbosu0cmMlQN7tHUoo7aAlJW/7LDg6pp1agubDa5Af2Z1WmxYfRQ6zT4aUphA1sr0tq/tlnGhEu6OAmskBzK6tk+07xgvkflQoUqHt2iOFk5hBK2yWMZFJg9cLFZQe4/hWQHvfMRRlvSZ/Xk0ptWGL24KaBuoJtFFJ5C/sIKU/Zj8TrapRPD6kLMRzsKWMBOcHRfnGxDmtxr3CjI9s36+CzsL/USBLV/x+fqCmEEetXVGeTB4ynfu83/8mdZ6+e89jdOpbneRlRTj4YVG4Qhft1FyuGVr2/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhiUDhEVzM2TGFuVjJEVkZ0bisyVzlUKzdUQWVGMzkrMzVPbTlrRWlxWUhY?=
 =?utf-8?B?bkpKZVEyWnZPSmpLaGl0TCtSNTAxSVBjaVlRYXc5K2oyOEVudzVONXAwam00?=
 =?utf-8?B?Q2MzZ3JVa09jRzB2WDF0K3Zhck9EN01JZ2R5WWYvWGM0d2RTMTd4UXBnd2Zs?=
 =?utf-8?B?STBWVDBwVVJtUnBjNG9INk9SSVF1WWZQVXNqUXlRVjdTZXQ0cnJ0dC9TQjha?=
 =?utf-8?B?S3hhQm5jRmZWeHljVnpSc1k3azJhd1dLN3Z3bDVidXFqUXJ0NEx3ZitYY00w?=
 =?utf-8?B?ZU8vb0VNdTJkVjJOT3NpOUR4Y0ZLWExlYUY5TXNUZ1RWVW1qd1ZSQVlnQVBT?=
 =?utf-8?B?ZHpEVHJVU0xpMG41d2pBaTh5LzFKS08xN0NrcHE5QlZ4L1NWRmc3Y3NYUjJp?=
 =?utf-8?B?ZDZ1NHV6d0doZzdTU09YZENVYXEvVW53TGRkMCs3Q3JENDZoR3I4MUxGZnN6?=
 =?utf-8?B?ZDhIVXphWGVFdWV5ZExYVDVlWXRSU2hURmExcHF5bG5YL1FzbzdZSVBETWQv?=
 =?utf-8?B?aVdsYmNyVUlTTWVTb0h3U0VzUStzQTNCcE54S3Z1RTI1NjFtc29GOCswa01l?=
 =?utf-8?B?RStjQ2JLb3E4VTVGWjE0dXlicDdWS2VWbkJnOHVTZ2w4NTA0eU9DRmJHd0pY?=
 =?utf-8?B?NTM0c0l4WVZEZ3hOaVl5bW10ekZSWlFnakZSV2pmQjlOMWpwMFE0UDNEajJ1?=
 =?utf-8?B?Ujkrb3UwcWlSZ0V4ZXdES01ybjR0MG1zYWJKTFlYZi9iaVV2VStRRjBjTGNV?=
 =?utf-8?B?ZVhRM3FMdzhTeUdlbVE3Q0dCRk9CVURYbW91SDl3MHJCSFBJUks2bmNlbEVF?=
 =?utf-8?B?WW5tckgwVkRlbWkrbXd1RjdLUFZMRDlpZ2pNcDIyK1poNEJickdBTVh3WVBv?=
 =?utf-8?B?MThXK1QxcGRCZFlCbVI1VXB4eGFWYUtZQzBmeWFpNVdjWDB5L1hLaFAwdmg1?=
 =?utf-8?B?ZkpxUGlUVmlrcERIZEgvTGdtcS9XT0hDS3A3TmdyNWdCanNVVmdwNFdxYS9W?=
 =?utf-8?B?QStBNXpIMVBJYjh6dUk3VXFGaStqeTkwbm5iS09CTmROR0h5S3grRXFpVjVi?=
 =?utf-8?B?UURGR1ZqNHZ3SVpkU2dDMW5lMWZ3ZkcxUWNRSGtTaFhUYXVLQWkrVFlUUTlI?=
 =?utf-8?B?ZGVSQ2FPb2hTdHZ0Rm53WmdKWWVvRXAxcjVsRHlxYVhGQUwzeVdMSGdXOUF1?=
 =?utf-8?B?MmwwK1VCeHJqYkdxU3lTZWY2d29qaWZzM1RHVmNEWWs0WU9GdFdoWDFjNXdi?=
 =?utf-8?B?T1VLUFdxMG9PWWJ3SVZKWWx1STROYXE1eWJ1SVJTMUVCOGtqamppNmp2VWg4?=
 =?utf-8?B?WFYrdVlXdzVJdHZpenNza25TNDJiaTZmNWhNa0dEQkY1ak0zcWNNWVZid29S?=
 =?utf-8?B?NHJ5c0J4b3UwMmoyY3VaMzdiMEk1eFp3MzJQU0Y5U2VmMjc4ckllaFRmYTZs?=
 =?utf-8?B?U2hNeEdrUDc2TFlzVXNjRnpPM1M5OElhWjU3ZGJoVUNTd3lqbmhWbFVZNm5L?=
 =?utf-8?B?aFN2TEhNemtURC90Rk9Yam1tNG5HOHpQSHptQTJXSmV1MTM4NWZtVTVLV2Rh?=
 =?utf-8?B?NExwK2FUWFl5NytlUzlUTEZNREV0S2FiODhMVkRhMTVOMlg0SGovYkdCSnpl?=
 =?utf-8?B?eHZ5RnNvbzZjdGlnb2pWamI2aHQySDBUS3dUUEZpZVRvcmY4ckhJV3FxQlRF?=
 =?utf-8?B?bzA2UDlBL1ZjWkxtZzF6OHJ0QWdpRkxPd3RJWWZxRlB4dUJDSjVoUlFmNkFC?=
 =?utf-8?B?aVUyL0c2Tlo2QkdvVU9MT2R4NjZ5ZUM4R3VlSTdaVEhCYllnYjlJc3RMbTBy?=
 =?utf-8?B?RVNnWnhyWGR5ZVI2MjUvYnc1V2NTV1I1VTRuL2xDYVFEcXlORzVON0p4U0xX?=
 =?utf-8?B?Mk1KWStWZkxadWxEckNNcEZyb0xueW9sU0J5K0lMNHNRaGJzWDdCTjNSZDNP?=
 =?utf-8?B?eDl0UEdGcmorTFdwYjN3SE5GcmUvK3VNSUdlNFQ3YkRMLzBKV2o0WDk3UUYz?=
 =?utf-8?B?T1dVam1zRjhLd2NmNG5VQkovTlVUcHFXYW1zN3pTUVk0a3VqbkdNR1BIUmRp?=
 =?utf-8?B?ZndYNWRtY0Q3SmVxajhZb3l3dXhZdkdoc0NaRGt6M0g5WVQ4WEN2VEpJOTVC?=
 =?utf-8?B?c3VoVmZzb29leHZGU082T0tCWVd6Ykh0TGlHcVNNZGhLdHN2ZGIvLzROR1Fi?=
 =?utf-8?B?T0dLVUFlOFd5Q2dudjdUc05EZEVGUlh4VTJ6WGNCUTY2NmtiK1hHMGh1dmtU?=
 =?utf-8?B?TkNRZ0FCZXJ4c0s2ajdJQkI5dG1Uck9Mem94eGI4UHhkVGpaV2JvNmIwQlEv?=
 =?utf-8?B?MVNCZ0xsWE1lb1k0dGRFT3Nnc2cxUE13M05laktRSUR2MzFmTkJRZz09?=
X-Exchange-RoutingPolicyChecked: n0o6etlV8etlk6T/AQvho94cUqsNBGi84oTkkwHrKJ5ej7FR/lqXMpoFrscYJERPyct61q1ETY8I0Yclc3v9cT2bGEI6PF4NPZKy4pp49+AJTEHZR3els8Pde98JndfiCIVbEdAwAgYx+b/VO6KmDpXLnY4htnWRLXSiP/RZ/K3MHBuh+Uoo6mNN2z/UHiQzuNpfyXBwpDbAovElGYnoeCy7HEAOwtLGe5IOe7Y0lGsmjV5+LkO5u0cbCj2AIHitcf8WYgB5LZnySva5I4XCHcPZI+aKE3blzc14UasAqBydqcFLcvONBjaQeV9CFmwSCXgH7n1yxQ/YN0jUKEGRmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c1435a-837d-44d5-5ed9-08deef44bf8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 20:46:08.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbjrUNw30S7ChozJAzQ1FVT0E542Dex0efb7eg2hG74MUBUHazQ9ZVQO+5rEfe1VHyJ5AXLD8Bc8d9y7btelr2eOkYDSxO/38kNGoSPdIX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6997
X-OriginatorOrg: intel.com

Hi Miguel,

First, sorry for my delayed response.

On 7/15/2026 3:30 AM, Miguel Ojeda wrote:
> 
> I think that warning may be coming from LLVM, not Rust, so it may
> depend not on the Rust version, but on the LLVM backend being used
> (Rust compilers support several major LLVM versions).
> 
> So I would recommend double-checking that -- and if so, perhaps you
> may need to restrict the LLVM backend version. In case you need them,
> we have nowadays e.g.
> 
>      CONFIG_RUSTC_LLVM_VERSION
>      CONFIG_RUSTC_LLVM_MAJOR_VERSION

The backend LLVM does not recognize apxf in the target attribute. OTOH, 
Clang appears to translate -mapxf into the backend readables [1]:

   egpr,push2pop2,ppx,ndd,ccmp,nf,cf,zu,jmpabs

Support for the apxf attribute looks to be merged about two weeks ago 
[2], and which is also found in the LLVM 23 RC tree.

Given that one option would be relax the rustc version while tightening 
the backend like:

  Option 1: RUSTC_VERSION >= 108800 && RUSTC_LLVM_MAJOR_VERSION >= 23

Or, simply like the previous:

  Option2: RUSTC_VERSION >= 109301

Since the rustc front does no longer emits the `apxf` attribute starting 
from 1.93. Also, 1.93 requires at least LLVM 21 which already supports APX.

[1] 
https://github.com/llvm/llvm-project/blob/main/clang/include/clang/Options/Options.td#L7483
[2] https://github.com/llvm/llvm-project/pull/184078


> Also, from that
> https://github.com/intel/apx/blob/study_rust-apxf/study_rust-apxf.md,
> I notice you checked object files, which is a good check, but what I
> meant is to check the LLVM module attributes in the LLVM IR emitted
> from the Rust compiler.
> 
> For instance, if I do:
> 
>    https://godbolt.org/z/sMaajjYao
> 
> I see:
> 
>      +egpr,+push2pop2,+ppx,+ndd,+ccmp,+cf,+nf,+zu
> 
> being added to the LLVM module attributes when I pass a `+apxf`.

I see. --emit=llvm-ir looks to generate .ll files where target-features= 
is readable. Thanks for the clarification!

> anyway, I would suggest checking others. In fact, you could even
> inspect all and filter them out by the language DWARF tag. Or perhaps
> you can just do it for every single object, since the C ones are
> expected to behave the same, no?
> 

Yeah, I could check obj files running the below for example. Both LLVM 
and GCC builds appear free from EGPR use when with Option 2 above.

$ find . -type f -name "*.o" -print0 | xargs -0 -n 1 ./check_egprs.sh
$ cat check_egprs.sh
   egpr_refs=$(objdump -d --no-show-raw-insn $1 | \
     sed -E 's/^[[:space:]]+[0-9a-fA-F]+:[[:space:]]+//' | \
     grep -E 
'%r16|%r17|%r18|%r19|%r20|%r21|%r22|%r23|%r24|%r25|%r26|%r27|%r28|%r29|%r30|%r31' 
| \
     wc -l)

   if [ $egpr_refs != 0 ] ; then
     echo "Fail: $1, $egpr_refs EGPRs"
   fi

Thanks,
Chang

