Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A14B0E32
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576431; cv=none; b=upd95T+Bq4Nnry2/WtnudueaTEADlqkmQ8O++1zwWXeed2/CA9PaScPKVLlB7VMefGycd03NEiWO87HYxTP5TemlVSmfhUt6U29IwzfFKrUhHTUytXWICTdoLGds0eY2P/MAgIpUU5RI0RyWYZxIdrii5xuFDHCuz9pahGxLsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576431; c=relaxed/simple;
	bh=0V9Lh3m+3PKzi6ioFcf7Z1LOTijyNR6nhubIQNBRuNc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SvpKQ02m+HdDn7vZmwbE9K3mnKOhgctN0oajilTWSxcpEZbN5HWkmjoikIFIrrg7hDxY4PDepeL3RzYGjvHPYzuZpbvoxERmLI9btx10/LoBrD8r/lmsbznkl8LfbbO5Fhe2nG6qRZl3oFROMC17Oj5bI0UDKjGlU2CKRAd86UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/GeYoCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/GeYoCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303671F00893;
	Wed, 16 Sep 2026 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576428;
	bh=MfAmJkznV3m1lwdAmgJrKrE0NXQLPaISmIhepCEWFMw=;
	h=Subject:To:Cc:From:Date;
	b=s/GeYoCn5mXzmW4qDX4IfbmtM2gGD3L5FeKHXygufBjD3QpdUmR1O6kdKWPu/ba4V
	 cuzIV0QaCs83IidN4w2FEwX9GZ0PWhNLspJQQOMBHUdm6vzFbyk58Ftks1AkGxIuhd
	 lLuuwJmJ3FVMf0QSWCuQFWdCMIMM/P4ipC2hvDIk=
Subject: FAILED: patch "[PATCH] bnxt_en: Don't free the live ring's TPA state on queue" failed to apply to 6.12-stable tree
To: joe@dama.to,pabeni@redhat.com,sashiko-bot+sashiko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:28:04 +0100
Message-ID: <2026091604-recall-carnivore-5fe5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5ce7f36c334d723954855ac769ede2fe0e8f89c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091604-recall-carnivore-5fe5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ce7f36c334d723954855ac769ede2fe0e8f89c8 Mon Sep 17 00:00:00 2001
From: Joe Damato <joe@dama.to>
Date: Tue, 1 Sep 2026 18:56:45 -0700
Subject: [PATCH] bnxt_en: Don't free the live ring's TPA state on queue
 restart failure

bnxt_queue_mem_alloc() shallow copies the live RX ring into the clone:

  memcpy(clone, rxr, sizeof(*rxr));

the code currently clears pointers that the clone owns (such as
rx_agg_bmap), but rx_tpa and rx_tpa_idx_map are left pointing at memory
of the live ring that was cloned.

If an allocation failure happens later and the err_free_tpa_info label
is taken, the live ring's memory can be freed while still in use.

Fix this by initializing the clone's pointers to NULL to prevent live
ring state from being freed inadvertently.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260902015652.2421609-3-joe@dama.to
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 343d70a98134..aaf658976865 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16357,6 +16357,8 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->need_head_pool = false;
 	clone->rx_page_size = qcfg->rx_page_size;
 	clone->rx_agg_bmap = NULL;
+	clone->rx_tpa = NULL;
+	clone->rx_tpa_idx_map = NULL;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)

