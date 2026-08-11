Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C541DEC8
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438036; cv=none; b=aeCen2awXspfUOp8vOLOmuPDih0TjCW6XjbG0nCAT3jJ++yVI1bNQAS2xKj484uW4Lr1sTIuY+BSEaZfOiBoLcsl+X/P3cCF9XuVDIbtL/W1A4dl1GxBK0xnFBfvmN+L/CKYfmZLRygCaYWADqdnVIvhLNRXW5LrbrahDlUQU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438036; c=relaxed/simple;
	bh=aTMGC8jjrMAmwoT5PX4XMFYEw8rXZ5oYEJn7jPDkksQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9qVSGq9yVLMVI97MHTxVgkLjEP0I66EZVyOja7LcUqBSEmw1RnEYOcCJ8RIPNerDfyB07L53JyFHNc1ZwCf0mDRwahllnOPP6ZUBdh3mw3prjRg2AOTM1cbhoQPpa5ewZfLmIbKQOg5FsBraXvAZaQbtAP5Z9w+lp5KPeA07zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ48Y5Ze; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ48Y5Ze"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3366533a91.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786438035; x=1787042835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkN28cbnuxaTZnJUJR8D84k2R0Wy2RMXuquI0epiuqE=;
        b=kJ48Y5ZeKLxE/Xg+Uj5krTq+eLkh0rkhwoeAjOZLrBanIQHUVYuPKAZ1ec7Msua+wE
         wA4wqLT69QZN93SyVRfb8lQTB8A9G+Rr06f+jlm0LoL0Nr+NaIqr+5HW06u2rn/ovcqT
         yyhbvouby5A2TYfhOTHvtUXMpE/HYdgBEhwArA9JjM7r/kyJTB9U4keyJ8mcwA8D2AAz
         mfuxGsBEzCCf4iZe5O+2PQ/3PfMAFxRcYgiHnlPUohJUOO572G6JyVYGb+qXsfVyGMmx
         b1keMQHUpKVHh7j+sfNym22evJZcNuyKCBPXaTh4zlM8NnbDcH/hLGweTcwVxUZBLMrg
         EOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438035; x=1787042835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkN28cbnuxaTZnJUJR8D84k2R0Wy2RMXuquI0epiuqE=;
        b=RoDoehsSLtb07xRM9z5w5A8+XHiqDLfLFOYZcr74DtbmrbN9aZEpTbqXEdN9/VHpPl
         SAoxeJ2SEjrHTeBBbvVB1sFhmvIMq3R811b7H7nPoee85IOPrismBECQolMIOodx9qRX
         PFs/m1SebUSZ+YroPmR2MYfbUnQi5kv1XBxAbhAnL7KnLvafc1aU1tb7MWneH04WzS4r
         mO5FMFjOIigkN9ruz3MPZ8fB7PCLuvSPckwrOInwYXW4QLnlvBz5o/anNkOFccjfwla9
         9685p5bkXqOWc6kY0XhrBg1xfZMz9zMl7zjM71vl6wvTxuDg9orgq/OEcbTSX4vVYWAd
         /PbA==
X-Forwarded-Encrypted: i=1; AHgh+RpQRkx5TxICElOMzW60IVCqWvGHbQIjcShmyYkaJ8uGtqDiOHUxcmbrVnMGn8BuXUL5PcnWgVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2jR+e64NR7sSWnI8uyzGxo1wZTyy+Cg8L/bNcG8GJe/P9x2j+
	uo/m2lkP4r3cDYELzh1y8ThAZCqeEI+RXBg6xfubKikx4ZYGlvv+VKK7
X-Gm-Gg: AR+sD13lQ+xhd6zAHCXOkfywROmhNrHQshpxd5TLFhWMAgHfo2mCzkzUOPswjM32paH
	iwcxcAQqJOFZiItYKUC784LtqJvXK8I8dMg/5YWGjZCB/5EfXDikSYNslq56pEXfaaDK01DQWFk
	6d+ctTn3Bd+bXKPE9dm/TJGgThPphq6uBIMCK5Nab3SLhJU26icFe4TR+wy0i6D7ZADyst0vTOq
	ROkjD0zAhRYJu0ZFfrwQd4+0m9hSZ46rYIqq/rj7z/tUByw0INdTHRz5rv7k81rbHXMFwLFYKk2
	tDgO9iRH7goss6dKP6ewNnL4kuFupomC0IKsD91+6SGar1y/ViUb6HojN3ct8o+3EAUsaJi16P9
	SCTbIrpKgDzWY4DV5Q9cIGbY9LtBSWK9X0EvjD+j0XstPvZvrt1IZkfo5/MnJUosS1qediJgvZW
	VHRR4omDr4S8GON0BqpGQ8DK2rLYvCeljyDMSMidgqCfqSS8lzuJSQ697NqwEG1CfFr+Eqsw==
X-Received: by 2002:a17:90b:4c85:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-392ec721e34mr1597056a91.20.1786438034735;
        Tue, 11 Aug 2026 01:47:14 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:47:14 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 16:46:28 +0800
Subject: [PATCH v2 1/3] drm/nouveau/uvmm: fix NULL deref unwinding an
 OP_MAP_SPARSE op
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-1-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=1555;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=aTMGC8jjrMAmwoT5PX4XMFYEw8rXZ5oYEJn7jPDkksQ=;
 b=09+Yjqqdood4dmBPaNI3zbuyE6yGr25iSeGlJ5xSWwhUElspOvJ/vCMx+lzUAZY2pEewE1dB5
 vJ9nHlmaFQyCawnfpg4WkYn3EBEqRGtDwKFngsk5epJfxu5IZAgYp4B
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Each bind_job_op is zeroed by kzalloc_obj() in bind_job_op_from_uop(),
and the OP_MAP_SPARSE case in nouveau_uvmm_bind_job_submit() only creates
a region, so op->ops stays NULL for a successfully processed sparse map.

If a later op in the same job fails, the reverse unwind loop revisits that
op and calls drm_gpuva_ops_free(&uvmm->base, op->ops) unconditionally.
drm_gpuva_ops_free() dereferences its argument right away
(list_for_each_entry_safe on &ops->list), so a NULL op->ops oopses. The
path is reachable by any render-node fd holder, since NOUVEAU_VM_BIND is
DRM_RENDER_ALLOW.

Guard the free with IS_ERR_OR_NULL(), as nouveau_uvmm_bind_job_cleanup()
already does for the identical free.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 36445915aa58..849bf42c124e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1489,7 +1489,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 			break;
 		}
 
-		drm_gpuva_ops_free(&uvmm->base, op->ops);
+		if (!IS_ERR_OR_NULL(op->ops))
+			drm_gpuva_ops_free(&uvmm->base, op->ops);
 		op->ops = NULL;
 		op->reg = NULL;
 	}

-- 
2.34.1

