Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C14570FF;
	Fri,  2 Oct 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978884; cv=fail; b=SsroJygoDnXsX9GsLsHkrI47v574tFGXMLMgzbqFMUxz4Bg8pj4hr4Lzs5PKSAOl0E6/NPmjAJHr3ZVoyWhENK/oTHElte8xnAfSbKWF2XqURbt7XKALiK/uRQoa0dessRfdJXZsV8JtpIvg9hg6WHeJIfMudcC9YHetojoF8XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978884; c=relaxed/simple;
	bh=eAnRAOlR8aSarog9v2N6g1awXNeuVzFEUDLmZn+RL2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k1wbKu43XCPvdgEPAQ54P6knIZhjZZqct6zZezD2VCIf6TY2VwKtRBdhGkbB7WIyKj92XY1wSOcanWeae1lefu4FyQybzUpTdIAuSedpBPUrTRF55QBxki35nJt4fd4SdJ80WD+b1vFQve45ZGVi1mzO3yVPm3mJgQ/Q9pIyHng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iTC1FXYf; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kTBiTPRM; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O+X466+Y reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iTC1FXYf";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kTBiTPRM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O+X466+Y"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692L8TEt710317;
	Fri, 2 Oct 2026 15:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=eAnRAOlR8aSarog9v2N6g1awXNeuVzFEUDLmZn+RL2w=; b=
	iTC1FXYfhJiIg/g2IXUWSXBejBbiNkhus8MN22TlRLKDw/WcI9RMAJySlWdi3F6F
	/yUNiz4CxI5/htW1rrWtT8GLYbh50/d+7FFzUIQCs0PgYBkDSUeCzTypsJKpI3Ik
	pE8Lzd0BM0IrErgaxp7WfpWkEM6FTfsz58WmgwT9JslarDlgEou/oE2bdV1fL1XX
	vo5IaTYUW8q5W7tiiP5N/NaXcupY8o6Wr/J2Ehhir1EI2vNJhoSgOVl13lULSRHO
	AYOmVWokrXVsJRvHlOG3WFNCCIMG6jNIVOIdj6nO1U6SVZRX/sIVL8fkPlqhNNNM
	dwilAmgK0PlPlLFXPy8rJA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4h28qyn1mq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790978867; bh=eAnRAOlR8aSarog9v2N6g1awXNeuVzFEUDLmZn+RL2w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kTBiTPRMhWMXLpSQVCpnWdMPBEdH5/8eBUW6I6V4edVj9+Q9G4RO1mEgkciXt4NbR
	 fiAt5GCruYKra7Pkl2SiNDw5fV55xol7XWhx5A83naUKVNBi4RUsbR10ou2ArPaD2G
	 gNILAvrIJGRKbIPOY9VSu4W3DQOrM/QGgfemuQ/dpmnmEPNtb+WJ4eFjRetpLEgqV/
	 MrFbC6Bnjj2OgtJTa30R4rLF9yr4TYcFQ0esCvQLE/JQrKt8VMzo9M/NzG/9m7UNPx
	 WOra22EoGqJ+rVyhc7KOCYzoAGZuAIr8K3bgsOCQEXfGacloREW423hVSpHAzDvqF6
	 HwlHIZNZkgwZQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 25F3E401EF;
	Fri,  2 Oct 2026 22:07:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7F8A7A0089;
	Fri,  2 Oct 2026 22:07:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=O+X466+Y;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00403.outbound.protection.outlook.com [40.93.13.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7F3A0405AE;
	Fri,  2 Oct 2026 22:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqMdxRfwruk3eCEL6bcLPe09R81QeXEkvwc08B8w05MV7/wkD/sQxpKS54GwCJtVtEjIRf5O2DmiNJN1vBuWoJGM3AeiyAEB1A92YPz4YvjdGuUVRjgqCncO9ObSHgZfKgyd6sHHcu3zJhrIR4nc0vYWe/JEGYXQVxUAWQML+0t/dzc82q1PV5viBaqiECb7yMEhfT5GDAywc6bQXQOg5ZOZSXZfmavKrLsYfTycUyw7zMz//P9ieb7w2KvheYCA8+MUSSY2cf5w7+7Zdp7f7ny0fgnjBBXv6lTHaAKPa0uOvemjpvo/ITGh6T2aWs580b65Hb5KztHGiYVlUhuH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAnRAOlR8aSarog9v2N6g1awXNeuVzFEUDLmZn+RL2w=;
 b=yFg1iDu/p9eVMy355pxM7rK4druiwx4pkGYJr0PTE1leZcpPpTv3Opm0/tmH8lO0UFL8IyeLgMAVerdH4perPzVXP5sBMCIyfgVpLfKXmNFpO+EJWyKVBluX8bOC/HrFHp7uEzOTfeOdyBUJThjtIxj3piIQiY+SdVrBeV3jaQqR7s5WghE4Q90L3oZlPpkdEd1Ww01BGRbqtwLbzDUEfUtKDfJcoX6Jwpwf/jx5FS9iLGzO4Q3demH4q182dJJKc7pzcxYLtttQPmYeB+ReJWFWEjQgwdjZ98cGtU2HM4RSRlTZwMNsjy67zmWPhKy1zUK1I6PKEdzie5zDryhIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAnRAOlR8aSarog9v2N6g1awXNeuVzFEUDLmZn+RL2w=;
 b=O+X466+YI1B4lfYKIkRLqoDHcg9TBRqLk9z3PBR+CQLyOBHnGUrD3orkX95VHkibHtna5rnTxZjBx1pqe5tCaBJs3iOacYy1tz9vmJ+PZ311cyCoWo+cUzwQFLqUUOqOUUdETzMaVv+9864488yeyRisBX5dNhLfTGBppuVscE0=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Fri, 2 Oct
 2026 22:07:30 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 22:07:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] usb: dwc3: xilinx: unwind ZynqMP platform init on
 probe failure and remove
Thread-Topic: [PATCH v3 3/3] usb: dwc3: xilinx: unwind ZynqMP platform init on
 probe failure and remove
Thread-Index: AQHdT0E0TZZWr5z5m0yIgKEISpj0wrbq1hcA
Date: Fri, 2 Oct 2026 22:07:27 +0000
Message-ID: <asAoiQuynjB8JJby@vbox>
References: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
 <20260928120015.3152461-4-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260928120015.3152461-4-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CH0PR12MB8530:EE_
x-ms-office365-filtering-correlation-id: 19c82427-5ca3-4aed-24d6-08df20d18bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|5023799004|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 WqjfNgauGRsHMlJnsnqzPXkSMBSJ/HBH9/giQnpuRAaFbbGn4drfnA7RkwTV2ZjRCXxX71BlkvdN9UH5diQGNkH9DHJ6g15ONl40oVD0IXC4QFWVbVE1t0l/LiZR/tZFi216dg1az+TAnD8bEdyWGQcl4RdOaYTrPWyDkE077fj8TLRuuJvJlv5l8JPY6YjWy1meO/Np4tKJT95DukOYSwN9o+gi30Wxf5pyrGwFZw52PWhGxBZoNLqIIEvCpNqlZebHgQOBgbj6KM8eEig8s9uZj8/5gq7A1/TZB17A/ZzPvU8pMBF90oKV5F2PZiz6vhImROjyVdjG/eonYDfqinbQEV8OBLAXYwrv4xMBzt0FQv+Jlp8jq0Uh2yTg+k3GrO6sjMjYv0A2DfG5hY8DYkWtGbgIdyJ32ASD1kFi04cTbqASpsN/NMrut2eBYlL+vhe4zuEwj+UZ7qnY54oaF0TzDUj6EFxbD+Rma/eosjDaRPzpyXvJHDdZ+1kAOGS/n2lfpF+bmpVNwEfKWD20qQvDxccH/lD47ecPiTa20z6P2hipJJixQiR/o9VD6ziXsAND1w3OXriKoFiNgcFvmUjeYI32hRuGMyOsf+W/ZUKrPs0PgMVDdvTL5SHz2wTMnLPH9H5Mj1+jJsScN/Iotr+H2VuSfDJtgwlas17K930X1ke6a4QfoS/9BZiOEM/Iqppqje7e471rA7YF0vGDpU66dlIOa2k+D40B4ZapBLE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDJFdHhMWWFoa2kvSW1JT3MyczBtZ0wvT0E3RFd5VkdORmhEQnN3Qkx5QzBa?=
 =?utf-8?B?K3RxSlVUNEl0NnlEVzFqQUlzOElaVXoyd3JyOUNIL1B3NUtWZ3Zvd1loK2N3?=
 =?utf-8?B?WDVUNWlEVDd5U1g0cGY3V0lEem4zVkMwZFFuRUFENDY2SVA1UnEvUzArMGdh?=
 =?utf-8?B?alg4MG91RFFzT1htaFErM29XR0wwN2VTKzhMTEJiVnB2VUltbWdka01OT1BC?=
 =?utf-8?B?WCs5RlhveUtjS05VS2JiTFZ5bWpUeGRORDU4ZldxVFVGZ0dkZlpuOVRKL3Fs?=
 =?utf-8?B?MTl0elc5TU9kOEJhTUVobU9TRDNXQm8rcnVwN3ZYR1NucFF6SFg2R2hIMnZj?=
 =?utf-8?B?N0ZNNHRZVEE0MkVKMGlpNkpkYkY2Qm94c0ZKM2ZiTWc1QmRQMmdIREQ4S2s2?=
 =?utf-8?B?OENBVzhPeU1maENYKzBuTDlxNUQrY0dvM2hHTDB3ZjhvMjJibjE2b3VhNmxq?=
 =?utf-8?B?dWFOT0M5QjJWQ2xsdVJXanJiUk5yVDMxUWR0aXV5OWtRNXhzZUs0YjAxOEZq?=
 =?utf-8?B?QXpTWEd6UktuSjJIQ2lQaWhLY2l6WGJ2blZXbXR5MXNrR0hJYjlWWjhtSjgr?=
 =?utf-8?B?ZURWV2lPYjBwblZYNXRjTWNXODZxbDU2TUFLY0FRYUNCYzBRU3FrRjQ5UFdI?=
 =?utf-8?B?TllaVllIYmlhV3BSbXBuOU42eWNoZVNuRGFxUW8wbU9JcGc3WE00cEtwUWEy?=
 =?utf-8?B?U0dONjkrWlVrZjJzWVpmVno0UkpZc05oT21SQ0lkT1lPNGdPcGhxQnhlcTh3?=
 =?utf-8?B?dnRjQVZ2ekpPM3pGVDR1TWt4VUplZ2hEZGtEZG9mTWw4My8wazNZcHM5N1cv?=
 =?utf-8?B?RWoxSm80N1pDbStrczFkNE1EMnI2b1dpa09xbHhJNjgxTGJwdWZRODF0enp0?=
 =?utf-8?B?N3BkODI2S3NCUVdZazZzVU9sbzYwenZzKy9TM1VkcXRBV2VFSTRDeHdoVlJu?=
 =?utf-8?B?VDNxb3d6T0FrYzUxYWFpZkc1WXE0bk11RzhTWTJPcENYbzd4aDJpU0xSRm92?=
 =?utf-8?B?cHlBcUE3ZmgyV3JSNkNxd01UWFFHMGFCelN3K3FlTno1Z096WGZGNWJ5ZWw4?=
 =?utf-8?B?OVhscU9iUHA4b3ptN3Q5NjlFc1ZHTHFkWjBrb2lvdUU4cWhYNlgxaGw5bFcr?=
 =?utf-8?B?T2RaU1lhN2o0TndzNlpuZGhYRSt4NC9CWWQzYjRBMXFyMytmQitia2pKbUdD?=
 =?utf-8?B?bGtiUkUvVy8vMzQxQkNXSjNrZTB3NGFHbDM4aDRuK0pWc1JDN1JrK3RUR0tw?=
 =?utf-8?B?eXV2VVdvbjB0YVRBSXB4TlZTNGFub3Z4NVlBaDQxOU9GNlFveE9MWXdxNjd2?=
 =?utf-8?B?SDY2TnR2ZEExNmhjWW5uZHJBUWlrckZGaU9RSXdBd3ExQzZWQzc5OUxzVzJu?=
 =?utf-8?B?ODM0K3Zma2ZnRWRjWjExN2tpWUJqWkxvM2UwVGxtTzlmMVdXYkdxVyt4cURx?=
 =?utf-8?B?MWpMa09EZ0ZvekpxbGdKZGhIdlEwUGJmWEtXUFVucTZOV2xWSU91QTMwY1pW?=
 =?utf-8?B?MTd5R3Z2MGhjWHlIaFJVbEZsdTh6VXBsZXN5RUR5WnNKYm1pUXNrYXN0U1Uy?=
 =?utf-8?B?dFQvYk8vcDJ6cStNcTJVNG5wQnpKZGhPbUd3VC80TnpLUkR0UzVlc2plSWh6?=
 =?utf-8?B?S0UxR2lXU0xxM3A5UGVVVk9sZTNhMC81eGdPWWY3ei85cm1IRE1lVHJCVEND?=
 =?utf-8?B?YTFHc0tjMlBIVjlpaDZ5RlU3UkR1eWFIQk5BMmZGbFN1Y3pYeE9neDZMcWFK?=
 =?utf-8?B?L05WUm1Obk9xK1dLM1Zia0pCK2VOV1JOaFdwNDRTSkZlK2dlZFRSM1JnZmFm?=
 =?utf-8?B?eGhPMy9vRHlnd1A4a3ZZdlp0N08wZ1BqOHZxZ1NiR3ZmZWYwZmhoMndDSzMz?=
 =?utf-8?B?MjBzQ2RSUUVhZWE0aVd4OGZ0SGNwWEprV0tCQW1VUFJ3VFk5UXM0VlFjazBx?=
 =?utf-8?B?RWhFSVZOUmcyaTUxKzgzblV2SWpEZExpb1owT2ZOaW5WcGhWN0wvVkdCQS9E?=
 =?utf-8?B?TlpiZHZ5ZWNidDZ0WGlETlF6UDkyWWZYckxNWnJiL2ZjOVhLS1Z0S1FHOWg3?=
 =?utf-8?B?aVlHUzVzR2VSRzduV28rdy85VXpUMEhEZG5oMmVIa3l4KytoS3FILzdHdTVs?=
 =?utf-8?B?aC9EVU5GOFdZRDdvRDdDTGtSa0hwZDNVK1Fsa0kxRW5hdnNTYXdxdzc4YUtG?=
 =?utf-8?B?ZXRncTM3bkxyazVzY2M1aEhRNjRVc05UaDhPNG9yY0R3TkdISHpjaHpJekcv?=
 =?utf-8?B?QjNLZXlZdStoZitxZnpJYzVuM3IzL1pIQzY3cGxOYkE1QklzNktxYitLZSta?=
 =?utf-8?B?eTRVaDFISFo4bk56ZEtLa0s1R2ZHZWJsT1lXM3g0SVJtM1dSaVVFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A526070F5AEC24398509D7CF5C699BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HhvvTsAetZqzM4hC+3dt6g9AFYc32dDaLggL/huJTKzxPov4T0GdXlU64bhrMBuoXwu7WjJxmbdu5yt/9SHZdv4Z80ad2zh6lCmkTeblMgFZ0P+4IKPywcZbo8sXsA8GS48GT2T05w86SP5TiU0jcp7/GEs37me7JP4ESfPUGKPBmJSRLh3UwoSW91CE8UDn752zgvmtvhP0xF2CJdbOjtsYKVdp1GcGbUShDjeXrbWqOHlOXObrM99GtuqTaicLlA2RnywH2e4L1EB+Wsj4ouEhWJ4mj9NIIvMW+jiU8zv1OnzJ7FGMqn9h+EkfiZg3YrNN8Nxlg1THXKWSdxiAcw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kbhakNjMYNPoiBfUYEKNX2/1FfXrD3UZBCH6fqdOkhraxhqiTXo7/zMDUZgFoVKENXgUyWBOdg/Bs72dDzQOFiBHMiZ5Tptsr64xHoBsV9BROJ+bkMZ6zwXKmYpjIjKxLUgbZ53Cracw/WvMRtVhdNCAS8gsTBwIaDysEfMDGfOXETbHPWAOLEVD67V4n4FILz8bq3dDGI8F7oRPwaX/+Jx7DIVUu530rX4kO6p3Yw95kILst17uqnBtBTIyHijOX1VPBO9iF/V0Y3i0H6ndCW1jGbZ54Ha69PK78WduseH0kqceOKvBJYcuZA/8+M79vBg88ycFEBZ+58B/iPy9jThGR0IyiFqJdyFgDpRoz4lXQmXTI00Cqo48czn7RlnRzdX47ZenfdmRWX3hJM3mteUHD9uT+/cwRr9kwXlMc73nkwgv+OleXDvxa/wS/TcwLNSxSy2s6+XvL8ot+ooEJSVbC5r7o44UOaCh4kckLVsuRFNwEmArO1P9rstBKTEKV1RUMFglTroq2frRRykkq7kuvTOMjJroBRvNf4BJgFrF08jyOLS2wuG1w8741/cmCOQ9kHpkm9+HGmUKEIQEVVb0HhEy9IL6VzxWhWIjWTg1xTGPm1ynmki0IzGZO1X1FFG4VyH5e4XmIQyAsNuL/A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c82427-5ca3-4aed-24d6-08df20d18bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 22:07:27.4081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j684Go0rhHk9UQhQlX8hgHlzpMqqUZy+aTUWqep4u8sh1B+B1jcWGBgI2sV+m5xixZf7Gd1LKAlsQNZHePAeMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4OCBTYWx0ZWRfX+LGTh7cOZfKF
 jsWvkzJkAbhHhMopZ3B2ou5/ZK1KwjqqnXyQ+LdICrWGw3zrc1uyzc/+uppRxomNEaehZdtVrsX
 y88LNsCe0IWBUnXK1cECABouD1KJ+lI=
X-Proofpoint-ORIG-GUID: c_dzWg1nS7y7qZ14bqP2LmPA3KQScZzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4OCBTYWx0ZWRfX0Jd/Jc7w9F12
 pE3HQgYzfMMu/pIatyO7KTbecP792jI0yHfYbBI1WvPDfI0xDKrLy2sU7eIei0Pmt5vW9BPm4VB
 dnVNY9OO0WcH5DuOcXHrGsU1CYxk0cRGIMhhkFirc4Oi6JQes9KpOAWYUKIHBvryyzk0INNr2lS
 jg9ClAAcxNHgAg8+0rkNpsUAqr6ZTy+6K6mJCwSRnItdmGahERN1hzXHrq0xL0YdC0UeAASta5/
 90uD/Wx0jYe6UX5N2UaUKHynZaa/9dvSRs+tpcKXsHJUSRmnHefvhUiOH+AnjVWWt2hNR03ad45
 DRoRIV2JyB8UvxGYekoMzIny33RVygArqZAHcmTJzzcPIDP2sXw2GFSFFtOpMTsEOiDbhQyRToK
 HFP2iIprFG0pulfT0lUlm+kcdemo8ReytLmA32ZXy/hxHPEVeNFBnqZBy6ObCZm5i3XHf7Zdf6i
 Qbwe7rMeyRtLBfKhmUw==
X-Authority-Analysis: v=2.4 cv=Vrm2kO2n c=1 sm=1 tr=0 ts=6ac02b34 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=NQtz5oybNOG0zV3-s8oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: c_dzWg1nS7y7qZ14bqP2LmPA3KQScZzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2610020088

T24gTW9uLCBTZXAgMjgsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IGR3YzNf
eGxueF9pbml0X3p5bnFtcCgpIGxlYXZlcyB0aGUgY29udHJvbGxlciBvdXQgb2YgcmVzZXQgd2l0
aCB0aGUgUEhZDQo+IHBvd2VyZWQgb24sIGJ1dCBub3RoaW5nIHVuZG9lcyB0aGF0IGlmIHByb2Jl
IGZhaWxzIGxhdGVyIG9yIHdoZW4gdGhlDQo+IGRyaXZlciBpcyByZW1vdmVkLiBUaGUgcmVzZXRz
IHN0YXkgZGVhc3NlcnRlZCBhbmQgdGhlIFBIWSBzdGF5cyBvbiB3aXRoDQo+IG5vIGRyaXZlciBi
b3VuZC4NCj4gDQo+IFJlZ2lzdGVyIHRoZSB0ZWFyZG93biB3aXRoIGRldm1fYWRkX2FjdGlvbl9v
cl9yZXNldCgpIG9uY2UgaW5pdCBoYXMNCj4gY29tcGxldGVkLCBzbyBpdCBydW5zIG9uIHByb2Jl
IGZhaWx1cmUgd2l0aG91dCB0aGUgZHJpdmVyIGhhdmluZyB0bw0KPiB0cmFjayBob3cgZmFyIGlu
aXQgcHJvZ3Jlc3NlZC4gVGhlIHRlYXJkb3duIG9ubHkgdW5kb2VzIHRoZSByZXNldCBjeWNsZQ0K
PiBpbml0IHBlcmZvcm1lZCwgc28gaXQgY2FycmllcyB0aGUgc2FtZSB1c2IzLXBoeSBndWFyZDog
d2l0aCBubyBQSFkgdGhlDQo+IHJlc2V0cyB3ZXJlIG5ldmVyIGFzc2VydGVkLCBhbmQgYXNzZXJ0
aW5nIHRoZW0gY291bGQgYnJlYWsgYSBVU0IzDQo+IGNvbmZpZ3VyYXRpb24gdGhhdCBpcyBsaXZl
IGJ1dCBtaXNzaW5nIGZyb20gdGhlIGRldmljZSB0cmVlLg0KPiANCj4gVGhlIHJlc2V0cyBoYXZl
IHRvIGJlIGFzc2VydGVkIHdoaWxlIHRoZSBjbG9ja3MgYXJlIHN0aWxsIHJ1bm5pbmcsIHNvDQo+
IGJvdGggdGhlIHByb2JlIGVycm9yIHBhdGggYW5kIHJlbW92ZSgpIHJ1biB0aGUgdGVhcmRvd24g
ZXhwbGljaXRseQ0KPiBiZWZvcmUgZ2F0aW5nIHRoZSBjbG9ja3MgcmF0aGVyIHRoYW4gbGVhdmlu
ZyBpdCB0byBkZXZyZXMsIHdoaWNoIHdvdWxkDQo+IG90aGVyd2lzZSBydW4gaXQgYWZ0ZXJ3YXJk
cy4gZGV2bV9yZWxlYXNlX2FjdGlvbigpIHVubGlua3MgdGhlIGFjdGlvbg0KPiBiZWZvcmUgY2Fs
bGluZyBpdCwgc28gZGV2cmVzIGNhbm5vdCBydW4gaXQgYSBzZWNvbmQgdGltZS4NCj4gDQo+IFJ1
bm5pbmcgaXQgZnJvbSByZW1vdmUoKSBhbHNvIGNvdmVycyAuc2h1dGRvd24sIHdoaWNoIHNoYXJl
cw0KPiBkd2MzX3hsbnhfcmVtb3ZlKCk6IGRldmljZV9zaHV0ZG93bigpIGRvZXMgbm90IGNhbGwN
Cj4gZGV2cmVzX3JlbGVhc2VfYWxsKCksIHNvIGEgdGVhcmRvd24gbGVmdCB0byBkZXZyZXMgd291
bGQgbmV2ZXIgcnVuDQo+IHRoZXJlLg0KPiANCj4gRml4ZXM6IDg0NzcwZjAyOGZhYiAoInVzYjog
ZHdjMzogQWRkIGRyaXZlciBmb3IgWGlsaW54IHBsYXRmb3JtcyIpDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1Z2dlc3RlZC1ieTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5n
dXRyb25peC5kZT4NCj4gQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy01DQo+IFNpZ25l
ZC1vZmYtYnk6IFJhZGhleSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNv
bT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gUmVnaXN0ZXIgdGhlIHRlYXJkb3duIHdp
dGggZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkgaW5zdGVhZCBvZiBhDQo+ICAgcGx0Zm1fZXhp
dCBwb2ludGVyIGFuZCB0aGUgdXNiX3Jlc2V0c19yZWxlYXNlZCBmbGFnLCBwZXIgUGhpbGlwcC4N
Cj4gLSBHdWFyZCB0aGUgdGVhcmRvd24ncyByZXNldCBhc3NlcnRzIG9uIHVzYjNfcGh5OyB2MiBh
c3NlcnRlZA0KPiAgIHVuY29uZGl0aW9uYWxseSwgcmVzZXR0aW5nIGEgbm8tUEhZIGJvYXJkIHRo
YXQgaW5pdCBuZXZlciBhc3NlcnRlZC4NCj4gLSBSZXBsYWNlIHYyJ3MgZXJyX3BsdGZtX2V4aXQg
bGFiZWwgd2l0aCBkd2MzX3hsbnhfcmVsZWFzZV90ZWFyZG93bigpLA0KPiAgIGNhbGxlZCBmcm9t
IGJvdGggdGhlIHByb2JlIGVycm9yIHBhdGggYW5kIHJlbW92ZSgpIHNvIHRoZSByZXNldHMgYXJl
DQo+ICAgdW53b3VuZCBiZWZvcmUgdGhlIGNsb2NrcyBhcmUgZ2F0ZWQgaW4gZWl0aGVyLg0KPiAt
IEV4cGxhaW4gaW4gcmVtb3ZlKCkgd2h5IHRoZSB0ZWFyZG93biBpcyBub3QgbGVmdCB0byBkZXZy
ZXM6DQo+ICAgZGV2aWNlX3NodXRkb3duKCkgZG9lcyBub3QgY2FsbCBkZXZyZXNfcmVsZWFzZV9h
bGwoKS4NCj4gLSBDbG9ja3MgbGVmdCB1bm1hbmFnZWQ6IGRldm1fcG1fcnVudGltZV9lbmFibGUo
KSdzIGNsZWFudXAgcnVucw0KPiAgIHJ1bnRpbWVfc3VzcGVuZCgpIGJlZm9yZSBhIGNsb2NrIGRl
dnJlcyBub2RlIHdvdWxkIHJlbGVhc2UsIHdoaWNoDQo+ICAgZG91YmxlLWRpc2FibGVzIG9uIFp5
bnFNUC4NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gUmV3b3JrZWQgc28gdGhlIGZpeCBubyBs
b25nZXIgZGVwZW5kcyBvbiB0aGUgcGxhdGZvcm0tZGF0YSBjbGVhbnVwLg0KPiAgIHYxIHJlZ2lz
dGVyZWQgdGhlIHRlYXJkb3duIGFzIHBsYXQtPmV4aXQgaW4gc3RydWN0IGR3YzNfeGxueF9wbGF0
ZGF0YSwNCj4gICB3aGljaCBpcyBpbnRyb2R1Y2VkIGJ5IG9uZSBvZiB0aGUgY2xlYW51cCBwYXRj
aGVzOyB0aGF0IG1hZGUgdGhlIGZpeA0KPiAgIHVuYmFja3BvcnRhYmxlLiAgSXQgbm93IHVzZXMg
YSBwbHRmbV9leGl0IHBvaW50ZXIgYWxvbmdzaWRlIHRoZQ0KPiAgIGV4aXN0aW5nIHBsdGZtX2lu
aXQgaW4gc3RydWN0IGR3YzNfeGxueCwgYXNzaWduZWQgYnkNCj4gICBkd2MzX3hsbnhfaW5pdF96
eW5xbXAoKSBvbmNlIGluaXQgaGFzIHN1Y2NlZWRlZC4gIFRoZSBmb2xsb3ctdXANCj4gICBjbGVh
bnVwIHNlcmllcyBmb2xkcyBib3RoIHBvaW50ZXJzIGludG8gdGhlIHBsYXRmb3JtIGRhdGEgc3Ry
dWN0Lg0KPiAtIE1hZGUgZHdjM194bG54X2V4aXRfenlucW1wKCkgaWRlbXBvdGVudCBieSByZXR1
cm5pbmcgZWFybHkgd2hlbg0KPiAgIHVzYl9yZXNldHNfcmVsZWFzZWQgaXMgY2xlYXIsIHJhdGhl
ciB0aGFuIGd1YXJkaW5nIG9ubHkgdGhlIHJlc2V0DQo+ICAgYXNzZXJ0aW9ucy4gIHBoeV9wb3dl
cl9vZmYoKSBhbmQgcGh5X2V4aXQoKSBkZWNyZW1lbnQgdGhlaXIgY291bnRzDQo+ICAgdW5jb25k
aXRpb25hbGx5LCBzbyBhbiB1bmJhbGFuY2VkIHNlY29uZCBjYWxsIHdvdWxkIHVuZGVyZmxvdyB0
aGVtLg0KPiAtIFJld3JvdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIGRlc2NyaWJlIHRoZSBidWcg
cmF0aGVyIHRoYW4gdGhlDQo+ICAgaW1wbGVtZW50YXRpb24sIHNpbmNlIHRoZSBjYWxsYmFjayBp
dCByZWZlcnJlZCB0byBubyBsb25nZXIgZXhpc3RzIGF0DQo+ICAgdGhpcyBwb2ludCBpbiB0aGUg
c2VyaWVzLg0KPiAtIEFkZGVkIENjOiBzdGFibGUuDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9kd2MzLXhpbGlueC5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMteGlsaW54LmMNCj4gaW5kZXggZDIzMTU1NzNiM2QzLi40NzViYzE5YTE3NDYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gQEAgLTExMiw2ICsxMTIsMzkgQEAgc3Rh
dGljIGludCBkd2MzX3hsbnhfaW5pdF92ZXJzYWwoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRh
KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX3hsbnhfenlu
cW1wX3RlYXJkb3duKHZvaWQgKmRhdGEpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzNfeGxueCAqcHJp
dl9kYXRhID0gZGF0YTsNCj4gKw0KPiArCXBoeV9wb3dlcl9vZmYocHJpdl9kYXRhLT51c2IzX3Bo
eSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFVuZG8gb25seSB0aGUgcmVzZXQgY3ljbGUgaW5pdCBw
ZXJmb3JtZWQuICBBcyBvbiB0aGUgaW5pdCBlcnJvcg0KPiArCSAqIHBhdGgsIHRoZSB1bmNvbmRp
dGlvbmFsIGRlYXNzZXJ0cyBhcmUgbm90IHBhaXJlZCB3aXRoIGFuIGFzc2VydA0KPiArCSAqIGhl
cmU6IHdpdGggbm8gdXNiMy1waHksIHJlc2V0dGluZyB0aGUgY29yZSBjb3VsZCBicmVhayBhIFVT
QjMNCj4gKwkgKiBjb25maWd1cmF0aW9uIHRoYXQgaXMgbGl2ZSBidXQgbWlzc2luZyBmcm9tIHRo
ZSBkZXZpY2UgdHJlZS4NCj4gKwkgKi8NCj4gKwlpZiAocHJpdl9kYXRhLT51c2IzX3BoeSkgew0K
PiArCQlyZXNldF9jb250cm9sX2Fzc2VydChwcml2X2RhdGEtPnVzYl9oaWJyc3QpOw0KPiArCQly
ZXNldF9jb250cm9sX2Fzc2VydChwcml2X2RhdGEtPnVzYl9jcnN0KTsNCj4gKwkJcmVzZXRfY29u
dHJvbF9hc3NlcnQocHJpdl9kYXRhLT51c2JfYXBicnN0KTsNCj4gKwl9DQo+ICsNCj4gKwlwaHlf
ZXhpdChwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIFJ1biB0
aGUgcGxhdGZvcm0gdGVhcmRvd24gZXhwbGljaXRseSwgc28gdGhlIHJlc2V0cyBhcmUgYXNzZXJ0
ZWQgd2hpbGUgdGhlDQo+ICsgKiBjbG9ja3MgYXJlIHN0aWxsIHJ1bm5pbmcuICBkZXZtX3JlbGVh
c2VfYWN0aW9uKCkgdW5saW5rcyB0aGUgYWN0aW9uIGJlZm9yZQ0KPiArICogY2FsbGluZyBpdCwg
c28gZGV2cmVzIHdpbGwgbm90IHJ1biBpdCBhIHNlY29uZCB0aW1lLg0KPiArICovDQo+ICtzdGF0
aWMgdm9pZCBkd2MzX3hsbnhfcmVsZWFzZV90ZWFyZG93bihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
ICsJCQkJICAgICAgIHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSkNCj4gK3sNCj4gKwlpZiAo
ZGV2bV9pc19hY3Rpb25fYWRkZWQoZGV2LCBkd2MzX3hsbnhfenlucW1wX3RlYXJkb3duLCBwcml2
X2RhdGEpKQ0KPiArCQlkZXZtX3JlbGVhc2VfYWN0aW9uKGRldiwgZHdjM194bG54X3p5bnFtcF90
ZWFyZG93biwgcHJpdl9kYXRhKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX3hsbnhf
aW5pdF96eW5xbXAoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRhKQ0KPiAgew0KPiAgCXN0cnVj
dCBkZXZpY2UJCSpkZXYgPSBwcml2X2RhdGEtPmRldjsNCj4gQEAgLTIyOCw3ICsyNjEsOCBAQCBz
dGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2Rh
dGEpDQo+ICANCj4gIAlkd2MzX3hsbnhfc2V0X2NvaGVyZW5jeShwcml2X2RhdGEsIFhMTlhfVVNC
X1RSQUZGSUNfUk9VVEVfQ09ORklHKTsNCj4gIA0KPiAtCXJldHVybiAwOw0KPiArCXJldHVybiBk
ZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBkd2MzX3hsbnhfenlucW1wX3RlYXJkb3duLA0K
PiArCQkJCQlwcml2X2RhdGEpOw0KPiAgDQo+ICBlcnJfcGh5X3Bvd2VyX29mZjoNCj4gIAlwaHlf
cG93ZXJfb2ZmKHByaXZfZGF0YS0+dXNiM19waHkpOw0KPiBAQCAtMzU1LDYgKzM4OSw3IEBAIHN0
YXRpYyBpbnQgZHdjM194bG54X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGRldik7DQo+ICANCj4gIGVycl9jbGtfcHV0Og0K
PiArCWR3YzNfeGxueF9yZWxlYXNlX3RlYXJkb3duKGRldiwgcHJpdl9kYXRhKTsNCj4gIAljbGtf
YnVsa19kaXNhYmxlX3VucHJlcGFyZShwcml2X2RhdGEtPm51bV9jbG9ja3MsIHByaXZfZGF0YS0+
Y2xrcyk7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiBAQCAtMzY3LDYgKzQwMiwxMyBAQCBzdGF0
aWMgdm9pZCBkd2MzX3hsbnhfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICANCj4gIAlvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlKGRldik7DQo+ICANCj4gKwkvKg0KPiArCSAq
IFRoaXMgaXMgYWxzbyB3aGF0IG1ha2VzIC5zaHV0ZG93biBiZWhhdmUgdGhlIHNhbWUgYXMgLnJl
bW92ZToNCj4gKwkgKiBkZXZpY2Vfc2h1dGRvd24oKSBkb2VzIG5vdCBjYWxsIGRldnJlc19yZWxl
YXNlX2FsbCgpLCBzbyBhIHRlYXJkb3duDQo+ICsJICogbGVmdCB0byBkZXZyZXMgd291bGQgbmV2
ZXIgcnVuIG9uIHRoZSBzaHV0ZG93biBwYXRoLg0KPiArCSAqLw0KPiArCWR3YzNfeGxueF9yZWxl
YXNlX3RlYXJkb3duKGRldiwgcHJpdl9kYXRhKTsNCj4gKw0KPiAgCWNsa19idWxrX2Rpc2FibGVf
dW5wcmVwYXJlKHByaXZfZGF0YS0+bnVtX2Nsb2NrcywgcHJpdl9kYXRhLT5jbGtzKTsNCj4gIAlw
cml2X2RhdGEtPm51bV9jbG9ja3MgPSAwOw0KPiAgDQo+IC0tIA0KPiAyLjQ0LjQNCj4gDQoNCkFs
bCB0aGUgaW5saW5lIGNvbW1lbnRzIGFyZSBxdWl0ZSB2ZXJib3NlLiBVbmxlc3MgbmVjZXNzYXJ5
LCBJJ2QgcHJlZmVyDQprZWVwaW5nIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbnMgaW4gdGhlIGNv
bW1pdCBtZXNzYWdlLiBCdXQgaXQncyBmaW5lLg0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpCUiwNClRoaW5o
