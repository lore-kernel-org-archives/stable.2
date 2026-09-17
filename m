Received: from mail-ej2-f15.google.com (mail-ej2-f15.google.com [74.125.228.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E13B3C13
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658724; cv=none; b=QLiYPAb6HShuppzha+A04r+QninEAPfcRQUAgQ/0kV9x3P7C8jNX+sBB14IU3ne+D2is7zzkZM9Na4lM3dklHqSCrxNiYo1X0wiXr8NtNSkWGKXULRBHqcgyY8T6idiopJOdcv86L9cvjIsj93+1eDkghGOmbPM8bovuGX2MCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658724; c=relaxed/simple;
	bh=d98IC8bz/qzZqOoRgoY7KC00p4aOgRN119tjHNyLlDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzJALZ9nqzboiI2iVGZjf2rRZTEGXYfM+gQR9iAnOpQqlUBrzDa3Re693BnhX/6kEs1yIBZfdP8STKSVqv8/tQmFcylWpe/aXaknipBgcmzXW+OBj2re48QctjPuXegWehUBpQ66POSys7tBjWzQBcM8lc4/db9y5kk2Bkp0b9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oInOTxn/; arc=none smtp.client-ip=74.125.228.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oInOTxn/"
Received: by mail-ej2-f15.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso126426866b.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789658713; x=1790263513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AEJ+zdV5VeKxtZ9NMskLi/eRs52AJWTItT2AzvXaS5s=;
        b=oInOTxn/v3C0SgDWu1FKge1t9tS00IKSMv5N+ywDSPxPDrdmLWuNSK8kEFZN4JivfM
         GKIMmn3dOTCqMx8YZFapXJnjQuvpVThdgeJ4hKO75UOhIlHywGeJwaflu54mCW+wnuvv
         URxLN8oqyR1u9Ouf5j388VY3hp3YxNGgVlntPG5eqd5eLA1Rg7cAWfwCE4VyNJPiYvCH
         oHoQBTZGw9PNBIx2nZTnrnjKEeDrAiU9tbEQ9INkqdcQaxbI0uVTlVQlMoQhoqIKLFo7
         11+FtYHRAFpIcb5nN4k8JJlFHrPudJkcMQOPROPqoFtRk6L2xvXToiSj2z2u8NA9Br3+
         jG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658713; x=1790263513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEJ+zdV5VeKxtZ9NMskLi/eRs52AJWTItT2AzvXaS5s=;
        b=AibswtJZXKpwzfZHSmC+2q0fx/qdGB/pbvfGxZ7vduD7N7udn3Lxo5fJwf6hVvOAZK
         0ao39hJjXIjCsdUJkZzy6jnThcofHabUGKxc3YZPgBCo3/7HEWEoAh3LapP2effTbvMO
         2G/ibY0G6w1eouHpfmLE79XOmdImmWIN45JDLzh1MSE6tUQe3P7gGtm9CVUCcgJtScmi
         jDjn3+ExLUcehMa1YOMiuZFeP5Dc4TF6QXA0UOg/knllfMklxXDicfHdCx+kxHQJ7Y2P
         mWoWiT6/e1utNX485zfP3JfU2IHWjahdylVUmQCXzd2/jl7oM9CumZn3KYhOj9wtNIYg
         F0wg==
X-Forwarded-Encrypted: i=1; AKwUvBzTOCL3lgS/uOCp+epVrz36V4ZiVXdceS1ZmGp/H+cmt6eqLFKS/UcW7EATJhjQNxE/FT+N+e8=@vger.kernel.org
X-Gm-Message-State: AFuF++m/TwErd0+5Of6RFFZYWiT998HEgAb+LNvJ1suLRBLwzeX0cin9
	F8/PzQ35W7kiJwsq54b64rHEqqDNSCl0qEWvKaHaBWYEg8X3wcugf8I03LuOEhmXVa4=
X-Gm-Gg: AYBFou3fVtf7Ch4CN3DmpGVshLXJZGLZ0K0pK1bkdqysMCG7aU4WAw88W6iuXaRv4Sm
	6OcmOvY96VBvxngAz/CpNkcAu4ig6omC4PfK1POqtWzaYe4Kb8DTiPRxYa7f5g3dQP8N7mNoQjC
	wPaGmF2y1HucvcZqfDWFo3x0S5IRm8USi7FZhD8B/dBn0TEa6jHZ8RYwDIktTSOFdBQ9W0fyZVa
	E+PBcO0rWbQ8ASXR0Bkp0yP1fkT4ApKoN1Vi3oJ22wHa5PDf45jjSYhzn7LPwtv5q+IKem+k49D
	eNu7haJLgVAZUn61zP4CdhNASODvVWEjLfXozWif36zDGyvKbe+493UXvuJsWcnMjBJVvXm+mfM
	+imzhLqm5iKjvnakm2LeG/yQBbMSgVgG2LSVY+KnHAgUJGKoOkB0muWdkgmrZGhMZaisvKTCgts
	c30TujKH9aDIl48/M+iuZdkHfuIBs9xPOiC71Pg/RsWkwxyuuNxHIiAGTsobGWNp8sISwFVehIX
	dEr+cJCon4=
X-Received: by 2002:a17:907:1c1f:b0:c26:2fc8:4e91 with SMTP id a640c23a62f3a-c29e5392cccmr517140166b.29.1789658713014;
        Thu, 17 Sep 2026 08:25:13 -0700 (PDT)
Received: from [192.168.0.35] ([109.76.29.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de48755asm310587366b.24.2026.09.17.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:25:12 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 17 Sep 2026 16:25:06 +0100
Subject: [PATCH v19 1/5] phy: core: Fix race-condition between
 _of_phy_get() and try_module_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v19-1-21ad8a76e941@linaro.org>
References: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v19-0-21ad8a76e941@linaro.org>
In-Reply-To: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v19-0-21ad8a76e941@linaro.org>
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
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqrAZUcpays4h8JXL+XeOMyUq3TXK/VODBXi/Xc
 5Ne9QjokSSJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCaqwGVAAKCRAicTuzoY3I
 OlpSEADC8Wf4hzNm01U+HNiK6W2iuoPHg+0s+ljuihZMu/yjAaIQCJ8cUfdyo2ANBUc6VYwDrZ6
 d3SZ+56IGDtrjeCJmMWvaPBdwDxK1Y0Kn4u3O/5t5nKnCcKfGSzG6BtrPyd0SvSv0WBanOfuACU
 SHRjN5bWDTH07xwACU7X2RcImVCizg8aNUOCeEzU/r3zx/mRy3/pAH5uu46LOu3dsNOohbrr36w
 FMSssMA99++wsIHp5ueR+sR4+5C51bxhCoc0DaLGjIyghjxbyXhDyFj5mlnwMcuF91JyMVc74Xs
 uT1g7jAaSyUt5vNvEMvv5jkLR1VeEk4fE/5H8uoqokLaJ11hMyXP8oYANSNz6CvtmFvd6n305kI
 yyy3ADm3h3hA1Q8qEgp7kkHRwMysnpN+iz3bA47AAPoj8wD/xC4iNKZCCb4xjwoOMHTrLDzKwW1
 yT9gz3Ulnlnh465vLNhAXmpfgNhrDC2B1W0BLA69jcUY/wWQZpRARsYHjqBAv7hNNuciqSjpaRj
 nAGjnjkua5Y/oIPupUek9jlHF1GrKTtP9lKrtBYC1wW8DWZB3BFdpofhkoKQ1mqwaup5rfGG4pR
 VlgC/w0eVfslozwyLPNfGbCfCH3BJHzvzcZsiAcUWIHJUxnU0sBgfZ5cEX3NFa26dXkRNYcmRmO
 JXZkJ6EoRI4XWYw==
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

