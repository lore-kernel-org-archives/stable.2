Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793790292;
	b=rHfwIpALIKIPdGg7wXL1ICMqhSdpqw0oxr5Pa/AwDUm1vBtHULAEZvR7mwvfrHjObkBm
	 M6nTIz/g02NTis/sNwszj04/Lk9k2/7RRr2/QzZib1BqJopVhJNTjBiEOMkbQrbHCTfn3
	 s4NOQQSdn+Sy3yzXwHv9ef7U753DtcMPodusBZiGsPPkmyQ49ITGnYqFYIX+bFLtBtnE0
	 J+/gtrf2l5Td9DukFCqYHL9+Huyh2whca/93QxUkGN9NksaKItEE8XtKyW6S7KKCjQf7i
	 ak6GRq5hzC6eeyVOal71/4DRzSNuVWut7pzxboPVxGxp7hZcDCxZ/DYNFrCXf6SOqhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790292;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Reason;
	bh=PkEau86gtLlBA+JmO89i8cA+oZbEdYdlHyf5EjpefkI=;
	b=rc/g62jSK1JYn+dKU/wIlptLG2oZVXZwA7BmuFe9NxMLxEtfjOn+HKh6qDxT12q3JZNG
	 P7fHjN8DH9B91PUkORPu47fe8gbuZi0n2/sIClC1bVp1bj1NY4N2R4vhWpsrz+VA8mZ7C
	 2aNP9rTgzaD4wUxiwhMIqV8J9WOqY9XINSIbqr/Ad4/PoEVsa4z2w8tUEm1+0eZ3gW00n
	 nlWYg2Y/yiQCW3/0BC2h1ywC9Sf4gjyXAEazz0Yb5NaNaJfHZIlsxuruP7onrJqd/d2mx
	 brXBp0qbr5bAb16Q5ONl9qBRlSCdLSSiuGcDzXVkS7u6GzWOPqctwHNWD2SSJCMQfVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=np0U95em;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=xho8Gefv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC3606A31B;
	Wed,  4 Nov 2026 11:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3EC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=np0U95em;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=xho8Gefv
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A440BLk2531264;
	Wed, 4 Nov 2026 05:04:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=PkEau86gtLlBA+JmO8
	9i8cA+oZbEdYdlHyf5EjpefkI=; b=np0U95emXhVSAbBR/GoMcpXwu/KFn6nPBS
	HIFoH29gyPkrbbrW34VxXT3FDhrRPDUJW9f434AtgVpTEMfdjunuzR6hcnQCUOda
	IoCufRbWuD2ntXDRTlmG3llbCycQeHfNoQeMInAkuRBELGdWemdIyPn+YD5rCIsS
	H8rxGdHU4cTSQBSmgmftSaXOUmcUAXMafRQ5j8UVXNpsYwrJZo4IqOmRDCRknukX
	vFzpwzJ+lWh/wdYy32WTMcRH31dY+akw0qrDYao9dJOIL1kRtMYUOx9yE/uiw1D4
	VZZnjEQUsdFWzbiOeoA0WE+Ja8pd+9XVcjC4wSt1tfGrTiGBIq0w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020120.outbound.protection.outlook.com [52.101.193.120])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hncrfwg1k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 05:04:35 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMzFVSISxiElSNhLqFg/ZjlvbgMJP84/eZLHy9SBKwmKCKbz09FcfwT6EuilljveY7ftQ9g99TAfF7SaErQ9nhCsDLx96828Xu7pEUqBGbi+Y7XvI3cQSalOHFz6AnEKpLaZcclsAqOVomZ0M3ymThdovKjXfGuyFVCcHuTSKJca9N9h7k/Zg88mOlyDJKwRJs9AG6HmVhtJaLM9gC0DpCFS593pomSRPhs/RwX2bq8qIjxmQsTHHRLcgcTAKnxb60+2x4sSWgKYPfGIFcgJmJ09R5BaGovNQw/wfOfpETL0woQNuo5UqprOCdUE1EzXwovp+OLGq9QvVARlQ2iHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkEau86gtLlBA+JmO89i8cA+oZbEdYdlHyf5EjpefkI=;
 b=gxWF78YPjAAv5ux+za6XovSoqW7Exfad8UNIkb5ulAAXw5WQon5DmFcKsTCaJio36QVjiQsGXPoPp4FeTPgwJOIZMMZCIsQ1xCiGuiCRR4ZPECYC6kvYy7KstdUD96sIQorUpwP3R67Q8EkLvJoWAHY3yaZtI5G5BhIJpJybQhJvEjd1YJXGi/+gIBdmSldiuKgKkc0QUznfCCqsXkrcCk+lPCUWrzejrC6+NZa/YTa6KGMiy0UA0GMwql8T8VGFE16lmQ0J3yOGYEN1PaigkvsFTmZuEBWxxhJujjl2FtzGx+afjgvY0MTFwQNYqBYWhtGPtlIYQwIRvVfUO3TZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkEau86gtLlBA+JmO89i8cA+oZbEdYdlHyf5EjpefkI=;
 b=xho8GefvJzdhLvBZMqfThEQ3E8FH3R4SML7Bm0NcxuXlZ8GLq//ZZCcuRbjeyvCakv+z0439CW+HHRpv36V7InXXmpdBdaa4m4W0EivYCKFDuJ8kxubD27qdR78xr2D2M9bY7jzeKI24KlG0HoUhjjAhy4aVn8m94mn9ez8jnWc=
Received: from PH0PR07CA0092.namprd07.prod.outlook.com (2603:10b6:510:4::7) by
 DS2PR19MB9078.namprd19.prod.outlook.com (2603:10b6:8:2af::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Wed, 4 Nov 2026 11:04:31 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:510:4:cafe::70) by PH0PR07CA0092.outlook.office365.com
 (2603:10b6:510:4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:04:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Wed, 4 Nov 2026 11:04:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EEE2C406544;
	Wed,  4 Nov 2026 11:04:27 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DB659820273;
	Wed,  4 Nov 2026 11:04:27 +0000 (UTC)
Date: Wed, 4 Nov 2026 11:04:26 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: david.rhodes@cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l43: leak MCLK when PLL enable fails on PRE_PMU
Message-ID: <ausROjYJJ2af1kXj@opensource.cirrus.com>
References: <20261104080257.1144-1-tangbin@cmss.chinamobile.com>
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
In-Reply-To: <20261104080257.1144-1-tangbin@cmss.chinamobile.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DS2PR19MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c170a9-1b26-4e64-c2aa-08df3a6365ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|61400799027|36860700016|82310400026|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	CtJ4tB1pwsH1qPfmtO7B1WQPR96dI+U+eDkXbXB/AvcX6Ahrlhy8rh2OA9phxYe+srCr6VA45A8Xwd+HWnQB9sNAyc2ZGhIbehMocLfzTdULhzuGeHKVgghqr1p6UfJIfUFNKf2QZth2kns58vAiuSbV8vTnFucbKqSF4OQ15HUoQ7zyqq1EcLzgTNjdg5EoLS1YJZC9O80PbTabN83bXbYDLDubYdPDziBBB4CnNvcrbWZ+fc7GWhn2k/JU9tT+ljpoele625o6InLWuheTY8C+wpMiEO5YQbxc9URRNxEPYHdalC7k9wT3eDZi7uH8bjKUJcEvol8OyfMmG6OAwv+ernL6TfJ97bAa3+/riZs0Ym2Lrfs0lbhn8yFAHlmync7w8ZNOrw8H+hn1qZV7iJ71tCV+iysv7dlh0PCBmHjlrCO2JFExgoHfZoCx744zJYxzghKYvRTA8TUnzjf4eRsmyqygc7UsZxd8e/prYNFm2Z11z7K5IqRHqFzcMOctazoidg/mfprNmcSZixCESYYeI9y7AjkAUzCmYbmL0X64AJ+nb2n6ziRp6zwg/u9dTa/jHncgJg//aE+KgseMHmAUVqdlfAEh5HK0OrusaVacEtX66fhdd5nM02JQWD0Wa5fa+PzQfgFCf39gzsfH1nB3SGwRB8lOc5GrI0fbkKrXN5kApngtGw/yi4tW64xdTMCHZ6tuYTH08njbdEuqcA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(61400799027)(36860700016)(82310400026)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0IIXemHLNLnc6oBHAMPrjY8CHnueqBlAnTtu4EsnNInUTPYReEv21dGUJ5wrbELtfJQTBCoOufkFzPF4Zksza33l1ZTEbftmgV9HBQTdHsFUJg2n/QCKfl5sPKOBDfw0XNEBK5nHx9Ag2tNjiY6eMPObCHF+kuz5pvc2fZUndeOUvJ5+kycuRE0Q18rU8OifUgoQokJYUZg4IpeN5snZV54xBfei8u50gkEBahtVZxgmzQ0AeypH39FUyPYG2pQz4qhXQM6xVFz6RIwAWozetnPRkFfESrQ+yWUXpHBwuCnw9RdAgvLtm2hDJ58prZNQavWFJjEq6voRB7+tKqdRHo+lX+Drms/NTPZKSsZB06ChGxSWCm+nJR6pTrwFHOUJY8Zuw16wgBJNiq/CBzsl7qGHTNE6EH5H78BbEUSnGPTf1lYEkS/Z+SkFm83w9UW2
X-Exchange-RoutingPolicyChecked:
	Jkcu2LW51ShtPthWyLVy0cQ0fUUYj//N6OAYCoXjhCMnFamu65tK+8ZCCRo5HSSayFeSoicw7Wf/o7kM6GbZQR1hZsFheYBlP6ZJilgQkQ8AgBwfQ8JJ2sB+pvqv+UoSPvUBatywplMMrVaP2oIM5uR2tI/973Jcf6XmWOVGw5GFzIOeEtoJiVFpflMFMHyzQxbmNtpyNAZ7DiOheKzjWM3ujwNq/rkWVeCHQaFcaRZtC7R1EVWlcI1ehuY5RUlQw2g2CvDK0i2sL0wv5IR5MfXPI7MFCn1s7MoGWd3JOYeeZDH0fzXQGFAyNnkVHghRpRiRDSfPdZIE4D46hIWaGA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:04:29.2874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c170a9-1b26-4e64-c2aa-08df3a6365ed
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0MyBTYWx0ZWRfX8+JIidHke07r
 4AQ0KwIjtMDe2Asi9+JkQh25TwhItH58fvD8vDG5yQm2huU7iZn4tCvwT5Jje2ezxGxofx22SUO
 rOUJR4DeF5VmbDBWaCmoyD49p2sZgSKKRXzZKee7aRIUzNYdnYorIMVq+E7o0+xJ+ViBvUDcNTp
 nY+2HsItEoWxrrYnjYDzKHOY19LJOmqI+CGNmFwejCtn0YqbWqifN2JlMAPxbZb5g+0Y9taBq1T
 ORY1cogDwAWfTbr1sr04xuvHZOwvYAJdhVlaZLFamJLq66L3WwSXkSLkB2AJmHmK0j6DbBSZrML
 yz2uhz718SErgILTza6Tq0BssuprC1qkAZ9/qRCdgIV+TYD7bLjvfZduVUNh/i4D/F4FCfQzBN2
 Yed/GS9Bp34d+D2G5XhjB91hhEbxT81/yWvj6Wr56jwdBz557aNb3g9kM2DPtQN4w+IgQp6HOc6
 Gn08GvsxIzWzRE2isNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0MyBTYWx0ZWRfX537hLx4C+944
 veGe3fPYpnxe3+csWQ+sYGgO+FWA27gqgdfGLpUu3r6ccxRpkE/IvuG4YZu1UXeG6scfxQYe+6I
 wdYNqfAg/2IDGchOeTWqzSWuJiC9U0Y=
X-Authority-Analysis: v=2.4 cv=LtgHWXdc c=1 sm=1 tr=0 ts=6aeb1143 cx=c_pps
 a=nzD6lsumb8VjuwgLTHIrqA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=nHwQJ6c27wit37Bziy8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: svN4gkRl_MQzLpMRd_5FO_2gC-8AJw7M
X-Proofpoint-ORIG-GUID: svN4gkRl_MQzLpMRd_5FO_2gC-8AJw7M
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 04, 2026 at 04:02:57PM +0800, Tang Bin wrote:
> cs42l43_pll_ev() PRE_PMU arm enables mclk (when refclk_src is MCLK) then
> calls cs42l43_enable_pll(). If PLL enable fails, ret is negative and DAPM
> does not power up the widget, so POST_PMD never runs and the matching
> clk_disable_unprepare(mclk) at line 1621 is skipped - mclk refcount leaked.
> Roll back the mclk enable on PLL failure.

Could you point to the relevant bits of the core code here? My
understanding is that DAPM mostly just carrys on in the case of
an error from an event handler, so I would not expect the
sequence to play out as you describe.

Thanks,
Charles
