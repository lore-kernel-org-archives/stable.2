Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722682;
	b=5rZKcVKRxYS8SwsyQ2bli1jbfOWTqsLbYNgUakmQivE894gJpRueRmZ6lEUf0FiXI9Q1
	 qi1//1B4u+kgLIf0E0ALPSfsr0JKeHjuJE/RyTNsnj7AN53wJW/ATTEbPweweK1El5/Z0
	 RWF2LeTvsqTNhOGrTSdBOd3AsRPxQ7zX+IPRBBn/aKJOfa5bMqC2W08Zsk33NRRFBV95/
	 3kVYO+8AqPbMZwOhrjCruHqjgtzxu6QF4X5jWAwoMVAZyIOI8dMKUzlERYZnf/wXruwuB
	 LbAEqO0m51PPWn9njg0yhtKPtnDvsf6M8/+OSFfRtBna/GWta2fRrywfDnoT+G2+6jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vly0CmdUjORbmtqfoq+NzpTLxjcAn8jvLhSrWs+51ig=;
	b=n/VidbW8UkmFsFXq8/Yirl+eAGVJa9tqaBNWoy0ex+raHkjszL4xeu3v9Ixu8YatTGgo
	 hMUspvuBYqJkX0YLzd1oK0PSJZWk6cmqi6CBRvr5LdZfFwv9RHKpkOCzNp1KL8e2qeA3q
	 xKcYhLizlyP39qGz623v/AVqmqaMyv2vrzQq/dI0GYjxULX0ST3t05aSyFaX/E+y8YD7M
	 EtvF2nvUlYkpUvd8oPFVxUNKsR4/NMg6JPdrspcLlnTguV2qwJRy4KN0p1A4YvqH7bvtu
	 n7FromRtMnbdocRhZEYyEYWI7CfxNqCFHd7vs5VEnyjN3+IZOpA6R/Y3Q2fHqQ+fB5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXsDHF3H;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B6606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC1B6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXsDHF3H
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eabf243d05so2770827e0c.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795722681; x=1796327481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vly0CmdUjORbmtqfoq+NzpTLxjcAn8jvLhSrWs+51ig=;
        b=gXsDHF3HYqE87K5skDIuQqocEsYWt7Fc+zSlhipQsPVBaHwuO3Jy+lX/kNwYybjllF
         Yn/A+Pt37OYAYnLAQNhRLQ0Cy7+c/3g0T1vI8RDhiKZVQ7vToNybOznsRCD7r+g1Pks0
         7w1yh8ducipxi5uGK22vK7fNJXlSUqHeN+YYtiaof9d5Q6KwqiB2pyQR5OGP/cGA07H1
         ZNlUiB0yb7/qiAKWeb8h89yV7z8P1UuKsNrKi34BEF+M+CREauF95OTrcPhzn1SuRxcN
         8hfJ2VGRkeDH+SbMAfxjOsB60O4Rtq5UWWY+FgeNuPhgGIS6TV35zki9VRWYpmktiEUd
         jydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795722681; x=1796327481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vly0CmdUjORbmtqfoq+NzpTLxjcAn8jvLhSrWs+51ig=;
        b=XOdw1wLw7fwBuy0PKpzQlbs4Z5tsAISJXNiFS/VXxqfnCE+XdFiRSkxCiMIDS8+HbY
         0CBMxBZyVm2jw0gzQzhLrvPbhdd+BjCuobKC57WBSGHEAsShJwkH0wqO96hWCBiGOPYh
         cWtT41e6Ka9buIJuYJF4Uggu8JrwyXVoX3cXxWx6uGv8AK76QTIp2ffUc5G72UfPoE3G
         X2UNEOOhgnEWMPQ0v1FvmwQp08MG4PXQUR7DlH9gaWV0yWuzkCrgzP4QeB3mi2856/sF
         8MPxTmaNj+8k+V7bKtN6R5liWbOglV3a+4E1z0C6svwm4r8ipwtVuMyInS+O2qELRkK8
         3WQQ==
X-Forwarded-Encrypted: i=1; AL+hErG53kko5BQ3ded5o3OBwuyVq/raPL5848VXlmYUHW7vrFrNqfrrALl0HnMz8qiLNj6GZd7N+w0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qww7U8xq1uVFrrTVJ5hdTl+g91tEEdt+PWqFWWH3uLHdfN+RZ
	0NIlEWQ5Yt1mwCogKe7cSXgtByrY6X4dQXY+MF19HqRp6qkBlN9aMXZL
X-Gm-Gg: AZFdTZcdbDM/O8bejScI8YE55NH/sQobE1Ym0d8MRQWpRMY+y4kFLsdcUBv/5gSB3eJ
	ehJgfNzjLQHhUOGj+GXRm4KTfz38K3TVBwthx61eLylmSzAlXuCLjOPZeNqA00T/bOsfpgNRGCC
	vlrJISRT7F3UVkHIPAljdzasqnEe1Xa0l6I4kyehB9HqrkNumiDqGEjsC+srZ2PmctRh0NDG4/J
	Mse9I4hpBdgVHhrST8ixZ7aNkbwbtkNHVEoEfvG43T+PiFBt02L18KZ49b2UECbZRaYeOVpILYv
	ZA094augEGa36pQmhChPJvW//IkprsLcEo+PF42a+iMfKSohHo8nMJ9ZaJf+lx6bo9oSFjMenfb
	8EABminn/2s1ZDwqJXU1NXYio1cu1kLzuVXHUUF9As+aGjX1EaxgA8WUBOkRKHJjetjat4p4mcB
	DchdSXh4VGA3yHgd+61YmKOLZCLIg5CHxUeNaqg03x/iEpjphyJlWW4a6UaQPmUBnm5OusQKi++
	K1hq2n/oKnJRfkUYmrmUwXbynbduytFT1Ad3uFoNJROH1V2ZKGGM5+GBdfnA5nIkt31f49qQwDa
	jHnXw8Fe8v8BwLA5V+AWkxElhGhhlxfsHkbo7rmhxb1l+vYZiHIqkdSIc39aSj2qtqgTfzi03II
	HSyPzWmyVU3cJJNLNBbb4VRA8lXLlt0zaVPfB9CPq+yXOVUE=
X-Received: by 2002:a05:6122:7cc:b0:5ea:a0f0:192f with SMTP id 71dfb90a1353d-5ee8aee2709mr12650427e0c.10.1795722680819;
        Thu, 26 Nov 2026 11:51:20 -0800 (PST)
Received: from localhost.localdomain ([2804:1b2:aa42:30d0:f9c6:2eb5:66c4:899])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b6641d6sm21675692e0c.17.2026.11.26.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:51:20 -0800 (PST)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: tcpci_rt1711h: unmask alerts before registering the port
Date: Thu, 26 Nov 2026 16:50:59 -0300
Message-ID: <20261126195059.1139494-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
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

rt1711h_probe() masks all alerts before tcpci_register_port() and only
writes the real mask after devm_request_threaded_irq(). TCPM starts
looking for a partner several milliseconds after the registration
returns.

The ET7304 (RT1715 compatible) does not latch a CC status change in
TCPC_ALERT while its mask bit is clear, and setting the bit later does
not bring it back. If the partner shows up before the mask is written,
CC_STATUS has the Rd but no alert is pending. TCPM stays in
SRC_UNATTACHED and VBUS stays off until the cable is replugged.

On a Radxa Cubie A7Z (Allwinner A733) with PREEMPT_RT, a source-only
port and a sink attached at boot, 6 of 12 boots ended like that. In each
of them the mask write finished after TCPM started driving Rp, and in
each of the other six it finished before. With this change 0 of 12
failed.

Write the mask right before the registration, so the setup before it
still runs masked, and drop the write after the interrupt request. The
interrupt is still requested after the registration. It is level
triggered, so an alert raised in between is handled once it is requested.

Fixes: d6b82dafd17d ("usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
---
I only had the ET7304 on a Cubie A7Z. RT1711H and RT1715 are untested.

 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 0581659763a..635ea9aa8fc 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -337,6 +337,15 @@ static int rt1711h_probe(struct i2c_client *client)
 	chip->data.set_vbus = rt1711h_set_vbus;
 	chip->data.set_vconn = rt1711h_set_vconn;
 	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
+
+	/*
+	 * Unmask alerts before TCPM starts looking for a partner. The ET7304
+	 * does not latch CC changes in ALERT while its mask bit is clear.
+	 */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
+	if (ret < 0)
+		return ret;
+
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
@@ -352,11 +361,6 @@ static int rt1711h_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* Enable alert interrupts */
-	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
-	if (ret < 0)
-		return ret;
-
 	enable_irq_wake(client->irq);
 
 	return 0;
-- 
2.43.0

