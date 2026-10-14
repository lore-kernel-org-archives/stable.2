Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49D3290AA;
	Wed, 14 Oct 2026 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941268; cv=fail; b=qlcOTuQxgi84wQeI7ktKluQmoy1jFaj9GSOG+MSwyHwHCAW97xyar0G34nx0B/peVIw4QfOg79noDzxpVr3cDvU+Sc9B42w1P9+B62O0yKuwL80uTIBqXuH8pznLAAkT7N2E30/em+FkfB2n4uDW4FpF5R56jzeHP/qlNoT1Wcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941268; c=relaxed/simple;
	bh=lJmYASQxyC3qadDD/7dlig9mW1K4ghMDA97hlD0bBDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzKVW/1qCl3adlSK8/h5OBdRtCuO1aB9gB5GTQLTbH3mDdN0XJWJ1SIpplJ8SxkI00ocJUOyDqRnLmGXYjL0LgldWqxaCi5v3VrSdkRI3DcrHRELMubS/IVrPSXAPT+ovBOTxsj59SueG9BwtP22H2LtUJXdQo9thjULj3atowY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FLyObOmj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MdTuIESz; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BqiWG4Mb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FLyObOmj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MdTuIESz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BqiWG4Mb"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DLnvTP3877830;
	Tue, 13 Oct 2026 18:27:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=lJmYASQxyC3qadDD/7dlig9mW1K4ghMDA97hlD0bBDY=; b=
	FLyObOmjotg/hsMOSEz6DFdT2JaZJ8R0YFNNYURgvl3ECeWem8d/3XLXt9Vsy/O1
	MfR6NT3BfAWrDqDkWE8UspmUMPq+LKFVMeEqd6wqo0dDYF8KikdJaOHhTGFNdtvH
	ahe8Vq1jn427AF1roTN5XqnpfhUlhY0nLF9BlIWEIxvezPQDCnCE7hYQAP1OzY6B
	7KS2HLGkkXl6ZFlrTRu7+ErKhDzW/RPcdy75mf5IkOY5U1Yiu8Tdsfc0mDlWvQae
	uL6GVsE4aF8eEeMzit/3yvXmYh6HbP4yvxohMToDt8TWedDqRl2gdR9Vk8RTXdrT
	HKbmj72VJ1qtApWkMdmp/Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4h9ssuagts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1791941259; bh=lJmYASQxyC3qadDD/7dlig9mW1K4ghMDA97hlD0bBDY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MdTuIESzi1sBSwCiPVyF8frHmEUW+B/QGQ05VjioR0DtLYXqaFoUvbaffvt7q04Yx
	 yrG1pdLuz+75kzk3YZ2opEiFHyfUVfzyL3DaSNoJn+3rMnXjp7ye3hnFMZHRxMNzMn
	 j2Inf9CTtG4fEa0UZvOuAj1wDzgUZ5n/yuifEMcZaXrN76Of9Rc7PLI8HvoQPCSK+7
	 nV3oZhUMv5Pc3WZJRIuvDSuKjBn0wWW6nfGX6yd9uB1sqn3725b29LErux2eCO2Y1Y
	 rWhbpY10K3Pb0WG5O7h6dmbdQ+Z9R7xhzXe6nP91yjkh9NkuUpwRg6/VEv+UNJ4D9D
	 sUKnYXPRIxDLQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 29B7C401C7;
	Wed, 14 Oct 2026 01:27:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 584AEA0070;
	Wed, 14 Oct 2026 01:27:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BqiWG4Mb;
	dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com (mail-bl0pr07cu00102.outbound.protection.outlook.com [40.93.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AF9D42201E1;
	Wed, 14 Oct 2026 01:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0Sdyxj8R82mfezAzfyq6fMJL6FhbIifZ90AtpHv7bdjad9CBJcFrdht1JDIO4vxgjQWAmNYLOsU53ybrGJ8QFJm0JWQb2SPhIruFdZImpq+pFyAlgKrPqNYTGXvjPSx/1DP7R4tsl23TKZ6s3uot7F9Xqs2koQ73FiHiIObE9dgfJvdtrvuzhTY2xEtXQvldsfoRcKW89KtAVQLU0fAuH0WGG8v1OtnHxLm8F6BqpWxHX6CwSqgeXUXg0dgIYmfatajYdlU4rYnRz7Bq2EmSkFZga4XcCB3UFFp3tkWuxtdf95p8tGzsisTTvCvmTD8kfYoUoRPwcbMdofAKWHukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJmYASQxyC3qadDD/7dlig9mW1K4ghMDA97hlD0bBDY=;
 b=L5dcQLTGEVO5/ehIgepLUeCrowDKunPgwBM7fqFJqnFT9ZmLZBeSMibOL1yGHrqw3vvhOrqwXTb6y7jdMgwduYirw1c+P53QH09bHMVccA21S5xnJCmQUy5bPfpfKXQYJo3+4+9usuAl8+mQzRREWMqDkqm4qjwFoFmg2FtUIMR/0TM0uc0yM/sZhiuJ2ZW1P5EqOfDlwlQ77VF4A0VPlkeuRDSVu2s2Pvdw8BhADfJdcggi1mOJCJVk7PV0bspA0InGFbh+LCrAHdXqeETby5J99Nt7dsaZcYnPt6N3ZwTl1Ob8KxkDr00BFlSOiQGf+Y5z3pN+f+VfyFXSPwZzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJmYASQxyC3qadDD/7dlig9mW1K4ghMDA97hlD0bBDY=;
 b=BqiWG4MbWCmJfifyGqzSOF6FKQ4Aa5/XjcZdTw8ZTMp6L/b+13YPfsOrefSogss0afOM+RMIlBa3Q6OHvH10o1c7HK7O3nsC8XjDwTZevkRS4nKvkmvmCKBFA9yRjhrHRyLC3kF0MZupMXPhCndVJlGOVIT1GrGoLB6LmZLemno=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.24; Wed, 14 Oct 2026 01:27:32 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 01:27:31 +0000
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
 AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYCABYeXgIAAj9uAgTzV/YCAB0WsAIAAQgCAgAXz24CABaAIgIAAq3WAgADGm4CAAATnAIAAo2GAgABNrwCAAUxggIAFyh8AgACW7YCAABUsAIABdiIA
Date: Wed, 14 Oct 2026 01:27:31 +0000
Message-ID: <as7ZHFpqLz623QQt@vbox>
References:
 <CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
 <asWmW1jmzedIV5SP@vbox> <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
 <98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com> <asbJfaj5OIhHBunD@vbox>
 <bc43e3f5-ba0c-4f91-b765-ee35021bf089@samsung.com> <asglyrMYkopr3EOz@vbox>
 <0a2bc277-3977-46cd-9759-ba273b5c2c4d@samsung.com> <as2N1JlPnpKBYcsb@vbox>
 <a8021139-a675-4875-b437-7e837d5433b1@samsung.com>
In-Reply-To: <a8021139-a675-4875-b437-7e837d5433b1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DS7PR12MB6216:EE_
x-ms-office365-filtering-correlation-id: d3f6ca71-10d0-4f6a-293b-08df29925183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 u6nVCL3omWYWx/VaaP0HAlcTyXEWeH0yKrCBr9m2qDw42np//GwXV5QhWMmt9N3GYnzf+dXUKBHz79TzGJ1XtQnXPqG/avGxRp8ox3AiPQJw4I7gQrp+mR/6rcHouJuKQeKtNMALWlfrlL38ux0yzE//fgDhi8aNAgDnl6MuxMz2vrt17wVuv/scI9JL9b9Pu93PF04Ny0bR8Vp76FdUX0SMayw91faWpjpN/JabPbhkpTFdmQ8QacXytEPuEWv37HolfYbt4nbqQFCxKOGpH52uu96fzzXi3m78e7oLbLCo+0UaArZNpIDrvr/70n7XZrRDHkq3kKdY2IspYm/hAdi/sImXgmf8HcLXnE11MtOoGtgPR29RtOgn2sU+ZIMAoHXm6AeoSdEcs6213dy0VwOMp+FKKMvDaOyisLf/YNRVaZvAp4R6aXEm1vY8XP+V/XxJXnXHlye1YPBAp51I7lNh9o7aG3wKIVjEGMTTp+35INeU71HXyYG3E6WycDqhwHVkNS6DQTNwMe4gxs3z73QhINCTUKMcKiPc7rTRFzY0+wAiAGbXQym7NNQSIWuWB+vFH7cxnDEH4gaJM/EbqtPSxpFnYm1tWDOoPLyVZ25gyV9gvEtSvK8OcTAgse99I+oqghEjTqMpHi0vdh9lvZcg4BLiUfKJ+i6uNwiit1m8bNSXjDmzWSuf9GiYirt9FRt9FVoJ4z4qSG4ssn6pFal27ac2UwYoyIIijjVQUg8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWhkMW1xRVVCVGdSN0ZuS3ZMYm8vcGZsN0QwSmZxTUhFb2RCV2lCVm5nZnVX?=
 =?utf-8?B?OEI5b1Q5SDlXaWdkU2g1Qmh5Q2pUazhrRVphMGtSUVNZN3k4V0N0QytIc0Va?=
 =?utf-8?B?YU9aUnV1MGIxMVF6SjR4Y3pBY05SOVg0cFJrQW5RaEx5MFNoYU0wRE9aM05Y?=
 =?utf-8?B?azRwVy9ja2lnaTFsZkV0eTI1SUJSWHJ4eFJTU3FRSXk2WEp4RHRQN2EreENH?=
 =?utf-8?B?cklZSlhVTXZ4SHBFZGd2RXZFVHdqQkNXbStkUFVpeFRwSk9vbC8xWFUzeWUz?=
 =?utf-8?B?T0dYN3k1MGRscCtLcmJ5ZDRpTmVZcjcyY2xvM3VYTGxnZ3pEbFMvUS9paDdJ?=
 =?utf-8?B?c2ozeWpDdWdzNDhWQlJqMnluVDk0Z0t2MS82M29DMHQ5RlYyNnNqV0xvUEtP?=
 =?utf-8?B?WUZWcThYa1B2SVBmTWN2d1RUQUtvUkVqSDhGdDU5b3c3enhWU3B6MG1UdHRa?=
 =?utf-8?B?Y3BOcFo4YnRENldOZnM2UHhYN2dSaHRlMHUvVDlHVmVxMjNyZkF3V1BRZWYy?=
 =?utf-8?B?YUpBTU5ET1A1RmpVYm1vOEVBTzF6NDFKc0pRRzU0bzB5T1gvQUlnbURNTlBy?=
 =?utf-8?B?SGc0UkpZeVVCbnV3RnRyS3VtbVBVSXFFVzJIem1ta3NxeGk0WGtvUS9tbnh1?=
 =?utf-8?B?eWRvcXJ3L2NzK1ZiV055aHVHeU0vcm80ZjIrL2lnTlZhT2lyZGRPMzNCNmd5?=
 =?utf-8?B?ZjRqYnBicjh5eUZlSGpIemozTnpXai9XMDdiSGhSWnY1YnlKUHh3U0JGZ2Jn?=
 =?utf-8?B?YlVZZzd1RGcvT3dmeWw1VDY0Wm05STFReTBnajA0UnpFOFVYVzhqZSt2YWxC?=
 =?utf-8?B?RTRKcWtXc25UN0xnSUttdmlXOUUySWJXNjkvcUREWm96bmhNN3c2VUVpWCtM?=
 =?utf-8?B?clNPUkdXdTlFaHZpa3l4YUxzdDVYUHZmRjJ3SjdRR3F0NzBEVHdZSHdPcE9v?=
 =?utf-8?B?cTVyNjF4TWtiVytDMll5OFMwQjBnQlhCM1BTMVJONDdzZ2NYSU9Bd2tsZUxi?=
 =?utf-8?B?V244UHhqb3FIVmMwc3JoRDhBNHJ0L25lREdRSHFBaHNHTjA3U1kzK1BMd1dZ?=
 =?utf-8?B?M25KSllRSWZPSHBNeWhKd2xKZi9Ec01sWHRGUHBqVkliTWlxZko2TGVUQkxG?=
 =?utf-8?B?cjRFcjdCYS9CQnp3eHlMdE05Q1hjSnpqVmVLK1ltYUpyaFdsbElXd2U1bjlx?=
 =?utf-8?B?MzVwb2VlaWpDZzR3NnVPQjFMejh5V1hBbHQvQk4yU2dMUVlyNHZ6K0lJL05R?=
 =?utf-8?B?UGVOUDFsU1FOTForcmdZeEpNbndHaFhOcWpadWwwUnNkdVBrUnI1d1BrbU95?=
 =?utf-8?B?WVFIUDQ2ZzI5U2R5TUMzcE1zRXZHMzJsMjJsSmpsVithVDVLcXlPd1RFbHZL?=
 =?utf-8?B?NGlsSUJnWUZNd0xzeXk5MWFQTGEzOUlpM1VBVURabjQwbUZ4aGdkQkVBZDdK?=
 =?utf-8?B?WEFOWXB4cjY4MEFvZk9yNVoyZk9lQ1hBcThwcm5lRnYxcEtEdWZ2K0cwQXpP?=
 =?utf-8?B?QnlqcWRmR3BWSXRlb016dEhLdEQ4S3dHS1czUk9tL0ZCYVBLdDE0SHhXSDdl?=
 =?utf-8?B?VzNsbk12VzdrRzdHbCtNV0s2Y1NTY25FUmlHUEFZWStPcTdVL0pGMyt5NTQz?=
 =?utf-8?B?YlhvNHB1K3BwNWNoYnlzVFd6NnBwWnMrM0pHMm0yYVp2NEd2TDhwemJhajA5?=
 =?utf-8?B?bTNDZmZqSGR2WkVDQlJjQ3pFdGdCV0k4TWpLeE5KZGZIazJFWnRBWmdIOEMv?=
 =?utf-8?B?bzNSTHc3RDB5UHF6d3lINElNeFBmN0VrdWR3eGRuUWdPNGxwTHRGVDE0WFZl?=
 =?utf-8?B?Y3grUWZhT1M5WHcyOXIwcFJ2Rm4xWkdIdHBLQ1VrQjFCTFNkeFlyTjNaTjlB?=
 =?utf-8?B?MHd3bmwxOUxDd0J3eTgzTGRuR3dMQ1pwaHptK3J3Q24rRkZxeXRRRXczV1pH?=
 =?utf-8?B?QVViZTFHZlZ1ZDYzeDJ4MzZHdHZLaUdvSjlZK1NtYUl0QkQ2ZkpyNnM4UFQw?=
 =?utf-8?B?bm5vbFAvbVRuQ1pJeVNBU0JHWXZYcEFza2RlbHVVT2FqQ2JsWVA0N0FKOStn?=
 =?utf-8?B?VGNJZDV4NVJRdG93VlhQRXV4dGhrS3BJaVdoREFhQjB4eUtOV3p3bjVQb00w?=
 =?utf-8?B?UitRL21DcGFsU2JIa1doZ202N0NRZ2pJR1hQQjlOMnVRQjV1TEpROFEwOTVz?=
 =?utf-8?B?UXRmMHJwakdjNm9NSDBBdVVmSURmMEpZa1YzM2ZuOGFpZEhySngyc0tTajJG?=
 =?utf-8?B?UTluSml0TTNCQzNxZmhlUDFzUHJaZjZWR21JTVNtcEFCcUVnSFVrZll1MnZ5?=
 =?utf-8?B?MVFJa2lMNEdEQ3JRVE9EZ296NGQ5b3JReWRxNGNqSmlPanZicHc1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01226B5271DB7B48B14A613715F800C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Qd5JDm/36pf50ONOWdppT1O8P9l7X8TB08GESR3ZGcTNOFFDpPRdjztMjCZqt2XZmG/bt0x+hMdYO8qxsMJYozbXdQgITYba61/2FFI74CtjWX1LoBEdiHC+M2LYhtTu22/l64dQa4Z1XPmT/DWGFExdcNnS6H7afYCPQ66tjo9i4FRAglgXUwe/wESIiROAZvptXSHk1b9p7aoPnX6eOkhLrbLKzcbtrhnBynMdEP1Liod4xxRebtEN5oKhRMPOM3616NNEWXVux7xIbpwNVHjyELIjFuJrRfxZFYxlVR8StLipbEvv9isUK/9H/wr9k4tjW6M8bSohuIBpJcapvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vHPGqcx2r30oENnSKZzS+E6QxGF1zCxlPo9JJqLnIKZlF5OdbIPINUCbYg5dhp5tlAJgYXkpcE7IeuN0WPx2NpfIPrEGrOA+Wly7eZChaXINJ+k4Y1HI5XqFMFtevXgD79tfRcpNIGxJfAuGavTeqk/LDEuo4qtyPB/kdxFOOM3GbBdBTRaXU6yaQ3gxjfAjXWGFMWRtbmPgU4x5vp717fvHi5/yLRluGC/7lOqlposwcjuKd1GT5LEMBeskZvpoSBUMDu4FWXuMGOzNGED+wswoQgT2GAwjI2f5u+nxJDrTHvsN2W0mLqFBSvyMNPbqVcNjCajjAWvUewb/bcUXn9D89zpePZWIFrleB/u779pht6gnrHCrDYFWiIxV7dFRsvP2Vsmc2EVXiWks3fAlP9kJr3SAlRvOGDL3wJ2rE9nBu7EVHJe+F40VU9R8QPT44uHTRdtGn5UAl/Bv/mHxk9v3LzM5UJpBJWsOmQ6XwT9d66t6zaCuqNdpENrpemAFH3oUc1eqO3Lak1yIQbUcrlAvEQGBPUaQL/NnZQfu8JHfcACpHNevtC/E0VgK4/2vMylPfQEQU9XznYcpHIe+7QQmfrZewFxWVL7gshDrGELupwtGf2nAnzFMdfykngWwgSHR8f63wH4tora2Ws55Pw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f6ca71-10d0-4f6a-293b-08df29925183
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 01:27:31.9238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZkPLc2FDCe7VLR12ukk4iBN+4kLlJSP6YcFbT5CBTNBkxU6l2/DbaOrmK87Ap0NFfD00rEb/IWAKLzXdqCtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwNSBTYWx0ZWRfXwj86DrDSeiAc
 u/BJKE2D2NCKXU+Czz5GGvR3tJTSqkCmzjk0g6er+E3lQ2VOZJ0ulK1kWXjbct0eFZDCYqGyTSS
 9K0DTyF34S7AF8HIeIoBFA7Zt3gxmYU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwNSBTYWx0ZWRfX+JSFzrFHK/xE
 T9Nzrvi6reuWoXoNt9TjdTr8aORzwX7pi+SSRhaNZ5iPQc/Ynf3RvdnwV4pdHVVcQ+zpmSZQjlE
 31pWju7W4XJ4RpqdQMpiSfJlwZ+59RyCkEKNniO4PUY8Rz7bSwGWO3ZtoIIa09zMLkn6rEFNYW4
 EKt2Po6z1dLDjuUDFEG4vwV4bSGIEe/Cgjr3eEMceOiHaqHpT+CVynQRzntBK4ek9ioxf+cGGkB
 IpnGEAee2lfvB9lZwVWvTi8idxKYOPVTPWQ0PaOGbdwtawqmWGQDdVwRbxh73a0+PEFiUIyIOzi
 r6nxzh7y79sc+x8mkNLZveRTD8amHu/hiqmhQCZLCOHXPXzZ5HNpGRl0xS7nytBGT/3fCfwyIsr
 CpWL/qCTKwIz6O6emEgsEOYA1klR+rCPGJeibrVr752tKSxUpK/I1qAgYA9bN+3r8/Spr3nbEGN
 qkSu8pAOoeg/dbnId7g==
X-Authority-Analysis: v=2.4 cv=Wt++otfv c=1 sm=1 tr=0 ts=6aceda8c cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=8jzvz50XA1i27yH1c_gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7Kzx9bQYSFmBKpdCc4IpUQDdYYstzyiH
X-Proofpoint-GUID: 7Kzx9bQYSFmBKpdCc4IpUQDdYYstzyiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610080000 definitions=main-2610140005

T24gVHVlLCBPY3QgMTMsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gSSBt
ZWFuICdub3QgcmVjb3ZlciBoZXJlJyBpcyB0aGUgZmFpbHVyZSB0byBjbGVhciB0aGUgDQo+IERX
QzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcgZmxhZyB1cG9uIGNhYmxlIHJlY29ubmVjdGlvbiwg
Y2F1c2VkIGJ5IGEgDQo+IG1pc3NpbmcgY29tbWFuZCBjb21wbGV0aW9uIGZyb20gdGhlIHByaW9y
IGNvbm5lY3Rpb24uDQoNClJpZ2h0LiBSZXNldHRpbmcgdGhlIGVuZHBvaW50IGZsYWdzIG9uIGNv
bnRyb2xsZXIgcmVzdGFydCB3aWxsIGNvdmVyDQp0aGF0Lg0KDQo+IA0KPiBTdXJlIHdlIGNhbiB1
c2UgZHdjM19zY2hlZHVsZV9lcnJfcmVjb3ZlcnkoKSwgYW5kIHRoYW5rcyBmb3IgdGhlIHN1Z2dl
c3Rpb24uDQo+IA0KDQpJIGNhbiBwcmVwYXJlIHRoZSBmaXggcGF0Y2hlcyBiYXNlZCBvbiBvdXIg
ZGlzY3Vzc2lvbi4gSXQgd291bGQgYmUgZ3JlYXQNCmlmIHlvdSBjYW4gdGVzdCB0aGVtLg0KDQpU
aGFua3MsDQpUaGluaA==
