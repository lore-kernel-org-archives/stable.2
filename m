Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199371;
	b=dSz1Z6w5Uq0lqXQB8Ois6KYYmudxcCOBDiLyORI+tdsL7Ls0sJQEaVJ76fV2LnzroSjk
	 8DhIiKmZlmFKY4EyNXGBrBp5aJ7Dl1/CdSYF6Dd+L7LnXCEP1AhGxXqvgo0d3dELu0ex/
	 vJOX2A7NiqAUqQ8FB81KZBj4Ex+/j7DzcXxVUIF7GOIPVN31DRGg14zACjzdfbTIiFQXc
	 Wy8egHWO21wr5x88wrV5OtkPv9gy2J9RAbNAzoTaUA7pC348QdqZBDyLnMzz/GcXip/Sp
	 7QPR/0EE9QJe0pZd2dckN3OOiSKQbcoFLqlGPupctgqxJ5hX4ps3aP34uhlEiVGWsMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yZy6juQ/C2+U+L3WTVvMgyAkJHBU1cX+JxwPunI95Oc=;
	b=TKwHQ2YxbTzX+d6pgXuSEIyFzyOYGc+T4Y+/sjlicqhqBz/cY/f/ZRkm9ndqMWWkCnG2
	 GqsMBzvJV8gF8FbwQsj3iiNamw2mvlRQi4IHV04Lo1V7gQt7PYXlATenHQi+0uZdM4JbA
	 D6zbNs9FB5R28eirS0rtQZaOkjxs4782XU8GRN23EEE6enaaHv1f1lkdY9OzKYqpld0OL
	 Di5H5Lhhhw43TIh0irkeiWyFuNeVdktk+TFs7dmJpEBUCmNhmj+b43OrxdV+MjYrr7957
	 rxvND+yrAexan36846WAf3PedeMMIO3sawAOgIZ82wRB711foEuHCv+RLQQQDO3gK5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XkWijxTT;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA40606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 04:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EA40606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XkWijxTT
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1185590eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 20:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199370; x=1794804170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZy6juQ/C2+U+L3WTVvMgyAkJHBU1cX+JxwPunI95Oc=;
        b=XkWijxTTWAqwBLhYURWexse90j8lVvME6HjHujR/avU4s8oe2xbjRMSMCFK97tMZ0b
         O6vtS6ERCGtHtCCyAdVbQd6/PpIn38zebhx6WxFlGf0NJIRfX1XkoCxqRZKqmxmCCpgO
         9mynUDx4Jgh5HXko5DbENTlBkZFuAx48zd6c97EQG27tC55FN9ikxX3vl/5iR4pvYO/C
         PsF+hP6z6mbVbb04Rpe2Qy9lmsAoRXK5P5F+z0UKtMr4AyTxrzev5IWcY+WvuALVBfnZ
         Xrk3aVHeo/wYy7IZ0+8e9aAQY2Wo9+KtMHSbYRouYdVZZ7WxPh9Eh+qm/yNIeOxqhut6
         SuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199370; x=1794804170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZy6juQ/C2+U+L3WTVvMgyAkJHBU1cX+JxwPunI95Oc=;
        b=aJ6pSmxhVi2Lv+9bN7wegxAaKCYQ/IiklUEJTEEhoWd1YLKWXo2nbTHM11YiIakW2V
         ZwxEwSOLMcg7dwwLQQFfv7D7Zx5v7qJ7R4TVdXN2zJ1vhPdvGkX2vTxKh04EIXMUVvNG
         vi6Z0iKgKPjty2uzGdbPgTLRGccYpgMQoTfPjv43gAZxR4FyqGKnMHy8ixORPWaMMbxp
         zZGTRdHRFdPtd2aonGfCjh5RgQvR9SI4JpNO8a3GhdKeurw24d9QogNkT67LEMhWcbLH
         Cjk99G9tU4n34VHOIWVs+ath5d4wDnr/3xYn7yp1sq+eoBnKweQp/taotwIU+SOjPuct
         jIwg==
X-Forwarded-Encrypted: i=1; AL+hErFHHx+7Z2hGEQTSBSRs7YTrjpkS1F0pYGgGSyXscCb+aa1NVvkB9VtxoK7BOCEdm8j+2rmUYjQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VB2kEdl1d3pPHsv/YGkHgt5BVbd66NzrCNDLPO3xXFBbHOxsx
	GyzezSY0wRoEk6pPPXvt0SNVeE0jItvAjrTRTNtCq7DSnqC2Q/Ri2BYo
X-Gm-Gg: AYBFou0RhnUoZNvxrRLGZ1sxsa8VZf/Nk7gQk4nUpwvjnVelSXCQYpY0kz4i0fyLgk1
	sedVGZ+Be/bR//S5lPnsejUE3fbNeodg/KKKt7g65O/1ziTgKcuX/ssfu0yt5bxs7bh0zGDoBdG
	WV/5FtrI+KRkbs1Eq4jLmGi/3UbLqTrZoyaMypJ/Oo7fn+W/0BRNCv6b5SjVUDhpMtCYQCShYD4
	hpjmgL7HgY8jgFP0sYNKvmb8G0YrPNgCmxvi2eg5aQQ650k4AKYlnLtxyhRKWEXHToZnmOGoOmx
	3/RKCVTG4Htwk62O94pXg7/i8oNJu4Um9P980xG1PJxjkMP3hMEHWZ3pQPeuu8iLTT37kcRT+aW
	7ckbKKZ4Z5b3FXdu0OT/2AFu5vKFYabh511OWFS27+g0T0KmcziHbhYmM4wLSzLYMUWaJdtH2bi
	FpTd19pJu7ZwT7xE6GE23cRdvVvw1UJ9/ofpqsqOFJVCkLiIIei4gKRiTvOtuR0QHFTQ4gfnRhF
	1mSjVC4K2r9j6kBLjDP8s2KZdi4sq5klBH9i79nfO/GuqkbmwGEBnlnjF6cRoFELH6+bKBHNYCV
	/lz1GG1KuZw2k4o25Ud4ftX5fMIJJxh27zGfYY4wwGeE74/6
X-Received: by 2002:a05:7300:da10:b0:36e:8e6d:a0c0 with SMTP id 5a478bee46e88-3725dd59dd2mr5386387eec.19.1794199370484;
        Sun, 08 Nov 2026 20:42:50 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10154026eec.4.2026.11.08.20.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:42:50 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] power: supply: mt6360_charger: drain chrdet_work before unregistering the supply
Date: Mon,  9 Nov 2026 13:42:12 +0900
Message-ID: <20261109044212.1157357-4-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109044212.1157357-1-hj351016@gmail.com>
References: <20261109044212.1157357-1-hj351016@gmail.com>
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

mt6360_charger_probe() registers chrdet_work for devm cancellation before
devm_power_supply_register(). devres unwinds in reverse, so on unbind the
power supply is freed first and the work cancelled last.
mt6360_chrdet_work() calls power_supply_changed(mci->psy), so the work
running in that window dereferences the freed supply.

Register the work cancellation after the power supply so devres drains it
first. chrdet_work is only scheduled later in probe, so the move is safe.

Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index b4d462343151..71c60ba012df 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -790,9 +790,6 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)
@@ -828,6 +825,10 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	if (IS_ERR(mci->otg_rdev))
 		return PTR_ERR(mci->otg_rdev);
 
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
+
 	schedule_work(&mci->chrdet_work);
 
 	return 0;
-- 
2.43.0

