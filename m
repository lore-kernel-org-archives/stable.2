Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321275;
	b=C0upahRiRR+m43Y6hnfxZGqQjazLdB2ElWrx3W8SqIpaOHV9zpvbHpaciem8ysRJR87D
	 nLqNCrspI9GjAi7+XQCuhvosyix8lKZWWpE+4qIu/sxlE+JbXh1EJdbslBYMVvBYhwwLu
	 ZcAZLzxfuXZTACUX/0LljMqQJ3KTBgqDQxyfhtIXCtQknxSuLHO3DRwJ44iJiR8S54QXg
	 QdpIQtZ//mCH26Wjidc6npbwUe0ZrWEafcylu615PQrJhgpygotRjGn8QGw/apJUAoALV
	 LPTfFFy8daua9I6blZllTZpa7u9AvFz2PNDnno3CiAyWcE8AkAlIWWwGYKHuGu/SUZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MhhvWUGrbBZFNHI5sgf2+ZYa8GHif0/a/8ttxejNqwU=;
	b=gi4h8p+6VEoy2K6R6Zbh66uj13dAu8gZtgNwroguzVvJwSDeI2VJKfcmK22/b92JrfwC
	 zeKkaaitb/xDVX11Hq8puUE/8bPuBSVVeyXq0QKT4UCjN21jS+PXBpgNCCDAmbyroyVbA
	 /Hgqq/vDuGy+Q5PkMMPCs2xvuOBdmeYhUb+H9nFhVUGFZqG8v6x3Xq/1Pk9Z37p4JBWxP
	 gum7nQNpbq/jNaLRiMp7/pMg9ukAlAaJTYIWGz7QjnMyXgj3ouxzc997WU4Q8ezjnWSjk
	 ub2156SpXOUrvO5nbf2v4aGRXm6wWoPWw2Are+uKhqfY8nRMJWHu1uVgBkbX4eqchWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMtjDNKK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CD606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMtjDNKK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B61F0089F;
	Tue, 10 Nov 2026 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321275;
	bh=MhhvWUGrbBZFNHI5sgf2+ZYa8GHif0/a/8ttxejNqwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RMtjDNKK7b6Adu6LNviFcwy9XExz1xXbxAk40+O4W7wUacspKVfeU3AZpckrVeS4u
	 2xAlnaaUi447Z1hnkrsHg2Wfb0xolkreuhQHyvlxzIKzXWNYMQ+OLrb/JpK5nKG6Gh
	 +9Po58jIA5KPsUjnc7nNPZEtarZa7zr/MQ/sGIqfti1CKrF9DZiVsEQRScAfZE8Qtg
	 gsU3xrS+CJHvLRxa5yXzhado9Ndj+b8yspqvWQ35WK1iRCG929khjnIJjAb6EFZMSa
	 f7KqwJJWPdVwUxj0hFP/zTq7WP39aM53Xb70p3+GPs/b6jRK2U68vOcbLDnlvJiIF7
	 BQQBjcNyrK4KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ata: ahci: print the lpm policy on boot
Date: Tue, 10 Nov 2026 09:34:32 -0500
Message-ID: <20261110143342.1911123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055900-failed-5.15-34a4a34431ed@kernel.org>
References: <20261107055900-failed-5.15-34a4a34431ed@kernel.org>
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

From: Niklas Cassel <niklas.cassel@wdc.com>

[ Upstream commit affccb16c117d188eb09495cbdea149cecbf00b9 ]

The target LPM policy can be set using either a Kconfig or a kernel module
parameter.

However, if the board type is set to anything but board_ahci_low_power,
then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.

Additionally, if the default suspend is suspend to idle, depending on the
hardware capabilities of the HBA, ahci_update_initial_lpm_policy() might
override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
ATA_LPM_MIN_POWER.

All this means that it is very hard to know which LPM policy a user will
actually be using on a given system.

In order to make it easier to debug LPM related issues, print the LPM
policy on boot.

One common LPM related issue is that the device fails to link up.
Because of that, we cannot add this print to ata_dev_configure(), as that
function is only called after a successful link up. Instead, add the info
using ata_port_desc(), with the help of a new ata_port_desc_misc() helper.
The port description is printed once per port during boot.

Before changes:
ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170

After changes:
ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170 lpm-pol 4
ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170 lpm-pol 4

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Stable-dep-of: 34a4a34431ed ("ata: libahci: Free the IRQs when activating a multi-IRQ host fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci.c     |  2 +-
 drivers/ata/libata-core.c |  2 +-
 drivers/ata/libata-sff.c  | 10 +++++-----
 drivers/ata/pata_cs5520.c |  2 +-
 include/linux/libata.h    |  5 +++++
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index f6af0683a6520..a30e17265e873 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2594,7 +2594,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 
 		if (rc)
 			return rc;
-		ata_port_desc(host->ports[i], "irq %d", irq);
+		ata_port_desc_misc(host->ports[i], irq);
 	}
 
 	return ata_host_register(host, sht);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index acc78416be8ee..00fafdbafe6e8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5911,7 +5911,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 		return rc;
 
 	for (i = 0; i < host->n_ports; i++)
-		ata_port_desc(host->ports[i], "irq %d", irq);
+		ata_port_desc_misc(host->ports[i], irq);
 
 	rc = ata_host_register(host, sht);
 	/* if failed, just free the IRQ and leave ports alone */
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ab1fe23810707..5cf8086943256 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2405,7 +2405,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		for (i = 0; i < 2; i++) {
 			if (ata_port_is_dummy(host->ports[i]))
 				continue;
-			ata_port_desc(host->ports[i], "irq %d", pdev->irq);
+			ata_port_desc_misc(host->ports[i], pdev->irq);
 		}
 	} else if (legacy_mode) {
 		if (!ata_port_is_dummy(host->ports[0])) {
@@ -2415,8 +2415,8 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 			if (rc)
 				goto out;
 
-			ata_port_desc(host->ports[0], "irq %d",
-				      ATA_PRIMARY_IRQ(pdev));
+			ata_port_desc_misc(host->ports[0],
+					   ATA_PRIMARY_IRQ(pdev));
 		}
 
 		if (!ata_port_is_dummy(host->ports[1])) {
@@ -2426,8 +2426,8 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 			if (rc)
 				goto out;
 
-			ata_port_desc(host->ports[1], "irq %d",
-				      ATA_SECONDARY_IRQ(pdev));
+			ata_port_desc_misc(host->ports[1],
+					   ATA_SECONDARY_IRQ(pdev));
 		}
 	}
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 247c147026243..3c813246794c4 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -212,7 +212,7 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		if (rc)
 			return rc;
 
-		ata_port_desc(ap, "irq %d", irq[i]);
+		ata_port_desc_misc(ap, irq[i]);
 	}
 
 	return ata_host_register(host, &cs5520_sht);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3069064dc269c..e7645df2f3063 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1565,6 +1565,11 @@ void ata_port_desc(struct ata_port *ap, const char *fmt, ...);
 extern void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 			       const char *name);
 #endif
+static inline void ata_port_desc_misc(struct ata_port *ap, int irq)
+{
+	ata_port_desc(ap, "irq %d", irq);
+	ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
+}
 
 static inline bool ata_tag_internal(unsigned int tag)
 {
-- 
2.53.0

