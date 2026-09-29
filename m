Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7CE41F359;
	Tue, 29 Sep 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697405; cv=fail; b=WtKW3zWffQdNmcn66uk+pPKS/Q/B9qKRXq6gLhaM6D7PcSeBvSj18iZDNykNYq69PWFCmENT8tkmOO6a326e/QPI6SqZYqqRxxR2r3WT90ZWPsXpSa4WuG9BhqPYzSNREFlXXi78Bj054cZf4HIaApLYyfvNC/xfvsIBhakb5k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697405; c=relaxed/simple;
	bh=azOf2D0+1E8FYMIXbzd+vVtdtBPpmVF+VKoIiExmZkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GM9u8v+8pAc9LdPcql1UY1Jea08kwFC330ax3P2Zwz1VC/JSjzTppqNtfx9QOjbTD/7vIBZbQv5N7tmSlqd8rd7dN73CkVK7JDGzOkP+k/iCDUd5nXPVegXI2o9Yc0eA9MwNCuKg9Zifx0TzGHCn0lQH+JouZnOfCslQhtaFJr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=lWFu2H90; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=mxPCWjZv; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="lWFu2H90";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="mxPCWjZv"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TFfoQm4076839;
	Tue, 29 Sep 2026 10:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ubGDs3PbtR65nrXQehf629qSftFGohLLLoRmcemod
	qE=; b=lWFu2H90SbgmVri6691WXu39tUvxMDe17W4uuyB9CCwvRBCMGipctdEON
	7woLAUiq6qo1nwF+lbB1l6qR3EM+oR0swoqhvsRIhY9PVkr6UpS8Zi0YbpCLoKCc
	wYnJ0srT+Jv1iOy83VIGP0d0EE1oyCmDIcrRGyPiHwH3oFrEnBlNmHmAk+PkUuM6
	kZJqSHhYZu16UIvhTv5EfYfqfjVjpXK46nDDbkwWF0pGLQCtxwlG2RdHvWbdc0jT
	BrIQNW8cYQUmALgKU7Xo32j7tlvJsnQp8wfFJlHGAclrh0NAg5EHRLUVCW3WgcNN
	9DSzZUZtgZLXeNOkbJ9gccYFWHk4w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h03adcw6q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 10:56:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAKitwH+qT/hQiZdssTbp/kGhJRYx2srkz+2kIZtnmjpRYDZDf3T8KayVxr7yvqPe2KXSzwpr6S3KoR7hKmbNd7B6MSMFL7ww8EH4O+YpGVO+rSZKHlQ/iquxuEbMh9lHsIaCbs1Vx13HgENdahtxQlXq4pcl56zhsBhM+uVEUdxZmZYadNw4hV8p1tCnAfIFLRNzjaw3C5hmCairai5wtQ9hVG58t6UtGmv9+Ec5G8ecVuwMBxRhmNPLKkS0lua5OYIiZu/OoJt5BcTkof30w1su33hMH34MSoZPqc4to2Hxl6trSOXgdlBQ2x3YANhppRMN1ub2QbJsHtc8e8i+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubGDs3PbtR65nrXQehf629qSftFGohLLLoRmcemodqE=;
 b=BgSKEW5xlhKGiKROn5PxQ1L63rh2N7KU3r2SkFQWcHj9J4gHV6ZQXlJoq2qUFANgcNyT9treOCs/WbvfkwF1rCt4UkEIYLLtf9TTUpCswdKbekfegMT9W/o/NH6ikP54rItxhIk0oe6EJPWpsUCqTJtDDcgeYkf2wKDlwx3MFqeVwkTMBlcyDL8VqDr79YI6O6SU/G0xhO7OMN/16NskHK7J7z74B7WodLKb3YZzvHiEMsKO3GPll67+hurD4CECfaX6vv+flw6dgwlP+RMbzcJwBDolyjYb4nzidh3oe2Gq8PSn1JzADnrlxNGBKCZn79MXgmjgdghCZXPH4HKwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubGDs3PbtR65nrXQehf629qSftFGohLLLoRmcemodqE=;
 b=mxPCWjZvOJxQEundRy6BniN3zxIEf6TVddl83Am2Se11sYih6BJaRtvgNJaI8hGaeFMds4OTDuA1j2SXuSPlOdeJWADiPDPWURwzbaSIAioSsQ303JGt7hBuUPm/RYPxJBzBhBbsYLgUY8YjE+wXqvPVRAJrn3FOL10kowwwlMM=
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 29 Sep
 2026 15:56:28 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::76) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 15:56:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 15:56:27 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 10:55:48 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 10:55:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 10:55:48 -0500
Received: from [10.249.37.61] ([10.249.37.61])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68TFtmMK2223740;
	Tue, 29 Sep 2026 10:55:48 -0500
Message-ID: <9b723a8f-6cd8-4993-9fc7-6cbe7d0545a3@ti.com>
Date: Tue, 29 Sep 2026 10:55:48 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: tca6507: Fix use-after-free on unbind
To: Danish Khateeb <danishkhateeb03@gmail.com>, <lee@kernel.org>,
        <pavel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20260926172115.543800-1-danishkhateeb03@gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260926172115.543800-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c495987-8eae-47f9-9b80-08df1e4238ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|3023799007|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	owrG1kd//SXLdQv5WWo65Jwmg2EkCrlBitweaExhP+x4sR0YSSPrY1W2grCPA5jurv5S+weECEZScxr5U1GIi0LkQVd0stpZYtX9BOL0CmVBxGWc0Kbp4PpCx1kCj/GiFhE1Ai6PGjm8SYj/ZwD3kbWtgmBoxbi5oRbto8Sp9u4psmBWkCYTtTxDQPdhnNFC2Y9KI+0GEMFZgBEQSBKFUiOT3Xi424C/JNzY+TWCRlkPiSGedmQQSuai7aKBecukGsynhaQC6jtm9NJESRfwMTDDC57Aey1WX5Rv/XqC8ilq8k+QeUuHJ0gBgdhvt4C1RqvsaQtOG376F1O9RTqLq0z9+vsKZgkigg/1P6381gcJ6/3Z3KHBGRxWKFp/PnXLRTMkyHk2MzAVoFZdMLkPAVLQeCjW7QsNmP1yEzbAMWD3r5LYoBOZhIAb9ZU6XnUKOBXr6bUCmw6DMGusSdpKdWpshjzPL8FU2kUkmdHFGToHFwFE1anPB0j39N1sNPWCXP5QQBfgKAl1/KYSBN0qHTVU/4x8ui+srYbqZodas0YwtC0S5endCinxB2bovrhRsFORr1/8yu6ljQlWWAuyg6ntqeZzQsnBKdjH3dibcC2Khg2fM1219Qp5ZVukw67PDWiUzIpAC1FqUEKf8jBrCizuA68rCJyEDu60ouTxF6UEzYNxEnyJ8/uvyXoFYRnWRN8AvSWuSDNtkWpmTvGTrA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(3023799007)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wc5l7WUMQ4OUmpJ+ZpTBaC/1vy4qvmn1a3GSIXGcaoyNw1/NSKrBetiRLeCFbQYWjMwvqHXkvBgIyGUfBCi1nsjWWj+gl481rRcJxpXdoPWlDy1dTepmGzUn8fSkw7MrE11HrT5D7hZfkRRMebskg1mzYXowQc68bZKho2QYf/ssIvp8XrjgKLOGfwvuu7DWyBY4IQ2B5O1xeUI1wRmxJ0dHFow0fMtNTg77r72aE34LP6W3S526hqIYBQ09DJXuBZfgvgYj9K2Mnf3ULZOrnvGSauYTDFOmKdjnubyH46sYNtiUJJY7AfXRz1uWWx+8m2lMSSbsSAr+qgwqW72x2GwTU7faPwQyPpY3BEwy5o8RHx60ukWAOXS2Jh7JoyIAgNwfn8kE8RK5VT6btRxFRuWp7MHcQ6PAwnkncJ3WCqxJ85Cd5hETUrFC3c1PHEcV
X-Exchange-RoutingPolicyChecked:
	n/BGx3jSflYmotJ9sP7J90L+R/3gdDXXb5vpGehGcD5aoCYS3G20dm5qpwsAuud6X+/7n0GyHzuFUrw6M8Sb34PIdWaOIvOiENSL7GMZZ2FvUMjvLfgBUIHEY+SUzH5wkeR19F25kdGC+HSLFdN7htnkHQj/Wan21Zv8bka4DuYi537XlOZdTlLLjtDkihKIajUxiGIPZJ7hG9dSywub4AUH6xsWs+viG3mQ+ebryn+0UrwybENajFP2oUDQ9OV3ZTx+wsSgquHeg2MxiwO5nIk+hr0Gdy+Jh8oEIAS0ku9RR62Zt7l5wgDuuotNfAspwBLD2YVrSYirLTR+X0F1gw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 15:56:27.6331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c495987-8eae-47f9-9b80-08df1e4238ae
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Authority-Analysis: v=2.4 cv=c94+0h9l c=1 sm=1 tr=0 ts=6abbdfb1 cx=c_pps
 a=jJxBgQE0Gv9vBhouG1T1Tg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=pNW3mJ0fZ0nBVP3wtR4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sC0vYehClxP3-aPotxKqocZkajRic6lQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MyBTYWx0ZWRfX9Cvb7EO3ERzo
 meQGfPiuMsmfSJYRVeURN0JUGXKs3xY3N4fuAh/r0RXXTEMbkywY4SqpZzMMQTwtD5zxZwPJ34J
 6cnfWUO9+AZXm+1YkblzEmwPCsArnuPQ521bK6Bys9Ll2NJzP2ErChk4KGs8w1F2iiTuM6bx6E4
 fwoNModOPdw162ie7b2NTQJ16LxqOKaCzvVdxL0qTdCaYcnUbmJ3iI4GT6NzCELyE+/q6/LmEFc
 7cQ3UH/ifH1sUPiUNRYtJ/9LVCRcAWUqtQVEOY4/r2d6XSF5shIs00FIJwrMEXwuQzlTpG9/y/E
 uf/UeMAC34/jecmLkk+uwefINDybi63WNO3KziZqxcdcXkIcaPh78gftqsvnXk+SFSb6vdRwTOV
 X7sonnNhaBC7v4yiZ56qX6DMeg0CAKqVQPtD3IQyMl7ZEKmV0Pm9bNMSdb8cUoxLaF61wKUu92d
 oST83APQ+AfWeYT0iaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MyBTYWx0ZWRfXyFhink9l6TJN
 CmjEwVx7nYhwWY1dsiikxbVcKBnOT9nLs5p4JYhsy1f6T6/GZ62DgPysMlv2R4+jLsX4LYjBk0z
 thr1XkUkerPDtr3QxW6d4OTQdEa7CgQ=
X-Proofpoint-GUID: sC0vYehClxP3-aPotxKqocZkajRic6lQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290063

On 9/26/26 12:21 PM, Danish Khateeb wrote:
> Since the LEDs are registered with devm_led_classdev_register(), they
> are unregistered only after tca6507_remove() has cancelled the work.
> Unregistering an LED that is on turns it off, which queues the work
> again from led_assign(), and the work then runs after devres has freed
> the chip:
> 

Seems odd to not be able to cancel the work before unregistering,
this driver is a little odd that it uses a work queue for updating
the registers in the first place though.

Anyway, we can sort that all out later, this patch looks correct
for now,

Acked-by: Andrew Davis <afd@ti.com>

>    BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
>    Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
>    ...
>    Last potentially related work creation:
>     ...
>     queue_work_on+0xb6/0xc0
>     led_assign+0x223/0x340 [leds_tca6507]
>     led_classdev_unregister+0x26b/0x340
>     release_nodes+0xb3/0x140
>     devres_release_group+0x247/0x470
>     i2c_device_remove+0xbf/0x1b0
> 
> Set up the work with devm_work_autocancel() before the LEDs are
> registered, so that devres cancels it after they are gone, and drop
> tca6507_remove().
> 
> Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
> 
> Notes:
>      Tested in QEMU on a next-20260925 KASAN kernel, with the driver built as
>      a module and a test-only module that adds a fake I2C adapter and a
>      software node for a TCA6507 with two LEDs. With the LEDs on, unbinding
>      hits the report above (38 reports in 20 unbind/bind cycles), and so does
>      unloading the driver in 2 of 3 runs. With this patch there are no
>      reports in 20 cycles or 3 unloads, and the LEDs come back after each
>      rebind. A W=1 build with GPIOLIB is clean.
> 
>   drivers/leds/leds-tca6507.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
> index 9afe2722986c..503a465a07f4 100644
> --- a/drivers/leds/leds-tca6507.c
> +++ b/drivers/leds/leds-tca6507.c
> @@ -79,6 +79,7 @@
>   #include <linux/gpio/driver.h>
>   #include <linux/property.h>
>   #include <linux/workqueue.h>
> +#include <linux/devm-helpers.h>
>   
>   /* LED select registers determine the source that drives LED outputs */
>   #define TCA6507_LS_LED_OFF	0x0	/* Output HI-Z (off) */
> @@ -735,9 +736,15 @@ static int tca6507_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	tca->client = client;
> -	INIT_WORK(&tca->work, tca6507_work);
>   	spin_lock_init(&tca->lock);
> -	i2c_set_clientdata(client, tca);
> +
> +	/*
> +	 * Unregistering the LEDs turns them off, which queues the work again,
> +	 * so it must be cancelled after them: set this up before registering.
> +	 */
> +	err = devm_work_autocancel(dev, &tca->work, tca6507_work);
> +	if (err)
> +		return err;
>   
>   	for (i = 0; i < NUM_LEDS; i++) {
>   		struct tca6507_led *l = tca->leds + i;
> @@ -766,20 +773,12 @@ static int tca6507_probe(struct i2c_client *client)
>   	return 0;
>   }
>   
> -static void tca6507_remove(struct i2c_client *client)
> -{
> -	struct tca6507_chip *tca = i2c_get_clientdata(client);
> -
> -	cancel_work_sync(&tca->work);
> -}
> -
>   static struct i2c_driver tca6507_driver = {
>   	.driver   = {
>   		.name    = "leds-tca6507",
>   		.of_match_table = of_match_ptr(of_tca6507_leds_match),
>   	},
>   	.probe    = tca6507_probe,
> -	.remove   = tca6507_remove,
>   	.id_table = tca6507_id,
>   };
>   
> 
> base-commit: 05b4738b0078f7d6f154f68068a11c8a0635e9df

