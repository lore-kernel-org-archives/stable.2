Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600096;
	b=n0GCVAjkbCrjqv4BwiUH5vb+o3hllnfVzIE8Vwf+7DVLDJnD0nUFxeq8bxI9IS41qnT9
	 hdI/OjVPu0h++ss+6ck8mS2pGDo59NGS4zPDS+1VCy7xKafP9Bg16u//sJw2/4uNhISJm
	 opfgTBKq+4j9KBuQrXVTzLo1UgR+NFZK1Y9b4ddPav+9VJesy2uVAAXqIJ3BGv1Um2IiG
	 9C5oRt+b7QWplXQn/CTpHQOKhwP/oce4DLE9HgGZtEPVsZ6r07QNyJHSTt40db3pE/pKf
	 6n8b0u1WvnHTC+KO6ovDvePSAQS6Qrxn1Fnn4z/Aj2nCfgHtcpM68tqFKMbRfnYhblg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=EC9RASKFPMm8luP0GQ/7tSz6vapPp12uuDlPtIQw68s=;
	b=Hc/aziRaEXseDdV8FSq9j5gZS9TlgOuol/RhckkRXzRImAme19RkSdD+lALcBe8zAdQS
	 KXvWBF44jUGpoCy8IVCPPMWLtADHICbS1jrKYap0MjDhEukpYn1Fkq4ewNHuGSViiPkL+
	 WmI55o5lBtH9b7tZ7vZuECjmi7w+ldqCRFS7GZAU5l8H4fv6306kmmUtGbV6st0fENlW7
	 yq7iMz/r1whtTml5xLaaYFNiW0Lgy9rqUX7ln/LUKVLEdL+o+y/X3YW1Qfzf5fgUxrAXU
	 P9DgeE1bMV1fiSLTpYleKO+jtK3zR0OoufpP4gX1XDo21ZGk+eV/ACud/VHHCr46FVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="Ii/Q4AtR";
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601D606A887
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1601D606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ii/Q4AtR
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-71ac798b8bbso541741eaf.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794600094; x=1795204894; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EC9RASKFPMm8luP0GQ/7tSz6vapPp12uuDlPtIQw68s=;
        b=Ii/Q4AtR+Ka3hto0ms2y390aqMzxmLu8CN8YPpbROMpPT+7mBlffjgccAy64QexD1m
         /wWxNx6PzyyD5aohb8jfcva8gy9MyZXidbtNC1cwD6YAZVGUoTZZQ5FnfaJU7nGRVbJH
         5mQuFodpF8yl+6lV00hZvs4Mei6pwi08rBiYYW0TMaR4Ei+hXMM4a5jzlVMh3zVhSu9N
         +vu2lQb6Qt2o8BF28jOcaBSPdR2OAtepAjhGIwpWdWGMrAThWgFkzHRp7WM1ecEj9EXg
         5Z1YsiPTERo1fqy8klWRT941zWFNbUa/4sbuz90bdILGzYqVlGsnaTwCB95v5Ok593YO
         xKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600094; x=1795204894;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EC9RASKFPMm8luP0GQ/7tSz6vapPp12uuDlPtIQw68s=;
        b=yBdHatvS+26+UlUSYbvCE5aX+7hfMRYRQuuPvZFbv2dxTgQ3M+XHAOGb/TCdvPqs2X
         LDo/T6ydRVMfXYgctAat4IlJyIVd2DEgK0tHPNCU5+W8xXuoji95v+YVeYcwirWXSZVS
         2IBSlj1L7mGBud3tsxWHT1d5Mrjy72y8oSwJdNTZyJs48bC8s2iz1fidFTzzurDtkSYz
         FfNpf29GX7RC4rpsqtc7xhaFnX3d1gtEP4qZ4SOvSLuVNPQZTnf8sz6V6lIrDLu/7mdz
         co4Wn2d+1A27N7bnMVZ/vIkIN6A0iZriu2kHrBElYtVP9vzsttYdgWHjYK6JG8K6u6cd
         Izag==
X-Gm-Message-State: APuU4Z9u/eyk5gRaOwtDb2FOeqDnnbo/7SMZ7XE7qGAzMYUaE3s/wIOb
	Pr4SV0MhVTCD6l8psufKJllRFvQXdi9tgwaTTgmNxnFP5qfChrHZUGqaFm9CawrVJXc=
X-Gm-Gg: AYBFou1kC3Uzc8Y5thW9L6AtGHaIXPAP31h3HrpBs+/dhGmx5L6xyuSIp64WLcbOeh1
	5N/cLu3pRaNZ2aXETLPfzqghVc5yyeOp6stmPUWogFF04UObkHuuH2NQ7cgOi+pqS/ZUg56zJBa
	z3XMirUKOTj3e4CuqvHs/n3uQGbsfnXNL6YLpT8G1B5hclcKP1BBhhFfbSn6EBwPNgotqI0B29Z
	PIB/L3xw05Ydl91srVqgQK+h2gQdpE1OxErWNs3g3OBhdB5NK9dICIhR5ut0FDKx+wY+Q2hFjGx
	rKGA41Yuad0IZD+xhwIMV7ljFNeXMM5d+Y1tgtejVSi94SwrxzUdsqmcuMxN2Kxc9CNUYRjX8Hu
	WO4wOvTZAASSSt6z6Mupu29AN5BUltzhAaeTcmp3HZTz4RBWuHbJzqPP7j6wIhamfLKvDdNLZva
	GpCVBviRVjoQTHnM0rF/ACAifMGRhQgKIJriw0sxnz8RCxieS3mAHaJXDORMMZRMutBSiuzTVGo
	SuWoFUbGSy3yOsQ3xq06sEWyViiSPDDVoitUqHECWjTKxhQEMoxWGsSyr1Y2b/raa3ENLh7bEdo
	2x/JOMtMIgcuv77Amuw3MevvHE5r/gyn5yihR6A=
X-Received: by 2002:a05:6820:1355:b0:716:d710:3d6b with SMTP id 006d021491bc7-71ab5083d31mr2286905eaf.49.1794600093872;
        Fri, 13 Nov 2026 12:01:33 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac6:bf21:1923::281:18])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab428b337sm2590808eaf.4.2026.11.13.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:01:32 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
Date: Fri, 13 Nov 2026 14:01:23 -0600
Subject: [PATCH 7.3.y] net: Use a dedicated flag to track disabled napi
 instances
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-napi-disabled-backport-7-3-v1-1-99560caf8bca@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAwA0atUXuMqbgpFXKVikY8BA0qjuCBQ1
 bsTYDmzeAsoF2GFQ7NA4aeoTKkGbRoIF5fOjBJrQ2e6HRFZTC4LRlHn7xzRu3DLU5lxQItmS73
 ZO2Ni76ECufBJXj98hKG17RuO/60Pf+Uwf2FY1w89Vmd0hQAAAA==
X-Change-ID: 20261113-napi-disabled-backport-7-3-051408a00d4b
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1794600090; l=5274;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=Jv9QV00aR+M1g59jP00fdAw8leVncE+PrUsMH8483fU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHlTpd5TAUpqR3hrf1Ua/ezmcrYrnH8wNvJmqTGKyAi2ptxR/RiI41qfut245SFSLyRaNhYhLWH
 B/NoHh+0KCgY=
X-Developer-Key: i=carges@cloudflare.com; a=openssh;
 fpr=SHA256:Cun99EBiH0EV7wvmfTBF9eDrld2NJx+aD4ScWZ45Q5M

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

commit 8dc87fc5d6a0eb337744737008177342a708bf36
("net: Use a dedicated flag to track disabled napi instances") upstream.

Trying to disable the napi threaded state while the napi instance is
disabled will hang forever in napi_stop_kthread(), as it waits for
NAPIF_STATE_SCHED_THREADED to clear.

This won't happen until the next ____napi_schedule() call, which won't
happen as it's disabled.

This happens in 2 instances :

 - Drivers that create but don't use napi instances (stmmac's rxtx napi
   for AF_XDP for example), here it's a driver bug

 - Drivers that create their napi instances in .probe(). Here, setting
   threaded off while the interface is down will hang :

   ip link set eth0 down
   echo 1 > /sys/class/net/eth0/threaded
   echo 0 > /sys/class/net/eth0/threaded
   -> hang

Checking on netif_running() isn't enough, as napi instances may be
transiently disabled when changing the MTU for example, let's use a
dedicated flag to track if the instance is disabled.

This allows immediately disabling the kthread when the instance is
disabled.

This was tested on mvpp2 (probe-time napi_add) and stmmac.

[ Backport: place the disabled state after the threaded busy-poll state;
  the adjacent per-CPU NAPI state is not present in 7.3.y. ]

Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
Tested-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20261029153130.121204-1-maxime.chevallier@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
Backport upstream commit 8dc87fc5d6a0 ("net: Use a dedicated flag to
track disabled napi instances") to 7.3.y.

The commit fixes a reproducible hang in napi_stop_kthread() when
threaded NAPI is turned off while the NAPI instance is disabled. The
sysfs writer holds the netdev instance lock while waiting, which can
also block device recovery.

The upstream patch does not apply cleanly because the adjacent per-CPU
NAPI state is not present in 7.3.y. Place the new disabled state after
the threaded busy-poll state; the functional changes are unchanged.
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3e64af0b932d..02119fa153c9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -433,6 +433,7 @@ enum {
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
 	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded NAPI poller will busy poll */
+	NAPI_STATE_DISABLED,		/* NAPI is disabled */
 };
 
 enum {
@@ -448,6 +449,7 @@ enum {
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
 	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_DISABLED		= BIT(NAPI_STATE_DISABLED),
 };
 
 enum gro_result {
diff --git a/net/core/dev.c b/net/core/dev.c
index cc7b32ab5608..0e0a11ba2ada 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7264,6 +7264,13 @@ static void napi_stop_kthread(struct napi_struct *napi)
 {
 	unsigned long val, new;
 
+	/* Instance is disabled, we can immediately stop the kthread */
+	if (test_bit(NAPI_STATE_DISABLED, &napi->state)) {
+		clear_bit(NAPI_STATE_THREADED, &napi->state);
+		clear_bit(NAPI_STATE_THREADED_BUSY_POLL, &napi->state);
+		goto stop;
+	}
+
 	/* Wait until the napi STATE_THREADED is unset. */
 	while (true) {
 		val = READ_ONCE(napi->state);
@@ -7294,6 +7301,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		msleep(20);
 	}
 
+stop:
 	kthread_stop(napi->thread);
 	napi->thread = NULL;
 }
@@ -7689,6 +7697,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->list_owner = -1;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
+	set_bit(NAPI_STATE_DISABLED, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
 
 	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
@@ -7725,7 +7734,8 @@ void napi_disable_locked(struct napi_struct *n)
 			val = READ_ONCE(n->state);
 		}
 
-		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
+		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+		      NAPIF_STATE_DISABLED;
 		new &= ~(NAPIF_STATE_THREADED |
 			 NAPIF_STATE_THREADED_BUSY_POLL |
 			 NAPIF_STATE_PREFER_BUSY_POLL);
@@ -7770,7 +7780,8 @@ void napi_enable_locked(struct napi_struct *n)
 	do {
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
-		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
+		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+			      NAPIF_STATE_DISABLED);
 		if (n->dev->threaded && n->thread)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));

---
base-commit: 7595a62d45ee1a2297eafa5f2ef5d0a45142d84d
change-id: 20261113-napi-disabled-backport-7-3-051408a00d4b

Best regards,
--  
Chris J Arges <carges@cloudflare.com>

