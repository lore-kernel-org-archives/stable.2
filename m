Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794448003;
	b=N+Id6grKtR0LYPL/9U7itsyTvidzinQpOpL5qc6+Pj0TLjJz+oXm8dwZcjYiLevnj0w9
	 YDMHjrqyj3q2wiUICH9mqr05DPEtMk7SjdSCXaJ8AElzLtcFXGRQWXXoBa7USZt53u5cB
	 jQku7u/24cn3M+2FKDQm+Bup9aR+6xxE4wMBBi3yQYV8JRqbT7lyZxpLBPK5TnVAUKHtO
	 8NTWVQOC/N3dxLH5ux9RWmebwPrc/wzAo+QMTXL43QFjWaIyy9ZXnEmZGN3Op3q1u8NP6
	 VFI78P6UjPdWzTjRhSZ3xOjgQmZpgYUVCiOhHyNgIXOjfH5zBSxPFn1HW3JLPs2OP8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448003;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G598YiBQHDTHg/ER+K1erzS5wxMynH4i/o2kYN8iA+A=;
	b=N1RjcG09Ad8Dp9pENFjxD6QWHRm5xMu0dXuywuZqrV8yqwczdCm5Om/nDUEwytPVMP7h
	 BvfxQz8P4FS7iTERI0SbOS6IuJbj2JvObpjQ1lsFbEQnytRyoFI0gS6UB76FazjcaLGXy
	 z65DVUx3QDrE51+oqkifnAZHZ9By11WGUhZDjRrpmXzMt0VyXOdlCqyhpOr78XbdyXhQw
	 Cqjn5QvfYebY8BaBfKoRaX4RTAZPpnqmGRGCpyJt8DHTuzywJk2I16pRQCCeSVgqLn2VV
	 RHJ4TXZDfGL3i+x0yhSNo2LAoQeZ/rF3vqX9knL5FXtMouwZHBEXTwboIClxpHFuTyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=ncFdma6J;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=JIzcRn+P;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=er8C1wlh;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7A606A32E;
	Thu, 12 Nov 2026 01:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C7A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=ncFdma6J;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=JIzcRn+P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=er8C1wlh
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMbwpE1629435;
	Wed, 11 Nov 2026 17:46:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=G598YiBQHDTHg/ER+K1erzS5wxMynH4i/o2kYN8iA+A=; b=
	ncFdma6JUIS4BAWPncxPOSevDEj/8ukkllnUUBmCk6xnRNAeC2RfV2V0C+uTZpV/
	iqtKpMJZ6feMoUFadQ/LldGaUfauLcoenPPZo1+e/QbzvrIZOI69EWXRf6CrszoY
	tYlB3zj6paPw9RYnoZFr1u0grYkDpTtYlgV5+hLX9Bg9j17EWLM0ZnWELUthDljH
	jiV4SstJY+dvlrN4qpd7Q8VJx6qqKjstuRdGILpe8v2oOb5cquIA7RKzTLkOZfGU
	uqv9aHKFhBd3G7pEnx3d1RQV+B/22tUj9p9UZP3ARCA9Zo9l2u1jmmyNE0uT5Q4S
	n5woI5cMQI21uaI3wXdETQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hvv7x39g4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1794447999; bh=G598YiBQHDTHg/ER+K1erzS5wxMynH4i/o2kYN8iA+A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=JIzcRn+Pnz/We7E5mk/+6Yp9Pi2atCg5sAvS8xdQjRMz0pInRv5vJpVc4qiiWr1Oc
	 UhaykvgYgdSt6c9pduiw5E28H0b4kXCTfTlLP7hYQPgUURGejW8Bf2cBHANGIGY1Hl
	 kJ0f0wMu4DhpnudcfKU3vW69Rz4sllWf1Hig9F95ZkwCVD7x0KdcDo2l6I9hjkPUNe
	 NB7fWKkn30u7Rz41Cd6xH5x42SjzZ4vo3Sy79Ae4slXMdTTMQfD9I5VlxTK9QywKzb
	 F14Cx4mdeOw+61aMjFwhPsp4FJlEv31dfAteE6onerkgCevLm5GC0Owm6k0f9hyEPG
	 xxMBmwoiM9xCA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3041740183;
	Thu, 12 Nov 2026 01:46:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id ABD11A00B0;
	Thu, 12 Nov 2026 01:46:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=er8C1wlh;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00401.outbound.protection.outlook.com [40.93.13.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BD9382204B0;
	Thu, 12 Nov 2026 01:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZtfM6pkapWLJpx2xktGA1lDEQ56esQ/Vh5waLCgdIPHnWoAyCrRGKGlGCTzlEs2ma0qHlKuczr1Bss9PMQaD+rRzKf6Ymq0Hn8h6yaPLjhlvHXGMAfHiX0ehYfJ/eIiyaIBPDwnKJzMwFUicFPA/4I3rPlZJTkn5Qyo7BW/181vw0g6+8xyWdASuKsZAE2SDOwus+IOUVkp1Pvo+vOtqw3vVH3rW83/yDIhYqBAhFLWwpTZnzM1lBeukC4FwvdNeqivsf3M8zb2VgxNuuJbkIjd+a3jvaKX5wAImum4XaaA8d+cZSJDgTIdGTpKjF1/LD/RASsf9uicCPIM1DyAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G598YiBQHDTHg/ER+K1erzS5wxMynH4i/o2kYN8iA+A=;
 b=ECK5UJdDVO+hDKM1o7RMvcQXF1OeIg8RqJKeBemHhtTLWYyzdDXbDMMw7AJIyZq6eBFzc6awo/zSHoH9xjwfQYh21uoKYQKPYxoKQ2snOnF8Uuvfqa6dJ2cZOBxNqKjhumBpruoV7uZJKVlxJy/lIOXr0ZnkjKPUI++pDQK51VlzbfmgVcQINQD8AMG3zvhxpVksAi/AVlrR18bIXZlpeJzU4qwUdow7KDhzw+lEpb5oUer9AUCEbh3NQnfb9+gK0yghP0xTkagylpuw0Df6NuE7WdZ5nTZI5WoJ99SaILcihx848n+Vcy3MtFW5HO1J09HlcuS1hAORm+faUl2Hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G598YiBQHDTHg/ER+K1erzS5wxMynH4i/o2kYN8iA+A=;
 b=er8C1wlhj/XfYI4yWDCxQZQphrwiV4MBrc2cCm8DBer1fnVzyVqgYRujuTN08sRe+IR5BRgn40gHKz0QwP/QnLcAKcU68HMfflpZUsHa1SFf9/hprDLROWsZWYcZb8b8DYkaoxbZwvd5tQLbrVwC+yKdtfF6tbj2Qk3kyJYpI9c=
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 01:46:33 +0000
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7]) by SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 01:46:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Elson Serrao <elson.serrao@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Increase no-IOC ENDTRANSFER delay
Thread-Topic: [PATCH] usb: dwc3: Increase no-IOC ENDTRANSFER delay
Thread-Index: AQHda8FaAdOP4Fszf021zv0JTQvZ17cpt8YA
Date: Thu, 12 Nov 2026 01:46:33 +0000
Message-ID: <avUVrw-Wtr22ZS3s@vbox>
References: <20261103182953.3437202-1-elson.serrao@oss.qualcomm.com>
In-Reply-To: <20261103182953.3437202-1-elson.serrao@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB7473:EE_|IA1PR12MB7687:EE_
x-ms-office365-filtering-correlation-id: c5c9f374-e5a3-4123-28a4-08df405ec803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 qCp9XDMAppJj8fzGyKyi9d2xofnXHdVmQHUdcIQ516Em0UKRSY4QhhwoagkbGHu3cvnREXwLE9BVHN2uwlt5fqB+qKQ6MotGfxODqOhwRBkdChfdBNMcl05Ii/7QY0jzZiHmqPqO+brk39T2819VmpCGiBqLHvc1f9NfiQ/yUwUUit8vjSdFSPKi/ujJnaH9qLqT7dEr5avYUTZx13S1hostYaWMbaACDOzkQRsQobiep5EXFkiWaGphLHunSKnPKJlLiIrUqxAEpdo6kzOSkA1XVSxVgld46JsvpOOA80ctoNNyK7HzEfEWfW+IAR+0+pBThe+OcVdEHu4usG4ODmb9SQ+pC0OndOKtHmtfVJtWRkjVn3fMH1UhTyWEzTNnm1+cwRgROv6LqhyZ6mU6xnm6WgNUKCuwg8rDNBcXfmQm3ySH/Mt58sKa+BLFMTK21SNQa7eHZMhVPyEc8TkealIZZ8ibb0qqHHHVZ8qCdxspRUp0XTxmWvT5/4klTmDyTErotrg84BmEeflNmz/jk0ljlGHZ8ueD0OIGrVPXn8IAvG2qLqJUfkcWj0h6Qto5ZZ8+4u+L9iHKRGqlVrf7CzoRqtGO1bkmxm3FJd7a6S1Q6tqjbpjJG5rdrGihKQIC01xAX4bJuqrLpvEzcg0vmGy5GzpqZuxAtz0N9KCTAssBu0HHmJ4tb5q9ZK5NBDe2WXKrl+Dox27+Bbub/O3OLaphXqGUvANUGmHfhigFsUA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk51WGtVWDY4MXMxZUN3T3VIekFHSGM4S3BaSG5uRklIS0REb0FMWmszMVdE?=
 =?utf-8?B?R3cvazFZbE44UXpIYzlRR01CS005d2VUN0UyV2tEbVlnRTgxaU0zRXA1Uk9Z?=
 =?utf-8?B?WU16aE5oU3FQWCtEVnJYSjFxeUlCUXdFZUx3NjV2ME94ZDBVMjg0TVRQRElJ?=
 =?utf-8?B?VVdrSDl6L2dQVWVhL3dZRW1COE1obS9mbDlkQ2o4dEgxMTNzMFpIY1Vjb28y?=
 =?utf-8?B?ay9FTk84UU10ekgrSG5NNHJXUlUxNTBrR0ZCY3ZhOFNIT1ZYcTA2S2JxUWFa?=
 =?utf-8?B?Tjdja1ZxNkVsVmpVYVdZdzAyaVpNOGd5TmxvUFVCYTZ3bnczcHhlTEZnbjN2?=
 =?utf-8?B?bGxWUzJYTjNFZGR2T0Z5Ukw1eEJtVmFOVzVCdkN1WFhVL1JidDYwYm44ejNj?=
 =?utf-8?B?U3VsRnQyWGwwQm85TFFTdjFYaVoxOC9jVHd1QzEzTkMxYjMvckJzVXROUW5i?=
 =?utf-8?B?TGxNbVJkVnpNMm9Md3VBUncwN0FXckpFWVFHaFZYMysybjJMU3ZXQndvVVhG?=
 =?utf-8?B?ZnhmbmUyRVlpaEZCaVFZT3V0cFhuOCt1NjNtb25aYVhIUm1rLy9kTnlrTTVo?=
 =?utf-8?B?UkxFbzNYRFg4NGVTN0hzM25hUk5lTmRBcWkvU2xGVElFWnlVZnZ1TzI2K0Fn?=
 =?utf-8?B?eWFicmR1VUpybGhtSjhXWHVaMjZXWU1QVTVieDJGdDZINE5JYTlwOG5DbFBX?=
 =?utf-8?B?aE05c0JDNkJULzV2eUVCZ2swRjdsd0ZoL2VxaG1GTWdic1o2bzJpSE1DVkdJ?=
 =?utf-8?B?T3ZGNHh1MTFMZEpGTnM2cDdyejZKdkdxM0hJTG9WVytuZFdSaU5md0UyRnRM?=
 =?utf-8?B?eEY1Y1g0TjhVR01vVFpYaTZjMFdrTGRUUU9HSmJtTEQ3elRUVldFWVFMNmh0?=
 =?utf-8?B?ekY2UW5sc1hLTm8wUHAwVkFTMUR1SEZYTnlTcjlYQ2wyV1RjQlA2QitHMXpN?=
 =?utf-8?B?Ykw4YnNrTEpBeGRKN3pTaGFsYWlOK2haQVNzY1FUZkdsUFRyM20zWHgxVVU4?=
 =?utf-8?B?ZXJoQTkxd0lFeStaWXRmWFNDY21DSythMVh1aldNMEE5ZEVjUnlYeWJKL0Nw?=
 =?utf-8?B?LzNxVlFDb2gxZXQ0VGZRYTdXdjArc242aG1qM2RXSzNadmw3NllXUE5HMTVh?=
 =?utf-8?B?SWtMdkN1Wi8zQjV6KzBrb2ZKQkN1djZTUHlrQ2RqdGF0NnlscUxiNDYrcnZV?=
 =?utf-8?B?aFJ6YWNXbTJyNFo4SFpnMzF2SklFOWFZMXR2MFlkWk5rQ1dVMWZFTWJMYjFr?=
 =?utf-8?B?eFpHRStGblhlWmJsNWJkdTY0NUxsYmREUTJEalk2OTdqZkQ1U043bm8xd3lO?=
 =?utf-8?B?anJYUWUrdm9reTRmSzNwcjNsTDJmNW1WdDMrdE9kSjJhUDQyOFByVC9idVhS?=
 =?utf-8?B?c0pWREtkNGRUTlJvZ1FQSzF4R0h5eENIRzF1RlEyL0EyM1Jta2J6M0plUHEx?=
 =?utf-8?B?bHdpODRRK2lnbGszWGtLQW5XYXluK3ZNQkdyK01tN0ZCMTdiY1g4Z2VGWkk5?=
 =?utf-8?B?V2s1eENsYllKK2d0b3h1ME1XRWZGV2o2ZjFQZzZFSXpFWWdSbExlLzB0RlJT?=
 =?utf-8?B?NXRyWVE1YkhoQlhMNjAwOFZsdmlmV2Q3RGdrS2lHbFFBTXp2dld5OTNmaDF6?=
 =?utf-8?B?VE5tQzRtd01Mdi9JL0NvaS9XLzl1UkdNdGdHQ04xQzB6TkJyaklNNXNpRnQ0?=
 =?utf-8?B?Q29zRzJFaHIyUWo5Zjc5b3k3dEIxRHNtUU92bjZTQURSc3hlU1NOeXN3c1JX?=
 =?utf-8?B?cFhuRStlZXlXanI0RnlQTDhNY3ZpOUhuN0ZnNk9FSFdhVDJmMmxVT2VNSXFp?=
 =?utf-8?B?cEQ5Si80ODVTV0tBd2c2bElBbEwwcDJBWm9Qd3lPWlNvaUZzWVZuVEVVMWdC?=
 =?utf-8?B?cDBSZ2M5NDN0UThiRUt3ZVIxT3kwR3UwTzR3VlhOK3UvckFUSmNXOWZoSzZI?=
 =?utf-8?B?QS82Q25xNnVIVkdmV2MwUmQ3anFBVm9zaWE1RUduaUw1WkJHY2ZkTENORmNl?=
 =?utf-8?B?azgxSzlDUDFHV1ljR2dNelVHaEFMeWcyVzQ5RTNTWE1IaHlpQU82YUFVNFRV?=
 =?utf-8?B?NWpoNTFqM2dEbjR6T3RzUmxwMUVoNHpiRFJ2ekxoRFMrQTJZNWV1ZzVwelRi?=
 =?utf-8?B?enRKa0F4Rk5QSEIwL3gyc1FzWlFQbm5jc0U5T1c1Ny94OGhHZytxeXplSW03?=
 =?utf-8?B?MUYrUWY5WmlGTmhhMWUwMWphdXJPVThjRmxyNVVaR2Jpa1FLN1dqaFkwcHZ2?=
 =?utf-8?B?TkFlSGQwZzAvT09PbGZSOUk4Z3I0SkQrKzU0K0EvaWpQaDV5OXlQNWJhTDZq?=
 =?utf-8?B?bTlnbUN6NmNLZ0Q0Yk1uTlpmN3lVb2x2NGY1SmNFTHhVQXRhTUZXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <456FB04C8045744D8C7E24AB07572BD0@namprd12.prod.outlook.com>
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
	1yxSmbj/Z1CDf4iIOFRhFxBf8+ujwcyiEozT/ArtxTgpVCwkJHvv8OBLaueUWXXS8N2BRcavlVZgYxUe5Ck9z1sUX3G33Yea6Wb9E17aYqa3wV6BtBDYKNOOSfAJ9tSkwGe3NgKRC0aGrigmgSgXdWLVnyFPj2IZVHhzAKIiPOHGoDY109xCl6ax5p6sBXORojCc+6ACesdepcuyd/QL9UbYd8Ap960IypzusuCls+2bShYFbyayAOabhUEfSSXaIzI7Y6qt2ybTcXKs4MH4M1bGit8WQP4Wb0BcIGbMgHlIb6HLCCpQDBlXTOrDaxilArednjhvcwKyxJteoTaaYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s+AtrWSOQqJWZfF4CxJBNpU27Pmcsuhe+RFHpR7U7CvXjbt6E5aKQ/7h76G9ryAsyHqAnTZA2+aM0cDDKNcue6DXPJotVVf7EelLouCj5ovscjDjdUpJ7XNydRa6O4SUV1zX8+mnjTH8DoeuVAEh/HZ0I3RgPbdPuKOM4KpEPTpAmXTqtMcU8x1fkGVzFgm1bzlVDV24U/uvmhzO/RwzoB8arhFe4iJguyDevaW8t+ico/qajCgWYYRSWswCVrCUEDnlPqsCp3XM+YEpcXKx9f8g5m4O8ZtUegmIxGRoP3K/WIUCUUZ2CEmMjQsZwL8m3a0JBEXDYzZld8vTgEwgci45kWf8wCGLqivS1J+1nSimcnnAhzMbrXMhRxBYEtlk9+ecnI2RqV0N3XjL337FQg5CZiey3bX8MPwhe45L35bO3+VBfIox0x/XGnH7FuqhmdtiQwR0go4ixPzx7afral62v1jHoFh6ySvGcROpdSumPh7O1skl77wO4/hVMQBKUZGZDYjbGShIohnoBN9K9pT06SXnvJtkypvuQNiB/k4X+rSzWaJEVwOajWDc77oAzed0ds0MO+pAqnePwur5aH4B/Ig3UnAx+yTaPY+Pqs//SJ6Vs2+tRkHnJctN44GaGFNRVcv26Lg8xlooJu0KZw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c9f374-e5a3-4123-28a4-08df405ec803
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 01:46:33.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5ieb3Tulb7qPVwurr0TxZUizrdPSnY3lV7QhgiaxmuX75XNV3um0NrTX/AEuJ29IvX3DnChr6AsU0B2bqM4Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwNiBTYWx0ZWRfX7YdDsIFhwA0Z
 /XU4ZALlRuOiSNWyq0w7BVhaDs670Yv6tm69V3jSIAxF288HbE6qxRM5cSitHTL0oqwNeEelXNN
 xzJdWD8iNm/dOGzjXZ/ZAoPIsRDpNolt3zqrnSBKWh2bOlkTtBMpJIL/0QUunBHf34QvPL3V8l4
 MFaQCTnZz9pB99M2xUY2jtdvkhfLBCdqYxOgdNsc8zs2LXThI4LNjxY6bjt5q6WzPocpCVLWMhv
 ql9rYidVnNAUFCCf0C736glXZNiiTwts0h1zP9S5sKjiU0FgDFk/qX/Vx9d3LbVkmER+UAB77Qg
 H1LJJEV5QuSelb4jBYmj1K1vR+JCxoQx+Med4XQ+R+cW/1lm2Z9P0FJXDLMPl0ygqO9NgST4ipC
 HxIAjKPnC+d5OTB86SlcAwbYGTZurYdHh0Dnp3RG7Efr12DT78y/kAVztM8TMQ4MwofV866UWLa
 d5OVJ5SJmmUzyGdUcAQ==
X-Authority-Analysis: v=2.4 cv=IuaL47/g c=1 sm=1 tr=0 ts=6af51a80 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=upzDRpGYDquxAcmJVkwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: E8yvic-XlJO7wkRBKgH8RBvtydc5uUQX
X-Proofpoint-ORIG-GUID: E8yvic-XlJO7wkRBKgH8RBvtydc5uUQX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwNiBTYWx0ZWRfX5MlSMT0RrmQG
 dGuWzePRCtadG2IeAwpIQNGxiq5T6/FHUuEztgD2tPITRe18zPPlRXUZIANxlZyrVI2wRhzJCJs
 mqLrz9s+c7jlI+oDTiIYIEnZHqvhJdo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611120006

SGksDQoNCk9uIFR1ZSwgTm92IDAzLCAyMDI2LCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+IFdoZW4g
RU5EVFJBTlNGRVIgaXMgaXNzdWVkIHdpdGhvdXQgQ01ESU9DLCBzb2Z0d2FyZSBkb2VzIG5vdCB3
YWl0IGZvcg0KPiBjb21tYW5kIGNvbXBsZXRpb24gYW5kIGluc3RlYWQgcmVsaWVzIG9uIGEgZml4
ZWQgZGVsYXkgYmVmb3JlIGNvbnRpbnVpbmcNCj4gcmVxdWVzdCB0ZWFyZG93bi4gVGhlIERXQzMg
cHJvZ3JhbW1pbmcgZ3VpZGUgcmVjb21tZW5kcyB1c2luZyBhIHRpbWVvdXQNCj4gZ3JlYXRlciB0
aGFuIDEgbXMgZm9yIGNvbW1hbmQgY29tcGxldGlvbi4gSW5jcmVhc2UgdGhlIHBvc3QtRU5EVFJB
TlNGRVINCj4gZGVsYXkgdG8gMiBtcyB0byBwcm92aWRlIGFkZGl0aW9uYWwgbWFyZ2luIGJlZm9y
ZSByZXF1ZXN0IHRlYXJkb3duLiBUaGlzDQo+IHByZXZlbnRzIFNNTVUgZmF1bHRzIHRoYXQgY2Fu
IG9jY3VyIHdoZW4gdGhlIGNvbnRyb2xsZXIgYWNjZXNzZXMgdW5tYXBwZWQNCj4gcmVxdWVzdHMg
YmVmb3JlIEVORFRSQU5TRkVSIHByb2Nlc3NpbmcgaGFzIGNvbXBsZXRlZC4NCj4gDQo+IEZpeGVz
OiBkOGEyYmI0ZWI3NTggKCJ1c2I6IGR3YzM6IGdhZGdldDogQWRkIDFtcyBkZWxheSBhZnRlciBl
bmQgdHJhbnNmZXIgY29tbWFuZCB3aXRob3V0IElPQyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFNlcnJhbyA8ZWxzb24uc2VycmFvQG9zcy5x
dWFsY29tbS5jb20+DQo+IC0tLQ0KPiBUaGUgRFdDMyBwcm9ncmFtbWluZyBndWlkZSByZWNvbW1l
bmRzIGEgZGVsYXkgZ3JlYXRlciB0aGFuIDEgbXMgZm9yDQo+IEVORFRSQU5TRkVSIGNvbXBsZXRp
b24gd2l0aG91dCBDTURJT0MsIGJ1dCBkb2VzIG5vdCBzcGVjaWZ5IGEgd29yc3QtY2FzZQ0KPiBj
b21wbGV0aW9uIHRpbWUuIFRoZSBkZWxheSBpcyBpbmNyZWFzZWQgdG8gMiBtcyB0byBwcm92aWRl
IGFkZGl0aW9uYWwNCj4gbWFyZ2luIGJhc2VkIG9uIG9ic2VydmVkIGZhaWx1cmVzLg0KDQpXaGlj
aCBwbGF0Zm9ybSBhbmQgY29udHJvbGxlciB2ZXJzaW9uIGRpZCB5b3Ugc2VlIHRoaXMgb24/IFdo
YXQgd2FzIHRoZQ0KY29ubmVjdGVkIHNwZWVkPyBBbmQgd2hlcmUgZGlkIHRoZSBmYWlsdXJlIG9j
Y3VyPyB1c2JfZXBfZGlzYWJsZSgpIG9yDQpyZXNldC9kaXNjb25uZWN0Pw0KDQpDYW4geW91IHRl
c3QgYWdhaW5zdCBHcmVnJ3MgdXNiLWxpbnVzIGJyYW5jaD8gSXQgaGFzIHNvbWUgY2hhbmdlcyB0
byBFbmQNClRyYW5zZmVyIGNvbW1hbmQgaGFuZGxpbmcuIE5vdGUgdGhhdCB0aGUgdXNiX2VwX2Rp
c2FibGUoKSBub3cgaXNzdWVzIEVuZA0KVHJhbnNmZXIgd2l0aCBDTURJT0MgYW5kIHRoZSBkZWxh
eSBtb3ZlZCB0byBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpLCBzbw0KdGhpcyBwYXRjaCBubyBsb25n
ZXIgY292ZXJzIHRoYXQgcGF0aC4gQW55IGNoYW5nZSB3b3VsZCBuZWVkIHRvIGdvIG9uDQp0b3Ag
b2YgdGhhdC4NCg0KVGhhbmtzLA0KVGhpbmg=
