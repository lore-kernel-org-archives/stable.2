Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C714ADD97
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598782; cv=none; b=Gb9H6bIo50bb8yetFJ2xWVqq5LebWoZAq2E8Nw5REuANXXPO4IqjHuDDlSAWOvrUik11jBFHIWSugmoRTuZiiBF9mSVsa2azygErw6RW1JI452c2JtzheRCW/nm/t3ZiIO+By16oiiUk+MBzkQc1kW3qfT72IkRC6YkGa48Yoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598782; c=relaxed/simple;
	bh=+iZw+MRqwVTjqytkPs3feaoSBVJ5x39W5SO7kr2H0J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3gsRwFl4OXLPE1rqqgDaB3WufVss5PBVmrB/lVsOa0ayDXC2dK8Ik7d1oHA+iIPmrRYNgZJFw8VOscm1SyYRqzNoEorpdqW82Mn2kmGuU2FdURmrB2/AFVoebpmp1C/waRkjA7h/eiAI9Za/bLCQA/472vUaPUjb5W/nQEB2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npQri0LI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npQri0LI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E631F00898;
	Wed, 16 Sep 2026 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598777;
	bh=3UWTqoR+bIeT1VF5LTRi2h0m1J5bPpd0xQ+ZoYfOmUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=npQri0LItN+Flg7Cs77fL4NBnEPX71tbVLY2f0O+fThJlMibH0hL9HJ7hyYXX36Pp
	 d1EId2m2Yp9fXcnaYUhIp/rpFHsG83oaTAhTwFtaiYbqYUNYKucNat8d5nQnST1KOp
	 XmuKGXHD5hWf8LUKnnv3lJpDZvzuKfUNzcD6IbNacfvEp4AagvHgKwxOuhhVQW5LRe
	 g7TI2pOjGFd4iM5Ft9OsWLk9AJutyCmwyGnVNqrwbmN6IDOI4UhU93txVrBcee+Dsw
	 eVBk7NbchvjrrRuYfh3+1C+K/oMgGOwxhYsOcQaXGujoqtyb6WEDo4UGtwPk41aOtz
	 rVwyb9iH05UjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: XingWang Xiang <v3rdant.xiang@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] genetlink: pin family module during policy dump
Date: Wed, 16 Sep 2026 18:46:15 -0400
Message-ID: <20260916224615.3195741-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091632-goggles-patronage-327e@gregkh>
References: <2026091632-goggles-patronage-327e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: XingWang Xiang <v3rdant.xiang@gmail.com>

[ Upstream commit 6a1094c34d176827b2b173e163dcc964a13af93f ]

The generic netlink controller's policy dump keeps pointers to the target
family's operation and policy tables in its callback state.  A dump may be
split across multiple skbs and remain pending after the initial request.

Netlink pins the module which owns the dump callback, but in this case
that is the controller's owner rather than the target family's owner.  The
target family can consequently be unregistered and its module unloaded
while a policy dump is pending.  Advancing the dump then dereferences
policy memory from the unloaded module.

Take a reference to the target family's module when the dump starts.
Drop it from the error and done paths.  This matches the lifetime for which
the dump context retains the family and policy pointers.

Fixes: d07dcf9aadd6 ("netlink: add infrastructure to expose policies to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: XingWang Xiang <v3rdant.xiang@gmail.com>
Link: https://patch.msgid.link/20260902084317.4092542-1-v3rdant.xiang@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted split-operation iterator handling to the older genl_ops and opidx interfaces. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/genetlink.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 3a3b29ff63b31..4ededd793767c 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1159,6 +1159,7 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
+	struct module *owner;
 	unsigned int opidx;
 	u32 op;
 	u16 fam_id;
@@ -1202,6 +1203,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		ctx->single_op = true;
@@ -1210,14 +1214,19 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		err = genl_get_cmd(ctx->op, rt, &op);
 		if (err) {
 			NL_SET_BAD_ATTR(cb->extack, tb[CTRL_ATTR_OP]);
-			return err;
+			goto err_put_owner;
 		}
 
-		if (!op.policy)
-			return -ENODATA;
+		if (!op.policy) {
+			err = -ENODATA;
+			goto err_put_owner;
+		}
 
-		return netlink_policy_dump_add_policy(&ctx->state, op.policy,
-						      op.maxattr);
+		err = netlink_policy_dump_add_policy(&ctx->state, op.policy,
+						     op.maxattr);
+		if (err)
+			goto err_free_state;
+		return 0;
 	}
 
 	for (i = 0; i < genl_get_cmd_cnt(rt); i++) {
@@ -1232,12 +1241,16 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		}
 	}
 
-	if (!ctx->state)
-		return -ENODATA;
+	if (!ctx->state) {
+		err = -ENODATA;
+		goto err_put_owner;
+	}
 	return 0;
 
 err_free_state:
 	netlink_policy_dump_free(ctx->state);
+err_put_owner:
+	module_put(ctx->owner);
 	return err;
 }
 
@@ -1372,6 +1385,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 	struct ctrl_dump_policy_ctx *ctx = (void *)cb->ctx;
 
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 
-- 
2.53.0

