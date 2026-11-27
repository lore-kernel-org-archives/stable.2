Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788459;
	b=fXRUd7RK6H4J2AT3nIGOyIRg4/77lLHM6Igs2Iqcn/rbMZmnJ2BeQ9TpHDfvWyK8RHnU
	 v0D5Ga/08h8yPD1QyQrrh3TO69kqBbZewRBMXikkdBeJFzL2fKUzai6m/BvLILht6zlRH
	 xsxF1jKSGgkg+SjgvZPD5aQA5IWAKyFcySGkex7/jRPReuws/QQOObemqGSr4eFAiIV5S
	 0j+kpdCBHX39LpCP5m3mEt0GRNlbgjLnTc8ofZREhmW4uzZ/CmpSe0Nrlrlo9hwDWcpNv
	 qxbhSJNSKxG7RxC0iaLi0RAdl5o/HZfgLZAQUvhdsPR190xDGQuvnL0MW78nDjUMysw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788459;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xNTHyL79nF9XXtIwSQd6Q/aKnFBBrPOZckjtVYsFR9k=;
	b=eOzSQOaVBu39hnL6lJMzT2jS79g23W89EMLBNQGOzg5pFLpwb9ST7+8yxk041G/Cxc3W
	 mGo1ZK5Mx1vzZ6JU0mNSVt3XBg+6z5Ty8fbtdnEIoYitIrm2RS1y8HdvjQAG7dkQAkIO4
	 9k+Azf+Fb8b+DWr68GSKusgFlyxaXs3TZA7kFN6wOGItLR+MCXqlsAGnk9/G8DjdTyYda
	 wQXNKiyYDWZwf/FdPuFPgTVMT69OVruHmO3ExcQ1jJuS8KPcw2GLGpbcpg29gZFabpcN7
	 oy/28V6Ok2nhD/6YWlQVNLWrMBJIHYeQoYwvixTFBWbwAM8xsxnxq4SkrAgey1lvMbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ec+WklID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C34606A31F;
	Fri, 27 Nov 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ec+WklID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25991F00A02;
	Fri, 27 Nov 2026 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788458;
	bh=xNTHyL79nF9XXtIwSQd6Q/aKnFBBrPOZckjtVYsFR9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ec+WklID7c6vdwHelKyWf8KfJiNtivMnHn7q/6WCnIfIpiDBPSuBTUlMC+j81rZCe
	 wLBhHEMX5LK1MIZx4ONBEY4Xca0H4t2gy2DX1Z6PRCzhiriiQz/ziSEfV5ZjMs7pVG
	 w16OKA91obxHvt6exXnXRy/t3a81/GcYVitVzGNfictbjXQL4zposrYH9yha5uOwkH
	 YTUARcq4uDGEZAyDXhXlhhrY1RRC/7jg5WPGdD+2Nj7G5pF7csBXgpYxGAZBKqhAfd
	 /DIi2ppunacNP9BuLQxSoITrweWYNSWiHnHQ5EWfuKMZDk5w4LcrbMocQ37WfL2yVx
	 F1MkYn3Te41lw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	James Tai <james.tai@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.com>,
	Linus Walleij <linusw@kernel.org>,
	Tzuyi Chang <tychang@realtek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 12/12] pinctrl: realtek: rtd1625: Set dcycle_offset to NA for pins without duty-cycle support
Date: Fri, 27 Nov 2026 14:05:00 +0000
Message-ID: <20261127140602.2790001-13-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

In rtd1625_main2_sconfigs[], pins gpio_86 through gpio_91 do not support
clock duty-cycle adjustment (dcycle_maskbits is 0), but specify 0
instead of NA for dcycle_offset.  Because rtd_pconf_parse_conf() tests
sconfig_desc->dcycle_offset == NA to determine whether duty-cycle
configuration is supported, an offset of 0 causes it to compute
GENMASK(0 - 1, 0) and corrupt the pad control register.

Set dcycle_offset to NA for gpio_86 through gpio_91.

Fixes: e309dbd523b8 ("pinctrl: realtek: add rtd1625 pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-8a8f690f-15e7-4dbd-a3a2-87bc00edf7b9
Cc: stable@vger.kernel.org
Reviewed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/realtek/pinctrl-rtd1625.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd1625.c b/drivers/pinctrl/realtek/pinctrl-rtd1625.c
index 88f2be37f743..f6e038e4bbdd 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd1625.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd1625.c
@@ -2993,12 +2993,12 @@ static const struct rtd_pin_sconfig_desc rtd1625_main2_sconfigs[] = {
 	RTK_PIN_SCONFIG(gpio_65, 0x34, 16, 3, 19, 3, 22, 3),
 	RTK_PIN_SCONFIG(gpio_66, 0x38, 3, 3, 6, 3, 9, 3),
 	RTK_PIN_SCONFIG(gpio_67, 0x38, 16, 3, 19, 3, 22, 3),
-	RTK_PIN_SCONFIG(gpio_86, 0x3c, 0, 0, 14, 4, 18, 4),
-	RTK_PIN_SCONFIG(gpio_87, 0x3c, 0, 0, 24, 4, 28, 4),
-	RTK_PIN_SCONFIG(gpio_88, 0x40, 0, 0, 2, 4, 6, 4),
-	RTK_PIN_SCONFIG(gpio_89, 0x40, 0, 0, 12, 4, 16, 4),
-	RTK_PIN_SCONFIG(gpio_90, 0x40, 0, 0, 22, 4, 26, 4),
-	RTK_PIN_SCONFIG(gpio_91, 0x44, 0, 0, 2, 4, 6, 4),
+	RTK_PIN_SCONFIG(gpio_86, 0x3c, NA, 0, 14, 4, 18, 4),
+	RTK_PIN_SCONFIG(gpio_87, 0x3c, NA, 0, 24, 4, 28, 4),
+	RTK_PIN_SCONFIG(gpio_88, 0x40, NA, 0, 2, 4, 6, 4),
+	RTK_PIN_SCONFIG(gpio_89, 0x40, NA, 0, 12, 4, 16, 4),
+	RTK_PIN_SCONFIG(gpio_90, 0x40, NA, 0, 22, 4, 26, 4),
+	RTK_PIN_SCONFIG(gpio_91, 0x44, NA, 0, 2, 4, 6, 4),
 	RTK_PIN_SCONFIG(hif_clk, 0x44, 13, 3, 16, 3, 19, 3),
 	RTK_PIN_SCONFIG(hif_data, 0x48, 3, 3, 6, 3, 9, 3),
 	RTK_PIN_SCONFIG(hif_en, 0x48, 16, 3, 19, 3, 22, 3),
-- 
2.56.1.839.g22a8290db9-goog

