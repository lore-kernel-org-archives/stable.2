Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DC4EFFD3;
	Mon, 28 Sep 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613904; cv=none; b=W+L2HLjM+hgV4vwAWb1kqRvgwz7E8edS48GIITGhsz/celgvyupb9/fZtZjf6dpMMvtp9VAa7beEihndil58ayOISm5cBUtX1iwJ27cfyrwLGzz2eO36mYD3bjIB8UROJYu5RXExAvq1xyCcjm79VhTzV60CuFy17j9ag6q47L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613904; c=relaxed/simple;
	bh=AKfHvxLLirt3cawUOFYry+ypxuH5o/0PwWfjxgKgRp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzGjFvrJOAxjNyYWIswoSLl4xm2aFLA8PtB+iP2P++vb3aBk51Jim9cuXU0a21DJt9w7FXu1FjLnev82Q1nBQvYbakoSOqael5KzHLJNpCAkPnAwRWLpJOMETYabzfgBexvnKCWHu6BG38Ix/6ubSnVPiGKWG8GAapISqKbSAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=qY0wSOhQ; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="qY0wSOhQ"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNp080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:50 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=tB7ZuGX+nKWVkPgylIWZb8HlxfExf1xZ2KYg5VteNE8=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613890; v=1;
        b=qY0wSOhQHL+GQTMKgygjLcHx4K34MJrBxS/I5n1xUHWYQFbyj2JwoGWQfmiOL3uL
         8xotRc1WgLfiCsBKrLBdQgnuYSNIuhkBqW9Fb4F5nbW27da5PcrIIBA/K/7uUoJJ
         b3sCGKFJLsNl77gtpIxJLEJvXjNoZ8elJ4B4CuTSVR+Ufk5R4Cs/A4d3MqQkJa8+
         q8q8WeShTLOf7Tjj6i/i/P7laGaP8uprnzkWIObHnfu5mDGDhBUV2dyjR1wShQ4P
         FcM9A1SErKgVhEYRthyUa67nP6dgLxzvz9G5Oy1E6c8jt7f/KE1WIzjY7+yw7E6E
         FEKkaWt2qB6IJFdKek8M9Q==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 04/11] KVM: X86: Remove useless code to set role.gpte_is_8_bytes when role.direct
Date: Tue, 29 Sep 2026 01:44:20 +0900
Message-ID: <20260928164427.4699-5-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit 41e35604eaff2266ba8523787ebe99c5ca4c4045 upstream.

role.gpte_is_8_bytes is unused when role.direct; there is no
point in changing a bit in the role, the value that was set
when the MMU is initialized is just fine.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Message-Id: <20211118110814.2568-14-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9f193b1620a9..f6ad81b5e637 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2093,8 +2093,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	role = vcpu->arch.mmu->mmu_role.base;
 	role.level = level;
 	role.direct = direct;
-	if (role.direct)
-		role.gpte_is_8_bytes = true;
 	role.access = access;
 	if (!direct_mmu && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
 		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
-- 
2.53.0

