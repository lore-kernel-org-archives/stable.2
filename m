Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38602D97AA;
	Fri, 24 Jul 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900253; cv=fail; b=RrGHIHR1EPhAaVyfP/t6QBq3xwUwfLETrwjDf8mAHYvJ9yJ99bKRCgL3PS0AixUoXrozSuRacRuY4UGtLH3l59/J7oH2ym4YGasgouJsqDmiJKA6Zu4uSJng4kG1WeUaYs6I4R6zNq7KdP2fx5ktO3HcFSXQCrJjxuUeOAlcXoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900253; c=relaxed/simple;
	bh=jGkcOaA7r8CGCqth3UwUH/ZQE45GofQ+4mu+AWkLnJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dowvslthPst80aXg2issQI+mk7BKbL7m5zgssvDPOYNrVOatEizRx6U+0/g10eDDqvj2Qyiyl1NKXsGJX82/sVtMcmzpbqWIgrvc5H9s9H8HM7j4RxY9zmkKZQcJsn2JeWvKQXGD3eQmAp1J/spK1IMAk+eAv3BCB+vSYD9QPPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NktaB0PS; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NktaB0PS"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCnvH64064068;
	Fri, 24 Jul 2026 06:37:14 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021091.outbound.protection.outlook.com [40.107.208.91])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fktsx9xt1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBkd9ACF3+Nray9k6E1whaxRsUey5H06Rv/dCRX+70+ojySioSTKrd1XSUEXRNPP3jzqIO4mmsO5MYFs6EBK7puRMMRuKZ4D8PCaGwrtqG13Aqr3KHczfC7bHbI+01CYAM4YDmqnfeli8+c1N+uYWMOZUJ5FNWAkXvIsFcl0ZFEa3CbjUQrclcEAQ0fGIgxA3GaMAHj/WXXcfes3aCmn7WqBATR0DNAdUPQ47LKJNNuYbT5gHcN+5lJX9LyIlV68nsQ/zilxge9c7WZ6E9dDqp+kqK0ujYopT9a4trAPO0aaH2miqovU1vqRtxGCahCDI1z3UkHLk5FmfdMOiu3Iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wVMFiJfovR6h79958qh4tFTh8eV3d7bxTWhSQRxgE0=;
 b=IpttGaTLPZn+JGgb4c6JJqGcaMsxLYJXujkaFeR5oAMI5sevzsfKAc0oGu+Q7qPHnhEuHLy+CjIxirR0tjYL9sClhAK7p+cNevDgAaFQke7sh5DJYNrI1Xt98g0W+KK9IGhWSPNZv4sFKKVqfgHs647BXLnenoWQQ1E6IsF1+KdoqhAI9Z8zCFRP/YB6nW2FiqYcW1uRCvoPpd1FSBSuBX0oBUnhGiqCKNInVPFdUPDO0TP3Wp5XyuFoKnsun/KAzKYJiH3x+vR700AkoRRDKkDCeP0gKuwJTVK+ON5ZwVIJm7bSC+NoRny08rcuzVbLwtufQZqznBL1syQzWhCUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wVMFiJfovR6h79958qh4tFTh8eV3d7bxTWhSQRxgE0=;
 b=NktaB0PSmedFZA82cGmJQooAeYudhJbsqUEwAfHdqIYRNloR8M9SeD5cbRbN996gKqQIwICbY7xnlhQIRevIK/zrhY2YhiiyM/JZFlxS4fGgmrSqwVGQP4dtdA99zmw/6XUg/+VkubTC9NOuhSodQnE8kdq36SvBajfSPN0vf/8=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by DM3PPF4976F8545.namprd18.prod.outlook.com (2603:10b6:f:fc00::6a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 13:37:10 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%5]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 13:37:10 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Yangyu Chen <cyy@cyyself.name>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: Mina Almasry <almasrymina@google.com>,
        Jesper Dangaard Brouer
	<hawk@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Lino
 Sanfilippo <LinoSanfilippo@gmx.de>,
        Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next v2 3/3] net: atlantic: convert RX path
 to page_pool
Thread-Topic: [EXTERNAL] [PATCH net-next v2 3/3] net: atlantic: convert RX
 path to page_pool
Thread-Index: AQHdG0ssB5yq7czHiUumk71ajarrGLZ8onfA
Date: Fri, 24 Jul 2026 13:37:10 +0000
Message-ID:
 <SA1PR18MB4600D19A6A443DE87FF2294BBACF2@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_771AEE718C41884FA30CDF85E092F693E306@qq.com>
In-Reply-To: <tencent_771AEE718C41884FA30CDF85E092F693E306@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|DM3PPF4976F8545:EE_
x-ms-office365-filtering-correlation-id: 574aefe8-5c6e-42c5-0ad7-08dee988a9a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 FWLgnF6CeuCjHS7rdL23vuQgpp1De8V1Il9TxGlpJH3+6sgKYecd1reAX3ROUWYHhRCoLQRjYWX1WylvYMY+1AEzZZuccIitE/WeW78rsOugCw3XqcIr9KIuTEzSAG0NWwgd0Ys0x0kmeTbYNdg6oEFlKYLqXThVy8UHrdDf3mRotI4SNcqv3t9Vpo+8IOiHHm/9NO0TANVwR97rgGY7C3y1IxLL2iG/tg+4J4hx2KeA/6VCUtKx/zBEXQvdCuzW9VROwJ7Sj4vuXJBYTzFuWUqUtIXjJNowJWM5Ts5pt3E5hQPDtlFHAn/xfjA4c4Q8bB4YZozgjoB8so1mOhXQrmxTHislhqFulQXEJPJlHXqhXXWWZlPevW5sXIGLNU2gwU9QeOMcvQk9otT/Q904YkuTgRpG/OTyKlSbeo/4IHxoP1sVzectx0KNVfppdv+BlVPhKyKwqWn2/73Gs9+j8BDd8g20UwuMerYHev6BaqXhyC2dujeht1TFkgUFPPlUdSXjprmLyLVqVWWODxknQc4y8x21197vDPJyTpYCFuxXA878G5bIsckEumMbqrEjlQwgS24csZAwr9ogJOWAc5n/zHfG6PyG85Ne+yQ919vQ4R4rF3ZrAcsRinno3EHF0S5jkqUdZk7wpmLA2Mmc0pxhb7u7MtpfcvKdytUr4aMkkc3llmyCworVRSz9O+bTKgf+8X4eqRyOxVRsi87S+pd9mBqoYGf5j6h9u+96jYQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?luEM7cIrmuMMJuCvGckQdfLWH8fIKNfOoBBpOLvh9uDaDKXi0qgv0920BhpD?=
 =?us-ascii?Q?DBVcyJF/2kwLODqStZbNJnTQ0F0DDjGkIDi5klVmOS2ssL6snn0jZXV3ubqq?=
 =?us-ascii?Q?SjTlOxnbYC/eyEtQrh2B0eBVjc5nk4tISjSNriw0ic/pJKxxFYjzcME+t2Nd?=
 =?us-ascii?Q?I5DSULGHfI/iizCfB6ezLxysHlVbdLHBP3Ykq66Km9k5VojKUOn+kXhfZNW2?=
 =?us-ascii?Q?irOcvpync+3/j2W+P3wbjopW66n++yWk29XT+6PX+vq1COhhPxAaX5Ss5shc?=
 =?us-ascii?Q?zwUsxbZnNcOwkLaYstuIy0modd8MzbVzHJtikhAPJwfdhnX2LLlND+A/gLzT?=
 =?us-ascii?Q?Lb+Rwwp1fmYZjUFYlmZjti8uLHlA8nTJBX1cFEhrxYLDHYvAJdZLo/vkvxwQ?=
 =?us-ascii?Q?L8AKmtJgXqEN6BH1ZZ+btb5ZfA44XOkmehfKTg8HxIicxkiB83BiLPOa0O8R?=
 =?us-ascii?Q?au9wPGC5Px91vKedG3TsOSWkvqusy+VAmmYHqmZGvQOx17nBIz5srotNZNiw?=
 =?us-ascii?Q?qudnVvouuQR+4nUxw7Ft4FdI78WyAPLQLHc1OKbmApboHRgxnsIWQtGmWXWU?=
 =?us-ascii?Q?EAk2sWEG/biEdApPTosdd4glUJz9OtI6rJ28U8uQMBc1UZdyEyP4Ec9EgBgd?=
 =?us-ascii?Q?C70uscIthQKbF3k/kQvX+jlh/1aHZVxdi6UBajDxOyOzer1syHb9UPCCexHR?=
 =?us-ascii?Q?WyMQqj4q3BeqYUwaZ3EnPVPRg+X70HhWCr5iL/q84eTaifzg0FUtxwk7qM22?=
 =?us-ascii?Q?Pcq0Xy+8gD7iXDkJxzq0ncCfyi/S46utGo4mv3u00YkOYpzhzj+MVZqfy/QB?=
 =?us-ascii?Q?JxgX4HKcFDqrw8EG9fu/Xl5mRXO/iqOdgIB+mZ66kxBZ5962aVzqsNNPffJ3?=
 =?us-ascii?Q?sm915oiN5ByEHIsyjZ6iHjg4+7LHZN6t+rEBrDVq1oxc6s1SGm50iapglN4q?=
 =?us-ascii?Q?ejarS1bzAmaWfxJb/AipAoBrXaqn4SDuGAUundg5aekhjoM0oF1fZs/t9J+x?=
 =?us-ascii?Q?8bsZMJp+S/tsuK+2H+NoMSKI4398NZE5SaHzsIFUa/51tTh93VNjm+ODtaCH?=
 =?us-ascii?Q?PPGFz+M+J4VBGmPaT6jmsnQmE0WhTEEXArBMzPttlIgM02dFNZyuSVBVx8A0?=
 =?us-ascii?Q?2FKFU2grshlTIHQ+dfEO8vXvAniJFBbK1+ZDzQ7Og65kIZLmenGm8GpSzqtU?=
 =?us-ascii?Q?Il/lX645AmUDro2ugE6V1ywzFFk0XxfJwiBIb/5FwscCcZ+CYvabn3U7Ib05?=
 =?us-ascii?Q?YOgt7ffBzAyHEZocl9GKk9W090nIh9WOhXaKcV9vpKg04erZgx9yQKeCIA1+?=
 =?us-ascii?Q?HRIq08Xj1Y/+t7s7Mu9qKU8GO1Wu22aM0QhYEoSNNTO1IyCqwOF6J8yzlKPe?=
 =?us-ascii?Q?AXImZrLTPg3NJDWTrptqwiiN9cRK0GqhU/C8Y4LnbtzvT6fD0Cc//M7jnlyk?=
 =?us-ascii?Q?/msVJpSPnENaoaCnSI873LJCm81l88ZEBd7jn76GdVz089eUFR9narA1ljmz?=
 =?us-ascii?Q?ubQJFuoQ9Js2FtmDBylmjtbHznDo62ic5OPHUABY9i2SG842ywvbYiAbJklb?=
 =?us-ascii?Q?QI+DTT96ki/foEhyLAYkDUNm+HmYv1cUoDFOipFpAh+zPj62Z1JLPHI+MCqC?=
 =?us-ascii?Q?yHMH3M4pqF9wZRiCVcNbmb5BGcmmBYEx6t9VVZOcJ+deytCDr3VqPAFwlrBh?=
 =?us-ascii?Q?UZOx/tTxewfmx0pbi3XCins7oXmEl8L5Nc2um5NutQIDvFBZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PQIy05+01znk/r65FfNzNf6AGTjw5sA7pmq9wGiw6BMQMnJ8mIO0R7CGLAtZ4nSeUIVSU4P23Vr9qdjcAxPhGyEyh+c5ayz+ZB1kO6PVIG0SUbewMHPSnuow3ROFDTCfYOw1nJgRPUbsVvD2vwuaomVeZw2QlLQldQG5LVtOAZ1kIbUUAeixaNBzAZO6Zgnh00OcvSGTHVWsKDAjZI7HOMbDYSakGUU3Oftg0xYPfDrUxu/BuGqyjhYMNmA1g8nXhNiFEGeW9yTiJJoGRRTjtcIJS9bU47ZLckTdpifji9eA8xtnf4vn6BZnbasyNImz83MPC/mH+P9kPe39MaRqvw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574aefe8-5c6e-42c5-0ad7-08dee988a9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 13:37:10.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1x2vahifUT0PRKX/ryeFmrSGs7O7VcnX3jEpxwpeX5BkXIRekwP2nVkmoGC3nc+Qutv5SUdDQlBkBFPstQFsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4976F8545
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyMyBTYWx0ZWRfX+YDKfYqPKF6O
 Yb0HWL1zhmJku/6OkZmf82+lW3WcwQSk6mfqj2ehS+6N/R7hcrIvfP9kRooMmKG9wrmeyzMUF3q
 ZvQ7UEav+kiVzS2YLJfcS8ijaWQD9lE=
X-Proofpoint-ORIG-GUID: 8t1OFMG_wQ27pl-dF19CAEcIVLnxGAKB
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a636a8a cx=c_pps
 a=uZr4HK/cABhWQOY6fA9CQA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=BFmiilHUvl0pmnkzmPcA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyMyBTYWx0ZWRfX+floVgxn8GSM
 Yq05cyLiJSWKE0nvhkWIKuWi0ZioxF3q83yINhiQYSJjcg2viQssPJQs4K7QbjYP196lOh0axVL
 831OlblSGwBz3iJDFjoMgWxf781RCGu7CeJoD/0szLvEtgytkbAbLBS16shRIyKByLyZVIpY7E4
 4H8IYrDv/mV4KwzsROxv8LJ4XXI5++N3ZzhDj9kD/4q5pi5CxqSavkLU+i/+g6UysiTXaIN0wFJ
 6tUGKxzdQHNy8FMh6d6trV7ZK5RxZxheECZKW2Furhdvx+Wc4eRgN/16VVQttnGHhusqcj55e3C
 Uxzia8tEnp76Q6EgbU3pQC3VCxA3/HTxX+tah/SgcR3LQ/VBSBuW2R3KHI4YTfFbS+sqlrCj6JY
 Bn3Ul5LXfXK2GtQdlg0RC6IXmZcmqf+sSrYCXr6n8nfTeguUN/Nw2tFb+ldCYWFB59MHzBsaO/B
 J5fOAR2DEtzL9FG4jaw==
X-Proofpoint-GUID: 8t1OFMG_wQ27pl-dF19CAEcIVLnxGAKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_01,2025-10-01_01


On 24 july 2026, Yangyu Chen wrote:

> The driver currently allocates RX buffers with dev_alloc_pages(), maps
> them with dma_map_page(), and uses a hand-rolled page-flip scheme to
> subdivide high-order pages. Behind an IOMMU, the map/unmap churn is a
> major RX cost: on a Thunderbolt-attached QNAP QNA-T310G1S, iperf3 -R
> over IPv6 tops out at about 2.2 Gbit/s over MTU 1500.
>
> Convert RX buffers to page_pool fragments. Pages are DMA-mapped once
> when entering the pool and recycled through the stack or XDP via the
> MEM_TYPE_PAGE_POOL memory model. This removes the custom page-flip
> accounting, lets page_pool handle fragment reuse, and ensures every RX
> path either keeps the ring's fragment reference for reposting or hands
> it to the skb/xdp_buff for later recycling.
>
> Register the PTP RX ring's xdp_rxq as well, since it shares the RX
> clean paths. Drop the ethtool PageFlips/PageReuses/PageFrees counters
> which only described the old scheme.
>
> On the QNA-T310G1S, MTU 1500, TCP over IPv6, iperf3 -R improves from
> 2.24 Gbit/s to 9.14 Gbit/s. The module was also smoke-tested with native
> XDP PASS, DROP, and ABORTED actions; carrier recovered after each
> attach/detach cycle and dmesg showed no page_pool/DMA warnings.
>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <mailto:cyy@cyyself.name>
> ---
>
> Notes:
>    v1 -> v2:
>     - split the RX deinit gap fix into the previous patch and generate
>       this diff with --histogram so it reads as whole-function removals
>       plus an in-place aq_get_rxpages() rewrite (Mina)
>     - comment the ring-before-rxq-registration ordering and its error
>       unwind in aq_vec_ring_alloc()
>     - use the err_exit_xdp_rxq label instead of open-coding the
>       unregister in aq_ptp_ring_alloc()'s memory model error path (Mina)
>
> drivers/net/ethernet/aquantia/Kconfig         |   1 +
> .../ethernet/aquantia/atlantic/aq_ethtool.c   |   3 -
> .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  18 +-
> .../net/ethernet/aquantia/atlantic/aq_ring.c  | 210 +++++++-----------
> .../net/ethernet/aquantia/atlantic/aq_ring.h  |   6 +-
> .../net/ethernet/aquantia/atlantic/aq_vec.c   |  21 +-
> 6 files changed, 120 insertions(+), 139 deletions(-)
>
> diff --git a/drivers/net/ethernet/aquantia/Kconfig b/drivers/net/ethernet=
/aquantia/Kconfig
> index cec2018c84a9..c8fb7b33e5b7 100644
> --- a/drivers/net/ethernet/aquantia/Kconfig
> +++ b/drivers/net/ethernet/aquantia/Kconfig
> @@ -20,6 +20,7 @@ config AQTION
> 	tristate "aQuantia AQtion(tm) Support"
> 	depends on PCI
> 	depends on MACSEC || MACSEC=3Dn
> +	select PAGE_POOL
>  	help
>	  This enables the support for the aQuantia AQtion(tm) Ethernet card.
>=20
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/driver=
s/net/ethernet/aquantia/atlantic/aq_ethtool.c
> index 420af958d486..0f5125bd2315 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> @@ -100,9 +100,6 @@ static const char * const aq_ethtool_queue_rx_stat_na=
mes[] =3D {
> 	"%sQueue[%d] AllocFails",
> 	"%sQueue[%d] SkbAllocFails",
> 	"%sQueue[%d] Polls",
> -	"%sQueue[%d] PageFlips",
> -	"%sQueue[%d] PageReuses",
> -	"%sQueue[%d] PageFrees",
> 	"%sQueue[%d] XdpAbort",
> 	"%sQueue[%d] XdpDrop",
> 	"%sQueue[%d] XdpPass",
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_ptp.c
> index 558ac9237f75..3a40d986cd67 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> @@ -13,6 +13,7 @@
> #include <linux/ptp_classify.h>
> #include <linux/interrupt.h>
> #include <linux/clocksource.h>
> +#include <net/xdp.h>
>=20
> #include "aq_nic.h"
> #include "aq_ptp.h"
> @@ -1192,12 +1193,23 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
> 	if (err)
> 		goto err_exit_ptp_tx;
>=20
> +	err =3D xdp_rxq_info_reg(&aq_ptp->ptp_rx.xdp_rxq, aq_nic->ndev,
> +			       rx_ring_idx, aq_ptp->napi.napi_id);
> +	if (err < 0)
> +		goto err_exit_ptp_rx;
> +
> +	err =3D xdp_rxq_info_reg_mem_model(&aq_ptp->ptp_rx.xdp_rxq,
> +					 MEM_TYPE_PAGE_POOL,
> +					 aq_ptp->ptp_rx.pg_pool);
> +	if (err < 0)
> +		goto err_exit_xdp_rxq;
> +
> 	if (aq_ptp->a1_ptp) {
> 		err =3D aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_I=
DX,
> 					    aq_nic->aq_nic_cfg.rxds,
> 					    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
> 		if (err)
> -			goto err_exit_ptp_rx;
> +			goto err_exit_xdp_rxq;
> 	}
>=20
> 	err =3D aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds)=
;
> @@ -1217,6 +1229,8 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
> err_exit_hwts_rx:
> 	if (aq_ptp->a1_ptp)
> 		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
> +err_exit_xdp_rxq:
> +	xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
> err_exit_ptp_rx:
> 	aq_ring_free(&aq_ptp->ptp_rx);
> err_exit_ptp_tx:
> @@ -1233,6 +1247,8 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
> 		return;
> =20
> 	aq_ring_free(&aq_ptp->ptp_tx);
> +	if (xdp_rxq_info_is_reg(&aq_ptp->ptp_rx.xdp_rxq))
> +		xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
> 	aq_ring_free(&aq_ptp->ptp_rx);
> 	if (aq_ptp->a1_ptp)
> 		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index e1193c6719d9..9dd881710594 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -14,120 +14,37 @@
> #include "aq_vec.h"
> #include "aq_main.h"
>=20
> +#include <net/page_pool/helpers.h>
> #include <net/xdp.h>
> #include <linux/filter.h>
> #include <linux/bpf_trace.h>
> #include <linux/netdevice.h>
> #include <linux/etherdevice.h>
>=20
> -static void aq_get_rxpages_xdp(struct aq_ring_buff_s *buff,
> -			       struct xdp_buff *xdp)
> -{
> -	struct skb_shared_info *sinfo;
> -	int i;
> -
> -	if (xdp_buff_has_frags(xdp)) {
> -		sinfo =3D xdp_get_shared_info_from_buff(xdp);
> -
> -		for (i =3D 0; i < sinfo->nr_frags; i++) {
> -			skb_frag_t *frag =3D &sinfo->frags[i];
> -
> -			page_ref_inc(skb_frag_page(frag));
> -		}
> -	}
> -	page_ref_inc(buff->rxdata.page);
> -}
> -
> -static inline void aq_free_rxpage(struct aq_rxpage *rxpage, struct devic=
e *dev)
> -{
> -	unsigned int len =3D PAGE_SIZE << rxpage->order;
> -
> -	dma_unmap_page(dev, rxpage->daddr, len, DMA_FROM_DEVICE);
> -
> -	/* Drop the ref for being in the ring. */
> -	__free_pages(rxpage->page, rxpage->order);
> -	rxpage->page =3D NULL;
> -}
> -
> -static int aq_alloc_rxpages(struct aq_rxpage *rxpage, struct aq_ring_s *=
rx_ring)
> -{
> -	struct device *dev =3D aq_nic_get_dev(rx_ring->aq_nic);
> -	unsigned int order =3D rx_ring->page_order;
> -	struct page *page;
> -	int ret =3D -ENOMEM;
> -	dma_addr_t daddr;
> -
> -	page =3D dev_alloc_pages(order);
> -	if (unlikely(!page))
> -		goto err_exit;
> -
> -	daddr =3D dma_map_page(dev, page, 0, PAGE_SIZE << order,
> -			     DMA_FROM_DEVICE);
> -
> -	if (unlikely(dma_mapping_error(dev, daddr)))
> -		goto free_page;
> -
> -	rxpage->page =3D page;
> -	rxpage->daddr =3D daddr;
> -	rxpage->order =3D order;
> -	rxpage->pg_off =3D rx_ring->page_offset;
> -
> -	return 0;
> -
> -free_page:
> -	__free_pages(page, order);
> -
> -err_exit:
> -	return ret;
> -}
> -
> static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s *=
rxbuf)
> {
> -	unsigned int order =3D self->page_order;
> -	u16 page_offset =3D self->page_offset;
> -	u16 frame_max =3D self->frame_max;
> -	u16 tail_size =3D self->tail_size;
> -	int ret;
> +	unsigned int size =3D self->page_offset + self->frame_max +
> +			    self->tail_size;
> +	unsigned int pg_off;
> +	struct page *page;
>=20
> -	if (rxbuf->rxdata.page) {
> -		/* One means ring is the only user and can reuse */
> -		if (page_ref_count(rxbuf->rxdata.page) > 1) {
> -			/* Try reuse buffer */
> -			rxbuf->rxdata.pg_off +=3D frame_max + page_offset +
> -						tail_size;
> -			if (rxbuf->rxdata.pg_off + frame_max + tail_size <=3D
> -			    (PAGE_SIZE << order)) {
> -				u64_stats_update_begin(&self->stats.rx.syncp);
> -				self->stats.rx.pg_flips++;
> -				u64_stats_update_end(&self->stats.rx.syncp);
> +	/* Buffers whose page was not passed up the stack are reposted
> +	 * with the data they already carry discarded.
> +	 */
> +	if (rxbuf->rxdata.page)
> +		return 0;
>=20
> -			} else {
> -				/* Buffer exhausted. We have other users and
> -				 * should release this page and realloc
> -				 */
> -				aq_free_rxpage(&rxbuf->rxdata,
> -					       aq_nic_get_dev(self->aq_nic));
> -				u64_stats_update_begin(&self->stats.rx.syncp);
> -				self->stats.rx.pg_losts++;
> -				u64_stats_update_end(&self->stats.rx.syncp);
> -			}
> -		} else {
> -			rxbuf->rxdata.pg_off =3D page_offset;
> -			u64_stats_update_begin(&self->stats.rx.syncp);
> -			self->stats.rx.pg_reuses++;
> -			u64_stats_update_end(&self->stats.rx.syncp);
> -		}
> +	page =3D page_pool_dev_alloc_frag(self->pg_pool, &pg_off, size);
> +	if (unlikely(!page)) {
> +		u64_stats_update_begin(&self->stats.rx.syncp);
> +		self->stats.rx.alloc_fails++;
> +		u64_stats_update_end(&self->stats.rx.syncp);
> +		return -ENOMEM;
> 	}
>=20
> -	if (!rxbuf->rxdata.page) {
> -		ret =3D aq_alloc_rxpages(&rxbuf->rxdata, self);
> -		if (ret) {
> -			u64_stats_update_begin(&self->stats.rx.syncp);
> -			self->stats.rx.alloc_fails++;
> -			u64_stats_update_end(&self->stats.rx.syncp);
> -		}
> -		return ret;
> -	}
> +	rxbuf->rxdata.page =3D page;
> +	rxbuf->rxdata.daddr =3D page_pool_get_dma_addr(page);
> +	rxbuf->rxdata.pg_off =3D pg_off + self->page_offset;
> =20
> 	return 0;
>  }
> @@ -179,6 +96,15 @@ int aq_ring_rx_alloc(struct aq_ring_s *self,
> 		     unsigned int idx,
> 		     struct aq_nic_cfg_s *aq_nic_cfg)
> {
> +	struct page_pool_params pp_params =3D {
> +		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.pool_size =3D aq_nic_cfg->rxds,
> +		.nid =3D NUMA_NO_NODE,
> +		.dev =3D aq_nic_get_dev(aq_nic),
> +		.dma_dir =3D DMA_FROM_DEVICE,
> +	};
> +	struct page_pool *pool;
> +
>  	self->aq_nic =3D aq_nic;
>  	self->idx =3D idx;
> 	self->size =3D aq_nic_cfg->rxds;
> @@ -200,6 +126,18 @@ int aq_ring_rx_alloc(struct aq_ring_s *self,
> 		self->tail_size =3D 0;
> 	}
>=20
> +	pp_params.order =3D self->page_order;
> +	pp_params.max_len =3D PAGE_SIZE << self->page_order;
> +
> +	pool =3D page_pool_create(&pp_params);
> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
> +
> +	self->pg_pool =3D pool;
> +
> +	/* On failure aq_ring_alloc() calls aq_ring_free(), which also
> +	 * destroys the page pool.
> +	 */
> 	return aq_ring_alloc(self, aq_nic);
> }
>=20
> @@ -346,7 +284,11 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
> 			++self->stats.tx.packets;
> 			self->stats.tx.bytes +=3D xdp_get_frame_len(buff->xdpf);
> 			u64_stats_update_end(&self->stats.tx.syncp);
> -			xdp_return_frame_rx_napi(buff->xdpf);
> +			/* Frames queued via ndo_xdp_xmit() may come from a
> +			 * page pool owned by another NAPI context: no direct
> +			 * recycling.
> +			 */
> +			xdp_return_frame(buff->xdpf);
> 		}
>=20
> out:
> @@ -437,22 +379,15 @@ int aq_xdp_xmit(struct net_device *dev, int num_fra=
mes,
> }
>=20
> static struct sk_buff *aq_xdp_build_skb(struct xdp_buff *xdp,
> -					struct net_device *dev,
> -					struct aq_ring_buff_s *buff)
> +					struct net_device *dev)
> {
> 	struct xdp_frame *xdpf;
> -	struct sk_buff *skb;
>=20
> 	xdpf =3D xdp_convert_buff_to_frame(xdp);
> 	if (unlikely(!xdpf))
> 		return NULL;
>=20
> -	skb =3D xdp_build_skb_from_frame(xdpf, dev);
> -	if (!skb)
> -		return NULL;
> -
> -	aq_get_rxpages_xdp(buff, xdp);
> -	return skb;
> +	return xdp_build_skb_from_frame(xdpf, dev);
> }
>=20
> static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
> @@ -473,8 +408,16 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic=
_s *aq_nic,
> 	u64_stats_update_end(&rx_ring->stats.rx.syncp);
>=20
> 	prog =3D READ_ONCE(rx_ring->xdp_prog);
> -	if (!prog)
> -		return aq_xdp_build_skb(xdp, aq_nic->ndev, buff);
> +	if (!prog) {
> +		skb =3D aq_xdp_build_skb(xdp, aq_nic->ndev);
> +		/* The ring has already handed its page pool reference to the
> +		 * xdp_buff, so if the skb could not be built the buffer must
> +		 * be returned to the pool here or its fragments would leak.
> +		 */
> +		if (!skb)
> +			xdp_return_buff(xdp);
> +		return skb;
> +	}
>=20
> 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
>=20
> @@ -485,7 +428,7 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_=
s *aq_nic,
> 	act =3D bpf_prog_run_xdp(prog, xdp);
> 	switch (act) {
> 	case XDP_PASS:
> -		skb =3D aq_xdp_build_skb(xdp, aq_nic->ndev, buff);
> +		skb =3D aq_xdp_build_skb(xdp, aq_nic->ndev);
> 		if (!skb)
> 			goto out_aborted;
> 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
> @@ -503,7 +446,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_=
s *aq_nic,
> 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
> 		++rx_ring->stats.rx.xdp_tx;
> 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
> -		aq_get_rxpages_xdp(buff, xdp);
> 		break;
> 	case XDP_REDIRECT:
> 		if (xdp_do_redirect(aq_nic->ndev, xdp, prog) < 0)
> @@ -512,7 +454,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_=
s *aq_nic,
> 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
> 		++rx_ring->stats.rx.xdp_redirect;
> 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
> -		aq_get_rxpages_xdp(buff, xdp);
> 		break;
> 	default:
> 		fallthrough;
> @@ -523,11 +464,13 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_ni=
c_s *aq_nic,
> 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
> 		trace_xdp_exception(aq_nic->ndev, prog, act);
> 		bpf_warn_invalid_xdp_action(aq_nic->ndev, prog, act);
> +		xdp_return_buff(xdp);
>  		break;
> 	case XDP_DROP:
> 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
> 		++rx_ring->stats.rx.xdp_drop;
> 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
> +		xdp_return_buff(xdp);
> 		break;
> 	}
>=20
> @@ -546,8 +489,11 @@ static bool aq_add_rx_fragment(struct device *dev,
> 	do {
> 		skb_frag_t *frag;
>=20
> -		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS))
> +		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS)) {
> +			/* Attached frags must reach xdp_return_buff() */
> +			xdp_buff_set_frags_flag(xdp);
> 			return true;
> +		}
>=20
> 		frag =3D &sinfo->frags[sinfo->nr_frags++];
> 		buff_ =3D &ring->buff_ring[buff_->next];
> @@ -571,6 +517,11 @@ static bool aq_add_rx_fragment(struct device *dev,
> 		if (page_is_pfmemalloc(buff_->rxdata.page))
> 			xdp_buff_set_frag_pfmemalloc(xdp);
>=20
> +		/* The frag's page pool reference is owned by the xdp_buff
> +		 * from now on.
> +		 */
> +		buff_->rxdata.page =3D NULL;
> +
> 	} while (!buff_->is_eop);
> =20
> 	xdp_buff_set_frags_flag(xdp);
> @@ -674,6 +625,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self,=
 struct napi_struct *napi,
> 			err =3D -ENOMEM;
> 			goto err_exit;
> 		}
> +		skb_mark_for_recycle(skb);
> 		if (is_ptp_ring)
> 			buff->len -=3D
> 				aq_ptp_extract_ts(self->aq_nic, skb_hwtstamps(skb),
> @@ -694,7 +646,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self,=
 struct napi_struct *napi,
> 					buff->rxdata.pg_off + hdr_len,
> 					buff->len - hdr_len,
> 					self->frame_max);
> -			page_ref_inc(buff->rxdata.page);
> +			buff->rxdata.page =3D NULL;
> 		}
>=20
> 		if (!buff->is_eop) {
> @@ -713,7 +665,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self,=
 struct napi_struct *napi,
> 						buff_->rxdata.pg_off,
> 						buff_->len,
> 						self->frame_max);
> -				page_ref_inc(buff_->rxdata.page);
> +				buff_->rxdata.page =3D NULL;
> 				buff_->is_cleaned =3D 1;
>=20
> 				buff->is_ip_cso &=3D buff_->is_ip_cso;
> @@ -851,6 +803,11 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_=
ring,
> 		xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
> 		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
> 				 buff->len, false);
> +		/* The xdp_buff owns the buffer's page pool reference from
> +		 * here on; it comes back through the MEM_TYPE_PAGE_POOL
> +		 * memory model on every XDP verdict.
> +		 */
> +		buff->rxdata.page =3D NULL;
> 		if (!buff->is_eop) {
> 			if (aq_add_rx_fragment(dev, rx_ring, buff, &xdp)) {
> 				u64_stats_update_begin(&rx_ring->stats.rx.syncp);
> @@ -858,6 +815,7 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_r=
ing,
> 				rx_ring->stats.rx.bytes +=3D xdp_get_buff_len(&xdp);
> 				++rx_ring->stats.rx.xdp_aborted;
> 				u64_stats_update_end(&rx_ring->stats.rx.syncp);
> +				xdp_return_buff(&xdp);
> 				continue;
> 			}
> 		}
> @@ -969,7 +927,9 @@ void aq_ring_rx_deinit(struct aq_ring_s *self)
> 		if (!buff->rxdata.page)
> 			continue;
>=20
> -		aq_free_rxpage(&buff->rxdata, aq_nic_get_dev(self->aq_nic));
> +		page_pool_put_full_page(self->pg_pool, buff->rxdata.page,
> +					false);
> +		buff->rxdata.page =3D NULL;
>  	}
>=20
> 	self->sw_head =3D self->sw_tail;
> @@ -983,6 +943,11 @@ void aq_ring_free(struct aq_ring_s *self)
> 	kfree(self->buff_ring);
> 	self->buff_ring =3D NULL;
>=20
> +	if (self->pg_pool) {
> +		page_pool_destroy(self->pg_pool);
> +		self->pg_pool =3D NULL;
> +	}
> +
> 	if (self->dx_ring) {
> 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
> 				  self->size * self->dx_size, self->dx_ring,
> @@ -1021,9 +986,6 @@ unsigned int aq_ring_fill_stats_data(struct aq_ring_=
s *self, u64 *data)
> 			data[++count] =3D self->stats.rx.alloc_fails;
> 			data[++count] =3D self->stats.rx.skb_alloc_fails;
> 			data[++count] =3D self->stats.rx.polls;
> -			data[++count] =3D self->stats.rx.pg_flips;
> -			data[++count] =3D self->stats.rx.pg_reuses;
> -			data[++count] =3D self->stats.rx.pg_losts;
> 			data[++count] =3D self->stats.rx.xdp_aborted;
> 			data[++count] =3D self->stats.rx.xdp_drop;
> 			data[++count] =3D self->stats.rx.xdp_pass;
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.h
> index 6431cc62962f..58bcadb3e3cc 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> @@ -17,12 +17,12 @@
> #define AQ_XDP_TAILROOM		SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
>=20
> struct page;
> +struct page_pool;
> struct aq_nic_cfg_s;
>=20
> struct aq_rxpage {
> 	struct page *page;
> 	dma_addr_t daddr;
> -	unsigned int order;
> 	unsigned int pg_off;
> };
>=20
> @@ -105,9 +105,6 @@ struct aq_ring_stats_rx_s {
> 	u64 alloc_fails;
> 	u64 skb_alloc_fails;
> 	u64 polls;
> -	u64 pg_losts;
> -	u64 pg_flips;
> -	u64 pg_reuses;
> 	u64 xdp_aborted;
> 	u64 xdp_drop;
> 	u64 xdp_pass;
> @@ -151,6 +148,7 @@ struct aq_ring_s {
> 	u16 tail_size;
> 	union aq_ring_stats_s stats;
> 	dma_addr_t dx_ring_pa;
> +	struct page_pool *pg_pool;
> 	struct bpf_prog *xdp_prog;
> 	enum atl_ring_type ring_type;
> 	struct xdp_rxq_info xdp_rxq;
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_vec.c
> index 05814fea0f5f..8e15405d4941 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> @@ -146,25 +146,32 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct=
 aq_nic_s *aq_nic,
> 		aq_nic_set_tx_ring(aq_nic, idx_ring, ring);
>=20
> 		ring =3D &self->ring[i][AQ_VEC_RX_ID];
> +		/* Registering the MEM_TYPE_PAGE_POOL memory model below needs
> +		 * the page pool created by aq_ring_rx_alloc(), so the ring is
> +		 * allocated first. If a registration fails, the ring has to be
> +		 * freed explicitly: rx_rings is not incremented yet, so the
> +		 * unwind through aq_vec_ring_free() would not cover it.
> +		 */
> +		err =3D aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
> +		if (err)
> +			goto err_exit;
> +
> 		if (xdp_rxq_info_reg(&ring->xdp_rxq,
> 				     aq_nic->ndev, idx,
> 				     self->napi.napi_id) < 0) {
> +			aq_ring_free(ring);
> 			err =3D -ENOMEM;
> 			goto err_exit;
> 		}
> 		if (xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> -					       MEM_TYPE_PAGE_SHARED, NULL) < 0) {
> +					       MEM_TYPE_PAGE_POOL,
> +					       ring->pg_pool) < 0) {
> 			xdp_rxq_info_unreg(&ring->xdp_rxq);
> +			aq_ring_free(ring);
> 			err =3D -ENOMEM;
> 			goto err_exit;
> 		}
>=20
> -		err =3D aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
> -		if (err) {
> -			xdp_rxq_info_unreg(&ring->xdp_rxq);
> -			goto err_exit;
> -		}
> -
> 		++self->rx_rings;
> 	}
>=20
> --=20
> 2.47.3

Reviewed the full series (patches 1-3) - looks good.
Not creating any issues with the newly added PTP feature for AQC113(Tested =
with PTP).

Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>


