Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881493CE4B2
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395734; cv=none; b=uEhQSo7Fo4OvFXbAlnBTzOmGn+HQKtNsL9ijgttb1QDiJy8oP9QDNFGp37Atz6qVyT9YWvD4BSD1O+TMPmdbrDp4WZ2X+FSEpQQ9uN3W1b2X84/Ol2B57DbsWdcDSpG8HKMH3Nczr6uT1xt8KsWap/3j3Bq3B9Hj/0O7Eqvi7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395734; c=relaxed/simple;
	bh=u+SC+3Fk66qdzcJexcuI9WtGJrbJKScKAeG31s7ifQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uCxW94Fm/p9UAC6e4LXt/Bgwzl3GX6OlG89CLKzXjAAmUer8P5DwPdNj9s1uAAk7NZwP4K8269Ag3F1KSFPPErlQPMa+cBEreRZTHil6IVAgxfqHFUq9GVIn0PRCU8UJDeEA60W+zpKIcLqDDHVEd1zxCW15IQckbbZZY+t6LF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=l2exZqcf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="l2exZqcf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=8VphESNReP/Cvyoi04whT2LFISYkgicvKkcvSxPPsHY=; b=l2exZqcfAjdr9KYvLJvmlTVvy/
	jYuTd1qg8RxcO/p8IRBq5wvhm9wU3uzey3q3VgStDROuOQFqBs7OpMGEyRhG1UlEjXDAMYKWAz6UH
	wVczMVV2dnpemXa9PmB+/ErpMegKXVXUUbTpvDEIVf8hiM0YC2g45DuCUAiB9Bd7PXGaJh0uTFtgI
	w3aHW9Nm4+QkaQjMijWRQCdUEVbkgAUbSkf18MfaR4DT5DIRxncqN/mNITFIw3fMiVgxMtMZOVUGK
	lDbRP3sujvnNAdRMb7cYBbjtW+tCakCofh5IEocQ3/YSAuPM4lCa3AFH/61Dfj+YWoAhcJhYnd8/U
	QNKyYtBg==;
Received: from [189.7.87.67] (helo=[192.168.0.16])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wl8qB-00HVLn-5w; Sat, 18 Jul 2026 19:28:43 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/3] drm/vc4: Fix binner overflow-memory corruption and GPU
 hangs
Date: Sat, 18 Jul 2026 14:28:33 -0300
Message-Id: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LSwqAMAwA0atI1gZs8H8VcaExaha20kIRpHe3u
 HwM80IQrxJgLF7wEjWosxmmLIDPxR6CumUDVdRWnekxco2rWnTuwl0fCUgD78Qs1LQE+bu9/CF
 v05zSB5ApHoxjAAAA
X-Change-ID: 20260718-vc4-bin-oom-fixes-29cf2cce2562
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Emma Anholt <anholt@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=u+SC+3Fk66qdzcJexcuI9WtGJrbJKScKAeG31s7ifQM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW7fGC92+hCBmHjyPzdcWa9LNHX53EMI0eouny
 07XrwcqpQSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCalu3xgAKCRA/8w6Kdoj6
 qg3nCADcnnVEg0tx3iDbpNXsrof426dqIEWupNE4/eS3AaNC+p9IMelpZydttPDn+hSluL7iYua
 EaEmOnf80xuEgluq5DGuf655nGiVIheA2Cg/qb3vEie3mwTjp0YnUYiia11UFlFo8rHFWn9w/IZ
 WBSuIYlTE75GMt8Evx/fMXI+kGHCfCFd3n2kqeGB4OSUPoOMKiJid4ipAe6LekHzdA6UPSMBvxf
 Fj89Mfg1jrNAoj+eXroa5V0D+orK5ZqzLhSbGyDZeWMZ/VKrTMtRdQZpXFosohdDNb3VRog+hnR
 GtVXWSHT4t9qcG/RmmyhcCkubP7zkk6e5ismZPi62tw+em/F
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

This series fixes a couple of long-standing bugs in the VC4 binner's
out-of-memory (overflow) path. The binner writes each tile's binned
command list into a per-job binner BO that is carved into fixed slots,
and spills into overflow memory whenever a tile's list outgrows its
initial tile-alloc block. Bugs in that path have been reported for years
as GPU hangs, a GPU that stays permanently wedged after the first hang,
userspace heap corruption and occasional full system crashes [1][2].

The three patches address distinct problems and can be reviewed
independently, though they were all found while chasing the same reports.

Patch 1 address an issue in vc4_overflow_mem_work(). The function points
BPOA at a 512KB slot inside the 16MB binner BO but writes the size of the
*whole* BO to BPOS, so on every binner OOM event the hardware is authorized
to DMA tile lists across other in-flight jobs' slots and, for any slot but
the first, past the end of the BO into unrelated CMA memory.

Patch 2 resets the software overflow allocator and the BPOA/BPOS
registers on GPU reset. Today a reset force-completes the RENDER job that
would have consumed the pending overflow slot, so a slot leaks on every
reset and the hardware is left pointing at stale overflow memory that the
re-queued BIN job would consume before raising a fresh OOM.

Patch 3 dynamically sizes the initial tile-alloc block up to the 256-byte
hardware maximum, picking the largest size that still fits the binner
slot for the job's tile count. This keeps more tiles' lists in their
initial block and off the continuation-block chain, which VC4 does not
walk reliably, and takes the reported EmulationStation workload from
storming resets to zero. As explained in that patch, it is a mitigation
for a hardware limitation rather than a complete fix.

[1] https://github.com/raspberrypi/linux/issues/3221
[2] https://github.com/raspberrypi/linux/issues/5780

Best regards,
- Maíra

---
Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size

Maíra Canal (2):
      drm/vc4: Reset the binner overflow allocator on GPU reset
      drm/vc4: Dynamically size the initial tile-alloc block

 drivers/gpu/drm/vc4/vc4_drv.h       |  5 +++++
 drivers/gpu/drm/vc4/vc4_irq.c       | 14 +++++++++++++-
 drivers/gpu/drm/vc4/vc4_render_cl.c |  3 ++-
 drivers/gpu/drm/vc4/vc4_validate.c  | 29 ++++++++++++++++++++++++++---
 4 files changed, 46 insertions(+), 5 deletions(-)
---
base-commit: 7a4b7122a623e3d57fc15cf843a9d45fbd72c6ab
change-id: 20260718-vc4-bin-oom-fixes-29cf2cce2562

