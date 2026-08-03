Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF03A7F48;
	Mon,  3 Aug 2026 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787200; cv=fail; b=gy5JgMbUErhfpIjWhcNAZ8brIY1nGT6DznKpn24/We493S8OpIKLpSbAYmI/SaizzM1HYD4zgZSmObkxKgvyISGwr3TjXlJQNx3xIYldsYB/y3g4WwN0Lz4jFUJayLObJ4CWK1q9klpQIeHj67QkYIHxTSILgt6txqWoGtA+8/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787200; c=relaxed/simple;
	bh=OZNfmnXKDu52NJjVHN43HCWV0wWge/I20P0+yRA+eYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=spguGbhq5ousVIj8mp3B2jKwrRZWBLxR8gUxDcMTNKttJXI4Rpv8K/kmQfot2cBKMQpd7dVbYNozRcxdQCli1sU8M7orb45EcKhJ87SRAC5os+MmArBU2zkG+Lh4XpLs0yyrzl6OIEnCodmb8NxTksAoTFAKfHu3V1FVf1Z4Q7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=I0v9mWDt; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kQFeWZpx; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="I0v9mWDt";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kQFeWZpx"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673JjB7a438754;
	Mon, 3 Aug 2026 14:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ZVAf/cKMfJeIQFKCBTyLzc8eMYViFRtQUeOZOI6D/
	pQ=; b=I0v9mWDt/xD2vTvNcZkaz5/sFoywfXhRm2DvQ9O1xvvLeSVQtEzDblt4/
	UXgK5lyMGc2Uz7VAozRylA606LdGkFWLDTHcE+aH5C6w2XjWRiyhthToWm7kVA2K
	4Kp3hNlbDkUsOYI9PY1nNoHjw3VHm0P9NXoXIJBsTakAvwq6CnVEn0A8A4JVyZXR
	B523mZLqAEBZeAKc+rTX/G7xOIHwe4nCSjowEM6zLYUOb8GrCwk/O/nBsi533rqy
	B/wvoua187UHMP6gGASUk4V4xbPH2Op3ctFSL4v/39ifJE9Df+iJpq3uMfOz6eIX
	U+zUgrY9qyLGZA/oofdHRY48W5scQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0rbpfc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:59:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGxvSKnG34WFj9QrfQ4nBT+E1722i2PW6ik0eNZi+7BWb6YhOkII+y5dO+rthflgmKw3Lz057SmP1GG2XNiXTUVYZMYV7DYvQzQ5cIiheqE91X+0+HU8GGYffR+VoZFL6b7gRebwTPem76olrPHC9TA+WE277csRHou03O/llOdcGYT7RSbAoaw5o6Zawq0ByL2xAybBKjNMr7M0Il3FLuOc9dTNTJD1hk/l/hQPK3NnK6Jejeej3lrlHBfQa9FcLnwn/blcss5PiCVvw8rC6GY3sI9gU7l2gQUP2WSuSUIBsG3r+Eg87rjzDzAw8/D9E5xmOlX+w7jIocKNIyk4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVAf/cKMfJeIQFKCBTyLzc8eMYViFRtQUeOZOI6D/pQ=;
 b=aCeGmLxEFAT8B2m6Lsand6rqE9UeR9ditVU+tN9F4y2gKijgCxqgaaJiQg+D2FXf1VOux0IeECpCBIfg6MPQpnHkMAQbAHLkEgO3bBT1SEYtSGbQAPPXhT0i+FTueLt6XTl+7x8Ka+r/xbMdTbQAg+Qef2z4M35l1+fc086ErWaEc38ymxnsGVlswfnolCl9gTJGejx656u6nBNdPxH7wjGv7z8bWt59mPAyRDcf46nB/Yj9J6FOUulbbc1t6EAs8htgWCaixTB5y83Aa9FpMb9iiNsxq/Rcdq/8i69jLgOrNe2bDjCjdDM0n+QtJztz99Jit+LU/AiEaldKcWnCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVAf/cKMfJeIQFKCBTyLzc8eMYViFRtQUeOZOI6D/pQ=;
 b=kQFeWZpx5NIlpVq3UarGt6J4jRilLv5VDIdV1BnsaTbgWAFyS9tf6u87fFO1pEPvjlWoNoE2mZtuEPdx5df8dz7oXh6UUgICtv3ZPw5gQ5NgAOepaAq8wDpVLZIICO0yzkuiYdNst8YMbKH4W+Z+rf0aqUHAIVKNDJ7xk7ZNBmk=
Received: from SA9PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:21::11)
 by CH3PR10MB6809.namprd10.prod.outlook.com (2603:10b6:610:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 19:59:42 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::99) by SA9PR13CA0006.outlook.office365.com
 (2603:10b6:806:21::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Mon, 3
 Aug 2026 19:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 19:59:42 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:59:41 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:59:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 14:59:41 -0500
Received: from [10.249.34.24] ([10.249.34.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 673Jxfxc2367144;
	Mon, 3 Aug 2026 14:59:41 -0500
Message-ID: <4721675e-e3ae-4e81-89db-eb0f7f419d1e@ti.com>
Date: Mon, 3 Aug 2026 14:59:41 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>,
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
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260803-am654-sdhci-v2-4-a5ee5be86133@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CH3PR10MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b49bb7-b10b-4abe-22a8-08def199c203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nhWM2nacon81ozo1x0rNrAT92DOzzpxEXskXSva85BvarQFWhn4UD0W/vqxNYf0ovdBfpap0XJYyh5dqpgXFgpRkdgv4N3vLkcYwYDYskHYq/3efTmeQQwT4+eF13LLFhz5+Ub7EspQCqCNqsMjDKM+HhGqA1ufBAbZ/064k6rtYs0px3uT9Nv3KSSpoQMvvJonW1GkT0nNMkKXp8WkwMpfcuLNr9yZ28ZyfpbBIngG0urRw7rG7x62yfQv/oecaqrVW2QdSViaMKt+DWQBOS/IR0gbGaqMWNbhew3pqEL4gwtI2HDqmJdOGULP9fnq3LX7Ehp3ZjfaJyorselsnPkGNdeEm7f+fAAX0cR/Erce4Uh5wZtFcUfTtlv8/2LRkrzWap9PNToHMr+sHObcXCM9PcCHFkSt08KeJHN3bU5YHk3w+9lW27DzIlv1d9YGdjvzfh6TatN2H+rF/sANwXh1iPuYYHQ95fViKQf9hIXmV+Gu/cK8UXXMhbllEPgrisKA8+8cyjMtbEKyov4xIWK7d2kwewuHhHD8iQFu1bxC+vUacJ5SulSGTYKkxCH6LxqPXNC8CpaJxCHUE0YimZIIY0OW1De7FeyQO7rQiC3at56RN8tfexFmtt27cXY6yK8KSIiBYbnqd9q6BhX4QWaUrPAC0fKQjBm7o/tAusQMf8UJNH74q8+Rhw01Iy8ZU20s2s0PXWm5THB/BnyksDQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mwmX5i8qi2ywDe5/uEgzpz32T8SFJYs6UWoq7SYSQeju1eG6sDKH0XzE7y8rvsRnskHYhcTEV0OFtlTFZTPmu3oEDGKmJRspsrx/rmLkaT+OQxhn6jjOcemIFrXjmU2JDyJqmSstgnnLqUB9Pk+OQXvvd2Yh5jMPat4KIWj1H7UvHHiDYOGUHNI22+uqVbC2JxncoY1+CeR4DurEXANRt3qp8IMqaXsdMutsJChuzumFpkqh4/5/AGJ/ON9QkB8QL84Wopgrl1XufrC0TRVBUL3qeKxb2BcaEiEWz7y6WuznCrSML+AWEBySXravmJ8cUiqaQ+ZspRLXN4wYJuE7kcVF178YRs/K/4898Xi+dZsFJZUwmVU6ySk2JSukPiPlrA7FgO44ypoMZoJxaMt9F0eTJV+U3M0mMDGFKBIb/gwB9GC3k9GL3MkFMe8hnKRZ
X-Exchange-RoutingPolicyChecked:
	ZalYZQVs9fewN3al6PVD97IzsKdPBdiRFmRADOZknrPEe1rg05PS57MuyAYfaGQ5RpA3Uy6CElw4x9Y3Xsfqz6gTzKMIHp4tp5CbmdO9cALilUP7ICMEuOPypCSS9eseLV8uTu9pXpA7o2e6TVZqJK5kJKHbnpfHuLC32u7sf+s7XPmcXBn5O4OYe33/Tr6Fgq/bn9R44Za5rgkj/k8TT+b6bt663wg/PpT7TbCpDHbzO2u+pwfKfo8Vhgi0PCYxmQu7aBiyDOSBhTnqn4DLVx7bWB+yOIy+FGG1Zt/oPvEQUgeOgtKhI7ZPbhvcqzZCBp2NUVpspeRlKftGHc444A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 19:59:42.0089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b49bb7-b10b-4abe-22a8-08def199c203
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6809
X-Proofpoint-GUID: z_QdWOYouChC-AGB5Lz-LoUvmsn6Z8tY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3NiBTYWx0ZWRfX3bqJDarxiGSp
 g8drWr4b+UBkjsgEXJJI/ec/TSTgw1aVs5aXCM0hH7fRbCajjpfJ0teqdpgEmL1XlrmLRhuXC9f
 tmz4iA7/2pq8ZJZZOTu9Y0sbwkHPLUD96WcVe3kmQBArlqRojfkt4kA89qHFnIL2V7L7CDKZkcd
 aY44x1j/zDXtt1/DKNV5jgh2ePEymghx9iakDisURa3RAMnOG8H7K8VNiDHJFBDoq+1FPxdk/jO
 p37WTF++N0pA4TDUhgtr9wwXUOWt6On2eZZEaqmCdY9JYTA/4FIC6iz2IYX6o0EVzUikmvnqQ6H
 loH0Nc8GZ6/dzQsRUJcg7NCYcy+SHB+5vO1NJTGG7QtiuLrGPIWe5PGhoxNVv1I0iTngiyWJwc0
 VmszGB4wVj9ojmkHgAKdxZdsKSyRV+ZcbBAnaVqrycvzIpgdvDq3EfOi+apU52pOKwJD95Qe1Bi
 oQ61LuYOKFpojx4s45g==
X-Proofpoint-ORIG-GUID: z_QdWOYouChC-AGB5Lz-LoUvmsn6Z8tY
X-Authority-Analysis: v=2.4 cv=eOUjSnp1 c=1 sm=1 tr=0 ts=6a70f335 cx=c_pps
 a=fjiyZBo1bxGOeg3e+tCWfg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=eRPA6o5xhzaxNKAK0UMA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3NiBTYWx0ZWRfX4WJCWuUQmZ6J
 KNztyB/PED4K8AwkAOOUpgfMsjeg3Aq16+pRisqZDMhPUIM+p9vvQSQIoAJLaLilr83+OS/apk7
 Y+5SjnBwC2+gJJir/PTXJmPMR5ryZ5M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030176

Hi Diogo,

Thanks for your patch, couple of doubts below.

On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
> DDR50 mode is not required to support the tuning command CMD19, meaning
> that calibration may fail on cards that do not implement it, in which
> case a known-good itap delay value should be programmed into the host
> controller.
> 
> Do this by reading the (already defined) itap delay DT property for DDR50
> and, if tuning fails for this mode, fall back to the DT-provided itap delay
> value. If the DT does not provide a value for DDR50 fallback then this
> simply disables using itapdly.
> 
> Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")

Should this commit be the one to blame or should it be the commit that
introduces DDR50 support?

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
> ---
> Changes in v2:
>   - As suggested by Sashiko save values read from DT for DDR50 in separate
>     variables in order to keep them across multiple tuning cycles without
>     overwriting them.
> ---
>   drivers/mmc/host/sdhci_am654.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8ce10422bba0..27ef79420eba 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -126,7 +126,7 @@ static const struct timing_data td[] = {
>   				   NULL,
>   				   MMC_CAP_UHS_SDR104},
>   	[MMC_TIMING_UHS_DDR50]	= {"ti,otap-del-sel-ddr50",
> -				   NULL,
> +				   "ti,itap-del-sel-ddr50",
>   				   MMC_CAP_UHS_DDR50},
>   	[MMC_TIMING_MMC_DDR52]	= {"ti,otap-del-sel-ddr52",
>   				   "ti,itap-del-sel-ddr52",
> @@ -144,6 +144,8 @@ struct sdhci_am654_data {
>   	u32 otap_del_sel[ARRAY_SIZE(td)];
>   	u32 itap_del_sel[ARRAY_SIZE(td)];
>   	u32 itap_del_ena[ARRAY_SIZE(td)];
> +	u32 itap_del_sel_dt_ddr50;
> +	u32 itap_del_ena_dt_ddr50;
>   	int clkbuf_sel;
>   	int trm_icp;
>   	int drv_strength;
> @@ -579,10 +581,18 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>   	} while (++tuning_loop < RETRY_TUNING_MAX);
>   
>   	if (itapdly < 0) {
> -		dev_err(dev, "Failed to find itapdly, fail tuning\n");
> -		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
> -		sdhci_am654->itap_del_ena[timing] = 0;
> -		sdhci_am654->itap_del_sel[timing] = 0;
> +		if (timing == MMC_TIMING_UHS_DDR50) {

Should dev_dbg be added here to let the user know that tuning failed but
DT defaults were set?

~ Judith

> +			sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel_dt_ddr50;
> +			sdhci_am654->itap_del_ena[timing] = sdhci_am654->itap_del_ena_dt_ddr50;
> +		} else {
> +			dev_err(dev, "Failed to find itapdly, fail tuning\n");
> +			sdhci_am654->itap_del_ena[timing] = 0;
> +			sdhci_am654->itap_del_sel[timing] = 0;
> +		}
> +
> +		sdhci_am654_write_itapdly(sdhci_am654,
> +					  sdhci_am654->itap_del_sel[timing],
> +					  sdhci_am654->itap_del_ena[timing]);
>   		return -1;
>   	}
>   
> @@ -758,6 +768,11 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>   		}
>   	}
>   
> +	sdhci_am654->itap_del_sel_dt_ddr50 =
> +		sdhci_am654->itap_del_sel[MMC_TIMING_UHS_DDR50];
> +	sdhci_am654->itap_del_ena_dt_ddr50 =
> +		sdhci_am654->itap_del_ena[MMC_TIMING_UHS_DDR50];
> +
>   	return 0;
>   }
>   
> 

