Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD04FB9A7;
	Tue,  8 Sep 2026 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865061; cv=none; b=L2c9bESma5oqGCmSlZabExjE6FQMbs2Ne1A7Q5uT0QMjcNZmkTUnP36fbx31dJgFi+LT6vy3h5FqsviMcNa/PhFBMVBSzzxSfRlag6EL97I7U1rdcktTr0/blcCwYmjsCTyqFOCg02SA5Xzr5w10vTl7WGuz5aogpEfn7s4hKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865061; c=relaxed/simple;
	bh=HdpRzNsi01Gm+Oi4cNsVzLyBU6oVTR4tJm4QKMDatp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZQyC1kJeGVnjB+3hS81lF2vEekmGV44YgrSNcjXiqaSTMmLZImRqIjhn/wprXh2ABKP/UQiexG3zqTHPuO3lkCxuob0hRjQBuv8lTmgcPN1eedlgo9Y0p+ZbhwG65n/FsW8tIrQIFcIUSj950o+EnRf3oGXXWeQQfMxRYCOW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0qn8lLa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0qn8lLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788865057; x=1820401057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HdpRzNsi01Gm+Oi4cNsVzLyBU6oVTR4tJm4QKMDatp4=;
  b=b0qn8lLaA/OwF+MzZOPUoiXLjrKNhMwNjj+GA/aayY+tGDnVw5ABT6jO
   VVFnZKgHeF06JO8J4FirkXkZHHe01qxhkQ34teeakJelx99bHT9f+Db5j
   /4Pgyi0s7IqbzeFENQwkmY62+qhYy/RQ6UBvz2v0XosRQqP4iS4hokPsv
   x0VVZgoZsXOM1KEPWVcYT3H7Z2B5evKbxsx7QWgXfG6TNpHDSZTd3B4Nb
   TC8n+vmnj6XSAP0rYrmHnYqTu2Pfk91jstfiFp16r6JUw6KPU+9T3grws
   RJl0h7jbK6QWa+L3Jj/YsQxddlqJrYAuQqWmlVgQ7OXphACQIsSyF8CMr
   A==;
X-CSE-ConnectionGUID: qQ2HKuc0SeaHjhAp4+tO2A==
X-CSE-MsgGUID: CnXEyIXaRZeHpVciUDjP3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="114802841"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="114802841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:57:31 -0700
X-CSE-ConnectionGUID: HRfUyJl6RXmslmpNjKhwdg==
X-CSE-MsgGUID: 8xZ5VKOnSW24TGwiFS/J1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="270924516"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:57:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Miguel Vadillo <miguel.vadillo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kate Hsuan <hpa@redhat.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: cvs: Get the wake IRQ without claiming the GPIO
Date: Tue,  8 Sep 2026 18:57:17 +0800
Message-ID: <20260908105717.496232-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wake line is only used as an IRQ source, yet the driver requests
it with devm_gpiod_get() before the I2C handshake. Where ipu-bridge
does not expose the CSI endpoints, CSI init returns -EPROBE_DEFER and
every retry claims the line again for the length of the handshake.

On the Dell XPS 14 DA14260 (Panther Lake) the four CS35L57 amplifiers
read their speaker ID from one GpioIo (DSDT decoded in the second
link):

  GpioIo (Shared, PullNone, 0, 0, IoRestrictionInputOnly,
          "\_SB.GPI1", 0, ResourceConsumer,,) {20}

A request that lands while another consumer holds the line fails, and
cs35l56 does not retry:

  cs35l56 sdw:0:2:01fa:3557:01:2: error -EBUSY: Failed to get spk-id-gpios

All four fail on Fedora 7.1.13, the first Fedora 7.1 kernel with the
driver enabled; the same board on 7.1.12 without it creates the card.
The second link shows the same failure on openSUSE 7.2.2, whose
config also enables the driver.

The INTC10E1 _CRS of this machine has not been decoded. The vendor
driver in intel/vision-drivers requests req, resp and rst the same
way but maps wake to an IRQ with acpi_dev_gpio_irq_get_by() without
requesting it, and on another DA14260 (board 0VRKYR, BIOS 1.8.2) a
build of it is bound while the amplifiers probe. The wake entry is
the line that differs.

Take the IRQ from the GpioInt entry the same way, as the I2C core
does for client->irq; this also applies the trigger type from _CRS.
The driver binds as a platform device too, hence the explicit lookup.

Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
Cc: stable@vger.kernel.org
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2529031
Link: https://github.com/thesofproject/sof/issues/11152
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/media/i2c/cvs/core.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/cvs/core.c b/drivers/media/i2c/cvs/core.c
index d4a3b9c3bab1e..8d857bbd8ab51 100644
--- a/drivers/media/i2c/cvs/core.c
+++ b/drivers/media/i2c/cvs/core.c
@@ -725,8 +725,6 @@ static int cvs_core_probe(struct device *dev, struct i2c_client *i2c)
 	}
 
 	if (ctx->res == ICVS_FULLCAP) {
-		struct gpio_desc *wake;
-
 		ctx->rst = devm_gpiod_get(dev, "rst", GPIOD_OUT_HIGH);
 		if (IS_ERR(ctx->rst)) {
 			ret = dev_err_probe(dev, PTR_ERR(ctx->rst),
@@ -734,14 +732,12 @@ static int cvs_core_probe(struct device *dev, struct i2c_client *i2c)
 			goto err_put_ipu;
 		}
 
-		wake = devm_gpiod_get(dev, "wake", GPIOD_IN);
-		if (IS_ERR(wake)) {
-			ret = dev_err_probe(dev, PTR_ERR(wake),
-					    "failed to get wake GPIO\n");
-			goto err_put_ipu;
-		}
-
-		ctx->irq = gpiod_to_irq(wake);
+		/*
+		 * Do not request the line: another device's _CRS may list
+		 * the same pin, and its driver would then fail with -EBUSY.
+		 */
+		ctx->irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev),
+						    "wake", 0);
 		if (ctx->irq < 0) {
 			ret = dev_err_probe(dev, ctx->irq,
 					    "failed to get wake IRQ\n");
-- 
2.43.0

