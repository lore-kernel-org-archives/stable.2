Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617E472F82
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859255; cv=none; b=AVjviB8FE582RUVlWwcpFVVlXqshSJZyIzQwrgTjs4NlATNRlEgEhK1W/k2ZITapYzFI8Pf9MfPO40+MtFB4KLzyQh58quiyg1WKwwaMvMKG2MOstFPYRm8yZtdQhZC/etFzKoYItv1pKfuvxNBdtN3ZuRMDjLfi4lDfiGOvcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859255; c=relaxed/simple;
	bh=L4zI4rFzbBdq96SX5DdXQZ7hn9ePYp9NpqWY50dUL0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6p7id9ayd0OI8PdzlazW4QTuUT5ofNvtrwTQp4AaF39zPMsRt2TicqXGpZQX4mMqyLTeomCYMvnLn2b+nqLGWfBJ/23DbEy+9PdHmPAE/KPxepc2v2tq53O7SSNpN+7KgTqVtrVZdlP27xetat4NUZz5l49n7EkXBu19gb4K6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyMlvdlq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyMlvdlq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b966dd74so19380995e9.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785859252; x=1786464052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=39LYywLmPcXSkKCIulhHDm7OS4Hd0MM7+1BesXcpx0I=;
        b=MyMlvdlq7EaKRhttWcIPfr4o5JcOSpOkX4IOfVqaL+wg/k3qnDh7rIDdckCs0UaNyS
         LRs/GbrqvotxSoYpYcY9dpnQT7WkG1PF4x8wOZEeGweRfdHMgXQ/vSeIggGAKFhVOR6q
         Tdxnx9aRKB8c6t4pcveQZIyD2fgZWQ2bOLHkPSlXAkNes2Id8+HJN3oOvnRiiXcXwyxX
         bRkrm8XDs2+c7NcikGoZXlYw8wm1pwHGcYS6mVu8NNJjsMYb9oXqLa9Hwp7F1yxnqeVr
         Ni/KdXWUTGRUzU3VmlqCtYeij/u5rgo+MvLqJ+iDqua5O8IKB+W1798+r/wUW+HzSYvW
         e/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785859252; x=1786464052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39LYywLmPcXSkKCIulhHDm7OS4Hd0MM7+1BesXcpx0I=;
        b=o5s67sY0RBRJXmWaGmjBZnXNnL9vkNdU0gC0puaVfGxQTHiNUiCdF96MyKhqLfC//3
         joHrfz9V/Pek7vsbjN9S0A60gE1Tm8WQIIuBMB6ZwUK/32gCl14XK4gYSVRDqYCNjuob
         nzLANQ1C8vVr1wEuUCtrnNUItYoKqBGbJ+Q/VinZNSENbcpaqK4dUcPgLXFNooMxESFb
         1YKZ1T5G0zM46o+0ZJT3SghJi04MaZchjxEoc0p9aAXHgRWdwptgGS9r98l0fulNgciE
         Yiuhj9RjGNFncHEn1S3amutu51U5H0PU5oS5apEP5LrSbVQ0+mrbOe2k4F8ZJ2PMAWZG
         kZkw==
X-Forwarded-Encrypted: i=1; AHgh+RrAy3cT2CMBIxDkWBtwK3leprcDAC6a6u4P/tT5a33o/3FVfrA+9vw80C6CMhanB8YRK4TuqAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFa3Pfx5RTnBpOe4x9dybyW0pC3aCpskjxvY/txPB5X0DhK9l
	c/8enChS+rxaVp2AKCrsldMKcWS4hNEVowYr6vZsJu8ikYG7XsME6L9f
X-Gm-Gg: AR+sD13m+8T7T0dqCEhkb1ASHCvE/xc3wvMyg9bzWYBVK53MDTejZ6SrS2118vJ/xKQ
	hEPUPPXxmrftVamPvEZiQc2qrSE1XnaRtBhC2rcBPiH/Ln9Gjxf35XVIeuWQ/3mlLsPZqHOojme
	8HtOnvQlLzhr6q413CF/RwkqrzMycQiaaXGbQrMVCIL9pnkmBtfTS9NSVfNxdA0paqw8JvZBUHX
	1MBAjOf8n0YXQqPCgRRnpAwMCFEsg1HyIjwqeC3eUvrXuvJXuqMSFyCVyobM8eZn8RP46minOoW
	1apgp8kiJMEfGO16owEGuVD/jmXhVdeCEfh0sT5SMZbugdMADxcBgDlcKKku8vXcyqonaqKfvS0
	2HR2cKD4ewS/w294uaD9ioJHmw0Sc5vFUujBAYX8gOtJOd2pbPSWqrZTw2YMKTwdiKKzNqFi86L
	JwfxGO+5ZMebLbFJjBJqQyvcyRNioIm6nZVOpP6PA/tFVzwcvVTbm/S3J1sPkkSCnlu8Jn9qt7/
	rpi5LoEf6spsfOs3SluaSYLcg==
X-Received: by 2002:a05:600c:1992:b0:498:28b:1045 with SMTP id 5b1f17b1804b1-4980c645611mr301569525e9.3.1785859252122;
        Tue, 04 Aug 2026 09:00:52 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b6d0:3270:8423:f239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807ba6abesm260913495e9.2.2026.08.04.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:00:51 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH] drm/panthor: validate userspace queue count against initialized firmware slot count
Date: Tue,  4 Aug 2026 18:00:47 +0200
Message-ID: <20260804160048.174148-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In panthor_drv.c:panthor_ioctl_group_create(),
the queue count is validated against the hardcoded maximum:

	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
		return -EINVAL;

However, if the firmware reports fewer slots than MAX_CS_PER_CSG,
panthor_fw_init_ifaces() will only initialize that smaller number of
stream interfaces.

If unprivileged userspace requests more queues than the firmware reported
(but no more than MAX_CS_PER_CSG), cs_slot_prog_locked() fetches an
uninitialized stream interface and may crash when dereferencing
cs_iface->input->ringbuf_base.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260803141149.68182-1-osama.abdelkader@gmail.com?part=1
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5832dccfc093..64749750e6ee 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3673,6 +3673,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
 		return -EINVAL;
 
+	if (group_args->queues.count > sched->cs_slot_count)
+		return -EINVAL;
+
 	group = kzalloc_obj(*group);
 	if (!group)
 		return -ENOMEM;
-- 
2.43.0

