Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157980;
	b=JRdX/U1FCH34Oz58EZRpsLPnNqQFU8Y934VdzApM9+lVGxB3yk9f3lS1aHqfzzOe+7s9
	 Gig6T9Iq1l069nYH06OqMQJ7GVwXWC9kixhPMABRJ7Fs56SmRsoqp4oRwP3c1TLQB3cgr
	 LibcJuUTIiltCYTvzZaohAXfa3YNrwd+TarpeyH5HHPsnUdGOiKJpxCZ+4K0N2OB36WVI
	 GhgHMb2GkH5lKPVK8cLWBWSZ7yWWiDG0xJ7CfdnYPd93dj1oh1JZwURhTKeDhCv/NoUcd
	 SKxVpRrhwl72lKR3jGTU7fOuCxVHy5pBBqH+61/ITl9AviAqXYTlFTP64gVeJVAeJ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157980;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eH/ILNneWFjzbYE1V7mJp7q808oLcwhhI5kcVPmM+oM=;
	b=WAgRjsUqeZ9pPKWa6kAlwkJeSZIFXpA+Shn8v+0CJo6cBdYktWj/TYNSmKBh5Q2SLFrx
	 u0e8EpxLtvd0tL+LZLektP7PNBt2Ha6qD265B+E88gGB8B9rXInwlv/XN9HjvGxIy41Jy
	 Y3WyozUHpd+rZ+FrgRQAIAw8x0KSUhjNtGLaCJOHkjGZKG8N05Aa7BbkAD4Njps7H3vbX
	 43Z4Q57t4FMMbGtucrc0cnVOEofppLGSSeXNbdseA54BbJqzudc8815e1RODU6zUtcZ1b
	 B7wdTLWql448VrYsPFwWGqb2+YUTGcysNasCSw+H/vncRsC9nD/r/aSnJSUwf6/E31w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RLjCzr8D;
	arc=none smtp.remote-ip=43.163.128.52
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B4606A327;
	Wed, 28 Oct 2026 03:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 067B4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RLjCzr8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793157970; bh=eH/ILNneWFjzbYE1V7mJp7q808oLcwhhI5kcVPmM+oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLjCzr8DlhJQKa1waPv25jmWowYxa1v2XySFuvU3aeLWrbRmfCkkIB4A/EtZCIUSs
	 cvElLEr/Zoh5QobH44nDB3Rzoz+JxGaelBuCf5T5u8Ae6DW5/2qLb+x5y9hNhIrwLI
	 zFdPN3JlmElxfsFz6NFmBmBn9n2r7vJpHjhFj0sE=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 66D82CB3; Wed, 28 Oct 2026 11:25:45 +0800
X-QQ-mid: xmsmtpt1793157946t43n6p27n
Message-ID: <tencent_9E404EEA5DDD9E37C7F105470FDA49E36708@qq.com>
X-QQ-XMAILINFO: MX1DZ62mjoOUfJQb+msiMQ5Z2fFnWAN67SHnTWQpnw5Uor7Lbd7AREs2rl/96A
	 9bRonn5rvBePJ/H/uhIUWJ8PkbUte2FH17ZU5em9m1rKq7HqFUYolixydOnlroCArBzUvo1e7Z2w
	 5ZXoku5aE6Fo7zPSL27V5WYIuTpCJ76ha7MCCgDBJZMD22gOHXcbFVBmrwL8RC1KJWXr//mFabVU
	 AfE/Mw+g8kVon+cVrXcAXvLcqeq5f/OQ9QjvjPbjsFztzys9jSRExQ2TMamodXP+wINf8hPigXhp
	 Ze1vmo/iKiz4kAvclpVU8DYDVqmOqnr4GN8Iatcp/UPdI3yEO7BqExFPTo7htr2qk4GYLIVsYWQE
	 pN4wUyk01jZ8XkcuRABTWgqHsbDn7lwGh2rlN0Y0AWwNaTcxWmWDagYlK5F4uTx6WvY7BCamk/hw
	 kK8DsszXD3WjOmbk5gMvqzGr8VDM8gGSAXdXnsTyEc4/udBZHdDdRc/9aop4w52qjilMdqPu6GuC
	 rIPmUXeXQCwcdGykfXE+7Vy6kEoQ2znss1JdtQUoGaNaILu4s6vesAiw17OFBYNKltyKu+5ITrdr
	 DFLuNtERjvb01VZnnBoZVM4NAtY7ETtomEiGaTAsuUtGhqELjBF85LL7l2KVPyVmzxfohbVU6U10
	 DtxwXBeZzOsYS6H0uBXp1FkbNOoRlJaPn6JIhiUq9Ht5eVuuSu35AiigY0khv3HiU8AbTirlaEBW
	 OEwCczvMn6Sp8FwcEWtUtJpvx+74eNfXL6LAwO3ABu+axqR1cDXpBiBWX/k3GJlNISovz9WseWyZ
	 dnGI79P/57rPy3cD1abFs4QWV8T1mBBqpIwDMZl9t13ekPVW3UAfeSc0TK4OQVw0WlkqjVR8/C2v
	 nbzPaG9BDXnJGz0YXWc3sSvAugbgRWtXyBvDN4+EjXZjsfClclufiisvuvFT5BGKBAdtOJVy5ury
	 3ppIcNBFRF4TVAyIQHH5A/TD4gfBTyzVdaq4To6jA0pRTO0nY+WuR7nOHhzM/zCcjiHS+W39r47B
	 aBeS/jE07RtexPisAdhoCY1BahMbdQPzQr3aTzRTkbsuLnwRvQ4usa3DGnt9g=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Chengyu Liu <19290937@qq.com>
To: khc@pm.waw.pl,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Chengyu Liu <19290937@qq.com>
Subject: [PATCH net 1/2] hdlc_cisco: shut down the keepalive timer on ->detach
Date: Wed, 28 Oct 2026 11:23:09 +0800
X-OQ-MSGID: <20261028032310.2832307-2-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028032310.2832307-1-19290937@qq.com>
References: <20261028032310.2832307-1-19290937@qq.com>
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

cisco_start() arms st->timer unconditionally and cisco_timer() re-arms
itself on every fire.  The only deletion lives in cisco_stop(), which is
unreachable on the protocol-detach path: detach_hdlc_protocol() calls
only ->detach() (never ->stop()) and then kfree()s hdlc->state.  The
cisco hdlc_proto has no ->detach at all, so unregistering an up cisco
device leaves the keepalive timer armed on top of freed memory; it fires
within one keepalive interval and cisco_timer() writes through the dead
cisco_state (st->lock, st->txseq++, cisco_keepalive_send()).

Add a ->detach callback that shuts the timer down permanently before the
state is freed, mirroring the CVE-2026-63803 ppp fix
(timer_shutdown_sync() in ppp_timer_release()).

Initialize the timer in cisco_ioctl() when the protocol is attached and
drop the timer_setup() from cisco_start(), so the timer is initialized
exactly once at attach time: attach_hdlc_protocol() uses kmalloc() (not
kzalloc), so st->timer is uninitialized garbage until the first
timer_setup() and ->detach() must never run timer_shutdown_sync() on it.

This bug was found by static analysis and confirmed with a KASAN
reproducer: slab-use-after-free write in __run_timer_base() within one
keepalive interval after rmmod of an up cisco HDLC device (allocated by
attach_hdlc_protocol() via cisco_ioctl(), freed by
detach_hdlc_protocol() via unregister_hdlc_device()).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <19290937@qq.com>
---
 drivers/net/wan/hdlc_cisco.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index bfc978b15b..2173d5c6d6 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -274,7 +274,6 @@ static void cisco_start(struct net_device *dev)
 	spin_unlock_irqrestore(&st->lock, flags);
 
 	st->dev = dev;
-	timer_setup(&st->timer, cisco_timer, 0);
 	st->timer.expires = jiffies + HZ; /* First poll after 1 s */
 	add_timer(&st->timer);
 }
@@ -293,9 +292,17 @@ static void cisco_stop(struct net_device *dev)
 	spin_unlock_irqrestore(&st->lock, flags);
 }
 
+static void cisco_detach(struct net_device *dev)
+{
+	struct cisco_state *st = state(dev_to_hdlc(dev));
+
+	timer_shutdown_sync(&st->timer);
+}
+
 static struct hdlc_proto proto = {
 	.start		= cisco_start,
 	.stop		= cisco_stop,
+	.detach		= cisco_detach,
 	.type_trans	= cisco_type_trans,
 	.ioctl		= cisco_ioctl,
 	.netif_rx	= cisco_rx,
@@ -353,6 +360,7 @@ static int cisco_ioctl(struct net_device *dev, struct if_settings *ifs)
 
 		memcpy(&state(hdlc)->settings, &new_settings, size);
 		spin_lock_init(&state(hdlc)->lock);
+		timer_setup(&state(hdlc)->timer, cisco_timer, 0);
 		dev->header_ops = &cisco_header_ops;
 		dev->hard_header_len = sizeof(struct hdlc_header);
 		dev->type = ARPHRD_CISCO;
-- 
2.25.1

