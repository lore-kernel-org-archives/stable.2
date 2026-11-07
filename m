Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047677;
	b=5HB8SuXtQmFchlrCwk2hQWqoSm3458I2tBw5hGWliBq00csq0NC9sbylhpPFUfEfnax9
	 yhJ/4JCXF2LfkKCoH/i7o9ubFU9Udp802jz8yokOpAf+mBCN/HJHuf+94B51uOyGfQYZK
	 6m+MhpEI2gHtZ/y80ztECwabDVBs0cvFXgdFKi93G8DC4GY7UeXA66V9HOr1HxPe2+kNt
	 rzrucgKlBu0Rvyyk8ip166ZjqYwEv7C1dfiTVBPPjlliyV4YDTLHdVkC9af2NyhBrVZFj
	 32hVIkrlvZuD5598SwgWVMpxOZMS9N/Dz6pDo3JxjZpJy0PWk6vV3PgdK12OyU6YVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047677;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GH4SnpLZSnqqUBIm4vEGOvVH382znzP0L1sepJtxfeE=;
	b=caoEqUzE4pZPVo9d4/yZcyiasFcXv/p1cRjsWvpJBZgqBdywZw4HErde5ZECXY/PB13t
	 jWqDONeiOj6qm8UsXZ8n21xSK7uSq8frvPRf2RCdwO6tVQhf0NmfQ9312jmJs4P7cvMjB
	 CbAzXVhwzAwTJuvA9YRm2pg9nqZHq2/bqP8O8r/95z/1pyxuOC+eMK+T2+4C93lgOOfe/
	 QwXS8jHJOjFOqF6M5vjvUzrgKqxesJiv5UuFlahEvO/ZuDYeMh2Q3/4AiqyNYaNXt8uS3
	 fX8M/UcUZldzFO8CiqC0dfMaN4P/FTkdw1OCQM20YRZadYdPM2SKsN3v3TE2NFX0eSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieM7tRz4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49969606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieM7tRz4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E881F0089F;
	Sat,  7 Nov 2026 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047677;
	bh=GH4SnpLZSnqqUBIm4vEGOvVH382znzP0L1sepJtxfeE=;
	h=From:To:Cc:Subject:Date;
	b=ieM7tRz4I/kJ35CCx2vVdtk4ljt+o1apTij3FqzEnljTzI4RTxvNrwMA8LlO0anL8
	 oWifKdzgnl8pFZ1Upu5S8HIYnF8DkvOrmkkwUolsuMbaTXcwWUxiaxyhm/pAB+0MWB
	 IxPT3PigpCyiUDInkfnikCCy84YmJ0YJkU/QyoR3x5+2Xloq+QJ7zwlIg4irlJVW9H
	 SYEFBVQjyvva0RXLXCC5nifdyWsSKMYEswo3mvNffxOGo59iZeUC7YDWj8HSYhgT1w
	 CDCuE1vFK+GxhBkO8aEfAvl78q9Cfb1QEJL31i78N8g8VK1g5J257uFEMiMl6YdLH1
	 FgzALkbTKdWcA==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: flatten nmi_panic control flow" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:35 -0500
Message-ID: <20261107053435-failed-6.6-75eb687ff2bc@kernel.org>
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
git cherry-pick -x 75eb687ff2bcec9fba31bbe266e5f91e5c283efe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053435-failed-6.6-75eb687ff2bc@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




