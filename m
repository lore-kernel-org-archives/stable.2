Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550842;
	b=xJ0vsTZv8NpzL0yriHioQvnvPANR46Zsoz2AXWUnfkWuaPgzlOdU+oYPmM3UNvbOSRJI
	 4SVPoPmIzHye14byHaMr9aaisPdRyi/4afrA33FOwtnu0bEfZJykfaUh051syq7qaW4gp
	 Z7WS97c2wGFfLjnW0qCnoFayyj1X8A9hWKzpIVU+eJkmqtvjZ2QskhMRaPE6IZeJPDpQU
	 pfv72B3/D5YApTB0etGStDb0M3EHBvdrlcNwl0w8LpN75q9gXVQUQG49GmrB5+IVNOfsl
	 +h4L516vD5Th3YC8WYju0aBr8HtrQdoQ7jaZ2UE459xsZuaorLzPTb5L3hl0mphHc7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2C93UiKAOXUB3tOivza+YaCz61WEDjXX0iSv8bO91c8=;
	b=5Jw6ELYwBQa1w6hBHnU1w3J5u4XLE6S3yvMCFf9//1dDycYPV7XoSlSgyfRCvNHgtz2Y
	 Zd2LGMDPX/gS4pPex+DJbvykva/hac3u2wXh4SoVaahJlSE1t3oBoAVm9AwvQaPfC/CJP
	 i1hO3NKQWV3wVOX5fWd+MOvcPM8uPyJvljYV4miva6NTx1GsrDt+lpOxxEFroNCypjowl
	 fq4RX73n1kyjAdA/qOEkFFm+6Wj6iDorxp7EtZ6wLBY8NPa/JzE9fQLHqYwAyTgIEDwiv
	 DnW9p7CknVgcV7wZ2v8aj2JKdNLmz7LtMZbhesPLss6Lmn0nOm4FjZpMjTF2KIvIyag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NBGCiMcW;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B1606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 341B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NBGCiMcW
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd67466211bso127314a12.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792550842; x=1793155642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2C93UiKAOXUB3tOivza+YaCz61WEDjXX0iSv8bO91c8=;
        b=NBGCiMcWXxiga66XUt8cC4LzDa9nwteGFbhRAXhvFSfdvhNAkSBYhonsIS5zOynzhJ
         TL1CODGa9YCuCBWo6amKECGVQTvO/7NfpvvV/J5hQ+UsBc7X1nVFr1EUBarHZtrmIjrX
         Pb03gMdCals1OaFb1vxTCfvjap7a3595iafxVaQ5itPFDU2rWnJJsK2ydH4U2TWulKgv
         0Yrg/l23GwZVL7COzmOc7u5RioXSmYKLuqd50jFTskhkvzduqXEMCl0JeFyBxweAKiFe
         JzEC9TGFXVTTW3ZAk1t9gH7sBHpK6g3b0S3TWjwq2sw4oIJCYsqhvOxMU07Jrlr/3dvH
         ++/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550842; x=1793155642;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2C93UiKAOXUB3tOivza+YaCz61WEDjXX0iSv8bO91c8=;
        b=BCmahEx8wCT1O7dPAq5zn97Jcv4eE86+Np4DnjQOxynMyTgsZNV62lcl34DK/HWV/G
         5ES1+a+/dfO1POu86a42dv0MwV+5o5qom9L0nbGtS7b1tnq6BWuessb217MmlA22998u
         vI+odWQ87XvdlTfn5c5cy3XpsBU+/93bF37oOAeg3wvb/S3yG1OalN631HsPLnWAMmB0
         hpnybD8pMRDQLxl5XVHvdmNiqaC0HxyJY9EhCRCOsCxFOOtlzzRpm0mboWoWbZ9nhDYX
         Va6yL9BGXbg03kNuhMTtqnyRl0oQCY72WQv7fRr+UcDFs01k8dX8/KzSiv4zP29DbSB6
         jLcw==
X-Gm-Message-State: AFq9FYJvjEfSpqE3L/5iKJrYR3lhhJlDiATfKNA8O1U2aTiwua8CDNP5
	lIrDwrHt4HoKC8covCjFiddXTzabLBHWr03i4uh1MZzsqp6Y30xwqqc244g0XX2YBjTJ3ClxHVR
	9fc8zNp0JkCtv+ntcv3uixdS12OlXCiylJoiTO2YZG5CPi2LXM4pPfs0E1dAm6Xo9nUI0muWkem
	Y2Y0vTOeaUyUvofvHxaos2w0k34vhMX5nJmXPZ
X-Received: from pglf14.prod.google.com ([2002:a63:100e:0:b0:ccf:d903:c14c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a21:b0:3d1:c99f:efbf
 with SMTP id adf61e73a8af0-3e287d241d4mr655872637.14.1792550841217; Tue, 20
 Oct 2026 19:47:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:47:17 -0700
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
Message-ID: <20261021024717.1734016-1-seanjc@google.com>
Subject: [PATCH 6.1.y] KVM: x86/mmu: Preserve nested TDP shadow page tables if
 they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 7a2c70e777a00c32ebafd376a6fe31ebb91c5b20 ]

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
[sean: resolve minor conflict due to lack of lockless aging in 6.1]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d7f1fbf8a83d..33e89555bb09 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2395,7 +2395,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 * avoids retaining a large number of stale nested SPs.
 			 */
 			if (tdp_enabled && invalid_list &&
-			    child->role.guest_mode && !child->parent_ptes.val)
+			    child->role.guest_mode &&
+			    !child->root_count &&
+			    !child->parent_ptes.val)
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
 		}

base-commit: 79807e970724c1f90cee1316361d61b80db4eef6
-- 
2.56.0.218.g1ec904b173-goog

