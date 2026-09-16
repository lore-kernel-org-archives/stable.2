Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9F4D7970
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574803; cv=none; b=U+XuHKmbsI7CnZ5dZ3q3Nt+K7ZI2bAN8qss/m8uIcqkCTiCe+LF+KOFpRZunybn4a1VqBjhhq69XCPalxSznac8xpf6QrwIvclLWpAFFCktfbOo47ojXXOry+tiKItVdwJuQmdseCiTkwbXyOhcChBIQ9bECkA+Ky/X7jKuFUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574803; c=relaxed/simple;
	bh=U51tlLN1gGhkEfPLfCIMeK5nATUb+zXyW4zkn94uxPQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tfKdDXK0KL4tApmaXLISpLvibutJpwRERRc8XWMs+r9roVHkZRhzz8kCNeguVSSUB1y4EVxhR1/Re1BCtwTeGePMmr+UWqO+0SxetYha5mxRbevKRca8aJmzUlPk5KiQwXdSqbJ/NGPp1CoaRh4Zt95SpqFFrqVucQI+o62jNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kREwzF70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kREwzF70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676901F000FF;
	Wed, 16 Sep 2026 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574802;
	bh=GhKRiQ8hA+KQ6DJ/bEM4WxszVIntelvz1/CQ4JQD4uk=;
	h=Subject:To:Cc:From:Date;
	b=kREwzF70nS51YBWTs0RgbqiBu1Mpe+kuZ4/CGXL4We4NZEGq2ZaAsV5KdEJkWyyOs
	 2XCtUxOrXt++N8h8oZVjWjOMADloz2DhTNdeK6X68+N3uJfFkpZoo1d90LkGJ+rGHD
	 p1VoF3Yb2QsCz8U+y6vT4k05IM/JOLTUy1tuqptI=
Subject: FAILED: patch "[PATCH] erofs: preserve LZMA decoders on resize failure" failed to apply to 6.1-stable tree
To: nikhilgurudasani314@gmail.com,xiang@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:43:09 +0100
Message-ID: <2026091609-nearest-swell-7036@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 617d0d8d199ba1790c94310fd75a22d01c97a8d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091609-nearest-swell-7036@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 617d0d8d199ba1790c94310fd75a22d01c97a8d6 Mon Sep 17 00:00:00 2001
From: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Date: Sun, 30 Aug 2026 16:11:09 +0530
Subject: [PATCH] erofs: preserve LZMA decoders on resize failure

The pool-resize path frees each stream's old decoder before allocating
its replacement. If an allocation fails after some streams have already
been replaced, the failed stream is put back on the list with state ==
NULL. z_erofs_lzma_max_dictsize is still advanced as if the whole
pool had been resized.

An existing LZMA mount can select the broken stream and pass
NULL to xz_dec_microlzma_reset(). A retry at the same size also
skip another resize attempt. Since the global maximum was advanced,
thus, the invalid state is left unrepaired.

Allocate each replacement before freeing the old decoder, temporarily
retaining one old decoder during allocation. Stop at the first failure
and advance z_erofs_lzma_max_dictsize only after all streams satisfy
the request.

Record each stream's dictionary capacity so retries can skip streams
already enlarged before a partial failure.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 6b0cdb446c6a..9d15f94cbee1 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -5,6 +5,7 @@
 struct z_erofs_lzma {
 	struct z_erofs_lzma *next;
 	struct xz_dec_microlzma *state;
+	unsigned int dict_size;
 	u8 bounce[PAGE_SIZE];
 };
 
@@ -128,11 +129,19 @@ static int z_erofs_load_lzma_config(struct super_block *sb,
 	err = 0;
 	/* 2. walk each isolated stream and grow max dict_size if needed */
 	for (strm = head; strm; strm = strm->next) {
+		struct xz_dec_microlzma *state;
+
+		if (strm->dict_size >= dict_size)
+			continue;
+		state = xz_dec_microlzma_alloc(XZ_PREALLOC, dict_size);
+		if (!state) {
+			err = -ENOMEM;
+			break;
+		}
 		if (strm->state)
 			xz_dec_microlzma_end(strm->state);
-		strm->state = xz_dec_microlzma_alloc(XZ_PREALLOC, dict_size);
-		if (!strm->state)
-			err = -ENOMEM;
+		strm->state = state;
+		strm->dict_size = dict_size;
 	}
 
 	/* 3. push back all to the global list and update max dict_size */
@@ -142,7 +151,8 @@ static int z_erofs_load_lzma_config(struct super_block *sb,
 	spin_unlock(&z_erofs_lzma_lock);
 	wake_up_all(&z_erofs_lzma_wq);
 
-	z_erofs_lzma_max_dictsize = dict_size;
+	if (!err)
+		z_erofs_lzma_max_dictsize = dict_size;
 	mutex_unlock(&lzma_resize_mutex);
 	return err;
 }

