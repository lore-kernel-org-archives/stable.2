Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0929448B84
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103305; cv=none; b=N8iKef9LI2864PKvcDNYRk2bVr99SklLiSLbnvJP7i3nL8JI8+EQbmFwUx7AR6ZJZyTp3oloVp3hH1yBgLWgx6kax4Vj2jaM3Ua4Uym+Lrwrb82a2eI/GMz5gw7OY6MqscC2j+y7vIH607S7V9P7Mc8JeSxkS1Bqf6btxd148Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103305; c=relaxed/simple;
	bh=bIiZtZ9Px155FsjMVerf6i69FABcMZyj994gn4yKf0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmN9ZG0DvU4vFroayRe7VQYYBnIhGkz0TU1C2OCVCP2UmTiXltgCBMjjS8+TFG5xxq9vJRi6bDNm7EMPr+O+QWxeuqmJK2RjyP+xqrDAaxOKmpuwv4kfIcf25XD4isdk8rgPdbQPep/6yYPMEv8sQUSr0EbbIQ3lAC2xeYNmmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8VIXvtW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8VIXvtW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B501F00A3A;
	Fri,  7 Aug 2026 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103293;
	bh=moRJ64cw7e5TIte0VfVci+iKHW1S2vFFjZs1zJIkezU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8VIXvtW6C2Zl9JCCIoekY1wGDYPXy3pLdd13OEF9nddkVadaw4HHA5D3NzLp89s+
	 ghUQv4zjez94wfJ8su13DIM8gCDhu6ypuRQrTU1o8t6YmEtm9gZvr5fT9LDqSmL7uI
	 3C8pXNnxiOeHC3M8NygYpPdqGn5Ps3JXcO//IkUZDepv3Mxu6l38MB1xi3gE0g9XLU
	 9tYrtAoqQnwJrjP5yQg5WkUIiul5rBIRIdEDpCAWn8fLE+/QyMfY4248rT7sOM0IlA
	 iGnN+T/Nt8G+dQ8qYcZuKRRAMAMWOkeDWyfyc+HZbTJHJzw8evplcW3Qkyfxu0E9a7
	 lpeYLSuUvDJvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WenTao Liang <vulab@iscas.ac.cn>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] ceph: fix refcount leak in ceph_readdir()
Date: Fri,  7 Aug 2026 07:48:08 -0400
Message-ID: <20260807114809.2056244-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807114809.2056244-1-sashal@kernel.org>
References: <2026072936-dispersal-unwanted-0d62@gregkh>
 <20260807114809.2056244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: WenTao Liang <vulab@iscas.ac.cn>

[ Upstream commit c3e64079d8b9663e3998d0caac9aba915b6b93ae ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index c5819319e8c08..0b764dcbc7bf6 100644
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
-- 
2.53.0

