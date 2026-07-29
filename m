Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354C48CD52
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331758; cv=none; b=r5EsekZYbwH9K455ve5St5V03U773U/Dv9StBG4APwxYGBE2j/TXGcdMGyNR283CKZDwLPg5ensnzwiXRlDrMV7b/Ar6xDNZCXBctKZPpdlgnrZUJC8wCJrpbH86HrKtS5l28i6eKHcXosL2XUvDvtHwSJbOIgpCFHuO2BuL+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331758; c=relaxed/simple;
	bh=OeJa6jBVtgU2XrrjVjq5h0S03BaR2Tv38SsgGywP6Qo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xu8G0fewaDAnzmlCwZqx2deykbY/z7nIPXq4UB0HMEfznMwqPHCQ8GcUs/Bv70r5SH5CZvQC8J/eCmwN6zCSXO6KIF9t11mfGDzyzVVa3KQSDNwxh6ruS8J8hp/c+VUcRn0xtTyhusdNXYuMPnY5zzxPT63LUpgpaG7JUYP6nKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwC0Rbp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwC0Rbp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE8F1F000E9;
	Wed, 29 Jul 2026 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331757;
	bh=2K0MfwH5mw0hk0xs8Hb+723WiYqLRTGFVrdmc2I2P2k=;
	h=Subject:To:Cc:From:Date;
	b=TwC0Rbp3N+gZnb2wo5rK67Wm4x0THgd1d39PElaYgmREXIoWESZLvt5i/szhwXN71
	 X4MOi7gsxG5e+2cYb1+dWaMlLjxIYoA0syZU+0TKkjKC2EOKv1RIZfRwiOef14hoLY
	 AwVC0LEFkO9T5w8Xh8RPqLrXfTx3AWSIRtmUf8CM=
Subject: FAILED: patch "[PATCH] firmware: stratix10-svc: fix memory leaks and list corruption" failed to apply to 5.10-stable tree
To: tze.yee.ng@altera.com,dinguyen@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:28:55 +0200
Message-ID: <2026072955-cranial-friend-2d3c@gregkh>
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
git cherry-pick -x 9119ceb76e987c2ec2b549ea100e3268ce3a1c7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072955-cranial-friend-2d3c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

