Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3B2FDC20
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231428; cv=none; b=g/szDM2AM6LwF2bXi1w7DBXwixS5QCkIhOdLOk4sxIuJhrnjiyePsuXXXmAwHwzmf37Omsok7dKOqV/OjmRXuImSTRbDXxgW3zzImwPtqwvQeydx1V1FMyE3qdbiEUivKuABzsJgHvzbmn1OGnZ96Xcd8B1SQ4HbuJ24GBEVkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231428; c=relaxed/simple;
	bh=zXvLgT337rvdyhJV23oSLkq2vxVPgXn1+uFIz5NiOz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3B5C5Vc3dBShHEZ0m6LEf5io1pJ7UjN0O6Fim2C7JysR2HA/PlVeiZRaG33sVSrvC2NSVhEHnXBXGvlFNcZabmjz1mK8upYShyujl50mW50QwuU+ueZiSms8PBkqlsQcu72Xs2oGwCYHBcHSsYQ93SNck0+lmYnMvffRsGW1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey93kykc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey93kykc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02BF1F00893;
	Mon,  5 Oct 2026 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231427;
	bh=u4lcUK/tKyWTX/8uqfvu6meoPFJi1m1qYEjbS5qzWds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ey93kykcCym3GLhNR8yT/Tl9R2QVsoEZH2eV0W8Zu2ZlPhYXSw6A4QwlaPzp5KF3f
	 T4TaavhsCVamJ8K5HygzBYwBWtDgZQdzrZFPJq6fbY7QrNPQApE8VOPjI/t8yQ96MH
	 ZEUYIXolelRJGgDqaiBOBzmrDNU6tDEX+0gPBMeYc4MSf/0Py2R+gBAtVzyoyegOvn
	 Y1vlt+Gi71DH6TfRlGBAjea5nloaDqmGeppZkrFtWV4Kk+xtzeyYgtWb16hJjiZcVz
	 /EIM76HYuPzIPfap77ozuK0+vMetGOiuf7b7P0d0nVf3z6+hX323RfDaEaM2ia7FSn
	 /zfc7h/sMtpMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tty: tty_port: restore TTY_IO_ERROR on activation failure
Date: Mon,  5 Oct 2026 16:17:03 -0400
Message-ID: <20261005201531.3157671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100521-halogen-alphabet-2d56@gregkh>
References: <2026100521-halogen-alphabet-2d56@gregkh>
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
[ sashal: Adapted to existing explicit mutex unlocking instead of automatic cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 21430e64b4128..7ee96882e0e48 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -781,6 +781,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 			int retval = port->ops->activate(port, tty);
 
 			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				mutex_unlock(&port->mutex);
 				return retval;
 			}
-- 
2.53.0

