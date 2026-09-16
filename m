Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B204C6503
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602819; cv=none; b=F3Vn2qb4M9tRSsd5QgbGRwxAk8UiBaxt5giCV/llvOIu1IyZO15Pe0PSb4MPRhEKePYdzWz38J7paZzKwKKEyT+1f/+t4YHWBTAdXLQeu1dvipkzpH9oIEsra4sHAx7pgyYaIMWqQIWiwgpotojjQiUa7rORR178szeCWHn1O4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602819; c=relaxed/simple;
	bh=OwMEQO6aTsD33Q2bUdAxCuXuWtWxO8pZMaROmudw5Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6SD5j4vjyEnFLAZeuC6X3JY0/Uf5dSICB0T1sjU6QCpsiJq0uOrG1h4KzIQ8/SGWy1GRoJDmbdmVJLH1exMwcrZ+j52D594ksTHXnH9K+U252pQCsChLUEQLmr54TyoV4agXolHW9RPHJXJvgyajb9WEeEj2JTNLDUF2w9ybXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkDGHb/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkDGHb/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406761F00893;
	Wed, 16 Sep 2026 23:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602817;
	bh=TfeFggJfAw38Fuw5sWPgeOeU3iwXCIlebVJYg8DS0hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkDGHb/H5Ye9zIOn2cQbeGA+K262c8ywWqOwa+wgF4MpCVAlF2h0AdR3IdgVjdbfn
	 4er5bpPHaTSOEWXoTB15HcR3Y7jXhgNnRCY00jmKYW+n58Uwx8wpBSIhitje8KqwI1
	 m4lPHJeD5yBImJEqgR5aDDa7JAu5HFsxjMTyghAuVv4lW4cY5/qBzihsPTiaas29F6
	 QvGANWt3T5Flho/AsvF/S+fwMwSCqOxAhRdseHXZPNObemMs34tMqUaFdFNziHx7G8
	 cw2nBB2BTG6ZJr9a5ku2Sot13NPz/CnYKrCTjnUyWSogA3kGY/1eWZZ3T/HX6RtRV0
	 BC5MyKlTlW2rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: XingWang Xiang <v3rdant.xiang@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] genetlink: pin family module during policy dump
Date: Wed, 16 Sep 2026 19:53:35 -0400
Message-ID: <20260916235335.3313400-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091634-denote-lushly-93f0@gregkh>
References: <2026091634-denote-lushly-93f0@gregkh>
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
index e085ceec96a4c..e5c4f1d8f0fba 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1109,6 +1109,7 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
+	struct module *owner;
 	unsigned int opidx;
 	u32 op;
 	u16 fam_id;
@@ -1152,6 +1153,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		ctx->single_op = true;
@@ -1160,14 +1164,19 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
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
@@ -1182,12 +1191,16 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
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
 
@@ -1322,6 +1335,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 	struct ctrl_dump_policy_ctx *ctx = (void *)cb->ctx;
 
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 
-- 
2.53.0

