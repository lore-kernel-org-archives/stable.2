Received: from mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8AD36F434
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289769; cv=none; b=TPqlKDwP9S189RuE9vvNfScmB+NuGFZYDqsHIQtrYNRM9SkrrZujrxvFIxQ56l06kIACnhC+CpnU9p0QHVO5rzrfE4k0/I1l1M4/hYxeBrYwL+/MVoMLqgZAu05d04WGSk1iq665E22zpHh2bLhB3BkDHVbxYZpydnS1C0Z1oek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289769; c=relaxed/simple;
	bh=WRPL/H0LrA/BKC4g71mMipRThq8ER0G25bE1inVY1ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BnALNLg3G2ZefvDwUjg2Z/utE7ED6iyN/z0SkNNH9tlTYRqBh3P6CgNdDLbOjBO76MznX38OoHgKR69Fl/WGCzc+OIhTxLqZ+NEKEBxCzqTjbArP8a7FMQWCQIm41+meoGTVRZDUfVScFy8UD1+M1b7EcDdlv8/AOUIt4ovy0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev; spf=pass smtp.mailfrom=cressey.dev; dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b=M8uxa+x1; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b="M8uxa+x1"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WRPL/H0LrA/BKC4g71mMipRThq8ER0G25bE1inVY1ww=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790289764; v=1; x=1790894564;
 b=M8uxa+x1EgcdMivO9OwY+7QaX6MRK+r6ztKF+95QExiaFoS9Iq2uxFuSFzvWFZIsPw8FHyJl
 55HOpmJpG9mO6EL5dasJFrMiO7ToSHdJ9K9dUCmcc/zTsQH7bc8CkYH/kNZzD8+/yHQU0iWzpmL
 OUJR/k6PPfC/MAL+AMJinC3iuVXwXq4JDq/TLXkLqSSKBxoTFI+D7CTmOSGRaPIn5sFk0fwV5uI
 MyINjT1Q74dmu2b/AO4UBPkCvdc5Cgr6H2TuBiQRZthPpbgBTopw1MMUsSfMVvpE8oXVSNeGtvB
 3BoB2y+RTihECm+J62I47Sc1ZqmcKprYI9nQ1kD1c35tg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9c16178fdf9bcaa3;
	Thu, 24 Sep 2026 22:42:34 +0000
X-Mizu-Trace-ID: 9c16178fdf9bcaa3
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Date: Thu, 24 Sep 2026 22:42:30 +0000
Subject: [PATCH] arm64: kexec: mark machine_kexec() __nocfi
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
X-B4-Tracking: v=1; b=H4sIAFWntWoC/2XMQQ6CMBCF4auQWTsRa63iVYyLMj5kNBbSqiEh3
 N1Wly6/ybx/poSoSHSsZop4a9IhZGxWFUnvwxWsl2wytXF1Yyz7+HCW75ggHAbplG3j4Ox2tz8
 IKO/GiE6nb/N0/jm92hvkWULlo/UJ3EYfpC+nwvVfl5blA0MBvFyeAAAA
X-Change-ID: 20260924-arm64-kexec-nocfi-496e643578ce
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>, 
 Kees Cook <kees@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, 
 kexec@lists.infradead.org, stable@vger.kernel.org, 
 Ben Cressey <ben@cressey.dev>
X-Mailer: b4 0.15.2

When the loaded image needs relocation, machine_kexec() makes an
indirect call into the copy of arm64_relocate_new_kernel in the control
page:

	kernel_reloc = (void *)kimage->arch.kern_reloc;
	kernel_reloc(kimage);

With CONFIG_CFI=y the kCFI check on this call loads a type hash from
kern_reloc - 4. arm64_relocate_new_kernel is SYM_CODE_START and carries
no hash. Its copy also sits at the start of the control page, which is
all that TTBR0 maps at this point, so the load faults and the kernel
oopses after "Bye!" instead of entering the new kernel:

 Unable to handle kernel paging request at virtual address 00000000544bfffc
 Internal error: Oops: 0000000096000007 [#1]  SMP
 pc : machine_kexec+0x104/0x274
 Code: d5182008 d5033fdf aa1303e0 f9418a68 (b85fc110)

b85fc110 is "ldur w16, [x8, #-4]" with x8 = kimage->arch.kern_reloc.
The crash kernel and images loaded in place take the IND_DONE path
through cpu_soft_restart() instead, which is SYM_TYPED_FUNC_START in
.idmap.text and not affected.

arm64_relocate_new_kernel cannot be given a type hash, since the linker
script asserts that the relocation code starts at that symbol and a
hash would have to precede it. Mark machine_kexec() __nocfi instead, as
commit e2f8216ca2d8 ("arm64: Set __nocfi on swsusp_arch_resume()") did
for the same pattern on the hibernate path and commit 2114796ca041
("x86/kexec: Mark machine_kexec() with __nocfi") did on x86.

Fixes: efc2d0f20a9d ("arm64: kexec: keep MMU enabled during kexec relocation")
Cc: stable@vger.kernel.org
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: LLM
---
Functional check only, under QEMU TCG (-M virt,gic-version=3,its=off
-cpu max -smp 2), v7.3-rc4 defconfig plus CONFIG_CFI=y, clang 21:
"kexec -l" or "kexec -s -l" of the same Image then "kexec -e" oopses as
above without the patch and reaches the second kernel with it.
"kexec -p" plus sysrq-c reaches the crash kernel either way.
---
 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8f9bc2327dc85..7d218339b84a6 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -160,7 +160,7 @@ int machine_kexec_post_load(struct kimage *kimage)
  *
  * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
  */
-void machine_kexec(struct kimage *kimage)
+void __nocfi machine_kexec(struct kimage *kimage)
 {
 	bool in_kexec_crash = (kimage == kexec_crash_image);
 	bool stuck_cpus = cpus_are_stuck_in_kernel();

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260924-arm64-kexec-nocfi-496e643578ce

