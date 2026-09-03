Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12553AE190;
	Thu,  3 Sep 2026 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437840; cv=none; b=uSHyMccCMO30w3qoWDN0DzWHPaX4XZIKrz3ckS9OQw9k6Mp8WAgL1Ho8Qc1In32k2bGGgGM7djCEqhXoB1qBVhMiyvfqOowu69eJ7SDR3iFGHxstxYhMVEGJn1xiTnpFyu290iQEJlYlBX7seguTWm7x3gfpQrKt5TNK0TWZKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437840; c=relaxed/simple;
	bh=BnrE7kEzY8dWFI0K1T6AL/3cc1AcPsxhd6uyIrWWp5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DH0d1pC3TTlUZHFRgv8McfBl06BezLlief/+21+fSf3s0NU3s5QOf97bVDNCPoGj2Z4lyoGqXSg5wH31F1QxpvL5kEaJ8qTRgRg4+xQuo3rGQs+XkznuO/EWQLxeB9hmbxUHzpURpLMGzKWfPR0XTvm65mQH5CcZjrp5OMO5r34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EQslB3W5; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EQslB3W5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bR
	RJiITqLGBDhUvWeksvOKIPYPbBJH9B9tHuU5D6pPU=; b=EQslB3W5cLVWKjz3hs
	wB8bouYPyhAxUHEUi+h9D3rXmztrtk9ZH+bZXN4mLk+HJ00P0hqG9P9hjwaiKqzh
	V3QBSxRkun3+mitMlKwhILuYkWTrLWOhlfzxgJTvBlyr6yFkx9DkdVPJy2pB1wSx
	DrLrf/nvmbrGNDID8SMqvw4zI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnk6MAZZlqxNt_AQ--.12555S2;
	Thu, 03 Sep 2026 20:16:02 +0800 (CST)
From: oushixiong1025@163.com
To: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/sched: Create a fake device for KUnit tests
Date: Thu,  3 Sep 2026 20:15:58 +0800
Message-Id: <20260903121558.782854-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnk6MAZZlqxNt_AQ--.12555S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW5Zw4DXFWUuFW8Jw45Awb_yoW5GrW5pF
	WkXFWYgrs5trZFg3y3ua95XFyfGws7A3yxKr1kX34a9F1qgFyfJr1UKrW7J34UArWUZFWS
	q3Z0gw47Gr4jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8Z2-UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-gJaaWqZZQJWEAAA3d

From: Shixiong Ou <oushixiong@kylinos.cn>

The DRM scheduler KUnit tests pass NULL for the dev field in
drm_sched_init_args, which NULL-pointer dereferences in the drm_sched_job
trace event via dev_name() on sched->dev.

Give the mock scheduler a device with kunit_device_register(), which is
also cleaned up at test exit. A per-function counter keeps the device
names unique, since some tests create several mock schedulers.

Fixes: 5a99350794fe ("drm/sched: Add scheduler unit testing infrastructure and some basic tests")
Cc: stable@vger.kernel.org
Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

---
v1->v2:
  - Switch from faux_device_create() to kunit_device_register(), which also
    cleans the device up automatically at test exit (Maxime Ripard)
  - Build the device name on top of args.name (Philipp Stanner)
  - Make the instance counter a static unsigned int local to
    drm_mock_sched_new() (Philipp Stanner)
  - Add a Fixes: tag and Cc: stable for the NULL dev dereference

 drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 11 ++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
index 8e9ae7d980eb..12dc61f56192 100644
--- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025 Valve Corporation */
 
+#include <kunit/device.h>
+
 #include "sched_tests.h"
 
 /*
@@ -288,6 +290,7 @@ static const struct drm_sched_backend_ops drm_mock_scheduler_ops = {
  */
 struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 {
+	static unsigned int instance;
 	struct drm_sched_init_args args = {
 		.ops		= &drm_mock_scheduler_ops,
 		.num_rqs	= DRM_SCHED_PRIORITY_COUNT,
@@ -297,11 +300,19 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 		.name		= "drm-mock-scheduler",
 	};
 	struct drm_mock_scheduler *sched;
+	struct device *dev;
+	char name[64];
 	int ret;
 
 	sched = kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, sched);
 
+	snprintf(name, sizeof(name), "%s-%u", args.name, ++instance);
+	dev = kunit_device_register(test, name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	args.dev = dev;
+
 	ret = drm_sched_init(&sched->base, &args);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-- 
2.43.0

No virus found
		Checked by Hillstone Network AntiVirus

