Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047249;
	b=39huxGBkvJFpl43Ee+/NGFSoaC5PPLJ17REGkZJ4VbxDjr1TZ3+u3vNijep54BU7Opkf
	 bOpiIrCb8T2/eZrjS24WLuc2tYTcS8YFUFc96GR7Tmt4qapyHhrBbKTjD9XmooLJt/Jub
	 BOosE1HS+DoNMbpj1q/kEw5AXPMTmgY6AieCbu/Iot0hz2bPKItLOW3MdO8N8+kSS+1iw
	 Izh0LRY1Kmo6Za2ywIAU1bJpFvsy8u6+qDGvZ7VpElTy5scDfilDNkDnsI/W1qGwAm2Dg
	 RbPNJifRIrEVhW/9l/Ioj+/vMzSEJwST6F4VC/gRAE87Q3rPazhup+Ye28uAi7tdPAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JRatUjwEfk4+Vykq29iYQa30nmVpcPYt+cJpemig/BQ=;
	b=zw5fVkI9zeviDhaq9ZUpShANuyG01tuYp5mz45/TeRQfxaCvuOT4YkL6WtL4ygh6kqy2
	 iGPEOErE9PXCGyzBEG/17RflDiOg5Ow6nyUk5jQfKTDGXa9RzuhEESkDRe6VbJB5s/P6R
	 a548q7bL64LR5eezuFjBKHfqxgsfeaUISUBFTDP44tLzk5wWv6aOjNGI16ynyWLROf39A
	 CjHZxwWNjKCpIWMTdVxJ/cVHJ6zh4QmsLfo6rTAA1wW3TmV+A+W31lHP2W+Os0hhf7Hwx
	 NnMobx2J+yFN8DlzZwbQfRTUQszgnBNOFRhK0j5GKpxgMhw44qh3whBhP3kej9Cc/FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kt8HIs23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kt8HIs23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4491F008A1;
	Sat,  7 Nov 2026 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047249;
	bh=JRatUjwEfk4+Vykq29iYQa30nmVpcPYt+cJpemig/BQ=;
	h=From:To:Cc:Subject:Date;
	b=kt8HIs23RiurWBndzjMnxnxsQPLySOVcRTWmoS+WCJoBm0R8Qwtq5ckdDtMIJ8qWD
	 qnvb6uVxeHem/kMLzFHwhznc0LKswt44mBohbBSiQ1UAihBTvLU0AEe8YzBj9BMQIj
	 /ofuHYZxaJ9rkbT7bydz13TRN15kE6WNfvOQQrveK9U9W79ZWnSEGBVsWJebRc2PWt
	 bCoz2kTcnm3n+RMGXIxacbTiZYC5wlyCoi+mXrmFaOgANq2waytW5bN83iNiZRuVF5
	 n3NTXrCqLr8fWZ+pc2oAvR9xXIc7V4aAYw3wncZ34AiLuPEzoBcKSyE+ettVyLEvGH
	 NqQBpA5gbadTg==
From: Sasha Levin <sashal@kernel.org>
To: user148783812897@gmail.com,
	willemb@google.com,
	kuniyu@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: limit priority VLAN untag depth" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:27 -0500
Message-ID: <20261107052727-failed-6.12-d3ff07f5acc5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d3ff07f5acc573e5f72bf1c581bae5d05191ba61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052727-failed-6.12-d3ff07f5acc5@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d3ff07f5acc573e5f72bf1c581bae5d05191ba61 Mon Sep 17 00:00:00 2001
From: Kamil Sawicki <user148783812897@gmail.com>
Date: Fri, 23 Oct 2026 20:48:35 -0400
Subject: [PATCH] net: limit priority VLAN untag depth

The priority VLAN receive path can repeatedly remove VID 0 tags and retry
packet processing. Unlike the read-only VLAN protocol parser, this path has
no limit on the number of nested tags it consumes.

Each skb_vlan_untag() advances skb->data and resets header offsets. The
offsets are stored in 16-bit fields. With enough nested tags, the network
or transport offset can wrap. A later protocol handler can then derive a
large pull length from the wrapped offsets and access memory outside the
skb allocation.

Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
Count the tag already stored in skb VLAN metadata as the first level, then
stop before untagging a ninth level. Keep the accounting inside this
uncommon branch so the regular VLAN receive path is unaffected.

A single VID 0 priority tag before a real VLAN tag is valid. No normal
deployment was found that intentionally emits multiple consecutive VID 0
tags; permitting eight levels is therefore conservative.

The issue was found while researching the Linux network receive path for
Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. The
affected path, reproducer and fix were manually reviewed and tested.

Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261024004835.17862-1-user148783812897@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9021e6d36ab2b..b3622e532f269 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6315,6 +6315,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int priority_tag_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -6326,6 +6328,12 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			 * 802.1Q or 802.1AD and vlan_do_receive() above could
 			 * not find vlan dev for vlan id 0.
 			 */
+			if (unlikely(priority_tag_depth >= VLAN_MAX_DEPTH)) {
+				drop_reason = SKB_DROP_REASON_RECURSION_LIMIT;
+				goto drop;
+			}
+
+			priority_tag_depth++;
 			__vlan_hwaccel_clear_tag(skb);
 			skb = skb_vlan_untag(skb);
 			if (unlikely(!skb))
-- 
2.53.0




