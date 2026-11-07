Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063038;
	b=HkiQEnVjM0PSlFDc3z/dCt2OUhKqdDOqKl7pXwrnnHWmTfkviUEVcyPvlq1J7TMTqiJo
	 W4I9oc65oFpHWQoZrGLbPehIVal4u5NC66bQrOPi6p3wea7pXQ2m8ZVKjk75fSEjgyzwd
	 ggQM7YxO024fp9A8pNihrwnQiQ1XlC42HyTVBybgKuoXq+7DXYNlJjNKAwNIRrGE7z4Oo
	 F/Pizhw+xMiby675jjKp4FjATbze6qF9v679F8XlLN/6Hj56Swv/PADP5Hy/E1NgKibCx
	 bJD1o0k0aVcyASlDkNr22HhEhb6M09zTdkUbbLFoXEhedYOufrAnDlbQwsNF4BB2S2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wae4+lr9g9z2uadKIYhnawrpwms/uihzaKeb+1TSuHM=;
	b=KI0EKUfCWKJ/8EtSiEqav7RB4h7rdfWbIna0iOvmEsR4bBU1oAihg+qfPhTv38z+4GxD
	 0iHaImmpcju4TeSySg+pCC5kSVKN7c91p80EbzjndlxsArGoPPNAxvp5iSg7CjvEOVwjz
	 3CpS36M0R23S5VaZEqT7D257ZV/kwd/QPzG6ED+D5P+buwKwMA/bZBXpsVztuWliaWbpO
	 gt39lxGwArcgFfQZE7G1/qkYfxFnTXi3V6EVZj0PuYMioUpAHGL8rsoGDuEL36LNgH3xH
	 G2bmkPbkcA0Ez+B4AuXvDuJeh4SjfjVH955NcxlpDecZkAP3NytEn4xzb9sDcqiP5Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzW1D4rp;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FE606D806
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 861FE606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzW1D4rp
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2492604eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063037; x=1794667837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wae4+lr9g9z2uadKIYhnawrpwms/uihzaKeb+1TSuHM=;
        b=bzW1D4rpqqnOrb3vsNFhb5DTW95O08SqswKmvfhfySuSdgX19/bskdFL2KSEVEWUWL
         80QLoZIPdsm8fy6NKgHVevW2gUd4K6uG3HdTzLvmW96pYBPcldWbXfVtcgYMbmKL6Q7E
         dXr9hb20mwtth71Z6mU4EQ5rwkxoLkOhcoluYH0ScgXwTqSfyHxt+qYOEVI3Wk90y/GS
         a9EagFB2gSQVh2UjPSpAadsXSenYmvn+RWIj3lRSo3Y/sF/Jp/el5lG4PV9/Ghw6EZIo
         6Hz1A+hG92rC4QbYrCLHV3U/PXa7205CEMNDv0kgXb+ZV8bMD1CUADKR7d1moDCPxS28
         DBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063037; x=1794667837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wae4+lr9g9z2uadKIYhnawrpwms/uihzaKeb+1TSuHM=;
        b=kA3i8NeSG0KkUeTQ1QbexsA/KAzeYYmlJlKbzdQku68nU7qBObtPY9SZDVA8k4TEpp
         QZMYaQrDjrhA4mWO7/8BacPmLnzBJqueDtqZ4jqQbaZXw1VtVKjZT5cAAnv2WsINU862
         KKu5syaSoXgY8WX7GXSBGeuPtVR4tI7SpxI1AGItIA4Djz/ZVfaVyAupSa6jOMlogZuh
         6Z6dF8sfPGGnY12uPXkSKOuTGIEDXuBZPPSq1ARNZMTzMKAu6+LIDdCX2p/veV2PNUYS
         pznbGLayVI3fuforKAGNtMhDR2oRoF5GzXoO0zbiTYIpQqj/Gh6p2wQBDb/imO7Ab7RR
         zZMQ==
X-Forwarded-Encrypted: i=1; AL+hErENdU0WNiyvukRIP1AkLrIMxsWtVPq9+wGU4tMw2/9g/vuH5BaN1E0qpiTybgzTLYWn6HcT83U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KNnvm07B93d3KSaPivvAOsKs9td60Rhl+UctXgJPUwXb/RsVX
	ZaOxeVKcf+EmIVxq91c3/g4PtEuOU0/6AnemWjo5pbEaBrlvS9WPx3E3
X-Gm-Gg: AYBFou0ZTFaR1Do1yW4N+o454TUsBlk59Fo1KLwO/nOqosDtsxcKUx6TNBAzMkjo0sD
	p/iPpTqUONYVpGp6nS+ewMupHgmP8B9jlWTtx0EypIUCJXk5FXhTXj/3hPMU9Jn1XQaY3X2fRzW
	DuN6UUzbrK0f2lPD2n8v4rWmYMha6tp8wJjwh6hNiRl6BE+gIrEmOeirEi+mpHzYoK8z6fbDpjK
	SkNEU+wZYdNqw5c/TGk/Nj5hTDfH4Bg+lcV3hqQMZzlfH08ESyLYYHR4vepCZhLIaFUCO+4mL/E
	x7ReFceO+7tb7RF3nb1um+afWLmnh04FivehBCDKDxgI0X3rTkHqfa6E9o24oMEJoPChNgA9M1/
	kZbKb5qlPX+6LI3DeJyMYimu6VCN3dtOhJa6RAOOV84tX0qeihvMixYQeY6wbMj6Wof2RBjZbTP
	ETwRfV6Olzpeyt2i1s297osE0PSkEsEmHJWTisE3KUJaStvVKJV6RUwLOI2hnnqJxw/gIJoE8T7
	OTAnJU1C4dbnE7b+7hYVEhtJtpGBgLG1E4d8WSrysbtTDODhoHS5TDHOVZruXKvbTI1AY8yHj+v
	Je5GWJ8Ay74EbtW2m6uEVz6Qj6QTa/X0mfPQimZ7625Xk4j4HlwGMjNe47L5iTQ+bJHFQg==
X-Received: by 2002:a05:693c:68da:b0:36c:a0d7:e4ea with SMTP id 5a478bee46e88-36f729cff49mr7699920eec.1.1794063036532;
        Sat, 07 Nov 2026 06:50:36 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm15787371eec.9.2026.11.07.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:50:36 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: sl811-hcd: delete the driver timer on stop to avoid use-after-free
Date: Sat,  7 Nov 2026 23:50:22 +0900
Message-ID: <20261107145022.3734911-1-hj351016@gmail.com>
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

sl811h_hub_control() and the transfer scheduler arm sl811->timer
(sl811h_timer) with mod_timer(); the timer callback dereferences the
hcd-private struct sl811 (sl811->ctrl1, sl811->lock, sl811->port1, and
register I/O via sl811).

sl811h_stop() deletes only the USB core's root-hub timer
(hcd->rh_timer); it never deletes sl811->timer, and nothing else does
either. struct sl811 lives in the HCD private area and is freed by
usb_put_hcd() after sl811h_remove() calls usb_remove_hcd(). If
sl811->timer is still pending when the controller is stopped and the
HCD is freed, sl811h_timer() runs against the freed struct sl811
(use-after-free).

Delete sl811->timer in sl811h_stop(), after the port is powered down so
it cannot be re-armed, mirroring the existing hcd->rh_timer teardown.
sl811h_timer() does not re-arm itself, so a single timer_delete_sync()
drains it.

Found by static analysis and code review; not tested on real hardware
(needs an SL811HS USB host controller).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/host/sl811-hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index b044977..53a0bc8 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1520,6 +1520,8 @@ sl811h_stop(struct usb_hcd *hcd)
 	spin_lock_irqsave(&sl811->lock, flags);
 	port_power(sl811, 0);
 	spin_unlock_irqrestore(&sl811->lock, flags);
+
+	timer_delete_sync(&sl811->timer);
 }
 
 static int
-- 
2.43.0

