Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597820;
	b=ylyU66QyRwoo/0/qBGDmLsfueWudoKT/8CpzOloecyVdKnAJZXrRP4pLnMnHhZ09x30E
	 NVl2w0BBcA2OazZ5dbfblpBatqORYCqYuGITDA2lfrMeYUnBgR+bbJ+15OezPcsswLuKc
	 Rq7TgUB1atcmE4fod9y7r7OovbkmUnLfdewopv+mnpmxDO/vm9NjUWTT7XD1BUeI37aIB
	 lrT+485sTc7XEhV0bUBgxaQvv+36DfPVuEVHsI8tlY27COmwdQHFrPVS0sfQfkMR8Vv1k
	 hUqEMPt/UUIPqBelLZod2f8l4IGQ0tsbe6txATNb+rci7D8pxzM22my3GCmP74lGj9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7Jp81/YwhVY4mwNzcGG+yudpq87Dczt69r71yvv/Ao=;
	b=Hb5xZi4Cl54xwnkFHhSHxKMw5GYIf50NsiE7QCbQDHakdyGn3us75MSacvZW5NTSIcyr
	 mhSo7mS67Q5TOclNxBczXN/9NqDgI2QqM30nXJlaY07pA1g4f04fjIXVYE6VK2kZjC+0B
	 bNPZYVZVQ5uIRTNcEjFjqbiQXTn3Vw9/J9BZJ25PmMSD7h/gxo0Az+N7xVAvC3DA0KD0H
	 DE8zvXGGnegl/65N+y39iQ0Z+5ulDWwm65mqvEmzjJCf1zYvnNduoYmAgTbvIICJOglXP
	 tHW8iPYOMj8qFUwDp0Tw4/ugA+Vv2mQ7KkTq1f6Rr87vOpo63LZ0dCC47JVdphuLYWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9mhLm99;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D9606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31D9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9mhLm99
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06e79e152so2678291b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597819; x=1796202619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7Jp81/YwhVY4mwNzcGG+yudpq87Dczt69r71yvv/Ao=;
        b=u9mhLm99dVc1rA1P6PDjbILqTqzAD7xN4ouRsDyOT03MrVA/AeyoA6KunG2NYM0gDT
         ll8knTQjsI9aOc9VlsZnhh3cg9lHkXvChnNxrnyRK5zI1DDuH7JBv8QYUzo4/8k2QVNv
         eDqld6wz9XfyWcZHCFnn0s5yGRd2VLRXCumHRaz9TjUsQfEdTjYbp490bjRRfQjHZOdZ
         faM7S+oTWv8CCOXtvHVVBNWtaqth/JQq22kFIRNWVIt4IVCrmtjY59/60tLaHWnJ7D0f
         9gY51/ZgwFKDIKBZrjZ8N45haYmPiV5yivy381EDWPlQ4g7F4X3yS0o+b0Ld7W6ESz1W
         6UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597819; x=1796202619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7Jp81/YwhVY4mwNzcGG+yudpq87Dczt69r71yvv/Ao=;
        b=DRITOT71Qb7trnFLYAGCpJ0IRX06d/8chph24raM/oaG8aFJ0mT7aHInVBngL6kM0i
         Jahsf5xnN8uYj4CplAtnaZR5m0xSZC4H9gJbk92zyKQY509acIK4rIoxdb0ZODQvmDNv
         NlwM1sd4lzqQt0NOfQ8gxDfR7AwXh1H6/2EIbVLQvXXzsOHlovcIydfh5pQ2bmiWPwxR
         1Pz4zWjzQM2+9vcCzqUTu1k0wgv4z4DR75GMSOtkaxkp7l/vMk5wUorO+gTFRE7eJA58
         JBdokDwtxCsSur0cBhdza0Cx3fCLhfteBwnKnMHo/SvEGL8Z6k1apwSrznsylGwn6s9H
         dNqw==
X-Forwarded-Encrypted: i=1; AL+hErFXs/F5rXgwrZvID7k8gWOsf2KIN+3sFD+WUmu0fl3IAqvJ6ZyDHVHRr7YSfJvYURbLlNTOW0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jJf5CHvanbHOsk+aLuPleRrOX1X6jJlWWg3zwOCzCT3Q9fKBp
	kFV2nDgooauhrM0jdn8hLHoeVFIjC/vtT0N3beY6cqCzz+QaUoNOvbmJsNK8AgM=
X-Gm-Gg: AZFdTZeGpC3BkBmP7+SpEA/UfNQ66w7VCbD4ratIWbbZ8j/AKYt1Fs1Y6YbcfO1T4wy
	R4QZUrxE0Oz7nm8TXJsScOGjq8FJuGoNndswe95rZl7M85+lf9yTJV4g7b5mBJV8OkvoJIqH7Cw
	C7eP4sWRZASE6Hhm8ZVsSTJnbQMce4S6CsJ4Q8dbiSGrtjf5jahfz8I/Nm6245mXbML5E3yqX8i
	NEw1Uc2J80BXqW1qM+sGFfMuTyFaw7XVcz1DJKD8NCIPi6ckipL0d0kphW8B3/lv6BJ4lVIb8Qg
	Pq5va0y0cQojucGuTB6727SCBoojOD3MiGFsydZ9+4myXRPGXsqdggSTS0pvG3JRgzO55x/gtDJ
	rgDFC2yI4CPChNsLJ6cd1WUTKWZfMKAnMRKLhMDFipJRm4EgvdA2fKyIxByHVQnmm3cA4Iie50w
	uNdZqkM367pdirhpYuaCjmQ0h/BaT8xmQPIMvYBVuXj0P1ktEkZFV8tDSYiQhPolqTxa/xk+4lX
	i4O0THm42UPxMbAoon+XsATNtsEBW+iJHEQlf9awoCL28t9fuhOkEonm9eRMcySOBWGr6hKakt/
	+BoC3Yu0UzVHkyfPFBtOl8GUrNFodyMfHakURZGwL9LHKFRNaesvOfHojUQSbmHAVo/q
X-Received: by 2002:a05:6a21:4d8e:b0:3fa:10b3:c8f1 with SMTP id adf61e73a8af0-4014d25ddfbmr15219804637.41.1795597818828;
        Wed, 25 Nov 2026 01:10:18 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:44a2:4377:d176:9ad1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc613csm8456765a12.5.2026.11.25.01.10.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:10:18 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rtc: isl12026: Fix EEPROM dummy client leak on probe failure
Date: Wed, 25 Nov 2026 17:10:00 +0800
Message-ID: <rc-b1-20261110-vc-22-300211a8c5a0@gmail.com>
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

isl12026_probe() registers a dummy i2c client for the EEPROM at 0x57
with i2c_new_dummy_device(), but only isl12026_remove() unregisters it.
If devm_rtc_allocate_device(), devm_rtc_nvmem_register() or
devm_rtc_register_device() fails, probe returns with the dummy client
still registered. Every later probe attempt then fails with -EBUSY in
i2c_new_dummy_device(), because 0x57 is still taken by the leaked
client.

Use devm_i2c_new_dummy_device() and drop isl12026_remove(). The dummy
client is now unregistered on probe failure, and on unbind it is
unregistered after the devm-managed RTC and nvmem devices that use it.

Fixes: 4731a43169b7 ("rtc: isl12026: new driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_RTC_DRV_ISL12026=m, CONFIG_RTC_NVMEM=y, CONFIG_COMPILE_TEST=y (object only; no new warnings).
Runtime-tested in QEMU (arm64 virt, KASAN) with this driver on a test I2C adapter module: with fault injection failing probe after the EEPROM client exists, the next probe fails with -EBUSY on 0x57 before the patch and binds after it; unbind/rebind and module reload are clean. No hardware test.
AI assistance was used for analysis and patch preparation.
Needs a probe error after the dummy client is created (allocation failure, or an nvmem or RTC registration error); no in-tree DT uses isil,isl12026.

 drivers/rtc/rtc-isl12026.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
index 2aa3694c4de7..cb12a6366fc3 100644
--- a/drivers/rtc/rtc-isl12026.c
+++ b/drivers/rtc/rtc-isl12026.c
@@ -453,7 +453,8 @@ static int isl12026_probe(struct i2c_client *client)
 
 	isl12026_force_power_modes(client);
 
-	priv->nvm_client = i2c_new_dummy_device(client->adapter, ISL12026_EEPROM_ADDR);
+	priv->nvm_client = devm_i2c_new_dummy_device(&client->dev, client->adapter,
+						     ISL12026_EEPROM_ADDR);
 	if (IS_ERR(priv->nvm_client))
 		return PTR_ERR(priv->nvm_client);
 
@@ -471,13 +472,6 @@ static int isl12026_probe(struct i2c_client *client)
 	return devm_rtc_register_device(priv->rtc);
 }
 
-static void isl12026_remove(struct i2c_client *client)
-{
-	struct isl12026 *priv = i2c_get_clientdata(client);
-
-	i2c_unregister_device(priv->nvm_client);
-}
-
 static const struct of_device_id isl12026_dt_match[] = {
 	{ .compatible = "isil,isl12026" },
 	{ }
@@ -496,7 +490,6 @@ static struct i2c_driver isl12026_driver = {
 		.of_match_table = isl12026_dt_match,
 	},
 	.probe		= isl12026_probe,
-	.remove		= isl12026_remove,
 	.id_table	= isl12026_id,
 };
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
