Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14930567B
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787425362; cv=none; b=C+C22/m2tkYgXuAPvskOQydNbz3oBZJHpangWbXNGM3dWB8AHFze+nNtmsKGqjzxUE2PVS92xy12YPDeml87N1DaijToDDHedSrSSbqB8E37IbMFXQPfAHY+8UNrKJSYjTyMJnWcB9DNjBcpbxcYvAc9qdwRg3EFmB0arhVLUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787425362; c=relaxed/simple;
	bh=TEVVR+NJeSOM6jhm2KmEJQjEK4pU5ls7LvfbQaqcKFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OerLhDYbEAzxye9xTg7GgnTm/riTDU9gWpY40pwbZPQMCWsb/A1fMvIndJhgzTCLeqGHlzEvfi9pddUzEIQn88Sj3y1q7F6h6aPKSakThsAwZ0x1Sl3yxbIjvUnkK5iM/tYlzDIaDDB3U838+U6FZPJqZokFdb1K3aPQmTMO/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oV32R1YM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oV32R1YM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38f0f3c8da5so188794a91.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787425360; x=1788030160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D0DJujrfDn5dw25P3BnoPNA4Oq1OjRXcOtGPqI8/msc=;
        b=oV32R1YM56A+DDWB8TLmVIdWhQckn87wnLJS7I2tU8giStxFRs9xig9UyLvsuqITXJ
         KH8jBUmUMlOsp4TzXPaeFCktbJ4lY53K+amdUsyNb5TOn0q5Vkk3KyOPDLYA00FiaT+7
         2NrjsadlbRsyy8FRKocgKW163hQcR1ZRQuq0hnJxHh38NS0fPgvoLuDWS5lpm3ldO8Eb
         pxmxOwNXAUUY6RGZFlBAyouDrT48fiCLoe+NQJ6VWcoiiKJat90wwfjfrr6ZplZ+wI73
         9Cvz7a83ykcQWGPPaiwhQNDZQRjCqIcdLV5gfmN4SP5pS+3srBkXAtw49dz1px8XHgu1
         imxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787425360; x=1788030160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0DJujrfDn5dw25P3BnoPNA4Oq1OjRXcOtGPqI8/msc=;
        b=GZ7paNhmQ2gkCyfTXRrpEdJU5GsLmrlZimzgzVq3q7cXM2tDX5xrJqWLCQz/kxkUNv
         KdV0K1iBVm4SpSzJit7h0SgCj/PFGY4HMZw+ojaSscln9UqJQQhtjgSgY5TWBT6ElDuR
         NXJYw96TuoHeF5caorncm5D3L9lxueB3ypY7pxHn6MRkvceJY9z9LS/DgusY8ZNP5ohQ
         7UuYH+eHGr9uqZ5fJc+kaYLCu2C0INmN0YlMnpdXb+VpzD2FmwLyL3ImIliev9zKdv3y
         U/RSQ1ExS/u259gDfelFo7nBtEtKn5SeqWDHzRPnHzXuUTAfa3/n+Hr6GjcmlQnI7Up4
         P6ow==
X-Forwarded-Encrypted: i=1; AHgh+RobdijQei+h30AGRxZSvMh4sg8of7fME5ABSVIUq2NGZ7w6eiTZEFHZucyTo1eKGC0GRXqua5w=@vger.kernel.org
X-Gm-Message-State: AFuF++lpvw4tKrvIVl4bvN4vZSqCXWNy7/vd1vy4ARPB4KixzEXR0n2B
	h6IcwnuJNtH/76Hky26rZfLgRZF6mTfE/CQNJJOvf5c+YYqprXqu/88w
X-Gm-Gg: AR+sD13AAQpa+SCRtZfxOACISYK3D2Mz3bBiRS00efR+Lz/tqVg6TSJf3RMGMRTLGTk
	IgoLCjsibA2t7kDveOwyYOr0lQi9dx3X9tyXwYlXHb+AAVVq4vBZ400GcUGL6TGqn239wG9YS8v
	pchgTH0hX/LaDl+LdoB/b4e1kjlywpl1sKMliDdjdPc+zXKwMXlY5ANCw7T3zH29f0BOOr0kaOi
	zY2Xt8Qew4RN1QhH6Zt1FxqmJloiypFbA+0vA4FPm9A2fiRIi2UG0g8prLSwBwBbHBfIaPJaXTy
	cFUMmnSvYB9Kei6ZIsQTdj8v9QfbAAeD55hNWTaIThqaE+k7qRUb/bWOSaExVREk5eXT0c6zyID
	XlXyU+37wi0BtuGH49qa1cLeKmqt1p8keoSGYTL0cn2wLoBGRPuyJVUPH1rwNIqx0AnYzBqEpkU
	9bVuKKxZEUBdhwnL+Hxe8SlARL2L36EUK7C5bYhP9e52+GNL76YydvwrvPm5v/K1NIB+IQDtl2J
	lvU7GE5zSksGgZuzbhPAgWvrWAALH4doMKDm6Agchr1sIjiJCQYzOMu6H71E+6mPQ==
X-Received: by 2002:a17:90b:4f45:b0:38e:91a8:fb85 with SMTP id 98e67ed59e1d1-395c35e7049mr11712009a91.3.1787425359802;
        Sat, 22 Aug 2026 12:02:39 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6989sm9412297c88.2.2026.08.22.12.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:02:39 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
Date: Sun, 23 Aug 2026 03:02:24 +0800
Message-ID: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect the noncoherent DMA zap with KVM's SRCU so that memslots and
their architecture-specific metadata remain alive if the rmap walk
drops mmu_lock to reschedule.

The VFIO noncoherent-DMA path invokes
kvm_arch_register_noncoherent_dma() without holding slots_lock or an
SRCU read lock. kvm_zap_gfn_range() can then enter
__walk_slot_rmaps(), which retains pointers to a memslot and its rmap
while cond_resched_rwlock_write() temporarily drops mmu_lock.

The race looks like this:

  CPU 0: VFIO coherency update          CPU 1: memslot delete
  ----------------------------          ---------------------
  kvm_vfio_set_attr()
    kvm_arch_register_noncoherent_dma()
      kvm_zap_gfn_range()
        __walk_slot_rmaps()
          iterator.rmap = slot->arch.rmap
          cond_resched_rwlock_write()
            drop mmu_lock

                                        KVM_SET_USER_MEMORY_REGION(DELETE)
                                          kvm_arch_flush_shadow_memslot()
                                            zap SPTEs under mmu_lock
                                          kvm_swap_active_memslots()
                                            synchronize_srcu_expedited()
                                          kvm_free_memslot()
                                            vfree(slot->arch.rmap[i])
                                            kfree(slot)

          reacquire mmu_lock
          slot_rmap_walk_next()
            read freed iterator.rmap

The delete path is allowed to free the old memslot because the zap path
holds no SRCU read lock. synchronize_srcu_expedited() therefore does not
wait for the rmap walk before kvm_free_memslot() releases the old slot
and its rmap array. When the zap resumes, slot_rmap_walk_next() reads
from freed memory.

KASAN reported:

  BUG: KASAN: vmalloc-out-of-bounds in
  slot_rmap_walk_next+0x82/0x1c0
  Read of size 8 at addr ffffc900005c1008

  Call Trace:
   slot_rmap_walk_next+0x82/0x1c0
   __kvm_rmap_zap_gfn_range+0x17a/0x280
   kvm_zap_gfn_range+0x2a6/0x6a0
   kvm_vfio_set_attr+0x576/0x770
   kvm_device_ioctl+0x1ff/0x3b0
   __x64_sys_ioctl+0x134/0x1c0

Hold SRCU across the zap so that memslot deletion waits for the walk to
finish before freeing the old slot, without changing zap behavior.

Fixes: 362ff6dca541 ("KVM: x86/mmu: Zap KVM TDP when noncoherent DMA assignment starts/stops")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 arch/x86/kvm/x86.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69469bbdc84a..2114553f3159 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14092,8 +14092,12 @@ static void kvm_noncoherent_dma_assignment_start_or_stop(struct kvm *kvm)
 	 *
 	 * If KVM always honors guest PAT, however, there is nothing to do.
 	 */
-	if (kvm_check_has_quirk(kvm, KVM_X86_QUIRK_IGNORE_GUEST_PAT))
+	if (kvm_check_has_quirk(kvm, KVM_X86_QUIRK_IGNORE_GUEST_PAT)) {
+		int idx = srcu_read_lock(&kvm->srcu);
+
 		kvm_zap_gfn_range(kvm, gpa_to_gfn(0), gpa_to_gfn(~0ULL));
+		srcu_read_unlock(&kvm->srcu, idx);
+	}
 }
 
 void kvm_arch_register_noncoherent_dma(struct kvm *kvm)
-- 
2.43.0
