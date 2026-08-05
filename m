Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465ED3D9DAA;
	Wed,  5 Aug 2026 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971633; cv=fail; b=p3dJguP52N2QADyp2tLhRr4ZQ3WsIjJIFh66MFjHkaJ1Va3L5PIicjS97qwqo/UxWRJ1bQnV4a6DtqwboM78X/SiG/KTpWNEp5fcwCKQQHT39gHiMF9MSduT77uDSSfh6hKHi1KpusGzoTH+18jtIwz9zB8h75XN5QJaEWeV8ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971633; c=relaxed/simple;
	bh=mDOmgELbhx25CLwIZFHivPE8lbf95G7TGclN84zFvKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PJGPry5VMHIawRhvwUS9MUIhHX+Dgt5PElPvddlruAVtOpsbCy+79o3/wUjBe+SSDVaUsin0N5Bn+tPX9815XhCVjjMdMVeIV1TTtYXatS01FrZPj/mvhgnN2Hz+vQCbS8mdiClwvcWFr2jbQ6PrR//QFbveKD3zML/vQCCancU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=bxlP8wfs; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g2HYpjsn; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="bxlP8wfs";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g2HYpjsn"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HVmdd2147818;
	Wed, 5 Aug 2026 18:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=tdFCTV828Q8G7oYS6WtTy8YJwphr4Ih/hq2Q+ITox
	Vw=; b=bxlP8wfseLrD9/K3Ikw58w00IFLFUkCqHuMgQvXKYhf4YB1kRJcdzqXgh
	HWB7hx2YJQr0f5iVLIXOD1toDjqhUO/zmV7piMBNjhnaEWFllQWx/ImdmfUsC78x
	l1ccpN29G976Hllus8JORwvB5cYWOTqAIEhRWB3xynAduhF1LOp96biDUScB+fuu
	vya4pQNvvsi6zHeA80LwJB/pHM/582OHY0//+SU64iz+fEJrv15jJ0oZQg0TkcZE
	xFI/3LzXjxNfWUBbA5890rHsIzu8mig2lnQ63lySuPlqkTnnctSmTt6ecbdxQ97y
	a3LEqed30e+mL3icE2RmdQX1nD+pw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fv43f4ykx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 18:13:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmaeL78ZF6wr3peRb7DKcLN5IcU4Y0F2scmRFjPvPpL77pICXlKrFLDe4vuQ4XEBpbU5Y3X8HczUE/obsybxWxByFS0tK7BK6sirUhecOpnRFm39DY1oeSEF479SVQXVun3WcNix/wyCOU/ttDDgjiUW4H/KMJKBUsrhj8ZSS23+pTGXNm3IMHzBt7z6jnko4LRLf7lllIapSU3eoFDixgG2o8H0DG/pLDVDeMFgiPRZ6ezIr5mFPPMH6u7F9hA1zVqXzbZOl6eDX3dCJnv5QYXgQmfG208qlav6rhRPKRSpFWdvtrLS837YQ+Qfw+Iw2Q7NH4/eXWP0cXWATsb2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdFCTV828Q8G7oYS6WtTy8YJwphr4Ih/hq2Q+IToxVw=;
 b=I0psIVlERievTzDM/pvWqeMOKTMTZ8NsK2uUq60QzHtvANTr65UY4CsnN1VczB9JXZqMsgBeG+D211NZCV7su1M9Z+tQsXOKuKNKuQrOESYmZumTapfreLYMiwrqz3vsJ0AWtHSaQn+/UANbdotOYpm3BRWbZvT3a4e7o+5k1HImEvrmmldwSBuZrfr08RYcKw3K4NslfGlSsFx8rStREKvLCyl3FrZfDlvdfRYFSBi/1zIYeDNwml55HSNMzh3zUEfMy5p0zhZZU68IJWyHskvU3ZL7HNFsuh5vbken1PhCTUB5fvToSVmfX4zRRZ66MFw5dY9yojK3P5kExTTZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdFCTV828Q8G7oYS6WtTy8YJwphr4Ih/hq2Q+IToxVw=;
 b=g2HYpjsnWiBPqzZLog/hrFX14+dHYAE/glJfBXLJZc4vfEL4vrk8mL1uDQ9rEY7qodRiTjqKzfWguJ/0czG2xoN9dsKX63eQtzywFAXR7GSXqzpNwxRkTqSX5pS2xYEtg9QmaK3HeztHYIM7rFrXxJlByJX8g8KweBLFEnhiYLI=
Received: from BN9PR03CA0861.namprd03.prod.outlook.com (2603:10b6:408:13d::26)
 by SJ5PPFB6A054FAC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 23:13:37 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::a8) by BN9PR03CA0861.outlook.office365.com
 (2603:10b6:408:13d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 23:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 5 Aug 2026 23:13:36 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 18:13:16 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 18:13:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 5 Aug 2026 18:13:16 -0500
Received: from [10.249.34.24] ([10.249.34.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 675NDFOS2240584;
	Wed, 5 Aug 2026 18:13:15 -0500
Message-ID: <9cdf448b-436c-404f-bf72-b946204629a8@ti.com>
Date: Wed, 5 Aug 2026 18:13:15 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
To: Diogo Ivo <diogo.ivo@bootlin.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Faiz Abbas
	<faiz_abbas@ti.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Pascal
 EBERHARD" <pascal.eberhard@se.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, <stable@vger.kernel.org>
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
 <20260803-am654-sdhci-v2-4-a5ee5be86133@bootlin.com>
 <4721675e-e3ae-4e81-89db-eb0f7f419d1e@ti.com>
 <6fc6216a-5e57-4df5-9033-d3573409ed78@bootlin.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <6fc6216a-5e57-4df5-9033-d3573409ed78@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SJ5PPFB6A054FAC:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a7fa63-86f2-45db-e610-08def3472d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	NfF2sckUwlYk6ShW0wcPfPIYmRdGWdGAwZMe6vgEkiz0w+Yw0s9MLyLkkCutRsk6DGnAksQ8TVJG6tGxSMCTSsTqN4nKDEKdaxpg45fWBhVPtE+xBu2CKHtdWYctjXvfwuIoCOtRdjAetjjPFjVJN2Ip2r9uOt4ahQqq94fVM4Qsz8vnS05Rpp5MzQOJT5dARbRbCeeZV3PUSn9ztdoRsesrBkl7sCUszNZrrKCkrfJHlfmP1J9bHB6vlVGduqNfKXEkKI45bTVIRGsz8EfXKCUo6PwARBL6UsJLj/fBYW7Gvqum65RFJqBdscjPMsBRx9BbWmvaOZwbbTXTOnWtT9/1Z9OTjD596fp9FNrCUY/gS31cm3FRGIyhHzM7ouwmBbHkoeVVb3AKFAToHtZnijTmy4+DFkR2hXnwJ/4VFyRtCNyDB0XOdMz429HuUBgqvVOQeP2U57gJZU2i8XQw/X0OUJGv7DikSzyjMtlnRkGWrXr1TElQCL1QwTxGIXGHa4bi1dkCA+Fg/Rf8Z355djDfZjyUU7Uy4Ar6hsmOaXUxyMIhTJKXwZl83sq4HWRCVZiQEVzl+bUj3j0ZtWT1uxHno9PnZk+3QvlZH9+2RC4WA+LAZy2bLTgZIytL15gh0gtj5Ndje5EArQSmV+ljkua4dHiGqqtzdYj54il/JSOOxA7Rlveno1whc2rxokTtDyGOY9AtHYKRBY0SlxcKXw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ch5CaZV3N9fwGWyq1hGLjHTBD3ym8BNjrilwiVp4zRWvFhd759Rq1gUG2fRo9lfsGZRlJvKtpaDk5mQvLjx9GRUU/IqP/DGu+AlIY+FmarNyxIs0ONXAx2s77/qiWAxrhac1vO13fvJy/s0xojFer1a5ry2/MZJrOJh/6olvZeHL6+aRwpGcYkIRkYOFQvl4SgvSPpgyWSsgx0vSAxg3zv9Ic+olIK7HVvMWamNegC3XNTRrSGj3L3bi+gJeuZZ9n7BrQETZF/iHmBYBbEVezL1cU0f90ynCIWLAXWFQALgzkKq9NV5ReKeZc0qcIXideY+r79tPtKWc29wFFQCTmdaC8HzfYHGW6eooZlhO/i3jt7PMoVXiOz4Hnee/G8GWJQqamZ+s0GeP9hMRCCSP4ELdp1gIg8EdivZXRMAqOeopeOR7kQ36pvK+X1F+0CYE
X-Exchange-RoutingPolicyChecked:
	s6Gcf0hHmABSU/2UZFs05D3F0w+6aJuEipVn24gs1sk+XKH/CXMXjc7/Um1tKCACkkfuNRNSVZ9WxbXdKvoA2dctsjr4YcV5SO8HdPEzy8MllT4gA7sKF2S7tiy6SiY/5R3tmJ6ZEEKzFniWsLoTG+V0SswiFDLAVLQbz39ji7/GBhQNwcnj/XOjwJJib7tzVm294Vnjd1IqOfZXPe9r9frg1ro9g6llChkLg+cA1WX2fDlGP+kcZvAn4O/7b2R+dgzYffl8bsIwHzXubgS4hlQYnHIbDRVYN5/h7/4NjNU4dejp+EJBcMewcqIHxdhdrxMGr78+1KQvboVqYuhWMA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 23:13:36.2033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a7fa63-86f2-45db-e610-08def3472d67
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB6A054FAC
X-Proofpoint-ORIG-GUID: FSm53_jKEXLY3dpL_emDADljvkh1ECig
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4OSBTYWx0ZWRfX68aKO/Sr/iiv
 VOx3Q1KsYB5q8a0V+AXO87CSi/mEoSj/O9an27CPmDPip3udSft73+1IsESBXMj6N6xryHDaz+s
 RN84AbVB2uta8sKYaDJo0qxXdTiv1kA=
X-Authority-Analysis: v=2.4 cv=Ircutr/g c=1 sm=1 tr=0 ts=6a73c3a5 cx=c_pps
 a=2EcEh/UKxA6NVIT+L3iE4w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=28HDlpIQsvZwnQB444kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4OSBTYWx0ZWRfX5/kneuqOr68K
 yHAijdV+gAcaCG99l2T+5tkgXi72t6VOlzrs/Z8Gx7Z4cOJiPchqki0uVtQ6uf5tXcUtWY0LAnv
 Qnz8xbOfC4tfM7yRyA47XirceI+tQFwH6QNWddBQF0vIYCI+OFZEqh1yKBgQGwEZ3gHnVkgHwTD
 c2QHrdeXuCQ1aVRidHwhSzoFVG88PXd/UR4gmS3feTzK3XfNMSmwGh0KExrsARgusBhBSXPsGnO
 Ecn2LajuzXE+6hh006TjsVzqCZE15nSILSvlKPufa89ZqjY1FeSq96TcDtj7qC92Ojo0WW4ZI5X
 g3YyiQMNMtxCQNI2RGqEnNQz38q5nyhdkJNNIImm7T9xRjsLZcjzbPCk33nVkthHf03pW/jPY2h
 Dx/HbRzPnIgwiohdBv8BowxpFF6UlBoxSRqnfq2lRdCvmchoHUysmKVr+iV8rQnAbfW9BU7GAQN
 eBohAI/HSkxRcTsqrCQ==
X-Proofpoint-GUID: FSm53_jKEXLY3dpL_emDADljvkh1ECig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050189

Hi Diogo,

On 8/4/2026 3:45 AM, Diogo Ivo wrote:
> Hi Judith,
> 
> Thanks for the review!
> 
> On 8/3/26 9:59 PM, Mendez, Judith wrote:
>> Hi Diogo,
>>
>> Thanks for your patch, couple of doubts below.
>>
>> On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
>>> DDR50 mode is not required to support the tuning command CMD19, meaning
>>> that calibration may fail on cards that do not implement it, in which
>>> case a known-good itap delay value should be programmed into the host
>>> controller.
>>>
>>> Do this by reading the (already defined) itap delay DT property for 
>>> DDR50
>>> and, if tuning fails for this mode, fall back to the DT-provided itap 
>>> delay
>>> value. If the DT does not provide a value for DDR50 fallback then this
>>> simply disables using itapdly.
>>>
>>> Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
>>
>> Should this commit be the one to blame or should it be the commit that
>> introduces DDR50 support?
> 
> I'm not sure I follow you here, as I wasn't able to pinpoint a commit
> that specifically introduced support for DDR50. Could you please clarify?
> 
> Taking a look at the git log of the driver I see a0a62497f6aa, where
> reading itapdly from DT was added but without reading the DDR50 value
> and 13ebeae68ac9, the commit where tuning was originally added, but the
> "responsibility" seems split between the two.

Yea I think because each of the three commits in question are adding
support for something else. This bug fix that you are sending was never
really discovered or debugged before. IMO (: Not sure if this requires
a fixes tag then.

I will let Adrian or someone else decide what to do here. ^.^

~ Judith

> 
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
>>> ---
>>> Changes in v2:
>>>   - As suggested by Sashiko save values read from DT for DDR50 in 
>>> separate
>>>     variables in order to keep them across multiple tuning cycles 
>>> without
>>>     overwriting them.
>>> ---
>>>   drivers/mmc/host/sdhci_am654.c | 25 ++++++++++++++++++++-----
>>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/ 
>>> sdhci_am654.c
>>> index 8ce10422bba0..27ef79420eba 100644
>>> --- a/drivers/mmc/host/sdhci_am654.c
>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>> @@ -126,7 +126,7 @@ static const struct timing_data td[] = {
>>>                      NULL,
>>>                      MMC_CAP_UHS_SDR104},
>>>       [MMC_TIMING_UHS_DDR50]    = {"ti,otap-del-sel-ddr50",
>>> -                   NULL,
>>> +                   "ti,itap-del-sel-ddr50",
>>>                      MMC_CAP_UHS_DDR50},
>>>       [MMC_TIMING_MMC_DDR52]    = {"ti,otap-del-sel-ddr52",
>>>                      "ti,itap-del-sel-ddr52",
>>> @@ -144,6 +144,8 @@ struct sdhci_am654_data {
>>>       u32 otap_del_sel[ARRAY_SIZE(td)];
>>>       u32 itap_del_sel[ARRAY_SIZE(td)];
>>>       u32 itap_del_ena[ARRAY_SIZE(td)];
>>> +    u32 itap_del_sel_dt_ddr50;
>>> +    u32 itap_del_ena_dt_ddr50;
>>>       int clkbuf_sel;
>>>       int trm_icp;
>>>       int drv_strength;
>>> @@ -579,10 +581,18 @@ static int 
>>> sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>>       } while (++tuning_loop < RETRY_TUNING_MAX);
>>>       if (itapdly < 0) {
>>> -        dev_err(dev, "Failed to find itapdly, fail tuning\n");
>>> -        sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
>>> -        sdhci_am654->itap_del_ena[timing] = 0;
>>> -        sdhci_am654->itap_del_sel[timing] = 0;
>>> +        if (timing == MMC_TIMING_UHS_DDR50) {
>>
>> Should dev_dbg be added here to let the user know that tuning failed but
>> DT defaults were set?
> 
> That sounds useful, I'll add a print here.
> 
>> ~ Judith
>>
> 
> Best regards,
> Diogo

