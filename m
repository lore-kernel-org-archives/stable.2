Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04144C4FB;
	Fri,  7 Aug 2026 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083611; cv=none; b=Z9RmqpaaTdq/dyKmv0UOsI867da2KDbnCG8Ldi27v+3bz+Oa8aBOPdG71vYbAt5sGUfm28/puUGVwelofhnEhaCWWI8x6AeBwg6CCBxd95940g4kvfb3cpyQBTwMwLIF85ff+GMlqjUWuwcrJHGu+15ppQx7/6ptf6z+o/qe9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083611; c=relaxed/simple;
	bh=KA9YESb9sPwdliAWcjl12negHhpSs/n1hGCdjNJgtjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7Vwgoar0RVJ5Sd1nWUzVaLg9mCtoPQegqWqJ5K/9VlwHlFOm4hLaxTQGq+aV+wItopIsfohPyt1n5l+50X1NkTwFJwfhI6xucTT+YSjGcecC8vTdUt50UVDV3Uq2KI3FRmajyN6ejXzk39SsbtulX58GG+icA9mtERPEKruPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=edRd7FYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="edRd7FYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27E71F000E9;
	Fri,  7 Aug 2026 06:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083610;
	bh=BPQl7rLI8EYdNc4pSI9dWtid5pUc7h/DOFbx7r4C1EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edRd7FYHDHpn0Yc4tpJxQozNgDL7DH3LunXpZbXe1PeGCOcJFBMMtI0GbwV388VDb
	 zsGIKH8UbKA67s1E0h+aAEwvNxuqyFm+g6VSDryGoRaM3gb+Xp9PDiYKl6ka4W12dT
	 HmC85YTsBCJNMy41WYzntAMf1fEtBagL9XpQDWgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.150
Date: Fri,  7 Aug 2026 08:19:49 +0200
Message-ID: <2026080748-fidelity-alias-c79b@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080748-herring-unsocial-031b@gregkh>
References: <2026080748-herring-unsocial-031b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index f64070d333e2..c05bee52eb20 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 149
+SUBLEVEL = 150
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 43a2daeef5ef..9a1531a43ce1 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -219,11 +219,14 @@
  * The LFENCE fixes this by ensuring step 5 is never reached speculatively.
  * Note that this LFENCE only occurs if safe-RET was actually interrupted (so
  * it's outside of the normal path).
+ *
+ * (The 128 below is RIP offset, used as a naked number here for ease of
+ * backporting).
  */
 #define __HANDLE_INTR_SAFERET(name, pt_regs)		\
-	cmpq	$(name), RIP+pt_regs;			\
+	cmpq	$(name), 128+pt_regs;			\
 	jb	1f;					\
-	cmpq	$(name)+5, RIP+pt_regs;			\
+	cmpq	$(name)+5, 128+pt_regs;			\
 	ja	1f;					\
 	lfence;						\
 	leaq	pt_regs, %rdi;				\
@@ -360,7 +363,7 @@
 	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH_FROM_CALL)
 
 .macro HANDLE_INTR_SAFERET pt_regs
-#ifdef CONFIG_MITIGATION_SRSO
+#ifdef CONFIG_CPU_SRSO
 	ALTERNATIVE_2 "", \
 	__stringify(__HANDLE_INTR_SAFERET(srso_safe_ret, \pt_regs)), X86_FEATURE_SRSO, \
 	__stringify(__HANDLE_INTR_SAFERET(srso_alias_safe_ret, \pt_regs)), X86_FEATURE_SRSO_ALIAS
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bf57acd42186..72de35d67bc7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3490,7 +3490,7 @@ ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char
 }
 #endif
 
-#ifdef CONFIG_MITIGATION_SRSO
+#ifdef CONFIG_CPU_SRSO
 /*
  * Called during exception/interrupt entry if interrupted during the
  * safe-RET sequence.  The safe-RET sequence consists of 3 instructions:
@@ -3527,4 +3527,4 @@ void noinstr handle_interrupted_saferet(struct pt_regs *regs)
 	/* 2. Pop rIP off the stack: */
 	regs->sp += 8;
 }
-#endif /* CONFIG_MITIGATION_SRSO */
+#endif /* CONFIG_CPU_SRSO */
