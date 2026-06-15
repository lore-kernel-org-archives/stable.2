Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988A3FBB6D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533355; cv=none; b=e6xMMJ2wBzT2yVBccreFmaMbVeeM9PND++0575PG5FTv9KAKFl2iIekxelIzQhzQTq9ngJwCpAer35irb5oColgTH+6jEOr0iVSflfazf6OdQggf+ObucpPeIYBumv/AXQHWCjDQsfxMWG2A1aK+Bn9Ag3c/pPN9+tNnQkYcsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533355; c=relaxed/simple;
	bh=k/kGITHorP+VmIG+H1fl6CRVRHw/9Ys9gf4F9EVIVTw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kPiPtoyyGooS4hCJIS7KPqWU/YGLfnG7e6ca9F1gnf9n2mZ/paXxf8otrSkCn3W3SR0CfeCDAFU+u43ZuolJpmcRY2NzgyImygaq9DuwrKH85RlfWrwjbm1e5ADQ1Eji3kYiB2P/2g2hKb/weeUWhKK73Yn4fB6cy8lkCFqKnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DOsApdd9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DOsApdd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF43B1F00A3A;
	Mon, 15 Jun 2026 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533353;
	bh=XkHCZ4yYhxgCo6nhPTaET50SoNQudZaiBhGPlyVdwXU=;
	h=Subject:To:Cc:From:Date;
	b=DOsApdd9kCjBvTQl9xiWX7Ma9Z+zZQj/EEjB22sCTj//i8HNYSAUtKbRtXRwG/12z
	 PBnJM6206EcCbjSXANIm3ljeEjs/FRaU7lNyD4itcNlRVCpHasZxWpZzngGXnoQahE
	 9bZgf/egSvBXjRybrTEkqxwJEIJY5TxBe9E3BAUc=
Subject: FAILED: patch "[PATCH] RDMA/umem: Fix truncation for block sizes >= 4G" failed to apply to 7.0-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:21:03 +0200
Message-ID: <2026061503-brunette-twelve-6cba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 15fe76e23615f502d051ef0768f86babaf08746c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061503-brunette-twelve-6cba@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15fe76e23615f502d051ef0768f86babaf08746c Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Mon, 1 Jun 2026 13:52:31 -0300
Subject: [PATCH] RDMA/umem: Fix truncation for block sizes >= 4G

When the iommu is used the linearization of the mapping can give a single
block that is very large split across multiple SG entries.

When __rdma_block_iter_next() reassembles the split SG entries it is
overflowing the 32 bit stack values and computed the wrong DMA addresses
for blocks after the truncation.

Use the right types to hold DMA addresses.

Link: https://patch.msgid.link/r/1-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: a808273a495c ("RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/core/iter.c b/drivers/infiniband/core/iter.c
index 8e543d100657..3ed351e8fcf6 100644
--- a/drivers/infiniband/core/iter.c
+++ b/drivers/infiniband/core/iter.c
@@ -19,8 +19,8 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
 
 bool __rdma_block_iter_next(struct ib_block_iter *biter)
 {
-	unsigned int block_offset;
-	unsigned int delta;
+	dma_addr_t block_offset;
+	dma_addr_t delta;
 
 	if (!biter->__sg_nents || !biter->__sg)
 		return false;

