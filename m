Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366365;
	b=q4grrw0rLkw1T8qyhf1/PnSiczfCD3yQHoR/N/VKXSCRVAXTkEqTUa1BWLBpYmX49uLV
	 U+B/nM68tvCUTsiN2TQnZO6XoRUz/tcu8oTgHMhHp5ZpnfSxxkpsQKR1XS3MmOeFkSF11
	 LGCpyyVlng5sSAt7wkCDAmAYcBuhxQxCHB92qJ+ifrRO6lTZP7XVlZkfY5GgctF4KeGdO
	 sb9bWUHRZ8h1f1kcUENtturICg8xr0WXqW0Q9Vc6EusvN7KMXv/reLYktxqDI+qAs2Wx6
	 ltv1P21VWNx/rr7ULgqDy2ZLUawjuMnFGI2a+pEEaxGX74PMsyotNLHNlXnTubR9GqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366365;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZhK6fxGp0Yhji3Lq0mMK6EbuS1F4rWHrpBGbgJUnycM=;
	b=xbNfmd6S7JCWaTHZsyawccwSjoToowfJRLEF+7RXKJnM35cc3M4XY9/LisMD+sZaq4xM
	 TQUZoSUdxfgEVQaHIMuR87anrK4g/XG2K1LT3eQedTayp5LvibLaS52o4sqMC0Lqd0wlk
	 //sINgCDEfCkONZUlT9IARpMXE406UZJUVKfqRzrVVTvjUJuB9+WhjHitDUUmf4FLSkBK
	 seHOyqzaLq4K0FKeQO28hik4oO6bG0av4Ug1GZKlqEj0Ol9ZOPsZqQElfKsTyQCnG4kjq
	 nIeKl+Q1HoQ5EpG5QGVpZzJFwjATidzJDuwCGLzWN70T+hDfHFXMWspA89o76grLEfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfrDZg9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0983606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfrDZg9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF4C1F0089F;
	Wed, 11 Nov 2026 03:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366365;
	bh=ZhK6fxGp0Yhji3Lq0mMK6EbuS1F4rWHrpBGbgJUnycM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EfrDZg9paVFizpE2hATnU/gqxVVIJ9aqqPFm2PdU5uWMWVUo+5eQoNksbuE2Yh+Dl
	 NKm9iISHXbaIyb1JTjoSrlX8t/M7O3ZCata0nWfJMiW+wfYcOhCRbgmuGh6+2WNKjY
	 wDbx8YgxV6fBlaerX6HS3Uip5oDH9TXxZSVaan36GO1dTY4KfjdbWN7awzjByL1SCc
	 OKetMQ7Ee4SMrOB/xLgTpZkdyIsMCz71kbAdqi0U5cBW5FZgHyq18yYZUpvnJrNOh2
	 PBQBjEnamDv/186jayt8bXiiZaM0IU4ZoV5tYi80lHDox4zT8dkuG8WYmptcKu4Ebi
	 R3/fiGPc2aZDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	sashiko-bot@kernel.org,
	Paul Durrant <paul@xen.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
Date: Tue, 10 Nov 2026 22:06:03 -0500
Message-ID: <20261111030546.811623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055744-failed-5.15-eacdb76c5f04@kernel.org>
References: <20261107055744-failed-5.15-eacdb76c5f04@kernel.org>
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
index ab9f88de6deb9..69c2d8dda2d25 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -356,6 +356,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		r = -ENXIO;
+		if (!IS_ALIGNED(data->u.gpa, sizeof(u32)))
+			break;
+
 		/* It must fit within a single page */
 		if ((data->u.gpa & ~PAGE_MASK) + sizeof(struct vcpu_info) > PAGE_SIZE) {
 			r = -EINVAL;
-- 
2.53.0

