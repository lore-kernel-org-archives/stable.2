Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509150;
	b=VySgV20PKV7qsKydAn4dHYj2A3Y25AdVhyRxS+fopmXcKRBEbSLKOKWud4quqSrHX5RU
	 NwsMnq+igTNWlVM4ximV1v6XwQlQ7QwPUurqDnYyLtBm1Qg6wVmOTFdFcSTu1xX+lE2cc
	 vk7IljV0AAcmq50rfLCKXaxtv73FIDaDV5pfTPDhkYkayf3hA6XUDqi7lof25+vdi+Qxs
	 1tmGODbjnuxQb4qHXsm2NRtd1m176vsgA+2e6mpmCV368sqwpUP9H9skq7d8f/vqwDhLb
	 f1Dzl/KGZBqGzwUXoEUm8najqAso6YUoxZC0MRFosmUzcRj7yMmieET8vvNcr1ItnlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cx07ziGcA50aUj85Mm/ZBnVBryK8gFtKvDY2YMtoJYc=;
	b=zgVWfI51OJSljoRo+W3Ca6bTS/SOnicGrRB0z/Vix0Kl7o62HSYOweqT00vmdt2QSrlm
	 WqNXPLwkFYKH7VhtRsfm4d97T0t5rBaVoolpVcGqwQwC/eHpl9xaI4UMjO7cHjhM7QV5Q
	 lxLXKkeoONAwvu9Bu1EMozq4hDy8RHBsn/8vtQwPKSRjmOzcX+ynBNsFzEqkgGPu4pXxi
	 9ZMdzS9e8lFmG2UlCQFGfelknf5+gUW/cWLXxLkK1anixPCbihdV2YqZrysVLi3kh3RsP
	 od7lAsImZ54PE4TREi32MmeunGP/6bAySZS1/ZK0VDxJf6oVTf8V5Kb9qdtumaHmSGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvqCJG4s;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400F606A33B
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0400F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvqCJG4s
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-372bdb942dbso227181eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509149; x=1795113949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cx07ziGcA50aUj85Mm/ZBnVBryK8gFtKvDY2YMtoJYc=;
        b=tvqCJG4sadbpnO9DnV+uFosM78XxQbI81mrM9a+WHoU2qGeXvav0WbusoVQ6AnJpYj
         tZd/x4021EFc285UdhOKNe06ZSJi8txJuYz+iANhdPUat88400IL3CNIQotARvfES6NW
         Xd0gE5Imo8+N21hsoZJnXanCSCSrPvUJLWdLo4UpR4tp3qyu/CX+nfDV1R6iUrde4tdU
         6Q5cQtl8j6sngNzYfyeeW7QcO8Hn4RXclW2JVOgz3wpyumLZjbD6G3BcUkIkL+moEKOV
         xkUV0ozBi2XNL+QLf/EtSLKqXyJ9F96PcSaHiSd396HX2MyoK6sJJIWLdncNDXW7VihA
         TC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509149; x=1795113949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cx07ziGcA50aUj85Mm/ZBnVBryK8gFtKvDY2YMtoJYc=;
        b=qLLZo3vPYnbOrYa3cTRnUW9wAbsjJYPngH3P66Yas0HGD8zI3GXslEWWHnIZY+5uKm
         ATTcZeUCc7pjHiFwOzxWnX7YmkzWFbXohV9YlU+wlu/LWsGkEKx1MPzpzbdedOR/ZMui
         HhjXiCHOs7Rl3+kse8WFetItL4WpvVKV5uqI4W9hXi1HionggpVV0h8w9CuLS5NKq5n3
         uX4cJyW3w81NEj51vFF4W9NAZCDg9SwNEK5R1/BpLaYCcFJZnIQT9OZMbA0FTYH6GvR8
         mhYlqUFgefRJ1e9LVB6hS6g1rZrMvI69cluAMhdq7r8UI7XGWhYxOzDCGI1GlLu8D/HL
         XFHg==
X-Forwarded-Encrypted: i=1; AL+hErHdI+b3TEIOO7WQjyZNeKEWz6oLYiQJ2PPvlEeLIK+pqmphUQbJtqgjgsyFD1APDYfu/a9Pkbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UP0F7fdxB4fwUVVnmnSLrewNUJjGQ5KJKBlNpPCB+L0UrUNuS
	mRNMDTAGXdQF28FyWudbJIXhD14sMNV7JQHHm8Qb92SLivbphUD85Zzh
X-Gm-Gg: AYBFou2eEM/5XP6zG4sKIjjYcUKfHwRPMJv1wFjKR7bh+SLS6gvih5oGlwk6gMFl4He
	1dbKfqMRstGS0qvlj9rd6IqMxIl/0jjotD65OF2owvkvjQkbWCAh6ZABuSpceaxzYMjyDzqI7Dy
	0rKN7IHpsk2dj6ltIwPWavS9Yc/jMSjYwwcEf6qr+G6QJlakvQFITeqOlGQqooi73aO8dfHBzuu
	lL2KOqgTVXhltbpRwDUp1Rrb5BWgBnRzdHRXWA95QRfPgzMUaQOM5W3PwyhYsLP93nX4aJsfKeJ
	vC5AmlmgV4Me+U14sGgmhz3ubZsiIlsCM+4fSZFIxcC6K2r4RiOggWfmsBWwhcQr55QbOrHtqGV
	T8c0X+PFfe50H2R3A/HYCl/GzajHXuFgaYU/Uwpnb9ih5kzJX8FTPLGFvmcY8p58IoWpJBejI80
	k/KJvr1jC9wHx94VTo11AX3QFtwbyGYvBJFSbhdmj2sXFhqDVTfefPXkYTvQB49vYr8032tO2L8
	+TGxZv3vE+hMPHLSSMwTbQrooRF+XND67/5+wo8yJL7DohyqIXgbewg2cgbvzV7NorDefaVfl0Q
	Nb4X3QRn
X-Received: by 2002:a05:7300:d181:b0:36a:1807:75a4 with SMTP id 5a478bee46e88-37967cde7c5mr17495eec.20.1794509148932;
        Thu, 12 Nov 2026 10:45:48 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad134sm369524eec.27.2026.11.12.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:45:48 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Burton <paulburton@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	=?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= <zhouyanjie@wanyeetech.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	hns@goldelico.com,
	paul@boddie.org.uk
Subject: [PATCH v4 1/3] clk: ingenic: Poll JZ4780 CPU1 power status atomically
Date: Thu, 12 Nov 2026 10:44:39 -0800
Message-ID: <20261112184441.3724150-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112184441.3724150-1-f.fainelli@gmail.com>
References: <20261112184441.3724150-1-f.fainelli@gmail.com>
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

The CPU1 clock enable callback runs under the clock framework's spinlock
with interrupts disabled. Its readl_poll_timeout() can sleep between
reads, which is invalid in this context when SMP powers up CPU1.

Use readl_poll_timeout_atomic() with the existing interval and timeout.
This is a prerequisite for the JZ4780 SMP bring-up path. The original
CPU1 clock implementation by Zhou Yanjie is already upstream.

Cross-built for CI20; the subsequent SMP-enabled image brought up both
CPU cores. Development and validation used Codex assistance.

CC: stable@vger.kernel.org
Fixes: 6673db4f3f26 ("clk: JZ4780: Add function for enable the second core.")
Link: https://lkml.kernel.org/r/1582215889-113034-3-git-send-email-zhouyanjie@wanyeetech.com
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/clk/ingenic/jz4780-cgu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 1e88aef7ac0f..1809f8859c7e 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -242,8 +242,8 @@ static int jz4780_core1_enable(struct clk_hw *hw)
 	spin_unlock_irqrestore(&cgu->lock, flags);
 
 	/* wait for the CPU to be powered up */
-	retval = readl_poll_timeout(cgu->base + CGU_REG_LCR, lcr,
-				 !(lcr & LCR_SCPUS), 10, timeout);
+	retval = readl_poll_timeout_atomic(cgu->base + CGU_REG_LCR, lcr,
+					   !(lcr & LCR_SCPUS), 10, timeout);
 	if (retval == -ETIMEDOUT) {
 		pr_err("%s: Wait for power up core1 timeout\n", __func__);
 		return retval;
-- 
2.53.0

