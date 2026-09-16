Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494A44A40B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589786; cv=none; b=O7/th561we+t1w+qoixi2pmYVY5D0ijxw7EAYLWc4ntKayRrHdCcDQ1NP+bp/tafjSgeyIaxsIHOxSibKp2bdfzAhk5AEK4u/N+IYPV5fAGAonn7X0TisVeuG7Fnv5WT9FpLuyzEE5mMmzDT9ZISbadZXbfjkmIzawufPyL3lI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589786; c=relaxed/simple;
	bh=pC8oM3i/VQszzkAIVZpNbsEM0a97hedIsWrjjTv+DZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmL9ED3eFJC2BR/qmhs708N2rhb9ucNWUd5Soh5t5Bg5VIoBBDf3frCrMkYw38pRRzrCG1/IsTTp7J636ej+vwl6x+UbR9w1h9dyGPDfSirg2pSlFzov4gDIuWAUj1qiBKHRsPuYp210r9C5NgEQQijf9s2sRdPmnHWPk60Gs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeJQ2E9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeJQ2E9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DFA1F000FF;
	Wed, 16 Sep 2026 20:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589774;
	bh=LiWhXDLEBNX7Tk7IaaXpEyq/qa2WQx6GkzH4U3EW3i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeJQ2E9dEfdza1fr0gAm6Mc25ykNiq108SkGPXWIlWNMflHJXevSOCF5bqBGiHsPq
	 fEtRNoJERLAwW3hk11w2DsEeUK4GdcgcjKUGf8B/UnYxOUQJowmXrAwhAua0Y3DT27
	 Atk1MUBDs+a/TW/MVy0NjWCbHHAj2bBV2hCwOJ1+tkNhVw9Mxooml8mLNcCprkckyz
	 MKTQwTiKQRsyuZLOfjfr0GyxDO2JD1Ly5ZD9LGNbsAqzO1v4rzAyw1q66TFE0yiVQJ
	 G/YFNpVugofowZxpn9Zg93wMQINuly7qkciIge0XaJ8/Fj1l2lpDwTDAqNhBxQOlu/
	 20Q1M1azWbYOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: XingWang Xiang <v3rdant.xiang@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] genetlink: pin family module during policy dump
Date: Wed, 16 Sep 2026 16:16:12 -0400
Message-ID: <20260916201612.2499872-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091631-barista-ensnare-6605@gregkh>
References: <2026091631-barista-ensnare-6605@gregkh>
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
[ Adjusted context to retain kmalloc(sizeof(*ctx->op_iter), GFP_KERNEL) instead of kmalloc_obj(*ctx->op_iter). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/genetlink.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 3327d84518141..a22b7a3279df1 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1514,6 +1514,7 @@ struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
 	struct genl_op_iter *op_iter;
+	struct module *owner;
 	u32 op;
 	u16 fam_id;
 	u8 dump_map:1,
@@ -1556,6 +1557,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		struct genl_split_ops doit, dump;
@@ -1566,7 +1570,7 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		err = genl_get_cmd_both(ctx->op, rt, &doit, &dump);
 		if (err) {
 			NL_SET_BAD_ATTR(cb->extack, tb[CTRL_ATTR_OP]);
-			return err;
+			goto err_put_owner;
 		}
 
 		if (doit.policy) {
@@ -1584,16 +1588,20 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 				goto err_free_state;
 		}
 
-		if (!ctx->state)
-			return -ENODATA;
+		if (!ctx->state) {
+			err = -ENODATA;
+			goto err_put_owner;
+		}
 
 		ctx->dump_map = 1;
 		return 0;
 	}
 
 	ctx->op_iter = kmalloc(sizeof(*ctx->op_iter), GFP_KERNEL);
-	if (!ctx->op_iter)
-		return -ENOMEM;
+	if (!ctx->op_iter) {
+		err = -ENOMEM;
+		goto err_put_owner;
+	}
 
 	genl_op_iter_init(rt, ctx->op_iter);
 	ctx->dump_map = genl_op_iter_next(ctx->op_iter);
@@ -1625,6 +1633,8 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 	netlink_policy_dump_free(ctx->state);
 err_free_op_iter:
 	kfree(ctx->op_iter);
+err_put_owner:
+	module_put(ctx->owner);
 	return err;
 }
 
@@ -1761,6 +1771,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 
 	kfree(ctx->op_iter);
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 
-- 
2.53.0

