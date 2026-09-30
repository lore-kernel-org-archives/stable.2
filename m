Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F940F8D8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751567; cv=none; b=hgB7Hw6G82aSZb8z3C8sixS77v2EWJeKOYhlTGnrpi1AhBUonqtWFi4FHLlmTxh/i1+YN6CNbAUd9yVVm98TP0cSXEn/0CumNSlJWJcORQIbZdo13Eoly4ERkrnUb6wyy+QlHSPILncgcZHXy8TX+PqtjCFbC33HqLOlSEaOC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751567; c=relaxed/simple;
	bh=zGQ6oA9FdiLwaGDeIJ/lMi9ihRSaaxgnDKhhGJ7zVIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww415UbUooqiLp+d9S0gvlPq/gQuPMJxf+fnMCz9SOeLsGJ3oPKF9EtJ/ycM9lHotDkYmnUHMKJv9LCfQirPhgi5fijWQeVPHaMv0Shgp9cZmE1asSqjudok34gX5BR/bQBT0FPKTca1c3x1XvngFytGW2MTEUdOe5pgTaeyyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MspFUoW5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MspFUoW5"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso28182965ad.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751559; x=1791356359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XY/E2j9XnFuNBK9WaF/nFTrbzu9uvpf+6HkIq2bPSfU=;
        b=MspFUoW5A/RFeFFuPjzSbDxh071aZl0nNu8l/YK8BrNfoiRfq4PgI2kpdrtpgl0mgs
         N6oL9FyuFoX/vBOkDfsBnkbPIVojhGd11E9E652Gr9YLHf8Pfuu5feRBtcaowosZWH1c
         CTaCrCGFpXS1AhKzZDyU195vnms3coN2nl51O56sfI0/COuLHiiz88uLOHB9YhftTNJc
         m7MrfiPAcknPQ6wmtyfOvlqYdGM5UJ2eJmwijHT1cx7Q4B1/9SW/97dZAykcS6Zvhe/7
         Y3tge84NV0u0+tGUwcD8nUZNw8ZieJh2f9x2DichxFWhlpzkj39EcaMlQECL/avpniw/
         2qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751559; x=1791356359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XY/E2j9XnFuNBK9WaF/nFTrbzu9uvpf+6HkIq2bPSfU=;
        b=gqGDSKho1CmS1M42WBHatFN2zrJvrX0M0UPrzMdv15HS7rHB+yO0rSYJ+ZN/5Qi8PM
         xsv+7NERrlyXwTZ91vTK8gtyh+B4NBAqLnqbmoPtg7P2exbsCIJhnD7NnSz50eOjgnH2
         WQv5JC1mrOMZD06JDjT2Wza2waeFHlBZHnR+EN/MkXJV8QdzjNq1kSKrspn09iDtY4Dg
         +OJJqiDWlQBzgo+pgBVrtAEVHHnbsqsw8BfPXh1UKxMD9z/btAqtbMpefDZ31AtvwxRX
         nUte5gGhwDxZrTIj7K0La/p3+WXLAtvR3L3je9vQzb9TePNM5iY3s554+9a8qMUybbiT
         WNAA==
X-Forwarded-Encrypted: i=1; AKwUvBxoEr09UuB2nEHO+iw/ErPCzCWHSiFgj0tiZW+oYcVZNZqbmQTDRl6DwkfyZjNFqMZGK1WOmyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5F5uGJdWtk4shJ2gcaOvzCDZ9Xc8DRNidgbYIFDPyUvYAgg6w
	dQhLIeT4ImTsVfnT/g3oczOKwq+gO99OipqLWHfODwPH052ZSOjAqZkn
X-Gm-Gg: AYBFou0Ac38K23EaEdvHALg+C27W1/bUIO+FrUW3wWX6+16lEO0CRhVPlX0suP/hRjz
	VObdWelb3Xyi2F9q7XynohUTf9494AnWz/7PbPoVQRPXKa59GSgB9NJadd5XMtziL5bGfuqYalx
	sT6iJUPuoi+pKObIJQ+9FbK/RlKzSWmvYhpDGqpBKhVFZEtUu+wlEeVKkrPMEi5sm/2YHI4TgRC
	VyreX/F3mOC2XMhfwgG7xDBkBZc6ONXTagPI/EYbfv0pv44KCdksNfwUrHJtpJJWSs5aNIMwtbL
	/4WsCYVgCXsa6WjFVJmc7kfidFyILfnbidehLb6teYn3ysBXm+hnEt0Aram9U6+5p5FczqtT3XP
	URIqKUoAkcOLSye+u8YTNgRMlGmwp6mwkXfUFx9/CgOH5MOatOR2OY9Wy10/mr9ue69tWroMhMW
	aTjC3vtY2ITzcJhOY2JmM+gzlUXftp6dXLs0M+GBCirDFwE6fuslmWr+eZ+5Wt9CUlFnSLlm/qC
	JdjYD8KnUYuuWJXCEzhd5HGMwQfj06MSsE7ASJGf7v85K2FqF1i26wms7u8zu0ycGO1lSLVOR6w
	fNd1jMEdTQ==
X-Received: by 2002:a17:90b:1e42:b0:39e:6c69:f476 with SMTP id 98e67ed59e1d1-3a4d18c21bfmr485055a91.53.1790751558947;
        Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 3/5] drm/gud: Prevent shadow_buf UAF by flushing work before reallocating
Date: Wed, 30 Sep 2026 06:59:12 +0000
Message-ID: <20260930065914.393939-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gud_fb_queue_damage(), freeing gdrm->shadow_buf on framebuffer
dimension changes while the asynchronous worker gud_flush_work() is
running causes a race condition where gud_flush_work() dereferences the
freed gdrm->shadow_buf during a USB bulk transfer, triggering a slab
Use-After-Free (UAF).

Flush any pending background work (flush_work(&gdrm->work)) prior to
freeing and reallocating gdrm->shadow_buf when framebuffer dimensions
change.

Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled by queuing damage
on a resized framebuffer while background USB flush work (gud_flush_work)
was actively reading shadow_buf: on the unfixed kernel KASAN detected
BUG: KASAN: slab-use-after-free in gud_flush_damage(); whereas with this
fix applied (flushing pending work before vfreeing shadow_buf), 0 KASAN
warnings were generated.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..f9726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -397,6 +407,16 @@ static int gud_fb_queue_damage(struct gud_device *gdrm, struct drm_framebuffer *
 	struct drm_framebuffer *old_fb = NULL;
 	struct iosys_map shadow_map;

+	if (gdrm->shadow_buf && gdrm->fb &&
+	    (fb->pitches[0] != gdrm->fb->pitches[0] || fb->height != gdrm->fb->height)) {
+		flush_work(&gdrm->work);
+		mutex_lock(&gdrm->damage_lock);
+		vfree(gdrm->shadow_buf);
+		gdrm->shadow_buf = NULL;
+		gud_clear_damage(gdrm);
+		mutex_unlock(&gdrm->damage_lock);
+	}
+
 	mutex_lock(&gdrm->damage_lock);

 	if (!gdrm->shadow_buf) {
