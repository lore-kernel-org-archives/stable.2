Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793977074;
	b=xIjtSCW/F+uancz9mmmiuXveIvAGlx6kbmSSqnPmgxS1kw7Q5yLLuTrV/jBfuh98Cc6d
	 C0JlKWgVttsq1vfEaZYYws1uqP95Y7pJh0QHdXxxQ3j9xdbnkt4D9TnGxMpc15FRO+56e
	 oNDrLMbDZQQR2j0hLMeOSTIrZGgPVmNXyQtifxcXgcqJLGQifHaQODAmKqrkFbiSAFxJQ
	 ce0KbX8SKamNsFvDTLjxywogoFvekjD70/7+DpiHwM2wpyRJ42L4oqa1Y8B9ndcFY5IOk
	 wtVvBV2y2XEuAutFTaJYOhAbXD9HcO249bFGftXj5PygZ54mH11GybWf8HUC7n9FtyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977074;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ku4juWGRzRM8pAS8TYUlMVqNlVgX3UEcRdOksafShEY=;
	b=d/nzSaAWDG+dQS1m42Rtkg7jSZcHJxB2QPCrtN887jXKYRy6jREED6T3qgSci40Xp4ai
	 19rB7aYMjN+nACjjS/rZMjWA7sj9FNF0QIvuBpEz+/ZVyqDpMn3u+Ul4GFaDlXs24Rd5S
	 m5CrquoGJhxgTSqV1txlkVjR4cQe8bIFWMGSOvz7wJoMvvWRRAdUX5BBP+a/vFBo+arSh
	 8Jjfc1hzYyp/m5a/357AlN78XfgZuHuo5Ok/tLB02WlrObMV0kLj4QKqgv1sskH/J6GOq
	 lwL56cFQEToRtjz+xGe3CBNPxki6Zf3gKdYZVC861QFhwCLjj0j+z5rL0yqOo14Mqqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fhxa7yWJ;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=LlPjuObd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837C606A326;
	Fri,  6 Nov 2026 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3837C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fhxa7yWJ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=LlPjuObd
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ERjDV3419363;
	Fri, 6 Nov 2026 08:57:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ku4juWGRzRM8pAS8TYUlMVqNlVgX3UEcRdOksafSh
	EY=; b=fhxa7yWJ2Se+m1HvYzyaGMuwi2Zk6e6oqc1IGcji7JBC69qrWyrMGl2rp
	y+6uAXwVP2ZJQQXigfEq76AjMC4xZ6in/4gWEnTxZM4j9tGxIRnkURJcRq2taE1W
	a+NW5GuRzdTd+fLYVSE/lwcbqd5a6XhGTbKNTTTOoNfNn5Va9CTL2N0yfFgXnl+t
	330n8cGWr48q73W+We9+XK4FpW4Tzr4LrVVLtVbdiv44SKcxjWSGhLHRlk5idshT
	dDeBAUAvXotwmY2JNKdYVw3Zxb7W9sT9LtJvSbGXgQ7VS5LBuXuEmNxv+jkZXVRX
	7mhm3zKzj7XlrqxbLINSSpMuV2GMw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hsbw91u1f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 08:57:40 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqkZVY5RbDoE6fion7Xp+pltGqV9I8Lp4uR9g0FPTjTAUMVHhuXa5QSAclMBvMWIqS7ga7szoAxSZ9MeEi+IIFBp3aV777AGJpskFoC9mWr4PPlvzUpvqMywDOMDd/eSMNeg8Lq9rhivpxwO8ySdKrpCgKOjtkbDU96ITcFejvxYxSoobJkzSKJM2ftCuvWaElwTl/GsZUB43kihchQvDIdJeSNnFIq0XMoVrg8C/wdqqDAMScm5Zm3tH+imxLhhYpiD7Cm4tqdMM8DPOwz4W0RMOrg7+QmXB6OMwdqIZPgBuV15+69jQSlAgE1ZzHldKaTig5+mnJskJDkJrTgIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku4juWGRzRM8pAS8TYUlMVqNlVgX3UEcRdOksafShEY=;
 b=WBwYN5bPfMg39LGQYC7thB4O7VTdek2Hq7Qz+8OAz5j8Ep7xnk36o4S96cFZV0Gm+iXjFWWPVaCPC4yR5bVv/dpZYpklofu3EGERR6EU04cZiNAsFix43UyMfPpRYenYeFDaZ0lObLPpki9KwW3KKKS9KEyavnfRzjZ5TjEyn3lGFN97hxDbV/sucaBPCg9dvPwR6/9DGh0+VM3yGLz5GqdgEkd8HNWygSG5aMnzj5dbwFuQsZuFaoc+GP+ugU4GNzeIbYr9vRhHSDSsAMMMSdfIfpkBze55ZL3roADt0wUYex0VMEw8tGBVQUkY4DHsxWuUxvfFecNc6WNYLbLzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku4juWGRzRM8pAS8TYUlMVqNlVgX3UEcRdOksafShEY=;
 b=LlPjuObd/zjj9cX9Ysi7esnKjLBZRgIzTYVBypkwgl0QRzsedhHOqZ6BVqPPk30F/GbkHeJRhEXcC52vwN+I916FIThw+5EekI8Mv1HzMTLLSpb3qpTrnJyptiCJpkw3sLcdj61AImYOoBinLCTJgerdwG/HJrx3QN2a8UCp9jE=
Received: from BN8PR10MB3652.namprd10.prod.outlook.com (2603:10b6:408:ba::10)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 14:57:37 +0000
Received: from BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a]) by BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 14:57:37 +0000
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: "Brnich, Brandon" <b-brnich@ti.com>,
        "mchehab@kernel.org"
	<mchehab@kernel.org>,
        "hverkuil@kernel.org" <hverkuil@kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] media: imagination: e5010: Fix clk never enabled
 without CONFIG_PM
Thread-Topic: [PATCH v6 2/4] media: imagination: e5010: Fix clk never enabled
 without CONFIG_PM
Thread-Index: AQHdYv1FLSZ0GWlE+kOpRsh/FUhs9bchOFcA
Date: Fri, 6 Nov 2026 14:57:37 +0000
Message-ID: <b7a862f9-ffd0-41e6-a0e4-d160ebdc03a0@ti.com>
References: <20261023144618.1652390-1-b-brnich@ti.com>
 <20261023144618.1652390-3-b-brnich@ti.com>
In-Reply-To: <20261023144618.1652390-3-b-brnich@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR10MB3652:EE_|CH0PR10MB4937:EE_
x-ms-office365-filtering-correlation-id: ce8e707f-1220-4a62-2940-08df3c164c45
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|56012099006|261022115727099003|261022105027099003|261021135927099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 1iJwlZsrlmWLkbK3m8bAQHBVql+TEYwGgb2Q1qVpfY4WbMNqODIQBZLVw9+ZJVuLpDRYLKhgY0Nr3S0/To1OLUK8WVjWiddGDsGXntU13yydwbot9kr2YW+zkKPak5G8MhhCfWLggj12B3BfDiesP2NXTEQsgP4UfKu7jlK3onwpDLAWHEQd8oz9aSJog8VrkdLT4q9pYrzR1nrNOHfrW4aISmtZavN6OdJVJuaXvxC6LV7TN+21XLdEQW3QIf6hrz1/LSRvt1TwWxbLzq+Qd3FeagOjTNwNocaQ1bkTTi755WsTm7u2Ge2tYCYkqc2H5reFrjddHBTNJ5nnhLuC9r/zrMCNY3mBuyp1pMAxQ8ZzJtqro/rPLEXIFAyUkdgIOXEIVBuuy+3n6pYR0PyH7i4xlvDN6GgaDi2TVi/mY2t+N6Gop5t3PQjgR/E6HsbewaABFMBOVT9SnN3oXcmkVPCt8EWXhK+K/RQNPuiSze69psuCs/c5LITRj4oHMlcrug2+dElMhE2cMbxpgQ6WGE6ER4KO14dg4NqfiiMFllWqWCYqgrlr9QnZkwsit/SRA0IA5aPu7P7jkqAHwBQh5IrfMgFQZw964M57gq97iA41ucgjrVBg3IHkXb3HGSi+6A5VTiKa5KXlA2zCRDU1q9o3Wc6pMUhzUZkaLA7YKwM8MTMmJv3e/RrJhJZJAnUFaNQMI1NO6I/uFHCVbXdb5qPa9rIF/D71MJZ8NcfmEIY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3652.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(261022115727099003)(261022105027099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1BsOE9SR1ZjRFpTUi9KY0JaaDdFRmp3cUFnMGp2UFo2U3RaZVN1Q1dvVTVU?=
 =?utf-8?B?b1JMN0xseUxJM0ZmU2ltTm43bWVtS0t4a0R4TC9MYWtOTFhUVkEyV1B0R2p3?=
 =?utf-8?B?Nk9kZmdKdlBxVjEvSFFuR0IyVFpUbjdsWCtHV1IxSnYxWGNhWVBzWktjTm94?=
 =?utf-8?B?MTlMNklIV2VQVmttMHJ2QTVNSkYwUTdKbHRlYWlERTZPWXVzaUdxMlZtTUdv?=
 =?utf-8?B?M3BVdjc3RXZib3I1OFhjZ3FqYmg0RW9yTmovSFo1cmh1cEdVWXVhQ0VzaU96?=
 =?utf-8?B?b0swSjhnbVY4YTltdTFOYWRLRzlUY3BQcW55c3VDUFNWelBwR2lZVDgzcXdC?=
 =?utf-8?B?SHp4ZzRJa2JsSTVCZWVZbHhRc081MEcwa3hjdkVYM3RWQXAwVjFuSmxlbk02?=
 =?utf-8?B?VXc1dnAwS09DV2NWVmtPNmwvaWJkcWNIZnB6elIwTzJIcEtyQkVDYTg3YkFK?=
 =?utf-8?B?LzJ2MGRWMTF1UlFHOCs5Sm9odnFNMG9JUVZOVXViNGdkL3JtTmwzaVZBZHhC?=
 =?utf-8?B?OXgzZkRQSGRKbUNPLytBQ2U4ZUF2SXhMbE96Q1NwbXBaRmtKMFJDNFJvcFRq?=
 =?utf-8?B?MG9LTGVUQm9oMEVkY0FqeFdZT2pjQU03ZEE1cHRNWEVKKzI5TXBJL0FvRXJB?=
 =?utf-8?B?WEQ1YXpYVERYWWhtdS9RcFp6OFV5RC9IRVh3ait2U2ZpWFIyNFNZQjMzeUpB?=
 =?utf-8?B?TEpQcXNFRXNHRjhtejVZN0NBemgrK0dsN3RDWC9Pem5XVVJ4TG85Q3JrKzBX?=
 =?utf-8?B?bWNTbmZHc2VrQU01RGRmcEh6d3J2TlE3bmxYU1FJdlZxUWJOcS94TVB2T0pY?=
 =?utf-8?B?YWpDdmttalpmUisvblhWdzhXMHZ1VTBjaU9MTnNBOXNLY0tRUzdXWU45Zk9U?=
 =?utf-8?B?aElLTU1BQnFOTU1LT2VxZmRZb3gvWjlKRWR1RmIwdnVRNSthcDcwRjgySThZ?=
 =?utf-8?B?WmtCbGtZcEpXSUtqb0d0dTRYTWFMeXptTjZoS2pmRUtWd0N2ek1zRzREQlBp?=
 =?utf-8?B?UEI1dTU1SVNKR2haNlNOblc1WGF2bWJSQWVrOFltajdldElPWHdacnRBMDJS?=
 =?utf-8?B?V3FXZkNpT1BxRG1mU2RpUWpPMmdzeHZJaE1qd1ZRc3QveURkRXd2NG8vNEsr?=
 =?utf-8?B?WmtXeWE0bENjK0tlNng1aU1DcmJoN1lGRG85R2Iybkg5dEJRZ3lzMGRLcGNq?=
 =?utf-8?B?ZHRnWXlGRnVQaHdmenpBWUxjM3hzM09nSlRoRk96RXlHNEhQdU83c0xwdllr?=
 =?utf-8?B?WjBBQWJTcnRoZlJmRTlyN0xyV1dxSnM3bWhHZlI1RlZ2TXdERkFwdmhDMjJN?=
 =?utf-8?B?SUE0SnpuREhXaXRQWTNzREdldlRqdGJ3UkhjVTgxVDZaWi9tS2c4NHBWSWha?=
 =?utf-8?B?MEtGUUkvMXgyY1Y0ejZRU08vN1F1OW4waHNoQU1QMTZjWThqWHpudkFVRGlB?=
 =?utf-8?B?WFA0N1lXQ1VvTmdUanNNVjE5ZGNKckRsZE5rQVNXYnRNcVEwZ2JYTXRBTEtR?=
 =?utf-8?B?NDBmSkRodGdGN1pNV1JpOHdwZmN3QkxrMk1rVk90T3M3dHY0VmtsdVpaT3Rx?=
 =?utf-8?B?QUlWOEUyUGJFRHJFVzVaVnZER0hFTlZKU3FwWjMzTTZMdFA2TjRqTkNEcDFq?=
 =?utf-8?B?Z3RjekVKaER6TFlZc1hHSjc0OUw1d09COXpueUdqeUNWNUVOeVVzaGIxU05U?=
 =?utf-8?B?TytNRXIzc1Q3aWNJaDR0SHFLc0todDYvcWhmdGtDVlJpa09WOU9WaEpXbnVM?=
 =?utf-8?B?dmNwK0l3MitlQWsrWDdiYm5lQ09zSXY5ZTRORnZyc0kzaGxrRC9GWUh3UDVh?=
 =?utf-8?B?dlltR0R6SGI0dVAvV3RxYXRoYmNHd29aOGpaVFI3YkR0ekFNQ0xuRHRaT1k0?=
 =?utf-8?B?N3BSdlI0MjBUT3l3dDl2VHhCS0ovbTA0SVE0Y01FNHQyaEhRVWY5MnMzMTlG?=
 =?utf-8?B?aXovanZwb0ZKYm96Zk5tQUVURHc5YnNmcFBoS3FmOTlCNmw4NkxWM0tPcW90?=
 =?utf-8?B?M3dUSHhSRTVLT09LallreUl4U2d1alE3K2Y2dDV5RlF5QmZPdk9IZHdPT21L?=
 =?utf-8?B?R0RCODN4ZC9oYnREWWFzQW5FQlJwYTM3a3NKTnRubERwQjhhdjJXWGRhT09z?=
 =?utf-8?B?SzhIQTQwZUxjU2NJVmVvWUJZa1EvWHNmOVRqdEV5VEJCQ0FCbThpeldkSTVW?=
 =?utf-8?B?bGgyUllmUWhTWHVoMlloRGJjeWRTS1RxNXNJd2tMR3RqTFozZ1p5czFycWt0?=
 =?utf-8?B?OTJaMnJ0RGg1M3dVcmkyUGJDMkFVMlYwQmcrVjArQlJwdlhvU1hVTE1DTnlS?=
 =?utf-8?Q?jL+42SaFPNGH/OFJ32?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC2A163EE5A1964B91E43ED469F4CBD8@namprd10.prod.outlook.com>
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
	N7Jd9c1gHW0rTUjwSp4K11DLPRbmftD1WVAwULNkrn6dayXY1VkR0KBaN33Mgr97KK0Lmnlq0s/AOF2wopKbyP2wS7VinnOEJYWhYdnJ4KFjNz4faeBfEnIiDPC4MCtshyiebwMWFCvHiEKvTELHk5A2yK3ZVJPgHXxnlhx/gcbc3d/jVPkxg7rHnfzi/UuLCXct7dabhA3Rvt5SgPI72k/uaHnxrmpz6PglrYNAcqcAt7efFnU09F+1A5VW7QMs+gC8iHzYmweibsHjT0piZ55syDzmEUx6Iac/6erbCsxufVqR4rzDYPqDRamQ0+eQiDmEe4rCdTWHUga0rHW/lA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3652.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8e707f-1220-4a62-2940-08df3c164c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 14:57:37.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwHJtfgoQbLfNZzNLEr7LNbzVqKkg+xiDr2YOZVv8GMlk6nEAP+7ZpwtUdXMhMMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-GUID: XmMAjrYQLClVwMi25nHBlqV-Pj5BOuDa
X-Authority-Analysis: v=2.4 cv=Cp0q4X4D c=1 sm=1 tr=0 ts=6aedeae4 cx=c_pps
 a=B1kIKGfTVomdQYahC0fm5g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=H0OXqGnWH-lIl9EKxfkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX1lcCyAKi8uRk
 JoifZfx0IZCoxa7moscHDG36sSuVCL3VDYWwa7bWWOgly+qds+Bp/Cn+P6oQmw70AFfmclfVDk6
 +yUwzy4iHDjJwBx7bTVISsRxfO4al2A=
X-Proofpoint-ORIG-GUID: XmMAjrYQLClVwMi25nHBlqV-Pj5BOuDa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfXywZFf6Vzr/26
 ZAJWzjxb5xEw8QBHZUi+DIZTX/OSotOcrFPlHvCsMqU59wpCrjXKxMOHWBobuQKN8E1uNE4UVSZ
 ToIromdc9vghkYXcGsX58P/ahK96LZaKA2WxxLoP5uNFDdJVZFVmxhWJJxMkuNliwMmC4lupBV+
 C9iI+EStIbmnjQFh9m9qRP3zRY3ujun6dKM0KqF2rd5flZq7fxdwvwIKSUvrUywDQO2I4J7A1Gv
 1Rr2DMIr7bhe2CVetrh/Mxhbp6vBy35fs/mz+pDLgUCbYxaRPwRlEcOZ/PhNkjIeRP6L/U3D5Cx
 Ib4mbvtPYbVW9X4KMeqpjfitPykNH+QLkMe0Px08JyvQyphjHGOBaIyxFDUXc5g6wd/MnPKnkwd
 u0I0u+TlhhqgWIEEZ1gukNxfHTqkHdpjr4vOzRkM+7Hm+mGsON74CYcGF6wImGlcdCWjy/4LcQL
 J88W8fkiccWRcuxsmsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060059

SGkgQnJhbmRvbiwNCg0KT24gMjMvMTAvMjYgMjA6MTYsIEJybmljaCwgQnJhbmRvbiB3cm90ZToN
Cj4gRnJvbTogQnJhbmRvbiBCcm5pY2ggPGItYnJuaWNoQHRpLmNvbT4NCj4gDQo+IGNsa19wcmVw
YXJlX2VuYWJsZSBpcyBub3QgY2FsbGVkIGFueXdoZXJlIHVubGVzcyBDT05GSUdfUE0gaXMgc2V0
LiBUaGlzDQo+IG1lYW5zIHdpdGhvdXQgQ09ORklHX1BNLCB0aGUgSlBFRyBFbmNvZGVyIHdpbGwg
bm90IGZ1bmN0aW9uIHByb3Blcmx5Lg0KPiANCj4gQWRkIHRoaXMgY2FsbCBkdXJpbmcgdGhlIHBy
b2JlIHNlcXVlbmNlIHRvIHByb3Blcmx5IGNvbmZpZ3VyZSB0aGUgZGV2aWNlLg0KPiBJZiB2aWRl
b19yZWdpc3RyYXRpb24gZmFpbHMgYWZ0ZXIgY2xrIGlzIGVuYWJsZWQsIGNsayB3b3VsZCBiZSBs
ZWZ0IG9uLg0KPiBNYWtlIGEgbGFiZWwgdG8gY292ZXIgdGhpcyBjYXNlLg0KPiANCj4gRml4ZXM6
IGExZTI5NDA0NTg4NSAoIm1lZGlhOiBpbWFnaW5hdGlvbjogQWRkIEU1MDEwIEpQRUcgRW5jb2Rl
ciBkcml2ZXIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBCcmFuZG9uIEJybmljaCA8Yi1icm5pY2hAdGkuY29tPg0KPiAtLS0NCj4gIC4uLi9tZWRpYS9w
bGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1qcGVnLWVuYy5jIHwgMTcgKysrKysrKysrKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAx
MC1qcGVnLWVuYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1q
cGVnLWVuYy5jDQo+IGluZGV4IDIzZDA2NzA5YTY5MjkuLmI4ZTI0ZjgxNjY0OGQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vaW1hZ2luYXRpb24vZTUwMTAtanBlZy1lbmMu
Yw0KPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEwLWpwZWct
ZW5jLmMNCj4gQEAgLTExMDEsMTAgKzExMDEsMTggQEAgc3RhdGljIGludCBlNTAxMF9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcG1fcnVudGltZV9lbmFibGUo
ZGV2KTsNCj4gIA0KPiArCWlmICghcG1fcnVudGltZV9lbmFibGVkKGRldikpIHsNCj4gKwkJcmV0
ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGU1MDEwLT5jbGspOw0KPiArCQlpZiAocmV0KSB7DQo+ICsJ
CQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGVuYWJsZSBjbG9ja1xuIik7DQo+
ICsJCQlnb3RvIGZhaWxfYWZ0ZXJfdjRsMl9tMm1faW5pdDsNCj4gKwkJfQ0KPiArCX0NCj4gKw0K
PiAgCXJldCA9IHZpZGVvX3JlZ2lzdGVyX2RldmljZShlNTAxMC0+dmRldiwgVkZMX1RZUEVfVklE
RU8sIDApOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZh
aWxlZCB0byByZWdpc3RlciB2aWRlbyBkZXZpY2VcbiIpOw0KPiAtCQlnb3RvIGZhaWxfYWZ0ZXJf
djRsMl9tMm1faW5pdDsNCj4gKwkJZ290byBmYWlsX2FmdGVyX2Nsb2NrX2VuYWJsZTsNCj4gIAl9
DQo+ICANCj4gIAl2NGwyX2luZm8oJmU1MDEwLT52NGwyX2RldiwgIkRldmljZSByZWdpc3RlcmVk
IGFzIC9kZXYvdmlkZW8lZFxuIiwNCj4gQEAgLTExMTIsNiArMTEyMCwxMSBAQCBzdGF0aWMgaW50
IGU1MDEwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlyZXR1
cm4gMDsNCj4gIA0KPiArZmFpbF9hZnRlcl9jbG9ja19lbmFibGU6DQo+ICsJaWYgKHBtX3J1bnRp
bWVfZW5hYmxlZChkZXYpKQ0KPiArCQlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gKwllbHNl
DQo+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShlNTAxMC0+Y2xrKTsNCj4gIGZhaWxfYWZ0ZXJf
djRsMl9tMm1faW5pdDoNCj4gIAl2NGwyX20ybV9yZWxlYXNlKGU1MDEwLT5tMm1fZGV2KTsNCj4g
IGZhaWxfYWZ0ZXJfdjRsMl9yZWdpc3RlcjoNCj4gQEAgLTExMjYsNiArMTEzOSw4IEBAIHN0YXRp
YyB2b2lkIGU1MDEwX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXN0
cnVjdCBlNTAxMF9kZXYgKmU1MDEwID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAN
Cj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoZTUwMTAtPmRldik7DQo+ICsJaWYgKCFwbV9ydW50aW1l
X3N0YXR1c19zdXNwZW5kZWQoJnBkZXYtPmRldikpDQo+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShlNTAxMC0+Y2xrKTsNCg0KSSB0aGluayBiZXR0ZXIgdG8gZGlzYWJsZSBjbG9ja3MgYWZ0ZXIg
dGhlIHZpZGVvIGRldmljZSBpcyB1bnJlZ2lzdGVyZWQuDQoNClJlZ2FyZHMNCkRldmFyc2gNCg0K
PiAgCXZpZGVvX3VucmVnaXN0ZXJfZGV2aWNlKGU1MDEwLT52ZGV2KTsNCj4gIAl2NGwyX20ybV9y
ZWxlYXNlKGU1MDEwLT5tMm1fZGV2KTsNCj4gIAl2NGwyX2RldmljZV91bnJlZ2lzdGVyKCZlNTAx
MC0+djRsMl9kZXYpOw0KDQo=
