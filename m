Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2542466A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103324; cv=none; b=ScCA9QuJFUzphCwY6a/S0s3tF8mfcSc+V090s+8Fd1+IVbXdc3psLrcaDE200IgUgAC82Ijxkc5yr0bbQ4jNLuKV2U0/MZ8ar0uhZnSjnNYPHr1YK76Ca2ZfJCOMy0CsJsbiBBu0+SpR/wkIQTlqFqa5dTrMUD33rIPTJposSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103324; c=relaxed/simple;
	bh=J1QFSlXKC524AFFPErlAWV1g3/iyYrRZ3AwdPu5yJrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNiuohuIhZtIaMAiMctcsZDdCbuFSLmsiqvRVoPe+3PIphLY6GDcv7J4AAVVaWbsmf/TPBJ0bRQ7QfRFnfNaM0KkxSSSGFU8zARwfIP0aSGCkOReh//CwUCNPSS01FA/jReIwogdZchWFiEjynFeHvJTnivByh3jzi+57p4+jHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTD6I4xW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTD6I4xW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0401F00A3F;
	Fri,  7 Aug 2026 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103307;
	bh=8hAELPfD/3un1MJFP/T4TWWAjEiApLpQAhYDMqF69gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTD6I4xWbOj7N/486hhTuwFAjjx1WQrGgPN8WtX4muIfllBVDCqAQchDWX6tByxxx
	 g8D+FcgdDuJvXGom/T+R5dqpMMo83LoXjsQai4kbkthQ9hdlYPLef2b4W8Bu5pxMrf
	 Rfnwy1gXgeqr+ZH20yOY/x3BVXN7uAT3CR74MwEpOd215JYwyhBaENIge3vkCjGblq
	 s2sXlynMwEq1WnLVbSvrjHbM2xVNZQy/bzJRXg/TKQrPRpjOJEWs0J+nF2/l7vOErk
	 zn74h0+DXQ/WgI3JBOVAt966SmkqhqW+IYACfH02S87ZkjEA0Pqy/VXwDvDp6adZeP
	 j4c/ilobzvjaA==
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
Subject: [PATCH 6.6.y 2/3] sctp: avoid auth_enable sysctl UAF during netns teardown
Date: Fri,  7 Aug 2026 07:48:22 -0400
Message-ID: <20260807114823.2056694-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807114823.2056694-1-sashal@kernel.org>
References: <2026072946-amulet-patriarch-e5e9@gregkh>
 <20260807114823.2056694-1-sashal@kernel.org>
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
Stable-dep-of: ffb2bd7ade36 ("sctp: close UDP tunnel sockets during netns teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/protocol.c | 20 ++++++++++++--------
 net/sctp/sysctl.c   |  9 +++++++--
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 2185f44198deb..bc1bd3a454ab3 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1394,10 +1394,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	net->sctp.l3mdev_accept = 1;
 #endif
 
-	status = sctp_sysctl_net_register(net);
-	if (status)
-		goto err_sysctl_register;
-
 	/* Allocate and initialise sctp mibs.  */
 	status = init_sctp_mibs(net);
 	if (status)
@@ -1431,8 +1427,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	cleanup_sctp_mibs(net);
 #endif
 err_init_mibs:
-	sctp_sysctl_net_unregister(net);
-err_sysctl_register:
 	return status;
 }
 
@@ -1447,7 +1441,6 @@ static void __net_exit sctp_defaults_exit(struct net *net)
 	net->sctp.proc_net_sctp = NULL;
 #endif
 	cleanup_sctp_mibs(net);
-	sctp_sysctl_net_unregister(net);
 }
 
 static struct pernet_operations sctp_defaults_ops = {
@@ -1461,16 +1454,27 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 
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
index 9c55a70f2b64b..ac9cbc4bf8c55 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -630,11 +630,16 @@ int sctp_sysctl_net_register(struct net *net)
 
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
-- 
2.53.0

