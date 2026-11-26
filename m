Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672617;
	b=yodHWptAmNCwXp6UJ2b4gA349cSRMw7f5ytn2O6IevKk6yQULGC/tx+chLwrRdpoQx3F
	 WwfsEIHIsKwGLm93bTS/liRWNHLqHzEaDxLcB5LDFeZ5XWhIy97EFIeNIeNTdsh1reV3D
	 mHShbS1rKf/k2GJKg2VlsrHLrBO8S8+FjL3bzoBAwods+xN5wo6LepyiInj7oYHiml1bS
	 /zJBRY6ybszh5iKCzpCyU6zRtGaHSvecwr4H5z2anliPH2smdy3ckF1uOJJmaOs686vGy
	 vOSIoZa3UZ1srOkRLpmP5wclQ4f9+iE5L+RT8tq2wh7V3nw7jFqljBl+53SnC9LteDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GaDF/oabtnPz5CC+z3Y48KsX5H9ec5sap3k/VVqc69M=;
	b=eESqHs2L8m4R4J4BA5gDbb+AqaebU9Iwgm+3tYRu1M+lMKefiVSAa0+TgYGfWrXhcz+p
	 0OLbe+GcL78wqvlsSQwkDHDTLsB+/v9Y4pIXWejGM0D6evnvuj6H3cURKd3LGjBsdR+6N
	 J2Gh4YAcK1ChucimlrJUtTQWUOzMWBJzSeDi6TRm/rSOkWxZgzYtTLh1I7ftycrsTFpc3
	 8RgQAJhCBzTz8+AAbYprXfFiSMpLya2yIqvZiG7LhCjJ68fOxEuvHdh5qW10BZ5XF2QbL
	 BuWw5TJRaK5KtwdAvPelOAg7sAlWrHZJxRNAvejNe4sUQp+RfeYbGivDmiHS+64IhfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ggdGyTHK;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D86606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ggdGyTHK
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3866a784546so9065431eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795672617; x=1796277417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GaDF/oabtnPz5CC+z3Y48KsX5H9ec5sap3k/VVqc69M=;
        b=ggdGyTHKICLNcWcMun1QBSRIj+w58Q8fDLAGuRoUVpqWwEYcJl+IxC0paMlWlrjzj8
         LkGy2S/7LOjq3cxbx+Gx8CPb9F24aCXiSNacF5N/VuvMLIc1qGO7kNqUEymVtJSVrYrJ
         btK0pCq7u4HBVGSiYT9T3NV7J1umh28GUfrkEpmjYVo8itfIZXcSOcfu5jRvnrPrCy3M
         7lsAwtRQ5AoUCgB5yL6MD+Jf0lmHeydBFXU5tefO9XjUv6B9bArbtDfpndnB0S5UwVHY
         T4ppcVXwvo82LuNSccQTzYmIEw9SH3NGX0WteqaLndZ3Rlka/hL03DlUiqyvgC8n3w1e
         Hqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795672617; x=1796277417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GaDF/oabtnPz5CC+z3Y48KsX5H9ec5sap3k/VVqc69M=;
        b=TQmJoswTgoH4yb/vRLfd1WiCEAsoI6LPK/szKH7Wx1Uv7x1JtbdZ42Nctah3kstiG4
         737/BeN1PQCgXF7crfm2lZ+PF8CoT7fgGuVcPmfG0kfYycPycAfOxbZZmza1UER8I3Tg
         Dugfu0nvGpyg1a6ry34PvFrV6VCAvBBQsHsfpZwX3t2JHvucQGttXGKVtnzEAwpD1XSo
         tkpGmT6Q/YWGns+cGm8bO5ZZY06sInpy7vHjVUEe0vKlGnNrquq53TEIpz3usx1MHck7
         876bEPJcoNr4T1stUvx6O6i+oYmEymRUr6uSI2fNO23tJ7Nrtwinb46sUjHpUe8iubHw
         7WFw==
X-Forwarded-Encrypted: i=1; AL+hErENmMmZ6LYVmTDn6T4n6rrcjyogDC9ps5NI/K4cyooaMjv0zwAAxitngQHB/3GATJzOnBgOVj4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YRwgbIaIns4PwNYYTrnNbTDTXyIR4yFYfEu9sh55vffNDqQTT
	kbVnK1iS2g8WOHF1nXt4vHEy2ZpjCNOqhtsVZc/CSqhpFNFpxBoV4VQ=
X-Gm-Gg: AZFdTZcCAChz+TMhfv6550Ce6iueEYk7dCqEcC5p8Es41iUQe/KBcL0vzgedVNcHT8B
	joW2jPOZVS92V16RZcuBYIC/ipXbyIKerHBFu0dOiFd2pYUfKP8holZOxRwGCmWMl2zTO25Yiif
	y+dF7iOcVfAw+spc7kjO/TeQCuSO3pPL5j6SLiHGIKZWMSVb/dX/n9IJUFD142W3kCjPokHFS7z
	Nn00rLCoN8TSU65OEXd970ZZhn/aHQo4O0NwiZJa5wn4TOn52VL+FoGQe2KY+NsSSs6IZaYqvUt
	q6yPc/jdF/F4mwbSEdfgldhoevtqfbKDhGU9eqnN5bUcPVhny/feZ2Wknv6lVMONo4SdGDjvjs2
	JLMwga5xKvVh2g+5jHVeu8oYGq+tyV+yJopUz2fFm+wo57Fo+j3B4u1XMfjUrObQpJKuobX0w0a
	10//gubPg5kfGBbCPQMfnDGmwM3mMpDlT7rAmyBXAtpXScBoakEb2lL0wC9CIAoR2A8bQPusLXM
	ojbEUvLWXISVSgv5PEngweencDopLBIUIy4CvMisfyRqpDWCe0ETOY0cvS5P3fNu+iQilmcKDF3
	zPS9/eLIzHRIg6t5HzpoHeO9t9YWnQWyo1Iq20qULbz8W9MUKt4hXtF/PEn9CqC314g=
X-Received: by 2002:a05:7301:4201:b0:385:b8f4:755d with SMTP id 5a478bee46e88-385b8f47ad3mr20537639eec.20.1795672616579;
        Wed, 25 Nov 2026 21:56:56 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm57523404eec.15.2026.11.25.21.56.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 21:56:56 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: tvp5150: Free connectors on probe failure
Date: Thu, 26 Nov 2026 13:56:51 +0800
Message-ID: <rc-b1-20261110-vc-28-73976feaa334@gmail.com>
X-Mailer: git-send-email 2.50.1
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

tvp5150_parse_dt() fills core->connectors[] using
v4l2_fwnode_connector_parse() and v4l2_fwnode_connector_add_link().
Each connector then owns a label string and a list of allocated
links, and each link holds a reference on its local and remote
fwnode. Only tvp5150_remove() releases them with
v4l2_fwnode_connector_free().

Every tvp5150_probe() failure after a successful tvp5150_parse_dt()
skips that release. tvp5150_mc_init() and tvp5150_detect_version()
failures return directly, and the control handler, IRQ and
v4l2_async_register_subdev() failures go to the err label, which only
frees the control handler. Each such failed probe, for example when
the decoder does not respond on I2C, leaks the links, the label and
the fwnode references held by the links.

Free the connectors on these error paths, as tvp5150_remove() does.

Fixes: 0556f1d580d4 ("media: tvp5150: add input source selection of_graph support")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2, W=1, CONFIG_VIDEO_TVP5150=y, CONFIG_MEDIA_CONTROLLER=y, CONFIG_OF_DYNAMIC=y, CONFIG_COMPILE_TEST=y; no new warnings versus the base object.
No hardware or runtime test was performed.
The path is taken when tvp5150_probe() fails after DT parsing, e.g. a DT-described decoder that does not answer on I2C.

 drivers/media/i2c/tvp5150.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index c889624..efbb588 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -2158,11 +2158,11 @@ static int tvp5150_probe(struct i2c_client *c)
 
 	res = tvp5150_mc_init(core);
 	if (res)
-		return res;
+		goto err_free_connectors;
 
 	res = tvp5150_detect_version(core);
 	if (res < 0)
-		return res;
+		goto err_free_connectors;
 
 	/*
 	 * Iterate over all available connectors in case they are supported and
@@ -2232,6 +2232,9 @@ static int tvp5150_probe(struct i2c_client *c)
 
 err:
 	v4l2_ctrl_handler_free(&core->hdl);
+err_free_connectors:
+	for (i = 0; i < core->connectors_num; i++)
+		v4l2_fwnode_connector_free(&core->connectors[i].base);
 	return res;
 }
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
