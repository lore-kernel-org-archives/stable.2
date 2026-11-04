Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793757483;
	b=gDcoUdCLEBg16h5CSMOtKGmOp7ggcD+/WHwlYfoL0RCbX5ivEQXzQu+4DhbEcwhaPVEo
	 Rd2g7gLQx5i0AJxGI5nECWNbhAhGmGpbSzIrunSk2GyRc7yb2r+JXhnkjAFKylLYwRarL
	 OCK7tX/CiVba4ESbOpN4KFPLjHIz8w3JVM4D+1SmceA06diM1SmP/kOBz2IgQUShSepxp
	 dnKtzfylLTWEJtQtc/ngZQf4xODYq/r35FDEuK1gGVX5U/nQOFOJlD/tT9qulXGdaFbQ4
	 HKj7YilWwG38YgRXVhgEZm5ZzFWcfYNE/E2AKvGVFuO9ayo7sqFI4jxwxE6uXh61xeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757483;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=A6RPYidhchcA4SQxi8UcfBcFKs4Q3cX5NQb7rHGkzE4=;
	b=Y9OEbetKe6/0vIyNT3wTUT0YyGTHH83YcfYDJIYnqe5XPUnTL+hf4wwmeNaPoGKEkfv3
	 yvsp2Cs9Aliam3YVdjdMmoqReE8ANXrjmgcN7x5bwBOXLtgKgYbVPQ+VLhrScnecRVFlR
	 FpxMDVcbN/YLdfRVfeVop+Sysys1CKVVwrqGbuMFAeLueAxRyO66iNX2+ndoClbkGaAVo
	 am4F18JnHxuOgzHBqOB4t/rwQhCPyPLoMkbKpM2AcfvZzttXpV1mia5+IEgsERdFP+sSa
	 0FWwEV8RytHGCgcX0MOvvIT7yGHnTsRqKunIFqrGRWDCRnLoPAXRoGT8NDlUPG7qkcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=BOK74aZG;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=AGpMGOAJ;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XbiWzLij;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD9606A326;
	Wed,  4 Nov 2026 01:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4AD9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=BOK74aZG;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=AGpMGOAJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XbiWzLij
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40S9uq253614;
	Tue, 3 Nov 2026 17:57:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=A6RPYidhchcA4SQxi8UcfBcFKs4Q3cX5NQb7rHGkzE4=; b=
	BOK74aZGJJEQ170MLo2ceB8HcQnjZoGY8mxB9FMIhhif4Mu/zPuffTVlndWCPWI7
	uqBY7Kofwt9Rm1Co5lqX+wfGHXaZ+22hm1aI5uAm2KwHj/ocNcNodZ7aMAzrLZYg
	IUz3LZTCQb1MVCvvDl8PpD/UNedvEtA46JPbGJZqfx+URVW+ULiT2J8V0pkhDQCc
	BoqlGqoXW/ZPsxxd/59Z071el31mAXf7LKWn+Yh8ipTECDhSnLwDdk5WvjyJtlSY
	flZdHmjlqzKsvrIehgkimmRgKywjQXafArqQ2MWjUGBt0X00P1j7NkSLDDg9v09z
	42pIt1sseRz84yEiX4/W4A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hq5af3qcy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1793757470; bh=A6RPYidhchcA4SQxi8UcfBcFKs4Q3cX5NQb7rHGkzE4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AGpMGOAJPToaho5Nfvldj3hZFVkQ+FCnoyWETI22yNBGHQ2AXqhHvgeALrXNElUAh
	 83reu5XzX85+bN29IWFsSGaKhH5eEEkhfpK/y1wl64fOtI5zg5LkL9GIoGc3nEstK2
	 AWt1TeMWpi132c93oUZjxoOasBHXV/+zvWuZp++rwT760ky4PbO0HEJgB7628gtJPQ
	 OMPjW3HLik6kYlEsCC+3nLKYGrF3EKJlt0S5AqMeiReEkGuz6ZH6bWmmWf8hJF9ZRG
	 bQuJ0AcNIZDzgbgQHyVlUPDq64HSWGqZnTCDofNETw5HD599VaDbpWCLkKWtp6h89K
	 Y3bLcac2B4hNQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E43F64017C;
	Wed,  4 Nov 2026 01:57:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 96499A00B4;
	Wed,  4 Nov 2026 01:57:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XbiWzLij;
	dkim-atps=neutral
Received: from PH0PR07CU006.outbound.protection.outlook.com (mail-ph0pr07cu00604.outbound.protection.outlook.com [40.93.23.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3AAE322003D;
	Wed,  4 Nov 2026 01:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSxBrkFb9623c7bFEoaoSZZVKc7HnapEQJ3wn8xDRxVrps3z5yi9WUysqfynTi2xXNvkm9XklgBru+TXN/LvebyLHvhIPXcCjnL8Wwv6DzYYQ0BBj+fXEgeg88ciU+0VF4Xn74Qwr+0wfU70VqFMYZxbbGMmVXXOgMl5kRaZcQ5ZllgulPs7ym7aN6UBnWnAQvU29SKrDIp8GYBzAoX0ubgGP30hm3OjvOZLMZrCIHMiq+GQa/PMjAGZ8W22xqFYYqxA3kwofRV+CbpDMczp6Op8qUSvvAHsMUx765Jo52QMtwZSFVQO1jSN6PAQK959463H/wBLs8Rm/gq2Ms4IKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6RPYidhchcA4SQxi8UcfBcFKs4Q3cX5NQb7rHGkzE4=;
 b=gecerW3q1tFhnIoQKk3EF5nJ/ZwHZYrc1oWbvBvl+4nPa9gYEnPlJECOVXpQr7r1qRN1+jAy0cgQtXefV+irUh91ubjDIsWRRDDUl49d/ds5SjSte4qcBUSne2Gi5ZVlNXVqAGhvT2fkjbY5LKE/B9E5bSNB3V+rPRLQeGfJo8UDhAa8Fd40nLLWKQHkgI93BfNnanWA5SKpqIyt0abVVvlDB3kH0jk7Oz3DCFkzc1GjnETzhubeZ2x1NvMb+um1sZ/3s1GtIiB4lsUTthpSsvhtqIMD4o3ka8KsmjhsKtYtUr5URvEfSWfNZxlwgrlF/4yVFqk6CLiBmOHGZPioQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6RPYidhchcA4SQxi8UcfBcFKs4Q3cX5NQb7rHGkzE4=;
 b=XbiWzLijSXXSrPJ81KsoWnMYjtpI7Rj228966h1Yi/bpJi1f6QMNEQ3irywxzeQ/2Shcfo8TkVt4UwnmevH96RgTnHGrmPndM3SKBRaoyLkRed3s7ys9nR1UedAqm7z2jpjTqs0yDB3QrRy6xd6yBkx9B/nAj8wHWQPR/si09ZI=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 01:57:43 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 01:57:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Jiale Yao <yaojiale02@163.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mian Yousaf Kaukab
	<yousaf.kaukab@intel.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] usb: dwc2: initialize debugfs command buffer
Thread-Topic: [PATCH 1/4] usb: dwc2: initialize debugfs command buffer
Thread-Index: AQHdYUnp39x5kbAJA0qaFCxgue2/JrcdPRMA
Date: Wed, 4 Nov 2026 01:57:42 +0000
Message-ID: <auqPUx03ISuM-FUK@vbox>
References: <20261021104720.4106961-1-yaojiale02@163.com>
 <20261021104720.4106961-2-yaojiale02@163.com>
In-Reply-To: <20261021104720.4106961-2-yaojiale02@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|SA1PR12MB6727:EE_
x-ms-office365-filtering-correlation-id: 6104b585-5ba1-42a3-0bfe-08df3a1703ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|261022105027099003|261026140227099003|261028144727099003;
x-microsoft-antispam-message-info:
 xU34QQtx6TxFfSxuaYRNFpXCxBgItifgZmumGdIqckmbWptdgFMOnEZ5y+qMhHkte3Gmq1GgFy5OMhK+/Q8+UUUzWv6+hvvMDk5if7iPv4Fo3GBe6Ohgt398cEX/N3UPWMMhISvq1eYRws5rA+Mmj7TqOq9aVHhhmymzvy7cqMObjkkJdPp1qpKkovBdT/5XG3nDVa66wUPAgzpzQlycIaYbMMnbJ4jkNFAzSk2se2gZleB10/CqoIp7ztHj7loprkrRbhwLjYvwkFTtV4pJH7fKZyteYvjjm+s4wJfgG1OSbGvkdV0o3U23CliFRLK/fj37ZmwXV/mLKzezbI2cBI7GIwc+bKgAyUK0IuuOQ4xPWkNIqanQCQ2kBEempIVJS/QDtLZaNTaswzN5aECj84Mxaqll1aQx1KDUgxQAxFfgTzE8U0t6WqwgPyaYl/gCW4zEp/k/bIDWV2DOdGBwgCtA/29VM9bFkK+dHnBZuBlUKlZVcL5Ou/4JT0V+G8AIBQWsW5w3e6VfQmyrMJHsbMdz9W3VhfgdeAZJkKlxRdd3GKEwKoMJBwQkZ9ef4oZh0aNvzD12Xw9pg6LK7dL1Z8w4Y6Bys6ke0V5rgrglvhlThYBIfmsLIFtXDrkztbmvLlJnW3FzZ25ujJx2aOkmFvt/ltwCbOQEXnWyX6yNfUUN/chWk+9ussTH5f7OzVAFYGGofk5P6TQcViLTsHREKg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0N4bXpaUzNxV3lFdmZ4LzRCWWt5cjRFSFkxSHVuYkt6a3B3ZWdFMnZpdkNj?=
 =?utf-8?B?bkh1L29mdjlvVUc2VU5FS1UrUi8wQVdMTW4vbzZYYjlaUUloV3BNMUIxUmFi?=
 =?utf-8?B?N3laVzRQeWoyWUE1QW1ORE11azZZa3YrNFVuVnViR1BST2xZb0h3TkNEb3cw?=
 =?utf-8?B?dklJKy9FUTVSdFZSZ29RMjUvSjBudXU3amwvcVVCSkZHQUlJemFma2JQWFpn?=
 =?utf-8?B?VWdWckxhdW04bEU4eFpjd0ZxRytKVDhQN1VqcHo2dHFmZjkrSTJRQVVsRnFa?=
 =?utf-8?B?UlJiQWJxNjBRUEhsRWdscU1pSHRkZFZlRS9WYk9mRGtOVnFOaU54Tm1UYzJY?=
 =?utf-8?B?aU1GUzdXSXBGWWlFRkhCNjUvajdCM2JrV3N0aGJwOGpCcDVwOFNwOXFDRG10?=
 =?utf-8?B?Y2x0ajJQalRVdEQvSkt2K0hOWlpDNnFjbDlKK0ZMem05bjRyaW9IbmY2aFVk?=
 =?utf-8?B?cWNtOUkxSVY4dFdlYU52c012bHZLOEhyZi9TVEdUam5UaXlOcmN0U1pJMHc2?=
 =?utf-8?B?eGdTQS9vL0FVSEVZaTZZK3ZMSytpcVU1ajVrTVFranlFTE9IeW4wNHcxeE80?=
 =?utf-8?B?bGtWdGloMHRKeFdMVEdLK0pTUXk1VXprSE1YRGxYcnlWTlloaS8xT2NHcmFm?=
 =?utf-8?B?RFdMMWIwWDliTEVJMUkwSndLVWwxMG5PT2dMMFJ1L29HQ0NnY1ZDZFpmNjVz?=
 =?utf-8?B?LzFDT3M0djVhS1VxQWFSMmpDeWwzUW5KL2ltcXgvUWp1MXlpL24wb1hLbEc2?=
 =?utf-8?B?b2MrNW4yNXA0bEkvS0xoR3ZRaHQvdEZjSXJaaUUvWUIwVFpCbmxQZUlWU0hk?=
 =?utf-8?B?WnZaeEZNZERpSHh2THVaaHliMmpJRVZDUjkzcWc4VmRmQkt0NFoyZHVBVnhw?=
 =?utf-8?B?NlU2WW1LYzhYbUhvTnlHalNFbSttQ3Z2N3kzNHVEL0Noam40MXFNckV6SFcz?=
 =?utf-8?B?V2llYVZEU1pqUnhQbWh5ZDhwTHA4NHg1bDJSbHFKWFJ2L1h0WHFyeFBHTFBL?=
 =?utf-8?B?am04dEx6OWtVOUd4Z3FkcE8yZWc2UWZBcjR6L1dsU0lmc0pCMGlHdjBuMFhB?=
 =?utf-8?B?Q29hTVNjU2F3TUdQNFpsaW02Z2hqNWQ4VldoeVNBb3Y1ZmszZ3VNcXl0dC9W?=
 =?utf-8?B?anZCanZJRGhxUVRJZFo2Ty8xMU5uNzB2NzMrSm5yUlV5bmZ0T3ZpS1JUTUl4?=
 =?utf-8?B?SndnQ0s2em13eSswaG1JVGdCK25sSlhSZWx1MnBWcFF1Zk14L1pQUG4yQXlF?=
 =?utf-8?B?elc4MCs1VjdrTFhVQnJHQmh0cFI2TUhYYm1rYjYyZUJGeE1jVlhFUVJLR0x2?=
 =?utf-8?B?UVV4S1ZLNk55eEErL2J4NWorVEk4dERkN1M4NWpBcE1aaHU0YlVrMGhjcFBJ?=
 =?utf-8?B?OTI2dHJ2WW83a3pnSDZab2NNQXh5cG5nblhKMDV3dHhTeSsyRjA0SnNtS0lS?=
 =?utf-8?B?dnErNzZXaTlvcW92a1l5NlJ3Qk1hUkwxSEcrN28wWW5QTnlRRzFRdlZHS01Z?=
 =?utf-8?B?MGd1RFVCd2Z2dWNqMzBONDUrcEFIRURueTV6VU9ReVczM1RLQ0hzNGs3MlZi?=
 =?utf-8?B?MVFwVlllcTlhbzViQ3Z2WlZWb240cDNFY29sL0RnUFliMGt0dkFybWhuT1Ev?=
 =?utf-8?B?VW1JTDlwTVcrVS9WMHlBSEo0ZkNqL0hFVjBkUTVpdDdRamZiZVdkQ0htSk9K?=
 =?utf-8?B?WU50MnFlTWpIOEthQXdzVVFtbG03TVlTTWdrcjRJRHE4ejNtQm8xNCtWSitm?=
 =?utf-8?B?TTJ0Snd4a2ZaMTg4M05SSS8xK0RpQUZlREFhS3hsK3BCWWFsQTUyR2pIOVNp?=
 =?utf-8?B?cU9BNkh5aWNGUXZTdElnWnNOdzhFdDZ2MkF5c2Q3MGtoTTh0aXAzNHFKSXFD?=
 =?utf-8?B?Q25pZHozREpZOHlxaUhPMEFqdWx0c3Y0RWZaVHBzbDZ2WWpMVXlJaWxPOHI1?=
 =?utf-8?B?ZlFwODZGL3FFU2FyVi9CaU51OWU1NW5mc1JsSjdJVG9kN2VYRVpYcWFoY2ZK?=
 =?utf-8?B?L0hBSlkySlJJclQ1VmluSDluVnhGM1dBYnF2Ump4eTZxeGxOZnZtWGtqWHdj?=
 =?utf-8?B?NU1ZQlE5cDg2L0NJeExlclZ2c1hPNjdCdFAvaE44Vzh5S0JwL0h5TEFabEJt?=
 =?utf-8?B?M3FJek9YTyt0cWw5dXRURENNeEN1UTNySDc1cmFWVmNzT0lJV2lHSnRHcUJZ?=
 =?utf-8?B?ejZVSGlrR2NWRm9LWVpJSDlJMWdFRmFnZkswYTNkVTFiK0ZmSWZVb0p1ZHNP?=
 =?utf-8?B?QVpDNzBnWXJZdStMVjQzQVB6L0JKL2Nmd2VSRjlBUTZFOEJUZUhzRElLVStz?=
 =?utf-8?B?UEdFNHJ2RG14b21vN2NSb3ZiZ3c4UG0yVGJndGh5U0JyZXRxQ2pwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D121FDB0C23B2349BAA590B545AD1BE2@namprd12.prod.outlook.com>
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
	dtAwNnoOZYmwhQC7HhzD/PaJUFRxNmk5JQPJSRIPgicSVjspapIwTwcpuN8Vv3snEbC8ivgHD5TUiqz9ND9p4wKj5Qz2KgO7rXWE17Kim/a0sYy2+lc5Lb5eDczOaKKe4U6Bbw6v9NJ3h52d3vtRl2uXILQiFgdre0/KGo2OV9rFyPZmtPRdoqdEbuHmJU5wEBSoHXB/h8Lazan3QGxMCNNAtC0Q8MfmzTiKOJdOlRiDF3boBxTgkFDwAVTwA+AMp486BbY5eboVY87VctZcfwDDd6zupGlCO9y5IcnXX1Wclk3BcCDifvNdITCS31zHkVBpQ+EnFw01fcwyBuB47Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ttxYf0Zk9CsDVhUmiUjuNxotOvSvaZWJgqniOSgd8hAXRRoyRP/dW3HIfHZKawOOGdvduIqshBKoLVuWBs8kIdEIH0wvS3DWgwbVDn8qPIPXHyiBSWbNYhu4KGFxXqegQLY2Hw47Y6p/VOpMfxRfq6L8kwiCsoWlpE0jsO6p9dwvVqRzrX+vqrQE60clzcc/791vfm2/17gbQtc7OWHxAosFxDF0qp8/YqUaEyzXp8IcerK25wo0VT76AtscRu0BokfZxg6ffwaw9U7Jz4vTWeZcIV/AS0+8wc1l5+z56pFCsVywQFAECIPzvqFifrCYoOV46HTygsg245ut7PzDnzdB/1zCF2/2mTu/UFRE92EQA6Nxng8wXv6CTVXjGDg1+F9CMXx7ywZiN+2A1yqqgIfHsjoLakykjy9wNgeAWB4X92P8YvO087Jlvsw8Y+GWSs4Q/IeAvLgsD2HIrUwSz06Xmz3ldkok9wtHcc2sCMXAWhUUV412dhf2I2u1SXW0GASI8jAV2hIcZ1ou1vry5XxpUQwSNC/+QzND5acZ7XTnOzpta1Kl2s1Nd3kEf8gIO3m+kbKBS3RPutBKjQgFClBNftc/AtGt6j5rh5s3s09BgP+89869T5udOrHlauwKo7B/rshRbqccu26B24wJeg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6104b585-5ba1-42a3-0bfe-08df3a1703ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 01:57:42.9536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2+fCS3myWLbkMBY/s7JuuWyYqdu5h0OQ6a/ygN7jcHYhFfPSg7XhAJyjDwhUEtQpzeYk6eOENwWRrKe2x5Gng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
X-Authority-Analysis: v=2.4 cv=XN2l2ghE c=1 sm=1 tr=0 ts=6aea911e cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=b9wMfKSsxdaFfJIBOeQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfXzeRmbDf3tptt
 EWaFzhezM0eeDZcB9K7kiA8nuy1kVFO0Y4b/xA6JYxCwMigzL48YaAJp+cCSjv7C3InCXISfano
 HSn+jak5xStYN3VUKqCAEDmzcH/fcZI=
X-Proofpoint-GUID: UtnIBAKXrP6xi9Iw1J2qOFWXADW3QQlJ
X-Proofpoint-ORIG-GUID: UtnIBAKXrP6xi9Iw1J2qOFWXADW3QQlJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfXyXURNF1fZYek
 4RX1jhw3OsADxRnejVq+8YWhCi1R3KxGFWwjpH07raMm6NCAu1q9DqX3qTQ7qIO5LqfvQaufo0u
 CkQPHajeaLl2cG/LJSPphm/3idUlLKKptMOoIx68Kg0dOe/LPLlm3Y47EoVWa5Jjx/0o/PdqtOr
 dyAThR6n0xUEy8QJ1JlrVrNzbE2bgpQXwkCTI2hcqqhmlJdKVaZurcb42eT8tP1u0i8RYIunK4e
 ep+E7FKIfaZwX6yvzfBAbT2PdKJS1Ta2utecmbMpMLqmSYSceKL3i3B3dBcUNYvw7TxSIgmn++6
 SFCUz/o13jzgro0h7U4gGhZkaKpTX/smgyp1DvkJob/TnUlQkG/NPgkmrAohWCDAU48Ze3l6jm9
 Thl+cEB1aJx1NV3DkY+9X7rI23Y7FxTbOHJ0zMIOJz8+xgh1t1wAtXxmDyCJFgLRONRjB4pUAH5
 fRJFW3g+JJWWkAEJ7OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1011 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611040007

KFJlbW92ZWQgc29tZSBib3VuY2VkIGVtYWlscykNCg0KT24gV2VkLCBPY3QgMjEsIDIwMjYsIEpp
YWxlIFlhbyB3cm90ZToNCj4gdGVzdG1vZGVfd3JpdGUoKSBjb3BpZXMgdXNlciBpbnB1dCBpbnRv
IGFuIHVuaW5pdGlhbGl6ZWQgc3RhY2sgYnVmZmVyDQo+IGFuZCBjb21wYXJlcyBmaXhlZCBjb21t
YW5kIGxlbmd0aHMuIEEgc2hvcnQgd3JpdGUgbWF0Y2hpbmcgYSBjb21tYW5kDQo+IHByZWZpeCBj
YW4gbWFrZSBzdHJuY21wKCkgaW5zcGVjdCBieXRlcyB0aGF0IHdlcmUgbm90IGluaXRpYWxpemVk
Lg0KPiANCj4gWmVyby1pbml0aWFsaXplIHRoZSBidWZmZXIgc28gdGhlIGNvcGllZCBpbnB1dCBp
cyBhbHdheXMgdGVybWluYXRlZC4NCj4gDQo+IEZpeGVzOiBmOTFlZWE0NDdhYzMgKCJ1c2I6IGR3
YzI6IG1vdmUgZGVidWdmcyBjb2RlIHRvIGEgc2VwYXJhdGUgZmlsZSIpDQoNClRoaXMgc2hvdWxk
IGJlOg0KDQpGaXhlczogOWUxNGQwYTU2NmY0ICgidXNiOiBkd2MyOiBnYWRnZXQ6IGFkZCBURVNU
X01PREUgZmVhdHVyZSBzdXBwb3J0IikNCg0KSG93IHdhcyB0aGlzIGZvdW5kPyBQbGVhc2UgbWVu
dGlvbiB0aGUgdG9vbCBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/DQoNCkJSLA0KVGhpbmg=
