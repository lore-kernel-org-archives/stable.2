Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365008;
	b=jvJV+nKF6NmpZkLQbeZSarVih+KvT/ZDnOS9w6xBRGURfP8RWZ4YA9dS32kZhOTJInpB
	 kHtSceX28V8p1BzntBQHom1G+zp2bG3Uw1K8oHByuLDKA9oZg8AYmSSmEIVyxbUa4N4FW
	 aUF1Mh67bSWVRTX+Da26+phZCX0CnzGdyWnRKhfuMUGGXB+thFOFeaX9uL0yL2vmkTk45
	 3jrJvyLtVsNbStnTSh3EoVi2IIWONyGNALqe3olHlqUleKr1mVrrhnyG0/QxydeN+nmZs
	 tehF8Wdk/6Vhhz9C5RpL6mmZaa/tCPsXxxszkw2FyMEoC2Ian0hKcVyathgHJpXi62g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1DY5BdyPwA9XaI5zETr9lVeFfh0ctpw+3FaFqrL5VXs=;
	b=r1EhTqY0fUj/R3ZVdktpMVvEx9VLiN54yiuXVh617NrG7lPN1tnjcol0V4XphA+5kquH
	 wSU4poUUYiatqL7oOxtaEYxDhHvO2ejeK3aqRiwMnJfNCY0qfLZzOS7x07ff13Y6js0BQ
	 UsqON84o9AmlhSZGpVh9lAvW5Sjm1E5vi7C/2h62lccdrmokND/T0qhZEHUSwwuASjFQj
	 /zAZoNJQDT2VR9p6q4W2Odtl8xIT3MkEcYl5QkkeZahjbJG2d6Ebjtq3dIU/swAM+zuAK
	 ypM8Kk0p8KfSUWM7VkXlH5vg9Q2AJXgVqHjuGDBaUHXkaTt0D3b1L5tREFFjWqJsIkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ld2YSjeM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070CA606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ld2YSjeM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0E51F00A03;
	Wed, 11 Nov 2026 02:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365007;
	bh=1DY5BdyPwA9XaI5zETr9lVeFfh0ctpw+3FaFqrL5VXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ld2YSjeMcdEuG2R6qQf5O2SW6DvaPxjcdAzYIchwSgul3CWzFv/tXuM5V19pDaLCG
	 6c/kRc0yQ766+2P2L5jkU2z80VNrv56aTQTgZSMnjpULRA09F5iq0GSd+eBAqkvs2V
	 Qx4rdnmo/DZFKgBx/35ha4OxAZJZLF5BlGaqZ/p1wL0h8NhdmZBDo+UD3HfAcy+H5y
	 wkcNomLxfKk+SZuxb2lw9iX73PzLLhuhGm1fIQQyz+TCYCYGdfWolEMUgF3/J/K8Cj
	 UW9bzfcUj/JtfriScBVY/lMvlqnKI85ftM8tVqh/OfEl2+KyFXky5oWV4mFqYWxMf8
	 XyLav56G9mISw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	sashiko-bot@kernel.org,
	Paul Durrant <paul@xen.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
Date: Tue, 10 Nov 2026 21:43:23 -0500
Message-ID: <20261111024039.676658-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111024039.676658-1-sashal@kernel.org>
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
 <20261111024039.676658-1-sashal@kernel.org>
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
index 335e046c68365..9dad266350609 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -742,6 +742,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		r = -ENXIO;
+		if (!IS_ALIGNED(data->u.gpa, sizeof(u32)))
+			break;
+
 		r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
 				     data->u.gpa, sizeof(struct vcpu_info));
 		if (!r)
-- 
2.53.0

