Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E03D811B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541229; cv=none; b=XyBbwEZb4R8EzTUvHwpV9Gp1buX4uUw2/nlv96ntH/lhzGx8kkExFCNXsFhcs3yGquAB9oS9V4515EiEKPE54ioOrGm+dYaIj+qVZuIwP2MTFpXRg3pNAfP5rlLXOwF2ng3XdBcf2hMKml91HxXfDvBEscofX0moxtd0DRB2PBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541229; c=relaxed/simple;
	bh=Tw7rd+H2w/3KiEctfx67D/UpF/MPhI23ON+ZZL4kjJc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cM77nK92uIvs/fpDpUum4wfvPqAiV/gtdSJM3a/NruD+8UAmlfSz6z+PzzpzTFTP7k4f1nmYf/GhSnXD6IhpP3WaoReBMkHHGTeDwQ+Xo04RIG5fz3dWnRWzNYswVI4NOpCna43w4mpriNFM7YfW5TqAPapl6vS3/R4KUpVgmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HAMr3XdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HAMr3XdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A5B1F000E9;
	Mon, 20 Jul 2026 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784541226;
	bh=xxsSnmFKsiT+0pyplJJf0T0c2otYIjZiWID+yjHmZ/g=;
	h=Subject:To:Cc:From:Date;
	b=HAMr3XdZ9hGDOTgQE65wOgVbk+cK0gy2kybmwqYN37hIlIYaX3KAhlt+WFwqFNDoT
	 8GP/Sg0cmjsWkB/I/YdDBOhZi0QmlI33RTTjsl8RAV2G4JPncWMfNM252f/fsCQR1y
	 6Q3xYaccfWqob0cXslIbgjfuH2byy/G2gLMw+zbI=
Subject: FAILED: patch "[PATCH] rxrpc: Fix socket notification race" failed to apply to 6.6-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:53:24 +0200
Message-ID: <2026072024-devalue-womanly-8b22@gregkh>
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
git cherry-pick -x e66f8f32f50116670dbbee5bc9e692cd2cd0c8f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072024-devalue-womanly-8b22@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e66f8f32f50116670dbbee5bc9e692cd2cd0c8f8 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 24 Jun 2026 17:38:16 +0100
Subject: [PATCH] rxrpc: Fix socket notification race

There's a race between rxrpc_recvmsg() and rxrpc_notify_socket(), whereby
the latter's attempt to avoid disabling interrupts and taking the socket's
recvmsg_lock if the call is already queued may happen simultaneously with
the former's discarding of a call that has nothing queued.

Fix this by removing the shortcut.  Note that this only affects userspace's
use of AF_RXRPC; the AFS filesystem driver doesn't use the socket queue.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Link: https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260624163819.3017002-10-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index f382a47c6eb0..9962e135cb73 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -27,8 +27,6 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	_enter("%d", call->debug_id);
 
-	if (!list_empty(&call->recvmsg_link))
-		return;
 	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
 		rxrpc_see_call(call, rxrpc_call_see_notify_released);
 		return;

