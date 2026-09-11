Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6830AAD8;
	Fri, 11 Sep 2026 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168358; cv=fail; b=EpyRhF2p5aClGgXKR/IvODlQ6eeKmXWsPok2PEcDt9TfK54fri2MXcF1fYEwkHjU83bzK4/PsvMeaBSwgXRhYOabmKNiUX5oEKCH460chnN4JiM9KbEl9MpB+ZCH2cFQoV/beOhpgJp5T67VzEgPilWiuAj+OdD4OOEppSdNWto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168358; c=relaxed/simple;
	bh=KJFijX4h6Ea3fk8RUI2DGWjP8XnnV8KGtUAonccV6xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJeggwv3O/Pdx5A7hIFo+Me5rHoqFBQGjUlPzsr7BON+IVTLF8RsfTLuUxQ7oO5Fu+J9BuDa8+GUCn/Xo9Qzhp8P20SJ/qwN8XNL+NrGOIhzU55DmOXo9hFKjSh7CJdV2iOBNc0Zc5OtKQWr0Oht9qpkDnc7E3fBg3Jc4eJmwtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=H3MomXHx; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KTFjGb7O; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eWGmvySf reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H3MomXHx";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KTFjGb7O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eWGmvySf"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BMiVLV2329281;
	Fri, 11 Sep 2026 16:12:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=KJFijX4h6Ea3fk8RUI2DGWjP8XnnV8KGtUAonccV6xk=; b=
	H3MomXHxPzsmHXYoYPPTAFfPTRI2Nz4WyQ/AxAmYnE57EawuXxLVzT+Pb4tF/wsS
	T+tWwfoRa9Qu7fFO9mM49g9Ea7Eve/FFJSIBxNBH7HnTxSWf6dki686ZpFXlC+9C
	HliCjLs4TaRwUDrcysOMWtaeZSaFeYa70FBgZcqPgiBkcVeeV065nZ5Wr/pdmGPW
	uwQx3OpPvdV0KLlK+UMn07SQW6CCqGwh/Nll2BGOKSb82ITKuMoHVpi463a1oyJj
	/724f7ZEw9RXlSmZmKAXnYE1e9/jQSl4t6RtZFTEQj2ULpDMGovdlFTiL7RhLryw
	HsND0sev9JHRUrGccJltmg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4gmrj4gya9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1789168346; bh=KJFijX4h6Ea3fk8RUI2DGWjP8XnnV8KGtUAonccV6xk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=KTFjGb7OOjjvD8xU3j9VesAAZgM03hm73Sibn19rsz5zbffRoUI2jjwQor2wRTFXK
	 Kv4XZGIhQ65rQrOwmsNvwqyajmEzwLXMtZ1p0wkGPdcz5ggAVoSjXyF93Zn25oRstM
	 TXQGNJfQqgvDrC+CY90n9HOjvQkzfyonJKOfkuL80TtMoTaif40ishSJXgmDAgrwsv
	 wKFe2B+7XxZzvyw3NV/0A7rpH20l7h9n0f42VvGnK/VNRtjs8ffdhOvanRSDdtVIZr
	 oO9SU0TU67AYVcORzVE190Zt7OO2Mf30YOP7jlzyRssNkza8szZwsLkkY0Sfl/1/Jf
	 JBfKNtWG8gc1A==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD57F401F6;
	Fri, 11 Sep 2026 23:12:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A263DA0070;
	Fri, 11 Sep 2026 23:12:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eWGmvySf;
	dkim-atps=neutral
Received: from BYAPR08CU003.outbound.protection.outlook.com (mail-byapr08cu00307.outbound.protection.outlook.com [40.93.1.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2DF0A40D2E;
	Fri, 11 Sep 2026 23:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMlL/TxeAlEvVOYOKA/+pLscTuNlU8DP00Ex+Malf8FL4IsszNsS03h7hGxa5oy2vPPvFPxlxdmxK2FPf/oaTHEyvA9q4f8aaE6Dz6GCIIUEDosA7kesD3yTxsiIxJkp+4Q/TDi6I1McxH2Pn3em1+KPBgn2yOSENp7QZS+X/grtNYDM4Z/hpd+yEXp8ubj8lvfx5N9Ec3optFpyUYTO3DpoDEjiI/yAdlpDjKSEyrYouon/vRtNLpd6mniyEJOS7KERny/OqOM/tzdMcZeKmv0Z/CvhDm6PR+g81wGcWqe+fxzK12YXT9j5E2dsznZ6atsCv7pwij5uQUMVtZK9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJFijX4h6Ea3fk8RUI2DGWjP8XnnV8KGtUAonccV6xk=;
 b=Vzu1Xt55ECP3VK6MiZMPGLW+uw2O22ME59cneztvo5fIUgFFlHHGRCvrdS5yMtUQz+3u43XM7nRjY9aM0qrkuDVcRytevoID/smQx7hap66STHcaiAx69bk4JB7Sg97YofW6INaU6v1WiFXHLRGnb9oEuwTPXeh+DUK9GaKptJKVygDDdirBDBYVSemOLeafNABCvnHU+kjMUXmviU4sLtAnSQF8Uj/fqKEh1BkUGwVIckWOVzex+KqaKEQ31hOUA0vj9KbkN6smI/jJl3wiFSifzEnz8k0K7vODoK3MBjSf+X79BGdXZTe61KvASE8/+nZJ1PPBOF7IHkHOMB4Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJFijX4h6Ea3fk8RUI2DGWjP8XnnV8KGtUAonccV6xk=;
 b=eWGmvySfJFSuTUq93ZrawfPpvRtb0LoUSpGEoMsqXko32N4y3z3/EjZpo3akhSZUOMTZiQFQHi8g8qwMwX9cjcZ43G0LHSxmPpXEWmUXZSCtQ+VwStta8XXOmPwb1tAGVaEjNP+o4z18thz1sOp/ANnZlUOc0A1ah246LC5Tnus=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 23:12:20 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 23:12:20 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: David Collin <davidcollin899@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3: host: fix dangling xhci pointer on init
 failure
Thread-Topic: [PATCH v2 1/2] usb: dwc3: host: fix dangling xhci pointer on
 init failure
Thread-Index: AQHdPVXtjJ8Y6Uplh0mvK+ZHIXFc0bbKC08A
Date: Fri, 11 Sep 2026 23:12:20 +0000
Message-ID: <aqSKwfEjI34NyVkA@vbox>
References: <aptV-QHKGbMqw1uP@vbox>
 <20260905164448.209348-1-davidcollin899@gmail.com>
In-Reply-To: <20260905164448.209348-1-davidcollin899@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CY8PR12MB8196:EE_
x-ms-office365-filtering-correlation-id: 80896519-c6eb-4410-a1fc-08df105a213d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|10067099003|22082099003|4143699003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info:
 ZHh9QVyBb5XsKtwO+T2e7kx6jhc3SNnDKIKj4spZbdTG6i8d9Hw7bhqtjCA4fNMhZtHpK+2togX5LZmOvRHWaZIly7P+Q2GuVA0kVMIZNaHwdTFRfASNteJXDWsRwKmqXGUOTZz00fjmTJ8zO91YhemLB78RX0yVV/iiY4dq3Uu1u7UFHd6r+ZLuygn5denIulIj+95bqQFlVExa4MIadeDFC1jfMBbo7ll5HBg7MbRKT3nSky49/rF6WvOHC7MWV49xdA6GhWWtdqllLWRhe4Gw3t7ZdRRMuVmN+RCC9WmMJuEaMjZ7EIjWP8i3GuujLoO+VxAmTPfUTsljtrP7iD1i98Fh2QmoCowgjVTqkXpUNYHRSCXYYGF02ERZzSEJkMNi223Rm65XyWKB3qeE+pFSqFjh9LdqScCPTHajLme7Bfzh8ye8miCu/t8Umu19igSKsHyDpdW7DzIVClYE4+C53LClnYjN7WQGZMTc2Hf/ESBTdQ3tW9AVDaAssv4NeRIIpdrJYIp/wadkcrjCv3nwnXKPDL/1lhn+EU7bWptc2ChrdgyBVB9KrPbYLk2f8FSuboyMWuQRk3xMMsraTO+bU2CYHdcR+cIuwwxQbNll+scQ1NnyEUs3V6470r4yTNr8A8//OvRQodN9naCXhd6qm1T5FXDXk35ZonS3zaKgQnsPZJlMVBRYirPva7ZbBOBQ58dVmj2Puy+R4cdmuEcemoyfDWwlrhNyD6bf71M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGN0N044YWVKRDBMVlpvWXdlcm0vaUxHZkc5U1N5U1BnTUpsZ2ZvNlY2Mk9D?=
 =?utf-8?B?VzUvQnZqOUxNWXhCSHEyNnZRNWZHY2xmNDRTL1J1RHVyeVJoeHNsS0RWNEdJ?=
 =?utf-8?B?M09Ib2xCSWFjU2pUZmFndXBLVWg2NXZ6c3U1ZWRjM3ZManFLV3RZOTU2OHQw?=
 =?utf-8?B?UUVOczBzSUhEdDJreUl3RHBRaE5ya3hSNTVsQklJRmVMSUxENUZHZWZZS3o4?=
 =?utf-8?B?aVkra3JLb1Ayb3g5MUNseVRvMTlMTHdZdTdrRy83Z2VERGNSZXNGRVVUQ3Mw?=
 =?utf-8?B?OWFrNFZYUkxNcG93WlR4alJ6cmw3c0wxWHJjMVkyMTBxbEx6MnkxWm5Eb1pJ?=
 =?utf-8?B?aCtYOG5JVDQyOW0zSjRwS1RNblozL0RwUmQwaDVybzZLeDl6cXIwYzFkaG1v?=
 =?utf-8?B?ZjFQNjhZOVRsWS9FVCswT1JEc0txcm9PSGhFNGxITEFBZjdLTVN1MnAwTjQ2?=
 =?utf-8?B?R0Z6K0l6NzZWRXdwTjRpajZSMzFVd09kOVdnaGFRckI2WUNpZFV6cFhpajQw?=
 =?utf-8?B?WE01QWo4Y2p1OXV0Z09JdXo0eEd5OW9DSG9IaitFNTN0U3QvdzlWYzhsZXFy?=
 =?utf-8?B?TGp6Y3JBMlZYOEFMZUpMRWxrbjd0M3lZSURFSU92ZkJUR25RK3kxQjdLYnZi?=
 =?utf-8?B?bkVYVVFVbndkVVlIcVg2SlNKdVcvb2RDWlV5YmEzekdLOFYrTjFaOU9iRTFZ?=
 =?utf-8?B?Ukh6bHdDazNJZUxCWjllZlVlMmkzMUdoYmttek1LalFEdmRKRUt6SnRTTGtM?=
 =?utf-8?B?NXlDQ0RTNXczT08yZkJjaitHNFNZOFUyc1ZYTFdnL3owcTM0cGpoTGlDWkJr?=
 =?utf-8?B?NjlUTGZHeDBvbEEwOXNYeDZnQlBwVVgyN1lNaUt6UmRjOUZubTMwTm5vT1B4?=
 =?utf-8?B?R1R1LzJEK1ZhSVhlQ0Y3YU5TWlF2azBnZmdUeWtzOGFjeGM3ZW1xSk1wTFlo?=
 =?utf-8?B?YUwxYUJYY1NqYUg4OHZKSVdpd2dJcnowTmIvZ3VoTnJVRzY5Z1lzZk05TUJw?=
 =?utf-8?B?anZFMHdpV05sN0pPM1V6T1BydnUyYXNCb1Z0eXgxaVpoMUd6dFdTYWRmMXFP?=
 =?utf-8?B?dkZiNjM0K0NIZklDSUNSK1Q5SVFkMWtHRXdvY3FWbEpSeFBPaTZ4d1puK05C?=
 =?utf-8?B?OXNrcGJMU01JeEdNVmpYYUEwblNaWWMxSmE2VXlHaEdORk9KVTg1VEV0bVB3?=
 =?utf-8?B?NEtocE1rdkdCYWZsa3V3TmNEaU0zUnZ1MEswczRpbUdHNFNodjhXZEhrWjJL?=
 =?utf-8?B?RXVuU2VpZG1zTXFmVnhBWmYwRDN4YVFGK3pKVmdJS0dkV0cwQ1F0S2tLWnNS?=
 =?utf-8?B?WkUvMFFTTk5janI2NUQ0cnVFT0Erck91RUNXWCt0eXM2N1hka1dYZ1k3K0RJ?=
 =?utf-8?B?REpaa3UxcHJHcUlSY2dmbFR2bk1tbnZQcWJWWE5Na1h1SC9SWnJPcmlrQXhy?=
 =?utf-8?B?RHVPVGRPcXdLK0I5RUFWWDNkK0JaL2dFWGJaaGV2ZUgzTzJtTURES0dWK0J3?=
 =?utf-8?B?aWNPSTZ4S0dGVis3KzJmcmhqY1JDZ0w4RUMwTmN4MDVjVSt4TnlhckI0VGhl?=
 =?utf-8?B?SzgwR1BicURKSTFueTRQK0hLdmVwZlc1eUJaQUFjM0xYRGJvd2lWTlpmelZI?=
 =?utf-8?B?bmJ2bkxoSzM5QWlKQnd3WTlCVUJsR2N0Z0UwTHp3OXg5WC9XUE9mcldRSG83?=
 =?utf-8?B?ZEFNanRacEhNT2FlTGpvYTUrUVgxaXFhUlY2dG1vRE5BUGhkUW1iZkJFWGd1?=
 =?utf-8?B?YXlxemJzWVVoamtEa0ZiTy9rVno0YkJxR3pCVVJSZkMrWGh4eFo0V1p0VFFo?=
 =?utf-8?B?MUJDMkY3a3B4WFYzeGRLblJiWG5zOVhyR04xUHh5UC9helI4cHdseS9LRndJ?=
 =?utf-8?B?bVU1WlFDQ09oUjc2RUpjM0RHUk9VaEtkZXZ6U0lxRXJGNUovaHoyMXRFZis5?=
 =?utf-8?B?eWFtRnhqZmZuQ2VkbS9lUUdHODlrSUxHUmdpM0tmL0lYelVScDNrMFNjMk1W?=
 =?utf-8?B?ZzFIcTJSejVrYnNNV3BNNEJtQ3BqZTM4T3VrWmZmSlBVc2N5MkVSY1RMakxF?=
 =?utf-8?B?NE9jWkUxeFdZTkhXd1ROMFAxRzQ1NjNKU1RNdXVyQTBBWlFXc0prS1oyWU9o?=
 =?utf-8?B?VHkrQ2Z4U0JRYTI5bDdodllyaS92S0dyY2E1UHViMG9TOVhlcGZFM1o5ZFlJ?=
 =?utf-8?B?aVJpVEZ4cUVMcnh1N2s0c204NlUyWFRqeGtXeEtud3RIViszZ3BiK3lrUHF1?=
 =?utf-8?B?YTBtaGhMZENFN0ZpamFXZ1RMSk9CMmN5VUl2RGVuSGFrSExicm5zUGFhbENa?=
 =?utf-8?B?V0kyZG1naGxTTjdEOUxFU3dNdWpQWkVVdGxOWFl4Ly8wUDEwS0ovQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7406FAEFCBC79747A193B78A00580291@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HxrJ0GN74DgYfhsAX0lbWJb5sxf3+Kx0qUQ93IqMO26e1NiPB1G6tkmUJ5mz5T4khJRHKA7PY7APSk1aerXgB8SxRdssyeM+EIVOytRK+aZoQLhL7OrJO90RZfA+7ej8uBgbg6srHRvWKw7HW5pSr1YQy3NVVVuTz0Qqy1h/J4omuOlLuKTP20Fcc/5cGoMC7/dd11U+CP4cDh3RZt7ibPmTEdAck8tGxzPq3EPQcB+DAobnE5LQiabvbnSDLQr9pOpHck3132r7YRhIlia+fc+5JB/zSLINT3lTuD9PyIZ6dVtDdkh1zn4q0Ai15O2GV7vzgUYFZQKZKVituZpGSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aPG/zbKxxrqfN19PeuhvG8s2aTWMtKhLuf+v7YEt6zYTNdzGLlyJYRgiKun4OqhG64kt8gS+LVQBaxpgcZLumb9rKiwCzGR8g27NkWiO2CuT3A3J3AsX9odMwEsh5C3gG5IbxHcAAJK0p5SQUvwu7U/YBG7MoD6qK+Ls7JmFDlj9HeL5Dmm9FOgzDSsVjV/ISUcjUrUjq02UfUrOhjQIVsHt/fqDL/5bOS8Pn9IVD0Y/R4jwuKYjW0EuICo1GrESvBWrzbvcDOgkD49mjF5PojIhwOuTik55R2LNLA+sHHZ3XHKq9kjpdMGmJUAY+LRlbIhdy1EWNCQPh5VE0hN3nHUQEcjZncn/bDKF5mX1TMxL3YDSjM0yZRkCs37YMKJG6IJm1dfxiKLVo46dvYpqowPb0UXcSp1h51vRRnZBsxBWiskrv2uc4uXbJKg8N8LK6W7L1YQytf9z3Jg5G7asse05ouRvq73jaSb/nxJpbIbdtWKErqQXzgTX+Yk6wuo4WPYO4PXlsoKJyxbp1fhqdhy9N5kIQULWMWv9K2uRNpN2vc+B2mb/tsgQlmelUchWEM5e0RrnYnan342/DqIwAG9cPLKWl/TKiAA6ZOIGNDjWUJbBN1K0/fxUvfYEHE0lHus1P3lOkTH4yzZpgJrzQA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80896519-c6eb-4410-a1fc-08df105a213d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 23:12:20.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ijBThGMFHjDJ5l491Rpapgv813v2HzSMT2maF6AZhpZM2N1IkDPYa0Lytn307ZC4W54DgvHVzzQcnZlJf4frg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
X-Proofpoint-GUID: KUo_Kk6QvGsA-iirN4y1vlr_UVD5X1P2
X-Proofpoint-ORIG-GUID: KUo_Kk6QvGsA-iirN4y1vlr_UVD5X1P2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDMyOSBTYWx0ZWRfXxuEpzxn4pF8s
 TaVm4xKJzlFnQ10hRD7HbusYV4ms3t9nIueWQb3mknSFpX5Zj/pYEGO2v684dv76jSGJFWZjFIx
 +2jXhfiXZya05K8n338iugoe9vJOpoYpfy8q8alaB5RM8DI8XCwsnCGKoO4bn+1nmckjiXtq3ju
 hyYAV7YF7q3jWClnD70rmboMC2C1ARxp0fLXKuxSFWKivvpJBpOMslzY9+MPwp00HZ/F4k+Hu1j
 qez2RaN4p4giedBgjA4kWV6R4i4trD9bvd0IMilzMD+wHIKcvSZXlke2+xqzj88hxic1fM05hEC
 cEmU7HJaqGq07f5FIsO9p807b0xnJxi8DfYv6FiSRarJIxEKIDpo0ze7CFOnEYXJGXhZR+EnZhg
 3t+mXDE3940Wja5yLgv2e70sO6r9uJnEY3qpQn3py6HQtFERYuog8puN2WqGIDm8B6GX3O2AKm3
 GtswrY9bDuv47Ymchjg==
X-Authority-Analysis: v=2.4 cv=E+lYNqdl c=1 sm=1 tr=0 ts=6aa48adb cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8 a=XOv3RVO5eh4kZm808AkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDMyOSBTYWx0ZWRfX9GDrq4thCL7m
 XWNSKfi2YEeRV8A3GxDV9KlLzaGaDpR27zOLBi0h3w2LUBzEMYnzXCUZ0QuL75vLt2EBb/5PqrK
 hnoARyCoHIXAJlJwKF+V0wvDwTDaFew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609110329

T24gU2F0LCBTZXAgMDUsIDIwMjYsIERhdmlkIENvbGxpbiB3cm90ZToNCj4gZHdjM19ob3N0X2lu
aXQoKSdzIGVycm9yIHBhdGggZnJlZXMgeGhjaSB2aWEgcGxhdGZvcm1fZGV2aWNlX3B1dCgpDQo+
IGJ1dCBuZXZlciBjbGVhcnMgZHdjLT54aGNpLCBsZWF2aW5nIGEgZGFuZ2xpbmcgcG9pbnRlciB0
aGF0DQo+IGR3YzNfaG9zdF9leGl0KCkgZGVyZWZlcmVuY2VzIHVuY29uZGl0aW9uYWxseSBvbiBy
ZW1vdmFsL3NodXRkb3duLg0KPiBDbGVhciBkd2MtPnhoY2kgb24gdGhlIGVycm9yIHBhdGggYW5k
IHJldHVybiBlYXJseSBmcm9tDQo+IGR3YzNfaG9zdF9leGl0KCkgaWYgTlVMTC4NCj4gDQo+IEZp
eGVzOiBkMDdlODgxOWEwM2QgKCJ1c2I6IGR3YzM6IGFkZCB4SENJIEhvc3Qgc3VwcG9ydCIpDQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIENvbGxp
biA8ZGF2aWRjb2xsaW44OTlAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMv
aG9zdC5jIHwgNCArKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2hvc3QuYw0KPiBpbmRleCBjNTY3NDE2MWIyYjAuLjc0MTE3Y2JiMmY0MiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0
LmMNCj4gQEAgLTIxOSwxMiArMjE5LDE2IEBAIGludCBkd2MzX2hvc3RfaW5pdChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgCXJldHVybiAwOw0KPiAgZXJyOg0KPiAgCXBsYXRmb3JtX2RldmljZV9wdXQo
eGhjaSk7DQo+ICsJZHdjLT54aGNpID0gTlVMTDsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAg
RVhQT1JUX1NZTUJPTF9HUEwoZHdjM19ob3N0X2luaXQpOw0KPiAgDQo+ICB2b2lkIGR3YzNfaG9z
dF9leGl0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICsJaWYgKCFkd2MtPnhoY2kpDQo+ICsJ
CXJldHVybjsNCj4gKw0KPiAgCWlmIChkd2MtPnN5c193YWtldXApDQo+ICAJCWRldmljZV9pbml0
X3dha2V1cCgmZHdjLT54aGNpLT5kZXYsIGZhbHNlKTsNCj4gIA0KPiAtLSANCj4gMi41NS4wDQo+
IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0K
DQpUaGFua3MsDQpUaGluaA==
