Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BF3AE18D;
	Fri, 24 Jul 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897844; cv=fail; b=IxuGxwvDaSwaCGJH+DE+t2B08ze+JkoD709Z+X2JmiXIHGi46WJhF5dXQe0lJfCcwZ/Fo0JuR+QYaYcQaip3qxcMi79P7Xx6GL2m3kRZlsAKKhiQXtQkevquVlczimMUi0OTEeVkxTA3SV0PvmMyG+BKjWgyQCKcnDdl5T7lox4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897844; c=relaxed/simple;
	bh=wHwzZzF3NrmkJBP7RiPFv/5dC7/faYwtDKzXqyuKzyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGFtQ7Tr8q3rEwUT5GpIf7jVTW6BPa9q5TPJDmq++8svd5jbvAhywBVDaqF/979phTc0U9OSViJ5FUjcUJKu7BiREg8sTqOBMAm0n9ZNBKA81MppXEGSLFLhtGNdG1Kl5gXoKznS9bEm7wjej5EwF5wEoPd3dO5vx6dyCOWQCIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=moPOC/3B; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="moPOC/3B"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCoGWe1804984;
	Fri, 24 Jul 2026 05:57:07 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020116.outbound.protection.outlook.com [52.101.201.116])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fka6kd0py-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 05:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlKPWRxMMPJZUXrGfdo4UHqoRVhVNvmUyk7EXVDqp4eXezW4KuEzvTmxpuvrQY2Ax4b/s4fsflPryw5ixT8obSU+4PEeOuS55mSr9GEMp4oQcs2fsMrKAWoe6XjcLojk6o5gunx3SLszRF2Vycr2AwMCIlhI4vvPc1/xjZcTz1vuUIUMAqD2lQWCW7JTPmAmoi+8zjRJOs9s8CnDYwZdZPBVLCcCxM/iT3xwjgigs9Ip2KI1umFKs9ZlWmgSo9YIYVvXIDh+MJN5armLJeRksRl9P9VkXiJeb92tHTU812WkmThUW5oQhCBBG6ir1tiCoAKVuXLC+xHJVREZmRZyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6VunySNjMH+JRK1Uvm4YuEXEbzLXv6+pFO6nfF0c2Y=;
 b=b5gO4sjUvybxdlN1p6l5CGBz53zs+/xGI0laK+DNPI1Mun7zzY5CBvnR+Cg0tzXHkBAvJevGK7VrzFi9Qvtjov17jVoFrrBfk77ai4lFCmKCpNF8BJ434Xa7IzrhfCZ+5tUZs+mQlRowRCoq4ezHgtKfNj2jsCB/Oc7A+058yocmjMZPQde3+2LKe5p5ky0aWYWpq+cxutARQe4g8+ImvaWKVmQf5VOzWWtoNEi91RX3vw5LJ5iCGfNjXLcBSNHboNCBV7/6JZTVzbEgnf86xhkV3OsbqTwv9VhZO3YsqEMnaANkafOWE4OP1Rz2pgbS9GX0oWKGVQYHeO1P4FlHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6VunySNjMH+JRK1Uvm4YuEXEbzLXv6+pFO6nfF0c2Y=;
 b=moPOC/3Bo2sOXq4UkLQ19lXHmCpoEHcJTUYwfIeJuTLQLPmHtah4Ar8IF42glwQalrxMi7XKPvfk9fiQz6vw+dzao0OAIziN+EWB+gzndVk0Uxyj+lbtS688ZyXGfn3Nyd9KicHdIQRE6H9LDKSG/rb4XJ+A27bHtexJ5VmGOy0=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by IA2PR18MB6102.namprd18.prod.outlook.com (2603:10b6:208:4b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:57:03 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%5]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 12:57:03 +0000
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
Subject: RE: [EXTERNAL] [PATCH net-next v2 1/3] net: atlantic: free stranded
 TX buffers on ring deinit
Thread-Topic: [EXTERNAL] [PATCH net-next v2 1/3] net: atlantic: free stranded
 TX buffers on ring deinit
Thread-Index: AQHdG0sZhFF+EAA/Uku3uxtyP8/eL7Z8nU5w
Date: Fri, 24 Jul 2026 12:57:03 +0000
Message-ID:
 <SA1PR18MB4600628160C128C4C95F580DBACF2@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
In-Reply-To: <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|IA2PR18MB6102:EE_
x-ms-office365-filtering-correlation-id: ff03fd4a-b248-458a-629d-08dee9830ee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|10067099003|38070700021|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 3JDPUxtKIdMP1sv2Uu8FbbtPQqkMwL9r/GzE5NTEE2WvFdzHpenT0LCipEhfDZwvFGFmXQLLgdYiD1//A3l90HTSMntP3KJ8LgssZPKTQYvhZDtJS00WSkZpnVEyt+DqhbioMPpaIK9iAzxPuZEXZoI6peJtcnqCOzvFxydLnkR8Q6Fpu4hLBg2jR4dZ4MuXja9bg+5aCAO++lVPj0WqrBybJqVT05ciOf/8NihKdw84JNZd3TIywzeinSb3aNH78soR0Wyb0jVajmwLiQBVoPaCs9Tb8lIzrFjmLhRUDW1WKU1rUYDvT8ftt5+WLrC6/RFJa1bw5asqpIePzJphpXd9LpOU9GJEmDQHvYmzwE+5bIdekAluAE8WW2FZZFG8fOOclYIqvUtFK+dUrSIl/b2lUgdTVUIE88UQ5LJO8IhY1qIJSCBNePqVo+TH52Oz65EchSYKQqGqt2bHl1H+JFXD7poMyybL+FYKnLpaEejtzGDJXBdEtn/BAVrpR15Dqf/7AVy5qEHXaf6K6P9bXuqcw5h4OrHIZYzUjmnnVKMPPiv93yMYa99LJkJN4H1xh5EPgFCgXzsSAuYytUt6fJ8FwFY+gOmTx5uL+Qh9sG0kk+Js99pf1fdVVhczSbZQ21Pdc2mRDn3AOgAlgd2N/JJYPrtkRkJUwm1CBDrxXFP6RDqlvSQUpCQWpiX2d3f+6xUA56xclTguCSRx6GCw4txJqkPhkRkaPsMc7Zj/xrM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X4p53uqPGq6fQkyrMtL+ohQsAfvHy6oVjyQoZCO1ylL+EO6Rd+BF/xObzfFo?=
 =?us-ascii?Q?ICZFEjm+nu+gcT+9oxil0NGINY+MYZlRFhEe41oGhJQGgPxjjc2IbOoWxGtM?=
 =?us-ascii?Q?KLeryhgx5GV8TzFxqRxuLi+G5ZQQbvOWS23rwZqG3ZL7B+uHjRGdo4NJJEDb?=
 =?us-ascii?Q?YEM/OnBxxCaa0743Q1i2lG9Ytpi4ezxAholbkBMWTHqDHL26IxVtSeqtGmGv?=
 =?us-ascii?Q?nUEaFLIo19ttwtL8yWVRKKUnJGsyMxPaxy6aHVC/kf1RNuA7Ynb+QcJ73Y0w?=
 =?us-ascii?Q?0IxnjXVsBNL1qGCYnmnarX+LdTqmcoiExt0iEy7eu7FnBUfd7PBTeLN90Hkv?=
 =?us-ascii?Q?6J+cuDSgvWHiM9OP5LvCCRQTBFtojRCKlAIzIQW+OV2fuzvK8grGj+TY+rGK?=
 =?us-ascii?Q?/vgkL+WB5Ydv/HvjmxOIkrUrqqq00PQapqPzuIy7kxz0o1PG/wI+rUTB69l7?=
 =?us-ascii?Q?COdwFE7/iH0vXdnQ1WGQETGrVdEBlwhtB9AC8JwSIgKChyqduMDGS0xyMdn3?=
 =?us-ascii?Q?gqnK4ReRK54tBiw2Y59QhO/qqqRLkkghF803NQmfExk+aNU0MnZz7ETNISmO?=
 =?us-ascii?Q?o7kLtfkm8m9w5sIpmJe/dblq6sEMmUfWq6CG4bifSiqAxRGUs8sNJ8BhsQFN?=
 =?us-ascii?Q?bTcDk6tZkZNa89KTCpr2P4bmlVMq5rLw3RvmDKdPB9Ds9dNEci4doTmja6OA?=
 =?us-ascii?Q?M97/5Z7CI0x7+6j+gX34MJrl+SGUOZyw0A0UtI1Yfjy8jepv8q7zSIb3nYeC?=
 =?us-ascii?Q?t/tkDUpB8Sn9UK5F/qWbU+l4QRH1zUeXLWMfxMNRhBIvGll09E4Fwsdai/bR?=
 =?us-ascii?Q?6mG41KRcbw39n9d5TEhpKnIxHkBQCt2p35uEhYAhC01Kxl3tConQ59ryjgLO?=
 =?us-ascii?Q?u68q4J/L5UXPvXh2zozhngcezcxfWDeBjVMd2K9yDuVNT9G7AbD0nSu92+zy?=
 =?us-ascii?Q?TGsLTVw2GemgaFRrESp2kzxKjCMfouSfca/aJukXEPrVUNIFb14IB0VtdnpZ?=
 =?us-ascii?Q?JNovhVuOjPqYgYov7WRUcydzdeOy3JvHcVEh/sDqe2aO/uyuHXFgxB/HV/NU?=
 =?us-ascii?Q?YloLI1n/hW3Bxm08pzfSdAt1f7wrptFhdHbUsg+WVBTSYNPUWn4ZDJF2f1C3?=
 =?us-ascii?Q?tEXKbqSgOKot+Rw+0SgMlMcl6R3qxeSpiZn5HuSek4/33ZCpDB2T0CMotTbd?=
 =?us-ascii?Q?ebejideev2E/XhaKpUoFxyc7jRzmzW0MyJmhYkSO+p3DDxjqQCgjftbsALoa?=
 =?us-ascii?Q?lPdCYvYqIvL3UIqYTV1jRATNIFMMFjJ40WGehTzUvadT4kCUH1UyxVUnHt5l?=
 =?us-ascii?Q?wn0OtrH/TcozjmhWln4tFn+coNJ2pqlIYYmBs83bwSn8avbZuhUXWQqIQBng?=
 =?us-ascii?Q?PI7bIJNKcynSkNMlGipa6HiGnIFzkNizFESn/dATF1pYt5BUSEsBsAoEygKB?=
 =?us-ascii?Q?wc6O6zCeBzEaVEd1BFBbZhfqM88L5xv4/gJ/8sNWwc+tDZzhvBgDuBY/OJOy?=
 =?us-ascii?Q?F6masQ2sj3juvlwVkEiuhTUV+GjqnyrIEYFN43mYl0Qa76bLxkVwgOWY8lz+?=
 =?us-ascii?Q?K0q4bV4kMhGd1vNX2fATO65ZcWYGBP081vo3uzoz3CAJIBs2CbDS3qGcGpsf?=
 =?us-ascii?Q?fWiaVI6cOvXwxOi+5w3di1v/ZiFggjYyZ/i2Sp25oT9DvF5uYPvIamPHdC+0?=
 =?us-ascii?Q?AIGF6vbaNcCNQSFwnCHsnc0EWX35vA/Wn0nbxPqZK8oKaLrg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	O9VLJpdnMBEzj45k5IfRwHESznIGgf454T1BA6lheRlqp6C5tq/Tqk79zLgvMlSTDTVaP+Uc3c5FmNdHXn5V9dB16VArsPKsTeCoeX6W25dkmgzzFe7abDDCFET8HKD1iqYxkHjEDyKhtnLVRZQAIK93gbHTWEX5AnXn8Yqn/q6S0huQD8oDy7EN9NWJzxk9VkmTlNRB/aWqGUaZ5BwFXE9+Vh/eKA4Pounm11WJohML3I+xmlTrfkYzoyh/oYq8xfeLkrX0oO9fT3MZD0CvkMlh07hLRiwdBut/Kf32yhKJxZZpFelYW/0rvlyhpe//+OS1EnCkVubwEf9e15oASg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff03fd4a-b248-458a-629d-08dee9830ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 12:57:03.2967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bcjjM5hVGCg2RScoy+HzYH3nEqc3RnlMVIEntOtSH1n5rpOl2NTHWyZfHQ0tlDgr+EGBMeDWMXcEoBYY3LF2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB6102
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNiBTYWx0ZWRfXwmqQHQEwXks4
 wqHxJwGBTEKM2HpgMLVcgAbWJQ+Uw9xooVX9izRnQAGJuKqdTcMy+2+roApAldAxDOhPxVMz7qE
 dtgW1aONutgQKHfh6sgMm7V2o+Bqusw=
X-Proofpoint-GUID: yJIomliEf3XvaB48y6nfDKnY-v5HnO2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNiBTYWx0ZWRfX8yKM9a23ngvL
 pwTtFvC0EdJWc0J3jag+KCLCAYVy9mp51zdvu1QgCtgxRgOrRnjlCXZjJbQmftMkS2MrMetZRow
 jHOqGDXLHNkItv7TXVw4yvw7MNgoQA5u8/ZT40k16YZhNnSRxPmKO0bWzVCT2bN9NVa58KOgrmu
 r4S/0Uej7pXovmoxYbCkbXQVD7V5pQggnWArtL6iWY5b+IeMZfjfG97fC0agFl4l8NJrpFNuSRh
 KhTcJwNJr3CSFaRE5sGH5eqKPUZbU9qnUnBg4172tXYEtgAkR/a8NpRPycdaB6BRP27pkirD3hP
 GQkfTm/c5b6A9JQqCVvb8vAKttw7sPLha132cUqGyiFmtB2XzF10z5bQRuroAilwRYQElhK0R2f
 McTusRAkmb4+v8Q3aAOqi42O0Z8Ayu4KALF4yBUUTNQ8X6bkchC276yrotwbg2XcpjRz43zRPlR
 FVC8D2XeuGC4xlt76dA==
X-Proofpoint-ORIG-GUID: yJIomliEf3XvaB48y6nfDKnY-v5HnO2G
X-Authority-Analysis: v=2.4 cv=Ccs4Irrl c=1 sm=1 tr=0 ts=6a636123 cx=c_pps
 a=3HzPxjwlbby21TQhxie9EQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=P01jzQAOuL4i42ygwAQA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_01,2025-10-01_01

On 24 July 2026, Yangyu Chen wrote:

> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
>
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the following conversion of the RX path to
> page_pool it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame
> keeps the pool's inflight count above zero forever. page_pool_destroy()
> then never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
>
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
>
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Cc: mailto:stable@vger.kernel.org # v4.11+
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <mailto:cyy@cyyself.name>
> ---
>
> Notes:
>    Without this fix, converting the RX path to page_pool (last patch of
>    this series) turns the stranded XDP_TX frames into leaked page_pool
>    fragments, so page_pool_destroy() can never drain and the shutdown
>    stalls forever.
>   =20
>    Reproduced on an AQC100 with this patch dropped from the series (i.e.
>    page_pool applied without the tx-deinit fix):
>   =20
>      # reflect received frames back out through XDP_TX
>      xdp-bench tx enp99s0                    # or any trivial XDP_TX prog
>      # from a peer on the same link, flood RX so frames are in flight, th=
en
>      ip link set enp99s0 down
>   =20
>    The pool is destroyed with frames still stranded on the TX ring, and
>    page_pool_release_retry() warns every 60s with the same id and infligh=
t
>    count and a growing age, indefinitely:
>   =20
>      [161110.753385] page_pool_release_retry() stalled pool shutdown: id =
361, 12 inflight 60 sec
>      [161171.170756] page_pool_release_retry() stalled pool shutdown: id =
361, 12 inflight 120 sec
>      [161231.588685] page_pool_release_retry() stalled pool shutdown: id =
361, 12 inflight 181 sec
>      [161292.005886] page_pool_release_retry() stalled pool shutdown: id =
361, 12 inflight 241 sec
>   =20
>    With this patch the stranded buffers are freed at deinit, inflight
>    drops to zero and the pool drains cleanly.
>   =20
>    v1 -> v2:
>     - return early instead of goto to an end-of-function label (Mina)
>     - drop the likely()/unlikely() annotations, this is a reconfig
>       path (Mina)
>     - add Cc: stable with the affected range
>
> .../net/ethernet/aquantia/atlantic/aq_ring.c  | 29 +++++++++++++++++++
> .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
> .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
> 3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 8ff07de2bd52..81685a4dc5a6 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -360,6 +360,35 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
> 	return !!budget;
> }
>=20
> +void aq_ring_tx_deinit(struct aq_ring_s *self)
> +{
> +	if (!self)
> +		return;
> +
> +	for (; self->sw_head !=3D self->sw_tail;
> +		self->sw_head =3D aq_ring_next_dx(self, self->sw_head)) {
> +		struct aq_ring_buff_s *buff =3D &self->buff_ring[self->sw_head];
> +		struct device *ndev =3D aq_nic_get_dev(self->aq_nic);
> +
> +		if (buff->is_mapped) {
> +			if (buff->is_sop) {
> +				dma_unmap_single(ndev, buff->pa, buff->len,
> +						 DMA_TO_DEVICE);
> +			} else {
> +				dma_unmap_page(ndev, buff->pa, buff->len,
> +					       DMA_TO_DEVICE);
> +			}
> +		}
> +
> +		if (buff->is_eop) {
> +			if (buff->skb)
> +				dev_kfree_skb_any(buff->skb);
> +			else if (buff->xdpf)
> +				xdp_return_frame(buff->xdpf);
> +		}
> +	}
> +}
> +
> static void aq_rx_checksum(struct aq_ring_s *self,
> 			   struct aq_ring_buff_s *buff,
> 			   struct sk_buff *skb)
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.h
> index a70b880ada67..6431cc62962f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> @@ -202,6 +202,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *rin=
g);
> void aq_ring_queue_wake(struct aq_ring_s *ring);
> void aq_ring_queue_stop(struct aq_ring_s *ring);
> bool aq_ring_tx_clean(struct aq_ring_s *self);
> +void aq_ring_tx_deinit(struct aq_ring_s *self);
>  int aq_xdp_xmit(struct net_device *dev, int num_frames,
> 		struct xdp_frame **frames, u32 flags);
>  int aq_ring_rx_clean(struct aq_ring_s *self,
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_vec.c
> index 2f9033ceed8c..05814fea0f5f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> @@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
>=20
> 	for (i =3D 0U; self->tx_rings > i; ++i) {
> 		ring =3D self->ring[i];
> -		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
> +		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
> 		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
>	}
>=20
> --=20
> 2.47.3

Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>

