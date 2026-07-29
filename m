Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484814ABE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297207; cv=none; b=B0A+NNDjItD7UwHwy2D/7PKhMKSKxehMZzRopNz/mlnWjcChy9jXRwsex6J4wuab7Ty9ay009U4y3nhG6wmQRXtozQHPzWhJ5wCn2gU60+jNQbWZo0Mzd32N4VLD3La6Rf0Zqn4Ujiv67WX2uLc4VBjAERQNsI2RsAS89MblGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297207; c=relaxed/simple;
	bh=du8HHNC2luRV2ELFr+U2AeMIo0bXDW8jj7mW4NeQHwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWOPNEK3N0RZ/hWXZeKWlI2NGv3OzNdXegop+d/bG/TT7Pc7E5CdCLkstFisio9e5CBzycSxb/Kli7xMV/eMdEKradicCHkBpwG0kKve4FONSZ/Gw9yOzO3UsDfNHHFvoGrMFgL8aECEMrqNvg7V9s4f3S8SXa8D6nD0sL9oakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvyCzVwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvyCzVwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F691F000E9;
	Wed, 29 Jul 2026 03:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785297206;
	bh=HgAYa13Uv2RVWNrl8u0md+4pm3d9S/9JFavvwp+NE/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UvyCzVwUTO9Ar1xJLmr7y9ZyUUoTbkM48CM7R+BzhLT4K1y8nfnUPk6qkQnFpdgW/
	 hMluF1V104YESv/I73QtpgIS1xppFWSPBZVybB4lkzXlyt65aqur0Sd36BSsyJBgln
	 y2B2ZDewBhmw4W7L3RqUP1sLDheIrRLd8Cch8ph4GHTdwbq+B+d6zHo/gt1s0Ssf/I
	 QpdgRAigXiiklNRkImkuS0ehU0f9R24fpXFggZ+gA9ih1/qZ4MDJJulgvDJewE6kmV
	 tfmy9a/CxC3jBgzK7DovNOmSrVWorjwLun43ra0c78ovX4bCfgQJ7Z76ol6ZJ688w/
	 lgU9iG0jPS3oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ata: libata-core: Reject an invalid concurrent positioning ranges count
Date: Tue, 28 Jul 2026 23:53:23 -0400
Message-ID: <20260729035323.1379596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072113-nanometer-showdown-d9de@gregkh>
References: <2026072113-nanometer-showdown-d9de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 533a0b940f901c15e5cbbd4b5d66e871c209e8ce ]

ata_dev_config_cpr() takes the number of range descriptors from buf[0]
of the concurrent positioning ranges log (up to 255), which the device
reports independently of the log size in the GPL directory. The count is
then walked at a fixed 32-byte stride in two places with no bound: the
log read here, and the INQUIRY VPD page B9h emitter, which writes one
descriptor per range into the fixed 2048-byte ata_scsi_rbuf. A device
reporting a count larger than its own log overflows the read buffer (up
to 7704 bytes past a 512-byte slab), and a count above 62 overflows the
response buffer on the emit side.

Bound the count once, on probe, against both the log the device returned
and the number of descriptors the VPD B9h response buffer can hold
(ATA_DEV_MAX_CPR, derived from the rbuf size). Reject an out-of-range
count with a warning; this keeps the emitter in bounds with no separate
change there.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 18 ++++++++++++++++++
 drivers/ata/libata-scsi.c |  2 --
 drivers/ata/libata.h      |  9 +++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 96b13b89f0a73c..ce4dac033578ae 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2598,6 +2598,24 @@ static void ata_dev_config_cpr(struct ata_device *dev)
 	if (!nr_cpr)
 		goto out;
 
+	/*
+	 * The device reports the number of CPR descriptors independently of the
+	 * log size, and that count is also used to emit VPD page B9h into the
+	 * fixed-size rbuf. Reject a count larger than what that buffer can hold
+	 * (ATA_DEV_MAX_CPR) or larger than the log the device actually returned.
+	 */
+	if (nr_cpr > ATA_DEV_MAX_CPR) {
+		ata_dev_warn(dev,
+			     "Too many concurrent positioning ranges\n");
+		goto out;
+	}
+
+	if (buf_len < 64 + (size_t)nr_cpr * 32) {
+		ata_dev_warn(dev,
+			     "Invalid number of concurrent positioning ranges\n");
+		goto out;
+	}
+
 	cpr_log = kzalloc(struct_size(cpr_log, cpr, nr_cpr), GFP_KERNEL);
 	if (!cpr_log)
 		goto out;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5e492655230842..55bf5ebd9b082b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -37,8 +37,6 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_SCSI_RBUF_SIZE	576
-
 static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
 static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5e0e676ed9a81..25e18bcc0192b6 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -112,6 +112,15 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
 #endif
 
 /* libata-scsi.c */
+#define ATA_SCSI_RBUF_SIZE	576
+
+/*
+ * Maximum number of concurrent positioning ranges (CPR) supported. The ACS
+ * specifications allow up to 255, but we limit this to the number of CPR
+ * descriptors that fit in the rbuf buffer used to emit VPD page B9h.
+ */
+#define ATA_DEV_MAX_CPR		min(255, ((ATA_SCSI_RBUF_SIZE - 64) / 32))
+
 extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
 					    const struct scsi_device *scsidev);
 extern int ata_scsi_add_hosts(struct ata_host *host,
-- 
2.53.0

