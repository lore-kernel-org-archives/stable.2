Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466582;
	b=Ab2GBbH3kcVQeImoHAnUBLgo+VNOixxYvfv7Qd4+/VKtcKE1DpyGJ4Y38bAdMOeKGQnt
	 GwTH7Yzm1H7M6z/rMU58ORRozbwaqhmEWDOv5izBDCbsqbKcsv6DyW1X9vntc+5rESiKK
	 qYC17tew9W9E+opm5ZjlG92zIHYgJEJ+vTR1NEorsC9OtDeFIdwVSwa6E7UnrV0a4utFa
	 jS8W2a0niova8fSf4b66xQVQYEHket5hLbOBRqaQLKZcpK+w579esicD1bTeXi4040ho4
	 hmZQT4R8w39Jib5IQzdzyKj6oz0SRjyPEueIeZ+lLBCDunYgpZtJbJk1yjs/SnL9FCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZG6VhCuHtrCJJzccAUt7IJkMQXU/fhnJBTGZBLb7Mhg=;
	b=jaRXCbgruezMaCr0oyDGm/MiRRHAWnRTLmTDJx7mGu37NsStlTzALRoAQ5D8Kh9aFZUj
	 2Kgf7LKtOVwb1HdRHhNn30tLgwhmTmQ8BtEBz6vdEOrQtGaO9oA9cXOPfTAy/18btu3JQ
	 zc6mcw2ZFT1voBpblrO0Dxha+vVpKflS/pGSdKLQziYxcReOEjiBiErAnar2lZvtT/Mau
	 TLAUUD1n+TQRUHBt+gHZwQQBwN2VS9zJJi6O7MdBhbxR2uDRxS+jLGbwL7QoKvg0wSnFN
	 fo6RF65BuvUHSLGjKgP9GN41Djhg4jjHhCEhxuSxaV04GDwRg2XXW54u5NYMWl5OQLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfrR1tH4;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF5606A899
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFCF5606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfrR1tH4
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-536c8f958d7so30611721cf.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466581; x=1795071381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZG6VhCuHtrCJJzccAUt7IJkMQXU/fhnJBTGZBLb7Mhg=;
        b=tfrR1tH4wMon/iJLwE71zZ5ygcvlIRUqDsKCDxPD8+nXPK+7SbGjbpUgB4ux08bFwR
         kAedk4D1uytudKaOMM6K9vzrVi6TLbJ5GhyrXQeYI2kr4NcdaR/5c25OG+YH24qo4fUr
         CJ9dmIBr2gUuhlrPGg/3BUkOwNKoiVO4NHlC+Znl74NmN8uKi88uQ3w8HXwgrGyZD5vD
         jvIMF6xlzSNGLH8Z8sb8gNdNVzlC3rYRQ6QlbK5iUxajt0f9WYdv2I0zkzNtgxtovI0x
         4RznnMrCmGIK+8Jx/YEru48Hpp9cV5P+05YC6Pe0Ks3xVgudX2sabAVlzHwPYGEsCv1p
         MQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466581; x=1795071381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZG6VhCuHtrCJJzccAUt7IJkMQXU/fhnJBTGZBLb7Mhg=;
        b=p8m4r/cJd3iohwBmHt9WbDNye3d3skFynSzHTfdzFEN1d8knMoBXE7z81uPvmoXeNj
         tSvLakwA5uGtl6EiugwuyXkYOa7PLHTSl3WSHIQ/CmQuCCmznujV827cw0tQMNAjtHYj
         Tw1CWrwpeMo3ruBByVA/GMDw1/V9zbVQP6sqF0qBCrVdmtKGWem8L+MuEPniJzHXhfSY
         O5sMCHxKfVWkgOmLmMmgBNqY7r72rraHDxJogrfB3zAQ6YnSdgBYkoA8WEfho0r82QtU
         cOlzxOG8yPY2cyAHSoLlXpgZuXz3jE1ckmvqYCHr+/IuE6Taqqrpv5CmcB57cmAQUkMI
         O5bg==
X-Forwarded-Encrypted: i=1; AL+hErERH7X9tw7CzxaXBp1dlF2hFj03PK0txLNPnqOVnYB0Gg4yV74KPp/rNHs0DT0AujFinGSJ71c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/d6IZrfIW5gmHHw+8evg+91NaU4N6otvW7HWlZv9Q6nDtHuRr
	9rS/QcFac+/fjrPKTrtG1MaW1S041VEDEXuSZ6T6jeTj8BHuTHfz4D6zgpGx
X-Gm-Gg: AYBFou3V1j1Fjlr9XpQsNxupPzzATjB0m4s4VSSZyWkODQALUeMThq/IQyZ/q/w4VUO
	+sdhcynLK6UjduNbpl4e6IoDB5qe2xcUiJ+3yEuOjSEvoaAmDB0/BOL/WZP44eSCg7Vx/1jpglg
	W4PW6ohioDZYRExOvislj+Bz/D9qr36npIxriNbpL3ndxiF4eo4lk8t14Sek1hG7Mww0rU4+cJL
	bXC/s6goxriMw2D3WcTXhJsqWTn6K4YhJzv6tHQIMihpTJFtu9khKeb34kjjmabNj527S2PmUMI
	NzuLNNl6rXH7JWybCxmUA4kWJeTk/KLp+6yZGQ0jnpCOlRSmgVQoYocp1miq4iowzeClJyIyTyy
	TkbNFkovLnCjr2V7ukv1/ltUkJhtUR3Upz4Elup0iku7FcNedP1prr2fDTYUQzZZDbI4W+b9MaI
	RpvTNnjYN3AE8if8FH7DNLu2SF7yhqxVl8m0fqkx3LOBYogQnhPLtgU/TWBz5snoDHkmKoxtcbw
	TiSOiZgIAQn11gAq2OJkSd3cq4sXS1CgpvaX2XcSPlVTP4dAj2JLHhaXwJeONw2uLXf3OYQMv1l
	BCJfBIv2iMgwJ8rwo08IRhUWWP0BRukXOWHIGGgIJTl5zQIdtOwzis13QM89+UVZG9hIY4wD8+1
	tkKpFbpchkI+sNjTiOVR1py7tRkhQBwHAHk3ymcdEbCUicVJwLMx2zmAPQy3HF8OmeQ4Tcn6tiA
	2WDU8Lo5HeGQKMTJy1KM5jMV35eFr6tNGS
X-Received: by 2002:a05:622a:34b:b0:537:8400:ab71 with SMTP id d75a77b69052e-556c04f78bamr79867681cf.39.1794466580744;
        Wed, 11 Nov 2026 22:56:20 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0318890sm63824076d6.4.2026.11.11.22.56.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:56:20 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: ir-hix5hd2: Disable the interrupt before freeing the rc device
Date: Thu, 12 Nov 2026 01:56:18 -0500
Message-ID: <20261112065618.34238-1-mhun512@gmail.com>
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

The devm-managed IRQ remains active while hix5hd2_ir_remove() disables
the clock and frees the rc device. The receiver may still be running
after open() or resume(), allowing the handler to access unclocked
registers or pass a freed rc device to the raw event code.

Call disable_irq() first to stop and synchronize the handler before
clock shutdown and rc device teardown. This must also precede
rc_unregister_device(), whose close callback can disable the clock or
reset the hardware.

Found by a static analysis tool under development.
Not tested on hardware.

Fixes: a84fcdaa9058 ("[media] rc: Introduce hix5hd2 IR transmitter driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/media/rc/ir-hix5hd2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index f74deb408218..e6770588399b 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -344,6 +344,7 @@ static void hix5hd2_ir_remove(struct platform_device *pdev)
 {
 	struct hix5hd2_ir_priv *priv = platform_get_drvdata(pdev);
 
+	disable_irq(priv->irq);
 	clk_disable_unprepare(priv->clock);
 	rc_unregister_device(priv->rdev);
 	rc_free_device(priv->rdev);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

