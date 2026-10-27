Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122476;
	b=S2arPtPHQZmnKZO0qTvi2rs+0aKDFE1K/GRRUDDcv3FQT4Q/IVir7CSSSHhNHqmWEjCC
	 XY5ZsvAjntX4R2wZ50L0Tg3QI3CP+mMKtLudd1zqBtNrCUSq+NZm26lVZnLT5vSzgKtJ9
	 w9CfcWsylwrv4mJAwDvzHzyzh+LUj/j6K7mlevdBTyTJm+tM3GSLGBkn8MINESXVzL0X5
	 pV+OOpSOJJcAwO0uOydG8J7rMi+OfY9HGhyDa82YroybpUOgER4Ru8qGAwpdm7ODzVI8l
	 g41rzhtNNBYbhA6xzbzqaUMwIXMGkjzRCwmEuflhJgj8XoFbE+S6t8JRzZaJN2LLifw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122476;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eH/ILNneWFjzbYE1V7mJp7q808oLcwhhI5kcVPmM+oM=;
	b=q4wJM2wm38eKwXw08hM6P6BN2ryT8enGPtfs3zoIOqfWvd4TpXKS+uWGSL7iCvp9UHGB
	 37k8JP67d9BDA/dOlqhboOAHXvZX8PAfdcs8UutqEDN05zaBb65mFX6dWiQtdxhlK+Bg6
	 7cBNFk8LyOWtIMixIX4C5bajrD20lcB55YDGtoKpO0xCBNkXphIJAPCjOQjHFFup8kuly
	 AQXeXMwCT2IBZrPAd/HPVKEIFg+V5OszXh23327WMKndcVI3kldBscsNgAjV7gJLn+Myd
	 OJDhVH5rxYvw0CEC+YxzVGP3nPoUfaLm5avk0Oq6zkw2g1oEMlHTBG3a8xalo8KfHng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Eu33nbjP;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AC606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A18AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Eu33nbjP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793122472; bh=eH/ILNneWFjzbYE1V7mJp7q808oLcwhhI5kcVPmM+oM=;
	h=From:To:Cc:Subject:Date;
	b=Eu33nbjP8BlNPy7CP9hFP3ULritJ3yCb/wkeQVy20x1GvgxEimPosrHDd+nZCP72/
	 E2GpmxyRucNzwLs4dOM1S2UnpXhW1gpTk8cfcMDTU6AEOJR3a9UXQqUxyRA6/lQQB7
	 8OnATxo+C0+KhstPpaMKzTrAWL1DrvHq3AlV/iDU=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 89F2B6AF; Wed, 28 Oct 2026 01:34:31 +0800
X-QQ-mid: xmsmtpt1793122471tw2vfcbfg
Message-ID: <tencent_6337CA8D55BCC5519576F3F816D0B83A5906@qq.com>
X-QQ-XMAILINFO: MRBm8gEMwvbCd6LZRPL4OrMrQ6vSXny4gxaQZ/D50zhBiZMBpA2pciCuBT4IeX
	 zbkLX18rGEnJYIo9950Uc0LMoSYud5hECca6oTe1TDDzPL0IScwVNbg7jPhN7Bx5ji7sbuRTK4+z
	 6u+qypOptCzdUV+XTi8FQvfIckZZaqUDbwrImo6sQbgat0/RNSKW/pKXqWLpZwuo8Z/ukAtx9e6a
	 63zbVhVHgisasYDi1v6EFpSdZHTuMdP7fLDbds8K5KAIwrAzxmfMbnfNZ/G7BLRfIBQPnSNljsIT
	 pZl2NK4RK6+HajoGpuEQ3/ZyX8+kUxOb1FSZzyWEC7beYbS8sp4Hil7DOOKMEkf2lb+p7QfCrmuQ
	 v4Tc+OxoGUtHV381hLbFiW25L4kwfuO/1eLyPJKd+VNTX5UaqMjkNXZAZGPfFhWX5vFC8WIEXTkS
	 R/GE3wS3eVoelkzXt5PqA5GKHreHFVFTpYETsD0PssDa2DIopXK65BnBhvCjDBq9pUgTAZ9RVUK9
	 Mc77X5mL5i/eKXapIPaL6hThR6U+3ksqp8QKwdiE4/oJMyzDrJNXi3dgj6/Q9N7dTu0bd2O0Qfwf
	 jC6yHGqFKEIqJKi9B4R2ZDqTj2MQ/1Kcglvr6NXL8aDpuUYYMiWpJBT5GMotGyXlOP4/L81Tgurr
	 18VLwQAjnMnoBtTCc7QBScEw1sXvveJzJ78QbFVOHxYscsFPQgWtvF0TRxeFG5zj9QX9zZJsrig8
	 QN2KyrOol58SNMDqCq+wIou4P+3AglET4uq4O2bX0ONr0+XG+dX9klURD9BCIAlpCtI/MlTrwSBi
	 GNq1CfSKP9QckBFewFL7eVSsKpBL9yugj3kWWU+4igQfrrEQE2pWwsQTjlK6hcnjhoTvgwbW8Kwq
	 dqo3Q/NvvvSjU9GKN469eZVismJwPPS/ssZTCBLhipAshMTZBYMvtcf8LfbVunYek8Ec4ZdmPvAT
	 15F3bJ6JqbOGmb+OcOMfuEScC5Q7NGtWyPZLcNhDnu+CLSzDTyi+FP9jQYAXFTsloe644/3XCUxj
	 1GlYKApTEQ0cen82+oyWNyUluXAdgpQOtI62VTtnIKoyX4/GP9
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Chengyu Liu <19290937@qq.com>
To: 19290937@qq.com
Cc: stable@vger.kernel.org
Subject: [PATCH net 1/2] hdlc_cisco: shut down the keepalive timer on ->detach
Date: Wed, 28 Oct 2026 01:34:07 +0800
X-OQ-MSGID: <20261027173407.2742972-1-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
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

