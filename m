Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892950;
	b=iC24/OQ4ocW5LF07l2yVdgnxHm6nvqYaZErXRbnfaUwmHy6SSYtvxyXbZWjqcYnqEO46
	 clbEDW4Pcus8RTLNzd2u3ebhreTuMBLSSQ0MXnXhcpM7p9+mDU02yp37EknLZrNYcpBFT
	 zf+4SyEHkDqwzkSNgWBj5GhHN9LTQqIzaaoSxmrf6eFYUxiPCTDZjIq3csY9XgcVXEGit
	 iJkP8gE9y5X0FIQCPx4l2GQrxTIua35Bzcpu7S5dkWOnTAWfnflSOJnfXnazGclCwNdiH
	 nSH4M4uZ8LhyPoB5EYm5JSdLosZ+6IMyYxW2C1fsy0qD2t4Xt+3UIlm0rij3oa0ketg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TkPEC3r/ywYKclCXCKERaenC48rzR/X1t9r60sr/1hg=;
	b=r4d38xyIG4tYbJe8RPKl0TvyF/mSew81iw3khlSV4+SbRXvBRoG+HLLns/UTuWkDdHpK
	 PWtl5jOyQjGn/6PIqh30ec4i8X3ccEcdR5U/Mf04ajhBjKJeJfQh0cNy5ruqupRYyYDfr
	 iBfbbVH/hwnKyZN1G1P3K0wcJOXFHMV/Okx/OMbb7AXEiJqZ21frx6DD90oSCSBZMKLXn
	 phHvoNlYQvynUHTjTHgJKpvvAVSsFxAolvGFQoApxPj4LIVC52nql09NEHcefHYTwoS6R
	 WsLBrFUj1rfusaZp8bZRCwWvKVsptbL4tY/Eqj5YJGJgXXp8Yai7CToFka/sS+bHQRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrXiUSGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2543606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrXiUSGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FA61F00A18;
	Thu,  5 Nov 2026 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892949;
	bh=TkPEC3r/ywYKclCXCKERaenC48rzR/X1t9r60sr/1hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nrXiUSGrhKFfxMVj679XL/KtJrk0eOAwl0IeracbEa810P1AV3ldM11DfcRCKBBX2
	 jCxJxOKFvF6bzxZrnP38S0UuXFFRb4OzSAIhAK1NwHV3HquViN/srg+disFCoMqrCB
	 fCz+J0mv64ANicrU4es9aYIwMkhhI+fYB3cbZOGPSgWNehuDTbbq0M9sIe1pDg3KFZ
	 hF7yga8xwIJaS5kjA1m3yx/uFAYoNyYVMPcdRKYzL7kFPhijZMV7lpvIe3hXdYrmYj
	 EKN5MkaUVex200EPwQXTG7WQXn6i6nAXdgIE683UTiJhFEOCu6C4CLBRdCfb0R5lSs
	 9uSjI0QWz49WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+5c3ed2a0de3270efc921@syzkaller.appspotmail.com,
	syzbot+c2ec61adfbcb24e5ec20@syzkaller.appspotmail.com,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: hold server info until cifsd exits
Date: Thu,  5 Nov 2026 10:35:47 -0500
Message-ID: <20261105150118.1662306-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110422-graduate-mounting-470e@gregkh>
References: <2026110422-graduate-mounting-470e@gregkh>
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
[ sashal: moved thread reference acquisition before kthread_run() because it starts the thread immediately. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h |  2 ++
 fs/cifs/connect.c  | 29 +++++++++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 8a5cdf4ba0ae6..05f68bf0a4a68 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -25,6 +25,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mm.h>
 #include <linux/mempool.h>
+#include <linux/refcount.h>
 #include <linux/workqueue.h>
 #include <linux/fcntl.h>
 #include "cifs_fs_sb.h"
@@ -674,6 +675,7 @@ struct TCP_Server_Info {
 	struct list_head tcp_ses_list;
 	struct list_head smb_ses_list;
 	int srv_count; /* reference counter */
+	refcount_t obj_refs; /* struct lifetime: srv_count users + cifsd */
 	/* 15 character server name + 0x20 16th byte indicating type = srv */
 	char server_RFC1001_name[RFC1001_NAME_LEN_WITH_NULL];
 	struct smb_version_operations	*ops;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index db54cbbe8cc5e..dedcc00e3b675 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -880,6 +880,18 @@ handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
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
+	kfree(server->hostname);
+	kfree_sensitive(server);
+}
+
 static void clean_demultiplex_info(struct TCP_Server_Info *server)
 {
 	int length;
@@ -964,12 +976,11 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
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
@@ -2496,8 +2507,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 		return;
 	}
 
-	put_net(cifs_net_ns(server));
-
 	list_del_init(&server->tcp_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -2518,16 +2527,13 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	server->tcpStatus = CifsExiting;
 	spin_unlock(&GlobalMid_Lock);
 
-	cifs_crypto_secmech_release(server);
 	cifs_fscache_release_client_cookie(server);
 
-	kfree(server->session_key.response);
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
@@ -2548,6 +2554,7 @@ cifs_get_tcp_session(struct smb_vol *volume_info)
 		rc = -ENOMEM;
 		goto out_err;
 	}
+	refcount_set(&tcp_ses->obj_refs, 1);
 
 	tcp_ses->ops = volume_info->ops;
 	tcp_ses->vals = volume_info->vals;
@@ -2635,6 +2642,8 @@ cifs_get_tcp_session(struct smb_vol *volume_info)
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

