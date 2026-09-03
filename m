Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4094AEBE7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444317; cv=none; b=NHgNBIy23SbL4ikZiBwwIURH/wdaWprZK394HBF945EIpIXHQlr2RMIsuyOfdvXGpjzXrd844d+AH1AM4YC4B+6x/sagsWZx++L1+mYuyzSkPczbTjOdGSw0H2xS+x0/t4EVqjnbKwFJoR8UDN2A+4wc+ljvLLQly1mwpFEaDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444317; c=relaxed/simple;
	bh=7yTJcljHaa9FTr5cT1AMKDl5r8oZaRIB1AQDjj0G038=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EkXQNQMyR2D0xPh24e0e5DFoDZc39mSgyAuWN8KWTdn5OXD2QezFU/1DhD9hA2I7F0MGESYAokkhP0GLAoOOKqTim70CH2aMSiecjXiwl1rZWS5uxYGkbTqOCwZhSA6YXD4HmFnIY+NGRnkciIOBhp5h6TjtfPzsqo+gDm06TnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwHUL9FR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwHUL9FR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417771F00AC4;
	Thu,  3 Sep 2026 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444303;
	bh=iMJ/g2obZEnq4b0U0M+P356q89KLtKJvORhk7R5lI8A=;
	h=Subject:To:Cc:From:Date;
	b=IwHUL9FRejRbDDCuPGoOi0oKWvL0T8dWCuoWtK/LvFrw88e2ce47T1MdQeKJDyS8a
	 hXwBUko6s7115Id1H/o/DiJvZD43K9WR7ip4vB2nWqmtXVbp7kuWwSbR8Rlav/r1XU
	 eq+5HNY7Qd+tzJ1TDj8RDmwV91L697QR81U+HUtI=
Subject: FAILED: patch "[PATCH] erofs: skip sufficiently large global buffers when resizing" failed to apply to 6.18-stable tree
To: nikhilgurudasani314@gmail.com,chao@kernel.org,xiang@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:40:45 +0200
Message-ID: <2026090345-used-spearfish-a45c@gregkh>
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
git cherry-pick -x a7d097cf01301c5da37927c8f26123d006f0fd8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090345-used-spearfish-a45c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7d097cf01301c5da37927c8f26123d006f0fd8a Mon Sep 17 00:00:00 2001
From: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Date: Sat, 22 Aug 2026 19:30:17 +0530
Subject: [PATCH] erofs: skip sufficiently large global buffers when resizing

z_erofs_gbuf_nrpages is advanced only after every global buffer has been
grown. If a resize fails after some buffers were enlarged, a retry
revisits those enlarged buffers.

Retrying the same size then returns -ENOMEM because alloc_pages_bulk()
has no pages to add and the unchanged return value is treated as a
failure. Retrying an intermediate size allocates a temporary pointer
array smaller than gbuf->nrpages and copies more existing pointers than
the array can hold.

Skip buffers that already satisfy the request. Once all remaining
buffers have caught up, advancing z_erofs_gbuf_nrpages again describes
the guaranteed minimum size across the pool.

Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index a0ce9226bc02..6b9bfa2ef3b6 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -79,6 +79,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 
 	for (i = 0; i < z_erofs_gbuf_count; ++i) {
 		gbuf = &z_erofs_gbufpool[i];
+		if (gbuf->nrpages >= nrpages)
+			continue;
 		tmp_pages = kzalloc_objs(*tmp_pages, nrpages);
 		if (!tmp_pages)
 			goto out;

