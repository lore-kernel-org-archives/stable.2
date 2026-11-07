Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047703;
	b=P+PIIjN2hgzaQnPZYQLgOCU4UN1GT8PM+gFcJSpoel39NYuSm8dzYkPYae+7xBTSLJfR
	 L+jyTzGCxktKKOBi3RfaETaPkKdbPU5V4kKp/5ONHN6zOjHK7luiiQBJy9xj1XfWkE7Ev
	 fECszt6Lf5tQIiUx5n6Hbhs56koFuy/qvm9lG/6Ud821AmFRTzsPu15g+ildL0ZkEz68i
	 8adgCqTtFukoeQZFUPKgM8l44+NFZ97wzwhWBeex9fvZRUMb9lmR3G/G2KgVlLLSF2d1i
	 t9ICdfSqyV1V7iMgLDrLxjfZDBKqZlgOJg179BO28lnifSHNz/O3AiG+hMUe4EX4gVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oirouTHWm8bhYuv4AO1gtA/yOB0eZyucyqM+9oEvIiU=;
	b=24mN9UIKy41J8Xoc7uKOtR+huT++5aOScNuhKk4Afr/dwKc++je1TXYQmVlvOSL6No9o
	 UREk64TjdqXZP9lgvLCVoQyUAnfZCfHGTDPTdeqctabWo61uG2o0DVEhN37oSPkI0PKFX
	 K1PbUi14lWyF4w8ZxU8VkHYM49WSAoN2X3sNJKcaz2IfhYBb9eDqa9w5WTwhnrVN5o2NZ
	 /VBrsNgSp7xcfMYL7hiYXugp8nl0B/mNADhZutqVC/PHiM37D90G0mww8wZjMG4OknC7i
	 Y9GG3JfBl/B49buZ2wOvh8J9oOEl9PIUj8tb5XyMlwPtHz4uujF/RnAWyIliOnKpsfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEZhHN08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4561606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEZhHN08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E151F0089F;
	Sat,  7 Nov 2026 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047702;
	bh=oirouTHWm8bhYuv4AO1gtA/yOB0eZyucyqM+9oEvIiU=;
	h=From:To:Cc:Subject:Date;
	b=eEZhHN08vAQT3iLIe2r9go8P3PtesUsEAo1VARhSENgEO7MSm2L1ulvO6JK3syHe6
	 d1+TTg/g+DbSCJQMM6TaEqop3XjAJA8K1/9bbmipVzIA+8qnWkA7VhHrE53T7TIoAf
	 DgAID8j0hgp1ySip+FnfE8T7T9u6CSuYyc5tfdpADn/zlwCECc6Z0lRlLWLUJKC1vV
	 rnDkclFBrX6RcXQ7dswLSBQsCvE1imLZXQElXLMmFMyU56COOaZTZuxuvNQtHVopFf
	 PxzUbDq6twvI7g60PhUEbYu9WK3QTp3d1GsQywexLbGXBZtIs6a2yh0QOESi7/XHwm
	 8xszC3dmE73zA==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	bigeasy@linutronix.de,
	rmk+kernel@armlinux.org.uk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ARM: 9521/1: cacheinfo: count external caches in early_cache_level()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:00 -0500
Message-ID: <20261107053500-failed-6.6-4fd69e8a9ebc@kernel.org>
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
git cherry-pick -x 4fd69e8a9ebc42e292637ec2ebfb6bcf2d2f6c0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053500-failed-6.6-4fd69e8a9ebc@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4fd69e8a9ebc42e292637ec2ebfb6bcf2d2f6c0e Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Mon, 21 Sep 2026 21:44:33 +0100
Subject: [PATCH] ARM: 9521/1: cacheinfo: count external caches in
 early_cache_level()

early_cache_level() counts only caches described by CLIDR. An external
PL310 is absent from CLIDR, and its arm,pl310-cache compatible is not
accepted by init_of_cache_level(), so early allocation falls back to
an incomplete count. init_cache_level() later adds the DT-described
L2, forcing reallocation on the secondary CPU with interrupts disabled.
This defeats early allocation on PREEMPT_RT.

Use init_cache_level() for early sizing too, so the initial allocation
includes external caches described by the device tree.

Assisted-by: LLM

Cc: stable@vger.kernel.org
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-3-kmehltretter@gmail.com/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 860eeb03cfe5d..31591c9472548 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -111,13 +111,6 @@ static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
 	return 0;
 }
 
-int early_cache_level(unsigned int cpu)
-{
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	return detect_cache_level(&this_cpu_ci->num_levels, &this_cpu_ci->num_leaves);
-}
-
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int level, leaves;
@@ -146,6 +139,11 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
 
+int early_cache_level(unsigned int cpu)
+{
+	return init_cache_level(cpu);
+}
+
 int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int level, idx;
-- 
2.53.0




