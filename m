Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE13CF1FC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692283; cv=none; b=WM3p0bOCnDUYdBrVRrj72kAMcLVEFWk05gb0L/yx9Q6l69YuQU+y4dASuXQMJiSFigNQjcLQHLWuyykzCBGxrnYuZsbhZRvgawE4CxSO7v+jlxo1fqas+4cZPnjkV1c/hnjl+mvKABI3rYUlCTuU+J+6BdAGPZH2RHMfUJOnA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692283; c=relaxed/simple;
	bh=agINWrTkL2s4cUvPRd+TAos57xdxeAsbrQFMvF2CSdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/C6PCDokz43abomOw2Ry/ay7bNVuo+D3OG+yQwHztnuQ3R6b0u96dV1pFoJvJJ6N+ANrJ+Kz5WY8xF2DK2rObZXK/bv6hLaTyFZ9eZX4b3tEu6Kd0jSPwYk1g0mWXnRFCOpvqcErw05p6N1iaoz9DOhmzs3q9BTNcO1u1iVNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEMyFbYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEMyFbYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FAA1F00893;
	Tue, 29 Sep 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790692280;
	bh=aiUe78Ey6BvHTXLsLLWnv5+5FCkeJbIuDg+UZSwtuaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JEMyFbYkHoyjjE5E9pIl3iZLXDqbzeB+gp4otsl2M9IZyOMVu/H3MMNNkyY3RXHss
	 1fOKMHR377VxbyeNk7IPNBzqoGyUB2RdbxRT6Uj4VKCjBaU+YxQ5nuGkcQcaWu1elG
	 zpAbLYNwUOIBF6Q4kKmKsx2+uPA5x4KVbrpae5GXsJMFxFXbGY3tlWYW/TrSZw0DZd
	 8ajkqtxzAAqjUVhEim+ZYf6o4udUqKLVnJfQNB4xw7IrkQ+DqerXV8vz3NzqGwF/bw
	 8qjw2sM0y1A9anNyME2GVsi2kk3B5d46uN0M2aVxB8o1uBomT8H00pL9R6OXZnjPpb
	 eqOxHw9K2myMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	co+0ea1ac045375cf05@bugs.sh,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 29 Sep 2026 10:31:17 -0400
Message-ID: <20260929143117.3597704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092955-unharmed-tulip-a8ef@gregkh>
References: <2026092955-unharmed-tulip-a8ef@gregkh>
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
index 3728e3978f833..2759d38466663 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -346,6 +346,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 {
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, VLAN_HLEN) < 0)
 		return -ENOMEM;
 
-- 
2.53.0

