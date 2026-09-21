Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E347FAF8;
	Mon, 21 Sep 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987928; cv=fail; b=hkT1D7M08DOyNTrfcZwQCrLJLrUiW0wUQoYB0/A/gn0GcJO2/VSjH50paVbWMd5Aqs0wo++bSkFdzdzu8+pXVR2Zzmcl06Qal0zx2j8IgAhXcI830sBWW/GDLvZdIjN/vReqCoSbJ93QX/U6o/EJOePjDD/5+OJAZcuQFvAq7fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987928; c=relaxed/simple;
	bh=8ESLwGmQxMa0+UPt3INbHSVEP1Knrr/zVbZXHg6Mn2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fg+IJH1cM34IikAhVRZZOwR2KoB/jqIo1snk+CECIJkXSOW8wZGAkFkYI18NlTJHC3DxI+MqbGPF9TXONSX3BSSXq1CbTjweATz6VDULHsQaP3asAMNrKVHn4CA5TBtRJ8ghYMt6Aguh1FFn+kxDV2CyTxo2Gk7yXwG4aZM6HwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LYSMLEJj; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LYSMLEJj"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAj5I1502038;
	Mon, 21 Sep 2026 06:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+C1FN
	MCnMIuvGRFCmvR5GmFlDQkA4ow/eCFyk/jbyyc=; b=LYSMLEJjPsK5isX95AnaH
	OsnV1LIFatuMUN6BVw2yoPn5TucG1vd1U6VqE4wDhfoqHma4hA4+KDCFdx1oIKeE
	Ii+Z5Qt0a3z3c+KRptaCE/TOjDWghuUGWWk52gLZQPSdaB0JHd7T1Hv5Jy6UiRaw
	Ht7gL0SMESXl//IZKwumyTE3orlg3Z+2tGvaqW8Ils+Z8H7TqwytbbXZ+LK8GlpN
	G9DnzGWgLhEu2IzIQVJ+6E6DNVfvZoducvhzv0foCcgx7UPlBLvG0OjimnIMsDII
	kHGL+1XlJ+AFRJos3P9+NCh7KOsUYvPO2OXjdWUkJLFqcEnMzCJMMchavpAoCKC4
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gtbqhmang-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 06:51:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1qgS5YRQVuF6reNXsgJeUEVsdz6NdkB8/fQgHrnJmmYlMO1D8EqclSJu3vpbaNYIzOH3Xb4/Hms3qNpeGGM/cMjDRr/kU1tCkcS7Vm2ZNJVo95w3M90hZqek8JmB0uF/SxVzeNkeLFBIPA4ys+clAF3qQalbMWJyOW3JiXkw/grLsMx/7clwlWu8NbnzWfd7uty/ggHQMYPbpMYupecUTbuMnLbpFsFUsrlPGqBLDG4jVC+GFesnXw3O2DeJVikX79EVVxWgtVM3umMhqc+G9Vun04T2mCdHHqekA9T0MP+bwMutz3CSqUlQFSNB0qVNqGq52eOLiY5OlZ6chEfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C1FNMCnMIuvGRFCmvR5GmFlDQkA4ow/eCFyk/jbyyc=;
 b=Ni2mFJvAgMOomHG37WjAKvJ5KbyWykgPvgbWsigtk509N/KRulfMpmGmgUHrDWCrfFWoU8N/R1bJJMEEhgORNjq6qro76FYJpMtwi00KzZzL06awhudzXooWqUZFAPXRRkoX0LCdhOWVevLSEidsXQql4ebwurVuGkWCZSgyDPk0kz03H0SQ2xuz+MR18qfrMOhGeBeJOOPJxsF9TqDoayPjxT27RSV6qDdsuYryfuEppnohBr0b2/N1qkWASDMD0htSYZ4znzLc6BwvbrXsgqftXtitRMt41hxILrz87/DP0kB5LgRlcIQrmgM5Rhfh6RH1I4Z/q0hkelsg/7Ngzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 (2603:10b6:930:116::5) by PH9PR03MB470143.namprd03.prod.outlook.com
 (2603:10b6:510:3ec::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:51:46 +0000
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576]) by CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:51:46 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Linmao Li <lilinmao@kylinos.cn>
CC: "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, linux <linux@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference in
 clkout registration
Thread-Topic: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference in
 clkout registration
Thread-Index: AQHdNTVolyy1vrljrk6694OmhBFNIba3TDQAgCE3cICAAIACAA==
Date: Mon, 21 Sep 2026 10:51:46 +0000
Message-ID:
 <CY2PR03MB6499337E7D978ECB90CB61C3BD9B842@CY2PR03MB649933.namprd03.prod.outlook.com>
References: <20260826083156.2287106-1-lilinmao@kylinos.cn>
	<20260831005728.4c2b80b9@jic23-huawei>
 <20260921041227.61e00143@jic23-hlaptop>
In-Reply-To: <20260921041227.61e00143@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY2PR03MB649933:EE_|PH9PR03MB470143:EE_
x-ms-office365-filtering-correlation-id: 9f576d1a-f752-409d-598d-08df17ce5501
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 nWY6mawZlj6k9gGrSoJC93Ykf3kFowdTIaiw50DxvTZB5gKckQkcxD60SMBlDGPj9L9BK9OTpbLe3J80OIqIApkWu7kL9tARvHx4VoUAipyywEdvr5GgmVdqX83T4Mh0dQgvpDWu0FzDfGjSPDeCOhNL1CwifJXcf3GzaI1wZb1mhyjX20ZxLto9Gw9pukVqshraUNtzVcIeN2icSN8I5lkAXU7xNWq7kRh9Civl7sOW03vtTxG8oTrrWS0ab0h5wK4L7B83QhNxfTIQ7Im09mjx7oSbADKs4Q/5DwsVQxxxIMOmSRyDHOVWjdt1gRCDsQzbxTL43NzHeUC7NIPRJNrerkjnxg1rPSddOF3DySlVIxpNEMFhFOgG7ZtUPr0KWmWvP7bnYvpafUbsJXq48wwNKLGAFnwThXI/PPxzagAPDjps1EU8Bg1zSRGRWlbRUCnBzfYUHJgbK2Z0FcllV2CX9jUKn4f2AWk0M70BI0b3TdHEwDEIwhkVZYKCFOmPB7660kJwQFOMVGv8ulK7CYskPFj0BMS3+UrfTpclvxniVMVSlsEm1WJ9RqtO3eKILSmnPUm9GCl4GYufSYPeJbkOPQHqWYagVUvziuFW1Bwb6loJozXW5hthc6Xejm+l5/9O/LtrFV6TfC2OlKTn0AN4CDBNNoRp1mypZq0NKbauqkeDMPXSsHTO+6Bm1OHTt+zBMKxF55QiuSSytgIlMfSo+1lvaRfl9yLMnxbOmEE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY2PR03MB649933.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?giUp+0uTFsxfrpkAeoKzw1xKlaBe/etXvOa4dzFyoLIa1ZQVUDF4zv7Ob7?=
 =?iso-8859-2?Q?PMRLK6DuAn0rq6yqgcFsbO0ZZJfXKnjxnBIruqOq7/h/bPq3MI6NQPKAa3?=
 =?iso-8859-2?Q?52ZuWvidAFtz1BwVceQYmjCRqn+4d9a7c2RjxPtGJs0kgomtHQr3OMwSEL?=
 =?iso-8859-2?Q?6fbRusfNDjFf6aAe185P4G5RqEO3WraYDOCXJvUFUdN0h00KNTm0swZ5Mx?=
 =?iso-8859-2?Q?AX7o7fzQc40DOwD3ihO9x42pbyyNiFrFYbEEYyT5HT4ooqenmy6eFx57zI?=
 =?iso-8859-2?Q?S6m7MA2jpiuLFWLviSl6Q64MXf0XB5AuDyESBn/79YyDj6gT3v13cZV+Fw?=
 =?iso-8859-2?Q?vp01x/NXKEFIxIeQ9WuLTL0a4cZAUBEFr2Tnjd5f+ZjtG4UBqgv56B4BAg?=
 =?iso-8859-2?Q?FMLG0Fz5WNT2J/qKIYpo/J7rCmn6Seo0LqBO23Zzy0RMwbvvUSBqn8meUq?=
 =?iso-8859-2?Q?78GtCWX+TV+P44jgufp0lQuQeEjz3ktcgcJKCGtI0zskX6cDzgwB6fVNHw?=
 =?iso-8859-2?Q?hnho6KJyi6WE8DP2p9zxEXd8nS6t+cgaNCKXp/VRv0XQrGSfpUV1RofOJZ?=
 =?iso-8859-2?Q?i/9rvocJbLkhkJ1hr0wf3r/dHegsqCatzdoQePNNhci9qWqW6vy/zcQHEQ?=
 =?iso-8859-2?Q?l+nZJJ2Wn9+ke2GbhvAkY6lK+7VD/jMtgL/hpgH3wFdgzuMymOtBxYqyi+?=
 =?iso-8859-2?Q?6f1U9lyja8eEgwvBZwRf+tjmGpp1TG6NMdj+svKRwnoKb54iLhWs6YBYgk?=
 =?iso-8859-2?Q?BU/ddzRiMmlkZUuE5R7fkFJcC+8/naUUVRFjknaoR6q5irwGCDf06mGbXs?=
 =?iso-8859-2?Q?oBir6g7U4EXq3T32kpyaNTOaazQpAKjy0ni596glQa6b9R9ormmrqE1AIe?=
 =?iso-8859-2?Q?uQQt9oZesv1//oJp0TxrvhhcP1+hzuBBnQ8CYF8tP0adrnEMbhC7zQNSt0?=
 =?iso-8859-2?Q?jiSlsQMYGOv7L5yfXC35KhglE34YSUGGp+/I1V9EzPE1lDOwrfGv3K5K2B?=
 =?iso-8859-2?Q?Kr7LV62P3jbU+eDRb5aUMIgupEClNax7J7yeZITzjWMcz27kUgbaZ7c8vt?=
 =?iso-8859-2?Q?PPPhFnp/1XKxWLrzIppckkdS0NOzLWAPkb3c2iUf8Rw/3hsqcgybfA3t9G?=
 =?iso-8859-2?Q?oIbzibzJBPpkIuRtY584R1pAjSa3RWPwqxPUWjOwYCQdhGr9iiNihtQlPa?=
 =?iso-8859-2?Q?8kKnJ4HE4TV0A5MWg1AmMkcC7xX4ZM6beadJ4hhZ+ie0oP7mLLQU8cwY3j?=
 =?iso-8859-2?Q?HHQmFWYWVm2qZZD1j+CpRzO+++k1fep6i09GGIcdlbsalW52XzpoR0fS71?=
 =?iso-8859-2?Q?vNUaiF/r+0iJFfw0ANwUszuy4VgN5Yx7fji66+ZQfHvx1tVJNeenG+/pE4?=
 =?iso-8859-2?Q?v+wv6jhAnUzBI/MFQqoRCwXIcVTnCIttSLs6Epj87PxvpZ7fWYDW4RGbbd?=
 =?iso-8859-2?Q?LQGgutvrWGivbrQxZXzhrbhaExj5L34WPglMx6HTZWw7EDMXh7siAi4CGT?=
 =?iso-8859-2?Q?9i7onEpe0j3v15p6FRyHrqvfViG1B4m3vTl03t3SEOBpNMqFzYacC9zZ4r?=
 =?iso-8859-2?Q?J0lqa+qFPi09zwemeA/K5TtqBBYFzvqMMtxGcVSQyoTAK7pLpkVY1OdWUI?=
 =?iso-8859-2?Q?790rHQAyfanxNfTSZq+nMc7/yTs/O4GsKAiIpa4ODVLfsiojlTBH1IL9/v?=
 =?iso-8859-2?Q?tc1k9HWqQpvF/Q/Mvxv22CVpJ2c+cH0ZtUrTcY4FeImwrwAj3+Jsd1O2+j?=
 =?iso-8859-2?Q?fAs0upbVmuF7MoBIzLpJh5NUeCNvXGzIt4ECgyt4qR9fAq23NHx3btRu7c?=
 =?iso-8859-2?Q?uICg4lSfpg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F7dfSh9vOd8L3FaDf8LL82Pd1gh7pQsWCJT51jJhVCL9Tmh/0ZLYrYcyo5/rkahGwJIFNr2aR/x8LZIMQfwYCnIF5mjkIhJ4heQWKQU+pCZ7/xUx/ZRfNxv9uye+3s63/FvLewzMVtjxSKp5dx3sP06NKtijlT/tlNvL6QYHprObl7MDpFO3iwwoq1Ihp8NtoCZoC8qT35eaMu0VQe4W1EThW4aWkqDPf4uBJKDcoyh7gmQbaHO9/WAWonDvHzO13GTXMUhLg83bruZ0bSoXmfQjP7aTgV9V2UzJx45ADJlkPctiTaPAKOjuy5GTGYHLTy+kyTCUtgsQKvZ7Jo7txQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY2PR03MB649933.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f576d1a-f752-409d-598d-08df17ce5501
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 10:51:46.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQniDiwgA08o6SFzja9hZA9TfKOsgjXT22O+3Th1ojhCIiWl3UcDvYzLnDjMeo3dDAZ2jZlbLvc0bLiSjtvcGEYl14/ogRVyXH7Nt1xlU0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR03MB470143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1NiBTYWx0ZWRfX+qAzQN1g+mDY
 VhhT2RPR4X749gNKOwIYCTWuC3aeLmH0YiMhOdRpEBsoHhkGnNRuISD4HX/k10wLdI58r6ITMnG
 /u1o3U2YYLgYxfsfqBFui7Bsjq0wsjxAC/wVAKTv585xT83V0pNYTuBV6mOcARLTUFl06UasYaU
 sS3pyqqv426q+hrDgSMUiGF7IekOz7K5JGPN/HmH9RQP0u1+zMDWCM9SGEHF6nG3M7+DpEs4PYw
 vBCsKNW+mMXComrrEB5uarSsuSPL9pNSDdayu1QvtXSDg2nxm5QLkPPKA2GT83GiuJNzZ4sTODs
 5kRicRHb9QloCXmiZadTVWiXOMGs7EoO9ZF6btpsOkbBzu3NzYBFs7QOKw6KP6s1Luq8zL6Hu7z
 +EGxObxTcF7fOU1cDBhtBnQBKKO+T7L7iH1ROqD+WyMi/Vyi0qFtLB3xlz0dWYGAX4KGX2q7EtR
 9NN7jmExL02MnMUXfRw==
X-Proofpoint-ORIG-GUID: cKuIM7qpwsuczteA5uqannqGznVRANTG
X-Proofpoint-GUID: cKuIM7qpwsuczteA5uqannqGznVRANTG
X-Authority-Analysis: v=2.4 cv=G5OJgNk5 c=1 sm=1 tr=0 ts=6ab10c44 cx=c_pps
 a=F7X/6K5kN+zqVHn88SdM/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=f4lUO2GnIfmwj6WCqWMA:9 a=jiObf9B0YAUA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1NiBTYWx0ZWRfX8+VA31WhhweT
 5aFvbjkMD+r5f4TIu6diGvN8lVN0uMuLvs+dUCYWDprcLB3oqBh4yEa1SmaqcYexG0KW7cE+0gz
 QMrxWt9OOS7nRGfrMssy9nc20qQbDZFzI0HFP0t6MRUCteDjX0g2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210156



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, September 21, 2026 6:12 AM
> To: Linmao Li <lilinmao@kylinos.cn>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> Andy Shevchenko <andy@kernel.org>; linux <linux@analog.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference i=
n
> clkout registration
>=20
> On Mon, 31 Aug 2026 00:57:28 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Wed, 26 Aug 2026 16:31:56 +0800
> > Linmao Li <lilinmao@kylinos.cn> wrote:
> >
> > > ade9000_setup_clkout() passes NULL as the register address when
> > > registering a divider clock. During clock registration, the common
> > > clock framework calls clk_divider_recalc_rate(), which dereferences
> > > the address through readl(). As a result, probing an ADE9000 configur=
ed
> > > as a clock provider with an external input clock crashes.
> > >
> > > CLKOUT passes CLKIN through without changing its rate. Register it as
> > > a 1:1 fixed-factor clock, which does not require register access.
> > >
> > > This change does not affect the configuration using the internal cloc=
k,
> > > for which the driver does not register a clock provider.
> > >
> > > Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> >
> > Looking for a tag from Antoniu for this one.
> Antoniu
>=20
> Please take a look at this.

Sorry for the late response, thanks for the ping!

>=20
> Jonathan
>=20
> >
> > > ---
> > > Changes in v2:
> > > - Clarify that the configuration using the internal clock is unaffect=
ed.
> > >
> > >  drivers/iio/adc/ade9000.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> > > index e57e24b6acdf7..4e96cc37fbedf 100644
> > > --- a/drivers/iio/adc/ade9000.c
> > > +++ b/drivers/iio/adc/ade9000.c
> > > @@ -1647,8 +1647,9 @@ static int ade9000_setup_clkout(struct device
> *dev, struct ade9000_state *st)
> > >  		return 0;
> > >
> > >  	/* CLKOUT passes through CLKIN with divider of 1 */
> > > -	clkout_hw =3D devm_clk_hw_register_divider(dev, "clkout",
> __clk_get_name(st->clkin),
> > > -						 CLK_SET_RATE_PARENT,
> NULL, 0, 1, 0, NULL);
> > > +	clkout_hw =3D devm_clk_hw_register_fixed_factor(dev, "clkout",
> > > +						      __clk_get_name(st->clkin),
> > > +						      CLK_SET_RATE_PARENT, 1,
> 1);

Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

> > >  	if (IS_ERR(clkout_hw))
> > >  		return dev_err_probe(dev, PTR_ERR(clkout_hw), "Failed to
> register clkout");
> > >
> > >
> > > base-commit: 6b9f23b5460818aaf199dda90210d5fc08d66c8f
> >
> >

