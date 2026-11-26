Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705824;
	b=3hcIiWRBSHKVkuxL+GfC8jnFCBzSVq2Rbaa0wo8Te/YU6uYb/yc5F3Ek1dRutfHd2an+
	 I7KRKFydn1kS56Kh3KBLgqcI5aA3PgVCJJ9w9z/Nj7W+wFp8/2fj9DxzgRV2IEGKbbpM5
	 5rRcVypnujla13nRTqD427B17rPfzCZjFmY91MXskh7Wo23r9rj64s2d7llVC0yYV3EqC
	 OryhEK+7rDcx97YDHy3q6S4uiMDPw2CGcTdLT6RSi+JoJwA8LmhKu+A5EZSJAAkQ/Smoc
	 xgVzLFUBWD7/lcabF03jOfEaY8Wl0Z7URWKIDdLSdLRz1ykbPHfroh1ieQocFOtzhnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FM0TX9pCyKlYvGAUXG7lrvG1MPeIfpE2i0x83ef+05I=;
	b=dqRMOSOmdEF0CEUV+0SYlN24fEsQNYR3c5mQCP6r+zhJ7d1sU2G7/Lmc8CdY9JLGzVQP
	 S2kMvgEuDinNILZi95jvSLhoOB/+mhAeL2NFjUO0IDLIg+hxMu3Q6szkpw94DkkT3ToNg
	 R7SWOacHD/4/YgF7zEp4y1A8+r6PZP3pbnm83SWZe458ZZKAfKCO2gvFwNAVZYwUCKA1l
	 1tLoXp9ODvJoMkqL27cPTi2e9dhPIxHlWv2CDLDUdwWW+gEiAn+GJofot1Ey6XI4lxjOG
	 QNj5fNq/JiQwt5X++GGlY8B6g0HZUS8pwnYhXac8J1woJ12KcpJaeXaKvpFTMbIQWUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eKnKELa/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C8606A32D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKnKELa/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1211F000C4;
	Thu, 26 Nov 2026 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705824;
	bh=FM0TX9pCyKlYvGAUXG7lrvG1MPeIfpE2i0x83ef+05I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKnKELa/DPd1thdCcZOm6So5WW4wLEch9FC73H//u4jxF14743CLKyPUPsK8W2AQ5
	 6vrI5SMtjeg1zBwrwRWx9tKlU8q9Su0J/V6zhwSQ7OfbYFc2gmu5fAwk7Q1zSn8EXI
	 juNiTA/UUw2USIqg8xKNdvEdVM1xH0KAUfMpKjj86WErriBI8VCKnzOMtK7V9l3wyA
	 Zw95jQDCacVzINsQzL9q2etKYgNlaKCl+XjmVrSJVkzf9So7BhgCG/Lk4CFV6SAmmf
	 NLCH6pZWSxE4uroFjPNtoQ5Xm+sw7C4aQ9EFQf/DdWjlWxOV0DT2+buaB+fQj/2AcL
	 BEWVf5KUTF61A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Baldyga <r.baldyga@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] serial: samsung: don't leak the tty on an RX IRQ
Date: Thu, 26 Nov 2026 10:10:21 -0500
Message-ID: <20261126151005.2254355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112552-acre-justifier-533d@gregkh>
References: <2026112552-acre-justifier-533d@gregkh>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 7ada442f5ef77f8d53f608a0141a5e88a888ca9f ]

s3c24xx_serial_rx_chars_dma() starts by taking a reference to the tty.
If the interrupt is not a receive timeout, it switches the port from PIO
back to DMA and leaves through the "finish" label, which does not drop
the reference.

A port with RX DMA changes to PIO on every receive timeout, that is at
the end of every burst of data, and comes back this way when the next
burst starts.  So each burst takes a reference which is never dropped,
and the tty structure is not freed when the port is closed for the last
time.

Drop the reference on both paths.

Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
Cc: stable <stable@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Robert Baldyga <r.baldyga@samsung.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20261027-tty-llm-v1-21-99b0202ae546@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Moved the tty_kref_put() to the finish: label, keeping this tree's uart_port_unlock_irqrestore(port, flags) in place of the upstream uart_port_unlock(port) context line. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 09dc73654ae3f..9222e1a1a7c8e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -693,14 +693,13 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 
 	s3c24xx_serial_rx_drain_fifo(ourport);
 
-	if (tty) {
+	if (tty)
 		tty_flip_buffer_push(t);
-		tty_kref_put(tty);
-	}
 
 	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
 
 finish:
+	tty_kref_put(tty);
 	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
-- 
2.53.0

