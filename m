Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3C480DE6
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996582; cv=none; b=AmWKV3J61dodpg6rbo1QxFW0hXcRj1/KTkNNn3q8XIlqKtga8p5DvM8AGIPXsoiYUbJeln2v9hxllgxhMn7NUhUKZedLYjeEyB3+lwZc8h63GoAsUwfz6PoFme13JfaqF0cbnNlSm2LDR9Zu373rgUoMpchKvcAKelq/EufyNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996582; c=relaxed/simple;
	bh=8Jo5H5/MwOSUkFaV8lR/tYmuCKlV3kdZyHOXkG5l3zI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pK45TH93gmxpCyGURBZ+nScmUzNOdBZ5LNZ9LMd3mIy7LxuR7v7h6wwOvXDlzmwj2uqY/dVTz2YfHt3+bAbuxXsI2ST2YYsFBlDelJzokEfwecO8B86CpsayDRWw9q/VJaQszKPzmXiAHbaTj8tlNr7DDlIrqWtL9ZbrDboS+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AcN/PnzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AcN/PnzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F881F000E9;
	Thu,  2 Jul 2026 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782996580;
	bh=wSj8CP+Y7TP/ZucsbboY/zI9nrgdJKO2XSfp2bacwGU=;
	h=Subject:To:Cc:From:Date;
	b=AcN/PnzAXMBd4Yve7ADCVsYNTo/LcneX0vaFq4TLo9xSMMJ5C1d1RMwKAh9ngKf2P
	 8rSbY/rMbE3jdM8e599HTC8+azDbwioEzo0fHfG8JakfFfZ3m6iG7uVkuYY/RI09lt
	 5wtLod6Wrg4vbVDTKoKtACD3S0E/ITASWPuPRaF8=
Subject: FAILED: patch "[PATCH] KVM: arm64: Omit tag sync on stage-2 mappings of the zero" failed to apply to 6.6-stable tree
To: ardb@kernel.org,catalin.marinas@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 14:49:42 +0200
Message-ID: <2026070242-getaway-aneurism-719a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2986a625740599fe6e7635b0586fed2a95bcd1f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070242-getaway-aneurism-719a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2986a625740599fe6e7635b0586fed2a95bcd1f7 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Jun 2026 17:11:56 +0200
Subject: [PATCH] KVM: arm64: Omit tag sync on stage-2 mappings of the zero
 page

Commit

   f620d66af316 ("arm64: mte: Do not flag the zero page as PG_mte_tagged")

removed the PG_mte_tagged flag from the zero page, but missed a KVM code
path that may set this flag on the zero page when it is used in a
stage-2 CoW mapping of anonymous memory.

So disregard the zero page explicitly in sanitise_mte_tags().

Fixes: f620d66af316 ("arm64: mte: Do not flag the zero page as PG_mte_tagged")
Cc: stable@vger.kernel.org # 5.10.x
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d089c107d9b7..445d6cf035c9 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1479,6 +1479,11 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	if (!kvm_has_mte(kvm))
 		return;
 
+	if (is_zero_pfn(pfn)) {
+		WARN_ON_ONCE(nr_pages != 1);
+		return;
+	}
+
 	if (folio_test_hugetlb(folio)) {
 		/* Hugetlb has MTE flags set on head page only */
 		if (folio_try_hugetlb_mte_tagging(folio)) {

