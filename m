Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7838DC78;
	Tue, 29 Sep 2026 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651353; cv=fail; b=E9E4Jq6qaqcZTMKIfhhhOn1xdB1x5WwHsqFknDWM2GyXp+2YUQ0KQ7l2pwFCbHOvHMx9WHtAMTxQauJCnAQLvvd0n8usj7y5cGWQS39hsRlZL6HOq71NSs6ns/THr5hUAOt06Z3ZfGi3rNFhHDbwbH8lN/1r3MKHKgIwhKv1ZPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651353; c=relaxed/simple;
	bh=xLBCMfK0yCQMZrY+b/hS8eFD1v9aD5xWVV6Gk9Le7oY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sUhPj3neUKBhq4Qcr00XxPrOwz4o+VVPwvTARAr2OWaZtYmWNmkBa+eU85yv/0bjqo0L+hKJ4bngUb7SYp8xHFlbS78G8ZS8Oq9meuhwAB/GoPZOZZclRk9+dwuwq0KuG297Pu1b07BmU2KDQuD3HFK6NL5nbWliGUq+nVxKITo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tJZuTrlP; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MsSiKIF0; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TuXxsZl8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tJZuTrlP";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MsSiKIF0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TuXxsZl8"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T31jB82776776;
	Mon, 28 Sep 2026 20:08:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=xLBCMfK0yCQMZrY+b/hS8eFD1v9aD5xWVV6Gk9Le7oY=; b=
	tJZuTrlPTRINLOUSmlthOwajZnBv+sXaRVJYYgBUAJUGmRlm8XTGOctn35F3gtKP
	tp5/M25p21m+N6BTo9OGPLTU7KHnITuWvIGOi6nFQ3YmqqXOpVTpqPRkSraoonng
	ZhYzDpyIU2kfp7UgYWjA2vB/Z0AsKHu81IoP9d3iE+WfdILaWTUvl6uIB0SRnDuw
	L7iG/YSAwMtfMqFBmMep9LI5GlCYqtrS4njK/m7EKi0t7m/7tPzjc7qmHn6uGmjP
	mSGm8Ard/olaib3HglHDjJkZ5ovf0LUe90/alAkx9NUxSIbQKIe7DLUsCFVOk5VC
	DuWm44F2jvsaY/yLA9kdoQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4gyxg4t2t5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790651334; bh=xLBCMfK0yCQMZrY+b/hS8eFD1v9aD5xWVV6Gk9Le7oY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MsSiKIF040GXzZGPaD/CpK33286yLx5M2CiZGVgsHNY8otbmZHOGrLWs94yoUosHD
	 EXLjXWJ0o4ZA7zitHbtY0zMLRXQBzNRi8A2IEJjc0pJORiSxSwI0RDdVkD89StNcZM
	 hPK/2EvHWyu33/wHd8I/jbTuqclK2w93/iXzStWa05sCcdP3Bgbc7MzOvnN0ux+oaC
	 LppzLFBx5MbbcmQkFVwx+fzsAZXAn0hgWvZ/DeMn5G7HnhWxN00aYOoHRfxDcdlZhx
	 EDhSjz/M/glax8N9YzTnMTavY8Hfesb0Ai68/tkfn2/21BILnlA44KFB5ay82RRy9A
	 MF8MYQfepc6/Q==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 40CAD401A8;
	Tue, 29 Sep 2026 03:08:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BBE7BA0070;
	Tue, 29 Sep 2026 03:08:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TuXxsZl8;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00404.outbound.protection.outlook.com [40.93.13.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 10E2340A75;
	Tue, 29 Sep 2026 03:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxFEmTkw6WH9DRmraihl8Cdd3nvNgpLUQhLBa3LZBW6FkGaTq0MWzb5dP3WmtaEHdx+LsTE8S1/27bl9dgNt7zN15insavjKTYWz3Y90s+esXpOfYf+4bb/XAu22v404gowzjl5jPmeV5vb8qs1xEl8MuBn5EibV4cPMmVJEokuh6SUB6+Lq81J2YsHpWwQQCbhrRH0ZHPCgvOmBKUYz6zfmYjv9H3yZ8Px5Df0TmhIhu9jRff5t+SKodOddT3KFgMPkePj2zpBwgF2Jvu16MNc56EonxLCGY1i1F2QCvRI+PdqaJ1/Neutk9b38HrD+nFwQ5HwmOsZWiyhYscTCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLBCMfK0yCQMZrY+b/hS8eFD1v9aD5xWVV6Gk9Le7oY=;
 b=bYOEI9rSYUr10WY8etqukASr/B/O9ztqF2kVYeJkfykBYHbXj0Zx86jNRgg9cqsRlJY7YcPlCLKktNkNF/RrgPEKVu0SaSvelcYI9rNcSP4+IN2EmwRk276uXoKLVCybpr6cc89F7sP065Jntiarinx2C2VEP0il8f3F8kazmt9tiThpEdFIC+JdJBP4gpSg0l1+1CMDniMKPA0mzmG/bqURNra8gDogELFuC3ohUP9oWb5RD3ZnP0EyRjMWj5k0daUZcVxyxGJNWL+atEbWjE+8BEatN4EnbTP7LFZJFBJStlRURejK8RIDLV8SHJCZBwrNOGm9Dpn1SxpHDoH1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLBCMfK0yCQMZrY+b/hS8eFD1v9aD5xWVV6Gk9Le7oY=;
 b=TuXxsZl8a/CYoZgtoaUgMzKK3osTiTepCHaGZrgd2HHJMDbAvy6bJHrY6Kx9ApTQTYPYANFSp45jYYT4IphaXwGOm2+KeyG6SmS1tSPUeD2TAApNVYLRCb62G751Z/NfIX9Ik6oLWkWKJqENEslYK9ZANhrWt1P5spI0Dr4JkVU=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:08:34 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 03:08:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "pritam.sutar@samsung.com" <pritam.sutar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Index:
 AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYCABYeXgIAAj9uAgTzV/YCAB0WsAA==
Date: Tue, 29 Sep 2026 03:08:33 +0000
Message-ID: <arsnMM-GvuXwBKCX@vbox>
References:
 <CGME20260227121338epcas5p4baebb406db37f07223545b2f85751bf2@epcas5p4.samsung.com>
 <20260227121236.963-1-selvarasu.g@samsung.com>
 <20260228002711.e442cuxwld4s2f66@synopsys.com>
 <20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
 <08273adc-d8cf-48b3-ba45-853d363af0e6@samsung.com>
 <20260306214123.3jnlzd2tmtwggch2@synopsys.com>
 <7f8a7341-3701-4ade-a198-cf86719da931@samsung.com>
In-Reply-To: <7f8a7341-3701-4ade-a198-cf86719da931@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DS0PR12MB7581:EE_
x-ms-office365-filtering-correlation-id: 5fac383a-e778-4f7b-d2ee-08df1dd6f27b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|38070700021|4143699003|6133799003|4133799003|10067099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info:
 qQwoLNvAPwINr3zMw4J0ZTnp8ORwgEn+gkZW6a/qt0tji59xH2oRK92RwFy5dvd/ewVj6zSgG1ohcr2fsu9+zNrtbctqdFPelRzqT9U7tJvocB65IJUF2KxLYbKDfVR8jvxUC26UDnDWNq8m0rNJZEDB9ZKF4oJ3/DyNWi0kNHASsIrfZqnD1uxhL8fJ0tNyjw8rpGzc9jyRAy3S78VbANjx4IDo0Xg4wev6XzM/MRhjJC3SlSYCEm+N3wzl9qIzOjjgxagOko1JOpRrBvdKwCHfTKPV+GJdjAxhAVkRE2Qq+0wIiRlkOGGICBPxw1T1Zvy2R7ID/Ks2tXck2MvVR+BabJiWfGjrpoSKqfL2By3aFEFBhd3s/1BO2Qg3tPygewHL3vWGajYDG5DHqZVcZ5NCvDgFvMssLSjmck4oqdA+cCafQx+HFH5gLcXC/LqqUPk8EqSjhwuWYk/mcpt9fwyJ/u9XZG3rI9ThUvC9m+1/DFaPnqxTKfLo51DkyH781JpR2Fpk8JvX46wM9iUV//S3zU9SmBfM5TgiIlgjYoCl22wdaGKtvSWX6JkjO75WqKBWPCQ1Cbth1dSTVeyn0Gbnhip4VIbt12VujyFUGgsiHyn31xhto5+I6EoN2NpRE9aAdFcSo3usmJwz1vzMHSDiYdExfWJlKoH/xDi6lbdi+Yxnctx9oE5E3EQFANVy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(38070700021)(4143699003)(6133799003)(4133799003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0ZBRmlPZGNRZ3ZpeXlScXpSTVVsejdocUk3M2RiVXVPMnFjSmUxYko0blVM?=
 =?utf-8?B?Y0VpTXNYNDJSS25LUWpqQlJUZ0FnSVBtb3dralFUU2U5YUtUQWpuUTUwbHNZ?=
 =?utf-8?B?ZDQxayt1NEEvMm1CVGtDQXI3TGpGeGNMTGowOVhlcFJHYndXT3BUNm5zdFRF?=
 =?utf-8?B?S3BpdldkZkVmV2lVdkpZV2hrS0ZzQ0g5SWVjMDdkQXJzVHJVd1pXT25hNCtQ?=
 =?utf-8?B?VlNWWW9zMDR1bklMTllBVEJydHdrWGZrWEE1STFUbkVoMUVYVUhjSzNwdFNl?=
 =?utf-8?B?eWZMOGptSnFiV2lvTUthdG9WSkFweFdJaEc5cnd0dXRTTGV2czgrQTZMVDFU?=
 =?utf-8?B?dUVFOCtyZTdVL2dtWVoyY2E0QXh3RmprY2g5bzVSZ0N6MWNmNFIvZmpDQUZM?=
 =?utf-8?B?QmxQRkp1Y1Q2d3hwbkV6R1NkZ082L1pTV0hoTm42L2lpNWpyVko1TjdxcnAv?=
 =?utf-8?B?M3plR3Z1RFYycGhRTWhIUW9zNFUzaWdRWDMvd1pNZW1UcHE3a0ZTbk4xYWhN?=
 =?utf-8?B?WElXRFFzbGtMbldaMmhXcnlPT1F0NHNtekJVbG1PZHV3U2lRUmZXeWJyckIy?=
 =?utf-8?B?bmtocXBWVzF6K1Q0S1FRUEtFbjYrOUNycXkzNDZpM2tVd1AxcjA4QzJvQXlC?=
 =?utf-8?B?WFBNRXVBWlAvSUdTN21xbHBGZUNYODdkcUFObHBUbVJjeU1aS3JRQzBwZnVv?=
 =?utf-8?B?cU5HUkdVdTJmc3pLTWhaWlRyYk1oUG1yZ1docllEMTJoM2xOUHB2dFMzQUJo?=
 =?utf-8?B?TzlienZsS3ZKcVVuN3g2S09YbDR5UGgzM0oyeDJRWFhpNkNZUU13cWx5cXVZ?=
 =?utf-8?B?c1A4U3FWM3VvMURqOFcxYS9tR09BSnNNVUFhUnpNMGpxSTI1bDVsZXluZ29V?=
 =?utf-8?B?K1UyN1UyQmRlWGhNd3hrVDliSWcwS01lNjRGMEwveW1wRFJZZWFvQ3hWZWUx?=
 =?utf-8?B?YmV2WkoxMHZqL2xoL1JOWkRITURkY2JwQzJTT2JuMFVKajVjenRtR0FHaUdx?=
 =?utf-8?B?czRxMVJYblpyc0RwL2xlM3VhMnZZemRVU2RWWk9ReTMvaWZZeWc1OHROckJV?=
 =?utf-8?B?cjhCWDM5QiswVERONXhXZk42NGdWa3FaUWgxbk11L29Pa29qOVhiakRES0Vu?=
 =?utf-8?B?RFE4U29QaWt4MkFMYVIySTAwQXVsS05HZFgzdUxlVlpvbVhlTXk5T1A2Z2l4?=
 =?utf-8?B?Rytoc0VaSnVsNFl3S3p0bG9aMzkwMVFISW5qN21TdWhXVVFFeFNleGdZMDl0?=
 =?utf-8?B?Ny94KzhEb2M2WVgwN3dIZmo5ZmZNMmVYRmowM2VLUXpLOXFzRDc4VzdTQW9s?=
 =?utf-8?B?TWRzaTVxN3pmYVZEaUNEL2s4a2N0UnAyWUNoUnNhQWZsejI2L1JIZHM2NWF6?=
 =?utf-8?B?aEtjTzhQR21Dbm9EN25ldUNtMUNJV25FQ0dIVC82UTNidW1zVThaLzdaRDc4?=
 =?utf-8?B?TUF2bmZFcEI1OXhKd29zbmM0MmlYTHIvWGJjVkRyZS9WMnJSQmJDeWs5Z3RD?=
 =?utf-8?B?dWZDL0R0YlQxdVhXTWFHUnNXT2VZajZ0MVhaS1loT0lrMHZ6L0xkeEFwKzN1?=
 =?utf-8?B?Q0pKSktjdkZaOTFDSHMrTnp6cjVtVVp6TzlHcDdKM0phTnQvOEhEMlowNERI?=
 =?utf-8?B?NFNjVGlQWXpSLzJSNG1kUi8zZlFQVnRwZzF0TXpEVy9OTkhlMmFPdFZuOFFU?=
 =?utf-8?B?SmgvZ2V4N1B1ZHpkVzMrdVVoQ3lHTGduemE3UGR6K3NYK2l1ME5LeVZua2VQ?=
 =?utf-8?B?UmJ2V3VBei9pTVB4MG1CMExYdldWbjI4MnczeGZod0JUNUhtNzRzWUhONlVL?=
 =?utf-8?B?aS9JNjdURzFhS0FCNjZ1aGcxR3NrVHgzYWhQRi8xTXJoY0lNM3R6K1NrNWo2?=
 =?utf-8?B?OEZRdEZwT2ZBQlNNQ3ljbkt3aHFnODJoUElpdzRRZzRQb0NQVEx3ak91cFRp?=
 =?utf-8?B?blQyWVlyVm96M3BpZzByTldSZlNWM1Q4UFZXUnkyMDFVMGs5blhBZFAwN2Ny?=
 =?utf-8?B?MU5wMUZLMFZ3Q2VURkF0cEE0LzFnUmlCK041TmNycFV0U0hyNVJSbGlQSDcz?=
 =?utf-8?B?NXhGWkt5SkNsaXpzV25DdzJReFBMejY3WWhtbEhjcXJsbG5LUUgrV1QvbWhr?=
 =?utf-8?B?MDZCNjMxRnFDYnFUbnYxTGRQYnBzN3p0dVBxeWVQd0t0ODBWalM1Zk50bUps?=
 =?utf-8?B?T05ZbnpzM1BoYlU5ZEIwYWl1VTdVbTIwWWpWdzNVN1hWUmxDVHZXRmdjMC9N?=
 =?utf-8?B?UHV2c1dwbHhvdzFKY2dOM3VJSTQrU2Y0OHY1dUJvcHdUK3lrWUVNd0FCcGNE?=
 =?utf-8?B?ZmlEcXFEdHZZSU1FU3cwMUxxYWpZblhLYlFWUXMyaVhmSXZpcDdzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B47685E3020FE34A9CA5589E201DA598@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xe/VjjXajC77oKy+x47O1mAMiTVyusCZ2RRfFXKsTddK/hx26C6lQD24npwTvTe3SmD+HGbckVx/eZwbnhZy2D5jVNZIBKDj7PgMCijCueKPosWbKIi28xypnDapvfgiSvCmHNmBKzq3FrVwqY6biNO2JIPU3pg9iaXwdmonNW11tnIMDvK8yEZEDio1n6yb+A1rPAQhdeSspvx3JExUEa1/R5zwantSbl8P6tr3hJazlov/pCb2x1lr9fttC101CqYf1GidbzzGaXkyFObXqHgq/XfAU/Rlm4EfFfoBOB7ukgX2wojOwn9SqLeNMd/9mX9VSyKji8BK7O6Yeo0ljw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/Neci5SBy/BNmxQlE4KZdvbYB0AzRD/ukyUmYUrNDQ9UAAvVT2/+kK65PQFUKzYkIGmuqXGH2rrxiihLGlMkqNJdxB6xVDyZa0A20XOs0g2NHSxsZDpO7mOYtzFBE89IfG7qu7bMsZviIUrGYmz6GzuxiqCq3mxUQRtTKVg6MrSvCjwHOlGkGztiFBxrxpQNUtbfPyNEudJaSPcZmIwDo2791Wuoys6CAutAK0UldcF4yzoUag7XDpJ6T5X/OrRC4jk+9mB2kyIuTea2zVuVRu4CJyQRy21UJ0VKYMFujine1YppKIEBOYm6pP3kklgVxqEDGXYiqBLYZ9V+DwTMNPHxmobeRmxOitL3P/NbdHCuuvGe3z3RgM/z7EJVrBcr6vxqAXeEz9EjtEpAH+G3yo56o8Rk/5J8XPv3Du3F+KLhKM5q2RwbKD9c8jMHVDqyGUAij5cFmiKahkQTYim0DquTzjNgYDamXG93hG22kcZ5WFTnxncyrQ17HpMskMDlc+kG3LKqwer/fni3yntf1kOKsAOTi3izqLvnD+emGwn7JnCpgJxU1VCfawB7UP3BfU3bemLKXiKFMjpX3PL7Kip69iNuKny+MElpFWaPVxuTjtveiFAwEFzmrQVfZ7MqG13TwM0KJN3ljGupslvlJA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fac383a-e778-4f7b-d2ee-08df1dd6f27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 03:08:33.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zh7r75PAY4jZCU+K8fOzbXNitAYXDVHsH24qrHhaA/flCTG6tPuFKZfZzv+JZq4WaV+SBWWmCqVCSwcpO2ICgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
X-Authority-Analysis: v=2.4 cv=T4QZ3PKQ c=1 sm=1 tr=0 ts=6abb2bc7 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=2JLUh5-gAAAA:8 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8
 a=Ep2sEMTJ6sXoWI_CYYwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX7D5ZDuCOW/Bd
 TqGdnHK74N74T9o6mTHSgDxQETRhWLarWGvIW44Hc676mOKI7/9++jo06QtX+ilP0zuOUhoeg0o
 XBXqZbokQsCaoOBSqZxES23or+vTMds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfXxgN0EoPgjwKG
 Taqn7Bo2TdGeVN3L3viwzFi51VgbwaiRKvUo3VMGP3S2x+MliiMZ+5TcLPO6aplQiD8O2j4SV39
 iMSPdPqEepc4nLdpGWNNmKqu9L9Sxy2ooDrAACLMdtpIANCLshj55+iDZ7boYkMEzQqMVLKqKCd
 u6YEyyXCmwcmwNUqXJZDoaZQ7AmAYhiLVDCLLQXK8hBY311pDsOTUGxAaApysIxqSv5bClXLiGi
 DbhId/EG+sLITVbpPuudPLaVOP4IIVZyKSv2wiljY/4zNlUkj8pTvus7gvPle0oQ/F224U/cT1Q
 U5BrWeRkGFKppBoaJ4xsATJbxZaOjalnYGhzW6z7VXo753TWTlEkuqXsM/uZf/8plMJ4iEKiLxd
 cu9730oiVvI+VOQqCLXQlBwsX04gmnYcHHYqMWopXMI3WFyQ2u7qUIhIay2dsIe5qxA4YQ5r69l
 wT71P4OKPc+b+b8f5QQ==
X-Proofpoint-ORIG-GUID: oB9KIA_cKhPVKQNnEsZEKnx7-nlMBAVe
X-Proofpoint-GUID: oB9KIA_cKhPVKQNnEsZEKnx7-nlMBAVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609290012

T24gVGh1LCBTZXAgMjQsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
My83LzIwMjYgMzoxMSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWFyIDA2
LCAyMDI2LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gT24gMy8zLzIwMjYgNjowOSBB
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gT24gU2F0LCBGZWIgMjgsIDIwMjYsIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4gPj4+PiBPbiBGcmksIEZlYiAyNywgMjAyNiwgU2VsdmFyYXN1IEdh
bmVzYW4gd3JvdGU6DQo+ID4+Pj4+IFRoZSBiZWxvdyDigJxObyByZXNvdXJjZSBmb3IgZXDigJ0g
d2FybmluZyBhcHBlYXJzIHdoZW4gYSBTdGFydFRyYW5zZmVyDQo+ID4+Pj4+IGNvbW1hbmQgaXMg
aXNzdWVkIGZvciBidWxrIG9yIGludGVycnVwdCBlbmRwb2ludHMgaW4NCj4gPj4+Pj4gYGR3YzNf
Z2FkZ2V0X2VwX2VuYWJsZWAgd2hpbGUgYSBwcmV2aW91cyBTdGFydFRyYW5zZmVyIG9uIHRoZSBz
YW1lDQo+ID4+Pj4+IGVuZHBvaW50IGlzIHN0aWxsIGluIHByb2dyZXNzLiBUaGUgZ2FkZ2V0IGZ1
bmN0aW9ucyBkcml2ZXJzIGNhbiBpbnZva2UNCj4gPj4+Pj4gYHVzYl9lcF9lbmFibGVgICh3aGlj
aCB0cmlnZ2VycyBhIG5ldyBTdGFydFRyYW5zZmVyIGNvbW1hbmQpIGJlZm9yZSB0aGUNCj4gPj4+
Pj4gZWFybGllciB0cmFuc2ZlciBoYXMgY29tcGxldGVkLiBCZWNhdXNlIHRoZSBwcmV2aW91cyBT
dGFydFRyYW5zZmVyIGlzDQo+ID4+Pj4+IHN0aWxsIGFjdGl2ZSwgYGR3YzNfZ2FkZ2V0X2VwX2Rp
c2FibGVgIGNhbiBza2lwIHRoZSByZXF1aXJlZA0KPiA+Pj4+PiBgRW5kVHJhbnNmZXJgIGR1ZSB0
byBgRFdDM19FUF9ERUxBWV9TVE9QYCwgbGVhZGluZyB0byB0aGUgZW5kcG9pbnQNCj4gPj4+Pj4g
cmVzb3VyY2VzIGFyZSBidXN5IGZvciBwcmV2aW91cyBTdGFydFRyYW5zZmVyIGFuZCB3YXJuaW5n
ICgiTm8gcmVzb3VyY2UNCj4gPj4+Pj4gZm9yIGVwIikgZnJvbSBkd2MzIGRyaXZlci4NCj4gPj4+
Pj4NCj4gPj4+Pj4gQWRkaXRpb25hbGx5LCBhIHJhY2UgY29uZGl0aW9uIGV4aXN0cyBiZXR3ZWVu
IGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoKQ0KPiA+Pj4+PiBhbmQgZHdjM19nYWRnZXRfZXBfcXVl
dWUoKSB3aGVuIG1hbmlwdWxhdGluZyBkZXAtPmZsYWdzLiBXaGVuDQo+ID4+Pj4+IGR3YzNfZ2Fk
Z2V0X2VwX2Rpc2FibGUoKSBjYWxscyBkd2MzX2dhZGdldF9naXZlYmFjaygpLCB0aGUgZHdjLT5s
b2NrIGlzDQo+ID4+Pj4+IHRlbXBvcmFyaWx5IHJlbGVhc2VkLiBJZiBkd2MzX2dhZGdldF9lcF9x
dWV1ZSgpIHJ1bnMgaW4gdGhhdCB3aW5kb3csIGl0DQo+ID4+Pj4+IG1heSBzZXQgdGhlIERXQzNf
RVBfVFJBTlNGRVJfU1RBUlRFRCBmbGFnIGFzIHBhcnQgb2YNCj4gPj4+Pj4gZHdjM19zZW5kX2dh
ZGdldF9lcF9jbWQoKS4gV2hlbiBlcF9kaXNhYmxlIHJlc3VtZXMsIGl0IHVuY29uZGl0aW9uYWxs
eQ0KPiA+Pj4+PiBjbGVhcnMgYWxsIGZsYWdzIGV4Y2VwdCB0aG9zZSBleHBsaWNpdGx5IG1hc2tl
ZCwgcG90ZW50aWFsbHkgY2xlYXJpbmcNCj4gPj4+Pj4gRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVE
IGV2ZW4gdGhvdWdoIGEgbmV3IHRyYW5zZmVyIGhhcyBzdGFydGVkLiBUaGlzDQo+ID4+Pj4+IGxl
YWRzIHRvICJObyByZXNvdXJjZSBmb3IgZXAiIHdhcm5pbmdzIG9uIHN1YnNlcXVlbnQgU3RhcnRU
cmFuc2Zlcg0KPiA+Pj4+PiBhdHRlbXB0cy4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlIHVuZGVybHlp
bmcgZnJhbWV3b3JrIGlzc3VlIGlzIHRoYXQgdXNiX2VwX2Rpc2FibGUoKSBpcyBleHBlY3RlZCB0
bw0KPiA+Pj4+PiBjb21wbGV0ZSBwZW5kaW5nIHJlcXVlc3RzIGJlZm9yZSByZXR1cm5pbmcsIGJ1
dCBpcyBhbGxvd2VkIHRvIGJlIGNhbGxlZA0KPiA+Pj4+PiBmcm9tIGludGVycnVwdCBjb250ZXh0
IHdoZXJlIHNsZWVwaW5nIHRvIHdhaXQgZm9yIGNvbXBsZXRpb24gaXMgbm90DQo+ID4+Pj4+IHBv
c3NpYmxlLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBcyB0ZW1wb3Jhcnkgd29ya2Fyb3VuZHMgZm9yIHRo
aXMgZnJhbWV3b3JrIGxpbWl0YXRpb246DQo+ID4+Pj4+DQo+ID4+Pj4+IDEuIEluIF9fZHdjM19n
YWRnZXRfZXBfZW5hYmxlKCksIGFkZCBhIGNoZWNrIGZvciB0aGUNCj4gPj4+Pj4gICAgICBEV0Mz
X0VQX1RSQU5TRkVSX1NUQVJURUQgZmxhZyBiZWZvcmUgaXNzdWluZyBhIG5ldyBTdGFydFRyYW5z
ZmVyLg0KPiA+Pj4+PiAgICAgIFRoaXMgcHJldmVudHMgYSBzZWNvbmQgU3RhcnRUcmFuc2ZlciBv
biBhbiBhbHJlYWR5IGJ1c3kgZW5kcG9pbnQsDQo+ID4+Pj4+ICAgICAgZWxpbWluYXRpbmcgdGhl
IHJlc291cmNlIGNvbmZsaWN0Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiAyLiBJbiBfX2R3YzNfZ2FkZ2V0
X2VwX2Rpc2FibGUoKSwgcHJlc2VydmUgdGhlIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRA0KPiA+
Pj4+PiAgICAgIGZsYWcgd2hlbiBtYXNraW5nIGRlcC0+ZmxhZ3MgaWYgaXQgaXMgYWN0dWFsbHkg
c2V0LCBwcmV2ZW50aW5nIHRoZQ0KPiA+Pj4+PiAgICAgIHJhY2Ugd2l0aCBkd2MzX2dhZGdldF9l
cF9xdWV1ZSgpIGZyb20gY29ycnVwdGluZyB0aGUgZmxhZyBzdGF0ZS4NCj4gPj4+Pj4NCj4gPj4+
Pj4gVGhlc2UgY2hhbmdlcyBlbGltaW5hdGUgdGhlICJObyByZXNvdXJjZSBmb3IgZXAiIHdhcm5p
bmdzIGFuZCBwb3RlbnRpYWwNCj4gPj4+Pj4ga2VybmVsIHBhbmljcyBjYXVzZWQgYnkgcGFuaWNf
b25fd2Fybi4NCj4gPj4+Pj4NCj4gPj4+Pj4gZHdjMyAxMzIwMDAwMC5kd2MzOiBObyByZXNvdXJj
ZSBmb3IgZXAxb3V0DQo+ID4+Pj4+IFdBUk5JTkc6IENQVTogMCBQSUQ6IDcwMCBhdCBkcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jOjM5OCBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsweDJmOC8weDc2
Yw0KPiA+Pj4+PiBDYWxsIHRyYWNlOg0KPiA+Pj4+PiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsw
eDJmOC8weDc2Yw0KPiA+Pj4+PiBfX2R3YzNfZ2FkZ2V0X2VwX2VuYWJsZSsweDQ5MC8weDdjMA0K
PiA+Pj4+PiBkd2MzX2dhZGdldF9lcF9lbmFibGUrMHg2Yy8weGU0DQo+ID4+Pj4+IHVzYl9lcF9l
bmFibGUrMHg1Yy8weDE1Yw0KPiA+Pj4+PiBtcF9ldGhfc3RvcCsweGQ0LzB4MTFjDQo+ID4+Pj4+
IF9fZGV2X2Nsb3NlX21hbnkrMHgxNjAvMHgxYzgNCj4gPj4+Pj4gX19kZXZfY2hhbmdlX2ZsYWdz
KzB4ZmMvMHgyMjANCj4gPj4+Pj4gZGV2X2NoYW5nZV9mbGFncysweDI0LzB4NzANCj4gPj4+Pj4g
ZGV2aW5ldF9pb2N0bCsweDQzNC8weDUyNA0KPiA+Pj4+PiBpbmV0X2lvY3RsKzB4YTgvMHgyMjQN
Cj4gPj4+Pj4gc29ja19kb19pb2N0bCsweDc0LzB4MTI4DQo+ID4+Pj4+IHNvY2tfaW9jdGwrMHgz
YmMvMHg0NjgNCj4gPj4+Pj4gX19hcm02NF9zeXNfaW9jdGwrMHhhOC8weGU0DQo+ID4+Pj4+IGlu
dm9rZV9zeXNjYWxsKzB4NTgvMHgxMGMNCj4gPj4+Pj4gZWwwX3N2Y19jb21tb24rMHhhOC8weGRj
DQo+ID4+Pj4+IGRvX2VsMF9zdmMrMHgxYy8weDI4DQo+ID4+Pj4+IGVsMF9zdmMrMHgzOC8weDg4
DQo+ID4+Pj4+IGVsMHRfNjRfc3luY19oYW5kbGVyKzB4NzAvMHhiYw0KPiA+Pj4+PiBlbDB0XzY0
X3N5bmMrMHgxYTgvMHgxYWMNCj4gPj4+Pj4NCj4gPj4+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFz
dS5nQHNhbXN1bmcuY29tPg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4NCj4gPj4+Pj4gTm90ZTogTm8g
Rml4ZXMgdGFnIGlzIGFkZGVkIGJlY2F1c2UgdGhpcyBpcyBhIHdvcmthcm91bmQgZm9yIHRoZQ0K
PiA+Pj4+PiBnYWRnZXQgZnJhbWV3b3JrIGlzc3VlIHdoZXJlIHRoZSBnYWRnZXQgZnJhbWV3b3Jr
IGNhbGxzIHVzYl9lcF9kaXNhYmxlKCkNCj4gPj4+Pj4gaW4gaW50ZXJydXB0IGNvbnRleHQgd2l0
aG91dCBlbnN1cmluZyBlbmRwb2ludCBmbHVzaGluZyBjb21wbGV0ZXMuDQo+ID4+Pj4+IEEgcHJv
cGVyIGZpeCByZXF1aXJlcyByZWZhY3RvcmluZyB0aGUgZnJhbWV3b3JrIHRvIG1ha2Ugc3VyZQ0K
PiA+Pj4+PiB1c2JfZXBfZGlzYWJsZSBpcyBpbnZva2VkIGluIHByb2Nlc3MgY29udGV4dC4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gQ2hhbmdlcyBpbiB2MzoNCj4gPj4+Pj4gICAgLSBSZXZpc2VkIHRoZSBj
b21taXQgbWVzc2FnZSB0byBkZXRhaWwgdGhlIHJlYWwgZ2FkZ2V0IGZyYW1ld29yayBpc3N1ZQ0K
PiA+Pj4+PiAgICAgIHBvaW50ZWQgb3V0IGJ5IHRoZSByZXZpZXdlci4NCj4gPj4+Pj4gICAgLSBN
ZXJnZWQgdGhlIHR3byBmaXhlcyBmb3IgdGhlIHNhbWUgZXAgd3JpbmdpbmcgaW50byBvbmUgcGF0
Y2guDQo+ID4+Pj4+IExpbmsgdG8gdjI6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
czovL3Byb3RlY3QyLmZpcmVleWUuY29tL3YxL3VybD9rPTU1MzVkMGY0LTM0NGU3YTdkLTU1MzQ1
YmJiLTc0ZmU0ODYwMDAzNC1jNjE3ZDdiNzc5MTI2ODJkJnE9MSZlPTJhNjUwOGU2LTYzNjMtNGQ2
ZS1iNmFiLWNlNmM3NzgzMmM4ZCZ1PWh0dHBzKjNBKjJGKjJGbG9yZS5rZXJuZWwub3JnKjJGbGlu
dXgtdXNiKjJGMjAyNTExMTcxNTU5MjAuNjQzLTEtc2VsdmFyYXN1LmcqNDBzYW1zdW5nLmNvbSoy
Rl9fO0pTVWxKU1VsSlEhIUE0RjJSOUdfcGchZFIweXVmRzJWdmdNbmtDMFpKNGVLM0k1djdDNXEy
cnk4TVlBWVNOZFdoTU5NMnpQa08zNWZHQkpKSFBTLUdoRzR5OWh6bXJDY08xNlYxQVNlaEhCWXh2
eFFXUSQgDQo+ID4+Pj4+DQo+ID4+Pj4+IENoYW5nZXMgaW4gdjI6DQo+ID4+Pj4+IC0gUmVtb3Zl
ZCBjaGFuZ2UtaWQuDQo+ID4+Pj4+IC0gVXBkYXRlZCBjb21taXQgbWVzc2FnZS4NCj4gPj4+Pj4g
TGluayB0byB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcHJvdGVjdDIu
ZmlyZWV5ZS5jb20vdjEvdXJsP2s9YzhkYWVkMGQtYTlhMTQ3ODQtYzhkYjY2NDItNzRmZTQ4NjAw
MDM0LTg0ODg1MDZkNTg1NGU0MGQmcT0xJmU9MmE2NTA4ZTYtNjM2My00ZDZlLWI2YWItY2U2Yzc3
ODMyYzhkJnU9aHR0cHMqM0EqMkYqMkZsb3JlLmtlcm5lbC5vcmcqMkZsaW51eC11c2IqMkYyMDI1
MTExNzE1MjgxMi42MjItMS1zZWx2YXJhc3UuZyo0MHNhbXN1bmcuY29tKjJGX187SlNVbEpTVWxK
USEhQTRGMlI5R19wZyFkUjB5dWZHMlZ2Z01ua0MwWko0ZUszSTV2N0M1cTJyeThNWUFZU05kV2hN
Tk0yelBrTzM1ZkdCSkpIUFMtR2hHNHk5aHptckNjTzE2VjFBU2VoSEIxWTRxa19rJCANCj4gPj4+
Pj4gLS0tDQo+ID4+Pj4+ICAgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAyMiArKysrKysr
KysrKysrKysrKysrKy0tDQo+ID4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPj4+Pj4g
aW5kZXggMGE2ODg5MDRjZThjNS4uM2FmMWJiZmUzZDkyYiAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+ID4+Pj4+IEBAIC05NzEsOCArOTcxLDkgQEAgc3RhdGljIGludCBfX2R3YzNf
Z2FkZ2V0X2VwX2VuYWJsZShzdHJ1Y3QgZHdjM19lcCAqZGVwLCB1bnNpZ25lZCBpbnQgYWN0aW9u
KQ0KPiA+Pj4+PiAgICAJICogSXNzdWUgU3RhcnRUcmFuc2ZlciBoZXJlIHdpdGggbm8tb3AgVFJC
IHNvIHdlIGNhbiBhbHdheXMgcmVseSBvbiBObw0KPiA+Pj4+PiAgICAJICogUmVzcG9uc2UgVXBk
YXRlIFRyYW5zZmVyIGNvbW1hbmQuDQo+ID4+Pj4+ICAgIAkgKi8NCj4gPj4+Pj4gLQlpZiAodXNi
X2VuZHBvaW50X3hmZXJfYnVsayhkZXNjKSB8fA0KPiA+Pj4+PiAtCQkJdXNiX2VuZHBvaW50X3hm
ZXJfaW50KGRlc2MpKSB7DQo+ID4+Pj4+ICsJaWYgKCh1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRl
c2MpIHx8DQo+ID4+Pj4+ICsJCQl1c2JfZW5kcG9pbnRfeGZlcl9pbnQoZGVzYykpICYmDQo+ID4+
Pj4+ICsJCQkhKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpKSB7DQo+ID4+
Pj4+ICAgIAkJc3RydWN0IGR3YzNfZ2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KPiA+Pj4+
PiAgICAJCXN0cnVjdCBkd2MzX3RyYgkqdHJiOw0KPiA+Pj4+PiAgICAJCWRtYV9hZGRyX3QgdHJi
X2RtYTsNCj4gPj4+Pj4gQEAgLTEwOTYsNiArMTA5NywyMyBAQCBzdGF0aWMgaW50IF9fZHdjM19n
YWRnZXRfZXBfZGlzYWJsZShzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiA+Pj4+PiAgICAJICovDQo+
ID4+Pj4+ICAgIAlpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RPUCkNCj4gPj4+Pj4g
ICAgCQltYXNrIHw9IChEV0MzX0VQX0RFTEFZX1NUT1AgfCBEV0MzX0VQX1RSQU5TRkVSX1NUQVJU
RUQpOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJLyoNCj4gPj4+Pj4gKwkgKiBXaGVuIGR3YzNfZ2Fk
Z2V0X2VwX2Rpc2FibGUoKSBjYWxscyBkd2MzX2dhZGdldF9naXZlYmFjaygpLA0KPiA+Pj4+PiAr
CSAqIHRoZSBkd2MtPmxvY2sgaXMgdGVtcG9yYXJpbHkgcmVsZWFzZWQuIElmIGR3YzNfZ2FkZ2V0
X2VwX3F1ZXVlKCkNCj4gPj4+Pj4gKwkgKiBydW5zIGluIHRoYXQgd2luZG93IGl0IG1heSBzZXQg
dGhlIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCBmbGFnIGFzDQo+ID4+Pj4+ICsJICogcGFydCBv
ZiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZC4gVGhlIG9yaWdpbmFsIGNvZGUgY2xlYXJlZCB0aGUg
ZmxhZw0KPiA+Pj4+PiArCSAqIHVuY29uZGl0aW9uYWxseSBpbiB0aGUgbWFzayBvcGVyYXRpb24s
IHdoaWNoIGNvdWxkIG92ZXJ3cml0ZSB0aGUNCj4gPj4+Pj4gKwkgKiBjb25jdXJyZW50IG1vZGlm
aWNhdGlvbi4NCj4gPj4+Pj4gKwkgKg0KPiA+Pj4+PiArCSAqIEFzIGEgd29ya2Fyb3VuZCBmb3Ig
dGhlIGludGVycnVwdCBjb250ZXh0IGNvbnN0cmFpbnQgd2hlcmUgd2UgY2Fubm90DQo+ID4+Pj4+
ICsJICogd2FpdCBmb3IgZW5kcG9pbnQgZmx1c2hpbmcsIHByZXNlcnZlIHRoZSBEV0MzX0VQX1RS
QU5TRkVSX1NUQVJURUQNCj4gPj4+Pj4gKwkgKiBmbGFnIGlmIGl0IGlzIHNldCwgYXZvaWRpbmcg
cmVzb3VyY2UgY29uZmxpY3RzIHVudGlsIHRoZSBmcmFtZXdvcmsNCj4gPj4+Pj4gKwkgKiBpcyBm
aXhlZCB0byBwcm9wZXJseSBzeW5jaHJvbml6ZSBlbmRwb2ludCBsaWZlY3ljbGUgbWFuYWdlbWVu
dC4NCj4gPj4+Pj4gKwkgKi8NCj4gPj4+Pj4gKwlpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBfVFJB
TlNGRVJfU1RBUlRFRCkNCj4gPj4+Pj4gKwkJbWFzayB8PSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJU
RUQ7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gICAgCWRlcC0+ZmxhZ3MgJj0gbWFzazsNCj4gPj4+Pj4g
ICAgDQo+ID4+Pj4+ICAgIAkvKiBDbGVhciBvdXQgdGhlIGVwIGRlc2NyaXB0b3JzIGZvciBub24t
ZXAwICovDQo+ID4+Pj4+IC0tIA0KPiA+Pj4+PiAyLjM0LjENCj4gPj4+Pj4NCj4gPj4+PiBBY2tl
ZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+Pj4+DQo+
ID4+PiBPaCB3YWl0LCBkb24ndCBwaWNrIHRoaXMgcGF0Y2ggdXAgeWV0Lg0KPiA+Pj4NCj4gPj4+
IFRoaXMgd2lsbCBjYXVzZSBhIHJlZ3Jlc3Npb24gZm9yIFVBUyBkZXZpY2UuIFdoZW4gc3dpdGNo
aW5nIGFsdC1zZXR0aW5nDQo+ID4+PiBpbnRlcmZhY2UgZm9yIEJPVCB0byBVQVNQLCB0aGUgZGV2
aWNlIG5lZWRzIHRvIGlzc3VlIGEgU3RhcnQgVHJhbnNmZXINCj4gPj4+IGNvbW1hbmQuDQo+ID4+
Pg0KPiA+Pj4gVGhpcyB3b3JrYXJvdW5kIHdvbid0IHdvcmsuIENhbiB3ZSBmaXggdGhlIHVzYl9l
cF9kaXNhYmxlKCkgaW50ZXJmYWNlDQo+ID4+PiBhbmQgcmV3b3JrIHRoaXMgaW5zdGVhZD8NCj4g
Pj4+DQo+ID4+PiBCUiwNCj4gPj4+IFRoaW5oDQo+ID4+IEhpIFRoaW5oLA0KPiA+Pg0KPiA+PiBX
ZeKAmXJlIHRyeWluZyB0byBzZWUgaG93IHRoaXMgY2hhbmdlIGNvdWxkIGNhdXNlIGEgcmVncmVz
c2lvbiBmb3IgVUFTDQo+ID4+IGRldmljZXMuDQo+ID4+IENvdWxkIHlvdSBleHBsYWluIHdoeSB0
aGUgd29ya2Fyb3VuZCBtaWdodCBiZSBhIHByb2JsZW0gZm9yIFVBUz8gQXJlIHlvdQ0KPiA+PiBj
b25jZXJuZWQgdGhhdCBpdCBjb3VsZCBtaXNzIGEgdmFsaWTigK9TdGFydFRyYW5zZmVyIHdoZW4g
YSBwcmV2aW91cw0KPiA+PiB0cmFuc2ZlciBmaW5pc2hlcyBsYXRlciB0aGFuIGV4cGVjdGVkIGFz
IHBhcnQgb2YgZXBfZGlzYWJsZT8NCj4gPiBJbiBVQVMsIHRoZSBkZXZpY2UgY29udHJvbGxlciB1
c2VzIHRoZSBmaXJzdCBQUklNRSB0byBzeW5jaHJvbml6ZSB3aXRoDQo+ID4gdGhlIGhvc3QgdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIFN0YXJ0IFRyYW5zZmVyIGNvbW1hbmQgY2FuIGluaXRpYXRl
DQo+ID4gdGhlIHN0cmVhbS4gQWZ0ZXIgY29uZmlndXJpbmcgYW4gZW5kcG9pbnQsIGlmIHdlIGlz
c3VlIHRoZSBTdGFydFRyYW5zZmVyDQo+ID4gY29tbWFuZCB0b28gbGF0ZSwgdGhlbiB0aGUgZGV2
aWNlIGNvbnRyb2xsZXIgbWF5IG5vdCBpbml0aWF0ZSB0aGUNCj4gPiB0cmFuc2ZlciAoc2VuZGlu
ZyBFUkRZKSwgYW5kIGhvc3Qgd2lsbCBub3Qga25vdyB3aGVuIHRvIHN0YXJ0IHRoZQ0KPiA+IHRy
YW5zZmVyLg0KPiANCj4gDQo+IEhJIFRoaW5oLA0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxheWVk
IHJlc3BvbnNlLiBXZSdyZSBzZWVpbmcgdGhpcyBpc3N1ZSBhIGxvdCBpbiBFeHlub3MgDQo+IHBs
YXRmb3JtLCBzbyB3ZSB3YW50IHRvIGdldCBpdCBmaXhlZC4NCj4gDQo+IFRoYW5rcyBmb3IgdGhl
IGV4cGxhbmF0aW9uIGFib3V0IFVBU1AgaW4gbGFzdCBjb21tZW50Lg0KPiANCj4gV2UgYWdyZWUg
dGhhdCBmb3IgVUFTUCwgdGhlIG5ldyBTdGFydFRyYW5zZmVyIHNlbnQgaW4gZXBfZW5hYmxlKCkg
aXMgDQo+IHdoYXQgbWFrZXMgdGhlIGNvbnRyb2xsZXIgc2VuZCBFUkRZIGZvciB0aGUgaG9zdCdz
IGZpcnN0IFBSSU1FLiBUaGUgb2xkIA0KPiBwYXRjaCBza2lwcGVkIHRoYXQgU3RhcnRUcmFuc2Zl
ciB0aGF0IHdhcyB3cm9uZy4gSWYgaXQgaXMgc2tpcHBlZCBhbmQgbm8gDQo+IHJlcXVlc3QgaXMg
cXVldWVkIHJpZ2h0IGF3YXksIHRoZSBjb250cm9sbGVyIG5ldmVyIHNlbmRzIEVSRFkgZm9yIHRo
ZSANCj4gZmlyc3QgUFJJTUUgYW5kIHRoZSBVQVMgZGV2aWNlIHBvc3NpYmxlIGhhbmdzIGFzIHlv
dSBtZW50aW9uZWQuDQo+IA0KPiBUaGUgbmV3IHBhdGNoIGlzIHNpbXBsZXIsIHdlIHdvbid0IHNr
aXAgaXQgYW5kIGp1c3QgdHJpZ2dlciBpdCBvbmNlIHRoZSANCj4gaW5mbGlnaHQgZW5kIHRyYW5z
ZmVyIGlzIGRvbmUuDQo+IA0KPiBQbGVhc2Ugc2VlIHRoZSBwcm9wb3NlZCBzZXF1ZW5jZSwNCj4g
DQo+ICDCoCAxLiB1c2JfZXBfZGlzYWJsZSgpIC0tPiBFbmRUcmFuc2ZlciBkZWZlcnJlZCBkdWUg
dG8gcGVuZGluZyBjb250cm9sIA0KPiB0cmFuc2ZlciBkYXRhL3N0YXR1cyBzdGFnZXMgKERXQzNf
RVBfREVMQVlfU1RPUCksIG9sZCB0cmFuc2ZlciBzdGlsbCANCj4gYWN0aXZlIGluIEhXLg0KPiAg
wqAgMi4gdXNiX2VwX2VuYWJsZSgpIG9uIHRoZSBzYW1lIGVuZHBvaW50IC0tPiBpbnN0ZWFkIG9m
IGlzc3VpbmcgdGhlIA0KPiBuZXcgU3RhcnRUcmFuc2Zlciwgc2V0IERXQzNfRVBfUEVORElOR19T
VEFSVF9UUkFOU0ZFUiAoTmV3IGZsYWcpIGFzIGJlbG93LA0KPiANCj4gIMKgIC8qIF9fZHdjM19n
YWRnZXRfZXBfZW5hYmxlKCkgKi8NCj4gIMKgIGlmIChkZXAtPmZsYWdzICYgKERXQzNfRVBfREVM
QVlfU1RPUCB8DQo+ICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEV0MzX0VQX0VORF9U
UkFOU0ZFUl9QRU5ESU5HIHwNCj4gIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERXQzNf
RVBfVFJBTlNGRVJfU1RBUlRFRCkpDQo+ICDCoCDCoCDCoCBkZXAtPmZsYWdzIHw9IERXQzNfRVBf
UEVORElOR19TVEFSVF9UUkFOU0ZFUjsNCj4gIMKgIGVsc2UNCj4gIMKgIMKgIMKgIHJldCA9IGR3
YzNfZ2FkZ2V0X2VwX3N0YXJ0X25vb3BfdHJhbnNmZXIoZGVwKTvCoCDCoC8qIHVuY2hhbmdlZCBw
YXRoICovDQo+IA0KPiAgwqAgMy4gQ29udHJvbCByZXF1ZXN0IGZpbmlzaGVzIC0tPiBuZXh0IFNF
VFVQIC0tPiBleGlzdGluZyBkZWxheWVkIHN0b3AgDQo+IHJldHJ5IGluIGR3YzNfZXAwX291dF9z
dGFydCgpIHNlbmRzIHRoZSBFbmRUcmFuc2ZlciBmb3IgYWxsIGRlbGF5ZWQgc3RvcCANCj4gZW5k
cG9pbnRzLg0KPiAgwqAgNC4gRW5kVHJhbnNmZXIgY29tcGxldGlvbiBhbmQgdHJpZ2dlciBhIHBy
ZXZpb3VzbHkgc2tpcHBlZCANCj4gU3RhcnRUcmFuc2ZlciBpbiBlcF9lbmFibGUgYnkgY2hlY2tp
bmcgRFdDM19FUF9QRU5ESU5HX1NUQVJUX1RSQU5TRkVSLg0KPiANCj4gIMKgIC8qIGR3YzNfZ2Fk
Z2V0X2VuZHBvaW50X2NvbW1hbmRfY29tcGxldGUoKSAqLw0KPiAgwqAgaWYgKGRlcC0+ZmxhZ3Mg
JiBEV0MzX0VQX1BFTkRJTkdfU1RBUlRfVFJBTlNGRVIpIHsNCj4gIMKgIMKgIMKgIGRlcC0+Zmxh
Z3MgJj0gfkRXQzNfRVBfUEVORElOR19TVEFSVF9UUkFOU0ZFUjsNCj4gIMKgIMKgIMKgIGR3YzNf
Z2FkZ2V0X2VwX3N0YXJ0X25vb3BfdHJhbnNmZXIoZGVwKTsNCj4gIMKgIH0NCj4gDQo+IFNvIHRo
ZSBlbmRwb2ludCBnZXRzIHRoZSBzYW1lIHN0YXJ0L3N0b3Agc2VxdWVuY2UgeW91IGRlc2NyaWJl
ZCwgb25seSANCj4gc2VudCBsYXRlciwgaXQgZ29lcyBvdXQgYXMgc29vbiBhcyB0aGUgRW5kVHJh
bnNmZXIgZmluaXNoZXMuIFNvIHRoaXMgaXMgDQo+IGhpZ2ggcG9zc2libGUgb2YgaGFwcGVucyBi
ZWZvcmUgdGhlIGhvc3QncyBmaXJzdCBQUklNRSBhcnJpdmVzLiBFUkRZIGlzIA0KPiBzdGlsbCBz
ZW50LCBubyBVQVMgcmVncmVzc2lvbi4NCj4gDQo+IFRoZSBiZWxvdyB0ZXN0aW5nIGxvZyBpcyBm
b3IgdGhlIHJlZmVyZW5jZS4gWW91IGNhbiBzZWUgdGhlIHRpbWVzdGFtcCANCj4gd2hlcmUgcGVu
ZGluZyBzdGFydCB0cmFuc2ZlciB0cmlnZ2VyZWQuDQo+IA0KPiBbIDMyNzMuNTk3NDc2XcKgIEVu
dHJ5IF9fZHdjM19nYWRnZXRfZXBfZGlzYWJsZQ0KPiBbIDMyNzMuNTk3NDgxXcKgIGR3YzNfcmVt
b3ZlX3JlcXVlc3RzIGVwMW91dCBza2lwIHN0b3AgdHJhbnNmZXIgZHVlIHRvIA0KPiBEV0MzX0VQ
X0RFTEFZX1NUT1ANCj4gWyAzMjczLjU5NzUxMF3CoCBFbnRyeSBfX2R3YzNfZ2FkZ2V0X2VwX2Vu
YWJsZSAxMDQ1IGRlcC0+bmFtZSA9ZXAxb3V0IA0KPiBkZXAtPmZsYWdzID1lMDA5DQo+IFsgMzI3
My41OTc1OTBdwqAgZHdjM19nYWRnZXRfZW5kcG9pbnRfY29tbWFuZF9jb21wbGV0ZSAzODU3IGRl
cC0+bmFtZSANCj4gPWVwMW91dCBkZXAtPmZsYWdzID00MDA5IC0tPiBUcmlnZ2VyZWQgc2tpcHBl
ZCBTdGFydCB0cmFuc2ZlciB3aGVuIA0KPiBlbmRwb2ludCBjb21tYW5kIGNvbXBsZXRpb24gaXMg
ZG9uZS4NCj4gDQoNCkhpIFNlbHZhcmFzdSwNCg0KSSBqdXN0IHdhbnRlZCB0byBwb2ludCBvdXQg
dGhhdCBkd2MzX2dhZGdldF9lcF9zdGFydF9ub29wX3RyYW5zZmVyKCkNCnNob3VsZCBvbmx5IGJl
IG5lZWRlZCBmb3Igc3RyZWFtIGVuZHBvaW50cy4gSSdsbCB0YWtlIGEgY2xvc2VyIGxvb2sgYXQN
CnRoZSByZXN0IG9mIHRoZSBjaGFuZ2VzIGxhdGVyIHRoaXMgd2Vlay4NCg0KUmVnYXJkaW5nIHRo
ZSBvcmlnaW5hbCBjb21tZW50IGFib3V0IGF2b2lkaW5nIHRoZSB3YWl0IGZvciBjb21tYW5kDQpj
b21wbGV0aW9uIGR1ZSB0byB0aGUgTm8gUmVzcG9uc2UgVXBkYXRlIFRyYW5zZmVyIGNvbW1hbmQg
ZG9lcyBub3QNCnByb3ZpZGUgYW55IG1lYW5pbmdmdWwgcGVyZm9ybWFuY2UgYmVuZWZpdCBzaW5j
ZSBpdCBvbmx5IGFwcGxpZXMgdG8gdGhlDQppbml0aWFsIFN0YXJ0IFRyYW5zZmVyIGNvbW1hbmQu
DQoNClRoYW5rcywNClRoaW5o
