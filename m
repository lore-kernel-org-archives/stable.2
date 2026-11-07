Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046667;
	b=J3AcBjBJdxBrwxt/+DB9YJPPgcQnLBSCjp6zn4ER0PlKiXEpA3ssp1k2hQQCT8MKSqLs
	 auj+O7B9ylkAPV1A7qjSnwzGKq96DB/OlDo4q4aetv5SmM/kQh6B15dxWjWZQcxxDxsxn
	 THE9BC10/88TuLb24lbLM2IjioVbQuVaw2QefjHRXBGM5cyMnEp/oiQe4M4ADFZtHsJT2
	 XB6Tg5cDyi3dwv6KiB3nA4fKJ+G6QfcscZp0Q6oXtLR14rpyuv3GwrCKwCJmiw/ZuvBe/
	 zQLtC8yaMQVjcGJPXkp3xCs5G+JgS9gj9imIYb9RBq4cSEecVzDT0BLkXUpjoMF5jRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046667;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+u526MVZ80KW3WebeZlyo2R9AOCNgmye+oAPudrqwIY=;
	b=fIpbBs5K+GTPYv6RYInrQAiR+fIye54vmZw0nQUf6+bKG1Bhm7JMtvkNXvtwMs8YVW0e
	 EZoRLW/17+ur7Od33aZaIbKQPjFv68XHe5D+jli1FOIEB3zgLm0f9zWHLMRwkVhxTb8C1
	 N0e8HtZPlo7yzyFdU5WNIwiUvuNR0dGpTntm7NFtxHGQlqZbpHKvoRJvA3t91mM4VhY02
	 ZQmTcwgJjAQx2r9amRUiU86LWHytVof8skrnrpQEGfhKbwbUV8oCEiPY0mONN4IHkHTJj
	 ND9wycJd/pYXbq+gFDyCPQCh++6+EIvLU/5y60KnBGQ5+/ezQk8ldn04VeOgI8P+Tww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xk+vViBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C2606D807
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xk+vViBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655961F0089F;
	Sat,  7 Nov 2026 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046667;
	bh=+u526MVZ80KW3WebeZlyo2R9AOCNgmye+oAPudrqwIY=;
	h=From:To:Cc:Subject:Date;
	b=Xk+vViBCXmqJpM+pUWAVSts2LVeqGpUt3J8gwoKvOBqLWD7j+PBE1fBezjJnClPJD
	 08APiFnur8TNKdpgISH1oKuKaT/KG6A3jgJlUB5BuOPtXYgspNwmBZZqWhxZAua8hf
	 nQyfAXMWFvGseAnz2ueKDSCeMBm3rCM3mcIkpcANJniOvDZlDPYHLx9LkP4AUqgKaZ
	 rjcYX43Rw7sOIjk7Nrb9jQlZxsi4MlvAXBIbyUvqQka8AnmWVPj//2rSo1T10d84rj
	 k+rQ/Nq1fy2cs/8zcakytn2yBUhVoYd8RbhyGTaQ6qUePqDu9k/rHFWuyf3UtpaeBL
	 Q47Ikbig76ZOw==
From: Sasha Levin <sashal@kernel.org>
To: weilin.chang@arm.com,
	sashiko-bot@kernel.org,
	vdonnefort@google.com,
	itaru.kitayama@fujitsu.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: ptdump: Check the page tables aren't freed when accessing" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:45 -0500
Message-ID: <20261107051745-failed-6.12-7d7199bdf77a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7d7199bdf77a3a6ed74d0037133f435a7febe97c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051745-failed-6.12-7d7199bdf77a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7d7199bdf77a3a6ed74d0037133f435a7febe97c Mon Sep 17 00:00:00 2001
From: Wei-Lin Chang <weilin.chang@arm.com>
Date: Thu, 24 Sep 2026 10:49:50 +0100
Subject: [PATCH] KVM: arm64: ptdump: Check the page tables aren't freed when
 accessing
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
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260924094951.727352-2-weilin.chang@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/ptdump.c | 43 +++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 69899797dbad8..b5a0584260e8b 100644
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
+	scoped_guard(read_lock, &kvm->mmu_lock) {
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
+	guard(read_lock)(&kvm->mmu_lock);
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
+	guard(read_lock)(&kvm->mmu_lock);
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
2.53.0




