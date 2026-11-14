Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794632909;
	b=YBLxXy6iLPxk67al+joSVFuq29HLgXY2pC73TvD34PTYekjQVXqn9SFsI4EZNGSczRMA
	 EkRnQMo4LP13h/+7FVapAMnxX4ZesZq/x75BF9zHezjGzLSFgPpse5KOe1q5XKTCKo191
	 sPtbt3lJfb+m3mc3clXm7tJ71vbWN2L0LURMSLrtxp6+hgtJakgxowhTN0KCXGe4mYfaO
	 ZbBVlZ/1QXyVbsIR/fAAuhIh9Xr0zQAZhrArLMWfdMcK0VYgtDk3LgnCtndn3KtovRFsL
	 Y9fc8JH0N0/4Yf/MXoTc2EQns8Cemh25PHXXzRfb8bR2R5Mu/szgNUvtegEsmnVj0/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s3tqao3gu78L5JXeH7aKRsHMDDcpMOgJCMMXmjvHGxg=;
	b=i09WkmAcDY9dKgGhHCF3xYGb+uuy3aUDlBh83cwTIgpqRW5Ohyyt5vpW7cgOEmE8B1r+
	 pANoOjYb0lDowODZQ+mJdztMPZ5geMpOB4Cdr2YGGhkl7TWdV0wRY/9+qAMpjGK9tB/AR
	 nkncXtUhE+h+kv77Ho2a2+gr7GzeHtqio0E7NKtqxlPkAy7vCj18iDXu+Ho/u4k/qnP7K
	 5T1sZQJyWNd62QhvYv3QgmjGOROS5dBepuNeM3QGX9vinSL3J7jyp5RsVO2sVzT+jR+4R
	 hvHvj2Wne9oApDaTdl85cuJwLMd/K6tkd6oFWSy0Get4n49Id8GAYYd1DWOXFHTWHvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbzCkTwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BD606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbzCkTwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1661F000C4;
	Sat, 14 Nov 2026 05:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794632908;
	bh=s3tqao3gu78L5JXeH7aKRsHMDDcpMOgJCMMXmjvHGxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbzCkTwvQJUWGAYWXwfcXsz74WbT6MUEsmq8/HhU/0kt7Ya6QR3ac9+9EhjLQ2RVi
	 /rLpujl63B8sl2z5JhnOXnf5BDSy9UHjM22PkMZss1GIi9DN9iCh21O2gf1w5Wvyaz
	 TMRA0ZXHdb699J76+ah6T780rjcba/gXnaJIv7dO9m0pIR1VPtTOUuvzAA4xQFOT1z
	 JOq7lvIsfT6fWzGS2sRTpLWvSCzBHSKS184Pp3ryKrKW3j/L96dX+idYWpOCc2+8EU
	 uxN7vQA83y89oZETtppTtzP9ho/N1zhO4md32OxjUysChm8Xg0FUjSe+F45QLIpJzk
	 S0ajCMMW12MXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <blum@kernel.org>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwrng: virtio - prevent use-after-free after a failed restore
Date: Sat, 14 Nov 2026 00:08:27 -0500
Message-ID: <20261114050812.2912148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202248-failed-5.15-0f7bf47f5a0c@kernel.org>
References: <20261109202248-failed-5.15-0f7bf47f5a0c@kernel.org>
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

From: Thorsten Blum <blum@kernel.org>

[ Upstream commit 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74 ]

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
[ sashal: Replaced virtio_reset_device(vdev) with the existing vdev->config->reset(vdev) callback. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f6c0de82c22bc..72c99fa35e78d 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -186,6 +186,7 @@ static int probe_common(struct virtio_device *vdev)
 err_find:
 	ida_simple_remove(&rng_index_ida, index);
 err_ida:
+	vdev->priv = NULL;
 	kfree(vi);
 	return err;
 }
@@ -194,6 +195,11 @@ static void remove_common(struct virtio_device *vdev)
 {
 	struct virtrng_info *vi = vdev->priv;
 
+	if (!vi) {
+		vdev->config->reset(vdev);
+		return;
+	}
+
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
 	vi->data_idx = 0;
@@ -203,6 +209,7 @@ static void remove_common(struct virtio_device *vdev)
 		hwrng_unregister(&vi->hwrng);
 	vdev->config->del_vqs(vdev);
 	ida_simple_remove(&rng_index_ida, vi->index);
+	vdev->priv = NULL;
 	kfree(vi);
 }
 
-- 
2.53.0

