Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6EE23BCED
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285053; cv=none; b=RhQ+uuuyX3VHkxyrl4s5pFQXk+WNRAAB6W5aUBzlCBLsHXypNEVwqqpDzzhTVSl15PBf3wEZl5EXBJxDg974sXaSLmDzKSfoVbd0umLlKmALfpppIHt5XA+1JixGX/mCsBiGlaTo8Ta6t5gshjK2XWSeMSzUNaoIRpGjTzBeBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285053; c=relaxed/simple;
	bh=AtyNHYpr19erox4R+gWPHaSLt+ABfgKT8VOj+wU1Fr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQmcQ0KfIz2kR/UI/6jMPYoSVDz4qQE+j9pCBSCNK0ZiAQQsTalBqDpsrieSNARPy1KdxIiJR8Jqr0k9xEHELZEtnnFwtOckLdpicTN1iVvF2/kHbEShQ/lan3LfdPuUAEUYMkuqwjoVQWOkCE1FI4DeUWsJby6kJAnz8ttxXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOG3bmpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOG3bmpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5181F000E9;
	Wed, 29 Jul 2026 00:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285051;
	bh=hoSzebHC6Iau7EYX9g/a5oz2HCcKuqgHJ+OsXElKmh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOG3bmpqJ3O93by6zNufrTioJD147BcyJBYXNh61zFxelruSP/JyZf2boyl6tjoQ1
	 0i8EtJBretPPU74ki/kYzi06hPFLg9K30lC2ngb9rD9T0ZeoULKU4sTpLTseYmSp+J
	 uVLZpz09/CH5uQhwaTip2quTNXt6q4uyd6vv/raGv18EgfKEnJT8rOQd7Srk1ISqL9
	 hcRfW+ow0xBj8UDVi22vIhA1Xrw+KhExmUXP6qsFH0LU+Z2U1ofoaWiMj2nDRrop4t
	 TvBMRtsj/In2im6J3B0fLk8/paou7UAVoeXEq+NsD7z6ONWQKo8jdiaFQffAM1GmdH
	 XnHOrm6fZ+TNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ata: libata-core: Reject an invalid concurrent positioning ranges count
Date: Tue, 28 Jul 2026 20:30:49 -0400
Message-ID: <20260729003049.888768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072112-opacity-hamster-c113@gregkh>
References: <2026072112-opacity-hamster-c113@gregkh>
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
index 22ce6accbc5bb5..f0753f5e57a8e1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2833,6 +2833,24 @@ static void ata_dev_config_cpr(struct ata_device *dev)
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
index 46ef1ef6f81282..a7916b50cbfcad 100644
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
index 0002994ddfc9b4..56c4136b741798 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -144,6 +144,15 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
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

