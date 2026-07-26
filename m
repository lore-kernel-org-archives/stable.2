Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC592BEC52
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104525; cv=none; b=V5Yp53SYSHXTWQRcAwNGuIHztM7rFvqR1TjXV4ajR2EOlFLIJS2qZx+jHSaSVVe0BXf/Cio491sahA4LFHG/uPPD2Sphv4pDCgaLoXJ0xo9z1gIP1fH4ukd4ZhszKatCwgWKC4jPZI8qYLUL4Z9BQeFEJv8XaHFjU11qEi/pTPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104525; c=relaxed/simple;
	bh=dWOhq4vj1voznDDgyaSr7a6vuOXR1PUmuFeTCZA9pQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/U8yc3WzT2AcvnR1Mimenmc4k72ssVFZeui4+GQJL/Y8e0aQl4YQa8yHcfcuGWZZq3rmsnZkxT77TTE7WV9jejIcx/F97M+lqYVB7tfBVmH38GYoFhlbMHyo8VrA2Xbc17t4dVpOt5HASJQ7pYFxmySiy0AadR9pDyR+x0OzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ET7UqVVI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ET7UqVVI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=LV9515Eo124m+s+bMGZhydKnLoqTNcA+ZyjkLF4O3Bg=; b=ET7UqVVIXIk2tMlgRj6bK8vQuA
	Zc+8ACYIH1e8KUfXgQa7MOwUqPflWM88JeIx5Gfgrox5dxgMzUmPv/D1NyM7pe2yW9Rqa7brW8Gvi
	8YuXyPBmjG2QJrUB+tdfGC6ntnXS2Oplo/dip3W4tZgsyOw3AUrsDsXhf7TWSIcwGYl3j7VszXN6L
	5sj0vklvAtZLRo0BP8/8LIXa2gDgNnYtf9vjUIhrRgo2RrFEzrmkfNGiGjJ0Jb5J6jcV+vAASOhFc
	ABGAT0rqcZhlT0QJ6BVhl/LcbKNlUTO7FX45QOpsmC4YVZsBZ1/7uPbRejomLMq5uu2/8+83NNBpM
	OZpUrZ4A==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wo7ED-005jKV-Mk; Mon, 27 Jul 2026 00:21:49 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 26 Jul 2026 19:21:38 -0300
Subject: [PATCH v2 2/2] drm/vc4: Zero the tile state data array before each
 BIN job
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260726-vc4-bin-oom-fixes-v2-2-7157e634affe@igalia.com>
References: <20260726-vc4-bin-oom-fixes-v2-0-7157e634affe@igalia.com>
In-Reply-To: <20260726-vc4-bin-oom-fixes-v2-0-7157e634affe@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=dWOhq4vj1voznDDgyaSr7a6vuOXR1PUmuFeTCZA9pQk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqZoh0BSD8rOyLZTN2BdSrZkehbzIBZ4603mRsP
 i7woixPSgWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamaIdAAKCRA/8w6Kdoj6
 qj+OCACtmSid2K927tzJreuJz/Oeu5O2lBJIXtG/HiYceF1efxm7irsmZpAWrdag/h31eZrM0OC
 AiqSYsDQ6u/01e8Edol+GTnCFAu6IC/NSbbxaAeOaAQd5qJF4CghkMnJNX0dcBivo1kYgkY+Fcm
 4WfOZtqKSQ9hNnudOmCscjE71pnu53/Oib/aPgOYyW2viIlxAa85AGxLlA7cKEqxbwHR5irQwqe
 u1cKRBZwgaNoop1oimrR1i03AcrvtIc83cSnOdbF0qWXWmxXnMUf2j3WNKhzpwVtO9+direPXM/
 mUTYeISuDzHBNh5G7vLBbCSyThiXyJOI+GvKAfkApOAjTyRP
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

The binner BO is a single 16MB buffer split into 512KB slots that are
handed out to jobs at submission time and recycled as jobs complete,
without ever being cleared. Each slot holds the job's Tile State Data
Array (TSDA) at its start, followed by the tile allocation pool.

While the tile allocation pool is only walked by the render thread
through branches the binner generated during the current job, the
TSDA is the PTB's own per-tile bookkeeping and is consumed by the
hardware itself. Although the kernel sets the "Auto-initialise Tile
State Data Array" flag in the tile binning mode configuration, the
PTB demonstrably still acts on stale tile state left by the slot's
previous user: the binner ends up creating invalid command streams
with invalid primitive streams and branches, which can cause GPU hangs
as observed in [1][2].

Zero the TSDA when the job's binning slot is configured. This clears
48 bytes per tile (~24KB for a 1080p frame) in the submission path, and
guarantees the PTB never sees another job's tile state.

The tile count is only checked for being non-zero today, so the 8-bit
fields it comes from can describe a tile state array almost six times
larger than the slot it has to live in. Bound it before the slot is
handed out, since such size decides how much of the slot is left for
the tile alloc pool.

Link: https://github.com/raspberrypi/linux/issues/3221 [1]
Link: https://github.com/raspberrypi/linux/issues/5780 [2]
Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Cc: stable@vger.kernel.org
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_validate.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 7f2fadfde7a8..d2a65c968b1f 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -385,6 +385,23 @@ validate_tile_binning_config(VALIDATE_ARGS)
 		return -EINVAL;
 	}
 
+	/* The tile state data array is 48 bytes per tile, and we put it at
+	 * the start of a BO containing both it and the tile alloc.
+	 */
+	tile_state_size = 48 * tile_count;
+
+	/* Since the tile alloc array will follow us, align. */
+	tile_state_size = roundup(tile_state_size, 4096);
+
+	/* Reject configurations whose tile state would leave no room for
+	 * the tile alloc pool that follows it in the slot.
+	 */
+	if (tile_state_size >= vc4->bin_alloc_size) {
+		DRM_DEBUG("Tile binning config of %dx%d too large\n",
+			  exec->bin_tiles_x, exec->bin_tiles_y);
+		return -EINVAL;
+	}
+
 	bin_slot = vc4_v3d_get_bin_slot(vc4);
 	if (bin_slot < 0) {
 		if (bin_slot != -EINTR && bin_slot != -ERESTARTSYS) {
@@ -400,13 +417,13 @@ validate_tile_binning_config(VALIDATE_ARGS)
 	exec->bin_slots |= BIT(bin_slot);
 	bin_addr = vc4->bin_bo->base.dma_addr + bin_slot * vc4->bin_alloc_size;
 
-	/* The tile state data array is 48 bytes per tile, and we put it at
-	 * the start of a BO containing both it and the tile alloc.
-	 */
-	tile_state_size = 48 * tile_count;
+	exec->tile_alloc_offset = bin_addr + tile_state_size;
 
-	/* Since the tile alloc array will follow us, align. */
-	exec->tile_alloc_offset = bin_addr + roundup(tile_state_size, 4096);
+	/* The TSDA area must be zeroed out before use, otherwise the PTB might
+	 * consume a stale tile state.
+	 */
+	memset(vc4->bin_bo->base.vaddr + bin_slot * vc4->bin_alloc_size, 0,
+	       tile_state_size);
 
 	*(uint8_t *)(validated + 14) =
 		((flags & ~(VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_MASK |

-- 
2.55.0

