Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5572594BD;
	Tue, 14 Jul 2026 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067350; cv=fail; b=DaTHqQJQW5yyp450H3JzAfi84D3xMQ50TM1gaMxxUGg5Mfs8qo8kUF10+ZIGXUURWvdXY8c33zcSTSkjwqquW5rFPrpYKj4blMRAEwy1VnF04M1wHGoQv6YSbcTQ/UMyHmXDyuVU7/UysUuWJf9ya4vPV5c8dPdy4/t3PLvZWwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067350; c=relaxed/simple;
	bh=WYATAOEuCY2KRB3ONYiMo1JvEO+Sc7p4hycBS7XrGP8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WK/04K5Qnu0BdjOq5n/gxOQv36LOycJiUr8b0NdkYg5v1LK/i/qxPIv5rqx0XItWV2awMU15t98BjTeqHM7A6DDemCSAvRIbhrU0AzSajPIB6wajbF6kQW+pqqf8yVxF4AXQ1aSMtpIX4/E+tqGf238uBZf+tEHc28ja4AG2RhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPP6vMG9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPP6vMG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784067349; x=1815603349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WYATAOEuCY2KRB3ONYiMo1JvEO+Sc7p4hycBS7XrGP8=;
  b=SPP6vMG9N/X1D570blZ30q556lfXjVgoh/gGaJ9HCa6uZFuEMQovKKdi
   v/XI6RdFbphFHUEhg+8/ZU4W6aPuLxm7uc/SfWqkyZU6OpBzl0ygqr2Yp
   zlEWVAwx6WEVjbYpQYWE52PC3ISNp8F+3nFVTWOqsnwxusgFfZG2tDiaJ
   4PgK0JdU7IVk0kgyibpJh3iDxJW6mb1meEpJvBFCk4rpkFMEvuBbCN85k
   ArVCMZK2Jeqj0Pm0O5jHYPzQ6sZHAF54eeZpQJUctQvvuda6E85bhpSVa
   rCfzr2xmS3jtfvFPXRvD9qxRUFvP1ogyrANW14s3+StgrIk2Qt7jkqSEI
   g==;
X-CSE-ConnectionGUID: EClQOsE2QWydlt5k6Q82Tg==
X-CSE-MsgGUID: u9dKsRf5QqKYfGw/gZ2dBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88376451"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88376451"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 15:15:48 -0700
X-CSE-ConnectionGUID: wpifdbFJRTi4iMPWm+iIsg==
X-CSE-MsgGUID: NhmAfb9ERh6HNGFK+Kuehw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="253366956"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 15:15:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 15:15:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 15:15:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 15:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpqNlJjHAAz1WS7BJAawUCSrdSdUvh3Z1G4m0Xbx0PyKK5AZq1Zub/NOKuf13hY+gxmuTCY7t1W7gT8eQXQ0w17XVrabD1WLsChRcXyE4pKgHTtiPi41XF96dXo00O3mfYh9JG93awWtDf+LBLxE83iryARgw7wnOn4PWw1b3wXQLt3ad/yk2quWVSGXJIWzcoyCaBnUfJechWuXc8dI2jXxPKZ5ZTsAWRfntIi+Va+h3D3GTcW/AHh+8l+x8vwblrWyEkJuxBJbdbQO9cngmNgVZQTAQPcIMdsLVRSUs8gND1WKkWQRdZG7y3TSne6RkRgdxM1reVuJHrWdQMp6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTIXZwT9WQHC/HdGKnkcqzoQi3jN2SJexR5MJf3Lmw4=;
 b=pJ/H+rVEA6W8/gplYKFfoMXPGh4Q3Y0/yqVdaTPSuBIXRzmG/Adp2Ygpabj0t7GG5wA3DKV7cIXF4MUqscndsczvsgafO74X/MRGS0n+LCz+UMzlg68N8ndSjphENltqrfoQ4XWhzQ/23bis2cZ5NHnwdleKUsfmvnO8sj5L0TAnpBu7WnHKb8PxW3pJvhoRKkaLogCBBdC3SRM8ax0gfeYDfydCA5vMx653uCQ1xulqRXatJBl2rzSq6tfZtTJQ4JQHOkFwxqKYWuX+ziuZzIO/vkp0+rHvHiz4/O0c+NwYiWpFZDxn62Q/9cs9WA1O88/2oGPOxPxcREkzzJLIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Tue, 14 Jul 2026 22:15:45 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 22:15:44 +0000
Message-ID: <b705ef27-e87e-432a-ad1a-f425fe66887f@intel.com>
Date: Tue, 14 Jul 2026 15:15:38 -0700
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
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CANiq72=-HjYOoJPd=B+0OYrHuyCO+NpcjRvmmhT_ecVZj8q97Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA2PR11MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 94010da1-9ca0-4a3d-804b-08dee1f572cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|13003099007|3023799007|6133799003|18002099003|4143699003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1NPJNdmP8yPCOWdFsay81gBs34i/XbLeYGa9zkRjXBuz/gFEnH7gNQ9xkEX6h1BlvV//oCgZF2dLHnPehQ2a7KQvn6CKoB5L7XGhY4dgdm6MvEymyvjZLWVdGWSL0vCDhgOm1SwignFqMgXVZU4dQs+qBbP82RrmMQQMrbznpiHdakIcE843kLFVvvgOG9hlIxEntK1EaFj8Jcnnqvk1zuVp88FqgaR7a9lhBar+vxGXvBLvKYlN2AiO9dNxYXFajaCS7ohovdV81RzyyXiwygWae9g4TNK6+op1SZIouWw6njOEbtlBgFDRLK2uCIzgRQ8JqpdC8cezefluhvpRvyySYauXADMyNgGNE/XqVQ86M7DFlkGlKn0cmdYI8kj0F4OpWH95Y6XTV4BaliAJUh1g6Ll0Ce0QBmQNReWzrdFB1mPcP88aC8hMukMMYfsirGxuL9bd/9kNRRymwWYOBARB+ejkO18FocgfLZpSAyUNRHRW2gezv6589/cBgyDb2CK0S9pVCZCGta2ZfVFhJT3uIiBiaKP55IvsObYZjlJ3vJzUs7iHrLA/98ffHayEhN7ibjZsooI6/V8Aw3ErEVD5cFSctaUBvluK0z1kCOifprsakG0i2djkWyPG9nlOxTLPSBDtndx5i2eHKgOIcUt+pUusycBq78Mdg1fBiCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(13003099007)(3023799007)(6133799003)(18002099003)(4143699003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R08zNklvN3BZSE1yS0ZVR3JLSDFCVS84L2ZpbWZjTk5vbC9oWENGMXF2Zzhs?=
 =?utf-8?B?bXE0Ly9DYUZJWkpvZU5pSTFCak1lV0RzdXdQbXFtSGpMRWlHZmVRbzlCY25K?=
 =?utf-8?B?WlBDaW4vekV5RTMyOE1MTDFkSHpIRmE0MmR4dE1pcTFKNm1wM0I2ZlV3VWxr?=
 =?utf-8?B?cklCWW44U1RmaG9UdEVqdTNrUmk1ejdidFJWR3lPbXVmTm1GelpFWWplSXpE?=
 =?utf-8?B?ZnFVUWQzbSt0QjdwTkFUZmxtdUJWYnltZi9VcXhxSks5eDhaWDlLbFRndjhB?=
 =?utf-8?B?bzI1aXhmb0kxbGc1R0c2ejU1SWxxSDdjTEhoQU9ObGEwa015cEN4ZGs3Mlhw?=
 =?utf-8?B?aE9DM09EeGVNQ2o0WlZmVWNrWVRkWHgwMzdjN2FhUWxLQ2FtL1lpT29BRnQ1?=
 =?utf-8?B?aytNR2dpN2UzM1BzRXVxTU9jNTYwRVd2Zi9iblBYWklrTjV1U3c0VmhNNW42?=
 =?utf-8?B?Y0tDaWV2cDFBMVVzUjNpSk5sREJRYmo0YmZWWjFWK09hNWV1Ly96enVKTVkz?=
 =?utf-8?B?RkJ0aWl4SVh4T3NJSm1jK3l0NjZJSEM2YU1wVi94blQwSWFtaWZWbXd5S253?=
 =?utf-8?B?ZVdKMkxzNUptVGhoOGpua0VGZnZKeW5sZkQxbGlHV2Mzb1phYnM4M3Rycmxl?=
 =?utf-8?B?UVowd1IrUTRjaWxKWGUzN0JaOFNpdTRqbU9jbkFiTi8vSnZIUlRuUlU2NFFx?=
 =?utf-8?B?eXJQY1d2dkdmZURIUDdZdzllT3owbVlXa2FVRlVuOEl6VTVhdjdwT3hFU1pY?=
 =?utf-8?B?K3V2L3lEdWtjS2c5WXhYSVh3MVYzWnRrS2ZJbUJSWUNtb25JTDQzNmJYYjJX?=
 =?utf-8?B?TjJ0QkZOQ2pLdHNHWlQyak56N2lNTmV5V1E3aGU5SExDSGhnNUJXeXlkN0NN?=
 =?utf-8?B?eGlQMEI5SVBlTDVrVWRHR3BsR3Z3azRUMGdMTThqdHY3aGllRUE5Q2JDb3BQ?=
 =?utf-8?B?R09Hb3FLeG80UFN2SmJFWmQxaWMxUHZ4M3YxVk5xZHN6N2VZRXZZc2dMNDlw?=
 =?utf-8?B?M1JUU1ZNcFgvSzgzSk53eE1vazJvM09ENEliWTBWK1ZCaStkVytmVmFtVTNX?=
 =?utf-8?B?bXFWQ3ViRVJQTW9uSUdsVkRGSkZycm1HRWRRTFl3azlqL1VnRmVzNEQ2L05L?=
 =?utf-8?B?UFBYTU1oL0ZLamJvdzhUbVA0cElsMzFtMGFLRTJmSXhjejdCME9tQUJhOFU3?=
 =?utf-8?B?a1JVdHlONy9DZEROSzAwZzBWY0J4NEYvc0ttRlJxUmRMd1VIbGxuMTd5dmV0?=
 =?utf-8?B?K2VvdjZBc3Y1dzRqTnlVRmFNTFZrblVOUDdCTkxqTmRrQkRKZG41OHlkU2Jx?=
 =?utf-8?B?RTZnN29lcWc3dDB0c1hRL2VFcEVEVWhvb3d1d0NTaXYvYkFzWlRLTk0vNXNM?=
 =?utf-8?B?TVFTSlhnWjdQZVNwVStLWnRsb09IREFjY044V1RQdnFnZjZxNjNyWGRKODgw?=
 =?utf-8?B?RTlIQVR6SVJ2aUtrWU5KVEM5ZVY3N1kwL1hxNU1OSEJxTWIvSGprUG1TQ0ZC?=
 =?utf-8?B?dDZxWkpDdjJxTDdJejBLaEJOTmdnZkFIWW1DYUNPZjM0b1J6d1pNWU1rWjZO?=
 =?utf-8?B?Snl3TkVvaC95K1hVMUl4T3N6MXdiMUdndnR6czBRZlJNdmpraWRpZWwzMmF3?=
 =?utf-8?B?Yk4zTDVBaitGUzNjMENjTVJPc3RtV2ZYYVNQUVFzRE9qUVY2R2pkcjdUWG1E?=
 =?utf-8?B?aHhwaUFkMVBwNlhqVytwQU1Qd09TbGFrTzhyVmF4VDUySlp0aERwVEdIdkhW?=
 =?utf-8?B?T2lMWms0ZVhkSHVVc0YvTXR4bjdTUC9IQWhtenJJdklUUC95SWUrUVpEMUQr?=
 =?utf-8?B?L010aEEzM3oweE1NRUc2OVJXV0d5VENlYVdBT2pFcEpIT05KL1NxU1lLenZO?=
 =?utf-8?B?MmhXMlI0REoyTHFvNnJDMFZrU3gxUU1yZFd3ek5uS1czdG9JR0FDMTJ1bGlK?=
 =?utf-8?B?Q0o4eWFFYU4wZkRzQTQrUGsyVVBJZDhLZXdUVk1sRzkyQ0dkT0Z2TWh0YmNI?=
 =?utf-8?B?MXlXSTBKZEZTVTA3YnQ3Szk2cVpZaG1MR0pJR29vSkNsc0E4QUduN25INnlm?=
 =?utf-8?B?NUc1QzdhNzZFTnVIN3ZPdkRDRE1wbDhrSnY1dTdnL1hCTUFURjN5cHRUK0ZS?=
 =?utf-8?B?SGxza05SSHdoZmFVM0VZRVpxSG9LS1FHei9qVlY0bVRiQ2ZiM1hFUzRudWZh?=
 =?utf-8?B?ampHSDVKM1B4YnFJQzF5M25FV1ZYT3RNQTd4a2g5c3Q4T1Y0MWJaYVNoQkFL?=
 =?utf-8?B?SUVCZ3dLcFcvYXE0c0NNa0JranVTcFZlMmpEYjdCdFBQMXErcWVSTmgvL3VX?=
 =?utf-8?B?V0RXV21CMEZWRHBJdGhtTUV4czJ4SU55UXRpazRoSHRWQjlMSTVVUT09?=
X-Exchange-RoutingPolicyChecked: M0F1c8sJGTkFxXZj8EoUGRAowZq4xDD1VcIFNNTMUYMd562SQccbceTMXVUB82UMkYSOwHLkOIhp7CnDty9pSd8dM4t639NXFrRCxZklcHB4trpwRWim1788VDDmTEXCa6Z0lN9gx2zlWJ2AYxvwoXOGEc2vXiAWhPQ8NqlMB81F7mB0ybtHJIHp24Dh/bcosWyWcgmu5loIPOJz9FmFzxcrw15vFep7wl/4tGHvdH5WlSEYQMceYtbwrCQZBn/f6305VIvVKyI1AUFVFuSi9hXZWPHREJ3vD9wQfb/Fsrhy8pDg/uWdOYYw7ucfHl8Lgjuwfgbh6TflKbt9p5f74A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94010da1-9ca0-4a3d-804b-08dee1f572cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 22:15:44.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnAI40fI06RJ+pwzWLOOHL+Lk2Q0s7RB/apBMITZIONVbGbRB+cZK9v5D9ygnztqyMw8se/+ngadbKA5HPDyBR1zOIc1J+gtln59VM5TJG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com

On 7/9/2026 5:36 AM, Miguel Ojeda wrote:
> On Wed, Jul 8, 2026 at 11:40 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
>> +        KBUILD_RUSTFLAGS += -Ctarget-cpu=native $(if $(call rust-min-version,109100),-Ctarget-feature=-apxf,)
> 
> Hmm... I don't think this was tested?
> 
> There is a missing `c` there -- the flag is never going to get passed.

Ouch. :(

> 
> And while it is true that `rustc` knows about the target feature since
> 1.88.0, it will (sadly) still loudly warn about it:
> 
>      warning: unstable feature specified for `-Ctarget-feature`: `apxf`
>        |
>        = note: this feature is not stably supported; its behavior can
> change in the future
> 
> Instead, we should be able to do it in the custom target spec, i.e. in
> `scripts/generate_rust_target.rs`, assuming `-Ctarget-cpu=native`
> enables it and we need to override it. But please double-check the
> interaction between those and test that LLVM is actually getting the
> right set of features you want.

I did some investigation [*] into the APX code generation across Rust 
versions. A few notable observations:

  * Rust 1.88 is the first release to recognizes the apxf target feature.
    Prior to that, when LLVM supports APX, target-cpu=native appears to
    allow APX code generation.
  * Starting with Rust 1.95, target-cpu=native no longer appears to
    enable APX instruction generation even without explicitly disabling
    apxf. However, this seems to be implementation-specific and could
    change in future releases.
  * Passing target-feature=-apxf currently emits the warning you quoted
    because the feature is still unstable. Using the generated target
    JSON avoids the warning but Rust versions prior to 1.93 instead
    produce another noise:

    '-apxf' is not a recognized feature for this target ...

Given that, the goal here is to disable APX without build warnings. Rust
1.93 needs to be the minimum version via the generated target JSON.

> 
> Finally, we are trying to get rid of the custom target and instead use
> flags as soon as possible, so if the flag will be eventually needed,
> then it should be stabilized.
> 
> To help with that, I have tagged the tracking issue with our Rust for
> Linux tag and will raise it to them in our next meeting, but it is
> even better if the actual company pings as well:
> 
>    https://github.com/rust-lang/rust/issues/139284
> 
> I have also added it to our usual live list of features:
> 
>    https://github.com/Rust-for-Linux/linux/issues/2
> 
> Link: https://github.com/rust-lang/rust/issues/139284
> Link: https://github.com/rust-lang/rust/pull/139534
> 
> Also Cc'ing rust-for-linux and the maintainers and reviewers.
> 
> I hope this helps.
Indeed. This is very helpful!

Thanks,
Chang

[*]:
https://github.com/intel/apx/blob/study_rust-apxf/study_rust-apxf.md
