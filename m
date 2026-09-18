Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1C43E076;
	Fri, 18 Sep 2026 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731234; cv=fail; b=HP1ioCSCKJoGImoaas35axyZ0OTpLBg25Et/EwT4mzLvf+6KCLWMB1rj6IKq+f8wIInSX67Ru5V0Rp5Nawvei6scash96xLzp1eaQYpNuTv3+pavwPvcUgcUQcVqKAZTgFnJftvpiHXO+9pASXPc+FR96szZjk7WJpXRZh6SgGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731234; c=relaxed/simple;
	bh=eKFl2VgGP79eywLn1Rt/HvF/AC8o1bhkzyQzWTMWQrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKGakij6ZXQRT1SptCsF79rFcuwexBqFpgtMAgl4SMAz9Bdq8Jqdk3HPqAiPi7gzvFuWyc8Yi7c5yJnwbHtf4z7RCeSNCmcmMoMkM3Wsr6VhCtgABbBeGRQ+38EXSGcLH6ndQjFIdFOPeKHmLDWUlncQui3JQ1ZOKK7QE1DDya0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZvZgfDW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZvZgfDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731232; x=1821267232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eKFl2VgGP79eywLn1Rt/HvF/AC8o1bhkzyQzWTMWQrA=;
  b=WZvZgfDWYgDDYu62SIBkb6+68YMetSJdAywFPNSJZUlq7N2/Uv2SLoL3
   ilBGvI+9vfHvtSUfKEH0bRgU7td4ALxBO/TG63i+zfnMPWpc4EzUbAKgp
   9AsN0I9Mf/88Kgdqtl3+Z2xXu31z+TjoJi9U9FaTxRQbKRayI5ThX16Ph
   DnvBU/WsppWYjDA8ugIXxR4Puv3WuFefcD6eQpuWvcLTiP8nTKCoXYADT
   YPxnDStbxQvlhA74uvJF5ePT3Qc6iABPwSzge1KYjhefxswXPCyXMVevn
   U5c2Of9/uEiGGHhlpkihJ3xOAJAyu1CWLBvmRfNkmCV3WQAc6TPP0Bjtb
   A==;
X-CSE-ConnectionGUID: KVK0GEsAQkC+8Jl00YjijA==
X-CSE-MsgGUID: MaJel2PUQq6qQKrW0Y3uZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="94063093"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="94063093"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:33:51 -0700
X-CSE-ConnectionGUID: rP4KBIUaS6C/GHrAQDh2Pw==
X-CSE-MsgGUID: +q/2yOEVQ6CKcw9fZoyQ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2550262"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:33:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:33:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 04:33:50 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss9z0qc8UNUhtmaMgpy6a9TGyJtEq3H6tWk6J4TRilZi9II6Wp7n7ei4DaWeJqNn477W/2OXO4CfrjJ+8TNLF6sGIVm6GkeTWBIG47DUoROKNhMN2acKCwqH33OhRKf9x5H15Fd+N15NMnB+RISnTVkwwJ1UUabFipScDPN7iY4FLmVsAE9PtOqJzU3K/8wDd2TzkwixoKoU0GLTLIRP9bdjbED86ZLe9RGLsoxha11j4Sj+zsgknNjZk2gc+njhEzwjsKO9P0WcLdciFfz7vexOoQBZZbPFjIIZKpf8TnkGvWI5OeJNkBJMEfBdpQ2e52Mly0WCEWY3rfZ4iYgJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKFl2VgGP79eywLn1Rt/HvF/AC8o1bhkzyQzWTMWQrA=;
 b=fm7Q/ND2ZXP8zP0gZ3vIpurpAcPqUiIqmImzXyOBji/PV7/x1eE2r05GiIbIwAb0X1CJ8ZeLoMEl5/ehEuqy4HGPesIVbAQwwmlixCwITD9OXoBVNPr1pK3YP77+PyZuXTyTSAaCsUVFgco0mB2AHm7ud4Hw/329rT+TddW0cDQ3BWYG27DmANosSFSRtXHCwleLHycZ6rovHB/C2ZNAMkh/+VrUV6C3ctBr3vi2Pktt5eP/83wfi+eUsiRYdbTEkBVjmeM51pwwm7w4/GGHm7zgSuXklP+pe+2nkY+LoePpST71WyU1oZCg+ow84y2BJai1WwgyTMVI1jHsba5j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by LVUPR11MB9787.namprd11.prod.outlook.com (2603:10b6:408:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:33:46 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 11:33:46 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Xuanqiang Luo <xuanqiang.luo@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "ahmed.zaki@intel.com"
	<ahmed.zaki@intel.com>, "mateusz.polchlopek@intel.com"
	<mateusz.polchlopek@intel.com>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Xuanqiang Luo
	<luoxuanqiang@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v1] iavf: add missing PTP adjustment callbacks
Thread-Topic: [PATCH net v1] iavf: add missing PTP adjustment callbacks
Thread-Index: AQHdNpEWRyqfGksdhEGja/UobFlRArazLOWAgAWNjYCAG5tk4A==
Date: Fri, 18 Sep 2026 11:33:46 +0000
Message-ID: <IA3PR11MB898550D3B15EDC08DC4B05928F872@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
 <ddc21a8e-b2dc-41a7-8390-5642664f08ea@linux.dev>
 <8ab343e6-1bb3-4213-9fad-fab43bf40362@intel.com>
In-Reply-To: <8ab343e6-1bb3-4213-9fad-fab43bf40362@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|LVUPR11MB9787:EE_
x-ms-office365-filtering-correlation-id: 7ec8124f-6789-4f12-03e0-08df1578b37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: yTIukP7HYu00MG7OzOeYoCOFGIoOkzRpAL5cGVRNFVnotca7srLNgB2otMGQfy9IYv7hF6RGL4w69gAr3pacxR1dA9KcNUnn2Y0OGH2aw+P4To/rcK4uRrak4N46rQw0cv/61tivmmPPOOhFt3zqj5OdHjkLvrnmgnR1ATmwt264Dz3a0IaMBzhKqSiyzCUfHIUXbOz+j5z1QqD3Iizd3NzIqX6e9ChyR3A0d68q240zh8cpsQZOKy2WfXfHWQYWTf7RuJB4ehukG/N+h0VInCJC3yJ6sZIP2ZtHDBlPvvvR6RNRgH1T+XA0fmI3CsnpTsO5XNTjyugykWyXIJQn0h0JDiJT0I5AG+YSjZA1RFLef/PNxsggGHvX0AQX3wYZ7EuIxd10bzBfgesKO6LYTkYBwHY80ivf8DfwESrprXV6781bskNbt/pWO/sw77kcOUXObJItblRpoaRttmC2qaGVuhqrNLl/MAkjA2uMK/ZNCG9TowcWY0ibSlGJatsBn5nVxQuEmUqZWWIZbwnaeA3KzBSmzqverA4Slf0YfcT36SuJAYWE8srg0PgQLDxNTwnVOSgWrTycIM9EpoVq4Q3SrQ40frHh+JBBEEj+9oYzh3wHPA2VFz5kfLOF+cg8WNXDTDkS/zOns9YG2KVwbQx/HyYgMi3qJyh0ZQCuS4jjGdKaX7bQQ3HmbPszm7pkwBy/o2oSSzYE9tPYPIILtYxIpHmGfQKJTeHuP1sfVZc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym5Pc0VRbVBkZlpFVU1vNTRYbEZIOHJNOVZIUEtLWTk0UlJtS3JPWDRDSUlF?=
 =?utf-8?B?c1krNVVRenR4VldkazVKbFluTkNpU0tHQTdML0hNSUxlMEM3L3MrNFhBemdK?=
 =?utf-8?B?d3UyQzV0UDJpTERGekVMdDJGNGY3NGZiOTk4N0g5dHRYL0k5WXVrNm1lWjdo?=
 =?utf-8?B?MTQ1bjdJSEp5YnVLcVhXSmlsazl1bjMzdWw5c2ZlTGQ1dnQwbFNkZkRzaC9X?=
 =?utf-8?B?VlVaSGpNeXJJQk5PZHUwRi9rVFREdWVVS1pQSVNNZE5ETWdqTkZZM0NJZk4z?=
 =?utf-8?B?aGszZXJoUDBKbThKVlc1YTFYOStqYUIyYWZWUXVWVWtnSVBEdWdBVzNqWWpS?=
 =?utf-8?B?cUNWRWNjYXhWOGtEcGpycnFHVzIvTGJWaDF0eTNEZlVUZUc5aERzNklwc2xG?=
 =?utf-8?B?dForM1AvQmMwd1BQMjRzSUZCZG5qYjI1R0l5Nmd1SHJLdUNKUTJVQzFFczBC?=
 =?utf-8?B?MGpnY213UDN0ZERBeG1qNURHMDk1UTRWRllSWU1kV21jWCs3UVJIUDgySDZz?=
 =?utf-8?B?Q29qV2VYeVdCTjkxeFFESHk4TjJSVUtqT2xVQTl2aFlqcDB2cG1aaWlmUmt6?=
 =?utf-8?B?K0d1bTRldEM1SUp3MDVac0xiZ1g4WmZwWWVDdkxqT0pVQ2dQbm5XNUhMUkl5?=
 =?utf-8?B?cWdMR29KeVZjUUR5bE10S2hLZE51SVhSRnNqeDFuUUtCWTVqREZJZUxLTnFQ?=
 =?utf-8?B?Y2RTeXE3Ykw4RkpUN0xLMlpGbytrSXhyWTNpdGxzY3A1ajM5OHkwdWdoUFBn?=
 =?utf-8?B?V2NMeGtEN1FtZUpJSElYbkhFTXpLbWZTVXNCV2R1NFJ5anRiaS9lZGtHaXh5?=
 =?utf-8?B?QVJBS1ZMSTFRNm9lR21mUU5PWDlubWh4RUFmRThsMk9BZXJIbk42dFRHT1Ft?=
 =?utf-8?B?b2J2ZnVKQ3I1MEN5cWoxM2JObFNlTUJjM3J3QUhzQjA5Y0RoVkQ4aE5TdEov?=
 =?utf-8?B?bllxWkpEUld0MU1TZVdXQ3diSmtHLzNKVnBwWHB4UVVaVzU0TFlNR3BiTmZW?=
 =?utf-8?B?TUtnVU84NS8xTXNPQlJIYzN3aXN6M1YvQmVQbXVPd2w1bWlncUQ0UlMydU5W?=
 =?utf-8?B?TmZERHhGekhVSnA0bExPRVl3ZUlhZTFOUjdIeDc5NnI0RW9xMEIwN1F6WWo1?=
 =?utf-8?B?MnU3QUc3NWRYTjFnWkthemR6MXVqNHd1SXcySEhMWEFjbTcxbTZLNm9PeUpB?=
 =?utf-8?B?K3dKUnFKU2VhQmxCYTc5eUlhZjhTaVY2UldIRk9ibzVvSzkzYnhHNDRsOThv?=
 =?utf-8?B?WXlGbDhKUzU0b1RYUTZxRG1TRHFyU21yYnRINXVrZkJZQmd0dzE0NDQzL1ox?=
 =?utf-8?B?RU5EdGllZTVRdGRmU3dHVHFCK2FJaVJHNDk1Z3ZEa0JRR05nWU1vaCtyd2hG?=
 =?utf-8?B?bkJhejFyYndJVGFWcjJzVWpld2VVYnFzQ1B2KzdpQ3h0dmVBOGtHbkxUUXNk?=
 =?utf-8?B?S0MzMjVxSThmdHhLQXVDdUsxS2UrVEN1dWdxRjRUcG4raVRITnRoUFM4b1BW?=
 =?utf-8?B?KzFPTkRCdmthWTRHTnF1bm42ckM5UmhSbW1ZTys5aDhnSk4yUnU0azVUSTR4?=
 =?utf-8?B?M2p3clJ3UU1RYUREVFRld1ZJWStFSkd0WVJqL2pmbngvdXZCL0c5UFptV3Nw?=
 =?utf-8?B?eTRJMC9RWWtzbE9XOFY1ZjRuaWtTKzlja29LK3FOTlJPWFlQR0lhMWY1WklU?=
 =?utf-8?B?Ny9oS2p0TEkrSUFEaW1NQmhzcW9jaXQyNzFiL1kxRWlYeGRseDFoMDNnV0Ur?=
 =?utf-8?B?TDB3dU9LM0t3dU9RTGV5TmFKRkJpRkVTcGRUSHprMkJIZkN2V0dBTHhzUDdK?=
 =?utf-8?B?U1QzN21yWm0vMmNLVEF3dkFsUTh4QVQxUm5ZMW1Ma2ZER20yK1lwMjlpWCtJ?=
 =?utf-8?B?cDFmWHN0WUM5dFVsM1A5aWpwcXUzczlkeUN1SWpVL0MxQWtpK2EzZlRXQklh?=
 =?utf-8?B?L3UwZnRCT1cvRlBNcnVtK2NLZXE0L1FEV05Dd2hPMTEySlpJMFpmYzdIbk9s?=
 =?utf-8?B?RlJSRVZwdytmZTlPSzRIRk5iSFZpOUt5c1ZJb3o1aWNVNkNsZDQ4SDlRclp3?=
 =?utf-8?B?U1JieEhzMkZwUVdySkUxUWg4dU5pNm5iVmJUa01GeHAwOVpvV0tWTmdaQVlI?=
 =?utf-8?B?TG9PamMzdFQwZVhGMEwzT2VkYmpMVlBGWUpFcXlad0E1c0UxRllFRDBOdlc3?=
 =?utf-8?B?R2dVZnJnMkdSMVFaeU5hamhzeExGTHhNNHNwN2RJTTVtdkFGeE92NkpUT09y?=
 =?utf-8?B?T1o5TjFURU9NVWVkZGxHTG8zUFUyVklLMkVVZUdPc0FLWFVCU0ZyeVQvaUR4?=
 =?utf-8?B?SGsxc3E3dEJMZkc1Q3E4NjZTdWRCRVBEM05jSDZYRUNlcGI0dVl6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wE/p8XMgEFYv+vmbktP8okOrDq5BdtWPe8WLqCUP/863+JlXLVvrGEs4oEiOQ2MylQzcKyWpg+p2GIos/4GHcWy536pDghfGZVYNLt1zXycSGsumpYTE/vyj/2lFfrb20UfZWek1weBpctTM3aKZws2LYkcu3heK/T9Va5mzdo/yMWj4wjQ97Z7Mnxk+m5imA5In5FTdbIJ7zsgZlfA3jb7vdnOatpT+DHEJkDJ2hmPZbWkEPXEdGrJcHIXe7r3Ws7JE6bfI8Fhy/BaZ/uKhm4BV5q4OPwDZFI3ECpYdrODavtXUIa2eP5aSrOP/RQXbFrXQXFFYYxuBtaX85GZEzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec8124f-6789-4f12-03e0-08df1578b37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 11:33:46.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+MLi9Ax+yJuVE+MP9uDF2B0vMtwadPOtM8PTe8xjODrK8nEHasmwm/1I3QGAy4z1J5KA0SiogPRDr6Qpb6PRFhTZLAA88g6SC4YYpQJIu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9787
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMzEsIDIwMjYgMTE6
NTggUE0NCj4gVG86IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj47
IFh1YW5xaWFuZyBMdW8NCj4gPHh1YW5xaWFuZy5sdW9AbGludXguZGV2PjsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IHJpY2hh
cmRjb2NocmFuQGdtYWlsLmNvbTsgTmd1eWVuLA0KPiBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5
ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVs
QGludGVsLmNvbT47IGFobWVkLnpha2lAaW50ZWwuY29tOw0KPiBtYXRldXN6LnBvbGNobG9wZWtA
aW50ZWwuY29tOyBzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbTsNCj4gYW5kcmV3K25ldGRldkBsdW5u
LmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtl
cm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBYdWFucWlhbmcgTHVvDQo+IDxsdW94dWFucWlh
bmdAa3lsaW5vcy5jbj47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXQgdjFdIGlhdmY6IGFkZCBtaXNzaW5nIFBUUCBhZGp1c3RtZW50IGNhbGxiYWNrcw0K
PiANCj4gT24gOC8yOC8yMDI2IDI6MTAgQU0sIFZhZGltIEZlZG9yZW5rbyB3cm90ZToNCj4gPiBP
biAyOC8wOC8yMDI2IDAyOjU4LCBYdWFucWlhbmcgTHVvIHdyb3RlOg0KPiA+PiBGcm9tOiBYdWFu
cWlhbmcgTHVvIDxsdW94dWFucWlhbmdAa3lsaW5vcy5jbj4NCj4gPj4NCj4gPj4gVGhlIFBUUCBo
YXJkd2FyZSBjbG9jayBkb2N1bWVudGF0aW9uIHJlcXVpcmVzIGRyaXZlcnMgdG8gaW1wbGVtZW50
DQo+ID4+IGFsbCBjYWxsYmFja3MgYW5kIHJldHVybiAtRU9QTk9UU1VQUCBmb3IgdW5zdXBwb3J0
ZWQgZmVhdHVyZXMuDQo+ID4+DQo+ID4+IFRoZSBpYXZmIGRyaXZlciByZWdpc3RlcnMgYSBQSEMg
d2l0aG91dCBhZGp0aW1lIG9yIGFkamZpbmUgY2FsbGJhY2tzLg0KPiA+PiBBIHVzZXJzcGFjZSBj
bG9ja19hZGp0aW1lKDIpIHJlcXVlc3QgcmVhY2hlcyBwdHBfY2xvY2tfYWRqdGltZSgpLA0KPiA+
PiB3aGVyZSBBREpfU0VUT0ZGU0VUIGNhbGxzIGFkanRpbWUgYW5kIEFESl9GUkVRVUVOQ1kgY2Fs
bHMgYWRqZmluZS4NCj4gPj4gVGhlIG1pc3NpbmcgY2FsbGJhY2tzIGNhbiB0aGVyZWZvcmUgY2F1
c2UgYSBOVUxMIGRlcmVmZXJlbmNlLg0KPiA+Pg0KPiA+PiBQcm92aWRlIGJvdGggY2FsbGJhY2tz
IGFuZCByZXR1cm4gLUVPUE5PVFNVUFAgZm9yIHRoZSB1bnN1cHBvcnRlZA0KPiA+PiBvcGVyYXRp
b25zLg0KPiA+Pg0KPiA+PiBGaXhlczogZDczNDIyM2IyZjBkICgiaWF2ZjogYWRkIGluaXRpYWwg
ZnJhbWV3b3JrIGZvciByZWdpc3RlcmluZyBQVFANCj4gPj4gY2xvY2siKQ0KPiA+PiBMaW5rOg0K
PiA+PiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9kcml2ZXItYXBpL3B0cC5odG1sI3dyaXRpbmct
Y2xvY2stZHJpdmVycw0KPiA+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NjA4MjYxMDEwMDQuMTAwOTc5LTEtDQo+ID4+IHh1YW5xaWFuZy5sdW9AbGludXguZGV2Lw0KPiA+
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBYdWFucWlh
bmcgTHVvIDxsdW94dWFucWlhbmdAa3lsaW5vcy5jbj4NCj4gDQo+IEFja2VkLWJ5OiBKYWNvYiBL
ZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gDQo+ID4+IC0tLQ0KPiA+PiDCoCBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfcHRwLmMgfCAxMiArKysrKysrKysr
KysNCj4gPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9wdHAuYw0K
PiA+PiBiL2RyaXZlcnMvbmV0LyBldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfcHRwLmMgaW5kZXgN
Cj4gPj4gODdiOTdlMDlkZjE0YS4uZmNiMjczODI4YmMxYiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3B0cC5jDQo+ID4+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9wdHAuYw0KPiA+PiBAQCAtMjUyLDYgKzI1
MiwxNiBAQCBzdGF0aWMgaW50IGlhdmZfcHRwX2dldHRpbWV4NjQoc3RydWN0DQo+ID4+IHB0cF9j
bG9ja19pbmZvICppbmZvLA0KPiA+PiDCoMKgwqDCoMKgIHJldHVybiBpYXZmX3JlYWRfcGhjX2lu
ZGlyZWN0KGFkYXB0ZXIsIHRzLCBzdHMpOw0KPiA+PiDCoCB9DQo+ID4+IMKgICtzdGF0aWMgaW50
IGlhdmZfcHRwX2FkamZpbmUoc3RydWN0IHB0cF9jbG9ja19pbmZvICppbmZvLCBsb25nDQo+ID4+
IHNjYWxlZF9wcG0pDQo+ID4+ICt7DQo+ID4+ICvCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiA+PiArfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW50IGlhdmZfcHRwX2FkanRpbWUoc3RydWN0
IHB0cF9jbG9ja19pbmZvICppbmZvLCBzNjQgZGVsdGEpDQo+ID4+ICt7DQo+ID4+ICvCoMKgwqAg
cmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+IMKgIHN0YXRpYyBpbnQg
aWF2Zl9wdHBfc2V0dGltZTY0KHN0cnVjdCBwdHBfY2xvY2tfaW5mbyAqaW5mbywNCj4gPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHRpbWVzcGVj
NjQgKnRzKQ0KPiA+PiDCoCB7DQo+ID4+IEBAIC0zMjYsNiArMzM2LDggQEAgc3RhdGljIGludCBp
YXZmX3B0cF9yZWdpc3Rlcl9jbG9jayhzdHJ1Y3QNCj4gPj4gaWF2Zl9hZGFwdGVyICphZGFwdGVy
KQ0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBLQlVJTERfTU9ETkFNRSwgZGV2X25hbWUoZGV2
KSk7DQo+ID4+IMKgwqDCoMKgwqAgcHRwX2luZm8tPm93bmVyID0gVEhJU19NT0RVTEU7DQo+ID4+
IMKgwqDCoMKgwqAgcHRwX2luZm8tPmdldHRpbWV4NjQgPSBpYXZmX3B0cF9nZXR0aW1leDY0Ow0K
PiA+PiArwqDCoMKgIHB0cF9pbmZvLT5hZGpmaW5lID0gaWF2Zl9wdHBfYWRqZmluZTsNCj4gPj4g
K8KgwqDCoCBwdHBfaW5mby0+YWRqdGltZSA9IGlhdmZfcHRwX2FkanRpbWU7DQo+ID4+IMKgwqDC
oMKgwqAgcHRwX2luZm8tPnNldHRpbWU2NCA9IGlhdmZfcHRwX3NldHRpbWU2NDsNCj4gPj4gwqDC
oMKgwqDCoCBwdHBfaW5mby0+ZG9fYXV4X3dvcmsgPSBpYXZmX3B0cF9kb19hdXhfd29yazsNCj4g
Pj4NCj4gPiBSZXZpZXdlZC1ieTogVmFkaW0gRmVkb3JlbmtvIDx2YWRpbS5mZWRvcmVua29AbGlu
dXguZGV2Pg0KDQpUZXN0ZWQtYnk6IFJhZmFsIFJvbWFub3dza2kgPHJhZmFsLnJvbWFub3dza2lA
aW50ZWwuY29tPg0KDQo=
