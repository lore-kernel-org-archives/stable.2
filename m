Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794448225;
	b=RQpJBbLBiKa6FZ3JaGQZIEzbyEZgzIRQvk8vqExnwYgTxkpGVW7o+RwlUCdoLA5BigU/
	 diSJjPFP+5BO1WfSCJ99CmjQW7LSw5CMXCH2qTPS9mO0t+d3KqPL/8osdNxNqCAjOQCBa
	 blSr1Ygm2hPbY5ftFMiq6v3XFQyHVl1UyaVmulzksVG5rC/JbvJ2bjTdMxfDgus95uRrC
	 Ja9/Ujl1wNZbBx5SdyW4pgmcs6o1W+ewcHn3LVsaAHDntMpUaH7cPGT4X2Yp/vG1FGHGH
	 NACRIUdgN+/puGLWfou4R43lLj57aN3IEYGKSdnG5SSkQrLCPITzDoceo9eGCmnLmeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448225;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:Received:DKIM-Signature:Received:Received:
	 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ATZ7yT27Uwkjj0FEwMNT1sy966T/QbEL7RvgBl1JSFA=;
	b=EgHvSXFEyiuUd1T4CT6p6AUgxAQTkwSRXfsYZkP81cIEqiptMHfK2m2BrgTaFIbFQqyG
	 o1Ab8uOE4ZBbDmikLlwhgAI1IUNwQM8hz6A1cqw0sDrieadKDGFsZvZlRCcjjB8juPFCa
	 jNqMNwvDVFibD+q6/ksfDD4/WQpT/wY5yVSG1fN056nMKHHrNtMpNNslIiMbnPAvN4rsL
	 Np1th9wBMCpSGecBYtL31ikTHiDk+Y0ThjJSGQOQ9u6I387ZTIyDjnAoLZ4d8IlPoyZtQ
	 VEa886rXbf85ICV4z1OdBAcDZgkiXPbQqvDe/0b3qJXbv/u08m23lSjLe6DWwYAP23w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=unUWscEo;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b="OcadH/yB";
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=I9OaWA3w;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CC606A31C;
	Thu, 12 Nov 2026 01:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C8CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=unUWscEo;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=OcadH/yB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=I9OaWA3w
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMbw3o2518959;
	Wed, 11 Nov 2026 17:50:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ATZ7yT27Uwkjj0FEwMNT1sy966T/QbEL7RvgBl1JSFA=; b=
	unUWscEoX9LWnpNRd1Wc/CGP6k66ozxxHu0evCloMZlHqbcSQ/K6b6ImUi4lEe9S
	zq9Qu7wmLDV3k+ijUZUOaVXKYKEaGpPdmkOkikdRdT2Hn4eEyhgE90vIMHDfLdCE
	ir6UKTcZ7MHZmGQVerGGhH8tY19YS3WD8fxM3ybrTWchw1eF5VMYFxsu660kufep
	Sep6//jIt3KepA/nM3VEsLaWqNXu/StoAGuH9PoQ8k67Rxy8zQJp/4HOg6a2yyBG
	BAK8cqpnM+R4Bhuv82hLYtktHJj9ME+/49ow2UHJpYUndM/DmcwpRdVkySEM/Eho
	KV+D16czdVGlnaMe5w7fJw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4hvvayu94r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1794448221; bh=ATZ7yT27Uwkjj0FEwMNT1sy966T/QbEL7RvgBl1JSFA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OcadH/yBPm9cw+MTI1EwLtMnChnAjhFxxPk7qPCTCa3yMBsu8muD5gxeIci+3kF+O
	 1D9cqFSNO5SO+pVTtqCnvi2Lsr6RGMRDbYs0HcX7RNH1rhu7yro6yp0tcaACl6glqk
	 fDOxrOFBQr5UYNN8jiD3ScvgKDvfRVVf0WhVylpi5qPndi9TQ90YRzRltl5oVixQDg
	 zr2EJ2i8i1Vtgms+QQJIE5QLqVaMCdNJWgf0bxnWILi5FovT3qzICCw8dM9gLa3deN
	 PqR8qYjr469yc//cGIPFuFRBx3vBe1n57GgrEPAd+4scq12L3bAZoBEL+eD9jhq7g4
	 KQmu+abPVcREg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1073E401DC;
	Thu, 12 Nov 2026 01:50:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6CE76A08AD;
	Thu, 12 Nov 2026 01:50:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=I9OaWA3w;
	dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com (mail-sj0pr08cu00107.outbound.protection.outlook.com [40.93.1.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A28AA2200C1;
	Thu, 12 Nov 2026 01:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwJpycdBSgmJGeA6NDRm+1VsxOQ1JAKFB7jGCLlh9HZTFlduhH4epWxaBX8eIGVtIZMd2XKWO4molSmTKXUfo6CZaj46XDPBepjwhs+MEGBPoSeKc88UxUaIg6F17rxqSM9n4sRzbHswLgb0HwMpWcQ6PRDR+a3kc5zSlyD1I35/TTe6lYL0r4U1DlqoQvkNIboHv/QDWknBlooCfljjAwOLWXHt/DzLiQQSggL9CPjAxzTok6dS6pTi/3eDnBY65k/u6sfaA+sxBkyEkM4WBul5HV1geiJxdls2Cy+Ow7E8cui9DyVCL6rESc3fiSqxIH/XjlLA4WC7Ac7G/VYiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATZ7yT27Uwkjj0FEwMNT1sy966T/QbEL7RvgBl1JSFA=;
 b=gResvrlET70C1d0KCeI7JMQKMMcXa27pUlcKBXR/a8LLxw3srCd7WPKuzArHH0FL0qANn2gI2mEsIIkFkZiVsIKFSBjY/tmyDcQcrwn6t+WqiYkJYgPTfKJ4a90+9kPzf9eXZNkozDrWrAi+/R9e8CLIF7mWZEoG0D8VMdTdfRFVs5pJoZu5jKyOb9BPywO6l3/lTvc5TQX9139j23HNQC1kU77+FVrrGPSnlcab+FCb9PVZx2xH8f2IbdqyG730qpRVYuIrtyrfzzW1VVEpcy35IrfHU2ckySsP2xuEa2nq0jex0+LBiicganal5H5pcep4o4IcUH5tnl5swKz6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATZ7yT27Uwkjj0FEwMNT1sy966T/QbEL7RvgBl1JSFA=;
 b=I9OaWA3wWG88VwXo7dhLubcoct61zaIKjrvUidNAXtvUGK8FfAQ4c6U5iIPb1PGsjVW7DvLTYk7jcT31610A8TQxYsdS4nvQZrl5+UrVbZYBXvQ7npn96dHWKnUerfxKTwvdPL9qP9EZd4o9mjVSBeuBO9yO1hpR/OTtCqWpiZ8=
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 01:50:15 +0000
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7]) by SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 01:50:15 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "zhugl3@xiaopeng.com" <zhugl3@xiaopeng.com>
Subject: Re: [PATCH v2] usb: dwc2: gadget: fix off-by-one in ep_from_windex
 bounds check
Thread-Topic: [PATCH v2] usb: dwc2: gadget: fix off-by-one in ep_from_windex
 bounds check
Thread-Index: AQHdbNi51TbRnvyVuk6okNNZpBaOALcptqGA
Date: Thu, 12 Nov 2026 01:50:15 +0000
Message-ID: <avUbJaex3ma9B6Gr@vbox>
References: <20261105034946.20566-1-fangxy@xiaopeng.com>
In-Reply-To: <20261105034946.20566-1-fangxy@xiaopeng.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB7473:EE_|IA1PR12MB7687:EE_
x-ms-office365-filtering-correlation-id: 60dbc202-7fce-4b58-17b4-08df405f4c40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|261009223027099003|4133799003|11063799006|56012099006|261022115727099003|261028144727099003|261021121427099003|261021130227099003|261026135527099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261022113327099003|261022105027099003|261021135927099003|261021133027099003|261022075727099003|261026130827099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 dUWWgplzd01mPdYvCmTPuxNWOgjqQiHV14chRtDxyUQ3GSlvBRfvW6gI8BG/qVje6OieOPivaHxVp6HJ3AWNu4S59RQ9bUyB4mEBrU14wWTPrWuljcxyjWhIcIV3SsX71FGBFU8KMSq8ByzjtKdptQM04juE7GkHSjcImmOgGsYARG/48h32Cdb2GMjg2+sD4YsF0LJz98/8iID3k7mc3r3IXlBFGzcZ99iIsGMFLk6bXd/86S6F9FKnryAr3ryK5NNsusZob7ZImhvOWbDKs1lg+f0D8ywYSTJTVLNT/teDZcKu9awRdz+bD0GJcVXY6wJz3gV8W3ChDzjrAcT9HCOLukToLg9rxWbHOQ4Asl4RdJlJe33vE7rsn33GI8XRN9mIuCDPXGOCWUEKvrZ7/jPT5P4BDf8RPuE8lfahAib6R3hZ4y/oMhVsv2ztAIhOIwoXDxKdMgbbPXkZExp19/eqdX9WNXr4xDcEHQ/YEGWg4S6lqt1NzaRu9/XVMAmQTEgx2nc1bOLVXlZyMR/yFnx9Jl1MkchVeStwWohIxkXnrYy2DeggX0eWd8npdLhzKuGACS0TkeDfKY5qmR3t30P0WxG3rRcCtHIsrcy/VeEkcgGg18xMqrYuSyDnggpJiFEGnrpo5Ur3IDHIIig462t/jNuC8yTQP99Wtl7bzdA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(261009223027099003)(4133799003)(11063799006)(56012099006)(261022115727099003)(261028144727099003)(261021121427099003)(261021130227099003)(261026135527099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022113327099003)(261022105027099003)(261021135927099003)(261021133027099003)(261022075727099003)(261026130827099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjVtNDhGamZoeWhFYTA2NE9KbnhZdjJ3S0RYdTBrQ3Z1a2p5MUExUGhLVUJh?=
 =?utf-8?B?UzJ4UElsSFcrTTh2TU5NWTlDK1hHTmIwQk5rQ0UyUmpUY3FRNWxmaHRmZXhM?=
 =?utf-8?B?YzZ2bGpVUzdNcDM3cFpINVNOdElEWFRtVVBVa0YwYlpLVjdSeWFHa29UbUM1?=
 =?utf-8?B?UEhSaDFnWEoxbnloYUVDMG9wUVYwdU1RclgzVDIzTEZ4azVTRDJ2ZVJ0V2Ru?=
 =?utf-8?B?N2dvTWdlRDQrVHJJUHN4cDNXeUFHWXVBb2REYytxQUZPQlNBQjNadDNnWXhn?=
 =?utf-8?B?eVVaSXR0a0s0elJmM2lOZ2xDS2V4M1ZVOXNVV2tYUTQ5UXNGL05jMCtiUjd2?=
 =?utf-8?B?Z0xlMzN3aFc5WldtcGdkaS9jcmc2UnN1SjFMZ1NPTjNBUndIMXh3QUF0UkNa?=
 =?utf-8?B?ZTRqNDdLcTM3c2R0TlB1T0h4RVViS2NYbGJGNTYwZ01XWTQ3RUg5NXp1emZ2?=
 =?utf-8?B?aHdwMStHQ2ZoTXJyR0t2VURHa3QxRU5UZkRpa1VEZTV5S1dNYkZjK3dhVm5L?=
 =?utf-8?B?Vk1qUHE1OFhyM0Zud05TMzdhaWN4OFBVUjB1SHpjb0hpaUhBTkUzK3pFYmI2?=
 =?utf-8?B?aFRZSWRydHZkV0crT1NvSWhHVFRVVGdkbkUxcTBPekxoRjBDUDdqR2ZXNGR5?=
 =?utf-8?B?OEp4Q1VUemkrclBFMFBTTkhVU3Y2VHhhL01IUENUTzVQRjVrZ0tWSElhY0Ni?=
 =?utf-8?B?d0VJNzZ6aWMyZ09EZ0F0V2R6dk9IcG9BaEozMC9aT3YxUzJBeG9UYkJZbUlV?=
 =?utf-8?B?QjhhNFRrMFRuU096SXVUV3kvSjQxbHUwUzFMRzl0ZTQ3RDcycHdsQTR6RlZo?=
 =?utf-8?B?WFpJbU0xaHV4YndXRnoyS2tjSGhLVnVRV1BuMjVNSnZhWGRnVTNtT2pWTWR6?=
 =?utf-8?B?NDAvT2MxRDZJeFRUYXVuemZYZnBIM2lZVzNEWTF4UVVaQmJQTVpkVTljdUVz?=
 =?utf-8?B?UjNjNFA5a2dBdmo5bW5MQVpHc09jMVlLOFVqRUlaTzlDRVVTMUl1bWVXUWxP?=
 =?utf-8?B?bDFqK1QwYzlVQXJBMlloODlCYmh6b3k1em5Eb0FJOHB5UnNyaWNwcXNUTjkz?=
 =?utf-8?B?RWpBYW9teDBFSlVmRnRNVEdPUjNiQ1FpTjVSOWwyWElISzFtaUtKYldOSUx0?=
 =?utf-8?B?cGpPRUJWMUhlYm5jWUZGeDVBOGFIM1NJUDhVUi9yZ1RRSDBOc1F6VFdVbVFu?=
 =?utf-8?B?ZXYzd1ovdmFPMDhkTVYxTzc1dEtBb012TkpoeWRWQXA1WXo5Wm5VazhpakRE?=
 =?utf-8?B?YlFOaEMzckJzZmVUcjdRQXJPUFBKMmdsRVNyZVU0L2dBN3M4ckNnaWZ5K3hu?=
 =?utf-8?B?YjlmVlNRMlV0dm4yLzRmaThJdm9zZjdOUTlUeGtzcUZpSzlKT0ZOUDhFZTdy?=
 =?utf-8?B?S1VqVWhoMHdUdGtKQmJycXlhVXRHbEJLSnhFQ3R5bklkUE9FSE1pc3RjSnIy?=
 =?utf-8?B?ZTJOQzVwYzltVFpHTEh1T3psekJIV2VESHlEa0pVRzQvQTE3bzc0OGhxRVdv?=
 =?utf-8?B?ZW0xOUo4K2RObHI4R2szWHoyNzdvN1QyQVhmbXlHZzFFeFV3Rlltc1dSZi9O?=
 =?utf-8?B?Z3BBckh1ZEd4cW1qNnJJVlZGWHlQOFIzQSs1b1R0Q0ZtamVEN0FUNGFCUlM5?=
 =?utf-8?B?aVJ2Rk42aHJOaUhFTFVtU1JNeVFaTjkvSkRGWVVUS21ic21JemJnZGJwZDhH?=
 =?utf-8?B?U0R1eHdrRjlLVFhYUHpnTk0yKy9OTjJRT3hsVkl6NTdBSndjdy9vd2toelR6?=
 =?utf-8?B?bWlOakdHNUhxam5QbkU3U2lmOUxEWmtGVUEzWUlUb2NDdkJzcnNHU1R6citx?=
 =?utf-8?B?b3ZZV3hiRDVKM2lKMUdsUVBRKzJ6VVNKaS9IWlpTSm5RRDBNVDd2SzJqcFgv?=
 =?utf-8?B?TjM2SG5tTWUzK29KOExlWDdiOS9uVm55WDl2aGVEWHEwWGpNeW1WSm5IMXRU?=
 =?utf-8?B?ei90emJYZGU4QzlZNGhWam9CWUtBcUt1ZEx4bkplMXBMeWRjVXU4MnpDMldQ?=
 =?utf-8?B?MkdxdkdDUnNDRXV5TlNqdnVEeU9hZjlEOURqbUlyQW5wd2FZdjdaMHNuZXh5?=
 =?utf-8?B?VnJyaEdhM3ZEdE5tdTZiSjJTK0tub2NYdnZPZzlVOFVEV3kyc0svRFVvNThr?=
 =?utf-8?B?RTVNQlFFSGRQUVJWTGJzZEUvaUVNakZtcW9yTE1EUFZXdGpVVlFud1B3SUlY?=
 =?utf-8?B?TTRTWFFaNXVTa1N0WEN6RGJvUFB3MHJiTXZoTkI2Ukp5VFdTOGR3YXBmMXU2?=
 =?utf-8?B?RHgzeFA2ZVF1a2NnZzRmM1MzR0diSDVnWDZud2F3SEZPb2h3VXo1MEh5NW9K?=
 =?utf-8?B?K24yR0c2ZlJVckUrNUNsS2JNUGQ0QUh0VmJtN2RjL2FyaTZxZWtBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EDFCC2F72D5AA42939216AED3845390@namprd12.prod.outlook.com>
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
	Uc5LyEarl111krkbMxamx5DemLkrwLetXqX1f+C8VvKe54D3KwD9dP8+c/H6p5kn7nrZey1X+ls15zurSz5xhTz7x/J6QYgtDg3D9oFQyV/lgOeGac3Ee1AQWDjr8Yk3uuNwLi2Gaahq0vlR5qvgqk1DIbT44w0/2OyeSc+6RUrbI2hj0xr+pshR37wDKTYKsmWEjmI1ZbAj9kuLiHs9gU7UTSinAD7gD18rxux/T1F2v4BL96qbal/jN2zyLjfVIAviVhHAz2peAWRPJsjpgg0F1rS/vr9ANFESNKjG/bCi0rrT6yZhyfoGBLkKv8lbHPEP6PL1hMnk2XgpDWBWTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s+Zco7tXHGdl3UYL9KfU6JMZgrzN61VGhJUfELhQf7X9BoZXAImtLgIETY+Kk7276+jDgnEJ7jxGKSZFTbo09PcwcbKgoG7jPGDr3N0AjxrocOxg1Rami7RVd8a3kqN5WNSWvJEZUz1jwNKsDmvnV52rUhMqUa4T2tuA3k0A2tSzqaiVdDuM+ix/gS56AdIEer/g3tU4H1EaZxtsgACp0SU679dMQES2/GfOmGPJHOFawg3WBmhah1v+cb2YCLeeMnRpg3yhIF9n9viQC1KfOPikonHyLBQbroqjHBWsIQ1+APrOY60KcWyx7UKEe3A6x8OTAqFUHmH6BOy0LNu7rMv6/zeTgUPXiofUMo0qZj7uKVdC/YdtKC1RDJwbZv1OiGvIB3R/bu5q7/cEPCyItyx+O7+y5PrSbxuAgYH3Ni5DW0CbsMzPbSCqUdNXmgEduHcVUhI7S1m1xzlhZPSE5FQagHg0+9jTwC301vU4ShlbBtYQBr2q0LhcBqfkChFqJwYJ4X0eYDEmUdvOFuL/7mbXrwopij/YOF0DwMrGfLzP0VugtTDT5nIHzG83pGPEHPKBxqMpDyn/Gz3DPV8YpFtwHBpARp+dIjKAvuvt+aO08j9tEgZNURV9uUbDZHvjVYo2yzytapHXYwJrbc/sdA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dbc202-7fce-4b58-17b4-08df405f4c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 01:50:15.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbjFXlMmidIsrzkaxHyCPwecLMDQmXHKrTcv8SA1ImeUgySdKvbIKhlJiqMtH3zhk5BDIgpqq0SANc3HJJNsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
X-Proofpoint-GUID: h-MH8SXpwA8qlWspafInPc0dRkWvhuKx
X-Proofpoint-ORIG-GUID: h-MH8SXpwA8qlWspafInPc0dRkWvhuKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwNiBTYWx0ZWRfXzVGBwfkl2BxG
 ev/aHVoa8GtyMQO666p8TRAZNlpUPFDTYiLe3q36XTDCus6GbyuBfmXzLzpXhOO/Gy8OqgG8AvQ
 suk8TwpjPJ7kI1Txxn26VELFIjryxJvujm4Bup7m+2Q5Hp6JLQ8D/bqYCDR2IvLcx9RoRt/BPIk
 2cBfcdfv7gtCI10nvy/K5+3Hx+FyWglLaYKcdHl7zdXrwDLAuaFw1+qqImaveeLUPvkPILvqK1s
 jSewN2LXx9pQKf03crR3IwM6qHZE0OMtfvss1q8EK3PVhkHl5NynkXhs4b82EPEWfFg2QqAJ9z2
 TaXwme9avVUjMFFOa776GhLGj8JeVTf+oA+rKpV2CZZfZFXtU9NutWAQQsSOpju0R3mCUpRyNx8
 RvNjzufTolznZh/qa2ZMgYsMJa6E4ZbLAdv/8EffpABI4m7d5kASlKmOQW+CUkxL0ARc+Gf/9r0
 3yT13mKo1k2m9GA1CSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwNiBTYWx0ZWRfX9eXmKA+5+bQn
 7612esuPeTjcepdV+igI928UKpCr3d796iaZME5VNYq2S0DA5Q5O8NHRNuL49GNDiuZnHLgpAwp
 Rr2dfEiv63+hqRmbM7MwXPQ3uCrAatA=
X-Authority-Analysis: v=2.4 cv=VNdIDNPX c=1 sm=1 tr=0 ts=6af51b5e cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=EgahoUkMAAAA:8 a=jIQo8A4GAAAA:8 a=gShKMJbaGX5h9A3A9I4A:9
 a=QEXdDO2ut3YA:10 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611120006

T24gVGh1LCBOb3YgMDUsIDIwMjYsIEZhbmcgWGlleWFuIHdyb3RlOg0KPiBlcF9mcm9tX3dpbmRl
eCgpIGNoZWNrcyB3aGV0aGVyIGlkeCBpcyBncmVhdGVyIHRoYW4NCj4gaHNvdGctPm51bV9vZl9l
cHMuIEhvd2V2ZXIsIG51bV9vZl9lcHMgaW5jbHVkZXMgRVAwLCBzbyB2YWxpZA0KPiBlbmRwb2lu
dCBpbmRpY2VzIGFyZSBpbiB0aGUgcmFuZ2UgWzAsIG51bV9vZl9lcHMgLSAxXS4NCj4gDQo+IFdo
ZW4gaWR4IGVxdWFscyBudW1fb2ZfZXBzLCBpbmRleF90b19lcCgpIGFjY2Vzc2VzIHRoZSBlbmRw
b2ludA0KPiBhcnJheSBiZXlvbmQgdGhlIGNvbmZpZ3VyZWQgcmFuZ2UuIFRoaXMgcmVzdWx0cyBp
biBhbiBvdXQtb2YtYm91bmRzDQo+IGFjY2VzcyB3aGVuIG51bV9vZl9lcHMgZXF1YWxzIE1BWF9F
UFNfQ0hBTk5FTFMuIE90aGVyd2lzZSwgdGhlDQo+IHplcm8taW5pdGlhbGl6ZWQgYXJyYXkgZW50
cnkgaXMgTlVMTCBhbmQgdGhlIHJlcXVlc3QgaXMgcmVqZWN0ZWQuDQo+IA0KPiBSZWplY3QgaW5k
aWNlcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8gbnVtX29mX2Vwcy4NCj4gDQo+IEZpeGVzOiBj
NmY1YzA1MGUyYTcgKCJ1c2I6IGR3YzI6IGdhZGdldDogYWRkIGJpLWRpcmVjdGlvbmFsIGVuZHBv
aW50IHN1cHBvcnQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXZpZXdlZC1i
eTogR3VhbmdsZWkgWmh1IDx6aHVnbDNAeGlhb3BlbmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBG
YW5nIFhpZXlhbiA8ZmFuZ3h5QHhpYW9wZW5nLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6
DQo+ICAtIEZpeGVzIGNvcnJlY3RlZCB0byBjNmY1YzA1MGUyYTcgcGVyIFRoaW5oJ3MgcmV2aWV3
DQo+ICAtIE5hcnJvdyBjb21taXQgbWVzc2FnZTogT09CIG9ubHkgd2hlbiBudW1fb2ZfZXBzID09
IE1BWF9FUFNfQ0hBTk5FTFMNCj4gIC0gQWRkIENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IA0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtdXNiLzIwMjYxMDI2MDMxMTM4LjM1OTExLTEtZmFuZ3h5QHhpYW9wZW5nLmNv
bS9fXzshIUE0RjJSOUdfcGchWm92RElnUkptbjhVeTEweXZMblpVVzNBX0tqYXRNQ09CaGcyUURR
Y3I1cFNUOV9tUlZrU2FvbHBBOEk5OFRCa2VXWTZwV1RvUkFkekhDM2pYS2REMFEkIA0KPiANCj4g
IGRyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MyL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCAwNjM3
YmZiYzAuLmIyYTI1Y2Q1YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC0xNTgyLDcgKzE1ODIs
NyBAQCBzdGF0aWMgc3RydWN0IGR3YzJfaHNvdGdfZXAgKmVwX2Zyb21fd2luZGV4KHN0cnVjdCBk
d2MyX2hzb3RnICpoc290ZywNCj4gIAlpZiAod2luZGV4ID49IDB4MTAwKQ0KPiAgCQlyZXR1cm4g
TlVMTDsNCj4gIA0KPiAtCWlmIChpZHggPiBoc290Zy0+bnVtX29mX2VwcykNCj4gKwlpZiAoaWR4
ID49IGhzb3RnLT5udW1fb2ZfZXBzKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIA0KPiAgCXJldHVy
biBpbmRleF90b19lcChoc290ZywgaWR4LCBkaXIpOw0KPiAtLQ0KPiAyLjUwLjENCj4gDQoNCkFj
a2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5r
cywNClRoaW5o
