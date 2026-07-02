Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7A480DD1
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996585; cv=none; b=uaQeAUcjOx2daJ6DqUsC4qGIOaHM0uw5vKBFpPYxKedtFu3dmbyqVPhVUmJ5i8fe18nt8uoKsxn8lcHkGHxVxMoCoxlXL0sIiVOFGZD1XF+LX6biGtHOLgZbUWmhFTF4KwW7fxpIW/XXa5iPv7uVU5BnwzjFh/Y8WSXwI0N6bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996585; c=relaxed/simple;
	bh=Y10EfEGAVwSCLHKFgAVZhIL4XWl2G2kvVFwnSojvSoI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FAcvhLJVqHhMZNrOI36Qj6ruuESNyS8PBLoFDIt4Airl9KLzqSfDFeiWwaNOuAl653hnevLWCAz3b+d9Onl8ewqmENNVxThrfMBuq4T/FLQ+Lhzqsupm+W38CgCG72p7BySznEVmJO30Cd9RLrqddGnguCOcrsSx7uPm65jiOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oxist6w2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oxist6w2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A311F00A3A;
	Thu,  2 Jul 2026 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782996582;
	bh=SUMSS9O6pHP+mAyFa4rK8wXUdw+L79dwSiLhSFGUL00=;
	h=Subject:To:Cc:From:Date;
	b=oxist6w2IzbON9GUiJM4CketUCODruw59W4k2j3QQDfF3Msfo3IUiHRMD6P1fFUto
	 SN9F3uVnwvsXcTmqUH7Ulb81Fi206flUGfdDLcbhAZOdw2xaJvCluy+VkmiI7nQyFX
	 ysBCr6YO0W5hMc6M7DuJVvF/rna/dp+IROO9uaqQ=
Subject: FAILED: patch "[PATCH] KVM: arm64: Omit tag sync on stage-2 mappings of the zero" failed to apply to 5.15-stable tree
To: ardb@kernel.org,catalin.marinas@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 14:49:43 +0200
Message-ID: <2026070243-buckshot-awaken-ece0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2986a625740599fe6e7635b0586fed2a95bcd1f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070243-buckshot-awaken-ece0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

