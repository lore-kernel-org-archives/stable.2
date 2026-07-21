Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E03C4B60
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626012; cv=none; b=L+JVY8ZUzbAIP0lVK493uVEsLmTndwLGxCBwdpqBr/GK8XLU0Z4HMXEz/qns51KGgAk1eqiaMCyy+NP8SoEwfoeNhOxMBQkd14/reo5sxTYgsHYpeTHVEFFWA3xYcVLTprlg3XsXzLeUAI6nPbsBeGmmGmGCA3oKG+MGNPGPjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626012; c=relaxed/simple;
	bh=PyfrWbZOkHgxuRR3K1CE1uZ7U9pE+JVteKFHtIp2OLw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cy199Q2fVgo7ubG5m1ufdeuAR4NNSHBv6Oo72v3/BUzTP/qXBLAkj8/IxkJqE6fcXsyvBgxKT4v6XVxucR9cLzm3ZUfb+WHQS+hafAPiAeIqEHAyhfAmfn8nPiNlcIljRgj8kCcUGJcwPgsC7fxPu52njOxWL/HzfZAGhypreBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXYkoLwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXYkoLwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E82E1F000E9;
	Tue, 21 Jul 2026 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784626010;
	bh=l0HUR7b76v047H6D609zAaHN60au6Su+voZ4oRCdbqc=;
	h=Subject:To:Cc:From:Date;
	b=LXYkoLwG4/Adz2cyFFX032qLNz6I72hJp4qiYUY4hwCd9r4afRdLUB3JzZVdU1w0+
	 +WSfG5BAiXiKvkRuXeT5D5tTyRU/tS1S7/eanrGNf62mHmlzVS2L+R62OVf17Z7PjF
	 6rv4RkriGjD+9eIRRYq2qPkWYxjgxtoL7UGLgdWs=
Subject: FAILED: patch "[PATCH] ipvs: reload ip header after head reallocation" failed to apply to 6.1-stable tree
To: fw@strlen.de,ja@ssi.bg
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:26:41 +0200
Message-ID: <2026072141-festival-graves-266e@gregkh>
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
git cherry-pick -x a2f57827bf7c695b8c72dc4511cae8e86582369d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072141-festival-graves-266e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2f57827bf7c695b8c72dc4511cae8e86582369d Mon Sep 17 00:00:00 2001
From: Florian Westphal <fw@strlen.de>
Date: Wed, 8 Jul 2026 16:21:30 +0200
Subject: [PATCH] ipvs: reload ip header after head reallocation

__ip_vs_get_out_rt() calls skb_ensure_writable() which may
reallocate skb->head.

Fixes: 8d8e20e2d7bb ("ipvs: Decrement ttl")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Florian Westphal <fw@strlen.de>

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index ce542ed4b013..9fef4335da13 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -736,13 +736,11 @@ int
 ip_vs_bypass_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 		  struct ip_vs_protocol *pp, struct ip_vs_iphdr *ipvsh)
 {
-	struct iphdr  *iph = ip_hdr(skb);
-
-	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, iph->daddr,
+	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, ip_hdr(skb)->daddr,
 			       IP_VS_RT_MODE_NON_LOCAL, NULL, ipvsh) < 0)
 		goto tx_error;
 
-	ip_send_check(iph);
+	ip_send_check(ip_hdr(skb));
 
 	/* Another hack: avoid icmp_send in ip_fragment */
 	skb->ignore_df = 1;

