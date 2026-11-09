Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215807;
	b=Sx0qA7Z7buZAYGMTKbwVQdKLM/3iEzeYeVVRj2vzXEAzatVBvZHWwUPmXMwVieLB5uKR
	 U8gg4msD/hLkWoae4/HPa+sB5F4EUiG/OaMboTqgj+C2Q4nTSsGVjO8Y0X/sPKyV0K2Ii
	 HZvQIn6wh07ynlji/BAfPQH+s5Dt5hRgtb2bRNsjoVNABi1kH6Tqa9vK7rbqFOIJuz6Aq
	 FTMg3ZD0u0Q/mF5jye1MfyIZY6jVYHNcdT9JhM3flz6/HoqxVv2EDPjE8h8UijtexNFLp
	 2fJld+LCOL9mMLjFJAe/yMNdsVel23TIAfl3vGvYRqu81/HcCt40PjYmT00SX0mbziw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4JYzGansMqTukkQ4RDlEbc+etaP39OGNhJKIlvghSHo=;
	b=CFOsd+oRs3aNqz01mYliJflwHiM+fHuJYERHvgB9jLnv1nEoxT8dQbJrrt+AqlH8K1sx
	 TyzH5kmMgiIag+lkpSg/z87Px4WJYUN40VwQM4HP7xrShiztQccHbZETJqlcBYYeWjmba
	 oqqBehndvetGcHzTRjTr8olS7qKn3N1OAzLyWwzqpOrXQVQgjyHy/9S2CPm8gcTTS2Qa6
	 N7q46b8fL90+9FxPE3dtp4LegM7LBgMU8Z3ezRlIVQTKBkYKj1GMenPd06y7/6y9O6UWv
	 gazUkg7X9CpkYENmgtoGq9QGyPgOSGeuLbCbLepf0z/sf4Mbafbj2KjayE4mErGqqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlLjh34f;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B3608361A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA4B3608361A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlLjh34f
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so1123255c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794215806; x=1794820606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4JYzGansMqTukkQ4RDlEbc+etaP39OGNhJKIlvghSHo=;
        b=mlLjh34fWJrUQyEM0QJmTVBhUuD6/MixZtoC4K422wie0uhVjBgC7cFSJIhg0EEW7v
         Sg91/qMumkPqqy85RyvTY+NVBLzB3L2hephR+u2b9TpvUSD2MaEX/LZ5f3DwHp83hFdN
         BjluUvZwYl77/TT+iPCH8jRS7cAz3AMuZscmUWE39i3//XWmoUbRWyVYoPW6YDikf8t/
         349fvuHYw19W++3018hUZm2tENmljkwSZVt9FFewfA2Rlvbu7ewhROR6Qu+gMHB7EnAl
         25cdb8o1HmOWLKQ58KbDjaecDL4kgWdX7r7jVFHki8IGVrzT8bdr1qsrU457ZGmEWHk6
         0I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215806; x=1794820606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4JYzGansMqTukkQ4RDlEbc+etaP39OGNhJKIlvghSHo=;
        b=s5Iv81NeCnbn9VgWvt8J56MU0iM/UEDPcH71G6rX5KW7dWO9D1ZTNpRkqHiTLSmQLn
         yZOpnEmD7CZbW3YloBsRFZJ0xe58DCzUZABxZKvWhRI/GLNyHtS8GuUUn5W5UeLTKa4b
         NQywo2cDYbPxJSReg1H86qwXMpIvYGV3DTbsWVzYq05w4FTkJOUTUzqRZyTPgNeT8N35
         WkdTgXDYj93EQ+85MtHYzgY4FMe2bRY5EaX0eB5Yy38vmN+3+CKPvE6hYDiA3+Dwtq4H
         Vg1hSJWaioszEiwFqX5g8tHtE3HAn5UGJvDxEEZiTKdlRMVNbJYRJ9GqRFLeWABG3orC
         e8Kw==
X-Forwarded-Encrypted: i=1; AL+hErG63HAM+Eq0pl1Yr0E9cPAmnKHM1HlhqcUeQwngq2nsDh04szhbh/Mz9r75FhWWGQyJwssyvGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W/nFGmcFOCeNsuS4Lrv7bdTZska+1DCl9e/hwRXkHAX5RpzXH
	51qUW0hIGLkLgBFoKuK5+WUrWeu5XZB2t7NrDs9LP4CWG0ZuwspuOF5B
X-Gm-Gg: AYBFou0DQDNi29QK2hqXjUajBwqSd+v9Bn8E55WXKleTk8NkoRnlXvmv3vWX85aJok/
	C+38zZlWX4i6Dp845vRH64WQFRECS4HhYepkdrZBzhkN52ykeyDP6BLvB4AqmhfrDzb0obLTBT0
	aEyLA6v4DjFR5qqbN5MAmu0ZBPmUN4UmEmVkDt4vRvpUz73pcya9vb6QsKbJZ51UxhRITTmTe5Z
	8q8+uruThzpUe8Go1Qo52NIMCLw1xhb9tbUe4ldSVlpJf5jGlCtCUIIyfKo6hJJek/nTIR4e9sy
	bF+7g0YsadYYAMBXdNWTjpqM1AboBgQLYAG7YODgJNa0GNA+HAh5YnEjH9J6olt0aKaWGIDUJl4
	b0xhw0JrwYiLsSLbjrRXSWyNTwsbRUV40CnaglwkomEp4MlAWDob5xfhYlzZ6GvTmsLnHdp+5hp
	812tAVCPBiVCHM/WFqLhlGvEZ+xoLVRmDeCkgo7PwfYRUTbHfsyorSSfWwwX1HFlqtOf8944lD8
	r48EhjJfT4Xmy25XUqMQESRSxmWH0OYoH6j786+p+lo/UNf4M3tDPgCoReytCgmuamNAzXrVptB
	Ny/yAP8ydFuQSD6160RC72+LEEcypCELI0+//7B8MQOkYRP3KQ==
X-Received: by 2002:a05:7022:e02:b0:191:3c:aae7 with SMTP id a92af1059eb24-1b39feec174mr7917195c88.26.1794215805760;
        Mon, 09 Nov 2026 01:16:45 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375728f8bsm10675160c88.15.2026.11.09.01.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:16:45 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] phy: rcar-gen3-usb2: cancel OTG work on unbind to avoid use-after-free
Date: Mon,  9 Nov 2026 18:16:33 +0900
Message-ID: <20261109091633.1430331-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The OTG role/VBUS interrupt (rcar_gen3_phy_usb2_irq) and the role sysfs
attribute schedule channel->work (rcar_gen3_phy_usb2_work), whose handler
dereferences the channel (ch->extcon). The channel is devm-allocated, so
it is freed at unbind, but nothing cancels channel->work:
rcar_gen3_phy_usb2_remove() only drops the role sysfs file. A work
scheduled just before unbind can run after the channel has been freed, a
use-after-free.

Cancel the work via devm, registered before the interrupt is requested so
that on unbind devm frees the interrupt first (no new work can be
scheduled) and then runs the cancel action before the channel is freed.

Fixes: 2b38543c8db1 ("phy: rcar-gen3-usb2: add extcon support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index b5ba751..35e519a 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -1171,6 +1171,13 @@ static int rcar_gen3_phy_usb2_vbus_regulator_register(struct rcar_gen3_chan *cha
 	return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(channel, enable);
 }
 
+static void rcar_gen3_phy_usb2_cancel_work(void *data)
+{
+	struct rcar_gen3_chan *channel = data;
+
+	cancel_work_sync(&channel->work);
+}
+
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1277,6 +1284,17 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		return irq;
 	} else if (irq > 0) {
 		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
+		/*
+		 * Registered before the IRQ so that, on unbind, devm frees the
+		 * IRQ first (no more work can be scheduled) and then cancels any
+		 * work still pending before the channel is freed.
+		 */
+		ret = devm_add_action_or_reset(dev,
+					       rcar_gen3_phy_usb2_cancel_work,
+					       channel);
+		if (ret < 0)
+			return ret;
+
 		ret = devm_request_irq(dev, irq, rcar_gen3_phy_usb2_irq,
 				       IRQF_SHARED, dev_name(dev), channel);
 		if (ret < 0)
-- 
2.43.0

