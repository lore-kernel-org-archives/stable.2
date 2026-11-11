Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422066;
	b=4UWKuP7tAXd5UrazUMTi+1uTqd41HqvyuhYRkFsNGn/CvWpEoKdHezmluLQnPESRSmtM
	 v4NrYOSDLcQmNXizJ6yChaYe3lzlfNr8GWpJl22+vFDAfS6ML1+268mDrYzzDvFLlTEiI
	 mLN7bGAoG47L85aXiOjqvY9yvKc3+YWQNcqmtomqWGtVfor76Vdasmi4yJNSh61qZVJHw
	 vWIwCOGeu2ilgbhIHJmYSHh9qy/tWckalfV+GzrtQFTtXJyv4/qT3u0tnnV2pOoJ4KTe1
	 E2AASAq9xgFtS8TfvZeoM87UmLHAIBi/YO9Hn52zJpHKRm8lJZsYmtMchCzCGulJ4nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fKSAkaiQ36+lwnFQCGZ+ob9CWEWr2Vohki+WKLyxKYM=;
	b=ZZV0hYb8JZadZIedIrKQqg8LKR3mwY6TRQy+5mfxvORur4XBipXQ6qeNZM7Juwqz2jMJ
	 VTuz7uQh+WSgJZOuueMTj6Xgo4ZT4AfyI2E4stPxQGgH+IeT9PongX0HATBbKRdOPIuOd
	 63KQqnwWGU1YB138zW3RkBnnXhtRw7vc2E1vRrTlq47jMkXK9IzowRhWFXjPlrO1v6HLy
	 mb5vc0YUr32Wz2lTVSEqN+vVszH/UQ2nVXRnRexTeO+G8h91UiY64/aVdDw5qzfu/o8ZX
	 AF5cAlEO1S3kPmz3VufXoNM2+UP569fGMyswvL6l/HMIFW3h6jgKCpR4UwHC3X7j5AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cdar3syN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5219606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cdar3syN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D358B1F00A06;
	Wed, 11 Nov 2026 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422066;
	bh=fKSAkaiQ36+lwnFQCGZ+ob9CWEWr2Vohki+WKLyxKYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cdar3syNEvUhbgfLl8H+vWlZiHCq+tOd0WNc5MwOP1/TStwTlzemCbbUVkBjR9c/l
	 GGvR7IyKh7quEJLn/I2jqJkJdr1VHaQwp9Iz2oNfvnZyQMm+jVjQxmeRZf3P0BuyUU
	 e7DT64GPGoI/yJkni1HRUcOigIrTBeavPFAWhUAEZOraJ800ifcqX6yaX1IVhH6vFg
	 Eu2dwoxre+KmJL2GGg0xSvt9o0c6s7PqDo2b3EB5DWjR4h98GNvo01tAS+SjI/Nbqo
	 603kqkk3xXU23A4n6yIVKmj1QLpWkjzaQ+Wcj1Qry2aBq85u0VhBO3mGGI1rTKY61p
	 IPMcqmuu2KYAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree
Date: Wed, 11 Nov 2026 13:34:24 -0500
Message-ID: <20261111183406.3847682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053607-failed-6.6-e7ccc777a040@kernel.org>
References: <20261107053607-failed-6.6-e7ccc777a040@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit e7ccc777a040343b80f95f4cc5c12ce1df3187f4 ]

The vring size was read after virtio_fs_find_instance() had dropped
virtio_fs_mutex, so a concurrent virtio_fs_remove() could free the
virtqueue first. The reference from the lookup keeps the virtio_fs
alive, but not its virtqueues.

Hold the mutex across the lookup and the read.

This issue was found by an in-house static analysis tool.

Fixes: a7f0d7aab0b4 ("virtiofs: split requests that exceed virtqueue size")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ sashal: Adjusted context to preserve kref_get(&fs->refcount) instead of upstream’s kobject_get(&fs->kobj). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/virtio_fs.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b1028a4dbb991..57ac33e3755d3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -265,26 +265,23 @@ static int virtio_fs_add_instance(struct virtio_fs *fs)
 	return 0;
 }
 
-/* Return the virtio_fs with a given tag, or NULL */
+/* Return the virtio_fs with a given tag, or NULL.
+ * Callers hold virtio_fs_mutex, which also keeps the virtqueues alive.
+ */
 static struct virtio_fs *virtio_fs_find_instance(const char *tag)
 {
 	struct virtio_fs *fs;
 
-	mutex_lock(&virtio_fs_mutex);
+	lockdep_assert_held(&virtio_fs_mutex);
 
 	list_for_each_entry(fs, &virtio_fs_instances, list) {
 		if (strcmp(fs->tag, tag) == 0) {
 			kref_get(&fs->refcount);
-			goto found;
+			return fs;
 		}
 	}
 
-	fs = NULL; /* not found */
-
-found:
-	mutex_unlock(&virtio_fs_mutex);
-
-	return fs;
+	return NULL; /* not found */
 }
 
 static void virtio_fs_free_devs(struct virtio_fs *fs)
@@ -1437,13 +1434,17 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
 	 */
+	mutex_lock(&virtio_fs_mutex);
 	fs = virtio_fs_find_instance(fsc->source);
+	if (fs)
+		virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
+	mutex_unlock(&virtio_fs_mutex);
+
 	if (!fs) {
 		pr_info("virtio-fs: tag <%s> not found\n", fsc->source);
 		return -EINVAL;
 	}
 
-	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
 	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
 		goto out_err;
 
-- 
2.53.0

