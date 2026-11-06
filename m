Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980883;
	b=PcpSEuJAKo1LmibssZfuTAa15Ot3DiO94/K7kEM+oDxmI2EcMfz+pvm/9EJZz1Si8J8h
	 P21XK1+YVjxdF7OxS1ygqlaKkESzy8/4x2a8Mwv1A2BzuK9X1cfBCnerbkF0ih7QUf1Pa
	 CRzUxNBigRLaAJVxC/t6tDxslOimgRBtb6hAgtq6HW7vTMKcyFPtDJIV3PXDPqdHWmfAv
	 00a3xEFflYqA7q9U97qLe0RwwdtIVAQIXjliSD1Zy15Q6TsggsvHrTHl7SsBiT36+IsNh
	 EnO7lNjrDrn03rTQdGh4ShEKcPgTay7b9uOYBC23U77kpxE8ZLytFwMUoCwQJX3o7Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WqCbehPeg42mkM3NuhRGWk2/Ovgf7IzdbwtVD2E9nX8=;
	b=Tub9i29efvEOe/L599JnBOb6nMdMkKSN4MessHg6q8EiDHpswyKb+PAL9h+WQoYYQdDM
	 3yw34vERrQAKkVNFMfQaDNHNOFYkRXaOtGCj19GZIwmt4kNiLXXi8qtRxJXQhsJ/pziGz
	 SQwfsX/Yxn5QiMF6QSubYvxKDxly83Kd+3lHsYofTdtLfqAOln25ZkplFXqbK83xPGHVA
	 1fgFWRVf5N3tHePN+4tZo8vRAxL0U5XSCMs7sN8UBaJWUdgL5yZyFQ81No5pvYiEZk2Et
	 75PxKCixAy/dZzf5XzmaFV9KKcptSEAfBlUl8g+Z9RZ4kei2iSiCQYJCv7SIw70wexA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ld0Zb1H9;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62B606A334
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA62B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ld0Zb1H9
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b271e573adso370117b3a.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980882; x=1794585682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqCbehPeg42mkM3NuhRGWk2/Ovgf7IzdbwtVD2E9nX8=;
        b=Ld0Zb1H9Hs2Iza5rEis+Nqc9xJbRIVRAbPZ+jljOKT0qkbRWKzvB5KmtyGtgUfhxS1
         T2qn7YhWKw+984g0RZFh0FDZf/0W1b66sN5u8fUkyzFkOe6kwkjEkUd/3PehrdUFx8MN
         Hm+rHc6oqCOkgGN/MNO5xefwGFuZDJlcBWz51fRglmDNFtTPid5qx8aqZqR52DhholCt
         PUddWG4eZ5L3zzxVb1w7Hfc10PWdw0WQsNeS8ykIjmUXLyOTfzhD8wXV8aecNnXebaO9
         Z8UiNUTJUYWnDAiFPatY7GPuZUzugT8KS1v/k/M0rRYDP0EN84ezaoPFyPDvmppbdDxm
         9WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980882; x=1794585682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqCbehPeg42mkM3NuhRGWk2/Ovgf7IzdbwtVD2E9nX8=;
        b=rOZMuaTQPC99PPIhkV5yzGcEB60dsl3ueIQdPenIXl6QB50eEfOBA00xuUiELrmiVw
         jH+kTaoyLSi3HhjWVcN71bktggWWjmBS3+C8dmvUqC+VupMdG2O8RlvAOLdgI5dLZ29/
         kacxuLCOGd8OCn1AoPcuR3KBUzuz6o3xSUrnZY6v1iT2MTuqDrK/I+5fg9ZEBC9hNXog
         4bPYcopjPGkiEwLfuhaA9REB1nuYcmqFE1jC4EP79qhOCvAKSudZNChrrEWmfusJonMI
         FqeiNPlU83xGci9Mgm6H5k96vxzHj9XRynJp+wzC0/lnMDQ5jIrmhhgz3TAlakDG10Lk
         oRwg==
X-Forwarded-Encrypted: i=1; AKwUvByej6WPJ8Dz9764xnEFoXCgCjXYsDJlhYf13PxTcY45t+JaadA1j664y82FrnsevDC8mqaEQo8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LmUyd19baDa6p1iaLSQqdcDnOQqu8Ue7+eJ8Zb977K6eq+jek
	UIIVJiGpCYDHzTRzPftWb/VuJb2WqbgzUQf2TS3tCZUg7Vth2fL/JM7+
X-Gm-Gg: AYBFou0D92VOxNFPAJhy/mT2ykrRFQrnpFGWDbYBHB4Wc3BnxRIQZMGTxEvdQYaHH3j
	ndbSXaZol3oL7Hjveu+DX/oP8UUm8HZ8+uIkRoPOh/JqnVUozjsPyDBBLhgOXGWPuHkckfcMdSY
	SMbBJXlFZwpn+SQJBRRCfObxt/cz6sb6al6FyvkE/M/i4GcPfuAH0aj+OnatD4ur1yBkv7ZFLoH
	fSgi/kcNg1t+tt7NXiC2aHq3RoVGkCA1q/VBAJtII60ZAMiUVIAOXx9uaHJ+ja/1a1it6W1hspf
	FGOpNGZENgYs7m45PhkqkrDI4MuF+3K4u8LkuQ8gd4jUu7kXTlvS13ulkTrhm/lJqL0lTklP3wo
	LMqRY4+ZTz9bpD1A6dDmfqZ4WgPYSlFawlHo45s2/VM9P+WaWwLHXHB05HTANMMFXulcCCQda6P
	KXaE7oAmy15gij3pejtQnfAJvyGcx4bSlE/Xx0J5MDSzVEr9HgGLKRlGIhlhhLhYKVPmMmmJr1g
	dMi5ZkoCZSskwh7YC//QVsDS9sVWEs55ZiM4Ge5oHgBq+M3sNdWV0V9fr7k66j4E+fLnkARRIw+
	Rr4lQCfkb1n9IUEe/EZDFgmctEfUk3KtgL8nFoeiWNZVJEA6
X-Received: by 2002:a05:6300:2201:b0:3e1:549e:614f with SMTP id adf61e73a8af0-3ebb299d444mr3364948637.57.1793980882239;
        Fri, 06 Nov 2026 08:01:22 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm727930a12.25.2026.11.06.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:01:20 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] power: supply: axp20x_usb_power: drain vbus_detect work before unregistering the supply
Date: Sat,  7 Nov 2026 01:00:56 +0900
Message-ID: <20261106160057.2754689-3-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106160057.2754689-1-hj351016@gmail.com>
References: <20261106160057.2754689-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

axp20x_usb_power_probe() registers the self-rearming vbus_detect poll
work for device-managed cancellation before it registers the power
supply:

	devm_delayed_work_autocancel(dev, &power->vbus_detect,
				     axp_data->axp20x_read_vbus);
	...
	power->supply = devm_power_supply_register(dev, ...);

devres unwinds in reverse registration order, so on unbind/unload the
power supply is torn down first and the work is cancelled last:

	power_supply_unregister(power->supply);		/* frees power->supply */
	cancel_delayed_work_sync(&power->vbus_detect);	/* too late */

power_supply_unregister() ends in device_unregister(&psy->dev), whose
release (power_supply_dev_release()) kfree()s the power_supply once the
last reference drops. The driver holds power->supply as a bare pointer
and takes no extra reference, so it is left dangling.

The vbus_detect handler (axp20x_usb_power_poll_vbus() /
axp717_usb_power_poll_vbus()) calls power_supply_changed(power->supply)
and re-queues itself via axp20x_usb_vbus_needs_polling(), so a poll
instance is essentially always pending or running whenever VBUS polling
is in use. It is also queued from the USB power IRQ. power_supply_changed()
unconditionally dereferences the supply (spin_lock on psy->changed_lock,
pm_stay_awake(&psy->dev), schedule_work on psy->changed_work) with no
use_cnt/removing guard on that path. If a poll instance runs in the
window after power_supply_unregister() has freed the supply but before
cancel_delayed_work_sync() has drained it, it dereferences freed
memory -> use-after-free.

Register the work cancellation after devm_power_supply_register(), so
devres (LIFO) cancels the work first -- while power->supply is still
valid -- and only then unregisters the supply. This mirrors the existing
"request irqs after registering" ordering in the same function: the IRQ
handler and the final queue_delayed_work() are the only things that
queue the work, and both already run after the supply is registered, so
devm_delayed_work_autocancel() still performs INIT_DELAYED_WORK() before
the work can first be scheduled.

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires an AXP20x/AXP717-class PMIC).

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 7625366..5274e1e 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -979,11 +979,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_delayed_work_autocancel(dev, &power->vbus_detect,
-					   axp_data->axp20x_read_vbus);
-	if (ret)
-		return ret;
-
 	if (power->vbus_mon_bit) {
 		/* Enable vbus valid checking */
 		ret = regmap_field_write(power->vbus_mon_bit, 1);
@@ -1018,6 +1013,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(power->supply),
 				     "Failed to register power supply\n");
 
+	/*
+	 * Register the vbus_detect poll work for device-managed cancellation
+	 * only after the power supply: devres unwinds LIFO, so the work -- whose
+	 * handler dereferences power->supply via power_supply_changed() -- must
+	 * be cancelled before the supply is unregistered and freed.
+	 */
+	ret = devm_delayed_work_autocancel(dev, &power->vbus_detect,
+					   axp_data->axp20x_read_vbus);
+	if (ret)
+		return ret;
+
 	/* Request irqs after registering, as irqs may trigger immediately */
 	for (i = 0; i < axp_data->num_irq_names; i++) {
 		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
-- 
2.43.0

