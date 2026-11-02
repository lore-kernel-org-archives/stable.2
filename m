Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793629582;
	b=eLqUIeLyKimRJdqOqYufy017G1M/rkZYWMCLPH9PGzhRx9TKHTnv07C4+cO6XFcwqOgD
	 MHBjj0ml97zuYg65/9LiwTPzPAZ2fWD9KT1or19mntOATDk4mpSMc7x3/15k8T73d2jO4
	 GoqoZItS7jGzxkcCNNqFVwXQiVYE35lDPpZZStiA4Bt0JgP7kt1QdhPbgiGL5KxpAT05G
	 q0mKCjImBdOH7pqrS3aQKek5SX+GQimfZQHilZoumC87FdXThE2/a1ne5hqD/ErHYctB8
	 Aghyqg63i+uAQDqlPmt7b69A3unFxr62xx07+saCOLRXjvLqNuK4UzjHQbqU2boAbtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629582;
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
	bh=tWqozxyFrdFEt0XVxqE03dmjHUpPunMGDVo5iYeswY4=;
	b=p7MipSxPk9xcITOZeIk9byTnH/ctu8f2IelzOomo51pTsuzveK7AwIKMllLVAlYztb0K
	 85Hz/qqNyOUazQUFTVtpb1lFnDJliiuKHb5/kGBX1LrOQo4JZUdPnOV9b0vrku/keqIrB
	 kCnpQhZ1+7aw4J9P8i4d+q7Ik3pwPwEpOp1t842NYbH6knUgEPkJ+kggnLzy9/5UDUg6B
	 7cjZsobSL4S8i1W5SOAOWOAuu9Lc9qP1gBK6F3ltivzOefJCPYvNelPyxaAynWBKpT6XW
	 +4O9cy5dG4zOj753gih7/UUo/6eHOvjbjc6sNGhMD4tSdS/oxdviIf5mEM7442cgeuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=e11Ue3q5;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=dZ1UQcxo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A3606D817;
	Mon,  2 Nov 2026 14:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 488A3606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=e11Ue3q5;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=dZ1UQcxo
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EOWUA3054427;
	Mon, 2 Nov 2026 08:25:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=tWqozxyFrdFEt0XVxq
	E03dmjHUpPunMGDVo5iYeswY4=; b=e11Ue3q5GNuYEUfA85UIl7ikFRv3L+jYZo
	SrZ8ZIhtYmzpam9GtWtI4BMjYpk57ONx8dkO5v2xzzY53Tc5MmFVEs63zu23bqDF
	MxUJVQJDWfqTWEFt50+3K4T8YsxjyaBTSK3Up7RqqkzL1NACK+aPerhpcW6//Gfk
	5q0pWr1AGkWH7hvfOK24b1e/VB4sh6ZGmv9ELD/M0QYTUSzS+zzevGZTaHWSRGeA
	4HD+nrh4rV8AqHxfawv2XkeHW1jxdoQM7eU81qKkphYbMiu7G2+wQBaoi+cXjoK2
	y6Ed7eLadW2henScJH5SEqA/B/tJxqEWGOmCli1jsllMnnIT96Dw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022128.outbound.protection.outlook.com [40.93.195.128])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4hndrf9wgc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 08:25:21 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc2kWIETpwj0h8GUmcSBmnDL9u4Zg7KQC0J+Go1Wllu9l9dLC/NEMLQwptY3JeTmv6LTZF3/xLb8R7zRWA5ljr7CO5I+RCF4ngLVSLLxqSG/JUGTZm5PYtlkzcV/Mxr7NOX4CdUDVq5vduzu9yWdiK9xAp9wgX/2+5MYsKcCre7zK/dspOHcfvSajZipuaFfdcKIXt8NSA1k3TwYwFpqYxnnna8nFDMoXJ+245EkhwL/ddUmuGRUHXke0mmqY8XfT7lN8QEqO5jzbhKJKCWhQTTk8PQpW2zT6J2cNTo5SbFsmnc5QEOvjUaqXcL1psH20bM/ItJlxF2xKWGYWtL6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWqozxyFrdFEt0XVxqE03dmjHUpPunMGDVo5iYeswY4=;
 b=tW+qY3tuqS403rm4ToFXjQp6lx0ar+E0KjmtZ24rCbjNYoSJm92gyK2/xslfMDI98gbZQMcuDuh9QIrA8vU61VPICIYPeoh7kdSEdOe9xcEZ4Gqm3fff6fdG6oeds2RQF1gfxQrMoyiY1OV4+pmUmmebdFmcO68NSh49Mr0qOxScrrjqH/P4MhJtj4M+a4Xs0S1SXlR2szW6uI9JPmIh/ACeQfAtfXtDVQokTHIZUmLHEc4dJaoGBJAIBVQUzBCE4R9/Yp6mfYZMmKCIC6bRLp0BOEeLFCx8hSUy08mGHBC2ohV7vy7fbdKlUGUTSlvMWoCscaNz8wLk72XA+Go7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWqozxyFrdFEt0XVxqE03dmjHUpPunMGDVo5iYeswY4=;
 b=dZ1UQcxofHZlpriJNE4aEVvXxOQ7oCb0CnH38NegkeOV0cd5Y9YH4Z8db8fcvqi4jV3IHDbkMr3uyw/MO7DVHjU4ZkTuEjnqCHDvYNGYssU0GE4NRpP4QqRvU/Gkchup0Pf9Zn3oswh3BsGehdQgODUPutMhTnav+X4I9X1+hqs=
Received: from CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::23)
 by DM6PR19MB3755.namprd19.prod.outlook.com (2603:10b6:5:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:25:15 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:610:1f2:cafe::50) by CH5P221CA0022.outlook.office365.com
 (2603:10b6:610:1f2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 14:25:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 14:25:15 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BB431406544;
	Mon,  2 Nov 2026 14:25:13 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 99347820273;
	Mon,  2 Nov 2026 14:25:13 +0000 (UTC)
Date: Mon, 2 Nov 2026 14:25:12 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ASoC: wm8994: drain delayed works on remove and
 probe error
Message-ID: <auidSMrWVmT8cW2u@opensource.cirrus.com>
References: <20261030170416.1839402-5-tristmd@gmail.com>
 <auhdJGbYnY95tJBS@opensource.cirrus.com>
 <6ae87c48.eabad26b.28ae48.d5ab@mx.google.com>
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
In-Reply-To: <6ae87c48.eabad26b.28ae48.d5ab@mx.google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|DM6PR19MB3755:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0fe751-8341-4cc7-f659-08df38ed1cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|61400799027|6133799003|10067099003|22082099003|16102099003|18002099003|56012099006|11063799006|4143699003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	H9Oa4ZyUYzhGvwQ3ztoHC2OHHtiiheWzdnhnoXW61tha1W/OXQ1sLPe5ce9cOQxYLJlr7nEZrbbLrDwpp9+ugMKrr5R8yFZr9p0ovGGofhlu3LjMxdB6YH4BjwQKeifPq2nQowPNdYZORnZ1kYTL2JFJ06d7KdhTyWlLS/gooj+C2T6stUqKXb7uF6fFVECR2C6LEGJQzFvyfBUHi8xdhes0DKAy4H0Iy9k9gp9rw3mDKs/s8pMhTxd2xXbam/PZl3xRZrjGRE0ApLHyWUuvQgVEDzzPWc6biVRT+kiVV81mGIF4IkhbIUCwUZYJFP6ZToUMqsZDzEoDAT/hyBUbAXlo5kVdDpkCcuS2SMLCbPVoTUh7W6V6Yr2FFu5x2RnYKmitoG5w0bueuPwA4VQarbKtzJjS19QO0YtdeAedSZX6YZ4kOBdgkDWMv6gL5Lqc2KsIvko3Uv50bSwdLcZEGqrlud41bzq89518xUC0ZRmMW/FUV5Ks88C+HSQxwREOHKyyT+5J2+Bun5TJRMQt5dmMAu6v1JAImEmYBKBuUJRGXNg0aybiIu1368g/zHiUE06xSt9lCizMw70T6N0XFsD1+ExPNj4g+yjDml5+Eg0rbr1ais8jO5v+md5YgrIe8Fyw2bKLn22xVSehcMW0kxTRwIjU2X5HUvpPogL+lvgc4/ZgAp+KrXy9F7A2US/8erbp5XzhW1HQBon2X1oMhg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(61400799027)(6133799003)(10067099003)(22082099003)(16102099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jCJH2mJ/BRLbApaxiVHj/HA0dPKSK4O8aw3Iq5IKOnQU4I5TiWLwpnwluKlMcU9O5qSvvAGwk3t4P3jnKhJehzxDSQabQpkiKHh9R0o6e7k5YsG1bWyFGpB8P+4HI8rJ78Uwt3nm7aR21dSZHs0blO9PmtpEkvaKItMAnZ3LpUMOaRY19jA87p8Ep0NI/Rde0f3/2cvonT6E0Vj+l9FSWniXy4ZgLPfaqHUB5NNSEREsBJ+vpQLMOKNWmTajDnr+GTDXyaXnAsHF3D8oXHaJL8NokYRY10dVtCz9llhK3OE9M2VUhLMGr+Sf5p/Na5lOx4R8STQdGQOTzMqbFdA4jbyHsQ25UAM2Bsh4myVcEDCn6a54M/nbAhTr39CDtcooTlAP43Mxxuk9bZeAbtmQpz0vj25tlEkMYN53Z4lSTH5+gaDT8aI020PAlBIPIZrC
X-Exchange-RoutingPolicyChecked:
	lOi+Bb4Bmhe4lU58HmDAjZrf+YfiAF7wdk5YJmtQodbvWHAt4+41YJWoX7UBUFQus9JrQ04/LSwb9NlJ9yMFSVkNDqppklx4Yuib2qyeJj7T0lcfS4yWGIjLixjNWwyLfBgniTm0dvDIeHtL7RlVsN4GLq7VhTa48anTnAx5wibB5RESysrS5N65M2K0DyjqtntLr+2bQlZxeG9DvK7bKXlOkgCCbFPHtlAtfOOOdf8GPNae7gTfqCSz+jAkhRBkWbMm6QZNZqLgEta//LCZPd7CyUQHVsB5AvlHnxIGZdA0XDekCfuiaqHaMAQOF9bOncbgbVwxKjqyU/uS0NvbBw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:25:15.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0fe751-8341-4cc7-f659-08df38ed1cd9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3755
X-Proofpoint-GUID: T89DtutAddZyMwniePjvYoy9CURTf_uK
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6ae89d51 cx=c_pps
 a=+WkigaN7fx4UYWmYucrQAQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=pSIma_B1SM4golTAR9AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: T89DtutAddZyMwniePjvYoy9CURTf_uK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX3B/QKfQJr6/8
 sSL9ohJ+1d6xd2Hf9Z5ZsLEXVUHmepkNqn+Xw1KMAkjAXGuU8qNFbCyq5AButbqi0apnEUIODTk
 iOhrnYYi9XIbOi8xenALE/sfgD4BNwXEeFe320Z3z33N3PTA/7V2RVLDw77Nq5+vm2Bb2qgCFnZ
 mMv53u/BrJIjZj+LSkSyfOnKwtJI9qs4AE5kwL9dc9IkuA1GQ3+ZF9rMHXsUVYAvCl7/7VPsQBv
 fivMHZEILjnP4WCUzTkLk57pZvmWUbysZLRHSvePKYfBulPn1O+48zhxPD7gjVO8leUHvN5Y4ON
 Q2hZcvJtKqg+IjPF84Ni5F+wmwm2hGeYdyuPbZGdyuJBFyGjTXbo2+uHzzhyXViwEV32I2uxsRM
 S+A4xV/oRdFm3rxlbklgNeNgF/5+6iSn9zZVNk8p+sLYJ5z5snV8ZLHTud3iDQRlxa41nDmbKiZ
 83k0vCh8YhXGaAsU2Rg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX+dizXFwCOg6R
 f69xPNBsjAUEzK22FL5/uYZvibkh6MlN9DC3GgKHAJ91rNSsEEz3dss/Po4N3/AxNZJxkFWtyg8
 FliK1qSQMWRdSKCkd6gdQuEgE/3mBTk=
X-Proofpoint-Spam-Reason: safe

On Mon, Nov 02, 2026 at 01:04:24PM +0100, Tristan Madani wrote:
> On Mon, 2 Nov 2026 at 09:51:32 +0000, Charles Keepax wrote:
> > Both paths appears to cancel the mic_work twice?
> 
> Yes, intentional.  wm1811_mic_work() can re-arm jackdet_bootstrap
> through the DAPM power-up chain (force-enabling MICBIAS2 triggers
> clk_sys_event which queues jackdet_bootstrap), and
> wm1811_jackdet_bootstrap() ultimately queues mic_work back.
> 
> So the sequence is:
> 
>   1. cancel mic_work           -- drain whatever is pending
>   2. cancel jackdet_bootstrap  -- drain; if its handler was in flight
>                                   during (1) it may have re-queued
>                                   mic_work
>   3. cancel mic_work           -- catch that re-arm
> 
> Without the second mic_work cancel, a jackdet_bootstrap handler
> running concurrently with step 1 can slip a mic_work re-queue in
> between steps 1 and 2, and that work fires after resources are freed.

:-) I see, I think would be good to add a comment in the code for
that.

Thanks,
Charles
