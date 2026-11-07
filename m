Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049546;
	b=Re+laZhMmlbMolyi3xneUGpuRdNnLOUyiE4etvOMBEG+003afhwvOKIIJnAlug7R6sey
	 IUZjkw5Xh+M/o0TK9vd7Lx7WzQo9+ivjXXuAx//uMOdPiRTfGIt89CzJLiWLVsjDTs4Ap
	 8PBqHwVJKY8bLMyFj3Ba+LDYveR5fDIsyLRw0wRXlXs9iBqnr++QJOvrFI5fCMbzR8pAR
	 08ZuIrMjT2h+hXMU2I+ZnUbBQgitKgVd1AgeB+o00jy6czO33myoMRrjgnaTlbL1uAAlj
	 jcNyMoI8C6hHuJCSdmIulKaaKY2gm/NQ9fJsz7jqf2iGjO7WTKL+XctJy1iH6+RuLqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4hVRUbXGqz8LjpCIlqTaXF6kjNbGGDSsrpbgSUmFIlM=;
	b=XbtzjAXXUp/Hq2/xCQ8mEqAOW2baV0AodhPQkNZKEyfuJ8WqGdhRQNTWGV8teGkR+ZfH
	 oP9ssisIu3vmPQ6/Ia/CWirIgHMS202yKk4nBbFFh7S+NQ67PE80KU8Waaau3Ken5sXBM
	 m6hpQYKvK4xHfeXwyVmG4+jIuV05bC7h85MBAUn5frWshNccaVnTGb/pqI6nkxiryDcnd
	 ZjBbIs+ytjLesoKpd6zyGKjpOhG0aiTM0pygOrdudxSd5RTFN1+hyCIA+i3ztJPdUBPjG
	 zgctAd19NIyVsOipxFw1RZx4ER8wtEgDfYSu0rywcYQMAiBoYrhw2s+IktLG4Gu0G2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0RHXIks;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0RHXIks
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BEB1F0089F;
	Sat,  7 Nov 2026 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049545;
	bh=4hVRUbXGqz8LjpCIlqTaXF6kjNbGGDSsrpbgSUmFIlM=;
	h=From:To:Cc:Subject:Date;
	b=C0RHXIkszDTZnbROqu7kVbDZraly8IYheABlTeMJXr+/N8qB9HOdALV7y3r8O+h8M
	 YxgmbFjJcYjju1kXQRVutlOxTsGs0GCzkMasfs/Q563Pi9L7xiXlgxzRnTCUZsB/bD
	 n1WDHcztO9mc9prPj166GJfi/c4j5bdiGDQ+lgc8/TKfzYNRAx0mxsi6gXCSp+CHSF
	 Xyg1r+EhtrJ9836a15YxA4ctYcyq3NBjcOrbrRh45HGqgTVld0vhUsANGzjpGfT3Su
	 /cOt/EyiDVH8rvD7ywE5EM/Z/vGPCx7W0HGW8PtIdPO2bpiFSxRP1vPNUD42DwKHBm
	 cc5z4ne9zgl2g==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: flatten nmi_panic control flow" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:43 -0500
Message-ID: <20261107060543-failed-5.15-75eb687ff2bc@kernel.org>
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
git cherry-pick -x 75eb687ff2bcec9fba31bbe266e5f91e5c283efe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060543-failed-5.15-75eb687ff2bc@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




