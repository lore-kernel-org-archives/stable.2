Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793638885;
	b=vcMoR/yvVoV2+1FuMhpTsrh3ZJUK60U5JUJzyANG/GPF9D+zB+7hWviGEj88JnEi/h62
	 4X8wrILc7eVpIi7nWoGxliJvhF8/fehbL7bqscAZTXn3u2oRtcO6iBub2F5S9pgfdQRyt
	 g59a3ZXBlz36seDTqWIf22/mJWkIv+wFEucukNYkUoNZYEogDl3Hag6JD6+q6k5cv0Zua
	 iC+v6YJTx2BXvyimcjeQ401dNM6jW+A0E0psia5mvA182GKFkr5soBZJic40dHLTVazg/
	 OrMG3Uxj7QKTYLomhCPa1nY+CPt0RIrZP6rkWt9ZSbZd35AYIfJiceeKRzMVa5HC1aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638885;
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
	bh=NpTavxdZGTQUNEgppIkeQT9i//8sC5J2e1UmhARWRgw=;
	b=Cx397ieG2TFZ2XaTs4LnD70ySng1SgIkf2hhByhJ/l7k9spUqdLpLJgdfgElEIBk4K38
	 Z1Gb2f5hCoyMAlZHECV/dJhOiAj7VcXFcJrkh39Vi1q476o8yMTpvzC1beUQY5A/7bp0M
	 1+xD55bFkViJ5XykYsnMV/gSpTjuVyzIK7YKnHLPYyWsecPVQwNxKa82df4GZSHRvDauL
	 CamcMEKvJVxaT0JNkgTiqf33L6XPswAvZsC++/Ti2Zt8m1nCRme8xMjXnf5gdFQeHNk+k
	 IAZUIY7Z+uKgXzo2k1ObZjMXBJe7Her80MViFK96jp8jjCUkXvdOyG+ue+oaIAg8wjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=qTk0V8aP;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=0R7cL8PA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604E606A338;
	Mon,  2 Nov 2026 17:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A604E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=qTk0V8aP;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=0R7cL8PA
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2GRU7X3255947;
	Mon, 2 Nov 2026 11:00:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=NpTavxdZGTQUNEgppI
	keQT9i//8sC5J2e1UmhARWRgw=; b=qTk0V8aPKqkY/llxMQ9C+TrowG7PHST9DN
	I707O7syJyLHuOtHgFfDHh2d/P6MRFrzfao9ngWdAyykife4ksJLcw1BTWNZ3p7I
	6G2Igb2f/uHzq5WVoeXbcn1WhOp2jmN8ld6hGjV7bLjYNIVSiUa2fnQpUN7wvMAA
	F8ppOWA7PlxBNFXLgiX/NE9vPRR5vpkfZAGFcHD0eajX99sO16U5Dol9eEVTdI1H
	hwKCRsbFOSOdQIu4jn2X8KAaDtzh8DlqhF558NUcoPyBas8j+VSd/qzkSuIny13a
	SkIpxpcEkSCROucbW6copvlD8BJl677DCk+3EOBja92s5a5Er0Gg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022101.outbound.protection.outlook.com [40.107.209.101])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4hndrfa69s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 11:00:09 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBcBuv9GWAP9/ojqE86JVgBoaI4pHj1GuQO3CskkvuG3uSg4KZFmJCVeg9hboEdY5sw1JSwLf151fV58vOItZuNauNYxmlnviWJd+j2+GH6OWJEEKbItaHWYUUa8La4vSWtP01UsuBeZhZZ/AFm/hUqWHFf7FhKrIxNMEPcIYEXq6GtWoeM7iUvCDxDES4khX5RVmcUq7TR3d0ile13VfrK1KRbPuM99Q36pKJHYujFftIXKEUtpon/vL6OcNJrpfvk+ZrxAUWwhkcd/5FIHoQZpg5Pu1rs1T+MqAvKSvWbm0xk7r1Un/mRMl4vpyefievfCfL/efEA9k8yB73/ejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpTavxdZGTQUNEgppIkeQT9i//8sC5J2e1UmhARWRgw=;
 b=V4YXkOVIJDTNtR3LXx24c42guMwCMauTr+/8yg1FocpFJy3xzY986XIjFzYrdr1lNMkoYuJU0k4owDmP3XBQmwbBoX9HLLEtyn4Bl93+ArZdrb15ogIfZrV5L5vtnpYl4ZwvlV0EXUQZ7jF9KUOtcCD2EF9hVg8yBNccWW8EBA4cJvy22MluAYPUx59ZBvlpxyFn9fCFuZvfim2RC99rwYitUDz8OXLsbb/7DNmQ2nFq01/mXnMFKe46ohko59l3HFUvwSAvaxisxw6ECSBOdjvZoOgtiqWHeI7JF/n8QiW7plNgNiQVljKzVUTRPBhTyEYICHVYkAOgaT69pe6cRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpTavxdZGTQUNEgppIkeQT9i//8sC5J2e1UmhARWRgw=;
 b=0R7cL8PAyHE9V/KWMNkE1nLKVshb+muWEJeKeOSlIeeSZ4Gi/DusaOXJOLjVWTqtyvcwVxOo82CYHl7kLbX01dd6ealhOiH+lRPXiMM7JIktxWtfTpgRJ13Pw2DDn5wm6nJtDgNYbFJ5Db/uOsJm1eNVG1qMxGDi2b0wlnUllTY=
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by EAYPR19MB641908.namprd19.prod.outlook.com (2603:10b6:303:2db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:00:00 +0000
Received: from PH1PEPF00062F29.namprd02.prod.outlook.com
 (2603:10b6:510:2cd:cafe::2e) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 17:00:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 PH1PEPF00062F29.mail.protection.outlook.com (10.167.243.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 16:59:58 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7CE6740654E;
	Mon,  2 Nov 2026 16:59:57 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6AE7182026C;
	Mon,  2 Nov 2026 16:59:57 +0000 (UTC)
Date: Mon, 2 Nov 2026 16:59:56 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
        Margarita Olaya Cabrera <magi.olaya@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH v6 4/4] ASoC: wm8994: drain delayed works on remove and
 probe error
Message-ID: <aujBjKHOtcNugTGa@opensource.cirrus.com>
References: <20261102165340.1558853-1-tristmd@gmail.com>
 <20261102165340.1558853-5-tristmd@gmail.com>
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
In-Reply-To: <20261102165340.1558853-5-tristmd@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F29:EE_|EAYPR19MB641908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a88f33f-e4ac-4bdc-d91a-08df3902ba6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|61400799027|6133799003|10067099003|16102099003|261102123227099003|18002099003|22082099003|4143699003|261022105027099003|11063799006|261022075727099003|261026140227099003|261009223327099003|261009223027099003|261009221227099003|261009220027099003|261028144727099003|261009221727099003|56012099006|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	XTwy/mPeqnjIyA8lwNh15SWxNlLwYj2SEcvq5r8X6cZ8BJ6i9FfVkFgFQ1RA+jXcEmDlSfrKLtuMTX9k9TYbOna4m6oXbFIBuzdd7WkTc73k7sRRscGEA/l+DirthOnPBTUGsNyPJ0JIpRDy7qBGI0DVChhcrHmVxdwWLrlprG9ma7mj5I86Jw8y8AjOXIG5m8+KceC8bWGzQgqbsiGhluKVVtrwl1TJZfAvw4v7B8pWWD9gPR5pYPdyhT+5CmL193D6Xu+xcPckadl6nqR3IA2z59bLQCPoOOb5qgkEzizzUsJZkZNNvLiyQrUxWFuMI0AKOzw54UWhS2E3mQ0fHlRY2u34ddjptYrVpIQQHeT2XfDDhnNwhoFxZ8sou0z6zZyF2e1adJ1ldwVgDyYdYXTYY4MPnwMe53NV43uYvsQwZLqSUXkvFnTkx+F+9pfcoUlj2PQs+slFJ8Lxhpnoi0GEThjihxmoCKwX/45DjjiAxIpuECJ38LJHB2JLq5w84bu+4RwQZkE8dqUPo3asTopoA4sXwIRSwtx4piTbg4I3VSW1r5TuTboyp2SDz3pY0UEtp1p2iXNYf1Kbnm5PAuNqhQ2NkB8oqLvQT3ZvzFBD6r3SV4YyFJ3eKKkn57gADqHgbrKDDRb+OhBrYVAWlImIlz128NqBrkDWfP7j4v1A+WUJLMzZiJiiftbsU/TU8npvfaSw8bTVAqHQaEQF8Q==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(61400799027)(6133799003)(10067099003)(16102099003)(261102123227099003)(18002099003)(22082099003)(4143699003)(261022105027099003)(11063799006)(261022075727099003)(261026140227099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009220027099003)(261028144727099003)(261009221727099003)(56012099006)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bXo0bc/GYZLYcw/WMAknoBijvZxMA40lkbzoCoYUAYp/cEATpIguFMh+lDwAQ/WacuOC1l76MSF8F/dx3UAX7xsTmVT2iiJn6EGkkgAe9xEn59pZLleX0btQj3Y6ATJNML977LUfL84L24+QlYRr5TszoirmakPZaZBD8k6eHoJeknGs/OyQ9FFJVV+tuWYtCuN7u/UUny3GPmM436wsGIV9qLuR0l5zdIi39eu9eVoEId5BmaX3kR846ky6fTb8+nbsEl3OipSvF1rtHfDKln7HHEX/sMtbD6CmO8Y7rU49jRiP/oy2k/zI3/eiwG+MRLaRLd1GIpzA4cnVdbxaKZ7qEaimOdX9sTr/JCPf21PyJr8e0rZbkCaC+hMcRmAzLacQA+3JO6I6DDtOJMpZTX6GySa+5qXUNRFUENw1zEFtZVznhfk83XduQy5mrrjX
X-Exchange-RoutingPolicyChecked:
	TZdF8Nsc+wOGni2rCHQA/QNTuQQEVIW0DiSfeg4TvNeHeebBig8W7eneiJ6HXguITj50WfdZgsPAp18C18ob75gCn6+v0ozk79M3+Fqp3yUSQZcVMMheK139CYyvVokVzM5COp5eiPYR3G2cSl4BR7IZmeM9R/LRQRJasu6olKAMo8cQ6gCthxbQnlWRaa6GpkVxnyA9zm4TCMuLiziD09tUcvV97NWc4Q3tvftZTyGLnUl/Hqx8btVC345ejqxLqi4tYNbTUmWWL7yRN4NtkVOGlvoCeCiAlWmIU+i+SOLxo26vx1dqqR756VUI7hE1+Pe/AKVRsCKw02SP5I3NNQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:59:58.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a88f33f-e4ac-4bdc-d91a-08df3902ba6f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-PH1PEPF00062F29.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR19MB641908
X-Proofpoint-GUID: ADjVwg6bRNbjXVePqdITqVlowhCFob1h
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6ae8c19a cx=c_pps
 a=vWQ3mT+D5TKWrXkKqtKQhw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=J_-Nd1mkAAAA:8 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=bzuF_kAla84l5f9Gq6QA:9
 a=CjuIK1q_8ugA:10 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: ADjVwg6bRNbjXVePqdITqVlowhCFob1h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NyBTYWx0ZWRfX8NsE6EyZwuQZ
 PVkNn1Djkbi2dDnhXpjeyx2VG9iD4IMUgyrVZG5f9O7oW1fA/bf8l9jHn5zaMWabtukb27EQ2yw
 1DOETCpLFvmBEGFAFjAXIBPWq9BX0ChW5zP5itTtLBOzEyNJ011AImi4e0j9OpEN671jq+nSHzo
 9m6tq/MqKd+EVsuvKjpiJaGY3XWgWzO68xc3qvnANd7V1SNlV8b5gNiJOuYA1OfAXQ5GmdWn+PF
 ou8DxYLYJVp9i9oS1k73hWtFwwSsh475NFTWuX44LmtS6WZRVJCrOx6NW5Vm6+cYUt23QtCP/TU
 +/F+HRvZqhtiR54DYak0EYAKgrmEgFY7+X7IrRYyATibynf/NwHh8SIYsLM8GasnRlPiwKT8AO2
 2RaBLSdc1IbcUdz/HLJjku4vCMHIWLMPfaQNTxSYzgUY76OeI4lDL/YoDMHwoXUusQN7BjCoORx
 u69yNeVaquMi5UtJ0gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NyBTYWx0ZWRfX/WmQaIeLxkPe
 fAzFs4q9sbFReGyr4AiN/k32YtgiKbDUbnBlM/w7rtRWrsH3XZTl8v7LwXzvR+xTYMPpYJb7t4a
 CwmZHSlxIH091vhRFv2jlQXV6krCWR0=
X-Proofpoint-Spam-Reason: safe

On Mon, Nov 02, 2026 at 04:53:40PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> wm8994_component_probe() schedules several delayed works to handle jack
> detection and microphone status polling.  If the component is removed or
> probe fails after these works are scheduled, they can execute after
> resources are freed.
> 
> Cancel all pending delayed works in the error and removal paths.  Guard
> cancel_delayed_work_sync(&wm8994->mic_work) with a type check because
> INIT_DELAYED_WORK for mic_work only runs in the WM8994 and WM1811 code
> paths.
> 
> Cancel mic_work before and after jackdet_bootstrap because the two can
> re-arm each other: wm1811_mic_work() can re-arm jackdet_bootstrap
> through the DAPM power-up chain (force-enabling MICBIAS2 triggers
> clk_sys_event which queues jackdet_bootstrap), and
> wm1811_jackdet_bootstrap() detects a jack and ultimately queues
> mic_work.  The second mic_work cancel catches any re-arm from a
> jackdet_bootstrap handler that was in flight during the first cancel.
> 
> Fixes: 99af79dff5a6 ("ASoC: wm8994: Ensure we get a notification on startup for jackdet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
