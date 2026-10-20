Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513027;
	b=GuPf7lYgQBiw39T59/UivZywr9sKXee5GzBCmDz0UbUBsK89s8QRK1hFykDS5aVWmL2Z
	 +9MA1aio/BwY1AVhMT8h0pkyG5tjbNnElvwa60RMKVq5nydkipa66op2RUdUh9z31hNEJ
	 IHsyED4U+1MZmm59xRVH8sgh8ul0P/RRfGiTQdnmLnoW1ZMueWQe7apoIjlBHY+pnEYTG
	 VyXpZOkOwDHU0BCo6PLrk7WOnA5J/Fd5VyG+nY89qIAM7oFjDmI/QwS5FyAuVYQoswDy1
	 ATbNEZ8PdTN75t7t5W6AL8k4rLpDPWdXNnDv+YDlua8Sk0dNdT11BxcLRBqqKYHfB7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513027;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Reason;
	bh=bb7zyXw7XVi9YbzBta7AXPj/CR1b8sx3T6in3c0I6+8=;
	b=qOJs500MCsztEY3uMm30TU1EbvVe0+H3R72EMn/PpdTOGc1MAOhyT5wdw5gZoYz9GL4q
	 /+EyM6aXGNaCwcnZ95B6UWos6udXy/RIhmvcaJxPN312wCNaak1GvTM86BPH9cRA6rr0R
	 lYPKJXhwSkRpn6NE1s2QsRfniCNiprAELWHL7vPx4erzRuZKcur11B6d3UQBn8uGAkpf7
	 c4DU4yEqFTEM+Ua8aQaUBDP+Yd2Kusu0ray4L2mbsvP/db6SpJllFgtmCaAg52O4zvIku
	 YYPypzqF2cQiFm/vvsvPUFmtANgowJ0YeHDwU3gyKgJtwH0QNsrGOOXNVBt/3dqLZ9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=jsezxNid;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=QMJbj0ov;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940D606A31A;
	Tue, 20 Oct 2026 16:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A940D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=jsezxNid;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=QMJbj0ov
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KEuvAV680274;
	Tue, 20 Oct 2026 11:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bb7zyXw7XVi9YbzBta7AXPj/CR1b8sx3T6in3c0I6+8=; b=
	jsezxNidpvaf5VDRAMGkdIUsBaOuDkP2EjcbXoJ/Ejr1B21LGKENuDnrDLgtQhUK
	ksyeDE/YufvQaBfgNjTGOkLDfR1eFbVykfMYT00UTUDXcJyjrIsKufCirCZ0bpUA
	NqosouM0xxsBsOsguGQgP4Mwa2EEniTEOFC0L//7yCGXD3dckZTWWTMgGlG6+Cmq
	a63qeHMooYk3sxe7kmfbLyRxmlrz3zJorF+1HdechNHOkRYYoRSeQ1GPu5osmqRy
	rUrIRIguOdv22IcEcEafrCHTp38ThKAkTXK+yEM5Zs8RoBERhjRkDP7V8T2GGH+U
	vpdxFhp1r0SoXCMKkPTYtg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022139.outbound.protection.outlook.com [40.107.209.139])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hdw4vsb03-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 11:16:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9to87Ne2p3AuDNnq4OSh0ug8OgczkEbq+qAN837+v9ghI2ppr32sQGr6Kwee0ZZmwnnZqGSwHEeQbVKuQ4vLgmY9rZLRCN0S3LFKYknLVVMkH5huFhnj33mlivOPtklzgJ/DzURO9brNcAeIkLmUBJxEzTAeGCeC4dISafGhjaLOmbnXI+nA0/ZZo17m6vIDmP8CAKhiCz42xZf3ovqAD/wjvAojUd4fhhNr9RFZluoqI07yxUhaTPerIaD2/o84ea4pdN00+tfDXEx/U/n9ZF6AK43ijG6qIm9K0WYn/zv93X5z2NwYGWKQ8sS6uz+g/BayksgWGen0VfdDaqN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb7zyXw7XVi9YbzBta7AXPj/CR1b8sx3T6in3c0I6+8=;
 b=xlapL6cZN1/UsEaQyFbJzVrmhvhV1LNqQI7Ewo/ypGce6rbgbMaaoCM06gSCN9WndN7Ebbg5oE7tilDgnAgtHWBLhcO2wv/fHNiA17l6CaEa3Oi6OdZiugTQO1iSgswW0IOh7LAouy8ucTXFXRs+SFEKMENEm2c5lzqh2985wpxUW4jx0K1NxfHQwCqOleQxB7fucG+0Tc9YvQ2UFOJkhZlMN+T2MG74QWFWnbkIaGBexnwiNL+F8fRmVmqMYmrMLoF4WP/xhRiLtt4Hgrutju8yWBE0ro8jkl+TNBpHJsHjK1WrIUvJQ8gXgm2qD9Dt5y+SKh2h+wo6EHBGhBD0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb7zyXw7XVi9YbzBta7AXPj/CR1b8sx3T6in3c0I6+8=;
 b=QMJbj0ovVQEyizcRm3y4prqOJNsLaMaZSw8F61WHlP4LE2w1CANwBINlb1zD4nqVZ7tCZYLRBrAsk/QzudTy4FE6YnaEGr9oy1Mqye5nPGBLBNDsRTkJ3r0JuNdGf0NgGclCGaRePRdbtOHTrztU99nGz7J/DY332LalLxB1ZKw=
Received: from SJ0PR13CA0127.namprd13.prod.outlook.com (2603:10b6:a03:2c6::12)
 by DM3PPF73554C556.namprd19.prod.outlook.com (2603:10b6:f:fc00::737) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 16:16:32 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::8d) by SJ0PR13CA0127.outlook.office365.com
 (2603:10b6:a03:2c6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 16:16:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Tue, 20 Oct 2026 16:16:31 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C478D406542;
	Tue, 20 Oct 2026 16:16:29 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id ACD6A82024C;
	Tue, 20 Oct 2026 16:16:29 +0000 (UTC)
Message-ID: <a1e22001-9a2a-458a-a6f9-a24e3c4a7160@opensource.cirrus.com>
Date: Tue, 20 Oct 2026 17:16:29 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 7.2.11: no speakers on CS35L57 SoundWire laptop,
 "CODEC DAI cs35l56-ot25 not registered"
To: verazimmerman1987 <verazimmerman1987@proton.me>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <k5Jaxe-8dtnRDkZ9ahH_w3C6hqb0IATbibwhxy4gAuOS5rV1HKzb4hzzv9XO9reX24UPoyKP30ZfRI6EVa6Jl0A49Q8Z5o7VKfgFyaq1x7M=@proton.me>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <k5Jaxe-8dtnRDkZ9ahH_w3C6hqb0IATbibwhxy4gAuOS5rV1HKzb4hzzv9XO9reX24UPoyKP30ZfRI6EVa6Jl0A49Q8Z5o7VKfgFyaq1x7M=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|DM3PPF73554C556:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8e9b02-efe1-4a39-bf51-08df2ec580cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|61400799027|23010399003|10067099003|18002099003|22082099003|16102099003|3023799007|13003099007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ApmrIWz6TJLcmD2hK5BUPRcP0DrmzaPbBFKFrvr9Fn8BGeVf4eQwexICBJq34TR3fX9W/Ac69suS1hKoV3YWKLWGmfQttgJQQo9eFcSbHp9H7eUUjkH5cOwsu/Ss+PhA/5197O0Hj9lCBwEH3lS2nKTZSVJSEbErJbkW5UQPZq/f67dauxlJDeuqM0EwskUxefmMwwhrdyppcDpaeMC6HGafX3gdhqmtgfq0H0WSsydMSzwptwbCoBjqSLB93x/8Pwy5auAFBaKGAzXS9Qb6PcUmfeViMlAl6/n/2xfD5+IY613Uj0cVfEFBIkqxu/mvxlfeYJTuv0gLSvzDMs73u6SCx+W3F84wEwM2zXSHBDXMJtFAqXbe9izfEZfN2XqEL9mkDaC41Ktx3iPCeKAsRr9j9baUtfczlRSUUuOcP0/ugPoyIyO2G9pLwOpEoXBmJmz4LuBjxsr2hTSix00vBNFaC0rwi6TpnkInyFBE3sJLNm7/eI/gLe1LWc0/BfLSZ7A1vNMAauZae65gCTVwEQf75rJI+/el+aNPaERMAOxNopVQ0fh+JDDlLdUPWk7I9zVplShd4l3WljscuD//wL/3O6SmDSSKVkt4E860LKc7LGhc9eq+CFjHa19RbMFuX0Klv9tbWHBJB0FAibl11GFlV8x4CEG6FxVQ4oAwyro=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(61400799027)(23010399003)(10067099003)(18002099003)(22082099003)(16102099003)(3023799007)(13003099007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	riAYcWZSn1KuyLC09HMv0KfmgiLyexX19y8H1gpVelJYJJrnZE0rTkMbMuliZSW87Hd6hN5/qrKNlaWvAePab8iL0kwS4JDL1M1DVmrJyHDHBnTgpGyfMcUpT1ICzinXXiVFjuIxxGVedJLwbsfekl0q9GGzSMmVwx80VEQ47w1/e5FZVI3vHfqRGuhYQBmJCjs08TMTsV/tBSiYKa1gP9fKnhLb6Ovp7lkOus0wziYTVeRgZJrEcXDXhvlpwbR/S3o9kKSq6cXg0daPEjQZ2gFXdhJ6PvxJklfJHAPmFGz9CX1a6RxE4p97CKJXdfC3gwOmK06z9WATXP9u8tmfFKBSXLf/1qEfedvj7q17FWEtB/eeJJNytX2AQeCowLpQvofU9Tf5wmU/1IcE8AIXJalkVOCmYmrM9p4JX4ucFKCMX3vH4t2MT+6Bf85tmS0R
X-Exchange-RoutingPolicyChecked:
	pNxTYsgwNE5eAW1kR8aArjcNTZKGrdOlAffbJBYskn9QyHfXbV2NPz/u/mc+F8QCP4fIaTyHOkcguq8FnTKHZkiREzTEOgEm3E1uOcmFz3M/X6ng/UvlPCf1uFreAwlsWHsuftuG3Y98Nag6Hl3lfVdtoj8O4FbsGmAwuNYQeBMSEgXbTzoUPwITn82XLQQKpoSjsoGSekTBzeSuAtfVqX/44e3wiY9WZy8mjYnifTabiw+9QwfHqPakiJ8bsbnPhekzLnrXPdg7iqIn9DtNKYOAayL2Z7K+bnR9/718fqTiTPRjRKvrocbZCZPGYsvh0+bf2rYpMWVnLvZRqjVZQw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:16:31.0978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8e9b02-efe1-4a39-bf51-08df2ec580cc
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF73554C556
X-Proofpoint-ORIG-GUID: sHTspBRQv8j1MiO5vBDHrfzhJoKgQAPs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NCBTYWx0ZWRfX1D1ndP/n55py
 v9i0FHgtbsZxvW0PDypw1MFNz2jUrpZHVWG/xXknV4WKtcZx8BmX3jnTg0sPDsq/4J6r802p2lB
 nZ91aitV58hdsascuds3A/S1d22NxWQ=
X-Authority-Analysis: v=2.4 cv=H7tOUOYi c=1 sm=1 tr=0 ts=6ad793e8 cx=c_pps
 a=A91p8pFdSY8iZOlwlHItIA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=2UBwMtoTQ2vo7Y6c5O8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: sHTspBRQv8j1MiO5vBDHrfzhJoKgQAPs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NCBTYWx0ZWRfXyjs33SGKMm0a
 oJhbpRYN49dUhZ3BgrDm0wwF/QqH1h3J8sgYTOoJVYdtDfYrjv6npxhXiT3oBfO4KWFJK2jrsju
 pkQXmQFsOGXY4b/npsa6GChl/Ukv4OVsQfaOGUV6EMw16PoBFZX5xA474O220ljFtEmMrdxfxgd
 rZA20y9lMAI54OJ4/orOZVGjhk4yf0xaRNZKDYgdm+QojvFB9Dbt/r5HYdAM9xTvirYOcAmjYn4
 /LQVBJPIyuYCea02JPDRLanGSyHAcaz4Fb9ilWaNHI0zdc4qmL5SjuD2eQeZcZZNVB0IM0TRZWE
 IPOPptZH1ZeMvJrjN9G1WaOLnHt8qVO9Zz0mi1VJs5VZSg0Qnj1CVX+LeOyQbMvUROt4AHZPdrY
 eNMEIFlRP9+tNiLq+Xef5JQFGbspX4dg1O5/80wZk4djHgqAiLAV0pQl7h1qC5YVk5EcLvOpsRY
 nEWc7ZAOR1rQuBpjZ3w==
X-Proofpoint-Spam-Reason: safe

On 20/10/2026 5:12 pm, verazimmerman1987 wrote:
> Hi,
> After updating from 7.2.10 to 7.2.11 the internal speakers on my
> laptop are gone; only "Dummy Output" is available. 7.2.10 works.
> 
> The sof_sdw card fails to bind with:
> 
>    sof_sdw sof_sdw: ASoC: CODEC DAI cs35l56-ot25 not registered

Yes, this is known and already reported:
https://lore.kernel.org/linux-sound/20261005155235.1386525-1-rf@opensource.cirrus.com/T/#m420ea27d936f1fd9cec79c988120a11caa8d428e

