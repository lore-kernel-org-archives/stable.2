Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760B368D47
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616780; cv=none; b=RktHkG1SqVO0hvB/TggXrNeiFEuon7Um5y/zOC2xeY9DU9EgqKLFpvQSLB1bM1ruzgsfMsuNuyGLN/pBT+Bz7HEevSFdlSLOvvFkCAGWUTERMXMWlc/qJsTEtBZSOmohMxtPYglF8PRUHxpCEZ7k46Pclxyx9Xn+ecbCjtXS33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616780; c=relaxed/simple;
	bh=yrf9imgPzO8wlFHThXUTZ35rA60+QDuQrt+uQxh0u+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QzRbbjGOQOxv9f4PTeJjGwpxU4of2Twp2RLdkAPEFYvFc1T+3aDmEx6elIURogz2Isyjqt68Ek1z3eXkQ7BeDI9Q6uuHWxv/9m22HvZGNcd7MRxftLybcro+NQwtQ+Ia2ZKO7J669pa+DAgtKigP73zYRy0wicTYf9a8mJ95pMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFgAJw2u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFgAJw2u"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso25899325ad.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786616779; x=1787221579; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CheetA0FCd2QHli7re2NKbzT3knYEe7Te2BK6UHPkW8=;
        b=dFgAJw2u8L17wAZiY7UwFxiu+qbdz2wQ7V5ypB4rknik7lBWrIdUEZd/FipNmh6ABa
         fY45say1wGw1dVrluyHatVthNxuJRnId32TyEsqZwSU6duNH/AmP/iuhPKMKqGeRmKIT
         zc1XguCInPy9GuEdb3DpFF7pH2lUOxJjtn8K+uOdyUr0VLAgVpA3415iPNtOSnPKhiTw
         H824ri1spbPv56Hj/jw3iisTDSryFdzhrJkk5QfKCyDPBoijMVkTiK/BXD583uoeRsFE
         FAT0dlK2LVnk6otDRQQrxrYHrpqu8iYthicPdBvGTRgm0sq8eroE+sWblTwpsRHQ61Y7
         54+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786616779; x=1787221579;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CheetA0FCd2QHli7re2NKbzT3knYEe7Te2BK6UHPkW8=;
        b=RWVvCkkmHBmdn4Mcxxh8LuF7ajC/hnGoXqrj+MTjoPDMvglwlmJF8MFVWjFF2wkeNX
         gwH4J1UyOk9em/OOuaKKwpoXyoKn5QuEfjt/MiKpwiyTFWqmIYf5RVrqitsxDR0Xd1IK
         PGyByB3aAZPNgZ4rRNBD0zB7vLYP7/joeFjne3GtNkUAIrl2zc4vP8MAIc3n31C0aCUg
         EvqI16pvw2f5whpZElg2IOzEXCbH94YwjndExwJva/frMGyrJXRNckgd0u/uxoolIM0z
         ePNJNO3i3S9vrCkT7e8nXoNesZ3xdt3sWlboj5RGAuhZB2klvimYI8f4Ik/ygF02nodT
         7whA==
X-Forwarded-Encrypted: i=1; AHgh+RrGqCJe2W+Y6pFgnzEjW8y19E4zyo5GHmCdfYREUPoiDD2+ir/7KQqyQXpT9+XbbSIJy0Rg0Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6QVzJm8NLHXi1cF20PnJSfr2BqxSFZ/lUBWB6SlTBU5r6DdG
	9qGGEe9OMK8GfsYKW1W2dP2V5XiB7YUtjk+fAXjh6t3zHgHSA0HVNhaOj3Pu32oKaU0=
X-Gm-Gg: AR+sD11NNdr3qTdTIGl9ivDrbeciHv2uCw8edPlij1CwxTMPqSaaAy8Ugx9yrxV/Qcj
	OH1K9Ndazj1d7eLk0NGPVd2xxu2WlCB29Nar5nmaGkLeCjpPgXNhhW4L/fhq0NnIBH1KewH2Bp5
	nyFuWiWrYz9J+dBShI4QHisIBjcj3mNBGhmLzGpwFPElnUBeYpEDpBluKGPvKQciSyIYOAtc+sg
	VbmiIbdq9q/HnSjVYQiqeE27dWVI2KyXNuROwCtNOmcaJktgTkYYCXarFLfAOVOvhPYgVkYRTd+
	MVwRHWRwzUDOiHirjCNUtQJBHjXp+WEsY5xIkMcSuN/FgnknvkhmdObg8O9T8C8cdKbxPzmw3qP
	DrWi4H649FoOmmbMoe14gbIBFTxZEClNHKu0NufJAg9sHG7iO4/UtIKo1CZ36V/93cO4rfZW4PT
	ysrNv9zDHMpFlSXKjlqYAr+9Nki0sDKvZoBqDPOMpY53U+d+/3yXtgvEwGfJs=
X-Received: by 2002:a17:903:4b28:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d37e856ffcmr53648995ad.13.1786616778614;
        Thu, 13 Aug 2026 03:26:18 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c49bd29sm7220095ad.64.2026.08.13.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:26:18 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 18:24:26 +0800
Subject: [PATCH] drm/nouveau: disable VM_BIND once a legacy BO VMA is
 created
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-gem-uvmm-vma-fix-v1-1-4f14d427f2c9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFmbfWoC/yXMSwqEMBBF0a1IjS2IX9StiIMkllpCoiQmNIh77
 3Q7PA/evcGTY/IwZDc4iuz5sAlFnoHepF0JeU6GUpSt6IoK7REiyYArGQzRGIxG4sIf7GaxKKn
 rplY9pPvpKM3/9Di99kHtpK9fD57nC8WTXNF8AAAA
X-Change-ID: 20260813-nouveau-gem-uvmm-vma-fix-8d0fbac454b9
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786616773; l=2346;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=yrf9imgPzO8wlFHThXUTZ35rA60+QDuQrt+uQxh0u+M=;
 b=8up90CkB3EcBEnF95pzAf697k2mBINT6B819yhVrWyqIK8onVKU51wq9dVqfe1WponwGildgE
 n1Cbg8WGmwFBxQyZiMo/7nsnzQyn6HS1V+ThAo1prd3d45OWyzzzIbM
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

nouveau_gem_object_open() creates a legacy per-client VMA when the client
has not initialised VM_BIND (!nouveau_cli_uvmm()), but
nouveau_gem_object_close() only tears it down while the client is still not
a VM_BIND client ("if (nouveau_cli_uvmm(cli)) return;").

nouveau_gem_ioctl_new() calls nouveau_cli_disable_uvmm_noinit() to stop a
client mixing the legacy and VM_BIND uAPIs, but the prime-import and flink
GEM_OPEN paths that also run nouveau_gem_object_open() do not. A client can
thus open an object (creating a legacy VMA), call NOUVEAU_VM_INIT, then
close the handle: close() now returns early and leaks the VMA. If the BO is
flink-shared it outlives the client's freed vmm, and the next migration
walks nvbo->vma_list in nouveau_bo_move_ntfy() and dereferences the stale
vma->vmm -- a use-after-free.

Disable VM_BIND in nouveau_gem_object_open() as nouveau_gem_ioctl_new()
does; the helper is a no-op once VM_BIND is initialised, so VM_BIND-first
clients are unaffected.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 20dba02d6175..e33f76b5a239 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -108,6 +108,14 @@ nouveau_gem_object_open(struct drm_gem_object *gem, struct drm_file *file_priv)
 	if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
 		return 0;
 
+	/*
+	 * Opening the object binds it through the legacy per-VMA path below.
+	 * Disable VM_BIND for this client, as nouveau_gem_ioctl_new() does, so
+	 * a later NOUVEAU_VM_INIT cannot switch the client to uvmm and leave
+	 * nouveau_gem_object_close() unable to tear this VMA down.
+	 */
+	nouveau_cli_disable_uvmm_noinit(cli);
+
 	if (nvbo->no_share && uvmm &&
 	    drm_gpuvm_resv(&uvmm->base) != nvbo->bo.base.resv)
 		return -EPERM;

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-gem-uvmm-vma-fix-8d0fbac454b9

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

