Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1C477E58
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488580; cv=none; b=SUFxytapK/6HjAubWt75T65e6WdEk/OpARn0RUlDBZtUHhpD3as2sriYnKjSnGy7L7Dy28ZPP//zqu3NEd3DG6veAOEiHK59MOUNnSuQbkTMCEBzbXNjQAtqrpewb6ui9ic6mHpMJfGW+dHq+VGuZ4I6Wg++c9Rretu5FW+3mxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488580; c=relaxed/simple;
	bh=3GWDWLWCMXc+5OOno8Qwns2iSCPZvQEoDk/ip8tJyEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kqTaskGC8tpLanJQeUmHvxHBVguBefqPtI6rSZm4qhd2Y7yiRPCUd0P9uW9JUhJ6GW4FfM0y6gorZfsLNxg/NZWCnti2wM5HElBeaz/3+YICjkBSp5+8fQtGQzr2i3QWdTC9WBAmDtS0gimxXWIvTCPQYqIP0h+iXc95JlJPqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8zAmw7K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8zAmw7K"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0bd02d97eso42847715ad.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780488578; x=1781093378; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtMTRcfS8t3A0zoUtO5rbb4BAKaZHdusERWAc+kj3aw=;
        b=Z8zAmw7K/cgDJoubb5NhTGVFD5aw/jelvqaW53zradCGDQkpjA4CEt0vD8pbKp6rzw
         uBA5yT10fZw/IONwFINNRxpTtIZffp+bmTT9EyRDIm9F9Ua8rV32KNewIaW8E8eq1WI8
         20gzqh+6Gr3r/+tFOw3jfZSrnWJGR4yxPChQtBbxXY57U4FG62p5nMd/XGNwbMQox2IM
         0enVl5B/alijGhYYfTOhzjct5NJ4IOS7Wh9+Fzb03TwYJYcOQ+ujWZBtozwCojCHRxWC
         tIsPKapx1LTb3CjH4MLYeoVfmMetEQhzMWVBTlE3NwL6PeiDOkZEuXvP06n8cQKXRspX
         0NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780488578; x=1781093378;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtMTRcfS8t3A0zoUtO5rbb4BAKaZHdusERWAc+kj3aw=;
        b=PAJ9YA206w7LFc2fXVK5BgEJTiU2ciLfGvdJ+SMMoY/tX9Pr69H3sjqvngTku2YMis
         xdBeOg7FQiY3xK4e7cBLYw8iIs+GvDfdcd8mPSS8B8vaMX4gOd9TXKLnziQNxHU5i/7d
         itHCzAAzRiGY5F8Qnz8zh2H7PlJS4JuFJK/rIhAJ1NB3TIvWQvZhWYVjikwyD3AVGkze
         xuXPXyjqIhSd50gN70BK8UKHTU/o6ZLyZlDKrsMvKx7Oys5WLaAGldXfKQy+r480Zv8Q
         5a5SYU3BQFnAeAxsvPwYeLs/TVSe6nIQXvYUuDl0OgsHKNMF1ov4dtZtLmbGlOf3W6dX
         cBRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+a7bxMhCexbBvqqF/8Fi6aqy0EsW5q9OE4kOKVUmH5oSeuJYfZN5JqKmaiKyOB2Km5+tXrjFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1pGLvblrqrBH4lv4wNo849xuhHG6sE8z2YtzYG1wcCsRWzzPq
	dtDy/U4ELRvf3zrIKYLgIbx3o0gcaCGtbQ10hGFppMW+pv1pJ2rUBFah
X-Gm-Gg: Acq92OEiUq6IsNEkLwu3P85p8z04RYocd7gQCOQD8X6ikmA9FmwmK7r4sN2yQ0WVgFt
	+fL8kIqackXP/oR5UcpzAWSxCEPDiRO1ZOFoNGSMmvTDqzlpQFdIYUWLHtH3IOXHHRHmD0cxlhq
	XA6FRLo7QcxnOG6zMKEqIAuv8oLmjCSkQTwHMwIX0oZDiYOBn8Obwd1pYMUbQjW5cbv88tnPdgP
	GhaoBSPloySbl6fkXodB1pmocckbhXIddXfiRu7vhAgg8F/Ovi01e6m+V3i1oaineBMFkJQ9cWd
	nHgQWphDuwLSYmLNpSH49cSq3CCKK/tUEFgLhCdXtlPK8ckndXdV/59ATdcpe/aUFsl1cUNW0qN
	xSG9oztlDzdNU1GHrW24laXxCpZ8/rR6SV7S0kAD+BhkIS6/Jek+fjkcfkdjG05Wg7guHfFstpz
	ogx1OsWQpM1+qh1JsA5D+ezMl9pJlYtY2+PX86B1fuV+bsfxBnhKGtSA==
X-Received: by 2002:a17:902:da88:b0:2c1:69cb:441a with SMTP id d9443c01a7336-2c169cb4529mr27294735ad.18.1780488577735;
        Wed, 03 Jun 2026 05:09:37 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfb4sm25082855ad.59.2026.06.03.05.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:09:37 -0700 (PDT)
Date: Wed, 3 Jun 2026 21:09:33 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] KVM: arm64: Take the SRCU lock for page table walks in
 fault injection and AT emulation
Message-ID: <aiAZfdeyanIvP8SD@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

walk_s1() and kvm_walk_nested_s2() expect to be called while holding
kvm->srcu to guard against memslot changes. While this is generally
the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
respective walkers without taking kvm->srcu.

Fix by acquiring kvm->srcu prior to the table walk in both instances.

Cc: stable@vger.kernel.org
Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
Suggested-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Wrap only the walker calls with scoped_guard() and move the injection
  lock into __kvm_find_s1_desc_level(), as suggested by Oliver.
- Reword the commit message as suggested.
- v1: https://lore.kernel.org/all/ah7_BAAzHggzdZeI@v4bel/
---
 arch/arm64/kvm/at.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 9f8f0ae8e86e..889c2c15d7bd 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1569,7 +1569,8 @@ int __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
-	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return ret;
 
@@ -1665,7 +1666,8 @@ int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa, int *level)
 	}
 
 	/* Walk the guest's PT, looking for a match along the way */
-	ret = walk_s1(vcpu, &wi, &wr, va);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = walk_s1(vcpu, &wi, &wr, va);
 	switch (ret) {
 	case -EINTR:
 		/* We interrupted the walk on a match, return the level */
-- 
2.43.0

