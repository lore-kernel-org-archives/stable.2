Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D33DB32D;
	Fri, 24 Jul 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881806; cv=fail; b=ItivjSJk3/bESqLlUmBRLc4UjNleykDaF4gcVRvvEyl5xHyCeiUzQpSeoosLYTQkufLRL9tKzE5Bmj4vDZF4HqEkUXa5LswS6cuczOqKf4c+q1sG8QkyI3TYWDE5MOiuD106Q2Vk4VUPxrHfZyzH0iTpDxB5lo42CW1llPNrAQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881806; c=relaxed/simple;
	bh=yPVq6aDzDv5kVPRDuK/aibmKigEl+rM9/tyCx3whcuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NLuwh4EclS1y8LBqA3Pa1SEssVnddVjmnXJCApSGEQDTdDKuuGEf8Mp+Tv9vQuPcZvPCddDVDd9YwgYWKL8ZrbFeL5YIAoEr+Ta/z2EljrDuGmsRbXMX9hU0AAtHVyy5JDa06ECB0uZIHQkZLcw2UNESzFRK/4QvDbnSo+4NuG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=We2PoItw; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BesxNFRm; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="We2PoItw";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BesxNFRm"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66O4l1TX140245;
	Fri, 24 Jul 2026 03:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=MtFlfdrg+zlwtezojI54Fb1RobNIfmGu7iQEqYDiu
	jE=; b=We2PoItwWXK52SeeFyDpULuTomXNXXisCYI+BHTmR+IrdMeCs6Wh85vXd
	QgGBWPlbvYxDEi7W4EHfWc/573omRCJ0y7jZOxkTMdTpQkSAFN5rmsjikmWuYXzB
	BQJ8+5H7PIsP3kArFHJkFt4Cp6ArsDphghJZfZKZtTKAhN8J7VFEILTmezX0bJOc
	2F0gII7A9t2dqWNgMDgKSBy8LgUSlSEkqpsVt8Y38K9zTrrntNIt+qfFK5c/bNAZ
	vFDJK9S5JvYlj8nrWIWWzkqRT7XAqSbQgqU9knh6ve/wDvy4iyPZ3fLFtjOqyKOa
	mTy7+1yEFdbOT5ws82ViMJZCjqVcQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkjawe9u6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 03:29:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1yfE9y49HSHWqThkqrdxFlaf9eBM873TbjF0itOBympXcrMDYz3weJ0TRaMi+/+oGNQ2Gy07zT5XvBzyLDGuY0UaNO5D2ukyRYT9AzmrwTagyKfUrTEd+cdklBd1P4ZQEt4XePjZs2hwszQxuQKhWeCK5tu8vjVEdmLfv6OfE0jw15ALkcCPTmpu0qtfcGktWXv/Lozrx5NygVs5/0HcNnu8fO5jl3RDp4tft602fad3LrNipZO1KOTfz4oIFE39QfYDGAoZJHf3Qg23GzKE5noJpFZsXOQ6gwN2QTkbE2vrH+ESwQSHNWx/6UhLFb3ZV+7HOLM7QT4EwYyQJGISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtFlfdrg+zlwtezojI54Fb1RobNIfmGu7iQEqYDiujE=;
 b=eUH/647Cnm+pm5UxC8mmbMlYzCKtkO39wABipEy5073KzMOK6RuQQDvsSkONZIcoZZl0i/X70JwPLjE3VSnGCVOb4HUTM67bkcE8Uo82sLp5h9plbgaCPT8ewVWnkcpI/pErbBxrsI95mKzyFciJtBPIt6eHtESmGi9HEw74JdLrrr1S0hAKaaSCp/ZcN1eGZXCjkoHLlI6E7kHplugxROivA2vCIfqsfQtXzpAiiVeAJ++kBdNOWS5p5m6DhOU/zoiD7LFsuclxv7pYal3xuQ3b00y7U9eqYXfKDh+mr+kSUyYfHDw5B23C8seLYCF37ohMPo8mHEkKg9MJtZlWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtFlfdrg+zlwtezojI54Fb1RobNIfmGu7iQEqYDiujE=;
 b=BesxNFRmIgF8nOWrmXcV8s8OAvZjHrvvukc2oXEfyaIhC6HcwcsJveJBJCqSZ3MjbBsMzylOPmh4612NurkWgN1Pu9RyRE5Giq14HqbNe8zPtiI3oMkQljxkrvuguu1iYtbLKXhV1fNxuQJqvw/H24l1UrjqATq3hhfWIygWieg=
Received: from CH5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:1f4::11)
 by PH8PR10MB6289.namprd10.prod.outlook.com (2603:10b6:510:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 08:29:47 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::6b) by CH5PR04CA0006.outlook.office365.com
 (2603:10b6:610:1f4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 08:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 08:29:47 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Jul
 2026 03:29:46 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Jul
 2026 03:29:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 24 Jul 2026 03:29:46 -0500
Received: from [10.24.51.219] (abhilash-hp.dhcp.ti.com [10.24.51.219])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66O8TgPZ2852774;
	Fri, 24 Jul 2026 03:29:43 -0500
Message-ID: <4adc8ad4-e2c2-424b-951b-f83a41684d0a@ti.com>
Date: Fri, 24 Jul 2026 13:59:41 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] media: ti: vpe: quiesce overflow recovery before
 freeing streams
To: Fan Wu <fanwu01@zju.edu.cn>, <mchehab@kernel.org>,
        <hverkuil+cisco@kernel.org>
CC: <bparrot@ti.com>, <dale@farnsworth.org>, <dagriego@biglakesoftware.com>,
        <sbellary@baylibre.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <801025b7-a3b8-4655-af49-f9bb65254170@kernel.org>
 <20260716113230.3131086-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
In-Reply-To: <20260716113230.3131086-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|PH8PR10MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3a6927-28b7-4092-9b9a-08dee95db89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|4143699003|10067099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	87TPGrUmTml/VSULQUqSuv+2ltTtH649UgYO2g6FLAYQPw4pL+q+NahprXdsMHoeIBxeQjwFMNzv2tXsu2mfB+siK74rCgzXqfpschPV+Tbp1vmifg+tQrOsd85koAWhzeB70t7zFAM67Cj1M7n/FBe+T9Rea+J32kWAGFygwQJn4ZPsDHP/52t40mZ5orrg+Pbk+R4bvfGdIooPqxpDFBGGG+mrPeYCVqkVX83lQ9T0uz4C49CVum4UvWEzWTFCGXe85g5BWKE3MhCYB6f5zyn+y3yTzu3xrFi04qD+71wFvZgotr69kkv2jk/CcNhB6fCCf4zrR7923G0jzlwzWBMozy35uguQ1ZIXl+IRu+Im9tWqYruEWKEK2XAPz+XDPsBzIvbV9Cg3Del6uqHJlUmZXtucB6/qd1CjQX+UC4ZBvfnBfeq72xBn77/ODgOySG5QJ330y/MAKgyRf8rPAx5AiFd7kEa6RyTlBhw6O+s3nfuAspH2rmcwA2lJ2GAkKIT5N/kJs0qlf7+1TOviucqVNuq2zqU4fJc1CeXuMXeSXmU7APquNdjjVsICdbD0DkQjSQXhiYFyaPmxrpSurz2FGJLo3vz2fRbq1YC4B86N2kzSrcPdNvtKMuyCh0IQKx97urUwuKl67N0BwzKAbw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r2jJk/BJpWhwcUDyyFrYf7SI0CIaTtKDQDBkq2bUmd7B6jB2nsQKdgDFBfNtwQFTRVgw7NVSKkX/KHHj63rvpKeXt/OUIMAMWwKpZlQ7SD24CVNSns4P6ElwiZZE2VxQGH6+DYRgZzi8Ggd0YDic2MKqLtx+L2suXWHIO1A3HGk4ikITJkqinRim4duhsns5k86T7OTGhK4gvfdZ9+CQhZ+S8EKmjw30L5W/8LMoXqOrMUQBtyeK0riLLnQgM/RkcYari91qmOPYezDY8Y+yV3L530nS53DuZeVzy5Xt1xtjs4XVvwYPgx8EjevO1uV7ZnJt5HLmJakh2oRitRevMzfYbJHbhFx6vQzcMgYeQHKnXd67us8r2Tm2dHJHhARruIrxJ8kVPWjt4mP4wre9Oel0mA+hLep29N2Q96dwO27N4VcVyIIIRaOD3T6L0yxm
X-Exchange-RoutingPolicyChecked:
	c/qdrClEyDRYDBv1liNuumcTVkTPCc7cDLvqcHUTpqG5xwKHQynLbR96927frged3ff7zqoSopy2jByiBns+oTzhxWV11BdwxRsuUjqPBwnEFfCSBu1fza4PVxm/hJOG14LdTcDZxCDmc7Pe/9JLVi8OWem92TciAELWDqvp+K7lHE2QxmlivMXkhyVoVcd5rmR72vKvAjxCC6ShRjcsXgeYZaoeXkT2iu5rWBIceip+wdIJfQLJVDpJVseu1bIsJ3LQPCMOjUw4P0unz+R0pEYAJtxNTlJEVsDWLqvr4r5k0jNceD/i4Q2IlU8EVClT4x5nEVYDqKXzR99k48+kxg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 08:29:47.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3a6927-28b7-4092-9b9a-08dee95db89b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6289
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3NiBTYWx0ZWRfX43M9/tlwL/S9
 OZsffiOVyqUjdDpF0B79hv/1UqfxR1/69uh5+fLfEd7kyceM30V70/cmOgQYD7Rbbij7kyyYip1
 EcN3Mm+SWfgTA/JsxLDHYQcZbpTprKQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3NiBTYWx0ZWRfXwVG2ZBUy2rtP
 mGlq/B9S0zdxx8LN2cg+u++Gv0S5mabgDBw5yp2G4s58Xk8oQpy/cabeMf9Mj4K8ryEBtZ5B0L/
 IeqIbyjR0dZS3EPuXGKFlZusngrtUdygZZIbXht8ZQYC6xRzfcDc0CqyORWh1RPdiM26vCyTF1x
 ZuKTXvFA8BVfCQrMk91qJ1DjS0fkxGhGbOhoTnXEmfR7FXCKQYu6m0WIsly6+ojn0pD8WV6Igd8
 zzWJkdIVj/JH6pnobDE9qoHd/QSlLVs4QweYBBcpCWseGv/v3iVin+Vk7vqIgvVoPG58eY/ATJc
 Y8d3WzIMNMaHvMzJhlR184ti6MIiG2NI+PdSU8jxgda8YavKyRQ+6HXRhY7/qBwzAL8fy442CCI
 /JM6iYtEyzGQ1iXb7YH6pjCY5h3EwQHGtM3ihoi2HrimBV2THN0cvdxNyip9s9KDvHTiDWkRA5a
 aKJ7OULiyLFOS3w9Qmw==
X-Authority-Analysis: v=2.4 cv=GPE41ONK c=1 sm=1 tr=0 ts=6a632281 cx=c_pps
 a=wVrytDogCwW2gNy9sPioUw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=0qC2fOzHzQn5ViRwkBAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AkqSgpGq3WLMdkrBzZvJg44_hbwgdfAm
X-Proofpoint-ORIG-GUID: AkqSgpGq3WLMdkrBzZvJg44_hbwgdfAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240076

Hi,

Fan, Thanks for the v4.

Hans, Apologies for the delay in testing this.

On 16/07/26 17:02, Fan Wu wrote:
> The VIP overflow recovery worker is armed from the hardirq handler when a
> FIFO overflow is detected, and the list-complete path looks the stream up
> through the VPDMA list private pointer. Both keep touching stream, port
> and device state; the recovery worker also resets the parser and VPDMA,
> repopulates the descriptor list, and re-enables the per-list IRQs.
> 
> vip_stop_streaming() masks and clears the per-list IRQs, but it neither
> synchronizes the hardirq handler nor disables recovery_work. An overflow
> IRQ that has already queued recovery_work, or a list-complete IRQ in
> flight when the stream is torn down, can therefore still dereference the
> stream after its resources are released: the descriptor list is freed by
> vip_release_stream() on file release, and the stream itself by
> free_stream() on unbind/remove.
> 
> Drain the recovery worker and the IRQ handler at both teardown points
> through a shared vip_quiesce_stream() helper, before any stream-owned
> resource is released. disable_work_sync() cancels pending recovery_work,
> drains a running instance, and raises its disable depth, so a subsequent
> schedule_work() issued by a racing IRQ handler is rejected at the
> workqueue scheduler: recovery_work cannot be requeued after
> disable_work_sync() takes effect. The worker may still re-enable the
> per-list IRQs before disable_work_sync() returns; disable_irqs() then
> masks those sources and synchronize_irq() waits for any in-flight handler
> that still dereferences stream state. In vip_stop_streaming() the helper
> runs before the parser is stopped, since a worker drained by
> disable_work_sync() may re-enable the parser before exiting and would
> otherwise undo the stop. recovery_work is created disabled and enabled in
> vip_start_streaming() before IRQs, pairing the enable with the teardown
> disable across the streaming lifecycle.
> 
> This issue was found by an in-house static analysis tool and confirmed
> by manual code review.
> 
> Fixes: fc2873aa4a21 ("media: ti: vpe: Add the VIP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

The changes looks good to me. Hence

Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Tested-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com> (on 
AM572X-EVM)

Test logs: 
https://gist.github.com/Yemike-Abhilash-Chandra/76ff7b621001187283f28fcba15a23e4
Branch: 
https://github.com/Yemike-Abhilash-Chandra/linux/commits/VIP_testing/

Thanks and Regards,
Yemike Abhilash Chandra

> ---
> Changes in v4:
> - Drop the unrelated vpdma_hwlist_release() cleanup from this fix (Hans
>    Verkuil).
> - In free_stream(), call vip_quiesce_stream() before clearing
>    cap_streams[], so the stream remains published while in-flight IRQ
>    handling is drained (Hans Verkuil).
> 
> Changes in v3:
> - Replace the per-stream irq_rearm_allowed flag and the repeated IRQ
>    disable/synchronize_irq() in vip_quiesce_stream() with the workqueue
>    disable-depth API (disable_work_sync/enable_work/disable_work), as
>    suggested by Yemike Abhilash Chandra. This also closes a window the v2
>    double-drain left open, where its second synchronize_irq() waited for
>    the in-flight handler but did not cancel the recovery_work it had
>    requeued, so that work could run after free.
> - Create recovery_work disabled and enable it in vip_start_streaming()
>    before IRQs.
> - In vip_stop_streaming(), quiesce before stopping the parser: a worker
>    drained by disable_work_sync() may re-enable the parser before exiting,
>    so stopping the parser first would be undone.
> 
> Changes in v2:
> - Drain the overflow recovery worker at both teardown points through a
>    shared vip_quiesce_stream() helper: vip_stop_streaming() (file release
>    path) and free_stream() (unbind/remove). v1 drained only in
>    free_stream().
> - Document how the issue was found and that the patch was prepared with
>    LLM assistance (Assisted-by trailer and body note).
> 
> Link: https://lore.kernel.org/r/20260708013738.110752-1-fanwu01@zju.edu.cn/
> ---
>   drivers/media/platform/ti/vpe/vip.c | 37 +++++++++++++++++++++++++----
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/ti/vpe/vip.c b/drivers/media/platform/ti/vpe/vip.c
> index cb0a5a07a3d4..673f9addfade 100644
> --- a/drivers/media/platform/ti/vpe/vip.c
> +++ b/drivers/media/platform/ti/vpe/vip.c
> @@ -814,6 +814,22 @@ static void clear_irqs(struct vip_dev *dev, int irq_num, int list_num)
>   	vpdma_clear_list_stat(dev->shared->vpdma, irq_num, dev->slice_id);
>   }
>   
> +/*
> + * Quiesce recovery work and per-list IRQs before releasing stream resources.
> + * disable_work_sync() prevents the overflow handler from requeueing recovery
> + * work. Mask and synchronize IRQs afterwards because a running worker may
> + * have re-enabled them before exiting.
> + */
> +static void vip_quiesce_stream(struct vip_stream *stream)
> +{
> +	struct vip_dev *dev = stream->port->dev;
> +
> +	disable_work_sync(&stream->recovery_work);
> +	disable_irqs(dev, dev->slice_id, stream->list_num);
> +	clear_irqs(dev, dev->slice_id, stream->list_num);
> +	synchronize_irq(dev->irq);
> +}
> +
>   static void populate_desc_list(struct vip_stream *stream)
>   {
>   	struct vip_port *port = stream->port;
> @@ -2428,6 +2444,7 @@ static int vip_start_streaming(struct vb2_queue *vq, unsigned int count)
>   		goto err;
>   
>   	stream->num_recovery = 0;
> +	enable_work(&stream->recovery_work);
>   
>   	clear_irqs(dev, dev->slice_id, stream->list_num);
>   	enable_irqs(dev, dev->slice_id, stream->list_num);
> @@ -2452,13 +2469,17 @@ static void vip_stop_streaming(struct vb2_queue *vq)
>   	struct vip_dev *dev = port->dev;
>   	int ret;
>   
> +	/*
> +	 * A running recovery worker may re-enable the parser, so quiesce it
> +	 * and its IRQ handler before stopping the parser or releasing the
> +	 * descriptor list.
> +	 */
> +	vip_quiesce_stream(stream);
> +
>   	vip_parser_stop_imm(port, true);
>   	vip_enable_parser(port, false);
>   	unset_fmt_params(stream);
>   
> -	disable_irqs(dev, dev->slice_id, stream->list_num);
> -	clear_irqs(dev, dev->slice_id, stream->list_num);
> -
>   	if (port->subdev) {
>   		ret = v4l2_subdev_call(port->subdev, video, s_stream, 0);
>   		if (ret)
> @@ -3074,6 +3095,8 @@ static int alloc_stream(struct vip_port *port, int stream_id, int vfl_type)
>   		goto do_free_hwlist;
>   
>   	INIT_WORK(&stream->recovery_work, vip_overflow_recovery_work);
> +	/* Start disabled; vip_start_streaming() enables it before IRQs. */
> +	disable_work(&stream->recovery_work);
>   
>   	INIT_LIST_HEAD(&stream->vidq);
>   
> @@ -3139,6 +3162,13 @@ static void free_stream(struct vip_stream *stream)
>   		return;
>   
>   	dev = stream->port->dev;
> +	/*
> +	 * Quiesce the IRQ handler and recovery worker, then drop the stream
> +	 * from cap_streams[], before releasing stream-owned resources.
> +	 */
> +	vip_quiesce_stream(stream);
> +	stream->port->cap_streams[stream->stream_id] = NULL;
> +
>   	/* Free up the Drop queue */
>   	list_for_each_safe(pos, q, &stream->dropq) {
>   		buf = list_entry(pos,
> @@ -3150,7 +3180,6 @@ static void free_stream(struct vip_stream *stream)
>   
>   	video_unregister_device(stream->vfd);
>   	vpdma_hwlist_release(dev->shared->vpdma, stream->list_num);
> -	stream->port->cap_streams[stream->stream_id] = NULL;
>   	kfree(stream);
>   }
>   

