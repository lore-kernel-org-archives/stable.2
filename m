Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20583016FB;
	Wed,  7 Oct 2026 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338817; cv=fail; b=QPgza020AIv8yUsUF3XJWFiPqc0z+i8NCJyYjz2fZWb6IrsyxwPRWmX2Ib6N8aOcLgOD33M63RZz9E+n/V6yKq2Nl4GShaKpCsVgRG9CZHyXdFM4FbWJEdCdlj3WstXMfB71swRo/jp1gPy6i7DR05jzpL3ZR6Z0rOde/gwt3Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338817; c=relaxed/simple;
	bh=bkz+SMz9cmsa44wI3vxzd7gtm3OQhPHGyfzk3Rfzfrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lRfAtMhcxYZVFEngB9hdpZy5SZF0n6/n5FB5nChqM3pNy92BNQ/eJY/sQh9ajuW9Ceb0FGSKgCC8WLg/4goaMPKMoloPa1+EuoqQ82fsxNBz7B7/emwdSEoLFQPJN7O8xMZDluOUToekMg/voiQLVe21MrKVoraHnBfunqy6Eyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Wl7ukWM8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YZmexhK8; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wfSISNqY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wl7ukWM8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YZmexhK8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wfSISNqY"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6971HpRf1656851;
	Tue, 6 Oct 2026 19:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=bkz+SMz9cmsa44wI3vxzd7gtm3OQhPHGyfzk3Rfzfrc=; b=
	Wl7ukWM8+sooI206rwTnOL2/wMoPeatX9BMdvbrOmU2B+Kiq5iPrOTwK/UTLLzxe
	s1Z3nxfGTzQDOolVRWsmDLdf7H89/7rGE5ZGJ2xgipU8Ynk4FWRBexIjURQJgys5
	V3ywNAyVQrl2YcHzHSQDOb0fzexMACsGH4pO3L3w17ZJT3QvJiZ8O6g7mxGEwAZo
	iSRqubTo8xlPgItJJejoMOGUTkbrvaqImiGvdQaUZa9YMf/WSOGs+GKY/2YroAG2
	jNVYsDWmznxogwCu1FPjJhlNRtNwUYLtsbG6C8jV92Adqyb1fFOlWMOmLzp488aw
	+DaiQU/9kg8xIRDyceEObA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4h56byjfcf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 19:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1791338803; bh=bkz+SMz9cmsa44wI3vxzd7gtm3OQhPHGyfzk3Rfzfrc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YZmexhK8n7D9Cx8W09WRdzUJadYB7z9oPBpLETLAhp3S3cEo92bea4KSWfMs5/mnP
	 qxUF9VJ/uWA3WDM9rt9Dj7JZiUjKkiHNOilszT0qKR/E+v6N/uSIbKDbC6/62k23P5
	 DBCSIkrs4wD3PtORXcxpxeYkXW+cnjo7H2QdW05BfjjSmDZ71dVWHle5kamjP7vTSA
	 clvcrivEALUDI9OUqsipEOD2ah9e4RcuWjZU2rA8khgWLmHntNBw6oYvC4Gow+pjvK
	 nUYGjWCBJCRQPldlLJIgN4h8UgmlOszNWZuqqcafw7uAvvDrkaXSnPT7AZqUykM86c
	 xqeH90n+GzNfw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 52089401A7;
	Wed,  7 Oct 2026 02:06:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DC691A0096;
	Wed,  7 Oct 2026 02:06:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wfSISNqY;
	dkim-atps=neutral
Received: from CH4PR07CU001.outbound.protection.outlook.com (mail-ch4pr07cu00107.outbound.protection.outlook.com [40.93.20.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 19F0D4024D;
	Wed,  7 Oct 2026 02:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNfwoC7JjDj53DH+tecbAOv8QUcOvPHGPEIEIbPj1V5WkmNQ9dC1LChsgAkz0eWx800eAu+D8v8ACO3YUT970miXu6Ry1o2IbXU1x/qsMvnOppSw+0NIG4LuTGfJzUWYO/g/WlKfSIehkuxAkWtr+RbRACRtScHy34hkLby8ul+FyclavSubil8XzelgLgDeRwNYamcc4woExMy07ReZcYjEBMOhMhGUHsYtyu4VEQc4muDhvDL8n4Ny5jh59xdMIH84PWkX/AtGTl1smmQoHakGNwyNE3/exyNC/z9mS0IMlGFiLqujhIPbHb4jgQ0uqJjKUM/lhpAhgnR/EMdqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkz+SMz9cmsa44wI3vxzd7gtm3OQhPHGyfzk3Rfzfrc=;
 b=Z3ZYMLFokwr7hjVrGtPKQx37yym9rQf6nO04ed0Cj0VRciHlUtsE3+Q+WiCwOrSre9x+D1N3eHnvpTWo0bGUSGgXiGz6QiY/WbI7OLZVD/mZ8SM+fVlQVPTrREPq1kV2Zl3UEcth/2dx7zpA14kzSP/OUcM85l7NdkSwIsTnAqTtfR7iusTYjMMUiHNzHpI2VkrGTYt4grZUokIni42nV/cj2T8Zv9wcBsb0598hG3A9RgEnEFPmHPQxzQaHuN5FCPjGiBl/u60D3QUzsqJg7sVhCTIyiu+QsP/Itu71PNsXR/K3MzhwVfF4khurW9IDNytr3NjQGCCakmchLEY0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkz+SMz9cmsa44wI3vxzd7gtm3OQhPHGyfzk3Rfzfrc=;
 b=wfSISNqYDTreBglDwYfau3e7MvDZSLYTgT5c6pfmMgW1OX12X4+31meXIA7yGZqToG2r6VF21ZrYKcnKUFPJ9LnWRZgCYW6ak+nRYUBuWmAHjEnDZvsFTdwmZ7BM+JTyDvuXh2HlNjXmBbcE26rqjcZf5caDCNUBv6Ud/dkO0bU=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 02:06:37 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 02:06:37 +0000
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
 AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYCABYeXgIAAj9uAgTzV/YCAB0WsAIAAQgCAgAXz24CABaAIgIAAq3WA
Date: Wed, 7 Oct 2026 02:06:36 +0000
Message-ID: <asWmW1jmzedIV5SP@vbox>
References: <20260227121236.963-1-selvarasu.g@samsung.com>
 <20260228002711.e442cuxwld4s2f66@synopsys.com>
 <20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
 <08273adc-d8cf-48b3-ba45-853d363af0e6@samsung.com>
 <20260306214123.3jnlzd2tmtwggch2@synopsys.com>
 <7f8a7341-3701-4ade-a198-cf86719da931@samsung.com> <arsnMM-GvuXwBKCX@vbox>
 <5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com> <asBhDmy-3DymDKQH@vbox>
 <3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
In-Reply-To: <3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|MW5PR12MB5681:EE_
x-ms-office365-filtering-correlation-id: a67aa706-f941-41ff-40cb-08df24179e4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|10067099003|11063799006|56012099006|6133799003|38070700021|5023799004|4143699003|18002099003;
x-microsoft-antispam-message-info:
 naJwDAUVbUclkD7bknAKoPmVa2M5Y0YTrwdfLmOsDv8Tsa1zenVrJ16bja2LNHCiXCu8W+nqX9kYSTl7vBE8KjDbNV41/yJCEDDUKhChSmXyiAV0yytEeLBsm4ZF8H24ur5msWTpmZafHIrIkuscMjsVzNxsi5YN0eHowDJJjfPwgPRZCqexvG7NqOHs64L6O7gBCKlbADfqb0S/sGcFCMmNDAN18pbKTJPgWKeV91KIKKNF1+klJsp6cWzpL05bPKSSfvDIOOh1GZnDf5yah+B2F1FIssyMTOoAF6GGGDAcH2tnyWl1BOKPJzw4E2w0PeiEMGD/V8rvrcvutHk2e0oTFVo/yaAwnq3SMxF99j00ttLr0vQMJBUQhIuTwR7XwBaMWxyVdH4Hk/vLRh0OI2i8puyJHa8U7xSBmq+XICSzBGOoDIx8bZt50Gb5TnVrY2B4fxdelN72aoNw/3F+xBy+sNAGkvnqU6vlU/HqFjimbEOvnQ/hgZD5lt2r0osdNN4oktxCD+uBL+3yJU5T1QuKfdgIyZeUNQIRkt2fkDKkZpdaQ/7+wa4DuElDXpvxYPx9Nq4uFQxdFkcUF3MtUp1KOxWt/n8VT7UKJ1jf5KlKhpLo4rSEjP2KImPZVM3KgUjs9hmPeJXYrcZXS6cJTjIlVcYFAp9lqqEL1MS/az+OUa95Nip/ZqoPLPkpUqnGnaGoDh/nOF3Jqc7v+G5mwcbn/g7BHAH/c0CigsQYyog=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(10067099003)(11063799006)(56012099006)(6133799003)(38070700021)(5023799004)(4143699003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1h5bHcyOXJ1UXpDTENwMGRvaGZPUVZqVlVQeU9wbmMrN1ZmNkszRnBSNGFa?=
 =?utf-8?B?TkhwSXpXQUY2SFpWd1dVZlBReWJGT01hVmtJTnJkT0Q5bDZGYlNlSUNxa1Zh?=
 =?utf-8?B?RzBkRGZHWGdtQng2NXljLzVRWmFHWlJBWXJxd1ZqM1N5NXhXK3FFU0F6d29H?=
 =?utf-8?B?R1VVTDN3RytONXIwc0hRSG1xZ3RJY2NoZ29Idnl4RFhYa2ROT2YyTmxLR2NW?=
 =?utf-8?B?Rm93VEx1S0pJL2dRcTJWb1JqUlN6WHk4cVE1ZXdJZS9TMjZZcjdpYVNJV0N1?=
 =?utf-8?B?TGExbEs2WktHL0FjVWJhblAxMDBLZXJsSDA4cWovNGQ0TVJIN0hmK1pvamtX?=
 =?utf-8?B?TEdmVVhPM1BwYmpUeUJnbkJCVUQrNGREa3hlWHpYNXVLSjcxQjkzQTlkNUVY?=
 =?utf-8?B?UmJSTWhpM3huTWw2c1pzenVXampBeVpTSkd1d1BBRS9SMVVjNXNyZVUxV0J6?=
 =?utf-8?B?Zktsa3RlTGllQmpOQ0hkcWgzL09LOEZCVmN3a25YemJFT24xSU5HdjJGMzBG?=
 =?utf-8?B?d3JSUkhaTENKenNFMklXZzh6cFduQlBabThRNGpleXNnNG0xdGR3TkI4RkRt?=
 =?utf-8?B?Qjk2eTYrRkVlYjhNa0M5RTlZbVJDZWJlNWY4MmxkNVpONXN0NEF4WENHRk5y?=
 =?utf-8?B?ZjRscTZ6T1NHcUF1NXVhblV0amZSVFRWTU5IRXFSVU8yM1ZraFFpSHlTMzg2?=
 =?utf-8?B?YXhNbnozUlJOSDk3V21RUUd1M29YMnpnbEROTE02bFM2TkltemE3SWlzQmVh?=
 =?utf-8?B?VzU0dXVZbGMxOVhLT3NUczNuVUFVQ2xUeURtaGE3eWNYNWxzVWdtdFo0VGRI?=
 =?utf-8?B?dS8rY3EwYzBkcW1IVzVwdHRxeEJWbllEbWl5Y2NYclBweHhZaENxdGFFdFY2?=
 =?utf-8?B?TzF0RTRXcjlEbndYOUx1YWZGNm4zdVFsMkpPRXUwUmZ3TlZVdTU3amY2TDBt?=
 =?utf-8?B?a1BURk14ZlNVQ2ZZb01mVFNWRk9BaDhFRE05cDhpRzFoS21Pek5XZjh2WkRr?=
 =?utf-8?B?MTlqMlI3MmxlbXhhVVR5cXJuZ2svL1BYTWVnVHJ2VjFkVzNKbitjdVBsV0pI?=
 =?utf-8?B?KzdrdnlZRTQ4L0g1TGJTTE9YZGZ2eFd6NnpTYXp6UE1ZdlUxeUFCS1pSOTRC?=
 =?utf-8?B?R0FObExCK3Ntc2I2aExITGduZXl6VHJjbVZTOHg2VHpYQUExaGNzSTdFMGto?=
 =?utf-8?B?SkRkcDJDWXpHU01RQTRBc1hIRGVYRVlWaXVjUXN4VDBmLzVCSW5YaEJoeWpk?=
 =?utf-8?B?VExJUFdSemVpcnRseHQwTWVHVVYwcmJzeFAwOFdmVEZlUUs4ekx1cndDemlI?=
 =?utf-8?B?dmgvMExsZFFlVSswYVZHUEFVWFFiOWh6dTFueVVpZHg3OWdsNmYrVzJUTXFF?=
 =?utf-8?B?b2JNNDg3MENYTERsMXJTYXNWRmZOVGlLWGl2YTlIdW81eUFTaXA5azladDlK?=
 =?utf-8?B?TTZXdXJMRTQ4V0s4end4QzBhWXg2VlAvWG5KU2VkWnlwdGFaZGtOYzNqcnFJ?=
 =?utf-8?B?ZGYvWHR4RGR1TGlUUm9UOXFVY2Q5bkFyUGtjMGdaTnFmajQ3YXZWQWo1UzBO?=
 =?utf-8?B?dkN2ZmZEaDd0WGp3eFJINi9xdmpSemNMdktqTVN4eWt6VjUzRTlGTzJ4TE5q?=
 =?utf-8?B?QXlHVVUzUGVlcEQrYk5zQmVLbmFQRTF0NklKa1FxeGx0eGI0UWViWXBUcWhW?=
 =?utf-8?B?QnMrNUlKbmIvNHZETUwzbzBzR1FUUjZYMWpLV21rRDV0YTNHMWFvay9TT3Mr?=
 =?utf-8?B?SFBUSmx4TS9iR2pBZGpPY21QTmlNMDVTZE8vUXhmRmg5UW43TEZLV0EzSXly?=
 =?utf-8?B?cUovdkxOSis4VVpleXZqdWF0MlVpUTlBMm5ENmx6MjZPZGxUcTZFYTFaYTV1?=
 =?utf-8?B?VU10ZnB5dTBWcDJ4Nkwwa28wenkxbndaR01raWkzWlBuYnNLOGE4K2VCekl5?=
 =?utf-8?B?dzlycElsVUJyZURGWVpYYzlFd21NNzgyNDVQWVlveUQycVRhQnpOUk5kVTRv?=
 =?utf-8?B?RC9HOEVDajYrWGwvSlBDMmg1RTR5RFgyQzV6NVhVZS9WdndEUktsbllCRlZV?=
 =?utf-8?B?eTJFTXAvcVM3dDduRzRONzNlMHpvMnZNYWlocnlvODQ1Qzk2VExRSDBycHBi?=
 =?utf-8?B?QWMxdWxpMm5qZGxta3MvTHFIc2xzMWs2WE5PdnllTkp3NDNzcTBBWWdDTG1j?=
 =?utf-8?B?dGRmTkphTmh2T0VMampRbVV2aEtmNGpEVlhhVlBpTXVuSDh2WUdjbk85RitY?=
 =?utf-8?B?czFwRThrNDBVOXNrc3NwRXpuenR5dlpLcjZMM2NjcGpKK2VHQmsyaGhTcGJP?=
 =?utf-8?B?cjVLNy9LUzMwaUUxb1hKMklPRVhEY0JvSDc5c1VXWmVZN2ZXM09OUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A2A8830603D9A45903232B07D74E3BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Q8Qx4UFZXqmrIRQXvdJiEJF8MCKjeoolImkdsN9bpEEP/NWVHTldGVX4+IBXEU40u7F3Qurmd3uRbjqlCuZqFdhCSLeZKPRnJg2x2YZn9IVDVSnjZ19OVSEQMuH0TmldNM78YHRMSpHNIIdq2KeM17WxOQ8PyaDxxKUNxD5DCaPoHIPMIS1tFUD5THtjq93YkIb+piksPD9G8LHADuDwmatHAS2eAax2OuxbuNqqvGOgls4OztC0Y7yj68fuGYzwfw5AQGSZysxXu/qQmjJFUtBsv780yL05m+6YKKa5wWxr+z+jZ6yN/kFOFkPfwUQRkNWJqWdckV35DFztIt/4tw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xAsUixWVVsyRi8P7XknRuk3b2btV3LYQvXr4nnhAHqAYyRZpkxOJG0CLJOPf4bKy0Cb5+on5wOiTPKvvQtagutuqyhoOLosJdruIXx6+G333GXn2TpaUBLYbe5Oq9EdbFm376CUMz8HA3W3C/Ih9bIy1gUBnpmnwsumAPxgtwEh0Sv53Wq4jDkdGS/NTPAnLurKMbQdpaOXnHDEAwbPv8uSgaaMYcuUH29sDFCd6dWmOGtO/p4Z/JjNFjviXrTOub1XT7qhAeojHIKF6PuF0vehoL0jrRx9jylVObr7LrfL/eASP2nnAKZ9dwDcyyDYwodEoOGYPklChKC+Mce/Gfa2y6twznh3KDeFVtJr94PWRAd5/jQqnsZOXONvAfuYm2JydczTmG0QHsvyL5cysUf/tHLUO9dORIHPh3oLBh46NEgUYQYKOdqQc4Ownzsmz4p6IS1cEfYWzy1A72lkQL6n/m7ATq4TFonkETnk2NSMkPTM7qUHWwR8HAk0pfn0Su64sPKkiddsgiECmjpTFn/swi/gducoa8+aAqbfva1qYaHwNr2lSu8I+D8AAv+fwhYXf6Kub9miXUBcAZ5JzBy5ivFg06r40MibBRVxdP+fC4YAtvbq5FsDZbdeQ8Izf/XFbogpb1HG2J6SLHZRVLQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67aa706-f941-41ff-40cb-08df24179e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 02:06:36.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeeUnBzJz2+lkbeNtF1Otbe+gKFKJdMYzgxPsFpHrF5TYRS1edDWTRHCNVmwuZ06Dfxiye0u+ID2j5UtHXy6PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
X-Proofpoint-GUID: ovJf0-U8LkfCLxkEOcqB_Eo4MRAqmzuh
X-Proofpoint-ORIG-GUID: ovJf0-U8LkfCLxkEOcqB_Eo4MRAqmzuh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwNyBTYWx0ZWRfX0M3TZUmpeAb7
 TmCPPp0iVhFHz+uaUkNdCtvtODNToTxPYjwpmGwbPnNThnGWAv88uDHksI8LADOHgWJyJYlETOL
 ZYhmZKBV29S+xTwt03AO/jL6+hACYzr2knrQFM5pirVx5Lw6BuJqmMbuKlzyzL2AWZvxpOwfw6w
 GPcvdkGFnYarpzQf/qv46wOrDpJF0DewUgc+fdCkzx5k49E3KLZp7yPXFr25buw2FK+0Ny/PtAi
 SWowVoCpkDgHghfy4gFdQJHISMgkiZBhMHIYfk1sPhYZ1C2eG072r3KVNmzKMDDN8j2jOfMKkYt
 H+4cFtdnNz75Vg7fYmxyL1kp1PqLBJrLatv6wGBDKguVOxym1bP9K8LU4NOmcCNJPBbrok/MNOH
 SofR/AAfgC8Nbd8+2anmFAGYHLoAf6uTlxMpJRiO+YEbZ4mItkL7Hn/9CweUn5WV/HDzi9YS4pc
 e/jXGmkISmg325EC4sA==
X-Authority-Analysis: v=2.4 cv=cMV1IVeN c=1 sm=1 tr=0 ts=6ac5a934 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=yi7EwGg6YDTMOj6UjfwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwNyBTYWx0ZWRfX5Y20k9PryMhm
 WZus3wDGWKq+ekZ8PaSB5nSnRI5iGd7cfs9Zm2/cZlqst5WFsHA1XJ4wRp7aE1zq06bGMWDPfGa
 K36USUm49hnKQtc4+yp8KLSuDDaL2OM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2610070007

T24gVHVlLCBPY3QgMDYsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gPiAg
IAkvKiBDbGVhciBvdXQgdGhlIGVwIGRlc2NyaXB0b3JzIGZvciBub24tZXAwICovDQo+ID4gQEAg
LTE3OTIsOSArMTgxNSw5IEBAIHN0YXRpYyBpbnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVy
KHN0cnVjdCBkd2MzX2VwICpkZXAsIGJvb2wgZm9yY2UsIGJvb2wgaW50DQo+ID4gICANCj4gPiAg
IAlkZXAtPnJlc291cmNlX2luZGV4ID0gMDsNCj4gPiAgIA0KPiA+IC0JaWYgKCFpbnRlcnJ1cHQp
DQo+ID4gKwlpZiAoIWludGVycnVwdCB8fCByZXQpDQo+IA0KPiANCj4gSGkgVGhpbmgsDQo+IA0K
PiBUaGFua3MgZm9yIHlvdXIgY29kZSBjaGFuZ2VzLiBUaGUgZ2l2ZW4gY29kZSBjaGFuZ2VzIGxv
b2sgZ29vZCB0byBtZSBhbmQgDQo+IGFyZSB3b3JraW5nIGFzIGV4cGVjdGVkLg0KPiANCj4gVGhl
cmUgaXMgb25lIG1vcmUgY29uY2VybiBhYm91dCBhbiB1bmNvdmVyZWQgZW5kcG9pbnQgcmVzb3Vy
Y2UgZmFpbHVyZSANCj4gaW4gc29tZSBjb3JuZXIgY2FzZXMgd2hlcmUgRU5EIFRSQU5TRkVSIHRp
bWVvdXQgaXMgb2JzZXJ2ZWQgKHJldCA9IC0xMTApLg0KPiANCj4gVGhlIHNlcXVlbmNlIGlzIGV4
cGxhaW5lZCBiZWxvdywNCj4gDQo+IFN0ZXAgMToNCj4gIMKgX19kd2MzX2dhZGdldF9lcF9zZXRf
aGFsdChkZXAsIHZhbHVlPTApDQo+ICDCoCAtPmR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVw
LCB0cnVlLCB0cnVlKQ0KDQpMb29rcyBsaWtlIHlvdSBzdGlsbCBkbyBGb3JjZVJNPXRydWUuIENh
biB5b3UgYXBwbHkgdGhpcyBwYXRjaDoNCg0KICBiNThlNjIwMDQ1MGQgKCJ1c2I6IGR3YzM6IGNs
ZWFyIGZvcmNlUk0gd2hlbiBpc3N1aW5nIEVuZFRyYW5zZmVyIikNCg0KPiAgwqAgwqAgLT5FTkQo
ZS5nLCBlcDJvdXQsIHJlc291cmNlX2luZGV4PTcpIGlzc3VlZCwgYnV0IHRpbWVvdXQgb2NjdXJz
DQo+ICDCoCDCoCDCoC0+IHJlc291cmNlX2luZGV4IGNsZWFyZWQgdG8gMA0KPiAgwqAgLT5kd2Mz
X3NlbmRfY2xlYXJfc3RhbGxfZXBfY21kKGRlcCkNCj4gIMKgIMKgIC0+IGZhaWxlZCB0byBjbGVh
ciBTVEFMTCBvbiBlcDJvdXQNCj4gDQo+IA0KPiBTdGVwIDI6DQo+IF9fZHdjM19nYWRnZXRfZXBf
c2V0X2hhbHQoZGVwLCB2YWx1ZT0wKSAtPlJlIHRyaWdnZXJlZCBjbGVhciBzdGFsbCBmb3IgDQo+
IHNhbWUgRVANCj4gIMKgLT4gZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRy
dWUpDQo+ICDCoCDCoC0+IEVORChlcDJvdXQsIHJlc291cmNlX2luZGV4PTApIGlzc3VlZCAod3Jv
bmcgcmVzb3VyY2UhKQ0KPiAgwqAgwqAgwqAtPiBDb21tYW5kIHN1Y2NlZWRzLCBEV0MzX0VQX1RS
QU5TRkVSX1NUQVJURUQgY2xlYXJlZCBpbiANCj4gY29tcGxldGlvbiBoYW5kbGVyDQo+IA0KPiBT
dGVwIDM6DQo+IHVzYl9lcF9xdWV1ZSgpDQo+ICDCoC0+IGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkN
Cj4gIMKgIMKgLT4gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKCkNCj4gIMKgIMKgIMKgLT4g
c3RhcnRpbmcgPSAhKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpwqAgLT4g
c3RhcnRpbmc9MA0KPiAgwqAgwqAgwqAgwqAtPiBJc3N1ZXMgU1RBUlRUUkFOU0ZFUiAoYmVjYXVz
ZSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQgaXMgbm90IA0KPiBzZXQpDQo+ICDCoCDCoCDCoCDC
oCDCoC0+IEhhcmR3YXJlIHJlamVjdHMgd2l0aCBOT19SRVNPVVJDRSAocmVzb3VyY2UgNyBzdGls
bCBoZWxkKQ0KPiANCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgZ2l2ZSB5b3VyIHN1Z2dlc3Rpb25z
IG9uIHRoaXMgaXNzdWUgY2FzZT8NCj4gDQoNClRoYW5rcyBmb3IgdGVzdGluZy4gQ2FuIHlvdSBj
aGVjayB3aGV0aGVyIHRoZSBFbmQgVHJhbnNmZXIgY29tbWFuZCBldmVyDQpjb21wbGV0ZXMgd2l0
aCB0aGUgZW5kcG9pbnQgY29tcGxldGlvbiBldmVudCBhZnRlciB0aGUgLUVUSU1FRE9VVCBlcnJv
cj8NClRyeSB3aXRoIHRoZSBiZWxvdy4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQpp
bmRleCAxZjk3M2U1NDYyMTkuLmJhYzAzMjg0MjNjZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCkBAIC0xODE5
LDcgKzE4MTksMTEgQEAgc3RhdGljIGludCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3Ry
dWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwgYm9vbCBpbnQNCiANCiAJZGVwLT5yZXNvdXJj
ZV9pbmRleCA9IDA7DQogDQotCWlmICghaW50ZXJydXB0IHx8IHJldCkNCisJaWYgKCFpbnRlcnJ1
cHQgfHwgKHJldCAmJiByZXQgIT0gLUVUSU1FRE9VVCkpDQogCQlkZXAtPmZsYWdzICY9IH5EV0Mz
X0VQX1RSQU5TRkVSX1NUQVJURUQ7DQogCWVsc2UNCiAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9F
TkRfVFJBTlNGRVJfUEVORElORzsNCkBAIC0zODk1LDYgKzM4OTksOCBAQCBzdGF0aWMgdm9pZCBk
d2MzX2dhZGdldF9lbmRwb2ludF9jb21tYW5kX2NvbXBsZXRlKHN0cnVjdCBkd2MzX2VwICpkZXAs
DQogCWlmIChkZXAtPnN0cmVhbV9jYXBhYmxlKQ0KIAkJZGVwLT5mbGFncyB8PSBEV0MzX0VQX0lH
Tk9SRV9ORVhUX05PU1RSRUFNOw0KIA0KKwlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX0RFTEFZX1NU
T1A7DQogCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkc7DQogCWRl
cC0+ZmxhZ3MgJj0gfkRXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRDsNCiAJZHdjM19nYWRnZXRfZXBf
Y2xlYW51cF9jYW5jZWxsZWRfcmVxdWVzdHMoZGVwKTsNCg==
