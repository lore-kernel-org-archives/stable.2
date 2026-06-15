Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968D3F7A9A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533408; cv=none; b=hhgU1rAMPARr4vFkkPSaLQiVPiMqltht0tzzwOL1tTC2eVM3C3x5YyL6w69I5pJ4ACa3VtLRvDtBwK1oVrdS6/dQ1i7qR5sZKo54cELYKPkMKzVy5iQhb4vx3wHrelAKiHYTRCwBDiaA31FtgjeQdtW5AQrjECrc2SXXOQ/9QkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533408; c=relaxed/simple;
	bh=4CVKUopdGo1oVor+fZU9bTH2P2OfcSGMGATcHxRhtjo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rxH8VcT+IvW7/1ReNm9gCsl6bcyfe1YggTbAXL4qXaLXZb3HIw1JukV7uiE4MYArlldNF8ZAqVqsoPxLpiDeWmb9yG0fFjS/UTzAhCY/b0AntU6Li3q6napO1MtUG/NIWs7j9MYx5S2bF1DBVgzIiN3RN50FQazivDTuDV6nOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vtzqwBgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vtzqwBgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138311F000E9;
	Mon, 15 Jun 2026 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533407;
	bh=VnkIQNNDaYTvPApgQ1V40D+65EKPRzTtHKWqFyPqp60=;
	h=Subject:To:Cc:From:Date;
	b=vtzqwBguHHzFaiFgCUWzLl7jq/9jzIUAS24ddq9ZIv5BFS3/pPhBcRcI4oGGrJgZY
	 UeTIrloOpRCYdkIRm1L5TW7l6VEeBpijWKlB76zH0nfDq4TFm8nH1ZXEQXigLDGpZA
	 IiL6oqAWUainXlf1l/wSRnWrp1E0BPMW/A6kjDGI=
Subject: FAILED: patch "[PATCH] RDMA/umem: Fix truncation for block sizes >= 4G" failed to apply to 5.10-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:21:13 +0200
Message-ID: <2026061513-rimless-afoot-0214@gregkh>
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
git cherry-pick -x 15fe76e23615f502d051ef0768f86babaf08746c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061513-rimless-afoot-0214@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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

