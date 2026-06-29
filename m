Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A45487BE
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782702839; cv=none; b=EAbrUZ1RxUTMiSAf31tpvFlE/bk/DM8Y+M5GCU8xnjRliC6sgVfRi0dRps6uz8QdGZgF6Xi1T42qrDs4jvVZ9mqBpQmK/nlERrPAigB6kpIB6RzFYSR8chTVJn5XcJFb5l2ZzRm3LkLVquH2llKWxvioTkD0g0C61QODoD9ffu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782702839; c=relaxed/simple;
	bh=cA0miXNy764U+mxajh7wNC0vJ/SclL1zAKmOx2jfnzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5hO0JfamPEn6gzsovqmZZV+jE0l3GkgdVd9RwI3kX4dskMBE82wuo43FytYo6ffjCbwNZO/9QLaapGygi8lrJNhfmkPUptYEL//B5PFmkg8iBP4KPkRuqeVYSswobAD0lq2YmtVw4lF1YxcwVPuwd8dV3kHtrLmnor1CqZyMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNJWt5VI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNJWt5VI"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845e363246aso947371b3a.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782702837; x=1783307637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIf1UjIu4HobsLfku1GIoLJNf/dF/mUSSo+eQGmmVZs=;
        b=GNJWt5VIKwOe+cRCpZeLVoIsl3fmdrJIUxFPB3YTe+zb6EmBuHz2n7gn1J7+bGxKqN
         /QbyIEWleI+NiiGvt9/KdCR5LbrgO8nO1T1Krl6wT0bbB8C5u15rztC1wm0SWVN4Htdt
         u/fjo/KmpCaY5Ge9PL0Zi3fo3hv+Q2mL6aAMQ5sYwVqP4xUopEQFXwNuqsXNtje3Szka
         K8PwhwO1IIMV47fO7T0mUELXIA2asnUM0ywy2XC+CQj4LF+Sbic5Pl6ipaiF+J4j4KHn
         5r2qClTSMyexeUiKxDswr3FoyMBEvYQagkRBB3V21BkElLEwB4r5rmt1Janh0IqisvTD
         4gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782702837; x=1783307637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIf1UjIu4HobsLfku1GIoLJNf/dF/mUSSo+eQGmmVZs=;
        b=LQilgnDt4zrnTDxlMm4P9MMDAacg2yT48qySxjoHUMDBbs46AUhKv8IZ8z0PfVGnCz
         FZds+53weXozOnap7cYiJtnudqd1XEnlkBjXrc4nU6m8mQSqzh0nRG0OFL+Z8kkNhZjl
         9vHeFUU5DWB9yTcH1q9nX6mNkcYpgJPYAckfOnGAd6BlQ7HnnI1mUn272Qi0r+0fETB3
         +IiGdNeglOEKKefT3zn70dQ3Uu+tJjZ++dJ3n83049Cba6AJVFgflmfrJzPMdmnt9pVF
         wSbmgLrM5Wl2xHd8Mkg92fQuGQEBVBy5Ubt4uHi5rGunGD/bZrjzLG3iUc4WX0ixou0Z
         93zg==
X-Forwarded-Encrypted: i=1; AHgh+Rory4exqdEP9JvTR823kIqCd+Eoo6660Zb0jlo7gI3A6Iju5qOOzcRtaCnNlf3ruSYf5wHsywQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyksqmupcsN2+upkyC/2p4QlPGwexT0daCrjt9BRizkAwQf1cwr
	ztGOsqozW3E8a6Bx6j5LhsFrlk4w/YsYcat+H8/PWBJ4vPWXR1UH5NIC
X-Gm-Gg: AfdE7cn+2HPp4+lfJxQJfmwEkHREOJud3zYTWlZVedbZT/YEY62ZijAQeu2uKh9lMep
	JldtnYP7eQZjAdJWjfdn+MCc+/aC5IQ8nOwtK9gsAAi2DFWdb8x/xURKn49YDu5SH1e87RT+yxM
	I7dYqZNfgWlIDEFoVtm2pdC5tn/a8usEVFWH8TDkJNWrXVNMLXMFCtz3zlllas1/oWyPlT/egzP
	jvXS8bbYjgTZxEKUk0oRAckmzOGo1DmUHxIGo9EHiQZiCGSPm6yS06zTy3Ik+vMrcw3IYBX2Jg+
	FLfOJuPda0LybiQynSAido1gm3pZoUew8fIdDjPv5BihdRdVcEUq7WIVGeiGfhNyeUCuoDZ1fyf
	OJxJzzA/unUO7CE4wlLrKk4QpZ1W2Ha1AMwUOdN5pjrVA0rTj57QuzFVtpqkCvKuqPisT5phKwL
	3CATnSZ1y4sUflByCZlrgGJXSzG9Q4
X-Received: by 2002:a05:6a00:94f1:b0:847:88eb:1e00 with SMTP id d2e1a72fcca58-84788eb24femr987190b3a.49.1782702837428;
        Sun, 28 Jun 2026 20:13:57 -0700 (PDT)
Received: from localhost.localdomain ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4121fdbsm10761359b3a.51.2026.06.28.20.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 20:13:57 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
	Philipp Stanner <phasta@kernel.org>,
	Akash Goel <akash.goel@arm.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH] dma-fence: Make dma_fence_dedup_array() robust against 0-count input
Date: Mon, 29 Jun 2026 11:13:46 +0800
Message-Id: <20260629031346.3875683-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_fence_dedup_array() returns 1 when called with num_fences == 0:
the for-loop body never executes, j stays at 0, and the final
`return ++j` yields 1. This contradicts both the kernel-doc ("Return:
Number of unique fences remaining in the array") and the natural
expectation that 0 input gives 0 output.

All in-tree callers currently filter num_fences == 0 before invoking
this helper (__dma_fence_unwrap_merge() bails out via the
`if (count == 0 || count == 1)` fast path; amdgpu_userq_wait_*()
cannot reach the dedup call with a zero local count because the
amdgpu_userq_wait_add_fence() helper guarantees num_fences stays in
[0, wait_info->num_fences], and wait_info->num_fences > 0 is enforced
at the ioctl entry).

However, dma_fence_dedup_array() is EXPORT_SYMBOL_GPL, so any future
caller that forgets to pre-filter the zero case will get a misleading
return value of 1. Depending on how that caller uses the result, it
could dereference an uninitialized fence slot in the array, since the
caller's array may have been allocated but not yet populated.

Make the contract match the documentation by returning 0 early. This
also skips an unnecessary sort() call on an empty array.

Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/dma-buf/dma-fence-unwrap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 53bb40e70b27..364cbf79ad73 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -97,6 +97,9 @@ int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
 {
 	int i, j;
 
+	if (!num_fences)
+		return 0;
+
 	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
 
 	/*
-- 
2.34.1

