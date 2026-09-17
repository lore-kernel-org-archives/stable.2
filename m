Received: from mail-ed2-f30.google.com (mail-ed2-f30.google.com [74.125.228.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440E4D37B5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643295; cv=none; b=X4KUXKAmY0M3jzt+PbgRh0vRL1w3pZzkyW5zmSFeOknDw4SB6bZXnZMldufKsBZjfX7+XNHUGbAzf7C63YrpvsoJqzENWwYj4ZE3c4PrTjRSZovut9irk9PtB/SOcCrwknRMwDGqQGhpaHeQZBKmGdrcoB4w98ffXMGxHKKua9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643295; c=relaxed/simple;
	bh=d98IC8bz/qzZqOoRgoY7KC00p4aOgRN119tjHNyLlDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNnq/qjp8j2BUP7vd26N41AGr2PY2xeAOXR+YstU2DF2NszID130mqEqPwXG149nhw8fiiYGobxW2cDqDoOeiSQCzzS4Jm+gDih+pg5r3n7c2HRISN3OeSYrKDSEpkX4m9UW9RmqpAdgy6cA4chslWYKfeICz9OPEgF/W8OIvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzhzJXgc; arc=none smtp.client-ip=74.125.228.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzhzJXgc"
Received: by mail-ed2-f30.google.com with SMTP id 4fb4d7f45d1cf-6aa06e51bc3so1257671a12.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789643284; x=1790248084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AEJ+zdV5VeKxtZ9NMskLi/eRs52AJWTItT2AzvXaS5s=;
        b=mzhzJXgcirNjihwgMv3mQXjwIot6kr3xEn8JNpdZf/iX0LAOgbqikClznhFQI4JOUF
         K3Xagxbn7ww1Mh7feKXsj7ROfqYMj4X+jFTh9FVRIGCB+Ufj4aTnnvWTTC10ZdLe6mey
         wcJ0e/Vj8KLOGlrCRT5uxCiBX4S4cf4yOXinzo4X9DEmlpqLW2HzHYajm6zUBTrN/Lag
         UNtcrYSAU1ln+8CUV8EX7kMm7GxjYoAhcjBGax/pRFaYP9NDEqXxg855yGUhkHJZqvtT
         AC6Yt360wFN4SSv/m+WfxI+XrCaa+KVpL4MnZsKNEAuTLOYroeFXfwq2Qu+VxM5EhzEB
         IPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643284; x=1790248084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEJ+zdV5VeKxtZ9NMskLi/eRs52AJWTItT2AzvXaS5s=;
        b=aGlcV+OGUYv+6RTemhzoYbYYiezi1cO8Oui4umnOXb3udN1idNHg/gr1Hm5WqKutk6
         TUTAZcZntU3CfaQ4YMEZxBcSSij7mZhkNwLtNC3qnXWvrzp9CSIRq66STWYmFvCOraok
         IsynVjyCErBvDiPrVaRTbE+sclA7VMPJKi3Wy4dG2WibSGj2Nu7cogHAB00dUrgRbhW5
         G6AbMDXnZQICvYFuQb8lABwK0WKwVsp7qqEZXccIB/lYCTgFWgnZvFxWQi3qAiSYBnsP
         mG9oS8fs/UP0HeeGiaVuH3cPFGIFO8bTC3t6pgoX1GUE73LkQk/xBro2ukN3fvFo8izr
         +8WQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzDuXUZ2qgl3Z9NfDCSKcbfDploT8/luGrZ5Ecx7XNUw9XkE9twwHwkGcluRl07XMP1fHYly0=@vger.kernel.org
X-Gm-Message-State: AFuF++kKC+2cOIOM9ikDT2Frbg49Q51FwicykKhk/P07Z1qLwvswyg9G
	CYfN/5LG+NnhSYVoRB2bHWLRQmwUdY68NaTJqFYdq6+w98F5cC1brYPAgUgO/26/vS4=
X-Gm-Gg: AYBFou0/sU8euZJ9WhNDLbtx2cMGmuGx8SeWSAyohIoD+QGnZ7YSmtILr1Y4pAZY8aU
	EkvMJvrsoT+MO6qmEpOxjAE6rQt6EY93zCRSoEbmSvHvy77RRbxcbGD9Sq2XE+Vx91o5+IF4+wG
	j7NgLr820/6k00+3meuSJVT250YwUm4PsZT5+uWiXrS5ayRihnLA6cXuEASaZ1QJ1LRb7m58CGx
	AqXwKtRANucureClXvLDpoGkCgZMRgqh3emMALsfxGobl/kO1RJPFqCqhAw+hbXg/wg2a4hAs2T
	6jimG1JOG10OuPvMQAGTO0Co2B4IMcoP1ujK6NYSz2yu/mhB3E8Vok7wD02c5JYLS9dmbuHC+mT
	Am5xozJno3coJBPmFI+xEXQr4/Gb04dOhV4Ko7rK2plYdHNCeP3Zq8kKT5e/i+1fRjyJLRv/x0r
	G6EXW0F8uCLnX02kT8/j+a9b5XVvbU6Rdho9MS0cK2FAERjYodpiHhwiCY2Mxyt9CxcEeYJpmHW
	OIQ/SHVag==
X-Received: by 2002:a05:6402:4143:b0:6a9:8db2:5c61 with SMTP id 4fb4d7f45d1cf-6aa224695ccmr4351003a12.45.1789643284160;
        Thu, 17 Sep 2026 04:08:04 -0700 (PDT)
Received: from [192.168.0.35] ([109.76.29.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d27ad36sm3175656a12.21.2026.09.17.04.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:08:02 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 17 Sep 2026 12:07:54 +0100
Subject: [PATCH v18 1/5] phy: core: Fix race-condition between
 _of_phy_get() and try_module_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v18-1-f85c9103177e@linaro.org>
References: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v18-0-f85c9103177e@linaro.org>
In-Reply-To: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v18-0-f85c9103177e@linaro.org>
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
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5374;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=d98IC8bz/qzZqOoRgoY7KC00p4aOgRN119tjHNyLlDk=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqq8oMMJX8EVikfzcwZo+32PzQIvs5wQtUxfWdE
 sUxbNbKSIGJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCaqvKDAAKCRAicTuzoY3I
 Op4QEACLqBWFgsDynn7Sx8zizEGZQf0msF2clsc/4OOxnUZedrMbGoYJBncg5EFWGgmQYXHN/Tr
 q/EHXaU4yA1q+sE33FpsVL0vD+ZFX3B+qdFfPssZbjCJnosk+qr9oJU7z/EVFZ3iYKpT5Uw/yjk
 ibiwxeGZuHlHZKaI1/9hBJrBygc+MUj0ZeE/XFJk0p2oKE4+FRam7sQ4r6dObIacxQouRO4qria
 /e8EZYjMnX6ACat6MiUJP3Apl7aIAN02TlOMepauG5UEOS+4hZ8HW9vKdjr3WGmAR0g/R06L7AO
 czp5wzzNYL9ACJ9o9gPaL2CQ+aG10c7hrx0AWfFNzlvw9KQkM3lWdrki2nBxbqngh+JEDHOEHml
 iDHp/IoNzL18wP9iH2UsfanebC0m/MEdDLthbEEaFFE0elycfUzb4iFGqqKAswKZdhT+cLPl47g
 6Ay6HJ4BGvh8aSccNrbqkYss0ePy2CfjIjPFntYzNL/F+747Uz8dgI0+nVAbXoCsckRj1jvWb6i
 QPkQp1eImIMQbE+qtRgLYuclBVvVNFPC0po9XO/O/b/k7TwdhAYuXzw2qG0H0AMBb4BE/+OijG1
 MJKn28BoDey2+hDIsgC0ay24j6ahFK+OTRXQaGTg4xaHjBOk0kShV4taFFm1Nki8wUrFQKxjQA0
 eETl4wv2NWaGDNQ==
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
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/phy/phy-core.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53e..89addd732bff3 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -124,13 +124,13 @@ static struct phy *phy_find(struct device *dev, const char *con_id)
 	const char *dev_id = dev_name(dev);
 	struct phy_lookup *p, *pl = NULL;
 
-	mutex_lock(&phy_provider_mutex);
+	lockdep_assert_held(&phy_provider_mutex);
+
 	list_for_each_entry(p, &phys, node)
 		if (!strcmp(p->dev_id, dev_id) && !strcmp(p->con_id, con_id)) {
 			pl = p;
 			break;
 		}
-	mutex_unlock(&phy_provider_mutex);
 
 	return pl ? pl->phy : ERR_PTR(-ENODEV);
 }
@@ -624,6 +624,8 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	struct phy *phy = NULL;
 	struct of_phandle_args args;
 
+	lockdep_assert_held(&phy_provider_mutex);
+
 	ret = of_parse_phandle_with_args(np, "phys", "#phy-cells",
 		index, &args);
 	if (ret)
@@ -635,11 +637,10 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
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
@@ -653,8 +654,6 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 out_put_module:
 	module_put(phy_provider->owner);
 
-out_unlock:
-	mutex_unlock(&phy_provider_mutex);
 out_put_node:
 	of_node_put(args.np);
 
@@ -678,15 +677,21 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
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
@@ -786,6 +791,7 @@ struct phy *phy_get(struct device *dev, const char *string)
 	struct phy *phy;
 	struct device_link *link;
 
+	mutex_lock(&phy_provider_mutex);
 	if (dev->of_node) {
 		if (string)
 			index = of_property_match_string(dev->of_node, "phy-names",
@@ -796,15 +802,18 @@ struct phy *phy_get(struct device *dev, const char *string)
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
 
@@ -813,6 +822,8 @@ struct phy *phy_get(struct device *dev, const char *string)
 		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(phy_get);
@@ -961,15 +972,17 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
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
@@ -982,6 +995,8 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);

-- 
2.55.0

