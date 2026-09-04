Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840548F85A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526801; cv=none; b=Lzpl6zmjvMzpBf6NOWYR8js/jYAZoe28iZ/MWSY6tuL06E0+yj3nW8+Y4NIzSdhpEzJ2Yu/yQA7CwzkLMa8/eQXx5d9nzi99ZjWh537hPSiA1wAxPH5inM1Fw3/n3OLPw0MSgJq7TzD9ixgjFaZGYN9BbgnSAPnsXXwlNx5y5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526801; c=relaxed/simple;
	bh=I/KTbjtAaB7aXggM7MM4kLgg/LraEEcLZGC3XenT6FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSEIHF905YDaklTEHaT2jSPAJKUYvM/xYV2irgEnKg2G6P37c+Y9Z1MRrCFJ8AEy1uruIgmi5c+atwcQ2cpZeKhiFACTP5pXOyTvTKwBr1D+HDWInRzI5yZA9GQ5cymDL9ABqsTWp0MEKX3yNBLWMiDJmCVu3g0KlGRNx8lpqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxps07nl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxps07nl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b4ba7fe26so260225e9.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788526798; x=1789131598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/WcwZhKQetLuVj0VCLbzfxuQncGS/yqg6oOZ6MnNyQ=;
        b=pxps07nlWeqYNvTjgGIXpVnvgLA6z65FufSuP2ZUGtN3ROMeWaFlEB0XBxwxA1rGmf
         1uNYt17YP8VRh0r+Lv+UN+w+oOrQeEiljZ4f6b3bfrZ6g1vBMW3aopq7IQJPQsgdQ1M4
         NXUsrkXsOmzk5w0pqHEeQELC56hm5497FUu+jMUWjq7r0fbByIntsd4k1a7NzX/JZ0/d
         AbYKLh3HNcuCJwyMltoDXwxqwIiDV0Klb92JKPCv9lAtyfOwmxMB5oMCbaLV/m9UwQJ6
         VvGvlpFh+OHYzg7k10EToSR7jS8qLbDJMxdMSR54hH8K/G/Mv1hVyip4bsxjh5StEwSy
         NCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788526798; x=1789131598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/WcwZhKQetLuVj0VCLbzfxuQncGS/yqg6oOZ6MnNyQ=;
        b=Dbc7oriMglXEVgL2/Vp6C23Sd5P/dVj5RHCfak8DQ+GwJ7zDoD2UB+zmKTA/+gGs0o
         T9dW9JnLg0pwXrCsu4HW2nRXmg1vp16JXwWRf3ZTw4UwmlXOYy0mCCyobCKQ8ubMq/Aa
         1K6htxHdR7HJZLBjkudYACOEIhoqLFLafjbkftJ6yKFWvQicH3CPiWrzRddWx9WsDp2V
         W0GUzgUK+2+l4wvfqwUUsIgTaEIIUXFdzqBEDT73tg766F0DxeEOXpOyfmUMmptb3tb6
         zmABtGC0CR75UvKMrujrPYcVpzXQNvsc+jgSKzVje5wQhtEvv+PqsHIXkCxgrvwd+NK1
         ENXA==
X-Forwarded-Encrypted: i=1; AKwUvBxX4i3ls1www3g4AEpTAyh3mSV5UfpRe7UKvN0kV3toYhQlY8Qf6KPqZfu95anwrnoWSMKyLwM=@vger.kernel.org
X-Gm-Message-State: AFuF++lKXAQIuuBTAv4N1fUJK0lGNDHyQNmvZfGcTcETVpJJEYLr/wjK
	bFgO01vsVxyPbOu4dnRbhVKPtDBOW6NoFRvgyeKvfzGE91mcAZUnLPqg
X-Gm-Gg: AYBFou3uiD9+xmdpO5WPQ3HQ4RdRdS65wueRfOyaq3uhSSoFPUkp8N/pbAw1O8l4QfY
	XT7L+HFRsDo6s0bY/xemwQPao60oBfaH38TDXcn4VGCqYMfLni/HSSQ95qKiisf1/62UY1WDOSp
	Wo8K2XpX47Vby9IjaydgUnF8aFC1OKKAXpE6yBqzEClHs+0P90dbYVZxnbxyRBL9Pmhc0wZv19M
	z1rHDbCL6rPwokbwzOpysxIjUio7Xr36CqznWIaV+Do4mD/IdnLzr14nuCj7tcEpPUe9/crnaLB
	I/8WSFhD8YohP7GYWuPGRb+vB0lXQqIhhEVBY/Wv0xdVmAvOFjSL1R4/Lvs2gH4fIAjpOZ6035Q
	Ehfy8gBbKNRVTo6ZfzhAtBxLpDqN3GTFTgiRlNNUgUNXMbnt93aseIeqaQJddPn2qBTJ/RWOEhX
	lzbd9waaaUKeNOmAZTEBzCbm/ehu1a/embQNlmjU6x7alhpbD1Mcm90bOMMRWIvDuOGynFIg2dm
	44CO1tEvJUuII1IhOHdtQyYyIUcSzRnRuHyrHykP/uvAcbACpnzhwcTZD1obuMRMF78EvxE1tvn
	JRmQMBmvZRTTgYM=
X-Received: by 2002:a05:600c:34c5:b0:499:cef6:104c with SMTP id 5b1f17b1804b1-49cf823c012mr40540685e9.1.1788526797556;
        Fri, 04 Sep 2026 05:59:57 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu. [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce554d52esm135287435e9.3.2026.09.04.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:59:56 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jiaxing Hu <gahing@gahingwoo.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH] accel/rocket: search every core slot when a core is removed
Date: Fri,  4 Sep 2026 14:59:36 +0200
Message-ID: <20260904125936.26234-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_remove() decrements rdev->num_cores for each core it removes,
while find_core_for_dev() searches slots 0 to num_cores - 1. Unbinding
the cores in the order they were bound therefore loses the last one: by
the time it is removed the search range has already shrunk past its
slot, so find_core_for_dev() returns -1 and rocket_remove() gives up
without doing anything.

num_cores never reaches zero, rocket_device_fini() never runs, and the
file-scoped rdev keeps pointing at a device that is going away. Binding
the cores again starts from that stale count, because rocket_probe()
takes rdev->num_cores as the slot to fill. On an RK3588, which describes
three cores, the second round lands on slots 1, 2 and 3 while rdev->cores
was allocated with room for three:

  rocket fdab0000.npu: Rockchip NPU core 1 version: 1179210309
  rocket fdac0000.npu: Rockchip NPU core 2 version: 1179210309
  rocket fdad0000.npu: Rockchip NPU core 3 version: 1179210309

The write to rdev->cores[3] is past the end of the array.

Nothing in tree reads the core array often enough to notice, so the
overrun is silent today. It turned up while testing a devfreq series on
top of this, where a worker walks every core a few times a second, and
UBSAN caught the first bool it read out of the overrun entry:

  UBSAN: invalid-load in drivers/accel/rocket/rocket_devfreq.c:47:10
  load of value 5 is not a valid value for type '_Bool'
  Workqueue: devfreq_wq devfreq_monitor

Record how many slots were allocated and search all of them. Every core
is then found on removal, num_cores reaches zero, the device is torn down
and a later bind starts from a clean rdev.

This does not make unbinding a single core out of several work. probe
still takes num_cores as the slot to fill, so rebinding one core while
its siblings stay bound would write over a slot that is already in use,
and rocket_open() still reaches for cores[0] whether or not anything is
there. Both of those want more thought than a fix should carry.

Found by unbinding and rebinding all three cores on an Orange Pi 5 Plus.
With this applied, 25 unbind/rebind rounds and 5 module unload/reload
rounds run clean there: the cores land in slots 0, 1 and 2 every time,
whichever order they are bound in, and the shared supply goes back to a
single user after each round.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_device.c | 2 ++
 drivers/accel/rocket/rocket_device.h | 1 +
 drivers/accel/rocket/rocket_drv.c    | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e72c5f..efd004194c1af 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -31,6 +31,8 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 		if (of_device_is_available(core_node))
 			num_cores++;
 
+	rdev->max_cores = num_cores;
+
 	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
 	if (!rdev->cores)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index ce662abc01d3d..c62d567010696 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -19,6 +19,7 @@ struct rocket_device {
 
 	struct rocket_core *cores;
 	unsigned int num_cores;
+	unsigned int max_cores;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883e..2bcfe4ab3c68f 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -223,7 +223,7 @@ static int find_core_for_dev(struct device *dev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(dev);
 
-	for (unsigned int core = 0; core < rdev->num_cores; core++) {
+	for (unsigned int core = 0; core < rdev->max_cores; core++) {
 		if (dev == rdev->cores[core].dev)
 			return core;
 	}
-- 
2.43.0

