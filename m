Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045850;
	b=e11LswJy451lBFc3ry7ieWTMeG9b66mhrT/sWQyXEcFhycKt3oV6wYr2oyVAeImfi2Rx
	 jCpZwf2TMZ+4wkze1cuHlBY3a3xAurZnR6SmGZHSv7JiesGbD+V9NqnGKH9bz1Ssu7lOr
	 HlW7idwrx09qT21hEitNuyW96sQr8cPf6R955MWHkLu6dmIGvhdDdqCMIauWBHWOMqdJ3
	 HRkB9GNmRF7ckOtiLpw9vu5abPqI2qLOqHGhxbXORaAA94x101SgE/nXRyaiLeiR8zNsN
	 NGGfEeM7lv32ldzkF4S5dKPPhgOGEDB1JnF+u7O3jAzVpOva5NLvv0nILi3cya9Gy9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Rl/FWPZrVIS4/B2wt9tqRmy29PkC98amqcpjsQmS4oU=;
	b=agNsenX7BqIwrl4i295Wn5Z0URAhkZsxhjO3I01muSCSp7jE3unlhJ3JwVSXvx1GShYg
	 un6c4A40/e4OYtCFKNlFprgKatbjGwajLAjgmaBS18WxOzwL2jO9Rrrj3nDoUZKxJGiQ6
	 OosOcpWziEGlwcoT8Gx7X+4gkxxaqToyJaE2eEamcDb3P36BjUmho94OIYN8I6vQNxwbC
	 9TKuk80I0J4pV7eYjx7My9mCpdxNU8bfbOjwMClR4ZkcfgaVaoMlaHbJ25AHmPdWB5YGA
	 2Q+f5el+/6oJxUG5jhFND7IgFqppYIRU3Jr3mi9fiEQdET594t4Gm9rJ06sHkH6c32g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cECYOsXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BFC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cECYOsXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9661F0089F;
	Sat,  7 Nov 2026 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045850;
	bh=Rl/FWPZrVIS4/B2wt9tqRmy29PkC98amqcpjsQmS4oU=;
	h=From:To:Cc:Subject:Date;
	b=cECYOsXnI0HJuKGBUsZabd37D7GSFCkhrq2fQFQUB946HmerBs3zXxXSFgTTerT8g
	 nwK9Kucy2g9Wtt8nWOX9UrHl+lB0x0LbhilA+/lN5msg539YgRNy0P17yABdqKfBXi
	 hs0DXNF7PDFV5UKoDu5mXOTju+E0fOk9+z3Hbrcqz349LNfyqg4x7SWwO5FHWmUKIq
	 IirsBHT7nwG675l5AQ316qCCKGQd/q37PC1ieEGpYY/AKfqAo5ymlsfMerwAg+0z2z
	 6AHip9D7eSe6fjBX77u2NUvmcpcBZbI2k8a4Cr0e0GU+9oPydV5ShIDlFa85wEFpdU
	 lpyP0x0AmdeZg==
From: Sasha Levin <sashal@kernel.org>
To: rathodpriyank@google.com,
	bhelgaas@google.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:08 -0500
Message-ID: <20261107050408-failed-7.3-d4c842c3af5b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x d4c842c3af5bc52b3ca0b8a7f116114e43b6ba44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050408-failed-7.3-d4c842c3af5b@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d4c842c3af5bc52b3ca0b8a7f116114e43b6ba44 Mon Sep 17 00:00:00 2001
From: Priyank Rathod <rathodpriyank@google.com>
Date: Mon, 28 Sep 2026 17:40:13 +0000
Subject: [PATCH] PCI/AER: Fix memory leak in aer_recover_work_func() when
 pci_dev is missing

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues the
entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is no
longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b013b853b5555..a6600801af6e4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1366,14 +1366,13 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
@@ -1385,13 +1384,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 
-- 
2.53.0




