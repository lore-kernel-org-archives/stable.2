Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178132;
	b=S1gODpJPppjIdPsZ2vsssshii4IJqyVj5jtYw4kDxFd+Hif33rwPanYYKq7T/n+asJVZ
	 jlsGzC5jQ0YHLiL5PmA7QwwyY3rhOzim2eSOnAmmABXWY34xfR7Fyax38aHAexP6Q951D
	 /Pl0eh+zXdgy3wA8VY8YZYmylknG8Ytv1FS90I8NnNsVt+i6zM4/gTyHnKuiDnL7ruqvS
	 LZChiAwRq2rNz6XlReMg6LiWxFpjHTAeO+JdIwOkV5cJgO6EejFtIY4r0JHEd/QQdMP/S
	 dQ2h2Q4ftVK1onpAhQWBogpuFMLwOkZO4SrOmJcBI5cM7iu2Gi10aB/AQp/b+qo+Ylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=3bI4CTK0ibSK5GiKKc2cJRvX2UBB1MrQ+kYcnJge6oY=;
	b=1IrUqS/Q2Mzb34MSyBxZcTvks3tTv7e7W3cxO9am54Xk2KG2dZwQs/PyoMciL7JMT3nX
	 QAOZQW6TUtYLMHxiihU+3uqnXJbKtP+UFxCjWom0pJA71WuXdqz2GgJAihIwVqpP/Da99
	 SRIUBvsvvspn1cTk63tY0vJOB2CAoWUO6byU+Pm9AyFdQ1cWHpH+E5wb3F/719yWWLDwx
	 i1xvmbalB089N0JBUpx5EvmH0L7A2tNnousi4s/LmRi75zfxS9FZw14gmPDv/aG9qU1Kj
	 uFigz3h/ZqNKypJ9c3S9yExztG2+tGmn+uyEmvuNgdLEFUkI6dKc91PE9qHqvLNIcgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xQZxFtP5;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C1606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xQZxFtP5
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f48d91ba7dso143275b6e.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794178131; x=1794782931; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3bI4CTK0ibSK5GiKKc2cJRvX2UBB1MrQ+kYcnJge6oY=;
        b=xQZxFtP5SDxqO3Ghrn8sQ6P2ZLxpry8nrmAlesZdNno0KD0xsv+L5HXRftB3Op7ao0
         rGEyfEMmhPP8SAgv03VaxGGIAoLVnbvOpn3wFZfvptQWjY9655gCzhZpKKhbD3X0BYvZ
         wsdz7MFb4xHsIciqZgpiJgXh+indiuMermFk0ikOEHzc7xuHbuNz/aHqtvRDepiIhnAR
         2ZOJtFQ82zZ1Z/wc9qNZh8DKnZlaBebTpc2WuJXvbRhYEFdIpnnvOb3S+hX40odJTQiQ
         iUtCtfkwsPM7sV1pEtzyb/PFb0ygVZmQpHBv4LXBGJHYqWCSezXx0YRBWuQQ7eSK11og
         s04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794178131; x=1794782931;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3bI4CTK0ibSK5GiKKc2cJRvX2UBB1MrQ+kYcnJge6oY=;
        b=jBI+MA8myQ97WmH3/XIiKPi/wtPrmPIl3dFlTbKSz86p0PzOkwtUBhVefAfAGJ5Sv5
         QaDP0lz5C4zysGNOEB/n2oiaLAQTwklP+KwIIaCsF4mtiSaH2rwvK+wIoHILVG4KUTcs
         EDmI0ogDOd0oB5aKJb/iTEJyhl9DMI1EDM/9cLB8Dx+CVuaKIO8austuhS4QkTHm9HjE
         AhikFfy4Z9zZnP9fWDx7dKeYngCHEkNc7TLP2KnaPacOObyzSMEdNFhTKz/iGxdgvoGE
         pmyuBOtvmpoeIBR+IzZskOFMjzVK9WkaoIbM9Jw5fQG1q8e2edXy0ecKwosooHZVeDF4
         jdLA==
X-Forwarded-Encrypted: i=1; AL+hErH78jnVuMqhuiz4ZpI6V7phWCLv8aZK54bdMeh6uE6tfTHg5VFSpHFeKkj34jY3r3KA5VGDG4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xSQNnG2bt8YkC1DAIFKhrGrAwc2Fg9bzsf2cyQ6/Tx+F9hOJG
	vQXRgVK/g47uhTf0srnOUvsWmXvTnFUWoa0j4Rhw5OVmgBxmiASdpt3N
X-Gm-Gg: AYBFou37RfoA9QPgIFbRLqpAtrDrsyvTx4AaK509tZOYzz8qgK4JPzx5Kio2lgconKd
	AB1UbGXczu4yOW59/y60Vn4XxlhIpUSWQ/YIQY7zmjhFgy3NZhvtmB8zudaLuPtE9POBRCnpcCP
	KEI8/PCRQuAnBy9jutSd4p717Ycmsh1JC8gHb+c7o5jvU9ajA5oiHcApl4gr7L3zqYG30rvCdTb
	UO8i+Qmk4rq71HAH3iMUIz6VAsLpC5BTaR2I1DYjAxT27r6HE7oh36Fw7KLI6NpSu1YA9eiyedu
	Zb9qvUPJ0rzw+tx4Pvr68x6odrDuFBjRPJSbkDSOkHPt2vlmFl4H7WKqlDcE/d0bVVyZJl5VQ1z
	5FE2p6aqYrGWJDzrpiaQsAQmPHDGd8Gd5MPtAAU4o5Nf7zfNxlZdsYrEGyNTOCSizAy3dRByIkj
	cBJzpmGiDSit/4w6bAsUwCypwgLse6PkTcwxKAFkNjiqSQfkNeHbr9TDcmK39hRgOgVzB8wudUl
	giIKLU41Lv/5WH7Ixf1swtoybfunShBuKOsJisQgyhVFyDwzerg4n8DTnoUftJXvj7PXrRyx1JR
	jjmdsf5njsKRFfQqUjhh4SDzbnPy5kCDIJtKBeaG10M3fs2EmQSxZcdUoIhZZMG52CdvILuPjnn
	kBAOb4SndP6k6550hV2Z/lyztuXeW5qouSFpX9pBe3iIroXCx91+xj6Y83Rz+CLivycJUXPPP64
	tvlwYjtYIOztP6PfNPN23Ufonz5aVi21bl81xx73GL1UexqCnpCwc=
X-Received: by 2002:a05:6808:c1c8:b0:53b:11c7:2da0 with SMTP id 5614622812f47-568146ed248mr1427843b6e.21.1794178131013;
        Sun, 08 Nov 2026 14:48:51 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813c71b08sm2885540b6e.3.2026.11.08.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:48:50 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:48:48 -0700
Subject: [PATCH v2] mtd: leave the device type unset when naming fails
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
Message-Id: <20261108-submit-mtd-devname-retry-v1-v2-1-09f576bcc51f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ7CIBCFr2JYO1pA28aV9zBd8DNtMUINILFpe
 nehvYDJzOK9mfflLSSgNxjI7bAQj8kEM7ks2PFA1CjcgGB01oRVrKa0aiF8pDURbNSgMTlhETx
 GP0OiwPtGSYa6rVpOMuHtsTffjf7odp3jT1SxIMuHFAFBeuHUWKxMPZfdU/k+mhAnP2/1Ei2c/
 5rkoSDqpuecqetF6/tghXmd1GRJt67rD5XGa4j4AAAA
X-Change-ID: 20261108-submit-mtd-devname-retry-v1-3f7cb2ed8083
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Edward Adam Davis <eadavis@qq.com>
X-Mailer: b4 0.15.2

add_mtd_device() uses dev.type to reject a second registration of the
same MTD. It sets that field before dev_set_name(), but the failure path
for the name allocation leaves it set even though no device was
registered. Retrying registration then warns and fails with -EEXIST.

Set the type only after naming succeeds. The later registration error
paths already clear it before releasing the device.

Fixes: 6697dae1e2da ("mtd: capture device name setting failure when adding mtd")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Correct the Fixes tag to identify the commit that added the
  device-name allocation error path.
- Link to v1: https://patch.msgid.link/20261108-submit-mtd-devname-retry-v1-v1-1-a67f332c54dd@gmail.com

To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 491a27d0315f..4f62a13dc481 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -798,12 +798,12 @@ int add_mtd_device(struct mtd_info *mtd)
 	/* Caller should have set dev.parent to match the
 	 * physical device, if appropriate.
 	 */
-	mtd->dev.type = &mtd_devtype;
 	mtd->dev.class = &mtd_class;
 	mtd->dev.devt = MTD_DEVT(i);
 	error = dev_set_name(&mtd->dev, "mtd%d", i);
 	if (error)
 		goto fail_devname;
+	mtd->dev.type = &mtd_devtype;
 	dev_set_drvdata(&mtd->dev, mtd);
 	mtd_check_of_node(mtd);
 	of_node_get(mtd_get_of_node(mtd));

---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261108-submit-mtd-devname-retry-v1-3f7cb2ed8083

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

