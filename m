Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17722253A1;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513697; cv=none; b=gJzTK9wflLoxEliJFH4fhpNfR94qZlvHU1Bf2fXKVDnGIYEgmXf9wtbce0EgvcXSuv7oE7naSWv8TAFgG2EbzYeVduVUl7i08mc7TGACVUxM6vIoGP895vvy7EMHtnkUgaR4NMuvdSkkpxDadRkiNBCGxWcxok5tl4etD5aCT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513697; c=relaxed/simple;
	bh=2Ef7G09j67/eoUC8SK2Ltteg4MTYzAdNGnUkoyKYleg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDcKmDsFslA5kjJDMYNwFHErdhoJyZlgn0ST8Wobe+SIvOCTN9mqeMectceUYg2CSVEZGV8DPVuUhiKmAusapFkw4Q5Yi47W1qPQy4b3d/yEm6JZtiOF8+lHLs5pW7eG3Lmvzit4YUtQQ8+VxyhLs7XN+l6WSffgMBNu0tX794U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj5LWPR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hj5LWPR1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACF41C2BCF6;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786513696;
	bh=2Ef7G09j67/eoUC8SK2Ltteg4MTYzAdNGnUkoyKYleg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hj5LWPR19q3Xoks4xzKyly0Lmc0JovtQdKa/NFqlIzOTVi/c2D0KMLbCV4PDtCxn8
	 W7O0n2T2Oi7M/xdv2blOn3m4s0gGfAGkwpZMEcZWHCvJqCkdepVEZb8LMjOR4G58DZ
	 kdkxiFUNJECmFZ4xZbkwUcjPrqog2kCFUVZl0jg3H/G3bCez2dlNOldAUxts/+pZPG
	 I2C4OUc3AKBIz9e3sOJtre+k/PejVDuir4ZRmRrtpEkTwnPjBwtGDTjK+D1DkCTMuO
	 nbgUwfrFnAqSPAvLV4I/xIrwBHuTfPGF8lLLjuZNNoympbo3fw65/npQVFBY7yrEyR
	 RxCU174uMPL3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFBFC5B567;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 12 Aug 2026 13:48:07 +0800
Subject: [PATCH 1/5] powerpc/spufs: fix memory leak of spufs_fs_context in
 spufs_free_fc()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-spufs-fixes-v1-1-449e201d9f64@outlook.com>
References: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
In-Reply-To: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Paul Mackerras <paulus@ozlabs.org>, 
 Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=7tJ0E00IsnJBei3nS8CdVd0Qh/gBecZOpc59xKiGh0k=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpOWbe6PYdDbk6eKcG3yuT2bsbKWTKZM88uLaw66
 pOXwejldb6jlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJuKrwvDPKIS9wVS0bsm+
 ufOuxTn1rIqYMKnaalX4pb0aDw6LPTHiYPin0BNay8Rec2FX46YA1YZni+1YFi74u+HmNc+Y6Ig
 ey9e8AF6eSFU=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spufs_init_fs_context() allocates both a struct spufs_fs_context stored
in fc->fs_private and a struct spufs_sb_info stored in fc->s_fs_info.
The ->free callback spufs_free_fc() only releases fc->s_fs_info.
put_fs_context() never touches fc->fs_private, since releasing it is
what ->free() exists for, and vfs_clean_context() calls ->free() and
then clears both pointers itself.

Every spufs fs_context that is constructed and torn down therefore leaks
the struct spufs_fs_context allocation. The leak is reachable without
privileges: fsopen() runs ->init_fs_context() before sget_fc() enforces
spufs's lack of FS_USERNS_MOUNT.

Free fc->fs_private alongside fc->s_fs_info.

Fixes: d2e0981c3b9a ("vfs: Convert spufs to use the new mount API")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2b54afb31529..51c432864f02 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -713,6 +713,7 @@ static int spufs_get_tree(struct fs_context *fc)
 
 static void spufs_free_fc(struct fs_context *fc)
 {
+	kfree(fc->fs_private);
 	kfree(fc->s_fs_info);
 }
 

-- 
2.51.2


