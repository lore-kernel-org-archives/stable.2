Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78023643F;
	Sun, 13 Sep 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306230; cv=none; b=D/LmauyC+QlDh1qS3IqIRFvaCI4ifmMPe1dKafqxZtc6jAT6zhyGCTw4/VFmXvydpBaxIzbz8vqO3JZ7bJg8jaFPHFJFD3XaSB80ZxA5txjgGiWcVJIwN3G0n8cm2unwZzy+QOsZi8QOICwpcnYDOFE9bjHbdSMK7MDb6Bma7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306230; c=relaxed/simple;
	bh=v67ykjHquTpdhGJFC1Yg0Bc8WcnPj76gEMicvECakh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrTgf2hfFpAHnwKK5xc85crKbLqrw1gxSw21STv4MWcShzGxcr/8r3/EGYJ4ut5yjZTM5Um3OgVBF//VjX+OhEhAy2rpTVy/6j/SLjLJWB6qMOr54AWGMxvMtwYsmbG+tAx6NPuJdKHYVs34xXspPtvlZuBB6qGuHKT0LwJsCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENyAmWH+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENyAmWH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789306228; x=1820842228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v67ykjHquTpdhGJFC1Yg0Bc8WcnPj76gEMicvECakh0=;
  b=ENyAmWH+mLESN3laKi0Saz59rkefb4qqMAL/9m7uJa19yAxhrHjJGxBf
   En6N2x9Qi0WCtKFrQSnhUpJznnsKsB+5Wb1tj3/Bx0ku6m/LKbZ1cy6oU
   3XIQANe9J0j9WNrTSR2AI/rmaWrRIKj0H2EnJUDeXlLLYJRYG2LQ7voHU
   IRLNp7yWXZgL/twlVfi2LHcjAZJr85Tzh04JFBSVgs8VoQJYUvTgNvY9m
   GxaHD+WFLymZYkIn82q8OCDStC8NQxhr6KyckXJu2xK20Yg95lRekmPrF
   59ZdjsNR8kND6F2Upa0javjGPHfjuFpLt4EcWibJecUNCmgf/rd9YMPXn
   g==;
X-CSE-ConnectionGUID: iafcZtGiQQaiffrWTz+p0g==
X-CSE-MsgGUID: r8PA0QrcS2mIoboES/uqiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11903"; a="100018305"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="100018305"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 06:30:28 -0700
X-CSE-ConnectionGUID: oL0M0WpWRMy+KGLosSg7Fw==
X-CSE-MsgGUID: JJdBRzNoRk624Y71PLnYvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="295882722"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 06:30:25 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Miguel Vadillo <miguel.vadillo@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kate Hsuan <hpa@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Spencer Bull <spencer@omarchy.org>,
	"jan p . springer" <regnirpsj@gmail.com>,
	Antti Laakso <antti.laakso@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] media: i2c: cvs: Get the wake IRQ without claiming the GPIO
Date: Sun, 13 Sep 2026 21:30:17 +0800
Message-ID: <20260913133017.624919-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wake line is only used as an IRQ source, yet the driver requests
it with devm_gpiod_get(). On the Dell XPS 14 DA14260 (Panther Lake)
that request lands on the pin the four CS35L57 amplifiers read their
speaker ID from. Each amplifier's _CRS carries

  GpioIo (Shared, PullNone, 0, 0, IoRestrictionInputOnly,
          "\_SB.GPI1", 0, ResourceConsumer,,) {20}

and INTC10E1 builds its _CRS at runtime from pad numbers kept in NVS:
a GpioInt (Edge, ActiveLow, Shared) first, then an Exclusive
output-only GpioIo for reset and two lines on the USB GPIO expander.
The driver maps index 0 to "wake". While it holds the line, cs35l56
fails and does not retry:

  cs35l56 sdw:0:2:01fa:3557:01:2: error -EBUSY: Failed to get spk-id-gpios

All four fail and no card is registered. Fedora 7.1.13 is the first
Fedora kernel with the driver enabled; 7.1.12 on the same board
creates the card, and 7.2.4 creates it again with intel_cvs
blacklisted. Where ipu-bridge does not expose the CSI endpoints, CSI
init returns -EPROBE_DEFER and every retry claims the line again for
the length of the handshake, which is how 7.1 fails as well.

Take the IRQ from the GpioInt entry with acpi_dev_gpio_irq_get_by(),
as the I2C core does for client->irq; this also applies the trigger
type from _CRS. The vendor driver in intel/vision-drivers does the
same. The driver binds as a platform device too, hence the explicit
lookup. A DKMS build of the patched driver on a DA14260 running
7.2.4 binds with all four amplifiers probing and the camera working
(third link).

Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
Cc: stable@vger.kernel.org
Reported-by: jan p. springer <regnirpsj@gmail.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2529031
Link: https://github.com/thesofproject/sof/issues/11152
Link: https://github.com/omacom/omarchy-pkgs/pull/419
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
v2: decode the INTC10E1 _CRS from the reporter's acpidump; add the
    blacklist confirmation and the tested DKMS build; Reported-by and
    Closes. Code unchanged.
v1: https://lore.kernel.org/r/20260908105717.496232-1-junjie.cao@intel.com

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

