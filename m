Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741452;
	b=lQ8YnyU2ehKJ34wcHdyzWPk+HP85BM1nK6r02V7dCnBCi4jmXcnlSAX3mgVnyjmZDChX
	 PEJ4CvWbDcwqSRwK2ni7tC4Z09FPf8gfkAmzBA3iyxLHNfQhzcwfkAJ+MuOncxBb+0Ic5
	 3RVnQr0BPprwaEEM15ut5Tz/KKslXiF9w6JRXj4XpY39J3/UXnuVTjXfrsBdiApYrzTkw
	 6Z8o/sAH/7WCp9ptNxExjC1tEC5LhfZMIH6bpQGVgUAGn92GYQ45Z/fKymIqVy7XbFB3v
	 O0AbDlWcSnH/6UucScMSoYj8oGkGbFrXgkd6j3iFmdAdiJhCd6YyW3Wb4xvO352KZJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vINjqp9pvya8axfuBwfbY8HnHtZqyY6Mf4sC6k4LGmg=;
	b=PtPPyyVP1tUyiSrNxy/iyox+WjYwYqSZOZ5Y9fS/e5ZRrSRzrwZSl3YldOrGTBhucKTX
	 d7blxDgh7buI0i+Mx01NcEPzUr59DZgN5+f5Q59m7df4nyfFSVFL2df3XkgQVmP44gfAX
	 kt0NyZWnLlB47uB3DvsFTYYDlWvkMdKBpR6f9Wi0g2DrrrU3i/P+p3KfsH20fPK7E2vWS
	 mcUJE1j5oj8d23Xm8L0TwpaSQpAppquYRmlhkc6+IVAR6sRofa073Lpiwx2kVk43as/Go
	 HUEQJ9TrB3Hp5orBCr8KgC4LqD9d75HN8urx2dP4Vmpnwcme96L9I+TkUKous2W3A2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8TCBl3P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2A606A324;
	Tue,  3 Nov 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8TCBl3P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A288D1F000C1;
	Tue,  3 Nov 2026 21:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741452;
	bh=vINjqp9pvya8axfuBwfbY8HnHtZqyY6Mf4sC6k4LGmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8TCBl3Pz2aHOP6xh2Rc3AzoVGQ5WnQltf1OxLL5tXtVIuTDgv84J2srOCYwS6WXr
	 OiZaqjb8Ovrzws3CEkiULS1Z6Pfe3iNbivm1QQYW8N21bkn3dl4jjmz6N4kR1yWWzx
	 fJR48SqMzNLFGEOVbBvtIX4Rybu9g4zKBkc0zaaEgh+lmLYeumJjEE2MC+NE0Qye4B
	 FebYcuGsGHuT+UuA2DAntL9BrxQPyRJ4F6UO1Okb3WjgGECYSVf33b7/ickptYIUJV
	 4NgfdqxsUyGTxEqx0tT89jZkM0VrCHwn+w1YnG32pWXLbr213yrrdNCeF4ePIh+VRl
	 LwJ6Q3UeKBqOg==
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
Subject: [PATCH 06/10] pinctrl: realtek: Fix bit shift when configuring RTD_HIGH_VIL
Date: Tue,  3 Nov 2026 21:29:11 +0000
Message-ID: <20261103213002.1673560-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

In rtd_pconf_parse_conf(), the RTD_HIGH_VIL case prepares mask as
BIT(hvil_off) for regmap_update_bits(), but sets val = 1 without
shifting it to hvil_off.  Whenever hvil_off is non-zero,
regmap_update_bits() masks val with BIT(hvil_off) and clears the high
VIL bit instead of setting it.

Set val to BIT(hvil_off) so that the target bit is set as intended.

Fixes: dcc9334435b0 ("pinctrl: realtek: add support for slew rate, input voltage and high VIL")
Closes: https://sashiko.dev/#/bug/linux-e7077311-3f30-4b77-844b-1447519d0c84
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/realtek/pinctrl-rtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd.c b/drivers/pinctrl/realtek/pinctrl-rtd.c
index 2b877099ec85..72773600303b 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd.c
@@ -473,7 +473,7 @@ static int rtd_pconf_parse_conf(struct rtd_pinctrl *data,
 		hvil_off = config_desc->base_bit + config_desc->hvil_offset;
 		reg_off = config_desc->reg_offset;
 		mask = BIT(hvil_off);
-		val = 1;
+		val = BIT(hvil_off);
 		break;
 
 	case RTD_DRIVE_STRENGTH_P:
-- 
2.56.0.385.gac671c819a-goog

