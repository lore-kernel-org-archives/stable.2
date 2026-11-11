Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794392953;
	b=wcuEQ85HAp/gU4KEx+hTIHC1K+vKP8T3sLtsW17KhcjBue3wrbBe/lZsUllrVE0hUG7T
	 unTMoyw8z9TurfI2sPr0/SLRyAPIkGee8DX+oBuxrtb3c06ZeWozt6lUPmWbjd+Rx5Aac
	 q49zQL8ouGV5OObaxXuPBtkPiPT5VUAgZ+K1G9N+zK/+AXRrJTspYGZF4l0/RclWdSiq2
	 wbWx1tmBKaLI6m5DyFkDFCN/gXe6+TpwcnO7LDoGnjeqAp9mjiNPZoE9l16xnSrdb27u8
	 7hz6t4GTeD5eZwdoA+tKBTlVFGXRdhZowc9kP8FdWM3qIahbHU+McYqR0xYvhzREM4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392953;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xf9lky5eBPz9aXazo667ZwNEmqrzN+Khyce9Wvpj1KA=;
	b=M8ACHe9dRv4Ty34akkWiGNe02jrDbhwEKY5qZDZgeVpb6SJxrZu9T6QYcsl4s2Zxldns
	 OO2/sFGxa2mtcZnncj35efg4DUT3KLi2xzr8iHp9iNA825sEp9SxO1wAozPLWmc2AG24Q
	 4KggmI8kBMztfGzzslGWMmA6BuaUGQxA5GUYi+uV594lQH3Fcf/bvMOTPm1jgnsRqjlLQ
	 8XMNcWtrbrbd1zUa1Whqu3DipT8ZxIIhWGmQdY+MYD1H5a+nmQmT+4Ni7nEFfNFPmnDj4
	 eD9KaWOgiQ9yD1wSWzCkoxeEMkTO3G+2iZBVB3mKSXNHqEDnoiVlBb0gQ/39HRajyQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=n87aETix;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NAjcoYPa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B13606A31C;
	Wed, 11 Nov 2026 10:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B13606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=n87aETix;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NAjcoYPa
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AB7Hsqt941834;
	Wed, 11 Nov 2026 04:29:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=xf9lky5eBPz9aXazo667ZwNEmqrzN+Khyce9Wvpj1
	KA=; b=n87aETixva6fEMNmif0o4erIfE0kVCZdomZDsZz8fbzEvf7BvoBYwPLU7
	vt9ezJbRLpdwuJ1HXAqAZHjaIz1BcE/c7imsL2ytvvFeKOhv/hB4mpcUnXeup743
	LPU6VaJ7OCiOB/29/wngLO4tb1bjBXUjB4igvBVun+gNHM5U5B5oGKPDNl/uto8h
	EDgOn77F2fYSRxV/vslxS6JPAYaAZAQHDXANA1JSUB3wp4IUsNxNYW2+Q5jPZrvg
	yrLDS9rOpIrqJDNxKBLzs228d1efOsIQJ+B7U48nOoilxpleAB2DDTDgGCicOmSG
	yn0G3+kEQGB9KN08GGAZV7ycZiSuw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hveygter6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 04:29:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ5sXfbQpFBIjOKqsJ3Xwm9LDQuTcSw13kDzCzOtHjgy7nN/ZHQCbilmGhOK8UFJkG8cTOhhU/gy3X8nLZDKVkM7C3V/5GFIiDfocZHwUZVYN4LL8r7xPzrnJPPTbDtBvjXlkCSbABdJT3CkDd1ZsqukfILd+hhwKx9FXlTTSHF861VwNHHxa7GQuuhGHKyaxWWbplKSeGNoGs8/Mo1sxA3aHvVWr7p81SAOZA4SBYFSXmWIDwH9CGLxQJeAn0m9HBuPCT4b7v7Qcm1kFncl0NDIrSsAa1/zg7SSB7K2d8mmKHZ5RAreO1KrFDAxFoZNU2q73tqbqdrmJEvS5h+yaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf9lky5eBPz9aXazo667ZwNEmqrzN+Khyce9Wvpj1KA=;
 b=N0wWUaf1ZxtYLBcT1bixGPPo8NuEjfzY20Ess+qI6JNtL6Mr8wDARSuKyEkWe/MWPlToYw4BUDamvOFioxciqPNCut0syxvH85YgngLQiq+5VSif3wFQPYI6RLz6UYbW6VL5kdVRd+VNiGdhrNnxPNGlVzn94OTEu0WIeveTpsmdrhWsGkA50ig1fJ6zy0bIayZ21TiwxOu3YzepEVNyCmlU/jQ2K7O96TSONTgtJt4FYl48eMdHkKQmQF6Z3RFqiWq5cz1HEKyscrQ5WWxWejRAZA4cPV17Z0MXx2LQpJfzJmfR1ui7+z6anYSlOtggNsIuXvDfhoJ8pj8tNgI9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf9lky5eBPz9aXazo667ZwNEmqrzN+Khyce9Wvpj1KA=;
 b=NAjcoYPatjBXh5BrewvdkY/aw94jKnTLh/Pc2RudHd/VY+PYAk7moU1arwKdK3IyUrC7SePdWMfrlltP2ZRG5YIHEe4SoijycbeimYuuK3AFIjQaAyYD1JaKAF5QR+uDBqnreoZAWaXvYzYYiqkMLWkOSRSyILXfk+AMRTvNGL4=
Received: from BN8PR10MB3652.namprd10.prod.outlook.com (2603:10b6:408:ba::10)
 by PH0PR10MB6959.namprd10.prod.outlook.com (2603:10b6:510:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 11 Nov
 2026 10:28:58 +0000
Received: from BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a]) by BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a%4]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 10:28:56 +0000
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: "Brnich, Brandon" <b-brnich@ti.com>,
        "mchehab@kernel.org"
	<mchehab@kernel.org>,
        "hverkuil@kernel.org" <hverkuil@kernel.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Willis, Kendall" <k-willis@ti.com>,
        "jai.luthra@ideasonboard.com"
	<jai.luthra@ideasonboard.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v8 2/4] media: imagination: e5010: Fix clk never enabled
 without CONFIG_PM
Thread-Topic: [PATCH v8 2/4] media: imagination: e5010: Fix clk never enabled
 without CONFIG_PM
Thread-Index: AQHdcTE8iNtxZ5UzREO/k5gxNTjC87corIWA
Date: Wed, 11 Nov 2026 10:28:56 +0000
Message-ID: <cca1d08d-0d3b-4082-81c7-9b4edc896beb@ti.com>
References: <20261110163247.48712-1-b-brnich@ti.com>
 <20261110163247.48712-3-b-brnich@ti.com>
In-Reply-To: <20261110163247.48712-3-b-brnich@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR10MB3652:EE_|PH0PR10MB6959:EE_
x-ms-office365-filtering-correlation-id: 48407e00-d328-45af-f2bf-08df3fde9773
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|10067099003|38070700021|4143699003|56012099006|261026121527099003|261021121427099003|261026140227099003|261102123227099003|261021135927099003|261021123027099003|261022075727099003|261022105027099003|261022115727099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info:
 T8qaIr0w1JsX9EB1s2AZ6IvXBi6NJUm3NwD+anZDepuLBFNeO0VFqbRqe7awxATUYTdCiXADqa9L5PtVbOkBTOqmyZ7l6J626DO+104Z/tUb72cp8JxF7+Gpb4dSvnHGKyHKxEnt4Wdmnd0fIjOXp7hJIr6AxRdmbDczRHPk7wHeIfV0tLizqcsuHc2M8RV7UYw1FpTT82z6q4Di0Ymq3vDaE4YV51ugFXvBIdjF2uW/2PWYTgEgEO+G2HF7XtVOGgOu0tqzr46S9hJaHs2KRe33ilBrG0kLdZTFTIEJkgF+aFwEU7FvDWUwR25RMl1Gfi+f7jZi4hSWm9V+8Yv+xd5UWsZNh4y9tzC90yeYXJhC3TvsPt858aOz2e7/Q3R17SercISfers07xHx44ZHoi5IXAeqHoLB7SW6cgXRgjex7kQhfcd40GiAq20MKv8WkynwmKnxqIou0IFdzgq7FJWCb++08CWbrYiWyoQE8EVL/6qGImM5pMo7gMZy7XZcn5JnuyzqAB2ZH+uP2fGBS03yl9OVE6mq1MY3SZdVdCW0JxAduH66F4Vd5mn92p/qH+2F2JUow9zVEOXXvuHIIOuJ+IlNRNXs0JLp3yMdQnHn9gWrRFKu0QcwyUdj/GgAeC3k3MRRr3Ac6hznaPFQag641vthXAq0BVcA0ZsR6KrjA5tJdzX75J/U1dfiDosfIZTQItFvpQn2P184sRF8nrxpIThFgwFKN80WM6pACpI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3652.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(261026140227099003)(261102123227099003)(261021135927099003)(261021123027099003)(261022075727099003)(261022105027099003)(261022115727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzBzbHphc3plMS9USXlnQTY3K29hQmVtVWp0UHdReFlYUGZYN2NpUi9ReWx6?=
 =?utf-8?B?L1J1RWhmYWVPZ3VBMUlJOFZMOSthNUZEVVBtWURlYlBva2lCMzE4VVAyL3Ft?=
 =?utf-8?B?WXRhY2NKbGowVWlaRnFjaGFyRDNNYk5rSlpUK0JJVGlzSE41dTI0bmVJMGs2?=
 =?utf-8?B?K0dBeUdwQWY2MTRLQlpWcDFCVUVBN21GTzlXdFpIN1RWVzAyZkxtUGRzbmpK?=
 =?utf-8?B?VUJrODA2ZTc5bEYxM2h5NVdlQ1BmTWNFVkQ1WmM3MnFkQ29yb0FLQTFydHRy?=
 =?utf-8?B?ODV0L3JkUTd3UXJuUHB5SHM2Zm92S2M0OTRwZGh1RUxRcWJVMUJxTUl2V3lv?=
 =?utf-8?B?QTJwVVg2S2ZPaDY4ejZwVjExdmVNRFRDb3V2dGVRemgzY3RFdUQ3ck1VdTZl?=
 =?utf-8?B?TEVUTmVaU2hDN2NKM3V4QlhCMTFBY0M2bGVXdkxPdTBHd3ByYWEwMTUrZEhF?=
 =?utf-8?B?L0tKY1Q2TjZGeHhQVWhEQ2RCaTN3NFczY1JRWkVoY28rSUcxeUZyVEE1bkcx?=
 =?utf-8?B?OW44UUdqVEFCZWNYMWR1bm5GUnZPK0VPTnYwdHRwZ2FTNXpMdGdMd3NiR3NW?=
 =?utf-8?B?MEZsZlVqZGRyNXlDSEpVZ083U2lHdWoxZkNVK0ZtVDc1MVhsVjN5U1loQUdU?=
 =?utf-8?B?ODNqc3hxK0FKeEZaakRuR1Brc3laMW9EYzlyK25QY3hGUlhLUXh2dnM3aTRv?=
 =?utf-8?B?WW1sWjZLV3pZaEY0L0ZWZlE2SXJnaHdldE9ITWFLS0VwZTVzeis1RGQ3M0RI?=
 =?utf-8?B?dUVCTXIwMlFCNWRkOVRMaktncld3aTd3dnpaWGlxdVhINUdtamsvc25rZ3F5?=
 =?utf-8?B?di90MlhHcGVpZ0o2NHJWeEluVHMxV1l0VE1GVlVnRG1ITy9pWitRMTlISmJr?=
 =?utf-8?B?REM5M3I2UHhLRTZiNkFKVU03WW9sQnk5YlloK09kRktFSXFjcEVqbnhYZDJK?=
 =?utf-8?B?eWZORHFSYzd6Q3AwYmJVV3R3WkJiVkFKd0IwR0RHNWhnczJNRUxKUEVlN0tn?=
 =?utf-8?B?RHJ2SXZqZm5FV1ZKbFdiZ1VIOG0vd0Nia3cxRjZDZ2hySFhrNzNxb3JFZERu?=
 =?utf-8?B?QlE0ZThUTXZ6NWN1VVd0MlZPZkhaNjBjSFpzN25sUTJ3S2dVN3pwN0NCSmdx?=
 =?utf-8?B?VUp3OVVqdUFCOFZ1VWw2MklLSmloQzNES2s2cGdKT3N2QVlXc3BIa3oxZHpy?=
 =?utf-8?B?cjFIMjk1aXRvaTYwU1pCckY3NzN1VHNEa3VvK0FIZFBFam5xS3NoY2IrekNk?=
 =?utf-8?B?RmNyd2drUnVkMXVydHdmSnZ2QjZaMnVMeHRpeWRWMnEvVWd0YzlzYTVuYlFN?=
 =?utf-8?B?SmxraGR5ZDkzRWVwZ3ZhV0M1QXFTV1UxK2pLdWVtZms3dklVamk4aUorM1dv?=
 =?utf-8?B?WE5CQnM0QnRuTTFtcWhucHpuQUFUYmd0YWJnc0M5VGwvcU9PWFN5dDFzbEVR?=
 =?utf-8?B?Qy8rTkVOVTdwN0lNTnZFRWJoSTVKc2J3a3RDcUJHQkd2dnVodnE3Z3BseUlJ?=
 =?utf-8?B?WERBMUJuSHFhbmtrRjMyZmhEeEN0VXJxMDB5d3dtb3RNTEdIUm5UTzVreXgz?=
 =?utf-8?B?VVZkeFRTZC8xU2NGUkdBYkdaVWlQVTg5M05iVlB1Tk1HaVpJTlhnQ0RvcGg5?=
 =?utf-8?B?eTh6c1N1aXQ5SmpPeDhzWWljQVp0K3NLbGNqUE0xV0k2WWxGL3p5V0VPeE1O?=
 =?utf-8?B?ZlNHYURXR2FSS21CN3VhcTBVaTh3aHdjckJESHF4SGxhOU1hanZrQ1l1d1hS?=
 =?utf-8?B?QW1lbmticmZUd0FBeHVONjFKWlBINkdwZHI4bkgvVCt1aVQvNXFidGFJS2xs?=
 =?utf-8?B?allkR0xoN0pNK1hCTWcwSU9TdUtxeWdNTi9PcTZ5RXBIMXg3clBscnJuNWt3?=
 =?utf-8?B?OVQvRDRSRUFsOC9oQlphMVJxM0ZZQW55Ri9VNmZUaURkNnczOVRZVlNjMUth?=
 =?utf-8?B?aUI2U1czSTZxSUZnelh1eDlMZ0E3NUk0bmJYY3FqNzh5TGVCTWxMNURQcUR3?=
 =?utf-8?B?YlJSdTVoVHdrbytBQis3dkFteWlIT1dDYVljNkQ4aVFTZDdGSi9UdTl5NUlz?=
 =?utf-8?B?SVZ5VE9Ka1VkMUg3M1QxVFNzai9nYjBlOFN2YkoyUGtyN0NJdmNJTHo4clg2?=
 =?utf-8?B?TjkwWVB3VVpuQTBNZFZGbzk5M2ZiQ09McjJXekhwQjNBK1FGNWltUjcraUtC?=
 =?utf-8?B?RjRtbjRyd1UxM3dTUXVZZUlseHRJem5QTWFyMFlEK3FFaHRNV0J6ZGNDR0pW?=
 =?utf-8?B?NHpndnZNTTI3bktBQlJXV2RZTTdnaGk0aW85b0kxUUxGQWt1MTZGWUJMUkxw?=
 =?utf-8?Q?B5kAcLTprj/keo6I5g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D48D6EA4AA6C5347A0F12CACE2E1FA27@namprd10.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked:
	ahGbnIkuoGsQaMpG6sS9z0deZcnhgWnyCATUrlnQUIWvjIx8c7ymHihv17X4LPfVDl42lbTj0gY8EHX+XV8AiJfIlt/wkEheJXKViygXRgpbvZjFgBalx5kjmlO6ewTdTDhq4aQNz4SsjtG7A8YsXN7SwwGFUcPnNm2+M9/r3rpYzh2sx5NdXrHU0jchFYDFcCN+0jw1tPksoZGwvI/vt9juLBjMGhJahIXwAFuwQvDpMB/01UQPg7o9zSqE/o5Vz1PDaEG4H18PfE6SiQaJ86tiLnDx34HjkGtdy5lIS20AJVk/U0RujpNk/ApLGTw21cNihCLmQQlYMmIaFHdN6g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3652.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48407e00-d328-45af-f2bf-08df3fde9773
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 10:28:56.5599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhfiKE8EbLLt7JhDnVPjcTstH6P0MxNXmxQew1ioxUwb7pDgwSi3E6RIggT+jFpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6959
X-Proofpoint-GUID: wuM_3UGDazNJtFhSqe49oKFjbHZynDwD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MSBTYWx0ZWRfXxRFzp4JWZTMJ
 KJDRJcPHFzRFdIM+EkT/h8cHoy1sWHbviU2uvfGGL3Bxm26vhtBM7E3KT0EG6QXSdIbL6neYJxA
 T+L8V4nBKxFsQSki3yukvecSN9mlpIw=
X-Proofpoint-ORIG-GUID: wuM_3UGDazNJtFhSqe49oKFjbHZynDwD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MSBTYWx0ZWRfX1aHzrIAC0QZ7
 ymf0IKVBTGdsXwfKYhW5Ku3xXSeSbuA2MW+ndlOZfkUU/cNOErT5rQIwt+jjGl7Xd6XnGx84jjy
 BEEfgU3yCLqUKLxfgPKAQS4hQh0k1DhgYJmM8+3kpvGviQko5IOD/burD3SqdXxWXilfFLIFvkU
 uKqAojS1TjmJPWtx4RRKDhiSdqrWk8tbF1AR188FCNDsc2KlzHXu+HKlgNzhi5dRy+kyjVXCaBQ
 0yFWYfutXgFNsnrqCTyIQRd5JNKoSfuZOXCwkrzrSb3aioeF3oqgqoL1EYDMZVBi8eAOsDKSTF3
 TARR7RHv5CyzpJPLAsN/3BJiC9bDOFyTeQs0Xq0GWCStkzef2t6K9SWIJFtGEnrU3P/BWoFfPj1
 hfyiRMfYt/gSgGA+1fFM5knXpYTUyHz4u+ZhRTz72Wz34K4LLcYVOPfpR4t2+aHnYv7iX1iCkAI
 Sd2gPXvrQH7lo4monPA==
X-Authority-Analysis: v=2.4 cv=FpaQbGrq c=1 sm=1 tr=0 ts=6af4436c cx=c_pps
 a=SPERBzkolnWMWDQhIvzwLw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=pbraIn_b0vyewlqHF90A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110041

SGksDQoNCk9uIDExLzEwLzIwMjYgMTA6MDIgUE0sIEJybmljaCwgQnJhbmRvbiB3cm90ZToNCj4g
Y2xrX3ByZXBhcmVfZW5hYmxlIGlzIG5vdCBjYWxsZWQgYW55d2hlcmUgdW5sZXNzIENPTkZJR19Q
TSBpcyBzZXQuIFRoaXMNCj4gbWVhbnMgd2l0aG91dCBDT05GSUdfUE0sIHRoZSBKUEVHIEVuY29k
ZXIgd2lsbCBub3QgZnVuY3Rpb24gcHJvcGVybHkuDQo+IA0KPiBBZGQgdGhpcyBjYWxsIGR1cmlu
ZyB0aGUgcHJvYmUgc2VxdWVuY2UgdG8gcHJvcGVybHkgY29uZmlndXJlIHRoZSBkZXZpY2UuDQo+
IElmIHZpZGVvX3JlZ2lzdHJhdGlvbiBmYWlscyBhZnRlciBjbGsgaXMgZW5hYmxlZCwgY2xrIHdv
dWxkIGJlIGxlZnQgb24uDQo+IE1ha2UgYSBsYWJlbCB0byBjb3ZlciB0aGlzIGNhc2UuDQo+IA0K
PiBVcGRhdGUgZTUwMTBfcmVtb3ZlIHRvIGVuc3VyZSB0aGF0IGNsb2NrIGlzIGdldHRpbmcgZGlz
YWJsZWQgaW4gdGhlIGNhc2UNCj4gd2hlcmUgZTUwMTAgd2FzIG5vdCBzdXNwZW5kZWQgd2hlbiBy
ZW1vdmUgZ2V0cyBjYWxsZWQuDQo+IA0KPiBGaXhlczogYTFlMjk0MDQ1ODg1ICgibWVkaWE6IGlt
YWdpbmF0aW9uOiBBZGQgRTUwMTAgSlBFRyBFbmNvZGVyIGRyaXZlciIpDQo+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEJyYW5kb24gQnJuaWNoIDxiLWJybmlj
aEB0aS5jb20+DQo+IC0tLQ0KPiAgLi4uL3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEwLWpwZWct
ZW5jLmMgICAgIHwgMjAgKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1qcGVnLWVuYy5jIGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1qcGVnLWVuYy5jDQo+IGluZGV4IDIzZDA2
NzA5YTY5MjkuLjE3ZWE2MTZmZjE3OTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vaW1hZ2luYXRpb24vZTUwMTAtanBlZy1lbmMuYw0KPiArKysgYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEwLWpwZWctZW5jLmMNCj4gQEAgLTExMDEsMTAgKzEx
MDEsMTggQEAgc3RhdGljIGludCBlNTAxMF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgDQo+ICAJcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gIA0KPiArCWlmICghcG1f
cnVudGltZV9lbmFibGVkKGRldikpIHsNCj4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGU1
MDEwLT5jbGspOw0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0
LCAiZmFpbGVkIHRvIGVuYWJsZSBjbG9ja1xuIik7DQo+ICsJCQlnb3RvIGZhaWxfYWZ0ZXJfdjRs
Ml9tMm1faW5pdDsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiAgCXJldCA9IHZpZGVvX3JlZ2lzdGVy
X2RldmljZShlNTAxMC0+dmRldiwgVkZMX1RZUEVfVklERU8sIDApOw0KPiAgCWlmIChyZXQpIHsN
Cj4gIAkJZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byByZWdpc3RlciB2aWRlbyBk
ZXZpY2VcbiIpOw0KPiAtCQlnb3RvIGZhaWxfYWZ0ZXJfdjRsMl9tMm1faW5pdDsNCj4gKwkJZ290
byBmYWlsX2FmdGVyX2Nsb2NrX2VuYWJsZTsNCj4gIAl9DQo+ICANCj4gIAl2NGwyX2luZm8oJmU1
MDEwLT52NGwyX2RldiwgIkRldmljZSByZWdpc3RlcmVkIGFzIC9kZXYvdmlkZW8lZFxuIiwNCj4g
QEAgLTExMTIsNiArMTEyMCwxMSBAQCBzdGF0aWMgaW50IGU1MDEwX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiArZmFpbF9hZnRl
cl9jbG9ja19lbmFibGU6DQo+ICsJaWYgKHBtX3J1bnRpbWVfZW5hYmxlZChkZXYpKQ0KPiArCQlw
bV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gKwllbHNlDQo+ICsJCWNsa19kaXNhYmxlX3VucHJl
cGFyZShlNTAxMC0+Y2xrKTsNCj4gIGZhaWxfYWZ0ZXJfdjRsMl9tMm1faW5pdDoNCj4gIAl2NGwy
X20ybV9yZWxlYXNlKGU1MDEwLT5tMm1fZGV2KTsNCj4gIGZhaWxfYWZ0ZXJfdjRsMl9yZWdpc3Rl
cjoNCj4gQEAgLTExMjUsMTAgKzExMzgsMTMgQEAgc3RhdGljIHZvaWQgZTUwMTBfcmVtb3ZlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGU1MDEwX2RldiAq
ZTUwMTAgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gIA0KPiAtCXBtX3J1bnRpbWVf
ZGlzYWJsZShlNTAxMC0+ZGV2KTsNCj4gIAl2aWRlb191bnJlZ2lzdGVyX2RldmljZShlNTAxMC0+
dmRldik7DQo+ICAJdjRsMl9tMm1fcmVsZWFzZShlNTAxMC0+bTJtX2Rldik7DQo+ICAJdjRsMl9k
ZXZpY2VfdW5yZWdpc3RlcigmZTUwMTAtPnY0bDJfZGV2KTsNCj4gKwlwbV9ydW50aW1lX2Rpc2Fi
bGUoZTUwMTAtPmRldik7DQo+ICsJaWYgKCFwbV9ydW50aW1lX3N0YXR1c19zdXNwZW5kZWQoJnBk
ZXYtPmRldikpDQo+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShlNTAxMC0+Y2xrKTsNCj4gKw0K
DQpuaXQ6IEV4dHJhIExpbmUgYWRkZWQuDQpXaXRoIGFib3ZlIGZpeGVkLA0KUmV2aWV3ZWQtYnk6
IERldmFyc2ggVGhha2thciA8ZGV2YXJzaHRAdGkuY29tPg0KDQpSZWdhcmRzDQpEZXZhcnNoDQoN
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgZTUwMTBfdmIyX2J1ZmZlcnNfcmV0dXJuKHN0cnVj
dCB2YjJfcXVldWUgKnEsIGVudW0gdmIyX2J1ZmZlcl9zdGF0ZSBzdGF0ZSkNCg0K
