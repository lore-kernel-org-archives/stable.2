Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C237F732;
	Mon, 17 Aug 2026 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787007277; cv=fail; b=nJjpYsHCkM8VF/zDiJ7pt4AbsxVSOXBB5CCEhH9kCqImzVPwTRPr6cvLsCz/1FzQuv3BVjCA6Hvi7AWvO/4qtdpKKbTUu+B+rWCp5GKqOKYB62PTwChyPJmG8SMqAK/ciYX8k/i0oQO+KRCcjGuLQsCLAzlXDUUa7car56hKJ0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787007277; c=relaxed/simple;
	bh=+1Es1iekum7cN3zZGUFv3N2PyqKhA8EjsilZJqJ821o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ne9f/rUozLI8ZlIuVFRe7Y/IAS/zTAsWjvDqZDukIP1JpCATJpJRAMPAbxSdJW4cbMhxkxtjuxMuAfiAHwyTW13E7SfJ4ayHOzvOgNhDftyBE+Ju0X7tpluVQuiI44Yo7ednw9WnYXLtbojkK7nrIwImq4MQ1icDZG8JxL1Bx4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dFQgWoh0; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NnuDy6zO; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dFQgWoh0";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NnuDy6zO"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67HLoCJa2008296;
	Mon, 17 Aug 2026 17:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=EcsZZ1umWqnIdEU8l9Z38SHVzg5pxaBH/1wjvFtxY
	fM=; b=dFQgWoh0YNaxVo2YyHL09lCaxvO9Ip19O80JV5JlD47VJBrjZuiJ+4xzO
	gQatigrHgecnxLfLWkVnU9HPe70BgGI+tXBBZWtzNuVUub75sKSGUbOVCwwnxRe7
	92DCuCp5RoujSuQzIzam85mxXdSqwCpPK9Qi6FpzvZ7SmGaFbovxbiGqRWw+QSbZ
	hqqPlFpXtD8406c/OsVCBKNKopxoY2WRfUeGJPySMbavcKrJzGNOKmDF28gaIkPF
	4YCK54fcKPA2rIQfmaRVJCAQusFdMPpMbw6BV7gyX1GuiK+lA+kdMXduJauPHJEt
	xKAvMOQoD7f+OwaAclcMdppTcMPyw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g3ykmmhc1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 17:54:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxCuf3U+glSqO3dbfhtW2n7FcTbhOTpO9RX95ouM2vUz++XRU1JF45cpDF3Kisa/9Xp6CJ+60oKgjlAPa96k9t7r6JZ2MhxQOdAvQa206teRNdFlfduYUMg5vYaPWQWQ4TP37KDKxh/goxOCkuaN3/M45+ZOTaW55SAU+DiDANPgATa49cMnDdP2vXH/cs/huSG2/9T1ooOXHF4CovXFfIvyyBt8dd1/L4F/1I0U5p2/4ZwTdZxWEg5Wh1wrBheo0GT2uyYnwwyLU93yxy+ITyUNZdMesolGzNFVzmUJhw6YjfbdWyoVZ8okiKfnRIbPmiU8ujYBEKKwXLJ7Gz6TJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcsZZ1umWqnIdEU8l9Z38SHVzg5pxaBH/1wjvFtxYfM=;
 b=L4w6dzRO6FYHaFWBpgUVzpTBfXKkUzfwPkE+Yv0Bc+4N+DNsitgd78jeSo+QJ8aAS5ieaFSypTIqC6jC63fnEL81CYXjA2CqXW0wh9aTfArXRtJsGF7wD+A8lwwx1cCty6CZcB3SUoyVJBD0RHyeqY06k4hbXBgL6ZubyCYYlpuVFY8kwZoXvUjNLbvyNEEZuyXaRl15xim+uoevcpp9xeEZDeT1XjAuWuZXST2GYglvA6eeJ5zvOXKwTPbbYCm1PoPS2UmzpocaQ5vBvv0VX3sDeBIfbDrRmeeghfRQUwgMk6U88UA5FAJTvsDZaEMzTNGb+tYeQ2dt70syza8kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcsZZ1umWqnIdEU8l9Z38SHVzg5pxaBH/1wjvFtxYfM=;
 b=NnuDy6zObosQCuYNaWUEBlivrglSyYLx4P9qN9Vn+Wld0bP0RS/AEX/yeem786kEbukeGXh0OcyT1co61ZLzxgo0HDLxBR4NMxDDHbfIKOSy9fvkrIczSGTNqqMBR29iqQVZX+Qx8NnIL4zWu/14Fcr6cnYPDH4NtTmqCvnhzdc=
Received: from BLAPR03CA0159.namprd03.prod.outlook.com (2603:10b6:208:32f::34)
 by MW4PR10MB6461.namprd10.prod.outlook.com (2603:10b6:303:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 22:54:04 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:32f:cafe::5a) by BLAPR03CA0159.outlook.office365.com
 (2603:10b6:208:32f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 22:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Mon, 17 Aug 2026 22:54:03 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 17:54:02 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 17:54:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 17:54:02 -0500
Received: from [10.249.36.144] ([10.249.36.144])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67HMs1rc307974;
	Mon, 17 Aug 2026 17:54:02 -0500
Message-ID: <1bced387-8c0f-441a-b7fc-bedbbb4735e1@ti.com>
Date: Mon, 17 Aug 2026 17:54:01 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as
 OUTPUT
To: Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Francesco Dolcini" <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Moteen Shah <m-shah@ti.com>,
        <stable@vger.kernel.org>
References: <20260813111238.56892-1-francesco@dolcini.it>
 <b4ed6b46-07c3-4ebf-9fc8-b9ae0dc03a51@ti.com>
 <20260814071549.GA5246@francesco-nb>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260814071549.GA5246@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW4PR10MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b61f667-6903-4577-0146-08defcb26f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|13003099007|3023799007|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WqQbrzpDxOVbBosnVk7RDgjfwonREz9AEiR2IiNQ+WbS0rkshZ1qfgeCbWCf8GojlEDVAecTkaAise+z3N6OSAMJGyLEjm62oxwMj6KpWEeNx8yYtdE4qx6ZIBGqEs2ooKK+qmz8PiRX+v5TMdXNJTHQJF5bH/3troBQyn91C5gIaKzVpBKuMCueJrTvQRfitANdPdRwEwh2baqZyHam+j7BuJhEboDiZnLCCPT/4+jbS45zfD0+y/Z/tWB79C0ZkAxsMs7qzYn1SgrpFW6GHdY7JIO/B2/e/5sR2Q3QxDO5NIMWHfviYAMB7casgFHZvc8WcR8Mv//Cowm4evoMP5OrCFjJIGHDJA1XNP547SeKLViEWsit+k3EgFULKqmfnV/SKDfvR71r0E2KR/rSZ747aUvIKyuHbPWuL/BWkItGxyLQuSLSkxi0aehlxSgGnP2S0ToRzqDud2Hf0V0qC0ukn3eLZXv8uyo7SZ20nZ9bgKBAKnWZ3neAmMwvUUceGCtV1UQbZb5o6zdjUG4ct0iEE1shwatYPRyiteOXuAWNbcSU239LWM3GE+Q/60bC2pQymAoc2NKffGBemDsdtyoN4zEYEdKaaaXzOeK9xnUZw4YoCKzK7NZC9KKJ0qC6TD4Tcsz1MM5ffXcd3R3ILb6cqLuyrgmVV6XgCiBmw60syquiKxO4t/oMBCn8/slsoLNoQhpJ8vJJxZk5eJ7iLQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(13003099007)(3023799007)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Kxy6eSBdTz3KZyc2tDf0WJwIwzV8s+gJ3aKl+rbxbCiUoTBAhEtNjbZRY2Vz119eoBhKEhQLlg6tuVBJExxalrvN63BItlW7IGpU/bNbbWWJw6p5/Uc70KsNvOxCeC3gYaDl0xyI+jcRnpjlDtGP5I+str3rBq6u12yju3h421KNtBkgsd6EiTWuw2ivDthk8gcPC27iSXQxSXkCC0UhVSuVEpWJHY6AaITkrARem42Qhs7Lsdq91T1rnqax3PSt+woAf3ezQ9Vq/A749l+bwpqGN7ych3s9IaXvKiIIlk9JromVZzCvF4y9eDP6auNDnXjpbFJ/bKA/Gpj1D8B3PeJETGLjl87X2WxUMNOh1xI9pDRqYja20qKNKIbMkxH/vri2EY6Wrr4WKAcSBC6KdW9uvjH53ojYJMtXV//BbsYqbz8yh8FFnsikKhNrJL3
X-Exchange-RoutingPolicyChecked:
	Ecxc7ZT8hOn6waVhWuI3OYdBdhMwwHcmTwLTinuzdoutOkA/czSYAE7x+pb0aT4m/k0kPqllWfxe34N7kyF49ImP5X2H9tAgpQlAnSubKsAJoXEixNPfah518OpBwI+eRtiMhMBQEInLP421/UZcO2dRyPMWbUQ15YhxaaxuOycZyDH3TwB09Hp568Xya0JuixF1CtWEoCwgHDWVplDRRU85P2cSiEmsOxW67gF93pGWtoxeqq+64CQnmc7QF88caiEk8Zx2VzpL4nk8p0ydQIZsml9iUQXKU/1nShAdDhY5ZcAgpFqfSwvkaICLuZzWTJM5evQnMzRBG3a/RZED2A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 22:54:03.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b61f667-6903-4577-0146-08defcb26f5a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6461
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE3NCBTYWx0ZWRfX/K7bJneFgerD
 b92sx8/nvFBTqSOKX0AfdDvvzWA5I5BALxEFU/tB0dvFVMPmq3ldCMO7R0HsQb5hq5scXJ+3vVn
 BdwBkkr3GcF4wMGCcgE7p5tYGeHNVicYOYOshG1Bu7vaHUd7mO9NM/M7yZn3yGPd5fv7qW8o1gL
 GPPFuL+aTJCkzgWHDPdcv1HPFTE2nJWi69T8UOAaGrhU4MuloFoxRFDKoRRjkyKvJfLBagJouS8
 M/6sLGHvvKdgmXd03lA5I+QlOCC/b5EN22t2YroXkrCRti0ppXdNqg7rlZnd3fLA/wco8jEAbnd
 ugxCCDUwLZ5ZKpRrlGUDTTZbpab301TkMIPqUUnUrin/OPnF14Pza2cEo1vgpKSNclZhhEQb2km
 lzpkfpJyU3RaLu0z20KXBDA0eN5a4CqmdxM9hVJYoFX0qaoRPuwcjc67FkAGmu/vbY7Ql+HvHRs
 VwsV0/RiMBv9R5S8pvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE3NCBTYWx0ZWRfX7tiGJYPFxfBS
 ifGr1KaaFJjWRJWOV9qPykdsAtvZRwd6TxP0HFUBYm5kpHSSvU/3EDucJmYQcAm3zU8Lx+hbh9t
 d+ss0FgiJDlEPX60ejBPwDri109/UcU=
X-Proofpoint-ORIG-GUID: gNWg3Pq9b8UgxUCGSAGMrx8bvUv5UytS
X-Authority-Analysis: v=2.4 cv=Q/fiJY2a c=1 sm=1 tr=0 ts=6a839115 cx=c_pps
 a=3tfckwpITFtzIurveUQz+Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=m8ToADvmAAAA:8 a=VwQbUJbxAAAA:8 a=Om0eTydDL3Fyhap43XoA:9 a=QEXdDO2ut3YA:10
 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-GUID: gNWg3Pq9b8UgxUCGSAGMrx8bvUv5UytS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170174

Hi Francesco,

On 8/14/2026 2:15 AM, Francesco Dolcini wrote:
> On Thu, Aug 13, 2026 at 02:57:52PM -0500, Mendez, Judith wrote:
>> Hi Francesco,
>>
>> On 8/13/2026 6:12 AM, Francesco Dolcini wrote:
>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> MMC clock pins must be configured as OUTPUT-only per TRM [0] with
>>> receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
>>> PIN_INPUT to PIN_OUTPUT to match documentation.
>>>
>>> Link: https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals [0]
>>> Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>
>> Assuming defaults are set.
> 
> We have
> 
>    AM62X_IOPAD(0x11c, PIN_INPUT, 0) /* (#N/A) MMC2_CLKB */
> 
> is this what you are referring to here and in the other discussion
> thread?
Yes, without this defined, MMC2 would not work normally. You have it
defined so you should not have any problems.

~ Judith
