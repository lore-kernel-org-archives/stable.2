Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E7551993
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874274; cv=none; b=i4/c/eX3SLvHNMqdgdg2bQzx/CYChI3+IqZb1jP9NTBBNFdTWu2N9hLpnOGs+ucW+QuGY5c66O7ef5k6L+tzOCcDecEQ9vqTrInzMlXvaTsc9UZWRH4cH/0AD28kOx9/ZH2G4gRoO4LRdtdAHz4CV6ubrDg495FmKZUeM7aiVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874274; c=relaxed/simple;
	bh=C74x/Bgvm8E/lWo2eq6/3iLYhc+S/dcR77MOFPLbhF8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q4qxAkfH/toCrzzNfrLSbet70jAHbyz70cznHRiIegwm4PHHdP6iFmJA2etdLIUCFxU5c/Q6i8klzqbrgTyNcSj+FL50WPZYfEgGOmvPpaEKAop29fcg6+sOjJyJJMR0+qTVRXb6L4rM5fBRw3MxEt01/S68S4F59pKc411r/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijHe8TuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijHe8TuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06DB1F00A3A;
	Tue,  8 Sep 2026 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874249;
	bh=MavO3bqNnfs87XDzkLH6RYQfx1IrC8ZK5N70w7hD4jA=;
	h=Subject:To:Cc:From:Date;
	b=ijHe8TuQiOgp79jHis6opq8teWc39GiObEgrrt+/jF9NEceBEhZdFkBqZSHHCsmFx
	 ulvPxNCr0VdlEqWz+SgRAZLsYzoTWRgXTCHE0bUY3Nhc3aTSGqkZs6VQ5ZzE0yVkFR
	 wCNPuwGPvZIi+yEOgds9erCqky5Awuy+L0Tgyv8g=
Subject: FAILED: patch "[PATCH] dma-direct: return struct page from" failed to apply to 5.10-stable tree
To: aneesh.kumar@kernel.org,jgg@nvidia.com,m.szyprowski@samsung.com,mhklinux@outlook.com,smostafa@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:21:12 +0200
Message-ID: <2026090812-sway-tubular-8b4a@gregkh>
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
git cherry-pick -x 94a04ad732c9f8b9554270fc4038a06737de5c22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090812-sway-tubular-8b4a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94a04ad732c9f8b9554270fc4038a06737de5c22 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Date: Fri, 17 Jul 2026 23:34:19 +0530
Subject: [PATCH] dma-direct: return struct page from
 dma_direct_alloc_from_pool()

Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
helper") changed dma_direct_alloc_from_pool() to return the CPU address
from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
dma_direct_alloc_pages() also uses the helper and expects a struct page *.

Fix this by making dma_direct_alloc_from_pool() return the struct page *
again, and pass the CPU address back through an out-parameter for the
dma_direct_alloc() caller.

Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
Cc: stable@vger.kernel.org
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Link: https://lore.kernel.org/r/20260717180442.110954-2-aneesh.kumar@kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4391b797d4db..b4cb2c03e5d7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -164,22 +164,21 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
 
-static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
 {
 	struct page *page;
 	u64 phys_limit;
-	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
-	return ret;
+	return page;
 }
 
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
@@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * the atomic pools instead if we aren't allowed block.
 	 */
 	if ((remap || force_dma_unencrypted(dev)) &&
-	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+	    dma_direct_use_pool(dev, gfp)) {
+		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  &ret, gfp);
+		return page ? ret : NULL;
+	}
 
 	/* we always manually zero the memory once we are done */
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
@@ -357,7 +359,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)

