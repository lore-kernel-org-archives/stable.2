Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CF4A2E10
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332760; cv=none; b=stOxDUKsIEy1YwvcLgJzNbH09BynE0C7nmzYHiybN6nYKs/bPq2WgF6Cu2cKaCYLfl8Z/9gf8vbZjns87oFSGn7U4Vqe7xRGY/N6Mk86YOVF1lexqe4ZbaMa8YW9EZGbLUif7Y9YH5Rvno9oqytoc6yR9hQP93+6+6uqfBhFkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332760; c=relaxed/simple;
	bh=QhUHtrBsNDRt3fPHGVyIi5lUcEmLc7DygDLlDsy+4po=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WBkBQadjJqHDhCoYfqsDbAIld09VG7KiMoU49T36fBfwOSMahjHm/WSnC/oXHy48syVJKAlTBsqEaJ4XFkBF+goErUQ1OPXHSsUlhPZJLR+1+2/RlgEo6XqFw+zSXwCF4FZwf+f1DEQBGfFWB1M3OJF1F/V/apXliO0JfIPovXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0hHFg+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0hHFg+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D291F00A3A;
	Wed, 29 Jul 2026 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332759;
	bh=Pe6+M0tU66jkK57qZDMLav7v1lw9yFWtfHPaxj8/O5A=;
	h=Subject:To:Cc:From:Date;
	b=t0hHFg+NxWkpRgj2tZ5XUMS3ZM70ySW4v2zdZ5nViG8J8thSqTelOuJfnLOqMDY2W
	 IKVURVxCDeiZuEiZ82P16IvuhB9yrZbDcPi4um3ZLf2imsohgcX+Lu2KUc2TKvPjgy
	 qSAMrx2tSnooavQSmotSW1S1UUHK5XliZuJ4QcxA=
Subject: FAILED: patch "[PATCH] sctp: avoid auth_enable sysctl UAF during netns teardown" failed to apply to 5.10-stable tree
To: roxy520tt@gmail.com,bird@lzu.edu.cn,kuba@kernel.org,lucien.xin@gmail.com,n05ec@lzu.edu.cn,tomapufckgml@gmail.com,tpluszz77@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:45:35 +0200
Message-ID: <2026072935-chaplain-wrecker-03c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x f8d5e7846025f4ab15a461235f8ebae9094a361a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072935-chaplain-wrecker-03c4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8d5e7846025f4ab15a461235f8ebae9094a361a Mon Sep 17 00:00:00 2001
From: Zhiling Zou <roxy520tt@gmail.com>
Date: Wed, 15 Jul 2026 09:50:10 +0800
Subject: [PATCH] sctp: avoid auth_enable sysctl UAF during netns teardown

proc_sctp_do_auth() updates the SCTP control socket after changing
net.sctp.auth_enable. The handler gets the per-net SCTP state from
ctl->data, so an already opened sysctl file can still target a network
namespace while that namespace is being torn down.

SCTP previously registered its per-net sysctls from sctp_defaults_init(),
while the control socket is created later from sctp_ctrlsock_init(). This
exposed a window during initialization where auth_enable was writable
before net->sctp.ctl_sock existed, and a teardown window where auth_enable
stayed writable after inet_ctl_sock_destroy() had released the control
socket.

Move the per-net SCTP sysctl registration into sctp_ctrlsock_init() after
sctp_ctl_sock_init() succeeds, and unregister the sysctl table before
destroying the control socket in sctp_ctrlsock_exit(). If sysctl
registration fails after the control socket was created, destroy the
control socket in the same init path.

Make sctp_sysctl_net_unregister() tolerate a missing header and clear the
saved pointer so init-error and exit paths can safely share the unregister
helper.

Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current->nsproxy")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Qi Tang <tpluszz77@gmail.com>
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/390cd5e91ed60eea27b0b64d0468301a9e73b808.1784033357.git.roxy520tt@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index cf335494bffe..49d9740b1e0f 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1383,10 +1383,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	net->sctp.l3mdev_accept = 1;
 #endif
 
-	status = sctp_sysctl_net_register(net);
-	if (status)
-		goto err_sysctl_register;
-
 	/* Allocate and initialise sctp mibs.  */
 	status = init_sctp_mibs(net);
 	if (status)
@@ -1420,8 +1416,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	cleanup_sctp_mibs(net);
 #endif
 err_init_mibs:
-	sctp_sysctl_net_unregister(net);
-err_sysctl_register:
 	return status;
 }
 
@@ -1436,7 +1430,6 @@ static void __net_exit sctp_defaults_exit(struct net *net)
 	net->sctp.proc_net_sctp = NULL;
 #endif
 	cleanup_sctp_mibs(net);
-	sctp_sysctl_net_unregister(net);
 }
 
 static struct pernet_operations sctp_defaults_ops = {
@@ -1450,16 +1443,27 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 
 	/* Initialize the control inode/socket for handling OOTB packets.  */
 	status = sctp_ctl_sock_init(net);
-	if (status)
+	if (status) {
 		pr_err("Failed to initialize the SCTP control sock\n");
+		return status;
+	}
+
+	status = sctp_sysctl_net_register(net);
+	if (status) {
+		inet_ctl_sock_destroy(net->sctp.ctl_sock);
+		net->sctp.ctl_sock = NULL;
+	}
 
 	return status;
 }
 
 static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
+	sctp_sysctl_net_unregister(net);
+
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);
+	net->sctp.ctl_sock = NULL;
 }
 
 static struct pernet_operations sctp_ctrlsock_ops = {
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 15e7db9a3ab2..fca840484ebf 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
 
 void sctp_sysctl_net_unregister(struct net *net)
 {
+	struct ctl_table_header *header = net->sctp.sysctl_header;
 	const struct ctl_table *table;
 
-	table = net->sctp.sysctl_header->ctl_table_arg;
-	unregister_net_sysctl_table(net->sctp.sysctl_header);
+	if (!header)
+		return;
+
+	table = header->ctl_table_arg;
+	unregister_net_sysctl_table(header);
 	kfree(table);
+	net->sctp.sysctl_header = NULL;
 }
 
 static struct ctl_table_header *sctp_sysctl_header;

