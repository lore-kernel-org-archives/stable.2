Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F103D34BB
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166536; cv=none; b=gUtTL1K+c9nlxGELEcIZfYvDyQWqI/uNOMUYmvr+Z7Aes3y2POOgYXWBhGbj4/l/x5LhV5TzpqSxt8GIzIbInl/9HOM5Cn4iHt37naH7zE0sH5XqEE9LqLUKs2B4aDsLbQhMbm4RfDO6p0Jw8h4vsLYoTw5EEZFhcFUvOxJKh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166536; c=relaxed/simple;
	bh=ilPdTUjxhICutNInYN/fC0okwYCOZVNIm5oFku0b9jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KE4pvwGkAC8X9THLCSGEHat0BYLs9nzkT9eI8mW8X6IlurG68cUNJ3lKIx5fXFzGLmX2n930d0U/xcXWJI+5qTNdtxORq683b/BRXULgVuwsii6ChT80853xQj7PbA8kJ7mHHh2Bb3YRhx1kWLcV/GxKYPQgGd0MMd3L1pI+12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhlX9y8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhlX9y8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700B21F000E9;
	Wed, 19 Aug 2026 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166535;
	bh=lhhPLKCb/OXDM6aAJucfaNWiCP/iqlwCwyEJNcuLJHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bhlX9y8d41kUoqtaKoaJ8wun8kkbe9mFjt+HG5BlZi90EEkR9qaVVC/EgB/yv9DlV
	 LXz9wKwAkZ5ZijdWuE1gOcgyfQ/2kA38BAXhKGcghybu23Cuis3h2C8nqGj8IA/Wkt
	 ekZZd8ny/QEYN+RMfI1aQG4zK0gV7Kqk0f8veZbrKVp14eGORFCglfH6yCPkdmdFQV
	 3eh/NkmslN4VBmdJ/EUtk37oiwDaVUcu5RycPrdJWORpyphEapLFzM1PyKE90gmCIa
	 GMI+G7X/Rhfm/4uuA/I/sNYAVHhUcHajWWQ0+Vro98B+HljZXO5aqAEPSpAWjDUpfT
	 VMepNR2UyUYUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] x86/mce: Remove __mcheck_cpu_init_early()
Date: Wed, 19 Aug 2026 15:08:49 -0400
Message-ID: <20260819190851.563607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081738-avert-freebie-72be@gregkh>
References: <2026081738-avert-freebie-72be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit 9f34032ec0deef58bd0eb7475f1981adfa998648 ]

The __mcheck_cpu_init_early() function was introduced so that some
vendor-specific features are detected before the first MCA polling event done
in __mcheck_cpu_init_generic().

Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
additional code will be needed to support various system configurations.

However, the current and future vendor-specific code should be done during
vendor init. This keeps all the vendor code in a common location and
simplifies the generic init flow.

Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250825-wip-mca-updates-v5-6-865768a2eef8@amd.com
Stable-dep-of: a213dfaa2596 ("x86/mce: Set up the polling timer before CMCI discovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/amd.c  |  4 ++++
 arch/x86/kernel/cpu/mce/core.c | 14 --------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index dac4564e1d7ca..4bb317a54f2e1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -674,6 +674,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d8f3d9af8acf0..ba28988c575cf 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2011,19 +2011,6 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	return 0;
 }
 
-/*
- * Init basic CPU features needed for early decoding of MCEs.
- */
-static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
-{
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
-		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
-		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
-		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
-	}
-}
-
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
@@ -2266,7 +2253,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_clear_banks();
-- 
2.53.0

