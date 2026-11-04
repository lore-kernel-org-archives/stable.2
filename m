Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818745;
	b=4r658GrFWWGV7xB2nOZzgF8l8SkR/YfYx02FN88qxL4REOyU9DPpKk67HA0LACoT2wWh
	 w7rZqv+rMmFmNb00jeITig6x4pGVxgotLdoVJkevR8T3vkE5rqziaRofopiZ3VexLFoau
	 0JnY16L60T5Bz+fA7l7hQzMBRKQv6VP82OtAdmJqxg6ka6cIngqJXM9bIb0EbGDZhlubm
	 rXHUQ4bnh58QCz90KQqER7s0fkBqo5asgN92m6jiU0PRapWHTmICHCNo4dlieZK9vgB0L
	 wstsz/MXaR/uPHFsp+08QfAIMoau/ipDnJUAM9nVUJ4QR6+UyEb5StefvXXOgBEtjUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818745;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4ukJYfRDFXxFwfJtQ3yOs+UM2ynMHxgoD5jaNRXARHo=;
	b=kbw4tW4C/N2bJT0B/KR0ooDTVV1NOcYVx+2pIxk60DlCwNX5GpZ8l/hoxXPhT0S1knUx
	 iC+K+gTFlLeWjAJNxU8xKlmET/ZhnCTmSElV3ElBx5yCNEOAObuj4PP4Bwbd9Eonp8idm
	 S04mwA+V/APYnjHJryu/NGhixmDd0bU5r8EkQASRNHD8H0mR4BcRWCUGYEWTlXZ3BASl9
	 91QZC7xTRfmROJA2Swspu8yArC6AqlpHJ+UqybQZwUWqWYFpaG988ueEjioD2iamW9KVI
	 zdItqTk3/jZtfYGUIz5HbVz2EUO1DGYhApBryS31hxBoRGup2uZeSnjMAKiCFbNMw0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ys3+cgyS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A4606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ys3+cgyS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F321D1F000C1;
	Wed,  4 Nov 2026 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818744;
	bh=4ukJYfRDFXxFwfJtQ3yOs+UM2ynMHxgoD5jaNRXARHo=;
	h=Subject:To:Cc:From:Date;
	b=ys3+cgyS9MiegCWiJcBI/ixfESD2cBoKAB+oncAQdmz9Ow2CvXnClX5igSpKg9Vnr
	 X/AMZLR+eCtOpczeE8JslwdVYdhTH0aJzsSx3eoJTefrzQtj02BuJF0XFnIbGQd55Q
	 t7bSvkJ63gIl3inu7taqeagVAzHI64whtaYVc7H0=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when the daemon closes the pipe" failed to apply to 5.10-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:58:56 -0500
Message-ID: <2026110456-scribing-radio-40c1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2a83fcb50f3c25c493cc4389619340fefe9d6ac4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110456-scribing-radio-40c1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a83fcb50f3c25c493cc4389619340fefe9d6ac4 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 1 Sep 2026 16:19:47 -0400
Subject: [PATCH] NFSD: Complete a cld upcall when the daemon closes the pipe

Once nfsdcld has read a whole upcall, rpc_pipe_read() unlinks the
message from every pipe list, so the purges in rpc_pipe_release()
and rpc_close_pipes() no longer reach it. cld_upcall_ops supplies no
.release_pipe callback, and cld_pipe_destroy_msg() returns without
completing the upcall because a downcall is expected to follow. A
daemon that exits between the read and the write therefore strands
its waiter: the nfsd thread sleeps in TASK_UNINTERRUPTIBLE in
__cld_pipe_upcall() and never returns, hung task warnings follow,
and the server cannot be shut down.

Add a .release_pipe that completes every upcall the daemon has
consumed. cu_inflight distinguishes those from upcalls still queued
on the pipe, which the framework purges before it calls this
callback; cld_pipe_downcall() removes an upcall it accepts from
cn_list under the same lock. Neither can be completed twice.

Fail the stranded upcall with -EPIPE rather than the -EAGAIN that
makes cld_pipe_upcall() retry. The daemon consumed the request, so
whether it acted on it before exiting is unknown.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Reported-by: syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/6a99f6f0.2e567484.299ffc.000c.GAE@google.com/
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-7-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 1a9ea6393740..5e7788e3fb79 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -871,10 +871,34 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 	complete(&cup->cu_done);
 }
 
+/*
+ * An upcall the daemon has consumed is off every pipe list, so the
+ * purge in rpc_pipe_release() and rpc_close_pipes() cannot reach it.
+ * Release its waiter here instead; no downcall can arrive now.
+ */
+static void
+cld_release_pipe(struct inode *inode)
+{
+	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+	struct cld_net *cn = nn->cld_net;
+	struct cld_upcall *cup;
+
+	spin_lock(&cn->cn_lock);
+	list_for_each_entry(cup, &cn->cn_list, cu_list) {
+		if (!cup->cu_inflight)
+			continue;
+		cup->cu_inflight = false;
+		cup->cu_pipe_msg.errno = -EPIPE;
+		complete(&cup->cu_done);
+	}
+	spin_unlock(&cn->cn_lock);
+}
+
 static const struct rpc_pipe_ops cld_upcall_ops = {
 	.upcall		= rpc_pipe_generic_upcall,
 	.downcall	= cld_pipe_downcall,
 	.destroy_msg	= cld_pipe_destroy_msg,
+	.release_pipe	= cld_release_pipe,
 };
 
 static int

