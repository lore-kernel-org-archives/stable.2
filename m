Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595377;
	b=z3TfpYQvBdYVNhw6wYqgIZDkzu9drvBw5MLMM2WgSVotXHHM9jg6EdxtLbOS4vxIjm8Y
	 my8adIA1EN68bHr4FRW7rtaqGsDq4LXDPK7d0VGcCIbvvdgEmoVyR5uoPTHxLZ/bp4zQR
	 X8/LQZK2t5rXh2KrrNPvlKL9idTrjkHn1EsSGoAEIhyNyyPWkEB78AsWF2bfAgRpFzlrg
	 wWlaAJIVgk50GYZi9IZpGmH/r7qa8mRUfaL9d9tKhFzt2DsFPySwkO6wv/IHVewOvuWeb
	 tv0PyP7xvwAO0mIJ1zF6cIzhKWfaM2iZ/TNctsoibw1OlHfK/s4OWkISNiMlE6j5mtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O+cYsgzT2IYrnjn4UHawDYzQU1HcpnMtWbFIeQ3G3aw=;
	b=YWyiM9hiutQDNyC7i2ft6xVfLOcWFs7O0hqT66ch2BwpbQVLHFfSzkvj3jjNCTehAqCp
	 PBqgh0kIueZXlptgdPxrsSnOgMsdDT0U+9FJ8Z6FcSnLJe4yNI1TadiR1CuZurhZsFFAP
	 icyqBca0z4MYsXfe0Pn9DSeRuN6fsw5YtuREA7auh1KDPV3ocQOBbDa4cfxzWa/Z2ynN3
	 fYZwvcDcZMOdWZqjDKRQS3l7N2ebXZxWytDByu2Micq3TNB0USrCt3KAxsGTuTXh9j+I0
	 MlvA1ksOCjL09FF8ZrGs5Nb9rYXwTNyEE2y3Ygcvws57R71nL0Knks5x8GoRDZ6EsHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLUfjCmP;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B5606A89F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E3B5606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLUfjCmP
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so1638011c88.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794595376; x=1795200176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+cYsgzT2IYrnjn4UHawDYzQU1HcpnMtWbFIeQ3G3aw=;
        b=JLUfjCmPNspwfncVcLCqOgrOYo48PDU/oZwv/s2ScUY2tCi7OUgYTFuEpdqXPh5MEi
         kvByBIDETbxVN8UX0f2GGLDVuaupezMITaxV0VLZceNmvLytYmA3RJLqqq/u81gpeBdX
         kuRHLkO3glN1ZVr9zUjwO7AXuvoX4K8ok1M/rE9BssGt1InXbbL9TFqHE0JgnRicS75z
         RAdWayHaQi2mysXJHs2pughOLURwVufmdoAHYqry+gSShG9xvntDYwOxBIBNj6014xVT
         KD9mjYPdyrgrxTcdOpQKbuukeg3xxS2pnL9tKI7TQLVVTP+6yYP7lrsZrQof6oAB7PG0
         y5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794595376; x=1795200176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+cYsgzT2IYrnjn4UHawDYzQU1HcpnMtWbFIeQ3G3aw=;
        b=XORXfvIvR1RvvtQySWvMXVCdm25Vt1A+asX0cqw2owxD3hlQOSdAg9JPKmnwJteiHo
         xCpIuejrouLpYVyGLTcs/ZVnSQneyZvPiNWIi8FZKugwNBziiawoxf47sGHWeLYZrp7D
         Tu9u9n28O1lnuhRlP/+lFdeLh6jBvHWC3JEFkyVLxvbisftb8GK/g0C/bbPXry3KJKFB
         Xr5TH5B6xADu8gwFnYJ5f3kDX8vLxBIsWMLjxVQMa7/oZvBaPWWW1DBfhVUEAoVH6du7
         DMJMhNVaCTuaM3jnoD6B96GgeB5hWjDzo9V7Ox/aUTZdXqZdiFzFv1zjCqRJJfQUtcHS
         akUQ==
X-Forwarded-Encrypted: i=1; AL+hErFJmjcTy2UgnZ5xu/DbfwDh+dub9c7HLBeQbFAW6IKRbPAYFPvGeqBIH3lOFkKmXUfMKLMSRjk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uan6LGKugXgsQx07Yw/brVFHw7i3VMQW4GQEZaFMeSr1baEcD
	/F6Bjtqy8xXLM4e7RXjiqq17L0lFCwf2L7l6PnQeKo9+Hwlkcit6DYTu
X-Gm-Gg: AYBFou1n1fMmDK/7wYErvgItApWfL0/Lb12b4uOtYM7sV/eqkSMph/Yo61sA0PGIXGp
	E6VJ8lVlU5MCm+UaAVuGdEbkw3Nb+AwP9/aIz8DL5+i99Zk+oakO9yBee2JPyjbYzZ/RwY/GMSt
	IV5fHLq3IeNGHae37bxnAD4WENnDkCAskZCKLEyimg1/I9JT/BWJW7LBMVhqIkOYv70jM/gs1el
	N0FFsYkE2SM1LHmDhj2XQZ88PPN0QCo/bzauC0H/Mr9P7wws71nBkYxLtRaEjRxhdZNzTqoV3vT
	YFDZZCEtu5Iwz2+WxW5xG9NcY62XNna8LvxxPF6UFfiHFFSwiWSUDCeQ1PElJNKjQsUg8ip1DiI
	qyfVMj+WS+P/qwMp4HDKDVdMEz8VgpUcrLlgLGvY0KQL9RFea9muzvlcuw05iFVrBzKba/Yx1Qs
	yoMDK6zJfBhXubAvGRDCW5Ah9aAICYkBLJmtRxe+i3NloFZVBjWAgVK34Gj+5jISIyFJh0RqPRC
	RIerOvn6acl8+Mx2uPZHaVXIas0END8A5W/YSKq+DLR1BVBowh5pEg6ocJ2+3dMlxsHRJlsJhSr
	pQQxOmvP
X-Received: by 2002:a05:701b:4648:b0:144:fb31:a597 with SMTP id a92af1059eb24-1b5031695c8mr3293113c88.47.1794595376420;
        Fri, 13 Nov 2026 10:42:56 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm10526177c88.8.2026.11.13.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:42:55 -0800 (PST)
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
Subject: [PATCH v5 1/4] clk: ingenic: Poll JZ4780 CPU1 power status atomically
Date: Fri, 13 Nov 2026 10:42:07 -0800
Message-ID: <20261113184210.470320-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184210.470320-1-f.fainelli@gmail.com>
References: <20261113184210.470320-1-f.fainelli@gmail.com>
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
Changes since previous posting:
- No changes to this patch.

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
