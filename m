Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023077.outbound.protection.outlook.com [40.107.159.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A83D891F;
	Fri, 25 Sep 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340910; cv=fail; b=af/FH89wexpG7VfY3rrk4TpgCfBpRnK+4UyqlHyrcUXo0nMu9QqdOlNygS8/toTQWH4t3dnEgm7pfWUHrc09fjvZBKXc3nBdN/hPDS8KwMLZRfcDfW5O5VW6wOz9DA4H2s3kVtMnKLsAYfc93hexvhcYY0VaPNqG5Q8pSt/+Mg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340910; c=relaxed/simple;
	bh=S464YIw4m9Bo0zEOkrWsmGuz+wQka1iKhO/djdkFQlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iTwGfLl+tEc/rntq7mTZshsQPdPFuIqxqzvHiMA2aQlk2/q+hwhkCvmw6b7RciH/Q7YSxAo6e3zuzX296AfYFbf+7B/QYTAdy8UfnR8HpIIIrRgnoynUFjg7vhrkLT0C+k8eDV9o0r2KxKGSj5ImWyyKp2KWrM3KUqc3hXyEQCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=cCzB3xKj; arc=fail smtp.client-ip=40.107.159.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="cCzB3xKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3v5R+CIMYGZ2E/+nQly2W4AkqssG/HDvOuTS3WY8wdkPf7QaXYDzbkqJ4y4yKZ/ebeDhC0+BF1TVfn8/G5aR+tY5bU5c5cAVWnDF8Y3fOjsZr+/jqT+e+1JHKrXyuZt1kv4KiFxVPNo85dus3gx/jyIDA5v64gzJrx6SPx0Kfi0x+SohMXE7mt9j3fPKz/MYYehynSm2PrebBrtD7AhBl27zoh1c+Objbec3H2gLH0Tu/1O102u28miL+qWpHge/YoWWqBKFEz9p5I77PFmd1quEmkk3MRFXj77xk6rUp0OAv8oj6HzkvLlgyauFZW/hUe/LiocOjR7CRZtXGfJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSIQvgk68ADZ6hnkXQ7gR6xxYu8W6UvZh80DzHSmimQ=;
 b=LFXWqlseOQ+ljQn3IoqgsD0Lxymko2FzA7/gwVBJ035oYlZisU+wtBLlzxEcMkoNOkzRpQhTTtK6KfOgqWsswLGsovzX0fLApxEI52pzQ/GmI/PZmpxMzfG6QUz1AoqStyFtexaTvTMXrtr3lo9Bmd9yJDRaBMsr1sAhAdVr2BCdUatXPsGzxXBuC4zm6bs0x93fSDztxS3lB1tF5Oje/xzPQDcQ5iGYAUW3IzESxldLuD7BgQaQl9Jb8+PkY6zJWIjlxnDrXbjdzM3YOqydUvZk6ZEGoUt/YXi1zqrFp3eS9gVLfMHBM5jSkJ5SnlFyPXnnrU6NSLWgqUgPMC42Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=kernel.org smtp.mailfrom=ziehl-abegg.de;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=ziehl-abegg.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSIQvgk68ADZ6hnkXQ7gR6xxYu8W6UvZh80DzHSmimQ=;
 b=cCzB3xKjRXzQtt9ulay+NZRYMN+kx2Fvm3hmOlEM0+PFQKgXrQp9Yejyo64UhKyKvkVCdgV2XiAlClLB4XsuArNs6zwMVZawcqLpN4wptFazWRm1x7dCxyIgj4kflOEMppRqrl82q5SS8Cm46FtJZypMVyKLbWEOLqY7J+MSKEE=
Received: from ZR2P278CA0056.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:53::8) by
 AMBPR02MB11623.eurprd02.prod.outlook.com (2603:10a6:20b:735::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:55:02 +0000
Received: from MI3PEPF00008493.eurprd03.prod.outlook.com
 (2603:10a6:910:53:cafe::17) by ZR2P278CA0056.outlook.office365.com
 (2603:10a6:910:53::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 12:55:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 MI3PEPF00008493.mail.protection.outlook.com (10.167.240.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 12:55:01 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.80) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 25 Sep 2026 12:55:00 +0000
Received: from AM8P251CA0018.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::23)
 by GV2PR02MB12257.eurprd02.prod.outlook.com (2603:10a6:150:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:54:54 +0000
Received: from AMS1EPF0000009D.eurprd02.prod.outlook.com
 (2603:10a6:20b:21b:cafe::56) by AM8P251CA0018.outlook.office365.com
 (2603:10a6:20b:21b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 12:54:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 178.15.18.66) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 178.15.18.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.15.18.66; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (178.15.18.66) by
 AMS1EPF0000009D.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 12:54:54 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 25 Sep
 2026 14:54:52 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
Date: Fri, 25 Sep 2026 14:54:43 +0200
Message-ID: <20260925125443.168134-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX04.za.ziehl-abegg.de (10.1.201.108) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30218.007
X-TM-AS-Result: No-10--7.198600-8.000000
X-TMASE-MatchedRID: xm/AKV1+13TIEK13nCa2RdwK3aKXLlLAOteHVGUMZ+DlbwjdfEVENEBz
	kHVLTkBx4AQ6En/+N1aoPdIvr1LpWlL1WjDDWM9gwroDo7M6Ycy9TAVy0y48Gznirt1Adl4gSNz
	OYgASIP7DEdyTYYzGzQ2FPEakzVvqfJYE9GoWRJGxkiMlzRAr9kGoVfTbC+0PpK0cdqYqf3M46j
	ujf3NZ6MUonAf5mkE2gaDFHNp6hidigYd5ESghxvbi+YTr2htSEpRQcMr0mi6QpDFuPdGIG8Kkn
	/6EKqY6AJ+dkE5Z75Xpm4uj63ofZ7wCrakag8ujYBS4BO08ckOB37bQADgKr4CpIfHsTRJvxHtx
	9qt/1r+xQ8t+/wTTMuUTedInjF4ziRz4gknBIqAIjw+vaMoIm/zUKvBZSHFYEgg3cwDHl/2jYFS
	FiWs3onGDuy8y1qkuImxnQvgkai1WB15Xa8khtlmblT0sEa1ozzsqyMJb8JpZCp8ExgdxTMsDlZ
	ROI5+mJMs/b3X04Tc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.198600-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30218.007
X-TM-SNTS-SMTP: 0D810BD16A8979413EDF4B9A4C19D37CE4B3EB5C163071EDA89D607F1B66CED92000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS1EPF0000009D:EE_|GV2PR02MB12257:EE_|MI3PEPF00008493:EE_|AMBPR02MB11623:EE_
X-MS-Office365-Filtering-Correlation-Id: 1072359c-4602-4ee2-0cec-08df1b04369d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|13003099007|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 2CKrgHTjpQKNbzpBLLdhGV02Uq8FMSa1nTa8WRQdzmx1Iu/rCEqBwqInW5fRyiVshKqv6V8aO7rtlk3sIY7H2ptp14tYBfL039DSi5aftDyPJ8qJjLWm9nOor0WXhF//qhgSAe4cJnHhNaDV/J0gNkhphzhjDS38d64fDyKHCg2+GbcqfVhIGwVG/pKv1pVTowkBw/z/86m9DFo9VvM7dRJHpsZ02k/ckKdRPIHWwW6i4dSSALh2/rboWXIxWHBDWk6qWC1g9ALj4H1JEIu2aaAZfydizHsUVJdAZyBNaJoiIEwxa7Q/v/Sp52/hrk7qWJnj7Of9A3xnuL2b7wpwFzstYng8mZlzGUTMAdLqtP5pypuiCYsBjO1yfV1wqe7FKK1dhoJK0Wy7JBZ4l2TwJjGIgA+5mIRTsen9CzfT+nPZZkCj3o5oxikjA6r6s+jQFUls+NFJxYJ7upcPnRssIBh6xpauI89fXCTS+W1ZKLzV0feSz3mKABBucYb801DcqlmVbP2FmpIuNBxteHccdXeMqmrN0scqO+awvSI1cB71sLobGDouVBP8hopXCdu0s26FlNdVw+JjLb9BnMkOEOMVU8eees0oF57i9DZNJz+dQlb1lPi8HirG0Nbz/4lC699dSbY3NEF0mzleOX8bmC2BE8GboE3qa72ucIppME0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:178.15.18.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(13003099007)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: Th0PKht9N/MDXv1s84XZuVDEsYamH5wavZThsqkgr9Cm02Ndcpm5iuPDn8ZtOxUiSI1rNGpexSPgFQcUITzWB7KNQhYskFUw9zh/mXKBZsNSpxAdM4exEQO16vqW/+jfO45WN2XlooyC6Syl++qwMrPDN6ri5H80p1YvVgXo8JVQdVuR9aaGv9WAjxTjXVIqN0jbVd6Sa97C3hQxy2XwX5JtJvyp87tFbj5y2Odz/NnFDt43r6Z7XG6tsLd17Jpg2jXtV3sRbhpJv4MBfewzMW+bw6UP5J0lcP9n/GSoJgpi8JcneZig2M5ZmO7/ehJHT5ZaMfb3+aMIYqg5+yd0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB12257
X-CodeTwo-MessageID: 1f6909ae-e6d5-49f9-a6d2-2b4dde04c262.20260925125500@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008493.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e1173dcf-8020-447c-958a-08df1b0431e5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|14060799003|35042699022|1800799024|82310400026|36860700016|13003099007|3023799007|11063799006|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	YSebBfcSmQqIRsHzpouqFKLBt0YucTSOlNVcehV9+ks4CgCMS+7nJspkvbYRnlU+mV+RXBPwysxNUuSVl8ypv0KKzCk+H+KovBjVWjgMjiyL9fO2oNXVAqfqUHqQDOZfhBK7r1v1MzuK2OF25MoYEO3he1Uol5sGoawcHApf1YWYgHPOX9ciO0HCj9Z5NWTPnhE2Z/Yfg2mA2xbh8Mubyxj+u9LUGOIijFXt1n1MAcMAJhSUjv0mFrAlwKkimyo83y5oRBSrgYzMYWha2LswmLHcxs3iPoV/ZuB4JQgLXjZDYC4Nme6EKyzlDxzvFctTsIh2pd7kQudFC/UDEIbRjduJpxKC84p9hIqp6P3SPRVOIYrAGcLmOJm/KTQD4lRs5Nt8EVo8rC4jQxiYxACGL7fW68rqqgcnKmvHeP/GBqIyRtnZ1l5T+8iJzXUcIZJSgnDYurYoBXS6MoRvJZckXgSJh94V/aVPYZdr37dDdPQtW1JXZ28uaV/+3jBFFoDNxyQWPzmwSnsPg8FuOrreTYpYVF+7A6mKJsIXAskZ6crbTQic9aoxYKq9tqYtDQkltM7eO2g6bdFVrKbILkV7idwZ98zjNyFpvHS8YmHTqNxDdH19ny1LyJcLM7iXw+OAhaBbq8rsR01Ly3GzJ2dftIiVxj/o6p1NkwJ2YW9lc/o=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(14060799003)(35042699022)(1800799024)(82310400026)(36860700016)(13003099007)(3023799007)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t2+Xi/qfhneV+13ngAyESsJnykd2mmGLNZkNxxB58aMx0ktV1KY4NYlW3oDKv+ruOL0hoLzDxk/m6eTjMuwltjYejrzprCDUyuw0lmQhKxghDEV1/KqgSxjGUsHA1bTuWEf44LA/SsEAOo+uUkrIMn3WuomjTHPpmQYHCukQ9RseknkhNVgp/StEZhljDQTJybF0rQOAhJRYM0H0aQBs6cUy3S892WX239s8fHBd35HPXxcnqoNGjwoX4MJ9njmR5eUGfUFwy+0FghujGj9fLEaFrdNXTx96aYIyacVKjboin5ZG1NRt4s7Y6K6J+qZTMlWeUBEGPVWKxXePwDykB/2J9CJ0rrLModTDbqTy+Kqwe1uSV2skJ6BU/2HNObHnEpA5zxssIcWwmhM8tCSKjBTh+jy2yoSPFcqiX/IF9/xYsGHPYfNSvg/hVeTAZcSV
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:55:01.7996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1072359c-4602-4ee2-0cec-08df1b04369d
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008493.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB11623

kfifo_out_linear_ptr() returns only one contiguous linear segment of the
xmit kfifo. When transmit data wraps around the end of the kfifo, only
the first segment up to the buffer end is sent. The remaining data at
the start of the kfifo is not sent until the next TX interrupt fires,
resulting in a visible mid-frame TX gap on the wire.

The resulting gap is unintended: data remains queued in the xmit kfifo,
but the hardware TX FIFO drains empty before the remaining segment is
sent. Such gaps can break timing-sensitive serial protocols such as
Modbus RTU.

Modbus RTU requires a message to be transmitted as a continuous stream.
For baud rates above 19200, the Modbus Serial Line guide recommends a
fixed 750 us inter-character timeout. On the tested 115200-baud system,
oscilloscope measurements showed mid-frame gaps exceeding that value.
Receivers using the recommended timeout may therefore discard the
incomplete message.

The incomplete transfer also causes unnecessary TX interrupts: instead
of using all available hardware TX FIFO space in one go, the driver
requires an extra interrupt to send the remaining segment after the
wrap.

After the tty xmit buffer was converted to a kfifo, the driver used
uart_fifo_out() to copy data into a linear staging buffer, allowing a
transfer to span the kfifo wrap-around boundary. Commit 133f4c00b8b2
("serial: sc16is7xx: fix TX fifo corruption") replaced uart_fifo_out()
with a single kfifo_out_linear_ptr() call to remove the shared TX/RX
buffer. Since kfifo_out_linear_ptr() exposes only one contiguous
segment, that change lost the wrap-around handling.

Fix this by calling kfifo_out_linear_ptr() in a loop, advancing through
all contiguous segments until the available hardware TX FIFO space is
exhausted or the xmit kfifo is empty.

This fixes the kfifo wrap-around gap independently of the stale-TXLVL
refill issue.

Tested on SC16IS752 over SPI driving RS-485 at 115200 baud 8N1 on an
i.MX6ULL-based board. Oscilloscope measurements confirmed mid-frame
breaks at the kfifo wrap-around boundary before the fix; no such breaks
were observed afterward.

Fixes: 133f4c00b8b2 ("serial: sc16is7xx: fix TX fifo corruption")
Cc: stable@vger.kernel.org
Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
Link: https://lore.kernel.org/linux-serial/20260623112225.82386-2-paultyson=
.mbewe@ziehl-abegg.de/
Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
---
Changes in v2:
  - Corrected the Modbus RTU timing description for baud rates above 19200
  - Distinguished the xmit kfifo from the hardware TX FIFO
  - Clarified that this fixes one independent TX gap source
  - Corrected the introducing-commit history for direct kfifo access
  - Removed the max310x comparison
  - Addressed Hugo Villeneuve's review: clarified that multiple segments
    are sent, scoped tail to the loop, and added the requested blank line

 drivers/tty/serial/sc16is7xx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 7107a0fb1e7b..fa7805d2cde2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -652,7 +652,6 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 	struct tty_port *tport =3D &port->state->port;
 	unsigned long flags;
 	unsigned int txlen;
-	unsigned char *tail;
=20
 	if (unlikely(port->x_char)) {
 		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -677,9 +676,19 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 		txlen =3D 0;
 	}
=20
-	txlen =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
-	sc16is7xx_fifo_write(port, tail, txlen);
-	uart_xmit_advance(port, txlen);
+	/* Handle circular buffer wrap-around by sending multiple segments */
+	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
+		unsigned char *tail;
+		unsigned int to_send;
+
+		to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
+		if (!to_send)
+			break;
+
+		sc16is7xx_fifo_write(port, tail, to_send);
+		uart_xmit_advance(port, to_send);
+		txlen -=3D to_send;
+	}
=20
 	uart_port_lock_irqsave(port, &flags);
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
--=20
2.43.0
