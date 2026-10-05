Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14C2D0C94
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234773; cv=none; b=stjsIUzDVzeJ8rgpfIMmuCJDNaghqxglrCuW9tYp2fq6Sagbedhp8TAKUjTDqNHRJpJil/xSfhPVQAgt/SUEb1R6DV8o/knvKdJx6QX1mv3QAN1SDooCUY9j1icCqShpIQldJzk+6/D73gYP8akFWqSxgscZZP0A1Hzsac/0Afo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234773; c=relaxed/simple;
	bh=IPPD9mV0pKOFoVsjc67Sw7mDjmA6dQ4WkiNRla3HWRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ2fEu/LRQGKh67c5iHT/LNBgVyhC53wGIGCl7EzX0RqJyT4B/yZP9r+KO15m2NwiEUfsbNpQ4CQtH0iHMKx200NGmJ/uA2ISxPtdrkq2eNHldGTj2tUNst3nUuGHtOZnkrmF1lFAlfNlBc8EqESkr55Qz+9in/5Pj94y324FRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWjA/9bv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWjA/9bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69641F000FF;
	Mon,  5 Oct 2026 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234772;
	bh=C5U+D/UD9GAuaGUVJ1oGeV7hLrJPNkMdP8/KDzP2OFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWjA/9bv7/zBOTzoP/zOAd2t4WQGECd5zPe4XlXH4B0HkvfENQBcgSkMkib8AvoWg
	 EOV7v8nHW29E9YCK/5YZQqCwu9nh6pP3I2eqMvmwPbwZBbmHGsMKrVUdDpTfi+d4Qi
	 LZNvWkDxOHAWsDrgeRwoqrtCjA9NppoM4fAz09QA8c0x/G64PNRl9Gai0e6AYunyrv
	 +ksU3liQno8e37jM9xjBGh4dg7hXnL3bCN4GsIHzmvtgk1oA3VWWuL6SD30yxvrGcn
	 6DLOZ8HjZIOwTAnWDzDyLx7BApuQrK357toiOTXOPd9ETbkDNLlrc+ys1JgpNtF8Eh
	 rbc8k01l6PbUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tty: tty_port: restore TTY_IO_ERROR on activation failure
Date: Mon,  5 Oct 2026 17:12:47 -0400
Message-ID: <20261005211141.3350600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100522-unleash-grapple-6912@gregkh>
References: <2026100522-unleash-grapple-6912@gregkh>
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
[ sashal: Adapted to the existing activation-failure block with explicit mutex unlocking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 2f1061a9d9263..3afdbe5ea156d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -694,6 +694,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 			int retval = port->ops->activate(port, tty);
 
 			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				mutex_unlock(&port->mutex);
 				return retval;
 			}
-- 
2.53.0

