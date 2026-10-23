Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757816;
	b=xKQIm8qyom1kSg50GaUNlGKXzGNCFhoNIcTTk20eX1PriHRfy7sE4ioc6P8SAHPcAYz0
	 LctsnXI7xIste9mT8o79HZJPdoSkJDUE/lrwqcqIrEwMUSzRWubDsXURaWovHbpVR8NQZ
	 VzYNV0z66qppyXoRN5L9fg1MnWk72evgfXofw2cDvuIiY80NBpaLQtGbYnUZMTt7KpDue
	 tRJ+uWseY49hmI/sSXUn0JfOxMbRxlGhAQbSW5XFNd2QbyxyCJapUqh6rGPGeuFO/zwDA
	 l5KWdkAlPRp+LAxvSP5BKp0S/+XknCzl3gQDicNJDECyN1/ad5ZfDceu8YjNovT8u0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757816;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eitBYZdwgfEn4Q+Iq3mIK9U7o899rtaXia/72WAA8LE=;
	b=eU88KoxpWCSFYiB+IGZ3u1C1UU7H64vEh8q2TrNF+XdymoLr4cOt5UJUCdsdBTC90tjF
	 /TgQ7Y8EXlVcCWN+cKPvSfvaKDoC3TVmaCrd2j4+ys7dk57DV9RtMJ92CmB/G2qgEALuR
	 NEC+LifmVGcniA2Lz8W1lDS5OEE729hCpQYKTWY1zxOAxwjceus+Ki+1q8llnKOc5WkpY
	 rTgoA5ToVC7HBlNDV/JYyFLhMM/Pvr86gf8NOFpOkxGRVZ+Qeobul/ryBHBG3BU2VlzFO
	 hkULZibeQjoEHnU50yP1yp6vZMP/7/jeH+fQwol3lOwqdrZhrqxc8n0Q9nngUIlT2QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb9TtRL+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E9606A320;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb9TtRL+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590791F01829;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757815;
	bh=eitBYZdwgfEn4Q+Iq3mIK9U7o899rtaXia/72WAA8LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mb9TtRL+tlje67pPIa3axFcbUMQSXUKGm+4nDR9PZkwLX5vunogfWBsnhh8p8WvoT
	 E34RjB99nzpc22qPwyHb8qggKWeHY72nVTkRjBZDHB3/zryUNvLYYZETYfm2jgL6wu
	 6Suf/qYSHVq00lITTPGi863jdmn1jlr64e0zleSRE7ZRVk69vF7oMLXFacM3Mn2n7E
	 kH1fw+YymZkeAJibTKqor06igvs+Qlh7S/KkdwbQ7KQJitjBU9x9MFPN9ePvr9lbAo
	 HZyMkdB1UvskmuFsjghlesO7fahxwQBOMGmAZUMeayYT+vtU7LvOSjcOGcFYbEW4lV
	 yf6b0wHvjcmag==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xKECb-00000000mZO-0HqL;
	Fri, 23 Oct 2026 14:16:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+763813d65c7e18c1b6d5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 01/12] USB: serial: io_edgeport: fix NULL-deref on early status
Date: Fri, 23 Oct 2026 14:15:19 +0200
Message-ID: <20261023121530.186541-2-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023121530.186541-1-johan@kernel.org>
References: <20261023121530.186541-1-johan@kernel.org>
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

