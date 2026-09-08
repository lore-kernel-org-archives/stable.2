Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080964B4873
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907016; cv=none; b=g1h8qG62+Z//DdLsNW6tU3k5t6JwHEIgxeWE9NjyLowFfdPNbj6aGi7KHdAbKWfig2cTD8MNo/lO/LwtAVHu1XN9nfEc+zkI+KsDHIAGmHVZyuMsQDMBG45UowIXXchf4s9NzgQkllpxLNtOUZf41UJJkPAClnRKQsojPB9rc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907016; c=relaxed/simple;
	bh=cblmYlIppXYv1w4skBY3NgFS1FQH6uC1E4D6FnxV+wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYKbPo6fU41NVPniCDdOO4LSk5iodO5PRgkGexS4hxp3rQvl0bg+lX6NNDDM+aduuWhzJH1q62oTiJS8AaaZckvw9sZsjcOzZJDxcWGPUzW5WZw4fexPGk4orO53yZY7jS6uQAXZb/SEpYrWR+oTmO4Eai49tdNV3brBpX7RIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKvPXeB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKvPXeB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CE11F00A3E;
	Tue,  8 Sep 2026 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907013;
	bh=HZ98ADxZ0VZzQj4JKeIGHUfJqGn8l7XFcxbVo23QWGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKvPXeB1QAR5RtVOX3IvqDCFbKk8Jl63MiNAcAs0FPDhPEqM3Ii7nUhIc9L5zNbI+
	 2GgHKHMTdeqkXvcUtrZE+1eaC8TDUcat/L0B9+XYueIaJDslEw/IP+PNp5OKfDjNpL
	 O1nxRBh98bFUCJ9Ts2LanoJz6SB4r7umuTQO4xkiz4X5GqOMFJ+Yc8s9fhwlY/wnww
	 +RTEsHFmobtQiMTBV28DoFELgwSkXIH86X2K/RvbOL1k/GdHcdGG8U96NMFgHPnl1d
	 RbzBOxBPYcdDzmE8RwFY2KWZzKyiESC7vqDCbTwjmp8G7YGtw5ef6d2Mjd2AxW0+Qt
	 Hxs6r8YQ1yeEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] SUNRPC: Add a server-side API for retrieving an RPC's pseudoflavor
Date: Tue,  8 Sep 2026 18:36:45 -0400
Message-ID: <20260908223651.501880-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223651.501880-1-sashal@kernel.org>
References: <2026090350-breeze-repugnant-70de@gregkh>
 <20260908223651.501880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit deb704281f076097b0347116a82edeba96697db1 ]

NFSD will use this new API to determine whether nfsd_splice_read is
safe to use. This avoids the need to add a dependency to NFSD for
CONFIG_SUNRPC_GSS.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svcauth.h    |  7 ++++++-
 net/sunrpc/auth_gss/svcauth_gss.c |  6 ++++++
 net/sunrpc/svcauth.c              | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 6f90203edbf8d..61c455f1e1f50 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -131,8 +131,11 @@ enum svc_auth_status {
  *   This call releases a domain.
  *
  * set_client()
- *   Givens a pending request (struct svc_rqst), finds and assigns
+ *   Given a pending request (struct svc_rqst), finds and assigns
  *   an appropriate 'auth_domain' as the client.
+ *
+ * pseudoflavor()
+ *   Returns RPC_AUTH pseudoflavor in use by @rqstp.
  */
 struct auth_ops {
 	char *	name;
@@ -143,11 +146,13 @@ struct auth_ops {
 	int			(*release)(struct svc_rqst *rqstp);
 	void			(*domain_release)(struct auth_domain *dom);
 	enum svc_auth_status	(*set_client)(struct svc_rqst *rqstp);
+	rpc_authflavor_t	(*pseudoflavor)(struct svc_rqst *rqstp);
 };
 
 struct svc_xprt;
 
 extern enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
+extern rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
 extern enum svc_auth_status svc_set_client(struct svc_rqst *rqstp);
 extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 49a8623cc1d57..3015839da877f 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -2009,6 +2009,11 @@ svcauth_gss_domain_release(struct auth_domain *dom)
 	call_rcu(&dom->rcu_head, svcauth_gss_domain_release_rcu);
 }
 
+static rpc_authflavor_t svcauth_gss_pseudoflavor(struct svc_rqst *rqstp)
+{
+	return svcauth_gss_flavor(rqstp->rq_gssclient);
+}
+
 static struct auth_ops svcauthops_gss = {
 	.name		= "rpcsec_gss",
 	.owner		= THIS_MODULE,
@@ -2017,6 +2022,7 @@ static struct auth_ops svcauthops_gss = {
 	.release	= svcauth_gss_release,
 	.domain_release = svcauth_gss_domain_release,
 	.set_client	= svcauth_gss_set_client,
+	.pseudoflavor	= svcauth_gss_pseudoflavor,
 };
 
 static int rsi_cache_create_net(struct net *net)
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index aa4429d0b8106..1619211f0960a 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -160,6 +160,22 @@ svc_auth_unregister(rpc_authflavor_t flavor)
 }
 EXPORT_SYMBOL_GPL(svc_auth_unregister);
 
+/**
+ * svc_auth_flavor - return RPC transaction's RPC_AUTH flavor
+ * @rqstp: RPC transaction context
+ *
+ * Returns an RPC flavor or GSS pseudoflavor.
+ */
+rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp)
+{
+	struct auth_ops *aops = rqstp->rq_authop;
+
+	if (!aops->pseudoflavor)
+		return aops->flavour;
+	return aops->pseudoflavor(rqstp);
+}
+EXPORT_SYMBOL_GPL(svc_auth_flavor);
+
 /**************************************************
  * 'auth_domains' are stored in a hash table indexed by name.
  * When the last reference to an 'auth_domain' is dropped,
-- 
2.53.0

