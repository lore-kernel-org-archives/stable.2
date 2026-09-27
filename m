Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069092931EF;
	Sun, 27 Sep 2026 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470783; cv=none; b=Cf748bf79wDZdUnNPqFKPqWPnv2YfIUp41dapWZh9XdWkqXAn/+3PmAJfQBmh2VZobSPCYas9nBSDSjQY3anMYRMeU7h28c1qBBJu4KpLxom6Tk7SMVUSecH142Wc5CRYKd91prvgAW115L1RuAOy4mhGQrN8tRS91jdzyZRON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470783; c=relaxed/simple;
	bh=QwIxzJa80SeiE/jYIqB5vrXXWt1x9Kwvdfei1JpPdoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhmEvVH8RukspIhc//EhcaoSch5QmMOb5ZQ3f6RZ3zS1AIaxGuQleuh13XHt/Yznq5mO4XRjVORuF7T1QeVwEY4QD2UNJp43Sq4xY1g1xsX8nEWUoze8kK1PoldoX1Hhgnz571uSYqhQdFVXZRCjDNYH64noqJz84hiFY7XQofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjyvmlJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjyvmlJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DB61F00893;
	Sun, 27 Sep 2026 00:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470781;
	bh=X1o4VZ0Vt38V/kOCvsysc8C3Tlcep57CATOtWtGvtS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GjyvmlJA7qVTBv+6Wg2hhkm7Tma81Edh1Oe3XD0GXYVUpB7QMMscYf6erdA0BLi+0
	 OnfpkQ4Z18ReOR+AZewKyTnAEtWf+czGpbv+ZNZi2gstn/pXuRU9ecJF6hC90rOV99
	 9MAKTPCDlxV0LrGbABGMK5kjfDKRnoGvrxXh2A0O0J7zX648sWYQspB8YfzBTrsyHq
	 wXLGuvn2ShckCsCDrRev+h1+DxBGzpELdW7U691226fYW5SDxdcGE74gYra+PnNUzK
	 uUfAvoG4Zzd+UeEZaqw56SxwHqddfr6P3ckeyZbRol7w6qcGQlgPku9dEKPnKJWEP2
	 bS/A+QjQNRXcA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sparc64: fix the build with CONFIG_COMPAT=n
Date: Sun, 27 Sep 2026 02:58:36 +0200
Message-ID: <20260927005837.8402-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927005837.8402-1-kaloz@kernel.org>
References: <20260927005837.8402-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 32-bit syscall trap vector already falls back to BTRAP() when
CONFIG_COMPAT is off, but nothing else in the entry path does, so that
configuration has never linked:

  head_64.o: undefined reference to `sys_call_table32'
  head_64.o: undefined reference to `sys_llseek'

linux_syscall_trace32 and linux_sparc_syscall32 are reachable only
through that vector, so build them with CONFIG_COMPAT. _llseek is entry
236 of the 64-bit table too, while fs/read_write.c provides it on a
64-bit kernel only for CONFIG_COMPAT or __ARCH_WANT_SYS_LLSEEK, so ask
for it as powerpc does.

Fixes: 852fed2e8bfe ("sparc: Disable compat support with LLD")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/include/asm/unistd.h | 2 ++
 arch/sparc/kernel/syscalls.S    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index d6bc76706a7a..76571120a1c6 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -45,6 +45,8 @@
 #else
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
+/* _llseek (236) is in the 64-bit table, so it must not depend on COMPAT. */
+#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #define __ARCH_WANT_COMPAT_STAT
 #endif
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 96fe8763d70c..82f0c96c243a 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -156,6 +156,7 @@ linux_sparc_ni_syscall:
 	ba,pt	%xcc, 4f
 	 or	%l7, %lo(sys_ni_syscall), %l7
 
+#ifdef CONFIG_COMPAT
 linux_syscall_trace32:
 	call	syscall_trace_enter
 	 add	%sp, PTREGS_OFF, %o0
@@ -185,6 +186,7 @@ linux_syscall_trace32:
 	srl	%i2, 0, %o2
 	ba,pt	%xcc, 5f
 	 srl	%i3, 0, %o3
+#endif
 
 linux_syscall_trace:
 	call	syscall_trace_enter
@@ -217,6 +219,7 @@ linux_syscall_trace:
 	 mov	%i4, %o4
 
 
+#ifdef CONFIG_COMPAT
 	/* Linux 32-bit system calls enter here... */
 	.align	32
 	.globl	linux_sparc_syscall32
@@ -240,6 +243,7 @@ linux_sparc_syscall32:
 	 srl	%i5, 0, %o5				! IEU1
 	ba,pt	%xcc, 3f
 	 sra	%o0, 0, %o0
+#endif
 
 	/* Linux native system calls enter here... */
 	.align	32
-- 
2.47.3

