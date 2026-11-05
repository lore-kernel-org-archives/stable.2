Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881293;
	b=X0hglZ3gcDcEvkWpjQCQXz1Kq7Dbi1hApefjuFExqVyjipBqZrGLun9N8lFJeUT3njUM
	 Y7jfGtNIRwj9YkGXpoSUOUjguVtxfBu3KM3bDDIKD7UR3HizGhLiz4gE5CAjeRrXljTTm
	 lsmgAgAD9DpWmNelm+hph/hq/V1TPflQkN4qd4oePh1E3NsCaPPOQqxkFXutp9Arj+m7n
	 ssscMQkP8TlUkbAk7S3I9/ADuYlgf7BJGjmePh/nmHjMKKMpqB9XNwCeOkUnf20QVkiGl
	 iD7A/fu1FHz+GVgg7JQ/GXyIxuHdSBV79C88Gk0YT3UtGptZ7IZ/Sk/YWp/x4tgf33A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vAsY6LXOnLZclehaN7vvtt8W8PcUF2Y3yMx85UmExXQ=;
	b=SJxjZDq/sJArUV7L84a2qkA91DdOfwZlXvsc2kxCnoM9pQJVt052yK76ARXN5Gu/d5YE
	 FK/BFAfrW0dJlM+O4J/vdUjhUU5sx1HJGLXcZ7Gg94dYeUjXQ0GTLTKTgOi2rVsdp6lZj
	 WEP28clBoUart+f2cWNqB5k5lrNR+rW1Y/M7trilWu8buVq86nXra8AvanSv+s3HIWgU9
	 PXbvHP1b/bnOsvMO9NSBRThvYaMzJtEOULWFrV6BJ6XmCjD6InbYH4iWg3DtVFmLOt5xw
	 2lMkA2denmKyodHjmDi0tItTnf5XUFgAlJHUMPytZvvI6CM4kICZBSEFJHNZKSVvN9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6Md0Fdc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B47606A337
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6Md0Fdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BEB1F000C1;
	Thu,  5 Nov 2026 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881293;
	bh=vAsY6LXOnLZclehaN7vvtt8W8PcUF2Y3yMx85UmExXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6Md0FdcCo9D9iD3kRv8fb0M2VpGcnNxR+RvyscYexlnpcWM+ZJIX/c6tV/ofkQhU
	 XputvCL2HzSbSBNq8BP1xEHyJp6q2QBAJZ0sXZrzokr+wDGEaKqLJCbr+7LI8DRePu
	 XwLcfC1YofjVsq3Lw2bOFexCI57Nshl1WRfH0EltY/b1tFf3Vhq4nUFwgHnm1AB2EJ
	 7WAYUgMNP+sG37ugvVkzr1ROaN4IEnKb/1ifec844R6Yo+2YwByYMsTtmAKkZIRzvU
	 v3iSdkF1ArjKgAKTLVHNzR5wgaWj2X0uegAHuAlYRA6zYuUWP2fU1ae5iRm8HTZ+j1
	 AIGIskJyj11Ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+5c3ed2a0de3270efc921@syzkaller.appspotmail.com,
	syzbot+c2ec61adfbcb24e5ec20@syzkaller.appspotmail.com,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: hold server info until cifsd exits
Date: Thu,  5 Nov 2026 07:21:31 -0500
Message-ID: <20261105121915.1276136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110421-avatar-written-3163@gregkh>
References: <2026110421-avatar-written-3163@gregkh>
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
[ sashal: adapted DFS cleanup to free both origin_fullpath and leaf_fullpath under the existing CONFIG_CIFS_DFS_UPCALL guard. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  2 ++
 fs/smb/client/connect.c  | 38 +++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a9dce6fe2705f..6658d6c532f80 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -16,6 +16,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mm.h>
 #include <linux/mempool.h>
+#include <linux/refcount.h>
 #include <linux/workqueue.h>
 #include <linux/utsname.h>
 #include <linux/sched/mm.h>
@@ -589,6 +590,7 @@ struct TCP_Server_Info {
 	spinlock_t srv_lock;  /* protect anything here that is not protected */
 	__u64 conn_id; /* connection identifier (useful for debugging) */
 	int srv_count; /* reference counter */
+	refcount_t obj_refs; /* struct lifetime: srv_count users + cifsd */
 	/* 15 character server name + 0x20 16th byte indicating type = srv */
 	char server_RFC1001_name[RFC1001_NAME_LEN_WITH_NULL];
 	struct smb_version_operations	*ops;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 157d947846d9b..3cb2d68673a5c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -984,6 +984,21 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
 	return 0;
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
 
 static void clean_demultiplex_info(struct TCP_Server_Info *server)
 {
@@ -1070,17 +1085,11 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
-	put_net(cifs_net_ns(server));
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	kfree(server->origin_fullpath);
-	kfree(server->leaf_fullpath);
-#endif
-	kfree(server->hostname);
-	kfree(server);
-
 	length = atomic_dec_return(&tcpSesAllocCount);
 	if (length > 0)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
+
+	cifs_tcp_server_put(server);
 }
 
 static int
@@ -1669,7 +1678,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	list_del_init(&server->tcp_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	/* For secondary channels, we pick up ref-count on the primary server */
+	/* For secondary channels, drop the reference on the primary server */
 	if (CIFS_SERVER_IS_CHAN(server))
 		cifs_put_tcp_session(server->primary_server, from_reconnect);
 
@@ -1690,15 +1699,11 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	server->tcpStatus = CifsExiting;
 	spin_unlock(&server->srv_lock);
 
-	cifs_crypto_secmech_release(server);
-
-	kfree_sensitive(server->session_key.response);
-	server->session_key.response = NULL;
-	server->session_key.len = 0;
-
 	task = xchg(&server->tsk, NULL);
 	if (task)
 		send_sig(SIGKILL, task, 1);
+
+	cifs_tcp_server_put(server);
 }
 
 struct TCP_Server_Info *
@@ -1720,6 +1725,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		rc = -ENOMEM;
 		goto out_err;
 	}
+	refcount_set(&tcp_ses->obj_refs, 1);
 
 	tcp_ses->hostname = kstrdup(ctx->server_hostname, GFP_KERNEL);
 	if (!tcp_ses->hostname) {
@@ -1849,6 +1855,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		module_put(THIS_MODULE);
 		goto out_err_crypto_release;
 	}
+	/* Keep the server alive until the demultiplex thread has exited */
+	refcount_inc(&tcp_ses->obj_refs);
 	/* thread created, put it on the list */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_add(&tcp_ses->tcp_ses_list, &cifs_tcp_ses_list);
-- 
2.53.0

