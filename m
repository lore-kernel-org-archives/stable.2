Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326347;
	b=o9lXfikTNgCxD6roq//zArzPSpIs5cD8Gm72sHV/fiPxyfVSjTPgw47g1D51BvBmMHcx
	 elV0Gzlzzj9L5AEhBqWDO/OMkLqQ7lyut3RlzzYiTGE4MlnCymLFxc2aj4ODfvmX9iDnH
	 lIqSvn3PwrBwu5nhbJ/4/73dAVtto/n80VoxqtzAJbAEs2mXsas+miDuYetmHkFBMjM+j
	 TXMp67kp56HjkT3ewMnBK20/e8/Lz2r51wIvx4y1xcY/DeObSk0BBBJXH6BTN8FSwUZn0
	 GlwHuW0yI2kVwbtbiT/+Jep2EA4KqFFZEsJwG9RW2I5UixTBK2fgUoVhm3aO4GpyZSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3yqs=;
	b=sG3pwOq0GkOoHTLVCea8hlRhaTfHrpmB+C7eQ7NrZVBID/xgIvzVXii6Z2OnYn8IKZ7f
	 gh+tl7p7g7+/IgRcjc3t/34Sw8TPKtKsSnzU8P9RxkMrbDwqVoEZEt8QvL+BOivZIc/sD
	 ZfEZiUqMeOre3W2XVFFZeTqRK/s5QAJyslpLmjOvrFk4eSydFVKx3ZZnLntKduaYA/76z
	 nV/kaEZtN+q1whiWBSjg9Szk9SKlynWRclrMclNGIzoVOsYoIlFIXhZU0F0AovFq+ZI+0
	 Q9TNQzReF0cKnFCuHZam/7MBYXCDmLkhpBla5V3rg8gDlwi8kTmtlFz8jGti0BBdTDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=U4rZeDGf;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=J5MOoX6k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A96606A320;
	Tue, 10 Nov 2026 15:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A96606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=U4rZeDGf;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=J5MOoX6k
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AAEw6dS2016043;
	Tue, 10 Nov 2026 09:58:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3y
	qs=; b=U4rZeDGfYoV/aVRomFbdZ4P9jy5zFs1YeyJ13XBWPMYbKc7SemGlYLs1c
	7l6qO2xSxIMWYCtl5thAo30Ho7Z145GgXQD4QFMdw/H93vz6WvoxWFQ1zfENWTjU
	Lyv0E60KbsQKNan2XBmeoDufI5MmWqaQI0Ud4u7ZX/t0pmZhFlK2l75ygDoKYMs/
	l4ZrjLXdLEbmmVRm7lK+F4aDCwNdoR4mc3f+DicrRI2KIAG4TxqTTAhIx92UJ3yw
	nNHf8p5j1FT5lFNwUZLXt2IoGnbsjJnm3yyzx5JbVw2JCU3v2l1xEel5v+V3Fcl3
	+vOVp+cW3avzuuvOMUDjvFfYkeSDw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	by m0380145.ppops.net (PPS) with ESMTPS id 4huxnx2r40-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:58:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIAKIuyv3YaOG3xX4MCE4l+RBNW3ZJrvipv8o09zc6/JL8WToUa8IlppHEpk/fLDasmbtditgLv8dr/PrRJ/x7yXW26NigQJBCcN6BU7DKAvR/QfQHf9kkSKv8OXgD4xqfU+MgQF/quOl+fztpiz+LGFNxRi81aVQY8r55P4zCWvmVk4R9GJeC4k55ORkQmH1bAHmBbOzv8rTg8EEluHkuTUUeK1rxa7MyRT7ucY5Cpx4K7cRYaFA0ie/bE6dWd2SsnoNZGFblsrTRyRJLhwTL6t5Ro965gj4g6XhKjhSI2XOJ/TUoMSZgOYtR7TNszXn9roj4FnbyAF6s6ZJURwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3yqs=;
 b=ldPt2qUBMmL0aNAN1KHPRWtLZVwcGeE4tZUO+Zi2vPrFb47fCXJBFadd+H0QqBZ9DCEDvjKmttk/x1r0c+pCpx1lNzVlKxVn4xsJzfCGMPUtvlqA10RzNUJDehPRQFJWW87VUlHu2zUsgNs+KUIdO9l5Bba1Vr1us1pgh1BcRLeak35CX2xbH7MFV/7BMgZ1DFu5y5gz4BmP7Xq1vzvUMs+CP6enssosXybnckgg4lEnbShcmAHIs0jMgrROK3X8SnAbBIShMRv6UDuzt+KsYxroqazeHO6/YE3rQZfumssHhZ8VpFe7TJDgcaO80m/jxb5aD94RcxkEm6alBaI3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3yqs=;
 b=J5MOoX6kaX6Gbd3QjR3V1H5ZgL3kn6bPh5Rg9e9mtoPqh2yM5qS8DObRvFqdddiwsPMN+Cu53kgRs+c7opEBYvBsESN0QMetYCuTk+JhGjE/odpGvhtefPm7aV4U3woyaUNHZFCo+tNjMFXmCsRPiC9Yuzfh6IFQ2Je1rj+oVcM=
Received: from CY8PR10CA0039.namprd10.prod.outlook.com (2603:10b6:930:4b::26)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 15:58:54 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::a3) by CY8PR10CA0039.outlook.office365.com
 (2603:10b6:930:4b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:58:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 15:58:52 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 09:58:14 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 09:58:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 09:58:14 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAFwDIU1079577;
	Tue, 10 Nov 2026 09:58:13 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <sebastian.fricke@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Brandon Brnich
	<b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v7 2/4] media: imagination: e5010: Fix clk never enabled without CONFIG_PM
Date: Tue, 10 Nov 2026 09:58:08 -0600
Message-ID: <20261110155810.18521-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110155810.18521-1-b-brnich@ti.com>
References: <20261110155810.18521-1-b-brnich@ti.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|MW4PR10MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c956dc-7f70-4740-bf81-08df3f438487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|261026121527099003|261028144727099003|261102123227099003|261021135927099003|261009223027099003|56012099006|261022115727099003|261021121427099003|261026140227099003|261022075727099003|261022105027099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zUcCdloLoopC+pDWTGXPIbHDHCXnu6lYi/Ftna65Kapjy31yrno247IUFY7vra/usBoj8zv0b7FiB2BghtuNP3Lionc02Zsh+GTLsfRmhMQx31wLu1mRz5J0a1RmBy9oXMfiwlLe5Mqakg+xOjtVrne3ZMd3MqdExjIemHy5gmBaiEEPJ9+oXCcAGUg2vkZJe9cPgWcHeJsvmRP6V2rKqGpYl+yx0k2/j9Xk/41vTQ64O0AUMnAPtSe9SaywMQzVu8iHpUNN+ZwSdJi4XgeAO+mrxTFIjtSJCpHVLVAhDcZ7MIOADDE2o35sWIjYUSkOJlONC3zjyzVskb2Z07WdNgOEXf6vZKQk+2RwnPsBDrjC/3KjbOxVcxw6npq5D0daamjPygSJ2ll9n6zhMrTcartDNC1eF2E6uYaoEUQ4LL1fhcTcmKlornJPPZuheG9y4pJbWpSse3kXKo1yryUWIF4tNrl30YqCKvTdsFl8+F3pqD2fi0l2YJ0woGiY2pJbJutIYEokbQQnTRF+TeE16DO1+WAe9G+JNrsCM4N9RuRFO6Ma49JRgDlMXfw3t+E5zAAGEN4vMnlPLbnTrqIO4haEJpOf4m658foWX4vNkkiin7Jgo7oZuW5k5zcEQid+o/XjzcaJqJjfZR7qdbejnSMRrN5oiWUbQTDhgkBKTSM0C8LuyPmusIXWwobPyVOkP0R40riVYyZ0bOxrwtrh0g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261026121527099003)(261028144727099003)(261102123227099003)(261021135927099003)(261009223027099003)(56012099006)(261022115727099003)(261021121427099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ERbKTorv75D85691+obyykYXdAPcPGDXXOJFICjV/844a1WrsVLS2AuTrpZL5RXLhWC+/MDJGS30pKof5SzRkGzuU+AAPW151cY3rHsR6hduEQ9F67Ycld+9pYZXyP3ZWQ9ITTFAt/HECk0hZq1068wW2ZWmwvSefThPAStr3u4fCNeQ+WxC06EZZjMZmN16ipxp1XVD1Z0r3xbTLdkaW9sqafuyhW5Q5Q63lx1OFOtxIeZQQEQNOC91xV4c1U+yqiD8KRrJkevWc6bRMbNsyWuZgb7GPkPD3+gc8eG2AIT9JDtVbQjM1tLdE6XnlkW1mVdHWg3EPAQelCGrFHz9rxEo3gwgQfmCD8MBE+iAAUvrGwezyE0iUkNJtocBdxtuEJ9yj99E/Dy1eXoBeOYQmWLYbd8VhDxGzXwWEWH/TypLnRoC77RQH0PpGlwqeM4D
X-Exchange-RoutingPolicyChecked:
	MapWbve8/TemyL11ldT57DmA0/1kqSB17s/H7+sH4+FhvKQiZRhbCKiRZwl65XyPO0+1FeoZSVqEYs9zH5228XUnaHPWGEUhf9TvbugWokKzqI/EApEYplGJEnLCMyrNpNGBrqDQDFjHO255239alUs0nmxmgRq/2OSzr18saG7QPPaBQWrrjBbGIzY58PBFc/57LahHc8PlwJlxZ2AT54VloOKn33cy35TJdeK0E3fi87/+6l20gj5mPpV4VFHqv0Gt+4v+g0PuTl1UOyJWrgaNadwX68WwBK/W2XXpWava6DobuUXeHkVP0hQDvmjqBawhAlxr+xUEK3yMPZ5XnA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:58:52.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c956dc-7f70-4740-bf81-08df3f438487
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-ORIG-GUID: YYh9Y95u_lp9Lj6pGHBJVhkieDjsIqi-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MyBTYWx0ZWRfX6X6V/4zRXn4d
 6GymUwB9PHOGAZLK8SV+v5ro6kYNh+ciIjst+fHzFaVBfj32IzPIo76RckHcFTH0t+yFgDqjYHe
 TGkavVM6GhrvqKj6PAgcrIpg4M+nGMA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MyBTYWx0ZWRfX2MyUJlYHFCOk
 v7b8lhXSEviU31JWjflo7H+QnlJmWSwZKa43reoxZbFnmKUPUSy+D13SRTBWWi43bWW708c9eyc
 5zMKdNit9QT3GjoXGJfGNk7m6wuCZkVTj27UDggiqJI0G/MQsFphi5TWZa1sHk1g4lzDZiyW/nH
 pbrFnWbV5P/A5sfYmULT5ieyGQkgJRIvLa54CXWRtsxrI7a0a/4fvJMVeVMuVhbdSi2nPphf370
 UyvQLwLOSbayZDrNviDGKulbeuZxvrK2DooUZBzcRDWZqwhfH6Rm+IijpiTQpJjjfg21DA1d31V
 Bt3A/fOxqtPgPSW60yNQ9hPwAOv9nnFYp3MgmvL0RM4H3OGAloUrYZpujBQGdbWd0XHBvxnO4R9
 a+4BDwYXJ1xEIyBBkgg9OUEAfVevNw9XAlVo6PPIqWDNBCFAnDmKx89f3JeYdz3J9ZD5l4Gz1Xm
 8ODpIvOxurGo70VINOQ==
X-Proofpoint-GUID: YYh9Y95u_lp9Lj6pGHBJVhkieDjsIqi-
X-Authority-Analysis: v=2.4 cv=b4cncdGx c=1 sm=1 tr=0 ts=6af33f43 cx=c_pps
 a=OJmONvCW+i+0F2OUQkAdQg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=-BWrc3HdS1PG3WIIs5UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100063

clk_prepare_enable is not called anywhere unless CONFIG_PM is set. This
means without CONFIG_PM, the JPEG Encoder will not function properly.

Add this call during the probe sequence to properly configure the device.
If video_registration fails after clk is enabled, clk would be left on.
Make a label to cover this case.

Update e5010_remove to ensure that clock is getting disabled in the case
where e5010 was not suspended when remove gets called.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../platform/imagination/e5010-jpeg-enc.c     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 23d06709a6929..17ea616ff1795 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1101,10 +1101,18 @@ static int e5010_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	if (!pm_runtime_enabled(dev)) {
+		ret = clk_prepare_enable(e5010->clk);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to enable clock\n");
+			goto fail_after_v4l2_m2m_init;
+		}
+	}
+
 	ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register video device\n");
-		goto fail_after_v4l2_m2m_init;
+		goto fail_after_clock_enable;
 	}
 
 	v4l2_info(&e5010->v4l2_dev, "Device registered as /dev/video%d\n",
@@ -1112,6 +1120,11 @@ static int e5010_probe(struct platform_device *pdev)
 
 	return 0;
 
+fail_after_clock_enable:
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	else
+		clk_disable_unprepare(e5010->clk);
 fail_after_v4l2_m2m_init:
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
@@ -1125,10 +1138,13 @@ static void e5010_remove(struct platform_device *pdev)
 {
 	struct e5010_dev *e5010 = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(e5010->dev);
 	video_unregister_device(e5010->vdev);
 	v4l2_m2m_release(e5010->m2m_dev);
 	v4l2_device_unregister(&e5010->v4l2_dev);
+	pm_runtime_disable(e5010->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		clk_disable_unprepare(e5010->clk);
+
 }
 
 static void e5010_vb2_buffers_return(struct vb2_queue *q, enum vb2_buffer_state state)
-- 
2.43.0

