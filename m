Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F43168E6
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974416; cv=none; b=XF2ST1/Y476LYFxO+GEEoxYnOCcXVXg4R1wctWReRrLA4h4+qsCcc/40SZ7LOndov8lnQATLVS4qHpmgRldkdHdBWnNEwPTpXHCbby2nsaV6NYC6pOuUzItoNB7DFHa+TTm1jAw5eAoVJP5NSuIRGxGuPvkvfrUPD2iwwPjfzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974416; c=relaxed/simple;
	bh=vLLYGnxRBnhnDuZQlInlNw7YhEkAAJD7JBKNgNyELE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m47AD61fXvkGabjBXloK6Dq76b3RhDB3E5+AiQNiB27eSp9NrjSvmihOUcDwmLKQjkfgoARyI2jU8Hyoy7TDfjkrlgzY99R+ApqLLR2lMDfVY/xExZ7zlrfdqv0w4bEf2lekGKMv3b1zriZ65m2AJi4Na6lRw2Puxpc1syne2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKlcXMyL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKlcXMyL"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so265190a12.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782974414; x=1783579214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCmxnXldFzmagzY4ubPmQ/onPJKAAsxLFT7eh00Vk4s=;
        b=rKlcXMyL+k1MyGf/zxlgAwWQQXoFpnwEOywA7FrhGQ2nZ4AqPyTUaTUZuNpdff7yrb
         NLxJtMBvxVPq/8w2Fvqo1zzcjIrfxkbag/tZClHSIn87CEkrSvu0TeVrEF9AZMpjdpeP
         zJJji3WSDNyWSfLtrz4eSTF+j0WLFcVXGgpaeijD0M2ltv91OXcDrmg0M7eAUpQa2+Pq
         mU79NShFF6Yu32bDkq0yTAajHCrUrbMKgtrBl0/N8ipM1k3ty8ZKYsD2ASfZh9Z6/XL+
         fPw3YmZm+cWGi+QvrhXePWqKg2hgKomP7LKSg+yBo9X4u/tAWsdTJnyp3GM63Z7ONaej
         zw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782974414; x=1783579214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCmxnXldFzmagzY4ubPmQ/onPJKAAsxLFT7eh00Vk4s=;
        b=QNwj6C6EqEgvWRHDORftGLcYGq4K8zuN4kFEt2vS8+o/Q51CzZCsnL+5e1UxcrTPwx
         KjSr+cLZDgBVG00AVUuDtO8uYoe8ZAE1P8UWudUWsCJHXNXX38VeHhy37IsoSLhuVfV4
         BXW/OozLqN/XYbh9z3+68ZGjWBBLz/V7n0Df/92NxVpAsYrGuAc96b8n2EUabMwOCksk
         7FxxNcWDQFnjh3CqM5IbD2HzNZDWNTOl6mtltlIPi3nOoDBwEuKEGe70gPT0FQjPJriC
         4sGqc2CCFBEJtuOR8y2zx06TQIL0j701DObFmqfN6CbFjGnQS5JpKrxDxFhogUlhrzrS
         CurA==
X-Gm-Message-State: AOJu0Yza/vq57avzvW1gRztkOa0d6ITPw68d/Cx/WHhId/yTClMYQemn
	gqUCzY5xL7ggRRSv0WFHY0U5DYq1gXW+H7OjC7MGPegAh9TIaTQB3pbmU1+Xnw==
X-Gm-Gg: AfdE7ckMPOQrputztUOpTX2x3cYNi+Dbnvh4r452lXD5plF/jDjdqJVTcSfn+nHQy81
	G+7pzGJJewEv1SGWa7Fr1q/tsx1KpUxf7vHJL5laRIfx+jYmgIucY1UjXQ10QZNylisYJTZTnoX
	6evxeSKxt/9EQjq446nDOniOB/LDJUOZAaPLnn1wT6PqNmH5edMoj5ls3gXPtmmOJF8mdGo0Pt9
	KcdIiWlPIvP+v8y0WfItYCilv6edG/qTDR4Lbsy/OqyCWWhbXEfVMwnLmd3RIQpFzX0TCXpt10k
	6K8ayKEBYIRc0WHMWYU9sCT1mgi3dRZvQcCKlBP5ZGSZd5HosN58zEtnXv16PuV/cjnEl6dBzOa
	6zOS9ECVfA+g4CTQvQi1yOdw5IzN67HaUjCXuPs7ewgflToItXEUZ2qxwfxjxoO+4Fdowcd9yYS
	zJSjcxRXXVcg43+mDjen9udT+GHAf33ry8
X-Received: by 2002:a05:6a20:d28b:b0:3a2:d838:bfdb with SMTP id adf61e73a8af0-3bff4235b5bmr4696924637.29.1782974413913;
        Wed, 01 Jul 2026 23:40:13 -0700 (PDT)
Received: from lenovo-thinkbook.. ([1.22.231.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84366sm7728162eec.16.2026.07.01.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:40:13 -0700 (PDT)
From: Jhonraushan <raushan.jhon@gmail.com>
To: raushan.jhon@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: Fix double drm_gem_object_put() in dma-buf mmap error path
Date: Thu,  2 Jul 2026 12:10:02 +0530
Message-ID: <20260702064002.2123237-1-raushan.jhon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdxdna_gem_dmabuf_mmap() takes a reference with drm_gem_object_get()
and, on the vm_insert_pages() failure path, jumps to close_vma which
calls vma->vm_ops->close(). For a shmem GEM object vm_ops is
drm_gem_shmem_vm_ops, whose .close (drm_gem_shmem_vm_close ->
drm_gem_vm_close) already drops that reference. Execution then falls
through to put_obj and drops it a second time.

This underflows the GEM object refcount and frees it prematurely while
the dma-buf still references it, leading to a use-after-free.

Return directly after vm_ops->close() instead of falling through to the
extra drm_gem_object_put(), matching the sibling amdxdna_insert_pages()
error path.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Cc: stable@vger.kernel.org
Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 891112c2cddf..3ac8c345b25b 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -526,7 +526,12 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
 	return 0;
 
 close_vma:
+	/* vm_ops->close() drops the reference taken by drm_gem_object_get()
+	 * above, so return directly instead of falling through to put_obj
+	 * and dropping it a second time.
+	 */
 	vma->vm_ops->close(vma);
+	return ret;
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
-- 
2.43.0

