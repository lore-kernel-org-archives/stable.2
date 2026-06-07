Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5237BE74;
	Sun,  7 Jun 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780823010; cv=none; b=Lvxm6ZRVkEgkySyib6596QWgv7Ie0s5zLH1H+/fLL3r4lu9RKx/GzjzA71h8EpFUz+EB622iEHQRerGwvQXStAwYh4jAYxeFjXx1lmtnSnECAkIySN+lMwjznMwBnyxl/R/c+x+scU5ozGQdyqgrm4X7EGtT2n3Ry8KohIIlgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780823010; c=relaxed/simple;
	bh=4SUUNkzDJdg4r/FrEuPSg45I4nO6KJLxlg215SpNcaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xd3C0bPLE+TB7DmLFbJL4xBzQpwdZfsIa5SnZofF1KO/rxfUrgEFUQjdmAEFBVyV343AneJNQu6DI+tmgR2i0BMtmQNrQ5m9mv/cc9JthFvc40jk+puqoPwKBy+9R2Jz90cIwq+LmZERaEcE/UTNSvqUEEY8rwsUFo3dTheNgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAXKtHQMyVqoCbkEw--.5129S2;
	Sun, 07 Jun 2026 17:03:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/virtio: fix dma_fence refcount leak on error in virtio_gpu_dma_fence_wait()
Date: Sun,  7 Jun 2026 09:03:03 +0000
Message-Id: <20260607090303.92423-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXKtHQMyVqoCbkEw--.5129S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr45GrWxXryxKryfKw47twb_yoW8GFWxpa
	18G343CFnIya1Iqay7A3W09ryrC3ZxArWSgF4j9ayfCwn8XF15tr1DA3ySqryDAFZrt3yf
	Krn7Cr4YgFn5uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwLA2ok4-xRfwABs9

dma_fence_unwrap_for_each() internally calls dma_fence_unwrap_first()
which does cursor->chain = dma_fence_get(head), taking an extra
reference. On normal loop completion, dma_fence_unwrap_next()
releases this via dma_fence_chain_walk() -> dma_fence_put().

When virtio_gpu_do_fence_wait() fails and the function returns early
from inside the loop, the cursor->chain reference is never released.
This is the only caller in the entire kernel that does an early return
inside dma_fence_unwrap_for_each.

Add dma_fence_put(itr.chain) before the early return.

Cc: stable@vger.kernel.org
Fixes: eba57fb5498f ("drm/virtio: Wait for each dma-fence of in-fence array individually")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index dae761fa5788..32cb1e4aa425 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -65,8 +65,10 @@ static int virtio_gpu_dma_fence_wait(struct virtio_gpu_submit *submit,
 
 	dma_fence_unwrap_for_each(f, &itr, fence) {
 		err = virtio_gpu_do_fence_wait(submit, f);
-		if (err)
+		if (err) {
+			dma_fence_put(itr.chain);
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.34.1

