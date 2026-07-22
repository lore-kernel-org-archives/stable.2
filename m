Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978644D2EC2;
	Wed, 22 Jul 2026 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719691; cv=none; b=A6NTVnyf+VhImKnOZk1bklmCInqwjSMBNVeCVq+ZjF9Uhkc1pE06UtwIKxO9Bqnh3vW8UpUmqpdCMJfjw7F+6+ofOgciCGuMiyvm2UQ5FnJZ0L/f6bhpDhCPA4lPt2+XiLI9eWjZNT5WFmOC/hf0nCxlCmcaXkXaii/Jr0nb0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719691; c=relaxed/simple;
	bh=/pUL7BxgGzHrRTl4Wiz3aJKa6cJH3AvJr8sfEzq/DPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tW849RbDH2y8F1eptiAew60mG8XS+eBs4eTYXTdKGWnCfgs1Yq1oFyMQhVBXG6ezj8GTJ1y0UZvJjiAtJax7WtsewNz/NwzTbc5p/kl6o4AKCnDvveM8TZrZSb+gA8FzG5dITOP0B2l8kgI3H0L/uFhxeS8ImtwXAyj/e4hxkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EjHUwNJV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EjHUwNJV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=wXOTISGZu/Qojt9imWYNgQJMiCgbqjSybkKHBOPZG70=; b=EjHUwNJVilkwcwOfjllANrcRQ6
	Z3yRMOcjFTGpNRxytaY9Hxmw54QmU0HLMyUr15Zyon/70jXtZI9crn3fYVo7xrA13t5ijr/w66dnV
	Ey59MNqly1TK6uLzUatOObR92G+ZaL9AvIOf7cIznpOp6LeTmCRGP0qy3R/Q+7L/91roptLQP0ca0
	5GNMgjIiBaUYEDKT/bURe+1s7Vl58dAY9N0mX8Pi8SMfLGVLHSGHm+FsihcDpzXOVzPsCmhxbzeEH
	0y+JOM9uAs+BxQE/cynnbJYAJuA1wBtIpypvXHzBjtvq09EPdTdrpq+W0VQJkN9rAn7bXTzUK3cOI
	bjOJ2fmQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wmV72-002xhO-1i;
	Wed, 22 Jul 2026 11:27:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 22 Jul 2026 04:27:36 -0700
Subject: [PATCH] usb: xhci: bail out of setup if the controller is
 inaccessible
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-xhci_dead_hc-v1-1-78f55597524b@debian.org>
X-B4-Tracking: v=1; b=H4sIACepYGoC/x3MSwqEMBAFwKs0b21AO+MvVxGRTNKa3qgkIIJ49
 4GpA9SDIlmlwNGDLJcWPXY4aipCSH7fxGiEI3DNXd0zmzsFXaL4uKRgbLv64dONbL+MinBmWfX
 +d9P8vj+Ei04AXgAAAA==
X-Change-ID: 20260722-xhci_dead_hc-35fa846923b2
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=leitao@debian.org;
 h=from:subject:message-id; bh=/pUL7BxgGzHrRTl4Wiz3aJKa6cJH3AvJr8sfEzq/DPI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqYKksecVMq5xwOetkM4NiIEtlt8LEQu7YlK0Y4
 2NaAo5BnsSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamCpLAAKCRA1o5Of/Hh3
 bW3YD/9wcS38dh3Fj99NvcjGped2lMpT7rMacFtSTPFyQZ37jJtwH1i3StOQkRxfGnNoAcN7FyH
 jsl16Bwq+uYuNrt50p9NuQ526SX3HvwChl/Agv5SDbpeJ0OFdZ1M7gIEbZWw33pA2w648hylvT4
 JFtzKdVy417wShQyMcMdxQIi8ihLync3N27AYHrtLi2TkvM2dKds50JljDGwoRuc8FEvQfl3qWf
 KfH9fGg6xgUdXUuJHdFZBCQpC4MG7mcJWh49bdvQGMnWxlXNl1et1RRYVNMldXr+WZ90NhZk6PJ
 0GzCsv/CaupmL0cjhq0GxqM7ECXP9mxOwjfDccnOfF5M0/gMr6lmtTiTjPccsLkcaiFgX1I0C/V
 B+0xSBxSZebpXkM/mDOpnfRb3hKGQ0EYqIR86yffAm8zKTp9z7yD2oVxwYT2saMO75OA8cQ3Qwc
 64D3MUeebbGU+Z1FB1Ra5fIGo+0R1ZlDuT4HsJz9CkJ8i+IX3Qsjqj+ymae2HuxlFF3kbLSCA/l
 34QtWyKRcO9uU0CcU276tuDVG7Iq9KSSsij/EqlLxu+UTHiV0gXRWmd3Ru3GmxblURzy/yYYqFy
 vgxFrMiF2sjTCbYdxT67g1JRJXDvjRWStIjXHiPo2lzKDtHx9trEyd2FWt+lmkkdsfRuYd93S7F
 ntEXS6oRuMbjs7Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

xhci_gen_setup() locates the operational registers using the capability
length read from the very first register:

	xhci->op_regs = hcd->regs +
		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));

If the controller is dead or has dropped off the bus, that read returns
~0, as I saw in practice.

The first access through it, xhci_halt() -> xhci_handshake() reading
op_regs->status,  unaligned readl() on device memory. arm64
faults on unaligned device accesses, so instead of xhci_handshake()
catching the all-ones value and returning -ENODEV, setup oopses:

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
   xhci_pci_common_prob
   xhci_pci_renesas_probe

This was hit with a Renesas uPD720201 that failed to power up ("Unable
to change power state from D3cold to D0, device inaccessible") yet still
reached the HCD probe path.

Detect the removed controller the way xhci_handshake() and xhci_reset()
already do, by testing the register for the all-ones value, and abort
setup with -ENODEV before op_regs is derived from it.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/usb/host/xhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 091c82ca8ee29..4e8a87df91d9d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5453,6 +5453,10 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	mutex_init(&xhci->mutex);
 	xhci->main_hcd = hcd;
 	xhci->cap_regs = hcd->regs;
+	if (readl(&xhci->cap_regs->hc_capbase) == U32_MAX) {
+		xhci_warn(xhci, "Host controller not accessible, removed?\n");
+		return -ENODEV;
+	}
 	xhci->op_regs = hcd->regs +
 		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
 	xhci->run_regs = hcd->regs +

---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260722-xhci_dead_hc-35fa846923b2

Best regards,
--  
Breno Leitao <leitao@debian.org>

