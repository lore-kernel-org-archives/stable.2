Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC543C056
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664177; cv=none; b=ZoJtdYCp0owSrED7UDVnG5rLN8Ld3Hj2TVTk7j7SI8u7U6h3fh8zVQgdqMLP1YN1r3Lse1rkP8nmgziUMb1qvzi7BIG3GvGIyiECNetbQu4D1TCd4Dja0TANOlSLVxUc6zuh7jnpxjj78gSV1mxAf8q+ajp10OQOFu388XSGr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664177; c=relaxed/simple;
	bh=4qu0qyhAbw1YFzP44H8eLg7GCvh4V2hwTBMpoKpyPL4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qKBDZa95aJPsYiLivF1LRiLu/c6FMv4bzh+MLtaA5+QokNjKZiNV5/PdfB9iw1i1JnCTnDnXIDbRnub+hkmASdQHHf0MaRmrh2dw99zUv6JmIWn1ggKmpCn6rL25JBAJF7f0uU57LrYGKbSIxb14PyuC/2xTVHQT4dyw1FxIQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZr97rbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZr97rbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59311F000FF;
	Tue, 29 Sep 2026 06:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664176;
	bh=ETEFo0Mucdm3ldOTDeaM7047qxT0+ucRMASmpV4AwCs=;
	h=Subject:To:Cc:From:Date;
	b=NZr97rbqUSrv+Q24/VG9edKqKjUiv43Z2skPRXuT8cixh8hANf4vtbiD1rD/Qh+ZO
	 RNPWnFJlVP+FVtAQAaplX0H1ZjDWxvgS/3VufVzRiBov3Ln++klGH4eKabGiE/dN8F
	 7iKOzf8zsQ7/ZeHKRzxVxeTI0o95WXwXdSrKv8uk=
Subject: FAILED: patch "[PATCH] bna: prevent IOC timer rearm during teardown" failed to apply to 6.6-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:42:51 +0200
Message-ID: <2026092951-corporal-ascension-4e63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 77b1718e39e5c9f6956fb60807326af20baf889d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092951-corporal-ascension-4e63@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77b1718e39e5c9f6956fb60807326af20baf889d Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 21 Sep 2026 21:46:05 -0400
Subject: [PATCH] bna: prevent IOC timer rearm during teardown

bna: prevent IOC timer rearm during teardown

bnad_pci_remove() and the probe disable_ioceth path call
timer_delete_sync() for ioc_timer, sem_timer and hb_timer, but not for
iocpf_timer.  bnad_iocpf_timeout() then takes bnad->bna_lock after
free_netdev() has freed the struct bnad.

Deleting iocpf_timer last does not fix this.  sem_timer and
iocpf_timer rearm each other: bnad_iocpf_sem_timeout() can arm
iocpf_timer, and bnad_iocpf_timeout() arms sem_timer from
bfa_ioc_hw_sem_get() when the semaphore is busy.
timer_delete_sync() only waits out its own callback.
bnad_ioceth_disable() can time out and leave that callback live.

Shut all four IOC timers down with timer_shutdown_sync() on both
paths, so a later mod_timer() is ignored.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1d32f7696286 ("bna: IOC failure auto recovery fix")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260922014605.588040-1-mhun512@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 8b75004ba7c9..55dfd4896785 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2571,6 +2571,22 @@ bnad_ioceth_disable(struct bnad *bnad)
 	return err;
 }
 
+/*
+ * The IOC timers rearm one another, so deleting one cannot stop a
+ * sibling callback from arming it again.  Shut them down so a later
+ * mod_timer() is ignored.
+ */
+static void
+bnad_ioc_timers_shutdown(struct bnad *bnad)
+{
+	struct bfa_ioc *ioc = &bnad->bna.ioceth.ioc;
+
+	timer_shutdown_sync(&ioc->ioc_timer);
+	timer_shutdown_sync(&ioc->sem_timer);
+	timer_shutdown_sync(&ioc->hb_timer);
+	timer_shutdown_sync(&ioc->iocpf_timer);
+}
+
 static int
 bnad_ioceth_enable(struct bnad *bnad)
 {
@@ -3727,9 +3743,7 @@ bnad_pci_probe(struct pci_dev *pdev,
 	bnad_res_free(bnad, &bnad->mod_res_info[0], BNA_MOD_RES_T_MAX);
 disable_ioceth:
 	bnad_ioceth_disable(bnad);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	bnad_ioc_timers_shutdown(bnad);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
@@ -3770,9 +3784,7 @@ bnad_pci_remove(struct pci_dev *pdev)
 
 	mutex_lock(&bnad->conf_mutex);
 	bnad_ioceth_disable(bnad);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	bnad_ioc_timers_shutdown(bnad);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);

