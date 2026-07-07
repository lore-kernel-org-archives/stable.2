Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D03B27FE
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454896; cv=none; b=bvrFfz4RjBqUhUWBvDdvpOyKDBT0RtnTBJrFuj8MOiIBm6eCAIsdj7vitoV1EtyDAHC93qneQJ40i4Nr+iH/LsCoBqIdvpz2jjp1Y9d/GJZdPadj9iensIewX7lProHvvBJkgS8PNXw0+n8HvQ9/TTIkxXqVYg7NC6z+5/NpZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454896; c=relaxed/simple;
	bh=2SkqIqquw9ePe1lAjJmL0H5SvQORPLQolYuNL44/29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IrbkThP11+KftETHu+ZGvghivVy7hGfhYU/xV5yIcq400fKHns6c8ELVoqUwGNjEkAAfaf05MUaxvthfdveATzWL+jruB8EGZL39evaYSfnJSwXr+wRf0lAkQ0BdWqtHwaQ+HTnG3laipL9AZBEVABpkK7R7bp4u+a/JE/PWxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UUSjl7YA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UUSjl7YA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fjrFh7LPxqIVsPzhhkZi9bSCfDkNO5Nv+dwFa29Cj2U=; b=UUSjl7YAL7FMGSJRk/9RK4zl9r
	Ed5Nbrsnu0ROY30yz+9pPFVN6pyaADVEsA7sO9CCW/qLKcnNltzFRSRk+dgM5N6bjCDSmcrhwcGdD
	LTVYa8eTLl0IU80Nxu679uFuxAohNw+HGD4c3pCCWLGt+gVwT60XiGaLIiX8cYOisXV2dexl9EsaR
	HOxOZMbYN+Gu472DeqgUkkjSFz3n0lZQ1g/f7yS8dNuxmCaPvvBuRqwK26QZgSqhLQoCm0Vr0WEJm
	MAlHG4vumCYqyNpqf57pPsL/zltD8xEEhFvt0yQneJzD1JAxBe1oUN2MnYIX1dxD/JdqQf4ro/H0z
	I5NyD1Dg==;
Received: from [189.7.87.67] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1whC5J-00B2R1-Ic; Tue, 07 Jul 2026 22:08:02 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	Iago Toral <itoral@igalia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence
Date: Tue,  7 Jul 2026 17:05:48 -0300
Message-ID: <20260707200738.659002-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3d_clean_caches() and v3d_flush_l2t() both write the single L2TCACTL
register and poll its status bits. The mutex cache_clean_lock exists to
serialize them, but v3d_clean_caches() only took the lock around its final
FLM_CLEAN write.

These functions run concurrently: v3d_flush_l2t() is issued from the
BIN/RENDER/CSD invalidate path while v3d_clean_caches() runs from the
CACHE_CLEAN queue, and each queue's scheduler uses its own ordered
workqueue, so their run_job callbacks execute in parallel.

Because clean locked only its final write, a concurrent flush can write
L2TCACTL during clean's unlocked phase. Both use non read-modify-write
writes to the one register, so whichever lands last wins: clean's TMUWCF
write can land on the flush's in-flight L2TFLS invalidate, triggering the
GFXH-1897 hazard of writing L2TCACTL while a flush is pending.

Hold cache_clean_lock across the entire L2TCACTL access sequence so it
is fully mutually exclusive with v3d_flush_l2t(), which already takes the
lock around its own write.

Cc: stable@vger.kernel.org
Fixes: abf888b03a98 ("drm/v3d: Wait for pending L2T flush before cleaning caches")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index c43d9af41374..e597b6fd47c4 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -204,6 +204,8 @@ v3d_clean_caches(struct v3d_dev *v3d)
 	struct drm_device *dev = &v3d->drm;
 	int core = 0;
 
+	guard(mutex)(&v3d->cache_clean_lock);
+
 	trace_v3d_cache_clean_begin(dev);
 
 	/* GFXH-1897: Ensure pending flushes complete before writing L2TCACTL */
@@ -220,7 +222,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
 		drm_err(dev, "Timeout waiting for TMU write combiner flush\n");
 	}
 
-	mutex_lock(&v3d->cache_clean_lock);
 	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
 		       V3D_L2TCACTL_L2TFLS |
 		       V3D_SET_FIELD(V3D_L2TCACTL_FLM_CLEAN, V3D_L2TCACTL_FLM));
@@ -230,8 +231,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
 		drm_err(dev, "Timeout waiting for L2T clean\n");
 	}
 
-	mutex_unlock(&v3d->cache_clean_lock);
-
 	trace_v3d_cache_clean_end(dev);
 }
 
-- 
2.54.0

