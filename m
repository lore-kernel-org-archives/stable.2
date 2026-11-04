Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793754469;
	b=hCloSEODFXnhiPPQZ7R9feo+gJu7OBGJHyxADpKtnikDYGXBQTP9ZfdCjSwJeApcjDpJ
	 OD48ldjZQZi5ldzg99zRWEVWTvr90suJDr+UXJtsiz5zWd7XO3VLYyq81k6Xv07kanrOK
	 g+CytaRFGWAXxs8ixzaswodsheGnNKZEAEAMshmqFEUlk1NRJwo5tXuHtDYUTN/ZrWx9T
	 OZAcjKnIcmNgn/ja+NpKiRUzDDL59FoP6pzm7KwSZtIIsMiRXKl86V1lW0X+9ZGV/mYgR
	 mIcUFONIrUpiZjRHi49v9BINREXsZZneTLIpMUlOTePRem2vj6kNUZVvXvDbVck2EEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754469;
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
	bh=K6D2clxJ8lULLuJt9suhce0U8ICWtHZILLkC8tJ1+tw=;
	b=lIeqs+Z4opVbSj7V69lOJwR9C30U90vwOImERbKjdnDVUW6IKFZbfCtUQ1T0ySCiC4pY
	 kaDA4mNiCrUjCcFdJqDBBZf9LmtReT0Mqdj4hPwK357GS0VZQlrxFFR8rqpAGu8NRiuwY
	 0dM0CoIwqU+Sf2g3H+BEPGTrPksIU3k9v5x8hJ/2mTzfujbGjtDjgWtVe5AsiTgRLVYr/
	 0IIMOFE0VzQZ+Z32YMfUHJFfwgRvun4dLgvhgNLlAUaF+Rekwejss5AxVSn9p6NTQFq1D
	 fpwCtDgq+/3o3vNipCgxxaQM2jaRgy67ABmlt5ubcFSINRNnImTyt3oN+WxFtY66FRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=vGMn+RtT;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=U57nCBjg;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PN8S1fmB;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3E606A329;
	Wed,  4 Nov 2026 01:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA3E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=vGMn+RtT;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=U57nCBjg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PN8S1fmB
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40SMCn1377134;
	Tue, 3 Nov 2026 17:07:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=K6D2clxJ8lULLuJt9suhce0U8ICWtHZILLkC8tJ1+tw=; b=
	vGMn+RtTYKNhD7CV4+pjWJHBCvwVpixk7TcWw98zq1gMp/vCOuuAeYAMY+k8UJgW
	0IEV/pDFBm4trz4tjeTAsDp/tHg1nFntXGlPFdjX5bS+Pq+23BxonNfASylQxfL5
	ORoToOwRYnJLOdlzNGTkoZv6XydaeAM3Q2ENKr61bL74w2jve1dY8+4xThYBK9Qn
	Zqzkpli1pbbZn78v5M+Wb/g7fakKT8sobjRChXMAj04+Q92rEjlZ6NjOK39hfkOM
	OYYAtBtSyvf6Dq+1SnnzOc4ajnHtBTESa4aISXcrO9jOPVjuFbC8gqaVSElPa0qG
	2E/AEkLNHiaT8UgL6wSZFA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4hqctvyqn9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1793754451; bh=K6D2clxJ8lULLuJt9suhce0U8ICWtHZILLkC8tJ1+tw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=U57nCBjgKuX5SPoQxVOzPS4ga7w5Au2G+all+ecJJ8DRkyNbMmr8xlZMw68CCnVYx
	 hPvJQ1+nKR6Kvj4J/nbg2HWLaJWoY9Mf1tBOpPKycmSTvf+tZCvTljs+Hy04ftCNNV
	 mgw4eH4Sgq04C5XqV+vNzb4f87Md+BLq1UocyuMWRtwZJ9c4dDtx4u0Z4K8rryULxa
	 ItDBmEnax9absxqCiYXfAU+4qXxkfskJjRJ6h5tkpUhxpYpSOM7nAEwVR7Ds1p54s9
	 N0LxhnwGu5Wc+Pd8srdrGvQCnMn9PqZ2NXkr/80PLMfhaGR5X5N+CKUF1oem+p38F0
	 Rf7/ZilVbzxuw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C5824401C1;
	Wed,  4 Nov 2026 01:07:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E3B0DA00F0;
	Wed,  4 Nov 2026 01:07:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PN8S1fmB;
	dkim-atps=neutral
Received: from CY3PR08CU001.outbound.protection.outlook.com (mail-cy3pr08cu00105.outbound.protection.outlook.com [40.93.6.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3B4B94041B;
	Wed,  4 Nov 2026 01:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUXSb2F65AEdwR1vsQlty86B9Te9IdMQ/7ukTgI3hhUapcyhrUm9xYucLYXzTlvcQidILuqLMq7dd9econFqmFZzQOQCVuywl0bj9FaEq21HBBNWYK7F5suRGENT1QHWD20XWsbaOqUna1wi8TVTkgMWZ+jfOUCmvobT85fapm3eRMQMtk0JRd68ODcMv67p+1ZUFFq9Jved4VdsP2wlN8f4clv2iHymAUb2mpp9nrAgYT9knEVgrQ3vKi7HJ5/wK4a6enLx6Qc6VzTev0VcmCAcpKibYkLBRrhkMrBF5dvmjTPAEDoAbsNpffNBedJRrSKVcauga4u01KefWejYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6D2clxJ8lULLuJt9suhce0U8ICWtHZILLkC8tJ1+tw=;
 b=VkXROd+SDz+xiBYAmnGkxjioxMusFROGMT8q5Krniu80ZjlhlI5YM9ajC3cCsxyQH+lYYtjyfbRcdD3EOvi8K4WWXEwlFqzgQC/ML07J7Pu2E5q3IQvrIiydwbmuMbBbtZqdihJ6OGANf/qy64Frk6HT8NFedr997dfIr+fZH6VX+SRQHdpRd7UwYTu1XpS4a+MI+SFCYBl/RxJqe18eOnTG4bqL8q2JkQv3gD/A01vIeP4uj+pM8zO6y01HPLjRSkKQXxnhNYioGVG4jvecg/AjI0zAtoJyRziHtYwiY/YYGCSz1PqltDbOiEnDab4hWs/Xa3TY2sTPd3J3nOAcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6D2clxJ8lULLuJt9suhce0U8ICWtHZILLkC8tJ1+tw=;
 b=PN8S1fmBi5wJwgRvw7C22BHs/22MDhrcnslc9udf3fjAANOHLrH4S3VqmB6pnOkYkCkMduvDB9dbGh2y/6H4vcUAHfKzrPkzsfbWoYEuWKEAit1Ap9yJhBMOwVanU7OtGCtw+rTO3TPPRh5QfHiby9rh0Ii1hy0AAY5sYkWXTRQ=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by FT1PR12MB100801.namprd12.prod.outlook.com (2603:10b6:170:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 01:07:25 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 01:07:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Dooks <ben@simtec.co.uk>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: fix fifo reinit in
 dwc2_hsotg_core_init_disconnected
Thread-Topic: [PATCH] usb: dwc2: fix fifo reinit in
 dwc2_hsotg_core_init_disconnected
Thread-Index: AQHdW7ol2ImyAWoCnUOs+38vOSkkircdOiQA
Date: Wed, 4 Nov 2026 01:07:25 +0000
Message-ID: <auqBLaXcwNDor_xK@vbox>
References: <20261014-dwc2-fix-fifo-reinit-v1-1-d918de90ee3a@foss.st.com>
In-Reply-To: <20261014-dwc2-fix-fifo-reinit-v1-1-d918de90ee3a@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|FT1PR12MB100801:EE_
x-ms-office365-filtering-correlation-id: c9820a00-3e72-4bc4-d7e3-08df3a0ffcde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|261022105027099003|11063799006|56012099006|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 3Odn4XssqRPZNbKM9DkJeCbvXwSXDAQRnd29W9x+LfMCGF7uKzS6jxaPGHvYuVKfzklfQH1VTQ7dFDg9O9XnrufuS08itmUOVmeYr8yX47YFX5/rlrPwGcm1KZobv958RPk30LuV8iMC17dg5GWGr0PEj9a85hukd4cV2sGAtpEPy0HZ2M8czhOXE4lI4hppXHmwpK9C7+s05aApKsJoy1dXOBfCigNCRR7JAzU7KzSxt/MNOmkDyALNWFujoinBAEYijZ4sG3TDbCsk/zponoieZqs8ovZPQIKOBXUORiOjiGvv2jDBzsJRjY6bcbL45K5HAMR1WBkXNfrWAOsfoCGNU/t+j30RqvWAHztrLmPI5ujlDIlaSR+pNDnYyWaI7fSm0alYfN7e87pwMu0eZbQFOXuLFEqtfOFm5cohMMRhvno66wsmCipZeM5+jhy/CYURzYW6z07bcsP+rXzoczIMzjDmNIVnyOWETJgJBpMd3qXfxGFht3BPnMWi3m3mPsT6/yv50zKNbYvA65+ILgqiVQ75O4FHnf6XcxDrb+5g5h5W/lvDsw504nKUjOox9mJbd+IZBaFJHh24IFxiKu84QMa1yhikrg2L4NFQz+oGPQyJi23YdR4l8ggJv/FzqLqHXChgGly23RJM5wNB41M8gEN886Moi+C2+bdkPSmeSqWPeti5KUJC4w2f16XdP41EvOE1J2CeDm12u6jx2+s68cA/Dm+QSodXyCF3GHA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(261022105027099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alBZNDhTQklyOUhmWXlMRE1sT3pscS9DMUR0OGVHOGtVakdhdVpyMW42Q0No?=
 =?utf-8?B?TlZTclZENXFGOXVRNXVpWmd4azlNb0lKLzB5VFFUcllHYU0vUE5rUXgwMmZY?=
 =?utf-8?B?TURNUENib0VtZmVOWUs3QUdjRHBidndYRlN3V3V3TXY3akE5N3kyOTR3Z3Bv?=
 =?utf-8?B?MWczRzVmNFFyZTdkY1VKSGVpSmE4Q1VrLzY0SUJYbGFZY3hZZVdnbEt2VnFX?=
 =?utf-8?B?anJCeEFQc0hUbXlEZVM0cnNOY2VoZmIzMTJrMVNBVEM5bWs1MCtma0dzMFc1?=
 =?utf-8?B?YVpZSHNkeHdHakljRG9telo3eFM0Yk1IaU0ycTRtZU14Mi9qZC9WZlY2dkhV?=
 =?utf-8?B?MWR5UzRVSnBOZVp1djFhbnhkSnVmbU5LbllQMjNybFI0V1hGOUNuR1lnUzFq?=
 =?utf-8?B?WC9abklEMWw0WWVvSkpHYms1bUlPWjMvTURVZXJ1aUw5Skd3ZFJXcGhnbVNS?=
 =?utf-8?B?RlptWWhIK0xIeUxBUkhpNVF4WTQ2UnNXWnhFbEZsdFlrbUdwTmxiR1R5WEhw?=
 =?utf-8?B?NGFkemViSWZhMFFqVHVuVkF4M202cjZKYlN1WVhsL1dkNUxqWkl1cFd6dE9Z?=
 =?utf-8?B?QWNWM2xyeEUxTjZPWTdQZTF6eTJ4NE8yS1FvMlM3VFZRM3gzMFVWWFZ2bTBz?=
 =?utf-8?B?elZFM0lvYi8wdytnSUhYTitpUS92TUFLK3paaXdMUXBKNXBxNnNBZjZMY2ZO?=
 =?utf-8?B?cFNUK0grdHhxLzRpc1NpdjdxcWIzdVVwWGVSaDBsK05CRVVlcFN5Q3ZxakF5?=
 =?utf-8?B?WHVCSlV3eW1SaTBwaVJCeXZWSDhaRDBxckJBaXJTeUZFT0ZmTjdKUTlUR0t2?=
 =?utf-8?B?cXc5ekh4Q1VVVjdoUlFJcndOZmZiRkwvc1M1L3FXTHpMSG43dUhOMUpSTnFO?=
 =?utf-8?B?YncvdmNydThWdTR1RFQ2djA3NmFFU1ZjSkVCcEYxR3dwVW5TMFNVOGJBUERz?=
 =?utf-8?B?QkVNOVcxRUI4YTdOSm1NdTQ5akVJT0J1MlVyc0VYay8yRDk2c0M1Sk9jTDJ6?=
 =?utf-8?B?dVZvV2lKaU9CZ2c1c0NMYmxzSmF4OUhDK2VpRlJHeExtVCtFemhDLzk3aStp?=
 =?utf-8?B?U1BmbWIxa3VYUHA3VFNiWlNQN1JIQVM5eUdjc21yVlJ6SUhqeU51TXNEMVYz?=
 =?utf-8?B?S0J1aFp5eElpczVtVWxJQVNyZDV1ZUN6OStHcHBkNTlhZDY4aWNQL0pZRzNL?=
 =?utf-8?B?a05xL3lmbFVGaVd4cUZBMzY3a2JzR2pjZXNNQUgrNkNISjRibDJiQVBFQ25q?=
 =?utf-8?B?cGlZa2hQUnBaRDNJRVFvNXdvYk5SYUk2a3g4WXVnYWhQSTI2bHBRSlMrVllI?=
 =?utf-8?B?OHdwbTIzRUNxbUN6b1FqTlJpR0Uwd2dzY3RGditHbjlob3liWDNlZXBaNyti?=
 =?utf-8?B?UXZTMUNzamJkbzNyREwzc0hxRkR3bmNYZU1qM005aEQxQ3NoK3o4WEFHNlV5?=
 =?utf-8?B?K3F6RXkzS0R0cWh6alRDSnUzWEloVzdjL0gxOTR2MFRDV3dTWWdRdWRFODNu?=
 =?utf-8?B?V3JKUmtldWhnZXRKUmtLSUZtZUNsdmdUd1RRTWNSL0hySGR0aElia1VRTU5q?=
 =?utf-8?B?MHFuWXFaYmJTQXpuQ21zOEhodGptdEtxOTZOVlpDQjZCenRWSXhySlM4TVZs?=
 =?utf-8?B?bTV6blJuNFd2cDlDcGI1N1l0ZEVhM1hpOUcvUm5PL1BWbENsZnN2Z0l1eFRj?=
 =?utf-8?B?OVY3U1RnaTBXU29IaTg4bUQwU1hWejhjSm52UVdKeUVrN3d1b0l3bU9vUUQ5?=
 =?utf-8?B?UE9FdFVBY0hWSlh2N1V0Rkp0NmQwMjZpMnBLTmlOdVl4L2xpb0xYZmp6OUNN?=
 =?utf-8?B?MTNDU1MySmpnbEU0Y2htN0drR2pQSnBpUzJBKzhMSFJmcTcxN3MxaFphQjFT?=
 =?utf-8?B?VTMzdHpqWVU4RWlTSEdCczVVUWJKTHgyR1FXbkc3ZmYya1FUV2Z5dmZKbmdN?=
 =?utf-8?B?NVVsT3lWMENXTzhTMW5OVzh4anlpNHVmRHA4cDVZUkoxV3B0c2VJNTZWdERi?=
 =?utf-8?B?VkFaSU1jSzhPRi9FcjlkUmlpRUw2WWIrenE2bkh3bHdrenFrWkczYlhaZ09Z?=
 =?utf-8?B?TnZPeFA2b2Q3THNCSWJuQWdMZTA1djhDSG9acDRHamRIanYwRno4enZQclQw?=
 =?utf-8?B?Umt1dVhHVExJek1MUkVDTXUvWmtpVTJ3dWJHQkRHTDIwanBwS2h4VFQzRVBi?=
 =?utf-8?B?Wm54SGRJaVJuYjF6WmFnVkVMSVJIUkxGa3dzSTQvMmdTWWcvQXo5QmY0Q3FR?=
 =?utf-8?B?OERVRmo3Tml6VFJObDJuQk9zc2RUbG5CY1VVN3dpOWZZSDUwU1RBSEFTUFhh?=
 =?utf-8?B?SEhkVHRQU3lxSVdFUDdNNkI5c0tBUnFyUDRISkRqZnFCRVk5eURKQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E144B226BE27D143A0520B33B1A4EA27@namprd12.prod.outlook.com>
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
	NITHLR+cAYkaYock2+0hTWKHCIETBieQOwbAGfyFE1RDl9AatzVZ+UvK4f9h4cAxWYIyUccbUl3GHtXKsxf2cAAg8S/YumaVOXKC0pbRBAks6cXJlF3BPR6vL07yhqRDsahbLs84KEsVvZunR1aWwgB3/1drZbkQB4ZLZHO9NryTz7oZB8e2SnUqsbm/U1jECz6RZaVgRaJxvDppnjIMPRuhbQ1/lvF8RTZlDfKC9o4x5d7Vo1HI4gW1atJIQwjlrGVso8G7NIO4wLWXUoW5jeFJfq57gwUM5yQXBUwyDAd+6OI9Ajnj46aukRIu5zf4oQaX3EmZ673FHHxvVjCGPA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HAyLY41qjfGNol7772C/aFdq8am1l2tH3z+8SYxaH6ALx8eiI0bvw+rzFV2MPnoy6ASdLn9fzlyQMHlg27h8qDdpCl6FaitCUCzI4YZw/JTFr6U8XyK6GJTbW5V01sU8JqEfeHdf3AZ8C2uasQIqmlh7TIk2zZFcCCStCoqUJi+/9awFW0ZVl8pK8OfPoQUxgg7bzxOFAhD3W4/bQD8aQ+Pl/ANwtjyHNvS1bHMVbOQx38HL0tTHZG/snF5Daux3ReCBP+Axb7X0ahogdBgEsVZvvqcQCy3mhWq2qfWfY7110G50/T1GZO6wvxdsIZ3KLI+osuTIlZDPGh9y2uzwtt0/FMMrQaZaRC/a9Vt3lBwwKJyhszjYll6ZCBPPMy1ifmyB++zlABHqK8iLf3iiA+jhwDunKXrKK+JKtsldrfsuHeHwBTgaBFL40bQaeh909um0++F1bLNX3Q/kMTRzsAdGsoVTpTiutxcApSt2IVKx5kV5oy1zPzdvXyGYRvgumsagm1mvnTHJ42RJXyIfrpkKpslKU53aif4BfYAmkCmc7OgDSUImAyHls1rOo/jhxutnUATR7+p20mr+6cD2z5zcNjbaaawQhs7tAlvq5vZMu00uywqGcOrNQunCPLS4r7APmIESaQvXyjzaL1mEJQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9820a00-3e72-4bc4-d7e3-08df3a0ffcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 01:07:25.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOHLm1f5d2NoijV4f2kVWhVNR/mSwmgCLk19TdUzzuf+9q0ctYwe5nIRoUp8cES+nBhG4fstfhWy7mVnTy7CYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB100801
X-Proofpoint-GUID: T7RYNN8LR2rwvtgILos9zgZhIkp6rFVW
X-Proofpoint-ORIG-GUID: T7RYNN8LR2rwvtgILos9zgZhIkp6rFVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNCBTYWx0ZWRfX01ACLxirBvZG
 tuenGFjzMNCoQHa1J9Jpk6uKY+AfpACBZQeoUYCQYNna56IKpbuG0jX2nWwJpG2GwO6Oi4/aXTQ
 jS1gM0dnQGHxUp/2Iqw3nj33uTcgYtYj3ao4/6oqyEApnRG2eKiufbi2bSIyS5JdmUrxu6IGA0w
 cCMobj5uPAOnfIzZsLgwFQMpL3rsnWkXR06agLJf/M0sMgvzUMBVVpBYj5Yjx7X5tXEWY1TfAHi
 CzX34FYtOVY+yp6UQ0uBuJ4VCSUupd7jB1CweJ3tyeTFHnchnWW9tkahAlyLv5qriAlj6tWKWMI
 jQ2Dx9pGyIex5AnfXXPtFR+OeC3at8NI04iAXsi/csFv9nAp/iHz98W/YV2diJvXQSn9JYfQADR
 6PtJQm7f1GUJ/LEnaV9SdYCUV48QWBxhbFNknU0l35PdolK0RDW9e9uo/sq8GmAr5bUj0Z4iMCX
 O/M6HQWnHFAd6CzUxpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNCBTYWx0ZWRfX+dVp6jQ0qoql
 gjDb5V5kjWq7yvy0MmrTtFvT5I5RLhIhjdVtecGnJWOiTQwwoPpPqb6Asj601xAwOvoFTl+6TdU
 njYIL0wDOK5ANxk0g3OzEYmyYWHaPsQ=
X-Authority-Analysis: v=2.4 cv=ce5HPXDM c=1 sm=1 tr=0 ts=6aea8553 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=jIQo8A4GAAAA:8 a=gFuuFCyObDAw_DxQ1CQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611040004

T24gV2VkLCBPY3QgMTQsIDIwMjYsIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gQ3VycmVudGx5
LCB0aGUgZmlmbyBnZXRzIHJlLWluaXQsIHdpdGggYSBydW5uaW5nIERNQSwgZS5nLiB3aGVuDQoN
ClRoaXMgY2FuIG9ubHkgaGFwcGVuIG9uIHRoZSBpc191c2JfcmVzZXQgcGF0aCByaWdodD8NCg0K
PiB1c2luZ19kZXNjX2RtYSgpOg0KPiAtIGR3YzJfaHNvdGdfaW5pdF9maWZvIC0+IEZsdXNoZXMg
dGhlIEZJRk8sIERNQSBtYXkgcnVuIGluIHBhcmFsbGVsDQo+IC0gRENGR19ERVNDRE1BX0VOIGdl
dHMgY2xlYXJlZCAoZS5nLiBkaXNhYmxlcyBkbWEgZGVzYykNCj4gLSB0aGVuIERDRkdfREVTQ0RN
QV9FTiBnZXRzIHNldCBiYWNrIGFnYWluLg0KPiANCj4gU28gbW92ZSB0aGUgZHdjMl9oc290Z19p
bml0X2ZpZm8oKSBjYWxsIGFmdGVyIERDRkdfREVTQ0RNQV9FTiBnZXRzDQo+IGNsZWFyZWQgZS5n
LiBEQ0ZHIHdyaXRlLiBUaGVuIHRoZSBGSUZPIGNhbiBiZSBmbHVzaGVkIHNhZmVseSwgYmVmb3Jl
DQo+IERDRkdfREVTQ0RNQV9FTiBpcyBzZXQgYmFjayBvbi4NCj4gDQo+IEEgQk5BIGludGVycnVw
dCBtYXkgaGFwcGVuIG9uIEVQMCwgYmVmb3JlIHRoaXMgY2hhbmdlLiBXaGVuIGl0IGhhcHBlbnMN
Cj4gd2UgY2FuJ3QgcmVjb3ZlciB0byBhIHdvcmtpbmcgZGV2aWNlLg0KPiANCj4gRml4ZXM6IDVi
N2Q3MGM2ZGJmMiAoIlVTQjogR2FkZ2V0IGRyaXZlciBmb3IgU2Ftc3VuZyBIUy9PdEcgYmxvY2si
KQ0KDQpUaGUgc2hvdWxkIGJlOg0KDQpGaXhlczogYTVjMThmMTEzMTUwICgidXNiOiBkd2MyOiBn
YWRnZXQ6IEVuYWJsZSBkZXNjcmlwdG9yIERNQSBtb2RlIikNCg0KT3RoZXJ3aXNlLCB0aGlzIGxv
b2tzIGdvb2QgdG8gbWUuIFBsZWFzZSBzZW5kIGEgdjIgd2l0aCB0aGUgYWJvdmUgRml4ZXMNCnRh
ZyBhbmQgeW91IGNhbiBhZGQgdGhpczoNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmgu
Tmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
