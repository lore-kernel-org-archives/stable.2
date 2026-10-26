Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052694;
	b=hKdi3t/1CBjizVHPwpeCvm/93de29eWzvW+iE0onUnYRO4VPbzW5mo9416FBxLdHzQnT
	 5FxHQOC9nGQWbG8hyu0bLFFxYFh2UIPOVmN4mL+Zz3vAeHw7OOoLye644PjJlzSdM+RIl
	 3C9yp2uV4YQqv/DlS8SOA2/OTENr/8VrCNf87zOaO9dxVJr03DDbWt2D1d1hZHPaST6k9
	 UzaW6WVBcYpFO9V6rOlO+2nrg51Ak4d5UlGRG2Qms9KPXhK0gauDCCPT4od4U9XJmzCKN
	 Tf9Y28bqNdLC6AhotJlk+OxoYhz+iVO/cbZOgaYuVHg9wVBIKGQ1aFXt6TnZ0T/UAiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PSlFXJXkUUOmnhxM2S/IZTz90QMtJhrhBFHA3HUgSEc=;
	b=U7RpenSVAVtLgLVFGtQJH1/BM5JP8Kft+E2xZ97cf+biFyl1aMtZpu3Mpe0jtCe1XEJH
	 U8hpc0NgDncF/ZjaJTz2n1SXXBy+HjV+L2lFMCfd+0d4U609oKOp9M1jyEka4C8kgYozP
	 DBwzd6A+DPRQU/2LzTFCggL1CxML/fu6oZn4vtDYBwR5E5mPG5a1wRmbRdHUMMfTD7HbM
	 AxFSHg/Y7e+r+zoTm+P3GylOLFAdV4oy6LaaX0X0Elv5ELBRaK7wGWLOJfnAKQqXoyFOd
	 pnyHDPb1zVXJte0DoVh3j/i3B1Ku69/mMhvDsZSWZuFE25mUVUcCdRQ8ZUoh7rVeqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jShPicuA;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83C606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD83C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jShPicuA
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so27157775e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793052692; x=1793657492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSlFXJXkUUOmnhxM2S/IZTz90QMtJhrhBFHA3HUgSEc=;
        b=jShPicuAEHrkpvl28vBmXFaPHG4zMpZwB6uvHO8oy5BS/uTEy84mPFM8nGV0OnKk0R
         Oc7ITf/ojDJUjaCGz+DjnTUMH48wJqVbAU4L8r5EJGKYIKbc9p+j5k/oSCEXjjbnrcoy
         Cs7P+XApdaoteCpo6a+mZU04uzXuJmvJ61OfhP4yBPrS/GcsWi05k8sjsaAEV/v6WmnX
         zDUzeAM4Uui7tjtKh5QgIbr1LjOQDjp44svvKSFTzCz1L29c2AU08ETWWDpkoJGP1dmZ
         Q1ZHCAB9cdFV59oTdY+E+0GsM6nhfx18VjuGMln6hwnYC6DxD54wqiiraUJGNXKJZ7Sf
         erbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052692; x=1793657492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSlFXJXkUUOmnhxM2S/IZTz90QMtJhrhBFHA3HUgSEc=;
        b=Vs0zu2VyPGsfBV6mo0eD5S7ApZ20jzqnfqPUk06K3GMDpTWiMrO1kSRifH7uq1lH29
         e9mVZPTvgSyifQD6PapcsQxQqFn8nNQVu1B6JK833T200ecSGs/TzUC+oW7Cj18K2lyq
         kQgNJ3OHkEXz2dxltZS7rLMMmHkaxjxnQ3qMrUxKasPLXlKykhjPd28H5eLmhfTv+E/9
         ZRmM+kSTkrEPuw9rj6e836J/hh9bMxbugVQPtm8N/1IQICY0zMAoyUOcdwoa/X99F34p
         78bZuQhAKUK5+yaGiq0zM8u2k4TCmF9C2CQigXze6+aRliHF7YoPh4et7ZQ+V+oqqw2H
         vspQ==
X-Forwarded-Encrypted: i=1; AKwUvByWrJLKJFI1Zv2tYdlk8replW6aAVIERyl4RxeDHhjDIolBvQAXRngUSdFqcmq6uEFSFsQjvK8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM/kbWMo1lYN7fa27HmM9QCf2x88RW3qPQoUQ5BxfrMMaBcY90
	3WU3a/fN4FnUeIGWH3ozAvR/eRG9hT72BEawG/y7wqcDffuue/sM0lMr
X-Gm-Gg: AYBFou36BrokGxXNUPei70A/SG92woc6eLO/fEPgNphOaexGISY4T3dQG6L7mbZBHMp
	scFMdUjAiUlndfm9vrd1jUD7F7u4LH5r1VVpNKVrsAE5y+JUWS0ljIN+dg+jhJEOC/isuUsK+/Z
	Scdx6SoN9L3azxUjN0I7ufJ+zU8cLnOE5n3bjUeb6+o3FAkn/AinWzjmqYzjKcJJ1NDpC0PiDCK
	5iUUXy7l9BY+5PKgug2BXLVoMKchu4k0F+7GD7VXydfouOcA+W0IZAF0lMDIt6kEqNIhj1RAu3z
	ayY8isxtnIdi3I2lpX+sVUYa02cD6WDOOboxOZl5rKdUQkQLLvPw6neG8bBR8UmcXh71H+g6vYR
	I3UL+Xd5xwwg0VZg4vfq7PRxsmFrKNPzWd/46z5ZUu7WLrRUf2xsnIqtPibFl0N472JRLUoKmv7
	4/Kes03Kau3dVQY9lByDgP9Kkkk+mufGHyxIuwK4tiLrUSI0fA8LQSDRYwbWG48K1gA5S7eWoGt
	ONb+pbabTIHHT+1zOE8PFz6JB2/Hom5ndrq9gvTYEq3S6hpbOeU/5yJ/3HY3UZTBtiNiFr4S7Rz
	1+QZPXajBuUbsEBFll4CJIzVKBxal4AT
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a35acb5854mr138706065e9.28.1793052692005;
        Mon, 26 Oct 2026 15:11:32 -0700 (PDT)
Received: from pve.netbird.cloud (bzq-79-181-189-120.red.bezeqint.net. [79.181.189.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a56992dsm210437945e9.6.2026.10.26.15.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:11:31 -0700 (PDT)
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
To: netdev@vger.kernel.org
Cc: pavan.chebbi@broadcom.com,
	michael.chan@broadcom.com,
	kuba@kernel.org,
	edumazet@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	stable@vger.kernel.org,
	"Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Subject: [PATCH net] tg3: Invert restart quirk logic to restrict SNP power-down bypass
Date: Tue, 27 Oct 2026 00:09:56 +0200
Message-Id: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Commit 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
bypassed `tg3_power_down()` on system restarts to prevent reboot hangs and
NMIs on servers where NICs were initialized via SNP (such as Dell PowerEdge
R650 and R750).

However, skipping the power-down flow globally causes the ACPI _PTS method
to trigger fatal PCIe AER events and hangs on other models. Commit
e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot") attempted to
mitigate this by adding an AER-disable DMI quirk table. Maintaining a
growing list of models for a secondary symptom misses the root cause,
leaving systems like the PowerEdge T440 (sharing the BCM5720 NIC) exposed.

Fix this by inverting the quirk logic:
1. Restrict SNP power-down avoidance strictly to
   `tg3_restart_snp_quirk_table` for the specific systems requiring it
   (Dell PowerEdge R650 and R750).
2. Restore standard power-down behavior for all other systems, eliminating
   the separate AER-disable quirk table.

For systems affected by the original SNP restart issue, their shutdown flow
remains completely untouched.

Link: https://lore.kernel.org/netdev/20251221175050.14089-1-noam.d.eliyahu@gmail.com/T/#u
Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")
Cc: stable@vger.kernel.org
Signed-off-by: Noam D. Eliyahu <noam.d.eliyahu@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 48 +++++++----------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ce108705bbaf..95827df4cf6a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18256,53 +18256,23 @@ static int tg3_resume(struct device *device)
 
 static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
 
-/* Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fatal
- * PCIe AER event on the tg3 device if the tg3 device is not, or cannot
- * be, powered down.
+/* Systems where powering down a tg3 device on restarts triggers
+ * NMIs and fatal hangs during reboot if the network adapters were
+ * initialized under SNP.
  */
-static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
-		},
-	},
+static const struct dmi_system_id tg3_restart_snp_quirk_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
 		},
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
-		},
-	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
 		},
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "datto"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "SIRIS 5 1U Server"),
-		},
-	},
 	{}
 };
 
@@ -18320,14 +18290,18 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	if (system_state == SYSTEM_POWER_OFF)
+	if (!dmi_first_match(tg3_restart_snp_quirk_table) ||
+	    system_state == SYSTEM_POWER_OFF) {
 		tg3_power_down(tp);
-	else if (system_state == SYSTEM_RESTART &&
-		 dmi_first_match(tg3_restart_aer_quirk_table) &&
+	} else if (system_state == SYSTEM_RESTART &&
 		 pdev->current_state != PCI_D3cold &&
 		 pdev->current_state != PCI_UNKNOWN) {
 		/* Disable PCIe AER on the tg3 to avoid a fatal
 		 * error during this system restart.
+		 * Needed since on restarts for systems in
+		 * tg3_restart_snp_quirk_table skipping on powering down the
+		 * tg3 device causes a fatal AER error during ACPI _PTS
+		 * (Prepare To Sleep).
 		 */
 		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
 					   PCI_EXP_DEVCTL_CERE |
-- 
2.39.5

