Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503613D47C8
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704240; cv=none; b=prcbYk++m2Gzq+tzFthbPXE84Wc9zA9oj4YSo2A8tROVBxhc/u+RkzhAa2alj0IuTeJsCs5Q+5hSw2haCtYRvO9nDdKAr5kapR+hHPxRWyDrGPS8945jcvuemIKeHBbMn7/V3XS9X3Zwq8BuaVKtb3i83btS288AFyKSPiacfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704240; c=relaxed/simple;
	bh=MtIxUv1HUhphqto5paraCNIhe7tNRBGeSF/voPqNm34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJZ3WvUFFOp0e8fhtyKr5TnVgWeEnSKmDlYHXdxTKHzhAwvp0jz0qERKfwEvmHTy95LUWSfC8vRnd2hF97UP+7Y1wRdnysVdzLFc/PfvNLGwc3MupWV/v6YetetED4dUPh6v8FEprsShacYyckwUUQNidEAY+tF+elX3toUSpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ocTCpsOd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocTCpsOd"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1777770f8f.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788704236; x=1789309036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZO6dxofZbAitz209jLurPVDhx0uGUtYXwmfwELJ9t4=;
        b=ocTCpsOdKEaX1m0bVB3mFuD3pNGW8tGTfzKLuY0p8ZY+TifFYfQ9wN68ZvXMM57Egh
         7EFs59t7SXk8zJelVjY2KHNYV/GXH6QYuPkdojsjBiX+Xql64hJvE8X1u9SwYLUvdKow
         /p++jFhYKFVo4Rxtl24lIPioiiaaTqGpP9/8hgAkOoRqLdjGvK9DgY2+61ZZWH0QqjKA
         74uiHYf2d+70gtdVLgsAn7vpes/XZHHWzwdgJvK/XPQlovN9GqhdZpj6//0m43wAMl9F
         PpbgAyPYt/HLACjfGJxua7Y9HcwbGXuHK3qArvW5ShI72IoMS5YZ1L8UIta8R+E9Vp4n
         SVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788704236; x=1789309036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZO6dxofZbAitz209jLurPVDhx0uGUtYXwmfwELJ9t4=;
        b=MihEKeBXQoc99eXHAQSxpOJHRoYG9DphnY9A7y2qfHfJSxF3ully7P9/VQcsAoTirC
         MYtJ+7jsbGSk2DfpbJlPKeK5ajTlclu6NrSZc2l5GKs6n3qy3Ok+X7ZVYefimlOIf9Hn
         ulrfNNWv6X0CSjAtUsCfHHurLMl9vGHk5r1jhli9J0T1mt+CmGXd8E1T+cwaXA/DEqUN
         Caq9Xo1OC6k0KjMQlgEEcDPU6iWnNuRTA2ld59i9tfIudiVTrwJiQQlIfHrTnSx/xLos
         r6ZcVlJUH2lGTmIjnLvoo2/HDofBE4J/aGju6MvwM+OVk2BnMAoKr6yF0XT2RjF+4xqS
         7yPA==
X-Forwarded-Encrypted: i=1; AKwUvByvMlY9br/jD9zww4pfzENHq678k2rqpHZCt0MOK0vzBePFT5cI+2seA+mz12pcVUToR7bhc54=@vger.kernel.org
X-Gm-Message-State: AFuF++n69mPHPA7ItAc00oUofztf3JYXG4VYYgPd1ztssm5NLkf3a9K8
	5Q/3D6cDdh1mjk2S+jGj0b9+Elz4yGbbfx9pgHpGilUfRrlrxfmuqrB+KFN34dsarg0=
X-Gm-Gg: AYBFou1AgTKn8OoDHBCB3HHwNR7VCtWM5AyBtuDF/sWgU2f09dSoH2nk387yaO9Qg9u
	87NtaK1ogqyr2nCtOp/gnEiVmPrBMEBJioWvds9Why+gevYAk5OiCZ7YcGu8enAk5+pZDa01+j+
	e8/RwIxD+bhpHIl5wO4US4i57Vah85B4xqjAra5UQ+O1kUlNSyT36Rxd1k/534Q2ho2PobZUqYK
	gMeUPABZ+CL0R6ng5tbJ+GY5BhMJtkTZYeJgJFY3siKiNMbAhIvxocUUqhp3ocXJPXTWQXtev2a
	SvDFyrmnPz3XczReC6WWn8B0rEEGnroqPnx8CS/9JC5yGDaRJ/URC7sZ03eXb2R6TB3VcoqZrPI
	DXk9As/ggaWOGtq67NY+9wexuwq1OEhpSUc8Iq/V2OVIRZ2vLDvb0oy5iThhFwefOAXyzvqzG87
	2mRYjepzd9fOwx7coHKfCSBYubENMfm2ZqsHOPujJyiaftV/oZ8HORXGj+3X7JpMYXbCTFu9ZI0
	DWfpnJKINE=
X-Received: by 2002:a05:6000:4694:b0:482:ee81:f0ca with SMTP id ffacd0b85a97d-485872a56e6mr16211183f8f.12.1788704236345;
        Sun, 06 Sep 2026 07:17:16 -0700 (PDT)
Received: from [192.168.0.35] ([109.76.250.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588390e30sm21669763f8f.7.2026.09.06.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:17:15 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sun, 06 Sep 2026 15:17:05 +0100
Subject: [PATCH v17 1/5] phy: core: Fix use-after-free in phy_get paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v17-1-e2197a3e2551@linaro.org>
References: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v17-0-e2197a3e2551@linaro.org>
In-Reply-To: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v17-0-e2197a3e2551@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5297;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=MtIxUv1HUhphqto5paraCNIhe7tNRBGeSF/voPqNm34=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqnXXnNTbjHP1icmE8CNbsM2qqgpcwLeDli3+4S
 jx/nJgd6m6JAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCap115wAKCRAicTuzoY3I
 OsvCD/9XaIr+mf2+5wtcbGX1M8ZayA8JGUaFMtEP5bzX9qb6j99iLte9gvMMF+ng+mVpDDlMXlq
 F4viiBVP7DRZ6PFDURdFYdvVjixU5+cqqS6IL0PYo5MVwAYaofA3xmhVrWGtSfZbi7crF4ak9x/
 OMDSglf2fIxnav+lOrXGatz0SwtavCSwLe/JnySXNq3foHMiiIUXFrtqYSyNk8nR9L/sv9onkaG
 aEQB5Oq1mTbptQjHngGnbB0aWpH76u0KRxZbEiD99it5nmT1JJVx1rDt9ht5NhgtJ/BHfj0cs+a
 ksTGZzSYe7theqmfYeBr5gkSYezPBTksdCd1Hc1Tp32F5BZ2SmQRyHhYRLOPb17m/u6zZ4g/ff8
 0bObPz+KXCW8z1PNZG6DNuzcmzpaQB20P97OSpFzNs/6KGqrXqq/4W2PS6WFT0P9J6pKWiDqW2C
 9llL0FlhKe2AYv3xY7mBvxhNOt1J2Vx+auz0sWJyzTA/P0cbVFiwyzHN643hGh3rC5QuQDCMl5S
 Z4ADJmtDiNi3G+E9t01e51ROIAOSuFD8kKemoPUaFnJW5G1wjSG16lvFf/PdH8R8ESa24UOloMo
 hl3hNZ30QIYsFPZ723dX78PvOZnY7GNnENHKxqKo0lNzGgbkxv3001jqrFWFXS46T7QJcviNrKd
 k5PA22ShQ8STAGQ==
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

