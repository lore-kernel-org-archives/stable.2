Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06987433BCE
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562978; cv=none; b=OfxfQu/Io3QGTnoXO5oU4ZhbpP6ogzt6Hccw0sfn6sJsSv0WV1cesBoNb0ghdDyzB1Gc84NhRWp2v+YTtOm+hDJ0FVlBZlYtrzhyGy7Y3rm19AgXObyJ5kSbVjpeMdQD2Sx6XD/V44uHhrFtEN17MxgIA6lvotmTz4etHmjIATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562978; c=relaxed/simple;
	bh=62mLoXoMkESOpcTXd4V402FTH8VUz4iU11eQcYVsnMk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XppsIC1mSqMJ2ctaXMFP49Bl7trGDksoAkLvfOPybBIkecQZ5+/0YP95/iF1OHgK0NwGmm578FM0UwlAz7lLs714LOYPmJ4pbkegCtXH6wxgNMVGS/kT+tJctvLJEnv4wJm8C8iWwxC4xZkwSutUnGBfQ0VPWhAnwlukw5oQYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIA+zag/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIA+zag/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3652B1F000E9;
	Mon, 20 Jul 2026 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562975;
	bh=oj4KWEk4RyrQmw47UqP0IYcDVwYb6XplDzLZLMZAVuE=;
	h=Subject:To:Cc:From:Date;
	b=oIA+zag/uRsJpwr9nRZ5qTAR+DtcAqFcPdxaCc4pY+i2KfPWNvTF9W8x9NIv2DsnS
	 7Kx7TWo3trtm46LZsxn3I6W4699m7GOVW+qzZAZDi381Z5NVa6W59fs3m6ZzxJOjnV
	 6eKQNWBFXl7ZfYzEYaSzyC4glFwpxotE7c3aKD8Q=
Subject: FAILED: patch "[PATCH] net/sched: act_ct: preserve tc_skb_cb across defragmentation" failed to apply to 6.1-stable tree
To: xizh2024@lzu.edu.cn,bird@lzu.edu.cn,kuba@kernel.org,n05ec@lzu.edu.cn,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:52:18 +0200
Message-ID: <2026072018-sixtieth-darkness-30c6@gregkh>
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
git cherry-pick -x 9092e15defbe6c7bc241c306093ca9d358a578e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072018-sixtieth-darkness-30c6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9092e15defbe6c7bc241c306093ca9d358a578e7 Mon Sep 17 00:00:00 2001
From: Zihan Xi <xizh2024@lzu.edu.cn>
Date: Sun, 14 Jun 2026 01:42:39 +0800
Subject: [PATCH] net/sched: act_ct: preserve tc_skb_cb across defragmentation

tcf_ct_handle_fragments() calls nf_ct_handle_fragments() without saving
and restoring skb->cb. The defrag helper clears IPCB/IP6CB, which aliases
the tc_skb_cb/qdisc_skb_cb control buffer. Fragmented traffic through
act_ct therefore loses qdisc metadata such as pkt_segs and can trigger
WARN_ON_ONCE() in qdisc_pkt_segs() when panic_on_warn is enabled.

Save and restore the full tc_skb_cb around nf_ct_handle_fragments(),
matching the pattern used by ovs_ct_handle_fragments().

Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc control block")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/510c51217fd7aaf29c6dc298bab8d643fe229b1c.1781358692.git.xizh2024@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 6158e13c98d3..d47a82f9ac6c 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -844,11 +844,11 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 				   u8 family, u16 zone, bool *defrag)
 {
 	enum ip_conntrack_info ctinfo;
+	struct tc_skb_cb cb;
 	struct nf_conn *ct;
 	int err = 0;
 	bool frag;
 	u8 proto;
-	u16 mru;
 
 	/* Previously seen (loopback)? Ignore. */
 	ct = nf_ct_get(skb, &ctinfo);
@@ -862,12 +862,13 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 	if (err || !frag)
 		return err;
 
-	err = nf_ct_handle_fragments(net, skb, zone, family, &proto, &mru);
+	cb = *tc_skb_cb(skb);
+	err = nf_ct_handle_fragments(net, skb, zone, family, &proto, &cb.mru);
 	if (err)
 		return err;
 
 	*defrag = true;
-	tc_skb_cb(skb)->mru = mru;
+	*tc_skb_cb(skb) = cb;
 
 	return 0;
 }

