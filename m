Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD23370D56;
	Tue,  8 Sep 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856850; cv=none; b=qMvr1yd+1PkPMmYABVXyYancg/7brPXfcutHnXxMvjWGd3kQ2uQXnqAXZ1hWFw3+nl1nIdzJc0L5ncij9e3ndqyAR5BhrBp0/fL8Fcn+Yho1v3amzMVLNqLPmL75d4RdDr54AqpJK03RmHgMNe6vFuuwlLciM+k47XZJWZbyGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856850; c=relaxed/simple;
	bh=Vrfr7zzEwJQEzZ6zaoaVGnzBmprSB9I9ol5Uhw6aLiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVRiMeGG/qgRVejLrJPr1nJTtYWeAL0nnHyYc3rwsiTUeAgqJSRAvme8b39fVCjWd0ChcdTxx7cOERSrclGZb6lG7EsE6Po9u6Lny4iWs5HVHk/wzfF3xuHWM6gtNDRailN2ZD6goc/Fv53aTFyYV7xVLa3tL9RIo56QERMqx5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlqqDKr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlqqDKr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CD01F00A3A;
	Tue,  8 Sep 2026 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788856848;
	bh=lfq8Fegv4esMs1vY+nfswJ3ke6lOATunr4YBcpYS5h0=;
	h=From:To:Cc:Subject:Date;
	b=ZlqqDKr4S7WJiCUdcsb9ZAsQNLwkw63A124ROPrQKMGTpRsZDTMnH5nnOj9Ycg8GS
	 wK3BxKThX+QFlzR0qp9zdBdmydTV6HuIwQJIyiMDAWZfUiKa/H8YKW9X4WVKRVgp1z
	 KRwjbi/oX39At6pIP+92QhxiakkiXnORDDbCPH+uMaZ73CRFbij8t/yJoZ20vOD+re
	 8QZ4GJBryTt/4W0JHlRZNTfpwlZsH+ijkOYYzph8WS6H8g2GtKCe+Nb1sJ8vSZlLpV
	 NIQBOqbQZ5X9vUFmTyCLUya4+oSrdD+Wwds6BHxJ6K9tTa3PmfAUosJlzH+CcjCE3F
	 a+I+ND0wcFywQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3rNl-00000000urb-3q1o;
	Tue, 08 Sep 2026 10:40:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] tty: tty_port: restore TTY_IO_ERROR on activation failure
Date: Tue,  8 Sep 2026 10:40:00 +0200
Message-ID: <20260908084000.218528-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to restore the TTY_IO_ERROR flag if activation fails to
prevent I/O attempts on a port that is gone or powered down.

This specifically avoids issues like kernel panic due to unclocked
accesses or NULL-pointer dereferences when accessing powered down or
deregistered ports when a TTY ioctl races with hangup and open.

Note that the flag is set again in tty_port_close() but not restoring it
on activation failure leaves a window where drivers fail to handle the
ioctl-hangup race.

Fixes: a9a37ec33a1b ("tty: tty_port: Move the IO_ERROR clear")
Cc: stable@vger.kernel.org	# 2.6.33
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 54359310e293..ae33987207b6 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -767,8 +767,10 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
-			if (retval)
+			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				return retval;
+			}
 		}
 		tty_port_set_initialized(port, true);
 	}
-- 
2.55.0

