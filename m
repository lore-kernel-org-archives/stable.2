Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050564;
	b=Ly0SbHmKDHNGDieOOUfGmbK7hyXfB33/jXCjpA/C+ZuryzaKH07JqlAghZjkqWoFOjM+
	 AFDsUAn4wPHLiWCkik/IzzrNUsUfJ61881c0lcwJcp0T2CQlEQwrNbK5AeX6iGgrbueru
	 4VOKhHKrgCIxPmISYt8D8hhmJL4hUXpm+1Akyg09UyIkEhAEEFl9XHIPduLI5h+JHB+vF
	 ifpbg0b+lA0CuWLbHP7UkqKJt/4CloDeNohrInH5H/G1lBaJAbrdBgEMDChtvnWOqCOLF
	 VRaq0q0n7XRB622PWWwO3WTl8OCc0OhgPs/O3Bz2QR4dUp2IG7dARY936O5W5eLe15Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iL2FWnL4QLW7t7K5kW1MlwboMKbUTmHtwCTuJECsvYI=;
	b=5NRwz8QUE2uzleNGmkiS9rneuBTw5ztPLZtY4eKTZGlLPdaAPItKhlo3iX7DaN2bKWux
	 oK7Cr58CUE6dF1VV65VzZjJJYvrt+sEVoGdxqbD0bJWqfbQ2BfNP9ebEHevubFRtbnquA
	 jq43Hrt0ri6OjPytEonQqKhpRxbXtSQzSLC3woMMDLKje8OG9bdHu4B9duSuWmvXMtVxS
	 USmgpkiDa6Dn2+LiMbISN+zVoAD38ueu05OV3aWf6vIqtuovIHtISRBBDlWjSERPYurse
	 FotKwe92DfhZVdX/ZQOnlKjbTOC6YrTcWzhxwfL06m54rAxDJRWO9muzgclM/HUhCDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kSKu4iS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E66606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSKu4iS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDD31F0089F;
	Sat,  7 Nov 2026 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050563;
	bh=iL2FWnL4QLW7t7K5kW1MlwboMKbUTmHtwCTuJECsvYI=;
	h=From:To:Cc:Subject:Date;
	b=kSKu4iS/CsUb9DtFeKd3EMn0CEo9uV7JyqAsZJCk+P3CpvxovzFnUZxhK4udxp9Ox
	 ojQsqGwwO57W52fnIBh/y3eNS3q45lLWfHyBOHzEMg2UktkKsuu+wW7q/83nJHuW1b
	 S6Oe0ezsrZYdtDt4YgcxmH/TU2uWa1/8nGA/IdWDkhNq2w7TEml+WM1pAR/6RbNw6L
	 1dAiwTE5yGhs7eJ2yge7z/GHZqpDctPpxqq9CkLgMLCnHWI60u5NolvrjVrOHurghg
	 kGNwgkEZvrI98RJyGWyHkdaGTuz9iTXxVbqIOVWBp2RX0Q3qa4bMjBMr1F+UwQ6kLz
	 drdxgstG41iSA==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: flatten nmi_panic control flow" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:41 -0500
Message-ID: <20261107062241-failed-5.10-75eb687ff2bc@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 75eb687ff2bcec9fba31bbe266e5f91e5c283efe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062241-failed-5.10-75eb687ff2bc@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




