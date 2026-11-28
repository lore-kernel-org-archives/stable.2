Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847953;
	b=RijAcRVFNtrKOw9VmSHnsx5yfDGhwR8x5uFuuBdBO6AdPJ1jqkB0LLWtfWVUtxZaL1B5
	 mc2bnRoQsKBYqFy9FdzAc27DZCwfa3GHCyNpu4mDpMtKYmTa7TZtu4ODMCsMkafcGsaXa
	 lmgATN81nclJfICai/jpl4FH88E3QgZjS2YHNffSdT97ga3+veLRD4y0Iywgs34SYGeZk
	 HS35lx5/b/RITp5GAL73+K4JnuXQhE9QuHERbs+sEiHvIupRzRw5E1evplTu9KSHP2fqk
	 fBAPkPZHGv4wZJ9VrAdaroBT5Bj3o3whIYcb99O+xcmxdiTFD/FgE7mTesPI3OG/4kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o9eubjqyEqSUf1SnweeCwXHyF/MyfNmZC7QvIQ6aTX4=;
	b=mEYdGhE0tcl0yhiy+spbquAHoIKCurvCPEg8xDIlPLJHTTFE3djA8orbNEpDraL/AXsJ
	 mYH6irxqSpjLAZcESM8VK3AVzIyySOo01yOVcgilH7JUHv7LZ3UrMtcJyVqGjFAPnQg7L
	 9UrrijCQdfKaJv3AWD+DekBCA0zGwVEcpoYjFpn285gs0rsh+YhmZ7LFLfIsU5dUJG5fb
	 lDaqiS9qSELQSTL66pt2v+S36jEmHez2nwo/ahQWq751RP/DT5B/dP7JDB93A01gV7+ET
	 AeedTctT8k3DxjYwmux4gqvMAIepBDUX2EAUGnvxvrWTtYdfLmtFtu1U+h0+MJB/XEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=furiosa.ai;
	spf=none smtp.mailfrom=furiosa.ai;
	dkim=pass header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=DveYEf03;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D5606A323
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 06:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7D5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=DveYEf03
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8d1aec63541so986468b3a.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 22:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1795847952; x=1796452752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9eubjqyEqSUf1SnweeCwXHyF/MyfNmZC7QvIQ6aTX4=;
        b=DveYEf03UdRFqSA72iitCoAvJkzkywIaMvL8lKlJoeuj5W+NJmm+3cE5wK8/XPqH3a
         cVQTIrdCVMJlLrSrGViTqs8hKf7C4reqhDM09Uk6DV/ALAlwYK+SOggutxvwJ33wKt4D
         8eFS/enJc8b7niEZ4Mv+cPHpqxvwYGR/0Jee8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847952; x=1796452752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o9eubjqyEqSUf1SnweeCwXHyF/MyfNmZC7QvIQ6aTX4=;
        b=IB5qiX9r9WxLmMb+wf/0OSV7uNA1ebDxngM9CE8Iji4xgKMV6JkW5wc1Qbc86MhbYN
         kYp0hnq8QQIQQ78LNonizQXKw3MzfdJoLL+GAM8mCe2wjbFF5EpbtZxgh0GBV6zE+/pS
         SWx4pFyZsDVgv1HRYhuVHUULxymPHcNCEYgCMyHpLv8UPjc7YWZ0Leb+sw+UcutKQGci
         +qOk9K5Rpi3jwb+d7zDeSTvaatm/VbIjKQiDSjlLJ18gtSzK4BgbRMP3Vy+NO4UelMdr
         bh+xS1CzK87VowSiylSY4vaInzvAm26kY8t7RnbPsF9bb5D9BRpB4JvGiHrV6ZLvN1Ow
         Vk7w==
X-Forwarded-Encrypted: i=1; AL+hErE6bL4gqi9vv9KgtS12zLCFwgKNpQvoAT6o/PwAwMoyAhB7Wt2Z4tjd1arKI9bo8ycI60e4Jdg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rQ1+qdsyVhCCigHOWxvZ65pd/n8j53WrPlppUdLYgYaZtwZ7d
	ZzuC9NhFc+KmgNs1k0xx7Xygow0ZXw3qAQ0ZY/3Y88P0FZ2H67vJXw0ixh+xEt7/NhL2eqwKTuN
	IRJU96Nk=
X-Gm-Gg: AZFdTZe8i1PRhhMDt5O4/fT3drjAozdBuzAXjHzJdETNpvld2NR3zWyEKoPm+lwilfb
	IvrT6SguxtFlQ4m+i9oMkKLDy6q83S2YwzU+Xu2NRC8FQoWSy442F7FFp9xbuUclWCXGMoq5sbs
	jO/3XbNiCqMJrLFclD+35J/yPYUxqBohCMnQATku02rEzwL5+9SvIenkdade0EvvXr1z4eYoyqi
	ECnizgv8DPk0IksvhDp0GBUQjZSrexVqQD78zq/HcvGuOfQNcn/swOBREeIT5qfCxQkdce9AGDU
	t1BFi6vPQ2JCOMB4K4sX8TIqvDAuoO0TeMoE8frpUJxnOOnTaQOJB6TAa1xjQgtUV5/o/lRaXP9
	C1vGRhf62UofDgigkix3a789eB0gXkYIdHohD0fOkZkJwnv26E6LFEFSsuIfaqYIZBq5iXLmTFq
	CFjJqljsOWcQltMmShcc9CMHMeBAimfWxf55NluOI4/45uGve/5eomvCN38OD2XSUKUej/+6AsO
	3C7FG2V7qxRpgYd8Hnf5a8jMTFnvTaOLNjhp/kVqeetvoK2RYFa1sjHenrqOdMqVYxKz6Rg80uZ
	nbQJxK5YPts/DNOjCk2d8SxvWM+Lay7AoEFf76RH361gqDaGAXAJ5zlR340LdF1NUzbEoHVgAcK
	fzkJZIqN9jLJGz1tCxfP3Sy/6Qc5aftAxsg==
X-Received: by 2002:a05:6a00:3403:b0:8a0:3307:c46c with SMTP id d2e1a72fcca58-8c87cb4678fmr24975744b3a.36.1795847952011;
        Fri, 27 Nov 2026 22:39:12 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:39:11 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Haoming Gao <Naixumogu@whut.edu.cn>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] accel/rocket: Skip CPU cache sync when prep_bo wait fails
Date: Sat, 28 Nov 2026 15:38:43 +0900
Message-ID: <20261128063844.1537615-4-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
References: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_ioctl_prep_bo() calls dma_sync_sgtable_for_cpu() unconditionally,
even when dma_resv_wait_timeout() fails with -ETIMEDOUT, -EBUSY, or
-ERESTARTSYS.

When the wait fails, the NPU may still be performing DMA on the buffer.
Syncing the scatter-gather table for CPU access while the device still
owns the buffer violates DMA ownership rules and can corrupt in-flight
DMA data.

Only sync the buffer for CPU access when the wait succeeds.

Fixes: 525ad89dd904 ("accel/rocket: Add IOCTLs for synchronizing memory accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index e52fc6ea7cf0..dddaf9d2fbc8 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -171,9 +171,11 @@ int rocket_ioctl_prep_bo(struct drm_device *dev, void *data, struct drm_file *fi
 	else if (ret > 0)
 		ret = 0;
 
-	shmem_obj = &to_rocket_bo(gem_obj)->base;
-
-	dma_sync_sgtable_for_cpu(dev->dev, shmem_obj->sgt, DMA_BIDIRECTIONAL);
+	if (!ret) {
+		shmem_obj = &to_rocket_bo(gem_obj)->base;
+		dma_sync_sgtable_for_cpu(dev->dev, shmem_obj->sgt,
+					 DMA_BIDIRECTIONAL);
+	}
 
 	drm_gem_object_put(gem_obj);
 
-- 
2.53.0

