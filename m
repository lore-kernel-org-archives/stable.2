Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048532;
	b=iWOlzSCSGYJRaEO7EI7RUrtyey7Bp6bW1ifUbOSc+Yvft6kYbcklDS4NDgjsEE+BhjKs
	 wcT4kveLez4DNFgSv5tCrrnje4VRwE98PVnhUvNOlnh3aRESswiUpfL+XtWzjud759msi
	 4GdaWNMeTzSZ1Cv8j0bREax0yTG8AJ9iWDI8d15O4ZNxwAIIfa0TArPYgWAuaTynW1iip
	 +7l5rDqiuS9mBCjW/zRcmopz1jDnj3sqqN/U/KYiU/fdHEjvc8mBozHvyxJqO6tndkeiJ
	 xArpX0t+1aF33lAZUM3F0uE8Emv5rmMRtBaxZIv+xIFloh4yKxVa7dmwZsTihaOj94w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2L2IcOivv0W0iv76tWNUi/jx8B74tUJY69JL4sMaYeM=;
	b=CEr5+cvwY0ZXhT99lJWDk67Ma53iZZutQCzsFd4XVpXxTh47meomvq5mLioXCliXB9YQ
	 kxc3c9wnhWbDv0S6c/Xd3mEwEoWiq4DcW3x31Pcz9XwJFbqhAisvUVwUUjO0KNQwUpg+u
	 4m4AiEHZV6mzn6eG37pW+BAM5yVQtuaGe18+G+qOcoxypwVsVxTkSd/mGMaEiB+uFCZU5
	 cvqwFtYZHC2x8mGgCcLoCzasSMLEM2CEZu4zmT5fifTuzdAaQjaIJXOsSy0pSVVwBu5OC
	 cq4l8BqvpKau1tjVCf8P14lmGw2v8/2xe4whvu3JuKecxcJCr616VdSFSdgI3bOBiZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfLcX7ZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06768606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfLcX7ZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F191F0089F;
	Sat,  7 Nov 2026 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048531;
	bh=2L2IcOivv0W0iv76tWNUi/jx8B74tUJY69JL4sMaYeM=;
	h=From:To:Cc:Subject:Date;
	b=BfLcX7ZAxdCI/Afr9OgjjeA7uMxXdeWuTiOqHqxNw/e4rJAyNqBbXTqV+zL70IDwP
	 Y+NFqW2viZXftA9ut7SSdY2jpwRTLHWkCG46wJ1ML1IouQ88cUDHvSarnmgYU3WP0o
	 OMjjZ0fgwzbMTloW05NXCfaWVubD8hOTDyRfrx3FbLqn8TMwhgVCSTB8LdMN7Vuq4a
	 ZoBGZXFlzMDqgrA3wwA8DXfxZqK3Z7mFdAH/mb/JJ8E4LF2SsB1H1ci1adAoqJksp7
	 PYyeUF/r4+Z1LuQE5XDDkCkMelzXJ/VAIbmgclr0jIhaKjbaNXJlK+5yiqpWfGD02Q
	 GGjdkdDPsgklw==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	bigeasy@linutronix.de,
	rmk+kernel@armlinux.org.uk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ARM: 9521/1: cacheinfo: count external caches in early_cache_level()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:50 -0500
Message-ID: <20261107054850-failed-6.1-4fd69e8a9ebc@kernel.org>
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
git cherry-pick -x 4fd69e8a9ebc42e292637ec2ebfb6bcf2d2f6c0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054850-failed-6.1-4fd69e8a9ebc@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




