Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7F4E56CC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449968; cv=none; b=otJ0+yZ9bffjOpXqwjxfgucBN+sOhqhimJlUwBjFSjVETy0Aul2zxA7pT+MQ/xRIbdXzo2I3GByycExj1qLJDHDV1Ukete4QRX35w4lylVYHz/rY1jR7s5rYhgsdavEIs18b/r7bVcjX096/YrzcbjFmCX1ny3alGJkquRVTPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449968; c=relaxed/simple;
	bh=V0pb3/RIBeJTUCEw7jcKamTSw2O6MHTzsFA1TELb8bA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZWrSl2QCb+C1YBSFhGM5p3/nJppP9gKPv/4hLe/c1xphNWs09vRHcMbNPkaJEx8z+Ozr72wEwZs/fgNztvQRiL7p1aQEn8rSkKSlfJOLAU972HfySBPQm+YNsIIYGp04dgLzaXrVgtkjUf1+iZEs4qbkdpGJyZJvxCEK2dfyupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TsrEmbK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TsrEmbK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BED1F000E9;
	Thu,  3 Sep 2026 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449967;
	bh=03yKDdJpysS+1eZRB62148fxN1QEcUAq8RxND4ubcoc=;
	h=Subject:To:Cc:From:Date;
	b=TsrEmbK9/aRMnXMyys7h5K4N+XBkz97ftg9hCp+hVlyB/H/LE7py2ZjTAKgMznnlK
	 Mn+8uOeq0gzjCoApdemTMVdrkRVgFOsmzGEY/oKr2PdiAqI0H/EOs46+g/stousPDz
	 MedPmxfVoxjcIhq16zPU6hJPJLY3IQyTpSGGWL24=
Subject: FAILED: patch "[PATCH] net: skbuff: don't skb_tx_error() the source skb in" failed to apply to 5.15-stable tree
To: norbert@doyensec.com,i.maximets@ovn.org,pabeni@redhat.com,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:11:21 +0200
Message-ID: <2026090321-bagpipe-overripe-485d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8ece906150128d5ec2462aabcc978c568433eca4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090321-bagpipe-overripe-485d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ece906150128d5ec2462aabcc978c568433eca4 Mon Sep 17 00:00:00 2001
From: Norbert Szetei <norbert@doyensec.com>
Date: Sat, 22 Aug 2026 11:13:47 +0200
Subject: [PATCH] net: skbuff: don't skb_tx_error() the source skb in
 skb_zerocopy()

skb_zerocopy() copies frags from @from into @to. On an
skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
operation on the source skb the copy helper does not own. That completes
@from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
SKBFL_SHARED_FRAG page-ownership marker.

Both callers already report the failure on their own drop path.
nfnetlink_queue does it at nla_put_failure, and Open vSwitch does it in
the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
dropping it here.

On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
this error: do_execute_actions() ignores output_userspace()'s return
value and, unless the upcall was the last action, keeps forwarding the
same skb through the flow's remaining actions. The uarg is completed
while that skb is still in flight, telling the producer its buffers are
free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
still handles. That flag is what makes esp_input() call skb_cow_data()
instead of decrypting in place, so a later local ESP delivery can
decrypt over frags the skb does not own privately.

Leave error reporting to the callers.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/6E3A780D-FB87-421F-9964-B1D457D7D106@doyensec.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4382b68d56e..ab3d161247b9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3914,7 +3914,6 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	skb_len_add(to, len + plen);
 
 	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
-		skb_tx_error(from);
 		if (j > 0)
 			put_page(virt_to_head_page(from->head));
 		return -ENOMEM;

