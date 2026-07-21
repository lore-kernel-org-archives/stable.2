Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985E3C4567
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626023; cv=none; b=G/rbof/nUrEW1+dPIOv6dzuANuxCOlO6niAwoQxpn6Il72DZlEHFdD1fx19d7834xtEN/Cg12C5mlBB9QyVOFzX/IPHlaLs/sZ51aVVaWFbFUvA7TDSU8Y0bW9NRDId3Kmw7N/ISxzaCudHQ9kQB2n5DE/5GFnAHVGGxzBlvTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626023; c=relaxed/simple;
	bh=fdkmcr04niMIAcix6+8yGn1rQ2hDb0i16WQYrEW7Yk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KcZecufFJ+tIKaD3VVBQs4YppOU9bIXRcxwN1S77YpPNhRsR17wvjy/OhDNPg0ZEoX/EePwalgvrfEi9jT0+oQi7H6efY0Tqlxq/bOaD+V6B28QaIBl+BimmxZn4zLyQgsiLL7qSHA7pITPK7bMo3WukiSNBAULJl2YMF/K85Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sIriNi7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sIriNi7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D341F000E9;
	Tue, 21 Jul 2026 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784626021;
	bh=/gfqls/IgQ/iRkCdKB5VxHogD+Ec9UStkKloBkH6BLo=;
	h=Subject:To:Cc:From:Date;
	b=sIriNi7OxiSontGYVEozIGbIVA3lsqoGaL85CP5UbhFO1K9Axa2po0tuJgy0g142F
	 pKExc3uoecsSqAyICVJryCQ0VyZ18FeeyNzVAOEqSZaoAMcww0/43Lgveh9RTXm1bn
	 TVISWhWm8sU1iLUKDZr69P+z+6FOMLq0YSRm8fJM=
Subject: FAILED: patch "[PATCH] ipvs: reload ip header after head reallocation" failed to apply to 5.10-stable tree
To: fw@strlen.de,ja@ssi.bg
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:26:42 +0200
Message-ID: <2026072142-nappy-shelter-af39@gregkh>
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
git cherry-pick -x a2f57827bf7c695b8c72dc4511cae8e86582369d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072142-nappy-shelter-af39@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

