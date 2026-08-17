Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C223741;
	Mon, 17 Aug 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949532; cv=none; b=adR3ysF2WUi41EQHsxBjAhsxIx110hBjFbN6bqy0mmxSKiXKAV8Z9c3eDna0VJmhN0wjxbujgipz7jVNOQUQvK3j5Zj/QN5qA2NkyEcgfCPQfmAVcqaOvaw89v/1wYAkJHVDhuu2c8t3ZsgWblQjzaoVY3jfg9vRO6HyvK5IJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949532; c=relaxed/simple;
	bh=iGEsJDmyTN28v3cr2G/5BlxNCEoAoh65smt1HEN+tk0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fO3FwDjYLAn8ve9XS0o+C07tWbvn0uSu5Vz+qIm2mploBffWjDPIzx8x+FCQ9DwYcDmLuzkC0FdCNZFMDjlWXiQhlqt38cSilV5InKTBWtKXD/pV4ngJuRVSCnC8s+7UHzwiodMJrkT0/nf4tX0AUjKz1zmlXT09hhzNeuo7UIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=emrgELxo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="emrgELxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786949531; x=1818485531;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=iGEsJDmyTN28v3cr2G/5BlxNCEoAoh65smt1HEN+tk0=;
  b=emrgELxoqoMtXulEAb/7GGXLoYq86lL/GJxI3PSdXkNe/2C08NOIOfDV
   4JpaJMOjbJ+nWKMsoGbreNHFsrTFvFrbHa+l9tHONwFlbHmT1WfpGF1co
   YgX5dcPpjG9vzcScPMOz2KwJ7F/cCzq6cxiF6wgXQs2OOK4KQJApAmwTI
   nyLYb9Q6lNImfJa6SWmrxpcq3vOfkpMsbymSiy/RQKMgNOGJMs9gkDnk+
   GHV2VL0V52HFs3bF5Xt+XzDUg0GvPUN+FTVCPNoC1Mbkl1qnNw0SovBQ/
   2bTbZQYkPMZlUTChqQCUMZWu3VJ6BDa4OE/zD7dLYwTN9pr/Qrp3I+GQX
   A==;
X-CSE-ConnectionGUID: PIIkSsFXSaWXKvUQPcJvjg==
X-CSE-MsgGUID: kLawX98cTOm3dA18YRONOg==
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="62229690"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:52:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Sun, 16 Aug 2026 23:52:04 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 16 Aug 2026 23:51:59 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH v5 00/10] media: microchip-isc: AWB, stream-stop and
 endpoint-ref fixes
Date: Mon, 17 Aug 2026 12:21:57 +0530
Message-ID: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2vgmoC/33NwQrCMAwG4FeRnq20adepJ99DPGRZ64K6SStDk
 b27nSKKyCA5/An5chfJR/ZJrGd3EX3Pibs2h2I+E9Rgu/eS65wFKHDK6UJWeDyw5ETyHH3gq8z
 tk+y1pCVZC2AJUYt8/9o/7e0u54bTpYu356tej9O36ibUXEpWYFxZBiqwcpsTU+yo4fOCupMY5
 R6+NFhNaZA1U2lQRKa0EP5p5qOVoKc0k7UQvFbOKoR69U+zH22pzJRmR81BUTtEhV7/asMwPAB
 jkkV0sAEAAA==
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
All but the two pfe_cfg0_bps cleanups carry a Fixes tag and Cc: stable.

[1] https://lore.kernel.org/r/20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
Changes in v5:
- Put the endpoint of_node_put() inside the parse loop; take a
  reference on the stored endpoint (Eugen).
- Move the histogram-disable and AWB flush into isc_configure() on the
  isc_update_profile() failure path (Eugen).
- Collect Eugen's Reviewed-by on the awb_mutex, WB-not-streaming and
  WB-masking patches.
- Link to v4: https://lore.kernel.org/r/20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com

Changes in v4:
- Retarget the Fixes: tags to the atmel-isc commits that introduced
  each bug; microchip-isc is a verbatim copy, so the real origin is
  older. Kept the Reviewed-by tags as only the Fixes: SHAs changed.
  Let me know if you disagree.
- Init the ISC mutexes with devm_mutex_init() at probe, and drop the
  dead isc_async_complete_err label (Eugen).
- Drop a stale FIELD_PREP comment.
- Link to v3: https://lore.kernel.org/r/20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com

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

 .../media/platform/microchip/microchip-isc-base.c  | 82 ++++++++++++++--------
 .../media/platform/microchip/microchip-isc-regs.h  | 16 +++--
 drivers/media/platform/microchip/microchip-isc.h   |  5 +-
 .../platform/microchip/microchip-sama5d2-isc.c     | 48 +++++++++----
 .../platform/microchip/microchip-sama7g5-isc.c     | 48 +++++++++----
 5 files changed, 133 insertions(+), 66 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>

