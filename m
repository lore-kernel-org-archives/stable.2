Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FC4C14E3;
	Wed, 16 Sep 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552908; cv=fail; b=cVcP4w2pFRpqhZEjSMRivEFpvoGWosMeAK6neHoIRWMNYI5nMhg5/7qbYXCKLi29hL/56hcKIxtNtPR/BkhZXBYggDiLJGJ7qk+5hn0zyZBPRNZDrmE3U3Pq4VdWPP4lia5f+s9omRzL8thxNm6C9usOiz3zpu/YAxRRbQlO7c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552908; c=relaxed/simple;
	bh=02oy9Fqo4Buh1OL7/tx8DRHO3WLmNiczba5r110gY8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZFAQ7/kpJfXDGFvLB2xLw35efA5UiCIhTES9RJshYinFzu4PS2OlliccUtfkFhm/p1K7jn1zX4w3vWiJZxeN+DvyP6CpzHYYOT5XTBg9LgQyvdAuHLWCEPbOce75RyK/HN7nnVpVVm/92Zab02R1TaBxy8fqUYsXA6jsujGn9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PGnGKjS2; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ztf+P0R4; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PGnGKjS2";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ztf+P0R4"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G4dx6h969533;
	Wed, 16 Sep 2026 05:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=SVOHUAcNXzFz/nVUe8
	5A+VXA0vVFemtiovIHXlfqowM=; b=PGnGKjS2PNCDgfcC+Iz4T8cvLQBAbtrI3P
	NOKGtZpPalM6RbBRFcy35ljoB1/CPewiFBJZLGbOS6Wy8ZuZethNsj+ulidgGKg2
	HyH2SvcDpo0tkm/Ulvps2PJqAaILhKBJPdK7BDkIGBNa4ZvDMkFJhBSoKychuhur
	MYQ5iGhJfLYRYAYLrw83dvsY/UF76sc3uJL/16O+riQFgp7dw1sifgd4v8sAB412
	MuHBq2ohJzb4tRDfBHfY7z/sAbwZXOaqaWG0XK2UIgoI9PnIAKJ972zP34bPXB90
	fkY+S6gA5AZARgw1uWELI3JIptLmfvM+CpnKJcg5ce3UIwfAhIDQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022099.outbound.protection.outlook.com [40.93.195.99])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gn35hcus0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 05:01:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+wsHuKv6+nQe3/TfNU+/6IqQafYR8oggYM9UKGr4pNpTJa/4udqGv+Oq7ATxh/4jMdWtn6lrhBCzL71O5yN07k8Rea95VUBVwVYhR7SvEUN5Ueu0/23if839eUXRYQxK6NYyw5+akCJZuqC2eNoQUbIBZFkIyse8SUtbivgzUsrOrAzSq3mccBKn44Td9OH4QtFG1d4fXJ1rwf7ctqMjjmVUJNeEmpFTG7VZmBdiekeWpj2tAaHUJiUxMA3Mg+VFr41Z8X2qIKF81zzd/xLUAYePfLVDrmRi2jARaqjZjuWrUYMJfreTiTsVGUncSufsR16u2DnrdGAaSOfIkCNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVOHUAcNXzFz/nVUe85A+VXA0vVFemtiovIHXlfqowM=;
 b=k5keeqAv9/YJTx51eIIgp1OKRrbp99dD4wH29imt/2cdseZhdXV6x7vDVBFwexSij+/5LVXyJ2nozLDRs2QUktGYf0onmh3r9fHVSIK/1pUP+5s+iugW4PIO2Qic4lZCT1+z3xgkXSzsmbJ36eV6ls7elYzxTspGvTQxMniRaaZSY4hAvQgAIx7s9unACGlrxgbdunQw2vc6TfYAvIl3gFiXJS3GueSPq3FWAtH6K+J+Qfka1eNi5jz51oOHrqtzdn/meWZS131wMTTKzf6gVf6v7QTSOhcp2zPYWqEOYt7PwJ/h44yRLiD4yjlLMOwLsIhtonCnlG2LGNwVDoK4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVOHUAcNXzFz/nVUe85A+VXA0vVFemtiovIHXlfqowM=;
 b=ztf+P0R4+leThrDVQY8Muoq3ZL4+ZF5rKH9cVi+VAVni4o3A0pySTWZZfs/mOpPyQ2FnY9eJG1eMwmeUIWiMCIN5RpPaAsFZMpi1Rs+RxPzAouKL/uDTv0fjBC9bWnBqYHe2AeFMDjjAzj7qvEAf05pyURG2+6/VwDOgU/Kv3tY=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 MW4PR19MB5632.namprd19.prod.outlook.com (2603:10b6:303:169::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Wed, 16 Sep
 2026 10:01:17 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::88) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 10:01:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.0
 via Frontend Transport; Wed, 16 Sep 2026 10:01:15 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D6428406543;
	Wed, 16 Sep 2026 10:01:14 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C5A8C820247;
	Wed, 16 Sep 2026 10:01:14 +0000 (UTC)
Date: Wed, 16 Sep 2026 11:01:13 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: brgl@kernel.org, ckeepax@opensource.wolfsonmicro.com, linusw@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: arizona: Fix runtime PM leak in
 arizona_gpio_direction_out()
Message-ID: <aqpo6Uyw8ZbGsx0g@opensource.cirrus.com>
References: <20260916094701.2007509-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916094701.2007509-1-vulab@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MW4PR19MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: c51f8517-a2ca-455b-63e2-08df13d97298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|61400799027|36860700016|16102099003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Hb6JIKTR7WUiex9uBUW5tJplCxUJwegY76mRE4hKT5/CrVBaH0a+FtpGh84DhclWCvLsBXElcA10hhPIUjWtf2GI2PV91kcgaxrQcO6ZlwH0mkkpIh8iAJAPuUgahw36g3g7zWw7ph5EokSSJEYO/VO3dCLiBdx4f3zpDCXNZ4KDRoUcUe2vYj36l2Iwxd3PREGFD+JZz3ZrZ0zFmwnggoV4a1imBGhKsngQ7iLIJgSnXcf+m0sp0EwQshzgTO/qAmYWdkdi7sRTrJxY93QijzhzcgfGrwIsIOOH5QBLNgZXHTLezp//ol+RUEM0FW8dZ2EiAm83KCFSUPknTJsU4fcSMx7XgJTJhxcv4NeimIjYvNIuCGG84YsDwrZNRj4J3wEQ+dHYV21bMsZvamrpHy92EoQObarXsiMLSBfHSkLc9J87DIHBHtXSbvUYO63fJAOJzCx0reO7Y35Wz5+z303pjd4F1zRg+RuyzpdHTFTXETXt+BHIN+BlybMmf2Cplt0DE0hqN8kSFwEckpJRq/QpY0Z8R5f9UEP1He33mHXmng9AXUbMvwXphzDt8fFluUsppImHmnBHn1zHoEGiFI6l+A53CgbzPnhYcP/EuK8+HYKUAtCIvpOl7C7wK+gS9RojHyYXxM6QMysN+SHgUnOK4MrY7hH8xHvxHYoaNXTpGkfAwyaRvTlbJL0KlwrUWjN2cDknh+yf5EdeOJOtIw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(61400799027)(36860700016)(16102099003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Ub02w9i+K5pKBYO0i2tbglpMwNWE+xoonkDncQ0dlWGcm9oaQrmlHfpewV9OPV3JqI/TAph1pPqYIG72zC4O92IymkKZ2xymiSNWY0T1Cn5zxoPQCKv2XXiFULxwicCgFOCBPFPLQEudUabt8jGhIQD2n0jWYDPm3YbYrIFT9WSvgutbjVk/FGWRKG5UpJ6Xim0DsuqDgU8U0G/ozxAVGEvQAEFzLuNGQVef5YyYy2WGAik5G/G2UyElGATEPXblk+m+uDGbswW7LYvIvB+i7gbM4580+EtGQpQeeXToekRgKSxyZUjQhws5M2vW6m9Y1VRQwQ1uWMPYMnyaFn1cj8S43MYDfXc3GBHK2HT5ZnXQZCiVcbmjYAGkX9PvFwd/mkTPWeRnszvAD0JTzCtmoIPGsFT4JgYwVMygdL+wPAR47HpxZe5I0mHOVkxN5Us
X-Exchange-RoutingPolicyChecked:
	cQ5SrdIHHz5zLlBDS9CKiexYPV7uzf3XfgQhwv8BT2Z6x4kJZ6iNmHmE0IPFi15/usZKtwzCQUcIQi2bDog96OtBQxaNVkp7SoGCF/y6GaLAozoZp8SCTyPO2Ls/omVDajOtCHTb/YnC3DUaFRiclIwvU5ssOeZIwD9H67eZP5ra60K/+uzl4ORYBSt+8zFjGHyKgxXIu9g2XZ/1hsP+Do15e3Dtdf2GgP59pobWUJ9B9P/TOnLmPpfoei7tV/1yD0XcR44Dtn553HYqtyZOOMiz9GjLtxAzRaYlI1U/NDyPH6fX4e1smBHN43R+Kh5QrysGwlDgQmMc8UvpH83XzQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:01:15.8929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51f8517-a2ca-455b-63e2-08df13d97298
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5632
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfXwCpRQuqb3aED
 593q3zBrxkOO0C2gnSCCw5pXbQ0YUL3MD8q5leBsS4ftu9rzkS53KuEU4hfLmGAxLt2avubZOXY
 cvpIzCwtkyZIwIHRmuREKxgeOs8DXzI=
X-Proofpoint-GUID: _gCUDJFPIU5wTQq5QcF5akEwzpR-tvxI
X-Proofpoint-ORIG-GUID: _gCUDJFPIU5wTQq5QcF5akEwzpR-tvxI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX7OegUrKbpnk8
 1cFHU3hGGt3ydZMVo0Bdtv4dLr8bg1krBl1aBYoGhvm1sB0/U2hY7U6LRgZH3M0/8dsfsVrTfGW
 2s2giuj2rBarVIPGfBmfBqZ7/eVMLSXyo5UsqMS03xww2E5KXvYFofMVFXLV4nlX4hbaooHFYv0
 sa51au4qieLJ6vpgUFeFDz4hP2lQra7K2M9+w7dcpzWWL8JEx9t8VvKsXU/r1SQeOfRMcepind0
 q4IOfvrAhMfAiGYxRGYOt1OzRqDNmeYGQk5hrWw+S9DrW7oFsHnVLKDgvy2HDdD3YpRthKZO4My
 w9o3jrctKqk3Tn8TkP6/CiiOk1YB9z1koLQPU2zFWSdzchbA2iontaL45i+/OHUo9MIr3O5FqB2
 AhTn6nfHUW+U2b9o7XXgYoeSRh0ZpFvB3ID1B6BApHNDPuZwjmT3ByG7TZ7WsiODqZtOxjCjHRo
 M4gTnmfZ/WKmeuWZQIw==
X-Authority-Analysis: v=2.4 cv=It6L47/g c=1 sm=1 tr=0 ts=6aaa68f4 cx=c_pps
 a=QfAu5cRUQmedtNjS8psswA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=zdfkEsTY1p9MyvE_A2wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 16, 2026 at 09:47:01AM +0000, Wentao Liang wrote:
> Switching a persistent GPIO line from input to output acquires a
> runtime PM reference on the parent device, but if the subsequent
> regmap_update_bits() fails the reference is never dropped and no later
> direction_in() can balance it since the direction was never changed.
> Drop the reference on the update failure path.
> 
> Fixes: 27a49ed17e22 ("gpio: arizona: Add support for GPIOs that need to be maintained")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
