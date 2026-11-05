Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793841925;
	b=hIKu634oL0x+ArC4OsL4rYGpfTNGq4iIr+4+6un+O/Xkq5KGpLEgNPXRiLRWhrSLdsG5
	 ysfZZsxPDjt24bkm8CJ2+N9gYea95kB9c1EIjxCp4o0Ic7sYhgYwf2aN6oRNLHyO1DK2+
	 4jfy+xPKFYte0uXLofWWS13c+FOJwhUuS1sYUtqXLBg1e8NfQWYXUaxXgQ7yMCyKPXdbq
	 yLY7/RSvGKYEJ9d/w5zV8dv97r6OCJ/5xuJx5YYJEJRvvdAwHh6cupeeEKwFagQYfCydj
	 u4ZWQwvO4kkDkJavy856BEcTPR8zMVfTlqnDMQMsQPuvlXbHU6x719YkjC1Rk4iVvfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841925;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/a42Vxe6rzEqS7V+i6ejoXp6fsOHiwTvGrcmaaGnpII=;
	b=PaSdwHa1wARn0lIrGCcUl61xRFuJ0ImI1R3sXViqjaF/ijWlWiNEKuRKnOX3GfG9IwiH
	 ZJpDnJZbXa6wF37K3YUuKJmzPiAY+6lvXpR8asFfV0H8CxLTltKDBU/VYZnapQBJCy1DV
	 Q1waKKdcapBDJaihKOA4dEx/3QrCOFl5G6RKplx+zl2YSfRHUsyKikgXzH1MOY2Hjt2V9
	 dpZrRSbb8AGbWmui5dHO5V5lukr/XGJIN+x+mU9B+rGFl73SYeqIrLmgyrSiLeSZnP6K0
	 PzuDyGv9wJztykpc9jYM6A8mp6Ikc5qyZBxsYsoMnzvhfCC9H4fNV03k/uObb+mWNjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b="qwrNQbt/";
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=JCVTs0aa;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EAV51R4l;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2A606A31B;
	Thu,  5 Nov 2026 01:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A2A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=qwrNQbt/;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=JCVTs0aa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EAV51R4l
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A50nOO1267828;
	Wed, 4 Nov 2026 17:25:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=/a42Vxe6rzEqS7V+i6ejoXp6fsOHiwTvGrcmaaGnpII=; b=
	qwrNQbt/ZjyKplkrt0khMO6qgXWg029XcbSbrsH5tfhfyY6r8vVYV5ylmz/pIrOv
	P/a4K5kXMaluJYlOYEXVInLm29HEqd9tOX4U8ZXLmLlJkuymCdWBW1PKjEtL1Be9
	s3XHNpPZ5JQ79tcfiWD1kFDtPh0SifOkhaL2sB26tcjVweUKbJT9tZgKZ7T73Pd/
	wSiqJaPCPG1Pn+z5G5Kjpa0w+6m7it+tus9Um5sF+Fpmymj1X+eXHnJuariHGMjH
	lrwyzoaVjm8FMD9kaSv654LU5uSKXEy5SgV4hkmk7TT1QY5SDAxhUVlnt6VFEL3U
	BQDr3S4GjR4smudFoQSGGQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4hr2dsg4f5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 17:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1793841921; bh=/a42Vxe6rzEqS7V+i6ejoXp6fsOHiwTvGrcmaaGnpII=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=JCVTs0aasM1WENsVdIWfQ0Iic0U1GY6Fi2VT/NHNQhvJEuY4+pd7PfO7ToxTjToZn
	 eQtd4+wClsvCtVVDIDmlSHhEhAlq7sHurv3lxZv0UB7toHZtM4JdDv4uiULv0IDmft
	 vN6+btaxZ5LWFMZeu/hWgOveVQYJyOwe278V675RvOjfsuZfpp+GA/CT02sT95KkC9
	 H9rO6TNBfNla5hNcgRNTQDmKJDr7InokT1X3eUB48u/jnAiCp+nbjW5Vlxfjgn9S0S
	 yI80yhXokcuAabimNadVzlkGpFeFBWzmGBpR6lDIi1rLEwiuQkhSjruKi8V9KcALAP
	 dlr7lrpAVnr0A==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D8E2C40183;
	Thu,  5 Nov 2026 01:25:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6BC85A0072;
	Thu,  5 Nov 2026 01:25:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EAV51R4l;
	dkim-atps=neutral
Received: from PH0PR07CU006.outbound.protection.outlook.com (mail-ph0pr07cu00607.outbound.protection.outlook.com [40.93.23.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D15DA4011C;
	Thu,  5 Nov 2026 01:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6XkBtc5DtJojxOEsFuLuhttpeq5NKahyB8bZMe0FsgxHgEJQUPUtsZOMCQyfBjZrdAThCkejS4rEpkmueZPLy9rkmPmP9qoS5pQS116FTem9yxRvhDE0DEoumyoplhQeSy8aCmRh7HHEUFqkc0xHw1oCIQWJneKFxMb9vfQRtXciTEI1gu+ErjetLgVuDA0oWNhmXGex3h+xyDMsCdwVcF3ruf5vmY0f7mHjJXQHiKo0D3ZvwdggDMO1ib70M2oaZ2qihHNixdRl/ceISDZBpfc4BoIb4nU3UzvvHQEsVlFSczOXcsz4zbfFqhf9Dq3WMjghnThYC/0aCbh/vbZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a42Vxe6rzEqS7V+i6ejoXp6fsOHiwTvGrcmaaGnpII=;
 b=xoi/wNemAyLfu63Gh+229H3hsoOWeqQ8L3degaFnRuryADbtd8XziEOVbGbLqfKWhoymkiIqcfHDV/iMTK1MyM6NPcZdbDewT/aH4vfcOm8x+np98YDA/MTwKM2TEMMIINpcsWdpEB72uo1qE0TMu8ZdVJEiD66zUiXwm3blnjXaJrNYGXvJoVrBZtPLPf1N5wlDVJgczgR1E9Jq58zWKOvqzw51jI71Mhwhkk4wZBxlO5e7drefYCM/kTZSj2FDA97CiryIZfE9hKttepyonYg5rvSMD9q4Hb+rgu2QU7/GKUtSFIpXWKQOyVnxDD9FbFvWCEEw4Cci4RgJPLfRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a42Vxe6rzEqS7V+i6ejoXp6fsOHiwTvGrcmaaGnpII=;
 b=EAV51R4ltrtUNeN4RK5NEAF7Nq4JZ0Avll+192lno/xOO/dPIjlugFNeEY5u5jLNQunwTGvkIGnaWAmfsy3etNUsFTb3xBZC/WHxoQjx0IN3WuiCciRGV+4XtNVal8l2uGwYx/qkhQw6si+W/vUYpAMecSgV/Akd34diYmTjKeQ=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Thu, 5 Nov 2026 01:25:12 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 01:25:12 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
CC: "hminas@synopsys.com" <hminas@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] usb: dwc2: gadget: fix off-by-one in ep_from_windex
 bounds check
Thread-Topic: [PATCH] usb: dwc2: gadget: fix off-by-one in ep_from_windex
 bounds check
Thread-Index: AQHdZPfy7kV8iFQbvUS03G6z/Xv4hbcevt8A
Date: Thu, 5 Nov 2026 01:25:11 +0000
Message-ID: <auvOD5lXoSPL-1Va@vbox>
References: <20261026031138.35911-1-fangxy@xiaopeng.com>
In-Reply-To: <20261026031138.35911-1-fangxy@xiaopeng.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM4PR12MB5745:EE_
x-ms-office365-filtering-correlation-id: 7bbe99a0-8e85-4043-f369-08df3adba322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261102123227099003|11063799006|56012099006|261021121427099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 /1TKC0P8fhIQL0qyUpcnzFNUUZPaMVJak+xm/sb/TOEFbDC+WDqlwBiVPxqbvfep+ElKz6uxLcXj5wBBwz5Xmn+73xdPFfDZb76nvVGU7Ijut6JQIwa0jUX+gRZ4POgZxiK6nU7qXnQRa+3rroPmcWPz+nYfgZpKsQ7z96obPHX6Dh59lgPFAVO9t3cQu3jkS/j6FaMO1iIP+kSZsMww7fhO/zJmEBjgsGzakqGUFPkYns/+Dl3Fe7DOnq3heaRR1gP7DI5FLQrP61cTMdAKBnaa8hp/TATjcEoj0uT9wiU5sAY8O3GmsqCSsKEEXCIG58O5cFpF219CFLx1BEFrcBzgWzsNrbaU8HOSmKKeVqQPGuIhSu3LZ/WGDmcUtK0w6lnIDDQB3cyJ3cWZkU2GosPBDHmX0OrFBl87cA2Je17loqE08KVqKOMTBnztI9XWsj+TpndCHOO+GcQLDtKG++J3yO+8hBmi3TG5pFZ3jVJjaD4ex9+pW+iYRfnrRnLFCz84cH7nH8OTECcOwH0c8UIf9oMHzjsa/0zYPPnl451idYTVY+EiDY9HgVDTeqX2YJkN/egEC23GueuWJE2e8Fw9Lm6t93l4NJLn6FM3cCPxUIBN0gwvtDWVI8WFBEDBXf3R8qvsfbaTeX2Zr9fDZxk23muvNh5B9iknPECpAx1U1scU1IncB802Q74TTprfqKNbQ/X202/gaD8JEFK+wV5aqTCSQ8cslPtzYXlWPbE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261102123227099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2NsT2JtUThKMnlKbFVFTUNZWTd6MS9zNW40VEN2Y0kxN2c3b3drb3FuMW54?=
 =?utf-8?B?ZVBxdTFFQWROWU1rVkdUSmVqNm1JUCtnY0pGQkdHOUp4a2Y1aUJTbDRjK25Z?=
 =?utf-8?B?TGt4dlo0Y2c2c2Vpa08zM3VOYTU5Vi9nSUZRdFdDRWs3NHNaRzdybEV4VmU3?=
 =?utf-8?B?bHc4NU5ZZklLT09uYkpRdGNJVmszbGdKQTltcHVUaUVmL0FXN2V3RWhTVkxx?=
 =?utf-8?B?OThKSjhRaGRRT0xyY1A0Vm4xM2hKZlUrMlNuNHRLRUI3MzU1MHZ6dExiV2Vm?=
 =?utf-8?B?Q24ybDdwVktkUkJOR2l0WVNZRUt5ZDRJS3dMaFNya2t2bjVQS0RBNmEwNkg1?=
 =?utf-8?B?U3lrK1cvTGFLNUZzSGZxT2RFTFBuSGFWMHVFZ1dCTllCb3N1MDQ0RUlkcjVD?=
 =?utf-8?B?WmhBWjRIOHlBaXZ5cFo5UGZndFV5SG12UnEvbjRpN2UxWTk4eU1IdkdZSUJq?=
 =?utf-8?B?blpKRVQrTDRyTWkvSFYzYStpdzE2NzQvU0poVmkybTFnRVJMWnhrRytJTXZC?=
 =?utf-8?B?MnNYc1NtbU5DTm9XVHBsTEl3NXJOempXOWZPSitjQTREMHRFaEU0d3lXUW00?=
 =?utf-8?B?VmZsTGcxYXJIeWpKcHZLMU5xSmFZSmJ1eklueVpkV0JMUkNuM3Nvc2VVdGc0?=
 =?utf-8?B?UXdFcXJxVXdSTk5mSFIycVpteTNiRmhuVDcvMEl3eW5tQ3ZDdHJTcXdUYzJG?=
 =?utf-8?B?Y3F4MThXQnRUSUxGVFlOYlRXSEI4ZlRHelRJSTljUURCNFJHQ2FBTXRXbEdF?=
 =?utf-8?B?WG9wUS9GcHJMbzRXVU5lMmRuT00wREd1d1U2NlVmZnJxajhWT0N0bjRUTWdl?=
 =?utf-8?B?UDJHQzJTOVF1VzdwR3pPcmY2UjdqeWVheU8zVGJSSW42Q3JOdy8rak5tTU1G?=
 =?utf-8?B?SnZIMEM1SlR2VnZzcHhxZmttSllpanJiOGlsYjFHR3d4UjVEczRKQ1dQMFE3?=
 =?utf-8?B?U1ZuZGFxc0hVMlFQYWNzM2JVbGRnQzA1NFJDdG95anY4dW4vZC95Q3MvQytl?=
 =?utf-8?B?dWZsWlIyVmluN29YOW14RzRyWEhFazdhemdxbTVrc08wTE53d1VjZ1RUbHls?=
 =?utf-8?B?dmtSUE9qUXFhU3VURHd4T0FlenloRGJuQXV5NTlMRVJHd1JudlZ4L1F4eExm?=
 =?utf-8?B?VjNIdkhacDVJNGRsRkt6OUoycWcxL2lXNysyUTg3d2pVMWN4Vm85S3NNVU1j?=
 =?utf-8?B?VGxBVnVBbGVRUUdzZGVWeENBQW95a2drSE1oWk5wdjNTQ0E0Qk9vaVMvUDVZ?=
 =?utf-8?B?dnByMk1WN1NjRmw5WlVFTlpldmVjN1JOVk11Tko1MU84TUtXaVlZZ0k1SDR2?=
 =?utf-8?B?UDdIYjdnQVRCMmI0LzQ2VUh2dUlqTDkvNGVzaTc3Y00yWUlsOGxwaEVsRFhn?=
 =?utf-8?B?bXZ2dlpzTHdubThQV2tYbEV6b3ZXSWU2UjZNN3J3RWhEMFRUUGM3UG0zd0Fi?=
 =?utf-8?B?aHU0c2ZvdWhUZS9XNW1PRWpoY3R2U3UwakM1UEF4NWFCc1BHenJvM0p4SFBu?=
 =?utf-8?B?WHFaaVc1dXpMdDdLT0tMS2NKR3dLejFyR3V3eEVjQldZN2kxV2p6eGk3MXZz?=
 =?utf-8?B?TDFZTXp3SE1Xb0JFM2VhallkUnZ3YUNZSy9PdTNDeHIvWlhqbm1XYVVtVjlN?=
 =?utf-8?B?OCtmQm4zYVFBVDVHUlp3M2VkdTVMTkIyLzUxM1AxRDBaT2piVVJrMWZrTnMy?=
 =?utf-8?B?QVBhTTJLWm4yd3FMZ0s5Q29nVEU5ZG9sK2ZPQ0FUNm9wZUVEd0RsS2ZZTE9Q?=
 =?utf-8?B?MXp5dkMzbWprTytwU0pqWU1qU0o0V3Z6bUtmb1VCWjRHRmNVWGFUaTB3SGtn?=
 =?utf-8?B?UnhLTWRwaWlSbTc5RWN1NHdiRVZ5SGcza2JudTVoOEcydDdUVDQyNWEra0o0?=
 =?utf-8?B?WnVxNG83TkJpR3R5Y3J6NkdobUhWRmhMb29nWWc2UW9hKzQyVWlyUjdFSm5N?=
 =?utf-8?B?QmhFVTBZUmJxSmpOUUU2dWY4K3E4UGJZYWNmVjhmNkdKTVVKUnZvYnVOVE9H?=
 =?utf-8?B?dXR6OTFxOGQweGtISXFkWW9qamU3Yy9BUThnckczTEN1VFE0Mkh5NDFkL3Fi?=
 =?utf-8?B?ZmJoM1dtUkdDSUtjY2Y3QXVlS29WYkdLS2NrK1FKSjJ5ckhHR09yQmlrVkVP?=
 =?utf-8?B?Ym90ZGcrenpYWTdvT1pOZjlad2R1TEZPaHgxTTdNODJDeTB4WDI4ZWYvMFBV?=
 =?utf-8?B?bHBYT0RQU283d21iaVd6a1BEbmg1SXZFSmpkcHEvdUEyMDl0dEZqVGdTNjZW?=
 =?utf-8?B?bDh5TUdQRWk4b2RJL0cyTTVabmhWNWMrYTljOVV1VlA2TDJRS2RxbzhFRGJG?=
 =?utf-8?B?SGxkUEpKRFhGTVVJckJRdkk3RkYxTndWVEFhYWhmWVVsVkk0SUJHQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B17305E1F05F864EBC6BCC383AA3DFE7@namprd12.prod.outlook.com>
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
	hqOrn3TuMkc5o2aVFDlOXa8QoRafWgWl44CIVfpfhXUrcxefEGttO/NL/ulojT4CGZUcBKwtqRa7TqRKC0WC+/EgLYcGHwlFIrUkbeIF3wE1VjGtMOHLkVelKussJzodJOozWRkybSbmquj/YTvqzmuJuIeh8gb6OObpZuGXRtqbXc8x7O0eAtloNJ72iKXo3QS7LpIsPe3S0Ym4cPUGVbBXN3WeMOi0sgbz98ZEEZMQ7XyESYzfLcmp8FIhlm9nH+RcSLljAtXMV3O/DdK1vF6EsTO6vo/L4KqEWUF3iGsPdTSAgLFpkzagZgzpf0NKfX1abjy+BwQrdwbeR9dEjg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iiPAe/z/6bYSQ3/7imERVIGcdG/HwoRNcMfzcXoV8c2el49yojdgQD94jNqcZFqXC6iuROKygGNfaTJuCczauWBpUUCR9Ub6hwvk198Z7jp9QnEIrcXVLrsQxQ/wJ7D2j2HzL4/dg15H7DZZg2crAIIhGHHV65158xrnM+rKlPs21+tmvZFnlzcrVGjV5ztsRDYuGlS1v/JHr/HUQRZ1TH95iMW5y3Acl/Nbeu9llXrDBufeMndwqO3YnBCjEbrekxkhxTLH9BBij5WX6GE66Qy9yOb3EiL5F+cIOhVs+5JAnOwEtCH+qVvvwsgTXK0NHxp+hjZzdSRTU+cBL/4mL8mCZPrpDRKNUYvPTvZasgchW5oVE745mNXR3J8GS6Bjo0Gz15rG9WopIDUxY0T3YUIgDFrWpEmxNYbqtiqz+Ydv+hFZwZTjDOF22KtdsfgzIxjX7fx6U9mrQL5YKYkEKN4Do8y9aMpfxdhmVbYUOgrSMGsxd228Pd+40q/66ChDeh4W1KBIN7vXilCySJL9kUJJKnbg8rBv5tmHH9A33UJZmhr2hYE9fpLhpgGi+LyEa3qRUdSqgOLxPEBZ8zXKPOvcoZnz7Cb2Pqelq4sAZKfUbVz2SwxbP9XRXGX6ixK3kcv4qFcJ6KZfonpH1YqNYA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbe99a0-8e85-4043-f369-08df3adba322
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 01:25:11.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDLV+TWP9mDazEiymsHO+iyJW29PCgHfEg8hokaZ/mljDkSvQ8tEqUbzRpXo1Uhp91uV3GS+XRiwg5I8I8K0Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAwNSBTYWx0ZWRfXw4IyUslXMn4r
 BpRIMIiV6UMt0zvy1H96UGBdwqpzZXjboy2O/nOC9u9ae8MMdsvcQN/YpN7kJjxC2LxXavEKGAv
 ynYI20YazIFzeDk7s5Pe1InAvZ0kuXJ79kicIusIZnmOxYeBmIVm09H56kP7NiGNHIKX2/9EhYA
 BycIUmRmMmwv8KJ5K5WfaLWlvGu156mKf0oHLuO8bZtFllyCxFI54iiW+Bqouu/YLMYCNnXCMEu
 NiHRazKKRmYDE7V6gngpnOQ0cjSG5s6jbC0V6ZmoOji0nHL7hnLhblU8lUAvKkZ8PpdyZPlp3Yc
 zXyWvZaZnKp7hEkrGeQWJtlvAY9+Ez3s0FvswhjOm6Rea18ox407u5m8moryZ9k7oMADuYvwieL
 ay/hrCMBXG3zg7h9lU6wM2yKLiz7QSdg6G4/ZVtUKRk/2vYpoXIFQ1chnd0mscYXhcEvyn0zlmj
 ypGxyK+QKxugFqo4NGg==
X-Proofpoint-ORIG-GUID: 2D5jWHP6ElQGLFxF8rXi-3cZ9ZIDxQ3X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAwNSBTYWx0ZWRfX/RKFYjczF3em
 fjx9OKRGq5sihljGwTrQmXyr3B8J0I807SGmSlz4CQEDwSrcEfjwxp95sqyNhrkzf0jtIhA1F9o
 EW/Tem5pqHerWcS3FyFCTaqK2Qgz7I0=
X-Authority-Analysis: v=2.4 cv=cb5HPXDM c=1 sm=1 tr=0 ts=6aebdb02 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=5p9d6SpccsW7gP8dhyQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 2D5jWHP6ElQGLFxF8rXi-3cZ9ZIDxQ3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050005

T24gTW9uLCBPY3QgMjYsIDIwMjYsIEZhbmcgWGlleWFuIHdyb3RlOg0KPiBlcF9mcm9tX3dpbmRl
eCgpIHVzZXMgaWR4ID4gaHNvdGctPm51bV9vZl9lcHMgdG8gdmFsaWRhdGUgdGhlDQo+IGVuZHBv
aW50IGluZGV4LiBTaW5jZSB2YWxpZCBpbmRpY2VzIGFyZSBiZWxvdyBudW1fb2ZfZXBzLCBhbiBp
bmRleA0KPiBlcXVhbCB0byBudW1fb2ZfZXBzIHBhc3NlcyB0aGUgY2hlY2sgYW5kIGlzIHVzZWQg
dG8gYWNjZXNzDQo+IGVwc19pbltdIG9yIGVwc19vdXRbXSBvdXQgb2YgYm91bmRzLiBUaGlzIGNh
biBjYXVzZSBhbiB1bmludGVuZGVkDQo+IGVuZHBvaW50IHBvaW50ZXIgdG8gYmUgdXNlZCBieSBz
dWJzZXF1ZW50IHJlcXVlc3QgaGFuZGxpbmcuDQoNCk5vdCBxdWl0ZS4gVGhlIE9PQiBhY2Nlc3Mg
b25seSBoYXBwZW5zIHdoZW4gbnVtX29mX2VwcyA9PQ0KTUFYX0VQU19DSEFOTkVMUywgT3RoZXJ3
aXNlLCBlcHNfaW4vb3V0W10gYXJlIHplcm8taW5pdGlhbGl6ZWQsIHNvDQppbmRleF90b19lcCgp
IHJldHVybnMgTlVMTCBhbmQgdGhlIHJlcXVlc3QgaXMgYWxyZWFkeSByZWplY3RlZC4NCg0KPiAN
Cj4gUmVqZWN0IGluZGljZXMgZ3JlYXRlciB0aGFuIG9yIGVxdWFsIHRvIG51bV9vZl9lcHMgdG8g
cHJldmVudCB0aGUNCj4gb3V0LW9mLWJvdW5kcyBhY2Nlc3MuDQo+IA0KPiBGaXhlczogYjNmNDg5
YjJiNjU4ICgidXNiOmhzb3RnOnNhbXN1bmc6IERldGVybWluZSBudW1iZXIgb2YgRVBzIGZyb20g
SFcgY29uZmlndXJhdGlvbiByZWdpc3RlciIpDQoNClRoaXMgcG9pbnRzIHRvIHRoZSB3cm9uZyBj
b21taXQuIG51bV9vZl9lcHMgZGlkbid0IGluY2x1ZGUgRVAwIHRoZXJlLiBJdA0Kc2hvdWxkIGJl
Og0KDQpGaXhlczogYzZmNWMwNTBlMmE3ICgidXNiOiBkd2MyOiBnYWRnZXQ6IGFkZCBiaS1kaXJl
Y3Rpb25hbCBlbmRwb2ludCBzdXBwb3J0IikNCg0KQW5kIHBsZWFzZSBDYyBzdGFibGUuDQoNClRo
YW5rcywNClRoaW5o
