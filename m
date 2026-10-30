Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364735;
	b=o94PCDUqMcuQM/yrlkIT8SOBW/FnQIInFTZQ8fkNkemOpBv3t0vB20toTrTEuVfC76ra
	 jw5wjYPbs5PARWwO0Aebw2crdKc4O3rx82bUi5pdpBhWboCrlkbPTnvf6hs+gssHF8x0j
	 xEh2nYiuiEibm+B7LXewneV1/MwTfKpu4yxxek/BErMfCFNdVHB9BJjW2ptMuiY0lRy7a
	 pcZQrNKI0W74U2uLEdyryy8D0u79Fa3xBubuOtNJQhptvKtvRhQHBj9vFfYPWfwZ/pPGe
	 CgA+sS5vlx7c4nRUbzKbIsk4lvh1lozi+N8qdS2qsOu6q4xiT7j10Zb9Q0RTK2hAXyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364735;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oNBysJGgP/TF702ENbCC5T1wO6Q5gBtZKUg73KFvsOQ=;
	b=mIH6uhCvaX4onKMWcIXxVwccTy2TClc7zGxyviKCsrQ731ktLEq++AbTsqtWQpmLuXuH
	 bxxnu9u8N5dMHktU+LHUzsHgBaX9FIb/yePmXZNsqGtAT57Pj+L3KxqKw4lA76jAYD5RO
	 jD7ye0c7DmnX3h2ngnnEcHsNTwwlLQgZVEzBfRCPALFLM1JrCJxKHAkEJZDRZsaM6NRJK
	 6uU4YCS96F/p+Lc5ez56eVm7GsYKsZUsaAchHIXdAIMHHsAQoTlDYq/21CBY8QQTSC4VW
	 XrCE9pjy+svxD3sATP7Fc96xOl6fXOaeErLvBzmFQDyIn3B+b+wNFk44SHcSVSIhU6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FJlIvfcs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAF606A333
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FJlIvfcs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB61F00A1F;
	Fri, 30 Oct 2026 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793364735;
	bh=oNBysJGgP/TF702ENbCC5T1wO6Q5gBtZKUg73KFvsOQ=;
	h=Subject:To:Cc:From:Date;
	b=FJlIvfcsWPAqm56dsb+tD/ENigbkXlIM8ZRfSGUwnZ59kYlaDfqZqMWY95ljZbKtY
	 jqzX131XyJ6Vr/jd0okYfl3EcrDTUdE6pJpqw8KXTDZHnrNyUGWZLYPZLk9kbQbTZ/
	 4qrCi44bIq8chAbrimriiHyFFM6jE/u1fpmJzkgc=
Subject: FAILED: patch "[PATCH] net: skbuff: propagate shared-frag marker in skb_zerocopy()" failed to apply to 6.6-stable tree
To: pointerliu@126.com,edumazet@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Oct 2026 13:51:56 +0100
Message-ID: <2026103056-slug-alibi-45b6@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 79dc34beb1fdb3da79753e51e15c68591a2561fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026103056-slug-alibi-45b6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

