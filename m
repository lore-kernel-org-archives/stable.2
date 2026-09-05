Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8237C109
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616604; cv=none; b=LuWS42wQSnvU60GpnBpjGrSchaIpPH46dgRmm9ehCjdqk6Q5v+cXbc3eZAId1HcgBIc2UT9xCPjclLyUzN9uneBz76J6hvIhx+AdLCv/W4W5TW81sxSJWnih0ge/oCPsjU0xdckNAq70X9W74rAUw9Bwe3GvSOBCuAmKebuArQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616604; c=relaxed/simple;
	bh=NfVTV0gS6e3kYce6by0fc8cj+oTqVj2xUJAE3M/e0A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nfge1MJxlVgBWj3t07MlV2ckq9zrBqw1riFajbdWcwZzdTqqaNv+o3mAfJeuHAzbVYHRolsjN3smdaXD00+38vShoNckujADxGa/kYGxb2ojgWMHqAw888TitPfUoCq9VCKB8F23nHh05VdZTe4PVw3KZpkxILfaB6zeU0ffpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R25ineUg; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R25ineUg"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485843116d2so93496f8f.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616600; x=1789221400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qv5CI8QgjHSQGUAsYpHOyJ+UdzvD7BcP4G3r/lK7tFY=;
        b=R25ineUg/SOq47m9dw+c0ntmGx1UM81WXt70HW0On4hF1UmCqQAYW9GMJYqOf+BvGq
         CcePcZhUBfnBvvYznAigLuHy8TdgGxYkgxl65n9Y1eUyGRcjcqk6sZ2z7zXxUWKW2JOf
         27X3gsHX7K5dvP3Q/iZllwB7YnNEOJ7BJDbVAl/kbeh/fSCbr2iV/xRR6QSiDIQBeB97
         oiqT9th0a+lP57kCoY1bcc52QxVjs2CU4UlITWBr7P1OzFnuxjD2tHQhJhUJ9smEb0yY
         gw+6WbW6Rf8aKYxQ35fY2NhCDOtf6PZmgD+EvfQ8Wc7ID86KdNOieRdRST4zzNVSwEJ5
         +Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616600; x=1789221400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qv5CI8QgjHSQGUAsYpHOyJ+UdzvD7BcP4G3r/lK7tFY=;
        b=HOC1AxyRCYbXVV53u6teT7WIWmZQSKDiBWKYSQbo0YdScMK1ubNqOmpkGfdK2Q70WR
         xPshmZNdaCS11FueCrWmm7CYu3bHo/o9XZMevS5u4LBpke7Sf8Hs/PZvOShyIHrwY+p2
         rXFW+TVS1rfLl8Co/pawucSUc/IujnZcq+qFxvSAHNbCaNN6g6rc/NoJZP6ZBk4l1JP2
         v2NBFgIpu2zSIeX1bW3hVQE1toWsGcY1eCbOxj5iV6PhVnnMvHtjjQgcV2EqqUpZ5LNW
         GIOskI9X53zc0p2X05RnQ/NWhVRzoTGN2KSvij7jzNi/mvrhSEMmAC2niieYfVM0F7k4
         1OAA==
X-Forwarded-Encrypted: i=1; AKwUvBzIlSi0xQFG8PxmhyPZM2edogCCp574/Ke4weiSsE12qcz607ivOXthsEv0IOGwgMVda/88UTw=@vger.kernel.org
X-Gm-Message-State: AFuF++l/tR9rtN3elPgYHudXZ65/ibIEKJ5NLmTEsWPjX0lefYi4k/AR
	b94ll4ev3XLeDiT5j2jMhVG+y+7QqsYCEx3KRZ2hSHXS8Z0GxNaa0Fdq
X-Gm-Gg: AYBFou0v9wCMlCh46bUFcIIUDYG1tbYXCbouxmrnx7Ue9Rje7mELg/NnyqIHQP1uO2Q
	MiaG3sMtiKyN5ZxJutVENMj6M6JbfiiZWsvP6yu6S4ySLkG01Yanjn38WGpPoMH0ytNzHzjPokn
	bqnKoyS9pHV+TEWzlljR3lkl15UTq0+/hwJEF8qfXjaPDcoZwyi75P5JM9yru3k1sfwmh3LKhIF
	Xdzk4REbulAjLlwjuOwRu5R94ZhI/okW9OhHS5QiJLiKZL8sGTY0cnq2bXb/W16lU8V1nWbSdsw
	1107LfL7awh/Xc2XXsnl7KSb+5EVmulBEShKYZb4xJ+QcOpq6JUyxAzlU7KhxDzGRyy1FKui6FL
	Oi04JRoU6GpFtJBAKGaPto2RpArUtM+UA+brtSKbp2up7LeGjbonY9pMfKLlIvbu6fdoAcu3eoV
	EYbkSGvtg+Rt5e4BBxfDFlCUCfYErE6rJ8C37CWSgE1QRWHJ9En6XQX3/2ajlPqYxXnzyYe6rwE
	+foM8+5d5Tb0PkwEjznJy+bcs/d+AeW8hq247qotnpwIUToNbi0gUjvCjUsomA5jnvA
X-Received: by 2002:a05:600c:c48f:b0:49b:9241:7ff0 with SMTP id 5b1f17b1804b1-49d010c4f64mr47995125e9.0.1788616600147;
        Sat, 05 Sep 2026 06:56:40 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B950E00B62CC1B9060BE3C4.dsl.pool.telekom.hu. [2001:4c4e:1b95:e00:b62c:c1b9:60b:e3c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883927a3sm10523155f8f.11.2026.09.05.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:56:39 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jiaxing Hu <gahing@gahingwoo.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Igor Paunovic <royalnet026@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/rocket: number the cores by devicetree position, not bind order
Date: Sat,  5 Sep 2026 15:56:12 +0200
Message-ID: <20260905135612.7324-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_job_hw_submit() programs the S_POINTER registers of a core with an
extra bit derived from core->index, the way the vendor driver derives it
from the hardware number of the core. rocket_probe() sets core->index to
the slot the core takes in rdev->cores[], which is the order the cores
bind in.

The two agree only while the cores that bind are a prefix of the core
nodes in the devicetree, in devicetree order. Unbind them and bind them
back with a different core first, have one core's probe deferred behind a
sibling's, or disable a core other than the last one, and every task
submitted to a core whose slot is not its hardware number times out after
500 ms. The reset that follows does not help, and the inference finishes
with wrong output.

Observed on an Orange Pi 5 Plus, over all six bind orders of the three
cores: only the devicetree order ran clean. The other five produced 27 to
140 "NPU job timed out" within a single six-second inference, with a
bit-exact oracle rejecting the output, or throughput falling from 130 to
1.95 inferences per second. The timeouts land on the cores whose slot is
not their hardware number, in proportion to the tasks the scheduler hands
them, and in both directions of the mismatch.

Number the cores by their position among the core nodes in the devicetree
instead, which is what the hardware number is.

The wrong value has been assigned since the driver was added, but it only
reached the hardware once the extra bit was introduced, hence the Fixes
tag below.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_core.h |  5 +++++
 drivers/accel/rocket/rocket_drv.c  | 31 +++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca9..46ed8352a79d2 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -30,6 +30,11 @@
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	/*
+	 * Hardware number of the core: its position among the core nodes in
+	 * the devicetree. Not an index into rdev->cores[] - that slot is what
+	 * find_core_for_dev() returns.
+	 */
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883e..e2cde31443ffa 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -157,10 +157,39 @@ static const struct drm_driver rocket_drm_driver = {
 	.desc			= "rocket DRM",
 };
 
+/*
+ * The extra bit that rocket_job_hw_submit() sets in the S_POINTER registers
+ * is the hardware number of the core, which is its position among the core
+ * nodes in the devicetree: a disabled core keeps its number. The slot a core
+ * takes in rdev->cores[] is the order the cores happened to bind in, and the
+ * two only agree while the cores that bind are a prefix of those nodes, in
+ * devicetree order. Every task submitted to a core whose slot is not its
+ * hardware number then times out.
+ */
+static int rocket_core_hw_index(struct device *dev)
+{
+	struct device_node *np;
+	int index = 0;
+
+	for_each_matching_node(np, dev->driver->of_match_table) {
+		if (np == dev->of_node) {
+			of_node_put(np);
+			return index;
+		}
+		index++;
+	}
+
+	return -ENODEV;
+}
+
 static int rocket_probe(struct platform_device *pdev)
 {
+	int index = rocket_core_hw_index(&pdev->dev);
 	int ret;
 
+	if (index < 0)
+		return index;
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -176,7 +205,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
-	rdev->cores[core].index = core;
+	rdev->cores[core].index = index;
 
 	rdev->num_cores++;
 

base-commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366
-- 
2.43.0

