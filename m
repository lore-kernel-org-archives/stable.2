Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08639150B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242969; cv=none; b=ZLhso4O1uPL+9vQKfn9guTlzTmX7Z/z0fvzQCsm3kc02e8JQYGTd4TIWQHylOWWebUqwHxYkkET1FnKwGIRbaIRV0E+hp9zUC/OCrH/pFGxARK1ye/GCyXRDtBShF2Jjek3cWg/eeWl2mdLOTdeuas+Ujcgbfh2MfWwoM/JSQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242969; c=relaxed/simple;
	bh=BdaqS2x93aAnR7qyDRmryncl463GVVC0Ab+SSxVjyQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2sE9lOkjXhdEOTrPrGCAUYT9/yrgzfYVIpazhHraAF8ZdPHxrPOcboiijmbO0+kEYMLvGtoEglrm2MxMYiFWzkc+m+vw7ni9r3GX/4W1vepxaPte+W/buDy3Vc8sLRCr2Gs/0WySaL+UvvbxzBcpf43PaJp03YY9KuE/7XTnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKZzlIWF; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKZzlIWF"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so3028205e9.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242962; x=1789847762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iv5Y9hzbKwVTvwjYbkj7A4OWiAYcXcebXQ5vuapgDoU=;
        b=JKZzlIWF2Hhf7sHDs2OR+/W3Ob/eqWuuK205rP1cjCOb0YkrqFkY3FKvPYcAf+KbDX
         BKiEGcWcBccnp8UPZHahTIYC/A2b9sU9nvxqS61chU+Z2WM04kSefu87edIP6Ndg2uNp
         JPA0fozdZ1w6uk/0qTfu4SqiMhYapvdc7P6su185RngKDBwCy/uwRFIewFKu8FUf736q
         DrvdKprxOlUVcG/XT9GuC5MojX8uQdLXpem1kuOoXca5SQM34gGvalICdFwTrhxrN0Sh
         LjsshcZGDhOtmrLV1egiFQHg1jfJ+hH3qJxJ5RNhFLw8xKeAF9yNr6utfxoJSU+Ve5p1
         I8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242962; x=1789847762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iv5Y9hzbKwVTvwjYbkj7A4OWiAYcXcebXQ5vuapgDoU=;
        b=Fzq9wnnFTHEGjJvDhoacFhQBlCjVUXBivNKdgq902mfCA1tQEOmGz9H6Dk7o8Zc804
         86oO2owHJecfRmsrqIeKLY4Gv7Dv1kYR80JL+kD34NUHsgDuLF3cEQgp/mnYqpYMMxKC
         eKtRdqhjPFlmkH/Mr+jEcf4WI9Hlxj+gMHPGqP43JIshG2XbLeSs0SOQXPB8IXL2XmdA
         DpcSe6jQ3+8PKx//AOVHTFJ6hCXvC5pKVr7MDNDc3bmwVTzcxgOtBNfT5Vhva+SHGqSg
         pL1Pho50zxKf5Bq5JyijwzOy3cAOeEQp5bvG0eZn9XveZZrMXtcIp/3+LwhDgwN5XZjY
         jv9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzAl9UBO7TJtZn8x1b1l01l7fr4cdEId4VzzmRCDWY4ISYHkcHv3BqsyWphNHkUNtZ9K+u2yCI=@vger.kernel.org
X-Gm-Message-State: AFuF++mjF6ZXAOLj2ggEpEz7FEdZj4Va4QCpnDErU+Nw8exWx0eOJXkR
	CT4KxXmpP18TGTgB0cKYDhhUf0DBccbVbcjO/KmBzCfNS8wESRU55dkb
X-Gm-Gg: AYBFou1TqLzVjlbz2AOBPH6G1VSjP/GI5WGCLRkv7aMpxRVbaAHyCq930migxLvAsq/
	PADWNwTgUO60L2q1Wa9osMgTroHM6GQYYJVeZhsjQYMtsColZhbvtFfkbuxqIx0u3kLx5TXT/ym
	qQ9jRyAB/2dL0o9go45N8IsQqKysDE6VffOqd6xJ4L8NDC+UNAJK8x4UA1GdOecsHKcA8KG9DZU
	hL0sixsyuxSvmognxija1yYl4vZVB0KUtN7x3GaKlMQKB85uEKlv5R6ruE0/2x6N5BQg+5x4bTk
	vP8dyJt+Bjhvem7YYQ1vzO5+yAoMbZNN5WkRFORLgb3pv1ocxjhW2z6tmA7EDcWKWoGtIC5fkz4
	iHkk297EyVh/LZs8RmZ+RWUlzHO2dc3nmkI98bI33hPpW+pDwYN2F3S2VNz9D770xOT6+08IWQA
	ii1/LSgsStdFGi0SqwmyMnQI1i6A2FqkAGBmH8VdGvtkWhxynzj+4kfoTJ280mmjTdhV8wmqsZD
	co/FnzHv6CEeRvz1Nyv45AC3XVRPD8zBWZTPJ6kuq6RtzFmhV1cZkswe5cTmUF85FxZoN2xcwNN
	OD2Sn4VJWrsoU0Ku57t88nOC1saX772IMLMauX2I9JlSKCeJv2RnBndM21UYZMNl2o6RxMm1RTB
	YgbBVYl8=
X-Received: by 2002:a05:600d:4452:20b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49e6198c2aemr79301175e9.11.1789242962176;
        Sat, 12 Sep 2026 12:56:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.56.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:56:01 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ARM: cacheinfo: guard the CLIDR read in populate_cache_leaves()
Date: Sat, 12 Sep 2026 21:55:51 +0200
Message-Id: <20260912195552.76673-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM1176 and ARM11 MPCore can be reported as ARMv7 by
cpu_architecture() even though they lack CLIDR. populate_cache_leaves()
therefore needs the CTR-format check used by detect_cache_level().

DT-based early allocation bypasses init_cache_level(), so its check
no longer protects populate_cache_leaves(). A combined ARMv6/ARMv7
SMP kernel can reach this path on BCM2835, whose DT describes its
caches.

Share the CLIDR capability check between detection and population.
Return -ENOENT from population when CLIDR is unavailable, preserving
the existing absence of cacheinfo and avoiding a new topology warning.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Reproduced on QEMU realview-eb-mpcore (ARM11 MPCore, reported as ARMv7
by cpu_architecture()) with a device tree carrying i-cache-size and
d-cache-size on the cpu nodes like bcm2835.dtsi: with patch 4 and
without this patch populate_cache_leaves() reads CLIDR, which QEMU
returns as zero, so every leaf becomes CACHE_TYPE_NOCACHE. Real ARM11
does not implement the register. With this patch the read is skipped,
the boot is silent and cacheinfo stays absent as before the series.

 arch/arm/kernel/cacheinfo.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 31591c947254..993c8a134786 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -80,19 +80,21 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
-static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
+static bool clidr_present(void)
 {
-	unsigned int ctype, level, leaves;
-	u32 ctr, format;
-
 	/* CLIDR is not present before ARMv7/v7m */
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
-		return -EOPNOTSUPP;
+		return false;
 
 	/* Don't try reading CLIDR if CTR declares old format */
-	ctr = read_cpuid_cachetype();
-	format = FIELD_GET(CTR_FORMAT_MASK, ctr);
-	if (format != CTR_FORMAT_ARMV7)
+	return FIELD_GET(CTR_FORMAT_MASK, read_cpuid_cachetype()) == CTR_FORMAT_ARMV7;
+}
+
+static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
+{
+	unsigned int ctype, level, leaves;
+
+	if (!clidr_present())
 		return -EOPNOTSUPP;
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -150,11 +152,10 @@ int populate_cache_leaves(unsigned int cpu)
 	enum cache_type type;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *infos = this_cpu_ci->info_list;
-	unsigned int arch = cpu_architecture();
 
-	/* CLIDR is not present before ARMv7/v7m */
-	if (arch < CPU_ARCH_ARMv7)
-		return -EOPNOTSUPP;
+	/* The device tree can describe caches CLIDR cannot fill in. */
+	if (!clidr_present())
+		return -ENOENT;
 
 	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
 	     idx < this_cpu_ci->num_leaves; level++) {
-- 
2.53.0

