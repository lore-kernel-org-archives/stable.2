Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EF5111AE
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691165; cv=none; b=On/OYpHYCOAEBK4YRshbmCrCIijjUt/hBW7cB9Dg3TFjteLyczzjHNUOkGa4ywl6rznyeKjLNnPcglVyqlTVmktb3UBsGEtwjywsoL6Pl+OtzUCh+RhL6cWQzIN8JLYbCc4YQ7Im3fZujjiCDgfg0OhVHZ3WQ7YoTyJbMhf2JdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691165; c=relaxed/simple;
	bh=agINWrTkL2s4cUvPRd+TAos57xdxeAsbrQFMvF2CSdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLzDv4YOuqHeBsrp7lt/tsF+viLIJUSQDTLW380x/SUIcrplh+TFLV/loUlfu0uoiz7gPVnvbTymO4Gk3ADo/0m7ktpYL8UuXKtd81hy45kB2aRfGuYdILCugDvF8Q22xyN5rkzv3tl5uOO5yXZ9BeyCMobMGqlRPZYOEh8HpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+jnCW1M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+jnCW1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C136E1F000FF;
	Tue, 29 Sep 2026 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691164;
	bh=aiUe78Ey6BvHTXLsLLWnv5+5FCkeJbIuDg+UZSwtuaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+jnCW1MCwKHxelzz52cbLipFvt0J3kM1pB3zdX7XzKdsoadoNE094sHhfFTHOXsv
	 1Ah0EMJc9KgMFCSMl3RR/MNXzEJ8mcbIx21a/EZ2K2Nm0tN1jLo+iQof3U8j7UTqnn
	 8Pd7IKavxqOcmzJyLcLqhHL0tx10ASMQGVWfpRYukokIvhH/WpK1JHzbCXAFhdXHbl
	 vmOp9W6TP29KLYi6HMglZrTpA6cZ7FNRX/V8h9GIamZ5QGhVQkBDU1fCnKIBYcM3i8
	 Zwki1mWIrKNjkAZ4n0/K9et0hLXyL9eLgbEXRmYNLPawCqyZQA+DZIoZJWv2uqHrh+
	 EUnZP2SdrlMCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	co+0ea1ac045375cf05@bugs.sh,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 29 Sep 2026 10:12:42 -0400
Message-ID: <20260929141242.3537639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092954-alienable-pointed-d2ff@gregkh>
References: <2026092954-alienable-pointed-d2ff@gregkh>
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

