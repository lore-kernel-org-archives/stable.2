Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCF39DBF4
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568998; cv=none; b=pVB857jpm8zDSQ7LFxLII2aW+8jpSjPD5+bgxPFX+ZpgaQJijMhwiIB7gZLVL67JHmuwxXy1Nvtv3/NHHR0oYoNi4o7rdzMeCF+Ugh/gzdgBSCjxCPgpUIojXJbwY213Hk+fDot4rcSZVu+Vc9wFdwlcUXrItlqeNi4EnPDxcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568998; c=relaxed/simple;
	bh=hRSo43CvPPnpPMLLeDH+O+pTDVU5r+99j032DJRLawE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZOSNtMeWGtpOYJq0ZzHi11OHh+sEDdcT6NcmmXHM2Fsuro+SBPDX75cxGTSbNcZ4eM+G/zDQhZ06HCsFHFBckjInMTEKyr+hVhl/hNMS5qonKMjILVuswrFgbGZkc5jB+UL7CsIkKeYyA9xwurSVS2zxROMjxA8HPhm4vvXWsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmbQG151; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmbQG151"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D19B1F0089B;
	Thu,  4 Jun 2026 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780568997;
	bh=Ui2Zq7v0FCsTEDgrXbucsB+gQQ7Md7D3JSWH9KYnbQY=;
	h=Subject:To:Cc:From:Date;
	b=PmbQG151uTQib3XQ/VtdDeaS65gSjqkm5gp0ahBAzBabRIFH5szQI+0yW1VvhQt6r
	 lnZ58zE6Hg486DvGa1mSSnDLO7WDqrOtiM3F6HbLaWmcy73DqDHq+IGsSdhREnZEn9
	 NUD6dd1Wl8IT9ARgv/5Als95Fx/a559+b3tu4TX8=
Subject: FAILED: patch "[PATCH] xfrm: input: hold netns during deferred transport reinjection" failed to apply to 5.10-stable tree
To: zcliangcn@gmail.com,bird@lzu.edu.cn,n05ec@lzu.edu.cn,steffen.klassert@secunet.com,tr0jan@lzu.edu.cn,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:28:59 +0200
Message-ID: <2026060459-existing-wooing-a148@gregkh>
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
git cherry-pick -x c16f74dc1d75d0e2e7670076d5375deda110ebeb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060459-existing-wooing-a148@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c16f74dc1d75d0e2e7670076d5375deda110ebeb Mon Sep 17 00:00:00 2001
From: Zhengchuan Liang <zcliangcn@gmail.com>
Date: Fri, 22 May 2026 17:31:55 +0800
Subject: [PATCH] xfrm: input: hold netns during deferred transport reinjection

Transport-mode reinjection stores a struct net pointer in skb->cb and
uses it later from xfrm_trans_reinject(). That pointer must stay valid
until the deferred callback runs.

Take a netns reference when queueing deferred reinjection work and drop
it after the callback completes. Use maybe_get_net() so the queueing
path does not revive a namespace that is already being torn down.

This keeps the existing workqueue design and fixes the netns lifetime
handling in one place for all users of xfrm_trans_queue_net().

Fixes: 7b3801927e52 ("xfrm: introduce xfrm_trans_queue_net")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index f65291eba1f6..e4c2cd24936d 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -797,9 +797,12 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
+
+		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
+		put_net(net);
+	}
 	local_bh_enable();
 }
 
@@ -808,6 +811,7 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 				       struct sk_buff *))
 {
 	struct xfrm_trans_tasklet *trans;
+	struct net *hold_net;
 
 	trans = this_cpu_ptr(&xfrm_trans_tasklet);
 
@@ -816,8 +820,12 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
 
+	hold_net = maybe_get_net(net);
+	if (!hold_net)
+		return -ENODEV;
+
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->net = hold_net;
 	spin_lock_bh(&trans->queue_lock);
 	__skb_queue_tail(&trans->queue, skb);
 	spin_unlock_bh(&trans->queue_lock);

