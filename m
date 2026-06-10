Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF13ED137
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086530; cv=none; b=aJPBc+oFXjhxWr86G8WFG1rCTN7//4HUYQUW0OY0yqX3UcuNX0oTIl8x8fT5IT5ShGkOtV+3IdPRi1jVmqAgtxVckPnt6P7OP6JBviA31RmZBYt/tGWEpLuztjKVY+bWgNybg5jm1kAGqabIFP1kqN9WIBCo/UebZjQNy0CqwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086530; c=relaxed/simple;
	bh=GCNb3jasKO6nopDqk9sCd2N7tayU62u18NPv4F9E5wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvzAORP8jOXGvK94Y4PFtgYqHObz5GHJHGKqYccGlWU7zuKmaQ8zFKZZumMKvs7vVa6K/wLScJbyGL9bTQ0+8zARfpNVmYUYizWGuL+JEfswHNnvi72JuItj8W6mw8yf+O7fBpYEzCTNMJlmDYAdRbz/GE5GHfmJTe0y5ZlWpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mExX8IKC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mExX8IKC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84230ab8857so2951310b3a.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781086528; x=1781691328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qCxOpd6GcFF1a8SEEvdg2ZJnAIlzX8WCb8r3Ehd1kA=;
        b=mExX8IKCOjbO4KT91owRp0HRAiAc18uCC2XBygS5NxZwdymwvOxueS6MZ9qfqsyds+
         kEUU5uYvaftIzYLQoHcfamxB02mknpLNcmfbHtzWQQphlB8e/Qfp2jm3EVR0kubFa1NR
         UGxSbKS3okAVP9/9wwAJiaoTl29bx2ldD4qWDyH32vCrxypT09+S8Z+4LRpGIrgbvYzc
         pK19qI6iTe895EblT5XRvj1IlrenAM+rtr1hV/KisAf+In+Ee6bsDWdVZ75rpdCYxCyt
         z/JWP9J1tvOiNUqTeoa4LJoVls2HVMZW5yUYMpF6JjyazUcK9V6R36JT7zefgncTkgMQ
         xhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781086528; x=1781691328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qCxOpd6GcFF1a8SEEvdg2ZJnAIlzX8WCb8r3Ehd1kA=;
        b=BrHrZqkYfW7hEf458tNag6o5wBWafqkVfqPhe8u7y1wBe/LH7hvqHFlAhpAjDvKyBZ
         C8wVCVBnp5/TORrz1zOTxTpFxxoHVmcy+UQNSDxIGfWNhTgBI5JlO/5SeSZiflVLx2PY
         kxwlQV0rjHOcCvEn3i5jwPAFVMge2zSs4WHgHUg7qgsD/Jos7cYdPJAAjjC7jk7gtZdg
         YM/M5QRPV14Bec5/fy8c4PXFWK1ral3obnezcu8FjTWvMGboWIUN9Gn5btSOTH3IrGT8
         HoJtS6624r6Z+84X+JYCm4qGh6t4TkOCyXX0xGK4g5IKdHPFLRAi/hQZOnjjDBBBiOUq
         AIpg==
X-Gm-Message-State: AOJu0YzjpnG1wFQT97VTQ4URqdfIi5OxXRppwznXvsx0uv6E0hmyH9KS
	vaPGl8JZpq9L1CgVTTnC8+eobc1pOnxxudGGoq7o6kpn/m7+HWEOj9+V
X-Gm-Gg: Acq92OHah8t4UN+AFDhiVpqitKxtYK2s/vBNmmSqb4k4NpTIyfkjrc1G3b3Tpyf90p7
	Xj8oYn6hYlqdJUz0R/FTCNVJKSAq0+O43ZjJZEyUNTPc4scRPOehohYF9VzHCkyyVhuhfmGHaNr
	l0hClOidBD9CmUE5Tsu4unLLLExC17DhcWAUelp7qeM+d4Ns7rDPXQxfZFyadtqFoebyNX6MNXo
	BNrbHM9m75ChoQ+YE7CktL8i2YXJhz8jZPe1n4GoY7YsmRSPca/wh1UBZanryjCworgKT/ZMdaY
	hOTiEecOBLUZsu1ivC0Wy+3hmHIeALMRn4YQei1phpcpPACDJ7N42eai3QWBGIelnlATRV9+yA/
	gw5E5P3Nb/wYdvSWfm6aUxw6MHKJt4w7QR6KipAtxchj4VKVm8MQjLJfCX43ul+hjJ9xCLdlf0d
	Jd/thTrXZdjCNLewiyAUB4kffRXFwAlPnhwRwAmkoDG070u7qPm1kmVQhRNwV/Kf3POXo=
X-Received: by 2002:a05:6a00:414d:b0:842:47f9:b9d0 with SMTP id d2e1a72fcca58-842b1011440mr26691190b3a.46.1781086528122;
        Wed, 10 Jun 2026 03:15:28 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282221671sm25915221b3a.4.2026.06.10.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:15:27 -0700 (PDT)
From: Yuguo Li <cs.hugolee@gmail.com>
X-Google-Original-From: Yuguo Li <hugoolli@tencent.com>
To: hugoolli@tencent.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: Bail out of pci_read_bridge_bases() for SR-IOV virtual buses
Date: Wed, 10 Jun 2026 18:15:22 +0800
Message-ID: <20260610101522.1511832-1-hugoolli@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_iov_add_virtfn() routes through virtfn_add_bus(), which calls
pci_add_new_bus(parent, NULL, busnr) whenever a VF lands on a bus
number different from its PF.  This produces a pci_bus with a valid
parent but no bridge device (bus->self == NULL).  There is no bridge
to read, and the SR-IOV add path never invokes pci_scan_child_bus_*(),
so bus->is_added stays 0 on these buses.

That stays harmless until something invokes pci_rescan_bus() on a
virtual bus, e.g. via the per-device sysfs entry:

    echo 1 > /sys/bus/pci/devices/<VF>/rescan

On x86, pci_scan_child_bus_extend() then sees !bus->is_added and
calls pcibios_fixup_bus(), which unconditionally calls
pci_read_bridge_bases().  The function only guards against root
buses, so it dereferences child->self and oopses.  The fault address
is the offset of pci_dev->transparent, reached via the dev->transparent
test in the pci_info() call.

Reproduced on mainline 7.1.0-rc7+ on x86_64 with an SR-IOV-capable PF
whose VFs span multiple bus numbers, by writing "1" to a VF's sysfs
rescan attribute (LTP's tpci test does this implicitly via
pci_rescan_bus()):

    BUG: kernel NULL pointer dereference, address: 0000000000000860
    #PF: supervisor read access in kernel mode
    Oops: Oops: 0000 [#1] SMP NOPTI
    CPU: 12 ... 7.1.0-rc7+ ... PREEMPTLAZY
    RIP: 0010:pci_read_bridge_bases+0x39/0x120
    RBX: 0000000000000000  (= bus->self)
    Call Trace:
     <TASK>
     pcibios_fixup_bus+0xe/0xd0
     pci_scan_child_bus_extend+0x6b/0x2e0
     pci_rescan_bus+0x11/0x30
     ... (sysfs write to .../rescan)
     do_syscall_64+0xab/0x500

With this patch applied to the same tree, the trigger sequence
completes without crashing.

Triggering this only requires:

  - x86_64 (or any arch whose pcibios_fixup_bus() calls
    pci_read_bridge_bases()),
  - any SR-IOV-capable PF (e.g. mlx5, i40e, ixgbe, igb) where
    sriov_numvfs is large enough that at least one VF crosses to a
    new bus number, and
  - a write to that VF's sysfs rescan attribute.

The same NULL self pattern on SR-IOV virtual buses was already
addressed for the MSI IRQ domain path in commit 38ea72bdb65d
("PCI/MSI: Fix MSI IRQ domains for VFs on virtual buses"), but
pci_read_bridge_bases() was not updated in step.  The hidden
assumption that non-root buses always have a bridge dates back to
commit f92d4e29d785 ("PCI: fix wrong assumption in
pci_read_bridge_bases"), which tightened the entry guard from
"if (!dev)" to "if (!child->parent)" to handle root buses that do
have a self, but inadvertently exposed the "non-root + self == NULL"
SR-IOV virtual bus case.

Add an explicit early return for bus->self == NULL.  There are no
bridge windows or transparent decode flags to propagate when no
bridge device exists, so returning early is semantically correct and
matches the existing pci_is_root_bus() bail-out.

Fixes: f92d4e29d785 ("PCI: fix wrong assumption in pci_read_bridge_bases")
Cc: stable@vger.kernel.org
Signed-off-by: Yuguo Li <hugoolli@tencent.com>
---
 drivers/pci/probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..6bcc3b58031b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -577,6 +577,16 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
 		return;
 
+	/*
+	 * SR-IOV virtual buses are created by virtfn_add_bus() via
+	 * pci_add_new_bus(parent, NULL, busnr) when a VF lands on a bus
+	 * number different from its PF.  Such buses have a valid parent
+	 * but no bridge device (->self == NULL), so there are no bridge
+	 * windows to read.  Bail out before dereferencing @dev.
+	 */
+	if (!dev)
+		return;
+
 	pci_info(dev, "PCI bridge to %pR%s\n",
 		 &child->busn_res,
 		 dev->transparent ? " (subtractive decode)" : "");
-- 
2.43.7

