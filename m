Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365669;
	b=iqbGgUJu9cJG5/kVlzGm2y0xU0K91sWpxNgLOmtdlcSLXjK87HkXtmtFUMnIudUs82y3
	 j8v0/KVb5Osv5vZrlcMDdHQ09w4I6UVZyr135kYUa7oPNeexoFMoop8L0WD9uibyWp6x4
	 L2Q3ffzagvr83zH3LqBnNxv/L7kXVcf9YMc78iCQSqrNVmS8tHv2OoPQGQiajE7EWLpq0
	 Y+Aa7voAr9XyJ52pBQARevOgK5dmAI3xInEFNuF8r++nNlYeochx7lBZLMUfOvibnRdz9
	 CD81N6B0puvzTBmjH7USvlsotljYN6owGp8ueWb8jix010Q+Rzl8FWmRomFvSNRF7hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z1DTqUxKGtgSlkjsnQi5QxSE4E0JKyNWCtvRQDTXwwI=;
	b=bvuSgZRquOkyzQM5e3Dxp9duimiFsiAm58T+u9Wf7hYTVB3nWfNh0dF3Xyn0n/nTsJCH
	 ZH0mMRPvCJaLYcmLYvgCxTiUhuIGyPtgmdisBy0XCjcrJIaQvV3/JvlLuN4PZHBoPvZPM
	 aPlkXqidRlXHHITCS3quTxTTO4c/KRHZBQCwzuqXVIbqSkCA/ieA0j7RCDUUPfz0t5x1f
	 MVqmHJVYv9v4G+ElfcDkOhOuZ81U10Y9fqF0HpCu2mBdbyWRG0geXDJNIZrBLsUIAw4sh
	 LsH68WU4ACAiW1AFnDfMVVe8B9y8qmp0+EAF4TY7q+Nj1K0yzXnClEQPZMyLyFqrrYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDJT4k2d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3871606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDJT4k2d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA84B1F0089F;
	Wed, 11 Nov 2026 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365668;
	bh=Z1DTqUxKGtgSlkjsnQi5QxSE4E0JKyNWCtvRQDTXwwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDJT4k2dowDiPHPvv1o+v0qKaEkuf19y9K2Q5mJSR8qq6YWvQJ422qkobbcccQNtI
	 NccFYysUJWxdxqI3F9zWSyvRw9h+tAOuCDyRuB8WtEA0hGrJaTTyovbqnHHWumlx0k
	 bWhCIYDXQJhpIe8rRluctaRknRiJglqEHAtr8f2uSLp1SpuwU0mBhkMSQ5cslXye9L
	 DdYGTc3BN7GekGnWLAG4fQJOkhJiZG5Z7McbDKWoP5I/UaLHRPxPixeOkNKYart6ax
	 x0gk4QQYcX112JCXZua/y+kN2nkfVcaQyWBnRPh4moDq/6pgQWRtzYNel+wqohVJR1
	 j3cdyqe+0akmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	sashiko-bot@kernel.org,
	Paul Durrant <paul@xen.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
Date: Tue, 10 Nov 2026 21:54:26 -0500
Message-ID: <20261111025313.769639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054109-failed-6.1-eacdb76c5f04@kernel.org>
References: <20261107054109-failed-6.1-eacdb76c5f04@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit eacdb76c5f04956035c5d7f7e1973028f30684a2 ]

Xen's map_guest_area() enforces that vcpu_info is aligned to
sizeof(xen_ulong_t). KVM has no such check, allowing a guest to
register vcpu_info at an arbitrary byte alignment.

Enforce unconditional 4-byte alignment regardless of the current
shinfo mode. This is sufficient because subsequent commits ensure
that all locked atomic operations on vcpu_info fields use at most
32-bit accesses. Return -ENXIO on failure, matching Xen's
map_guest_area() behaviour for unaligned requests.

Originally observed in review of an unrelated patch:
https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org/

Cc: stable@vger.kernel.org
Fixes: 73e69a86347a ("KVM: x86/xen: register vcpu info")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Link: https://patch.msgid.link/20260831213632.81023-7-dwmw2@infradead.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ sashal: Omitted the HVA alignment check because only GPA registration is supported. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/xen.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index baa0c6d180962..e2900e5b0bedb 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -569,6 +569,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		r = -ENXIO;
+		if (!IS_ALIGNED(data->u.gpa, sizeof(u32)))
+			break;
+
 		r = kvm_gpc_activate(vcpu->kvm,
 				     &vcpu->arch.xen.vcpu_info_cache, NULL,
 				     KVM_HOST_USES_PFN, data->u.gpa,
-- 
2.53.0

