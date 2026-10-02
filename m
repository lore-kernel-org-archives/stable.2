Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023089.outbound.protection.outlook.com [40.107.162.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9374352C28;
	Fri,  2 Oct 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941148; cv=fail; b=uiEhLC9/lRu5AF+5jOTOH1Wqg6fogvqNcrtoSeVa89/2X61VBWzw81+E31fpbvvFnwKmQPiTTlnhAM7pbqYY62V8qx7RXMQ5TCmNCwT9QWrizqSRI4PwxZe7vQQYT/2zUG2yJMq0mcjO/NqQl0ZuhVq5d/C2rqu6M7jU9sf+VWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941148; c=relaxed/simple;
	bh=zdiGdfqHmtGE7sXZyHB3l+t/SlJs6GTT8n5f3f6efbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6ln8r2GX8KA9Om6ii23KmhKN6Z7i9+zbb26qqovU8fzUsgvYEOxFItVKkGoUH+b/SzCBmWO7/+DFBeJ2ESjGnvdtWCtFL9silhtPtVJbAR7fmT9QCuybB9bLZlLDDnWWKjgrIMclcCHy7eE3ZXuRZ20wy/ld+++/KMExi20l2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=oAtHaEMU; arc=fail smtp.client-ip=40.107.162.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="oAtHaEMU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2DhOiivu5lXiPbn7LXJFQwbdFIkz8gzRwKnTDNF4OJxb5seHCePjM6Qoo10f/LEYo2Dfgc7f8sVdcb+CcsD0K+PqXajc7b4SRzbwN3mjF7czBjKCyH2J4uafiPQSzUqQP5aKkwyjNn41DJ7rIsPB9ZOpDuQe2OOpu7K6Ft/rCfmB3gFJeuMgMpCtDX8jQWrAMRx/7YZcvb0hIey24FXXGxPrUmM3Lr7W5kAOSVcQtJcUbgor8ppUyyLvxYqkF3WTF/eyszYFGrgY4fR71L/r2S8NP1NnUJAiAewLiVqjZsis+UtZgB4kPf/WfczhqDoc2oqPN5NznDwoF+Vu6Qj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdiGdfqHmtGE7sXZyHB3l+t/SlJs6GTT8n5f3f6efbM=;
 b=EREk1mXrVYpKMcMyraow+xXX8/m46v5jNol+qbqrAr0XzgR6WWZY6nNRwqpVTtblWS2fB8W7E9/OCJ2GjteAzPD1XimM7NQHgW3vCPcrMDaJJLLIvB7Wkxg6SM8TxILGkxQ1Rw7Mb6vWaARmldry2K1rSShn/eARboViGnbvr58P0qZeqRD0lMdOlT8u/0Kr6CEjLwDRfreI8tdqU7DMjzTRdolSjvIYB5qr7wjjhR+Bmx8pmH/AOOVcXZaGmaY6wlFxjwuiMsKk1NgyOUHVsLS0hR0g5MvF6WQh0id1xgUR9u1eys5IOBeKEQl7yynW742wEi56hg7+HFrV4bTmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=hugovil.com smtp.mailfrom=ziehl-abegg.de;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=ziehl-abegg.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdiGdfqHmtGE7sXZyHB3l+t/SlJs6GTT8n5f3f6efbM=;
 b=oAtHaEMUKPTzKtQLsMAt+cHoJ2fwYs5oIHJ9Jac//uUO+0ZFfpppJtyDvJue+y2rKGQyIVqNnBzTioxp80qPb9cvVUkKnilo/k963j2jyBF7BTEZco2khw/ueuU5pP4l7mDIgWgI+EcmuiOBc8aJY5sa/Q3s1dMAhFgHZ0+EAuI=
Received: from AS4P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::14)
 by BR0PR02MB742772.eurprd02.prod.outlook.com (2603:10a6:2c8:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 2 Oct
 2026 11:39:04 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::70) by AS4P192CA0014.outlook.office365.com
 (2603:10a6:20b:5da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 11:39:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 11:39:03 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.86) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 02 Oct 2026 11:39:02 +0000
Received: from AS9PR05CA0085.eurprd05.prod.outlook.com (2603:10a6:20b:499::21)
 by AMVPR02MB12501.eurprd02.prod.outlook.com (2603:10a6:20b:775::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:39:00 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:20b:499:cafe::54) by AS9PR05CA0085.outlook.office365.com
 (2603:10a6:20b:499::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 11:39:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 178.15.18.66) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 178.15.18.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.15.18.66; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (178.15.18.66) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 11:38:59 +0000
Received: from vEX02.za.ziehl-abegg.de (10.1.201.106) by
 DEKUN-EX01.za.ziehl-abegg.de (10.1.200.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 2 Oct 2026 13:38:13 +0200
Received: from localhost (10.1.200.37) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 2 Oct
 2026 13:38:13 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <hugo@hugovil.com>
CC: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
Date: Fri, 2 Oct 2026 13:38:04 +0200
Message-ID: <20261002113804.1235444-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001120921.97b56c43423f40fcff265e97@hugovil.com>
References: <20260930143207.542930-1-paultyson.mbewe@ziehl-abegg.de> <20261001120921.97b56c43423f40fcff265e97@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DEKUN-EX02.za.ziehl-abegg.de (10.1.200.170) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30232.005
X-TM-AS-Result: No-10--1.022700-8.000000
X-TMASE-MatchedRID: u1zqiMeMcrpxHKHpX0oMcmyJrxBqx5NCz6TRdW3x1JxlIB58l+haoR5o
	KJXDoW/PuN5HWW7Uv2xpUfxmW8xINIxm1LjQpCqoW8gh3wzbqBNczpnN5SayTVo7GmCOJYd128g
	AxP/Ts6J4P0Lv165tYxec2TfXZ0BDRk6s6cAq1PTHhyirdw/CUWoE++m/YTuvXjUa5WCPzqkb1m
	WuENC5Oqcmqg40BkLbjineMlypRVEY61dnw7QU7H7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.022700-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30232.005
X-TM-SNTS-SMTP: D400075916FA7FEBB84D6BFAEDBC505D55A447843A2FDCDE30ED5715CBC093142000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU6PEPF0000A7DE:EE_|AMVPR02MB12501:EE_|CPH1EPF00000520:EE_|BR0PR02MB742772:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b884970-79de-4bb5-e310-08df2079c254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 PjqSphLaio87WOJb6dL6g6EseQGKzlKqlvHr6PGSa04SHl6ZnZzl69VcLp+Qw1Zhkfx2uAI/+ezvbbhq+IefSwHfLacDUCDlJjPzYV0HDgLraV9kgHeoUFNqcymV5KA4ZYQj5xARgrNGfKA+iEHFB19+awIJGYpu2qcIm3/eYKll5qTaYY31Kiudq0errLGP04wiJNFC5xBWEV1a4N0SgcpBToheohBlf0T9FtwFHpGYosn2euPm6Jhi+ZuLYxDNIWZyHaFKYWWU5SNZq1CL5f1UA/aS8JA4jDs3krjpYp1hVYvU7vNdiOivGE4OWg8SkxbrCwTp8gE/c6Xrixo4CIvUSFKXpoShbWlfZrjHHB5xOEfs+VH02FK/TOFAB/0CWP+HwwBC6QzUuQSFPRxNHNIXaFLqRSIQFn6wUFYYAMUvQRY+YwIZCd9Q+FsIL/QKeqLwbGwMQaps1BjBWE+AzP2zVapNFEwpcDDAaYXo+rwWqRKgBBj/pVVRseZw2sXe60KZb8Ab4WfKY74+IiD46dTx7wmd0PyClsPIMwIfPw40iGJHZ+8iMuat131mETc31NipwULAtP3SATa+p/U2eksQomHssgmVtk8AszvI02o+UcVOSU8ZfbvO0T40QyoyQmYrC1/kAZfW7OqKO+fEzKSdm9+KcVAgitgH24LHO5CMKERjCxch7bDOC67EP1S+vnhKCd94d1f+O6t8fZ4/Yg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:178.15.18.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: 3WLCMsWuk70tzmyCK82727alsPCSFneXd53eZiUe1yXX19pJhaEQYWlYDjtjSWpcHFhwUnkt0CpAkNwFV/lVq+ahb86lYBSgVa01R4sDMVf6zjD7E/gkv/UOGWmYM/MmOSKq0Fk5WjRLKXtOV88tz2UWvzzJRL48K9CT/a1fzGpj7uK3HYc+AxJU5vvSL5MKlNgeGwsGVCyoNCV7yqrM2g7TvknCTYk8VZHnwvTKYEzsx2yt0pANWQv1ZdWxQh7D36R99NW4lxIK2UQt5wISvqH2psip424KMJm6S/2AMvW+KIFp9Ej6+LDjxmAqjftqgd1QnGEqcmSnzYRitN0jJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR02MB12501
X-CodeTwo-MessageID: ee05f93b-7a0d-4aca-87d4-c097f3a2423e.20261002113902@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f5789500-da8c-4d37-55a8-08df2079c013
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|23010399003|376014|82310400026|36860700016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HhQY4Ll2xJMTJZZ38hQvDKt1Y04yhfZqZCElQXzK6TA7zTz9LX93MnqhkG+AyYzC8la8vMC5D0BCEmSKyDYGAQyfOEgm2tHpLyc0fBFFvCL2OFKKkoF1huLZF8vm/VUnv5uu4xdABQqNQbR31UIJyImfu43Y9XdNdKwAu5lyqsDFZR0FOXweCJ5PsvY/IG3Kk7uVYbmWwbcOSuQkVamSw0oZisYnQIpVRjdBml9ER923eewB7rLPpDWHNFqXfKPEDVFWMAc7qVuCwkO98YDbqzGZjy2/OzoadWyWRHt6SnrewCCfTrXp6rwfeD9QOxaPY50PBXKOX2H/PZ1Qaeh34e2zcqJx54I1YoyPD3fP6vNDQ1m/U9qXVWdCQS8KMjpigoHbE63jW9mNReeENAWouVx0oxk18cFBsLdlrk4DS2Sh5b1bSoQ5mi0Eh5+cJN7s1l099BoGBTjDl8o8ESoEsewNJznmwvc/r5jMgx4pyMX440p+U+WMyTvWSdbFwf7cEBB9ge6pjhbsc+ZDq2KR/MezGxNuSz8LVl1BtghRUaMaSbQDqMOdhGEwFIVHKUg9Gpp6F9Q9A76d83gh71vEKpKSG4jvgKCCGV7OQI0pwfaS41Dnw6JtkJ+iJwuUGL7oPsC8GHu0VRvRvQvl8nFVKU/P8Rad8cq07rB6lp/AGJU9Ajqv6Lfv8aOjey+kmAdHaLS6mrq7v4TeI7tAeaAz+A==
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	04SDmujxzWWzYMC8+6aBsWHz7Pxw+0sqRYmLsae58zSkqd2SYtaWwmrdRkafRO6HE1ZcwkGkgDUu/z9aQH6RmeaoT17Ci4P7beBQlJ5I/D1TD1nsrs44Ja1wBBpib6W9Zwrni5VZVa21QR2wg16uFHRBR1MoXR1V6M3S4mQoQot4H5fLFOHKSqIi7e0zUcTvQGl4zHRgeQKWHfxznU1cXs+LlHHjXQ+ysu11Wfop+VW1JfngG7k7gK1t7Q2smXq8V6/1875S6kWzstSPc7AEnadC78cYQpyy6BdHMw7YeAyuchFo4xxy5lBW0jgfuLaghezvgCW0gFBzJ+5mTWpFpdNmCpDkXFTJgNWdylVKAoA7vSsLfLdtsVm8v+1Ne7ycQt7vjp3AYigcQNsIqd4xvq0H5z7F8nafYtDm4bIgj3IwsXhLNTxY0ezHUscmFo+v
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:39:03.1443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b884970-79de-4bb5-e310-08df2079c254
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR02MB742772

Hi Hugo,

Thanks for reviewing and testing on both boards.

Greg had already queued the clean v2 resend in tty-linus before your
reply arrived, so I won't send a duplicate v3 unless requested. I
appreciate the Reviewed-by and Tested-by tags; I hope recording them
here in the thread is sufficient.

Thanks
Paul
