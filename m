Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442B37C909
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683179; cv=none; b=kYoQ6+jqGzFWL1pxJfgolE7l36jTdYv/YAHHtntEBjmiQwK2+U2TkabjOeoDBqx/Rv5dn90lxouBmG5CPW6YrJXKz5GLIotQtujslcppGfyxtFCZ/ArPs2V7j2bspdY9dU7Cl1fR7x6BATlQwYddED78b9rIHK2I4kP8zaMcsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683179; c=relaxed/simple;
	bh=RdeEnUyZxdCR6MrqtuNxlBJrc3Eh5JtCEqB3t4sF5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHnNwDwpuF/hDp1TutxGRQpMkMAEpuGyQDREopOeYSGftvN238/HPErDdll3gx+v7tyLkwjK046axUqToUGgFq2X9NFABWMfQDrr3+WGNoFrFZFzNbBngzoxuJQ+8YIzW8zmATTEp/Q2hP0KRG8PJkAexVBIDv4ormFblTHTmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddZpj1LR; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddZpj1LR"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66d176f0569so19110d50.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787683177; x=1788287977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DzDBNQWpaXJItDcAuhVID3lvsOEPud4hU73IGqDCIdQ=;
        b=ddZpj1LR9AKheN6rsa5JhlqXbXllfuPWAMS/Z+dvYFRz0SmNa6v634DDeD/gWtI2ye
         Z7rCn5l/ouOtgIwqiL2cl9TmMNbhNdHaoOJsMmrjHui3r4E2OLmKAC3A3ZrqduZpkkyR
         rFdcRnqrtCjDUFAgIbXDAxx4UCf+/xiqPkihXHaQ5mm0YLiEEPwIzcwlqBZKBU5FVMqV
         7Ftugo1+DeHdfvPL+yiF/xfyxzQA/6XsqDQoNHbDZroriHwrSLL12bi3GNfOLOAPBGqv
         LtMs9Zis12hG1fd0un6SrXOZH993JLKjMgc7iOwkdR+vmWuk3QPlDudLpCUyyL37IyOW
         DRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683177; x=1788287977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DzDBNQWpaXJItDcAuhVID3lvsOEPud4hU73IGqDCIdQ=;
        b=NGmCSAZZUVtTc9L8FteIkeNqputGDohO74zHcEeMfRtQewulHLOyjveIqk6Lsr2q8C
         vJBc4XD4iRLjM2Mb8WxehrAVZLGcS0I8lZ0InN/ItxzBuTuSxB/Ym+0Ag9w+jR9Sq0R+
         VNVldsadkOhdHG4XsF0IZ7Mn6t1K+a6WYzakcVszmfzTdRU0Tfy25hmI3/bpPXTdklaW
         M3bGHJJr+yuhqhfPeRdWKGr79nczMspC1JP9GgoCwPHjZrczwpzd1hm/dHc1IXO06GWE
         NBmaXFCLESLo7EFTfKjXntneP5Ulq2vzLjiJ/uQxWtnXzR7wJ91y/RwYNNRJACSHXZXr
         OBVg==
X-Forwarded-Encrypted: i=1; AHgh+RpESnU1U6bGnU3cd/XoBPM8yzPgFETrnOzBE1IlNrwJAvQ2fcnFrzO75KIm9uSbZMu0kBNgQ64=@vger.kernel.org
X-Gm-Message-State: AFuF++moahNH+0+/k0CxERhH9h0I/2PUdbr02yqnjDuODqtbg9Wnh5V9
	Lcq4VGN2eu5Qn+cKjW4oyCwXznOX1IO4WflrU0UTwVlIbz582FycWm3Z
X-Gm-Gg: AR+sD1081tEEZFY0L3ibv8PG4nX31n1BhU88qUEYRUyo4kCuMcbMNP1b6XgWGsxUYxZ
	KhPbgRCmydjx9Wzd5Lughr52L/QbSF/Xfi48N2E17JnrB0EWK6ay0bW+eCd/Dljv31EexxZHGxw
	CaSOgYjH+Ig49nNKnGdgcrQXsvPcQ8nwbtW1Tp9vk3pFatFn1fVCt0uS286A0PUnM+CyYT8C74y
	JNYrY9YTbqv/Zar2/S75bZlzlXfCM99jCa6LxLZEfc3ghDn4r4dfu6mBQcX3Sp/f8QvNekrbzge
	2p1BgMMXKVmRuMXdiF/uZ1tiWhYHABxXC0VoCsncI7k0LQKFEjNz4queYTnKMdiBEIrC2XidjMI
	QPeFmLv5xgUXLf+liFC8MrEAL5NChcrOPKo7FSbjjVh8T1b92cqOgah8zDdFyCJf/oeYNSIn5ua
	4ZjnN5DWQ1gJ84LgqsYXZDgtSV8biI8uDIIekYL4N7mVfbGK7+uq4peDbUXic82oquS10qutiuc
	rhI9Uu8J7zuNGyeZuBDNDEc08DlMws4ozgZo/seY02fdPhmvya+kXBGZQ==
X-Received: by 2002:a05:690c:c4e1:b0:820:100e:1abb with SMTP id 00721157ae682-8574105820cmr4191967b3.4.1787683177092;
        Tue, 25 Aug 2026 11:39:37 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d237bf4sm3988007b3.38.2026.08.25.11.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:36 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: x86: Take SRCU in kvm_zap_gfn_range()
Date: Wed, 26 Aug 2026 02:39:24 +0800
Message-ID: <20260825183924.237727-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_zap_gfn_range() walks memslots and rmaps and may drop mmu_lock to
reschedule. Callers that do not already hold kvm->srcu (or slots_lock)
can race with memslot deletion: synchronize_srcu_expedited() does not
wait, kvm_free_memslot() frees the old slot and its rmap, and the zap
resumes on freed memory.

The VFIO noncoherent-DMA path hits this by zapping the entire GPA
space without SRCU. KASAN reported:

  BUG: KASAN: vmalloc-out-of-bounds in slot_rmap_walk_next+0x82/0x1c0
  Read of size 8 at addr ffffc900005c1008
  Call Trace:
   slot_rmap_walk_next+0x82/0x1c0
   __kvm_rmap_zap_gfn_range+0x17a/0x280
   kvm_zap_gfn_range+0x2a6/0x6a0
   kvm_vfio_set_attr+0x576/0x770
   kvm_device_ioctl+0x1ff/0x3b0

Take SRCU inside kvm_zap_gfn_range() so every caller is covered.
Nesting with an existing kvm->srcu critical section is fine; the
helper uses a local index. Drop the now-redundant SRCU pair from
__kvm_set_or_clear_apicv_inhibit().

Fixes: 362ff6dca541 ("KVM: x86/mmu: Zap KVM TDP when noncoherent DMA assignment starts/stops")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
v2:
- Take SRCU inside kvm_zap_gfn_range() with guard(srcu)(), as suggested
  by Sean Christopherson, instead of wrapping only the noncoherent-DMA
  caller.
- Drop the now-redundant SRCU pair from
  __kvm_set_or_clear_apicv_inhibit(). Nested kvm->srcu is fine; only
  kvm_vcpu_srcu_read_lock() cannot nest with itself.

 arch/x86/kvm/mmu/mmu.c | 2 ++
 arch/x86/kvm/x86.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a61750f8e1e3..ae55a77e5a05 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7047,6 +7047,8 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 	if (WARN_ON_ONCE(gfn_end <= gfn_start))
 		return;
 
+	guard(srcu)(&kvm->srcu);
+
 	write_lock(&kvm->mmu_lock);
 
 	kvm_mmu_invalidate_start(kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69469bbdc84a..adccd4a8e6c1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10986,10 +10986,8 @@ void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
 		kvm->arch.apicv_inhibit_reasons = new;
 		if (new) {
 			unsigned long gfn = gpa_to_gfn(APIC_DEFAULT_PHYS_BASE);
-			int idx = srcu_read_lock(&kvm->srcu);
 
 			kvm_zap_gfn_range(kvm, gfn, gfn+1);
-			srcu_read_unlock(&kvm->srcu, idx);
 		}
 	} else {
 		kvm->arch.apicv_inhibit_reasons = new;
-- 
2.43.0

