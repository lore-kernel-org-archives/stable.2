Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE274534A9
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352152; cv=none; b=Cyjy8n3NWQI1G3vRA8Ylqn9CJ5WoSHsM76XLYMwhFsVPxa8wRYQs/Vaml4yNPsKVPnBWnmgRvKasKUwKS/RLikR1Bg6w8oxRedRu4LJP+ZIIObI2cJsfKRnuOUloRlxQlqzPv5rbEElzv8WTjdyLA9WwW7oP8lMtJjCco11MfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352152; c=relaxed/simple;
	bh=U0Dzb5dFYo2WQuk1534RF6VPlhwKL3gXFahBxN4rUAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCSoontkSSvRUB0zDJSJpbqIZB73qj3HHwIxNxC6+hFLM434lpRms1FJmFMO3tf8u0Io4StNay4z5QJcN6q+B+1EVAAc0auF3EN4zuN2T9smdBuVAJlIqeus8cbrKfNWxyEQfSg9iFp7Pusqu6VbIOpB0B+9qzJPp7ILDFNAY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaibV6cp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaibV6cp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so800640a12.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352149; x=1788956949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LT2CNvhu8gQBvTvgavkp0Ba+ivwSZKXt+qQbPlYvMs=;
        b=QaibV6cpVkc/Fv//oE5+AqVCnsLKknemFuaPOlfHSxlXo3gtq5K3dxKsaHnuKB3Ugf
         ZWjEUsrinhdMW+j7sE1nRM+PhgHKpcImku1NlhHO58IsAWUBR+TrKLwv9L0XNgUvaPqN
         e87bEXyxa8QmS8Sh/wjoU58YFR1U+rhAGzqw6I/5gS+g9ZcU0ydYtyM8/xXlM3eRb8D8
         R4FDNZcAYnBef9wCS+PD/DUUDq/ENcK4gG4432jLAtYU4xeDfGQxKqMxt87kAf+FNF0m
         pKiF/Ba8S/bKEwuQY+u8NTeUrB8hRafRS5LCXbkoYsWXflJJtAb2DnMvXrL/wERLNtKC
         z2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352149; x=1788956949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LT2CNvhu8gQBvTvgavkp0Ba+ivwSZKXt+qQbPlYvMs=;
        b=doIbFXNz7f7msZ/OJ8IIWMHH1OTh5zagPN/yNHQrfRcRo4MxddsA12CN6d6LnzcAs2
         OGV7bX46M45kvtHpClItmGyGJu4tSqzl0Z6vya1sTaeYsd/10erNkML3IZbRnYW7mMM8
         kbOo09aeiK2FaEIJcxYM7v7HtFQtGjTO1ksLR/wum/avTiIPkMrSMqHcAwGRoNQ8nCIP
         jjNgjCcU+Ct+jB0SOpbMmwsdTZM5nOEHJTeJ9rgDa5gmkD5iQ9VQvvWOwfA3wrb8P1Xk
         j+38PYah5AUch708pmzwbKAbToO5BgSBM8fjl0ypUlQGK9LcRASFFtD6uyliGghgAO2J
         hciA==
X-Forwarded-Encrypted: i=1; AHgh+RrC5ubi+QK+FVvDCbPAvsg+BShqz15WrcC1v4Z2cI+gbynolM63oRr7PR7qwq6br4R1Ob5CQHE=@vger.kernel.org
X-Gm-Message-State: AFuF++lKkhkRUO7xics4NbzKftld5M78mAjLtHZV1vKTQDjL/uqYO0cx
	6J4wyHYRo25Y0k90QncPMbScZ+s0F9Ij3eu5o2CMK9ICr/AvwdeD/twp
X-Gm-Gg: AR+sD11oT/E1CA4oMbMoc+rAkym5XFu3vAlHpz3tNWqpPPfVPhDSTQis17yFyPanDkR
	NtYDSTueV0AC8xlm8oOvCF3kKqQTZAhuHIfo277n5Pup4RBXuG9o3sL1aaFVGDs1CJbO0mLn/MZ
	K9hoXzpa0/kuYcwTerg1ole29ssBt/tMPxl32aNL+6oucY8SrFYban0Ww5PjoPWOIB4ywzGZVGF
	WMZjz2xWuXUUYWKMxQVUfKIztG2ERMlw8tUxgLU8MhCawcn0EGvj1UEQegcQqApFjuokhy75bRz
	RALX8odJuYRY3fPVQGcE4pGHyya9CPiqqSupNZKlhK6nH+u6iZPBqSzJmiGJqV7nOny5VpvzC2l
	dq3iOulmWLIKlQcmvv/82mTQHQc7q71y0mDUgS83D6+8hUvzBr+LrUDaUbS01q1sWe39dBn1ih5
	FdIhB0KTKAGX6lqMgqZurtpBJvNzNaw3qTiUK4A9GmVmcWR7+UlaAz2G39p8E=
X-Received: by 2002:a05:6a20:7284:b0:3d2:2afa:d7d with SMTP id adf61e73a8af0-3d9afd1db2fmr6185663637.18.1788352149101;
        Wed, 02 Sep 2026 05:29:09 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc34d03b5a8sm944767a12.26.2026.09.02.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:29:08 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 02 Sep 2026 20:28:42 +0800
Subject: [PATCH v2 1/2] drm/panthor: Treat a zero-length VM_BIND op as a
 no-op
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-drm-gpuvm-zerorange-v2-v2-1-da63269c6ec4@gmail.com>
References: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
In-Reply-To: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788352136; l=2156;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=U0Dzb5dFYo2WQuk1534RF6VPlhwKL3gXFahBxN4rUAo=;
 b=h8iTCkrFYjTCEkw5/NfJU9Dawfua/i6v+p4HcQQK8G93JF8Z82hyY8PAApUtztu2Aa07UMjqa
 rd5H/DsmVsrCwAt6S35BaWA/H4uYZhu7y/j56TXO0hJGG0VDn2fG5tV
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

panthor_vm_bind_exec_sync_op() short-circuits a zero-length operation: it
returns 0 immediately when op->size is 0. The asynchronous VM_BIND path
has no equivalent guard.

An async MAP or UNMAP with size == 0 is not rejected: only alignment is
checked in panthor_vm_bind_prepare_op_ctx() and IS_ALIGNED(0) is true, so
the op is queued and panthor_vm_exec_op() calls drm_gpuvm_sm_map() /
drm_gpuvm_sm_unmap() with a zero range. A zero-length map into unmapped
space then reaches drm_gpuva_insert(), where the GPUVA interval-tree last
key addr + range - 1 underflows to addr - 1 and a malformed node whose end
lies below its start can be inserted, corrupting the augmented interval
tree.

Mirror the synchronous path and treat a zero-length map or unmap as a no-op
in panthor_vm_exec_op(), before any lock is taken or the GPUVA tree is
touched. This also keeps the async path robust if the core drm_gpuvm range
validation is tightened to reject a zero range, which would otherwise make
panthor_vm_bind_run_job() flag the VM unusable on the resulting -EINVAL.

Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index e592a8ebb478..93542f59cb5e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2591,6 +2591,15 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 	if (op_type == DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
 		return 0;
 
+	/*
+	 * A zero-length map or unmap is a no-op. The synchronous bind path
+	 * already short-circuits it in panthor_vm_bind_exec_sync_op(); mirror
+	 * that here so an asynchronous zero-length op does not fail and flag the
+	 * VM as unusable.
+	 */
+	if (!op->va.range)
+		return 0;
+
 	mutex_lock(&vm->op_lock);
 	vm->op_ctx = op;
 

-- 
2.34.1

