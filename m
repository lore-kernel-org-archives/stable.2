Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6552BE3C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572518; cv=none; b=Wzoe0ExCTuYd7Z87hi6u3l5a3XcWtf9YZ7tH+gTSxnQN8jbWSY/8vAWYDRrquPMoZKcxkWHaP7ugzeWyVbr6X51uGQ4hr6QoK23qgk92n8N7p6XFZstbkc/O355/o5jJnWj60N6OPlGf1/zEt6R6cLnGL34ntEbPrd2w9Ih9NlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572518; c=relaxed/simple;
	bh=dLXWQ3Lv2jlVonHiEwF7GyKcah17lLSIatDDDFUktoY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gXvVyyPGH2njQSJv+XRhT7ZWxqSK5PtWApQ0j0U1IDx741nV7HDG9DhdEhvmr0AytzojLgszAbVwr/1zGJNu70bYvRgQP6fhBX7bZVHLnMDen/JA2atiKng5XUfaGbdfxuOTk7RVULoMzHtZ0zI+ZLGJhcvmUGBxj9pXpFjXwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVQWvwS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVQWvwS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361341F00893;
	Wed, 16 Sep 2026 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572508;
	bh=GYbUx6u2MwVoPSJluUEsFXprScEI3Uxfj7GSBgz9i00=;
	h=Subject:To:Cc:From:Date;
	b=AVQWvwS39pLuX1XaTIKuh6IEcOVFov9l9S4qNAkcJpV0S56d7+++bm9DI6XMpMqNP
	 8/FsJvCkjPvMio/ePz+US1D7HbvRdgA9w7elRT/c9Ytw52sc4Pn0TvRQqwfOlIan4h
	 knqCTKiVIi+eG8P7w1pvx1mcX8SCcrLT796Jg7PY=
Subject: FAILED: patch "[PATCH] genetlink: pin family module during policy dump" failed to apply to 6.12-stable tree
To: v3rdant.xiang@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:17:31 +0100
Message-ID: <2026091631-barista-ensnare-6605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6a1094c34d176827b2b173e163dcc964a13af93f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091631-barista-ensnare-6605@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a1094c34d176827b2b173e163dcc964a13af93f Mon Sep 17 00:00:00 2001
From: XingWang Xiang <v3rdant.xiang@gmail.com>
Date: Wed, 2 Sep 2026 17:43:17 +0900
Subject: [PATCH] genetlink: pin family module during policy dump

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

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 0da39eaed255..41d37442f186 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1513,6 +1513,7 @@ struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
 	struct genl_op_iter *op_iter;
+	struct module *owner;
 	u32 op;
 	u16 fam_id;
 	u8 dump_map:1,
@@ -1555,6 +1556,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		struct genl_split_ops doit, dump;
@@ -1565,7 +1569,7 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		err = genl_get_cmd_both(ctx->op, rt, &doit, &dump);
 		if (err) {
 			NL_SET_BAD_ATTR(cb->extack, tb[CTRL_ATTR_OP]);
-			return err;
+			goto err_put_owner;
 		}
 
 		if (doit.policy) {
@@ -1583,16 +1587,20 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
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
 
 	ctx->op_iter = kmalloc_obj(*ctx->op_iter);
-	if (!ctx->op_iter)
-		return -ENOMEM;
+	if (!ctx->op_iter) {
+		err = -ENOMEM;
+		goto err_put_owner;
+	}
 
 	genl_op_iter_init(rt, ctx->op_iter);
 	ctx->dump_map = genl_op_iter_next(ctx->op_iter);
@@ -1624,6 +1632,8 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 	netlink_policy_dump_free(ctx->state);
 err_free_op_iter:
 	kfree(ctx->op_iter);
+err_put_owner:
+	module_put(ctx->owner);
 	return err;
 }
 
@@ -1760,6 +1770,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 
 	kfree(ctx->op_iter);
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 

