Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187012512C8
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649021; cv=none; b=fnnPsW2GDnYVeU78hP+9FQvl2YCNnxSMTcy/MvOjM2L6prA2f4xqKOpkBZ3LYHqaaYZKIo4xmlmEO/otHNcefDNm9sPcJ8dCToHmIPEouH7LBt1uPQBgXw/wF1o7Qx4D027MtVX4L5S1Oaew51iEzJQV1t1JvReO2eGUauhoJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649021; c=relaxed/simple;
	bh=uNsJEYvIDc0VCDALY6YDZxBHqMCSaqi2JKaNzQgW3y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGE3MqlXxxEvhiuJOpdgHCxHEO0WAMd50dSGRtAnhPW8gZa2TPZui2jeM9eku6nwS2znSbC41XX8dd8s20bWPIz6WmDJOSwiCs7970qxWLqyOLbj0h12FAXf2tDynjf9Bcunti8ktD/0V7WpEm5XQXOstzRSdMU1yaZPTHnp+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCZhGqGM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCZhGqGM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a668cacdadso3448198a12.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788649018; x=1789253818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdHRMjIh4Da/TW9+xhlHquWaor975k5o4/mzNz3UlTY=;
        b=PCZhGqGM73gfA+K9eiTPSztypijTq+vbvHivn6rtU+gOedAjbFwSKHH222M22J3863
         SZ06lplJoFgD6L4t6ZkRR2w2qXNJEpurZSxSfz6ZhRvIz3pzFYnN9XJ+yTpaHpfwdXrS
         KZOzSzL43Hjl87L8wQoZH8NfbvJ8UQPPjO9Xj9W8FzbFgdxEXd30knxjvmkn5TCjcdYY
         IJ7x9Y9B1E6RQgb5AYFr4tcvTeVeu2fgZt2NEGsHDgy5olpLh3PVIik/SY4+dxz9jbHs
         f/GpCNh2sQx5Zfx5yr9Ieksk2g9rJ2R88oqlljRu6grDH1Knteghl17SR9b45tJk+Puk
         6NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788649018; x=1789253818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdHRMjIh4Da/TW9+xhlHquWaor975k5o4/mzNz3UlTY=;
        b=Tjjub13D/1K47jO6KTPV58jeTbxFHdPhw2WVR5Kw9jA4reqC/wlONP4NliBgjurUdX
         ovaKMg82bH/K6uczp3z1AoWTGDFWTgOcdFGd6zKqku3Vi5PTfV5bs/tKt0zN1jC30sxG
         XoTc1f2tTjr2IqLxr/AISlQB3btijFvh5PkcpU82kD8569LFDEHPIZOBuODU3yyg9R6L
         qq9ErsXFSp9iovOZnDKUaw5Ux/iOfT36hDfvpihade41RnxY5uJQaJsq1K2+E9mkO+kv
         xtWcGFFHGXvAf2R3MAl9o8ICrb5YUyH9lQp/Le/ZcxfQRz+3pa/9hxCuPjnn1C+Aya62
         YEPA==
X-Forwarded-Encrypted: i=1; AKwUvBzQSJqn66S9+JJOiyZC9bXLTAtmu0xyucefmtEh3SpgjOnPcs3KOrJOPddXvFSL10oe3v7vWyk=@vger.kernel.org
X-Gm-Message-State: AFuF++lfPMo4yVlExIic7zjetOxF5Vmd1NMFUXVA/M2L9rOQN4HF+VFY
	oavXTwm/U/vm64p/LYFAWWbd8XpLudRiYP7ECYWmThIWG/t/sT4SrdmA
X-Gm-Gg: AYBFou2knPbu2eSrtNX9fbAuNzsKPgvtyK5B5Sr5ny9bKD3nlDnvDq3NwC25ZLfv3zo
	4IOOlwAIQxy0ykBGw+6ul5eXCkUcrKbHqSDc03U+8/IhN1vFpTnIByeyhg4TrHXCVw2ngSS83hy
	shcFqC5yrDdk0mYoQfDiLVN1yzmaW9VXJ110TWWVBhS2p8lmH2MPcFafwt+zVnNKOd/YJEmeHex
	kQk3iLsBQl+TcRdd3SnJZ5f6XEaeixdF1E9i95Rn+2esoY9pnT2klRqlkOGTfvYIwPrCTLk3Ay/
	PPHh0UD5fE9YVNNwi3dP73mGqnDOYD2CKMCHi6y6GSywMf7G4wsryNEcJ+APU7ECdztVlCPXqDq
	2v+5HqoeycnHsa0deiBfT0uAWOlfhImPfihRtmKyE3bEfvOGOUD+y8puc0CjAQ+1J90+uQMNSGo
	UIOIo/RwnKDyuqp5DgjxSNHNuXfc1L0EUKY+RY64jS0cmX5rX2s+NO2WH52UGdXHfdta38oqoR2
	FA5SvSlHk5s82aYkqP7AZKpOBb9RvE=
X-Received: by 2002:a05:6402:5508:b0:6a7:ea54:38d with SMTP id 4fb4d7f45d1cf-6a7ea54210cmr3612677a12.30.1788649018127;
        Sat, 05 Sep 2026 15:56:58 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3d88sm2713779a12.15.2026.09.05.15.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:56:57 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] net: tulip: use mod_timer() in t21142_lnk_change()
Date: Sun,  6 Sep 2026 00:53:34 +0200
Message-ID: <20260905225454.439466-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t21142_lnk_change() is called from tulip_interrupt(), i.e. in hardirq
context. On a link-fail or NWay renegotiation event it calls
timer_delete_sync(&tp->timer) before rescheduling the timer, which is
exactly what

  WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));

in __timer_delete_sync() exists to catch, since tp->timer is not
TIMER_IRQSAFE:

  WARNING: kernel/time/timer.c:1611 at __timer_delete_sync+0x13c/0x150
  ...
  [<...>] t21142_lnk_change+...
  [<...>] tulip_interrupt+...

This isn't teardown, it's just rescheduling the media timer, which is
exactly what mod_timer() is for. mod_timer(timer, expires) is
documented as equivalent to timer_delete(); timer->expires = expires;
add_timer(), and as the only safe way to change the timeout when a
timer has multiple unserialized concurrent users. That is the case
here: t21142_media_task(), scheduled by this same timer's callback,
already ends with its own mod_timer() call on tp->timer, with a
comment noting it synchronizes against add_timer() calls from
interrupts.

Call mod_timer() before t21142_start_nway() rather than after, to keep
a property the old timer_delete_sync() had as a side effect: while the
timer was merely pending, deleting it first meant it could not fire
during the ~100us t21142_start_nway() takes to reprogram the NWay
state. Rearming first, before that state changes, preserves the same
property without the illegal wait. It does not cover a callback
already in flight: tulip_timer() only does
schedule_work(&tp->media_work), and neither the old
timer_delete_sync() nor mod_timer() waits for or blocks that work once
queued, tulip already uses a separate cancel_work_sync() for that at
shutdown, which is a different primitive for a different race.

Update the comment in tulip_interrupt() accordingly. pnic2_lnk_change()
still calls timer_delete_sync() from the same hardirq path, but its timer
callback re-arms the timer directly with mod_timer(), so fixing that path
requires separate consideration of the callback/reschedule race.

The warning was reproduced during a link-state change at boot on an
Alpha UP2000+ running v7.3-rc1 with:

  0001:02:08.0 Ethernet controller: Digital Equipment Corporation
  DECchip 21142/43 (rev 30)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
v2:
- Rearm the media timer with mod_timer() before restarting NWay
  rather than after, preserving the old timer_delete_sync()'s
  protection against a pending timer firing mid-restart. (Francois
  Romieu)
- Spell out in the commit message that this still doesn't serialize
  against an already-queued media_work, which the old code didn't
  cover either.

 drivers/net/ethernet/dec/tulip/21142.c     | 8 ++------
 drivers/net/ethernet/dec/tulip/interrupt.c | 5 ++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/21142.c b/drivers/net/ethernet/dec/tulip/21142.c
index 76767dec216d..950abf4a8c14 100644
--- a/drivers/net/ethernet/dec/tulip/21142.c
+++ b/drivers/net/ethernet/dec/tulip/21142.c
@@ -216,20 +216,16 @@ void t21142_lnk_change(struct net_device *dev, int csr5)
 		    (csr12 & 2) == 2) ||
 		   (tp->nway && (csr5 & (TPLnkFail)))) {
 		/* Link blew? Maybe restart NWay. */
-		timer_delete_sync(&tp->timer);
+		mod_timer(&tp->timer, RUN_AT(3 * HZ));
 		t21142_start_nway(dev);
-		tp->timer.expires = RUN_AT(3*HZ);
-		add_timer(&tp->timer);
 	} else if (dev->if_port == 3  ||  dev->if_port == 5) {
 		if (tulip_debug > 1)
 			dev_info(&dev->dev, "21143 %s link beat %s\n",
 				 medianame[dev->if_port],
 				 (csr12 & 2) ? "failed" : "good");
 		if ((csr12 & 2)  &&  ! tp->medialock) {
-			timer_delete_sync(&tp->timer);
+			mod_timer(&tp->timer, RUN_AT(3 * HZ));
 			t21142_start_nway(dev);
-			tp->timer.expires = RUN_AT(3*HZ);
-			add_timer(&tp->timer);
 		} else if (dev->if_port == 5)
 			iowrite32(csr14 & ~0x080, ioaddr + CSR14);
 	} else if (dev->if_port == 0  ||  dev->if_port == 4) {
diff --git a/drivers/net/ethernet/dec/tulip/interrupt.c b/drivers/net/ethernet/dec/tulip/interrupt.c
index 0a12cb9b3ba7..6ed4b68ad86c 100644
--- a/drivers/net/ethernet/dec/tulip/interrupt.c
+++ b/drivers/net/ethernet/dec/tulip/interrupt.c
@@ -698,9 +698,8 @@ irqreturn_t tulip_interrupt(int irq, void *dev_instance)
 				dev->stats.rx_errors++;
 				tulip_start_rxtx(tp);
 			}
-			/*
-			 * NB: t21142_lnk_change() does a timer_delete_sync(), so be careful
-			 * if this call is ever done under the spinlock
+			/* NB: pnic2_lnk_change() does a timer_delete_sync(), so be careful
+			 * if this call is ever done under the spinlock.
 			 */
 			if (csr5 & (TPLnkPass | TPLnkFail | 0x08000000)) {
 				if (tp->link_change)

base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

