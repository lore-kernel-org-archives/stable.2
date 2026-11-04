Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793798477;
	b=nMSD8Si2ArHXxWultOUz1PmmlBvdUgBtRPOz6zobeCBpoa2tRQdFPxWPGydMrSNhc0W6
	 Ymf1jdqoZX5GbCWt4HqR6KuyX6Q8q/BpajtdHm0iyINKA4DbhkrVOuNXwgf47zDChmk+B
	 SRQYFL4lco5Hl9jzxBA4YuxS2dLa5WuE7jXoAKfUy7T1j6Re7XcYPPE+IZIg0ouknc+7c
	 m05OJgC3mUsGKLvnNCTKnpdk91pbCly7tpFz2d4msx4A6DzNKbvDQ0wIy+p+bNHBSknJr
	 oHyjJ1uvQmnUAJXGcsPwwRwd5u9PNcd2a6qoK6D6cuOJkPxGYp3gt7X/QE939A/9NDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798477;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Woks12ayzA+ixH+YvqZEhYqpnHQriIDTepnLgmONhAA=;
	b=GfCevp08ubOAjVYqyHOeCYltSReW8FXiBKJQAfuO8/9sK8UhZaY5vB/71v4Th4IKIWZk
	 okQTZyQnHo/xz0r6sw3j19AewDUG8TEYaXF2NMkFDoFgnefN2yJwcc9a0LWG2nGujRgJ4
	 15FO9vlLX+o2Yk77FxWqe2GcGKqQ3hsVnMO8m/Bzip74lkHTZuROURcYbpHTG70HLyyYj
	 VmRT3M60sGG4EuCfqCjmeijg0xJATtoabx8f6mxd07OaEkNzEe5nZNHwZhVq7FfOS8f1H
	 +bqklogD/CxmddJh1GnvMCk2jUi8gOg2/aoZ+23zftkp8oyEym4sckwawknIxU+Om/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IaXMjf8+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.54
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97573606A31B;
	Wed,  4 Nov 2026 13:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97573606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IaXMjf8+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkqFblteC1lfB73N2pR/LO1kAKm68k5PyAcQ7fUUeiKw11KHn+5i2+z4Y4iza0rihDkO6p+pPyCQo/RQi4JmEM6SogQ4SrQZIsK6W6erAxGBvDpQEsurngHzKhy8wVHQcvx2G46kwGobtHUnr7FIketcYozhFdh8DpGtLavs/lMsmNEZ511l15RBfK6TmbMWdd0jwjpp+P3okez20p8H3Iu23NsiQImOtIYN6hNtQcYo7DkGAZxsQU56T0p0w5WjeEoBLSCEXZ5pyMQShGs5jgUFyVKNoj9sVGO+lx2WNFh7Wax83kSfc/E9mdDny/+XTmtmhUblYM6Wjaj01XwKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Woks12ayzA+ixH+YvqZEhYqpnHQriIDTepnLgmONhAA=;
 b=x3lHagYTG8Jhu3HqZ01Ir2Pky7w8klZY5NmbX7UEXFzHE6Ok9RRenZr1OgV/sqf08B5eQyra9wwnP0jof7WiLfAWEBnIiybl3KepWzVG+T/aRKCbp706hzsoLbeIBuR54ZSrq4Pv2jAq+YE27B0UpGun4hbpjcMxp1zIAr3j/5WBVEkUbNny6uvxk/1rof/z83+/qDy6XgJhGym7iHBOR9UpI6joVmJStaBcSsKkV5V+tf9tmGTcee12JuQfMnYz+BmKxNH/iY+PBedMRJhWJRDyMmKch711Qs/w3CHzTN8h2UoaZdWVkLbmW1ZDs4prydNf600aGtgqzZq7oI62sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Woks12ayzA+ixH+YvqZEhYqpnHQriIDTepnLgmONhAA=;
 b=IaXMjf8+RReGfZIDYqjJUsVxoeOL8YFzv22VCgc23Arb2YEye32pR+7beKYvkqAn64VBed5AmYzXZeHJo7Lc3bo0KLtVvOrbcNrczX17DNlsSwUf9VAadWSy/igQyoc0b/Z7/nGS8tFeQMZPRq2iboa3ls7b9m9Q44deO/GgLbbe3d/H6rHYxmFTDRVkjeCqGQ0bKa6T87CfUWdeLidnI7BIuwlCn5h0PcomQuwryBVzh3dW+ageZTzsOARytcmUwsvZBThQdpzP3pc3dhsNe6z2qbV+AdY0FEQZIMJEHgVSMWlY/rZYiYHCBZ5lN55JaPsHNz+NVG6j/pdRvNRthg==
Received: from AS4P192CA0032.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::15)
 by GV4PR10MB993150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:400::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 13:21:13 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::59) by AS4P192CA0032.outlook.office365.com
 (2603:10a6:20b:658::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 13:21:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 13:21:11 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 14:21:40 +0100
Received: from localhost (10.252.2.138) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 14:21:11 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/2] usb: dwc2: fix fifo reinit and workaround for isoc
 tx packet
Date: Wed, 4 Nov 2026 14:20:14 +0100
Message-ID: <20261104-dwc2-fifo-fixes-v2-v2-0-2bb13820f662@foss.st.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4x62oC/yWMQQqDQAxFryJZN5AJUrRXKS7aMVPThZaJjgXx7
 qZ28+HxeW8Dk6xicKs2yFLUdBod+FJBHB7jS1B7Z2DiawhUY79GxqRp8vmKYWEMlKjhto2UArj
 4yXJ+7t27P9vyfEucfyXY9wM0f8jRdgAAAA==
X-Change-ID: 20261104-dwc2-fifo-fixes-v2-10f08299c0f1
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>,
	"Fabrice Gasnier" <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000520:EE_|GV4PR10MB993150:EE_
X-MS-Office365-Filtering-Correlation-Id: d717d747-b91f-433c-6cde-08df3a767ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102124527099003|261022075727099003|261102123227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fPdiLV8ZiXNh866Q4shrl0ApaJ/XxfQ+AGKMoZ8bjHxzm4f3yCG38V4Bk9gaQLz+qua2VE/eKBAkP8iqBKgA50KdHTKr8IXGcHHB4oUHN5g/71k2TzC05uc6G94NYP94+hPnN717t/Ze6eO5hlCV+3N7VHu8iYSlVPOKrvjQFauH4nhjhn6NzsgnGfUWFBjZ0Sem4OvozMOSQlDUZB1jZ45QFx05A84bb62v43Zy8zShEzFFeTGrRye/hqmaNiumhKOZkXbzznBOEEt2gCQgO0xkmW7ImVcS8OpR4tqOM+gjC9LutsO3nxsAWXFsvQoB/K8O0jL/KLhPkljrktk8wQ7bXSzqh/y+GnRExWdr/QDu9INoo0hAlLlg5i2/vE2ElV24zRtAK9sgDQMQdLIBki19xeJ9qYwwGIeV7RLyIRG+cxn4KkiE3hd7FTGCqd67GBeqohgDN9KJTExSIF2JFljWwythdMmUYNGGS1CUecIBaSJQIVmXB8UrO48EkBsU5Ijun9LKXufj8oxicF58QR07jG8lcvabQ896xSGrx6mRomFJJy1wIwwuKXsXqrYgjHA7kRlCST5R4F30YflRVj+wPLEp1RMiFaZhCEqejOORpvDK2BDivzTZkJ2FFCPrT2ZtNUkuGLenwOC8+edM5Q==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102124527099003)(261022075727099003)(261102123227099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t4ab74gQOSHXttWW5v7sEoo3RRLFwA2z+xVCHZ9eDxCLkT9kz4VuU/zhHzQx4ftCmaoyrmrCeHrFWEpQVuLNHA3AsBFVGJjboMSAoW/BSII/+VRP56Px+5vlipbrkE4ehR/BBuI/jE+XMBWgnBOuNbRVYVsZKyOjgTELlrf5wsOfvAEFFhRTWyFdLFmnUUcTHGvM6fE3zAEhajO3as9IW/A7/frt62vG53+s3FVaAyTsBW7IkgXdtLWLjTko46TKq/ENO9I1qpxDvGjPJHdUFETSnYl4uS6sanXEaPLL0YQJGhZWg3O7jbBxAVUCSFRgHHAk4pgfDatvQaDwN5q/W93iyhOrqrK+k1jLECWV9RHy0OHhTaaIGdu30a27y3ZdM6OLey5wTv9U7tkRphcMWO9qSjMHiZVGIUMaZjwmPhR1BpQXMnk1SAKjqu+MSv0y
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:21:11.9420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d717d747-b91f-433c-6cde-08df3a767ef4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB993150

This series addresses two issues in the dwc2 driver:
- First one fixes fifo re-initialisation when using dma
- Second one is a workaround on some cores that may send long TX
packets.
As these two changes may conflict together send them in a series.

Changes in v2:
- Send the two patches in series as advised by Thinh
- Address Thinh's Review comments
- Link to v1: https://patch.msgid.link/20261014-dwc2-fix-fifo-reinit-v1-1-d918de90ee3a@foss.st.com
- Link to v1: https://patch.msgid.link/20261014-dwc2-fix-wa-isoc-v1-1-f261ce0852bd@foss.st.com

---
Fabrice Gasnier (2):
      usb: dwc2: fix fifo reinit in dwc2_hsotg_core_init_disconnected
      usb: dwc2: wa for isoc packet tx fifo flush at periodic frame boundary

 drivers/usb/dwc2/core.h   |  1 +
 drivers/usb/dwc2/gadget.c | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-dwc2-fifo-fixes-v2-10f08299c0f1

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

