Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705473;
	b=mWkML5xSlLTy2LhJFA5NAr0JBVxplCvF8rNUm66WREDmLDcIatIDoDb32RRinu6LC8D+
	 rji1a/GXJ8MQYCyDiOR/KPTAgM/V392eA13ml6G4ZomH93OxFzyTJrz2eLmV/+88iDKrN
	 x6jNQVPNJygwZvpbKkToG9ipnRZ40PPTRVYdOtE3qy4pDBtQCBKpKPywfEUfsgjt64Wwn
	 NA/K47nrwrmryQ3+Xg9RCKPwO/EqHO+HVq5Cm5EdHDX0XHtco2YrT/sIN587J4MRYPpy3
	 lyIvj+57PGCRkpkS7DoB2alz7cEQAhlYPOdqWkfDMcD/fMnIlMwM+UknBOfM0SUIP3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AZsTgJrxtY/+ecmVuz+oazu+q/Ray5FVhnHMX5K0qnI=;
	b=Ng5FQ46MMOP0+OiDmWWdSeaLrFAs43s0EpeQzvnOpBz4rbijHLcbTZWZQQWZTWthHKY0
	 sKvUC7FYe8I0E2ccea4/xSKEsbUPQ1J34ajKch2YbQ1icEeUyB8KD543Uvpyl1cVwXuZJ
	 9waWkvNP+ojlgPcX0tHzTSNMDNGdZ7Qy6EOvdlaFvQrbFgAsaJ76LFeYkMTWoZq1+ET0s
	 MZxjFbt24JN+pYmSVZ8xZ1C/XUwqT9eu0FGbr11fjwt7FYPpC2n40llSbyv0BQNDuNbO2
	 P3+W79VmW4RKqEWiDWp996KxlI/bJKlgW8TlEUAMQGvD2HSmKTzPMDIoBmI+c5JuK9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6BD5lVB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D878606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6BD5lVB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7673B1F000C4;
	Sun, 15 Nov 2026 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794705473;
	bh=AZsTgJrxtY/+ecmVuz+oazu+q/Ray5FVhnHMX5K0qnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6BD5lVBNxjLGSfa9BBjQvOnWycaSofIXPzsOW8KutKoLM7OulR2GTGecMfO52osZ
	 9Lg5N0dcAqVNIkGeJtM6Qyb+Mw/mFEaoxyokS4fjVvRJVeUIwQCosz4QwqcNrIspDo
	 Ex7gr6GFFdWsQEZYVZlKKDF702Vrc3pnor7Yixxz5QTiRNWB7nzIFLuCwmOLhgVtv3
	 7lXO7HA8qTSNqOW7x9IRgesXGPnNf5N26J648QZ/lbNxoCOl5sjWJ+w1Vczv89c+pk
	 eJ1Zfuzj8hhATriFhvMncDEDCp2l0Kk2YevX0e9kUTRuLLv1M4jN1cHLmABLlWd1/A
	 po+4QPKu2gQJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Kaloz <kaloz@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers
Date: Sat, 14 Nov 2026 20:17:50 -0500
Message-ID: <20261115011714.549863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202514-failed-5.10-696bdfc58975@kernel.org>
References: <20261109202514-failed-5.10-696bdfc58975@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Kaloz <kaloz@kernel.org>

[ Upstream commit 696bdfc58975fbc70d2e2347a74e0b562e7e2494 ]

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
[ sashal: Adjusted context in ahc_init() to preserve an existing tab on the blank line after the host-ID assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aic7xxx/aic7xxx_core.c |  8 ++++++--
 drivers/scsi/aic7xxx/aic7xxx_pci.c  | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index 12fed15dec66f..a6b18547df7d7 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -5267,9 +5267,13 @@ ahc_init(struct ahc_softc *ahc)
 
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
index 656f680c78024..7db8e20aff5c4 100644
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

