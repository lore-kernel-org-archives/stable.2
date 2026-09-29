Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152764FD7B2
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688665; cv=none; b=PfcNv37fBo7AZq2rA8N0K3D8lhV7W/raspYz6O1a+7yoJI8W6Cxg+ii4oRjnS5ye54jEAVRsW4femoMHWhaaVwCiezdIVP8aK8xLOTvBNq8ztX+hDadoINarvowRwPuSB32xKbS6P338xmSlSGK9D5XBM74eDGbBtjJ9HH1O2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688665; c=relaxed/simple;
	bh=ICHnfv/+N14pe9big3Ozyt5lR9DDXGJbkSaJZHPa2Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxpa/1wRhC1WPb0Mh0w7930k+ciqBusdtoDhOe5CZpzlpwIwyCREy5PXFbNb2NjtDzSZIzs98nxJXFnKb49WIl4XXVSZtjgrBVz8BzEbq1EeZ6KMF2FGFm19zlgJWfbkTiybXAr0miFgTaoYULetOJhZbCOevcMLkSre2KHIwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyuRrwhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyuRrwhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD7B1F000FF;
	Tue, 29 Sep 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688663;
	bh=FHP9CNSvxaasoRhUM7qdpH/sSl7CsSsV2V+u9wyPnbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eyuRrwhmdOvUnKm7659L+6ksYE7jp8mPOx99FPRPQAeBq+bN+npvDbYaq3KrFWMaz
	 jumljrILjDnirQtFjTTYPUYok7I+68OPrR4GdnHI6xnVurDq7EYGtnDSYGy1NnsSsd
	 x7s0kA/CEGoO3wTujOZm3K5Zz3t0L0vMggFEbrb8zsrS1fONW6Pc03ZEf624cQ9ra0
	 /A68epP7/GKinJaKNg2rMkrsj1B05P0j0N6+v2VyUiBE1qh3V717h4MLHV6QdC4dNK
	 q0ay7nZb/PboGPC6m5JtGnxiRZs/h84KShY1fr8YRSvfIvT9dqeh9w2yWi8M1dcSfT
	 obBycigi1JfGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	co+0ea1ac045375cf05@bugs.sh,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 29 Sep 2026 09:31:01 -0400
Message-ID: <20260929133101.3502574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092953-quaking-spotting-8e6d@gregkh>
References: <2026092953-quaking-spotting-8e6d@gregkh>
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
index 272d9ad739607..1cab62956589b 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -356,6 +356,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 {
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, VLAN_HLEN) < 0)
 		return -ENOMEM;
 
-- 
2.53.0

