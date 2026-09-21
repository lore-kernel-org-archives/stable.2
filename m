Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288944F560;
	Mon, 21 Sep 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009589; cv=fail; b=L1RHRGeW25Wuae83wj+2xat0CxsUW49ukFAIPMRXvUlEcJfZX0JQ6ngTHNvxJ0D4P/ff/NDlbqdIxUhGarr8Ebz0OUw35rBQWku4gapMGylfYsT0kf/B2A/r1GGHARYJFpmmsxDmeKjQKPZxfCOe1ipHWWm0ZKyzafFKgr9Vj70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009589; c=relaxed/simple;
	bh=RWXo7mP5CtXsBMlCxU3rbtiPVaf1apgbkvUyOdU5hzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9VQ8/jnj7JLddonjjmgCqJB40/ILi02+ehoTe5PYjrt+gTCNLkjhORB/fNRXl10dVU2ZoFwVwJlMFae04LX45g4CXroTlcDCK2WBKhpjadLFme5KJkqbawzMBPeyMXSi1tdYXDSvAnh71zfbRogh3L8HZsfIuw+GJ6eFIZDwfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=CIPEdCs6; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="CIPEdCs6"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFqR9L2074680;
	Mon, 21 Sep 2026 16:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=H4
	pr0MOnZPI8Y/OeuMWm4chXBzaEoFqme5QYmB4K1/I=; b=CIPEdCs6eTTCFHRKE1
	vLCKQQW2OLkVQuw3ZJkprwoWzOnEdDsforuqhCl/kV0cx1+us16wRR4JRDjeBg9m
	PrQI8Fk9laZUb2XygjD4JT5eBYw79re6RTuWkJgRnstN4L8vFLOa2DtotgIBPlmr
	bK/KYmmgS48eyPQl5ov22Xsk952TVhPa5/RStzy0/u1wQLihjIVwazjWA+08VDW3
	Oq0aQ77gZuj2bVqHn40+8LFLIY4XHafMY7BDplOuEx44SNt9q3yOHHb/thzkWtWa
	LoBxFMOeBl9sb94YBvUv06qFQfgBK1ouewb0mVQaM+/AeNYYvbKlxfyroKO8oKRF
	F/lg==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gu7ksgv34-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 16:51:43 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D12AF1478E;
	Mon, 21 Sep 2026 16:51:42 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 21 Sep 2026 04:51:39 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 21 Sep 2026 04:51:38 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 21 Sep 2026 04:51:38 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 04:51:38 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRB3nmR+mrAUNwPKYIVoysBAwETlX5bG4ecaYKSCUfSWzM8hLUOpsU42u/Afvw8Nr+isiCovqX/u5mab64pw7TrL/fQ7UtDC7kbWea0DDsxxhuN9e+gCtELr6EiuL+1DsebIn5frY5LEq7OdK7M4IOrgLi3kQEvQrMzlaVgLG9huLtw01Aa4Y/jN8dnOpwtvGHk6v8R/boCepfEXY5LM8ShIg+zi7UTmTEq9Tf0ZJV80QyZGnLNJ3j99d1s4OCwATEDG7rjDmJM+pzKOtobeuk70bmrk+duiV7j64U14wC/y+HIXn4/rhcZ0piswFdg9Mf7KDupYbmy5U2IJy8SFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4pr0MOnZPI8Y/OeuMWm4chXBzaEoFqme5QYmB4K1/I=;
 b=pinNUeEiqE7dwJ52j74YaLCHH8AYsXfKl6umW8h5IJvBcA4vprxnvrsqHat9qyQ1ZyD/OV6asyPSKlJyrfZ99q0AFB+7wFCwaPigvTY0vnMh04PzIO97njw2LTBfOVinbamjZFXScU+teY9e8rTnghi6OyJx+mEV7LOrZYJCpBBQheSHcqxBB3U6KA3oHoX7a/yb5TBJHIMHudqwn3YEptrZNfSleG0tibaGUueB6DyvuJVlChcmOoj/4IIEFhsidewiYne9N5nKQBuWyEB9pG6UwajOAybGDFm/QlE6D7KDXrytOtD4BRJgY14T45Mnf+cWHJLCCuEXjFd69gDdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CYXPR84MB3515.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:51:36 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:51:36 +0000
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
Subject: [PATCH v2 1/2] nvmem: core: reject reads and writes beyond the device
 size
Thread-Topic: [PATCH v2 1/2] nvmem: core: reject reads and writes beyond the
 device size
Thread-Index: AQHdSel2CkdcZTYQnE+04aav/45GjQ==
Date: Mon, 21 Sep 2026 16:51:36 +0000
Message-ID: <20260921165055.421933-2-sanman.pradhan@hpe.com>
References: <20260921165055.421933-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260921165055.421933-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CYXPR84MB3515:EE_
x-ms-office365-filtering-correlation-id: a7e6c818-7fd6-4fdf-58ea-08df18009968
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: flyPcYrk6YqiVRI0rmVymXxla/2BBngBlVGMumqVOXixcFtCY1Fcw9v/QK1/G/aXEx6NLlHDi6b9vde47daTn/qmDiThSY11/F28no3g0eRHcfoTjqJl4x55bIjVlmiC9/duRW9zsfLLdpk2wxuisOBLO93LrxlMzO84UY/klpkJpU79XwRyDK73hT+GtBqO/4bjNB1sK/L3faksVXpJQnigPHf5Qu+BCSS4CjYCYdPZeUOASkX6fOHW2bWRmA1m38g5JxoBLTgJnpsSE90ZLpD7/zc3hAQdS2YHxqC5mBH2buqsejQ1yT5eRq8g+xsJpI7fdLDm2qj+dqI3RbZLctwlnftIcURLMilpTPINK43/WCsN5YVMdnx+WQxxnLeNCg3gXLJflPJkEXyrmUHe3CNXkcAbdH6uJ+e/W8WKF23kjj0QK3rHL6FV9dhgBVn3fqBNk5GFAmD2uDc3tbQEKuUARlmneiCo5IVemqrB/8iKN1ycRT6bHNi1NE8eZyfbuHFm2NzLyLjY5rmZRImGavBdjMcDRcpbGcpjf30Ghgb1xv5mOJ67V5ua72J6pDcEbXjODi/gnDIXAlQHoqo/ifDcDzQAUbVyixcysvXQFR6oJwtemQ9QhoAkNapQTiEZwCsEEh+gqJz3Kyu4gOwcjiUA15os1CqCIH3PNS3Mw4NRI5lp0l2gFdWKhZjEGcDybmkQe9Evl1RFMsVD/AgPTzR/Eu5x2FQa+CcW0W+Bpnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U6/zxa1YY1clsEcrlz+cXfLEzzMVSjYzcufeOw4U/Do12bvAu/z2kGqelR?=
 =?iso-8859-1?Q?Q9nZLQpeOXpG7nTB8kbI7V6yUY1vdy7T6Q8waX5cGhJSDWbTZ8ubzMNiXT?=
 =?iso-8859-1?Q?XkWkkxG6ceakX6o6AQ2XLCkCdAfickEhsoQuOZWD86uzOzMm6X/M0zu2wE?=
 =?iso-8859-1?Q?7P2lDOMRBEjE19IHSKfFRqTS2avgtwxOJK3Q/eeqNKOu2Jbkq/UiSYERtR?=
 =?iso-8859-1?Q?ikbCcHGNyOn660mk3Uhp7xZDjNV7gsLAidQXbG271pE0QW/LGGzurRhyAM?=
 =?iso-8859-1?Q?yphxjBmt6vehc4EG8qFtf8k4+j090w1uNo9gDvQsYEDIIuI+uFy4UbHJR1?=
 =?iso-8859-1?Q?DI5FbGCzU7w2r6eqg6R2p7VRao+qi1AtvgoDY0tzoj222blPHlvZeG1rKs?=
 =?iso-8859-1?Q?lk/xo71aEWlPfh5ETPp9CxQPErkPvhHnBM9/TsPqqoVf+Yku1moM4Rg1Fw?=
 =?iso-8859-1?Q?yVs/CnTf2TzdDNvAMpXLUaKDTLhhds6iYPISv1yseb1Fos4Wbp71/l9mWV?=
 =?iso-8859-1?Q?hGJ4ddQ7BI6PH9JwFS5Pzeu7wf7jlw9VD7BgRnSsDC57eAOEBad5eKym7K?=
 =?iso-8859-1?Q?PZ0sscuLXIq56MpH8kHN+0YQxncx6sYckQ0XaPW1ZCjjhQxzGEMtFsfugt?=
 =?iso-8859-1?Q?vSIp8u2dtC5WtRoEdK+CB/+MhsxOhOM1hsdATgXe5U3L6bOtnCw+R6BLl2?=
 =?iso-8859-1?Q?OySQQC2Qq7JgQkMVBEFwCoIF5O2ZWd2mCWdOqiGD0lPXeRDjVLfUkXQR+L?=
 =?iso-8859-1?Q?2+Yu+nUkhKohHd/Y+f/voWCr3+bFOEIVQmKDgVjKNPmxCG4zRhkmmvlREx?=
 =?iso-8859-1?Q?V0I3R2GeY5ExO/WWgyNLWyRAptccYUp66tdYXitffVI+sztzdSUfcQBso9?=
 =?iso-8859-1?Q?InKHk9jsdEJPh74gQkaEbAlQI8RnIYvrAr0J0K3Ru+b8GlOWCJ4BOKYufK?=
 =?iso-8859-1?Q?Lm+mTIlxaWiAEmjC9JlnA/rYpDNRnwcpKTaXRv+1OpztKSS9zLPO4B6NNT?=
 =?iso-8859-1?Q?60Tf2TEivebZDGjuNzHIQTPCEccyf7uH0oNnRzlZq27YljnFKTrxo5EMhp?=
 =?iso-8859-1?Q?mnOSy1//FVmhbLDw/wuiU8RWZJmHlHXkowQP/AIY18pIW0hnqYAf9Bpo32?=
 =?iso-8859-1?Q?agTOXKGb8QefETYkzd5ateFj4jc2byVdMqw/qeXySETtSTMH0TZSdJ/Wfc?=
 =?iso-8859-1?Q?kE7fsTI6W4GpIBeTvHMhPSZHLzCRxiSG+U0mC78XZxFCbALZBh1kWRKJw3?=
 =?iso-8859-1?Q?lNH/VT8+F7ciwd/L2IgdDB4UJhcjoimgKHUWda95LK/chgHLrlVIzwKAKE?=
 =?iso-8859-1?Q?SsNnFfQIOouzUYgE2hPycGcb3ey/1A+5efPzYOxV+e8+RCB5IC6AfOdOki?=
 =?iso-8859-1?Q?WH2ZQmSM/iRuVkPfz+Kms9cG2q5uDVhJd+REZ2vEfS1a04vAaqiHIa6vhU?=
 =?iso-8859-1?Q?dG/1Ac1FZkltkOqojNfga7/NtEM9GFI3If2m5n66ZwgUAwf21Z7fTF2C6/?=
 =?iso-8859-1?Q?OpGN4FsRrEDUW12D7poi4Wv2l5J4Tfy4u8wUW4KFXUM3N8YI+DrIAEMMln?=
 =?iso-8859-1?Q?c8X4dEC4qWDm+65cDWelXnb4//pm6UWBrqXNVUuMSeFm7dVxB5UpyWhRdu?=
 =?iso-8859-1?Q?WPq3eidGpoIvoBzShbzt3VYXUAlMvA3rPHYbYWi8ae+fxZ/W/YMsXgUE+d?=
 =?iso-8859-1?Q?5/X8RcKM6rKnQkbCyZAs6OCE8S+bO+vUUVZfq7JvXILFlueJxN3d/I6MNj?=
 =?iso-8859-1?Q?zg24EdZRB7OOJWtRuRqXTYV38dWrfQM5YeTsj8S1Ogq62lmBBJmm4jeQfB?=
 =?iso-8859-1?Q?oq3UPPXqCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cd0wXHt2SJhQmz9VQUJiHVz6CRg8BZKtFN6LT91dn4+UgyJtoYI17m0JaDGXwz0qqBz699+40N4VtHU68A/G4d9Q4/uKg1Jrwh8pqAdOBJY+HXRcDxE33ie5lx4774HZoYYNHIxltnQVsVdsYy7f2Rj8k95V0cIr5mj4JoEUA9SeQUvLHZlArSE7g9nAQljBPZdFNZFcHwvC90b6FB4+G4WkMs0MBl/vgreEAtuTithhxvvNGBkcAMbhKpLIuCKNGambXT2hr8z+aKsdoLgfixPIQ55gvOP6nZfc9P1GlxWScLwyHkIozCCxkcYydfftSl6/Xfb1MoL/ZCumRCdmCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e6c818-7fd6-4fdf-58ea-08df18009968
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 16:51:36.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2t/OBmc/z7O/ryjSWruXy3qEN+pZomwe7Anvb1g0IH4K4wxGyNA0xtLxqhfsZcfCfCJSE/sxll5GOCDMwf7L/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3515
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6ab1609f cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=X6WIv8QqBXgotRSfPDAA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: 8kA1iPSIXP_MOL-tca7vd7uPMZQbFlyg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI0NSBTYWx0ZWRfX3n28POSjmJBt
 FXlxEspPwpJYlPdKy1yGOaHFodemVHe+KRp03ZgnVCrBN/l41ev8BZJ9+13i3qWKpLc+s/sh5HH
 F/b2yFv23hrlgy57TxG+Tbsvf8S65u8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI0NSBTYWx0ZWRfX6g5yASlk879i
 x1bD1yQb+FB/VEkmmMlKLS+94WNtUDXtCzrxWbOQk25+mGcef/XLqLlvtuqW2VtaulNPe3CiXvN
 Qaza13FL8xyBd2+IVbrC+d2l0K44q20J7X7CdmYRDW9PFS4KcDxmjQEwmLmfZGUaDXuK8bipteH
 09UqyzymQLMA6JVAQTH5D29qGPW3Juxpju8+VmjEZk/sQnaVZQWZT2vMPdbjuPeg9vrGESytd14
 KOqCSzCXj90fFZfibLRIghQHkroffq+Cdiil7F8BAhrUjSITas+YZc59RsU1E5xJTduslo3Q+90
 wnlPiOMInwk/zTacqOCkF9x6CeHfrNBAt4kXHrs/wxXx45ZjzBMIH0nlvrZP3JcdYc2XDwYwabS
 JKRkxl7lSkjU4kJX3Ti4TzKEpxxGBz2n0gyfCBaarSrZsLnlYkc1w44yZewctMGaaQT090y4Vsc
 ezKVd/yvefQFM+/DwGg==
X-Proofpoint-GUID: aCbWyv-Jj00NIAvaaXNaFXvbQC6YrvSB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210245

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
nvmem_reg_read() and nvmem_reg_write() pass the requested offset and=0A=
length to the provider callbacks without checking them against the=0A=
device size. The sysfs binary attribute is bounded by its size, but the=0A=
in-kernel device and cell APIs are not, so a caller can request a range=0A=
that extends past the end of the device.=0A=
=0A=
Add a bounds check to both functions so out-of-range requests are=0A=
rejected before keepout processing or provider access, rather than=0A=
relying on each provider to validate. The subtraction-based test avoids=0A=
an offset + bytes overflow.=0A=
=0A=
Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")=
=0A=
Suggested-by: Srinivas Kandagatla <srini@kernel.org>=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
=0A=
Changes in v2:=0A=
- New patch: add the range check in the nvmem core instead of the sprd=0A=
  provider.=0A=
=0A=
Compile-tested only.=0A=
=0A=
 drivers/nvmem/core.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c=0A=
index 0556d140170a4..ca90b24d73675 100644=0A=
--- a/drivers/nvmem/core.c=0A=
+++ b/drivers/nvmem/core.c=0A=
@@ -154,6 +154,9 @@ static int nvmem_access_with_keepouts(struct nvmem_devi=
ce *nvmem,=0A=
 static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,=
=0A=
 			  void *val, size_t bytes)=0A=
 {=0A=
+	if (offset > nvmem->size || bytes > nvmem->size - offset)=0A=
+		return -ERANGE;=0A=
+=0A=
 	if (!nvmem->nkeepout)=0A=
 		return __nvmem_reg_read(nvmem, offset, val, bytes);=0A=
 =0A=
@@ -163,6 +166,9 @@ static int nvmem_reg_read(struct nvmem_device *nvmem, u=
nsigned int offset,=0A=
 static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset=
,=0A=
 			   void *val, size_t bytes)=0A=
 {=0A=
+	if (offset > nvmem->size || bytes > nvmem->size - offset)=0A=
+		return -ERANGE;=0A=
+=0A=
 	if (!nvmem->nkeepout)=0A=
 		return __nvmem_reg_write(nvmem, offset, val, bytes);=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=
