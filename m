Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478028;
	b=QmMwPo5doP2Nl21ZYTVaEGXh9/+o+TWyBxEIPDwpNJyMC7w1F20cYS10jG2AShBoVjIx
	 ypOzQ/pk8WF+Ey23hPV38YwBMUhLCF4QlC7q2RBfqIt25BcJrWtkaT2lRDIf66MBVVlb0
	 UELpWlEu9xqZtCrAEpHJVsvO4lUiidRIPRiMzFkiRPexG9JUgy3efyONt83KZPtUqVk/Z
	 gwrOi9u9x2msVtXUeBlwGiEl6tyLjEHUlFoAXt3Q5+NuFjDgbyNxi3hJD9hDIVcLTZtTP
	 SB08zCaTCP75hyvbV8DdgToYpoRuOPAkWHWPn77tsZJ17woGKVf6lf5+Q3v+Qm/eVtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478028;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YrrwumO/5raUBSV5ArMQZNK6oNAfyIqZEDeYPuOGJbc=;
	b=bevWySO9pZzdEpjpAAKIGeqL8EIvbAkpyvhal0ymbILdwAK6JKIE+gFdz71AClVurczR
	 U3TLlHNaONi5mEcNUFlYoRnNGlF2CU/9kABofoStNeM/PXgJOUCTcKmEuO/0AfbgYlqFT
	 vKdAsdSeQT+V9bXFBUgZTF29jAvtRL2HPpmMQ1mp53Qm6K+qs5sR/21Ruc0D5oJXPT0Tu
	 CriccoY8K92zzxXtwV/NcQPCXjd5JT+G6M3R6qulHpfNgCkcmPwg4hG3+0I9ZJoe2PE4z
	 3/gsgWvDLxxtmQ5doa130wdOSk6n4OKV3aZj4Jk9c/VW4tkfclXDpbAMSSe8NPFul9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooT0GOf7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0C606A332;
	Thu, 12 Nov 2026 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooT0GOf7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66081F00A06;
	Thu, 12 Nov 2026 10:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478027;
	bh=YrrwumO/5raUBSV5ArMQZNK6oNAfyIqZEDeYPuOGJbc=;
	h=From:To:Cc:Subject:Date;
	b=ooT0GOf7phxibuDjkz4U6fvVoFcnMn6rIZk3VMvKLd5HbMyL3KR7bmGG7bSsBIg5D
	 TaXfXR1RuQF8ckiWuKb7uK31R6MRdHSkjYu07UUNypJLyKAA2nwIVWumjoyI9quS/9
	 0029jFclb3+o1XeVyPUFR9jhK/RlnHS8YKDfu7gs6tr6YQchCmORNMOFUIR5hV2eUg
	 wQb8eURA+3y7lDZ9ujYah5UJkyg47/Ta8GUkU4b6kdbPNxtCnlMijYJFjsF+Yii0AL
	 3MYngPf/PfOGGdYr1uJI6C56VgqdydoL/6JLhQYCO65lMBkjvyZcBGJFk7T5mVECtW
	 RpFnphEdD8lyQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRRhx-00000001Sep-2PNC;
	Thu, 12 Nov 2026 11:07:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] serial core: fix use-after-free after driver module unload
Date: Thu, 12 Nov 2026 11:05:41 +0100
Message-ID: <20261112100541.348390-1-johan@kernel.org>
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

Deregistering a uart driver frees the driver uart state including the
tty ports themselves.

Take a reference to the uart driver module at install() so that the
uart state and resources like the tty driver name do not go away while a
tty is still open.

This specifically avoids use-after-free when accessing the tty port and
crashes when accessing the tty driver name (e.g. in the tty printk
macros) when a tty is closed after its driver module has been unloaded.

It also makes sure that the uart state is still valid when waking up any
waiters after releasing the final uart port reference in
uart_port_deref().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---

I hit this when investigating a deregistration race that can lead to a
deadlock:

	https://lore.kernel.org/lkml/avSAyV6QE0Id3rAk@hovoldconsulting.com/

Johan


 drivers/tty/serial/serial_core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2e53d194ecfe..289f767cc068 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1930,10 +1930,25 @@ static int uart_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct uart_driver *drv = driver->driver_state;
 	struct uart_state *state = drv->state + tty->index;
+	int ret;
+
+	if (!try_module_get(drv->owner))
+		return -ENODEV;
 
 	tty->driver_data = state;
 
-	return tty_standard_install(driver, tty);
+	ret = tty_standard_install(driver, tty);
+	if (ret)
+		module_put(drv->owner);
+
+	return ret;
+}
+
+static void uart_cleanup(struct tty_struct *tty)
+{
+	struct uart_driver *drv = tty->driver->driver_state;
+
+	module_put(drv->owner);
 }
 
 /*
@@ -2733,6 +2748,7 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 
 static const struct tty_operations uart_ops = {
 	.install	= uart_install,
+	.cleanup	= uart_cleanup,
 	.open		= uart_open,
 	.close		= uart_close,
 	.write		= uart_write,
-- 
2.56.1

