Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAF2F361B;
	Thu, 13 Aug 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648987; cv=fail; b=hK3M8ZGN7h0LDgZsQ4A9LRAY7JRjZorqUy++CoX2GnOO5ppaOgLW5ToeWXpX2EluMrdgLNXzbz0D3w2aC/JEIT/HPinoXkUgdzX5x2UuYLc6ip+ZatEknSznwRXkyeiy9gOIAoNGa37vlFXcQOpqSKxyihBiSOMubbHXDf71BJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648987; c=relaxed/simple;
	bh=2lvGsYOhUCf+9eqvE5Z6nXQ2jj3LyqXgOMApG9RxmD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XINLpQzZKaW8/Y1SjSOprjOdAE27X15HnNunCE6hU3+ud+dq3Sj+vhipHvNIWBSmsnJf5lR881ax+L3v1B0Op98qjFWP7xF3eZKKtzyUl10eZzQ/0AosD5kglkvgAutUiNyRMVV/PnT4rC1Wjh5Dr4MLX5XmgDFnwjgV6Kv7GRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCrcRnTW; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCrcRnTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786648985; x=1818184985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2lvGsYOhUCf+9eqvE5Z6nXQ2jj3LyqXgOMApG9RxmD4=;
  b=oCrcRnTWZNG9d3EHP1SxNd91qX6kYhAa1jE2berIAlTYO1XkFwSWDF6S
   Cwq5/K1eBN9KQapor/f1kqPUt6nTNcsMnrOE/Q8xofMRrzy6G6yjo7m4g
   iCpbDvXgPPdCURd+WkcVV+f6/oFBRKoLlbXuDoewiSf74n+GVVs1WPpEi
   Pj6MxayL3FxLwqGbTNGZ6B2UU3YpscKdHCKjCqIgVXx1rFvwdUF23lh8Y
   IABOUt8fOglCQIZtdO+4tAbrf58kMoUptKpp0MkB59IOS8x6DSSWGnK09
   l1wc7lmWzIJvdkx2Rm0/K8Za6GX7uxXlOBPQEZlSqCVRVtvXKD4iSPamO
   w==;
X-CSE-ConnectionGUID: l92luRSrRgueiH4c+i2MRg==
X-CSE-MsgGUID: 2wKJsfPpQzOjhDZfJAyueA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87306350"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87306350"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:23:05 -0700
X-CSE-ConnectionGUID: dJzxLEZ/TMiekcklnpIGJg==
X-CSE-MsgGUID: N9oRV4uaR6+CvWHHtzXCEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262698351"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:23:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:23:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 12:23:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcCOP1MZ7uwku5BiaAhTQ8xZapzPmp5hLu2cz6xKa627HTESt9yKgcGU8Gl/Z9fVJBfeYXVuqzRmb2gEog50j46LSeYwxYSondKXCAmm4COp8wsSFZlvdM64povps6zFmyKKsOWeruT7AabzpVOTobL4inr14bZuYDhdNG6VlDAlYTdJcCkBWgUXmp31LmRx7wnT/v+riQJgWja/AZxMmVphutU3WaucTsMd5XHccS6ZSriCEda31x0lzVMN3F/xeOpXzhD/fEjSfJ0BhY/q5V1G55a5y7EaPtd14K9t/UPvoHzj3S+mqx/o3dy4i7tFrYsl5ooZ+mUJ5jfDsdbI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lvGsYOhUCf+9eqvE5Z6nXQ2jj3LyqXgOMApG9RxmD4=;
 b=nqpVf9LUmzZckcCW84qQD6TEAMjmGLHesiOUg8XYVGQUM0m05P+Q0rGgSjAMFrJd3iraDVZEvcxGyn1MxR/JVrKilgVUM/KiBUC7CrcRJaqvFsrIJkZQX1/TSSSuVZGcSO9gbWT1aUQ2KzeYHWuYoU77Fy6yJY8b9dDJwEuJxXpt52OCGjHcvtzU33BA50TxZbczOOQ6tlQi/br6UGv8AgAhdZoZL0nHiJb5HzNffxgX0ab9HRCD0DpsGvCZBLLWi9fYQxyuzZ3Kxj9Ydzpskc3ihGUtOX4oRvMvRgF7mdRhSUxq/61Qs+/umgCe3eX2Gt71onZ+TAbhiXbdFMSEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 19:23:02 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%6]) with mapi id 15.21.0292.019; Thu, 13 Aug 2026
 19:23:02 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>, Doruk Tan Ozturk
	<doruk@0sec.ai>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix use-after-free
 of metadata_dst in repr release
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix
 use-after-free of metadata_dst in repr release
Thread-Index: AQHc/zHXDNjUJWhRoE6S+590uPJ5pLZNnO6AgE8W8wA=
Date: Thu, 13 Aug 2026 19:23:02 +0000
Message-ID: <IA3PR11MB93019BFA8437C98A13F00DCA8ADB2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260618145003.47471-1-doruk@0sec.ai>
 <4a54f8fd-2779-41dd-9d5d-f19151b68976@linux.intel.com>
In-Reply-To: <4a54f8fd-2779-41dd-9d5d-f19151b68976@linux.intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: 5d3aa2fc-fd08-4cb8-50a8-08def9704af5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|56012099006|4143699003|11063799006|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: aesKTEVJfTbRUXi+1riJU/LTQrFp4Pz8Mns79wUOvKL9wY+JlmWSMxqR7IvwI4eqtlLXzBhN/wk2jDxw/9K5yHXQiVKvFQzTQZUpFGfLWX+81XOtUUSkJYAz+GkbH9HJPLLWro3GRWuRbZqytupKOqsx6gOKkGDVw3NUOP4mzW/EiDq+9G352UIbIINiRwj6j6JEhF4tPepljxhVoMCDu6CjBKcY/paQCAl3thO9nOA67TDJKPA9x5KGxvl4+vXUaQ2uvcW6/szSnJpzM7NnEZV7wzRfV/cbuiLbGMmPkaTu3nxUvLI8Vw67G2T3refQS9jxP8ATixRd5zsIYjiXLzPPg6pV2eSxAoAGN/9+llbELvxBC4HUaxsF8+G8bSxYi+fjGQwbmBYx29KMSwdIEvTQxga3mkndfR5l3VCotZZG5KVWDAdrFdzHNA4oC25IHU8XEXrASKgrd3lIeqo+BHnSpcIcVzuXLpGSgpE055S91gh32U0hdQL0A56ZKkKpJ6LszaKHFiv4O7k0D67U0QP8kbZZaUWbI0wvQ8AcMuDM48FyilFI3DIMl7WBQ8g3mvGkQH1jyEDiKxhDarX9ish3buhue4g3jaG1BHFycMtogasyZxEHKPKNm800pBeYQ6qTiRvttz7cu2ZC0+4rgjPSDYqm/Jv4vTEunvNerwSOZtOuc7NSb0d/emvvK7NVddJNwnKvr3/LPESRWX2vemtcAd5+ho2EG15TKDpioQmG/Uk7n2ho2U+9Hh1+3cD5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(38070700021)(10067099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmh6OEJ5K0pFZDRURjhqWTJ0SHJaZGtNWUc1SW50KzhQWlJPRFpRSS9xZVEw?=
 =?utf-8?B?aGVMQ0ZNZmlybi8rY1c2SG9qcms0Z3JNeFRtdzE5b1JQUVUvNGV6MG1wR1gr?=
 =?utf-8?B?TDM0em9GSksyMWJqZE4yTGxoTitlcHBVOVM2KzkvbUg2Ym40V01FUXNMUjJD?=
 =?utf-8?B?eVpnKzBPd2FCZTM0bzRESUhSdXg0K2hKOVRzVUYvUTRXRGpjUHI2bnpScHN6?=
 =?utf-8?B?ZGVBblo4R2hnOXdhdWlGRzdJZTBZTTFyZm5GeXkrWnBiUzRiK0NJOHJjT3M5?=
 =?utf-8?B?NHFNbVlqKzQyQ05oZSt1dVRUWDRTTUdOVFVSbEh4SWp5elhBNHNwamlCYXJN?=
 =?utf-8?B?cStjRGFGenBNSnlUYWlENXFVbXBmZjUyVkpnbnZSa204b0tVRmtSYUJUZXRC?=
 =?utf-8?B?dnBHU3RyVSt1WENqNkRHYWRoMEZWQkM3RVF1ZGZlMS9RNXVPcnFjN0dEYWtm?=
 =?utf-8?B?SkQwVHU3ZlRsSXptdm5sN0hXR1N1b2ZWSHdCTiszKzJIdEs4YXBRaUVQTHBO?=
 =?utf-8?B?UHRUaVlTUk1reFMvYU5MWlJPVG1zdDllVUVKWStGZm9oUmdTd2Q1OXdZTGhq?=
 =?utf-8?B?SHp2Q3NMR0RqOThsV204Vll1a3FlZXhyWEtKS0ZYdXh5TklaY0p5WGxuY0hv?=
 =?utf-8?B?aGRLSFIramxpbE82azZEc0xWbHVqRHVxcmZZRHU3QktGV0xjRVBqMzRoZFpo?=
 =?utf-8?B?WEZCdmFuQUVuYUlVLzB0ZGhlQjU4QmdPSmRoZmQvU1A3YzgzNmhTeVlQaEd3?=
 =?utf-8?B?YkxndVJtWmJsc2toT2sxbDRVSkNWV3pJVkdyc0R1cXM3YUJKZDFBdWh6T2pr?=
 =?utf-8?B?YXNkQlBVTzY1V3dNVU85My81TzFMNXB5Rm9acG04c0x5T1BGUFcyRFBrY3ZJ?=
 =?utf-8?B?S0tCMTI0a1BnU0dURUp0SmFnaUFtQjNnYjJ2RndvNnQ5NDRQczVBbldabGtE?=
 =?utf-8?B?L3VaY1RUaFRUMzVNQ1JyMHF0Ny91dkdGbEFOSGc3OFk1cC9kNVAxMmJySXdH?=
 =?utf-8?B?Y24rQnUxd2M2aFJuemdxZmlrMEZBc05rbnduM3ZUdHFYREN6eFFWdFBuMlBM?=
 =?utf-8?B?RkhaM045UG1vVzdTWDFOcjltVlpzUlJrV2JpSlBIQlJreDNkTlJRbk5XbW15?=
 =?utf-8?B?azRFckZuYXVyaXZ6aWNNYWY5QjM3ZWNmcWVnZFpOcG5na1VmQ0VJWWRBZGRT?=
 =?utf-8?B?bDgwQ3orKytScUY4bVY4Sk51T1hkOUxTZnFVZk1lbklQWWZBSHRVaFFIaVZw?=
 =?utf-8?B?cU1oNlFHWEZ6ZFhkKzdZVTlQYXVUOCtVZnhHbEgrVys2VXQxL2ZUVDNWaHFX?=
 =?utf-8?B?S3Z0aUhObUhyaCtWSnFqMlo1ZzVSTXhWVGVQS3FFN0JzaWg5bmdvR01CdDQr?=
 =?utf-8?B?SUZFcE9RaDZJY3ZYZjZVRWI5U25wWWk5UGVrZHQ0L3hMVHlQMXZGbkZNVUxD?=
 =?utf-8?B?dUhISDg4TitzUWNscU1kcXVZUVBtakpFeFNYRTcrN1M0OG42K0IxT3lIWm51?=
 =?utf-8?B?a2R5RFBpYldObDl0VENOSHpRRVdpR1ZzS0Y5VWlJbFlmMlN2YXpVVkRZYjJ4?=
 =?utf-8?B?b2RSRHp0ZkJtR214YU5hNTYxWTRaQ3JWd1pBRmwrbEU4RmRGZ0FSZkkrTlQw?=
 =?utf-8?B?a3AzbFNPWkxaR3BnK2JXRVU3bUpzSjVrSGYvdEVaRWZnaVpYa1lPTFRvbXJQ?=
 =?utf-8?B?azNHbWZ2eHIrUm9IZkNZYUJLM0RMdlFvREpiNTVhb29OM1ZqWlZVMVhoZmxv?=
 =?utf-8?B?VmdDUmk0NE5RRkdQK3BROWY3R0p3S1RpMGE0c2FSWk85eEU1UnBEcEpNdHRn?=
 =?utf-8?B?Tk9QOGYxbUkxSXlCM2F1eG5IeHpMUVBic2llVHVpTTFsK3l4UGFJblYzSUFS?=
 =?utf-8?B?bk1FM0hmbnBiMzNHN25ZMTJMTGZNazFwQ1lmNitqcFBDc0hrNXpSQWNGRldt?=
 =?utf-8?B?YURXckhpalgreUt0R1Joak1ZSGQ5U09BTTVDSkNHWTZPeHhPZjNQMVp6UDF2?=
 =?utf-8?B?WjI3bUQwMkp6YUlHL0NBc01lcGNHMlBjN1JjaE5uREc3OG1FWnBvOFdjMHVh?=
 =?utf-8?B?T0oxV2NscS9QVlI3NnVqVU1Xc2Rtd0w3UjFucWFsajhJempWeEx4ZVFPOThm?=
 =?utf-8?B?ekNsQVJGS1FVaWdab3NXV3RMUTM0bHAraVllTU1PcnZyY1J4VWpVbDVNWWJ1?=
 =?utf-8?B?b2x0cCtocjViUVNxSVpmL3I4a3o1TnFLUVFBK3JUKytsYlk2T3VjL1d5dXpX?=
 =?utf-8?B?b3lTaURJQ0lQNWZaNGQvdXU3RXUyd1NCanJiYjRienVVTVJLSEs3OVlCYStH?=
 =?utf-8?Q?I88lyr9jSEBlR291EP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l+b1R+ebRwXyxixsbD/rLT/g1MigpAH4Yi+iIWBz3P4oYs70ZADlmFQHDWgManWQ+C4RcxmXXJ3zcqs2TncLr5rkaVcMguGI4BhcFwyISBoSxpgsWnoEXoCXwEDc7jxmSZRvDdexq6ZAErxb3x4i+YAKEmo7H6w1j6aUIosPURlWEQOhR5vWJei5s1LuPvXxgyz55VWUC9XfJspIjuKAa/05/nb+ezaMwwSBGJOUzcl43WvY/yTNfLYXwdPZ/s8g95GR/M373I7gt4mjFu/MICTwxkZLAmvRxu8YlvM23y/v7qNhl5m2kXyqMuHgrPE/NcX+mB0UEmxoe7RFXErmuw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3aa2fc-fd08-4cb8-50a8-08def9704af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 19:23:02.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paD5zZcsUUUQ9QzG6QPOhk2/hV3eScw9xb6h1h1FY9IGg6x3pmVw+PYjMPPNLpIfTM1878skcvtaT3vVPvSEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBNYXJjaW4g
U3p5Y2lrDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyNCwgMjAyNiAxOjM2IFBNDQo+IFRvOiBE
b3J1ayBUYW4gT3p0dXJrIDxkb3J1a0Awc2VjLmFpPjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFu
dGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15
c2xhdy5raXRzemVsQGludGVsLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4gZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBw
YWJlbmlAcmVkaGF0LmNvbQ0KPiBDYzogbWljaGFsLnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNv
bTsgRHJld2VrLCBXb2pjaWVjaA0KPiA8d29qY2llY2guZHJld2VrQGludGVsLmNvbT47IGludGVs
LXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBo
b3Jtc0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0gg
bmV0IHYyXSBpY2U6IGVzd2l0Y2g6IGZpeCB1c2UtYWZ0ZXItZnJlZSBvZg0KPiBtZXRhZGF0YV9k
c3QgaW4gcmVwciByZWxlYXNlDQo+IEltcG9ydGFuY2U6IEhpZ2gNCj4gDQo+IA0KPiANCj4gT24g
MTgvMDYvMjAyNiAxNjo1MCwgRG9ydWsgVGFuIE96dHVyayB3cm90ZToNCj4gPiBpY2VfZXN3aXRj
aF9yZWxlYXNlX3JlcHIoKSBmcmVlcyB0aGUgcG9ydCByZXByZXNlbnRvciBtZXRhZGF0YV9kc3Qg
dmlhDQo+ID4gbWV0YWRhdGFfZHN0X2ZyZWUoKSwgd2hpY2ggZGlyZWN0bHkga2ZyZWUoKXMgdGhl
IG9iamVjdCBhbmQgaWdub3Jlcw0KPiA+IHRoZSBkc3RfZW50cnkgcmVmY291bnQuIFRoZSBlc3dp
dGNoIHNsb3ctcGF0aCBUWCByb3V0aW5lDQo+ID4gaWNlX2Vzd2l0Y2hfcG9ydF9zdGFydF94bWl0
KCkgdGFrZXMgYSByZWZlcmVuY2Ugb24gdGhpcyBkc3Qgd2l0aA0KPiA+IGRzdF9ob2xkKCkgYW5k
IGF0dGFjaGVzIGl0IHRvIHRoZSBza2IgdmlhIHNrYl9kc3Rfc2V0KCkuIElmIHN1Y2ggYW4NCj4g
PiBza2IgaXMgc3RpbGwgaW4gZmxpZ2h0IChlLmcuIHF1ZXVlZCBpbiBhIHFkaXNjKSB3aGVuIHRo
ZSByZXByZXNlbnRvcg0KPiA+IGlzIHRvcm4gZG93biwgdGhlIG1ldGFkYXRhX2RzdCBpcyBmcmVl
ZCB3aGlsZSB0aGUgc2tiIHN0aWxsIHBvaW50cyBhdA0KPiA+IGl0LiBXaGVuIHRoZSBza2IgaXMg
bGF0ZXIgZnJlZWQsIGRzdF9yZWxlYXNlKCkgb3BlcmF0ZXMgb24gYWxyZWFkeS1mcmVlZA0KPiBt
ZW1vcnkuDQo+ID4NCj4gPiBSZXBsYWNlIG1ldGFkYXRhX2RzdF9mcmVlKCkgd2l0aCBkc3RfcmVs
ZWFzZSgpIHNvIHRoZSBtZXRhZGF0YV9kc3QgaXMNCj4gPiBmcmVlZCBvbmx5IGFmdGVyIHRoZSBs
YXN0IHJlZmVyZW5jZSBpcyBkcm9wcGVkLiBUaGUgZHN0IHN1YnN5c3RlbQ0KPiA+IGZyZWVzIG1l
dGFkYXRhX2RzdCBvYmplY3RzIGZyb20gZHN0X2Rlc3Ryb3koKSBvbmNlIHRoZSByZWZjb3VudA0K
PiA+IHJlYWNoZXMgemVybyAoRFNUX01FVEFEQVRBIGlzIHNldCBieSBtZXRhZGF0YV9kc3RfYWxs
b2MoKSkuDQo+ID4NCj4gPiBTYW1lIGNsYXNzIG9mIGJ1ZyBhbmQgZml4IGFzIGNvbW1pdCBjMzJi
MjZhYWEyZjkgKCJuZXRmaWx0ZXI6DQo+ID4gbmZ0X3R1bm5lbDogZml4IHVzZS1hZnRlci1mcmVl
IG9uIG9iamVjdCBkZXN0cm95IikuDQo+ID4NCj4gPiBGaXhlczogMWExYzQwZGYyZTgwICgiaWNl
OiBzZXQgYW5kIHJlbGVhc2Ugc3dpdGNoZGV2IGVudmlyb25tZW50IikNCj4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IERvcnVrIFRhbiBPenR1cmsgPGRv
cnVrQDBzZWMuYWk+DQo+ID4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVs
Lm9yZz4NCj4gDQo+IFJldmlld2VkLWJ5OiBNYXJjaW4gU3p5Y2lrIDxtYXJjaW4uc3p5Y2lrQGxp
bnV4LmludGVsLmNvbT4NCj4gDQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4gIC0gQ29ycmVjdCB0aGUg
Rml4ZXM6IHRhZyB0byAxYTFjNDBkZjJlODAgKCJpY2U6IHNldCBhbmQgcmVsZWFzZQ0KPiA+ICAg
IHN3aXRjaGRldiBlbnZpcm9ubWVudCIpOyB0aGUgcHJldmlvdXNseSBjaXRlZCBmZmYyOTJiNDdh
YzEgb25seSBtb3ZlZA0KPiA+ICAgIHRoZSBhZmZlY3RlZCBjb2RlIHJhdGhlciB0aGFuIGludHJv
ZHVjaW5nIHRoZSB1bmJhbGFuY2VkIGZyZWUsIGFuZCB0aGUNCj4gPiAgICBidWcgZGF0ZXMgYmFj
ayB0byB3aGVuIHN3aXRjaGRldiBzdXBwb3J0IHdhcyBhZGRlZCAoU2ltb24gSG9ybWFuKS4NCj4g
PiAgLSBBZGQgU2ltb24gSG9ybWFuJ3MgUmV2aWV3ZWQtYnkuIE5vIGZ1bmN0aW9uYWwgY2hhbmdl
Lg0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXN3aXRjaC5j
IHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX2Vzd2l0Y2guYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9l
c3dpdGNoLmMNCj4gPiBpbmRleCAyZTRmMDk2OTAzNWYuLjQxYjMwYTdjYTRhOSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2Vzd2l0Y2guYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXN3aXRjaC5jDQo+ID4g
QEAgLTk1LDcgKzk1LDcgQEAgaWNlX2Vzd2l0Y2hfcmVsZWFzZV9yZXByKHN0cnVjdCBpY2VfcGYg
KnBmLCBzdHJ1Y3QNCj4gaWNlX3JlcHIgKnJlcHIpDQo+ID4gIAkJcmV0dXJuOw0KPiA+DQo+ID4g
IAlpY2VfdnNpX3VwZGF0ZV9zZWN1cml0eSh2c2ksIGljZV92c2lfY3R4X3NldF9hbnRpc3Bvb2Yp
Ow0KPiA+IC0JbWV0YWRhdGFfZHN0X2ZyZWUocmVwci0+ZHN0KTsNCj4gPiArCWRzdF9yZWxlYXNl
KCZyZXByLT5kc3QtPmRzdCk7DQo+ID4gIAlyZXByLT5kc3QgPSBOVUxMOw0KPiA+ICAJaWNlX2Zs
dHJfYWRkX21hY19hbmRfYnJvYWRjYXN0KHZzaSwgcmVwci0+cGFyZW50X21hYywNCj4gPiAgCQkJ
CSAgICAgICBJQ0VfRldEX1RPX1ZTSSk7DQo+ID4gLS0NCj4gPiAyLjQzLjANCg0KDQpUZXN0ZWQt
Ynk6IFBhdHJ5ayBIb2xkYSA8cGF0cnlrLmhvbGRhQGludGVsLmNvbT7CoA0KDQoNCg==
