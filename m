Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776027;
	b=I/dX+rt26pYJoQAF20PR0DH2kH6eBSRu+hC7tRtMw9D8L5kZ9mqAY8Z34VKtXGjr8blS
	 mvCkGgHoyOeswt1MCavK4QsIGynwTMRpQ1fgC1Cln4w5hOfTgJCEbMyVdBypDcEw4lNZB
	 xnu+G4O5zHlldGBP5NLCsV2Dycwus/xSddGrBgl2pLglYxOrKSZ0mW363X91Q/yVDD0a6
	 M70VWlSPixk5dunq0GlmdJTDzJY+gg3GleZVTAtWsOAzS82RjeGM32nE1OT9DBuFu6Lxw
	 izy69SouAK/bzNQtBAoCfbGr6nC/kjVX+VPU2T01mq57dBpnOMR5Ft1MoRRy0632A4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0MjmSAAhpe5cqP7I84bvnQ40cKtlwbqwpo+pqHT1S+8=;
	b=JTexHHmxO8TjWCekr5yo2RoQ0UdA+fgB+UDvQJs/xFfAmixOCmYrGuOaMCS3mxls1QXB
	 uFezC6ibsPP/l4w5/t8KhVcpH6nfdfPyH2GkcdJLWqFyvBIKcPjSiFHHspn7Ec8GMVQeF
	 NiPoPTbtb0ekHVSBvGtLIKWFDBd4w7n1vQ5EjqOJOS7H0MSp1j4XFOpDV89s/2Ku5WbpU
	 xN0odHttL4nLnT8jTqzLSGDJ9BqRU3zv8rCFzD5gJEv0w5sO9QXGI8dfu+bPn77MCJC2r
	 FOrJ30lLO5u0oIgSwa/4MpR4Y1E/1cVTxd7uft4lKOTJdlCVg7Nlmc2BYxh/hCD9qBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBsrZ6+T;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2B606A32D
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBF2B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBsrZ6+T
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso2031761a12.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795776025; x=1796380825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MjmSAAhpe5cqP7I84bvnQ40cKtlwbqwpo+pqHT1S+8=;
        b=dBsrZ6+Tx9NngHi25UXo3zVvlNSGzeTecI35aa1EMzKiA20cYwQ9kIYSYbJXlFE45n
         xo/CRMrccnn+ohJyXqDOegZX4zHq3Tz39Kr31OrO2tPOY9ulF0bvadZIZC2ZAaApyfIu
         wxrWczUDV9bNQ02PA9XmPgb9LqJGmHl8zjasWuIfbY5raGGho+ljxtFOYgGLj9NERqsI
         IefaIQTLcYcLlfYGL29MSwFvkYIhjdeTQG+M7RjbW/3ke3+GN/tOQFcwR8iWmFmI9OSa
         YVt1I/aoRdY49/Hu54a8Fo7/jjtqi34jWsI/bCX2VYdcbC1hqzP3O8TgARmmRpZDDdQZ
         507Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776025; x=1796380825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MjmSAAhpe5cqP7I84bvnQ40cKtlwbqwpo+pqHT1S+8=;
        b=H9JmF4qqp91jRnWp7YiMdKPAVZUYU3mHpMDtFWGeNvhmD0pjjUh61MW8XsPo0aFDtg
         /QesXxweVp4GdsrUemhhEfXp2xjmrC9b6C48t8UYxTJP8Pa81gOmXLCUBK8evHJjWN8J
         Runi/C+b+gicG8M/tUtKy5QWMihoJ+KUsGoa2IjnY7uE40VQZ2BnhrnW/PNBLdvO6JBH
         mChwcxEdBH32lsscqq557w9nPkhVhvF8/ipehbvp84ZfjA8lzzqXId4F6ibFXDNiqMfn
         8PLKiNMHlB8nXTYWqW327QR/CbNnzHTB6lto9XP4NpUKOMddqKUNMAe/HrvcwLlmv7Eq
         PYdA==
X-Forwarded-Encrypted: i=1; AL+hErHLe3BE9y9utEjWVFoNnJ7X9W8XUOMtFF4huEh+SsdpAUsXzvrcwT/vhqlLrMECws1IvtoUtZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dqhPCgQ8Q/O3i13G489vGoEmAIUZCbZk8hOhFpuczDyGa1ng3
	QBREyJ3TFZ0vSoCXW6u5qhEoLnSmCs5V2m+IXss3wA7hnytGQpiOBRV0CvBkqwiqX2c=
X-Gm-Gg: AZFdTZd1FSOKepBOj5E2M7xorR7Kg4iRjFN9iZ+62oGj+3YnCkZsuEUfxWKv9aezQAj
	wWa2tPGUtT0RltXaFdJyxZsXxa15gOgMO0gvepRfkXfMIWbL3vufwlUv5jprIJ4ku2ToLsZvzMN
	c7Klly2sz9CI6ALzb0EUZh2kPVYlmcTplNmZVFFVS06jxWggJcQXc17mKh8DmUuayhFGsWW/tjF
	1xxXjI1SCNuefpJauY6MwzWPPczBS/WI5Nhg+TTBVH1rc44hyvxGIMbYVyr3sbpmzRrSr6S+Vb3
	rIuJR1vZ6L0mZ+5o9TbZHyNHed/RWxAdv3esvQHu63J1GU8Lg+u7NJ1kLDb0AQdUiDVwrgXa2Mi
	X3EiAk+E5icYeI2iD5iRWhUIhlYyIgFbHX5xFXTsrZxhui2Fw2TIiFx2YUk1L6CWk/HBlqFmH2f
	r4+qMBUokYQQInExgnzgv85B5t2MEbidW8tS2ABW6TQYG8InRHXLuMFzID5LILtDq3pvp2tmibO
	QTBuOO3YJyR4VFwNbXWl4q17ndIznNk/MnwVjqbqwZducrfRn+0srdiOBK1+oTcnimqjhRG4Yg5
	I9EXxW7tyWQV+6Z8knScP2IrARzeI49Jk9k3X4dJgOUIvml6v2LVL9j2MSzvEvdSyhemckl/XiI
	ovrMdWsZFYd4/OntZS5g3PUxZPRTCFYC5uhHjlHc=
X-Received: by 2002:aa7:d353:0:b0:6ba:22f7:189e with SMTP id 4fb4d7f45d1cf-6ba37d63cdbmr12166261a12.7.1795776025312;
        Fri, 27 Nov 2026 02:40:25 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb11ff543fsm3919199a12.2.2026.11.27.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:40:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 10:40:21 +0000
Subject: [PATCH 1/3] phy: samsung: gs101-ufs: terminate pre_pwr_hs config
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-gs101-ufs-phy-oob-v1-1-144b0e04c3a8@linaro.org>
References: <20261127-gs101-ufs-phy-oob-v1-0-144b0e04c3a8@linaro.org>
In-Reply-To: <20261127-gs101-ufs-phy-oob-v1-0-144b0e04c3a8@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Booting a gs101 platform with KASAN triggers a global-out-of-bounds
read during UFS PHY calibration:

    BUG: KASAN: global-out-of-bounds in
     samsung_ufs_phy_calibrate+0x144/0x530
    Read of size 1 at addr ffff8000825a894d by task (udev-worker)/179
    Call trace:
     kasan_report+0xb0/0x108
     __asan_load1+0x98/0xa0
     samsung_ufs_phy_calibrate+0x144/0x530
     phy_calibrate+0x70/0xc0
     exynos_ufs_pre_pwr_mode+0x280/0x2b0 [ufs_exynos]
     exynos_ufs_pwr_change_notify+0x208/0x2b8 [ufs_exynos]
     ufshcd_change_power_mode+0x58/0xd0
     ufshcd_config_pwr_mode+0xf4/0x1f0
     ufshcd_post_device_init+0x2fc/0x4c8
     ufshcd_init+0x12bc/0x18a0
     ufshcd_pltfrm_init+0x200/0x3d0
     exynos_ufs_probe+0x48/0xa0 [ufs_exynos]
    The buggy address belongs to the variable:
     tensor_gs101_pre_pwr_hs_config+0x2d/0x40

samsung_ufs_phy_calibrate() iterates through each configuration table
with for_each_phy_cfg(), stopping only when cfg->id is 0.
tensor_gs101_pre_pwr_hs_config[] omits the END_UFS_PHY_CFG sentinel,
so the loop reads past the end of the two-element array into adjacent
memory (offset 0x2d is cfg[2].id).

Add the missing END_UFS_PHY_CFG terminator to
tensor_gs101_pre_pwr_hs_config[].

Fixes: c1cf725db106 ("phy: samsung-ufs: ufs: Add support for gs101 UFS phy tuning")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-gs101-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/samsung/phy-gs101-ufs.c b/drivers/phy/samsung/phy-gs101-ufs.c
index a15e1f453f7f..d4af94f3fed4 100644
--- a/drivers/phy/samsung/phy-gs101-ufs.c
+++ b/drivers/phy/samsung/phy-gs101-ufs.c
@@ -98,6 +98,7 @@ static const struct samsung_ufs_phy_cfg tensor_gs101_pre_init_cfg[] = {
 static const struct samsung_ufs_phy_cfg tensor_gs101_pre_pwr_hs_config[] = {
 	PHY_TRSV_REG_CFG_GS101(0x369, 0x11, PWR_MODE_ANY),
 	PHY_TRSV_REG_CFG_GS101(0x246, 0x03, PWR_MODE_ANY),
+	END_UFS_PHY_CFG,
 };
 
 /* Calibration for HS mode series A/B */

-- 
2.56.1.839.g22a8290db9-goog

