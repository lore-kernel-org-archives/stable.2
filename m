Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416775;
	b=Kwm8r0sG0VF8bBmN4qUIRF/QVbNDhpLhgiPa6od0tKXFKx5lxp4x7PGGdYlTFaanUx7+
	 S4/bc/3S4C5jJjlQ6Ff2Sl/Fq0J9jx5I/tuGqeWFbWFra/9OFaTiLz+OMB27yRW54UMOZ
	 wDx2T5m+nXMwy5Qh4yvtV5jggv5wQqrwi9bk4EnCb5AVVb4mdR7rtJvI1VahFpttz+c0t
	 sDfIEakvER+9fHiAQdf9MzhIA83S81bm3XANMBc2NKry7i7Sm1fQ7dkSyftaLXWWE9NCu
	 /4WdCGZMcXL1C9MabBV5wdBTFIGoH526ynKlCmEzEXAas8bOUsTL8N+2Rj22WfGqv2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416775;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VuP1xkEeVG+1ahpm/NwdqGtEpY0sqzFtUlNnwK0XhZs=;
	b=R0tVHVcL5Bhe/5mP+RIRxCiCr3RZc9ZPv5rNDOTazdL/at4uFTG3RbFSldCwGPEFgpOJ
	 xdbTaoQH3EvNoABEr4jn7EQN1Ms/nGTfRGTehR/745x+W8kUTSrjBKY9m76LsoniGWN6u
	 EuzCj63DYYbx+/iC7N2KjTbalow2AR8ucu2s6a+NmkTM2KlUTRosVojMz8LprtWCcOvHG
	 gYnxIDcr9T+osvgXddwBRXUvPLnP5kqOYZhoojn/m+I7AzalTGqFU3Jolwhe+inn6v9YI
	 kTBmeQCHIOvPXWR+KWrPAQwe59yj3VsEgGEkSnZ35bFaiCdzb6MqXbN7W+feKja5clQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=i+HxXhBj;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=SwOEXdHX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94070606A326;
	Wed, 11 Nov 2026 17:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94070606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=i+HxXhBj;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=SwOEXdHX
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ABF39n41811222;
	Wed, 11 Nov 2026 11:06:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VuP1xkEeVG+1ahpm/NwdqGtEpY0sqzFtUlNnwK0Xh
	Zs=; b=i+HxXhBjBj00LxP80gGTk1aMohZM6ct3WwUCyUwHMdnYBkWw7ucwjAX3I
	qjtR7qWZnOBvDChQt0vkLHQktdf11Rd9dtSuae6IrOlRZQ5otrOaSwfTm6N0FzFL
	nKRs/8k5PWBefeI+hwj/a9u5/j/GqKSWnJoYSh0l7XNG5gb2N/5DFM+U9ByDQLNs
	SjG033Vnlq7JDCOJ7CntG68dAHcAUVJCRf3wttlNWyhQkHNtpf0arIWsH4c9PMHA
	ObIWm4SXiudr/l/5HCyaT0O/yUZ5SJtQjEvTxnxVLrFNrSLmjNxZifKYnOvv3QdP
	NXRMOkp4GL0qjNvwftyYIQNqkCLAw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hveygvm6g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 11:06:03 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7FlusansQnrTRNwTHngKrMkLSPpEBaMBgIcXJXSUAw4W36KuHWrPzax+lNslg9G65O3TJh0m4OEejubXPZz7gvLIWYUPTej7C6xnCAqi7qJEweJB6mShgz9OsrbuSvkEBkt4Le0PO6r+f/913HP3yGAnq2+7izrtt/9dOPtVpo+/gCotvEzZCdF9e/SkrSxk1KS/KyYz52EEeicabHWhoRk+acSgtM4qqeSmQ6hR1BktKEDHRwcpRc5T2Fa8h1Y+g8dB11sr/xsgZuDkKuY5cBa6Kf79UPp4uPG8d6ZYWeHz8zIPdulsiSU9AvcYAhtrNLtD03QYuHl5Sgj8S0fOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuP1xkEeVG+1ahpm/NwdqGtEpY0sqzFtUlNnwK0XhZs=;
 b=LqAaMqazhf6lhHeJXuj5+MOeLAeZKoedz9fdEKnKgKUE4mqitMIjBHrzXW4kKwmemDOvvWb3++SuXkjqWhdg7G9+4rkkOp7RUftK/66fbvKJT2n4ec/i0smVRMcipiMFJOXASjhh4KR1AQf28XB9RaiQCYbHRIPge3xHWhuc2Ti+ZoXyJU3+Tu1w696gxsCRljtgC8SQLTrFBkMPIR4ci8ImwjAFaP65D/Ifc210SH21BU5rQ0Y2WWerDPgHIHTCFfWXJH/+qklCjWrTaZYtq4AD5ZpaO8Otwtzyec5KVa6DIVuVqiYVfsaSiTqcxSbyXTx0liRuxVp3pf4ls/6n3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuP1xkEeVG+1ahpm/NwdqGtEpY0sqzFtUlNnwK0XhZs=;
 b=SwOEXdHXDEfktOnTECPMvDGEAxhej1fDLMIbjVJHWjUb5Q8Y5y1kHclGJOrnnABC8TNHlUCbFRr9faUK0MBsDyfqzZNyRPMeNA0Ap/Sio353us2t0QXIpo68LJ5vYfx3bvoeCynmAQUOXaE5E61BTg0OOiB/PGwJDQZzC4SUAJ8=
Received: from MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 11 Nov
 2026 17:06:01 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::5e) by MW3PR06CA0028.outlook.office365.com
 (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 17:06:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 17:06:01 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 11:05:33 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 11:05:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 11 Nov 2026 11:05:33 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ABH5WAs123833;
	Wed, 11 Nov 2026 11:05:32 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Brandon Brnich
	<b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v9 3/4] media: imagination: e5010: Update e5010_init_device Call Sites to Ensure Proper Device State
Date: Wed, 11 Nov 2026 11:05:29 -0600
Message-ID: <20261111170530.809226-4-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111170530.809226-1-b-brnich@ti.com>
References: <20261111170530.809226-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: b08a8732-ae9d-4e71-8d52-08df40161027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|18002099003|22082099003|261009223027099003|261026121527099003|261022075727099003|261021123027099003|261022115727099003|261021135927099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|10067099003|56012099006|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	2/p7KtgV7BzIzukfV/yzat5AMwx26izrx8agQ2QSv/wDb5+/PDmALiZPyl1dnsRdhO/KDpYPIYzPutNvlu2ipyRMB9sI/AskyZ2miqu88fgKkqCWOp608feO+Dnxq+HehZSmfCYT20pceBPaO2ARXUGoGDWvDtK4MJznrzf6MDLNVCoJ8vHDfU4MOguOpFSzBxSwxWF9Veaf2LIn0E7Xog+21qWXMEBNmnweS3qEwCLHoq/L9GGGbwnrD65sGOPH+foG/nKPb4fu3UF7UE0IlIeZ5d1KL7IYp3loTRBlhKNJCHGO5tHuuUOdg/aFampnRk9EVqGUJjRiFjXSyRM/Wc8oCkoNVZeV07VKHZUKNT9YOpQECFTnu9j6CauFX34U4Epkfbpaur45XY+nHGSdyeAMFfbGsOF460+mpOtTmu0m7q10MzzCFrLk3FsXONr8noks8Z30VhmpsM+9vlS/+BK2vcERRTxbxswl7Rb8fTEMszLAM5kKn0RNFFvZY/fPkIZ1sLiCJ6n88uGFwp4nR2V2ztXD0fxuHG+7MLZ8itP+m0DyQMI3cE8QHKAoYGIfiW1V3XW1CV20lmd2GxAFy6bknSjudHbNjpmXElzA57wB2jJoQGcCWWN3YRHaHUKpzdnL/TGPVK+TNsUorYn1sAiGjoWpRpEyWqUFIb/JDIrLzawI62y9Gr8CbV1/cPHD4CRFvTX+H2ejHLgbTPHQYg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(261009223027099003)(261026121527099003)(261022075727099003)(261021123027099003)(261022115727099003)(261021135927099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(10067099003)(56012099006)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aqK3IsPKorxrk8Y7riEiSG6gudXZBG9WCJAIPKu9g6sP9buKeNaSMKSeXXmItbHjBtRj0W6TvACMd9Gbm7e9zzc8Rt58ZwYyrf1WljnOjBD5Sf4cxuL+qfmyUqcm0DhfbOILTngFSvF95/VJKiAcYe2SmvQTiZjoHYvlTIPRMxtosMSOLb2iXTTClAxTPckarTBxOMK0EGEy5yfns2Jc4P7a1QJe/OFlqHRxtyf/nsWyKRqPl2mQl3jNL4rXf+gbpt5X6wTgIEzZX4VU8FHsNUIrpmA6qZiw/60l0EkrT+nHpziMDUDKVKLNBhQXLWQy6tYdNmiGEIShUR9hML5jC/mVZMlHU15JXLMrihs9pVjdW2dp6Dlqsu78UBRTlbkZMeGgnuB0KXVnvTcj64wQ7EfrfxArusNLeCxrYziPp+1cPSKYttfmUzbWLVPFz+fX
X-Exchange-RoutingPolicyChecked:
	2E/U1zlAJTsHosA5XbIu7i3z9KLHPlV7RUJnn4haTizWqb/uy+wHjWvN9HEobL6qgw6hS341m67vz67U2yACp7SRuhIrZY5RDsyHkstRsf3JLtqnx6Y3Tw9ChWMDbGuMnzZM/6QPdKt+8CLPc+pf0DOF/bGhO9c8CwT6dSkh42+UZ0B066Vbzd6xkDVTnnlOcE8uUkNV37M4vmEz8owSQDXo4AulwgXqMD9YJoUDxX6ZbfCq7NFq/MS4tSdcWCT7xTsoYNsBCzEapm1ORrCk3wFD0mtvs6+iPi4/KP2JQ3gDlUUnw/4ymso2HnFXYqmthPWg+FyUX06rTOJaznXigQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:06:01.3011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08a8732-ae9d-4e71-8d52-08df40161027
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
X-Proofpoint-GUID: SalvWYEyICmBv2M9qM145z_29f68p0Up
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfXyukPEpfri7ta
 jQWTgm98EEGGQeJ9g2yQwrwIzE8QxmmBD7ZpaqxXQFPd+Qf9ERqp8hPpS246YB9h55gAaxb9TgK
 85lrxHfyt6uQcV8rDEGEdQkGYlbwngU=
X-Proofpoint-ORIG-GUID: SalvWYEyICmBv2M9qM145z_29f68p0Up
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX/uVTmR7L8weu
 hXv0GeChMK+FlBl0wKJ4av6KiyrQ0z7vouIQYRVqc1RUmAyurO3nRgFu3iVzrhRCdf3fhEPxLwJ
 RiG2unR5PyF6LjIEiXnTHpC7NeXxWwWaKVmaCT6H6874rIbXCe0LJ+ywrppNV/SpKs0jnmYvSxX
 OuFV7aqbPaLF4LCsU0Sqve3puhQc1qJa/gnEDNcE34MkIjIUXfubJ55VEHruoCSCdDoJdJ6Bh0w
 Z9EGGpWvYB5wxs5ATT8wRtVXYJEr/OOgOQw+GNgEbsqF+/BR2SZ+aIO9CRvVmqq/IL8+sI58lpC
 T60SEs3vTwYhEqOkggTFZcjTrvG3Do7btAKDX4fFlaXCcm4GhyXUPKdpXRWVQxYz2/ykCERFrAI
 Vzu5HfKL6Y6qR4BLEZ3HDd8WQ2zt30gsVpxDGSnk9jFYFjXZ/o45Su37d8uqDt+JjHP/qpEJh5R
 EKjb0jfSKjH1TaTh5Vw==
X-Authority-Analysis: v=2.4 cv=FpaQbGrq c=1 sm=1 tr=0 ts=6af4a07b cx=c_pps
 a=26rO91Bbw6QoawbNyte6AQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Jee-tNXcj7xYXxj2UzcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110067

The PM framework skips the runtime resume hook if the device was never on
in the first place. This results in a crash in the system resume hook when
a call to e5010_init_device() attempts a write to a powered down device.

Move e5010_init_device() to the resume hook to ensure register write only
occurs when device is properly powered on.

e5010_reset() resets the whole IP, which reverts all registers,
including the interrupt enables, input source and quantization
tables, back to their reset defaults. Call e5010_init_device() after the
reset so the next device_run() starts from a properly programmed
device. e5010->last_context_run in e5010_init_device() should be set to
NULL as well to guarantee the next device_run() reloads the user-configured
QP tables instead of encoding with the default ones.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../platform/imagination/e5010-jpeg-enc.c     | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index c9dc12126cf9c..2da43c14a25c8 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -986,6 +986,8 @@ static int e5010_init_device(struct e5010_dev *e5010)
 {
 	int ret = 0;
 
+	e5010->last_context_run = NULL;
+
 	/*TODO: Set MMU in bypass mode until support for the same is added in driver*/
 	e5010_hw_bypass_mmu(e5010->mmu_base, 1);
 
@@ -1487,7 +1489,9 @@ static void e5010_device_run(void *priv)
 
 device_busy_err:
 	e5010_reset(e5010->dev, e5010->core_base, e5010->mmu_base);
-
+	ret = e5010_init_device(e5010);
+	if (ret)
+		v4l2_err(&e5010->v4l2_dev, "failed to initialize device after reset\n");
 no_ready_buf_err:
 	if (s_vb) {
 		v4l2_m2m_src_buf_remove_by_buf(ctx->fh.m2m_ctx, s_vb);
@@ -1516,6 +1520,13 @@ static int e5010_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = e5010_init_device(e5010);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable e5010 device\n");
+		clk_disable_unprepare(e5010->clk);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1548,12 +1559,6 @@ static int e5010_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = e5010_init_device(e5010);
-	if (ret) {
-		dev_err(dev, "Failed to re-enable e5010 device\n");
-		return ret;
-	}
-
 	v4l2_m2m_resume(e5010->m2m_dev);
 
 	return ret;
-- 
2.43.0

