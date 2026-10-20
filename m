Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521811;
	b=EexsDlq+0AK6bdJu2cPrkqjXuoNsYVgwh1nwJ4lbDnq3EVDJ9KaY9FyLQI+o385xZq12
	 V5e/OQmezpZ0mQNdcSc24kwN6HyI4Q7h0YrEeSTbJBBD1lWiugRcok28yqD56+dHLt4j6
	 H/yUb8tI4XzKqTJztuiKmJRYJEOrfCDjkP2XwhV+JHtpvXKOFTpX29Gb/xxv4Tqy6UK9B
	 fEDO5IqYT5NfESX+aBHK+lyBTXq9AwNe+TDr+is7vGeHqU4uL3zJIFnLYmM1dxhTme0Ks
	 9CXBsrBRlojLJgM5kiZXcmvi5X6edKsVJEmBOisQYOIqjdQNHVHW1kWcEG7GHaJVqzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521811;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=yW+ipQD8TDPwyrv1xvhhUuK9dyII7X9ovRSnpipOHa0=;
	b=NymFQUyPnW27aA00ityDAxUE8fHT+gyE7j9y+iVhOwVzANhCKcUmD/kyS76zjthDa5wp
	 N7Rl4JDiyrX5BE+ICsVJszfLa+dIJQAZLezqOhJ0B9DSV+85KtYh0LF3qu3P/HJEVO4za
	 E8ijiMa2KQOhJD5aBY3z6sT2pX/1GnxwheCZi4S3SRaG5zfS3Ud4cGeTA2Mcdf4n6FFgq
	 E3SDJzFKVzwjcGdcnWwrM3n1o6IaUM+NwEilkdj3oTMRp76MMFAWJ7BEyFdT+jnqUeVzK
	 nTcGjO/9vLLJLRnL2IK0qx6BlTzMixqC2PQUIEzyuG2OFBlOr25rT7Zeu8YnjJ4Ws9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=iTh6UXCV;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144D60A2621;
	Tue, 20 Oct 2026 18:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C144D60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=iTh6UXCV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=yW+ipQD8TDPwyrv1xvhhUuK9dyII7X9ovRSnpipOHa0=; b=iTh6UXCVgG5X+Klfar63MxPxpZ
	Bwp7aRBA3oqdutDIVAeiMPnDZ9uUrEhRityJ2lWJXDuoFlM2c1mC+XUn66ExPvPgf+jtXputlJksN
	cDBhVq2S1FSqkKtptIw22RXx11DCckAH0N6EFV/huKnyhA9qDcy0LtC7m8sWaD5fu0Kg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xJEo1-000000000nG-1h4N;
	Tue, 20 Oct 2026 14:43:23 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alan@linux.intel.com
Cc: hugo@hugovil.com,
	gregkh@suse.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] serial: core: clip out-of-range baud rate to min/max, not min+1/max-1
Date: Tue, 20 Oct 2026 14:41:18 -0400
Message-ID: <20261020184131.2893575-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020184131.2893575-1-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
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
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

min and max values are valid baud rates, as the existing code in
uart_get_baud_rate() already checks:

    if (baud >= min && baud <= max)
        return baud;

I couldn't find any explanation in commit 16ae2a877bf4 ("serial: Fix crash
if the minimum rate of the device is > 9600 baud") as to why this is
clipped to min+1/max-1.

Also, Sashiko identified a potential problem where clipping to min+1/max-1
will be out of range when min == max. This would result in the loop exiting
and returning a zero baud rate, triggering a Division by zero fault.

Fix by clipping to min/max.

Fixes: 16ae2a877bf4 ("serial: Fix crash if the minimum rate of the device is > 9600 baud")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c3c1a1d76405d..0498a8524c6da 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -533,10 +533,10 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		 * As a last resort, if the range cannot be met then clip to
 		 * the nearest chip supported rate.
 		 */
-		if (baud <= min)
-			baud = min + 1;
+		if (baud < min)
+			baud = min;
 		else
-			baud = max - 1;
+			baud = max;
 
 		tty_termios_encode_baud_rate(termios, baud, baud);
 	}
-- 
2.47.3

