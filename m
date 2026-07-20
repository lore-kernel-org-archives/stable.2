Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43914192FC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550950; cv=none; b=dS8ssYoPVxg6nYcO8o2wZwCehjF6ggFQbmIU+46rbvEnABVKknxdvTCIOyukbCJrlcdmpcbuL8Znx+BPAzSlmcMJlppkl2OApTRfJ4Hug31GxXoUafLNgHh4axIGoMr9qshjugKfX/d2fGL4qa8v32fddv04GfSg22t5tWvz3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550950; c=relaxed/simple;
	bh=E7zbKHES6iqtj6FgAHcQU4YvCRKJD0h1dE1asWhHh1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XG2utaB667MFhvHXAzfJfro8Mh+3ef9xaBXeFCgFjR72upFLIeyzur07WOLCXtKekQXlhErWVhrBoPGAvWs+97sA5NFOnbdr7pNmLAvaiQcFUOjUuNcNQV5yzlS9CX2goVluaCz3nCbd6S7F6NN2kFkQkACGsjJyvz01+kn4VvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hYKFY1ZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYKFY1ZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD121F000E9;
	Mon, 20 Jul 2026 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550948;
	bh=hnBmmmltB6LX8qNdrDRErFxKOP/ph3pWz65qI3l1gX4=;
	h=Subject:To:Cc:From:Date;
	b=hYKFY1ZJ6nXkMeNT/qB2PYWsIlqKPiNPpOAFBBSqOq8g5lCWZG+5tQHDOmpqEs4Ru
	 6uGOkfzKHPCFwenLNRMV/J920Kte5TPY41gkANvVxraXnz0ijs7ZEovysPpfb337uR
	 9u5GEbpgHuQZc3HdoH91aclH/lCkXzdHyglU+J3I=
Subject: FAILED: patch "[PATCH] netfilter: nft_fib: reject fib expression on the netdev" failed to apply to 6.6-stable tree
To: theodorlarionov@gmail.com,fw@strlen.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:33:54 +0200
Message-ID: <2026072054-folic-tartly-6b52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d07955dd34ecae17d35d8c7d0a273a3fba653a8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072054-folic-tartly-6b52@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d07955dd34ecae17d35d8c7d0a273a3fba653a8c Mon Sep 17 00:00:00 2001
From: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>
Date: Mon, 29 Jun 2026 12:53:11 +0200
Subject: [PATCH] netfilter: nft_fib: reject fib expression on the netdev
 egress hook

A fib expression in a netdev egress base chain dereferences nft_in(pkt),
NULL on the transmit path, causing a NULL pointer dereference at eval.
nft_fib_validate() masks the hook with NF_INET_* values, but netdev hook
numbers are a separate enum that aliases them (NF_NETDEV_EGRESS ==
NF_INET_LOCAL_IN), so an egress chain passes validation and then faults.

Add nft_fib_netdev_validate() that limits each result/flag to the netdev
hook where the device it reads exists: the input-device cases (OIF,
OIFNAME, ADDRTYPE with F_IIF) to ingress, the output-device case (ADDRTYPE
with F_OIF) to egress, ADDRTYPE with no device flag to both. Also restrict
nft_fib_validate() to NFPROTO_IPV4/IPV6/INET so its NF_INET_* masks are
not applied to another family's hooks.

Fixes: 42df6e1d221d ("netfilter: Introduce egress hook")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netfilter-devel/ajxsjcDOnwllMfoR@strlen.de/
Signed-off-by: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index e048f05694cd..89555380f1c5 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -31,6 +31,15 @@ int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr)
 	const struct nft_fib *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	switch (ctx->family) {
+	case NFPROTO_IPV4:
+	case NFPROTO_IPV6:
+	case NFPROTO_INET:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
 	case NFT_FIB_RESULT_OIFNAME:
diff --git a/net/netfilter/nft_fib_netdev.c b/net/netfilter/nft_fib_netdev.c
index 3f3478abd845..5774a7544027 100644
--- a/net/netfilter/nft_fib_netdev.c
+++ b/net/netfilter/nft_fib_netdev.c
@@ -50,6 +50,33 @@ static void nft_fib_netdev_eval(const struct nft_expr *expr,
 	regs->verdict.code = NFT_BREAK;
 }
 
+static int nft_fib_netdev_validate(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr)
+{
+	const struct nft_fib *priv = nft_expr_priv(expr);
+	unsigned int hooks;
+
+	switch (priv->result) {
+	case NFT_FIB_RESULT_OIF:
+	case NFT_FIB_RESULT_OIFNAME:
+		hooks = (1 << NF_NETDEV_INGRESS);
+		break;
+	case NFT_FIB_RESULT_ADDRTYPE:
+		if (priv->flags & NFTA_FIB_F_IIF)
+			hooks = (1 << NF_NETDEV_INGRESS);
+		else if (priv->flags & NFTA_FIB_F_OIF)
+			hooks = (1 << NF_NETDEV_EGRESS);
+		else
+			hooks = (1 << NF_NETDEV_INGRESS) |
+				(1 << NF_NETDEV_EGRESS);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return nft_chain_validate_hooks(ctx->chain, hooks);
+}
+
 static struct nft_expr_type nft_fib_netdev_type;
 static const struct nft_expr_ops nft_fib_netdev_ops = {
 	.type		= &nft_fib_netdev_type,
@@ -57,7 +84,7 @@ static const struct nft_expr_ops nft_fib_netdev_ops = {
 	.eval		= nft_fib_netdev_eval,
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
-	.validate	= nft_fib_validate,
+	.validate	= nft_fib_netdev_validate,
 };
 
 static struct nft_expr_type nft_fib_netdev_type __read_mostly = {

