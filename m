Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D64CEE43;
	Wed, 16 Sep 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580043; cv=none; b=axWbTIgx/YOO2j+AzCOYzzBhvrB/oeR5949LKAarU4pBP63YkPINAbGnh8eWBYvBxox5PuyOucbNb4B7s5HLeubOFpz4fgzYdTzWKA3h5PqQF1VG/bcXFF7pdm88lGngoBW1TFh4coCgyo3EwMOmYfkSXyarzi3lMAYhfvR0iUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580043; c=relaxed/simple;
	bh=6kQ+pd+y2hnq2xcRHK9oOH+puqcVji+Dwq7yMHn6ZaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7jsiSOBun7UOnDTvHa4rP+l9v2rd7dRGRAwEhHFnfbnqF8ulZ1SBPyM37OSjqXwKalj7vSd3GfNrFPK++9KI9/+h1uSkelgSSkQduElkruqVRaXuqySth5u32qkujF97+UxCbHhwrtNt9jqPjEIhOGU9FbjorrP2i6GGx65JKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnDzr+0qpqua9uCA--.45835S2;
	Thu, 17 Sep 2026 01:33:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: John.C.Harrison@Intel.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	matthew.brost@intel.com,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/guc: Fix rq reference leak in intel_guc_steal_guc_ids()
Date: Wed, 16 Sep 2026 17:33:22 +0000
Message-Id: <20260916173322.2088193-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnDzr+0qpqua9uCA--.45835S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1xXr4kXFW8tF15ZF18Krg_yoW8Gry5pr
	s3XF4Y9ry5Aa1IvanrA3W0qFy3KanFyFWfGw4kGwn5Ga1UJas3Ar9Yva4jq34DCrZ7ur1S
	vF9FqFW3WFy2y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqozVtLgACsD

nop_user_request() returns a request with an extra reference that the
caller must put. If intel_context_create() or nop_user_request() fails
while spinning, the loop bails to err_spin_rq without dropping the
reference held by last. Release it on those error paths.

Fixes: 0013f5f5c05d ("drm/i915/guc: Selftest for stealing of guc ids")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
index 63a75272924f..603843047d3c 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
@@ -197,6 +197,8 @@ static int intel_guc_steal_guc_ids(void *arg)
 			ret = PTR_ERR(ce[context_index]);
 			guc_err(guc, "Failed to create context: %pe\n", ce[context_index]);
 			ce[context_index--] = NULL;
+			if (last)
+				i915_request_put(last);
 			goto err_spin_rq;
 		}
 
@@ -207,6 +209,8 @@ static int intel_guc_steal_guc_ids(void *arg)
 			if ((ret != -EAGAIN) || !last) {
 				guc_err(guc, "Failed to create %srequest %d: %pe\n",
 					last ? "" : "first ", context_index, ERR_PTR(ret));
+				if (last)
+					i915_request_put(last);
 				goto err_spin_rq;
 			}
 		} else {
-- 
2.34.1

