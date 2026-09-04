Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CC479877
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522790; cv=none; b=lOgScZHLT3rlFyzXoiKu6Lolc63ikJ6zFtW4EpGYMszd24xpF8S+msgexXjlgmfOUtxtd9/jnpTnTY74cxx+Ygg6Zg8wGsJMS+N0ZfK+rP43hBIk6LFCmnkjwrLQ7w0vmoJz9dMiZIecqyJVt0LX3dYqUdl8Uqc5eNqssY4Jx70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522790; c=relaxed/simple;
	bh=SScZXkbAnXgnt8nSkpe9dZOfqBXgsPZesshLBsUkf8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvttp3II0lbOFsOZtD8H3STmt70xu355bC06vTOcAoDhhQPE4U+oPNGBr50Sl5a1iT9Y7DikSrzIkBNEoD/xTOcvEE9FeG23Rgc9w4BVe034EYSQ+BO6nzamzONEx7cZver8sdXEG/23+x2E54PEBXbwoMv4BVxuTu3B7N+tEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zR9taRaz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zR9taRaz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482e4998d28so655925f8f.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788522785; x=1789127585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Gn3T5GKQVsKNu5CjSN12Pg6Gz0nGtd35pevkWP3bfA=;
        b=zR9taRazJnaPqXzNK6lv6wXtMcHKShcA8UM3tO+bQiF6sx9C1GelPm17hU1hc+wN+l
         twBmYU/2pcU/M2N3yuK27qzjxWMnkarz1eC3iPV1QW2E6YyNuV7TEPcftkWZKqu3IYMw
         oz12HtEGKDDSmWw5YxY3GC0Kz5XE9NNp62/ljlT34PLQbFDiSgUoAAf2LTD+eOiTCWTz
         rX+3FwczaWpQyBOi5kqabtkFymUg/HcPIhJnOvuAfetApSmWaMrqjN7UjUEbBs9Upoto
         iJeBcxkZAF+7Wz+krlfkWLuwR7ihE5gPln1rKeNj8m6Fi12h+u5XZCXnxHS6lnuNt6jW
         p5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788522785; x=1789127585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Gn3T5GKQVsKNu5CjSN12Pg6Gz0nGtd35pevkWP3bfA=;
        b=XHN0f9ypRNgWFgsfgt/AyCPWN4eSoGl4YtQ/EKoHB1F7xYruGv7GLdIh0nvIL9RszU
         NXP3wndI13Tg2MAqM+kN3eX7ykDwojqGuoPpyjcRYbceWZYlgX5Kd6nBaNGYsuXRF5gR
         VU5lciiMfJvwEKwFZSQ/Gl2fRmqCYZTY+XpGHth2k3tGlNnvfn1WCCW1+rel7Kwcl4rN
         4HB8jOAvAlaPIZEWd4XUAeDVI7FQ+N9wkMDA84CQPd4DsG+Y1b7XrPLxmbUHujdmWpmT
         1rM5oT+gGHjE+3E0Trk0LWm/t8nxK2+lyiQUeGDjIW7+BE+YFtaXdV4x4XrjoXOk6543
         i15g==
X-Forwarded-Encrypted: i=1; AKwUvBynEz5tvqzN0Iv3oVhQC6ykOIvFUVexIlGa5lc3CqZQul5ZxHcwH8K41K4oXBwO7D57FqIv3X4=@vger.kernel.org
X-Gm-Message-State: AFuF++kiFf4MNovJmfkOJGUHeWspkZT2rIUvKIa51dY7IYYpnAJ2/v5J
	tLDG/WkvkMQAfzB1UtbFQGBNiMk7maL+8ec/hDqfcEg/aB2ZAQ5AGVt6d4jwYgGjLlA=
X-Gm-Gg: AYBFou1u837vewljeKXe8WcKq4JyEDViox+tScQmhBJ1w9ZGi/P6kvxb5CJn+v+0VNy
	evF8jlPdnQrZYyNSj+0iThx3w8EOjNT8v3zEDFntkqXAjPJXQZQlifd7aMoTeG/UNPOUi2mPn5+
	Fw/2t7vIn3rH2slgXDWp0tWTGN4GpUwbjxD/ZO5DBhKFEdc0jq9ZF1hvdgLmiYPwAY8/7ctXep8
	LEvEAGF4/4te34/4yX+LQxxesA7Z1uV0ibY+1ejBVYw7YxFjBqhXgEnp4LOssFXJlzkx7aPGwZS
	I6Ku88zNCdEyBzFdHp/ivprvWJc7G1aOw2ANX4Otj0b/mK17/cEdCdYWXKECWX4fCAGZf93TBgh
	961mTHzxnOpGfSn9AwiLJJhT7Wury0cXmEIlZRuxf7VpzbuF2G0OkZ7sNshHd3GNO0xTgHcYghO
	bIbgf3iMJgXXIIBEugVlfuzdEBT5BgZl+wQmbQt2SeVtKfIdy/MbIiwNsYfIKxuqoK2KTjGjwg
X-Received: by 2002:a5d:5d02:0:b0:485:8c16:a35a with SMTP id ffacd0b85a97d-4858c16a5f9mr2923096f8f.50.1788522785044;
        Fri, 04 Sep 2026 04:53:05 -0700 (PDT)
Received: from [192.168.0.35] ([109.76.237.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm5474207f8f.36.2026.09.04.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:53:04 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 04 Sep 2026 12:52:58 +0100
Subject: [PATCH v15 1/4] phy: core: Fix use-after-free in phy_get paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v15-1-68b7916e7a3f@linaro.org>
References: <20260904-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v15-0-68b7916e7a3f@linaro.org>
In-Reply-To: <20260904-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v15-0-68b7916e7a3f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5238;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=SScZXkbAnXgnt8nSkpe9dZOfqBXgsPZesshLBsUkf8E=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqmrEcRRwG+Yi5Zk7Lrt1BMPnkhCjlvn3VMIIzK
 BkC/hH62jGJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCapqxHAAKCRAicTuzoY3I
 OkyVD/0ZJAcLsU1XsHqDMb70c/J8/RnY0iJ9KDXjiaBsC/hPi9OkMLpMqpeEtVnj7y0MwZcxpk5
 7cxvGhdk+2/L/wsH0HmD4l2eyJxJMPVMq15Xs7ulS9X0vpdW/o3574Xvz9MOlv+0Ki0Thd+zY9q
 GVeVe06Kk07GJfs1VdpgGL9GyPUp+OWKFQML0FoFVsqPdzPRRvR3mTrBtneZdtVBHAPjIyjIjoY
 THd+0ouYoS3lEzLQ99nxkH/Z6QBDTKv9qG4z3vEivXxMYr6u0CLgDCYbDskyClUsbX5VOoAbafl
 TD8XcA3D/9EaODdsLayLeRNm4/auXmijSKatzdRMPVbunt6MfaRDz8lZ7r1ZakxZwN1PUV6Eauh
 XS3RrvnowEhIvrpNQ959rX+CgdUYDqzz1kq3B7B+Qco+ZOkCb1PRY1dUljE8u/AaAr3hmFcHj3l
 dH2pyfko9J8zQRF9lhu73sPgt2HhZ6uiDE6IF4aga+VnoBr2h7QCAW3E1vY6o13ESssUcnzVWv/
 kDO5G6IWlmxOYy25fR03muU+1a2cEoEspMfQGk+vWKvFZEP5ih9cO1xq+5+fkwVnkMVlLlVVJSI
 MO9S57sgq8Rh5beNrNPCQxX6ot9+4BWV/0/YfdFjw/d6U8+96RV3pSX4r+wYcDgTC5NNu1J3kZT
 SiBA0RjaoV1GKGw==
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

