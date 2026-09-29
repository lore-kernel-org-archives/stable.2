Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627A50EC10
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685976; cv=none; b=Zarhd2c/miQMzmSBOVxpbWhxscu9D4VZZ/gUpVE4WCS3LigxZ81Kfs9BXJV9n9fW7Ug9dQJlFYDcoUIjh5XqFUoaVIPIHhcYWqZ33zg3CAQUen/rHaBn/gLjI2cVovaI/4X5KXLKAYFnoek41OiIEaWZxgmnAdydw7HQc991K94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685976; c=relaxed/simple;
	bh=fCf6HPniaKxWE8JP/uTAZEU+uyjaWdBIQJBO/n5dLmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMREvV4VEbCCrbCBltC7CFY2qwYo/sBkuCC7j1SxaGbfbxwWpkzkSLyLFjf4mY8JuO+W4sULxekxbEo1ruF1vQBwM7vFuUVlEyDee1AANEq5v1hb2Zm5V27SRyGFSrfG47wuuJ3BJV78nh6z/aJb7ucYvexSPb2XGc6NT949uUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDdiKpAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDdiKpAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4341F00893;
	Tue, 29 Sep 2026 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685975;
	bh=93t8tmwEGcQkdW1y/G7cAYChvX37GB88yepGaMJ7bwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TDdiKpAWQnAIAF/ElkLo+CEc+BOysaamKKbD+EWB4n408/kJAKwjmpbgGTJ8yZWKC
	 8s+EzMKUrlmfQyZYIA3rZd4i342cxKMWpfatFMoMB/IVdPj5LNQo950SP5vOqjOnvi
	 xciLwCN4jpTNwMwG8FjhcNiGCqKO7kJFELlck5EqCkGUj81gR43DIEc/a3QkguONWG
	 c0tmGwPH/rDzDTdU020pFsKdA3PtwZi/Rmuxeq0bwuzvaCdHenZc9wNVCRBBcGK6t1
	 sgOaZ+N83pqLtA7FQxUJM0gDaYKCxVTx6E7R8UAV6yxMIuvJmGnwrNDRj9JnrEP9Sc
	 4nKf3JsBKR29A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	co+0ea1ac045375cf05@bugs.sh,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 29 Sep 2026 08:46:13 -0400
Message-ID: <20260929124613.3452956-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092953-anatomist-taking-b440@gregkh>
References: <2026092953-anatomist-taking-b440@gregkh>
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
index 9551dba15cc25..d403ce386c707 100644
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

