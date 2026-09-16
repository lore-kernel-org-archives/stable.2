Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA251A729;
	Wed, 16 Sep 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573020; cv=none; b=iLUAYW/Ve6o/7Dc/cLakIH6pz6UobdltJoqZcMZfHQ8kKiGLJctR1cSpei5UWh+fMKCL3lOrof/0fBxLc0CxSucLodCPfBv7GaFmLM3A0xMF8zfuO8hHEzy0m/oMDGY//vF6gKMAVN+ATU3+px798iu3qyk10F9w4Y1Y7Cw5iTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573020; c=relaxed/simple;
	bh=Bbu0Yeog8iBpWauweQyv64p+GfTeIXBLJ/ewz1/Cg6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rrkBl3LiwAIOmhfTA1wNgBvl3cPre9gOvxxOHGLHmqZcFNp9EYKzVgdcZ4AUWtnLFrAuYoigaSlK7Tq9tML6BogvNhjB2i8B+7UFNnp+hFaAl5UeRUDRWn4JN1Jsylzm8/KQZD8GZt2oGw2a3GKoPfWgpX4cZK9AX9Bro4Y5X7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXATyDt6pq6e5sCA--.21128S2;
	Wed, 16 Sep 2026 23:36:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	itoral@igalia.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mcanal@igalia.com,
	mripard@kernel.org,
	mwen@igalia.com,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix indirect GEM object reference leak in v3d_get_cpu_indirect_csd_params()
Date: Wed, 16 Sep 2026 15:36:07 +0000
Message-Id: <20260916153607.2048140-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXATyDt6pq6e5sCA--.21128S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr47Ww4fJrW3Gw48Xr18Xwb_yoW8CrWDpF
	sxW34akry3Ar4Ig39rAF4kAFyfG34avayrWFZ7C393Zr1FkF45Xry5KasrZr47AF1rGFy2
	qr1DtayFgryjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcS
	sGvfC2KfnxnUUI43ZEXa7VUb_gA7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2qqpVgwiQAAsL

If v3d_setup_csd_jobs_and_bos() fails, the reference taken by
drm_gem_object_lookup() on info->indirect is never dropped: the caller
only cleans up via v3d_job_cleanup(), but the CPU job refcount is not
initialized until v3d_job_init() runs after the extensions succeed, so
v3d_cpu_job_free() never fires.

Release the GEM reference and clear the pointer when setting up the
CSD jobs fails.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 3ddd53b6f437..f021ab9a69b1 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -465,6 +465,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_indirect_csd indirect_csd;
 	struct v3d_indirect_csd_info *info = &job->indirect_csd;
+	int ret;
 
 	if (!v3d_validate_cpu_job(file_priv, job))
 		return -EINVAL;
@@ -485,9 +486,15 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
 
-	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
-					  &info->job, &info->clean_job,
-					  NULL, &info->acquire_ctx);
+	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
+					 &info->job, &info->clean_job,
+					 NULL, &info->acquire_ctx);
+	if (ret) {
+		drm_gem_object_put(info->indirect);
+		info->indirect = NULL;
+	}
+
+	return ret;
 }
 
 /* Get data for the query timestamp job submission. */
-- 
2.34.1

