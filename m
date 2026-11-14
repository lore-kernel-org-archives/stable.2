Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630157;
	b=dKUSAg4PZ8vr8lnJoC6O5Vh1wZfeHaRVTjYHv3RFsnOYeyE0KY5PipX/2vrY7oty4vU8
	 uI36EfzQs8oL0Wa/0DjRNIft2sopgd2VMfU+ikIgJgU6IHLcetDA1U4oDp5KglZYPS4eg
	 ZVjlTpCxGQY8DG/pZdKzQu5WM3j+033ACRCgPmoCi/HtVhYTggd+O83VawVLOV/tpG2ux
	 XxroabVa3u4KrMwg7Ie/5Ed2jm3GnZO3nIsv55+UUgGXhV2kZG3CK/Dx6jeBo9SRoLxGf
	 MpHX8jDX+nnYFn/vHAtUfnv1tkh3ka85X7PE6dhQJS3zClkB7c+y2zBC2DbnXv6KUag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fiFcITt6/RWYn37iBuro/+ZBXZ6JM7SRS3rT8//BXxE=;
	b=LUZvIZEAAlDkfKufQVcvvLK5eWgVIrwksd/sRqSNL8OvLYze/kcZEdPniZo7uw1Co2RT
	 qtJNFvHa8Dr5mPoWlD67FQAeCoUoyd/o34YljVKTHtmAvVZTsFZhX9BFHUSg5Dee9z54x
	 H36cyHUloO/qWCTsZG9tbBEziz3vF3ajc6fW7b+Ml5u8RkrOIXfM4dPaPsaF63CQmjhPH
	 BU8uT/M92wp03LDbYgHN0gY5BYB6dXLF0TOXQYstgpYu+fdy/eODek1NYgY+GwTbIf7Fd
	 ahiskYBoIl2MaZG1qf7ONDZsFcEAD4LY2SqKR6VmlZiZbS77dVvd8BQiW+pATPGirmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ7UwBFp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B9606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ7UwBFp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962F91F000C4;
	Sat, 14 Nov 2026 04:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794630157;
	bh=fiFcITt6/RWYn37iBuro/+ZBXZ6JM7SRS3rT8//BXxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZ7UwBFpLvLGaIeTppI925ta+VllUtog1pBXwNlgbCwAh5rNGpGLLisYkMRLeT0qg
	 SEtaMl/HuaCrtFvgPU3+z5U9ALsBO1LrBEUPiYxkYsORmyLV7otryzelPRg3FP1+FW
	 xJZhZImSkSGAT4wDX/uEsVhidzc1oGGnGwT2QpiHr6+j94m2mGE5n5qil6o/9RbCFA
	 LClHmyYPytF/CqletgzslVOaG3Y3HUTA8VffZo2/9wjeu1l839g6CP5eE/3h8Xzotd
	 FY3ffOrl/jkGLjOpur2YlcJdRJnQ80aewnnuzXR9xksvrO3HIPO5sICem3S+mogQ6j
	 4wXyrUvlB5OaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] hwrng: virtio - Remove usage of the deprecated ida_simple_xx() API
Date: Fri, 13 Nov 2026 23:22:34 -0500
Message-ID: <20261114042223.2847229-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201257-failed-6.6-0f7bf47f5a0c@kernel.org>
References: <20261109201257-failed-6.6-0f7bf47f5a0c@kernel.org>
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
index 43e84983c428b..65984504a3ca9 100644
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
@@ -185,7 +185,7 @@ static int probe_common(struct virtio_device *vdev)
 	return 0;
 
 err_find:
-	ida_simple_remove(&rng_index_ida, index);
+	ida_free(&rng_index_ida, index);
 err_ida:
 	kfree(vi);
 	return err;
@@ -203,7 +203,7 @@ static void remove_common(struct virtio_device *vdev)
 		hwrng_unregister(&vi->hwrng);
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
-	ida_simple_remove(&rng_index_ida, vi->index);
+	ida_free(&rng_index_ida, vi->index);
 	kfree(vi);
 }
 
-- 
2.53.0

