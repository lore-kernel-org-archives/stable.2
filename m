Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600155;
	b=1ZDJLBU2WSuOVFEewa6tx6G8B/XbWqXHGVReIeQ5tq35CEjkch44M5QaansR3cmfynrJ
	 uTbJOwaw562Y8kSY1xVlOFgvutk+WqQn5VXPelsmMzQ9u7NlXMlxLv0KF+PM8SvfNBV/5
	 2S4AYRERAHwVVMIzpvVxiWn6L2clZ7g/FQAdd0y1qwVVeR7ytHvVRzkxV1gqvdsrlDBfs
	 eabAIlf45soXWbI+1AOysJoZVxRVouqLg2dl92TafA+oX6X9m9p6ga07FR+mYNy2K48vg
	 l82E7lsaomFiElLZDSCMsqUsbyqz7kAl1L8BkDXdEEcK4CEp5EmU3VmrSs3Ared+Ipg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=OdipV0qEsj3h9N2EHRblxLGiTfzERE+tzRI1XRZpm+0=;
	b=K2JqHIpOF5/PTmHlYK4T1fFi97Bfyor7Sxwt6GYYfLtNjQiOT/2I6RcLSRo18CowdlVX
	 wgMEIrqteIJ2cPUegeeEaCwkVWgXuirZ5mftwJri0uRNfGsKSrW/7uaRkuf0+7fo0VHeT
	 TEZ2cfk7y/YYeQ5n62onSqpM/S5b014w7AxIFVs8lhCBti/b7QmLJzCLALidnG+OMFl8i
	 7aguPWRlVGw5u4pewp41DU7YKVtncqtCOR1cuPE5NSQj8D11WNv+fmK2I0pIXXHbDxFrL
	 eKkOafJcWhrqqOtDQyHH53iDqrsoTY1nSBrblU9/YVgY1AvgetimoPkVRICZYgS+mGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="cG5/0LhC";
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3231606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3231606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cG5/0LhC
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-833e671ee9fso2523241a34.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794600153; x=1795204953; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OdipV0qEsj3h9N2EHRblxLGiTfzERE+tzRI1XRZpm+0=;
        b=cG5/0LhCZtvnIywu+BZam9v25+QoGvZSTjvrjWo/Th7JW24Rma41sJrkFbfqS1TZGD
         xOxPE6ideTFvtHiEC16W3I5MPuZ4sUdkE3Z7nVV0lhnsKkvLNSv1j8D6xc9djt2v78tU
         7Czjk0GQjau2Q6cJMPmEnWOVJyj61YlKZ8AwfHJRRfBYSBV+ZmDCU77S0p8Gy0AlhDSg
         4gXjI7sOffpDmbFiqLj13ZQMccElKLWSvoeeEZaGpT1sYjuReNgLWaNXsvgjtUENDdU8
         Gp7rE9IpnqkmguaXa7APUiJ18TNdjJwguXtvSs9KW3pMyfVGQd9llE1WGr8GqFo7peQb
         Cfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600153; x=1795204953;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OdipV0qEsj3h9N2EHRblxLGiTfzERE+tzRI1XRZpm+0=;
        b=GFz5JED7QnDaYK7nfvikaot+FUgM8I0mlqT6CF8LDe1TCH0G9mxWXj/1ZQwaPSDw/Z
         fxbwRSCU62d5V06YP+hy8CaP8v2LsV+/rYYsUHsRIp85jQhsVlcc7wFolDkzZ/4shZBf
         14P6yItRFtT3Hk18QuKG1yz2QY1l0I8yc/2HQkb/KXD5wWzKSb87910ppStQT17+gHoL
         sxUKD9w28FT4D7OZ40EUGlEZCqryRLDUJON/cuYhB/huuT5IX5hw10EWZx346ENx2qku
         /pF4pCJh4eP7RQZq1mVL31axQvFe24Es2p+mqT8ZZJGcwv0H9Jlz3vqFjQhVoknbhtdT
         jOzw==
X-Gm-Message-State: APuU4Z8dXusVOmOdIlOYlr6ZJanfR6Y7nsbfZPnkXEfuztoSR1z7jyuS
	H0+bXg8wDljD7M4Rua8sEbQ5qJ4dWCAg+no1+s/24oIa2NSUJncdDQhovGABr0u5Kis=
X-Gm-Gg: AYBFou0ljKM9J+SwOXJeTjAe9f0hxq6Ewrf9KhSGEuCWqdaE/Z5pMf63Ks/9I4oQk5o
	eYwdjxEDI8DZJnL9l3iPrX+pMjLELSWyrM4hlh7H1lXaZEhGjjNdXWi9yOWjgwAERDDDulLT6nV
	uHtqyWT5v7KLRQf5s0MGKxYSfxjMp51oNzGGhaf4cTbIWTnlUhhUFB55t2syD61Ci8pcO5GJAlG
	WxO1YAHyZMYDuUoxaAfIi/HW6Z3D8pzcn1/OItdSkR9uh8zyWiLBQxhRaOma7T62yMRhEiJfkEW
	ZXA0q/UmP2vhY+0fUv53xtTCGL5qq+VxEWR/D7VMTBXFlqUK/UOqtUIVf8h+JEiERe/JRf8N4M9
	Ze2dOcFGtOlK9lYZZ70zyiV5nmWAJY+bFHleF0Pssfcw3BrxkqxEwPeONrz46/yg41BaljYIlD2
	NtPwVh7hDHJQk5NcX+WKiwm95Xj08jKc+9o8I67elzMWoz9RmZ2B3qPF1lDrDIvaF/j2ox3X2Ze
	hoU+j1Aqg7djSnocQpo8jkA/GIMZ1kpvEuWemm8q99AlkeVOUCGyk1MJll9QQjSzvdQN5SEdqju
	sYxePCRCAUdAhOQ42Q==
X-Received: by 2002:a05:6808:1510:b0:4c4:3997:ef2f with SMTP id 5614622812f47-56e63286b63mr3317786b6e.17.1794600153455;
        Fri, 13 Nov 2026 12:02:33 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac6:bf21:1923::281:18])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6dcfcf4esm2893643b6e.2.2026.11.13.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:02:32 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
Date: Fri, 13 Nov 2026 14:02:27 -0600
Subject: [PATCH 6.18.y] net: Use a dedicated flag to track disabled napi
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
Message-Id: <20261113-napi-disabled-backport-6-18-v1-1-8081f2887b69@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ7CIBBA4as0s3YahiaIXsW44GfUUUMJVGPT9
 O5FXb63+BaoXIQrHLsFCr+lypha0K6DcHPpyiixNWilDRENmFwWjFKdf3JE78Ijj2VCg2RRaRW
 GvT34YC00IRe+yOenn8D0ZPsZzv9fX/7OYfrSsK4b7Ce7P4cAAAA=
X-Change-ID: 20261113-napi-disabled-backport-6-18-020c3789bc88
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1794600151; l=5123;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=6r+mxa6q4IYhpBpcpr4DGE82Y0Cl3bnuQ3KCYwMxafg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNKXy0bXu7Mknfxffqwnf/kmKrYKzus0C8aZJNo6YAe5XtJ8pGzJY6d7oS5s5NOP3NVi0BSCw1i
 +NTaKAwKXNAA=
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

[ Backport: omit threaded busy-poll state handling, which is not present
  in 6.18.y. ]

Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
Tested-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20261029153130.121204-1-maxime.chevallier@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
Backport upstream commit 8dc87fc5d6a0 ("net: Use a dedicated flag to
track disabled napi instances") to 6.18.y.

The commit fixes a reproducible hang in napi_stop_kthread() when
threaded NAPI is turned off while the NAPI instance is disabled. The
sysfs writer holds the netdev instance lock while waiting, which can
also block device recovery.

The upstream patch does not apply cleanly because 6.18.y does not have
threaded busy-poll support. Keep the 6.18.y state handling while adding
the dedicated disabled-state tracking.
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7be5b78b2bff..e272d0006c6b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -431,6 +431,7 @@ enum {
 	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
+	NAPI_STATE_DISABLED,		/* NAPI is disabled */
 };
 
 enum {
@@ -445,6 +446,7 @@ enum {
 	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
+	NAPIF_STATE_DISABLED		= BIT(NAPI_STATE_DISABLED),
 };
 
 enum gro_result {
diff --git a/net/core/dev.c b/net/core/dev.c
index 673223065b95..95126e236079 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7127,6 +7127,12 @@ static void napi_stop_kthread(struct napi_struct *napi)
 {
 	unsigned long val, new;
 
+	/* Instance is disabled, we can immediately stop the kthread */
+	if (test_bit(NAPI_STATE_DISABLED, &napi->state)) {
+		clear_bit(NAPI_STATE_THREADED, &napi->state);
+		goto stop;
+	}
+
 	/* Wait until the napi STATE_THREADED is unset. */
 	while (true) {
 		val = READ_ONCE(napi->state);
@@ -7156,6 +7162,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		msleep(20);
 	}
 
+stop:
 	kthread_stop(napi->thread);
 	napi->thread = NULL;
 }
@@ -7541,6 +7548,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->list_owner = -1;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
+	set_bit(NAPI_STATE_DISABLED, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
 
 	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
@@ -7577,7 +7585,8 @@ void napi_disable_locked(struct napi_struct *n)
 			val = READ_ONCE(n->state);
 		}
 
-		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
+		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+		      NAPIF_STATE_DISABLED;
 		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
 	} while (!try_cmpxchg(&n->state, &val, new));
 
@@ -7620,7 +7629,8 @@ void napi_enable_locked(struct napi_struct *n)
 	do {
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
-		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
+		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+			      NAPIF_STATE_DISABLED);
 		if (n->dev->threaded && n->thread)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));

---
base-commit: 1cdda838e8475edf89b73ff0cc952005dd0b1fa7
change-id: 20261113-napi-disabled-backport-6-18-020c3789bc88

Best regards,
--  
Chris J Arges <carges@cloudflare.com>

