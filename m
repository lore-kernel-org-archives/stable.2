Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850270;
	b=GmL5Y5XtXTbyosRJDh59o910fLFZZwrBRWZjkwTMUVawwF6T/mFQBScpWyxk3LIyMU3s
	 JvExpvHQLREcERQITBkUi1Ogtg3CiUv5YUBw1N5PZ45zdfJnbICJL50tmkatURxlTgN0m
	 McfKEJzgx2ewmr5tt+evSAUQWNm8jFYsVcuuF5SQhAfUzAJIfplJ8dgYkPwh+zi8b00/0
	 MO0FifmAdpVOHT6UagwrtRT/wQP0OC4Lr8xCkv+DVXEpu5LGD9pUeOY7egXqJlGu2ZQbe
	 acgVvmcW4o0xcH99zPb1BNcXZ0iDgRxQtxEA89viFUFjBHtdR3TtNTR03FGzCk9UH+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850270;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2XvspcOknGrdd2gw9AAEEtDDPv/FcVq8g+18OSpL428=;
	b=qQrafVhn03bfV4M8xesG5BV3YRi3baAnWnYdnUol/WmpKlpaelUtC1c5S53+BF+Vh57F
	 VuEEsONY4Fp9trRBBrslB20thfcA/7oTxK9ln1uZec5LI1FSQPkGhCzG/gF5EwtIlXOVg
	 uRPzNrxQqptvIUnpd+FiM8kPWohjCScomylMeA1ecOPgo4mXPFaCeNNCLsjIzShp/R3+3
	 ISsJz7zLTxw9VExO67n6rPnU0JJrZm5MqgGEP6F3X9WlDAw72QX2xbszH48wf4jyAbnhJ
	 nGc/TXHrXwxvPcrkoop8b5JH2ktzFZ9HTxS7alAbo1MhosEvPgEzUlNsICQ40nTmExg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACB2w+Fp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E4606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACB2w+Fp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951D61F000C1;
	Thu,  5 Nov 2026 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793850269;
	bh=2XvspcOknGrdd2gw9AAEEtDDPv/FcVq8g+18OSpL428=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACB2w+FpZcGS6e+2DHI0B2BeUQ6iYF+eUR7xlxMw4EDnlWpJgYsTGLiyB6J7vpRbd
	 d/IuM1phgJ7k5OSlm+9vQ4mljaKpSJ1/B7E3Ywjt5swy0vBaCTxAZLx7TTfdNYWSeO
	 wUt6XuhXULPxeAUjpMG223z5wg+waRepJiERDxjmhLoMJwIYZfoOjs1bJrqbEN6jK/
	 QPBblb+ianAduUAT3xX49u3MRDEajQ69XwRFUCcRTg0+l39xRAS+nAI0wzGj/NJulX
	 Mv1JV0PKpt8mAcZLsY6wQUtPAb2woA6WLl7agG9WaCrAj2h9/r6ePcLibMzgkgSr51
	 YY4sbYnoOjLoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+5c3ed2a0de3270efc921@syzkaller.appspotmail.com,
	syzbot+c2ec61adfbcb24e5ec20@syzkaller.appspotmail.com,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: hold server info until cifsd exits
Date: Wed,  4 Nov 2026 22:44:27 -0500
Message-ID: <20261105034400.1240316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110421-bullring-earplugs-c9a8@gregkh>
References: <2026110421-bullring-earplugs-c9a8@gregkh>
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
[ sashal: adjusted cleanup context for kfree() instead of kfree_sensitive() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  2 ++
 fs/smb/client/connect.c  | 33 +++++++++++++++++++++------------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 126cd0e31704e..6ff12e9e3417c 100644
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
index 3d0fd8bf8f352..419ded50b2457 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -993,6 +993,19 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
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
@@ -1079,14 +1092,11 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
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
@@ -1695,7 +1705,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	else
 		cancel_delayed_work_sync(&server->reconnect);
 
-	/* For secondary channels, we pick up ref-count on the primary server */
+	/* For secondary channels, drop the reference on the primary server */
 	if (SERVER_IS_CHAN(server))
 		cifs_put_tcp_session(server->primary_server, from_reconnect);
 
@@ -1703,15 +1713,11 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
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
@@ -1733,6 +1739,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		rc = -ENOMEM;
 		goto out_err;
 	}
+	refcount_set(&tcp_ses->obj_refs, 1);
 
 	tcp_ses->hostname = kstrdup(ctx->server_hostname, GFP_KERNEL);
 	if (!tcp_ses->hostname) {
@@ -1872,6 +1879,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
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

