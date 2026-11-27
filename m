Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806596;
	b=qfUViPQh2tvjgTlCJJbrSztwiwE1RRcQkfCFuTh1bhbdhOR2UysJh/e6WvLoZJxeCqhD
	 OcdbPGh27mmMoDWyIJ9lfxpJlHUDysKLp3vMWC2WL9fU55HV8RnKhqVVTCFgcqgLFmoJO
	 ET7VEbXTP6PH4lzcv7NNL06kXjwqdMkwOwuoFx+trTgYtyIR4kCLKXUiqa36pu5Sh3COP
	 9o/QagJ/XfhWC/7gmfRCwENI2VoxhBTGoksb50JiHzg3HqAp3sxaj554Ow20Ni1pQC6K9
	 SK2Lbj3v2mcOyqDHGDPOxDRf/askKmNtQBfjLa7nZF8gSWJfYiv4s4aFREdMrbok6Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Tu6aU5M+2skw7CfMYibCOfN2VIrKMUr0DGrXBqKQg/o=;
	b=yTm/R67mlS0hSH30q2WqN++pxow9hymvcg12z+IVFjDqq+3B1GH+FmZNGjet/WN3x9Ss
	 DK1cS6BuTskdrhMHGH3WibEvPqGbF23vTruCisCcjJlMNblfgLAcxS2gS4jJSDyZlOw4x
	 3+1VstWflQ/DuPjFewqLvJYzNqJ7lciitH3ef9hk9EHzAKGa6iWQwgxVOLLsv7P/x3D96
	 kWRkbPVerG4kNY6rUkqychWG4DyyQI/jzV83465adu0b3XS3jgYdsgRfrMx3SSHxjPtx9
	 InFUAIagLmNBZFi63zvtv+k5LYth5eFUlhXws+pw1KO3/yy/7WNE+tj2MsNMJDSFRfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KuHLCcON;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6C606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D6C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KuHLCcON
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d427836e9so1110782866b.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806595; x=1796411395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tu6aU5M+2skw7CfMYibCOfN2VIrKMUr0DGrXBqKQg/o=;
        b=KuHLCcONKN/HVhsBI9TzyEi5Mg9Hq3SCuUlQlJ79BrOlTnZklbpObXySoxYMduP4Z0
         ijRMm1JehwT/dvpBiNKTqYY2VYRE1RMUEB/3QAJbBEkoaLbVn+3WbVhFaPZ3Rv9QgEgS
         GtuStUWfebq0CM2RF1shYKfHry5QmOreDOAKNbz6ccJGegteTode191u1yJ4Tnjnh+Yl
         K9LgTInPnq+2E4tzlMHKxQttEwyUvE1u9rtO4elaqL8Pq664+79udIBBG0orbYRzVV3v
         Z8+/0VWiVm+kcpKYqWz1+mubXEoVCmIMIR7FddYfSdiVf2tHL/BhBi1oKilFp1sFJLvN
         I4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806595; x=1796411395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tu6aU5M+2skw7CfMYibCOfN2VIrKMUr0DGrXBqKQg/o=;
        b=icbJ0oeVgzfLv3BMXsvIgXfDkJlIDkbzK/vQtxouxNIwXqigmtfXJK0dvocHE8ECg+
         O73JyH5yPQmu5XjRyttchgCMzdYIkq2GGkRTEx/CoQUmhVwtW28tEEe1dc0W8aPMnMWi
         du6pan0b4Xjm5Mx2MpkhsZomlNIqNMSMyWxG79yh27d9mrTB8RBN0e1gSb6pSdpzwwIX
         fwXWAJkstga2oF1M2dt/P0N22ZFA+Hsvgt9uWjGfINs/IyJjxH2INg7DZgBgHiMA44bB
         UIBbVLaL7ec35ihj79esKHEx5m5eEAQrvd8q2+Wrz9M+SsgzGT+TZxE4S8OgIkJ9Pnfc
         ia7Q==
X-Forwarded-Encrypted: i=1; AL+hErFoE4bJnQkk+hqnz/8Aw3PIWjnnWmegIjB67WEAIrjQltG3PMnKP2aiWGruJM9nZwI062aQhVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8em4949wGaYv1tI0Gx1eNtEcsxHSzOF7F8uEy7GRKYXuxWf/gN
	M8cdtk1wzSGaKaQwO01qYy8Yzvgs9yhaPUrKhbNlv978MG07ruPJP8XE+H/Omwy1g2Q=
X-Gm-Gg: AZFdTZcMY40CmUN1VXNRGsZG7ABoOqcI/zAQZpVm4ufEBCb++CCDQI9zvyOTF5KVNbt
	fJs7rtgoi2edYyjxyjnPcJzuG5SWk2mWjqNxKoBDcf8GuJHahlr89LUHqa4FHzWXJVmDlEtKiVo
	Tcv5F2paRtjfcsVQi34IE+A20d41TGukXbesnYNUfkJ6cPtjy7fLxrnYyyR1OZKjNNUn7HhsgBh
	0kya/lM8rKgwMrLfAWF/5UyXgAc8n/qYGqXFb8aO0hUsaBNLhRs7f0OPGFaxst6pV/4pNR31+2E
	HDaDm9hCouL8KxGGy+iv/0m7vejjHjSYFAfjcvXxhFZWcRus1QJoQryLaDtwBVuY7vWbBes2U+N
	35wo9LWKdQQKhbCUg2ejomDekFh1KgZfQ80vCiselwoodi2KmZGIID1HKIdnm98Q6+pqp0OBWRe
	RDhFiN4KXSy+QpUtIxfKfw9UwHt0kYx3EnxgpBSl8AV9nuPygVTM6ui6bVEnqVs68r2MD0wv8T/
	kuDabZiZFn6UxDEVrtYD0aMpIbDojVfIzKv9PzMyp0tiu8O61pT3lhOKBF8Jr99EJnwU+Roid8i
	qeZSxtEbgBtA/TFdqVoqoQdblQUeuI+SXI5OlEnAajdvaySh/YV+9odDyN/ou0D2RiNwLKCXvGd
	j6ewwpyIBAkYZy+jjbw==
X-Received: by 2002:a17:907:c612:20b0:c51:2583:78b9 with SMTP id a640c23a62f3a-c513ab477e2mr1558459766b.34.1795806594992;
        Fri, 27 Nov 2026 11:09:54 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:54 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:52 +0000
Subject: [PATCH 1/6] power: supply: max77759: fix use-after-free of
 tcpm_psy
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
Message-Id: <20261127-max77759-charger-fixes-v1-1-b364a0862d72@linaro.org>
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

Unbinding the TCPM supplier triggers a use-after-free oops in
psy_work_item():

    max77759-charger max77759-charger.1.auto: Failed to get
     CURRENT_MAX psy property, ret=-19
    Internal error: Oops - BRK: 00000000f20003e8 [#1]  SMP
    CPU: 6 UID: 0 PID: 96 Comm: kworker/6:2 Tainted: G     U
    Hardware name: Oriole (DT)
    Workqueue: events psy_work_item [max77759_charger]
    pc : queued_spin_lock_slowpath+0x388/0x3c0
    lr : queued_spin_lock_slowpath+0x120/0x3c0

psy_changed() caches the raw struct power_supply * in chg->tcpm_psy
without holding a reference. When the TCPM supply unbinds,
psy_work_item() gets -ENODEV, schedules a 10 ms retry, and dereferences
the freed chg->tcpm_psy pointer.

Read ONLINE and CURRENT_MAX directly inside psy_changed() where that's
safe and store the plain integer values for psy_work_item() while
dropping max77759_charger::tcpm_psy.

On read error, fall back to offline (0) so psy_work_item() disables
charging without retrying against a disappearing supply. This is fine,
because the only in-tree provider matching "tcpm-source" is tcpm, which
returns cached fields from memory. Charger I2C retries on write error
remain unchanged.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 55 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index e792327ff14f..a75005c0b582 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -77,9 +77,10 @@ struct max77759_charger {
 	struct power_supply *psy;
 	struct regulator_dev *chgin_otg_rdev;
 	struct notifier_block nb;
-	struct power_supply *tcpm_psy;
 	struct delayed_work psy_work;
-	struct mutex retry_lock; /* Protects psy_work_retry_cnt */
+	struct mutex retry_lock; /* Protects psy_work state below */
+	int tcpm_current_limit;
+	int tcpm_online;
 	u32 psy_work_retry_cnt;
 	int irqs[NUM_IRQS];
 	struct mutex lock; /* protects the state below */
@@ -595,30 +596,15 @@ static void psy_work_item(struct work_struct *work)
 {
 	struct max77759_charger *chg =
 		container_of(work, struct max77759_charger, psy_work.work);
-	union power_supply_propval current_limit, online;
-	int ret;
-
-	ret = power_supply_get_property(chg->tcpm_psy,
-					POWER_SUPPLY_PROP_CURRENT_MAX,
-					&current_limit);
-	if (ret) {
-		dev_err(chg->dev,
-			"Failed to get CURRENT_MAX psy property, ret=%d\n",
-			ret);
-		goto err;
-	}
+	int current_limit, online, ret;
 
-	ret = power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLINE,
-					&online);
-	if (ret) {
-		dev_err(chg->dev,
-			"Failed to get ONLINE psy property, ret=%d\n",
-			ret);
-		goto err;
+	scoped_guard(mutex, &chg->retry_lock) {
+		current_limit = chg->tcpm_current_limit;
+		online = chg->tcpm_online;
 	}
 
-	if (online.intval && current_limit.intval) {
-		ret = set_input_current_limit(chg, current_limit.intval);
+	if (online && current_limit) {
+		ret = set_input_current_limit(chg, current_limit);
 		if (ret) {
 			dev_err(chg->dev,
 				"Unable to set current limit, ret=%d\n", ret);
@@ -660,16 +646,35 @@ static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
 {
 	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
 						    nb);
+	union power_supply_propval current_limit, online;
 	static const char *psy_name = "tcpm-source";
 	struct power_supply *psy = data;
+	int ret;
 
 	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
 	    evt != PSY_EVENT_PROP_CHANGED)
 		return NOTIFY_OK;
 
-	chg->tcpm_psy = psy;
-	scoped_guard(mutex, &chg->retry_lock)
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+					&online);
+	if (!ret && online.intval)
+		ret = power_supply_get_property(psy,
+						POWER_SUPPLY_PROP_CURRENT_MAX,
+						&current_limit);
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_err(chg->dev,
+				"Failed to get supplier psy property: %d\n",
+				ret);
+		online.intval = 0;
+	}
+
+	scoped_guard(mutex, &chg->retry_lock) {
+		chg->tcpm_online = online.intval;
+		chg->tcpm_current_limit = online.intval ?
+					  current_limit.intval : 0;
 		chg->psy_work_retry_cnt = 0;
+	}
 
 	schedule_delayed_work(&chg->psy_work, 0);
 

-- 
2.56.1.839.g22a8290db9-goog

