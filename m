Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF349B44F;
	Wed, 16 Sep 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573584; cv=none; b=DuSfHW+HWkee3cY7hWYbuQgg51X+1qOwnt2o/38xpAPqilM7H3aZNNPsPIKN3J7J2hBa7A9qDPZZxJkejJmGWV3ll+OLVjgLNyndiO3z3eadHd8vdE9oEGicu7uWB3+o8wkrSSjmEpVp1u98uXQkTINgvXDwKnO6mxIyw66K4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573584; c=relaxed/simple;
	bh=BgpNlBuN0rGTtq3tp/H7w1e+nJNCmx5Wl/E6Kdoddhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ECfpvHF4rsiHvgi80nFMQBZ4ehQPi/6f+cf1jnbScEzGKDiBGQqrVWb34nDTanPckqK9JBS69kEmthp2OBFghPym0eAwW+LaeDNksBgkIX7OyvtuZ+ye2I3VnWkExHRDxapUf2OmtHzP/ODDB688TtSoUpFoDpYhETWaCrb4EqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXwz3BuapqjRBtCA--.21738S2;
	Wed, 16 Sep 2026 23:46:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	thellstrom@vmware.com,
	tzimmermann@suse.de,
	zack.rusin@broadcom.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix tfile reference leak in ttm_base_object_init()
Date: Wed, 16 Sep 2026 15:45:42 +0000
Message-Id: <20260916154542.2063219-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwz3BuapqjRBtCA--.21738S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4fAFyxXFWDKF45CFyUZFb_yoW8WrWkpF
	ZxXrW7tryrJr4xKwsrAa1kXr9xK3ZF9r1DKFyYv3sFvr15Zay3Crs8XayqgFWUGrs7Zr43
	ta109r9xZFWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0ob
	IYCTnIWIevJa73UjIFyTuYvjfUrrWFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqozU9AwAAs9

ttm_base_object_init() takes a reference on the caller's ttm_object_file
via ttm_object_file_ref(). The reference is normally released by
ttm_release_base() when the object's refcount drops to zero, but on the
two error paths, idr_alloc() failure and ttm_ref_object_add() failure,
the object is torn down by the caller without ever dropping the
reference.

Drop the tfile reference with ttm_object_file_unref() on both error
paths.

Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object functionality to the vmwgfx driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..92433b60e282 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -203,8 +203,10 @@ int ttm_base_object_init(struct ttm_object_file *tfile,
 	ret = idr_alloc(&tdev->idr, base, 1, 0, GFP_NOWAIT);
 	spin_unlock(&tdev->object_lock);
 	idr_preload_end();
-	if (ret < 0)
+	if (ret < 0) {
+		ttm_object_file_unref(&base->tfile);
 		return ret;
+	}
 
 	base->handle = ret;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
@@ -218,6 +220,7 @@ int ttm_base_object_init(struct ttm_object_file *tfile,
 	spin_lock(&tdev->object_lock);
 	idr_remove(&tdev->idr, base->handle);
 	spin_unlock(&tdev->object_lock);
+	ttm_object_file_unref(&base->tfile);
 	return ret;
 }
 
-- 
2.34.1

