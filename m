Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E19566C4E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094019; cv=none; b=jhcDkEGizUJPhOsvIqlfGWJrDwE9F3LP/bFKBtAQ09i1mbXV6bkDpueGN1jC0Rfw71fpItSAX83op2GWM0nqfT61d5FtDF+QgR8fnV3C7Keqoif2i0J8+g+aEMOD/unmHxxx3+O6je0TdL01G8Gjk0+va6MnecGj8iay+HDBFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094019; c=relaxed/simple;
	bh=gX6B/1xHS5VyyfHXVfZhgozeS7ergQo+Ay+JkwaFffY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW3cSiTPUM3lIVkeFZ9zU1+OshAxR6YuD40OaiubN67OcSCsue8wlFXrPiWBKC02J1nYsa5Ha1UeDFg0jJkQeq6bZ1e0mOiyUINgugDHMZOuABHirkfbDS/FyCpLuKf5FR9zZCCTBYwUUfkBGQin6kNaHnat9xxQL2TG3TJMx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvQkvVFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvQkvVFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DA01F0089A;
	Tue, 22 Sep 2026 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790094017;
	bh=LseOoqMxol0ih6YWbXsDxlbP3IOV64LYPBmSqVxfLw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvQkvVFN/qDsyrquqEsqh4T/SR3pwORKiiKHge5OnvJkgYBYn1NQvLeC/gSvOnLo0
	 cDcr8tK3KvdA/+opx29CFoj76pCjvFrMCq2hjzqi/SsfFZmKV+/9HD8KXMZcnmj93P
	 n8CTVRK+ZjQY81w0jF5gWradL1U1Uk7J3PcmrozN+Ci1QrZ25He11u1FqjJkMQ3CXM
	 nPmfeNdjhPRehqME6YWOlJ7BNiDu1/46zOQ00pxew9XxEi0beIkUQ9oq0hpsaHn02t
	 w9adQqhb+fq1lG0psWkJF2TMrYtUf5kk1ZXe1RLOapio5pRu5BBBnoY7LHiu75QEOu
	 0362PSqWOP/mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuhei Takeshita <jyohuku.alterego@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] IB/hfi1: Resolve the credit-return buffer through the send context's node
Date: Tue, 22 Sep 2026 12:20:15 -0400
Message-ID: <20260922162015.3008344-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922162015.3008344-1-sashal@kernel.org>
References: <2026092207-spotless-rambling-6fce@gregkh>
 <20260922162015.3008344-1-sashal@kernel.org>
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
index 322060f7d289a..4a0745cb26827 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -425,10 +425,10 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
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

