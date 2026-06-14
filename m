Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747521AA797;
	Sun, 14 Jun 2026 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455782; cv=fail; b=eFQyhiafXeS9kiJ4ZXb+IHN0EMvNrcY2ZMBiYGTEd7znWFBWWIcJQbN9IitJK3LxJgGpNdpUeHFYRgHYjQX2wm2353Zy3tzR+yF2YBo+sU4rAC4UJpkpEhQnqJ2aVzvnuBpUpXXXEOnx5FtAFN6hfDtGDSu+xYsbg6UGNf33u4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455782; c=relaxed/simple;
	bh=g2/YKMA3xIyBMd2KalPy3I35swEk44iTUHPaDPDbATI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcnIwfRkM0VLB6Dssrawa18dK5khcSCvpvCVah9rpkdNGBcBCjxSgCEijcOAxe3QcDOIVWR4R+g/uODqFmemNtowy0jGedOgCyBcZiFr6XiHbDy2PjNr+yeY4P2VYTEheGDjQfZyd43vvvDZ7PzCR8hQwyZgo9+Go7oo08rxVm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=SMvLPTP4; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=AjCH8Qd+; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="SMvLPTP4";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="AjCH8Qd+"
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECb9ok568297;
	Sun, 14 Jun 2026 09:48:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=g2/YKMA3xIyBMd2KalPy3I35swEk44iTUHPaDPDbA
	TI=; b=SMvLPTP4if9GoLUZOP6qsrrDDv02MeU4dER2wEv0iDuH9TvBzgvQIn4km
	wsNQIRdFRvSubeX9sx1OE/3X88PUjHB+KgRefv3gGh5QOYHn3Ih3omit5K0S4Udf
	sOjnH2ZEFhCEE7bkWdz2I0/9fDkzk50uoZ/IEhYUXY7CFvj2gFXLGM3LGc7r3Jqo
	1EVDQRzBm5u+CCN0A3dZqRJHZelYv7pDHtw7/vRXGLkRnTMsfKIeIGV5szbnWvnI
	XoTmM21UjFt61AeTAK4nPLauIjuUQCoboRP7REC0kxxf7kdbRzIo4zCR3sWu3hxb
	GbxDCn+ZRhrPT80iE+9JnXRZpmf0A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020098.outbound.protection.outlook.com [52.101.61.98])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4es6qx9pc1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 09:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTyE6cUsnJaLFelJVTkBpvApJbyMr0EWX3HMD5IZrMGL2yTZ/OWQZ5XVFw4sKZ71kS7F4QysIFwnn4ePJ8ER+Qco1PQoDiuRSc+P3kZgSAySpLZ08YOPWNdeeKbhUx1ZFwUzNtOrlG5zRIkS9gXwMvnHHHb21Rx2mhfeARUjL+BV8nfU77pUVIyLOIgxLL+c+4GTYRiwV5GfcqWBDhk6qki8kwsIBguwC6DUYOzQae86ddOM5Xdf2gNpuJIKpTVBKQ7AdPfGJxnCLm5BvbdR8H1XafxKGfTm6QvoE2D1Y4BYikf2lpmr/hiFYGemMlanAZhgCIsE7TiKOU/wr0to9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2/YKMA3xIyBMd2KalPy3I35swEk44iTUHPaDPDbATI=;
 b=v4oCIWAnK+gU4vtTWFDg1B2OAn9ewQ3GzYstki2RYc8UVyqkFb3cYuSWAXTkVKv1D4g/t4rwgMQwGN5GgtBI8VR9yCWjYtqG73drAu5W/spKg3UJA7dAWpgyeLglIrN7bUi6D3EH/0G4zEqXEPxyaU7n+kLaSx68NFEb2vKkoQSOQhI6hAvMpLumQsSALwwxA7AFa6CojSdP8H7nsPOsxq5vWVA0aBC60evQTDwJlxCKYohp31CdjQ9AP0WxVPloJhQDUYrw9nJCj/qxh3OF1ztYRlq/ptuAUDujAU1Z+ivL46KHinfgckYSdTpLRMskXNu49S/89RriHnXXga/hKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2/YKMA3xIyBMd2KalPy3I35swEk44iTUHPaDPDbATI=;
 b=AjCH8Qd+toGDqp+cnjpAoemYYw6W3uWYhYdIRsst+zaNl5FwzIXYc/TrlLaHoofBQAjZ/6Kj1M9SSFBLSjInJ0+dmF7havBTwfefjKvGEJco3wdQiW0qWxwAg2YzRRO1uTJfPT53hwfmQSCtybHIEeXRWtjLapUswnjJi09GaqO6295SMws5+VjPgP/TFyzozEjcoQBaG/0NV3u5JOvsBhXLufTZLHU6eFQD4WmRME4i6feyIAC1JqM+fGogY0tz86qN1eIKJc8KbyzqF/FU5EeMTYWz9z5uVHAfyCovnGCiU09hbnWDTYVu1EXxfJlN5J9Poj6xPO5asUf7cRsKhQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BY5PR02MB6738.namprd02.prod.outlook.com
 (2603:10b6:a03:20e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Sun, 14 Jun
 2026 16:48:53 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.21.0113.013; Sun, 14 Jun 2026
 16:48:53 +0000
From: Jon Kohler <jon@nutanix.com>
To: Sasha Levin <sashal@kernel.org>
CC: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
	<pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan
 Kohler <jonmkohler@gmail.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, Chao
 Gao <chao.gao@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Gulshan Gabel <gulshan.gabel@nutanix.com>,
        Prerna Saxena
	<prerna.saxena@nutanix.com>
Subject: Re: [PATCH 6.18.y] KVM: VMX: Update SVI during runtime APICv
 activation
Thread-Topic: [PATCH 6.18.y] KVM: VMX: Update SVI during runtime APICv
 activation
Thread-Index: AQHc+qhVXDGI8D2KbEm48qfeO3Vz6rY8kucAgAGzGAA=
Date: Sun, 14 Jun 2026 16:48:52 +0000
Message-ID: <C091BC70-A13B-46F8-A732-BD060DFEB030@nutanix.com>
References: <20260612211003.2503400-1-jon@nutanix.com>
 <20260613143000.0001-1-sashal@kernel.org>
In-Reply-To: <20260613143000.0001-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|BY5PR02MB6738:EE_
x-ms-office365-filtering-correlation-id: c9b2ee3f-df90-4db4-ffec-08deca34d133
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|23010399003|10070799003|376014|1800799024|4143699003|22082099003|6133799003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 34j2b9+5cJP435fz3c3aFndaX8U/lMafa1RxaAras/rd4ryWrDQT/lyEHDYWsP9xORDHUlAFuFxA1dRG+y+73Yq8JllKAyU8jO6Inbtkq8haHatnEqQYE1dVstCqGZzdtclHDvEBiO9S9Po7MpakHvEoWXYZ63Of6K1cASChdp3SRPSzumgHAmLOZ7lD+dSZ8Q9rqKFRqSSLKznXIutbIbXhO09r91n7HwqxP5qWhOiQ6zlNDXPiBY9aPRnWeRQmUwDVa1A87d7oFXY38sTlnawyKwwyQ8Fr7LRJmterinE5hi0KpnjQOhWUUIqe+kntZ6dC0WBwf9biS9gmS+XMR6XnQ1wRqTE5FOWZv73CiNNwlUVZy3145H2QH/GeicsGURKcnBhk+mFQopaygj8OjyYCSceeL/VRHgkeslH6iMi+zCBomuJGJC/v/bBUProE8+BXdpS1Sc7jX8DvPd1oNfWiQGueSdsbPlgXXO3Zn/Jbq5f7GVIXlDsGBqB4L7o7KUU3cL9A716GIaQngjdLvaPIurAlEcEfkJZH2WazZal7+kIobvXMQt/VLd9/7w4lZDDg287mXCvBMO6/Ph29HEzrXQnXHRULfm1QLW+Iw1vGaOfNwNzzQxOhrCran1m4BVvDBbRnRnSwqAHuKL68BB24lFGTxpXE9JVGYMtWFgLySH1s4AjzQo4ypdLyVeqtsTadINzg+TFR+2PoTlT9bYmwkgJGH5lM3alzUuW8z9OVX2bSBepHx/mEwMX3cFeR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(10070799003)(376014)(1800799024)(4143699003)(22082099003)(6133799003)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UU1pdWx2cXdpbGh2SDI1MmROandNU04vR0ZyYTFWWDZxTFFvUXRMMExMY29E?=
 =?utf-8?B?dEx6R2szMTlZMXJScXArZjJSTlVYMUJra1p1SFRmcXF5S09BRktIOFVTdUxq?=
 =?utf-8?B?a2ZiMG1QR1ZKbUpiTmdkZnNheWs0bUdpL2ljVjBZNWZXMlg2NUdIMHBUdzRW?=
 =?utf-8?B?bURQK1dRRU5hZXZEbzdVSjExdFZjU1hTaE44WG1aMk85QXJLZ1BJeWlzNTZM?=
 =?utf-8?B?ejNWV0lUUS9BMkJwSm9JSncrR1RMRkl6dTZyZ0FmSzVac0xGb0hXQjVHUGNC?=
 =?utf-8?B?bTJCMmg3dEFROVVQZExMczZRNFBZeW8xdU9xcVhWZUdubjFFZnNqbExwQVVK?=
 =?utf-8?B?MXUwaHB0SUpxQ1dxU2IvU0JBeWxzOERJMERUMXdxTUFjTDFRTTJnWWNsaGhO?=
 =?utf-8?B?MENuZFozMWtHcmRmL3grcjhuNjkxY09zUXlnb1NzMWYxMURQLy8xTkJNNlNv?=
 =?utf-8?B?ZWZieUVXMGphdkZYTDRqeG9RVEtwSER4SXg2OTR4SU93eTZuazMzb3RMdkhl?=
 =?utf-8?B?aUdEMGJGblJHcEtzVVVGUjJBSDlvSWR6azZzUVl3amFIYitvQjU0bEpxUDRl?=
 =?utf-8?B?ZGRvMzhieU1Wci82bnZ2c0phRjBiL3lkamFrQ2xoRlR2TkpDUDFtLzI2N05q?=
 =?utf-8?B?bjkwWHI0SjZwME9ZSVJ5VjlJZVBjeVRNaFJXZVlEZGZ1M0RPbU8rZk4xRWc2?=
 =?utf-8?B?aUJsUi8zbThhM2JaZEc0MVZqWU1JejJSc3ZiM2Z2eHRMdGJBV3VZYmxjQVNw?=
 =?utf-8?B?SUd3bW9vcFNyUld0L1N6aUNRWWZKNHgvamt0QlM2b21VWHBkcmM4ZGhuazZD?=
 =?utf-8?B?WGVBWFNzYjBFdkRhQXJtZHU5c0dTVlZXR1lOeTJFdkdNb1VJUll5RnJmbDNv?=
 =?utf-8?B?cElHQjJNSCt2RlRmL1o3aDB6cjg4OXcrQ0l6M1hWWThTWjhCKzZhelR4ck9n?=
 =?utf-8?B?T0crNmFTTmR6cUd5cnN2Ukt6YVdicEk4bDl3MXNJUXFGZ1pGajFxdVdTQ0oz?=
 =?utf-8?B?Q21pSDUzK2FhM1psd0RLR3hvTnBWall4SHBrYXp6VXU2NkF5Z1ZxYTl0Y1Z0?=
 =?utf-8?B?K3ppeW13bWxZR2d2OXJGV0czOFpYR3ZkMmpUUHl2MGdIWEhNMm5QbDdxK2I4?=
 =?utf-8?B?RmV0ODdZTHFNQm1PSFZjaWNsaW5QQ3l3blhRNlhaaUxORDlwUDYrb2R4bFB6?=
 =?utf-8?B?c3ErTkVUWFFFM1RmdkQvSkhIWGtmSWxkUnNIbTI2dzBmajhWRGRXZFVZOVRr?=
 =?utf-8?B?Z2V6dUVKbmpBUTVCYTZVcTd2eW5GMHF2K290R2lVZE5ncTFPTU43dFRONjEv?=
 =?utf-8?B?cTVJdFVVU2gzYWJDOVdhZWF0U1FGdHZkV1pVTSt0eWZySWtiWlNZVWJGRTZi?=
 =?utf-8?B?ZURIejJzL3VoY3djcG9aTGt4RHlLSWNJcWZoQTVudnYxU1BtSWlEWjdKei92?=
 =?utf-8?B?RGtaa2dDREEyUWQ2VytGcGh4QlFadU8xTnFXYmxHNEpRcW56cWJKS01GOVFr?=
 =?utf-8?B?S0JXdzY4SkZ0L0dKcEk1MGNyTEMvcTJsUFBmUUs3ZEU0Tk00S0NadGdzNXEv?=
 =?utf-8?B?QmxyeTdtYktTMlJKMm5SY001MDd3eEhiYStNb1JOMUZDNXk0L0E2SUNEZU1a?=
 =?utf-8?B?TnJHcmxEQ0NWZ0JabkF6bVhPUlYzbUZZM3E2ZUg5Wjd5ZUhSd1UvWUFXcG9q?=
 =?utf-8?B?K21qY0RtTWRwZFhKUk1ScTB1Q0UyeEk5dlVEY2ZhWHJyemNrK1RyVjJxcmFN?=
 =?utf-8?B?dzF5NzVaa3lYN0gyTzE0bzEwL1pteHhuUTJGSE1aMGhJUGcyUkplTW9BSVpl?=
 =?utf-8?B?QlpQRHhNaFpCNHFUY3ZIZ2ZlajRsc0RDSFpZblpDcHdOSC84SkdnVHphT2Zh?=
 =?utf-8?B?MzdxLzhLMGhwWEhUZ2NTdUJpdHUwK3BTczhuYWhGdUlZZkxYZUhFMGpsTjZp?=
 =?utf-8?B?NjN2My9tc3VRVXF2N2t2dGkwbW1pQ3d2ZnFhcFI2alIzQ2tsdFQ4TDNYY0ZY?=
 =?utf-8?B?T0dNTll0WSs3TWRWOXBkUU1pOW1YWEZMLzNyR21RL0dsSjFrTWMrTG9sOWVE?=
 =?utf-8?B?Z1J2bVhrOGhyTDBtNzBzTVJZMmQrdy9PbVR3RDRXT2ZFWTBLa0s5Rk9kUUhB?=
 =?utf-8?B?WHovcGFNUlA4M3BVWjN0Tjd5dDRmRnBDeWtXdUdQYzBsMkRwNE1Lek1wdEU5?=
 =?utf-8?B?Nk42TE9kSzFLdEJmUW1sblRFWjJSREFYSHZGVW5nMTFTQll3WDYxS25IcnJW?=
 =?utf-8?B?cm1MQzl2MFBxRTNTeGMvQ2ZhMEJiUUt2SzhWWU5HMXNPWk50ODZBbkMvV05P?=
 =?utf-8?B?cmJCbzBRbnNXNnl0VVJMdlI1K1RmdWQzSlRqVFpTTllqdWVqV253UC9wOGtR?=
 =?utf-8?Q?/aDQRXfNl8ex2/AY/QZ754nRW/RHEHznEF6G/gQkemKF2?=
x-ms-exchange-antispam-messagedata-1: FvVIkJDQ8RoeisUTTckn/RCWRPwJ5W7J0zo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C3D0272A8A1324A9BEB6550208849F4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tBEeGG/jWTc0oibR7NU3XhHJWdslfbveJbaXM81bh/N8DihV+xKw+Pgf3TwQaEtVhVTN6aYfSTaTeB3oeYOvuWDk2jeeo1dr9HTzbjl0tUHLxJBKYQZZmbw2wKOMMtR0IyP1tyTmcnsY90SINOK1R9R9EFZCXgf4cBc/Pry68haGDETG0jEel0i2sbJ32jzXxHefPZ0rDz6Njif0vDojhyKsdxUQYxr2Lxp5xxidFbiPYNHFHJkPWHltz0sBusKWOY9SK9kDrpZDaXydGuSiqEIHyEn5XvrycFIScCusUeeACTTktKM4Nz35sCXY0+SReNcbkkvNT6oVy4p1/Zvrjg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b2ee3f-df90-4db4-ffec-08deca34d133
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2026 16:48:52.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZwpqAozIHsmcBzXg1GQoHEQZcN6UOqyz5UmnbTy0ybAKs64q2WZp/F5x1rsIsCSUs3jljf80KepIzCVsR2SRR7bmWyFose0BRQobRVcanw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6738
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDE3NiBTYWx0ZWRfX+57Y+veegGf3
 +NIfYpUMd1B+gLbmEppf83J/MuGu2CtFNWU2GZFp/C4CuibsEzVGngu1HwGLLpYMHLwUoAXOgGF
 C4oQ6dYc+f9AvR8NnEDV8rgm0KY6Bac=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDE3NiBTYWx0ZWRfX4MRigjJxg9fX
 ZldGeZe3J5WKUxmHr2RFKKZpsXdadzGY52j8ZPw+Xt32enujZ1My3FYAODNJKMzuHRC9AiFcHF6
 /6QY/6skcF2vvn0vrfiTwgOn/Th80tQnv50yB/4lgnWTnFusxX1pHzZ4w6Ylqqq+fVwwWIMvwhA
 sokLdMOeeuFzIAklH8MFXxvuDlsQ34WG5uKODN1zRAYkWIQgshRZRt7OXobLIcko/Zw14Doe7Vf
 dPVM9+vBWhrTelTCrRL3hVY8SWTgZoK3XxLl1bLovnrGVnxWdZh2ALOzmK9RFUg5lW9ywAlhlc2
 q5FLEL3llUSXn1+UfKAF8Qh8NpRXQaQwl9mhWNoWPZwOATGMiKmrOnl/1X/XOcDOn45ZqrSVgei
 OxPM/SUKyDKtfs9BmtOu2S8FL5TN5j733zFQGJI7JCmVA6RLJkZEzGVaWVAXUPGPjgz5dSyJZhc
 L8niuwYnuJm1JzbCn+w==
X-Authority-Analysis: v=2.4 cv=HZYkiCE8 c=1 sm=1 tr=0 ts=6a2edb78 cx=c_pps
 a=Qm58cps4sUx16Q1OvPHhHQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=-2tzEVm9hxSgDTqUeVIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ATH8xad3cI3HtNcQZFn1Ic3mcE7KPCS0
X-Proofpoint-GUID: ATH8xad3cI3HtNcQZFn1Ic3mcE7KPCS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVuIDEzLCAyMDI2LCBhdCAxMDo1MeKAr0FNLCBTYXNoYSBMZXZpbiA8c2FzaGFs
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKdW4gMTIsIDIwMjYgYXQgMDI6MTA6
MDFQTSAtMDcwMCwgSm9uIEtvaGxlciB3cm90ZToNCj4+IEZyb206IERvbmdsaSBaaGFuZyA8ZG9u
Z2xpLnpoYW5nQG9yYWNsZS5jb20+DQo+PiANCj4+IGNvbW1pdCBiMjg0OWJlYzkzNmJlNjQyYjU0
MjA4MDFmOTAyMzM3ZjI1MDc2NDhlIHVwc3RyZWFtLg0KPiANCj4gUXVldWVkIGZvciA2LjE4Lnks
IHRoYW5rcy4gKEFuZCB0aGFua3MgU2VhbiBmb3IgdGhlIGFjay4pDQo+IA0KPiAtLQ0KPiBUaGFu
a3MsDQo+IFNhc2hhDQoNCkJyaW5naW5nIGEgc2lkZSB0aHJlYWQgYmFjayBvbiBsaXN0LCBTYXNo
YSBpcyBnb2luZyB0byBxdWV1ZSB0aGlzDQpmb3IgNi4xMi55IGFzIHdlbGwgYmVjYXVzZSBpdCBh
cHBsaWVzIGNsZWFubHkgdGhlcmU7IGhvd2V2ZXIsIGl0DQpkb2VzIG5vdCBhcHBseSBjbGVhbmx5
IHRvIDYuNi55Lg0KDQpHdWxzaGFuIChDQ+KAmWQpIGRpZCBhbGwgdGhlIGdyZWF0IGludmVzdGln
YXRpb24gd29yayBvbiB0aGlzIChhbmQNCnRoZSBjb21taXQgbXNnIG5hcnJhdGl2ZSBvbiBteSBv
cmlnaW5hbCBlbWFpbCB3YXMgYWxsIGhpbSEpLCBzbw0KaGUncyBnb2luZyB0byBwaWNrIHVwIHRo
ZSA2LjYueSBiYWNrcG9ydCBoZXJlIGFzIHdl4oCZdmUgYWxyZWFkeQ0KYmFja3BvcnRlZC9zaGlw
cGVkIHRoYXQgdG8gb3VyIGludGVybmFsIDYuNi55IHByb2R1Y3Rpb24gYnJhbmNoLA0Kc28gdGhh
dCBzaG91bGQgYmUgc3RyYWlnaHQgZm9yd2FyZC4NCg0KSm9u
