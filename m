Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794639028;
	b=Oa3mT80o3/lpZr123j3GVvzDQCYcP6Z9IRWaGRP09AgfQp68y82+xHHmtda98AqA+/xT
	 2W+FrnirtQrBRcyPchebN5rU63bAQbSN/mV6gMgUxa1gxoc252Mlj6/mzf8HasZDePMHt
	 TtiIKiM2z6q9OGM4/h8H+5Cff5tfCvH31v+MSbPSx7NK9qiNirEmgN7U5rV7zwqFEwbW3
	 nsDOraRHZg4F0Cm7WulDdruCuyjxlC8M6bjuGaNTQunbPoukSyLVv6H5bV3EeseN6Xu0e
	 CGOFyAJWD7aB+e4rNiPkA6msSWCKD6myK7vvhs0mp2v/8hF0zOr7FtiAbIff3lG9gvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794639028;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DOyBoioYHCWLyh07NlJPkAGqlylR2I/EfAeAVCJpPq4=;
	b=4I4SrsFTOPpNdFxJ8xTDjUvc1NPDAxZdxwNh0VvepauVbOlTzjjyMVgOCfu+nULtjwYZ
	 x9KcSCekCdVLpStNbpaZZetKpVPV8KZP7yTf35I7ihPehneCaochmkDAjRIaa+xbJ8czA
	 B1nr2B3PuSGvRdF8lWg0HKuoDgQmGqXIPg9pU/UJuRiijYUYk3GwAdaX6+RQUPp5t8nxC
	 8PfWlR5jzTvq5YSexwpoVpa2j5bfqyMAhCh9Kmv3YRyU+5S7wbgKJKz1SxQagOLNdiWKG
	 ObfZpJMbOSSc1Tn7xJOLis3FezoEKwy1jljW2hfsL975zZiaJp44PiOWut+dXDnDe0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvkRqLwI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300FE606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvkRqLwI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B3A1F000C4;
	Sat, 14 Nov 2026 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794639027;
	bh=DOyBoioYHCWLyh07NlJPkAGqlylR2I/EfAeAVCJpPq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvkRqLwIAIksJXhWYreIJNBA8z6sIiGPttKW/K+YgTds0WgjBqE03PNZdO3K8XIR5
	 9sz8ReKuHarzdt2Q8ISOUZuJTyXeSJZ6qDafcNgknccXBmCL1+c+wQfekEsxXLpsPr
	 5xZ9POnkUTGtsdn1Q2YoFOE3PgWOxbvJQD0tTJgRqYfwjOCz+pryfw8aHipnlieqsi
	 pBZFnP5tI0YNirrDX2JIDOHCRk+NzDxDz+wg3Qqrjm6VkZKg0sqkldOZ0JcnHC8vVU
	 k+oseahcKBJeXnCli0Wr9dzDRieWfJEImiBdXxcdJbx+S3+0jU8aoOzdY6LGNkGlj+
	 ITB9qayMwF9Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hou Wenlong <houwenlong93@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] KVM: x86: Exit to userspace if emulation prepared a completion callback
Date: Sat, 14 Nov 2026 01:50:24 -0500
Message-ID: <20261114065019.3231096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202643-failed-5.10-ae85ac25eb67@kernel.org>
References: <20261109202643-failed-5.10-ae85ac25eb67@kernel.org>
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

From: Hou Wenlong <houwenlong93@linux.alibaba.com>

[ Upstream commit adbfb12d4c4517a8adde23a7fc46538953d56eea ]

em_rdmsr() and em_wrmsr() return X86EMUL_IO_NEEDED if MSR accesses
required an exit to userspace. However, x86_emulate_insn() doesn't return
X86EMUL_*, so x86_emulate_instruction() doesn't directly act on
X86EMUL_IO_NEEDED; instead, it looks for other signals to differentiate
between PIO, MMIO, etc. causing RDMSR/WRMSR emulation not to
exit to userspace now.

Nevertheless, if the userspace_msr_exit_test testcase in selftests
is changed to test RDMSR/WRMSR with a forced emulation prefix,
the test passes.  What happens is that first userspace exit
information is filled but the userspace exit does not happen.
Because x86_emulate_instruction() returns 1, the guest retries
the instruction---but this time RIP has already been adjusted
past the forced emulation prefix, so the guest executes RDMSR/WRMSR
and the userspace exit finally happens.

Since the X86EMUL_IO_NEEDED path has provided a complete_userspace_io
callback, x86_emulate_instruction() can just return 0 if the
callback is not NULL. Then RDMSR/WRMSR instruction emulation will
exit to userspace directly, without the RDMSR/WRMSR vmexit.

Fixes: 1ae099540e8c7 ("KVM: x86: Allow deflecting unknown MSR accesses to user space")
Signed-off-by: Hou Wenlong <houwenlong93@linux.alibaba.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <56f9df2ee5c05a81155e2be366c9dc1f7adc8817.1635842679.git.houwenlong93@linux.alibaba.com>
Stable-dep-of: ae85ac25eb67 ("KVM: x86: Conditionally resched when restarting REP string emulation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6f5a6fe42d874..d7236e8467316 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7717,6 +7717,9 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			writeback = false;
 		r = 0;
 		vcpu->arch.complete_userspace_io = complete_emulated_mmio;
+	} else if (vcpu->arch.complete_userspace_io) {
+		writeback = false;
+		r = 0;
 	} else if (r == EMULATION_RESTART)
 		goto restart;
 	else
-- 
2.53.0

