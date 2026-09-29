Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35ED43D4E9
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664000; cv=none; b=clXDZUqiow/LFUGwu1t3sc9FIE1WT0gkpF3cVyG7kARa3mUKZmiMddDbRmd21ytVb3fawFZRl9Yh5x55+buakWcC2+mUGN3j5zNKBjbYOK3I976oIkvsgL1bzT7Uml4HoA4QxcZ+B22OjupKkvSKgUX705ZIFnvQyQZoK1mfhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664000; c=relaxed/simple;
	bh=Ha9mg0UWdX+ndNjsjK9LJa4tuZjBrwtU5HkhwrPULcE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TKRsCxiliGyZbKCJrd+BSBm9cDIGHuz9ggAjgkIa3U6x+GQsn1I4Ahb0OK6hckCecqKGmtbyJuOL4VWY/vNjbbUAwfkja13XTjwcXKLOjRscofd3tpkM+HTqlTViq4O3NJ7nyz4B0ZU7c39g4DEZg1x4/BF7cVegWC3XCi+L7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NxZlnTPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NxZlnTPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB821F000FF;
	Tue, 29 Sep 2026 06:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790663998;
	bh=suvgXlmnIpgHoT8FLWuuD/HtgyWjalmHueeF8YV9VUo=;
	h=Subject:To:Cc:From:Date;
	b=NxZlnTPzOk1c/SQ5xpfaxRcjkbGL9isEVoBjiKUns+9hdcF/Sw81Ogj3w9j45tZYs
	 Tch0/GoFzUCge7t4vQVautRJlYluaVLGGSdtePY19zpB+h6+kUuCZiZZWhM4u4fE+p
	 T6pffYanOJpMxNBOO4gfCmEbHeI2N6ZaV2WBKtZo=
Subject: FAILED: patch "[PATCH] vlan: require the MAC header to be present in" failed to apply to 6.6-stable tree
To: xmei5@asu.edu,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:39:53 +0200
Message-ID: <2026092953-quaking-spotting-8e6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ab888242fce4f16f6c4d4c6ec53939ad36aa3b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092953-quaking-spotting-8e6d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab888242fce4f16f6c4d4c6ec53939ad36aa3b3a Mon Sep 17 00:00:00 2001
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 15 Sep 2026 01:31:52 -0700
Subject: [PATCH] vlan: require the MAC header to be present in
 __vlan_insert_inner_tag()

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

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 20cc16ea4e5a..4846032bf4ff 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -365,6 +365,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 	const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
 		return -ENOMEM;
 

