Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261346;
	b=dLZs2Wa4+RKauAuOcmzOq6eqWk+Wa3/LlFS9mqXV9+J0Sp70NX3njg4VLieulvq6aDGD
	 HQ36/yjR12UkChahQtGedyZJ9wS/WeuvfLpabpPZaGXd5Jln3LNQTzLNShSellXt4VrTp
	 ieYe/EXPCuQP+qgZMvqviNwW8FscKXI3xHOVNDMMFaSGoTQx9tq1Y94CKuiXPN1BzDo97
	 zb99rwSIPjR+cqWNgkd8UqanR+ClQywNow8Af+u4uqzpFL8k2/iR2ivac3C5HcYIhExip
	 zGQnMgODMl1EG+B6uhsBz7BFXtsFlN8Ql3JzDUkb3tL3mCAqFKs9lCvpacKUF71Q5DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7N4WlmfqA0hZpWuGR6iMpWTfdh9oVVPUBDUfmb8WE2Q=;
	b=kG2chOmsJEciFaItofllbll4I2RWGA4FpkiIwIlDqcue5v1nWtbYvwPZWd21tXC2ziPA
	 TTgI9kp+jJnqSWsDgB/0kAlB2woqc+ARiptHaiXmbRmmbcE1Lp7B82soF4OOd1qhvwYF4
	 axWaf9oUdPt0gur1rg9WRX3bHnVDUHnLHN4A/W08eTbjVfW2Xmpwu0j+iqLzJySG55iap
	 NWiQlbEfOUenSn6aVPbMdEz0gc57+KvDtKYBzIhm4rzPWL5Mq9KxiAZqVKmvyaHePn/q9
	 a6Ufd6kAVpc1VjC4WbOvFZWhrMYSYCqtZXOYwRD4ynDo4MEJGF38gesG6jNjib0jsjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cNOYWyqw;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B0606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 020B0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cNOYWyqw
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9e53d011eso13156935ad.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793261345; x=1793866145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7N4WlmfqA0hZpWuGR6iMpWTfdh9oVVPUBDUfmb8WE2Q=;
        b=cNOYWyqw8rfUEpeQ0i9U5W9LwXEVCNsLmX+0K3jiSekccz6Wo+QJ43CR8MqJtbLR+u
         SYlgD+eXv+dji5REvVJ3SkHEmSUzmV9kVcPU7zDgZcisEg2LVmJyS5zJc5F237w7i3jJ
         ULYyZrDfIZduP2xw/y/+qfhCAun7AxwsBbWo44J80O63hqV8BswuXd2b6xqoNaI974l8
         gbol3fG28bA/ECrahTNBqs01AsdWkPbeZJ8d95PWOrsK8lVD9tk+fYJ91LtdzOBYAees
         Dqaym6U13NzuBGUgE8RY4+IcyoQvkp56XU0/zy3wFN6FR711n/Bsoe+0Gcq+5hLiiCLK
         fVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261345; x=1793866145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7N4WlmfqA0hZpWuGR6iMpWTfdh9oVVPUBDUfmb8WE2Q=;
        b=bleo+VP6+apjzWuvPqEp6ThiDFAwzxkSs+ZyxGXl77P39vRSQvcSkAF7Jqw8xz3c1d
         ybFJkPOEOrRTRzQVAdoBJZ3eVGOWqegiqNP1mqUG+B2iOh4cJPeOELybnbqzCNHffyig
         mWNbK/cYxBvxcjFfw0eqEu3nO6mBjxApQT+PWMBFT47CsdQoggM0vUE266HRTb3Vdkj5
         /5DFARI9XLrLwqutf837+VYl4cC7kjUvGud6SoPdG5tXS4bJ/bRv1/BFwcVeqxvluPPB
         NYWv0JHgCL2bv88FzI56kRh0inf/wZXYRTRqg9KBc0TSw59FHSHFsAZ0tCyspRLLVZps
         787Q==
X-Gm-Message-State: AFq9FYJqcjy4/ufPALN7q2eiYuWYfOIZvS+/NAlKVIrRpgEATV8GCSjn
	BuJW70jjoSiOfkjOftlfCNw2g3aNh+XmKPAUyNkqFlekd3kOwTNMfIiVFOGXAhBWip8=
X-Gm-Gg: AYBFou2kaGVsBeyUATruAHPDp7WqBu3vS5GXtU+eEgZ1MQzqHTxCeh1XRIGwH8asJTx
	/5AcNbojw4Q8mJnqGU2f/dqH8uQisrGdL5AUDb/vyWl8vlgLeWcC5pq/quBkYKO5QUWssZiDP4N
	k8wSeea4u2FvHl4Cvk5KWhX4nEctspg0uo53xjGMXBKpqdfjolq58BzlA7M62pXavm1HyPYcLzZ
	6JaXtFtOSCa1E4r7fXiuwH2qLpXl9te7MGC1mgIxwDy/0HddNW8jlCwcuf0nSYDOJtbGn6hFug+
	nRS0dliuKnKDEAChNMu3HIRyCvOONw+SKpVDQ4e19tI6mcUyLugNpOFLyHcPz7nyq69XRepI4IG
	6fkIEFvFjDQZZW4AyX+b2mRdlhlx83b4rvV22+0zxvOQpWp8Y0ejFeFPYbgGGuMA0HCTqU7NYzf
	Okzax21Vo+dUSpxg/JpVyI8UCdoexPy0udJPxBV/anwfkk2BHQJ55WzUWHTrXqNltxCREWpShmu
	VRYYMgJSweCd0sxAbt9SXwYbZ7gaQY1reuAcOvRXdLCMF0nq1MYIBSeywtkRSFFtk9gT3H57VXz
	zzmoWDpcxBIjfCSQEABs0oJTiaOcnWhwEx9GK4n2Y1Q=
X-Received: by 2002:a17:903:94d:b0:2e9:4b9f:b81f with SMTP id d9443c01a7336-2eb003cdd41mr47516255ad.31.1793261345179;
        Thu, 29 Oct 2026 01:09:05 -0700 (PDT)
Received: from iZj6c0kydq3fvfrtx5kta5Z ([47.86.51.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ca1bb2sm30116645ad.68.2026.10.29.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:09:04 -0700 (PDT)
From: Challvy Tee <challvy.tee@gmail.com>
To: challvy.tee@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module is not initialized
Date: Thu, 29 Oct 2026 16:07:31 +0800
Message-ID: <20261029080731.890996-1-challvy.tee@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Commit XXXXXXXXXXXX ("x86/tdx: Disable the TDX module during kexec and
kdump") made native_machine_crash_shutdown() call tdx_sys_disable(), but
tdx_sys_disable() has no runtime gate: its only guard is compile time
(CONFIG_INTEL_TDX_HOST), which distribution kernels enable.  On a system
where the TDX module was never initialized, kdump now issues a
TDH.SYS.DISABLE SEAMCALL that it did not issue before, and the crashing
CPU stops making forward progress before machine_kexec().  The capture
kernel is never entered, no vmcore is written and nothing reaches the
console, so kdump is completely non-functional.

Having the TDX module uninitialized is an ordinary state rather than an
error.  tdx_enable() returns -ENODEV early when
X86_FEATURE_TDX_HOST_PLATFORM is absent, and it also bails out if
init_tdx_module() fails.  Any guest whose host does not expose TDX is in
this state and logs:

  virt/tdx: TDX not supported by the host platform

The syscore path is implicitly protected: register_syscore() only runs
after init_tdx_module() succeeds, so tdx_shutdown() cannot be reached on
an uninitialized system.  That covers kexec, suspend and resume, which is
why only kdump regressed.

The crash path calls tdx_sys_disable() directly and bypasses that
protection.

Where the CPU has no SEAM support the SEAMCALL raises #UD, which the
exception table entry in tdxcall.S turns into TDX_SEAMCALL_UD, so
tdx_sys_disable() just returns and kdump still works.  On SEAM capable
platforms the observed behaviour is the hang described above.

Reproduced with 'echo c > /proc/sysrq-trigger' in VM guests running on
Intel Sapphire Rapids, Emerald Rapids and Granite Rapids platforms.
Before this change no vmcore is produced; after it, kdump completes
normally.  Guests without SEAM support, and plain kexec everywhere, were
unaffected both before and after, matching the asymmetry above.

Gate the SEAMCALL on tdx_module_state.initialized, the same predicate
tdx_get_sysinfo() already uses in this file.  Putting the check inside
tdx_sys_disable() rather than at the crash.c call site also covers the
syscore caller and any future caller.

Fixes: XXXXXXXXXXXX ("x86/tdx: Disable the TDX module during kexec and kdump")
Cc: stable@vger.kernel.org
Signed-off-by: Challvy Tee <challvy.tee@gmail.com>
---
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

