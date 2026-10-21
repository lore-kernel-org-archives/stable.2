Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543090;
	b=MNL3c+DA6nWW+C9fiTN5+ybNje2qqsNOy4+7JO9JhDV16nO+FRqhRDTsPwIcqHYecy4y
	 GzhA8Q8DVRQPkXTQaobzWmDxemtL0IAWTDBRDTNI8ydJixEZ0pVR8H6XBu+YGk2wQakBq
	 YTB5mKX1PIIiLVmCv6/vACHp95f0GYVSVPsTTMG2aGdp6onQBn5/z9gVI+AlThIOqSZNq
	 2rUwewN5jcSbJ06tdplIvLE34chFqRycffNtJhr/7AklDA7iG5WsoLW1TemvShrUKLCkZ
	 i7Te+Xhds5fVVutKa8oJSerfTYikv+wJPqyJIX9vhmzM2wEw8Cq6JG02uLLH6p7B2Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543090;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wyUkx3vglyDjC8mPzqi3m2kExG30g9w13h49l6s+kmg=;
	b=B3KyjGsT5jRUWCYlcMvpp0Mmp7rSMDuzsDgSwh4FT8S0ngs+8qHAaKYRIp8K3BcCmVwN
	 uvfBBCYtrYgir2jApSKbdQ8uC4oty/+oVN5jotFC5YiHfxlaoPzE9pt2h1DimogCYfBnN
	 V/ZIyFUHAkGy1Byo6sHjEgUgtivQbETAtpPiC5pVQk+GgLiLCAiIJ6RZUJ3we1DhxklS7
	 eD8mmaQYCZ88rZXbp95zNckCr6EvdjgYJhRfCTWipwOAq5UekNDiWS5uNMQiiUbgswHG4
	 s8V4+ThXjiYmVJysE1Dqritag+7zhAbe91qxp7m86FLgktzvbU52gfgkfnGVJf3qz6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=ih5dOm9P;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=Z1nfjDwC;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RTUxl8hL;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4E606A31A;
	Wed, 21 Oct 2026 00:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C4E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=ih5dOm9P;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=Z1nfjDwC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RTUxl8hL
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLI7hw3719268;
	Tue, 20 Oct 2026 17:37:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=wyUkx3vglyDjC8mPzqi3m2kExG30g9w13h49l6s+kmg=; b=ih5dOm9PlqZv
	sp6qApybF5sQCO8aaynA1KM1swVN3+H7+Vg4AELz7lhfA6TNWDEpSdc3kePNUMN7
	euMfyOKIAz/iftdJV1YRmSRbYgRPiGHguSS6gTGddtIk6AqaLz39y1IzZElYp33/
	IPmR8qXXjs3yzU60gpjMFKBpiCLwTTMa5OsY+ecmPs8Kn6x4wWIhgXkUHkd7C0fq
	6jttv12OFAfC/11K6RNMOCIpn0bJz/FrqcXLqSb8XLoMwIW1C+7jCmDfI4ih1Q8e
	VZTUvVv62oh+ovqdAnoVl1+rD1W2HLfQYAk+Bv/uyTb8sLoJOa1z6zy05NwKjQds
	bmOJ+TYvcw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4hdw70g81f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543077; bh=OcNP3PwkdjeVVojuD9hs3dKJqMCqnXxk5lldWPCaSLk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Z1nfjDwCKAleFYanznlr6gSHgZ/7koc5US7ttQed2oiNpaH3PoGCN1+CPxiCwMEE0
	 +s90X/SotSpMHXVZpxQkjw4KBysfmInZ3NWjS6+GQzbekNc4/Ti9ZAnBpMsujfm3cr
	 5IiXp0iF9uzOS3IBiEC2H9xKRUndoDD9KEKHeGZM1mwKR7FGE0O5dWA/Unegnjesr4
	 JXSGRE/PK38dmsaeHshWGsNPS2k2SliFzEL93+C6BJx/aesakiPHyqMVpFNH2uTWfz
	 FeIZIYwmAgGnAqAEcol+ssu0WY3KJpIF4LYKxSwRD+iRjccOOxC/mJLVcWWPZJ7dw6
	 w6XFY6EamCquA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F2E15405E2;
	Wed, 21 Oct 2026 00:37:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AD3A5A0091;
	Wed, 21 Oct 2026 00:37:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RTUxl8hL;
	dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com (mail-bn1pr07cu00307.outbound.protection.outlook.com [40.93.12.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7F89C2202F1;
	Wed, 21 Oct 2026 00:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cp3wFAPBryumOu48PC3+r6TJ/yBCBn6ObyAl4NEHncDfd8fZSNA8uj3Ob4+kwR68RYhHaOJ785MsC5YA0EBKnTFYumEfC8xuY7weci7uwFHMktuI/5cC91O2Ob46wW/WiLo5WQcfvlLY1jFHS0RF4sJvVCs0sl0BWua4IEFd2HuFl+EoHTyRyXmKY1ceXM/jh6thImrXn83RCuVdcOWFnzzeJHl5ItfB4szxlGjpRBhWgtR4FGA6BlN5eaNUCo4xFdzsMGQ0dtIPdzGjAaYH8N9bAfP+DosNIjbBiKFaUFIJyV8olKO/77s3oFT+baKM3Sk7LMjuG9oL9MoyxnSlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyUkx3vglyDjC8mPzqi3m2kExG30g9w13h49l6s+kmg=;
 b=FvA0HX5eYPTbLXhZpDSCQZwA04WlM8T34arjAT8Jw4GMiAuAPuTp6osyEqFIh35IceEhPBtGFms1vHJPWivf6MfjfH+ehNX/WgwD8nNrH4y9Fl/uv4eGpiCLmo3Uyo+914RXaUi3aJklYJ7XGjGBEba+bdYN64szYDFmwMS64nI/MpPG/gvT6Y+zti9eeH/PswBiJAck2EIM3LaTbsP6pua70I/aqsUZ60sTrR+c1LBDqj8NLn2fdzbs+pQ2jOOc9KiaqtYT4FUAbTeT6NVQwLRmz82bcjfdcUT+I7an/wCCZivwrefJTqDKMElI+4Dyux0R7vDqdPljE0Yau34nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyUkx3vglyDjC8mPzqi3m2kExG30g9w13h49l6s+kmg=;
 b=RTUxl8hLjBu2ZuOQBZfgnBkAbma1om+PwDrsKt27RVn0ArsQ3iLovB4Vxk6k8dvpJfZLk2xeZlMTMMiOiGlNLB8iyyb8sJqoAKdr+riSE9hYvgqHueNt+QUvfSVbzeSWEpz+vcgcP/g3Jd4747gwswlhkA5mHaK8F2Fv4jdWfvM=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 00:37:51 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:37:51 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 1/7] usb: dwc3: gadget: Reject requests to a disabled endpoint
Thread-Topic: [PATCH 1/7] usb: dwc3: gadget: Reject requests to a disabled
 endpoint
Thread-Index: AQHdYPRnea6aPGw0JkOCCoT//EUA9w==
Date: Wed, 21 Oct 2026 00:37:51 +0000
Message-ID:
 <4ceab6aa5d6af0e4780f9d3a964fd5d8168a0a02.1792542945.git.Thinh.Nguyen@synopsys.com>
References: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CY8PR12MB7433:EE_
x-ms-office365-filtering-correlation-id: 6023d6c1-87f6-4cea-45b8-08df2f0b89b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|5023799004|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 9kMXDTk1eODn+L1QYIIhteS+A9PNiyDbhoSpg9ojVF0B6lYy/C8ZT8PS2t0BLnZItfgaEqqvxKQEpWYqOMfCkgTvCQe2qAdv922VsRkx8XopP/GWgCLtTELdMLoe0UBX+/jb7QP3vfaTdpzdl7/OmdzBnbsQPPX60mD9GF34bGLJfHBRboumrD3pliOrciu7T6SSQEown9r2JeQlVgCaOw62mJXNUVaagoskMKahpbJmjTBCtotvdHdxTKgptqeT9MRr1MVe39QTVhwyMLRxBIK135+lu86aHXI2ltWeI0IDXT5HSZ5s2UEvWiTWh9SDxq8mVVjwJLkT8kT3JI2ygMVFLqlkCND9RZIl2yiDditOGCrGjjrrhpyKRgfLOuOlsPy7/Hl393j4pd6nIb5AlAqM745PdFZPPydM/DcfvbgFKeW9na4HxoEVraDCZi4xkDGss1NQVgfpy6cNF1b3qr9D9Q80yUp6ph6y0hLvrtQ/jMT7uUr+3XfEqjdKJ4ieybXQLWNBtdBeMQFkMRrWl2d9tIKfrR0W55i8P+HXkPqWDD+oqGtbvZ4Wl5f5JugjU3sqGuSKcty6WySdy9xPsfDRxYEwOCIzgSQZljrFOQlHxDVygBJW3xkOHAK3SyDBIqHyC3wXvT7qxZoVAIIPNwLNbX+bG6GEcWPKkAjZbWDKDdLXlC5xqmBwIH/MUArYcuVSe2oxYG/G7J2sp6xrPfO7FGk1Jm3OO+PXDZs+dPU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CPKD2oxiY5F5VQs4uY1xx2G9dQ33TLiQroLqmQjU0C7/JMh44y2LQtz5TL?=
 =?iso-8859-1?Q?iGYlZshC6/fcIQ9Wuy7EmU/5EYEMyPJavPe9XrNGJBhgdmN1VEN89QOe98?=
 =?iso-8859-1?Q?vWjefS3pK+kGfFB8S0b1Iqv0y0Zgf8/6+Qa4znpSl73kC5vHcK3kXiv38o?=
 =?iso-8859-1?Q?NalER7ZN5EcK2P2Ep/G1J7nnoE4S1faoXbtbNEPk12K/IcpTh0WspBn7wP?=
 =?iso-8859-1?Q?2t2iFq8XdUa0ruFoPnmyXISJeQiHr8QOf/u2aswv9OuCu2F0T3BFZvUs3j?=
 =?iso-8859-1?Q?IMr3PYAOzX1osFm+OE/RqebA3MMWuRWCT1lRyd2ycT2Q0C/NAf9HTocMBv?=
 =?iso-8859-1?Q?vIiW0UT3gBUwHgFf5+b4s/exsbGAZtYD9n2kJWevjP0PJ+i+6Y4HdY1RLz?=
 =?iso-8859-1?Q?/zFCHTmkLpnIz4oyMj/4+exFdCBOJIpqJnSGJz2XdcBGjzbsfCoSEVM96k?=
 =?iso-8859-1?Q?qJ76Fp6GLX0L0FXh5WdoyrFND5yJlANWGHF4lArWlDaCBXR0buUa5s/aDn?=
 =?iso-8859-1?Q?DfrXg0I0OH9FUj/LP+W7uJ+8vZwJWJEaSfnFZulukk1NhfU2Lp1aw7FtIz?=
 =?iso-8859-1?Q?P6nascR9mjFXflB769aIin8Pt2ZEvh51Pqjt+aAkE/mhNWDQsSzbn3tknv?=
 =?iso-8859-1?Q?je2vLYTAJjjxsaO9TikkFYiezj4g+ym2Iupf/TQYRUWO0fP9zSg9+XHIlk?=
 =?iso-8859-1?Q?wzXnQhNmypBB4LsjkVcN3YnfJ/UGUCH6UzZBvmqZ00c6jueRLlOi8diwss?=
 =?iso-8859-1?Q?dwBuSANrpCF3+8TzEU2M9IeUVYQugEOGjzaFTcE2+kA/YhSiBDrlde6D4A?=
 =?iso-8859-1?Q?Wuzi/yQ6CLJm2/suo9+BWYdXVEKX+pz9OG8vM7UXCgLUJw3y71Z8rnksXi?=
 =?iso-8859-1?Q?2y9675yKH9gMjzv/NETJ3QBl0Jp3Z/oqk1XOgb9LG0t4kXjfslljFYeL0v?=
 =?iso-8859-1?Q?fqQTAI8Vhy/bn3MnyVavhy+2Lck4zOCPI5dwabrLtTLEtZNRDIXIInoAFS?=
 =?iso-8859-1?Q?qP0uJeA9H5picDWfWDpF/OiARCuuxcoTL5ZSaekKduy1AEXgxHp8nJxsBA?=
 =?iso-8859-1?Q?Avw9fvCXGF2HgzSrPySzijRjCsDkngrArh344JrAF6apaonMpXyuog/izX?=
 =?iso-8859-1?Q?HgMjb1suOMip1IgzM20qdoDLnJkk3PZ9EihIjfIQZLbEznSuOw67VKqh23?=
 =?iso-8859-1?Q?aGVpvEJNUgSCq57HduP3uLQQbR1Bz5/06AY2IKHZb+G+qjrlt9ANHqeJHj?=
 =?iso-8859-1?Q?3eEWXcyNGZaHLAWiYpOrMXDgnuAbW4AJKm4/KjFeBsLEJk/sopuNuBub/s?=
 =?iso-8859-1?Q?FtMuLHmWVO3hUmI3UQbL8ezEQfS2hi/QJn0mpeS1xke5irOks2ByyFE5tf?=
 =?iso-8859-1?Q?bLVsA5zd77A7xpqzB37RWkpL0FXGqavmYxwAkAMnWrBl3ipM0ZK8qt0KP/?=
 =?iso-8859-1?Q?YIVBH59tQ1enZlNRDNpnWNgvrd4vku+8BLs6nWrUZAzFi0asEhaFdAhMLS?=
 =?iso-8859-1?Q?bfwqBq0u3QNW8zgLrig0NjnDSzwRSxTVGD/ArnyIR9lyQJXIURleAMXGLR?=
 =?iso-8859-1?Q?/oX56wJiDueIqEYXRnFeKa7d9lb/eRSifi+PKO2r2Lh6b7y+3IZ9/pUPa3?=
 =?iso-8859-1?Q?KopBR/ab+a+oNaojtDauC9f5AUzpZ5PkKL7Pv/N+GFfXYtshPeIijZcytJ?=
 =?iso-8859-1?Q?Q+kkFLYpEN7IWAAYOtNCScQxjamJ3V2h8KmhF8IC24pw0XzoH+ELwcss19?=
 =?iso-8859-1?Q?yp+G0CtHTrQ88sxFG6ANC2N1SYtiJHx3KiXL1ElVCwSRbiYTv2Bxfhu90r?=
 =?iso-8859-1?Q?mBJBoh4LuA=3D=3D?=
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
	tXX161jRip8b5OUvB+vdtBXYPTwjdY19HOzpX7Sahir1wLMrguTW+ICxEwdgGXPnQZXnBcbB7hwtg9s9L+ILdJevzdOLhzF1Byut9Gu5a7QlzRnLhLnsebzi2dGHcVrqNoNrEv1E8pvVztvHD5fBdxAGFBkMbYkQ7jOGiYmlCfMLgRS0LZ7E9ALMkVTL7nl1yrgb/0YHidyxtYTJrOdtO7qpF3cyAS+H27Z7fUlJso7x66D+LdGCnH8c7ai9dNwQT4PieIKqOnppRXo1jcJRZY3kGm/uEEqMqdxBAEM8l8BbRYn3yVD9XyOsglhzuJdftUlbhhXasVIT0CktwSs8CA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1wPJEnVk8a71I5GJl18UicRiGVhTnTeORPit3UihpYPP7RXJu+/pFH0IIxhgIZlnLvenCvBeFpGb27JBcDydPlvspBl86Mls58Nd6q26n0+h0APDA2RTKnkrFctw3HCNNHiC5Fg8ePEmDX81GK4OSfj+63P6i9BG95SzciBgBu9Z4byk01ZSLMD8bFzQToFTiw/q4SvWq4GD+rmv1hHKAuQeTV1lUJTWjLpWOmWKbMky4zrKwAYIhLf4Vsv9pwV0+M1RY9KKms3kRJuM/DxVdIGuKPZMoBzP034Z/yaCHvDzveNCvFCh9HKv6qDQ8Or3/wZY/9G12zZlFzeQf60T8UQWPt/5t9lf39Nv1ZxQr3lGJIi0EgoXbyjTl5c0eqFuhJGzzWl2r4/znnw9O//i7nP1TXEP6h+5x4hMdGiK+1jPOmBBwhqh8hu4T5O71j8F3u6Q+EgaCXkrvAroh8xVsu1WspfmDMzLb31YuRuYOEK/XqqIFeZe7zY//lPdljgoecuAuclNTvaLU3iQul3HxAKtvvaCtJ+HhSVbZPnT+Oo3lD03IKaDPmkwwXGTvDvtDCDsjSe8/ON+5YpIPsDMZ4+0Bg7EHxUsX2XvNNKkQne5rjQU28PNzjnAE44LzPHSIKlUhcs+QOicoVhDFeBPHw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6023d6c1-87f6-4cea-45b8-08df2f0b89b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:37:51.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZ3mCwcwjk7vddUBMr9Hb0u6RsfW//SjnA5/q+tdPjQiIbRDLf/6h4OzmYTft/1OFIeNF6RCIdADTdxlp/oJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
X-Proofpoint-GUID: p1jOPNrYxHtN7HCbPZ2bB8KGlKCP4CvN
X-Proofpoint-ORIG-GUID: p1jOPNrYxHtN7HCbPZ2bB8KGlKCP4CvN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX9jyaYZiFdOx9
 AbnJk8C3uycrm8v7b1Wm9xUlySs3sdp8dsJekEh3zZoSOmpuZpDE08hCfi6RWxvdDKI1ux9NnV9
 6+CtNNJPUYP3ldBY8SVZafrpQQQQFf0Tb/gupznoYEmg/IWdw43/pQpc0ihyK5aTSld/YHzS0bX
 eONO1LA8DDJ9tD16CE0ApC072omprnYapZ+a6hydggYxwSQbaOz4r+0VIK5ral+yJtvhASJXo2t
 oTjSbBFGIxgp20VqxCFB9UGDZQ9/pKoKmMaCz22ikmIrGNbgcinNpWDlHQzJs7W+lWg9HBz96mU
 OP+9qQ7lYA87EbK3tF8Ky3Co11zt+s/wueDRp271IYv0Go1vYKVy87Wcjhi8aHwUPr4bfK6Xive
 WfgZuryLp/QpvbvNrOS7dZNTCvUuDVDfOBmxVLqp2kZhd8nMbx/HBnrZGdHRNSHARMusyPZa1RD
 MzCXkGi9Azc1PmN4V8Q==
X-Authority-Analysis: v=2.4 cv=E8RYNqdl c=1 sm=1 tr=0 ts=6ad80965 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=gEeMJsqpcwTDM6lsfioA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX3RV+INkLeo2o
 KrWea4o8byiYOUIA+ibZHBBK+HcVNYkMKMUfZaQD6Y4u+Wd2kKK1DTpSoEcmVirqp8Dn/YLI7jE
 gnqyxoVwZOfjRQbzqJZJRGYO4mVDHiw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001

__dwc3_gadget_ep_disable() releases the lock while giving back requests,
and DWC3_EP_ENABLED is only cleared afterward. A function driver can
queue a new request in this window, and the driver would start a
transfer on an endpoint that is already disabled in hardware.

Clear DWC3_EP_ENABLED before giving back the requests, and reject
requests queued to an endpoint that is not enabled.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ee837235630a..eb6666b7bb98 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1084,6 +1084,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *d=
ep)
 	reg &=3D ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc, DWC3_DALEPENA, reg);
=20
+	dep->flags &=3D ~DWC3_EP_ENABLED;
+
 	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
=20
 	dep->stream_capable =3D false;
@@ -1990,7 +1992,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep=
, struct dwc3_request *req)
 {
 	struct dwc3		*dwc =3D dep->dwc;
=20
-	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
+	if (!(dep->flags & DWC3_EP_ENABLED) || !dep->endpoint.desc ||
+	    !dwc->pullups_connected || !dwc->connected) {
 		dev_dbg(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;
--=20
2.53.0
