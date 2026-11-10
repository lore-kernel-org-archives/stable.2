Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340712;
	b=YeNbPIPLeGwyoJXAueHFjjRy07t2ermYBp9b/J1N9p1nE9OLItr3NVNEd5SoopycOO80
	 cZ7DYxNTw/btxRBhYerCp+S8Enj1FQ20S1XluyDWwwzYrZ/9JEQ4C16IX/AqXfmjAPi8i
	 xZRAL02Ae1Zb3uYDVKu3QLBA/ko0DmfLhkRdCsWsoa0FnlONvkzCNeqa3EWN876UgqzpY
	 tOt6HJyOAudHc/l5P9OXaVtbWdxuhaG5TiBWK1ES1rEdnO+KQEa6ugTkGuHzURYNxEUKV
	 UtlRiW/Omu6M/CblBVCM6pjceHVowY9H8WAYge8gcZLhnYg6KbrXlABkQpIZB5Aj7UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S976mcGDoerGz+Fol+MB3WodO6oXAi3xeuUXQLMLFcE=;
	b=JOP8jTjvMXRetPHo3xva6b0Loh80E8RMIfUZ8A/jDSukk60tg3vJ9vsUFCcGr2PouaqT
	 L+vTCwvchv5xsntXX93UmhL+uApJnOyrGaPgIziJSHKpU5L9bQZ8NZKZNqts/IVHSy60u
	 TwSPxTGj6UXiPDNI4ireLrvZs4qGZaURiOE9pMvNoBUOP1WfgzmZQizCWfCPPBbqEmUe5
	 GxZfbpT68SrMPfzoI+0p4ikwhv3BrrP/yjqyB2iovmJf1c9cAs+WPD5r0QJjYevbbQwk5
	 liQRQuXyY8oCQuifnYBt2olWKi6H87TaQBxpQ4OqNfdSOE/hVGmWyhkpn/Cj78yqJsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBl9PdsQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBl9PdsQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499071F0089F;
	Tue, 10 Nov 2026 19:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340711;
	bh=S976mcGDoerGz+Fol+MB3WodO6oXAi3xeuUXQLMLFcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBl9PdsQYTxFirq4+XUS6LaI3tFwsO+w7QH52ZKrrXLzBXBxWx9uky06FpopSHfG1
	 dAuvWw9+91YPrM5scGG8FMIk9ErN3MtyC+4pENb08fxTdNONTQrVBrQZJrYSqQhuV3
	 6UCaYLFcfGoaGCef8PWBWninwOyyGohhNjCNCWe/0BIfjug9itITiegkyzZSlZFjEA
	 ziJUvh31KbgxFnbCDv/XqG1Ydwm/yCjB2uRzCvgpOemBB1S0LeeTUPBSbFVZ2Lt9mR
	 Au8iVWqCFXEI5PnLDW/SzTWBy5g44MA+0ib9ybfLKd1hFp481yzDWUJm+VMj6mfYGB
	 +XLCNTSvLspwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Guenetr Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Wang Jinchao <wangjinchao600@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] panic: flatten nmi_panic control flow
Date: Tue, 10 Nov 2026 14:58:28 -0500
Message-ID: <20261110195623.3491996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062241-failed-5.10-75eb687ff2bc@kernel.org>
References: <20261107062241-failed-5.10-75eb687ff2bc@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <brads@mainlining.org>

[ Upstream commit 75eb687ff2bcec9fba31bbe266e5f91e5c283efe ]

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
[ sashal: adapted helper-based conditions to existing direct old_cpu comparisons ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 30d8da0d43d8f..f7dd6095b4ece 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -194,7 +194,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 
 	if (old_cpu == PANIC_CPU_INVALID)
 		panic("%s", msg);
-	else if (old_cpu != cpu)
+
+	if (old_cpu != cpu)
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.53.0

