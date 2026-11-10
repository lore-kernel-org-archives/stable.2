Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323547;
	b=mpRNifvKypdRmq8fwGxHZLkLqpRMKBSjUj1qWbjUM7T327r6JZfyQ3RaQFDZpnd646gU
	 pjXqAQPzN6MpMmmLHjUUqQhCK0gSuldSnPeI/dHymwD19zwirIAWutBkNm3GAuE+R7l/2
	 nMXui/otlrxAEs4fNtTcPlvFOZyY/a+6g41avG6+bQCwRGD9KEOPPW5kuCIavVjuX8Q4K
	 ZfOVRdcrUkPW/xWo98WO8NFJeRH582zgFti4KQ5g+b0lpysFWPLwUdi/xfT4Bkv7CCQqx
	 qg6PNHoeqyNttqNe+cru4vRjttqLtg86ytmdHgCQ9InYy39Vn6P//KGsSPceO+LUKdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iQ2aUXSby8Wx9VrBCKYp9Q7wKkk9UqTuqKlH2VfRgVY=;
	b=TMutwEp1WQolQeRKhA6n2qwztPICKeuYP8a2uiDsJbhmsWeW1VWUHenjNmadnAb0fO4T
	 7421rZgfmQmmF3dLIQyUKnqkScH8FG9SV0rffi4Z3Wfij6TiMu7lmD3WwHxW7yq4zHrg/
	 TtH4oCDyQD+NXYwM0v9jDQp7yo7c1i7Q5CcjAvcgKTfM47W3w1904YY238lDU9WATbNsF
	 uJkwW8UMqO/+il2xRMjpif7V6Q5F+ihKsJ0W6qVNCJqi3BEMu4rMt3fwYHiZT8JgfJfZI
	 MbymDpkBP5iPP4Gj/29oXVisPHNcbYfJFS26PHN1uv8PH7KHT0VAs6vuWsJrQEJB/yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fevqteTB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795E60A261C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fevqteTB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAF71F008A2;
	Tue, 10 Nov 2026 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323546;
	bh=iQ2aUXSby8Wx9VrBCKYp9Q7wKkk9UqTuqKlH2VfRgVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fevqteTBn8wegwf70yCyiDHVKIeLztHLVnfsJ84qUAVXZOLy5HpCa9zLzLWHxfbV/
	 T94/MknmQLCFSDBWlv4K5GM+UGmrj+LfVchhRDoTQLPeT4aU8DIWPEbhVdyk8fhGwd
	 OMjF/5SPwpIaqiXUkftr1ybI9APox1sR3hKR9yF0P8ahPROKVGT6N3NKzJ3JQ5HCjW
	 bQLNxEBYOnQeTwfGVlGn0KgHzqTrj/80us/gS8RV+8zHEFGXYzKnkshzpscORE0hjX
	 G42INLjFomJl9YADRHOJeXTPL+8KjL4QYFRtY1JDUw/i0Wn3L/I9HXS1s0Nt/D+BzN
	 i1AP0V+TNKbKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] ata: libata-eh: Remove ata_do_eh()
Date: Tue, 10 Nov 2026 10:12:20 -0500
Message-ID: <20261110150946.1943054-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110150946.1943054-1-sashal@kernel.org>
References: <20261107051701-failed-6.12-96fdeb7e3fd8@kernel.org>
 <20261110150946.1943054-1-sashal@kernel.org>
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

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit df6f9a918ea856fc288b9001b0414c5be136d7d0 ]

The only reason for ata_do_eh() to exist is that the two caller sites,
ata_std_error_handler() and ata_sff_error_handler() may pass it a
NULL hardreset operation so that the built-in (generic) hardreset
operation for a driver is ignored if the adapter SCR access is not
available.

However, ata_std_error_handler() and ata_sff_error_handler()
modifications of the hardreset port operation can easily be combined as
they are mutually exclusive. That is, a driver using sata_std_hardreset()
as its hardreset operation cannot use sata_sff_hardreset() and
vice-versa.

With this observation, ata_do_eh() can be removed and its code moved to
ata_std_error_handler(). The condition used to ignore the built-in
hardreset port operation is modified to be the one that was used in
ata_sff_error_handler(). This requires defining a stub for the function
sata_sff_hardreset() to avoid compilation errors when CONFIG_ATA_SFF is
not enabled. Furthermore, instead of modifying the local hardreset
operation definition, set the ATA_LFLAG_NO_HRST link flag to prevent
the use of built-in hardreset methods for ports without a valid scr_read
function. This flag is checked in ata_eh_reset() and if set, the
hardreset method is ignored.

This change simplifies ata_sff_error_handler() as this function now only
needs to call ata_std_error_handler().

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20250716020315.235457-2-dlemoal@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Stable-dep-of: 96fdeb7e3fd8 ("ata: sata_inic162x: remove dangerous broken driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c  | 48 ++++++++++++----------------------------
 drivers/ata/libata-sff.c | 10 +--------
 include/linux/libata.h   |  9 +++++---
 3 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1cf737f17d0a3..a7525c8e97bf3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4040,59 +4040,39 @@ void ata_eh_finish(struct ata_port *ap)
 }
 
 /**
- *	ata_do_eh - do standard error handling
+ *	ata_std_error_handler - standard error handler
  *	@ap: host port to handle error for
  *
- *	@prereset: prereset method (can be NULL)
- *	@softreset: softreset method (can be NULL)
- *	@hardreset: hardreset method (can be NULL)
- *	@postreset: postreset method (can be NULL)
- *
  *	Perform standard error handling sequence.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-	       ata_postreset_fn_t postreset)
+void ata_std_error_handler(struct ata_port *ap)
 {
-	struct ata_device *dev;
+	struct ata_port_operations *ops = ap->ops;
+	struct ata_link *link = &ap->link;
 	int rc;
 
+	/* Ignore built-in hardresets if SCR access is not available */
+	if ((ops->hardreset == sata_std_hardreset ||
+	     ops->hardreset == sata_sff_hardreset) && !sata_scr_valid(link))
+		link->flags |= ATA_LFLAG_NO_HRST;
+
 	ata_eh_autopsy(ap);
 	ata_eh_report(ap);
 
-	rc = ata_eh_recover(ap, prereset, softreset, hardreset, postreset,
-			    NULL);
+	rc = ata_eh_recover(ap, ops->prereset, ops->softreset,
+			    ops->hardreset, ops->postreset, NULL);
 	if (rc) {
-		ata_for_each_dev(dev, &ap->link, ALL)
+		struct ata_device *dev;
+
+		ata_for_each_dev(dev, link, ALL)
 			ata_dev_disable(dev);
 	}
 
 	ata_eh_finish(ap);
 }
-
-/**
- *	ata_std_error_handler - standard error handler
- *	@ap: host port to handle error for
- *
- *	Standard error handler
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- */
-void ata_std_error_handler(struct ata_port *ap)
-{
-	struct ata_port_operations *ops = ap->ops;
-	ata_reset_fn_t hardreset = ops->hardreset;
-
-	/* ignore built-in hardreset if SCR access is not available */
-	if (hardreset == sata_std_hardreset && !sata_scr_valid(&ap->link))
-		hardreset = NULL;
-
-	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
-}
 EXPORT_SYMBOL_GPL(ata_std_error_handler);
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 83cb44ca5a97e..13aec8ce4458f 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2054,8 +2054,6 @@ EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
  */
 void ata_sff_error_handler(struct ata_port *ap)
 {
-	ata_reset_fn_t softreset = ap->ops->softreset;
-	ata_reset_fn_t hardreset = ap->ops->hardreset;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
@@ -2077,13 +2075,7 @@ void ata_sff_error_handler(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	/* ignore built-in hardresets if SCR access is not available */
-	if ((hardreset == sata_std_hardreset ||
-	     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
-		hardreset = NULL;
-
-	ata_do_eh(ap, ap->ops->prereset, softreset, hardreset,
-		  ap->ops->postreset);
+	ata_std_error_handler(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_error_handler);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e5e098279803b..511dad024708a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1418,9 +1418,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
-extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-		      ata_postreset_fn_t postreset);
 extern void ata_std_error_handler(struct ata_port *ap);
 extern void ata_std_sched_eh(struct ata_port *ap);
 extern void ata_std_end_eh(struct ata_port *ap);
@@ -2153,6 +2150,12 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
 
 	return status;
 }
+#else /* CONFIG_ATA_SFF */
+static inline int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
+				     unsigned long deadline)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_ATA_SFF */
 
 #endif /* __LINUX_LIBATA_H__ */
-- 
2.53.0

