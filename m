Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F574AB3AB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574800; cv=none; b=J0xp+CZfKV0D4y9AiEzu1+EHPiBnw3/D/XcWC28cYiO+GFA4bL96de58Ks+xj69eBE8aFYgGzvp54Bn1g8FaLvMQ9Re76viRYzD6AWUC5zUVfahsX2PrnQNX2X5LVSHtY5bBuopUU1s51AwpMyQXQU2YQCeBmgo/7nm4sr6VRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574800; c=relaxed/simple;
	bh=WdOyeq1PdlmYzCe27Stu/pi/godj2EPXhKO9RuE5dbw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NQoXJXKVe0RrO/XuXP22McvE8LK3ffXZN3jP4EEaVBka0pwNgJrSqdjm0dbn64Y1znKGtsEh3lifpYOYIt0xR4TvZ7/6tW6jNcfZW+ovqH1a0pM6hHUpaSZivI0izmfHmUqylQ/qQKE4PAbxdfXat9ZJC7GBfPTWbWS1RD/1YnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4fonzGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4fonzGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7331F000FF;
	Wed, 16 Sep 2026 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574798;
	bh=MYu+1gQTLRnKaMa4w0I9wZ/cj9ruVRvB2hV4TrbIB2A=;
	h=Subject:To:Cc:From:Date;
	b=b4fonzGnn/44GQuOLrLPLMrI4bPeCguCtzyqRj4IqL5nKF+YLRPZHC4TiIQVy4mV3
	 0nWE+1XVfVktwnzUCY6xwUmD5bWrypSgt8DRie5mKqSOgfkJXubL2WK6Thg09Mdb6h
	 rDhreYzDgFY3o3e5pnpKAG8B+YnZYSrH8zVvPF28=
Subject: FAILED: patch "[PATCH] erofs: preserve LZMA decoders on resize failure" failed to apply to 6.6-stable tree
To: nikhilgurudasani314@gmail.com,xiang@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:43:08 +0100
Message-ID: <2026091608-battery-antitoxic-df2d@gregkh>
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
git cherry-pick -x 617d0d8d199ba1790c94310fd75a22d01c97a8d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091608-battery-antitoxic-df2d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

