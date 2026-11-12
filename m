Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466584;
	b=jWwP2FPdbqeCOiwjSFT97ShZOr1N+XPqy9A3NR1hQ2neEJikpVw0bVRyGmfiqZiLkGOb
	 0sw4QOSFaRwrbqFqCtXO84AZyScSQV4LP41V8niOpXCwgkY2JtG2I0VXGbgnlr7zVTL0I
	 cDVce0jhFw1uRVzSMNiJY2rpr0CShm7Vbga1anyj2Z9ZV8I2QMnQny+Dp7+AQVT9nXpfp
	 zjRErObQfhcLFGOnkpzZ+SVnfJcWTr2q22ZCUXvEJFlGq8Xzeg7ssiGA9K7VNhWFL6qYB
	 Qn3hMVDLrU8tZxKsr1tDyAeeN3nUqrCgc6Fi88Br1OWCRuAYgWZ8OcKuwQQJKrWu/HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vTav8FAXb6nFTtunUSm9Oo3pbBRDYrw795godDfr3bA=;
	b=Bz7p2ICZg9kGlr+cW9cBAuxlPJHyT16OHRComyYMQTPRX/tDKYKsJ7se5rwArw2RLgvy
	 yU4x7VIXCQY5ZcS6kntxB2hqFoL6VQ9DPDKjI7jR/MC+V43rwdcCnB2LNe+WgCgfYOJpv
	 ZuFBIb10Imibv2SisoH/aOoMPaxY+WVNDCN4hqw1/4xvjlfnfXFtcosQf5sDI/rmsPf0O
	 9OdP4VETrZOZv62UWPmEvTCdzjjbjsQaqVgwLgDek+L8ZnuP8667UCtqsanV97T9ayApF
	 FbhE/vUP2osSpKu98vRtJNUFLhVGe0Kr5KgE7WewKka6UfVwAmMXsbZISDLPmQV5K5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UxyEoZuZ;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06594606A8B0
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06594606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UxyEoZuZ
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93efc0452b5so259589885a.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466583; x=1795071383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTav8FAXb6nFTtunUSm9Oo3pbBRDYrw795godDfr3bA=;
        b=UxyEoZuZZPTpShq4yKIoeWQVufiwYeT6C69K4s4wsmxpWWb29QQTHCwJBZ4JcKQ3np
         qWq9MEbtxFWwBGbxG+GJ2lJj/UDk+yRg4L2Ud4rYX6V2knajD8KaJDkv4yLyr6s9C9wT
         IAr2K/VZiMY5a4NBQocjqklXKnCDk2L7c3RXsuAWVKvFUmU35gE6V0rrTNxuDgz+6neU
         qbOt3i6kBYDqRCRqz7f2/OwUHLZ/tqp/4xRbr7U0SZTtCKzfAua5rqGYO6kjSx0VMkvU
         o8CFYrkC5zqMEbNUnylldLJhDH4Msnh55xEQeIf4WS7DbZBAOPEoyG9DU0+Ye6VwzbrZ
         UxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466583; x=1795071383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTav8FAXb6nFTtunUSm9Oo3pbBRDYrw795godDfr3bA=;
        b=MUmIXb4ibnpUgvV1J+0j1t735lpCfuu/MWpIXoozm+K5gaT4g6lwTy1wWhcUZvw8fP
         UgKwJVcYW+1OjShDRxCfZhkcg7QGNae3tRtiNHm+2vWk9Cb3l5f/KpeFcZhBeH4aqe4O
         vlWqbSaqqamCYUXUtrczcsxQuVrGMdvkQWRboCjNhguW8GateQL2i/ADzBQui22u8jpm
         9YZM3F4SIpA1UlBK+X1K0l+htQ65bwEgTj8O2iB8xK6ivBVtvwC/c4tJxZB9voUXwEmY
         0dZEGqqWnRh+X/ZiFYJ1DL9rUlhcNew8cWFSHSp/SM/Dfsqc9x4EVr4zqdfUy9B7d3Jc
         lF4g==
X-Forwarded-Encrypted: i=1; AL+hErG097E6NCJE38zhuB7U42Px2YxIPx9eie+cPJdQu+5iooSUAl7L2Ufdr1yn0qbzoRsf/hIOIDQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aklG3nXt93JNcYopVZkiKK03PIiclwVTiDCgNgUhPkhMtchWl
	z3v8Mm+eg7yUIio8PMTlO0VLnENdsgsh+p/sh91DDNM4/vSBsemvja0=
X-Gm-Gg: AYBFou02NnDlrmm8U88xZQtpszBYEGq0nBZxmv64xpB1A0eSWU7+uoEZNzHd2EqzJOc
	msi4IJbpaHfGlm2QcRSv4PZEcor5vdb+kaO6EMi6eZwvudiDcdFTrrpEBY0HcnkOijgp2YmyhLK
	dX2y1m/ln9Zky8mxnhIJI+RS2+njy+leOoRHMnT/hWd1JD7ElsLLyy92gyHEVO994m2DUHMRNNO
	3ouwPte5uku+DKvkuvbIhgYg2vR87ak7dODPEhle9pY2ZqhUqn2MzXRLJiJOQVhlfzT3t6mAqYY
	vj1hLujS5AFQxQM6w+py4hdZIdCLbAiFHUvdb5CAPwZNT5ccar7YGM9Vcr0UsIf5VeDY3HhAuve
	2zFrD0d0QTtg4KQF2TMKGN6kSTViInQRaHkquyssJYXG+jXcIWfqa+K8x2ZeRX+FNzFkzPglAY7
	UeT6gDsoBt1cPyembRNgySitPyPriJjjFpFMZP9Onkti0M4BIA7nPUG2ieaOo0jdKRZOwlYYG7L
	8ddRphL6tRWdQaEKYx+iYwmd5J8Fp25BHEyyTFXhwiktlUsRvDwZjSSk4JSfcMgqtR4Q2Hllt5N
	1Alz/+LUh7bfNhiuOkAUUGO0JICdQSRR75i9RCFYZlzc55vwdHzReZ6nAdgdM2U3swX/JyOcdKR
	MuXfJZl94JnT1gP0d+EK+q5Xq28/IiZDKpZu1psSHiLPjyVMWGofh2Cx//BkC5Xk84GWlWZHEOq
	RDUMHxQxa0+8sZyuW63DJ6l0L7pDXdOd8H
X-Received: by 2002:a05:620a:28c9:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-947affa6f31mr888523185a.31.1794466582945;
        Wed, 11 Nov 2026 22:56:22 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e784e77sm661246985a.20.2026.11.11.22.56.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:56:22 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: stusb160x: disable the interrupt before tearing down
Date: Thu, 12 Nov 2026 01:56:20 -0500
Message-ID: <20261112065620.34269-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

The devm-managed IRQ remains active while stusb160x_remove() tears down
the partner, VBUS, role switch and Type-C port. An attach or detach event
can race with partner removal or access the port and role switch after
they are released.

Disable and synchronize the IRQ at the start of remove(), before any of
these resources are torn down.

Found by a static analysis tool under development.
Not tested on hardware.

Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/usb/typec/stusb160x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index a2ec0565bd85..ec2f4d7f7ed3 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -801,6 +801,9 @@ static void stusb160x_remove(struct i2c_client *client)
 {
 	struct stusb160x *chip = i2c_get_clientdata(client);
 
+	if (client->irq)
+		disable_irq(client->irq);
+
 	if (chip->partner) {
 		typec_unregister_partner(chip->partner);
 		chip->partner = NULL;

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

