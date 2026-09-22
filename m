Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A0E5616C5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093616; cv=none; b=jPxh5cxH4HkeG9SQvmF7KUqxTPH7nH2zHW7Nkuc52D9kCZ6BG7fYQFNxg44ONotNb+B61KpKvwPxFIdDzdxDYaFbnPPxl30bU5c8UIMvoEjaUXkmj62Vx6wIpICfczjKXfFzKilyjdyndx1SAb0IHo6u3gVYtarEUnqiOhN8faM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093616; c=relaxed/simple;
	bh=E1CK8hjQ9CtRgCjhh+PsJycWkLt262tQo1V6bmvBce4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idawF02rhFGNsHpUN5a5jLYnuKrQY803xiqSj13SSCvkLsxvweDGVFahyIJG5ErH7JoxstiuZjIGa08LOWuESGr0ULl/FpSSbDua8U/En9taziALv3gSd/p2kfy++ojmN6MpLEeHbOhVIArsvNvsRB5p9w+gD8u69WGSwA35QMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4TI4JOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4TI4JOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5791F00893;
	Tue, 22 Sep 2026 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093614;
	bh=Ogk4CiV9yASjCsNFRptxL/HCOfqBGJeiXSet3a+t2H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4TI4JOb8C5nsJga3ZlU3e91ig30FJGYzhZydok6qwWxc38p+ys8s7nIOMfYE0POm
	 FgfUjyQ7LmcrsF75pKXYSnWlGhiVnD+Od09VJ+Uj8xizpiwMcbOKgkdlcQ3TyxnoWC
	 v4c/XdLcaECr06AWt6GVamVqsn2snnwzbssKD4+0gvkuhhUC7qz0s/BDkUbeR73TUk
	 IEzpSRiN3V3jj+h5nlSP9P0xVuFLe1qHWw/B/9y78TAkAawk+6SJ/NmOD9h8fDMdl8
	 v6Grr4epar0FrAi7jlGb77EQyTTSCvhig10EQ2rgZnMy/SnVb9GcC8ugSm452IaCHQ
	 dqs/2rZnleiXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuhei Takeshita <jyohuku.alterego@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] IB/hfi1: Resolve the credit-return buffer through the send context's node
Date: Tue, 22 Sep 2026 12:13:32 -0400
Message-ID: <20260922161332.2979388-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922161332.2979388-1-sashal@kernel.org>
References: <2026092206-enjoyably-shrapnel-5c31@gregkh>
 <20260922161332.2979388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuhei Takeshita <jyohuku.alterego@gmail.com>

[ Upstream commit 975396b9e5a4028e649f4b9a6a5ca5dfb76a824b ]

hfi1_file_mmap()'s PIO_CRED case derives this context's credit-return
page offset, and the DMA handle for it, from dd->cr_base[uctxt->numa_id].
uctxt->numa_id is the node of whichever CPU the process happened to be
running on, but the entry itself lives in the credit-return allocation of
the send context's own node:

	sc->hw_free = &sc->dd->cr_base[sc->node].va[gc].cr[index];

and user send contexts are allocated with sc_alloc(dd, SC_USER, ...,
dd->node), the HFI-local node.  On a multi-socket host with the process
running off that node the two allocations differ, so the subtraction
produces an offset into an unrelated buffer and the DMA handle belongs to
the wrong allocation.

Use the send context's own node for all three references.  The
continuation lines are reindented at the same time; they mixed spaces and
tabs.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Cc: stable@vger.kernel.org
Signed-off-by: Shuhei Takeshita <jyohuku.alterego@gmail.com>
Link: https://patch.msgid.link/20260809032743.2671579-2-jyohuku.alterego@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index a02a90a9606cf..81e3cc7cbd47b 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -384,10 +384,10 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * of enabled contexts > 64 and 128 respectively).
 		 */
 		cr_page_offset = ((u64)uctxt->sc->hw_free -
-			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
-				   PAGE_MASK;
-		memvirt = dd->cr_base[uctxt->numa_id].va + cr_page_offset;
-		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
+				  (u64)dd->cr_base[uctxt->sc->node].va) &
+				 PAGE_MASK;
+		memvirt = dd->cr_base[uctxt->sc->node].va + cr_page_offset;
+		memdma = dd->cr_base[uctxt->sc->node].dma + cr_page_offset;
 		memlen = PAGE_SIZE;
 		flags &= ~VM_MAYWRITE;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
-- 
2.53.0

