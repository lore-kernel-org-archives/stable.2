Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8970424D64
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788696868; cv=none; b=W1o3DjbpYMkzYH/hYneQZTgKRq6YZFm9PN3czJKTpmF8nxSQEH10OoPK4n7XumKz/w1SdH6BuHE/yClrXEkbg6Z52gj3y3wUMl7shS8NPIG0dsRzGSvNlhFx0+Y42q1WqTMEUs6/lFkL9hS2+lQo7ISG/WToK1Z2N5ee/U+80Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788696868; c=relaxed/simple;
	bh=xiM5pdelIr3CgyoWOb5sGWF8noprLxF9pgrehbKU2oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fy6mn7lx3rjaj+0/DUyQRaPI+ig1B/vgaWF11Ptjjb5R5v06Q8+h6gVxpFK5KEzgN3vyFlJf3zX/ivAjRRE+S9v/NiVuGFX0xSKCARMGTCrIlMq0ECugLeT95iVA99CXcDOqFf2pQ+Zml9wuR+ToXnznS58se433w7IehiMuW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzHJAqrL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzHJAqrL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so4318705e9.0
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788696864; x=1789301664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p90yRqRNkEpbXqQjLiETs/gtDf1cDQsPml2IReoU9ZE=;
        b=kzHJAqrLY1uA8QHBl5LWb3fGpZ9SllS8aEYgHCBm7g0V8tQqKZ9L3KWexnMqTTpq3L
         kfrkN3VEbOSsF1be9RmEifbytnE3EKoesxydBCaM8WRjdoCjYtvu/UL9GPZxDFn5Zbqj
         Zj4w5VobopYu3F/goh2tMgeNbhvzrIszgTRw0PYY18PDb8SU5TmtcCFSvbgpvp0r9jzE
         ZBKBkthURe0/10DsogNdkz99VbeHVTINqzb+WbncJJCRLNUAJ3+GbH67py6v31nxFhjN
         EAQ9H0wMG18gDlluYPsNhoedZ8MhHn+B19136zOjWnzKBmVG1F0orr8nlH/1xU+mUw1x
         b9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788696864; x=1789301664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p90yRqRNkEpbXqQjLiETs/gtDf1cDQsPml2IReoU9ZE=;
        b=E/Uo9zn5+B/dgFeMucr8VeCNCVjAqpAmUKHJUDCnDlzpj/DLeApjdaxzkHdfQpZBo/
         O7d0bnu7QRfa5t7FmzWWEGPLFLDsEck3WqFnetLgx5MRN2uqA/4/aXQmMv6KmUtO5tP9
         heKkrXpGGG3lP2Nh73FdQ8XYsjjCDD9uWZp0MJKAVEfaEB5kmrQkAJo/dCryetKTWcNc
         P7IehWN7N9ypd++V8Erks4syn83ZjNVlpq4ebhCrHthyFmCTRjgQHruCom4A4eDtlriU
         60CDCrK6tY1W3F1n/mPsSpdjxy918dNyBA0A31t2sc7kbhNPZz/T1UcCvcMjwC218kau
         Zc9g==
X-Forwarded-Encrypted: i=1; AKwUvBzc+I/yIqnNxeuvTWdaKeXkuZXA0+odWcu57C5knoDkoK+ZLEGTEhC/W1fbhqFI8Ij1hVOMpzw=@vger.kernel.org
X-Gm-Message-State: AFuF++mYXBfm7vElnF74W/vMuJ6w0oBCZvOCN0JqC792pyPbrIBSrMX2
	AxtDoQr11fgbG8YWWcTpVXM+6PgPefJhXm47D2qKwkE6u1DHcl19a2re
X-Gm-Gg: AYBFou35dZGepP+Ivs+RBcBbAjqWmDJR9rumEolSmbq0gBORA47geXi+to4FVf7j3wn
	Cx5x4bpIqBDvMGLWAs2BUi6PxoGBZ/ZnBgZQ+Y3tc5VtMFH5BDndZIzMzdjPfu2OIGYRpTQQmwu
	5agta+3sq3TiUmTvtqU4pC4At/OyF/z3uGqtAf0b2zqE8aHrOnGC/KPZfPKBQaFTkwxSNdYFrOf
	OAsxnh5Mksb2+9vFj+Tm/sNY43U0nttrdDg7qveGHo7gbfr6nCAbdc3qyez/uQ7E6LfD7JPVXxd
	e9mCP3ij1n4y3W34xUj/T2yfIv8ms+3n5aLTTwhnIpqtuksAVQVfm5dhoSCYR2S7hE6GKNDc74R
	cw/7uBRGlk9owzfZJV8hU6UGz5WpnxERtJPAcbzz2XAIiEsNdIaNCTqrYUoGLMmJh5C+xdbPvQL
	sEJO2ie7Z3Oog6pQEjMa6GIGm/48hQINPCcskEbUnG4gYIBY49yoPbHfNoL2SeFMSh/Ymq8Aj45
	pCicI6EwUZF9n6CkKnuOSmmk29KLA2JQTVH4w3mV37RLz15S7s0o9gKYzU=
X-Received: by 2002:a05:600c:474c:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49cf8227619mr155692535e9.5.1788696864253;
        Sun, 06 Sep 2026 05:14:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm137917565e9.13.2026.09.06.05.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:14:23 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Khushit Shah <khushit.shah@nutanix.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: errata: match the target implementation CPU's own MIDR
Date: Sun,  6 Sep 2026 13:14:16 +0100
Message-ID: <20260906121421.60575-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__is_affected_midr_range() is handed the MIDR and REVIDR of one target
implementation CPU, but tests the erratum's range with is_midr_in_range(),
which re-scans all of target_impl_cpus[] and ignores the @midr argument.
The range test is thus constant across the per-CPU loop in
is_affected_midr_range() and only answers "is any target CPU in range".

Since just the fixed_revs REVIDR check uses the iteration's own registers,
an out-of-range target CPU can decide whether a MIDR_FIXED() exemption
applies. A VM then enables a workaround whose only in-range CPU is fixed
silicon, e.g. erratum 2658417 on a Cortex-A510 r1p1 with REVIDR_EL1[25]
set.

Factor the range test into __is_midr_in_range(), which takes an explicit
MIDR, and use it in __is_affected_midr_range().

Fixes: 86edf6bdcf05 ("smccc/kvm_guest: Enable errata based on implementation CPUs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 arch/arm64/kernel/cpu_errata.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b33dccfafaf8..8ec47d89b45b 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -28,18 +28,21 @@ bool cpu_errata_set_target_impl(u64 num, void *impl_cpus)
 	return true;
 }
 
+static inline bool __is_midr_in_range(u32 midr, struct midr_range const *range)
+{
+	return midr_is_cpu_model_range(midr, range->model,
+				       range->rv_min, range->rv_max);
+}
+
 static inline bool is_midr_in_range(struct midr_range const *range)
 {
 	int i;
 
 	if (!target_impl_cpu_num)
-		return midr_is_cpu_model_range(read_cpuid_id(), range->model,
-					       range->rv_min, range->rv_max);
+		return __is_midr_in_range(read_cpuid_id(), range);
 
 	for (i = 0; i < target_impl_cpu_num; i++) {
-		if (midr_is_cpu_model_range(target_impl_cpus[i].midr,
-					    range->model,
-					    range->rv_min, range->rv_max))
+		if (__is_midr_in_range(target_impl_cpus[i].midr, range))
 			return true;
 	}
 	return false;
@@ -59,7 +62,7 @@ __is_affected_midr_range(const struct arm64_cpu_capabilities *entry,
 			 u32 midr, u32 revidr)
 {
 	const struct arm64_midr_revidr *fix;
-	if (!is_midr_in_range(&entry->midr_range))
+	if (!__is_midr_in_range(midr, &entry->midr_range))
 		return false;
 
 	midr &= MIDR_REVISION_MASK | MIDR_VARIANT_MASK;
-- 
2.55.0

