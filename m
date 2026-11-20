Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174000;
	b=zQPDjEjXZmZD+tasONdNSNsCOOblR0dKrJAX0UflHjfCurYBvS5xLYXjCoQdze5d/H1q
	 vSs58id4A28MWGP3UDu9PuyL/En103BjyG2O4kRYMV47YeGR2+ZzPkHkSygp3EJcJRyXc
	 SWjLGycgRfdbJNd8dgyMGoYMmE9o0Ba+Yj0cLCx5Ej9na/LpOVsmTQgZ4M3pw+Zh5ajpG
	 9QonFP17SwYRJPGrRIdyyYN3ZLoMiy90g2fXh5sis9H647AKiDJHOeTjAhGTk+biT1S2A
	 7S37M7+d6/0jbwsE8ZjUhalh820DCb8irEoC4ipwG3CuNfc9eOTpU3G9V2FPOIRWIFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174000;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5F2eTzaQioZlffdDvmTAcM2K2yQPTf7znqshC9jLldc=;
	b=ZEZS5DC7zF9NwNN63bvnzM0ZEZQnZpsKfRR5+2PrTWiejHonf3PNWjrCrNhj97YGPC36
	 qd35Lf44MU+z4LRFLNOp9YMdNQAEhV0XC9iwKb/9IiD7PcQf6eGMT/15AI5n9hg471qRJ
	 mON6Ry3Pms6MUmf+HKBGZ52VxSglmF8PIeiqyFyPPKEWYtMjVF79opDmMMB00nsSvaMiH
	 F9lk/03uBJIM2QyceyNW14whccRxVNM4sZDeArKiHQD40R8sGL5rNeQL38PKAZ462Gln7
	 uMNrqA+Bqn5muqn+wOiEPX6vOV6UqwJ3rD9ua5zpr/gYQ9mPHfbk1yy+sqIEbBqMZyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtQhf7vO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BB606A320;
	Fri, 20 Nov 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtQhf7vO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C57E1F000D2;
	Fri, 20 Nov 2026 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174000;
	bh=5F2eTzaQioZlffdDvmTAcM2K2yQPTf7znqshC9jLldc=;
	h=From:To:Cc:Subject:Date;
	b=QtQhf7vOjkzSNFDhXLk+UAS7osGMFB6VF04c2IGXygF6NYRznYMQVMA/nN1HiiubF
	 sa0AqPEh6FCNiq0Wm4itxatY/MUaA08FlJv0QL6fJe+BkaF78elJmX7juUQQJfjoHe
	 /mEYDgtAE8vT10qOPpcPEYE5o90sB+b1jY2Ap/bYV6aLOUGv+7RSiFY0jnD7PqCC4C
	 YOw5KTy4f6U7/hvRN++n0HtmoravHzAtUjZXxs1XJoplnD/6WW5AEy3e5m7UqHvm25
	 Ecl7Gd89E24ZAtEEtlxm/qwIwiVQ1Q9f8PeWtTcX4mA1ZSFGlX8QzJZwlsfW3/S89L
	 8yzX0Kurdyiuw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xUMlK-00000005gG3-0ETW;
	Fri, 20 Nov 2026 12:26:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	"William A. Kennington III" <william@wkennington.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: reset ldisc to N_TTY on reopen after hangup
Date: Fri, 20 Nov 2026 12:24:55 +0100
Message-ID: <20261120112455.1353962-1-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
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

Line disciplines should not call into a TTY driver for a device that has
been hung up as the underlying hardware may have been powered down or
resources may have been freed.

Since commit 638b9648ab51 ("tty: Fix the ldisc hangup race") the line
discipline is however reinitialised on hangup which means that ldiscs
that register class devices on initialisation (e.g. N_SLIP) can call
back into a TTY driver after hangup.

Commit 892d1fa7eaae ("tty: Destroy ldisc instance on hangup") later
moved reinitialisation to open() but that still leaves a small window
where an ldisc could call into the TTY driver before the device has been
opened.

For hotpluggable devices, open() can also race with disconnect,
reinitialise the ldisc and leave a class device registered indefinitely
after the underlying device and its resources are gone.

Fix this by restoring the pre-2004 behaviour of always resetting the
ldisc to N_TTY when a tty is reopened after hangup.

Note that console ldiscs are still reinitialised on hangup but consoles
are special in that they are not shut down on hangup.

Also note the line disciplines currently affected by this require
CAP_NET_ADMIN.

Fixes: 638b9648ab51 ("tty: Fix the ldisc hangup race")
Reported-by: William A. Kennington III <william@wkennington.com>
Link: https://lore.kernel.org/20261118145636.3534234-1-william@wkennington.com
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1a6c8a1bc764..363572f10456 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1323,7 +1323,7 @@ static int tty_reopen(struct tty_struct *tty)
 			return retval;
 
 		if (!tty->ldisc)
-			retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+			retval = tty_ldisc_reinit(tty, N_TTY);
 		tty_ldisc_unlock(tty);
 	}
 
-- 
2.56.1

