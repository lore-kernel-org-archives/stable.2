Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191B36C592
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194557; cv=none; b=ttmWeQI/nMGQu2EkU+Ch4Yj3pKZ6t9nrP5TeM4HZb9XM6Ndjr1PjMOR4RgwDUeHS0iaN9IdgTL9WacC3rgpEQy/8gL/DWURdhEe4P+1v7ipMjo1EMmlrJWWPGtPh5ev/DME4HjUiR0bOhs8qfgUekwJy8vfEyiRQzOjK+N0/354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194557; c=relaxed/simple;
	bh=auJ5BTKDMPnM/0yJV0Q2KxEJn1Ngg/e1sbx5hedbnIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcHwCja2zKwrLFGM0/AgLMI7tuhDA6op280FeAXsfVmJbHyn1dMa6LMj3ENv8vSuovcNbMZ2goUJ9KAyf8m2lVmVZ8UpTQG6nHgLvRrdQGbjeJQhUIsQ6PIWCSYf5P5XA7fVKkahKAcTb9SjYIfevTwCw203t7sMWxWTN17KWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKLdc7xH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKLdc7xH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3EE1F00A3E;
	Mon, 31 Aug 2026 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194555;
	bh=Am16aeZ4PZJ+TKtBM/ArcZHnbmvuZl5DjMtaKOYzvhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BKLdc7xHbGydmLqrmZM6zUPVO0+WOh8yBoFk34DnGEftVTK74TwDWOmt6Kd4SRhOp
	 0g6Y8Dgn5P/ta7UbmqX15+nY5DnSuBYYdflDqjRnDQ2xMuMTUqmBTHJ66j1ZpUYh2x
	 2Pgbe3UE0Okiht+J9s7udTXARVFu0BoO8t3Hlv/DUe1TT3Wpdq4usG+KKWXi8LsxmX
	 uYNnRQ6OyAhXX3XoPfMciY2xbdm/HnuCPGQ+wB6rCzjVcOk1SUorqo8Yiw+GcBtZZQ
	 cVDaXIQKVsKues1ENEtUxehngTCtkBLhVd45PFiFpRWO2Yhgh99E1zfRdektXRDYLv
	 fOMwATSu8CymQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] usb: xhci: add USB Port Register Set struct
Date: Mon, 31 Aug 2026 12:42:30 -0400
Message-ID: <20260831164233.269066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083120-autism-gerbil-efbb@gregkh>
References: <2026083120-autism-gerbil-efbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 377a91594e008848363641d07f51d2e48f4bdde5 ]

Introduce a new struct for the Host Controller USB Port Register Set to
enhance readability and maintainability.

The Host Controller Operational Registers (struct 'xhci_op_regs') span from
offset 0x0 to 0x3FF and consist of fixed fields. Following these fixed
fields are the Host Controller USB Port Register Sets, which are dynamic
and repeat from 1 to MaxPorts, as defined by HCSPARAMS1.

Currently, the struct 'xhci_op_regs' includes:
 __le32 port_status_base;		The first PORTSC
 __le32 port_power_base;		The first PORTPMSC
 __le32 port_link_base;			The first PORTLI
 __le32 reserved5;			The first PORTHLPMC, not reserved
 __le32 reserved6[NUM_PORT_REGS*254];	Port registers 2 to MaxPorts

Replace this with the simpler:
 struct xhci_port_regs port_regs[];	Port registers 1 to MaxPorts

Host Controller USB Port Register Set:
| Offset	| Mnemonic	| Register Name
--------------------------------------------------------------------------
| 0x0		| PORTSC	| Port Status and Control
| 0x4		| PORTPMSC	| Port Power Management Status and Control
| 0x8		| PORTLI	| Port Link Info
| 0xC		| PORTHLPMC	| Port Hardware LPM Control

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20251119142417.2820519-8-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 78203d5b54a4 ("usb: xhci: bail out of setup if the controller is inaccessible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mem.c |  3 +--
 drivers/usb/host/xhci.h     | 36 ++++++++++++++++--------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index f0ed38da6a0c8..3ef311ca224bc 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2161,8 +2161,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 		return -ENOMEM;
 
 	for (i = 0; i < num_ports; i++) {
-		xhci->hw_ports[i].addr = &xhci->op_regs->port_status_base +
-			NUM_PORT_REGS * i;
+		xhci->hw_ports[i].addr = &xhci->op_regs->port_regs[i].portsc;
 		xhci->hw_ports[i].hw_portnum = i;
 
 		init_completion(&xhci->hw_ports[i].rexit_done);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1a3f2dfd5a711..ccc43473ad90a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -66,14 +66,25 @@ struct xhci_cap_regs {
 	/* Reserved up to (CAPLENGTH - 0x1C) */
 };
 
-/* Number of registers per port */
-#define	NUM_PORT_REGS	4
-
 #define PORTSC		0
 #define PORTPMSC	1
 #define PORTLI		2
 #define PORTHLPMC	3
 
+/*
+ * struct xhci_port_regs - Host Controller USB Port Register Set. xHCI spec 5.4.8
+ * @portsc:	Port Status and Control
+ * @portpmsc:	Port Power Management Status and Control
+ * @portli:	Port Link Info
+ * @porthlmpc:	Port Hardware LPM Control
+ */
+struct xhci_port_regs {
+	__le32	portsc;
+	__le32	portpmsc;
+	__le32	portli;
+	__le32	porthlmpc;
+};
+
 /**
  * struct xhci_op_regs - xHCI Host Controller Operational Registers.
  * @command:		USBCMD - xHC command register
@@ -85,16 +96,7 @@ struct xhci_cap_regs {
  * @cmd_ring:		CRP - 64-bit Command Ring Pointer
  * @dcbaa_ptr:		DCBAAP - 64-bit Device Context Base Address Array Pointer
  * @config_reg:		CONFIG - Configure Register
- * @port_status_base:	PORTSCn - base address for Port Status and Control
- * 			Each port has a Port Status and Control register,
- * 			followed by a Port Power Management Status and Control
- * 			register, a Port Link Info register, and a reserved
- * 			register.
- * @port_power_base:	PORTPMSCn - base address for
- * 			Port Power Management Status and Control
- * @port_link_base:	PORTLIn - base address for Port Link Info (current
- * 			Link PM state and control) for USB 2.1 and USB 3.0
- * 			devices.
+ * @port_regs:		Port Register Sets, from 1 to MaxPorts (defined by HCSPARAMS1).
  */
 struct xhci_op_regs {
 	__le32	command;
@@ -110,13 +112,7 @@ struct xhci_op_regs {
 	__le32	config_reg;
 	/* rsvd: offset 0x3C-3FF */
 	__le32	reserved4[241];
-	/* port 1 registers, which serve as a base address for other ports */
-	__le32	port_status_base;
-	__le32	port_power_base;
-	__le32	port_link_base;
-	__le32	reserved5;
-	/* registers for ports 2-255 */
-	__le32	reserved6[NUM_PORT_REGS*254];
+	struct xhci_port_regs port_regs[];
 };
 
 /* USBCMD - USB command - command bitmasks */
-- 
2.53.0

