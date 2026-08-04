Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E494570C9;
	Tue,  4 Aug 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833455; cv=none; b=MkUAX7RgB9IB/Ki8+atqRchHIrgOPS9lLKopipQsHYYkx9aU7ufeIQBQJkN1GpHsq2VGtSxuslck+6O1WAqDs3XeeXp1lFoT8txERa6meEMBMdLmnQbhwwqNk/xIc/ham6cp1w08GR5OmX5enW/Uhs99q2l7ziEca+DxQECGVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833455; c=relaxed/simple;
	bh=GhANxRpAyu/KCkIgpDUCIepXUdGoiRJbd1x17Sr/Kvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4ozn099MIFSDYsxha7A4O7GWcu8qiY+2nStwUY6qiH6W5T6VbIKkcOJNXKKUC21mprIcZkC2bOy7+4zGt5Cf1h91Jm2nxdl3KxEdeDfff6Kp/4u44M7bgbBeOtgCSiBIOW/b5g33/AU1d8dsMPy2Iz/Pfg86RtLvXx/ltzpsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESKSqjXX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESKSqjXX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC29AC32781;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=GhANxRpAyu/KCkIgpDUCIepXUdGoiRJbd1x17Sr/Kvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ESKSqjXXa/wn/WkDXS6jeQObwDt3s3LJL2VCNJtAq+gbamyvwb91t4WesJ6a0MkuF
	 u6z8UADaF7/oyby9sJLP/sudQIhzgqv2G/h+sEvwpu8CJpE5oUI2XFB/FZsNVEmHlV
	 laV3cnpTU6Ru/6Cj8djZKLQZEWa4nlX8gRMz+v+m7/Xw5oy/KLb16wvHdNHJKdK7mo
	 L9AerNX+KEWbfBbuzkok7ptVIHqfIh3sPaeB6Sq4JFRSRajhwTYsAUhebyD4HxQERX
	 9stg7Ibc0oo2vPFSO2ZGZNbB+qKyBroWRdt6GiQrdrPzhDt6BRgC6an0XRFk0daZ8c
	 cnV9UqiitqlDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FEC55184;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:41 +0800
Subject: [PATCH v2 4/5] powerpc/spufs: fix deadlock on gang creation
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-fixes-v2-4-5bfd827297f9@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=Cj2YqlgaZpS5pzQnZtV4Ucl3WQDjefs7reGQ8GjrlS8=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlb6z8KpX3rjeYmVNQWXmXr2Xh382Xyje/KLY+2
 nnSZjNXTHJHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATET+C8P/jOTkSPaFHw5L
 OU67oNHz4MRr8YNf2Pv/vnI1YN/4yDSBm5Hh+b7oApZtpxPcZ/qdOWIkHVpfw7Jnd0M8z7Qpv6W
 cdfZwAgCYhkxU
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

do_spu_create() enters spufs with the parent directory's i_rwsem held
for write, taken as I_MUTEX_PARENT by start_creating_user_path() and
dropped only by end_creating_path(). When spufs_gang_open() fails inside
that window, spufs_create_gang() cleans up by calling unuse_gang().

The gang was just created, so gang->alive drops to 0 and unuse_gang()
proceeds to simple_recursive_removal(), which takes the parent inode's
i_rwsem as I_MUTEX_CHILD. This leads to the task blocking on an rwsem it
already holds, leaving the spufs directory write-locked. The other two
callers of unuse_gang() do not hold the parent lock: spufs_gang_close()
runs from ->release, and spufs_dir_close() drops the parent lock first.

Tell unuse_gang() which context it is called from, and use
locked_recursive_removal() when the parent is already held. This matches
spufs_rmdir(), which spufs_create_context() already uses for the same
cleanup under the same lock.

Fixes: c134deabf478 ("spufs: fix gang directory lifetimes")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index c2b15c30f7c0..998512409552 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -175,7 +175,8 @@ static int spufs_fill_dir(struct dentry *dir,
 	return 0;
 }
 
-static void unuse_gang(struct dentry *dir)
+/* @parent_locked: caller holds dir->d_parent's i_rwsem as I_MUTEX_PARENT */
+static void unuse_gang(struct dentry *dir, bool parent_locked)
 {
 	struct inode *inode = dir->d_inode;
 	struct spu_gang *gang = SPUFS_I(inode)->i_gang;
@@ -187,8 +188,12 @@ static void unuse_gang(struct dentry *dir)
 		dead = !--gang->alive;
 		inode_unlock(inode);
 
-		if (dead)
-			simple_recursive_removal(dir, NULL);
+		if (dead) {
+			if (parent_locked)
+				locked_recursive_removal(dir, NULL);
+			else
+				simple_recursive_removal(dir, NULL);
+		}
 	}
 }
 
@@ -204,7 +209,7 @@ static int spufs_dir_close(struct inode *inode, struct file *file)
 	spufs_rmdir(parent, dir);
 	inode_unlock(parent);
 
-	unuse_gang(dir->d_parent);
+	unuse_gang(dir->d_parent, false);
 	return dcache_dir_close(inode, file);
 }
 
@@ -483,7 +488,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 static int spufs_gang_close(struct inode *inode, struct file *file)
 {
-	unuse_gang(file->f_path.dentry);
+	unuse_gang(file->f_path.dentry, false);
 	return dcache_dir_close(inode, file);
 }
 
@@ -520,7 +525,7 @@ static int spufs_create_gang(struct inode *inode,
 	if (!ret) {
 		ret = spufs_gang_open(&path);
 		if (ret < 0)
-			unuse_gang(dentry);
+			unuse_gang(dentry, true);
 	}
 	return ret;
 }

-- 
2.51.2


