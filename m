Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046931;
	b=BPUwYS+y6Am4UxHyUcmIMAC6YCpd7wA/+BUAzi7+00KOvdA/AfsjN+0J/oUXKdfz5iYe
	 sjNSmkHe62NPmDnKMfmKqbst4u6V0YuclY3m704+YL18xCoS1FOxHO8B1cEP/j8cRK2Lh
	 gjUqLj828ws8gZxYQkW5tHYsfYtCrg2B0wJ2evR2tHZ+SfWvC4UGtveE+H3WOLvtEo5rP
	 7cPP0USGvzD+d8NNpgfd+/kCfwxoFsvn7tBYm4lYClEXY6DIWKU19hcMBJMYPJ/6GL+3a
	 3No1x+9ozWm4xB97JAyra41Jq8rqXqxQVnKkV6UJexRQ6vgMP6TpuF0q6Z7yVAcKjtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RSSWvlG23mW4Z7Ly93B77RqE/P8XE/TtObqNirJJ/Bw=;
	b=cbCGpGz6HQrL2bvYNGjitaKO3y4hCy8GodAuRVr8mVnITjO5dcVvsqGx6QKSxaWncW2D
	 48pZNns0Iq0EcJOJkQ2Rwa1EcwAwhGCBZlCne0JP9grRoJonShsvbWjPQhDS6yDBRAIZ1
	 iYKb7C3PJQAWldZDa9ACrRJBb0Mn/Rr+NyuVU5OEDT4EHBJ+LXW8YUGjBSZJeFcRWu1Bx
	 wUGAO0q2WaUqmeQZUC0cKgjF1ughtOntRy4OhlS/+1vCJc/duvhY/3ZJCkqtyLCNJozFM
	 uUdYbzckYU8d8lf5PTaooDZ3jUg3QogcxD4yAPYJ+QpctHfIVwfv4kap7KzRpSEmlGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O24QPLd+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A127606D804
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O24QPLd+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF901F0089F;
	Sat,  7 Nov 2026 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046931;
	bh=RSSWvlG23mW4Z7Ly93B77RqE/P8XE/TtObqNirJJ/Bw=;
	h=From:To:Cc:Subject:Date;
	b=O24QPLd+fyvd3BkhyhrrRUgvh7359PiR15FXHqCBnvFBDnMyODAM5q2fsNGPTeWWV
	 v1jl4vyqNKqcPfSVZrihCF+uUwdv+uXze5IuUJSoaxmJ+XFRN3BGku+PRbfuvR6WP6
	 Rn5gGcXQ0McYG2yGxzR2fHX4GmfGbON93iAIfPhrb79xFifsU8zychjE/mkryixrlb
	 POGXMwbY5xURRC42kqSLeGCzFLMO9+AW7H4u+wnOvPpRwBH1/Sdcnv+TpOlT23atHE
	 Bj+aruV5kAowCHLF7+JgB3s0MQH1gleoqsWg9ENxArYEg4Sz1AqaEWH0esx17Yxj3R
	 7pLHddTi89ZkA==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: flatten nmi_panic control flow" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:09 -0500
Message-ID: <20261107052209-failed-6.12-75eb687ff2bc@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 75eb687ff2bcec9fba31bbe266e5f91e5c283efe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052209-failed-6.12-75eb687ff2bc@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 75eb687ff2bcec9fba31bbe266e5f91e5c283efe Mon Sep 17 00:00:00 2001
From: Bradley Morgan <brads@mainlining.org>
Date: Wed, 16 Sep 2026 18:29:53 +0000
Subject: [PATCH] panic: flatten nmi_panic control flow

panic() is __noreturn, so the else after panic_try_start() is dead.  Drop
it so the force_cpu path can be added cleanly on top.

Link: https://lore.kernel.org/20260916182957.7788-3-brads@mainlining.org
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Guenetr Roeck <linux@roeck-us.net>
Cc: Sashiko <sashiko-bot@kernel.org>
Cc: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: <stable@vger.kernel.org>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 08072bfae4221..5646d4fb82b7d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -517,7 +517,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 {
 	if (panic_try_start())
 		panic("%s", msg);
-	else if (panic_on_other_cpu())
+
+	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.53.0




