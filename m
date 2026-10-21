Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543108;
	b=Gn4xxs0gaGZNH/9DF39n0LL41URi4v1GWU5GRK83mvdf9Jz3kiM6PEL/WPa6JL1pEM0A
	 c2P1/ZsIaa7ZP/puSn+4eXR0m0wZGtpw3XYDXMwVVDVYDXmveCNskjtGu/L4+/N4itLCQ
	 +5vg4zIEYFHWa1u3u2blh5ghCtkwRsGDru0kvYub3X4XMVD3efeBZEtRdt6Rwvrsk+Wze
	 0sbcIlboKP00BKw+2WsfJFK9Vf10htpUByhuVLhayqQbBZuHLr2NM2j7lpNKCjAy7xoSl
	 vK1cpZnSc7PUkWK0hqLPPgHqRSwtzDmUfybXP9rAAFl/pxUpCGGP0L7ZDE8mgwI3ZGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543108;
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
	bh=HuyAQEVUl/6lXt11tA2Z+obmhABSsG2w5EsnT2TrjSY=;
	b=t6lkXBJw0A3PoDoOmuuWiiFN4w2o43dK3SeoC2jeWH+UnndP0JONrlr8Vxvwfs2fYBSc
	 Ex5GZluCiGDw2SmkBBtUZ3CpZXuwiJTh1wdzJ0SRtUrvQtUPbTn9tzvri7zS7ZUOkxOKs
	 dmicKYmX35nrhcPMAggSOSqtD/AIKcWSW4cD3tNHxE0aFSz4zj12ni6wlRMk0GGRPziYG
	 RcRbix8SHdwsw52tqzRF1/5NeenoX+MTE1Om3RTb4EiqntCOgYKUPx1QS6/UDatWSaFK0
	 LdA8P5nKcDVI9PGWMaqaxp8KHslupJr5D2Ff5zR/oQZrQeYkQ3Z4v8x+svw+v376f0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=mxN1IiOX;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=ZaxPo1J7;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ggXRZfGn;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2D606A319;
	Wed, 21 Oct 2026 00:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA2D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=mxN1IiOX;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=ZaxPo1J7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ggXRZfGn
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKwtLQ3684511;
	Tue, 20 Oct 2026 17:38:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=HuyAQEVUl/6lXt11tA2Z+obmhABSsG2w5EsnT2TrjSY=; b=mxN1IiOXCRnI
	zmiPGLLyexFmZnNnUdQp0MnEWK7YAEZefY9NQBDJAalC0AxAHcXiNCaT5TyPdbQV
	KAq4t99JXvT8h2eWOqbF+DaMXLNs975AOfXa8nz0PMTboR/eVpvYrVHlP7Cvy4Rt
	hyRDX8CVp2c1JB2OtKWAt274JMxIjyfJEZVUqCXcHXTW05sIfmQh+eVrJJv6tUxT
	M+df3c6pE8wWMX6mCx47vfZGNlAsZOuIq6j2I8YddKmpVBTzi+DmgeKI19FfZVDm
	Dkl53mbUF41RHu+QKfWM5UeKHTkpX+hZeu/qbytOFCYj4WICtlL1fkjL5gJs4z/Q
	vkQO6w6PnA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4hdw70g82s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543101; bh=C8f8ubeYMT08bl8CZCY/XIaAiqO6EgDNG20MLkF+i3c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZaxPo1J79jp/KJTpur/Q9OuXOvzodGZS0wnL/AXvH9yf5eKXwhGoKs/wD8LAq7XUF
	 RO9IRzBQG4RimDgBH1vv/lxJnWI2zFurJVKekewqaoMBPwWvPsYSjy7ZvsyGdvDwyz
	 FzcjDjTmtXHB+4K/CkW8nj4gbyeTCosyAx5iWtVXkTftg1rf1PHn04KnxnqOJGz19v
	 RSS6j7TyFYwEOHybC7WgeOSqEdOfMlbb5MgEvdjqVIR6MJI9pxq1rgxOb0tiHVquSl
	 tvQbNAVLPTgCDs7BqQ2o+2cwy+4BY2QprwCTZ4GxKwKA31t9GmdcZ6kq7xjrGwxGfs
	 moG7mFrF01QMQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 23BC6401C7;
	Wed, 21 Oct 2026 00:38:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 06BACA00E5;
	Wed, 21 Oct 2026 00:38:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ggXRZfGn;
	dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com (mail-dm2pr04cu00303.outbound.protection.outlook.com [40.93.13.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B748E401A6;
	Wed, 21 Oct 2026 00:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYBXcXQxvEuwasz4OUXCjcoHVO69mhjTDZMso6IL1z9FkniK5BsMXWMv7qMf9El2X++yXdYHB5CiK4wTvSucnYMko/KYe6TH6klfwxEsn+tdFDTdqeqsK4N9DWalAEPMBZ9g0RgOGR0q3aM6+wbWQYbAugC4J9wqW7Qesj830uEPqBmwpjEqA5m7y7s3ohi1883Y+uicBwlxyEklQLZ56qc47Yc2SiMckhukcGtDfHIy5gRW3HrlPCcrrp2z2KS7XN1UQr0rb69P19TPx4mTFXnTW+ptMZDexhh3wvF//nWUCjX3HpeAfyKaUSxc9Grevxp01MeB/3PDVq2TRrQn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuyAQEVUl/6lXt11tA2Z+obmhABSsG2w5EsnT2TrjSY=;
 b=n4DQqMXRv8TUt69lknNc/fmmBTLlsJyxV91AYWEpb8b2VF5Jlan8Uxcww9Hc07VE6pNMOZgk7wfJzvY7+rOCgo1NULuOU6VYxt+CEara6Brp1y16EejtkhUUjU6YAzzzhGEtjiI2mbq1BnOWSjs++El+CffE3z2Dx8S6kx5zfU8Itgwt1TfYZCtHi0P88nCtV9DE41f170H4zqpCIOOuo81NSSzdjY0b0raZDBNM3DcH7KGrTKuFIrvVHmc0L1o+rKW2EqY/nNvoWggjCuH1yh33m7/y2Dj8jiMdOwpZodxVnqsaKWLV6lbNAwe5oak9cu5iJBh37MEFXyBEl8yOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuyAQEVUl/6lXt11tA2Z+obmhABSsG2w5EsnT2TrjSY=;
 b=ggXRZfGniqLRWF97W2gg8bRyi9WSKi4EE7nUsy4MeG5rL2Y+CrHPYVguqlmWpr3wBDd90s6U5VN9Qr/EFPxzN23IuN/XgCWWialNJPH192iUAZyZSw+O5D8xtyjQ2rEDnk9YujLjGMplG4F3bARVGsT+MOCGhNGsQ/rlRJ3NR84=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 00:38:13 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:38:13 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 5/7] usb: dwc3: gadget: Wait for End Transfer completion on ep
 disable
Thread-Topic: [PATCH 5/7] usb: dwc3: gadget: Wait for End Transfer completion
 on ep disable
Thread-Index: AQHdYPR0vMKNvIZqoEiCEvVM9AjrEw==
Date: Wed, 21 Oct 2026 00:38:13 +0000
Message-ID:
 <24fa8adeb0222dab415c8c2799405188440bad4b.1792542945.git.Thinh.Nguyen@synopsys.com>
References: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|PH8PR12MB8607:EE_
x-ms-office365-filtering-correlation-id: 847a3dff-64a9-4626-5a00-08df2f0b9707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|11063799006|5023799004|261009223027099003|10067099003|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info:
 VXwmhA7bX3h4XeKEP+0wWOusgvQWLgAtzMceDRIHhRMzSbhAaDMLlw87RHyiA7WZUMqGnr9tyZtgdt9glF2zZQEA0Fvn4RdTsiISQ1J3NEFmHk/X6a6WT5yh0ORK9kG64dzbm157wQ+TTtAVrsW8rxj8EM7SHnoPeEDQZ5jEvjJwWQPKo2R1VHjEk084hvviq3IdhJB3NpD6ghEKD8AQjGsetavUgNsfI9Mm0+4BZ4Nj1wXcH566pEmjyGa9theJg5CM7gFA1mu2V4oOj+oot/De6Crk2M8jdtPMaeCOdt2UrIvJxxIuqimfQCb2Gfskhw1iuiVoHv2MT4MErt5d4GFCGQigYVDNILm1VX7CQlJ+ugzuFoWRYylLfuN52Zowc5WmA9g1WCHbWLgI+W1W34y2UzkTU+wBxFXgapWHKsZ8G5yzJjm4tB9BDvjZYqWZaWYr10yITiJS35uYKlDk+sr8i0geP6ibeeH89QaVHfO95bO55qy8/Bp5W0hYWqwNNoBHozsmxregOC2Jh8RPWtLIdAhoKRJ+Vw0p9w9BbI7R16jN4Ej04H5kXT94YXL84LX7/zLs7NgQGJBGwM8/4WXY9JJrrIEFuxBwbhrj2eDKCH2PuDcAoUZoXYIk9ngKXWiqHl/YcUURz4a4Fi21LgFChnqKgZ+jPn920AI2TIo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8/icqBY6Lh/+BGISipP+/scYwmy0XgRdRkudIcYNWwp1ZBEsNE2YJhE7KS?=
 =?iso-8859-1?Q?2+ckvUDG2HbouO57nUGQ0SbS1RI4YySIQFZf4XIxWVw7SWJBsmk2zNlP3o?=
 =?iso-8859-1?Q?Fzs2aZUHTsYMn9Lr0XZ0TC51GCUm8ib1xU9Z/VutXhKKh5KtLh+BWtu5mF?=
 =?iso-8859-1?Q?YKNzfLFBYbyqTqQfUPBKZ7hSVSuMG+CXFVRPo0E7GZzp/FU6LTjwgwHRiD?=
 =?iso-8859-1?Q?W2H8qeJWBdlRI1nl6GqZJ7FDINAk52NbYAGhxPMC43WjLLi7kyhyu726v6?=
 =?iso-8859-1?Q?gLhcXBQWvo4q+zg7cNHv7+CljiIrxB2JfknpCPn91NnAn1HNUWwOqDZI12?=
 =?iso-8859-1?Q?thIfhQg9NY4+NRxO2BX3dOrZ51NiQ0l3/0nSAHB9ZrhUo+htOjjQMnxDXp?=
 =?iso-8859-1?Q?+wzNuyjJYKHHishzCR+PtmaQa8QjtvSdQmFSbbH08mnq0cAZKXWbPh/xZT?=
 =?iso-8859-1?Q?tDAtfwfmsZFzEo7iSBsnNhI2Mn1H1PWLqNS6Kwavg3KXs7PDAIvjBAaaYl?=
 =?iso-8859-1?Q?09NL6c4lzW8HvmkvSM8azDaDlZj3obedxMkFF4NUNJiuXrJB9TAQvtuXZX?=
 =?iso-8859-1?Q?WxhK7dG+O0CKr4rRczsSaI8NQbmCvPR7CxhEp48ypI/YduLoi56UayjTyI?=
 =?iso-8859-1?Q?Onr/He0laMr4r+EJnCINHWP+INRqZSfAcq1tQ+Pfs2AMFx03n0M3HidNeE?=
 =?iso-8859-1?Q?8U506wYnYfOxkCJHR74a9azYH+mf82qIHonW9DCE8K+q6GbFqIfvhz9Ljg?=
 =?iso-8859-1?Q?2f7ecNYgce2L7YNBp3psxHIc0OojHzqGjux2S7+STYCsnIREtHPj1uBc9Z?=
 =?iso-8859-1?Q?VwA+RtRbQfDbD1Ail25tm1a9BfSgqmLTX0iYIidJ21NaOq9ejl6bNWWhye?=
 =?iso-8859-1?Q?819Gn+87Vr+QKNJl1KJHLLIcfaiQSr1xZERcg+ilJIZx3Maz0h3vOlD7T8?=
 =?iso-8859-1?Q?h8fJft7i6bpR0KtEA1rlwiBY23w9x/RnJn7j6PNDIz43MUMl3dud2rwmuB?=
 =?iso-8859-1?Q?Hi35as40iWHgY3pOHWpP+tXM7AiBf9zb0pagT+JZmO8cgk51PvtLoUjDjy?=
 =?iso-8859-1?Q?eUrH4TDsXC/Zk4gJ1oLM5D69LX2QxF+PXcIXXiCW/FqfZUAxUer8TAnpDT?=
 =?iso-8859-1?Q?P6IGQK6GUdkRWdpC4GaziraRc5hXMI9Xxv2WHrGy/xGlvUl8tljAjitXRh?=
 =?iso-8859-1?Q?qEh1YpbfwOWvDEEvfBPqhU8GlyQuLSENNJoxrjSFG2o90aTcLeruIDi3Ek?=
 =?iso-8859-1?Q?kSDi71QIFA7PgsRf54xK1utP9J7g3LI7TX/J6J0ndWno0rYGkcWiofaqVY?=
 =?iso-8859-1?Q?Al/x5DIsJ2lzCG3OoMIDmGqjojx8yU7VLL3039lAu4f9/76KFjdA9D9Yy3?=
 =?iso-8859-1?Q?66MAAtbuo7D3JVybg5exUw0HRjWKirr5NeqLQDMfhZwP46fb8aaULdrZEt?=
 =?iso-8859-1?Q?F9yq7OP/tVKFT4tOIJy6ZXoyR7Q+cMv/IPsb3fhqdkLOKd/ts7Wnnk48lK?=
 =?iso-8859-1?Q?9uEAoenl1QyuLF5q8Hab33yJnEvebfsorC3hhuRNuhnCb7cOmut50Y6Kgn?=
 =?iso-8859-1?Q?/ZnfEQlmvuDv453hhC+dKpQYVaZ4vEEECk8IgYsgVXojGGredKhO34lTt4?=
 =?iso-8859-1?Q?q9cGB15VoRTVW49cwAPFViKWEb1Bxe+u4uyV9P0aE56u/o0PWyIrfxuHsr?=
 =?iso-8859-1?Q?XrTvJuC0xKQz0hkXeO/EF/BZ0Jnu1cKi3iTduEzZWFpAprUDmTbYV3Uchl?=
 =?iso-8859-1?Q?LX9okySOAwnGL25nbZG/j82dZJTW74x9G/3OhFfhuV+7imla0FSxyv++kz?=
 =?iso-8859-1?Q?SOP3rrpVsg=3D=3D?=
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
	Xnu590HLKarqtRxJLgres4falZSVTUYhKdznqaKAdleBlKk3UDhwzG3RoepfNmYCnXKthWUc48iDKyz2wVGfYhxxyXO7FoPGZ+aRrWlcyjqd/FOXVEBcgPWpdgkXZtlMPig1kOgYMQ0wU8F/2mrVdHi9B7Nw3dDj5KS3dzf5k6B7c6E7BHAD/BCQ672M5Ddq6oR3PPkY8EPb1F5ak3gh4YXsBVdvTz0b7INMlFrtcYNwlOG1MYX1YMYSwcfYzryTBBNlBNCaaXMT4wH9HrdgFsEoIgFPU6UkofEhmopNG9yi3E1kVM778bA+jahHZ4pCisfNpcaB+Lwh7NE6rm8Qpg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p8bgNtr/D0qV7VTL+N2AW4hiRJIdZL2cf1t3zgXcwoWLZk597UcQI84ZsE1iJXOVrptis0xBFKRh6YRSx7VfaKLUZQRjJM3PFyVg6QSg2SZrUXPMCGY1tX9A1lwiPSsmpwBCanOx4FfE9ecjXxD/qhLeHa1sXlKx0XdgqqHmrsiByDNYH4TU3CfwQK571T1aqaOiEBWI6JKQvIJcb12AjPvzDp+nyokPqq3hTJQ6yhn0YRoEOuSUoyFsM7jfUqc6Qyol+AF8VKVo4bntln2J+XFvAH40/BP7tVcMSksX7UsgIs+WjK+c7zELenHs4W0Kl/AoohKc5gtDpepo9jIdPMmnxZ7yPtwHQAJU9rmZ3cqu/iZAPjFyT1GoRY8eG8NwuZ04NazDCJqsqzr4JHenWvFh+3HJPvpCU+xdYYF8bPFQv0jVsj+1dlKCaJBhre+81EegwjGcOlVVUXV7CwgWe6pJqSvv2h4SiacsLpPJGb33lUXKhrtbqvSkOqfoD76Ybq5SDRjJFWyxiKnOXzSWJwdhaJes1p4kRr05RwSYYMnlJtYbcDIcETkxFvr3cBAjm6OszcVDPRkkagZ/sSft7cunsuoLNOwyU16FjjKtwJBI/lPal4GISVFsIXgUNJH8yEDRX5KqN6ROUPIeFaPUGw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847a3dff-64a9-4626-5a00-08df2f0b9707
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:38:13.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQh0Ry2/7Y2TzbRs0TseJMuL7MRVd5RhdbHJDHfrDRZbERzT24Wxg6JF9rW2CAJCbATK3YMeGAiP3Wygml2zZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-Proofpoint-GUID: yPkdtOZ-SvdF3PBHALJr7b8ESD8rKzdK
X-Proofpoint-ORIG-GUID: yPkdtOZ-SvdF3PBHALJr7b8ESD8rKzdK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXy2UK/eFOWFR8
 2iam+aG00j8twIfObeuMByP88juCjs5ybk3u96peL9mHqjpSZdUEVHbI/RCi+wo54d1hUs5DKzY
 4DQ2xIHUSOb92xEVQbJjduj77xjuHuRSuxQ1bttz3yTiuH5v4MZYp41C9AFsVKJy60pTfC+Pnb+
 g85qD0Mx8ivEIHAlyjc/6KMwPbTlEdnUSYQsB2ZuqGiuSC+dQD7i1dsAWjEmn/SNDyeR2FOkRDa
 1i7mn2QLDYrgjE8MwjcpTOLCb/Kzn78xGVqapiI8vQ/TchE6exg4bwEiRWADlO2cLPlvBBdXJmy
 Fs5ViaxxP+EOiYFCAQJOmRn48t4qMtVi9xFGthgz3smGgVu6tPf8T/ZQraBwJ/ABt4Zgecf4Ig+
 ObLGHaximDWe2kVhdhd3HGrPzuZgzJ4RAxf4XjE80cQaJPgYXI3Zluh2MYGYdZWB1F92g/dJJh8
 A0OOGg/oAv6keQp8gow==
X-Authority-Analysis: v=2.4 cv=E8RYNqdl c=1 sm=1 tr=0 ts=6ad8097e cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=PXEoWPVRprKaXEqG_kUA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXwRTJaq837DT3
 GcgDl2hE1KLkIDA4Vh4LWnWm5iBm0EsfSSNNB37uMUjuIkitw+HjreUpGurwbjoenkkydVH5Xo5
 Fn4BRsKhjU9GU+2WqpeLXUqDsNSmTg0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001

The End Transfer command on ep disable is issued without interrupt, and
the endpoint flags are cleared right after a fixed delay. The command
may not have completed by then. If the function driver re-enables the
endpoint and queues a request, the next Start Transfer fails with "No
Resource".

Issue the End Transfer command with interrupt on ep disable, and keep
DWC3_EP_END_TRANSFER_PENDING and DWC3_EP_TRANSFER_STARTED until the
command completes. Defer the no-op Start Transfer of a stream endpoint
re-enabled in the meantime to the command completion.

Fixes: c5353b225df9 ("usb: dwc3: gadget: don't enable interrupt when disabl=
ing endpoint")
Cc: stable@vger.kernel.org
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@=
samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/core.h   |  4 +++-
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 42 ++++++++++++++++++++++++++++++++-------
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f3dabb37f806..267c922ca11b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -771,6 +771,7 @@ struct dwc3_ep {
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
 #define DWC3_EP_RESOURCE_ALLOCATED	BIT(14)
+#define DWC3_EP_PENDING_NOOP_START	BIT(15)
=20
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -1695,7 +1696,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsi=
gned int cmd,
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
-void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int statu=
s);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int statu=
s,
+			  bool interrupt);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 46a34c4a046b..cf5a47b71efc 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -315,7 +315,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 		if (dwc->connected)
 			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
-			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN, false);
 	}
 }
=20
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e68584f20fbd..e531adc02a40 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1020,9 +1020,14 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *d=
ep, unsigned int action)
 	 * Response Update Transfer command.
 	 */
 	if (dep->stream_capable) {
-		ret =3D dwc3_gadget_ep_start_noop_transfer(dep);
-		if (ret < 0)
-			return ret;
+		if (dep->flags & (DWC3_EP_END_TRANSFER_PENDING |
+				  DWC3_EP_DELAY_STOP)) {
+			dep->flags |=3D DWC3_EP_PENDING_NOOP_START;
+		} else {
+			ret =3D dwc3_gadget_ep_start_noop_transfer(dep);
+			if (ret < 0)
+				return ret;
+		}
 	}
=20
 out:
@@ -1031,16 +1036,21 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *=
dep, unsigned int action)
 	return 0;
 }
=20
-void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int statu=
s)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int statu=
s,
+			  bool interrupt)
 {
 	struct dwc3_request		*req;
=20
-	dwc3_stop_active_transfer(dep, false, false);
+	dwc3_stop_active_transfer(dep, false, interrupt);
=20
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
 		return;
=20
+	/* Give the controller time to stop accessing the request buffers */
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		mdelay(1);
+
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
 		req =3D next_request(&dep->started_list);
@@ -1089,7 +1099,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *d=
ep)
=20
 	dep->flags &=3D ~DWC3_EP_ENABLED;
=20
-	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+	dwc3_remove_requests(dwc, dep, -ESHUTDOWN, true);
=20
 	dep->stream_capable =3D false;
 	dep->type =3D 0;
@@ -1101,6 +1111,15 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *=
dep)
 	 */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
 		mask |=3D (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+
+	/*
+	 * The End Transfer command is still in progress.  Do not clear the
+	 * flags, so that the ep is only rearmed once the command completes.
+	 */
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		mask |=3D (DWC3_EP_END_TRANSFER_PENDING |
+			 DWC3_EP_TRANSFER_STARTED);
+
 	dep->flags &=3D mask;
=20
 	/* Clear out the ep descriptors for non-ep0 */
@@ -2553,7 +2572,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *d=
wc)
 		if (!dep)
 			continue;
=20
-		dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+		dwc3_remove_requests(dwc, dep, -ESHUTDOWN, false);
 	}
 }
=20
@@ -3901,7 +3920,16 @@ static void dwc3_gadget_endpoint_command_complete(st=
ruct dwc3_ep *dep,
 			dwc3_ep0_send_delayed_status(dwc);
 	}
=20
+	if (dep->flags & DWC3_EP_PENDING_NOOP_START) {
+		dep->flags &=3D ~DWC3_EP_PENDING_NOOP_START;
+
+		if (!(dep->flags & DWC3_EP_DELAY_START) &&
+		    (dep->flags & DWC3_EP_ENABLED))
+			dwc3_gadget_ep_start_noop_transfer(dep);
+	}
+
 	if ((dep->flags & DWC3_EP_DELAY_START) &&
+	    (dep->flags & DWC3_EP_ENABLED) &&
 	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
 		__dwc3_gadget_kick_transfer(dep);
=20
--=20
2.53.0
