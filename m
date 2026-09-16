Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B649B465;
	Wed, 16 Sep 2026 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582150; cv=none; b=ACARKqOFVzHOqfXgr16FLCc2KXuMqZf2C7Dao8A5aCtH6GavNNp8lzzgfFeBZcq4ganHVim0CZrdUAGbN1jUTabAHa5xMS1Ztt9f8v1RqMuQjJYbSe1IxZwjJehNxSY5tFW2TpCSgn5Lo6FauOfnIwjezOVDhXku3BV1InAu4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582150; c=relaxed/simple;
	bh=5bBGmJH7KuWz5PZgORTS44n2/TYAky//GSonzK24UlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AbAOGAMJqlqfd1E4FRfEgn+BVj3T9WgGcJcUQJ33nPI66M7NNpFyLlTI3eng5xauzeXpOAXnWvq+eoYTLXtmMhb0ko6wS3/UFTEFaFUIDqm1JHEpdx8/11gzsb+qBRAOTNbMEDRDGQxFrl9N3vRu/D/N6+AOdZK/8f8pa+P9Byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAj0o26pqDzdvCA--.23140S2;
	Thu, 17 Sep 2026 02:08:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: adrian.larumbe@collabora.com
Cc: airlied@gmail.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	eric@anholt.net,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	simona@ffwll.ch,
	steven.price@arm.com,
	tomeu@tomeuvizoso.net,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panfrost: Fix runtime PM leak in panfrost_remove()
Date: Wed, 16 Sep 2026 18:08:13 +0000
Message-Id: <20260916180813.2090648-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAj0o26pqDzdvCA--.23140S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur4fKr13urW3GFyDAr45GFg_yoWkWrX_ur
	1UuryDXr4YyF1qqws2v3ZxuFyF9FyDXrW8Z347K3yFk3WUXwn0qw12vr4DZr4Uuw43CF1D
	ta1jqF1Yyrn7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgAMA2qqok9+KgAAsw

The pm_runtime_get_sync() call keeps the device awake while the
hardware is torn down, but the usage counter it takes is never
dropped, so the count is left permanently elevated once runtime PM
has been disabled.  Drop it with pm_runtime_put_noidle() once the
device has been marked suspended.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 074c0995ddc2..6d047ca7e208 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1029,6 +1029,7 @@ static void panfrost_remove(struct platform_device *pdev)
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 }
 
 static ssize_t profiling_show(struct device *dev,
-- 
2.34.1

