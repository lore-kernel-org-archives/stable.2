Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58413E3DBD
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919315; cv=none; b=WxEWiFzxak+6+a75LQclnK8rbmEktrXDeX1Uyxnh2mQBi4IkYjwVIkOGK5H1U03dTZfJN70231RjYSrPHGe3onekbnzJdkf+wm4dHSvTCdEbqikumyEEol3hd8NQzAOkTRYLNwwjL616liEDXzY+g+fDKNMIhxIhz2ZgCHPfdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919315; c=relaxed/simple;
	bh=l/oWp5W71NAkATODGkRO0A+w9ni3mNScsDVkSE5s4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sC62EKp2Kx0JRCsZDYW4PlgkG57/GAe5lujjeaHtCzwsBeFOD7lSOpWq8wA90kJjBhscEo+FZYjhCy11LAMNmUzUscO8MoRNvAzd/bHiEF1+VhzZuZQYSbV47mzHYtxQpCbk/q5xBc2KvVofi+I46qCje9Nr/ywx1aS+RD6UH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmUKjlbT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmUKjlbT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f703a9d05so437344f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785919312; x=1786524112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d3K5hA7CaLdIJbg5AimV7fCZLWk9OkFDdwcvRXHBYow=;
        b=BmUKjlbTaK+c2Uo/hA6ZB6BM+d3oc2KPCaTqE0FEZF5E1wOZvLCmkaQ02h9y26h1Ff
         vhmwR7k+vocoIO1i9EiVFLY/4lX50cgR4AwZeVBVN16X3y1wiAiB0aTStH7299WAFME2
         RTEYrGrLglMxtk/SvW7ocV0hRAJ2xVRIUXygVoqZz6Q8PTNK3BolrO41aFsmlxoVIVkf
         WJMGB8cwNCNFugqJ3ASpEWHk8YQE0sTz8MNy/iYcoSOJI51Fp9TbpUbPQrfBYjj1JCq4
         23gHlT7ExEtSleSPMKq7ZibSQiOkPU3yPbFii4msjE/tq07Z/Hs72AtOGfgKtpdcyl2V
         piUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919312; x=1786524112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d3K5hA7CaLdIJbg5AimV7fCZLWk9OkFDdwcvRXHBYow=;
        b=M8yVncvFLGd7Fb4y1MExCiZyW9AxAuhUsD484k5FBs+LC18yJZ9agNromb/YAnVJhg
         AOGwyFJwURQxGGLLH/4kqylwRa9EGYAcrtFkYj5XJoVEOGrxU8DYtfm2XdlDk3YlJYLW
         wQNgG/ms1DnozFSvvzvCtY9rPMXq+G1lw7MTvJqbMmLe+AWansrXJ7d+2CD0/v8NIVQs
         WVnW1aLSvS/jJ6CT3pEfQp/wNJo11tU5USnQ1W4Z/xVLnXC3aJKdvaL7B8U0WfXvcj8A
         nim5plOzhrf3qG4Rrwbj8EYIWm/Jf+uGCNTLl3GrHttZgtpXa9aL26poeYyie5owXSgL
         79dw==
X-Forwarded-Encrypted: i=1; AHgh+RpzxSvpDaLRCnL5j9Er7eUBIJSK612MtVBd95igt1QpUAcIp0akmxT8ND2N7cimkHW0ts7tJt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFhMkMf87tpFst1pIn/MIgSqsFrA8Srg8sKmBwpVup+50nABU
	1lIg11Y/UDEOnfiQk/fd5lAv9ey/JGv21VjR/6gSUT+pb4FNRPoj/o2v
X-Gm-Gg: AR+sD10/IOHQWSiOmv4viTPD+6e+2FeKGkLHxNkhshz4OZA8a0LJY0mneclX1e7Hjig
	uSO5/8dhOTzBFoYuguChBkffGTqWJp4jiWYR1N+OC1m4jt+/2Hyw/2QciFvUvorDYq0x53hsM3O
	LjfwrI4eDUnR0O5Y4msoZrmvUj55NFmNuGhNuonCcjqa8CcoBQt/lQlhnJcxebcb06nlM4dndKS
	+nLyQIChAX3aIrrpPEdwwgWoy31ogLPu0wNElgkUmelrY/RiZdh3YiW4p84oyionhhNCIK+BNze
	ZxIS+Y0za7+sOQfHZ2FLNfNi/7A93OD93R489Bdj3UGX2um4KQ0v6IGJLBdFtfa5mEHm8UNPmNN
	WZM137CYaL/gHiRrA3OTow4IF4oQq9B8ZAZHhBPC02f5jidiTU+kiOMcT6ljZqDBP7jWjq5gSTk
	hVctCooMjQVEAtWn1giLLCgFJMFOC9w+9HLrWqovrfEp4dSwayoaKNyfODvYAmdSifcQt1wPgku
	jPFncblNjsMyTPPnIGX113Me8TI4FvON1joD2+JanDEHSIiDKkwtA==
X-Received: by 2002:adf:ea89:0:b0:47f:9751:cb3d with SMTP id ffacd0b85a97d-47fec4f229bmr6673348f8f.8.1785919311697;
        Wed, 05 Aug 2026 01:41:51 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-42-255-151.retail.telecomitalia.it. [79.42.255.151])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47febfe5b1bsm6278770f8f.12.2026.08.05.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:41:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: airoha: fix wrong value for PCIe reset pin
Date: Wed,  5 Aug 2026 10:41:41 +0200
Message-ID: <20260805084143.3901-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe reset pin actually require the bit to be set as 0 to work as PCIe
reset pin. When the bit is set as 1, then the PCIe reset pin act as a GPIO
for GPIO44, GPIO45 and GPIO46.

Cc: stable@vger.kernel.org
Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pinctrl/airoha/pinctrl-airoha.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
index 04b4424c688b..6409572c0a4b 100644
--- a/drivers/pinctrl/airoha/pinctrl-airoha.c
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -1412,7 +1412,7 @@ static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_PON_MODE,
 			GPIO_PCIE_RESET0_MASK,
-			GPIO_PCIE_RESET0_MASK
+			0
 		},
 		.regmap_size = 1,
 	}, {
@@ -1421,7 +1421,7 @@ static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_PON_MODE,
 			GPIO_PCIE_RESET1_MASK,
-			GPIO_PCIE_RESET1_MASK
+			0
 		},
 		.regmap_size = 1,
 	}, {
@@ -1430,7 +1430,7 @@ static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_PON_MODE,
 			GPIO_PCIE_RESET2_MASK,
-			GPIO_PCIE_RESET2_MASK
+			0
 		},
 		.regmap_size = 1,
 	},
-- 
2.53.0

