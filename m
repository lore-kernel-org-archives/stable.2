Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E6502780;
	Tue, 13 Oct 2026 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892956; cv=none; b=EjgC+z8ilxhyIS3DMxJ4/q37TAd07AZv0Yf7Ph3yK8Ps/3u05iinj88svBIPSzpruW2R62/75Hcm/PNLNfieHegVaa/asIpBQssZWxYVw1vrZI02vZI5GyQZblKjZpZbdUv0z7U0LchjX53fV0wvyAChQzl/71eZGE1cjM3jcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892956; c=relaxed/simple;
	bh=ijJ0ca+kKJXb77pIENQCm3ZD4UQegF5clualmJljGt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi3Zkpbf/R+mAeKYnzq2QR5kRnZDCbp0hzV/t6F0Ft+auj1oflMo3+nVqbC1MmCSGgiLoSQDC3KKqmkCwggu9XgYnNr2jXRGUH9M8oI14c12cax6BwP7T94l9uZZcJs3fovPpTq1uLXebnu27bBOn8+p33hwAC1szLuzATVEdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=BEq+GqvZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="BEq+GqvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791892953;
	bh=je66SPt1cPbB5eg6M1/B06Le5HrmnanotjmdERbZzFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEq+GqvZLUp5yqf4hWeZOOvukIwenXliv0ntHFLWbiVmchWSfj8x1yt4e5Sttz8XV
	 WWPPnNOrrLYZuYABVdokwfRUGMKPxUE5VuQFVqFwT4MYAWn1Qqzr2QXcnY33/4rjfa
	 rAV/S03hLROFzizKdky7FQi7BxZMb5hmiuJPec7Th9U6fO+hUR7eJ+/MPCHTCZdgiR
	 vqwyYP3/XdFiXqTjtn3u43/at5HQuuhNv9+MvNToK1O5muHAo6N5qlDmby/yCtFuxk
	 Ymsjz+uPz3cXqSSCYBcPoIOS9qd34zjXJE0my5KxyW64DUakQpMFkNEXnZKhXbVWPg
	 r8pOg6sb0aN9g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4j3tHr3JFtz4xh0;
	Tue, 13 Oct 2026 23:02:32 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex@shazbot.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] dma-buf: Annul dmabuf->file on file release
Date: Tue, 13 Oct 2026 13:02:06 +0100
Message-ID: <20261013120211.135807-4-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013120211.135807-1-matt@ozlabs.org>
References: <20261013120211.135807-1-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dmabuf release path is split between file and dentry release:
dma_buf_file_release() is called shortly before the file is freed, and
dma_buf_release() calls an exporter's dmabuf->ops->release when the
dentry is freed.  However, the dentry can outlive the file (for
example, if opened with O_PATH), meaning .release might be called some
time after the file is freed.

This presents a window, when closing a DMABUF file, in which
dmabuf->file points to freed memory yet .release op has not yet been
called.

For VFIO, if a buffer's .release has not been called it's considered
still active and subject to move/cleanup.  If so, it attempts to
get_file_active() on dmabuf->file: a file close with dentry held open
will call this function with a stale pointer, a UAF.

To make this pattern safe, set dmabuf->file to NULL in
dma_buf_file_release() to reflect that the associated file is now dead
even if the DMABUF is not yet gone.  A get_file_active() ... fput()
sequence concurrent with a file close then only executes as one of:

 - Gets the file before file_ref_put() (dmabuf->file valid)
 - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
 - Observes dmabuf->file = NULL (no file)

Originally, drivers could assume dmabuf->file was valid until .release
was called from fops->release.  This assumption was no longer valid
after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
dentry_ops"), which moved the callback to the dentry release (by which
point the file might have been freed).  With this commit, drivers must
still consider that dmabuf->file could be NULL before .release.

Cc: stable@vger.kernel.org
Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/dma-buf/dma-buf.c | 21 ++++++++++++++++++---
 include/linux/dma-buf.h   |  5 ++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 4c9add51f9ef..61485fc28b8b 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
 
 static int dma_buf_file_release(struct inode *inode, struct file *file)
 {
-	if (!is_dma_buf_file(file))
-		return -EINVAL;
+	struct dma_buf *dmabuf = file->private_data;
+
+	if (!dmabuf)
+		return 0;
 
-	__dma_buf_list_del(file->private_data);
+	__dma_buf_list_del(dmabuf);
 
+	/*
+	 * As the file is being closed, dmabuf->file is no longer
+	 * valid and NULL replaces an otherwise stale pointer.  If a
+	 * reference to the file isn't already held, the file can be
+	 * closed at any time, including before dmabuf->ops->release()
+	 * happens: dmabuf->file _must not_ be accessed directly.  An
+	 * exporter should use get_file_active(&dmabuf->file) which
+	 * atomically tests and acquires a reference to the file (or
+	 * returns NULL if the file has closed).  The barrier ensures
+	 * get_file_active() observes the store before file_free()
+	 * frees the memory.
+	 */
+	smp_store_mb(dmabuf->file, NULL);
 	return 0;
 }
 
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d15b2b31d3c9..a31eb0ab9ecf 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -303,7 +303,10 @@ struct dma_buf {
 	 * @file:
 	 *
 	 * File pointer used for sharing buffers across, and for refcounting.
-	 * See dma_buf_get() and dma_buf_put().
+	 * See dma_buf_get() and dma_buf_put().  When an exporter holds a
+	 * common lock with the ->release() callback, it can use
+	 * get_file_active(&dma_buf->file) to safely acquire a reference;
+	 * the file could otherwise be closed at any time.
 	 */
 	struct file *file;
 
-- 
2.47.3

