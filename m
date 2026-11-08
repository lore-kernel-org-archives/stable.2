Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172300;
	b=es4RFIvphmofu9OAaLQPIabUaOoqt3D1plW2SXrslBBxsVVQNc6HpqL7WlGZ8uQ3HvW6
	 pcTmOQYyOiM2ePJfYdDJPsEH69ioxYSiUmFF6UjfezvrAwC1VRdDjysGBLPPyubrnqy4Y
	 jbDwjzlafn8Sqh43To03YUmYCaf2zp+Msj2yLZ5OacJQKo4IqEZEGfIk6Tygr1jWqrGA1
	 T5G+rK5rjCayVS+GuQkdw6vkwY2Ba4AcGIteQfWBWH0TETetA44SY4CXATJo+VQ9rMwFR
	 Bka+IFhmqqWwYTaQpx3/u5VW/PI33mfa0W0X1MwYL7fuJ9ph+wshvabyGvdpuVBrVjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=/tM7Th5heSIu0EjehKmDLLPeUVpt5UbMkUrc5jBJaHc=;
	b=RqrooRA8CT3/rTU4eDcCSyVe9SxT3oAg1WOaTqemdld/Ex+QHstinaA0jpLJVA2LAUZK
	 xV1PeLh5aW7XzLsmIGfOgs9xlQjarYthYuhWtdwnhC4hv1mX9D1fCZYbZcdz9FtmSMtNh
	 IHY8dg4ChyYDIDQBs4syrzKMtK4cfjFBqbPJ1qKfCAntIOILKBU/jtYJEkuZYrqKyWxcu
	 AIZv/Lk96Mu31yWhK9mCXVwtQZO9A7P644vhUS7ykM5g73pz6nMCnjvTNtkoNzKh8m1zj
	 WLXbsWuxsCsFzbcoCuxsV65B1ZxFeZBVb5hcZXuSlXuOL1yUWc+dQh3jqS3yZ58kqyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbVzcdn9;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A2606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E8A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbVzcdn9
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-717080a2d50so201564eaf.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172299; x=1794777099; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/tM7Th5heSIu0EjehKmDLLPeUVpt5UbMkUrc5jBJaHc=;
        b=kbVzcdn92NzR3ioHuL7Zysi4TmV2lBIZPG7EFR60AOfU6xCcTAn0sSs95LOm/VzAaK
         YUUB8F9dBl5v37jOk3MrVUCEk7zC44pjGveY41UTyGkM/hATte8flR6iArHQkwewiSi4
         MnG8lgJQxGUNHvgWBAq/xMTjmQ70j/mdhttDzzePGbSYrBtoO6bZgyVTh7hgaCeGpUc4
         erLDO6SM9w/dDpRRt6KmlW47VQhEDteFapTYVoBdBpTt3NXOwBOm4vuDPezjGQPBhQLZ
         YaTuCXtAIdf14dxGbDdeYe306hErmERh+W1KMDMD/RPTEpcCjhap59bzH9oKC/BoeGaw
         Y2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172299; x=1794777099;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/tM7Th5heSIu0EjehKmDLLPeUVpt5UbMkUrc5jBJaHc=;
        b=BU5DFlSJbBPDDUpAywa2cBP73HDwdtYh/4EMf96jK99/JpgRIeUiJ36JtQqczrJif5
         Bd0y4jzgc+M+EocyGKv2sXu2j09bcgTnmq5B+4dChD/ZxwZ1WxM2KO/A774BwFz1/yfY
         9747RJBgxN4YyUhF/jW8P7mJ9Y9lii1/KfIVr4cwzWVzfUaurMMGrnyRYI7ppTS7drKx
         7K5rU1cZSA+t/Rcx87a8pjma++EimWmeC99yw6TLcjfVwj9IOmP4Iy7kX5XPLB1Lg8CI
         N6nOttT7GFxau6ndboJzWY3AHV7OmcUdq61gD/5d3IEIVtgchCuJxEELQR9IiLzX48x4
         sIPg==
X-Forwarded-Encrypted: i=1; AL+hErGwoLf/M6pGwT+XpDNeS5wsxYRE5DzTdY2PYMo1cE3m2ErLQtnWO2ZTv8CwHIDfzAjFVhSXNwY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cEtZS3cR1lhIuR1KSeFHQUCTUg8VGZNqd+aCMrVskY7R3h4WJ
	9wYu2G4XGY8TaMJcS9zQwtT15DqKBxvxXX6DsXyAicQqCTd+9ygygc4/
X-Gm-Gg: AYBFou3AP3aKsx+N6lDCOgVcgmZV1Ob6X7iQ+inBiu3dwqIZiFGWItuIcOEs1i4O4MF
	F1A2ys/x7SAPRCwIqC0y5IFnGYIX10Ve9zinuJXmq5ByHyGtgT6MvG1wdfGxnEm9ZsgH4Ips7a7
	9Np5Uc7ib9m95NoNjf0X1YoJFCeCuXM9qDnlejYlrVdTpz0aptuXI+07lZobvXvefynB730rbUj
	0lsq5DxjY9+iqwv3VRR6WpEsQ9so9RKb7lm19n+U9p7sjCRffAGlMyEiVSp/gmlD/0HAgAvtFiG
	Gw57UhUD4hWB3+rg4yWRQUkaeYIh6aGp7PQdyWbqNMdeTfQ3Po2DisfGbHN+A0gIlfqnhWPB1dk
	gGSxbFuQz/Du4WIPyPOR7IC5pyf39DrslRS/6XJ8cu//22zysfixPhQQaIl1nT65FzjkejwBfli
	NPVhbsfZrkXp6zju87d51ArLMBk06ro0gdp4YL+jyKzixqNImFF2VYiPCrtYErhMiQN5JtK4AIQ
	/htg64g7ecspGAnO4ald051syGiGHLWRK2Rzkkymonl2fCGyu1URSBweVQtckD/GUhyzyuhhxsG
	IcpTXgLpKu8p21Zk8oVIrbpvbtvH2rBLYqLHyjND1Ua/2ssGpnxKdisBm7LRr+rZ1ZJpVzFeWCz
	p2fzl/PGDEQ614+KtnwVUHgNqawiAe3+i97q05jKjanxWSH7eetSrqxHXc39GYBuknRieGSqvHa
	rOSqN0UE8hjm1V93S9NZqho3eG8GD/K3koRCO91So/zFQyr7yGiVw=
X-Received: by 2002:a05:6820:c2cc:20b0:716:d70f:1c1c with SMTP id 006d021491bc7-7170f30f0e9mr760112eaf.90.1794172299437;
        Sun, 08 Nov 2026 13:11:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f5e1e93sm1970733eaf.0.2026.11.08.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:11:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:11:37 -0700
Subject: [PATCH] mtd: leave the device type unset when naming fails
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
Message-Id: <20261108-submit-mtd-devname-retry-v1-v1-1-a67f332c54dd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQrCMBCEX6Xs2cUmBQ2+injIz9aukCibGJTSd
 zexhzl8w8y3QiZhynAZVhCqnPmZGqjDAH6x6U7IoTHoUZ+UGg3mt4tcMJaAgWqykVCoyBerwmk
 +e6cpmNFM0AwvoZk/f/v1tnO7P8iXruwLZzOhE5v80qtmPfbsr237ARH9KoSfAAAA
X-Change-ID: 20261108-submit-mtd-devname-retry-v1-3f7cb2ed8083
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

add_mtd_device() uses dev.type to reject a second registration of the
same MTD. It sets that field before dev_set_name(), but the failure path
for the name allocation leaves it set even though no device was
registered. Retrying registration then warns and fails with -EEXIST.

Set the type only after naming succeeds. The later registration error
paths already clear it before releasing the device.

Fixes: fa06052d637b ("mtd: Convert to dynamically allocated bdi infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
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

