Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464032;
	b=CDZ01aXGQHegEMwG1edwi9lkoEdE66Mv9irIkIBIuBarFh5ZeEdCww79HhJhzyckUJVb
	 P2QnjLnz/C6LOLYMne7S4CC4ukpE5tremyrJ+861LTXsX5XsfkWqi29DbS3QwpqXq0psD
	 G4J16dnrLcCLTq6xWOg3F/1N8r7oTKV0jgrZdCttebqvFZtu22GsEE7fv1erheOhqwKAI
	 x/ldC3QuSGRbcu+xO9Nn6wpuJMBl8sJLZDqwc6H0NtgyihgOHbYj62in5UkcGGp8A/xKW
	 WUVXX/j39XMQ6ExOVhpR7OkXyRbOnhd3U/9ZQOm9ryH78c3JtttHqH2YEJemGejV0sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wJmHuysGlrzUFkpREAfhZMaFYaFsHG8yDDRDlHUspmA=;
	b=afXf8Ca2dxWU+jpoMUQPevMUoPAK58x8QeHYsMWupX1U/hHcT100852/tuSXwKkGLuhR
	 bEdXhF0BeX3zhDdNqPB5rSJm0QaFi5dMsqd4QDoEC5gU1kv4K4yEwL6amjFFoXv+xwYgz
	 OBWftL/V0vaNvmbJd1W1HH93GeVFtE5mhhopuf3eGiWjSADIGwdwa7Xi6EdjqlAOpM7hn
	 pphOO+vq4KxGBuwNultcCywOJjddPXz1EQSERZa6V7kPTRBMhinhDqAZxRMcmtjXLVti4
	 J73Lx0kznc8xlhyX/3URgJifUDrL/GggiXXlk3KfxwxU1vqTbn+8tdYDOc1igvvNI+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKkr1tiw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A07606A332;
	Mon, 23 Nov 2026 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKkr1tiw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932811F000C4;
	Mon, 23 Nov 2026 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464031;
	bh=wJmHuysGlrzUFkpREAfhZMaFYaFsHG8yDDRDlHUspmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BKkr1tiw2ceUf6Ky8hMnKRSKYuCRupbDO2zhLMCHl9MvroL5Xs1SLGYpYVIL5O5LX
	 V+ZWMXfhXfvzI03cPCilmR+zweACy3zNnHkQKwoJgY20p+FtSQntCemRTHVfeHzsmi
	 Gy939rqUaTKMDnhmxzq8t17cvFYfV6PhVxjfdRyQbA/qQ1kninTGSH/MAEfn0jJChO
	 WQ5m0/2//02Zy2L9Awgc+8/Vuf5cinNe5AVxMeOT1xYBcnYNXInNgX1TeDlmLI7Xgt
	 oL7cG1okt01VXYqHQ+w8rUa0Exe1yaDMxtbx6VSFoOWo+GizVGvPfAUoepwQqekkdf
	 NK0159O9bw15w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	lm-sensors@lm-sensors.org,
	Sergei Poselenov <sposelenov@emcraft.com>,
	Dmitry Rakhchev <rda@emcraft.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] rtc: rx8025: pass parent I2C device in clock_adjust_ppb sysfs callbacks
Date: Mon, 23 Nov 2026 19:59:12 +0000
Message-ID: <20261123200012.502284-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123200012.502284-1-lee@kernel.org>
References: <20261123200012.502284-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since rx8025_attr_group was converted to rtc_add_group(), the device
pointer passed to rx8025_sysfs_show_clock_adjust() and
rx8025_sysfs_store_clock_adjust() is the RTC class device (&rtc->dev)
rather than the parent I2C client device.  Passing dev directly to
rx8025_read_offset() and rx8025_set_offset() invokes to_i2c_client() on
the RTC class device, causing type confusion and an invalid pointer
dereference during SMBus register access.

Pass dev->parent to rx8025_read_offset() and rx8025_set_offset() so
they operate on the underlying I2C client device.

Fixes: 3d35840dfb75 ("rtc: rx8025: use rtc_add_group")
Closes: https://sashiko.dev/#/bug/linux-39839b9a-7a00-4bdc-8d5a-b28de75dda80
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-rx8025.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 1ccec7b5ae42..ab3a30982863 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -482,7 +482,7 @@ static ssize_t rx8025_sysfs_show_clock_adjust(struct device *dev,
 	int err;
 
 	dev_warn_once(dev, "clock_adjust_ppb is deprecated, use offset\n");
-	err = rx8025_read_offset(dev, &adj);
+	err = rx8025_read_offset(dev->parent, &adj);
 	if (err)
 		return err;
 
@@ -500,7 +500,7 @@ static ssize_t rx8025_sysfs_store_clock_adjust(struct device *dev,
 	if (kstrtol(buf, 10, &adj) != 0)
 		return -EINVAL;
 
-	err = rx8025_set_offset(dev, -adj);
+	err = rx8025_set_offset(dev->parent, -adj);
 
 	return err ? err : count;
 }
-- 
2.56.1.750.gf70dc682cf-goog

