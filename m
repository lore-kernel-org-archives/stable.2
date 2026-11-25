Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602434;
	b=SnjWIUySktxz2x5gnlGGmHUJXYBDw2iErGNQGWGNoE9PtOrmBDq4i8Ys+vMyvvN9PgbO
	 Roj4N9utFAFeNk1hUCJckI+ZfpXdcjoSPjowdMxmZKO/HkU0wV+Z+Vnbq40USN3ss+JME
	 hDo/qqstJ9/mpjzyywgFA+9r/BQSPboAq1zKVmaXOicXUi7JsoD4toapawDfr+6H85oqF
	 xoTV5TOA7OePJOx9L/8ZUo5HMswTtzbQ2wIoQANTWSixQ8muACoO/DYkn3B8oXpkKKkW9
	 FbyXwAgxCbSiX1YH+3KU9nmr/kSqEWvWtGMfCq5sF7M9KxTnY9B74kH56uCxVkXZ7sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602434;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IRiPOqnz/e9ckncX4LYjPxeejzOi/QGaibgHUbDDwx0=;
	b=Khzgy9jcFQfVXHodI7GEjNmskPktQvtoQhldMtrDuze+Nj/slbTdZEvGhRlV9SrhQtBT
	 5cgX0yjKl4Q7fmZgeybaJYajiGLbUmiMI7nVTaf4CdQ5hxN8AZeVOu9I5Ys93F6/jDGeJ
	 TvaOJrnEydT4vZHgzO7c06qXCK7vlChrCfX+PaVvXAio6ROlR9lxPQXk7REdjv8PANyL7
	 /EVQCHbGK8wm1ytizFLLA/ijyMMDJk3wLZNxFad3WzaHb3uIJdsNd6Sl6y2Hby3hRvDy7
	 2IvL8Ao5LP5zFgoV1DiWZs9/rQrgxExRb5S9P4J3dZo/xRCxaWZ1AsMSILFiCsUsQdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5Ezye1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4FB606A32D;
	Wed, 25 Nov 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5Ezye1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC61F000C4;
	Wed, 25 Nov 2026 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602434;
	bh=IRiPOqnz/e9ckncX4LYjPxeejzOi/QGaibgHUbDDwx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c5Ezye1B8E/aih0ckiaVfkFES7c1XHOAex8RhEpu1fmAiyW+G+SOEbNtG6DyXQvFQ
	 dH6LT75otAiy15AjuXyf7do7p1CFOM6izaGSj/ceswp26ejiU+9P1ASJNO4kYOvEBo
	 VzgTPouQkEsyTEBDxHomvkpKzPM904WHUDmS74OOljQfrFC/D8Y7RsaUdvu1r987XP
	 gZJ0XDw2qXUD4p+3FLuTgj9Fx++ABM9m7QeSjawSAA67HVNl5ozmpNTxemsn91dU45
	 z1j0ygbD2YhmYxFeGAOO+CICMihaFG4arvCu2oc+pFqq1n7fPMQgTI1WDr0v4d087E
	 Vc+WFho6DhWVw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 25 Nov 2026 11:26:52 +0100
Subject: [PATCH 1/2] fuse: make readdir requests big enough for the largest
 dirent
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-work-fuse-readdir-v1-1-44312add01a8@kernel.org>
References: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
In-Reply-To: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2960; i=brauner@kernel.org;
 h=from:subject:message-id; bh=duPCHfXk4j6PDNT06TRUjy34CXKCN1VPyVad8KWF/Rg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzbf8xe1+k8JLG/2cjMjX7Ny/1+mkdsv/ibJdrF277s
 sd/zXVI7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIzByGPzyfppXeWFDBa/f6
 rb3+hLcmMg//yYae2fo7cueaRzqdrWyMDGuy41iEy54F8lks5L3V89F+SW7p4l7FgDsHFj1Yn2D
 1gwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit 27992ef80770 ("fuse: Increase FUSE_NAME_MAX to PATH_MAX")
a dirent can be larger than a page. But the readdir request can still be
a single page, for a small getdents() buffer or when alloc_pages_bulk()
didn't give us more. The server can't fit the dirent and sends an empty
reply which we take as end of directory. So the long name and all
entries after it silently disappear.

Make the request big enough for the largest dirent the server may send.

Fixes: 27992ef80770 ("fuse: Increase FUSE_NAME_MAX to PATH_MAX")
Fixes: 4dd6f6d3085a ("fuse: back uncached readdir buffers with pages")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fuse/readdir.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 1f6cf565477f7..a75baed673a76 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -333,17 +333,23 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 	return 0;
 }
 
-static struct page **fuse_readdir_alloc_buf(struct fuse_args_pages *ap, size_t *bufsize)
+static struct page **fuse_readdir_alloc_buf(struct fuse_args_pages *ap, size_t *bufsize,
+					    size_t minsize)
 {
 	unsigned int i, nr_alloc, nr_pages = DIV_ROUND_UP(*bufsize, PAGE_SIZE);
+	unsigned int nr_min = DIV_ROUND_UP(minsize, PAGE_SIZE);
 	struct page **pages = kzalloc_objs(*pages, nr_pages);
 
 	if (!pages)
 		return NULL;
 
 	nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
-	if (!nr_alloc)
-		goto free_array;
+	/* The bulk allocator may stop early, but the largest entry must fit. */
+	for (; nr_alloc < nr_min; nr_alloc++) {
+		pages[nr_alloc] = alloc_page(GFP_KERNEL);
+		if (!pages[nr_alloc])
+			goto release_pages;
+	}
 
 	if (nr_alloc < nr_pages) {
 		nr_pages = nr_alloc;
@@ -364,8 +370,7 @@ static struct page **fuse_readdir_alloc_buf(struct fuse_args_pages *ap, size_t *
 	return pages;
 
 release_pages:
-	release_pages(pages, nr_pages);
-free_array:
+	release_pages(pages, nr_alloc);
 	kfree(pages);
 	return NULL;
 }
@@ -380,10 +385,13 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
 	void *buf;
-	size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
+	/* Room for the largest entry the server may send, a direntplus. */
+	size_t minsize = max(PAGE_SIZE,
+			     FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET_DIRENTPLUS + fc->name_max));
+	size_t bufsize = clamp((unsigned int) ctx->count, minsize, fc->max_pages << PAGE_SHIFT);
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
-	struct page **pages = fuse_readdir_alloc_buf(ap, &bufsize);
+	struct page **pages = fuse_readdir_alloc_buf(ap, &bufsize, minsize);
 
 	if (!pages)
 		return -ENOMEM;

-- 
2.53.0

