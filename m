Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6D41D13F
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805961; cv=none; b=BLkG+TtfOlUuGZYN5Ozug0s5tSe7zpeIFBoSo6nwpnmffR9UtllVNmdd5vi6kSMZbD4692UbG6jyc7DNYjMQVKwwf22Kqqn85JQyRopHEeiFUv9izv1JxspcHiOb7CVmapvXkRhrwnVj4NJp60W8lmfSTr/F1rNiJOi7UpFFok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805961; c=relaxed/simple;
	bh=hzPZ7/kMFfYPJqfR7nQm8nUAVNSLABD3zpPB6iBojYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lXSRU9bYTSqP6lvfmWxmSJ+XFdGt35AweuNOCyzuBDn/sLFhLQM8+pl9jSn80OPmZrG/flH6RZvraqV6T8cet7oMSAxygtlqgmiKcAEsCrGwtXd2fBkan9uuhZoYAosZjfbcburKErWPW/xJ9pw0K3IOrzDFsvlINgb3Mbl5+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzQvtdVT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzQvtdVT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so18638385e9.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786805958; x=1787410758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wx5BkprMSKmCIjYgcc1kdDlxBMJZQro9c/22It8R+Vk=;
        b=LzQvtdVTRlYtSvve8G8NWEJRysFMs6ifrtAQmbGR9i0aK8NhPmbb2h3rwaxkAdo2++
         VW1NH5DtxCr4A3BSFvbsnJiR1FNGNE43La9D8YqF5WLY+oi33J1ASopXJm6nD9kZ/Fbf
         wAOsVKhhHrP/KqjASTER6bhHk2wkcZ7QQvqK9LZDZwFFE+5UEvmLjhcEGgnFUA6cCdEG
         I5wBbsasjwiM15fGgZlapfxoiPh5wI8FUAL7XekR0IEpBgDW0N/Nbrike37AmUilkPhk
         ANw0YbXrP+Aa7feQ5vVSprF2PwjLdejtxo2LbKu+4TpyP6q1BhsdCI6CsPbxdCjWwDn+
         yt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786805958; x=1787410758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wx5BkprMSKmCIjYgcc1kdDlxBMJZQro9c/22It8R+Vk=;
        b=pAxG+WpTiOabv/RGBLVB1JFh6g3abWraV6w3atFIQezTLmVaIDgrz2p3vOD2BS+uhO
         gKtXPZu8Rof7A7I/dcZL9UoNdpvQoN9WJJ8juN5GYzF5Phlx0BLC0FTCbTamwOkk39mX
         L+2tYHJ3JyoQiUn+kFg17rWUMjfDw1By7fgzKr9YkLkvQphAjaTFoEFvm/Ct09kCyMGO
         Hx31PR+k6Kt4SHp5NvlimXjc7YxuKxD87pqbFl7ZN0iqP0HMPamuJsAOTVVK2gm6NV3s
         VyeZk4YKC+rbX5EKPBwMjn81DLmq2bNPNCILj2g6ELEmi2MHKK1xj8inM103abhT7Rx+
         ghMg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1ubZiUYWn7nkPTRZC2++k2h3Qb95SdZNX2bEM2cPyl0g412s/r8gVW1YqBk87NVWRgnGxRbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MhOktHDlIXNf0spCydvw32gxg+LFMcLkjM3IRwcz06YhP3wF
	k48BEGl6sbWmbT+jKudCcEG9Pb3USNpWMFhcvqWL+jAGbRSOCOI9x1jK
X-Gm-Gg: AR+sD10aoH1lGyOD9DoLWWvh/O3AY8mhTMfialD1TCnefVfU61CnSo0nCXN6lVGCCfc
	lEBgM6fr4qsj1PbOcYE5WBjDPIXfWaQX4H1nslqbhsozZdZSV2CX/xAqcuMRrGFDsrYLpC2J4VQ
	t7hxHghpFr5ZQ6okchB3PHDvOf3nVwUs/IuTzrScdimKRVcnPyq1QehDCKhaip2raOLQ4HyBrsu
	yIqrIN4GIkMU/xQtcY3VYolVQ0+3MvP3+u964kekR4b1DbxFIGi68pSpyoVlb1mXOy0wGpr9xEk
	KV1jK56wN814hUaJOgiLVxtXIcovF37IDKPhhVGZA8G1SrO0sBkeGyXD2/gRLiIzds6kQr7c/d5
	qM2KnLAwewMWB3X5fR43yt89vkKN9PHHMe0XSrrETBHHonsGIgFY8gtLguDXV1tqnysEz0DNRWY
	iF7bI2D+L9bSRFFgZDCjgmweGSwcHoIIA33soLdVAPYzZv4qV6Bx1RVNWFvP3nJJTW8h7ZGedDi
	WQuhGScBjcWfNtrF8GX/BZRhZ1NLvFnIkU+yFoGv4IcOxUTWmShmrjXgMiATKfWoT7eJ4HXiubH
	mCfrGTZco6pICUEIF2yhpcfNFQYneXTCgJQE5iqYWW/i0zgo9lIfcAz2i/pLF3N3hWow
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49987938e19mr207043855e9.1.1786805957923;
        Sat, 15 Aug 2026 07:59:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de. [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899b5f86sm119605645e9.5.2026.08.15.07.59.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 07:59:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
Date: Sat, 15 Aug 2026 16:59:14 +0200
Message-Id: <20260815145914.84154-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3d_submit_cpu_ioctl() allocates cpu_job before initializing its embedded
drm_sched_job. If extension parsing fails, no CPU job extension is
supplied, or the BO count is invalid, it jumps to fail before
v3d_job_init().
v3d_job_cleanup() then calls drm_sched_job_cleanup() with a NULL s_fence,
causing a NULL pointer dereference.

An empty DRM_IOCTL_V3D_SUBMIT_CPU (flags == 0) is sufficient to trigger it.

Deallocate the job and clear the pointer on these paths, matching the
existing handling when v3d_job_init() fails.

v3d_job_deallocate() frees only the top-level job. If extension parsing
already allocated query or indirect-CSD state, that state still leaks on
these error paths, turning the former oops into a repeatable leak.
Fixing this safely is more involved and beyond the scope of this fix. This
patch therefore addresses only the crash.

Fixes: aafc1a2bea674 ("drm/v3d: Add a CPU job submission")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on a Raspberry Pi 400: the unpatched kernel oopses on flags=0; with
this patch the ioctl returns -EINVAL without an oops.

 drivers/gpu/drm/v3d/v3d_submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 7682b24f13ec5..304950ba42a38 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1313,6 +1313,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
 		if (ret) {
 			drm_dbg(dev, "Failed to get extensions.\n");
+			v3d_job_deallocate((void *)&cpu_job);
 			goto fail;
 		}
 	}
@@ -1321,12 +1322,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	if (!cpu_job->job_type) {
 		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
 		ret = -EINVAL;
+		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
 	}
 
 	if (args->bo_handle_count != cpu_job_bo_handle_count[cpu_job->job_type]) {
 		drm_dbg(dev, "This CPU job was not submitted with the proper number of BOs.\n");
 		ret = -EINVAL;
+		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
 	}
 
-- 
2.53.0
