Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888670;
	b=jfGpZLzbiSmqNOMosDce3q1yvgtWp9nC2jeeOuqgtXceAvfNm1sCVqRTgOm1oL1F3yrY
	 gtYnq0jXsOlxE0J9VWDdx9vXjxCdMiPpVHzWFmIUmnV+qkoThez6BRXT34dNbSaL4BkZX
	 YobHfVLqtXuxlsX9EWMxeaHjbFFbVXRtLdARIWxNs7VCuOp7qK8wMQCFmWwhapmBYtiDj
	 D1B/8AzM8Xws4A103+M+nheN5tN2zkfGS64tUf1IGmokNCyaFS/PevIl3+5U2W8I0q5iq
	 47fMltozxSN/2PByzP858rfPo8pRJuiwUGns7xHfghL+M1F2pk66p7ThCB/fG4FOIrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888670;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3pR499vXDlupy9Rr2kVHKnMu83WlKLtBcWcm8dQVLJk=;
	b=MnNc4acM8yTNwJ2rLEjV+0zUG6lkR5VHmiVlxRIpgsIdf2MMyM+mQAnomVLC9O0P1zr7
	 1hVKCliMU6YQyb4/Xr0IAJkYDp1aBotsw26S+4KJxIvXGReli4EZrFWT38T4ul7T6+nSq
	 pNpc4v0EGS96mfXXygYK9dvegWcICOF5G02K026q99s3lN/FCRi0rM6YSO0/W4do6qfDs
	 LMldCY+4vJRx5ctBX99XWGi4Y4MR73J1Ck3eqZrcnMTiCW6yzwUKwZotezOiPzg0iquTw
	 8ADZjnLcFoP65izqA7bawL6m+QHeFO9hGrjexTQ29YfvoRVJdKSAFlkkmRECFBhY8cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ITQ8Bo1e;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=MpWvttNH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7D606A31B;
	Thu,  5 Nov 2026 14:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71B7D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ITQ8Bo1e;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=MpWvttNH
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A5Diats2635303;
	Thu, 5 Nov 2026 08:24:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3pR499vXDlupy9Rr2kVHKnMu83WlKLtBcWcm8dQVL
	Jk=; b=ITQ8Bo1eh2W6l9eKvdrJaI1VRHLPANgYkNNjFtwFA+U898GVJiTjYxUNt
	G+yhwfcBnOQANWUst/Mm41OYaC+G2pSJTjtjM/ljFLtGuuQdZkt67Pke0+os673R
	ocwYb/izoLDHnCArf1Ua7cmNpA4GMAM7R1zPbn7jueNsoOx/ht4IVYaI58cVwJPs
	5UsGOZmTfHaSLFgFGAIDlRior9d80vC8zHPAgWihLd7evmRDan++Yzk8t4uE18NZ
	mumTQsMFE57ZA6xhbZJgjsrEV/khmnfqS9UaNVPvjWrkzGdquTxIL0SOgwdHzJMU
	eNaHcq7IxbzyDOVenpGgM720ZqdKg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hrgp9m3aw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 08:24:17 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAKodsy/flvQIGsJcadq5rzaCxq7a6hx6donnFa4vyFLHzOoAtxFsOzbSoAGE8hJQv36rLxMtLeR1Zo0YtnHU3Ge8RxN15CeOvziC8sotmqaHmBW0JiSUGMR5j47LavbQgbZRYczS7lnYemHSdIm0BJ6uxkeApVmhd6Ok/qfuod/5l0QRtpoUgCgzDlXlS03l33nX/JC9oNl7YiM4/QiLdOwkVoRP5iVe1kw1ibWkV02BHjUwAVUdwwbroimppogLaCYuR2ZdKSWtzkz3nOa2ZTLxEy4vxQjUDYu8Dago/NN/QEeBQgdocYrIoi4ku+lbsjtZ+YqQJfRvvqw6x9hyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pR499vXDlupy9Rr2kVHKnMu83WlKLtBcWcm8dQVLJk=;
 b=vqXifobO1n/FQj6oCTHi0RCUDMc6FOPnHyVCGOsXGP8fSXyrZxZxH+hm7HHEl9EroJpJ0VPmBhoWGuTpEEFYTVnwIXSRQ2OL7buoPD3S3PN+hZgT5r24W8nUM6XvW00uf5FGTKomsWRNPlr4p6Z/FOH5ERRzJVVONnAgr2KsCt8+2gggYrLkD1L5e0b38vxMeY38m5N4yqj2ZW9fHd46lARB00IupOyoOfB//8SQMzIA0X8PmUARWrlruThtrfTRTbxVCDmj1vb9/2ZWxXz7JSzi+yk1RH5zpf+VIrHO9xUu+0/MA5cMKz1OKf71VT154apbItFy4suxFu3M5DVCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pR499vXDlupy9Rr2kVHKnMu83WlKLtBcWcm8dQVLJk=;
 b=MpWvttNH8Njc/m2GGJMh1sPsG4eyYIeObRfKvq4OO4y4Y444CNFSU2LukBYlptLrmB+vc/WL0VmpM8N6KlNdHq4wJ+hqC083NsevjCWb8lPnHyjgWVdlGDe/x6mPlz4t//E2lgu0HxLyZ9AyPO/9DjMkNgQsrsYABFZn3yy9LQg=
Received: from BN8PR10MB3652.namprd10.prod.outlook.com (2603:10b6:408:ba::10)
 by DS0PR10MB6701.namprd10.prod.outlook.com (2603:10b6:8:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:24:13 +0000
Received: from BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a]) by BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:24:13 +0000
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: Wentao Liang <vulab@iscas.ac.cn>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] media: imagination: Release m2m device on probe failure
Thread-Topic: [PATCH] media: imagination: Release m2m device on probe failure
Thread-Index: AQHda3grcLBavCwS70uSS1/GIj0877cfi7cA
Date: Thu, 5 Nov 2026 14:24:13 +0000
Message-ID: <d1cce550-6d23-48d7-8ef5-cc5103d52804@ti.com>
References: <20261103094617.1289402-1-vulab@iscas.ac.cn>
In-Reply-To: <20261103094617.1289402-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR10MB3652:EE_|DS0PR10MB6701:EE_
x-ms-office365-filtering-correlation-id: 8b5e54d0-36b0-4db5-d9b0-08df3b48777d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|261022105027099003|56012099006|261021123027099003|261021135927099003|261026140227099003|261022115727099003|261022075727099003|261009223027099003|261021121427099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 SUjiDSCa/iMTW0ilIdnUOUe2piPf6z/V9rT9NRNVHqkaecPSILj/rCtStS6q977XqfpPlyDHTR0DL8LCpoP+IZWZ3f6xMMUACm6yIzb8+/rwZAIepIHDSzIryMEtB4l0q24pAPdCPEP+CSGs1Vhynzx32FPVjCa6U38uRPvXW4uq9Ow45t0VXB9TdaFvhKei8pAuD9xk9caqltZjH1+zGHqY1s1COj9qm7/C0OsE3eIZZHPN5xuZNMzhDaMznUFnHHddvRbmoDg6OiE87vBnNBI61cd6Gm1/daArXa1WxPMOO2AGInvfA8FxdcbmzHZBOIB0SNwqvBZlZ5iJ7br31y55LIDU4p3bbBgLnNzWkZYcyIBJo0zbGzxLpzV04Hkq9RxHOrzzDwFx5kaOn3w6Or9paR3I+hKe/832wt7J+WQcB88/TJRLlXF1cbWbHpj8EuZzP4m/wcpY8P15nduDIYRQcr/Znn+TnukqZxYZjVhE087LfkOXk0XPMSGX1QRIKkGIIQj8eE9zwSAz9adOM68pWRDTjb6Ez1Ysw8lctDvRj4UZCEZ90v1926yFvDPE3Xc4X5zTscy3M/jEjXdSOlvji0ZlWHEGoce35oefhbcBNWI6k4wf39WdqYMFnexpyrZ9cS+3COGi8plOPxY0fviQePOFDoRH/yhm1gxEjiw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3652.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(261022105027099003)(56012099006)(261021123027099003)(261021135927099003)(261026140227099003)(261022115727099003)(261022075727099003)(261009223027099003)(261021121427099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3cxT0poV2ZYQkdFRWpaNy9pT2hzNVExSEFHZ1FhVnRtb1pia2w3bEdBOUlJ?=
 =?utf-8?B?SjVLa1hPY2dzb3RRelg5OGxoWndZalgyK1RMbmF0T3VmbGdrUXlRT1BUMWNk?=
 =?utf-8?B?aDJVbTkvS1lVUGV1R3RjcjVCSHloRmpUNTB4WkhER21XMWV0TVJIdU9YcEVR?=
 =?utf-8?B?VXJyTWpIb01qbEYzUGlhb2F4RGdLYWNzZmRJeE5mcHp5REczeEErNU42Ykov?=
 =?utf-8?B?aHYwblljUGlVTXo1bXZBT1UvRWtLVERMeVc0K25MbGNYL0owL3p4b2poRk45?=
 =?utf-8?B?cEk5NFMxY210d29LcDMyUUNPcEw2MG1oU0p1WkhQdXFVcDdwUEJES2ExNHZ0?=
 =?utf-8?B?WjF2UkUzeFNpazJTaWxmZGxoWWVteWlSTjZLa0dlNm5mMVlJaXdjVjBDNEZN?=
 =?utf-8?B?RUN0S0dybVJFNUxRQmovazN1TFhsL2hvWTBYMllDeitpSFRkd1ZIcFpPYWhI?=
 =?utf-8?B?UmUwbmtLaGZycEJOZ2I0ZVpTWnJ4UjlxYkNrbHZNdUpCM0dYczBqYVBzZmJ4?=
 =?utf-8?B?TEp0QTRXUVJvbG5mL0FoaGN1TktJVWdyL05Kb2dJcy94N1JIMVVFTmRvVVhQ?=
 =?utf-8?B?ZXpLaDJxaWNwSUhDb1VwbHBZVHJ5VTllVXhOdm5UbVRhNVhpRnpDbzRIMnly?=
 =?utf-8?B?NGZvUWZzM29lNFV0RS9yQ0xJajd0emJkcG0xS3VGYTBQU2RSTDdKS0pPbm1t?=
 =?utf-8?B?YWJRWElEVFNjVll5cnMwRnNpM2drNnFPQkUwSGI2OXl5dWF5MGFSQ2tDSUQz?=
 =?utf-8?B?czk4UEw1dUtyYmdKUll0RmMvdVl3d2FXazZ6NlJDbWpsYU43Uk9SZFdIU0Yw?=
 =?utf-8?B?TlRHVkloemFlNW5HSG40TkpWbXVOZk9RVWNCTEQ2bXJYS2VwbUFUWXVvYTVW?=
 =?utf-8?B?TDV2OVFaS2dWTVdMdVNobndDWFZobkdpMDAwallId1F3bFNCU1YwQjUrTGds?=
 =?utf-8?B?aUFjMWhaSVNJSVpmK2oxeXE4MEI4MlMrZVVaMmgwc0g3aHN1eFN6K3BTaVAx?=
 =?utf-8?B?VDE5U3duMFdMRXoxSUFjVUMybzVkRmhvSEdDTjdmbWtpeDROUGhibERTdk5u?=
 =?utf-8?B?a2k5U1JDRWFkRkpKYTgxRHpyR1NnekxmMzE0bTM4T05VMXFDQWFab0c5cWtq?=
 =?utf-8?B?RTJia01CNG9YTGJ5QVRPcXN0UEd0OHBaektQcUt1MVN4MXNMYzJLUEh1cEc1?=
 =?utf-8?B?Q0NXVUF6aVIxT2N2R2cwQVVsVXFoa093ZkszRmFYWVVkbEJTTUJnS0lnUnUx?=
 =?utf-8?B?WEVnMnp3NStLOGtra2lZVUU1YWJpY2lIVFJmODhTYzdVWkdxUktaL2p0M2d4?=
 =?utf-8?B?b0s2ZUs1bTlOdTJOZWp0c1Azd3liZzVseWt0NElNbGlNN3QyL0QvUFJPNTRO?=
 =?utf-8?B?SVJnTHRQdUVHczFFRUNERjczMTdGYXNzcXVXV0ZjTWFMQ2NwUmt6QXc3SDV6?=
 =?utf-8?B?ZjV4TGNObFdzSGpaSnQ2K0tlT3lhZldxRmg0Sm14QW5kOWs5MGhwWHV6NkdX?=
 =?utf-8?B?ZFc5SDMzTUdna3ZZai9xdWxwa3FLbGFtTElrTFBpS1NZc09KVmExaE5Rbkt0?=
 =?utf-8?B?VE4rZDBYUUF0cnVtRjlkZVEvQThKUm9IaWVncWw5YmhSYk90VVVFdkkxWmFz?=
 =?utf-8?B?SFllbEI4K2g3RE1hVzhtY2tpWWxpUGl0VTlQSFhwTmN1WVVSaitndlk1cGNG?=
 =?utf-8?B?VFVMMEtmNExrclg3YzZtaU1NK3hNUDdWSU8zaUNGSnBZUlBDeENPc0s5RUVL?=
 =?utf-8?B?QUFVdUtOeFJYQmM3c0J2RVlTQ2pLV0RVejkwd001R0hHQkd2a3IxWWlxSEhq?=
 =?utf-8?B?Y2EzcmxYZ2lFb3hnZElXenhZMEFlenBjU2ZIUklueVlidUIzaG91Ym5UTnpJ?=
 =?utf-8?B?YVpBT3JYS0ZqL2N6bEI1bVB5Rzk2V21EZVowaDAvdkZ0N2xYay9XTnJRR0E2?=
 =?utf-8?B?b0NrbWQvVTRyd0hZWFg3YXB2cm5Ub2VXeWsxVzVROG1xd0VkYzI5NHMzb0c1?=
 =?utf-8?B?VkxKWHQ0bCt2WE1adjhCMVV0L0JSVzFobWN6V212Tk03Nk1oUEF3TlV3cEtC?=
 =?utf-8?B?ek5leVNJZG4wTW1HcU1MdEVBUlNqVGJpL3B3akNSV0p0eVRMbm9qQ2J2d1Mv?=
 =?utf-8?B?YVVWY0hYeWQzZHpJODdYeFZDZW1LYmJoREVrbzR1bXlTN3p5NkxEQlZBV2M5?=
 =?utf-8?B?WWcreG9aNXZnVk10VVNMWnVBUVJHUjdlZkp6SDc5TG0zZ3lmZTdMTC9jc1Rz?=
 =?utf-8?B?MVlkRm9scnVZTXY5QllOS0JkNnJ5RGwyczI4NlRKNENDYVhYU3JjZDd1UmZs?=
 =?utf-8?Q?qgb8DUY/nx6U0pA4ml?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <034F93671CCD404E930B02007FCD0873@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
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
	HObfODWJtocM852pZF0j5WAzZfSPzyYu/2SbolInM0VQomHeSdhjVN3fta2/uxA7YF9vZ5DLlfOnsFOAXjGNEJQAZTrgfdVSGxRsoulTqtjWv4N2XPxUmZVnFVYZVGWTX+Argpv/lQgrQLij9DREeQDKt8qcKBbLqBDNeJydu/d5zm2yjz71lJ9uMRDObrIiGiU/jXRpMYsOOOGZHyZGTBzRMAzlnIE0d9R3zpcv/zLCwXGnnViLISwYJ3Lz1M+fDvCLzdjUTH1raMTscuohrKnHzvJ6meIjym6002OyuI5s1vf/lgAPoMoJV+3MCz3RwdE1uyv+Qxn9ZX/AANUAkg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3652.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5e54d0-36b0-4db5-d9b0-08df3b48777d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 14:24:13.7500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oIXWjzcPiHzJ/TwMio8qKhrbZnBwk4DcyIecidIL8xVhrJXo5Dwh8VOB3mxVrdK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6701
X-Proofpoint-ORIG-GUID: 4k0ON11hE4lhJi82phpAmlZaKY674SJ_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NyBTYWx0ZWRfXxg4VNSMSoAKX
 8mDrDDCM8AcYAOJjOGMbZzjX8vPkEalTUpOMyeY+K/s315OtSxx4fE/HqUQFEuGVcKfzvt2YB4U
 Pv0xoGkwiazaW1qh/4BCZtBSk/zsNbc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NyBTYWx0ZWRfX5hCz2lluSk+u
 Lv8WI8WqIWDaHDjTl+30vYwinCPt0uBUWwEkUqfixFqITMoxVVYCt9xhpovGAI/2RCxUFFKLZaY
 nUf7Se9+l+bNxgrdwQ0WnIYutVrYNiEa4Iv+StsZhAMagmjE0POX1eTQnaFnp71NGN/AShn69af
 QlJ8Rz4/iHrVSxhWig/2Pne2EYeKIp+gxcTGgfmQ73p4yO0eEvnkzkFqnCkoJqwk0AvA8JwxkP6
 3mVMbAJqXuloU8smhgJ0bWwBTaNKpsVtdd5c5G2spm4Hh4XFVHKV2jwaBGxK8D9+c/0GR+x4mLv
 9zyJh7CXjZ7+xycDkBTcpgZz/dibG2I+lPyRBvx6L7/9OrUWjFBtvgjRe+OfIbcagGls4SBkYPF
 T5P7pOBOC1CZIojVQS3e5unL0Ks7TYTwFYXSml5eIzUrK05ehe/gV+dt/hVb+duD922eceytsgT
 HaKa4+8CIUwO0U0lHLQ==
X-Authority-Analysis: v=2.4 cv=D+jSufRj c=1 sm=1 tr=0 ts=6aec9191 cx=c_pps
 a=EaWthEyNNaJ7GkMLLYePaw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=p53652rh8HvrgzQrR6UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4k0ON11hE4lhJi82phpAmlZaKY674SJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050057

SGkgTGlhbmcsDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQpPbiAwMy8xMS8yNiAxNToxNiwg
V2VudGFvIExpYW5nIHdyb3RlOg0KPiBlNTAxMF9wcm9iZSgpIGluaXRpYWxpemVzIHRoZSBtZW0y
bWVtIGRldmljZSBhZnRlciByZWdpc3RlcmluZyB0aGUgdjRsMg0KPiBkZXZpY2UuIFdoZW4gbWFw
cGluZyB0aGUgImNvcmUiIG9yICJtbXUiIHJlZ2lzdGVyIHJlZ2lvbiwgcmVxdWVzdGluZyB0aGUN
Cj4gSVJRIG9yIGdldHRpbmcgdGhlIGNsb2NrIGZhaWxzLCB0aGUgZXJyb3IgcGF0aCBqdW1wcyB0
byB0aGUNCj4gZmFpbF9hZnRlcl92NGwyX3JlZ2lzdGVyIGxhYmVsLCB3aGljaCBvbmx5IHVucmVn
aXN0ZXJzIHRoZSB2NGwyIGRldmljZS4NCj4gVGhlIHY0bDJfbTJtX2RldiBhbGxvY2F0ZWQgYnkg
djRsMl9tMm1faW5pdCgpIGlzIG5vdCByZWxlYXNlZCwgc28gaXQNCj4gbGVha3Mgb24gdGhlc2Ug
cHJvYmUgZmFpbHVyZXMuDQo+IA0KPiBSZWxlYXNlIHRoZSBtMm0gZGV2aWNlIGZyb20gdGhhdCBs
YWJlbCBhcyB3ZWxsLCBzbyB0aGF0IGV2ZXJ5IGVycm9yIHBhdGgNCj4gdGFrZW4gYWZ0ZXIgdjRs
Ml9tMm1faW5pdCgpIHN1Y2NlZWRzIGZyZWVzIGl0LiB2NGwyX20ybV9yZWxlYXNlKCkgYWNjZXB0
cw0KPiBhIE5VTEwgcG9pbnRlciwgc28gdGhlIHY0bDJfbTJtX2luaXQoKSBmYWlsdXJlIHBhdGgg
aXMgdW5hZmZlY3RlZC4NCj4gDQo+IEZpeGVzOiBhMWUyOTQwNDU4ODUgKCJtZWRpYTogaW1hZ2lu
YXRpb246IEFkZCBFNTAxMCBKUEVHIEVuY29kZXIgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQXNzaXN0ZWQtYnk6IERlZXBTZWVrLVY0LjEtRmxhc2ggYW5kIE9wZW5B
SSBDb2RleA0KPiBTaWduZWQtb2ZmLWJ5OiBXZW50YW8gTGlhbmcgPHZ1bGFiQGlzY2FzLmFjLmNu
Pg0KDQpUaGlzIGlzIGZpeGVkIGJ5IGFscmVhZHkgcG9zdGVkIHBhdGNoIFswXSBhbmQgc2VyaWVz
IGlzIHVuZGVyIHJldmlldywgc28NCndvdWxkIHByZWZlciB0byB0YWtlIGZyb20gdGhlcmUuDQoN
ClswXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMDIzMTQ0NjE4LjE2NTIzOTAt
Mi1iLWJybmljaEB0aS5jb20vDQoNClJlZ2FyZHMNCkRldmFyc2g+IC0tLQ0KPiAgZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1qcGVnLWVuYy5jIHwgNSArKy0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEwLWpwZWct
ZW5jLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEwLWpwZWctZW5j
LmMNCj4gaW5kZXggNDIwY2I4YmZkYjEyLi40OTk0M2JkNjA0ZGEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vaW1hZ2luYXRpb24vZTUwMTAtanBlZy1lbmMuYw0KPiArKysg
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEwLWpwZWctZW5jLmMNCj4g
QEAgLTExMDQsNyArMTEwNCw3IEBAIHN0YXRpYyBpbnQgZTUwMTBfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIAlyZXQgPSB2aWRlb19yZWdpc3Rlcl9kZXZpY2UoZTUwMTAt
PnZkZXYsIFZGTF9UWVBFX1ZJREVPLCAwKTsNCj4gIAlpZiAocmV0KSB7DQo+ICAJCWRldl9lcnJf
cHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gcmVnaXN0ZXIgdmlkZW8gZGV2aWNlXG4iKTsNCj4g
LQkJZ290byBmYWlsX2FmdGVyX3ZpZGVvX3JlZ2lzdGVyX2RldmljZTsNCj4gKwkJZ290byBmYWls
X2FmdGVyX3Y0bDJfcmVnaXN0ZXI7DQo+ICAJfQ0KPiAgDQo+ICAJdjRsMl9pbmZvKCZlNTAxMC0+
djRsMl9kZXYsICJEZXZpY2UgcmVnaXN0ZXJlZCBhcyAvZGV2L3ZpZGVvJWRcbiIsDQo+IEBAIC0x
MTEyLDkgKzExMTIsOCBAQCBzdGF0aWMgaW50IGU1MDEwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiAtZmFpbF9hZnRlcl92aWRl
b19yZWdpc3Rlcl9kZXZpY2U6DQo+IC0JdjRsMl9tMm1fcmVsZWFzZShlNTAxMC0+bTJtX2Rldik7
DQo+ICBmYWlsX2FmdGVyX3Y0bDJfcmVnaXN0ZXI6DQo+ICsJdjRsMl9tMm1fcmVsZWFzZShlNTAx
MC0+bTJtX2Rldik7DQo+ICAJdjRsMl9kZXZpY2VfdW5yZWdpc3RlcigmZTUwMTAtPnY0bDJfZGV2
KTsNCj4gIGZhaWxfYWZ0ZXJfdmlkZW9fZGV2aWNlX2FsbG9jOg0KPiAgCXZpZGVvX2RldmljZV9y
ZWxlYXNlKGU1MDEwLT52ZGV2KTsNCg0K
