Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543097;
	b=p7LuhkUkEfVJfNcT/gyU4Gs70nmghbA9TdHsTESGYbaKYw4+WHSlqIFpq4yQdXmU2LRb
	 YY4Rn7pfD4W4myuHm0HulfzKkS0g8wqes5WNhdl2t9UtHFhuTULGp1U6KAh6NRh+6YFME
	 dWvqSpbq1HNHLdJ0buPKF81gRO5va9paOCvtYhjpKfavELTL+hWR/IX2wHVTMsEl2yecR
	 TWoxTyt/CF96wrvXmX/XGG8l0bi0Lfmox+8q4r8SNcj1uhtw4dOyRnbI/vSZMdmInlo3J
	 u4S4C3qKirICkHfIZHKM5QYD/w3dCi3Rb2yzNrLYhSm2/K26wnJAutbI7++sTTjWXvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543097;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:Received:DKIM-Signature:Received:Received:
	 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v3PpRLKQikpb4oNqPi+vn4s4MQjh3k2NaJCuAHjtT4U=;
	b=n7j9sLd8lSI4J0wbJc+Fs03FaZkil+nXLo+ZC+SMg6zqgqv2Q06YX33HU9Cs6yWhYYHZ
	 IAmmiIYyLKaNFsXYSxW01Z6KYswb+f6R0tgUcbgSA9otf/utUqVRTvucmlduiLh77Zgrn
	 S764+Ng5nKVcnGugyfo/WBXjX0zvXmFv5wyKBAr+X0FY/bHA53UuuCqVK+3SrtG5drcFx
	 S6u19JyRkqP7gEjpCRyX9QiGkuhKSn4kiL4YlpkMW7K+V6+4pdJm+5FDwvkhx8R07KQhW
	 WJouy4wa9D86bCgghU0lQNsq2aXlw6YfWAT5IumGLgwhIXIDGD2ol0TK8OE02lAB6zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=OZUAkTFM;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=AtBxj0ay;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UhHKWMIg;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC313606A31F;
	Wed, 21 Oct 2026 00:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC313606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=OZUAkTFM;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=AtBxj0ay;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UhHKWMIg
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKvo1i2052397;
	Tue, 20 Oct 2026 17:37:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=v3PpRLKQikpb4oNqPi+
	vn4s4MQjh3k2NaJCuAHjtT4U=; b=OZUAkTFMODkjrnK38oIOEi+8rWtamrPugvO
	8W1RuBCi3v/Vd+fMxYfxlLrByp8fq63gp354hlXICdq9BZmIc7Ysf+GwInaFSzwj
	Iy6t3PVV75XbbvghoVStmgpgakmGKZiC9tn7q+xpg/tEUdhLfwenu+xAUGV7UgaI
	oPB9M4+TyxY6JNiVfBo7UXwLkJvRzERr+0RpAW+JC87U3OSggWX4UnaZ50mQ+mbh
	MHxDRkaNeaGOjxfhaO+TGsrjg1+5JgKOVcl8RSmh5V9oFYPQ06Jr9GUrew53DS0J
	9eMZihhe7ENl+sEPizcQRWdbs/pioYJmNzTyhsCBtriuzdu+L6w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hdw6v8evf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543076; bh=GyU7QC6gfWrh9Ab2559UiaKC5ME+/6W/ziVgATVTeis=;
	h=From:To:CC:Subject:Date:From;
	b=AtBxj0ayh9Jw8xCcLldSxP75OaeYPdF0c2TuRMW14OtkroQw8GtFSKt1RCPL1GS2g
	 I+aNFI6mm8179UKMAkHqIhRqvFDqTolBK5wiBYohAVbt/I+SKdOGad4eh1h1bYCeLS
	 o+9ysnbkp+CTojF93lDR0ITEqH2AnUw855VTKg+eZBehMRYGvzMOwiGWpMA+zQcgLF
	 kLeouEqMSv7K7ENFgbzoxKPf9BXAlyQJ0UQQo8X6hrMXUQN8jE3kpJqbyqnxfdYhj9
	 ERz2li+kdUxD1pkfHAb54gmxz9pLkpRYb+Zmyf12BM1ggeW2vwwCJoOACYTJ8PdYLp
	 hwpE4LM+uGOeA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A6CC24017C;
	Wed, 21 Oct 2026 00:37:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id EFF73A0091;
	Wed, 21 Oct 2026 00:37:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UhHKWMIg;
	dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com (mail-bn1pr07cu00307.outbound.protection.outlook.com [40.93.12.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E298C2202F1;
	Wed, 21 Oct 2026 00:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzjdkbyhHIaF2+FBv36lvjPiNM2O1lmy23iGkxas3Cz5RFyFxP2+cTM90h+yO4zfKQptxqvM+reIPuQcmtOijVRvpgo8dExKH4sccm6LeAQZHvVAH/+/yDcYj1vY4qpBi9uZCy0idgQIGcMoZbO84hu5kB4Ax7x12TSAY6WaGbFGclc743byc5u0X9Xl8qazskoxChkei0L8so45jJvJhp4585bmNEQKln+Fd9APq7DlZ18vms06HtdW6MVXAwURSBt1LqrafHyK2HLteO4GVJcops/CXguQeQIuvdB2mjPOek8577uN65aPx9r40lQYFMPeY6LwIs9IJf+fo8YIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3PpRLKQikpb4oNqPi+vn4s4MQjh3k2NaJCuAHjtT4U=;
 b=dgD5OGZh0KYsK7LEVbOua4UyfjNN7eLf3v5kp1lsTU7JCWnlcuvV1Kw9TCYyGcgclVDHnQ8XQZgJ9jfHPOfx5Yx5NFvYKktZpJ79R5vEF0quUJkfQYIKQhcBx5HDStVhjacQPfAbIgQeDbdagx6YtgvKR/CoxwUo8VKFebd2prwQJk/SF2rw3ZOruBp5DNqetWnTb8Xs/eyIMwMXqNLJBnaF9cuWyJ9u1KxWPvNEjDmjpyvjWgJ7EjrdWX1wwGriop1bdvNl8iQtlRvPr5O69NhHTdhc1VqCahfUNVmhrNd0DPKF9ezLTcmhzJL8Q/XjiguYDcFbPldoyGWG2QbhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3PpRLKQikpb4oNqPi+vn4s4MQjh3k2NaJCuAHjtT4U=;
 b=UhHKWMIgCSA2tTR2qrwN1qbB5OQecsxJgRco7qOBGkYxffl0Sl4h66U0A/lYFwEWrw4mNEqHnNUDuunFePtamhXz8uJ1Eal703HN0qwGpFyKqRl60OAitywGctSfgtCKVSgJiiMbREstEYrKo66XJugvn1hqLX6OKdPVJHFqFD4=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 00:37:45 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:37:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Michael Grzeschik <mgr@kernel.org>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 0/7] usb: dwc3: gadget: Fix No Resource after End Transfer
Thread-Topic: [PATCH 0/7] usb: dwc3: gadget: Fix No Resource after End
 Transfer
Thread-Index: AQHdYPRjxPmMoXgENUC0jChw7Y6G5A==
Date: Wed, 21 Oct 2026 00:37:45 +0000
Message-ID: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CY8PR12MB7433:EE_
x-ms-office365-filtering-correlation-id: d448e309-9a7e-461d-13f1-08df2f0b866a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 3F60OyTo8+QSepZBygkeBT/0+VMSe5PZ2Y/91PmJP3cDWpxKmtsPXXBn3bymK4lwwBG/wo0viDyIuz1TrrEdpUiVCtCHaST3nTLS0T4VuQUShTI2LoUxC4SOTN265wQekzbIX2pnVddzkJq5Nq5OO0PvUXhtVOEPOk6elrrVlZr3F/4xHzVijzlNIwhPr7xwfyi+fhq5kJ9hkS2YziMlZP833YyjS3ZYv9xw+IFjo/SWQHrjg/yWJL40HD5cPh3U5ysRJuGKUry5z1NVJx9uTZgY94KLF1gSjhOxvfgbR8uLfNrCWrYDqhSPYaXvsfTSKSVzcSlny7cjZpPwwK6aJFwXk7HK+JHvRTi2odCP1n3DaJ81iBK24lgDzu94OGpJ+lqRonzMSPv6SL2eq/vaXJ4iL/A8hawZ4QvROL4I64B1TGSmI5rpzL6x1iSGfY0J6muF5ctZ8iHc/9lWOPCBIWgtCW9HV9s+lLHLEK12faomPlXF3bgCknFAZ7eAySeFulQA9NETYDar2vwreNEEtNsR4NKdnRZylQ79HQ7sIVWcwb9jJuqtl1JhyQI35B37w1nfGJHcPAbh1IwM51WrIC2XKgMKNzS+C58jSMN/lGKzZUdZN6BJMS8QxZoexgh+31aA7EOmhsfUK8Dn2xm9NRcX9a5L7fpSvmYlbxzPcf4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(11063799006)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0leX+E3YfEEdjwZpaDzA9E8k2jNuP9d/SKNBoGIVURXlA83isDxq5LGlJe?=
 =?iso-8859-1?Q?9IcuX4C68z/QWGQ7rS3jGnoK2NicxMv7Qr8WNq2WPEmHO7TQGzM8HO9pDT?=
 =?iso-8859-1?Q?jyGsfdDrbY5sXulqpu7fxHn9/+aOIITG2myPGEeMgKhtxlMoWhykrRiHgW?=
 =?iso-8859-1?Q?AdwCQwFWoLBLmj+4sgAHuCz01p5G9y2xThli8EAoqbOLkGKtkHKYU7FW+C?=
 =?iso-8859-1?Q?RnQIguK/Myt8vyppcxoURT6PwE0eZx4RMuKAjH7TnE/8rRhQaNmHY7KtOO?=
 =?iso-8859-1?Q?Oe1h9yS5abvYHoVibzGRqaYM+SEQGJdlkDnT/bs0n0dFe7Sh+3Kr25ZJ1L?=
 =?iso-8859-1?Q?pScCQJYnbOPl7YCrvewi4Ok9zCZurNfXIaiFRfref+m2hWmlYOiAvJlbOT?=
 =?iso-8859-1?Q?jVqL6E0/BT8wKxLjjp0cTFccM6uObOguTo30KOFGKQ0EvBjWBs4/RGR+HI?=
 =?iso-8859-1?Q?SouoRrb7hawYFZi5rvVkX8Hvtatki5oUXfIVsU6xtb4wIRwwT6J4M4yqRV?=
 =?iso-8859-1?Q?TkEHHpxkdNvK7QPZj8qXrzrLb7S2/44E4iWYbPtakXAPrbyucTn5v1h1YA?=
 =?iso-8859-1?Q?lvTkrXeLxvBUCt7CkIRRm7UsKCtAdV7lnJ/s9zlg2jJewF38LUasCTro5A?=
 =?iso-8859-1?Q?VdfnfNm+4IXhHbXWSMFolM6sXc7x/DwzueBeMtieAxK8bG0cNDTthZnR0J?=
 =?iso-8859-1?Q?cQPwd7RK4lXGdHAAgoOXzcjYj9tT/qNQpVjDZLL2hgBhGqdN6Df3egglNq?=
 =?iso-8859-1?Q?3CtwVxfnWYxUxKFVJNyAsxJgFuht2HwlF5Ey7xZYRA485WuDtb90LCWtyb?=
 =?iso-8859-1?Q?Ih6Lfxk5bvnnKklEsAQHv/LHOpmOzeAPw1iuXNp04L0a/8gqHjz0DdpPe1?=
 =?iso-8859-1?Q?+i3IC6XUR3TJoYbuRZ2ArNvHbHFdTVNZp9CMqmCOQLLNPsA204HWMziaIz?=
 =?iso-8859-1?Q?LsPVUwn0A3X/8uOUablCpwrHEYMMCI3sKDXOQ5I8631N88F5wkYZ86OqlZ?=
 =?iso-8859-1?Q?BREyRSyPm+slEBV52rJu2A6LXWwyzkHUmvfR4LJxZLx6iu2zE4eNEZABj4?=
 =?iso-8859-1?Q?KAt9znJyVkTHHP41veQPUTn1v4a4immEUMLmx8ywxxLzW4lAEaMPQ2P6Gg?=
 =?iso-8859-1?Q?0ep0J2XZVsViLl1CiaTOrLdez35NUDjGsiPEBN+zxNhg2XXlqnGTyBZrum?=
 =?iso-8859-1?Q?QkDu6XLBW+FSFSnRbko64SKxlS6SEdK0ArcTbMWF/JJyPSjRp2zV4ipQwe?=
 =?iso-8859-1?Q?OdGdSTUoAkVlafZ0cBlQpQuy1lT9UxRvGQ8hDqyx17gtMuJDCFbynouQfR?=
 =?iso-8859-1?Q?B02VoUevVRNyyc5kp23/h5yr0ff6TOS+BtJ2Sb11UPq2Sp2uii9Mm4jttY?=
 =?iso-8859-1?Q?Xzfi6wuHCrCHrmKYDRbvK3T/lIN1huHss9bwcwwVJJAKPC+Ckrzi2mIDjx?=
 =?iso-8859-1?Q?cBQ8iTFePDGhi13i2u6je5BmTyD5dsNAT4VWdLPoc+CHFxJTCF7BfFo5oI?=
 =?iso-8859-1?Q?ZQ1zIiiNWPt+gdb5rE2P/KpO9PB2wSxJ16h5Z0stzZYGbZDwf3mUK3gyFK?=
 =?iso-8859-1?Q?Nwpa1ehMyydvtmUl7aUB/V14IZYuapnSYFaVtDkCUtHqc0bCSE/mETxN+B?=
 =?iso-8859-1?Q?ILKwhDMYLi0abniIxYBKn1Z7DkF5Bd5JAS59vxxHG+zIjhT/Z8JeGsjYtD?=
 =?iso-8859-1?Q?TRlKQuzD+knaNBncEk8jzKGGfUDM8rT0CO2q5SBjDTmN3oI/RridO9z2LN?=
 =?iso-8859-1?Q?4cWx2b7witaoaCoy/ndGED01ZvebVCAw06DpdTngW4Oq9vBq/rfz8w6F/h?=
 =?iso-8859-1?Q?Ry9AjqqpEQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
	UzbktPCA01avhXiEPND6q4L7rF8M8G1LuByqTgh8vIi/bxo4GYwDv/spz6hXBFD7424RojS2Wf/M2/rAGxF/qy7IFdkdmwzH2Uv69+9T74EVtIgm6459BYOlJ2bK7K+D62LTmdGn6aETfYUlJ7Q4A1PYgxcxQjXTEyUk4EjKeJ0rb9bjo/J2xnfpBrNEir/yDO8OjPQy8RbXd1EVLwbBjfm3fhCiC78IojkaHmvZJnnWNtGkyk1qxNpIkICIhYwoRQA67F4V2vp7NHC0Wa4WRm5uOpsf0fqNN56eRrshjjl0ajYpQ+dpxx+MpeLsysUTj8Bpwk2+awNWuT/KXshddw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3a7HjuNwpoECHD5LeVOxEC8YrwUG/fZdTlYAU2yHpxG9qe4EJVIvRMnwnHiUIUuSZQA0ZujkUGu5QptB3EroK6YbkEEow7Nf1kOLmcgl9aMs/PeD6SovAnHeIWqXn9d8PUwe1QCeijyG7tSNd6Z6n4nW4O3t33xT0LM6SBo27JmJ6RR1xRRL/QttFVQ8k7yk6dr6Dx05OJKAM7xKXno51Q0lKz4W6h3RX8Atqcso5M2O98gDjluFN46lo7T5ISjhkSOCsTkJt4yhPX3gYv9mlg5NOo3lEXliyPmkfXl0Pz8fDNLoD7mjX/NOlBQ5B9U90c3SzkUJJZVe7Kpg5wLC6SeaS+kTCx60xkeHVP7OR+3AecCq5mXeXOELAKArCXnq/4tKLUchB3DOHYsABOBwEKdMTKyEkPYcBhT/1/wXoNgOHNq3nDuGvXqnYiuFviOQzQ+5F1bg7yk+MXhf9k8LnqirtDtc4iI8tahpzEa+0c4PgMQNlvsDDb2DNlvSn8lqFiD/XexNCiZkFnvVShcjHU3WzxsUCKxfZblJMKAAhMDJm8FLj9n872xYyEG2aqB0SAJ8c91oMkZE8ECO6Ogr8Za9RTO32sIneLM4O4c6t7WsGts7hGvKkMooo6TD2em4nJUlOUH8udWIfaoA0CNv3Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d448e309-9a7e-461d-13f1-08df2f0b866a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:37:45.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnFXLkzqk3UsLw4gSftPecOmqzQdaACAmFIGYJjz2vwvudP847QLtu+LwN0xAQE7nY1DemizyI2PTmkLj+ZejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXyQAZjiR6pPTY
 gZo+rfo0pW8lHe4l1Jxl/o46Kf9d6uej9H/eriLkBHB6NCgIQWinnqZxqneKW3MxdryirzMYh1i
 pUyB/S6aYTg87uNY0+sMme8LetouYFo=
X-Proofpoint-GUID: 0p4Wu7XpUlUrkYdQW0BtQpnYjgDj729H
X-Proofpoint-ORIG-GUID: 0p4Wu7XpUlUrkYdQW0BtQpnYjgDj729H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX9OvSYts5e2PT
 dJn56FBNBiUqXccMh61JzPNDYwMdj1snX/7uup5STtDwpa868TRv3dr5GmlS3Sq8sGsc9Hco6gc
 Vgk1yTzYHZVu4KqUrqRlSAD2YwNKQmpxXb+pBkyBzbP7gNSD5NHLL61J6RUM3sXy134XQ8YyJqj
 Ij4S7GoRjOdFzkFKgQKPJIvDDy1ucgingIGMwNFgT/43+fiQRSopQ2HKavjQN6WU+YkWMVsZX0F
 2ns5D7grFqlug0PXen+utIEFAlVzU+mTxvDj45nyLjTCsXvRnUUQP/MVAKEC4NzJTvb9gIED2WE
 wvtVx2qronPTvJMQPOTHajCDGOTCpVMQRQGPKJ7RHtu2YsUPC9sIg/rtOVNsVNQpQcHroaPg9DR
 KCW1eZa7BoerD0ov78BvY6IAU1EmCHDuHkcTKKgq5tdbrXdmcddGkLS+dh6ouUqUuPXr6fbhh3a
 u2AySzUv5iUaANux/zA==
X-Authority-Analysis: v=2.4 cv=LK3z05W9 c=1 sm=1 tr=0 ts=6ad80965 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=y78e7X9CCXFLgyTJIbcA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610210001

The dwc3 driver can issue a Start Transfer command while a previous End
Transfer command on the same endpoint has not completed. The controller the=
n
rejects it with "No Resource", and the endpoint stays unusable.

This happens in two cases:
 * On ep disable, the End Transfer command is issued without interrupt and =
its
   completion isn't tracked. A quick re-enable or queue to the endpoint can
   race with it.
 * A timed out End Transfer is treated as done, and the endpoint resource i=
ndex
   is lost.

This series tracks the End Transfer completion on ep disable and on timeout=
. It
also avoids an unneeded no-op Start Transfer on non-stream endpoints, and
rejects requests queued to an endpoint that is being disabled. If the End
Transfer never completes, the driver recovers through the existing error
recovery, and stale endpoint flags are reset on controller start.

Thanks to Selvarasu for reporting and debugging the issue.

Link: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@sa=
msung.com/



Thinh Nguyen (7):
  usb: dwc3: gadget: Reject requests to a disabled endpoint
  usb: dwc3: gadget: Track a timed out End Transfer
  usb: dwc3: gadget: Clear delayed stop on End Transfer completion
  usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints
  usb: dwc3: gadget: Wait for End Transfer completion on ep disable
  usb: dwc3: gadget: Reset endpoint flags on controller start
  usb: dwc3: gadget: Recover from End Transfer timeout

 drivers/usb/dwc3/core.h   |   4 +-
 drivers/usb/dwc3/ep0.c    |   2 +-
 drivers/usb/dwc3/gadget.c | 160 +++++++++++++++++++++++++-------------
 3 files changed, 109 insertions(+), 57 deletions(-)


base-commit: bdf12cde30830d46a8ef1ba93986356f1164b4f1
--=20
2.53.0
