Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4B3B776A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560884; cv=none; b=V6TAZYWsiJJC1x1g5xF7a6Ju9vDyJl8qrErAfVW7Q1wgJyNPXpJEjFUOODD8A/pzNYcxrrUPrVm9wDVKvKs6rEgpuCMxOcY8QKXi8fXm+vruweHvlCfjDQnlVOifZ41I9TOP3sHyRr0rnAZ2x7j8cJMjBQFIFbeLw8blYfJhOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560884; c=relaxed/simple;
	bh=DCS6KZLUxkgrDiPxwM2MsNX+j4Hds16585emdMUCp2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opxsJlfx5hkUCkhG+ci2XpaU9zLK7wIAVnSX5d24Iu4ryR3DqRysAUcr9z6BDQZh73UvPAJewhk9KmAkU1eflxQAhNtCU3RV5/BcaxBy5NLZjAosmOEIw/9AgoeCuqD8A++H1P5yDA7T4y0R7sULBNkop4cZqppvTbuL9/u/rrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGsq5hGl; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGsq5hGl"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7f015f87fddso41439487b3.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781560879; x=1782165679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIyvWCdTdGpwmgLj68ZKIBwap2l4YcZzm7SxNeqPKYk=;
        b=YGsq5hGlTNedC+24/Z1e6CgOVh6YD4DLFJWFZmdQ6q3XMPRYJ9zH8DN6XES+Ig2Xem
         sxEVFGzZ76pVbVdxW1rcq6BDlE+vOCOaFL83mw/7q3Ys2xwm6QHc8X1+OE63vQuT+z66
         nvPijqUp+n3SFkCURowKiq6P/vNDReq1obDnTKWr44rD553MXeI/ahnOE9cHU2EKKBeN
         2Y/hxm/uhuYxsOdCIrArZs9gd5EOyDNX6/b25xD1JAuREi2QXsLYhn4Ur1syjzWJYXfq
         d6Bb442CrPQAKzcvtdRexbg/R7G9ippVcb7XqfZZ8Bn8XBdX5SoX8Qh3VC+IdJKpowdC
         qomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560879; x=1782165679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIyvWCdTdGpwmgLj68ZKIBwap2l4YcZzm7SxNeqPKYk=;
        b=rciTpwvOukUyeGU00hOrLbUTCXBloi3OJYKOluyAblXr372T4kViS/VlnEiG5bPgky
         dboMuXhU6MIirRnmt7pkAgVDUALBKUyJVxEfuOhXeyhymD4kSKpbuYdp6fZ9SXhRSBdC
         v7ymySIDJJqzyzrZUmGzYvYhTzkhHMTrGOppaPyrL4h3cAGogRI/N1a5nWnpx0feSE1B
         8ObfKjKP7K4ZBTHrpu3sIl/VLmoRFnN5NQJN5DfxyZ9hvnBtc7oD9H1bZE4nk7D6Ss8z
         T3TV4ZPLVuLPNppCAd1Y7iPkKihtE53NSayh5BReJWCE7kW4bbja5aYEy3mKF/S2LrIk
         UflA==
X-Forwarded-Encrypted: i=1; AFNElJ9YFQQ/4gFs5SQayWns1PlZsrsbjRehTLxh0K+Bf1/Wgb8v5/cgZYTnf+vmDkQFb349XhumRxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpeGU1dQ8GDnY+mcH3B9RsANfoZKbfZ+GFUzvAYu16UYv1YX3
	jPLHktFTNQvNWHl0AWqCUqdBl3YYvoMQn4gRikUhZNRMUcobAU1jiKz6
X-Gm-Gg: Acq92OFq3Gd+RMSpE4h6O9UwTQvCuIDqEWWvicQdOb11pFtrEoIBrebhJ4Pq7CQ6sLl
	+CfpB4lzrQTvwxNWQ0+94G2eN8mjvizHKtyoen+8NG2SvibzF5NuqwW3j7GqIyJJnYD6lyrsJOf
	o+9EWOlIxZDWBBOlCg2jIAL/I6vSQ0MKEnhgqpDn3Eml0IVxqY40P0TC1Bj7mQd5CKpDwoQnjxZ
	rcA6EKKZt9CtdyKh3A4QaGNF+o3NWjVBTVhkM7HRtBY4QOFWBMlcNTe5Smr38hpdQoeJnUW7XpX
	29alscicefsoLFH6j28/6sGQN4Bc1mq428QNGNDFeZaUO737ylnmrIbzo5MQdmsAscjkZSjl7h+
	DR6e+eQ6Q9X5j0KvgdWX6fe5Y83Pm9nLIHxTSjfxqzrOQiBsjdSvmla65tak41l960xcsL9dCMu
	a4HiyasCzbm3SsLXEMpwF4EVCCsTBvzJefNPClJad4mGd+fDnO6wNpO1+ClFPlL1gtxJ+5AC4vl
	2Z2tA==
X-Received: by 2002:a05:690c:4a09:b0:7b6:783f:2122 with SMTP id 00721157ae682-7fce389261bmr12809317b3.9.1781560877980;
        Mon, 15 Jun 2026 15:01:17 -0700 (PDT)
Received: from ljh-System-Product-Name.tail61485f.ts.net ([203.246.85.145])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7fcd2c87028sm6021997b3.27.2026.06.15.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:01:17 -0700 (PDT)
From: JaeHoon Lee <dlwognsdc610@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	JaeHoon Lee <dlwognsdc610@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/v3d: reject an invalid indirect CSD buffer handle
Date: Tue, 16 Jun 2026 07:00:48 +0000
Message-ID: <20260616070048.1590551-1-dlwognsdc610@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3d_get_cpu_indirect_csd_params() does not check the result of
drm_gem_object_lookup().  A bogus indirect CSD handle from userspace
makes it store NULL in info->indirect; when the CPU job runs,
v3d_rewrite_csd_job_wg_counts_from_indirect() dereferences it through
v3d_get_bo_vaddr() and oopses the kernel.  Any unprivileged client can
trigger this.

Reject the NULL handle with -ENOENT, as every other GEM lookup in this
driver does.  v3d_cpu_job_free() drops the reference under a NULL check,
so the error path leaks nothing.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Cc: stable@vger.kernel.org
Signed-off-by: JaeHoon Lee <dlwognsdc610@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed5..05f98379c1a4 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -605,6 +605,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	       sizeof(indirect_csd.wg_uniform_offsets));
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
+	if (!info->indirect)
+		return -ENOENT;
 
 	return 0;
 }
-- 
2.43.0

