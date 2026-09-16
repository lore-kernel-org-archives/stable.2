Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595153D9DA8;
	Wed, 16 Sep 2026 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583327; cv=none; b=c1O1rQoOgxFT7h4cthzeq+kx+U8P4L87FB49Q0uNROyNlWCf78PSl7AVXriogTsNYVz8obHafeRNvg0sLdkK5qmTXxeucxDjjbKjlKFxqt2NW5mM0vZtf+0LYIDfifFsv+LRL9qnuHetu4TN8xQni3Mm4FyNyRV5YCtuf2tUe/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583327; c=relaxed/simple;
	bh=kOkToSjcHPQ+TUFyAlJlAw/w6CeTVyoy/LuB7BXfH6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGlUQ3Fs2vsMNWVcreMWGRDr4tdB2OzgFmb41CNYM84ynT08RifyKCm6wULtkHdXMRc+TbXilCydpsgSZw+U/uqFOtkISQ3CGVgSckceNtXeela/+441qRbT5IFUwUz7hRRGReJHfxrH4k3Ei1yhFTsmJi1mznl7fdMBbiy1fhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3pD7I36pquoZvCA--.23473S2;
	Thu, 17 Sep 2026 02:28:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: alexander.deucher@amd.com,
	dri-devel@lists.freedesktop.org,
	imre.deak@intel.com,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tests: Fix tmp_connector reference leak in drm_test_drm_connector_dynamic_register_mode_object()
Date: Wed, 16 Sep 2026 18:27:57 +0000
Message-Id: <20260916182757.2091940-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3pD7I36pquoZvCA--.23473S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW3Gr1xJFyDuFWxCFyfWFg_yoWDWrg_WF
	1DuanrWrs8CrykAwnrAan5AayIv3WDZFs7Xw15trWFq3yxtw17ur4xC3WYy34DWay3Aasr
	Kas8GFWjyr4xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqozWEAwAAsE

drm_connector_lookup() takes a reference to the looked-up connector,
which the test never drops.  Release it after the lookup succeeded.

Fixes: 9ce43bba6569 ("drm/tests: Add tests for drm_connector_dynamic_init()/register()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index beb1d50a6646..bc63e722117d 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -582,6 +582,7 @@ static void drm_test_drm_connector_dynamic_register_mode_object(struct kunit *te
 
 	tmp_connector = drm_connector_lookup(connector->dev, NULL, connector->base.id);
 	KUNIT_ASSERT_PTR_EQ(test, tmp_connector, connector);
+	drm_connector_put(tmp_connector);
 }
 
 /*
-- 
2.34.1

