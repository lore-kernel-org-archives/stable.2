Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E0EEA8
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786900618; cv=none; b=Nd/oEADcPJZIaVB4VLOu59pGW9aFLhj4hknda6izWT/x3Htf9lPg8UE8Z3YJZDEyw3LesYO8k01QK6Vatuyh30E3OfAEWQz1GBJyo/Zo62WbPqLtVk+bumB2LoNub+LzAfPUCZfPwQ4YpM41m2HzG623oxIHZhXsIotCCD406zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786900618; c=relaxed/simple;
	bh=CRqmAvWGksbZfUuvcjjpvynfTJFjP2gans9vMh8Sje4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXTsycY9LJ66j3u9KhgqPfcEjvTAgh2vRFeAwe9Ok3euMQmUV2eitE+HiAA6KtkMzlViWRWwTqRHYm3py3FUqXQOLXVeyo/DPAmdue5V0G5IckIjik3qJXF41arsRjnfGfoBMp8b2Io0xJ3W0fzCFUK2op57+PbnylEa/xDPG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIaWTi61; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIaWTi61"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2103703a91.2
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786900617; x=1787505417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jqHlndu2mP4JOXXcMYq7yqkvIBuKIHfSguke33kVois=;
        b=cIaWTi61vQqxn5hzucL1kCgdg0BVmC6RaHwLsXnOQlWtkrAnSU1msJJ1dA7QJ4+b3D
         71sLe7t/i7ixhF3E198uXoYryQP844pX6GD3GAv3sIZzhgrr7RliLPnNOKEUHW6ssVsG
         0idHIdu+DRKzubnh0gNLdHSnoM2Ei1opfEKpsoEZ0rlWSLp+BIBSjccG2cJFmXKM3ROu
         Rumf8VOefyVy0rf9h7Dz0kslH0PoI+PrjwBZ40EI2zaNNbyiePQNX9OCmVnsGz3gQfeE
         Lk1+Klf1WftJTsgk47OGo5flHnUJZT3PvmhAkfWiv2geaV5ZeKodX3A8rgjksffRr31n
         TMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786900617; x=1787505417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jqHlndu2mP4JOXXcMYq7yqkvIBuKIHfSguke33kVois=;
        b=Nk/c+m8yhF0EbGVlUl8nppRY7jqjlXW2OpSbhG8zm2pg7O0eco7pj+iscSJTgt0hmI
         nPDsuVJvZOTZImsnprkVYszW6+z+Cwl33OSkZyOJzekEbTceb4nLPoVE2FA2b3LLRGRU
         G2dMJEmkOFXwqy2qBmH0Va8S21hBeZSuQnM3a8AUahF4k3poiLzgxV4AM6rmdmPPgOXx
         IaTo22VKz35/rF0Xn/3KSY8IxTMvI0pYWpCycnH9HD/u88+ud5d2BliVImM6ZivB/+7l
         7K7tuQhwmeo2K/Bph6NUi3VGstsj/N0F87SUbRcl7npgQWl1VRoNhgvegPFkWjDNYhER
         zjqw==
X-Forwarded-Encrypted: i=1; AHgh+Rqge/+0iihXC9/smweCpgaf/rSQwtAo8eJmGwk9PXsLeg1XyLLlghTPGVr6NI9m2WoZOQEiO2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyufKpfPFuYho/XWjOqh9sV6h2AmNfXcTM1EtPR96avBtUBjfHc
	DWPfHXqcDWUzoQTO6gooOnCjVyqf1hvYiGI7DBss4neZ2QQAgucd32Kl
X-Gm-Gg: AR+sD133vr8O7rYOQuXpfGX01jj7KmHuMt4NZqknaoEPRjIvGr/dgXh8y4rMi6APwT5
	ao6sdPF2W7MiB6L73bDDWjSkbyPZmvZHMNdOExW8eRmCkqfxSN6y5jq7HFPHESIfILTHsl+Gc3K
	7+JK0Gn05t2uP34ZY1nOcuTtS1OfBRo3eGgmMZMeOhxqRLQewkODTRIe06lcC/cch6ise99UEYW
	BJQxA+JX5A7NDIsXYqWpbEU8eLgulLgdQUCyGRRV83FM9nfanMmj+gZSQVv8V++n/EfcDRi7srH
	EGyGA9KboJCNaojFHQT6HlDI22ZGcETIecipm1KhEFo129fZKoKXGa83ORAhhD7UeAnZxjl5lpT
	B6Pkem0zCpBTq7iL/ztZuLesr6KV0XkJjYvV8TxkmAPKvSFTRHRiYn1J3PlP3B8/jUcH8ybreQb
	CS7PaqmBUSbN4MsNTALeVU0lmNnBG4uWdgXZxAvbhP2Vnie3DBSktcRQPMnGV1qzYqsV9LKmtbo
	mEK5OoVXkJ8Qq+qiSCQ/j1954A=
X-Received: by 2002:a17:90b:528a:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-3933b7c3696mr20611825a91.3.1786900616817;
        Sun, 16 Aug 2026 10:16:56 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:1470:95d0:2f3e:656d:65de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm4607627a91.1.2026.08.16.10.16.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 10:16:54 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: linux-pci@vger.kernel.org
Cc: jacky_chou@aspeedtech.com,
	mani@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>
Subject: [PATCH] PCI: aspeed: fix clk and phy leak in aspeed_pcie_port_init error paths
Date: Mon, 17 Aug 2026 01:16:33 +0800
Message-ID: <20260816171633.15025-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aspeed_pcie_port_init() calls clk_prepare_enable() to enable the port
clock, but if phy_init() or phy_set_mode_ext() fails afterwards, the
function returns without calling clk_disable_unprepare(), leaking the
clock reference on every probe failure.  Additionally, when
phy_set_mode_ext() fails, phy_init() has already succeeded, so
phy_exit() is also missing, leaking the phy reference.

Add the matching clk_disable_unprepare() to both error paths, and
phy_exit() to the phy_set_mode_ext() failure path, mirroring the
cleanup pattern in pci-aardvark.

Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
hardware available for runtime testing.

Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/pci/controller/pcie-aspeed.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index 9aa9e14c6148..1fd663ea3bf8 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -761,16 +761,21 @@ static int aspeed_pcie_port_init(struct aspeed_pcie_port *port)
 				     port->slot);
 
 	ret = phy_init(port->phy);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(port->clk);
 		return dev_err_probe(dev, ret,
 				     "failed to init phy pcie for slot (%d)\n",
 				     port->slot);
+	}
 
 	ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
-	if (ret)
+	if (ret) {
+		phy_exit(port->phy);
+		clk_disable_unprepare(port->clk);
 		return dev_err_probe(dev, ret,
 				     "failed to set phy mode for slot (%d)\n",
 				     port->slot);
+	}
 
 	reset_control_deassert(port->perst);
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
-- 
2.55.0

