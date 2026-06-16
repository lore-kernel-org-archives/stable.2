Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624F3BB11B;
	Tue, 16 Jun 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610669; cv=none; b=Ov1c4ha+eYNSvl7IN/ZGjCSBNkIxbpZN9v4Bo36a3hWI89HifTmgjNy1bEenvWyZCLqzRqUfYEh40xZY/7tJD/hT3f+WC2kwOeKK4EBShHz+8nlSJRMd+mKjDeNw+ygC7odx/h+hMJzRyv+LnKEb9yDwvaVSiI0/0aHeZ39SeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610669; c=relaxed/simple;
	bh=By2mMJs1nWlHlHFZhBj2tC2hwKrxxDZb2XghSsdgZPY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hNc3TvXrorrq8NSFqG/+NEcvG+o1jStz+/QFn6jy3DLKbpp+bmAQF0/K68I9PzJk6Ac4B3xCzWDJCydvTd+z8HLlTY8FaKsPQK5SNyMNXqGJ8j3kio9b3uacSjxFglF/E0iXQzsWXuqWjAZ/zIbjV4nE9CY/+ap7yKuec5uJcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y1BEUCgn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y1BEUCgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781610667; x=1813146667;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=By2mMJs1nWlHlHFZhBj2tC2hwKrxxDZb2XghSsdgZPY=;
  b=y1BEUCgn2x/EQ32UaqYzCPWQJT9/uziEpEt/SKHFVnCpfCunI6nKoJgd
   R7zKI9Q3lBOofIrU/k9hCz6mSfXQiTQqdt8lahjOBAv+7YtcoGq7meEEC
   iptaMLDRtf4nUZb30YzQ+tdgwjeDY73lKj4UCJA/NflHJysG819H0+Kv7
   rNg8KGPqaGIBFlrh8PKxwrt0HOf9c56n7SVxHMwbHMwO5JS9M2bBk4jCg
   G+yO+SjsiZs1AT2Xa6LJ/t53RTu8IFr/Pj2tDVUFhGoUk+7pHs/qgHU3y
   7lJcJRHQaz2INECAQwy8ik6yjlFHo8uQHyjMo2gjVX7Pt3e1YgMAu0YSB
   A==;
X-CSE-ConnectionGUID: pZAM2NeiRlqwY3FTrCdTsA==
X-CSE-MsgGUID: ZSxBjVVpTJ+tgee6w34KzA==
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="226388478"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:51:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 04:51:01 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Jun 2026 04:50:57 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH 00/10] media: microchip-isc: AWB, stream-stop and
 endpoint-ref fixes
Date: Tue, 16 Jun 2026 17:20:55 +0530
Message-ID: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKA4MWoC/yWMQQqAMAwEvyI5G2hLFfEr4qHGqEFRaUCE4t8te
 pjDMOwmUI7CCm2RIPIlKseexZYF0BL2mVHG7OCMq01tKxzCtgqKEp6RJ7kxw4qXRWrIe+c8hWA
 h7//+fXf987w0jwISawAAAA==
X-Change-ID: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

This series has a few fixes for the Microchip ISC/XISC driver, found
while testing and from the feedback on the combined series [1].

Fixes only, sent ahead of the enhancements so they can reach stable.
The SBGGR10, WB masking and PM leak fixes are unchanged from [1] (the
SBGGR10 and PM leak ones keep their Reviewed-by).

All but the comment fix carry a Fixes tag and Cc: stable.

[1] https://lore.kernel.org/r/20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
Balakrishnan Sambath (10):
      media: microchip-isc: fix awb_mutex and lock lifecycle
      media: microchip-isc: take a reference on the parsed endpoints
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: disable histogram and flush AWB work on stop
      media: microchip-isc: clean up histogram on the start_streaming error path
      media: microchip-isc: do not touch WB registers when not streaming
      media: microchip-isc: fix pfe_cfg0_bps comment
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: fix SBGGR10 Bayer pattern
      media: microchip-isc: fix WB offset and gain register field masking

 .../media/platform/microchip/microchip-isc-base.c  | 72 +++++++++++++++-------
 drivers/media/platform/microchip/microchip-isc.h   |  7 ++-
 .../platform/microchip/microchip-sama5d2-isc.c     | 22 ++++---
 .../platform/microchip/microchip-sama7g5-isc.c     | 22 ++++---
 4 files changed, 85 insertions(+), 38 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>

