Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049660;
	b=FZWAA9AIliZVUC3qLWx+SDFZeQ3sMpyCvGf+5AFtTassfW5c4NJDNW2Lxb57ErOY/sHA
	 73CQkIz7j84wDiQgVIPGqOEL0fNC0D3C1FkUM2t2Olnp7zMYV8iMyPRIGqsBkL0QhyACX
	 Y2wus6gx0jAuwtZKYPxB/ThgbQuMc7wY9r4IGnKYNS9nopFvkzuh0kZx4uKEhsfGnCeS8
	 BizIIeujvgV50ThML3KctYcOK/3UvKcovmDwLMZlrKMzgHeMkAbBBj08rooQt6kd8JqY/
	 edgacUMqhTgEaH0+lqMI3GRZA0X5XlhEyPf4rMWrgNr/4dIoc8B2DjT/qjdagMSC7hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fC/h8E3dpQLB3Pz4Pr7X/inJQjc3MJce0T5jvA5dgVQ=;
	b=Q+i0oj+nATS8D+xcPLUnIZEZixdW55024CCk3dCQI8BmelHhSR2UVac2n9QMYatoIzDt
	 Sf9WmEygkXr6BHfeIBB8eTAebbLDzc0H7HSWv6Dnsh3q+zfe4gYQNC1ej/zBwPJXrkODS
	 TJxdgiTCnzLq8LrHIIwsmQFb4lk8Qzcuej2YEeu07/petYLSYkUBcQSDla/mtxL7woLw8
	 il60fmpDKokdtq2TXfE8vhaR68FgNXi7O9AYZv3Dyb2oGPyGFSdIJwm4prL8qHlWWlkEP
	 Bv3YOMdj+dGLD/IyfNKKDjCgFRfYwoPBVrVL+eacKlMOMmsq8k1RjuFUpMtP4Yygx/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1tdxDEO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C89606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1tdxDEO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7751A1F0089F;
	Sat,  7 Nov 2026 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049660;
	bh=fC/h8E3dpQLB3Pz4Pr7X/inJQjc3MJce0T5jvA5dgVQ=;
	h=From:To:Cc:Subject:Date;
	b=F1tdxDEOsS+aHSfz77LdlXb5IP4b+/UnPTqjHF4V2J2YCUTYRI3hw9SZsZlmwDBVB
	 mjHcUoIADhCDCar6WdRMJyeNBqaQgN8m1pjwJ9taR2QA1acmhtSIQuBjNfZjox02Jo
	 7G6Qpi9z6LWIFw6jLyybk8H+R9xPe3w4FqvMMVFp7X77LtErDr9Fjf8ZLP775IygFR
	 r1r8E1AGRy7zDXZ+x+gcxolBg6zvggyE/cpggI2Mtd7igKCRFCNeZcusPKggTQXQRl
	 Ws2PXK7xcXBJB4v102zekOdiS7Ni+p/zWMUfDxlaT3kO18Ivf6NENPyagEb0bJYqL3
	 t/qX2U1BKRSRg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:38 -0500
Message-ID: <20261107060737-failed-5.15-e7ccc777a040@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e7ccc777a040343b80f95f4cc5c12ce1df3187f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060737-failed-5.15-e7ccc777a040@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




