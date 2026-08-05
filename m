Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09445DF5C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932139; cv=none; b=ChG4uLwU8lZTDTKJE9hKyRoN4Q5Mj/KJ57jsCN5yUVIG0uBnN4m54yYj1f9ueigNnTrDu5y9KJm5F2Xab8gxIK9x+t1h/YGPtaEOO4QJ5EK9TQBHrXJXdgUXmQtVKq+ixZYNXH9VZOImeQ4G8sxcODh0ic6ejP34be6rQpH0SsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932139; c=relaxed/simple;
	bh=QPCR9deDQ5doOxzxKtdzHgSH5cx1V18QYOhq0TF8T/I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nVCy81Jbax2Oae6zG4tEC/wwijScGOgc8Ey0AhhL3REJup5A8YFZ+p79QffUthjcSfZ2d+bCCZexCSZWKY2IL6KJYqVRRaFLKxLFGmWHsi6K7M+8GS6s0Fa62Wb2482OO87yF6inJOZ7ZIN9azmbGyS2VHHqs6vXwsYil8MslpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mhRLa9BK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mhRLa9BK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880E71F00A3A;
	Wed,  5 Aug 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785932136;
	bh=s2jtzQDwAXrQz2BLbxJpbejE03qaKCQDwJ2ElNZ9HR4=;
	h=Subject:To:Cc:From:Date;
	b=mhRLa9BKfC50awlnTduN6zQKklD+4mOaccLW0TOigKEOTjadBUuwzXCdsdFg5M1Xt
	 9C+++iW4c80VUqEdR4pQxIvXTkvb6ypderTuKzOXMVy7m3XxpA/uFIKSX9dg9LXVpX
	 DV/Cb7zHOWDq4mLO/LmHYrUF4O7rAl0excr9MnPU=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: reject DX_BIND_QUERY without a DX context" failed to apply to 5.15-stable tree
To: zack.rusin@broadcom.com,ian.forbes@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:14:54 +0200
Message-ID: <2026080554-crevice-snuff-ec4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 55ec09c9ce10b1272802c7ab6c1be2ea0dbc68db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080554-crevice-snuff-ec4b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

