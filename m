Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550966;
	b=PovZT47Yaqxj94GwUZ07hgK9IbdGffQW18iEJbNV1B43yTeIqnwWdeMamYK1VDIURdW4
	 o3yPPZHww9zmZe8RdfMAMnpaCPpT6lvUaZBrLQPhxwXBebbbK6QYNjBZpl6yCmOvPmk6z
	 n+CBveOUTGPs4jaXZZ62flIuAR+oDnVN6a5fUjIMfAgZB4k7XGwDU+SfvUGXz+DKRjcNR
	 oBkN6I9HwMBLTDbLRC48bWTikEfE7IrthmhyQWNWw4tEMnNMZb4Mntxta8znt5UryLFtB
	 v/vLWH59J0LHSBMfHcGIduGUbZRuAMKb/a3IkCgrwL/xxf0fgR96zVhttN8r4fbkfkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gSnH3fXxTz7HmVcM/xtbhh/4LxD2ZgAsSDglyoF9vfI=;
	b=uAnlDIs9/1Vzh+8mRFJtz1p9XYKKwYYV5SIR4IH1suzm5OYlJVEkt7jmGmunrErgUw/v
	 NJumVDRiXw8isGvIonQ3ybsLqRi1p7oCkXI90DJsEiZi8jNcRFWM3u5abPE73F12qWUhr
	 RZennAsBItR5f4nq/CUYU2tZm00/dZx8hgUUsbO4d500Fnq61eExVx/yej+UvL8bn2Jrw
	 A7PP2gdtOBReifekJSxFszABPqc+8ZCKvNCnKw3YVMNvb5YEZsWpoVXSNhKqm44f3Tzl4
	 hOXjT1gmyMplUFCxm8XU2ZOz2Up5hBZt2WBCW/8i8CD7b8d3L/qPm13yJLqQ0YgGLfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AVzps8aZ;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAA606A31C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBBAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AVzps8aZ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so336206a91.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792550965; x=1793155765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSnH3fXxTz7HmVcM/xtbhh/4LxD2ZgAsSDglyoF9vfI=;
        b=AVzps8aZMOfSNEwYwjdNhFacax5Vdj/VHOahl4IygNsW61gBT8xQTISXu+5F6j8Dv9
         yFcHnokOKCNvA9JHNaSnT21oUxJUbcoPfgaMNAK/pRbqf9NU3Z+AmXJ3HPaNAr6DxPiZ
         Fy0Cl643FDTLOINdXaRELtwJKqeoRyXvdxi/ORDZlZrNQo4/Fhj5aJqkpdp9kL3WSCSA
         ofVeoYM8THlD3O+GFtOfHP/kZe7Z9cYlKzzUJe0LjFJfsoHaFiqcDX3x968OT40fjWzZ
         WsdP1SqRj7RQhtmTKlqmu7xl1Sa5Gb0r8wt2R8ejQE8LXCEl98DtkewNk7VP+JHEhxqo
         0SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550965; x=1793155765;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gSnH3fXxTz7HmVcM/xtbhh/4LxD2ZgAsSDglyoF9vfI=;
        b=rqXoNw4amJ7v6Rdj/ed4OE/4xx9IoqpVCbhChERLPJwa5kfose+XLo2dxK4jTfOtQU
         2J7K3KAqTiGbk1xflKES0QOvtvkhV+OkeMUABb7053lfnt2fmjsX7Bqz4IQLwjln+gGa
         9MQgwwBHMw5pAXKbJaod3hPxq1L4oRWLnS2ieMw2mpKPK8H6Ri/9e83Cf0fS8vNkm1Hg
         s/Bp+iQ0OEmv9cxOQsui+BBJEY1yF6r/m/vlwgq43WyV/vI6G0Ee6Z3oLlpe/GY7xFP5
         k166nmFSZRX2cH/6/20tD5KaBkDMzgeVbK22DuHD1K1lD9C00Ng5y4XLeWrEESuFYvhh
         eu1g==
X-Gm-Message-State: AFq9FYK9AsPXU5UuUQ/mCpxwyAAnmDlvP6WFteRIboQkXSgjmgZJqMcx
	FvvoVQTPZNLBc+GfYEu9EcW5/Y/uY6OysoimbY9XGfdxuMrtC5ALiw/aENMEe601NtYVmXDjKvv
	P5dJ6UtEV+rD+z1NuNGydwnalLPXxTJQdSEaYm5C0MT2p8t7kij4iIMu4pnrgn+TCRBvEVO2jrw
	V5g4aHqcAcCAU3L4ozf39jYOw6Afub1eWyXhXk
X-Received: from pjsa19.prod.google.com ([2002:a17:90a:be13:b0:3ab:9517:f413])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b90:b0:3ac:8527:3fc5
 with SMTP id 98e67ed59e1d1-3ad86afbde1mr745223a91.3.1792550964733; Tue, 20
 Oct 2026 19:49:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:49:21 -0700
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
Message-ID: <20261021024921.1735149-1-seanjc@google.com>
Subject: [PATCH 5.15.y] KVM: x86/mmu: Preserve nested TDP shadow page tables
 if they are used as roots
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
[sean: resolve minor conflict due to lack of lockless aging in 5.15]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 081547246801..a768cbe23808 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2336,7 +2336,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
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

base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
-- 
2.56.0.218.g1ec904b173-goog

