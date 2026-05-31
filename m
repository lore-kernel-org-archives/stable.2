Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829AA25333F
	for <stable@vger.kernel.org>; Sun, 31 May 2026 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780258768; cv=none; b=VNpVyVY0Bmeia5HGrn7cWYILsP/y1q0+C9sfoaJN4Cf0xb/femFJi4HxzCBb+wtIpBEGMtXM07njKPYwFt4bTGRNbqThR9icVog9S6kRusZEzYmPr4j1nroYwHm6KDGjOZU3OAzhDJoEPjkJ2PwQZ0esLHQkHLz+JN8bmgS2PGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780258768; c=relaxed/simple;
	bh=9dXrm7pQRO9xLM4M+O8SD4kdnQ+Wj0M4604wOGM8wug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1BltQ7gNO2ZMZJ5Qr3MBSgSFYfLFfPLDSmGDPXhQfXC5u1kq7b1GCO2N+JxFjYNr5stp5PJsOW3KM8W3fCn8RgiL0Je/cNs8iH64R8gMYAmxP3yO0jhCdSF8NeaAplEsPag8OiEDyawJgglV6b1ZYs+YkaURjzJpSGL7BGgIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IgxWhxqR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IgxWhxqR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cgLu62+w1OMg0zxozb4iDUz7avTk6NK4BJ7f4xO3MmY=; b=IgxWhxqRtp+me1/0mDBh5K7W84
	uXcfRzagCdBnnBlDnkgn7bkS5b6RuxXcOkIyE/GDZE17jTnFKpYIlfjhmP5ETPhDZ/TouuexQv2zb
	8X9anM1larEBmuEM2iej7dMqJ0IJdG9OMG2+5mh8qwpqRfX5tIyxkjRa6fOP3DH5p4UMkXMh2V/Ok
	F/roX94llINbYIt3+8xxHjwepkRornvI6mP/46Q/z6TIbFI7KMctWNBxCNdPAlwTfv6Hj9q1uXqHm
	M0A2v13vHAmy5F7EZXgeITKuLj0+iU1wfc75qOEM0Jn2yWL57igdubIJp/5Nf3G3Oqv1vXiVWsaC/
	EMq8TEkg==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTmcu-00Agcp-SJ; Sun, 31 May 2026 22:19:17 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 31 May 2026 17:18:55 -0300
Subject: [PATCH v2 1/4] drm/v3d: Fix global performance monitor reference
 counting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260531-v3d-perfmon-lifetime-v2-1-60ed4485a203@igalia.com>
References: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
In-Reply-To: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=9dXrm7pQRO9xLM4M+O8SD4kdnQ+Wj0M4604wOGM8wug=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHJe99zvk1ZtOjuQ+oxcjeV+/SQWQULPiWHcp1
 5afe6Xsp1OJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahyXvQAKCRA/8w6Kdoj6
 qtC3CADH8FLiJ4HMn3yQbQCZOCFXi40h8RGnRpgucnOodnbnvslH3rTaTcjXI9Xhyken8Cn36zP
 siMRDr+EonDgIg1rd8k72SdI0FTeS8NPie3DBe3p3XZ/v/GjDWhqheXa/wty6dVLVNwIwrLAy5j
 y6y2mkzI1aFGswGqNUS3uxQdamLaXcugRxeEgNsCR5H+SrX6rRGHtA232vBVGUjVPU82vZW9Pni
 8vYb4NyzqeDQTeA/Wba8GAQJQBx/UeBdbuj+iBrbeBKIQXTLiYai+nrcBEl5Kgj2DgZGYq2CRJ+
 3iaepRCKKF0qiblO3WcSLieQTWTbcGCINID5YUXUCvSONMeX
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

In the SET_GLOBAL ioctl, v3d_perfmon_find() bumps the reference count on
the perfmon it returns, but v3d_perfmon_set_global_ioctl() and
v3d_perfmon_delete() fail to release that reference on several paths:

  1. v3d_perfmon_set_global_ioctl() leaks the reference on its error
     paths.

  2. CLEAR_GLOBAL leaks both the find reference and the reference
     previously stashed in v3d->global_perfmon by the SET_GLOBAL ioctl
     that configured it.

  3. Destroying a perfmon that is the current global perfmon leaks the
     reference stashed by the SET_GLOBAL ioctl.

Release each of these references explicitly.

Cc: stable@vger.kernel.org
Fixes: c6eabbab359c ("drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 02451fc09dbb..48ae748247be 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -319,8 +319,11 @@ static void v3d_perfmon_delete(struct v3d_file_priv *v3d_priv,
 	if (perfmon == v3d->active_perfmon)
 		v3d_perfmon_stop(v3d, perfmon, false);
 
-	/* If the global perfmon is being destroyed, set it to NULL */
-	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
+	/* If the global perfmon is being destroyed, clean it and release
+	 * the reference stashed in v3d_perfmon_set_global_ioctl().
+	 */
+	if (cmpxchg(&v3d->global_perfmon, perfmon, NULL) == perfmon)
+		v3d_perfmon_put(perfmon);
 
 	v3d_perfmon_put(perfmon);
 }
@@ -471,16 +474,27 @@ int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
 
 	/* If the request is to clear the global performance monitor */
 	if (req->flags & DRM_V3D_PERFMON_CLEAR_GLOBAL) {
-		if (!v3d->global_perfmon)
+		struct v3d_perfmon *old;
+
+		/* DRM_V3D_PERFMON_CLEAR_GLOBAL doesn't check if
+		 * v3d->global_perfmon == perfmon. Therefore, there
+		 * is no need to keep perfmon's reference.
+		 */
+		v3d_perfmon_put(perfmon);
+
+		old = xchg(&v3d->global_perfmon, NULL);
+		if (!old)
 			return -EINVAL;
 
-		xchg(&v3d->global_perfmon, NULL);
+		v3d_perfmon_put(old);
 
 		return 0;
 	}
 
-	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon))
+	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon)) {
+		v3d_perfmon_put(perfmon);
 		return -EBUSY;
+	}
 
 	return 0;
 }

-- 
2.54.0

