Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942452268D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684702; cv=none; b=IFEOwAkQfSoWFiKHm2KEswYfr1urlF765cmQKRAfu2K81C1zSfOQ7Dwsg0sy1fFpMZc0x57AogPmTYL7fDpx8KaaDGNAz2t3r5MCu/58m7ByMXfrqZu763KzSn7tyGBPHyGz7VwP2shc/4r6JDxNNCMXxcGljenOL+JMMTs0V+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684702; c=relaxed/simple;
	bh=LTbJ4cq5UfkSybM5bKvMWmlf28HQy+Dq3g+pFkI3+JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOKKL0RfTk4JEkXA0ERz//Vd4bjX7lNzfbo03GsOrlREJf4gDlgcEyJg9NYKl5yvl43fvJvybgfyL+ZBi0+su0R+widJw4+rLZoJFNNZq8TgWsDnaiEfQY0DMcfC4bhwuHJ2BgfdSqcyySxpg4S9KfzW7rhTuea3+NgZmdM/UbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1oxjc9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1oxjc9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B78A1F000FF;
	Tue, 29 Sep 2026 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684698;
	bh=466VudFnLBxXUOhQ4WM0+oIBlfaPclBvIMTk51ColW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1oxjc9MkAz6usVF93STCT1Yuir+whXGJyEfL+qaHep08N06W35mylcOW2oBrW4Zb
	 dIXsuajiMQYzY5kwRKAO0NY0BPjSYCspB0oOYdqG0B6wXqDHk6fOhNmt+eqWdNrhC2
	 Xt8LIq7eqRrU+G+P2nNLuCpycxrxrUHGkrKUKkNqCcd6nqY9U/yHLObTb0lhl97IOh
	 0FdIshITn8tfPW+2q4iepa13DKH/bwe0zxtOW804UASbx8/OGoS2+tOrmKepUxYu9P
	 bH0dJfZP7KRckusCs82jc5fI1ui3v9FrKj/rdy80dtLUUqrQq0ZbZRo8xA0grgcolN
	 t1A25lyMQYg9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	co+0ea1ac045375cf05@bugs.sh,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 29 Sep 2026 08:24:55 -0400
Message-ID: <20260929122456.3382282-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092952-trillion-quadrant-6e27@gregkh>
References: <2026092952-trillion-quadrant-6e27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit ab888242fce4f16f6c4d4c6ec53939ad36aa3b3a ]

__vlan_insert_inner_tag() only guarantees head room via skb_cow_head(),
never that mac_len bytes of MAC header are present.  Its ETH_HLEN
wrappers - __vlan_insert_tag() under skb_vlan_push(), and
vlan_insert_tag() under validate_xmit_vlan() on the generic transmit
path - therefore rewrite the first 16 bytes at skb->data: a 12-byte
memmove plus two 2-byte stores at +12 and +14.  No caller supplies the
bound, while the pop helpers use skb_ensure_writable()/pskb_may_pull().

An IFF_TUN device has hard_header_len == 0, so packet_snd() accepts a
one-byte AF_PACKET/SOCK_RAW frame.  The first vlan push only sets a
hwaccel tag; the next - clsact "action vlan push" or
bpf_skb_vlan_push() - enters the helper with skb->len still 1.  The
head comes from skbuff_small_head without __GFP_ZERO, so each push
drags bytes from beyond skb->tail into the frame.  After three the
one-byte send leaves as 13 bytes carrying 11 bytes of uninitialised
slab:

  0000: 5a b3 62 12 80 88 ff ff 00 b3 62 12 81
           `------------------------------'
  only 0x5a was sent; the rest is slab, here the top 56 bits of a
  linear-map address

Require the MAC header the helper rewrites to be present, so such a
frame is dropped rather than transmitted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: co+0ea1ac045375cf05@bugs.sh
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260915083152.705309-1-xmei5@asu.edu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted context around skb_cow_head(skb, VLAN_HLEN) because the branch lacks upstream meta_len handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/if_vlan.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 15e01935d3fad..89472ba4425f0 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -357,6 +357,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 {
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, VLAN_HLEN) < 0)
 		return -ENOMEM;
 
-- 
2.53.0

