Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE136C0CD
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090254; cv=none; b=CfbgtesjloV2GbGEvGdBy7hoAeEz9Bdou5yjmalD2MiR9KKsL8MuqUnHQkgH8PAERMb9sZpm/Qn6bEgCaVDuo2DnqaDD91FHZBsTKMFWVyxjlplQwNamOYuFNHJimKul4TVCJ67vEDdssnBL2SFh47n8fVTyig4+o9sZ9nJauj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090254; c=relaxed/simple;
	bh=PUGRFk3h17WsJHv6gJoHKaaB3MXYO9elmGUfb2D3+yM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZA+kTBE1xDJTZ3BBPJSH/knpIVGhRDuUm5rW6kqbp7tDbe6mHn2wXDlTzw6o+Np99YvUToklyu4NBfxHsJT1mFzqBb3IjrX81YrN0+1O9tOZUz7xwPFL1ji+xeMwVo0N4HbJ/4qNQMiadRv5SS501KprR/JNsZUY2PQLoovKuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/vuzzrD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/vuzzrD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso18796345e9.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090251; x=1785695051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QHN7j1c1qpvzCHml0Yb9DW3l1T4sBXf6FrZ7o+K/N9s=;
        b=E/vuzzrDNSQ30zUOeJFxOjAvUjpE9fQrvFxK6UOOr3N8gdpNVFw4oqPX/8WIY5Nyhw
         Dpq+aYCpnuSJWOZm8nMFc7ClGRA8deEwGcMl2SLiymlVOTP6UC3d42KB1CncHnTyjWca
         5vMYCoHNMj1fiZiQ4Aw3C8MibWwXdZCvZFefHL3oAbAAq3NSMwTqAI7ZIyVlLt9YMiUy
         ao0XHvR644OLjdZ/6yxXkzXKURrD84fMSpAEfIkfkZq0qVtfgjp1JShl3F5d+qIJd7Fu
         8gLLczIl/IrM4eDEyJCFHrx2jZOY5SYnPmhBqCVedRIfsQaUJX/igAJ9bJSOv8AV4Qs2
         7PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090251; x=1785695051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QHN7j1c1qpvzCHml0Yb9DW3l1T4sBXf6FrZ7o+K/N9s=;
        b=fhGrZvyU1FpBs53MbZhUlcCDkWS5Xkm3h0p4fXnae2f2+6uGjYbeqHihrLUbIEJ8eI
         CFLRZuIpA/KcggrWGf90v6Qya/h8tgbwV1paGS062GVJrorY6TEzFFZlSHxmSjbOwKvX
         Y6/Zbj9137ZRJdMC+ifkmiJYPNw4xw+poNolX9cdlKtto3lmn3MwRaommfcGPaHJOhWU
         q+oD4NBICtj8vORYL0UB1m7u/P8+DNi8ajEeEvNFfGniQNKRzNfrEELOS7j0loz4+rrA
         /7FHqwfQOUKtbNr9brWqcIt7fp5CYf5H2pqJNvq7B+MnZmLcXU00f5LHBIf7INBU0Z2l
         cp1w==
X-Forwarded-Encrypted: i=1; AHgh+Ro3VydY2bdb9sjOiRpgD4k+TrBA+ZLcY1sug85v6T+YKZ7/Yp8T68GibJBJh6OQHUNxYWW9WY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnni8O/NUrPsHZXE4K+435LRcluunxWhkK7CsSXLggzCxLXm3
	QZA+cbbAGDmiPmHJRwgNGvTAe/BFxOi7SzPVqwzhHHstFSfgLJet/FBL
X-Gm-Gg: AR+sD12ReNajeIK4guPh7jiLL8yNzVutA8PQ6QoyMemdyZHDi53EhrsZXvwMBo6nAC3
	UW+7DuWxUHg0hnzXDWIqA66wTLc05+HXh1zeJdy2dTige9aOBXimJp3K7Jj6Cp+grkQR9J0zjbS
	c+9zHfqqGScWif5yOd6d45LZu5FOaJSkLJ+dSyeHnHHiaJEGYD4vnbiqT6lzM570QS+ApqW986m
	KgEy9f9TIUC/12EX3c0Lv4wNNtX7pkHp88Vy9msKSVLH/Uc1ViDpmIpRXpgnZSgd35YdQ698/9U
	cS327BLyGUKRvLEVI35JFwbQD406qmfCPmxaQ2YcLDDtN9/F03JP4edoGvg2Tw1yz4IlTihVlTW
	KK7SktKyX1eI+K8QuusG6U6dPi+y8C+Zjhkk3qTFxj0uyjEVV7syQVcV6IO2AXtd+Cp3rVQ/cCL
	zE9ohgSvnTMdKUGPMD2sLTMP/X3HXD5++svFt9dWjpODsh+2V8TlggUqjAB4U4RZZA0o6HOZj8W
	EEN56oaWBuQtJ0Hy8ShJ3TvzeQDfah7kuHB1Ohe/eoJHfHvHbY=
X-Received: by 2002:a05:600c:1d0d:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-496b56b1b23mr75964785e9.7.1785090251254;
        Sun, 26 Jul 2026 11:24:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-116-215.95.114.pool.telefonica.de. [95.114.116.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6287csm42553563f8f.25.2026.07.26.11.24.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 11:24:10 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Liu Song <liusong@linux.alibaba.com>,
	shechenglong <shechenglong@xfusion.com>,
	Jonathan Marek <jonathan@marek.ca>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: proton-pack: Restore the nospectre_bhb command-line option
Date: Sun, 26 Jul 2026 20:22:53 +0200
Message-Id: <20260726182253.6939-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7f1635737823 ("arm64: proton-pack: Fix hard lockup due to print in
scheduler context") moved the "mitigation disabled" printks into
spectre_print_disabled_mitigations(). For spectre-v2 and spectre-v4 only
the pr_info_once() calls were removed, but for spectre-bhb the whole
branch went with the print:

  -   } else if (cpu_mitigations_off() || __nospectre_bhb) {
  -           pr_info_once("spectre-bhb mitigation disabled ...\n");

spectre_bhb_enable_mitigation() therefore no longer tests __nospectre_bhb
or cpu_mitigations_off() and the mitigation is enabled regardless of the
command line. The parameter is still parsed and its flag is still checked
by spectre_print_disabled_mitigations(), so the kernel prints "spectre-bhb
mitigation disabled by command-line option" while
/sys/devices/system/cpu/vulnerabilities/spectre_v2 reports "Mitigation:
CSV2, BHB" and the vectors are switched to EL1_VECTOR_BHB_LOOP.

The only remaining escape is the SPECTRE_VULNERABLE arm at the top of the
chain, which a CSV2 core never reaches, so from Cortex-A76 and Neoverse N1
onwards both nospectre_bhb and mitigations=off are ignored. Both are
documented in Documentation/admin-guide/kernel-parameters.txt.

The identical mistake was made on the neighbouring compile-time-option
branch immediately before this regression and fixed shortly afterwards;
this command-line branch was missed.
build_bhb_mitigation() in arch/arm64/net/bpf_jit_comp.c still tests both
flags, so nospectre_bhb currently keeps the exception-vector loop while
dropping the cBPF epilogue mitigation.

Restore the check, folded into a spectre_bhb_mitigations_off() helper
alongside its spectre_v2/v4 counterparts, and use it for the boot-time
print in spectre_print_disabled_mitigations() as well. The print itself
already lives there and does not need restoring.

Tested under QEMU with -cpu neoverse-n1 (CSV2, no ECBHB, no CLRBHB).
Before, spectre_v2 read "Mitigation: CSV2, BHB" with and without the
option; after, nospectre_bhb and mitigations=off both give "Mitigation:
CSV2, but not BHB" and a boot without either is unchanged.

Fixes: 7f1635737823 ("arm64: proton-pack: Fix hard lockup due to print in scheduler context")
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2: fold the check into a spectre_bhb_mitigations_off() helper, matching
    spectre_v2_mitigations_off()/spectre_v4_mitigations_off(), and use it
    for the boot-time print too, as requested by Will. All three QEMU
    boots re-run on v2; results unchanged.
v1: https://lore.kernel.org/r/20260725122959.98361-1-kmehltretter@gmail.com/

 arch/arm64/kernel/proton-pack.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 7bb6553fec08..3bcf86154d95 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1023,6 +1023,11 @@ static int __init parse_spectre_bhb_param(char *str)
 }
 early_param("nospectre_bhb", parse_spectre_bhb_param);

+static bool spectre_bhb_mitigations_off(void)
+{
+	return __nospectre_bhb || cpu_mitigations_off();
+}
+
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
 	bp_hardening_cb_t cpu_cb;
@@ -1036,6 +1041,8 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		/* No point mitigating Spectre-BHB alone. */
 	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
 		/* Do nothing */
+	} else if (spectre_bhb_mitigations_off()) {
+		/* Mitigation disabled on the command line */
 	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
 		state = SPECTRE_MITIGATED;
 		set_bit(BHB_HW, &system_bhb_mitigations);
@@ -1201,6 +1208,6 @@ void spectre_print_disabled_mitigations(void)
 	if (spectre_v4_mitigations_off())
 		pr_info("spectre-v4 %s", spectre_disabled_suffix);

-	if (__nospectre_bhb || cpu_mitigations_off())
+	if (spectre_bhb_mitigations_off())
 		pr_info("spectre-bhb %s", spectre_disabled_suffix);
 }
-- 
2.51.0
