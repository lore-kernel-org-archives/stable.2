Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049569;
	b=j75m80hCRYHlTB5HiYsjnc0Kb0I4JTkX2rqOqfweXxdKkVn9x5Psy7mAGgGoi3BnJEBk
	 w3sAEbk0ZsFE8gK2DHSTgQc36zOUCvOMFIqIVya8gNtTrIjyWoWLpi/AXy7AzeMa9OtNX
	 n+na87BfiDLRicIea2zZJifC4AEvQ7be+eIEPSQGpRiWOwgYL+EMrTgXlXmce8q3txV3c
	 Awkrx/qTOzihxw8Mzn+uagLy0CO9XtoV+or++0j5df3w1Hxqh5O53PFTcMZHxI+k/OVjM
	 z1GxhYfc44tmReABo+IFruCBOGYJBUJThbzyzT42C/9mI28mLrUHNkMRZEHaDJINocA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049569;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bYpm8d4hB+OP/+Ey9dMw6mIrdvy1dVoGX0OlzUEIpLE=;
	b=lEYsqdGT8A42zJKxiJ/Jxq7LCGH+ci0aARnGl/LWdWn2l3t+uqFt7nIETQH8uJJ3nhOA
	 n0T9lxaTq4OCz4AZ7IVymxBMz7ies1FzAG+gXwa56hd66Hec4D5eWeUWPLcGjem6Qw29X
	 yYBv5Y+ZpeD0/q2WkZQQ9604mrqetu+qNQJs50NTBh46gf5JXNt2A19SdPAFUVmUrqoaN
	 IsjZfW6vUdjm/k+addHsDvSKTBQf4vkQ1S1zU2z5t5/67RXY4g1un/oWx+K8YxJmvO6qt
	 V1ouifSNh1HJ4qx1qSzfV1JmPFGtYLXIV67XXT6QFTG26Lxsmtu3xHN4eEv8o8sl+2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O7J/wQDj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB6606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7J/wQDj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932191F008A1;
	Sat,  7 Nov 2026 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049569;
	bh=bYpm8d4hB+OP/+Ey9dMw6mIrdvy1dVoGX0OlzUEIpLE=;
	h=From:To:Cc:Subject:Date;
	b=O7J/wQDjbwTvFraRJo4REr2Gx6cy/7T2ZjtERED+6K7UQqZvKHq3RLUj3C5Qhcmb4
	 Dpy9mA3TyqbPsthJhSb/S6WnwyEeZILcZKI91Ba1y+wkE+2uNa5xCrWlhXFgUEyvVv
	 KSLMPY/jHY0yv5Qz/SzLhFC4MSzyx9sqiPAKQ/BhxWHy+Urmo3fI/T+X3CFpVA6D6k
	 +98k9QldwO2C9qheH3KWP7NedSzi5cppgs98lJnwOxq56VZzegwjKA7wq/E7BZAer9
	 deOr5j7yfLp1c9u5k5ioPXbTem01O1HxEVLnwFUillye//NmwSFPxVvOGAExpiOjCJ
	 tMEmxLqusf/EA==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	bigeasy@linutronix.de,
	rmk+kernel@armlinux.org.uk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ARM: 9521/1: cacheinfo: count external caches in early_cache_level()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:07 -0500
Message-ID: <20261107060607-failed-5.15-4fd69e8a9ebc@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4fd69e8a9ebc42e292637ec2ebfb6bcf2d2f6c0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060607-failed-5.15-4fd69e8a9ebc@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




