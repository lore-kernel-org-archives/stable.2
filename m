Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C03016F5;
	Sun, 13 Sep 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304046; cv=none; b=ZRNWlfXDBw5lSu9N7e8fsoxGdCosMw9sbwz7YV9ucsI4xgJuNx3a5dfha3o8tSKjNeHnDL0QF6pBxkpdgIi2P7ln6XO0+SGwHCTv8y+cBagA4LAZblZotHrI2kNZnMzzw7Ts6WEAxbTqYBsyaF7jVKEeg+4aDptCSf4lFV/gfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304046; c=relaxed/simple;
	bh=ay4qyJCaQmXveBRyHeoqGyCcwueesl6T2BFAs3f+Z7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gslz1HMyCantaEaoMS7DKrrDIgxV2mdTqlHoG7iILrwIfAGuSB4oIMBQ/sozUtgcwLiF9XZCrfTOFjnoWap090g1qTnPE2YdRzVh7HnP82hiq81Ui5uiXLEKjP8Qjl57V0zyYhv5RckyYuBI/rvEEUsuycarolcp7LO6vNKQoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnW80Cw4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnW80Cw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789304042; x=1820840042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ay4qyJCaQmXveBRyHeoqGyCcwueesl6T2BFAs3f+Z7w=;
  b=ZnW80Cw4PkPEb5DpJw0vqYhWqZrJvQk0Qdgkf12+Oj/pUJQnJst6TpNN
   lKbwCVHqc3koRyaw2nRi+NB0ERz1dcebZtLHdVlRMYSLYmeAzMMZjZzbL
   YQKGUgBAtD0vRH+bIqsNEqGzSUBvJy9hcESRX9o09A3nysV3Pvh8ldMVL
   63LhifhCi4foWOYkStZmIubwwktmxpUKF7b4sEr2NJSfW6Ue2kbaytOjl
   GnKVi37cAR8d1tasftDwNrI2MIp3VtYo5Z1MbOmARXBECEz7iaWUGbrz/
   TPmK2MOEoX6FpxBrOpLWcbyIDfQlMqgfJ+OeiITeR0hzIB1mKjJhBBHfT
   Q==;
X-CSE-ConnectionGUID: LzXsXkqITcmV91vUMk41+A==
X-CSE-MsgGUID: CjZtUQZkS8mvoWX0AmeiUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11903"; a="101041851"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="101041851"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 05:53:58 -0700
X-CSE-ConnectionGUID: Pj3reVYjSiKANcJMJtEzoA==
X-CSE-MsgGUID: 5YYtgwtCT2yF1d3eeh8Gqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="277638693"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 05:53:54 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Miguel Vadillo <miguel.vadillo@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Knitza <manuel.knitza@googlemail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Antti Laakso <antti.laakso@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: cvs: Do not hide the option in the ancillary menu
Date: Sun, 13 Sep 2026 20:53:45 +0800
Message-ID: <20260913125345.588586-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A camera behind a CVS device needs intel_cvs bound: since commit
c28527ce5d06 ("ACPI: scan: Honor _DEP for Intel CVS devices") the
sensor is not enumerated until the driver's probe clears the _DEP, and
since commit c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU
bridge driver") the IPU notifier waits for the "Intel CVS" sub-device.
The option is sourced from the "Miscellaneous helper chips" menu, which
MEDIA_HIDE_ANCILLARY_SUBDRV hides on any config with
MEDIA_SUBDRV_AUTOSELECT=y and neither EXPERT nor COMPILE_TEST, and
nothing selects or implies it, so olddefconfig on such a config does
not write the symbol out at all.

Arch Linux's config.x86_64 for 7.2.4 is one: I2C, ACPI, VIDEO_DEV=m,
IPU_BRIDGE=m, INTEL_VSC=m, VIDEO_INTEL_IPU6=m, VIDEO_INTEL_IPU7=m and
no VIDEO_INTEL_CVS line. On such a kernel a Panther Lake laptop has
either no CVS driver, so the sensor is never enumerated, or the
out-of-tree intel_cvs from intel/vision-drivers, which registers no
sub-device; the second Link shows the IPU notifier pending on
INTC10E1-0/port@1/endpoint@0 on such a kernel. Both reports had a
working camera on 7.1.

Source the Kconfig from drivers/media/pci/intel/ next to INTEL_VSC and
imply it from the IPU6 and IPU7 drivers, which are the IPUs the driver
looks for, so that a config that has them picks up intel_cvs=m on the
next olddefconfig.

Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-media/20260912185836.309071-1-manuel.knitza@googlemail.com/
Link: https://github.com/omacom/omarchy/issues/10948
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
Tested by running olddefconfig with Arch's config.x86_64 (7.2.4.arch1)
on current mainline: before, no VIDEO_INTEL_CVS line; after,
CONFIG_VIDEO_INTEL_CVS=m. With EXPERT=y alone the option only becomes
"is not set". Not booted on CVS hardware.

For stable: a 7.2.y distro config with IPU6/IPU7 gains intel_cvs=m on
its next olddefconfig; that is the intent. Sourcing from pci/intel/
puts the option under MEDIA_PCI_SUPPORT like IPU_BRIDGE and INTEL_VSC,
which a CVS system needs anyway.

 drivers/media/i2c/Kconfig            | 1 -
 drivers/media/pci/intel/Kconfig      | 1 +
 drivers/media/pci/intel/ipu6/Kconfig | 1 +
 drivers/staging/media/ipu7/Kconfig   | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 5c52007f9cbeb..8573f27b907d9 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1680,7 +1680,6 @@ endmenu
 menu "Miscellaneous helper chips"
 	visible if !MEDIA_HIDE_ANCILLARY_SUBDRV
 
-source "drivers/media/i2c/cvs/Kconfig"
 
 config VIDEO_I2C
 	tristate "I2C transport video support"
diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
index 3f14ca110d06c..dd8c990a0c294 100644
--- a/drivers/media/pci/intel/Kconfig
+++ b/drivers/media/pci/intel/Kconfig
@@ -3,6 +3,7 @@
 source "drivers/media/pci/intel/ipu3/Kconfig"
 source "drivers/media/pci/intel/ipu6/Kconfig"
 source "drivers/media/pci/intel/ivsc/Kconfig"
+source "drivers/media/i2c/cvs/Kconfig"
 
 config IPU_BRIDGE
 	tristate "Intel IPU Bridge"
diff --git a/drivers/media/pci/intel/ipu6/Kconfig b/drivers/media/pci/intel/ipu6/Kconfig
index 1129e2beb4bec..54bd264f7ccd4 100644
--- a/drivers/media/pci/intel/ipu6/Kconfig
+++ b/drivers/media/pci/intel/ipu6/Kconfig
@@ -10,6 +10,7 @@ config VIDEO_INTEL_IPU6
 	select MEDIA_CONTROLLER
 	select VIDEOBUF2_DMA_SG
 	select V4L2_FWNODE
+	imply VIDEO_INTEL_CVS
 	help
 	  This is the 6th Gen Intel Image Processing Unit, found in Intel SoCs
 	  and used for capturing images and video from camera sensors.
diff --git a/drivers/staging/media/ipu7/Kconfig b/drivers/staging/media/ipu7/Kconfig
index 7d831ba7501d4..c23a7844e15e2 100644
--- a/drivers/staging/media/ipu7/Kconfig
+++ b/drivers/staging/media/ipu7/Kconfig
@@ -11,6 +11,7 @@ config VIDEO_INTEL_IPU7
 	select MEDIA_CONTROLLER
 	select VIDEOBUF2_DMA_SG
 	select V4L2_FWNODE
+	imply VIDEO_INTEL_CVS
 	help
 	  This is the 7th Gen Intel Image Processing Unit, found in Intel SoCs
 	  and used for capturing images and video from camera sensors.
-- 
2.43.0

