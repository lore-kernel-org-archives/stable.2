Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E137268A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476369; cv=none; b=BiAgeEQlB3XIjdy/fcDSZZFMflByYcIpT14xgB/IoKwbBmYMCg7OHzokdI7jdwA1tvzYtN9o8PL/jeqhnqHC4/t18r7GXt0SieKduDKshbZ1Dbhc5VCF6uDWpDriMlqfP0J7OTIFI/3OpASTVlt7jJO/raZjjEjXGoQyJNyqDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476369; c=relaxed/simple;
	bh=PqW9tqmW9F2B4lcssAx2e+YT+CUUTBw6AIB9Ts0OgxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B63HHd+DIFUtqdz7xCdJ8DsVWjQW3jChIWM+hrmAv9U1XXdH53NabjPAWeCdh2OL2tn/rgsULk+laHmgU6uD/tkYj9R8VfZXKbI48ALKX2Oc6VV8xWX8P8X7W8y424GZIAxjJCVbFhhn0egtT3EUZ/mVm8SxAIhaMxyndxiwvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4cs7WiO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4cs7WiO"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so392665f8f.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788476364; x=1789081164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKArYctGJ4c8BFSi537cYU55OgevfeFg9JTuZatHHeY=;
        b=T4cs7WiOyWTkTphHF6/XsRXOEo84E8Z9R4a+AooHYUOVGWzAbJUq6cbpxGdozJeDlm
         sMxKS43gnMbzIfigeMlbt+fwFxxaHgXKAyPQoLQ0sbUJ65zQUwbt32lb9oUe2Zj9VE1W
         7P8pTBVnX1m6r1Fo7Qk9nLYOgl1wdTuc6b3sp5ZjMYHk7ywr62g/ft5J6pXLqQ5rsOTq
         UWJ0DKHNUeNL3FkS6q67ywdlOqTn+iYkYK1U1Cx+TSKXaVGRmkRpzFUV7XIkEb+Zw1Fl
         3tWQYQAp0ZhE7CdP0sl8OesvKVSeMFZsHbR2mQA9/drt+xQ+JLptVcmhrRta77Em1z9n
         P2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788476364; x=1789081164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKArYctGJ4c8BFSi537cYU55OgevfeFg9JTuZatHHeY=;
        b=GJaSurBki4R7wWS9zgQZXk2v/v43igW1V7tNpk0r7qfVCeY8aPzbhwtxe/ZJv5HTU0
         atErf1Rc7sVbOr9GHTjjCGGd7XYP5GbIKLrYVB5aDgNkm8rhndkCjkeDM+70r6k/zgmx
         5RT5+mwHCXqfAZT4am/t62A0Y8slpLcNe8KEeVLtNR4v8ecF5IPdlftBofuC3Gmsg5e+
         E7GK4DcvDGkZkezMjrhC5ZV4/XXlgqH/+Mo3vhq3O575RpHAQQCG36GkSB1AP8jnHdQd
         l6fEXCZj7YaT3juie5JLCGg9w4imAEzWiEUmMhl88KNXKpZXG1Uw2ZhE7L+mda+xoz7G
         KYmg==
X-Forwarded-Encrypted: i=1; AKwUvBxfAPEBqrwHSN0kBt/KcDEItEezpw/CLFTCCZ2cP6BbwUgpfoy15/8/RvYajsORx36Ri9rj55Y=@vger.kernel.org
X-Gm-Message-State: AFuF++m8ukVR1LlS0X1Eiq3qj4qydX8PsXvqgvSdUoSMAthDI7fZvrzL
	DwcvZvaxZzaB7+ScNyynEpStaEQaBAu3oIdi/fw4RP8LDm2aPh94XaowCvMstsETeAM=
X-Gm-Gg: AYBFou2TqbSgmgiNAmKxT9ymOs3jw4FKHEJuCNV3KJKlWNvAePoTuwdhihTqWHb2r/B
	ocan1PgfAF74JnN1JrUbhLNBrHfaCoB1QpNUohJxkCMB8LEJHbguVLQ1UTgv3U19a9GpcVvnfe5
	MP0XIcVxQmzwx+Ivhdz2tgGTjsy61xStIio2JudtKTvGEnW/lNXmOzUeEbj+bi6U7jVJMbyUVPT
	jKIZad6H6lS180lqPeT+z0uOabzKakJjZ1k/VFYpMm8pzh39sBjO6LjBe6BYad28hiwroSFIeE5
	kKoS91VqMmuFBcshQZdz7N/5xkk807rpNUy7YzrSE9gpIUEARJmkIm+WQRkS6L+ejN4wQ5ZOipM
	aO57JD8PGGu75+lkdmN5mWqtFxqkvsooHT2pRrdHEW78uA7VAU2yiXiZx5VI7N0ppiXgGPW77MK
	oQi7TADk2OBRo5WRnUM005ppgNWrDdzzhfsj47O8OHcjRBNgElQYC5hlFwWPIFfCdwrVhh
X-Received: by 2002:a05:6000:25c2:b0:482:e2f2:19c1 with SMTP id ffacd0b85a97d-4858703f827mr3881421f8f.2.1788476364322;
        Thu, 03 Sep 2026 15:59:24 -0700 (PDT)
Received: from [192.168.0.35] ([93.107.91.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9a56sm1448006f8f.15.2026.09.03.15.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:59:23 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 03 Sep 2026 23:59:07 +0100
Subject: [PATCH v14 1/4] phy: core: Fix use-after-free in phy_get paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-1-01ef1eced075@linaro.org>
References: <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-0-01ef1eced075@linaro.org>
In-Reply-To: <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-0-01ef1eced075@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4896;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=PqW9tqmW9F2B4lcssAx2e+YT+CUUTBw6AIB9Ts0OgxQ=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqmfvGaPneFS+DA4dpavnsinID7MBmg4q52oC3G
 HG/1MMsjaeJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCapn7xgAKCRAicTuzoY3I
 Ou7qD/0Vwb+/DK1cHGSRf047U7hRatmKhpsTaydg7KJzmBxNz15oSuVvm8xp86gIXG75+V4c3XZ
 W7uJeLm9oEeN0XXnBSooRDOLIWdLh2600gRTuKMI0EIz1HXPi8X7GWTg5cVE1KTHBZC+jQSPUzs
 TP0uhPgA9rn4UDe2FgC9+At4P3EhFQtvKCoU9eMQ9Z/g6jvLUw5Bl2/QCJZI9xDj1vUu1OGzf4B
 dXS8jILQyaJvHE7vQHeOHsYgBT9ftVzLwGXDMEjbJzLL+s5j3wauE9pCQdMa/o5CWxoeISzI/cb
 /z2Hn4mpZ2wlsMHR5FI+JpBS9jNR/CsQQiFWggJEJeYT7UcvKj01Pt4QWg/l4IRhxeHPRtUswDp
 aaO+XQ/RVYpGoYpzMkhw8w0RkAgoMpiJXl1dflGJ8fuA5Uz1+NB4itT09q6/n0DgmDz1rBaKWuU
 ryZMRkrJvyhXmYVdoR6DL5nYdmwEkAVvHhyTmy9ZIhHxxBAylFfl8+0Z7iFm1O8OcVew0SKwuEV
 bgiEv0+p9V47WvtHua1uZLYeWnt0HgIZGBzTIIywpkJ96R4kLDMor/akP9juZR6LYzFjTqc86YN
 Ag7m1ndHZljlibM2L8BwVTuIdK4mIUJHZck7QXh5oXkUeDOB7SlpVkVJPmB6z8laxl9rS9daFdi
 yT6NMd6qoiYqZEQ==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

Sashiko asked during a patch review if the existing usage pattern had a
race condition; specifically in of_phy_get() if it was possible between
returning from _of_phy_get() and running try_module_get() that a module
might be unbound leading to use-after-free.

Looking at the code this appears to be so, there is no linkage between the
phy and module under a synchronisation primitive.

Using the phy_provider_mutex in phy_get() will ensure there is a link between
the returned phy pointer and the module_get() bumping the module reference
count.

Amend phy_get(), of_phy_get() and devm_of_phy_get_by_index() to fix the
same usage pattern.

phy_provider_unregister() must take the phy_provider_mutex so amending
phy_get()/of_phy_get() to take that same mutex guarantees there is no
use-after-free.

Fixes: ff764963479a1 ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/phy/phy-core.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53e..cd9ace125567a 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -124,13 +124,11 @@ static struct phy *phy_find(struct device *dev, const char *con_id)
 	const char *dev_id = dev_name(dev);
 	struct phy_lookup *p, *pl = NULL;
 
-	mutex_lock(&phy_provider_mutex);
 	list_for_each_entry(p, &phys, node)
 		if (!strcmp(p->dev_id, dev_id) && !strcmp(p->con_id, con_id)) {
 			pl = p;
 			break;
 		}
-	mutex_unlock(&phy_provider_mutex);
 
 	return pl ? pl->phy : ERR_PTR(-ENODEV);
 }
@@ -635,11 +633,10 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 		goto out_put_node;
 	}
 
-	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
 	if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
 		phy = ERR_PTR(-EPROBE_DEFER);
-		goto out_unlock;
+		goto out_put_node;
 	}
 
 	if (!of_device_is_available(args.np)) {
@@ -653,8 +650,6 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 out_put_module:
 	module_put(phy_provider->owner);
 
-out_unlock:
-	mutex_unlock(&phy_provider_mutex);
 out_put_node:
 	of_node_put(args.np);
 
@@ -678,15 +673,21 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
 	if (con_id)
 		index = of_property_match_string(np, "phy-names", con_id);
 
+	mutex_lock(&phy_provider_mutex);
+
 	phy = _of_phy_get(np, index);
 	if (IS_ERR(phy))
-		return phy;
+		goto out_unlock;
 
-	if (!try_module_get(phy->ops->owner))
-		return ERR_PTR(-EPROBE_DEFER);
+	if (!try_module_get(phy->ops->owner)) {
+		phy = ERR_PTR(-EPROBE_DEFER);
+		goto out_unlock;
+	}
 
 	get_device(&phy->dev);
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(of_phy_get);
@@ -786,6 +787,7 @@ struct phy *phy_get(struct device *dev, const char *string)
 	struct phy *phy;
 	struct device_link *link;
 
+	mutex_lock(&phy_provider_mutex);
 	if (dev->of_node) {
 		if (string)
 			index = of_property_match_string(dev->of_node, "phy-names",
@@ -796,15 +798,18 @@ struct phy *phy_get(struct device *dev, const char *string)
 	} else {
 		if (string == NULL) {
 			dev_WARN(dev, "missing string\n");
-			return ERR_PTR(-EINVAL);
+			phy = ERR_PTR(-EINVAL);
+			goto out_unlock;
 		}
 		phy = phy_find(dev, string);
 	}
 	if (IS_ERR(phy))
-		return phy;
+		goto out_unlock;
 
-	if (!try_module_get(phy->ops->owner))
-		return ERR_PTR(-EPROBE_DEFER);
+	if (!try_module_get(phy->ops->owner)) {
+		phy = ERR_PTR(-EPROBE_DEFER);
+		goto out_unlock;
+	}
 
 	get_device(&phy->dev);
 
@@ -813,6 +818,8 @@ struct phy *phy_get(struct device *dev, const char *string)
 		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(phy_get);
@@ -961,15 +968,17 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_lock(&phy_provider_mutex);
 	phy = _of_phy_get(np, index);
 	if (IS_ERR(phy)) {
 		devres_free(ptr);
-		return phy;
+		goto out_unlock;
 	}
 
 	if (!try_module_get(phy->ops->owner)) {
 		devres_free(ptr);
-		return ERR_PTR(-EPROBE_DEFER);
+		phy = ERR_PTR(-EPROBE_DEFER);
+		goto out_unlock;
 	}
 
 	get_device(&phy->dev);
@@ -982,6 +991,8 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);

-- 
2.55.0

