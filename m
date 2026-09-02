Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD05483BF4
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352145; cv=none; b=lqEhbk2c58Ig/U+cCM74MO1XWHJt9OyXVa8Y/LOkQiW+trHvUJ5TNJf6cn9meFlhD27OiwsJA+T1cwZL2U9fZU76IVmjYHJ7UduZRW/G2Hlik5LXPAqkL4Bld9onhOKRQi+msHm1nwlRHRcMhVzZjtatoZFjrBFCxH+LbhijSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352145; c=relaxed/simple;
	bh=Y4UF1kjYtRztU8LqPmvUCwD+sr0gZn8JnAKvIXkPkOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ob8IJ1fSImEDBejabcjNMgxIjwXKiGWrV5gbubLYdw3nPZjB5yctADMitmSmDdRxj3pjKB1cYLvAX1mcaUEdfiYFJ/qq5HOoWAFcUv7tvbTmWXUrUWTuSQTtj+tPJJufqAeJ8HbSgX1wSpyxOTJgYinV7+egt7swUtRbj8VJy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRvL+zn4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRvL+zn4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so1114603a12.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352143; x=1788956943; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/qoMjdLtE5Tb+izhhpMSUX+0Aq5eRvzQV4VKQzJTc+8=;
        b=fRvL+zn4Nlx+qEjtD6pCUgaA2eEtYVsKPJJuYdLyR7PT3FBiV3XWoKL+LGDtX+r5Bf
         nO7hq5VWw2f7o5W6GmBmDmkjjrk8gAFpk+RjoyIVs9zw76UCt/0RKfCwGGOVZ/W2pED4
         No1y+16tVCjVoISt/qWfm+JZfVX42G8RllKNtKQvEBc3biy/ND3LChK3VAgxkACoMWIJ
         XaJoQADXZvSHGNfuqftIph3jkYwoN1BrfvKQgJgGT3u+3RelUzkS03+hwEVcexm9/RUR
         QN12JIh+77A28M6vNf8QTzAF65561vu7CPVC4ibreuruMIi0PZj2FQMJDm7deGA02ytb
         C/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352143; x=1788956943;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/qoMjdLtE5Tb+izhhpMSUX+0Aq5eRvzQV4VKQzJTc+8=;
        b=Vog3S9AMWkGNyW4eKU72/KFHghUSaeiaDCCExkevMAQYgQHbRCKPKiI4Czl5fHYjAs
         GbVphtGyT2nbtqrYD4OaF229TUudbvtglGwqd3P7YfXTGWPfz5rNvUKEYx77LDQ4cOnv
         AJe/mONJUjypy4CJ2/ccRW6NW0p5V/Piq9Z0U9fUuj/f4En9Zjw0EQZ/AVJBlUt5WbY1
         KGdHnuKfulRjp8LayDfxXdlqVIF3lvagXhT3F5kb6JR6i9fcH6bAGZlTLKB0/4yrYs/g
         1m1y9qtHZWHZj7luNGNYMgYKDTCjrEyiSdJHwTQVa10u2/SiXV3LGfbZ0/M5uXtYJhCz
         kzKw==
X-Forwarded-Encrypted: i=1; AHgh+RoLKS3NrOfaTqHQf702dpUO9lsxcshAZooF2H7g036OSqxaD0haLQupJkGKmD2FPy4Q+NX6iaw=@vger.kernel.org
X-Gm-Message-State: AFuF++nQXV8ltrRknot88kuVgGI4hC8DFfyyvFosSnSjGj1Ry6HqK7gd
	ezNsBq+Pekn3hUiV+v5u7WSSCdYO8xyE/vcTf++leZHXfg4Ujhj2YUp3
X-Gm-Gg: AR+sD13XaEQ0UMOUMK2CB+b/bTuYc6mji3ubrP4fDJrc8gBHC7yGH044wgbg9paUT2G
	wIxmVWTs7hQ/HWvDg8mnn3eFDZFpFx6bJPEll95E7kCextTX7smBZ54sa251Tqe/b6RF+WVIRBx
	ub/RlmYdlynHb+k9wJAaMxRK5skilUuWwUpb/Ykdlae5QHgnlaxbXSSGzKG0MN7FmoLFZjHFQZd
	4S+fB3aLM/xcIQM2Sel8Lzkad/01yaVUCUT3GzQK8jKsFrUbi6bOVPmqTsUlOU1K7EYiUN9aPsb
	PbpUdc9rYmYnQacTwCneONi5Bmsz4DOc0O53VKM3CALM8jrWQaAGGxEqCZkAXHyNkUfMsATvb9L
	fhYsOimd1IMw6iTo4yxPhsTKiE1f23+VhRdHOBL0QDHYmAms8Sf/4w2D4+pRdYpRpo0XjO8a5gz
	aVjk8kuCNwVUWbyUHB/8ezzg2MfT6P5Ty9iiu3DWiJZpbEuGxax8S7xRyOkjU=
X-Received: by 2002:a05:6a20:2d22:b0:3d3:aec2:4dcb with SMTP id adf61e73a8af0-3d9b051aa7dmr7668765637.23.1788352143372;
        Wed, 02 Sep 2026 05:29:03 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc34d03b5a8sm944767a12.26.2026.09.02.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:29:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH v2 0/2] drm/gpuvm: reject zero-length VM_BIND ranges at the
 shared gate
Date: Wed, 02 Sep 2026 20:28:41 +0800
Message-Id: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkWmGoC/y2MywqDMBBFf0Vm3YF0WiTtr5Qu8hg1BR9MNBTFf
 zexXZ7DvWeDyBI4wrPaQDiFGMYhA10qcJ0ZWsbgMwMpqtVDEXrpsZ2W1OPKMso5SYSGrnftm5u
 urYZ8noSb8D3Dr/eP42I/7OZSKwtrIqPNAdcV9W8KFg/7fgCxrzjWmgAAAA==
X-Change-ID: 20260902-drm-gpuvm-zerorange-v2-a2148df386b8
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788352136; l=2561;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Y4UF1kjYtRztU8LqPmvUCwD+sr0gZn8JnAKvIXkPkOw=;
 b=kdB6ANHPAWt1uIv+6CXPurZjkjDoqYI5cORAK4jhKYzt60UFnJTGsQy2mZ0iOBS9OnYp9dBuA
 btjcHle4QJ5BziAZXjhT+zrIYN/lB/OO7O/pk0H5sMLn50vge7Jm1YU
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

v1 fixed this in the nouveau driver by rejecting a zero-length range in
nouveau_uvmm_validate_range(). Danilo pointed out that this should be
fixed in GPUVM instead, and he is right: the defect is in the core, so
this v2 moves the fix there.

A zero-length range passes drm_gpuvm_range_valid() (0 is page-aligned and
addr + 0 does not overflow), and the GPUVA interval tree then computes a
node's last key as addr + range - 1, which underflows to addr - 1. The
resulting inverted interval corrupts the augmented rb-tree. Because both
the underflowing arithmetic and the single validation gate live in
drm_gpuvm.c, the core protects no one: nouveau and msm are affected, while
xe and imagination are saved only by their own explicit checks near the
ioctl boundary. Patch 2 adds the rejection to drm_gpuvm_range_valid(),
closing the hole for all callers at once.

Fixing only the core would, however, interact badly with panthor. Its
synchronous VM_BIND path already treats a zero-length op as a no-op
(returns 0), but its asynchronous path does not: a zero-length async
MAP/UNMAP reaches drm_gpuvm_sm_map()/drm_gpuvm_sm_unmap(). Today a
zero-length async map into unmapped space can already insert a malformed
node there, so patch 1 fixes a pre-existing corruption on its own; and
once the core starts rejecting a zero range, panthor_vm_bind_run_job()
would additionally escalate the resulting -EINVAL to
panthor_vm_declare_unusable(), permanently killing the VM. Patch 1
therefore makes panthor's asynchronous path treat a zero-length op as a
no-op, matching its synchronous path, and must be applied before patch 2.

Both patches are Cc: stable.

Changes since v1:
- Move the fix from the nouveau driver into the GPUVM core
  (drm_gpuvm_range_valid()), per Danilo's feedback.
- Add a preparatory panthor patch so the core change does not regress
  panthor's asynchronous VM_BIND path.
- Link to v1: https://lore.kernel.org/all/20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Zhenhao Wan (2):
      drm/panthor: Treat a zero-length VM_BIND op as a no-op
      drm/gpuvm: reject zero-length range in drm_gpuvm_range_valid()

 drivers/gpu/drm/drm_gpuvm.c           | 6 ++++--
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260902-drm-gpuvm-zerorange-v2-a2148df386b8

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

