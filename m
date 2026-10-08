Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F964A0EF7
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474854; cv=none; b=Z3g4fiZw88Q7nEVfpv3IGudiW4+LtPxJYqSzCxb2sQQfpv3x068tytFsoC7ppw6pnmU6V2sjKDvJARzQBmMxwv/KtM60cwBE1Iel1+XwT4UvtqbNjsemFfqhPxQJf69Ibn7WRQlqGLu9mLEu4zBEg2asaRPXvqzLw2SiskYy3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474854; c=relaxed/simple;
	bh=S1II56ylg/97q6dhjDqRpRIkCOMFFzoLox0FF2Ni0VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cy/AzXDGSrHxtMf6AJSK+BoL7pyohzq+tdJgcfHL9ls4poeR31KvsWFiknZxS9Bgl8S1ygzrvlHp3CXLxrEx6IkF5XVimPxALuOMRFqGysnreharpgqYRtRmqoR9q5Fr8IhGs4ekAytKEAurrRu6RQe1L3AGrb5vtT7ocQ2fym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedlinux.blog; spf=pass smtp.mailfrom=embeddedlinux.blog; dkim=pass (2048-bit key) header.d=embeddedlinux.blog header.i=@embeddedlinux.blog header.b=dSLzE9l9; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedlinux.blog
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedlinux.blog
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedlinux.blog header.i=@embeddedlinux.blog header.b="dSLzE9l9"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso1914445a91.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedlinux.blog; s=google; t=1791474852; x=1792079652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sE8lwTNdLkYWc1LQF/cZxBSB3EKclBzuC8NPFeXmPwo=;
        b=dSLzE9l9Y6mYySM54duzz4qGRgu2KgjjVtRQYYg20qBU5iBdtH1SfI9KeoUivrcUkX
         DiTQsFcoan3vDnRDpREMSNMfTQzWEmvlsy5XTpxHbWteNwVpaVeCm+V3l1bCNJZREmzG
         ryEDojpMyTjCuPIGJKyjXfCpGOJioUcISNScgVRXNyFVYnc+IBxIkt3QLkajdTWi2792
         o84iZqPHaaX2ix/c4neK7lD33QZZk9LN5/84sGdA8At1cwvJtd1qibHnd6hdeJdoOgLn
         TbfnPdWT7wLzDOHPBNF9wi2EbesHOVbCP3Sc3te3uxNAizukOIM+xrAO4kcFA494yTkq
         janw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474852; x=1792079652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sE8lwTNdLkYWc1LQF/cZxBSB3EKclBzuC8NPFeXmPwo=;
        b=2hwDBQy5Dzd7gzMG+vJrQzScTYHXAJVMV65dLzhMxF6+xdabGhiwyx8PXK1e76X+LU
         eufmX/FyqydN/Ib7rGMNJKRqsDyAin6b7Ye8XvplwIUt2X77T68R4/osnI4xMftrp6d7
         fLN1b2S4yR4I2UDyA6Egpr9+w6BXfRaNYePwaHUsTDaDSEe7AzbR6RKSPSd7iZy0ReN1
         c6Cjow79ZA+pQAtsMlMgEfdox+EuRJBQdweEfrAhYzfWIayWe957wI3lLkYyVrB/+fhj
         jcpny+5BbGl0h6Qug9WOhedwOOSSyF/wVd9ZyNT5lG1lc9m6MrweVQjVjxA0oZqE/5Si
         1QWg==
X-Forwarded-Encrypted: i=1; AKwUvBxpBb5SxBuZns7R37CRzPsZaxIdDECCz1p02qlOd04pVpeE9sQB30uYGkqwjPnInRAtZO7xO1M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSJGY0UKsHTE94PXPGdc/w4Z1ng43U6zJpBbovePhFxjWNvzUN
	tVZd3D8GtUbQV04/8nypnG6O93KRAf4T2+jls4lF4g9C8U361HpGaNjPy0VPhAFIcg0h
X-Gm-Gg: AYBFou2cKH8ubQER1IBiIFxBE+CmpOmBeh2P+UnUiIvw40t3HvafazhbJrAkteXVBME
	JbKO4MQU4CxrUKuMTseJ55t1IE5aB9HvwgIzbFM3A7nSo76wwSnZbbz5nPRCyJeUwjvBscGTlIc
	+bBQkA+NbuSNl2LA6ILWqHKCYkMz0YtzfJVEnJuM2ItZfZidOibUQnJMsZG9aZKMKWEvF/Jx+ov
	eLv6kjKkR1a9dWPho8YwJX0PidSb+E4B7vBLZ3/f51Fnxv4ykmHl4O1xsP9E4kLT/EeK0C0Gx3K
	aT3McaUvV09SYMGRdSzmKd7OVzRw2EJmYS1EF2DYKBY5jK/GaLolo5GyPiiIDB0U83U4G8v4Urw
	kKlfvb5zr/G4gAWLnJXSzG99kPR4f145Pv2NrSqxehvwXSw8XmI9DmszIWi9VweZhtjeZ9tSogl
	7NrThl/thYD6NfaZQHXgv1RKtqu8seXp6/k2Bkglhf65O1orrMRNP7w1JnsaYjml4sCspfmRD5l
	eeAwgY=
X-Received: by 2002:a17:90b:1812:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3a8a072a80dmr5549464a91.15.1791474852449;
        Thu, 08 Oct 2026 08:54:12 -0700 (PDT)
Received: from ltu.. ([116.101.18.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd357149824sm293486a12.18.2026.10.08.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:54:11 -0700 (PDT)
From: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johan Hovold <johan@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: musb: Disable the D+ pullup during system suspend
Date: Thu,  8 Oct 2026 22:54:02 +0700
Message-Id: <20261008155402.66266-1-tien.nguyenminh@embeddedlinux.blog>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When musb_suspend() clears DEVCTL, the host sees a disconnect. But VBUS
is still there, so the controller can start a new session on its own
and, with SOFTCONN still set, pull D+ up again while its interrupts are
masked. The host then fails to enumerate the gadget ("unable to
enumerate USB device") and gives up, and nothing at resume makes it try
again. On a T113-S3 board the gadget link never survived an s2idle
cycle.

Clear SOFTCONN once the context is saved; musb_restore_context() puts
it back on resume. This is what the FIXME asked for, as USB can't wake
us in time with the interrupts masked. Platforms that power the PHY off
during suspend, like the AM335x, never showed the problem: D+ drops
with the PHY.

Fixes: 6fc6f4b87cb3 ("usb: musb: Disable interrupts on suspend, enable them on resume")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
---
Changes in v2:
- Comment: why only some platforms see this; where the PHY is powered
  off during suspend, D+ drops anyway (Andreas Kemnade).
- Message: one sentence on the same, in place of the da8xx one; da8xx
  powers its PHY off during suspend, so its host saw a disconnect
  before the patch as well.
- "Disable" instead of "Drop" in the subject.
- The code is the same as in v1.
- Link to v1: https://lore.kernel.org/all/20260927164145.1956429-1-tien.nguyenminh@embeddedlinux.blog/

I found this on a T113-S3 board (sunxi, s2idle, Intel xHCI host): ssh
over the gadget never came back after a suspend. With the patch, all 30
cycles I ran re-enumerated after resume.

To check for regressions, I also tried a BeagleBone Black (AM335x,
dsps glue, suspend to RAM). There the link came back after every
resume (10 cycles without the patch, 30 with it), as
am335x_phy_suspend() powers the PHY off. A test on an OMAP3 board
(omap2430 glue, twl4030 PHY) would be welcome.

 drivers/usb/musb/musb_core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 73ac25f536..39b0845108 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2825,18 +2825,26 @@ static int musb_suspend(struct device *dev)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
+	musb_save_context(musb);
+
 	if (is_peripheral_active(musb)) {
-		/* FIXME force disconnect unless we know USB will wake
-		 * the system up quickly enough to respond ...
+		/*
+		 * We can't answer a host with the interrupts off, so disable
+		 * the D+ pullup. musb_restore_context() puts back the state
+		 * saved above. Where the PHY is powered off during suspend
+		 * (AM335x, for one), D+ drops anyway; where it stays powered,
+		 * as on sunxi, the host would see a device that can't answer.
 		 */
+		u8 power = musb_readb(musb->mregs, MUSB_POWER);
+
+		musb_writeb(musb->mregs, MUSB_POWER,
+			    power & ~MUSB_POWER_SOFTCONN);
 	} else if (is_host_active(musb)) {
 		/* we know all the children are suspended; sometimes
 		 * they will even be wakeup-enabled.
 		 */
 	}
 
-	musb_save_context(musb);
-
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.34.1

