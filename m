Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148968;
	b=2BHhrdWO9Ve5uFrvBwD02jLXk9XTrm/kiPpoHekCrnI+QRzXqHZVQA0GylDOgYB5C7FN
	 gI4O9F5JIhrYJ4RSYEsdoFjD6Jc0+lRyNfHaoYSEAp0od+h2Rvh4obj1oB/dOuuJWfnE4
	 /5V5uN5iiAUNiPgOUMGZn9ygvQ4l5EmAT378D0QxOR+9xTBy4nZzXtar3rSozMy5MjvWw
	 7VFgiyUTOc2T6crPMjRviKjAex2L4PF3zpqtDk4BZE0vkUXpCn6OSG2tWFuDjXqbuOmye
	 1MC7RAFtjpmZpVjtcv9T1409TSoWNSQf7N2JKEP3xHm2jEURanNzluCocHodGqKWUrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/lG80DLNu6POZT4VDpp/wyuZACJ7GhkljhIS7mjm8QI=;
	b=DPrM5S+FJwZlAw93LPylt/ySOTW8d66WsQryzomUlGtn/InTR+P6yqkte0YsHau2TRkO
	 othvqwFNm5oDikrLNN9pJGCeFBdXWLJXDWTx/HVOwd3KNAk8ZeoxkX7Ldig25VuwuElwf
	 kRyqq0Avb2zKj2vG4lA0uSupvB0RWDZLQ30wijvWcBfdjqUVyypeRdorA0eBiDw9RJpwm
	 dx5fp0jBZW/D6K17wRomzMlaYxkxlKoW5jn55+mcEpB4gW0QlLXBKxhJxrMQsqOC5UXKd
	 cJ3eWd3KvnefLaEfiLIGe4AtdGra1fwkajdB4PjY6Eabsih8Exi7zgSxt2XNbA5OZwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="k/r/8nyM";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93294606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 00:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93294606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k/r/8nyM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso3364925e9.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148966; x=1793753766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lG80DLNu6POZT4VDpp/wyuZACJ7GhkljhIS7mjm8QI=;
        b=k/r/8nyMpl2GvO1At64Ns9lvg+M0uqE8hwCj+ZmnUOcma2wVT13S9++jKuaFcprrSD
         dMU76qrPbW2SEW/ltRcYsAbgMEMx0g6gDgR65GEXrmXyZaW2GicOtoPNJSLRAWkJbt1F
         fkYgvsWWKRM5KtbgpTXLiF/OfxgWvAmmodRO7eJCW0xF9FlqlpdmiG1OIALA+ff/knJY
         bR1BY/AeKQS/wuCg9zZcdFk8ePedG0/s5mEry5qbpwZBlL9o8VloGupVWgc3oMx0xrmE
         zZ/GzFvz0fuDS0H4UWjrrAbPYy4KL0qSqrY+wLLHQo5oVvEGptVJs9cjC6NwzBBS8HI8
         qwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148966; x=1793753766;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/lG80DLNu6POZT4VDpp/wyuZACJ7GhkljhIS7mjm8QI=;
        b=ebJ6BEXGPIdSR/r1fli2n9mAQhd5f4050wKyVeEBRzHTr8rgBl3rZnRxhRYvF8v2kQ
         2xb6KpTJ/kvbhZGRh1VnIW6CjD4NhDhXx+JcmE2mBS1gFtNpcNaxraWBwwOZsKj72fJJ
         edBgUEjFU1CYAFCwXAZ/ZDfDjwxSeP+4x49wiRnjBviKA/twbdh6P+6iL2saBc5XXqEV
         zcqR5EqNjxJh5cZadOj22A6nzJpGrEsQyvfOPJOdKhds040C68MTaY8k2aBTdcXrJPRf
         tOAIP1AsfX+I361u0sDFjNFEGR+9eUKDrd9TmEw89a+VolPFZ2xGLHNJsSID3N8+Kpkq
         SpSA==
X-Forwarded-Encrypted: i=1; AKwUvBytxqtrbqqisRMACHBr1F2RaXop2LJNXkFNCV02AvrzTGXYB9gVOTcOUrk0aLjxnv+5qP+IsB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2Bq4TJQ6MkSqPwe7GF0ImP4eha+h6xF0FEAuH9BmlP+YR9Uai
	iqBTnfg3hYhB0ywvGNZRuaipxvPM44n3jgfGeFPtuAXBqjZ/nDdQtyI4
X-Gm-Gg: AYBFou1gbPbOdOz/tOxWN3nG2zrMl5JrZVBfLFMfQhwreP6+LuKOG1qErrYLXZ3y5tS
	JbHd9KZwyvhiFIOJtlNt8v/P/xQ3p+UP2BxWs7Y9ewD5QeHWfDHUza5GRXGWsdCEPuAhtAqVSCl
	FPuhr/0pgnxfkAy6HuyfvFBywTcIt69osR1XGT1QqoGFQFjoczvYZ7fDYV7xMq+yJF2egHaZXlw
	AWsJzVcw03phRwADUjYW6vZpWAZWdjlnod2uadXEoe4n02tUGkCYjhND4MQupRScHXpVUnjTKSz
	jFHUnfYtrPwx2gxmE80eSBW0ajEVjQF2d/LEuc5SALQ3X4fsHmSaUtW17vVNlMoWUlTfxQeWWWc
	buPEFstlzQr18idssjbg/pdMSEf3D7PAMj8iMCp9FYFibx/6OdOTXTbK0W5nUvlCq6yr5cVOUI8
	We0qKPghEWeSMN54P/PFYgoQg81Lh6ofFjxwiZAUAIEsZKT7vWwkZ/c27vqz+8t8G+HSRc5zgZK
	TP0ljBjMMeEMfN/m3TB4nC6CN/6YjoJlJX93I0bd7xK0Dptqq4G3xwi3g5nbdQ4dq/PKnhgwiUs
	LMx23rfPjsXJzTFG38C0QPcXZjDJVHqAHp7ThTYp3dci3kQ9saaIqgSs2bBO+4dTApnDyQ2LeWw
	h6Z+LMXV/DPv0v2tnUJuKQ2zgjf3QU2AfSWC0DL985uDsvNE=
X-Received: by 2002:a05:600c:1d1a:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4a966c4111amr12556135e9.17.1793148965902;
        Tue, 27 Oct 2026 17:56:05 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c42bb6fsm7698165e9.7.2026.10.27.17.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:56:05 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	iav@iav.lv,
	=?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
Subject: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is already valid
Date: Wed, 28 Oct 2026 00:56:03 +0000
Message-ID: <20261028005603.2399220-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
behind an rk3399 root port is almost never enumerated: the link trains
normally, but the endpoint's configuration space never answers. On this
controller a configuration read that gets no usable completion is
reported as an external abort rather than as an all-ones response, so
the machine does not merely miss a device -- it dies with an
asynchronous SError inside rockchip_pcie_rd_conf().

That change added an unconditional msleep(PCIE_T_PVPERL_MS) to
rockchip_pcie_host_init_port(). PERST# is asserted much earlier, when
the line is acquired with GPIOD_OUT_LOW in rockchip_pcie_parse_dt(), so
the sleep lands inside the assertion and widens it. Measuring the pulse
in the driver with a ktime delta across the two gpiod_set_value() calls
gives 1 ms without the sleep and 108 ms with it; msleep(100) rounds up
to roughly 107 ms. This endpoint does not recover from a reset that
long.

To separate the two things that sleep changes -- how long PERST# is held
low, and how long the supplies have been valid when it is released --
both delays were made runtime-adjustable on a single kernel, one before
the assertion and one after it, and the host driver was rebound to
re-run the whole probe:

  before assert   after assert   pulse       trials   enumerated
  0 ms            0 ms            1-11 ms         5        5
  0 ms           10 ms           ~18 ms           3        3
  0 ms           15 ms           24-47 ms         4        4
  0 ms           20 ms           ~28 ms           3        1
  0 ms          100 ms          ~108 ms           4        0
  200 ms          0 ms            6-11 ms         5        5
  200 ms        100 ms          ~108 ms           1        0

Delaying the assertion by 200 ms changes nothing, whether the pulse is
short (5 of 5 either way) or long (0 of 4 and 0 of 1); widening the
pulse is what decides the outcome. vcc3v3_pcie on this board is
regulator-always-on and regulator-boot-on, so in every row above --
the failing ones included -- the supplies have been valid for seconds
by the time the driver probes, and Tpvperl is met whether the wait runs
or not. It therefore cannot be what distinguishes them. What this
endpoint reacts to is the width of the PERST# pulse.

The wait and a short pulse cannot both be had in general: Tpvperl is
counted from the supplies becoming valid to PERST# being de-asserted
(PCIe CEM r5.1, sec. 2.9.2), so on a board that powers the slot at
probe time the assertion does have to last that long. Where the
supplies are already up, though, the requirement is met before PERST#
is ever asserted, and the sleep only widens the pulse.

So record whether the supplies were already enabled before the driver
enabled them, and skip the wait in that case. A supply that is already
on at probe was brought up either by the bootloader or by the regulator
core at boot, both of which precede a PCIe probe by far more than
Tpvperl. When the driver really does bring the rails up the full wait
still happens, as it does if regulator_is_enabled() cannot tell.

The same check is repeated on resume rather than assuming that power
was cycled: suspend calls regulator_disable() on the 0.9V supply, which
only drops a reference, so on a board where that rail is always-on or
shared with another consumer the power stays valid across the cycle.

Skipping the wait only when every supply is already on is strictly more
conservative than what this driver did for years: until the change
cited above there was no Tpvperl wait at all, and PERST# stayed
asserted only for as long as the register writes in between took.

Boot-level counts on the same board agree with the table: unmodified,
the endpoint enumerated on 0 of 84 boots; with this patch, 3 of 3; with
other ways of dropping the same wait, 16 of 16. Each of the three
PERST#-related changes that landed together in v6.11-rc1 was also
reverted individually, and only removing this wait made a difference.
Moving the wait later but still inside the assertion did not help
(0 of 15 boots), which is consistent with the width being what matters.

The measurements were taken on 6.18, but the code in question is
unchanged between v6.11 and v7.2.

Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling")
Cc: stable@vger.kernel.org
Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
---
v3:
 - Rewrite the commit message. It now leads with the width of the PERST#
   pulse, which is what the endpoint reacts to, and demotes the Tpvperl
   redundancy to the reason the wait can safely be skipped rather than
   the explanation of the failure. Manivannan was right that those are
   two different claims and that only the first one was evidenced.
 - Add the A/B measurement that was missing: one kernel with the delay
   before and after the PERST# assertion independently adjustable, so
   pulse width and power-valid time can be varied separately on the
   same binary. Also note that this board's PCIe supply is always-on,
   so Tpvperl is met in the failing configurations too.
 - Note in the comment that the regulator_enable() calls are kept for the
   reference count and are independent of the Tpvperl question, so the next
   reader does not have to ask it.
 - No functional change from v2.

v2:
 - Re-evaluate the supplies in rockchip_pcie_resume_noirq() instead of
   assuming that the 0.9V rail was really turned off. On a board where
   that rail is always-on or shared, regulator_disable() leaves it on,
   and forcing the wait there would reintroduce on resume exactly the
   failure this patch fixes. Spotted by an automated review of v1.
 - Factor the test into rockchip_pcie_supplies_enabled() now that it
   has two callers.

v1: https://lore.kernel.org/all/20260911104952.4190994-1-ehbello@gmail.com/
v2: https://lore.kernel.org/all/20260911211559.207990-1-ehbello@gmail.com/

diff --git i/drivers/pci/controller/pcie-rockchip-host.c w/drivers/pci/controller/pcie-rockchip-host.c
index d203c48..495428b 100644
--- i/drivers/pci/controller/pcie-rockchip-host.c
+++ w/drivers/pci/controller/pcie-rockchip-host.c
@@ -314,7 +314,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	msleep(PCIE_T_PVPERL_MS);
+	if (!rockchip->supplies_pre_enabled)
+		msleep(PCIE_T_PVPERL_MS);
+
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
@@ -609,11 +611,39 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+/*
+ * Tpvperl is counted from the supplies becoming valid, and the driver waits
+ * for it with PERST# asserted, so the wait also lengthens the reset pulse.
+ * Supplies that are already enabled before this driver enables them were
+ * brought up by the bootloader or by the regulator core at boot, both of
+ * which precede this point by far more than Tpvperl, so the requirement is
+ * already met. Treat an error from regulator_is_enabled() as "not known to
+ * be on" so that the caller waits.
+ *
+ * This does not change who owns the supplies: the regulator_enable() calls
+ * below stay, both so that regulator_late_cleanup() cannot switch off a rail
+ * that the bootloader merely left on and so that the regulator_disable() calls
+ * on suspend and in the probe error paths stay balanced. Whether a supply was
+ * already on says only whether Tpvperl has elapsed.
+ */
+static bool rockchip_pcie_supplies_enabled(struct rockchip_pcie *rockchip)
+{
+	return (IS_ERR(rockchip->vpcie12v) ||
+		regulator_is_enabled(rockchip->vpcie12v) > 0) &&
+	       (IS_ERR(rockchip->vpcie3v3) ||
+		regulator_is_enabled(rockchip->vpcie3v3) > 0) &&
+	       regulator_is_enabled(rockchip->vpcie1v8) > 0 &&
+	       regulator_is_enabled(rockchip->vpcie0v9) > 0;
+}
+
 static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
 	int err;
 
+	rockchip->supplies_pre_enabled =
+		rockchip_pcie_supplies_enabled(rockchip);
+
 	if (!IS_ERR(rockchip->vpcie12v)) {
 		err = regulator_enable(rockchip->vpcie12v);
 		if (err) {
@@ -890,6 +920,13 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int err;
 
+	/*
+	 * Suspend calls regulator_disable() on the 0.9V supply, but on boards
+	 * where it is always-on or shared the rail does not actually drop, so
+	 * re-evaluate instead of assuming that power was cycled.
+	 */
+	rockchip->supplies_pre_enabled = rockchip_pcie_supplies_enabled(rockchip);
+
 	err = regulator_enable(rockchip->vpcie0v9);
 	if (err) {
 		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
diff --git i/drivers/pci/controller/pcie-rockchip.h w/drivers/pci/controller/pcie-rockchip.h
index 3e82a69..e63259a 100644
--- i/drivers/pci/controller/pcie-rockchip.h
+++ w/drivers/pci/controller/pcie-rockchip.h
@@ -318,6 +318,7 @@ struct rockchip_pcie {
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
 	struct	gpio_desc *perst_gpio;
+	bool	supplies_pre_enabled;
 	u32	lanes;
 	u8      lanes_map;
 	int	link_gen;
