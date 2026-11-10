Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273179;
	b=knlmGfjZNuFbEzVUFyf2PZ4J2TxgnLs+kPW/ZUeNID9c9POMPKNxNPw4ON2vqEsZZz4Q
	 AtW5GdlBGb31Nhv9HUp9SEs0WgMTddaJ/bCL6Jb2Xfgj9i2PBPjOwC0uQi4wWe9OHAriX
	 5Y2v/rW2Szi7UPO/qjSlycItNfWC1jnV56bZ3iJb1/c0ARwmg/bWN147TUsQ7BvzlkyiG
	 FJ7YTOOQLrQBf8LHeF8IDAlhzWuT2EGYEJF3KDjZ4FH2Pkb/co/vSjjh8Lwl9bmm7kY/V
	 FfRlO9X4Hg8vXsG/ue0cKlICEk9pYoIKmVIdW2sBo63WNXARCh5KHP0IuRlEe52QKnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273179;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d5XfuC91YL5tm5bA18E0Ea+514GCF5e7seXWR8/1mvE=;
	b=ZCIXFRn97rYI03mKZVGq/5La6PlAd2FPqTNpeYHvUdvlZPB+9ofPrnPtIyDrZMkjv72+
	 FkKizaZbU/E0A3BL008dPVRqvphNOD0Ret3aoQCewLIDCMas2x/xubVmgHDhCCr39C+9z
	 V07mSxY/i8Pn1az6vXN5voME5hGzMvioGbD/BHShQ2dr6W9F9v2cz6ZHBWugdxKQEISqb
	 ALPCKhjZzj3htW2o0EadL6kNOVpixvWjHNIwqB9uTFEfCNkRGNAIQPxS0xjDSZom+bATX
	 oiL+U5FBhNGSWyGetIyLRsWsi8Ol83CjWaHv2Rz2K6bz863LyrHQUfSNMFg+jOIxd1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtPAyAo7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30577606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtPAyAo7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5D41F0089F;
	Tue, 10 Nov 2026 01:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273179;
	bh=d5XfuC91YL5tm5bA18E0Ea+514GCF5e7seXWR8/1mvE=;
	h=From:To:Cc:Subject:Date;
	b=jtPAyAo7e+gVen6PSGFvNdSUxczZzpPbHPQwh+xjNVP9VWbdQyIU9tAy//HrOuOaA
	 0cGKwlJ7z13TDLwzNg+kG188PolU0So/sySiApVEn/lrGDj8jpVyVIzAMCVbswlrna
	 UsF666vr9Ek+12FsqSK6X4AVdlmDYOwvyzM8KvktwU4oVutpRteB88USQUgSfasta9
	 D8DJ2URZNEH1U6nHolpwPe4g0MnCMceqii/O0KAixktDxAmG1qtpCN3cSmWLRJoM59
	 4W8vZ7ZyXAgjd2501x+swRY+lcvCm9SZIalorqYeyUCUZ4Z05wmrkttCMIv+t6fTnf
	 fAmxxdhI6LI8Q==
From: Sasha Levin <sashal@kernel.org>
To: blum@kernel.org,
	prasannatsmkumar@gmail.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwrng: virtio - prevent use-after-free after a failed restore" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:57 -0500
Message-ID: <20261109201257-failed-6.6-0f7bf47f5a0c@kernel.org>
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
git cherry-pick -x 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201257-failed-6.6-0f7bf47f5a0c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <blum@kernel.org>
Date: Fri, 16 Oct 2026 12:36:40 +0200
Subject: [PATCH] hwrng: virtio - prevent use-after-free after a failed restore

remove_common() frees the driver data during freeze, but does not clear
vdev->priv, which points to freed memory. If probe_common() then fails
during restore, a later remove or freeze can dereference the dangling
pointer.

Clear vdev->priv on the probe_common() error cleanup path and before
freeing the driver data in remove_common(). Also reset the device and
return early from remove_common() if vdev->priv is already NULL for a
safe teardown after a failed restore.

Fixes: 08e53fbdb85c ("virtio-rng: support multiple virtio-rng devices")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <blum@kernel.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261016103640.4989-2-blum@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f9982217247dd..45d87c0614a5e 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -190,6 +190,7 @@ static int probe_common(struct virtio_device *vdev)
 err_find:
 	ida_free(&rng_index_ida, index);
 err_ida:
+	vdev->priv = NULL;
 	kfree(vi);
 	return err;
 }
@@ -198,6 +199,11 @@ static void remove_common(struct virtio_device *vdev)
 {
 	struct virtrng_info *vi = vdev->priv;
 
+	if (!vi) {
+		virtio_reset_device(vdev);
+		return;
+	}
+
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
 	vi->data_idx = 0;
@@ -207,6 +213,7 @@ static void remove_common(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	ida_free(&rng_index_ida, vi->index);
+	vdev->priv = NULL;
 	kfree(vi);
 }
 
-- 
2.53.0




