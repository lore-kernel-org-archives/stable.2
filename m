Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103663B6344
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559908; cv=none; b=LSl3IXpoPK36hiB9W1I2o6SqYNfGuEhM6rTik1r8UzSAW3z9RUDb/n5gcpzP/7m6JOOcEq6SsrfoyJIDoYT+hP9hvA11QJ34fn9lQJEgOVApCR+PP7+JaHo1emyR2srGpZDn7/jhIFqLMVPd+kVo/OQzl73vC6f/JF92fmhOjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559908; c=relaxed/simple;
	bh=eM1i293KbcMOMJRX2NSsJY2swiVge6P5UAEoUfuiY6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PLrDwoi/TFCAcOWEfklQq5A4PScS63fRAww+Y2MFl0mw6bVcoliayxpoI/YuNnbm9jhjOgxZhHCQ05E7CPKzwK6dORcZXhJ/BKh3zc5DdjhykfoyIK9/IklL4n9HRr1Bc+E08B66dSlv0UhVTOMsedLaBxtUfdQ75GHaBejrC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B029F4e9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B029F4e9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6172E1F000E9;
	Mon, 20 Jul 2026 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559906;
	bh=lf9beHSCQpaZiZkKBmGPvdMosd+wJoVepBke14e43CQ=;
	h=Subject:To:Cc:From:Date;
	b=B029F4e9UDbFwzrE29L/khV/YkedWIn3XC3DKMnVi3nrNGrsDzlIWLKS4KxMTT9LG
	 9Dkt7ZQbydW2xfMUCjNFHos0s33B1ADKbYn+t0cYmXw/vPPpgiPnddlVPy9JDwlO4w
	 RkyaW5jt/DeTMyegOBh0OoL4fA7X9M49ADnAHuGo=
Subject: FAILED: patch "[PATCH] smb: client: use kvzalloc() for megabyte buffer in simple" failed to apply to 5.15-stable tree
To: fredric.cover.lkernel@gmail.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:04:57 +0200
Message-ID: <2026072057-hurled-heap-2563@gregkh>
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
git cherry-pick -x 806c00c23e3ce8eae397a40ced536ef88ae4e012
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072057-hurled-heap-2563@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 806c00c23e3ce8eae397a40ced536ef88ae4e012 Mon Sep 17 00:00:00 2001
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
Date: Sat, 11 Jul 2026 19:54:02 -0700
Subject: [PATCH] smb: client: use kvzalloc() for megabyte buffer in simple
 fallocate

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

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6bce44b171e4..5f0e268aa644 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3595,7 +3595,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	if (rc)
 		goto out;
 
-	buf = kzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
@@ -3652,7 +3652,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 
  out:
 	kfree(out_data);
-	kfree(buf);
+	kvfree(buf);
 	return rc;
 }
 

