Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630158;
	b=0dBCwhfiwDMdRithxiqIhy+jglfC3hdiNDHoOQaZ7cp1pSyfnATKryIokyao6Arcq0Jy
	 WJZ4l5rz+3kWiKkC8ah8nUwZ3PdK0QhaAwhcT21An7LnXT0xXK3fh/+PYio9Jv6zp/0jV
	 tFsPmd1CZjZiUMXsoVxV5snekGS0+FEcLv0xcX9pmEBqAKZPk2epBsp3I6+Yty+tnxxSc
	 OZrgWVZ0mumSAQgrOwqVVy5Tl9MfZ9nq1eXrVm7XsaSZJTp7eSOZ4V+ptPQlXjVvMPC5d
	 urDmQNImDfKy/YiFOonBEL7ohMbyVIevkXjWL7iePpgW4B1J4vd4Feo8Hlw6b6nfLJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9LYpH8OROROqGOi14QXEz/eepTQ6ZYQQmVxfDrYZ27Q=;
	b=d8hnE+jWegtE5lD+S6e9Tf7jVexbMhRilp9Gw7caqcR/nTB4a/A9csB1QfTWZIYG1muv
	 RozonKwczrAjFBsP6CvSKvP3qFSIQB2br2KBvwMz9jFjHX0oU0/kyPLFm0B4hofg5kFnJ
	 9r50hh0Q9tSs2OjQiubB4uON1Bf737wrgtai54dTGzh+8Vfy1oNxD5jC/IlvbbpuK5t2v
	 sIP4YB8oNA5LJkG86AJLZJ3szlRp95uKqHSymOpczQbcHxkO5U5K1zgITifwiAce+8pde
	 zcxgd+IxuzQwPc0S3jov2ZpriDiBflcnJ0KRipsiqGnHwFpIX2izuR7EcnqL5HZ1Mfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koxncPRn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F575606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koxncPRn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0671F000C5;
	Sat, 14 Nov 2026 04:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794630158;
	bh=9LYpH8OROROqGOi14QXEz/eepTQ6ZYQQmVxfDrYZ27Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=koxncPRnth8WPAfIC/Bkga65GsQQPc1JL2D3MPMIoIZIrb5zEd8Lklf67VYy9uz5U
	 cu3dS5gMqJQCyW0sUHF3d35sDVmnarcuOLNQTIL+338uNeD3QaR0LVUvtr6dW8stkA
	 OlHcTkdUZ8/EUtj3IWEdNX1FRS2g28DDa1BxVIfnvF1qsz2v8VLLtkJM+vUbpjZfON
	 SNBA0Q1Y8loukbL+H2yLsXTN/+zEAtQuBDnvb9jt7o4ADlBrWe4ntNXDidlok+wNJR
	 P6+a1cpdHMmwy63bG/KDMIzMIGLjWC3BElX2Zyaz+2/UzGkTD+7dC9HAYO9JogiYdJ
	 ir1RUFY+Usuyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <blum@kernel.org>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] hwrng: virtio - prevent use-after-free after a failed restore
Date: Fri, 13 Nov 2026 23:22:35 -0500
Message-ID: <20261114042223.2847229-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114042223.2847229-1-sashal@kernel.org>
References: <20261109201257-failed-6.6-0f7bf47f5a0c@kernel.org>
 <20261114042223.2847229-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 65984504a3ca9..3b47bf1a65f51 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -187,6 +187,7 @@ static int probe_common(struct virtio_device *vdev)
 err_find:
 	ida_free(&rng_index_ida, index);
 err_ida:
+	vdev->priv = NULL;
 	kfree(vi);
 	return err;
 }
@@ -195,6 +196,11 @@ static void remove_common(struct virtio_device *vdev)
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
@@ -204,6 +210,7 @@ static void remove_common(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	ida_free(&rng_index_ida, vi->index);
+	vdev->priv = NULL;
 	kfree(vi);
 }
 
-- 
2.53.0

