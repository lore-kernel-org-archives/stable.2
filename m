Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802868;
	b=2yr1KdaVeRxQXATYy5ejxv4oT81ZictgJi9HDlTHDdgxc3OJXoNVL5sSfxiysyf+bzpk
	 JMPMUGm5ltx0+P1sRL46KT+a1MDjMjD3wz4alJQ1Y1UmcS5uc81jKQiYWkNoeEI+r91OS
	 j3wT2j3TpdAGO9+7RQjtSa5QD1sfF4FID6ub+78SSYqqAjplsJ9DH/EhulLIii78vZX89
	 dZGeGKgzq58OMpE0POEYWBlMBnZ6ydwtArrjm3I4wKUExvgMlqqB7WLFe5h7n/KKXdA3H
	 mss+hueXruojBR//ZBlJ0VxskGU1ghrr9Cy4LVa6Q294AyL+0hQeZ5pKe2nFsISVjZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802868;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ftm5yxeKb+UeJx0yejPRpH5t92KwO5apECamGDGVm0U=;
	b=sS348inx677juB7NfK51OMw9Ukk4YFdooIpmvzzHtnK/1jwPN+uGawWTO1rAUUEvLx2A
	 1vjJrL33CcuxJWQPQ6b9OJ60PMrVLeaFMmPqYOB3OcRfucjTMLtiquuISKYZ9tcZCqTsD
	 HOuvPSs6bzEjFC0CwWT48vNcgFx35ouI48HtcZAX61K/8EK27g4gwXn/k99nLTJRTVD1e
	 kA5jGebQc8bWoyNjR7YeZf7Z9kXll14tuQGqT7uuz0E7/TjuYZU9ah03lorssGUBu2T7V
	 4C2sP5iOiFMpctzS8dZXnyHw1pJ7aQ8roZKfSAXtdaVSTJyXdHQ87SoAAeQHa4724Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="in/N+ZxS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B789606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=in/N+ZxS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD91E1F000C1;
	Wed,  4 Nov 2026 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802868;
	bh=ftm5yxeKb+UeJx0yejPRpH5t92KwO5apECamGDGVm0U=;
	h=Subject:To:Cc:From:Date;
	b=in/N+ZxSSNXEfv8nX/RX+pThPV/eXwGZjAUqDezFGWpESaIHnfLS7wfriT5HEM/uX
	 cuLsZICqpQHss6RJjCVORtzDa3B1GiWkcGatA5K8EyM9PYH8U7EhPC4BAOfueaacF2
	 KSdUbuKYaY9e+374sqPANppsKNyV6yJcQGAjkWkk=
Subject: FAILED: patch "[PATCH] smb: client: hold server info until cifsd exits" failed to apply to 6.6-stable tree
To: hackerowskiy@gmail.com,mike.michalo@gmail.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:34:21 +0100
Message-ID: <2026110421-bullring-earplugs-c9a8@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 482c117c6dbeee382790168af10959810450ab09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110421-bullring-earplugs-c9a8@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 482c117c6dbeee382790168af10959810450ab09 Mon Sep 17 00:00:00 2001
From: Eduard Zateev <hackerowskiy@gmail.com>
Date: Tue, 20 Oct 2026 21:45:45 +0200
Subject: [PATCH] smb: client: hold server info until cifsd exits

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

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 73b49dcb5215..d3ca688b6aba 100644
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
@@ -681,6 +682,7 @@ struct TCP_Server_Info {
 	spinlock_t srv_lock;  /* protect anything here that is not protected */
 	__u64 conn_id; /* connection identifier (useful for debugging) */
 	int srv_count; /* reference counter */
+	refcount_t obj_refs; /* struct lifetime: srv_count users + cifsd */
 	int rfc1001_sessinit; /* whether to estasblish netbios session */
 	bool with_rfc1001; /* if netbios session is used */
 	/* 15 character server name + 0x20 16th byte indicating type = srv */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c3614c077746..e68fffb2ab2e 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1083,6 +1083,19 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
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
@@ -1168,14 +1181,11 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
-	put_net(cifs_net_ns(server));
-	kfree(server->leaf_fullpath);
-	kfree(server->hostname);
-	kfree_sensitive(server);
-
 	length = atomic_dec_return(&tcpSesAllocCount);
 	if (length > 0)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
+
+	cifs_tcp_server_put(server);
 }
 
 static int
@@ -1751,7 +1761,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	else
 		cancel_delayed_work_sync(&server->reconnect);
 
-	/* For secondary channels, we pick up ref-count on the primary server */
+	/* For secondary channels, drop the reference on the primary server */
 	if (SERVER_IS_CHAN(server))
 		cifs_put_tcp_session(server->primary_server, from_reconnect);
 
@@ -1759,15 +1769,11 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
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
@@ -1789,6 +1795,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		rc = -ENOMEM;
 		goto out_err;
 	}
+	refcount_set(&tcp_ses->obj_refs, 1);
 
 	tcp_ses->hostname = kstrdup(ctx->server_hostname, GFP_KERNEL);
 	if (!tcp_ses->hostname) {
@@ -1927,6 +1934,8 @@ smbd_connected:
 		module_put(THIS_MODULE);
 		goto out_err_crypto_release;
 	}
+	/* Keep the server alive until the demultiplex thread has exited */
+	refcount_inc(&tcp_ses->obj_refs);
 	/* thread created, put it on the list */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_add(&tcp_ses->tcp_ses_list, &cifs_tcp_ses_list);

