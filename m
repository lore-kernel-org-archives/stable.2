Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563499;
	b=t1XFWTmLxjhTmYfmDmWgKvzlZOTt1sxe84kVPDycRFCR6inzhz2uKcEI9UEgzBy7FcrN
	 8oFZY07qzHDUlPpF5EdL2dWpkkBWYvQskelfvmrf555299RH6tzSyrf3nX0EIf2Vk/mAw
	 V9IFSpbqZAd0ReSm1Tgk2hWmgC1lQO/NGZOpigXw0J0caGNII6M7/uvWznTqWnvh6tMXp
	 DY+XeFonpJRRobjKveRdIlNqv014pKJSF/K/rt+fg4Ag6nuX5zqI71xKqS80uf82xgY4n
	 EvrAbkWHBVrDUNq3+q+1fVxMwsSdGArhFZdovQWaA8GZc1SrLuTRojLabdBXijDY4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563499;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:X-B4-Tracking:X-Change-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=4PU89QwU68LrW3sJImUGX91LxCYEkUcPPey1S+s13qM=;
	b=nZN5bTBbsXZbxYPQJJcZp+W3MoG+/MZPSBijAHT/GNL0YmJbw8OEDiMrr5/wyW2wDGvy
	 ZY6qLhmI6bsrtgKhh0fTW0xEu9+qnGs2RWF4nb/VBalJ2bDXbs3yxU5QMJn4X0xmzgf+A
	 58V7qDvoGQGPUhMrvzwlWghXamr103OJ/b7LSQ0RtqLwE/C6l9KGa3SszJ8x1lc7T1YlN
	 UfW6wKbOCviz6BHJmqiM9m4+E4WXltfSt/faea4t7BvxyiRiEUOHuTfNq1aWhyLYDJ46f
	 fIkCm4LbwUXrO40mbuAiIh4TRzcmMxG9V0GkJYH2K4CVSdeOgD2HJn7PkhlXS1oXYqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niA3MBir;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709B606A31E;
	Tue, 24 Nov 2026 23:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7709B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niA3MBir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795563498; x=1827099498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MRZPPyR6ZqF34fP+tah/EHivSvxSMcRvQ5hawpHzCPM=;
  b=niA3MBirBepic8NG6lx1PTG322qXaoUCzckwlpF0F6wWwXYNMW3Ak1rB
   m2O6WjCL0Cevv96abbvZ/bZIkYxl65GRLQvnBkJ3u+fkXc6bAy20IjksL
   mmJO5WsLtHFaT09bS9t5njba6jEYjB+g75OuHnRF/UaxRSnifi2Akc4dD
   ZVkl/mnUQwIOK2nIharYR1CC4smEe0Sw6Hx8hdGOqOhNFlYRYlewsQUs4
   HlbgrzgjqRAwEYq304p9DEUky/tPKStxrxnnl9fTUO3fBrk3L7+/OINNI
   m4QUQjIyV67NsM2EkMb/mB/Pc3BAHBEuDWQxdtrUaaFseYMw5V6mLLNI+
   w==;
X-CSE-ConnectionGUID: TcVUjcQzQreQNJh/URy8zw==
X-CSE-MsgGUID: /zrrLe6kSqyp9WmRsli+YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4441221"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4441221"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 15:38:18 -0800
X-CSE-ConnectionGUID: NFHe3L7WTVuVLE3jn7h6yQ==
X-CSE-MsgGUID: BLz4NK4MRQWi1DWLqrjJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11901365"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 15:38:17 -0800
Date: Tue, 24 Nov 2026 15:38:17 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, peterz@infradead.org
Cc: Alexandra Sandulescu <aesa@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: [PATCH] x86/its: Account for CS prefixes to indirect branches
Message-ID: <20261124-its-cs-prefix-v1-1-10f2c01687cf@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAKEfBmsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMT3cySYt3kYt2CotS0zArdlORUU0NL06Q007RkJaAeiDDYvGilAMc
 QZw+lWIhwcWlSVmpyCcgspdpaAL36P154AAAA
X-Change-ID: 20261124-its-cs-prefix-dce5195bf5fc
X-Mailer: b4 0.17-dev
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

cpu_wants_indirect_its_thunk_at() finds the last byte of an indirect
branch as addr + 1 + reg / 8. This assumes the branch has no prefix
other than REX.B. But since commit 4a1e02b15ac1 ("x86,retpoline:
Optimize patch_retpoline()"), emit_indirect() pads an indirect CALL
with up to three CS prefixes. These prefixes move the end of the branch
by up to three bytes, and the ITS check looks at the wrong byte. A CALL
that ends in the lower half of a cacheline because of the CS prefixes
does not get the ITS thunk.

ITS mitigation must use the same CS prefix logic as emit_indirect() to
find the correct end of the branch. But emit_indirect() also adds INT3
padding for SLS.

Move the encoding of the branch itself into pre_emit_indirect_unsafe()
and keep the SLS INT3 padding in emit_indirect(). The CS prefix logic
does not change. Let ITS mitigation call pre_emit_indirect_unsafe() to
get the actual end of the branch.

The new pre-emit version must not be used directly for patching, as it
leaves out the SLS guard.

Fixes: 4a1e02b15ac1 ("x86,retpoline: Optimize patch_retpoline()")
Reported-by: Alexandra Sandulescu <aesa@google.com>
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 62 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index efbc11f8c336..16e0bce7fd6e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -721,11 +721,15 @@ static inline bool is_jcc32(struct insn *insn)
 #if defined(CONFIG_MITIGATION_RETPOLINE) && defined(CONFIG_OBJTOOL)
 
 /*
- * [CS]{,3} CALL/JMP *%\reg [INT3]*
+ * This only encodes the indirect branch without the INT3 padding required for
+ * SLS. Therefore, it is unsafe to use this for patching directly. ITS
+ * mitigation uses this to identify the branches that require mitigation.
+ *
+ * [CS]{,3} CALL/JMP *%\reg
  */
-static int emit_indirect(int op, int reg, u8 *bytes, int len)
+static int pre_emit_indirect_unsafe(int op, int reg, u8 *bytes, int len)
 {
-	int cs = 0, bp = 0;
+	int cs = 0;
 	int i = 0;
 	u8 modrm;
 
@@ -747,7 +751,6 @@ static int emit_indirect(int op, int reg, u8 *bytes, int len)
 
 	case JMP32_INSN_OPCODE:
 		modrm = 0x20; /* Reg = 4; JMP r/m */
-		bp = len;
 		break;
 
 	default:
@@ -769,8 +772,24 @@ static int emit_indirect(int op, int reg, u8 *bytes, int len)
 	bytes[i++] = 0xff; /* opcode */
 	bytes[i++] = modrm;
 
-	while (bp--)
-		bytes[i++] = 0xcc; /* INT3 */
+	return i;
+}
+
+/*
+ * pre_emit_indirect_unsafe() + [INT3]*
+ */
+static int emit_indirect(int op, int reg, u8 *bytes, int len)
+{
+	int i = pre_emit_indirect_unsafe(op, reg, bytes, len);
+
+	if (i < 0)
+		return i;
+
+	/* Pad INT3 to tail calls against SLS */
+	if (op == JMP32_INSN_OPCODE) {
+		while (i < len)
+			bytes[i++] = 0xcc; /* INT3 */
+	}
 
 	return i;
 }
@@ -840,13 +859,23 @@ static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes
 }
 
 /* Check if an indirect branch is at ITS-unsafe address */
-static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
+static bool cpu_wants_indirect_its_thunk_at(int op, int reg, int len,
+					    unsigned long addr)
 {
+	u8 bytes[16];
+	int ind_len;
+
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return false;
 
-	/* Indirect branch opcode is 2 or 3 bytes depending on reg */
-	addr += 1 + reg / 8;
+	if (WARN_ON_ONCE(len > sizeof(bytes)))
+		return false;
+
+	ind_len = pre_emit_indirect_unsafe(op, reg, bytes, len);
+	if (ind_len <= 0)
+		return false;
+
+	addr += ind_len - 1;
 
 	/* Lower-half of the cacheline? */
 	return !(addr & 0x20);
@@ -854,7 +883,8 @@ static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
 #else /* CONFIG_MITIGATION_ITS */
 
 #ifdef CONFIG_FINEIBT
-static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
+static bool cpu_wants_indirect_its_thunk_at(int op, int reg, int len,
+					    unsigned long addr)
 {
 	return false;
 }
@@ -941,7 +971,7 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	 * Check if the address of last byte of emitted-indirect is in
 	 * lower-half of the cacheline. Such branches need ITS mitigation.
 	 */
-	if (cpu_wants_indirect_its_thunk_at((unsigned long)addr + i, reg))
+	if (cpu_wants_indirect_its_thunk_at(op, reg, insn->length - i, (unsigned long)addr + i))
 		return emit_its_trampoline(addr, insn, reg, bytes);
 #endif
 
@@ -1471,6 +1501,7 @@ extern u8 fineibt_paranoid_end[];
 
 #define fineibt_paranoid_size (fineibt_paranoid_end - fineibt_paranoid_start)
 #define fineibt_paranoid_ind  (fineibt_paranoid_ind - fineibt_paranoid_start)
+#define fineibt_paranoid_ind_size (fineibt_paranoid_size - fineibt_paranoid_ind)
 #define fineibt_paranoid_ud   0xd
 
 static u32 decode_preamble_hash(void *addr, int *reg)
@@ -1772,13 +1803,14 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 		memcpy(bytes, fineibt_paranoid_start, fineibt_paranoid_size);
 		memcpy(bytes + fineibt_caller_hash, &hash, 4);
 
-		if (cpu_wants_indirect_its_thunk_at((unsigned long)addr + fineibt_paranoid_ind, 11)) {
+		if (cpu_wants_indirect_its_thunk_at(op, 11, fineibt_paranoid_ind_size,
+						    (unsigned long)addr + fineibt_paranoid_ind)) {
 			emit_paranoid_trampoline(addr + fineibt_caller_size,
 						 &insn, 11, bytes + fineibt_caller_size);
 		} else {
-			int len = fineibt_paranoid_size - fineibt_paranoid_ind;
-			ret = emit_indirect(op, 11, bytes + fineibt_paranoid_ind, len);
-			if (WARN_ON_ONCE(ret != len))
+			ret = emit_indirect(op, 11, bytes + fineibt_paranoid_ind,
+					    fineibt_paranoid_ind_size);
+			if (WARN_ON_ONCE(ret != fineibt_paranoid_ind_size))
 				continue;
 		}
 

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261124-its-cs-prefix-dce5195bf5fc

Best regards,
--  
Pawan


