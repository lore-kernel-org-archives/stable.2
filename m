Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726E3C10B5;
	Mon, 20 Jul 2026 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579260; cv=fail; b=aOoU+Qt8Vd5vRtxF4jMTf7uoqF5mS96ItuSd+31WW5GizYe8ndAPQKiObQw74SzWGgCh8TXe4+dt8Zp4e4Eo/jttX4aXYCpUTN4iVzb0gx8/qgNoNtUodausNkn9yaTkPWgjQheQld9Vrptw6Y0xgBuoORRHp1fiEARSm/zUWtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579260; c=relaxed/simple;
	bh=Tbbt7BwpN4SyU3b3ZIonW7tg+gP850DM7bv9wlt1B/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nyvw0szlPVycZ+IdEG0UlXr3jpZqLg/H8WbUwAYc0Ae7DHtfwe5eST3lYf12aG6FnlhsjhtLksuvhZIz2w1PAnUxV2kqxKs1HIFHWZbbBruz6SrYIhsX4MrqVHqApEi7nNuNw0spZpUdqety5+JL7jaiMjJ1TP9C2zgsePuCLU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8nUmJ7Q; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8nUmJ7Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACMTewb1/kOtfBiBCb7UGEslBiXp1wljSpAc/QBCArPbUAEcA7qXYnU74XIBpLxnUNvn3Paf6IN4QQ9JUFbnxziZiZkP70rz37jvpWmIBQ80sRKvRH5auzXTuVeSbEcCfmmXYWp34d1MzJvS52HSF1MXwx+v1IRoeW3xkkFI+7CrCXBcxL99Q6OMvoQKPG4lCh0km6peqqZNFUUbvq1mOAzoNH0pkny0gDm1YaXrmg2vuH5Y57MMOtTtrnc48hH4QV2zORnPDJ2lLMxD3FxE24hVpc+KTFlR+ZDDKpPx+Zgr9IpuY5ogM7Z+2nkVDynt5WYmSaILNpRwL1VTWObZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zgOppVs9372bMP5bH+FM4kAsuyenQXkIMNhFGkYVC8=;
 b=ok9fe2q7jFnuV6pgDszS4zpYvQC4bakWzUmSHgBmKrmMlYGyIMXD08LSlx4ku05cilAMM/TfBD1+7W1usSX+DTqRwfBVzr/ADjK7NWG+q0QFmAjKibn0xKgG9GH7JCYSTk962XDCju4qRvFXRfHBwqNFVOlWiklWemDmYwLV2Br/Xi9J93PgDPY5jlP/bbgV4+3Gv1EP0cISxQTjc4AYbOR7mM1SM2MJnRI9pOlvi4hV3vTBEwiom2+nLdJTbBFSIlVbMbxUYGXWMGgNkCBXnRKAKfY+9D77aIZtnbPQCSPz+LFFd/6GdAp46SNMWlEW44lRGFB7q/qdgMz33qySpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zgOppVs9372bMP5bH+FM4kAsuyenQXkIMNhFGkYVC8=;
 b=f8nUmJ7Qp/V1B3w9YnGAl+nZvmlNS1hCh/hvelYSXJsvPk74x5x2hCd7/uFx7dDcwSV0F5WJI88uKp4cRH5XZ1h9WTOnnqC9rktt/dSw+Fh1WNlwILrRxGaaHbETdWmQOhnQhdE4/AysziCGqgYi63e8utj1Elv17+sJMV1LBijmSMd8oqYYLw/kRI2dcPkjBSS3Z6kkR/StbtF+pH2bBHlo9HQhu0CCdzROr3Pn2Lfqx/0vttioD/QwheGChu3CDRRLnnau2p6CmPY00Akgae6e5xjTANz12fS7e2DlVOw+nKFkA8Ahlgh179GbQPPiSugr5UFdLGvE+HOnNQPbqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:27:31 +0000
Received: from CY8PR12MB7540.namprd12.prod.outlook.com
 ([fe80::4eb1:ab21:a9cf:e72a]) by CY8PR12MB7540.namprd12.prod.outlook.com
 ([fe80::4eb1:ab21:a9cf:e72a%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:27:31 +0000
From: Lucas De Marchi <ldemarchi@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	demarchi@kernel.org,
	Lucas De Marchi <ldemarchi@nvidia.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/3] xhci: dbgtty: Fix unregister on tty_alloc_driver() failure
Date: Mon, 20 Jul 2026 17:27:15 -0300
Message-ID: <20260720202716.76000-2-ldemarchi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720202716.76000-1-ldemarchi@nvidia.com>
References: <20260720202716.76000-1-ldemarchi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::14) To CY8PR12MB7540.namprd12.prod.outlook.com
 (2603:10b6:930:97::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7540:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f029f7e-f3bf-4967-bf68-08dee69d534d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZvrBjffXGkUDGegDx7eT7fcUu7FBkqESE2zOh6c12XoCi8IEMAqLHBAP7GXkk/KtqVH6ZXdmXA/PtwTsThrSShHIcofvD9C5tdzuRekF7Llzw3+jACZZhPwOeSftTZICQ3l2g6tay1Y+IJQdyx9J2cCjxVQ0rnV14SUW/hcC4RpLENbCvp7s+b3GdNe1wINyKmX8sX34IIfL3xtolDlir5D7Zbptbhd2g0NWr/lYl9xTbXQq0cr1TJPKETUrxOBOvsmJBw0QmfgeAJrxNY6YsYpo2EY/se1ruSVcRb5MXcmeS3TcO8GFkO38LtCiopk2+KP8habGOWIIDFj8fZvEPoeNIZYaIpmGQVgstVgncAnUEGryCookHf+ECEhjTvMUZJYJtLDuNWWfx3MmIT6EurYdeX9c9zo5SVR4hHslKj0hsTQW2P9Bvjb5jxPdZQgQPlNeoYrVszbthjWf/2Cqz+Lpb3TiNug+wGv+O0XbVz1fJHqQZX+9Fa/z5+lTKXAnVIRnj7zOU01S9qMoCnCsi6IUX7hvWljn16NX/inTat8PigomMe5w2WEBbySNvuyvgc/Hp7q5JitJXbLiBvb9lE77tn+zy+pS/pLlFElQzKuQB4ZoEobxFoclq5O6Rh9DMKanDn8chumXegRTNPkRxaEEConnWvkjaecADCR09yk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHYiak8cupXzD5mEoH4BZnOLzYIyq8FnyvOCGl4AM989MV9Qz9uPZKHnO/Tw?=
 =?us-ascii?Q?hPO7lYU7/jznMLcKL6X4cHvzZnIFrkXs0wnr0JoVCxf1L865an3UXgFKIxe3?=
 =?us-ascii?Q?R3M7BvdIW6W37abX0ByJOAflqWOvS7HgSxtpz4s+cKI3jCS4Ytb2l8ZSeCfg?=
 =?us-ascii?Q?b598p750ywnZrhzSSHXtux6sNqwzlqJRmPFCmbg829HlfrPwhcmOCF+CnEoy?=
 =?us-ascii?Q?ibCUwRkc6rs8dFUy7oVNN+wnjRx/7PP07Uo97IH0UPrA+hzaTDrWfu6xoh+h?=
 =?us-ascii?Q?FIB1tFkMs1h1VQV8O5S5cvb/v1kc1mE0PfuoyxtNpI4lfC0qlUqZGhNh+EEv?=
 =?us-ascii?Q?MVJISeMFx8+zFrRhqLiyyaXi/Kf7++wO65uJoqvuLoPU/wncxK1JeCZchYya?=
 =?us-ascii?Q?NjwwdpUnFWZ0gnx1JZhgWNEHT8b15mrwXWeUZKJW7WFFQyXV9OMLkbAar1S7?=
 =?us-ascii?Q?NESLNUHVXUwudDWSWpG47z5LkxYZzzXYEEBmHt2Vv3exyFj5V2yJD4gdwJQP?=
 =?us-ascii?Q?UFHQV+TDTmVJOhQGHG6XB4LtMZ9//lpHn7mkhyYgfRd5ZPEhBuupfUBNKzaI?=
 =?us-ascii?Q?OpvmtXOisYxTMYNVH9cwOXipLd7Wv2uv9/I80p3D2cgrC4RbMzM2db0fOqM5?=
 =?us-ascii?Q?06wnQsO40zriD0UwoIRbk6c4EG4Yhti+E3my+n0rDLxOSFSrNHmTgtnVppjF?=
 =?us-ascii?Q?XfTmALpL164bzybR1toO4tDxOaR2nkiwvrmEhfiDsjTlGKdFvoVLRFDHoGBf?=
 =?us-ascii?Q?QL6PMOJa797KTLnH253kiIGu0TLbr8kkpldJ4Iy9AaQE4jgdn9V1ggI1o7Vi?=
 =?us-ascii?Q?SRFI+zIUzl1rd8YWswXxYc7xQGks0cXJK4/XRWk5cBKCo/S0v3oiK+uVSv1l?=
 =?us-ascii?Q?MSKdtzTaoAkovwCJnmrF0aovm/Rf31+JGUKtxzoiw76XG+fzRnZHK0q009P3?=
 =?us-ascii?Q?Wpv7bfbPUTtV9I5BHneogtRrytTDvGlv1rkzb5Qdj6Y0aZZDNOQPfW7b1Zlk?=
 =?us-ascii?Q?Rr4rQl4a1cYqp8cKYsBGNGT6i5Qa1XtW0edfCO9dafRDpt8gGtsHWhcFgQln?=
 =?us-ascii?Q?3xFpWWr/2ARwfSnCWaNGz7vSsglXdGwm9HabWWAzCZAH2+JEJGPgThUCfWai?=
 =?us-ascii?Q?i/lO52I0/hh07wkwLqyo4MWvQMUexEAO0EQtbrENVYibcvimMiCrie7VLuDy?=
 =?us-ascii?Q?qeVtFbzGfu5UKDr9FtqhhRiC/Ff0Zlt1v4m5kAoG7JIoRbZFus1+UhdUNlZO?=
 =?us-ascii?Q?xOvLmQ6P2cJr+daaPPpZgR4BuI1GrgDyOgw7OX1pwoi2G7sccAW6kRhy/2A6?=
 =?us-ascii?Q?MNMt1t1keN+QRlGTnSWIuCCbjYcOAkIM5Zm7jXdicWslZYQDe4+O2NsMrLA3?=
 =?us-ascii?Q?c68aFfnJAhXgMfXSsyoxostNB5S70OdxrjFiSDANOq5DyEJvqqf636ZV3Y7y?=
 =?us-ascii?Q?yPqkqaIGaJaOwoTS3oVbarZ/yZbbHRsHhEWBz5Pum3xIW5X5pW9gsTbS6ZqL?=
 =?us-ascii?Q?8EpDyBSZ98CtQNWOlgL5/oz/h55cePd91XHQAoVT5k0+1Q+m688aOxTy2K1T?=
 =?us-ascii?Q?JWk2EcH4zTUwpU1frTO2KG35zT+akfMlwN1I2M9SAHlr/QnfziW9v5USwDHQ?=
 =?us-ascii?Q?5Lq9Uzg6ReUh5rwrr9jx2ewoGTpNwiNSoEVQU818bcxIoI65snSn2TBnX+tg?=
 =?us-ascii?Q?+yuD52YM5Jhoa82ZNr9m5YabzHuWHh/2YYMTTUUzK+jzF93ANglbtfUAiAOR?=
 =?us-ascii?Q?+4LIWPqLSYukcPAjulqH6bRAhFQnjhc1odepOgTxt159KCz7YAT48DHGoOAi?=
X-MS-Exchange-AntiSpam-MessageData-1: g8M2vdeFzru0kA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f029f7e-f3bf-4967-bf68-08dee69d534d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:27:31.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nyCRF5BnAQaaWbMQKJ52qoDynza55UC6GiAZx5PAafoPLZB/phxv4xFekEUz7BToEOpKBnBOgzYTsRvS4PwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430

Make sure to set dbc_tty_driver to NULL to match the check in
dbc_tty_exit(). For that, make detached error handling path common to the
other branch in the same function.

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Cc: stable@vger.kernel.org # v5.10
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lucas De Marchi <ldemarchi@nvidia.com>
---
 drivers/usb/host/xhci-dbgtty.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 01decd46f313..7e44e62d6ea9 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -628,8 +628,8 @@ int dbc_tty_init(void)
 	dbc_tty_driver = tty_alloc_driver(64, TTY_DRIVER_REAL_RAW |
 					  TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(dbc_tty_driver)) {
-		idr_destroy(&dbc_tty_minors);
-		return PTR_ERR(dbc_tty_driver);
+		ret = PTR_ERR(dbc_tty_driver);
+		goto fail;
 	}
 
 	dbc_tty_driver->driver_name = "dbc_serial";
@@ -649,11 +649,17 @@ int dbc_tty_init(void)
 	ret = tty_register_driver(dbc_tty_driver);
 	if (ret) {
 		pr_err("Can't register dbc tty driver\n");
-		tty_driver_kref_put(dbc_tty_driver);
-		idr_destroy(&dbc_tty_minors);
-		dbc_tty_driver = NULL;
+		goto fail_put;
 	}
 
+	return ret;
+
+fail_put:
+	tty_driver_kref_put(dbc_tty_driver);
+fail:
+	idr_destroy(&dbc_tty_minors);
+	dbc_tty_driver = NULL;
+
 	return ret;
 }
 
-- 
2.54.0

