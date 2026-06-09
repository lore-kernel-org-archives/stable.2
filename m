Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171153C769E
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990813; cv=none; b=cmk+/VMv4quodX9/W/aIE6jMjPpzq68pkxMy4o3wfWVEdCTVVwgVwRmzfd0V9Erzw5NhavHziwx8TUu/hDSX/BDwF1pp3IoiubGt6aIAHgeeUblPNz4jvY0GfgTwuDo5QEPlUqtxO7GpVdlDvK6Q446vwkDcF4CGXdH8EKLWBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990813; c=relaxed/simple;
	bh=oqyGzUWHdL7d2s+OWF5ICpmFkeu0PGA38ZPf4E3jhGA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RabOT/r2dtYTXDDlSqA25WVg88Av8pCfQzKT6FfpPmoJD3hCD7y0V5CF76d1i/D+6fHVes8Dn2gQNQmCmjdnZACJ3WH78c8NfIlP16XOACMQQ85/P4194K1ZUP8rUdBgDFCFarjZVWrCgTWsy5z88JRAoanyh7VQ+LCAi9pA/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s08nsFED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s08nsFED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415201F00893;
	Tue,  9 Jun 2026 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780990811;
	bh=bCIbHuLw4PkJXq9z2JhgFOAbX3JJe9ktCBuwxUVcZmw=;
	h=Subject:To:Cc:From:Date;
	b=s08nsFEDDlz9ZQkJxyez+5ygjtQkIkSYArE7ZDoLFjF/vSEoHJa/sVLErqxFt08wx
	 FBrdVbw4clTql+0vOFdPO/K3kDivttduMSEu3/ZmBuCHRXdIMezV0I7c5pOMj09avK
	 HikBfPZ79qmV1i0OuAJU2q5VhT8xn6YILacJoOzw=
Subject: FAILED: patch "[PATCH] KVM: arm64: Reassign nested_mmus array behind mmu_lock" failed to apply to 6.12-stable tree
To: imv4bel@gmail.com,maz@kernel.org,oupton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 09 Jun 2026 09:39:13 +0200
Message-ID: <2026060912-erasure-visiting-baeb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 70543358fa08e0f7cebc3447c3b70fe97ad7aaa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060912-erasure-visiting-baeb@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 70543358fa08e0f7cebc3447c3b70fe97ad7aaa8 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Fri, 5 Jun 2026 17:27:01 +0900
Subject: [PATCH] KVM: arm64: Reassign nested_mmus array behind mmu_lock

kvm->arch.nested_mmus[] is walked under kvm->mmu_lock, including from the
MMU notifier path (kvm_unmap_gfn_range() -> kvm_nested_s2_unmap()), which
can run at any time. kvm_vcpu_init_nested() reallocates the array and frees
the old buffer while holding only kvm->arch.config_lock, so such a walker
can reference the freed array.

Allocate the new array outside of mmu_lock, as the allocation can sleep.
Under the lock, copy the existing entries, fix up the back pointers and
reassign the array. Free the old buffer after dropping the lock, as
kvfree() can sleep as well.

Fixes: 4f128f8e1aaac ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/aiKIVVeIr1aAB1yp@v4bel
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger,kernel.org

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 38f672e94087..6f7bc9a9992e 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -89,21 +89,28 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	 * again, and there is no reason to affect the whole VM for this.
 	 */
 	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
-	tmp = kvrealloc(kvm->arch.nested_mmus,
-			size_mul(sizeof(*kvm->arch.nested_mmus), num_mmus),
-			GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!tmp)
-		return -ENOMEM;
 
-	swap(kvm->arch.nested_mmus, tmp);
+	if (num_mmus > kvm->arch.nested_mmus_size) {
+		tmp = kvcalloc(num_mmus, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
+		if (!tmp)
+			return -ENOMEM;
 
-	/*
-	 * If we went through a realocation, adjust the MMU back-pointers in
-	 * the previously initialised kvm_pgtable structures.
-	 */
-	if (kvm->arch.nested_mmus != tmp)
-		for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
-			kvm->arch.nested_mmus[i].pgt->mmu = &kvm->arch.nested_mmus[i];
+		write_lock(&kvm->mmu_lock);
+
+		if (kvm->arch.nested_mmus_size) {
+			memcpy(tmp, kvm->arch.nested_mmus,
+			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
+
+			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
+				tmp[i].pgt->mmu = &tmp[i];
+		}
+
+		swap(kvm->arch.nested_mmus, tmp);
+
+		write_unlock(&kvm->mmu_lock);
+
+		kvfree(tmp);
+	}
 
 	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
 		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);

