Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8FF420E8F
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438040; cv=none; b=KCzPerYyEewZJGACE9glwLlivBK1qoIFeqKVFsjstHdvb18DslnJ8pFSSFiQYfQRZfkwoisek3S+EhyIcpGC6+8+jCWtBmthgxs9fl4bPxjpl19UV2MjmJ9tK+LXo83Nv8JiRVsRRvv6BWmZWUv5M1YEZ/ITtOCmbA2YblioYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438040; c=relaxed/simple;
	bh=fKwS8hLuASUBBkfhmQft0t9owMYTP3CSXRQ1mDs9JW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9kzlvohlfEnfvaRI/GINVfsD9d0sbMl24AxSb6TAm68NKqpoRtjo8Q3j4sVENRLJCXtX/BQTP/j1pomNWeB8M81GdF4kzNuk5TyeSbOGrrZjKzjp0fJhP33a8eydec7XhQmZZ65sXIbZwFAOLAOtnlQgJCcNiedPHQcb5qq1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0xluFKs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0xluFKs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2793620a91.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786438038; x=1787042838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ly/Mo1nbCV/oSok4ztJy2PbfdvW3bZVZXW3Etcdsh1I=;
        b=M0xluFKsxP2h9vvHw2eUj7aVjO89T6gdwlX2rX9oEbBye0KrrO5/NMXK7b9a39AQeI
         /vfwqnTNcys2Hl+/kxUY+z83JR+CHnTynee+v9BfEJoh1KOs2deQogo2GaNrQXU5FL1A
         sR30CjIQU1HzNlXXnMIgCHcZWINhvrArab3VWH6kyM9QQ3lcGLLoCtKRgJPSJ08mLXsX
         G6lh4yC2wvapyYo4rMTfvT3nCq8PT2003YhdJCcoSYWK0z3P7PJMfxhcNLx+nF3oTX3A
         fBRHxSH+iu3pNHLXBQiMQkcq2385kV4rit0U6B6V4vIlvG4tnIR/8OCjbJq1KNyxE+YP
         ekFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438038; x=1787042838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ly/Mo1nbCV/oSok4ztJy2PbfdvW3bZVZXW3Etcdsh1I=;
        b=rdUQxJKMjnfBRgA/KHzKcy2DJhzBKMwP+YHVWlypJzZh7lkKO2lZwlXk/BhPBulXfL
         hyATlyVgs+P+2NMR1Zet9BEqBM9zKPB0KyXV7+SIdGH3J4a//xRt2HZE873e2fJ8P/u+
         JiMXczwvw8NZyw2LXJ6TiUS73jbnvfK2TfU0ardEuC45ClVtWaf8l7UmZcBBOwzIA7xd
         FsT4iboWSRWLlprmX99wurxSwv/9Hm/rNW/xqsPrtbEISAvV5dL+J5TgaPnETMraiUVM
         hMpKeYTJnhH283jUWqXERKl8ZAQFWagypM3NlgnUqBiyf2pD4bgy9XK2+BoMewc2wiBs
         6VuA==
X-Forwarded-Encrypted: i=1; AHgh+RqWnkoZtDOMomEC4AsmrP4m2sot1Q2bwffzauGkyHuuZErp49zkENr0NuMHSum52dccovdi/Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwibkmRguMmgayaa8rIdYy3wQK3xDBVBYJAYNmNOLesL3ziAXzg
	TBZKTmBe+4nrQDTXlNyy7gwemx39DBYyNyvNcLFreYr7fiWVCQlokbPy
X-Gm-Gg: AR+sD12zEBfYq5VfWZOsiLYqZVq9QiFSlln+LyN4gh7E32llRsd15v/SUZglHAL465a
	9JoA0S9bzKG45+Qj0j7UxrLFmr9F1yTfPstEvsAq1p6CxJACg1oGlLocb1u8/qQxQjk8eLIAnWb
	irxgFUZIwYJhUEOoF+ajejHfKNZ7WK0cB2PVX6igiHNEIe5VMsHbyE6YpCS69lwSd8iElCHHlIs
	Fn5ZGlUK7xDjKl+wYZYNKUodbXzLMxg0ajpkJcDots9R+egcd2YNx+A6VCwAVyslJA5xA9TrlYu
	8H6PEQ4gY9lZpW8rcc+zj3uSvzyud08UNfYYWzeo1GPj5tOWNGmyUUq2Iaa7/yK4AGZmJS5bNfA
	RmqMttNyiRYafVWOxbsgV7Sw9peQ8PDFae0c7y8fb19UvaMbtCIfRzscZaZEqpKR45F5eSVvq2J
	aDppSXoLhHDxsRCfh1AHNJNn3RhmP0QbITIV8Ufk2hV/SuM4KnA5EUGsrezGw=
X-Received: by 2002:a17:90a:ec90:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-392ec53e6c1mr1809410a91.12.1786438038162;
        Tue, 11 Aug 2026 01:47:18 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:47:17 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 16:46:29 +0800
Subject: [PATCH v2 2/3] drm/nouveau/uvmm: fix premature region free on
 failed OP_UNMAP_SPARSE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-2-aaee4b395d04@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=2185;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=fKwS8hLuASUBBkfhmQft0t9owMYTP3CSXRQ1mDs9JW0=;
 b=yrXi/GfTrG95r3RXD9fwP33siW9x0kLUCR1OkBk7w2hfnn9/lRMc+wLYmEKPbf+pCazGFbf1e
 HvXu2K4qPhFBTyDVzpUhsUqHjP6hqOL8DT8dLd6LvcoE6Kq50n4Egw2
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

In nouveau_uvmm_bind_job_submit()'s OP_UNMAP_SPARSE arm, op->reg is set
from nouveau_uvma_region_find(), which only looks the region up and takes
no reference; a region's sole reference is its membership in
uvmm->region_mt. Two failure paths leave op->reg set: the -ENOENT check
when the region is busy, and the drm_gpuvm_sm_unmap_ops_create() failure.
The sibling nouveau_uvmm_sm_unmap_prepare() failure just below clears
op->reg; these two do not.

unwind_continue steps back one op, so the failing op is skipped by the
unwind loop and its op->reg stays set. nouveau_uvmm_bind_job_cleanup()
then enters its if (op->reg) branch and calls nouveau_uvma_region_remove()
and nouveau_uvma_region_put() on it, dropping the tree's sole reference
and freeing a region this job never created. The comment above the
cleanup loop documents the broken invariant: op->reg must be NULL on
submit failure.

This frees a live region on an unrelated failure, reachable single-job
when drm_gpuvm_sm_unmap_ops_create() returns -ENOMEM; if another job owns
the same region, its cleanup then removes and puts the freed region, a
use-after-free. Clear op->reg on both failure paths.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 849bf42c124e..3412200b21fd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1319,6 +1319,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 							   op->va.range);
 			if (!op->reg || op->reg->dirty) {
 				ret = -ENOENT;
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 
@@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 								op->va.range);
 			if (IS_ERR(op->ops)) {
 				ret = PTR_ERR(op->ops);
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 

-- 
2.34.1

