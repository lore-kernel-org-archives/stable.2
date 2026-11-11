Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422363;
	b=FhwVddDp1I6eyVoMi1BtnAb0jjmTgwWgL8SnJ+saw46NKFXckrpJ01Mr4qrNLc2IDc4d
	 +T7sgSoXf8EJYI7zoqgHRHMbzZc6Uh3Xvn+0lziN+X/fLX1xAZ0PmBZY7wVYV8TM4crUA
	 PkZ+D5mBNqK4W3t9Ai7lwRZcuQNhz+6o1fLrQ0UnUVumoA+MvUTY7oeEGlYOxzfl9cy7h
	 xMeLjVrAOTA54m6BxI83m2Nk5BxED0Fqy6yVTtqoHJjXSQ0Q0WJOdszQeh8pE+91ad9UA
	 /b/qA4TTYhpIg3MXSt3w4zGVyez0G9avl9CYfF56C21qlwqX2U/W9EDesObv3Zb3Jgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422363;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hV3eGu3i96MgTq1oe8yvIy5+UiVirZmEj2wqHa6K8hQ=;
	b=qa7GO7JE2CzAVllmuvh0wCEf+5uXzH+8Z6cAgJ8AmIBPt2NAXGdTz2NINjU4XtHIaCwO
	 qsizZVZuG6A8Tob0MgUWscY8nixWq44Ips4Sd86z2SsQWZl0IuxpS5mym5+b+xqRhMxvM
	 x60enfIIxvhoIqWnNHc/8/fxdzJ3bppmZJcfmA9ua/1lx7VWAyx1sfKBUNEgWh7DFc8WT
	 KabFvj4jEG5eAbBhyws/u+aYPqiqjr2c0QDYceD6yoPBQRfgvW2amehAr0Synl+A6BJby
	 xCbR7Yzudn08JBnJqlXJQH2vFNk+hxg1qvqSQVnBB9vwDXh6P+3sjBYpnuK63+QGhbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7wgJELt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C5606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7wgJELt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDCB1F00A05;
	Wed, 11 Nov 2026 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422362;
	bh=hV3eGu3i96MgTq1oe8yvIy5+UiVirZmEj2wqHa6K8hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A7wgJELt5twYyBAf0W+7EGZ7CHnvwQC1EAwrqCUGtEIBgzvv/nHFF79n6FPvabZ5h
	 H5pxRlkR62zNbE9pgtzYG3WnS6EN2uopM2kJXpudMJTg92fWZjihk1HDM/+XQdd3Tv
	 EFFgrWN+ciJyJgMat7coruFvDxLa2XGQ9xjtfpH7mkISUokL38UPEqioVaRLT+6L3e
	 fnnlyh+lcLAHekIYLFL1Xnq+yWot9CXvmucW1RoCymXlBdhYv/A0iTFpSwyGhJm0hJ
	 O//8hdlhZI1YgeFOGvKsWGl21VJFb+rlDxACdbyOnk0uvgNtmsyMR5VO0cj8r2C6h6
	 n42uFNSWcV7aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree
Date: Wed, 11 Nov 2026 13:39:20 -0500
Message-ID: <20261111183854.3863855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055028-failed-6.1-e7ccc777a040@kernel.org>
References: <20261107055028-failed-6.1-e7ccc777a040@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
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
[ sashal: Retained kref_get(&fs->refcount) instead of upstream's kobject_get(&fs->kobj). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/virtio_fs.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 9e4f2ba0ef9d2..104d32619c535 100644
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
@@ -1436,13 +1433,17 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
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

