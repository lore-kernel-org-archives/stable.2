Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9B346E4A;
	Wed,  3 Jun 2026 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473967; cv=fail; b=nMtr/SRX9BT/XP2iNE7P6wHwHBxm6gbiGyA5gim0ZvSNmhZv7AmDs/HKnNJzNs6AL10UeNaisTZoOnZ1cDvSszEjEpN9A0Gc5s+22Ig1wp8AtRqtopDwChOHE7NOxt6hlhYtHnollN9qzm8ZJ+Dc79JxNcmv18nzpZxQA68iUFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473967; c=relaxed/simple;
	bh=fywVR3DXpnGKGn/gFn3fduPgicJL0Pp952anA4sDD3c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nHGxZtLbrPp18dXYo07XaYZtK6hpm7CsxGbPPN6IuNoPg6SrnvHZJRIKx/3/eG5igme+QRQFCJhVIIkDqtP1i5yY/dMZIUWCF0dTfOWpNJr1UJr/RnwQvRylbjnhGPLmt/MmQFcwPgGh8i4G0BrkRb1OYS9qi/lYPT7GmmIQS34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=EG1x2b0O; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="EG1x2b0O"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537N20E3730584;
	Wed, 3 Jun 2026 08:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=jFvTkzKwg
	A0NEyzhMBnicJB/0ROw2nusNr4vkMEZJaU=; b=EG1x2b0OAID6W6epTUQmxSpjl
	gagJbr4A4Whphwbl5uvp1KxaWCoeeISM5hhAs8cj4SLCrMmxNAPlAvOH+LuQb3MJ
	tHY2NoBBZ9HptZgV5fYMyS0GS0rm7Dk7ZYtbAwRSwz/UwHK6OhqqZFRn2NxkOwDs
	1K6uMufMskNBiwW9cprd6QfubbQAq5dTgF3ArEfQOUPFfjW9jvOkH1WHUgU9ggLC
	ncPNIS0q6FKU7RPIKg/fPXb1p/gl4aP6vW53by39PNenCkG/+qq0yvZvzc4LD5o9
	XotT3ZVuPBT+VR3Ap6Y3KPz17TxhXNfX8iA/KmNxfrG6u8FNM7KhCHMZaQLNw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efn406ejd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 08:05:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hglvesF/q7nWOeUj2CxgGlrphHywp68kKWo9/mpNLlwOaHc9R5/TI6t1R4foml0tMwm3GPUmjNb2nVT1rNSdyRp3v9IUZgJq0CdCq4YQcV5A0kU3YzWE6mPRpr1LaYm8W7uIuo2T4SVIK3dUeiVihYSVYDxEV+7irzZsiBC1RdV6OXEJse3Y8Aw+L2pz5uqxVqLUrQDxuf1yNw3YfdKWKw5Vsc5ud/kHqoSptBdprOMxqed9p4h31zMHJdX9oBq6UKMoJt8Gk5x97uZg9U2WO6SauCv1y3d/W/tqKTt2u5ziDghoCEdwgprDhzQ26uhNyEAA32AjquvC/rgR7D4Bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFvTkzKwgA0NEyzhMBnicJB/0ROw2nusNr4vkMEZJaU=;
 b=QYqjUgVmdHa7CbXh9BvatjLxAbcNZ+w0NOInqcww/JUviEJpEsH7qb92xuEn6o4StbqIqQGkl0VQNSFYF0l/SEllP3/iIWP8MMN+qArOZBuImJuxiA4T6pmoGzW/X1ZY8b7q03XMU5wfSi/m3QsOMH2Xz5Y0VTWDuAgvq+2s85Mnae+sWm+0nt0FIYzmlhIIXuHSJdKRD17K0g+OEGi8IX96ug9EsGjxYe7cYO+WGqWAIvP+X0z/nr1paP8/1+67dsgXgR2oxMUwprWp5OMbCXLfmw+Ksb19L8MNP2UisnykupnN5VJJoi2gj/XYMEXQtBBB9eqJ0OR95k96StrN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 08:05:23 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:05:23 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: stable <stable@vger.kernel.org>,
        Horatiu Vultur
	<horatiu.vultur@microchip.com>
CC: Friend <netdev@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Andrew
 Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Greg KH
	<gregkh@linuxfoundation.org>
Subject: The backport of upstream ea5df88aeca1 introduces a regression on
 6.6.y stable
Thread-Topic: The backport of upstream ea5df88aeca1 introduces a regression on
 6.6.y stable
Thread-Index: AQHc8y0VwyixP6M73UWdLUwNljBHWg==
Date: Wed, 3 Jun 2026 08:05:23 +0000
Message-ID:
 <CO6PR11MB55865EADC225FA57A8473BD4CD132@CO6PR11MB5586.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-06-03T08:05:23.199Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|CY8PR11MB7009:EE_
x-ms-office365-filtering-correlation-id: 8bb6f6f7-287a-4526-fe0d-08dec146dd25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 34rjoXbb8ILPGaO1Sj0zBRHqYnMj/ev9H+2ZmQUo3A92m22+HyTKRsTEazRwlMIlcF1lI8n4Ghgr2+FD0MGSFVeNCfDHOQF46+71ELVrujAn523Q4nWirWQZdKSkrfYi8qzoeN/msqcbG9rlrSFDY4vQYSJQCJ9aBZPsAWhrQDkiFv2LNTdZWPDgpcuBhuPJhVtnGW9cB8gQiV7+2VBFv84sSzbLCSwIgw0deUfHPLUjtUnXVGWq/vVMuE4HoYdQif6TqUkC3dMF1aSI91HT9ZLQBkR6hJPSgchTQL3c0YMQLnNy4S5ayyU5vEiUGratE5IiCXDZMcfPg8CdxCH5jivBYnD4UEySmFkdNcq1rzZk61qeLKoElsfNttHcPB1pV+LnryzIpZxn1ajkLZeFNI9m3eO0tNOMaUSiteV6a3RVISdD6//SEdTVBCchx9RtDhGSGH+AygwKbb0BQekopr0FArwl7CuPLbTuPsf7mySsWh2wDRl8Ce3k8cmEf3cb5trcOyNvitGTeN2nFQVsbT6znqlmQWMPP8abGYL7fLv0BDKqFnA/uzrT9ONOKmZrCQiMW0p5uxAQ+eB+GTE6PD6kJHwQEFAaMddAMHUqTPbMhejT3N7nBOrayRD6s61vmaXQMGIV82XbFRkkEHsN3ytkTdpEOD5vrpptg23Dqq2se7Kg/KP7zNabFDyhkNhupelO2pmuN22zGu6zEcaZz4SfVfz6KvLtubYJ69NRzEiPhlW1SnthKdDIPEkFClDQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fvMsEEGBQPucRjVMBMgfzlodWwBjLuG+jQPmkSn067sv8M5WW5BSdikI7O?=
 =?iso-8859-1?Q?G/yNScQA4IqWOpaAuy2Ijksf+KDq8+SVYACSLWQhhSHhdcdq1fjOkVe1vK?=
 =?iso-8859-1?Q?k8v+C+F+aWrOxae477tjhL75qAufFVyAknS4ZlnJalfcnsQKRQoP1xsFD/?=
 =?iso-8859-1?Q?tqMYSjXeSrPcbUCq5plem9fZLRiHixgIZxizpB81DU/Um2/TarM3aVci3v?=
 =?iso-8859-1?Q?7MdIcBYQyzLIoLWTyG2yRoXLEfmNl7xI2/S+UON66vX4PYs/X9hNerswYz?=
 =?iso-8859-1?Q?vpOo68v7JkbikHhuJjuDrVwQ0mleXfeBHiFqABYtjP+Rv+VAZpKYj54WM+?=
 =?iso-8859-1?Q?g+LS9dvQA5VuxULvprGf6xpVWP+ycOIHHnsA8meskR8H8Gg9fa/mI4j/UO?=
 =?iso-8859-1?Q?+FuCtaSue3MOfjjkN5Nmpj+yl0jDBxR5KKtNyi6XOAUb8tFIwzyjy1iQAf?=
 =?iso-8859-1?Q?nNPJs0n0fEiYTxriz9Yz0V4YLrwysqFiwFElrsxU0nFsP7qBXNV0cIIz29?=
 =?iso-8859-1?Q?LP/aX2zSfyk66RSFsOCJTeMkt2mzhjiuqPcmnCRizruH2u6ncZGm945/+p?=
 =?iso-8859-1?Q?APA+OBw2aEWQ87xZ2chiiC0yPurEpn8IcUwAb6exxsD7r4/fLAweuJ7QQ+?=
 =?iso-8859-1?Q?VzohsF8rvOdNTFHIBPmH2c8haZ9BOIbYrOVDu+520m5Q3J/YjzGNH8Ca2F?=
 =?iso-8859-1?Q?3SNlI9rc3Wjfjhy6CcMdK/ibaN3zOr0gqBjPP0ILIBEudvnKd41NAGwnz9?=
 =?iso-8859-1?Q?TGwTj9FvNygjkMf4DbyarU5qSpyqziKLQr0tE7HRLUjfw+KO8+NbYQYxWl?=
 =?iso-8859-1?Q?4G/znBvx9Q6zkqxn+FhB+EjL1Hxm93HhfxdcUi2PnOb9C/5eke0HZCnNBc?=
 =?iso-8859-1?Q?LnClTE9kpIiBfS/QiPIkRRCrFCZbR68t058bYkldPb2V+bHhgSeJVvVQz+?=
 =?iso-8859-1?Q?d4V8XrrX8XFqLQIYUQjekhIGED1kRWcI5reTaV8hRpb2SGP0A6qfVZKVZt?=
 =?iso-8859-1?Q?UZY2FwCHSkrotGsrOG0M1nzXCLi7O5gGOfRDLagkhEvnujUNNr4iJa6wI3?=
 =?iso-8859-1?Q?t52YQP6r+nEPngw0SvEi0QngcBV5ZKpSZ4ufxv5xkMFiKSqM9HTh79lFg7?=
 =?iso-8859-1?Q?3YkdT12CFhx/3Y0G+h2VJgZK0fZH+cddOdhLplrKwNt2/hgn2h+7nFftS8?=
 =?iso-8859-1?Q?/uiFbaqTlwtYzz023mIwq1yz4tErvA5mdjbERn+pB0BA9XRPAGoc6JxufQ?=
 =?iso-8859-1?Q?qvQ32PRQ01/NuYkbFeP5FD+eKSe4sz30PZ2sfYRkFlTZJ4fbY6MyDe4YmQ?=
 =?iso-8859-1?Q?Jb8qdXzd65dLkSYUFytxbDeEgvYoQNCgjPTJFMPs9jl0ClUxB1lee79gaK?=
 =?iso-8859-1?Q?udKOiMqtpUZY3qdYrjd1jyxRYcycCfCofyOR7Ws54VWTgdqCbS6ZAQ6Ikr?=
 =?iso-8859-1?Q?ZZcv48tYVzlzzrdJe412CAo2g1uWX67zFvKJ/pIKb83vCD7Q1vk18d2Jki?=
 =?iso-8859-1?Q?tI1Z1aD1hHUGIcn5K9XX5PyzIfSdZVqzZhdR4PGdZgnVxl2odvncKJSmH7?=
 =?iso-8859-1?Q?sccw+FJ5JkdSyeTiJX1Y9tXXvgE/d4xINczwh/4jCjtPrD/g06XZzFs4Iy?=
 =?iso-8859-1?Q?9lHgPwmBbWcu3x0cmxC1bceqgOnDRDG85dQEwkkwm+icZeKmAt8wMlg0IY?=
 =?iso-8859-1?Q?8JQIp3kwHWJFZdc4PkkEiBCm4fXYTBw7T20ASgoQ/l+KxIXtjaeP6sufhA?=
 =?iso-8859-1?Q?Z0H24uWRRRkMQnJuG0kfI+ev0u9RY/zOhpbdAsoK3GeAMaUIWzBVxF0jB3?=
 =?iso-8859-1?Q?sOdNAczMCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UXEIM943u/P1a8amFZkS89+TfbFzoD/j6TEVjHiZkwUebtZ2gsMfuSl73SjzZozyz/OCHfneRu3YjSl/76E1+3RBadO/AXWPXABpvT55HFIi4u8Xasnt6+fPVA+w8LYDV+30pIcaq9evaJDhwj5wSyQmBnkyntm6iT7QFIo6B5BqZYtfvcHdoSOSd3yDqP3IZSe0cohuH3Jv+Epp4m8jkK3BLyHHm8Jb3/BG1pxE50Bl4wm37ONj6GLeojwEYgVqWWRJKseom9pVgN2GzzwGJvezdnUTO26v1NMrnmGXlaflcHHnCwk17ljjw0tv4sMugPPcsSYF4InCDK+wnCfSig==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb6f6f7-287a-4526-fe0d-08dec146dd25
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 08:05:23.4669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O31X77Ff1dqPHuwxk2nBbaZstOF/6etDdnX52g/Vp4OW9bLC+la+RLeVzw4BH7W+fnJimZA4KC8PGI5LcFm7M297ldhqshbJwZX+2zRGE7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7009
X-Proofpoint-ORIG-GUID: unG0CT9Yuil3QH0QSXpoxLKx2ONDtR-n
X-Proofpoint-GUID: unG0CT9Yuil3QH0QSXpoxLKx2ONDtR-n
X-Authority-Analysis: v=2.4 cv=GI441ONK c=1 sm=1 tr=0 ts=6a1fe049 cx=c_pps
 a=aMvkJueGaHUSD5gdo5rTxw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=8zSXAInKr9-sn4ztfKoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA3NiBTYWx0ZWRfXz64xCi9gecfe
 1aI4nRzUj+xYMR+VezkOepkmPdYh/1mbg08ny/iQ8HC3Y4AMkgMJ6yD3xmP+uV1hFaDAIERGFC1
 YGx4FoN099H+W47zSaOC7bRKklU5x6eZ6x3M7UuA7u+qr+JGCYmgP2ydVljGQLnaZtL3dEVcrAz
 GUOEC0z4QM11P4ta9XNAW4mE8UPqebgFwVYuUGZ/cEbAERM51Efm07V6TXoEdx48QVuAq34Q1yS
 L6iYpNIO9GbMfxZYC15vdbZk7Y5e6n3ltrUjEWX7c3OkAWZMIR3cnAvyAmJfpi726b01OZ6i55c
 oaGxTyh73CpPV24PE/jCDu/cphCensssllnQhJSW5MXo5gmSZnm9ErwdhsSWpaWfhbeLFa4ZdZc
 6iXSuN/C+6ng3fdMOsehrwAkGZIb8KjoAAF6LY1mfyPr53HW7eosERrfKF5d1jcF5XyCRg87ROX
 mz2SzLCl7j20NYeewTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030076

Horatiu.vultur:=0A=
=0A=
Commit 85ede044f43d ("phy: mscc: Fix PTP for VSC8574 and VSC8572"),=0A=
which is a backport of upstream ea5df88aeca1, introduces a regression=0A=
on 6.6.y stable.=0A=
=0A=
The commit changes the probe function for VSC8574 and VSC8572 from=0A=
vsc8574_probe to vsc8584_probe. However, vsc8584_probe on 6.6.y=0A=
contains a PHY ID check that rejects anything that is not VSC8584 revB:=0A=
=0A=
    if ((phydev->phy_id & MSCC_DEV_REV_MASK) !=3D VSC8584_REVB) {=0A=
        dev_err(..., "Only VSC8584 revB is supported.\n");=0A=
        return -ENOTSUPP;=0A=
    }=0A=
=0A=
This causes VSC8574/VSC8572 to fail to probe:=0A=
logs:=0A=
Microsemi GE VSC8574 SyncE ff0d0000.ethernet-ffffffff:08: Only VSC8584 revB=
 is supported.=0A=
Microsemi GE VSC8574 SyncE: probe of ff0d0000.ethernet-ffffffff:08 failed w=
ith error -524=0A=
=0A=
On mainline, this check was removed by commit 1bc80d673087 ("phy: mscc:=0A=
Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X"), which=0A=
was patch 1/2 of the same series. However, only patch 2/2 (ea5df88aeca1)=0A=
was backported to 6.6.y, without its prerequisite.=0A=
=0A=
Who know why? =0A=
=0A=
=0A=
Regards,=0A=
Guocai He=
