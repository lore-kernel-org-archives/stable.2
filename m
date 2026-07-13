Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D019D8A8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963844; cv=none; b=AnNHgjvphTHsBHVlsBK9+xqFa6cONwxJpVjbM2LDJuhFhnmryc3m1l6+hAKBL4PgeeSl9e4Uit4/pqsqS1kLbqE1t5PN3F3K6iYmhtEJ7bAxyeal2B/VeO9+0scRtBPVT7l4KlXHnsR2+bWzTeUW84EyCCrdm7i+geoI05/+NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963844; c=relaxed/simple;
	bh=1tmxqbSX/zDXiqCGKwM1SB+8uGNFCIFDlS5qygzgRsk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AVpLVr5iBgv3Zsgwu4FwF6RkddTGHT3nOOXWuz6GI9J9aNqn/BGinbLj9P6ELLTDgzWs+PoYJ6bpcT2enIQnMEVQcFBWuu2SU9KjVSHz23AnGRzOajKH3lyuEY8wuC7euLmZjG3rcv+LS78URCLe9MoJRcpCm6NWfukNZ7jf/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y028l/mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y028l/mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FB51F000E9;
	Mon, 13 Jul 2026 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783963843;
	bh=0Rk+lDEChkxY62AuKeMjTl08LU/MjrxyqQA8joVGopI=;
	h=Subject:To:Cc:From:Date;
	b=Y028l/mmllnHMfVsFaHsFPYNdwWRmTwtqqmFBhGa9AdBuK388lIBXScAe6sGO6ve6
	 sHkcGNYAlXU7NX94Aamz27fvN54RJRNTyLp1+LezuYqmDgtOnNUsbctAUbDTuTi2y4
	 JpszWTvWLtmcmM2yQXl/g4tlGs/l5p2iCUPs4EPc=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: cancel pending_rx_work before taking" failed to apply to 6.1-stable tree
To: runyu.xiao@seu.edu.cn,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 19:29:36 +0200
Message-ID: <2026071336-hastily-statistic-2a3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2641a9e0a1dd4af2e21995470a21d55dd35e5203
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071336-hastily-statistic-2a3e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2641a9e0a1dd4af2e21995470a21d55dd35e5203 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 17 Jun 2026 23:36:13 +0800
Subject: [PATCH] Bluetooth: L2CAP: cancel pending_rx_work before taking
 conn->lock

l2cap_conn_del() takes conn->lock and then calls cancel_work_sync() for
pending_rx_work.  process_pending_rx() takes the same mutex, so teardown
can deadlock against the worker it is flushing.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the l2cap_conn_ready() -> queue_work(...,
&conn->pending_rx_work) submit path, the l2cap_conn_del() ->
cancel_work_sync(&conn->pending_rx_work) teardown path, and the
process_pending_rx() -> mutex_lock(&conn->lock) worker edge.  Lockdep
reported:

  WARNING: possible circular locking dependency detected
  process_pending_rx+0x21/0x2a [vuln_msv]
  l2cap_conn_del.constprop.0+0x3f/0x4e [vuln_msv]
  *** DEADLOCK ***

Cancel pending_rx_work before taking conn->lock, matching the existing
lock-before-drain ordering used for the two delayed works in the same
teardown path.  The pending_rx queue is still purged after the work has
been cancelled and conn->lock has been acquired.

Fixes: 7ab56c3a6ecc ("Bluetooth: Fix deadlock in l2cap_conn_del()")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 62133eef9d2f..036d887dec34 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1775,19 +1775,13 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	disable_delayed_work_sync(&conn->info_timer);
 	disable_delayed_work_sync(&conn->id_addr_timer);
 
+	cancel_work_sync(&conn->pending_rx_work);
+
 	mutex_lock(&conn->lock);
 
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
-
-	/* We can not call flush_work(&conn->pending_rx_work) here since we
-	 * might block if we are running on a worker from the same workqueue
-	 * pending_rx_work is waiting on.
-	 */
-	if (work_pending(&conn->pending_rx_work))
-		cancel_work_sync(&conn->pending_rx_work);
-
 	ida_destroy(&conn->tx_ida);
 
 	l2cap_unregister_all_users(conn);

