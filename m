Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE4457E58;
	Fri,  2 Oct 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950718; cv=fail; b=A+4p3C9LzoLit8VrXR+kVPQrKvxLYARTzbxefeAx7V2QIdZaallwul1UuX81OISBP+7hagUh2C9cmrZH6//chNsm4x4/+E67KuiYsDJheSFRKF2pnzeyUJC5AUCDnHSCFubbrt4jNikXxg/o88fkdstnTEA2RBu7iDH2La3xv9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950718; c=relaxed/simple;
	bh=RTGwjnze7gyceR1iwRkB7d5gTuw3Ycyy/m5lBLAVD8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y92E5/4tnkLn7Wkj5UUdYiIHI66fqg2tCpgdlKMpAc+0qqZVE7/Dg3u38wqkJAorIjvSgetF9qW95tIh8+B0sCwV+I0Ag+NQkcdPJHqnbwGZ8IGMw9fFbUV2N/9iboKxKij3TNYQBBplDyD95igsP+FEt93G6wKRxD7nifmmFlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvrdXu9X; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvrdXu9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790950717; x=1822486717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RTGwjnze7gyceR1iwRkB7d5gTuw3Ycyy/m5lBLAVD8c=;
  b=MvrdXu9X3+VgdjoBS9wCqGfGNPxS2VPT9/LgYnlh5RsQI/8yWhCgU/Qu
   AjwLLU04a0wsTM1gFXL0owjswSrbFSgoB0xmXO3EFhRq6mOHo4KpO/dvw
   Yki4qW2govZ5Zigo4ahSlOlzjpP489diiyKgWaAlEHXtttTRC/8SWhlRy
   o5z55WUFau3VysH07SlaYj/FcvdSsb7fxy2vCvte2m9DEgu1ml+ypj5Jj
   Hlz3yD4IhpkXqAN7ga8X2SMXx+ZgW6B2S3tVZV0lPrpe5kFaQTb4gEo2v
   xbmurXTStsaaabKJJq8OBN3Q5iDbT+kKK79pgvUDhKmex5gFY6GKWoCQj
   Q==;
X-CSE-ConnectionGUID: H4mV6hYEQS+NnD8bHnjEKA==
X-CSE-MsgGUID: uwHiBo7YSPWhtkccZ+58UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="91736836"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="91736836"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:18:36 -0700
X-CSE-ConnectionGUID: 6rFh5vyjSBWAorQ1S5gk/w==
X-CSE-MsgGUID: zjYw10FSRjGuwO0CoQSNog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275796633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:18:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:18:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 07:18:35 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZfZ/rgw2f4ZGzn3lsEAOz4t1o0RYEa6fmZRrRqqFZ9PtEEFeMTLEpQtNG0eEuAuHQqP6Q36KB6uqhktQ2G1kiYFstX0QTHpIrIw2BWX7Gn6esbgTSeWprWP0kJ5lB3VzdG0Ptx8kLvrRjPtDfs+lJT4zgzvhlkf+dq5jY7+iQVwIGeoGOkSYVxhbg6NDLGqIgGBnreq6eYgIpXtviNGGPCSLyK1C9zqSnrRdjlzDn7oYlLdjrrE01yGHN4sDRAlFmXbS43tw+HuAEQ6D3Kil+CQO7mCNTVFPM0r7dBU7VHz5zOZBMPiryn/GewHYMSVFCI/5o8F0h9awI7ULPtKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTGwjnze7gyceR1iwRkB7d5gTuw3Ycyy/m5lBLAVD8c=;
 b=eUtLr6hT+xdVvVNLuKLkIJs3GkBu6HsOQ/neWdhU1sMWmOBXH7RU2b1eYbD4mJsuD/7NS+jeL1m9u5FWLvS+p0JFjgF174CYfqW8rVe6rmI3vq8sVoXHeST8KI2cT5eS5qXk7krvmc6u+5HkMBzBLfq0xDLPK+zWi9N5bqgcyVOO1Q21i9kuO9FR1L4MjOKw6xy8uVYQomUbCDcGowJwaLDoerPF0hVe28fXb384L21120+ZwA2uZZhH/tsOm+DhPakb5WAtsGTaLsIiDm6mJMlhsURyppq+F36ZDVxgxViErLs7p5MaOgEZ1jeuaZhN8izb10bKIwrMeb6fYpETvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB5946.namprd11.prod.outlook.com (2603:10b6:806:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 14:18:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:18:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michael Grzeschik <mgr@kernel.org>, Jijie Shao
	<shaojijie@huawei.com>, Denis Benato <benato.denis96@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2 1/3] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net v2 1/3] net: fealnx: fix teardown order in remove
Thread-Index: AQHdUnfRvKa0pR6FzEGasc/BsufUObbqTKqA
Date: Fri, 2 Oct 2026 14:18:32 +0000
Message-ID: <IA3PR11MB8986E19271B0742E2EDBA0CFE5892@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
 <20261002140954.261779-2-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261002140954.261779-2-r.zhambakiev@prosoftsystems.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB5946:EE_
x-ms-office365-filtering-correlation-id: ff67e573-782b-44a1-56b7-08df209009e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|38070700021|56012099006|10067099003|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: +MRN78wZEp5Y+CCen6To1vlqSbhWcyuILWyFrfDiI+tbBo7zqSuLfpodg2ZEMXEP0DuQtyMl6RlQYY0dxUNHRxJ9jC5t/7In2o/lLFlZeCfZCz4gRX0h5tyO9g4hxy4fAOF32GBqSf6iVz8ZCaMN5+EXp5pNlLnotV8SppME970v0CYE1rk3syLuZzgPEP5smndYTEjh3TXWh+qJ/BVR0Xty8UkQjJJed7PWUwDy06UnQYt5IqacvWdr5PfLoNzFLEEGB9IPPFnnFtlbgnjrHpqFrFxzDSzagiV0XLRm6fV2P4oIZVS1wV/dpYvwrvcE/t8IpNKGd7hjTTm8s82VFiS4KJRPR1Q7rf+2J+6FfnUAkJopdL7RyLzOgevf4GuKxu078UMk04BeByvfnNgtytQE6ya1YqUcNJM1OQSJZ4ER4NRaONFCQn6mCzKYmej2Osmy+imzY2IS7V/r6pkzgCHdbcyLGzg5AjfKhGHemGhJjI6vqCbRgnPC4/q+c3y5lH6zGbCaLNcQig4+ddo14m26yLpJB8L74ii6M1m9BtFnnUm5T/fZ7oNyUzGe9ZyxfI2QuFIh1Bt23Pxn93k+NAcZz7vOn+b9PdeV59F6aDTOtrMhN+KMlwQatglamD7ZyxtXSi8l4zit5bulyZlFoFIA4mNhErRIxwteNjmIL5qdtgZmciysT8brXRLKLWEGoTwnN0hI9aAu6vGYLuA9gSQ6KhpvpOzGGgIk3dXmDHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDh5NUpzTnZuNDZkcDVLeUwvdzZtZ1hjeGN3U3B5T2xRL2JRMXVGWENOSzVH?=
 =?utf-8?B?M205ajF2MW83Wkk3YTNZOGV3U0s5KzNneWlnb1ZEUlNidStqd016OEhwek94?=
 =?utf-8?B?SFNjUWVOR2laNUs3aG1jdkthVWdPbzIxVHZPNkhvd2hlN1QvRFdzVEJHaGhB?=
 =?utf-8?B?Z1ZXR1dEUFFDYlpjMTh5R0R4MGdjVG9ta3RqUnMyaTc4N3d0YWt2MDNFRk1x?=
 =?utf-8?B?MjdESWRtYVd4Q25vdmxyRkJTV0hLZHdhUjliZXVNQ2VvT0ZNZjlGaFUyV2xI?=
 =?utf-8?B?bGxmZjVkWVRlN2I5OHR3TDFIQXNxK29hbndsd0cydGxDbXNWc3k2dE5qQUt0?=
 =?utf-8?B?S2tQTXdzSEhGeVU5TWhvaUozU0J0NTFVZzhpdkpTcEFSYmtOZnB5S0JMMFJr?=
 =?utf-8?B?eGhsa0NCeTFzd0VkSUQ0S040ZENaZEN0Q1Y2YS9mU211eDdoOHc0U3FIZUNr?=
 =?utf-8?B?Zy8wYm8xaFBRU3N3ek1vTXVGbjl2SWFFUUpERmVaRnExenBXWFk0U28vdGRm?=
 =?utf-8?B?RXFSbEJ6d2loWWVZT1dVVGpWZUhmUlU1RE0vNGhzM1JLUXlsTWk1U1YrdlMr?=
 =?utf-8?B?V1JnamRzR3JBT09haHAzYkw1blhUOTBZQzZZaFVUcTJ4aG5MS3pSSmo2MTJK?=
 =?utf-8?B?ajl4ZE1HdjdoU2RCYTc2eWV3MGdkQTRMeExBNG90SWF1WjBMMUFoTGVHVmdu?=
 =?utf-8?B?akpvak1SV2RTRlhpRnZ1Y3k4ODR5OE01ejhzL003L2UrUUQ5WStZRWxBS0JU?=
 =?utf-8?B?enJva1o2MFZtN1Y3bks4V1hyWWs3ZFp2K2JxQ29Kd0hqTldmOTVhT2JneWEr?=
 =?utf-8?B?RUVId25HR3dYdEt4cUpOSElZd3k1bmtva3QvOXM4RUQxWlErT1gzYXB3ckxD?=
 =?utf-8?B?ZSttVDVjSkZmNzFkd0pVcEovamF5eDV2bDd2SzVGbXRhVW8wdjBmMUxGSmVs?=
 =?utf-8?B?RkR1Y0dQVUIxVUVPWHptQVZBVVVCeWhTbkZ3bGwzWWg1MWxHdER2K3VRMXNZ?=
 =?utf-8?B?OUdUQysvK1hQQVh1U21zSkVJalBvSTU3d014ck9JQkU1RXEyVEhuSmNTd3l6?=
 =?utf-8?B?bVdqTGpGbFJBY3dPbEl1V1I2WFU5TXJ2ODk3OTdacC8yT3d1L2M4WlBaR1Nq?=
 =?utf-8?B?eVQ5Ly80VWZTekIxa1pja3VIK2JaQnlGYWp2VjhHM0FKSlArK3J4WDBHMVVZ?=
 =?utf-8?B?Z3l1cUtNQ2RTbVNMQWhQU3FoQy91azg5bVdpaHdjNzhpZm93WVVVTUJ0TWtt?=
 =?utf-8?B?b0h2N2M3bXBoK0V6dytNMVprQjFKV2puWVd6ajJ3d3hDRFFEbHJKcXJScmxl?=
 =?utf-8?B?WFZtd0FPSjZsajRTQ1EwWHBheHh3S0ZvV2FhRkZXdnVKYWpKbzVqSVB4Y3BK?=
 =?utf-8?B?OGI0a2FjQUJmQm9sNSt6VFdrc21PcExEN0lDeU1IRlVWZTVneEFJUDMxZXVB?=
 =?utf-8?B?OVVWTlI0K3dwK1I3cHpUSEFjK2t4TXZwZTI2eUV2amtlR3M1VGp4UFZqd0NS?=
 =?utf-8?B?UWdXMGdNTlNJN3RaTFNVWlJTbFIrSkdKeU10N2xKQmVHWUpxbENhQ1ljcUF4?=
 =?utf-8?B?Kyt2MUFPN0c5ZzVja1pta2RZcW1TYkZXZDBUVDdGMzByditFcnQxMnpvWWNC?=
 =?utf-8?B?ME0rRG9nemxBay8vcjhmODVhbXRnTXpxZk1BQ1FyL2w4SG1BU2FFRE5mMENj?=
 =?utf-8?B?eTFieTQwZnF2NXA2RENYYUMxanVMekNjSkd0SnNmQm9TWDBQUXNxS2FkZHVi?=
 =?utf-8?B?QlRXSk9ocDhtcnM3eTNzTU1YQ2g1dDBuemlJTUtYRVRweTZsRWN4K3M5OU9S?=
 =?utf-8?B?c0RDeUdTMUNHbW0wVzd4N0RYYmdERExpZlpNTXFPOEJ0ZVJ6WEdLRGtROFgv?=
 =?utf-8?B?TWYxUXBqU2Q5VjhjREVlQ1kyQWdkcm9rN1FYQWh3cFRPMEdvN1FvTzhpakxJ?=
 =?utf-8?B?RWVUaitsOWFveGdxa3Q1UFFSLzB4RDMvb0F4dVhhdEVuUmduK3hZV21JZnNo?=
 =?utf-8?B?Nmo2RnBBbDNILytDZXFpT3lqelBpTTRpSFdoVzVkMGNaTU9aVHpVQUZORm5M?=
 =?utf-8?B?cm5FT2Z6dHVVVWIvL09tSVU2UWFFWjFEbERwcFpoT1ByaHRjNUlZUWF5a1p4?=
 =?utf-8?B?Q0F2QjNPTCtuVlZlZThtUWw5U1J2bVZIeEpuVTdWcTVNNnk0RGhsdjZBaWFj?=
 =?utf-8?B?ZGZoa0EwaWp3RXN4dzBQbmlpekQ1YzFtTFRkU21vc1FLb080UXhxbXcwaTZE?=
 =?utf-8?B?TVRteG53QzFWVHVMS3A0c1p3V3dJVmlsUDBmamtXaEx0SHR3OUpudDE2WTM0?=
 =?utf-8?B?d2ZZT2FiMkxUQ2dqTjR0ZjN4WW5tZzhhSmlZdXhCbW1YZ3Z1Zm1LZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JnmLmQKNThnL0/oZhi7RYTPrV5CbZVzgKig3jKM2uzvtMTv+wVogWzzQSdB8J7f2w+Wpym5Z66QgVPcsdLtdJ3pbVqXR5rWxiqRDiPNeENpMhpQ5DHUUL1jHQjpvd4zm5C8MHZTiFv4/HaPnUJpd9OPXvzq1l8y96EMSmX/Wua2bnRWghKc7FsVw6jDtWlZMwUT4Oh0NXmjww/o/amSg7SSFr8qUpdgHkLSBVWnnizUApQtS3m3tRoCcGyTQ/FFPUItETS/HYRIi8BV6H15zoXGsRuGpe5MwAEpsx7cPaoyY1JbV1jpwU6jYBvaRFWwgkAfSQtlNBxx+R3sce5/Caw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff67e573-782b-44a1-56b7-08df209009e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 14:18:32.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kN0OI7+Hzqe1HE/jKZaRnPOZcDgwIjCrmHaq94T9Fao+30zsTGCKcPmveZvurVlYnfH8YF0nshL1RO3J8DmTSBiRivI8bFOCxJVUYFBpsh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5946
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog0JbQsNC80LHQsNC60LjQ
tdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00LjQvdC+0LLQuNGHIDxyLnpoYW1iYWtpZXZAcHJv
c29mdHN5c3RlbXMucnU+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyLCAyMDI2IDQ6MTAgUE0N
Cj4gVG86IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+DQo+IENjOiDQltCw0LzQ
sdCw0LrQuNC10LIg0KDQsNC00LjQuSDQoNC40LrQsNGA0LTQuNC90L7QstC40YcgPHIuemhhbWJh
a2lldkBwcm9zb2Z0c3lzdGVtcy5ydT47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5j
b20+OyBNaWNoYWVsIEdyemVzY2hpayA8bWdyQGtlcm5lbC5vcmc+OyBKaWppZSBTaGFvDQo+IDxz
aGFvamlqaWVAaHVhd2VpLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIu
bG9rdGlvbm92QGludGVsLmNvbT47IERlbmlzIEJlbmF0bw0KPiA8YmVuYXRvLmRlbmlzOTZAZ21h
aWwuY29tPjsgVXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1YikNCj4gPHUua2xlaW5l
LWtvZW5pZ0BiYXlsaWJyZS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbHZjLXByb2plY3RAbGludXh0ZXN0aW5nLm9yZzsNCj4g
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IHYyIDEvM10gbmV0
OiBmZWFsbng6IGZpeCB0ZWFyZG93biBvcmRlciBpbiByZW1vdmUNCj4gDQo+IEZyb206IFJhZGl5
IFpoYW1iYWtpZXYgPHIuemhhbWJha2lldkBwcm9zb2Z0c3lzdGVtcy5ydT4NCj4gDQo+IGZlYWxu
eF9yZW1vdmVfb25lKCkgZnJlZXMgdGhlIERNQSByaW5ncyBiZWZvcmUgdW5yZWdpc3RlcmluZyB0
aGUNCj4gbmV0ZGV2LCB3aGlsZSB0aGUgaW50ZXJmYWNlIG1heSBzdGlsbCBiZSB1cCwgd2hpY2gg
bGVhdmVzIGEgd2luZG93DQo+IHdoZXJlIGZyZWVkIG1lbW9yeSBjYW4gYmUgYWNjZXNzZWQuDQo+
IA0KPiBDYWxsIHVucmVnaXN0ZXJfbmV0ZGV2KCkgZmlyc3Qgc28gZGV2X2Nsb3NlKCkgc3RvcHMg
dGhlIFR4L1J4IGVuZ2luZXMsDQo+IGRlbGV0ZXMgdGhlIHRpbWVycywgYW5kIGZyZWVzIHRoZSBJ
UlEgYmVmb3JlIHRoZSByaW5ncyBhcmUgZnJlZWQuDQo+IA0KPiBGb3VuZCBieSBMaW51eCBWZXJp
ZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKQ0KPiANCj4gRml4ZXM6IDFkYTE3N2U0
YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiBTaWduZWQtb2ZmLWJ5OiBSYWRpeSBaaGFtYmFraWV2IDxyLnpoYW1iYWtpZXZAcHJvc29mdHN5
c3RlbXMucnU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZlYWxueC5jIGluZGV4IGJkYzM4YWFjNTg1MC4uNjgxOTRjOWVmMzMyDQo+
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KPiBAQCAtNjgyLDExICs2ODIsMTEgQEAgc3Rh
dGljIHZvaWQgZmVhbG54X3JlbW92ZV9vbmUoc3RydWN0IHBjaV9kZXYNCj4gKnBkZXYpDQo+ICAJ
aWYgKGRldikgew0KPiAgCQlzdHJ1Y3QgbmV0ZGV2X3ByaXZhdGUgKm5wID0gbmV0ZGV2X3ByaXYo
ZGV2KTsNCj4gDQo+ICsJCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQo+ICAJCWRtYV9mcmVlX2Nv
aGVyZW50KCZwZGV2LT5kZXYsIFRYX1RPVEFMX1NJWkUsIG5wLQ0KPiA+dHhfcmluZywNCj4gIAkJ
CQkgIG5wLT50eF9yaW5nX2RtYSk7DQo+ICAJCWRtYV9mcmVlX2NvaGVyZW50KCZwZGV2LT5kZXYs
IFJYX1RPVEFMX1NJWkUsIG5wLQ0KPiA+cnhfcmluZywNCj4gIAkJCQkgIG5wLT5yeF9yaW5nX2Rt
YSk7DQo+IC0JCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQo+ICAJCXBjaV9pb3VubWFwKHBkZXYs
IG5wLT5tZW0pOw0KPiAgCQlmcmVlX25ldGRldihkZXYpOw0KPiAgCQlwY2lfcmVsZWFzZV9yZWdp
b25zKHBkZXYpOw0KPiAtLQ0KPiAyLjUzLjANCg0KW1BBVENIIG5ldCB2MiAxLzNdIG5ldDogZmVh
bG54OiBmaXggdGVhcmRvd24gb3JkZXIgaW4gcmVtb3ZlDQo=
