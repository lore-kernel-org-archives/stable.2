Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD72FDC20
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235311; cv=none; b=tbia9BmTPlvCSsZ+q0hTXULnUxHb5kwYTaW/B7i7uS5l5vlmrA42luphzSitVTC4jWk0OCHMuKpbg1Hvhmnyb11iVlV0MjwIblIOJH8K33HNI3n3Uc5vukbRmtg6f3GLSet3L6ZEYBJickFmkZaxv6Hv8ivgU3YHA8L7wBmeR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235311; c=relaxed/simple;
	bh=uHqDnb332pyBXgnpOZmTExMjxOEJ3vSMJDtyQa/7RPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne9vbOq+2/paYw+pqzpboO5UIvDcXlyRBptHBfsRGkNQgdNhlGbYS0W13L+Dvj9jPZUgw9DzGwvDR4AnAbilKgM1Kl27dZVgtFlYd8Fr1Rwr8Xm+n77b+Wtuk1m1+gBMkRedC9U25EunXXUGGPk6BOHUDLb8PoCm4OFZHJKqwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSiwza9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSiwza9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74B31F000FF;
	Mon,  5 Oct 2026 21:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235310;
	bh=+aGRhh3oXFo+ur1mgV3ybvgfyOvtiDjY/0voRtEEcjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WSiwza9kFjoY9Vz0Lezggr9hS0nzquCIddCWscfYAwcnBKSlkF3DcJ0rSTd/kULjc
	 epDsJgccvklzJPgJhWkRg7uWDUEcI896TBK6A0neGsJxbN9CPyVWmBUn5bZNs9sJlj
	 KLJOwj7Z2juqFbgNGX9ZYnDcpymK6a+zqmfVlIk0daPOjFD5vndclzVuW0FMS9DCwI
	 kVMpx/F8ZmReT7YI9q699vYA68lWnBlGaP7vsQG7ZIlxTz+4DS/w8BBw01vg6yZ9Xf
	 mIAjzPuv9A+JvTrQnqqcw6VBxCDvyRldosjqy2SoH48sSmBnjoNevfgxEg2uwgbaZV
	 IvD6CP8pTPAow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tty: tty_port: restore TTY_IO_ERROR on activation failure
Date: Mon,  5 Oct 2026 17:21:45 -0400
Message-ID: <20261005212016.3390176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100523-caramel-unstopped-5721@gregkh>
References: <2026100523-caramel-unstopped-5721@gregkh>
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
[ sashal: adapted to the existing braced error block containing mutex_unlock() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index cbb56f725bc4a..77e28059ad982 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -689,6 +689,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
 			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				mutex_unlock(&port->mutex);
 				return retval;
 			}
-- 
2.53.0

