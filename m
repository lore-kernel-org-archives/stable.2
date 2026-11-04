Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793782745;
	b=DXdI8LyNJIPYj/QGRtKayulG0aMgnGOylPEneap/LOcnTjhlzb1vKa9YhBJcwjnTE3aW
	 ggHdHBeFn08f9QSibGP4v38mn7qxhp6jcfEnSpEihrMQDntCpyxAoIciFCRpkfTgw6tQd
	 73JamGcR/uor8XRD4pzordCj2tWO1jR4EsuwJqC3oAt8D3pMyrkG6WAf7Q0L2px98kMEt
	 xdsVMw7BVOrEGVXKzzCeEDSVwcTSHafxAKKKy0nQ3K4wBeoi2WFPu7wvwhof7GbmKKk/T
	 bcnVq7VPQYQj1Gf6h4sDHWKfzPTE+PxG7hB0w+h5xKq4UQt2JEdcsE9hcB7D6RglHYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782745;
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=81pZD97wjikj0MPeYagDnHXohaD5rmrxr59e/g3AD8M=;
	b=dHHyJKap7DX8ToVR/T+bqawISp/83Y/pjm2FblK0ifMU52LRUPoemui1NsYhnZ+pSdL2
	 LvJKxHJSIhureoGrITA/KfAvByfIbdG0+YpF3ij4OkAG7/5WWIB0C21S+OKR2FXKvg9VZ
	 PobOxebz+GbD499fufA4T1/gJayYnFo9tami9eQUNtI+TpvDkRb5It3xxqwZfIv5P6uXx
	 O0F8766lGmrAPgYUPTqHpDwprjopX5O470mQdys2y57y2g9RPQGKhXDf9z2P0gqsCF+nr
	 QIjtvnbPyUK162cASL2ERm4VLOmvUlWPwbknNqCRUtUzuLV0NL6ASLxkmLe4k4EqpSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=UxBMSnJT;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="iJQC/bbi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A6606A326;
	Wed,  4 Nov 2026 08:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=UxBMSnJT;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=iJQC/bbi
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A48IuYA1694646;
	Wed, 4 Nov 2026 02:58:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=81pZD97wjikj0MPeYagDnHXohaD5rmrxr59e/g3AD
	8M=; b=UxBMSnJT8y8br/PkxBsYkoDay/Eke9eyR0tdJRkzCzXgna6PiJ5SUtShH
	pM9YjlnZOu4MxwVlXQmJaWCEGMdehUxkUO12ZfpSTcMpAIMgCKRgJVNw9YgqzTF7
	GHC/cBNC71gWSc7QVE6fEbCBpMwlvivyO76Ak2KAd+FHHblDJZhUScC0rY8irVvZ
	Mvwg/w+fiTZHd0lodYLRKVRyZNS4zbxTpVwJO41kRALU+wu6ivnHODfe3vBKQ+P6
	ap6gyaLiYPC66Mz+Q5TgbXJuZbFJc7W6/xFhY7I5/32ZABk4qEjNmPgYwVXdiWPs
	iB5iqc3E7OZAooE024qSMhX+3g/Hw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hqqra35v4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 02:58:58 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II2eT9tOZ8bCN2u3Cn9Bt40kMe9q/j71b0TK9GUxBphZupfE0zsWgw30IuAEAX6dhHqKBh21pzz/DMrHkrzwCLNosBwwExi7xOJeODi64GC8GaQsVvcjSQGV6yTMO88qEhxOZdEOl0jdCJWTAmy9cPWV/Si905X5gb07tldRe/hW+JGhr06RrM8o+xbJbMdNYBZ1ubNRp6ju84zWdMj/Sl56QEG8Mm0Gnz6h3aKd55fiqQvNVjPhS+J0JpebqvzmyeTt62nGhhQm2HLMOk726PTk5LXfliHFIxLTLHHEonYdarzh1JA6b+otUCYFebgretMxj7HQwgxamnNjQMge/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81pZD97wjikj0MPeYagDnHXohaD5rmrxr59e/g3AD8M=;
 b=QiTUAQlyhmV+aNInp37tg3XsvauuRKvOsYj3ZN0jnkfptKjZwXIdfPG34t+9e2iUCmK3v1YluhQkZ9iSd15xW/b4y9vY0CWF3zB191J4Tod455a0lkLbMSBX/TGfe/Hp3P8psyOnjJXnH3piqAwOXYskQB+GtcXKOdDtfwpXro356Zr+CoEIveBgx4gf8bqa3VvxT2VdSHMR1/dwGIM+kdiu9Xyt9h+Y2FAx9UQT8O208U4XGk4M/y+vHFxc5L73dMoOPhkGDshpbvoiytRwLVfyTk4/fJro4PxTluiFRpFC1hlfKs5qgzSXs7y1HiC3Ahfu46BkXC+J1l29Q65N9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81pZD97wjikj0MPeYagDnHXohaD5rmrxr59e/g3AD8M=;
 b=iJQC/bbi3uftlwRmlmcpzdbvx8Q+wkTFJpz6BZiQroCvnxrRKZXdSrckdC4/Ub4dLacSOx5fXe2NGAsDsYka3CEypmuL8L9I32I4IeUeu4ISG6mD6UcV9aeRwGnRtVmc3bRWFXgFqIwksgLOMJxeMRoXO+TNE6kQeCctt5AXL2M=
Received: from PH8PR10MB6645.namprd10.prod.outlook.com (2603:10b6:510:223::19)
 by SJ5PPFD9B14F409.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 08:58:56 +0000
Received: from PH8PR10MB6645.namprd10.prod.outlook.com
 ([fe80::8985:7ede:7087:7bd7]) by PH8PR10MB6645.namprd10.prod.outlook.com
 ([fe80::8985:7ede:7087:7bd7%4]) with mapi id 15.21.0546.025; Wed, 4 Nov 2026
 08:58:56 +0000
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
Subject: Re: [PATCH 2/4] dmaengine: ti: cppi41: Fix register access in
 suspend_late
Thread-Topic: [PATCH 2/4] dmaengine: ti: cppi41: Fix register access in
 suspend_late
Thread-Index: AQHda8rleXaL8rt9vk27BG1sL1HeUrcdndiA
Date: Wed, 4 Nov 2026 08:58:56 +0000
Message-ID: <08054438-193c-4d08-8680-40cda7806baf@ti.com>
References:
 <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
 <20261103-v7-3-topic-am335lpm-cppi41-v1-2-d7213446c5f5@baylibre.com>
In-Reply-To:
 <20261103-v7-3-topic-am335lpm-cppi41-v1-2-d7213446c5f5@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR10MB6645:EE_|SJ5PPFD9B14F409:EE_
x-ms-office365-filtering-correlation-id: 0508948a-389a-47f6-714d-08df3a51dbb8
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|261102123227099003|22082099003|56012099006|38070700021|4143699003|261021121427099003|261009223027099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003;
x-microsoft-antispam-message-info:
 vzsdsdiUO+ScTLcG7Q7sSGeaCKEhTB0fCazQqoeys/vJjyj6CXWS3oKF27dd0r/5ri4oGRmXJ32JxfWUcfXM6uyaHNYsZK01lSvyxTzoQ4WKvhoTvMCcVDD6mRoI5jQmW2TcB3sQ8/E4BE4XiY6GnEhxQh8k9o8uTV0RRhqASk2ZPn89xM8WAMzBKlaWI4S5PGLa/rSwJ9YLVTp6QY2x3XQLrTPqqP6U6RMfS2VeTxMsTEAI57h0sA8YugoZfdkRDYE7fCU6HyJW1PF/7nNELbz/WEFINZNFefwlXvg7KupqfLmbfmYdV1nq1GcEwFNeckXBmO9Ii89VC3NbgHU1PSavBSF814qvx7BlpRAvljAe0/blFVlapzchmFg+D9H5q/B+M8bXDxi4Fg4L4mk+2mANzGYEfCE++EqHo0/SPWJ65O27zhdNwOcaFwr0L+nuQQYmR5veun7XMjLYAJp9ynsNf/BP19WX6g5Jx33Z6QnYW08i7F9nBbdv7ye0ojvZLmKyugM/cQoMn/WJSUy3SVTCGf2IlarsMCF5x4spdeYEkmuKNqyBm3L6Y1UYCQhHgZssAeZfJjZiHWOvlrr13jaHC31O7BT6x46AjR278SBZPSrCd3TwN2Qwglh0CP3OkRtaimKhBc3/bd/XiEqDTM3rL6PwV6CLeJ2DhMqJkUseol+tbVyAUYLRdGbJefcOip3g29QDwLUDFB6T4ei3tnIceoNVPGpGNyIFxvyWPVA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6645.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(38070700021)(4143699003)(261021121427099003)(261009223027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2pucVNSSHNUV1pqYnArVTllTTU4M2l2bzl0aGZRZUFJZ1Mram1RM0psdWdR?=
 =?utf-8?B?QkY3REFwWDVkcGlOK1gzSnpZencvenFpVG9pb0Rqcmd5U0VIVzRnbTNoMlUx?=
 =?utf-8?B?OEdoeEFVM2lsUlVjcldMTEcyQ2RqNzV1ek9kRkErTHFONktkZzdvUWtrWjdo?=
 =?utf-8?B?VnhrdlhJOUcwVlZHekg4REtjdlk4bTYzbmxhUHFJRCt2bzNMVmNBZW9MMEdQ?=
 =?utf-8?B?MHBzVmlJTEpKMm1UVzJacG5uMlozMThGbkNYOWxvVkdSRVI4UEdjTGl0MTJ1?=
 =?utf-8?B?WFVWWUlBQSsrdTFrSnora1FHdWhJampMZk9aOWdJaGdsMVZzbFl0bzFKN1VL?=
 =?utf-8?B?bkR4ckcyTjlPaWN6Ujkrdm1pNmluazgyODI1dCsraUVVaTJ4dEFrbjZhd2wx?=
 =?utf-8?B?Z2VVWnBBNEpEeEhVUm8vc3k1Nkk2Wng1Um5lSGVFczdrY0J2OGlDVGtTbi84?=
 =?utf-8?B?ektwM3pIcmEvN1N5TW9EUE9CbUpwV1RLTHFZZEJETGUyakVWY2JBMEZTOGZ6?=
 =?utf-8?B?THB3ejZxNjBLMndCRGxWTFB5VFMzWXo1a0g1QUFROXY1U3V1K0xzUFRMTm5W?=
 =?utf-8?B?VThzSVRDb0FENHhVSUpqUlZPd01JeDFaUVhrVEp2WWxSY1hSWmxjUDhRazdz?=
 =?utf-8?B?K2RFUzRiUGVYK0N4bUJJdXRsTTg2VG5vT3IzWE1wSUptcUUxd2tzSVRzdE1F?=
 =?utf-8?B?QTFuMkRqbEJTVHVjazVrRFdPcXFOWWZIQU4xeHd1UFlrZDhJR0F6OUo1ZHM4?=
 =?utf-8?B?ZFZoTFBXVXgraWlXd1pEdFdLMkJoNmxEdVIwblBLUDVnVFB2Ty82VjVaWGtH?=
 =?utf-8?B?dHZ3UmRVcW10OFNoWTl4NUtkMGcvNFA3RmdiOFhIQk5NL3lRNFF5MXlxd01u?=
 =?utf-8?B?aWhOd001V1dBZS9DTVdyU2c0NUxxTWVZb3U5LzBCUks3WFhPSHlLcE5obXVM?=
 =?utf-8?B?Q1J4TWF5MmY5b1d6VVJYM0U1dS9KVUdIam5hSjY2VDNiMzU1S0tzMHRsTkZC?=
 =?utf-8?B?NXFhd2owamZVMG9yTXpOdm03M1ZITHJDQjJyZnNLdVRhb2N2WkxQOXZYV2Ex?=
 =?utf-8?B?V0pQcWlwNVV4c3krT3RpY0VSUlhzVTBKZVlkUE10QVF6SWl2bU0reUtuZzh2?=
 =?utf-8?B?S0tZVjZYNStOMms2TENHT1liQVRaWnRhS3U4VjlYeERYQ01HcUcyMTZJVDRK?=
 =?utf-8?B?NGdJMGNTSllYbkc2RGVRM3lSSFJwby9jZ2pzTy9HMUlHN1RiMFc4amwzVVho?=
 =?utf-8?B?cWpyTUpRR1JBTCtSQ0Q5K3gwYlVYN0dWL1JvOTdFNEwvYnJLdzBieEdxQnJ2?=
 =?utf-8?B?bEhoQ0xzL216U05HU0x3eXd2QWhvLyt4Q0xqL2piTFN2RXBwUGVUM0k2Rnhn?=
 =?utf-8?B?UDNCQWsvQ1hLamEyMnNCdG9DdzBsTzlINE9wN1pyUE1aS2ZYZ0NoNnhwQjVx?=
 =?utf-8?B?eXUzbDhIdlpoQU1KTFpLYjNHTnFJUFJ5c1lXZlRCOWxkeDVJMWZGSEIrZ2Vt?=
 =?utf-8?B?MDNGR216MTlzNHBHaTREcHcxaEgyVENxRjAzTmtHL0Q2dTJIeWNSK2lsVEtQ?=
 =?utf-8?B?cjJad0dmL2N6UGpCQ2pKWUwwV1V5VGxUT2RLMk1COG90OUtIK1drUTNkTjdn?=
 =?utf-8?B?Q1lya3Y3VkxTL0Y4NFBWMFV4VE05RG84Mys5VHNac0RBZ1lodVZOOVFhM2Fn?=
 =?utf-8?B?eXhiOExnUVNYRkZ6Uk9kRy9JYnVaaUpTdnV1Vlo3RTloZy8rYW9ZMU5PZTk5?=
 =?utf-8?B?dmY3S2o2MlczRE5jM0h4aldJZURZcmlDOWpwdE5TWEo0OGtIcU9OWXhIbkhT?=
 =?utf-8?B?ZzJFaitZcmJNZXJGQmR2M3FsMitjOFlNTlRuT09KQ09UdnRJTi8rSWIwTjdX?=
 =?utf-8?B?L1BqWnR0UyszS1pybUNWOFArb1RWWUtML0RBc2duMFY5MEVKRVAyWlRYdjg1?=
 =?utf-8?B?eEZBcmFDU1VwTXZ1ZlFlUHZEZHg2bHZWS2ZsOS9HamgvUmI3WGtxdXg3c1pP?=
 =?utf-8?B?UGhTbm9waEVTWFRpaXgyeFdFQTF3dXk5VUJnVHdURlNLQllnOUZ5b2Nza2VG?=
 =?utf-8?B?elFuQUI5SU9jc3UvT0J6V0J5TUYvTG5GOWttenRPcTUreitNMUcxd1BjMWdt?=
 =?utf-8?B?KzZsRFRUcWVmUG1wdGRGZTZjeFZPTWt5K21OS1plUUV3S0djRTdhS042RmpG?=
 =?utf-8?B?ODFBSlZaL0czK3ZhU3JheWJZajEvWDB6OG9jc0NQcTRYUDBWNitPdVFzb3lK?=
 =?utf-8?B?UnNBeTcvYkxWMFp3TG9XMzNrdysxUWtBdmJzK1pJUkdDRytpelFqWmtMcWZT?=
 =?utf-8?Q?0nyIqlIGqKNFB/lEZa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C19854EE0D571F4EB5494B3081A2BFF9@namprd10.prod.outlook.com>
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
	zc2bD4+MfcZFQQEehYeFBTSYI++ne0LkeV4swlLBfE2nNNy8wCiJ3tJbLqkG7pQmbLKb2VFK3lfmVTWAkPR2/kg4tkgk6QYPplecgs8vqsET/oawsDOhlrzEQONa7WS6D/Po1daRp0cuyslnFIPWhewFODlTRV956BxcscABW+LYjLbfkM9KyblMY61lRp8cYvKBhTA7ilnouW14/mST45WMROnfu9IbTL1lR9FveyTN1TdW1Y0Rk13McFZaU/0MDeME2egBn/PV68RT2RF7KWYRiWPvB8gvNvsKupa0gUhinwByUnAjWZmo8lRNT9RoN5zdo+j3WCEURob2WxGWvQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6645.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0508948a-389a-47f6-714d-08df3a51dbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 08:58:56.2617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhOzcbG5jCepDLElJpGIaWsf7j2YGjAugQTK7Skj6kGcdq7OP2VlCikfcfaGBOF5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD9B14F409
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNSBTYWx0ZWRfX6+m3s/dXDy71
 FKW5TtZSu93+FxbwY7HpRQd3P6GNdDaO/ymw+MFhVRDzwGwDDJX2EyrHh3DbHsbHMXhBrkOTNeu
 slJTJqUnq+Ecfwh2IP/EDvuEB16PV+U=
X-Authority-Analysis: v=2.4 cv=F9TC5ahN c=1 sm=1 tr=0 ts=6aeaf3d2 cx=c_pps
 a=B1kIKGfTVomdQYahC0fm5g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=p0aXHUFv11IBRqPRGSAA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNSBTYWx0ZWRfX7lwCOtXSxRDE
 9Qhict4L9H9CvFVMuXSy1KKyWO12aNAztYJy14oEw1IhASBmUhzdUe0kcRSu5cYklcrdyAtYDYG
 tCXzj6tVHG5gxmw2hW0uZzPXNGrdVVnLw50/Zyv+aQ5TLiDtVDUdYqLFtISEU1CQ6NyOVnqtvJ/
 9uGTQ8VOun+jd6PFBkdszuzGotrzWqDsBtHy5HrdQCpWfxf+guppaHSJvHszs3+MWhHrRwtsBTS
 ByBUz6MksLD2eE3dxQNxVbLugQYJh8jTudqk160EQOoRH9UQGvQi4rfh81iRsZjltZqAvuxAJkm
 tsAMKML62e8zmUDj2m0BOoihs6SNPCccEr55K79GOrEk9why78HXH761+tHekTYDJw5q0f64Qav
 wub9F5zpmaK3tiA4sUQT4PcqmAJeg5JY2wqWsfMyoXwVU0lFaeAdnwj/vgF1W3znZjM94RkMnCn
 ysmneOs40QCHJkmKkDg==
X-Proofpoint-ORIG-GUID: on95LybHPkkUQcrJLCsxDrCaUDGABnjC
X-Proofpoint-GUID: on95LybHPkkUQcrJLCsxDrCaUDGABnjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040035

T24gMDQvMTEvMjYgMDE6MDcsIE1hcmt1cyBTY2huZWlkZXItUGFyZ21hbm4gKFRJKSB3cm90ZToN
Cj4gY3BwaTQxX3N1c3BlbmQoKSBhbmQgY3BwaTQxX3Jlc3VtZSgpIGFjY2VzcyByZWdpc3RlcnMu
IEhvd2V2ZXIgdGhlDQo+IGRldmljZSBtYXkgYmUgcnVudGltZSBzdXNwZW5kZWQgaW4gd2hpY2gg
Y2FzZSBpdCBpcyBub3QgYWxsb3dlZCB0bw0KPiBhY2Nlc3MgdGhlIHJlZ2lzdGVycy4NCj4NCj4g
T24gc3VzcGVuZCBkbyBub3QgcnVuIGRpc2FibGVfc2NoZWQoKSB3aGVuIGl0IGlzIHJ1bnRpbWUg
c3VzcGVuZGVkLiBUaGlzDQo+IGF2b2lkcyBhY2Nlc3NpbmcgdGhlIHJlZ2lzdGVycyBhbmQgY3Jh
c2hpbmcgdGhlIGtlcm5lbCBkdXJpbmcgc3VzcGVuZC4NCj4NCj4gUmVzdW1lIHdoZW4gcnVudGlt
ZSBzdXNwZW5kZWQgaXMgZGVsYXllZCB1bnRpbCBjcHBpNDFfcnVudGltZV9yZXN1bWUoKQ0KPiBp
cyBjYWxsZWQgdXNpbmcgdGhlIHZhcmlhYmxlIGN0eF9sb3N0LiBUaGlzIGtlZXBzIGFueSBhY2Nl
c3Mgd2hpbGUgdGhlDQo+IGRldmljZSBpcyBydW50aW1lIHN1c3BlbmRlZC4NCj4NCj4gRml4ZXM6
IGZkZWEyZDA5Yjk5NyAoImRtYWVuZ2luZTogY3BwaTQxOiBBZGQgYmFzaWMgUE0gcnVudGltZSBz
dXBwb3J0IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
TWFya3VzIFNjaG5laWRlci1QYXJnbWFubiAoVEkpIDxtc3BAYmF5bGlicmUuY29tPg0KUmV2aWV3
ZWQtYnk6IFNhaSBTcmVlIEthcnRoZWVrIEFkaXZpIDxzLWFkaXZpQHRpLmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy9kbWEvdGkvY3BwaTQxLmMgfCAxNiArKysrKysrKysrKysrKystDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL3RpL2NwcGk0MS5jIGIvZHJpdmVycy9kbWEvdGkvY3BwaTQxLmMN
Cj4gaW5kZXggNDU4ZDIwYjEyNDYyLi5mNWE4MjQ0MThmZTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZG1hL3RpL2NwcGk0MS5jDQo+ICsrKyBiL2RyaXZlcnMvZG1hL3RpL2NwcGk0MS5jDQo+IEBA
IC0xNDYsNiArMTQ2LDkgQEAgc3RydWN0IGNwcGk0MV9kZCB7DQo+ICAgCXN0cnVjdCBsaXN0X2hl
YWQgcGVuZGluZzsJLyogUGVuZGluZyBxdWV1ZWQgdHJhbnNmZXJzICovDQo+ICAgCXNwaW5sb2Nr
X3QgbG9jazsJCS8qIExvY2sgZm9yIHBlbmRpbmcgbGlzdCAqLw0KPiAgIA0KPiArCS8qIFJlZ2lz
dGVyIGNvbnRleHQgbWF5IGhhdmUgYmVlbiBsb3N0IGR1cmluZyBzeXN0ZW0gc3VzcGVuZCAqLw0K
PiArCWJvb2wgY3R4X2xvc3Q7DQo+ICsNCj4gICAJYm9vbCBpc19zdXNwZW5kZWQ7DQo+ICAgfTsN
Cj4gICANCj4gQEAgLTExNzEsNyArMTE3NCwxMCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2Vk
IGNwcGk0MV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICB7DQo+ICAgCXN0cnVjdCBj
cHBpNDFfZGQgKmNkZCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgIA0KPiAtCWRpc2FibGVf
c2NoZWQoY2RkKTsNCj4gKwlpZiAoIXBtX3J1bnRpbWVfc3RhdHVzX3N1c3BlbmRlZChkZXYpKQ0K
PiArCQlkaXNhYmxlX3NjaGVkKGNkZCk7DQo+ICsNCj4gKwljZGQtPmN0eF9sb3N0ID0gdHJ1ZTsN
Cj4gICANCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiBAQCAtMTE4Miw2ICsxMTg4LDkgQEAgc3Rh
dGljIGludCBfX21heWJlX3VudXNlZCBjcHBpNDFfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gICAJc3RydWN0IGNwcGk0MV9jaGFubmVsICpjOw0KPiAgIAlpbnQgaTsNCj4gICANCj4gKwlp
ZiAocG1fcnVudGltZV9zdGF0dXNfc3VzcGVuZGVkKGRldikpDQo+ICsJCXJldHVybiAwOw0KPiAr
DQo+ICAgCWZvciAoaSA9IDA7IGkgPCBERVNDU19BUkVBUzsgaSsrKQ0KPiAgIAkJY3BwaV93cml0
ZWwoY2RkLT5kZXNjc19waHlzLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9NRU1CQVNFKGkpKTsNCj4g
ICANCj4gQEAgLTExOTYsNiArMTIwNSw4IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgY3Bw
aTQxX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCWNwcGlfd3JpdGVsKFFNR1JfU0NS
QVRDSF9TSVpFLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9MUkFNX1NJWkUpOw0KPiAgIAljcHBpX3dy
aXRlbCgwLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9MUkFNMV9CQVNFKTsNCj4gICANCj4gKwljZGQt
PmN0eF9sb3N0ID0gZmFsc2U7DQo+ICsNCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiBA
QCAtMTIxNyw2ICsxMjI4LDkgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBjcHBpNDFfcnVu
dGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIAlzdHJ1Y3QgY3BwaTQxX2RkICpj
ZGQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4g
ICANCj4gKwlpZiAoY2RkLT5jdHhfbG9zdCkNCj4gKwkJY3BwaTQxX3Jlc3VtZShkZXYpOw0KPiAr
DQo+ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZjZGQtPmxvY2ssIGZsYWdzKTsNCj4gICAJY2RkLT5p
c19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gICAJY3BwaTQxX3J1bl9xdWV1ZShjZGQpOw0KPg0KDQo=
