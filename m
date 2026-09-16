Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220594E2F35
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602132; cv=none; b=QPX8C4PIZAI/Z0adLUSTUvknZlKLb2L0HrVtB6+eR5C2GVxZCwP4TmbN/WtP+HyRUD5TgZoqa0eyqyMlHap9w57J9Bs3+DIfXL2BBop7jYwIH0RY3JO6zWLU6CyJ8V4boLV/oGlL0Xgcc1u+QiLZVSyovpezwr8vTZHV+KibO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602132; c=relaxed/simple;
	bh=a5IQYqZOP9cxBRkfPYcbDCNIqUU1eoX/DB2cS1+dXLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se5AReXpFrtAoUyKxoff/WoIcd1SMweZaq5azrYzqBdyQUbE+hh5pqKGgyexphQaeAVZZ4KKSt4oafg4F8wJ6/ljj/tNFsySqOV5m8wHvqogYIEvatErijQjo2GZoLJtTDnbvUU+I4i7ovrR6yOuuvTyAfvQv0go8Y112zh1h2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Voce2sp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Voce2sp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A86C1F00893;
	Wed, 16 Sep 2026 23:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602130;
	bh=sni+O5W/Kbb79kWxsY8f4dYEJN9DWYCnu04bmqFcE3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Voce2sp0cL4Ny8eIuX0n3zbPtmW3VQyoLG1LPIyr2lVJzHfP5Hct68qiRKCKyt6vk
	 09NNc/iYt7/Hgbe7XR3znXVAs5EowQwCMG3ZXOjA/z64z8y6OO8I+L3FADidUaLwkg
	 +GhpCNIvvd+nln/bBkUjgnVDTtBc7jDMEKrqjkseYgGZW414mRYY0DaSOTbZjjW0iy
	 6mjyqQLDkSTTXEoPugW+hoQG8cd1cxob5yid/rjHY/DGxFtGxHfjS75wIglcbSAtWn
	 0Eze0kwxHaTQzthR3E+0DoATillRzSqWBH69nozglscMGWj/2fecXNbh3uvo6LyRhM
	 8LSth0yyjK8Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: XingWang Xiang <v3rdant.xiang@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] genetlink: pin family module during policy dump
Date: Wed, 16 Sep 2026 19:42:08 -0400
Message-ID: <20260916234208.3296047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091633-subdued-portal-83eb@gregkh>
References: <2026091633-subdued-portal-83eb@gregkh>
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
index 7a568292e0d10..c0d6950e21651 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1101,6 +1101,7 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
+	struct module *owner;
 	unsigned int opidx;
 	u32 op;
 	u16 fam_id;
@@ -1144,6 +1145,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		ctx->single_op = true;
@@ -1152,14 +1156,19 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
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
@@ -1174,12 +1183,16 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
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
 
@@ -1314,6 +1327,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 	struct ctrl_dump_policy_ctx *ctx = (void *)cb->ctx;
 
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 
-- 
2.53.0

