Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE64908B2;
	Mon, 19 Oct 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399266; cv=fail; b=fCGSYUFeDs9/1z98zmnRolWhLDCN85A06+xS/+QINQUlt69AbTgQEiE+nz8+GoMhs3EaMvRuP4nQKV7FzgV7uWtbUC29++/MCeISA1/CHKL1eLO10IP3knUJiRF24k9+V8lhxn01bpGHOeM5pabbK25ypEYnyJjHWgKcpMO9k2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399266; c=relaxed/simple;
	bh=WnrghVMr7/uJ/2lZMNNzqa3A1bfNYJzuSvadir2Xsj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4YbHMOTZU7tSz6m7aFC9RxppGt64dvaBQfFjyVYtOKPChOCL+8qZu5GCk9Eb4xx1Sr+CH8/aDsnxJhawP9fQVsmeTwkN9Vz3IQDC754r1WE0rrisXz0t/ncSDEkNjySuEPlIJY2lQeH7FZRuqfJbIMIJBczEYKuqMZPSsJjM6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cPTRi8B2; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=vZyFajjn; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cPTRi8B2";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="vZyFajjn"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4uKXK1404383;
	Mon, 19 Oct 2026 03:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=uAFoq2ytFqbRhoF8Ca
	gr9hTvsVZezimrDv5fW7c5J+U=; b=cPTRi8B2QqrGkYBKrVqab7ZuS2mPRdZB+X
	/WxE0fNNvQj+f+gwgR2nGkSf7N3XrSaKk3eHYDXnYuVyB5ApfmFZJWt7VOMKoOzw
	GMf5aKvb8qUae4djMKiSPxPQ9q3ru9OpNqG3QsiUdl0506R0z0pYa4tfgSqwHciZ
	3BM9/6JVH4MlsuhlM4OQ0zwbapNmOhvokcm6dwvq4Lml7aPnxFGHXko0qIHrVgCj
	uBswfQDTztbUbUc1LsZF8vZ+82tR5vmUscdbV6OeEqdxn0t4P+X+mUpXKhGt17fp
	BDPVTo2ZsmINb93DE9t6SXUitAYV5Nb/AWt1kwKB7I83xNFUdqow==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020085.outbound.protection.outlook.com [40.93.198.85])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hc5ej1tr9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 03:40:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmFnuLzRs1+S7VqqB/jXOyd6wnurw3NzbdoAsvQM8ll9qUCc0c5yfybC5VROafDapyaoX1iwS0i7HnnnU9P+jyRM2j6LBe8YwmARNQQ6OLM/mVGf2otHsvVrUWFC2rmZqR2KXer8/X7cEMo+oi5/yDr5hggQAJlbgsk2FV4zYDyutSCQdwuMKCjOZImBMzrcI6paFecdZOaezYA79c2kKCmNY6kSCl83BlBaG03iXvVnijlvRUVqC6jIhoeM8cJvD6Pabc7a5LDJqgR6WaHbcsnVcc84jI3Y7rQzuF6QnVtJPe6uCcV6ErPfJzU/QOm+olDJRtOmHy6hKlSG3wQCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAFoq2ytFqbRhoF8Cagr9hTvsVZezimrDv5fW7c5J+U=;
 b=D7a2mu5VauwnYFa8tAFeW2189/ImUpd/RQ3vb8oepVt35X/xcMIXS1VncfeG2RbEqaNPoNd7YmOwnmYggFVH3YGN/Dsw1I5/YoEokCmZJ/wPtPxEQ2/5JJEDYnfklth3/ObKnuk4RRnJft8nvrTua4/2QnvYkik8Ikd9FOMbH1RXl4TzCAFTqlm6MypPNQ+FBdm4a+LdR5RWz6l7RQc3Ik99rMLd9hk1GDIu9zKU/AjxZ4leY6E4vpRfGUQTtcfLY0EBk1NyPiqAIzNAzHDbEtWTAGPbgfo94VGH2wVf6VxXu3XsVxoFrhg1X7YzpvzXpSpDy+hG/dLjzuZbeCtlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAFoq2ytFqbRhoF8Cagr9hTvsVZezimrDv5fW7c5J+U=;
 b=vZyFajjnALv6QCNPAjVdnw9M/m+FHzFbvbzwbdU1LD26UUHilpMARdmiVoH6BW0ZAeCHYHrnyf7cGnsRoMmFxG3DSu7avf1kFaS3LRaciahCCKPe+mg9p9D6LMEHvXKUb2Dsc1aDiE1ItQ9qHa+8wy1/8kWrnQg2gv/3l++WxkQ=
Received: from SJ0PR13CA0218.namprd13.prod.outlook.com (2603:10b6:a03:2c1::13)
 by SJ0PR19MB5662.namprd19.prod.outlook.com (2603:10b6:a03:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 08:40:47 +0000
Received: from PH5PEPF0000002B.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6c) by SJ0PR13CA0218.outlook.office365.com
 (2603:10b6:a03:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Mon,
 19 Oct 2026 08:40:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 PH5PEPF0000002B.mail.protection.outlook.com (10.167.243.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 19 Oct 2026 08:40:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C1EED406540;
	Mon, 19 Oct 2026 08:40:44 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A6A5E822567;
	Mon, 19 Oct 2026 08:40:44 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:40:43 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: SDCA: re-enable IRQ on
 pm_runtime_force_suspend failure
Message-ID: <atXXizdc6pLzNCOI@opensource.cirrus.com>
References: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261018192359.287987-4-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018192359.287987-4-srinivas.kandagatla@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002B:EE_|SJ0PR19MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f806e63-1d20-4f01-3608-08df2dbcaba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|61400799027|82310400026|376014|7416014|22082099003|16102099003|18002099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7D8VGKAl38gyJPjYqlIUHhesOcqAJLGNqnybAQCUePCRTWmRmL778Hfp0JQeH8LVbJNSTlEH4KSJ3ZO9KaZFu94WbifPJ0Xdzm0oixswdon7wsFbOSv5wKkYkU87vEnkL5B31JGgqLUCCvr2dBAAA9K60VqtcrFk4qrfAmf7RgKGcsVQx4FZsc7WF3BqvH53TBHAwLo9/ATHzyBWINLg6h2xN+uEaGkudpihdpdzPVOj9qAwOqcbBrswKvaVy/Hiw98xA9tjsy7DyZPWXL63WabQOmitfP6vWmLtsaYXgy6p4D+sDcp5vV2ghXAgbWxXzmNx2Poi3cBuFv3pJBvLo2elENs33PMpvrWphnPZe3Z4ZBwRAfBbeNbrzmH8Om1HqpFFcJJ3VSCMRtuAkkOPDkin/MqlblZQF9qNA1qKA+s15s7w4S29xF/UXXgKPAYQ1GpENKA5SlyS2Qcw1NK8g5y2Mjaogi3jrK46zpnMreqkUSUA821t4YsZuoDVSzuuw/9BP7OlkNsrZiIYKqTn2N2XQKxDxJQKZvkNTlwamvqu6I1rhjcCLLAon7QJE+ZUaXhIP4jXXNfu/lP45JCaP0RDvEJz9KNuPqyR3IGmJAayRTJj7cKG1VkVAamebvyu3hB9+0Fz5fALEknkoPGYUsfj1JClElUM4Xl5NUlgkt1PAHvRzdP5AbPsn5pYdtX/sfr9HKmEemoLqdKGY+BatQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(61400799027)(82310400026)(376014)(7416014)(22082099003)(16102099003)(18002099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dg3yxXQQ8cX83GCxMUjTk6flLOxdh0zBIRUO/sEZdz+jK5HcIsCBQZKSKu2jH5KF0ZeAbJ9b2rG+JJUwFthf10FMxXXGhFKnQ0BrQkMlutFRc5RTAWmgwqqpGoeZgUtLva8efrd6bM2nwxLuMRusgwzpJyYezDdIJoac61SOjUsfE3oicknWJKQO4sHQS1wfmM9SWLM9INf6/DwVLmPOHGRtus3v9Pakdii2MihUmFmk6rz3ovRfr8haZZygHoCori3Iq2FmzTfQD2Y40Phd7JzQZX8TqvzbHP45SGMMJoHG1n7LT+86AnajptwTIkQm6J+V3JWTGf3Cq8Rp/kElkdOQa68oW8fxaIHMrgBq8HqK66J4nEMoYkN2nSsJ+Vbz6nHfhwsgQXxLnplh8dTx1AjUwjos2lNeW0ta4PQVR1RJPAJhRA/qksAhZywhZ1Lr
X-Exchange-RoutingPolicyChecked:
	RTsafPLV85fQFxyyULmcXcwaESsPbAA8VASkdrE+2tTSCx479U6e1y0HA66ttnGpzpP1jwL937f5uaJraNG40+O5aCjpaYmKT0haJEjTSfbeNGVvlehB7K3+KtpwLcUVL85mvKr9JcsYnHNRi+mNDnH8mMMEyB/kiiXvp/NCF2xAMXFqHIOK1x500VRYjY/RJ4LDCCVHPzxuFp10IzQbbXrI5Hfd7XRlNQfVy6vhfYIoWlO0TJ03ljI4x5GiTgZL0Ltg8skRj2aiEHJ4Q4Tn3sSNu1+2YLdiwhqGI5KNFxbaknLxgGX9+VuzFSWUUlFUld0DENP9OpvMI0MFtAUgpQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:40:46.3494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f806e63-1d20-4f01-3608-08df2dbcaba2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-PH5PEPF0000002B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5662
X-Proofpoint-ORIG-GUID: k5bWnmmZLhykZop6qtPJQA-Hcf1jz6oC
X-Proofpoint-GUID: k5bWnmmZLhykZop6qtPJQA-Hcf1jz6oC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX9ZkycHkUO0+U
 jV3ta0B6pH0fnnKZsJB3qbNnNCpqDQvJFGhQQlGeMh11yb8QM9oqhu/vNXzW37MYqQULcwREBCT
 yuOPLQ7rCGIdtYPP+5sfeo6lmzMtW/4=
X-Authority-Analysis: v=2.4 cv=KrjYSmWN c=1 sm=1 tr=0 ts=6ad5d793 cx=c_pps
 a=A0XUNoO2kYPMKlNirmUWng==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w1d2syhTAAAA:8 a=0HELhf3kYCoqtG__aEMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX3G2y/yrQXhgw
 05uO37+OlFkccYXWfEVALT/SyLZG2ucRkUdUvRd3wCDSMXaE4jA0M/j3X69fwErC8zfzCzfgSjh
 KgbxjuaYAmqx8bMd71+Uqrussd/MJYxb/XbymjMfdTY+U9a3lKtWeexzPxlKUjGhbjKu8NbQXFF
 um3QhfquU8Yos1qjt36zuHMK98oz5Q70LRvX71rQuMeIfaj0ix1V+FcI1J+Ed1KJVrnwpBRaM0B
 Gp5F6zyT9GlLkAVQYoNNeHSCQLPlonNraKqFiz7LOPvYEmuRJk/aOSFe/OKsFrmM2gp18e3Pd6L
 ZzKSsFkwS3UJHSIWSQlGOQEdpKwvAKsIaoIt7XG6OXaqk2Hn8OBhnfDnpXq6lniIH0FAITU3OH3
 ZkyqoYSCOjc4wjL8eccdDD2XDIKjbNDArAsz4nqbFGnBAdtnTByMnFLmIkWLSznaxdOThPO46w3
 Jstdxy3xGNqyMtDvY1A==
X-Proofpoint-Spam-Reason: safe

On Sun, Oct 18, 2026 at 08:23:58PM +0100, Srinivas Kandagatla wrote:
> The SoundWire IRQ was disabled before pm_runtime_force_suspend() but
> never re-enabled when the force suspend failed, leaving the codec
> unable to receive interrupts.
> 
> Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
