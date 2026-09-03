Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707033C553A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463873; cv=none; b=H/c+zmZgAEBFoqNXr/kRoEBBFsPC+fXneoS4WCEtzCUiKKZPgYVcBC5/m8qn+pT9J9yKxiEQRiUPGWVtV8prK8rnlpluN6D/a0JEjKb2pTTg/nJcmfhPIaB5p+eWjRzcW6U1PpA+CWkLuCDCr9QGwvsSq9/IaCYb1nKKKkKjjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463873; c=relaxed/simple;
	bh=sPieW/XMxA1aPDsb/aIFP2+oe40K3qdsLeR6duFXD1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7bvJOChaS4T1qjfg9jt2mAf1Wi1UsGvRjkdxh+kWuXKFxqpcFYUY1pQ7YnLgsxYDU08mK52W6EB+DGVTVcO4/vHNHvs6M2ykOYyY21uI7ajmwQlTFo9cxjRyWOHk3Q+Yf5HYDLLT4OEFs+6D/fD7dT4mUMY5Skbj7eXo/YlaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlZI+peR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlZI+peR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d5335cf904so1802195ad.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463858; x=1789068658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4u3M0sxZUqmdiAJH52liPLQN2L5yD3cqPXsc6cd89U=;
        b=PlZI+peRfuXk4I5/ySdd0Jw+g7JFFfPEhKcFzDr5LY4fGc/p/nq2yGnc+8Cq9labhE
         iipovlvVinCv2XNCiaP7kmIrPi0+rMXCHQQPXIGdgGifn35yRiAubj5VXqeIgyzri0uJ
         ou/ODXGrTumxV5R94seXyH+VVZ0TqFEfZRd4RZjJjG5folfr/nhDNZxLgfzdwgPx/nt5
         5feV3V2O4QvcqUrtn12SmpRIhq+TywLfoHumCU+YMi9EKT5MnG6RUp/bKuvjXMDDsDnc
         9XO9NjCUcXRDsFgA27emnCzJJBAWXikIIhwnWF+3EshxTGUGyNgNOeVwA1jfsiwNqr96
         /Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463858; x=1789068658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4u3M0sxZUqmdiAJH52liPLQN2L5yD3cqPXsc6cd89U=;
        b=LM4+Mh9LGf7+CO2jxnp1V+5USF9wNvkXJGfaE9CX3B4+9VpK1C+uS/LhNirLGHoUrJ
         m35f5z3LrsdplR9k0Tpj7Eyp+oNM3oFp1Gv7wFLkgBUrOWQEyeLHsy/i6JRHKam8N2fB
         /cxvKg//xGByD/Yc4jG8y9JixpfGLclbpghROCd98QShfTkMttGMoSzOTx7F/2rEMOXY
         yZPpUd1mUp/IBuhDdoKGf9e1lOL/SJU4rXrgTM7S8ZzSx8jvSCjDXHOKcOILU7cma77E
         LJlQd1G3j2ICffQyXkK9RcxuMPGsVLWsWlooux7CFexGECz8bTZ2yl+wxcfcYnNbt9Tp
         Ja0w==
X-Forwarded-Encrypted: i=1; AKwUvBxlv4xLkr5oKtm9QkXWBlwY3M/1pxe89yBiP6Yu1OHvxckwFQ/mwGDOUk/n8+z9FXYmyfKXLdI=@vger.kernel.org
X-Gm-Message-State: AFuF++kWGFK59Ptj41EXmg4iicMSsLlghHuTz4xuMWrS/AgkhmrAXmjT
	x8dVu1xB+rOP7qyPp6ot2Iqg4zWOnJPPYd0KcRdCafCF7I2RW6BKODOG
X-Gm-Gg: AYBFou0H64nDGXMliZDkZbbFVCyR5XzQJW+UC8X6PJYYDLDiO+gKe/XQGdSs2RHWfRN
	ZF8Ba9l7CbRQqObQWuxCiTbteLj1lmYkHY9wgjDVEVrLU33flRUEQp2vFuCMiiVj3VcwLHyRznh
	qsK2OrK0kpAre5Ey0E8Ww5lQaKDAQDB/LkeX/zrYuttHCfcDtzSQBe2TKC0qO20imf7WKUSmgtx
	zi19u7fHbxidwjMHUEmN86VQdqCU9S5KKhFAvCUyih3EfunYIAUY0xIT2MvXrgcl+mD7qaNeXo9
	lfmg2rxzhb2bcYJfvpMUV2EbI2GJ0lQCq6NRzn5hlal6qC+QHVgcxDcZipoTVbWmeCkZuCIbpwn
	bqHGg1s9B3E+KW+/+zdOxZJhe+46yMXyPyyKNQuxMGCPXiODaQLHiGOl2ntPQK2JRtrFbYdSb/Z
	xthoQqWu8zgIkBu+pFgT25o1XbG/bKK5CbKMDI75i4OE3I+LBgTpKzckEZXNX+37dDgj7mqksj+
	UDNnISeqnb+csDO4cB2zSwLyu5tgqIoyio=
X-Received: by 2002:a17:903:3803:b0:2db:117e:cf50 with SMTP id d9443c01a7336-2db125a5895mr20300335ad.4.1788463857912;
        Thu, 03 Sep 2026 12:30:57 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([223.160.226.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae53ddsm396985ad.78.2026.09.03.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:30:57 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH 1/2] Input: tca8418_keypad -  Add devm cleanup to disable interrupts on unload
Date: Fri,  4 Sep 2026 03:29:41 +0800
Message-Id: <20260903192942.21906-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tca8418_configure() enables TCA8418 interrupts by writing the CFG
register.  If input_register_device() fails afterwards, probe returns
an error and devres releases the IRQ handler, but the hardware is
left with interrupts still enabled.

Fix it by registering a devm action that clears the CFG register
 when the device is released, disabling
all interrupts on both probe failure and driver unbind.

Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 36d4a7c38bb1..9f0aace6bd21 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -270,6 +270,20 @@ static int tca8418_configure(struct tca8418_keypad *keypad_data,
 	return error;
 }
 
+static void tca8418_disable_hw(void *data)
+{
+	struct tca8418_keypad *keypad_data = data;
+	int error;
+
+	error = tca84818_write_byte(keypad_data, REG_CFG, 0);
+	if (error)
+		dev_warn(&keypad_data->client->dev, "unable to disable interrupts: %d\n", error);
+
+	error = tca8418_write_byte(keypad_data, REG_INT_STAT, 0xff);
+	if (error)
+		dev_warn(&keypad_data->client->dev, "unable to clear interrupt status: %d\n", error);
+}
+
 static int tca8418_keypad_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -356,6 +370,10 @@ static int tca8418_keypad_probe(struct i2c_client *client)
 	if (error < 0)
 		return error;
 
+	error = devm_add_action_or_reset(dev, tca8418_diable_hw, keypad_data);
+	if (error)
+		return error;
+
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
-- 
2.34.1

