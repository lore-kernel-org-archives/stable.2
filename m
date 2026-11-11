Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419944;
	b=Cr4Jt8mJCugtJtIL8eNwLH+AESwxFQIYbIIJOEYfC7/Yrg8kZDYi3dBykraqa6bWQRka
	 yWNkvAtE+K3136h5mMeQdpjJTzGodDgqGIWLaOORv8Ppq/AjoPIhVNOrlfxuDCeDoWPFM
	 6wj/z6wX+0jj9ui6nFkTAwns3MaFgRzIffkpg05ktl+t/Os9MLHImLglp7NJn3JW/npJI
	 uK4X2SdzmZ7bu5MfzoWXiq2dEpkvfJS/7LTYR2tUjU/1RqD/ElXB5YkGK3/mE3C4d6kOb
	 tagA5uNi3+D65aALU28Sou3NXKLbamXeHbBwhFs3TdqFFS0hxt8jTGGCrw1tv7SIlrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xCSRQndgGYCgQ1UY81UleAUi/noEt6s8nO0zhbXbRmQ=;
	b=pSe/b11lgl3t7sMHJe/tdjHdqTv8GK6mN2diANbh8woq5tPjs0W/AwBzhWb2SZR6n9fZ
	 7gNSoWv8HJRQHKAfkOgdgRktMF8xwUea3okqlcUzoxYwmMIQlMrTzi2f3SCmLe21/AKIH
	 JW75+WLgbrHAolYjcpgTCeuXV5hD5pKDOd/nmRYH4aVC7JQXO5xI0NK9qSOmKUYntUAqG
	 OBImXZrd+NmGKI9lWCAlhpL2x7e/l3UKszWlj6Baex93K4j53DX6KfSbpIX2uLfCAFqHh
	 KF2Vcv3GlOH8JOHS33N8Ohin4db413Q9peyBa37wBBlGXS0vVQkG7UxIbTcxML5HUQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ood/r5HP";
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B872606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B872606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ood/r5HP
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b75712fb57so3196329a12.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419942; x=1795024742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCSRQndgGYCgQ1UY81UleAUi/noEt6s8nO0zhbXbRmQ=;
        b=ood/r5HPqeVohsjwJoS3WSsqCcU40u+XrOewwSQj8SMMOlQIlVl4sd6mKV1aRxXjko
         9rWNnj7CqJcZhGBaBV5+FJzgeCgJvCUkBRENHPTe2L1OysIRuWPHmkt2+dgXIFThpVS/
         M1VUYPj+d0zkwBtBCAgLGFFPiKAdS4locKesx8Hboi1NVqw3kBS3QPGbpLpprKgf9J/K
         vMRfHi8hk4o9/YECswKsSeuMgsSG4IgtbIuuQBMdEcAS39Vb3mx3KdEDCoJunddY4dAl
         0ShQzhlrWAf2cJ1Evr8VYL+djH0zhUUdopFQ/1IyPBgf2cG3vYoXeGLQKJWb2dFnPwtj
         oTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419942; x=1795024742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCSRQndgGYCgQ1UY81UleAUi/noEt6s8nO0zhbXbRmQ=;
        b=uQuJENfwRL0Sh+F0pJgWQ9NHhVIROHM9KVSDecitL1LBuJQn4onyn64GT3d0m0Fifm
         rbOA3duLlIFADYcaeyC0WyfR0cyBBz/AVLcLAtCThghcDfvtV9UbxR68SrBrnmmwZA/2
         IUeMeEii88TnYwnQbGYrzCHGarw17ZWL3vTHGWiegy7cDDXs/1lKcD9i0gQJYdLuUjVi
         1dl+MxlPJuVMR6s+TSDw730aAno9sFEHPDHG5qy2k7uuqcWiTyvTZ32kZlTjoQinSYLD
         JqDYJ8X/YFh/nohtbDKH2Re0T5dletMWY9HUFKPtXnhH1feRtBxq5g1Itz5DP71Ynq4Q
         hEwA==
X-Gm-Message-State: APuU4Z+ahQARBsd4IrOgfNJObH7jkurX8ZjEj3aY7xX9m89M/ymcC+IX
	Fj0zeOpeJJfzvoP8uk0c7QENND8WBmwTmz0uNjSk/ofuQEC9hjnzCAh1y7IyPq314D0=
X-Gm-Gg: AYBFou0KTeyRkF7PC1hukapaaCWNRtvtqT3qBC7anEKzFT0dpTExyg0Tah9v+tcfU5l
	Q03Qxvp5oicHGX3dQ5sAlxg2xd3FRN0Yo4gxPuHZ90Q/QRGxAxKC0HKN1PLYCQLZsTpvgcDNNVk
	0scXS4kZPGxuK3OFQIbhAvieOjAjo6AbYHPdWMdYT8Apk+qCZWbf4jU4oyIs3PiIWsfTte2bvih
	jnBqVrUj2uDEzd4B5+kmYhyxJ/FMZOhp5+0GZw3ua/TH5Hi6lFTTxop/aBlBWc8gLBuBLxQO37K
	HPA43nAeddf9+lv2xD7I36hN9MY1E0uebMSjsDPWQBHfgWtE2n5hk9dQKbSOy7BkBeJcDbCJI9f
	PVtzbCWtsbvqauqKln5RBDImMAwGdvzZmSyAdAWSX3EBugv9Fd1aMdP28/DZ9/1Y6vFEFUuxS0V
	elsdntd4LDkAkELBh4/00HXxBrU6PQ9lLt96KLP/SVNqhRB1RQzcY5arX8yvvQp1c+0x4gHYdVO
	FapZirEjRvLqi52ZIjXiGz+JQQW4IVkAfDwOxg+u+0ejI+Ti7n3gqkSBv59fU6AyImGO2GhCQhs
	1TUH9lw3OF3n3z62DgMFbAdDxgQUN72BVLZLREK068Jh75+4o52KxUcPE6xDEk9yVbtyctw=
X-Received: by 2002:a17:907:6ea8:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c5066ad6d1dmr242986666b.21.1794419942257;
        Wed, 11 Nov 2026 09:59:02 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5049ef69c7sm260075966b.0.2026.11.11.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:59:01 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: stable@vger.kernel.org
Cc: Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH 6.1.y] alpha: load the MMU context when switch_mm() switches the current task
Date: Wed, 11 Nov 2026 18:58:44 +0100
Message-ID: <20261111175851.1156045-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107055056-failed-6.1-9b8be19d5dc9@kernel.org>
References: <20261107055056-failed-6.1-9b8be19d5dc9@kernel.org>
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

[ Upstream commit 9b8be19d5dc9525a408942e2e8012873199e7455 ]

The 6.1.y header still contains ev4_switch_mm().  Retain it, and omit the
unrelated do_page_fault() declaration move.  Of the direct callers
described below, only kthread_use_mm() is present in this tree.

ev5_switch_mm() only prepares the incoming PCB. The context is installed
by PAL_swpctx, which alpha_switch_to() issues against that PCB on the way
out of the scheduler.

Direct callers reach switch_mm() without going through alpha_switch_to():
kthread_use_mm(), which borrows an mm for the current kernel thread,
sched_force_init_mm() on the CPU-hotplug teardown path, and
do_shoot_lazy_tlb(), which switches to init_mm from an IPI. None explicitly
loads the context, so the task can carry on running under whatever was
loaded before. For kthread_use_mm(), current->mm then names the borrowed
mm even though its context has not been loaded. The other two callers
change active_mm while leaving current->mm NULL.

The stale page-table root need not be swapper_pg_dir; it may belong to a
user process that ran on the CPU earlier, and the kthread's user accesses
can then read and write that process's memory wherever the stale mappings
allow. Translations taken that way can also end up tagged with the
borrowed mm's ASN: ev5_switch_mm() writes that ASN into the PCB, which the
next PAL_swpctx installs against the stale ptbr. An address the stale
tables do not map faults instead, and since do_page_fault() resolves
faults against current->mm without reloading the context, the same access
can fault again on return.

sched_force_init_mm() needs CONFIG_HOTPLUG_CPU and do_shoot_lazy_tlb()
needs CONFIG_MMU_LAZY_TLB_SHOOTDOWN. Alpha selects neither, so only
kthread_use_mm() is reachable in practice. Test the caller's identity
rather than special-casing individual callers.

The scheduler passes the incoming task, which is not current until
alpha_switch_to() runs; all three direct callers pass current. Test for
that and load the context the way activate_mm() does. All three run with
interrupts disabled across the switch, so this completes before any
shootdown can be taken and needs no asn_lock handshake.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Tested-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20261010142533.974797-2-linmag7@gmail.com
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
(cherry picked from commit 9b8be19d5dc9525a408942e2e8012873199e7455)
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 4eea7c616992..518ecdd50bbd 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -132,6 +132,8 @@ __get_new_mm_context(struct mm_struct *mm, long cpu)
 	return next;
 }
 
+extern void __load_new_mm_context(struct mm_struct *);
+
 __EXTERN_INLINE void
 ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	      struct task_struct *next)
@@ -141,6 +143,15 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	unsigned long mmc;
 	long cpu = smp_processor_id();
 
+	/*
+	 * kthread_use_mm() switches current's mm without alpha_switch_to(),
+	 * which loads the context.
+	 */
+	if (next == current) {
+		__load_new_mm_context(next_mm);
+		return;
+	}
+
 #ifdef CONFIG_SMP
 	cpu_data[cpu].asn_lock = 1;
 	barrier();
@@ -182,8 +193,6 @@ ev4_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	ev5_switch_mm(prev_mm, next_mm, next);
 }
 
-extern void __load_new_mm_context(struct mm_struct *);
-
 #ifdef CONFIG_SMP
 #define check_mmu_context()					\
 do {								\
