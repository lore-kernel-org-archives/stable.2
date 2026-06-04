Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2753F54DA
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569037; cv=none; b=Z3KExKbNSm1PA6bKcHoC/yJcKiKlX6xN7CG4ZzzxUv7aUGy1cRvVI3ONJuDIe5KntHz0juuZVtQyYzeU75GQPW5Zeko0/dDcjg9haanNVqaun+Au35qFzZVFAUBP8u/zUlLf4JthzVEgPCp53xWY4G8URp5aWB1h95lNh+RqRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569037; c=relaxed/simple;
	bh=xhsuh5pZK6Nm90fxkhOphFhVANTN4hmopigT5ySs4Lg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CJbDQavFDUHL0MJtdVD99IIggDe38GarorLjutLFVGWLvhmAOtHlrcuaen+4KOJTAeryxA3B7AdIk3xzfnwKuNPCEha8LYAl0bUC0QomSmruNKmJv4pPw9U3aq9mBjy0fQLMtypheoB00wy+oP3eJE0b3GFE8S05UwwKwfzAFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qC9sSaq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qC9sSaq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841751F00893;
	Thu,  4 Jun 2026 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569036;
	bh=FFjB5MmwdsOUbc4xHzJoBubqrx84G7iHUNMkDl2LDck=;
	h=Subject:To:Cc:From:Date;
	b=qC9sSaq3yPe5Nm2bV+/wMSuNyR877Jp3nQ9xnJDEco3zOXAalhJD0dInz1KbFparD
	 ArGG4bW+R+wGq6u2LZfKkaZR41NhV2MtenEkaAIHYutqwqWkpwQg2YlD2RmrZdOAO6
	 yhsqgMLIxinJ8ZGoHMP8uA2SyrmBezcobWiS+s1s=
Subject: FAILED: patch "[PATCH] net: skbuff: fix missing zerocopy reference in pskb_carve" failed to apply to 6.6-stable tree
To: minhnguyen.080505@gmail.com,pabeni@redhat.com,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:29:39 +0200
Message-ID: <2026060438-bullring-defrost-cf5a@gregkh>
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
git cherry-pick -x 98d0912e9f841e5529a5b89a972805f34cb1c69d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060438-bullring-defrost-cf5a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98d0912e9f841e5529a5b89a972805f34cb1c69d Mon Sep 17 00:00:00 2001
From: Minh Nguyen <minhnguyen.080505@gmail.com>
Date: Tue, 26 May 2026 11:12:39 +0700
Subject: [PATCH] net: skbuff: fix missing zerocopy reference in pskb_carve
 helpers

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
the old skb_shared_info header into a new buffer via memcpy(), which
includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
Neither function calls net_zcopy_get() for the new shinfo, creating an
unaccounted holder: every skb_shared_info with destructor_arg set will
call skb_zcopy_clear() once when freed, but the corresponding
net_zcopy_get() was never called for the new copy. Repeated calls
drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
TX skbs still hold live destructor_arg pointers.

KASAN reports use-after-free on a freed ubuf_info_msgzc:

  BUG: KASAN: slab-use-after-free in skb_release_data+0x77b/0x810
  Read of size 8 at addr ffff88801574d3e8 by task poc/220

  Call Trace:
   skb_release_data+0x77b/0x810
   kfree_skb_list_reason+0x13e/0x610
   skb_release_data+0x4cd/0x810
   sk_skb_reason_drop+0xf3/0x340
   skb_queue_purge_reason+0x282/0x440
   rds_tcp_inc_free+0x1e/0x30
   rds_recvmsg+0x354/0x1780
   __sys_recvmsg+0xdf/0x180

  Allocated by task 219:
   msg_zerocopy_realloc+0x157/0x7b0
   tcp_sendmsg_locked+0x2892/0x3ba0

  Freed by task 219:
   ip_recv_error+0x74a/0xb10
   tcp_recvmsg+0x475/0x530

The skb consuming the late access still referenced the same uarg via
shinfo->destructor_arg copied by pskb_carve_inside_nonlinear() without
a refcount bump. This has been verified to be reliably exploitable: a
working proof-of-concept achieves full root privilege escalation from
an unprivileged local user on a default kernel configuration.

The fix follows the pattern of pskb_expand_head() which has the same
memcpy/cloned structure. For pskb_carve_inside_header(), net_zcopy_get()
is placed after skb_orphan_frags() succeeds, so the orphan error path
needs no cleanup. For pskb_carve_inside_nonlinear(), net_zcopy_get() is
placed after all failure points and just before skb_release_data(), so
no error path needs cleanup at all -- matching pskb_expand_head() more
closely and avoiding the need for a balancing net_zcopy_put().

Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260526041240.329462-1-minhnguyen.080505@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d247acd447e4..0d3cc115f2e7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6833,6 +6833,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			skb_kfree_head(data);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6976,6 +6978,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_kfree_head(data);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb, SKB_CONSUMED);
 
 	skb->head = data;

