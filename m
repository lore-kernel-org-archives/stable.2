Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193748;
	b=QPGCvkDgcGvi3uJiyv8Bew/TkePrnOIB7+0LPnLcKzZoGzB702yvFX/zI82mQD48tzFb
	 ed1NhQL3rO04irbqSXeQx7LOEnNhNPmetL0Y9lu2uBBWk+nBrOLM70emRkVZVkiOYDwbw
	 sqCWFyj81/0eOLd01/HxTEMIge/px1LD6x+e/BlAgZ+8GgW8+35IkBzP3yfQcm45lq3w0
	 veml7z08UkDs0HSklhzT1ttCqbhhJRMan36p9lN/XwgcGcbwXjv5NRP+Ra2Z+C36mbabO
	 Vmj9gF30KjqwLn2pOKGfegT791ZhtRzxo0vydjumonhu5lyzEFddM9Xa50HNNWIdu+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193748;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yhDLlLsOvouwfc6IjVkEz3nLAwJ8aknGVp4Fj47waDc=;
	b=av9yzgrZzLfg1L2aDV/USEWXF7YsVQHvMgyLmYMjdDGldYiSZnGQOgESU+mqOnj1LT/2
	 joTxVBxpMpzMeGhxNVrEXIDqQFYV12zvVzTKDA+CqWCnOpYNAiPT4gSyJZzKoRjTg+8iZ
	 50rwY5VIEQ+xJ7O5FDBt4+Lh1t8nSRaVdtXCLk/MgZeVgk4+AlsvmcnFtYKYhe8/mPurj
	 S6DkBUmU06IRp+cePWLmacDlWdOXxnlzxHu0FQs94kZt77lvrWOJss4LGTEkTz1kvOp9W
	 rhjDlslDYrEmM40eh43YROabU7UJbatKVD2kf7LWv0KM/Kt0J36uo7kmQxnfW3NeN9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=md9hrAVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733E606A31F;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=md9hrAVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6451F01829;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193747;
	bh=yhDLlLsOvouwfc6IjVkEz3nLAwJ8aknGVp4Fj47waDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=md9hrAVIUAKTN/SW6oGFgBPihZGkNvy1xdgx2oySyWWfYUjk7ghKIeL6Fo+8n0DJX
	 x0kRHgX00JAMP64bkmvfmE8Yqw5icZ4j6PE2nyJmN2Xxz/OtzzBf1APoroU0D6V3TO
	 BHtDvF1dFuaVVHCKKFZvRN452BL+DtYniztDcYQBO/Yk4vSkr1JC4Aqel8V5FrMPL2
	 3VOHxxVGckrOTcHhXF0jyTfFI7quFOf14MK9DDxUcrBTH/q+0RAQqZty1PxvMhkXWC
	 5An6Vrn5pcvzJHVFPz9bp7JfHLZii3AQTL88PZj1GJPI8BVeWq6bvu1CBJgUyibojx
	 PODZaoSjn4nNA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xM3bl-000000033X7-2Yvc;
	Wed, 28 Oct 2026 14:22:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] tty: n_hdlc: fix missing write() hangup check
Date: Wed, 28 Oct 2026 14:20:47 +0100
Message-ID: <20261028132049.728457-2-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028132049.728457-1-johan@kernel.org>
References: <20261028132049.728457-1-johan@kernel.org>
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

Add the missing hangup check to the n_hdlc write() wait loop so that
hangups are detected and -EIO is returned as expected.

Note that before commit c96cf923a98d ("tty: Don't block on IO when ldisc
change is pending") a task hanging up the tty would get stuck in
uninterruptible sleep when there are blocked writers, but since then
write() incorrectly returns -EAGAIN instead.

The false-positive stuck hangup issue was flagged by an LLM.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/n_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 895b850a5950..0fbc44968a44 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -529,6 +529,11 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
+		if (tty_hung_up_p(file)) {
+			error = -EIO;
+			break;
+		}
+
 		tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
 		if (tbuf)
 			break;
-- 
2.55.0

