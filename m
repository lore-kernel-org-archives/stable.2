Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011011.outbound.protection.outlook.com [40.107.74.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D137B025;
	Thu,  1 Oct 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867449; cv=fail; b=FvC9rGiZ3qdxJMY5kOE7VKaPWPk+M4fKlmcwWxjZcXpCLth6vAuiFdVN87H2nhYLyjFaUziDgRodKOdl6dqPo9sHDnqiko/gZ8Tqm8YvUIgC3DM7OT8E/BCUZn42+IG1uJ6+enl/EJKJagTK6MPJKbiBAQ0znqpccBf2aRcciLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867449; c=relaxed/simple;
	bh=wv7762Vw3kyU7N9t3ithImA7odeDga0RuFmopKvDLsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pgkOh/Rep4kVwqAxIC2gfPXAkuiijRmailDwDWzTaUsJYWA49JMX8FwB+7nqMskwGKdmhN8/QF7horstqJVEY8IRdFxR4jI/Zj3FWrZt9SKBXcyWLLPw5ATVmXBay+G+7GE+pJatT5OWAVdMb+mIuDDAAsKPiMQyJPGNAPDxlHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JJBrBVvz; arc=fail smtp.client-ip=40.107.74.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JJBrBVvz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbK/KlGlBgfuvnRAPtUIk3t5sIdy21FZ6eWOr4Eks6Of8OC5z5YQflCBLa4U2/1RqMhBxIlDLXZFZQdvc0nU5iVFJYrkcxOOLsQPVa89px+/cGBpUaBfKq/pcQc2Ys6crvo/CDuMlhRmOuvCgG2+fHsTBh/Xh7U4Xp2McfwDRZe2tIz/eiZAI153wUHDUN9vTz90qD15lkEyqQJNRMyu0g0vJQFa0avTppNHtYvm9P1VVS3bLRdvjk+EmISmjzHnVZ/V+komGyuZda4JVZM1K86VKyh3YJOUzOja0Iz8P5rRdeeDCsC6trTaCdrDN9kahyAJd+BeO7GteZBG2Xd1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j739L7rUCmNjaLKZN1985XO0CsCsdoJrePR3yrJ2/J0=;
 b=lEOMdtuagbFSCq4ayYwxGjn6gDxwzmb8hTiR+4i/mmoprZK4rBBWFtx47dxOe/tkKAU1CjwwZpz9C/F7C990yF1H1uaZ3ddBNRtmgl7Zf0UqTqfp03ld6L36VeaJvDlM8r9hGiC4aNcqFzSTAz7TafrdinW42JxpCGXcBn909zR/FXRfp7I8kuc8J+18OrsX1/h8idaa5/vf/S15e/GUl5sHz4UmP5tKdtF2ZZU020B6qYI2tP9KPeLb87rO3OMn1BwAXsawFvqiSVsNWRVB+3vEEonZd7dZXiY5IIGTJkP47ZBQo6G0eZTIwld3En0sLNt2+Mv8yHzKHTIy8FYLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j739L7rUCmNjaLKZN1985XO0CsCsdoJrePR3yrJ2/J0=;
 b=JJBrBVvz8kyl+zjO/zI86+EdT8n0AfskzRZigMnGAdw5cduUt4Yn/PnV57kQM850ub5yyYsBMJ3mVWTWc8bqrNd1VCi4XBXaSi45pH6Kx4CUDRd0y0Uf7Qtk3swOE4NfQMu+exae64i6Bgb4wDLfRG5MGjwI9r0JWQ5AjgbFPMo=
Received: from TYCPR01CA0127.jpnprd01.prod.outlook.com (2603:1096:400:26d::12)
 by TYYPR01MB13985.jpnprd01.prod.outlook.com (2603:1096:405:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:10:42 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26d:cafe::42) by TYCPR01CA0127.outlook.office365.com
 (2603:1096:400:26d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:10:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Thu, 1 Oct 2026 15:10:40 +0000
Received: from [192.168.1.82] (DEU-5CG4161SZR.adwin.renesas.com [10.226.92.88])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D48293000255;
	Fri,  2 Oct 2026 00:10:37 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Thu, 01 Oct 2026 16:10:09 +0100
Subject: [PATCH] i3c: renesas: Fix MDYAD(x) field length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-v1-1-2250225e6d20@renesas.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN0QrCMAxA0V8ZeTbQVqjUXxGRLokzottodDjG/
 n1VH8/LvQuYFBWDY7NAkUlNh77C7xqgW+47QeVqCC5E75xH1mlAs648RrJCGFKMqHu6PHnOjK7
 NB+cpZeYENTIWuernNzid/7Z3exd6fauwrhtSO+vjggAAAA==
X-Change-ID: 20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-0ba701c9add9
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790867437; l=1100;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=p7deA08Qe7Ys+za7Smwz2XnGR9jNHZdyiazT91+7k/c=;
 b=b639q54jB7mWBOFE+yaGhke88acOOiwSLBr54/zfhli38SYwaxQVW2wxnnEH8NoZDTjBYPqnf
 rt3nUkFGJ+SAQhB9Rc+J+JOLkIYoFCxIs+nZDB6iBzi+npUSlW04b22
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TYYPR01MB13985:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c167102-8eb0-4d95-9bd1-08df1fce2831
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FelJWm4UbruUhG4pWzfqBn9xcLwAhBI5c03hr4wIzz7YX5u70Jm56IJWmYMmRPZqTONywm/5f/Ho8HqhtkKKrI8lzda+ljUDMsRKJzmEK6mIui0WYtntrXGiwruAIOocw3TMJIsDjKGjVAhX1VbAf8Ce3tL+AiJd3CtT6IFcdlIPTt5HOKid7EwwqiIo+dLKbVgJsz5S3QF8nViOpPfi1/Cmmm+mVy207p1263xKuxVCZeow+IglbVvngzA94+lXkYm0T6L4YsuUtXaaN6r9bx6Z3bicsiU1EX7eH7UOZQx1rBRE+hVT8odcsjObnDTCh3OBACxpWSor7KMxeu2vv7+0EY96zcb1YDx/TfNslRgH4uofyXLZ5Iyiu2/FCLxUFocohVQbhfNMljFZjSRXtMxQ1Y9GDmwoALLg3v22jcQfx4mKZd9E9VTkR2NwdoAq+rZ/pDmdHD3F3N+YTItpjZuM4g36wi5HgPCpneu3aDEMKD8ruKnZyDMHv1lZcqHS9hCXOa72HhogjUhxgHJm4SaUu2x5i6r+FWj4CYWPMKHTY7OCONkRhpDLVviMxuCmIw7e3TYzx0KD2wGFUJ4BctmaYhZaaCf839xNxHai12G44Phl85iz0EiAtqMPMmA1V2Dmf9mR6URlEeYnJAKSkQAx3yYwXlmtPld1JOyk10oTj0nl4b5UpjVXX+0W4/0rnKcN3iyRuGaRR1c3JD4BoA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j+ZyAS+8zFxRxXZ69oKY63qd0CitV7yeGAv6Dp23785UQtCtj63kBHJ4BlMmwJxrGIALRTf5fBsFU4eaRU+kLrjfM2VoC8aY5sIcRVQ4cSglX01AiIxh4Q2nu0Fty7SKFcKqSpnpgsKqatEJJA1a5rPxG/oYufozF4fiAMFah9NFTotw31iCXRtWnpD3IxOd45HjKkrYKhBCLT4CB/l6m59oJ31oAAD0M0bQETR1s3felrg+EnSCCYp26XLXLFWIblRhA2ut6Dxpxc78Z890KXMXW0C8QjpzCS/zZ1HBc60XuZlmF19Zsn19UMg7sOQ3h7aad7rcYCehiif+AuTQct1H2x6GiQ/5MlwdSpC2VFOfL7qTfeCrhmc5SEdYHUH0o4FyRON/iZf6i+j1rSfbMPRtatjbKW+YWzC5kNzoLCIGpt379ApkqrlffqlwULrd
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:10:40.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c167102-8eb0-4d95-9bd1-08df1fce2831
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13985

Fix the length of the MDYAD(x) macro to be 7 bits as it represents an
I3C address, which is 7 bits. The length of this field was confirmed on
the documentation of the RZ/G3{E,L,S} SoCs.

Fixes: d028219a9f148 ("i3c: master: Add basic driver for the Renesas I3C co=
ntroller")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 28c0927a0179..8b264f72e55c 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -37,7 +37,7 @@
 #define  BCTL_BUSE             BIT(31)

 #define MSDVAD                 0x18
-#define  MSDVAD_MDYAD(x)       FIELD_PREP(GENMASK(21, 16), x)
+#define  MSDVAD_MDYAD(x)       FIELD_PREP(GENMASK(22, 16), x)
 #define  MSDVAD_MDYADV         BIT(31)

 #define RSTCTL                 0x20

---
base-commit: 66b734f67a4a0a4c2313afb89033d5ab8b8f7523
change-id: 20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-0ba701c9add9

Best regards,
--
Diogo Ivo <diogo.ivo.sx@renesas.com>

________________________________

Renesas Electronics Europe GmbH
Registered Office: Arcadiastrasse 10
DE-40472 Duesseldorf
Commercial Registry: Duesseldorf, HRB 3708
Managing Director: Carsten Jauch
VAT-No.: DE 14978647
Tax-ID-No: 105/5839/1793

Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.
