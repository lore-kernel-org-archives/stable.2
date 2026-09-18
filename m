Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC438233933;
	Fri, 18 Sep 2026 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722443; cv=fail; b=A9V1ptpKgfvtmO1iDWXOdpZOGpyGQHWwdqSWPp1Hy0YiJOC61yWj/s0ZvFNKb4li9akMck+Z7GUKtzsuaXVq4IweCda1E0MyqpSeUhnrKY70ZPd8W3xAUsoeKrpbRYILYIQGILz5rQN6xcuHBKLMMNH+yKYQkHq3Y2FkshjK210=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722443; c=relaxed/simple;
	bh=/pPb5Ah5mG34hZAZUZ2xdJPZSsr0XgMrXuhHHVIOUT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EL8iwoXm1uc6WeB3Mk5hQ55WAWL1LPv5SQIxqIZPcn2MSRCPDQ/vqEXqo6Ai5jP/UHCLCDt7BOklNf9j4acnnCPl063TViRyDdwa3MdmZktTk+Ee9W2gFKGd5NJ0+9t9r+p6ajwdLoBzps3BwNC8wmKBk+Aek3wpOBAzYaRq/TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=cTqTfVV6; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=d6g+W0CD; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="cTqTfVV6";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="d6g+W0CD"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xdMM1292252;
	Fri, 18 Sep 2026 10:06:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=/pPb5Ah5mG34hZAZUZ2xdJPZSsr0XgMrXuhHHVIOUT4=; b=cTq
	TfVV6u0zuyBUyGvklWYhJabepf0k6OY0h5C1feSmlSJiGV0Vk2XmOS+AEoSXSZkt
	ORK9hpVyPnldxxVO29LDDa/VZYQeQuubh+SAfiuv3Q4S3l9RZFyn1f2j1+QoWzu0
	njZSCcyEqsvlAtCZmNb+EP0DZiklt2NEdC/LCtOZIWo49HvAibtL4YzObnFPNYsJ
	J7QirKpdLhz03fUBKnsXgxTUSVHZ5Zw1gO1JpJQzIsZLR7K7xE8VWi2jG28c1g4Q
	edBtImiVL9hPE/yX7wU8eH44GqKwE2GR4RAXKLGKBRh5MaGM+BMD4oQrcGnxiSM8
	/BdWpjHMct4EjKq+/pQ==
Received: from lo0p265cu003.outbound.protection.outlook.com (mail-uksouthazon11022141.outbound.protection.outlook.com [52.101.96.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtunepv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 10:06:59 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNaBHEbgaaRSWfYS1VkBdIo24GC3i2IhuRe/1Ygfgt0ROwdO0M3H6YDKdVgMvdku1y6GWD0sYfOXxghncONwomUTaX3GsKF6Rcpqq2XT1HRbvdjiS2n20/EneOzaeDSVlIK1sT4l/qouA5dp6VvjH9k7SJ4L1MMmcy9kLlVtGt8Ofd5CgL9B7VOH5S/y/FTt35uGw7Rj0dlv6B//4jvsJBFL6vItEf03nMltx8qEWxKFU8Bpi2FeWGt8ZUhbKhS95cSLpyQOWJ9fCkJHPifLw3vn62XxrTjqh0lIG6/qFhvXRhmdKkrGTuy1wUaCdomGUvL2SHxNGt6loJK3FhXWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pPb5Ah5mG34hZAZUZ2xdJPZSsr0XgMrXuhHHVIOUT4=;
 b=AhLpmQSStYDke7r0gZlnD56Rkoy8tPXNng1Lz8cazdDQFz3iPb08tdJnEHaxpXM7LeLA4kFMhwxpBFdSyj53hQEH+w3a0oVXvxk2y7JRX1es2ymaxAy3XsJwQeW0rJjAa1hYR3xut9vrCx7mcBISk3esy/6LYe6Jcf0Xv3WYai+xP9UeLOzhuZhXVmkw+0ngO7OC92Lt8rMNqi8Z7Zj6QuXd6n08L+O6JRV1fIxo+Lc2+gXNPmr/DYIy1pRMGWg8SUdM0c9SaafNAtMt7osY/zJ2xm8z90qBfA8Wc1x48npP5c+qt+Ahi1lt/N+gynxvfeVUG8I15UXPgAETkSLOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pPb5Ah5mG34hZAZUZ2xdJPZSsr0XgMrXuhHHVIOUT4=;
 b=d6g+W0CDAxF/Lh4eXVn9NW49lK6Sp2pFhBId7eY7AxdGupNBjeIfaBncfUTg9H2W1WbFc9+2aydRKSmta9dOALaOEZoLDYC2x4vf0HKo+FzAHimPPriVlb9dkDkdPq38koiopVVGcTqglf2rr+swZj5CBab52rFHQHjw3J2Deg0=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO4P265MB6998.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:06:52 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:06:52 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
        "airlied@gmail.com"
	<airlied@gmail.com>,
        "imagination@lists.freedesktop.org"
	<imagination@lists.freedesktop.org>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
        "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH 1/2] drm/imagination: Propagate map failures correctly
 from pvr_mmu_map_sgl()
Thread-Topic: [PATCH 1/2] drm/imagination: Propagate map failures correctly
 from pvr_mmu_map_sgl()
Thread-Index: AQHdOsFPDHrRjpSDx0KtxRvUMIq8dbbUJJKA
Date: Fri, 18 Sep 2026 09:06:51 +0000
Message-ID: <66928f4986a27c8e12c54eb46e5f2e458fc688cf.camel@imgtec.com>
References: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
	 <20260902-mmu_fix-v1-1-c55a23fb7cab@imgtec.com>
In-Reply-To: <20260902-mmu_fix-v1-1-c55a23fb7cab@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO4P265MB6998:EE_
x-ms-office365-filtering-correlation-id: a2c348ba-5e20-41e6-3fe8-08df15642de5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|6133799003|3023799007|10067099003|5023799004|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 APhBJPbvR65Vo8sSK9uSF2DcnCrOrUNkQ70+sBQO1ih65JnZZl8llwAv1kyZcpt6TPlpvh02D8mKa2avwsNV2rHUDSVZy6eKogDeTj1hUM/BvUtui0SSAog3GhxwUX4oZdWx9HDqEcMjW2G77fH5+hSgG8JYNH8tyDagOFsqju23JisI3KnQK9990VM4QhvbzI1+fjpXP+XKiUEqY0qCKN2nufqPkXJNz0dtM6apDC1ZFSDXCB41OrKtVLTPWs+Qel/0++DAbbE/FbiXsiEF85VHpAh7R1j9TUfvhvFuRwih/JP6yMk3aPIHBHlMO1LoI0OoldYTTjD+0Wh69I6S6/eu2kglv7MdG29qEVKjRPTTf8bIBWogBRgGolZZ+KJjf2Rokw8aqF1yxB6RsaQdrTpTEqyOs05gKYwHBGyyzekToK2phzI3xK2Oo7NfgDyB2PBq4LKq9E/6uv6HBntdO+fNWwQW+varigqkvi70ysJebEKDJ6jJuOm14kmWli2XmyBr1aNST10DJGO5zTD1Ws7NN9VQX4Lt0SH/reoUbALcJ+shFeQkVDWG1lLpmi9OvguNjoL6Mo/9LlAIwV/EVzEv1U+kI8F6ar8n43iiBU8+Hv5AHBT9vm5QXnOifD+a3TIGQDfCWLHNUArNDvrRbUGvJsso4CwyrJcwl3kQc9kR2BLRLaRYQNyF1Exg6zYI1QznxtNkbVZz33JwEsqBDgmWtf/37+SyaGLzH1SIZ4s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHRXRW81NEtNcExQMGFHMTg1YURIbkJXUFFnSGFkZEwrRjRoeWY5S1hkZmRq?=
 =?utf-8?B?V3M1NDJpeXRhbzgvYk1kekI4THpNbU1qck9IdE9qZCt2eE82dWFkME1MNkw3?=
 =?utf-8?B?RFpkT2dBblJiaE45Ym5yTU1NZjBCR2Q5d2huWmNwamQzbkVRTXZWV1Y1STMr?=
 =?utf-8?B?RnY2QlYzUk9sL3pxNVNUdmZZYWhoMHFYNmhCZWxnSWJ6YjJ3aXdjbFRObUxZ?=
 =?utf-8?B?TUU5SVRxQXZaUFVnOGl1Z2JleUlTT3JvM2NwRnVCQkNJSytOTGZRZ1U3Tzkx?=
 =?utf-8?B?dHlyTjduK1FhelFBOS84OUl3NmpQcXBnY2xjSlpSY1NCZzBzNENTcmdxMmsx?=
 =?utf-8?B?VURWdjhqMjIxK2owS2MvTFltQXk1QUNDTW1xNEpVZUhVQnFURFo5b3ZHVXN3?=
 =?utf-8?B?NlNPa21jUzNUWldJRG5ENE40YmVSZ3V1NWx0amRwalZnK1lLekpQU2MzcGU0?=
 =?utf-8?B?WVh0aUg4MHl4NTV6SEM2elFtYmJVZkMycDU1WUtObE9QTDU2MzZiWlgvdlBp?=
 =?utf-8?B?dUE1RkhvT3NGMVVnZWtjSzBVdzFJOWhkd2l1OHE3dmdnMWpuRFJoWk1aRmtL?=
 =?utf-8?B?UVBENW0yT01zdEFleHR2ckdNalowSFhFOTZ4emNPVnlaRzRtU1JmZlVoUFc3?=
 =?utf-8?B?MHovYTIzRi96d3VhdDJSbEZBeFhhc1lJNFkwcGZ4WGh5czJCSTdIYytseWdp?=
 =?utf-8?B?ZHFpY3ZWR2dmYzR4YndUR21BK1UyREkvWXRtQlpEdkd3djdHZytjSUx3WnlP?=
 =?utf-8?B?MGUvNy9ONzBRMDdVTHJLaXpEaE02NjJ1eVVpdG50VHpSa0lRY0VnUGZtNXlo?=
 =?utf-8?B?RW5KSTJacFBUR01Dblg1bnYzS2tjSUVhZDdJeDBRdGNIN0JDQ2FVUkszTzh4?=
 =?utf-8?B?MGF1UzZNVmpqeDRUTHEzcnRSS1dOQlNMYUpnUHh4WnI2cW5NeStsVDltVmNL?=
 =?utf-8?B?WXpjRENJYjlJalJISFU2Z095MUZZNW9scFZrOXd4TzJ1YWRONXFneDNBRW9k?=
 =?utf-8?B?dXJZRHZPNnBSd1U4Q0VibVlrK1l5UGJtbW1IWG0vME9vbGlNV3R6Z1h6TWpa?=
 =?utf-8?B?eDlyeStJd0d5V1RFbCtQWUo1bCsvaWVMVmJaR2lWUG5VYzkxclFUMFNMek4v?=
 =?utf-8?B?a01MeEwzYjdQL256bVpSemg5VU9PNjhxeXpQcG9SR0lrQkxCdGdQSFU2VXBH?=
 =?utf-8?B?cnBFRURoaC9nTzJXVm1PRmNrVWZoY3ZUWFN3NzQvc1hOSXVCaTZMM2xmWVNU?=
 =?utf-8?B?ZmM3U2ZBbUplRFh1M3Y1eUo4YTZhUWRHSmNWcTY3Y3FNcENuUmROaXZjdFg3?=
 =?utf-8?B?L1RZelo2OFVzZHN3UzdNeitaZ0UyNDZueVdrZkxGS0NFMzBybVdPYk9NY2Ex?=
 =?utf-8?B?elpFN092eS9tL2lXRW01OWhoc0tERG03bHY1SDJpRS9TTG9CVTg0QWM3MTdG?=
 =?utf-8?B?Vmp1bmNON00yTysreExyeGF4YnlLcFo2b2dRRVhxbHNxcFVQTkYzaEtZdmxC?=
 =?utf-8?B?WkZKRlBhRHRzMHpod0ozbVZKc0pDSjNPUjNsRHJoNjk1SW1EVGViNnlkNTVy?=
 =?utf-8?B?YkZyQ2hxYXJnNFpKa25QYkVUZFQvMExlcGNLOFRMdDE5bFFEQVNqbXcraEtL?=
 =?utf-8?B?NjNwVHgzNS95SDhKSC94YzV6YmxSYlhWL28yY29rVzE5amE3OXJvdG5ER3U3?=
 =?utf-8?B?WUM5THMySmV1b1NSOHBBVXBLeExtNW14Q3BhOGdIeWRCWUo5dmVQUzY1MFEr?=
 =?utf-8?B?dnM0RXpFMDYzaWtTM01zVkNsZGZFR05nWktPQ3lYSUF5a01BN0hWVmJlQlRt?=
 =?utf-8?B?NTIyWVByTk9wLzFGdkJ6ZnRkN2tPU3ViQmNDTDR4K0p6RFRiUE80a3ZyWUJD?=
 =?utf-8?B?c0lDWU1RVkNTUjAxUktka0FLVlJYY202cWdYaWNEc2VKT2w2eXpiRDV0cDJZ?=
 =?utf-8?B?S3hvN2xzbG5jMUllcW5VaFd5bjE0V3FCbHdoekN5Mk5NVDFaQklRTGk1ZEV2?=
 =?utf-8?B?YVhvRlp2R0xndFpWclMvOWF1RVJSOVEyYU5xTkZidStXRnZDQ3hpdmN1MVh5?=
 =?utf-8?B?eCt6WWZ4bzhxL0g3RWRocWtHUDdpdzZYb3ZxZ3JJcWFoZjN0RnBLWGJLVDR1?=
 =?utf-8?B?Y3JGbHVZSWl2akVKUW5WTDlhS0s3YW1Ra3YzY2hOQ3FqWHlJVjVodHM1SXg2?=
 =?utf-8?B?QjhoNHJuOUhRNzhZYklwaEg4bEdZOEgwemdQTVUwdjh6ZTRpbEdOK3RWUE1i?=
 =?utf-8?B?VTh1QS9iaFl0cVJnRXJVL3RhQnE4WDNlVDZqSjFFZnkxR3ZOeFUyV1hrOGZu?=
 =?utf-8?B?QXdnVDhDVnlRYVRYTnZtam5mWW02b0Q5VTFxS2F1ZWY2TkJCS01ZTWNHRTJv?=
 =?utf-8?Q?WFqAmHAkMlxxic9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE1287A1F4C56947A5467FD6DEF07D82@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0wb7TkNFveVcH/nrx5IaH+osEKlJbRVqSUdbammX1X5aaFQHOL12H9KxYXrqIDI3YMWY0sFEK7Jc9iOeSKsOAL3JxB8mqoavZqN6nZGYEaOHh5W+vSIqXJybAmx8kJA5h4ll3oTIArnTIBN1szbs+C381tpASiPDGMVV6imYUyxJkcAhHLkQr/mxNKqX22YZ/lpSbfLhPHW9q1qZLW4AgF47DXt9L9NeYzN1YObPYY5oOl8XP2MyU4pGkfird3/AoJU2/dZhdXm6K6jYtIXFy7coKaz1YXBR7h5c4W3m/nw4jl+Uvkxbxys2A0tjz0g++1bBC6FYWaL9YfRla+lCdg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c348ba-5e20-41e6-3fe8-08df15642de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 09:06:52.0594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtzmMOtOfqYc/3KNTW94D2LVP9rOSQxAykLtIlIubg4Jd9rRnDKNmZxaYzsXNUy0msofG4a26VKJ3w0B86Q2why9megrLA71azGiu/doBcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6998
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aacff33 cx=c_pps
 a=DaLHQDDaQ4tSWLhwDYBtgw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=K86C1l-dmHi3L74TS6IA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: f7vYpwJK2ATvhJu6QBaUE-gEvNjme-Gr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyNSBTYWx0ZWRfX6BQ+39DSVjp2
 WNBVBRd4iz07h0uKnl/I8Yv6cJBo+a6x+IAHFuU8A57nYrzCsqRC4IDeV/5thjuAKoDuG3/aqPt
 0UaX5Zxw2iUeH3g7VUGiWHB8yTwZLqZRFivdAEtfJRnB0Af62WUAWlJXl4O8YgDKoVBsC+o3458
 ODvFYgr9+8tSiq3bmYkm1SkdyT4Epx6tUURF8wOCrttV3lc0hNIkiVYuGURThFB0M/lZ0C3ECQw
 zr44B64bm8jZ9yDw6fi0c/Oijcikc3ZIZhJOBNbW2W1xfvpvIigHQYeVGQoa2QQv/yY6VNj9e9u
 wnc0ff7zheV0msjAt/3YAzAB4wIxcO2iGx8ReYqkNa15zwq2UJsVjYKEMZq4w6CMEr/3GkIMXbN
 jp6uh/dm1fyNVl74/6D/Jkh4RbZbjrSBx8UZw3Sc0C96BzEmkpDaQv1Cclanq0k29F1qHh3qD7z
 dPBgGGVATUQws8PB0OQ==
X-Proofpoint-GUID: f7vYpwJK2ATvhJu6QBaUE-gEvNjme-Gr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyNSBTYWx0ZWRfX6dFDYX62jgZd
 Nk2TDXBAN3YUETcTWU2kRFvV1OReAQkLZBG8WUmDBvGA8oC0ath5ZCBqM95uOdmkLK66YtakpDc
 5pCAF9P1PaZ6bUOnjILY7nwJSwYHdEQ=

SGkgQnJhamVzaCwNCg0KT24gV2VkLCAyMDI2LTA5LTAyIGF0IDE1OjI1ICswNTMwLCBCcmFqZXNo
IEd1cHRhIHdyb3RlOg0KPiBNYXAgZmFpbHVyZSBmcm9tIHB2cl9tbXVfbWFwX3NnbCgpIGludGVy
ZmFjZSB3YXMgbm90IHJldHVybmVkIGNvcnJlY3RseQ0KPiB0byBwdnJfbW11X21hcCgpIGludGVy
ZmFjZS4gVGhpcyByZXN1bHRlZCBpbiBwdnJfbW11X21hcCgpIGludGVyZmFjZSB0bw0KPiBjb250
aW51ZSBpbnN0ZWFkIG9mIHJldHVybmluZyBhbiBlcnJvciB0byBjYWxsZXIuDQo+IEZpeCBpdCBi
eSByZXR1cm5pbmcgYSBwcm9wZXIgZXJyb3IgY29kZSBmcm9tIHB2cl9tbXVfbWFwX3NnbCgpIGlu
dGVyZmFjZS4NCj4gDQo+IENhbGwgc3RhY2sgZm9yIGNyYXNoOg0KPiBbIDExNzkuMjg2MjM3XSBV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVh
bCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwMDgNCj4gWyAxMTc5LjI5NTA2N10gTWVtIGFib3J0IGlu
Zm86DQo+IFsgMTE3OS4yOTc4NzddICAgRVNSID0gMHgwMDAwMDAwMDk2MDAwMDA0DQo+IFsgMTE3
OS4zMDE2NTZdICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+
IFsgMTE3OS4zMDY5ODddICAgU0VUID0gMCwgRm5WID0gMA0KPiBbIDExNzkuMzEwMDQ4XSAgIEVB
ID0gMCwgUzFQVFcgPSAwDQo+IFsgMTE3OS4zMTMxOThdICAgRlNDID0gMHgwNDogbGV2ZWwgMCB0
cmFuc2xhdGlvbiBmYXVsdA0KPiBbIDExNzkuMzE4MDk2XSBEYXRhIGFib3J0IGluZm86DQo+IFsg
MTE3OS4zMjA5OTNdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNCwgSVNTMiA9IDB4MDAwMDAw
MDANCj4gWyAxMTc5LjMyNjQ4M10gICBDTSA9IDAsIFduUiA9IDAsIFRuRCA9IDAsIFRhZ0FjY2Vz
cyA9IDANCj4gWyAxMTc5LjMzMTU0Nl0gICBHQ1MgPSAwLCBPdmVybGF5ID0gMCwgRGlydHlCaXQg
PSAwLCBYcyA9IDANCj4gWyAxMTc5LjMzNjg5NV0gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgt
Yml0IFZBcywgcGdkcD0wMDAwMDAwMDk4MjJhMDAwDQo+IFsgMTE3OS4zNDM0MDJdIFswMDAwMDAw
MDAwMDAwMDA4XSBwZ2Q9MDAwMDAwMDAwMDAwMDAwMCwgcDRkPTAwMDAwMDAwMDAwMDAwMDANCj4g
WyAxMTc5LjM1MDI0M10gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAwMDQgWyMy
XSAgU01QDQo+IFsgMTE3OS4zNTU5MDhdIE1vZHVsZXMgbGlua2VkIGluOiBwb3dlcnZyIGdwdV9z
Y2hlZCBkcm1fc2htZW1faGVscGVyIGRybV9ncHV2bSBkcm1fZXhlYyB4aGNpX3BsYXRfaGNkIHho
Y2lfaGNkIGR3YzMgdXNiY29yZSB1c2JfY29tbW9uIHNuZF9zb2Nfc2ltcGxlX2NhcmQgc25kX3Nv
Y19zaW1wbGVfY2FyZF91dGlscyBkd2MzX2FtNjIgYXQyNCBzYTJ1bCBzaGE1MTIgbGlic2hhNTEy
IHNoYTI1NiBhdXRoZW5jIHNjaF9mcV9jb2RlbCBmdXNlIGRtX21vZCBpcHY2DQo+IFsgMTE3OS4z
Nzg5OTJdIENQVTogMSBVSUQ6IDEwMDAgUElEOiA2ODAgQ29tbTogZGVxcC12ayBUYWludGVkOiBH
ICAgICAgRCAgICAgICAgICAgICA2LjE3LjAgIzEgUFJFRU1QVA0KPiBbIDExNzkuMzg4MTIwXSBU
YWludGVkOiBbRF09RElFDQo+IFsgMTE3OS4zOTA5OTRdIEhhcmR3YXJlIG5hbWU6IFRleGFzIElu
c3RydW1lbnRzIEFNNjI1IFNLIChEVCkNCj4gWyAxMTc5LjM5NjQ2N10gcHN0YXRlOiAwMDAwMDAw
NSAobnpjdiBkYWlmIC1QQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMgQlRZUEU9LS0pDQo+IFsgMTE3
OS40MDM0MTVdIHBjIDogcHZyX21tdV9vcF9jb250ZXh0X3VubWFwX2N1cnJfcGFnZSsweDZjLzB4
MTM0IFtwb3dlcnZyXQ0KPiBbIDExNzkuNDEwMTQwXSBsciA6IHB2cl9tbXVfb3BfY29udGV4dF91
bm1hcF9jdXJyX3BhZ2UrMHg1OC8weDEzNCBbcG93ZXJ2cl0NCj4gWyAxMTc5LjQxNjg0OF0gc3Ag
OiBmZmZmODAwMDgzOWFiOGMwDQo+IFsgMTE3OS40MjAxNTNdIHgyOTogZmZmZjgwMDA4MzlhYjhj
MCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDEgeDI3OiAwMDAwMDAwMDhmMzg2MDAwDQo+IFsgMTE3OS40
MjcyODNdIHgyNjogZmZmZjAwMDAxNmQxZGY5OCB4MjU6IDAwMDAwMDAwMDAyNDcwMDAgeDI0OiAw
MDAwMDAwMDAwMDAwMWU2DQo+IFsgMTE3OS40MzQ0MTNdIHgyMzogMDAwMDAwMDAwMDAwMDAwMiB4
MjI6IDAwMDAwMDAwMDAwMGZmZmYgeDIxOiAwMDAwMDAwMDAwMDAwMjQ3DQo+IFsgMTE3OS40NDE1
NDBdIHgyMDogMDAwMDAwMDAwMDAwMDI0NSB4MTk6IGZmZmYwMDAwMTZkMWRmNjAgeDE4OiAwMDAw
MDAwMDAwMDAwMDAyDQo+IFsgMTE3OS40NDg2NjhdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6
IDAwMDAwMDAwMDAwMDAwMDAgeDE1OiAwMDAwMDAwMDAwMDAwMDAxDQo+IFsgMTE3OS40NTU3OTNd
IHgxNDogMDAwMDAwMDAwMDA2MDgxMCB4MTM6IGZmZmY4MDAwN2ZmZmZmZmYgeDEyOiBmZmZmMDAw
MDA0MTkwNDgwDQo+IFsgMTE3OS40NjI5MjFdIHgxMTogZmZmZjgwMDA4NTNmNzAwMCB4MTA6IGZm
ZmY4MDAwODExYWUwMDAgeDkgOiBmZmZmMDAwMDA0MTkwMGI4DQo+IFsgMTE3OS40NzAwNTFdIHg4
IDogMDAwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwOTkwYzQwMDEgeDYgOiAwMDAwMDAwMDAw
MDAwMDA3DQo+IFsgMTE3OS40NzcxNzddIHg1IDogZmZmZjAwMDAxNmQxZGY2MCB4NCA6IDAwMDAw
MDAwMDAwMDAwMDAgeDMgOiBmZmZmMDAwMDBhN2Q4MDAwDQo+IFsgMTE3OS40ODQzMDZdIHgyIDog
MDAwMDAwMDAwMDAwMDFmZiB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiAwMDAwMDAwMDAwMDAw
MDAwDQo+IFsgMTE3OS40OTE0MzNdIENhbGwgdHJhY2U6DQo+IFsgMTE3OS40OTM4NzJdICBwdnJf
bW11X29wX2NvbnRleHRfdW5tYXBfY3Vycl9wYWdlKzB4NmMvMHgxMzQgW3Bvd2VydnJdIChQKQ0K
PiBbIDExNzkuNTAwNTgyXSAgcHZyX21tdV9tYXArMHgzMWMvMHgzODggW3Bvd2VydnJdDQo+IFsg
MTE3OS41MDUwMjddICBwdnJfdm1fZ3B1dmFfbWFwKzB4NDAvMHg4OCBbcG93ZXJ2cl0NCj4gWyAx
MTc5LjUwOTczMl0gIF9fZHJtX2dwdXZtX3NtX21hcCsweDI1MC8weDQ0YyBbZHJtX2dwdXZtXQ0K
PiBbIDExNzkuNTE0OTUyXSAgZHJtX2dwdXZtX3NtX21hcCsweDQ4LzB4NWMgW2RybV9ncHV2bV0N
Cj4gWyAxMTc5LjUxOTgyMl0gIHB2cl92bV9iaW5kX29wX2V4ZWMrMHg2NC8weDcwIFtwb3dlcnZy
XQ0KPiBbIDExNzkuNTI0Nzg1XSAgcHZyX3ZtX21hcCsweDFmOC8weDJhOCBbcG93ZXJ2cl0NCj4g
WyAxMTc5LjUyOTE0Ml0gIHB2cl9pb2N0bF92bV9tYXArMHgxMmMvMHgxODggW3Bvd2VydnJdDQo+
IFsgMTE3OS41MzQwMThdICBkcm1faW9jdGxfa2VybmVsKzB4YjgvMHgxMjgNCj4gWyAxMTc5LjUz
Nzk0MV0gIGRybV9pb2N0bCsweDIxYy8weDRlYw0KPiBbIDExNzkuNTQxMzM3XSAgX19hcm02NF9z
eXNfaW9jdGwrMHhhYy8weDEwOA0KPiBbIDExNzkuNTQ1MzQ0XSAgaW52b2tlX3N5c2NhbGwrMHg0
NC8weDEwMA0KPiBbIDExNzkuNTQ5MDkxXSAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9wLjArMHg0
MC8weGUwDQo+IFsgMTE3OS41NTM3OTBdICBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KPiBbIDExNzku
NTU3MTA2XSAgZWwwX3N2YysweDM0LzB4ZjANCj4gWyAxMTc5LjU2MDE1OV0gIGVsMHRfNjRfc3lu
Y19oYW5kbGVyKzB4ZDAvMHhlNA0KPiBbIDExNzkuNTY0MzM0XSAgZWwwdF82NF9zeW5jKzB4MTk4
LzB4MTljDQo+IFsgMTE3OS41Njc5OTZdIENvZGU6IDU0MDAwMzAwIDM1MDAwMzYwIGY5NDAyMjYx
IDc5NDA5YTYyIChmOTQwMDQyMSkNCj4gWyAxMTc5LjU3NDA4MV0gLS0tWyBlbmQgdHJhY2UgMDAw
MDAwMDAwMDAwMDAwMCBdLS0tDQo+IA0KPiBGaXhlczogZmY1ZjY0M2RlMGJmICgiZHJtL2ltYWdp
bmF0aW9uOiBBZGQgR0VNIGFuZCBWTSByZWxhdGVkIGNvZGUiKQ0KDQpJJ2Qgc2F5IHRoaXMgc2hv
dWxkIGFsc28gaGF2ZSB0aGUgc3RhYmxlIHRhZyAodGhhdCBjb3VsZCBhbHNvIGJlIGFkZGVkIHdo
aWxlDQphcHBseWluZyB0aGUgcGF0Y2ggaWYgeW91IGZvcmdldCB0byBkbyBzbykuDQoNCj4gU2ln
bmVkLW9mZi1ieTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMgfCA1ICsrKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMNCj4gaW5kZXggM2NhYzQ4MmUxMDM0Li4x
NzVmMGJhNGQ5OTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfbW11LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0K
PiBAQCAtMTIsNiArMTIsNyBAQA0KPiAgI2luY2x1ZGUgInB2cl9yb2d1ZV9tbXVfZGVmcy5oIg0K
PiAgDQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9kcnYuaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJtX3By
aW50Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvYXRvbWljLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
Yml0b3BzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gQEAgLTI1NTMs
NyArMjU1NCw5IEBAIHB2cl9tbXVfbWFwX3NnbChzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICpv
cF9jdHgsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2dsLA0KPiAgDQo+ICBlcnJfZGVzdHJveV9wYWdl
czoNCj4gIAltZW1jcHkoJm9wX2N0eC0+Y3Vycl9wYWdlLCAmcHRyX2NvcHksIHNpemVvZihvcF9j
dHgtPmN1cnJfcGFnZSkpOw0KPiAtCWVyciA9IHB2cl9tbXVfb3BfY29udGV4dF91bm1hcF9jdXJy
X3BhZ2Uob3BfY3R4LCBwYWdlKTsNCj4gKwlpZiAocHZyX21tdV9vcF9jb250ZXh0X3VubWFwX2N1
cnJfcGFnZShvcF9jdHgsIHBhZ2UpKQ0KPiArCQlkcm1fZXJyKGZyb21fcHZyX2RldmljZShvcF9j
dHgtPm1tdV9jdHgtPnB2cl9kZXYpLCAiJXMgOiBGYWlsdXJlIGluIHVubWFwcGluZyBwYWdlc1xu
IiwNCg0Kbml0OiBDb3VsZCB5b3UgYnJlYWsgZG93biB0aGlzIGEgYml0IGUuZy4gYnkgbW92aW5n
IHRoZSBzdHJpbmcgb24gaXRzIG93biBsaW5lPw0KDQpZb3UgY2FuIHRoZW4gYWxzbyBhZGQgbXk6
DQoNClJldmlld2VkLWJ5OiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+
DQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiArCQkJX19mdW5jX18pOw0KPiAgDQo+ICAJcmV0dXJu
IGVycjsNCj4gIH0NCj4gDQoNCg==
