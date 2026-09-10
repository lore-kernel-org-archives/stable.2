Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42223D349E;
	Thu, 10 Sep 2026 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031265; cv=none; b=t8e0NuYxaQOp43JwqtR4VJXk1kY4Yho2tJT7lz93l9lsV9c3e3AbFSHVNNJ2RGxkkED33PD04u7wHDgmLawLflvqQ8vZZBYwELZUjAAfwA3O9zqqO2nx9NXW1Q9ZBFZP9YIv/CJU3hzyJpaRh+DJEseE3n1yuh3aCR/VFCXuxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031265; c=relaxed/simple;
	bh=U8Hlo2wkrkvrYeycjwxZvKGRyqP7Th0ecOn6/5niTE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LNE48B3n66ithH2YG7S5Bbm8kTrzVJGekVqiSgXZJah8nWR4UfA7ygrWJWbuZNR7wwCRkwFuCa46QbWrcx6wqNPDsbW1KryhJZ7BnUOAwlcnfh7S7gHkbtbh+JcDw31oJ3Bfb5wMObbS1jPi3LYCwvR5Nzd6uDymw/6Ri2GbSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0aUICLpB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=napS3j3Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0aUICLpB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="napS3j3Y"
Date: Thu, 10 Sep 2026 09:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789031261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T9nvI18Ju6xu6qvor7q2alm/05RmkN01+L0tyWsp9A=;
	b=0aUICLpBqA1E6PtAS6Ch3u1IAB5zrmW0Y5rBYdWeFLWa0Hi5ZZX6SfYtAlo26LTSil5hDE
	HUISumJQ9iuQuGsmT+Ktc6d3FhC4zjxg1C1bw1ka2BBDOHVASbMzPLsnoiEA0/Ex8Qg/zG
	KmrPtkPB6nwOE55/my4V9cgth/pU4lGOkmIT1VjHwKdCjyIQoSXywrWLOWgY4Wtwp6JcTA
	Zh/5s2T9X1ES/h868xdAlBFiLn09zKrvkySif0eUlC9roBL40W9WNOgLazRyy7D6Lax+BU
	XgOgqw6ScUDNXVppyFX1q8LygUlDyjdB+bPkoIVra4TDoLAFk3aqrnh1nCX00Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789031261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T9nvI18Ju6xu6qvor7q2alm/05RmkN01+L0tyWsp9A=;
	b=napS3j3YRxcHLwwg+QzmgKKTiAuzT1WHM6TAoaXY/YEkZp/wI+PyZffRMwScFVX3H9tKcF
	tot8+nN01RJGxIBQ==
From: "tip-bot2 for Soheil Hassas Yeganeh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()
Cc: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, #@tip-bot2.tec.linutronix.de,
	6.18+@tip-bot2.tec.linutronix.de, x86@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To:
 <20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ffc0af5c4ec@gmail.com>
References:
 <20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ffc0af5c4ec@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178903126017.623050.9781792197599239541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5a5d26f2cfe13467166219f6bf58099326912ddb
Gitweb:        https://git.kernel.org/tip/5a5d26f2cfe13467166219f6bf580993269=
12ddb
Author:        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
AuthorDate:    Mon, 31 Aug 2026 14:48:44=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2026 11:01:31 +02:00

x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()

The switch of the FineIBT preamble from "subl $hash, %r10d" to the
shorter "subl $hash, %eax" moved the hash immediate from offset 7 to
offset 5 of the preamble. fineibt_preamble_hash was updated to match,
but the open-coded offset in cfi_get_func_hash() was missed and it
still reads the hash at offset 7.

cfi_get_func_hash() is used by the BPF JIT to give a struct_ops
trampoline the CFI hash of the stub function it stands in for. With
FineIBT the trampoline now gets the upper half of the real hash
followed by the first two bytes of the next instruction, so the first
indirect call from the kernel into a struct_ops program,
tcp_init_congestion_control() calling ->init() of a BPF congestion
control for example, fails the FineIBT check and the kernel dies with
a CFI failure.

Move the FineIBT preamble template and its offset defines above
cfi_get_func_hash() and use fineibt_preamble_hash there, so every
reader of the preamble shares one definition of its layout. The
CFI_FINEIBT arm is only built with CONFIG_FINEIBT, the only
configuration in which cfi_mode can take that value.
cfi_get_func_arity() does not need the same treatment: the __bhi_args
call whose displacement it reads still ends at the function address.

Fixes: 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA")
Assisted-by: LLM
Signed-off-by: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org # 6.18+
Link: https://patch.msgid.link/20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ff=
c0af5c4ec@gmail.com
---
 arch/x86/kernel/alternative.c | 72 +++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index add62db..741d876 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1201,6 +1201,41 @@ static bool cfi_debug __ro_after_init;
 bool cfi_bhi __ro_after_init =3D false;
 #endif
=20
+#ifdef CONFIG_FINEIBT
+/*
+ * <fineibt_preamble_start>:
+ *  0:   f3 0f 1e fa             endbr64
+ *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
+ *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
+ * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
+ *
+ * Note that the JNE target is the 0xD6 byte inside the NOPL, this decodes as
+ * UDB on x86_64 and raises #UD.
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_preamble_start:			\n"
+	"	endbr64					\n"
+	"	subl	$0x12345678, %eax		\n"
+	"fineibt_preamble_bhi:				\n"
+	"	cs jne.d32 fineibt_preamble_start+0x13	\n"
+	"#fineibt_func:					\n"
+	"	nopl	-42(%rax)			\n"
+	"fineibt_preamble_end:				\n"
+	".popsection\n"
+);
+
+extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_bhi[];
+extern u8 fineibt_preamble_end[];
+
+#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
+#define fineibt_preamble_ud   0x13
+#define fineibt_preamble_hash 5
+
+#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
+#endif /* CONFIG_FINEIBT */
+
 #ifdef CONFIG_CFI
 u32 cfi_get_func_hash(void *func)
 {
@@ -1208,9 +1243,11 @@ u32 cfi_get_func_hash(void *func)
=20
 	func -=3D cfi_get_offset();
 	switch (cfi_mode) {
+#ifdef CONFIG_FINEIBT
 	case CFI_FINEIBT:
-		func +=3D 7;
+		func +=3D fineibt_preamble_hash;
 		break;
+#endif
 	case CFI_KCFI:
 		func +=3D 1;
 		break;
@@ -1367,39 +1404,6 @@ early_param("cfi", cfi_parse_cmdline);
  */
=20
 /*
- * <fineibt_preamble_start>:
- *  0:   f3 0f 1e fa             endbr64
- *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
- *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
- * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
- *
- * Note that the JNE target is the 0xD6 byte inside the NOPL, this decodes as
- * UDB on x86_64 and raises #UD.
- */
-asm(	".pushsection .rodata				\n"
-	"fineibt_preamble_start:			\n"
-	"	endbr64					\n"
-	"	subl	$0x12345678, %eax		\n"
-	"fineibt_preamble_bhi:				\n"
-	"	cs jne.d32 fineibt_preamble_start+0x13	\n"
-	"#fineibt_func:					\n"
-	"	nopl	-42(%rax)			\n"
-	"fineibt_preamble_end:				\n"
-	".popsection\n"
-);
-
-extern u8 fineibt_preamble_start[];
-extern u8 fineibt_preamble_bhi[];
-extern u8 fineibt_preamble_end[];
-
-#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
-#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
-#define fineibt_preamble_ud   0x13
-#define fineibt_preamble_hash 5
-
-#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
-
-/*
  * <fineibt_caller_start>:
  *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
  *  5:   4d 8d 5b f0             lea    -0x10(%r11), %r11
