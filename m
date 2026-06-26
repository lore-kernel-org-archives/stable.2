Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B53C2D;
	Sat, 27 Jun 2026 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524968; cv=fail; b=Na6PjHL5JiUN00oS7bmRM6lZ6HbupzfgC+7Lwd8weq0hZDysTMM4MXP/NteUHjzJb8AyCN5ymEWoaBMj4QbA0K/Pn5zn0+lCdAbQ/ntprgT793SEjgpDeQTSDgIkgMaQvxbNn3UrEfiYybBugmtN9PgDXz2R3igbvvpUyCN90+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524968; c=relaxed/simple;
	bh=5TQLy6z2jBqBEuMGaWFiHdFB6nW6PLpEDH5n2ALWXc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CoeWkdlX1qvH9jq3KeoZCvIvSzJDIB6/f21uf60jKA0Dve4HG7GEvuVCa04SCjru7vXYfGDQNm6JRAZ9YQPajOdQalBFTDOJIRz0hlrsM3yjF/QyVByRcM4XrOuRVUYcvWwdxgccCJYr6fc/7Gd6HgRSWCDvwA3AufXZiaL2drQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iv9tGkQE; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AV2MvNFF; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YKRBoXrO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iv9tGkQE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AV2MvNFF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YKRBoXrO"
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QNI6832380294;
	Fri, 26 Jun 2026 16:21:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=5TQLy6z2jBqBEuMGaWFiHdFB6nW6PLpEDH5n2ALWXc0=; b=
	iv9tGkQEH6gnD/bYbYAR3JO01nAwjvWFH9zEPSWRcboVJoAhE/KIenkhUkYomgy+
	P0jhHEk/p5kcw4+Chb7t9AQEVcBwwdOCQu4ULJG3Z41+kZkjMuE1wH5UCcLffliZ
	8EOsmInnBOjZkfkx+OIotPgfHf1aZ4LLJTV5IGQlX7eKD+AN9ULRQFzS7MgxcI13
	q8Zf42TxI7pzkkfCRYeAwVghLvu5pQKhGPyMgHQOi94Qsy4scaTYWqZXWUl5Q4d6
	elxAZDnta5H33ScEGpb5vX4ObXneGRurH3LSsBqSHhmrl1L3Hb+CgLFqHesdFDXj
	kpWMHTeeaBPWlVi8ItaDPA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4f1mwk81nr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1782516065; bh=5TQLy6z2jBqBEuMGaWFiHdFB6nW6PLpEDH5n2ALWXc0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AV2MvNFF6rWa+IGTNgyzNPJY9NMVH87Nj3jgyC6Bea4p3kgM8s0x7BSO0bdfUJ3L5
	 JBVkXRog2DAPM8fQ4HP6TePAbS+aY7LxWj2AOFpDYEl23gmbRwfLf8Lh0/cSv+45Y4
	 f8MFxFDCMYJY+L4TNcVwo9jRwrVqOE1Z2hV82MIF9pPl0+ZdzlIT2z+8VCQQ5y8/rT
	 h8DrRfMIQnOcMrtOl7jbY+0dxYk52w2Vs7cOecpZ5Zxik6x5iMK91800ucg/Cvt8hO
	 TDEcwqmbh5aK/wfk1B7nHf+wLISYIvsXyyOBma2Iii9L7naJUxpUAn+bvQtwWilidF
	 DOZnPVp+5frNw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 44B284012F;
	Fri, 26 Jun 2026 23:21:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 51408A0063;
	Fri, 26 Jun 2026 23:21:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=YKRBoXrO;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00100.outbound.protection.outlook.com [40.93.10.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 14F75401BC;
	Fri, 26 Jun 2026 23:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYwxTKKCL7+4BcS2a5LXdk9CwdBgJaL+otaRAIfwIN7DqGFsIG/HeOcjm/UjwmAV8UYnEXlZLlamLbq6dpPZaS30oPh/2sv6RCUTq8XvrfY/szH3DMSck+7gdht3POqvogzl8HuDZrxvbYSGudUptTjFgObTgH3w9zcTu2XpMcHSNbKig9ZKWI/tktmJRzTmgObylfSGjxyVhfEuy4HbGKQRcwKG6cByW0q2A3fv520j1czsXr4+vEA5s+FpTZFp5wPScvaHI7W8Jjo9nj7ftHx1ZQIJJmrJGIKLb5kJFgzc9+mgI8nuBjVNM7Mu7p88hSeCadDccZ/HiaWopG3t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TQLy6z2jBqBEuMGaWFiHdFB6nW6PLpEDH5n2ALWXc0=;
 b=jRhmP165pv10juJZJee8jUZa7tC0OW71Tmf+PwynVUTHLO5SLzPl5kO5+GFh3CHUPPQn1JmH2DRA9vkroITYK73Fkli1+Jqa5+p0dnAsWY0MmN8v1Vqs9+q7ZpLDLP0G1agx7F8h3RH+O+IqeqZqEgBBcNRrPRyreSrgitdgXcHOYsffx6ozICORTuYb34oNYpWO1+BTVLUDM5gOK79/CVC9rjrLdYjubgJ9p2gwG2aOKL9qhr8AOjjXF9dULLc1cs90FBHcs6H1fFxhSPxu/H6KU2IoGJZ4n9k9QKDedMbzIkCxdWP09ixQmU7sGdtJ0ETi99cfYf6jOId3kik6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TQLy6z2jBqBEuMGaWFiHdFB6nW6PLpEDH5n2ALWXc0=;
 b=YKRBoXrOikfjU+L+XBvp1J6Vqqn9YSzT88G9L/TMBJlXLv9iCFiuaM+G27uoqtzfv+Bdmtd5MKeH9nzNUU8uMz847lFvk8xn0rBS4blBB+kIvLdmbuNBdpSjseH09PIiXOSSN+crapCLm3iAqqNtRp5d6csa30iKFyv8p1QeelI=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 23:20:51 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 23:20:51 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: WenTao Liang <vulab@iscas.ac.cn>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: meson-g12a: fix refcount leak in
 dwc3_meson_g12a_resume()
Thread-Topic: [PATCH] usb: dwc3: meson-g12a: fix refcount leak in
 dwc3_meson_g12a_resume()
Thread-Index: AQHc+aPdMDtukPvz0UCSyfOE2A5fjrZRkZCA
Date: Fri, 26 Jun 2026 23:20:51 +0000
Message-ID: <aj8Gyn2ClDFDqRx0@vbox>
References: <20260611131121.81784-1-vulab@iscas.ac.cn>
In-Reply-To: <20260611131121.81784-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM6PR12MB4369:EE_
x-ms-office365-filtering-correlation-id: 47695296-7d76-4530-18af-08ded3d99009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|11063799006|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 BX4JogoYhWstzop066JUCqfYQ2sDnHLv+HJQOWrKp9LmyG7evQTUpdFYZaiExMoymnKdPsFGKDOTzj3ohNFZjmny7mj42XMpKq/0GkBHhTf6j+Vhtysm2Q0QunphuWMXlraFG93CSZn5Oo8sLYXgEt1VxvMD6A05oIs7q1Uz36ZrKoxEU4N+OORGByYEGC29tmoo39zVyMIuJS6GfVNsncoxlSBgk5ybqE5/BQUHwIidPSS8cCbCDatn+N0k9zrFm2GE8BCpUC5Xrn3bVg/gm2azgjgFAgezsAffolMrr4iHUqrOcL3Hna9mleQw4RKtUgs1BqgmNcPxVE6bNE2J85jbcbKYQB+D6pL6LGJYowt24Ir5yVEEDuj/ms3RxzKQBhL2TbROg6nl+sW2psl6g5UKaYUf2SKe/1u5Xe8le9dHBa1xLHo6sGrcCTUEHbwY9msw50BwlqwK++R4MJHkrmnEGDbfa8TIL4q9SKACRBr/zAWV4LSN/cxqbk3qoVUgSC8s2d/+PeQLdzTRyWTInvRe5l0cz8JP3nZNeY9x/zbMW3KB2VBb4rWrCCosUHkFHr6HVrU5xhSGCqHG9CTBu0rH9T86vlkK5Vm9q/ZduNxXvX1iDhsETfHBSkoix1HQo3mjWgdzJOaxp1tHP/WWJOg5f3RovpOg9CeZ3RGT5li8oblnb3ghM10P23PHsUH9ZgRXIOwgo8hHmk2YGVLQQ2Q/Em+knVxdzQJuT0Szl3I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(6133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anZpR2IzbnNYU2pSb1oybnBqaTN5VUs4NWZYcmRsaGNtN1ZtK0hVMlFqay80?=
 =?utf-8?B?d3ZjYkF2ay9aZml2VDhlOXRPN3haNGg4K3FETU12UnE4b1ZwY1BnUFBZb3B3?=
 =?utf-8?B?a2UzU0ZiRkJ6VFN2ZlFhMFd3VWltL241eWVBOGFETHFjL1E2RDBZKzNhc0Js?=
 =?utf-8?B?RlYxc2liZ0FuZXNNME01U1ZlNjh1WThRYTBpbldkSGRBZGdOL0Z3TkVaOGx5?=
 =?utf-8?B?aVhQbjlKaWtOY1E3QnpWNkpmRnJOamhXUE0rS1NtSXIyL09hYWJrckhLSzVG?=
 =?utf-8?B?VWJ6UFhQMENIUkVMRkZqSVRLT0ZqNkwySU9VQlRFaE1oV0lrWDJIWHhPTjdD?=
 =?utf-8?B?ajAvWERyWmIzZnloM2VndWJlQm03OFd6SlIzMUZGRFNwdlkrbVBTbnlUOTRz?=
 =?utf-8?B?Tk8zaVRTcHJteUphaEFyalVTcy9WT0NlMkdqbFhrdW13aVlOL01BOE9YQzNO?=
 =?utf-8?B?QXZodXZzWC9iTStES2YvVjltdDVsWS81bGcrN3M1RmxHaDFKWkZ6YnVXakJw?=
 =?utf-8?B?RlRCdHFlTm5vUkZsRXFKVlVCWGk0L1IzQzNkVzVBb0ZMSG9hVi9FL3U5cjdB?=
 =?utf-8?B?WGRLSDhOWFFPTnppUzFxZjZPZXlIYUVWcVltN1podFlsSnVac2ZLbjJLOHBl?=
 =?utf-8?B?c0JGV1Z0UStCOEl6aUs3SlRaL0FnNjc3ME9KWWkvT2gxbEFKZkd5RG5adS9B?=
 =?utf-8?B?K1YxMUU5Mi9CSnpScmtuNDdLZlVpbWUzc29YZHRoQTNicm1qNGhOQ1ZPN2l3?=
 =?utf-8?B?dEVsd3ErTzFVMEVOa2ZpSDQybGRacEZ0R1Y3ZUFQZ3A5QWE3Ry9sN2ZDS0Ny?=
 =?utf-8?B?dWQ2QnptS2Z2c0t0aFNTOGk2S3hIdEtPQzNVUXRKSkV1a1loUHN4YmJrRWUy?=
 =?utf-8?B?U1Vpd2ZJWTRFMUdvOUpQcmtyeDg0Nk54cTRMRy9BSHV1R3dxTWFSNW9QN2k3?=
 =?utf-8?B?RXdCaStTejZQUTNkSWVQTFZyaGdtQkFORHgzUUtXckxKSUZUTlllc0tpRjEy?=
 =?utf-8?B?Zmtod2NSOVVHNmRQVzZ4aDBCZHNLdnlXSElsRGNPRjhTcHJIU3pkTHBRZW9Z?=
 =?utf-8?B?aFY4VnpnMnVaRldZem10bDNlaWxOSUlDLzhuUDF0ODV1NG55SnRFK0VQVFZ5?=
 =?utf-8?B?NldkQm5NTlprL0hxNUYvRlE3T2h0MHdHSkE2Y3hNTnBHa2JqMUh2NDRoZWJw?=
 =?utf-8?B?bGNOZHUwMURRRGIxRHJIdkRVSFR1TTJHOTREQkFPaGhHTEVHUzhXSUw4QjFW?=
 =?utf-8?B?S3RUZjRkVmw0T3pWNkkwWDBVZVJuYkgxS2JwLzlRTkpFbStHV0hoZmpQdmhR?=
 =?utf-8?B?c3dCZ3RJTEVEWG1TNVEzOVozWW5GRHVhYnRqeTI2Y0Y5WTd1ajduYy9wWnVw?=
 =?utf-8?B?WGdvazhoRXJVRGVubDA4eHFpRHpkWWtLanNlQnJHTmV3Z3VTb211a0JUREw1?=
 =?utf-8?B?MWJ2aGprOG5QVE5ac09OWGxtR0VYd3VuSkJ4eUxRcE5jWVNJUThINWlRNnFN?=
 =?utf-8?B?WU8zREpJMy9lMmd0ZHR0QldTRWcvSVlTT2U5WWNjNnhIb3U4dkhiM3Z2dDR5?=
 =?utf-8?B?VGtuYzVSdnd3eWZHcnlCTExRWXd2bXR5UDU0bE1tL2ZaNExSdVR2TFRTRUNJ?=
 =?utf-8?B?eUg5ZXd1ZW51SXRHZVBEV2RnNlJnOGwxMDVNa0xaVUVuaDBZY3FoWWpQRXVo?=
 =?utf-8?B?K2Fwd0lTVTA1U0YvZDQ0bnhETXk5bzlVaVZOLzRodlI2Kzk0UWtnWjg0L1NS?=
 =?utf-8?B?UWxEU0xrU0JmSElxRDRLeWVKWm1vVkJZbG5vRm5taGZncGM5d2pGeEVPcS8y?=
 =?utf-8?B?WWg1U0FqbzROdE1kTE0vQklyQ1dCakEwNDcyT0t1WFplcm5FWkErbnk1ZlZY?=
 =?utf-8?B?Q2s1VVJpUUFWRU1rRW9sWnB4TFJubFJPdWdrYlZKaCs4NFJ2WG1QKzhNTTZ5?=
 =?utf-8?B?OGoxa1NGOXcyTEZiZGVYUFkzZ0hvV2JFMGZ1L1JGeGtvSmF0TlJxd2diclpz?=
 =?utf-8?B?ajBBK29jcEFxUUdXSzNuZjd5ZzZyOWwyaEFBYnJLQkc4TlM0Y20vQ2F2Nk5w?=
 =?utf-8?B?Ri9HbnFHS2lCU2pBTkYxYU4zK3V3UFdFSWN3cWVwNjg1U3VEanlmMjJzWCtU?=
 =?utf-8?B?ZVJyQ2V2RUVnN0ZYV0s2Zk42dFRXREdMNTB2bWVTNWoyaEpLK0RyK1B0TmR0?=
 =?utf-8?B?UVJHUUxEc3NFenY3dnB0OXdBVEdDNEEydzlnc2VRVmdpOUFianYrbGdtQ25C?=
 =?utf-8?B?SWlQVGhmQ0V6VU0wU3BmZWZDUlFVVy9QUXAyNEdXNWd5a1ppVnpCM0pPY2xK?=
 =?utf-8?B?a1REb1h6eHpKN1R6Z0V5OGZIVnF0UVJ0ODdGbnRqVGxhTjM2Vld1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4526738E2457C4DA652FD945D2619F1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	INFYhEOZtXGQ4LYVuptFeZw05Rfnl43nOpecPs/QWzMrlkGiwEaRhAqbovDFXeoiabHol6EpW76s/ajCB3Xus+Sg3UanTJodcYlHJ35DehclcAZt4/GSiugeLmJ7lQH5iZuwJ7BhuNHWm+F30vAbxsLhPSHFlNIv8id/LYEYzknWHf9SjWJ784o4q5xo93jBBefvgPnPajFmYai1E22HEGj2VzLBRBQuNtwlms8ymJfqXfGYQEwrxXaknFX5kDiObLxbe7afEv/aDKQenpAM3/NjqHfodDtmmjclbw/n2eR2+8ntenQBy0Kd0divx/N7c3IUc6P8nh17fj4ajyJamw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hmsVhIL3AI2198ahKhed9fYCTsL1vjnA4mNXwTCFWmGVhr+/r5JNTNur8cD6zgYVdWfAvuQ8DP5rD13Xa0+tmQX47bTZqpQ8C6w3u6I7wwbqk0c8O5aOIusFRePjm35ZvgKY3yjFL4i/DQKbd7bNDBCO03G9mUq593LJEpD5YA0G8MmL7nV13Ey+JhrZs8RBrhs1R+dboQTF1LTHvynBe/quc0KZ4DtTEeOAi0do+9nZ4Cwpl3WfYVKyOIJD0nJ4EHqShJhdXDWEEmnE9Bs/jZb2egkRVVEHhmgdbtNSoNbv1koKDOp+79RfvSdNw/b6BGzDxjEYibSjmlwZWHdXq+2CgHiFwEI4o07W7mkynTgC1GCT/qv5I4B8/gPJXq3MoQXxsOByDqHM5AaXY/t56oBW0fDIwVVDKKoCEPbGVVYqbxBjMJX1E0qwh9raq97xX5sBjarB9cWb4gsesQNm3jUngzgJMife/m9chHGL9LF86Aa/54vhLgIHF77zWiucfbR4AuE2V+oykaggduVFJ6NxhyR7njHeseLe6JAp+asK3KiX+TmMMv/T2yDEKQcfcRXdppPhQCBH0+Q9TXW6dLotqi/kDlhc0Sjnvp3u6ynB9PyVUNOi9RlWxHe7sB8Bid0tjoXTaqcAd9K2Ix7ehQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47695296-7d76-4530-18af-08ded3d99009
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 23:20:51.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgsHJb1usQUX164cYKG3e2lvunbcHh2AYdgFhDixj2Bdfb9kz8UXmTVU1kVzEE9m2RsyJskkbmdQ2yOg5xVjCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NCBTYWx0ZWRfX9J4WCyucF0An
 LC0klYZsxFFrv5yc7cBhBlJ+09YpwVBva4VJXlFjr1IFhkP/WuKdlLjmiiaqOK5jhj+n/IRdkS3
 H2jKR4E18BdakLInqiMTOlfsxvOJbuoW0/fR64rA3ZYcB0d4CtKR3rdIUbnafM/pigNYn4Z/dbf
 EMB2jvZtAwbF+4briDIC3Z7WzZ6sG5hnqURNJFDY5Nb48JljfVsRLC1iUiUgyo4pyNg+DpRdlMx
 bcjcLM67rz7+ojeccqcsFPv8y3aW7Gu5GqDJgk6/GcxSWha3d7IiBh45GDVAQjj7QlQi4vZd4GK
 2Zo0JJhdR4UKWgBThQ2Mm4h17KEXel1YUny0wQCIIgPvAjd/Oxp2uwxT4eGsoHLot3fpKHM3j3X
 Dh++hE4bPbWGFP1lo9HSlMdjswXo4fYtfrs465ghPZ2wDBeQDTspASFzUO8//U36bBnVfyMcW5A
 hqmIeinS4oDjIyC0Oig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NCBTYWx0ZWRfX8mG31V9FKMTd
 Rx74cxTWCMhqP016vGI0QJySPPX5cU7sfoRJlC+NOvdyGUBOnuibyfELkxx745ula2poSr62H0B
 dZdN4tWRwI+lh83D/UTmIaUjUNIfDWY=
X-Authority-Analysis: v=2.4 cv=PN4/P/qC c=1 sm=1 tr=0 ts=6a3f0961 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=Wo6YDfOMAEstGd-0DxeT:22
 a=VwQbUJbxAAAA:8 a=hohcdOfaH-Cr7FVGXBoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: snoLXmUCKRjvv5G7OVIAjgf97rkD0Gvk
X-Proofpoint-ORIG-GUID: snoLXmUCKRjvv5G7OVIAjgf97rkD0Gvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 malwarescore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606260194

T24gVGh1LCBKdW4gMTEsIDIwMjYsIFdlblRhbyBMaWFuZyB3cm90ZToNCj4gSWYgZHdjM19tZXNv
bl9nMTJhX3Jlc3VtZSgpIHN1Y2NlZWRzIGluIGNhbGxpbmcNCj4gcmVzZXRfY29udHJvbF9yZXNl
dCgpLCBhbiBpbnRlcm5hbCB0cmlnZ2VyZWRfY291bnQgcmVmZXJlbmNlIGlzDQo+IGFjcXVpcmVk
LiBJZiBhbnkgbGF0ZXIgc3RlcCBmYWlscyAodXNiX2luaXQsIHBoeV9pbml0LA0KPiBwaHlfcG93
ZXJfb24sIHJlZ3VsYXRvcl9lbmFibGUsIG9yIHVzYl9wb3N0X2luaXQpLCB0aGUgZnVuY3Rpb24N
Cj4gcmV0dXJucyB0aGUgZXJyb3Igd2l0aG91dCByZWFybWluZyB0aGUgcmVzZXQgY29udHJvbC4g
VGhpcyBsZWFrcw0KPiB0aGUgcmVmZXJlbmNlIGFuZCBsZWF2ZXMgdGhlIHJlc2V0IGNvbnRyb2wg
aW4gYSB0cmlnZ2VyZWQgc3RhdGUsDQo+IGNhdXNpbmcgZnV0dXJlIHJlc2V0X2NvbnRyb2xfcmVz
ZXQoKSBjYWxscyB0byBpbmNvcnJlY3RseSByZXR1cm4NCj4gZWFybHkgYXMgaWYgYWxyZWFkeSBy
ZXNldC4NCj4gDQo+IEFkZCBhbiBlcnJvciBwYXRoIHRoYXQgY2FsbHMgcmVzZXRfY29udHJvbF9y
ZWFybSgpIHRvIGJhbGFuY2UNCj4gdGhlIHJlZmVyZW5jZSBiZWZvcmUgcmV0dXJuaW5nIHRoZSBl
cnJvci4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiA1YjBiYTBj
YWFmM2EgKCJ1c2I6IGR3YzM6IG1lc29uLWcxMmE6IHJlZmFjdG9yIHVzYiBpbml0IikNCj4gU2ln
bmVkLW9mZi1ieTogV2VuVGFvIExpYW5nIDx2dWxhYkBpc2Nhcy5hYy5jbj4NCj4gLS0tDQo+ICBk
cml2ZXJzL3VzYi9kd2MzL2R3YzMtbWVzb24tZzEyYS5jIHwgMTQgKysrKysrKysrLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLW1lc29uLWcxMmEuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvZHdjMy1tZXNvbi1nMTJhLmMNCj4gaW5kZXggNTVlMTQ0YmE4Y2ZjLi40ZDYxMWMw
OGU4YTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1tZXNvbi1nMTJhLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLW1lc29uLWcxMmEuYw0KPiBAQCAtOTA3LDM1
ICs5MDcsMzkgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBkd2MzX21lc29uX2cxMmFfcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIA0KPiAgCXJldCA9IHByaXYtPmRydmRhdGEtPnVz
Yl9pbml0KHByaXYpOw0KPiAgCWlmIChyZXQpDQo+IC0JCXJldHVybiByZXQ7DQo+ICsJCWdvdG8g
ZXJyX3JlYXJtOw0KPiAgDQo+ICAJLyogSW5pdCBQSFlzICovDQo+ICAJZm9yIChpID0gMCA7IGkg
PCBQSFlfQ09VTlQgOyArK2kpIHsNCj4gIAkJcmV0ID0gcGh5X2luaXQocHJpdi0+cGh5c1tpXSk7
DQo+ICAJCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiArCQkJZ290byBlcnJfcmVhcm07
DQoNClNob3VsZCB3ZSB1bndpbmQgaGVyZSBhbmQgYmVsb3cgaW5zdGVhZCBvZiBqdXN0IHJlc2V0
X2NvbnRyb2xfcmVhcm0/IEkNCnNlZSB3ZSBkbyB0aGF0IGluIHByb2JlKCkgZXJyb3IgcGF0aC4N
Cg0KQlIsDQpUaGluaA0KDQo+ICAJfQ0KPiAgDQo+ICAJLyogU2V0IFBIWSBQb3dlciAqLw0KPiAg
CWZvciAoaSA9IDAgOyBpIDwgUEhZX0NPVU5UIDsgKytpKSB7DQo+ICAJCXJldCA9IHBoeV9wb3dl
cl9vbihwcml2LT5waHlzW2ldKTsNCj4gIAkJaWYgKHJldCkNCj4gLQkJCXJldHVybiByZXQ7DQo+
ICsJCQlnb3RvIGVycl9yZWFybTsNCj4gIAl9DQo+ICANCj4gIAlpZiAocHJpdi0+dmJ1cyAmJiBw
cml2LT5vdGdfcGh5X21vZGUgPT0gUEhZX01PREVfVVNCX0hPU1QpIHsNCj4gIAkJcmV0ID0gcmVn
dWxhdG9yX2VuYWJsZShwcml2LT52YnVzKTsNCj4gIAkJaWYgKHJldCkNCj4gLQkJCXJldHVybiBy
ZXQ7DQo+ICsJCQlnb3RvIGVycl9yZWFybTsNCj4gIAl9DQo+ICANCj4gIAlpZiAocHJpdi0+ZHJ2
ZGF0YS0+dXNiX3Bvc3RfaW5pdCkgew0KPiAgCQlyZXQgPSBwcml2LT5kcnZkYXRhLT51c2JfcG9z
dF9pbml0KHByaXYpOw0KPiAgCQlpZiAocmV0KQ0KPiAtCQkJcmV0dXJuIHJldDsNCj4gKwkJCWdv
dG8gZXJyX3JlYXJtOw0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KPiArDQo+ICtlcnJfcmVh
cm06DQo+ICsJcmVzZXRfY29udHJvbF9yZWFybShwcml2LT5yZXNldCk7DQo+ICsJcmV0dXJuIHJl
dDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGR3YzNfbWVz
b25fZzEyYV9kZXZfcG1fb3BzID0gew0KPiAtLSANCj4gMi41MC4xIChBcHBsZSBHaXQtMTU1KQ0K
PiA=
