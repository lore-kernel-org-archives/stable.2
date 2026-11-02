Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793615455;
	b=3k+QbufAXRNTCswOTgYtMAHPESJagWNdUKZkWLA32VYJZ7l+mfDfYmFl5nKZHfr4272s
	 //BNKwJeS0zJMnlKq5FaUab1A9EiIsnuDd5l0AXEqZUhxER3T0xY1SEfI23v9BGpzU+g8
	 BhLHibweYrI5gqhk52jbGSrqOQJZ9OU6tFIDBa0TXIH8phmsqDzxF5PZENRjlMaueGljC
	 Z91VQI7/KPU+woGaN+Ov1lPd7+juiXNRD5fg5VIgrvznmNKCA7iYgbmsbpSotgwW1QHHL
	 1v2NbGJLXYE+LAuZCtP1gID22Wm+fqn5bdIjSWNr/fzLAXWk51o+fTjtM4zY2ry1+uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615455;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Reason;
	bh=NwBHbYaOVZBXMqNQx1fs1BsxOhf9/4qyYew/cPy2zgo=;
	b=Q+lEQDfTZbz/UhivIXOZtRF8W590pt+i6xSg+9Hu3F4tjPxjNWdDZUUr5YZ0559/uBLs
	 xqEAzMlsSO6TJyJXhelgJOp1o4FP3RJI+2o9fKOCa5ApNBufTerfnjg+XdPjV0osqDDdd
	 LMHyUXngaDc9P9sRwObbO7N8x01j37cTmh3lz5R+p3GqdwJsWTMVJx5DdoxdOp2Kcn9em
	 8DWos+zKNOpIwRsha/CWgoiVEkkIc39lLrz5DTXM5+o15paJRDYRMlXpsbhrT7vK9I5Fz
	 5HaV1bEfGB3M9IM6k1KA7Ik3sv6EzqgMq+tvh56pwdWArDpDnvXHw4/hpgg9ARVw1Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=XIHvZMfa;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=uO+NcpWb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322D606A324;
	Mon,  2 Nov 2026 10:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8322D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=XIHvZMfa;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=uO+NcpWb
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28L0dT2468838;
	Mon, 2 Nov 2026 04:30:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=NwBHbYaOVZBXMqNQx1
	fs1BsxOhf9/4qyYew/cPy2zgo=; b=XIHvZMfaNZ5XMgKn2gueCbLINoGlAx/Iq9
	HWCnGPNFf+FtF3Ax4i2U/FfUP5kXOVYCZj1ivJK+TNw12QtSKYqaSKZ9gjLYhUaR
	uoEJrPtN2qzmYgMrdJTZrdHuHVAGxmTHlauJFHL0XJCIbBUaAXXz+WRYEN3ddrir
	gv4G4TEHOgMhxi0FsAC9TAkz9RrM5x80MewkjRKWHbUBvXnQGQ1XBfBLhmjCMWM5
	LjlIhBLT+XwFFEq1XKMuH4z+LtKj/iOXQzqBGIERp03rxrM2FPQUO6EPlVnTa8mV
	bfg2L6mUODhKtj9cwmHYiPoy20WNdBqdEP7phAgdfW8WYgqkgRJw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020113.outbound.protection.outlook.com [52.101.46.113])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4hndrf9pat-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 04:30:30 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVClPGL/ueL8dbHE9lB/Y8q5qfC8uoi2R3uBVW8gosGEEpwNGfcBZxcvWx5BNlfwEMVcWSeALBz5vFKVsC6m0ILTuXMl+ZW1Rm5t3eq6XtGw1bWzFrSIbfmUR1F0yM4eGqZaNmvG221pU7INH8qQ+T8IKKQm6ZxmnJ5h7RqYLgmKfsTzHxGVV+r9/bczOo0tETtbG6ESC4JwpdQgTwGFpCxNpMRiDCVIIJe1XAJmCBBLgIu0o/ETRjYB4m1GlNWI+RYNnQWGYk+ntAAeykKZsZ+baSJ62ODU+hBkoulg23oNWz9D+TZZ+4sY4TySsqGZgPOz0tuUqR+rNQ4pWL6XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwBHbYaOVZBXMqNQx1fs1BsxOhf9/4qyYew/cPy2zgo=;
 b=c9JUlOGaqhIybk8zm8n+2K0xf7fFpe6tMXcoEVcPAV6Iw2AYqQs0LnWDvRyLurQYts/EmojCQo4KQPXLe2Sc/g+Rd3KCDOP+AjsXHd1Bj5L6arVN4aAk2W5BHt/Wuk/eUBq//yANu+fi3FTuyhmlrdafz/J+n8oiQctqgStUrMcxAkpEKHuZbwxljAYxiIlLCTdsf8QV0LFKg1aNuI6tnyXE2dN+ISmTqLrO02cETp4Ij12z1VcpTapIPNIPIb0rEmT0pIoEJHl6Qe0bBjjhAOCnjjlgGs0dMx6lcR2azJZ9r8nP4LFzufsdhuCYt9FnwIBWcshQ9YILzSDkKpBhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwBHbYaOVZBXMqNQx1fs1BsxOhf9/4qyYew/cPy2zgo=;
 b=uO+NcpWbwHqlobGsPlGZc6uRS6mXmOQoDJuP01P2Ix/c1pPwkvtMrkX85UxxRl2RwcRwYhHgRECyiOxFat2w6XanCovN6LfbHCroCc68+42uTM9HGIN/sEaq/a15U85AOnBYWapIVx9yeRLKT088hTd9XHKb/5o4AgI99a7ds4w=
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by PH9PR19MB086256.namprd19.prod.outlook.com (2603:10b6:510:3f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:28:26 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::35) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 10:28:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 10:28:25 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C5BF3406544;
	Mon,  2 Nov 2026 10:28:23 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AB9E082026C;
	Mon,  2 Nov 2026 10:28:23 +0000 (UTC)
Date: Mon, 2 Nov 2026 10:28:22 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Brian Austin <brian.austin@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l36: Handle zero sysclk frequency
Message-ID: <auhlxorxXDKeV6dg@opensource.cirrus.com>
References: <20261030142637.415971-1-a.kazinsky@ideco.ru>
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
In-Reply-To: <20261030142637.415971-1-a.kazinsky@ideco.ru>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|PH9PR19MB086256:EE_
X-MS-Office365-Filtering-Correlation-Id: df67cfcc-1ab6-474f-ec1d-08df38cc0718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|61400799027|82310400026|376014|36860700016|261022105027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	5vAH+NnrTRTnnC8nfjs9QDe4cCIhqcLepcfw5HlNEVy+/8M3EXRuYVXTHlU9nl2F7hF7LizhQ2yevV5jxbTazpSuw+tewUlca0JquvZAFp1gj97jjD0L9/zMLkIi7NUwO8H0F1szXPhWl1lVCudyo1PuUycToFFUGJN0YYe7HDEqabB6r83bAeZLPE/u+28Lw1GWXfHqGst21Vqt3JPr8v2ed4jMv8NGBAc99hRvB12SGVAVrmiEZjrnk4BEcarO9qC6Kmk2GWbhl2noYXSZ+LtJWaG6zfzYyZxxKv+8TxO/6X4gSFpo7gVEirGailzCf2JC63rHZHMKkCFWQPRlgM2fwLYqSnMWlhug17zyQzPZkPlP+4cHa4DwBLQkNmYqxE/v5ghhSJI8JE1bkEqoIgMPb+kX5Glu1BpBYujwPDtVycdkH5jpHu8Ur/cBkGhFuZ3T6DfrUjxgJmV/OKidyCR/e14whirfk1rXgvp5ECAkA6fdYxQP+dPgWuuxWyrZb5sGPXnole5gxnDaXw/FvPLKwbOwYXXJmk7VIR7pBuH9LQizaFoc5twDRtyhkmIC/nlzfeuqF9BKZhTzQOsJ4qDhOFsrUBoMy5ZscwEl26L7PFUi16wHqKGxQiGWwAYmqCaO6niv8sJDfnvknn3ZcpLxJj8X09+i797D/jgik9U3cv9ExYuPtNXuk33OGF/C8/hEYM5J5Mj/r+U+McQ6RQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(61400799027)(82310400026)(376014)(36860700016)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k7XxGYquTfsoVELbSr2YlQRCAqK+IKcM1aqgUcB4RB9WxAO0mmb/m5gZ1UEMk9Xrsc6Jei7CtJ/fmpjFbk3Ty61rmCEF5UHfYCoyk8hbkemAb+mWLWBDj+PtfcWi8IybSO0gE1UpasuPSh8U3jBitE4WI1fpFWWX6HS8QFlta2SEvlk+lPmU13Ftb+vRlSCKN7WdsOAxciilNKkMZOPkvkOMCCXwY598LK6LL6HgctJjUzNbM4ZAxiSwpJS1XWaSVNl+72JlhN73UQsPtncoO+wWuVc+83i/fUZs8Qr9MZOXHHdttgCq1sKvamZ9RNhVmrkmb/ZOwRsTHhWd5Tc424S1cKVF3pvGLFm7eLzmBOpQeOPJ/Dsi2sjC2zpIKwP+3IMt8/pS+YomuJoUkLlZUEm8J4X83ubJ6twQcL1TWaalx0BrBDU55Iq2/VY8Wko6
X-Exchange-RoutingPolicyChecked:
	vWzIYR/J+o6DQVYz3Fcow5RjwtRe/hmCb9JkLcPhEFzfPELJufNQnVIUzX0sdFHsmMzMYWL7HF7Wgg3LsmS3NSnn5++mOTQQ7ArS+L98d5Dpcg1AlUrfJ7+mKCDnIHEZGVwlpaJztLYUmDctpchMTek18c4/LtdY1GsccBByR9jxVXPlTIhvz2R9w+5+30cUwSNrGQUgZK2dsP5hviBNsYWIOWL/JrE83o5sp9ISNms67lTFFzBsZRUSLI/LLrKgp0/Ki2R6JfbNiTOgkX1n6sQSaGlDzMAckXelO130IxuhqmiKfet+QfZ9fascmWqzmQJbmkfFdtCPdd2o8JSosQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:28:25.1318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df67cfcc-1ab6-474f-ec1d-08df38cc0718
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR19MB086256
X-Proofpoint-GUID: ra6LeDU732wJjyZEUW7HyP1Q4qQqOa0I
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6ae86646 cx=c_pps
 a=K4Uj+CE6H5eOf29xRfO2cw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=qR8kI7lcAAAA:8 a=w1d2syhTAAAA:8
 a=Fes1kecUIcmg1ffA56oA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=6zj99eTjNMTg5e1S657Q:22
X-Proofpoint-ORIG-GUID: ra6LeDU732wJjyZEUW7HyP1Q4qQqOa0I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX71NZHeuL5289
 fhXEfEO4OD2o2MM2XvEoUy+7V9HdYCYnagMzl+X1WYt2HQ1LmE6zoYaBZyRl/vpx/2K6qsGhBJy
 W72RgwhkS83X6hMpgMgeq2YgQ71/iMUYqk6wwx8VLu02IV7kRgPRZiVSYku0hE2EWOh7IC1gZem
 pZfNrK6yN8ACMOeS/tKT3qTiVZpChhs1WagRoBmyN4zXCNMUs5WIuint87Eg8zjBgOyMQqzB2yo
 Axu9xiVs2RpXyS7moSOaEAluOO5t8PMigZAp+v/ktpcIkD5pi969xfpTJLvAWCgZH41x4iUH9oW
 LNmwpWqbsy8cttCvnnd2z1hQ0fMVwMmFRZy0nvFRCNXPXsKTxkL3LDDrXda3hnkqGzte5vaQwAu
 2Wu3A+oC8DOGtKrMokH3a+zs0sqwM6B5bWpZkUkIMjNJo97kkgZuEL2bJahzam/HcFwEReGrLG1
 FJwSJwIHj9I+SxXsp8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX03IC5ia2VGTU
 Z5DeIFXM82Z4QTQP3UjHKrCpMziOSZDm+Inb0bw2ErnyRux9Nsr8NxAkFhieScMEKSHWPGpU8hf
 sqSvN/w6sql0JVNfX01JLZt/KHgrLVo=
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 30, 2026 at 06:26:36PM +0400, Alex Kazinsky wrote:
> simple_util_shutdown() calls snd_soc_dai_set_sysclk() with a zero
> frequency when mclk-fs is configured, the clock is not fixed and the
> last active stream on the DAI is closed.
> 
> cs35l36_dai_set_sysclk() passes this frequency to DIV_ROUND_UP() when
> calculating the FS monitor windows, resulting in division by zero.
> 
> Return success without updating the FS monitor windows when the
> frequency is zero, as there is no running clock to monitor.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> static analysis tool.
> 
> Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
