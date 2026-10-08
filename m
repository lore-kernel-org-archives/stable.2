Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5533A7F57
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487112; cv=none; b=g4stbvA2dKvNRqVT2LYUbOC57hFcB8D7tgrkXAzn3gigFIb4Fih5kqAVWFuSGXEJ8xmeIcRCKww498+B3FkMkNkLLz8M0AOSEyaLaq0VHPg36v4YuBFwSWza4N58OhbolFVdqNbkmflhBlPApy5FNEATyFw9yWwHIPZDa6UktIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487112; c=relaxed/simple;
	bh=amUxH7dplBRK8duZIHd9DmmDP5zoeolOwFlBY/V0V8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWqU5lU9Jrr0Hk8fYc7/RF3t+2W2XzTI8NGc8UW28Fv3qmC+KMcT4p/6zBh7G2TR9sYV6iKPeIh5/DWEXb5LmETcfIIbESs6JkvqWHQj2RtyjnRAzsSuHKVWZBqnxqjYVnwi/G/ObRYJjtEPOdXe8YFYbNQ/IKlK+C3oNEMmPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Hs+SSw/p; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Hs+SSw/p"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-34ceab2900eso5948908eec.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791487110; x=1792091910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a14qc72yQKkzCAZ2CAoTwipNnd9qGKItgjyfXX9xZAw=;
        b=Hs+SSw/p9qwN620ghvtdqdOQg0XSA8oWw6ui4jXXwEzxfjP12jOKkruaq6Y9ZvN86H
         xEdM05WCjb13YC4A4nyo3GK70Fiwrx2WDkDkDaM0CyrV5DjD1BhywdbcNG1umJGtoeef
         9CUEZUDUmGE/Da5r+xEsDo6CxdifP7BkyG60fq/Db4pbqCCqqG51RFd1nMPI5OmdpMJl
         VqmzEb8hUTU2MOIGP/M4jyImzWht+RiVd3EcQ+d5vKzpPJF138/dgFvBXIBFFO3u7fjA
         fLt9csy1setfzcRuYsReXsxwiRBtXrT+Tzj1jM9Poihw0rHrhvz8kSCnUo0L3m6oFEbZ
         WaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487110; x=1792091910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a14qc72yQKkzCAZ2CAoTwipNnd9qGKItgjyfXX9xZAw=;
        b=PCyxO8+DOs6xy240KMCpRRzGCPiK+M3+5vbhLCYDs/bahU2P93/LKlhV7g/u/Scp8E
         jPejooptJSw4/zm7wTHi3zXxJjgloPmDDo7xlKoJneRM/vnrRJwwxMuiqpL7zj51htyH
         k8dl8CmT3pGXJmfSB9yEWG+sOOOpd9DONdYtpSsHWtcK1YBVNVIivJ1/b/PKdDS2PPgG
         LIJKwv6oMFna+zelvRWnfw1eF1j9phcva6xAv+M/2qdc77z338yBlrFhIr9q/kq0UWmO
         i5Ls9EKR6zttbm6R04OH5lqDVgNd4HHsd7YIzr00bjBy0dEgob+MyL+LF2u3MmMeoSTV
         3WEQ==
X-Gm-Message-State: AFq9FYJEXrIaLS9fy+DeGiDH+oAiZHU0UQbYu61gEl8RnVc+rNjq2HFH
	9l3S4hYu0Y5NzZoqb2aYhsJ7mIvqyM8TE7lQ23bXF7CTLf1YkmGofykVyXkdxDIcQhWjze8GSrn
	s/0NWFefdQw==
X-Gm-Gg: AYBFou3D9QW33fqsmKk5Ls8grlKeyZS94vqrwMT0c9/JSNsadvW+gsRuQMu+5LfXcuq
	2ZohVxh9u6Jd466Z2zC/wu2QKFteyTOtP0NvEj+EG6y3b/hCft564dsK9nCUxPWBzJqoHP1gJNY
	ZQKvsPEH6PILDXKIcMl+CHsH8+r6wpcF1vnYGAK8cnql0Bx6DcCSeTo/9POEy8ljb73pbs4wU7B
	agzvnnaDh9cEQe8WYRjH5/tLNUS6L8mm3i3HtXnqYGRrlkoiyGU8YoU3z0aIJM5qNWQl9xj3PvJ
	EYmmURJMTOZaf4XRaQBpqmr6ziJUT06jhfn5Sc0OmyVzEutdWerEq8J0ATyDEzi2P0hWx3AvnKu
	BiERSOi1tXHVathvIGwyBwyaBsijPUwOaJckUmZYFcu6UgkEBuxWQ2xZQGSnN/CUXil8HPchaDl
	8jRaX1vZ+isr5elVRqZHCWSTHudaHD6wKKriydLAEyHRW2zViU+ZAOO6KhwgXnieb+bJTI8lj+C
	XT8sez0TECjrbmPouKn+7di9CXHO1nmsgIKKiBBl5ahFbfDRcN7Q1BXkFOoz+CtIYWIfXg=
X-Received: by 2002:a05:7300:8819:b0:33c:e72:5b3b with SMTP id 5a478bee46e88-3535f3cbcd4mr464739eec.25.1791487109863;
        Thu, 08 Oct 2026 12:18:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm117933eec.4.2026.10.08.12.18.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:18:29 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marco Scardovi <scardracs@disroot.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	jay.xu@rock-chips.com
Subject: [PATCH 6.6.y 1/2] gpio: rockchip: teardown bugs and resource leaks
Date: Thu,  8 Oct 2026 15:18:20 -0400
Message-ID: <20261008191824.98662-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191824.98662-1-artem@trailofbits.com>
References: <20261008191824.98662-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Scardovi <scardracs@disroot.org>

[ Upstream commit 9500077678230e36d22bf16d2b9539c13e59a801 ]

Address several teardown issues and resource leaks in the driver's remove
path and error handling:

1. Debounce clock reference leak: The debounce clock (bank->db_clk) is
   obtained using of_clk_get() which increments the clock's reference
   count, but clk_put() is never called. Register a devm action to
   cleanly release it on unbind. Note that of_clk_get(..., 1) remains
   necessary over devm_clk_get() because the DT binding does not define
   clock-names, precluding name-based lookup.

2. Unregistered chained IRQ handler: The chained IRQ handler is not
   disconnected in remove(). If a stray interrupt fires after the driver
   is removed, the kernel attempts to execute a stale handler, leading
   to a panic. Fix this by clearing the handler in remove().

3. IRQ domain leak: The linear IRQ domain and its generic chips are
   allocated manually during probe but never removed. Remove the IRQ
   domain during driver teardown to free the associated generic chips
   and mappings.

[ Backport to 6.6.y: For 6.6.y, send with 1c1e0fc88d6e (CVE-2026-53226)
  so generic chips are explicitly removed before irq_domain_remove().
  6.1.y lacks irq_domain_remove_generic_chips(), so it needs a
  separately reviewed older generic-chip teardown backport. ]

Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
Link: https://patch.msgid.link/20260526171050.12785-3-scardracs@disroot.org
[Bartosz: don't emit an error message on devres allocation failure]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2026-64241. Releases the debounce-clock
reference, disconnects the chained IRQ handler, and removes the IRQ domain
during driver teardown.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.

 drivers/gpio/gpio-rockchip.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index ff9a4b8611d7..e0e4f3ed5fdd 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -629,10 +629,17 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	return ret;
 }
 
+static void rockchip_clk_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_put(clk);
+}
+
 static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 {
 	struct resource res;
-	int id = 0;
+	int id = 0, ret;
 
 	if (of_address_to_resource(bank->of_node, 0, &res)) {
 		dev_err(bank->dev, "cannot find IO resource for bank\n");
@@ -662,6 +669,11 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 			dev_err(bank->dev, "cannot find debounce clk\n");
 			return -EINVAL;
 		}
+
+		ret = devm_add_action_or_reset(bank->dev, rockchip_clk_put,
+					       bank->db_clk);
+		if (ret)
+			return ret;
 	} else {
 		bank->gpio_regs = &gpio_regs_v1;
 		bank->gpio_type = GPIO_TYPE_V1;
@@ -773,6 +785,9 @@ static int rockchip_gpio_remove(struct platform_device *pdev)
 {
 	struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
 
+	irq_set_chained_handler_and_data(bank->irq, NULL, NULL);
+	if (bank->domain)
+		irq_domain_remove(bank->domain);
 	gpiochip_remove(&bank->gpio_chip);
 
 	return 0;
-- 
2.39.5
