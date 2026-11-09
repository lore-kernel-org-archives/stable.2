Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199367;
	b=YaOv+OsUU9WlkyiEn9Z0OdXS2FOhOKVLzHahhp39aQnY5YRWWqN3c2XhY44DI/zIvfk3
	 oha3r9AkC7FUHvf6SDyP5t/MLUvTMibfG+SunTDDS9OUxT7NYPQ423R9LJ7nF/qNseKaO
	 e+xR2ASBSiYxoNVVTm8bhvaDdrJ8zxf9MzIUrsBLRlIJQ6RbkVNaxObYRe3Or2DjxXHrB
	 pxr0jExa2RIIyi5xzywNHnr1/oOQ4eXyrCzeZZquLdBwxXyMmV791UQ8mh9t1prNXhTEp
	 a081iUrfejhmNS5RUqC3qLkQ8333YegMM3EKrE6U/BcmJNfRgLakJ+iieROhFI03ICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=shxUqKnWZYz/K/hcqwVzW+1VupY1njR3r4UW+YRvWGE=;
	b=BAnGj8ohIUdswlqwuGgTMAGgfubZO2R2V0TpnovDxRKtdBGmtyJ0sacvU7mhfrcscAnW
	 Vz6r5Qp5HnCoWP78O/NGOTmwCBr43PsEefXeYRGQ1HWdZevofwG133kFkG3xejZENeVct
	 s4hyQY45i9tunronYwF5zuuzoBssYT9CDLhW+bwhZPscynWwKwoBESAG7k5J0nPsALN1V
	 WQ41l/paq6tN84g2pRdd2COXYw0tKH1T1OZyFllKSH+Rx/9YnYIJK6dsa0nc435Dx4xOr
	 DcXiLcRhb9Kbeti/MJ7gziWnzGDWn0+S1bAim4klPzhEcF7EfY0Uo+89ilnE08FznNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aFn5/jAp";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFB606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 04:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACFB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFn5/jAp
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso701959eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 20:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199366; x=1794804166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shxUqKnWZYz/K/hcqwVzW+1VupY1njR3r4UW+YRvWGE=;
        b=aFn5/jAp5/goiBRVghRUHFdJZk1JQT8b9Cf95Pg++7PNnY69wXy3Q1A9iJcXCs8u6L
         qAGQ+TuTq7SmGvbz18K6y0tH3SGtviISG8F9JB7+Ty713HKQU9468NQlKUkI5m7VPbV0
         ziVWxVwpunNz1y8joLB0gHSgFGoJ7ALKA0vzYn3fFg7X8KglQNDV63kdby5pEUc0kdBF
         y3GiDwYIvUrsZgxICqeAs4xj87CCfCyA0av8vGdo6DGfQeAYdSRq0vgt0pjDDv238C4F
         pO5zgDAsntuYNM82nLMGPWanRHIdn+j5rrBYt4CqWV/NOj/w2u5BLY8XSMhYQNaIvz+Z
         2cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199366; x=1794804166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shxUqKnWZYz/K/hcqwVzW+1VupY1njR3r4UW+YRvWGE=;
        b=pl5WNonesrKOzK8iyy3E4OyB+v2BXtbNqZeUowmjTdUaZYeqye0yP5hVhUzwp5bvK2
         wiEoxEUQ5RUL0ZDqQVHkPutcZ8SwoZdB9S+UUgXMGNxXys/YdnLH44SwNY5stmcXPFTo
         qQnFH2r6YQP+LI/oDEgl+ikfqx+1CE2wuKnfXLRfp/sDlfevg+/nOrXsUoGbxgNquHpY
         HaqnfBTavm3UGISoca1FGiXFhzN8zjifewBRwH0F0weKEP5PhZI1wBpyUiz17DEsfSA9
         8I8RMFy9bLvOHw6h/mDO7DIcjmoTkxAt8acrjCyYg1dedqc9NToxJfSSj6dLwDeMWzhk
         v2Gg==
X-Forwarded-Encrypted: i=1; AL+hErGfs+kXzUHTIWay2TL8aq10tCEn/f7lY1QSDm1qcPpV/ppOOiADTBqWBD3qLMsu3o9pUk21610=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eK6qjqToR7bWJ/TqNcijDZ5z+uDSZI6eB6zF+oOo/X1WXh11J
	J09tpvnB6Jal9O24sP3wAssUPhzvs/51xPaKTmDsbUnWOQCi4etQ1vsy
X-Gm-Gg: AYBFou37T6B2S4GMTk55dEct9LbeiJwxamUBdjBEduWDTLIDuxm6lj4db6Vk52mCIC3
	rV2R4/ki9FGwGGRe5pp21XVJHoQMT7CBJM+hylYwbt8nSNfp7TbqmlfZXN8BwEM3Ubs9ezTRaAB
	IlEw6saKPuxdlPA6w9v9iw0NOmJCFjYQSyTByFZhaU6gg4NlLoFHCRNw1Koey9AL4b0S3QF90gL
	UXVnUAa79krDK4ZOO552bnk8P5R5CIxmbvHwbEZKCn9vN0NSav67mSFfprBOLVgQ1JlQzRtfBkB
	bwlUe3mbVtsdKUCNnQj/+hkDve1mdNHBfXn/r6KkDwg0S3Dj4ANF1g9qsT6wNq5sOkdvi+CPJ+Q
	9QZ5kVgNmM7A9WzaD/TSKtOjtr2qA5aOxOsp4VRZCqM9CBrm/zUPR+S64+uuvsSOTFAAwxGuUyw
	2Ly0M5AVYqkySeqMXlFJcVoOvYuKIga0rpK2ggnyfPYo2aQc8WFuNok6uCRDPld/OQUyxKhMXfV
	JuTLaiaw8AXd1394R8rVjX9bA9qJK5vaEl+jN5DNrlHsOmEkaX+gX+eTbUo7ELMA4j5gwZc03GC
	vgrJNht8bcyV9Roae/p68N9Qnr58sGSgrHtMRDWEvtuazlRqou8wJOW74syyAWRwHsInww==
X-Received: by 2002:a05:7300:f14a:b0:369:f9b6:f486 with SMTP id 5a478bee46e88-37256aefa73mr5940591eec.41.1794199365785;
        Sun, 08 Nov 2026 20:42:45 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10154026eec.4.2026.11.08.20.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:42:45 -0800 (PST)
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
Subject: [PATCH v2 2/3] power: supply: axp20x_usb_power: drain vbus_detect work before unregistering the supply
Date: Mon,  9 Nov 2026 13:42:11 +0900
Message-ID: <20261109044212.1157357-3-hj351016@gmail.com>
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

axp20x_usb_power_probe() registers the vbus_detect poll work for devm
cancellation before devm_power_supply_register(). devres unwinds in
reverse, so on unbind the power supply is freed first and the work
cancelled last. The handler calls power_supply_changed(power->supply) and
re-queues itself (and is also queued from the USB power IRQ), so an
instance running in that window dereferences the freed supply.

Register the work cancellation after the power supply, matching the
"request irqs after registering" ordering already used below.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 7625366104bc..f6a7dcbd5a01 100644
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
@@ -1018,6 +1013,11 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(power->supply),
 				     "Failed to register power supply\n");
 
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

