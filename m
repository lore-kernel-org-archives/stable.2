Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047709;
	b=Uh6u/gqLFLWMe3Y4YdAQBjRYEEZ+MCEeMRhajgRQxz/6gOy3fPTx7OEP7/Hg8p1sz1cZ
	 y4hM5XsN4IqrWEj/y1aVIdiv5C7Aa7BkSenapo3bppf+gL8DzhwfAofDUWDQYktoBLDoV
	 Mb23CBxMO4sDP7O8w1MjNBFyjGluNyc44CetU2S8EZx9HQMeDf56UbZTXyF87LjUN2hTM
	 AKXUtsV7yxx4jqwQCEUiSq8ZFRBeSAd6SHYnvgodmRxwt3bm+g2KuZCWrFu2dIZWgiJi2
	 R7yfJJwkdMkglXcMm2HzHepb9d4xqKMsSBRQuK0zoAQR2gerPOrRCc5h0x6+1Lj75fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047709;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jy2EyR6WYNLvbaHXsrfld9l9x7yllvHp7OW08EaPRg4=;
	b=A6nTylgL3Te1ElrkKietnN3sID3VPHKyFubvrPo7HLu7h4EwLI3vRWk9SW75ASr2hNMH
	 YToPavhh1Hr10/e1Hbq5XZy7YbbbmPUhHQ8QlplYocNLCvgQnLeJMskBmINv6DhhTd8QI
	 krQIGWkv2qYiKHxplnR3YBri3jpEaBm1q3XYh53v3pcmsUAOHaWgqXybI3UPaNpIidxFr
	 tmM1PulNsS9b2PpO09UsxQd1FhIC3t1XG6C/+Xf7JjHDt/IioyQxAJxSesaG9lbQ02zGR
	 PIr2J+nrZZDStKYtWw0QMx0yHKNKB7VYc7rO0IgHzkclOtP1BHsDVIRfmUyuggTZAig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gbl5Li/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbl5Li/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B961F0089F;
	Sat,  7 Nov 2026 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047708;
	bh=Jy2EyR6WYNLvbaHXsrfld9l9x7yllvHp7OW08EaPRg4=;
	h=From:To:Cc:Subject:Date;
	b=gbl5Li/DbLrSQbFmlGnFfiSpdLyh/Ug42xSMZDaWx2Kul7cDzVW6+YIt3kjLgKsm2
	 u5GDc5bTf8hpjm8JwwaXvWw2ZMlunmNODvdmdC4xBaIlEnJgv11FRUs/RwaU89vqOb
	 ijnIAJ9VA3x6HIm6ng2+HjbEl3IiFmwxGOgr81BmXHrcbr7fR2gjD+23nB0/WisqfF
	 wkKsZYrJ83pbGAgVybZ8hYoQ1Y9d2gdajUq8xlrsNdkgBELLD2cPABtTFzPODQ1BtV
	 ecYfoCpsISjdJd1I0JyzPcOOXOJEvDAJLTM/PQFzrd3oNVuCdxTjd/Hai+ALp5JZj5
	 wAH8kElzG/bYQ==
From: Sasha Levin <sashal@kernel.org>
To: jirislaby@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: 8250_omap: set priv->line before enabling the IRQ" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:06 -0500
Message-ID: <20261107053506-failed-6.6-8276a44f0a0b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8276a44f0a0b68c07b2331cc0058036ac4c4190d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053506-failed-6.6-8276a44f0a0b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8276a44f0a0b68c07b2331cc0058036ac4c4190d Mon Sep 17 00:00:00 2001
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Date: Tue, 13 Oct 2026 08:48:50 +0200
Subject: [PATCH] serial: 8250_omap: set priv->line before enabling the IRQ

omap8250_irq() is requested in omap8250_probe() with IRQ_NOAUTOEN and
enabled only in omap_8250_startup(). The handler obtains the port by
serial8250_get_port(priv->line), but probe stores priv->line only after
serial8250_register_8250_port() returns.

The port becomes visible to userspace already inside
serial8250_register_8250_port() (uart_add_one_port()). So it can be
opened -- and the IRQ enabled -- before probe stores the line. An
interrupt in that window makes the handler call
serial8250_get_port(-ENODEV) and dereference a pointer outside of
serial8250_ports[].

Store the line in omap_8250_startup() before enable_irq(), so the
handler never runs with an unset line. Keep the assignment in probe
too, as remove and the system PM callbacks rely on it even when the
port was never opened.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/3b3a642f7df2285f49a7bbbe5d1c23fa442c7d94.1791873876.git.jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 3a1473bf54d0f..137175aa4183a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -711,6 +711,9 @@ static int omap_8250_startup(struct uart_port *port)
 	struct uart_8250_dma *dma = &priv->omap8250_dma;
 	int ret;
 
+	/* ISR and runtime PM need the line; probe sets it only after registration */
+	priv->line = port->line;
+
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
 #endif
-- 
2.53.0




