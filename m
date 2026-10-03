Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993DC30D401
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018017; cv=none; b=VYN0/zq8smd3zjcu3e97ealk8wqC1U6Do0xxg5Droe3VaDK6f2V/t4FyEP/91VEdRykySC6sg831rXsOIrJpxAgacsXyGxLzRbZgvdmDYm35fu1aQyLE9RZC+C26QpDBKfBdn6dG2EzfQydcuEPehPQmMoYkxGzM1w1fGw8jaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018017; c=relaxed/simple;
	bh=Gqln2HSTYBcxm0OiDBkTUMVKuzF33da3ftRsy7DC6Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ikdh+RlirHTVJ9sqYb5vU1uz8T1OFHYkFblgVjEKOy/bT5IId8yppYZgvs5oR6sB+r9MqNBUAzLIx/gCwXNOBwMQXOCUZStNqy3MyNU8pn5dlIgTQcMypA2yueoOlfLs6bfJjJRoQqG5unN6Bs1FkYb6sziUjMc7d0QO/IMDXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdpYDbIF; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdpYDbIF"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf5e516e67so906415ad.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791018016; x=1791622816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XiAtNXBcVho7+bPRrrdtDPhvWeEZ2yz41dniWV/stxY=;
        b=UdpYDbIFzWE5Y6+vit4lVv6iKpPy42exwpik7+jfD8kLUO2iCMkBKQAKqgiWUk8ccj
         34EFlzesKbOsF972tkTME9kh31JwKWvbg7TsDb1q7Drbn4TpD7l/2RMJpXUJPw6IBXIC
         XZh6xO6fgBVG6RJYYMfR6LI/wmMvmBVXKL8GKZDoZiZd16/7cYEF6JaPHtrqd3aTcHz0
         RCxdYAC3M0hCVuMnIYEpVaukyjDqAyKmz9Mbdh6yUnr1MrO0AbnZ4TfQFk2qD4XHru5D
         dVMPHr4Y8We1bFDxNudy6S7Nk8hlERgDi522BepseKxuKcQIvShGjg3O2NXIlzxVe42B
         A5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791018016; x=1791622816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiAtNXBcVho7+bPRrrdtDPhvWeEZ2yz41dniWV/stxY=;
        b=T27Q/HcnHkzjrqOMRCXH8sf3Qa+Xvr6Q6FrlwUNMmjUp0ZWMRAhROlqQviCGQGc74I
         o+HZ4866Otp6gL4tg/FY012FuOgFeUodjPBe0OpTJx8vEswglY2Jt9y7ABlkys6tBjTm
         L8EbSxTk31RTkVZzkPglKCBRL7ua/W06B1uuMOBIf/cfbIpvMz52j6jNZ7lFlfT71nBp
         77HJm2QDusPetRBtHnBQu+fP3wznquCp3jlObnW6WBr1rFKPNk9jM8ivInc6sBK09MLh
         iOFSiUYyVXdlzeJ7qguFiKhWK5pUGb9wraw4AwYwLDr9KGPXPpu9eIRJptrVoiFReJ1h
         m//Q==
X-Forwarded-Encrypted: i=1; AKwUvBzoAw0CfrUAp86l7m+GZuIhVbQclE8ovEoJl8Q7+qRt5Fd1LQArsbqZ4MMTvcT5qKSVm/A7/fQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLih+NtW49MszWnfhCAuJ6imnC8w7lR44bVrYjyjHrscRfEKLiH
	UfWuu5CE6dTjlEeQaqoDNuHGBiRfe+l3IHxU0GuBuJfyEcfdQqGGtoq3Xe+eGm7nxXUxWKoq
X-Gm-Gg: AYBFou24LmrCEILqE2U+Hrlhzos4XSVzz2r8qerGckycAQZVoxI5k/PBu0hE7S47DVe
	xSHOfxo0YXfYS5slEOvOWQUDsir+g0nFYoHp090SQuhOTFFyHKZsJIRu3cP+b26TW2E3OL5/ECu
	EUxjlX8kTaUOgwtxMJQeKwpYP2DIIO6wSOokkiTgpOifitEBerFcM2xxMTzg8eazcq5WIIZisGJ
	xBOzRZswwRxIxNLk34qZdYK8A/t7tTjeEwgxPSc9IqWmjTirt3ib5BDaEf6lizKKU5+TOnCn/R4
	33lPbkjMTlLZNlFbQnKU4BSrManB/EO+Imq7+p4qsRLXIIucAM8GD8+Bl7Y0F9vVXewQR2u19en
	W+VUSCqEkiNkQnKsnABYSlP5XLzIKGSyOS6DZF1BU5dYoHyQXuDlBkALxq94SUEla9glUzoM7Re
	lYaeKzhPaWuepLeI7guk7kuPjwmnS5ZurupnmM2f6S85+4HxnPdvGl7jRlgUsz6rN81g==
X-Received: by 2002:a17:90a:ec8c:b0:3a4:dc2c:be9e with SMTP id 98e67ed59e1d1-3a6ce82e436mr4223235a91.51.1791018015805;
        Sat, 03 Oct 2026 02:00:15 -0700 (PDT)
Received: from localhost ([2602:ffe4:806:2289:21fe:8574:7a8d:1dce])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e48c38bsm2314877a91.9.2026.10.03.02.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:00:15 -0700 (PDT)
From: Evanshenf <archwse@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/loongson: Fix framebuffer selection in async cursor updates
Date: Sat,  3 Oct 2026 09:00:13 +0000
Message-ID: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An asynchronous cursor update swaps the new framebuffer into the live
plane state. However, the driver reads both old_fb and new_fb from the
live state before this swap. When an enabled cursor changes buffers, the
address-update condition is therefore false and the hardware continues
scanning the previous buffer.

Read new_fb from the new plane state before swapping the framebuffer
references. This updates the hardware address when the framebuffer
changes while retaining the existing behavior for cursor movement.

Verified on a Loongson 3A5000 with LS7A2000 using 32x32 and 64x64 legacy
cursor updates. Callback counters and read-only register observations
confirmed the asynchronous path, the stale address before the change,
and the new address afterward. Same-framebuffer movement and cursor
disable/re-enable also passed, with the primary framebuffer and mode
unchanged.

AI assistance was used to investigate the existing report, prepare the
fix and test tools, run the build and hardware comparison, and draft
this message.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/
Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Evanshenf <archwse@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
index bcc0ffa..7b9c65c 100644
--- a/drivers/gpu/drm/loongson/lsdc_plane.c
+++ b/drivers/gpu/drm/loongson/lsdc_plane.c
@@ -230,7 +230,7 @@ static void lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
 
 	new_state = drm_atomic_get_new_plane_state(state, plane);
 
-	new_fb = plane->state->fb;
+	new_fb = new_state->fb;
 
 	plane->state->crtc_x = new_state->crtc_x;
 	plane->state->crtc_y = new_state->crtc_y;

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.43.0

