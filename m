Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643B521215
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572531; cv=none; b=SgrAf4MMauXAYIuaMhVlTG+5XZH0gUSdsh7eu1fJOssOcNWmgYAZvwWr8HS6QjRD6VwtahgE+5t0EXn0LWqGXjL9PO49lSMIqbni2zwnVMmWgUtb9m+Bd2gI1agRUI1Jd3d8YAPVrx7s0ZGcaGrsVnm7PPMMdXzJfCfr3f82jLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572531; c=relaxed/simple;
	bh=gT6+GXTroNzTmTGY9dRnz+cKBTagAqPG2o7ZvaB+yXM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EFAFK1hDgS7QcUcjWRgMXvJtWhN/YoJL8MxYZ9NPASqhG9E26bxtqToP6ohtqDDb6GPzycXURtqR+RcliomNS9LnACgh4LD8Q7ayuEx51I3jucliu6M8wYenGZPX1F5//owYF0bu7UmB+myrirURfsqgXlssMM7G8QmHUyghz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vptiOvdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vptiOvdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F1E1F00893;
	Wed, 16 Sep 2026 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572524;
	bh=ZB/2yvvdwPct/NK5tHF2u/udiNKz8nHct99RilI6S/w=;
	h=Subject:To:Cc:From:Date;
	b=vptiOvdXFNvroJHU6WxxXBIWbvPc0liTi3YYLIQ9I0wV7J+oPavrk92VFqFqlOdJR
	 +i+6eY3i3NTBYpGRjxKTay6e0HnbL+J8n1KVOmsQU7XFm9SzGR+jtG5gLCqLNXTAR0
	 wtNfrrhF7OWS7V7akIeASwBI3BkXNMd5QNrwgaMI=
Subject: FAILED: patch "[PATCH] genetlink: pin family module during policy dump" failed to apply to 5.10-stable tree
To: v3rdant.xiang@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:17:34 +0100
Message-ID: <2026091634-denote-lushly-93f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6a1094c34d176827b2b173e163dcc964a13af93f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091634-denote-lushly-93f0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

