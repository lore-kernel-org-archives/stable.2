Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047700;
	b=5M1Gvf2b0iuh0pjkeHktQUgCy7VRcsGfL1U5Edhipr3Bo901FUKJDXK+GgAfhc/xuMeO
	 Uy0icyp3MWK2Ic5CO6tqe89C/rXOYydXNvZgqvLDumiHiDMOE+D5lcjIGBACO2exvAS1J
	 RC7ylnfe0gE4Hdgsp0NvJ4nLxbRwhI9qX3vyFCzAKVcTkP2gXaFSehIMDBxbxT+i9lWUN
	 VvLkA9ZpNEecomMircIuc/nKRkU3smLTZ4RdkegkK9Jpvheihgj65+SgmZkw0hE0Dcigb
	 9hWJLMN6/VA1Ps0EuTLN0sWqgyZKLoaSm00bPYyPCAwBsHRdSA4KmVoNNF7goGzQDow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yWYrcxrqh+4MbMlKX1DopAJhs1Sg4kc2RSbcExTqHog=;
	b=xqhIzJzK4n5Z2nvnvRXcR58PNv3BFgyWTgxAxxGtkjK5JQHqqM2sC/pdLojrQcVWRIDc
	 1RCljxY+5NeIHi2J/9j1OrBMbrNw/JOOmpyMie26Q3ahOcyd316OHgNBj0/UgE1porU6i
	 zWXpERyiODEQB0VXjhvqpcetiPW8G0dYL+hBmrsR7r4Op8UD5MOmEuG3nt5b7P0z+aXTu
	 rt5PZ42Iog7BCSowd/jN8MyfP+kMmusNd1spmc1PTwzFKofFsOyBM6hixEsl3wuI34C7H
	 IT28/BWs/K8ZU63mDEWsXeT+Tkgwfp3zEoGiGNJ7q49JWnroLj1wbJMnvML0ys/THNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWwyRvTF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51581606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWwyRvTF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6571F0089F;
	Sat,  7 Nov 2026 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047700;
	bh=yWYrcxrqh+4MbMlKX1DopAJhs1Sg4kc2RSbcExTqHog=;
	h=From:To:Cc:Subject:Date;
	b=oWwyRvTF8GTCVt/90S2JFRKdrEm29Q6mg1sYRL2nmFh3fZr3AAt9EH5+ORGTDf832
	 zrKIMwIHum8pJpTFKp0FyD70uhD1Fznjo5LLMl0aUF4I5F0hJ0bSIHyI2l0zCL6hR4
	 OddZ/UY3xOdGHMqjkbkoEp2u4eM68xzHC26oZ0juiDKCwyvbzmIo+k7wHEbnnYnVT9
	 DTbT3z7ITzU0vGvmNux6wfun/1gGScFxU4QT+bhNINFpAvWzJmPNFAfXuuwMTvVs0s
	 x6kzdDK2eJppGHQ0S0nL1wXKQIjBRnQ8ZdZWk7R1w3kN3Jzu6Xw1+s31T4vpTSTM2c
	 SnAVAjl1FbZ7A==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	bigeasy@linutronix.de,
	rmk+kernel@armlinux.org.uk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ARM: 9522/1: cacheinfo: guard the CLIDR read in populate_cache_leaves()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:58 -0500
Message-ID: <20261107053458-failed-6.6-2315f2c46e08@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2315f2c46e0813d010e7b3ea40f2769621453e27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053458-failed-6.6-2315f2c46e08@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




