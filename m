Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794328424;
	b=dWf2QnOcizSzinXijMDakH6vq6uh6wful1x9LrMLCM0iZrus/DkZY5PWob1yE8AyEsjP
	 yah+E79vrDfbA7BJ2MqItLR+UwOJ6SgCNi7JJ9BTvSDqV2swCgqlnFOLeGIwWaNuUaHGG
	 Lmtcopp9/0XG+SpCJjW3UOp3f5ET6wGo5Yi9UMwausv9fLlmdLFTTFACIILQd/QP/bKVm
	 JUwszokrxQepDPdT6ATskSSM8RMvuIs/PSrQ2MzXVdZR8G+s2uvrtb/p32ZPYjDIPpC+s
	 j/eHQKmCyjqllGZHFs0TBGt6VrQZ4GzTPq6sUiztcJbC4ByHmzJfxTz3VPLUzSsgX2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328424;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFfZ0=;
	b=u4l3mYjdGeU4yw0X+ZnyzByaALegw0Bi6B9tz1v38CHglmqGEEmERQCXifTXxKdLWb/d
	 LrMXeMe2cOJjt6U0RWCsJ3DtjaaWKoGqkLXDZJKse+KBduSl3SNJNc/Npp/VgU/1OBfDZ
	 gzmuolEx3GyZZfBzJZzDNg5kucGEAmVccfFMnQttZ1TEQ0jZbUSR4UV9orDrSVgKqMg0X
	 p98iBkMvnjqdNfP/XLXP/WGErO/2nD4gdh3pqzB0BVjZV1xuImejjOcaInxJEESm5hIV7
	 Rvw4BOKhlXbRusXl+WWwNKXVFWVB8tfAOiL+8OYXADahPvAqVLqQ5VvfsvNBd0mkczw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ccIKP9Ed;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="WjsG/vIf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838A606A205;
	Tue, 10 Nov 2026 16:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E838A606A205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ccIKP9Ed;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WjsG/vIf
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AAEwCnP3291768;
	Tue, 10 Nov 2026 10:33:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFf
	Z0=; b=ccIKP9EdrcpGs4WOu5LEvl93u4sTUF1JnxD9fb0Pn9jR+HC53BMBxEGnf
	47iqimR+gM47hUPzu4F5mFCKWdgd+j90dSR28UmYRc6jhNA2gzq2gYvOyACqZ9Y8
	PL9b4jP1deerZOhfpHCrcJ4zV/mLtWDHcBX11cL+2kyamhSznDM4MxoVTMxLTeed
	MbmslJaZaQ9GpEMVqNFO+6cIougtZTrcza7qz1s5bQv1M8hkjGUpAhagWF4TQEKF
	1KYtZy0T7jBkM27Ojo6hEdbI+KlduKrNwloxbH1J54scGBt1QQ5iKW82yJhwuBDV
	2dWS9xjADtMP+azVC22kjVQtYMywA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hv0j0acse-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 10:33:37 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dE8CxH/Tqi9svnR6klUyw7c59t/FYMzK9rMTrK4QDrVlKlB2hvQ+A9apYJoQb6QmHmM4P7v5ysx/qj5fRQ2PzpKUtt+Ky98mcvJMXV8SPFAmm7kC8KFFg06HndnThzskbrWcOuq/Qk4XoXy/wm9Sn/7+l7fB8VhHvAczBBQpdRDrRgPyrPK02aSh0N8mzfWSm0ZDhkl15+LRva1m7K2bmfkFaVIhwWN7pfs9azLGpFwuOEyfQZ+IFelrCPSUqZzVDNRtBtciuwfoZNQt7gdnCyt8whH2nV22vEz22B4IQMf7KtLyo7bxWi+pEl6zZVMD5rsCxuQpLpCOfttlZwEZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFfZ0=;
 b=RwBNcHsxThKb0KLpJOs3PkMnnmFLHinxTT9amdRd0TfsvtcqYyMJH2M0vGjW1eRrWRZy1aD6paOhqGj/NvlOs7R3GMT3rx0Zs+Eep1fJafBtI3tkW7sI6u9Vm9nA9g6d5lg3dcDs9A8W5OxdLXmkxUQSnnagIxDi4wN1Hpv5+rmqeh5JrdoeTezt5xqkFF3Ct9gEG19bWaBjPsVhSt2CMn/qr+gQCOHUmOAs6K7RGO5PwkYJn/da8+C0KzvUUieQg1PFTLpHm+hnWIPK5OGtPYl1hFr8Mlr1kgzYudrgeLql1lPT2cglriSPvJuI1JeBmSPb6SAlcNlaUgGlZVjEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFfZ0=;
 b=WjsG/vIfIHfzaYXu4FFDRoPoXWMEhm5GOmEP6j9n7OLe6nWHTND/2BaZWKHWlCLUA7xDJeKHTY/vYXOSWUAerSF77hBNhVyz9lQ7xxkC2aMmHdeZ1o/uxCppqKyC15OdDoGk+7qdxxy9Yj6hZ7QlmStRiQjM3FBf0oNIY+WpO5Y=
Received: from MN0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:52c::31)
 by SN4PR10MB997897.namprd10.prod.outlook.com (2603:10b6:806:4ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 16:33:34 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::9d) by MN0PR05CA0006.outlook.office365.com
 (2603:10b6:208:52c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 16:33:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 16:33:32 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:32:50 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:32:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 10:32:50 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAGWoH61141135;
	Tue, 10 Nov 2026 10:32:50 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Brandon Brnich
	<b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v8 3/4] media: imagination: e5010: Update e5010_init_device Call Sites to Ensure Proper Device State
Date: Tue, 10 Nov 2026 10:32:46 -0600
Message-ID: <20261110163247.48712-4-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110163247.48712-1-b-brnich@ti.com>
References: <20261110163247.48712-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SN4PR10MB997897:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ef07cc-3770-40d8-bf99-08df3f485c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|261028144727099003|261026140227099003|261021135927099003|56012099006|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261022115727099003|261009223027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OlBFVAPs0oGNebaFDkOAqJIuebXyUtALlUwgm54wUt+CEwo+0wRHcmc9CGHXmaeX/wqPnPntWx9kMOBZ+0/vLzeOWX/cu1w6ktbXJHDOsXjz19YiISWp3w+NluMmtiP6csUdp7QdC+N860lGILT7wJi71EHhlhxFt2yVpt4wK14pOGOziGZ6zh7AtwHkcql5Xp1+DUF4N8djCS7OHg2vCjTJfaODKcYZZJPydTdhi87p2XQZUsM1m8M2txG9LwnltkHKrK9dMUcyGnHnuNR7k5xmBi8uWodlcDzwLg4EuREt4hGaOyqYMB7iWrdOcT7pFiOdOiM4mpYc+at3lpE+CRt9P5RQKmyTGCV0sj8QpJAbk78HRKHYpNzQF8YngUhmQ+LeghvbQiItJBEqJAAMEDZ4munjibJQRB2H0cjuV62GwmhnatAGTmVJt7/+8DtAtfhHATDx4ws/Is3Z3Y2q7Q+mnLtW4Q9KT2QmbKVqlsEgc5dK+zLlfGaoyknZt6eM1Xmg0jNeP70M9JVBOAcskCSfN8emeXA/Bl3RwssJczQGrZWIRBLEDPhwFQoJsO+u8q69Q+tGevdbTE+Bx2LPfurW/dNkOO+uwjHRBhy+EZfhALvBoLs5rrh5kxEECf0CHq1NbFScZCMojCknBfKm4VeobIDdB7SXNMztxt6SDFvhfXvn73DMi/T7CuRt6vehmukukxaj7P2SNzGkxJDVBw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(261028144727099003)(261026140227099003)(261021135927099003)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261022115727099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SwSQx4KKlhA5WVsh/Z5PFE48rgEh8cvLcPGJ9ebk8sPiQLDeIH+kuLssHA1JMagtqFApvgDD7QLD7+oE6pf3Y7LJQy/Md7OTIsg16ef7z7eBQHppYVZE+gk2HrxdiFT2mLwm6UHbHFcDkDXR+XWOaSaFO2GIuKYKfGuvQQ3VoSZRp76e9Vp1+MzshLSIzInQ4LxTrZ6Yqg3MXCiJXNklwLUPOXg7uyeFo5JVpt+X0HLUVe9kWhakTkd1AkSjiIJN626bpLc+4VRLFsTQA3Yly7XeVNf7NhELpROWXgsptPcW7/8o7Yy1BqhVt5A/rXuneitYxV+17prjkYThtx4Lae9TzLI5X8dUvr9/CbjBkEB7spzbuS5W4ugBs+eQLk8/Fp2CQGF2Ef2gwNhmxBbGsmrVpQ+i0NGMPynWST9bz30+utkqXmvJhUxbu87/tKZK
X-Exchange-RoutingPolicyChecked:
	fW9E/WhFbKatXcpwgy0hwi/VwlV7Eu51DlAsMPZ/kC/U1UiVA4QczypE5HqIoDSHLKxKFOaMcUWjk53UrNaFxim544woL9OAViV1dPVZtO9UXVR2hMZCoRf7kraC5CLmdLuE+KLcMv6qMDKUrjM8BbhTUbt51wJ+vG9W5h4n9H6yEs5lgNYg3Uo2TU4oaWTpc5PULULKy2C1JKPIy45aVPBePkcrKAXV11/NKJuKyygd7CuuBDnrOh3JBDBUaLETnUzcsXFYMeBERVxpYV1VPIAl6ezbGbSiPdmouRCsCcHIM8+FNz3Br+8ATwdnlffduHbHGqnrsH599e83DveiFw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:33:32.4150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ef07cc-3770-40d8-bf99-08df3f485c1b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB997897
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX03j20QgntMnS
 Pn5gscWYoz5YAYuL5dXgVZhBvdWsyQ69cc+ahI4XYqRH/bxWNor3kJnv9edyRT31ybRS07YwtSQ
 LHXTmOmdDU249YKILAyHUD6LDSn391u4XGWMUR4RJoNsM9bX8QdeQJsJLVNwTNiNXcEf3z7W9z3
 pc+y9SWwJ/D5QDwCK9DtwANX+6otD+ETiuWuZHwbHLowfQDLIWHdtkYBZgfaMEORwG4EkO6+UA/
 W/EJQzPQZYc0UUb+XPOUz2/nzOZRAXx/8WDsYM0B9wb5TNPJrUS18rFpZo1vMRL4FUAJKHzH4Ep
 Y+ONmsipzyuyHX5Ef4zEQOg7UdiVPlHAdoDhbENweLt/vWBnELrWkYnH3LwC9GFctydijrpSdNN
 5PGlo6aUaKz1ruP9rygAVkP365F104RTJpdZyBGdbEia48EDVbDMZ1B0nPmmu7LX93PIQllNur6
 LuIHqNAqTHmq3ANtIgg==
X-Proofpoint-GUID: 1BGqea9aGS7Ky_voXpEEkE4U0Es4wsTz
X-Proofpoint-ORIG-GUID: 1BGqea9aGS7Ky_voXpEEkE4U0Es4wsTz
X-Authority-Analysis: v=2.4 cv=BrgIUoX5 c=1 sm=1 tr=0 ts=6af34761 cx=c_pps
 a=w9jTARCbdo3hRO6w7Rsibg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=Jee-tNXcj7xYXxj2UzcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX3CdHaFSYwJJ8
 1OzgdHaMg7o9fmS8EAOyZvvzpQ4nfcskRx/IlMXH5ZmENGElTbwTmf0OW4+1W22Y5l+EdgokjJM
 vtkkUQFDWDiGrE4Lw8aDXNnoYToiJV8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100065

The PM framework skips the runtime resume hook if the device was never on
in the first place. This results in a crash in the system resume hook when
a call to e5010_init_device attempts a write to a powered down device.

Move e5010_init_device to the resume hook to ensure register write only
occurs when device is properly powered on.

e5010_init_device needs to be called after e5010_reset for next
device_run to have all registers properly reset. Without this call,
register values are stale. Similarly, e5010_last_context_run should be
set to NULL in e5010_init_device so the next device_run call does not
use stale QP values.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../platform/imagination/e5010-jpeg-enc.c     | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 17ea616ff1795..4e77112b59197 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -986,6 +986,8 @@ static int e5010_init_device(struct e5010_dev *e5010)
 {
 	int ret = 0;
 
+	e5010->last_context_run = NULL;
+
 	/*TODO: Set MMU in bypass mode until support for the same is added in driver*/
 	e5010_hw_bypass_mmu(e5010->mmu_base, 1);
 
@@ -1488,7 +1490,9 @@ static void e5010_device_run(void *priv)
 
 device_busy_err:
 	e5010_reset(e5010->dev, e5010->core_base, e5010->mmu_base);
-
+	ret = e5010_init_device(e5010);
+	if (ret)
+		v4l2_err(&e5010->v4l2_dev, "failed to initialize device after reset\n");
 no_ready_buf_err:
 	if (s_vb) {
 		v4l2_m2m_src_buf_remove_by_buf(ctx->fh.m2m_ctx, s_vb);
@@ -1517,6 +1521,13 @@ static int e5010_runtime_resume(struct device *dev)
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
 
@@ -1549,12 +1560,6 @@ static int e5010_resume(struct device *dev)
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

