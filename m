Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94789249EB;
	Fri, 24 Jul 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898094; cv=fail; b=hHKt2azEx+3ba/Z+cP7M/7Y06LA0jRWJachP71/7asPNfXar9ZuHbyrn2BQVjs0vCZE1mCVtkgmMHQBmLy57j9wSZDdQtc42yP07WQTEfwWOmQLOx46EWJKv5TNdfLiSZDVnL9/DJn4g+VZy6Qyqmm3fHNx4USHNEf8b0c9ChZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898094; c=relaxed/simple;
	bh=WUWg24Ue02BHbMXVvePBHRUfu9HcBg7ikrYxd5FdCsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OWiBL/r2zqzBLpSd+KOtx+tQ4pkbAB9LZCIHJzUIXukK+WVkPxvZpxTYQIgsdGbcaG397qgVFjEokkQrGIuI54WqJ9NZZZ3hsVqaKh9dfY8B4wpa0Zll4QC/VapgoVNwuHj8/aHcaruSILQwB17YTUJXBBJ9hktzt78eDOyPKrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FX8lIk0v; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FX8lIk0v"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCnZMp1813309;
	Fri, 24 Jul 2026 06:01:17 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020098.outbound.protection.outlook.com [40.93.198.98])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fm66g8afg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqykne57vEmN0xhVnfyShqCT6hiFIpVl2/1zUdukzlkmLYqTbM57L/37TYKnEC72L3kJwIfL/LfBOqz5M0CbmhS9CVWCvO1q/Vj/iwuKGeWrCmhcjhc1pqy4Ayu6w71LwYSN3GpfOjPOhMLu6SpHy4t2011Znlw8Pm1y5ynEjtFmKi9FR9X19/Rz/YernTKuog1nKrF0FjbOtcjVLAJsX3zm4fEdZAaiFjEHhcCyHeUl7IJ5/ZGWzcFBXigKIAmuzce6CbDL22+NIjQin0ngwC3goH52G4kZh19dwZwhtTZvP2pNhjCci9OCGzkqLDZ+SS13PxoIHMAsR3Zy8Lt+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK61bp5NK2IkKI+FshQP7g0p845tMs7A4GG7YQiciE0=;
 b=MuISyKwuEuSjsL32sPhq2wcrvQLIT5BkA7F1bartJiAJrOmexkmlW2Q5tHVb/Ihkj6//qFqL8Vd/gF+BalWGIiW/v54HsGksx/rwp27Kj4SXZbwnGDEliZHpjGeS9F9vwtOd9iKq7Wt11ntM5zvwTFQzWMvLgPSyv3xLrZK6m/KT6Qrr1Cq0Km5x50D/vd/8iSMR67z8varazWfMQ+4D8clBP26itf33uAh/TsNYju4JSDP9GthSLRL9OxC2TgFzgm3DRv2KUbX3A0Qgs9XaGdLNoWxu0YTUUAyNtFzpIUy2NDhpxD32IwDxmGcp/WgG8Ws6qSQg+QgtvC4pIqEECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK61bp5NK2IkKI+FshQP7g0p845tMs7A4GG7YQiciE0=;
 b=FX8lIk0vd4hjrzzgYOtpYM67aDWkpYiYPoedBg7zJunFWyfcRB0+3p1+6RbSpxux3x6M7bezVeLC8myXDhcuTGo97/QmuAjggl3hP0xYOVI6PiJNDKPnKu2itPaEQAbNqQHGb2DxHKV1Yh2Pa4uesZtKFRnXe/JbSkl1nso9MEA=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by DS0PR18MB5271.namprd18.prod.outlook.com (2603:10b6:8:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 13:01:10 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%5]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 13:01:08 +0000
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
Subject: RE: [EXTERNAL] [PATCH net-next v2 2/3] net: atlantic: free RX pages
 of consumed but not refilled buffers
Thread-Topic: [EXTERNAL] [PATCH net-next v2 2/3] net: atlantic: free RX pages
 of consumed but not refilled buffers
Thread-Index: AQHdG0sjRp4Ub7f21U61wm/DNO6JELZ8oWAA
Date: Fri, 24 Jul 2026 13:01:08 +0000
Message-ID:
 <SA1PR18MB4600B1FA7D0A1B0F9B701B86BACF2@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_F0FD0A4E6AFB381AE042C7AC87583506F10A@qq.com>
In-Reply-To: <tencent_F0FD0A4E6AFB381AE042C7AC87583506F10A@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|DS0PR18MB5271:EE_
x-ms-office365-filtering-correlation-id: 7f46736b-921b-4d4c-fa46-08dee983a134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 F7r3HfD9Xu7UfmE/BajwSJg6yzP4f+9Eg6/YCl358NRxsGYFWM3/B7Ff3KSJxrlH0wpol0gocPUjSYuFT45vhx+n+lRFCt8r9OhtLVcLalUAkupJnynoh1PElV1z1R5pTojkYeYSu19KqYiFq/3EDjGMgZ83Je78S2Eg2b3YxrJwicwxy/yCE0ijkVLkkPBSD/Vq78yBgyJJlHI4tm18TxP6Qzk4MAdGKwSE6oHaPiyuTMGzhDZS1r84d1bwcXpKMxQA5PyYxdk3086hSD0IoLV1FYmbHiqI6UcaC6fzergwI2GWH4H9//6AuyXQfJo5sfK0wGOcwnSSl3de7DcjDC6PKeymwzwIoKlf48uAF00JNjLAKJuqKq2jbevtY03vwjB9pRnD9d8sCIKMhHbcMOBs8v2pUCVUO3Okt7In04BjmQ/WzcBfenJ1y3bhdksY7pN22VPQ3JSVpYYYYujnCF6Xg7jRHPbSsDiN0q7GVK1yrTLxj/cHESQ+paC1onjEeNPeyeT47jGOgxOeefdHZwjzbnjCi1xr3koRfvgL9cWPQOfuYIh4P6mbNeyqnRRYUiT7HHLDBRB/YskkreoWhKdLVxvNyoLfbzxeSUcv/urKtHda0hV0JjFG8Ib8SDB5JfTaG6FN8YamTkAYyig8lVq4qh7PUG4uxaIjbSioh0grSmydA/p7l2v5gpdQTCyw/7i3kIr0s6nU8cH7KNIBnum1gMNW7Y8F+Pl6JYIuLAc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gr1U0D+tTX9SIzjUWfSg+gaAxUJf+3NqdUPmgcUOMhM5Gjh8uT1RiROLa0Wh?=
 =?us-ascii?Q?RYEB2zmfDypJfYU6YL5zVpAy8tH8m7v9MRuCQbrxUPdTmUQCKjz1zFPsMzhg?=
 =?us-ascii?Q?TT5b2TDa2/BRf6hO6JEDd6bqBYENnzpRbrJmfmvnuAz6lZWgYhcVweCEQW7F?=
 =?us-ascii?Q?z/UjMx4YlaDB0NR94fKy/yR8KFyq1EZNLDBbTG97INi8y6+shloP51FoIweG?=
 =?us-ascii?Q?4Vp78HZ9w1fDX3sohpw2+2vww9CaTP8eak5cyEl9gS770clSsMUQv8R/PCDu?=
 =?us-ascii?Q?ueb/u3N5Yzyyj8Gv6nrjjep/DDXOxavi5vylbVNVPJDVW1MEkhJuqxLdFKgv?=
 =?us-ascii?Q?VsBWrjTiXxlvj4bKyPXZtveYLtQocyT1t/bdo9e/awOXuQ9k2DGGvhl4+O58?=
 =?us-ascii?Q?gcmw8b/oR+5ELUIYtsltN7GpbUV+55jWZUmiVJuJlDquNII+50F5pFHhbuuU?=
 =?us-ascii?Q?ceN9Va77AkpLfxFyd0i0NNJp1+2S91HPgPYWxaHz3i7qadAkq5ht5ZkliHXG?=
 =?us-ascii?Q?gqG4p2cZiKD6vEduIfHUR/2OBKsDVQCh2l3ILB7Ud8iZ0XAEp1wMsbBBrEWU?=
 =?us-ascii?Q?xL5CGuu+WAmTesnyLQzip86hvMUPWibhDo56AgVqt1ZrsT4wg4kn+yewA14I?=
 =?us-ascii?Q?sYyrusknLLjWYEPeEnfnFloBdgjeG3QPhX6dJZnpD2hDzNrX7DzQA7nykO2a?=
 =?us-ascii?Q?3rbu55/5SpukcRk8cMBfZeWGI7fiMH39EqJV3ZLrf/keGCliquHpqU9Oy6Cx?=
 =?us-ascii?Q?ZbSp2jt8CyJ1XEoSR+nyUIJuR4ym3yak6u4e2FpV9d/+jZ8sRyOXqrzDmF91?=
 =?us-ascii?Q?HjTB1AqoAIIwBxpFKyFh7XH7X7+YIVsWa4D3Zb0pixdDwbSQkMgzwsKKaFLe?=
 =?us-ascii?Q?FiEf4Wnkk/utu9jd/PF4EWyn2xW/xWWDNhJmSKCgGChgCfMHax/V1SL0ufSk?=
 =?us-ascii?Q?xgdm6KMm5QTGdgoQ0q6obJaeiHp+IA7IiQ5Iv2X9aQsCSK9nmTaRvPccSuAU?=
 =?us-ascii?Q?8fpopOErC6ksIoqyeympYAQ8RIozlGj+yeZQyumIDDVob0F02DAnGxKTnilP?=
 =?us-ascii?Q?oRqKAKNiXOA9ZZtibTp4rM2y4GC8QWEE/E90fBjNb6qPi7/D+AtATlvZfb9v?=
 =?us-ascii?Q?PlLkmdedAdE5X10yxxHoqT2S+obVvfoMII660TemrVdIlhEn8ZxKr9Kfqg//?=
 =?us-ascii?Q?KSAgyJKMFjcJCWnyfI3X4rSW4jfHwFRN+GPxYrThZK2tgv1OA4SiefCY/pgX?=
 =?us-ascii?Q?yDazFdotzsjvNfD4Hb1tG8usM2+AK/EEeG7B7WgbUQGPPMBLy74AMWCpkei3?=
 =?us-ascii?Q?bS7n5Rjd5DH1z7R4dA6VAgCinLpIRLrQFEhTcxOZF9UM8tN/A6ehOrQy7mvA?=
 =?us-ascii?Q?HPvXyRyI8GusvzCNaFHeETRzP0dLajf0e5eYEWtF26Me1y9CfZA88R1COOth?=
 =?us-ascii?Q?DZRr5sT6UqdX19li/mBGzRItH+2IS8e+/uSTbnBqxePDdtRMgj4lmONEZn85?=
 =?us-ascii?Q?6LCjciFn2NOUApH+J7g8paOqkFdiyfTEb3DF+LSngzrZ5bAHqQphawLI1oGj?=
 =?us-ascii?Q?NkCPOZvGuSon/llL8+4ApHfbR2cp515SypyXDngDelVDCjU+Lu6Y3K0fNGn+?=
 =?us-ascii?Q?6lrdPwH2TSDuaPA2eozjjRlQhMYbldBBq9V1sOuKsj+o0u9O0ypTZX1nrYUb?=
 =?us-ascii?Q?ibWt3wzsmPIlOXnTzbAzS3zYY0KpOuNMYazkZfOSWiSLrlmG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Ie3F5j7BE8+gYLroCDjfnoRvaEumB9WczPGb7XyuVR2u7WVMHSbpUqEYCiDsTFfhpUHwCe0rO7+pyCusbnHY6LXwTvFHVG4xx4Gm9d1NDkIRjtSqmMETmUPlXQy+/tL3QciyMENJVxOAt9OqyYjMAOKZqN2p9SYyccMjoId0ECmJeepGi7TprUj687y/4liaSYBFT/YYVJiEp2GGj613Hict6TAVp52cdwEWZdRlYnNbzRpxJ3PXLuvWVXZULIgcEsUKjTyAQcTPB5N5cDB+u+ZBvGgCETtqcnThY+9z4ZD28BzWHMuNZhmVz7YC2eSiP+U1XOB0E4B5cxc8VG0/OQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f46736b-921b-4d4c-fa46-08dee983a134
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 13:01:08.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcoyR4cmqF7xJQzwxunGZPR8ZZvF/Mu0CekfyQ9K/7v8CDxaP4lAlqreR/NpZqie3XOTtyMSrSccMfqu8/LKwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5271
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExOCBTYWx0ZWRfX8j/5c8t/HfiZ
 +AgHwD8YyLNOscVGSJrLj2ecz7tPPNFQCvyd+j5y/tnt1B+QQ5bN/rV1aJe4nDKjDKSCNy0Apba
 s3SUbsCPlTFVXYotCoxIGw+8f6+ZeKJ+2W+2IEzenfqNkKtEBk9LE3XnUh4TkBCV8MDFgYt7mZ9
 O/zVarToDJ7Wx3f2xCl88b3beVqV2R+a+l7xtGRZz1w9P9pK8vdGoZLZB2+kETQ7M2MZbZ0w7F/
 CpHNORtvIaSDfLBLUMIc4lpZe6jP2h70gHs8xvUasFrPlpqEW1B1pvq+aV/OA9JZgDNujtwX5Sg
 o07BRzxqWUMv6AyAwk9u4+VfCEFVWHfUzdOj+8adesxh8cveRXkZwyC1c2N9Td3JZKE9ur0whau
 OCyBea0083PMAyq2AyVuDE3MwweDUq1ZD2pfa2llQh9BET8rAq9lg+I4jUgSCSiS0vgOuPyhxZU
 2muqtENfogQeIbfxueA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExOCBTYWx0ZWRfXyBUPq8glFPU0
 D4mJs2fjZVqSrV/4SG8lYCl1b3tW8gSzgNdUPvApxxivG8T/QwjkZ7aDDy8/+jnGQ88Mb9OKZco
 fZ4bA8foonpvFy9buhKCXThZl/FKNSo=
X-Proofpoint-GUID: oMxIxcjUMoWX8aCniMQKkBPGsDKIlpu6
X-Proofpoint-ORIG-GUID: oMxIxcjUMoWX8aCniMQKkBPGsDKIlpu6
X-Authority-Analysis: v=2.4 cv=SrqgLvO0 c=1 sm=1 tr=0 ts=6a63621d cx=c_pps
 a=5WG37Iiv9zZuKkK3l3Cj4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=1NV-BSczsOLvH7eC:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=UQ3F7XsocM0Iduz3li4A:9 a=lqcHg5cX4UMA:10
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_01,2025-10-01_01


On 24 july 2026, Yangyu Chen wrote:

> aq_ring_rx_deinit() only walks [sw_head, sw_tail), the region posted to
> hardware. Since the page reuse strategy was added, a cleaned RX buffer
> keeps its page (and its DMA mapping) in the ring for reuse, and refill
> is batched: aq_ring_rx_fill() returns early until AQ_CFG_RX_REFILL_THRES
> slots are free. Slots that were consumed but not yet reposted therefore
> sit in the complementary [sw_tail, sw_head) gap with a live page, and
> the deinit walk never visits them: up to a refill batch worth of pages
> and DMA mappings leak on every interface down.
>=20
> Walk the whole ring instead and release whatever is still there. Also
> bail out if the buffer ring is already gone: a partial
> aq_ptp_ring_alloc() failure frees the ring but leaves aq_nic set, so
> aq_ptp_ring_deinit() still gets here on the unwind path.
>=20
> Fixes: 46f4c29d9de6 ("net: aquantia: optimize rx performance by page reus=
e strategy")
> Cc: mailto:stable@vger.kernel.org # v5.2+
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <mailto:cyy@cyyself.name>
> ---
>
> Notes:
>    Without this fix, the following page_pool conversion turns the missed
>    pages into fragments that page_pool_destroy() waits for forever.
>    Reproduced on an AQC100 with the conversion applied and this fix
>    reverted -- ordinary small received frames (<=3D 256 byte header-only
>    packets, e.g. ping replies or pure TCP ACKs) are enough to populate
>    the [sw_tail, sw_head) gap:
>   =20
>      ping -c 200 -i 0.005 <peer>%enp99s0
>      ip link set enp99s0 down
>   =20
>    One short ping flow left three of the eight RX rings' pools with
>    stranded fragments, and page_pool_release_retry() warns for each of
>    them every 60 seconds, indefinitely:
>   =20
>      [278084.929092] page_pool_release_retry() stalled pool shutdown: id =
123, 1 inflight 60 sec
>      [278084.961064] page_pool_release_retry() stalled pool shutdown: id =
126, 1 inflight 60 sec
>      [278084.961087] page_pool_release_retry() stalled pool shutdown: id =
125, 6 inflight 60 sec
>      [278145.346737] page_pool_release_retry() stalled pool shutdown: id =
123, 1 inflight 120 sec
>      [278145.378745] page_pool_release_retry() stalled pool shutdown: id =
125, 6 inflight 120 sec
>      [278145.378759] page_pool_release_retry() stalled pool shutdown: id =
126, 1 inflight 120 sec
>   =20
>    With this patch the whole ring is walked at deinit, the pages are
>    released, and the pools drain immediately. On the current code the
>    same gap leaks the pages and their DMA mappings silently.
>   =20
>    Applies and was build- and runtime-tested independently of the rest
>    of this series, against the current page scheme.
>   =20
>    New in v2: split out of the page_pool conversion and made a
>    standalone fix for the existing page reuse scheme (Mina); Cc stable
>    with the affected range.
>
> .../net/ethernet/aquantia/atlantic/aq_ring.c  | 22 +++++++++++++++----
> 1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 81685a4dc5a6..e1193c6719d9 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -950,15 +950,29 @@ int aq_ring_rx_fill(struct aq_ring_s *self)
>=20
> void aq_ring_rx_deinit(struct aq_ring_s *self)
> {
> -	if (!self)
> +	unsigned int i;
> +
> +	if (!self || !self->buff_ring)
> 		return;
>=20
> -	for (; self->sw_head !=3D self->sw_tail;
> -		self->sw_head =3D aq_ring_next_dx(self, self->sw_head)) {
> -		struct aq_ring_buff_s *buff =3D &self->buff_ring[self->sw_head];
> +	/* Release every page still owned by the ring.
> +	 *
> +	 * Walking [sw_head, sw_tail) is not enough: refill is batched
> +	 * (aq_ring_rx_fill() waits for AQ_CFG_RX_REFILL_THRES free slots),
> +	 * so slots that were cleaned but not yet reposted accumulate in the
> +	 * [sw_tail, sw_head) gap, and they keep their page for reuse. Walk
> +	 * the whole ring and release whatever is left.
> +	 */
> +	for (i =3D 0; i < self->size; i++) {
> +		struct aq_ring_buff_s *buff =3D &self->buff_ring[i];
> +
> +		if (!buff->rxdata.page)
> +			continue;
>=20
> 		aq_free_rxpage(&buff->rxdata, aq_nic_get_dev(self->aq_nic));
> 	}
> +
> +	self->sw_head =3D self->sw_tail;
> }
>=20
> void aq_ring_free(struct aq_ring_s *self)
> --=20
> 2.47.3

Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
