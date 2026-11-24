Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795522384;
	b=Sq8NYtcsKgVdLCMuZHQjZRmvUYsmEXG+Uxa/y7pyYmqjNACleRzP0z0gp9qKgFUMPSUo
	 oySoe8IktLX/ZXX5taqqhnIHVqsseBUyXBG5lIL1F7RQrVAsA2TP5qlfK3aX5DCtJbOcD
	 EI+shvoLeKp8Ym395mJ/PDhNcJZvRz4GbV974wmG9qR7wT2raF1838g+U2oI9hRWf7w4Y
	 xHC1tZcgJWT5Kk3OoaSac+6ke3y5uVZnUrdIWaFO/HoNAs2cJxtfbovnWfoipU+tSzjLz
	 ck2LXKgl0ZGkFylFuywD4sT9JiEvWw4KjAheqcwLmKIR/pgPbeKyzKSJ7+vpIw9fsvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522384;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=IVJi2GmVXNEURpa7n0O3pFzbMFwrIIHaxeXCCKmjg98=;
	b=iTJm+NBYImDt+tuKPv3CjRv2j0zVqwUfEzTccJyBphK6jQbjdbO76iFyHXTp8RTnk0jG
	 jIprFcr2G7DtkSBkXivQFuWyolK69Df8FFiqLcYpJSKyrN4TR7mTh/KJ3IUutiGwc0mWP
	 BSuaHuLVce1xABstOldmPQk3StcQ6AgT2KBFJl4y2pmbxmf7rh1sJFRHX2f+aaUvCHq/U
	 f0+GhzO+o9ILCIIa1oKugwmDHinYpk6WwGTKpOu1P3gDTvUF2tDMlma6R4QRuc9wQcwYi
	 gCGIXNqa04PthwOgqlYh2j0e9LzpDxqiJDLabkhqngQt3YzlywG9QWzoCRs1D/ackng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cq8ksUQf;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gtpJOHHW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D4606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 358D4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cq8ksUQf;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gtpJOHHW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795522383; x=1827058383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IVJi2GmVXNEURpa7n0O3pFzbMFwrIIHaxeXCCKmjg98=;
  b=Cq8ksUQf5XGLHwzpyRLcBijqvmU7dEejMBm/2C8mn7dh8x2nAWKBldtF
   09cej0xNVO4kF2eH7EpP0RMsZ3KhTCFffB2x+Lf5R3x7HSEoeIPqzaQHK
   puNhUkNwAR7XffpWfSnQQXOiEkzJtNK3cLymS9+HWYkiwBTVdfmGddcC+
   6PZWDIJnQnNSWUY+Yr3OyrTs/naHfsbGS4tpgm13QZhK1msq9Nlz8BaCR
   wxX9+nLWW3AzI1vBmJCuLz6KHASJTwy3MVS90rLHaN++c7UYgYZzpZGCP
   Royh0kfSF7R8/qHNvfHDX6X4OT9W1EZmqiYfpGUqzqUGR/sDwe9VpAuzB
   g==;
X-CSE-ConnectionGUID: Uy2zPXTuS9SA/hfmVLHrBg==
X-CSE-MsgGUID: djaeluYPRgWE4WdtdP8dPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4206355"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4206355"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 04:13:02 -0800
X-CSE-ConnectionGUID: 7+iJZkohRouac2ZeViQK6w==
X-CSE-MsgGUID: 18e2wXQZReKW9jkXwoUGAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13565253"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 04:13:02 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 04:13:02 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 04:13:01 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 04:13:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/uHL/qhCxalQ1DGBnWLFlIWHvYg7uF65czhY8wFzJB7mKTmpOv21kdtYHOBx2g3yJ+k+NyQn4CeUDRGaqbHU2kjICArQYCZpK7IboBBdgOH7BkyLL5L/+a5pUiyh9/EICACy/4+kviTvAxjCUoSp6azxvDcuyUSIZO6dUb9+OGO1ubB80GQJjhOn2hB4y5eTvj0RpkIKANC8PBnJamkkr4hBC+6iwLeK7Wp85r5TEFczStk+Dx9dJFvVaJ/3JbwXCQRk6lAl8KJEUiPp+Z4p+ODobBaixZ345e7HqzDLeR6ZgutnMuQUSC9tZhTmKL4ivEGUvoQplojKwl/soE7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVJi2GmVXNEURpa7n0O3pFzbMFwrIIHaxeXCCKmjg98=;
 b=mvxlZ0xd1CiHOwwVFUNl5LGZBxkGqZ65q8/ndWuF34zifPcOzhzzwPXjyEXbIxxEXwxNUKe9HyQ6UlNK7shwLgOQKibEktETvWFS0Rkn2Xi6PYZ0gBhjC6oo2o3TdzolM3Vdqq+hf5rwTDvtl7yPse3fXS4yWdSLS2Z//8qDDro6Dc4h4kVcIYBddsEGCX6kO+yE1Lg7qv7dueTlphUWsWr+yrgmi4SY8vBNdm+ZQyFKjcMJwKOscUTNU0dx9rgC3RTkYlOIDFkkIFji0W8Hp2Z/4LQanu5MIu4yn5IY9uD6Lj/7pT4X9HQxFUOo/MXj8YOjVteitH5OOVXx01lh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVJi2GmVXNEURpa7n0O3pFzbMFwrIIHaxeXCCKmjg98=;
 b=gtpJOHHWTYcpg0dFjvejSnh3JVucGpSnWo4NTLUY0RsIvcMpBcarSShNcoZHsbCBmmRI5835pxnsutl0Z9EneRBjFwaQDt1otoSaxif6WsYZ6D1aBHa0SfCJOiN1ETNYsAhJVRmbpWaJEzwaeZX5opJE9++PnZ1pel+TrB+ygxE=
Received: from MW4PR11MB6570.namprd11.prod.outlook.com (2603:10b6:303:1e3::6)
 by DS6PR11MB533224.namprd11.prod.outlook.com (2603:10b6:8:46b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 12:12:59 +0000
Received: from MW4PR11MB6570.namprd11.prod.outlook.com
 ([fe80::63e8:6dc8:402b:36d1]) by MW4PR11MB6570.namprd11.prod.outlook.com
 ([fe80::63e8:6dc8:402b:36d1%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:12:59 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Deak, Imre" <imre.deak@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/pps: Don't steal VDD from another eDP port
 sharing the PPS
Thread-Topic: [PATCH] drm/i915/pps: Don't steal VDD from another eDP port
 sharing the PPS
Thread-Index: AQHdewgruvPcTaWADEuFN6JH1RJfq7c9I41g
Date: Tue, 24 Nov 2026 12:12:59 +0000
Message-ID: <MW4PR11MB65706BB25E1F163EA791D0FDEF442@MW4PR11MB6570.namprd11.prod.outlook.com>
References: <20261123050422.3130438-1-suraj.kandpal@intel.com>
In-Reply-To: <20261123050422.3130438-1-suraj.kandpal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6570:EE_|DS6PR11MB533224:EE_
x-ms-office365-filtering-correlation-id: 7fab7e2f-f834-460f-ea77-08df4a2447e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|261022075727099003|261026121527099003|56012099006|11063799006|261026140227099003|261021121427099003|10067099003|261028144727099003|261102123227099003|261022105027099003|261009223027099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: VF0BQoueFP+WsRLrLOqfrgW/iFdSjEE3P4mJAw5AM7BXyCJxmqGQ8ZkXuKFHIZWMPz/TnCctFlMFUDULvEpgDD9f7dej4noh7MmKCpu1v/Qo0tgg0GAM31hwiogbuCM+liFTTFRkmk9pY6zIz9ltIhyz8TXG9WtoVqSEbYwEMuZov/++bpxxgIe3k/AWwC7W0bJsSrzwr/t9m8n3J8Dz6q+rW5DZbG6Ft/CMtRFL4wPjucK4t6WTZbyCO7zJCw0Shwk42BtnYHcHsurT7tpuOY5x1pVeVqb5l9mGKIW7ILEuHV2QBHQLJrRyN8WvzFx2n1Ljal5mumZmggtECl+jsv2/lJByGfqYcT7OW0DnC3+cc7QzkNBhSmGEfXajDf8N3ey4Az7k07Q9MtIGG91bA/rMQj3QxQkxrHfm52p4ujXvQb5oIncLRNQbnG8bIGxHDzmrJ2uw+cb5R6c9GqBdQpwhd3PhprooVC7JdtHg48zzDLOWyuyahnTgbY03QJSATkpgcSfGM6x7phNODrYdEh3qdfWiwZL/a+M55sBs+R+kuHzKVp86aILqTZDNSwNDoFmeMVftqbBZQiqYtm6LccoL6aB3S7TyRg8NnrHwLz1gAlmoRz9SRRjVCDyMkJKrMOv09LX7Rrz67Pb/w/BRdACrelECM02apxDoO9O+tEs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6570.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(261022075727099003)(261026121527099003)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFQeFR2U0JlOHFYbXpOV2R4YUIzZW5jdUJpTTlmazZCM2o3OFdWaXVHbCtv?=
 =?utf-8?B?ZDY1N3U2UjNqRldXWlpxQXVwTU9keE1BK1oxaHFDMTVzOVczOVNDOXYwemQr?=
 =?utf-8?B?dklEUjJPdnlFRjhnY2JGWkh1TENVNG56REh6dit1TWhpWEE4OElrbSswcDdZ?=
 =?utf-8?B?T0JnQzRNOGFkbnZBRHlvTjZ6SWcxMUZRZUd2NVI2NFJ0QWU2UmVrOFBvSFVR?=
 =?utf-8?B?OHl1MEh6VHg0bWZoZzR1bitmRVlKOGt1L2lFMEdxdUIzbVk5YVhPWkkwcWtY?=
 =?utf-8?B?UWZlVGhwRVYveEZGUmpvaGxrWXF6VllDUXRoV2RDd1RXelU1K2l2UlBTbHFa?=
 =?utf-8?B?eG85Rkx6L2dLL05KbExOSVpYSm9aQmkwcXg2T0Z2ZUNaaTFzNHdSZ3lzWVlI?=
 =?utf-8?B?cWtvNTd3S1p3dFM2NWxldGtYZVhjRnRLNmpYY1UvbnZUckxWWSsvZENpaDNU?=
 =?utf-8?B?UjdOdDdvWnQyUmxOVWlteVUrbHErVWZzRTF6dXJUYmlkNWtqQnloVVl4dGZI?=
 =?utf-8?B?UVBhc25wZjllTkYrU2JhNG44YVF2Q1RNVE9QeVFoTDVkTktiYVdNQ3B1eGt5?=
 =?utf-8?B?Ty8rZkJLQmRiZUJKbmdGWDgwQUQwTHVrSU45WjNGRzE5ZXh3QWU3Qzl2anZD?=
 =?utf-8?B?ODdWU1ZDUWJUQy9SVHpwUUlUVFg4cmtMNUtvYm9pakhXVWZ6UCtBS3NTVWMr?=
 =?utf-8?B?c0tRU3JZbmIwYW1kUlR0V3IrM3JiSGR2K29HNi9QR3BUMjlFS2E4MXlONzN3?=
 =?utf-8?B?OENXcnRQMjBzVUk1WW4venR3OEN0VzJ3U1JzWUgyeklmWEdIN1VCY1pGY0k5?=
 =?utf-8?B?ZE41WGp4d3VFdkJQUXRjdUlHTU1pRFNyODZ0MEJhWWxCZkJsTzhkQVB1UWRH?=
 =?utf-8?B?QUdQTlY3ZFZYeUU5TGhsaEM3dTdYLzh0SWp6MFdlTFE4TEZ0NzQzOFkxOHB0?=
 =?utf-8?B?QUp5R3VXTkRmMGVzamtpN2d0UyttSlQrZHlKWGhBZ2hMSXNyendkVUhwZ2dG?=
 =?utf-8?B?UkJCbmF6TndsY1EwbmFhdXhYVENKbW5vTTRHMzNUQmxRWUVhSHVyazVRWlFJ?=
 =?utf-8?B?YngxY2d5Mkt0QWZ4YS9teU9TbnVmOFVpdkVLQ1VIemVaSlY3Zyt0Y3ZwS085?=
 =?utf-8?B?a1lRcWFSY01Oai9BdFk1YXYrWnBMMWlERHUzVTlrN25GSW5tMyt6SXNYcUI1?=
 =?utf-8?B?QVQ3bzErNVRWWnBIRncyZFQ1dmpEQjdSWjI2ME9lTThUNGRDb2lUZjkyQlBE?=
 =?utf-8?B?NTA2ZzQyY2wzTUpGMUxxRHZBdENydWdKTzB5TnEvR1kxK0xZVGZHVmt0bnlv?=
 =?utf-8?B?SjJEbzhCYWt4SjI3NjlkcCtya1c2bFlXWEJGNXVmK3RDelBWcmlLL3k2ZmZ4?=
 =?utf-8?B?L1Z0S2J2UjJIWElsaWZ5ZDZUWXpsRFBLa25WQ2NWZjlLbzZMaW9vNXI2K1Vp?=
 =?utf-8?B?VmptbWE5RVpqaXVnREUzaGRGOWs4N3BPTW9EOHhpTk1vM0YxdFF2ci9TbkJx?=
 =?utf-8?B?UFpaek5MQzRUbzk1NnFvcXRvY25LcmNHYWVudFNyMlBBanh5NGFVTnZHNUhh?=
 =?utf-8?B?TXpRakp1eFBYUnpsczl0N3hidUJhVHREM0psZFlRYUcxVDhDM1hkZUV6Rmhw?=
 =?utf-8?B?SjNyRWl2cm81SkdUQS9uMGRWa2xMMVZTaXVVL1pjSkpBdVJGa0kyaEYvZVNR?=
 =?utf-8?B?djlqczV1Y2FEdFpRTnY0U0RoVnh3d2xVeG95Unp0VnhaR0RQUTVCb0Zld1Q5?=
 =?utf-8?B?MW5kQmRjdENnNFRrOW1DZW1rQzZrcTRSc2JlZXNscEs5cjIwSFVmLzZuc1Zx?=
 =?utf-8?B?Y09sNzQ2QkFDQk1XdER2VkhTdHFPWGlOZ3dBR3NIVjhraTRyaGVGNU11YVp1?=
 =?utf-8?B?R0pFa2tPUU9rZjdCS0o1V2tVaEtPK2RRT0YvakNFMFJIVTYyMjVmcXVwSHUw?=
 =?utf-8?B?S0FRcG80YnR3bVRzL0JpNHpkQkN4eEtoSUFLMmRDUTdTN1ZZdGZONFpCU1Bo?=
 =?utf-8?B?dHFhSGowUVVyQ0NWU0lxUUNpRFJaNk1JQmJDc0RPMEJsN3ZDRW5aeWE1R3JN?=
 =?utf-8?B?aCtXb1BVK3FrOHg4ckwxWVpBOFRDb0wvUEZIYll5WGlpNDQ1NGdPUkVJK01Q?=
 =?utf-8?B?NTl4aEtsNmoyekdiY05CWFJPSlJkQmgzSy9ubmhWVWVldU9oeDh4TnVLVlQ4?=
 =?utf-8?B?RVEwbEgrM0E5RFVnVG1Cay9FUDhOb0RjdG81em5BWkJsdFhyZjFiMUwyZVBN?=
 =?utf-8?B?cEUwN0xrTkh4cFFrQlQyeDlnYUtwUzJjME9JdGN4N1RBMklreFRvNmlzZ3JG?=
 =?utf-8?B?RGhValcrdlNqcjZQMzFtNU5XbUhTQ09mY0ZIL0xFbFdwM2RFMXdLUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DtI1xtjUWeLoc649VmfvkoolM/m8j5JIWWoXV12lFOrHYsZzmrD5uqnd31lmdxvcvzkx7Pmvk785aogqLx9yDJsYF1hqqsPchhaeBF+47VchK78WXd86z7S/QzKw6bQUN7FvBWMzZW7gLLuGll1wvQ5nr0v/CiI6HTZkfJ9L21B4tEf57XXwY81Vxs0k7wNNKej1NTmc0MUcSupa58Mc+d5o7/1h4gO5dlM361AV2FrXjVxnN3wUhINFN5c/EZg2JLF/qSxjKNO5CUxqxiuChs2ZuJu9zAy3mKMEzaN0ZWhz+MKggNEr1T5mN/2xfXVooYCGHIX2GhqbBChqo4R3eA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6570.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fab7e2f-f834-460f-ea77-08df4a2447e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 12:12:59.5211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyiwREV4Gf3r9pynsIgigqAssfxYFe3qaK+5vz2KWQq1cpmUxSyGcTFn2NiQGPkC0xEypxBDl4c+8/BwtOuh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB533224
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYW5kcGFsLCBTdXJhaiA8c3Vy
YWoua2FuZHBhbEBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgMjMgTm92ZW1iZXIgMjAyNiA3
LjA0DQo+IFRvOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC14ZUBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERlYWssIEltcmUgPGltcmUuZGVha0BpbnRlbC5jb20+
OyBLYWhvbGEsIE1pa2EgPG1pa2Eua2Fob2xhQGludGVsLmNvbT47IEthbmRwYWwsIFN1cmFqIDxz
dXJhai5rYW5kcGFsQGludGVsLmNvbT47DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIXSBkcm0vaTkxNS9wcHM6IERvbid0IHN0ZWFsIFZERCBmcm9tIGFub3RoZXIg
ZURQIHBvcnQgc2hhcmluZyB0aGUgUFBTDQo+IA0KPiBTb21lIFZCVHMgZGVjbGFyZSBhbiB1bnBv
cHVsYXRlZCBlRFAgcG9ydCBuZXh0IHRvIHRoZSByZWFsIHBhbmVsIGFuZA0KPiBhc3NpZ24gYm90
aCB0aGUgc2FtZSBQUFMuIFRoZSBnaG9zdCBwb3J0IGFkb3B0cyB0aGUgVkREIGJpdCB0aGUgcmVh
bA0KPiBwb3J0IHR1cm5lZCBvbiwgYW5kIHdoZW4gaXRzIERQQ0QgcmVhZCBmYWlscyBpdCBjbGVh
cnMgRURQX0ZPUkNFX1ZERA0KPiB1bmRlcm5lYXRoIHRoZSByZWFsIHBvcnQuIFRoZSByZWFsIHBv
cnQncyBWREQgcmVmZXJlbmNlIGlzIHRoZW4gbmV2ZXINCj4gcmVsZWFzZWQsIGxlYWtpbmcgYW4g
QVVYIHBvd2VyIGRvbWFpbiByZWZlcmVuY2UgYW5kIGEgcnVudGltZSBQTQ0KPiB3YWtlbG9jazoN
Cj4gDQo+ICAgZHJtX1dBUk5fT04oaW50ZWxfZHAtPnBwcy52ZGRfd2FrZXJlZikNCj4gICBpOTE1
IHJhdy13YWtlcmVmcz0xIHdha2Vsb2Nrcz0xIG9uIGNsZWFudXANCj4gDQo+IERvbid0IGFkb3B0
IG9yIHR1cm4gb2ZmIFZERCBvd25lZCBieSBhbm90aGVyIGVEUCBwb3J0IG9uIHRoZSBzYW1lIFBQ
Uy4NCj4gDQo+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pOTE1
L2tlcm5lbC8tL3dvcmtfaXRlbXMvMTcyMzINCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcg
IyB2Ni4xNSsNCg0KSXMgdGhlcmUgYSBwYXRjaCB3aGljaCBpcyBmaXhlZCBieSB0aGlzIHBhdGNo
PyBUaGlzIHBhdGNoIGNvdWxkIGJlbmVmaXQgb2YgaGF2aW5nIEZpeGVzIHRhZyBhcyB3ZWxsLg0K
DQpPdGhlcndpc2UgTEdUTSwNCg0KUmV2aWV3ZWQtYnk6IE1pa2EgS2Fob2xhIDxtaWthLmthaG9s
YUBpbnRlbC5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogU3VyYWogS2FuZHBhbCA8c3VyYWoua2Fu
ZHBhbEBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wcHMuYyB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDM1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX3Bwcy5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wcHMuYw0KPiBpbmRleCA0NDJiMDA0OTFhODguLjY1M2I4YmY3ZWM2ZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wcHMuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bwcy5jDQo+IEBAIC01NzAsNiArNTcw
LDMwIEBAIHN0YXRpYyBib29sIGVkcF9oYXZlX3BhbmVsX3ZkZChzdHJ1Y3QgaW50ZWxfZHAgKmlu
dGVsX2RwKQ0KPiAgCXJldHVybiBpbnRlbF9kZV9yZWFkKGRpc3BsYXksIF9wcF9jdHJsX3JlZyhp
bnRlbF9kcCkpICYgRURQX0ZPUkNFX1ZERDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgYm9vbCBwcHNf
dmRkX293bmVkX2J5X290aGVyX3BvcnQoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4gK3sN
Cj4gKwlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkoaW50
ZWxfZHApOw0KPiArCXN0cnVjdCBpbnRlbF9lbmNvZGVyICplbmNvZGVyOw0KPiArDQo+ICsJbG9j
a2RlcF9hc3NlcnRfaGVsZCgmZGlzcGxheS0+cHBzLm11dGV4KTsNCj4gKw0KPiArCWlmIChkaXNw
bGF5LT5wbGF0Zm9ybS52YWxsZXl2aWV3IHx8IGRpc3BsYXktPnBsYXRmb3JtLmNoZXJyeXZpZXcp
DQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCWZvcl9lYWNoX2ludGVsX2RwKGRpc3BsYXkt
PmRybSwgZW5jb2Rlcikgew0KPiArCQlzdHJ1Y3QgaW50ZWxfZHAgKmRwID0gZW5jX3RvX2ludGVs
X2RwKGVuY29kZXIpOw0KPiArDQo+ICsJCWlmIChkcCA9PSBpbnRlbF9kcCB8fCBlbmNvZGVyLT50
eXBlICE9IElOVEVMX09VVFBVVF9FRFApDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQlpZiAo
ZHAtPnBwcy5wcHNfaWR4ID09IGludGVsX2RwLT5wcHMucHBzX2lkeCAmJg0KPiArCQkgICAgZHAt
PnBwcy52ZGRfd2FrZXJlZikNCj4gKwkJCXJldHVybiB0cnVlOw0KPiArCX0NCj4gKw0KPiArCXJl
dHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiAgdm9pZCBpbnRlbF9wcHNfY2hlY2tfcG93ZXJfdW5s
b2NrZWQoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4gIHsNCj4gIAlzdHJ1Y3QgaW50ZWxf
ZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkoaW50ZWxfZHApOw0KPiBAQCAtODM5
LDYgKzg2Myw5IEBAIHN0YXRpYyB2b2lkIGludGVsX3Bwc192ZGRfb2ZmX3N5bmNfdW5sb2NrZWQo
c3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4gIAlpZiAoIWVkcF9oYXZlX3BhbmVsX3ZkZChp
bnRlbF9kcCkpDQo+ICAJCXJldHVybjsNCj4gDQo+ICsJaWYgKCFpbnRlbF9kcC0+cHBzLnZkZF93
YWtlcmVmICYmIHBwc192ZGRfb3duZWRfYnlfb3RoZXJfcG9ydChpbnRlbF9kcCkpDQo+ICsJCXJl
dHVybjsNCj4gKw0KPiAgCWRybV9kYmdfa21zKGRpc3BsYXktPmRybSwgIltFTkNPREVSOiVkOiVz
XSAlcyB0dXJuaW5nIFZERCBvZmZcbiIsDQo+ICAJCSAgICBkaWdfcG9ydC0+YmFzZS5iYXNlLmJh
c2UuaWQsIGRpZ19wb3J0LT5iYXNlLmJhc2UubmFtZSwNCj4gIAkJICAgIHBwc19uYW1lKGludGVs
X2RwKSk7DQo+IEBAIC0xMzM0LDYgKzEzNjEsMTQgQEAgc3RhdGljIHZvaWQgcHBzX3ZkZF9pbml0
KHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApDQo+ICAJaWYgKCFlZHBfaGF2ZV9wYW5lbF92ZGQo
aW50ZWxfZHApKQ0KPiAgCQlyZXR1cm47DQo+IA0KPiArCWlmIChwcHNfdmRkX293bmVkX2J5X290
aGVyX3BvcnQoaW50ZWxfZHApKSB7DQo+ICsJCWRybV9kYmdfa21zKGRpc3BsYXktPmRybSwNCj4g
KwkJCSAgICAiW0VOQ09ERVI6JWQ6JXNdICVzIFZERCBvd25lZCBieSBhbm90aGVyIGVEUCBwb3J0
LCBub3QgYWRvcHRpbmcgaXRcbiIsDQo+ICsJCQkgICAgZGlnX3BvcnQtPmJhc2UuYmFzZS5iYXNl
LmlkLCBkaWdfcG9ydC0+YmFzZS5iYXNlLm5hbWUsDQo+ICsJCQkgICAgcHBzX25hbWUoaW50ZWxf
ZHApKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiAgCS8qDQo+ICAJICogVGhlIFZERCBi
aXQgbmVlZHMgYSBwb3dlciBkb21haW4gcmVmZXJlbmNlLCBzbyBpZiB0aGUgYml0IGlzDQo+ICAJ
ICogYWxyZWFkeSBlbmFibGVkIHdoZW4gd2UgYm9vdCBvciByZXN1bWUsIGdyYWIgdGhpcyByZWZl
cmVuY2UgYW5kDQo+IC0tDQo+IDIuMzQuMQ0KDQo=
