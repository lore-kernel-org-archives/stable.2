Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A14DA9A5;
	Mon, 21 Sep 2026 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009592; cv=fail; b=BJcf4V0W3e7uVD6fwiUgN84Y0+qLRq31nN9gPh4FdXVuYkXPvl9Dz8Tlbj21xa1ljnF9vWs90PhYMLjym6yRf9vr5FKXCCCheqioaeomEAHM34RVFGxu+rS9bMb8XrNgZbCv/hHIT9K82tnHe2pZ2atpOkMDPLGQe9YaqzECBoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009592; c=relaxed/simple;
	bh=AAFTJQEQE6sjZrzEhkKVgWbOSNyR8BNvbGZX1qLPbu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uc2Cl5CGf+YlDLeobxONZfLR4dPBJwr04lMX4IYCqeie41J3V+/xZ+syHu1229t/rgmFJF/zAxxJACdYtihUXw6SZYYXK0T4uidsHJBtfOqLfOYaelwYap7s2CtPaUj1h1wKbk57fVVw/IzxcaDtE23k5wjBdz9a0nOvMxrTVu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QFsn7alG; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QFsn7alG"
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFD5EG1913182;
	Mon, 21 Sep 2026 16:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=0J
	jZ5tJg0wtmHNqrvjGL5a2/RXwr6yP/mpyG/fTF1Ao=; b=QFsn7alGQTjM/ErW32
	273Ug3B9V9O8smdz5VTbRkQAdQI9UbOONm4ZsjP00+yMd3e6RWKW5NPWaBlyAHYi
	lFMCyDCBwmIf0qnezcHj0yy8Qmfq8a3J9Z/hf+o6o5lH+fwviMxf6jPSPWSYpeWi
	53Eq3hYpLE61BBgx694ie77WrcWHHzfmnikXDHYjaYfz+8NhqKQ55okfQTteRgjG
	6czdYF7NJTCKbrUwwOnQjTQrHZV8JJsyswLanygh47ezY/JdUVN++ytf1WzVs//X
	0r8cS3vwe6L7JpMjnuk8UfZHrCTXBGt1Qp8IQUyV1b0MACB7q15cJ+28vtU8si8b
	y5TA==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gu3kk4c5j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 16:51:51 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 2163B8000A5;
	Mon, 21 Sep 2026 16:51:51 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 21 Sep 2026 04:51:50 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 21 Sep 2026 04:51:50 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 04:51:50 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVrFcqdc3j2RW/r4TqZrLldy22jcAB/JoInTitNmL2eFpoztNUAccaMVag5NFCVDrYFyN6Yr6WpPIG1vgeS9j9Hvqfvpym9o5pNudbcXb9cwo3WfvgbTFX4t3Kh/5IEVA0BX5d4kCYkf499UAUguP2delQcG4I0IY/Cn1EF30kaAJtN1W0vF11gsSmk4lN3F92bG4jtDL1+R8c2PHLE9shSLuRrR+d/TYak75iOqZDxJLAsxOS/BaXtKe5+xr5hxpJLYzSjNFl6mvMgEw7TfFStOtFy/+wo6vSKXteGS1IKroA0p82YT+pOyC2VZCOEg5/Liu3OEwoZSt3FGbaLCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JjZ5tJg0wtmHNqrvjGL5a2/RXwr6yP/mpyG/fTF1Ao=;
 b=EiJJ2BSqjAQBKdOTUdRFZrkzmDNhjQFOtvkUGBuSnHxsNTdWufm3hvRVNF3wQSRVGz5OKH3wYJj3DPN2WeXIIhOHxD6YAznlFyEhWte2J/v85zzVpe0fxd7YlweZC8SGQtU070ZAqIXaXeuQSbl+b4S7yv5hqu2U4UK4D1UC9D2njLp+YGCpC7q1Jw0r0zjbb6VtZJJJHIPvaYm/2H3gPD6v0xnjb3d63FQW2BxrJHFs6QNpPR/gZwGAB9ekjklFpM6dEoVBrZaIC4P7umvxtsccdsVORxtupmXV5rOL3bp6hK4U1lkn18+n3wKtcWDMqPEHMvyehGAcS9V31CAuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CYXPR84MB3515.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:51:46 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:51:46 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Srinivas Kandagatla <srini@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
CC: Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Freeman Liu <freeman.liu@unisoc.com>,
        "Maxime
 Ripard" <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] nvmem: sprd: fix out-of-bounds read in
 sprd_efuse_read()
Thread-Topic: [PATCH v2 2/2] nvmem: sprd: fix out-of-bounds read in
 sprd_efuse_read()
Thread-Index: AQHdSel9uFcSL59qX060uXXS5Rtx1g==
Date: Mon, 21 Sep 2026 16:51:46 +0000
Message-ID: <20260921165055.421933-3-sanman.pradhan@hpe.com>
References: <20260921165055.421933-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260921165055.421933-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CYXPR84MB3515:EE_
x-ms-office365-filtering-correlation-id: eb3d1bc0-d616-4502-58c7-08df18009fb1
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: MRaMzHHFmDODZjlUCMF4660q1HGhIPSZqTdIS8C6a1ft0W85zS4HlogkMJdPH2fJk3PetLoFCubJICnj47r4wMh08fkhVj6gDR+uoJ5CtjIwo22fj/LBSfqBw/iGPmvIXvAHU9TfEX07GOp5U+6jx7teVdOjweEKA4v15+X6M5x/gLAZwhT92p1ffTJ9+cDPXgWUpdN+gWhH6xoi2wbtTtn0KgjuYJslFciKrGN/qiUNNwqIpiYB8rlAuckYmRrYaHEH3OS0DjkAPAh4OJL6tmGr2XNbqYkPa1PXVcLJccvgPhTrMCR0seLb2zIvm/unOKhNfWZ53B1xxZs62uItAtRWxQBQQf0HCxXA5DWJmnxGQoHrrTpN8E15e3IiTmHrg/glp79OuY8E5AElGHQ8F68XHaNc3WidVK+bFkwS47epLbA4OHVMhTXvbI85IC79IshpHnKBpYfHzm2hB+cQujVqUYfGYRXvZkJdvaCO+H5KeX0mG6dyFuFr96OEM0/HMMPlAsYwTBNLLTikE11HchLs5j9VZiY4rxohFVQQkCBljoo47cKUcbd+31atccd8524TTXAwIU/5JkBkajP0NDuBai/RU5GybrHE2D/TESpLUNq1ify6qVf83PsnlhpyTFuM3hvQu1mwW+apy/H9VKxig4s8RoEUkaoB4hynj5dQusjMPvAPk8TVhpChb1PBR0hCoMuTiOyVedR/itaKufgEWU9Hyx6Qn/2rgqcPChs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fAvy8opfTgsoIIQSFe6RifIR6TrGhDW8P4IzteyzVkiNIlmnyXqu/Kojwt?=
 =?iso-8859-1?Q?W6Hk6ndWdWpWGX6v92a9Oj0PDrYpMHJOnRxfpLQHoH1WV6W3hOvnWnLciX?=
 =?iso-8859-1?Q?6C7FVLIJtrCzpHELvLLuf+8vy1JSg5sKnZw+orQMI5wJHNnKiRcjhV2k8O?=
 =?iso-8859-1?Q?u9SO91612QqsoEABOkpkNWFDZCodpITff11gGtmd+oOiMrDQr4EZfow/6N?=
 =?iso-8859-1?Q?3Td1+hHH2TQ85Kffg0zjoeSLNzkSBRzplg2CwLTBPdnQ7hTGkBcpI6fJqn?=
 =?iso-8859-1?Q?3uENegfSAKnhC6EMmIIeKI2fX5iyc3vbnyptjUB4oH2jXIs02Q8Yt5Eatt?=
 =?iso-8859-1?Q?IQ+OZhq1YsQEoeh+Jt2pfOHdUDF3/zXRQVdpyIARQYSfP3e4Op7SNdPRxv?=
 =?iso-8859-1?Q?mJQMfg2HFrNFtgdcKgRjGEK2yUXbCHhtysTl1J5yhkw8bviXhS16GHC7B1?=
 =?iso-8859-1?Q?JBeZZfN32PvxGp0JMwAWhUwPbRaDSwnopceoB0xNN+axoAgZYTyay3BPe6?=
 =?iso-8859-1?Q?Dmm6Pit97M+bKQ7RMXAH/9hgjDJnWp3Yax5LKvA2RIYS5hq+e1o5BMMsg5?=
 =?iso-8859-1?Q?hd7jg0Q07gGSN6y4MRgOiVmJCluiztHN3lApbfXEoDebFE8lxNIBn+03Mp?=
 =?iso-8859-1?Q?D562HGbXSSK8tbFJ8R4cCpD/SBMq2LgyNrsjWDzqfyXWBY/Nx9BuP4GleF?=
 =?iso-8859-1?Q?OlpwL+zO2FWCsHP0Kp0CwPYs41W3e6baek40PnbuiaTu/TpU/1JdonRP5G?=
 =?iso-8859-1?Q?vbTv6G1LVXXGaFKpnuYu1JiJscEvc2McUG9MS+F8Jk7zWB1VI8i3WwcqDw?=
 =?iso-8859-1?Q?0dBFVtkpWOhI0O4FrqSLGRyov81wbQq7ukas8TkN6vnZIwm+ITjCfk5r+R?=
 =?iso-8859-1?Q?fGbKDjZT+71Rg3HkxLAi7plK5tb3BuvW/N1hX7FawLz1WvSdMT87WTRfYd?=
 =?iso-8859-1?Q?UpXMcA2ECX7+Sw3QGz6RwIR+v9taiUVsIUtNanoV6WqcwYo3JbeDGmPk0P?=
 =?iso-8859-1?Q?ieI5X7FAj/GXyzQmbUt2fXClq3hQP649gVt92+KUtQ5iHqMem9wPXJOOzT?=
 =?iso-8859-1?Q?xywiksKcSrXUUFnqDgOFdWxbkmQhPcKUlex3esvQOYm9TwqSQgH3NTmxEf?=
 =?iso-8859-1?Q?se7FmNzHnZoIxT/OKO4WZN2CeUzd1AkVWKa58P+n07YiIH2fYBCzbzhMVd?=
 =?iso-8859-1?Q?+ebYnceSQ66n1V/KkRMMFWeh3DLA9AXU9NCGgK4MyBFvcHNduHCBYfV7VD?=
 =?iso-8859-1?Q?6gkuPKsev/llKyI2WeAi7OJLZyB2Wen8dFKE+yvt+syGsOvqapLzD171mQ?=
 =?iso-8859-1?Q?cdUklnrE6UkaBXYE1AsiCLrpFSmVeqrTui/UgbCDpaKoMXkzjQDpDkKSYx?=
 =?iso-8859-1?Q?69KXTWrknPhFxKS7al8y8WaNEDDHfO3rARLiqalmCsL2Xrpjgpttcx9bir?=
 =?iso-8859-1?Q?n3A4cPDYHezDkyLaSRN9bMSH7V7dEHXUj8OENjTdv17GksKZ+MbfsAgis6?=
 =?iso-8859-1?Q?NowxDq7DTpKjvZqnv5YCQAXSVpshsYGZU8PyUM/hbjKADvxBi3PFb6heKH?=
 =?iso-8859-1?Q?4A5PRIEdFFTrnVvq++B12DYfhQrh4UlV4bw7BqCE1/QUpao6zRB9O1H4QG?=
 =?iso-8859-1?Q?goOFvglP34ygAcooX/ujDYT5BuYVQadQhszW8NxRUhPiDYagiG6nlSUNOu?=
 =?iso-8859-1?Q?D7INOxknWe2pfir49mhChhHKGswnk5Ni2zyudkfF51/1loUco5UnbQCora?=
 =?iso-8859-1?Q?SDr9QX/e3KXcGljCphnFLPSfHxlYoJs0a1PvXzjz1p4gwLmGFMa+tmnCrE?=
 =?iso-8859-1?Q?IJwqiXTQkw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LYg68aTV+5FnUG1ePIbkumNoteqk7dMBOEVXCEqNsH1ipZ0bbYGjjIBKm8DqdE8YXLGadCjjwk1Xjolg2/6TfnUw0yBUyQHQ/Ug1lkAmH5YVQ1DigtxQ+aG9iUgWRqy720JMhgWqQrelwz8w4fTsutCEkSrBIPZs8AHDHD9/eyLiu6ZyIRPIy2DcUrO2J2OK9Oe/zhks7sBcSSSaWKSmxgr6820gFHPLy/cIaBV1DSuHSjUA0BBC1QxUU+6oNjgWopYjH8g1Gckse0zdqjF7eRh/+bDLaFvlm1088QAYFw1+ZLNCez2AbPH5mMGD+wOndaTR39mYqxrbl5XtlOT1Iw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3d1bc0-d616-4502-58c7-08df18009fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 16:51:46.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmcF2H8RscqPNhzifS9kVlncjP/LZib7kiOdSELc3IRFbwt91TGnYQnIzUx13Nnf6cx4I/q9MXdRRDPUzkhI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3515
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI0NSBTYWx0ZWRfXxT9nL2iskpd9
 hYQYbTvV5MbI37GKZ+Yua6iaAUPiW+xZjxFPErxyFR2LWwuS+8gg11F51KD8qg2b7jkhOeCOEcC
 zrN5NoYWkryGiDzkIWkCWMgyX8EaM5sNQcYIoKhhbj6jfVBmTJ3mV01byfL2O54aKFYv83AiOSa
 Qm6M/DEQHGgq9o930Pswj13AA0F7GKObugLHRIW6wwEzZVgEiVWbov+Wj8fDuPtq5elQWlL1/G/
 dM2qdcZJo0UCDA4nP+prNsjEYX4ogbWr2Z6Mngd4hCGj741/sdb+3AHm35uj6Tsn4U9F36b6ypT
 CFgSYNVbgZYsqd5IaE3GulUl0FBuKKmGedS49QpItuZOtyODVrfZa9lQxf20IbDpSC/0+YCxJdZ
 EOa8403BA4GbkYqlqnXzO1x9jaiBwHzYEwGWzLGGBRdKy1CZiM/yNtRtjvX8yzmRFxnEFgu9K0f
 f3hfeA0BrXAqMwRbQiA==
X-Proofpoint-ORIG-GUID: zbvxSGhsPIh8vzh_etAP5EFzBOtbxz4u
X-Proofpoint-GUID: _H59FVGnBOl6iVbsJ6AJ_Np4T7T4Pb8s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI0NSBTYWx0ZWRfX0y0QRJELFp5t
 4/dabgsRQ3PD3IR1CpgwTUUCoF8YRKy71LEeL6B11hf1C3AXkOF1lvv9ciIMv2BcZrbwVE6lJPW
 cW3ai+FtLKgAXgEcI2NhyH0W90RMrDA=
X-Authority-Analysis: v=2.4 cv=MJL1C8Zl c=1 sm=1 tr=0 ts=6ab160a7 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=MRYFSQQF-GsNLmLhGdsA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210245

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
sprd_efuse_read() reads a single four-byte block into the stack variable=0A=
"data" and then copies the caller's full "bytes" length from it. The=0A=
provider advertises word_size and stride of 1, so a whole-device sysfs=0A=
read reaches the callback as a single 96-byte request, and=0A=
__nvmem_cell_read() likewise submits cell->raw_len in one call.=0A=
=0A=
Reading the whole device (96 bytes for ums312_data) therefore copies 92=0A=
bytes past the end of the four-byte stack variable into the caller's=0A=
buffer. The read is reachable from the nvmem sysfs file when=0A=
CONFIG_NVMEM_SYSFS is enabled, and from any DT cell wider than four=0A=
bytes. Only the first block is read, so the returned data is also=0A=
incorrect: later blocks are never fetched.=0A=
=0A=
Read and copy one block at a time, capping each copy to the bytes left=0A=
in the block so it cannot exceed sizeof(data), and account for an=0A=
unaligned starting offset.=0A=
=0A=
Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
=0A=
Changes in v2:=0A=
- Drop the provider-side offset + bytes range check; it is now done in=0A=
  the nvmem core (patch 1).=0A=
- Qualify the sysfs note with CONFIG_NVMEM_SYSFS, and use min() instead=0A=
  of min_t() (both operands are size_t).=0A=
=0A=
Compile-tested only (NVMEM_SPRD_EFUSE, ARCH_SPRD || COMPILE_TEST); no=0A=
Spreadtrum eFuse hardware available for runtime testing.=0A=
=0A=
 drivers/nvmem/sprd-efuse.c | 17 ++++++++++++++---=0A=
 1 file changed, 14 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c=0A=
index 1a7e4e5d8b86c..82995f8bce471 100644=0A=
--- a/drivers/nvmem/sprd-efuse.c=0A=
+++ b/drivers/nvmem/sprd-efuse.c=0A=
@@ -5,6 +5,7 @@=0A=
 #include <linux/delay.h>=0A=
 #include <linux/hwspinlock.h>=0A=
 #include <linux/io.h>=0A=
+#include <linux/minmax.h>=0A=
 #include <linux/module.h>=0A=
 #include <linux/nvmem-provider.h>=0A=
 #include <linux/of.h>=0A=
@@ -297,6 +298,7 @@ static int sprd_efuse_read(void *context, u32 offset, v=
oid *val, size_t bytes)=0A=
 	bool blk_double =3D efuse->data->blk_double;=0A=
 	u32 index =3D offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;=
=0A=
 	u32 blk_offset =3D (offset % SPRD_EFUSE_BLOCK_WIDTH) * BITS_PER_BYTE;=0A=
+	u8 *buf =3D val;=0A=
 	u32 data;=0A=
 	int ret;=0A=
 =0A=
@@ -308,10 +310,19 @@ static int sprd_efuse_read(void *context, u32 offset,=
 void *val, size_t bytes)=0A=
 	if (ret)=0A=
 		goto unlock;=0A=
 =0A=
-	ret =3D sprd_efuse_raw_read(efuse, index, &data, blk_double);=0A=
-	if (!ret) {=0A=
+	while (bytes) {=0A=
+		size_t avail =3D SPRD_EFUSE_BLOCK_WIDTH - blk_offset / BITS_PER_BYTE;=0A=
+		size_t count =3D min(bytes, avail);=0A=
+=0A=
+		ret =3D sprd_efuse_raw_read(efuse, index++, &data, blk_double);=0A=
+		if (ret)=0A=
+			break;=0A=
+=0A=
 		data >>=3D blk_offset;=0A=
-		memcpy(val, &data, bytes);=0A=
+		memcpy(buf, &data, count);=0A=
+		buf +=3D count;=0A=
+		bytes -=3D count;=0A=
+		blk_offset =3D 0;=0A=
 	}=0A=
 =0A=
 	clk_disable_unprepare(efuse->clk);=0A=
-- =0A=
2.34.1=0A=
=0A=
