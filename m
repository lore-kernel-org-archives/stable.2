Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C94BF92B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070155; cv=none; b=nfJiKSmkFd7UeOzrVoWCx5AFoGZEV9ygOYLbio/fakTB1M/53PSA6Jn3j7HVQaWpuDvlr3/2qQO3s9Y+Az6ojKw57ol2WyPOVM5v2VJ4wfCJdfQUvKGmf/U5lzIKeMImpM+r6bnbdmaiJVxqhi79xw2i4OZEKObV/QY8yJ1zA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070155; c=relaxed/simple;
	bh=12BhVIk3NJ5u9N0zAyr+usPmyxiZd90cX+vtjLHR/yM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LdaAs9r9ucHHjjOxyYpt2GqxJXBoro8zuMqGEKpA8lMiiOSRVUdpKgQYZLT+D0dBwtUMjaWd/j8isEILvJXaax27vgrWqX2u5XsGUqlqGstTXCWgH8X4VK2YtOKTCaRvLjomxN6AF3bcn/3N2fsZBjxgxMLD+Z+LXa+BLGRmGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVZmdNUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVZmdNUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CE71F000FF;
	Tue, 22 Sep 2026 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070153;
	bh=Hj0bz2q7iRd51CwgoWtijaQJ/r7j9Ut299Q33XAcXsY=;
	h=Subject:To:Cc:From:Date;
	b=NVZmdNUh8j1yIKRnyYL+miyofGdn0McUUCCcn9WXpKBhWB9aE04S+Q4AFwK0Y8XJy
	 /F8b0iZ5IvpXwInSACQT+VU9rkCfg2F6jAOSV5WdERne3MCRFtFMnnW8uWdr6YGS3E
	 nzl8ikp/qanKBQV5yrdPIaSmc7g68txlfLnAil4o=
Subject: FAILED: patch "[PATCH] net: wwan: t7xx: validate the netif index in" failed to apply to 6.1-stable tree
To: zhugl3@xiaopeng.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:33:15 +0200
Message-ID: <2026092215-sincere-shack-66e6@gregkh>
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
git cherry-pick -x c7ead9704249d57d4693a04697e3bbd285138fa9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092215-sincere-shack-66e6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7ead9704249d57d4693a04697e3bbd285138fa9 Mon Sep 17 00:00:00 2001
From: Guanglei Zhu <zhugl3@xiaopeng.com>
Date: Fri, 11 Sep 2026 10:17:34 +0800
Subject: [PATCH] net: wwan: t7xx: validate the netif index in
 t7xx_ccmni_recv_skb()

The netif index carried in the DPMAIF PIT header is five bits wide,
but ccmni_inst[] only has room for NIC_DEV_MAX (21) entries.
t7xx_ccmni_recv_skb() indexes the array without a bounds check, so
indexes 21 to 31 read past it.  The out-of-bounds value lands in the
callback table that follows the array, which is never NULL, so the
existing !ccmni check does not catch it and the driver dereferences
whatever sits there as a struct t7xx_ccmni.

Drop the skb when the index is out of range.

Fixes: 05d19bf500f8 ("net: wwan: t7xx: Add WWAN network interface")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Verified in a QEMU guest with a fault injector setting the netif
index to 25: the unpatched driver reads a value past ccmni_inst[],
which lands in the callback table, and dereferences it far enough to
queue the skb.  With this check the packet is dropped.  Well-formed
traffic on index 0 is unaffected.

Changes in v2: none.

Link: https://patch.msgid.link/20260911021734.1396599-3-zhugl3@xiaopeng.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index fc0a7cb181df..8f32c2d26931 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -420,6 +420,10 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
 
 	skb_cb = T7XX_SKB_CB(skb);
 	netif_id = skb_cb->netif_idx;
+	if (netif_id >= NIC_DEV_MAX) {
+		dev_kfree_skb(skb);
+		return;
+	}
 	ccmni = READ_ONCE(ccmni_ctlb->ccmni_inst[netif_id]);
 	if (!ccmni) {
 		dev_kfree_skb(skb);

