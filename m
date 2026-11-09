Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244918;
	b=3KTP5+rcVOgSgFC/f8id8+3rjAoB9/Q+4kmcVftI+X3KShEVqIluh8eD+Tj8wMNOlK/C
	 NrIp56kfIQngHaSHWLmjgM/kAr2grjQzqkAAa4h2GTPdUlMY7TNhcD/uAVxH9h28oUP+I
	 i1aXeN6v5pdmN0x3CnroLvPLQOpCGcwq6Gcufl9sGq/CxCnlUVqUSmiZ3hcoIy8xTFnQf
	 7mjYKtMrtqnKuRULgrnD5pmUbuoiJyUmQCw/NV7WsKbCtRD9HYXP+ggpX9qwQL8+6vJwD
	 PGS9LdHsq7QzMItYnrSHoeLV6IpXQM/vqe3Wxep9yFk7bf8MKwWxKiI95Zavasy269Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FylPiDKpV6Uqon3wL6seZPAK0gj8Jy6XAVftoBAaEmA=;
	b=mSzzHUj/aXk0WHOKnNIr5Khf40RyRXUoeNMwpVQy+WBvCC290l5hTypoEC0MaZG9gPgL
	 8K/yrXWDlrTi7txaaYzlIOHXDoIUQA4X1GjGADnKsBq5gF4HefpNJ33qfrnhlbAL4lTdN
	 j4TR9RqwgdRKYqO1qczOm3Zhulfqfffl2fqKr4lNTcinrMBMa7Ef3nYciUIxkcKjiBS9W
	 4TUxV2TlGvpTXaxNWwCZfAFJP9kojucTutS95iGpx9nHxB7pa6SfrCQvoY6i5/8H9Vkng
	 ge398euvP5zTgiZEaLRLCpFyiud9LYjrhUo3OELkzSHvy6QIRdMbQnoltQid4z9NeBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n7yNEmtk;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1A606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n7yNEmtk
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2761c69fbso1072604c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244917; x=1794849717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FylPiDKpV6Uqon3wL6seZPAK0gj8Jy6XAVftoBAaEmA=;
        b=n7yNEmtk8n5vxuOaeRSbJVx6lI/CuO5X5XDdQmZZliEOordOtFH2x6FOluS6ijSLqL
         pf5NUII/6sv8KwZq1oCs7gTwm8dl2e9Ng3MR89cpOJ2eQGLe0vC3LkNtfM7oDJo9i3wr
         hg58QGCEtJxlEIHOJrV917HR5gtoqIR6ZCTvGQk/qaTaqVQwK7wttRzY7q22nrn3Qz+0
         kMkk7hyDktGEwKY+fiMOMwEpg9QW/iYwuNgRlaVc5R545lBkGQoT4pcsKwXFKDiFoJ/8
         AZacfpzRQBvrOfR3oYC69mz3YjZnjrYQwial2gizh5iM1iy3YsQSnl6QTTMsETj7sKPF
         ZfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244917; x=1794849717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FylPiDKpV6Uqon3wL6seZPAK0gj8Jy6XAVftoBAaEmA=;
        b=PmDsuobWKDhKYQi+2PI7q/BwCWJmu3jd/jyM6PRYy4t+I+/C61cHdaPNzEn9EjfmVi
         5XA98c0aRlNJdj6l9pUNQf6dLm3gxyoHIQ2yhLwsbLFoB4H17DWN00Z0ml6PYwxgSHWE
         6acv4MIZ/nlZJHrfynwjDqH2dm5HIlcqg+Zs3GvN1d6LYoaK1UZcz8QzutObfAF1L582
         89PwhI6A6A9gErl0j1Gm5Cu1gT0H65bAbLxSoXTzO6Jh0iX/Ft+1Zj9AlVE5qL55nwYs
         q4pBif32dZYIqnbxaOq8wMqhJPJbTRfRnE4vYqoJUS3mCefePEzaSkjudNupea5QEVSW
         fOYQ==
X-Forwarded-Encrypted: i=1; AL+hErEifroaqefchTMIUbfmzvanjU/JIeFzjg1GVE5fgA+mLdjvTHh236tkw93v4NYrIFvvIAoZLH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+677l6o4lmULJfj84tNAeWMLUVTQIgv6ZLPxV9IP3IvKhYOEx9
	JulfO+iNJHlr29fTx5gdEG8/9uxgGTFB6MGTgJu7D1qXVMHVpZEfDkBg
X-Gm-Gg: AYBFou1i82B+vQI0xpsrWLeI8lZqBkV4f1NgrapbtiWHInc127s3vsUp/eCCgtFDWE1
	VmZ2eMZtg426LHOtBcifithm9odi4sAthgZ+K73QZZzKH4jGXXP/JSfei9wIO2ZxOKDa0thtzE9
	ipWaV0VqwzM7Tij6fjnda/4t7EugxMRh9xmrw4ieqMuYXaGW7nV3Jfn8p89TiEkDlJPwBxuzmci
	zfYPkL1LydctQs/ebWpq6607jYhW3Bf4rT2uJM+r1apEu4UZMfpxaNlNVAfYICwymO751JmUmeo
	jhDQ7mLlwRQHbSGGVAceb1+5JcqIuMWXJirfkE8rDABFm8NDZ7fdy50rBiuHqRR67Zergeps3IJ
	kkf11OTe4uW55ooI74ePC3csiYRzJnlO8G2Y9Wiiphd2F7nh+QUaH7GhPee5+xgPnZDECMiM1lL
	7m4T+Me8udAr/pKrDTW4/6GgABFsouwhCWINVUkXoktzAgP44qu7m7XrGdxLZf4kCxsujpZ1OPT
	bJ9d6qzNl5la99Lv6LMZx7Phx9eY0F5XSEwripew1GmZ7hOe192g28wodJQ+FMUiBaRdy9QQSCr
	u2hF5ESXxkPRSKi9/xGMbB9bXe9UBGBtELGb6LmBy8oKEJtM
X-Received: by 2002:a05:7022:3f0e:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-1b3b6054c2amr123720c88.13.1794244915328;
        Mon, 09 Nov 2026 09:21:55 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm364288c88.7.2026.11.09.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:21:54 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ASoC: rt5665: cancel jack detect work on removal to avoid use-after-free
Date: Tue, 10 Nov 2026 02:21:44 +0900
Message-ID: <20261109172144.1851173-1-hj351016@gmail.com>
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

rt5665_jack_detect_work() runs from the delayed work jack_detect_work,
which is queued from the jack IRQ handler and from the jack-detect setup,
and the jd_check_work polls button state; both dereference the driver
data via container_of().

struct rt5665_priv and the jack IRQ are both allocated with devm against
the i2c device. The i2c driver has no .remove callback, and the component
.remove and the .shutdown callback only reset the chip; neither disables
the IRQ nor cancels the delayed work. On unbind devres frees the IRQ and
rt5665_priv while jack_detect_work (or jd_check_work) can still be queued,
so the pending work then runs against freed memory (use-after-free).

Disable the IRQ and cancel both delayed works before the chip reset, and
wire that teardown into a new i2c .remove callback so it runs on unbind,
mirroring the sibling rt5682 driver.

Found by static analysis and code review; not runtime-reproduced (needs
RT5665 hardware).

Fixes: 33ada14a26c8 ("ASoC: add rt5665 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 sound/soc/codecs/rt5665.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 0000000..0000000 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4837,9 +4837,19 @@ static void rt5665_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5665_priv *rt5665 = i2c_get_clientdata(client);

+	if (client->irq)
+		disable_irq(client->irq);
+	cancel_delayed_work_sync(&rt5665->jack_detect_work);
+	cancel_delayed_work_sync(&rt5665->jd_check_work);
+
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
 }

+static void rt5665_i2c_remove(struct i2c_client *client)
+{
+	rt5665_i2c_shutdown(client);
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id rt5665_of_match[] = {
 	{.compatible = "realtek,rt5665"},
@@ -4865,6 +4875,7 @@ static struct i2c_driver rt5665_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5665_acpi_match),
 	},
 	.probe = rt5665_i2c_probe,
+	.remove = rt5665_i2c_remove,
 	.shutdown = rt5665_i2c_shutdown,
 	.id_table = rt5665_i2c_id,
 };
--
2.43.0
