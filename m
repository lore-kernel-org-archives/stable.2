Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455664;
	b=3TI/NEe7fcyHNF/iH0ueZw6WR8Iq1CL6ZEly5n9X2mT08rCfaC/7rJ9YN8ESTFoYeZRd
	 iClHFAs1fAfxwoPUElAUCcddptJgoC+6b74zEIVj7gkb1faKaRq32TRIWxL0t2t/IamtX
	 Nr/D0yhxiqNA3JxwdVIuBB07KSdv4qS+vtNIDJb/OJW2CJcRXc1OF7a+IflvZ1hWSb97Y
	 8537kFh8q4TgoIMnfi9ZhYnv4TUFXtqUopcazN/AeoF793MAWzfcFnfLgsKcQjsvtQqUy
	 HS9d31Y0CkLtB/hUwFo3w+3krI95HKjYsYwryjsZnypSbDx5jgSONA7jCJaubiuT9yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xBHf1i3knjux7GbC9NcrP8w6x+jKGVeq5oZiew9XRX4=;
	b=5OWt1kaESRk+FFNjyVY6EfPiHbBq5Obf36RtDJ59BbaFVlePX83kLgbRZyFHtcRH2Qlh
	 EDwIwBM9r/1WoqFUH109pmDoSzU3tKJsdYx6ewwEmdQAqZ1i5F44GCV8EMRFYKvcaPGNl
	 49dGzrRLQ2tRxl2/tx2kJmw9krQ5TM4OkP+jMfndMxjoWUOIuiItBVqlbVxmzC0RWjmeR
	 pItKaWEVAS9cwIWTTvLRsVoMCa2GLwJfRMW8+ikAxhfHY7b/+l3tszr5MZi09ToeY0J45
	 QbQvJ2xJ6GW2p6fbhF7bz7eO61qHXdQqE8MZ/7FYOirbsHCpPfeE113h9A5V1F2Iijw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=NzPGYzfW;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE5606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73EE5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=NzPGYzfW
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso143177a12.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792455664; x=1793060464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBHf1i3knjux7GbC9NcrP8w6x+jKGVeq5oZiew9XRX4=;
        b=NzPGYzfW1WBjfwBOavoylb6rkxG7Bh3thkTixKBzQjgIlVPNNWwY+1+lTxDzqnof39
         wjZOxkOkeS76PtLwWa905tk0DoTPgNgw96iFiAmnfmMw3w6WPWkdWe7roBxc0Gl+vbEm
         w0MmkvTkYGhzElelY8ddSq2xdYktSmICX3ovs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455664; x=1793060464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xBHf1i3knjux7GbC9NcrP8w6x+jKGVeq5oZiew9XRX4=;
        b=EgFSpns1u5eMHwM8YSZAAvKzhfAUIBmHXMmrFDZGZoyld8iaMGR4d2wzFtRJ2z/Yc4
         qQrZeyudNXRQj0k6JdqBYCYD9kk0JDUCBCFURcJ7g533+FD2+WkbwCzf7sdlmO9yGTai
         /vvqfbWqKMG6KrU6GKlTItUya3F7Uf/PgkAUXZZkujMROW5ZXomY76R6vBauvPItbdmt
         smMa89c+JB7GQ02ajqbvA0VD8T+rHiskRMIYSk7olCfiRTA3Ij74MCrtmJ0Oqqfetgs4
         YqJqNH6UOiX4M4JIAQKGC8Y0jPCjhSbm5m/M0Eh/7OBQ059ZQ4O1kpzlzvh2UvPGNCMi
         TPeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwd4ChBZ5RbDip/ts7pRQEjo2nC6vLJfIu3HaBghaY5CUBbEHMvD5GLJak60v8O+fq/UQiZmHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+Jr2qX0e0Oc2oOiNUpQZ3lPE0cPfIHYdxMMpxTd6RZqZb8tfM
	ZO5dcbzS3phJqN8t9Mhie7b6Hsu/xnUsvh11HQavhUajnHn6gnSVkg19CoD7VMeO1X4=
X-Gm-Gg: AYBFou1ndbK4k2S9LRKmYxaCjU2Z2Sb/xwujo7raqo6twSG9EQFDy0ScLW/X99Kh896
	eFSYlTAwsJ/35j39xAOTcyfdXBbVk1YrX+7XfazPgMitPMM1XKrklt5qEdCaw1UzWOJS+bCYcJS
	bJD9mhRHj3TD0GUBG69SOZDXheu9MO2TotThzh6gKsGSrpduawT+yE74H8vD54kl26qH9OpFU1S
	JuCz5zQ46i6cQ2KrFbIeVFqBVFTSQzHRUHm0BsDjn7LIDP7AE7WSA5b224RW5910uLCImxuKEiX
	z16JnaZxNCMMzIvFMO/Bc1huvIwUOaWJQLwpzXz9T745A7Yi01YiBbPxN2mrHqHEaxldkvXiCCp
	F3pL08lDG4362JjwJ9bxsohd/lVNOu8VgEtYn2AkeP1AhTab7FB4jssUPEwTxXxpzLmi42IlXTW
	QImYo8vFpPxwfQADCI/LI2OzJ3HQy2yEt9s6IINZgoX6GqRyPZz8CJDqQSNqQtePdRq6lRiCXbB
	gd5/8Auk2UD+hdZjpdb3cOTdqKprtLG2LaGHqPFccYvsoasFbrVXCc=
X-Received: by 2002:a17:90b:3ec8:b0:3a0:eec6:b065 with SMTP id 98e67ed59e1d1-3ad64ba5d2emr378689a91.13.1792455663750;
        Mon, 19 Oct 2026 17:21:03 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df89fsm1694273a91.11.2026.10.19.17.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:21:02 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v4 2/2] net: usb: lan78xx: reject short register and statistics transfers
Date: Tue, 20 Oct 2026 08:16:21 +0800
Message-ID: <20261020001621.2920-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
References: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
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

lan78xx_read_reg() and lan78xx_read_stats() read from the device into
a freshly kmalloc()ed buffer, but only treat a negative return value
from usb_control_msg() as an error. A device that answers with fewer
bytes than requested leaves part or all of the buffer uninitialized,
and those bytes are then used as the register value or the counters.

Treat a short transfer as -EIO in both helpers. lan78xx_write_reg()
does not use uninitialized data, since it fills its buffer before the
transfer, but make it fail on a short transfer as well, so that all the
register helpers report a partial transfer as an error.

The write path validation was suggested by Andrew.

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: stable@vger.kernel.org
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---

Notes:
    This patch depends on the previous one. Without it, a failed statistics
    read would make lan78xx_update_stats() compute the counters from its
    uninitialized on-stack buffer, so the leak would move from the heap to the
    stack. Both patches are Cc: stable and should be backported together.

 drivers/net/usb/lan78xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb8204371f5c..c19df8e80b52 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -612,6 +612,9 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, u32 index, u32 *data)
 			      USB_VENDOR_REQUEST_READ_REGISTER,
 			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, index, buf, 4, USB_CTRL_GET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*buf))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		le32_to_cpus(buf);
 		*data = *buf;
@@ -645,6 +648,9 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 			      USB_VENDOR_REQUEST_WRITE_REGISTER,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, index, buf, 4, USB_CTRL_SET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*buf))
+		ret = -EIO;
+
 	if (unlikely(ret < 0) &&
 	    net_ratelimit()) {
 		netdev_warn(dev->net,
@@ -695,6 +701,9 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 			      (void *)stats,
 			      sizeof(*stats),
 			      USB_CTRL_SET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*stats))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		src = (u32 *)stats;
 		dst = (u32 *)data;
-- 
2.43.0

