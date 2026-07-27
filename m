Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF338656C
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162766; cv=none; b=T3wLE4gqbYmg300UhimdUyK5KNgAS3L9wkOoHEme6TK4gH2a66voWZxVKgXll61DKSip8BfTvJE0V6vu2Nc5H4LfCkKFjXaGTJtjjOscX+RRlZyBiY7YC5uCb//zRrMOBOxuMwWCK6DFO/6Ysnzkst8H3eg/Uc18P/RwaAZKH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162766; c=relaxed/simple;
	bh=YGYthqmSkC8h78b1vWRmPeKQhegvHzR1P6XUSWdp1l8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p1vCfawQtRqN3dZ+/93C8fTvByB3ppecK30Z5Wm13lwP2Fb8doR5oqTBXChr0qTfVAEbwc3qhfEtLo223nPxTueGsRXdKDnNuBIc0o3jFopMJ6t1ljlvTRRV+hPlKE2oVoPpRW/+Opwc22kPdCV78hgS+bRzHaqdKwd/kbatjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qnHlYAYb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qnHlYAYb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=DiE4IxzE17usoM51qOTZlsKT9PGucUwiHg87MbGicCY=; b=qnHlYAYbKvxNdYuWcrBw61i7EE
	z2XK0h0R7hLeJD0cpMOAlnEA2x4sJNm8N8LWFFONmS0QFGDyasPNVdDlQmRPSoWq5A0Fi9+0rvuz7
	foRPtfq5YCeeAVW3zpmwUDh5p4Tmj/NdGbzA114blyLUxoD5SeWHoKoHGBNn7J/mi69wr/7hyn7OU
	ireXud7usQ5QfeFGDMWYhT7jpkBRDVF13sFuOdtXZcsaXnyB6CqFLkr4VpPUYn4ilgKL8JTXwibrW
	n/meKG02sBBworD/ym0dAy9qnAF/LkIUKzByHFAqcuuepzHXXO3YYXcTqd4zKWiHJRrT37YL77Xbp
	36aQ4yiw==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1woMNh-006B5g-8r; Mon, 27 Jul 2026 16:32:37 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH RESEND v2 0/2] drm/vc4: Fix binner overflow-memory
 corruption and GPU hangs
Date: Mon, 27 Jul 2026 11:32:27 -0300
Message-Id: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=YGYthqmSkC8h78b1vWRmPeKQhegvHzR1P6XUSWdp1l8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqZ2wBwXggYGVsbJywWmivlGDi8AwVIwNveKVcx
 5ACTO6puv6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamdsAQAKCRA/8w6Kdoj6
 qleZB/91AUuq06t34wK9WMCx84IuxJ806HeXrZtP/D0aR6X94Fax2X+3FVfNEfyGGG1Ro3rvb9d
 cMI2bl9UMX9oTSVqC66pcx4aSpkEOl/RI5A66DDYk3G6H7sdrbudXXuWb7AO+uEhUomKX1K9wNh
 CIo1sKbvIFjiueQAk2IDQ6YoXsvfOPz+vRg6hEKDBrffREFIsh3+b9GP/9mEs0ddDvorv+GWpjN
 w3eqLNCv39Plb9Hza1fxgRfMx92FPhKA8RxHayDtcHO2G0bcY+CB0CLnKkvzOKui4tULy0NA8A7
 HFMI8hXi3OV6FBUi2Gx0XckgFHfLKkDH1qP94RvHhaV6hlmk
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

This series fixes two long-standing bugs in the VC4 binner's out-of-memory
(overflow) path. The binner writes each tile's binned command list into a
per-job binner BO that is carved into fixed slots, and spills into overflow
memory whenever a tile's list outgrows its initial tile-alloc block. Bugs in
that path have been reported for years as GPU hangs, userspace heap corruption
and occasional full system crashes [1][2].

The two patches address distinct problems and can be reviewed independently,
though they were all found while chasing the same reports.

Patch 1 addresses an issue in vc4_overflow_mem_work(). The function points
BPOA at a 512KB slot inside the 16MB binner BO but writes the size of the
*whole* BO to BPOS, so on every binner OOM event the hardware is authorized
to DMA tile lists across other in-flight jobs' slots and, for any slot but
the first, past the end of the BO into unrelated CMA memory.

Patch 2 zeroes the Tile State Data Array (TSDA) when a job's binning slot
is configured. Binner slots are recycled between jobs without ever being
cleared and, although the kernel sets the "Auto-initialise Tile State Data
Array" flag, the PTB demonstrably still acts on stale tile state left by the
slot's previous user, generating invalid command streams with invalid primitive
streams and branches that hang the GPU.

[1] https://github.com/raspberrypi/linux/issues/3221
[2] https://github.com/raspberrypi/linux/issues/5780

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com

- Drop the GPU-reset overflow-allocator fix and the dynamic initial tile-alloc
  block sizing in favor of new patch.
- [1/2] Add Iago's R-b (Iago Toral)
- [2/2] NEW PATCH: "drm/vc4: Zero the tile state data array before each BIN job"

---
Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size

Maíra Canal (1):
      drm/vc4: Zero the tile state data array before each BIN job

 drivers/gpu/drm/vc4/vc4_irq.c      |  2 +-
 drivers/gpu/drm/vc4/vc4_validate.c | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)
---
base-commit: a3caaa06809248b996254be5b47e10804a3494e2
change-id: 20260718-vc4-bin-oom-fixes-29cf2cce2562
-- 
Maíra Canal <mcanal@igalia.com>

