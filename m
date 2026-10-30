Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375342;
	b=KCxCK9VpUi/zKVXrCANaPRSi+aIgU3aXNdvs3TR/qyRPuuDXv/0tOaB3SgjQXlCEsZF7
	 jdQkra3Hx17dg4jdSvxiTzFylOlv0jGRQpdzysy4NtYuuBaV7kH+U8JrAFBRq71UL+dgL
	 8z+SZh8iyPV7+b+blA6RTNulJzr1SO/PcRWPXdlOo882VtslVCX7uK7k3ekLo/a6SM04P
	 IkjF7/gOHvJ6UgAqUe7YRI6WD7zkJaYcznpE3RI306mcjd+UvTMlqNHvroz6IgeRbZ2jV
	 3OEkBFDsIcVyWcKGJQULXXN5GPEMFvaLe/bGd4efmJVnsZ247WkyHGWck41npLmhzLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d0SM8LOepW7XUMwU+ZDps/Wc1zMBVt4O8GKS2q6Z4u8=;
	b=vU6sIjTLNHIBnoRr5cT2dkAjqMMFdPfXTcx68uI6QLKcPnSSB3G0zKAMKXMYf5vuER75
	 QJ83mEiBk9hQZnQE4z9vaME4ebNXRo62Cckb6iMLK30bpCr/G5Sb0z0A1ULWH2eEKMS3o
	 AbM/78VD6b7yxqrGt9TQw3GzIcpk4+dUNeaAoeqcXVzrHP878BrDXtw4+fuQvBIK5+9Fk
	 jXRc+likMq7vwi0kYemwoer7PRQ2kh21aVad/G4+n+Ul1CRevn0cD6hQrN7FNNpBjDk0U
	 sgHrO45OPDnxrdA1He9dBFIDDOESHFDLytjbiNw0/QdNEvOapXpidryu7gJGYzQxw0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+4d04eQ;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC74606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC74606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+4d04eQ
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e96502e447so8384285ad.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793375341; x=1793980141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0SM8LOepW7XUMwU+ZDps/Wc1zMBVt4O8GKS2q6Z4u8=;
        b=D+4d04eQJNhajRiaB/I4WmxG9SSWEVIKLvDiW/Xtl9BEtjCKOnJAdJlGXoYJ8Ty5mU
         3k3rpwu0l2ZuRD3pok82XroXZqJMeIsjFJna1hpFd9jFjb1PFs0a3ZfvfXu6+iLm2ill
         8n8xYrk1esDyGhU9vDTbBSkfnyicReSBuXfvKzzfwefaZr+fs97U6uA27pwtghUG6k7U
         HiTgO9ymxPrd1BtnUsE4N1FNZ46GqZ+hqRjG5btZpb8Ox/ID/6wrZjQRaGB/VO6xSs48
         abXganD5CymVh3SOknsSzr6GnPl3nGyuo5iuGIscL4md+lkadIVadsny1/Oi9xhjtjsD
         OzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375341; x=1793980141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0SM8LOepW7XUMwU+ZDps/Wc1zMBVt4O8GKS2q6Z4u8=;
        b=YYeY0JbZKuq6dHBCwMBiSopuZnYGz4uhfK84LMcJ3bBWck8nMFeS2ARuHC4WaAD8vx
         TayT9FRc3aBJIp9ER6Nxzbv62DR1ax4z/07i6dNNDaLh1IyX9RiuaowRazomtP2nE5Ne
         HNbg1FaFzaqBTTdW4d/hpojfTBOHOxsraaUL40TdTlqgT8ZGdemg4tc50tzozGcCQ3sa
         IvG7nbpf0SwRxkqS1G9xeKIzjhwH5bSePSXhNmTT2gRUxCo/rf9DaSXbAbdCixMsBzur
         VjyJzRgPiLN8iWd4f6m5tzZcLrZA+i4C794dSXlXVQayLrdGvpZw1kQ1ApgxqB4oXoU4
         F6Xg==
X-Forwarded-Encrypted: i=1; AKwUvBzfRM7Z9jKTXXnFiW8OwvIL4qbS9CRMGZSHJlP+lXP7BqEuFC058rbmsjZWJL6hv1mSFsG7Rdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhjWWjBdp+bLsOKpJHTG+jFJD1EE/T7qVJthxEco88a5uQDUzn
	POtLZOdCBaxuDNgo/AusOApcvkJQABejRC6qWMf8GqGTqf4ZtJcbo9Qx
X-Gm-Gg: AYBFou08W2Q66h/e2YVYqzUd4QkdMYzIzTTlc9g+wFd2hQ2A7XRSJF3yVUm7sXuCmM3
	AulSabixC9FX9Ec7qMGozl+hms2/3uoTvAQDSey5HtoKyckqe6vDDIN8AnsZTU8M21RxjgF+k2c
	RRAMBv04ZZqpGKoKP7H3xbeBpDQkjTAvzONxetWHdI5BUBGSzx05QNG+6jpPuk0qviD2WsWt0R/
	HVdzQlYC2z9BJ3tBEAfm0Tt237Sr2uFHdK8YTS6YOoRLUPqzMlBH9Nu9HpHS8miRThyhqIJfFM1
	8vVSOuwDwniyqsvMzus+dTdBUyL/kyRDuamAjF9OgCfEAP8deyKW+O89Od0/6gHR7ykQlYlf+N2
	BystXV6b+sBC82u4zZzZGAYSBNlM1SFO0zcxNZc1mSzRU/5xRkjUamruIVOlkfO/SBcVly/fv7C
	OFWEsQN78Vk3CE53oSjndAKPqs8A7WMSqXG726Cecv5Wt57Vs8GPc9mtsYcvt7rPg2ZY4+HW9Tj
	WWEZIxubQ070iug7je+ItLbkvjxSn418ZKOky+bbcX3WMm3RCvYIqkevqziSngbT5eijPhcADnp
	wvO0/TklSNDVRNcLsTMzVqpIhsG+UDyHLUxacrxzmHE=
X-Received: by 2002:a17:903:3c6c:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2eb3649bef0mr30087255ad.17.1793375341157;
        Fri, 30 Oct 2026 08:49:01 -0700 (PDT)
Received: from iZj6c0kydq3fvfrtx5kta5Z ([47.86.51.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39248621sm9426235ad.28.2026.10.30.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:49:00 -0700 (PDT)
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
Subject: [PATCH v3] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module is not initialized
Date: Fri, 30 Oct 2026 23:48:51 +0800
Message-ID: <20261030154851.907726-1-challvy.tee@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <auM3KKutfutAqgWG@thinkstation>
References: <auM3KKutfutAqgWG@thinkstation>
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

Gate the SEAMCALL on tdx_module_state.initialized, the predicate
tdx_get_sysinfo() already uses in this file: a kernel that never
initialized the module has no module to disable, and where it did the
gate is a no-op.  Doing it here rather than at the crash.c call site
also covers the syscore caller and any future one.

It also decouples kdump from the host KVM version -- a guest cannot
require its host to inject the #UD.

Fixes: 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and kdump")
Cc: stable@vger.kernel.org
Signed-off-by: Challvy Tee <challvy.tee@gmail.com>
---
v2 -> v3:
 - Rework the changelog around the VM exit mechanism from the review
   and scope the impact to guests on SEAM-capable hosts whose
   hypervisor does not handle the exit.
 - Shorten it and move the reproduction data below the fold.
 - Cc the author of the KVM commit now cited.  No code change.
   v2: https://lore.kernel.org/all/20261029094705.896693-1-challvy.tee@gmail.com/

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
  Emerald Rapids     0x6CF    Alibaba ECS    6.12.0-278.el10    no vmcore
  Granite Rapids     0x6AD    Alibaba ECS    6.12.0-278.el10    no vmcore
  Granite Rapids     0x6AD    AWS EC2        6.12.0-278.el10    no vmcore
  Granite Rapids     0x6AD    Tencent CVM    6.12.0-278.el10    no vmcore

Controls, each producing a vmcore: the same platform on a kernel
without 5b25f249be32 (tdx_sys_disable absent from kallsyms), platforms
without SEAM support (Skylake, Cascade Lake, Ice Lake, AMD), and plain
kexec.

With the gate applied kdump produces a vmcore on the two Alibaba ECS
guests; the others have not been retested.  No TDX host was available,
so the no-op case is reasoned from the code rather than measured.

 arch/x86/virt/vmx/tdx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 96ced0494b68..a7eae7492c1e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2321,6 +2321,9 @@ void tdx_sys_disable(void)
 	struct tdx_module_args args = {};
 	u64 ret;
 
+	if (!tdx_module_state.initialized)
+		return;
+
 	/*
 	 * Don't loop forever.
 	 *
-- 
2.52.0

