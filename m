Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DB376BD6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644865; cv=none; b=jJXkXezoadsTMQSvi3DXyVrMduD0HU6QWo+gRrOTbG36Y179XFnumXGFMj9ZO9FIRMynqPJy5VasP817JihWtYZFaoXZ9n3o6AEfZlH6eJM6GBM2LnguuIZGJsBVAv7ag/IyJ56ydgmNoIiD8XsX5Uz5dET42wRDsKWxamdpbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644865; c=relaxed/simple;
	bh=ghkwrbNSbkPF1LyM/Camc2L4uFI2DvXsHhrJaB0RrBk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kI0FUfuMrsnqyLyLSPObow9+aldibfEKQ+zCM1IEtxuzp38+n41pB1UxVLNB3/dI/ZPQSqY9mJ+7IEe/p2vlwjyjgxhYir589DY6Txa4DbjLyxnKn+lKYQaEnHVDJm0z4twwbr5genCgwCTh0zZSwIymskddWnFRgyT0O1JHoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZAnEWV5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZAnEWV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD441F000E9;
	Tue, 21 Jul 2026 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784644863;
	bh=07ktNWqU/I1hF3iGIwGJOsncvMXceuCizQHGlSoZRn8=;
	h=Subject:To:Cc:From:Date;
	b=BZAnEWV5cmChu5gNfTSXIQnmDU1E8Z+x6jA7lhCjANEPzwz4sOEqExNe6vt9Lgu1L
	 e45D8vdVYgevIglyt02APA5WiHYGBv4rF/y2o2xCGQCVRxCdU6Wctam+QENC/S7fEQ
	 WEi6NShyTcUX6bmo/K+A32LMRf2vV3n9GokmOuHc=
Subject: FAILED: patch "[PATCH] net: airoha: Fix skb->priority underflow in" failed to apply to 6.12-stable tree
To: win847@gmail.com,joe@dama.to,kuba@kernel.org,lorenzo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:40:54 +0200
Message-ID: <2026072154-partly-effective-6632@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 86e51aa24686cc95bb35613059e8b94b9b81e3f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072154-partly-effective-6632@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86e51aa24686cc95bb35613059e8b94b9b81e3f0 Mon Sep 17 00:00:00 2001
From: Wayen Yan <win847@gmail.com>
Date: Sat, 20 Jun 2026 16:17:44 +0800
Subject: [PATCH] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In airoha_dev_select_queue(), the expression:

  queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;

implicitly converts to unsigned arithmetic: when skb->priority is 0
(the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
and UINT_MAX % 8 = 7, routing default best-effort packets to the
highest-priority QoS queue. This causes QoS inversion where the
majority of traffic on a PON gateway starves actual high-priority
flows (VoIP, gaming, etc.).

The "- 1" offset was a leftover from the ETS offload implementation
that has since been removed. The correct mapping is a direct modulo:

  queue = skb->priority % AIROHA_NUM_QOS_QUEUES;

This maps priority 0 → queue 0 (lowest), priority 7 → queue 7
(highest), with higher priorities wrapping around. This is the
standard Linux sk_prio → HW queue mapping used by other drivers.

Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
Link: https://lore.kernel.org/netdev/178185573207.2378135.3729126358670287878@gmail.com/
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Wayen Yan <win847@gmail.com>
Link: https://patch.msgid.link/178194366700.2485734.5368768965976693502@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..3370c3df7c10 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2110,7 +2110,7 @@ static u16 airoha_dev_select_queue(struct net_device *netdev,
 	 */
 	channel = netdev_uses_dsa(netdev) ? skb_get_queue_mapping(skb) : port->id;
 	channel = channel % AIROHA_NUM_QOS_CHANNELS;
-	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
+	queue = skb->priority % AIROHA_NUM_QOS_QUEUES;
 	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
 
 	return queue < netdev->num_tx_queues ? queue : 0;

