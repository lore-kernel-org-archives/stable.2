Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6F364043
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970438; cv=none; b=mz7QvBm7xLDEIsJY49K/XBVBP3PxH/rJKmVCUyej3cvMzWkq2nKw05kf6uRTTMkt4M6BiGqyLXy9YpxV5mw8HWlwhSNimZts6fVm+ONma0gXXmNliNrUSDB4lxJZZYRBY8EEz/xtiuKtVcJNsMecl2nvZkJRxG8Wt+NmMsxYooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970438; c=relaxed/simple;
	bh=AXpA8RvM6kawDldLMecY8xFEc9YXqrk/NMuGudPk2vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YtNHfWcDCcwjbXurK3oXDOquudvDJTqbCWf272GYaqoYRsORXWiNjueCd5ZapSgBru6TXlQF0AKzGJNGQc2J+911B2rRcZIgXBzwLcR2J+oPyIUS2yPYca6Dolw5dY5XecfmCOQjwyqE3JOvx/30jgOpnXpabQvcQYFlxFjjXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX6j1G/7; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX6j1G/7"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so18436075e9.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970432; x=1790575232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdaDi91QTKJpghjSNCi+hMWuT0eZZ+v0mEr89udI5Ug=;
        b=bX6j1G/7S71Jy/lcl3qARsxsaN+mP3sccWbBawU/+GtQJwDP26fZhwdwRSJvajiO16
         nnsiMsXNuP71ZLWZz9BIMd3XPeXYd09jnYOoklRyAcoLdThethusmPULAHq2xnaCGJlG
         QIbdFWHWDj4YNvSfEq/LM5tRErBzM0X5bWAA+qiVWOc+2EQNdaw8drz6y0TQHyUlT3Te
         tT9CW3NH1Q8OOJw9wkag9gOjv9Xtom5Ab7oflc8m87UkDYaLvZUUYmQwZZnfIE4f4BM+
         ORCzm/shoyTNLmpiLOwHQbTbAsTvn8TQOjoLfMcCn3NYeyF6Ae98UfBenvzlDlQSYSGs
         j1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970432; x=1790575232;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdaDi91QTKJpghjSNCi+hMWuT0eZZ+v0mEr89udI5Ug=;
        b=pVLsytKY/uzO9Vxbh+LhHtxyinVRs7AVrNdv96IBs8ryTH5vwb3qfqBUoYbaJoBb13
         tNnj3W1rkKvdtOlV9dyrQu5MvrMg4WchaFyKYJ9acStvt2JxNX/sNeHyu+oucg8S7dLN
         wkhfczMFbciPnPtBaIHD+oWaX6Z9rNfqZykpEIunwWx43LsLkypCkSIzxDUYGEsWSgck
         nVXVcSTn6MwkjkySvoo2yKoqNMHVlCXz/DZVIBtR+EE8j9Jh6eOVJX9uCUpXoBmo1Q5/
         23KzRIuBHBYpEOd97OTTyCeEpEQvvngHisUqsROg+QaUg8tQSLai1LrAlkCR2kLTWK8J
         wd0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwiJMA2+HDcny8DZy0DUwf9JrNCN9kZP1mVdZTre59dOkx8uRrr69LZbx/ouhpW+wSjx/jVEHo=@vger.kernel.org
X-Gm-Message-State: AFuF++lGBt1B/Y+N9+GEhK6iYZm5pylphH8UeIMmjDwWL53CwPwo747K
	nH0pS1pIBY7AA2KQh+UtEy5rcYAy+2NcnVsUL9NsUrXms7v5ui9zujAA
X-Gm-Gg: AYBFou2Jli5WQ6oZvkQd57Y6b5uOle3xDhaKXd3mj+pTRrEbo85y/xhEpHnsODTkYKP
	lkDXpk7v9WcG7JCQz0ef9VBzXPwy0zcP1uwH7fH7N14aJdBZn1xS+2aurudavAd0l6ilQIMlAOe
	7PKfix+Wv3XqnKerFZ+OrWkJIU8L3at5Iga6rVYTvd9tpG198k1rdll9gRKbELy3UzFxWobFBfM
	bqyeJdl4cxdxmR8O6e1XZmOMZQLZWswd+9wVSq5lABXcFTNERy3VRE22fJTkqUovdOyD2GM2uS2
	ypBXKeKQq6xhkIz7NsVcrTvRGDao10IUT9BF+/AU3Asyyu/h6WWnheCHJeGKmgt49KbpjFJCS4R
	DI4s9geT8JNMRiEawLJgUd82GCql5rbB/x1XMx1EDjRb1oGnTph+IGa4Ir2V/nvW9gET8zZBUmH
	meah81HSyTWZ9wPwUBo2aNvtV0EbDr6xf87cyp2RJSQrvOiVR179Lg9SG9eVNVWFOwc2jFoxYZM
	7xJIwYKi6iOjaol98aCk3dpOIhacAnJXYd/SvhKqkJxYjemnCCOKFHqMGw3u+Nudb2dTXpSG6vq
	DNm7X88nx3kbinDhYv/8LyPuBO03Tn9rwlMK6YZgl+FFFYD3wXQxZ+QH/U1iNGssvYp7Yio6/q4
	q7X0=
X-Received: by 2002:a05:600c:46cb:b0:49e:660a:935e with SMTP id 5b1f17b1804b1-49fc586827cmr115985055e9.29.1789970427187;
        Sun, 20 Sep 2026 23:00:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:26 -0700 (PDT)
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
Subject: [PATCH v2 3/4] ARM: cacheinfo: guard the CLIDR read in populate_cache_leaves()
Date: Mon, 21 Sep 2026 08:00:12 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-3@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com> <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
Content-Type: text/plain; charset="utf-8"
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
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-4-kmehltretter@gmail.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Fresh full-series rc1 retest: three builds and seven QEMU boot/CPU
hotplug checks passed; see the v2 cover for the matrix.

The detailed testing below was performed for v1, before this rebase.

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
