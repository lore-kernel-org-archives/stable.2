Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8D44E666
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932141; cv=none; b=obeeE95WMaPN0Ti0jkOpKuD5Qq4bU+46MVZc0cCeGVDPCEJh8KsYT7ua6+HeDOxIOe9J2MOITZ42gLTehrtrDL2VaJ0aLNID8faKlYids6ocYrvV+RdvsAR0vrzVqW3DuevojU1HQSNei0EJyNA0sritL32V/qLCCfT6mM2Dt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932141; c=relaxed/simple;
	bh=6YE461QSlWbAEdxuVFSeCih/ukciawg2sX3ZYQ5v4Vo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a0+b35d2zw0BK6b8fLmR6CG3jpyHKy5WM+jR5mKpDU8hWCHwH3eDlLz/s3iFit5jA766D8Sawxef/FkeG63gwuP/XrRP5Zu8MbC9DnZyRDFw4V+Dd0tRs6SKo+PEWQhFxkqn2EnY7Y5Ga/ImOPRtOxGUjxo/WVcydmEQj0VctTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wS/6Keex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wS/6Keex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D32B1F00A3E;
	Wed,  5 Aug 2026 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785932138;
	bh=yB//RZgM+9Omv6YiAxs+st6vhwXGS1EoMECajB2e244=;
	h=Subject:To:Cc:From:Date;
	b=wS/6KeexINiSKJBRdVlN6Y6Ypgbu1TXA+8q2uMwE4HMeCc1besoTore+mZ54yi334
	 6W+NmfJNJZtVDyA6FqsPqKINj65v5bOF0flmmkCF/cp/MnsV9mTmy3lLNLidxU7Bdz
	 M3a63uEb/Zwy6qN+eabyHQcLUHcGIa3i4haeVjJQ=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: reject DX_BIND_QUERY without a DX context" failed to apply to 6.1-stable tree
To: zack.rusin@broadcom.com,ian.forbes@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:14:54 +0200
Message-ID: <2026080554-irritably-chase-d242@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 55ec09c9ce10b1272802c7ab6c1be2ea0dbc68db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080554-irritably-chase-d242@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55ec09c9ce10b1272802c7ab6c1be2ea0dbc68db Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 5 May 2026 18:22:23 -0400
Subject: [PATCH] drm/vmwgfx: reject DX_BIND_QUERY without a DX context

vmw_cmd_dx_bind_query() unconditionally dereferences
sw_context->dx_ctx_node->ctx.  Userspace can trigger a NULL pointer
dereference from any render-node fd by submitting an execbuf with
dx_context_handle == SVGA3D_INVALID_ID and a SVGA_3D_CMD_DX_BIND_QUERY
opcode in the command stream: dx_ctx_node is left NULL and the kernel
oopses on the assignment.  The same NULL is then re-read in
vmw_resources_reserve() via vmw_context_get_dx_query_mob().

All sibling DX handlers fail-close on a missing dx_ctx_node using
VMW_GET_CTX_NODE().  Use the same pattern here, returning -EINVAL up
front before any relocation state is published.

Fixes: 9c079b8ce8bf ("drm/vmwgfx: Adapt execbuf to the new validation api")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Link: https://patch.msgid.link/20260505222728.519626-3-zack.rusin@broadcom.com

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e1f18020170a..b07f052474d0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1272,9 +1272,13 @@ static int vmw_cmd_dx_bind_query(struct vmw_private *dev_priv,
 				 SVGA3dCmdHeader *header)
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXBindQuery);
+	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	struct vmw_bo *vmw_bo;
 	int ret;
 
+	if (!ctx_node)
+		return -EINVAL;
+
 	cmd = container_of(header, typeof(*cmd), header);
 
 	/*
@@ -1288,7 +1292,7 @@ static int vmw_cmd_dx_bind_query(struct vmw_private *dev_priv,
 		return ret;
 
 	sw_context->dx_query_mob = vmw_bo;
-	sw_context->dx_query_ctx = sw_context->dx_ctx_node->ctx;
+	sw_context->dx_query_ctx = ctx_node->ctx;
 	return 0;
 }
 

