Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D23BB9F1
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785076786; cv=none; b=nZ2PzQBZCXoQp+C6azs3ie3mXAL+M1lxZcgTd7QCUuDL73Ab6Gjpp3+wjgwSxnR9l9FDNhB62lcaC91uIJztJayIqUKmkS04KA/gJOf5SpsA6nsGxffg2E675jMNfrO05DvtATXHfaZOanV90YKDbOM6MIckMkpxmdB4t6EfyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785076786; c=relaxed/simple;
	bh=d5G61n9DCzJoG1XlOEr5f4M+FNe1kTeCxwulfyig4F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDsfJ8DYWX/P7NMdfsdmtKd3Ii64EFu8h82noCn7E22WBgvsxCOqJk/o9yJ5sgHmt+TDAhBmG1Il1hXfahBQQ4mi81UsivET0yp23jAJOWnnFpnDWEWU+G3ZwqrJjBu7RdCItZayU6zdXvHVVHIGS9+DIYGlQh5244EOsf27myA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTx4BP3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTx4BP3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F081F000E9;
	Sun, 26 Jul 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785076784;
	bh=BGUKuvrecusY5Fj/XRT2hHuXbxehdd7K6sOES19ki6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTx4BP3oNYHJEP8Ga0YFDxentYsl146TGMzFtR31Sr9cQrlr0UzXjgIsZAOclc6vT
	 SRjSTLGsEVAw6fgeobppl/4fwa+7OHXtlFmxGlth0GJ2GZzLwo7uOaCHnO3AG5etPB
	 toqkR6sKDJUpagJjr0Ghs+6EUOJ9zd8p1QQxsDhf11VzWZmidHY/OCwPTddf5Uu2B1
	 iF0fm+rg5u5aJWeQ5a5WZPyNij4kdqjjPgp4EL8T7k+8cELeOh/AUQWDk243BALblj
	 6qUkNzxC4xREJFa8cS7YsBCBcGrT9PnkRIWri7P0RLwjNkFxUsgo1/GmV+RbFn+/vo
	 603JXa08gYjrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: use kvzalloc() for megabyte buffer in simple fallocate
Date: Sun, 26 Jul 2026 10:39:41 -0400
Message-ID: <20260726143941.1052693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072058-blaming-unseated-0a99@gregkh>
References: <2026072058-blaming-unseated-0a99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fredric Cover <fredric.cover.lkernel@gmail.com>

[ Upstream commit 806c00c23e3ce8eae397a40ced536ef88ae4e012 ]

Currently in smb3_simple_fallocate_range(), a 1 MB buffer is allocated
using kzalloc(). Under heavy memory fragmentation, a contiguous 1 MB block
of physical memory (an order-8 allocation) may not be available,
causing the allocation to fail.

This failure was observed during xfstests generic/013 on a 4GB RAM
test machine running fsstress:

fsstress: page allocation failure: order:8,
mode:0x40dc0(GFP_KERNEL|__GFP_ZERO|__GFP_COMP),
nodemask=(null),cpuset=/,mems_allowed=0

Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 warn_alloc+0x163/0x190
 __alloc_pages_slowpath.constprop.0+0x71b/0x12f0
 __alloc_frozen_pages_noprof+0x2f6/0x340
 alloc_pages_mpol+0xb6/0x170
 ___kmalloc_large_node+0xb3/0xd0
 __kmalloc_large_noprof+0x1e/0xc0
 smb3_simple_falloc.isra.0+0x62b/0x960
 cifs_fallocate+0xed/0x180
 vfs_fallocate+0x165/0x3c0
 __x64_sys_fallocate+0x48/0xa0
 do_syscall_64+0xe1/0x640
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Node 0 Normal: 3375*4kB ... 7*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB

Since this scratch buffer does not require physically contiguous memory,
switch the allocation to kvzalloc(). This retains the performance
benefits of kmalloc() under normal conditions, while gracefully falling
back to virtually contiguous memory when physical allocation fails.

Fixes: 966a3cb7c7db ("cifs: improve fallocate emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
Tested-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index bd4ea48e057613..0f9b93666df813 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3567,7 +3567,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	if (rc)
 		goto out;
 
-	buf = kzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
@@ -3624,7 +3624,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 
  out:
 	kfree(out_data);
-	kfree(buf);
+	kvfree(buf);
 	return rc;
 }
 
-- 
2.53.0

