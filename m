Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A35581FD
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093430; cv=none; b=rQkzAVMstO9EEjBNBThFWhkCXGHqKhB7fkQ7yo1f2HQvJeZAzwOW62MDWGwBwvRXVDELpp8/emQNV1GwjM5ybmHvRClQvy6DsadKaEohqaE63+fN6egefHjPEgWMoqPJm+eepq7LtMIuL1UzYVM3jbNczJ2HgOFcpN+QBua7h6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093430; c=relaxed/simple;
	bh=hN98+oZSGEtQWYA/VOlIuZIb7suaEjhFYi2cp+t1sr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adfb9toxKs6A9O3UbIxpEMtXo9/T5rBw2X8DlfdDzqz+uE/nLogYmOx9wF9JCkEeUhMiQ18utM3kLYY9a68IJLyorDhC7dI8+eTb/AftWwE/DjkX+DnYB3TstwWFjStRKEAN86VcQJCceXcgxFWqmKPDHN+wCKvOlQ93Q9CkCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQHUACfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQHUACfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAB01F000FF;
	Tue, 22 Sep 2026 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093429;
	bh=86UudS0gLmjNEJLCYZsHgF0OuqEWowAYzKTqsPnA1ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQHUACfri9hmP/cryd2S1Dw3qXkn4kg8B7Lb6FuBOphvmEzTHdIh0wSTi1BMgapVa
	 2bDsIZ7omTNvdJk8XlyeNJbTUIJGzbQrsov2g60XOCuvzPKMKnZm0b5xurStx8e717
	 HQKOQnrsxB+vim6mgjbcrP4Ha3R1MIS1KERPMJUsbOJZYZG3n/TM2pTJSbM8jlAENt
	 Ywsxl9/BcRZhvz0K/U23Sw7NqaKhO4V0PQUSaPGjzTdtIc/FV9GieDA3HPJQTPwOwu
	 2xibTB38/Ub5RobFOnCHulXcfi+kSVUD3Y+iFIdIzBoQ3keMxsiPngSzna4PhCmLd+
	 lJIirMixPgZ5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuhei Takeshita <jyohuku.alterego@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] IB/hfi1: Resolve the credit-return buffer through the send context's node
Date: Tue, 22 Sep 2026 12:10:26 -0400
Message-ID: <20260922161026.2969429-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922161026.2969429-1-sashal@kernel.org>
References: <2026092205-wobble-lusty-9a31@gregkh>
 <20260922161026.2969429-1-sashal@kernel.org>
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
index e03b0207856e7..1bc59d71c1d0b 100644
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

