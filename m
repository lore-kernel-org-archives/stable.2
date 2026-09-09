Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871F538D85
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953227; cv=none; b=bQpUwfLsuA6dK3Rj/gUZhh4dchlrwiiAs2uHFDSpv9isv1N2Iu8cgGgl5p4p0ApNhkSpCtP2SXIk5FceA93m8JYxYMkkl6cUlNwjlTZ9OgCzXytDwtH2HJ7+T8xQyfx3z4vkZc326vSvV4YrDTr2nn4eYvPVNrXyiHhBApILM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953227; c=relaxed/simple;
	bh=xJPoq/nIZyh4G6vPWOWAh5I52pO8OlyGGhwkj19WVOI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nu3hnR8AnAAXj5ZTao9P2bnriKk46DjqVVmDAeDxij1eSOdzy/u9Dz/EBeoLDtWDhHlzLmUsqjuBGZbxFxnWcM1DQt5S8jwW/3vw9qr0V1ii2Ux1ShZEget1jMaSlwRyZqa9HymmlsCY7WxyQGtDVzHLFN7qjK0vePzC1vMKhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WC/98icC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WC/98icC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB011F00A3A;
	Wed,  9 Sep 2026 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953225;
	bh=+xrBZOcEkRxetqyG6svt07yfqW55bOJG2MneIFpunYk=;
	h=Subject:To:Cc:From:Date;
	b=WC/98icC3NU530HbefxMNMzMD+2d7wMeY5NaWZbH7aiKKwmXQ/1rp1EYF8dv1ePhg
	 5FyAwxiH5qZzop2cVI9AwDSuUQYramgEU89GO/nO0pjVHDau9E2tiPm/DwVMDPZrGP
	 jyuMp35hzCagur4kmnJZkhGghKmEeUf+Br8YpK00=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix soft lockup polling continuation IOCB" failed to apply to 6.1-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:19:57 +0200
Message-ID: <2026090957-skillet-scroll-dca0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d7e3fa7d06bf7fcaac186d3c4d635caac166d36c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090957-skillet-scroll-dca0@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7e3fa7d06bf7fcaac186d3c4d635caac166d36c Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:19 +0530
Subject: [PATCH] scsi: qla2xxx: Fix soft lockup polling continuation IOCB
 signature

qla27xx_copy_multiple_pkt() and qla27xx_copy_fpin_pkt() poll
rsp_q->ring_ptr->signature for RESPONSE_PROCESSED (0xDEADDEAD) to decide
whether the next continuation IOCB has arrived, spinning on cpu_relax()
without advancing the ring or decrementing the entry count while it has
not. response_t::signature lives at byte offset 60, but a continuation
IOCB (sts_cont_entry_t / struct sts_cont_entry_ext) carries raw FC frame
payload at that offset (data[56..59]). A received frame whose payload
bytes happen to equal 0xDEADDEAD is therefore misread as "not yet
arrived", and the loop spins forever in interrupt/DPC context, causing a
CPU soft lockup.

The poll is also unnecessary: callers of qla27xx_copy_multiple_pkt()
(PT_LS4_UNSOL and the NVMe purls path) already gate on
qla_chk_cont_iocb_avail(), which guarantees all entry_count IOCBs are
present before copying begins. The sibling helper
__qla_copy_purex_to_buffer() already drops the signature poll and relies
on the entry_type == STATUS_CONT_TYPE guard instead.

Remove the signature busy-wait from both helpers, keeping the entry_type
guard, and gate the FPIN path with qla_chk_cont_iocb_avail() so it defers
and re-processes on the next interrupt once all continuation IOCBs have
arrived, mirroring the ELS_AUTH_ELS and PT_LS4_UNSOL arms. With this the
signature field is never read on a continuation IOCB, eliminating the
payload-aliasing lockup.

Fixes: 9f2475fe7406 ("scsi: qla2xxx: SAN congestion management implementation")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-15-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 6375c18fe392..d9019f2b059c 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1002,14 +1002,6 @@ qla27xx_copy_multiple_pkt(struct scsi_qla_host *vha, void **pkt,
 
 	do {
 		while ((total_bytes > 0) && (entry_count_remaining > 0)) {
-			if (rsp_q->ring_ptr->signature == RESPONSE_PROCESSED) {
-				ql_dbg(ql_dbg_async, vha, 0x5084,
-				       "Ran out of IOCBs, partial data 0x%x\n",
-				       buffer_copy_offset);
-				cpu_relax();
-				continue;
-			}
-
 			*pkt = rsp_q->ring_ptr;
 			data = ((sts_cont_entry_t *)*pkt)->data;
 			data_sz = qla_sts_cont_data_size(ha);
@@ -1299,14 +1291,6 @@ qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha, void **pkt,
 
 	do {
 		while ((total_bytes > 0) && (entry_count_remaining > 0)) {
-			if (rsp_q->ring_ptr->signature == RESPONSE_PROCESSED) {
-				ql_dbg(ql_dbg_async, vha, 0x5084,
-				       "Ran out of IOCBs, partial data 0x%x\n",
-				       buffer_copy_offset);
-				cpu_relax();
-				continue;
-			}
-
 			*pkt = rsp_q->ring_ptr;
 			data = ((sts_cont_entry_t *)*pkt)->data;
 			data_sz = qla_sts_cont_data_size(ha);
@@ -4272,9 +4256,24 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 					       "SCM not active for this port\n");
 					break;
 				}
+				if (qla_chk_cont_iocb_avail(vha, rsp,
+				    (response_t *)pkt, rsp_in)) {
+					/*
+					 * ring_ptr and ring_index were
+					 * pre-incremented above. Reset them
+					 * back to current. Wait for next
+					 * interrupt with all IOCBs to arrive
+					 * and re-process.
+					 */
+					qla_rsp_ring_rewind_to(rsp,
+					    (response_t *)pkt, cur_ring_index);
+
+					ql_dbg(ql_dbg_init, vha, 0x5095,
+					    "Defer processing FPIN...\n");
+					return;
+				}
 				pure_item = qla27xx_copy_fpin_pkt(vha,
 							  (void **)&pkt, &rsp);
-				__update_rsp_in(is_shadow_hba, rsp, rsp_in);
 				if (!pure_item)
 					break;
 				qla24xx_queue_purex_item(vha, pure_item,

