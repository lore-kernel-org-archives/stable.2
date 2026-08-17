Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E241167E
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970681; cv=none; b=OeewrodDgM5WcZVhgTNwMXSzAs6HmpTSov+H+vaXlR9Eymsq5kve3QfP2jYjXYb65MrKBIq5JsbiK0jr6T48n2F4PJnZENRPLLUnzrFZQ9a9RvNqxWJ1ukyua+TVUJMQ64U2L6pgb0P3ndwrwkoEzBXrvdXNRXujNTYQrgFj35Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970681; c=relaxed/simple;
	bh=HQTztExFIaQ9x78LCVdmXWWcH9Uwbvg9/UI0v667mZc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SQXcFm1XPjGXxW+rje74b87apujbgDwurJsVX5h1lP4KDYuPlpsTZ4eZPp7s0wNuStFmLW5+K8umhUTlwNEo64kzVxic7p6O7y5PEwC/l4yKXXH7RkjJlm3rSdFKR0OLN00mt9jFg+XxVFeq/XaRfmLe5vvqkUSVuT79Ofun5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=auFba4gM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="auFba4gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41701F000E9;
	Mon, 17 Aug 2026 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970680;
	bh=74VBkJicJmClkBZ8YTYKDz4EYyuMDSKhUayN47qJkT8=;
	h=Subject:To:Cc:From:Date;
	b=auFba4gMr8BgCXraopL9vWtQVrEyWXlyAgL1/bK9x0MN1OnbMWADbpe01wV1YJkBy
	 s1tDqfzlQ3uJAveApYm+O56ybRH9ugJkSAVY2S9cHJ7CjJeOFaUJPp/Rzd1Zv++NhU
	 pr+TpxyXBNxd6ra7sreJEWOgxYAf7KH6m8GfWlcE=
Subject: FAILED: patch "[PATCH] net: expect instance lock in netdev_queue_get_dma_dev()" failed to apply to 7.1-stable tree
To: kuba@kernel.org,daniel@iogearbox.net,horms@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:43:08 +0200
Message-ID: <2026081708-gracious-yard-1b78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 92465f46f3c3a92e4758af20d2363b7adc43e1f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081708-gracious-yard-1b78@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 92465f46f3c3a92e4758af20d2363b7adc43e1f5 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 6 Aug 2026 15:56:26 -0700
Subject: [PATCH] net: expect instance lock in netdev_queue_get_dma_dev()

netdev_queue_get_dma_dev() uses "compat" locking assert which wants
either the rtnl_lock or netdev instance lock. This is not right,
the callers are taking the instance lock unconditionally. All entry
points for queue config are purely instance locked.

In other words the callers use netdev_get_by_index_lock(), not
netdev_get_by_index_lock_ops_compat(). All the state we will
access is effectively instance lock protected (it's const for
devices which are not ops-locked).

Update the assert to avoid false positive warnings.

Cc: stable@vger.kernel.org
Fixes: b6c5f9454ef34 ("io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock")
Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/20260806225627.3998672-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 4d6864bb4f6b..f5558b12877c 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -40,7 +40,7 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
 	struct netdev_rx_queue *hw_rxq;
 	struct device *dma_dev;
 
-	netdev_assert_locked_ops_compat(dev);
+	netdev_assert_locked(dev);
 
 	/* Only RX side supports queue leasing today. */
 	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))

