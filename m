Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615424028E8
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096805; cv=none; b=ubOugOUWb8j8+n2e6cvhN+xqp9+O/7zsSE/dAG38IdhYrrczL0CNUcOYaHs+WXiCOHIAocSAQJr1DqolyhCjFi6ulBy7nGWmzSnty4AT3Ajc2GGcjks89z6K5unSURFJ0782U8K65lwBEHZbVa2gZPNKjKmjwGlEbGKy9eFeZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096805; c=relaxed/simple;
	bh=GCNb3jasKO6nopDqk9sCd2N7tayU62u18NPv4F9E5wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyO0cY3sIGtbt7dxQ3QCvBnvvdI38u2WFVmPS06JSUM0Y00HuFjQeHO6AU2enVsQrDwy2U79D2PXjI4OTs1o052do0zB3mtLz+3H4B7jPH/2SMzj+S4eEJIktnyNxcdrPWhwUBVjkTY6IQFqnHsJRKpYLnLeFpqSWY6ytwu2Nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMJAaJqW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMJAaJqW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2247e38eso69556735ad.3
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096804; x=1781701604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qCxOpd6GcFF1a8SEEvdg2ZJnAIlzX8WCb8r3Ehd1kA=;
        b=NMJAaJqWL6pWyrSc1WbVuk4KYpPzcY5zmApbnbicoGNoOO6yVWjQ1MDw534Nfmtw+P
         qtpxabZaTlpPFV60yiGkscF9D3mtMsgfzW1UDBygPP35AlceNq6jW6O3UI8fyzgMpqhG
         2+EOnveo3bsC1m95c+RsElKA9wTrFn/7Wx6+4tacby7B99RORrAP0v2ecGnSJogYkoUv
         BjtRHPcY7itSfz0RYwF4H0RStq+YGrkLaSODmD+RfCmRpFly2kZMyaEp2tgH6E74kipx
         UEnTsHxH9fLDxqxhH+QEgcnT2UxMRgDhYv+doHud7DU1MyphPnmFp3C+cl2EQOSm1fTJ
         aw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096804; x=1781701604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qCxOpd6GcFF1a8SEEvdg2ZJnAIlzX8WCb8r3Ehd1kA=;
        b=Q4IDU2Hr8TZiYNhK/d2HE6V1uQHB8s4zQNEmMlb1ehc/TdgQjezaqSxPV08MfcmEKs
         2WqbIJO5BfGX5Int93A2sBZj7Bwf0TthsOMmQEFVBLlNYsMwoT7Yin9cn+Y69G8RD3qG
         ihlRKQLknn8fJ/g1hmv1wNOCVRA++NhGJPO7DU1rQP0M5C0n12jA7vtAv7sDNGOCZhVV
         g6h0OMObSqrv5lmruJ0Spto8bxvWlYSLfYDT9ghCTScIJyB/I0oRdpN6mnePvaVDOfRL
         sqAREHSLhtg007U8qLNDavuOd63dQxisd6DfRgefUT3yK8RSKfGGArAYLIUSyh3O1n6l
         Ph7g==
X-Forwarded-Encrypted: i=1; AFNElJ+bW09SQULjtMjnzc+MsJ9rKAJCIVKjxdd3rBjGTLO/hvZDOEcVa7RarIUl2I7t5d7Uh+6C+Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIXPyil6vt2pg0p3ZAY5Oe9LUyAgmbJ9bAxsSPnYUmcfYCWsr
	HVlVdo1OzRPsFbsWj+u7hrpn/uNzclOuSysp7dhReizz/kOP1n7c59Qb
X-Gm-Gg: Acq92OEE/S4GhbOHNTUDv4S2Tj3wpNF6reh4X6Ulch9v5bNwKpthw5NRJaWYlsr5Fh1
	cO+0ZEwMRJJIkifOTEUgGX3uReuX0zXO/A9VK8zs36Vwdv23e3H2TqZeEGABGOvDtKUzCTwjgXm
	HtGJ4HU6rn1o8t7QOiT64NPepNUS5MXa1sjqf43V9on9j4RoFyKOwCFEYpElLyhB1kNq351J3h7
	MNx9dJtWAWxqDBZRb9Xy6N5I2YFRTnJ4Gu+Xk7juUDHwJlXXNuuTIf7BcCmhXw5kCDknINsfV4w
	6w22TeITuk/UaXJ7QdqEy+rqRNnOCaoSA34UxB4CRpKojfKytPEIk46HCfbLL8vWvePvO+oAyr+
	RcBC05QACvqptPKgsDTDiKUeFjA/l1FdLVFUqYQ6QhzGKZtw9C0Z2ItZgAeNesG7HUeuZ3y0io/
	3h4GHHr2hf+r7n5cW+xUGCTHfhK2aPkyuC6tbtv7WAh1bs3Og6OHL9nha0SwNqDuV7uw==
X-Received: by 2002:a17:902:e883:b0:2c0:ca93:1303 with SMTP id d9443c01a7336-2c1e80e4313mr288788555ad.6.1781096803762;
        Wed, 10 Jun 2026 06:06:43 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8679esm238523865ad.21.2026.06.10.06.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:06:43 -0700 (PDT)
From: Yuguo Li <cs.hugolee@gmail.com>
X-Google-Original-From: Yuguo Li <hugoolli@tencent.com>
To: ruippan@tencent.com,
	leonzzhu@tencent.com
Cc: hugoolli@tencent.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: Bail out of pci_read_bridge_bases() for SR-IOV virtual buses
Date: Wed, 10 Jun 2026 21:06:25 +0800
Message-ID: <20260610130627.1601141-2-hugoolli@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260610130627.1601141-1-hugoolli@tencent.com>
References: <20260610130627.1601141-1-hugoolli@tencent.com>
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

