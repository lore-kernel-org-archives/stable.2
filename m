Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1865293EF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953133; cv=none; b=TW8KOAZEoIO4713fpOXg08AEVnw9X7iIcKym1bKE7dkgC4RxVzcQYNBRO0virYvTFxi61bFPJi8TzLCzlx41oHJU7JqP0Ojn4vngQ/BF7jCChr6vAb0buKTwVoPIGhHHiiiRBVZPKcUK7G7zhFyP5U4f3kOe7usmQO7cy3ZVL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953133; c=relaxed/simple;
	bh=d1ee2X8XZ9UrPBgIk0PKSALSiXILDADdBoz0cPH3r54=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vFYFuJizNx+/b10Wz6DdPeDsaBeXxj6DM4HaALw5fSaiJ5s3pPE2C19rr0V7L+jEcgjK/YqVOJa7CLRW99kzc2rRHfCwWpodI4jDtQUGvjPVtwxKjdskDef1W6AgH17XsG/jJ2Hd10PdnMPxRcrSYrlqie2tRRtrA216GLYfcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pOdRNhNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pOdRNhNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835601F00A3A;
	Wed,  9 Sep 2026 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953132;
	bh=22+lGTuBv1qu5ZBIdhsipCS0plQfkWBO9dg2gQ7tyLc=;
	h=Subject:To:Cc:From:Date;
	b=pOdRNhNr+xAiHVVwgrCF5c/jCV+WhlBf38SsyJCjfr/m1Z20DpKPA/HHaYYfMobCm
	 mUCmfigohKIxI2OotaB6bWiybYiJb+In9jrkFAEiR9wYb4O1uFssND0rU73q1Fjz1v
	 OkgC2v8rVG5i9rolj2z425Gp0mQjoUOCij2phR8w=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring" failed to apply to 6.12-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:17:49 +0200
Message-ID: <2026090949-stoppage-crummy-3ad1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 626e44f3d8a924a97a3848a9fd45833947e081e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090949-stoppage-crummy-3ad1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

