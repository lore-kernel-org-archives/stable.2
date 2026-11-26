Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689296;
	b=XjavuOagXIMsmRwk+bchEzxz2zkgemNykAE79jpyIrpopDxDt9iSs2AVOrQBzYASPqat
	 5oQlLGVqRVl1ceGHk4EPuLVDm1yUxT+z5f8EHMGvL47GUXYpupiUfvpvWfmh1tK+zjkwO
	 H8SAQdsllyU+QUqzUycBkV19d0/onEkv46r3F4hmZbgE9bNF+2q0F1E4GZ0ODz6LvfHMJ
	 S4tkhPUaaMFy+JIW09+L3DbZnI1CWflSg455JCWR5rv7EQWjXR5aV1EFBTHh8jCmKrcWY
	 ItQdQOxe3V1P//vSCnmGbybV5/CFgeQZwC1WjeRIoO+VF3PSVIEgV6dQ+hkMKqOpVIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689296;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=JgQXv7FdgOeE5H/CalcuK3oIqiWd+ZRvVVk3oyr25Ko=;
	b=e05mDlK4VaMXtlfXRBVat0lJ4bg/V6NKIU14G/mFQZfxOpZwlFSvu+saAVb2gP3VZy8u
	 +g4v5x1vln2FLaCBX+pVA4558ErYT/mMt4TfE4/IwSlTHsHOKHLxIaBy08siliaulhmw+
	 0P4/TjVOi7bo7wHm7DNO2pfDLS1h3co4IIOV/2+VoZcNWdjpEOA0B8+ZZonkAl9g5AmFK
	 dUPcl72CIzs62RNHz0KryjhTVkmF6TApOKZAS9R8DvJZ1dyW0+T5pG9XpYlqXmuO511Zj
	 5WY1c6THSHc2v64xtY+4PGHBY+N5/GVPUOb9Uk/HzHDxX7nozX7Bir8Z04Aycvlh5Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VS+d6Pt1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F3606A336;
	Thu, 26 Nov 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VS+d6Pt1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795689296;
	b=CcWARuQKkEo/GEoxfkNw+N8A/oMrBUIenavlG+ZX1wbV4LyFaAplJBLCjYvZekElPSYa
	 7KVMa02jT0LlA+f6qg69XlfMMUHnUhl+rwDxmdo6aJ0uMNuW618028qqABk2zrlyiuOmh
	 B/FjDCVr1wPGfd7c7belUZXWKmOTxSqSxr+oZt2b2c8hyaYt9V3Sm02iNDRyNxthfSwyq
	 BnTqT8HrQaEU0SCCldugvCWY9OpYorDf505SnkU2KewvYMcHa68zsMJtPGasgL7DA9mn0
	 ynOM7NQzjm4c55xlay7kLnlNTPjcWVTsgrHHNcOs1v7hw6qRPB+H3l5s5pKh+j52dCQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795689296;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JgQXv7FdgOeE5H/CalcuK3oIqiWd+ZRvVVk3oyr25Ko=;
	b=22EVORb6rMjWNx7AL6qdJ6TlXyqMsCBq57Q7yJV5+VA3AryMqlm6qcRsDQGjyj2lBA6K
	 GWIUSkuGkuZYY7nmYgxNcwKWQ2hUSdj5jxZYVPleOlobESCX7BST0GYNmio6LZh6b3EsQ
	 KcCxY5PeVsywsE7M09O4MfO+on1GYzQpKZ09I3sVzuk7nHci2N3dWy2l50ZpOfVyuwLHY
	 md/c0HWzxKP19RcK3RR8DBkxh8x4pLbQemqTIuaIyr8FQ6VXbJISSK5XE97XbsS8YRO4v
	 Cuenk0I6EqGU//NFnO7EUFFU+6tty98SFZH/7liA3+vFZcIU0T9zX128fTSR9lSJmjA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 603DA1F000E6;
	Thu, 26 Nov 2026 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795689296;
	bh=JgQXv7FdgOeE5H/CalcuK3oIqiWd+ZRvVVk3oyr25Ko=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=VS+d6Pt1G44+/5VFkW4PSjAF7octuB1NnUIRf0VR58EvC3wZ9tI+S9d5MKq9iijY6
	 F2fDrx6Pm2bOfyRmmqCFO9caz/nIiY16fXLWotBZN1F/YKU2OE8zWAu0SaSRZP+f0f
	 PzW5Z+Ajqm1eM/mC4RuwloXADSkzh4RDKNx39EGrTyJTlvjvBMrFmZx/dNdWMNKQ21
	 oZlcbL5NHLVfcl792PNeHWp7qgIvP7idBAsBh6Xq0ek30FT6ILC05ZcuJXczNqELUD
	 xZIHCS+UHyNVUDJcgUNMLZ6DbrRf9t1sv34HkOiecDKQLFRPJKVWXHnVdj0PmzDnlO
	 21OcyG1bZ8w+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E5C5C4D449;
	Thu, 26 Nov 2026 10:34:39 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Subject: [PATCH 5.10.y v2 0/2] KVM: x86: complete SRCU coverage for vCPU
 events
Date: Thu, 26 Nov 2026 10:31:56 +0000
Message-Id: <20261126-kvm-510d-v2-0-bcba96aa2088@certik.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwKCGsC/zWMywrCMBAAf6Xs2a2b0ATxV8RDHquNj0SSWpTSf
 zdRPM4wzAKFc+AC+26BzHMoIcUKctOBG008MwZfGSRJLYTUeJ3vqAR51M4N5HdKEQ1Q80fmU3h
 9VwdQvaD+DcefL097YTe1TyutKYw2m+jGpgpHP6V0w+a3/z+s6wfjFa5bnQAAAA==
X-Change-ID: 20261126-kvm-510d-6cc40d855004
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795689116; l=1912;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=tZO36opxcxWmYFpvOATral8/1zZH55TXraMh88jDJHk=;
 b=ApqeA9bExi8qy5tP2NK4EbBv7S1Mr2DckuKO99gynUeL6IjtL5NAD+cf9KHmI7oU7Tf0QJPDq
 tQbMQPpPnoXCFCuyTRlREdUYQqUQ9ICQiOpDRBFU95yyRn3U0YE1ug7
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

Hi,

v1 was a single patch: the 5.15.y version of commit 4bcdd831d9d0 ("KVM:
x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS"). On 5.10 that
isn't enough. KVM_RUN also reaches kvm_vcpu_ioctl_x86_set_vcpu_events()
through sync_regs(), and on 5.10 that happens before vcpu_run() takes
kvm->srcu. Upstream covers that path with commit 8d25b7beca7e ("KVM:
x86: pull kvm->srcu read-side to kvm_arch_vcpu_ioctl_run"), which 5.10
doesn't have.

Patch 1 is that commit with its follow-up commit 2d08935682ac ("KVM:
x86: Don't re-acquire SRCU lock in complete_emulated_io()") folded in,
so emulated MMIO and PIO completion can't overwrite the outer SRCU
index. Patch 2 is the v1 patch.

Tested on v5.10.275:
- x86_64 allmodconfig W=1 build of the touched objects, base vs
  patched, no new warnings
- booted a PROVE_LOCKING/PROVE_RCU kernel as a nested KVM host under
  QEMU and ran the evmcs, smm, state and sync_regs selftests. All pass
  with no lockdep or RCU splats. vmx_preemption_timer_test fails the
  same way on base and patched in this nested setup.

5.15.y has the SET_VCPU_EVENTS fix but not patch 1, so I'm sending patch
1 for 5.15.y separately.

Changes in v2:
- v1 <CAFaZ9eoOtFxAansjaUbA-CDNQLcVAVJre2R9vaTQONG9MYUEng@mail.gmail.com>
  only had patch 2 and missed the sync_regs() path. Added patch 1.
- resent through a whitespace-safe path, v1 was also damaged by my
  mail client.

Thanks,
Dickson

---
Paolo Bonzini (1):
      KVM: x86: pull kvm->srcu read-side to kvm_arch_vcpu_ioctl_run

Sean Christopherson (1):
      KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

 arch/x86/kvm/x86.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)
---
base-commit: 99112ea818e35b606397c84fbc05e6fadb6ea162
change-id: 20261126-kvm-510d-6cc40d855004

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


