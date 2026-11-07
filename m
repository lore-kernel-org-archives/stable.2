Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048535;
	b=itEsCTgOvU97JC8R4/jUnd7swnqle5p+WAZX40OndcJgsH6t4CuTXfflaPlZ3E4wYnrm
	 MZ10BRZhUxiDzA+W5RHOhcYCjkrkYSV62qiyqoqpn3d54wLwOpVsy1jEqv27jXkRmBLtI
	 qML6kLGPGS8JOazojWzExFjPSaHiG3SbMQLhT414zoPTPqsy9sczbqTxMi21d37UNEI5K
	 xs3eArWWsQQfdz0mIp/O3Y7HJBY99KXwWZ8lQCrbKD8pvO44zCmfpry/jvJq7CnD7FcGg
	 5Ulo21XY6UwwXwgCOB6lbStSbzRJiwiEJtKj7YaHZpPzVrwDGfXs7RB3VVHjbpA2Uvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FjwUj/Awy0vuQfLrT+xnAo3DbGzd2HlBKLw9T1MVkZQ=;
	b=DvXSUkwum63uBePo8v0OpjpxNNz/tzh4UgEWz2GeAPdL1ljocfTLRNP8mg6PAeDYlM4p
	 2gsD/Hyu6C5QjB6L18kOERgEKmSoiUQir0pGlEpGdt97bw1BuDIAg78Aagu3DJZXQcNqF
	 zq2dZyNxbSnrbcV0I6jKt0JxEXdAcOwaDCKAYjR07Cw253tISsxbceL0sGv3SfpAZngcn
	 hk+JurlalbOtZJze0ArTKiqRr4ydJddbnYzFdEqQA+Zf8QWI2NK7jZg6xWBM/C2IS2v/F
	 imxBJa8ayhnDMQu4uxejl6MJFA0aUMk/ie9TRNPwjAsQuxUfPj2D3cfJyynvnkrHAsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fo9oo3S6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fo9oo3S6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D2B1F0089F;
	Sat,  7 Nov 2026 10:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048534;
	bh=FjwUj/Awy0vuQfLrT+xnAo3DbGzd2HlBKLw9T1MVkZQ=;
	h=From:To:Cc:Subject:Date;
	b=Fo9oo3S6vDmk00wk8zcr/eVs6l8bL1WwXERU8cKAed6WABzDMW+szmhZ7yhW1i9Dq
	 RVYyFR4ZQdOxKsp2T+371i/3H0VYm6KfM1/Hp3ddCUGmd6qSjVhv4EEoh28iVXv1X8
	 fj9Fxyn3C4so4hYXN9ImVNB5k7uZswAis4lKgZlJSF4BT/OClSnbduMx/OzWybNuBi
	 GyB61Cltc0gePM/xy9eer5d51r5a54ogYqWqpcgUENRCGpwDF54qYkOAUSFrmEhlQr
	 PAo0yxSD3cnzYA9+WdlVpX3aeGfxpY6SJfes4sbR2azXqSN2s2Ibc1599+gxMAbfMk
	 WB3IOjSenqtRw==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	bigeasy@linutronix.de,
	rmk+kernel@armlinux.org.uk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ARM: 9522/1: cacheinfo: guard the CLIDR read in populate_cache_leaves()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:53 -0500
Message-ID: <20261107054853-failed-6.1-2315f2c46e08@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2315f2c46e0813d010e7b3ea40f2769621453e27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054853-failed-6.1-2315f2c46e08@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2315f2c46e0813d010e7b3ea40f2769621453e27 Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Mon, 21 Sep 2026 21:45:20 +0100
Subject: [PATCH] ARM: 9522/1: cacheinfo: guard the CLIDR read in
 populate_cache_leaves()

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

Assisted-by: LLM

Cc: stable@vger.kernel.org
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-4-kmehltretter@gmail.com/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/cacheinfo.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 31591c9472548..993c8a1347860 100644
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




