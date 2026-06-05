Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295F381AE4
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684295; cv=none; b=Dq/XKNf/qhkpEvIpL2dXYBWdsra6XPYuDr5ajlF7B/MFcbzomPx8l9Q1YH7rzjjSiUQdc/TopMO7r2IUypRkPV/EJZ/lUOxyc3gLpluiBkyVgPpxZhlVJwpsoJ/blF0kcjRGmtesj4KLn+xpGA5MDC+LlRdARF4ysRoK6dC+z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684295; c=relaxed/simple;
	bh=oz6pyKA+z6TQ4waCmKkEazsT4tKdHk16LWmWaTFD4BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkuZ6atrnPaYyjIt0vz3pUmqfrdNu0eIXA05y55AIY+tbBLh4G/Mvw5lJKeU1stjz3JmqAi7PMzvUViGvxi+k1QwQMrBjs4jsjwp39JB4Hj1BHwnIg8Uk5WLSgM2OlUto9HNlE9g9NJojZyOwhA8khuXvNKKNUsbApR8x+zL7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsRWjJV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsRWjJV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399A71F00893;
	Fri,  5 Jun 2026 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684293;
	bh=m4F7W4ylU8cnVCrncFLFCDxUl93ZX48m1CQDxaoYQ/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IsRWjJV1srEXp1AtlbonNDJ3nSVeWtuVM6LnHaKvam223KvOGMj7ofUe7RfzRVC4d
	 5dCEZR9vHtS2YhVtrz9oNUAijpfBhbduPEtu11Cb02XVGeeglMVnzMdhxT2GqusvN0
	 UxPPKzLmpQhfoUBUk6OrmbtnBKAA9BBdINncPzMYzCwvo1UT+MrsewbFUI5+hS3zsq
	 IqrB8hU9rrXJ80RCrkbLGAsdjSwDXEyFwmugAwNvy69TcB8srFW4abJadg2Glt7Pbx
	 YWi6S1saG6kisyuHs4rPLM/oNdhP7StsNl6NT2IKTWLCuq0dVRIpFWlv5kq7oPlvY3
	 d3GGdbkwNcqxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Fri,  5 Jun 2026 14:31:31 -0400
Message-ID: <20260605183131.2056525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060442-premium-area-c1fd@gregkh>
References: <2026060442-premium-area-c1fd@gregkh>
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
index f7100f5af37ca7..01b34fd472959c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6058,6 +6058,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			kfree(data);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			refcount_inc(&skb_uarg(skb)->refcnt);
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6210,6 +6212,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		kfree(data);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		refcount_inc(&skb_uarg(skb)->refcnt);
 	skb_release_data(skb);
 
 	skb->head = data;
-- 
2.53.0

