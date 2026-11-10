Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273916;
	b=HC5kOSJvhDxW5wZmU/TYael7u716pJ2ZWORLC/LpMVmu8cLyxppxLRSM/TuVYFZQuTMG
	 UW12ZTNAw9nH5iYCN1urbe5/ebAk688UCQy3V9uS6IzPo53PcA5n8yBoSvvx7xf8Plzta
	 Qlf3Yxk5KMoJwhUrk7QawLGMvIjWwq/pTAvd0ou9U+WRn3Iv0eYHMQGcdLrmyYrJ4r907
	 hbeNX7eKKDZNn8/P5NkC3g06oTNrTs/DH/fZYH0HD/x1kSi+1cNB8rLZG5jcQk7NX5Ts2
	 6nWdXG2yXOUuIFmXmV20BsYcCYUkZvMe1w631VPgjvqpx6PilySULnaH/27L8Kji9nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u5NuzANpTDRhCIJa3BEC2VKv/qUstNMTJ/7GUUMyHng=;
	b=xiy04nCKddaNyBqzEJQWyEm1ZeEQz+drsQzYEPlDP2DKdFJ15FJUi++l9kpt0hZANsi9
	 eIx2VQWVW4VU23Qd02uyn6/HRlgGW8exSOaHCagOhq6aVNF1aXPakPbbHXyMQwc1RYXbo
	 Xvt96+NwQWMqzdPjR+F5QdRLljnm46igJts608awOqI+vXLBRfaBn7tXyciTU++QD3jNt
	 9rZg0kCePKzTgJ1y9F9/Rb5RkZ6EwnGbFM+GGiVbXv/nXerHbeebL+Uj83iWxJm5MRkwR
	 UMzjzSZQWa7nCKwJ6mZ14bsmlTe+INqgI70TGGHN+EP8W2K+2y8Rs95HFrn1jDVbuAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lz1IKQ3j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD56606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lz1IKQ3j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631771F0089F;
	Tue, 10 Nov 2026 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273915;
	bh=u5NuzANpTDRhCIJa3BEC2VKv/qUstNMTJ/7GUUMyHng=;
	h=From:To:Cc:Subject:Date;
	b=lz1IKQ3j/gswE9fM7W7xh7MNSDpZx8PHwJEyzZSVt+EnVgww4KsJ/KVIqQzvloACX
	 fRn5F0UACrsTUz6f3ba4uVSi2pK0Agq4vJuXpEtp7ajsWaOSLWrtAnKHmDv5a+cAN9
	 BJlKucYQIiBhnc/r0nqjIt/l8K8Dm3jDwNi//jhdfDho6h0JN0BMoC45m7JC+gYepr
	 ItVYuZ3e9ivnVhU/hQO5jg/0PCzrDS2HgyF1aplT0hOuMIp5Th5/HykP1j8FomDTX2
	 BRsZhmBw+EkHKifmUuewi2magcBryinX/LzsScK05kycnij9cnJidQ468xYOyYfgl+
	 TEiQQexWsAmGA==
From: Sasha Levin <sashal@kernel.org>
To: kaloz@kernel.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:14 -0500
Message-ID: <20261109202514-failed-5.10-696bdfc58975@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 696bdfc58975fbc70d2e2347a74e0b562e7e2494
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202514-failed-5.10-696bdfc58975@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 696bdfc58975fbc70d2e2347a74e0b562e7e2494 Mon Sep 17 00:00:00 2001
From: Imre Kaloz <kaloz@kernel.org>
Date: Mon, 26 Oct 2026 14:14:32 +0100
Subject: [PATCH] scsi: aic7xxx: Use default settings on the SGI O2 onboard
 controllers

The SGI O2 firmware runs its onboard aic7880s without the Adaptec BIOS, so
scratch RAM holds no settings. The left over BIOS path reads uninitialised
bytes, and bad parity panics the boot.

Use the defaults there with host ID 0. ahc_init() keeps the default host ID
ahc_pci_config() chose, 7 on other PCI controllers, so only the O2 changes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
Link: https://patch.msgid.link/20261026131432.26065-1-kaloz@kernel.org
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/scsi/aic7xxx/aic7xxx_core.c |  8 ++++++--
 drivers/scsi/aic7xxx/aic7xxx_pci.c  | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index db330ca927678..af6115bfb2808 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -5266,9 +5266,13 @@ ahc_init(struct ahc_softc *ahc)
 
 	/*
 	 * Assume we have a board at this stage and it has been reset.
+	 * PCI controllers keep the host ID ahc_pci_config() chose.
 	 */
-	if ((ahc->flags & AHC_USEDEFAULTS) != 0)
-		ahc->our_id = ahc->our_id_b = 7;
+	if ((ahc->flags & AHC_USEDEFAULTS) != 0) {
+		if ((ahc->chip & AHC_PCI) == 0)
+			ahc->our_id = 7;
+		ahc->our_id_b = 7;
+	}
 
 	/*
 	 * Default to allowing initiator operations.
diff --git a/drivers/scsi/aic7xxx/aic7xxx_pci.c b/drivers/scsi/aic7xxx/aic7xxx_pci.c
index 2d4c85426dc3e..5a04c7d55e4b5 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_pci.c
@@ -701,6 +701,21 @@ ahc_find_pci_device(ahc_dev_softc_t pci)
 	return (NULL);
 }
 
+/*
+ * The SGI O2 firmware runs its onboard controllers, in slots 1 and 2 of the
+ * root bus, without the Adaptec BIOS and at host ID 0.  It leaves no settings
+ * in scratch RAM, which may still hold power-on contents with bad parity.
+ */
+static bool
+ahc_pci_sgi_o2_onboard(struct ahc_softc *ahc)
+{
+	int slot = ahc_get_pci_slot(ahc->dev_softc);
+
+	return IS_ENABLED(CONFIG_SGI_IP32) &&
+	       ahc_get_pci_bus(ahc->dev_softc) == 0 &&
+	       (slot == 1 || slot == 2);
+}
+
 int
 ahc_pci_config(struct ahc_softc *ahc, const struct ahc_pci_identity *entry)
 {
@@ -782,6 +797,9 @@ ahc_pci_config(struct ahc_softc *ahc, const struct ahc_pci_identity *entry)
 	ahc->bus_intr = ahc_pci_intr;
 	ahc->bus_chip_init = ahc_pci_chip_init;
 
+	if (ahc_pci_sgi_o2_onboard(ahc))
+		ahc->flags |= AHC_NO_BIOS_INIT;
+
 	/* Remember how the card was setup in case there is no SEEPROM */
 	if ((ahc_inb(ahc, HCNTRL) & POWRDN) == 0) {
 		ahc_pause(ahc);
@@ -898,7 +916,7 @@ ahc_pci_config(struct ahc_softc *ahc, const struct ahc_pci_identity *entry)
 			 * Assume only one connector and always turn
 			 * on termination.
 			 */
- 			our_id = 0x07;
+			our_id = ahc_pci_sgi_o2_onboard(ahc) ? 0 : 0x07;
 			sxfrctl1 = STPWEN;
 		}
 		ahc_outb(ahc, SCSICONF, our_id|ENSPCHK|RESET_SCSI);
-- 
2.53.0




