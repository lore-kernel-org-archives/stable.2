Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD435CB7C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590005; cv=none; b=iaUrcuOiCH6CM1ZrIkkBUtsDFPnurfkg1jdDcD0rKupkYb7iQW1FYcOvWV/8vHnAUkHuAhByuhc5x15gZVCXsmziDCHTBAqrwkhJo6Sf4FlQ+9MWo0rPDFyyJ597qTPmgPk1OVw+B0050hpl7zXAaMzC1ZhILyJURBaLOR/q6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590005; c=relaxed/simple;
	bh=t/4clch6UxHX/Z9Z5PmFPaYQw4m/1vRlmaBXqqCKxf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wln9CCQ1HmdgRzAjC5Xw8kbKTLLGK3gsfHTqF3jx7/oadlMzYSLJB4b5GlFEE/g6hzkcyR6TcjdYVKECJT1NONVXi2+vWlqW33i8ib/rGHl9+px60ULAj2guFuc5ecR5KX8E1UvQ5bNsxwfzxUpKasVrriSiwh0o74j47UrxXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDtYDmub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDtYDmub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2DC1F000FF;
	Wed, 16 Sep 2026 20:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589999;
	bh=SsEbxlz2w1qJNX8VdaHgZlCm4wv2hjDRzb4QIQXu4Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDtYDmubJo9xf+2NCVUH9VQqPjCWujvEREDg1tv/WSYFAbxnTnkm8iuGTkJJ5J4nb
	 uB1plgdXac5/V8NkcUCkOw3o/5tBhLHeSIo6eBQjn5fN9fJAgY5mD6dvkSTvi2mivc
	 awdDynQJjRKNhR9e7+gcnwM15lJZHYOwKptx+xlfcUu7bU90aorMmgv3qcIpAwkjYy
	 6RDqlmXEKVJA7GW138uJE5qEt+qINCmXoPhnAS7u4f1Fl0f3F0h/WOztgd0S6Pu2YP
	 Q9T2LbsedpFedkky3X2B0WXbqAWEcLN7Be7nxYyOOEd/mSCS8e90/KVLiVZaqWk3EG
	 TIVlbz8TqCgig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: XingWang Xiang <v3rdant.xiang@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] genetlink: pin family module during policy dump
Date: Wed, 16 Sep 2026 16:19:57 -0400
Message-ID: <20260916201958.2506150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091632-scanner-exploring-953e@gregkh>
References: <2026091632-scanner-exploring-953e@gregkh>
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
index 9825369505669..36dafe9f37c3b 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1368,6 +1368,7 @@ struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
 	struct genl_op_iter *op_iter;
+	struct module *owner;
 	u32 op;
 	u16 fam_id;
 	u8 dump_map:1,
@@ -1410,6 +1411,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		struct genl_split_ops doit, dump;
@@ -1420,7 +1424,7 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		err = genl_get_cmd_both(ctx->op, rt, &doit, &dump);
 		if (err) {
 			NL_SET_BAD_ATTR(cb->extack, tb[CTRL_ATTR_OP]);
-			return err;
+			goto err_put_owner;
 		}
 
 		if (doit.policy) {
@@ -1438,16 +1442,20 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
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
@@ -1479,6 +1487,8 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 	netlink_policy_dump_free(ctx->state);
 err_free_op_iter:
 	kfree(ctx->op_iter);
+err_put_owner:
+	module_put(ctx->owner);
 	return err;
 }
 
@@ -1615,6 +1625,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 
 	kfree(ctx->op_iter);
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 
-- 
2.53.0

