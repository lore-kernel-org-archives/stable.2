Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B346AEFA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331750; cv=none; b=McoUdMssC6uviO7cpE0HY8LWoi7ymHOXy61n/MmeRgx0YJHZoZVr/0OyXGuMT5zBmFLDdXpiIFBdYmQ9VrOJjmDQsR6JVlrrIJk0HuTCSUEiMVxad53blXEPUoeRChDLwz47d0NSEWtlA6mrdcJHSHYvZtHA1dqCeNTWycH6Cf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331750; c=relaxed/simple;
	bh=mF1M3ti5k6lcArkonIIIZCBuA28XMvwE9Ch9mApQsPI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=guHw28GQHPCkNXNGciYKO6uFe7XmKBkKAhyDXd3DeMVE4O85O8IEikPih/zjhng6+NSE2PgSR7M8cbDesSFY84nCj2JSLcB3/MvEh15U21/3iG6W1ot48H39DRMV9H71IAwitWTiY/R47xJ/JXGSK2GoPVRBpFOgqlJQCdcyDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gRlpjH1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gRlpjH1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AA31F000E9;
	Wed, 29 Jul 2026 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331748;
	bh=nIuLpgiIzwrcXAqq1vCyk/Dug9zEyEk3OtHkHepqx5I=;
	h=Subject:To:Cc:From:Date;
	b=gRlpjH1s29pnDezpfIZyxr/vp7w59e3EbkvC/8BK85NVw2c5zlmS+wKan3KwAqg02
	 IJkmEOCyDbOKokOim+q8nEgQsPFH3znPkd+6pPkwVg6ZAQEXbZTXxd5/sr8UN77i1x
	 LlhC0/IEpA/TU1DAKCaIAFRqOdUgSzozSZkZ+rr4=
Subject: FAILED: patch "[PATCH] firmware: stratix10-svc: fix memory leaks and list corruption" failed to apply to 5.15-stable tree
To: tze.yee.ng@altera.com,dinguyen@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:28:55 +0200
Message-ID: <2026072955-anatomist-verdict-df3a@gregkh>
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
git cherry-pick -x 9119ceb76e987c2ec2b549ea100e3268ce3a1c7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072955-anatomist-verdict-df3a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9119ceb76e987c2ec2b549ea100e3268ce3a1c7c Mon Sep 17 00:00:00 2001
From: Tze Yee Ng <tze.yee.ng@altera.com>
Date: Wed, 24 Jun 2026 03:06:35 -0700
Subject: [PATCH] firmware: stratix10-svc: fix memory leaks and list corruption
 bugs

Fix a memory leak when gen_pool_alloc() fails by freeing pmem on the error
path. Switch pmem allocation from devm_kzalloc() to kzalloc() with
explicit kfree() in the free path to match its list-managed lifetime.
Remove the erroneous list_del(&svc_data_mem) which corrupted the list head
on failed lookups.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org # 5.0+
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index c24ca5823078..6306b79a14a1 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1857,14 +1857,16 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	struct gen_pool *genpool = chan->ctrl->genpool;
 	size_t s = roundup(size, 1 << genpool->min_alloc_order);
 
-	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
+	pmem = kzalloc_obj(*pmem);
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
 	guard(mutex)(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
-	if (!va)
+	if (!va) {
+		kfree(pmem);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	memset((void *)va, 0, s);
 	pa = gen_pool_virt_to_phys(genpool, va);
@@ -1890,6 +1892,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+
 	guard(mutex)(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
@@ -1898,10 +1901,9 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 				       (unsigned long)kaddr, pmem->size);
 			pmem->vaddr = NULL;
 			list_del(&pmem->node);
+			kfree(pmem);
 			return;
 		}
-
-	list_del(&svc_data_mem);
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 

