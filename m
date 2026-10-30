Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364738;
	b=pt7oWI8fYOnoKAT2s8LdYykUaDHeqaHD2CRMjzxSJdb5O9le0kcjFRM3wp091as/zNYN
	 OoIraaf/jQKJgn2V6V3VYe+N1WcfvmSue+TdziqFboRrwHGwrYU7X+/K3ZGU5gX2ur+cx
	 xeAnDh12eyXOQ9kbD2WknvYdUB8dESCOEppEPofjfVszAAdde9n2RKjHNs4UmpznyM4By
	 WcvrTJhBcepucOj++E8XQdkUecaEWi9MaxlNFq2dqKIYduhmLZuG+FJmtvuGZGCR1h13c
	 EDth19/WPAFr5LNlgxoCoRtFqUDGYj/07OIO/o/eQC5bIGI6kW33Htu6NDCGfxVLV/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364738;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OkkbVR35edVcAhs1xcZxTyF3F/sBovMPGVcdt4f9v28=;
	b=kwr8+3gs6PjSMSSfhCw4lJTQ2T4xvXDmYs+sGCKEsQESNxoJ4a/RNXPaeAadXEynbKVA
	 H8+RDY0Bus99I5tuU25nmqsH8/l79PrjK4pTqH/ocxhUy5eUmgJFitJwtO33Q1jxsFgPt
	 qHnXRZEfuq7L/O+J6aZ2BHSlKOJQuCOk6av7GL8AZS+RbTld+0gLW0cSXS+aaV+imTkKX
	 BlEziocCSXI+hWLRTAosUGDFzNsPQZXA6HOURnVJWXTQzGJqeq7GUdwOdrGGBPrUpUdA6
	 mXhbmbyBtv4xx+R3SEh9FLjN3KUmcQ8psoggJbcXxlobZxEP6CkvSYZ50YBf7uyKMdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CJ2CHC15;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BAD60A2600
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CJ2CHC15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5421F00A22;
	Fri, 30 Oct 2026 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793364738;
	bh=OkkbVR35edVcAhs1xcZxTyF3F/sBovMPGVcdt4f9v28=;
	h=Subject:To:Cc:From:Date;
	b=CJ2CHC15XjZ992De++rbA9z+Gbs8Ld7gvBKznYpTh3xR50FnVDzMXfGkLnNAsocFQ
	 2L1F21Q67ikMkSt2zqw32lfUyvCzK1PyY+rpTTdalt/LR47jiOUcQ8T921j2RauUp4
	 io8ZjnBSqhmMfBoAOIngyRUniKqkNueRxyF6WvFY=
Subject: FAILED: patch "[PATCH] net: skbuff: propagate shared-frag marker in skb_zerocopy()" failed to apply to 5.10-stable tree
To: pointerliu@126.com,edumazet@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Oct 2026 13:51:57 +0100
Message-ID: <2026103057-payer-wobbly-83d2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 79dc34beb1fdb3da79753e51e15c68591a2561fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026103057-payer-wobbly-83d2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79dc34beb1fdb3da79753e51e15c68591a2561fe Mon Sep 17 00:00:00 2001
From: Zizhen Liu <pointerliu@126.com>
Date: Thu, 22 Oct 2026 18:42:17 +0800
Subject: [PATCH] net: skbuff: propagate shared-frag marker in skb_zerocopy()

skb_zerocopy() moves frag descriptors from @from into @to and takes a
reference on each frag, but it does not copy skb_shinfo(from)->flags into
skb_shinfo(to)->flags.  A destination skb holding the same page-cache
backed frags as the source therefore reports skb_has_shared_frag() as
false.

That breaks the invariant relied on by later in-place writers.  ESP input
checks skb_has_shared_frag() before deciding whether an uncloned
nonlinear skb can skip skb_cow_data(); with the marker lost, an skb that
skb_zerocopy() built for nfnetlink_queue or for an openvswitch upcall is
decrypted in place, letting an unprivileged user write into the page
cache of a root-owned read-only file.

Propagate SKBFL_SHARED_FRAG when frag descriptors are copied, as done for
the other frag-transfer helpers.

Fixes: af2806f8f90a ("net: Export skb_zerocopy() to zerocopy from one skb to another")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Cc: stable@kernel.org
Signed-off-by: Zizhen Liu <pointerliu@126.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261022104217.1852191-1-pointerliu@126.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index eb9fcc4b1fd1..6a7c02b7653a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3966,6 +3966,8 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	}
 	skb_shinfo(to)->nr_frags = j;
 
+	skb_shinfo(to)->flags |= skb_shinfo(from)->flags & SKBFL_SHARED_FRAG;
+
 	if (i > 0 && from->unreadable)
 		to->unreadable = 1;
 

