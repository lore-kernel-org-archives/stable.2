Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794327887;
	b=At+B68mzAaIpEoVQ/lZDgQGdpj/X00AuaOu5lC9vMK+NrpK/08SmGxmhGC+DduMY5h9S
	 hi6YfkvzKCwZErh0MR0Ezk2ijZ4lAXOnzQC/gaIkjqkgpcAxsg7/J1N74iVTLV6tVg2rM
	 Dyg33gQ5h0ZnJlCgRAMZZsJ70od4KrhT753o7v52vFqc8dxZo++2Q9qbveEqhUhUHuID6
	 Iurt3RoSONx8sPO5ss48Lhur7tsZJGqBlxhw+hxK5KBvpRtKyDI2l9TU+iaCXrA6ggoez
	 /FTjuhcxy87MjU8CqItvcxQDGWvGm2FqzCoGJ1JY1iDSkSvqhuWeHqAgSBy75Pi07jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327887;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6umkUeuYZUt5fsIw0iUqsua2idewj8kC2O4j5/Ef9WE=;
	b=JgrAj1DecUJacfPF9gad+C8QOlI8YzJ6ccA0nCGiWGs6+Jzr38wxfegIQSfVZ74qCvsg
	 TyS1XLe/XdEc65s3yUsQ1GDE9QUy1lKQR2Iai+axCeeiW4yq4M1ZYAZ/PvmOaorEcX8ZU
	 68/we1xxBt4SlIh4J9qltUZSn4NjBDQcXx1EW9wnkfWlONqmslc4jGA1QrwFM0DwUYo/C
	 0GML+8MngaREm9pXzx4otwP/kJjIjopBmt3lraIHO3fp9gtRLvCP/5J8yvQRk7Qt18Ver
	 9rYaNOOKpgC8SpuIPaK98ktH//sSezM0oyKgR91jBXkGFon/nxMrkPK2hOPMPQGtN6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ti4zF+We;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=T5ibHcdF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228360A263D;
	Tue, 10 Nov 2026 16:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F228360A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ti4zF+We;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=T5ibHcdF
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAEwIWO1618394;
	Tue, 10 Nov 2026 10:24:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6umkUeuYZUt5fsIw0iUqsua2idewj8kC2O4j5/Ef9
	WE=; b=Ti4zF+WeCpEDwK5QYKhTg37sWRDTOZp9+W4MkjaHRehiUkgwH2/qPEGjO
	O0mk3Pac7nSWWreuJxPHV8HXHU108HyvK5pon+xCcm3nzNkwyuY4re5OAMv948xq
	W2keQu39rqWTRLzf4B6x7J/oopxUJSfm1sfM6n0e2KDPxBbpwXLtQYYslIXbYmCG
	RrDxrR7oLkFmFsptyVMB4iIkTTdVTtYZG/BuhIwJfo+20t8qfJoLiQjkgDXJ2RRs
	9VNr67M9ayjN896dFaOzVDrefo+YeL1D/9Ct/iSIrjKUpwMkhtOofbbCQe93LhpL
	HXkxbJWZoxtqrEFeVzHSEx3mapgEg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0kst82m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 10:24:37 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikrQP072C+ZhiML6A2cXz3lMah4xP1AAPS4tlPTQ6+jN8q32SJgmXFP/wlq9kK+JokGCQFfujSFiMI/MtWp8sJmBTJpW3GE7Cva7iPAMT+OYUUbK/qLzlAfqMHymKZQRfFn74YUcI5ZrbFfDSluMVGqKnj3SIf1mAzo4MRh8emp5z3fiBY8vMkkJkMPsBLTKLtB8IafFw5jZzaziSQpfNBwCwHfV7SiP/8mBpaI1K1hkjxaQiZfcr/v3XxEIQPn+elD2uCvD/eBus5y2N4p/jJ63aNB9n6jhb7GjSM6hb5w11KpgHI6RTiaEcmL809d98Qfpch/nZV7hsWUUXIKZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6umkUeuYZUt5fsIw0iUqsua2idewj8kC2O4j5/Ef9WE=;
 b=O3cQev39/2QGOBr/1EXYuHsGINs1K+Hit5wiM4i4nXuMcNtzEezmmaL8bCSgTEXlZUDiFC6QGZGk7W3PNqxxrbzqPerP8vAyco5pbavMKULYZHG+kWv/KXPNksIBtvsygsm9i+UfneIcy6QEFBckxXrp6zAKIjfzWV4wt5Khae4OIG7pJ6j8lu8PnXJLENprLVwdFSjKK+FrLMiaZb8uT7PwAHDuvNa6Mo1v5sFmZA0AtRDxNYmxt3fG4kbbn4TnJeraRxLztW/eWQFp3w5hOft+jHvkUWSkEz70b5DESKfsnfn+LSyl+gJ9QBkhD96Y1TZ51P87uGmBtxwJufU+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6umkUeuYZUt5fsIw0iUqsua2idewj8kC2O4j5/Ef9WE=;
 b=T5ibHcdFJxx/Zuo3AZEZnKi0YlYYowKxCb/1oL8g1HZhCyrKESpl50NYssU8ebbJ9M/Fl3B5bnLovNhvq7VfVWcM4+aMOMw9dVYMCTG7XbZXkf6D9Z/XxgzkxE4xmr2sRWyJB38wZsv+45ZqwXZHdHjsBeADoJU6fqMyShYA+1M=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by SJ2PR10MB7827.namprd10.prod.outlook.com (2603:10b6:a03:568::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 16:24:29 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4d) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 16:24:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 16:24:25 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:23:59 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:23:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 10:23:59 -0600
Received: from [128.247.75.1] (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAGNxIh1124949;
	Tue, 10 Nov 2026 10:23:59 -0600
Message-ID: <762a1a3d-ac18-4220-a9fd-bafcb247ee6b@ti.com>
Date: Tue, 10 Nov 2026 10:23:59 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] media: imagination: e5010: Update
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <sebastian.fricke@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>, <stable@vger.kernel.org>
References: <20261110155810.18521-1-b-brnich@ti.com>
 <20261110155810.18521-4-b-brnich@ti.com>
Content-Language: en-US
From: Brandon Brnich <b-brnich@ti.com>
In-Reply-To: <20261110155810.18521-4-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|SJ2PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b84b18-7af6-47c9-25a3-08df3f4715f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|10067099003|261028144727099003|261102123227099003|261021135927099003|261022115727099003|261026140227099003|56012099006|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|4143699003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	kQnPvmFIZhzEoEX+VIOCnx0g8Ymzxk/DNggvOijbMmNalYb+xRK5FVoqoX8ctx5TXq7Kp2qr5huixa7zQsOhCAQhlmE5GOyAxRQb6Obw+m1zQLKvArhkMIXbUY8mWwL0XdCWsBcnCSwF3PS1fcuxdfiNpdqIIg+9Q1rDNIxIZVvfyVZb3usZ0UpasW3WX2B1jNYD6OfQl9DRrrzi0N756lpYj/rDtUL0PecxZepgkhv+dRmkNwPLAG8g1eppsJy/EIBKpJ4EV+fAmiEkzkcVa/ZCdVIDujDY3xVdASVbfMUmAaykj/G3sqv5GqyAoKdw2mN3aIREE+dZ5IkolrxvHtrntN/Sx2ADU8n8YnWrCOdtGc4+4zoc9Lbz02FcepthiTGEerpgQirKIDWJvOB/Z84H3LjQRkeE+4LkOolvKCF2y116wnjwp9hEAs7JhDwkCig+qBrtmR5SC28oUJPB98FW9zXgor3qb7EEMfPOYkhO1ABaVx+cljLhfKomZVYCUQbs2tilSiNCGPFm5nbaKwvJJiOj9znDIzKrUM1KgYRTAFFkWo0Lpfnot4zWauhWTao+67yES1pOR6ick2zW9uVvsijHworoemOteSzU/sPoOKwB2r//ciVwAxPyDh6+xI9cC3toX37d13Up9zjCiav7Dph+l8P1dQJVSgEs5YwjqSqoZDhQuiD6dUGxUL0M5YM7VqmqvVljAmZa0cRDOw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(261028144727099003)(261102123227099003)(261021135927099003)(261022115727099003)(261026140227099003)(56012099006)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(4143699003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d4D6EsvQWRo8hV0kHnfrByDqBjni52F6oBzBr9UDttcuvdKwJYvzaqLXycmEfpOMILGQxl97UeKiWDxdfqNC15HCYxxLYYmUOU3WGDPEJfwhu07EOLsJbwYllAk84zjQAMjrQnjcJoXQDWQVuj4j5NVCaU77twr+bSGkX3+7catkk0MrlPCm3kiFgkgupsjI7ToznGP1CWsyhUYvz3Ij9AexFV0tvS4iiJJSDCZVzCEFgAyRftWaSsRg+fm8hInHh+WnvjAtRXRS9OnSc8k1n81HniD+FeqEjigbExGjpKf5RDhV8A1W6VjXpvmkn/JMVx1h0PHVCquxsbpBAjueV8Nj9Fi2OPGc4/EMnDn6vzXidmxzvicbUWokYB6e1hIBL7CwNKRqvcKKEnf2dLU3He4ullITYRDRAW+8iWtdeAQP0wwYszrTFt25BBprcURa
X-Exchange-RoutingPolicyChecked:
	To38PdwFP3Cx47pHSko8zEuDV+b1hBXmRyqSE+LUlunmuR4fGueUvE5xIWm+mZdSYs+YolXcyON+po+f06gvHH4kKJbt/WxWi2ULIE5EMsk8UhTM0YMm2iz7YjTlEn+0h1SAiOrI8MWx990r/+po9Loh10ByENdBkhi9WITvPO+L/9nAprckYh535hUB9RQZvJX+sruTFcu4fji3QaUCp/7yFr2Ugw6iGW7WFsMNHPZ7FbM3G1ekHzkuXbvGZgJYbyQIV1EsKe0b2NNwr3y7JyUGnp941luq12ioVY5YlpRNx+AS3sOYr3/xTJAGTwveWE10uXnlauclU+I7zdiX4w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:24:25.1994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b84b18-7af6-47c9-25a3-08df3f4715f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7827
X-Proofpoint-ORIG-GUID: Qs_n8i5aUzlmK6BYU2RzlLk4TswCKlUb
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af34545 cx=c_pps
 a=TO2QspbEOyvqwnNCDF3LgQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=18iZY3HW1OHlVmvoSgwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX5ypQC8F5M6cm
 q6hpXe0bPU3Nlq1iSb0dRySugTBKqj9bRxJtx2sjsaOdedNZ3y6QKavNA7Z7aFHXRfSUI6bVXfJ
 /JikQatHpgkt8KqOFWiCse+HnRqPQ36f8QB3F5aFTbSuGvZnG1whFpxaxUmShewieXBSudYslyW
 oIYpzJTPc8fQPXaj6RUsU6yc5WrFmQTKpB5ykdnhN4kYV3to8sew0XZ8dgXOH1qrKBTK1THprAJ
 Y08Ex5mxEfVRdMWMMU8LtoK4zQK7N8GCQrBDzSABo1Z4rvoH/xszRmRmW0Cb+o6dEglHxQ1Ib4p
 YtonCUp+94wZgOwPMSg7K3kvqCMwe/z9vGsywwxfmE9sRRYGJszLAxmuG+G8sSw+rQs8TMDtAy0
 nUvFsEg8lcFgmdNkGZNJgT6WI6k0VH3TVBOgcpcuCnv+pB+JwSfHiq3whndp3wkt8zkNB9NAxC/
 jPjbZoxV23xu7zD1Uig==
X-Proofpoint-GUID: Qs_n8i5aUzlmK6BYU2RzlLk4TswCKlUb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfXzp9U2XpXsRDs
 jRpKvofK0vEVkjey4+RkQbimOsYdbg1bVUCEc0s88z042sjOjQNAYUnzshh4sr/VLDdoYOkno8E
 zSUs9lKheABr3K1FEVKQvPCP5A+b6Yw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100065

Hi All,

Will need to resend this series because the subject got cut. Will 
re-send shortly.

On 11/10/26 09:58, Brandon Brnich wrote:
> The PM framework skips the runtime resume hook if the device was never on
> in the first place. This results in a crash in the system resume hook when
> a call to e5010_init_device attempts a write to a powered down device.
> 
> Move e5010_init_device to the resume hook to ensure register write only
> occurs when device is properly powered on.
> 
> e5010_init_device needs to be called after e5010_reset for next
> device_run to have all registers properly reset. Without this call,
> register values are stale. Similarly, e5010_last_context_run should be
> set to NULL in e5010_init_device so the next device_run call does not
> use stale QP values.
> 
> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>   .../platform/imagination/e5010-jpeg-enc.c     | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> index 17ea616ff1795..4e77112b59197 100644
> --- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> @@ -986,6 +986,8 @@ static int e5010_init_device(struct e5010_dev *e5010)
>   {
>   	int ret = 0;
>   
> +	e5010->last_context_run = NULL;
> +
>   	/*TODO: Set MMU in bypass mode until support for the same is added in driver*/
>   	e5010_hw_bypass_mmu(e5010->mmu_base, 1);
>   
> @@ -1488,7 +1490,9 @@ static void e5010_device_run(void *priv)
>   
>   device_busy_err:
>   	e5010_reset(e5010->dev, e5010->core_base, e5010->mmu_base);
> -
> +	ret = e5010_init_device(e5010);
> +	if (ret)
> +		v4l2_err(&e5010->v4l2_dev, "failed to initialize device after reset\n");
>   no_ready_buf_err:
>   	if (s_vb) {
>   		v4l2_m2m_src_buf_remove_by_buf(ctx->fh.m2m_ctx, s_vb);
> @@ -1517,6 +1521,13 @@ static int e5010_runtime_resume(struct device *dev)
>   		return ret;
>   	}
>   
> +	ret = e5010_init_device(e5010);
> +	if (ret) {
> +		dev_err(dev, "Failed to re-enable e5010 device\n");
> +		clk_disable_unprepare(e5010->clk);
> +		return ret;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1549,12 +1560,6 @@ static int e5010_resume(struct device *dev)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = e5010_init_device(e5010);
> -	if (ret) {
> -		dev_err(dev, "Failed to re-enable e5010 device\n");
> -		return ret;
> -	}
> -
>   	v4l2_m2m_resume(e5010->m2m_dev);
>   
>   	return ret;

