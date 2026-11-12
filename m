Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456979;
	b=QwCkbtLx9cYjvCKwkOQAzaey4ubyiqvNDHMRzAsck9V2Tdu4+XWhKwpQMKhH6f9RROqt
	 wk8aIM7R3hvOrjBKdeiFq95QjfoA/mJzLIcdCjEDzobU91XUaSGCS3NX7LoihZimYPojT
	 B+t9pem49oP+wtjA099h6cSPD1YZ3F6awYMfDDG4PlGu30YbpLlencfO+njB0/FEhjAmf
	 IpqsXLlC2b3PPARJWJkTKa4tTsljUL1+I/3DVOYk8T6igB3k0NLdt4UZTRsq4dlN9Ubex
	 r1B+VaKNWvQl+nJwoWaX5xXSvVO4vUKTczFpAysDDTtN7O1FvNGwbp54DXYv8UDSW3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cx07ziGcA50aUj85Mm/ZBnVBryK8gFtKvDY2YMtoJYc=;
	b=EqAI/jZqee/R0sSOBTww7k3hP0GbGXe8ArVrQDdWpsNkO5V+4LSI0qJJsWtwOuikDz8+
	 4NP/0ISYwl95aPma+MFoQYcE9Ga5MCHrOx0xwhUeDvfSv40PL/OkbwGQ7GZtxhnOWC+0j
	 PShS13xX/KBk0phBQt9TgGq75F9n66CJaMj5LdZzaf2O9Dddx8qSTN5w6O9OicvORNtqS
	 hXQDrkAzbCPQvb/o3LhtAeNIFC2973GjQx7YGF/+ZaRo5XtyuqPJVASWeSIfT+HKig0FA
	 9a/TynknNThLjtYyr36o5PdOeR5dlU8iEdbTJyG34c5KJXwqd8RW/dS8sBsiJOKJKHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RmJGZdJg;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF4606A33A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CF4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RmJGZdJg
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37628596783so3608252eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794456978; x=1795061778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cx07ziGcA50aUj85Mm/ZBnVBryK8gFtKvDY2YMtoJYc=;
        b=RmJGZdJg942OY9rPhScQBPvnVkEnUGRlsngqVgdkiF3pKXoGg2y1cYTwH4oLb8CQg2
         5N585j9GpOm7a6X5s5k+2F0qU3kMRG0Id6ymOAWHgSX9fYdQTwd7cksIITmK2Y5HXVCH
         63sRX9aIvluSZaVFvwDpVH1jBUVkYrv3HZT7LIl4X8K+9c0goL5LoyrxNSlZxGIpHstH
         u5Mx4zbi0PpsGq/6RETVOripdngpUkEHMA0Wu60KDVQHebkEwI6X6GM52/sMvAY+MHqm
         KzyvfCC3pvLX71DTrsb4OBfQAZe1Nv3lTGMyOUnCGnXQ1MSUZY/8tyjocmoE0RMOf2x7
         gI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794456978; x=1795061778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cx07ziGcA50aUj85Mm/ZBnVBryK8gFtKvDY2YMtoJYc=;
        b=P3Pj35vKSKTX/Bei6chCfQ9YdKu7gpEJJLQ0P7BALATQnoPUo8vmN0rHRHmzmNSHlT
         5E2KfJcqDkRidRHsSv0pwdEDA2scDI9M9LC2EEF/V7JKuR3QrMF59cKeUzzcNcF97LfP
         Tno+mHFvImUOhBrliMlDwMxWHUrccjzzyqclaDDPdcR1Uvx+OWCNyH2npeuytEM7zDP7
         Hrbwm00R4Qo21J2tVmpMIgVinT5k61hOSEaPxHZ/cGxnNRqzO8mtrN6/DziKMWj9OMlP
         +MVVRrGm0r9zmdyj/vhZ3VoNivglQzCIHJE9qQrQ8GYr8mEWaYUHjjLRpgW8X1m5YnbD
         9KyA==
X-Forwarded-Encrypted: i=1; AL+hErGIebtaeWCJOwArkjDIRFu2SB89tQWO5jaWbhlbIX9p05WeuRwLAJvbgRBHEmm8oA2TxErxZg4=@vger.kernel.org
X-Gm-Message-State: APuU4Z94prsUiU3cgb/fxsidwovNNnacPX+0atXhPs0qkR0/dBDjPFLh
	eTDwusvKHiIGbDm3bGKh1BvNjXhRqn3eLpq+SVggtBKQ78bxmp6j2Ol6
X-Gm-Gg: AYBFou3V3sm8DKp+/XP0F8OmWajnMu4wccIj0rq9P2kXnsW/54UQ+z8VvjxKCucXM5B
	lhhw1no+fbnm9wFwja2R0HAq1VWfkfPs4XX2WxKzjv+6oGZM9TKZO0M6FpxJ+D+bFjeupXt1FWp
	oICWOoWxanCEv5UeKfGusS4TQhiwIR248hT4mkTbhMiNerdo4aq/qjW4+Pfozk63klFEWyNzrt2
	3akcPsd4JfvKgy+gVTpCvkj5JV2Qo5InKI334EAI1py9P0sKI4tYjA0gU/ksr83Ajn3rF41L8Bl
	+413BsvhCap14zmvjIGgck3nXSyXtxenJTBRBILRZm9cGBRm/t2YyBk2ESxtchCDYhwFdpV27BD
	F5WH+zMADUzJFnKtT09TJY767lE+MbC2W3HR3MvasLv5VfqREBtHHQzxYE8n0OW6jhv7eTWvIGq
	h78L8856q1U69g3WbdweKJq3y5KJN9bKeoIbQ6DxDLRFcBuGJ+dZMJ2z4EOXIHDP9zuMW4RH3W2
	uJOqH0bwQVEbYle8bssCR90fETKYCTiY1l6zKaENr+AzcoRV9UcBLfHUNfm7fTjA+LvAVbEEdVm
	4lyLbAd1
X-Received: by 2002:a05:701b:45d8:20b0:1ab:9266:f50 with SMTP id a92af1059eb24-1b3c03766d2mr4147018c88.46.1794456978493;
        Wed, 11 Nov 2026 20:16:18 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21300801c88.1.2026.11.11.20.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:16:15 -0800 (PST)
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
Subject: [PATCH v3 1/3] clk: ingenic: Poll JZ4780 CPU1 power status atomically
Date: Wed, 11 Nov 2026 20:14:20 -0800
Message-ID: <20261112041422.2997275-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112041422.2997275-1-f.fainelli@gmail.com>
References: <20261112041422.2997275-1-f.fainelli@gmail.com>
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

