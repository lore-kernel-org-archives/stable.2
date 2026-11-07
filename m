Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065613;
	b=Kub7K3V41x5sen2/Nr+PfuiRLM0/5+xhT2bYrLPzDysAXTviye5sbAdSnmiAfNzMG8zI
	 jOaGHSvjKEumAf8cGaUn+G+0kGj9buABKAD5hlgc8vY6F3tuqcs08GZmYOtuBXft/wLPJ
	 unBJSfiaAcgUoITfppthFuatpOfI8Ns+YQWNni2n9wv5LmR2CipCUOXOK+TZWhxCyEoZk
	 k0+wwfD49FFUhVpp194mx6al2klAykOEgKR30RTO6haBMRHSOBJbnCjMWOyFgh0PC7jGe
	 ifP6zdjBkQwb383/F1hTG6EEU11b4588pj1zgsNVFdBvMAdw1gM6z/rMQEQH363Dwhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
	b=f4JGr/wQPQ8OA8bQLH9xgMhtcxxUE4c06bif6fJC/1sZBX9wkd5TUwEXGa8urKjibDGp
	 aiPV5hfGVsC70Ea2t8Of0Pa9UeLGk2Oz54tLYIb2lOG9oFfds9+xMnf2pTh9Rg6+AGVTW
	 HcdLjdT2yww+7RV5JzCAOSi3nfdgSB86aWNJlJnN4cuMFVzQaIqmRPJb7c2WufvmWvk76
	 xb9/n3KyWWHJa/PBzLQ8W2GzLNAy1Td1Z77pUPAMo6RyBpeoqVbsL5Pb6t9s5f8mEquJq
	 XC4c2dlK56Vob1ZSf0dkhYVdTRUOywmK4BWijEAnPMd5EHYS+BDxnKQuBllCOT4zCvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yj4cDSkF;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F065606A338
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F065606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yj4cDSkF
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2771932eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794065612; x=1794670412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
        b=yj4cDSkFVYDWYdtMlaEUcHRvWY/d+c/hagAFafGVJ2kowj7dEQtzde1dFtIr9b8k4O
         TznZsh2F8ZZSCDShb7GwY1Q2EMPyfv4l6WIR8wugF0oVmUUV5XsQvpIkv9BYwYBa4upM
         v49KfCxM6hDHs2bGh3SbigkIGGfWJbKvF7xoSGkOBM8qpXVG9SHqKDSm9MEzjogwlzQf
         doEZfXO7C4/5NyZ9Y+AOCAwV6ZM/0INN4g2SEEtHsmIFnb9AbasKCMBkCp6t85EyOh6X
         pSPMnI/Mi+0bbcN8+9Sj0wBCv1o4Mwu+sfFQU2Ez6P/9d3JirkyqtgmB1V1hLsJMFsqr
         chrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794065612; x=1794670412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
        b=YI4B3tlrzVk7VnIF3QOZ2QzFIEPJXM/ZxtQAO8JxBazkNpncyZzNtCadY9JY15Ogh8
         2SzObg6zBiJO8gi/BSslzhF1a8hlaQGlVM0pbgYF5xykGzLGv410TMcJYziGy9AzRARC
         RCJn4Ylk2j7hD1MBZZza4oaCyZJxcyRiNm6uEK7PjIc4Egx+pQeRSMKYtUM7XvES4czv
         sk6cg4calL0woU1vRCbqN4dscKg19JgAkHHfneCGc822GLlW2MgH8Sh1xpyMlDvL8wRL
         Q8Vy4QZnLwULqXcc6stn9N6hJ/5rpHIqbDGNJEH5Wseon5L5+izla5GQo1irjrLu5b10
         CIhg==
X-Forwarded-Encrypted: i=1; AL+hErHM7Bro2dfy/BrCOhcn43U/6oErHq1Y7BnisJ6AOJ5XMV0jczOQWss19v24fKc9J9qjH8EPqOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RWvOnEu+KR4alJ4w+X+jX80IuWBaVYtjHSBYf/ACZQ0L+tWgJ
	IvnggOoIt0LayymmTWAFyFr4vvCrLhYJHQ73e/l29EHCrxhrNqsruSdv
X-Gm-Gg: AYBFou15+cApLszqhz3GFKW2qqx7ByJjhjuW0sy0WzUTqLICylE9ui/14SRSbhMosW6
	bFW7Dh5j/LmBhPfQjgsp4eY2373NOIMGbb17Qqmb2XmJj6Y81LEAoUhjBjagq2007Y14AGJUp5a
	192kUp7javX9v6MjIb+Exi4MLm2c+l+BVQxzTV0xgfd9Y1JIjkiUbuRznijghSU8O8HbL1f/e5/
	Q1WATqnStSaHWYqL8LUM1VOxozayjl0wlntWvrWRMW7ESZDfqwSHsvi31fhDiJ3+SsEDulH4EVd
	vcDhPpBv4hGMusdlLknbNom46aKCMFwioePkXcfQ2rUnZrK2TNHqoANOwwbW7Yj2wfOIEKTBB5Y
	sQeHJo9X/LC4h+kP+9KnytKi40Nw7Axu57130N1Wz7Vn7mf0nHvXhC3AM1bsX6ZjWxkIsV+xJ5f
	7TWczeJb8SoWHnKIWVBG/UCbwekcKSjkqMEuzqMBp7ywOX4dC8i6JEwA5pNFFpezYb+U6cbgtjV
	iTzDMe26Hij2agJeNoowYrZEBBTuOmcLm7HUTfxL2THQsNv5RZo35RCD4p+Z8OBmKcBQC8nayAJ
	uJKXNK34nwdNYoSC64UfYwSBGH6+/H3V/dgQ5449KyDRcxQScl3eTxFCMJ7mB2rWlp4sRQ==
X-Received: by 2002:a05:7300:10c:b0:369:f97f:72c1 with SMTP id 5a478bee46e88-36f771025d2mr8735252eec.36.1794065612157;
        Sat, 07 Nov 2026 07:33:32 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa96fe226sm17256890eec.12.2026.11.07.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:33:31 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: peak_usb: pcan_usb: cancel restart timer on stop to avoid use-after-free
Date: Sun,  8 Nov 2026 00:33:19 +0900
Message-ID: <20261107153319.3765325-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

pcan_usb arms pdev->restart_timer from pcan_usb_restart_pending() (the
restart-command URB completion) during CAN bus-off auto-restart; the
timer callback pcan_usb_restart() obtains the pcan_usb via container_of()
and calls peak_usb_restart_complete(&pdev->dev).

Unlike the other PEAK USB adapters, pcan_usb provides no dev_stop
callback, so restart_timer is never cancelled on teardown. When the
interface is brought down or the USB device is disconnected,
peak_usb_ndo_stop() / unregister_candev() tear the device down and
free_candev() frees the peak_usb_device (and the containing pcan_usb)
without deleting restart_timer. A restart timer still pending then fires
pcan_usb_restart() against the freed pcan_usb (use-after-free).

Add a pcan_usb dev_stop callback that deletes restart_timer, so it is
drained on ndo_stop() - which unregister_candev() invokes on disconnect
while the interface is up. pcan_usb_restart() does not re-arm the timer,
so a single timer_delete_sync() drains it.

Found by static analysis and code review; not tested on real hardware
(needs a PEAK PCAN-USB adapter and a bus-off auto-restart racing unbind).

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c..4c13195 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static int pcan_usb_stop(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	timer_delete_sync(&pdev->restart_timer);
+	return 0;
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1059,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_stop = pcan_usb_stop,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.43.0

