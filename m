Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.156.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793078543;
	b=kUn9Zp8rZdEz7UWQO/rMqRjegN1g0XlGIsKro07Vo/AsKFIX+xWulpC7+HxwWbLBpViO
	 gnLRzOjQfImX3v9bAsAofBG+CYj8+34SjTM0giVcaofZe1J8U3WGig3p9ujVl6kXE6VnO
	 Uc1iEmxdSdOBBmRkqGzxHEFbEFzvZZzNfHxo5IZuOQ6+5VikHIuG3Wfx/OlRI15hnXuFF
	 NcMxUtukvq2pSMfmeotXtCX7lDPEaoWcgtUEBLNVBcHmEJn/qnTRL+vPVy+X70MOjmZkO
	 ZAx/S35HIe9HCg59smCfmGAnqzqGzXd8Ix0eibKS4MyYu9VC+nX5TV78rpADcpLfHrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078543;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=0enu2qVzhPGW6c7KaUX3JZlgQY44KPB0uV46iWQpl60=;
	b=m/ht9L3Y134PyTVe1yVF5iEZWL+kV6Q48U4eptVJqNCQE6TOKWAzmBpRBSUXoZvtZmkE
	 BXy3PFJOkKFEs08Pfa5EVtqiM/jiUkJBiTGmSjp/xumre+WdVwCfXF9xuN6obCaf25+0F
	 6Z6Y6Q+u2MM6RZvgTuG9J+qOhEpBrwHHg4OKsietoHGQGymnzw00VI4dl17chIogUfojE
	 r98Ru6csO3QaxCnVeAQcJbVR4N5elFbdfQdZTdyPb5YZz4mNEMrHsP3cmkBPbSUglj/p4
	 SAEMqMbVpLjB1f+GOJvcLfAnQnTY3W0i/u3+3UNyhaGcBAD6Gm9H/c6eWg7OjacJOPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=uy8NgjEd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC57606A31A;
	Tue, 27 Oct 2026 05:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC57606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=uy8NgjEd
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R2EMWi361333;
	Mon, 26 Oct 2026 22:21:54 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020130.outbound.protection.outlook.com [52.101.46.130])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hja63au17-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 22:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r71Cdwr5wFMP8RaS2vjyb7YlP2a7DR2Jd1haTGbBieqUUYl8425FcztTvbIi2+S1kDFci7097XtqaGIV/8rttU+hCPS+r9xmWkFdzbIvKAVvaaVY6spzaxN4qdMo+lsoJwL3qsJy+btcNjK4FLGn8d5eG6Vmk4/dj4HaWjtsZdKxKvuto3nsqZkhXou0gKDQuHxwgslLpEM8BYS8Fw2Vn4s35XXB4vm5Lcn/17rBu64dumd+Pp5ywD1TRP3efIopGHTyTt0NuYkRhclOi53o44EzJAuDBWszXlqTxBu7QzFs9DiUfjSR/CAfr+1Zlr3A/4gfLuxzlhtXfFHvqc82nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0enu2qVzhPGW6c7KaUX3JZlgQY44KPB0uV46iWQpl60=;
 b=ow0c0JagvtvQD34/2yM8Nphdek7/aKIQadgc7L7XHwP+/fE30pj0pGNjOxBk16tR+u9BKgC/CN0m1YKdTpMbRlZeUXkfssPUeAc3u2rWu1rM2zJ4J6smOOgLMHL0A2QWqkGQLpzCOrKdDY82sWrxZFDPpsLf+vxsoZTH6VdMW4Joh8JZOKe5CNcjaC8Nq5IUt2EjEnFcgX0kXtBzv96vgQ5P4tPghZqrjZy7HW+q/fA3lSPs3yYJ9Px+zqUUnIYE9+R4AOTId0NSKz+YpFvt5c9uXwD/m12cKnEW0rMzVKIy9BSQyKfk6DQjxh/pgBTrrhAqFL0KZeJHsaHS/YsGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0enu2qVzhPGW6c7KaUX3JZlgQY44KPB0uV46iWQpl60=;
 b=uy8NgjEdOM7+bmy+7mSLeP6jczvOXtNnssh7a6WYY7AihriuJ4ubMf2N2vj/bDSfTUcBqY15X+/a7ia1Rpx5Le/ka5sRLOLjciLSXsyRF5yXiRILXcNuclDhqRcYAAbGwbFBMtcz9BZha7MtuK8QBGbLPpoVO2KOrRj2gjyzNIw=
Received: from DM3PPF7732E70AE.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::6af) by SA1PR18MB6065.namprd18.prod.outlook.com
 (2603:10b6:806:3e2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:21:48 +0000
Received: from DM3PPF7732E70AE.namprd18.prod.outlook.com
 ([fe80::753f:30bd:74f5:a0bb]) by DM3PPF7732E70AE.namprd18.prod.outlook.com
 ([fe80::753f:30bd:74f5:a0bb%2]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 05:21:48 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Yingjie Wang <1075151112@qq.com>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] perf: marvell: Fix DDR PMU polling period unit
Thread-Topic: [EXTERNAL] [PATCH] perf: marvell: Fix DDR PMU polling period
 unit
Thread-Index: AQHdZcJ2lwZMMH/oX0ukm96ZyIiijbcQ2dsA
Date: Tue, 27 Oct 2026 05:21:47 +0000
Message-ID:
 <DM3PPF7732E70AE966A965A2A04EB19214ECD602@DM3PPF7732E70AE.namprd18.prod.outlook.com>
References: <tencent_592E3D2D89322E934E28FE593E67826AAC09@qq.com>
In-Reply-To: <tencent_592E3D2D89322E934E28FE593E67826AAC09@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7732E70AE:EE_|SA1PR18MB6065:EE_
x-ms-office365-filtering-correlation-id: 71e0a090-d468-4d0a-1104-08df33ea32ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|260925022911599003|260925021311599003|260925021911599003|11063799006|56012099006|261021123027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 AEp1zqtGElWJ23FW3JcAwUPVtn7pdgebO+T89JrsvOwjJbzr0oY62HA91WvDU1vfyrqt/HuXOL+k0YIecUpZvOCcgpNxqSjqrNiGduvej+TYPJoe7mzNyztB9yOAj7NfnNPl6LH+krEjB2CqvQhk76RmYl9gNcacLCS60l9tKjSWWNryH/jlGCdlYMGfbPNCW1HMQHGuKovHNiRcxCIsIUf9U/dQ8FLPM69csZXOiQQzq/nOyJOJTsRc6GjLi7n8IgwzKa3Q8yiIjph8KxQyGU7dExynW0Auk+FpGAjMBnxwnjXIFeQxymFt/gxawFx3hKPX10Q+bxqsNEhtwpkpESGyq2SQhGMC50hlkF/6AUN4Roh/pbUX2q2Iw97nuHPWzPIoiXGUFhPAFaY7ekRwbqq/C+s7ajGquwlclws+ybCpkMBIeItgXL5eDCYwMDtHNGa4twTgZXsREFV4KwhKTT+nUOezabXAV8LNOGyN5nA5ZtMBVYOtMcznAHacXSOhYztk6VgcO39hXMF4CBxFhDVYvA8e29iR6Lb6fcFgLd7AbRhOvvB0fD4FtUn3yR4B6As53Lq1pOsTBm6JtkVYw+OvSnXHVFQCxMxWQxLDJtdAj/8MswLE+nJMKqUyGB18Ciz5WvN0nm7wauL/sMBiPLVHTySiXafwJBTGAPg2tPtbA4XDVBEfYgVZcCPwD1QDtGS12BQDEIgXtO7avHs4lLDSmun82LOQ40YqxZc7HbU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF7732E70AE.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?diR+D/ug7FczA9+Dmtb3uOIhGLE2TVC3hOVtxZaiWOOmhtNzukMmhEk57exU?=
 =?us-ascii?Q?dgV2XEA81xsaa2Ejo1QgePj32kxR5YOrmYAJ581+A7X9XHiy8KTVBel7K1Dr?=
 =?us-ascii?Q?1lmR1MDM8mjBkry+to06SAd79x3TeNmjCs0G6aL/au1R5asd87Urtq00Xk7z?=
 =?us-ascii?Q?n3NtDAUW4NWv9GQPZ4q7j0iLlpeeicy+7HX3RRkjjab2BKDZdxj8O3HK4J3J?=
 =?us-ascii?Q?41DlzQOFtQQ9srOgxcm9EIqZTfa9Bi0IKlXRJMSNJsTBwREtisIAfs5OGtiQ?=
 =?us-ascii?Q?QwiTXvw+KjoK7vKQrV6hhUlMN+qrSMNRECsslzGTDZOc/k3sRduSpcA4faCW?=
 =?us-ascii?Q?K2kWlA0u2eGE5jk6/ZYwpJ5V+3iFdnMSaIgN6+2wQMk0DrM2SvBHDaDNkjFK?=
 =?us-ascii?Q?pDhzv9TfwYi0O+rICHP7nikNfwPcHZzWhA6E6jXOtDRwv7Wp622IQ6RJda8G?=
 =?us-ascii?Q?cz/PL/2Gpr+RYS0Zz5YZAmNK/FiEdS/cTi0QJ7ZiCWyiPUjW7MVHNclaD4UO?=
 =?us-ascii?Q?yvBKXhXii6r6ODy14cQLLmQFnbLIRuDHfFxKGxwr3ka2Ric65//5l4lj1Aos?=
 =?us-ascii?Q?lw+C6ihhZbYe/F28lsPSQSzbb39fQdu5xzLi+XK6398xCclagH+r/nBFBer2?=
 =?us-ascii?Q?/UKnI68Fc3O2i4/0lL8Kk1l4C7UI9crlS1FKiQMVPyz7iGj5rYEfW+Opx6Ul?=
 =?us-ascii?Q?u07mGFKOs3/d+ntCez+WsUe7pqT5n3vG974iDwVOsZmUfgfSA84h6gw9v0TE?=
 =?us-ascii?Q?xJqiLWAjvQbv7Jh3Cn9B9ezjS/7UtAyUAr8Z0QYjs/pctTCdJcgm98R3PXXR?=
 =?us-ascii?Q?3Y7/SztKIqc9/gzADEmqscXeuGfHpuyak2EMazBet44y4NI3ZMQNqTKZnVIc?=
 =?us-ascii?Q?6n1dOsqHh7VTykR1xLI+pI4xjkRgNU8VxL9Cc13X0Bt6yZy79e+1Nup1yXhU?=
 =?us-ascii?Q?+OzU2icYMw04oYgGPzoI+0kyzBGD3ctpwUXvpbfQerVrw5TcxA/9AhxxaGxI?=
 =?us-ascii?Q?pfVJm6BDUtFZUP8puDmHr2/hNoyxRNqhs1AITQofRZSRSQg6BjBZ7cII6Mzg?=
 =?us-ascii?Q?VHaTowJAJKEY4xQP4Uigr6hqBD/YfyhFq7Da6whK11fDIHXE9ZVHBbm06TT0?=
 =?us-ascii?Q?wXgvW9qgMrNDhgmZnVUdw8rLd1G7j7qgiCky8XiuCKg1L4KBSuxSapVA5kpQ?=
 =?us-ascii?Q?6mQY7tw/sfg5wzGX/zaXZJJ1KtLQq9P5ejYPzG3Il6GKfxnL0630W11MDKx6?=
 =?us-ascii?Q?SvzjutiMmSxqtP3a0nHFGAFKB9N5VWaCZnuWiQjuHMrguPGg2C6W79iIcmiZ?=
 =?us-ascii?Q?tnYIaBnKbUI1vrZTR0xUhuwSLG6ZRdadj/V93agTifR0iaAWfz0QkHVBrvw2?=
 =?us-ascii?Q?hHqqi0GPgLXF5fl6E0oWW8l4A6HSjVE+1rvuXz5kfGWlJBGVpTQHjH27f/7O?=
 =?us-ascii?Q?1i7rlBE6SsFl21BjxvUPWQr5ebYI0XoY3b6G63aAG3Gz1/bQnAxkErbHJ5Zs?=
 =?us-ascii?Q?DOpXdqH1rpDbiJHc8mslAmPaEPEoikxknENnbjRgWXE64AwkEoEN4Ek/Z7zg?=
 =?us-ascii?Q?KLmEbcGyEao5E4qgqy8kUikvagRULwrSFxeeG2JgWpOMhUMK6uNONUqAzROl?=
 =?us-ascii?Q?CRIUyCR1nibYk0g6g6/c8Y7CkXGakxTQf+RLR8hzAIOynOVhcFiUCEdT29H6?=
 =?us-ascii?Q?tVLggcIWN9CfO6EA05P7iJkhs5a4SG5854IOcyhGLUNPKeuc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
	UYJOvwoROAdRxWGXzdoNVlS1JyRFrr/ZjWuAHLy1DbcwTPm9LQ6Dqk0+rfXWOz/lXmntEXm+Fnw9QBF3UjwsYnSo2BQUoaj7K3DxFHDd54R9vZijM1mlF/+uZt9tG3CXHp4lgxCv7NSb5Ffz1sdEq5eTk9EbnxFfe1wAN7nl+Yb4NI+YCx7BENJN07uD3eoKWN/L/xtCBpKuPBnF3YsjS2IiHCnkAeWiGUn1sE7sinuKcpdiVBNv1gEBTyqXOaOTq1vG+EHS1+yn7u+YiiM4PaHjEgedSYSURg7odC6u73DgbVU2CcfD2Lnx1flvdrzU8uoXV5JKTwnUBtLfTfSfIw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7732E70AE.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e0a090-d468-4d0a-1104-08df33ea32ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 05:21:48.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1UqeQJtXNZoApDl68hFDfrhempaAJOsrsRVN8zI6xIQu51rV4yWmXC3Z24uohQqDEeyiDIvpdEpQcoVxbTaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6065
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX455XnKwIDTmm
 swR7PsADOHTuS5Bi8OaY84iZMbxQtG6uElhtK9GHx+3PKVBBNV7PdR7Nw6xpmmcmekTxygf3Xur
 XmFPJ5Sop7/vn5sTjUvUTy2t/wMTp7M=
X-Proofpoint-GUID: 9uIQLFrlQPn60pHnEKx_zArj9nQOX53a
X-Authority-Analysis: v=2.4 cv=PJCaavqC c=1 sm=1 tr=0 ts=6ae034f1 cx=c_pps
 a=9hhwatWKa7/vLw/BZzsOGQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=dZbOZ2KzAAAA:8
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=M5GUcnROAAAA:8
 a=CmyYjPjWn2xqFErP4zYA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9uIQLFrlQPn60pHnEKx_zArj9nQOX53a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX7tToN6tBFsg/
 9jTHtcl7rf6QUbHcHdRLFbOex53YSKRrm3Flz77wJ69DpJxtHfsk2cY1RITV3oKjsFs5/5kiMsg
 IKeelUuDOZn5Ww3zEV9N/cNkeVbSZEYB1GfGtcqtTK/x9SC9abxD9KL3DO3MrXYx5Renq8ctJRp
 LQPnxNaIscUB6rfv5Gl3JNtLaiuiJ773dn+dZiVyQMucSpeG/Gc+TRnLU+NwEy2HYPF5OCGvggY
 o6CTbz/AdlqnNQ9B7jAaY/9jr91sm/rGnB+e9NIrt7l5jmrtj8aeJ24T7rUliEOspTo677WsCNS
 3fMboSxBfmtPG2pIcJhFmzdB5v96whoXtFPbVskdBCGfkGT64WVJI0dYd849FKPyJSoGiwXmfjU
 iQ7iZFAbCYzZysAaFawYfQkGshrmcmzV+wYHFzDa7b4QTnJAvEfdWYuvTfwB6txs0bDAWgOJRgT
 xoZnOtbr2nc4Km2Vgyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01



>-----Original Message-----
>From: Yingjie Wang <1075151112@qq.com>
>Sent: Tuesday, October 27, 2026 8:53 AM
>To: will@kernel.org; mark.rutland@arm.com
>Cc: linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org=
;
>linux-kernel@vger.kernel.org; Bharat Bhushan <bbhushan2@marvell.com>;
>Geethasowjanya Akula <gakula@marvell.com>; Gowthami Thiagarajan
><gthiagarajan@marvell.com>; stable@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] perf: marvell: Fix DDR PMU polling period unit
>
>The poll_period_sec parameter specifies the overflow polling interval in
>seconds, but cn10k_ddr_pmu_timer_period() multiplies it by USEC_PER_SEC
>before passing it to ms_to_ktime(). This makes the interval 1000 times lon=
ger
>than requested: the default of 100 seconds becomes 100,000 seconds.
>
>The driver relies on polling to handle counter overflows. Delaying those c=
hecks
>can leave programmable counters frozen at their maximum value and lose
>events until they are restarted.
>
>Use MSEC_PER_SEC to convert the parameter to milliseconds for
>ms_to_ktime(). This corrects both the initial timer expiry and subsequent
>polling intervals.
>
>Fixes: 35a43326a9e3 ("perf/marvell: cn10k DDR perfmon event overflow
>handling")
>Cc: stable@vger.kernel.org
>Signed-off-by: Yingjie Wang <1075151112@qq.com>
>---
>Built drivers/perf/marvell_cn10k_ddr_pmu.o with W=3D1 for ARM64 and
>x86-64 (COMPILE_TEST). No Marvell hardware testing.
>
> drivers/perf/marvell_cn10k_ddr_pmu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c
>b/drivers/perf/marvell_cn10k_ddr_pmu.c
>index 9b68d6c1c31cd..31641a21e3792 100644
>--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
>+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
>@@ -516,7 +516,7 @@ module_param_named(poll_period_sec,
>cn10k_ddr_pmu_poll_period_sec, ulong, 0644);
>
> static ktime_t cn10k_ddr_pmu_timer_period(void)  {
>-	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec *
>USEC_PER_SEC);
>+	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec *
>MSEC_PER_SEC);
> }
>
> static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
>
>base-commit: 652ab8ee0d27f21a5f402a0b6ac227c8bbfdd64c

Thanks for the pacth.
Reviewed-by: Geetha sowjanya <gakula@marvell.com>
