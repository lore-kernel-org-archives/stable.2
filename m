Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87626738C
	for <stable@vger.kernel.org>; Sat, 30 May 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166289; cv=none; b=YpEmGh8b3YUYhqTO2OUUScA+yu4wsqkKNWWuGNnXvGSHmkLwHE/JzONzywvOCEHeqPyL8SkMaLX5b/aLxT3J+Q78gvEU8BJkpHrEIFvGZKtzEDOI5VuUctgzOSnkrdiQFARknWSUVKce5R5JmkY21rHHCaleFEgAVW2ISqxK5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166289; c=relaxed/simple;
	bh=NLI0v+RttiQPW0DxzyASoDa+lnqiux+q/8Ll8MbHowU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYrp35SaWoX/boPsMN+mEU1pRCg1pkiDyzXYGoO7+ik2OfLpUCjtfL7684F/elgvh/7EG9byu7gZFZ7wN3n9pZ+lU4kp7zdVvs26MISY95vaL+4dTQ+kER2CxusAW8mzKYiUQItfUBuIb1dnV+Vw0XUVioQwfsEnn/VzDJRllr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MOZ8DLIy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MOZ8DLIy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9x8OYvKFsNwqjP7jvmqNwZP7haudpAOz0SmRmxXx/PI=; b=MOZ8DLIyyZhL7AE8Bw+fKVJJqr
	2JZCBaA13sKcxtPK7UR3FmZj4J9q1c8IGXziiltxkQxsTGWoSJ1etwOdnLghq63nIH+m+aDnfW/5Z
	2LCzSwDPAixRKAZvJ+2AL6V+TXTF49Aqhkbiq6PtdtYTZHEuZ+eSIvgzF1yEPonW149m1HNmcW8ri
	RugnEUMTtDgw20GfeA1Rd2SkHRidUSvhwdsldR/4qGROd8ry09HICBNlqczHxobACMpWmKXoj2tde
	31XK4K+DVrsq4sG6ajD34JXSCD4zBk0bZySs9Pcq/pfnNk7cSu1kkBd8dq+StvDhnUJ/siSw88v7o
	6oRpkQkQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTOZS-00ALNh-38; Sat, 30 May 2026 20:38:06 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 30 May 2026 15:37:42 -0300
Subject: [PATCH 1/4] drm/v3d: Wait for pending L2T flush before cleaning
 caches
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-v3d-fix-rpi4-freezes-v1-1-c2c8307da6ce@igalia.com>
References: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
In-Reply-To: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=NLI0v+RttiQPW0DxzyASoDa+lnqiux+q/8Ll8MbHowU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGy6IKfrBNgvOxipeVBLlQFNlHTOqR93SY0Fo5
 N/c5SJVKo2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahsuiAAKCRA/8w6Kdoj6
 qhoWB/987vqe5RJXjAq5zqDfNNS0pVHfja98VFCWPzo33F8l6S2jjQrULXwpWXLThlEZDmkHWeY
 sWIDAAowcEyiwiHuELbB8sSKy1SAN54H24uuH1J7LBNHglvkogOo/x4dsH6cNPiH9mqQoz9UGTW
 mP0vcaS1GzI9gH9kweK+nJo5pRkeTgDrKlW6zaymPk5FiwDvtSjEpjehZadSDAz712B0OaZnIlF
 x/58jQse6NH2E+JTSX2y607dnlSF3nvyomKw7eaJlx0xPdHcCTo+GPkoUWK8ERfTxKkWSncK6ib
 uGNliD66G4hK6rk5Fj0nCo1O/jq+YcSKj6KW0Xj1w2hWTH1l
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

v3d_clean_caches() starts the cache-clean sequence by writing
V3D_L2TCACTL_TMUWCF to V3D_CTL_L2TCACTL and then polling for that bit to
clear. It does not, however, check for an L2T flush (L2TFLS) that may
still be in flight from a previous operation.

On pre-V3D 7.1 hardware, kicking off the TMU write-combiner flush while an
L2T flush is still pending can clobber bits in L2TCACTL and cause cache
inconsistencies.

Poll for L2TFLS to clear before writing L2TCACTL on V3D < 7.1, ensuring
any pending flush has completed before a new clean is issued.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 1ee3c038d5f6..c43d9af41374 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -206,6 +206,14 @@ v3d_clean_caches(struct v3d_dev *v3d)
 
 	trace_v3d_cache_clean_begin(dev);
 
+	/* GFXH-1897: Ensure pending flushes complete before writing L2TCACTL */
+	if (v3d->ver < V3D_GEN_71) {
+		if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
+			       V3D_L2TCACTL_L2TFLS), 100)) {
+			drm_err(dev, "Timeout waiting for L2T clean\n");
+		}
+	}
+
 	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL, V3D_L2TCACTL_TMUWCF);
 	if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
 		       V3D_L2TCACTL_TMUWCF), 100)) {

-- 
2.54.0

