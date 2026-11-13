Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594628;
	b=xp9e97K9ojuNMfefV1Lwlx7RnP9T5d//QB+3Kg9XH0tC0f/5r+3dkNyYwsZ5srD8lmsl
	 axWjVRc0H4juL7hpjTrCLnhKp6ts2nDHn1cM8hzdAr2sFsjk4RCUNSM2A9P5IaUkkRZTe
	 +vPsrrV9+/bqQl/qzcQbQiek4X11uqVkJCjTkdGJat71nUSRc2h9bRu8pGqQkhsgXJ2mB
	 CLoFHYSFWWDcTUlQo1Y3GLKC4lN2nsq5YH9lzRzKVs8t+uNdCEVU8F/mgajGGHK4VNHiv
	 I75tXYMd1KpU9ZScxF7A31wLoaPkjLGW8fnyvarbLyP8GmTOM1gJGbcIAjmkANDWUVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594628;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yGrg6nOyT9qRRzMiDYjb/UJ8S+5/vY6IyT562fsHYYQ=;
	b=Avz46H8EBTOqNfqJRyvBD3kBLAYOKcMvkXpdU6H1tnYEa66Qzb+YZdZea+E534o4wKDp
	 2bqtw2K7jAaJ4XSl/qxW0nJM+k0ur7kM8mQjGuQpnQ4Yl65BJvxQg/UH/uBSYD/Z/hIe+
	 hupfDjXuFkuBWJU8DmEpSyRRPiDI65T47rf0nSK3k+GwetoqxUqbJsipkS0tjS93KvCrs
	 /Y9WIc2fRVhlfHHRmngB7MhLptEUG5iMmSJi3PVyhnzxUUQCs7MvgVDbetGVC+177L9KU
	 Z8spzPydwb5PYiYmqf5Ys2X5ilxOEg4hm0aRLGv58w5M8YR4XiXY9YLOBSeEYLxCdvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=bUOaf450;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.23
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011023.outbound.protection.outlook.com [52.101.125.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74C606A32D;
	Fri, 13 Nov 2026 18:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B74C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=bUOaf450
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHEnED5teLZ81Rp5Rt6mF0+Nz6k6sHlA+0olOkaOZHwEcGbg1cX7fnnqqE0sM5F4ENg2gju0E5ec+OCto+u6K/E7iCF7mxWl6myFtaFLUc2M909SSNCUoBbDOuO6K5Jh8dhTnRM+Kqg/WAw4ajk9CvceiuKwTFc7vt8PRUzw0CjvXEyprCGBNNFl6trCkWHPI9BCE7qp29z+vssbr3Ppy0ZYHc0sBM3f6+6yqDABfMphkLRCBhOKLn2YpAuN5KkYSRhSZ6enEZR74AWKBioLBKWexR+uSIvWjrufTgg3xF97LyqmNWtpnqBWT0tGro7/b73YsY/puPg0hG72ic+M2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGrg6nOyT9qRRzMiDYjb/UJ8S+5/vY6IyT562fsHYYQ=;
 b=nhJZWGSrCwTgkrVil6iPpk0fy2rVdm5OOI26SQUXgsA/E6meERsC1TqwgOAw5VH/mzF0wtIILdlagsX5CfgAFn8rZINrE1MkoPEPM8NEzR7Wjfwfa/+pEsX3uU0uri6w9qom//ynWd8LMJQH3/BwSU7k3TZq3EzINSG+c5V0+QwguFYj9VVAEleevNT2rDK2X1E4zX7oarpUaI99rkFCEAI36izC+i9NMXofG3XhD2ik5rCJ0ZbOBtNv0E7SL8Dh0ZcrX4dojODl0jnPMywaTKMqdar42Ue4ml9PCAGL3ODHDo87AkQWStZF+4hWZ4QUdvHp/ooIBT/0sITND7lxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGrg6nOyT9qRRzMiDYjb/UJ8S+5/vY6IyT562fsHYYQ=;
 b=bUOaf450QtiNEU9w4t2VN14wXT2WGr79w/+4PJXzeTy+AUIWhyyM2Vemcb4DgZYG7VwYLrTpkxxx19m/JPa13WupxDD1yia7IXgyEfayILI6K/6Ag7x7sntJIPNfHoYnO1jFd5OYdKi/q1KjGMwDeeTJsnc8wW6kYzlUiF477ww=
Received: from TY4PR01CA0088.jpnprd01.prod.outlook.com (2603:1096:405:37d::9)
 by OSZPR01MB9635.jpnprd01.prod.outlook.com (2603:1096:604:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:25 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37d:cafe::8) by TY4PR01CA0088.outlook.office365.com
 (2603:1096:405:37d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 18:30:25 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id BE8FB3000231;
	Sat, 14 Nov 2026 03:30:20 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 13 Nov 2026 18:26:26 +0000
Subject: [PATCH v4 1/7] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
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
Message-Id: <20261113-g2ul_sci-v4-1-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
In-Reply-To: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Au Dang <au.dang.jx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, stable@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=1429;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=5j3pfh+RcSlV5iV/d5a+vXXMdKwnqhNhWuBsFE8qspY=;
 b=cetnj0fD2k+DBgwqBio5wGLqTiXV++FYC6SY4tcgTZeojeo9R1gsi43ZXDH5nmYaHpXv6PuX+
 PaD5h9k8nK8ATEi5A7CNeConSebpGKjagDn5mVERO5VncEb4PwlYvk0
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|OSZPR01MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 576bc56b-5ff8-4304-d029-08df41b42f26
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	awM8VR21RiMMPk1eIPRiFpwyz9T2rJoElYTryQCFUlAOfaJZxP0NhpPTcW9ROOl8C/b9ITP0uHv9tWIscE4pXU50p59FO3/5hvpo/yqRH9qGeD/6GdpMeLdWOmIPsrFpVlIbPVcfWdKU4P0KB4+t/4pMjJ77iJR0ksGgltyuIKzLKBOzy4Ag+cuuJjKm8tKMGC/uR2H3IykNnhVnBZmtVfsLdkKRjvqoEfZ+rJQ4cPwEczH5SldhHcBaduQ+y0VsglbAm9NKa3KxIv+jz2vDKTsDjESv+NxjtoKBMP1wZ49iHD9IdU1mGhSDXjCbH8WAvJfDWy4ERetmVcGDTz06p04BdNnDJn6O6hxfXGZ/5vU+P9KTuiYUdoJqY2nCCUAYywOk6PNcs9d9E42203C30odA6BFpbzfcvO0RjD5xM/otJAImqo3fdvJteZMlpHTItQRu9biFYFQYBdV4C+LpVFsMYCslKzDBD2dsb9UhnJ/mF64x7pqPMG8EnPaQG0B+IS1zZVqN/a3pFfCoQMOh+NpOl8QQIp9M8YykktcN7Gs5wRopMVd4ub7AQRrp5mhZZNgDIPMeWyW7/rybjSLtSsoQv7PjlW4DfiAopxE942tGcExC3e0+5G+tgQbZ6Dzi9kqBynUqFsGqJPfg1njT9f0aT8jcBhzWNygDKFY/Cc5e8Qx00jv+kjuEvKHvNeZUWsxybVcAypBDW9LAbgNI+A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2JyauSZp50R8Jiw8tH5OFvleXigXKV1FBpnadIvD0UD8oYUCgVffd8KrM0anK+6IaSpl+7qV99YGLOqE7b2S5uiQbMgjwZPJcw9AlmBKx5zo5EeiKdTh1BqflMTGKpFahWrlgTWNvZ0sjPET377bx6vy6oD9wVWSU9ij604Gs5iA7qEE+n2lgIb9K0INcQuS7T9XqIQIaiMNGDqydAFA3WM8/RvJ3r6+iqSl1NH+mea+Oi9NqY+2qqgZWAgEYBAtVNK6SRn8BHuvM5LRTgAdqbC7i9MQRFKLJl/2UUvCu3ygBOKKOnrFCbkFjclTfAVVyytCCKDKzEivEVJmHrIM7+esCWpSnXaD63rZnDl2gt3H7XfCTyXbF7FFSZjPz6RC8quOVLVo/WfFAzOcvbmXVXbxn77EOoSzcenPbQwP7yE/FW3LoYGQMzJo5GQ+vYDf
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:25.0384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576bc56b-5ff8-4304-d029-08df41b42f26
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9635

From: Biju Das <biju.das.jz@bp.renesas.com>

Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
PORT_SCI once the transmit FIFO is empty.

The hardware manual does not describe disabling the transmitter to end
a transmission, so this special case has no basis in the documented
programming sequence. Remove it and let SCI follow the same path as the
other port types. A plain revert no longer applies because the driver
now uses a kfifo, so the code is removed by hand.

Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd58bbfa65aa..9eb297dbc901 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1036,13 +1036,6 @@ static void sci_transmit_chars(struct uart_port *port)
 			c = port->x_char;
 			port->x_char = 0;
 		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
-			if (s->type == PORT_SCI &&
-			    kfifo_is_empty(&tport->xmit_fifo)) {
-				ctrl = sci_serial_in(port, SCSCR);
-				ctrl &= ~SCSCR_TE;
-				sci_serial_out(port, SCSCR, ctrl);
-				return;
-			}
 			break;
 		}
 

-- 
2.56.0

