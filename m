Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527825;
	b=QFruwnyyqRMhX/aU6nZwyXErXQt26T9lktj5rxOEagYZ/nnkaJhF2Z22wKKkP8u3idfH
	 WOEWWaCcm6+xmYk4G39pWxBRH9Sutu9aZcVJMTJc8e5T9Zu9O6yhBqEUefT5Jf/segJJo
	 41IrzU3X2+bzLd0OFcyh4MRdfQo+Byj834cEGIOeh+royVpyZCI9rGkdvNpztk0lZtAMV
	 vFNFwJeD/YAZVZn0GDEuUr3SRm72Y1FxejpozeOnWCZ9L+y9mic/GRIfm/MLZw5sSIR7+
	 342Da882Jj079FLpHNl/qq1DiIa1UUSkTY4QsGRuGw69r7cQP/KlFgWq0wP0modnz7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ElwPfqXeirLqqsU4zQh4EAXIe0nkzZW28c2DWS+oP2I=;
	b=GlnFOYSpSInRDHMJryr55jh7kQA66TxgYtSTrSdLhqaqkYiOM1vZ4V8qd9zie3gVyVsY
	 KQxonlGALRisaBeDArHgprns1qYGtJXelzFbSzwmkXhjSUkWjJzRKbrCgSIYNIhgyMbOD
	 YMsXTSSAvSp2wBHbElGSLkIcb5p8a+jzfEthCks+4BRcQ3PHjXFddxZQZ/M4kn9p+NBC5
	 bzDeEEJ/7nl3lq20yfJVqfL0RH/7BpbpamY6OONCUfnacPnhNA20oW0TxweuQl8GiW1kD
	 77tCaQsC5nNQC3K1y5SH7FBMdHYghe9/MaQQ6T5J7IXaf3E4S8aUUX9y65KTL1sovBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bdj+rMlp;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAA606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFFAA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bdj+rMlp
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4db3db8687fso502688b6e.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794527824; x=1795132624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElwPfqXeirLqqsU4zQh4EAXIe0nkzZW28c2DWS+oP2I=;
        b=Bdj+rMlpDgrKiXqotTW4jXcvpzcUv0e0jeQma6c38CAO/UzPspO7FbIsvkeOruRh3G
         1OHjcdOgjt8UpaeV8MvBDAQqQp676tX1+3HO4NEVB2+pWR2BY5E6G2GwaqGlVTY18ZG8
         myhSQGN1pus0aOgIi7CPaWi3hUfODzuVltFNaOPJVPYJhdVbOurfCYBDhZq/9Ahs4HRR
         yx6pz4+buNymzccyhZkrgHKEPyCoI/r7KzEY1IO3wFgnbib6oMFyJln8s8ndxITEi5R0
         lXp43gJGFjw0HRq/e6ThbCYd50GU5Jegggx+tBMqJ+VzwAj4Ng6TW3lVfzB8rLhfr2D0
         Fg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794527824; x=1795132624;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElwPfqXeirLqqsU4zQh4EAXIe0nkzZW28c2DWS+oP2I=;
        b=rLoBAiRL/hlqnWRUFCNaW82cCwq+erFYGmwTM6yHfWla3pesA2LDJ4SN9g5avZG6av
         T+oiK9aEulF2tyRNMY9XzmhqcXvV46c/nFr4UjYkFSQBBylghPaTpe6NPoqRh+MXqMQu
         aNd3yf7jOJsYp6FUTlVIdwxSsqcJWrYz6Y0lT1S0ermSipr31voTeD+GXZB2A8pdPTm5
         diX+hsELs2nz39DXCNJS78HiAADIOsU4I91RhrxLmhKX5Fa1IbTWGtlcTQEUGiWsdh8C
         ctRn2APdYsEh6NK7QNNmW/dVvCT6sBRNzQbSHDb1TDvKwb6IM4QNVnVEHOpzoLV0pFhc
         MWPQ==
X-Forwarded-Encrypted: i=1; AL+hErHiXFNqO8w1i04+QdwupwMflxBCBAJbCsBCLHBkJAuJ0KMrJOhhYFQia/nKsURA7cz+p1DMfng=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sNSofZ8Cuy3fig2E6Ec0/qR4pAavIKeAn1vRhZhbDfIJIaJbv
	5Xe7JpLBMdRuaWDmN079tzRJVQisYuC8Rvoq7oW8lOLac7OKpwHhLyZtLkh7kYD+CiSkFIqMe2Y
	joOKKyHXvxbmVSg==
X-Received: from iocot30-n2.prod.google.com ([2002:a05:6602:c29e:20b0:9ca:bccb:ca8a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:181d:b0:564:3fe1:2fad with SMTP id 5614622812f47-56e645d54a4mr794959b6e.42.1794527823209;
 Thu, 12 Nov 2026 15:57:03 -0800 (PST)
Date: Thu, 12 Nov 2026 23:57:00 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261112235700.2029562-1-skhawaja@google.com>
Subject: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may need it
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Anthony Pighin <anthony.pighin@nokia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
upstream bridge before resetting the device, and skips the reset if the
trylock fails.

All VFs of a PF have the same upstream bridge. Take a device with two
VFs, both used by one process. When the process is killed, both VFs can
be released at the same time. The first one takes the bridge lock and
does its FLR, the second one fails the trylock and is never reset.

The bridge lock is only needed for a bus reset, which is done through
the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
resets the bus for it because the PF and the other VFs are on the same
bus.

Add pci_reset_needs_bridge_lock(), which returns true if any reset
method enabled for the device is a bus reset, and only lock the bridge
in vfio_pci_core_disable() when it does.

Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
with two VFs. Both VFs are opened through VFIO and then closed from two
threads at the same time, counting FLRs with a kprobe on pcie_flr().
Without this patch one VF missed its FLR in 50 of 50 rounds, with it
both VFs were reset in every round. I will send a VFIO selftest for this
separately.
---
 drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  3 ++-
 include/linux/pci.h              |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..c44e4d4d8774 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5256,6 +5256,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
+/**
+ * pci_reset_needs_bridge_lock - check whether a reset of @dev may need the
+ * upstream bridge to be locked
+ * @dev: PCI device to check
+ *
+ * A bus reset of @dev is done through its upstream bridge, so the caller must
+ * hold the bridge lock. The other reset methods only access @dev itself.
+ *
+ * Return: true if any of the reset methods enabled for @dev is a bus reset.
+ */
+bool pci_reset_needs_bridge_lock(struct pci_dev *dev)
+{
+	int i, m;
+
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		m = dev->reset_methods[i];
+		if (!m)
+			break;
+
+		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
+		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_reset_needs_bridge_lock);
+
 /**
  * pci_init_reset_methods - check whether device can be safely reset
  * and store supported reset mechanisms.
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..ba3dfdadae39 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * overwrite the previously restored configuration information.
 	 */
 	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
+		bridge = pci_reset_needs_bridge_lock(pdev) ?
+			 pci_upstream_bridge(pdev) : NULL;
 		if (bridge && !pci_dev_trylock(bridge))
 			goto out_restore_state;
 		if (pci_dev_trylock(pdev)) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..cb2856f444ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1486,6 +1486,7 @@ void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
+bool pci_reset_needs_bridge_lock(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.0.611.g1030f0b940-goog

