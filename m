Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE984570C5;
	Tue,  4 Aug 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833455; cv=none; b=ssJUJ/GDQT5EShZteDDcH541ZnQENr0KKynpI0zuGl3Jim0/o92mW215K61aXtfm9bjqyvD9Oj5EyLFjupbun/SV3wXLqZDRM2JwNl5z9kHBAUr2I04i/onqAqX6bXwvBTywdlH6r8Rw6gg1WWxvGOmZloRdv80OX3sgrrzh6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833455; c=relaxed/simple;
	bh=afJAMLbhFODoEcveLVFFRIw8h+QDoAijPxkIMhvX5Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1rOIoo2Qdwbe1o3HcQ+jj4VKoAgU9u5OgPzNm3jJ+3JDImR65/K/gTNzDFHNEpGYmfR37oKCAQ3hpt2F26aq4zBj+ulOMTFogolbnr7nJaq3WoX2c//BEYEs2oZDxTNPt3W4XGJpaooPnDiVOw+KenAwCZLj0wT8B/3oRKDMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU4dTuRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU4dTuRI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D39C2BCFD;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=afJAMLbhFODoEcveLVFFRIw8h+QDoAijPxkIMhvX5Oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eU4dTuRIPB4xWAu9Ya4VG5C95yTBDgyq2cEThTJGEvoWzxaI8blP/rPPPZx1tsPXA
	 qUx5LyIX4ZvGzGUMaN42zS9TmqJ5YVTYhLz8JyEhttnja7m6dNSZACKV5rFkb8Et+z
	 5Ud1ioWuadi6TjLP+SuqYrEcK7fU/AOXS/MJDjdbo+PLtQjj+UZ7JTRkXfJ1H9GCq1
	 U+wP9fVDVBYqcqfe206tWQiTcN8gzk/IJLMMfsQ2i9OHCcd/9AtYC+Pm5YfuEJ/XAx
	 NGXxTFnjOwXudiphSsTNR0x09cvaiIMenlxh2anYjzxPpQ0uwUh1YCYoxwQeEA4jUT
	 TCell6G3Nke9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DEC55ABA;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:40 +0800
Subject: [PATCH v2 3/5] powerpc/spufs: check permissions in spufs_setattr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-fixes-v2-3-5bfd827297f9@outlook.com>
References: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
In-Reply-To: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@ozlabs.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=dffeiU9SuIG2crRu8M1hNRxZHn/iEzt/PMyihiDEjKQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlbxTVjPNSXmaeOhL321xIPc/iZOt5vyTxgAsyW
 xgYFVrab3eUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARJScGBkeBFrNO/D0QJBQ
 //p0rZh1Xe/62jdz7osUfpo4W4BxVdcmRob9zxY7Pl1XmXm4LKPmtcy9NE23/HCHklOHvq/d6bh
 B8z4fAOdOSp8=
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
Assisted-by: Claude:claude-opus-5
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


