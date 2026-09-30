Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021076.outbound.protection.outlook.com [40.107.130.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FA4D7D5B;
	Wed, 30 Sep 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780238; cv=fail; b=pac6nibTTGIZOcO6Ylv+pC7ZpoJ9AzWcM+Glpl4s2WOAj5u49mvbrBtKBV+NoIx13hviEZkhRRpAHyusQN7eljajHg5o18YlZyEf4AJaotV8MqtPYO94lb7Rtdv6eLM4Ya0MJJ3J0uhp8plPsf/1NSqPJpGYt6/Qffb9/eXf5Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780238; c=relaxed/simple;
	bh=nsa7j2hw36Mmv26JG8VNexH9lvOmDUDGr91uiN6MOow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYuYriB2IjpNkhEWzCYGkH58Oiowww0iqCUf/qj3uJ0NGyQ747dKSl3tNBiKMFKOn/UwKwclIlvrOwYbjQmSQZ+Gv2Bex4LfvTyzuv3qA3IlxZkEFyjDEnY15+Neo0DIISvCJ087Y5e/65Ryd+8vkiThJbwrdaSTjSPc4kRr67w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=YvOVf+m7; arc=fail smtp.client-ip=40.107.130.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="YvOVf+m7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvm9y1HYce8qAJK9CujZaH5qGTStIpYE04zxQoMZMtt3R9JHoq5Lve1F/CpOfLnsVcJfVfdCvfThmvDO9VDyuXjlFB1KWC38J+/cUnR7kkgm7zYOn83PzbU0O2xHBWwOCtds+7uLr4ydmPRylJDxei2zzVejkQQiVPzerWErLp3S5quAQ2ml7RcgieTovpP+bM1oDyo2VoDopHxjhbmMN89NuFMC4uMkTi6NK66mBXJXa4K2/pGuCU/u75K/5Mml40sXX2s6uh9fadIMGsKbbyvb6AUbX7FHXQ0nq2v2Nevrt49rrmWpzIx16JdA/rnLQZTCww/hu4TRNPmXKXCHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/P83rFvKQd20/0T3KZslJ5nA3so+FACb0HPfBilsmY=;
 b=yI+k6FF/xN6ONAksyYKt+nS5Iz42A0pwgYUc+BOOUUmMz1mkA6tMrgAwYYXyYCDOPP5PBRs8RTjAEAOy3vdYflnWAJKFTuB7Z2NCaIsVJqWAbL97Hx8f5tbCTexbUINtpesbN7/Utk9VqpuUVchikd43PgzosY7eYtBdmH/NuSsKbLuz+j+HwF70IUiQm9wbfDdOcOZH2GxjEZJE8Sw3RuzEnxYbSVGmWkSHomwZHjmq4Hr/A/9CoH7AvVX1n0uWm8thXvwbzh1lUcdQmrXhQ96N/RgCx/rl4qHOol/i1x9PjaAAZ4bmj8adYpQxMXdoOTAKuDbVOSRsYCh6+7Q5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/P83rFvKQd20/0T3KZslJ5nA3so+FACb0HPfBilsmY=;
 b=YvOVf+m7BTzY8Lw659a0B9W2CTzKImygnHGSbTovkIAohzSbviUbGkoXF9egtqsrgWKIJsygN80y4o85+Ys0fx/YDXM4C/d/ibeK0WNqcXF7zECsOJdO8z2NPA/fzW1zOMdAMYFRWE078WzbALLx4doAnFtqoBVhg8LrEdsG6SI=
Received: from DUZPR01CA0354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::6) by DU4PR02MB11309.eurprd02.prod.outlook.com
 (2603:10a6:10:5d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:56:59 +0000
Received: from MA3PEPF00000405.eurprd04.prod.outlook.com
 (2603:10a6:10:4b8:cafe::31) by DUZPR01CA0354.outlook.office365.com
 (2603:10a6:10:4b8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:56:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 MA3PEPF00000405.mail.protection.outlook.com (10.167.241.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:56:58 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.90) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 30 Sep 2026 14:56:57 +0000
Received: from VI1P190CA0041.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1bb::8)
 by DB4PR02MB8725.eurprd02.prod.outlook.com (2603:10a6:10:382::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:56:53 +0000
Received: from MI3PEPF0000847D.eurprd02.prod.outlook.com
 (2603:10a6:800:1bb:cafe::1b) by VI1P190CA0041.outlook.office365.com
 (2603:10a6:800:1bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:56:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.242.194) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 91.26.242.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.242.194; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (91.26.242.194) by
 MI3PEPF0000847D.mail.protection.outlook.com (10.167.240.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:56:52 +0000
Received: from vEX02.za.ziehl-abegg.de (10.1.201.106) by
 DEKUN-EX02.za.ziehl-abegg.de (10.1.200.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 16:56:40 +0200
Received: from localhost (10.1.200.37) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 30 Sep
 2026 16:56:40 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>, <stable@vger.kernel.org>
Subject: [PATCH v2 RESEND 1/2] serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL
Date: Wed, 30 Sep 2026 16:56:27 +0200
Message-ID: <20260930145628.566535-2-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DEKUN-EX01.za.ziehl-abegg.de (10.1.200.169) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-AS-Result: No-10--22.781000-8.000000
X-TMASE-MatchedRID: xgjD+b8BcNEjT1OtLjNOO8FwCSR9lLGIA7zAJOd7U7GO46CtGFNzgB6x
	6GATv0yu33N9hXGm/eBrBIZaYgb6df713DZdglzA2fOmnfHgOUoKfUYWORZ3hY73XtTiMnCgOR9
	TNr9jiqpZz/xdoRU2o/GNtF37Q9hm0l0AwoUm6S0ftZuMZfm2SU9Xke28M87NCw80CQ95LdC0WV
	EGd9ktR/CiYQ9xUzmAYsRtQSiXxwevrjrl9OcF/dcjNr80SqOVgT7JgSKmNS/PxctgaqKz4WACf
	vAIOBO2kvfSBv8G5HjTWEuZKnxXM3kkrpVn/L8lju2XlcEx9HQta64Tt5lszJASM5lkTKECfDRR
	zBqJajaC4coG9a/q4eL95qFX87s3vYow2p/EmQJSU7TOghylToHV87ajhAZwVpazjfYi2Wy6dDg
	bOwQH7Hi2yHSIHoZsnbZX7Kshm6n9xFOSC4OKya39Nxr6In/3fH+EesxtKNVRCkSxJRCOByAtOk
	0TFyJTeNIWTzSSH53yHvs7OKapzNvUNTm/lfkGlEJO70qtU7ajg0lrtKMWyiT/9g75F2ivWjsaY
	I4lh3U7nRP0DvgcK7YURQHAp3zKlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.781000-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-SNTS-SMTP: 9B340118C0BDE41DD1F2E2E8D9F066FB9C4E522329365570E2E03E81581D15EC2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	MI3PEPF0000847D:EE_|DB4PR02MB8725:EE_|MA3PEPF00000405:EE_|DU4PR02MB11309:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a9630c-8da2-499b-b8a5-08df1f031412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|13003099007|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 bjTVCdQcsYlvzNWwNU5TNb43/4vNdqY/7WJAIsbNwT1DaLzUkatmjhbEfG0qxgoSEcivKkRKK/PJzSaXkuwybxeDfTNywXcxXjXUO6yqNT07VJeDdqv9kyYYWerO1VSE82ZmJaZ4odPgkWqMlxQPimp/xa0hw3kc7SFs20YkGHqqIHzFZo7Gn7hDUUbwpAzuwj3DKDtEwu3mLn/BPvYyTgmu/wSflfxwW5oCMZTdaBocKmBjSqTI60eD0uA7pVEhPlRn3Nc+Mp9+GLVmAHLxi5ehw2JzRGvxRH8fInrtDwjIgBW6YlOZmAgmGdRBSY4zJIGDfwonYrZwoexOgxdwVEVnbTiWz4TuHEWbI94yfkRDdiMDZ5t6n41hqG39EDFfih81HHo1stCnIDu37j1cZYu09bZ8B+kBPegQuWKt7Ag02W7McXyu549bPy6+sbhCN9YKEiKkBPsgV/p8nAZQxtBeEQeUf4tt2Tqo/SOODWgZW/jETJ8d8e5/sOkGV7bG9bvij/uYRAaMnrb0348sw3CkpyQ0Xtc8bQij+8DRwkgrMns13TTKoRK8Ne2nPCabXBUKby2YmDyyXqdQCbeOZ3WvD+N9VZgiyb06iH1sZFx8yR+Dg1I5mPrd1o7Z5lxTeu0BQ2GofywvU9QsNWx70ijPn1i/VhPl+jaZGg5KWo8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:91.26.242.194;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(13003099007)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: uCIOIgsPthad5jP9MvCrwrF4FUCanunplj4iTv3e87oCyz7+ppaCqPYVyRY8+E85xDigkw3XUFXaUhd+z5SQWnT8WFTij00s8MbFXEhBotFCeFwDkkia3QqfPun1DHYt6UF76IC6DVijRiA9zc5JcyFoP/TsFUDZ1rrXPTFJq1LCvgLwPfwGh31cQTGFOdwr/za5G1owfR8sG0LrqxM53eXhTGv/Jh05q4jD2SCaZBratNIZLln7yCjE/aqP7NWMS2TeNH1VD0V7EhMFqRb580edzQOOvcyBPHujB+2nLMqCba6Z9EWO9a3ssvyLDT8xKUNByfskgart2qa3eTGcPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8725
X-CodeTwo-MessageID: afd93e67-0d17-4789-aa3e-fa5154116fe5.20260930145657@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000405.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0e2676b2-ba07-4f90-f28d-08df1f031046
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|14060799003|35042699022|82310400026|36860700016|22082099003|18002099003|13003099007|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	RyfLOlzoPXj4mlfG6P4J6ukCEHPjs9GjeVf5qBUe40IyOTWd6ycMNkwitfbqS0kpSs6JzDnBn5Y6yy138YzKrwdChvcZdgjXYreMW6oKaRCCU4AhwS1rEXnthk2dhBXiH3bCFaZq4MVez+L8Ia5Ov6vBxGihZDPVQ+vW0KQB8tOZlTYb3oWpscJ5m8Rsc9/8YggiNcP/mIE847Ad/e9kC58hU9VshLsMxI94O6u5MDGJN3X36yNKRjVnRYpLjWcgKM8lC5dT7oD7nTXUYM/9IG8x76HHxVTtLUnFyu6a6OuWMilRkj1GSYSuxsAvdtbgkjPh1fAVbIR8n0ZC3bcv6jB5c3m9sRluVi7ew5FIA44F1u+F+reHbBK9N9hsOBqXyrW2xfxXEMN//63yTGezIgRo4yWoxvY31ZmakUp6cCI1t7r7cTkKbHhVGC7O1E94Wk0VWiYrNVfso11IwxSwfUuN7tJRayR9yXaLi/u4RNu8+m6lM2feWpo0sIJJ/+G1PVDOHMS8hv178Hx7bRerwSBDw6tHWCIAEh2MInnxjEOAhL16ACEmkZFsWzXXMKAEdS22PUKwCKQzv7sdz9GSA7WXRqW9mMiWnU3e5Ce/GhuD6QAETiyeahQ6BuSsGF+saCA8ML12ZyPdRvigVBUt4JmVsuU7SijpB4zxjGnkYUk=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(14060799003)(35042699022)(82310400026)(36860700016)(22082099003)(18002099003)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0SfBwima7wAp6DivoCvK84zIdloelcXKuc00gE/yo6Doa1tigDWNJ7i+SkOcQ+tU/r4WmtdUaVVzX771gLHs2hOJPzDWl62aqTcDJX9I72URtpU5H9VNaCMitbvm116tVA/ZNQdJAwHVcyYSA14YIQ+DGs87dvBe+YHW4BItckZ2LgpXPLkCbby9BUpCti522T1zDyzhBoLsDYW/fGDyueOMkJ2ALwNtkdNEhQXe6evQ+d9qNnXwAmilRuNioJp2Xugyj5Vlora2bzt0KVFAfN5iXpRHjWUimgCGgtphDeiHrqTl9Z9lxZfJjQm0um3mRAEaJwAYotexvseMqY9Hc5HDy/zVKFxP3B5yFMJQb5/Cz2FvsCyhX7rByhj9WDfasxHGIJ/nKX9D7hrHhOLhdNeyfMsxkxaI+/K4pEUm0oENFLUZ9bI1GvmMgrUfpTu9
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:56:58.8814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a9630c-8da2-499b-b8a5-08df1f031412
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11309

sc16is7xx_handle_tx() reads TXLVL once and sizes the hardware TX FIFO
write from that value. TXLVL reports free space in the hardware TX FIFO.

On this SPI-backed path, hardirq/softirq activity, RT scheduling, and
waiting for synchronous SPI transfers can delay the refill while the UART
continues draining. The TXLVL value can therefore become stale before the
hardware TX FIFO write completes.

One failing ftrace with the default 8-free-space trigger showed:

  tx_start       txlvl=3D9  txlvl_read_us=3D580
  tx_pre_write   sent=3D9   pre_write_us=3D16
  tx_segment     sent=3D9   seg_us=3D364
  tx_post_write  txlvl_before=3D9 sent=3D9 txlvl_after=3D12 pending_after=
=3D29
                 post_gap_us=3D12 post_txlvl_us=3D130

The driver read 9 free spaces and wrote 9 bytes to the hardware TX FIFO,
but the post-write TXLVL read still reported 12 free spaces while 29 bytes
remained queued in the xmit kfifo. Even allowing for the post-write read
window, the hardware TX FIFO had not been filled below the 8-free-space
trigger, so no new threshold crossing was expected.

The captured failing samples had the same pattern: data remained queued
in the xmit kfifo while post-write TXLVL remained above the hardware
trigger. The hardware TX FIFO then drained empty before another refill
was requested, producing an unintended gap on the wire.

Fix this by re-reading TXLVL after each hardware TX FIFO write while data
remains queued in the xmit kfifo. If TXLVL is still at or above the
trigger, top up the hardware TX FIFO again. Stop when the xmit kfifo is
empty or a TXLVL read confirms that hardware TX FIFO free space is
strictly below the trigger.

Stopping when TXLVL was equal to the trigger still allowed TX gaps in the
tested workload. Continuing until TXLVL was strictly below the trigger
eliminated the observed gaps caused by stale-TXLVL under-fill.

Program the hardware TX trigger explicitly through TLR using the same
constant as the refill-loop threshold. This prevents the software refill
condition from diverging from the programmed hardware trigger.

Tested on SC16IS752 over 1 MHz SPI on an i.MX6ULL single-core
PREEMPT_RT system, transmitting RS-485 at 115200 baud 8N1 under
continuous Modbus RTU load.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Link: https://lore.kernel.org/linux-serial/20260623112225.82386-3-paultyson=
.mbewe@ziehl-abegg.de/
Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
---
Changes in v2:
  - New patch arising from review of v1 patch 2
  - Added a fresh TXLVL read after each hardware TX FIFO write
  - Continue refilling until TXLVL is strictly below the trigger
  - Explicitly program the hardware trigger from the same constant used
    by the refill loop
  - Corrected the root cause from trigger-level margin to stale-TXLVL
    under-fill
  - Removed the max310x comparison

 drivers/tty/serial/sc16is7xx.c | 38 +++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index fa7805d2cde2..1f7e98c2b570 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -216,6 +216,8 @@
 #define SC16IS7XX_TLR_TX_TRIGGER(words)	((((words) / 4) & 0x0f) << 0)
 #define SC16IS7XX_TLR_RX_TRIGGER(words)	((((words) / 4) & 0x0f) << 4)
=20
+#define SC16IS7XX_TX_TRIGGER_LEVEL	8
+
 /* IOControl register bits (Only 75x/76x) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	BIT(0)   /* Enable input latching */
 #define SC16IS7XX_IOCONTROL_MODEM_A_BIT	BIT(1)   /* Enable GPIO[7:4] as mo=
dem A pins */
@@ -647,6 +649,21 @@ static void sc16is7xx_handle_rx(struct uart_port *port=
, unsigned int rxlen,
 	tty_flip_buffer_push(&port->state->port);
 }
=20
+static unsigned int sc16is7xx_txlvl(struct uart_port *port)
+{
+	unsigned int txlvl;
+
+	txlvl =3D sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
+	if (txlvl > SC16IS7XX_FIFO_SIZE) {
+		dev_err_ratelimited(port->dev,
+				    "chip reports %u free bytes in TX FIFO, but it only has %u\n",
+				    txlvl, SC16IS7XX_FIFO_SIZE);
+		return 0;
+	}
+
+	return txlvl;
+}
+
 static void sc16is7xx_handle_tx(struct uart_port *port)
 {
 	struct tty_port *tport =3D &port->state->port;
@@ -668,13 +685,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 	}
=20
 	/* Limit to space available in TX FIFO */
-	txlen =3D sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
-	if (txlen > SC16IS7XX_FIFO_SIZE) {
-		dev_err_ratelimited(port->dev,
-			"chip reports %d free bytes in TX fifo, but it only has %d",
-			txlen, SC16IS7XX_FIFO_SIZE);
-		txlen =3D 0;
-	}
+	txlen =3D sc16is7xx_txlvl(port);
=20
 	/* Handle circular buffer wrap-around by sending multiple segments */
 	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
@@ -687,7 +698,14 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
=20
 		sc16is7xx_fifo_write(port, tail, to_send);
 		uart_xmit_advance(port, to_send);
-		txlen -=3D to_send;
+
+		if (kfifo_is_empty(&tport->xmit_fifo))
+			break;
+
+		/* Refill below the trigger to enable the next THRI crossing. */
+		txlen =3D sc16is7xx_txlvl(port);
+		if (txlen < SC16IS7XX_TX_TRIGGER_LEVEL)
+			break;
 	}
=20
 	uart_port_lock_irqsave(port, &flags);
@@ -1139,6 +1157,10 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
=20
+	/* Sync hardware and software TX trigger levels */
+	sc16is7xx_port_write(port, SC16IS7XX_TLR_REG,
+			     SC16IS7XX_TLR_TX_TRIGGER(SC16IS7XX_TX_TRIGGER_LEVEL));
+
 	/* Disable TCR/TLR access */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, =
0);
=20
--=20
2.43.0
