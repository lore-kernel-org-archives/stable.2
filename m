Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049763ECBED;
	Wed,  5 Aug 2026 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921187; cv=none; b=ry0EilzQanIrPfWtx6Cj5zGP/+jMHxjGIS3XU3EBd/xxb3O0F/ObNCUWwqyCVAkjofy9XvOkPls6hnU5t1nIigSJdcsyWQ3wp+pe18O7/f+541uiaz6srjzwcudCw1KfLHke7oCz+FHSIIocb2vU0V+PV5XEdfst4vvdPy7FnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921187; c=relaxed/simple;
	bh=/GtezGhgXO7aXEf4An9d7FGUqge9XyvQyRYYYCXxIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8Vir/S30Lv+4XtCNV2L17PW1cZhkoIoXsJJ11EDYp8+vbNUjj9+P+TfVI6eZT+eDSe3Msd/8HNzcrOOsfZYX0sJ11MgYsP6bd6OLEwy8FlU/nhpZ5eP/brVpTx9Fgf1xBCoQxdZSLXQvXTqC0bs05TCeZqfV4KB2upi0s5C7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+BKaNHg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+BKaNHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785921186; x=1817457186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/GtezGhgXO7aXEf4An9d7FGUqge9XyvQyRYYYCXxIP8=;
  b=g+BKaNHgj92r1SOObNnkdXVuLviNdsCrmvibtpxI3iNqNHAfBFmOUsgU
   7fLKNVGcv4H+neXL7bBJZgtUfyqwCpI0gPZ+FurPTAefKlKJ2yVn1sDBL
   tw52Jwsw4cEkxbNfbGfkH99vqXNqLle34kDpCBX93u+tpoqvYlwEyOtdM
   /eOeYZ/bSNpWI9JVj2YKf9qhSR4KbwjFWOxg3cXdUYKDuV+vbcNhMiB0X
   1olyY7ftDbJazVJmIsNmMSqBqJDkwgovrCsESeJdBUdKRUWjfu80fjYI8
   +aUEx1/8e80c+v1BRBGTrTom24ZB57xNBqzxf9+r6qKRrmrg+EHGOlUA7
   w==;
X-CSE-ConnectionGUID: vn06zRNpSf++RcvJ0Rn6ng==
X-CSE-MsgGUID: vzNv4K3JTt+PBidvUJl6Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86260666"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86260666"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:13:05 -0700
X-CSE-ConnectionGUID: oLHP7ESvSq6fv0iTdYIMGg==
X-CSE-MsgGUID: KmhDt+snTZeaPiaLgPFPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="259993248"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:12:49 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: tas2783-sdw: drop duplicate reg_default entry
Date: Wed,  5 Aug 2026 12:13:26 +0300
Message-ID: <20260805091327.23944-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TAS2783_AMP_LEVEL is defined as TASDEV_REG_SDW(0x0, 0x00, 0x03), so
tas2783_reg_default[] lists that register twice.  Drop the open coded
second entry.

Fixes: 4cc9bd8d7b32 ("ASoc: tas2783A: Add soundwire based codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/tas2783-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 3d0b116544cc..c520251cc3be 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -106,7 +106,6 @@ struct tas2783_prv {
 
 static const struct reg_default tas2783_reg_default[] = {
 	{TAS2783_AMP_LEVEL, 0x28},
-	{TASDEV_REG_SDW(0, 0, 0x03), 0x28},
 	{TASDEV_REG_SDW(0, 0, 0x04), 0x21},
 	{TASDEV_REG_SDW(0, 0, 0x05), 0x41},
 	{TASDEV_REG_SDW(0, 0, 0x06), 0x00},

base-commit: 05eebef3c7b2e8595fdd1bd46912aac9c1de8587
-- 
2.55.0

