Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422209;
	b=Nyyp6q2m65q0IAYIsu3M18pyhzpEwYnnI9MM/bNgdGaso0kV/irDAZIV0gUH8aMtGJ92
	 WKlkkGgmsLA4yUVCVhwdj0ZVyRHF0EHJ+F1Qiqft6C/W9Wg4QuyW/e61/16gfkPJwC4CF
	 SM165Q66uMDN4tgrkQIIcdUX21nVxkoKJsIa+iEcoOGCNz7bx/Y2TlOOJr8IuOgA06Qgd
	 hVpx8dUhGV3e+3P37oG+DY4DnROB1+O3LU2fS8EauyVZpcHIUedmhwd5+Al3i9v+I1bQr
	 VgVgvBvkBWXjU6ael4uCuuCF/fcCgwH4HGvi/pZf5NKyuYyPvMORt13/6GNf00WTUkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uuespoRDwBQJeUBvmL5s6lub4zWS+XIVRIT635tecJg=;
	b=pSvSNG108tvh1UwwAQYebHpAur0H2N6og3ADBGmNZyMZ0shKjmpV1evVTCNJGS0oM3EJ
	 B0/I7uNo1tUmIe2j+312sJv7a8PfP3IwNYk4NBmBhavJU9ws2K96qk7cP02I0tkLcxmHh
	 WglYGo+3Az5+u/yIG+IJOkBDz+X94gNWPVLR7J+vvpTYILTFN/513jgSW2ZgevWeRKMF1
	 OToiL6QAsbmEvf8E8SSP9qHV5tIG/y7QceBXXQ/Hgy9wjqNRbBirXFMb/21H5tgP78KCw
	 yvWP7c7VBz5Y10GDjtlajBZZHZyNGUEREY41KQXewXBlTKBe20/7P31ErFzkqpnityA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuixgFLU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61C606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuixgFLU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA5D1F00A05;
	Wed, 11 Nov 2026 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422209;
	bh=uuespoRDwBQJeUBvmL5s6lub4zWS+XIVRIT635tecJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LuixgFLULkqEp5nMVeum2u/HISbzV7bDZtBTY05rBOmrIsIU3bsq8ao9rSavGnZin
	 hXQKdgtDyQmPolkmGaMwO9yo9hzhA5QBV/D/bhP0kd1Wv4A//vsnweR1ScZ5BHS/RY
	 UxgeabXT9YY9BNH55s32y6nnpxpq/TmK1AF0EQsgDJYXpbXtPHC9kZCalYXvtXSdH4
	 FTh9xq+wWt6sio6/Hc2SIzNTxaVZb9E4BvIUr3YKbAwh5hVU21KP5cjdH33+WCYdo7
	 pTfokESHP7e10+9anG3c3Xuyf3k9U2Yb/V8jGTleGrCv/Opzy/FMItS00Fco9paDaZ
	 NwyAzWVXVZ8ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree
Date: Wed, 11 Nov 2026 13:36:47 -0500
Message-ID: <20261111183629.3870449-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060737-failed-5.15-e7ccc777a040@kernel.org>
References: <20261107060737-failed-5.15-e7ccc777a040@kernel.org>
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
[ sashal: adjusted context for kref_get() instead of kobject_get() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/virtio_fs.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba8d5f5dbeb01..08f1ae3ea896f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -252,26 +252,23 @@ static int virtio_fs_add_instance(struct virtio_fs *fs)
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
@@ -1438,13 +1435,17 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
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

