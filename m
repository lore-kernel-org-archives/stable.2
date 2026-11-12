Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794492199;
	b=Buc5j0PHdSHHUVnRANxGxElePLSWmWG/Lxc+yon3Ydh7YouZcNt5Ce8Ykc6qPVNWD+wA
	 Ly3ZJBR5WKj8MA0lKH03LlFbtiGpYwHTo1HRGZ2AvVcPguQqLoA5Evs6Y8BHxSYlwSWqG
	 HrayJv7aJ2rfjneBo3dJJt7ote8I6j5ISKj89PhkdOKczOpMXyFGJk5YsAs+bckOm3PoT
	 3i9mwAGl4Qu14ZLZmIOEfClYJA4LuFVGf5gZYKt1CIvBpD7k7mk+uJEb6rAoGOsYJoAIo
	 vNqE1jyoIMyIM4nmlzeq7zWWmoZ6H6QaOwA7Cnx289o/0Nw5Uj/wJPZ4hCByri4jHEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492199;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:From:To:Cc:References:In-Reply-To:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:Thread-Index:Content-Language:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Reason;
	bh=kP+nmvQp703kICG7ycAXIDv0lm23eYXjZLcpnZSqOKM=;
	b=J75y7C/9gdblcPPUm6JXBTFbPGAB2wQ87GjBKFBkfXQLu3o8RcdLGNqams18RDsXWUnW
	 05R7U1z0vc02YyFAChsXICJB8JREhuRJhUYiI61xo3PcSx6fwUNItM+zG8AmYrIo6HvRv
	 pIlHGRUe2tA4tCPeigp+h/++X6Befj92Mdkq4EiDCm6wFtGwbLupwCEBkXYAniKot+PQY
	 FFCFFxdgk7ZTL6/pYKYdIAGcO1FwK9CMH7SpmV/crr1qF32Yvvpo7BCTiCVL2aHK0wiBc
	 Gjgp6zu4Ymv7OGpuCtUz1SyPwZXVTkYx9Cvs91fFxbXekUE/57bE1ycVxD5nw+qLd+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=Hz5OlDdM;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=oTphrwCv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1474606C735;
	Thu, 12 Nov 2026 14:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1474606C735
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=Hz5OlDdM;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=oTphrwCv
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACCg4vV967484;
	Thu, 12 Nov 2026 08:03:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=kP+nmvQp703kICG7ycAXIDv0lm23eYXjZLcpnZSqOKM=; b=
	Hz5OlDdMpsdWdsDtW0qMHF4tW8/nEJdYwIfNuSzFH/9+Hoyd1Xdrr5HJNZIjmGZ3
	iVOAY3b6ZQ2K7z6mb9I+Kgc1pPvjbgPyYv1+tQumhJsae9b2/jNiTNiOm0Vs66sa
	V9XsT1nlMj3rvwZH5AiRcLTFn3nPueYaNxaWT+RwXIcmfwnYyHlW/7eLHJcnToHF
	0oeeDmUO3DOMQcbvRLHwD/4WqxFXaoAAb1kshSEdi+pvbCVDmmGzwSYK9aLNTkpX
	Zy+XBzdaMkXlg9Q87MrIHKTa7TryVlsQgXa6Ri8seHTQs73bF4tEakeDQmvtzTSG
	xlQS3VSxn/OwmId9T4ZeVQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021129.outbound.protection.outlook.com [52.101.57.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4hv7rfb936-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 08:03:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOSfaGCMj+60AQebUE22L4jtTwuNcjgErvMFC/aMF5fOcACLZd6O1NZD17x/R7pJPb9ISNUUAXTxTe6Bv/m0u/83WmGaPop25NsWq6ptDFV9eTPyV/RFO/PGGbUzrUuh6/kMCiiM5R9goXAkRLpL8C0whQSeJlXV/ZvI7aSJDIkWE90oVup4kf0iIMMTKWAhLkVN++OrA9Gw1OLLtFlpjJsEylf8Hp8pDOO2FWyEgIykt7PP5ahGr4lFyVBOwacNuZ6fwY4hAbKR8tBDJ+hv3pVBnzdW0qcp44EwHII5lsmO1sAcnJoXCSE310hsuvbNiPazz7Th6M/zs/t+M0f72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP+nmvQp703kICG7ycAXIDv0lm23eYXjZLcpnZSqOKM=;
 b=sfIWLQ/HkrLM/3/4bZthpMoMOWS/d7LJWaHFFKyxcgEmGXfFm9Z1Ah3W1GwmbE4YMnVyAfdBN7RyRfDe1HvOK50F1BD42EdLyqPYmK0zmQm5pUmg+XGqtUvkioetDEueRox5QO2xFkjLa2TXfow8RJK71w7vptj4RFsL7j86DvWSca84XYL1im02h6dxfOhNgzLP9Pj7yxg5CpSVteoP6wgi5QUTNLZsS6dYu+bTlDh5rBulhNKMdEQykCxLi+ux8Jz2jENh60Q3D5BUQJ/SUgJJ7IAFeAWWh5u25OsjKwXDGRi9qbmwlNNuPmPhmOXqw6L/NXPMyYyih1I9gBFIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP+nmvQp703kICG7ycAXIDv0lm23eYXjZLcpnZSqOKM=;
 b=oTphrwCvU4Q6lhtIXAUgsB/IV485mHsYEj4K2T+HSZSfg4h7hZ4Q2X73xPamo0W+lXgcNrEFh2DmEDJBQtG5giSSdPKqqQ0VOJ+w4nJd3Pek93PyoXnzThINBi1JZ1XuTtjZ18AtIkFHbrT1XL62sfwZK4GbApcn0jYUy63s3AI=
Received: from BLAPR03CA0040.namprd03.prod.outlook.com (2603:10b6:208:32d::15)
 by DS0PR19MB7839.namprd19.prod.outlook.com (2603:10b6:8:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:02:48 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::62) by BLAPR03CA0040.outlook.office365.com
 (2603:10b6:208:32d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Thu,
 12 Nov 2026 14:02:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Thu, 12 Nov 2026 14:02:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 974C0406555;
	Thu, 12 Nov 2026 14:02:45 +0000 (UTC)
Received: from LONNCK4V044 (LONNCK4V044.ad.cirrus.com [198.61.68.159])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 49005820273;
	Thu, 12 Nov 2026 14:02:45 +0000 (UTC)
From: "Stefan Binding \(Opensource\)" <sbinding@opensource.cirrus.com>
To: <alban.kernel@gmail.com>, "'David Rhodes'" <david.rhodes@cirrus.com>,
        "'Richard Fitzgerald'" <rf@opensource.cirrus.com>,
        "'Jaroslav Kysela'" <perex@perex.cz>,
        "'Takashi Iwai'" <tiwai@suse.com>
Cc: <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261111-cs35l41-freezable-fw-load-v1-1-ebcaf549b2f7@gmail.com>
In-Reply-To: <20261111-cs35l41-freezable-fw-load-v1-1-ebcaf549b2f7@gmail.com>
Subject: RE: [PATCH] ALSA: hda: cs35l41: Fix hibernation deadlock with the firmware reload
Date: Thu, 12 Nov 2026 14:02:44 -0000
Message-ID: <006d01dd72ae$7e02eda0$7a08c8e0$@opensource.cirrus.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKtw1tloDEKjXOyqLDfVjzxR4alc7WJpdrg
Content-Language: en-gb
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|DS0PR19MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6af006-4108-42da-659c-08df40c5a18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|61400799027|82310400026|376014|11063799006|56012099006|16102099003|18002099003|22082099003|6133799003|10067099003|261009223027099003|261021123027099003|261028144727099003|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261022115727099003|3023799007|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	hxz04u1NrwHfPfu7nVwuNzL9ZaNv+PguhsxnCZHIRLBILEcin0QE7diWGpotVBEQsg6inLVlJzY5YbKaMoINuVtIrcbRvhXRbt6qOWdrwLnPKtteAM7/j0sFJK6+2Xwvsgk9QroM+aEAYMAUszRyJbCiVrf0ANOpl764dyhFb9D1APTyB6Bw56NB4RD/nR2RwB839EWNa6EudzhBdRAhRHqHZG2uu8ey/HyQvF2g+yTlEckTZUDhwtElVi784E3sJdJgUqD9cxfuSC0vDZLe2T9BMSS0m5LZSvKIF8CEQd1po6K0PGTU15CgpKBbyMV/P5UJL3p+Xdjiz1ljSkzbGKKYx/eTmKrkAKu1SAzRvJvwzJxM/Ze8+igO/MOcLQLcTfhwUCS7UC+f8frP5XsPuJBZpchRoNzodykLTRf3s1GjvYfUscw2gJgI74uCY7SOby3yr3PihQhkHNVlpyaohdgslkxdU31guWYkikUfDqsAvzCH2gdgZGFCBrUkb4cyv9QaVU1ZyqmG5+L2pBQYRYF72xsP9udwyjo4RtlGKp7Chpl5EFeRunNce3/UTsWw5tQEFgWuBi2JmC0SKWyV+SU/HmOWkMEAofK06820UigM3+BTGI0Y+m5qRZ93vUmcZ2WdSEQHIYMe+vCUioymOV/kIS3FYQvsubPG5wdCIKw62mfFXGff+weaYl5Ni2FOigeD5sxz7Lyv078Umju8YQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(61400799027)(82310400026)(376014)(11063799006)(56012099006)(16102099003)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261021123027099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261022115727099003)(3023799007)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aT1E/up2IacLXJaTPHe0RUKbPbG4Z6jbQxKdp4uWjYrMO5/3e7K+CEr1UwoLgDuGgPoAKAl0z9891ft8N79tyqn+LB6m5jtHZneljCCMKt49mbaCr9SA+FKqFARzoiaaDJvkgIOr8TUGQRVy+Pyi72MnsJfgEPcKczzwcE70f1P8xcfrVhnb1TQXvQjZxrXPOso99gPhX3d/DanQbj3uzoSK1ZEBA7G6MZF5D07KLd7IeX/lyYUX9dtCp/XBu1/k9F7DAOyv+UK/YaWqMpBWjN4XCzpGb8HgEUYG002HNEWjDYt06ECaNvJfEGj2TppL/pC/WrhRCe2tGDE3myXDEOdqdwsud1YU7VabFXo0h3Is5a1YxhCXmSXRN1C5uyGQnb2tPwNT271FagpRT29WOJYmruG2Ev8jes4+DfAAP8TZ8Pm8Any92J5Kd5VB4ffu
X-Exchange-RoutingPolicyChecked:
	qGPQr9qSFBaIKuzUcDKZx8zZX8bJdjgBDz9tdGlLCd8c/ARel0q7hS7wkQKTwJRg8YXhItoVKitL+nCqIk5iEJhcGr8+f4fu4qg1edupq+XJnWOCQPF+paXbLMHrmKUUZtHIIJCE5lXXgez7LnXQtg9xmFexn0LILx9aXyRTvLA41pMSSvdVsjJsd3xrVtZNOZn8LDp9mDTCuESdTb6BF1L6OZNcO/2K6jYqj2jyMvzTgKQ/yphbhEdFBYu5AOCCLdZi6BUzsUufUiKygIua3vtzmJ1vdwk+xeTgpiFPqvAcwDgqREicd6LR0Mr6N+yrFVwqsAMfLDDTFy5PsphdmQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:02:46.8922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6af006-4108-42da-659c-08df40c5a18b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7839
X-Proofpoint-GUID: D68c9eZw_Pd6IiUoBImpM7iJfckMqXyZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfXysP5zI0RA8tZ
 DCCA8In1eHgwGCN0Q5W0vFq0WnH886dwkKmSqXA7Se9RXF6RQS2QZ9PxKnOR0NK/Jl90VybOWEn
 NMpZgEMVn4wSKk4MV+FdhDuTFKjZ9Lo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX4o4bvgtYO8Bp
 KiVBCvLgNO50dW3LRsSRYe42CqsH0flUOEeOVa2h/Jktog+4vXc21WPVTgvtXJVaQBQ/WOJfzEb
 4qRFgu25w1QNPMmhQ9C5xlwzWf/1txGedbngwLCHNQe9yWs4TBoDs9QrvMhtUwwbXsbGraQ2zyr
 SsQjCSKMuIkduL48jCPOba8s72tfY0x9ui+uIqxJALTJwEAvXMnN5wYCnKRhLAzRhirpTJQswut
 Y0In5B1wkSOOCgZtvVFel+OgwYxRHRSyPNfZwMpOZipMkZLab0AkbQL5UvMR9B9E/ebxE9NAtWr
 hfa9s+prA7en+g9jzu9kgeMMSTq36FmTsVxIz0a7sdQGW6t0UT0P366Sle5t7uMFGRsyZKNMBym
 9uNSr6HzcLgDro4Z6Vx4TeFULl33p8yBKH+sJIhf06EXfSWVXKr2TTsgVJFVcifUxBfIp17pYJt
 9O2oLT+GUlsLaYoXq6g==
X-Authority-Analysis: v=2.4 cv=I6Hw19gg c=1 sm=1 tr=0 ts=6af5c716 cx=c_pps
 a=0kdhZxwYHPUST2xGnFlr3w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=iox4zFpeAAAA:8 a=pGLkceISAAAA:8
 a=t_rf1SEEQty20o9znuwA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: D68c9eZw_Pd6IiUoBImpM7iJfckMqXyZ
X-Proofpoint-Spam-Reason: safe

Hi,

I've been looking into the same issue (alongside another issue system =
suspend Issue).
Whilst I agree that this work item needs to be moved to the freezable =
workqueue,
I think there are a few more loose ends in the driver that need to be =
addressed as well.

I have a larger chain of patches to fix a couple of system suspend =
issues in CS35L41
HDA Driver - including this issue - coming.

Thanks,
Stefan

> -----Original Message-----
> From: Alban Munari via B4 Relay
> <devnull+alban.kernel.gmail.com@kernel.org>
> Sent: Wednesday, November 11, 2026 8:25 PM
> To: David Rhodes <david.rhodes@cirrus.com>; Richard Fitzgerald
> <rf@opensource.cirrus.com>; Jaroslav Kysela <perex@perex.cz>; Takashi =
Iwai
> <tiwai@suse.com>; Stefan Binding <sbinding@opensource.cirrus.com>
> Cc: linux-sound@vger.kernel.org; patches@opensource.cirrus.com; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Alban Munari
> <alban.kernel@gmail.com>
> Subject: [PATCH] ALSA: hda: cs35l41: Fix hibernation deadlock with the
> firmware reload
>=20
> From: Alban Munari <alban.kernel@gmail.com>
>=20
> cs35l41_system_resume() is also the .thaw and .restore callback, and =
it
> schedules fw_load_work on system_wq. During hibernation, .thaw runs =
right
> after the snapshot is created, while tasks and freezable workqueues =
stay
> frozen until the system powers off. The work calls
> request_firmware() with fw_mutex held. When the firmware files are not
> cached, the lookup waits for filesystem I/O whose completion runs on a
> freezable workqueue (btrfs completes reads on its endio workqueues, =
which
> are WQ_FREEZABLE), so it never returns. The next step of hibernation =
then
> waits for fw_mutex in cs35l41_system_suspend_prep(), and the machine
> stays on after the image has been written.
>=20
> Blocked tasks on an ASUS ROG Strix G17 (G713PI) after the image was =
saved,
> from SysRq-W:
>=20
>   task:systemd-sleep state:D
>    __mutex_lock.constprop.0
>    cs35l41_system_suspend_prep [snd_hda_scodec_cs35l41]
>    dpm_prepare
>    dpm_suspend_start
>    hibernation_platform_enter
>    hibernate.cold
>=20
>   task:kworker/15:2 state:D
>   Workqueue: events cs35l41_fw_load_work [snd_hda_scodec_cs35l41]
>    bit_wait_io
>    read_extent_buffer_pages [btrfs]
>    btrfs_lookup [btrfs]
>    path_openat
>    kernel_read_file_from_path_initns
>    fw_get_filesystem_firmware
>    _request_firmware
>    cs35l41_request_firmware_file [snd_hda_scodec_cs35l41]
>    cs35l41_smart_amp [snd_hda_scodec_cs35l41]
>    cs35l41_fw_load_work [snd_hda_scodec_cs35l41]
>=20
> Queue the work on system_freezable_wq. After .thaw it then stays =
pending
> until the system powers off, and on resume it runs once tasks are =
thawed and
> the firmware files can be read.
>=20
> Fixes: 88672826e2a4 ("ALSA: hda: cs35l41: Support System Suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alban Munari <alban.kernel@gmail.com>
> ---
> Testing: ASUS ROG Strix G17 (G713PI), two CS35L41 amplifiers =
(CSC3551),
> 7.2.14-zen1 with this change applied. Before it, every hibernation =
since
> 2026-11-02 left the machine on after writing the image; with it, three
> hibernations powered off, on mains and on battery, and both amplifiers
> reloaded their firmware about one second after tasks restarted. =
Without the
> change, setting "L0 DSP1 Firmware Load" and "R0 DSP1 Firmware Load"
> to off before hibernating also avoided the hang. On sound/for-next the
> change was build-tested only.
>=20
> AI assistance: the fix was developed in an interactive session with =
Claude Code
> (Claude Opus 5.5, Anthropic). The model read the journals and the =
kernel
> source, proposed hypotheses and experiments, decoded the pm_trace =
value
> and the pstore records, and wrote the change, the changelog and these =
notes.
> I directed the investigation with a troubleshooting procedure I wrote =
for the
> assistant (research before experiments, one variable per test), =
supplied the
> observations, ran every experiment on the machine, reviewed the change =
and
> tested it as described above.
> ---
>  sound/hda/codecs/side-codecs/cs35l41_hda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c
> b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> index 6fbc194d3347..efe937d18330 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> @@ -1012,7 +1012,7 @@ static int cs35l41_system_resume(struct device
> *dev)
>=20
>  	if (cs35l41->request_fw_load && !cs35l41->fw_request_ongoing) {
>  		cs35l41->fw_request_ongoing =3D true;
> -		schedule_work(&cs35l41->fw_load_work);
> +		queue_work(system_freezable_wq, &cs35l41-
> >fw_load_work);
>  	}
>=20
>  	return ret;
>=20
> ---
> base-commit: 291d8707fa439ed4ec72552e7770177f6b6514e4
> change-id: 20261111-cs35l41-freezable-fw-load-c9542cf8bda7
>=20
> Best regards,
> --
> Alban Munari <alban.kernel@gmail.com>
>=20
>=20


