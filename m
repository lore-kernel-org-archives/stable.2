Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070490;
	b=FdC7LMBamqARlzI/lq2Q4gVp04+11XGrZtH55VlXc1sq/8APsEDewxwXgGv2aSf2P3Jm
	 2qKI7o1qtzRWbURzij2c1e0fD1bctAvGJUgNajbF5Ed8smCW5OJEdxjr1AyhC6OUmkTxY
	 QVwf9Pk0mjudeCwNUdwixjUxPet4IkNQ7/83CNKsokp4qnnzvYoJqhfklL0vlO2NXqUJ6
	 AJJSPaiPIYMseWk31lMW1rqs9kLD9Dl6olTJKoIkktO/MzpPaXiM5/wHabtY7bkLggChS
	 UK+O8gLch6gj7BOFFnRzs4aJRgLP7MjCmCLNTePMXHHhr5BuyqHyckpDw0KMDAiUtXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=igNgupZEn7aKjw+PjHHDoJ6CuNjmPliTKlApfHrxbJo=;
	b=NSNuCsKefjIRsomgcK4XcWODq+nnGDIjTAGcjO+VzCBGi/t7QWD3v1IPTIzBJPNr/eHo
	 maqiB6xK2jAhjpxJOiGb/u8IF+1c053saIdzUh5fu7tRUcX2ikMKFPOl17EDYUm7XrO7B
	 MW/707oPQ6KcurAMC+rGeQiA74BGHKnUYx8L1y6I+3MvGRD4V+ZddzxSyDIP1mA/by49w
	 U+oE24lOeYCLETQ7IVsHRZtui7M22NV9UFjZYWOJmmVhZFBG33rx4d0h4QyAfn1gFiOc8
	 XA2iv06F+ZakZbktWIcAaGDfK2w/H1xjyicAUL/WMP/mMh17ktLd+ov44RwjtvlWGiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T3mmvNcK;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF2606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADEF2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T3mmvNcK
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e987b4a710so2194705ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793070489; x=1793675289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=igNgupZEn7aKjw+PjHHDoJ6CuNjmPliTKlApfHrxbJo=;
        b=T3mmvNcK8/rhpm5cNcIOD/CQ5n59Gin70ROvTsrk7xbOnpt/692Iw6ZohmPlR9U9ZU
         +0AEIaXN+wLqA2Sh72WSFc6myjIbFm6Y3+5IfL/cj1DfRZfzwwgkYrSnZPPH4D9jKO6J
         4fVjbYe/bYW+IfC69xgKyaK8ZC8hyOuOKHdGl8reeH6DsjS5L2b1Ow2bZDkS1Id0kJlZ
         Al7XyCuT7vOhk+GSVN5JjrMWG8pAVhEZxCBEjlfhdYGvs/bHF2AAhpuZu76cJDR9pnbm
         sxrEfmaauC/b1VucXRe2JFNa5xoJvenuZXFqKWuOMwFTQNHSavPCJ6HaBvqTgYRwbkOR
         vVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793070489; x=1793675289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=igNgupZEn7aKjw+PjHHDoJ6CuNjmPliTKlApfHrxbJo=;
        b=ZUyyHgrckC6HMstFiUZFTI+MLbfZNxZZhEheP07lYqjQR/HqxjdLZpWBduIU5Fo7RF
         Q59izfPco/bZFz0zK+dIvfYoC+GB6Awv/8qrA90vl7EbYyBqf3FRVBwwgI8AwvMM8Xan
         +Ei/dgSuPJEcTTWfoGUO8Z5DGcqN6JOZmW49bzDoYvdoU0LvYCGuZRb39BGq40MRlJCB
         Gc4Nw+cIOUUmFH1iJoPTZrQgF+1FGUtxO9FHq0CXBAETXxFKQCIF9/4o7FmILXV9TwoX
         gMide9kgazlo0HzENXOTt4NAbfdz6bCf8PLEl23ZPU+je7bDCXC31/573BAEeqQXp/Ai
         YXcg==
X-Forwarded-Encrypted: i=1; AKwUvBzX7aZO0U1YqGn9AQfSz6in2lJvbhhp/W+Jf9xChenwIc7uJ4teuKEnwHQs3nOl9816niisyE0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIylroxRa2Waun6FWiVBGh4O26n0k2BxKDrVxvxgxczqLMdy38A
	VMXE2IR10F/4DFzU06VKTrY65DharNlsCySFsGF3UgFQUdIADFl7LY4D
X-Gm-Gg: AYBFou0Zzw8XvPbXcJoN1Z3ZAS7bEUJcgkeeMjsjI936BAJbgVSsESKsED6d5jMP853
	RjbvVszz9akzexZgHh+aBUMcGEWA0LXagwEDSsgbG+ewJn2HZtUlC7JuKSv4oGvqedb4yNvzuZ7
	dtxCXyrvEcIntK6/ClhsUoLwR6sQZpBOIWE7nww+2+WEuOQPMPar1dbKSJWGCV72hm8xTtLdIEd
	UMvNkhkNXKFYZyoFxHEPZ9fE+2SozFVBCt5IcjXxcv9FybREcDeWEmCy3wbWX6sUDHn0dFu3IZr
	BJKmMKXbxuGbPXgL7CtzZ+9Y3TEzhF9xjyhmP83Bgi1+myTecJ1T3e11jvqY3uRXkaixuJI0PIf
	wwhE3eQT9+TEGoGF329kGP2J2dlvsERJBBRAAZxSPk8tS79LTy0F8akLv7jv9gHMpEgkVlHNYtO
	0vF3TaUJ8Myd9AMc31ppJuayMwLqNx0Xvp7ikfT624KeUQlDWm1dwHNpqJErwgBOgy0mrZE8F4s
	LI3LJMIr+vRa37M3CIGWqPOe7z8E7KZstqiTwU95642h/OV63YJ+acQRsz0Hotp/hRWzshmz/IU
	QYOmbDr/YAX6Cz4Iq6i6IRYOJ6Q=
X-Received: by 2002:a17:90b:3142:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3ae40268bbemr736527a91.8.1793070488963;
        Mon, 26 Oct 2026 20:08:08 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebafacd4sm5767362a91.2.2026.10.26.20.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:08:08 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: da9150: fix IRQ action memory leak on removal
Date: Tue, 27 Oct 2026 11:08:02 +0800
Message-ID: <20261027030803.118131-1-lgs201920130244@gmail.com>
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

da9150_remove() currently removes the regmap IRQ chip before removing
the MFD child devices. regmap_del_irq_chip() disposes the child IRQ
mappings and removes their IRQ descriptors.

The GPADC child registers an interrupt handler using
devm_request_threaded_irq(). When the child device is subsequently
removed, its device-managed cleanup calls free_irq(), which can no
longer find the corresponding IRQ descriptor. As a result, the
allocated struct irqaction is not freed, causing a memory leak.
The associated IRQ thread also cannot be stopped normally.

Remove the MFD child devices first so their interrupt handlers are
released while the IRQ mappings are still valid. Then remove the
regmap IRQ chip and its IRQ domain.

This issue was found by our static analysis tool under development.

Fixes: b8fce55c09d3 ("mfd: Add support for DA9150 combined charger & fuel-gauge device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mfd/da9150-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 5c59cc869fb3..1b6dbbed60e7 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -474,8 +474,8 @@ static void da9150_remove(struct i2c_client *client)
 {
 	struct da9150 *da9150 = i2c_get_clientdata(client);
 
-	regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
 	mfd_remove_devices(da9150->dev);
+	regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
 	i2c_unregister_device(da9150->core_qif);
 }
 
-- 
2.43.0

