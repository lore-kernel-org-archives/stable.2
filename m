Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0530C35C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104524; cv=none; b=GR8ThgKmCl0EV6lIVskgi8ajevagau1sRxCvMKV0HXajVZYRUdaDxVHMiQXhBBw9zu0SCm75CmFbY7J6gpyu/LGEHV7C+Nw4i6FkHZRv+F6ZyRfQb7vbRXOJ5xZGZy2H2E9g06MoGilNKRWKAFtlzPhA2p6C6hAQNKkf5R5eSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104524; c=relaxed/simple;
	bh=kbGvYAQiwsRmvw1lZVnWX5RWOEFmCmCgzoYshk3C1uA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p68YpUHk6Fi1ISu/ZffDm14ny8x2dtEHaAY/9+sjolP8/V1xrNc7NjQl82IIWv+d4h62SpJ6pJO4WWfzd2a/HaeGqILZ5Gzf8onNGm4qOUJMMIFLPWTK9RVHFXFhEIs6dn9Ce3i6MOP2gXV/Rhup5gBKdKGrGqobyNDR2+LgeTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KvKj5mlx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KvKj5mlx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=BR6TKvLH7A8s4iHWtwlLhAHtHdnYMKw9owb0RPK4cRw=; b=KvKj5mlxmLGXuBRl3smII4XnSh
	MTo/8/cPgmaGZtJr0HL7kC6Au40IRFdoW+kl3l9RSgJZVTkWNvHHR8DWJT6dC6044MS52LP2KvzcJ
	ja2ZJ/olS87WmBdkuaZyP7hncHw7AX39LF5EJtFQIBVBImq+xPX0nZpGt3CTwOc/g2FDHY0ctL4I2
	uCmTN1NCrhCCWVCqJNkti/7j7lIKFIvG5qVWfJQVgmNKk/No+wr+ZJ2UThlArxXOq6V4PNBymrgol
	ZbWsKAYPDiqJ+y8mkfhgbt46CeS/EvVIL6Lpg9ziNggbgQygaAzQSsxZuDItmmZi7fT/jf1nug7Vd
	JfaVEz0g==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wo7E7-005jKV-Ao; Mon, 27 Jul 2026 00:21:43 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/2] drm/vc4: Fix binner overflow-memory corruption and
 GPU hangs
Date: Sun, 26 Jul 2026 19:21:36 -0300
Message-Id: <20260726-vc4-bin-oom-fixes-v2-0-7157e634affe@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZgyCIIr72FYlHGASYSa1jQa0
 rtbOYDL93/e/xsE8SoBLsUGXqIGdWsGOhTAs10nQb1nBjLUmHPZYuQTDrqicwuO+paA1PFIzEJ
 1Q5C9p5e9yNqtzzxreDn/2S9i+Uv/rcUSDbY8WNPVdctVddXJPtQe2S3Qp5S+mIuqsLMAAAA=
X-Change-ID: 20260718-vc4-bin-oom-fixes-29cf2cce2562
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=kbGvYAQiwsRmvw1lZVnWX5RWOEFmCmCgzoYshk3C1uA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqZoh0ICVkDmrTWR55eHSCAOfkzPBOssbP0o1ym
 NOIESf2TA6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamaIdAAKCRA/8w6Kdoj6
 qtwXCAChhvIzfDzbn8btN3gVZeUZg4VB1uj9wvgqqJFu6M6KMp9qbwrVysVzoYlRqbtKM40pI7N
 t1WLq5i+6N1GPY93e+jlZM0kgjBoKzVhjuM5gvV0n5QSAyQscwMDjugxUes/TfQTvN9NRLNz1/P
 j4LWLKsDGDlVRaqKkGRBRi0tUOPCQIqhRpqiECX9Ueime1B8kuOYhUVsSLPGmQ1udx2RJiAp/Xi
 b9Ioh20gH81NUPrlM2ueAM7K/xzVtzSYn8Pte0sivS6AVx8zpqArBiWeaz15PsPdysQHRUGRP0s
 f98dvvfXf/CDdFUUdjzmbTjOoi3C11S4lKaCI/fPse5Ot9Bm
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

