Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713A2BE033;
	Sat, 30 May 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151869; cv=fail; b=R7jR+1VvvE/Ei/tCRFIT1X4iAhXnBroAyWdSSYOCLsGTDAJa1FBtKB1b8fsgFuouTxKoSPI0td2pdcCCo4lvVCacgn7F2ICdjziMTYr7GGfJ8bSUJmVOc6N/hIrNTbBMkjJlp+02lA9tri84OAubDKBCtjRzd0/7OXbVwxvYSkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151869; c=relaxed/simple;
	bh=o4mtcVJbGlVFx7X387rjI73rs65cpq+dQUOyRkXUEC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HeltPzcWucmgsYyM6sjVLlSRylKBMlUD+Ykkgvkoipxyeelm/Kb3+cslpMrpocvF/tSSbXJBN6fb0ihVacG0luPEvns0jxcdWy8CbbjZSAFLSBlh70JwcLJF7GdC6aIZBUp4HJPUlWnh9Qgd9b7yc6VvvmqAhG9hZtiwHYULaRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=UE1CceuS; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="UE1CceuS"
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64U77cQQ4157816;
	Sat, 30 May 2026 10:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=o
	4mtcVJbGlVFx7X387rjI73rs65cpq+dQUOyRkXUEC0=; b=UE1CceuSMInyF/kal
	JPLAgcsfbIk0aTL7dvpdY65ZWVNrkfpPCWO2UVrbQErtPiDOo+3wvukPGKShM7Ph
	9XkcIjgeBLyFui1wvc3t+984MJ7ijfL13s+TJbfxqUuDXZRiSvrrH8nBHlBgdSUX
	EFaCUOs5QKzMTA5z4QhZfsl8rRu0iSO6ncPM7ffE5m32mdrWLsZPrT87vndSBFcX
	o+ENLV6WUSAvb5kjrHnzGEvVdOZGL5q0ADdZk/kURZsgGCxD7JfqgElxCjEwBz/H
	9JMLVvOSoBi2xO/oDj8CwwRZBE0ExX31b02qUCDzztShcQ2K79YrrS3BHI48d8lc
	jT3YA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4efu7d0qt0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 30 May 2026 10:37:22 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UDds6q2884698;
	Sat, 30 May 2026 10:37:21 -0400
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4eft4ubwqv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 30 May 2026 10:37:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1Aag1bNSEc/IUcbk8E2YLxInZsVaht/KhudOY8SezmNFXkjouPOiZKExRs3IPgNTPlLvaMrQAQGeDzvvH2JTqyBe/A56V4LS7Fruod9NzfZJrXN/4xSOvr6boBqPsFD7XuaYqYAHhFTsnYNeUbu6PA7wNK/L3+Vsb3vTEqZyssdtsFZ7dz4UHlP9R7k7/KphMmxKbk5uTO8jILdDMhMO0d49xwoRCRgSdr3Vzbp3198IUdgqGo/bw2NmR4KndBXr2GX8RM687hB1nGy/EwlY5sbjBCQD6rQFtYZs++N6jlt7rYbSy8ENQlhvD4RC4WjHCUggU6YY6u8ZTj4TRoDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4mtcVJbGlVFx7X387rjI73rs65cpq+dQUOyRkXUEC0=;
 b=Cy7+kb4CYBjETP40YkFyR7m+Yxvx4Wj6eo72wvZ1vJi047A3tZb6h6gBBCMVV+wv/8PfHWSRmw+97XrvN8yDLfhGi/VbG6DefKUx63XQdA2PB3qJnLh5yyUN/aCMmtFFOUo0fpEhzxJKd9P12CIIN0Bk/4J/TID+KXCNNXIjehajn9EQwMRLxKghn5pCO12GrkKNnQh8g65dMRHnxOE4fFPnjQh2CZpqxAfl2cbkp0B6uOXd+n59w05B/c0TZNSV7HuutkxvkoR96jx3jdmuFaTZ7fGGnkVCnQtQ9sA0gbIc/5FmNFgyPQv8fAYkstXvWHImQMwTdTAYGTeS7NtbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS0PR19MB7696.namprd19.prod.outlook.com (2603:10b6:8:f8::5) by
 SN7PR19MB7545.namprd19.prod.outlook.com (2603:10b6:806:340::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Sat, 30 May
 2026 14:37:17 +0000
Received: from DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9]) by DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9%4]) with mapi id 15.21.0071.015; Sat, 30 May 2026
 14:37:16 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: Keith Busch <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Topic: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Index: AQHc7rYSFc/wmEX1xUeXcN5PEFcVh7Yjv4sAgAB4luCAAWqUgIABA0jg
Date: Sat, 30 May 2026 14:37:16 +0000
Message-ID:
 <DS0PR19MB7696553BF77498769623D083FD172@DS0PR19MB7696.namprd19.prod.outlook.com>
References:
 <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
 <ahiHIEhsV2zuG5vH@kbusch-mbp>
 <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>
 <ahocb8YRtqh5rHo-@kbusch-mbp>
In-Reply-To: <ahocb8YRtqh5rHo-@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-30T14:36:31.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7696:EE_|SN7PR19MB7545:EE_
x-ms-office365-filtering-correlation-id: e6c3398f-0e90-4367-d334-08debe58f298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|786006|376014|1800799024|38070700021|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 1H3C6zv+kNI9xu+mXn7wW+2YFWPPgHJ5VqtIt4wratsIgAX4VoNL99qV+pilZl+TN8HTptmhlcuIKpyH174B1rrai5IWTctBZSxDjw8O50EPMItvRBQIvF5KBNiA5LfgDdAJbCJzuwtt9Ni8Q1onG/R0SNlO0iioxdwxQL6tMHexlXVvqacCUEw5sg/tvEwMoIwNFjLdtZ1S3q7b99PIZrZCYRLa6WvU63jNQQi7JaaLaaW27dNlRlT+cQebij/OTR4kHh5YHVjahxCEX57f2t67AY9Ib4fvSFWvvm2mPZ3vPUzc5PW2uTrW2PuhAMXVa5nJTIEBVGuqQmftmLc9q3n0SiNtoxUYElAfiZTmRmblJSNbObRM4wDJ5wqg++yH7pi2yAflRfjYGQhcBAIop8wQMyRYQ15i6fwI1fGU1bFZVFudrKCm2IvvqwlCcLFz+5dt0LUCusjYiszLHN8QHE+PMthhxnoqje3R8CbIy/oxbBONdSG3p+20yHGOaklBw4xSK49HBLbSP3MbhEcFxr+T2aaHeUq5C0bkpBwmyc8g9Wr7rrLKROLNUxGdKquCB5tA9f3lfBfiLn4GTfG+MYbH2GizmcKGW7ftuvgRVC9Eaa2XtGQBZIp5XO95m1UNJ1rHhEJbqfeseTOZIU+Gnd++uZp8qGmsmPBy0anliajHrHXhPDbFTl4ecod2ujUpOz0P0rFSSMTF71zysDMP3qHJkO5U7bfu57EqSo4D5ydtUUd3AHGkt+YvtNm8Sj+f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7696.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(376014)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/tlSPIOwA8GNA/wqgUbQRSi2cxH6K3NWCx8ic1Akzl6EctqXisM5paGO1xQ6?=
 =?us-ascii?Q?gT9GxQ24XkYzTwnCmqyqU+iaPQVpEfj+IGfLTP1l5MlcXb8nngcyoQHA4ClY?=
 =?us-ascii?Q?VMZjWbMgvFfQlWa0ZbuA+nivUzpXZmgQGbEjlz2Wfxi6ZFRDRTeyGuOCZBzP?=
 =?us-ascii?Q?4mDQRnITP/jXYZek3Sw0M6bR1VrcplDgYrPevuZ28pcW5/olyRF86Q0s5dui?=
 =?us-ascii?Q?/dqQnpA42+3OwmFFHmQ70LO2sH05HIcP8qhl8rtd6VSSibciC7xipQdhhZ7D?=
 =?us-ascii?Q?Qu8YmQJZhKGwTat9t+CPaPCMrRi3/xDqzQ7DTnhlETnvw6Cssbic3RZmZBlu?=
 =?us-ascii?Q?9cibsM0noec+j/L9nUWK/WgdpTKG0qS9l1/4C9avv0CDl8nOVX5n4MmK5/9C?=
 =?us-ascii?Q?i1HcWy8o6B87UwmqzUL1r1OR7VvzmNDylR/khiMNOe9HxmUsI2iR5F9VrJMQ?=
 =?us-ascii?Q?tLwWJB6wfyXXCu9VmRfv/L55180Ch6RrpI+JSN3IiGBcCMfAKCP95chzSJ4X?=
 =?us-ascii?Q?PrQvJ9af/STp343GMJslTqMGmXl1leEZK3God+CHMTXoohYw0hC4VAPd93e+?=
 =?us-ascii?Q?yaWn9MEu9AyFqF3Lvw+L/TIFmJUPtqhe07ROa+A0FqxRUwgisGT3mXDAPHuO?=
 =?us-ascii?Q?gsrW4ZgxSr0CHRdqoVshaB+Wgs7tCoi/zPQ2HYSs9orqacbdb+Z52BFr33q2?=
 =?us-ascii?Q?OUsoyYhhOaaBXd91MZ7fe2Nc5VwNjwpD53GORQ6+26pIr7ZY3Q88jtz7e3O9?=
 =?us-ascii?Q?2uh7Q/6MuDc8meZtA/t7W9995ODKniCCtLp+SvdAAxM9OfmoNPg970YBnOA3?=
 =?us-ascii?Q?qQsXLDbJJp1PjG9KjMi2QIEfsVKH98CEaeAU0bw7BBetRXr+bzAAM2Aw5XIo?=
 =?us-ascii?Q?V+otiV3vPWifoZhUAY3RzzfvrC4bUvwPDxZKTpA7OIgljrywZqD8c34ksLfM?=
 =?us-ascii?Q?Cxg4Dx0rXuRxaPwOGFnHD+ncROAg/5PZDo+ttFEtcV1+93x0joSDKSLp+s7H?=
 =?us-ascii?Q?wL5B9lzWcHLJqp4+w4qtLjeitxaE9o8r4KyRKvU8TIzTwNhpIG0SB6KCVU2o?=
 =?us-ascii?Q?gYFOiaKSSfiu88suFIAEldbf7r+INS77LKwjPrgivpdpForQ3ncwKJcnGYB+?=
 =?us-ascii?Q?Fur4CnKTIAvRPnUMM4Use23fp6MsPDNjvvRBnal8u5XYKJwhVBrm56uugV4C?=
 =?us-ascii?Q?MEIATyLzoF3oahMCkyRif+It0XJ372FA7j7aeXLfnUTY8llp7SvwJTNQO0kB?=
 =?us-ascii?Q?X3b6zhXvFq9/+TwfwU5PNUmZn+cY0WNkKm/IqotCeHBHca0FbMDKt1N7EYbG?=
 =?us-ascii?Q?vb4MwJvXd579o026+k385fvRqGTF35Gpqz6Hq0tgWu3t6V64Y8xAE+na6a8C?=
 =?us-ascii?Q?BFUAvhKHzyj+KP1MZ3rwPZt1BRQcZ0vNkuh4CX4u7FrctStkPadyJqvsGX98?=
 =?us-ascii?Q?ovb9rhq3iP9sgULQvwk4ZoTjWWtwZYckAPBndrua2/XjX0wNblGLin82QT3L?=
 =?us-ascii?Q?aP91xIruE/Lbsk9lsUsz4zezEVMOek57WYXlFxwRg09rmhgLKQeP9l80HJ4/?=
 =?us-ascii?Q?ShXL+tvI0jLirwQpzg7HOmDbL345DJHvd7N5XT6G19SKQowjihi7NbgA/Z9v?=
 =?us-ascii?Q?a7qMUyCIbgVhgU2VxCq230ef0OV6hBVpIYRNwC3a6L6ECrRRpkgnLkI94bMK?=
 =?us-ascii?Q?eCgz51QiyuyjF6MSr7QHDp1P61OFHxP1/dyu+VLTwqamTm2wGL276LrlBNdw?=
 =?us-ascii?Q?x4MOROn9Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mEyyvwXyRDJVmOpX9qA/cY83/IFmXIUNqFq0/vpRe6aCgHfWM3QzrP7aZPM1zmljYwgNgeCQ4gQ8HIwexmpfcZ+XCjBa3Vod0lx+LO7v1g10i6/1DTYoOBDD/hrCW1itlziRTfkOQT8TP+ps4dxkjcrPJIYaQXau9dTYibEK+RrNVmZfbJGMTAuX1+w+XDyGLNwapDXhSkEuMXC+ZQ/1S7YL9VZFlZ67Vn7T5fgq1LRhwnT2OWN09IoqzmrLIpQDpSf3YkrVyDMdUz4Hl93gs2sKqk5g8eQKWw8kAdSL/v+J+8IFzFk/cNRFySjLqd2LIPFSsk7tUvf/4JyBB1GDcw==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7696.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c3398f-0e90-4367-d334-08debe58f298
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2026 14:37:16.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHYS463e1yzTTM47PnTJCv+9ydwPjepAQsx5koxYtFWCWvg6lKNmlJpBBY/+ylwxCpCNcBpo5huECpBTC1Zmmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300158
X-Authority-Analysis: v=2.4 cv=KfridwYD c=1 sm=1 tr=0 ts=6a1af622 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=2Lpba0WeoN7BYVdwMO11:22 a=j4ti81vYX-xKtT28lx4A:9 a=CjuIK1q_8ugA:10
 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: 1WMkl3rFcfOJAAchQwH_gj-v7D2kvira
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE1OCBTYWx0ZWRfX/tJKCeFfhRoc
 3PPXmqIjGLSCfPsJydb2CWy1MwcJxEXIGgBJW7JiC2xXouGG1NSHwm15WfgskIGuMtGo64XG2Y2
 IbgeUzZCvtQ8Qsh+o2k53UN8bUIS8ZmdCAOb5f6EMyUL4zr6yWS3SnTS9ZKTBAsipD9Jejjrt3a
 siBHg+HygF8dVY28uQEWKAIdcLNbzmnZDcoAlrlEsl0IXE5ZMvBXGFaI/Cs9isGke2OXBdEmAA7
 /1U3wetldzRoYrjJ/9/5Q44lb7gbfembDQucyIOeytL6mTzSw2IvHuasM3CpFoQqPU5gnFOcHit
 RTjIG72zkXD/b47aEtgqrF6C1P8HNevjbLhLCd/fVFEAAprpUCCKcvFPAdRMAPFhDMynq5s+rM9
 1ij4sJV6tQtkQ24q1yXsMI/sDtUZPUnI+WGKf3ArWq4K7yIfV6hDNrTEADycWWFAHOOptkGoVXm
 M7SJ30ei8SXKJz3gwNw==
X-Proofpoint-GUID: 1WMkl3rFcfOJAAchQwH_gj-v7D2kvira
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300158

Keith Busch wrote:
> Sure, though I was considering just adding it the nvme tree. I'm giving
> a few days to see if there are any other comments.

Sounds good, thanks Keith.

Internal Use - Confidential
