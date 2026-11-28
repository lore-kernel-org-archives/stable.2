Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847949;
	b=iZn40GJvX881Z5Gu/dP0NYkMoYGX77bhvnS2s28u0fNNcZYv+4PaobSELh3yg4GGMaEz
	 GmmxV4ZC73evb/LoQLYkqElGGQYZfah4uRisrbYZeyGLpFaGyfcKjGL2b2gKjZDyw7IiS
	 bXnR/1LA/6arpqGW/qm3vsqtVP4ma3mWYtlhZwDfmEBpQRl7spt7RyOsM7A3E7cJ5soiz
	 /nmS87u0mLVP6IlTFTsGNdMS9i9b883N4pMF+zvYMAKDHh9CfYYstaNCJRQidxM/+dx0W
	 qZtYLP7kbZP4gFgzwNfHYM/NiQA5JSNWkZ8ry+cPzFapwI+fngCu1YH56U+W5oRVTtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7/KIItuSkOccTTrf3OQEivNTHfzC9rlU/LCr+peVUCg=;
	b=Y9UYBetIRs8GQE4MnCXMn303TfXW1rVs22/X24Hu2r2gXD/DOsILQY0i/lvPrSb9HiLd
	 drwXh/oySFDBmtdsJKbysIa9JWhcdK9wx5oGzWTIqyRX+bmOqhS/8SyeT7gKHdmjb/L3j
	 NJ12r9MWji0nxXxm5ZQ7jFIh1Uo/GuoUhn1GVIWKE/io2c2A1+ezgmtYLm5nFElNtY/Rv
	 Z7rYVBYla0EVCAzvLZ2xfD/jHC2MNUcExON3vZdeLzwz1MwRmVSX564T47fRx1n1YYRnw
	 uV8O14iir+IaWqjD9nHidtZewIozZWH9s6jJqwWQmMChtU17aUI2OXjl0YwpQg5612A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=furiosa.ai;
	spf=none smtp.mailfrom=furiosa.ai;
	dkim=pass header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=GzW6jTTx;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F987606A327
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 06:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F987606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=GzW6jTTx
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso3511009b3a.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 22:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1795847949; x=1796452749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/KIItuSkOccTTrf3OQEivNTHfzC9rlU/LCr+peVUCg=;
        b=GzW6jTTxAsDEHPyOt7QcsgxdP7JhrH3ErUG1ai2DNjJGexk5iPsJP7lrRvBo9+ONFw
         Sfe+G81irh9UiFr/vLw5RUUUfMz/JJKuG6JYp24rIdXR8u/zewBVZ1mAaz+9G2miH/Ux
         nv2a64LYYMqjhBm4Bkje83DynyKqMbngOSxTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847949; x=1796452749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/KIItuSkOccTTrf3OQEivNTHfzC9rlU/LCr+peVUCg=;
        b=fpTa83VtAMccY2WJd23Z3pXBEiphWO3b1rAdWjtKpKUkry03OK5bV15iEb+Tq88glj
         4t2E3TJo26W7yy8qi1eMRQcnFTK+5lBs7sapwc0PGrMTwMGRXgd0EpG7gz+mbkQ7rKOt
         R/HbC88+Ueu2k/LhKbGcRXxwDcjL7xu1K8z7eQ8u0crz3uVgNsxsNeRjA1qDiCtuvKx5
         IuowqnLW7FNMbC1iMipcR/Jic2l8KiAByXwqGm+n9+5TaBVrphKCKpBRMMBPjifYw+yD
         OcRcC0eUdexupQNOMWTf3tLPXFot/ZqBLf3Nzxqwg8mEFpIPYyBLRm49HYaPBb/izq57
         PuyQ==
X-Forwarded-Encrypted: i=1; AL+hErEJdFut0gZpD9PT+DqILGIzyQUL+Qm9FfiW+JDnc40sltoCFtv7C4yeVZzFACX5csFcmT+qz9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+W33MUKe5l+Kesa37vA7K0hGN7CigHeyOSdepIhAskXcWq7JqM
	dmge7uAyn5+BmH2dZl/JCQVN/aS1TTYtA+UwpDByDhUxgQBF+Yi/1SVW+zKadB6CLS8=
X-Gm-Gg: AZFdTZeP+X6feYh+KvDwjyp5P2BBpb0Wt1N2liFEaCVBNkJTvfpXfWSW1XsdK7dCXUo
	aYzwCTRPEJoSbgw3h+rqqYkueU/T53Ct3xKTtyqZGRbe9XjwMTYWG4BCO9LRyFtzh0yV/2KgURW
	+cCYQUZcg+pM5xbi0FQrstF5Radux8LnS6SZYdogTiO3SM3Fj5JpvCNC9NgLtY4yI8mGdGvzgWu
	lhIjyqcpcRQadj6YYXuI9PvKe/E7Pu+7LXgpLn6Y3J0yabirFklzuGnnP1+X42da7Orld0hAt/K
	Y1UdtHTKWZodyM/KbVAPUrPpJcx0QLygln1l6PHmUeuTOnsE2FLZtmIGjTOd1xCBTBu0gms65GI
	fcOVHDEFjq16R05cvfB7OiK7IcriYdS3j21xHV4LuQhXDIcB3HUmIy2yEous1lxsEiBB9rHGG5u
	4HWBkJ/gwUB+/227udiNaPddePzbYbV95frL3y1mEjXzINuNGGUoXy1MyqOb/YqXtCV8IYTUnfg
	/nw0yRB/Xp/QNBWY/ctyp5cWDVONojFine/z3LrOZMKyhmiJqAmOhMf0u9DoC3bGGgWeCu/sLI4
	iENL1PuOcJgpNV/zSoMOC88aF7MkGOEgzLGeGBFm+0MN++kGtWQoDonaHxsnEq++S5Vdj4TyBrD
	eEnKjEaym/7hy
X-Received: by 2002:a05:6300:278a:10b0:3f9:797f:385a with SMTP id adf61e73a8af0-407235c3a0cmr11591887637.15.1795847948803;
        Fri, 27 Nov 2026 22:39:08 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:39:08 -0800 (PST)
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
Subject: [PATCH 2/4] accel/rocket: Fix iommu_map_sgtable() return handling in create_bo
Date: Sat, 28 Nov 2026 15:38:42 +0900
Message-ID: <20261128063844.1537615-3-sidong.yang@furiosa.ai>
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

iommu_map_sgtable() returns ssize_t, not int. Storing its return value
in int ret truncates any mapping of 2 GiB or larger (reachable via the
__u32 args->size) to a negative value. The error path then removes the
drm_mm node without calling iommu_unmap(), leaking the IOMMU mapping and
causing subsequent allocations at the same IOVA to fail.

In addition, if iommu_map_sgtable() ever returns a short mapping, the
error path fails to unmap the already mapped range, and the drm_mm node
was sized from the unaligned args->size rather than gem_obj->size.

Store the return value of iommu_map_sgtable() in ssize_t, size the
drm_mm node from gem_obj->size, propagate negative errors directly, and
unmap partial mappings before returning -ENOMEM.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_gem.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index 9f3d85e3dd30..e52fc6ea7cf0 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -67,6 +67,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	struct rocket_vm *vm;
 	struct sg_table *sgt;
 	size_t size = PAGE_ALIGN((size_t)args->size);
+	ssize_t mapped;
 	int ret;
 
 	if (!size)
@@ -81,7 +82,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 
 	vm = rocket_vm_get(rocket_priv);
 	rkt_obj->vm = vm;
-	rkt_obj->size = args->size;
+	rkt_obj->size = gem_obj->size;
 	rkt_obj->offset = 0;
 
 	sgt = drm_gem_shmem_get_pages_sgt(shmem_obj);
@@ -98,19 +99,27 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	if (ret)
 		goto err;
 
-	ret = iommu_map_sgtable(vm->domain,
-				rkt_obj->mm.start,
-				shmem_obj->sgt,
-				IOMMU_READ | IOMMU_WRITE);
-	if (ret < 0 || ret < args->size) {
-		drm_err(dev, "failed to map buffer: size=%d request_size=%u\n",
-			ret, args->size);
+	mapped = iommu_map_sgtable(vm->domain,
+				   rkt_obj->mm.start,
+				   shmem_obj->sgt,
+				   IOMMU_READ | IOMMU_WRITE);
+	if (mapped < 0) {
+		drm_err(dev, "failed to map buffer: err=%zd request_size=%zu\n",
+			mapped, gem_obj->size);
+		ret = mapped;
+		goto err_remove_node;
+	}
+	if ((size_t)mapped < gem_obj->size) {
+		drm_err(dev, "failed to map buffer: size=%zd request_size=%zu\n",
+			mapped, gem_obj->size);
+		if (mapped)
+			iommu_unmap(vm->domain, rkt_obj->mm.start, mapped);
 		ret = -ENOMEM;
 		goto err_remove_node;
 	}
 
 	/* iommu_map_sgtable might have aligned the size */
-	rkt_obj->size = ret;
+	rkt_obj->size = mapped;
 	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
 	args->dma_address = rkt_obj->mm.start;
 
-- 
2.53.0

