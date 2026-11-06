Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793950087;
	b=tJK8VJvqsc/Ra64jK7Do0kp5I1t5q8pwJ1Z8cEIjA5UZnjnxwFd4bJVMRUOSSnF0hENj
	 c/vx0J366zjjUEqSGke7IVAhbLLpikS4fDjbJ+DV337Qv8rw0oVgv7dW/II+2zvCCoPRP
	 TgXe04G+s624FzSViu/KoEFefzcKw9kmdjy0cfKTm5A3eyxapiawenNAB2+odh+kTFAcF
	 IAGro3zJMIYeuXjX8L802Dnh0qdL+KuyUuVqnOBOGBZKOKmypRPHlyg0+WVpNQKYBgCPy
	 zhuhCiuWZJA2FQhUl6dobx0m+GRdO8UopmithoDoa0dA+cqEcJAP4pNupGD8dmfhFdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950087;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dIghQSBE5Ovnv7DwILttGhC5aH4p0EXNoWOYiyogQ4w=;
	b=S0085mQqfMCi9cQujyg2suuKcycIK1p3b2MA8KuQYKsHOFtJWG8drCGpnP2y6Tu6bdGm
	 eC4GsORbg5muxCRUM+70Evq5JWqtxXLm6yGCvJ1+qoVIlNntfBUNvaxqLG2V+04pvIVNc
	 F8Rae5JLwTg03Z75cOgLnHAjMsI90XZqSfqlGhZhkIDNDELzCQvoAXwRVEr1xfttO5o4A
	 iMCxa1OFQ5lmEF+Zavlm/UKK3NaFcq7JumcoJWFYIQ/guyaiM61wyBjCQYZcJGWfrUZd1
	 MSfJrGciebdnbij0oXus7GXGP+HU+eQld29nSaElUzULgWtsAMwCw6LTBbFPOKWVu/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XbRkzENP;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=RxvHohl8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD79606A328;
	Fri,  6 Nov 2026 07:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD79606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XbRkzENP;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=RxvHohl8
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67RqbO3273658;
	Fri, 6 Nov 2026 01:28:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dIghQSBE5Ovnv7DwILttGhC5aH4p0EXNoWOYiyogQ
	4w=; b=XbRkzENP6fAB6EQPOvoOKYtG3P1Yn+9MVtT7CHeMZHZIuRaFR9t/a7xaX
	1J8gBb3do5uXfBWdVfE8Bmv5s0BEg0yg8Gg905Y8XOEOt+UqDTfzKbYvcbTek+qx
	VhGkP1n7sELLCt6Vv30Zkz8ZZdiGY01k2ll182e2aedqOtq+KNIrXOIbQ5KbiEor
	ZVCEj7huEo4O3J2wF50rfw0F9LTxhEKm3wrsvV2uOLnSjaFGZWdKdmX0rZ+OLiXg
	b0qVKReA2QTdhgXdWRMOU1zs4INz523KVCLzkdtPoIyvVnZTHjhhtRZi+a2mY9WD
	fyytKs2sIOJEqDqxGIzAAu3qmAfkA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hs3qma7ha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 01:28:01 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn2H1RdJqw9h030te08lx70CCaVLACHUaeVWBqywazpYwAHVimcakcZ2l7NKli2Sy43efRfd2molGiNlMa3VTtxlNLcqP78W3UdotCFNW1yfzKdUL0JVU15ni//aG6pOa927Q2T+C/efPgCxD/rx3BeMY6TzSssMl4OKhL0PsGrM1/La6Z2JZcEHRzaJw3jcitT0nerZhOIU/WTjPYXZS/JmOxAHrhfKLuRFUYiXyLBqRNSs2eiltFTs6j1YIC285w5+jAdFE98YS7fb8GTEhZrVaGwWkkVRnEQxye0hlY30+3BZEhn0lDljtoD/aeehNiMAn+sGCQ6oiONGtwYFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIghQSBE5Ovnv7DwILttGhC5aH4p0EXNoWOYiyogQ4w=;
 b=dkh0ywRakivQ6u5Ad5yWuTBaEYrQv5PnVDFOnr++wBF9unhZ03IB1bvl32cpesvcUeOxcGwu2lqV0pGPXnzw63g/zEVglP80DJ9Um5piB7auutBmOpLRBcTIIZ2Ztd1jt+B2b+3vViq17WQCdODNIW2f2SgeuvUB0qTsDIf3/AKDUxGRoTAqncYZ1OFau8o8LeX828TPyCuixKQ5iF1r5VEziQGxDYEF6tuBcs7csqBMukRi2tAQr9c6FkcFP4qnd08m2CvKMvxBkQFCXCHmGjG18HCr4Km8Yy9dokcek27+tnC8OWhwGPL/T1QVr16z96BUZhUrH6zR5LltGYJjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIghQSBE5Ovnv7DwILttGhC5aH4p0EXNoWOYiyogQ4w=;
 b=RxvHohl8hvPbAkX/SHlpUIu0RQ5/Q4GRssM1biKPSSonOpD0y+peQXnIkijIG+KLev9DcM3Nn2IoxA6WWlkZHNBje/jJb2F71P5gSe+XmdUYwozf6nDWnWWNpfujVAD4l2dUF94uF/gw4ZCnisAzYhy3C1GX6sTss5znycc5zhg=
Received: from BN8PR10MB3652.namprd10.prod.outlook.com (2603:10b6:408:ba::10)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 07:27:59 +0000
Received: from BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a]) by BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 07:27:57 +0000
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: "Brnich, Brandon" <b-brnich@ti.com>,
        "mchehab@kernel.org"
	<mchehab@kernel.org>,
        "hverkuil@kernel.org" <hverkuil@kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Myeonghun Pak <mhun512@gmail.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] media: imagination: e5010: release m2m device on
 probe failure
Thread-Topic: [PATCH v6 1/4] media: imagination: e5010: release m2m device on
 probe failure
Thread-Index: AQHdYv1E4pjlUtGfYESW5y49+wnPEbcgurOA
Date: Fri, 6 Nov 2026 07:27:57 +0000
Message-ID: <78a1f748-6ab3-40dc-8eb6-6a655e8e670f@ti.com>
References: <20261023144618.1652390-1-b-brnich@ti.com>
 <20261023144618.1652390-2-b-brnich@ti.com>
In-Reply-To: <20261023144618.1652390-2-b-brnich@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR10MB3652:EE_|SA2PR10MB4764:EE_
x-ms-office365-filtering-correlation-id: 71ce6ea4-5e8a-463a-adbc-08df3bd77ab1
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|261022105027099003|56012099006|261021123027099003|261021135927099003|261028144727099003|261022115727099003|261102123227099003|261021121427099003|261009223027099003|261022075727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 CMMJqYcWZxvKQo1+zsSFqLGJV1yy4NSlbDkwb0HrBwpEjHEePJmgq5bA0xovJbCj6ZA0P/BWjQlpM1xASfsXdCWNE+EvKuJh4UW8Y2jL58mKnfiVQpKxDtqqxabSApBsGQcW4hhvxr50aKZ3DHE08o769xO3JMBZbn8bJxKotaR0+tpQ923576BZ+tPV1yEl8HloZ/n/GH0/Z0UwGpZKNrS+x2vN++6mNuJ/Ejnx2SYIgv/Q8qrg0TjOKo5404z4RdEs3rCzHyK3kLmRzW9ZO6Ow5DYnfCQwQA/1Tl5F/hwpwt2CJftWxIs26/4bOJ+oK4zghGzgL1MgHg5TTCcKHh4SeTFy/34DlaqRBcwDjWn9UitNYU8MrC8/ofTW8F7qkROGCvN/w3NeXI4OmCIvybyGhpIIyXgBq0V32wu0VIpvilBk+1jpdslZfdq0ixzX36yRe7lbNbQpIy0z7TNxx1aZgwHvutgZhuPBA4k6qfzCWkRN5rzFkvAKQgTe0xnosYtOJBe88AftzjCnwbQEXeGFoZuzbEDyaHjF1CuMetw4+LA7SdhKASLH1OhLKf8WenLZu+pJX6Kr5wMV06RCafU52ofMYRnslI4yS6yJfhVjMo0dSHru4JwmirwzGT4Poz57SSqfq66vVS/IOBbIjn727BiKgRFgaAW88+rtuykbX5fiQ2sbS++24roJE46ErHT2DCrWldKnk7bajLU+rRD8LAVwgFKKb277AGe5fQI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3652.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(261022105027099003)(56012099006)(261021123027099003)(261021135927099003)(261028144727099003)(261022115727099003)(261102123227099003)(261021121427099003)(261009223027099003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUlDUWkyZEd0RFpkR2tjQWJ5aElJdDFISytURmlKZ2ZnMnZUWjVTaFdMU2tU?=
 =?utf-8?B?SlZYTEFiSGI2U2h3ZzBLT3NlaUlqMDYrTlZqSnlLcVRGNDFlY3NVcVhCUnBt?=
 =?utf-8?B?b1NqaTNUN251RmJmUTh6aGZWRHlESWJ0TmtKcG5VRFNWUlAzaXVKZUowRDFC?=
 =?utf-8?B?UGkxdFphN1QyMDkvNlRFUlhGZ04zcC94eXFZYmZIQmk0dWx6TWVwK0VmZDA3?=
 =?utf-8?B?YlJmM1h0NnFKb2tZbVc4TWtGNnQ5dC9pSTFiSHA2ajBEU0pwcmVSOUh4ZmlV?=
 =?utf-8?B?R0VwazQ5ZThSeGZCNERNa2F1TCtSWWw5ZEtSM0VUL2xqN3lQbTc2VVltd2hr?=
 =?utf-8?B?THZXRFRBT2dHY3V6MXgvVEVTTi83TjF1bHdBbUwvK3BJWTNrUGdlUkNlTk9Q?=
 =?utf-8?B?ODZpbUJpbytEOHFaRTVaemp0dW9nWkJvOUxLdG9SQkRaK0hjZXlDQUlNSkcw?=
 =?utf-8?B?SVBVWlZWSlVJclNpUHpWUWdEcEVlL0lTem1pTVJ2bmdnZnpSNDF6V3ErY21j?=
 =?utf-8?B?ZTRvT3FMQjhuTnEvUnFCU1hNRmxDM2Nsc2lhak04YlZvVWkwR3lFeUVQRjFJ?=
 =?utf-8?B?MmFtcFpSbnpjZk5HQXZuS2w4cFZ4RUUvSTNMaE9MNC95clprQ0VvM1djRVFG?=
 =?utf-8?B?YVY3Q05OeGJNOW5Xd3Q1cllYUSsrNFNHMEZrRUpLdnBlbUtJME9MbWVsMFA1?=
 =?utf-8?B?Z3JaSXprdHliU1dNeFJwcFBwdmtpT3pmQTBoNFVYR2svUUJyOHhVN3VlYnNj?=
 =?utf-8?B?RWJiQXBBOUlWTzhTTHFpQ0pvMnY3MzAySldLSUpkYlBqZDlCWVc4WHFjY2hN?=
 =?utf-8?B?c2lVcFlWd29hUWJaZ2tWTERwQnVRSjJySGErZXNONnVDc0F3UnRzcHVYSVg1?=
 =?utf-8?B?SmlidndVUEJUVm9idHBaVTNFMXpTZFZyVUJjUWRKeVQxS1hnUENKb1VjRmF1?=
 =?utf-8?B?SUdjbEZjNXdBQjBLT0tnOHNia2wyLzZHN2lsbnpGdnpjK3ZHRjVjbWE4OGJP?=
 =?utf-8?B?UUNYa1FoM2F1SGl5Mml1cVkvcGZHZFdCd2h4Sjl4Rnh6dCt0QjJzTnRrdEg4?=
 =?utf-8?B?dnJ5aWphanA2aFVEQloxbzNEWTgwblFCNHlBb012R0Y3eXJiM1dhOWY3RFND?=
 =?utf-8?B?ak80VHVHaXRVV3FVRFNmQ1NnMmZQODhaZDF6MzFNa3k2UXRDSHlHUmtkVHF0?=
 =?utf-8?B?Z3E0R0xrMmJOSWxDdFJFUkU5aGt1TG5xMzZlbnNIOWNheEpoM2pnZkNYSmdO?=
 =?utf-8?B?eWFWUFZ5ZHlPMFYrNk9pN2xuYW5zeUJHcmRZRmVSNzRCSWNyRTVtMHJNTTRU?=
 =?utf-8?B?bDJmQVhORTg4RjdxdUZ5dFVOY3JuVDRuem4wQ2NzWERhS0R1ZWtkT3VnMndE?=
 =?utf-8?B?RUZZMThHbWt0eFlTMXNXU1VsZ1VXcmNtbmVGOG9lNG9uL095bDdqOHQvT2No?=
 =?utf-8?B?Q281TGtadWh3QkhqTlhBQXhYSTQxUExKU1F2S3VURzY4RitXK20xSmxFSDFX?=
 =?utf-8?B?WFNxZlhnbnVOTkg4L1N2dlMvUHpyN254M2NZZlV1Znh4VHU0NWhiU2R2S3o5?=
 =?utf-8?B?Wlo4V1NyaElIY3ROTFdrN3d5eWh5MWpWb2ZCT2JIUTFxWHEvQU5yc2FIRTRE?=
 =?utf-8?B?VWJlc01MYkJnYzFYZUZ6N0RPcXZqeGtRTGpvTTVBVEdwQTkyYlJCRkZtSUo3?=
 =?utf-8?B?bkVaajkzN1R6eWlXWU9aUHZ1MXNhNmRmYVBpTWN1UUVvSFFZSnhIRk9jTWpn?=
 =?utf-8?B?Z2IydVd1Y3U3c3lIM0FuS2F5aWRLbXI4UU5IeVdvdlJlTklkcUY0NlRUc05C?=
 =?utf-8?B?TWVHd2JicGJSaUtITE1iZGVCR1dJZDhZbEIyb01wYU1Ua21XZXVMUW5yRU45?=
 =?utf-8?B?bGI4THlvSHgrK3RxTnlDKzYwdjJ0YjVORXdxdGQ1T01JdUZxQW1qeFZrcFJQ?=
 =?utf-8?B?N1J2OVBpNTFEaWNYTmZUSkpLM0J4eXAxLzhOSVhzS1k0b1FLc2lNanJwZEpU?=
 =?utf-8?B?UmNlRkNSZG9ya0o4a0U5VWp1NkovUU0xNnhWVFJBRy83QWVvSXpQSlVJSjZ0?=
 =?utf-8?B?SzF6b3V6bWVsNHN6eFJ3YkduU3JxQjJtbmdCbkpSSkxHOUtONWdLR2NYWXFE?=
 =?utf-8?B?cWMzeGVieDNiVmJPY3lKZkxUMVNMM1QxSXY3SnIvbGN2Qi9GQmt6K3RTQjI4?=
 =?utf-8?B?Z2FoVEFaS2dIdDNBZUdoQWtYWDBsTlI0V21JaWpGU2w3RWMvRkFDZCtSOFNQ?=
 =?utf-8?B?RzdnR0UrdGlpT0VZdUNudFFHUzgrYU4zN0dtOWt5YmlTTXdFZHhVa2w4Q1Y2?=
 =?utf-8?Q?ceyjfVpEsezaQUFUpz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFAAC70A902FD448B812AB8517D14973@namprd10.prod.outlook.com>
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
	o6UTOgdHkqFEVHdmDC0b2jdUtBsDhbGGqD4QboSLDkvGxyQOuNY40zWYFTI6Q0VCjktZ+pEiJ9AZ2mfspE1+YYneNUOdPQdtye7DQ6xAvSZZq36/z87cW6XYBHVu0OB+1BA2vKBNm0DDrnh0YcAsRvWiSPYkiwmwJLga2Ig9Bv1AQrhFh6r1jRo8l/BfKNENZPU2awIba3+VfDOrgi/s2CgEpBCBwYx5XQbotx1k43VVboBPcUWK0QFQJJb3nwB+vLOQSTGrBBaI6PvniFcDSmhjLoUNqqfXTJ/912STobCG9qo/BLNa7PbnT3W0XO1HboGGb7kU4flzI2vEBB6SxQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3652.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ce6ea4-5e8a-463a-adbc-08df3bd77ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:27:57.1417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Um6GzQV1OW3Req2BzlyMBrjp025a40pwXydW7aqCK2mRR8XNlj6PO83dpiQcVepa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Authority-Analysis: v=2.4 cv=IJ2XmQvG c=1 sm=1 tr=0 ts=6aed8181 cx=c_pps
 a=BRoDR27eCUDGJJSfTO8W4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=gia2ZrFLpXCUGkhVA6QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfX4Wdoad9R5xNH
 KOsCoCGsGIYbJ7x4GIW/a3Yl7r0VKJtX316uTCC2EbPaTB6x2MTZtxLZZEP1qVksGh02KuYtHOE
 D2PMu+4eZ18VD8oSRjsGWU6sdxeJuzan1WHzOU27H1/ykhCwIOD2OLmWkKuwVD15qjpdMIDMGJm
 O6041AKtYVxz410UwJkKZ7Sbu4zWPDZsCTJFoYz0L/MLtlwEhQ50apnFP4lBjFTvzhFjGpWpR7q
 46q7TtyZqOo/N70PswxSIJiv/EwWG3C0XKpR01aLkppY3NNOdKq9i1XL3Et4LtpsLkFBsh/4Sng
 iFlVVklDMZ5hAQn4B0czBI6BG8Tol5d6Y53VsMjYhDpfpUU7FYfBXrIH1KIncvnMdUl/zjzBdAB
 MUuypbnFM+JQDDnjj/xE9/xYnZNKQiPKxB+DS6f+IOVJh2HPECunxJIIpDLkyW/im+7eLOjM4cw
 /+cC/6fXCnvN14vIGrg==
X-Proofpoint-ORIG-GUID: MWIQN8GR7zpGtrwd7-IUTkW66BO1mQ1r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfX6NwgPz9O4/Jr
 w6QANLbMPFIlXyfBMjiaEEQi08WTXL3OUqzxkgfXpBK2Vx70o+latAlzZJTgWxtdmcuyPK12MGL
 abp2x1E0DaHO8u0dm7rS0WWWvBL1WwQ=
X-Proofpoint-GUID: MWIQN8GR7zpGtrwd7-IUTkW66BO1mQ1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060029

T24gMjMvMTAvMjYgMjA6MTYsIEJybmljaCwgQnJhbmRvbiB3cm90ZToNCj4gRnJvbTogTXllb25n
aHVuIFBhayA8bWh1bjUxMkBnbWFpbC5jb20+DQo+IA0KPiBUaGUgcHJvYmUgcGF0aCBhbGxvY2F0
ZXMgdGhlIG1lbTJtZW0gZGV2aWNlIHdpdGggdjRsMl9tMm1faW5pdCgpLA0KPiBidXQgc2V2ZXJh
bCBsYXRlciBmYWlsdXJlcyBqdW1wIGRpcmVjdGx5IHRvIHRoZSB2NGwyX2RldmljZV91bnJlZ2lz
dGVyKCkNCj4gdW53aW5kIHBhdGguIFNpbmNlIHRoZSBkcml2ZXIgY29yZSBkb2VzIG5vdCBjYWxs
IC5yZW1vdmUoKSBhZnRlciBhIGZhaWxlZA0KPiBwcm9iZSwgdGhvc2UgcGF0aHMgbGVhayB0aGUg
bTJtIGRldmljZS4NCj4gDQo+IFJvdXRlIHBvc3QtdjRsMl9tMm1faW5pdCgpIGZhaWx1cmVzIHRo
cm91Z2ggdGhlIGV4aXN0aW5nIG0ybSByZWxlYXNlIHN0ZXANCj4gYmVmb3JlIHVucmVnaXN0ZXJp
bmcgdGhlIHY0bDIgZGV2aWNlLg0KPiANCj4gRml4ZXM6IGExZTI5NDA0NTg4NSAoIm1lZGlhOiBp
bWFnaW5hdGlvbjogQWRkIEU1MDEwIEpQRUcgRW5jb2RlciBkcml2ZXIiKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBNeWVvbmdodW4gUGFrIDxtaHVuNTEy
QGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQnJhbmRvbiBCcm5pY2ggPGItYnJuaWNoQHRp
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERldmFyc2ggVGhha2thciA8ZGV2YXJzaHRAdGkuY29tPg0K
DQpSZWdhcmRzDQpEZXZhcnNoDQoNCj4gLS0tDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2lt
YWdpbmF0aW9uL2U1MDEwLWpwZWctZW5jLmMgfCAxMiArKysrKystLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1qcGVnLWVuYy5jIGIv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1qcGVnLWVuYy5jDQo+IGlu
ZGV4IDQyMGNiOGJmZGIxMmEuLjIzZDA2NzA5YTY5MjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vaW1hZ2luYXRpb24vZTUwMTAtanBlZy1lbmMuYw0KPiArKysgYi9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEwLWpwZWctZW5jLmMNCj4gQEAgLTEw
NzIsMTQgKzEwNzIsMTQgQEAgc3RhdGljIGludCBlNTAxMF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChJU19FUlIoZTUwMTAtPmNvcmVfYmFzZSkpIHsNCj4gIAkJ
cmV0ID0gUFRSX0VSUihlNTAxMC0+Y29yZV9iYXNlKTsNCj4gIAkJZGV2X2Vycl9wcm9iZShkZXYs
IHJldCwgIk1pc3NpbmcgJ2NvcmUnIHJlc291cmNlcyBhcmVhXG4iKTsNCj4gLQkJZ290byBmYWls
X2FmdGVyX3Y0bDJfcmVnaXN0ZXI7DQo+ICsJCWdvdG8gZmFpbF9hZnRlcl92NGwyX20ybV9pbml0
Ow0KPiAgCX0NCj4gIA0KPiAgCWU1MDEwLT5tbXVfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZV9ieW5hbWUocGRldiwgIm1tdSIpOw0KPiAgCWlmIChJU19FUlIoZTUwMTAtPm1t
dV9iYXNlKSkgew0KPiAgCQlyZXQgPSBQVFJfRVJSKGU1MDEwLT5tbXVfYmFzZSk7DQo+ICAJCWRl
dl9lcnJfcHJvYmUoZGV2LCByZXQsICJNaXNzaW5nICdtbXUnIHJlc291cmNlcyBhcmVhXG4iKTsN
Cj4gLQkJZ290byBmYWlsX2FmdGVyX3Y0bDJfcmVnaXN0ZXI7DQo+ICsJCWdvdG8gZmFpbF9hZnRl
cl92NGwyX20ybV9pbml0Ow0KPiAgCX0NCj4gIA0KPiAgCWU1MDEwLT5sYXN0X2NvbnRleHRfcnVu
ID0gTlVMTDsNCj4gQEAgLTEwODksMTQgKzEwODksMTQgQEAgc3RhdGljIGludCBlNTAxMF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQkJICAgICAgIEU1MDEwX01PRFVM
RV9OQU1FLCBlNTAxMCk7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfZXJyX3Byb2JlKGRldiwg
cmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIElSUSAlZFxuIiwgaXJxKTsNCj4gLQkJZ290byBmYWls
X2FmdGVyX3Y0bDJfcmVnaXN0ZXI7DQo+ICsJCWdvdG8gZmFpbF9hZnRlcl92NGwyX20ybV9pbml0
Ow0KPiAgCX0NCj4gIA0KPiAgCWU1MDEwLT5jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCBOVUxMKTsN
Cj4gIAlpZiAoSVNfRVJSKGU1MDEwLT5jbGspKSB7DQo+ICAJCXJldCA9IFBUUl9FUlIoZTUwMTAt
PmNsayk7DQo+ICAJCWRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gZ2V0IGNsb2Nr
XG4iKTsNCj4gLQkJZ290byBmYWlsX2FmdGVyX3Y0bDJfcmVnaXN0ZXI7DQo+ICsJCWdvdG8gZmFp
bF9hZnRlcl92NGwyX20ybV9pbml0Ow0KPiAgCX0NCj4gIA0KPiAgCXBtX3J1bnRpbWVfZW5hYmxl
KGRldik7DQo+IEBAIC0xMTA0LDcgKzExMDQsNyBAQCBzdGF0aWMgaW50IGU1MDEwX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcmV0ID0gdmlkZW9fcmVnaXN0ZXJfZGV2
aWNlKGU1MDEwLT52ZGV2LCBWRkxfVFlQRV9WSURFTywgMCk7DQo+ICAJaWYgKHJldCkgew0KPiAg
CQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIHZpZGVvIGRldmlj
ZVxuIik7DQo+IC0JCWdvdG8gZmFpbF9hZnRlcl92aWRlb19yZWdpc3Rlcl9kZXZpY2U7DQo+ICsJ
CWdvdG8gZmFpbF9hZnRlcl92NGwyX20ybV9pbml0Ow0KPiAgCX0NCj4gIA0KPiAgCXY0bDJfaW5m
bygmZTUwMTAtPnY0bDJfZGV2LCAiRGV2aWNlIHJlZ2lzdGVyZWQgYXMgL2Rldi92aWRlbyVkXG4i
LA0KPiBAQCAtMTExMiw3ICsxMTEyLDcgQEAgc3RhdGljIGludCBlNTAxMF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gLWZhaWxf
YWZ0ZXJfdmlkZW9fcmVnaXN0ZXJfZGV2aWNlOg0KPiArZmFpbF9hZnRlcl92NGwyX20ybV9pbml0
Og0KPiAgCXY0bDJfbTJtX3JlbGVhc2UoZTUwMTAtPm0ybV9kZXYpOw0KPiAgZmFpbF9hZnRlcl92
NGwyX3JlZ2lzdGVyOg0KPiAgCXY0bDJfZGV2aWNlX3VucmVnaXN0ZXIoJmU1MDEwLT52NGwyX2Rl
dik7DQoNCg==
