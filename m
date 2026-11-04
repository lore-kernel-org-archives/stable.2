Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818743;
	b=fF2a3qBiziPT65qwQ5Od6F6vJWhJozGbxI+dlz/FTaTw97A5xuWd2sGmuX9jEJ408fDO
	 HGxDsbO263pDFZ+pWuGlD02/LPhlNZUABHy0L2OKGzSTcMtzeRo3MTIHSYfPHIaukbWh8
	 1r6cfBu8MfpsCk5fpZVNTtqT+fbotPxq2aAeIPIGdfGMqfrYyD8PduKRdDVQDS8KSmlWq
	 rv+zbkbdvSArMKBH6ZAe0/mf7knhyc4NG7qv5SN3F8M4bu3YWkjIYA+uEWvsUWR/DhmYR
	 ISg4xgwD5lsKJhckFhTOkcdz/sI5rRSZqZkTfzyNk8LbLOaE+6WYHyhm4iztdZQxGPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818743;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8hYJy+FDmREqp1HUXpI7U7iLZmX7Y8hMzYwI9ye29LM=;
	b=5p5FxGWwRh11JKDYuOBQNn0UzEDhWjiZ7NF6lJ/ncSGSKqsLcDOpUd1mWuWKYaRaC4Sz
	 PLCbdRCUwEiQsSYRZzNPFJP/jLIT5YCZVHAfEG55e3WaA22i4f8CUKiG5gZlmCYgl4g8k
	 hWX+LKEyZOkND3L848UGG7JKeVG6w+UFA5G5LtIBT3pGERS11cRsYuASdHp1BwbiXRI71
	 rOUCS4qkEkZ9WFHqil0xn/tG7lkB/ddlQr1IoNijh/1bZaoGe4RX+hRkvH2kdzYfcyDHM
	 BUcuwec2/gycvH53dVRxqSlkT4g6PkiNET2J/wjMvb8PEzaBrI5nJHp4hKtlKhvs4IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vgYUhrMj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AF606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vgYUhrMj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AB41F000C1;
	Wed,  4 Nov 2026 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818742;
	bh=8hYJy+FDmREqp1HUXpI7U7iLZmX7Y8hMzYwI9ye29LM=;
	h=Subject:To:Cc:From:Date;
	b=vgYUhrMj0gH6nx1Ha9XKrBPkYNbkKWnNeBp5rkSHwJCGgWhptk4FPKEDQKO3bPtkH
	 EeEY8yaAkVOrhjn3ui/CQ4UUa9rcx8IDdqUq+pKaLx3vTmCxBkOVNT6nW3TGy7X5/k
	 0n/Ugh6eY0C2kaaS3APBzkRNYO/wzuNhzdrDKK/s=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when the daemon closes the pipe" failed to apply to 6.1-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:58:55 -0500
Message-ID: <2026110455-splice-wrongdoer-64c7@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2a83fcb50f3c25c493cc4389619340fefe9d6ac4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110455-splice-wrongdoer-64c7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

