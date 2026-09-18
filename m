Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC445012BE
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739815; cv=none; b=uxeGye5N3ZyQQhsqzpoXVOffUPz88B5fDWaB2qAFOck9WpTdv3IRof6pUfAz2ULSKugWFhvDniphxsZhxmzfp2dluEgu+j7Pz3vg5PZnAGvxGQFvdxe9lOsUkyw5k8BOFGETqXp9rZoo9EnQ94Prx1KTqPxcN0xJMQoJpPwWaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739815; c=relaxed/simple;
	bh=IoXZ1reQlvpqJte8Azuyv4AEJ1+ZnvZqFWxjllzwkAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhhcKZfqBXh23M5RIXW4D0lkoes+b0kGujv+nXYt7c/aG9eYsKZk0gvzNTs1nfqsBX9BPNh3MwzphBq1NdRNRiuX5xE8RpS8iwxouLHA+Ua3THYY+8PaSA/klV7205G+I4HutXGvsxFi4CTP0p639EBSVQ4RrvVCETbLKUJKnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eEs8QZdb; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEs8QZdb"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98604f6b4so1024613a12.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789739809; x=1790344609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsT9IFRHhiJUngj7BjrND4Gxc3zxhQTn9THAcGWlf5k=;
        b=eEs8QZdbFDOmLcKCF0Z9C7N+cJsNeMFlUNVYMRTctXa7lNkBhE7xxbPCNOsSwaV3m9
         q0x+NzUyy/g3vpYzJwblOjvhwPSOyhINB6LXHKQPqSZi53WvssUUVy2HJ0yzvuuUpesl
         igPYrEG2/oiiYUKfFpgo3VjH63mPbXH1mXpaFkn/reobAT9g80rbN3I2dhlP6SRrHr+1
         sC2GPyWOi0TY9IypRetw0csnffaz6SbB0Nv7Y/tsUspZzE2DZYkXlzGf0VRjc/ALksGW
         mZ3kRBjwVBpH7tL2Iva2iu2VbuMF+VEwU88WeRsSX46UVYTkVbL8fZRFWmBM5IxNswIV
         sx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739809; x=1790344609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsT9IFRHhiJUngj7BjrND4Gxc3zxhQTn9THAcGWlf5k=;
        b=iIfQDm7RnQotxczTln8fM5/GbSLS2ljm8Ryufy0JrVfRham4vHrLkhXpOUwSraX062
         ja078acxdxEtQ5ZuGt80D7Z7V5YpVKcjRqtmQMdSwmcg+GSExQ2ghg2WBzNYyUxrxJeP
         jYdjcMMrmRZPMmdt3667pTCRU3QJ8Su6GE0VtYmbp/GWnSL2W+a7zM9Z4BCG26inMixs
         pldbLifqt1Q12rc6//MHsysORnmEDVVktc8yrhKlCUqS4DoHF604hGLnrqRm2lgd/3Ii
         4zSLec7VI/pEfG8Jp1OLDd5O7QnsRgiBFsdWhOFSH3jakElna1ZFhafO7OOZsIU0I5XT
         uDWg==
X-Forwarded-Encrypted: i=1; AKwUvBxSMA2dwMT/997Nirwo+jtGd9kUwBFkqVibG9nCK+BVypMBMhwRD03qryRr3LiOzVjiAmjjDzM=@vger.kernel.org
X-Gm-Message-State: AFuF++mGnDles+LrRRHKBH85geEO9Up9oCHAM/VYqxIBwikCortnkhqO
	IE86SXb0BF5XknQ/3nIGcAkWqJtT1C6ZnkvSIcXsJ2CKzR5PFYqHySJHfVRyJv9i+XU=
X-Gm-Gg: AYBFou3eOoBu0ww842C5lG4svNghWtHNAVw3H3mV3fD60tsJohSBpwxnsm4pOgjWqP1
	0Xc5g7FMVWivptZLFe0SFmSJgspl0hJTWkTpwC9muzTe3JFF5EkkNDlzDwS37/QCdIE8tyToFyl
	aQ1y+T6nJXQuz2qc2TURXa4vv1FaZQBfaQyOKvUQW0KD/yEewHKVSOCEyJFEwUZs3ne2RI4FxOp
	eD/L2xkY2P2dAAV/2IF+IDdrN67rZfTtKTQO75tl6H8pr0a6m860vqqQLcVqFf7a6KeKsDzLInX
	wnhazHsX4NxUEGTwBv1yQfCeqpfJbd9Lk3Ajzr++2u1imJZjo5+IRPu4Jms6HDJxebIJ7L1zdby
	dQX96zyB0t5OaVvocB9FjeZ9GXVSQNFQGzS9Ut/77olYnPa7I2HGoD1gsvTwjLO4yItrMQk0NZS
	CC8GDPQTVdtQUGQHj9Xz4DGUvN08pr1N43bhxdQTEUl5zAUDUwROMPCDiLjNNGY7Kl0+Tb34qUB
	d/aSDpeXA==
X-Received: by 2002:a05:6402:400a:b0:6a7:ee55:dcc9 with SMTP id 4fb4d7f45d1cf-6aa57861e81mr1539832a12.24.1789739808949;
        Fri, 18 Sep 2026 06:56:48 -0700 (PDT)
Received: from [192.168.0.35] ([109.76.4.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa59730866sm915455a12.18.2026.09.18.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:56:48 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 18 Sep 2026 14:56:36 +0100
Subject: [PATCH v20 1/6] phy: core: Fix race-condition between
 _of_phy_get() and try_module_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v20-1-dc244e124e71@linaro.org>
References: <20260918-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v20-0-dc244e124e71@linaro.org>
In-Reply-To: <20260918-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v20-0-dc244e124e71@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Oleg Keri <okerixx@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5454;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=IoXZ1reQlvpqJte8Azuyv4AEJ1+ZnvZqFWxjllzwkAs=;
 b=kA0DAAoBInE7s6GNyDoByyZiAGqtQxuhxTNWuBxqGuGf4V9voyix+7h2Kuf1dI47lzHHNmTBP
 okCMwQAAQoAHRYhBOaT+yqro23hF6tvtCJxO7Ohjcg6BQJqrUMbAAoJECJxO7Ohjcg6384P/2Eh
 8FioUFRtKvwe+A5sax2BlOE4qxn9ftzFmOdVa4B2dygKtvtNV/+kvY5kVAtlP/JTiJFrDum9DD5
 cK4rRdBM8uNLSTPE2NqXT64fJOsUoh6f7vNq7QFHV/VDbMQB1CTuVogQHt39lQC8N7uM+Cxl0NF
 qvhdMQLt6OdscwOFltQA9MtQasI1P6oF3OP+NZ28dEiKIznl+2eMWwxVJivnyYNdqoipXzc7++M
 B3S2pV3hM12q5Ue7u78V7mljnO8hpCIi3EtSE3qpL6Y/WS356g0vH5b1Sp3TOHLDOez9B+ClpGx
 6ifC2wmhq9u1oNmMFPAsR+bVCfJJ0ABv3Pu4ARjzTM49iNTB9vzWrMIPMBEtovb658J/VueYMCA
 l8pr4Akln3NVS6hfymeXoUfDgoMuKb5eoR9gYW3/V12td55PlAs7VgKcBQdhuYj9VNcXEf/i2Ot
 8+OYZld8Qajo022Xrab/ZFu4W3gFpkLKiMXBhMAWgYNOYcIP2/Q2jjaZfn+wkidvrfAuUwjCMQs
 R+XJ8bAKr8ypCM0iKtjmdFIqYN53SQYPZlLrGzlYxk37Mku2WSIyI1NRUtWCuqpxnOIh1jtz1A/
 VtKAWUBCLe3pG0/atadTuCgu1KYwO1+B2nbsgc/gXo5UgeT590/Zbb5eDvkpFSEV9T8rD2kH0xJ
 vJm09
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Tested-by: Oleg Keri <okerixx@gmail.com> # Lenovo Yoga Slim 7x Gen 11 (Glymur)
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

