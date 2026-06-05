Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378DD40E8D4
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667862; cv=none; b=rLqGvYvbaV4ZcQpNE9H9yRNcLtIRnyv6hWVew8pfrX+us6THr7ovmTrBSWLQTuU6N+Z5ZfUTsj5VmjrF52LfMHiWIW6W91NIyt7VII3lvrp5I5WSLk/JjF/5AEHYDlqJWKjfUuuINxPlw99qDkanN7V+T0GV0dvy4P37HbV+tMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667862; c=relaxed/simple;
	bh=taH/htxfRp9G4UgPJtZqDtvorB6jBmbIMN5saL8XvvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYwEAeeGXN95GjSS9B0fEUw2GgetVIzg5ESAUGstZSZmaWJ1P7n40mBc7X0ywmd7PBuRSkxIW1lzr8X6HKGck/i+19ou/SnYow8ObRNoPBh3Qf9hTxJ6if7YKzi2AcsAGV6D9HGrDZIIOk3TxwTNDps8d0C4gdeP7hl+cGN+6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkxuCf4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkxuCf4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6351F00893;
	Fri,  5 Jun 2026 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667860;
	bh=p+pDPyuSe1H0YRTE0CLkxO2+TZksjNBHbrdDj6NRH68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GkxuCf4JdpHqEKMEGIAISZdbUuXAnEqcMgrhdZqRPUR5cm+aNLbgs2Ws94O5TJoYM
	 5+uOqaDbf4bLFjmcrBwKiLCdlSK7RhzF5zLw5kve1y3obrAZPHvg0owg5uFfVKtUQd
	 9omyft1Swkyev5EsABeyAJbjvZNlGNhcRmrBJKrgxw+kXhckW5lII0cbOso48KEV1P
	 pf9bCE5F9N9Ldg4fojk7/aC4aaU/SZnRmc1PmQ/5RzhiRptm3CETFTGQWNUre1g+4y
	 eXiJaui38/6i9VW7rKqzFqINpMosNToUnI666yAPrQq7vvVRDaN/Fq7e1kB2bVLj0j
	 cn/rphMhBlsQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Fri,  5 Jun 2026 09:57:38 -0400
Message-ID: <20260605135738.973875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060441-bullfrog-dealer-0f27@gregkh>
References: <2026060441-bullfrog-dealer-0f27@gregkh>
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
index a8d09eff26f11c..d363d2f6f576c1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6256,6 +6256,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			kfree(data);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6404,6 +6406,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		kfree(data);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb);
 
 	skb->head = data;
-- 
2.53.0

