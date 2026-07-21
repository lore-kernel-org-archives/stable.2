Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8B3C140D
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624556; cv=none; b=oH92vggy7CvZZjxvzZk/QZwVcYlx/zzFkDIMwv28+BnxN/6hLf8rKSzUBvQsUwwWTi5gfPiNmm2YdkM7N+g1vUQ8F3bDDttOl9cERLhW/Qfphn53TXgGuEfmTbm6hJ6YD4/shlLT9TnZMxJWjgvg3hg/rscf2ph4NAu6ZBQTiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624556; c=relaxed/simple;
	bh=QiertrDqc1xLKbl39Pr2krulsoFv3woLO6dfsLxd5no=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Po2M/tKs+mjYyrCgZOpmS3ajHelXotWrkHZCgP/4OrvhSvKCeWclwpL6lT6NjmLwprQzGC8neBP8mlCmicbRMieOyAkSNMo32GHXk+CQZyRbC5MqHgB3cGVHJv4lC0Lgy0cx3dp8ceLG4SdEx3FHsfN/1ellc1wshmp2QpJiawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLcLvm5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLcLvm5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2CD1F000E9;
	Tue, 21 Jul 2026 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624555;
	bh=vnEhMtJ2Rii0FM9iCjPH63EJ938XwUhMxstLhIRUFNw=;
	h=Subject:To:Cc:From:Date;
	b=uLcLvm5GZZbuIT4rvnqDw84FIyXTkf2sOFaZJsEOScc/4w3N81W1PGuiImIz7a9kn
	 +VePRLED+tXcpT1pK3Wq9ltTyA9o0qsW1tCz9pLYHzNoJ9iNk+SXcxRye+VR/AYbNi
	 ApnGnO3BJAEh9YAXLdRefNzZcfvmkZ+upmJ9FJEg=
Subject: FAILED: patch "[PATCH] ata: libata-core: Reject an invalid concurrent positioning" failed to apply to 6.6-stable tree
To: hexlabsecurity@proton.me,cassel@kernel.org,dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:02:13 +0200
Message-ID: <2026072113-preshow-stoppage-40c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 533a0b940f901c15e5cbbd4b5d66e871c209e8ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072113-preshow-stoppage-40c9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 533a0b940f901c15e5cbbd4b5d66e871c209e8ce Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Mon, 22 Jun 2026 22:23:45 -0500
Subject: [PATCH] ata: libata-core: Reject an invalid concurrent positioning
 ranges count

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

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c9a6eade8faf..bdc88cf74709 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2847,6 +2847,24 @@ static void ata_dev_config_cpr(struct ata_device *dev)
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
 	cpr_log = kzalloc_flex(*cpr_log, cpr, nr_cpr);
 	if (!cpr_log)
 		goto out;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d54ec1631e9a..6e0615f2af5d 100644
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
index 0dd735c2e5b5..700627596ce1 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -149,6 +149,15 @@ static inline bool ata_acpi_dev_manage_restart(struct ata_device *dev) { return
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

