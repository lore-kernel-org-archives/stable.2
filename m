Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A053AA500
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261104; cv=none; b=ePlKF7ECup5zm1f+EdA1U0b3sijrCfXf9dPxcMHt9ggEWpRDFjzNHmJzUDWqvy77ZrOdyaVjGMFSIInC3aNVfBDfZ5Dfo/MF7ax64uCeoQAq05D51FSYlX6VRPv44qavb2dTZXtLBJUFCzBY5nKTETEKaF771bGs8F7rEwxkBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261104; c=relaxed/simple;
	bh=5EDgkKunk3EuSfc9T+Q1eBOxRVhrPV7cos5ouOKzp5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sd6/p1zgyn9rozLq9cLDO0xrCDV+pLVo0Cr4Ab5gy93IoV5N6yo3LMhQjxrNp+b36b6EexMDmOcP7LKO6tqSTU2tXNP2Y+K2wLuu0G1AFtU5cBNQSs3iqBFJGVIYyxhOsAbu6T+khdUjDmXq7K0BpmC/eS1ygPrFomdQb18KY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo+06caT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo+06caT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce98cb8165so1146175ad.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785261102; x=1785865902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8W8t5tftK1vDc1qsPICPRCSPFcmSyMyPg0AlpPcMPM=;
        b=Qo+06caTyNkyw/eUBYudUIJXtk1EcvVpR0hsa2ltj2F798CPCXT7y2Pp32XLLzzZpP
         KP4uBTyTHP46yJpef+bGwyojaLDjvGZJrHPOHAC1wmPybdyGgRViAYj35bQebHr6CtLA
         tepBfHrZftmmbcj1CX6pKbjr5HWCoA0opMWavve2aDck/yiVDPNnnj9Q8rykyPMkp3qK
         mQWf4uoIsoGJerp27kCDZIoSoez7iS3PV3pt5g/Swgau8FNPuWjEaSYbKe6GBuFNeScG
         bX8oKjzmwvaVkIalbc7eVWAJxMtsZeOZyzO56lMAGipdUDfWNHJorqIdRLCPOM7dtte/
         cCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785261102; x=1785865902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8W8t5tftK1vDc1qsPICPRCSPFcmSyMyPg0AlpPcMPM=;
        b=LfU0osmKtCSuN/v/qB5xE2ZXu3BbDTzrPaYx4mLLfsCr5yg6pNcEtHjx+8SSHGGwHU
         7VnPdI/qaAY5WTZFX14c56aDd1Qd7KtpLow9AXB7yk/eLfx55o9zGFbLPWRHZ+ZZhwLr
         fwBMrI/rPFvdTQ7F/eu6QeSrl1zft0Qfb+bsw/cqlcH3nJte1jPwMaIE6BNUUXw0UuNP
         UTYdNFPtTLbYvTKRZ57c8yQ9dgFxl3pE66IxpgV0PHCsIEJFOU2dpI/ORTkvbtTfUzmu
         elFfTafxfETWNceBBrJHaMWkiPssUN5CzUg7l876bMZ/KtdI6eawjwlEa9ysTZc9bAzj
         imgA==
X-Forwarded-Encrypted: i=1; AHgh+RoyHxbyHQgFOl+Lt98z1/k198pAjdEnAhS6soPiXjQy3yrqwWkjSLIXZH9frrqyqq0TmQf5cZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36flZyV0KZCZKLL9VcAzpSPPy3BLc5kG39WFRod2VpNGWOObM
	t0OZeonnOvbXgcYzlIg3lCYOUL1Wsr6ukQuPBecaXh9zsA+zcfGPxYJ6
X-Gm-Gg: AR+sD13Iw2fOoqneJEEiThRRH5+SSMKYhTqp2HK5Ik6wIninPfD7E+dLpDW5I3wdZzw
	L6996crfpTNM50TxkMbFl7RVw8bcwUtbvuH0/aduiluG9PrvLwr+AZhCFd6AbS+as1UpzbVE9w3
	z9ZNAu4CedTKQsA8VQAhBUimPpV7M+6Mrq7+lMgLejD8S6piZUEPpOepwvtyIPHwUj1bBY5U6B3
	rwBxLSAC5rKR+PiiPit/nchF5QD7ttj/MmlyKnNT5TwgPZhoMSOmpcaMPuuewMnIVNgviOnSbgV
	ml+e/hrChUwSYTfrutP4B3aJ76/Zt3UXs2qkevmvrm2yNRgwbLF5BaXuv4DenaHoy8w2IqU1Cck
	jua7NvGtjlb2y+vdRn9fis7/0AYczdGdsUaenYP3rb+bLeVk75BRDoHTFeJFRG7FFiYWVaFvtO+
	R72w1RtTE/yq7SLmfbrENv0VmTgJhQQWgD2Njr4pL5vCgr3+WFb5ridN/R4gbzAFiF9J8wfivGe
	6EemyQ9wEkI/IOMIJUsVxAs24WFEVZNtaxT
X-Received: by 2002:a17:903:1848:b0:2cf:af20:4254 with SMTP id d9443c01a7336-2d015c9b78dmr40007835ad.10.1785261102038;
        Tue, 28 Jul 2026 10:51:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:e192:4a0c:2079:ffb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc63fesm777040eec.15.2026.07.28.10.51.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:51:41 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: samitolvanen@google.com,
	kees@kernel.org
Cc: nathan@kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cfi: Ignore non-allocated module trap sections
Date: Tue, 28 Jul 2026 23:36:34 +0545
Message-ID: <20260728175135.65578-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rewrite_section_headers() initially sets sh_addr for every section to its
address in the temporary module image. Only SHF_ALLOC sections are later
copied to module memory and have sh_addr updated.

module_cfi_finalize() accepts any section named __kcfi_traps. A malformed
module can therefore leave mod->kcfi_traps pointing into the temporary
image, which is freed after loading. A later CFI trap would then scan freed
memory.

Require the trap section to be allocated before retaining its address.
Clang emits .kcfi_traps with SHF_ALLOC, so valid modules are unchanged.

Fixes: 89245600941e ("cfi: Switch to -fsanitize=kcfi")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 kernel/cfi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cfi.c b/kernel/cfi.c
index 4dad04ead..3ee67b723 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -74,7 +74,8 @@ void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (i = 1; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings + sechdrs[i].sh_name, "__kcfi_traps"))
+		if (strcmp(secstrings + sechdrs[i].sh_name, "__kcfi_traps") ||
+		    !(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
 		mod->kcfi_traps = (s32 *)sechdrs[i].sh_addr;
-- 
2.51.2

