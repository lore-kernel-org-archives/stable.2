Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F5301704
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667202; cv=none; b=P7vKosXwrFsNlIRn8pw2dAZKNie3Zx82rL8uSy6u3KgJldDDjAd5JSClRUaH3SOq+pFdX0JkUQXRAF2mBD4jbm0QA25B6ToNMD5qrRCw4z1+ahZH5ytVfnTHBN9vmZi03I8RVrTpFIwL+coTV0ombWl1uD0FCGMI/Yi8tFv4XcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667202; c=relaxed/simple;
	bh=ln6dxqH+ZumX18DjcJ8mUDyT5w8iXAAbzJtPv847+LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+KkRpGWsqnmKcgetNc8ZmKH+YJSjTWzlkwe/nkjE900nwE2pxuhf5qBV+I1I6WpF328hHfsjhMIUkpkw4aadFHbS+iNSLg698rqtmxysUrx/hA9dobXvCuuF2aBr/Awvz5DZCla2XebJxvogHucJZArVlzVp1DQ0rvLZfszzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHVQLolR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHVQLolR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DAC1F00893;
	Fri,  5 Jun 2026 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667198;
	bh=sdCydy8cPIukBbQaYw00s755mTb6Y51Kj3Dx/MARaHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHVQLolRtVD8pxPqmySJ+YS6rgGN70YRUVRA9plB0AqWvst6KFyPsRExWhdixsabX
	 Z58eyWji+SRO7QilieABC/06s7zLxayqKH9LbOaUm65qU6JazKcFEtlJlgvFmdj94M
	 OihXcQnqCBhkVoSlE5YvN0GRqrNtphcgvozWjmMhTUvCr5eBHU5cHwxFs1NiwC10hv
	 KHTmC3Pr1/YQxcxwogvcmTCjspP45CmcsZW9bORe9apOo4g6eR0rA/QKhGeJ3HjjRZ
	 aweBCu+ICZOTPjooAOKEb+bpAGDoyjTobff4b6/Fe3z2Xq7rCwBjtgoF2UIszB3A8/
	 o1oZFQvIzNoHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Fri,  5 Jun 2026 09:46:35 -0400
Message-ID: <20260605134635.841596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060440-cinch-zone-22b5@gregkh>
References: <2026060440-cinch-zone-22b5@gregkh>
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
index 8bc4b26de5e538..b91e2e9f1096a0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6242,6 +6242,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			kfree(data);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6386,6 +6388,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		kfree(data);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb);
 
 	skb->head = data;
-- 
2.53.0

