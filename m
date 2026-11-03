Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692828;
	b=F1SNGkfQ5qb/H6mmJTjg2O8C5hZnKsdn4Rz1cZsPlcXnoWm1VzpL0ritx5OpiDesYcZM
	 rtZnmJbjACa1ccVmbobCQMBcbcZZvLb/MNKqD5Y9OoRWP72hjl91MQcN/nWafmQ9YJ91T
	 CailemLKmbuNzPXy/0yuFOUcao1E/rBXYrMnwac0J+EY9/Alz8k3ZdlenyP2nk9c0gOnZ
	 dfuZuqRkrDSMWpj01xwPSzWVnme12bLcPiQcHLhqc1hdmqCfaRfM7CN/PuhdkZAcE4u8I
	 +5MDh1/Tpf5K5DGHvexYRr7HjShZXvTZtutAN24ZIJ18X+GpysusYe8opA5k2oztapA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692828;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=LzceNF2F9XiwGejermgERTUnYejgDHJTzLTn1V/kH6A=;
	b=EvRQznWNQU2D7+CS8DbkIYjtL5Ikc5FVCGxPaDKhYRniqWn5O5fmG2f89xZ3owWevZfA
	 Q5fdqLa9NqaQg/ugqYBPOqyUGNqrdhfZCm9GWGQLF2QQKWzVKODtt7/4655KFoWRmkhiT
	 aLW7hCXdZuCvlOXI4rmWlbeBCSnqR8UmBSg86lZJKnyCJnh+qWH9Beb2u0KpjdkHvQs31
	 h1JGBSsQ3Dml6dqJ3f3KQLFSY+/K8pVXiq727Li4CePrYZJewNq9NHKcEbWYtzQFiDFSF
	 mmbD7VoAK0cFDWSOPe4MauwDYtvNVAxu77C0Vz/WMYeOZ3R4JjZSx1S3M1Z8CRmCXTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7C606A332;
	Tue,  3 Nov 2026 08:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A7C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXaZqVlOlqxiw6AA--.63029S2;
	Tue, 03 Nov 2026 16:00:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/selftests: Balance batch VMA pins in the preemption gang test
Date: Tue,  3 Nov 2026 08:00:30 +0000
Message-Id: <20261103080030.1124149-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowACXaZqVlOlqxiw6AA--.63029S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8Zw1fGryxWF4rWr1UAwb_yoW8uw45pa
	1fGan0krZ8Kw4xta97JFWjv3W3Ja13ta4rCrykK3s8twn8ZFW0kF1F9FyjqFyDAFWfXw1S
	vr4ktrWfuFW2y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6J
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYAA2rpWmXWhwABsv

create_gang() pins each batch VMA before mapping and submitting it. The
mapping and request allocation error paths drop the object without
unpinning the VMA. Later errors drop the request references but also leave
the pin behind. On success, live_preempt_gang() releases the batch
reference after waiting for each request, again without unpinning it.

Unpin on every error after a successful pin. Keep the batch pinned while
the gang is in use, and unpin it when the caller releases each batch.
This preserves the fixed addresses used by the semaphore chain while
balancing the pin before the final object reference is dropped.

Fixes: 2d19a71ce68f ("drm/i915/selftests: Exercise long preemption chains")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/selftest_execlists.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 21e5ed9f72a3..d861e2b27878 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -2734,7 +2734,7 @@ static int create_gang(struct intel_engine_cs *engine,
 	cs = i915_gem_object_pin_map_unlocked(obj, I915_MAP_WC);
 	if (IS_ERR(cs)) {
 		err = PTR_ERR(cs);
-		goto err_obj;
+		goto err_unpin;
 	}
 
 	/* Semaphore target: spin until zero */
@@ -2764,7 +2764,7 @@ static int create_gang(struct intel_engine_cs *engine,
 	rq = intel_context_create_request(ce);
 	if (IS_ERR(rq)) {
 		err = PTR_ERR(rq);
-		goto err_obj;
+		goto err_unpin;
 	}
 
 	rq->batch = i915_vma_get(vma);
@@ -2789,6 +2789,8 @@ static int create_gang(struct intel_engine_cs *engine,
 err_rq:
 	i915_vma_put(rq->batch);
 	i915_request_put(rq);
+err_unpin:
+	i915_vma_unpin(vma);
 err_obj:
 	i915_gem_object_put(obj);
 err_ce:
@@ -3032,6 +3034,7 @@ static int live_preempt_gang(void *arg)
 				err = -ETIME;
 			}
 
+			i915_vma_unpin(rq->batch);
 			i915_vma_put(rq->batch);
 			i915_request_put(rq);
 			rq = n;
-- 
2.34.1

