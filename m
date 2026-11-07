Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047769;
	b=BSQ5avA/SsKaCrIRchp/ftyI3NVtA9mQX2Ie3at0D6wSf36Tbex1T60lP5+jDaFbr1xp
	 bo9xEw/dGBIYuFE8IvgHe93vdPYKYv/yYULyU2neKJ9eVlulc24lyRjv16dmHgZU5ceEh
	 /3HZNk61D+esX6dq516iOgSlpKh8OH43GHLA9rTXpeqfVJybUAhWZDUPSWNyNHPkbO/Fr
	 p2UCjszJqCSnB8bZv7eO2B3AXZqNtRzH+47tau61wI7a2rqVvcMRy2szgWfcAg/OuJhuA
	 k6uCtOVQJn9q5g8BbwGwH3ymofzMaWfYqWZjpHkEo14xj9ZuHZTx30VIvB33zyZztgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047769;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=usoTDUmG2DKDW/XSm+x5rc1nr1OCZqQPQDzd7K0jVX8=;
	b=u/wa7OBOPWXiSEt27q0I6aTtR4iXzVrTYnhCKpsY2mCgaVo/XOhBGjjGVHOhuzeurDXd
	 2ZTyOjzuPTbe3uCZqkKaSTXNGYBwJOJRrbY35CzIpwU4uz0/hBSBy0okVX8S5wTjxlWXu
	 XVsw68YjllNWIz3syYtL+hxpDxHo8zCmL1vTFSZsFdmNeMYSurZgK1lKrd05nxEOLpCKW
	 CsyovlJHvM2Le6HDiQNT6wh4dJHxTxQsAmV66rY3C160Zf6ZoTWX0Ms4kIV9WkmPosd2E
	 LSmtzLUUat/mr4zx304jN6cPjI3m4RfnO92SMWbxPlOqVD+lMMP2r4HTH2pipEQsG0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbznQF3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbznQF3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83ED1F0089F;
	Sat,  7 Nov 2026 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047769;
	bh=usoTDUmG2DKDW/XSm+x5rc1nr1OCZqQPQDzd7K0jVX8=;
	h=From:To:Cc:Subject:Date;
	b=gbznQF3J7C88Z8RHqdWNTTXffR4pYQv9Gq3hLYgAXesAnDZyhIHUmB3+QA3wCopjF
	 jSDeVLBobZaoJLTFl1Yp43ruBpznMI/ITFnUiOY9Y53ToMMtF+/NpJmRe4iIlo961V
	 10gLMzojrW6c14LKCV9RWsRQIz2wUdhk9n3GbwwLP8kKMIZK4lR0bGn3kd3kP1MaKm
	 tSfRxQ2BrnrRfNfd5L5vIeeG7kpH0qfkGB90GuQbL63l8wYIecEwte1qpDvuRhM+gI
	 W6bvhiDpFr17sm1B9Gevu0NSvxCfSx3sEQocAMXT+EuUPeQhbchSJDeGmANF0LhoLT
	 iLOUdSdnVCZJg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:07 -0500
Message-ID: <20261107053607-failed-6.6-e7ccc777a040@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e7ccc777a040343b80f95f4cc5c12ce1df3187f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053607-failed-6.6-e7ccc777a040@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




