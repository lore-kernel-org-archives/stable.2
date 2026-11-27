Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=91.207.212.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795785664;
	b=MSD5Yjpe1MZmfeV0MP0P6LaOtQq7eNtA3VHzwjdYKPOi0uAFIkB8UquiHcBWGd6c6Pio
	 nLwbHODA6/MHh+uJfqCrMoXTeLw6tZMM9WCznSdjD3e7Q1TuN1iqdchMXHQn9MIJT03ZB
	 AvY3G3KErN83GFBdM5myqd3MTr1L5TpMojZMrLiPb49YQSmLYDPSTv6tDmxvfvALpnYmI
	 v45y2ochfsaDtVOcW9cG1BMU11oHvkyWs0zoWSWK6g4u++TW7TXrscxLVz7+iaykpoIDy
	 vYKCtBHATzZoGnY9xbEuf8xYq85f7YjV1SmsopfzmdSztg1DU9AIDE9qJGH4+5uHzLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID;
	bh=+x6Bc3vdsmmAxYKPbCduitgepgAXrOLRbAFFqKLjinY=;
	b=daR1ved0v0Vi1cXMhyhNc3LfNTkGztPmOfd14lxWNOczigw4Tjg6incxOPzyYV0RRzp+
	 tZs/y9aI8jYq68w7iThE2SUp4j8/glj/pOuwQmXf6bLFxltnkxrWFYwRvwrrpASEer0Y6
	 jxWlfMeGclTD8MpbcieoYEbLUOqE/Xh9bgcXc2Q502+WrKsoNHs1X243pWC/7V8k0MbMe
	 NBW2UAI61NQBzFKewoCoTyD0Nrw/ONHTNWfWCoSFfAMTlYtwqdSvM6elM5WD3GSk8fe8B
	 GlRKY0mLzmGXRfdigll8IUDkVhxjzrNJ3lr5u12CMmfpMbYhFwEszt5m4Xe6Tqyg9PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imgtec.com;
	spf=pass smtp.mailfrom=imgtec.com;
	dkim=pass header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=DHSoY2ec;
	dkim=pass header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=aMKC2dYb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=91.207.212.86
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF017606A326;
	Fri, 27 Nov 2026 13:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF017606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=DHSoY2ec;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=aMKC2dYb
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id 6ARDK5wD3626703;
	Fri, 27 Nov 2026 13:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=+x6Bc3vdsmmAxYKPbCduitgepgAXrOLRbAFFqKLjinY=; b=DHS
	oY2ec6CTxpx9yX9sVqlSHpag3gOihO8gzyu77VxZbr3F8RwkvheRk6Rg3MNDvMwd
	9+kRZyfWZ1idJwCEUSVPolrfYQPswLQETZ+APgcRs6SKOnzz8/M/w2D2ZYowBqcf
	Z9ouZvqmDwBjSOHYi0SfAKUHR8eh3edHF7lllah0tdPx+T6gLmDDJUQeKgb4l9m7
	iKgFIQLYSIWFWv9VZpMJ2TjVyNHnpHByT65umnDRTmmxRLLrAsgKk1ekQwZgIPIH
	AAELPjbybhsXa5fX4vssgbeAM4gaJKmW078rhJk5X+aupGecm+9MJ+xKKLFOi6Tu
	KaBq/HEBRC4QulBoF1w==
Received: from cwxp265cu009.outbound.protection.outlook.com (mail-ukwestazon11021140.outbound.protection.outlook.com [52.101.100.140])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4j32ev4j1n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT key_exchange=secp256r1);
	Fri, 27 Nov 2026 13:20:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwYWeXHZi30XniI4t7WAQZaEAv71D8xPoS8YfIxgtmEvBuaI1GgjGCUo+dALJiN6sI10k1FmlefNvhxQL4Tp1MUmviZFgGUeumFDhuf3lcz2ufzF+7FK/3L7pH25Htzex73aRjhZ8qSjoNAQrAa5bG23aIQw4wIYbix24NHDXsvEw+5QlQJkQKSKZL+rOXVqKLJM8ABuAn/wQg2QLLd1c27js20OXu0JqAE4IaS4kakOZO7maQ+Q+axMpE0kZPzBxw9eXVg5D99J6wb/JZ7b7v6NtUP/8DxIcXVdvHBgPjkhxlmTakKjUYTk4+MM3oqG4xSBd2qpwqfNBfMLqDnwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x6Bc3vdsmmAxYKPbCduitgepgAXrOLRbAFFqKLjinY=;
 b=Kr+uzQYOXyvfzMg5u+fn59BoQhcP1UzfFxH91ycBjoLgvdbCSuJ/8RODEkSJMLY6Nf1n/oUS57PoDWxDlZ+QP7MypnoJFA90AMg67bMxSO78HNjVi86bTBEFsQqoSiKbQfroqucmm0CFERbxIOmQzxS2v7RJPrtof1tWjwoYqr+zQc+p9ProfmEtAAgqOlo7I1U5mDrz1JgUykItpw+irtRfHV8e9XWN9j+qCT6uCU6LFZcu93u/VXqTRnGwVyj1hyKL4O7DouE36FzZjDySd7tftOKN+WqJNPC6w/I38J5P76gE2NhUFWQJ3ptvOzckA/G+4nLj4fFYfNYe/grFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x6Bc3vdsmmAxYKPbCduitgepgAXrOLRbAFFqKLjinY=;
 b=aMKC2dYbb8EJdzewADk5tpttQdTNJvwBddzNZZso5xouJ3WuyqaULo1hFFDNTv8AgEnchk+Q77epjQPxWDj5LOAIqd9zumJJ400I2gHhL4BiFBNooYt/wiDlRDVSOwhUy8VCCqbwXFXbqda6KeiKl964fmEc+wY2mdJF1RevG0U=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LOAP265MB8360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:472::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 13:20:23 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%4]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 13:20:23 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Alessio Belle
	<Alessio.Belle@imgtec.com>,
        "ryanbrue.dev@gmail.com"
	<ryanbrue.dev@gmail.com>,
        "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org"
	<mripard@kernel.org>,
        "sarah.walker@imgtec.com" <sarah.walker@imgtec.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/imagination: Wait for the firmware's interrupts
 before stopping it
Thread-Topic: [PATCH v2] drm/imagination: Wait for the firmware's interrupts
 before stopping it
Thread-Index: AQHddrqV1yLLJWEd40CF/bGZdgUnrbdB9qWA
Date: Fri, 27 Nov 2026 13:20:23 +0000
Message-ID: <0eb9e32b040c698a5c0fa9b68debbcbaa20e3c35.camel@imgtec.com>
References:
 <20261117-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v2-1-780e31f25220@gmail.com>
In-Reply-To:
 <20261117-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v2-1-780e31f25220@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LOAP265MB8360:EE_
x-ms-office365-filtering-correlation-id: 8816c58a-740f-42c4-a2d7-08df4c893197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|23010399003|7416014|366016|376014|38070700021|10067099003|56012099006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261022115727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 q4N2AaNLsI1M51QGR8f/0YOKKmI1RrQrtCrS+ZCicueFxqOTn/yHFzhdnAicsJN0sKkN2VfNjYNqDeXnHcwNmoERcWLCVT/CzZ85s0DclW+/jLWjiPz7QMcp/FqNuIgYcWerZVPEPatDXyoWauphKrvF9UW6AjfhOTKhsZO6YQODBx5Ih1DZVtlTNhqMg4Bf0XuJ6o4ZRpnON0m2CG9abOcGQOiGE1Q2dytZW+gsWkMNnAUdMTY1WTKWa9pASmeRdzNYw3xGY0TTHAbQLypRZMFwEDaexun+ehBu+AoKlBT9iZbotFj0uKmdnrK2GFRrPfdAeV0BxBCW3zwJqF3N4ii/dcFvTXHJkqyzqj+Sf7BLGvC17GDFeBM9LbzIESfBjmmP0M8V2HgJKWsy0z4LBk6D3RL3mky6+Qzl+dZGn+pDGZHWeBuwPoE81GrpqKtFOGTKlxiL1sUEQScPB8FMOlSN9RD1YI4FgkSrMK4riMycRbAk/xrvG+EgXWSwio+ti8lCNYLxDVNWSK+GFa9H2rlpFrbMh7p8gGzbcZr/zeeOb6jehMhCmv6MRyx3gfm3c6xHo8NLR8YOrR+i92XWBt2Xk9lBEHHc9LHKXQTdP6F//402codsinG1y2ll5xXusKnj8inqXc4X0TuZKSAJYMqL40ns20IS0tjBHn9+Soo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(7416014)(366016)(376014)(38070700021)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261022115727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0RWcTBLd0RuYnR0cEUzQ05CSFA1R3V2VzRjcjlNKzB0QXEyeW1XaTNpd3pV?=
 =?utf-8?B?NzZ4cEZSeitKT3RxL1l2Ly9tM1Q4dVpGVUlBZ1NhdkV3RGQ2VGkrWk5hNHBI?=
 =?utf-8?B?NThXWGMwUksvcUs5WUxSRGcxTERJNkkrTHVPYVFtWXdPY0xhQVpYTEM5V3Zi?=
 =?utf-8?B?UnphTjd4VU1EM3RuUzQvYWpxdnBnbUtxb0pSRU5Tbk5lRWs4M3Q5cERXZU8v?=
 =?utf-8?B?MjJ4VHRXY3cwOFJ1NUY0NXVvalVIWWpLUkp3d1lhUEE2dk5FUU5PMjV4S2dt?=
 =?utf-8?B?UWZ3NnBrQmtiTXNoRU8rcVRyeUlaZS9oY0U4NmFySG1pRmhXU3EvVzcvUGhF?=
 =?utf-8?B?RnRtaThPdHpmVzFXVW5zbTkxY0YrcUhZZU4ySEV0bTltaExDUHFYWUFnZEpS?=
 =?utf-8?B?ZkY3bXU3Z1VhUUIzQXB6UEVDVGgxM1JFb1JSTlU0NDk5RkhBeWo3WHR2eHVa?=
 =?utf-8?B?V20zSmh1NWJ1eXpjWUk5RUVYbHJWMlRqRUZsMWEwWUw1eklHaGk5NGh5d2pM?=
 =?utf-8?B?VDlEcEp5OUsvMkN6MnNRMEtpUFp3QjdkZUlXMnNsR3RlOW52b2Jhc0hhM056?=
 =?utf-8?B?djNGZEtYWnJSNk9FOVBBMk1lZ3FmeEVFL0lkQmhZQ050ZzBHcGdZTUVlNXQ1?=
 =?utf-8?B?RFl3QytsUlJDUXd2K21mbXp5dXhqQzZPMkhtaG1kQ0pBemI1aTZUK2hzdzlO?=
 =?utf-8?B?dDFhS2trYVNlU1VvblYvelZkMWEwc1l3TThZZjJSQjJiaEx3Uk1ackJORkxy?=
 =?utf-8?B?N0ZaYWZHb2ZQejdSeFFpaWFlTmZoRDQ1aHNrbGVodzdSSVJTNGh0S2o2QXE5?=
 =?utf-8?B?Yi9RQjg1K3M5OVBpWjFpc1FocXpacVNWMWxuVitjK0FYLzlrdUcvSldvZ2Vy?=
 =?utf-8?B?S1U1RUc1cnNPWlJxWDdSZ2F2VW1qUy93a2R0WUI3QkcyNzRkZ2lOcHdxNDVi?=
 =?utf-8?B?Sm9weWRERHlhQkwrcVg0RHplRzdoMTFOZ2ZBWE1LSjVsNHF4bmdRUFRucExE?=
 =?utf-8?B?eG9FUlpVTk9JR1JaVFFPSGYrbHV1RFAzbkgwZzdncnY0TVpHZVBxZ09EU2Z4?=
 =?utf-8?B?Mk9tK3lWUmxTY2hGbVBYNUlkV3NDcGN3aG93WTZMV0liOEhGUEw1bTRsKzFp?=
 =?utf-8?B?aU9ObWtPMEx2VUx1dzFhY2VLS29Oekt5TG8vcmpzRysweFUwM0ZlR21ib2kz?=
 =?utf-8?B?bUo2Y1FXU1JnSVBaaUk2alhOU0h2eXRJZ0VCTi9KNVpPTTRRd05VRXpFMzB0?=
 =?utf-8?B?SHA0Q1hNeE5DWThuWUU2YSt6STduYkRhV05PVlVES0p3RmxiTU85TDNIbjA2?=
 =?utf-8?B?WTJVNFA2Z1NJYnBZZ3dVNDFSb2xNb2tuVlc3ejA2d0tDb2lpUDV6TXA0UTRK?=
 =?utf-8?B?OEZScktCZlhXRWpNcEI4ZDJHdncwRVFkU3NSUVhMYUF1V3czWHJJQmJlSlk1?=
 =?utf-8?B?YmZQa2JxUFVlSXZMLzVBRDZnOHZtZGdPUFp6dEhCK0JlWTRmSkJjdm1QTEl6?=
 =?utf-8?B?Ulp6d2Z0V0w5Mms3Sk1IamFuUE1XWVpIVkhYT1M3OHNmYU9sdVA4SVpMNGhZ?=
 =?utf-8?B?M1lBNmZQMDNJQzFvK1A5akg2K2U5ZXBKU2lFQUJONHNqZHNGbDRUSXdMSmRB?=
 =?utf-8?B?alV5bGp5NjIxT3czVitldng5YUo2b2g3cHdYMWNad0RVcDN1KzBmcm9XbzhX?=
 =?utf-8?B?bkxvQ1Y4VEFtM09XaXhOaEdnUFRiK3gwZlFBbFJ4TmNVUGJ0bzZ1eDh6dHVi?=
 =?utf-8?B?dktOZlI0ZmF1SnhpRGtCSjZIWFV0bkVVS201YmdEWjVmY2FPK3pnSEl4blpw?=
 =?utf-8?B?QUMzK1ZhNFo1TVkrS3RoNG9QYTBYS1R1bVVmZ2NrZVl1MnlMSldiRHZ0Qm1m?=
 =?utf-8?B?bnk3S05UazJ5UzFKVEJQK2p6REMyTEgzdGd3T1VSRnVicFlHeEIwdWloMEhJ?=
 =?utf-8?B?V0toYitnSG5jNnBQci94eFdtWkFPQ0tyWEd4eFIvWm94UTFFZG03elZ6QzlW?=
 =?utf-8?B?N2tvV2hEYTBtem0xT21LaEVRRHpoNXhDM0s0OUVuVjhaQk5FTVphSnRicjBJ?=
 =?utf-8?B?M2ova0l0ODBDMEphRy9PbDJHY2RUcWpUYzhMOXVXdVMyN3pTQW5KRWl6Ullz?=
 =?utf-8?B?dHlLSitxZnVwS2FEY21PSHNEUzluMHgvbXA4QlFpcnN0eGJPMm9aTWhCSW9i?=
 =?utf-8?B?S25TNkpDTk9xY2NwU3dGQXorSDFBb1Y1ckxhWlVlaEJDdHhYLzJIMmF1azdZ?=
 =?utf-8?B?R1g5MFJCcXp6U21zaTV2YlZjejZQT1R0MThrV2VUdjIxa3haQ0dqVE81b3VF?=
 =?utf-8?B?emtYUm1QVElxY010dGNpSElHU01mN2g5NzB1YllHUGkyOHVuMm9lYUpwcWF0?=
 =?utf-8?Q?tIecJiG8iLbXVJ4FxR4G6W6++hZnR1G0f0VNmCmJVCpxV?=
x-ms-exchange-antispam-messagedata-1: wojg8+hNVZZ/MplapLBq7HDgnKQAtK2sj4g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67D079A8EE53B54A935D89B6A292527B@GBRP265.PROD.OUTLOOK.COM>
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
	iyHdyYwvfuYnncuWlYJXhlArDhpae4+0Na5ka7IBRdLs15OGIkepP8X5f6jgelrtqSIwK3dFfDwtFtt3M9YRW/yKG1onPDBk/ubKYMRVI6cW6WN0k9GC/WLijEL+wA1TQt8VvantRaEJ4FALE6DlxNaaoM5CR0IQ9eIL8xkYZhylQDY6fY/b/12lXjZaGwIT5e2i0jPBkYEvRI3NpMQodxenPn1zgycBA31Bn20OWSinJ5ZzMjR7H80hBQmvTBQTDecnqu0Wy+IexWzd1baHdTFNraydoYuO34eZvOJ8LuYEIFZ/01NBFaw06Lqygfh+/HXswEIeBhU8D+yg+43qlw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8816c58a-740f-42c4-a2d7-08df4c893197
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 13:20:23.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hmdY1dI2SEg3wXFb9LmH1yxyjiTXeuxc5L2MHI7s9kKrrVqEM8khB1E38jQqAHDOfShMj81vss0BOsv/FwNBfquCB3xe7YbMZ51wsOMG+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8360
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MiBTYWx0ZWRfXwAFo7PVd3hBe
 mG/laoaJ0vv9nhSMNxdNtOkiv/lwLMj4+y48kF9EV570pUuJ4kk9bVjImWO3IFb5nBEmVtNvtvz
 3frYeFewPTjIm/mKofsFmZtRnXO6uVA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MiBTYWx0ZWRfX8WjvzaGNN469
 LfRsbMojJzP/bhRqVZPR3Q3rNBjX4ydeYB6C0u70ASXeIa06sPsNDswVxZ8Snv0aAtcAadkOeQ9
 sbej0zdW0D4PcHzk5uY7P0YLVOEHcfqEEixo6zfU7mH7DhRhqnc3KsFzEqQs59SK/xGG8JYLESU
 7liDDkfyiu88VvIg43j58Z6q7rK/banxBtQNzviLkpjfaNaMMq+YdB4XEpeP3mDkg+A0fJqEsR8
 qc7FAF/F0xwKi9Z+Pr2Gmu1Rj07VbkFtap/6InEqzIDVFDWIochQ7U+5Fz/g+WCL4iwSOoHrNdp
 by07oN1JXn0cNgmKVLNvHKkj8A6JvkXe30S9QY9JfJYkwj3/4DHcC9c4ysTw3F6phzkoMucCI8I
 y9zTBkd0BoYJR3sBhQxNx9/ytnDB2zJpm5s8QxsnZY4qNnvWVc/vuB5Z0nA0GXQBhjSwWmat7Q7
 EtghpSOAhZYthtwaBgQ==
X-Authority-Analysis: v=2.4 cv=T7AZ3PKQ c=1 sm=1 tr=0 ts=6b09839d cx=c_pps
 a=k+0uX8idyWF9koV3rWdvhw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=94noyIIGu-a-l1EgvLoA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: I2o_UuOFN3lvWdsPexVuAqGf8oHuPIQS
X-Proofpoint-ORIG-GUID: I2o_UuOFN3lvWdsPexVuAqGf8oHuPIQS

T24gVHVlLCAyMDI2LTExLTE3IGF0IDExOjM4IC0wNjAwLCBSeWFuIEJydWUgd3JvdGU6DQpIaSBS
eWFuLA0KPiBPbmNlIHRoZSBmaXJtd2FyZSBoYXMgYWNrbm93bGVkZ2VkIHRoZSBQT1dfT0ZGIHJl
cXVlc3QsIGEgcnVudGltZSBzdXNwZW5kDQo+IGRpc2FibGVzIHRoZSBJUlEgYW5kIHN0b3BzIHRo
ZSBmaXJtd2FyZSBzdHJhaWdodCBhd2F5LCBldmVuIGlmIHRoZQ0KPiBmaXJtd2FyZSBoYXMgcmFp
c2VkIGFuIGludGVycnVwdCB0aGUgaG9zdCBoYXMgbm90IHRha2VuIHlldC4gT24gYW4NCj4gTVQ4
MTczIChHWDYyNTAsIE1FVEEgZmlybXdhcmUpLCB0aGUgU0lERUtJQ0tfSURMRS5HQVJURU4gcG9s
bCBhdCB0aGUgZW5kDQo+IG9mIHB2cl9md19zdG9wKCkgY2FuIHRoZW4gdGltZSBvdXQuIFRoZSBz
dXNwZW5kIGZhaWxzIHdpdGggLUVUSU1FRE9VVCwNCj4gcnVudGltZSBQTSBsYXRjaGVzIHRoZSBl
cnJvciwgYW5kIGV2ZXJ5IGxhdGVyIHB2cl9wb3dlcl9nZXQoKSByZXR1cm5zDQo+IC1FSU5WQUwu
IFRoZSByZWNvdmVyeSByZXNldCB0aGF0IGZvbGxvd3MgY2FuIGZhaWwgdGhlIHNhbWUgd2F5IGFu
ZCBsb3NlDQo+IHRoZSBkZXZpY2UuDQo+IA0KPiBUaGUgZmlybXdhcmUgY291bnRzIHRoZSBpbnRl
cnJ1cHRzIGl0IHJhaXNlcyBpbiBpdHMgT1MgZGF0YS4gU2FtcGxlIHRoYXQNCj4gY291bnQgZXZl
cnkgdGltZSB0aGUgaG9zdCBjbGVhcnMgdGhlIGZpcm13YXJlIGludGVycnVwdCwgYW5kIGJlZm9y
ZQ0KPiBkaXNhYmxpbmcgdGhlIElSUSBmb3IgYSBydW50aW1lIHN1c3BlbmQsIHdhaXQgdW50aWwg
dGhlIGhvc3QgaGFzIHNlZW4NCj4gZXZlcnkgaW50ZXJydXB0IHRoZSBmaXJtd2FyZSBjb3VudGVk
LCBhcyBJbWFnaW5hdGlvbidzIERESyBkb2VzLg0KPiBTYW1wbGluZyBpbiBwdnJfZndfaXJxX2Ns
ZWFyKCkgcmF0aGVyIHRoYW4gaW4gdGhlIElSUSB0aHJlYWQgYWxzbw0KPiBjb3ZlcnMgdGhlIGNs
ZWFycyBhdCBwcm9iZSBhbmQgaW4gYSByZXNldCwgd2hvc2UgaW50ZXJydXB0cyBuZXZlciByZWFj
aA0KPiB0aGUgdGhyZWFkLCBhbmQgcGlja3MgdXAgdGhlIHplcm9lZCBjb3VudHMgYWZ0ZXIgYSBo
YXJkIHJlc2V0Lg0KPiANCj4gRml4ZXM6IGNjMWFlZWRiOThhZCAoImRybS9pbWFnaW5hdGlvbjog
SW1wbGVtZW50IGZpcm13YXJlIGluZnJhc3RydWN0dXJlIGFuZCBNRVRBIEZXIHN1cHBvcnQiKQ0K
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIEJydWUg
PHJ5YW5icnVlLmRldkBnbWFpbC5jb20+DQo+IC0tLQ0KPiBGb3VuZCBvbiBhbiBBbWF6b24gRmly
ZSBIRCAxMCAoMjAxNyksIGFuIE1UODE3MyB0YWJsZXQgdGhhdCdzIG5vdCB1cHN0cmVhbQ0KPiB5
ZXQuIEl0cyBHWDYyNTAgKDQuNDAuMi41MSkgaXMgbm90IG9uIHRoZSBkcml2ZXIncyBsaXN0IGFu
ZCBydW5zIHdpdGgNCj4gZXhwX2h3X3N1cHBvcnQuIFdpdGggYSBjb21wb3NpdG9yIHJ1bm5pbmcs
IGFib3V0IG9uZSBkZXNrdG9wIHN0YXJ0IGluIGZpdmUNCj4gaGl0IHRoaXMgYmVmb3JlIHRoZSBw
YXRjaC4gQSBkZWJ1ZyBidWlsZCB0aGF0IGxvZ3MgdGltZWQtb3V0IHJlZ2lzdGVyIHBvbGxzDQo+
IG5hbWVkIHRoZSBwb2xsLCBTSURFS0lDS19JRExFIHJlYWQgMHg3YSwgR0FSVEVOIG5vdCBpZGxl
Lg0KPiANCj4gT25seSBNRVRBIGZpcm13YXJlIG9uIHRoaXMgb25lIEdQVSB3YXMgdGVzdGVkLiBF
YWNoIGZhaWxpbmcgc3VzcGVuZCBpbiB0aGUNCj4gaW5zdHJ1bWVudGVkIHJ1bnMgd2FzIG9mZiBi
eSBleGFjdGx5IG9uZSBpbnRlcnJ1cHQgKGZvciBleGFtcGxlIGZpcm13YXJlDQo+IDE0MzIwLCBo
b3N0IDE0MzE5KS4gV2h5IHRoZSBNRVRBIGNvcmUgdGhlbiBjYW4ndCBnbyBpZGxlIGlzIGluZmVy
cmVkIGZyb20NCj4gdGhlIERESywgd2hpY2ggd2FpdHMgYXQgdGhpcyBwb2ludDsgYSBmaXhlZCAx
cyBkZWxheSBpbiB0aGUgc2FtZSBwbGFjZQ0KPiBhbHNvIHN0b3BwZWQgdGhlIGZhaWx1cmVzIGhl
cmUuDQo+IA0KPiBUaGUgcmVzZXQgcGF0aHMgd2VyZSB0ZXN0ZWQgd2l0aCBhIGRlYnVnIGJ1aWxk
IHRoYXQgdHJpZ2dlcnMgYSBzb2Z0DQo+IHJlc2V0IGFuZCBjYW4gZHJvcCBvbmUgY291bnQgYmVm
b3JlIHRoZSByZXNldCdzIGNsZWFyLiBXaXRoIHYxJ3MNCj4gc2FtcGxpbmcsIHRoZSBuZXh0IHJ1
bnRpbWUgc3VzcGVuZCB0aGVuIHdhaXRlZCB0aGUgZnVsbCBzZWNvbmQgYW5kDQo+IHdhcm5lZCwg
dHdpY2Ugb3V0IG9mIHR3bzsgd2l0aCB2MiBpdCBkaWRuJ3QuIEEgaGFyZCByZXNldCBvZiB0aGlz
IEdQVQ0KPiB0aW1lcyBvdXQgYW5kIGxvc2VzIGl0LCBzbyB0aGUgaGFyZC1yZXNldCBwYXRoIGlz
IHN0aWxsIHVudGVzdGVkIGF0DQo+IHJ1bnRpbWUuDQo+IA0KPiBJdCByZXByb2R1Y2VzIHdpdGhp
biBhIG1pbnV0ZSB3aXRoIHZrY3ViZSAtLXByZXNlbnRfbW9kZSAxIG9uIHRoZQ0KPiBjb21wb3Np
dG9yJ3MgZGlzcGxheSBhbmQgdGhlIEdQVSdzIHBvd2VyL2F1dG9zdXNwZW5kX2RlbGF5X21zIHNl
dCB0byAxLg0KPiAtLS0NCj4gVGhpcyBwYXRjaCB3YXMgZGV2ZWxvcGVkIHdpdGggdGhlIGhlbHAg
b2YgYW4gTExNLiBJIGtub3cgdGhlcmUncyBhIE1lc2ENCj4gcG9saWN5IGFnYWluc3QgTExNIHVz
ZSBmb3IgdGhlIHBvd2VydnIgZHJpdmVyIHRoZXJlLCBzbyBpZiB0aGVyZSdzIGEgcG9saWN5DQo+
IGZvciBkcm0vaW1hZ2luYXRpb24gdG9vLCBsZXQgbWUga25vdy4NCj4gLS0tDQo+IENoYW5nZXMg
aW4gdjI6DQo+IC0gU2FtcGxlIHRoZSBmaXJtd2FyZSdzIGludGVycnVwdCBjb3VudHMgaW4gcHZy
X2Z3X2lycV9jbGVhcigpIHJhdGhlcg0KPiAgIHRoYW4gaW4gdGhlIElSUSB0aHJlYWQsIHNvIHRo
YXQgdGhlIGNsZWFycyBhdCBwcm9iZSBhbmQgaW4NCj4gICBwdnJfcG93ZXJfcmVzZXQoKSB1cGRh
dGUgdGhlIGhvc3QncyBjb3B5IHRvbyAoU2FzaGlrbykuIFRoaXMgcmVwbGFjZXMNCj4gICB0aGUg
emVyb2luZyBpbiBmd19vc2RhdGFfaW5pdCgpOiBhZnRlciBhIGhhcmQgcmVzZXQsIHRoZSByZXNl
dCBwYXRoJ3MNCj4gICBjbGVhciBzYW1wbGVzIHRoZSB6ZXJvZWQgY291bnRzLg0KPiAtIEZpeGVz
OiBjYzFhZWVkYjk4YWQsIHdoaWNoIHB1dCBwdnJfZndfc3RvcCgpIGludG8gdGhlIHJ1bnRpbWUg
c3VzcGVuZA0KPiAgIHBhdGg7IGF0IDcyNzUzOGE0YmJmZiBpdCBvbmx5IGdhdGVkIHRoZSBjbG9j
a3MgKFNhc2hpa28pLg0KPiAtIFJlYmFzZWQgb24gZHJtLW1pc2MtbmV4dC4NCj4gLSBMaW5rIHRv
IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYxMTEwLXJicnVlLXN1ZXotdXBzdHJl
YW1pbmctcHZyLWZ3LWlycS1oYW5kc2hha2UtdjEtMS04ODcyNjg2ZDE0ZDBAZ21haWwuY29tDQo+
IC0tLQ0KPiBXaXRoIGNvbnRpbnVvdXMgcmVuZGVyaW5nIGFuZCBhIDEgbXMgYXV0b3N1c3BlbmQg
ZGVsYXksIGEgc3VzcGVuZCBmYWlsZWQNCj4gdGhpcyB3YXkgd2l0aGluIDIyIHNlY29uZHMgaW4g
NyBvZiA3IHVucGF0Y2hlZCBydW5zLiBUaHJlZSBvZiB0aGVtIHdlcmUNCj4gaW5zdHJ1bWVudGVk
OiBiZXR3ZWVuIHRoZW0gdGhleSBtYWRlIDI3MTEgc3VzcGVuZHMsIGFuZCB0aGUgdGhyZWUgdGhh
dA0KPiBmYWlsZWQgd2VyZSB0aGUgb25seSBvbmVzIHdpdGggYW4gaW50ZXJydXB0IHN0aWxsIG91
dHN0YW5kaW5nIGFmdGVyDQo+IGRpc2FibGVfaXJxKCkuIFdpdGggdGhpcyBwYXRjaCwgOCBvZiA4
IHJ1bnMgbGFzdGVkIDYwIHNlY29uZHMgd2l0aG91dCBhDQo+IGZhaWx1cmUsIGFuZCBpbiBhIGZ1
cnRoZXIgcnVuIHRoZSB3YWl0IHdhcyBuZWVkZWQgaW4gMTUgb2YgNjkyNQ0KPiBzdXNwZW5kcywg
Zm9yIGF0IG1vc3QgNi4xIG1zLg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfZGV2aWNlLmggfCAxNSArKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9p
bWFnaW5hdGlvbi9wdnJfcG93ZXIuYyAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZGV2aWNlLmggYi9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX2RldmljZS5oDQo+IGluZGV4IGMyNDYxMjJiNGNhZi4uOWQ0NmM0
MTE0MGI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Rl
dmljZS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZGV2aWNlLmgN
Cj4gQEAgLTE3Niw2ICsxNzYsMTIgQEAgc3RydWN0IHB2cl9kZXZpY2Ugew0KPiAgCS8qKiBAaXJx
OiBJUlEgbnVtYmVyLiAqLw0KPiAgCWludCBpcnE7DQo+ICANCj4gKwkvKioNCj4gKwkgKiBAZndf
aXJxX2NvdW50OiBGaXJtd2FyZSBpbnRlcnJ1cHQgY291bnRzLCBhcyBsYXN0IHNhbXBsZWQgYWZ0
ZXINCj4gKwkgKiAgICAgICAgICAgICAgICBjbGVhcmluZyB0aGUgaW50ZXJydXB0Lg0KPiArCSAq
Lw0KPiArCXUzMiBmd19pcnFfY291bnRbTUFYX1RIUkVBRF9OVU1dOw0KPiArDQo+ICAJLyoqIEBm
d2NjYjogRmlybXdhcmUgQ0NCLiAqLw0KPiAgCXN0cnVjdCBwdnJfY2NiIGZ3Y2NiOw0KPiAgDQo+
IEBAIC04MTMsNiArODE5LDE1IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZA0KPiAgcHZy
X2Z3X2lycV9jbGVhcihzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gIHsNCj4gIAlwdnJf
ZGV2LT5md19kZXYuZGVmcy0+aXJxX2NsZWFyKHB2cl9kZXYpOw0KPiArDQo+ICsJLyogQSBjbGVh
cmVkIGludGVycnVwdCBjb3VudHMgYXMgdGFrZW4sIHdob2V2ZXIgY2xlYXJlZCBpdC4gKi8NCj4g
KwlpZiAoUkVBRF9PTkNFKHB2cl9kZXYtPmZ3X2Rldi5pbml0aWFsaXNlZCkpIHsNCj4gKwkJc3Ry
dWN0IHJvZ3VlX2Z3aWZfb3NkYXRhICpvc2RhdGEgPSBwdnJfZGV2LT5md19kZXYuZndpZl9vc2Rh
dGE7DQo+ICsNCj4gKwkJZm9yICh1MzIgaSA9IDA7IGkgPCBNQVhfVEhSRUFEX05VTTsgaSsrKQ0K
PiArCQkJV1JJVEVfT05DRShwdnJfZGV2LT5md19pcnFfY291bnRbaV0sDQo+ICsJCQkJICAgUkVB
RF9PTkNFKG9zZGF0YS0+aW50ZXJydXB0X2NvdW50W2ldKSk7DQo+ICsJfQ0KPiAgfQ0KPiAgDQo+
ICAjZW5kaWYgLyogUFZSX0RFVklDRV9IICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX3Bvd2VyLmMNCj4gaW5kZXggZWI0YjZlY2RmNGY0Li4yZDBmYmNmNDU3ZjYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcG93ZXIuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMNCj4gQEAgLTg5LDYgKzg5LDI2
IEBAIHB2cl9wb3dlcl9yZXF1ZXN0X3B3cl9vZmYoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYp
DQo+ICAJcmV0dXJuIHB2cl9wb3dlcl9zZW5kX2NvbW1hbmQocHZyX2RldiwgJnBvd19jbWQpOw0K
PiAgfQ0KPiAgDQo+ICtzdGF0aWMgYm9vbA0KPiArcHZyX3Bvd2VyX2Z3X2lycXNfdGFrZW4oc3Ry
dWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYsIHUzMiB0aHJlYWQpDQo+ICt7DQo+ICsJcmV0dXJuIFJF
QURfT05DRShwdnJfZGV2LT5md19kZXYuZndpZl9vc2RhdGEtPmludGVycnVwdF9jb3VudFt0aHJl
YWRdKSA9PQ0KPiArCSAgICAgICBSRUFEX09OQ0UocHZyX2Rldi0+ZndfaXJxX2NvdW50W3RocmVh
ZF0pOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZA0KPiArcHZyX3Bvd2VyX3dhaXRfZm9yX2Z3
X2lycXMoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYpDQo+ICt7DQo+ICsJYm9vbCB0YWtlbjsN
Cj4gKw0KPiArCWZvciAodTMyIGkgPSAwOyBpIDwgTUFYX1RIUkVBRF9OVU07IGkrKykgew0KPiAr
CQlpZiAocmVhZF9wb2xsX3RpbWVvdXQocHZyX3Bvd2VyX2Z3X2lycXNfdGFrZW4sIHRha2VuLCB0
YWtlbiwgMTAwLA0KPiArCQkJCSAgICAgIFBPV0VSX1NZTkNfVElNRU9VVF9VUywgZmFsc2UsIHB2
cl9kZXYsIGkpKQ0KPiArCQkJZHJtX3dhcm4oZnJvbV9wdnJfZGV2aWNlKHB2cl9kZXYpLA0KPiAr
CQkJCSAiRlcgdGhyZWFkICV1IGhhcyBJUlFzIHRoZSBob3N0IGhhcyBub3QgdGFrZW5cbiIsIGkp
Ow0KPiArCX0NCj4gK30NCj4gKw0KPiAgc3RhdGljIGludA0KPiAgcHZyX3Bvd2VyX2Z3X2Rpc2Fi
bGUoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYsIGJvb2wgaGFyZF9yZXNldCwgYm9vbCBycG1f
c3VzcGVuZCkNCj4gIHsNCj4gQEAgLTEwNyw2ICsxMjcsMTMgQEAgcHZyX3Bvd2VyX2Z3X2Rpc2Fi
bGUoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYsIGJvb2wgaGFyZF9yZXNldCwgYm9vbCBycG1f
c3VzcGUNCj4gIAl9DQo+ICANCj4gIAlpZiAocnBtX3N1c3BlbmQpIHsNCj4gKwkJLyoNCj4gKwkJ
ICogTGV0IHRoZSBJUlEgdGhyZWFkIHRha2UgZXZlcnkgaW50ZXJydXB0IHRoZSBmaXJtd2FyZSBo
YXMgcmFpc2VkDQo+ICsJCSAqIGJlZm9yZSBzdG9wcGluZyBpdCwgYXMgdGhlIHZlbmRvciBkcml2
ZXIgZG9lcy4gV2l0aG91dCB0aGlzLCB0aGUNCj4gKwkJICogTUVUQSBmaXJtd2FyZSBwcm9jZXNz
b3IgY2FuIGZhaWwgdG8gZ28gaWRsZSBpbiBwdnJfZndfc3RvcCgpLg0KPiArCQkgKi8NCj4gKwkJ
cHZyX3Bvd2VyX3dhaXRfZm9yX2Z3X2lycXMocHZyX2Rldik7DQoNCllvdSBjYW4gZHJvcCByZWZl
cmVuY2UgdG8gJ01FVEEnIGZyb20gdGhlIGNvbW1lbnQgYW5kIG1ha2UgaXQgYXBwbGljYWJsZSBm
b3IgYWxsDQpmaXJtd2FyZSBwcm9jZXNzb3JzLg0KDQpXaXRoIHRoYXQgdXBkYXRlLCB5b3UgY2Fu
IGFkZCBteSBSQiB0YWcNClJldmlld2VkLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRh
QGltZ3RlYy5jb20+DQoNClRoYW5rcywNCkJyYWplc2gNCj4gKw0KPiAgCQkvKiBUaGlzIGFsc28g
d2FpdHMgZm9yIGxhdGUgcHJvY2Vzc2luZyBvZiBHUFUgb3IgZmlybXdhcmUgSVJRcyBpbiBvdGhl
ciBjb3JlcyAqLw0KPiAgCQlkaXNhYmxlX2lycShwdnJfZGV2LT5pcnEpOw0KPiAgCX0NCj4gDQo+
IC0tLQ0KPiBiYXNlLWNvbW1pdDogNDFiNTQ1ODU5NWM2MDE0M2QwZWJhYTFlMDMyYzljZGE1ZDc2
NGRmZg0KPiBjaGFuZ2UtaWQ6IDIwMjYxMDA0LXJicnVlLXN1ZXotdXBzdHJlYW1pbmctcHZyLWZ3
LWlycS1oYW5kc2hha2UtYjgwOTUzZWI5MDRiDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCg==
