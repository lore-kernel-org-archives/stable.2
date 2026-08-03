Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342113793B4;
	Mon,  3 Aug 2026 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752449; cv=none; b=mxrYuBMD5dt41fEgDrrhz+bbFygayaHhz0h3NbU8sW2kafT58foML53EVrpDPp4B+VYfLOIy+mPxaZtFK77bznDd7aUxLviq5az2SWcT4CBj9ztZikadZtpoXpRo6zqbOYkuIETy8sjJi5UNoKzXqmjdn486Bxei7EqWFEwA2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752449; c=relaxed/simple;
	bh=KzLvhioSEn02OX6ZxnR1KybNELfQr0PY4KZPXlxz4ww=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=n9jThmvdvnpv2Bw88qpAyMx1/wvEvT+kUEOpuDTUmyPVeZRMYOIUkafJ3jvCPrzWVHa+4u4W22I8YoK5xoO22aHE43P1sfaLOHlrUO14UAcF2nZDDWeZ3B/PYAoaAmFkRPmRRP07XSH3icFi+RG7oV1besKtZJodxGs3NCs5u3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KGWu0LPE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KGWu0LPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785752448; x=1817288448;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=KzLvhioSEn02OX6ZxnR1KybNELfQr0PY4KZPXlxz4ww=;
  b=KGWu0LPE24YWqIFbLoazdwVwx3cr+iN+XCPRx1DdRmKqoIDQIKglKkv3
   LkO14PLLk8/It4YOUqrmzXu6r9zgKmxM9IQuiPlmWlhpahNoBvzrA5YM9
   49M+Wus0gYGiXD0mZuEQc17EtdneUQZYFbuCjoPVhZ8lpRH9s4Z5orB+r
   /MyCnff8R+PmF9YLI2QV9SrwHD5vDokJdEiv6v48VpIGG8gAPcXXhhBo/
   UDNKioZdYCMZ6gETQf0jzZZqZCenoYXIV1akrOUBpFFOm7f68FMpgvBAb
   Iq+ICyhFG4yDJS4o+ktLJpnm8p8DUOxNWE5LMKe2d/6Dd/jl7/6KXjKi8
   Q==;
X-CSE-ConnectionGUID: 6Zzq/Eg0SFWlwt+IHYs12g==
X-CSE-MsgGUID: NGwoY5evQQKUNa6sAcF4VQ==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="71118322"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:20:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 3 Aug 2026 03:20:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Aug 2026 03:20:37 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH v4 00/10] media: microchip-isc: AWB, stream-stop and
 endpoint-ref fixes
Date: Mon, 3 Aug 2026 15:50:35 +0530
Message-ID: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHNrcGoC/33NwQrCMAwG4FcZPVtp065znnwP8dBlrQs6J60MZ
 ezd7SaiiAySw5+QLwOLLpCLbJsNLLieInWXFPQqY9jYy9FxqlNmIMAII3Ne2fOJOEXk1+A83Xl
 qF3kvOW5QawCN1kqW7l/72d4fUm4o3rrwmF/1cpq+VbOgphK8AmWKwmNuK7NrCUOHDV3X2LVsk
 nv40qBc0iBpqpIgEFWhwf/T1EcrQC5pKmneOymMFhbq8lcbx/EJLDmmF2IBAAA=
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

 .../media/platform/microchip/microchip-isc-base.c  | 78 ++++++++++++++--------
 .../media/platform/microchip/microchip-isc-regs.h  | 16 +++--
 drivers/media/platform/microchip/microchip-isc.h   |  5 +-
 .../platform/microchip/microchip-sama5d2-isc.c     | 49 +++++++++-----
 .../platform/microchip/microchip-sama7g5-isc.c     | 49 +++++++++-----
 5 files changed, 130 insertions(+), 67 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>

