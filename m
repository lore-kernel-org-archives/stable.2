Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238073B19B2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332813; cv=none; b=dymJR16pbXSIOMnVgA2VKrJPmA29heC73TULfAaMwW8D0+YSqXeBdqAAUIivRIgbUe3uGgzCer8uKEBGu2abnmdRekQzeG97rTSUmjNYIOK1lktF+hseu8YgLnBOiHkR0gxZYpzIKuUq7PC+uk/GyHAWD1cxvlmCy3mMTyj09oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332813; c=relaxed/simple;
	bh=UPCOmoKNBr9ZKeNregliNQnT2r7GhpzxgDWkpNB0pMs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lcr/DnS3k9HkGBZbmfmE84gzEecU4LqeX7UsUXsL3sSbQsIxta7gMvNZUirxrsuSYxWH355xqoy/h1EOBsqFWTAMBvDr/OA1w4x6UR/a7k6HMC7c0jnfZME+YiLmapgaDJ2hxr6rL4ZRt2LwVwSfK7HiCiQUzIK1W6o28v9Tql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1p0Ik3Me; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1p0Ik3Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FE71F00A3A;
	Wed, 29 Jul 2026 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332810;
	bh=GNqLFrKR12qyxGpDCQ5sAPCUMzmmsebRoOLXuycgvqQ=;
	h=Subject:To:Cc:From:Date;
	b=1p0Ik3Mer+EXN9OHjZ/y2NzwJmBbWyYmGW3nzezpL/n3hIc2AsEi4ZYQ5xHtrcBSo
	 q9/ZcVTU32KzWbZELdJFxDnSWVvqmfLzcEP2SHEDeTRJNKUjZ2c8X2xUAI7XROrR1g
	 E1cIV2tDynJdjkY2nosiViORwoVu+ZRE7qsD2Nig=
Subject: FAILED: patch "[PATCH] ceph: fix refcount leak in ceph_readdir()" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,amarkuze@redhat.com,idryomov@gmail.com,slava@dubeyko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:46:36 +0200
Message-ID: <2026072936-dispersal-unwanted-0d62@gregkh>
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
git cherry-pick -x c3e64079d8b9663e3998d0caac9aba915b6b93ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072936-dispersal-unwanted-0d62@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3e64079d8b9663e3998d0caac9aba915b6b93ae Mon Sep 17 00:00:00 2001
From: WenTao Liang <vulab@iscas.ac.cn>
Date: Thu, 11 Jun 2026 22:40:07 +0800
Subject: [PATCH] ceph: fix refcount leak in ceph_readdir()

The ceph_readdir() function allocates a ceph_mds_request via
ceph_mdsc_create_request() and stores it in dfi->last_readdir. In
the directory entry processing loop, if the entry's offset is less
than ctx->pos or if the inode pointer is unexpectedly NULL, the
function returns -EIO without releasing the reference held by
dfi->last_readdir, causing a refcount leak.

Fix this by adding ceph_mdsc_put_request(dfi->last_readdir) before
returning on these error paths. Also set dfi->last_readdir to NULL
for safety, matching the cleanup done at the normal exit.

Cc: stable@vger.kernel.org
Fixes: af9ffa6df7e3 ("ceph: add support to readdir for encrypted names")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..ef9e92e362d3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -546,11 +546,16 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			pr_warn_client(cl,
 				"%p %llx.%llx rde->offset 0x%llx ctx->pos 0x%llx\n",
 				inode, ceph_vinop(inode), rde->offset, ctx->pos);
+			ceph_mdsc_put_request(dfi->last_readdir);
+			dfi->last_readdir = NULL;
 			return -EIO;
 		}
 
-		if (WARN_ON_ONCE(!rde->inode.in))
+		if (WARN_ON_ONCE(!rde->inode.in)) {
+			ceph_mdsc_put_request(dfi->last_readdir);
+			dfi->last_readdir = NULL;
 			return -EIO;
+		}
 
 		ctx->pos = rde->offset;
 		doutc(cl, "%p %llx.%llx (%d/%d) -> %llx '%.*s' %p\n", inode,

