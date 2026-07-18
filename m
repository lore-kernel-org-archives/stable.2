Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877A3D5C2A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395737; cv=none; b=MFYcmnt29zLIDZ2CG4eiN0RDtT6uXDSLGlssoLx+KxDg4WZ9xT//D8cYUZceg5bFwZ1g/wqdCx0AOcaX0YUpCinFLnWGOL6fVuFtLBJ2QBc+3HkWZXhP7LUoDJDx882BZYxnj+dLqe49tUCYFXjTM4AFljC1ivIHX8I0f1d7CuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395737; c=relaxed/simple;
	bh=nN0HeD0tf4I1huaO2UUr4MQOtkUSBCbrJ6JHXcy8QoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dkg6lb54j04O6/jMu2YT4kDskVrbeBXndmhjdkZQHaltYTS2VEYDupj43zuMhfLSV+UyvEoZH4Wu8kHQKDe2weB7kB3LZTFoiJydgQNu/+7BHaI3/8+PH21RwUlrU0OJ/uhZg4b2widM2o2sLj336qnXRiZiCOeeCC2+YN0Cnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KxzjVCTF; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KxzjVCTF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=VRJxSQaIiGoYp1jV5fex/NR9A/X9b/smZEHGm36EyIo=; b=KxzjVCTFDVyZSAaNXK/7NS3LBV
	vJa61e6c7fPdvipvKBeIRpDOr9UJvHqRpU3/aCFTIwuBCfKhjHie/vj1ELGcdTUa4e2HSfhY0uFzR
	J9jcpnrr0Rc/cO865tCM+d2wjbH9BRA0+EZ4o1qJD2ta7jnK1eNZDBWs7QYUeR6+ICuYdqlCY0a1O
	3BzK3UHP3uu8LDSOncl/CQsUO8M/Pq/ujWzH/4yNe/HGsetpB9KPuUI6OkOlr+FcsdrlV33haT0Jx
	rYbWqbRyN5pAuXp3ulyC8uHh3G6Zq1eModLTWOIdPg+wywD3CCnIVeh5Zg0WTTpEF9N324yjmdey7
	q+Zgmlrw==;
Received: from [189.7.87.67] (helo=[192.168.0.16])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wl8qI-00HVLn-Er; Sat, 18 Jul 2026 19:28:50 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 18 Jul 2026 14:28:35 -0300
Subject: [PATCH 2/3] drm/vc4: Reset the binner overflow allocator on GPU
 reset
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-vc4-bin-oom-fixes-v1-2-8cba09558c33@igalia.com>
References: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
In-Reply-To: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Emma Anholt <anholt@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=nN0HeD0tf4I1huaO2UUr4MQOtkUSBCbrJ6JHXcy8QoU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW7fHgCixf2odcsndgt/5GU1CKOqUqMdJwUxLA
 /P7x/pFCxyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCalu3xwAKCRA/8w6Kdoj6
 qlqrCADaJ7Ouzr5hpsop1Z8zx5xdvJ01LBI7p8CMJwIpkTSHvLMo1QYie4mOu1AVDdY1276tVr0
 JQ85D+E9P2gGlTTF9LSIUF6TcvLKFSrCc487qFIz4IWrdgFNQuOb+HnBdHEpvH5srg68o9ye+jI
 rlBQe6j+/HUFHxUbVZINpJxip9f2pVPbOicNPfXVjdpC8HhN5ciP0VdmUUKUkjQD5OULgj1vPiM
 +SdiOaI0YP2ipuT7T+vw5at1MXU3EMKdLqrCPY8gZJCmE0gzQ/KvM1K0yGBBRdSS+sgjQG2JyM/
 s2DK8FDBbjDL9tZUNHpNe/XyT4f9v978yQjpiNW6IUm/9y8Z
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

Although vc4_irq_reset() tears down the in-flight jobs, it never resets
the software binner-overflow allocator or the HW overflow registers
(BPOA/BPOS).

The current overflow slot is tracked in bin_alloc_overflow and is attached
to a job's bin_slots at the *next* out-of-memory event. On reset, the
RENDER job that would have read it is force-completed, so it is never
attached and never freed: a slot leaks on every reset.

BPOA/BPOS are also left pointing at the stale overflow slot, so the
re-queued BIN job would consume that stale pointer before raising a new
OOM interrupt.

Free the pending overflow slot, clear bin_alloc_overflow, and zero
BPOA/BPOS under job_lock, so the allocator and hardware return to a
clean state before submitting new jobs.

Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Cc: stable@vger.kernel.org
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 7877d493d80e..9fac1b39e8b9 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -344,6 +344,18 @@ void vc4_irq_reset(struct drm_device *dev)
 	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
 
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
+
+	/*
+	 * The reset wiped the binner's hardware state, and the job that may
+	 * have been reading overflow memory is torn down just below. Free the
+	 * current overflow slot and clear the overflow registers so the
+	 * re-queued BIN job restarts from a clean OOM state.
+	 */
+	vc4->bin_alloc_used &= ~vc4->bin_alloc_overflow;
+	vc4->bin_alloc_overflow = 0;
+	V3D_WRITE(V3D_BPOA, 0);
+	V3D_WRITE(V3D_BPOS, 0);
+
 	vc4_cancel_bin_job(dev);
 	vc4_irq_finish_render_job(dev);
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);

-- 
2.55.0

