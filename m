Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048501;
	b=mCyUw/AXpm8B2YkFXEJhQFX4+8+c0FJkPb1PxZp3kDsdSVklklMq9u+VYGYF94qucN3i
	 jS2Jgb5My/iPCSN+mcTW8TInp/PqOrFLBO5oEuNb1QZ0OejCTTugF0PG2PAIvRbCRUpVq
	 5ekE+0LsmwpwhxiHGeGXr8uemLMxPSTys8LAmdDjIu2fWRzMNP+bq8wdCuI3OFWnGKLAv
	 DYRXvUtqy9FP+wVSA8fyE8hKCTQyzZpHTkCEfPqUYL20TZVZFn8sYiXScYG6gz/m6iOtE
	 yEbildBiV8sBo9iCNymyF0bS85q4BDUn6IC+IqNuc9sxUrJLKX5iHaVealw6WiRwIkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sylJ15/b6UlBkyKdqF7cRvNZbENEy0FjYfOW0tWA6AM=;
	b=pQGFCY9PvK6ZjanwNvBAS4XFKrZWsdxB3tKZHm39guNM4ONJceZ3jtLzv1HLfK5zSEzP
	 DU6JliiD+/+SG8n8CnB+xonzg3znORkhvO4NWmHcbf7ewIRMl4gmIJJkjKjD3DyqlEkHK
	 3qD1xqqILxXOq/FtRSXN+oDwLciY2Bb+i4rp41TE+HIAJZ4SGp1Zv8TF5kMpX2e3oNpkV
	 w7BVCtJkJTqZrindHQJqE+4ZGPIWt1JSV9vpafEg+culLYWh9AEai465ljC4enzpuM+ig
	 j1KCSaBhxnUEX9ZDdaUsmqaLMkNEpPBdwIWYwn6gzqhGaOsSVfgqknuFVnp23dK0j+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1brifXH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1brifXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D385B1F0089F;
	Sat,  7 Nov 2026 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048500;
	bh=sylJ15/b6UlBkyKdqF7cRvNZbENEy0FjYfOW0tWA6AM=;
	h=From:To:Cc:Subject:Date;
	b=U1brifXHU289wIxqmNGgWcxJKi8p30XM7VrFJdHCygsPMJmICMt1ewXI6keenwCH/
	 pTydv/BQl6sUxPvTJvS88l4b59Yy59g13MrpJHujMV3hi7xUlAGPlCaA21V2XLf5Qy
	 y5i3lMJXUHLd5w9kFt16gZ31KjDgvQ15oDOER5O1CwDkrf/veZTUiIQReWrAiancfT
	 B11dBAj67D9WqA3n2LvNm0NEIoBaAU2aiM7COC/1NU55jjG2lvZCA96kHsqJ0i43w+
	 RGZBkqg6g5qhwwzjmoA911slKmZgtVr7YRRVHmelBrq0gqXVwuyCwjDC96ZaeGMcNZ
	 Sixwm/coeIQTw==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: flatten nmi_panic control flow" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:18 -0500
Message-ID: <20261107054818-failed-6.1-75eb687ff2bc@kernel.org>
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
git cherry-pick -x 75eb687ff2bcec9fba31bbe266e5f91e5c283efe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054818-failed-6.1-75eb687ff2bc@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




