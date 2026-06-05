Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F23F4820
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664729; cv=none; b=Bghnqtg5QDT9BhIBBnEpEZClycfBJTAaGcYcKpBvfxKlgc/govne1drB5rH+peqt2fG6yxDJEJY7RYrv3PzDzUATCE2Wty0MmrQtlDqtPmt60Gs3GSR7mkgArod16ABMtlJvrGFxV6Wh8rOOIGrOs1ylzVYCi3DwAYsm0Ia9UoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664729; c=relaxed/simple;
	bh=GvpDfr2/TEYfatG9yuQ7voXnTWnRRgmeTY1sN99TQFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSPz7s5LIUFqqtGXpyabwF+bptliQP+VLFMDIxfQheJOdW7JVPBwxKbTCuKoZqFAglFcdy8E1+Izdxsq6hmh61WEa/YiRtixyfKA0uB+xbfXAwG58VRzzYgwc7FrehgJWTGKEHq8gR843WIdELq/nfdwqIiYtycTOxgb6e/g5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASxa5to2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASxa5to2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72F01F00893;
	Fri,  5 Jun 2026 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664728;
	bh=YS34djVUX4nj5nrStx6A6k31Yt/CZtvnjpEG0hxUYbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASxa5to24TRIPbESGLGX60ZvsG6U+OBmX6SOOWWnFaziI1ye72eFbgaMUMMxWGyv5
	 8SShfS1Xqw7KUPWX5do0xR8tU91hYMTbAp7LTW9eCUwOddWNTm2hroUY21zQ9EdbE0
	 5tsOK6nMiYmPg9+N78ZcL2gPFJNHU/nyhrW90ORpDGltsNpS7LiSECdFz9rGpiaz70
	 T2aOuG1cah6SSdI39GtlPm17HI1x2qHkbUmAB7M6osfINH5ow5Sj8BWcnL1IvC+AiC
	 11I6StIEQazU7SuMnjGsBqhK7NbZdEi6IzzQ+20+vF5/FCv+DLeMfXAceOu/a1vi6K
	 tJkQQUJSqfCgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Fri,  5 Jun 2026 09:05:24 -0400
Message-ID: <20260605130524.411589-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060438-bullring-defrost-cf5a@gregkh>
References: <2026060438-bullring-defrost-cf5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minh Nguyen <minhnguyen.080505@gmail.com>

[ Upstream commit 98d0912e9f841e5529a5b89a972805f34cb1c69d ]

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
the old skb_shared_info header into a new buffer via memcpy(), which
includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
Neither function calls net_zcopy_get() for the new shinfo, creating an
unaccounted holder: every skb_shared_info with destructor_arg set will
call skb_zcopy_clear() once when freed, but the corresponding
net_zcopy_get() was never called for the new copy. Repeated calls
drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
TX skbs still hold live destructor_arg pointers.

KASAN reports use-after-free on a freed ubuf_info_msgzc:

  BUG: KASAN: slab-use-after-free in skb_release_data+0x77b/0x810
  Read of size 8 at addr ffff88801574d3e8 by task poc/220

  Call Trace:
   skb_release_data+0x77b/0x810
   kfree_skb_list_reason+0x13e/0x610
   skb_release_data+0x4cd/0x810
   sk_skb_reason_drop+0xf3/0x340
   skb_queue_purge_reason+0x282/0x440
   rds_tcp_inc_free+0x1e/0x30
   rds_recvmsg+0x354/0x1780
   __sys_recvmsg+0xdf/0x180

  Allocated by task 219:
   msg_zerocopy_realloc+0x157/0x7b0
   tcp_sendmsg_locked+0x2892/0x3ba0

  Freed by task 219:
   ip_recv_error+0x74a/0xb10
   tcp_recvmsg+0x475/0x530

The skb consuming the late access still referenced the same uarg via
shinfo->destructor_arg copied by pskb_carve_inside_nonlinear() without
a refcount bump. This has been verified to be reliably exploitable: a
working proof-of-concept achieves full root privilege escalation from
an unprivileged local user on a default kernel configuration.

The fix follows the pattern of pskb_expand_head() which has the same
memcpy/cloned structure. For pskb_carve_inside_header(), net_zcopy_get()
is placed after skb_orphan_frags() succeeds, so the orphan error path
needs no cleanup. For pskb_carve_inside_nonlinear(), net_zcopy_get() is
placed after all failure points and just before skb_release_data(), so
no error path needs cleanup at all -- matching pskb_expand_head() more
closely and avoiding the need for a balancing net_zcopy_put().

Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260526041240.329462-1-minhnguyen.080505@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8b05866e93b195..b901e6ff461e31 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6407,6 +6407,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			skb_kfree_head(data, size);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6551,6 +6553,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_kfree_head(data, size);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb, SKB_CONSUMED, false);
 
 	skb->head = data;
-- 
2.53.0

