Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F753FD42
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953147; cv=none; b=YYdhmqc5cyYLMTyRQmN6RpvkEb7l5ftY2OfNv4Ru2atsiEV+t7CNU4bp0t3Hd7MlYa82odcoojYviR7vLsgRRvkHTFAfh7i2L8VX2GH9SREfay0WazjGxJ9aKyn/QYVLnD8EovOJpGca5PIJWl0ylw5dYFXmgujI45y/qoLbaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953147; c=relaxed/simple;
	bh=0g7kp1GUFdCdtX/eeR6ZSfSJ3wa69PMHNu+OFEEaX7E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h3JtUC3CaluGFobJ1jd10gb09sRlDCBZdRZumCgoKZMg+nqwhZ+QKRkUH3SOpQyirIlcAGLf3W+xhLeVe86QA4+EUg2HDbT9jon+7UoHZwFvTvQCtl9njyzyA1rPa/V/z02pWqXqyUS98Bxo8hbQgxwX99yPzKLrFe1Sg9tvdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WlrLnjy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WlrLnjy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1A91F00A3A;
	Wed,  9 Sep 2026 11:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953146;
	bh=vbM+qN9OWhkhstJyckVIGEosGDFPaiiijVjfJZ94Nn8=;
	h=Subject:To:Cc:From:Date;
	b=WlrLnjy5Z0v1dg6rlD6b5PBb2ouRBtGkXgrh1nudB1ugflSTrovVesAgepD/BLAfC
	 Kw+Ezld+hiT5jZL6Ej0+Y7K9KM//7Vxc3Mfyt6XWc5f+xFrJWyN+yEa+J20NW2qpq5
	 ekZ3TYkFytdyzyVsNUvm0RgkAjP6VeAOolgoJxi8=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring" failed to apply to 5.10-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:17:51 +0200
Message-ID: <2026090951-petri-county-d8f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 626e44f3d8a924a97a3848a9fd45833947e081e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090951-petri-county-d8f7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 626e44f3d8a924a97a3848a9fd45833947e081e9 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:16 +0530
Subject: [PATCH] scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring
 slot

For QLAFX00 the request ring is ioremapped device I/O memory
(ha->iobase + req_que_off), not DMA-coherent RAM, which is why the rest
of the FX00 path accesses it through memcpy_toio() and the wrt_reg_*
helpers. __qla2x00_alloc_iocbs() however zeroed the producer slot with a
plain memset(). On architectures such as ARM64 a regular memset() may
emit unaligned or block-zeroing instructions (e.g. DC ZVA) that are
invalid on Device memory, leading to a synchronous external abort.

Use memset_io() to clear the slot for QLAFX00, matching the I/O
accessors used elsewhere on this ring. Other adapters keep the plain
memset() on their DMA-coherent rings. The zero-fill is retained for FX00
because its IOCB builders (e.g. qlafx00_fxdisc_iocb()) copy only part of
the entry and rely on the unused tail being pre-zeroed.

Fixes: 8ae6d9c7eb10 ("[SCSI] qla2xxx: Enhancements to support ISPFx00.")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-12-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index c4595626c16b..88bae1166a24 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2530,11 +2530,13 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	 */
 	req->cnt -= req_cnt;
 	pkt = qla_req_ring_slot(ha, req);
-	memset(pkt, 0, qla_req_entry_size(ha));
 	if (IS_QLAFX00(ha)) {
+		memset_io((void __iomem __force *)pkt, 0,
+			  qla_req_entry_size(ha));
 		wrt_reg_byte((u8 __force __iomem *)&pkt->entry_count, req_cnt);
 		wrt_reg_dword((__le32 __force __iomem *)&pkt->handle, handle);
 	} else {
+		memset(pkt, 0, qla_req_entry_size(ha));
 		pkt->entry_count = req_cnt;
 		pkt->handle = handle;
 	}

