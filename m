Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543115;
	b=gV/AaUVRItX7rcyFezVfex11DeaeyytLoYtKWnFEX2AaduXz5zde90XrgE7BgWLS/JpO
	 JjDGsNkI5aqFOTo+N5Gif/jdAbifTgZF62L+XfJAKWesV1W0ADISfT1Ng1OSCBBCaWnd6
	 eWCfjQ8JZXIc/4IM5jGrne7/3YSEGhoaS/S36JFWCWQKLzxEMw83HCmys1D5qUIJtdn/1
	 1nd2WHbX+SAzEmyDc7c8ec+LlCl7wpiRzZNUhsiLBuWNnqamoPP7pyN7kT/ModA4vsTN7
	 Njj8z8WgekK7efdnTdanJ0JaSKbesQjBScWIFoQpQWtWAe0A+uYmzvrOkPuHST4KABg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543115;
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
	bh=7dWKpLxYctXcRBWg+olYCVG6g75CcnObgwFUJjkYEOg=;
	b=KK0myFDKmqzmxK9aB9R0wUpHVm0zV5TR3/Mb18r9BQCA4wX+tbH8ghPGOwNvS1tdGDFd
	 cVcFz0yQUe3DAeHvh43OgEU3qFl2pPY5FKwGkHjTkx6tMn2nkm+4dXdpMXHizssCeZD8W
	 rnS5p25CIx3n4QUXk9RkR7WK8Vc3Q7sHqxw4/r4Z48roNnTQegbzfYUwxoEFgr1uhAy4b
	 iOnsSH2CN4DjKGQRdyFpwXzARBRYBRFgqCg+Aau0zv3ESFGeVpoRROX+HdfsJuTGq3H7n
	 McEmuBltheCpy76gsNDBJ8ufxrqMm/YYlNoeMtA0O9YAHQf4EEIjDryF9sJeMf0tYtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=pRmYUoiA;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=eokAXhZn;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cndcs0MZ;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5A606A31A;
	Wed, 21 Oct 2026 00:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFC5A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=pRmYUoiA;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=eokAXhZn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cndcs0MZ
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKwvlN3684545;
	Tue, 20 Oct 2026 17:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=7dWKpLxYctXcRBWg+olYCVG6g75CcnObgwFUJjkYEOg=; b=pRmYUoiAGTSt
	Lik7Li+xHjtNHYICEWpqjJ91jZFPqN2kA72H+K6ies72rxr9b+/yRtuGBCCAaaji
	So+2wdsQihmQZyLJCgGkw4e+WsARqRfXU0zTfDIaZB2nRTbaDqrelIZkDCx04YFX
	lwCEZbCxKx42G3XY9bodvGdOwHZVgbHWf8RC2yE9gienDx/k8y86zq0nHZYZnLSZ
	ZvjDvzwYSb+/SSqTA8SF8n2oEVbgeRkN65Ei9wR1DUjX8bbzuA+HG729IoKFxTAo
	H6tyhBozDppq4yqB9tpSr0qC+3QlFZ4s3ckBUAOZ8EtDfULh8nB6owvyaktlvxP0
	xqt/OZ67Qw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4hdw70g83a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543108; bh=P4UlwtkrnDgF3Zg7RwmkzRqESH8ssFeCIT8xZabaFp0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eokAXhZngUQAeXCHJMG7ZUWQz4jvCINmjeVAIxhRmcJVXjZjFO6EhvYt1HYXNJhiL
	 GdP9p1cOzpyC88W0Nw2/jgOcPW0N6973c85IO7715UliBCHyO/LK6929B94Zdo0XXM
	 JnaaW+ze/LMAR05qk2wcakDFBqjSu4YIbDAM7CBb3LAzkkmLsYeAjZCkIkHuPvyY6K
	 cofvYWtRrPBooFaakeoC8OmaJjWfhd49Ik7IITezJeZs9REZYpkRlmL+Z4U6RqzoLd
	 yKPyhBlppXjMKmxXxRZSBx6BUAdrCrQDKyHCvUk5yYRwYdipVJG+NKqc6mJtZFwx5I
	 Ap5Yg0ACfptzQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 43B2C405E3;
	Wed, 21 Oct 2026 00:38:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 24CE5A0070;
	Wed, 21 Oct 2026 00:38:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cndcs0MZ;
	dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com (mail-sj0pr08cu00103.outbound.protection.outlook.com [40.93.1.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A0FA9220382;
	Wed, 21 Oct 2026 00:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkuNNFQ5uFI5prgSDQrY198ikNj8R4ItfXQackBV7vz7/biROEdJHDI3dNJO+ykVG6bhPTpHMxAR/8joiq2TObt78RnqQhox1NwJ/DBO3vJtCgHGc3Pusm9Zro4YKao0EtNNh3rWzFgVv4xp0MKLVijA5LcqE/pqn2osCo9tHON2viQEUCbzZtwKooPuLfYuw5xo3NTXsP6E3GMwMWmG0XSows+v5C4xhHBI7/D9o91oI0k/XBdCyYA9ZE2buAr/3kk1Aou9eV6p8dUd5FmwcEMB3cW9pHM4zJJ0wLO9ramNXTYbtSwKSQAtwdUjouKE+zaeIFecusomTGBXnsmm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dWKpLxYctXcRBWg+olYCVG6g75CcnObgwFUJjkYEOg=;
 b=jIo2MLc0yZHkgTtq6CKB4C3I6VQUUavlZlS0bDb/FmfEHn2hEXnSjnCdD2URvHjJoQA+AmvkY0GDe6GDLPh7dSy1SyFNJwRtTQOFQjjo85/th66zgSWSnZ17CTKvA8mYHbSbICJla9JVU7E7fuSbLTpqaF7thn4uW8sIyvdHZy4/7jq/yRTaCv3Ur85/CkAKhOm/10ZOe4lsdrnZ/b7AlCeTyKdR1AplOX3PwHDuwF81jj1+Tq85fdDkZXCUt3ZWV0lqC/O3jFXVuPtsy7wTkulAlsiH8BAe7syN/umz/rYeXjjG6frFKpTL09jBgXxKnPyXnwisrq6FCwHu51vOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dWKpLxYctXcRBWg+olYCVG6g75CcnObgwFUJjkYEOg=;
 b=cndcs0MZPII65KNRxNqkp5j6tVoInB6n387cGJKUNQSrKGzR3i+NmdgXOqemZL56HSoY2eLILeHp67tZMa99YKo8/Zj60tL9T10DluclFLugKf3klRzZDwWhabkp4+Hpq49vXqgkF3E3RCCmlojsnUNhNsFK/+VWMHw4CgtU9Ao=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 00:38:19 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:38:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 6/7] usb: dwc3: gadget: Reset endpoint flags on controller
 start
Thread-Topic: [PATCH 6/7] usb: dwc3: gadget: Reset endpoint flags on
 controller start
Thread-Index: AQHdYPR3xWFfanrvuUGZHAwywiUGOw==
Date: Wed, 21 Oct 2026 00:38:19 +0000
Message-ID:
 <21cd189962b9d32a4f9df381df4947d35341d5a9.1792542945.git.Thinh.Nguyen@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 7b8f2110-6850-4c04-851a-08df2f0b9a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|11063799006|261009223027099003|10067099003|22082099003|56012099006|18002099003|6133799003;
x-microsoft-antispam-message-info:
 JgB3V0jE4aPmgJH6eNvHFRRLE1MBLEOEN/0c5Z1hep5aQLrUdZzChkwyvTGkrZwk4j3qGmYnPzwbbm+wg6jspELFKnzdSxCnLRxqO664K4LWIlArMvC+4m/t/OLPU5Eeqg9DcncyBYeRzCjt/pJdmTJkbrQ3+TdGbZ7s9gKKgY9PhBIfgOLoO6Cp43jlNb+xnqEdXxRNHpboHm+z97a5XNzqpXvS0VZAYoXu/QSY50a/OWU1KV+VTs9QfQ/cEuYxwpK3hVghCBaFLaZPylf/6LU3Gd4+BmLHM8oBb0OSBbHuQrZzmvMHXatbBC9OQbEuzGhQXsBhvplJpZQzcrwne/xGYPrUiBNhQWoR9AO5PSH5rxmE9gIoZpddIWe63OepiOvG8XgZ3Iy5jwk7WkBcPcIVqWp/N8bTSucSj6uW+HltPHr5s1HNvyCKtlWQqL9pDNN2GxAlgE4egxUILMCdG2341im4OMgsAoBJBaFkfN1OxMwmSLDU75rFqWwMrQYCPC6RPUMWRR7Dakn5rloH1t7xxfg/Lx8R28E0dc5su6fmUUkwRPxdji9gb1e5yTpWALSGkKF7d1iQIWuHnLixpSIIk1gmV6md3Sf2evf6jNd5MrBJqVlxPhdDA/wbDs+G/2iR6jdyLLRIsy1foA+vENzELokhNojKHYkyMBSRUHdxM3ayabX8WgOTB3SRg6w0Nod/MstZkqy9AuJ0Ec8NSKBIUQjgHkR6RoVjDlgBNBM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(11063799006)(261009223027099003)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CUf8eJxyEPGb/33sI0tR6w/xne2UrdcSmzEiUVRCXcTv2hEZyTqTPd/2rJ?=
 =?iso-8859-1?Q?qvJAljfmxLCOkYFWzxwWZ/3RhPxBkqr4/qj/FEbcJzhSwmhJOQ2+582DAl?=
 =?iso-8859-1?Q?OHEfx9oQNDqn37xoiWiI8UlWdkTXPald2JktB72l3qmKHxtEpV93pUmNMw?=
 =?iso-8859-1?Q?njx82Xs4zUS7lztrbDUb3RgeuOLfg2dULYN7wzUYqoEPgqz6u7jcoZerJW?=
 =?iso-8859-1?Q?iUMP+fCvg3mGGFWj8aSFILtjgE83KmQHjUtEKuCLpNG+UEOHgreXZiPahP?=
 =?iso-8859-1?Q?9ncQHuFBfj/ZM93ZIcS6foR7MT5+FVxlrI5VTWWkLtgD/G2A5+G/rarzzQ?=
 =?iso-8859-1?Q?vDYuo5uzfI6GXT5qkZkOpJ9x53WKK7xC7nH/YpirhRiFOXisl9xZh27Tnc?=
 =?iso-8859-1?Q?8pREcSArQkCFhhApQVMkq5wEO4WLsz0Dfs8keoGQ5LHedzQb1U2C3ipmAK?=
 =?iso-8859-1?Q?F2GEXnFCCybCXL5xRDJ2KcBvEvWd1pz3czz6M81gU+6IVBCBrX63l6aZfL?=
 =?iso-8859-1?Q?z3LuoZLB2v9aXVn9l4pABnyKyk3ONStMqkIyxBeJIsV3JYjVJR2k58vMbl?=
 =?iso-8859-1?Q?7lhPzUlMijm0HoqhKyjKFjEUaG+ywSE6q2QxB4DCf91Hn50VqS5JUyOh/x?=
 =?iso-8859-1?Q?hy3KDV21vmUAQKncM+jF6NOR0mWoHabIhraKG/dSXYdtjmx6HZUc8+ulFi?=
 =?iso-8859-1?Q?6MtVSp6LFbdbcwKlGU0q4RPWTBQKhNOsrCLOOCcxU+m7oQMbdKEm0y6+iy?=
 =?iso-8859-1?Q?fAtTsScPHGU7FUsplkURBa9L+oBjwKp6JM/cJ7TAt4JvGyvQY06BvbkR9R?=
 =?iso-8859-1?Q?orjBb2cMzsL34/mx86OGe2EZOWTuoa9Ksn8e5yIe1V7F64HlclrELOHjvQ?=
 =?iso-8859-1?Q?D1o2inf90ypNeYCM8vOmWzLBXQPoyNTRqL0Ao/uCTQvYgSKLqhGspMLD9A?=
 =?iso-8859-1?Q?H8i1HSvYtGwCSXeJTAdYtrEbf5WLgPwKoas5SSsioljzbrSIIFLlrIw9g4?=
 =?iso-8859-1?Q?qvE15dH+m1hAZrDjJHJQs7O0DhyOjW/38iU6if0S9EXo9IK8Ds/9jfO7lL?=
 =?iso-8859-1?Q?n+oafoKv9+naPWdWBI+pNxoXKauQfnyLjze6HtftZ9WBzk87FA1E5/6WKI?=
 =?iso-8859-1?Q?+qhQMltGN+i3vXg5CfbbbhIpe5GnoRoRLFLIhpPJANgaM+n1yJjnEBDzkI?=
 =?iso-8859-1?Q?BB9GVZOorBywgR8AinPrJYJ/TKyapeAxjL6gu8zTSxTdLFFbFuEsP08SAV?=
 =?iso-8859-1?Q?XD4vgJkxPCQtvH49G4sP4I3FlJ0vp1rkWNiedFZ1bL4lTbYNv1KKodCon3?=
 =?iso-8859-1?Q?nErQejHNmk2TvVOCHMox4pXzgPlAEkb9QIcQtIyyGpAfOY3iq2ZKm9QGXQ?=
 =?iso-8859-1?Q?fepeeqyjnPoDIRWTER3rDZo2ZEsuS1WeS4sN0dpJv+HTNGBx8THAAGftIk?=
 =?iso-8859-1?Q?5jpjuQmzjFaZdX2ncUDEzdEzXhCqlYDanD9KQoVyGJYSJQdBHy8Bz1WX7h?=
 =?iso-8859-1?Q?ByBFxpsDTj1pnIHMV9sn9dGUHACdiDGRGBj+NqghanwcZ+T5lkbXTrvNkI?=
 =?iso-8859-1?Q?00EB1jiNtuZXdEBJsMwgBm2be66uXH10eW+rzkZ9cnR7uxuDUQzcdW1H8T?=
 =?iso-8859-1?Q?HdwGit1nJ1aIkPbwIHMBOdkV6ZKFWptUAe2tk3H7DTx8c1qHBmH7SLNvcB?=
 =?iso-8859-1?Q?gSKo9AkDJtP2k/SqUR/PXgyUThXbnAmBAennptI8Qo3H36gXakQbzKpf/s?=
 =?iso-8859-1?Q?44XcFw19Z4Y5fin1vN0JrMN/oqxBuVLRthOugCwqAt/u9dVehThrWGZJd/?=
 =?iso-8859-1?Q?vPF/p/S2Gg=3D=3D?=
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
	bRAtzBHbBqfV3Q1cuUyRa6E/M5Pq7xjEZE8syM9lLZt802PNenPPac3ra+9pORWr8bTl4b+dFVJTZ7ydxC+zlYaGm9n2q9nsxApS4VXxwdgIcE2NW0jb2qhEe2ya6/hfuZ31PdtpvAsfZevW8FUg04u04dMuBzsssCgetC9oPqt/l7wh3Ihi08H3Jd0PiSUkCxEsuoi/BI4ZVA1gYc2au6Q1lHztUyHmFdVQRNrpBQ3+o2ltPP4Uo3jbIpZY0AE5LyCdRrE/S2sgdf60Pzt50RKbxz8M2DKxXdW0yEtG++g/i6UW3FBLHjT/IMY1zb0EcCHsvzxuu80mzDDl9D1pKg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e7HSJOCRVxl0eAMhVrKgGHpfPG9NlOgcvIjy/cx6jZjkzRDmFjlFaoSbd1yyDth+gsv5lLcIc9rK1SBvDsUT1b7TLJOgnvw2UoIwEUYNFk44zBrUPRN0M4Xjxx9R/hqZAiZ2537qqqMDoRdCLhrckgdPIb5YyN4u6UhFtOpmc+bvKGq3A6DGflGgSgQX3RizEfClRsVub7COulpmHcInyu4b1cdF/K61/Di7tkfRcyfU0PGWQAOr1ptmeoAkX3qIH4DtrOxGNXE9P6CWTz362tmMsLgb6f3Si62VJh8wcnYACoVmMJjCJNK6DGMKOswwC/MxeO/OUMYWRiMH0j/aN2Q17ZmjbkKY/+3sOMI26Nxsv4lJBSHuMN67zl+jlBJfRcGsKI94vv4Ge6XzhZ/AM4lIC6eQA1S590mNZP41eR312DibxaKwKKnzQixRttOYKUFjQxwXJPKahdVuFHrf5bGW1Jqd1Hn6RunaSTOJLmYXNp5BfjSGlwyOygJtvy9yIs5tOq8HrTPyiGp71gEEYlufSYqNYmgaFaMW+noLXoI55yWql+MlPWLeK8XSfIX7JOGPC7VFSD29Dd3ZZUHiynfdk6N+YYIZeyOi23LmsLE0u9Ehi0NcXpuQSKjfET7cUxGCDraNYxhMOhbok3HBtg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8f2110-6850-4c04-851a-08df2f0b9a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:38:19.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Z7Hw2L8BCu0tbgala8FU4B0T9IrT68ogEI/cn7D922V3mMWNFiwHRvuSkx1Pq7FedD7ztiaHoovAJspBvAmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-Proofpoint-GUID: tH0hcLgOaOO8tJimJa7rH7lXd9GHKtji
X-Proofpoint-ORIG-GUID: tH0hcLgOaOO8tJimJa7rH7lXd9GHKtji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXx9iUbHL0Ajsi
 9Zb0HmEo+qlyflSInP+ZAOFv+RvfYcGGky2m3EZ4CfUIl8qPKnonWlKirLQL/E2lg9eFYULikKo
 RO9RLDGlHQaCzaD6hV2xALm/MKfL+0OeX+RUPI8te+vWQ0GFLvIGG9u0Fw62QtWDlPbsKLa1rc/
 aSB76PxPOBB6FaLI08lya5pR5pedi+ZNw4UWTtPLEbY3uZ5lvUtx/BXhEMgkBBY3CNpn2zaeY1J
 rbBkJR3TsYLntwfaT9OIYc/sAg6/jxpAkJVLB32ltOQPg2VnYAXMXdGA7A9wFfckiHDyp7wuTpV
 X4m/cUcW9BybhYmU6SeSNCxSmHob3UziMsOLT9bLaPxegmr309jOgZ8S1E1FBEh/ehV+R/cFUx/
 E225d9Xz/zFRrDDnq2IdWJiR4G0sUdY26xfHxO1SlAFP6j1SJCCg4jfvBW24VZJVb+UmWZpaNFC
 Bo1HC4AQ9fo2HlyPm4w==
X-Authority-Analysis: v=2.4 cv=E8RYNqdl c=1 sm=1 tr=0 ts=6ad80985 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=O0cdpFghz9ZPo4PmLpAA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX3YFUgZoey4D7
 LziZO+NbfX6ptlgQEZW4GOkS1x71EkJdFIzCeQoUVrgA22THD9GsVa8DlJCr7GVTThG5gCICPCn
 BB1knoerDwML9cQjvBt/IP4a/AxxGOg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001

The flags of a disabled endpoint may be preserved while its End
Transfer command is pending. If the command never completes, the stale
flags persist across a soft disconnect or an error recovery, and the
endpoint can't be used again.

Reset the flags of all non-control endpoints when starting the
controller.

Fixes: 76bff31c7fba ("usb: dwc3: gadget: Do not clear ep delayed stop flag =
during ep disable")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e531adc02a40..a8f12e583a0f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2972,6 +2972,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
 	int			ret =3D 0;
+	u32			epnum;
 	u32			reg;
=20
 	/*
@@ -3029,6 +3030,15 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 		return ret;
 	}
=20
+	for (epnum =3D 2; epnum < dwc->num_eps; epnum++) {
+		dep =3D dwc->eps[epnum];
+		if (!dep)
+			continue;
+
+		dep->flags &=3D (DWC3_EP_TXFIFO_RESIZED |
+			       DWC3_EP_RESOURCE_ALLOCATED);
+	}
+
 	dep =3D dwc->eps[0];
 	dep->flags =3D 0;
 	ret =3D __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
--=20
2.53.0
