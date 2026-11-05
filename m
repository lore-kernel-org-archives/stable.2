Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886386;
	b=KPpRLtQVBXwK9+KVfpXHTUewZgbwGZaRSh3bku7GLK+Hz8d9DN4HPHdLzLm3WyEeYOgV
	 sAAe8BKhAdMd4L1GXr0GYGIILCk5CErNADVKsaMKRMb0MjYj0LbkPx84vbWd2nJcAxgHg
	 yfEah7tXor4x16pbMPTTCPlGLO1yJndlYTahBm4PuP07wbrlDCNcvdvfzbrJZz+Unv28z
	 SD6imxtVroI9lOZrvCnyIno773drhZDnwrDVl8Hk6ucFDYap1u3BegcpcyI+eR9e56Xqy
	 hjE/FERFLTGEP+lB9p5sicMgDgZLTHiSRAhiVPqGSu+ncvY00KX4CIKb0TS4AqiucVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886386;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E3mTmZnyMqqJl9OWGjOvY3EqOy3aYzC1Zotp62jHhLY=;
	b=SwGw+xcSX6xIGTXYbF/UoJ7G6t75XFOFZKxDTnP/P8RjwQiTokKSIEJ4m80r6wiQixed
	 FbLNMLgE5/skgo0VioRLIMdKSHSsyK5aa4EapWh+H8QIiDsQz3hU9bo3yFAZVP0EXJHKz
	 nGlPiVFeFa6biZlWnoCwINNNX3kk9Mp8psExEGDm6wZLJ1nnpDIlSfkExW2zqdGj0Yc/X
	 rlO+F4gzh/iragIo0dfS7RHC/gc97eOMcf41HU+K1pb+WilzragKhApw0QF8knKbOuEak
	 aR6vb3dfZhtDupk4hmYrD1KLSxFT+FSGda+I+lEnFisR8ErPVQr6fVkLyRGeRUEh/IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgLc4cW5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61313606A32F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgLc4cW5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415011F00A02;
	Thu,  5 Nov 2026 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886386;
	bh=E3mTmZnyMqqJl9OWGjOvY3EqOy3aYzC1Zotp62jHhLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RgLc4cW5eNEFWG1+F6Hr6t8Tuld2Dgaks/IstcBet0mKGMGrPtwZ90YcxCSH9bvTu
	 EMpGsJziDZjhH0bHVKWMeLolmzFyV2IsRd0Jv6ZbrjTJvmrU7HcvBFPcl1naEOpM7M
	 mukE+61sGZkFbTaojB0Gt1Bkih8Fp1kLpgq4feOEbqD5su+2KyG5Pf44ByeTCAuKHi
	 feoY3fXnUOj9XH1liWhEI4LEm0EjNpRLDJ9/WdXJYp0UPsgXDX/tpm4owQBi8ugnK6
	 7WpuHwFP8AyIYOb6OCLDhimJKTT0fifuf2r88F0Iqw5cUTC1qj8rqhoFw6JQn3Zz7X
	 3WADj5Nodmr3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+5c3ed2a0de3270efc921@syzkaller.appspotmail.com,
	syzbot+c2ec61adfbcb24e5ec20@syzkaller.appspotmail.com,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: hold server info until cifsd exits
Date: Thu,  5 Nov 2026 08:46:24 -0500
Message-ID: <20261105134354.1398603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110422-sternness-coagulant-cee1@gregkh>
References: <2026110422-sternness-coagulant-cee1@gregkh>
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

From: Eduard Zateev <hackerowskiy@gmail.com>

[ Upstream commit 482c117c6dbeee382790168af10959810450ab09 ]

The last session reference can be dropped while the cifsd demultiplex
thread is still running clean_demultiplex_info(). That thread frees
TCP_Server_Info there, racing with cifs_put_tcp_session() as it releases
the server crypto state. syzbot reported a KASAN use-after-free in
cifs_crypto_secmech_release().

Keep an object reference for the cifsd thread. Defer final crypto,
session-key, network namespace, string, and structure cleanup until both
the last session reference and the thread reference are dropped. Drop the
thread reference after clean_demultiplex_info() has finished using the
server.

Build-tested with ARCH=arm64 and W=1 for
fs/smb/client/connect.o. The KASAN reproducer was not run on the patched
kernel.

Fixes: a5c3e1c725af ("Revert "cifs: No need to send SIGKILL to demux_thread during umount"")
Reported-by: syzbot+5c3ed2a0de3270efc921@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c3ed2a0de3270efc921
Reported-by: syzbot+c2ec61adfbcb24e5ec20@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=c2ec61adfbcb24e5ec20
Assisted-by: LLM OpenAI Codex
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
Cc: stable@vger.kernel.org
Tested-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: moved thread reference acquisition before kthread_run() to accommodate immediate thread startup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h |  2 ++
 fs/cifs/connect.c  | 38 +++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index be53b788ea4ff..23bfe72ebbdc6 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -16,6 +16,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mm.h>
 #include <linux/mempool.h>
+#include <linux/refcount.h>
 #include <linux/workqueue.h>
 #include "cifs_fs_sb.h"
 #include "cifsacl.h"
@@ -578,6 +579,7 @@ struct TCP_Server_Info {
 	struct list_head smb_ses_list;
 	__u64 conn_id; /* connection identifier (useful for debugging) */
 	int srv_count; /* reference counter */
+	refcount_t obj_refs; /* struct lifetime: srv_count users + cifsd */
 	/* 15 character server name + 0x20 16th byte indicating type = srv */
 	char server_RFC1001_name[RFC1001_NAME_LEN_WITH_NULL];
 	struct smb_version_operations	*ops;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a91d3f6ae5be6..5717d54222c0c 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -754,6 +754,22 @@ handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 	dequeue_mid(mid, malformed);
 }
 
+static void cifs_tcp_server_put(struct TCP_Server_Info *server)
+{
+	if (!refcount_dec_and_test(&server->obj_refs))
+		return;
+
+	cifs_crypto_secmech_release(server);
+	kfree_sensitive(server->session_key.response);
+	put_net(cifs_net_ns(server));
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	kfree(server->origin_fullpath);
+	kfree(server->leaf_fullpath);
+#endif
+	kfree(server->hostname);
+	kfree_sensitive(server);
+}
+
 static void clean_demultiplex_info(struct TCP_Server_Info *server)
 {
 	int length;
@@ -839,15 +855,11 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	kfree(server->origin_fullpath);
-	kfree(server->leaf_fullpath);
-#endif
-	kfree(server);
-
 	length = atomic_dec_return(&tcpSesAllocCount);
 	if (length > 0)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
+
+	cifs_tcp_server_put(server);
 }
 
 static int
@@ -1372,8 +1384,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	/* srv_count can never go negative */
 	WARN_ON(server->srv_count < 0);
 
-	put_net(cifs_net_ns(server));
-
 	list_del_init(&server->tcp_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -1395,18 +1405,13 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	server->tcpStatus = CifsExiting;
 	spin_unlock(&GlobalMid_Lock);
 
-	cifs_crypto_secmech_release(server);
 	cifs_fscache_release_client_cookie(server);
 
-	kfree(server->session_key.response);
-	server->session_key.response = NULL;
-	server->session_key.len = 0;
-	kfree(server->hostname);
-	server->hostname = NULL;
-
 	task = xchg(&server->tsk, NULL);
 	if (task)
 		send_sig(SIGKILL, task, 1);
+
+	cifs_tcp_server_put(server);
 }
 
 struct TCP_Server_Info *
@@ -1427,6 +1432,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx)
 		rc = -ENOMEM;
 		goto out_err;
 	}
+	refcount_set(&tcp_ses->obj_refs, 1);
 
 	tcp_ses->hostname = kstrdup(ctx->server_hostname, GFP_KERNEL);
 	if (!tcp_ses->hostname) {
@@ -1523,6 +1529,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx)
 	 * this will succeed. No need for try_module_get().
 	 */
 	__module_get(THIS_MODULE);
+	/* Keep the server alive until the demultiplex thread has exited */
+	refcount_inc(&tcp_ses->obj_refs);
 	tcp_ses->tsk = kthread_run(cifs_demultiplex_thread,
 				  tcp_ses, "cifsd");
 	if (IS_ERR(tcp_ses->tsk)) {
-- 
2.53.0

