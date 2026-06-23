Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021137.outbound.protection.outlook.com [52.101.70.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7B3BE156;
	Tue, 23 Jun 2026 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213831; cv=fail; b=TAX/hLV588H3wAX1G700u8lpGYJ+lu4b51GEQUXt38foTAihBNDpt/nQzqrnxMNZ6lJl1snFZmZ9kNZxIZL1TZMPIqGmvc8Ik5atD8SFjn1zJ36tiTr0xrLhy6UK9yakPZ1L1JAxxhzdRzDSXrmnpC33IfOAMZ3bhBx2tMUZAAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213831; c=relaxed/simple;
	bh=ERsBWLd1ajmffo+1fLfqYRhDlD0T/VGx3RuHP9W8gR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIdT+FgeNJn/9gramRhw6lmbAvX9eJA6tcJXyi2ezjbIMsinezZOrNzBc+a2QXdvDUJlETqOqPNiyI3566TZq6Z39xQd3XH8wEIQsD3mwKEs68KsemV2L48Tynmgc5u78Ly30jQtEFvaXEeOVt2N2nHxBVNp7OAv+3p3aM3eZPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=ghOGQ9x2; arc=fail smtp.client-ip=52.101.70.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="ghOGQ9x2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWf+Zt9ZSK4jxFCwFkzec7d0Ov8OhK5KyEWkKdPLcD69/nOYUgaaTg5GG/e7p0tioQVmTkUYkYXMps0BScCRxqXd7cpkShq1neYMxvM85Xb4N8RFaKn8QbREt5Js5gOfnTEezHEWaSyiA/KmRSjRX69N4swyZpenry3lW3S2/1RSGG7iw44pkHae7aRY2kY2U5Rk7m3nFA0f4+ymEspr/fsz+8L7XZ+W3rDBxmaxtuFyUd41c8jBkirq0EyWViZRsJumW2YhCqKbUjbRpdXs5e1Wn6iCtt73midOZYS60SDXDzMEL3RCuPTY+WyVKM4xVsmgBFPj7Zl2BA6x2HBBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpx2phU6JeyM2OFBsrqGymCW70QNZtf9m/g+/JDlV/w=;
 b=SB7VOFQKi5f1CYt1V+HL5Q/4YHk3pyZxhudr4aDiKlX8wfGxT8VvYn5/BUvD7ygYTMul5rjOdxrs+SmSBlKbCpAo9oe/x0Wm5Sx6V8NhmG8xIWxvBxauU2xkWBHBxOaEauBAfmJlZBQzhfGXW7qAP1o5rlE5saRwiYOFLPYF35JO73ejYQk7Sh3FSobN1y0WSTKSAnxb9WlusBXz9dSHie9Al7qNybwhwF7P39HIdOnWwahORhwisWf9Y+6upVfgVNmUmjJZatprHJ6OqwqBz0F/qdeX2wZCKET0K4ZcYS+U2n/csKbrH/x+wqOSf0FNjJAWS/VLFSV4/ZJXRpluLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpx2phU6JeyM2OFBsrqGymCW70QNZtf9m/g+/JDlV/w=;
 b=ghOGQ9x2aA0QrE0TeBRcYE3wbBmdzyPASLu7bMaT3NsYlybdBP44J3Uzflh4kyRr2S0I+hlwUJcccjilkvd8m+lMQlsq1rm3QB9sgGDju8q6OnJe/4aegNk3O3yFpSRjZZ+k//1/5nMYZ1MjPDHSiYKjuryeFdUT3MobnV2+LEo=
Received: from AS4P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::9)
 by PA4PR02MB6895.eurprd02.prod.outlook.com (2603:10a6:102:d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 11:23:41 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::57) by AS4P190CA0023.outlook.office365.com
 (2603:10a6:20b:5d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Tue,
 23 Jun 2026 11:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:23:40 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.70) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 Jun 2026 11:23:39 +0000
Received: from PA7P264CA0345.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39a::13)
 by AM7PR02MB6484.eurprd02.prod.outlook.com (2603:10a6:20b:1b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 11:23:36 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:102:39a:cafe::94) by PA7P264CA0345.outlook.office365.com
 (2603:10a6:102:39a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 11:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.181.0 via Frontend Transport; Tue, 23 Jun 2026 11:23:36 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 23 Jun
 2026 13:23:32 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	<stable@vger.kernel.org>, Tobias Gannert <tobias.gannert@ziehl-abegg.de>,
	Joachim Knorr <joachim.knorr@ziehl-abegg.de>
Subject: [PATCH 1/2] serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
Date: Tue, 23 Jun 2026 13:22:24 +0200
Message-ID: <20260623112225.82386-2-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30024.005
X-TM-AS-Result: No-10--3.290200-8.000000
X-TMASE-MatchedRID: 84bS4swKpiX/qqVpqhD4PJ0UyaWO1QCnOteHVGUMZ+DaHg8oIhVMt0jc
	zmIAEiD+wxHck2GMxs0NhTxGpM1b6sp0ttW478qbm2eUW/oDuiF8f4R6zG0o1f5CEAGScl89KVF
	ZxXdSZ5xo3qrovOBxQlYlwY+8qfWiicsvhXQraykZD7bjq+6lMGzY00haS8Qo2ubnxCjreJ9SNu
	Dnpl7GPgObIzLs3GAWEgg3cwDHl/2jYFSFiWs3onGDuy8y1qku3W6IHoa8uBASPBCwN1yGzYsAM
	g/4cQi8f33Z9BQl64hjWEd0C42224eVln79iR5WNfdOZrUX+mcFYPOvfeQoZkZw4b6ew8txrcgY
	SgCyxhsX9j5CWNv2R5n/n67dt9lDVVtlvmSZGXhfJnqmX+gNDX4DPSs1ZmHWgrfEfAe6N49pLdd
	d9zGllg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.290200-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30024.005
X-TM-SNTS-SMTP: 1C6007103D3103BBCEF5A789333A6C7D4E64B5CE40B60DEF2CE5A808AA3F05452000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00025F98:EE_|AM7PR02MB6484:EE_|AM4PEPF00027A68:EE_|PA4PR02MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: b1daa0d1-1d44-496b-91d2-08ded119e0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 ewnCToI0bNCbsSIo8J32en+AFJjlLk/Pe8kM5U5mQLtG8LZtGYGO6uqfGCk61rnqGV4ZvCXBjSLp2HsI0GSAYMu9vzsYu4iHOflTfAV8oLuHX3wbeSyP+CbPOqIp0LuOixXmo62m+5oq5SRFgYoG+bwvSpARSZAnGWTydWO+gbPf3OCfT/zm3JQBL8mc77O2MMiPcXsLk7GzEsGhtJ1S30mSookr6oHnWSMCc+QS1dgrixQGAuAt5otDmf0WdpKMFOtf9B/EQ2HqPJVFxqeKhRY0ks1GB+iflkK7ABjLJlIfqiCtqZ7oba+Cdd+3j+ECIjb/UtHmKK/VVVJmyuIUvM82HaqdwCX2FOG77ZCDvnOnyuKxBUwwtIwFC4LBOlccZoUu+VrxeAipOTGmBgBEZLidJ1KZB60o4mCAiqQBT9tw1OgSoeSiTLGDs+MKc1hEh84HeT8T5V6oJ/7fTsU9bbyDZWf8NYy1gB7Trvhp3I5JjUEZVRpYeg7v+YC6VQ2EwH5iPRko+EbkWzm83tYydCZ+fwzi9Ys+oDQCOPrp97vYNotzezh+GQlgyHv9KQtzGYTzAdN0TzRscz4GKf+bGhNaVJ6TQlcaExgQQh3CtAQc9PHAtR8RxAVWp/Vude/4GVt2HexHL7O/n3/RtyWHDc2ef0J79pWG2EJILBUJbLJqWqR3pGDyAXohflcJQWWshGwRvyPerId6jbh6o3uz5w==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: b47Zp/SWjxAxF0kEU+0OuAe2GuIkLmpvDhCyRGrLQKhMGeQg0hYEjc0FbiTXkxXgfXEpWXdGAB3FTHNEjwrFyMTxNGMtD8RDwHQW/RMXwd5FxUVRVZU6qjIHc3oukrNzZghN9O5FtTnk8s82vGnHNZr0UZtWs+Z6TyHj2ypBrJygEU+BeLmnOZTXvDAJ26XGKSlyAVRczqgCFziT9T1zlKpgEgwXFg++642DnMdM0MUvxSs0rD5+FVmeGRhflw2tQAm2t2psOj3j6eUkPmMhD/b0IQhdxBQeiIywi2BeFOvZx/ubBqViAIhzn9Nd6SCB+1XPZLJ087uBUHG80/OgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6484
X-CodeTwo-MessageID: 2cec5853-cdc8-4033-bd46-0aba5085d89a.20260623112339@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0817eaea-515e-45b5-888b-08ded119de29
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|35042699022|82310400026|23010399003|14060799003|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nxp8EedO56gMUWbeKZm63QqvkdYA9AVxj7bs5r/7st9IPp91YNC/FLqVVoK5NVk1Mi9qncr7qPtVO3icGeXRJyYHOpLr9EyLvADMCBDr35cSGpCLyThUWY8FhXkg3PK73FzMftscBlnFjVkbl58fmDFTnpRYQYSQqCHeqCQ9FyiSlc9O9EA1cDnO14UZAshyeM+fBhWkNIu6X1on/1eEjQXyoLtbyhpIbZ24vYGKcX+EGOzYpEVIBuyScx87Ccsb6Ulh75CyL4jRH1S+9wR/1cBrNtSwmE9d0gNDTg36o8M5WfRQhy59W5TvnG8QTTYvmqn9+IB3pk1wjUs+zdXh59hSLJSva0bt4n8FIOA6HXqKkUy6yIU18+7n+Y1kgVMLp4hjKIQbbO3CX4tToEakpv1gOsmVXsBMp9ouJKzEYvw4as4HtVMkl2nET4DY+tmKQg4Gsei/gNBWJM00f6IUR3b5eWlp1upO4hNTUrEQ8ixSro6fyVNvije3BTL3NMGGZvkDGRcg5D8z0tY45BHoDE10z8DKpczDjDmiZjzVYBsh9S0vWF8dmQKxH+vOIqWUF/pzfgQXXklXbQ3fLKvk3AGvnZcnXyTXuwaDIX2ocJG5NvLpyUaZVmXT0kF3Hk9GpTGekXdSnWOaRGU50cwS6w4csVk3qQhSd1Q/8jFwORNPXcV4TtuYyOqcIKjUGdVEDEGgCdRlBNM8c6VyZgeHwQ==
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(35042699022)(82310400026)(23010399003)(14060799003)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B1lrj3eEa5swvYt1OWO76Y9S+NEKgPTB8HGY4mYZEcyjm5TV++X00NhyYcs+hR3lNhOosK/W/IRw14pLm+VYR47+8v6YmNemrO1QG2v5anDq4s6uqMhpvkXG6/Nrw1kb1FrdjuezlSzJwLNxBUx7VXhJy2WPjSr5qK4i6NiA6DdRPkZHoc7B+k8yTtP5Bx/6iflafX8pvoOu3LEFHUkmnqJSiPpJJu9tuajR+fRSi7NErRu7gNCvCu6ayEvEHeVCVed5jxP2YiuCKQFGyczaUq6GGY2gidQb45sfH4RglnwNYl+FNfqNflYRoNSKUX7dK5qwSdtQfXBhgCbQA0oM+sFj71lsYHFD349w/2CcQRdfW5+e/Gxol8AIlEPHgghvdcfda9odBD16hlYuihM2Yk0CnZ3564FThf4nl7hR8IHMbdSjHMNupKXhvV4NgVcz
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:23:40.8205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1daa0d1-1d44-496b-91d2-08ded119e0d6
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6895

kfifo_out_linear_ptr() returns only one contiguous linear segment of the
circular kfifo buffer. When transmit data wraps around the end of the
buffer, only the first segment (up to the buffer end) is sent. The
remaining data at the start of the buffer is not sent until the next TX
interrupt fires, resulting in a visible inter-frame gap on the wire.

This gap violates the Modbus RTU 1.5 character-time inter-character
silence limit. Receivers interpret any silence exceeding 1.5 character
times as an end-of-frame marker, splitting a single valid frame into
two malformed fragments and corrupting communication on the bus.

The incomplete transfer also causes unnecessary TX interrupts: instead
of draining the full available FIFO space in one pass, the driver fires
an extra interrupt per wrap-around just to send the remaining bytes.

The pre-kfifo code handled wrap-around by copying bytes one at a time
from the circ_buf into a linear staging buffer. The conversion to kfifo
replaced this with a single kfifo_out_linear_ptr() call, losing the
wrap-around handling. The max310x driver (a similar SPI UART) correctly
handles this with a while loop.

Fix this by calling kfifo_out_linear_ptr() in a loop, advancing through
all contiguous segments until the available TX FIFO space is exhausted
or the kfifo is empty.

Tested on SC16IS752 (SPI) driving RS-485 at 115200 baud 8N1 on an
i.MX6ULL based board. Oscilloscope confirmed mid-frame breaks at the
kfifo wrap-around boundary before the fix; no breaks observed after.

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Cc: stable@vger.kernel.org
Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Tested-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 1a2c4c14f6aa..395a219280be 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -730,9 +730,17 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 		txlen =3D 0;
 	}
=20
-	txlen =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
-	sc16is7xx_fifo_write(port, tail, txlen);
-	uart_xmit_advance(port, txlen);
+	/* Handle circular buffer wrap-around by sending in contiguous segments *=
/
+	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
+		unsigned int to_send;
+
+		to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
+		if (!to_send)
+			break;
+		sc16is7xx_fifo_write(port, tail, to_send);
+		uart_xmit_advance(port, to_send);
+		txlen -=3D to_send;
+	}
=20
 	uart_port_lock_irqsave(port, &flags);
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
--=20
2.43.0

