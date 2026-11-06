Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933969;
	b=4/3h8l6/7yp4TChw2ePCnqoNJGyMx1YKjwfvGihRWDb8h6T/1JyJk8IvGUvw0su/V4XN
	 uh7Oyk7j3OJYDuPYQufNrnACQjKusozEbolTdcbTW80pYBrwBcROYtH4AJFYm7s1kEWPp
	 uyAinLqXOddGE7B60SUwyPew3Jcca5Q9DIzwoMZ7q66j887Ey6fNfnY5poJD/hk8ev1Tr
	 PcnXX1XQhJKMWs647OI5GGUmP9vFEHZ9DALWV9f3MmHk6wndE0ZOrnt4FSpHArxjA67/d
	 YKJW2F34xTJQDfh0B47MMwJyosNWDyQz2uNq3Jkut3XEJT6+8n8FajC26JbnQ5JRmxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W1T6eXTnP023xU65goPLgM0Wr3GKzA6hUiUtRy6uurU=;
	b=YPtzumjS4GEr70uaw63wSnsVkYqKzalGYJNMJqTOrhLkSoC9/Lwt4j3y3ahRsb2/vAYw
	 5k1XutWe76M5egdph8eA8GW/5eB2f8kl5m0CoQg+PViG5epEujHeXMjpsA0f634sU0bPK
	 3Rs4U9SosdxZg4MymDNqtkgcaTxj5hX/4xx+wdTrDz+qCD8HUONUH7xz+bn1rCu9XxaY2
	 QH5hHBnYiti2cd/0RcsQKsUitx0UYheYByk4Ohgvuo2jTSAff31eUgkmWwcqjOrA0WukV
	 xOhIbJSSA7mMr6j3UYl2/j2bmApCEV3IMRdR9nxZfFs2WRguNmGpX241Fl5qpGfbY3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+r7ojfD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1A606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+r7ojfD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CC11F008A3;
	Fri,  6 Nov 2026 02:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793933968;
	bh=W1T6eXTnP023xU65goPLgM0Wr3GKzA6hUiUtRy6uurU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+r7ojfDWEgwTZGqjhs5tTlkXNoniWlW02erbgo2hOZvEg6kAnP4ln3YrPpGz7QwX
	 BaOs1rFcOFI1FlBhnUWxFPbNly8qVZ/cTd1O2maF+eOe3mgiuvDkEvHzq0KZJuNQYB
	 F8/a5K5BLRMWxZnrBrF7wZPQivk9C5F4hBOCrnBVPQlWrpA2MR+0yWsn0gKBNEkRis
	 RWBO/USjEC/3/lTcn8/smhacbN9KMkLrpKOUAs3f2oGRFV2GJVJqceYUHdr+ZtI1lF
	 I2PLEJcK/U8GVWfBl1X7FXC9Qj5r1X5nni80tIEQIcmgUo3s6HK+SPuNm6vG5PgRjc
	 A8f1COPZJnLlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] NFSD: Complete a cld upcall when the daemon closes the pipe
Date: Thu,  5 Nov 2026 21:59:26 -0500
Message-ID: <20261106025913.3959182-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106025913.3959182-1-sashal@kernel.org>
References: <2026110453-devotee-unsuited-ab14@gregkh>
 <20261106025913.3959182-1-sashal@kernel.org>
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
index b493bb059a8b0..9c7f6d90a1b99 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -948,10 +948,34 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
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
-- 
2.53.0

