Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793540620;
	b=VT+yrGwTM1mJAE+DIRGHi+x+kX7rXfx6PWHc57IFEvWTyAnrn46i9zMUnnxO5E7OlXN/
	 /UxXBu2OtO3qRQg4d8c5aV7Ql/34SEN6soCE8F+6FHKay4oS/Xonm3bApMmsyiqWOM4TN
	 ZYiPMR5j/j/0WtV1/gLyDlVbSkb/CxXgsJXZtT6/DgnLrHlUlYu8jMbQFZhurE8oB0uZh
	 MVnUwXrVkCl718qQzc+Z2BUNphdB1JcPoAdRq644jbfNNixHLiqERTDkLaqEsEgSdvSUB
	 9ECspD7fiZF9wk4XPp72AnRUk8ylueCZ7WXsrNo0KyM8qSE2KUG3QuKmdrwrMb913lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793540620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4661m1xYP/jYEqHVXb2ZQHfA5Qdo4lmezgeOZnGqpSk=;
	b=2ad9FsOor5GeA/cSckMNkg/T668I4wVuADybSItuvcP7HFSNSxfwpAt8I30vQRb8Bucf
	 U68AZzCGu7v92kWNaWvKEJQD9QOc9tftJIajwOr6E/cZ/TqGJRnle2wdyDuQy7MEzAi09
	 YBvVwhEI8iuVrfH7DXAVsnlnJ0j9JaK0R0GAMwaBZk4mKnT1W9+OxYFUDdgfc2o8kXw0g
	 /Aghfx6xYWBD1e+b0l2QcWDbl4KHkBRsZZZ0zgkhmg0F3CrGIDEw9akYkbRcvEIv38UTr
	 Y5d1HkHcXauoP40EJq6sqVmqZubiMTm1EKoeRCvlcmliCenIBK9n61jsm328EuXL+XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eisKOQnv;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA1606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 13:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45AA1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eisKOQnv
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a18fc7a38so3117379eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793540619; x=1794145419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4661m1xYP/jYEqHVXb2ZQHfA5Qdo4lmezgeOZnGqpSk=;
        b=eisKOQnvuhXLkFpTLtfmv29J4yIGP8l4y+CQnaDOTYY+ApcPlAkuI9OJbUqcBQazqM
         NGKpVY58FJd5KtwXwV7vqzHGC7Uo4fowQnAu3w/XfTq+YOj43laEFWiU+x7+QQJrrUnk
         ye8hz1U6Iku+8wJ1xBbiyyHtexPJdqQZOK879xmHeNb57yMpvfk3+HLNqqrN+EykPeoV
         Wk2BJwPkiZLUgeSLbvOAzK/ACa0oMRLy9GyCam3o3wLPUcvAjt26bMx+3j1LiuzRcSL1
         s6V1qqbVh//JrZi9xQb9lRm7UZFDEj2rMGSt3HNn321OUSHU4oTY51y0E4MAm5DjeN9k
         YTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793540619; x=1794145419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4661m1xYP/jYEqHVXb2ZQHfA5Qdo4lmezgeOZnGqpSk=;
        b=Ue+h8rM8CSZ4xsxLO2gK5569ekj4ss6SZWIef4NsJr6RKueHo2Ngf9jxAanfupaJfN
         0RDtlmhQwt40Ef/IT1rVBIKXv6hFoLnrIfWaa+aYsvmiIQcS7xerMwcOQ3QCbf6iloYp
         W3FCwovA08lPFna3CwBMSlP6HIk9vrgRcMoZm+NNSxBVM+1CGxn44kTGauE3ryUr+qp6
         NHMIIjBVHA5u9vfMPVUGwXi6oQI6Hfn3ykp1b4EkR6yNqCs6HF1dxwiDXIjZ/tsxDvDs
         KjrP1jwHay4MKwZBROOZDAL0DV/B2+x1woRq+i45rbMABAkas230roPkNx3HDfnQIFWl
         hhRw==
X-Forwarded-Encrypted: i=1; AKwUvBwRpmTxvMrE5gP28w1LgWptdZNG5qmFqQyDWMkcwSnquAIWtZfvpVznaBXc9/zlB+SCHXF5FgE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Q/aF8tqk22HD0oxv0j8aMKPbjlyU+Bl14uuuCdpd4Q8rJZEqT
	9f0gFTIC9sryHdChvjKq5uMOh/y6CNlZRq0qR4ITbGNgFc40m0FBLpcc
X-Gm-Gg: AYBFou3+vEi9iCAiwc53zhm+khG6AJjoAx4hCHIy3bbnJciZVqbZNJPaizvgcjBZj2I
	mKIq6vYuQCUe2s0vqc93hKBkIWb82kc6g+q3qDub9GnLvgG6Rlss3uFvom7ougr8WsQ7Ss6w5nW
	4dzjVWp2LfrTb9ErEocCtj0g7bD/LBCrdfN/l//osmhrd0Q4DQtv5WPdYd+VdzK8V9pn4vty2EM
	bLwg6CFjo2RmxAjnnBBBYDLvHE7U0UkxhJu+JSxqh6bpSsdxkhf/lcVg594bnTsJP9DKV5ioPkR
	0UgK0lfIzKaXGcERZEkZUdnzfFJkICtw7jBpAUU5SGtlU+ivUdYgoNV3P0YRCSeVxKQNlpB4e/p
	+DNvYpMr1leDet/ONgXLi2ruUdFWwMyivoa5eaY5CeFiW8CkinI20iwidHBmSson0dnu1Nu9kDf
	LKmdlrf3zzxFj3EuLjMo73pCpzdBSqsyHhJuO+vAt+E35NVk5M91tQVPOKgi9v3ticTiLfMwPrw
	GqFBJ/89Jo0xMZ1UdqGwUeYs/gmsRqlzEl/l6P1uPJcWlmjYUYBBbP8FQu5WezFgLEx8BKLaALt
	Whn4WG8JpXsfSNHH27e+7F0o2Mt3RpvXF7nt6b4VqVo/8g==
X-Received: by 2002:a05:7301:7306:b0:366:2893:7421 with SMTP id 5a478bee46e88-36a4235f6aemr11038645eec.10.1793540618755;
        Sun, 01 Nov 2026 05:43:38 -0800 (PST)
Received: from KRHW1CJW23 ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a98f65sm26717779eec.28.2026.11.01.05.43.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 05:43:38 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Luka Gejak <luka.gejak@linux.dev>,
	neo_jou <neo_jou@realtek.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Hans Ulli Kroll <linux@ulli-kroll.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: rtw88: usb: stop RX work before unregistering hardware
Date: Sun,  1 Nov 2026 21:43:15 +0800
Message-ID: <20261101134314.39340-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Disconnecting an rtw88 USB device while RX traffic is active can leave
the RX worker running after mac80211 hardware is unregistered. A firmware
event can then queue C2H work onto a destroyed workqueue.

rtw_usb_disconnect() kills the RX URBs but does not cancel rx_work,
which their completions may already have queued. rxwq is destroyed only
after rtw_unregister_hw().

Cancel rx_work synchronously after killing the RX URBs. Only a
successful RX completion queues rx_work, and no RX URB can be
resubmitted at this point: rtw88 does not set soft_unbind, so the USB
core disables the endpoints before it calls rtw_usb_disconnect().

LLM assistance was used to find the bug and review.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Changes in v2:
- Drop disable_work_sync(&rtwusb->rx_urb_work): the endpoints are
  already disabled, so rx_urb_work cannot restart a killed URB (Luka)
- Correct the commit message accordingly
- Drop the 3e3aa566dd18 Fixes tag and the stable backport note; the
  patch now applies unchanged to 6.6.y and later

v1: https://lore.kernel.org/r/20261028141904.8707-1-enderaoelyther@gmail.com

Validation: A W=1 build of usb.o passed. Not reproduced; rtw88 USB
hardware was unavailable.
Sparse C=2 and Smatch introduced no new diagnostics.

 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 64e1c3420e0a..56ca4496b2e6 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1371,6 +1371,7 @@ void rtw_usb_disconnect(struct usb_interface *intf)
 	rtwusb = rtw_get_usb_priv(rtwdev);
 
 	rtw_usb_cancel_rx_bufs(rtwusb);
+	cancel_work_sync(&rtwusb->rx_work);
 
 	rtw_unregister_hw(rtwdev, hw);
 	rtw_usb_deinit_tx(rtwdev);

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.56.0

