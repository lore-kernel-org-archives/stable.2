Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449233AA9E2
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233689; cv=none; b=iMjb1GPmy0TWO62LLxvNhUtyQPGcEdixJeq6nhFmRVmowFkEQJkvOszmFbb6waX81lDOMiqgDMiq3OfFpPujBaf4bxJZlI+MnWi43+9a7y8T4c5Fu/aE6Tv9OFvMLOgQkQckuHIJjCviyVWg8Veg/pRxQQEy5jZoPrqq4tRnrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233689; c=relaxed/simple;
	bh=ZDwYvAX4AqSpiCy1YXGCSHB4tjNDhbvCD+TQPrtx30c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YteGXdEACEqJXeTkeaQ3s7IOcGqomhSR8ywDZVPntiLTpjwpMgh0fRvHtBBdXT+qg1rtmQR0qbM5OrRnOpjuBKcutwbrLV1llEkYqAldEGwID9JlSDSYolDCbW9jogEpbAX22gzmUh0HFXLzYqUi1Sgip6a8PXH+T2pAJXY4WD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie+XEJvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie+XEJvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA5C1F000FF;
	Mon,  5 Oct 2026 20:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791233686;
	bh=+vwOL9vMIhK+J5RmKBslcQpJUCBdOIyFZM8/IBqsHiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ie+XEJvNmh2Z8SazjZrYrNA7VomwE5KSBtYv9TwZP9/eFXJz3ajaXnKolbsWxIfyd
	 +cwZry118ln6DvL1yBso+mvCsmDTLn7e5faGI0fbLvN0OKawIDFHMKvto4p3r3T+g2
	 jYT6Ae2r09WiE5ybORrOhkSb9wzB4FGEN/OhHO7/1juX6c/T6V0Vir5eLv+JEpD0n5
	 1DuHslp0eXMmMmtXtJKfXJs9/8tLZM0HO8ZQhpz8TgysTcM9JHECUgAcNzljjPTbOI
	 oxm8KLdYlAKurYYM8y8TXN8X9d2NPZ7Zl5uAPWsTXNrzo09Lwe0kWN6dFYKN1tOZ4l
	 xIKq9l4St7GjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tty: tty_port: restore TTY_IO_ERROR on activation failure
Date: Mon,  5 Oct 2026 16:54:42 -0400
Message-ID: <20261005205257.3275534-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100522-tidings-ouch-9669@gregkh>
References: <2026100522-tidings-ouch-9669@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 56964f6a31238fb41d5830bb42520c5b10ff7d8f ]

Make sure to restore the TTY_IO_ERROR flag if activation fails to
prevent I/O attempts on a port that is gone or powered down.

This specifically avoids issues like kernel panic due to unclocked
accesses or NULL-pointer dereferences when accessing powered down or
deregistered ports when a TTY ioctl races with hangup and open.

Note that the flag is set again in tty_port_close() but not restoring it
on activation failure leaves a window where drivers fail to handle the
ioctl-hangup race.

Fixes: a9a37ec33a1b ("tty: tty_port: Move the IO_ERROR clear")
Cc: stable <stable@kernel.org>  # 2.6.33
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260908084000.218528-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Adapted to the existing braced error block with explicit mutex_unlock(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 494500c453ccb..6f3b4eeb44b38 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -783,6 +783,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 			int retval = port->ops->activate(port, tty);
 
 			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				mutex_unlock(&port->mutex);
 				return retval;
 			}
-- 
2.53.0

