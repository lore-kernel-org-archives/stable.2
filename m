Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9A420460;
	Fri, 24 Jul 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886068; cv=none; b=airdTFkkCgsHCz621fsmLz2d0IU2iS+X+hJYRO92TNWw8XZbmH0Aqio3h/CgefDVV/hpUkwux/cfBrjCAiNGIQyLfEy1f+eQfBOpxA+ciqw5bF32+phWUHqAqqhOCI5TaDbYDmmaHLTzaD/BmL/xT8BaNt2XQQ/b5A0P21nppPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886068; c=relaxed/simple;
	bh=235G7a9BBCD3MJGRC1VvERvc3pDPEgvmtKrQXMGiiYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mqn+eLayyMg5K5eh3dHTyQwx9uolvQ7vlW+BVz1+Vgx/9uSCRYSERWZgW59aUhsL7uFC3c5SJnQHZw9wt+4URGG8CsGrYki3siwggJi2JInneNlB+wPqjvV+ppYdMDcA2Y6Yw8VxhJqYB+iCTs4v9y4xsr/+Mw8ji72ia1UyLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NI4Xgf2z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NI4Xgf2z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=EElDP5q53G0lEtpIs+Ip+naIxZAG4WadSe4WlXIHZZo=; b=NI4Xgf2zS6VO2QQ/itiqTY46wO
	ZRp7stbSN4hzR0WKfghWrBt1t/0Ij8tAlhH5Gq3PArY0ohcn6QbkEcb8G3R3wzf8Yu2Mpycjfr/hW
	1r67iX6WHLACqtQhuawL3ehQo1W/D9wZzLNYeeRLXZ+lbe1OEa42LiH5dD/Eqyzn8W041PAjrG8Cb
	cszjU855QuC4aXJmbyu6JtEMS0hhIOEWjVY9LMUkaYv4JbTTBGZtwcBa5p9Z46XnS3ETg0FPdy0Le
	B/JERm3G/lqRpGL7wF4hA5oIwucJbhHxJ96uJ0dlws1ngbPyKJsr6NTBCE++Y+6mLLtYShtG3UUWs
	Szg5TUCA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnCOn-004Syv-2C;
	Fri, 24 Jul 2026 09:40:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 02:38:13 -0700
Subject: [PATCH v2] usb: xhci: bail out of setup if the controller is
 inaccessible
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-xhci_dead_hc-v2-1-1f8dee685ef1@debian.org>
X-B4-Tracking: v=1; b=H4sIAIQyY2oC/3XMsQ6DIBAA0F8hN0Ojp4g69T8aY1AOuQUNNMbG+
 O9N3bu+4Z2QKTFl6MUJiXbOvEboBUoBc7BxIcUOegFYYFMYRHWEmUdH1o1hVpX2tq2bDqsJQQr
 YEnk+7u41SAGB83tNn3vfy5/+ifZSlcq0XmvdGY319HQ0sY2PNS0wXNf1Bccv2LWpAAAA
X-Change-ID: 20260722-xhci_dead_hc-35fa846923b2
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4324; i=leitao@debian.org;
 h=from:subject:message-id; bh=235G7a9BBCD3MJGRC1VvERvc3pDPEgvmtKrQXMGiiYs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqYzMlWHyddJlMJjfIW+vEIMCaO6yOxdOE3/hIz
 4laURCSaeCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamMzJQAKCRA1o5Of/Hh3
 bQJuD/9t0ls8AqHmSmUGappLD7czPIxK6o0UZFyEwPMvJTiQOKO0WPjVtgFo+EhHKvicLeUQJ5f
 JlRoQwlcClX2c80yKA8pqF7EDUcPp4yb73TXiR6KWxBStzBbWVzCMxgrQkiC8amlf2owTpC4Lcl
 1VinO5Wr1E1V2s7KaFxzn2OzF4+EpgXDXdLSV+0h/ur9X/mYANbxXrHFrMhX1xsnFo6INMGoXna
 5d2Fok7xsOx1xGzVEdaHM8WaR6g7Np4gZ2qZQr0E7eQR6aP3afK2YbHDZR0GV/ZCfYjXCT5IMIM
 v8Cy35rxoO5hxcPGwhEs5ECpDdW/bewLsD5jSwRnM+xVaOvqH6T4OOeS+YkZl0g4SUcptN5hler
 yklQJ/SzHAx/jGkPwrT59wb2kobpTh9dZ2ngsk+0HP/1itdOJv3jwM1hDysHLkqoXwMGVAqYwc5
 XAG9H7Cf9/AtD2u0Ucg+0ICDAyM5CvExTLWQLWJb3t/UyNzkY0ef+o6exFmkNFaPXoa50+WlYFy
 ctFmz6o+u6U8zsA16kg7qJdKaRbVZF/AAKQ1IW/npJd8kENRnsnai48K2REffm2qIHEapbXqd1q
 YmonXro7V31BwDHMirauFSC17pJBxutXu7o56A50y2KkP/Hbnqd884UnunNCWWWSbGNK/O9LHYg
 UMG4DlYxfe+zoAQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

xhci_gen_setup() locates the operational registers using the capability
length read from the very first register:

	xhci->op_regs = hcd->regs +
		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));

If the controller is dead or has dropped off the bus, that read returns
~0, HC_LENGTH() truncates it to 0xff, and op_regs ends up 0xff bytes
past the page-aligned MMIO base, i.e. unaligned. The first access
through it, xhci_halt() -> xhci_handshake() reading op_regs->status, is
then an unaligned readl() on device memory. arm64 faults on unaligned
device accesses, so instead of xhci_handshake() catching the all-ones
value and returning -ENODEV, setup oopses:

  xhci-pci-renesas 0005:08:00.0: Unable to change power state from D3cold to D0, device inaccessible
  xhci-pci-renesas 0005:08:00.0: xHCI Host Controller
  xhci-pci-renesas 0005:08:00.0: new USB bus registered, assigned bus number 1
  Unable to handle kernel paging request at virtual address ffff80030a770103
    ESR = 0x0000000096000021
    FSC = 0x21: alignment fault
  Internal error: Oops: 0000000096000021 [#1]  SMP
  pc : xhci_halt [xhci_hcd]
  Call trace:
   xhci_halt
   xhci_gen_setup
   xhci_pci_setup
   usb_add_hcd
   usb_hcd_pci_probe
   xhci_pci_common_probe
   xhci_pci_renesas_probe

This was hit with a Renesas uPD720201 that failed to power up ("Unable
to change power state from D3cold to D0, device inaccessible") yet still
reached the HCD probe path.

Read the capability register once, and if it reads back the all-ones
value (as xhci_handshake() and xhci_reset() already test for), abort
setup with -ENODEV before op_regs is derived from it. Reading it once
also avoids re-reading a register that may change under a concurrent
hot-removal.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Read hc_capbase once into a local and validate that value, then use it
  for op_regs and hci_version, so a concurrent hot-removal can no longer
  slip a U32_MAX in between the check and its use (Michal Pecio).
- Fix typos in the commit message.
- Link to v1: https://patch.msgid.link/20260722-xhci_dead_hc-v1-1-78f55597524b@debian.org

To: Mathias Nyman <mathias.nyman@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/host/xhci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 091c82ca8ee29..5c759ad28199f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5433,6 +5433,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	struct device		*dev = hcd->self.sysdev;
 	int			retval;
 	u32			hcs_params1;
+	u32			hc_capbase;
 
 	/* Accept arbitrarily long scatter-gather lists */
 	hcd->self.sg_tablesize = ~0;
@@ -5453,15 +5454,19 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	mutex_init(&xhci->mutex);
 	xhci->main_hcd = hcd;
 	xhci->cap_regs = hcd->regs;
-	xhci->op_regs = hcd->regs +
-		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
+	hc_capbase = readl(&xhci->cap_regs->hc_capbase);
+	if (hc_capbase == U32_MAX) {
+		xhci_warn(xhci, "Host controller not accessible, removed?\n");
+		return -ENODEV;
+	}
+	xhci->op_regs = hcd->regs + HC_LENGTH(hc_capbase);
 	xhci->run_regs = hcd->regs +
 		(readl(&xhci->cap_regs->run_regs_off) & RTSOFF_MASK);
 	/* Cache read-only capability registers */
 	hcs_params1 = readl(&xhci->cap_regs->hcs_params1);
 	xhci->hcs_params2 = readl(&xhci->cap_regs->hcs_params2);
 	xhci->hcs_params3 = readl(&xhci->cap_regs->hcs_params3);
-	xhci->hci_version = HC_VERSION(readl(&xhci->cap_regs->hc_capbase));
+	xhci->hci_version = HC_VERSION(hc_capbase);
 	xhci->hcc_params = readl(&xhci->cap_regs->hcc_params);
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);

---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260722-xhci_dead_hc-35fa846923b2

Best regards,
--  
Breno Leitao <leitao@debian.org>

