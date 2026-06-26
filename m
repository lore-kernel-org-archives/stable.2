Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000B2FDC27;
	Fri, 26 Jun 2026 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782514740; cv=fail; b=WDSCEp9OkkrEwotXXHkuP/MdonrZNMin8fNVRMj6+EyD3VenN9B6hN7wb8COqHv4ZIWm24Ke/EEnoyxtNBndRjFjhVQLtMKW+fmVpAtJOdv8M5pvTAxA4iz2vI0MnlLoztCANYy1NoK6f4CcW3SlXG4ZITlMchaqWhhlspzTAKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782514740; c=relaxed/simple;
	bh=S78/D7fTzKfYZHAlSkN5vO8jyaLlKmU3EAFib+EZV+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ojmE4X1RQj/VecxL12UJ2MdqhowC8KReTV0et4DguEYKG5V1kzRNcpYApVeu0KxsvpSkHFqCHRAXDz9ti6kCQ/5O44GDAwYDPM2EMlnRsDmIeGdd6sm6bGjuwcfVTOVMHzlcR7RD/IaYLW/22O9h73z1OXk8YhNY6G+3pOWSBB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qIVXu2OC; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Py0Rhrgw; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rw8lUgOb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qIVXu2OC";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Py0Rhrgw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rw8lUgOb"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QKhW241930479;
	Fri, 26 Jun 2026 15:58:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=S78/D7fTzKfYZHAlSkN5vO8jyaLlKmU3EAFib+EZV+g=; b=
	qIVXu2OC3LnMJXAf1cX3DvA0Fked8xcn9ksprgsRmN8G/n/VLs9HClNngzD8Uvb/
	RWVc78lx9cpmU8H98EmyEPCpsAFxhoFaj+mFa9XlwIrWdcnSlSi/yesbUqyQWBrm
	mmGYp1p3J1DztTIPol5TOlrxSuD/s3t1F/YM69AveBj4S35vplT4AuJ5K0r6KWuf
	o9s0C05QWdicWIzFBQjq1tbEN+jD2NUKMraMKrfcQrt+Fg9QbnANsX3vy9asQ4gm
	GDdl/exQmSaxYkWBTcrndNO0AqjUCGOyvpd0jyCzX+Fc0DOF8a2KC5wSToWb4ary
	wHMCyGblYJTiGrJg+Exbaw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4f20qc8vbc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1782514721; bh=S78/D7fTzKfYZHAlSkN5vO8jyaLlKmU3EAFib+EZV+g=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Py0RhrgwK3C9QD9tQn27reLutL8rU0VbRiwGHyOUjs/zYSWMryGHLThbifRQTen94
	 +mYFN8I/nEl0IAHtzvdMaq6LBoXCmGdQgqfeGCjBF7kij0ZVAeMYvqdYwSZyS6NDxE
	 jCq1IAQAXPX7sfHlrZTtwBZ2mnnJqVMzUlAWFkWKrQu8YM3VoetXplbb++3kvSUoG0
	 hHe8F2pJ1bF59VWRr+s7OC0h4Ja36hellIT67fxo1yXxv24wu5W9KBEDLBQ3BXswFN
	 dNwff7FFA2vk1mZl95FISsKJfsgba/GXR1ODptyJA/FSPDobmxOmM+NL4XEZDMSuYq
	 QUD0KE2a7N5gQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A4FA34011A;
	Fri, 26 Jun 2026 22:58:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 33495A006F;
	Fri, 26 Jun 2026 22:58:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rw8lUgOb;
	dkim-atps=neutral
Received: from CH4PR07CU001.outbound.protection.outlook.com (mail-ch4pr07cu00104.outbound.protection.outlook.com [40.93.20.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 926E14011E;
	Fri, 26 Jun 2026 22:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ6VnEIGOKjR99+g+esMPJ7DFETuSukK8g4UoCq2xLVK+ycdAOk3oA5xCVmz8z5JeaQAIMQx2bJAX7O8zVVIQfb+9om001qjTSeydXK75+NOq84zGHnILCGl2by6Sefzi3XpghMu09NYrpDxU+3Y6ZVxTJC4IxiSz+epBt43QG+PWmCj+yx06RZVSnWpq2bgNQaj4N4GeGuyw1TnLO4bFSrpvi2dBxgaVEHZr4PBtT40tsaFN4pyfh1MlRWWQcJrlZu1qeo4TXWtbw+KJ8VHVU9FEnD99ErkFnJW/9/e/ZWzACEJ1IQi/fhLv6iqu07hXx1v49+OPwK0JyboiIyDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S78/D7fTzKfYZHAlSkN5vO8jyaLlKmU3EAFib+EZV+g=;
 b=Cx6mIwtGBB8HlfJPCG7/oridcatjlbs+QCuRHyohP5P/Vq1tt+EOAWftGRXcMEa/PqL73qrXv1QViBCOXmLYr18OaWZUm0mDtbIuenmeM0pWyQBjAsFV0Rm6+IN/PrJ+CM0zdM2L4UkD+PJ4U/NZ3grn4Vi2mVPSZxjAyc3DLPgtMQi63xI+eK6TV2DaKwZDwDMg24ejV4Uqk1YsBVJIrJEvhsKoo5cA0hmcvOqg6t8qxTVt3/0NPKpUAwJnORGlSsvnjCzRseas4zLmXxn/nzJeH8X5caWZrk0smkqTWX95PEd2NB1b1W8b3cmn92Re8fe54v3eSL7HfaRBEbGSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S78/D7fTzKfYZHAlSkN5vO8jyaLlKmU3EAFib+EZV+g=;
 b=rw8lUgObk8mu1Q7gKnPjsz6stjsUyWHo3TEDHxz/JM4NIFLJFZz2xlmxGeCtaf9YWPhgqVc/8yM7/u9Qb+lykwiGltZPPHa8gqK3o8Y46U7cMotG4xMaZnaHdy7mjP5EdvlXhAV79ncEYqxUE5x+ceiYLphxT9hZgyaw8HuQX8Y=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 22:58:31 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 22:58:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jianhao . xu" <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] usb: dwc3: run gadget disconnect from sleepable suspend
 context
Thread-Topic: [PATCH] usb: dwc3: run gadget disconnect from sleepable suspend
 context
Thread-Index: AQHc+iswpiZnmFzhtUuUQhk3WjLKXbZRikMA
Date: Fri, 26 Jun 2026 22:58:30 +0000
Message-ID: <aj8DsuXoqh1PBAnf@vbox>
References: <20260612052005.3849659-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260612052005.3849659-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|LV8PR12MB9336:EE_
x-ms-office365-filtering-correlation-id: 5ba64f00-c44b-461a-a462-08ded3d6710f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 NclOQcwlA6dxbnzrgW/C2J+NqmSldfV+6EsQtk+56y6+zKqUnCq68cH38nNxRAzZkJvAC4zK/Z5kWGP36YK2TXkVmvXX3l3OW8UXzLTp6SRdnQjGiZlY89Xf40ap1tBL3VcgBxnFKFBdUSswo9oLDoqhxQVbIkjLSe4eadgQ8pgiHL50dvuDhlOS1fbxZNSYbZM9dSZfABwVvncEnoM4iefkbxGVsZk1D0eMQdPBoGN5zD2sSNhRVExW7QjWM1F3Xhu/zLnlnedWqGtT5rN5t9lgTBPuTqmFvXSNW8/zfJJw6DntzOOKsucC8tSFIKMhvrET+J5rDmKptV270HqM8JwTGltEONzwWi5i8VtmO541nsfIuSl5rVv0pjTsHoF3T9jrLgAfQayGWnTWF2tjwqdEJXF9pvGoJ8lehnwu8V0I4LI5MD+L0oOzM11YgAYH2HVOmFyI6BT4zsvxsD3RI+scMFFDpOmW2P0ocGwlPvwX11MQRszpVJrvZ4w2z3b/u0V700t1uO64FWw4lyoVsFKk4R2NZcA2m8gkdAJfYQ+bgL77UU58vnhjaJwMSSG+MOQv7ywxvaXlmb2hX93Ccq7IW/RMpmcsRHuYphj4Oc0WwmV2W94Njp6YPX83W8JypCKOy7LzWAPY6ohitQtv2hRMb1AXLj4f6sGu2rKt0xPE2VtiRDXrcZb3BLECcUyVXy+HgBLG2V5yQ3cAG1IZPe6L+FjIuuhYdQWGLqJnW6E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3l5RDVsWUM1TjBOc1czejRsbHM2ZVcwWmg1YlZoQ2d6NVRxZHlOWk5PTVhF?=
 =?utf-8?B?ZzlQaDZaVUVNUHROUWM1S3pMWjAxOW55Y2V1aVdLYnlMT1hXeWQrT2pMOWUv?=
 =?utf-8?B?ZW1kVFJCaENYU0xVQ1pCazZkZUtHYmJxMUl3UUREWEVJcjdiMUJxYnpzT0Uw?=
 =?utf-8?B?aHQ2L0NGbkdFVUd0cklLQmNLZWxBcmQ3S2hoTXpKZisxMVlndm5heitkTks5?=
 =?utf-8?B?aS9NbGo4Zyt6K3dKNjlHd3E1WG9KV3hrUUJtVzZNcUlUTDlKNzBmaE0yQ1Qz?=
 =?utf-8?B?d2VtQndkVXZZZVNPZzlTR25DMlhYY3dUUS8wR1ZUUThvKzg3WTN1czRYNW5Y?=
 =?utf-8?B?KytaYWxZbWdpUk8rYzRFTWtleWNHcVFma1J0NkdZNmdoN01ickFVYnJiMGo2?=
 =?utf-8?B?Q09ZN2RiSE9pS1g3NllkY1Q5NDNROUZYV29tREp1SnNJdTBHTDhFWEtWVU5k?=
 =?utf-8?B?cmluWkpxQjFaa1BXOE9DQXJYY2xkUEhQTllLMmJxcWFUb083R1A1VW1KQWpQ?=
 =?utf-8?B?TnJ5SHZDUHFEcysyQlNLRnovb0Qva3EvTU1XaU5XTnFXS01yczBDQ0R1bUp3?=
 =?utf-8?B?L3NrUXdMeFFRVXVTMmJTTzlJYWN3TnFjUUs0THM5SXBCRkNueUJGYWcrL0dN?=
 =?utf-8?B?UEt3VmhnSHN6TEx0dkc4d0RpSnBSaGVPNUZvQjBFY0FBL08xOS9xQndabHdn?=
 =?utf-8?B?M3BmUUZEcmFabEErK0o3WjlKQXdmTjFWa0dTMWh4dWRFYVcvcjZtQllDK2F1?=
 =?utf-8?B?ZDVDSUQram1GSS9yaUJLQ252YnBKTitDUTh5aWdXTGZRSGphNlZvbWJDWUJv?=
 =?utf-8?B?aThyTWMrSER1c2xCSEhKQndiZ2I4R3JhN0g5NVRIbDZ1ZVh3SFBtQ3UzRHJp?=
 =?utf-8?B?STIwVmNhT2EyMjEzNHVIZFlORFo0NndkMkJCeWpreXEySWM4cm5RM0tWQVND?=
 =?utf-8?B?Rk10aWNnbk9TSXZBb1Fteng1UFV1RllobEx3WGM1LzByL0FtMlo1Q2lQb01N?=
 =?utf-8?B?MEF0ZG5kUXVlSTFZNnd1M08xTXlucjdQdm5meU80TlFtNFFtL0VVdURzb2VI?=
 =?utf-8?B?VFIxT0Y5aGxVeW9xQm1STzR3N3dNYThGQU5NUUsxbHMyeWFiZzQ5Smkwczgw?=
 =?utf-8?B?S2pxK2tRNUt5VmtidXRGcjI1SFNsUzBibHRvc2R3WG5ZNjF6dlU3N3kzaTZL?=
 =?utf-8?B?L29qdDdlZE56RjM5WUphejRSQnVpSDJQWEJ3OVBKTUNPcThFdlZLUG1oOENI?=
 =?utf-8?B?YUhVM1l6akcvdmRRTTNFSFBnc1QvamhBZndjeWs4ME5nbXRJVU01T3pDNUNY?=
 =?utf-8?B?bDdzQ1hIUnNVTEJSUFpwTGxPZTJvQVozczRPNWFUci83UzQ1UWt1MDQyM2Qw?=
 =?utf-8?B?WUxzYmJuVCtNemJBZkcraDZtRWozaGFUVnV3aC9zVnljOVdjVmJqNDQrQ2ZV?=
 =?utf-8?B?RWZkOS9GaEdhRmNBbTFDR2Q1T1g2NGRMWWNURjdQSXdJTkZ3YVdWOUlpT0JI?=
 =?utf-8?B?RkI3MDUvT29Cdi9hUVM4TW9tdHFiMnhQNDdwMlpxSjIrTUcvSFRoSkhRamVx?=
 =?utf-8?B?ZTQ0KzB6SWVwcmlORmt0VEpmNDhBeWJHWnA4RVRwVGxDL3NlN1FJMTRXOVdr?=
 =?utf-8?B?N0VWVDZRaE1ib0FqWjBBRkxhWk5VZDB3WEhLRk9pMjg0cFVQcjdudDhsc2Zr?=
 =?utf-8?B?T203b3dmWERoT0N1bHZxbzY3YVBYdFFJZkpUb2dnSXZmYjI4L2dSS1dWWXF5?=
 =?utf-8?B?RFpTdUQrOE82VUI1V3ZWeG00S0FTdEpqMVNHVDlNSjY0TW5Ldkd3L01JRzdk?=
 =?utf-8?B?Z09RckQreFp6TGF2dWtEdi80cE5Fc1BCWGZXcGszY1FQeEYyVHNvbCtuQ0xw?=
 =?utf-8?B?MWhadDV5TjlpTExZb2hVdzlkWlRvOG9tbUxQTGlPV29rdFVlTTArYzVwb3V3?=
 =?utf-8?B?SVdFNHhJSGM0aWlqV0o5aXpnUWZZbTN6Q3lYTjVMeUFNVjdDWkRMUUFwbzBD?=
 =?utf-8?B?K1R5eSt4UVArL2VIY1RNUENYY1Frd1hNUldWU3dQMnNHT1VicEpXUktLUmdw?=
 =?utf-8?B?M2VpL2kyVnp4Tk1SelRrbFVxV1NTMHRIZ2E4MkU5WHNjSXVMRDZiMTZQZFV2?=
 =?utf-8?B?cnFGM21TNmMxcDBXR3ZGRGtrOC82VUNRTXBNejRrVzh6eVNzb25FZjBVQjk0?=
 =?utf-8?B?S25qTEdKc0xRL3laZGl3TFRUVzVFRkV0UUFUWndxT1Y3TjZYU0VrU2xIVVlH?=
 =?utf-8?B?TGpPRWRDazZsclpEd3hienltM0p1UWxGVU1WS1ZLRE41dm5RMWI5QnpRZU0z?=
 =?utf-8?B?c09nY2pWRHVwekNrQk1qYzc4Y0pDYUo0dnFseWZRR21peDdDbDdlZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8397CA1B5F69364CA97D0AB0CDA86601@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NvUg9M6Uf0ZzUrxAu9DVqBQ9rpDb+f+rYGqsxciFX3dGDcYA8l5TfpElcuwjbv/hkILHxm4F1LGz0aghSne1qmbek1ReAj7K/J8IsGFR2fjKABxzjwA3SGnQ3iVauThHoNSzqI1xoQH4oYVqMQWYzYFHI/OTzm8ozkwS2bemw/OGRoLUWFqkcFnejx8YCooq2k4v3OVGzwwUtLqnXHaMxhgs2IG0LNCIvUGgGD5yl7c2cyRz5J3Z3VbxBX7Rg2ZB8dM1HBzRcO7To3mjDuCsU3GFqMtxPjqiPzYz+fheftnu96B4HJ5JFsPPY6Ydm/WjaKjeA1TEFIdw34/5RCwKmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R3PKdMlJI2FN9Kv6sjps0sS/27xQOynjDYVovOYflr/0+6IZTpQfmAQp5rfBVXHFRrT5KaDZiTKiionZML5/bsxDeBMjXAIEz0AgNj7qfL5swq+KzGY2K9a5BKGHP9RxJZ/BZQqrZ9/Brzkz2fnLifd+1u1V4pEdVVT+QDnMvYf2LmeQCp04YGaL+u1adZQOqdY0iS2uvnH0J/Wxk819eOwutcTjE/mgFO0CKYVjj/GDar0reAnfdqIfY1Q+QWYkgAGSEudHS1FELfva8XirY4oQRkTF8Zn5kxkgDcpLvvEj3hGS8XXu+ZIANlJO1+j9XaYd31rgErwcamkEpaalwAYEjzbfCIgskVNwip4nlbp+AitZREpDZ8o1+QXI6/gI3spIU3+scYBLkEwNOkFixiHY6n9fYJrk8kPa3LtIgTzGcAG/HooVFcEqml0E2wVp+ORDu/tvu7MH/0sRUVsbBGGXqnphFzq/bvQmo2Tb3SDmLZVLNGDkwl1GimXg092Lqw/OMg2F1Rr2vtyOnF+VjKQBm1sqxaJPjX56Cavp7kgcbBmT8EMhOU3SdneD1TlNCgWg7cPBt7KD7O43mv770Zv7Zm+i59YMdMU0As+DWLMZkvvV367bNlLo/9/T4/I8wJpKzcQHhVZ33yYbS/cRkQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba64f00-c44b-461a-a462-08ded3d6710f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 22:58:30.5946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5m559dIlofwnCieky91jhldvI61HSxOIIuzIAZvEx8VpBG31XWHvrPbIcXLgc1leOsJKk1cTbDC9/Dsw8S9G5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336
X-Proofpoint-ORIG-GUID: JSCHTEJEAysnFOfQvgU4DHOwCYNcmVyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5MCBTYWx0ZWRfX1iQmfVFswObT
 zBLTYv52GkdMuxm8YvCiFtlxK91y0f5p1qLVe0nrvvhGbDMu+dud8CfPka81Zn+2xHrRfL7qu7w
 pm2XNGG9URpF9eWzlEJSGJktOsYcGta1ogoUHAp7WWfVMhjJMKAN+sGIrM4o6OYtpu9FYTqBpg6
 zVR8zQYJVUTMSqKl6xvWeRLnmOoJMEeWa56k0fKgkFSGQI1wndjv8a/WrZepOj5C6l9O06QUFjV
 IR7MtjraPfFdfcqbsk+bZztJvKYQuGTZAL9RRTA+xIGgpmOH3hJbw3MKYdK7MUJlxoPpCNUOcnv
 6zYYuACykmkBkVqOOpJmuDyuJLfoqpYy5seHAAP1aiO0nb1K7+Fd/GRxkKnyiQgDz41uTSYSvPc
 27cNLtzwF2adEeTC3DquSW788n0j2hiEiT+xtSkmlZlG+dvGUXKnk6F0BDPINDa32kohNs/ZL13
 hDtMaUe66ZszUSQwQYA==
X-Authority-Analysis: v=2.4 cv=bo18wkai c=1 sm=1 tr=0 ts=6a3f0422 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=6al8y_X73J1iKFhNIFQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5MCBTYWx0ZWRfX+IsA5cHDWEBS
 XRN9RcP3nTPJdcXbdKi/RaTFFj33ENU/hBOHFMCqyF/zeu28fHoGbHOD2SYfnbYvlWB3lJtg7Mb
 WVJ0o5Bes5Gk+P4pD0rYLLD3m7mKgdQ=
X-Proofpoint-GUID: JSCHTEJEAysnFOfQvgU4DHOwCYNcmVyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606260190

T24gRnJpLCBKdW4gMTIsIDIwMjYsIFJ1bnl1IFhpYW8gd3JvdGU6DQo+IGR3YzNfZ2FkZ2V0X3N1
c3BlbmQoKSB0YWtlcyBkd2MtPmxvY2sgd2l0aCBJUlFzIGRpc2FibGVkIGFuZCB0aGVuIGNhbGxz
DQo+IGR3YzNfZGlzY29ubmVjdF9nYWRnZXQoKS4gIEZvciBhc3luYyBjYWxsYmFja3MgdGhhdCBo
ZWxwZXIgb25seSB1c2VzDQo+IHBsYWluIHNwaW5fdW5sb2NrKCkvc3Bpbl9sb2NrKCksIHNvIHRo
ZSBnYWRnZXQgLT5kaXNjb25uZWN0KCkgY2FsbGJhY2sNCj4gc3RpbGwgcnVucyB3aXRoIElSUXMg
ZGlzYWJsZWQgYW5kIGFueSBzbGVlcGFibGUgY2FsbGJhY2sgdHJpcHMgTG9ja2RlcC4NCj4gDQo+
IFRoaXMgaXNzdWUgd2FzIGZvdW5kIGJ5IG91ciBzdGF0aWMgYW5hbHlzaXMgdG9vbCBhbmQgdGhl
biBtYW51YWxseQ0KPiByZXZpZXdlZCBhZ2FpbnN0IHRoZSBjdXJyZW50IHRyZWUuDQo+IA0KPiBU
aGUgZ3JvdW5kZWQgUG9DIGtlcHQgdGhlIGR3YzNfZ2FkZ2V0X3N1c3BlbmQoKSAtPg0KPiBkd2Mz
X2Rpc2Nvbm5lY3RfZ2FkZ2V0KCkgLT4gZ2FkZ2V0X2RyaXZlci0+ZGlzY29ubmVjdCgpIGNoYWlu
LCBhbmQNCj4gTG9ja2RlcCByZXBvcnRlZDoNCj4gDQo+ICAgQlVHOiBzbGVlcGluZyBmdW5jdGlv
biBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQNCj4gICBnYWRnZXRfZGlzY29ubmVjdCsweDIx
LzB4MzkgW3Z1bG5fbXN2XQ0KPiAgIGR3YzNfZ2FkZ2V0X3N1c3BlbmQuY29uc3Rwcm9wLjArMHgy
Yi8weDQyIFt2dWxuX21zdl0NCj4gDQo+IEtlZXAgdGhlIGRpc2Nvbm5lY3QgY2FsbGJhY2sgc2Vs
ZWN0aW9uIGluIG9uZSBjb21tb24gaGVscGVyLCBidXQgYWRkIGENCj4gc2xlZXBhYmxlIHN1c3Bl
bmQtc2lkZSB3cmFwcGVyIHdoaWNoIHNuYXBzaG90cyB0aGUgY2FsbGJhY2sgdW5kZXINCj4gZHdj
LT5sb2NrIGFuZCB0aGVuIHJ1bnMgaXQgYWZ0ZXIgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgpLiAg
VGhlIHJlZ3VsYXINCj4gZXZlbnQgcGF0aCBzdGlsbCB1c2VzIHRoZSBleGlzdGluZyBzcGluX3Vu
bG9jaygpL3NwaW5fbG9jaygpIHdpbmRvdy4NCj4gDQo+IEZpeGVzOiBjODU0MDg3MGFmNGMgKCJ1
c2I6IGR3YzM6IGdhZGdldDogSW1wcm92ZSBkd2MzX2dhZGdldF9zdXNwZW5kKCkgYW5kIGR3YzNf
Z2FkZ2V0X3Jlc3VtZSgpIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVk
LW9mZi1ieTogUnVueXUgWGlhbyA8cnVueXUueGlhb0BzZXUuZWR1LmNuPg0KPiAtLS0NCj4gTm90
ZXM6DQo+ICAgLSBWYWxpZGF0ZWQgd2l0aCBhIGdyb3VuZGVkIExvY2tkZXAgUG9DIHRoYXQgcHJl
c2VydmVzIHRoZQ0KPiAgICAgZHdjM19nYWRnZXRfc3VzcGVuZCgpIC0+IGR3YzNfZGlzY29ubmVj
dF9nYWRnZXQoKSAtPg0KPiAgICAgZ2FkZ2V0X2RyaXZlci0+ZGlzY29ubmVjdCgpIGNoYWluLg0K
PiAgIC0gTm90IHRlc3RlZCBvbiBkd2MzIGhhcmR3YXJlLg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+IGluZGV4IGRiNWU1Yjc3YjFlYS4uNjNmYWEyZDM4MTFiIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gQEAgLTM5MzQsMTUgKzM5MzQsNDggQEAgc3RhdGljIHZvaWQgZHdjM19l
bmRwb2ludF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YywNCj4gIAl9DQo+ICB9DQo+ICANCj4g
K3N0YXRpYyBib29sIGR3YzNfcHJlcGFyZV9kaXNjb25uZWN0X2dhZGdldChzdHJ1Y3QgZHdjMyAq
ZHdjLA0KPiArCQkJCQkgICBzdHJ1Y3QgdXNiX2dhZGdldF9kcml2ZXIgKipkcml2ZXIsDQo+ICsJ
CQkJCSAgIHN0cnVjdCB1c2JfZ2FkZ2V0ICoqZ2FkZ2V0KQ0KPiArew0KPiArCWlmICghZHdjLT5h
c3luY19jYWxsYmFja3MgfHwgIWR3Yy0+Z2FkZ2V0X2RyaXZlciB8fA0KPiArCSAgICAhZHdjLT5n
YWRnZXRfZHJpdmVyLT5kaXNjb25uZWN0KQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwkq
ZHJpdmVyID0gZHdjLT5nYWRnZXRfZHJpdmVyOw0KPiArCSpnYWRnZXQgPSBkd2MtPmdhZGdldDsN
Cj4gKw0KPiArCXJldHVybiB0cnVlOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2Rp
c2Nvbm5lY3RfZ2FkZ2V0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+IC0JaWYgKGR3Yy0+YXN5
bmNfY2FsbGJhY2tzICYmIGR3Yy0+Z2FkZ2V0X2RyaXZlci0+ZGlzY29ubmVjdCkgew0KPiArCXN0
cnVjdCB1c2JfZ2FkZ2V0X2RyaXZlciAqZHJpdmVyOw0KPiArCXN0cnVjdCB1c2JfZ2FkZ2V0ICpn
YWRnZXQ7DQo+ICsNCj4gKwlpZiAoZHdjM19wcmVwYXJlX2Rpc2Nvbm5lY3RfZ2FkZ2V0KGR3Yywg
JmRyaXZlciwgJmdhZGdldCkpIHsNCj4gIAkJc3Bpbl91bmxvY2soJmR3Yy0+bG9jayk7DQo+IC0J
CWR3Yy0+Z2FkZ2V0X2RyaXZlci0+ZGlzY29ubmVjdChkd2MtPmdhZGdldCk7DQo+ICsJCWRyaXZl
ci0+ZGlzY29ubmVjdChnYWRnZXQpOw0KPiAgCQlzcGluX2xvY2soJmR3Yy0+bG9jayk7DQo+ICAJ
fQ0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0X3NsZWVw
YWJsZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXN0cnVjdCB1c2JfZ2FkZ2V0X2RyaXZl
ciAqZHJpdmVyOw0KPiArCXN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQ7DQo+ICsJdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4gKw0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdz
KTsNCj4gKwlpZiAoIWR3YzNfcHJlcGFyZV9kaXNjb25uZWN0X2dhZGdldChkd2MsICZkcml2ZXIs
ICZnYWRnZXQpKSB7DQo+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxh
Z3MpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJZHJpdmVyLT5kaXNjb25uZWN0KGdhZGdldCk7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGR3YzNfc3VzcGVuZF9nYWRnZXQoc3RydWN0IGR3YzMg
KmR3YykNCj4gIHsNCj4gIAlpZiAoZHdjLT5hc3luY19jYWxsYmFja3MgJiYgZHdjLT5nYWRnZXRf
ZHJpdmVyLT5zdXNwZW5kKSB7DQo+IEBAIC00ODM2LDcgKzQ4NjksNiBAQCB2b2lkIGR3YzNfZ2Fk
Z2V0X2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIA0KPiAgaW50IGR3YzNfZ2FkZ2V0X3N1c3Bl
bmQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAg
CWludCByZXQ7DQo+ICANCj4gIAlyZXQgPSBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoZHdj
KTsNCj4gQEAgLTQ4NTAsMTAgKzQ4ODIsNyBAQCBpbnQgZHdjM19nYWRnZXRfc3VzcGVuZChzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiAgCQlyZXR1cm4gLUVBR0FJTjsNCj4gIAl9DQo+ICANCj4gLQlzcGlu
X2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+IC0JaWYgKGR3Yy0+Z2FkZ2V0X2Ry
aXZlcikNCj4gLQkJZHdjM19kaXNjb25uZWN0X2dhZGdldChkd2MpOw0KPiAtCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCWR3YzNfZGlzY29ubmVjdF9nYWRn
ZXRfc2xlZXBhYmxlKGR3Yyk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLS0gDQo+IDIu
MzQuMQ0KDQpUaGFua3MgZm9yIHRoZSBjYXRjaC4gSSBkb24ndCBzZWUgYW55IGlzc3VlIHdpdGgg
dGhpcyBsb2dpYy4NCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT4NCg0KQlIsDQpUaGluaA==
