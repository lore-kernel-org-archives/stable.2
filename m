Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177193;
	b=DL5G9bYsGNPs3uDTEmPXppj3ZzS7cKvBzcUH3mlfZUKK9DxUsKfYi0U0bwFvLQ51xu6Q
	 2gmOPN5Dc+1Wg8PGK1VSJby74qLDDxXB78+K0oGQ65bNyLJrvifYd2yUV3xlutP8i2JhC
	 LcCa5dAuDHYAlxeSHlDd3ANlHRVYDoerjO3TloNsULGfj6zZQX2bxoGglGR4B8DjkOitv
	 qQsy+xTR+PI9FFD3COY2G8lKOBNPF0+/LqjNz4r598CN3CTbNFmCpC4VcCipgD6GUqLfB
	 vhfaF8pxWneOtvaeQYF55YHhjEIXwQ7Bk/N6+PLvJ4VsSYQAjycVtgUKBAC9lT/f40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=PkdH+wEUMUSeDLAeSoZy2bnkjMkJXd9IxOdgSs+yng8=;
	b=r2gGSQ/a9AoyYqu7huEwpcekurGidAHCPXhNgam4DUdZPhS2v9v1SvSh5/jg7IWiIw27
	 rmoa+2Kyx2i7lsRgn1KhZmdDKb0Q2SwlLboDMiZWz+GEvQ7u2ldWGQnMQskZFKxhtj3B2
	 lWVaEyvWoq/8UqyZUEA5hXZyIFIq5DOto5FERzMhEiF6BD3zDC0dUdhn0yh2vEOaKjleV
	 rs5yzxF7e9e2bBt6Y18e2VwZcfV0oj/eS4P48eQChPa6bsajclg0yC80y4biSAXO7SuFD
	 iwNLif7baqek8hPRVqtDQjRtsJR7U14565+4AstN7P29pqlrlegRetv33Yu/35YskGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umCAbGL+;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B9606A333
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951B9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umCAbGL+
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-48ed0b68895so192403fac.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177192; x=1794781992; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PkdH+wEUMUSeDLAeSoZy2bnkjMkJXd9IxOdgSs+yng8=;
        b=umCAbGL+7eK2RSXF3PTPeizN2u4fnldl8IaFPRWXZIv/kGAY5sLqwglRyGbID2YvAN
         /8cx18GwT3pMgPMb7luW1s9BWY88rgn+CvKoocJMIlgqMZeo5FGdk3lP+FJ3cY1D2B/n
         jJKmzUjV/RaYyBq3enqyfcj5iCYx9Zn44c0rGWnwX5n//vVqnVrQRoN4a7PW23Hj8Fdi
         60bjHtbGXSsW7LYIz3ysO7lOBTHc9ooaOYDTOd8WzynPtx5n6eCyc2UMNwS3gK6IaOY9
         +3qXO10txO/kAbkPyA9uKfPSVXgzuJgnTndbEmPhNIvgdi5tpiZXCZEua/EOOdDc8kjA
         1VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177192; x=1794781992;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PkdH+wEUMUSeDLAeSoZy2bnkjMkJXd9IxOdgSs+yng8=;
        b=I5qaEhFF9wRujsLbxdxwLPf4imA31WK+spw6T6sk1CXCvWwbpuAsr09Ii3cN31qn+w
         NdQSO0ouL++Kvb0gD2PLnu+lY3GGa+voqU/TC6Ov+8vISU+kjELBP8GS8HeBNhcnpiMC
         yLemyS6WpaFEnNkBp6d1EerTsXvwzhfeMuekRO91uemk48A4D6huRA6KzS6d60HCSJ41
         /uxLIR4x59KjtD1W944/lWHL+KRdzp7r1p/y6RohUmxehirrdLOgPkMiTfrVvkaiH7Tt
         vl7PmDwZfMyWDo+Yq4qNRd5Q1l0vbWAk18Ae6sqsHRS7wwMyorlw1D1b2q+F60FMH+Z0
         cCZA==
X-Forwarded-Encrypted: i=1; AL+hErH23j47YDq0Aq/QyACSG6VL3RuyqNjEZpf6dcID/PC3fNE9IzIHyNCRYWf1vycjr0e4tDMnQ+k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b/WWDytVExpzKH9mI/hCd6QoxttESI4u9YiKI96C7tWPdus4l
	F7IHn8t2tSbNtSy9cT6KUtBTha5HVWL5YTELV0eMzZpGbVkxcX6zot0TzFwS6w==
X-Gm-Gg: AYBFou2t2mPKo9LHX9viFGOuub2TGr8F+yOxKFo2ih5hVqMGLGdHM52jlMI+pWGVLhK
	rr1W0Qj5ynf8IxCAJ2bT5OeZZwsFOo4HTTAqslmcqMcgVfPxJBIVGuTJ+v9fJ31EWp5LNDMDWLY
	/pX3MfFtO46TGhCXWU/27M4cCaj8j+HMhhd+l/QEDHBirfO40HAUMQPSc04cA+0as75f0zT7IUB
	LMNjXybKP6PwbVMGKzabOs7W9s2waQ8YWWAgttwwAkn7aNhRjV8PWqPGEbx2yq63AIAALsqLDMF
	76EocpyVNXh2o9HvCQQqKBTAzgrW/dbuXXg7eX6JbTAgj4PRX92Y0JwhNLxkjj0IyTOKyz/8SmL
	o239Mvcdl8CrrIeWeFtUxPxZcONIJinHpUp43iQV/wGLw/EI/opNaPRt1gD0N2aXkbUymIhWhgG
	aYEk7L522KOF/9PAXZLZ/iPp0CZoAAWw25Wi8X9cevR3oYn9/NpulcMSJgXk6D6Btp+B/2scJcs
	rYXKf+vxdaiFqbZkSVl1faSmBYgHy6FSQzEiywkSaHNKBv0TXeQgIsxbHxL6Z6YhrEOm7La1RgI
	cqjmzhP/XyZ0DUeO9oLYSUrI7ma6Hu4BjT3RxH8ylKi8Jx12D/gA5SBeu9GeBfGuMt+RbYfNNj3
	oZsTHIH6kVxBealhWrrrqxcWFEc2KMzpsJ1SC9UPM069SNoP98mscDI0XfH8x/hncfns0KWVzPP
	Zo+JWi1kQ4clTqA0h+E7RJICIRLD6RvK1a4IkmE3HrXByseJJeCH0=
X-Received: by 2002:a05:6870:a414:b0:48f:e3f5:c41c with SMTP id 586e51a60fabf-4adecbf500fmr1245207fac.61.1794177192413;
        Sun, 08 Nov 2026 14:33:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade6a326fdsm3563668fac.17.2026.11.08.14.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:33:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:33:04 -0700
Subject: [PATCH] mtd: rawnand: macronix: preserve OTP operation errors
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
Message-Id: <20261108-submit-macronix-otp-errors-v1-v1-1-8f64a2ad5a10@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqDMAyF4VeRXC/MKsxurzK8qG2cGZhK2okgv
 vvqdhP4w+HbIZEyJXhUOyitnDhKCXOpwE9OXoQcSkNTNzdjaovpM8yccXZeo/CGMS9IqlETrgb
 r0badbe+m8wGKsSiNvP38Z//vArzJ5xM9F4NLhIM68dP5mnO4ipNyaMtwHF+SDBugoQAAAA==
X-Change-ID: 20261108-submit-macronix-otp-errors-v1-0f83783917cd
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The OTP read/write helper replaces the result of enabling OTP mode or
transferring data with the result of disabling OTP mode. Successful cleanup
therefore hides an earlier failure. The read wrapper can report an empty
transfer instead of the error, while the write wrapper converts it to
-ENOSPC because no bytes were reported.

Keep the operation result and the cleanup result separately. Return the
original error when an operation fails, or the cleanup error when the
operation succeeded. Still attempt to disable OTP mode after an enable
failure, since the failed command may already have changed the device.

Fixes: e87161321a40 ("mtd: rawnand: macronix: OTP access for MX30LFxG18AC")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/sashiko-outbox-204080@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/nand_macronix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 03237310852c..16847f28b19d 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -377,7 +377,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 	size_t bytes_handled;
 	off_t offs_in_page;
 	u64 page;
-	int ret;
+	int ret, cleanup_ret;
 
 	nand = mtd_to_nand(mtd);
 	nand_select_target(nand, 0);
@@ -420,14 +420,14 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 	if (ret)
 		dev_err(&mtd->dev, "failed to perform OTP IO: %i\n", ret);
 
-	ret = macronix_30lfxg18ac_otp_disable(nand);
-	if (ret)
+	cleanup_ret = macronix_30lfxg18ac_otp_disable(nand);
+	if (cleanup_ret)
 		dev_err(&mtd->dev, "failed to leave OTP mode after %s\n",
 			write ? "write" : "read");
 
 	nand_deselect_target(nand);
 
-	return ret;
+	return ret ? ret : cleanup_ret;
 }
 
 static int macronix_30lfxg18ac_write_otp(struct mtd_info *mtd, loff_t to,

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-macronix-otp-errors-v1-0f83783917cd

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

