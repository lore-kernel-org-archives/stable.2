Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379286;
	b=4FOYiFXK4fuYtzSyWjll8GSR6/+QQPvny7z6htdd6KmYIiD84fVuwKhDx3qeBg6Jv6TV
	 ctCyAjtK+eupClDHhZ36+rEfFokk4IQLOLktCiCgZi1rFCjB+nX9O7TOldqbQeZvugJZv
	 y6LXAEDU3+VNaEj2sBYKeDniFim7feL2QmxVVeXaUIS2VK8cUb1ZPXXva+PqL3aj9WlW2
	 FWlx09nwBB2L49z7p0ZO+/F9Tle3hqRgfIyD3EGbKnV4vjY+4AlTxUL2uunIVNnXCpaKY
	 g1WXxmOd0Ja7U7mBUpdRSduf3TTPuyLCe6aviFP3amgM4ZATWnbQ09+eoPl6JlZYtGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379286;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=fNE2eV0m3D6OyWPIqQmvZsbomGlIUyQZym9vjn+vL/o=;
	b=VGC+yeE7MfMn+v1kqUWFqP2b7eyB2/Nlzde56HIJUfxeReMcWa/rL+FflLZ5GLz5Nt9c
	 KZnM9w2S3oKhUDE2rran/lAJBgYtyCHypPeFnQoRUcHEyqgtAZDGzNIucEi1y0PYxx6gF
	 U/5rdS9v+CuVOJ8Trs60qohF8xjt3LzAHtYnbJSaEQUd/K5xJWvMNwDvleDS2a5wmqbEb
	 U8D0NTOqsSFaF5PYnWHJQBXNhgY6jxqRMuVlhEvl1wCt0gYImAO5UjEW6JCLaELy2r8+r
	 aL/2iw/Tru9uY1618P1RmpsPyTk07S+LfdxfXNt2nXe/2t0JNzt6q13BMNO0rjUB4mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=NJhLc9zU;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F20606A327;
	Fri, 30 Oct 2026 16:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F20606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=NJhLc9zU
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f74f11d;
	Sat, 31 Oct 2026 00:54:35 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Lee Jones <lee@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mfd: palmas: Fix potential IRQ action leaks on removal
Date: Sat, 31 Oct 2026 00:54:26 +0800
Message-ID: <fe4ee2ff4b3ad6675a46a169d6de6410db32b652.1793377422.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
References: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa18dbc13bf03a1kunm46158e5a52a22
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0xDVhkdTE9KGB9IGUsZTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=NJhLc9zUAZUbMz4RbfiQSzAdSh5etaPu1SNUALwGAEHFs5rwnZDkv1J34bEZO/IXSofz23Irx8eYaLbEfxdtfKmvIT+PVhIX7D9k6szQiPJNrMwJNluGUevNAlYIfuTQEn8y2dtyS0D8h92Iiwbv8WMlcg64FyiqBLzbYY9Fms0=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=fNE2eV0m3D6OyWPIqQmvZsbomGlIUyQZym9vjn+vL/o=;
	h=date:mime-version:subject:message-id:from;

The remove callback deletes the IRQ chip before managed OF children
are removed. Their later free_irq() calls cannot find the disposed IRQ
descriptors, potentially leaking interrupt actions. Depopulate the
children before deleting the IRQ chip and auxiliary I2C clients.

This issue was found by our static analysis tool under development.

Fixes: 124e9deb1c40 ("mfd: palmas: Use devm_of_platform_populate()")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 defconfig plus COMPILE_TEST
and the driver dependencies (W=1).
No runtime or fault-injection testing was performed.

 drivers/mfd/palmas.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 7fc886f4f80e..8a0b7b1e89d7 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -677,6 +677,9 @@ static void palmas_i2c_remove(struct i2c_client *i2c)
 	struct palmas *palmas = i2c_get_clientdata(i2c);
 	int i;
 
+	if (i2c->dev.of_node)
+		devm_of_platform_depopulate(&i2c->dev);
+
 	regmap_del_irq_chip(palmas->irq, palmas->irq_data);
 
 	for (i = 1; i < PALMAS_NUM_CLIENTS; i++) {
