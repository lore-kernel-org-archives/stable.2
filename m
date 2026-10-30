Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364729;
	b=ZaVgfxd2ur5PcOPvRWW7LRZiL/GgwH4JyVmJVQdB7n7SJWzMnCejg4Eh5sJGhJ27K4cj
	 ZI3/aAuAO3MVgZmJD1MxrkZOnJs5zoJ6Xoljm9rMnkT9a161F2pTV34MVBzKZ+2vlt1XL
	 2zKS3xMqsBestpHQqpwBJFlk9q4kgHcf2SRNbpASiJQ8QqspYRzXs4tPwFn1QTtEKhLKH
	 Hh3bb9+u3ql8SZNVlFpC95wxvNZAtzpKmlrJ2wq03TyFLxpQpVZHjfsrMCLRexNLMuf2Z
	 /7vDdqYGweDMTk66N8gNwVU5pqgl8dz7O8j0+VUgejLdOsNIyAi3+4sGlKKG7tURw0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364729;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uK3WvoVy0YSvuCfLBv5IV9n4exSO2EGy5EbkcEXAMng=;
	b=j+4+yzRxV76WLnmXamrHeMl12ds6GqQBixQ4cTia9kZy7YsU28zikjqWiQAId7M3X5hM
	 uOvoSb+PgcxrF8vn8pC3ChHXH8MdVTj4+DjzD+gSz/+JnouL6k1M0hAm/nwOG3kbI2pNa
	 QFaZDOabO4sinaGKbpYdJ6sE46WZQ5GsEWkNAvsMhsWEEMhnz5GPPEBkKLq9IhepwgPfN
	 0/LbNJlNTI2prNNslE6jE30bs8kqk30smI0buud2uxW5Z7krCDF1vJd+BkOPkBYjUjIgm
	 uToYRxBU1lauwf/8NLqTIGi+v/Vjfp/JyiYF8l3oWJ17AVXO0+ay6vBI86abg/weRjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=P4xVlbEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93414606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=P4xVlbEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909DA1F00A1A;
	Fri, 30 Oct 2026 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793364729;
	bh=uK3WvoVy0YSvuCfLBv5IV9n4exSO2EGy5EbkcEXAMng=;
	h=Subject:To:Cc:From:Date;
	b=P4xVlbEMNGDEk2zrGdqyyRdIc1tfPAA1SnlJdEOzz0JrqVPYYYqegobcQj3uUlTiJ
	 qeyfh86QlRNWP5hogp14dl7OVq9vd5F8EVd+0Mi2ARYb5WDqZp2rpRIfvza2EcTwkH
	 zrtRWSr4PZD9LMq58bG2hR3XFvT6WLJ4bA/upFbQ=
Subject: FAILED: patch "[PATCH] net: skbuff: propagate shared-frag marker in skb_zerocopy()" failed to apply to 6.12-stable tree
To: pointerliu@126.com,edumazet@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Oct 2026 13:51:55 +0100
Message-ID: <2026103055-regime-lip-8078@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 79dc34beb1fdb3da79753e51e15c68591a2561fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026103055-regime-lip-8078@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

