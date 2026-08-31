Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC83C1083
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216265; cv=none; b=SjCiT0T9Zq/Kr6z51wm39poGDBZvC6FJJSarkSyPASOrURChyyNGZSrxR/SnWrQfJH6sUhH+OklTHCreLCsXIa5k4jdgf9bl75noPqoli9dtCAes9lq6Nlap7svLTkET5LLYoHEmYtSBrykteQL6F51WR/eXd17aU0xtQk0BDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216265; c=relaxed/simple;
	bh=/kR8qx04GaK1fozh91ZrueT9taUY09NoFMimXg43G9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Itch56sdSDr8N3mHTC0ajj50/Tg4iQALtQmBLs1w01su23BoxsxseuezU7IqtishM8cENjt9yDfRBhwxmXl3fCEhc7gD5Q8saytihTZbl255DySOJF41jqWFr4pKRzegJC18MStZqBJXRsDOnenX+xO/3NqA4fHAzdWAKMQB858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv6Wh5jz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv6Wh5jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5C01F00A3F;
	Mon, 31 Aug 2026 22:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216264;
	bh=i/l3TsS26Qm2RgkOwjKSwq7WahiYxc5glvcqes89URg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zv6Wh5jzPd5ZSL1/ukKpichHsVbMdiEzKe7D306hNpnKpjy4XPH/AvnxmrR5nFNRI
	 BQx/UCD0/itOt40Ko2fACc1IjdAL+hW1HMpshG9yqy64tD+OePlFMWRzGIIcApx0t/
	 xfes3rK3c16di/MLEXnAL71RWaFc9/S+A6fRb01UkSDJ5ZOJRct693JZJiymIfWAV4
	 ejgQrLG4CuatfGWEJBX+X4jUT/EF/YFWpNQoC/tbuIOOsKaQNBqbV5Bu7qdUv7ovqT
	 UjSzKR7fh5r2mR5ED5bMuPq3ZYmYrLnqUmSjXoPZq1pgJKNqnukkEauVlrwTs9C3yK
	 HHnXi8ym54tlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 6/8] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
Date: Mon, 31 Aug 2026 18:44:15 -0400
Message-ID: <20260831224417.1903154-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831224417.1903154-1-sashal@kernel.org>
References: <2026083159-request-customs-f573@gregkh>
 <20260831224417.1903154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit b27622c4eeb125814081baaefe9175191be5b94d ]

Split kvm_mmu_zap_all_fast() into a "front half" and a "back half", where
the front half is everything that runs with mmu_lock held for write, and
the back half is the code that runs outside of mmu_lock.  This will allow
putting more code inside kvm_arch_flush_shadow_memslot()'s critical section
without having to take mmu_lock twice in quick succession.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-9-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 73358100e0018..10c28f78bf276 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6802,20 +6802,11 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
 }
 
-/*
- * Fast invalidate all shadow pages and use lock-break technique
- * to zap obsolete pages.
- *
- * It's required when memslot is being deleted or VM is being
- * destroyed, in these cases, we should ensure that KVM MMU does
- * not use any resource of the being-deleted slot or all slots
- * after calling the function.
- */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+static void __kvm_mmu_zap_all_fast_front_half(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	write_lock(&kvm->mmu_lock);
 	trace_kvm_mmu_zap_all_fast(kvm);
 
 	/*
@@ -6852,8 +6843,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
 
 	kvm_zap_obsolete_pages(kvm);
+}
 
-	write_unlock(&kvm->mmu_lock);
+static void __kvm_mmu_zap_all_fast_back_half(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_not_held(&kvm->mmu_lock);
 
 	/*
 	 * Zap the invalidated TDP MMU roots, all SPTEs must be dropped before
@@ -6867,6 +6862,24 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
 }
 
+/*
+ * Fast invalidate all shadow pages and use lock-break technique
+ * to zap obsolete pages.
+ *
+ * It's required when memslot is being deleted or VM is being
+ * destroyed, in these cases, we should ensure that KVM MMU does
+ * not use any resource of the being-deleted slot or all slots
+ * after calling the function.
+ */
+static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+{
+	write_lock(&kvm->mmu_lock);
+	__kvm_mmu_zap_all_fast_front_half(kvm);
+	write_unlock(&kvm->mmu_lock);
+
+	__kvm_mmu_zap_all_fast_back_half(kvm);
+}
+
 int kvm_mmu_init_vm(struct kvm *kvm)
 {
 	int r, i;
-- 
2.53.0

