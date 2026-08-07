Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422B281369
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115962; cv=none; b=ZH6hrtv3NKA9BI2bcGJvjWsN32Y0lBAZDw66Ic0Rr15Evnin5oqIldh5hKSnMuUOhNWI6f+D4ErcA0nbYiVj9rpwZBq7DDsQhpVca0HLLTTTIrpL3dBGVIVA54wkP5tLTyZIn404HkyGx6/txaLvT5cnbWuf9RehdiiaQHToZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115962; c=relaxed/simple;
	bh=vLhg29aQOYXpqHjWfPf/aI/YD9GGv5CmEWoh6ddChqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkTcf+6Q0dGg9G+oBes1Jam6cHKoVGc5LyUrhkUZJSWlQcOA+QPS9HgYxU2iDOKfm+WGHQEtxUm4cxyym1Nw6Ej4XCSKsaDE1UyoJHfb73ZUYQ18L2qpq0TdDc78FJhVCj3iXgI9bIeuoA0d4hprTkx1qMIsNfpMDwAdR35G8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsC3nSHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsC3nSHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AADB1F00A3A;
	Fri,  7 Aug 2026 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115961;
	bh=TUsc5pds/8L2h7CMEXNjt8wTnHvzHOu3u4RT8nXwJnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AsC3nSHw7HAs4k/b8Mcu4T5THAgiB9esY2umNI8IWkjxPKkTbngvxwD1JrBwUs1D4
	 BasnsrfNTWxVZgYdLOcZVPlpPIwjfGNogXsOda09QgTT0eWwWoli6uOiebcnIK7zY3
	 4104wzUAd6JPhxDmms032tX+1ieGkbqTdRSngm3qZuJK1XuMcwYE7X5vUr4Cy05z+8
	 xvYpIRax6/x5jVGo/OpU91/vdGBrpwGy+sEjBZP55x7HEsIOUJmgzxG+7asfJJ1L93
	 e8HZ3l0fwwNEDP+jL82O+p3r81EUdnZ7Co6NfnXxcx5hnJfZUGoiQIWDhJpIFoHC34
	 t+GkgyMBSk1gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <roxy520tt@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Qi Tang <tpluszz77@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] sctp: avoid auth_enable sysctl UAF during netns teardown
Date: Fri,  7 Aug 2026 11:19:18 -0400
Message-ID: <20260807151918.2226592-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072934-alfalfa-childhood-9927@gregkh>
References: <2026072934-alfalfa-childhood-9927@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <roxy520tt@gmail.com>

[ Upstream commit f8d5e7846025f4ab15a461235f8ebae9094a361a ]

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
[ dropped the missing `l3mdev_accept` context block and kept 6.1's non-const `struct ctl_table *table` declaration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/protocol.c | 20 ++++++++++++--------
 net/sctp/sysctl.c   |  9 +++++++--
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 036dc574af4f9..9384ff5418d59 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1383,10 +1383,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	/* Initialize maximum autoclose timeout. */
 	net->sctp.max_autoclose		= INT_MAX / HZ;
 
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
index f3d09998c24de..2e99de0aeea6d 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -617,11 +617,16 @@ int sctp_sysctl_net_register(struct net *net)
 
 void sctp_sysctl_net_unregister(struct net *net)
 {
+	struct ctl_table_header *header = net->sctp.sysctl_header;
 	struct ctl_table *table;
 
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
-- 
2.53.0

