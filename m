Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB033B19A3;
	Fri,  4 Sep 2026 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559765; cv=fail; b=IhVXaSWfQ2OG75Phg4XEE7iVq3e19YCCaXcVb6HuqD6jkMyA+E0jsAu+B3FtDVoUSLu93B///yY7kX9ImtHGBQCO4Lnzrs3AUl2psSk/LrKfOfd2s2uiGgoyrbE9A/P/aW3AO39lB25hyyb790hOpzw5922KWkvbHSQTopQHD1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559765; c=relaxed/simple;
	bh=XUSGrz5a4x0eA+3rxXUI6Z/3pmlN9A4Q708DtEwy/Qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulNNzPO+OlTV4fxcbuilF/XLfq9OpKPJP6mAbAc4P2ljlCgN70yEUKGOMSER+qnr06F7SX7sfaE6YhO4CEEX2xrx8sGku5PgqTA39xH4GQw+VMQUPe74HNkUqjzQx5J5rqxJM/Fh33aiPAtwOPtBsc4HyElOcMdxVlEbPku3xyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=jl/eMBra; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="jl/eMBra"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684M2hPL3058027;
	Fri, 4 Sep 2026 22:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=XU
	SGrz5a4x0eA+3rxXUI6Z/3pmlN9A4Q708DtEwy/Qo=; b=jl/eMBraJHzQG2hFYc
	eS6l5NjFSWUec5GZxorw7nrmA1uspV4ewVfJ5xCvIHhLGqVGM2SVhlsf7SBlrCoT
	xPI3UTYK9sapzz8GXy2kLtaUt1DsiWeppjLtS5XsqqaoSytWjrkr++WDXff9ILE5
	rBhHXaX2nAfnHKirKDPUh4dxVfEdTpCdgseTXk9ZZu0OluE6j0yEv7hJ+YUgBl4B
	fJ+45qWovy06dF1Du2hd1a+I4JHdDnLmQOWHTHyzEL3dvAxzxVnGLyBR5GvR7YE4
	0SrX/uXe0AzpaTMUN/SwLl1BjZX1iYezrIsCTl5G9FO9Kq05W2ASCkuydiFRWmQS
	jMow==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gg078d4bu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:09:03 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B6309D2E4;
	Fri,  4 Sep 2026 22:09:02 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 10:09:00 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 10:09:00 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 4 Sep 2026 10:08:59 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 10:08:59 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AroJl6epJHOCWMoJ14t7mhcSMePUNVO1wdXsoHvgyrUspjTzIA3dDqBX3XOTXiK7ga4ZMwN5Qq9W6qPlv77Aj5RHFosQ6gmU5nRxF4iTSuQZO/l8ObBglafLjW6Dv2DJY69wJJK7B6kwOLkLrMGG01aul8utv7gzuR8cT5bo8TO5jpBfOtO5DJ150d0oEdVDLBd09fFGAf6/bJXs04hHZlPTrIyPAjLYLmt+XzXDd1nCny+C2JgpX1RWO71OSTRvLFuW/d+JmYShLfHcb3XIdHann/AdVu4Mz7dKq7jTxim8UgQ+iPeEtkCNWs249UNLKxPNXziEj8EnCssbGD516w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUSGrz5a4x0eA+3rxXUI6Z/3pmlN9A4Q708DtEwy/Qo=;
 b=St8Qu8yrLfqv7Nd1F52MJS6X/h0FZrJjvEHbQ8vyDnrq2JFb6RYfFccWOlqKypPzHfj+GoNTVEwVycryLVLe42Dt5DVPJm4HxbxBPBuytKbL0zNQdgNw6Cz6Ya3TcbZY6YQE3rnlqOgWiduXQxEcTUyk9rH+aSRjCHpQFwcLcZI4Y5D1bi0wyhTRoHbygwg0qW8vrZes2QGJkgFuExGb7tOy50WcxgLSNPiiGi1+Ogoi7tOqh5XIhJ7MJuW+59iEZAtfcCEKMDwk7mmDPre3YieLCGr6mzYdib1wdG2KjO21rN6r2GLUkPsG074MBIxeRhMXW5D2OVXH/n9EJXvHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DM4PR84MB2118.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 22:08:58 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 22:08:57 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page decoding
Thread-Topic: [PATCH 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Thread-Index: AQHdPLn7b/djOMSNskOiiqFfbinNkg==
Date: Fri, 4 Sep 2026 22:08:56 +0000
Message-ID: <20260904220843.495082-2-sanman.pradhan@hpe.com>
References: <20260904220843.495082-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260904220843.495082-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DM4PR84MB2118:EE_
x-ms-office365-filtering-correlation-id: 4f865083-6d0b-4831-0581-08df0ad11d85
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: sRQ9JJYzFYBD450tHVQY+1hsZQQkns1OMWPFA5wU0GSkLxI081ERUE6lKw4O9y62jrExIRmR5iKB2twEf54PxGlan82xyYpnzi6JGKzRsUx6RduNDajHVN6FOdqm0Shnk60XnxiJ19LG4Mf8OCJ+FPg7dJf4cTZ9uT3NNe0NpquxM6EzLB/bSwfXRFarxUXTKMa9mAEvKf+ZiLPiv4Piuu7eQBir60rjRwoC0hzbt0ZbV0jXaa42PQdc19dfg2Yt1C1hjeIiRpoC2OnFwfjtOl/ZkoYygSjoHd6BILD/dbjZTQzubVlPAvr+OW581j9x8TrNYNLsYFdEiahwMdS0+soqeqBowYlGtTT4zBiVURIjxkaXfsZIdaGG3KUW3f1wr2q/7G6gbvVEHuOo4ExxawFL8do74FV0NuOXauhjNRSswE1Pmg34U1q8CsXrjsdcek73LMEYSrY8VqQdm5baTtScJNT62/jijto4ekkKxcv4UOdRlfcoduPVYOuvPSse+HWsqDX03tizKMNiDGiyMPYURuYcRQON6V/AuzSsUpcukzzkXLUuYSBor5uizjRFclZV4p+9NAtzlIXzK1RszbLeww0dp5muVLVXFurxdZCzRC8aYlz4HKtqungx+daCNH1hVQWBDWkUlFpVIpB4r1SWypomOZhPunFxxJclrvgt4GKjb5iNEr6MIiO/u5OGHAOju4uKDM8NzeCdmWT7PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTVGUEFwUGhsZVN2TS8xcHF4NEs0WVZYU3NwTWIzd21sYnFOLzVlMlAyYmds?=
 =?utf-8?B?MEVGSENOUTZIempZOEl2V29sOUxJQzdOSmVQeW9yVm1mVkV4S1dZU3RhL1Ba?=
 =?utf-8?B?bmFLT2oyZm13MXE2Y0ozbnEzUlFXS2kzTzZUUTF4ZzdmWFpyNURjeXdvODBq?=
 =?utf-8?B?anVlNVQwRUpwYmJWalpsSmlPcU9xQ0RKenBHVVhIYzB6WGxETG9DekNEM3JE?=
 =?utf-8?B?ZmpIVy9HTlJmVVBHbFo4V1FhY1AyVWVPSFg5SisvZnZOYU0rVmo2RTBPcDBM?=
 =?utf-8?B?aFR5S3hISmlldDhYSWIvcjlldEl4SE56anZrS2RZVzJQcTVoMlJxcVJwS3BL?=
 =?utf-8?B?a2t5RmNSLzNqRXJ3dS9NQlZsdUhzYlRtWC9Cb1BDVnFXYVhLcFpkbVdGTGNS?=
 =?utf-8?B?YjdUaGRCNzArR1hOaXBtNjZYZWlWdm1zVXg2WjIzelhOS1ZvV1FIYloycGpV?=
 =?utf-8?B?YTRKbCs0aVRrNit4N2xIWlFmMFdVaUNHaERhUSs3eGVtemUrVzZTdHpkaUN5?=
 =?utf-8?B?TDJOeWp6d2wxU3F6Q0gxV2xPeG05TkRXam1xWEduTXJvS24wV2kwSlc3NWJs?=
 =?utf-8?B?bmRTcTFaWE8wNnlKTTlueDhIbnNRQlBtSnZEZXByNVZGdWQ4MkRKdlgzNGw5?=
 =?utf-8?B?TFBRQ1MvQlJ3TUxoZG41dkVNUnlkcHNFRHJXdmwyelc5REFkVmhwNnpKWEZY?=
 =?utf-8?B?UEpqMDBNNVd1ZjZwbVpCdkx4SnpBZThDR24wekFpVWhEWmNtaFk3VWRRRW02?=
 =?utf-8?B?b3pPR0ZuL2VOTzZkTmh6TmR4a09hb2ZWRXVqcGY5OVZQOWIzSGlOVTZMMTA1?=
 =?utf-8?B?QXc5Ym9FZXZ1OHl6RHVJY3Urcld4RU1aditwbk5WVEl4TTR0cmFTZWM4Q0Qy?=
 =?utf-8?B?aGdlbzM3emJBQWhqbVptVHhaZGxhb2lpN2QxclB2R3pEMytLYVR4bkc0L3d6?=
 =?utf-8?B?cVdtOWFLRVpqOHNzdzhSdFNZc0tiSFZaUzN2OXhTRE5MalhlVlNobkZDSXc2?=
 =?utf-8?B?bkNZU2h4VUNCenhzL3pZQTNWWU8zN2tMY0l3TmRwUHp1NkFRaUR5WnI1ZURI?=
 =?utf-8?B?N0hiUDJ1SFZMQ21NU2ozR3FJRTJ5SU1rM0xWY0xCczM1ZUQyc1ljamhmSVZX?=
 =?utf-8?B?MlNIMHcxRlQ4TEVsK0pObEJXc2E1YmNhVzNibC82QWFUaGJ4R2pkTS9XeVpL?=
 =?utf-8?B?ZXdoRW5WSHI5V2tiamxseWQ3ZkRCMHg5ZGIweGFnazVYcmg5OWUvOGZvVEFu?=
 =?utf-8?B?RzBabFZZK3pyVFZHeDhiY0U3bzVQZklIUlpJYldVbm0xOWJlcXVES1lpNmtN?=
 =?utf-8?B?U2N1ZVJ2ekJpWXhKZ0ROTlVzOVgvZklrMnlXUU1vaHJ0V1UvbGovem5WeEVX?=
 =?utf-8?B?R3hla1I4SjlvSlA2Q3lQdWNhRWhXZUVBVWZvMnk5ZGx4dVozTjZpZlBnZDFZ?=
 =?utf-8?B?MUkzVlVwRGVvRUxWS01PeVI0cGwrS2FMRnlQS0ZmRzRJYWZocWdaRi9LbDNs?=
 =?utf-8?B?TFdjTW5ub1loNlZXaldKT3RiekhCSG9rRVZGejFPanNTcUhGbU8zZmNDUnRx?=
 =?utf-8?B?Q2hrOC9uN2hIekJkVnNpL1doemM5TlZoR3lzbThGM3FHLy9PRlUzT0pNY3lY?=
 =?utf-8?B?UXQ0MndsRDZuSEFabkNtbTFEaEJSTXRxYjlGTTAxWk5wSU5DODdTL0ozU0Iz?=
 =?utf-8?B?RExZeVFSQ0lrbEZpVm4xNWJmM0ZDVlhxRStBd2psRzhVVDluRUZ2YUpSSEpL?=
 =?utf-8?B?OUxKQ21pZVFFaGg1ZFdtNEFpZlNRdHFFNmZGQlA5NzI4UEdqUWNUMk1wWXlM?=
 =?utf-8?B?a0t6YmZaMzVVTG0vVEFXZHU2WS9PdW5ETnlkc3NMZERIWXRiclBjUFFLUlc1?=
 =?utf-8?B?eXA5dnAxQzQyNFVIYkpkZGdoU0E0eXdMcDJhYjlTT2xUM0ZVY1BnTElXRDY0?=
 =?utf-8?B?QlBIY2o0WThOOHNsZVFuNXBqRHQ3M0VuWVBTeHZOb25LWnRhRXlNUXV5Vmg4?=
 =?utf-8?B?SFc4eWJIenZ5ZVlIcTZzdWVDRHhkWSs5aFhOQjdsTVdEOWdBa096NG9WVm9F?=
 =?utf-8?B?djRaMkw2LzVSSkowNHczaDZNK1lMR0pUUXBNamxKeW94c0RudTUyMUd4Rjdl?=
 =?utf-8?B?SGpnaUp3K1h5Um5ZZ3pHcXg5MXMvZFJlN2haN2RoMjVlc08xM3ViVVFYWDRz?=
 =?utf-8?B?dE1mM0J6emx2SDZKV0NiUGpmUTEra0dCTmMzQ0xZaWRRSGVKcXVzVHdTeCtJ?=
 =?utf-8?B?Mms0MVBUQlVRTFBXZklsSGNkb2MrVnZmVjU1eERxQkxia2dySDlWUVp6VGVa?=
 =?utf-8?Q?qfieJ+g/ddg/6SdpjZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ANpI4kT+ZU6qNFXa41je3iHnYdFuscCgBStPM7gEeo1zy07rFTcJtXAcePz2npdluwdtiUvzzF8T/4GKkORRrfODY98tqvDsx30oUZ7FpRNc95Um1iT/othBYbVY+sqoX7uI32KFlzINp2Rf7ze/QvqI6zgHWNQdeR5Ji+lJP9wgwAQiuOBfZ3NFC8FbTid4T75L2fa9ejClJMpYOjqPEeGOZE2u4wwMC/0VSuUEY92nTpLmaxz7CUwCzqRpaLi5n6158YsJk8vCJw0PR7gssv77oLMcnh38ZFWxGt80UAh1++yOE35GZik8HSmB7FCLL6JU92Omy7f9XFgh7ii2FQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f865083-6d0b-4831-0581-08df0ad11d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 22:08:56.9175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoDwTU1VbDMTFzdr1DQZzmaL+ncO9M0LlJpDWf9ciWIVyC32uEhohRi+ucocGF0bo5u4dN5NGaFWeRtonviGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB2118
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwNSBTYWx0ZWRfX1WDm48sxZpDM
 thsHWf6fO+nbEX41ApA/iwj0Ue4T7yN2/gA6/SVNNN/UmRPX70u+IFiJHMbsQr4rGYz2LvZxy3b
 wmy6ylm88RWuSulLUapdpmj5FeykcNfCX+GFBCYFFxglqfpyxLwcP54xSbYEcy0jq/kPzE4MI3Z
 /UuaR2KEdBYFYVNI5KyNjeIjXskC7G61XaR8IOzgmChQWuLyxGa8+/jkg/XdlL9D/GpBkYpj0mY
 BfDPfsqf5wn0WbuxI9sf5eo/bZHFimGkngxDL6j4HRUV9ZU+m1hdKMDYlML96tEQcp1PHipP5Hg
 ytAiPLq8Uc6lZN1A6ZqomcfM1wcnpDjiq1gUelMiRbfbxEtSsv+EjaNJhIET5bQWMJ1TxN8mz2H
 vMjtJOwSW1zoyiCLiHUwweOf39MSol5DkZCtWULF1T/vLN83HMIzSVOBttaOvRCwJRTgV0pLmi+
 NPBx8ipIbIeHCfi9evg==
X-Proofpoint-GUID: EUEorOpXv26JdpVs6BYIxO9GkPVvG9IW
X-Authority-Analysis: v=2.4 cv=NOrlPU6g c=1 sm=1 tr=0 ts=6a9b4180 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=HKJLD0rnby66v6-aK0UA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwNSBTYWx0ZWRfXzzmCSArIl3Bj
 JtU015SsvcS+wiPWkRXzq3byZ8Buu+KMYUquZmnirQtByNSzBSdh3hiMYvf/ndSyCKM6JJFGT0X
 sAAU77CQ0nKpbd207Fa5ArhlCh3iFPk=
X-Proofpoint-ORIG-GUID: BfcB4eLTJ-hGrS8tZLo2r3EUPWl5x0yf
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040205

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Cgp0cHM1MzY3Nl9pZGVu
dGlmeSgpIHJlYWRzIHRoZSBVU0VSX0RBVEFfMDMgcGhhc2UgY29uZmlndXJhdGlvbiB0byBjb3Vu
dAp0aGUgcGhhc2VzIGFzc2lnbmVkIHRvIGVhY2ggY2hhbm5lbCBhbmQgZGVyaXZlIHRoZSBudW1i
ZXIgb2YgUE1CdXMgcGFnZXMuCkluIGVhY2ggMTYtYml0IHBoYXNlIGRlc2NyaXB0b3IgdGhlIGNo
YW5uZWwgKFBBR0UpIGlzIGVuY29kZWQgaW4gYml0IDQgYW5kCnRoZSBmaXJpbmcgb3JkZXIgaW4g
Yml0cyAzOjAsIGJ1dCB0aGUgY29kZSB0ZXN0ZWQgYml0IDMgKDB4MDgpLCB3aGljaCBpcwpwYXJ0
IG9mIHRoZSBmaXJpbmctb3JkZXIgZmllbGQuCgpUUFM1MzY3NiBzdXBwb3J0cyB1cCB0byBzZXZl
biBwaGFzZXMsIHNvIGZpcmluZy1vcmRlciBiaXQgMyBpcyBuZXZlciBzZXQuCkFzIGEgcmVzdWx0
IHRoZSBleGlzdGluZyB0ZXN0IGNsYXNzaWZpZXMgZXZlcnkgZW5hYmxlZCBwaGFzZSBhcyBjaGFu
bmVsIEEuCk9uIGEgZHVhbC1jaGFubmVsIGNvbmZpZ3VyYXRpb24gdGhlIHBoYXNlcyBhc3NpZ25l
ZCB0byBjaGFubmVsIEIgYXJlCnRoZXJlZm9yZSBtaXNjb3VudGVkIGFzIGNoYW5uZWwgQSBhbmQg
cGFnZSAxIGlzIG5vdCBleHBvc2VkLgoKVGVzdCB0aGUgUEFHRSBmaWVsZCAoYml0IDQpIGluc3Rl
YWQuCgpGaXhlczogY2IzZDM3YjU5MDEyICgiaHdtb246IChwbWJ1cy90cHM1MzY3OSkgQWRkIHN1
cHBvcnQgZm9yIFRJIFRQUzUzNjc2IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVk
LW9mZi1ieTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Ci0tLQogZHJpdmVy
cy9od21vbi9wbWJ1cy90cHM1MzY3OS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9wbWJ1cy90
cHM1MzY3OS5jIGIvZHJpdmVycy9od21vbi9wbWJ1cy90cHM1MzY3OS5jCmluZGV4IGZhMGZkZjFl
M2U2YzkuLjY4MDMzOWE2YjkwZmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMvdHBz
NTM2NzkuYworKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKQEAgLTE4OCw3ICsx
ODgsNyBAQCBzdGF0aWMgaW50IHRwczUzNjc2X2lkZW50aWZ5KHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQsCiAJCXJldHVybiAtRUlPOwogCWZvciAoaSA9IDA7IGkgPCAyICogVFBTNTM2NzZfTUFY
X1BIQVNFUzsgaSArPSAyKSB7CiAJCWlmIChidWZbaSArIDFdICYgMHg4MCkgewotCQkJaWYgKGJ1
ZltpXSAmIDB4MDgpCisJCQlpZiAoYnVmW2ldICYgQklUKDQpKQogCQkJCXBoYXNlc19iKys7CiAJ
CQllbHNlCiAJCQkJcGhhc2VzX2ErKzsKLS0gCjIuMzQuMQoK
