Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C44CC27C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953142; cv=none; b=SLYnVnyxphLIWDrUe+K8z8W0ERYsrtYebayIA2QTLezviWfKnbFZmUQQanR4bwRvb8FR8VMOqowQ6/lMr/U8LF0T9eB3A+dnJ2/awwUOFrXwJt+1fpFB31nFJrbLeac/VYCYTVwOvVjBiCxARJZiEFIDx2lipIC/rfb85unAa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953142; c=relaxed/simple;
	bh=3Xi87IvJYS+eE8WrBXWgIkt9JBe6T96AgeMzIWQbMS8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GbIxSZmAJQs4GjQPFfqe/3JY0lnsVjBIkMY18UPJbpOa50vfUa+TMwppsWtuWr0an4xGfs00aXiUeIRsMJUrqbNet/LtJIMuNabLTwstPceXVIJNr1pBOeG/ynpAgeUhEdl8/MA65HG9lS9Q7Nwz4GgLJvUFOD75E9jW+N/nFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wTGcDyL2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wTGcDyL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108431F00A3A;
	Wed,  9 Sep 2026 11:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953140;
	bh=KciEzmL95JGEp5O4IcG5YydJJi38iyE21tte6GTltC8=;
	h=Subject:To:Cc:From:Date;
	b=wTGcDyL2KT5cmeGRDiCEHtHAtfo6R5919jEbfInzS4wTmsLE/5wmRqrzbPTfUCsd/
	 ioiILb4sJPZ7/uCkNcZew38fKfTtoSpillNjUDMOb0isbbKDf9HqOLAqHR8mTcPmoi
	 CdYBfgBaCFMQjjB3m8jxmfX+b4XYvXsYpNx27vWo=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring" failed to apply to 5.15-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:17:50 +0200
Message-ID: <2026090950-irrigate-failing-04d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 626e44f3d8a924a97a3848a9fd45833947e081e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090950-irrigate-failing-04d6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

