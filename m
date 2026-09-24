Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023119.outbound.protection.outlook.com [40.107.159.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40649B5AD;
	Thu, 24 Sep 2026 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265735; cv=fail; b=fnt6QhZDaFoYekxh8r8/nU4HEUYmt8zug6a9J4mt1WC/o0BMhqly6QIsI0ahVpUeP+owx3VLaORuY6ZY3LRvWHR9TaUnydwo1ocHoj5ptb6JUNtk8mPG3lYZXytqFzZnMArdCezCpQ0NM7GTy3MUmmiz/Dainzmc+QlepTzv+Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265735; c=relaxed/simple;
	bh=RO9lTtr5YhFn3MTRuIiUE/Trz7Ze96ujVTx6GMotq5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2OaE0M4OU+fgBAgzKm/PYCX2w8fN9scvwBmVsGOboGJ9KW2PxSezcTAkYIrzGejIiy+VzBLdqPFX2qEbZfkTDEGeyOlcg7GJDLlSb/unP3p4e8sQZiLn0e6CfIfxqBClz6sKadZblkdoAAaX+PxGAq6c174ZQextlDGqHwE+mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=bTS+ibnE; arc=fail smtp.client-ip=40.107.159.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="bTS+ibnE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNXwxUKyR/6gCf15j/DIwUlDExvq6nVVdCpuScVUSJaWe5tUavOA/MMuhUJ3XS+JidEh2YdxJGhZCWLj66UwRndv8T5RCmvloykWhJKTPD2Z4Zw2YcZMboWmi4E/9XvN4jyfxe3NZ2xek7lX40iQOkZAN34tmdOpxSZslyoGk8gU3eZp2q4T/ml4j0xNk1SbKe2FQRtplwNgp4H9cDZ1X9gae9zpv9RqusX5WxtAvF7A/UrpxcMS/8A2+WDLJ3m5YxIASMC5XE4u82cGgUunRZUpkbCaGVLpJFIHagt1E4aLkStsNP0XqRThvjJBv7aqgj2RCptVRhk8H2ttTuwkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO9lTtr5YhFn3MTRuIiUE/Trz7Ze96ujVTx6GMotq5c=;
 b=u6dEwI1KayfNlmjnXmWRRNpeplHPOrthyMQtSYGSOFy36BPOfjTNvF8sx9uBwbUB85fRbZefDfQz/e5akacJ4OUQKaL0wnKNwoW8Sbpv1oaNdrmLtauTFDLTcrGytHF8otw24qvjPieS9tfiZ9rB9tWYBXZYgvnpUuzWmxG6RwtF6oVaERIayXnI4c2AnM/mDv3mH3XnBmHgWF5AJY84LspB1IV0YmmoA0OoFnWqRtNN7lB1miLIJpl6J8TBEUvux3f06zMZM6cFljG8FSKqwdmnmvBWHXHhbvuwTMX6W7ePIaEEh14j3GBceteC0V7P3cZO3qlE05wgxlCyhzcJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO9lTtr5YhFn3MTRuIiUE/Trz7Ze96ujVTx6GMotq5c=;
 b=bTS+ibnElufm54q/NOow9mtv2YDpp7B5VGnkJ8ZJ9r2qMIb/UxkiT4zwvguBZ71juL0ygc9zXfGicYvW+upwpsyO51HNpNPnwQZrOcd8zXvlel2YxAUt3rlr5B8hcXR4bVI1nW4qzLr0ypQATvH/COxe2IKAjWaI01IC8YJuP3I=
Received: from AS4PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::13)
 by GV2PR02MB11276.eurprd02.prod.outlook.com (2603:10a6:150:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 16:02:07 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::85) by AS4PR10CA0005.outlook.office365.com
 (2603:10a6:20b:5dc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 16:02:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 16:02:06 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.69) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 24 Sep 2026 16:02:05 +0000
Received: from ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::6) by
 AS8PR02MB6598.eurprd02.prod.outlook.com (2603:10a6:20b:257::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 24 Sep 2026 16:02:04 +0000
Received: from MI3PEPF0000849A.eurprd03.prod.outlook.com
 (2603:10a6:910:41:cafe::3e) by ZR0P278CA0156.outlook.office365.com
 (2603:10a6:910:41::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 16:02:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 178.15.18.66) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 178.15.18.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.15.18.66; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (178.15.18.66) by
 MI3PEPF0000849A.mail.protection.outlook.com (10.167.240.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 16:02:03 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 24 Sep
 2026 18:02:02 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <hugo@hugovil.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>,
	<tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 1/2] serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
Date: Thu, 24 Sep 2026 18:01:55 +0200
Message-ID: <20260924160156.1770103-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924095320.3038105d452dcfbe44cabc60@hugovil.com>
References: <20260924095320.3038105d452dcfbe44cabc60@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX02.za.ziehl-abegg.de (10.1.201.106) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30216.007
X-TM-AS-Result: No-10--4.333300-8.000000
X-TMASE-MatchedRID: wQVy7q402w0rKmlbgU92WGyJrxBqx5NCQahV9NsL7Q9ffiFFvXJUvpmg
	kd7c0mklq1OKGmdZqMHck2GkR6TlRRmmC6fFx8ruGqxL/yNoD8pcCdOe5Y5LZlaL9DHCw6UK7gb
	7lp3Fk2FaOxpgjiWHddvIAMT/07Oi9VRkPJa+sq6LADIP+HEIvG1CdFlcEYhnSBiYOLSG2rZCO9
	M3Dn5+lVDz9Vf6OkwjnEA+10Hs8LuCEq3ZCBanrjuGNnVAYS/wUwWE+0Rl6FsSQBCR9Dbh0/WgJ
	21rFsx3
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.333300-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30216.007
X-TM-SNTS-SMTP: D5FFB790C2631E1278B357551DF7464B138805DACC8AAA0A3F6CA1388CB7A1212000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	MI3PEPF0000849A:EE_|AS8PR02MB6598:EE_|DU6PEPF0000A7E4:EE_|GV2PR02MB11276:EE_
X-MS-Office365-Filtering-Correlation-Id: a53fedba-b918-4493-ffca-08df1a552ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 Yhhg1F1mD5kynin5FATVd6ei9DELgwy2iE7FKUFc6wJCJ+PmY1UQQhKOIcdYhpU1mDjATqLkUq1Zkb3HV1NgYv6DKjaJhxkQniWowAXxfz91uABnSCvDDX7EIiMHHlqWqAAI4ZB9Yasx1SmD/kD8JX+ztYcm0nadHWEp1POt4LYOl+2/L/rm4Ax9n1CsKoG7dsKYpaXTzjabF00osDtRQaLLhZDoI37Hq8pvAJ4XM09twUXhKet9okzloxBy2omPn6ideJYUFfRtoP7gszbIfYt4yIatWModJd/FSdyb5NptjIvIVFWpGT3nH3T5T8M/bmOV+fS3JForeILp2LlpRNB9uCd3akY90FKFFK8u4x0W4au3+opentVr8ZFt6ePILQr90UrL37qwNnKLoi6ey3ua43NEqIZFcpS+MmXk2MeDMUOo5dcyIewdlL6KYuRpFmhA78Dk6TW+uetPE0oGc/YU78Mzlsmu7ivN0huUcxGWlaJopSQ25Z0d9Wl8kNKzSPbph1nryJZEVrsl3InNuFlI/qyl2JsqOEDjtGIuFja0m9xzGoCnZdIULgTy4jsioygV6mdVLXOc83de5RQdaoT7N4/ToW5jFW+d5fZaDJeZIYJ9x54+79nI9Lf2M6NPUZZ7SoSWpbY8nWbj0OrxYj2/NIwQgjuogWfGIxZ10mep0/+WkaR97gHPO+6a4cMO
X-Forefront-Antispam-Report-Untrusted:
 CIP:178.15.18.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: 2JEq0NtCcaP/Uf3l1jDcGdVW4Smo3awx9Zm80dktqko8AkGaM+MuC9ZXqOMsCob8o23+6OEXveIKHWGLjSea0bTZo2QkBZr0H+/AyyVeuA/dY6i6tT+G3bD5aY211Ni4lBhRIZASdZX+4pp7PsesSR8Zf0ZWdAU1+RfZpUlPnJMlSpSPj4bNPccdBvAhDPU0wz41RDeKi13jL3L8+EzAwLRH8dCHoMlFw7gC8Sap3LBXQgnPCS4S66RgcyDhpFWHEKYTXpyvG08m3xFDNltiAZ7EGTeS5tvl5re47/TN7UQc5PAvDBsoBxsZYcCWhRz+AwCW2mr3vylZHwo1os0D5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6598
X-CodeTwo-MessageID: 16fc2827-15af-40ee-b0e5-8e8218c2f894.20260924160205@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1edf7c91-3057-4f5f-db81-08df1a552cc1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|35042699022|376014|14060799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DYxvkFXUt0WyLvIrUZg7lbpN832uIk+9WCH/yC58wPNb0CB7r31gR94HUAarYJdiLaIYThkbdWihX+TRisDauvgnLknHFFOUE7Y+5rFX7YR01eIhRu/xCKDbZNNRWQnJBLhX02Rsh4UrsA+RUFSYog61XY63hIHxwasb9ilwEzE3rNAZ+boca1DNqtMRgNrTFCeIxgWrk4lLm/CkyQRd5F/uNf8rU5HZHBRys8C6S+FCxnRgtSrJaNl/Rg6mxGKBGJEdkhdtwTOJOJCglaQSOADjIrUdu6vgL0vQ1Q9FrijykttgOYbjf79s4vrdoxJOb0b5gcrN/j41k+2PI6QqHoBvzLa5/81bXa596VIu7n5MTBppQ19C6jGyGA16UOmXoyPQ3lBMYGeI437DWbRXTzx0tI+H50DVyycFK5hMXItLvXmhM7T9VUiFB5qUvGLPtuELhtZPdfnvaraZTVCGPhMu2JJxtzZ66qHBtWd4SsbbgA8iArEIev9Q9Xz+vJhjUUQRCB2Lgp1DOWk20O8v/sOjMqDqM7p1RqEWULPjiAD10fV0dpiLyWm1XVwZ/ww3h6y4ECtXoLicXkMS99apiS28i9482n2UhoSInnTecf9sH2VHU6VXy7Lf4dGLOe2aR+JGdNEZ+5kbIhlqxA5cAfN5KgFuVoIAuioGr3GjlPV49pZ4Ne0KvDtjPnPF7rDJ
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(35042699022)(376014)(14060799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qy72YUoduKphLfYCn6jQu4kELLYueMwHW9656t7MlZyFxkcqkg6vib9btvXamWtGjpOCACyNmlCyZu3BDOmndmp2IAaWo8nqnfJ3Zx5q9+DzCtYSfGVma6WoBHJzPbEYRiv1UkKHVAVMF1+7qrXRbS+EAforkKTeghr052jErFs821VVApiW0778tBx3EaoFDcQyeMp60TVN+RHgIAXoP6CPKX67pmyq/ymWtE3rWXyxqkIsHOz/PR86m6G3xCUjva8bHuNLMAAeW15TBuS15Q/lZvEeXOIyan2eSDlzd70F9tdy4q/GpfY7kKFF6GAJDglpeOMytriP7dX0rLcsHGgfWV03BstQoOh74JUyNcGyA4yjFSFOJkLTItQtHbmovvJsBKnW7DXMKiUsSgUhjX6Ba2EVFGfkzrAAkTSf0IDN3V0VoBa3qlDorCdrXyXN
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:02:06.7168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53fedba-b918-4493-ffca-08df1a552ea8
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11276

Hi Hugo,

Yes, I am preparing a resubmission with your suggestions incorporated. I
will send this fix as a standalone v2 patch and resubmit the remaining TX
refill changes as a separate v2 series that depends on it.

Thanks for following up and for the review.

Regards
Paul
