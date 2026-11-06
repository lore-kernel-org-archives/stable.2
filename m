Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968642;
	b=pODDdkGe5dIuoO7x4pFcNqerV5SUBpl5omp5Hg84IGjjREQiDsHXwo6RTqFMbj/ioh0H
	 DXeXLSn80R8IgDCs/RwrPvkfrtARYIktMhG/C2On9W9Mo6P3M7Uob5xfi2LDXvucVDBjO
	 WlTrBuGBkMRkKiqZg43rHI6MjRRo+ietXHLl0rlPgtYYZg6Aj1HfiOazaRH/YFBfpNk4a
	 iYPt+jsqzJnp5c4XI2JmcoKROwuXhCydfWz/mndwN7Julj2VSmxoNoVgg6ZZlQwDzZrvl
	 WfwSrKbBWvTj8/epcKmY2Kau2B8AB68EVKzcEryorg17E6RdHVW2MTFBl5sKqkeCBjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cA0GxN44Ukze796NaYJVAbnSSuYugauTH3UBvHdVUl8=;
	b=TSwbmlujrfMTNyIcqkq44q+baUAFNaKpe0q1ukdmnNefMRbxYOXsFxEvkq2gag2vAzh5
	 7RkIlUT9rBR9U7ONKXH9lwDpK8vAXvuXCAm7F17dleH9Plna7OsvBFVEXFdYsrK4oTZF5
	 rZnLc0baHD6+vkrzQNUqsTXFQfMYM9I91QaZv7r414XxTUy8ZH8xLO37hhJvu4CxS4A6h
	 o29hBJ8kLd3Tnh26j/bjbbiTl2qv5sy5QdGEbZ1oJJd4AbEBpTARM4iKd5hzlv6gYcDUl
	 adN9YKm3yM9faGgwn7asEWswItqApbdFXk3a5sKIUz8VSiU1neKzDoXB6t/6HhDbe4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9s3kkJp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E16606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9s3kkJp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038C31F0089F;
	Fri,  6 Nov 2026 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968642;
	bh=cA0GxN44Ukze796NaYJVAbnSSuYugauTH3UBvHdVUl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I9s3kkJpTn2NIrS1zpKn9yuR+Ui0M66KU+zFNyNSdmwcvd+BtIJrZKY5z+7jRsIYo
	 FrjUm+YM0CVCUYzi1yssIW2Hy3hrM55nqKd49HvAMWix14H8/jA0OVykkuuIUfM6tW
	 C6de8n7rJE1GaedRaVvbraBHJBUDrl0hQkWq8wKXgdsLC87cbfKTU6/r9UFegzhuQh
	 4vudXHTnMehprnrtIztsnpcDiCT76IhhgVFFGCLacxHYC9LJ0y5icboqcliW1aIOs6
	 k86ZW/jkJVMaVvBxTPXBmW/14KHIFhJu8yIQPWZYC/3eUA9vp8rDPR64y7pAb8Q//+
	 UTaAn6nQfXqrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] NFSD: Complete a cld upcall when the daemon closes the pipe
Date: Fri,  6 Nov 2026 07:37:20 -0500
Message-ID: <20261106123630.4042374-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106123630.4042374-1-sashal@kernel.org>
References: <2026110456-hypocrite-villain-ea3d@gregkh>
 <20261106123630.4042374-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 2a83fcb50f3c25c493cc4389619340fefe9d6ac4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 274c6e0aa60f2..4dbf1e72c1232 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -937,10 +937,34 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
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
 
 static struct dentry *
-- 
2.53.0

