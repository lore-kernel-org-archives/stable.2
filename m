Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046042;
	b=PLZAjgomfgkk6WHy4VvdAWSwbKjbLc8GYndi7juKTeXRz7ZAZiplnwT1FHK3F4QOoss3
	 8u2r7p6yl4KPXCyjoMpP6g8CsuiTanJV2+bimDOFn9jgypqfKDNr7/JFHf+3wXlYhPRdJ
	 hsdhue8Fy/JPoMbtLTjVfjkV7QnDqDdE1CWpp/oXW+FJ9TIN7z8Vrq9s17zPVzB/nxRso
	 8Kk+t5zvraJaSOtX3WHhNHXRN4uHpodYTogvhb1PYp/EqHhyT0nkLzPxsbt0bXa2xFDzN
	 RnuAcULlLCqnnHUwxu4+zSqwWE3GF4p0lexNT/5zVTekDZq0teZMuAxY9N2S1o1C0wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8TJOsNe0VknxuEyhFpmlsaOaqv8ZhxmO7iLpcOPm5z0=;
	b=K54Xt8/g1c59SK1RqkSnqPifahpgbJHtwV6QugWdKxgiIg9pi3/eOW2zToz7EEgccRvA
	 YGjDj9UiYDxSsRWLtlyNosIWzUI9Vod1Gt37I1fCqcv+bwS/5vKxmCf9U8/qBI0UsLxIq
	 1+9s1TWof01agVDVshdOTYtMX75GWU2D/E6Y7MQPgmTavuBeWR0/3RacV2w/B9eIyC5Ge
	 VLFZKt/oQEjjX+03oHyv5uU3SItHjYtqXZRBaeKBWbFP2F8wDio+0JQsgJZrkqrf1CNWT
	 d3+Ly3WwUOXTn1NK+xcCVtf3mgopa/cu41GMUDXeVg9A8+G55s+HzkN1tLKJhBUhKCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrEyIOS5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE8606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrEyIOS5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B071F008A1;
	Sat,  7 Nov 2026 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046041;
	bh=8TJOsNe0VknxuEyhFpmlsaOaqv8ZhxmO7iLpcOPm5z0=;
	h=From:To:Cc:Subject:Date;
	b=MrEyIOS5khmJV/U51LY03fk1uyFT5uj7G3HrgVOLqh9P9oG2skp9IThSfHg8M6liL
	 OgjACH0Pco60QvcLTFP1LvFtgZEvf0fbf0ExelKrhhShXOKJ6I5VI7B4eCdN2VhXAl
	 mVTuMOVDN9oAzJA0tut8QSnH2vU9AWmmIXX5tpN1gg9kgQ+bAIAXOPRnCWaFoxQGVW
	 fIWFvZQAWd/+tLVWRB7W+rIHPQIEoRvjV6IDWIceYIpNAWgHGuSXy925CFvIOLfw7A
	 jw7WS+M65zEi2tuENOQTW0/a/puUgI6hdmZzxKZIcY6qgUYFlAJdfJUhuqTIwoLnFv
	 hL5cS1Gf/5dxA==
From: Sasha Levin <sashal@kernel.org>
To: weilin.chang@arm.com,
	sashiko-bot@kernel.org,
	vdonnefort@google.com,
	itaru.kitayama@fujitsu.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: ptdump: Check the page tables aren't freed when accessing" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:19 -0500
Message-ID: <20261107050719-failed-6.18-7d7199bdf77a@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7d7199bdf77a3a6ed74d0037133f435a7febe97c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050719-failed-6.18-7d7199bdf77a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




