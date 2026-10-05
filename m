Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847A358378
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240390; cv=none; b=oIjRcmudWwDGbQ48QwVVzq8rtZTeMW9LVppWN4EbG9+s4BduMLHWg2Fo5Y3/7l9RlIag53Q15D8VBAYmLtxcL3A91qhFh2vI1th7fHPAuAz9W8xeZVh89IzaD9KYvlMlTuafEGFFJK4/3DnwdWMmwmMkTWtjIvvJ5UALb1ozJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240390; c=relaxed/simple;
	bh=OW/cqAmDcdxPcQpsJbGWxbSsjmsLeWOTHN9GKOPlneA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvNfQ2Ybq8zmlzLznx5qoh7YN5S8ADG40xR7cbNpyxHjcKC2BteH/VPs7BUmNcNnw+s9Zg9ZRZq5lBcqeWTOK7OQ+H2g+TNXGcpLwEA6gKd0xZwl3lL5V1p262bUKOD0rR9DKHRTOVkvcN93xkKHIZpfrFNdP1FoJ9jVUXYuXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWytlX28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWytlX28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01C31F000FF;
	Mon,  5 Oct 2026 22:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240388;
	bh=x58iR7Vx3A0GWzdMHYqVSHeloQaKUFaadBmBoJ3hB+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWytlX28pSF5/Tax75KHr5BiPJ33cnnr2mKrOvAbwsXvOK6TT5HEeeez1RiygJ+fv
	 wHo7/g5n7KROz/qAEk3GvmtP1vNWcWj+7kfkVGbuF0NP3QkLYfgsZCj3ZLzC6TTvtr
	 TvD9U4t272pFsdU6WHP2/vt/eHQaaeHum44DrWX949RmfFbJBmXNMglnyCPSzeymBt
	 VELnJNGjsTzwj3T3yWCL8rU1HD8BjVvkv6cpv3gNtbx3FVO6n0lehPd4/os7pM5qQm
	 Fji/KDC5DHG1GPEAa8RnT6kCgs20x/3NhiW52rm8aH6Ux0e41be5BeSejLz7JDyQhz
	 zCgyXnRloVSKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] serial: fix TIOCMIWAIT race
Date: Mon,  5 Oct 2026 18:46:24 -0400
Message-ID: <20261005224600.3467867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100502-jab-vividly-0ef4@gregkh>
References: <2026100502-jab-vividly-0ef4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 40adffec8c0090533dfaa863ced7901b60bbf1dc ]

The task state must be updated before checking the wakeup condition to
avoid missing a racing modem status update.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org
Cc: stable@kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260910130816.642699-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adjusted context for direct spinlock calls instead of uart_port locking helpers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2704eb8af5880..dafbd24b91484 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1222,12 +1222,12 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&uport->lock);
 		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
 		spin_unlock_irq(&uport->lock);
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 		    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 		    ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
-- 
2.53.0

