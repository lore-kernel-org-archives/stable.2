Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793782840;
	b=ngcnnuvLJjdjSdy49ysGCwo1CsZr/NEEBwnm1UKkHB04TZFD4jN86kS5716fUKPwTQ84
	 WCcPAqldet2MSeBb3RE42dnI3X9Ei3KBGoWKvEsgs2XlD6W/RpPUlnnrtP8Xza7NfCTLo
	 Y+aSh/ffzIqPiKiPOdE5sMTZJM24N/GX4NwmPBN0nDc1jHqJ1qXFQ52jKNxfzB70N60y1
	 lx8bDxSVpPbiZC0SktPtpjCbuUrMSjw93nFFD4dTLG+WoqLJ89uVOd3RPi6BVgaNzNXBe
	 1fGXVHpk0W0ARH3Q61457dt57CG7vAYG7cpPLV1J0FF0uVYYkNxn5Xgd6zCkYOLYxzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782840;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PMgR6nQe9DgmXimyJkZ+ZbHxvQhPxG3Oayv2HYaKh44=;
	b=mmViHYvJD4FGTiAaLhbvk13+D8ipxyLbhleRel57xpXpFuI5tGRjgSZU7kBjI6LBCrAG
	 vwrDI2ZXdd3VlEMnyAhcWSSpeDUyr+rnB9tDHh0a2NoMErOeLHYNLyKoI+pXyP/titYit
	 Ks/ReI7zn1z5NTdTgAw+ITgMDNXLrh1eaQRDvWHHK2qYwShXZjT/6g3hKWPoQ/tmPug3N
	 3rw2zSlSSco7Wsuf6eUTJLAgY244BeXibB71nZlOY3B4XKoVHymwlX0J8v/EshtGSGoyS
	 80KteKfP6zSC0c1vqn7Qe2gY4Wt1MB6PJ4gvi93Wf0LKS9psOXLd1EPx3r2vUh9UcBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YmV6O649;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="Koly/ExX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C46606A32F;
	Wed,  4 Nov 2026 09:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C46606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YmV6O649;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Koly/ExX
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48J3li1287148;
	Wed, 4 Nov 2026 03:00:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=PMgR6nQe9DgmXimyJkZ+ZbHxvQhPxG3Oayv2HYaKh
	44=; b=YmV6O649iuBGWZsiMEcJGv0bX6PfC4e7ymHRSLzob2oBWL4baGMx121iw
	Rj0eLEyOEh9GWddxrxtuFQBUPJyxS9zTcN5UImu4bDmuAIEiCt6B8qPVyyZyi/cI
	0a8UuQDs+pLHAFYHkPhbPvasPj/0bKvL0harFUMn+MSSnEZMHEltQYdXeNsE5xFm
	rqL50JIvkqPfY5i5IQUp5zXvNy6qDsl4qTVcznhE9RH9Fa9Z9w074l4NVr1j4M+k
	Y3tiPsWD/5+hmiK3HDxqaKwjjfCYWKh/yoFSqwWnyC7awXsMLaSbW6QUEqKGpOpe
	5R5QvTynMGFHzbZhEXZpOml0bv+pQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hquyf1vnc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 03:00:33 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHyOcgRtqg/J5PdrJSRp7XKB/3W6A1F9bV/8aXLidUGPIxAS3e+jpqhoHBgQ/q/fiPta6yjCDJXl+pk3tTcQXo3TFfzj8tlT/xrbN9kUFZQ5yW/AtVc2NCZglkrOPzpjrWrDP3U6B01huO3tXdak/QvABqhKKEXc2wwZavka1ed6jNAeLhXRvG9c1HVMn4xiiA8D48wb7pLOG+AtVMpRGimvyALR83aC4tBOjd3KTHKqMoU+utTueD5Bf28W8E+PSjrj//v4Bl0fGWMggbxT8hINCrQvyKQM/QSpgM2jaP+7E9d6xoyTMcrCLDYifKuuYWvUS0NPiC24pd0et/6Q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMgR6nQe9DgmXimyJkZ+ZbHxvQhPxG3Oayv2HYaKh44=;
 b=KO1/enioPVWT/chXL8n+XV+euIGK2lwy2kW5wAKH6Ck4s7KmjRbyL3Dg3nwTxS3skrqvd0lGN3ZnbVFIa7LruDSCR65Y8VTqBa89g18tiPBy4MKAe/SZdDEsbre6rcNiyyqxqBjKiQTDWk8M2YeEnfmCsMBp01IVDDtcO52wTUd03DtRdMUweOUVgd/90JFp+UtQznmvwCE471mz9IfRZKvplR7dfOpp9PmPy9cUrqS9x0WHknFB8gJ1+D3q8KBRB8uMyF/FD3nmkpxntqjRGY9ETMTFCk0ZQQtyQZFBFMbqBmzGQVk7L3UIXmNfodd1yQpFvJBq3syNwxV0ufk4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMgR6nQe9DgmXimyJkZ+ZbHxvQhPxG3Oayv2HYaKh44=;
 b=Koly/ExXRnKejC1OZubtTuE5Skelduw2rWneXRlfXlweSOxxtK+Cjn2t9cI+j+ekHPrpPlNYJJ4CBdjSvM1z2zWre5SZv47aDy4lE16qn1MIYQF4FalvzOx0+O/3iiOBG+MyTEJF1EXjaV3oUIchdzzjvcO3bbGWsHJcSZzB+o8=
Received: from PH8PR10MB6645.namprd10.prod.outlook.com (2603:10b6:510:223::19)
 by SJ5PPFD9B14F409.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:00:31 +0000
Received: from PH8PR10MB6645.namprd10.prod.outlook.com
 ([fe80::8985:7ede:7087:7bd7]) by PH8PR10MB6645.namprd10.prod.outlook.com
 ([fe80::8985:7ede:7087:7bd7%4]) with mapi id 15.21.0546.025; Wed, 4 Nov 2026
 09:00:31 +0000
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
        Vinod Koul
	<vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        "tony@atomide.com"
	<tony@atomide.com>, Daniel Mack <zonque@gmail.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Panis
	<jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
        "Francis, Sebin"
	<sebin.francis@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/4] dmaengine: ti: cppi41: Restore QMGR_MEMCTRL in resume
Thread-Topic: [PATCH 3/4] dmaengine: ti: cppi41: Restore QMGR_MEMCTRL in
 resume
Thread-Index: AQHda8rnXp5IO7zQOki11RT8cSyzTrcdnkoA
Date: Wed, 4 Nov 2026 09:00:31 +0000
Message-ID: <85721db9-ae98-409d-8ae1-4f3ba2b2ac0b@ti.com>
References:
 <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
 <20261103-v7-3-topic-am335lpm-cppi41-v1-3-d7213446c5f5@baylibre.com>
In-Reply-To:
 <20261103-v7-3-topic-am335lpm-cppi41-v1-3-d7213446c5f5@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR10MB6645:EE_|SJ5PPFD9B14F409:EE_
x-ms-office365-filtering-correlation-id: 82802da3-6765-469f-f890-08df3a521457
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|261102123227099003|22082099003|56012099006|38070700021|4143699003|261021121427099003|261009223027099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003;
x-microsoft-antispam-message-info:
 JYx0RV5tJ8kkD3C2ZZy+YqjJ7T2wJ1q9qUm9cVML1dMcCkvx4WldtITu+EMbzy8wwn/iPwx9ZqkPA/+IKjHPSc6qoFqzdgvUqhYdtPjdVv/Ii7CjD9x7HW+GJLanl2B7vo0/90p6Qxjt3hMFz0LyjDG3aki46moQU+sRZ9C8y7nYsO2vl3vg+nAbnWABfpsOgVV1uwHeMsn9se2rpkiQnQLbcrH+v0ipJwQ8Ar7Ju7ZsUTJQERXoQN7lv889NvLkz14lZf9PhzqjC0k49skCTRKDqOVQBL1mmWrn0/iIUPkMjREKwlV43Gi7SheLa/0sy+fTimkxHqk6QHuhD09fgNRRFN12IIsKIdFQX5jkBf5kYEm7d1/4xZ2Z3/0UeHcUzcY3kA887MPBZZqwllderjymVrO6Cuu00rRpyONVtU+5JvdPdIz47Uv5PbPh/ZtGdCSw6NbKlUnQLJW1S6h/b6jbs36lFufbEfTjk4Ju9oJA5Rs+d4MuLfjutyinRJz65O60p9qP8PNGvkIoHDal1J5JmDu6dcHbd+s8caG5Hi/y0Jw2BnsCvY67aZWJkTiCz7fwaPJdFzBasshnsVzN4bIcjbRi/x48QTRiDHdB9nIbc6bN9ccnqhVfypmUiqWyA2uFiUfDwXz+iYs7gyjsBUTZGQaw6Gm4nF2NjB2dZPHhoQ3YmCKjys2AR6vXiCjfz5UUBzmeXLDsHC95tGtxifLYH7Z7Dxdt2yZiP2uxkqQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6645.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(38070700021)(4143699003)(261021121427099003)(261009223027099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVJMNTcraWtqR0RodFJNMVlRRW16WGI4SGZZdWJEQ2N4YWtjdC9oVXkwVnF3?=
 =?utf-8?B?bTk4bXVVTlZmMEFEbXdYR0ZiZEQvSG5aQ1IrdFlKV1lkZ2ZwLytQNTc2dkx6?=
 =?utf-8?B?clFhRzhDclVYRDN0d1EvTERNRThRYW82S29DOUNwUEFnaW9qMUE4SHF1VHBF?=
 =?utf-8?B?Rk9SR0xtS0tobGgyQmVQcXBGSmQ5YzJKc2xoREE5ajVIb01wVVArYVg5TjBt?=
 =?utf-8?B?cS94bk5EQ2QvbHBPR1QvN3R3UCtIYUpJbDZlUEdZOFl0M2s2dkxlWEFWb2kz?=
 =?utf-8?B?RGQ1TVNFSi9jWjM2TUp5ZGh2UklXclMrYmZUUkc2aVNxRUl0VkQyQVRaVVdo?=
 =?utf-8?B?QVlEQjZOcUxUNEVCbU5CczVreEJTckIvU2V5ai9ESUt2cEI0L0hEWlV6UTls?=
 =?utf-8?B?WjFtTGxVenAzZUs1dnMyMVBXSm1reEdyK3NLb09VT0t6SHk0QWRHa1B1SGpO?=
 =?utf-8?B?TWJRTUdkaUZiZmt3QklqRS9BdVJDa2hYOG9TNENMcGVSVHoydjQrWU90ZWd0?=
 =?utf-8?B?am5OaWRsdnJaM0VPNi9oMXBxWi9yWENEZVRIZFVLR0h0cXFFVFYwcnB6NGVk?=
 =?utf-8?B?OVArSVJNcHNsZU82SXZIWEJqOG9LbldmekJWakNlRzJFN0h6T0FCVFNvOVg1?=
 =?utf-8?B?czZhUU1wTVgvOGplNm5VZHMzTjdFcFBIUWs5Z1hxMnI3QXN5YlVUeWpRZkUr?=
 =?utf-8?B?ZVZ5a2oyN2RNNm1NVm9pTmlaT1RhdG81ZGg0aEpGc0RmZEIrK25Na2lJTjE3?=
 =?utf-8?B?QytGaCt2cmVjRE91cUVqUzVLVUp1eENsN2FmSHhRMlR5QnQ3MFFlcDh2V1VJ?=
 =?utf-8?B?MlZSVFhxUGgrMnQ5RGJBd0YrL0Y2ekZHTkh4NzBwT0twVHFOeldSMlZ5enF6?=
 =?utf-8?B?OFplWllrSGc0MjJVWENhSjV4QUFUMEtKQmZhcTNLc3Irbjc1LzJZQkJGV0ZF?=
 =?utf-8?B?M0QyV2orTW5kVElCRGFabzhQYk9NM001a3p0dEhLYVRZRzRXdHRZVTFrNDhn?=
 =?utf-8?B?NmlQcGFSV3VGRTI4SzdOdXV0OXRyZWFnV0pVeTVxQ1V5ZVl5TVYzV3NQZFZn?=
 =?utf-8?B?MEVqSzFqdGp6V0F5ZUQ5MGNRVE9HZjVzUnpleWpxOW5NL0g3U25Ec1BwTlUw?=
 =?utf-8?B?TGFZUG1PaWJLZUJCb3hTZEM3YlJLRkRYNUxLZ2tNWVJSdXpQOCtDVkFwS3BS?=
 =?utf-8?B?K2xKYWpnWG5nYkJvT2tlRExVVExMRnczbFJYTmJMTlp3MWN5VDZRTzF2WTJ3?=
 =?utf-8?B?clZVa3BzL0FrdUtiYkJmcllVZXBEOFNnWXM5bU04aVJFZkhlMVloWlR6SS8z?=
 =?utf-8?B?SFNsUWZSd2xJSHdFVGErbFdiRmt5WFYvR3pOdVVvT2dlSHUwbXFGMFlOZzdT?=
 =?utf-8?B?L1BqelI1b21qSm9FbDhCelM1Tk42RW9LaTY4aEgwOGxBTjJmMXNGV1lCc1pk?=
 =?utf-8?B?NnI1QTNWT2dXSUFTUGRmeUpEMU9uVWhsQkxHNVRWdi9EaWtMZ1UyVGpONmpw?=
 =?utf-8?B?bGlvTndwaEQ2UHZCZ1VBb0pXZWk5M2tuMGM0MzZndWE3OUx0aGFMQWdoNCty?=
 =?utf-8?B?SnFGbmFEU2x5eXU5S2pNQ0RMREM1RGpOUlpES0F6WDJVcXluR21mblhXRmVY?=
 =?utf-8?B?bHcvVms2SXh6dVhaOUZyZytxZHJGNFV1RUhtbWJvcUVsaC9YNGJhNk1tdU1h?=
 =?utf-8?B?dmJVWml0ZFRkNy9WSXM4MDBxdWpvR2NaSGVSS1lJdkVrQjh2RXZYaFlCWUQz?=
 =?utf-8?B?Z0NXNzdjWks4L3JqeVBtYkYzVFIyUCtjYkxBaFVDSWxpOXF5UWp3QnE1ZGdC?=
 =?utf-8?B?ZGV5SUdjVkE5cjFKU3pQSHhSQUpJbWQyQ0NVcWVOU0pyemdPR3ZNWVpPa2RZ?=
 =?utf-8?B?dUgwT1Y3UGovQXRlZzdiZlJtRkFNaHNMUWJKWUdCRENGYlBSRUxIckFxaGJk?=
 =?utf-8?B?WUNXanJta3Radm9mb3VvNnVRU0QvRTZGYk1wREM1WHZhMEt4Y2JsbUJ4Yk5F?=
 =?utf-8?B?WHpUZHdOdE1xS0xMWmZGdHpVSXFWaFAyTXpwT2hhZWxtODNiYUVSUWdkcjNh?=
 =?utf-8?B?Z1h1T1hIcnhzTEgrOVl1bDd4SDY3NTZkcFpGbFdVRENIMHZFdWswYU9OQmd2?=
 =?utf-8?B?a0FPKzNxRFhCMWJlT3pXZTV6bm5Cd2FFQ1dTcUFCOU5QSzd4U08zdUgvMHNv?=
 =?utf-8?B?K0ttaWF4TXM4UTFob0k1YlYvbW9sQ1h6NForOGg0VHlRK2x0UlBTWHZXQnlq?=
 =?utf-8?B?TkRvQXUyeEJsK0U4NW1JMWVzVEpMWVZLRWxveDNhYUFBbDR0cE1BajVlcGkx?=
 =?utf-8?Q?pB+q1dVtnjFpQoJYW/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F575A31C7E1CB948BE45E449B39B2118@namprd10.prod.outlook.com>
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
	5CeJ58Nwcu76f18YhYcAOzAMgLz4RH/zlv0cXCmKkSilKnObpG4X786rO4Q2ul2Iv33vgwLDrjugRVkz5VclOasDBLtl9i9iInwrGB7gEQGVIj+8sEtUq344ZFmLxydN4Do7Hqjg9YEFKlu3j2PCovjVQY1xsBa68n8vjNmEL/A2/1+yhtSF2xgb7ncnQxzF58dNdwPwhOGfW6szpxkDZiQT9gxXEZos3VHCt1Gnnpm7nn9G6qXng9r/EPs9HMfUgdSec+6FwkWKNWc0YSSUUVy0z7bdc5l8Ix3uFQNgdu+GIo/5VoBE1BOHHU4jdAZ2H3YrckqvWW1d/mWxzhN1Wg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6645.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82802da3-6765-469f-f890-08df3a521457
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 09:00:31.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOh33W+6JlqUQpFCpXrvmmZcT8K17smbps9vCAOEpGeINZy9sfbmSMqcPYLFAT4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD9B14F409
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNSBTYWx0ZWRfX0QwTzEZ1OcbW
 kDXakKaEORjW1JMF5o6LtVaT6zPKSXnSoHSLLGFqmdshMc2PBzzxU9VzR6GYmAobtjCv8TB45+h
 2gFy+6IEyigKBL7BLFD3FXdpqOvG5C9Nk3fb/6d39cruQBgkIwfIiex8zWaAxA0gzjeRN98YZ5w
 h14lWt/UC1/zbMGy2W2DyHTgn+7hoHvyyzlnRC3fI2DMG7zAjPeRnXUovMgnrvUYFVW8/t83Z+n
 rClhIkzSlM1NWTc8LavKe3yJeNUuGvMz2knu1pLC++vUbMhsA9VAFYpjPZ4h6GELWJY5MrtIHzn
 xGzP/Is6P8m3mEkCiquxWIwbYQNrUY6xbMXGA0BxtvJaXIbS2GhzFSOHrcg0y4g2PCbYG/vHRRm
 1qAY5ssFQ1tIs2scrPutorkRg/SOHiJnpIRHVEYBXyC39fHAo9KS3WOxSu3ATmvJEyrvmhM5eH2
 DioUB+yq4TbbBo0mJGA==
X-Proofpoint-GUID: PXt0yXXWg-6Zz7gw60GbqpFT7vYUqUKN
X-Proofpoint-ORIG-GUID: PXt0yXXWg-6Zz7gw60GbqpFT7vYUqUKN
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6aeaf431 cx=c_pps
 a=TO2QspbEOyvqwnNCDF3LgQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=0rrp_ejtKkHPXBh795QA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNSBTYWx0ZWRfXzfei2hnYIrXB
 zs3Yywpy5SOd2OVCqDg9eKbjwJYSQEqwOUqc3NI64BjludeTXccq+K0we5MLRYOgJ5Gh429ke64
 O7uPzjrlot8kDqtJX/z06Y/kXQcn5lM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040035

T24gMDQvMTEvMjYgMDE6MDcsIE1hcmt1cyBTY2huZWlkZXItUGFyZ21hbm4gKFRJKSB3cm90ZToN
Cj4gQ3VycmVudGx5IG9ubHkgUU1HUl9NRU1CQVNFIGlzIHJlc3RvcmVkIGluIHJlc3VtZSwgUU1H
Ul9NRU1DVFJMIGlzIGxlZnQNCj4gYXQgaXRzIGRlZmF1bHQgdmFsdWVzLg0KPg0KPiBBZGQgYSBy
ZXN0b3JlIGZvciBRTUdSX01FTUNUUkwuIFRoaXMgaW50cm9kdWNlcyBhIGhlbHBlciBmdW5jdGlv
bg0KPiBjcHBpNDFfbWVtY3RybCgpIHRvIG5vdCBkdXBsaWNhdGUgdGhpcyBjYWxjdWF0aW9uIGlu
IGluaXQgYW5kIHJlc3VtZS4NCj4NCj4gRml4ZXM6IGY5N2I5OGQ2ZDAyZSAoImRtYTogY3BwaTQx
OiBhZGQgc3VwcG9ydCBmb3Igc3VzcGVuZCBhbmQgcmVzdW1lIikNCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIFNjaG5laWRlci1QYXJnbWFubiAo
VEkpIDxtc3BAYmF5bGlicmUuY29tPg0KDQpSZXZpZXdlZC1ieTogU2FpIFNyZWUgS2FydGhlZWsg
QWRpdmkgPHMtYWRpdmlAdGkuY29tPg0KDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9kbWEvdGkvY3Bw
aTQxLmMgfCAyNyArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RtYS90aS9jcHBpNDEuYyBiL2RyaXZlcnMvZG1hL3RpL2NwcGk0MS5jDQo+IGluZGV4
IGY1YTgyNDQxOGZlNy4uZTJhMDg5MDY2YzZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS90
aS9jcHBpNDEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS90aS9jcHBpNDEuYw0KPiBAQCAtODQyLDEz
ICs4NDIsMjIgQEAgc3RhdGljIHZvaWQgZGVpbml0X2NwcGk0MShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBjcHBpNDFfZGQgKmNkZCkNCj4gICAJCQljZGQtPnNjcmF0Y2hfcGh5cyk7DQo+ICAg
fQ0KPiAgIA0KPiArc3RhdGljIHUzMiBjcHBpNDFfbWVtY3RybChpbnQgYXJlYSkNCj4gK3sNCj4g
Kwl1MzIgcmVnOw0KPiArDQo+ICsJcmVnID0gKGFyZWEgKiBBTExPQ19ERUNTX05VTSkgPDwgUU1H
Ul9NRU1DVFJMX0lEWF9TSDsNCj4gKwlyZWcgfD0gKGlsb2cyKHNpemVvZihzdHJ1Y3QgY3BwaTQx
X2Rlc2MpKSAtIDUpIDw8IFFNR1JfTUVNQ1RSTF9ERVNDX1NIOw0KPiArCXJlZyB8PSBpbG9nMihB
TExPQ19ERUNTX05VTSkgLSA1Ow0KPiArDQo+ICsJcmV0dXJuIHJlZzsNCj4gK30NCj4gKw0KPiAg
IHN0YXRpYyBpbnQgaW5pdF9kZXNjcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjcHBpNDFf
ZGQgKmNkZCkNCj4gICB7DQo+ICAgCXVuc2lnbmVkIGludCBkZXNjX3NpemU7DQo+ICAgCXVuc2ln
bmVkIGludCBtZW1fZGVjczsNCj4gICAJaW50IGk7DQo+IC0JdTMyIHJlZzsNCj4gLQl1MzIgaWR4
Ow0KPiAgIA0KPiAgIAlCVUlMRF9CVUdfT04oc2l6ZW9mKHN0cnVjdCBjcHBpNDFfZGVzYykgJg0K
PiAgIAkJCShzaXplb2Yoc3RydWN0IGNwcGk0MV9kZXNjKSAtIDEpKTsNCj4gQEAgLTg1OCwxMyAr
ODY3LDcgQEAgc3RhdGljIGludCBpbml0X2Rlc2NzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGNwcGk0MV9kZCAqY2RkKQ0KPiAgIAlkZXNjX3NpemUgPSBzaXplb2Yoc3RydWN0IGNwcGk0MV9k
ZXNjKTsNCj4gICAJbWVtX2RlY3MgPSBBTExPQ19ERUNTX05VTSAqIGRlc2Nfc2l6ZTsNCj4gICAN
Cj4gLQlpZHggPSAwOw0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgREVTQ1NfQVJFQVM7IGkrKykgew0K
PiAtDQo+IC0JCXJlZyA9IGlkeCA8PCBRTUdSX01FTUNUUkxfSURYX1NIOw0KPiAtCQlyZWcgfD0g
KGlsb2cyKGRlc2Nfc2l6ZSkgLSA1KSA8PCBRTUdSX01FTUNUUkxfREVTQ19TSDsNCj4gLQkJcmVn
IHw9IGlsb2cyKEFMTE9DX0RFQ1NfTlVNKSAtIDU7DQo+IC0NCj4gICAJCUJVSUxEX0JVR19PTihE
RVNDU19BUkVBUyAhPSAxKTsNCj4gICAJCWNkZC0+Y2QgPSBkbWFfYWxsb2NfY29oZXJlbnQoZGV2
LCBtZW1fZGVjcywNCj4gICAJCQkJJmNkZC0+ZGVzY3NfcGh5cywgR0ZQX0tFUk5FTCk7DQo+IEBA
IC04NzIsOSArODc1LDcgQEAgc3RhdGljIGludCBpbml0X2Rlc2NzKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGNwcGk0MV9kZCAqY2RkKQ0KPiAgIAkJCXJldHVybiAtRU5PTUVNOw0KPiAgIA0K
PiAgIAkJY3BwaV93cml0ZWwoY2RkLT5kZXNjc19waHlzLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9N
RU1CQVNFKGkpKTsNCj4gLQkJY3BwaV93cml0ZWwocmVnLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9N
RU1DVFJMKGkpKTsNCj4gLQ0KPiAtCQlpZHggKz0gQUxMT0NfREVDU19OVU07DQo+ICsJCWNwcGlf
d3JpdGVsKGNwcGk0MV9tZW1jdHJsKGkpLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9NRU1DVFJMKGkp
KTsNCj4gICAJfQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+IEBAIC0xMTkxLDggKzExOTIsMTAg
QEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBjcHBpNDFfcmVzdW1lKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gICAJaWYgKHBtX3J1bnRpbWVfc3RhdHVzX3N1c3BlbmRlZChkZXYpKQ0KPiAgIAkJ
cmV0dXJuIDA7DQo+ICAgDQo+IC0JZm9yIChpID0gMDsgaSA8IERFU0NTX0FSRUFTOyBpKyspDQo+
ICsJZm9yIChpID0gMDsgaSA8IERFU0NTX0FSRUFTOyBpKyspIHsNCj4gICAJCWNwcGlfd3JpdGVs
KGNkZC0+ZGVzY3NfcGh5cywgY2RkLT5xbWdyX21lbSArIFFNR1JfTUVNQkFTRShpKSk7DQo+ICsJ
CWNwcGlfd3JpdGVsKGNwcGk0MV9tZW1jdHJsKGkpLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9NRU1D
VFJMKGkpKTsNCj4gKwl9DQo+ICAgDQo+ICAgCWxpc3RfZm9yX2VhY2hfZW50cnkoYywgJmNkZC0+
ZGRldi5jaGFubmVscywgY2hhbi5kZXZpY2Vfbm9kZSkNCj4gICAJCWlmICghYy0+aXNfdHgpDQo+
DQoNCg==
