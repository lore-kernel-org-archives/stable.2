Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFD2E282B
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499044; cv=none; b=CuObgU2h0ofWWuhh2QN4cg6PHy8mL6yMEgjUnVQouiriLNBwv2Wd42JkJdx0UDMqkiKgrAt7ZLQiOjnTI3sfTUXWy2pgO6YQGZ074Z//KurINuSgQNe0FhGOMprXCB3gYzEw6FSALtG3wc1NiDwy+3l/nfjt1BhwECfllMIWqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499044; c=relaxed/simple;
	bh=dUEaJRxUr1v76K2SCkn5RSwlmWHDmcrArC8H6gE7+XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoHetSnSEZ0DNOGBIq4ZlgXbhC+yRJ+FWkGdUVI+ESVemiaztbRzP3SOuKBPL8XOu/t5/W9QxQoicRR83i6DAdR44QCIFSCNmNUrRsojD6xWGZ5l/VdbC8eHQdYdw4ae10ITadRxHWTlhBSWQgvcflGS1QI+Wyjezk3MThPebn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAG0/pVo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAG0/pVo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49557167508so9526325e9.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499041; x=1785103841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2WnfrXCKBHilw+RfhMqIc4Ta8+VRnPx7kVZTMW2Ow4=;
        b=rAG0/pVoxVjxY2l/TQcjuXeD8jEmCWPDakt8X1yRht+XSuWEJ2Luaysq4JCRXCMDM9
         MFmDqXTjpCXTfhRBXTzZ5KffvqnLbhgDB0udBGFahQ8J7+21tgc1KjMRi6qqMmV/XRik
         zcgbzI33V9rrpuBpZRUc5q+5H0aTmxnJRB6W8KQRN6Rb9ZWIa7ZqbBfnmkcd3OPm4hsQ
         Se391YiFhE8LUun5QrArMinBRmY9FwhxtuNquHhnIT+mAv3cwZXxgc+3XwXJF2jdoaj3
         3heWFCrI9zBzW0HxrBHA20rxbLna83AKaIS53OcAi++plna9CHpEH6Tm1GOXJ5sUXFrJ
         BsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499041; x=1785103841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2WnfrXCKBHilw+RfhMqIc4Ta8+VRnPx7kVZTMW2Ow4=;
        b=qMVB7NrNNdcVKMkAyBuFGccnL7a2UsV2J1Hkj0OkrIj0OqNPtawCW/oUmeNexaFP6f
         KxZgePfRmLY4Fq4XJevW6iZ9rSirI+Iobkp7k21VrCkI7cDKkYjfdQJYyDAHr8DMmuUF
         1l3EyBxbQTOZlh9U4/uwUv2bCpYU4Qx4GoFPpBZXfoODZEFCFBi44PsDvcEunHWF9jKr
         e570Du4KXMu+T9hhc5YgWbNZVDxQAOWgpFSa6tMd3o7tsBRdNGS2xJQjCqiH2KtM+RyN
         Axq01saNz18VrpZyjykyfJFTYY1/0J8yc2QnxsKUccX2dtp9dbVZSLpTWsfaIatZ/TgD
         XrCQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2ec4uDmgw3l+CaWroVPADiD+HswlYGgxDzZXVdz5taRdJ6HwaBymbbCcZUsFtdqxsAURFceA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+CB2x1oHjCQSHYjohuw+uUujLUeIFjhNlDAn+d5wUzfHpvIfU
	tCNo//jdrV/ANoLU+OKpmi/3TWPAg3peNyxGuEHLzBwn5qtfiM07erSM
X-Gm-Gg: AfdE7clV4iMqtuAgAgbjWld5BJUb7mvoxu/l2nMn0Crtxx5LtbIMBJ8dk+8h9Txwzf6
	jQk6EE6axcNgJoI1RvHjNahlsfh4gTcRflq2PqYs5saVxsMuj5jfqxgvbEYY9OCY1SfwYBzYX1d
	RCwuW7wN98coJqZAwUg8UOIs7Wu4bLXlbtk5XfLG/ni7GALRpHdjNfeEWnK7g5zD0xh8EIAEpIm
	r2kMPXgwuyiPEb4xXEenDHAfP+njgFqwpX0sk4SUJyKTBc+biUT05QEpvFPItjnF5jwbwj4L+rY
	1900NnkysUWsVv5uXyfY+3AYtrWWQrORoUP++kS70fswbHKMSS+tToJjtDqmJOsip7Gk+cBGB7u
	b2G8vhY+VI4PrTfh+fwXlWNQHUmcKOKe4TuW7Ob42jWJ+iDBIRtqv0uU743RFFycuUf+7Kh8mQM
	dAiBd10HRkcbKYfnLWvhmNW22UFZ9yPWu779USp9vCmibBkmPjcl45N37R8iqkc9ShOmOU4Uhk6
	Gu64QYeTqstkbEouT1q0yNGSQpoNMgayckq0N5yJ8bZgFDUa6myVwqoJKJh8y72lTiwYoiK/has
	m8U1K3zTDm0y8cxogU1V/tI4
X-Received: by 2002:a05:600c:e558:20b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-4955cda5441mr19986495e9.16.1784499040980;
        Sun, 19 Jul 2026 15:10:40 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] serial: core: clear freed pointers on uart_register_driver() failure
Date: Mon, 20 Jul 2026 00:10:12 +0200
Message-Id: <20260719221014.44354-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719221014.44354-1-kmehltretter@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_register_driver() leaves freed pointers behind on failure. If
tty_alloc_driver() fails, it frees drv->state without clearing it. If
tty_register_driver() fails, it also drops the tty driver reference
without clearing drv->tty_driver.

Several drivers register the uart_driver lazily and use drv->state as
an "already registered" sentinel. After a failed registration, the
next probe sees the stale pointer, skips re-registration and calls
uart_add_one_port() with freed state.

The resulting unwind can call uart_unregister_driver() with a NULL or
dangling drv->tty_driver and oops in tty_unregister_driver():

  Unhandled fault: page domain fault (0x01b) at 0x00000018
  PC is at tty_unregister_driver+0x10/0x68
  LR is at uart_unregister_driver+0x1c/0x60

Reproduced with failslab fail-nth injection on qemu's raspi1ap board:
fail the tty_alloc_driver() allocation during a sysfs bind of the
PL011 port, then bind again in the same boot.

Clear drv->state after freeing the state array and clear
drv->tty_driver after dropping the tty driver reference, as
uart_unregister_driver() already does.

The tty_register_driver() failure case predates Git history. The
tty_alloc_driver() failure case was introduced by commit 9e845abfc8a8
("serial: fix NULL pointer dereference"), which made that error path
return cleanly instead of crashing in put_tty_driver(NULL).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 9e845abfc8a8 ("serial: fix NULL pointer dereference")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 887b1dd80ad2..ba9145c5a38a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2777,8 +2777,10 @@ int uart_register_driver(struct uart_driver *drv)
 	for (i = 0; i < drv->nr; i++)
 		tty_port_destroy(&drv->state[i].port);
 	tty_driver_kref_put(normal);
+	drv->tty_driver = NULL;
 out_kfree:
 	kfree(drv->state);
+	drv->state = NULL;
 out:
 	return retval;
 }
-- 
2.53.0
