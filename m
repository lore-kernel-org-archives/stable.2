Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1047DF99;
	Tue, 21 Jul 2026 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629742; cv=none; b=NoRfAKGFPU66aeFydq20jkowmFaffR5MG7g/d827o/X8TpfvTx14niljwFI/Svyf/tbzOhVmT7yzq9Gbz4BOP5cvG/x9KkF5fXaX1wsgaMT+M1Zu30weW6OOposJ8ylvvXvzVa8d7d3oyTz0WORpNXSe1+8PQTeSOrj2CPBm13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629742; c=relaxed/simple;
	bh=F1+UVwOZEeJF59KEp06xDRMWI4CbcDVCbWUBCs0hIZM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ceX9ycupjYoJ44LvHVMRBBU+mAwM5z0Sf6zDUIYTWrXpzXDl2yqF1iOgIor/13dxv65F41SSgz3Fhbuh1zGSwBqNN36cnwTe8f6nuzPU/gAwS9OWArWfqcJ+vWaV3710LXPOf1Ru5uF0KKqGeiBXJ0grIgHAjr8cRIQLwEKHX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1hClCNfS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1hClCNfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784629741; x=1816165741;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=F1+UVwOZEeJF59KEp06xDRMWI4CbcDVCbWUBCs0hIZM=;
  b=1hClCNfSADCQGB4Gitq7DFJXiyN4+DEjVREkv9LOkbRrWMRZZGZm9LNf
   Z0sXfdf+lTrQuoG/oV91x7KHz6/jPBCn/DXDDMKX1KpNYDtJUPZoGfeqU
   qREx6BQJUyxGGFiujvpgtBAyYpGYreI/b+YK9LpZD67CotI4y0XHKf9A9
   T6xAGehUUoWNit6+GMtySERj7ptPtEof2DAUMEHOl35Jh/AtZLOToSPWS
   DVPMGpSy1CFD6BX7jb48bw4fN3MuNE2bPr71KXHcxykIQpos1pneRDL/M
   gtwoYqdGttRDBFem3F/8m72qXadHJWttvqzVR96pa/fOi8U9jpf6Qmf9L
   Q==;
X-CSE-ConnectionGUID: LWWthe45RSCkMNQK45Vl5g==
X-CSE-MsgGUID: kxCwG9w0TN23nXZUQepujw==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="292316646"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:29:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 21 Jul 2026 03:28:59 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 21 Jul 2026 03:28:56 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH v3 00/10] media: microchip-isc: AWB, stream-stop and
 endpoint-ref fixes
Date: Tue, 21 Jul 2026 15:58:54 +0530
Message-ID: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOdJX2oC/33NwQrCMAwG4FcZPVtZ065TT76HeGhj54JuHa0UZ
 ezd7SaCeBgkhz8hX0YWXSAX2aEYWXCJIvk+B7kpGLamvzpOl5wZlKBLLSpuzf1GnCLyIbiGnjy
 3izwJjjtUCkChMYLl+89+sU/nnFuKDx9ey6sk5ulX1StqrpJbkLquG6yM1ceOMHhsadii79gsJ
 /jRYL+mQdakFVAiylpB869N0/QGJWZssxQBAAA=
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
The SBGGR10 and PM leak fixes are unchanged from [1] and keep their
Reviewed-by.

All but the two pfe_cfg0_bps cleanups carry a Fixes tag and Cc: stable.

[1] https://lore.kernel.org/r/20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
Changes in v3:
- Rewrite the WB offset/gain register writes with FIELD_PREP() (Eugen). No
  functional change; verified on SAMA7G5-EK.
- Collect Eugen's Reviewed-by on the PFE_CFG0 and macro-typo patches.
- Link to v2: https://lore.kernel.org/r/20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com

Changes in v2:
- Squash the stop and start-error histogram/AWB-flush patches into one (Eugen).
- Store pfe_cfg0_bps unshifted, apply with FIELD_PREP() at the write (Eugen).
- Skip the WB register writes during the stop window too (isc->stop check).
- New patch: fix the ISC_PFG_CFG0_BPS macro name typo.
- Add Eugen's Reviewed-by on the IRQ-sync patch.
- Link to v1: https://lore.kernel.org/r/20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com

---
Balakrishnan Sambath (10):
      media: microchip-isc: fix awb_mutex and lock lifecycle
      media: microchip-isc: take a reference on the parsed endpoints
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: disable histogram and flush AWB work on teardown
      media: microchip-isc: do not touch WB registers when not streaming
      media: microchip-isc: store the unshifted PFE_CFG0 BPS value
      media: microchip-isc: fix ISC_PFG_CFG0_BPS macro name typo
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: fix SBGGR10 Bayer pattern
      media: microchip-isc: fix WB offset and gain register field masking

 .../media/platform/microchip/microchip-isc-base.c  | 77 +++++++++++++++-------
 .../media/platform/microchip/microchip-isc-regs.h  | 16 +++--
 drivers/media/platform/microchip/microchip-isc.h   |  5 +-
 .../platform/microchip/microchip-sama5d2-isc.c     | 40 ++++++-----
 .../platform/microchip/microchip-sama7g5-isc.c     | 40 ++++++-----
 5 files changed, 117 insertions(+), 61 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>

