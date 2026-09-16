Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475F4D0CD5;
	Wed, 16 Sep 2026 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579596; cv=none; b=frDSFctidlbSCZmLbNVS8EvwraGjsMuk+fUbivsfryfLoOW+hm6WVNAx+fSapjNtGENAaYARqrDfHWa775XH4gtSQzw3PK2b4o0dRshalZXbmgaGv5W4FsOqdmhOQtJ+VwHPr3If1YjSoT6fGkNhL7NbKRdxb3L0G5tCXDMI0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579596; c=relaxed/simple;
	bh=AhpLtqGNAH+VUImvHnuwgDAzlAGIYJdklwlXZmm6V04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOvxBcN34rQPkKCaiksde64+CqFTwWgvlVV1QCI7epuLujpoNGTqr0Qrxi5ALZp25P68JcvHiSnlcucJlakuZySKghKR+u2accxmq0+avxX05Bo9XiN7x47y0ehb+fWsl+O9oaxGTnMCmsDGIRdOyBeiS7zdJr2EUebH1Kw/C+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD9A0apqapZuCA--.23115S2;
	Thu, 17 Sep 2026 01:26:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: chris@chris-wilson.co.uk,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	matthew.auld@intel.com,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Fix rq use-after-free in perf_mi_noop()
Date: Wed, 16 Sep 2026 17:25:56 +0000
Message-Id: <20260916172556.2087724-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD9A0apqapZuCA--.23115S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtF4DXr48WFW8Wryktw18Zrb_yoW8JF4rpF
	4rJF4YvrZxJrWIka1fJrW0vFy5Ka1SyFWxKrnrKwnxZr15X3Z5Jr1Iv3WagryUArZ7Wr43
	JFs7KFW3WFnFkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJbIYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqozVqnAAAs0

The i915_request_put() after the wait may drop the final reference and
free the request, yet the following cycle counting still reads
rq->hwsp_seqno. Compute the cycles[] entry while the reference taken
before i915_request_add() is still held.

Fixes: 3c7a44bbbfa7 ("drm/i915/selftests: Perform some basic cycle counting of MI ops")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 5ffa5e30f419..7503763136b2 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -351,13 +351,14 @@ static int perf_mi_noop(void *arg)
 
 			if (i915_request_wait(rq, 0, HZ / 5) < 0)
 				err = -EIO;
+			if (err == 0)
+				cycles[i] =
+					(rq->hwsp_seqno[4] - rq->hwsp_seqno[3]) -
+					(rq->hwsp_seqno[3] - rq->hwsp_seqno[2]);
+
 			i915_request_put(rq);
 			if (err)
 				break;
-
-			cycles[i] =
-				(rq->hwsp_seqno[4] - rq->hwsp_seqno[3]) -
-				(rq->hwsp_seqno[3] - rq->hwsp_seqno[2]);
 		}
 		i915_vma_put(nop);
 		i915_vma_put(base);
-- 
2.34.1

