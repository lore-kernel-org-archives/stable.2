Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630435;
	b=Afthl+uFqm0vw3cFaBJIajfmC4gfGtncEYqmfqk7XeJXpoIzFVMihClYVB1QYe/umpuW
	 uhVUa2CMUv8P/fcWVO+T8oRT0ohslEW8fY844u5N9GNpryNWy9fpUXItCIck9jtKom6R9
	 LCXu2r34fZz+05sVBYiMimUb9rhEC7oOxaF6rCtOOIIiH0uYTmLboLmvT550wAB3bv25Q
	 O73andzrMyESeOvSWrECKt012aK++TXZ4C54L/JA1+gHUtBKcDypL3uEIjaCv8FTUuTnu
	 Cvb+L9SBt2243AqTzYif3Deey8HljLOlxCm8Lf/c3EAw2C18ItWsKgaUIICxiJvoHkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gQTgLIJ8DgKlqzfQLgPuzzldH+6X9KiUl4ktTp2Q+Cs=;
	b=ZMngA+mn0ag5uZpx90R+mbw7MnmzxtTL3Tdqhch9LMYBaShTbSRxlVMiq/dL+i+Oj2kc
	 iEE9mcH+ZjTd+PFq7mXXHX6VkW1Ya1JL0Bq/CrI1nId7gxSD7IU+gjG2FWv9y3c1DFKuV
	 tvUhs6gBzCzma6vbVMogQSsMyOXvGUNyS57BM8Gl7bpDDDM0gIIft94xKR3DuzDrSCRoN
	 Nc40hKc+pM4NeIiigcX20qZFQdMRvTH0dHH+WHMIgop02JTtZrK9r8dbgAbyreYAKFFa6
	 d5Rh8gMa1pz3iIaiVozQLuMoU93QHIF4h25bTW+wjDsVeXkRFANa7H30G3Z5D2x4jeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXpbPIBi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA54606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXpbPIBi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CEE1F000C4;
	Sat, 14 Nov 2026 04:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794630434;
	bh=gQTgLIJ8DgKlqzfQLgPuzzldH+6X9KiUl4ktTp2Q+Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXpbPIBisR+uEeTz9xY6mvkyOnKHxYbU0SMmwIl0bEd7k0/Zr2dLpFxhkBfScwYd7
	 9A30vhoAxlgYzewHQHcuNQsPpgHjsdEJ7xThZMxH/0k1Kgez3Oo502CiJq43wbSRqO
	 btoEXNCtG0/KP76FrTtVTMjz2XMTHr6PIL8NC9euWY050iITuYC+1FW58ZHrq1Fc4a
	 TcK+tzF4UMDnNxYoVzR3/aLwK0cRDN9P8/E/ZeqNb69VuaONhbrR1NwGP3fIJfNe5i
	 IBq5/6Rzcy8uPXr/V9Li5aXtrGIxlIvfx3qO4OtYQRO8Z1z+NchTBEXTEYr24g8L85
	 0tgl2fLDzhUmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] hwrng: virtio - Remove usage of the deprecated ida_simple_xx() API
Date: Fri, 13 Nov 2026 23:27:11 -0500
Message-ID: <20261114042658.2897777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201748-failed-6.1-0f7bf47f5a0c@kernel.org>
References: <20261109201748-failed-6.1-0f7bf47f5a0c@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e4db80d80cff590eb5fe0444b665cec839c34133 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 0f7bf47f5a0c ("hwrng: virtio - prevent use-after-free after a failed restore")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 279cdbdeee845..14ab1c2a7350b 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -154,7 +154,7 @@ static int probe_common(struct virtio_device *vdev)
 	if (!vi)
 		return -ENOMEM;
 
-	vi->index = index = ida_simple_get(&rng_index_ida, 0, 0, GFP_KERNEL);
+	vi->index = index = ida_alloc(&rng_index_ida, GFP_KERNEL);
 	if (index < 0) {
 		err = index;
 		goto err_ida;
@@ -186,7 +186,7 @@ static int probe_common(struct virtio_device *vdev)
 	return 0;
 
 err_find:
-	ida_simple_remove(&rng_index_ida, index);
+	ida_free(&rng_index_ida, index);
 err_ida:
 	kfree(vi);
 	return err;
@@ -204,7 +204,7 @@ static void remove_common(struct virtio_device *vdev)
 		hwrng_unregister(&vi->hwrng);
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
-	ida_simple_remove(&rng_index_ida, vi->index);
+	ida_free(&rng_index_ida, vi->index);
 	kfree(vi);
 }
 
-- 
2.53.0

