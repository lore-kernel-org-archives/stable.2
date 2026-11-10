Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336657;
	b=dTcZMtVHVBjcha12PT8TXxGbm3tJ46L2i+cBQqlBELsW7/4XfRjNVuzQjjWUjGcEu+Lf
	 m9o10HmF53eIKPt32s+jnxk0LcUNf/Rd5sNzzBgEi5G1i18T3I6b9kBDB46SX+y2QK19v
	 6cr3l9/RpnBKWkoZUuNwy49SYeezeVImlqX+lb0r8MFgLcgd3C8Nri8CJmw7tuLDHSKzx
	 rwj50v8RrhhcS/y6Gtcbp7NyIpqDgoGrcePh3Ft90Jz0OBsNOgC+4vx2P3rEkT5tRsQc+
	 YKNAUl6fwmktJ0spl1AeC8eqJUSso+gsHCtz35KTeG2dWpfl2E3UM1Bb1vyWyvNJCIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iunjm0L/+znqiRi2rwMK4+HbvQsrrkMur0l+lCfxVKo=;
	b=uUI1U4BcHy48r6L89v0Rczg8y5hd+yJiafgkIBV+75OSqwpRABQFdE0qvxN0nX6Byj2Y
	 oXQXlgabQBEtRHZ1KleMwfQgkSnntR7nJe2tsbdfXY984quGCOch9NT4eqR2m7ZvByXKT
	 pLdV7Ka2L60Dm59osGlG3Kgn6/mNU/VTjaOSoQl8eJ4+Xofnq1cMFiMjo0JhhOOTDTi0l
	 /u9jCpd+atUEgXlbAOZbe0NavmadR+Ucj1LzNReksOfvXG47ndMeZEeS/A5YDFFxASlOJ
	 pziVLW6spfJbTKrM2wNXJ5MkMzFaq9x412KiIpPvz2g1uQiZkVFISOH4VlvfoQSxnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHi3o05F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37E60A2613
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHi3o05F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57571F008A1;
	Tue, 10 Nov 2026 18:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336656;
	bh=iunjm0L/+znqiRi2rwMK4+HbvQsrrkMur0l+lCfxVKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AHi3o05FpcpflJb/s++obmlwx4ZUH1BqKp5AXAdHJ/3KC1Ef1CnBqmeyxOBtpXUzN
	 ZfSBEnm1gLkEZE+Zi4cJecOusXr2GDUQ97LJKX0u5bUkIZscLz5GLZfNA6j04Zv532
	 Z9D3LSROoUUzFFrPevXxTIWmxp3hWQdAN3eeUE21PMyf/lyVdbraw11XoqSn7ppyAZ
	 rzuIG5n374diQbMwmiBh+RFV+n19Otp8O3rJac5+joVLWNdXtjOdR7TL5aTgL1it0G
	 4lb8Zzsdpo2i0De5269gHC0kpi1dym2Rc4936Mn4th6+WKsfe3hc0JiApO7Z8BLmBR
	 j2UWGXkavq6hA==
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
Subject: [PATCH 6.6.y] panic: flatten nmi_panic control flow
Date: Tue, 10 Nov 2026 13:50:54 -0500
Message-ID: <20261110185041.3396879-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053435-failed-6.6-75eb687ff2bc@kernel.org>
References: <20261107053435-failed-6.6-75eb687ff2bc@kernel.org>
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
[ sashal: Adapted the change to existing inline old_cpu checks because panic_try_start() and panic_on_other_cpu() are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d7973e9754748..3698d2f8c925e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -199,7 +199,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 
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

