Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806600;
	b=WhIg/aGWOR/+60Q+iIU+MGBWRAvFLyXBCTPPTH25xw+C8Z8of+k9ERKjqjfPvYfYSrTM
	 62ytBBved9gMdan5sv5quMm2T3d+JRND3xDFp2zeWddeHK79p6MHXOrMUsr4LeJibIwyv
	 GNL2epo1zAEVqiCBTAHB4NWusPT3pbXs5h8+J/Qnua7fJLz/7HVhoeNmVwOO4zp6jjHO0
	 Mwe+c/XPF960+zZjxyo98cu7F9RaeMyKkEIuWe1EYN12AtA9aC+LWMJYhFbshx1DOOhlE
	 4x/8O0N2sdpjtiDh23J+RO6VPH5HiQ0KsE6pkPXpojwLLUTBek7kmCPmA64SJtXCang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gMUEHr5+RLy5VN9K88In7HKPCt0PQK7KPkn/dGa+2MI=;
	b=bY3EX7ZcU1WFcQMwKIfa6jC2TzynAeodUzr1hm30OVyfPjA9XuRd3cojDmjXv0jr1wXG
	 8mFxaMCRfBExVEHDEsEaWv50zvb1qCb6EQRc7FVcUTsB3TthURBkTX6omgViwEH/7n2YA
	 ey6BkpFv7PsnHtCW5iGXve7o0PgTr8reStOdjItLdV3/EUU9DBMKlZXstK37W7EYlOrp8
	 UM3nBSh4rXugON3mv9IcZ1gz91dLaSRDhC0ppVRLNvgS4imvU9W+6VPG9TPhkxZs8KJfI
	 4FJnKSwoC4/Qh2eXmdW+q4a78wat1bGJcXEFDE6UfjUjnl7q6q5owAI2xlsuAnEUIkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NHAqD3p4;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7387606A6B4
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7387606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NHAqD3p4
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d581da0aaso1156489366b.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806598; x=1796411398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMUEHr5+RLy5VN9K88In7HKPCt0PQK7KPkn/dGa+2MI=;
        b=NHAqD3p4/CgaMMToaEN7P74q0g/caivQ/b+ti0c0fLLKp1cZi98di9wkKw4rsBvdSq
         h7itirNf7U2rBjiZmNVVPGwLRRYw73tIUZ+7vcsgvTU/DDiMPaJe07UeC7r8ah+kNTqw
         0tx4AebCuvY+IhRAa1Pu0StyO8OCUlZHh24CiOhfL4sTELqBXSaW8O3FYibSmOG9LUhP
         4MXKggtPIJ2d+mxDYuMHDOfx+A4UBzZp1iStQUAMGf89UihTdMNAlCddox66SUEgxJh8
         LLR42ozQSaIPi/nGbrf3smVKtcHT8ysYFrgNxGE1DwkOjFKWIONr4zh1kdBI4GDOo2Dy
         J9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806598; x=1796411398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMUEHr5+RLy5VN9K88In7HKPCt0PQK7KPkn/dGa+2MI=;
        b=W5VN2elUajhaS/Fl5nfYWWH0Q1VbrthGK2+lS7JmM1IFr3dPHIkAVNdG6dYegmm9dx
         bPyRxq1Xz+WAku71E0PRUwL3bnUZTo+KRznvE+aRdV69YbyLDPPmcWtqxPMVUT5s8ZFJ
         4Sbvmf/w96tFK9HGsmIfSE8eQnhFlDz+DOGuAe3ze1JezoIkez8aiFtoKXTE4drzJmth
         JuqFKcX+RVl8r8/rgaDrJAwgle0DZCEJmow2gNBZSNtNuyPXKewRgVYMitfgXTTtHyY0
         1kCRmRLrTc9tK23+HKrGKyjHHzbPqPcjTaCV/6LknVHZlo5YXnyeBbmbYvokJblmL/34
         Q9yg==
X-Forwarded-Encrypted: i=1; AL+hErGmz8Z8ukulU/Q/DfzXnMv1SYfUFJecDWvynrAWYI7+/vZcNI+uvjqYKP+JupCNT8zPC/ywKWE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iEc8B5G91Dc0cf4c1Oq5cz4cNbNzrg50NlP14WgcmI0VvuyH7
	bX6Q5r6XVZaB06ZX8ZNmQS80HZkb4ONgVzl5n8bOeWO5wV1DUAibYHZBSsEWRV2e7E8=
X-Gm-Gg: AZFdTZevz8U52uxS3RARvQrus/gcAwNxIdGKETw/Rk09z2Bx9qjkkyKEZKTFNPoYR+g
	VIkGzBWVyxtwQxc632TV0vsZbHt20ts97TsDp5ELTeEazqMmYwHEDpqG8qz80QjFYfHTKuXJUUP
	W+TFbtHJFK7PxIHbamRqX902rBuSIFXhopPxB8I7THwfXQyvforeWyuAdJTj5QKpFmD4xVpoJ60
	wYdz/dimcCesRMq3C4UipdBAM/4CllHQmBRK5xhYKgKV5/4JEbiYRv0r3F4UlQIquDeTKyjkg+g
	Q0iafDebm5bzcIjYRs5r6LPbUKZHD8/lqw/Y3PH8eHQg1ByyV+JJdHKSVdeEiQBKa/tLh0DZ6qX
	dubhJ4tGBMnapjGvGH3fUPw2bRflxehPWnrblYv0odsbEiHvnxQleyvtTNKfjUtGDjoxprIiT2h
	XqaGkXGldpJZVze+QPqJr+8wqIPfZ7NrHjhA7xlL+pOPauaGr9g4A93cRejoPMMzTbHqx0a8Jr8
	TpqzIbwY+sokg/vd6HLcp24QIgC2pUx2+2lVIq7VVwPddYBnPoQFW+4kRc5m78QlorRAjHFNPwa
	Qx7L6ANMhb9GSdFsG8p6+yLFoBfeVulIdKVzy7/OxKTJFJhWYpXnPAMD/Elt5PDKP8h/HtFivAn
	LiVR4ofGu/a3mPl0lSA==
X-Received: by 2002:a17:907:7f91:b0:c50:c747:a4ce with SMTP id a640c23a62f3a-c513a4b083bmr2229259766b.4.1795806598370;
        Fri, 27 Nov 2026 11:09:58 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:58 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:56 +0000
Subject: [PATCH 5/6] power: supply: max77759: sync supplier state at probe
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
Message-Id: <20261127-max77759-charger-fixes-v1-5-b364a0862d72@linaro.org>
References: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
In-Reply-To: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Supplier events emitted before max77759_charger finishes probing (or
before reloading the charger module) are missed, leaving charging off
until the next supplier event.

max77759_charger_probe() calls max77759_charger_init(), which forces
MODE_OFF, and then registers the power_supply notifier without reading
the supplier's current state.

Extract the supplier read and work scheduling from psy_changed() into
max77759_sync_tcpm_psy() and run it via power_supply_for_each_psy() at
the end of probe. Hold chg->retry_lock across the property reads and
state update so the initial scan cannot overwrite a concurrent notifier
event with stale values.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 61 +++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index 7a7d9a54d888..fe71e8143954 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -663,34 +663,31 @@ static void psy_work_item(struct work_struct *work)
 	}
 }
 
-static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
+static int max77759_sync_tcpm_psy(struct power_supply *psy, void *data)
 {
-	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
-						    nb);
 	union power_supply_propval current_limit, online;
 	static const char *psy_name = "tcpm-source";
-	struct power_supply *psy = data;
+	struct max77759_charger *chg = data;
 	int ret;
 
-	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
-	    evt != PSY_EVENT_PROP_CHANGED)
-		return NOTIFY_OK;
-
-	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
-					&online);
-	if (!ret && online.intval)
-		ret = power_supply_get_property(psy,
-						POWER_SUPPLY_PROP_CURRENT_MAX,
-						&current_limit);
-	if (ret) {
-		if (ret != -ENODEV)
-			dev_err(chg->dev,
-				"Failed to get supplier psy property: %d\n",
-				ret);
-		online.intval = 0;
-	}
+	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)))
+		return 0;
 
 	scoped_guard(mutex, &chg->retry_lock) {
+		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+						&online);
+		if (!ret && online.intval)
+			ret = power_supply_get_property(psy,
+							POWER_SUPPLY_PROP_CURRENT_MAX,
+							&current_limit);
+		if (ret) {
+			if (ret != -ENODEV)
+				dev_err(chg->dev,
+					"Failed to get supplier psy property: %d\n",
+					ret);
+			online.intval = 0;
+		}
+
 		chg->tcpm_online = online.intval;
 		chg->tcpm_current_limit = online.intval ?
 					  current_limit.intval : 0;
@@ -699,6 +696,20 @@ static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
 
 	schedule_delayed_work(&chg->psy_work, 0);
 
+	return 1;
+}
+
+static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
+{
+	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
+						    nb);
+	struct power_supply *psy = data;
+
+	if (evt != PSY_EVENT_PROP_CHANGED)
+		return NOTIFY_OK;
+
+	max77759_sync_tcpm_psy(psy, chg);
+
 	return NOTIFY_OK;
 }
 
@@ -773,7 +784,13 @@ static int max77759_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to add devm action to unregister psy notifier\n");
 
-	return max77759_init_irqhandler(chg);
+	ret = max77759_init_irqhandler(chg);
+	if (ret)
+		return ret;
+
+	power_supply_for_each_psy(chg, max77759_sync_tcpm_psy);
+
+	return 0;
 }
 
 static const struct platform_device_id max77759_charger_id[] = {

-- 
2.56.1.839.g22a8290db9-goog

