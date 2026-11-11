Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439589;
	b=3sGXJHdPU+zE4NwE+lDNhOqKGDXdGvjLS7zxYLiG2XhuysI8cLqXglRBxkgZ5Bktc47l
	 4Oe6DMo2VNdHzVW8ozvcObfotSvG/OEzeWiFosYsp5K6fXzLfy7i1Bwtkkw7mZQuYhwSz
	 cld1mZbJqZFMLoGmN5DhsZJ9lmaKZz/S904Onunor3Rhx+nARPVcp0bRXQVaoAZ9jdmzH
	 FtCwN5sQOkAlegDjoEaqgZNwGMBODBGB22Yf530m/QK9g6U5Sj8rFykV1r2kyOzE9KG83
	 4gcQ73ppoSkobW9X4IkvpANplCsq4LN7jMiQrST92Swz+Uj78cqX/6GhuDSzbEQkpow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439589;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:X-Change-ID:To:Cc:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
	bh=t9kO9XGAegdg1V2vmzxAZZmN+Wm2FOyrI5Nk2f8kXVM=;
	b=kfeHdk2C5gM1HqZwjtlJP+FXlN0Y6LygCe1PEe7vCAKEeEOCIOgS9ATWQ/gWT5QaJn8Z
	 gqyNBaA1AQfPEE4GoYKIwlMMHQUxDsagv9ygO3qlChdgnaTezJj+Wx/iXnY2/8oXqG6Ir
	 dJ/Mk6EG97mASQb1C9kTOTuOiIOu/utlBfIbarkTAzDak1WoZt/UmoK0iYsSIFZF/gUjz
	 WgNN9q7z9/fZNtlYT893OWQphauqu7vHmF67xZbna3LUy8VYokxtyzGM8bOv7VLwZa+jI
	 36f7xRoEFQ6OuOVqzN8eqtLl5E7j3q2hPY1eyHy22F2sLRc/UyQM8Gd+ra7qHzESxZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cressey.dev;
	spf=pass smtp.mailfrom=cressey.dev;
	dkim=pass header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=MOdWtvWo;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66355606A337
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66355606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=MOdWtvWo
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b/8lLMDlwRa4+gznMkDz96CHWdfImhJ5sxzvM1VsIDw=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794439585; v=1; x=1795044385;
 b=MOdWtvWoXkBNJaA4bOpDVYlDcwCRHMWccYHPEbF14qgfh4c/hoMYub9Ykk3C6TU4x5jiOuyo
 QtwZI1Kpx1hB0E/VWP32Df9LYBv63Id4NtJP7W12/dsZQpEW+zd454PRyEn3fj8rVm+xecFZfeU
 6dAsxcEO2SH7Khx3jWWXoWRUcTJv5tXsaJh4AmNCdLog3tU4ljPqfph6wDa39AF8U8NJivVZ1Dl
 LNXOzq7NGhUfzDtRWXclH4mNedpphhvNyidaudP1JiBEiwA1SfAW+muNTi6OdEoNZHGkvXzM2A2
 mzGDMFy5U1DxpaBp1CvBkOyOrkM8b2bLy3GCU7W7rWXcg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4893caac69ce6e85;
	Wed, 11 Nov 2026 23:26:25 +0000
X-Mizu-Trace-ID: 4893caac69ce6e85
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH v2 0/2] arm64: use typed entries into copied code for kCFI
X-Change-ID: 20260924-arm64-kexec-nocfi-496e643578ce
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
 Jeson Gao <jeson.gao@unisoc.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
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
Date: Wed, 11 Nov 2026 15:26:03 -0800
Message-Id: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>

An arm64 kernel built with CONFIG_CFI=y oopses after "Bye!" on every
kexec that relocates the image. v1 [1] marked machine_kexec() __nocfi.
This version types the copied relocation code instead, as Kees Cook
suggested [2], and does the same for hibernate, as Mark Rutland asked
[3], so that swsusp_arch_resume() loses its __nocfi. Only kexec faults
today, and its fix does not depend on the hibernate patch. x86 follows
as a separate patch.

Kees, the kexec patch is your diff with two comments and the ASSERT
message reworded. It had no sign-off, so it carries Suggested-by. Send
one if you would rather be co-developer or author.

An LLM diagnosed the oops, did that rewording, wrote the hibernate
patch, and drafted the changelogs and this letter.

Tested on v7.4-rc1 with clang. Under QEMU TCG, so functional only,
kexec_file_load(2), kexec_load(2), crash kexec and hibernate/resume pass
with CFI at EL1 and booted at EL2, and with CFI off at EL1. In KVM
guests at EL1 on Graviton4 the three kexec cases pass, where v7.4-rc1
alone oopses under the two load calls, and hibernate/resume passed one
commit before v7.4-rc1. The KHO selftest passes under TCG, and oopses
at v7.4-rc1. Bare metal, BTI at the typed entries on hardware, GCC's
kCFI and LTO are untested.

Changes in v2:
- Type arm64_relocate_new_kernel() and enter its copy at the symbol's
  offset, instead of marking machine_kexec() __nocfi (Kees Cook, Mark
  Rutland).
- Take back v1's statement that arm64_relocate_new_kernel "cannot be
  given a type hash".
- Add the hibernate patch (Mark Rutland).
- Rebase onto v7.4-rc1.
- Drop the Assisted-by tag. The cover letter now says how tools were
  used.

[1] https://lore.kernel.org/20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev
[2] https://lore.kernel.org/202609241804.BB23BF10@keescook
[3] https://lore.kernel.org/arZSe8hNnRPM5FqY@J2N7QTR9R3.cambridge.arm.com

---
Ben Cressey (2):
      arm64: kexec: use a typed entry to fix kCFI oops
      arm64: hibernate: use a typed entry to drop __nocfi

 arch/arm64/include/asm/kexec.h      |  2 ++
 arch/arm64/include/asm/suspend.h    |  5 +++++
 arch/arm64/kernel/hibernate-asm.S   |  7 +++++--
 arch/arm64/kernel/hibernate.c       | 14 +++++++++-----
 arch/arm64/kernel/machine_kexec.c   |  7 +++++--
 arch/arm64/kernel/relocate_kernel.S | 11 +++++++----
 arch/arm64/kernel/vmlinux.lds.S     | 10 ++++++----
 7 files changed, 39 insertions(+), 17 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260924-arm64-kexec-nocfi-496e643578ce

