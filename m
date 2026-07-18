Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BC3D5C2A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395735; cv=none; b=R6B94PEtiB7DchiofaODg4EF/DNY6bB7rhQ0+9125HsSRxQ+sP0mcnI94AJRzwHnlJ5dh36aBsQoq7By4knfBCmgzQlpkATJP/AAKQWzH8MG30wYCICAD2EPCHbqQPMAV5cw8uudVGt1CZSTdOIb3WvjC6Q9bE0J/QvULiOD6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395735; c=relaxed/simple;
	bh=1rwGdz8PKZ1XZrYFow+mStRGqRVzsXFDieqxYjFu5aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPG8b7FmxEo/qfv/hBRvwartMMFjx9aYRRpMBdxqbgsnC9xthHz0si0OTxNRKovsKADYPWfnxjiIcIwDIbG7qG+jmUuATu7B8RC4YX5TA5S4fCrTfwONwnI9U1qHN/bcdz8XpGW6AwNKtu+D5KpmW2BrM2RLqFMlz2MCWjVhaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fc31nMsq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fc31nMsq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=D8rPfF3L2oL20Q+bI432aFP601nWw3tdbQ84UGoUzTA=; b=fc31nMsqGfmlra9TfRAmpuUka6
	99b00GiUnl2FecbTgNt5Fhnp7kvKSXIhLSqq32pDnjEwzlZ5kCtG2jrdXtnBmit5cV4SAkhJAxT/O
	H2wTVX/aVsLL/ZnEU49m+8s/lvLXIWHTRCefjdii8mE4curECFcnkEpMg7XyhAxTBNa5/QQPMiSw+
	a4lzdjvKVEtloatsYI/Nvkend8cnQntar1q+aXGCAgNpPxRHeNRULKeD1Tyb3eK5dupROkZIz+ozj
	Qz2L4lDJcEd/lFZNcT8qlS9Mpdn2uG9GI6YVRDgu9cEoNvMCW5KAiE3qlQqf9aOo/BTmY3KX13w0z
	Vjkx7RPQ==;
Received: from [189.7.87.67] (helo=[192.168.0.16])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wl8qE-00HVLn-Kz; Sat, 18 Jul 2026 19:28:46 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 18 Jul 2026 14:28:34 -0300
Subject: [PATCH 1/3] drm/vc4: Supply the overflow slot size in BPOS, not
 the whole bin BO size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-vc4-bin-oom-fixes-v1-1-8cba09558c33@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=3E48Juc6BuLCYGLrT0FnSVeNA64WwSkG1HTRvLBuN/Y=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW7fHEdWEOUwCar+LzZqEXUFzerbHem2PlWh/S
 fpQ/9cMCjeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCalu3xwAKCRA/8w6Kdoj6
 qoRNB/90hkYTp6wub54nbSFSFDzYK7rzhAM/ekgPVof84c36Q4Sk0tPjElZYF7mIp2Q1erEvbIh
 Qwk5Iqa0/cN8EVSaVXQjC8lri8a6IeQ7GyCjbwizjRcwMzISJ25kaiTtBL7nZytHf+3hv7lkQvO
 Dj4ouYhI0jWH6NQESA/BwQlvnb6zyn9mXgFPoOXtNnAVw8QJKHaHmSxIsoFlnEgHujKWM/CT42s
 sJOzTJuQgbrXZr5Mg5ss3fo1TkpQO0WMZqUqPBROh3Yub4kR9mcC78thtgzi5GDoJGhNjCmjl2u
 HUd4LKhbWE7YLcN3xcP9i7io5V+lNBiehqR6lfyX52SW6H/T
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>

vc4_overflow_mem_work() points BPOA at a 512KB slot inside the 16MB
binner BO, but writes the size of the whole BO to BPOS. On every binner
out-of-memory event the PTB is therefore authorized to write tile lists
across all the other slots (which may hold the tile state, tile alloc and
overflow memory of in-flight jobs) and, for any slot but the first, past
the end of the binner BO into unrelated CMA memory.

Since CMA pages are recycled into page cache and user allocations, this
is arbitrary memory corruption by GPU DMA. In practice it shows up as GPU
hangs with corrupted control list pointers, userspace heap corruption, a
GPU that stays permanently wedged after the first hang, and occasional
full system crashes, whenever a job overflows the initial binner slot.

The bug dates back to the conversion from a dedicated overflow BO (where
writing the full BO size was correct) to the slotted binner BO.

Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 8e5141bb5075..7877d493d80e 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -104,7 +104,7 @@ vc4_overflow_mem_work(struct work_struct *work)
 	vc4->bin_alloc_overflow = BIT(bin_bo_slot);
 
 	V3D_WRITE(V3D_BPOA, bo->base.dma_addr + bin_bo_slot * vc4->bin_alloc_size);
-	V3D_WRITE(V3D_BPOS, bo->base.base.size);
+	V3D_WRITE(V3D_BPOS, vc4->bin_alloc_size);
 	V3D_WRITE(V3D_INTCTL, V3D_INT_OUTOMEM);
 	V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);

-- 
2.55.0

