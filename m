Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E160443E094
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664003; cv=none; b=ghVQIuNjTlAxJsaO2lmxGWl523D+9xcLZgV61/8HQtaujBiytPsvpdduMg/dugB8oLVOqg3DQSqQtKlRPPhQEJ3o3KEpHzRhEcbitzoE+s6CdlFlwn4N0WE+pLYq6ngSOsaahkKwjmeiqjZoBGUIt0O50dFfale9xq649bf7MjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664003; c=relaxed/simple;
	bh=hBfk2U3RCBThsUKuWD3mxCWcd14xlLOVCwktyEhMnkY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CVzvxSR16lr6QtRTkohjt7Q+HdOpDbreCuMLwIcBuP/dGDxbSkt3520uI7C2n5PEEJbJrvYotUE1Q2yU2SEu3qo2UiIuZIMDiYZMRGNvo6BCJ4tc4y5xS33Fk+9ZmORak6UplbtHMJU1vaefNnn3GEOdq0xsdje+nDM5Dztv4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qMEzStfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qMEzStfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4EB1F000FF;
	Tue, 29 Sep 2026 06:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664001;
	bh=IXh5ygnQabF5w2INsdKiXxOdK5Eo1qAEtWpM/JAkhjU=;
	h=Subject:To:Cc:From:Date;
	b=qMEzStfP7a36kknn39b69RDTVKNXgbdPvEX0kf298bf1jMgAam2DvkSUm3ID09LlD
	 Nut4r0StnnoC57fgNu1hAqjUphM7c2l7FZGalOyUwRxR4mqVbjVTLZm6fLgKkSK8nx
	 GYubylBYzs2TjwNByFxewHF8/atldpTC0pkW5XxQ=
Subject: FAILED: patch "[PATCH] vlan: require the MAC header to be present in" failed to apply to 6.12-stable tree
To: xmei5@asu.edu,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:39:53 +0200
Message-ID: <2026092953-anatomist-taking-b440@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ab888242fce4f16f6c4d4c6ec53939ad36aa3b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092953-anatomist-taking-b440@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

