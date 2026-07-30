Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA23CBE74;
	Thu, 30 Jul 2026 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450258; cv=fail; b=V62Ygzf3VG56utw4l9udykIWjoLVqDn4URfaL/lttpcOs6kj/e/Il+Nlkuh09TGF8MN4aTzEF3qT7E0Tll/k6ssQh5EkALizcsGjSWTPxtodJbzrtq7nGFE8XPq5CINTas/KP3CVA25IJC3ybDMMWsMH3myU2shpxgLaXN5uUdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450258; c=relaxed/simple;
	bh=1VN+D3eplqgdO7V/cGkwv9EWm4KzRoF1p1sesyOvEI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IREfXNT3HeWEpnZMEr8h+xs53mQd6aiHGJutsRus6S8ySnmRI+pQrjO0gbkp1bMRsL7VVvFTX85E26Xi7OFwS9JRTDG4OxMSq10WPHL/GpmvbrK45mDKLULmz7lqv469IpdBcgk/qK+4zF87G0j6v3YlaTo/TuAEhGEt8TwEFLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=lAfXXFSP; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="lAfXXFSP"
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UM2ZEB3985219;
	Thu, 30 Jul 2026 22:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=1V
	N+D3eplqgdO7V/cGkwv9EWm4KzRoF1p1sesyOvEI4=; b=lAfXXFSPFZD0laL9HG
	E7Ot48BHT+34SY3FVmOE97d0+u7S9/m9UaoDOBgn5VwVSN1QCvJAcbybXaOUPkUI
	TBLjeyNN4B7Ndq1wDFHeuE3MiWY/zIxOXdOGsEYv48jo0/VTNI+xltNspokNavwg
	H59f/LLRJJhp/NxVDHEDyAR524pLiZqZtcNRqobL7e3/xXOH80THK8dIsG3O4wn5
	v55nbZO7J0uwbdT93IkjELUi8pWxfpl43dvNtbZrf9ftDubiCG/7s6Qy72n/zAzW
	BkZ7Q2ge+gk/csw5sql2yNdF/R0G+7EIQm73ZCA7yPMN/vG4LKnvQFStVtw5qfe/
	ZJmQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4fr9jfa11n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 22:23:54 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5A4E013062;
	Thu, 30 Jul 2026 22:23:53 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 30 Jul 2026 10:23:28 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 30 Jul 2026 10:23:28 -1200
Received: from DS2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 30 Jul
 2026 10:23:26 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5V+pQRbF+TH0dqmATndAOxQ5wTvLBtRzdPqJr6GUXkBjGfFcgBP3aexY3H9A2beDXELOGSK+p/AQuBcxu45XSUc2Gx6dLcd6Rw2DxcFgNV5OdwZQ5rTaGGGhdBAWtWTwa2oxVVe0Z6A+MlsDTiUzCL+LIu4ISM2SOT0UBe0Z6SWupY150mhTwOO+4MPkfzoM5VKv4ZZQlTdyG0UD0ZYoZXIPlZXayfGbUAAgn+X8le1v1csSX5cWZewXT/BNtOMcBJIdjqRfcwUb4Kh/8baCUJ8IDJ26exfUbxXNweDGCq45QPDW6wFDUv2OXwI3zz9exTq7Iz/ApQSfPW4wiF9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VN+D3eplqgdO7V/cGkwv9EWm4KzRoF1p1sesyOvEI4=;
 b=NjRHlzxSgeXhRK8ddztoDfa1CXuevEF7OP3wMl2HsJWomUWIhwNTReT+zHosbyAatSpmBRzFif/HS6KExlKnDggBFK2C7vwv7JcXxD1GeKVjNLb6LbZ3j4ZGxlq5+Cd1XnoiTTU0blBRdMnrUhNlYzd+tP5Y/AfxJDBZMNWrivc3LEzVFHJLERCBmI3P9vnxXUn4Ssr00F9IcPn1AA+ep28IM7CRT3Gj5EsJU1JeMvEzLWYiIBF/ii6Hvs40CokAQBGR3YBIgZIcdwJL7NcfSh65Nt7YPKH3Xjq47CtEnepH1qi9LD1aZtHnfdZ9aJi/brQJn4Dp7w8pZPlaimrAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DM4PR84MB1592.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 22:23:22 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 22:23:21 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "liusizhe5@huawei.com" <liusizhe5@huawei.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "yangyccccc@gmail.com"
	<yangyccccc@gmail.com>,
        "zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling
 and clean up trace start
Thread-Topic: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling
 and clean up trace start
Thread-Index: AQHdIHIH74SQCHrsnkSd0Ny7Cc8vXw==
Date: Thu, 30 Jul 2026 22:23:21 +0000
Message-ID: <20260730222259.67293-1-sanman.pradhan@hpe.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
 <d558a593-ca12-4237-a9b0-5f20441c9d52@huawei.com>
In-Reply-To: <d558a593-ca12-4237-a9b0-5f20441c9d52@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DM4PR84MB1592:EE_
x-ms-office365-filtering-correlation-id: 895ba393-9ea6-4d3f-9354-08deee892a36
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: HdYmwanuN5ezwD2Ys1vWMFO1J8d47+JC+7JsZ7o9k0B5WXps8djSr6zyI9GXMqVTvqIxfTQGFbeorXzn4yOk4h9V8g/OfxqpiqMh+C9DlAdUJMNObbEbCAkdKqZQcxu8w2vG8ZWjYyFzslISbXX6R1fvs0N8OyK0ExyEVFr1kS05UfBSUWKQoArV3ezQAx5yRHUo9H8mZoJFt8jmPVlB0sAI9BpyTuutyIQqPO3jJ8XFKHbXROF8AdO744t0zN/fv2h3P4t7CjZ6kUF7r9ayW4XJgIrj/ynIwY8LMLEDwSgAE2PUGCk6zGao8EgOFXt7hhlvaD4rmb90NZhDoQqKZOBMz+6DevCAmemKLXo6XpP8/md72/D96OCGa+VVFvzdjojKpSZ960rtv3ZdyEgcrm07kTpU9Z8coL6u0M50p46A6dKRsYFJk5bsVgZETwAH1aNjoBxIoOKbEScQNdEvwkVNpkNiotqm2pIN9/hcc+kXQIvX9wwP7LHWL59lF5MGTQhx2Bb+iCzP4Odqg32Sm51tCLNGW7bIEa/B9eu1Yd1YFBfcZ6nT+XIec4baQpmeKvOQ+4lFbVuKFqxxNTRC+87l3L5R6E79px31nZOslDJN5ZDKI2SZFqvGocxax+E2Wf9W/QZewrVryMTXHawv6d09Od2DLIoJN8FSVJ8Zzzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFhDVS9hbU51MkllOFFFckVsSnRYdkRwMnB2ZGxIZnM4bUVSbGVQQm9mT3F0?=
 =?utf-8?B?cHl4cFNMMVRxN3VsUTZNYWVUSEJaR1dnVGlVclRITjBzMnc0UDB3azN6KzI1?=
 =?utf-8?B?bUFrYlhxd25ncVUwSHgxeTBFck5uNjgrOERKaG9SaE5kVXRUMStRVHh2bkRY?=
 =?utf-8?B?eE9nQ25iVE5sTHBEbkxNa1NTVnRBOFlrSzR2aXR4RjlOSndRaU4rRTZwSnl1?=
 =?utf-8?B?RHJ4QW1pMmg0Q2JBOGhWdHhtZzhUZzNNSEovd0dSR3NENVJUVWF4d09NWHYz?=
 =?utf-8?B?T1lnOTB5dWZQbmFJZlp2N3Y5UmJweUY3VnBwOTNqOU1oa2wvdHlDUlZCUHhi?=
 =?utf-8?B?QkpXWDE0V0hmdWlubnRwamFvOW5sZ2Zab2sxN2pwSmwwdk5Sc2k0MHhMZWo0?=
 =?utf-8?B?bkViSVAwRzlJVFdoNmtBd0FUK0RtaTE5VlA0TzlxN3YvMXZaeThhb1NDZnVZ?=
 =?utf-8?B?MXNtMTdKd0gvQWpKVm1ZVDVQS285SDk4UGhDL0pGb0YrUm1tQ0F4UVc4TW5S?=
 =?utf-8?B?di9WWGYvNHVHQzQ4MkNPWGJqQ1VhR2ptWnZ2amdDSmZXaXJJOS8yQmNDcWpk?=
 =?utf-8?B?eVRlUWhIZS9ST0xleVlQQ0lLM2FEcGFBVDNQWHJ3TkFEa2dRRmlTSlUxTk1V?=
 =?utf-8?B?WEV4bUtOTlFmdDhXYzdOUTMwdkllRXdLbmtDWGJwNFpuVFlvdVNzUDlubHV0?=
 =?utf-8?B?dHdPYnlOdnhIeXo4a1ZwamxUK3Z4ZytJUm9DeXY4dStLcC9xWkpPVHhUV2JG?=
 =?utf-8?B?MTR0TEM0QkRvNSt5c3Vnei9SSXk3aVo5S09CRCswZHZrTjMzcEFiNUMrbUdI?=
 =?utf-8?B?dExyWVBwVU05U1VyS3M2RzNmZFFvQm54MnpaVWFhckREUE9OL0toK0xNeDZC?=
 =?utf-8?B?RXE4NFkxM05EM0N5ZW5Rc3ppSThWcjNkWHFEK3N2dFJGcTNsQWhGa2R3VFNL?=
 =?utf-8?B?M3V6Y2Z3aHpQSkRLckNIRFpKL3JlWlFQSCtLOHNGUmExVm14eUFHRldXaHVQ?=
 =?utf-8?B?Ymk5MDU1WWNsMlJOMkkrc2lKYU5MVUJud1FRd0xlV29zZWVRWkFSbTFjZ285?=
 =?utf-8?B?bEN4M09sLzFCYVM4dUVzYmVPS3c2Ny83T0s2ZjlPbE9DUXJGVlFLUzBLSmVU?=
 =?utf-8?B?QnhEbWNUM2ZQUTNnMXY4R1RlQWxITWFpemZaVVo0cEZ1bnVleFBUM0FZTlBE?=
 =?utf-8?B?SzI0RGFGRVkwTjdGVjFxRERCNENrUExzaERUSkMxMmxXRDdENFplN1l2WDVo?=
 =?utf-8?B?bjNDTUJuQzdqYS96WmRxYUN6TXFIZVpOb3Q2NVMwM0pFVGpNTEdmdGM0dld3?=
 =?utf-8?B?ZGZlbzZhTGlicUJTNDFFaUYxQjQ0OHo3Tk1qWGdVemRFUUJ5K3N6Z3d3UUhy?=
 =?utf-8?B?eFd0a0dpNmZqVVJPU2RoSTNqVG1laWphdUlDVVMrT291K1ZEbHFzVXJXMnMz?=
 =?utf-8?B?VWI0NHpuUHF6QXNnZ2cwUU1wdUtXTWN3eXRYT051dWpuKy9vQXRSc0wrY3VS?=
 =?utf-8?B?ZTBqRm82b3BYQUpwazlub1NQWnlzd3JTN0M3bm8ydHZUaDJqTlZ1Y3VuM3NO?=
 =?utf-8?B?TlJneHZxSSthZDRrMjFScUdYNFNFRS9SNUhGRUp3bU9NdDFUQUpQSmJnMDQ0?=
 =?utf-8?B?QkVWeVg5V2k1RVo2Sk1ybG1EY05nb2ZKOGxOZk00anJNTGQvQVVxUmk3RnFP?=
 =?utf-8?B?WXBtN084M1lCNkVlb1RYSjgzR0svZEd5QzlGMnZuNDZJMUQzenlRNEhLL3B2?=
 =?utf-8?B?a3BJbGJJR243OVFpWTRabTBvc0ZqNzg3bmVnRkE0Lyt5eEd0aWk2TjR5dk80?=
 =?utf-8?B?U0tEOVM2aUw1aW1aVTFUZTJzZkhUakQxd1Jieitqc3NJY2FkZkUyaW5ENWU5?=
 =?utf-8?B?Y1FiRmE0UnBkbXMrd29VV2NTVFZ1UmYvdUxkMCtvSVh6ZVg5MmpaOVZIWHpC?=
 =?utf-8?B?NWNDRWdDNkRDRUZFWG00ZFBIR3pQZ003bkFZRjBzQnc5WEg5Y3U1dTdIZUp6?=
 =?utf-8?B?VStNbHZxdnp1b1NIakRtTnYxdnJITlZuMm9aZC9vNjdVckR5am11V0FBOVNT?=
 =?utf-8?B?SnVVbEhMMzRyYlBLRFR0dFQ4UktNa0FENmtwL2I2cHlTTExXVmpzZFFGYyt2?=
 =?utf-8?B?NitCQzY3T0g2dTNwY2p0VDBPZ3JUUEM2dWQvU3FkbjdQRkhDL2cyMWhSL1hL?=
 =?utf-8?B?WVRJM0FmZHRsVUZ0SzZyNXIyalZGN1Jrc2FhY2ZSU0p4aFhSR0FScnZBVmlT?=
 =?utf-8?B?K1drWE9KYk5LMlZFdHVacmlCT2M1YVRmakJRd1hVTFZFV1Z3WVl1L05nTkpr?=
 =?utf-8?B?akxmTHluK3M1RVZ4MjlId1ZOWG1paTZqTC95SVpoQ2MyS0MxdHg5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m0Ns6yqVYdqjiIp8bIY1dVcZFXzlJVBdmCZERB28uL3jA821202Xq4a0rjSAbB/hBvtm1fFL3CHYRj5yR43fvrlgXUNMsPeGzT6mpnjVj7TP8ba8skAAHyUZtmNiTsv/Y89eIaN9T9Tvz+4AzTfThvGBE7JQZv0dN1dQ2ebDFCvEIQpkAgNOY9sXRvevebG1RLEwCuoX/hiwEic7LNtB4JHVYAnURmP+o1wEIGdrcBJxANCZNZg+4oInLf3ApnZAZmoSqokSh+oCaE6gKgK4T+gM86+kZ14XE9LhyywmIgOCPqdLsvogzNVCCe7/DMQLpOiTdDcSZTxnD8zfduBwyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 895ba393-9ea6-4d3f-9354-08deee892a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 22:23:21.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDfJf5d90MTdPTG+y8RnZIZOSBLIbviUj03VGucDAsD3+F0LkHKwgjBtLZuRHPmG4fUXGQ76HIVV+L17UsHmHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1592
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2MCBTYWx0ZWRfX1vq99QwOb+Of
 z+/D+h51aT41Vd+hktqV/vG/x7sA1rWAMbPrcZz3KzXOY7relrfXsLs9z5Yj4Y+tIQ2h7J6eDls
 pi6gMS7RlyywXupPSkoUiBhyPEWIsSGCvcjIdEPezNKjIhn1gmIMq/LtibRfoZ2hQ6efVsxdXWE
 0OvuRqhl3ufXeAfUB1FxQ1meBLl5fhBYXEKdalinA0f9ukmuWl8EdipNZ34jRi4RQV9DfCK0UER
 MwmKYvTaAvlXp3k4bHK3G+uu8i2dltrgr+u0bAG57ZW/6tU1OGFI+qr9PvvqRFVjDNXH+6Ysfen
 jjKe0dhXsNHHKFuKradR2j+1YZuTzh/PjCVyuY72mXWROJpkhZCjy0Fy6wnSoINe+Ahz0PKiHUe
 dtzfC3R7dTWGkycT6kmE1Nh20e5wr90HfeUST5SoQXmcVJ0Y5iKDJHce4lH3vacq8Z+NZP9Ioyf
 23GBDMf2LN1DD+dTBSA==
X-Authority-Analysis: v=2.4 cv=F4JnsKhN c=1 sm=1 tr=0 ts=6a6bcefa cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=i0EeH86SAAAA:8 a=OUXY8nFuAAAA:8
 a=WTdOyeCx9Ns28dWvA6cA:9 a=QEXdDO2ut3YA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: yRqmtOg-lcjObJBsPR7FMUU2U0mVRee8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2MCBTYWx0ZWRfX9vEjBn5uUAba
 jvKu1KiZwCpGRyDQRMnDN/Wi4n8j3NIZjwHK6lYNuJi6mcjaOxKJmGko9GPmN4jPpHorclsyCFg
 22zy2DpiHHbPjuGhunWL//Gob+ap/UE=
X-Proofpoint-GUID: jpM-JkqD45HLG_-ppAtM4E-oQdct51Rm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300160

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpIaSBhbGwsCgpHZW50
bGUgcGluZyBvbiB0aGlzIHYyIHNlcmllczoKCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDI2MDQxNDE3MjQ1MS4xNDMzMS0xLXNhbm1hbi5wcmFkaGFuQGhwZS5jb20vCiAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI2MDQxNzEzNDU1MC4wMDAwMDI3Y0BodWF3ZWkuY29t
LwogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA0MTQxNzI0NTEuMTQzMzEtMy1z
YW5tYW4ucHJhZGhhbkBocGUuY29tLwoKQm90aCBwYXRjaGVzIGhhdmUgYmVlbiByZXZpZXdlZCBh
bmQgSSBkb24ndCBiZWxpZXZlIHRoZXJlIGFyZSBhbnkKb3V0c3RhbmRpbmcgY29tbWVudHMuIENv
dWxkIHlvdSBsZXQgbWUga25vdyB0aGUgZXhwZWN0ZWQgcGF0aC90aW1lbGluZQpmb3IgbWVyZ2lu
ZyB0aGVzZSwgYW5kIHdoZXRoZXIgYW55dGhpbmcgZnVydGhlciBpcyBuZWVkZWQgZnJvbSBteSBz
aWRlPwoKVGhhbmsgeW91LgoKUmVnYXJkcywKU2FubWFuIFByYWRoYW4K
