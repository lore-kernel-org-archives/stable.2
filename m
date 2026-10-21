Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548751;
	b=vWv058wWquiiyuInYMECu5uDF4nUvnLvszZyUHE4i/LBlfau3KBi2+xZC6bvbVja7Nqn
	 2sW+bMzUuvOlIbqaOjdfj6+mlGxvwpsWz6KD52lrBev4RfZYmYRahBYUSmYAqZXs1V3Se
	 rA8tzug7wHUBG8/JX0yhoZUoTYLUCLZ0n7Yz8ePfb4kwIqvT/FRFHICxnxeKXqFHUUNWv
	 9yvUfNCls39ytlAgodU2RUM7Ll7oYWMI0OZSWMKW/Tl893tRfitrvNaLDqQxcUGwo7YyH
	 RWduIzW5gLxrhkB7ucmmlCTPVZIvdWt3eoSOfS7+Y+Qy/AkoP1x5tg+CJUvaZRaP50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LM3zXXEyrs1k6iikZyGFv5HI2GOa7cTFeTDBek3U1qE=;
	b=CQ60pFxid7IC1tlgmCp7GJ3K/Lw5swSyasuBU/nPNebYCpTY7tqfA+zTBNv92WGlsgpq
	 XPGMMzF8bEKIVor/x1/2qA2AJKF8VTRrA6fd2AzWpdqxL10n8oXf3bg0SZlTvgxaAlQr3
	 uQxgXMY9hzuQMiFMdpH3hcWpGFf4VfFtEW0jmNnj1xEWxQyRpCvFsPz2omRyugedSvW/Y
	 5eZYE+aNkFiptB33/68Y0Bb2Ly/u/NXn4DJvuetROSsfAGzj8EX1ht0nA9KLhQRlM+7XN
	 wCjeB+wMyNz0IhiwVpJzEYtlocFk39yqztyancan8aqt9UoMlM+fwOKv27nIkxb3fgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fMu1ySdm;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2490606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2490606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fMu1ySdm
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso414658a91.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792548750; x=1793153550; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LM3zXXEyrs1k6iikZyGFv5HI2GOa7cTFeTDBek3U1qE=;
        b=fMu1ySdmKczYVurWwRxucpMNpuFCzKTBtLPq1eOEyqTkETBtmQwuLv0iM0GA+FQbfD
         tiDfoFf8jXxeEl1PBK7MWgBoKp3C68m3EyMvWhzkfVLH8W941S8H8IOZv54egwQhxV2a
         zNgOnb9IoS3+PR7ankyuxnZZUknQdR6kX+cRptdznh88kvpg4AhAfOucETHRan9RV3DN
         acY+ogOaCktWPGKQGEmGYpW3xhSrNlVWwWkhU8c1VlaACVeKmkb4L2FN5reRGRnV1s/j
         +H9jOTK36MO+3buvLjxTi0pzlgsfIO9TmgPajhbAYDIOj58VjxZnpicWAIfuFhdnDXJ0
         d2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548750; x=1793153550;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LM3zXXEyrs1k6iikZyGFv5HI2GOa7cTFeTDBek3U1qE=;
        b=ze+qGeY9eL3KrWeri+Ue+UAplPuyuzrdjnVTWlrj6tcA2SSww0reuAOmFPV/VMoC2f
         nCK3QgI5vXjSr18tjpVVMaod3oil6ENJJ5yWJmISMmSMS4vnEQKHP42f/8Muwi8YX/lJ
         v81/Z8fFYDJEuVF3R9hiwwfEYdVuxQRPjzFoJpreWwskLkjRvYe4eFyTvu5KAeirGui7
         C9r+DWPzBEzYKuoIu1Qjxn5t4CMHtNkdoSOSPMgMliI7AmTi5yI2kzYaM/GCe0eTh3O7
         DRO4q0NxqPFlkn8KXN4LH7g/51sng7TjaItNWnxK6IehfIUNCtRc0lQIjFMmFDQI62QP
         zFXQ==
X-Gm-Message-State: AFq9FYIdJDjwZuCdXHUCD6SWeNbP17DLB8wpFJHXIofhBLr4K7sqZpnN
	0LQIXNEf+BT3t3Gulvo06aPCGZj4tEjgB0R7HqAj5a90U9jg18DVIlQUu9o+15w5pe79pvkabKv
	xsmJlPIXJmfi6EURalAzztmsyYJ2TWk/7K8SL1iOYR+SlAoC8eO1I5/gWiiUh6PhV0nTHJ6Ko5a
	WL87lvPIVKPAJWZ6Uvih6rELezg0HUj7db+Fc1
X-Received: from pjbhg5.prod.google.com ([2002:a17:90b:3005:b0:3aa:ab59:7e2e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2786:b0:3ac:acf5:6daf
 with SMTP id 98e67ed59e1d1-3ad8707bffemr601484a91.66.1792548749874; Tue, 20
 Oct 2026 19:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:12:21 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021021221.1703700-1-seanjc@google.com>
Subject: [PATCH 6.18.y] KVM: x86/mmu: Preserve nested TDP shadow page tables
 if they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

kvm_mmu_zap_oldest_mmu_pages() excludes a shadow page whose root_count
is non-zero from top-level reclaim, because such a page cannot be
freed. The path in mmu_page_zap_pte() that recursively zaps a parentless
nested TDP child has no such check. As a result, a shadow page can
be zapped even if the page itself can't be freed; as the comment in
kvm_mmu_zap_oldest_mmu_pages() notes, zapping it will just force vCPUs
to rebuild the page.

As in top-level reclaim, do not recursively prepare zapping of a
nested TDP child whose root_count is non-zero.

Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 205d314a7583..1fa251ca4dcc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2630,6 +2630,7 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 */
 			if (tdp_enabled && invalid_list &&
 			    child->role.guest_mode &&
+			    !child->root_count &&
 			    !atomic_long_read(&child->parent_ptes.val))
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);

base-commit: 2ff600d29ee478d0a8d46ef8a58afb5e038fe692
-- 
2.56.0.218.g1ec904b173-goog

