Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604789;
	b=1x9Z786i78x6AXAH85+J6x14S0vpKmToKfFThHam6EzL9DQOEKy7T96myRS1j3j3RHj5
	 6v0NM3+SNMQbkuuq2kP6cn8pGfEW82meB2LFpctTKLbDmE/9LWMARmGdks2ENziE9kmp9
	 czvyI/Je/kN62bRaAR3KcGVnWDvdsRy/6DJ2NCZiaJZcbAsA2wpHWEngwbpxfDiYs1iZ6
	 Dq5G6g6wF3zgtJG3UbRjLO1+9iCUyDr5GaBe1oRF65blNHCgD7OIQ12G0W6akqW6IdYKB
	 qkzX+mX52tH1PCSts9WP43klbV74VDQAn7S750go2Fk5T5FybIY1MBOScclSIZ9Or2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uhlq7lRBnMZgN/FlVC6dxixNTQE9Qh0fbitp0y0qEhA=;
	b=EbVGO8w0ZZ0gAFOTULlUnRr01NDSqjfD4gMxFChvA2SngtKh3VrI1IoWRUcFeFA7WiJp
	 mZi6/nX6RxrsRoYILpCMj7NPyyYbfI/WUXIFQ9E3+1Ru9F9VvcS4+4rMKatZ54Rmpe+F2
	 JO3RDNqtMJy/rNtCpe2TAMGJ5lhZMXzIIA9WocDTImY2fn1NjtOTOl/vhJU5RZy7tDqW6
	 hhEPB/eRmd0DBk5DdnDkWXT9A7fH1aXRYnIgH0CKu/aiFkEpOQ52Wd2cGC/L0LmwQsELs
	 AFkfU17WJpGY5O9Z8h6vfNdrjxLc9nASazUO+wa3JWfDCcpwBl8g4T/Q98Sn2zYWwGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FijoGuQS;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC65606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 07:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC65606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FijoGuQS
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so1257770b3a.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 23:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604789; x=1794209589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uhlq7lRBnMZgN/FlVC6dxixNTQE9Qh0fbitp0y0qEhA=;
        b=FijoGuQSUaP574cBOPnGIczHrUOjWFNk+Jrj5n35e1QLUZFUl92Q2mJQAAIRY/qjmt
         yfSIm4cqlrnhqOIhYqMtBfb1vR9mQZtZZuVQk7vUKi/4kAkWME4ZK/onJy0/xUFlCPay
         P/RYk7M5cYEYydnSHpjzXyv0mTCTPnOJSmOJV0JxkzAPKs4GpSCTpso6tr+e5CyPQLcK
         5VIY2bgxCNC21HzAb5ZiGCt8JMbOFVDuWDQTJjY7H+YjIm0oweELaFeyNgqG26pMFstz
         UmlqdiGKZiiWqzGeiQ3nheYmhEBke39hbZKtUL56OgNdNlkET4GIFtEGaUhY8SCkz8/C
         8S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604789; x=1794209589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uhlq7lRBnMZgN/FlVC6dxixNTQE9Qh0fbitp0y0qEhA=;
        b=Hz5Yy7EyEh7Qw4xn+VtZxQFZqQDyygKnrdHFB+jzQTW5ikYXU55J2q9zKCM6448AXi
         EzrpM7ma0w0VWDeaC9GZ3QmhxmBHqLouNf9FHMDI0h//CiZC6RAG6odK3Kvk2jQRqlWy
         dFTIRdH0xkuqJTHbrGMKpvyycdbdbjTY9F7AsI6TzRFX0EmbdR3xos9iW8DgY8jAyoud
         sWDQ9CSyCym7L0hxT31yVM5QLWiU6ihmgwIrwVZS8i5Rn1ffSvL0h+JbmcylGzF13j7V
         kgq15HRqS9oR4hslbmwfmCxpJCSc3V8Hvj0zcInIGRcbbcm/fSGhIADnDSDgcVttCIxv
         8B0w==
X-Forwarded-Encrypted: i=1; AKwUvBwKI4pjnpXuxTpuetf3+9U/k+0/rqkIrEZvbtn7L1XtkzHl6reNExnazeiKbm5VtCGjtUOy6/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qt3lLvHh+f0zZ/czeOLixoVUXL6QfRNEC7wE8+nnhY+xNvATh
	thQ0tA6+by77n2ZGcDzkY4gx3+Lm8Lb3FVu/JfDu/OYu7nKXwS+lxDM0
X-Gm-Gg: AYBFou0dqy5eK+YL6ljTxYqjZ0qrs+PmcaQzV7cpzkfzGvEYUmMzKVIyjJ70AlGsQcQ
	rksvDwdQNlP7IwkD30pXGnEx6JDkshB9yB2VY6YoVysCp+UP+XCfSlMSRg1J7VtQ7FxLJsfXKFL
	7jmpufxMrcGpqymOBvx02kRS4S+1WbUTMPq4Z6wwsdN/6GT25irvYUw1ebPyi5xExsZqScycW4B
	hDrLeFFdDaWSZj1vXqorD5x1QjL/T7dLl3rusxliyGfap95TNasvMgx36X5mTZCaIctIa5aIyMw
	3c26suSNbfLj9Ohf1kDu8K9vXE14iYCV10/9KVIBtwCUV6YN0hrPrSz+qFXHAeyztvobz1VpUB/
	1lKVfiahi+Pg6TA3K8fmTYLRY9YAayVNJaCqzOvfemosQPTFtuAzbHm8L3Xv0zqUzt5dYkyWWZT
	+EmcbREcx7lV4n7dy8ILxrFFO1RUY7Ms78ejgvQ0cfP215KyfeIUiRG/MUhzrxq31s+y7dBIcGy
	IzgLB4kfyatn9hIPkoFiS5P6oRwxFwj0a9WsLS6Hpzzh3LNoa9F3eQ/rwS9PPJkGzW+uQwWkKbG
	L6zHFbKcA4NKTCLQUgpes3qtuSbrDhn6dewB/6vFEOA=
X-Received: by 2002:a05:6a00:340a:b0:89f:d449:7526 with SMTP id d2e1a72fcca58-8a8321b41acmr7898596b3a.21.1793604788690;
        Sun, 01 Nov 2026 23:33:08 -0800 (PST)
Received: from iZj6c0kydq3fvfrtx5kta5Z ([47.86.51.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada6c2c28sm1563174b3a.43.2026.11.01.23.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:33:08 -0800 (PST)
From: Challvy Tee <challvy.tee@gmail.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com,
	kai.huang@intel.com,
	seanjc@google.com
Subject: [PATCH v4] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module is not initialized
Date: Mon,  2 Nov 2026 15:32:44 +0800
Message-ID: <20261102073244.919864-1-challvy.tee@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <07cfa95a-e766-411b-8765-33352a04c0be@intel.com>
References: <07cfa95a-e766-411b-8765-33352a04c0be@intel.com>
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

Commit 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and
kdump") made native_machine_crash_shutdown() call tdx_sys_disable(),
whose only gate is compile time (CONFIG_INTEL_TDX_HOST).  A kernel that
never initialized the TDX module therefore still issues
TDH.SYS.DISABLE.

In VMX non-root operation on a SEAM-capable host, SEAMCALL causes a VM
exit instead of a native #UD.  KVM injects #UD only since
commit 9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute
SEAMCALL or TDCALL"), first released in v6.18.  On an older host the
VMM gets KVM_EXIT_INTERNAL_ERROR and the vCPU never resumes, so
machine_kexec() is never reached and no vmcore is written.  Kdump is
thus broken only in guests on SEAM-capable hosts whose hypervisor does
not handle the exit; plain kexec is unaffected because tdx_shutdown()
only runs as a syscore op, registered after init_tdx_module() succeeds.

Gate the SEAMCALL on X86_FEATURE_TDX_HOST_PLATFORM before issuing it,
the way paddr_is_tdx_private() already guards its own SEAMCALL in this
file.  Without that feature the module is never initialized, so there
is nothing to disable; on a TDX host the gate is a no-op.

It also decouples kdump from the host KVM version -- a guest cannot
require its host to inject the #UD.

Fixes: 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and kdump")
Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Challvy Tee <challvy.tee@gmail.com>
---
v3 -> v4:
 - Gate on X86_FEATURE_TDX_HOST_PLATFORM instead of
   tdx_module_state.initialized, guarding the SEAMCALL itself the way
   paddr_is_tdx_private() already does, as suggested in review.
 - Drop the v3 rationale about covering the syscore and future callers.
 - Retested with this predicate: kdump produces a vmcore on the
   Alibaba ECS Emerald Rapids guest (6.12.0-278.el10 base).
   v3: https://lore.kernel.org/all/20261030154851.907726-1-challvy.tee@gmail.com/

Hypervisor -- KVM on all five (CPUID leaf 0x40000000), across three
clouds: Alibaba Cloud ECS, AWS EC2 and Tencent Cloud CVM.

Host log -- yes, from the Alibaba ECS host of the Emerald Rapids guest:

  KVM internal error. Suberror: 4
  extra data[0]: 4c
  extra data[1]: 2f
  RAX=0000000000000045 RDI=0000000000000045 RIP=ffffffff855422fe
  R12=8000020300000000 R13=8000000300000000 R14=8000020200000000
  Code=... 4c 8b 5e 28 <66> 0f 01 cf 72 05 ...
  check runstate transition: 'running' -> 'internal-error'

Suberror 4 is KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON; the two data
words are the exit reason (0x4c = EXIT_REASON_SEAMCALL) and
last_vmentry_cpu, i.e. kvm_prepare_unexpected_reason_exit().

RAX and RDI hold 0x45 = TDH_SYS_DISABLE and RIP is at the '66 0f 01 cf'
SEAMCALL opcode in __seamcall.  RAX still holds the input leaf rather
than a status code: the SEAMCALL never returned.

Reproduced with 'echo c > /proc/sysrq-trigger'.  All five have
CONFIG_INTEL_TDX_HOST=y, kexec_crash_loaded=1, a kernel changelog
naming both backported commits, and "TDX not supported by the host
platform" in dmesg:

  Microarch          x86_vfm  Cloud          Kernel             echo c
  Sapphire Rapids    0x68F    AWS EC2        6.12.0-278.el10    no vmcore
  Granite Rapids     0x6AD    AWS EC2        6.12.0-278.el10    no vmcore
  Emerald Rapids     0x6CF    Alibaba ECS    6.12.0-278.el10    no vmcore
  Granite Rapids     0x6AD    Alibaba ECS    6.12.0-278.el10    no vmcore
  Granite Rapids     0x6AD    Tencent CVM    6.12.0-278.el10    no vmcore

That dmesg line is printed by tdx_enable() when
X86_FEATURE_TDX_HOST_PLATFORM is clear, so the feature this patch tests
is absent on all five.

Controls, each producing a vmcore: the same platform on a kernel
without 5b25f249be32 (tdx_sys_disable absent from kallsyms), platforms
without SEAM support (Skylake, Cascade Lake, Ice Lake, AMD), and plain
kexec.

With the gate applied kdump produces a vmcore on the Alibaba ECS
Emerald Rapids guest, retested with this predicate.  The Granite
Rapids guest was verified with the v3 predicate and not re-run; the
AWS and Tencent guests are reproduction evidence only.  No TDX host was
available, so the no-op case is reasoned from the code, not measured.

 arch/x86/virt/vmx/tdx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 96ced0494b68..9b01131f7b7b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2321,6 +2321,9 @@ void tdx_sys_disable(void)
 	struct tdx_module_args args = {};
 	u64 ret;
 
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return;
+
 	/*
 	 * Don't loop forever.
 	 *
-- 
2.52.0

