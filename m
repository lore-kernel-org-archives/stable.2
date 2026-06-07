Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F1F223DE9;
	Sun,  7 Jun 2026 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850891; cv=fail; b=rCMbeGiQOp/FH9ruqSHoxQ6VPv747BbGe2NWUvDqVdTpTZy0wg2CsmgIWb9lt7aEVBwB2WpBchLfA06HRnAaH+59kf2bxB1Owb911SwDT7hx7woFKtouTq+9Er0NTKggmELwLoK6SMuL7uOvmlXSyWKlY6GQVWtZrpTz5iy00QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850891; c=relaxed/simple;
	bh=Ol4iRwSnH+w3iAyy46jq1mq8HTkaio5LJPL82WhlvDA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g5m5mJZk3vsaXX0QvYbc84mtzRpcDGZj8NGSqWbJ77knQ4AzVwwzNUCLrwVGqwnSfjwvaXZbqmE9Y7V2YZ7NWtGYnpUY+sR5UFldyC/tGHkL7IvajZhfGMqgMGIJvlgS5N9Wt6wZoGMgHS893DKOzHS93CepuYMN+m7J6i04Adk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=FfRjvkyD; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="FfRjvkyD"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65792ucs3334056;
	Sun, 7 Jun 2026 16:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=Ol4iRwSnH+w3iAyy46jq1mq8
	HTkaio5LJPL82WhlvDA=; b=FfRjvkyDRyDMI7rdlQSkcyPHQ9Zmeyj6VRsJeHJp
	bKdTml6ZE+CRdr5GbnBhXvSZAsHfr16qlp/rNUwbJUpojbbicT7YWehLf79N2HjJ
	VRsIGWWI/rEPCjuky+uW/Xlm35+LLFuZ9H3jstW0FHY4OwVirRK2ZwmXPpBtMusI
	AcBovs+SPtMLyl+q8rBW3MpG9VZUPgpXhLoBAFRyPUElUnYE64AjcxxfIm81tgPU
	B8iN3t8Y3liS/jCVDPczjRtuCbk0DFCbdQ9AmwXtGjISvSAb8egDAMy/iuJwOj4u
	HVIAsKcaM2Yjgi/GwSc2+/sxSulOBv3VaXwO0+qix9BFhg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4emgnt1v83-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 16:47:40 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 909EB132DC;
	Sun,  7 Jun 2026 16:47:39 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Jun 2026 04:47:39 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 7 Jun 2026 04:47:39 -1200
Received: from DM2PR04CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 7 Jun
 2026 04:47:39 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZO4z4z6Uu0g7HWc1V4zOwUM08tQUp6GeUQS/tDPEtWYxjI5cE2v2I7nJTmggGYA7fBUcryH6gILcu9jQ5pBs20vfkTKcHj8+aieAp+DOJedR8hCLCklYVniX2W6AoMq20wKWkwaBO8vIMwmxCFqVxoZed3qMbeqRizzqabUjrctCY/cHO5Fd7AdIN+esifnCFPlKnOHOvg6jm6wgrAHX+6J9xMu1sADpywlz+rr24M6+XUGQ81T5aSQ3N+fKdwfqp8Ya4kbPWEBakvPdjai0sT8KQ8GGcvaWUI1xr3sGLnZ+YxTqQw7JPLOEwO+WFc+dir0edVm4GNjUIgVzZyyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol4iRwSnH+w3iAyy46jq1mq8HTkaio5LJPL82WhlvDA=;
 b=n/FNDpacZ+ueTmnV3UWt8Y0DxFdteYNGcbS3IHg31QkO2Dh9g2BflGsfCg4lahPsI1Xa+Tc225k8sgBPOy3v5fNFFt0UsaV2duP21X2U6vMdiUBam+rQyUNRxkyVIxuZvu7kCQ2b0tn2vnARcqOVRk5BMsE+HvJo7g1arSXmB24yNkoqL7orMDEcpUeAPiHHr1llS8VMt+aI/aNk8P0Ogsa44l9nlawuVfbKscRFtuTXi3T8zN26G4GGJxP7+bpQP635sIp/K0UQJHaurrd4JFQjHAYyaW44foiRsnQklPV8hzOyR33OQLtrKneyVxutULeZA4nHPw7Q6UD5mzVXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by SJ0PR84MB2230.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:438::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.8; Sun, 7 Jun 2026
 16:47:35 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.21.0113.006; Sun, 7 Jun 2026
 16:47:34 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Steffen Klassert
	<steffen.klassert@secunet.com>
CC: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: [PATCH ipsec] xfrm: use compat translator only for u64 alignment
 mismatch
Thread-Topic: [PATCH ipsec] xfrm: use compat translator only for u64 alignment
 mismatch
Thread-Index: AQHc9p1XvV+Ok45NEkeZDq7ky11VOQ==
Date: Sun, 7 Jun 2026 16:47:34 +0000
Message-ID: <20260607164726.1544435-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|SJ0PR84MB2230:EE_
x-ms-office365-filtering-correlation-id: 330dfca1-7e19-4d59-70b9-08dec4b479b3
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099006|5023799004|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: qJ1Jqq7KOIy5bAgoeIo04yAwPh/ANaBcbAgMl0a9JbugV1DS1vekb0JEQ4xPdPdpwztniUlIQxM0F+48sEJhSJmEev06rjDa6mIETloddaWGmdpDkslwF5pYbR3iuIj0xE/5x3o6kSjjGt8Jcq9qzlw6KNU8IWoZ1ZxeZC/tGH+VdCTXbL5d5zMWA6lL72GmFdqtpKiuUyF5CXqBgIW+Ys1I5obunKcyOgoVsZraeFGeF5cpcoJNVtVpdhEx+UeZ6aJFpwNmRZ3oWcMBDSP/lylCNmUngOHRV9YzyPKi376IH8f02vz9hu9i4DGd5TO8uNRwaWyePj1lGoruA0mOTX/f63SyF7UOndY4jLUnd2MkYYcPQQ1MKAQIHWTVfozqnU29qmf1p3HO8h1YSyEhK8WAXgeqTeAaZkpvh2FXd4C94+xNejcbMGsgc8MsrxZhmeOnkyf5ylVYogvd7MTkpA1WrYPKeoUWFl4MOF6jVhgQf6dkH3RufV3CUlubgLdiaKh0OvGXpEYo7IDbYZ8pG2jyzUJeuPMW4bcCjLBINaDxKbwExLRPNgA1oxlvwM8xt4zWM7uNuTON8cVFhjRsJvIoCpnNm2kdRed1Qb/JnO9br5g9UV4vyrLchXuAGfBDOGUe7dMlI/boXjbAvljRLl0yA4UoSTNTvY5tbt7jEPx0Dn5jkrv2vjFwg8RWPId3vqqbQyAWnd1ZVEzwbdKMErLfkNyBaFUXPTFj40GvJ3bG5hA+vpPPNoafNrH7aW1W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(5023799004)(6133799003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXFNRTJ2ZTNOVlU3alhuQzZvQk5oL3g0dlRkZWc3VkRXSk91ZTV1VWV4NytF?=
 =?utf-8?B?UHJUbTNuZkFGRzY2OFlmRDRCMEpZN2kxbU5kdGZPV21lS0paWU9qZkhBMmda?=
 =?utf-8?B?Q2d5RGhKbCtBODZaZm1COTBvVWtRa3Z2TjNDbEV5aGM5d2R5eE1XM3N3RW9F?=
 =?utf-8?B?UkxqLzA3NWxheVR3T1lVN1g0R1pRSlNmcFd5WU5ES1lBOHFaMzBMak5iSFBL?=
 =?utf-8?B?RG9FQ3NJTGM0ZlhKWUpOWUZId2w3d1Y5ZWhDVW1YYWpGMTdHOEtSNHI4cXJp?=
 =?utf-8?B?cUt0aGo1OXlITm14N2M1UlUyaWNmYXNld2pqUzBqSlFKaGRzMU5pdlBLd3cv?=
 =?utf-8?B?UjJUNVBHektCREhVUTFuRTB6dUdTQno1RURBOUdOTXZmR0hYUmZsMVlEQ1pL?=
 =?utf-8?B?L0NBaHVmeitEaDdFVnpKcnZvMmJyRzJ2WlhHRW5nblpnZ0hQVXc3bC9zTHI1?=
 =?utf-8?B?bUpLdkI1Q01ML0xtYlJwRGlpUW5keDNwRkVuZjBjMVAzR3JINnhzRjcxeldu?=
 =?utf-8?B?QTF1akdVZW5HbjAwQnorazBHc3hhTVc5YkRLMXRJYVgxOGxjMzEvWnNnYkNw?=
 =?utf-8?B?Ui84OUMwMHp1VnVyUWI5dzJUZStJT21Kb25hbU5hcUJyVkxkZlNodnd4U0lm?=
 =?utf-8?B?dERSNnQ1RlcrYk1DRlcrL1ozSXY0V09aNXZKdmMxNTJMS2xEUnBEOXgya0tp?=
 =?utf-8?B?eHlZRG1qV0pNTlIxQ1NMbnBOcGZ6MDlES1dHclF1ODZuWFBVTDg5cWFhNGNW?=
 =?utf-8?B?V0hrdVdoS3pCdW9McEF5amtBZ0ZEWmtPZGZSTEhLZ1YrL3VBNDZwa1lrWGlq?=
 =?utf-8?B?dzFsRGtnK1Irc1o3Z1Z1V3V2WG56VjVnRTZMcTI4TXBxVjkyck0rWWVUNVVV?=
 =?utf-8?B?aWx3ZDdGMFN6OHg5ZDRWMDl3ay9rQTZaQjk4R0ZmSk5QTG1oRlRvQkN3UDNO?=
 =?utf-8?B?ZW5ieVhtT0lzemdwYVZNYzYyQklyRWJrYWJmS3hxK1RRL1BRM1RMNmlnaGJh?=
 =?utf-8?B?Mk1RWkpobXhab0tFeDlwVnlHd3BKWHNPSVFDYUI1anpONzRhdFhaMkF4U3ZR?=
 =?utf-8?B?MG13bGdrT1lMWTR5eENpYll6d2xwMm4yWVVVRCt4SFhqSU96eC9EOWZOZmtw?=
 =?utf-8?B?Y3psMTZuZUl1eW1rWFdTRlppaFRRYnhXd1NydStTREN0Y2YzbW01bjZueUZQ?=
 =?utf-8?B?SXdWcnV5eDlPZUFzYk1JclY5d0xVVmZpeW9UMzQ4MDdGaEhNSXFobXNCTVVp?=
 =?utf-8?B?Tk1TZ0pNSjhnK0lHUk1wZjVlL2pJSVp3b1FtcFFYcDA1T1haVEdLd0lidHp2?=
 =?utf-8?B?MWZFeFZaaWdiazFReDNGNFBNaUtvVkNZbmZ6UXhlYUVaMlJCUnFvek1xTC8z?=
 =?utf-8?B?WFJLRERUa2NzY2E5V2ZES3N6Smo0d3BPeGpwSHBCR0NvcXpMU3VtQVBkWmxF?=
 =?utf-8?B?aGhzbDJPMDJtVDVwYzdtMUtPNW0vR3FuZm55d1ppYUs5UTJ5ZXM3RVlsWWNy?=
 =?utf-8?B?Tm84OGxiMWpPeFVwa09HVVZ4dTB5UmtYc1gvMWpGME5vWDFqalhTSkVBTFk4?=
 =?utf-8?B?ZFpXTGtwRll6RmdJWmNZbEU2L0Z0MFJaOTZoSGlocnNkQytEQmdxZWlmTUpY?=
 =?utf-8?B?enBYaitIV3pWV3pMZUZPVXZ3WDVrbm9wODlXR3F3b21UNmVUVUJBd2VKVWVL?=
 =?utf-8?B?ZWljalRDV2FMekJHVWRaU2Vka09keWZwWDFXdzJRQW8zNkgxWEpMWTk5bTNV?=
 =?utf-8?B?dnRlYm1MM1FLWXpmL3hxb3g0ZFhZMTdWaDdDUWFwSTZqckRxSjNLV0VISUVT?=
 =?utf-8?B?R3VlUFczcFlvZWJoaVJJWU9QVVlZblM0Wkc3VnFNU29CVVYyUDU3R0tNejhk?=
 =?utf-8?B?WFB6dnZXWERGZVFiOHNWODR4TDVJREtPc21xRWlvMisrZWdjWjRDOU8xanB2?=
 =?utf-8?B?dmFoRDJlS2dSWlphM3cxRGF2SnREZnZTMEM5RFNaZEFnV0ZLV0FyRURtMFBo?=
 =?utf-8?B?RG11aUxEUTBJRlNGeXN1NFc1OVJwUXNzWHp4SmIvZUJzMm13QmdkRldyME94?=
 =?utf-8?B?RkhKV25Td2JCcjZONUE0K3BrdHdrNTIrZjdiMlhKWEY4VmdVUmFwbEtvWGRP?=
 =?utf-8?B?Q2h4NHB0TnVzczhvSEFCaFYvVjI0aXQ2NUp4eFhmSFRhWTJYaXZJQURQcC95?=
 =?utf-8?B?MklGbmxxT0M4Zk5GbHJ3UXNjUFlreitpeWhwMDVJcjhmTENMc0RhTnIxTm1L?=
 =?utf-8?B?L0hSa3VSc21vZ2s5ZU9LTjNQVklkNGhqQ2FFL0UrRWVMVklZSWY3RXZQNG1x?=
 =?utf-8?B?WThjenVoNDBlUEVvY05Qb1pWdXpwOVdaMnRHalIvNGlFQktQb05NQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GOwSUNQDrsg6DaL+gj0k0Ta09scqS3BXX8ifeIF5nR48uEeWVjbokYPecXx2KSsfXQXSDC7ft0MvBT2+5V0v2tzWyvMlb3aLMlLODir37y0GvMIQgEnd60YkaGBiavBOtIql+EaL5Rege7g/QCLCHgVo+tY8iuY3H2pP+HBd/6/sObwF7dKqP7C2zcDlo3JMDombhYixtLqM+31hU0/fG5Ufw19HdwME7sstRGU9g10R/W1Kw5bevQNrntnKkaEct69AR5t9T4Op3QT2hiYar3TMCf5sVcCMIu8Cg/iUrdq3grzqKf48gpdOKx/Ye2QK6fih4+z1Ih8STMXctX9osQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 330dfca1-7e19-4d59-70b9-08dec4b479b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 16:47:34.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntEYE23owKkCRWC0P5Ywy5qmWgGJmQEHfrX2HVHz0HIMGu7dOQokMdw+TbseGBtyVsHwDHBe2pCvxSahlpu2wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB2230
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a25a0ac cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=DUwEP6uyuKNJ1rOH_5cA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2NyBTYWx0ZWRfX8Pbs8xUpWWaF
 MM8RnbFWErf0lRr05Qlp+yeJ9wL3IUkGmnrOYV0ChEGJjKunuUpwAKq7hFHiNhCOzphyxAsAbBb
 NTlMO4SU3gxi3a3A3wHOrXcrowYdAoq6UMoOmWVtpLBdT32BRRfrCb8ui77BPFAK9homMNWuu8b
 RtS0oYgU9sNcf51e/ACk453NWC+lSTLgNS8/9oespH3XzHq8lvw/Uh+MIThjWXH+SpBgEEQD11C
 zht8B4UtRTJfjU6Q7iKpVLzXm2wF5pCXuqHdCvw+Tc/3GPB0oTS/l66GFDc7bOrB3GtAoLn6oiw
 E9zWGcH9g66mTtVxfxkjJGs0oFqnjmLZo7Cf65L5nyXU6zKe2tN6anXWby0gQ9E6bnRXKZ8WIX6
 s/zSyzJRf7e8O9ypYXUhBoedPkL2xFdDRh0IfQhZCKWt08k4Jf7gGm75m7fIVR2adZQ2plmuGqT
 h9jEw6vMd6lZ/Mlzu6g==
X-Proofpoint-ORIG-GUID: HeOJYoHpZFWQNf1mys8Q0rx76QgPuYDN
X-Proofpoint-GUID: HeOJYoHpZFWQNf1mys8Q0rx76QgPuYDN
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070167

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpUaGUgWEZSTSBjb21w
YXQgbGF5ZXIgKENPTkZJR19YRlJNX1VTRVJfQ09NUEFUKSB0cmFuc2xhdGVzIDMyLWJpdCB4ZnJt
Cm5ldGxpbmsgYW5kIHNldHNvY2tvcHQgbWVzc2FnZXMgaW50byB0aGUgbmF0aXZlIDY0LWJpdCBs
YXlvdXQuIEl0IGlzCm9ubHkgbmVlZGVkIG9uIGFyY2hpdGVjdHVyZXMgd2hlcmUgdGhlIDMyLWJp
dCBhbmQgNjQtYml0IEFCSXMgZGlzYWdyZWUKb24gdTY0IGFsaWdubWVudCwgd2hpY2ggdGhlIGtl
cm5lbCBlbmNvZGVzIGFzIENPTVBBVF9GT1JfVTY0X0FMSUdOTUVOVC4KClRoYXQgc3ltYm9sIGlz
IGRlZmluZWQgb25seSBieSBhcmNoL3g4Ni4gWEZSTV9VU0VSX0NPTVBBVCBkZXBlbmRzIG9uIGl0
LApzbyB0aGUgdHJhbnNsYXRvciBjYW4gbmV2ZXIgYmUgYnVpbHQgb24gYW55IG90aGVyIGFyY2hp
dGVjdHVyZSwKaW5jbHVkaW5nIGFybTY0LCB3aGljaCBzdGlsbCBwcm92aWRlcyBhIDMyLWJpdCBj
b21wYXQgQUJJIChDT05GSUdfQ09NUEFUKQpmb3IgQUFyY2gzMiBFTDAgdXNlcnNwYWNlLiBPbiBh
cm02NCB0aGUgQUFyY2gzMiBFQUJJIGFscmVhZHkgYWxpZ25zIHU2NAp0byA4IGJ5dGVzLCBpZGVu
dGljYWwgdG8gdGhlIEFBcmNoNjQgQUJJLCBzbyBubyB0cmFuc2xhdGlvbiBpcyByZXF1aXJlZAph
bmQgdGhlIG5hdGl2ZSBjb2RlIHBhdGggaXMgY29ycmVjdCBmb3IgMzItYml0IHRhc2tzLgoKSG93
ZXZlciwgeGZybV91c2VyX3Jjdl9tc2coKSBhbmQgeGZybV91c2VyX3BvbGljeSgpIGdhdGUgb24K
aW5fY29tcGF0X3N5c2NhbGwoKSBhbG9uZSBhbmQgdGhlbiBjYWxsIHhmcm1fZ2V0X3RyYW5zbGF0
b3IoKSwgd2hpY2gKcmV0dXJucyBOVUxMIHdoZW4gbm8gdHJhbnNsYXRvciBpcyByZWdpc3RlcmVk
LiBPbiBhcm02NCB0aGF0IGlzIGFsd2F5cwp0aGUgY2FzZSwgc28gZXZlcnkgeGZybSBuZXRsaW5r
IG1lc3NhZ2UgYW5kIHRoZSBYRlJNX1BPTElDWSBzZXRzb2Nrb3B0Cmlzc3VlZCBieSBhIDMyLWJp
dCB0YXNrIHJldHVybnMgLUVPUE5PVFNVUFAuIEEgMzItYml0IHVzZXJzcGFjZSBwcm9jZXNzCm9u
IGFybTY0IChhbmQgb24gYW55IG90aGVyIGFyY2ggd2l0aCBDT05GSUdfQ09NUEFUIGJ1dCB3aXRo
b3V0CkNPTVBBVF9GT1JfVTY0X0FMSUdOTUVOVCkgdGhlcmVmb3JlIGNhbm5vdCBjb25maWd1cmUg
WEZSTSBzdGF0ZSBvcgpwb2xpY3kgdGhyb3VnaCB0aGUgWEZSTV9VU0VSIG5ldGxpbmsgQVBJLCBh
bmQgY2Fubm90IHVzZSB0aGUgWEZSTV9QT0xJQ1kKc2V0c29ja29wdCBwYXRoLCBiZWNhdXNlIGJv
dGggZmFpbCBiZWZvcmUgcmVhY2hpbmcgdGhlIG5hdGl2ZSBwYXJzZXIuCgpUaGUgdHJhbnNsYXRv
ciBzZXJpZXMgcmVwbGFjZWQgdGhlIGJsYW5rZXQgY29tcGF0IHJlamVjdGlvbiB3aXRoIGEKdHJh
bnNsYXRvciBsb29rdXAuIFRoYXQgbWFkZSB0aGUgcGF0aCB1c2FibGUgb24geDg2IHdoZW4gdGhl
IHRyYW5zbGF0b3IKaXMgYXZhaWxhYmxlLCBidXQgbGVmdCBhcmNoaXRlY3R1cmVzIHRoYXQgY2Fu
bm90IGJ1aWxkIHRoZSB0cmFuc2xhdG9yCnBlcm1hbmVudGx5IHJlamVjdGVkIGV2ZW4gd2hlbiB0
aGVpciBjb21wYXQgbGF5b3V0IGFscmVhZHkgbWF0Y2hlcyB0aGUKbmF0aXZlIGxheW91dC4gTGV0
IHRob3NlIGFyY2hpdGVjdHVyZXMgdXNlIHRoZSBuYXRpdmUgcGFyc2VyIGluc3RlYWQuCgpHYXRl
IHRoZSB0cmFuc2xhdG9yIHJlcXVpcmVtZW50IG9uIENPTVBBVF9GT1JfVTY0X0FMSUdOTUVOVCBp
bnN0ZWFkIG9mCm9uIGluX2NvbXBhdF9zeXNjYWxsKCkgYWxvbmUuIEdhdGluZyBvbiB0aGUgQUJJ
IHByb3BlcnR5IHJhdGhlciB0aGFuIG9uCkNPTkZJR19YRlJNX1VTRVJfQ09NUEFUIGlzIGRlbGli
ZXJhdGU6IG9uIHg4NiB3aXRoIElBMzJfRU1VTEFUSU9OPXkgYnV0ClhGUk1fVVNFUl9DT01QQVQ9
biwgYSAzMi1iaXQgdGFzayBtdXN0IHN0aWxsIGJlIHJlamVjdGVkIHJhdGhlciB0aGFuCnJvdXRl
ZCB0aHJvdWdoIHRoZSBuYXRpdmUgcGFyc2VyLCB3aGljaCB3b3VsZCBtaXNyZWFkIGdlbnVpbmVs
eQo0LWJ5dGUtYWxpZ25lZCB4ODYtMzIgbWVzc2FnZXMuIENPTVBBVF9GT1JfVTY0X0FMSUdOTUVO
VCBpcyB0aGUgQUJJCnByb3BlcnR5IHRoYXQgbWFrZXMgdGhlIFhGUk0gdHJhbnNsYXRvciBtYW5k
YXRvcnkuCgpPbmx5IHRoZSByZWNlaXZlL2lucHV0IGRpcmVjdGlvbiBuZWVkcyB0aGUgZ3VhcmQu
IFRoZSBzZW5kLCBkdW1wIGFuZApub3RpZmljYXRpb24gcGF0aHMgYWxyZWFkeSBjYWxsIHRoZSB0
cmFuc2xhdG9yIGFzICJpZiAoeHRyKSB7IC4uLiB9Igp3aXRoIG5vIGVycm9yIG9uIE5VTEwsIHNv
IG9uIGFyY2hlcyB3aXRob3V0IGEgdHJhbnNsYXRvciB0aGV5IG5vLW9wIGFuZAp0aGUga2VybmVs
IGVtaXRzIG5hdGl2ZSA2NC1iaXQtbGF5b3V0IG1lc3NhZ2VzLCB3aGljaCBpcyB3aGF0IGFuIEFB
cmNoMzIKdGFzayBleHBlY3RzLgoKVGVzdGVkIG9uIEp1bmlwZXIgU1JYIGhhcmR3YXJlOiB3aXRo
IHRoZSBmaXgsIDMyLWJpdCBJUHNlYyB1c2Vyc3BhY2UKbmV0bGluayBhbmQgWEZSTV9QT0xJQ1kg
c2V0c29ja29wdCBvcGVyYXRpb25zIHRoYXQgcHJldmlvdXNseSBmYWlsZWQKd2l0aCAtRU9QTk9U
U1VQUCBub3cgc3VjY2VlZDsgeDg2IGJlaGF2aW91ciBpcyB1bmNoYW5nZWQgYnkgaW5zcGVjdGlv
bi4KCkZpeGVzOiA1MTA2ZjRhOGFjZmYgKCJ4ZnJtL2NvbXBhdDogQWRkIDMyPT42NC1iaXQgbWVz
c2FnZXMgdHJhbnNsYXRvciIpCkZpeGVzOiA5NjM5MmVlNWExM2IgKCJ4ZnJtL2NvbXBhdDogVHJh
bnNsYXRlIDMyLWJpdCB1c2VyX3BvbGljeSBmcm9tIHNvY2twdHIiKQpDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBTYW5tYW4gUHJhZGhhbiA8cHNhbm1hbkBqdW5pcGVy
Lm5ldD4KLS0tCiBuZXQveGZybS94ZnJtX3N0YXRlLmMgfCAyICstCiBuZXQveGZybS94ZnJtX3Vz
ZXIuYyAgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9uZXQveGZybS94ZnJtX3N0YXRlLmMgYi9uZXQveGZybS94ZnJt
X3N0YXRlLmMKaW5kZXggNTg5YzNiNmU0Njc5Li5kODQ1N2NlYWYyOGMgMTAwNjQ0Ci0tLSBhL25l
dC94ZnJtL3hmcm1fc3RhdGUuYworKysgYi9uZXQveGZybS94ZnJtX3N0YXRlLmMKQEAgLTI5NzYs
NyArMjk3Niw3IEBAIGludCB4ZnJtX3VzZXJfcG9saWN5KHN0cnVjdCBzb2NrICpzaywgaW50IG9w
dG5hbWUsIHNvY2twdHJfdCBvcHR2YWwsIGludCBvcHRsZW4pCiAJaWYgKElTX0VSUihkYXRhKSkK
IAkJcmV0dXJuIFBUUl9FUlIoZGF0YSk7CiAKLQlpZiAoaW5fY29tcGF0X3N5c2NhbGwoKSkgewor
CWlmIChJU19FTkFCTEVEKENPTkZJR19DT01QQVRfRk9SX1U2NF9BTElHTk1FTlQpICYmIGluX2Nv
bXBhdF9zeXNjYWxsKCkpIHsKIAkJc3RydWN0IHhmcm1fdHJhbnNsYXRvciAqeHRyID0geGZybV9n
ZXRfdHJhbnNsYXRvcigpOwogCiAJCWlmICgheHRyKSB7CmRpZmYgLS1naXQgYS9uZXQveGZybS94
ZnJtX3VzZXIuYyBiL25ldC94ZnJtL3hmcm1fdXNlci5jCmluZGV4IDcxYTRiNzI3OGViYS4uM2Ix
Y2YyOWJjNDAyIDEwMDY0NAotLS0gYS9uZXQveGZybS94ZnJtX3VzZXIuYworKysgYi9uZXQveGZy
bS94ZnJtX3VzZXIuYwpAQCAtMzQ3Miw3ICszNDcyLDcgQEAgc3RhdGljIGludCB4ZnJtX3VzZXJf
cmN2X21zZyhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm5saCwKIAlpZiAo
IW5ldGxpbmtfbmV0X2NhcGFibGUoc2tiLCBDQVBfTkVUX0FETUlOKSkKIAkJcmV0dXJuIC1FUEVS
TTsKIAotCWlmIChpbl9jb21wYXRfc3lzY2FsbCgpKSB7CisJaWYgKElTX0VOQUJMRUQoQ09ORklH
X0NPTVBBVF9GT1JfVTY0X0FMSUdOTUVOVCkgJiYgaW5fY29tcGF0X3N5c2NhbGwoKSkgewogCQlz
dHJ1Y3QgeGZybV90cmFuc2xhdG9yICp4dHIgPSB4ZnJtX2dldF90cmFuc2xhdG9yKCk7CiAKIAkJ
aWYgKCF4dHIpCgpiYXNlLWNvbW1pdDogN2YyZDc2YzljMDMyNTdjMDc4MmFmZWY5ZDk1MzIxZmEw
NDA5NmY2MAotLSAKMi4zNC4xCgo=
