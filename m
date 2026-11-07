Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050682;
	b=mk0Z29STD08MXPD2JtFxCHAzWzc34i+MzSVc8O5w17/KNC10mKreLE5hHVUKBUVZxC67
	 m3lXI4qTaKLY1b1PrJhHxlcrCZVz2G41SxuZfZrJvLNM6I/0lQCpaHKLTfS4XPS2MKLER
	 A7OWENa2obT3GFkwQM7xAZjc4rDysL1qgeN6ATG02vNM+rzUxIGoJP0ABLNuYRtke76Y+
	 U1lalAccjGDLZKnPJqZ8FwdOADj0WBtUEGvNKpL+Qy0/SMppIQrtFfUOlrJZglkbc2HkR
	 k4aNRCRlep7FkFzA8ZzS0TdcOd3UxjzW4MjjRxVuwMLI8xiGCwJvw9pIyxdyoMTvkZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+vnp4mNponx/7G89rjbig2NtTKX1ASyGlkpILu88yyg=;
	b=JUmThMIapxUO9wF1/6dBSQOo8YtHD4kmbMvFbBiOR5YTR+fJzm6S4oQRL9jGtjyqnCeg
	 6gJY3+s935OH7S8N8j2xQ5cNhd8u/MEDSghAEAM6PY/Fvggq+dnIonlApuncLDiQYegbe
	 IcfC/8ZRKxi4YjOY42r6dlHpMNUbgLBYFCc1e++H+GEJVoGUqW+JrJFB59HwOB5czdRcZ
	 t3dI5XY5Zoly5FHNsoSqd8eFjah0RSbrVcAGKbXUmF7/R9YN0nvOXaXaUsJHd43O5/Hkj
	 TYbk1ILuwWFGgj0bcCsVe7c4gNHCDNBOmI6PuLuQsWN7SNll/GpAFSIUZiBFp1YztcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4poqAWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4poqAWg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D021F0089F;
	Sat,  7 Nov 2026 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050681;
	bh=+vnp4mNponx/7G89rjbig2NtTKX1ASyGlkpILu88yyg=;
	h=From:To:Cc:Subject:Date;
	b=L4poqAWgc9tda8CMXkGBbcUreHRpoXFL0MPh/0aiFz3e7y5J6KfUbzbE8aYWg2Vgx
	 St0SDvEpAzbKQD0WhT0Fo0sLeJNZqS39goR4j2Cl6dLvoKKyley6Xh7o7MdVcJgEa1
	 JiVIXtUXdbjZp5TXnegArQtiBXf0b6FGO9HziEi4zQxye9vM92oqavA6PA8eelAvzn
	 Eiw1Pr17H5gd90myh5pCNOHYiNSE1yfumTqBd1urFstplwojVUO7U8bVq6vqPBiIPL
	 2kLFnTotU9SbCblnXSYH1ePthNSk9yC5dX5TV+7jajTcQxldPf41VODnGXOPfMvVzI
	 iqTm8V+ly1c9w==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:39 -0500
Message-ID: <20261107062439-failed-5.10-e7ccc777a040@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e7ccc777a040343b80f95f4cc5c12ce1df3187f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062439-failed-5.10-e7ccc777a040@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e7ccc777a040343b80f95f4cc5c12ce1df3187f4 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Tue, 22 Sep 2026 08:13:18 +0000
Subject: [PATCH] virtio_fs: read the vring size under virtio_fs_mutex in
 ->get_tree

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
---
 fs/fuse/virtio_fs.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4f334766b8c30..674fd784cdb80 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -455,26 +455,23 @@ static int virtio_fs_add_instance(struct virtio_device *vdev,
 	return ret;
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
 			kobject_get(&fs->kobj);
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
@@ -1700,13 +1697,17 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	 * in chan->iq->priv. Once fuse_conn is going away, it calls ->put()
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




