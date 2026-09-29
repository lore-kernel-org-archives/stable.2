Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C74446F4
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664008; cv=none; b=d/OsRMgcqDyjopxlaeAhBUo1NUkLXFwmKMcd2b/afD2IDrHlLoccWiP6mR9+k091dKM0yL738dNhiDU9Iju1ctzBofnxaThBXFAqyKkvesFIdXzh20E8D41+hoj6Y55w9BL9HqxkLLQpVADFa0DxLsccD5ZGUdp1kAj2TiY4c8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664008; c=relaxed/simple;
	bh=F163Plntz+8KcS8iMuoxDh3wKNbXOuE83S6iLq0cKFI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jIQTzFR18kGNXA6tojJqax2Drvzl31TIbKsIcCxdgSHbHMBXCs+L2bWOCh89JHkJj1pFjSMo7Ra5S8uvhxilwl4KyiJvMgD2u+lw79h/V9hY19vBD54RK6uIYaFxhfYX77E/qU9uisemME4g8b8k+fqFYksgVzdnKlhELGBQW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwLynYQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwLynYQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633B01F000FF;
	Tue, 29 Sep 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664006;
	bh=lpMvc5fujDO261Br3gzp1f7TkmOgFP1aysC00RzdEE8=;
	h=Subject:To:Cc:From:Date;
	b=VwLynYQDy7FtXNoO+Er5wtsHOwF6esBKKtUq1nRvipHNZG/bue0cFMXqa/Bbq6qF+
	 kwcnIRDaiLlvpoVAMyUBlwkrIzB5S1nP+jiC+vmv0hefheLsCsBgdlgsCjeemMX+Ob
	 tiqFE4HB6a+FiT07me/uUZkqS5k535GKcfctJCCo=
Subject: FAILED: patch "[PATCH] vlan: require the MAC header to be present in" failed to apply to 6.1-stable tree
To: xmei5@asu.edu,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:39:54 +0200
Message-ID: <2026092954-reappoint-enquirer-7872@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ab888242fce4f16f6c4d4c6ec53939ad36aa3b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092954-reappoint-enquirer-7872@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

