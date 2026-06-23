Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020081.outbound.protection.outlook.com [52.101.69.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B831B828;
	Tue, 23 Jun 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234838; cv=fail; b=ISmqEoWn7+/8jmtua/kasLmQAKk+g6Mfj1kciXKkpBDVFwPgFoZ8uEwjeO0UOGLvkY10HppknWG05eaBHMNZvOwNE7s46vlBW6kYo2linlI0Kio27gsBWCrJAR7GcvfEIM1vBvUHk2PP9+4ITjH7A1JYECU1Y5Zvrg1lcAGYu0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234838; c=relaxed/simple;
	bh=xkCWM3u+RXN3HMrK2RfmxbrO0u4LnMn8M5l2fur8E8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1/5Ez2ovc5TsZYAlo6j4rYL0S19sjfjX2skkc8Tc3ojkqLlFSp20+t4R7jfQgkiDuWEyd68YD2YWMdzmno8bA7KYMDY+7Da2KPRbU/ZSJIB+Qz83HRonTAzPalkfma4D6n2GZoHIJjjDb5H9gekHBqRxmZBUl5coAPWxse0hKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=i3vGM73r; arc=fail smtp.client-ip=52.101.69.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="i3vGM73r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1QUQyryDD037espIwGtVt2HcX52wwP5LDWuwiT5H95fLdpJ2noR5wDMLVp/LOr9Nb9b6DUFOd0gtBXGVD8tlLz/Z/YqXxp472jG+2n2BiEAUhJyPTKRllPsDwrjcnzNKphsxY5UPtFPLY/S/Fw+7R49yQvd6T5m4kN1WO27GqAtLCQdLtUYmRGgp7HEZ96L6Ag6CfUb5Sp8WanUFVAKLArqEz7/KbXAQHz78DpxdOQ1Hmz8959oUfpM3A0pnxttPa6h69857UQ9c9sEm6CpHxVdnDs2ZYnn3UfV3O/bSPpRrARjuHgFjMcb6+FZ5Bn+8PA1wVtQ17D3OoPI+F0Atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GOMdTAEmixSdQ55ofelHeZTazdWAILvCay9evFD37o=;
 b=cbY7X6YV9iTa0tshoTvZVf7LVO8mZrtomEIcDcqkGOMXtG5323q3v5G9SXbgEj9v/sOW9rFsug5qQ52kro3qimgVtAJ9ytqnxpodoq+tjphqqxMeeqfYBDl6wgrv77NRCkBVLDucGoQic4sPVP1xtO0n+j/Sbz3kVPLDYk4xjIfkPTKd8YEwXmTU2oIg9d2jr9fH/SYXjcKZjW+Qrtv5tn1EnBKdKtasXM2XplXAy8p/gZv1K39Hh2298meAWxQF2/OmrqoTCS7yWcvw4scR5jO8xsQxMDzwRlyiLzSFH4+4OWiLr34POSQKgqyOmk4MOQ5wzh1C7A/yQLrfhxUWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GOMdTAEmixSdQ55ofelHeZTazdWAILvCay9evFD37o=;
 b=i3vGM73rR3zrzBcDZmNDxk5HeD+C3QeANYv3qvowFYBEoI5iNvGG0t2QrJEKoHrIwyWED6ZAen20cM3hOWXdU/Qeuxt8T6lh89XwzsGeOMZ+nEf6lz10fQ3CGbtk1eGOjNz/qflgavd0Op/kIkoUYpeIdtjdm0r2sBI38axI1bs=
Received: from AM4PR0302CA0027.eurprd03.prod.outlook.com (2603:10a6:205:2::40)
 by DB3PR0202MB9036.eurprd02.prod.outlook.com (2603:10a6:10:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 17:13:52 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::91) by AM4PR0302CA0027.outlook.office365.com
 (2603:10a6:205:2::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 17:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 17:13:51 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.93) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 Jun 2026 17:13:46 +0000
Received: from DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) by AMDPR02MB11550.eurprd02.prod.outlook.com
 (2603:10a6:20b:73b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 17:13:43 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::a6) by DUZPR01CA0056.outlook.office365.com
 (2603:10a6:10:469::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 17:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 17:13:43 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 23 Jun
 2026 19:13:42 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <david.laight.linux@gmail.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>,
	<tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent underruns
Date: Tue, 23 Jun 2026 19:13:28 +0200
Message-ID: <20260623171328.153735-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623160759.506f456e@pumpkin>
References: <20260623160759.506f456e@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX01.za.ziehl-abegg.de (10.1.201.105) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30024.007
X-TM-AS-Result: No-10--16.209000-8.000000
X-TMASE-MatchedRID: u7Yf2n7Ca/2HXEtxeZW06Ka5LaHlPm0+nOh7yddoSeOiMrI1WZc6u31i
	NLYHUO6nvowtcqHt7gd6d7XUE/oZlCq+IDhKu/cW3voO92n3LCrWRI6+saz/4ZdigZi17dHq/7V
	IAujYlfmZlqCQ5FwWsiwxedL7fMGvbvdYkHY6wfEbDP4SVbyWhgrN8TTGJsc0Paj0VwPn2LUt4d
	eikMpofDMs/CnMa0Mxvgzz342VCJUsST2dyZP/gXzRkrQz4xEZJ3y+iqiko28oEQF9DEP4Hai7N
	h532INSumvj5sw68ZLKvNGNmG0SU6+eCSMeOiOkFNPcKKOC8NjbyADE/9OzovVUZDyWvrKuiwAy
	D/hxCLwD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.209000-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30024.007
X-TM-SNTS-SMTP: F8BD814DB25496109693A2100C27603B9ECAFC5B53004B1A44330696E6834EAA2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU2PEPF00028D11:EE_|AMDPR02MB11550:EE_|AM2PEPF0001C714:EE_|DB3PR0202MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 119a5ee9-f125-4c26-2c49-08ded14acc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|30052699003|36860700016|23010399003|82310400026|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 I3tGkMhjDU3WmcOEgoINJL1rvhe7x1Amw27FBykETXRS/NpyK+1xi8qXArkGEPbtW+uOe2YytDtbQ9DZRl1V+CjyQ2usnuR8OkRsej7MOa2QiHbBHI3VJLi20ykP9qsQ3/2nqoqTV4aPBCjwQVYkqW2qoDs6RAbQF7ALwxACOInaPd2x1GTiMsE4ZsznNGv0ZMc8d9h4QQyz5656ygyNhm5aPrjQ7gAic+u4sZzRHFkmQ+SZ9MZHv8TP+ggcXm6UCa8Y6x9Bg0e2C6bFTK91HgrHJiBuT72nPqDzfCzvSP72D7JbfdfvKRCF+IjTiAXPynMNWFMBviKSuiRJPrcqQb7htG0m1ynodRAMYjMqT2uBvr5UFJZWNU4mzBnJ/IfeqLidYbTrxE7OtBh22l+MurhRT5w87T1PhakOjFi7esIFgSjRiXBF0wJSqHHMD2PTJHk5vYXAm6rZd79DCYAFWAS3utZTFk2XfYNH+78ehmjcJ+Yys8HIxD1BIBrcJ71uIIKNVXgXR9bUe2zYsqsktJDQ5QJcMNkbhAbgKu2qQZDgFok81BzpS4jZI28QzYAEK0JJHaU28tvt1mhQJEX7pDhWYXNXEH2z9deRwtDYh3ma1Vt5OMzEe7x7lf6XUGiSh7dT1SQiUbxCpK0PbUaEj3nZCt5VYmXRNBcCWEY2bsE3WTSttK1rbbUlnENVwrRWBTaxDdrmDUDXpoo5r/TbgQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(376014)(1800799024)(30052699003)(36860700016)(23010399003)(82310400026)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: eAMTf7FWeFiYTV9Ab+1USAj5PACg2pDC43VvfqzqALlxibu3N/QmIwMm+WG7irv4tcvBZ1m/DKJ7jjDS2+4geiqDiS4PYJccN+LtQx7a1qR/B9U+IfIyxTxFNJ+yTcV4AR2IhLATbAFbIJKUoOaOIILRkU1v/USAFDQApScjvlq9QUUrdznDhKQ1yWNV7FlaPl/PupDSdlQzRU00p+qHEvrnm65NNCKgFc8ZtQpAc9oO/L+MGQXPuQPUisqClfMLyMYPAIKu3Qj7OyH3lZ3q8CsAg84KT+q01IUQzDeij6smOGjM3E2aHWq0R2eb79GAwLzAmEjydLKTbPWt0y17yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR02MB11550
X-CodeTwo-MessageID: 5b9e7555-f5a5-4947-9da3-7e5b352123a3.20260623171346@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	48792bcf-1d08-48b1-f2b3-08ded14ac761
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|14060799003|82310400026|35042699022|376014|23010399003|36860700016|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XpLBqSQwJ3p6PredcCjB+6jqfDKuyYLhQrfL3sqwdAROoj51qQEketzK3FCyQjhDUl2ieJBA+r/GKDF3NSgZUzkWhUvjPCPsXl5g4PSKNEvDM4z29J7ZfLfhIaRl1DNcv0eDoKfjLMT75zMvQ4VUuN680fexKLJvuCfbtyBcrm/g9Hpm+NCGKvAxnpp/gehj+caslFNn1eOa9gpI8KZLSAxH4czv0nZCB8vttPdRUzikoIgAwy6qN9LQ3I9ZoxbXoyqY1qIYH2ODtxpaaZPa5zHwFUmJuTWSuvxUfl6zCUV5etxYLTP1CuUUQUwEBx5yGrVsUeZZsIVmjd13XMEJK0T9kW45O3Cc8DI33uWze6IakiFvIjkBIZjU8ia5E82NVaQaDPllcSI8yseCG9IWcqCL2Oy00gbT9YZN5CVuon09o+0Vz/KGgIA8m+8Uk2tW3ttwcAaM+gVu/rSvlSk7QIfHk5vq+XZVbabuqMbqTFpF7j5plGM26/AecAPrxp2nb+IgX+Z1x44+sfccLawo28PRj1jr0rKQwe3Nc1x5KziEP7TtcEVfy8NWMdez9ztt/fOeFuW1Nvui7Z7jCir8VI+lhVQVZNa8D6mmWLcWANaS9vfdZMGLv0xJ3s4aPVkDTnbMK1Shqw1ukFcvbTPIyMrbM7Ki2xNDJQsCcXZ67s3bewZsranR3BCOVH8WZuMdybZUhuNVeMkPm6+DF3V3Wg==
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(30052699003)(14060799003)(82310400026)(35042699022)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SIrNiZfnrtJa1dVMC83yVLUDVRqlhuohmq7jCDesrnIAutDsGqCBlQlK37+owPfBZUASvc1WG6FMrQ8Aoxw8gXmXXB2jWXh2+nWaVgZGMeeWrI+tsno6k0DpLr/1rH20649UEhjgdujd0edjlUlUh6cy2qd+q26SrGUYZdqc0kKVtWhPb8p9+BOaOgAdbR3KS5gMxSMC323dYMiEU0rhZuYZEbs2sTfjOgJUSB4fBczHjkMRYesp/Gxvf6fqC12jBLuUixQwAif4cs9C1/s0Cz8dMIoOoH/hm9A2FRsCpzB1Uoo6eX5PiKPodDHKLTokRgzwE/fO06CsRHWGXI5IrRK4D0NGnWjtk3V6j/QldXtgCHmZIVNflIeRtECKUuPkQhb/4cZfLyBx/cuCotMsV5DLxris7sMFjbS8JKY4ZFmXepshhuCgyrPLtU/MlbJe
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 17:13:51.9079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119a5ee9-f125-4c26-2c49-08ded14acc63
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9036

Hi David,

On the test system, the relevant threads already run with RT priority:

  irq/134-spi2.0     SCHED_FIFO priority 50
  sc16is7xx          SCHED_FIFO priority 50

So this is not caused by the IRQ thread running as a normal SCHED_OTHER
task. That does not remove all latency sources, of course; on this
single-core SPI system the threaded IRQ can still be affected by other
RT/kernel activity, IRQ/preemption-disabled sections, SPI transfer time,
or lock contention.

I agree, changing the TX trigger from 8 to 32 free spaces reduces the
per-interrupt time-to-empty margin. With an 8-space trigger the FIFO
still contains 56 bytes when THRI asserts, while with a 32-space trigger
it contains 32 bytes. So the v1 commit message is misleading when it
describes this as increasing the refill window.

The observed effect is instead that the 8-space trigger causes many
small TX refill events. Each event has roughly the same cost, as you
said. If the handler runs in time, it can catch up by seeing more than
8 free spaces and writing more data. The failure happens when one event
is delayed long enough for the FIFO to drain.

Using a 32-space trigger reduces the number of refill events and the
associated IRQ/SPI load. It also reduces the chance that one delayed
event lets the FIFO drain completely. On the tested setup this reduced
irq/134-spi2.0 CPU usage from about 15-17% to about 5%, sys CPU from
about 51-61% to about 19-28%, and load average from about 2.0-2.2 to
about 0.65-1.3. With that change, the observed TX gaps disappeared.

So I agree the commit message should be reworked to describe this as
reducing TX refill events and IRQ/SPI load, not as increasing the
per-interrupt latency margin.

If changing the default trigger globally is considered too broad, I can
also look at making the TX trigger configurable or limiting the change to
SPI-backed devices.

Thanks
Paul
