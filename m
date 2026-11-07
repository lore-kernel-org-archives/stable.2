Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048019;
	b=HLvTqn2Y8LgmTFuTKLttCJ3uDAM6WcwxafsqWcbwaoaTTNnJaYn+s9Vld75Zi/TpC9f1
	 dsV7CmfmSp4xUPwyxwAy4EI9is3HB7xs1z/J0YAQn0186q7u7EaXAUhuiBdKUzXrxzQLr
	 H8MUEl8+ZEOFXjAI3Y/EwkAU1fXyB1SM71jhh/SdV45XDy+dsVJBSh5miWh2bwEhZgych
	 CZ/h8qXTWBdk9C0z4HmvGOkYEHT6w0D7FKe4aUo5/4uPlMM5Cpr8Ohe+q16flWfvher+r
	 mEcuCoqJKs9Zm0XqtDnDxap9JBun5P6poTac8+AA1xvr6Kgfc9gE6jEqYHFVR9jJufw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G4RlYcLCFMGnO/d8bvfe4mTsrhnohjESOurxepcHRfI=;
	b=vIMlfAb0QQpDThSfU5b3AnXzllHwDx3C9T+Nb2kg9SJsT9yy9i4nGLiyNH0LhoshXR3C
	 1bIkkPWRlmQ2ufIW5583WU0eU19yUKxn79KsumOI9fPz/AYlmrNgh4KEEONy0ydKm9/xU
	 13Fy94M5D/TSDYGrM3iA88ebhayXdisI6GUbH27dpHAEkaSLP8T/2rCFakKL33SP979+3
	 hRTYBOVOH3LNAKi32V1ya0BRTYZZ5lL4/VMNbs+Y0x1SBCrkCxPqvL4tbVwAxEDR1Slza
	 Hg+28OulE/SuXbuZ6zQ6l5TFo+H/xQiKrLA3IcyYLgo52W/qRQ0kJFWPt4rwHyxcaVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aC6GlsS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E83606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aC6GlsS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E52B1F008A1;
	Sat,  7 Nov 2026 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048018;
	bh=G4RlYcLCFMGnO/d8bvfe4mTsrhnohjESOurxepcHRfI=;
	h=From:To:Cc:Subject:Date;
	b=aC6GlsS9oTJkOMko0HiIxY17zfWeYhMQlWfUJmXGNdC2Zq1fMZQIg0QUAt5ymaIl9
	 D7DrW0ZYhO664lZoksKw8wRHeh5Ujmj9pEaAYYiek4wqWV84fVnzZ9lxRkgeOSdLsE
	 tKepCoJBPdnBQtP1bL96AO1Rx2ucKfu3Sl6ojw0GwYTILzhn0beRLhjveJCKOvMGYh
	 NYW30Hg95Y0uLmh8mI5qtdnDszaRce3JDzcaGzRySCMJ+/QvudDLjE7Awwl3XVhlXU
	 vlyI4c0Ei/Oi5JEHtbuBm0G9gOV77pnDIBVVlKNs7bcOt8phK2iu3ox5NZhjN+uw3I
	 D9RQ9bGLia+uQ==
From: Sasha Levin <sashal@kernel.org>
To: user148783812897@gmail.com,
	willemb@google.com,
	kuniyu@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: limit priority VLAN untag depth" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:40:17 -0500
Message-ID: <20261107054017-failed-6.6-d3ff07f5acc5@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d3ff07f5acc573e5f72bf1c581bae5d05191ba61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054017-failed-6.6-d3ff07f5acc5@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




