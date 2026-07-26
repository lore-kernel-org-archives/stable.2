Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DC481B1
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785075701; cv=none; b=AmyvpA+MN1+t6KweHfb1XeQrykBUxPerc6vwmUHsgEzTpXvNGNiCTOxovUfZDGft0MQtsQHDBLG8gnfAnvwBAeH0jXiw5U1FeRtmzXk5OZBFiqcf7ae5lbpIKMYZD5QoCAskftjOmN81YuJVCt8iqZYeWvKtglmpy+0AKeyv18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785075701; c=relaxed/simple;
	bh=H7eYodIfl+nXdSlrD0q8+EJXdPa68oXV9C44GoUeB1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg9Ga8fh+tpCq/8aa8JHICsVdjPnCpA/SxQvl5/sksU7XJI2FB2qvl99Y/o4u7rvNTcNT6m0s2G0EBcdB8/eV2KzllTdcT048lUpIrW8q7DyWV8TThFJBkkzht6H9IBzhutlFHViLxfO0uT05Na7tNO/hFsXKxp9OFO0VrBwh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCIaTYiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCIaTYiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78661F000E9;
	Sun, 26 Jul 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785075700;
	bh=U7CvhtGicJM0G44hBDs24lA69MIpO17jYMU1UcyX/Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCIaTYiPONZ7Bd7vnnIyK3Z+RI/1Pb4BClYon1MDIPlZ4soBx7nWYThuEhV3Se5DL
	 oCY1dFyQPRVENZxmV0p1uSwiLVXzBS+KAWn73YTVeJvSqoMIcvvUkHTppw95P6hL14
	 IsGFcIl/D+gjXWkqDK4ahYdqUOu3iL9jzRyqezXOCQIF1mJmplXrdQ4g/JY1IqUlgg
	 48Ff56AuxGIc79qTX6erg34qqRAIjCpm8uAgrRA11QlIagTpwcjMSPn8xzDmOgifnW
	 8+8cnCoohSvwQhvZsvywNdgZuBSuUBGGxJMdTXh/f6WqU6XWKy3hc7TLXsr59u06RR
	 IGg1PCyNQ6uww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: use kvzalloc() for megabyte buffer in simple fallocate
Date: Sun, 26 Jul 2026 10:21:38 -0400
Message-ID: <20260726142138.929820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072057-hurled-heap-2563@gregkh>
References: <2026072057-hurled-heap-2563@gregkh>
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
index 5d80ab4fa08777..b62b2aed979d42 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3735,7 +3735,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	if (rc)
 		goto out;
 
-	buf = kzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
@@ -3792,7 +3792,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 
  out:
 	kfree(out_data);
-	kfree(buf);
+	kvfree(buf);
 	return rc;
 }
 
-- 
2.53.0

