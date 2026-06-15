Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71143F6C3B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533362; cv=none; b=ahWCC/pTHiAePOuLF0rFN7fcdeVWp6NEvt3B3XnETSGmeZCarBLRsVlJIZ+Iq1dRlu3jem2Z/WIznTVpSX570rQZJSiKMmHx9KAGuajv8lSPdUVA1MF7sV5Hbmypbw2XXFeuNIdSjQU4uNifcEfcuRbo6eeKr2CtO8pAeHWb0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533362; c=relaxed/simple;
	bh=PH2yrqfopxzF9FEROLLc3k0ibQXO09kqahqaVzXETEU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GQIJlc8pFlRAH16OJZWsEeo0tQNFlxcT0hIvK6emaXf5tUBcfmDGWXwqgNgrpc6ev41LYV+GT0QF03V+GihtTdKZSWMYdLTpIkI5zEsNUUWBFmoeOs69ccXyY9AyYKuPD6vkMuFE3eyLg+47/DZfrJYF0AHzWYmlp7OhVw8Z6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JHvqntyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JHvqntyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515071F000E9;
	Mon, 15 Jun 2026 14:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533361;
	bh=PKWSdmF6W8Z/zD7Xpm49dxJdSwGZgnoM4i3bZoQzXd4=;
	h=Subject:To:Cc:From:Date;
	b=JHvqntyxodYyGnjoLfB2Co8Qvl6Ecx5TVyhH6X0ZdmID2KbLxUtbXDrKZlOxiHDMI
	 XjMXJgmp5+VDsu9F8DV5N8VuvlSeNE+HVVFDKjz9foU9gTN8yeYvCg54R2XZTOJ0aj
	 bxyfdTZWrhqe6UdkNeOzOBJ9WAgVrEscvOxl/GI8=
Subject: FAILED: patch "[PATCH] RDMA/umem: Fix truncation for block sizes >= 4G" failed to apply to 6.18-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:21:05 +0200
Message-ID: <2026061505-frayed-clergyman-65f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 15fe76e23615f502d051ef0768f86babaf08746c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061505-frayed-clergyman-65f9@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

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

