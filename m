Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793842067;
	b=E/XCwcppOIcSiEjIkrvLaJyjEkO2VUnrqbLM8ZUgLa7gwvv9+s2imgcbRbFPsgfB4b7W
	 /sGGafzjPQgfsxzOq/ERdfnHO+yvurieY4BwVMhRxjtad7hZzZBduXst1YcjPf+JAYyTP
	 8NLByo/Zil6t+h9rCbBBTWBOhUlOW4DUJUTjhezZwfxlTB0mWxvjDQ7YUKL/IMDkUiiHt
	 XuVAT4QMZXpE7JSsOagTudd/wrsiP7f4JPK6yJrigyvZWoO6DtvvTe1T6PXBSIOw+vUZZ
	 yexvudy1/96uc63S/AeFMlWE0fW62slNgCpjrVlW96gH/s9nLdWI54yGb5TKJvRCHlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842067;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DnTMbVGWx7onKU6OfpJy+qn/yeWGzVgB2yIkbC/FSCE=;
	b=f3cDPke1fALmtsCIykqbcQUVuNyN7qHf02/Q2SvReynv16M5spinJPtcUKFxa7+Im9ka
	 PU3HHi2x5lv0mn+z8oIE6lMS4DmrEbfrH6yIAbbywoF1FSwZM5lBhIe+gcSxJF0qrLNds
	 cxR2CapL2p07h+WX3/RFsrjrKLZj293D2q+/nryg09W0Ytgcvs97nJfaHZve3H3oaNyce
	 JpsIMO71w7XI2rvbCD93pHAaEqAwGTChk7jfTnJsWVrXnsbsh8CTJTbjVWnehgFP+M4+l
	 JnA+hqAiudV4ZCqy+Xop17uKdB+VDTtj60hylsV8rER0yblk/lSa84JqQ/ukeWfhuzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=Mlkf9oJs;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=YDSt4E5w;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OGGGKdZ0;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAF606A31B;
	Thu,  5 Nov 2026 01:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1CAF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=Mlkf9oJs;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=YDSt4E5w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OGGGKdZ0
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A50oSwf3400958;
	Wed, 4 Nov 2026 17:27:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=DnTMbVGWx7onKU6OfpJy+qn/yeWGzVgB2yIkbC/FSCE=; b=
	Mlkf9oJsZIA9WDEMY9cxG/YifWuB2AqK2TZSvF4o9kH5yKg9Mmy3Y0mNXEZ9cLRB
	gCL1LeLLay6FMGUuGDbhVIsiKVP8LN70b/aNGif4l5uFmRi3WkiSrZgBc/gHNzFO
	9zNhnYbtA+touKrTDNBY27UxF6u/OHoO2elmeGf7TyV9ql6xCXvzcX9NQ/1u/aNC
	o7kzlTOMKnuVm05eC0Xnc2DGDateyk1gVfGjl89MtFT9xaUwHPk/Xw7gcCx6+r/+
	DelwnGDSTa8i5ZOoOkY173EuBAvNyW6JhFKU8wwjbE5jkS7Fq45RROiEg6c0y9sN
	6GHaAEHiI5Ppu+C3DW7BDQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hrfjqg9f7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 17:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1793842058; bh=DnTMbVGWx7onKU6OfpJy+qn/yeWGzVgB2yIkbC/FSCE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YDSt4E5w2AknTV34ZzQA0RHVx0AY9U1/YVR9M0aleHSWt/GlSE3cBDp3TwMFxeFCw
	 9vcQCHP7Ibo7umUm/dne6s5e+KQrAJMJ9j2mU6FvPogL+YLVAbjEK5pqjRpJLFEYVe
	 oE2WQ2NC7kBOP3fPNUyU7zPYsFREmqds0GKEhIMBPZ9BXxd8RtT2Z5/g+ioca6vp7t
	 w0JtXULehTNfTJikO2BWo/c1+dNrpxeaJrsL3/dJQ0S/KNzJgxO2RB5+1rSwjpqwnQ
	 vw64mEVmSs5Q4dAPTyrg402ChBR7hbKQijcaZGMNkGfYg8cHr5O94xPHCkXgKzWf59
	 +sWG0UbBlm6/g==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A52940131;
	Thu,  5 Nov 2026 01:27:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 23B75A0070;
	Thu,  5 Nov 2026 01:27:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OGGGKdZ0;
	dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com (mail-sj0pr08cu00102.outbound.protection.outlook.com [40.93.1.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6DBA8401E4;
	Thu,  5 Nov 2026 01:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP4K3pGwJm2gyWFBnU1aiaI3MXvpr5LzO2FAwEhO9KDrRUk2rwNkjANojANT9ZJ+yzBvqc5YMjSpixNU+buU6PV1uoNU3buDh0FLF3zrzqFtQLynvSdLR0PP2ewgHdpSNEH2Io1txI+QnjtF5EhatcuxJcX/jFSdLcAWys1ESynJCNlzkn8OER2jl1scy5EKHgja0FQNg3lfRPZIiIScTC4sD4fcQcSdTMJ2kPfA+jUqJprVO91DuQZHAKMOlou4n7dvni7Z9tj++7QZe6kPeclvcUrxkMYsaIH7Ho7l6Sxep3F1ikl3yNOKWj18/WVt1KjGVK758NxQRSXKOXxzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnTMbVGWx7onKU6OfpJy+qn/yeWGzVgB2yIkbC/FSCE=;
 b=HU2iG42ZW/Gd2jjD+isNm7pRMNq7WdOS4vgMIFHdqEbzKwu5CDIktdaEu0ufCAXOdXEjlOgUcXheAYgyWNJYGD/pBBCf14SsvAPSAxlXgILSEJPGwKwlqhQLoH7+L5KzLWg4J6Pa/f6naQLv4r3aESkKHYUjaksIHuWjM1N+097fviH6+dd9TiqQizuKLnzyp7RukMZPKgFPYx6C2IIj6MfdnaK44eo48VPJq7pm/Z9WMlCOzqR0QfAkLn8b8QoFFHpdFUzZru7p0lZ9sN3EqT6vpRf70WRIGWt/7U/Q8LKJfIk4qlBoUNfix5EpzgAjn+4IYPnBrprJQA5ntPQAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnTMbVGWx7onKU6OfpJy+qn/yeWGzVgB2yIkbC/FSCE=;
 b=OGGGKdZ0WG+Ff5ibffAQAiVlphJCsXreelk6iAOq5jg1MXN5+CduxNsSxzAnDb0wIHOKezg3wpJPQNd8U3u5jf2Odk25ZkysFk5fKT9KCZwOLwMdEnotb0tLSq/h7YJq2nr6tJsQy1aUQiwVX5C+IQ/+jvAEP15TcbAeWHgvKSM=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Thu, 5 Nov 2026 01:27:33 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 01:27:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] usb: dwc2: wa for isoc packet tx fifo flush at
 periodic frame boundary
Thread-Topic: [PATCH v2 2/2] usb: dwc2: wa for isoc packet tx fifo flush at
 periodic frame boundary
Thread-Index: AQHdbF9mZAbfHR+EhUS/P3nQdLlRMLcesLkA
Date: Thu, 5 Nov 2026 01:27:33 +0000
Message-ID: <auvbRQQXJsnbhvQw@vbox>
References: <20261104-dwc2-fifo-fixes-v2-v2-0-2bb13820f662@foss.st.com>
 <20261104-dwc2-fifo-fixes-v2-v2-2-2bb13820f662@foss.st.com>
In-Reply-To: <20261104-dwc2-fifo-fixes-v2-v2-2-2bb13820f662@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM4PR12MB5745:EE_
x-ms-office365-filtering-correlation-id: 034904e0-8e4b-4c0b-8b0a-08df3adbf783
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261102123227099003|11063799006|56012099006|4143699003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 ynbLDf5UQiFxnI5yKipiDmSh95upWvJRMkbCI36CZUWGMzx2ouQKOgmiepd5HZ3XvEgbgv+TtCgR/CANeg6EcC+HGcC6ELDm8LOnXxwlKd2e3HjRo/awJTh0MVFfwYjh2VZbHt/TNtorFJ68Zg0QXvFNJ4qFYr2VEVPusOZ0bvuvWyyfecfFKHpMxcDbvdjbcNJO6eUrHrxOHz8x1LAyTHRqAbu9GhhthgcB7GyJfVSfR0lZBEcdmaH05DuUczXxUuRWINu1zFoSuYNjPIO5J/gpGPOiaaj1qqye+umJvgDTNo2efDrNMEtcC2pskRUlJJyepf2qHBg/1GPROCSFnOqVhojzd6yEUI4m06tyGWOJ4ExH+ii6OHyJj2gp7PwpVmQ/YfFR2tEd1sVvjovmPai0GJl+5rbkWS1RGvn5LyaGA5v4FqQH4CQbGAcUjTIifsNWYU1xHF06jyhk4Av75hXkds9WuMyd2/TDUeCOh652bwXXgVhpC/58CISek+YyPkt6Kjr9SpJz/1sb9wpe2CG0Qop9tdDUhQybiwXCDii57ta3mBtdW19Kzd12EkrIncGPFKrP0aTJxHkPtBu704TWq9koG35bBs+TydUZxKUB8X6sHbpSPWgHMqFPD9DoYOEEw0NmNe9Afe/5SF1VZoBR2rjSR12mF1QMVw4YbPvMBVnl8l/SVRNzIFi4i0J2ZZuGBv/x/zeWeTV6aQDsq+KrmZxT3aAEK8UfhUO/IDE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261102123227099003)(11063799006)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzNRdDBOemVsb0w0ck1OV2c0WWZXRFl0L2l0ZmVFRjlpQVBtbm9FeFp2STVD?=
 =?utf-8?B?cFBRUFpkT3FQbmIwdGpyVW9zOVVVU3hnZzR0YnpZOG03alM1dythZkRkUi83?=
 =?utf-8?B?MjA0WERwR3RxNXdBY2tFeEU4QzRVQytNMkpDZVNsTEZXL08wSkJvRTdCWmkr?=
 =?utf-8?B?T2ZtSWdWaEhEa09LNkZ0bGlpYkpreVM4c2dRVU9sS2ZaMFNKMm1Bc0dWS2JF?=
 =?utf-8?B?Q0l3ZVdWci9zK0F5TmlvZVptdms1VDJ5c2pUQlVVNGl1dlNERW0xY1E4NFFZ?=
 =?utf-8?B?T1VqV0tzWUxXMzNERGU2aFl4aWpxcEJ0L1FVSlNSa1IrWlFqbmt2dlArYlM1?=
 =?utf-8?B?RTlRVnpibDk0U0JJSER0bHZPV3dyQU8xMm1MUXAraG5IZVR2SHpxU2tHbnR4?=
 =?utf-8?B?alh6UGM0dlZBMUVDU3NNWEhFdE0zY01Td2wrdnN4ME5HVWpvQWI2RExWcElH?=
 =?utf-8?B?QzhmekQ2b2N5My9kSWtvSnFwaUZHdXIxVzFEOUZ1b1cwaFBiRTNIMEU2T2tI?=
 =?utf-8?B?OWZDMEtJY2hOanlmcEhPa25ObWhKUWxvcThKMWlpK3Vxdk16cld3aGgzTGpK?=
 =?utf-8?B?QUo1RUxBbHRjYVlUTlhRUStUMVZEYTFOdWU3SzEyNUhlaDN6TUozcUo2TTA4?=
 =?utf-8?B?ZXM2MmY0cUErcysrck94dlozUFRwejBlbld0YkZDblcydmN5QWVmNmRqWVdI?=
 =?utf-8?B?cEtqSXQ2aHA0b0gxMU9HTFNKS3VCUU9scVRSU1BtUnlxYTZ5NWFSQUVyRXZx?=
 =?utf-8?B?WjB0SVltZlJsekJJRW1ia1gvbFI0eitaNmduZ3VtR29ML1ZuLzh2b3RyMHh4?=
 =?utf-8?B?R1EybjRSc0RuZWlXeGt5VnoyU2ExVm0rK0NXcUEwK1hFa3p4VWdYSVpWYjI2?=
 =?utf-8?B?a2N0ZW1veWFFVExXK2Z5YkMxbUhncEhBajhaZFlTQ2pQcEhmeFJTVXpLcWky?=
 =?utf-8?B?MWRmaHl1ZnVhYVZmUTJWR1ZaN043Q2VTWjhycmloSVVJR05ZTmxUdmUzMVdZ?=
 =?utf-8?B?T0c1S3VNaGgwa1dlWkhWcHFYcjBaeEFGN0h4R293T3BhcUFSNVNsb2N4VTZw?=
 =?utf-8?B?bDFEdWVmaE8zVm9pVSswamIybWxtbCs1SExobm9lZ3ZoQjhFR3N6QzJPSjN4?=
 =?utf-8?B?YzEzbUVia0dJTGhsMmxxU0kwbk8yOGxEWWF0dGE2dldGdW1PTlJ1SjRZc21P?=
 =?utf-8?B?T3VSci85aWJod0xvZW03eHRzTTF6Q2txSzBUcVNtK1ROQ09odkV3RW5sRUw4?=
 =?utf-8?B?UXdQRW5oZjVsUFNHL3N1TWRNNDZnbjNjVmtJb2tKTXVOOThMMFA1c0N5S3Uz?=
 =?utf-8?B?YlB1ZDlSVG9jSWltZlFYczQ3OWtSMkJINkhEUG9tODloWDEzaWhTbDhVYVBk?=
 =?utf-8?B?YzlTWWlvVU5pUHVkbUJJZ2xDbUhadE51aVVoTnp6RG9RYkxSUmhXWjIvcE1T?=
 =?utf-8?B?clVMZ0ZGL2pRSFpCYTFFakhSVlN1WWk3R3Jld2Q1empkUmV2ck5Fa0VmNnor?=
 =?utf-8?B?ZzU1S2dzcjkzZXpENzRBWjZtdE5uTkcwbC9GSlhOSVFtZXpZVkFNQnV1b1Fq?=
 =?utf-8?B?NUFXSG9rQ0lHSUlDMnJCUytuVmJQYVBENFJ3MU9QbldHUUdZUzhQWGhyUDZK?=
 =?utf-8?B?Wkhab3hnQmhEdmhnYzBxRENuWlhYZTNLV3JLVWVCMUduaFExbXNLNk0wajh3?=
 =?utf-8?B?eFdvUjRUcHpVTVZ5SHlSeDQwK05YWXJDdFdJcDFZTCtGdyszL1lGYTVFNG9x?=
 =?utf-8?B?R1hJQkFuNlAzZ1RzbGk0bThGZUlCa2lEaHhBQnJLNFI2NU85VHg3WHphcXRP?=
 =?utf-8?B?aWxRdmtPNXg3VzdLVEtlTElNMlZ0N25jQVJZV1Z3RXozRjRXT29LQThQRjhK?=
 =?utf-8?B?Q2pzQ1ZUemIyMTF4bTcxNEIvRnI3YURjYkZMbFUwMEE2VDVnWFB5b2JJV2dG?=
 =?utf-8?B?UmFCdzB6Y0hSaVpFUjdHTEQ3YnRGSElROE9seGdtNTUyaGRaTTBGSGM2UC8x?=
 =?utf-8?B?YTFrL0xtb1lrSFdRNW1RdlRVOGpaN0pBR29xdXI3TlYxeWhEQktZZjl1dGxT?=
 =?utf-8?B?aVFNemZpU1l6dVVpVXZ3a3Z4MkdhaFNMZjZVOXQ0Q21nZ25JOVVONk9NVEJC?=
 =?utf-8?B?bFdmcktkanpTbStucVNINEg1K2U1anJyK3ZLbUtiTWw1RE1YUFRJcFl2OFRk?=
 =?utf-8?B?alVzS09XVFZkeklOaGJhSjVrZ2I5cklJWEtySDE1eUVybkV3NFFkc3djb1h2?=
 =?utf-8?B?OC9IemdtSVJDZ3hvTXluQU93cUtlMGUzVmJLdXpxVktLS3J3eHpUUVNCa0hZ?=
 =?utf-8?B?dHhnYXlYK053cW9hQldWMjVZQy9JUlgxYjJrT0hrTWliNHpCQTd6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EEE871ABBE4B14195CCA0F60BFC2D4A@namprd12.prod.outlook.com>
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
	BKfk82UTRVPEjfDWtM4MNVKngqfyUuI9wEhjCOsFmW93uw9TsDVmSh3otcfz1QrCTc5SdBp2qGHuA1m9b1hy4Q35dZN+xdrqo1zv8FyfXlYDs9xm92xyjV5XWqnfuk6j/geSuuVv3W5Ijk78q5cMlO9vebnhHdMm0c4OEB+CT2anZN2r+RKp6bDjrcZ1gtL7oiJftrjQjMLdzx5ZD0Yiv5VLzHGW8hqT9FlzMsl9oI+tB3qE6voFwcOoc/saK6CRRwx6113ihon7ruwlCIYIFkFEyfs9wqVxxEZYArPmqnNictbIjTa0146C/rp1YUquPis/IJWDWBj5iuN3V1V6hw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w9cdlzw3dgo3W64Vc6GJ95saP+65gZ/IT7wlJADOOxPskqB7Wb+7PEdBMaZiRDZLKkaYAoWEJafsSEv+ZySR51Z/fPv17hbus4d5dNOzdx9S2TaVd2Ug4Lgjb8UunOQpNY6RxLxQeRS0OULIXx1Hv904JdsRMfqQlcXv3QAI1djdGpXJsNQ68mLto3sGc2wwf8Y5SVQVQij1m09vvsr0QcfkoJC0XK22QW/SkALfK6XvVa7cCfP9fSYLFaYBvWrwskx9WXE+ziSSia6pQ5oBaSKhiQYy806QxmS1jURG1MvBRjLRKUDJNc2xbZ9lgmD5hlv5VtiY7GbjwEZg2cRvpjttVl5zv0yIiK5W0mCmupRTa4fnpL39RDjYsdK3czWPC5lgQaFxPmIg5IoI1SikDoS9Fyun5MAvdjkKRiQ60rMpwRJX9+sQ2FgUwAgCyQmD5mTPj6ee6otK+gNEL5Wtnr3ZSRrOlOyLRKvFqzfJTjZIn7VVfkQ1M8SHu2JB27UdOnbXcjPGwfvnYF5P49Dlx4YCrkevRkFIre6k/2fe1qkFVKV2MkWa8doQ6qwyqRKFUfeHRByLJELim7v5R+qx9Hmi2sOduDEZYWXDZdKSL8Fcwb/x2FObV/ztRb24C/klIWAiGh+eNvBP6XnCjCipjw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034904e0-8e4b-4c0b-8b0a-08df3adbf783
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 01:27:33.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkfzYCqe02bn+oUOhsODXiNf+YXe59Asqvz3U/lPFlTOZa/0JLHQizNm81rJPPs/eguTsepsvoJcmbKS0jxKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Proofpoint-GUID: zvN6aTVoDm9-UwevGVHZRnNpGkGer2pK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAwNSBTYWx0ZWRfXzesAketRi0t1
 i5JWKrGtbN1feCQ8laqL6zc4TrXXM9loPQf67RiSMt1yKdbpbDohLapjoo2D/di6NrYCaR7hmwx
 TrNVImQlGQErZKz1TdwVV/g1GgN2vHU=
X-Proofpoint-ORIG-GUID: zvN6aTVoDm9-UwevGVHZRnNpGkGer2pK
X-Authority-Analysis: v=2.4 cv=J6s/fwnS c=1 sm=1 tr=0 ts=6aebdb8b cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=jIQo8A4GAAAA:8 a=vFReqyp3GkJumYeHLYAA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAwNSBTYWx0ZWRfX9Wr8ukDADtRQ
 qJ1S/JP0NUs5Abitw/RRlL2IRFoiYOle+gcZ8U/kHnQKHkTMU5mZqv66mw6EWGAqsRyHIK7+CTn
 p1CY/EQkqYnyooCuh7moi8kRU3JcLqNfK60j3SNH/7yuon9CGqosDut1inkc38YT2DdZFGnXkwR
 qSAUSF8M18XVngI4g62P5Q1FWvzUXIGcGbsDi23tvh48rxly7fzDClzekIUOdi006H8yuSAyl0G
 oC0sM6+XrbkUB6ieP2YBtKO8N2zo7nbEEQ3PzIAeD57cDmpg5fMHS9MVHFpmE3sbJrw7Qt/7Kmq
 DnBV0klscHptHRAAk/ASp/e1u7vVMroLKe5X8Hi/8t4xrd1UIBeZ5GnHtN4yVpynvUJvxSi0dQP
 8j6bDmeKezsKT2BYzJH4c+++lnjZIcRVqUQ3li11EGwz9z+gINZFR9JwOVloNTvDnKCTxHdPBrf
 iHxHN8pznd1mwp+O/bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611050005

T24gV2VkLCBOb3YgMDQsIDIwMjYsIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gSWYgYW4gaXNv
Y2hyb25vdXMgcGFja2V0IGlzIHN0aWxsIGJlaW5nIHRyYW5zbWl0dGVkLCB3aGVuIHRoZSBlbmQg
b2YNCj4gcGVyaW9kaWMgZnJhbWUgaW50ZXJ2YWwgZWxhcHNlcywgdXNpbmcgZG1hIGRlc2Mgb24g
ZHdjMiBjb250cm9sbGVyLA0KPiB0aGUgZGV2aWNlIHdyb25nbHkgZmx1c2hlcyB0aGUgcGVuZGlu
ZyBwYWNrZXRzIGZyb20gdGhlIHR4IGZpZm8uDQo+IFRoaXMgY2FuIGxlYWQgdG8gYSBodWdlIHBh
Y2tldCBpcyBzZW50IG9uIHRoZSBidXMsIGxlYWRpbmcgdG8gdGhlIGhvc3QNCj4gZmluYWxseSBy
ZXNldCB0aGUgYnVzLCBhbmQgcmUtZW51bWVyYXRlIGl0Lg0KPiANCj4gV29ya2Fyb3VuZCBpdCBi
eSB0dW5pbmcgdGhlIHBlcmlvZGljIGZyYW1lIGludGVydmFsIGxpbWl0IGZyb20gODAlIHRvIDk1
JSwNCj4gb24gdGhlIGFmZmVjdGVkIGNvcmVzICgyLjcwYSB0byA0LjAwYSkuIEl0IG1ha2VzIHRo
ZSBpc3N1ZSB2ZXJ5IHVubGlrZWx5DQo+IHRvIG9jY3VyLg0KPiANCj4gRml4ZXM6IDU0MGNjYmEw
ODU5OSAoInVzYjogZHdjMjogZ2FkZ2V0OiBTdGFydCBhbmQgY29tcGxldGUgRERNQSBpc29jIHRy
YW5zZmVycyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6
IEZhYnJpY2UgR2FzbmllciA8ZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tPg0KPiAtLS0NCj4g
Q2hhbmdlcyBpbiB2MjoNCj4gLSBUaGluaCByZXZpZXcgY29tbWVudHM6DQo+IC0gRml4IGEgdHlw
byAnZmx1c2hlcycNCj4gLSBVc2UgRENGR19QRVJGUklOVCgpIG1hY3JvDQo+IC0gQWRkIERXQzJf
SFNfSU9UX1JFVl8xXzAwYSBhbmQgRFdDMl9GU19JT1RfUkVWXzFfMDBhIGNvcmUgcmV2aXNpb25z
Lg0KPiAtIEFkZCBhIEZpeGVzIHRhZywgYW5kIENjIHN0YWJsZQ0KPiAtLS0NCj4gIGRyaXZlcnMv
dXNiL2R3YzIvY29yZS5oICAgfCAgMSArDQo+ICBkcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIHwg
MTUgKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaCBiL2RyaXZlcnMvdXNi
L2R3YzIvY29yZS5oDQo+IGluZGV4IDAxNWE1ZmI3ODQyZC4uNTRjMDQwZGEwY2FlIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2My
L2NvcmUuaA0KPiBAQCAtMTEwOCw2ICsxMTA4LDcgQEAgc3RydWN0IGR3YzJfaHNvdGcgew0KPiAg
DQo+ICAJLyogRFdDIE9URyBIVyBSZWxlYXNlIHZlcnNpb25zICovDQo+ICAjZGVmaW5lIERXQzJf
Q09SRV9SRVZfNF8zMGEJMHg0ZjU0NDMwYQ0KPiArI2RlZmluZSBEV0MyX0NPUkVfUkVWXzJfNzBh
CTB4NGY1NDI3MGENCj4gICNkZWZpbmUgRFdDMl9DT1JFX1JFVl8yXzcxYQkweDRmNTQyNzFhDQo+
ICAjZGVmaW5lIERXQzJfQ09SRV9SRVZfMl83MmEgICAgIDB4NGY1NDI3MmENCj4gICNkZWZpbmUg
RFdDMl9DT1JFX1JFVl8yXzgwYQkweDRmNTQyODBhDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MyL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCBiZGFi
ZjNjMzlkYTEuLmI4NGNiNmIyY2VmYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9n
YWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC0zNTExLDYg
KzM1MTEsMjEgQEAgdm9pZCBkd2MyX2hzb3RnX2NvcmVfaW5pdF9kaXNjb25uZWN0ZWQoc3RydWN0
IGR3YzJfaHNvdGcgKmhzb3RnLA0KPiAgCWlmIChoc290Zy0+cGFyYW1zLmlwZ19pc29jX2VuKQ0K
PiAgCQlkY2ZnIHw9IERDRkdfSVBHX0lTT0NfU1VQUE9SREVEOw0KPiAgDQo+ICsJLyoNCj4gKwkg
KiBXQSBmb3IgRGV2aWNlIEZsdXNoZXMgT25nb2luZyBJU09DIElOIFBhY2tldCBhdCBFbmQtb2Yt
UGVyaW9kaWMtRnJhbWUgQm91bmRhcnkuDQo+ICsJICogT25jZSBwYXNzZWQgdGhlIGVuZCBvZiBw
ZXJpb2RpYyBmcmFtZSwgYW5kIHRoZSBjb250cm9sbGVyIGlzIHRyYW5zbWl0dGluZyBhbg0KPiAr
CSAqIElTT0MgSU4gcGFja2V0LCB0aGUgZGV2aWNlIGZsdXNoZXMgdGhlIHRyYW5zbWl0IEZJRk8u
IFR1bmUgcGVyaW9kaWMgZnJhbWUNCj4gKwkgKiBpbnRlcnZhbCB0byA5NSUgaW5zdGVhZCBvZiA4
MCUgdG8gYXZvaWQgaXQuDQo+ICsJICovDQo+ICsJaWYgKHVzaW5nX2Rlc2NfZG1hKGhzb3RnKSAm
Jg0KPiArCSAgICAoKGhzb3RnLT5od19wYXJhbXMuc25wc2lkID49IERXQzJfQ09SRV9SRVZfMl83
MGEgJiYNCj4gKwkgICAgICBoc290Zy0+aHdfcGFyYW1zLnNucHNpZCA8PSBEV0MyX0NPUkVfUkVW
XzRfMDBhKSB8fA0KPiArCSAgICAgaHNvdGctPmh3X3BhcmFtcy5zbnBzaWQgPT0gRFdDMl9GU19J
T1RfUkVWXzFfMDBhIHx8DQo+ICsJICAgICBoc290Zy0+aHdfcGFyYW1zLnNucHNpZCA9PSBEV0My
X0hTX0lPVF9SRVZfMV8wMGEpKSB7DQo+ICsJCWRjZmcgJj0gfkRDRkdfUEVSRlJJTlRfTUFTSzsN
Cj4gKwkJZGNmZyB8PSBEQ0ZHX1BFUkZSSU5UKERDRkdfUEVSRlJJTlRfTElNSVQpOw0KPiArCX0N
Cj4gKw0KPiAgCWR3YzJfd3JpdGVsKGhzb3RnLCBkY2ZnLCAgRENGRyk7DQo+ICANCj4gIAlkd2My
X2hzb3RnX2luaXRfZmlmbyhoc290Zyk7DQo+IA0KPiAtLSANCj4gMi40My4wDQo+IA0KDQpBY2tl
ZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3Ms
DQpUaGluaA==
