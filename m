Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0B5908A9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907018; cv=none; b=JRIN3HnWb8UAYoRmnJdDB8/whkl0P9k59957FmplCujwuAYwhyei/sYlVzXSm7GtOokCA9SYjEb5RASU0YamauE6QxEVnSsldX/XPBTaMpUUOSUH1P22vLQdO1rnicbfQPlprCVXiyHpVF4yaOKO/XZVAgIJYY/yYsO+KdsvSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907018; c=relaxed/simple;
	bh=X0Kbsx5lC0QnyfJgy8S9qiAaVBaA25rx7KdR9OQuL+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbWL94uekzZksHUDao56akbsbiLR6elglZxb++4L2FVb2kZEjP5oFu5HzCmT1B+UA5UaL2FdkyF+PYs+zG6dSIaz9bWiUZv1QZa9zG7zbFJ6wXTEFZCZHs+/Cv66m3qF2LCri7SxNwmiDg4qSM0i4xh+/ZNhHMg2DAzr6YxjPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0o7VrOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0o7VrOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79EA1F00A3F;
	Tue,  8 Sep 2026 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907014;
	bh=mo7qQEQSaq0y8mLdW9CpJeD2U0NR1JcQJX5kstZCtrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0o7VrOYdGTGzU8HX/Y+n7vxuyEfIfpEAmJFJSLZ0Ld0Ef45Lowd3SWxGWT8X6+lm
	 dkOBnwYDcV74gH2OoU1EQSiewQCWIg5Er/40Ha28BwI7cWGKXFTWl4H7AKccdzcD1p
	 +BoldKxw5j1n2efgtVNHA4TD6vsLkyFUBhCojICw3QwyREXumyuiJNe+5syDWRrBEV
	 5VQFHWRUrR+DKmV/XAa4OIE9Ct8lbpvGDdP7VwUi+60XuQ01ft0YUXkuRpyvqn1WrX
	 4O5G96xALJypq0n+j2oMY5SeHHLOPfQp6qysDNDDwYpha/VEInMcMSsmOnYo9yU9il
	 wxb2yhXPU+KDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] sunrpc: refactor pool_mode setting code
Date: Tue,  8 Sep 2026 18:36:46 -0400
Message-ID: <20260908223651.501880-3-sashal@kernel.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 5f71f3c325534da55dfda487a67208e2e0f0cd1b ]

Allow the pool_mode setting code to be called from internal callers
so we can call it from a new netlink op. Add a new svc_pool_map_get
function to return the current setting. Change the existing module
parameter handling to use the new interfaces under the hood.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h |  2 +
 net/sunrpc/svc.c           | 85 ++++++++++++++++++++++++++++----------
 2 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3d8b215f32d5b..d4558fefd9b4e 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -395,6 +395,8 @@ struct svc_procedure {
 /*
  * Function prototypes.
  */
+int sunrpc_set_pool_mode(const char *val);
+int sunrpc_get_pool_mode(char *val, size_t size);
 int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4d8d460747164..bf88a955920f2 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -72,57 +72,100 @@ static struct svc_pool_map svc_pool_map = {
 static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count only */
 
 static int
-param_set_pool_mode(const char *val, const struct kernel_param *kp)
+__param_set_pool_mode(const char *val, struct svc_pool_map *m)
 {
-	int *ip = (int *)kp->arg;
-	struct svc_pool_map *m = &svc_pool_map;
-	int err;
+	int err, mode;
 
 	mutex_lock(&svc_pool_map_mutex);
 
-	err = -EBUSY;
-	if (m->count)
-		goto out;
-
 	err = 0;
 	if (!strncmp(val, "auto", 4))
-		*ip = SVC_POOL_AUTO;
+		mode = SVC_POOL_AUTO;
 	else if (!strncmp(val, "global", 6))
-		*ip = SVC_POOL_GLOBAL;
+		mode = SVC_POOL_GLOBAL;
 	else if (!strncmp(val, "percpu", 6))
-		*ip = SVC_POOL_PERCPU;
+		mode = SVC_POOL_PERCPU;
 	else if (!strncmp(val, "pernode", 7))
-		*ip = SVC_POOL_PERNODE;
+		mode = SVC_POOL_PERNODE;
 	else
 		err = -EINVAL;
 
+	if (err)
+		goto out;
+
+	if (m->count == 0)
+		m->mode = mode;
+	else if (mode != m->mode)
+		err = -EBUSY;
 out:
 	mutex_unlock(&svc_pool_map_mutex);
 	return err;
 }
 
 static int
-param_get_pool_mode(char *buf, const struct kernel_param *kp)
+param_set_pool_mode(const char *val, const struct kernel_param *kp)
+{
+	struct svc_pool_map *m = kp->arg;
+
+	return __param_set_pool_mode(val, m);
+}
+
+int sunrpc_set_pool_mode(const char *val)
+{
+	return __param_set_pool_mode(val, &svc_pool_map);
+}
+EXPORT_SYMBOL(sunrpc_set_pool_mode);
+
+/**
+ * sunrpc_get_pool_mode - get the current pool_mode for the host
+ * @buf: where to write the current pool_mode
+ * @size: size of @buf
+ *
+ * Grab the current pool_mode from the svc_pool_map and write
+ * the resulting string to @buf. Returns the number of characters
+ * written to @buf (a'la snprintf()).
+ */
+int
+sunrpc_get_pool_mode(char *buf, size_t size)
 {
-	int *ip = (int *)kp->arg;
+	struct svc_pool_map *m = &svc_pool_map;
 
-	switch (*ip)
+	switch (m->mode)
 	{
 	case SVC_POOL_AUTO:
-		return sysfs_emit(buf, "auto\n");
+		return snprintf(buf, size, "auto");
 	case SVC_POOL_GLOBAL:
-		return sysfs_emit(buf, "global\n");
+		return snprintf(buf, size, "global");
 	case SVC_POOL_PERCPU:
-		return sysfs_emit(buf, "percpu\n");
+		return snprintf(buf, size, "percpu");
 	case SVC_POOL_PERNODE:
-		return sysfs_emit(buf, "pernode\n");
+		return snprintf(buf, size, "pernode");
 	default:
-		return sysfs_emit(buf, "%d\n", *ip);
+		return snprintf(buf, size, "%d", m->mode);
 	}
 }
+EXPORT_SYMBOL(sunrpc_get_pool_mode);
+
+static int
+param_get_pool_mode(char *buf, const struct kernel_param *kp)
+{
+	char str[16];
+	int len;
+
+	len = sunrpc_get_pool_mode(str, ARRAY_SIZE(str));
+
+	/* Ensure we have room for newline and NUL */
+	len = min_t(int, len, ARRAY_SIZE(str) - 2);
+
+	/* tack on the newline */
+	str[len] = '\n';
+	str[len + 1] = '\0';
+
+	return sysfs_emit(buf, str);
+}
 
 module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
-		 &svc_pool_map.mode, 0644);
+		  &svc_pool_map, 0644);
 
 /*
  * Detect best pool mapping mode heuristically,
-- 
2.53.0

