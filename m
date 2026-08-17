Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606741D216
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970676; cv=none; b=ESnS+B5SABDOgZmLLDBAa+NtTEN3jNetQbLDMmAlR7tu6AP0cWgkuyHf+OvwiQ3S2zwcVv1Zqv/T/kmq2nYi+8V51olgk7xGKEalkCXR6+RAZbXjU2B7BUy++n6W403qNWV/pkiNp4ngPOylHvPsYjmooVooD33XfViv+3IBGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970676; c=relaxed/simple;
	bh=x2C/ud+uHfWJ/rrd/ciIch48eKaw80xot/WZ76nny/8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dWS7I5TdDI+7/PUMnDnbxp9GWK2B6v55C8zvjapw+EIuan5aj73SmDRrGTUuYYwhcXKMi2RcRt/XaWSbQhjo7OQd6Bo0whGLvI0gKt+vPsEwRkDwk/9wxQgE4pCcqvc86AawlX+C2u500+ovyHoWG2go16RoIiiPWUFA/HlS308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCgMbAHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCgMbAHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98D71F000E9;
	Mon, 17 Aug 2026 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970674;
	bh=5nyxAOYhUP1XlufHGbzZA3dFq8FoANEsVJJxDateZPc=;
	h=Subject:To:Cc:From:Date;
	b=YCgMbAHJ3ZvjzauiLNmfxKrI3mFQhCtUeuJu45LJZWBxVuOLUOrUsp1FJQPPtGzRn
	 1j14ITe0J9ZkV7fJM3ydGGcIP0odbSG/G2rTI33dl6Ixgvru3mH99Ckq9XzBBYJta7
	 8WHx7NxXaBmH0ydkVfjaB9TGG2InbcQuqn30LsjU=
Subject: FAILED: patch "[PATCH] net: expect instance lock in netdev_queue_get_dma_dev()" failed to apply to 6.18-stable tree
To: kuba@kernel.org,daniel@iogearbox.net,horms@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:43:08 +0200
Message-ID: <2026081708-grout-zipping-a932@gregkh>
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
git cherry-pick -x 92465f46f3c3a92e4758af20d2363b7adc43e1f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081708-grout-zipping-a932@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

