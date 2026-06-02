Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34370808
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386745; cv=none; b=D8+JOQmjuoBAGBbxLsUnJamedjIxgGT+Q4DzNFO/zPFWtWC01dSYUhxiBRTOoag0IXWq0loff5HykOnnE+/qBNKfX/R3ALNciidoP7Fs2fhbHXJq2dART85EmsNWDu0dZ9KTrIiIqki4Vj/g1A+Pz4c+2P1MmozIFTpIR1u5na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386745; c=relaxed/simple;
	bh=eiSYb56ISqHiWW85Bez4/clFZUsfcUNxHe8kRpVIXmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mQCcIwUqfdvAhxVGlOPdLm4UWTEd1C7UDUm/7sGgcAv/Y3399fwcOpm5yW+zISR0Oraue0KGGKNKXZab8Rf7KuV7XjtDiqun7pnbjdI7sLnVYM5cc01yrOcOOJ9GZqMnuslsCzu8VpY1PIyI5oP+vu0jIEhvnxAg8G5nhs8Tbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt8sVGs7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt8sVGs7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423f1d8902so792142b3a.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780386743; x=1780991543; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP2LSLOcJwd8pqW0+7W9R4omsBDhLT1ZDgtaEvUzbZw=;
        b=Jt8sVGs7PW5hDokM3WyoGbYSM4xx1e1wwYjyS5AAAE1eTiu0gkU8CEqyODvgg1Gz6/
         BLbsslNns58OhmJ2ek+jLflLBD4r+L0X4zrxKMauiYqSFr5BmkwZhBcuyu5zSayKf9HB
         ItrgYnA+No8DUJitk8xY+HlnvNkbmjQDNWJ/vSTOWDn0OEh4MnScTDhh9qVpoDbUem5T
         7aWE+T55RSbdqT8tm1s+2C9Tkxe0rS3OTNrBXswRP5PLEYstzESNcT1CYZDOiFwNgFiw
         7Uunm6tYWu8AxNpJW9KGcrPGy8IUn/O0gqW01l1jJ1q+J0pdxB5dA4n+749PXm0BixOB
         CNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780386743; x=1780991543;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hP2LSLOcJwd8pqW0+7W9R4omsBDhLT1ZDgtaEvUzbZw=;
        b=A0t6a5JA2cCvRlsd2xqIQOAgfxPDN1oMStDxHc1dS6FJY5L7uA62h5zYT/b0cqkSjn
         dHMF5rz1dxLlwvOW4zJl7eHHZyyKA4+azonST5O+YfMNHpP1e/5Q7KOSRlbipWGlAaTW
         0M2s9OgIynvJwPSdeVlIGpM4YZcfCpaKnebdwYxbhEGGZdMI2l5eEXdLVDVJ8+TAq7oZ
         08nilW8BorNmJ5jdQ4YbYCWEwdrD1Ec25JWuqkPM+mpouNkLxRGuYySjMgrB14krp52S
         wjsoHHqy4k2ePT9FlH9PZ1IV9QBCTKDe3ol0UVk438HwuorNkEfVb7eD4JkkgL0/BPtE
         VxPw==
X-Forwarded-Encrypted: i=1; AFNElJ/8qBnhnyUF27kD4OEdnZQAIzdHHentrH0WLOwFj1J9rd0D16nKqWlrKTd4NaayQ3Pf3iIncrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyto2tlSLyAGFkaPv4uqrvclz75sw+Gv/y5989Gyv6aoHuCxRZw
	ltHu94T8s+xB8InUP6rJWWSEDUjvx1Anh1P2v3TcIa1sFtzYwOvQK45z
X-Gm-Gg: Acq92OHGyQh1uQzvjeMa4vguprKTmaVyfkjf2Hv50UmI4AmO7so9goBKNtrRdIJo2nl
	Ospgp9z1lOJA8+VOVPNIASaj0Z38bP6DtahdjsZWf/i4D3l9R1D3dUR7X8e37HEnlLvdujoWbC9
	7F17JDxjhNjSse8A8TSGlo2VrXNIVPs29VTeH2oCNXVBLgxCEYyE55tZk93YA3ZpRE9N3Au3YmI
	N9WVPb31qq5Gd3R2FkxRJ6bcbIvXU4O0pbVdThKd/a0mVP2iFpMG2W3T0sHc1yWkF4OGQmkJWQt
	P8iJ7nyl78FMG77eX7V6uA60ajorm8urwu35qU+ty81am5HjRy9rw+3oFC+bcNz678tzDDPgrq3
	jsU9P0kpmdNTEo3vMv56SqAuVXUAGIgDwAk4u6iTJT0ObsvJIRe+vOeKpsGrekGrmwcdN/F0E6K
	gc4bdcVn3oXaJA/3TkKi3cUIvd9SX6Am6IrwY/RwiH4YMmT+qojCJ2hq5uwPa71lrC
X-Received: by 2002:a05:6a00:3cd3:b0:835:6388:655d with SMTP id d2e1a72fcca58-84225401e17mr12812962b3a.14.1780386743362;
        Tue, 02 Jun 2026 00:52:23 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423dc9f361sm7534426b3a.24.2026.06.02.00.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:52:22 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:52:18 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, kees@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v2] KVM: arm64: vgic-its: Serialize translation cache
 invalidation under its_lock
Message-ID: <ah6Lsi4MfKUU6wBR@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

vgic_its_invalidate_cache() walks the per-ITS translation cache with
xa_for_each() and drops the cache's reference on each entry with
vgic_put_irq().

It must be called with its_lock held. The ITS command handlers and the
ITS teardown path hold it, but two paths that also invalidate the cache do
not: the GITS_CTLR write path holds only cmd_lock, and the path that
clears EnableLPIs in a redistributor's GICR_CTLR holds neither lock. Two
contexts without a common lock, such as two vCPUs clearing EnableLPIs or
an EnableLPIs clear racing an ITS command, can drain the same cache at
once. If both observe an entry, erase it and then put it, the single
reference the cache holds on that entry is dropped more than once, and the
entry can be freed while an ITE still maps it.

Take its_lock in the two paths that lacked it: the GITS_CTLR write path
and vgic_its_invalidate_all_caches(), which clears EnableLPIs. Since
vgic_its_invalidate_all_caches() now takes a mutex, it can no longer walk
kvm->devices under rcu_read_lock(), so walk it under kvm->lock instead.
With its_lock held across every invalidation, each entry is erased and put
by a single context, so the cache reference is dropped exactly once.

Cc: stable@vger.kernel.org
Fixes: 8201d1028caa ("KVM: arm64: vgic-its: Maintain a translation cache per ITS")
Suggested-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Serialize the invalidation under its_lock as suggested by Oliver,
  instead of v1's gating of the put on the xa_erase() return value.
- v1: https://lore.kernel.org/all/ah2c5lu4JbUg7dj-@v4bel/
---
 arch/arm64/kvm/vgic/vgic-its.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 1d7e5d560af4..4bf60fa5bd7c 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -596,6 +596,8 @@ static void vgic_its_invalidate_cache(struct vgic_its *its)
 	struct vgic_irq *irq;
 	unsigned long idx;
 
+	lockdep_assert_held(&its->its_lock);
+
 	xa_for_each(&its->translation_cache, idx, irq) {
 		xa_erase(&its->translation_cache, idx);
 		vgic_put_irq(kvm, irq);
@@ -607,17 +609,16 @@ void vgic_its_invalidate_all_caches(struct kvm *kvm)
 	struct kvm_device *dev;
 	struct vgic_its *its;
 
-	rcu_read_lock();
+	guard(mutex)(&kvm->lock);
 
-	list_for_each_entry_rcu(dev, &kvm->devices, vm_node) {
+	list_for_each_entry(dev, &kvm->devices, vm_node) {
 		if (dev->ops != &kvm_arm_vgic_its_ops)
 			continue;
 
 		its = dev->private;
+		guard(mutex)(&its->its_lock);
 		vgic_its_invalidate_cache(its);
 	}
-
-	rcu_read_unlock();
 }
 
 int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
@@ -1725,8 +1726,10 @@ static void vgic_mmio_write_its_ctlr(struct kvm *kvm, struct vgic_its *its,
 		goto out;
 
 	its->enabled = !!(val & GITS_CTLR_ENABLE);
-	if (!its->enabled)
+	if (!its->enabled) {
+		guard(mutex)(&its->its_lock);
 		vgic_its_invalidate_cache(its);
+	}
 
 	/*
 	 * Try to process any pending commands. This function bails out early
-- 
2.43.0

