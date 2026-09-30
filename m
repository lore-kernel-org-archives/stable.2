Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B73F824D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751571; cv=none; b=YK07afk9EaXv6aJYeLlA1H+m6GS8DpJFLV/pzRfWEH5UG8SAmL3uPqIqPI/GNTy4hAEoHvt/UMA7RIz+BBLmPTZzkh9IaTcK2BdccrD0wrRRjzJGT/9oc+5Za9fi6fECqy4SQCSWHaJDXWA+dHmJob/mUoUxxyVXy0nT9so+i0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751571; c=relaxed/simple;
	bh=6BdjSvBTfW4KpzxkiX9ADLPmoRyL16y/wUOpfb5VEvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KheoPeezfi0qO26WXkJBbZ0ibcOm+eDRSxipi1zni5xGg63IzZ/w6w3dHqOxqTxIkwwQMlauvK9in4JO9iJnEg/5ZS7G6Ol0WESIMDIu9x05b7aZjdzJGYaa5g/qesOCTT0w6MMoSGPEi+JCujrdbnyypeBdK7EwPFmQWEDAnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiX0HdV7; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiX0HdV7"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso829216a12.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751557; x=1791356357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mx0iaoPR7zXZchCwtDWxvwWQjv0it6r14y9G6mnX/DE=;
        b=NiX0HdV7dEnKt6KwlC8zoBxXmpRewPvK1Tp1FKaWfAD3b94iA3gVTb8QpZkToJZ7u0
         O0WCmSgOQvR2x+9m3TP1NPMqZco2paLoEFEBODbgDUGLZ3AE4y5oQjoxHHFuULfnXX7H
         wHyuGIdtMYsEDQNWLjOHoOR7VqP3Hb1qX+tZQbc9G7dv8Y85jc1PUxlrNeYgkXnKpXFO
         BcMdj/PaV4FfcDcI5TQ1P14TY/gCimX7R14j4rXzipCgiv33rZzEnCr9jZWpWes09oKo
         YsgvWC3U3HOYYHxg3U3IUUDgIjzyi6bVTBchcSgcvGTM9L7N/vd5SDzJlO0dV2CslS9h
         zGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751557; x=1791356357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mx0iaoPR7zXZchCwtDWxvwWQjv0it6r14y9G6mnX/DE=;
        b=jo+iEEwrXcJvu80B61ZsL/A6dlw9wwRub2knTycerW9RhnjfTuyqnasqps9Q2w0X4j
         lWzFLtB+83iu2qKo8XwesRvjDjBdyK76zb6e23oCBsTqa18wH5it/pCx9HvZ4YNDzRsn
         OxKo9CZqKWFFDTR1ye1KjVHMIQrGTDFnAyyJ+5OeuuS9J12zh8UACB8EOGFO41zvBG25
         bzcJPZlTIxwMyrNsLq/Vsq52Tg8jJ7zEMEs1YyMPTTFtMEhP01ojuKPC9BBXilfxtAe9
         y4Q2D/7kzNBnjsTGzgt9k4RKdS9EMrrTe8PK1hb/+Ezpc40CbqmyqgTGzaMDAh76mb2+
         wOXw==
X-Forwarded-Encrypted: i=1; AKwUvByNonfjbPWId56hD8FQa+LVObU8AalDr6BrR6OPf5vdvZF/QBPLAVTY3kog8sQilhpysmEIQ6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuQUfGFyDXCmbV2hC1RSop7WCbcmpvSQfIYKHcr3wi+JIDTHB0
	sYt08TKHWOFY1lSKSXyb6t/zYJWE9N0ezTXK6MEhlq7aP8u93IUYKLjd
X-Gm-Gg: AYBFou1/HT4ThDqnrVsPht1OUy8CTEASd+mA/+RosO30BzuhCJUXvwcUAPwBY4exIMI
	arBIP/ESp8lNFvf2IDt8DoZbvNuGgTQ7mWiLwlLguqSxNhcPcAUfTWf3d32jSgOK4c7sVKjeBZt
	2vEC6sAL1UcXmkGqUw+beiTuxnUy4zcwpSWRHN4M2FKOIaDZahT/C3t5Ssm1o0iByPNoeF4XlYH
	TAS0UfpGjr/yua24/w6rkFnKbqWDG9aOSaWu4w+b6Om+1pU2SZ2oeSVes+rUXz1hsWwHYcC8+m8
	w3KTW6924VEeU6kxrGsgny8oVJWhf51cNoRiszs05WkbqMATQV5R4errMExHNZ0WROAsARuGP/d
	EASb+7yFYvidxcLTNF6xGjRrV6xIAxEcr98pNgbDmyrlm/4hGscDZgpeo5x/un4O/t9ZQowepJQ
	O41HdDxg/cZGCUV+JA3aZIvoi1qshJlUcnUaflY6p/iVZJtJfj6c/JaBu/c7PdADLpeDT2bU2br
	LtJ1fYnbfqKX1zlrNBHmuo9SCL7hLy4bXs86pO7HbAyYRNT+UQ/MT+dtBGEnNOY6cAaVnqhXzgb
	yadZw9K7cA==
X-Received: by 2002:a17:90a:dfc8:b0:3a4:b3a4:e7a6 with SMTP id 98e67ed59e1d1-3a4d276b9bamr261177a91.11.1790751556720;
        Tue, 29 Sep 2026 23:59:16 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:59:16 -0700 (PDT)
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
Subject: [PATCH v2 0/5] drm/gud: fix probe validation, shadow_buf UAF, and bulk_len divide-by-zero
Date: Wed, 30 Sep 2026 06:59:09 +0000
Message-ID: <20260930065914.393939-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses multiple memory safety, concurrency, and
validation bugs in drivers/gpu/drm/gud/:

- Patch 1 moves display descriptor validation in gud_probe() to after
  drmm_mode_config_init() and field assignments, preventing unconditional
  probe failure (-EINVAL) on non-DMA USB display devices.
- Patch 2 aligns both x1 and x2 coordinates to block_width in
  gud_flush_damage(), keeping rectangle width aligned for compressed
  block display formats.
- Patch 3 flushes pending background work (flush_work(&gdrm->work)) prior
  to freeing gdrm->shadow_buf on framebuffer resize, eliminating the
  Use-After-Free (UAF) race between queue_damage and gud_flush_work().
- Patch 4 guards lines = gdrm->bulk_len / pitch against zero pitch or
  lines in gud_flush_damage(), preventing divide-by-zero in DIV_ROUND_UP().
- Patch 5 resets damage state on vcalloc() ENOMEM failure in
  gud_fb_queue_damage(), preventing damage height underflow in subsequent
  flushes.

All 5 patches have been dynamically verified in QEMU against Linux 7.3.0-rc3
with KASAN enabled; detailed test methods and outcomes are documented in
each commit body.

Changes in v2:
- Split single monolithic patch into 5 distinct, single-purpose patches
  as requested by maintainers and reviewers.
- Included QEMU test methods, expected vs unfixed behaviors, and KASAN trace
  details in commit bodies.

Hui Peng (5):
  drm/gud: Fix probe failure on non-DMA devices by moving descriptor check
  drm/gud: Align both x1 and x2 to block_width in gud_flush_damage()
  drm/gud: Prevent shadow_buf UAF by flushing work before reallocating
  drm/gud: Fix bulk_len divide-by-zero in gud_flush_damage()
  drm/gud: Reset damage state on vcalloc ENOMEM failure

 drivers/gpu/drm/gud/gud_drv.c  |  6 ++++++
 drivers/gpu/drm/gud/gud_pipe.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.47.3
