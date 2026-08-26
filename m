Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25025483BC8
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775435; cv=none; b=Q//zTSrf7KaIAaKntu0m1UksLO5P1yqiiG1Nwz8jEEvG6/TMVzjBKngzBZh+JbxEkytktaqnVvQvgIbgrIvsIVX+y3SgrKGF13NwZuCWEbVjuztZFkSJltZG1n1NjI6XKMKsTrZPv7RPWXsPF0e2zO5/7ysa+JHASM7VGBjEsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775435; c=relaxed/simple;
	bh=VNoz2VDnlGL7nf6vtZBQ505wury0ZhGaC6JD4dMDDxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldH41R4KdvRiMhav7+Y3FTfftwvIT7HDEg4mVd/NdyAXCAfxMy1S6PZQfN6gWjFP7KBToGyAB+6O2VJl7og0cPcBdBrpQCb8Ki2f3/wdh7TSklQJPhWomLcYU/vpK9dtlddOgRp9qkYkL02wHw+K8cDc5xFj/GAnzCpgYt7zBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=PS+X2c/g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="PS+X2c/g"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d71ae3455aso10680465ad.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787775433; x=1788380233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZP/Zh7VL0NP5ZL/ftf+0Og5kx5+Zk04Hdc0Eb7ielXU=;
        b=PS+X2c/gGSSLtN3Y1TtsZADJvG5rkhVZRFeOtm6SHUWnRuKdtfsYn+4yCL4gyRNHsm
         o+8H8sN88sKpNVwb2izvd535/luNvDJecc9or7CZDiXQRZ+HBdHn/JJgkg38ZeQfwkLB
         QCciHSNj+cLVrP0CDYBsOU8pGQ6lOGESjV+9nF7vjuq6K2muF8GejNL4lUzO7l8sUPC9
         chBx7shd1D8OVUe07xH9TvHb4fDiyZNHF1UzbA00SVN20o/9cN5gZTVAVgwKs4B11nkf
         QVeX4MVrjzkMWEM441Ry/efiEtnzRu78yueam1hfONmK2UbJrZtHdMPpJipHl/u5BGVd
         Kpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775433; x=1788380233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZP/Zh7VL0NP5ZL/ftf+0Og5kx5+Zk04Hdc0Eb7ielXU=;
        b=LDXiOo1tfgfjZowM01l5gKYRrD8WYGiBZl0JnOvP1LtyEXwp3vNH8/Ak1vDG3WQmjU
         Rdm/FKeEjdojcKNK/CKCTgiS+5+StMqL3Hm3UThEuhbiGTmZMHDx4SA6vXekXV1pR71R
         RMk9ktpNrcUYVPaddMZBUziz3mHs/zsv9tCyYImp4akBYqm4ZesD2izvCYoJP3ReCVzH
         u9QtzKTIory2bRDaFLXy/AJziAxFl80Z/8OG69hJWZiJAUdTWmah5Df7VKxYPZBU1CXb
         hpLnskleEQe0qWiXbocQBJHMJ0N+NWnyVweLdnqeKefSeTMIwrdZ19lTVhJ1fs5vAMyT
         GEXg==
X-Gm-Message-State: AFuF++nqQHYLcXV1ieh1j3OiZTGtG/NMer6oR6L8cd2B0FWrmaizoGbC
	vpgRH1ImkGFHRDhyteW/kcl4ycVBchvt9w6T4Xod79AlA/Y2dYRM4QxhtI2Naqz3pgw5VcmZz5j
	ikuJD
X-Gm-Gg: AR+sD13GqtVHpNfR+14YPzeD2RZhJV0l1MOson+QQ0ADYhdYrBxwuRCnjYspKK62qZP
	4ulAwyTFsrdyUvXZeBsZXuBBdBHMraqM1ehLU1tb7+NeUcBhreGst3BpPLvHdq69qXnJvWVMJWp
	LUD5l9sB97g31Mw4btVD/RGI0JfIbjEvBXucIiFAdnEkmxnbUw1vR8HFAu2U6Gjd9MmfUwNPY3D
	i2KYzHVtkhSeCkJ/9U/LN4CbRbvN1B++S9rJ/ajQhbb7BHND3Gj6eonm/PKipogyJVjnR9s/XLy
	joBC2FkU1Q6P0ObedoQA9aCNSzmXa3yuhgs32RyvqXkPl86RAbFZawOA1ggsl9FNs6+fFAJR+Er
	USFIla1WraA6eEiQ/6tlp5usFvhUx7291QnMfIUHP8TkYWkfAu+sqOjSs6md3iOGkTwV0U0Ki+y
	6I6mewe0UfPCImU8sciqV5vDvyO5gmFXIv9j6MZ1Up6ttYo7PnZQt36/aRzTVq/NDxhXg5arD0K
	tdSdxzCDbWhEwhi8epfTJeHQc8av/Kf7YEzf6BoY3fFcUSHFtbo5FGpM6A=
X-Received: by 2002:a17:902:f546:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d707b60764mr156912635ad.13.1787775433400;
        Wed, 26 Aug 2026 13:17:13 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:957:eb3d:7323:2ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60b59dsm11179738eec.3.2026.08.26.13.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 13:17:13 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	kimjw04271234@gmail.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.6.y 1/2] KVM: x86/mmu: Check write tracking in all address spaces
Date: Wed, 26 Aug 2026 16:16:54 -0400
Message-ID: <20260826201655.9198-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826201655.9198-1-artem@trailofbits.com>
References: <20260826201655.9198-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinu Kim <kimjw04271234@gmail.com>

commit 0f38453cdb2e17566ccb7c0f3dabd5bd21caca26 upstream.

kvm_gfn_is_write_tracked() checks only the supplied memslot, but page
tracking is per-address-space and shadow pages are shared across all
address spaces.  With SMM, a GFN can therefore be write-tracked in one
address space and appear untracked through the other.

Check the supplied slot first, then the slot for the other address space.
This ensures all callers honor write tracking regardless of the active
address space.  In particular, it prevents mmu_try_to_unsync_pages() from
marking an upper-level shadow page unsync and eventually triggering the
BUG in pte_list_remove().

Fixes: 699023e23965 ("KVM: x86: add SMM to the MMU role, support SMRAM address space")
Assisted-by: Codex:GPT-5
Signed-off-by: Jinu Kim <kimjw04271234@gmail.com>
Message-ID: <20260721103512.2136240-2-kimjw04271234@gmail.com>
[invert direction of the conditional. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ artem: adapt to 6.6, which has neither KVM_MAX_NR_ADDRESS_SPACES nor
  kvm_arch_nr_memslot_as_ids(); use KVM_ADDRESS_SPACE_NUM instead. That
  macro is CONFIG_KVM_SMM-conditional in 6.6, so the guard on
  KVM_ADDRESS_SPACE_NUM > 1 around the peer-slot lookup is retained ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Target tree: linux-6.6.y (stable).

Verified: applies to v6.6.153; arch/x86/kvm/mmu/page_track.o builds clean
with CONFIG_KVM_SMM=y and with CONFIG_KVM_SMM=n.

 arch/x86/kvm/mmu/page_track.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index c87da11f3a04..2615074a4bff 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -117,13 +117,23 @@ void __kvm_write_track_remove_gfn(struct kvm *kvm,
 	kvm_mmu_gfn_allow_lpage(slot, gfn);
 }
 
-/*
- * check if the corresponding access on the specified guest page is tracked.
- */
+static bool __kvm_gfn_is_write_tracked(const struct kvm_memory_slot *slot,
+				       gfn_t gfn)
+{
+	int index;
+
+	if (!slot)
+		return false;
+
+	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
+	return !!READ_ONCE(slot->arch.gfn_write_track[index]);
+}
+
+/* check if write access is tracked on the specified guest page.  */
 bool kvm_gfn_is_write_tracked(struct kvm *kvm,
 			      const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	int index;
+	const struct kvm_memory_slot *other_slot;
 
 	if (!slot)
 		return false;
@@ -131,8 +141,18 @@ bool kvm_gfn_is_write_tracked(struct kvm *kvm,
 	if (!kvm_page_track_write_tracking_enabled(kvm))
 		return false;
 
-	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
-	return !!READ_ONCE(slot->arch.gfn_write_track[index]);
+	BUILD_BUG_ON(KVM_ADDRESS_SPACE_NUM > 2);
+
+	if (__kvm_gfn_is_write_tracked(slot, gfn))
+		return true;
+
+	if (KVM_ADDRESS_SPACE_NUM > 1) {
+		other_slot = __gfn_to_memslot(__kvm_memslots(kvm, slot->as_id ^ 1), gfn);
+		if (__kvm_gfn_is_write_tracked(other_slot, gfn))
+			return true;
+	}
+
+	return false;
 }
 
 #ifdef CONFIG_KVM_EXTERNAL_WRITE_TRACKING
-- 
2.43.0

