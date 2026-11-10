Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311298;
	b=4BdXiTYaLNPQU82qUClrcAdbwHlcrEsYhGQk1sjg7ds10ztd1MXARKZMNbiYk2oF/EJ7
	 uiXU2vPQYIo0E2X4hweUVZXT/xZApBc9onNijFLZRHzOfUXGOlnlLKYL6yqhI+capHED+
	 eT6MeT3tudHoZtSujg62NkEXtHZTVDlmmoEZJv4utO2UX9Py/UZKtjQkGJy6DpByAq0FM
	 HyGXx8ZZVOzA36T3He4fena83Erx9Iu1PMIiCxf7q47AD4qHGn75nEhm+AA+ZwRP3WW92
	 ItVrVhVK4PJVTS7dgghz8pCy5dfwUeJySSSJoGWWxbVlJdAmJbhmobNdld+iL4n70iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311298;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rPuq8HZwfQSj8hKo89LthqS8VkiUPAcn83ucvF3u10s=;
	b=zYC0FQwz+baxNz1bU0s2oV7KYwlVdbwoGmd8AdA38Pr6N6JJ+qjMrC2jMWwdOnxmbaf4
	 fYESxE9o1HA6HzS+VSRWVaJKc3a8g01wEPoQTyRSy2inl0O7w9d9QOlJbbf8ROWGcNg1E
	 ubOvHj3fqNF14caAiM6TQwh1r9OZXGymQoFVNJUzl729RQkmYSyfWpbn7FMmqseAm1R2c
	 NX0tvddtnVefNP+SFyb6hy3K9Re7omLjPRlDPlvpy2YCO1+EWob/kkyEca0hbnb0q+Ngg
	 qvFhtDJhnzs75pVJpG8wtnZD9vpb+t41K+xLljeCNAPs5YeiEM1TO3U/0bu4slsc2FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYMBlAWu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B4606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYMBlAWu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485DB1F0089F;
	Tue, 10 Nov 2026 11:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311297;
	bh=rPuq8HZwfQSj8hKo89LthqS8VkiUPAcn83ucvF3u10s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cYMBlAWuFPDHhNbrj2Q+gSJ9CJ1PcVigzeI/NZNhFDw/Fv3ufqr5f7CKyFHUxCwdI
	 Z+BSexOoKb623A2AduuC8A4HbdgYq6WqcZ/6rAvsc1rJaj4C/HpDxifI/zWQVF8FY5
	 rbNC1JLDGUfushl8Wa2e1yrZ2DLRn6lPaFWGPQVypO0zCk0NiBlblofWxREqH4YECR
	 M+1y7AAEPFJNQ0TD1JjYB6bwdNgnxoVF5YUGC0ZaMU0w3WaufOx66FqpeGRSBm33b4
	 gMkSt4OAFLJm8s6idbCcIIbU2A297vKuF6s56xDoXDXbbgMHKLNbqULGxCX1ZDRQXW
	 n6ze+UHqRZC0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei-Lin Chang <weilin.chang@arm.com>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: ptdump: Check the page tables aren't freed when accessing
Date: Tue, 10 Nov 2026 06:48:14 -0500
Message-ID: <20261110114755.606960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050719-failed-6.18-7d7199bdf77a@kernel.org>
References: <20261107050719-failed-6.18-7d7199bdf77a@kernel.org>
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

From: Wei-Lin Chang <weilin.chang@arm.com>

[ Upstream commit 7d7199bdf77a3a6ed74d0037133f435a7febe97c ]

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
[ sashal: copied ia_bits alongside start_level under mmu_lock to accommodate parser initialization during open ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/ptdump.c | 50 +++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index dc5acfb00af91..8e4966194be49 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -97,22 +97,35 @@ static struct kvm_ptdump_guest_state *kvm_ptdump_parser_create(struct kvm *kvm)
 {
 	struct kvm_ptdump_guest_state *st;
 	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
-	struct kvm_pgtable *pgtable = mmu->pgt;
+	s8 start_level;
+	u32 ia_bits;
 	int ret;
 
+	/*
+	 * We only need the pgt start level and IPA size to initialize the ptdump,
+	 * get them while holding the mmu_lock. It's fine if the pgt gets freed
+	 * afterwards, we'll check again when doing the actual dump.
+	 */
+	scoped_guard(read_lock, &kvm->mmu_lock) {
+		if (!mmu->pgt)
+			return ERR_PTR(-ENOENT);
+		start_level = mmu->pgt->start_level;
+		ia_bits = mmu->pgt->ia_bits;
+	}
+
 	st = kzalloc(sizeof(struct kvm_ptdump_guest_state), GFP_KERNEL_ACCOUNT);
 	if (!st)
 		return ERR_PTR(-ENOMEM);
 
-	ret = kvm_ptdump_build_levels(&st->level[0], pgtable->start_level);
+	ret = kvm_ptdump_build_levels(&st->level[0], start_level);
 	if (ret) {
 		kfree(st);
 		return ERR_PTR(ret);
 	}
 
 	st->ipa_marker[0].name		= "Guest IPA";
-	st->ipa_marker[1].start_address = BIT(pgtable->ia_bits);
-	st->range[0].end		= BIT(pgtable->ia_bits);
+	st->ipa_marker[1].start_address = BIT(ia_bits);
+	st->range[0].end		= BIT(ia_bits);
 
 	st->kvm				= kvm;
 	st->parser_state = (struct ptdump_pg_state) {
@@ -141,9 +154,11 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
 
 	parser_state->seq = m;
 
-	write_lock(&kvm->mmu_lock);
+	guard(write_lock)(&kvm->mmu_lock);
+	if (!mmu->pgt)
+		return 0;
+
 	ret = kvm_pgtable_walk(mmu->pgt, 0, BIT(mmu->pgt->ia_bits), &walker);
-	write_unlock(&kvm->mmu_lock);
 
 	return ret;
 }
@@ -193,17 +208,27 @@ static const struct file_operations kvm_ptdump_guest_fops = {
 
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
 
@@ -211,15 +236,12 @@ static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file,
 				    int (*show)(struct seq_file *, void *))
 {
 	struct kvm *kvm = m->i_private;
-	struct kvm_pgtable *pgtable;
 	int ret;
 
 	if (!kvm_get_kvm_safe(kvm))
 		return -ENOENT;
 
-	pgtable = kvm->arch.mmu.pgt;
-
-	ret = single_open(file, show, pgtable);
+	ret = single_open(file, show, &kvm->arch.mmu);
 	if (ret < 0)
 		kvm_put_kvm(kvm);
 	return ret;
-- 
2.53.0

