Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543103;
	b=3kqFZlIxx9Yyw7ygQuHtEX9rV3JOEUyrO0EQ4sF78gzrWq0W2Dq0VTl/u9pKyef9zoFt
	 JfnYOYv9vZWNBjcCmExCMq2V+dpiAExjGEIGrAl/+5SDvbhBtA6+9dz6Upw9RVPfVjDzX
	 cQCHoiwE8KLUf4s1lyNmvT2x6OI+kJsi11Wul31bxit3gE5A0HtJXkQhm3+rHoyLkCTz3
	 mvnYkBDZLjIXaE0SQF7tZxNqgTWDVRZ1fFf40ntPEuO6vUpnFtmZAU5Mur16VYnGfReZ7
	 ANLPLsn9osvUN+1GRAajgEY8L25A4YeO7fK4lVtXT93TahFFedMxfBAQ30LpKIRdTIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543103;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OOexhBcmKcrTrqPv+9I8gRKrU1m+QtvrEyI+xBW+5Gg=;
	b=DjjRTNYYBLT6k36jf+/S6KFivLBk8odeuK3bw+ToGmsQYOY0oS4PzCNKRRJCqGgRv38R
	 ndTf36IqbC0NQtETf8n8QMC3l/h+uCBqG0zkjHBIePi4U5bmzYGrqoxo5l8RoCy0RjJej
	 tuL/X3iM/YM0N5Bxucadz7CMz9oFxVhwD+3TZDCll00ZB7lcPyoiDqE3sNEDbAIpIVVIr
	 SDsoKrPlvwBpyy18DhZb3H1XxmZSBZcm1mOQjgXkZHpRSSObb5j5f2k0cYmCCQbVdkeRy
	 k/jRHqWJIRcbUaKzauP3DUguYQh9MUJ5H9wL8L6gGJOVUyRcH/yNEwfUEogUSvFwiog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=DP6Y43Em;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=kS9Fx7iz;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KNW1rG6f;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BD606A321;
	Wed, 21 Oct 2026 00:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=DP6Y43Em;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=kS9Fx7iz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KNW1rG6f
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKvoMc2052396;
	Tue, 20 Oct 2026 17:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=OOexhBcmKcrTrqPv+9I8gRKrU1m+QtvrEyI+xBW+5Gg=; b=DP6Y43EmmhUy
	AHIOpkfSH8Y2tj514K6reqLq3GhLcfpdceTknOiBarEJFRmpm8pbtFds6yA29LZ2
	pcrl8TwUmbg+UXRz1ObQCQ1Ifp4RXnCB0xGt8BjqCBPGnyYtX4GL1nnn2xt4iohT
	6dZRudA49cV1FoyskHbQaFfY1YKZd0J/dtynKJljWiAXQM5WLlU9vVGVAdnGoX6N
	8IKfIENsc/0bKMiEdamHwSSo+KV3TVVjUyxNneM/jvJa1tPa/0Ywgb+pN7AbXj6E
	uLY4YQt++xXfWBGcLh5RmxF880hFgVpIXn1UPOkcG/0gv3lQZRAbkKkCT5CbqhaY
	3UzRiKNfjw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hdw6v8ewf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543094; bh=X4Bx/mjPwXTXjDHyrxZqNy316Z7kLn0t2kRDDzosU2c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kS9Fx7izPZNBcYDmr6xE6DkVu90lrr8rpffib9/RCmWOLkjO+twNw6Lh7b4HF+bIF
	 3TlMG2J7QJSq8TgeAcaVh8NSWdip86qrpRBjiGIe9rQR5bTRzFjHmCyvHKFOULKAE5
	 XylGrbtg5bDUCIdrRkWIieywl3zT0R+9zIsfHyioBy7MDbm3wOlZJ4N9OwTbVrhL6s
	 sBWsuLX0EeTxF++SZLj1C2VabD6tmli2hIXObfSYY/EQtwjMWKlklPQD7YPC060VQf
	 gAvFexTswrfmm0qcrrCfQUQCSoCdUPxMCdy4i4FkwRStEFolfbCkux19nPrU/vHj22
	 OLkyY7KTcoNNw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8467A401C7;
	Wed, 21 Oct 2026 00:38:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 47F2CA0070;
	Wed, 21 Oct 2026 00:38:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KNW1rG6f;
	dkim-atps=neutral
Received: from BYAPR08CU003.outbound.protection.outlook.com (mail-byapr08cu00301.outbound.protection.outlook.com [40.93.1.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id EC1D72202F1;
	Wed, 21 Oct 2026 00:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X69lDpAZh6tEAT7JMOfBBlyC5ZuWGlOUgDfoSUwMquyA+ge24wOJb4JnRWAjo7JfGUf/v2FwPMX6HwWqE1skTx82wqHDmpihw0WRRnn2/+58ASTCVM3HX5D3c1h4uZGYVOeHrQXJ65jWoSpu7aYRcRYUSR9Mwg2lP42+LuPpXmfQhmfUfAmtxpN1Teiv93VUTJlg4vVCQIu4XFdMd88XxsP2vRpIlicQxm3t3AROREqyUpodSGvV0hI16anINKqctzwJHZg4jBVcwB5Yf4gayZur0a0RF2sKXfrwTWpMNFszCSdLbgju1UvrYyLhPWQJbfN5c83PTgTae4WfXz4CWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOexhBcmKcrTrqPv+9I8gRKrU1m+QtvrEyI+xBW+5Gg=;
 b=cw3NV1AWLUZ9ixq1ipXl2fCZ9yg1yMy7KwdV2H6f3zF0c8LqXSiY8Db+/yAOwe1l9IAEKL+S8NXgPJHCcK3K93E7l6bazPXKCiqQA919QaY4rHRa7WPCj4Ymq0JxIY5dx4nSAZ0QTR7bphQfUK3CJinLU8jlYIKT4zqf8KkHaeLe1IK3e9pKk9vzWie8+BmRvXCnW4MBkdVgwrddK1H1jGi/h/QKZxFvVfoEWy/8VN0t69UZQVQUX54xw/IAoUo7YOPunPcOz12LmUMrDxZ/XradbgveHKbIHyATWbaLOyS1coFhBS0lpz0wqcZ0w9h9zzIGLkdNGjjXsiPM/3/Dxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOexhBcmKcrTrqPv+9I8gRKrU1m+QtvrEyI+xBW+5Gg=;
 b=KNW1rG6fsjpkpqbeDJtqEcZ+aHmNcICtSC9p3peClyssvqWWcrmzXkJnKmiBrvn3bMPs5mtODWUO/+p4e27dqgu0kwY7ukXTU9SI/sv4wZD26tpmFWNQbjXVcOCwWTw3H3Lw8sRAx/Y+PdyQ906WpnH/Fg8U4K1VGJicsky6DnU=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 00:38:08 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:38:07 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 4/7] usb: dwc3: gadget: Issue no-op Start Transfer only for
 stream endpoints
Thread-Topic: [PATCH 4/7] usb: dwc3: gadget: Issue no-op Start Transfer only
 for stream endpoints
Thread-Index: AQHdYPRxYuSiuH218Eqg59T4Qrp9tA==
Date: Wed, 21 Oct 2026 00:38:07 +0000
Message-ID:
 <227e97e30d26a017c92d7008a8633c01f955d088.1792542945.git.Thinh.Nguyen@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 47573475-9a1e-4669-c752-08df2f0b93b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|5023799004|11063799006|261009223027099003|10067099003|22082099003|56012099006|18002099003|6133799003;
x-microsoft-antispam-message-info:
 vE/q1axjYhKqNTVZgiQ/WNJ0IKh862VKjrEl8jCOy7J1TE+pasXgHGjlDvETJN36uIRy3q+PzQMjLIU832VJP34iQ8pFyIC3ErNk8pN04Q+CQDlKv+pggjRfBEPR9JlGrx8EUnhucRx3MWx0Te/vHoHElCeqttaVnI4J24bHBjAuALj9GJpI6qPB76jxgcL/CFxF56uWAAoOcErgKkgW1awoAe6FLhMrC6W3EyAAgsZvogoIcAKr8Jta7gzvRx5o0n5h0wCbchSw1IWcwumfwgtwWzjLK1xPha0/PslOaLUBYUnhocwF2TUCsP3vhACg1nHSiKump3TbLLgsIXd34lvNyd/QQ0O/DJZZaG9zfgYp+oXrZVBhhJZmYrGalyEEtFa2nP6OcZC60kjN+mrbHMH2HBfWpenDyLRuMrcpO8JFTp8/VUO+eJut6MxYpd/bLX0oEkwVXNTqD/7E/LQwqypoo7lzW7Ng2/mCQ3XGT1q8tnhyD/rQpEKB+VCGknivhi0v4+N6EWPHOaOZQBGO2OgXrITIIC2IaljNScIOr+f6odgX71HGxeLSGiRX52TI3k7Gf5i+qxxBbRpaIQZ6zp68FxEt9WSIKXMNWj/m42oOTDdcgep2a5Ql+lk8S5K0FWpIHBKPGGnY8mwIdLcKn4MkTBh9r1H8mAyixfWBGY0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?C0tSUjfGvpVPoMx3KSmHbg4tI3L/CmEe/CUaVfiP++jgm2jNGBB/GZZNNS?=
 =?iso-8859-1?Q?gjGXZvxfqpNXxV/8E8VB1HMAp+glGrN/JSypX85VftRfaM0plj4hEFTalG?=
 =?iso-8859-1?Q?dsbQyL+uyt7/oqTrVBwvRC/AiTX6jFFWIqlJklnfc6mVNwTnzPAbUGuFvd?=
 =?iso-8859-1?Q?ChosEj1KwEc5mVbJtIoR42988LrcrxhwlkJIMy569j3hC51e1tNoC0dw0R?=
 =?iso-8859-1?Q?fbowq3y0OSD+6BVieHZXl12IZjI3827PdrrhgEewvpJnWGw+okdDrPaKCA?=
 =?iso-8859-1?Q?un2E6pHTpQnm35anQyP9eglprOwpRUI5eQitv+dbE0tTVUW0rupzvfBmXl?=
 =?iso-8859-1?Q?FKk2BUKIyDWN/OcLeFwbeeBMoe/cxlN6ZxhI5heEOasUw/IZdvFy8qNHnk?=
 =?iso-8859-1?Q?5TCSuQ2QifIMM6+k4voRS724ImOPAoNq1wGuRid+A9i78SZjS3l5CQImRd?=
 =?iso-8859-1?Q?nhvDo0WfjgvtIL6TFG9Z1F0W7otWxOAYKDGVqk9azNPlbjQag8p/qwqMxA?=
 =?iso-8859-1?Q?Qx26rdEuw9pT8Lic1bWOxJw/qNyKqoWt8+j5DURMCK5PpAjjgQxXz+nbLr?=
 =?iso-8859-1?Q?uGuUA5FqoQjLqtEQ9u0n9hIncncZASARWl3qIYmRBABhp6CYzDTKM7hVvA?=
 =?iso-8859-1?Q?T0vBWWCx+Icg0gp8tWw1W53Zt/ucuCgoEjh3lIcFP+kSYsf4Ry8deWRVQp?=
 =?iso-8859-1?Q?fFpl33wzF0TTaT7zmFfMPOkaqgZ6NCWAujCIYlsj5P81NU1Y7Jq39gxC2o?=
 =?iso-8859-1?Q?9O7p9JqBlVntiEE0qYHcOyckQNRS9NGEycTlUFKtb5c7BpVv3XzFqbpss9?=
 =?iso-8859-1?Q?DvPfNsFveraW32DTr458JSChCiVIar6+C63QgXHRY554l+m1Jl18dGijB5?=
 =?iso-8859-1?Q?IUWGqSw8eNhyBZjDJy1hyKeckDH34wj5NiAcyAq/Tffl50+/miH7+wHP2b?=
 =?iso-8859-1?Q?JfEeIoTJzvrIKGv/pb9kOUGoMQwMf1wfFC3UBwbiLAK92GOvJfnGn9p+Bp?=
 =?iso-8859-1?Q?35Beef2ipBe4NDmSVifbEDXhzkXBf87LXSirVqz1MWjmqqhjxb8HnbWqei?=
 =?iso-8859-1?Q?jAPLde2sKj8u3EBkgRvbO0q2dhvm7Fr/XjIu1SfEs0f3BNW8ASmXW9GFkH?=
 =?iso-8859-1?Q?RSEP0FBqrdZv/y5CbY4RyytnFtOYzkG7VvnctjUnNApsJpOMsdboaqzC6n?=
 =?iso-8859-1?Q?ccMf8tMJl/FswcXO9UpNR/FuZ3x1pZTCxqWZy3a/rammylLnyW7PvtvVk+?=
 =?iso-8859-1?Q?E0wMpxe4grd/+Hf/TCxd6UK0EzoAGgI/JpXF8Uis2iDeNwH3nBknLmCbqh?=
 =?iso-8859-1?Q?BRBhfJq8mdfWUxLTkrDfkraYet1xwyz/GMMe1SufZumHynTPi4TRd9PNRo?=
 =?iso-8859-1?Q?g3JIqMdXm2Xq2kDscUhZJ28RGVHjSDAqa9IVfqGZGsS91JMPTXmrfJk+Az?=
 =?iso-8859-1?Q?DyeBYNYmdwRyQBLj9XHMtmViA+FNLWE2S0B7L3cf1eEKZW3CyGAvr5wSBW?=
 =?iso-8859-1?Q?l70uliSpQjzqQshzEnFDfOqs52+d/WsC9rRa/vufEoTqrAhxYj+NyLIEZA?=
 =?iso-8859-1?Q?GstdKvzXcOE3l/xJHVXeD0redVLmfan9qF509eojU75PFRv5zBqo1M99pO?=
 =?iso-8859-1?Q?jyC0ukd8c64oCQdZUILMFCQ7/1+ngZKfLRSR0u5r9jVo/lHKBX2X1yUxxa?=
 =?iso-8859-1?Q?6uboN1SFm9NhRmutPZJTea7cRG0se/Sc1hUuO+JUkNH9tRkBIxzneC82Wf?=
 =?iso-8859-1?Q?yEnEXlCV00sMDEm6H2YIME+BQORpWZesbHXDlUlS7KiOI76XrtLdwdEpwt?=
 =?iso-8859-1?Q?6Ae3IwZHOg=3D=3D?=
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
	o3T1pmKET9WmP2wzHXiq0e8m0mDVPIfyQvmPmKIgPHKk0Qlx3ZEADTGzJoHgp6Sm2avmxd9GuHXeYOs7itJQJNwf/9RAe5wahJI6O1yjZnHgyz5ZAhS7roVFmYsC2LSdQds+HaCcW3XDzzOaVpprxUTkjQ/htQ69u/g7P1SO9F5fLjFlJHWBFpDHC4rZ/KTiH6jRg2SdziOXOnpRBdyF4Tj8DQX4R6gpZbMFjsyOLl/P6NRkyySD89pChTHOcPz2rCM4d9+e3b+3ZV7BA5hOs0Knh+0+S4bqu1oJV1IZvD0K/8+l73lbepeYobM6bHbes+/X2NRGi5vI2MmgJPApGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sNNf49p+tCthnIYmKwTzpvs/4jxJsjVi/PS1nllPxKjk5lVHWDxPMBSa0N7f10RZdnoTkCDV5lyyS88rKkWAyrmZpsqpWIy565MqmJXKYxYtgUsXenjVGNgC5wc5KU3N1A7eZlDTYJQg1plmQvjeqd+hUFzdmHSXHg6NuiWk9v2cEDnzZsqtx7njazzhCIbWGubwvTZht0tSsppiZkxzUxnRHRIjG2WzqnhtC/SjU6wGgOkuZ6UOYLCCyPIUhDcubLDhkdVNy2Bd5fGzdUbueyI3Xa4ffM+vmzT/1eoKfxQpv6eUo3Uw+DsqTBL7EJYmAIhIGaGIdlHK7ZSqM+AE3DLYJja16/zlQDtpDu2nu1TIeE0e2jJFjwC4J0JLS1AAU8vn195jJXnVNbqVZ42PXnJEZVTRx4oVKUxnFc1PqO8T7OpiYc+9xxUEi3yyTs4+4KR9+2NAw0uckk/1sJDRRHo+lXeSiemQ7/nKijCXRMhZyx9yDwW3/nB3MgMXYQVqCcPsQiALT5nOAI1Jra5KiO21an4b+E58IDnEh+MPbrPxt1JPENvGOBK79Df3MWlWc2iL8OYe2Y11yzm0FpgXPFQSRr6rWeQJXkA4FiLbOSDB8rEOhM4mDZWfEFXXExdmePnweD22D8vZvJXThmoAUA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47573475-9a1e-4669-c752-08df2f0b93b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:38:07.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfdoSEANo/VopgaRW/xvDcHyV8fkyjdk3as+A/cw7mfhSJPdigEzlbP771IAd3AkybsnnKVLmKJIjIJG7IjIpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX5b93j1qMrdNO
 qGibnnZmdz5gZSH+4558IOcxH/e+xhcnV3Q7jBhPpdZcEll9+x5gfEaAQo83c1ceOWqdNjt1XnN
 i6g37VkmaZ6KS5zSVQJYv8tK51H9KYQ=
X-Proofpoint-GUID: ci4RpjIHewWkLCUL_N7dQq4oAu3NtduQ
X-Proofpoint-ORIG-GUID: ci4RpjIHewWkLCUL_N7dQq4oAu3NtduQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX7i4k78s/nvsR
 hqG31X3koo4wRUiO5I9+OUG8juy6LfIi6ON8UQ9kZoDhBMyof1nARzniaaRXHJ5tjFFkGb8r6q5
 JwXXqiEZ7ZxDZa+FKECo7taL618ffajxmxnHaZH2vrjuoWH5TEFDEH0EAZc5zUbRCffgHFzAGU5
 5USO8RH67sCrl3UrAepeKCOHsdbKhph+UBVkdcfDXErq0K0Y5/sdan4IEdpkl156NEZZDBcAi9w
 DS/Clij//FW5qbiIAtTPuS212FdEz+z0a1v/7ac7xAJeApO1rqDprHU/WkajXiZ2jb0582vGm+/
 w+XW4WT6o9aMefXi0iAz/E0uZyn1BSPOgIJ4TmiEP53VaWGTAgOm9m/SaY9ZIWDi1i4HnDhoLyz
 MoRaLYrZxVihu/SmcVup7KKVzJ0Qx6wGx8G5qK6lXR0IlV/dmuJG8JW31J5RQwAlJCQr958gW1S
 jhT5Sepu74YvCtQTYCA==
X-Authority-Analysis: v=2.4 cv=LK3z05W9 c=1 sm=1 tr=0 ts=6ad80977 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=6h78iNf4uoTPcObiNlkA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610210001

The function driver may re-enable an endpoint before the End Transfer
command issued on ep disable completes. The no-op Start Transfer issued
on ep enable then fails with "No Resource".

Only stream endpoints need the no-op Start Transfer to initiate a
stream. Other bulk and interrupt endpoints start their transfer when a
request is queued. Skip it for those endpoints, and move it to a helper
to be reused.

Fixes: a97ea994605e ("usb: dwc3: gadget: offset Start Transfer latency for =
bulk EPs")
Cc: stable@vger.kernel.org
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@=
samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 97 ++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4de3b81cb678..e68584f20fbd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -906,6 +906,54 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep =
*dep)
 	return 0;
 }
=20
+static int dwc3_gadget_ep_start_noop_transfer(struct dwc3_ep *dep)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3		*dwc =3D dep->dwc;
+	struct dwc3_trb		*trb;
+	dma_addr_t		trb_dma;
+	u32			cmd;
+	int			ret;
+
+	memset(&params, 0, sizeof(params));
+	trb =3D &dep->trb_pool[0];
+	trb_dma =3D dwc3_trb_dma_offset(dep, trb);
+
+	params.param0 =3D upper_32_bits(trb_dma);
+	params.param1 =3D lower_32_bits(trb_dma);
+
+	cmd =3D DWC3_DEPCMD_STARTTRANSFER;
+
+	ret =3D dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * For streams, at start, there maybe a race where the host primes the
+	 * endpoint before the function driver queues a request to initiate a
+	 * stream. In that case, the controller will not see the prime to
+	 * generate the ERDY and start stream. To workaround this, issue a
+	 * no-op TRB as normal, but end it immediately. As a result, when the
+	 * function driver queues the request, the next START_TRANSFER command
+	 * will cause the controller to generate an ERDY to initiate the
+	 * stream.
+	 */
+	dwc3_stop_active_transfer(dep, false, true);
+
+	/*
+	 * All stream eps will reinitiate stream on NoStream rejection.
+	 *
+	 * However, if the controller is capable of TXF_FLUSH_BYPASS, then IN
+	 * direction endpoints will automatically restart the stream without
+	 * the driver initiation.
+	 */
+	if (!dep->direction ||
+	    !(dwc->hwparams.hwparams9 & DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
+		dep->flags |=3D DWC3_EP_FORCE_RESTART_STREAM;
+
+	return 0;
+}
+
 /**
  * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
@@ -971,55 +1019,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *d=
ep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
-			usb_endpoint_xfer_int(desc)) {
-		struct dwc3_gadget_ep_cmd_params params;
-		struct dwc3_trb	*trb;
-		dma_addr_t trb_dma;
-		u32 cmd;
-
-		memset(&params, 0, sizeof(params));
-		trb =3D &dep->trb_pool[0];
-		trb_dma =3D dwc3_trb_dma_offset(dep, trb);
-
-		params.param0 =3D upper_32_bits(trb_dma);
-		params.param1 =3D lower_32_bits(trb_dma);
-
-		cmd =3D DWC3_DEPCMD_STARTTRANSFER;
-
-		ret =3D dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	if (dep->stream_capable) {
+		ret =3D dwc3_gadget_ep_start_noop_transfer(dep);
 		if (ret < 0)
 			return ret;
-
-		if (dep->stream_capable) {
-			/*
-			 * For streams, at start, there maybe a race where the
-			 * host primes the endpoint before the function driver
-			 * queues a request to initiate a stream. In that case,
-			 * the controller will not see the prime to generate the
-			 * ERDY and start stream. To workaround this, issue a
-			 * no-op TRB as normal, but end it immediately. As a
-			 * result, when the function driver queues the request,
-			 * the next START_TRANSFER command will cause the
-			 * controller to generate an ERDY to initiate the
-			 * stream.
-			 */
-			dwc3_stop_active_transfer(dep, false, true);
-
-			/*
-			 * All stream eps will reinitiate stream on NoStream
-			 * rejection.
-			 *
-			 * However, if the controller is capable of
-			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
-			 * automatically restart the stream without the driver
-			 * initiation.
-			 */
-			if (!dep->direction ||
-			    !(dwc->hwparams.hwparams9 &
-			      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
-				dep->flags |=3D DWC3_EP_FORCE_RESTART_STREAM;
-		}
 	}
=20
 out:
--=20
2.53.0
