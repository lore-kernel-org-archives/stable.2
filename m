Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325EC3BFACC;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685914; cv=none; b=D5BT0ynrD9SNei1QWLG6R9QUo24BmYIxP9F8tiGL5zcMTn9bf0bGOy8JI0hBVhGfeQw9b9LsKDhTVptkTMQHmn359dTYSF6OvDL5PPm1NJjc5PzbxjvG267fdnLeqTelrJ/PhWt7OWJmOCNn9yllTKjiBFXK3bZ4bk1DZjJ2urg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685914; c=relaxed/simple;
	bh=vXE2AV78Cf4cBIpFGvjs0Jox33f1sFJXn10xcbgQjPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUV2Z6XWF2cS/ZQry5OrAystItl9EHcLQKGaeihCg6t1gz5kQc1XhjDcrNII1OWzuQDlFr9TDmF2aQ9u9GkppYsFvnCTPB/KY8bIbqOdXjh3GG2xPgMrV9kNqhA6jLRS2jc5iJ0yTxHQi7ryN8vmJPmuYB5Cza5Bxa1GcaFQIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPQ5qquV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPQ5qquV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF73DC2BCFB;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=vXE2AV78Cf4cBIpFGvjs0Jox33f1sFJXn10xcbgQjPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BPQ5qquVL2yBC7IgjHhyEXmaZ33lBl76MgJwFZZmVlN89ZabMrOELqx2zkOZUQT6v
	 KBEt9xvewY146oze/t5oITyCztfrlHHTJ7I48EnHmSHjcqc+3MAeUrGDuYILLhdqdk
	 PQZO1v0bUYy2YD3ILlSnNyzoqd01AqnkADZlLSICunQzFy2errMfg4MafrNMxaHcd7
	 kCqmWOpxRt/IqUvyKgq32Bf137oLcsKSMXHdGlyLFP3xoKkYvsXeQkyrSvFnLS2svU
	 YAMfXmyKE4iit4Qwx7NkbyVldD2ruUiZ5h0EbE7amwCQm/rYbbuBn9p1uU51PMSCR/
	 jJrDUAkSPMIyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB682C55177;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:42 +0800
Subject: [PATCH 4/6] powerpc/spufs: check permissions in spufs_setattr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-fixes-v1-4-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
In-Reply-To: <20260802-fixes-v1-0-7368423440f4@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=bHGF2umld4asI61QtFVSR8rrvQgLxL9YyHNp5cEh3fE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz06U/5amU+1+kqnpvxr2m3yL3X705r3d7mFa16n
 O2jFc9a+eyOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmEh3ACPDgdXfpr6aZ7lX
 qGydSJf7a52yL29mya46IF605ubD/HB9XoZ/xmZmju/PyLE2+p6uiWR1iT8W9Xj+3Xs3LpXUXnW
 adfohCwAnQk23
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spufs_setattr() applies the caller's attributes with setattr_copy() but
never calls setattr_prepare(). notify_change() leaves that to the
filesystem: it runs only may_setattr(), while inode_owner_or_capable()
and the CAP_CHOWN test live inside setattr_prepare(). setattr_copy()
performs no checking of its own.

The handler is installed for every regular spufs file, so mode and
ownership of another user's context files can be changed without the
usual authorization.

Call setattr_prepare() before setattr_copy(). The existing ATTR_SIZE
test stays ahead of it so that resizing a spufs file keeps returning
-EINVAL. &nop_mnt_idmap matches the adjacent setattr_copy() call.

Fixes: 67207b9664a8 ("[PATCH] spufs: The SPU file system, base")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2b54afb31529..c2b15c30f7c0 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -96,10 +96,14 @@ spufs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	      struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	int ret;
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    (attr->ia_size != inode->i_size))
 		return -EINVAL;
+	ret = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	if (ret)
+		return ret;
 	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;

-- 
2.51.2


