Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF83264C4
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130247; cv=none; b=Ybb/cvq5bR5WaMbleLMl2vFgQhCqZU5uBaK5QnUGfs/ZUXLL2WmXpykPnLfdzDvCYCIJ60WZzzticzIwBPfeGJuyFzTSh1sgz1enqdIuuP9980dFOfTtEoN5zLi1NG1/kQ783i4KG06f0yDvzSbAQfePTjFxynuoQFHhERZn5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130247; c=relaxed/simple;
	bh=cqJ2wndUU4NnIEElPzzzMNWEPlYBMTfCd1R3VFWLT+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJMjvtKrOstmnfINXcICYyYC6kmiU+0u2GXDJvGopIt62XK4+BXrtOcfG367MzqpmiQEnjK1h2t054rUKu6HXY6GneMFbHd5oaKC/Cg9x7OhcZXsNqIuE1gMv+1V8zlwbx7ejdxs2gnyqe/HVSJ8qOSAwBd6dllG/aUbwUDsPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLXBo0zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLXBo0zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE48D1F000E9;
	Fri,  7 Aug 2026 19:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786130245;
	bh=qNShf59X6xA7BEtY+eJjxy8j6WlKwfkYH9/RQBys33Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLXBo0zqhmlHaa5iB9vZRaDFs1M/Ah0/XPT6F9NZLVfwUorTd61ElCKDNoHCimsQc
	 nuDP055+WDXnvdpzpgQxswGpYgMOeNB/E78yDv9lmQdOrm+1DVetFtX+GXwDR1pvho
	 w31j6Ykwu/LdtCkyWl/hyunOZqZGirSqz2+F6JeBBdqnUpAjb8JePeXP/+Vfu7bAjq
	 pvXQX27qWTTVwCOxurfrmSJQyjhxmLu0pyKdCNLOaLjK9g2YRg2zQmbCKqub5zS2WE
	 CwXDR0Mg6CjBzbSIARf9OgacamnkRa8dCsxwFIh/cfvbXXYKsxUA8ZyaiucdM3RmKV
	 961cmUHc/z7Lw==
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
Subject: [PATCH 5.10.y] sctp: avoid auth_enable sysctl UAF during netns teardown
Date: Fri,  7 Aug 2026 15:17:23 -0400
Message-ID: <20260807191723.3145916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072935-chaplain-wrecker-03c4@gregkh>
References: <2026072935-chaplain-wrecker-03c4@gregkh>
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
index 6e4ca837e91dd..6e3d0872491a2 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1286,10 +1286,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	/* Initialize maximum autoclose timeout. */
 	net->sctp.max_autoclose		= INT_MAX / HZ;
 
-	status = sctp_sysctl_net_register(net);
-	if (status)
-		goto err_sysctl_register;
-
 	/* Allocate and initialise sctp mibs.  */
 	status = init_sctp_mibs(net);
 	if (status)
@@ -1323,8 +1319,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	cleanup_sctp_mibs(net);
 #endif
 err_init_mibs:
-	sctp_sysctl_net_unregister(net);
-err_sysctl_register:
 	return status;
 }
 
@@ -1339,7 +1333,6 @@ static void __net_exit sctp_defaults_exit(struct net *net)
 	net->sctp.proc_net_sctp = NULL;
 #endif
 	cleanup_sctp_mibs(net);
-	sctp_sysctl_net_unregister(net);
 }
 
 static struct pernet_operations sctp_defaults_ops = {
@@ -1353,16 +1346,27 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 
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
index 82b736843c9d1..6f3afa763d6e2 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -515,11 +515,16 @@ int sctp_sysctl_net_register(struct net *net)
 
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

