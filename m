Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF46485508;
	Mon, 19 Oct 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398971; cv=fail; b=nNH08ipzwO6lgrfQJsonp46ZjJX9Cgx5enNxRVQquw6ERs0pzDHu6/Tnm77J3F21nHVArp+ypfjmPY6a4+xcof/D4jxi16nhyf5LmqnZW8+w5Y7tV0eyQOjLHUwgx+3sPrQ49+M8bPiI7v+FE5s0W4l+vzpQaZgRLP4fBt6g2xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398971; c=relaxed/simple;
	bh=6xjIpB63KuwN8kBvE8Vd37UZT55KRBDLvmFtC07AR68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7BiWFY4hbs0S/EX042/7wkYarNwFTTE24Eu59Bq5CrleztZm9W/3UK3iOcNtuLo8G6eSoAq49SsD8jB4UVAkW2+f1+0TXrtvTZDH6YLptHdNMhsOK9Uz4Hgakg0bs4jt2FEONm9wRYnqxALcJkFuNcZMUBEZiGW1sAQUVl6gjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=X4WC+g9V; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=KXKulwUL; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="X4WC+g9V";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="KXKulwUL"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J5qW7O3213457;
	Mon, 19 Oct 2026 03:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=acpgoR+mTZ6H3QBgbWx+tqOC15ajJ4XCcj+XiOiZojc=; b=
	X4WC+g9V81iFG6eXEUExJrHVYzfaj/8UwozPvSq2eSmPucw4bW2vuIEl1kzlOtLa
	dDkX7ixFGxL4CUBXcL/LhNd9nFbwzawovtnvz7LExNi5OH+w/Y74LEo7mUBsJ+Ta
	q4GgkIydSqCO/21ZunUssz32YML7/jdsg+e848i667lX2wR30FCfI9mcqxv8KCgo
	yGUBwhLgjdGSTQLy8iT9jw/qlmywUOyatiVyoU/LuWpSKxnH6PbnXsq9ql2QfASG
	RA4QsgB9IoDTW6UPskLKLoJZbolDwOODB93tdkYPEs3gQ3xnKDpnWfxv8F3Kmg1/
	tnSXrmThscOfaHXpTy1zfw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022142.outbound.protection.outlook.com [40.93.195.142])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4hcpts128t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 03:35:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oz5VAv68RdMO4j2Xn6JW2oPDeqYewmzSISqQLpt4uKWHfFnlAMIVFnWB5an2FokXIr+xim9/ffqhXmi9LfkIPSOktsOMtUOeC+AlozYmL6NsaRl3n3vbIFC5ULEOumC1L6kceAJip6STIxYKO23tS+db3qulop3i5farYH7zyM7J3hzFtu4zo0ffAmQlsFeah+LKcWNMSJztBd/sVIUxnRxz3sJG1fjZz7AczuwCquIeATfCvP/USkcjHoYfumAix3dAjZIqZXt0m+qrSnKjguRw72iLoaIYmYheES+qVGoFjTIBgSOT2LjJNqFDMSuaBWV4sOkg9WhP4VG/8QFLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acpgoR+mTZ6H3QBgbWx+tqOC15ajJ4XCcj+XiOiZojc=;
 b=oLF6XLKeBlusxPGFJGzPmBAsa+M5VFYvrUHNO+yI/hxmiNY53hF7RuE0hHGF2ViQIYK6Lin2uAWJFlVoFgULHgE45GGj2tgX64qQ5NACooSsZiKMUQcTBqP8cFYOUlfDy+doQyOfYZMs1ig9fUJsxcVXAK7GtHIXZlHl/jTiBFPTb1TPwzCtsjLI1IYn2Aee81FYYP0p5OplXchiqXU7m5USlMOYbF+IhO4af1R4K+39l0Gtm3rBcjpdtHr1GXcH7AkFmkZCKc44I5YX4CWioHMuxM60/6XCSBJaX7J7HY1BCVCmDm+ZW7thpBt2pLSj1csv/YIV5fxjVF05K2+ivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acpgoR+mTZ6H3QBgbWx+tqOC15ajJ4XCcj+XiOiZojc=;
 b=KXKulwULgTla50lfpmTF+f0SNzkq3jCIap1j3oWhfGaakMcfF8ROrnbXG16XnmUNWXFOlKHLGFgUX+3Jg70k3m7gMUz7sfK3J2qupmJeNbrXzxmze7QVcCc/obvsU6yRLmCl0YKZc3g85FbZB8iul6jVxHDfSjLerSBsFeYt17A=
Received: from SJ0PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:33f::30)
 by DS3PR19MB9222.namprd19.prod.outlook.com (2603:10b6:8:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:33:48 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5e) by SJ0PR05CA0055.outlook.office365.com
 (2603:10b6:a03:33f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 08:33:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 19 Oct 2026 08:33:47 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AE76B406540;
	Mon, 19 Oct 2026 08:33:45 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 91995822556;
	Mon, 19 Oct 2026 08:33:45 +0000 (UTC)
Message-ID: <ed897167-5a7e-4d1b-a76b-efc5bbb60e79@opensource.cirrus.com>
Date: Mon, 19 Oct 2026 09:33:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 7.2.11] ASoC: sdw_utils: cs35l56-ot25 DAI not
 registered, no sound card
To: Connor Stevens <ooglie05@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, broonie@kernel.org, sashal@kernel.org
References: <CAF50T1myMs2LSPUsTAPKyJutxzqQihyxbY3=iVGpxenRbnXxKQ@mail.gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CAF50T1myMs2LSPUsTAPKyJutxzqQihyxbY3=iVGpxenRbnXxKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|DS3PR19MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d9a323-5730-42f2-2c10-08df2dbbb1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|61400799027|18002099003|22082099003|16102099003|13003099007|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	15EVymUh+Zfw5TCA+7Fupta9TwqIXvQMMk6TmuGSqBnEZrVexlm/zAiNCJllBeDqL+SzC8ICNMGnO941eKwPB0wOU0tFSKO/wTL8KyUTqs9sUKeQp1hOmIhfpSqeKqKLEEvn2oUEqAnWD7cW1/d+MGT2H4plL4WdC0z7g+1yUUA7Xp4Cypw4A3bY52bY59CUk7hS4m4OKeX+lvXkdSA9rlkMj7bPD3Y/kaxFFUT+KK5M+kyUQUlPV5VH1V7klE8uAeY5xNA6DZoAGX0LK/u+2wkvvgzTRRWxJ/vtCm4B6qYzl7t1AjZlSfM1hSkDwS36afj7yZlCPTjjUcKNBdmk7dOyDJEa+WHSTDbKCtumzzaBJm0ec9MqfQTtKgUDros74HENNPFKFfgvnY6l/DvMxk0NCg4UvEAJhGuy1ii5Q4/R6BO2iGAzvT8ZG7agFIHw0pY+uJ/ywqE693/Bv5m4vDhPB0DMlfnK4sW1U4NUAqNFONWFoSzHAiTLAeFYWJyaDB+0vFPWkL6sl2k6cpMkEy1Na05X6WpQa/ADbi9jGyw1CIXX0EJ/H4mLCyT02dM8B7WYjJDBMNoCMhiuaqkjRKJuyYvLTEMgspWmo2EtoasiRBFgQnJqhPDMEEQrhj5n+Dqx+b810rylRG1E+Pf0KA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(61400799027)(18002099003)(22082099003)(16102099003)(13003099007)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AO3nWU0YaxYGppBdPtbsOGLCIq78x37j41QgHQO+zpvH5dLzlgSZDtkUFgYgIsTqvCcmJUlwp30PiKPokOrPNLPcfyZaLMxWakeiCe7aK74EAwvPjTB0QHY8adhqcseRbmN41WRZ1U9A/hfsInwMpW+0NE8o/901HURURPTDqIkTZyoof47Qys1P+cqCxYc7T6xsYDN3aiwI311YeIVllFDmGkmbZXQoH7NGUO76bSe8FoL6JHYsrB1RKvZrISvKtnZD7xEY4XlBqidRJ7KDQTldoXB3112GE+y5dcmGmYMWEFwS0Od+l0cj11auCbbHnvEHsSALrgH15VdQLGyHqM29TiZJEY/MbFLAVyfEhDHCV1Qkm7sWkcU2BQUb/fFkc4Vtp+uc3kOl2LgYwoCb6CrP8BW4ZK+CtTgjY75bwwI19KjoSrx7K/Aawcex928h
X-Exchange-RoutingPolicyChecked:
	tGRfFzAxcDGBVc66Skek5dwWZVAkI4IAp2dwdye986Ag/jLcgT5e5QfVxHqhN7zTvJrtzDtSHGttonBQA59P/Fc9UmwY1VJLb3TR+T66/okbmv4E82m250Kzn9uNLUYKxtq52sLGbETZRrFytwxPvQ6viIR05XQ1VTrkqimvVuEscUC9J2GRAHKT+wZZUcE+oIHDWep8zFKVfuoI0w1+Us0YjarGy+jWqlSOtcXYBnFmJpR93PoSqGnWPHfj1O5qfa0hCFKrsjqjq3a7CX2CqgTsVOoMSrzQFe29zR2divL4vPgH6M7xxFRuXWlbhsvpc0+kmx8htyYJ4hbibWhkkw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:33:47.0443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d9a323-5730-42f2-2c10-08df2dbbb1b7
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9222
X-Authority-Analysis: v=2.4 cv=QM391QLL c=1 sm=1 tr=0 ts=6ad5d66a cx=c_pps
 a=JRl+IjCvVGCyytsd+wv0WQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=2UBwMtoTQ2vo7Y6c5O8A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: su6Xt669zJELwM0R83Yn3G2pNmC-j_ml
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMyBTYWx0ZWRfX5GLEH+bHS3N5
 iY8GIWYAuqA0qnrRMHfTlZkctEriY3r+eib2VCRonUEnlnHlCV9MMixrPWYxW14S61xHUN924+g
 yWTKBNQ5a/TsO3SYHrfdZ+3x+W9Gysg=
X-Proofpoint-GUID: su6Xt669zJELwM0R83Yn3G2pNmC-j_ml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMyBTYWx0ZWRfXw8Asl0mfMyHA
 vE/m59IwoOx7gp2nNyMhJ15lmnE966PFg2ZYvhG2pR41GqStzP1gtGDTpYOXE88uIeXqZRoOgiA
 JEup97BsP7RK78iLI4Z2fmQuS319B/74pUBEii46mqrLS6VhgY23gXSybdXbP2VO72L3XFbERkA
 uv1MyeuR8CUnQIwbvubqExuqWXpe8RX4+Sb4hT1u9G6noE40CvQpFHDlQI+DTBBGa9OEBXtWa1y
 73BeY6Qy69xMAC0PyJRQwcxniSbaXYEclpGqi4pfRIqxh2l7o8Vc4LgPuYOPHAMwgYKs+4rhDSr
 3f5CrVFx+8so1hRysLC+iC+AoQ5PotbthSlLzsEq/y9TQkGF1NJRlKpRAjZgo6yssWEi7gvDGDq
 kKnlVOa5gCnw/x7UES5e2TcKC8ay2XNDVsMr/kuOD5iPgryD+BQEjPiI03HV1lFg+DaI4TTI8P8
 XwSu6cKTCS9gNuJPYpA==
X-Proofpoint-Spam-Reason: safe

On 18/10/2026 11:41 pm, Connor Stevens wrote:
> Hi,
> 
> Since 7.2.11 the sound card is missing on a Dell XPS 14 DA14260 (Panther
> Lake, subsystem 1028:0db9, CS35L57 amps on SoundWire):
> 
>    sof_sdw sof_sdw: ASoC: CODEC DAI cs35l56-ot25 not registered

Already 
reported:https://lore.kernel.org/linux-sound/20261005155235.1386525-1-rf@opensource.cirrus.com/T/#m420ea27d936f1fd9cec79c988120a11caa8d428e
