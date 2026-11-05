Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847711;
	b=SMXxftmlONjaOc19OzIGmuQ2zP0YzPV0aDcN/e256FBQ+qiOdi3MKHMvfu5T4M1P44Xf
	 IX/GHiS7mqbljtgNxylk0aP9z2igAP48mSq9CAD7AGzk5ZjhlOJsIxvk9i3TWGk0/sUNd
	 mkYrXP9UDcLnL7CC5K2MMqTFwrIpAQ/oZl2afGEsfIeFJpGaUbWsZolZumut9bgGAAbTD
	 mT02z0TDXWUo9qUBrQA30oSKs1JZqRiXG18MM4J/d1ubGYH5q2Ga1IsMt6jJB0bsjycEF
	 LNzZGs0lJ9kmWkkNSyLAzP2JWiGSbzaDPE/cW9ALVmw4TfjUihViSrHFJtGHbR8oFuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847711;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xNUucnfc+vfRoGbQhXqn2kYs4MzqO1lstHiwfwPXjRw=;
	b=jwfDMDpZqPd6kJy5paeBVpqYbkpaB/ZD5Pq+OCNWmsjrH5/H4GPT3nfnHGpiX0OrhQOc
	 j2LkiLRV2rj4HlMhIi/PbVsM/uhsHhxVnEuMXj1VdSHYb3f+rTOBDYrr9EEIqYX4TJEvw
	 9dq+wlXO5lgpULa6kmTUdHiZTGx6JkLdmyRFf0t39QSYlwsBSGThEkxUcKSOr5VUlboJv
	 d9uIgw3iXF4YY2DU98Bdje4EjnDVdipKJ9SOwWufAa3jrE2VPXi9nHnB02GigSluHBxjk
	 mLjJBzi1BrO5TwQF0gLOGpaa0By7eBnwWqgArShAoK7HZbpxxPS3mTua8PsoIQKLpiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="msF/fk7H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D6606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msF/fk7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A401F00919;
	Thu,  5 Nov 2026 03:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847710;
	bh=xNUucnfc+vfRoGbQhXqn2kYs4MzqO1lstHiwfwPXjRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=msF/fk7HsqHYGObzvqZdUMgQHlRR/Ch4uf7mZAO8vmRc3q+ZB88ChA5WYKAniK1lg
	 WUE0wL2O92lynSnt/guZe81e/CJFOzmAiBqAkl3WFCpKLQWKB2M//UrCbQWBbR/4sE
	 QcOvXdFjLzfT6evJg24Svn+I230Usg6GpNIHYW9CkUwLW37duwVsfnuC5Tkg6ggCeO
	 BVLaxQmI8jPMoKKsF7cdYK7p4d+Cy3ZlusAVdYveIXlZpeYW+A08+hQn+Dxy8KKT9g
	 sEF8To1/TsoMbHS+hJSx9t9zbu9oYXZ3yOFpv6Njs95txuX7h4IYpzUkYpAsp5MpfG
	 wqoVJkKXPgsMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+5c3ed2a0de3270efc921@syzkaller.appspotmail.com,
	syzbot+c2ec61adfbcb24e5ec20@syzkaller.appspotmail.com,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: hold server info until cifsd exits
Date: Wed,  4 Nov 2026 22:01:48 -0500
Message-ID: <20261105030125.1213408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110420-crunching-excess-eb90@gregkh>
References: <2026110420-crunching-excess-eb90@gregkh>
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
[ sashal: Adjusted patch context for missing NetBIOS fields and existing kfree() cleanup instead of kfree_sensitive(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  2 ++
 fs/smb/client/connect.c  | 33 +++++++++++++++++++++------------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index f5ca2cd653e95..8ffc8b2ab6db4 100644
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
@@ -647,6 +648,7 @@ struct TCP_Server_Info {
 	spinlock_t srv_lock;  /* protect anything here that is not protected */
 	__u64 conn_id; /* connection identifier (useful for debugging) */
 	int srv_count; /* reference counter */
+	refcount_t obj_refs; /* struct lifetime: srv_count users + cifsd */
 	/* 15 character server name + 0x20 16th byte indicating type = srv */
 	char server_RFC1001_name[RFC1001_NAME_LEN_WITH_NULL];
 	struct smb_version_operations	*ops;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 81961a54c9f1c..225bcd149a32f 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -977,6 +977,19 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
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
+	kfree(server->leaf_fullpath);
+	kfree(server->hostname);
+	kfree_sensitive(server);
+}
+
 static noinline_for_stack void
 clean_demultiplex_info(struct TCP_Server_Info *server)
 {
@@ -1062,14 +1075,11 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
-	put_net(cifs_net_ns(server));
-	kfree(server->leaf_fullpath);
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
@@ -1678,7 +1688,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	else
 		cancel_delayed_work_sync(&server->reconnect);
 
-	/* For secondary channels, we pick up ref-count on the primary server */
+	/* For secondary channels, drop the reference on the primary server */
 	if (SERVER_IS_CHAN(server))
 		cifs_put_tcp_session(server->primary_server, from_reconnect);
 
@@ -1686,15 +1696,11 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
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
@@ -1716,6 +1722,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		rc = -ENOMEM;
 		goto out_err;
 	}
+	refcount_set(&tcp_ses->obj_refs, 1);
 
 	tcp_ses->hostname = kstrdup(ctx->server_hostname, GFP_KERNEL);
 	if (!tcp_ses->hostname) {
@@ -1856,6 +1863,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
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

