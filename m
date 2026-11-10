Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274044;
	b=5QbKUYgAGrAmTx0QqgZBNgotifYRpkeEB/rW3fJnnu2LwO8mYa+XI72wU4HaFREFjCeo
	 xaJBRCe9ZG0g0jF30EQbpYvVhatdFR0+2QCG/obvLxhQVb6brzzf1rkOAKb0UNw2TvhGX
	 c1Vbtxmh0Iz9wmdW2oizoFve1DTOPsXhfTbmr4lSYDL9RTShENn956cTInGM6rl7hWE98
	 CSb7oB9v5uXac/ARPUzhw7R+B4NbGC5NQNWqdeH7BYtDF2xWDCLDDVA6Lm3Y9nxQTIKLz
	 F6BZXaU1wyWicKKYglfkd+hY0dCK1qpbyKaraqbf4NjPeF8Nmpv3pSVaLMjdci3w1Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OusW5ufg3B0yL+oG1N3jNtBX0HB7+vBM2Sku0h17I2k=;
	b=PX0tR9789hiL3CRhI8Ygru4y+LuiCVLLE7WE/VjzELaOxVmFx7Osvl0LfzhrqsH7Pa58
	 M6KPA758q13UKL94bm84rnYFMTAV7pceg10VP/tmn12+cuz5ujmkdXUNKMZBEcSJE+KZ4
	 QBdNAl9QDBv15bvEkt5jWkebUbPL/W5Chof0tOti9bugysi++MbMeNauixnEV76kBHJTa
	 KxIqLQm5zA4EE37UmXdASB6kdrBFy6I5OUm/B1vfhveeulLZS22atiZsY6Al/KGFi1MyV
	 Iypg7Vd3CygsFcTmgRctIn2yhZ4Rpjx53CasM4Ky4E4tN1o3qmvByUz4aIEcso4VZaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrB0bypj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC7606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrB0bypj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3EA1F0089F;
	Tue, 10 Nov 2026 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274043;
	bh=OusW5ufg3B0yL+oG1N3jNtBX0HB7+vBM2Sku0h17I2k=;
	h=From:To:Cc:Subject:Date;
	b=OrB0bypjeDyXc6r75u/pQlW0xZ7aljuImLC92MvZFHNUH+4hqRZ1BRhVbE+Qh50Z9
	 sKHUvUTQbddmwG1FEu54s2QOo17S/JH6sWOrObEPPblau7QVomeMVIoIFRVDYkNeGc
	 2nUjPEF9jZ8QfGBb9dwfUTkHiVT5i13J4TDevy6wkSE6D3cMiOST09AJ1yogkJbSSv
	 xDw7jT+RCEGj9aNJHbQvTxPJ8rQfgBfrjFCFVdRnmgGR5egffUvDVVn7+2g3kr+odg
	 78dlS94HRcaN5LoSBXGOTTn3kLfHz4XIP9BNgRG+QKZI41lo2oIzglcdiGyEjEMlcj
	 U1gXbJbMit1mA==
From: Sasha Levin <sashal@kernel.org>
To: blum@kernel.org,
	prasannatsmkumar@gmail.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwrng: virtio - prevent use-after-free after a failed restore" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:22 -0500
Message-ID: <20261109202722-failed-5.10-0f7bf47f5a0c@kernel.org>
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
git cherry-pick -x 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202722-failed-5.10-0f7bf47f5a0c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




