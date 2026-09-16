Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B54143F080;
	Wed, 16 Sep 2026 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599900; cv=none; b=tnTGnFVj636/R6hdcLhxV2Tfnd+ljy6KKmLZnaHftPFmNl9k7zx473WsiyFG0spQEhvxFQEXq2TIDaRh+Oy4VklG5BPYmkIynsVzlv7O8mN5qQ8qqxPG84k77Glkcq5YYp6kd3SYiHvxRzpx/HF3qaXO7Se7Jtal9sB9qnCp89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599900; c=relaxed/simple;
	bh=vAFrHWJhmqJ9JZijWWOPIIzgx1x4jbVSOAfXEjggRyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6+WL6DcoLGY4OpG2KpsYX7hZbPm1rJBnL13iSa69QhdOIZArxC3KJqHb/lviTOWYoWiTmQp+xH7OTG8X9rEzQ1yAnq5paFNZPHnZufBPYNZA4ph8qUwMeatuHpEAfIqUqtZnsHvTlY3z2aNcc6SBkPgDQtcM+n72E2jMHtzLYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kA7LM8H1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kA7LM8H1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9C11477;
	Wed, 16 Sep 2026 16:04:53 -0700 (PDT)
Received: from workstation-e142269.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56C573F7B4;
	Wed, 16 Sep 2026 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789599897; bh=vAFrHWJhmqJ9JZijWWOPIIzgx1x4jbVSOAfXEjggRyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kA7LM8H1OpkdNGp2irBjX5CsQBDrt+cJIsSqMhgERYavYzt5474QgreduJ9Yrae9i
	 ic/a6FT9wL8gzGrWyQrZYJkFy4lOkJ5yivHl4HSrFhd7MGtQ8xNm1kqztMzNgpArmF
	 36ykGbIFADQGlUdkl9JnQxNcAuBU7Vg/A/Esv/ZM=
From: Wei-Lin Chang <weilin.chang@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Sashiko AI <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] KVM: arm64: ptdump: Check the page tables aren't freed when accessing
Date: Thu, 17 Sep 2026 00:03:36 +0100
Message-ID: <20260916230337.4162485-2-weilin.chang@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916230337.4162485-1-weilin.chang@arm.com>
References: <20260916230337.4162485-1-weilin.chang@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An open debugfs file keeps the KVM structure alive, but does not prevent
mmu notifier release from freeing the stage-2 page tables when the VMM’s
address space is torn down. Therefore page tables belonging to the mmus
could have been freed when a thread opens or reads the ptdump files.
Take the mmu_lock and check mmu->pgt is still alive before accessing the
page tables.

Also for the ipa_range file and stage2_levels file, switch from keeping
the pointer to the page tables to keeping the pointer to the mmu.

Fixes: 7c4f73548ed1 ("KVM: arm64: Register ptdump with debugfs on guest creation")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvmarm/20260623144054.B91D21F000E9@smtp.kernel.org/
Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/ptdump.c | 43 +++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 69899797dbad..4ead856c181a 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -115,15 +115,28 @@ static int kvm_ptdump_build_levels(struct ptdump_pg_level *level, u32 start_lvl)
 
 static struct kvm_ptdump_guest_state *kvm_ptdump_parser_create(struct kvm_s2_mmu *mmu)
 {
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
 	struct kvm_ptdump_guest_state *st;
-	struct kvm_pgtable *pgtable = mmu->pgt;
+	s8 start_level;
 	int ret;
 
+	/*
+	 * We only need the pgt start level to initialize the ptdump, get it
+	 * while holding the mmu_lock. It's fine if the pgt gets freed
+	 * afterwards, we'll check again when doing the actual dump.
+	 */
+	scoped_guard(write_lock, &kvm->mmu_lock) {
+		if (mmu->pgt)
+			start_level = mmu->pgt->start_level;
+		else
+			return ERR_PTR(-ENOENT);
+	}
+
 	st = kzalloc_obj(struct kvm_ptdump_guest_state, GFP_KERNEL_ACCOUNT);
 	if (!st)
 		return ERR_PTR(-ENOMEM);
 
-	ret = kvm_ptdump_build_levels(&st->level[0], pgtable->start_level);
+	ret = kvm_ptdump_build_levels(&st->level[0], start_level);
 	if (ret) {
 		kfree(st);
 		return ERR_PTR(ret);
@@ -149,6 +162,9 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
 	};
 
 	guard(write_lock)(&kvm->mmu_lock);
+	if (!mmu->pgt)
+		return 0;
+
 	st->parser_state = (struct ptdump_pg_state) {
 		.marker		= &st->ipa_marker[0],
 		.end_address	= BIT(mmu->pgt->ia_bits),
@@ -211,17 +227,27 @@ static const struct file_operations kvm_ptdump_guest_fops = {
 
 static int kvm_pgtable_range_show(struct seq_file *m, void *unused)
 {
-	struct kvm_pgtable *pgtable = m->private;
+	struct kvm_s2_mmu *mmu = m->private;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
+
+	guard(write_lock)(&kvm->mmu_lock);
+
+	if (mmu->pgt)
+		seq_printf(m, "%2u\n", mmu->pgt->ia_bits);
 
-	seq_printf(m, "%2u\n", pgtable->ia_bits);
 	return 0;
 }
 
 static int kvm_pgtable_levels_show(struct seq_file *m, void *unused)
 {
-	struct kvm_pgtable *pgtable = m->private;
+	struct kvm_s2_mmu *mmu = m->private;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
+
+	guard(write_lock)(&kvm->mmu_lock);
+
+	if (mmu->pgt)
+		seq_printf(m, "%1d\n", KVM_PGTABLE_MAX_LEVELS - mmu->pgt->start_level);
 
-	seq_printf(m, "%1d\n", KVM_PGTABLE_MAX_LEVELS - pgtable->start_level);
 	return 0;
 }
 
@@ -230,15 +256,12 @@ static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file,
 {
 	struct kvm_s2_mmu *mmu = m->i_private;
 	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
-	struct kvm_pgtable *pgtable;
 	int ret;
 
 	if (!kvm_get_kvm_safe(kvm))
 		return -ENOENT;
 
-	pgtable = mmu->pgt;
-
-	ret = single_open(file, show, pgtable);
+	ret = single_open(file, show, mmu);
 	if (ret < 0)
 		kvm_put_kvm(kvm);
 	return ret;
-- 
2.43.0

