Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592152;
	b=k9Oa6mjOT+C2rZcGx4glfnLf3zp3pC8CwAXbLuMw+GiIMGqbhZymWtWGsoSyJ8ZqOjvg
	 70+8RLKjkWRRH983nD6HIWERdWqax/0BmAk+gcn23OJBJOHWxPn2BvxuWlpq0AgA3nGla
	 FV6LOaFQsz5YWJxcXp9SH8IQHB33zmWM30RJaG9SVCMiLbbf2Ag3qrys6yHedudPUwOm4
	 7pB7OUz5At+QLbmdYAhWxoJouA4lEUxVytWUixcnB0YRG/ffDq1rDtqDASCAEOUZfoHVd
	 lRelYtYSSeOrSKoo5kuf/mAwKngmS1K6h/nnEMo6+vrvBdVNGmRYJF09bVIXGK5Sgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592152;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eitBYZdwgfEn4Q+Iq3mIK9U7o899rtaXia/72WAA8LE=;
	b=sanxKlht0pF2DnDK4H39vC0wuOd/gVH8ldkYYvY7HMRbiMN56NYwIOjgp77llOuUWjlo
	 FXECuRctYJqQWldlWhy7CJR9t8aEwQGrM9i3llS1mfMZLSepz76FIBBmHRJgSurJK6G2L
	 qD2oJ2evKO8WKFOfslk43NkTbBIjyMdROX5PvhPxk89MIkSlfY0XdtW6WMN8dz9Pm8ajV
	 1rWVG2AoDwCUMffR4Vt/3yc62GCJirbbcQkMME87m6NvzfaiwvY9HEDZuSLoeUniIoSDh
	 FI2V9W16HbE2D/GeIypO9WAitkbErAdZhfOGjRq2kbouzIRNdVbx/u+UALHs8AVPsHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OGLuu/IF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49772606A32F;
	Wed, 21 Oct 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGLuu/IF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ED31F00ADB;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592150;
	bh=eitBYZdwgfEn4Q+Iq3mIK9U7o899rtaXia/72WAA8LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGLuu/IFXUH/7LvOKld8kQUUVqRDa6P94q4ahO5WBueVVpkUKIrmkeE3lahLm6QGH
	 ULoTZPYFtPQbSMuO/OFbk73XVCZBA+92D8gYtsQYoEhDU+10lFbOgQg2gUicX0/ClJ
	 dVOxuXkpH1hZLGL+rVxciZyhPo3xxLP2LEKeoRNl527SMXxLLoV52AoOajcMk6xUMA
	 fDBddX27mA/D+LmekYH4E18yNGxpJlcJJsAWtpL9bj9b2jiTe6x2PM5Xgcz9rpQp5Z
	 F5vp/SmN5EUJ5g77Pk7N1I4vRL193CMdGuxSOq7idUbwMxhNSA9Dc+1RiyGSyNQEJl
	 4JdRQWrtSFmlw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xJX6Z-00000009kq9-2Hrp;
	Wed, 21 Oct 2026 16:15:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+763813d65c7e18c1b6d5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH 01/11] USB: serial: io_edgeport: fix NULL-deref on early status
Date: Wed, 21 Oct 2026 16:11:44 +0200
Message-ID: <20261021141154.2324793-2-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021141154.2324793-1-johan@kernel.org>
References: <20261021141154.2324793-1-johan@kernel.org>
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

The driver submits the interrupt-in URB during probe or on first port
open, which on completion may submit the bulk-in URB before all ports
have been opened and their waitqueues have been initialised.

If a (malicious) device sends a status message for a port that has not
yet been opened this may lead to a NULL-pointer dereference in the
bulk-in completion handler when attempting to wakeup blocked tasks.

Move waitqueue initialisation from open() to port_probe() to address
this.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+763813d65c7e18c1b6d5@syzkaller.appspotmail.com
Link: https://lore.kernel.org/6a8818d8.ae6ddae5.3da009.0031.GAE@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index eaa8f00716c8..cdf41e86ba44 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -877,11 +877,6 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 		}
 	}
 
-	/* initialize our wait queues */
-	init_waitqueue_head(&edge_port->wait_open);
-	init_waitqueue_head(&edge_port->wait_chase);
-	init_waitqueue_head(&edge_port->wait_command);
-
 	/* initialize our port settings */
 	edge_port->txCredits = 0;	/* Can't send any data yet */
 	/* Must always set this bit to enable ints! */
@@ -2965,6 +2960,11 @@ static int edge_port_probe(struct usb_serial_port *port)
 		return -ENOMEM;
 
 	spin_lock_init(&edge_port->ep_lock);
+
+	init_waitqueue_head(&edge_port->wait_open);
+	init_waitqueue_head(&edge_port->wait_chase);
+	init_waitqueue_head(&edge_port->wait_command);
+
 	edge_port->port = port;
 
 	usb_set_serial_port_data(port, edge_port);
-- 
2.55.0

