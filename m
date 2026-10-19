Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792424413;
	b=r/CFYjz6YSiWadcwDS9c4lv+/BKiBKkYQP1bJ2qrAbyK104Umb4VGg3V95Xeeqc95Vx2
	 T1HPNSg+EkpdRj1PCegp7/qhnasFJQPeIvV/6SXWl5IcAyRgrbVbSePC6Ux39iNzOdEcF
	 DPbVXeTXqqAf5DP697MRVtcxWZD5UB3BRmQiBP4tIv8KgR3/8kyc6VzgUX16Qk2oYqcgp
	 8IMZIFWvms8AEErifoOww2VcSmOY/ft65ROuW4Y9X26GCZJVKifVz6upk+HIu4he97s+L
	 gaQVl8GhjKPOXjN5OM1zpnFaWzRtj3XY6+xAmOFP+/OkmsAIJLvJYTZr20ZLAuCCe0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424413;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Reason;
	bh=KutMuQshVMvdUubnEokFHiyOUKWMrd7Irzx24Gd99JQ=;
	b=bvVzVon8FSEDVOlIMzpcANq63on+duzA5nuSUJ8PFrbuNCcb0vruZnVG0HG0PTAf/RAI
	 H/5bqTh7ayQvjWnAFnN51FdyW+6lZxB1PlhoZbWNh6dZ1RLArxmkx/ftg0OUaQf+TxMGn
	 CPlPzaGmw8lBup31PY46l2WiRCEblVtgc4Ip3//ncsyTKz+x39qxB8Be7LRTaL9uw6jCW
	 OJkK1HaCh174F6tS7bf+MHXGo4ue7olYE+TidCQ72O7D6RcInJwURmtS8CUiwib8skLzP
	 HRhPHGEloKI13qYbmLU21Q3E10+7CUip2s+H9fo4Sm/kpkSq2JPDJDCkffgaQLnwXeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b="anbtb+/x";
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=SGogDVs8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C8607AF10;
	Mon, 19 Oct 2026 15:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B53C8607AF10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=anbtb+/x;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=SGogDVs8
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JDAvoc2244214;
	Mon, 19 Oct 2026 10:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=KutMuQshVMvdUubnEo
	kFHiyOUKWMrd7Irzx24Gd99JQ=; b=anbtb+/xOS8CsoiGMT0ZG/iXZQsjWnb19D
	JGBPbHys6pPD5f6bV1KDXxnEzvoBxXDnrAeWu3nqwc/1XvpRX6YMc/IHYbC6RFR9
	QMgKTl1p3SIBilF8AB63lGy+vm0QUFk7dGAbmZkMRmR6znsoyWaXzQ0cTknZe8BK
	gYoK7HLyS1SBFk8qV86nc3t+K53COpnSPeWn5jo5pUfV0q84h+B1sGaQ7h+V4bxT
	KE5gdyidaIdKVJeofN7AOsf6MQWAf2ycxqbmzt28aIvHABh2NOafY4ZDR1dnMWaj
	iRfpMO+nfjJrRV0QMTUeNQ2tuytCH3rvSRHAYDiiQht6eW3V1B3A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020116.outbound.protection.outlook.com [52.101.193.116])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hc5ej2fum-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:39:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCwELR++vRMI7z4IQ5NI9gZxzCSdRmcytS9b+kdNe5Vb9M/lrpY9hKtTX8Mjwk8lhIIP3QsLJjvmIsIxfCsBHJv6ZdojTa8TWGh/v3nlkI+iWqQTRj0ZHble+GHe71pifSIEYYPD1IFI5AcLXoVaR34iMKSyhRTD2H3YO0N6OOJqV76/8GqndcZh/12ldw7jjtVlPmDJwL91QiBdDlAC+zBUfY0J8piyXJ/YSZwt9rpdqpkkXPTVz/rIS41hXuF08N+mmCA3l97NWRMby+t6W57Kl4mF9uLqrCPuQX2cGd2YrPTVoYrnl5GAlcz51O7cKzFlx4XUO898aR6BjpKqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KutMuQshVMvdUubnEokFHiyOUKWMrd7Irzx24Gd99JQ=;
 b=tnAp8IMJwRRV371+5U1Ufts9GeIq1cTibk/StnOxz5/FyRr89PMWS0pADKW/aNQk4EmQjuPdNnCgpP4w1WdZ5n8Ed1nM0m1ZcV4pm5du4/Q44+MtX1WezONM33YOsTd+tO0HGKUGxzczQIqAxGWegYPUo0R38QwZkbsDTUDM2BAfofsbYpt1/zN3Nukt6mpm6pm2R3NMTANgfwogjKL+4lPhLIot2EGP/lot8gLSrhuyNmaGYIrCD2buL8jYrXfYbRdVceT25O0/+l48wwFNFSIcQDtIXH9PH+BDqwVhuZ6XMsph4Qu1GcHKBff9EmTrwCLR+21XsEjCLIAb1v+T6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KutMuQshVMvdUubnEokFHiyOUKWMrd7Irzx24Gd99JQ=;
 b=SGogDVs8Ep2RQsv1rUo5j6MtJYpLNE2wbCJ7T9+yUnkNtQhmRkiJjNdx5EYSrIADt0Se1lqIi9B6Zmt1NCkgVFiFmYJ7FfeLfIRdWZHYNtF6OIxxtp6/NgZWmuvV0BeOwYfWwksidiZAo0NSevmH/MtTiTEjW3ukT3eV9Z9axco=
Received: from CH0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:b0::29)
 by BY5PR19MB4033.namprd19.prod.outlook.com (2603:10b6:a03:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:39:46 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:610:b0:cafe::ae) by CH0PR03CA0024.outlook.office365.com
 (2603:10b6:610:b0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 15:39:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 19 Oct 2026 15:39:45 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A924D406540;
	Mon, 19 Oct 2026 15:39:44 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8769B82024C;
	Mon, 19 Oct 2026 15:39:44 +0000 (UTC)
Date: Mon, 19 Oct 2026 16:39:43 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH v4] ASoC: wm8962: Stop IRQ from requeuing mic_work on
 remove
Message-ID: <atY5v0BUNKLtm99Q@opensource.cirrus.com>
References: <20261018021817.3859256-1-mhun512@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018021817.3859256-1-mhun512@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|BY5PR19MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdaf4be-d7e7-4343-d210-08df2df733b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|7416014|61400799027|18002099003|16102099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UlofQZArilPvS+t/Wu+fSpSYHqtHGs9bhCZnwB+L5blZWWhpDrt/dBQgo6knS6n7dR1K+X7Qc3KChqGwX2Tu9T37QprFo3uPCcA246trOSmjH754mQk9jr83RK5r/ULcjQf/23zwfvvVXACOqhme69D9z7BA8GLdgwQtINAIVnCldypPfu1fNyP8CxG1K/VdSoKF5yV6qE6zvNkWkc5vj4cK2bTSwzpJc6786zdT1zwOonzW2GENIp830GEs8EFdkc6kle2/ziZoQfwsHLqJ6UA9jBR/lCyAjM43COOT07VDjoEvip5o8+gekW1YWzTd3puIpur4xlVST7kvVZLRVW8Imh806MUXvFFngU8ih2HTLRMcJpbkrccFjU4KWz4jEBQmDjLOj6qjBIvt6tHRu2MS1LYIpmbT7YNxtXpw2eR9XcBP4RqJ2Ov9nLRaqqXJMwuVjb9bNKJh94c4wLxIfTaeIK8ruHdR0x8qcclFk/DjXUF/J2+wbRq2c06WYiAUssngygVB5EpcBpdvpmepF11zoXSU1lXtPBVdA+DNl+7BVN7ANaXyyOi2zr/fyBYYl65LBAWJ9p+8AHYoYRC4N4wM2Ug78RGysnxa/2sht/RM3IwtVIzPUyCSgFWgfWAXiyovpIPc7qLK/aRXU361bNdsQojDW5E1xEwNqEuS/zp/jjZlFXrWxFq4iZKgTTqihREC1y3u4yqv6dEeEvGBPg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(7416014)(61400799027)(18002099003)(16102099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OyWGYxdtSajYsWYDtvfZHLkpWn4FAKXEUPlM4xnta6b2vtxzdu2vJP2o/0qsI46VRzCt/kC3cdkZJASB6skWG9Tgfg/UZxvaFiY4xr61xIN4vowg+ahV1wnGHL75KWj/zHMoRDU4YG11VcrbyirDIWsu7zxORym1ph8YY5zK4awM0EMty+nox4w490aQLSzdvCHScmz4hh2Q5ebc2V8wgIk7kzHUWAhlFj6SsjPvrxyxu2XFoQRxuaAlcmThc2m3FLb6xJijMpImXl1QnN10P0TMEETN9WQe0IlR5xJ/Fx5umYOxBswPo39B4zQo4ohcqQBfKz0a60zJHT/tx2wZB8sut0xnGNe0DCYij2KyarTlMcSh5KV9FzatUQanY/9CVJNcuTl37uUSoYP2Na/LyOU4lLqneXphCUp9L/apBI1Isfzu3P2HQu85ZA5743g5
X-Exchange-RoutingPolicyChecked:
	MupOZSs55hy1q9Gz4Z6IUXhRPTDxT1l0nEB0/Im0acF6tb2HYx8/PAq9WM4I3rnZG5W4CfQ4OzRAecK48kFtBH6HSLsN+4hHWOffMEvASIuglFpNA4FqTeFYWIf4PK99EW2bjicUI6B3VGXYgZzm4XnPQ3eFa8tVdzGJkFeSt7ReIe7RnPIrzkV07dDysCF6cimbjkKcfuTmTINNhsiXcsNldlpEFLEjjtoOBd7DG3SpBBgJJ68PHX1VoPfuajw/k0BCPIm33XAmvU4e/aez4jyVWC8QE8zrYte4MxextS2hYSALJ3b76CUBwchLOf9Zfg8gqMdp1nhv5g4R91KxGg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:39:45.5223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdaf4be-d7e7-4343-d210-08df2df733b1
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4033
X-Proofpoint-ORIG-GUID: 9S1i_QtwRMPCTsxl5akq59_KLKrRcEHK
X-Proofpoint-GUID: 9S1i_QtwRMPCTsxl5akq59_KLKrRcEHK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfXyOJHFYnXTCFl
 pSvgzVWEy9rUc1Db73a7+zu5av+boptyeCQhora0FiP6mApVk2z0CfM7vhoXC0GsTSl6HiXc89/
 B++kPmdY0BgvPKgOvLOLIOpoqhJiHN0=
X-Authority-Analysis: v=2.4 cv=KrjYSmWN c=1 sm=1 tr=0 ts=6ad639c7 cx=c_pps
 a=ncti5ugMhgZX8XAjOw9fkA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=bPxfyd-zazssHTqC4v8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfX1/QW6PhxGdJU
 BUTzwQ4TrhU6vClXPK5Wpd7O9qfj6sk6g5F2S5bYWN8yqSlV9dIm+m3L997nHrMiQCGRWRc2fja
 8utF2oRWY7X+o4YxH0To/yTfXGjPLHaNbIbk1vO2yBISYR+aKaUEqIZj8C1AY4MODug7j0gSfZx
 62kHnhh88ZogmRkJMjKaTpMNSNiZWV/tRyuQ9yhcO9YKx05UrLT3p5bOcctmc0CmKfmfnrPGSOV
 p/W6uVAVQzS4ndCM3QyIszi+RctQ12ot3zwdc0imXN2vkOrReANBlpbUVBK5nahWTPfSkKmLtyn
 QeyprzZqm3o3Qo1pdTuBFeBvNBp9UIPzho8Ibf+zgDZl2g3dkkCda9RQYViKtUOz2rr1MdEtswS
 A+axW/ok153twjtG1+JsksdhZplBL5800zGglcihgJTGSaGE8BcqK4M5GzFVoBmnIlfCg81Aqbj
 SD4QWNMPDrExDEmP/SQ==
X-Proofpoint-Spam-Reason: safe

On Sat, Oct 17, 2026 at 10:18:17PM -0400, Myeonghun Pak wrote:
> The WM8962 IRQ remains registered to the I2C device when an ASoC card is
> unbound. wm8962_remove() cancels mic_work, but a MICD or MICSCD interrupt
> can queue it again before the component is destroyed. The work then
> accesses the component and reports to the old jack.
> 
> Mask microphone interrupts and disable detection in wm8962_mic_detect(),
> wait for any handler that already read the old mask, and drain mic_work
> before changing the jack pointer. When installing a new jack, unmask its
> interrupts before enabling detection, preserving the existing hardware
> sequence. Call this path from component remove while the component is
> still valid, leaving the IRQ registered for FLL, FIFO and thermal events.
> 
> Tegra's card remove callback runs after ASoC removes the codec component
> and PCM runtimes. Drop its redundant microphone cleanup.
> 
> Fixes: 0512615db6db ("ASoC: wm8962: Convert interrupt handler to direct regmap usage")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
