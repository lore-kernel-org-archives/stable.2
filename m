Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961126738C
	for <stable@vger.kernel.org>; Sat, 30 May 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166288; cv=none; b=hMORP6/hrlGe6YPVpsagf7d+vEuYbQ1fQbA45KnpM1HJMFCfJK9CCVOispUEp855uXVwPh8RIN8Rkm/e8Ui6nRZWdGeoExi+R0nf74VkJYKlH9WqqIIJNAHDCfLz+6/LOT+nqcwSa6au/jKoU6DcGA1eZ0wc7s3JwF/PIrk5h7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166288; c=relaxed/simple;
	bh=T4N0sBAg6OvCjb2pgLo2/mx0ExzDNFlAqYzZFdtR9+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SxJc9h1ywtiJU+vO2Q0DMExzMy/IlCmEYIrXSWIOGx2TwQTbSY4c60dOAimG4SWO8+S4HZoG8A7RlKigJIltpnt14/dwp3I0jO3mv207hzQ5Yh1z59VXFvNpRQiNxeXPme/FC6ToGYyt9ANMLe4fTTwj1X9hVrYOolxhQ98Eb1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TM3fkiHy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TM3fkiHy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9JbDhtonn5q5rNu0vzNVx69cnGfGhDTfpZJpjnWnyZo=; b=TM3fkiHyv83epjq0c3vSbI6fqd
	yRzc7gbHz+i5QMdUEcncvS9ffDIbyofcNQrF1pIndwbyz8NNloM7sJUyVAIBtvtTOVlqmUXIcBJ4t
	1h5NCCu8JRwVlQNjfD1lk9tB4B18WNmrR5cTMcu/3T9rqFGtaQwF1dtoNqnt9OZgqCTRehC1DElwS
	ljE9e3e37+xqteqXUW3nvjPCR5kK2fz1+gFu2hZ9e07+w0jb948s6qFTjbKt6k6BQVuR+ZqUsGI7E
	1oQ8sU417FngGyU79aikDaOEqmiw646HZePGvOB3SPe3BbXqsXgy3Dj7spY2fvlQ/kodlPIizFSN7
	EpNfjBlA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTOZP-00ALNh-Ep; Sat, 30 May 2026 20:38:03 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/4] drm/v3d: Fix RPi 4 system hangs from stale cache and
 MMU state
Date: Sat, 30 May 2026 15:37:41 -0300
Message-Id: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQ5AMBAFf0X2bJMqFfyKOKCv7AXZJiLEv2scJ
 5mZhyJUEKnLHlKcEmXfEhR5RvM6bgtYfGKyxtbG2YbP0nOQi/WQioMCNyI30whXtN5UMyilhyI
 5/7Yf3vcDIzHD0mYAAAA=
X-Change-ID: 20260528-v3d-fix-rpi4-freezes-8bae519d04ce
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=T4N0sBAg6OvCjb2pgLo2/mx0ExzDNFlAqYzZFdtR9+M=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFnSeh1/ImPY9O9mRZem8Uj0Lrh0wHDTj87QyGcGtm+fe
 rgsXLK0k9GYhYGRi0FWTJHlx5PYWkaxcnbNZeUXYQaxMoFMYeDiFICJzGDjYJive6Hf7nLl5p67
 tT3HXRYtjk6qZZ3/84D1hi+sejvFbi7653RtYo6g3SYvmR9Nu00/1s9RE5hVd6YzLkq8nMHk0Jp
 PP9hKmjJ76qsWKKhMZzD48SKoyMzTl6eRLU1kmqYQk88GzVWTf2z54Xmjxfskv3PLk3hVs0cWmc
 Wl/t6Lkhz++P9p6E03M9bqrV/E9Wz2teOfq6Yf8JNSLZ5Ve7MrPvjwlY/2iQ/36t8q/P82m1kqu
 3gWxyrtyNr7//M0O03ZvzazRJquX3y+rf11o/rhzelLCmqLOD5U3567rz3BJdf8C1fRk7oE+w+X
 E9hCD288PeXzkpT2qPIzU4zvN7e8uWdleHCn6tr3le+5AA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

Some users have reported hard system hangs on the Raspberry Pi 4 (V3D 4.2)
under GPU load [1][2][3]. Investigation had traced these to V3D caches and
MMU being left in an inconsistent state across PM transitions. This series
addresses three distinct issues in the cache and MMU maintenance:

  1. PATCH 1: Addresses an issue on pre-V3D 7.1 hardware, in which
     starting a clean while an L2T flush is still pending can clobber bits
     in L2TCACTL and leave the caches inconsistent. This issue existed
     before the runtime PM series.

  2. PATCH 2: Fixes the MMU TLB/cache flush in v3d_mmu_set_page_table()
     being silently skipped during runtime resume. Directly addresses
     the system hangs reported by the users.

  3. PATCH 3: Cleans the V3D caches on runtime suspend, so all dirty lines
     are written back to memory before the power domain is shut down.
     Directly addresses the error `v3d fec00000.v3d: MMU error from
     client L2T (7) at 0xff877600, pte invalid` reported during the
     hangs.

Together these restore correct cache/MMU coherency around runtime PM,
addressing the reported hangs. Moreover, with this fixes, it was possible
to reduce the autosuspend delay, which was increased as the shorter delays
used to cause more frequent runtime suspend/resume cycles, which exposed
the cache and MMU coherency bugs as random GPU hangs. With those fixed,
we can reduce the autosuspend delay to a more reasonable value.

[1] https://github.com/raspberrypi/linux/issues/7381
[2] https://github.com/raspberrypi/linux/issues/7396
[3] https://github.com/raspberrypi/linux/issues/7397

Best regards,
- Maíra

---
Maíra Canal (4):
      drm/v3d: Wait for pending L2T flush before cleaning caches
      drm/v3d: Flush MMU TLB and cache during runtime resume
      drm/v3d: Clean caches before runtime suspend
      drm/v3d: Reduce PM runtime autosuspend delay

 drivers/gpu/drm/v3d/v3d_drv.c   |  2 +-
 drivers/gpu/drm/v3d/v3d_gem.c   |  8 ++++++++
 drivers/gpu/drm/v3d/v3d_mmu.c   | 31 ++++++++++++++++++++++---------
 drivers/gpu/drm/v3d/v3d_power.c |  2 ++
 4 files changed, 33 insertions(+), 10 deletions(-)
---
base-commit: 61de054a772a1feda6364931ab1baf9038abf1c8
change-id: 20260528-v3d-fix-rpi4-freezes-8bae519d04ce

