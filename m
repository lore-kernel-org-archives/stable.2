Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337395;
	b=qKIFXwDhUCgJES1lkR4ObJ7hZK9pBb0OjRJ33VmezBycoYxaOiz3oQsud0tZ3Lw2w1In
	 KSLfV7ZcQSMnQBrRP8GTOdHq5w/7tAp6vnP7hrgGjj5CdPOUvL8lPUpuQSC55o/Lhfb0N
	 dLiJe8zuNJ/e5vnq0WlP+TnLm+vEShAcyTdzrjPdczaX7imMtJQ1/4C9N29szkv84WzKU
	 9VZnssHBKrfcxlj3+geXFyp7If4rUYh86PdOOR1TFT8v1Y/krgkjLL0GZaLCO6CbQP+Uc
	 WdhhxJfOHaBL6zGyNOwZkeSLlO/jCS664zJh8FLVFRZ0Djv0Dm+hJXVjjsjdlF+wkBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UX2EdQ8edF4R84ulRjnsIwn5b0ydLIn1kJ2/bXwUIIg=;
	b=0tFJHhC8yYf7UG9tP6tQA+Nb72JkWfzxj3h59JgA5rVPxHYKHlaNFMo/wRRiHslz4xpT
	 q0ka3oQQ35K0PV6Z5JZ+eWnXRKkULOFlaqcwxu6TAfnOhNrn0DxBEEN4a3dRBossKymiD
	 FxMDJV5q3w37jaefZFOCyhyCAzdJ1krTdrqDe/Y8svAx8UG7KQHJFyQ/bkN5NBQx9K+fX
	 OekQfzn/bDpbpQBThKc7Ns42vzYuByGUgHi7jSFmQEbIfHzzHqynHy4VQ78jGiYGAVGou
	 Ft8ZCZa0iTUbRTTsLd/h3R4iGWEBBEIb+A5QJ5NA2c+i0a8CMiiasL88dxTbRbOmFdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tvu5QrNl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E4606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tvu5QrNl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3531F008A2;
	Tue, 10 Nov 2026 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337395;
	bh=UX2EdQ8edF4R84ulRjnsIwn5b0ydLIn1kJ2/bXwUIIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tvu5QrNluHmwfvnlhMSpZi+0L79ESPc1g0GVVNGuzKOciYqx7sNKqDydwWOxc5BT3
	 R76u7KIIJEcsPFKRTppZkOYnos0JD5rGZew9hVYzZmA6VIs7QtcknIfPtG7BKfdp0n
	 qA/yBgrtsmTvpniW7uFOKKgwqpssWJHj/LlaLpCb1m0cJF5MemnoL8Wy6NnJwOr8st
	 UlCVTKhdn/v6TmTtg/3BhIrLdbufinkIFYlTl5QraZkzlTqWxQCJq5ywGV/72nGjmz
	 UpKe0kmKiqFNY3BruWKgX7mlW8iz2Xrw1eHOfBi2chXXLSiEFS+8ibsAPVTwmAXNha
	 8SHEnfHwNx2dg==
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
Subject: [PATCH 5.15.y] panic: flatten nmi_panic control flow
Date: Tue, 10 Nov 2026 14:03:12 -0500
Message-ID: <20261110190222.3468951-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060543-failed-5.15-75eb687ff2bc@kernel.org>
References: <20261107060543-failed-5.15-75eb687ff2bc@kernel.org>
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
[ sashal: used existing old_cpu comparisons instead of panic_try_start() and panic_on_other_cpu() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 3b14c6d123ddc..2db714911168b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -195,7 +195,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 
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

