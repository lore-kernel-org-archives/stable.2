Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173AB380FCA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292811; cv=none; b=n/801kobEbdl0qVEV/A7yjHYHEFrmazZfn4RCbNrv7eSiR1e6OgpUJ/todwHZCjfBl+iLG8ArksMC5+/bRTpxVLX1XLqop1XgdVMUSLBN7QsBQdqDJsmlYw0SK56eYknOvSLEmpnaprcDAxzaYWkJbhpzSxt46oe82CXGJFIRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292811; c=relaxed/simple;
	bh=x/4KYekynCBU3ctFHAmXHZV5FWOgGhBSSEoBBlMVWuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA7778xdLwbHpvsjb1te0hBdS8y2iFunswNu5UCd6durzqZQ9GK2Uum0wYy0eTOtOIMODhpe1uaz9CYoI5ryI2dhs9meuOlSIBurk45lVKW1tq+fo1qAkAt1EfGvsOxzYFbepJIk+ZS8wgZMdsBlGTeWXo8pOZKC/jZhcSf96ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D65OQo+t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D65OQo+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E320A1F00A3A;
	Wed, 29 Jul 2026 02:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292809;
	bh=fDj++L3r7ZIAAVBYgAwv0CszKuxHs9I7yWmjrnv81fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D65OQo+tRE9p363kFWKbQJrhsh5SrTX4VWTLwaLRp/jVxLqaSTUKKXefgOTuyI5Im
	 yboppG6EkYK8eu29pMkHjyO81OiOU7xDGQnBzW/boUb0oZFbz68zVkB/+y3qA4ia2g
	 sgIY4t43k97a1q5dJt0z1bBcn0IoH0Z34d/Iy+hNL9kZApN5WHCYB5+RDNNf3oiobx
	 b72m/+hpG09OxJd+su/ijaPaAa5fhj/nUMBYJIh3CEsSGMFtRoNBjYSUMevl6krTmm
	 NKZ50jGV0FgVEZFG9Khr27nUYaFeKSLs7OVHJE8D+e1Du8h2PgHfOuQIhTZo7gQtJo
	 8pd1+BGX63Mkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ata: libata-core: Reject an invalid concurrent positioning ranges count
Date: Tue, 28 Jul 2026 22:40:07 -0400
Message-ID: <20260729024007.1127363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072113-preshow-stoppage-40c9@gregkh>
References: <2026072113-preshow-stoppage-40c9@gregkh>
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
[ adapted `kzalloc_flex()` allocation to `kzalloc(struct_size(...), GFP_KERNEL)` and adjusted context offsets. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 18 ++++++++++++++++++
 drivers/ata/libata-scsi.c |  2 --
 drivers/ata/libata.h      |  9 +++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 07dd04b8d01d16..3992a12b90a2a3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2794,6 +2794,24 @@ static void ata_dev_config_cpr(struct ata_device *dev)
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
index 300818cb1478a2..0da8c69dc966cc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -37,8 +37,6 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_SCSI_RBUF_SIZE	2048
-
 static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
 static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 9927d79e55878b..dc2a4583441cd5 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -111,6 +111,15 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
 #endif
 
 /* libata-scsi.c */
+#define ATA_SCSI_RBUF_SIZE	2048
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

