Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491073;
	b=PhgZJ5rD3sQTQd/UxA1PLOVc6cio2ZJkaVTTf0FYehKKz/kcm9M/PGv0ZcPcwvZ1y//2
	 1ngNRxgoMA1oiOWlcAZEEON1RGfOm3pY8LD9Sc1la/0zMIiARb+FqRZc58ZWrLqayfenF
	 pg2dEiqG1FyU6lM3iHyg400b61REm0kxXT88JT0hrVWKoED7zpCRhTwI1nQ3xys1CEMyC
	 /Z4niNHRlAociTeZlCThomYtvs3aarGrAgzcstt9wD0zOiD+apU1qvKSUtTePyEbAA1yf
	 nY+P4KNSnM2DCLetcA23wOpE3jmK6YbiV7ndbiEbtazttaI3zJrHtfd5rZd2ujj3TpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=gQI81K13gbBx0VwTS9k/Q6XgvqjYaKgVoW+Q/ZG/OuQ=;
	b=dBA33Iz1r7fMNhNROsvlE7xVS9iJjXk+Z0twrh5F/pasjpZouC/Ck+UwLK12nlGG2cCl
	 g95aaD/sYuaGU3jCQUvOI275BWZ2cmzXK54giIkmBJT/9Uwl0ZwEJdxsAcw0ICOpvl+89
	 zkeVDU67IfPUFyE24SnjBVhqG+fJfHOzb1OSEIPXfml/2cUOyWfHi6iJN3L9CHk0rQF+A
	 eVx/5n6y0M8Ig55ouQWSdA7KJXs45rW6eineT5f6nRyOy2uddmw9Xq58Pke0+EmFyBdvq
	 Tf5KnHM10/+PsoHTr45xKunzIgkKPv0moFDd3BKbN4CNffh9WQgpx3fmTi5EpV11PEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAj0uvNC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE716606A335;
	Tue, 20 Oct 2026 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAj0uvNC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAE61F000C4;
	Tue, 20 Oct 2026 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491072;
	bh=gQI81K13gbBx0VwTS9k/Q6XgvqjYaKgVoW+Q/ZG/OuQ=;
	h=From:To:Cc:Subject:Date;
	b=IAj0uvNCWUp3u1I5sGvm4nRft6o0TkQNgewrsYtGEhwrWdC52NzXWRQdulRbpGwLf
	 m5o4zJgSTDXORSHUJ1pDTJ95Fk0tEwHpmpKa9JmfgXHgFmui+J5lSBVdDySDtbSzGu
	 5xB2trJa7o8fhCt+KVRyWyF45OB/xN+PYqikcuZ/GECCulWftbicNptDjW2acqMi9Y
	 Y6nr8DPzflM6i7tQ5T7PLlfyxExKtHl1827MBOaCsVGRRjpVJi1aDApVREaBTBHqwE
	 HeO19z7/yVdGcTQjeEvcZ6mUOoqkJScjqdw/CAd2Ls8pNq7PnBJhfNBNLyWRW2ByfW
	 wKpYIBn/WRc2g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Richard Weinberger <richard@nod.at>
Cc: sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-sff: fix race between IRQ deferral and ata_sff_flush_pio_task()
Date: Tue, 20 Oct 2026 12:11:08 +0200
Message-ID: <20261020101107.1449635-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6186; i=cassel@kernel.org; h=from:subject; bh=PFypG3XVw/56gkmY/NL2LAsiupVlF/mxzKvjrFxTA74=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKu29k05M+V6jN/czey19J+tuL1dW/zdm1t1wv7JNh29 vzptJRzHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIbCcjw1eRlb+Pfr+26n7A upmPLm3ceOXZc/nWBKaL4c/CHtoq3GBl+B953Nvdf/O1f1qT5k3Wv8M+be6/kJBu0QKGrd7H7Yq OP+MAAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 4a2e5409472e ("ata: libata-sff: don't busy-wait for PIO data-in
command completion") allowed the interrupt handler to queue
ap->sff_pio_task from ata_sff_hsm_move() when a PIO data-in command is
still busy after its final data block.

ata_sff_flush_pio_task(), however, was written under the assumption that
cancel_delayed_work_sync() is enough to prevent sff_pio_task from being
queued again before the HSM state is reset to HSM_ST_IDLE and
sff_pio_task_link is cleared.

The flush runs early during error handling, at a point where the timed
out command is still active, the port is not frozen yet, and interrupts
are still being serviced.  If the final data-block interrupt of a PIO
data-in command is serviced in the window between
cancel_delayed_work_sync() and the reset of hsm_task_state, the
interrupt handler queues sff_pio_task after the cancel has completed.
When that work item then executes on ata_sff_wq after the flush cleared
ap->sff_pio_task_link, ata_sff_pio_task() hits
BUG_ON(ap->sff_pio_task_link == NULL) while holding the host lock with
interrupts disabled; alternatively it proceeds on a stale link while
error handling owns the port.

Fix this by resetting hsm_task_state to HSM_ST_IDLE before cancelling
the work item.  Once the state is IDLE, __ata_sff_port_intr() can no
longer enter ata_sff_hsm_move(), so the interrupt handler can no longer
queue the pio task, and cancel_delayed_work_sync() drains whatever was
queued before the reset.

Also make ata_sff_pio_task() bail out quietly when the HSM state was
marked idle by the flush, both at entry and after re-acquiring the port
lock following ata_msleep(), since a work item can already be running
when the flush resets the state.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-ide/sashiko-outbox-177477@kernel.org/
Fixes: 4a2e5409472e ("ata: libata-sff: don't busy-wait for PIO data-in command completion")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
The bug was reproduced on QEMU (piix3 IDE disk driven by ata_piix,
i.e. the real SFF/BMDMA interrupt-driven PIO path) with a
fault-injection patch that:

 - forced all rw commands to ATA_PROT_PIO (the emulated disk
   otherwise uses UDMA),
 - added mdelay(200) per interrupt in __ata_sff_port_intr(), so a
   multi-sector read stays in flight for seconds - long enough for
   the 3 s SCSI timeout to fire mid-transfer,
 - forced the new HSM_ST_LAST deferral branch to always queue
   sff_pio_task from IRQ context (emulated devices clear BSY/DRQ
   too fast to hit the ~100 us busy-wait), with a 150 ms delay so
   the work runs after the flush has cleared sff_pio_task_link,
 - made ata_sff_flush_pio_task() wait for the IRQ to requeue the
   work inside the cancel_delayed_work_sync() -> sff_pio_task_link
   = NULL window.

Trigger: echo 3 > /sys/block/sda/device/timeout;
dd if=/dev/sda bs=16k iflag=direct. On the third EH cycle the
deferred queue landed in the window, producing "kernel BUG at
drivers/ata/libata-sff.c" in ata_sff_pio_task()
(BUG_ON(ap->sff_pio_task_link == NULL)), the kworker exiting with
IRQs disabled and host->lock held, followed 60 s later by an RCU
stall with scsi_eh_0 spinning forever in ata_eh_thaw_port().

With the fix applied under identical instrumentation, the same
trigger produced five timeout -> soft-reset -> speed-downgrade ->
EH complete cycles with no BUG and no lockup; the read failed
cleanly with an I/O error.

 drivers/ata/libata-sff.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 976e4e160494..73767d4a85dd 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1196,8 +1196,6 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 {
 	trace_ata_sff_flush_pio_task(ap);
 
-	cancel_delayed_work_sync(&ap->sff_pio_task);
-
 	/*
 	 * We wanna reset the HSM state to IDLE.  If we do so without
 	 * grabbing the port lock, critical sections protected by it which
@@ -1205,11 +1203,26 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 	 * example, we may set IDLE in between the time
 	 * __ata_sff_port_intr() checks for HSM_ST_IDLE and before it calls
 	 * ata_sff_hsm_move() causing ata_sff_hsm_move() to BUG().
+	 *
+	 * Reset the state before cancelling the work item: once the state
+	 * is IDLE, __ata_sff_port_intr() can no longer enter
+	 * ata_sff_hsm_move(), which prevents the interrupt handler from
+	 * queueing sff_pio_task when deferring the completion of a PIO
+	 * data-in command.  The SCSI error handler cannot dispatch new
+	 * commands while error handling is in progress, so issue-time
+	 * queuing is not possible either.
 	 */
 	spin_lock_irq(ap->lock);
 	ap->hsm_task_state = HSM_ST_IDLE;
 	spin_unlock_irq(ap->lock);
 
+	/*
+	 * Now that the interrupt handler can no longer queue the pio task,
+	 * cancel it.  This also drains a work item that the interrupt
+	 * handler managed to queue before the HSM state was reset.
+	 */
+	cancel_delayed_work_sync(&ap->sff_pio_task);
+
 	ap->sff_pio_task_link = NULL;
 }
 
@@ -1233,7 +1246,13 @@ static void ata_sff_pio_task(struct work_struct *work)
 	}
 
 fsm_start:
-	WARN_ON_ONCE(ap->hsm_task_state == HSM_ST_IDLE);
+	/*
+	 * ata_sff_flush_pio_task() may have marked the HSM idle after this
+	 * work item was queued or while it was running.  There is nothing
+	 * left to do.
+	 */
+	if (ap->hsm_task_state == HSM_ST_IDLE)
+		goto out_unlock;
 
 	wait_mask = ATA_BUSY;
 	if (ap->hsm_task_state == HSM_ST_LAST)
@@ -1252,6 +1271,13 @@ static void ata_sff_pio_task(struct work_struct *work)
 		ata_msleep(ap, 2);
 		spin_lock_irq(ap->lock);
 
+		/*
+		 * ata_sff_flush_pio_task() may have marked the HSM idle
+		 * while the port lock was dropped for ata_msleep().
+		 */
+		if (ap->hsm_task_state == HSM_ST_IDLE)
+			goto out_unlock;
+
 		status = ata_sff_busy_wait(ap, wait_mask, 10);
 		if (status & wait_mask) {
 			ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
-- 
2.56.0

